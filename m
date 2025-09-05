Return-Path: <linux-pci+bounces-35528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B84B456BA
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 13:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E7C16EEB1
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54253451CF;
	Fri,  5 Sep 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVAAp2p5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E42334320C;
	Fri,  5 Sep 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072623; cv=none; b=l7FEe+mMZd8SiajPrMJWNL6Sgd98NEbkqzxm7mZG5NrqGVw0H3VkJkzLu1sSutC1AdajjeW9qZZw++KY3g3UOi5IcQ2DSMrmjp++A+ud+PQ/8DVqrycNDY409akGC3v72u3nNFMc2dzFyuOwj2+sYUwQRs5jmt1xTRYn6SK6Dzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072623; c=relaxed/simple;
	bh=NLML2PKuwuj+OYNgyIRQX3jQ9i3GAYhKH/CptvLMsng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shs882tuPaKcNAorrmjVvvUHBk8AH4L5vFRLrATnPv+/1/bwq2JocrjQRU4xCPZauRulN/Krm3A2smRXUP30S9SVx/oMRRCR8/Gu8VFOw8qbu7bVJV/nYMaDbTo/CjCNRDrrUmnRqpacp3dVkAxFbVBX+DNKe6BnS2n4UCrDV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVAAp2p5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9BFC4CEF1;
	Fri,  5 Sep 2025 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757072623;
	bh=NLML2PKuwuj+OYNgyIRQX3jQ9i3GAYhKH/CptvLMsng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVAAp2p5/E4CwAUtDQOLmC0Gc6y8NUeC9WK4IOPuAgfHEZGqaOwEdx5Ns+KcST7/F
	 PEiLR4ES6kjCMJyP6JUoVYMTwauVS/C7EN+6JOLI8e72dxBRpxFsC670XT1tosCbIV
	 +j2RxEFGc6BShuQ1ucZEqIo+44s6Kht+owFiJHJjxVDsCtrAa7o/EPQJr/P0ngV6p8
	 CepXm6zV9tHmjLVHYf7uNmY7a1AB+gCUry6uzhfAh48NzCuj2RIyu3bpBa64JvnL5v
	 4xNb3pI81ElcUK7Wg2+2tOA7IY5h/8L4hQrj8mjFDE6JML/QZG1ahsZRhqJGKGIU8k
	 N0S/XtwEcZzZg==
Date: Fri, 5 Sep 2025 17:13:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, quic_vpernami@quicinc.com, 
	mmareddy@quicinc.com, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v8 3/5] PCI: dwc: qcom: Switch to dwc ELBI resource
 mapping
Message-ID: <xzzyhcuwfva6vqzmxkdqt5x7f7vxpkkyqnml6vjclb75f4ozwa@gugsrqfsbuor>
References: <20250828-ecam_v4-v8-3-92a30e0fa02d@oss.qualcomm.com>
 <20250903191459.GA1214624@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903191459.GA1214624@bhelgaas>

On Wed, Sep 03, 2025 at 02:14:59PM GMT, Bjorn Helgaas wrote:
> On Thu, Aug 28, 2025 at 01:04:24PM +0530, Krishna Chaitanya Chundru wrote:
> > Instead of using qcom ELBI resources mapping let the DWC core map it
> > ELBI is DWC specific.
> 
> This seems like basically the same change you (Mani) added to the
> "[PATCH v8 2/5] PCI: dwc: Add support for ELBI resource mapping"
> patch?  (The patch with Mani's additions is at
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc-ecam&id=d39e0103e38f9889271a77a837b6179b42d6730d)
> 

Doh! This should've been squashed to patch 2/5 as we cannot split the conversion
patches. The reason is, we cannot ioremap() the same region twice.

This is now taken care in the branch.

- Mani

> If this qcom change is separated out, why can't the exynos and qcom-ep
> changes from patch 2/5 be separated out?  If we ever had to bisect
> and/or revert parts of this, it seems like it would be simpler to do
> them consistently like this:
> 
>   - PCI: dwc: Add ELBI resource mapping
>   - PCI: exynos: Switch to dwc ELBI resource mapping
>   - PCI: qcom: Switch to dwc ELBI resource mapping
>   - PCI: qcom-ep: Switch to dwc ELBI resource mapping
> 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..5092752de23866ef95036bb3f8fae9bb06e8ea1e 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -276,7 +276,6 @@ struct qcom_pcie_port {
> >  struct qcom_pcie {
> >  	struct dw_pcie *pci;
> >  	void __iomem *parf;			/* DT parf */
> > -	void __iomem *elbi;			/* DT elbi */
> >  	void __iomem *mhi;
> >  	union qcom_pcie_resources res;
> >  	struct phy *phy;
> > @@ -414,12 +413,17 @@ static void qcom_pcie_configure_dbi_atu_base(struct qcom_pcie *pcie)
> >  
> >  static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
> >  {
> > +	struct dw_pcie *pci = pcie->pci;
> >  	u32 val;
> >  
> > +	if (!pci->elbi_base) {
> > +		dev_err(pci->dev, "ELBI is not present\n");
> > +		return;
> > +	}
> >  	/* enable link training */
> > -	val = readl(pcie->elbi + ELBI_SYS_CTRL);
> > +	val = readl(pci->elbi_base + ELBI_SYS_CTRL);
> >  	val |= ELBI_SYS_CTRL_LT_ENABLE;
> > -	writel(val, pcie->elbi + ELBI_SYS_CTRL);
> > +	writel(val, pci->elbi_base + ELBI_SYS_CTRL);
> >  }
> >  
> >  static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
> > @@ -1861,12 +1865,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >  		goto err_pm_runtime_put;
> >  	}
> >  
> > -	pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
> > -	if (IS_ERR(pcie->elbi)) {
> > -		ret = PTR_ERR(pcie->elbi);
> > -		goto err_pm_runtime_put;
> > -	}
> > -
> >  	/* MHI region is optional */
> >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mhi");
> >  	if (res) {
> > 
> > -- 
> > 2.34.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

