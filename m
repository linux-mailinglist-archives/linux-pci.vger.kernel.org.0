Return-Path: <linux-pci+bounces-23856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A35FA6324E
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 21:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F641896E43
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 20:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9261A9B28;
	Sat, 15 Mar 2025 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CizdI21k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6C198831;
	Sat, 15 Mar 2025 20:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742069761; cv=none; b=WmAJYOTprd6ay1vmE43jvv9wqwT0SMekbsV1yUrto4vO1Dv3rbTrY+1pHkHM9Jg0bgrbNQKnD/Aj9ChGB/DgRBWqAiT7WlIpuVNJL/Jh+6kQyb/280GLo4iGUDB/YikrmHd3b/wuhdDBQZ78cPM91rmTXhnv5Bd9/gGgNYwEBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742069761; c=relaxed/simple;
	bh=UQ59zv9FuaqX9nZDy1KqpQxejNQdEppJ2cczOe71XF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rx6NOKh8iIaO9AaR+UjPWArdQWUoI5J2K8j7ABGvBNdCJ+Hnr+vOj4Hqyx2ZGYmhTWMN+HtiZ3nfyzhktR+VJupaKuFHyHGed6GYYYfxwW9Ntv2bbIkPZaNqZ9GdiqhJsH09xSJzp58LqJ2Jro37ocdJvNfPj611CHBXabPF+U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CizdI21k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76520C4CEE5;
	Sat, 15 Mar 2025 20:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742069760;
	bh=UQ59zv9FuaqX9nZDy1KqpQxejNQdEppJ2cczOe71XF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CizdI21kCtv5eit8m4INMznvOqkXezGWSbe6h7pQUBBhLuNPA935WXkxxavRCLAUs
	 ezUatl5+zp8Zcged/GR2MnT7ol/xmlRmOfl0Mql76Bz/eDmCp9UDOAS4KhjLHINsIB
	 Ry7314Du3l6g3Hdk6lowrsAmPWsgdvZeCUqYeY7XtLTjD7/VB4JesE8cCpwOW3XX+k
	 A2JpHxLj/COP/2laWlwkm+QcLUH3uPAzgV4SIQqY70q8+wmm/sxV86Nga3gm5+HX6X
	 lw/DDGN1Szdp39qR6zV8n6m/IYlCz5drnN09ueOvLzn+tYvnvFokOhBvldtI/8WmUR
	 DFzkKul4Lnllw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 03/13] PCI: dwc: Call devm_pci_alloc_host_bridge() early in dw_pcie_host_init()
Date: Sat, 15 Mar 2025 15:15:38 -0500
Message-Id: <20250315201548.858189-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250315201548.858189-1-helgaas@kernel.org>
References: <20250315201548.858189-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

Move devm_pci_alloc_host_bridge() to the beginning of dw_pcie_host_init().

devm_pci_alloc_host_bridge() is generic code that doesn't depend on any DWC
resource, so moving it earlier keeps all the subsequent devicetree-related
code together.

[bhelgaas: reorder earlier in series]
Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-4-01d2313502ab@nxp.com
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 1206b26bff3f..5636243fb90e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -431,6 +431,12 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	raw_spin_lock_init(&pp->lock);
 
+	bridge = devm_pci_alloc_host_bridge(dev, 0);
+	if (!bridge)
+		return -ENOMEM;
+
+	pp->bridge = bridge;
+
 	ret = dw_pcie_get_resources(pci);
 	if (ret)
 		return ret;
@@ -448,12 +454,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (IS_ERR(pp->va_cfg0_base))
 		return PTR_ERR(pp->va_cfg0_base);
 
-	bridge = devm_pci_alloc_host_bridge(dev, 0);
-	if (!bridge)
-		return -ENOMEM;
-
-	pp->bridge = bridge;
-
 	/* Get the I/O range from DT */
 	win = resource_list_first_type(&bridge->windows, IORESOURCE_IO);
 	if (win) {
-- 
2.34.1


