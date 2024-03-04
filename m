Return-Path: <linux-pci+bounces-4408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB586FD85
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 10:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0067F1F24818
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51F124B52;
	Mon,  4 Mar 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlnpOGKu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220473BB3E
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544273; cv=none; b=k1aBDRvqNTELQLu9crdiXBUxw+ybovVIVAt9H9JdAYfXsWJ/GZnu6GD5W2FD6JUHH+Fi9/a0ANTAB3fBksTRVA3TAC9hFUC8xVhi8ph80io4SLUaB1dhNIwrB/aYFHOv2DjpREe2snAl3eXJc10jF4k+fp+nakHKQNFdrdAyU3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544273; c=relaxed/simple;
	bh=WjZ4+mNCQcDtI3R3bog3jBOb0ktWOFeqYYk+qv8ZsXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/wqwOdCENCQXpgk2ASaVHV7Z+DbRLd/BVQz14blWNVIYhl55h8kH/dAN5erDcQAYsUGOBT3S4Vh0/ag3NyHlJf6szVlufQaXjnS/sKgJmvbcTjU8mC4TkHqIqsLteem/cTmDFxGw2m8z/Em7Xph+dh5l3ojhNuB//JA0jOPyN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jlnpOGKu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc9222b337so42261595ad.2
        for <linux-pci@vger.kernel.org>; Mon, 04 Mar 2024 01:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709544272; x=1710149072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKApz9irlhQK7YOF+8+xnE4LjbCpqvxzEctgkEdtmlY=;
        b=jlnpOGKuZgTQI8iR6CopRV/d6nhuW0mVIPElyA6yIAnjVH9Tth+mGEamDgXHc8hnHH
         BTo0T+4+eD9Kn0Sfd2TlziaTw/G96Zinyjr4jPdeiqOx5v34u3Z2XBBddt/QnAkjaOwd
         Hu97rEakLRJqLWl2Nv04BlXX9R+8eSvcoBe7wGko5aGjH7XNTm+SHheBuakGEUiW23kj
         dYRc81D2aeAqbiRi9nS/tPp9vQzUqyyZcQhEcuWwvr+1BU5jCkGJ1yVP24iAD19WvuKx
         5oo9JH8y/P1kp8pjHWMvLveZj5MNl/F3xhQzgip+/kq3ao4UpxPOG8PtVu6o382wsHfX
         aO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709544272; x=1710149072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKApz9irlhQK7YOF+8+xnE4LjbCpqvxzEctgkEdtmlY=;
        b=ORBvAMCxXhRmixu1IHbGq/K2t4IR4ouYWCNfB7Tv01vEAmgzJVtnySTj/siSgFU3y9
         KEKV34fD8qS28b80NHZ/C0fl7BMlbSgZd18qUIvt5HtmvXoOUEdgrnKIayvanPD57DAx
         kPduEcxCURnnpyuqHg3t2g7NwoDUWl7Qh+/UvEPCLqpR3byQ1YTAY52U8zLkJIwjn/fQ
         0VUKo/Rgne1XPUpF3lf+P4z9gA7m6rf/dnYt6Q022SYRNRsb81k63C2wCGyGWHKDmZIA
         OZCFnTLSuZu6k/j79gDsZgqq2OY1PWmyeR/R2d/ce3XkxXf+7+B5gjzHKUqjvGXuYB/4
         H/ow==
X-Gm-Message-State: AOJu0Yx8VF9s1Kf2GXtM+DcVDINvPN9+VXLUvmntfkYBPXVR+Fw+/yaR
	onpNWcwBVO80pmG71TGjB5Pst5KAjYU1Af1RcVnQg0YZnD7q6nrQk3/4fbBD+w==
X-Google-Smtp-Source: AGHT+IF4YTs2Kpu6fiTzAPwNlCcr4XDNQmr1k3fHuS6nfsdDSGwckiq/zFRGje4c6qjRF2yf2DBhGg==
X-Received: by 2002:a17:902:eac4:b0:1dc:90c0:1e9a with SMTP id p4-20020a170902eac400b001dc90c01e9amr8888988pld.64.1709544271681;
        Mon, 04 Mar 2024 01:24:31 -0800 (PST)
Received: from [127.0.1.1] ([117.202.187.165])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001dbb06b6138sm7996648plc.252.2024.03.04.01.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:24:31 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 04 Mar 2024 14:52:22 +0530
Subject: [PATCH v9 10/10] PCI: dwc: ep: Add Kernel-doc comments for APIs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-pci-dbi-rework-v9-10-29d433d99cda@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6415;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=WjZ4+mNCQcDtI3R3bog3jBOb0ktWOFeqYYk+qv8ZsXo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl5ZLZg8bOTT0oLqT2NyAJQTr9HfKYG39kFmtg5
 A8RDcaHmcWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZeWS2QAKCRBVnxHm/pHO
 9TY+B/0Xiw9hnMzcEVTeRvv8fKNAVavUTvd5zFLasDuEhWvi0JO11ciyRYx/3nt9Ja8JvlO0BvF
 h0r6OeL7IYvOCK4+Kwge1yDe6dgYffR3GliEE2SM4sQeWooBXVIG6+ZMbQIzKQibR6JIyQdHTXV
 G8VAyGwZrDSeRml2FSKFinvZtWDMJTDT2at/hXCDymbTPlt6GuNHQgS2JcYsZntzQ329z3O2js9
 Oiak6ntiveYiUp/0yD+uEUOD6+Xs+N1dlkMCyTtdn0XNdEnJsuElNOu5XmqT15+2CKbNdnX/c7u
 e8TKDLhkdT+mckGJbCwwrX3aJWMus/GGWoKLqsrN0DJJVSA2
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

