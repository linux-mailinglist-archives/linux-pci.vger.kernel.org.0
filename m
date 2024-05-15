Return-Path: <linux-pci+bounces-7525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1C08C6C79
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 20:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC075284B27
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 18:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9221215B0ED;
	Wed, 15 May 2024 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gdtro8IG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EAD15ADB6;
	Wed, 15 May 2024 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799164; cv=none; b=tr65Eq+880gIHVyMZ+MUp4plhOEQIjlSbjfb1rK72DCCH3V+wz86q/eb+5m1fmCPRskJlL6V+ShjczNzu8yAM+jIoeceIYQaTuAlA8xa/jAZT8sUT+JWos0zt0kpcbyBlReDegucaAbiwuzoiSlGLV8F7kZZk/+5fYzeOGI7hLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799164; c=relaxed/simple;
	bh=oXhqMtB1Q9CCQXQJ3USVFEUF5oXFqNdWxV7yheTzfmE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oyJ4KbTX4L1GMl9kmij6V6vMovZljPQpHrGO8czyEIHbTTnTaS1WEVPukCW473jT0Lt5lhmUB9ndEFa+1Sl4gMtx1OZUySZIpi503oINme/QQE9lB9JrK2tsLkgHefZ6BBYih5PYShPR7igC5ZSy2epIBTUBCYHZBaCLMOVZJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gdtro8IG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21DFC116B1;
	Wed, 15 May 2024 18:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715799163;
	bh=oXhqMtB1Q9CCQXQJ3USVFEUF5oXFqNdWxV7yheTzfmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Gdtro8IGeuHC3mbYxSLKA/eOoXeVh3Pl94ZwCw5Fy55FkfL614rRhNtB4fWjrNolB
	 8YVaQRmpK855pYgzJmHA8biFzXZOpdgVnWl61xSGwAnq9Y+1k8AHZwWl1my8g4We6E
	 jql3CJ6jIGnTNgMgDFVTcosMDmaCkDmimEj2ZItZ12vKc1XGKp+jZmhOHFaG3lmio4
	 KtIQsxUzrBwD8//aYNeYVXkeLla0qHtSKP+GnT+zwKTMcnf18sXfW+Ir6AydDwI9aD
	 IgFu07RZLuTo5GmzXDXgMDUmHnWOFikXSpwD9vyOFF7caPRbf0WNZBR5i2QO95qsM6
	 widVINxqKxP4w==
Date: Wed, 15 May 2024 13:52:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"will@kernel.org" <will@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"liviu.dudau@arm.com" <liviu.dudau@arm.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Ketan Patil <ketanp@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] Enable PCIe ATS for devicetree boot
Message-ID: <20240515185241.GA2131384@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR12MB6674391D5067B469B0400C26B8EC2@PH8PR12MB6674.namprd12.prod.outlook.com>

On Wed, May 15, 2024 at 06:28:15PM +0000, Vidya Sagar wrote:
> Thanks, Jean for this series.
> May I know the current status of it?
> Although it was actively reviewed, I see that its current status is set to 
> 'Handled Elsewhere' in https://patchwork.kernel.org/project/linux-pci/list/?series=848836&state=*
> What is the plan to get this series accepted?

I probably marked it "handled elsewhere" in the PCI patchwork because
it doesn't touch PCI files (the binding has already been reviewed by
Rob and Liviu), so I assumed the iommu folks would take the series.
I don't know how they track patches.

The merge window is open now, so likely they would wait until the next
cycle so it would have some time in linux-next, but that's up to them.

> > -----Original Message-----
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Sent: Monday, April 29, 2024 5:10 PM
> > To: will@kernel.org; lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > bhelgaas@google.com; krzk+dt@kernel.org; conor+dt@kernel.org;
> > liviu.dudau@arm.com; sudeep.holla@arm.com; joro@8bytes.org
> > Cc: robin.murphy@arm.com; Nicolin Chen <nicolinc@nvidia.com>; Ketan Patil
> > <ketanp@nvidia.com>; linux-pci@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; iommu@lists.linux.dev; devicetree@vger.kernel.org;
> > Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Subject: [PATCH 0/3] Enable PCIe ATS for devicetree boot
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > Before enabling Address Translation Support (ATS) in endpoints, the OS needs to
> > confirm that the Root Complex supports it. Obtain this information from the
> > firmware description since there is no architected method. ACPI provides a bit via
> > IORT tables, so add the devicetree equivalent.
> > 
> > It was discussed a while ago [1], but at the time only a software model supported
> > it. Respin it now that hardware is available [2].
> > 
> > To test this with the Arm RevC model, enable ATS in the endpoint and note that
> > ATS is enabled. Address translation is transparent to the OS.
> > 
> >         -C pci.pcie_rc.ahci0.endpoint.ats_supported=1
> > 
> >     $ lspci -s 00:1f.0 -vv
> >         Capabilities: [100 v1] Address Translation Service (ATS)
> >                 ATSCap: Invalidate Queue Depth: 00
> >                 ATSCtl: Enable+, Smallest Translation Unit: 00
> > 
> > 
> > [1] https://lore.kernel.org/linux-iommu/20200213165049.508908-1-jean-
> > philippe@linaro.org/
> > [2] https://lore.kernel.org/linux-arm-kernel/ZeJP6CwrZ2FSbTYm@Asurada-
> > Nvidia/
> > 
> > Jean-Philippe Brucker (3):
> >   dt-bindings: PCI: generic: Add ats-supported property
> >   iommu/of: Support ats-supported device-tree property
> >   arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP
> > 
> >  .../devicetree/bindings/pci/host-generic-pci.yaml        | 6 ++++++
> >  drivers/iommu/of_iommu.c                                 | 9 +++++++++
> >  arch/arm64/boot/dts/arm/fvp-base-revc.dts                | 1 +
> >  3 files changed, 16 insertions(+)
> > 
> > --
> > 2.44.0
> > 
> 

