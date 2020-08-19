Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969C1249D18
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgHSMAx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 08:00:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:49555 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbgHSL7x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:53 -0400
IronPort-SDR: W+DdLoC+9vlXB9bb2N0is9Ry0Ehtg8ON8X4sIhF3JJTqwZlExEjewqMzH9BsHN8J5WBdWcZ3wN
 HneTjVCwFSCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="239922673"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="239922673"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:14 -0700
IronPort-SDR: WUm0ykx4GA/OhJSVT4Cx2Yc7W5T3nzYLqgOMINs2bwhSiqON0DmKvb7elpSsAkEucGGWcVn6kx
 0g6hMMGp2kbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="278309127"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 Aug 2020 04:59:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CE3AF656; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Dana Alkattan <dana.alkattan@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 13/19] thunderbolt: Configure port for XDomain
Date:   Wed, 19 Aug 2020 14:58:59 +0300
Message-Id: <20200819115905.59834-14-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the port is connected to another host it should be marked as such
in the USB4 port capability. This information is used by the router
during sleep and wakeup.

Also do the same for legacy switches via link controller vendor specific
registers.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/lc.c      | 54 +++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/tb.c      | 32 ++++++++++++++++++---
 drivers/thunderbolt/tb.h      |  4 +++
 drivers/thunderbolt/tb_regs.h |  3 ++
 drivers/thunderbolt/usb4.c    | 45 +++++++++++++++++++++++++++++
 5 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
index 5c209a570360..44647fa1ec1c 100644
--- a/drivers/thunderbolt/lc.c
+++ b/drivers/thunderbolt/lc.c
@@ -104,6 +104,60 @@ void tb_lc_unconfigure_port(struct tb_port *port)
 	tb_lc_set_port_configured(port, false);
 }
 
+static int tb_lc_set_xdomain_configured(struct tb_port *port, bool configure)
+{
+	struct tb_switch *sw = port->sw;
+	u32 ctrl, lane;
+	int cap, ret;
+
+	if (sw->generation < 2)
+		return 0;
+
+	cap = find_port_lc_cap(port);
+	if (cap < 0)
+		return cap;
+
+	ret = tb_sw_read(sw, &ctrl, TB_CFG_SWITCH, cap + TB_LC_SX_CTRL, 1);
+	if (ret)
+		return ret;
+
+	/* Resolve correct lane */
+	if (port->port % 2)
+		lane = TB_LC_SX_CTRL_L1D;
+	else
+		lane = TB_LC_SX_CTRL_L2D;
+
+	if (configure)
+		ctrl |= lane;
+	else
+		ctrl &= ~lane;
+
+	return tb_sw_write(sw, &ctrl, TB_CFG_SWITCH, cap + TB_LC_SX_CTRL, 1);
+}
+
+/**
+ * tb_lc_configure_xdomain() - Inform LC that the link is XDomain
+ * @port: Switch downstream port connected to another host
+ *
+ * Sets the lane configured for XDomain accordingly so that the LC knows
+ * about this. Returns %0 in success and negative errno in failure.
+ */
+int tb_lc_configure_xdomain(struct tb_port *port)
+{
+	return tb_lc_set_xdomain_configured(port, true);
+}
+
+/**
+ * tb_lc_unconfigure_xdomain() - Unconfigure XDomain from port
+ * @port: Switch downstream port that was connected to another host
+ *
+ * Unsets the lane XDomain configuration.
+ */
+void tb_lc_unconfigure_xdomain(struct tb_port *port)
+{
+	tb_lc_set_xdomain_configured(port, false);
+}
+
 /**
  * tb_lc_set_sleep() - Inform LC that the switch is going to sleep
  * @sw: Switch to set sleep
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 54a4daf0b1b4..602e00e0b45e 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -140,6 +140,21 @@ static void tb_discover_tunnels(struct tb_switch *sw)
 	}
 }
 
+static int tb_port_configure_xdomain(struct tb_port *port)
+{
+	if (tb_switch_is_usb4(port->sw))
+		return usb4_port_configure_xdomain(port);
+	return tb_lc_configure_xdomain(port);
+}
+
+static void tb_port_unconfigure_xdomain(struct tb_port *port)
+{
+	if (tb_switch_is_usb4(port->sw))
+		usb4_port_unconfigure_xdomain(port);
+	else
+		tb_lc_unconfigure_xdomain(port);
+}
+
 static void tb_scan_xdomain(struct tb_port *port)
 {
 	struct tb_switch *sw = port->sw;
@@ -158,6 +173,7 @@ static void tb_scan_xdomain(struct tb_port *port)
 			      NULL);
 	if (xd) {
 		tb_port_at(route, sw)->xdomain = xd;
+		tb_port_configure_xdomain(port);
 		tb_xdomain_add(xd);
 	}
 }
@@ -566,6 +582,7 @@ static void tb_scan_port(struct tb_port *port)
 	 */
 	if (port->xdomain) {
 		tb_xdomain_remove(port->xdomain);
+		tb_port_unconfigure_xdomain(port);
 		port->xdomain = NULL;
 	}
 
@@ -1047,6 +1064,7 @@ static void tb_handle_hotplug(struct work_struct *work)
 	struct tb_cm *tcm = tb_priv(tb);
 	struct tb_switch *sw;
 	struct tb_port *port;
+
 	mutex_lock(&tb->lock);
 	if (!tcm->hotplug_active)
 		goto out; /* during init, suspend or shutdown */
@@ -1103,6 +1121,7 @@ static void tb_handle_hotplug(struct work_struct *work)
 			port->xdomain = NULL;
 			__tb_disconnect_xdomain_paths(tb, xd);
 			tb_xdomain_put(xd);