All of the APIs are missing the Kernel-doc comments. Hence, add them.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 94 +++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index fed4c2936c78..1f33f2929c2b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -14,6 +14,11 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 
+/**
+ * dw_pcie_ep_init_notify - Notify EPF drivers about EPC initialization
+ *			    complete
+ * @ep: DWC EP device
+ */
 void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
 {
 	struct pci_epc *epc = ep->epc;
@@ -22,6 +27,14 @@ void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
 
+/**
+ * dw_pcie_ep_get_func_from_ep - Get the struct dw_pcie_ep_func corresponding to
+ *				 the endpoint function
+ * @ep: DWC EP device
+ * @func_no: Function number of the endpoint device
+ *
+ * Return: struct dw_pcie_ep_func if success, NULL otherwise.
+ */
 struct dw_pcie_ep_func *
 dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 {
@@ -52,6 +65,11 @@ static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
+/**
+ * dw_pcie_ep_reset_bar - Reset endpoint BAR
+ * @pci: DWC PCI device
+ * @bar: BAR number of the endpoint
+ */
 void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 {
 	u8 func_no, funcs;
@@ -431,6 +449,13 @@ static const struct pci_epc_ops epc_ops = {
 	.get_features		= dw_pcie_ep_get_features,
 };
 
+/**
+ * dw_pcie_ep_raise_intx_irq - Raise INTx IRQ to the host
+ * @ep: DWC EP device
+ * @func_no: Function number of the endpoint
+ *
+ * Return: 0 if success, errono otherwise.
+ */
 int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -442,6 +467,14 @@ int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
 
+/**
+ * dw_pcie_ep_raise_msi_irq - Raise MSI IRQ to the host
+ * @ep: DWC EP device
+ * @func_no: Function number of the endpoint
+ * @interrupt_num: Interrupt number to be raised
+ *
+ * Return: 0 if success, errono otherwise.
+ */
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 			     u8 interrupt_num)
 {
@@ -490,6 +523,15 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_msi_irq);
 
+/**
+ * dw_pcie_ep_raise_msix_irq_doorbell - Raise MSIX to the host using Doorbell
+ *					method
+ * @ep: DWC EP device
+ * @func_no: Function number of the endpoint device
+ * @interrupt_num: Interrupt number to be raised
+ *
+ * Return: 0 if success, errno otherwise.
+ */
 int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,
 				       u16 interrupt_num)
 {
@@ -509,6 +551,14 @@ int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+/**
+ * dw_pcie_ep_raise_msix_irq - Raise MSIX to the host
+ * @ep: DWC EP device
+ * @func_no: Function number of the endpoint device
+ * @interrupt_num: Interrupt number to be raised
+ *
+ * Return: 0 if success, errno otherwise.
+ */
 int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 			      u16 interrupt_num)
 {
@@ -556,6 +606,14 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
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
 void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -564,6 +622,13 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
 
+/**
+ * dw_pcie_ep_deinit - Deinitialize the endpoint device
+ * @ep: DWC EP device
+ *
+ * Deinitialize the endpoint device. EPC device is not destroyed since that will
+ * taken care by Devres.
+ */
 void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
 {
 	struct pci_epc *epc = ep->epc;
@@ -635,6 +700,14 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
+/**
+ * dw_pcie_ep_init_registers - Initialize DWC EP specific registers
+ * @ep: DWC EP device
+ *
+ * Initialize the registers (CSRs) specific to DWC EP. This API should be called
+ * only when the endpoint receives an active refclk (either from host or
+ * generated locally).
+ */
 int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -718,6 +791,10 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_init_registers);
 
+/**
+ * dw_pcie_ep_linkup - Notify EPF drivers about link up event
+ * @ep: DWC EP device
+ */
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 {
 	struct pci_epc *epc = ep->epc;
@@ -726,6 +803,14 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
 
+/**
+ * dw_pcie_ep_linkdown - Notify EPF drivers about link down event
+ * @ep: DWC EP device
+ *
+ * Non-sticky registers are also initialized before sending the notification to
+ * the EPF drivers. This is needed since the registers need to be initialized
+ * before the link comes back again.
+ */
 void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -743,6 +828,15 @@ void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_linkdown);
 
+/**
+ * dw_pcie_ep_init - Initialize the endpoint device
+ * @ep: DWC EP device
+ *
+ * Initialize the endpoint device. Allocate resources and create the EPC
+ * device with the endpoint framework.
+ *
+ * Return: 0 if success, errno otherwise.
+ */
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	int ret;

-- 
2.25.1


