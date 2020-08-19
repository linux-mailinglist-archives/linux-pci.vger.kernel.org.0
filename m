Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F06249D32
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgHSMCo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 08:02:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:49555 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbgHSL7S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:18 -0400
IronPort-SDR: KbSCkfzyQ1/fg0ETZf9hyu64kPg4Y8yrSikqgjJLB2SA7fd0B4TkH/mDFFPfRRToCvToazvZ6v
 BjgrAFVuAbTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="239922670"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="239922670"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:14 -0700
IronPort-SDR: avVy1w0z+mAauYiDQZDZCgLFig7bmX2LHOQKkBXqLmOhv7WEfmlRbsaubXDb8ArWfAn8nyBMbY
 Du0Qzkdhf7tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="329310758"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2020 04:59:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C543B5FF; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
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
Subject: [PATCH 12/19] thunderbolt: Set port configured for both ends of the link
Date:   Wed, 19 Aug 2020 14:58:58 +0300
Message-Id: <20200819115905.59834-13-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both ends of the link needs to have this set. Otherwise the link is not
re-established properly after sleep. Now since it is possible to have
mixed USB4 and Thunderbolt 1, 2 and 3 devices we need to split the link
configuration functionality to happen per port so we can pick the
correct implementation.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/lc.c     | 48 +++++--------------
 drivers/thunderbolt/switch.c | 33 ++++++++++---
 drivers/thunderbolt/tb.h     |  8 ++--
 drivers/thunderbolt/usb4.c   | 92 +++++++++++++++++-------------------
 4 files changed, 87 insertions(+), 94 deletions(-)

diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
index b2f62ba0421d..5c209a570360 100644
--- a/drivers/thunderbolt/lc.c
+++ b/drivers/thunderbolt/lc.c
@@ -45,7 +45,7 @@ static int find_port_lc_cap(struct tb_port *port)
 	return sw->cap_lc + start + phys * size;
 }
 
