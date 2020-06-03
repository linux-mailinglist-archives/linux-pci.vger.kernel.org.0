Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9749E1ECEF4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 13:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgFCLtO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 07:49:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:60884 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCLtO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 07:49:14 -0400
IronPort-SDR: HekfZPGzVfN3Rz8tXdbg6osW7MqtPM45sCbbU6myPzFh+ifZZ6IXUlqfuyRZnburCgndiRm0+u
 gCvnaPhtsHEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 04:49:13 -0700
IronPort-SDR: H1mn7D3ibaebcB80vdUcFHwoNFnvDau4t3J8OyMuciLHY/Jr37C3l+UjPB97E1FmoH0aeFTeT+
 2cqNvLgVz3sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="257987380"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2020 04:49:10 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Michael K Johnson <johnsonm@danlj.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Drake <drake@endlessm.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/15] mmc: sdhci: Use PCI_IRQ_MSI_TYPES where appropriate
Date:   Wed,  3 Jun 2020 13:49:01 +0200
Message-Id: <20200603114906.13625-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-gli.c     | 3 +--
 drivers/mmc/host/sdhci-pci-o2micro.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index fd76aa672e02..d14997f9cbf9 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -271,8 +271,7 @@ static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
 {
 	int ret;
 
-	ret = pci_alloc_irq_vectors(slot->chip->pdev, 1, 1,
-				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	ret = pci_alloc_irq_vectors(slot->chip->pdev, 1, 1, PCI_IRQ_MSI_TYPES);
 	if (ret < 0) {
 		pr_warn("%s: enable PCI MSI failed, error=%d\n",
 		       mmc_hostname(slot->host->mmc), ret);
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index fa8105087d68..498c51207bfb 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -470,8 +470,7 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
 		return;
 	}
 
-	ret = pci_alloc_irq_vectors(chip->pdev, 1, 1,
-				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	ret = pci_alloc_irq_vectors(chip->pdev, 1, 1, PCI_IRQ_MSI_TYPES);
 	if (ret < 0) {
 		pr_err("%s: enable PCI MSI failed, err=%d\n",
 		       mmc_hostname(host->mmc), ret);
-- 
2.17.2

