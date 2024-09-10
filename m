Return-Path: <linux-pci+bounces-13011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74424974171
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 19:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D24A2847B1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A8E1A3BCA;
	Tue, 10 Sep 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crV/1QrB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC43A1A3BAF;
	Tue, 10 Sep 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991170; cv=none; b=n6ik3KHBMGRp1kzCmm9rdpfNa09ns34P1zEPEyy4BqvoxVV4OeVqWPRIYn6q+fMoc3UUcU0i1yCxf7OwGlyybDJmPlcz54BcKFbPkUldJdCSdxbw+/Bs2U4ygTdGjNqwlV/NUhysj+X6edW+ALp7ZKE6CanNad89+ErwLvp4bJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991170; c=relaxed/simple;
	bh=2CwoTyoBU8Cyahl9bkaERJ3bw5QE6HHOa8rGrLy7A94=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dXPUrkTs20pg7+ZLnqQFr/12WDS1rVuaV6P0uKNCHwaMe/JT8hJTU3Fm/Y2is7iXXWEPqxb7PSmLAGioOcEKlyEs136QRT7/wPYNK79qtrJKk8Iz6AseO3UyPQvzcwUOY3yCW20dde0FqdLlwFnOxn7NWQmBlDIWZWOEdyU6Zug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crV/1QrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3145BC4CEC3;
	Tue, 10 Sep 2024 17:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725991169;
	bh=2CwoTyoBU8Cyahl9bkaERJ3bw5QE6HHOa8rGrLy7A94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=crV/1QrB7exGQ5wTtH1y64D2zlSbwamqVTrSRLEU7DIQrE4XstcdwB1W9JqUbfMA0
	 3b3fmD12ZzOPGrUAIe90jORTfy45zHGEWWBUaPcClTnunsT0HIc2GDgicjOLG79To8
	 d3j799fXRizJM2pgXqqXgAZztb9kAHr8/o30FNmgtNSqaBtA4d9jDQujLQEiuAtkcm
	 OSkahkr1HccOOrH9LMXl1xIgxeW5U+2P0MxX98od0cUvfILqtkvlrbI7Aux70+T1DW
	 on9bBcuPN4FLc45FWAd2tVxqCG5ejqUEQtrbm1GzAKOiiAD1dAPYmE41gsvt1R+bXe
	 N9O5v+NbEWWrg==
Date: Tue, 10 Sep 2024 12:59:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
Message-ID: <20240910175927.GA590299@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNxfmeBhHK57pUGtJEbBCuhEi8TQCVFPxPbAutkpJVwksA@mail.gmail.com>

On Tue, Sep 10, 2024 at 01:30:41PM -0400, Jim Quinlan wrote:
> On Tue, Sep 3, 2024 at 10:26 AM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> > On Mon, Sep 2, 2024 at 3:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Aug 15, 2024 at 06:57:18PM -0400, Jim Quinlan wrote:
> > > > The 7712 SOC has a bridge reset which can be described in the device tree.
> > > > Use it if present.  Otherwise, continue to use the legacy method to reset
> > > > the bridge.
> > >
> > > >  static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
> > > >  {
> > > > -     u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > > > -     u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> > > > +     if (val)
> > > > +             reset_control_assert(pcie->bridge_reset);
> > > > +     else
> > > > +             reset_control_deassert(pcie->bridge_reset);
> > > >
> > > > -     tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > > -     tmp = (tmp & ~mask) | ((val << shift) & mask);
> > > > -     writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > > +     if (!pcie->bridge_reset) {
> > > > +             u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > > > +             u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> > > > +
> > > > +             tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > > +             tmp = (tmp & ~mask) | ((val << shift) & mask);
> > > > +             writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > > +     }
> > >
> > > This pattern looks goofy:
> > >
> > >   reset_control_assert(pcie->bridge_reset);
> > >   if (!pcie->bridge_reset) {
> > >     ...
> > >
> > > If we're going to test pcie->bridge_reset at all, it should be first
> > > so it's obvious what's going on and the reader doesn't have to go
> > > verify that reset_control_assert() ignores and returns success for a
> > > NULL pointer:
> > >
> > >   if (pcie->bridge_reset) {
> > >     if (val)
> > >       reset_control_assert(pcie->bridge_reset);
> > >     else
> > >       reset_control_deassert(pcie->bridge_reset);
> > >
> > >     return;
> > >   }
> > >
> > >   u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > >   ...
> > >
> > Will do.
> 
> Hi Bjorn,
> 
> It is not clear to me if you want a new series -- which would be V7 --
> or you are okay with the current series V6.  If the latter, someone
> sent in a fixup commit which must be included.
> Please advise.

Krzysztof amended this on the branch.  Take a look here and verify
that it makes sense to you:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-brcmstb.c?h=controller/brcmstb#n752

If that looks right to you, no need to post a new v7.

I think Krzysztof also integrated an "int num_inbound_wins" fix; is
that the one you mean?  If I'm thinking of the right one, you can
check that at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-brcmstb.c?h=controller/brcmstb#n1034

> > > Krzysztof, can you amend this on the branch?
> > >
> > > It will also make the eventual return checking and error message
> > > simpler because we won't have to initialize "ret" first, and we can
> > > "return 0" directly for the legacy case.
> > >
> > > Bjorn



