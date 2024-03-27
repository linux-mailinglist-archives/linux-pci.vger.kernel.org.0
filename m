Return-Path: <linux-pci+bounces-5239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDB988D9F5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 10:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442AF1C27881
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 09:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA8A36AFC;
	Wed, 27 Mar 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+fNR5jH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB54CE0F
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530904; cv=none; b=pwpbzRzUOjql4G9AmqXWvdBpPykgyK1UCmsTh8aL79CUxXKROaq4dH2yhJLaQMTnlKtpLZdcz9OZBUo31F1mfEiMli77W7r7kLLV2hw8RWXVotY9fl/rhupN4ZrA47JaxsSCUNXBJTns8XpWmxNDQ3ZeWZMa/Jn8CFnG/izFU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530904; c=relaxed/simple;
	bh=cYPmZhMWF9JrrdBXi4xoNK400WwuLP3vEJRvgS89ChI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EIaWglsu34NGZfYFPwxZb+TF12YTSZh83meswLWqcLqMBudi7sHTUO59zZ2gf/xOaDrhz/ihWpTiAEBgFyxwBiDAEBysjf85nma2aVWybiZbiBihqibE81ujFu/jTLsPSpVCic0T7MFLWT1zmyoYOyU5wxYqweJd5itu6Qn2DEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F+fNR5jH; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a128e202b6so2312712eaf.2
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711530901; x=1712135701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+w8+XZFFVZD9serrdKw4v46iT3fU34iMoHh0wJblC08=;
        b=F+fNR5jHGXqI7iB0nQg/3p6UgQ7b+L4ynULXLf6YKN412YlOWs0tnjyqkb9Jsh539b
         xTOhQzN38cbp0Equqe0p9fU7gTOGme8YvemGDFyQ7QzEJtfFJjlr6azq5i7Bx0Z/4LKq
         Ko8Ot6ZbQlf7YQM7CBWR6M44WPWW9ml4cQS+o2fmi3ZfAX/6ad8KmcBxd4TOAworNn44
         TGaUL+ShidfgbtV4KkayFd5pvLR6G676oitlfDvsVv9tJkMEslOpJ8J1KoSbsNP/u2xW
         A3TcznUfQm0j00t4k6EpwsudSoMhfhyT33nu0WQ0j7b/0+u574POIQh1QwTmKwu1wpRN
         fEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711530901; x=1712135701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w8+XZFFVZD9serrdKw4v46iT3fU34iMoHh0wJblC08=;
        b=qCePOSLty6iVtiIa8CCAvbjUx026adViJzc/fTHcubu7GRA6pW9BRcSU1TqQ+8VizK
         dX66NmsC7/TmrEmHZa13TgsGPyVixf8fCa+RfOGQfBhxPpFrrMus4GZDCr6OD+lFTdId
         MDU0yR+uQwVp5BUUUw0y/vfBtDxtsqttGvmWWmET7j0nGmTYwehjIyuQHuaPv59IBlJ2
         o7syuEQuyIWI1kNTFY0Sq65kVf2PFwh65N+jTP+ONmJ404DK+s4yIgVwfzRIOCn4UoQC
         GtO/lawvktBWrsJE6UOU+fFoyft1EZ1iipHGd+zJCFKE9C8RQTYeUqqvGbWLX8Fgrp18
         sRjQ==
X-Gm-Message-State: AOJu0YwP6xR6F60vd9khqVwCpy1GbuN2t+kpFN+Ilebh4Z0XdYCZceQ/
	2WvlZilgcCqN5GxrhFNfJjMEL+pwJYVlGpPYbUiLBVXfsgDu2LEGXvukzODWWw==
X-Google-Smtp-Source: AGHT+IG0gU1p3u2cZSNbNacouPypPMZacdlL/OD6GpxQGu1TYUYdgA72yNE40cxd7c52iaQO+ragyw==
X-Received: by 2002:a05:6358:7584:b0:17b:b559:2ba3 with SMTP id x4-20020a056358758400b0017bb5592ba3mr819971rwf.11.1711530900939;
        Wed, 27 Mar 2024 02:15:00 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.52.77])
        by smtp.gmail.com with ESMTPSA id h190-20020a6383c7000000b005dc4fc80b21sm8673871pge.70.2024.03.27.02.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 02:15:00 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 27 Mar 2024 14:43:34 +0530
