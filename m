Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076986F3F55
	for <lists+linux-pci@lfdr.de>; Tue,  2 May 2023 10:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjEBIjg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 May 2023 04:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjEBIjf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2023 04:39:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ACF10B;
        Tue,  2 May 2023 01:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683016774; x=1714552774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NQ7UtzDQj6DonGb4HNH9Xd0QLx15TZUY6naY4Em3T/4=;
  b=SDxPQPNTI1UiE+Gjvi6MBbYz18+/PhndnXY33X92I6K7Lg4mtHV2QVKu
   9gVXqKhOPHuIk0TsdildpgTIzFGyT+hK7BWA/B78egWo8NZj/xWSB19TX
   ofDYeVqxtLDPF45dNVoUAijM3dm+hJGRq8Nl5n1DEc6HkqUk3JNGCPW/S
   eZ8bHAh9AXE/zjtSfHwTOdvZ3VSOdJHaTvrF3rtQIS8TPbmAUX4a6akja
   t2inhdOvTkjmnCy64/XTomCV5bInZcW25cyFs0tyVPawCKqSXS5Xoy1KU
   Uq27sCKUKJFiy0BAMek+6DBK3kj1d3LjeoQDEqwog3r/P45sB/B5nMI0r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="350421628"
X-IronPort-AV: E=Sophos;i="5.99,243,1677571200"; 
   d="scan'208";a="350421628"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 01:39:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="728850171"
X-IronPort-AV: E=Sophos;i="5.99,243,1677571200"; 
   d="scan'208";a="728850171"
Received: from rmasarlx-mobl1.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.34.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 01:39:31 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Shaohua Li <shaohua.li@intel.com>,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
Subject: [PATCH 1/1] PCI/ASPM: Handle link retraining race
Date:   Tue,  2 May 2023 11:39:23 +0300
Message-Id: <20230502083923.34562-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implementation Note at the end of PCIe r6.0.1 sec 7.5.3.7 recommends
handling LTSSM race to ensure link retraining acquires correct
parameters from the LNKCTL register. According to the implementation
note, LTSSM might transition into Recovery or Configuration state
independently of the driver requesting it, and if retraining due to
such an event is still ongoing, the value written into the LNKCTL
register might not be considered by the link retraining.

Ensure link training bit is clear before toggling link retraining bit
to meet the requirements of the Implementation Note.

Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org
---
 drivers/pci/pcie/aspm.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 66d7514ca111..dde1ef13d0d1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -193,12 +193,37 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
+static bool pcie_wait_for_retrain(struct pci_dev *pdev)
+{
+	unsigned long end_jiffies;
+	u16 reg16;
+
+	/* Wait for link training end. Break out after waiting for timeout */
+	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
+	do {
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &reg16);
+		if (!(reg16 & PCI_EXP_LNKSTA_LT))
+			break;
+		msleep(1);
+	} while (time_before(jiffies, end_jiffies));
+
+	return !(reg16 & PCI_EXP_LNKSTA_LT);
+}
+
 static bool pcie_retrain_link(struct pcie_link_state *link)
 {
 	struct pci_dev *parent = link->pdev;
-	unsigned long end_jiffies;
 	u16 reg16;
 
+	/*
+	 * Ensure the updated LNKCTL parameters are used during link
+	 * training by checking that there is no ongoing link training to
+	 * avoid LTSSM race as recommended in Implementation Note at the end
+	 * of PCIe r6.0.1 sec 7.5.3.7.
+	 */
+	if (!pcie_wait_for_retrain(parent))
+		return false;
+
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
 	reg16 |= PCI_EXP_LNKCTL_RL;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
@@ -212,15 +237,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
 	}
 
-	/* Wait for link training end. Break out after waiting for timeout */
-	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
-	do {
-		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
-		if (!(reg16 & PCI_EXP_LNKSTA_LT))
-			break;
-		msleep(1);
-	} while (time_before(jiffies, end_jiffies));
-	return !(reg16 & PCI_EXP_LNKSTA_LT);
+	return pcie_wait_for_retrain(parent);
 }
 
 /*
-- 
2.30.2

