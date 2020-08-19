Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B59249D07
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 13:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgHSL73 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 07:59:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:34066 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgHSL7R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:17 -0400
IronPort-SDR: nPUFkw7LkQSai0008UOMKf/u0xR75ptVtUYjmqHIy31wwoGQVpKMPxzr7DtYzPdGyACHJTX+70
 tpLdGOQ/3Emg==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="134610557"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="134610557"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:16 -0700
IronPort-SDR: 88rLKxKPvltUAIjZMepMWjQj1Zn9zhGaGdv708Itao6hFHG5ypSgQ+dBruBfeHbg/7YAdrafFR
 jLY4mFyCizbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="472211902"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 19 Aug 2020 04:59:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BC68951B; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
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
Subject: [PATCH 11/19] thunderbolt: Configure link after lane bonding is enabled
Date:   Wed, 19 Aug 2020 14:58:57 +0300
Message-Id: <20200819115905.59834-12-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During testing it was noticed that the link is not properly restored
after the domain exits sleep if the link configured bits are set before
lane bonding is enabled. The USB4 spec does not say in which order these
need to be set but setting link configured afterwards makes the link
restoration work so we do that instead.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/lc.c     |  6 ----
 drivers/thunderbolt/switch.c | 55 +++++++++++++++++++++++++++---------
 drivers/thunderbolt/tb.c     |  5 ++++
 drivers/thunderbolt/tb.h     |  2 ++
 drivers/thunderbolt/usb4.c   |  6 ----
 5 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
index 19be627d090f..b2f62ba0421d 100644
--- a/drivers/thunderbolt/lc.c
+++ b/drivers/thunderbolt/lc.c
@@ -94,9 +94,6 @@ int tb_lc_configure_link(struct tb_switch *sw)
 	struct tb_port *up, *down;
 	int ret;
 
-	if (!tb_route(sw) || tb_switch_is_icm(sw))
-		return 0;
-
 	up = tb_upstream_port(sw);
 	down = tb_port_at(tb_route(sw), tb_to_switch(sw->dev.parent));
 
@@ -124,9 +121,6 @@ void tb_lc_unconfigure_link(struct tb_switch *sw)
 {
 	struct tb_port *up, *down;
 
-	if (sw->is_unplugged || !tb_route(sw) || tb_switch_is_icm(sw))
-		return;
-
 	up = tb_upstream_port(sw);
 	down = tb_port_at(tb_route(sw), tb_to_switch(sw->dev.parent));
 
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index e1ba8215144b..ecc47ea81bb6 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2012,10 +2012,6 @@ int tb_switch_configure(struct tb_switch *sw)
 			return ret;
 
 		ret = usb4_switch_setup(sw);
-		if (ret)
-			return ret;
-
-		ret = usb4_switch_configure_link(sw);
 	} else {
 		if (sw->config.vendor_id != PCI_VENDOR_ID_INTEL)
 			tb_sw_warn(sw, "unknown switch vendor id %#x\n",
@@ -2029,10 +2025,6 @@ int tb_switch_configure(struct tb_switch *sw)
 		/* Enumerate the switch */
 		ret = tb_sw_write(sw, (u32 *)&sw->config + 1, TB_CFG_SWITCH,
 				  ROUTER_CS_1, 3);
-		if (ret)
-			return ret;
-
-		ret = tb_lc_configure_link(sw);
 	}
 	if (ret)
 		return ret;
@@ -2315,6 +2307,48 @@ void tb_switch_lane_bonding_disable(struct tb_switch *sw)
 	tb_sw_dbg(sw, "lane bonding disabled\n");
 }
 
