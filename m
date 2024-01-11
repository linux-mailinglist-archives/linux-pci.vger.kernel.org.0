Return-Path: <linux-pci+bounces-2061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EC482B1B3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 16:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C241F21B2B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDCC4C3D7;
	Thu, 11 Jan 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdaM+opE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D014BAB5
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e10c4fcso7742132276.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704986722; x=1705591522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dZy9tOinq1xQQqvzRrzHSuOcpy/Q+lSYh4VmR4W64MU=;
        b=gdaM+opE9JBhTIRKJoFy3nivlRq4aDO0kOTnxFl+WO4Gf0d4HrKdEH5c6WzX/HPcmc
         Wl0skATRQL56TA+2cmgs1nXAmWvdRulWQu4ETTyls2nf4LxJgMecO04HZeIZyA3ExdKc
         Hj6p46Qe9e8xRnKGX2oLzHlKvNl3lCP/nuo4eiYVnup1dGvq3actQYpfInuvE6owOpn2
         p8Pib7ck9PzSx0mFH3AqPl+MtUTviEbESlNC4ROTgN8rIYVit3PSBVTA688RNT9keRvE
         N0JIh/l+0n3E7AfiXrEuIbooC/hPorYZTrvgIBsbeoc6lRPaIRRmXl6nl2N9F6eXAiHC
         Azcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704986722; x=1705591522;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZy9tOinq1xQQqvzRrzHSuOcpy/Q+lSYh4VmR4W64MU=;
        b=AXnY6N6aFRdOjYZ2HJN7yrhUhVuPLDKbrZJX6ZRLkyePY0aAhmIneMM7rDynO+tu2K
         QIEjMzEPzggLJHG2XtHoxaP7uGf/ur01Q4iya6uoTu2xw1mhGyMC+/AVzVvaPTQ0GyVe
         qfeYrzS5/2Hr8Ka3CUWQopStotTaM/SSBTNkn5HfjwctKoJHOmN6XL5WTj5DGq+b3eRq
         3MLsvLXyd9Oeg8vOQF1eUK6hkpsyFQEGVV3vO9Jo6Asx7DPTW7hCTh8CzLg1ftuNwZv2
         hn+8/Eult3irTh6JY/nUInoUwsKfOCseBYuMPAv6GcTGLg3QWE0sT8a4t/VRfNUPoNdK
         T+iQ==
X-Gm-Message-State: AOJu0YxbMGXO4D5cASWnrRYofeyAV0ifli82+QCVTXoG+ueuu8vnAOVx
	vVUFLjJmXeUwdAgy1hk+gWruY22VxBptds7bilA945kI
X-Google-Smtp-Source: AGHT+IE8cdV/uHIVBX/XDAjVPLLZAemLrVLLTV0Zouy7GVebrTe3KxyJQPeSW28jmOdDJ1w2sfZuZEFrOojhO9HztA==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a05:6902:a02:b0:dbd:b6cd:92cf with
 SMTP id cb2-20020a0569020a0200b00dbdb6cd92cfmr546551ybb.11.1704986722497;
 Thu, 11 Jan 2024 07:25:22 -0800 (PST)
Date: Thu, 11 Jan 2024 20:55:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111152517.1881382-1-ajayagarwal@google.com>
Subject: [PATCH] PCI: dwc: Wait for link up only if link is started
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
2.43.0.275.g3460e3d667-goog


