Return-Path: <linux-pci+bounces-19175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 076CA9FFC9D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 18:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3004E1882C0A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3D114387B;
	Thu,  2 Jan 2025 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruyYold5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CD125D6
	for <linux-pci@vger.kernel.org>; Thu,  2 Jan 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735837768; cv=none; b=qiGRv8Ms7+7Jbad2c/BeQxWXoq9lBedoURxiGvDhaBVhf1tMuajaKcj7hA8aMyDYyc+YMqW5TtecbpXuospzKZB86A7jwUNE8m3M52/ncJEcCs9y9kb8/FHSXNGKjzuTGiHwtWuJL+4EzeITN3KYNKFM0bN8Q7Jvc58WuxLxGH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735837768; c=relaxed/simple;
	bh=Dfckcslj2/8WRc8SptWS2FQp9woBnJsNqD3xm+9mJes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlOsUh8LRAEu4BfWB8iUF0eDuk+aVXEz8HZ8GvUg/tL+JbZuSeN6nEadlYTyyRuhnPi8mZltT5vcWvOrLcdW2L+vcufZIg2roWCjIhQ1m7x4SUnboKggDvPNwDC+5aWNMC1XTA/dwQ+Jd1uL1KeQwT1ObafYEz/tY7L4Rp28Sbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruyYold5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C49EC4CED0;
	Thu,  2 Jan 2025 17:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735837766;
	bh=Dfckcslj2/8WRc8SptWS2FQp9woBnJsNqD3xm+9mJes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ruyYold5U8duzlVE6n5ktgNH83eSQ0/GovN3m3oZtWtSnr5Fshqdt/Nrtb16S3MgB
	 lqycf6xuS3anj00QuzamQ2IpKPjJJNCc2v79T83c/NVR5FlOq/B/FmOBOyqn/Nl3zc
	 CGuDGrxIeqVbQ3p3VC4c7vzMeR9Dsg4rtHlzDUm6A21iogjVht5qksfT6kYmx5TCX5
	 +nP6bCUrW8Qs22O3Tgm9YU085lSxkPr+Vb2vtQ24xHpkun+yhLOZ781XIoZ+GzlNc1
	 Qo8p6cexKtpHOo0nW+d20c+dlauVTRXyUyWz0EkZ+EwYmh9xKWq7UIlOYCSNIR5lwm
	 naSL8cRx8xi/w==
Date: Thu, 2 Jan 2025 18:09:22 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Enumerate endpoints based on
 dll_link_up irq in the combined sys irq
Message-ID: <Z3bIQj4b-9gV-Sd9@ryzen>
References: <20241127145041.3531400-2-cassel@kernel.org>
 <20241230191908.GA3962801@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230191908.GA3962801@bhelgaas>

On Mon, Dec 30, 2024 at 01:19:08PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 27, 2024 at 03:50:42PM +0100, Niklas Cassel wrote:
> > Most boards using the pcie-dw-rockchip PCIe controller lack standard
> > hotplug support.
> > 
> > Thus, when an endpoint is attached to the SoC, users have to rescan the bus
> > manually to enumerate the device. This can be avoided by using the
> > 'dll_link_up' interrupt in the combined system interrupt 'sys'.
> > 
> > Once the 'dll_link_up' irq is received, the bus underneath the host bridge
> > is scanned to enumerate PCIe endpoint devices.
> > 
> > This commit implements the same functionality that was implemented in the
> > DWC based pcie-qcom driver in commit 4581403f6792 ("PCI: qcom: Enumerate
> > endpoints based on Link up event in 'global_irq' interrupt").
> > 
> > The Root Complex specific device tree binding for pcie-dw-rockchip already
> > has the 'sys' interrupt marked as required, so there is no need to update
> > the device tree binding. This also means that we can request the 'sys' IRQ
> > unconditionally.
> 
> Thanks for doing this!
> 
> > @@ -436,7 +481,16 @@ static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
> >  	pp = &rockchip->pci.pp;
> >  	pp->ops = &rockchip_pcie_host_ops;
> >  
> > -	return dw_pcie_host_init(pp);
> > +	ret = dw_pcie_host_init(pp);
> > +	if (ret) {
> > +		dev_err(dev, "failed to initialize host\n");
> > +		return ret;
> > +	}
> > +
> > +	/* unmask DLL up/down indicator */
> > +	rockchip_pcie_writel_apb(rockchip, 0x20000, PCIE_CLIENT_INTR_MASK_MISC);
> 
> I know we already had a bare 0x60000 in rockchip_pcie_configure_ep(),
> but can we add #defines for both of these PCIE_CLIENT_INTR_MASK_MISC
> bits?

Sure, I will send a follow-up patch.


Kind regards,
Niklas

