Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E975218F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 14:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjGMMqy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 08:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbjGMMqw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 08:46:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BE2728;
        Thu, 13 Jul 2023 05:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689252387; x=1720788387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w+Jctrt8GXsG54tgiviHTqhtp1nDe9dil2kNRqoIX1w=;
  b=mpd5/x3R5TOyIsGGcnQr+5z85Emv5ZiinOK3qdv8Fddj0Ruq/5vcQ59Q
   Vw0qD9OV3qpD2wF8zxNXmrcvBf0rz+Mx82YhJ2s31Fa0iA77vqTzu8ZXs
   zF/TgIaeVt7yNFz3OyKGyF0tKoVJljmKIrmS+s0Afd0BswScA9gnWb7rS
   BdHH179zRrv0MY6uj4H9qr7xzvj1r6RmxLCs8hZAtBsVnWzBJOwlWFKUJ
   gDJTEf7uq0ED7yZRMXzO9vZ4F0lQ9ypAphxQx/jPAogqUl8SxjrxwFPgg
   zf7snhga3UaTwTW+SHS6zMfP47aMkdFCb2ysID4WdcfczTUT4u2/eHA1h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="367796991"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="367796991"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 05:46:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="757144492"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="757144492"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 05:46:20 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Kalle Valo <kvalo@kernel.org>,
        Carl Huang <cjhuang@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        stable@vger.kernel.org
Subject: [PATCH v4 08/11] wifi: ath11k: Use RMW accessors for changing LNKCTL
Date:   Thu, 13 Jul 2023 15:45:02 +0300
Message-Id: <20230713124505.94866-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713124505.94866-1-ilpo.jarvinen@linux.intel.com>
References: <20230713124505.94866-1-ilpo.jarvinen@linux.intel.com>
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

Use RMW capability accessors which do proper locking to avoid losing
concurrent updates to the register value. On restore, clear the ASPMC
field properly.

Fixes: e9603f4bdcc0 ("ath11k: pci: disable ASPM L0sLs before downloading firmware")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Kalle Valo <kvalo@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/net/wireless/ath/ath11k/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 79e2cbe82638..ec40adc1cb23 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -581,8 +581,8 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
 
 	/* disable L0s and L1 */
-	pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-				   ab_pci->link_ctl & ~PCI_EXP_LNKCTL_ASPMC);
+	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
+				   PCI_EXP_LNKCTL_ASPMC);
 
 	set_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags);
 }
@@ -590,8 +590,10 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
 {
 	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
-		pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-					   ab_pci->link_ctl);
+		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC,
+						   ab_pci->link_ctl &
+						   PCI_EXP_LNKCTL_ASPMC);
 }
 
 static int ath11k_pci_power_up(struct ath11k_base *ab)
-- 
2.30.2