-static int tb_lc_configure_lane(struct tb_port *port, bool configure)
+static int tb_lc_set_port_configured(struct tb_port *port, bool configured)
 {
 	bool upstream = tb_is_upstream_port(port);
 	struct tb_switch *sw = port->sw;
@@ -69,7 +69,7 @@ static int tb_lc_configure_lane(struct tb_port *port, bool configure)
 	else
 		lane = TB_LC_SX_CTRL_L2C;
 
-	if (configure) {
+	if (configured) {
 		ctrl |= lane;
 		if (upstream)
 			ctrl |= TB_LC_SX_CTRL_UPSTREAM;
@@ -83,49 +83,25 @@ static int tb_lc_configure_lane(struct tb_port *port, bool configure)
 }
 
 /**
- * tb_lc_configure_link() - Let LC know about configured link
- * @sw: Switch that is being added
+ * tb_lc_configure_port() - Let LC know about configured port
+ * @port: Port that is set as configured
  *
- * Informs LC of both parent switch and @sw that there is established
- * link between the two.
+ * Sets the port configured for power management purposes.
  */
-int tb_lc_configure_link(struct tb_switch *sw)
+int tb_lc_configure_port(struct tb_port *port)
 {
-	struct tb_port *up, *down;
-	int ret;
-
-	up = tb_upstream_port(sw);
-	down = tb_port_at(tb_route(sw), tb_to_switch(sw->dev.parent));
-
-	/* Configure parent link toward this switch */
-	ret = tb_lc_configure_lane(down, true);
-	if (ret)
-		return ret;
-
-	/* Configure upstream link from this switch to the parent */
-	ret = tb_lc_configure_lane(up, true);
-	if (ret)
-		tb_lc_configure_lane(down, false);
-
-	return ret;
+	return tb_lc_set_port_configured(port, true);
 }
 
 /**
- * tb_lc_unconfigure_link() - Let LC know about unconfigured link
- * @sw: Switch to unconfigure
+ * tb_lc_unconfigure_port() - Let LC know about unconfigured port
+ * @port: Port that is set as configured
  *
- * Informs LC of both parent switch and @sw that the link between the
- * two does not exist anymore.
+ * Sets the port unconfigured for power management purposes.
  */
-void tb_lc_unconfigure_link(struct tb_switch *sw)
+void tb_lc_unconfigure_port(struct tb_port *port)
 {
-	struct tb_port *up, *down;
-
-	up = tb_upstream_port(sw);
-	down = tb_port_at(tb_route(sw), tb_to_switch(sw->dev.parent));
-
-	tb_lc_configure_lane(up, false);
-	tb_lc_configure_lane(down, false);
+	tb_lc_set_port_configured(port, false);
 }
 
 /**
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index ecc47ea81bb6..1c45f8baf487 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2321,12 +2321,24 @@ void tb_switch_lane_bonding_disable(struct tb_switch *sw)
  */
 int tb_switch_configure_link(struct tb_switch *sw)
 {
+	struct tb_port *up, *down;
+	int ret;
+
 	if (!tb_route(sw) || tb_switch_is_icm(sw))
 		return 0;
 
-	if (tb_switch_is_usb4(sw))
-		return usb4_switch_configure_link(sw);
-	return tb_lc_configure_link(sw);
+	up = tb_upstream_port(sw);
+	if (tb_switch_is_usb4(up->sw))
+		ret = usb4_port_configure(up);
+	else
+		ret = tb_lc_configure_port(up);
+	if (ret)
+		return ret;
+
+	down = up->remote;
+	if (tb_switch_is_usb4(down->sw))
+		return usb4_port_configure(down);
+	return tb_lc_configure_port(down);
 }
 
 /**
@@ -2338,15 +2350,24 @@ int tb_switch_configure_link(struct tb_switch *sw)
  */
 void tb_switch_unconfigure_link(struct tb_switch *sw)
 {
+	struct tb_port *up, *down;
+
 	if (sw->is_unplugged)
 		return;
 	if (!tb_route(sw) || tb_switch_is_icm(sw))
 		return;
 
-	if (tb_switch_is_usb4(sw))
-		usb4_switch_unconfigure_link(sw);
+	up = tb_upstream_port(sw);
+	if (tb_switch_is_usb4(up->sw))
+		usb4_port_unconfigure(up);
+	else
+		tb_lc_unconfigure_port(up);
+
+	down = up->remote;
+	if (tb_switch_is_usb4(down->sw))
+		usb4_port_unconfigure(down);
 	else
-		tb_lc_unconfigure_link(sw);
+		tb_lc_unconfigure_port(down);
 }
 
 /**
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index dcdc886412f5..082ae9da4cbc 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -846,8 +846,8 @@ int tb_drom_read(struct tb_switch *sw);
 int tb_drom_read_uid_only(struct tb_switch *sw, u64 *uid);
 
 int tb_lc_read_uuid(struct tb_switch *sw, u32 *uuid);
-int tb_lc_configure_link(struct tb_switch *sw);
-void tb_lc_unconfigure_link(struct tb_switch *sw);
+int tb_lc_configure_port(struct tb_port *port);
+void tb_lc_unconfigure_port(struct tb_port *port);
 int tb_lc_set_sleep(struct tb_switch *sw);
 bool tb_lc_lane_bonding_possible(struct tb_switch *sw);
 bool tb_lc_dp_sink_query(struct tb_switch *sw, struct tb_port *in);
@@ -902,8 +902,6 @@ int usb4_switch_setup(struct tb_switch *sw);
 int usb4_switch_read_uid(struct tb_switch *sw, u64 *uid);
 int usb4_switch_drom_read(struct tb_switch *sw, unsigned int address, void *buf,
 			  size_t size);
-int usb4_switch_configure_link(struct tb_switch *sw);
-void usb4_switch_unconfigure_link(struct tb_switch *sw);
 bool usb4_switch_lane_bonding_possible(struct tb_switch *sw);
 int usb4_switch_set_sleep(struct tb_switch *sw);
 int usb4_switch_nvm_sector_size(struct tb_switch *sw);
@@ -921,6 +919,8 @@ struct tb_port *usb4_switch_map_usb3_down(struct tb_switch *sw,
 					  const struct tb_port *port);
 
 int usb4_port_unlock(struct tb_port *port);
+int usb4_port_configure(struct tb_port *port);
+void usb4_port_unconfigure(struct tb_port *port);
 int usb4_port_enumerate_retimers(struct tb_port *port);
 
 int usb4_port_retimer_read(struct tb_port *port, u8 index, u8 reg, void *buf,
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index dd601a6db23c..b2677427789f 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -338,54 +338,6 @@ int usb4_switch_drom_read(struct tb_switch *sw, unsigned int address, void *buf,
 				 usb4_switch_drom_read_block, sw);
 }
 
-static int usb4_set_port_configured(struct tb_port *port, bool configured)
-{
-	int ret;
-	u32 val;
-
-	ret = tb_port_read(port, &val, TB_CFG_PORT,
-			   port->cap_usb4 + PORT_CS_19, 1);
-	if (ret)
-		return ret;
-
-	if (configured)
-		val |= PORT_CS_19_PC;
-	else
-		val &= ~PORT_CS_19_PC;
-
-	return tb_port_write(port, &val, TB_CFG_PORT,
-			     port->cap_usb4 + PORT_CS_19, 1);
-}
-
-/**
- * usb4_switch_configure_link() - Set upstream USB4 link configured
- * @sw: USB4 router
- *
- * Sets the upstream USB4 link to be configured for power management
- * purposes.
- */
-int usb4_switch_configure_link(struct tb_switch *sw)
-{
-	struct tb_port *up;
-
-	up = tb_upstream_port(sw);
-	return usb4_set_port_configured(up, true);
-}
-
-/**
- * usb4_switch_unconfigure_link() - Un-set upstream USB4 link configuration
- * @sw: USB4 router
- *
- * Reverse of usb4_switch_configure_link().
- */
-void usb4_switch_unconfigure_link(struct tb_switch *sw)
-{
-	struct tb_port *up;
-
-	up = tb_upstream_port(sw);
-	usb4_set_port_configured(up, false);
-}
-
 /**
  * usb4_switch_lane_bonding_possible() - Are conditions met for lane bonding
  * @sw: USB4 router
@@ -789,6 +741,50 @@ int usb4_port_unlock(struct tb_port *port)
 	return tb_port_write(port, &val, TB_CFG_PORT, ADP_CS_4, 1);
 }
 
+static int usb4_port_set_configured(struct tb_port *port, bool configured)
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
+		val |= PORT_CS_19_PC;
+	else
+		val &= ~PORT_CS_19_PC;
+
+	return tb_port_write(port, &val, TB_CFG_PORT,
+			     port->cap_usb4 + PORT_CS_19, 1);
+}
+
+/**
+ * usb4_port_configure() - Set USB4 port configured
+ * @port: USB4 router
+ *
+ * Sets the USB4 link to be configured for power management purposes.
+ */
+int usb4_port_configure(struct tb_port *port)
+{
+	return usb4_port_set_configured(port, true);
+}
+
+/**
+ * usb4_port_unconfigure() - Set USB4 port unconfigured
+ * @port: USB4 router
+ *
+ * Sets the USB4 link to be unconfigured for power management purposes.
+ */
+void usb4_port_unconfigure(struct tb_port *port)
+{
+	usb4_port_set_configured(port, false);
+}
+
 static int usb4_port_wait_for_bit(struct tb_port *port, u32 offset, u32 bit,
 				  u32 value, int timeout_msec)
 {
-- 
2.28.0

