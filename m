Return-Path: <linux-pci+bounces-5219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6A488D67A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 07:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D627B231D1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 06:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEE9225D6;
	Wed, 27 Mar 2024 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w+ISqc2B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8B623748
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521408; cv=none; b=UfUatsXJ1SVZ05/6j3F5A/9HhRlVRsC0SwQgMx22j2JRGMvTdbZcmG+sosr1QYLG/B6INyQzsnwkmlzlyIKm2jWvxTpiylgjUMxoAq7tcYL418X+wwG0RAyv3hqvpqMHDni3Z7et/Xn/B0lxAPoc3Z2+NnU9usbhIw9Ou+4pwpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521408; c=relaxed/simple;
	bh=DDCZoLHduZCUgXgmwVWPg1p7qsh6fab55IAmfI5Ain8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RZWTjCWJZmXlwsLB9xgDBAiuoYg5kRPVhy0b0KXtqudQvZGl2vRk44/CfXzaVGkqJJgVOl1FV7CDnpJslf08ec8XPjO7FZd87PejWvhFv/7joBzSc9Jt+z7jwqVQQdsVMo+cgJDbzx+RVVVA0jEvm/8kKusSLnvNWwnYIBQPvUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w+ISqc2B; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e034607879so50652265ad.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 23:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711521405; x=1712126205; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ms4/cCoO9t4kQQ5ANCu4uj6Ldb1VzG42n8OC1+sLfgU=;
        b=w+ISqc2BM4pE2OfOpLn4uuYcy82HnQyzVup/P60CYCHjYNeTZf8IIoQ+vnnT93t8KE
         Qmy182cNWCy1FTQSUNMJJbO1WIVDuP4E6pR7wGzXQhYR7UFpf9eF+hI+eJcLj7/wMPwF
         H5B9G7HfrZROMusiWlO/j5PLxucwHZVM05Uewu9eGjouqxR3DRHP4HXaJhhcckTnSLBp
         4HY5IXVKdZNv9GLnPS7A8jpNtai7kPR4VFURZ26VXdyhSE+KxAsdjmjeISNYTBdthmmi
         GRbqh7Trm5Zy7xrxiQh+cPnaxPZfrKSIu8GIutsv/CiJn4BlSwCZ2th5+AGmzrqqR193
         uJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711521405; x=1712126205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ms4/cCoO9t4kQQ5ANCu4uj6Ldb1VzG42n8OC1+sLfgU=;
        b=dfwQ2LBipCmptYIPGdrWcmmBofnK9BNrQv+G8CSMWr38Ergs8Nqg3f2FFiNszymSoJ
         JO+K1xA/w+ekNuw+aDP085ZPOAtjJUuem/kbKFF4hvhMPjtTFjEPnv+flmoc6lE7aDZ9
         ZpTvVK31MyH1PDX1V30njmnGbrT9w8lgviECczhKAx40CSHD5DA0mR1QAEQCMvEK6W12
         vD0zkKu97ynPQkifG8K5ItQNeAgj5BO/s3qo57qOnB8g6YZV1KRWGcLoWnS1Wfh/BUTC
         r4Cu+dspJgSzlYdN2VVcz16Ab5qnWN5JSYX3Wpfk4NgOmy+hYdJEUP/cSaraehY9/Q2a
         PdOw==
X-Gm-Message-State: AOJu0YwKerN51PNU4RMrj3/7G9C895kzebYAwxGjg77UCygQNReCEwD9
	lzaRkYpwc3F+olZgq23Ni2Qb4Y9be4JFsnli6e2+JM6SJ1B25usT3JogayT4Iw==
X-Google-Smtp-Source: AGHT+IGfb/5qpheudJAFQDoQ+Y66yU71tsgjR+uPsTCQEqq4JR9dsREPelKP5MBglXDbwKKL8InnkA==
X-Received: by 2002:a17:902:f707:b0:1e0:2344:e8fa with SMTP id h7-20020a170902f70700b001e02344e8famr507533plo.66.1711521404473;
        Tue, 26 Mar 2024 23:36:44 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id r9-20020a170902be0900b001e14807c7dfsm602553pls.86.2024.03.26.23.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 23:36:43 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 27 Mar 2024 12:05:47 +0530
