Return-Path: <linux-pci+bounces-36292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9F5B5A05C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 20:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C309C3B00FD
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92342494F8;
	Tue, 16 Sep 2025 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8Ze1UX+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC2275B0F;
	Tue, 16 Sep 2025 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046563; cv=none; b=V/SaSx8jbkDYMecsRMnR9ca2BPsGOKO+Onh4STPGxAFHfPp87jCJ5P6isM6mpAxALajpwIYT/NuXhizbx6YH4ZcCaKlXEr5klvjFLPISTbovR/XUtmQC5BcaloUAkG3i78D2eD4U9wZY/1/IsdDyeuXl4Vl0T2O1TEDjHKhACHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046563; c=relaxed/simple;
	bh=96esRpRVOD+XFDViUi5Rp/BwRk1ZkQw/6FlWGRRVyNw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=diu/RvKZwv7RWgMbkCufDqSfzOivMCdI0KN48DSfCpXcDJ4e3drBliYW5o1eHi/GsOQaFWe/CGxW/opkVZXyG1/GCuTv2PobelZL8ILRomHnMS0mrsU1sKpGN2mYOLJc+S4is6gvm5oiTENGh3aAnjhu+vyu15m2nXNkusuQBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8Ze1UX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11A3C4CEEB;
	Tue, 16 Sep 2025 18:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758046560;
	bh=96esRpRVOD+XFDViUi5Rp/BwRk1ZkQw/6FlWGRRVyNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f8Ze1UX+32gcR3ijXXPy6l+L60PAkRJVsIAMzFeH3w0u8MWFfXPH59iq+ZX26EL39
	 Fl1T0zPvbXqD0KXWbPT169VmUN2/PNhDIlNPiJLEVc0fjJWsqto75s2doD//R3RaDj
	 mQp4SArXCYDu1c6kh01FBivcQsvxomaQWKCnW/6bXO79DIXo7j4MCKQbNeW2BKRlGG
	 OV/9uafqR6XItOrDJMdCMmEDzcpVI21AKPSyfjIkLuSeMDdSGwm8j033DutXxGkvVR
	 KW/Rf0EiT8FkwSkkXMcqKoik7nJpl0T8MU7sKqbT4/Hiq4GnAgXHjDzbncMnD0VAJK
	 054KMK++n9iFg==
Date: Tue, 16 Sep 2025 13:15:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY
 initialization
Message-ID: <20250916181558.GA1810654@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab002c9a-0c9c-4d8f-be5d-b2694175cc86@mailbox.org>

On Tue, Sep 16, 2025 at 07:39:07PM +0200, Marek Vasut wrote:
> On 9/16/25 7:13 PM, Bjorn Helgaas wrote:
> > On Tue, Sep 16, 2025 at 06:31:31PM +0200, Marek Vasut wrote:
> > > On 9/16/25 3:57 PM, Geert Uytterhoeven wrote:
> > > > On Tue, 16 Sept 2025 at 15:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > > > > On 9/16/25 11:59 AM, Geert Uytterhoeven wrote:
> > 
> > > > > > This change looks correct, and fixes the timeout seen on White Hawk
> > > > > > with CONFIG_DEBUG_LOCK_ALLOC=y.
> > > > > > However, it causes a crash when CONFIG_DEBUG_LOCK_ALLOC=n:
> > > > > > 
> > > > > >        SError Interrupt on CPU0, code 0x00000000be000011 -- SError
> > > > > 
> > > > > ...
> > > > > 
> > > > > >         el1h_64_error_handler+0x2c/0x40
> > > > > >         el1h_64_error+0x70/0x74
> > > > > >         dw_pcie_read+0x20/0x74 (P)
> > > > > >         rcar_gen4_pcie_additional_common_init+0x1c/0x6c
> > > > > 
> > > > > SError in rcar_gen4_pcie_additional_common_init , this is unrelated to
> > > > > this fix.
> > > > > 
> > > > > Does the following patch make this SError go away ?
> > > > 
> > > > > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > > > @@ -204,6 +204,8 @@ static int rcar_gen4_pcie_common_init(struct
> > > > > rcar_gen4_pcie *rcar)
> > > > >            if (ret)
> > > > >                    goto err_unprepare;
> > > > > 
> > > > > +mdelay(1);
> > > > > +
> > > > >            if (rcar->drvdata->additional_common_init)
> > > > >                    rcar->drvdata->additional_common_init(rcar);
> > > > > 
> > > > 
> > > > Yes it does, thanks!
> > > 
> > > So with this one extra mdelay(1), the PCIe is fully good on your side, or is
> > > there still anything weird/flaky/malfunctioning ?
> > 
> > Do we have a theory about why this delay is needed?  I assume it's
> > something specific to the rcar hardware (not something required by the
> > PCIe base spec)?
> > 
> > I'm seeing SError interrupts and external aborts on several arm64
> > systems and I'd like to understand better why they happen and when/if
> > we can recover from them.
>
> The SError here happens when the PWR RST is released and DBI is
> accessed rapidly right after that. The current hypothesis is, that
> the controller core needs a bit of time to initialize itself after
> the reset is released, before DBI access can be performed ; if the
> DBI access happens too soon after the reset was released, the core
> reject the access and CPU interprets that as SError.

Sounds like this SError is for something on the CPU side of the host
bridge.

I've also seen errors that seem to be related to errors on the PCIe
side, e.g., a PCIe Completion Timeout or Unsupported Request.  On most
platforms, those result in writes being silently dropped or ~0 data
being synthesized for reads.

E.g., this SError that seems related to a BAR programming issue:
https://lore.kernel.org/linux-pci/86plf0lgit.fsf@scott-ph-mail.amperecomputing.com/

> The reference manual however does not list any such delay, which
> makes me concerned. I can send such a patch which adds the mdelay(1)
> as a temporary stopgap fix, until some better explanation maybe
> sometimes gets uncovered, if that would be OK ?

Yeah, if it's some rcar-specific thing, I don't see a better
alternative.

Bjorn

