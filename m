Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C950EFAC9C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 10:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfKMJJW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 04:09:22 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14445 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfKMJJW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 04:09:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcbc8440000>; Wed, 13 Nov 2019 01:09:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Nov 2019 01:09:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Nov 2019 01:09:21 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 09:09:20 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Nov 2019 09:09:21 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dcbc83d0001>; Wed, 13 Nov 2019 01:09:20 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH 4/4] PCI: pci-epf-test: Add support to defer core initialization
Date:   Wed, 13 Nov 2019 14:38:51 +0530
Message-ID: <20191113090851.26345-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113090851.26345-1-vidyas@nvidia.com>
References: <20191113090851.26345-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573636164; bh=PSPmVrDzo534RrRdZAwtuFYisc9SkubauqDX1jqAkTo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=IilP7tjYxaAC3IAGSi55w6t3nfGSZ6YQZSW8vLSXh3Z+8n/bcr71jBv3N7nl42XOp
         sjeKzUGcC18/rNTvBt2log8FpY1Lpnj9IXxaZP9w8jY+Gj9sZdnzm7k8vM8VqqJRQo
         WiPpG2rG5PPTnX2kkjgRFmEJwnuUL59a0tH1Ihc73duMVX1pamVEYJxZjrJAGDIk9x
         m8Vqw0yuioPTqmyyRJbvHum/MMN2TjuqRlmAtQNKotbuhhJyJWDLSQx4MCpXVBoZdh
         uQ7mJ2zxqMyqxeaUWF1YSi9e6NK/oYleyIGAGd1cHV85wvvxvr6Ugwhi/L/KRu1Mpk
         ta+OskhxJYU+Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to defer core initialization and to receive a notifier
when core is ready to accommodate platforms where core is not for
initialization untile reference clock from host is available.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 114 ++++++++++++------
 1 file changed, 77 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index bddff15052cc..068024fab544 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -360,18 +360,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 			   msecs_to_jiffies(1));
 }
 
-static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
-				 void *data)
-{
-	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
-	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
-
-	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
-			   msecs_to_jiffies(1));
-
-	return NOTIFY_OK;
-}
-
 static void pci_epf_test_unbind(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
@@ -428,6 +416,78 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 	return 0;
 }
 
+static int pci_epf_test_core_init(struct pci_epf *epf)
+{
+	struct pci_epf_header *header = epf->header;
+	const struct pci_epc_features *epc_features;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	bool msix_capable = false;
+	bool msi_capable = true;
+	int ret;
+
+	epc_features = pci_epc_get_features(epc, epf->func_no);
+	if (epc_features) {
+		msix_capable = epc_features->msix_capable;
+		msi_capable = epc_features->msi_capable;
+	}
+
+	ret = pci_epc_write_header(epc, epf->func_no, header);
+	if (ret) {
+		dev_err(dev, "Configuration header write failed\n");
+		return ret;
+	}
+
+	ret = pci_epf_test_set_bar(epf);
+	if (ret)
+		return ret;
+
+	if (msi_capable) {
+		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
+		if (ret) {
+			dev_err(dev, "MSI configuration failed\n");
+			return ret;
+		}
+	}
+
+	if (msix_capable) {
+		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
+		if (ret) {
+			dev_err(dev, "MSI-X configuration failed\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
+				 void *data)
+{
+	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	int ret;
+
+	switch (val) {
+	case CORE_INIT:
+		ret = pci_epf_test_core_init(epf);
+		if (ret)
+			return NOTIFY_BAD;
+		break;
+
+	case LINK_UP:
+		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
+				   msecs_to_jiffies(1));
+		break;
+
+	default:
+		dev_err(&epf->dev, "Invalid EPF test notifier event\n");
+		return NOTIFY_BAD;
+	}
+
+	return NOTIFY_OK;
+}
+
 static int pci_epf_test_alloc_space(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
@@ -496,12 +556,11 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 {
 	int ret;
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
-	struct pci_epf_header *header = epf->header;
 	const struct pci_epc_features *epc_features;
 	enum pci_barno test_reg_bar = BAR_0;
 	struct pci_epc *epc = epf->epc;
-	struct device *dev = &epf->dev;
 	bool linkup_notifier = false;
+	bool skip_core_init = false;
 	bool msix_capable = false;
 	bool msi_capable = true;
 
@@ -511,6 +570,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	epc_features = pci_epc_get_features(epc, epf->func_no);
 	if (epc_features) {
 		linkup_notifier = epc_features->linkup_notifier;
+		skip_core_init = epc_features->skip_core_init;
 		msix_capable = epc_features->msix_capable;
 		msi_capable = epc_features->msi_capable;
 		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
@@ -520,34 +580,14 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	epf_test->test_reg_bar = test_reg_bar;
 	epf_test->epc_features = epc_features;
 
-	ret = pci_epc_write_header(epc, epf->func_no, header);
-	if (ret) {
-		dev_err(dev, "Configuration header write failed\n");
-		return ret;
-	}
-
 	ret = pci_epf_test_alloc_space(epf);
 	if (ret)
 		return ret;
 
-	ret = pci_epf_test_set_bar(epf);
-	if (ret)
-		return ret;
-
-	if (msi_capable) {
-		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
-		if (ret) {
-			dev_err(dev, "MSI configuration failed\n");
-			return ret;
-		}
-	}
-
-	if (msix_capable) {
-		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
-		if (ret) {
-			dev_err(dev, "MSI-X configuration failed\n");
+	if (!skip_core_init) {
+		ret = pci_epf_test_core_init(epf);
+		if (ret)
 			return ret;
-		}
 	}
 
 	if (linkup_notifier) {
-- 
2.17.1

