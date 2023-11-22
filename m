Return-Path: <linux-pci+bounces-94-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6427F3DDE
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD2C1C20F18
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FC915ADB;
	Wed, 22 Nov 2023 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeLnAMmk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF33156FC
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EB1C433C9;
	Wed, 22 Nov 2023 06:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633064;
	bh=JDHVvhCp94Z+2IcU/uhcMeYkRhBQHpTa/i6l/Hz5xSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WeLnAMmkIeBJ0GMtBq266UJnLTVmiaX4hgr1XT4Pi+SWCh8Z04eOGN8xyz+UtNEFo
	 HSkBhkIGcIzV8qSvCEYwzoTZ98P7VmID1sWcVfMJQOCleBYaLBGWVEWsUbeeI8XyuA
	 lqlCvnYPhXXcQMRRtHQt1uSUCbbE3MNkITKUWQ5ioRl9X8iBQcowPKcQjvc9EPdS6d
	 B2DW+tsIeMjNT71SRFgyVLgOUQHBFp37lwL4tQtDcSMetAVjtR3IdR289bpIaQ+NU4
	 9FIscEWTVZRYPIK3yCJLUxpP5oWYeeFdRCD7qpiEEgRQwePPh1WG7vUF6OFj5bfl5P
	 AHdFNF1xsbrkw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 09/16] PCI: dwc: Rename dw_pcie_ep_raise_legacy_irq()
Date: Wed, 22 Nov 2023 15:03:59 +0900
Message-ID: <20231122060406.14695-10-dlemoal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the function dw_pcie_ep_raise_legacy_irq() of the Designware
endpoint controller driver to dw_pcie_ep_raise_intx_irq() to match the
name of the PCI_IRQ_INTX macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c             | 2 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c    | 2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 6 +++---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h      | 4 ++--
 drivers/pci/controller/dwc/pcie-qcom-ep.c         | 2 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a5365ab8897e..f117ec286a76 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1064,7 +1064,7 @@ static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	switch (type) {
 	case PCI_IRQ_INTX:
-		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
+		return dw_pcie_ep_raise_intx_irq(ep, func_no);
 	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	case PCI_IRQ_MSIX:
diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 5f78a9415286..9e7beb3ba09b 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -172,7 +172,7 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	switch (type) {
 	case PCI_IRQ_INTX:
-		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
+		return dw_pcie_ep_raise_intx_irq(ep, func_no);
 	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	case PCI_IRQ_MSIX:
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 87759c899fab..d8850b59094b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -496,16 +496,16 @@ static const struct pci_epc_ops epc_ops = {
 	.get_features		= dw_pcie_ep_get_features,
 };
 
-int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
+int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct device *dev = pci->dev;
 
-	dev_err(dev, "EP cannot trigger legacy IRQs\n");
+	dev_err(dev, "EP cannot raise INTX IRQs\n");
 
 	return -EINVAL;
 }
-EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_legacy_irq);
+EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
 
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 			     u8 interrupt_num)
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index c83968aa0149..27047e4c402a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -48,7 +48,7 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	switch (type) {
 	case PCI_IRQ_INTX:
-		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
+		return dw_pcie_ep_raise_intx_irq(ep, func_no);
 	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	case PCI_IRQ_MSIX:
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ffb9a62f3179..d55b28f3f156 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -580,7 +580,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
 void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
 void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
-int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
+int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no);
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 			     u8 interrupt_num);
 int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
@@ -613,7 +613,7 @@ static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
 {
 }
 
-static inline int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
+static inline int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
 {
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 2e5ab5fef310..71860e59cfce 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -732,7 +732,7 @@ static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	switch (type) {
 	case PCI_IRQ_INTX:
-		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
+		return dw_pcie_ep_raise_intx_irq(ep, func_no);
 	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	default:
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 25354a82674d..6be20359d9fe 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -368,7 +368,7 @@ static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	switch (type) {
 	case PCI_IRQ_INTX:
-		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
+		return dw_pcie_ep_raise_intx_irq(ep, func_no);
 	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	default:
-- 
2.42.0


