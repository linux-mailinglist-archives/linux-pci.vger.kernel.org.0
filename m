Return-Path: <linux-pci+bounces-23111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64BDA567D2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 13:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D3C3B20A3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 12:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07684218E92;
	Fri,  7 Mar 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjdsCdjo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751821885D
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350595; cv=none; b=TMy4Jd0lPIQBgm3zDfmRBVJpml6imkxSvzyyhkj72gSAlNVdh5WqaRSs/+4iVf5SzzYvN6mkdC2Wgf+XYENAFKiHOkNeIUxgLK13iibxYlPblPHig52JOdXdr5REJ1Lzt79oOl0LS4Md3B7nJ5GE2Pm1JEC+3/4/pWWweY6h3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350595; c=relaxed/simple;
	bh=+VVBJtiF5Ii7M1lEfiI1i4POFsGEnlp4WuusV3Xil4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vx0ukdXQGAp8wo8WaiL0VPeOzDpcXNhiOu9QPcmzlqQm9Oeg4pcvhqPkqbZsG9Gclq/JdGYRGDb+KJzJ2SMmF8LmKQj2falJktTeY5vSo5zz1PvL8SviXxOrjMztiiob5m3WhezfHlJf9RpYstxof6o9KGI5zDwXykjHr0YDu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjdsCdjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0ECC4CED1;
	Fri,  7 Mar 2025 12:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741350595;
	bh=+VVBJtiF5Ii7M1lEfiI1i4POFsGEnlp4WuusV3Xil4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjdsCdjobZNT+sMdck8xTcbhwFdqsgPOwF9xU1fXrTskcvBDGPgiQFzK98ciQU0cd
	 JABhDQAT0cZMUbb9t7vOq4WzCEXQ8ZsRGoEwBjEiiPTQ/0ZClb/ugUwQcJHJDM9KNd
	 5n2yT/Qp88Rva/vrA4+DQAxGW1Yy5X4P4HUcGHCxqukqflJvQ08QwQazhNe9zLcXXi
	 k4iCVhUUfn976KmDME8sHmSrItXj5+rtDMs3ld2IOaXRQJbox0GRupEniQdPgKub1N
	 n/pk+d1ER7Dtt/oxzNAxyYIjZdKorT5mo1dy6cXu7HAmqqoVCPDb1+Tusr6yOSGSrY
	 p1W012/Vs+/+A==
Date: Fri, 7 Mar 2025 13:29:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: dw-rockchip: hide broken ATS capability
Message-ID: <Z8rmviTHs92699jQ@ryzen>
References: <20250221202646.395252-3-cassel@kernel.org>
 <20250221202646.395252-4-cassel@kernel.org>
 <20250222160837.mropn3laiyv3acaa@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222160837.mropn3laiyv3acaa@thinkpad>

Hello Mani,

On Sat, Feb 22, 2025 at 09:38:37PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Feb 21, 2025 at 09:26:48PM +0100, Niklas Cassel wrote:
> > When running the rk3588 in endpoint mode, with an Intel host with IOMMU
> > enabled, the host side prints:
> > DMAR: VT-d detected Invalidation Time-out Error: SID 0
> > 
> > When running the rk3588 in endpoint mode, with an AMD host with IOMMU
> > enabled, the host side prints:
> > iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01a0]
> > 
> > Usually, to handle these issues, we add a quirk for the PCI vendor and
> > device ID in drivers/pci/quirks.c with quirk_no_ats(). That is because
> > we cannot usually modify the capabilities on the EP side.
> > 
> > In this case, we can modify the capabilties on the EP side. Thus, hide the
> > broken ATS capability on rk3588 when running in EP mode. That way,
> > we don't need any quirk on the host side, and we see no errors on the host
> > side, and we can run pci_endpoint_test successfully, with the IOMMU
> > enabled on the host side.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index 836ea10eafbb..2be005c1a161 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -242,6 +242,51 @@ static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
> >  	.init = rockchip_pcie_host_init,
> >  };
> >  
> > +/*
> > + * ATS does not work on rk3588 when running in EP mode.
> > + * After a host has enabled ATS on the EP side, it will send an IOTLB
> > + * invalidation request to the EP side. The rk3588 will never send a completion
> > + * back and eventually the host will print an IOTLB_INV_TIMEOUT error, and the
> > + * EP will not be operational. If we hide the ATS cap, things work as expected.
> > + */
> > +static void rockchip_pcie_ep_hide_broken_ats_cap_rk3588(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	struct device *dev = pci->dev;
> > +	unsigned int spcie_cap_offset, next_cap_offset;
> > +	u32 spcie_cap_header, next_cap_header;
> > +
> > +	/* only hide the ATS cap for rk3588 running in EP mode */
> > +	if (!of_device_is_compatible(dev->of_node, "rockchip,rk3588-pcie-ep"))
> > +		return;
> 
> Compatible checks always tend to extend. So please use a boolean flag to
> identify the quirk in 'struct rockchip_pcie_of_data' and set it in
> 'rockchip_pcie_ep_of_data_rk3588'. This way, other SoCs could also reuse the
> flag if required.

I agree that in many cases, compatible checks tend to extend.

However, the ATS capability is broken only for rk3588, thus we need to provide
the ATS cap_id and the cap_id for the CAP immediately preceding the ATS cap_id.

The linked list of capabilities will be different for every SoC.
If we look at the only other SoC supported by this EPC, rk3568, it does not
even have the ATS cap in the linked list.

Thus, I think that creating a boolean flag for this is wrong.
Even in the unlikely scenario that there will come a Rockchip SoC in the
future with an identical linked list of capabilities, I think that what you
are proposing this is premature optimization (AKA the root of all evil :P)


> 
> > +
> > +	spcie_cap_offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_SECPCI);
> > +	if (!spcie_cap_offset)
> > +		return;
> > +
> > +	spcie_cap_header = dw_pcie_readl_dbi(pci, spcie_cap_offset);
> > +	next_cap_offset = PCI_EXT_CAP_NEXT(spcie_cap_header);
> > +
> > +	next_cap_header = dw_pcie_readl_dbi(pci, next_cap_offset);
> > +	if (PCI_EXT_CAP_ID(next_cap_header) != PCI_EXT_CAP_ID_ATS)
> > +		return;
> > +
> > +	/* clear next ptr */
> > +	spcie_cap_header &= ~GENMASK(31, 20);
> > +
> > +	/* set next ptr to next ptr of ATS_CAP */
> > +	spcie_cap_header |= next_cap_header & GENMASK(31, 20);
> > +
> > +	dw_pcie_dbi_ro_wr_en(pci);
> > +	dw_pcie_writel_dbi(pci, spcie_cap_offset, spcie_cap_header);
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> 
> This code is mostly generic. So please move it to pcie-designware-ep.c. The
> function should just accept two CAP IDs (prev and target) and hide the target
> capability. Like,
> 
> 	dw_pcie_hide_ext_capability(pci, PCI_EXT_CAP_ID_SECPCI,
> 				    PCI_EXT_CAP_ID_ATS);

Sure, I will create a generic function in pcie-designware-ep.c.


> 
> Its too bad that we cannot traverse back from the target capability. We could
> open code dw_pcie_ep_find_ext_capability() to keep track of the prev_cap_offset
> though.

I'd rather skip this. Seems like too many special cases.
E.g. what should dw_pcie_ep_find_ext_capability() return if there is no prev?
It seems easier to just need to provide prev_cap_id as well.


Kind regards,
Niklas