+/**
+ * tb_switch_configure_link() - Set link configured
+ * @sw: Switch whose link is configured
+ *
+ * Sets the link upstream from @sw configured (from both ends) so that
+ * it will not be disconnected when the domain exits sleep. Can be
+ * called for any switch.
+ *
+ * It is recommended that this is called after lane bonding is enabled.
+ *
+ * Returns %0 on success and negative errno in case of error.
+ */
+int tb_switch_configure_link(struct tb_switch *sw)
+{
+	if (!tb_route(sw) || tb_switch_is_icm(sw))
+		return 0;
+
+	if (tb_switch_is_usb4(sw))
+		return usb4_switch_configure_link(sw);
+	return tb_lc_configure_link(sw);
+}
+
+/**
+ * tb_switch_unconfigure_link() - Unconfigure link
+ * @sw: Switch whose link is unconfigured
+ *
+ * Sets the link unconfigured so the @sw will be disconnected if the
+ * domain exists sleep.
+ */
+void tb_switch_unconfigure_link(struct tb_switch *sw)
+{
+	if (sw->is_unplugged)
+		return;
+	if (!tb_route(sw) || tb_switch_is_icm(sw))
+		return;
+
+	if (tb_switch_is_usb4(sw))
+		usb4_switch_unconfigure_link(sw);
+	else
+		tb_lc_unconfigure_link(sw);
+}
+
 /**
  * tb_switch_add() - Add a switch to the domain
  * @sw: Switch to add
@@ -2449,11 +2483,6 @@ void tb_switch_remove(struct tb_switch *sw)
 	if (!sw->is_unplugged)
 		tb_plug_events_active(sw, false);
 
-	if (tb_switch_is_usb4(sw))
-		usb4_switch_unconfigure_link(sw);
-	else
-		tb_lc_unconfigure_link(sw);
-
 	tb_switch_nvm_remove(sw);
 
 	if (tb_route(sw))
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c35d5fec48f4..54a4daf0b1b4 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -593,6 +593,8 @@ static void tb_scan_port(struct tb_port *port)
 
 	/* Enable lane bonding if supported */
 	tb_switch_lane_bonding_enable(sw);
+	/* Set the link configured */
+	tb_switch_configure_link(sw);
 
 	if (tb_enable_tmu(sw))
 		tb_sw_warn(sw, "failed to enable TMU\n");
@@ -681,6 +683,7 @@ static void tb_free_unplugged_children(struct tb_switch *sw)
 		if (port->remote->sw->is_unplugged) {
 			tb_retimer_remove_all(port);
 			tb_remove_dp_resources(port->remote->sw);
+			tb_switch_unconfigure_link(port->remote->sw);
 			tb_switch_lane_bonding_disable(port->remote->sw);
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
@@ -1076,6 +1079,7 @@ static void tb_handle_hotplug(struct work_struct *work)
 			tb_free_invalid_tunnels(tb);
 			tb_remove_dp_resources(port->remote->sw);
 			tb_switch_tmu_disable(port->remote->sw);
+			tb_switch_unconfigure_link(port->remote->sw);
 			tb_switch_lane_bonding_disable(port->remote->sw);
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
@@ -1269,6 +1273,7 @@ static void tb_restore_children(struct tb_switch *sw)
 			continue;
 
 		tb_switch_lane_bonding_enable(port->remote->sw);
+		tb_switch_configure_link(port->remote->sw);
 
 		tb_restore_children(port->remote->sw);
 	}
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 69e78bbed53a..dcdc886412f5 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -767,6 +767,8 @@ static inline bool tb_switch_is_icm(const struct tb_switch *sw)
 
 int tb_switch_lane_bonding_enable(struct tb_switch *sw);
 void tb_switch_lane_bonding_disable(struct tb_switch *sw);
+int tb_switch_configure_link(struct tb_switch *sw);
+void tb_switch_unconfigure_link(struct tb_switch *sw);
 
 bool tb_switch_query_dp_resource(struct tb_switch *sw, struct tb_port *in);
 int tb_switch_alloc_dp_resource(struct tb_switch *sw, struct tb_port *in);
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 2b8355e6b65f..dd601a6db23c 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -368,9 +368,6 @@ int usb4_switch_configure_link(struct tb_switch *sw)
 {
 	struct tb_port *up;
 
-	if (!tb_route(sw))
-		return 0;
-
 	up = tb_upstream_port(sw);
 	return usb4_set_port_configured(up, true);
 }
@@ -385,9 +382,6 @@ void usb4_switch_unconfigure_link(struct tb_switch *sw)
 {
 	struct tb_port *up;
 
-	if (sw->is_unplugged || !tb_route(sw))
-		return;
-
 	up = tb_upstream_port(sw);
 	usb4_set_port_configured(up, false);
 }
-- 
2.28.0

