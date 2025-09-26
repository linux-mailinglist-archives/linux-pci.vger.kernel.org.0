Return-Path: <linux-pci+bounces-37129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3B4BA50EB
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 22:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36751B26AFC
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 20:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8D2285060;
	Fri, 26 Sep 2025 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tp/CxQ5g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702F4284669;
	Fri, 26 Sep 2025 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758918323; cv=none; b=mvClH3MSIRadHswWgEL04HY4baQS07YFsJbjIzlPB9AEDYzh1GWjaux4OssOl2M730h4SGdDbGkJ+7tjf8SgXp0A9HzEpZiha4Bkltg0uPpm7c8zFOXFZKLsb6hULkk7+upB2wyIbhcamE37Mp8l6AXXYm+7fysuVSlm3+15nGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758918323; c=relaxed/simple;
	bh=QtssM2JLS2bcwQ9EUpp9ZJifiBkLbCEIm03Xx4xumZE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kEURuPUP6n+kmnJThZU0ZruHZ6/Yzca+FURS5UwE3bdy2sjJoof2Y4kzqH3bAVy3f57OpOQgR7gG88XYw2BzJ3CyWoKEvVS1LAlXXPPiq9NVZrWiaw5XjNx+DzfKDKredt9WS6CZElXGfbAAuRaMld0dsgjr+h1dwUsI29DQkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tp/CxQ5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3850C4CEF7;
	Fri, 26 Sep 2025 20:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758918323;
	bh=QtssM2JLS2bcwQ9EUpp9ZJifiBkLbCEIm03Xx4xumZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tp/CxQ5gjwcR342fUAjKaT8ALiUmpYRJfJAcdPoLHdJYV1GLl8fSuaUbGpu61WYOu
	 3h9xNS1xaKSS+Erz5jQiXcpVAjr+qmx4ecf57WcVHgxLTY6uV0DkmN0c0G16diwqM5
	 2ZoBgH3sro0maUU3PZ3riXz7b5kkCPr3ar/tRrlnME/xJWlVn2k72sbjwKggA91yiR
	 H/WXyL11Cbz9Y37qBe5EhWHTpiFCozCwm6sI8qdYuY9IC9nHKVm8riBvo8QkgRRENZ
	 +aR/C871KI/mc9f/d5GhS87lPZT0aQpAV5ZJ4R1Mf4f1Exb3/veHOKgMmk0mz+ZruX
	 On7+mzH0lzm0w==
Date: Fri, 26 Sep 2025 15:25:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>,
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
Message-ID: <20250926202521.GA2235281@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8833BEF8C043CB239DA074E38C1EA@AS8PR04MB8833.eurprd04.prod.outlook.com>

On Fri, Sep 26, 2025 at 03:08:30AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>

> > On Fri, Sep 26, 2025 at 02:19:37AM +0000, Hongxing Zhu wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org> On Tue, Sep 23, 2025 at
> > > > 03:39:13PM +0800, Richard Zhu wrote:
> > > > > The CLKREQ# is an open drain, active low signal that is
> > > > > driven low by the card to request reference clock. It's an
> > > > > optional signal added in PCIe CEM r4.0, sec 2. Thus, this
> > > > > signal wouldn't be driven low if it's reserved.
> > > > >
> > > > > Since the reference clock controlled by CLKREQ# may be
> > > > > required by i.MX PCIe host too. To make sure this clock is
> > > > > ready even when the CLKREQ# isn't driven low by the card(e.x
> > > > > the scenario described above), force CLKREQ# override active
> > > > > low for i.MX PCIe host during initialization.
> > > > >
> > > > > The CLKREQ# override can be cleared safely when
> > > > > supports-clkreq is present and PCIe link is up later.
> > > > > Because the CLKREQ# would be driven low by the card at this
> > > > > time.
> > > >
> > > > What happens if we clear the CLKREQ# override (so the host
> > > > doesn't assert it), and the link is up but the card never
> > > > asserts CLKREQ# (since it's an optional signal)?
> > > >
> > > > Does the i.MX host still work?
> > >
> > > The CLKREQ# override active low only be cleared when link is up
> > > and supports-clkreq is present. In the other words, there is a
> > > remote endpoint  device, and the CLKREQ# would be driven active
> > > low by this endpoint device.
> > 
> > Assume an endpoint designed to CEM r2.0.  CLKREQ# doesn't exist in
> > CEM r2.0, so even if the endpoint is present and the link is up,
> > the endpoint will not assert CLKREQ#.
> > 
> > Will the i.MX host still work?

> Yes, i.MX host still work. 
> If the endpoint designed to CEM r2.0, and CLKREQ# is reserved. The
> property suppots-clkreq wouldn't present in this scenario. Thus, the
> CLKREQ# override active low set by host driver wouldn't be cleared
> later, although the link is up and an endpoint is present.

Do you mean 'supports-clkreq' describes the *endpoint*, and you need
to change the devicetree depending on which endpoint is connected?

The schema says 'supports-clkreq' tells us whether CLKREQ# signal
routing exists, not whether the downstream device actually supports
CLKREQ#:

  https://github.com/devicetree-org/dt-schema/blob/4b28bc79fdc552f3e0b870ef1362bb711925f4f3/dtschema/schemas/pci/pci-bus-common.yaml#L155

I don't see 'supports-clkreq' in any devicetree related to imx6, so
I'm not sure this patch is needed yet.  Does it fix an existing
problem?

If it enables some future functionality, maybe we should defer it
until we're actually ready to enable that functionality?

Bjorn

