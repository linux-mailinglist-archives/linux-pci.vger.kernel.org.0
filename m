Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38216249D34
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgHSMCq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 08:02:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:1231 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbgHSL7S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:18 -0400
IronPort-SDR: 955j5xxPleaA/SpgKVSnTiaDJV6bO5wyFX8DMphM4qlWlcEFK/gtpF7kjTGn1rBpwxO0cJ8yTr
 2Oo3eYMTcvxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="142904887"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="142904887"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:18 -0700
IronPort-SDR: 0GjM+kqIFOcDe/ndho/BZ1LQSxXoS5IIuNRg6nF6w3KYz56ZVoDDWZQOgFFx3yDOjUGD4pWegi
 VEMNlHf7kSaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="497724282"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2020 04:59:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E0B656E8; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
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
Subject: [PATCH 15/19] thunderbolt: Enable wakes from system suspend
Date:   Wed, 19 Aug 2020 14:59:01 +0300
Message-Id: <20200819115905.59834-16-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order for the router and the whole domain to wake up from system
suspend states we need to enable wakes for the connected routers. For
device routers we enable wakes from PCIe and USB 3.x. This allows
devices such as keyboards connected to USB 3.x hub that is tunneled to
wake the system up as expected. For all routers we enabled wake on USB4
for each connected ports. This is used to propagate the wake from router
to another.

Do the same for legacy routers through link controller vendor specific
registers as documented in USB4 spec chapter 13.

While there correct kernel-doc of usb4_switch_set_sleep() -- it does not
enable wakes instead there is a separate function (usb4_switch_set_wake())
that does.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/domain.c  |   2 +
 drivers/thunderbolt/lc.c      |  67 ++++++++++++++++++++
 drivers/thunderbolt/nhi.c     |   2 +
 drivers/thunderbolt/switch.c  |  30 ++++++++-
 drivers/thunderbolt/tb.h      |   9 +++
 drivers/thunderbolt/tb_regs.h |  12 ++++
 drivers/thunderbolt/usb4.c    | 112 +++++++++++++++++++++++++++++++++-
 7 files changed, 231 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index bba4cbfa9759..7ca6a2b34ddc 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -455,6 +455,8 @@ int tb_domain_add(struct tb *tb)
 	/* This starts event processing */
 	mutex_unlock(&tb->lock);
 
+	device_init_wakeup(&tb->dev, true);
+
 	pm_runtime_no_callbacks(&tb->dev);
 	pm_runtime_set_active(&tb->dev);
 	pm_runtime_enable(&tb->dev);
diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
index 44647fa1ec1c..41e6c738f6c8 100644
--- a/drivers/thunderbolt/lc.c
+++ b/drivers/thunderbolt/lc.c
@@ -158,6 +158,73 @@ void tb_lc_unconfigure_xdomain(struct tb_port *port)
 	tb_lc_set_xdomain_configured(port, false);
 }
 
