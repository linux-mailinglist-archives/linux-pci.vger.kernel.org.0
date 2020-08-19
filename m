Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B8D249D0B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgHSL7b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 07:59:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:23197 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728453AbgHSL7R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:17 -0400
IronPort-SDR: jkgx8MdRyBTdVo8Y2ycmSS9Y4UbPJ34a1ao272IYd1BELj3dJStEv+h8sDpYd62VbK5L0BTqQe
 LkEU9aRZ785w==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="152708174"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="152708174"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:14 -0700
IronPort-SDR: Nttxb4+YcF2yr3xWeLrmOtQkjZYMskIXL2yWeXYUHPXmATj3QmhtGB82UaaTpBcau3TsW3Cn1a
 z8kRFV3xNz4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="400804657"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2020 04:59:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 960A43DF; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
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
Subject: [PATCH 07/19] thunderbolt: Send reset only to first generation routers
Date:   Wed, 19 Aug 2020 14:58:53 +0300
Message-Id: <20200819115905.59834-8-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

First generation routers may need the reset command upon resume but it
is not supported by newer generations.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 21 +++++++++++----------
 drivers/thunderbolt/tb.c     |  2 +-
 drivers/thunderbolt/tb.h     |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 72756c8ceead..fb30ea1dfc31 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1234,23 +1234,24 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
 
 /**
  * reset_switch() - reconfigure route, enable and send TB_CFG_PKG_RESET
+ * @sw: Switch to reset
  *
  * Return: Returns 0 on success or an error code on failure.
  */
-int tb_switch_reset(struct tb *tb, u64 route)
+int tb_switch_reset(struct tb_switch *sw)
 {
 	struct tb_cfg_result res;
-	struct tb_regs_switch_header header = {
-		header.route_hi = route >> 32,
-		header.route_lo = route,
-		header.enabled = true,
-	};
-	tb_dbg(tb, "resetting switch at %llx\n", route);
-	res.err = tb_cfg_write(tb->ctl, ((u32 *) &header) + 2, route,
-			0, 2, 2, 2);
+
+	if (sw->generation > 1)
+		return 0;
+
+	tb_sw_dbg(sw, "resetting switch\n");
+
+	res.err = tb_sw_write(sw, ((u32 *) &sw->config) + 2,
+			      TB_CFG_SWITCH, 2, 2);
 	if (res.err)
 		return res.err;
-	res = tb_cfg_reset(tb->ctl, route, TB_CFG_DEFAULT_TIMEOUT);
+	res = tb_cfg_reset(sw->tb->ctl, tb_route(sw), TB_CFG_DEFAULT_TIMEOUT);
 	if (res.err > 0)
 		return -EIO;
 	return res.err;
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 98f268a818a0..a6da2d0567ae 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1258,7 +1258,7 @@ static int tb_resume_noirq(struct tb *tb)
 	tb_dbg(tb, "resuming...\n");
 
 	/* remove any pci devices the firmware might have setup */
-	tb_switch_reset(tb, 0);
+	tb_switch_reset(tb->root_switch);
 
 	tb_switch_resume(tb->root_switch);
 	tb_free_invalid_tunnels(tb);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index df08f6d7aaa0..69e78bbed53a 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -634,7 +634,7 @@ int tb_switch_add(struct tb_switch *sw);
 void tb_switch_remove(struct tb_switch *sw);
 void tb_switch_suspend(struct tb_switch *sw);
 int tb_switch_resume(struct tb_switch *sw);
-int tb_switch_reset(struct tb *tb, u64 route);
+int tb_switch_reset(struct tb_switch *sw);
 void tb_sw_set_unplugged(struct tb_switch *sw);
 struct tb_port *tb_switch_find_port(struct tb_switch *sw,
 				    enum tb_port_type type);
-- 
2.28.0

