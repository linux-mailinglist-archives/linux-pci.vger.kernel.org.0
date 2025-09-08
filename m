Return-Path: <linux-pci+bounces-35677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F3CB49434
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 17:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C14188701C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1CE21255E;
	Mon,  8 Sep 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8dmRxuo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BB61FF61E;
	Mon,  8 Sep 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346588; cv=none; b=uSKRlvFF1wksI7z2xzr2UP6SpbjtEdoNcHNqckWBBccxzInjvXFX6ZpNvwxECq01X62bVFL6KDGjO2CvW+iaAb9ycy0QLHyGt26FFZL8tf0EAlNAVc2erB0IT+lW9YGSE3NmWZ9FxcVIy0Jdn3y8/rfpjCCGoJWmsY2mslV71D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346588; c=relaxed/simple;
	bh=QEkG6MGFd6wCgyTdrMCBAh2H91botqbPD1Iua5pCB8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiQi5LR48z2ZMjUQzlJ8GNfeHKnzysjztXxU9gOklctROGapOhu0eVyDOL5AxRDYOo3t+R9eJC2pF4NmN0bA8KmhQvNLSpgELQHZHRkcBypmhyPgEFKiu7zN2CNthOlb/D9aW0sfstmNKRLanxWtqNbJe1azOFhcrseQUHcwlo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8dmRxuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1985EC4CEF1;
	Mon,  8 Sep 2025 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346588;
	bh=QEkG6MGFd6wCgyTdrMCBAh2H91botqbPD1Iua5pCB8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8dmRxuoPPXoDzHo2FzdAlM6Wn+oBq6eoOkCPnirxucLaTnwKXBbNAxxxF2xxAgMe
	 lk24oN0d7WTo3wyANolZi3fQVDMscP7BBCPtaXIQJt5kHx781aJOwtx0bDjXn+/fwr
	 sVffPrHZIpkjtWVVt7k6TNDApA6bg2a0xpXeihDWmVD4pkmpwe7cuOmdMJHxF1aUZp
	 2xRdsV8tkeeCXsmOJslX1O7Bq+b9/BglGS+4KzygcmjjyUtl1d00EULx8P+aoaf1ox
	 33cV4a4jAiwrIkEZ6NF4K9rgXnF4Bnki3/p1D60gSX0IO21WND2hgPnxER838llfgA
	 rI8G6G82+Xz/A==
Date: Mon, 8 Sep 2025 21:19:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Message-ID: <ruhcvw3oqalrspkbl4ay5vebomatww6wbirwzowxyqxq7sdjou@yba5ri45j24w>
References: <20250820081048.2279057-1-hongxing.zhu@nxp.com>
 <20250820081048.2279057-3-hongxing.zhu@nxp.com>
 <ryvt2k2blew5wisy7edkjqdcmulrwey7lkeriasrmvaigpe3ku@vdgkod2bf7ma>
 <aL71k+CeZEwTnn86@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aL71k+CeZEwTnn86@lizhi-Precision-Tower-5810>

On Mon, Sep 08, 2025 at 11:26:11AM GMT, Frank Li wrote:
> On Mon, Sep 08, 2025 at 11:36:02AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Aug 20, 2025 at 04:10:48PM GMT, Richard Zhu wrote:
> > > The CLKREQ# is an open drain, active low signal that is driven low by
> > > the card to request reference clock.
> > >
> > > Since the reference clock may be required by i.MX PCIe host too.
> >
> > Add some info on why the refclk is needed by the host.
> >
> > > To make
> > > sure this clock is available even when the CLKREQ# isn't driven low by
> > > the card(e.x no card connected), force CLKREQ# override active low for
> > > i.MX PCIe host during initialization.
> > >
> >
> > CLKREQ# override is not a spec defined feature. So you need to explain what it
> > does first.
> >
> > > The CLKREQ# override can be cleared safely when supports-clkreq is
> > > present and PCIe link is up later. Because the CLKREQ# would be driven
> > > low by the card in this case.
> > >
> >
> > Why do you need to depend on 'supports-clkreq' property? Don't you already know
> > if your platform supports CLKREQ# or not? None of the upstream DTS has the
> > 'supports-clkreq' property set and the NXP binding also doesn't enable this
> > property.
> 
> It is history reason. Supposed all the boards which supports L1SS need set
> 'supports-clkreq' in dts. L1SS require board design use open drain connect
> RC's clk-req and EP's clk-req together, which come from one ECN of PCI
> spec.
> 
> But most M.2 slot now, which support L1SS, so most platform default enable
> L1SS or default 'supports-clkreq' on.
> 
> Ideally, 'supports-clkreq' should use revert logic like 'clk-req-broken'.
> but 'supports-clkreq' already come into stardard PCIe binding now.
> 
> One of i.MX95 boards use standard PCIe slot, PIN 12
> 12	CLKREQ#	Ground	Clock Request Signal[26]
> which is reserved at old PCIe standard, so some old PCIe card float this
> pin.
> 

Ok. IIUC, i.MX platforms doesn't always support CLKREQ#, as the pin might not be
wired on some connectors. So if the driver turns off the override, CLKREQ# will
be driven high, but the endpoint wouldn't get a chance to drive it low and it
won't receive the refclk.

Is my understanding correct?

I'm wondering in those cases, why can't you keep the CLKREQ# pin to be in
active low state by defining the initial pinctrl state in DT? Can't you change
the pinctrl state of CLKREQ#?

> So I think most dts in kernel tree should add 'supports-clkreq' property
> if they use M.2 and connect CLK_REQ# as below [1]
> ============================================
>               VCC
>               ---
>                |
>                R (10K)
>                |
> CLK_REQ# (RC)------ CLK_REQ#(EP)
> 
> NOT add supports-clkreq if connect as below [2]
> ==========================================
> 
> CLK_REQ# (RC)  ---> |---------|
>                     | OR GATE | ---> control ref clock
> CLK_REQ#(EP)   ---> |-------- |
> 
> 
> >
> > So I'm wondering how you are suddenly using this property. The property implies
> > that when not set to true, CLKREQ# is not supported by the platform. So when the
> > driver starts using this property, all the old DTS based platforms are not going
> > to release CLKREQ# from driving low, so L1SS will not be entered for them. Do
> > you really want it to happen?
> 
> Actually, some old board use [2]. we will add supports-clkreq if board
> design use [1], so correct reflect board design.
> 

Ok, thanks for clarifying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

