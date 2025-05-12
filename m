Return-Path: <linux-pci+bounces-27584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1538EAB39E0
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 15:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A531893AD6
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383691DE891;
	Mon, 12 May 2025 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rF1Ro00w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109041DE4E6;
	Mon, 12 May 2025 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058352; cv=none; b=eESiIovnKxXDdpVEPceGoQgryj4XdSXTTYvHKIfH3ByiqcL000ZWcr6ZQwngKdXJMdIyGQd2dvAcFqRh3H8AemiB8dnw9eZ8dddaaQfPXEfcFYR8j0k1TjqFSjKZxmVe5V3nztnPfDm9DbfYAJZcSu09XznNw6pGe9aTgdCBoFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058352; c=relaxed/simple;
	bh=3qQEJIUiN5/1spp7/oWnT/Aquzhhj4IjrdDSjaDXCdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHWiLBFStS7y9qRgf70aY+KvenGkwqwf1+kjzM/JnsvoeYyUHljQVda8aKCy/TMSQ/jvfpg+fb+pH+5jKauK6CFldXaToO2FaJKYNkzRlFscPKRb0jqZLgAm1IBZL63mQ2ZLsPo45RyJI+fXH6ZSm/PslPT5o/hGnaFtA+HKnck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rF1Ro00w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8F1C4AF0C;
	Mon, 12 May 2025 13:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747058351;
	bh=3qQEJIUiN5/1spp7/oWnT/Aquzhhj4IjrdDSjaDXCdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rF1Ro00wlJqFU7hZnRcuMUaDXVzMollDmF9eHqm5TBwoYtCrRCvpV4h9Q9vdr60X7
	 rbhTlg0cmvy14/sCJ2gnufdUsKrDTkV9F9fEDDlp+fl02Uj2nM85IIC3zJWWIpcuJK
	 iZaFdRBmbD4sQeZ0mtIiEmUasrLBtD4M1t7NLWEUFJCJCecQZAuhi8KiwahMq8mdo/
	 0cWRQl8kSIN2yFn3Bl9X78IXLbkaGJfA/06c6Q1cfDU2mMJt3sdzGnyMNrFBnywNQH
	 Nu6kyZIGAkv6BH2LfN1w8eBHqrM7iVyeNf8Vk1AoMjDfpWpNpfTFmugZjs/vd8ridU
	 TqTeGGR0qS1dw==
Date: Mon, 12 May 2025 08:59:09 -0500
From: Rob Herring <robh@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	dlemoal@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: pci-ep: Add ref-clk-mode
Message-ID: <20250512135909.GA3177343-robh@kernel.org>
References: <20250425092012.95418-2-cassel@kernel.org>
 <7xtp5i3jhntfev35uotcunur3qvcgq4vmcnkjde5eivajdbiqt@n2wsivrsr2dk>
 <aBHOaJFgZiOfTrrT@ryzen>
 <dxgs3wuekwjh6f22ftkmi7dcw7xpw3fa7lm74fwm5thvol42z3@wuovkynp3jey>
 <20250509181827.GA3879057-robh@kernel.org>
 <a7rfa6rlygbe7u3nbxrdc3doln7rk37ataxjrutb2lunctbpuo@72jnf6odl5xp>
 <aB8ysBuQysAR-Zcp@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB8ysBuQysAR-Zcp@ryzen>

On Sat, May 10, 2025 at 01:04:16PM +0200, Niklas Cassel wrote:
> On Sat, May 10, 2025 at 01:01:51AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, May 09, 2025 at 01:18:27PM -0500, Rob Herring wrote:
> > > > > > 
> > > > > > > +    description: Reference clocking architechture
> > > > > > > +    enum:
> > > > > > > +      - common-clk        # Common Reference Clock (provided by RC side)
> > > > > > 
> > > > > > Can we use 'common-clk-host' so that it is explicit that the clock is coming
> > > > > > from the host side?
> > > > > 
> > > > > Sure.
> > > > > 
> > > > > I take it that you prefer 'common-clk-host' over 'common-clk-rc' ?
> > > > > 
> > > > 
> > > > That's what I intended previously, but thinking more, I feel that we should
> > > > stick to '-rc'i, as that's what the PCIe spec uses.
> > > 
> > > Couldn't this apply to any link, not just a RC? Is there PCIe 
> > > terminology for upstream and downstream ends of a link?
> > > 
> > 
> > Usually, the refclk comes from the host machine to the endpoint, but doesn't
> > necessarily from the root complex. Since the refclk source could very well be
> > from the motherboard or the host system PCB, controlled by the host software.
> > 
> > > The 'common-clk' part seems redundant to me with '-rc' or whatever we 
> > > end up with added.
> > > 
> > 
> > No. It could be the other way around. We can drop the '-rc' suffix if it seem
> > redundant. Maybe that is a valid argument also since root complex doesn't
> > necessarily provide refclk and the common refclk usually comes from the host.
> 
> When the RC and EP uses a common clock (rather than separate clocks),
> the clock can either be provided by the host side or the EP side.
> 
> The most common by far (if using a common clock) is that it the common
> clock is provided by the host side. That is why my patch just named it
> 'common-clk' instead of 'common-clk-host' or 'common-clk-rc'.
> 
> I can use whatever name we agree on. I indend to send out V2 of this
> patch as part of a series that adds SRIS support to the dw-rockchip
> driver, in order to address Krzysztof's comment.
> 
> 
> > 
> > > Finally, this[1] seems related. Figure out a common solution.
> 
> I don't see the connection.
> 
> https://lore.kernel.org/all/20250406144822.21784-2-marek.vasut+renesas@mailbox.org/
> 
> does specify a reference clock, but that is in a host side DT binding.
> 
> 
> This patch adds a refclk-mode property to an endpoint side DT binding.

If we are dealing with the same property of the link, it doesn't matter 
which side. What we don't need is 2 different solutions.

> This property is needed such that the endpoint can configure the bits
> in its own PCIe Link Control Register before starting the link.
> 
> Perhaps the host side could also make use of a similar property, but I'm not
> sure, you don't know from the host side which endpoint will be plugged in.
> 
> >From the EP side, you do know if your SoC only supports common-clock or
> SRNS/SRIS, since that depends on if the board can source the clock from
> the PCIe slot or not (of all the DWC based drivers, only Qcom and Tegra
> can do so, rest uses SRNS/SRIS), so this property definitely makes sense
> in an EP side DT binding.

I don't understand why we need this in DT in the first place. Seems like 
needing to specify this breaks discoverability? Perhaps this information 
is only relevant after initial link is up and the host can read the EP 
registers?

Rob

