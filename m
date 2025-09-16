Return-Path: <linux-pci+bounces-36283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83110B59F01
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 19:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98A5462280
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320329D265;
	Tue, 16 Sep 2025 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnT1APbP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44CC301705;
	Tue, 16 Sep 2025 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042794; cv=none; b=EAq7y4hfnMXRChhCSXeaMfYqJiNOF2VicHPHwvDIG5Zfoh+Acc0pxnP/OA08YL9QbHU/MOteTlNedUy3NAa1O4yGgAq/6uPLBP90S5+iqw6KnDow0j8TyYpi6Q4oa9AsU3Qo5AF9/SCuuF4VYpEqAd8lCp9ypQCR5z5z9Yt7L5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042794; c=relaxed/simple;
	bh=jLictUrn0JYUJ7t9lwgxfHk/EFg/eyZVTbC02oCeQCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=U7jSggzEzVwAtFfo4zty9wEOpGC1LRc+k+hCgK1mAByOOFyJfigAU0YOx4BqC1aBHmLoRvS2aMwKXPgrqJmuvR2575k0zECDvNjaREoWZ7VORWh3NwxJp+R/Fv8DhPwZBuqUVgXJ/k91xSKnVmE0TtafyTYFySkl47Fj3mkgWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnT1APbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4C9C4CEEB;
	Tue, 16 Sep 2025 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758042794;
	bh=jLictUrn0JYUJ7t9lwgxfHk/EFg/eyZVTbC02oCeQCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gnT1APbP92Ic8ib2bgltjJzFUbJfvNAuqEYgQrI01wmJJ2MUi/SDvXxYArEhD8949
	 HION2qzL795GKG7RzSJr17bXis1CJB762VRmaC8ttuSGWMY8iptMgpSp3cGYfGRlLC
	 LMkVSRRxiLlVKUsgJINYRDb78c47VS2+D19EIpHKkicfHSQkPVuft7RobD7lbiYbrD
	 PxqCscvtNayywplIzfKOD+/wh0asR5GYeDWdAMNxZ5rGovQDJHSiMKVJKIC7A6rnk5
	 1wdE8CwLFzhxkgNDmVjuN7745WUYgutrBduNbFgMUCMKg+NeWC9w6cnvouJKORWLrf
	 5Bqj7IPZCRBLw==
Date: Tue, 16 Sep 2025 12:13:12 -0500
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
Message-ID: <20250916171312.GA1808058@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de4e4003-214f-4260-854c-d15efc81bb74@mailbox.org>

On Tue, Sep 16, 2025 at 06:31:31PM +0200, Marek Vasut wrote:
> On 9/16/25 3:57 PM, Geert Uytterhoeven wrote:
> > On Tue, 16 Sept 2025 at 15:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > > On 9/16/25 11:59 AM, Geert Uytterhoeven wrote:

> > > > This change looks correct, and fixes the timeout seen on White Hawk
> > > > with CONFIG_DEBUG_LOCK_ALLOC=y.
> > > > However, it causes a crash when CONFIG_DEBUG_LOCK_ALLOC=n:
> > > > 
> > > >       SError Interrupt on CPU0, code 0x00000000be000011 -- SError
> > > 
> > > ...
> > > 
> > > >        el1h_64_error_handler+0x2c/0x40
> > > >        el1h_64_error+0x70/0x74
> > > >        dw_pcie_read+0x20/0x74 (P)
> > > >        rcar_gen4_pcie_additional_common_init+0x1c/0x6c
> > > 
> > > SError in rcar_gen4_pcie_additional_common_init , this is unrelated to
> > > this fix.
> > > 
> > > Does the following patch make this SError go away ?
> > 
> > > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > @@ -204,6 +204,8 @@ static int rcar_gen4_pcie_common_init(struct
> > > rcar_gen4_pcie *rcar)
> > >           if (ret)
> > >                   goto err_unprepare;
> > > 
> > > +mdelay(1);
> > > +
> > >           if (rcar->drvdata->additional_common_init)
> > >                   rcar->drvdata->additional_common_init(rcar);
> > > 
> > 
> > Yes it does, thanks!
>
> So with this one extra mdelay(1), the PCIe is fully good on your side, or is
> there still anything weird/flaky/malfunctioning ?

Do we have a theory about why this delay is needed?  I assume it's
something specific to the rcar hardware (not something required by the
PCIe base spec)?

I'm seeing SError interrupts and external aborts on several arm64
systems and I'd like to understand better why they happen and when/if
we can recover from them.

Bjorn

