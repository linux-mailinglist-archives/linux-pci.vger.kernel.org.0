Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86D931611BC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 13:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgBQMLX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 07:11:23 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10305 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbgBQMLW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 07:11:22 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4a82a40003>; Mon, 17 Feb 2020 04:10:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Feb 2020 04:11:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Feb 2020 04:11:21 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Feb
 2020 12:11:21 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Feb 2020 12:11:21 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e4a82e50002>; Mon, 17 Feb 2020 04:11:20 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 5/5] PCI: pci-epf-test: Add support to defer core initialization
Date:   Mon, 17 Feb 2020 17:40:36 +0530
Message-ID: <20200217121036.3057-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217121036.3057-1-vidyas@nvidia.com>
References: <20200217121036.3057-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581941412; bh=eGt2+Yh0O6x9T6oLgMVEW8AJcfszXV5Q3sRLEsQmQ/0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=SeFtdgpahDWW2OuUC/5wwH/aUpbu27WMzNmBU03CZUEA9JXy+K7f1o3SeyqSehlH6
         Ug/9satkjGGYJWFbK2dJ8O49uDPl4gma+oCxfucDw+0TWA3hPFWqUutvJ91Mvtp/R1
         UuVdPvKVhnBEAOFqi22wnC1desbLLnHjlSMzo1IccC5E50UCHED7AvGSCclJjmwz3G
         /goV3gslJyIxuAf7zFkL2hNXOHeVHAJlRN0kOWFqONBzGM0E/scTMjve7OuQp5hECs
         +lcZio3QhwaS3s5vofaeBwxl0rU++zxNxfBe/rdfuMHc8MwxySPHSW5VmtCsS9rrWu
         dQvPnE7dylgQw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to defer core initialization and to receive a notifier
when core is ready to accommodate platforms where core is not for
initialization untile reference clock from host is available.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
V3:
* Added Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

V2:
* Addressed review comments from Kishon

 drivers/pci/endpoint/functions/pci-epf-test.c | 118 ++++++++++++------
 1 file changed, 77 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index bddff15052cc..be04c6220265 100644
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
@@ -496,14 +556,11 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 {
 	int ret;
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
-	struct pci_epf_header *header = epf->header;
 	const struct pci_epc_features *epc_features;
 	enum pci_barno test_reg_bar = BAR_0;
 	struct pci_epc *epc = epf->epc;
-	struct device *dev = &epf->dev;
 	bool linkup_notifier = false;
-	bool msix_capable = false;
-	bool msi_capable = true;
+	bool core_init_notifier = false;
 
 	if (WARN_ON_ONCE(!epc))
 		return -EINVAL;
@@ -511,8 +568,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	epc_features = pci_epc_get_features(epc, epf->func_no);
 	if (epc_features) {
 		linkup_notifier = epc_features->linkup_notifier;
-		msix_capable = epc_features->msix_capable;
-		msi_capable = epc_features->msi_capable;
+		core_init_notifier = epc_features->core_init_notifier;
 		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
 		pci_epf_configure_bar(epf, epc_features);
 	}
@@ -520,34 +576,14 @@ static int pci_epf_test_bind(struct pci_epf *epf)
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
+	if (!core_init_notifier) {
+		ret = pci_epf_test_core_init(epf);
+		if (ret)
 			return ret;
-		}
 	}
 
 	if (linkup_notifier) {
-- 
2.17.1

