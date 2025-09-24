Return-Path: <linux-pci+bounces-36844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC9CB98FAC
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 10:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 532107AB120
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2522F2C326E;
	Wed, 24 Sep 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzOmaFDo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77092C325F;
	Wed, 24 Sep 2025 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703862; cv=none; b=Z2lDu1ppCvavN19ysIIecYPTkk3Hj9cEQ8mCCf6eW+NlnnOYdtskKukGa94d44kzkLVYk463UhSjI/r3HI+dpACH8s+vgsYLmsdWKdFSsoTXmU9p2eIIrkoLLHC9Szye2CIh/469geuHHSOHYJo1C/Enw8tZHeKuheSVtgyo4yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703862; c=relaxed/simple;
	bh=PhUkbUI8KogzWtzU+Q9FLveQJuOuUgfGJLwlQrk0GY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWlpcxQ1iVVNxZjLAa6XdqtWXzdxj6EaoPPMiR41N6Unxr3otEx1RypSTec2XdgBrJWsxFoxaJxjYp6FV02+16E4UBJWmENrczu17Ung7gC8t7m2I2qxwpyLfaUPDhA+XkNoGuAK+Ucgtn467KcalMEdxZsiOK1PRQMjUSEG3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzOmaFDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B36FC4CEE7;
	Wed, 24 Sep 2025 08:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758703861;
	bh=PhUkbUI8KogzWtzU+Q9FLveQJuOuUgfGJLwlQrk0GY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzOmaFDo+t3rdWk5mkSVOnaSKEq4kk3zzNLtDnufs3/UwDbMSUVwpStOBR9tjdsw/
	 5r5jNuar+AzHnqvMqe/m6cS9V6QnvChSakUGkLC7lB7ulgNA2ifUFYdKy5UsOP1r2N
	 FrAFYlteFOFMERs1cbWhYuI56KOSyx7EhAy25V0SMh2n9vTMU99xAb672wxXlzHvac
	 NZSS9lccrxvAdSNX0AuCxKr1fODGczTsjW43e0xqBKrsWsL9BcrK/+1JoHbKERxf1d
	 iEWF27wTF7ZqwO1VVVNf7Jzi+b4IQqkPF0HuxlnR36skEtyRjMbMvQ/dLifJT5u5La
	 zkbToNWuYM3TQ==
Date: Wed, 24 Sep 2025 14:20:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, 
	iommu@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Pavankumar Kondeti <quic_pkondeti@quicinc.com>, 
	Xingang Wang <wangxingang5@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/of: Call pci_request_acs() before enumerating
 the Root Port device
Message-ID: <e4fjukl3xkfcxcm5p6jo4davplqlrx4xrpbjhdsduqjlv7oz7l@zilbaf3h6py2>
References: <20250910-pci-acs-v1-2-fe9adb65ad7d@oss.qualcomm.com>
 <20250923202701.GA2055736@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923202701.GA2055736@bhelgaas>

On Tue, Sep 23, 2025 at 03:27:01PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 10, 2025 at 11:09:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Xingang Wang <wangxingang5@huawei.com>
> > 
> > When booting with devicetree, ACS is enabled for all ACS capable PCI
> > devices except the first Root Port enumerated in the system. This is due to
> > calling pci_request_acs() after the enumeration and initialization of the
> > Root Port device. 
> 
> I suppose you're referring to a path like below, where we *check*
> pci_acs_enable during PCI enumeration, but we don't *set* it until we
> add the device and look for a driver for it?
> 
>   pci_host_common_init
>     devm_pci_alloc_host_bridge
>       devm_of_pci_bridge_init
>         pci_request_acs
>           pci_acs_enable = 1                    # ++ new set here
>     pci_host_probe
>       pci_scan_root_bus_bridge
>         pci_scan_device
>           pci_init_capabilities
>             pci_enable_acs
>               if (pci_acs_enable)               # test here
>                 ...
>       pci_bus_add_devices
>         driver_probe_device
>           pci_dma_configure
>             of_dma_configure
>               of_dma_configure_id
>                 of_iommu_configure
>                   pci_request_acs
>                     pci_acs_enable = 1          # -- previously set here
> 

Yes!

> > But afterwards, ACS is getting enabled for the rest of the PCI
> > devices, since pci_request_acs() sets the 'pci_acs_enable' flag and
> > the PCI core uses this flag to enable ACS for the rest of the ACS
> > capable devices.
> 
> I don't quite understand why ACS would be enabled for *any* of the
> devices because we generally enumerate all of them, which includes the
> pci_init_capabilities() and pci_enable_acs(), before adding and
> attaching drivers to them.
> 
> But it does seem kind of dumb that we set the system-wide "enable ACS"
> property in a per-device place like an individual device probe.
> 

I had the same opinion when I saw the 'pci_acs_enable' flag. But I think the
intention was to enable ACS only if the controller is capable of assigning
different IOMMU groups per device. Otherwise, ACS is more or less of no use.

> > Ideally, pci_request_acs() should only be called if the 'iommu-map' DT
> > property is set for the host bridge device. Hence, call pci_request_acs()
> > from devm_of_pci_bridge_init() if the 'iommu-map' property is present in
> > the host bridge DT node. This aligns with the implementation of the ARM64
> > ACPI driver (drivers/acpi/arm64/iort.c) as well.
> > 
> > With this change, ACS will be enabled for all the PCI devices including the
> > first Root Port device of the DT platforms.
> > 
> > Cc: stable@vger.kernel.org # 5.6
> > Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when configuring IOMMU linkage")
> > Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> > [mani: reworded subject, description and comment]
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/iommu/of_iommu.c | 1 -
> >  drivers/pci/of.c         | 8 +++++++-
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index 6b989a62def20ecafd833f00a3a92ce8dca192e0..c31369924944d36a3afd3d4ff08c86fc6daf55de 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -141,7 +141,6 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
> >  			.np = master_np,
> >  		};
> >  
> > -		pci_request_acs();
> >  		err = pci_for_each_dma_alias(to_pci_dev(dev),
> >  					     of_pci_iommu_init, &info);
> >  		of_pci_check_device_ats(dev, master_np);
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 3579265f119845637e163d9051437c89662762f8..98c2523f898667b1618c37451d1759959d523da1 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -638,9 +638,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
> >  
> >  int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
> >  {
> > -	if (!dev->of_node)
> > +	struct device_node *node = dev->of_node;
> > +
> > +	if (!node)
> >  		return 0;
> >  
> > +	/* Enable ACS if IOMMU mapping is detected for the host bridge */
> > +	if (of_property_read_bool(node, "iommu-map"))
> > +		pci_request_acs();
> 
> I'm not really convinced that the existence of 'iommu-map' in
> devicetree is a clear signal that ACS should be enabled, so I'm a
> little hesitant about this part.
> 
> Is it possible to boot using a devicetree with 'iommu-map', but with
> the IOMMU disabled or the IOMMU driver not present?  Or other
> situations where we don't need ACS?
> 

Certainly possible. But the issue is, we cannot reliably detect the presence of
IOMMU until the first pci_dev is created, which will be too late as
pci_acs_init() is called during pci_device_add().

This seems to be the case for ACPI platforms also.

Maybe IOMMU folks Robin/Joerg/Will could comment more.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