Subject: [PATCH v11 1/8] PCI: dwc: ep: Fix DBI access failure for drivers
 requiring refclk from host
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-pci-dbi-rework-v11-1-6f5259f90673@linaro.org>
References: <20240327-pci-dbi-rework-v11-0-6f5259f90673@linaro.org>
In-Reply-To: <20240327-pci-dbi-rework-v11-0-6f5259f90673@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Kishon Vijay Abraham I <kishon@ti.com>, Vidya Sagar <vidyas@nvidia.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
 Roy Zang <roy.zang@nxp.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Srikanth Thokala <srikanth.thokala@intel.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 Niklas Cassel <cassel@kernel.org>, linux-arm-kernel@axis.com, 
 linux-rockchip@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=7480;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=DDCZoLHduZCUgXgmwVWPg1p7qsh6fab55IAmfI5Ain8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmA75VejBfr07ROuibuxbZqYO8QEep5hEFy1PLd
 iQo+IXhdMqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgO+VQAKCRBVnxHm/pHO
 9dHbB/4pmhskP37BwSxqMzzmK2lo7rBUUac8PcmWoW8wwynl21raO/S4FPL7awE92Kf/WrDW9BR
 RZvUM9Z4LMenjrVKVui+wJ6/tXWnQ+OJAeMwrj/Yz1GsRPwAEAUvkAMg+StfG2iV93wlJTBUanW
 arD6jN7mVq4BqqBzlVqTWlsen0TVvepRtKLV0AyM/797EF5q1s46EdEJiVrA/B9ld+hUV+yc4+H
 7fbrLIoiKbMxJ3DzLmoLHrI+Xkw/bIOdJDr5Sej93a5n2mLLQqKRLhm/Wt+/flW0zD7h1E7MpsG
 I8lAs1e/d+QJDIVXKO1XqFNTIZfS7zW6wx+IgFuCMfjw6Y4Y
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

The DWC glue drivers requiring an active reference clock from the PCIe host
for initializing their PCIe EP core, set a flag called 'core_init_notifier'
to let DWC driver know that these drivers need a special attention during
initialization. In these drivers, access to the hw registers (like DBI)
before receiving the active refclk from host will result in access failure
and also could cause a whole system hang.

But the current DWC EP driver doesn't honor the requirements of the drivers
setting 'core_init_notifier' flag and tries to access the DBI registers
during dw_pcie_ep_init(). This causes the system hang for glue drivers such
as Tegra194 and Qcom EP as they depend on refclk from host and have set the
above mentioned flag.

To workaround this issue, users of the affected platforms have to maintain
the dependency with the PCIe host by booting the PCIe EP after host boot.
But this won't provide a good user experience, since PCIe EP is _one_ of
the features of those platforms and it doesn't make sense to delay the
whole platform booting due to PCIe requiring active refclk.

So to fix this issue, let's move all the DBI access from
dw_pcie_ep_init() in the DWC EP driver to the dw_pcie_ep_init_complete()
API. This API will only be called by the drivers setting
'core_init_notifier' flag once refclk is received from host. For the rest
of the drivers that gets the refclk locally, this API will be called
within dw_pcie_ep_init().

Fixes: e966f7390da9 ("PCI: dwc: Refactor core initialization code for EP mode")
Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 120 ++++++++++++++----------
 1 file changed, 71 insertions(+), 49 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b..c05304eabb89 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -602,11 +602,16 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
 int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *ep_func;
+	struct device *dev = pci->dev;
+	struct pci_epc *epc = ep->epc;
 	unsigned int offset, ptm_cap_base;
 	unsigned int nbars;
 	u8 hdr_type;
+	u8 func_no;
+	int i, ret;
+	void *addr;
 	u32 reg;
-	int i;
 
 	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
 		   PCI_HEADER_TYPE_MASK;
