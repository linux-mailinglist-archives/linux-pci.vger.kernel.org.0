Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D20A249D2D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgHSMCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 08:02:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:49550 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbgHSL7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:23 -0400
IronPort-SDR: PuSeqyQr/q0KizfHJUuvlehAgLjvmVXGjmyaUtYjRFK58r+1A1liW+9kW8tJOCV3FY5HUIUNJe
 8ycoN/zSEbwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="239922671"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="239922671"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:14 -0700
IronPort-SDR: BeDZnOWaqfnl4JgJphoLH1l/+9bRLuDcmINtHUYnxJDJJOKiPC0Ujg/WnHwXv924P/2yue77Zw
 bUYjKahQtsjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="329310760"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2020 04:59:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D76666BF; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
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
Subject: [PATCH 14/19] thunderbolt: Disable lane 1 for XDomain connection
Date:   Wed, 19 Aug 2020 14:59:00 +0300
Message-Id: <20200819115905.59834-15-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

USB4 spec mandates that the lane 1 should be disabled if lanes are not
bonded. For host-to-host connections (XDomain) we don't support lane
bonding so in order to be compatible with the spec, disable lane 1 when
another host is connected.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c  | 44 +++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/tb.c      |  8 +++++++
 drivers/thunderbolt/tb.h      |  2 ++
 drivers/thunderbolt/tb_regs.h |  1 +
 4 files changed, 55 insertions(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 1c45f8baf487..a8df25dae57b 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -673,6 +673,50 @@ int tb_port_unlock(struct tb_port *port)
 	return 0;
 }
 
+static int __tb_port_enable(struct tb_port *port, bool enable)
+{
+	int ret;
+	u32 phy;
+
+	if (!tb_port_is_null(port))
+		return -EINVAL;
+
+	ret = tb_port_read(port, &phy, TB_CFG_PORT,
+			   port->cap_phy + LANE_ADP_CS_1, 1);
+	if (ret)
+		return ret;
+
+	if (enable)
+		phy &= ~LANE_ADP_CS_1_LD;
+	else
+		phy |= LANE_ADP_CS_1_LD;
+
+	return tb_port_write(port, &phy, TB_CFG_PORT,
+			     port->cap_phy + LANE_ADP_CS_1, 1);
+}
+
+/**
+ * tb_port_enable() - Enable lane adapter
+ * @port: Port to enable (can be %NULL)
+ *
+ * This is used for lane 0 and 1 adapters to enable it.
+ */
+int tb_port_enable(struct tb_port *port)
+{
+	return __tb_port_enable(port, true);
+}
+
+/**
+ * tb_port_disable() - Disable lane adapter
+ * @port: Port to disable (can be %NULL)
+ *
+ * This is used for lane 0 and 1 adapters to disable it.
+ */
+int tb_port_disable(struct tb_port *port)
+{
+	return __tb_port_enable(port, false);
+}
+
 /**
  * tb_init_port() - initialize a port
  *
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 602e00e0b45e..214e47656be6 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -142,6 +142,12 @@ static void tb_discover_tunnels(struct tb_switch *sw)
 
 static int tb_port_configure_xdomain(struct tb_port *port)
 {
+	/*
+	 * XDomain paths currently only support single lane so we must
+	 * disable the other lane according to USB4 spec.
+	 */
+	tb_port_disable(port->dual_link_port);
+
 	if (tb_switch_is_usb4(port->sw))
 		return usb4_port_configure_xdomain(port);
 	return tb_lc_configure_xdomain(port);
@@ -153,6 +159,8 @@ static void tb_port_unconfigure_xdomain(struct tb_port *port)
 		usb4_port_unconfigure_xdomain(port);
 	else
 		tb_lc_unconfigure_xdomain(port);
+
+	tb_port_enable(port->dual_link_port);
 }
 
 static void tb_scan_xdomain(struct tb_port *port)
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index dbe332c3e95e..f58cd3fa98ea 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -790,6 +790,8 @@ int tb_port_add_nfc_credits(struct tb_port *port, int credits);
 int tb_port_set_initial_credits(struct tb_port *port, u32 credits);
 int tb_port_clear_counter(struct tb_port *port, int counter);
 int tb_port_unlock(struct tb_port *port);
+int tb_port_enable(struct tb_port *port);
+int tb_port_disable(struct tb_port *port);
 int tb_port_alloc_in_hopid(struct tb_port *port, int hopid, int max_hopid);
 void tb_port_release_in_hopid(struct tb_port *port, int hopid);
 int tb_port_alloc_out_hopid(struct tb_port *port, int hopid, int max_hopid);
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index a553be24f1c0..d1a40baa63d2 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -279,6 +279,7 @@ struct tb_regs_port_header {
 #define LANE_ADP_CS_1_TARGET_WIDTH_SHIFT	4
 #define LANE_ADP_CS_1_TARGET_WIDTH_SINGLE	0x1
 #define LANE_ADP_CS_1_TARGET_WIDTH_DUAL		0x3
+#define LANE_ADP_CS_1_LD			BIT(14)
 #define LANE_ADP_CS_1_LB			BIT(15)
 #define LANE_ADP_CS_1_CURRENT_SPEED_MASK	GENMASK(19, 16)
 #define LANE_ADP_CS_1_CURRENT_SPEED_SHIFT	16
-- 
2.28.0

