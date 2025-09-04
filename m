Return-Path: <linux-pci+bounces-35447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D816B43C0B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 14:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C135A40AD
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC9B2FE584;
	Thu,  4 Sep 2025 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIjEH50L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A7A2FE565
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990134; cv=none; b=A7OmfFgzYebE3TBis99N8QB4NPofmTxu037XRBc2ojqbh968ucpXmeELmHiK+ebX7nRjYcHHL9OTP18oHQcex1Xx44uNWBuqI1ace6SIGy/jCuioEBpC2dc8JkK3Tcuw60JhPJ8/zzjQCXZ+t/nTmODAkQeQT9meswrZJgE1BJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990134; c=relaxed/simple;
	bh=DJlw4rE8LhEOLISeLuWVApOZLjTFb/l7mXqvArlRGMA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Uo2vrPuZNH2dDauAgho9i0/fmXpzX3ghN0VsTylJ4O+pGZ/QjUfj/kgC8BFJlFMhcClym79rtgTMdJkvBBdmX+LjzBr6h2DlltjzpzsUUzqt4wHRR0tvJAtN3FSnHbtPff6DRKBOIUZxTBuTw1/RnmSJ3tIg3shVRrRNKZRTygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIjEH50L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDBCC4CEF1;
	Thu,  4 Sep 2025 12:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756990133;
	bh=DJlw4rE8LhEOLISeLuWVApOZLjTFb/l7mXqvArlRGMA=;
	h=Date:From:To:Cc:Subject:From;
	b=sIjEH50LglJhP+ed8ErJWfP4GsW/V3YtxCSV06fsM6UZulaNXb6AePQFEOFKDju1m
	 oJ9V4AQ5VV0XlMDMj69TKM4NEU0L+Ga2ilM5nYn0aQmBGugBKyc4rbm81eegx7Ugdq
	 t+dGbTf/FakcVZgLvFBjxqNL4KGhG6rz+vwyVFL7QqS+SlmlTt3nvT+djTT/n5tHSc
	 qqPeCC1bHbgt9Bv/8gsvff7FuXKaClijW44Hr9eMBxCL51JSoUqFKViohMyY94Xbik
	 25fBdipmeJ1473SUmCq9UQyFcaRkVCXu+jy3dzqgNhNdqm7XcdsbLKuIUbI69RCvBF
	 1Yhuz7CFXBY/w==
Date: Thu, 4 Sep 2025 14:48:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: DWC PCIe eDMA irqs
Message-ID: <aLmKsp7VWBdMcM5p@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Mani,


Looking at dw_pcie_edma_irq_verify()
https://github.com/torvalds/linux/blob/v6.17-rc4/drivers/pci/controller/dwc/pcie-designware.c#L1048-L1049

We can see that it does an early return if "pci->edma.nr_irqs == 1".

I.e. if the glue driver has set "pci->edma.nr_irqs == 1", we never even
bother to fetch "dma"/"dmaX" from device tree.

This suggests that we support a single IRQ for all eDMA channels,
and since we don't even parse anything for DT, it suggests that this
IRQ could be the same IRQ as the "sys IRQ" for the PCI controller.
(E.g. tegra has a single IRQ for the PCI controller and the eDMA.)



However, looking at dw_pcie_edma_irq_vector(), which will be called by
dw_edma_probe():
https://github.com/torvalds/linux/blob/v6.17-rc4/drivers/pci/controller/dwc/pcie-designware.c#L945-L947

We can see that we need either "dma" or "dmaX" in DT.

Which suggests that the code currently only supports either a
separate IRQ for each eDMA per channel, or a combined IRQ for
each eDMA channel, but the combined IRQ cannot be the same as
the "sys IRQ".


This seems inconsistent to me.

Since dw_pcie_edma_irq_vector() requires either "dma" or "dmaX" in DT,
I don't see why we shouldn't have the same requirement for
dw_pcie_edma_irq_verify()

Looking at pcie-ep@1c08000 in arch/arm64/boot/dts/qcom/sm8450.dtsi,
it does also specify "dma" IRQ in DT.


So, should I submit a patch that does:


diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89aad5a08928..c7a2cf5e886f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1045,9 +1045,7 @@ static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
 	char name[15];
 	int ret;
 
-	if (pci->edma.nr_irqs == 1)
-		return 0;
-	else if (pci->edma.nr_irqs > 1)
+	if (pci->edma.nr_irqs > 1)
 		return pci->edma.nr_irqs != ch_cnt ? -EINVAL : 0;
 
 	ret = platform_get_irq_byname_optional(pdev, "dma");
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index bf7c6ac0f3e3..ad98598bb522 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -874,7 +874,6 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	pcie_ep->pci.dev = dev;
 	pcie_ep->pci.ops = &pci_ops;
 	pcie_ep->pci.ep.ops = &pci_ep_ops;
-	pcie_ep->pci.edma.nr_irqs = 1;
 
 	pcie_ep->cfg = of_device_get_match_data(dev);
 	if (pcie_ep->cfg && pcie_ep->cfg->hdma_support) {


Because, since sm8450 (and all other platforms) currently must have
either "dma" or "dmaX" in DT, all currently supported platform should
still work.


If sm8450 case, this code:
https://github.com/torvalds/linux/blob/v6.17-rc4/drivers/pci/controller/dwc/pcie-designware.c#L1053-L1057

should set pcie_ep->pci.edma.nr_irqs = 1, because sdm8450 has "dma" in DT.



Kind regards,
Niklas