@@ -617,6 +622,58 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 		return -EIO;
 	}
 
+	dw_pcie_version_detect(pci);
+
+	dw_pcie_iatu_detect(pci);
+
+	ret = dw_pcie_edma_detect(pci);
+	if (ret)
+		return ret;
+
+	if (!ep->ib_window_map) {
+		ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
+						       GFP_KERNEL);
+		if (!ep->ib_window_map)
+			goto err_remove_edma;
+	}
+
+	if (!ep->ob_window_map) {
+		ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
+						       GFP_KERNEL);
+		if (!ep->ob_window_map)
+			goto err_remove_edma;
+	}
+
+	if (!ep->outbound_addr) {
+		addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
+				    GFP_KERNEL);
+		if (!addr)
+			goto err_remove_edma;
+		ep->outbound_addr = addr;
+	}
+
+	for (func_no = 0; func_no < epc->max_functions; func_no++) {
+
+		ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
+		if (ep_func)
+			continue;
+
+		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
+		if (!ep_func)
+			goto err_remove_edma;
+
+		ep_func->func_no = func_no;
+		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
+							      PCI_CAP_ID_MSI);
+		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
+							       PCI_CAP_ID_MSIX);
+
+		list_add_tail(&ep_func->list, &ep->func_list);
+	}
+
+	if (ep->ops->init)
+		ep->ops->init(ep);
+
 	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
 	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
 
@@ -651,14 +708,17 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
+
+err_remove_edma:
+	dw_pcie_edma_remove(pci);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
 
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	int ret;
-	void *addr;
-	u8 func_no;
 	struct resource *res;
 	struct pci_epc *epc;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -666,7 +726,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
 	const struct pci_epc_features *epc_features;
-	struct dw_pcie_ep_func *ep_func;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -684,26 +743,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ep->ops->pre_init)
 		ep->ops->pre_init(ep);
 
-	dw_pcie_version_detect(pci);
-
-	dw_pcie_iatu_detect(pci);
-
-	ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
-					       GFP_KERNEL);
-	if (!ep->ib_window_map)
-		return -ENOMEM;
-
-	ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
-					       GFP_KERNEL);
-	if (!ep->ob_window_map)
-		return -ENOMEM;
-
-	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
-			    GFP_KERNEL);
-	if (!addr)
-		return -ENOMEM;
-	ep->outbound_addr = addr;
-
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
 		dev_err(dev, "Failed to create epc device\n");
@@ -717,23 +756,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ret < 0)
 		epc->max_functions = 1;
 
-	for (func_no = 0; func_no < epc->max_functions; func_no++) {
-		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
-		if (!ep_func)
-			return -ENOMEM;
-
-		ep_func->func_no = func_no;
-		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
-							      PCI_CAP_ID_MSI);
-		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
-							       PCI_CAP_ID_MSIX);
-
-		list_add_tail(&ep_func->list, &ep->func_list);
-	}
-
-	if (ep->ops->init)
-		ep->ops->init(ep);
-
 	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
 			       ep->page_size);
 	if (ret < 0) {
@@ -749,25 +771,25 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		goto err_exit_epc_mem;
 	}
 
-	ret = dw_pcie_edma_detect(pci);
-	if (ret)
-		goto err_free_epc_mem;
-
 	if (ep->ops->get_features) {
 		epc_features = ep->ops->get_features(ep);
 		if (epc_features->core_init_notifier)
 			return 0;
 	}
 
+	/*
+	 * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
+	 * step as platforms that implement 'core_init_notifier' feature may
+	 * not have the hardware ready (i.e. core initialized) for access
+	 * (Ex: tegra194). Any hardware access on such platforms result
+	 * in system hang.
+	 */
 	ret = dw_pcie_ep_init_complete(ep);
 	if (ret)
-		goto err_remove_edma;
+		goto err_free_epc_mem;
 
 	return 0;
 
-err_remove_edma:
-	dw_pcie_edma_remove(pci);
-
 err_free_epc_mem:
 	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
 			      epc->mem->window.page_size);

-- 
2.25.1


