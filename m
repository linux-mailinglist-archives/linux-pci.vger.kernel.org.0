Return-Path: <linux-pci+bounces-29655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C638AD86E7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 11:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366CF189D32F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139A1291C0B;
	Fri, 13 Jun 2025 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1D314jD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8763279DD7;
	Fri, 13 Jun 2025 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749805505; cv=none; b=LqHK5x+JUWGTuDZcJIpVODFqI6pKHTnhIg11L/apfJuwpCez/fCcajs1UKQKyg4vQWGYKNACi1i8UR61zg7D9mKKJPJxATV6/4O32vavo+oo0+qrjepyijhnXdzxwQqlAsbIfuPn1JFovv+BRhXM9kU0j4GzVLiPCCyyZWcuHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749805505; c=relaxed/simple;
	bh=/z3ISYzkV0unW5sqeJeb8uAQIRvRJjWrGvnYEIkJOl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3kGH99Xyss1UFM2ttw9t5GCRTSDmtXRVkDEgLr49+c1Tovx0oPiIq3uTfdTU7dPJpHeHo4/MXQeRigm7pzHIaXrlFntMo/OcqVMwfCwkO17dKDfKBCKpYzFxOA5gC0ZvPGCaZg43iiWn79Q12iciE1cqaT6wl2j7MrBH4zRRxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1D314jD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A22C4CEE3;
	Fri, 13 Jun 2025 09:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749805505;
	bh=/z3ISYzkV0unW5sqeJeb8uAQIRvRJjWrGvnYEIkJOl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1D314jDshWGk9VU2FaY4xmGqqNeYJ+VEfnVmgJTbLmVUHHkWXnQ/bz5woAKzjvTP
	 /DOvGnVk+VFicXXGm06il7p1yMWrGU1SrtwLvKYooEcl1/LvCtWvSdod2fqOwHKinI
	 StbcptvHentF5Eltm8p22RKUHdoQ8dkhrZbjNGzfbjCDBfPqIjy3CbCryp/gAlspNP
	 nuP7WJp4925btgScwJ1DSd8MdyUnu4D9EASBYnU5c4z+mq08FLc+QW5rd6RDW3eene
	 yN6Ex20uiZkditsFIUM2eMD/uqKuvBx+c4h1Q9GSHmhOOXLosJ4N/TXPLe1SvV8MF1
	 g9Dz9rRKzCncg==
Date: Fri, 13 Jun 2025 14:34:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: 'Krzysztof Kozlowski' <krzk@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.or, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de, 
	m.szyprowski@samsung.com, jh80.chung@samsung.com, 
	'Pankaj Dubey' <pankaj.dubey@samsung.com>
Subject: Re: [PATCH 04/10] PCI: exynos: Add platform device private data
Message-ID: <fty3sp3brzpcs6jeqg6yxiwgpbyqogxqt5mo7owiw4vkl7vj2j@b33zfdizuy4d>
References: <20250518193152.63476-1-shradha.t@samsung.com>
 <CGME20250518193239epcas5p4cb4112382560f38ad9708e000eb2335f@epcas5p4.samsung.com>
 <20250518193152.63476-5-shradha.t@samsung.com>
 <20250521-cheerful-spiked-mackerel-ef7ade@kuoka>
 <0e2301dbcef4$42969af0$c7c3d0d0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e2301dbcef4$42969af0$c7c3d0d0$@samsung.com>

On Tue, May 27, 2025 at 04:13:58PM +0530, Shradha Todi wrote:
> 
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 21 May 2025 15:15
> > To: Shradha Todi <shradha.t@samsung.com>
> > Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.or;
> > linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org;
> > kw@linux.com; robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; krzk+dt@kernel.org; conor+dt@kernel.org;
> > alim.akhtar@samsung.com; vkoul@kernel.org; kishon@kernel.org; arnd@arndb.de; m.szyprowski@samsung.com;
> > jh80.chung@samsung.com; Pankaj Dubey <pankaj.dubey@samsung.com>
> > Subject: Re: [PATCH 04/10] PCI: exynos: Add platform device private data
> > 
> > On Mon, May 19, 2025 at 01:01:46AM GMT, Shradha Todi wrote:
> > > -static const struct dw_pcie_ops dw_pcie_ops = {
> > > +static const struct dw_pcie_ops exynos_dw_pcie_ops = {
> > >  	.read_dbi = exynos_pcie_read_dbi,
> > >  	.write_dbi = exynos_pcie_write_dbi,
> > >  	.link_up = exynos_pcie_link_up,
> > > @@ -279,6 +286,7 @@ static int exynos_pcie_probe(struct
> > > platform_device *pdev)  {
> > >  	struct device *dev = &pdev->dev;
> > >  	struct exynos_pcie *ep;
> > > +	const struct samsung_pcie_pdata *pdata;
> > >  	struct device_node *np = dev->of_node;
> > >  	int ret;
> > >
> > > @@ -286,8 +294,11 @@ static int exynos_pcie_probe(struct platform_device *pdev)
> > >  	if (!ep)
> > >  		return -ENOMEM;
> > >
> > > +	pdata = of_device_get_match_data(dev);
> > > +
> > > +	ep->pdata = pdata;
> > >  	ep->pci.dev = dev;
> > > -	ep->pci.ops = &dw_pcie_ops;
> > > +	ep->pci.ops = pdata->dwc_ops;
> > >
> > >  	ep->phy = devm_of_phy_get(dev, np, NULL);
> > >  	if (IS_ERR(ep->phy))
> > > @@ -363,9 +374,9 @@ static int exynos_pcie_resume_noirq(struct device *dev)
> > >  		return ret;
> > >
> > >  	/* exynos_pcie_host_init controls ep->phy */
> > > -	exynos_pcie_host_init(pp);
> > > +	ep->pdata->host_ops->init(pp);
> > >  	dw_pcie_setup_rc(pp);
> > > -	exynos_pcie_start_link(pci);
> > > +	ep->pdata->dwc_ops->start_link(pci);
> > 
> > One more layer of indirection.
> > 
> > Read:
> > https://lore.kernel.org/all/CAL_JsqJgaeOcnUzw+rUF2yO4hQYCdZYssjxHzrDvvHGJimrASA@mail.gmail.com/
> > 
> 
> I went through this thread and the solution to avoid redirection seems to be:
> 1. Make the common parts into a library that each driver can call
> 2. When there is barely anything in common, make a separate driver
> 
> From my understanding of these 2 drivers, there is hardly anything that can go into common library
> 1. host_init, dbi_read, dbi_write these ops have completely different flow
> 2. link_up, start_link have similar flow but different register offsets
> 3. write_dbi2 and stop_link is not implemented for exynos but needed for FSD
> 4. Resources are different - FSD does not have regulator, Exynos5433 does not have syscon, FSD has msi IRQ vs exynos5433 has legacy
> 5. Exynos is host only whereas FSD is dual mode controller.
> 
> I don’t see any other way except redirection, or using lots of if(variant == FSD) which is also discouraged.

Please wrap your replies to 80 columns.

> 

IMO it is OK to have the callbacks for cases like this. This is also similar to
Qcom driver where each SoC requires custom register updates and going by the
common library or a new driver wouldn't be feasible.

> And about making it a different driver altogether, I'm completely okay to do so. In fact we had previously tried to post it as a
> different driver which was rejected.
> 

No, please do not create a new driver, that is another maintainer burden.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

