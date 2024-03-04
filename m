Return-Path: <linux-pci+bounces-4401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507DF86FD3C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 10:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EB21C225E4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F72520323;
	Mon,  4 Mar 2024 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DHzDLm6S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E12225DA
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544200; cv=none; b=HqzbwYCN+Zh5htfB4MKxJpzqyFaH1inUXDwJ0hf5E/qVYAxsYEEBMdVZJuOyOWIVeFur74DthevbR/CImjSlnwPlsuiCSvBuQBxXs/+P3gjEgCtA7bdRbJRaduVl1e/Yx1DBFCVJ2yLADytKaWOPe/kpZKxK2Pe3nSCvC/U6oj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544200; c=relaxed/simple;
	bh=ypYDM92zx+ByY0T7WnwufvgR277d6q8zr4H0b9YIwoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uA0lTt6Ksfs4uThEtT6TZMYZH/ZE/+oXj26C7RJOAH1GbCCHuGRSQp+3+UCXQpI5TvAjHfu8GD4Pr94pTVjYgxULeWN3Ucoe62oWQAPJHonqyXOCPkp1fvJ7lvdGPUzwJSMkOmI8Adl/ko4+q2VwkqzqEkNVLEsw+JXByOuA+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DHzDLm6S; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8b519e438so3977201a12.1
        for <linux-pci@vger.kernel.org>; Mon, 04 Mar 2024 01:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709544198; x=1710148998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iAAKsut+Lnr406fDiuI97iuObX28NmTfTZPzkL+1fo=;
        b=DHzDLm6SdRCdzBz4MakgqG3S6HDtPxZLRw1nWF0UbicgCxu5P37Cod6/S+0/jvOJtj
         ftsA8ycZ+vm+p8INHIA+rt0SlGqvCm6y8BTwTAgRE1AC+c2dnPxJEJP90/yMmxrrppnm
         baUAlDJQOv/v9j1rEoWGdTAC/de3nMOgD8voG/a3+hdT2ydaVqGnPoLzRCOZCYLRCPpM
         c1YCdn9m0cfRGJ4p2eG61LkKmPzeIjSvXwRGpP6MoLII5CdOzofFhKI1iFZKPiTEv0FG
         BEHKcB8maWtbfXFTgw8fpO40l3LwKcWxUcU/AyIEEcmJwfwas/U4yIu4yCVthcTwgCVs
         8xPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709544198; x=1710148998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iAAKsut+Lnr406fDiuI97iuObX28NmTfTZPzkL+1fo=;
        b=FOZPZMsJylvL5rmcQx3esGO14fw5M+GE/7Re6Fi+99uoJU2JyYqUp4JYS4PPyVDMIl
         G3KD+1sv08Ngp1odDb7CYx0FiaqY5L/zv9nkVfcq7DUS/816WlVYJQg6QL7lCt6fuA+a
         O6MoSEcvgg30ij2y/d73oHDTGwaITgtbvENA5zUZUkiLgrvAI8NBzV+XBk5DPSYIG3Tq
         6lYGfHeDg+G5OvjYNWVZFmibh6wPQVXf1wb9xqU1tUWTA/DoYg+PmhSNswnc+1UXit+O
         Qw2+CkmieTOElOfrQP8z4rQ14p9P5tKPqoADE7dXpGp5Op0Mp4GTsi7cGORp8WV0Sq6m
         IUdA==
X-Gm-Message-State: AOJu0Yw7sONGSTTNFdLoF/kQnDwMDLv7PdUV9rEcfM3MOAbpJaa6B7sP
	0GrlVR/sB9676OAL/Dlbkza7cRpxh4feFpwkX2duKUgR5LwSzTK4Mg37w40MiQ==
X-Google-Smtp-Source: AGHT+IGgKnmiFQobeMh2YTWAxlSLgx0/pU4aP23F9C12AqEGAOggZ8ib8OKjkD4YAlDCeDhLjLF+FQ==
X-Received: by 2002:a05:6a20:4f91:b0:1a1:4a97:c2bf with SMTP id gh17-20020a056a204f9100b001a14a97c2bfmr2180987pzb.38.1709544197821;
        Mon, 04 Mar 2024 01:23:17 -0800 (PST)
Received: from [127.0.1.1] ([117.202.187.165])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001dbb06b6138sm7996648plc.252.2024.03.04.01.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:23:17 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 04 Mar 2024 14:52:15 +0530
Subject: [PATCH v9 03/10] PCI: dwc: ep: Introduce dw_pcie_ep_cleanup() API
 for drivers supporting PERST#
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-pci-dbi-rework-v9-3-29d433d99cda@linaro.org>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
In-Reply-To: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
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
 Srikanth Thokala <srikanth.thokala@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 Niklas Cassel <cassel@kernel.org>, linux-arm-kernel@axis.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3682;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=ypYDM92zx+ByY0T7WnwufvgR277d6q8zr4H0b9YIwoo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl5ZLXx8mL4OCigKAtsTSBN5DEBwsyik+wZ/JB4
 La0Ju5zCXGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZeWS1wAKCRBVnxHm/pHO
 9VloCACPrI8Hr2htGt2mk5PgpFmGydL8nF02RLuxbzk867sLalnQnopNSdlBgv+prE7meJI+5sC
 iasOG4gXUO03I/Oyf6FQRtVvBtIDO4p3+QpgV4PXzIXmRxKvVsTfbnFPdKLPvINV+iiMk75fOmL
 +libQ1tupUQQwAwjaNXiLnUbEJrvK0qyDZsPVmebFDRlRDNEhDTz1d3ANBUuTOl1Wosc6QBpDDg
 8C8GDvJpbdbo7paCLVTDSTw9/Fq0nvwx8zZaC0RDeYTb/2qFb/uFL3EFTWfmytI7tucLvRwkigg
 YJv5KU0bD1RU56bbRN47G1CNoplP33MCsI6YbE+lWtWj2Q1X
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
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 11 +++++++++--
 drivers/pci/controller/dwc/pcie-designware.h    |  5 +++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c       |  1 +
 drivers/pci/controller/dwc/pcie-tegra194.c      |  2 ++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 2b11290aab4c..1205bfba8310 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -564,12 +564,19 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
-void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
+void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	struct pci_epc *epc = ep->epc;
 
 	dw_pcie_edma_remove(pci);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
+
+void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
+{
+	struct pci_epc *epc = ep->epc;
+
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
index 7afa9e9aabe2..68bfeed3429b 100644
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


