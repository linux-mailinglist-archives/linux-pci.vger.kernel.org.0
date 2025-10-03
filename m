Return-Path: <linux-pci+bounces-37560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C40EBB7B3C
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 19:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985B71B20820
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 17:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3ED2D9EE2;
	Fri,  3 Oct 2025 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th30eFDg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5AE2D0628;
	Fri,  3 Oct 2025 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512118; cv=none; b=J1flTy+edtpedrcC7W1sgNH8L4hawjLgQDSkB/Ia/tnustoXEhXUDJF3jSqAxFg9C9UleSM1PmdwoZ7tTx5V+WoDTiAwdj5XjA/XNVoaG9F21KEsCRTpnleFtCoOXSXantQu7GYBK6BRiYMIo/jNumY3TNIOPVrfF3DdojbcH/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512118; c=relaxed/simple;
	bh=gJyCL8uxswVnUfA7Rwci8BgxqWn7pX8aafHn3LwvUy4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RFke0WYugHNX9tWa2M+eWon/KBt2WySX2H18ONFIQfFhlRjah8Ri30BXsO6OfacWa9f7CDlUePFkwLoBR66YFPZCyhKgaB9yHh3tb+MTnWEfeYoC+FEGUgS+nUcKRGA5UnW4cIpm6WdT7s4VUYPibe8yZgwL6e6XnWE/MMpVzPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th30eFDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAA7C4CEF5;
	Fri,  3 Oct 2025 17:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759512118;
	bh=gJyCL8uxswVnUfA7Rwci8BgxqWn7pX8aafHn3LwvUy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Th30eFDgAR9AWh5/pYf4m8ToHxrvKDRYPxME7aMWPS78o9w6gaabq4RznHz9NaAnS
	 enA90sfpO8CF4nZDNrI2p9vx6Lxa0w8WyWiyKWt9qPLhqwDRlKue3a2Ztc4IuizavR
	 3grRXBqmsYav+iOJPUZMm/yL6sxnnD4sT7ULhx1jO4XpwMMVwJp0Ry9Ao6mIhIMp2b
	 z1fVIFXRsKi03U4uoop5AHsw6kYxWdbiFeHGugBOH/VIvdWIuMiy3L/tX77YCFWJR/
	 Hymy2LuptIJQ3z3E6sgLQKSyEmAhn8sypAVkhCU64Wav5pqtBza9OWr/uET8lAK97p
	 cGMcNG+TdjDkQ==
Date: Fri, 3 Oct 2025 12:21:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Message-ID: <20251003172156.GA357448@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNcXxC7cJ6yha+ff@lizhi-Precision-Tower-5810>