+static int tb_lc_set_wake_one(struct tb_switch *sw, unsigned int offset,
+			      unsigned int flags)
+{
+	u32 ctrl;
+	int ret;
+
+	/*
+	 * Enable wake on PCIe and USB4 (wake coming from another
+	 * router).
+	 */
+	ret = tb_sw_read(sw, &ctrl, TB_CFG_SWITCH,
+			 offset + TB_LC_SX_CTRL, 1);
+	if (ret)
+		return ret;
+
+	ctrl &= ~(TB_LC_SX_CTRL_WOC | TB_LC_SX_CTRL_WOD | TB_LC_SX_CTRL_WOP |
+		  TB_LC_SX_CTRL_WOU4);
+
+	if (flags & TB_WAKE_ON_CONNECT)
+		ctrl |= TB_LC_SX_CTRL_WOC | TB_LC_SX_CTRL_WOD;
+	if (flags & TB_WAKE_ON_USB4)
+		ctrl |= TB_LC_SX_CTRL_WOU4;
+	if (flags & TB_WAKE_ON_PCIE)
+		ctrl |= TB_LC_SX_CTRL_WOP;
+
+	return tb_sw_write(sw, &ctrl, TB_CFG_SWITCH, offset + TB_LC_SX_CTRL, 1);
+}
+
+/**
+ * tb_lc_set_wake() - Enable/disable wake
+ * @sw: Switch whose wakes to configure
+ * @flags: Wakeup flags (%0 to disable)
+ *
+ * For each LC sets wake bits accordingly.
+ */
+int tb_lc_set_wake(struct tb_switch *sw, unsigned int flags)
+{
+	int start, size, nlc, ret, i;
+	u32 desc;
+
+	if (sw->generation < 2)
+		return 0;
+
+	if (!tb_route(sw))
+		return 0;
+
+	ret = read_lc_desc(sw, &desc);
+	if (ret)
+		return ret;
+
+	/* Figure out number of link controllers */
+	nlc = desc & TB_LC_DESC_NLC_MASK;
+	start = (desc & TB_LC_DESC_SIZE_MASK) >> TB_LC_DESC_SIZE_SHIFT;
+	size = (desc & TB_LC_DESC_PORT_SIZE_MASK) >> TB_LC_DESC_PORT_SIZE_SHIFT;
+
+	/* For each link controller set sleep bit */
+	for (i = 0; i < nlc; i++) {
+		unsigned int offset = sw->cap_lc + start + i * size;
+
+		ret = tb_lc_set_wake_one(sw, offset, flags);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * tb_lc_set_sleep() - Inform LC that the switch is going to sleep
  * @sw: Switch to set sleep
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 5f7489fa1327..24d2b7eff59b 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1157,6 +1157,8 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 	pci_set_drvdata(pdev, tb);
 
+	device_wakeup_enable(&pdev->dev);
+
 	pm_runtime_allow(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, TB_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(&pdev->dev);
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index a8df25dae57b..a2ebf51ac389 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2036,7 +2036,7 @@ int tb_switch_configure(struct tb_switch *sw)
 	route = tb_route(sw);
 
 	tb_dbg(tb, "%s Switch at %#llx (depth: %d, up port: %d)\n",
-	       sw->config.enabled ? "restoring " : "initializing", route,
+	       sw->config.enabled ? "restoring" : "initializing", route,
 	       tb_route_length(route), sw->config.upstream_port_number);
 
 	sw->config.enabled = 1;
@@ -2502,6 +2502,13 @@ int tb_switch_add(struct tb_switch *sw)
 		return ret;
 	}
 
+	/*
+	 * Thunderbolt routers do not generate wakeups themselves but
+	 * they forward wakeups from tunneled protocols, so enable it
+	 * here.
+	 */
+	device_init_wakeup(&sw->dev, true);
+
 	pm_runtime_set_active(&sw->dev);
 	if (sw->rpm) {
 		pm_runtime_set_autosuspend_delay(&sw->dev, TB_AUTOSUSPEND_DELAY);
@@ -2579,6 +2586,18 @@ void tb_sw_set_unplugged(struct tb_switch *sw)
 	}
 }
 
+static int tb_switch_set_wake(struct tb_switch *sw, unsigned int flags)
+{
+	if (flags)
+		tb_sw_dbg(sw, "enabling wakeup: %#x\n", flags);
+	else
+		tb_sw_dbg(sw, "disabling wakeup\n");
+
+	if (tb_switch_is_usb4(sw))
+		return usb4_switch_set_wake(sw, flags);
+	return tb_lc_set_wake(sw, flags);
+}
+
 int tb_switch_resume(struct tb_switch *sw)
 {
 	struct tb_port *port;
@@ -2624,6 +2643,9 @@ int tb_switch_resume(struct tb_switch *sw)
 	if (err)
 		return err;
 
+	/* Disable wakes */
+	tb_switch_set_wake(sw, 0);
+
 	err = tb_switch_tmu_init(sw);
 	if (err)
 		return err;
@@ -2659,6 +2681,7 @@ int tb_switch_resume(struct tb_switch *sw)
 
 void tb_switch_suspend(struct tb_switch *sw)
 {
+	unsigned int flags = 0;
 	struct tb_port *port;
 	int err;
 
@@ -2671,6 +2694,11 @@ void tb_switch_suspend(struct tb_switch *sw)
 			tb_switch_suspend(port->remote->sw);
 	}
 
+	if (device_may_wakeup(&sw->dev))
+		flags = TB_WAKE_ON_USB4 | TB_WAKE_ON_USB3 | TB_WAKE_ON_PCIE;
+
+	tb_switch_set_wake(sw, flags);
+
 	if (tb_switch_is_usb4(sw))
 		usb4_switch_set_sleep(sw);
 	else
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index f58cd3fa98ea..847accd91bfa 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -333,6 +333,13 @@ struct tb_path {
  */
 #define TB_PATH_MAX_HOPS	(7 * 2)
 
+/* Possible wake types */
+#define TB_WAKE_ON_CONNECT	BIT(0)
+#define TB_WAKE_ON_DISCONNECT	BIT(1)
+#define TB_WAKE_ON_USB4		BIT(2)
+#define TB_WAKE_ON_USB3		BIT(3)
+#define TB_WAKE_ON_PCIE		BIT(4)
+
 /**
  * struct tb_cm_ops - Connection manager specific operations vector
  * @driver_ready: Called right after control channel is started. Used by
@@ -852,6 +859,7 @@ int tb_lc_configure_port(struct tb_port *port);
 void tb_lc_unconfigure_port(struct tb_port *port);
 int tb_lc_configure_xdomain(struct tb_port *port);
 void tb_lc_unconfigure_xdomain(struct tb_port *port);
+int tb_lc_set_wake(struct tb_switch *sw, unsigned int flags);
 int tb_lc_set_sleep(struct tb_switch *sw);
 bool tb_lc_lane_bonding_possible(struct tb_switch *sw);
 bool tb_lc_dp_sink_query(struct tb_switch *sw, struct tb_port *in);
@@ -907,6 +915,7 @@ int usb4_switch_read_uid(struct tb_switch *sw, u64 *uid);
 int usb4_switch_drom_read(struct tb_switch *sw, unsigned int address, void *buf,
 			  size_t size);
 bool usb4_switch_lane_bonding_possible(struct tb_switch *sw);
+int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags);
 int usb4_switch_set_sleep(struct tb_switch *sw);
 int usb4_switch_nvm_sector_size(struct tb_switch *sw);
 int usb4_switch_nvm_read(struct tb_switch *sw, unsigned int address, void *buf,
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index d1a40baa63d2..0431e415e3bc 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -178,6 +178,8 @@ struct tb_regs_switch_header {
 #define ROUTER_CS_4				0x04
 #define ROUTER_CS_5				0x05
 #define ROUTER_CS_5_SLP				BIT(0)
+#define ROUTER_CS_5_WOP				BIT(1)
+#define ROUTER_CS_5_WOU				BIT(2)
 #define ROUTER_CS_5_C3S				BIT(23)
 #define ROUTER_CS_5_PTO				BIT(24)
 #define ROUTER_CS_5_UTO				BIT(25)
@@ -186,6 +188,8 @@ struct tb_regs_switch_header {
 #define ROUTER_CS_6				0x06
 #define ROUTER_CS_6_SLPR			BIT(0)
 #define ROUTER_CS_6_TNS				BIT(1)
+#define ROUTER_CS_6_WOPS			BIT(2)
+#define ROUTER_CS_6_WOUS			BIT(3)
 #define ROUTER_CS_6_HCI				BIT(18)
 #define ROUTER_CS_6_CR				BIT(25)
 #define ROUTER_CS_7				0x07
@@ -302,9 +306,13 @@ struct tb_regs_port_header {
 #define PORT_CS_18				0x12
 #define PORT_CS_18_BE				BIT(8)
 #define PORT_CS_18_TCM				BIT(9)
+#define PORT_CS_18_WOU4S			BIT(18)
 #define PORT_CS_19				0x13
 #define PORT_CS_19_PC				BIT(3)
 #define PORT_CS_19_PID				BIT(4)
+#define PORT_CS_19_WOC				BIT(16)
+#define PORT_CS_19_WOD				BIT(17)
+#define PORT_CS_19_WOU4				BIT(18)
 
 /* Display Port adapter registers */
 #define ADP_DP_CS_0				0x00
@@ -418,6 +426,10 @@ struct tb_regs_hop {
 #define TB_LC_PORT_ATTR_BE		BIT(12)
 
 #define TB_LC_SX_CTRL			0x96
+#define TB_LC_SX_CTRL_WOC		BIT(1)
+#define TB_LC_SX_CTRL_WOD		BIT(2)
+#define TB_LC_SX_CTRL_WOU4		BIT(5)
+#define TB_LC_SX_CTRL_WOP		BIT(6)
 #define TB_LC_SX_CTRL_L1C		BIT(16)
 #define TB_LC_SX_CTRL_L1D		BIT(17)
 #define TB_LC_SX_CTRL_L2C		BIT(20)
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 59b8b51d1fa4..40f13579a3fe 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -196,6 +196,46 @@ static int usb4_switch_op(struct tb_switch *sw, u16 opcode, u8 *status)
 	return 0;
 }
 
+static void usb4_switch_check_wakes(struct tb_switch *sw)
+{
+	struct tb_port *port;
+	bool wakeup = false;
+	u32 val;
+
+	if (!device_may_wakeup(&sw->dev))
+		return;
+
+	if (tb_route(sw)) {
+		if (tb_sw_read(sw, &val, TB_CFG_SWITCH, ROUTER_CS_6, 1))
+			return;
+
+		tb_sw_dbg(sw, "PCIe wake: %s, USB3 wake: %s\n",
+			  (val & ROUTER_CS_6_WOPS) ? "yes" : "no",
+			  (val & ROUTER_CS_6_WOUS) ? "yes" : "no");
+
+		wakeup = val & (ROUTER_CS_6_WOPS | ROUTER_CS_6_WOUS);
+	}
+
+	/* Check for any connected downstream ports for USB4 wake */
+	tb_switch_for_each_port(sw, port) {
+		if (!tb_port_has_remote(port))
+			continue;
+
+		if (tb_port_read(port, &val, TB_CFG_PORT,
+				 port->cap_usb4 + PORT_CS_18, 1))
+			break;
+
+		tb_port_dbg(port, "USB4 wake: %s\n",
+			    (val & PORT_CS_18_WOU4S) ? "yes" : "no");
+
+		if (val & PORT_CS_18_WOU4S)
+			wakeup = true;
+	}
+
+	if (wakeup)
+		pm_wakeup_event(&sw->dev, 0);
+}
+
 static bool link_is_usb4(struct tb_port *port)
 {
 	u32 val;
@@ -229,6 +269,8 @@ int usb4_switch_setup(struct tb_switch *sw)
 	u32 val = 0;
 	int ret;
 
+	usb4_switch_check_wakes(sw);
+
 	if (!tb_route(sw))
 		return 0;
 
@@ -359,12 +401,78 @@ bool usb4_switch_lane_bonding_possible(struct tb_switch *sw)
 	return !!(val & PORT_CS_18_BE);
 }
 
+/**
+ * usb4_switch_set_wake() - Enabled/disable wake
+ * @sw: USB4 router
+ * @flags: Wakeup flags (%0 to disable)
+ *
+ * Enables/disables router to wake up from sleep.
+ */
+int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags)
+{
+	struct tb_port *port;
+	u64 route = tb_route(sw);
+	u32 val;
+	int ret;
+
+	/*
+	 * Enable wakes coming from all USB4 downstream ports (from
+	 * child routers). For device routers do this also for the
+	 * upstream USB4 port.
+	 */
+	tb_switch_for_each_port(sw, port) {
+		if (!route && tb_is_upstream_port(port))
+			continue;
+
+		ret = tb_port_read(port, &val, TB_CFG_PORT,
+				   port->cap_usb4 + PORT_CS_19, 1);
+		if (ret)
+			return ret;
+
+		val &= ~(PORT_CS_19_WOC | PORT_CS_19_WOD | PORT_CS_19_WOU4);
+
+		if (flags & TB_WAKE_ON_CONNECT)
+			val |= PORT_CS_19_WOC;
+		if (flags & TB_WAKE_ON_DISCONNECT)
+			val |= PORT_CS_19_WOD;
+		if (flags & TB_WAKE_ON_USB4)
+			val |= PORT_CS_19_WOU4;
+
+		ret = tb_port_write(port, &val, TB_CFG_PORT,
+				    port->cap_usb4 + PORT_CS_19, 1);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Enable wakes from PCIe and USB 3.x on this router. Only
+	 * needed for device routers.
+	 */
+	if (route) {
+		ret = tb_sw_read(sw, &val, TB_CFG_SWITCH, ROUTER_CS_5, 1);
+		if (ret)
+			return ret;
+
+		val &= ~(ROUTER_CS_5_WOP | ROUTER_CS_5_WOU);
+		if (flags & TB_WAKE_ON_USB3)
+			val |= ROUTER_CS_5_WOU;
+		if (flags & TB_WAKE_ON_PCIE)
+			val |= ROUTER_CS_5_WOP;
+
+		ret = tb_sw_write(sw, &val, TB_CFG_SWITCH, ROUTER_CS_5, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * usb4_switch_set_sleep() - Prepare the router to enter sleep
  * @sw: USB4 router
  *
- * Enables wakes and sets sleep bit for the router. Returns when the
- * router sleep ready bit has been asserted.
+ * Sets sleep bit for the router. Returns when the router sleep ready
+ * bit has been asserted.
  */
 int usb4_switch_set_sleep(struct tb_switch *sw)
 {
-- 
2.28.0