Subject: [PATCH v12 5/8] PCI: dwc: ep: Introduce dw_pcie_ep_cleanup() API
 for drivers supporting PERST#
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-pci-dbi-rework-v12-5-082625472414@linaro.org>
References: <20240327-pci-dbi-rework-v12-0-082625472414@linaro.org>
In-Reply-To: <20240327-pci-dbi-rework-v12-0-082625472414@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, 
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
 Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 Niklas Cassel <cassel@kernel.org>, linux-arm-kernel@axis.com, 
 linux-rockchip@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4250;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=cYPmZhMWF9JrrdBXi4xoNK400WwuLP3vEJRvgS89ChI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmA+NJCy5UKQajgGLcJFCmTCocVuyMtWTlZ2Ejs
 QvYSXEZAl2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgPjSQAKCRBVnxHm/pHO
 9T6mB/9pFQquf5LOGTNXV2yHivElmVpYY5aK42tRZFhvZZ0Tq1cMStZlxIL1CLcpD/qAJJPoQS+
 yVJ9edDCykI7R6KmW+PI1NL5g3gievubaOlD4LHYQpXWT3eRl4G1adOoeFRaOnbqHWAkiKFRgwM
 APGy4NWJvEX5fEswTOaqdUIxHOR1D8QSfTpyiQjtc6sbN4hICqqYVM/nNy9qVHB543u9n0PPMK5
 mwWvNRApMkR5oCw9X9KChFW25uEjtpqUSGFHWzRJqYacYvkodK+xQuRVRbCraKJY/IJgSJouwp4
 NYITRCwxRHIPKRVUpx5qz/2wRe4F6MoptuTdyT8F6F+m+R/s
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

For DWC glue drivers supporting PERST# (currently Qcom and Tegra194), some
of the DWC resources like eDMA should be cleaned up during the PERST#
assert time.

So let's introduce a dw_pcie_ep_cleanup() API that could be called by these
drivers to cleanup the DWC specific resources. Currently, it just removes
eDMA.

Reported-by: Niklas Cassel <cassel@kernel.org>
Closes: https://lore.kernel.org/linux-pci/ZWYmX8Y%2F7Q9WMxES@x1-carbon
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 19 +++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h    |  5 +++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c       |  1 +
 drivers/pci/controller/dwc/pcie-tegra194.c      |  2 ++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index d87f7642d7f6..eeff7f1ff8f1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -619,6 +619,22 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+/**
+ * dw_pcie_ep_cleanup - Cleanup DWC EP resources after fundamental reset
+ * @ep: DWC EP device
+ *
+ * Cleans up the DWC EP specific resources like eDMA etc... after fundamental
+ * reset like PERST#. Note that this API is only applicable for drivers
+ * supporting PERST# or any other methods of fundamental reset.
+ */
+void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	dw_pcie_edma_remove(pci);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
+
 /**
  * dw_pcie_ep_deinit - Deinitialize the endpoint device
  * @ep: DWC EP device
@@ -628,10 +644,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
  */
 void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct pci_epc *epc = ep->epc;
 
-	dw_pcie_edma_remove(pci);
+	dw_pcie_ep_cleanup(ep);
 
 	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
 			      epc->mem->window.page_size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 61465203bb60..351d2fe3ea4d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -672,6 +672,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
 void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
 void dw_pcie_ep_deinit(struct dw_pcie_ep *ep);
+void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no);
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 			     u8 interrupt_num);
@@ -705,6 +706,10 @@ static inline void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
 {
 }
 
+static inline void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
+{
+}
+
 static inline int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
 {
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 36e5e80cd22f..59b1c0110288 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -507,6 +507,7 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
 		return;
 	}
 
+	dw_pcie_ep_cleanup(&pci->ep);
 	qcom_pcie_disable_resources(pcie_ep);
 	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
 }
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1f7b662cb8e1..26ea2f8313eb 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1715,6 +1715,8 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (ret)
 		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
 
+	dw_pcie_ep_cleanup(&pcie->pci.ep);
+
 	reset_control_assert(pcie->core_rst);
 
 	tegra_pcie_disable_phy(pcie);

-- 
2.25.1