+			tb_port_unconfigure_xdomain(port);
 		} else if (tb_port_is_dpout(port) || tb_port_is_dpin(port)) {
 			tb_dp_resource_unavailable(tb, port);
 		} else {
@@ -1269,13 +1288,17 @@ static void tb_restore_children(struct tb_switch *sw)
 		tb_sw_warn(sw, "failed to restore TMU configuration\n");
 
 	tb_switch_for_each_port(sw, port) {
-		if (!tb_port_has_remote(port))
+		if (!tb_port_has_remote(port) && !port->xdomain)
 			continue;
 
-		tb_switch_lane_bonding_enable(port->remote->sw);
-		tb_switch_configure_link(port->remote->sw);
+		if (port->remote) {
+			tb_switch_lane_bonding_enable(port->remote->sw);
+			tb_switch_configure_link(port->remote->sw);
 
-		tb_restore_children(port->remote->sw);
+			tb_restore_children(port->remote->sw);
+		} else if (port->xdomain) {
+			tb_port_configure_xdomain(port);
+		}
 	}
 }
 
@@ -1321,6 +1344,7 @@ static int tb_free_unplugged_xdomains(struct tb_switch *sw)
 		if (port->xdomain && port->xdomain->is_unplugged) {
 			tb_retimer_remove_all(port);
 			tb_xdomain_remove(port->xdomain);
+			tb_port_unconfigure_xdomain(port);
 			port->xdomain = NULL;
 			ret++;
 		} else if (port->remote) {
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 082ae9da4cbc..dbe332c3e95e 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -848,6 +848,8 @@ int tb_drom_read_uid_only(struct tb_switch *sw, u64 *uid);
 int tb_lc_read_uuid(struct tb_switch *sw, u32 *uuid);
 int tb_lc_configure_port(struct tb_port *port);
 void tb_lc_unconfigure_port(struct tb_port *port);
+int tb_lc_configure_xdomain(struct tb_port *port);
+void tb_lc_unconfigure_xdomain(struct tb_port *port);
 int tb_lc_set_sleep(struct tb_switch *sw);
 bool tb_lc_lane_bonding_possible(struct tb_switch *sw);
 bool tb_lc_dp_sink_query(struct tb_switch *sw, struct tb_port *in);
@@ -921,6 +923,8 @@ struct tb_port *usb4_switch_map_usb3_down(struct tb_switch *sw,
 int usb4_port_unlock(struct tb_port *port);
 int usb4_port_configure(struct tb_port *port);
 void usb4_port_unconfigure(struct tb_port *port);
+int usb4_port_configure_xdomain(struct tb_port *port);
+void usb4_port_unconfigure_xdomain(struct tb_port *port);
 int usb4_port_enumerate_retimers(struct tb_port *port);
 
 int usb4_port_retimer_read(struct tb_port *port, u8 index, u8 reg, void *buf,
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index fd4fc144d17f..a553be24f1c0 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -303,6 +303,7 @@ struct tb_regs_port_header {
 #define PORT_CS_18_TCM				BIT(9)
 #define PORT_CS_19				0x13
 #define PORT_CS_19_PC				BIT(3)
+#define PORT_CS_19_PID				BIT(4)
 
 /* Display Port adapter registers */
 #define ADP_DP_CS_0				0x00
@@ -417,7 +418,9 @@ struct tb_regs_hop {
 
 #define TB_LC_SX_CTRL			0x96
 #define TB_LC_SX_CTRL_L1C		BIT(16)
+#define TB_LC_SX_CTRL_L1D		BIT(17)
 #define TB_LC_SX_CTRL_L2C		BIT(20)
+#define TB_LC_SX_CTRL_L2D		BIT(21)
 #define TB_LC_SX_CTRL_UPSTREAM		BIT(30)
 #define TB_LC_SX_CTRL_SLP		BIT(31)
 
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index b2677427789f..59b8b51d1fa4 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -785,6 +785,51 @@ void usb4_port_unconfigure(struct tb_port *port)
 	usb4_port_set_configured(port, false);
 }
 
+static int usb4_set_xdomain_configured(struct tb_port *port, bool configured)
+{
+	int ret;
+	u32 val;
+
+	if (!port->cap_usb4)
+		return -EINVAL;
+
+	ret = tb_port_read(port, &val, TB_CFG_PORT,
+			   port->cap_usb4 + PORT_CS_19, 1);
+	if (ret)
+		return ret;
+
+	if (configured)
+		val |= PORT_CS_19_PID;
+	else
+		val &= ~PORT_CS_19_PID;
+
+	return tb_port_write(port, &val, TB_CFG_PORT,
+			     port->cap_usb4 + PORT_CS_19, 1);
+}
+
+/**
+ * usb4_port_configure_xdomain() - Configure port for XDomain
+ * @port: USB4 port connected to another host
+ *
+ * Marks the USB4 port as being connected to another host. Returns %0 in
+ * success and negative errno in failure.
+ */
+int usb4_port_configure_xdomain(struct tb_port *port)
+{
+	return usb4_set_xdomain_configured(port, true);
+}
+
+/**
+ * usb4_port_unconfigure_xdomain() - Unconfigure port for XDomain
+ * @port: USB4 port that was connected to another host
+ *
+ * Clears USB4 port from being marked as XDomain.
+ */
+void usb4_port_unconfigure_xdomain(struct tb_port *port)
+{
+	usb4_set_xdomain_configured(port, false);
+}
+
 static int usb4_port_wait_for_bit(struct tb_port *port, u32 offset, u32 bit,
 				  u32 value, int timeout_msec)
 {
-- 
2.28.0

