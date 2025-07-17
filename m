Return-Path: <linux-pci+bounces-32387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68470B08CE6
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 14:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46831C255E6
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246BF2BE65B;
	Thu, 17 Jul 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceJopmgB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E872229DB7F;
	Thu, 17 Jul 2025 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755382; cv=none; b=fWLfgmpyT0qZV2vW9jN0JHD66IfGoOkMX9QPaRKix+Vvq8i9v1NsipHV0BdDcurl85d9xsEn/sIombUImSlTclIhbRZ7j62DgJ5S1fU9g/QN4JujJRl20/urXFfH8f4piIai/zpOvsrDsvFqpkRu1UwlnSLC1yxD6ySpkmoHAbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755382; c=relaxed/simple;
	bh=wuTslYNT33q0ZwkBocmRlf+/H/EC1qjjCuq+1hLV8/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgFLBZC+nQ/tRboEI7dgIBwrMmcffWRTpawHSyGx+V8v8fkIQeMtJiH0yUdr/BLqnmwoyhkACJnyeR4KF04SuUgu0uVxG/d0tUQIgSmjoypZZ/p6fMSjHAosK2pKFVaU4k7Isz17MLTbVkozOhyJriPSphknPTkrGklH8Ah508M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceJopmgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8082C4CEE3;
	Thu, 17 Jul 2025 12:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752755381;
	bh=wuTslYNT33q0ZwkBocmRlf+/H/EC1qjjCuq+1hLV8/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ceJopmgBy57bJV7/pVeyCt/sWnxvpAsEluSAjSqU2w3Jh04BHtaiAKo9lmJ9AvYfZ
	 K5pBwXOHitlun8dR26Zstr1RUWJM84CUNJfJY0BVF+gf0zWoLpnwdZR4sNr81K1YBk
	 VUBJ/VjvFxZgy3wMohvdUgSwrCUch0CBivHiD0o0g95164OK9/znhIREB+z7g1Nqfm
	 VsB2MSBRiMVxTaAYbHVNFLA/s2h37gLvnyn9KZt5WyJYtPI3Y+idAjq2x0myzQGof3
	 7u8IWr9UGLr91Oy0qtj9GnGEqOjcPxca775YWvWve0YENWg7eoUzNJiULTgSMnK/Ev
	 dWpaGUGxT++EQ==
Date: Thu, 17 Jul 2025 17:59:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, 
	Hugh Cole-Baker <sigmaris@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/3] PCI: rockchip-host: Retry link training on
 failure without PERST#
Message-ID: <djbhz7qfyzrn7mdqmvqhyh6yjsjyigjly7py4f7aj5f4qbabou@67gk3qdnvzws>
References: <cover.1749582046.git.geraldogabriel@gmail.com>
 <b7c09279b4a7dbdba92543db9b9af169776bd90c.1749582046.git.geraldogabriel@gmail.com>
 <zuiq3b2rsixymtjr3xzrb26clikvlja62wgj65umnse4kuk75c@x5qan73ispxe>
 <aFk-MeIWFcBiGBPr@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFk-MeIWFcBiGBPr@geday>

On Mon, Jun 23, 2025 at 08:44:49AM GMT, Geraldo Nascimento wrote:
> On Mon, Jun 23, 2025 at 05:29:46AM -0600, Manivannan Sadhasivam wrote:
> > On Tue, Jun 10, 2025 at 04:05:40PM -0300, Geraldo Nascimento wrote:
> > > After almost 30 days of battling with RK3399 buggy PCIe on my Rock Pi
> > > N10 through trial-and-error debugging, I finally got positive results
> > > with enumeration on the PCI bus for both a Realtek 8111E NIC and a
> > > Samsung PM981a SSD.
> > > 
> > > The NIC was connected to a M.2->PCIe x4 riser card and it would get
> > > stuck on Polling.Compliance, without breaking electrical idle on the
> > > Host RX side. The Samsung PM981a SSD is directly connected to M.2
> > > connector and that SSD is known to be quirky (OEM... no support)
> > > and non-functional on the RK3399 platform.
> > > 
> > > The Samsung SSD was even worse than the NIC - it would get stuck on
> > > Detect.Active like a bricked card, even though it was fully functional
> > > via USB adapter.
> > > 
> > > It seems both devices benefit from retrying Link Training if - big if
> > > here - PERST# is not toggled during retry.
> > > 
> > > For retry to work, flow must be exactly as handled by present patch,
> > > that is, we must cut power, disable the clocks, then re-enable
> > > both clocks and power regulators and go through initialization
> > > without touching PERST#. Then quirky devices are able to sucessfully
> > > enumerate.
> > > 
> > 
> > This sounds weird. PERST# is just an indication to the device that the power and
> > refclk are applied or going to be removed. The devices uses PERST# to prepare
> > for the power removal during assert and start functioning after deassert.
> 
> Hi Mani! Thank you for looking into this.
> 
> Yeah, tell me about it, it is beyond weird. I posted RFC Patch in the
> hopes someone with access to PCIe Analyzer could have deeper look
> at what the heck is going on here - because it does work, but I don't
> claim to understand how.
> 

I was hoping that the Rockchip folks would chime in, but no reply from them so
far.

@Shawn: Could you please shed some light here?

> > 
> > It looks like the PERST# polarity is inverted in your case. Could you please
> > change the 'ep-gpios' polarity to GPIO_ACTIVE_LOW and see if it fixes the issue
> > without this patch?
> > 
> > If that didn't work, could you please drop the 'ep-gpios' property and check?
> 
> Sorry to decline your request, but I assure you I have tried many
> other combinations before reaching present patch, including your
> suggestion. It will do nothing. It won't work, won't make SSD that
> refuse to work with RK3399, working. Note that this isn't specific
> to my board - RK3399 is infamous for being picky about devices.
> 
> > 
> > > No functional change intended for already working devices.
> > > 
> > > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > > ---
> > >  drivers/pci/controller/pcie-rockchip-host.c | 47 ++++++++++++++++++---
> > >  1 file changed, 40 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> > > index 2a1071cd3241..67b3b379d277 100644
> > > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > > @@ -338,11 +338,14 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
> > >  static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
> > >  {
> > >  	struct device *dev = rockchip->dev;
> > > -	int err, i = MAX_LANE_NUM;
> > > +	int err, i = MAX_LANE_NUM, is_reinit = 0;
> > >  	u32 status;
> > >  
> > > -	gpiod_set_value_cansleep(rockchip->perst_gpio, 0);
> > > +	if (!is_reinit) {
> > > +		gpiod_set_value_cansleep(rockchip->perst_gpio, 0);
> > > +	}
> > >  
> > > +reinit:
> > 
> > So this reinit part only skips the PERST# assert, but calls
> > rockchip_pcie_init_port() which resets the Root Port including PHY. I don't
> > think it is safe to do it if PERST# is wired.
> 
> I don't understand, could you be a bit more verbose on why do you
> think this is dangerous?
> 

When the Root Port and PHY gets reset, there is a good chance that the refclk
would also be cutoff. So if that happens without PERST# assert, then the device
has no chance to clean its state machine. If the device gets its own refclk,
then it is a different story, but we should not make assumptions.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

