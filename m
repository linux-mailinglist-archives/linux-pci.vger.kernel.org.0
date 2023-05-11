Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41BD6FF280
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbjEKNRv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 09:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbjEKNR0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 09:17:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FBEA246;
        Thu, 11 May 2023 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683810963; x=1715346963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=paHPAxNSN7XrfOCqSeIv5fD6avbn5iDknT1MgPKEy2c=;
  b=KtsglVmiMYR3Ac7037BdkEZflVqp1nc6ZHeTz+ubv9bFsAdLRzK83+4p
   RVLkmmgQX6TbPKfrjhEtwROAnU5YrwufQwZGZHCYWuqj7JFTA+QEk4qZF
   Ky0cXKZwJY9sm7Qsbj9P5l2T2jdZ+mgEoEUY3gMsOi6aPJKnliAshB0aJ
   2dKPX4mkUr1WcC1KODMl2JrhXDZR/i0jPCKS5FNDnT0HcV7SdcTKTQetv
   sMzKyCe5EkmSYqxYQpJ+iaUXR7SQNZ4KpNAcaFnyl1CL3fZCDrDYhl6NN
   yefw/ZEKkb84Kwugqp8kF2iCT/bNsjeMo/FmnXhI70/RnwursTF6cnDO0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="378619659"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378619659"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="650170018"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="650170018"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:15:43 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 13/17] net/tg3: Use pcie_lnkctl_clear_and_set() for changing LNKCTL
Date:   Thu, 11 May 2023 16:14:37 +0300
Message-Id: <20230511131441.45704-14-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
References: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't assume that only the driver would be accessing LNKCTL. ASPM
policy changes can trigger write to LNKCTL outside of driver's control.

Use pcie_lnkctl_clear_and_set() which does proper locking to avoid
losing concurrent updates to the register value.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 58747292521d..f3b30e7af25d 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -4027,8 +4027,7 @@ static int tg3_power_down_prepare(struct tg3 *tp)
 
 	/* Restore the CLKREQ setting. */
 	if (tg3_flag(tp, CLKREQ_BUG))
-		pcie_capability_set_word(tp->pdev, PCI_EXP_LNKCTL,
-					 PCI_EXP_LNKCTL_CLKREQ_EN);
+		pcie_lnkctl_clear_and_set(tp->pdev, 0, PCI_EXP_LNKCTL_CLKREQ_EN);
 
 	misc_host_ctrl = tr32(TG3PCI_MISC_HOST_CTRL);
 	tw32(TG3PCI_MISC_HOST_CTRL,
@@ -5069,13 +5068,14 @@ static int tg3_setup_copper_phy(struct tg3 *tp, bool force_reset)
 
 	/* Prevent send BD corruption. */
 	if (tg3_flag(tp, CLKREQ_BUG)) {
+		u16 clkreq = 0;
+
 		if (tp->link_config.active_speed == SPEED_100 ||
 		    tp->link_config.active_speed == SPEED_10)
-			pcie_capability_clear_word(tp->pdev, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_CLKREQ_EN);
-		else
-			pcie_capability_set_word(tp->pdev, PCI_EXP_LNKCTL,
-						 PCI_EXP_LNKCTL_CLKREQ_EN);
+			clkreq = PCI_EXP_LNKCTL_CLKREQ_EN;
+
+		pcie_lnkctl_clear_and_set(tp->pdev, PCI_EXP_LNKCTL_CLKREQ_EN,
+					  clkreq);
 	}
 
 	tg3_test_and_report_link_chg(tp, current_link_up);
-- 
2.30.2

