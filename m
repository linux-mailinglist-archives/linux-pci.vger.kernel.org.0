Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E6F6FF283
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 15:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbjEKNSU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 09:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbjEKNRw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 09:17:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CE010A20;
        Thu, 11 May 2023 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683810996; x=1715346996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TAC73s9QwdyGD3M/5SJI0+AWbjKADBP6Sv9hNzZQGXc=;
  b=AE6fCeq7PdQ1tgyOEDZs6HW9qtthi8TSinwt4pGMtaQiIm9o4LVsT8o9
   fasc9cuZinK6CYaTI1icSiLKMIKWtwLZS2aYlyFfw9gXfQx9MadayymKw
   ot8K3m7Mj6Z/Jw6OeBdPRbob9JIEXzznfhLt8M1tRHAm1oIXk/xZZ2V0C
   gBlS24sxr4PJfwtvW1zdZgT0nhFMl0Url462gYyZi4VYq70ykoDfX1hD5
   ZmIVOgtNNRXkeyij0rH8/DBHIcd7xRK/nWMF2wD/G4meIAfaFlDH03vS/
   FoNUlsuoGDgBcwvIT5SP01uAiwshYpPCsN2SJzeMtNhPDMa85bhtOEPcl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="378619781"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378619781"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="650170161"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="650170161"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:15:57 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 16/17] wifi: ath12k: Use pcie_lnkctl_clear_and_set() for changing LNKCTL
Date:   Thu, 11 May 2023 16:14:40 +0300
Message-Id: <20230511131441.45704-17-ilpo.jarvinen@linux.intel.com>
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
 drivers/net/wireless/ath/ath12k/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 9f174daf324c..fa88a0b88520 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -794,8 +794,8 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
 		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
 
 	/* disable L0s and L1 */
-	pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-				   ab_pci->link_ctl & ~PCI_EXP_LNKCTL_ASPMC);
+	pcie_lnkctl_clear_and_set(ab_pci->pdev,
+				  ab_pci->link_ctl & PCI_EXP_LNKCTL_ASPMC, 0);
 
 	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
 }
@@ -803,8 +803,8 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
 static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
 {
 	if (test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
-		pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-					   ab_pci->link_ctl);
+		pcie_lnkctl_clear_and_set(ab_pci->pdev, 0,
+					  ab_pci->link_ctl & PCI_EXP_LNKCTL_ASPMC);
 }
 
 static void ath12k_pci_kill_tasklets(struct ath12k_base *ab)
-- 
2.30.2

