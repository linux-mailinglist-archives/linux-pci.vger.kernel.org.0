Return-Path: <linux-pci+bounces-3223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7F684D57C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 23:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD4B1F2B51C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D7B1384B4;
	Wed,  7 Feb 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLEAdqQ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C0612FF7D;
	Wed,  7 Feb 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342025; cv=none; b=GDwaeGyajn4pcpeiBhpcceHt2D5UG2IcwVJ/YFVXixjjVfpTiUfP3jigCh//VNxkMxPTfRimmRY1NiPgc1eEzfop6froW1AeDVGTM1qK4D6r1uUhJeldTR2BgalK9bIvi3DydGWP1FMTWELPuQA4tFP4K99ON8e1PD1UH8RRHhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342025; c=relaxed/simple;
	bh=7fxBm/u2hpuDrFKxyT9bbbVkeIk2RFIy8x4CrTkZ0IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJ5Iq9g0ykyLHrqKzMuLABM5Ew2aPizIWiuvfl/JKNMCD1R6XgVB+Nx2fGpT6L1OPU3oASiFwQoQrjRdR99laKCEz29Y8I7NOwacbxDzwha8T5T7U/34+bPBsD66pUNvgB86IC8h/6JvschAFvaxDqFTaMfDRzknVeFZJQFuZio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLEAdqQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10235C433F1;
	Wed,  7 Feb 2024 21:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707342025;
	bh=7fxBm/u2hpuDrFKxyT9bbbVkeIk2RFIy8x4CrTkZ0IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLEAdqQ3K80SAgWPWulLyIDYM6OpLTPdkqpTvk8iymqcsF9cLDVOZv67/iDvyn8xq
	 eNzExg3CQm2BX4xKjh8hqh5l+2epbZQdphfbAqfBtbgQBnGDHU6mc0D5Ivs6uKjXNO
	 +ZetRlloDLFyngqH+8Nm0i8VTFp+IkdK1/uXrJEB3cNx096Wz1Y17BRO/GpyfgTckK
	 MCkwkZag45y8pLhz1mEgqbD8AZKGHkoxWHy86m4T9+TywiCZc3fTd43t2ag6c42kpr
	 s7i8n+ujtDnqYCchea+hkHbmPLPLdnrBrl1MaNvmQ+XnfAakzcvl9uqrI+0T6bQ58W
	 uT0Qw0JieF8NQ==
From: Niklas Cassel <cassel@kernel.org>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/4] PCI: endpoint: refactor pci_epf_alloc_space()
Date: Wed,  7 Feb 2024 22:39:14 +0100
Message-ID: <20240207213922.1796533-2-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207213922.1796533-1-cassel@kernel.org>
References: <20240207213922.1796533-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor pci_epf_alloc_space() to take epc_features as a parameter.
This is a preparation patch needed for further cleanups.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 5 ++---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
 drivers/pci/endpoint/pci-epf-core.c           | 6 ++++--
 include/linux/pci-epf.h                       | 4 +++-
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 0553946005c4..43cd309ce22f 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -1067,7 +1067,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb,
 	else if (size < ctrl_size + spad_size)
 		return -EINVAL;
 
-	base = pci_epf_alloc_space(epf, size, barno, align, type);
+	base = pci_epf_alloc_space(epf, size, barno, epc_features, type);
 	if (!base) {
 		dev_err(dev, "%s intf: Config/Status/SPAD alloc region fail\n",
 			pci_epc_interface_string(type));
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 18c80002d3bd..15bfa7d83489 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -848,7 +848,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	}
 
 	base = pci_epf_alloc_space(epf, test_reg_size, test_reg_bar,
-				   epc_features->align, PRIMARY_INTERFACE);
+				   epc_features, PRIMARY_INTERFACE);
 	if (!base) {
 		dev_err(dev, "Failed to allocated register space\n");
 		return -ENOMEM;
@@ -866,8 +866,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 			continue;
 
 		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
-					   epc_features->align,
-					   PRIMARY_INTERFACE);
+					   epc_features, PRIMARY_INTERFACE);
 		if (!base)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index e75a2af77328..ba509d67188b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -446,7 +446,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	else if (size < ctrl_size + spad_size)
 		return -EINVAL;
 
-	base = pci_epf_alloc_space(epf, size, barno, align, 0);
+	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
 	if (!base) {
 		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
 		return -ENOMEM;
@@ -550,7 +550,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 
 	barno = ntb->epf_ntb_bar[BAR_DB];
 
-	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
+	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
 	if (!mw_addr) {
 		dev_err(dev, "Failed to allocate OB address\n");
 		return -ENOMEM;
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 2c32de667937..1d405fd61a2a 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -251,14 +251,16 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
  * @epf: the EPF device to whom allocate the memory
  * @size: the size of the memory that has to be allocated
  * @bar: the BAR number corresponding to the allocated register space
- * @align: alignment size for the allocation region
+ * @epc_features: the features provided by the EPC specific to this EPF
  * @type: Identifies if the allocation is for primary EPC or secondary EPC
  *
  * Invoke to allocate memory for the PCI EPF register space.
  */
 void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
-			  size_t align, enum pci_epc_interface_type type)
+			  const struct pci_epc_features *epc_features,
+			  enum pci_epc_interface_type type)
 {
+	size_t align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 77b146e0f672..adee6a1b35db 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 
 struct pci_epf;
+struct pci_epc_features;
 enum pci_epc_interface_type;
 
 enum pci_barno {
@@ -216,7 +217,8 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
 			      struct module *owner);
 void pci_epf_unregister_driver(struct pci_epf_driver *driver);
 void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
-			  size_t align, enum pci_epc_interface_type type);
+			  const struct pci_epc_features *epc_features,
+			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
 int pci_epf_bind(struct pci_epf *epf);
-- 
2.43.0


