Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6A5249D00
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 13:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgHSL7T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 07:59:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:50012 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbgHSL7N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:13 -0400
IronPort-SDR: DLQJhcqScln7J7x0Z09Qul6nInTS5H2qXfGnBmMEYrpJHEXAmi7wpc3Pruks6dHLC8EgBMo5nl
 E33YSXaHgW6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="155060155"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="155060155"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:10 -0700
IronPort-SDR: jlJ1sNCxmI3NEFOl3iykLMYBESZ9h6W1Un94eLawz7S9fIFbNuDcnWkTcDLVHNNVDlVlCDPQB8
 n30go2nRjGMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="279686688"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 19 Aug 2020 04:59:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 69B84371; Wed, 19 Aug 2020 14:59:06 +0300 (EEST)
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
Subject: [PATCH 03/19] thunderbolt: Software CM only should set force power in Tiger Lake
Date:   Wed, 19 Aug 2020 14:58:49 +0300
Message-Id: <20200819115905.59834-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When Software CM is running it should not send any NHI mailbox command
during PM flows. Only force power bit needs to be set and cleared so
change Tiger Lake (well and Ice Lake) nhi_ops to take this into account.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/nhi_ops.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/nhi_ops.c b/drivers/thunderbolt/nhi_ops.c
index 28583f9faf46..96da07e88c52 100644
--- a/drivers/thunderbolt/nhi_ops.c
+++ b/drivers/thunderbolt/nhi_ops.c
@@ -121,31 +121,38 @@ static void icl_nhi_set_ltr(struct tb_nhi *nhi)
 
 static int icl_nhi_suspend(struct tb_nhi *nhi)
 {
+	struct tb *tb = pci_get_drvdata(nhi->pdev);
 	int ret;
 
 	if (icl_nhi_is_device_connected(nhi))
 		return 0;
 
-	/*
-	 * If there is no device connected we need to perform both: a
-	 * handshake through LC mailbox and force power down before
-	 * entering D3.
-	 */
-	icl_nhi_lc_mailbox_cmd(nhi, ICL_LC_PREPARE_FOR_RESET);
-	ret = icl_nhi_lc_mailbox_cmd_complete(nhi, ICL_LC_MAILBOX_TIMEOUT);
-	if (ret)
-		return ret;
+	if (tb_switch_is_icm(tb->root_switch)) {
+		/*
+		 * If there is no device connected we need to perform
+		 * both: a handshake through LC mailbox and force power
+		 * down before entering D3.
+		 */
+		icl_nhi_lc_mailbox_cmd(nhi, ICL_LC_PREPARE_FOR_RESET);
+		ret = icl_nhi_lc_mailbox_cmd_complete(nhi, ICL_LC_MAILBOX_TIMEOUT);
+		if (ret)
+			return ret;
+	}
 
 	return icl_nhi_force_power(nhi, false);
 }
 
 static int icl_nhi_suspend_noirq(struct tb_nhi *nhi, bool wakeup)
 {
+	struct tb *tb = pci_get_drvdata(nhi->pdev);
 	enum icl_lc_mailbox_cmd cmd;
 
 	if (!pm_suspend_via_firmware())
 		return icl_nhi_suspend(nhi);
 
+	if (!tb_switch_is_icm(tb->root_switch))
+		return 0;
+
 	cmd = wakeup ? ICL_LC_GO2SX : ICL_LC_GO2SX_NO_WAKE;
 	icl_nhi_lc_mailbox_cmd(nhi, cmd);
 	return icl_nhi_lc_mailbox_cmd_complete(nhi, ICL_LC_MAILBOX_TIMEOUT);
-- 
2.28.0

