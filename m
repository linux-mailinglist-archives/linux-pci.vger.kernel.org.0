Return-Path: <linux-pci+bounces-2084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A89F82BD49
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 10:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9A0286029
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 09:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB9856B75;
	Fri, 12 Jan 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGWDI+ri"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A109E5D8EE
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5eb6dba1796so118315707b3.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 01:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705051811; x=1705656611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7DbK7idU0uEVWJmKz7BH4SI0JtCU8A8G1ScuQzRkV5E=;
        b=uGWDI+riF/EHz8p+OpCdk7j+N0gLP7J3etcRXVgrN35i7mJsBmeewP0QzTEfztKZcx
         ZPUTVaBXjqTCLSSzOKJp6a0er7P3YIjuGTdmb2kJ2vcL3tgevPVHAwThjvVnyHUFEvut
         lGOzAdWu2UfsAYGomqAtRlz4CAS0qL3zN/J1TYfRCTG1KsZKzINq07qaWHeL1Iq0SE7/
         CleVQtexTo+VVeC71z5grMIVO1c1h1mxLKMhp5vMwS2bdtVneA/nZQUuFj/5y86a9MRf
         Jm82EjZPI+SYl/FR20FRjdDKQZYwbTft6UbxhnR6oGHVvxapRmFLHH1pq58v8wDGwzXU
         ciDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705051811; x=1705656611;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DbK7idU0uEVWJmKz7BH4SI0JtCU8A8G1ScuQzRkV5E=;
        b=CQ6S4jfYrrBrrC3302TGsf+jkc2iI1WuDdUEcUBZKxhcV/pZIf4CWnp4OWRwt34Crw
         yf+mhNfMQF1egYLy22c3vxExoTsSNWXvS/EZ/q9V7JlDExNzV9gYpSQ0H2pCQhEsTnqP
         cf3KesN2P2Fd0O37haShiiJHjfuMnznkpD28+LvvIsUlWMHZECwL0Q06pVd8IFTjiSwm
         zca1w0NCjAc9dFQB/2M1IHoFPnmsGc4pe0lBByLqcLYfioYGCi+HvVNQg+j0OxR/CIbr
         J8x32pKz8isY7SQyxTlS0/ZI+YXFwoHwjN79FPH5T54a0cPBZBwIPG44jBROicunIYQ4
         xsWg==
X-Gm-Message-State: AOJu0YxBlqLZGjW/2vl78caJbDSk8zcABBscic44EvyIeyiC8pWwPZ0n
	v4Cb1yDlvYlM2FjUloqwEpI2AQUN3yDQ44Uh+BFxrCGE
X-Google-Smtp-Source: AGHT+IG48osOKARHpnq6WAX1Owlegm34Norf8qDBCcksJvBDHqdKS1YbVwu8TD06GHWI9+xZC72Tg2U4CKqLWCzsKg==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a05:6902:1081:b0:dbd:b6cd:92cf with
 SMTP id v1-20020a056902108100b00dbdb6cd92cfmr222093ybu.11.1705051811654; Fri,
 12 Jan 2024 01:30:11 -0800 (PST)
Date: Fri, 12 Jan 2024 15:00:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240112093006.2832105-1-ajayagarwal@google.com>
Subject: [PATCH v5] PCI: dwc: Wait for link up only if link is started
From: Ajay Agarwal <ajayagarwal@google.com>
To: Jingoo Han <jingoohan1@gmail.com>, Johan Hovold <johan+linaro@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>, 
	William McVicker <willmcvicker@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"

In dw_pcie_host_init() regardless of whether the link has been
started or not, the code waits for the link to come up. Even in
cases where start_link() is not defined the code ends up spinning
in a loop for 1 second. Since in some systems dw_pcie_host_init()
gets called during probe, this one second loop for each pcie
interface instance ends up extending the boot time.

Wait for the link up in only if the start_link() is defined.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
v4 was applied, but then reverted. The reason being v4 added a
regression on some products which expect the link to not come up as a
part of the probe. Since v4 returned error from dw_pcie_wait_for_link
check, the probe function of these products started to fail.

Changelog since v4:
 - Do not return error from dw_pcie_wait_for_link check

 .../pci/controller/dwc/pcie-designware-host.c | 12 +++++++----
 drivers/pci/controller/dwc/pcie-designware.c  | 20 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7991f0e179b2..e53132663d1d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -487,14 +487,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_remove_edma;
 
-	if (!dw_pcie_link_up(pci)) {
+	if (dw_pcie_link_up(pci)) {
+		dw_pcie_print_link_status(pci);
+	} else {
 		ret = dw_pcie_start_link(pci);
 		if (ret)
 			goto err_remove_edma;
-	}
 
-	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
+		if (pci->ops && pci->ops->start_link) {
+			/* Ignore errors, the link may come up later */
+			dw_pcie_wait_for_link(pci);
+		}
+	}
 
 	bridge->sysdata = pp;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b85..c067d2e960cf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -645,9 +645,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
 	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
 }
 
-int dw_pcie_wait_for_link(struct dw_pcie *pci)
+void dw_pcie_print_link_status(struct dw_pcie *pci)
 {
 	u32 offset, val;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
+
+	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
+		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
+		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
+}
+
+int dw_pcie_wait_for_link(struct dw_pcie *pci)
+{
 	int retries;
 
 	/* Check if the link is up or not */
@@ -663,12 +674,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		return -ETIMEDOUT;
 	}
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
-
-	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
-		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
-		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
+	dw_pcie_print_link_status(pci);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 55ff76e3d384..164214a7219a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -447,6 +447,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
+void dw_pcie_print_link_status(struct dw_pcie *pci);
 
 int dw_pcie_suspend_noirq(struct dw_pcie *pci);
 int dw_pcie_resume_noirq(struct dw_pcie *pci);
-- 
2.43.0.381.gb435a96ce8-goog


