Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969BE1F36EB
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 11:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgFIJTr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 05:19:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:41831 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgFIJTp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 05:19:45 -0400
IronPort-SDR: pf1GobEWeXhgURn620/sWYZOH7M1PlFYNnG3+jYnZDHnAbR0N9e9eY2Z5iXbN22hKtAG3Qdusm
 gqtw1lhRFM7Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 02:19:34 -0700
IronPort-SDR: PvJDXIovsXy9CV+FXSlW/+WF+fwWmRrsEOAZ0ixSlqAj0k0ZBaL6faCUI6q1x5Pg4oWN8ME58R
 uE3J7bnT7bFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="288770992"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2020 02:19:31 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Michael K Johnson <johnsonm@danlj.org>,
        Renius Chen <renius.chen@genesyslogic.com.tw>,
        "Shirley Her (SC)" <shirley.her@bayhubtech.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Samuel Zou <zou_wei@huawei.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/15] mmc: sdhci: Use PCI_IRQ_MSI_TYPES where appropriate
Date:   Tue,  9 Jun 2020 11:19:24 +0200
Message-Id: <20200609091929.1600-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
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
index ca0166d9bf82..aa7eef201ada 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -284,8 +284,7 @@ static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
 {
 	int ret;
 
-	ret = pci_alloc_irq_vectors(slot->chip->pdev, 1, 1,
-				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+	ret = pci_alloc_irq_vectors(slot->chip->pdev, 1, 1, PCI_IRQ_MSI_TYPES);
 	if (ret < 0) {
 		pr_warn("%s: enable PCI MSI failed, error=%d\n",
 		       mmc_hostname(slot->host->mmc), ret);
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index e2a846885902..c81a5c328a81 100644
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