On Fri, Sep 26, 2025 at 06:46:28PM -0400, Frank Li wrote:
> On Fri, Sep 26, 2025 at 03:25:21PM -0500, Bjorn Helgaas wrote:
> > On Fri, Sep 26, 2025 at 03:08:30AM +0000, Hongxing Zhu wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> >
> > > > On Fri, Sep 26, 2025 at 02:19:37AM +0000, Hongxing Zhu wrote:
> > > > > > -----Original Message-----
> > > > > > From: Bjorn Helgaas <helgaas@kernel.org> On Tue, Sep 23, 2025 at
> > > > > > 03:39:13PM +0800, Richard Zhu wrote:
> > > > > > > The CLKREQ# is an open drain, active low signal that is
> > > > > > > driven low by the card to request reference clock. It's an
> > > > > > > optional signal added in PCIe CEM r4.0, sec 2. Thus, this
> > > > > > > signal wouldn't be driven low if it's reserved.
> > > > > > >
> > > > > > > Since the reference clock controlled by CLKREQ# may be
> > > > > > > required by i.MX PCIe host too. To make sure this clock is
> > > > > > > ready even when the CLKREQ# isn't driven low by the card(e.x
> > > > > > > the scenario described above), force CLKREQ# override active
> > > > > > > low for i.MX PCIe host during initialization.
> > > > > > >
> > > > > > > The CLKREQ# override can be cleared safely when
> > > > > > > supports-clkreq is present and PCIe link is up later.
> > > > > > > Because the CLKREQ# would be driven low by the card at this
> > > > > > > time.
> > > > > >
> > > > > > What happens if we clear the CLKREQ# override (so the host
> > > > > > doesn't assert it), and the link is up but the card never
> > > > > > asserts CLKREQ# (since it's an optional signal)?
> > > > > >
> > > > > > Does the i.MX host still work?
> > > > >
> > > > > The CLKREQ# override active low only be cleared when link is up
> > > > > and supports-clkreq is present. In the other words, there is a
> > > > > remote endpoint  device, and the CLKREQ# would be driven active
> > > > > low by this endpoint device.
> > > >
> > > > Assume an endpoint designed to CEM r2.0.  CLKREQ# doesn't exist in
> > > > CEM r2.0, so even if the endpoint is present and the link is up,
> > > > the endpoint will not assert CLKREQ#.
> > > >
> > > > Will the i.MX host still work?
> >
> > > Yes, i.MX host still work.
> > > If the endpoint designed to CEM r2.0, and CLKREQ# is reserved. The
> > > property suppots-clkreq wouldn't present in this scenario. Thus, the
> > > CLKREQ# override active low set by host driver wouldn't be cleared
> > > later, although the link is up and an endpoint is present.
> >
> > Do you mean 'supports-clkreq' describes the *endpoint*, and you need
> > to change the devicetree depending on which endpoint is connected?
> 
> It is NOT descript *endpoint*. supports-clkreq descript the board design,
> which connect CLKREQ# signal. Because standard slot's CLKREQ# (PIN12) is
> reserved in beggin, so some old PCIe card have not pull down this signal as
> latest spec requirement.
> 
> PCIe Standard slot with INTEL E2000 1G ethernet card, which is producted
> around 10 year ago, PIN12 is reserved.
> 
> So we don't set supports-clkreq for stardard PCI slot, only set it for
> M.2 slot. So stardard PCI slot in imx95 evk can support most cards. We have
> not vendor card lists, which already connect/not connect CLKREQ#, so we
> have to fallback to disconnect CLKREQ# situation by clarm our evk board
> have not connect CLKREQ# to make all card works, eventhough it lost power
> save feature. work is more impantant then power saving.
> 
> > The schema says 'supports-clkreq' tells us whether CLKREQ# signal
> > routing exists, not whether the downstream device actually supports
> > CLKREQ#:
> >
> >   https://github.com/devicetree-org/dt-schema/blob/4b28bc79fdc552f3e0b870ef1362bb711925f4f3/dtschema/schemas/pci/pci-bus-common.yaml#L155
> >
> > I don't see 'supports-clkreq' in any devicetree related to imx6, so
> > I'm not sure this patch is needed yet.  Does it fix an existing
> > problem?
> 
> The patch adding 'supports-clkreq' in dts is on going. No funtional broken
> because it just impact l1ss power saving features.
> 
> > If it enables some future functionality, maybe we should defer it
> > until we're actually ready to enable that functionality?
> 
> Actually, it fixes i.MX95 19x19 EVK second slot problem. At least
> INTEL E2000 1G ethernet card can't work at i.MX95 EVK boards at main
> stream kernel without this patch.

I deferred these two patches so we have time to tidy these up:

  - Coordinate with adding 'supports-clkreq' in devicetrees.

  - Fix the imx95 refclk enable that was missed in the v5 series.

  - Consider making imx95 refclk enable parallel to the other
    versions, e.g., by using .enable_ref_clk() instead of doing it in
    imx95_pcie_init_phy().

  - Describe the "i.MX95 19x19 EVK second slot problem" in the commit
    log.  Possibly split that into a second patch if it can be
    separated from the CLKREQ# override.  It sounds like this part
    doesn't depend on 'supports-clkreq' in a devicetree?

Maybe we can also figure out how to explain why CLKREQ# override is an
issue for imx6 but not for other DWC-based drivers.

Bjorn

