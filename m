Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC76FF271
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbjEKNRk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 09:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238068AbjEKNRJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 09:17:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF5A106CF;
        Thu, 11 May 2023 06:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683810955; x=1715346955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ul2QUVnvHfkhIAA4evmk2/BOdfg1e7KiHMnCZ5G3U7Y=;
  b=dCxeaUelrWwtrOW8P6DDMcVaev+lwE6fbjQAafJQ/ebe+rgyC+lNCEv/
   hegvtdFU/cO/ID3ej2qV76hRcA/Lbc2Ya+ml4Tjugoe1DfpArx7P618Zb
   MfvBAIXZGGyLN056+noFksDD8wNmS1wuvjkzcRmiOnjmAnKZ96Ef79P1x
   vWir8zsJnK9IHUWju9V1/yqyG4+y+pBIdgYjxF9G98Cam8kF0w0Mq/QJ+
   yCzcx7atFYDjV64k+JM7pCpkFXbUoXas0StM5t8geAgxOMKGAwRIAhdxV
   L4jXtLOpLofsRu/8qnBpRhG2jCyej9GE6cXPBeMeZAvO2ukZAbzRmn/bm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="378619622"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378619622"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:15:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="650169989"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="650169989"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:15:40 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 12/17] misc: rtsx: Use pcie_lnkctl_clear_and_set() for changing LNKCTL
Date:   Thu, 11 May 2023 16:14:36 +0300
Message-Id: <20230511131441.45704-13-ilpo.jarvinen@linux.intel.com>
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
 drivers/misc/cardreader/rts5228.c  | 6 ++----
 drivers/misc/cardreader/rts5261.c  | 6 ++----
 drivers/misc/cardreader/rtsx_pcr.c | 8 +++-----
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index cfebad51d1d8..74f407fff460 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -515,8 +515,7 @@ static void rts5228_enable_aspm(struct rtsx_pcr *pcr, bool enable)
 	val = FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
 	val |= (pcr->aspm_en & 0x02);
 	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, pcr->aspm_en);
+	pcie_lnkctl_clear_and_set(pcr->pci, PCI_EXP_LNKCTL_ASPMC, pcr->aspm_en);
 	pcr->aspm_enabled = enable;
 }
 
@@ -527,8 +526,7 @@ static void rts5228_disable_aspm(struct rtsx_pcr *pcr, bool enable)
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, 0);
+	pcie_lnkctl_clear_and_set(pcr->pci, PCI_EXP_LNKCTL_ASPMC, 0);
 	mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
 	val = FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
 	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index b1e76030cafd..830b595e5968 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -596,8 +596,7 @@ static void rts5261_enable_aspm(struct rtsx_pcr *pcr, bool enable)
 
 	val |= (pcr->aspm_en & 0x02);
 	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, pcr->aspm_en);
+	pcie_lnkctl_clear_and_set(pcr->pci, PCI_EXP_LNKCTL_ASPMC, pcr->aspm_en);
 	pcr->aspm_enabled = enable;
 }
 
@@ -609,8 +608,7 @@ static void rts5261_disable_aspm(struct rtsx_pcr *pcr, bool enable)
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, 0);
+	pcie_lnkctl_clear_and_set(pcr->pci, PCI_EXP_LNKCTL_ASPMC, 0);
 	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
 	rtsx_pci_write_register(pcr, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
 	udelay(10);
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 32b7783e9d4f..a9b26846aec6 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -86,9 +86,8 @@ static void rtsx_comm_set_aspm(struct rtsx_pcr *pcr, bool enable)
 		return;
 
 	if (pcr->aspm_mode == ASPM_MODE_CFG) {
-		pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-						PCI_EXP_LNKCTL_ASPMC,
-						enable ? pcr->aspm_en : 0);
+		pcie_lnkctl_clear_and_set(pcr->pci, PCI_EXP_LNKCTL_ASPMC,
+					  enable ? pcr->aspm_en : 0);
 	} else if (pcr->aspm_mode == ASPM_MODE_REG) {
 		if (pcr->aspm_en & 0x02)
 			rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
@@ -1315,8 +1314,7 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	rtsx_pci_init_ocp(pcr);
 
 	/* Enable clk_request_n to enable clock power management */
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					0, PCI_EXP_LNKCTL_CLKREQ_EN);
+	pcie_lnkctl_clear_and_set(pcr->pci, 0, PCI_EXP_LNKCTL_CLKREQ_EN);
 	/* Enter L1 when host tx idle */
 	pci_write_config_byte(pdev, 0x70F, 0x5B);
 
-- 
2.30.2

