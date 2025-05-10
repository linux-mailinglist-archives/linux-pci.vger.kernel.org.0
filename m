Return-Path: <linux-pci+bounces-27540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80283AB2383
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 13:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E7B7A784B
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 11:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4881D5CF2;
	Sat, 10 May 2025 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi9iS54B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542C1259C;
	Sat, 10 May 2025 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746875062; cv=none; b=otkS4tZaTjbdp1+DlR/NzOydhwGvMIO1VG2r/+WkYHRYJ0dYqGVZXG63T75DKjUOwW3McaAep9+8/Hz3u+L8l4iD4c95fP/0jCQwWYdksnjhNW4v6XjfdTWC8IurtCT132sO5ZPfMJouwXNzkhr6M7edbrQ54ac3KS/+ln/2Lck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746875062; c=relaxed/simple;
	bh=LnCr8g0K3kFovNAfIBhC2oA0dXw5uMqRwlfONu06Ff4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXxIR3FQQLjwE4uhyJGIu9Vv1m68LfUHadVQby9UfLS82h4wwhHUyUunURqXv6O3kSXMAynwzIrqcIrmWlhd8jsrkQsXdSNZkySiRf48Gf/TfLT0driyAi2ZrhLK1O2bJEDA7B8+uSesMZEZwKuxc5BGTxKdHGcrkRx/0hNjVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi9iS54B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEAEC4CEE2;
	Sat, 10 May 2025 11:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746875061;
	bh=LnCr8g0K3kFovNAfIBhC2oA0dXw5uMqRwlfONu06Ff4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zi9iS54BLj0T5mXRojSJXhPL94LXj7hCQ+/I1xdk2P4NXw+CAhe/Wf16Tkh+1LeWL
	 I2HULSYCpdvR9Ec/a/lV0cBaUEv5yPIkIGg7uZQFb10tVi+k0ADJ2bEqFqYy5f0PoT
	 zOAVMhR0OiHhYFKU5Zd3vh8EVkbxof0lF5yQemN0sDDJ3oXLBPfkIPfr0FVs7JlzTV
	 0NMNjnIgfiQLgzZLAmdBYuVbxUfywp5GlK1lSGv2mgPNjPMafWt3Z9wAovA4Zax31l
	 rJIVFoZCkZ/5eXPA2hFuU8UyNNuf07KWWbSU92+AKjxgBLDQ2nIGoKz6Xt9Ujmsui2
	 ij+0/jcsMlu1Q==
Date: Sat, 10 May 2025 13:04:16 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	dlemoal@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: pci-ep: Add ref-clk-mode
Message-ID: <aB8ysBuQysAR-Zcp@ryzen>
References: <20250425092012.95418-2-cassel@kernel.org>
 <7xtp5i3jhntfev35uotcunur3qvcgq4vmcnkjde5eivajdbiqt@n2wsivrsr2dk>
 <aBHOaJFgZiOfTrrT@ryzen>
 <dxgs3wuekwjh6f22ftkmi7dcw7xpw3fa7lm74fwm5thvol42z3@wuovkynp3jey>
 <20250509181827.GA3879057-robh@kernel.org>
 <a7rfa6rlygbe7u3nbxrdc3doln7rk37ataxjrutb2lunctbpuo@72jnf6odl5xp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7rfa6rlygbe7u3nbxrdc3doln7rk37ataxjrutb2lunctbpuo@72jnf6odl5xp>

On Sat, May 10, 2025 at 01:01:51AM +0530, Manivannan Sadhasivam wrote:
> On Fri, May 09, 2025 at 01:18:27PM -0500, Rob Herring wrote:
> > > > > 
> > > > > > +    description: Reference clocking architechture
> > > > > > +    enum:
> > > > > > +      - common-clk        # Common Reference Clock (provided by RC side)
> > > > > 
> > > > > Can we use 'common-clk-host' so that it is explicit that the clock is coming
> > > > > from the host side?
> > > > 
> > > > Sure.
> > > > 
> > > > I take it that you prefer 'common-clk-host' over 'common-clk-rc' ?
> > > > 
> > > 
> > > That's what I intended previously, but thinking more, I feel that we should
> > > stick to '-rc'i, as that's what the PCIe spec uses.
> > 
> > Couldn't this apply to any link, not just a RC? Is there PCIe 
> > terminology for upstream and downstream ends of a link?
> > 
> 
> Usually, the refclk comes from the host machine to the endpoint, but doesn't
> necessarily from the root complex. Since the refclk source could very well be
> from the motherboard or the host system PCB, controlled by the host software.
> 
> > The 'common-clk' part seems redundant to me with '-rc' or whatever we 
> > end up with added.
> > 
> 
> No. It could be the other way around. We can drop the '-rc' suffix if it seem
> redundant. Maybe that is a valid argument also since root complex doesn't
> necessarily provide refclk and the common refclk usually comes from the host.

When the RC and EP uses a common clock (rather than separate clocks),
the clock can either be provided by the host side or the EP side.

The most common by far (if using a common clock) is that it the common
clock is provided by the host side. That is why my patch just named it
'common-clk' instead of 'common-clk-host' or 'common-clk-rc'.

I can use whatever name we agree on. I indend to send out V2 of this
patch as part of a series that adds SRIS support to the dw-rockchip
driver, in order to address Krzysztof's comment.


> 
> > Finally, this[1] seems related. Figure out a common solution.

I don't see the connection.

https://lore.kernel.org/all/20250406144822.21784-2-marek.vasut+renesas@mailbox.org/

does specify a reference clock, but that is in a host side DT binding.


This patch adds a refclk-mode property to an endpoint side DT binding.

This property is needed such that the endpoint can configure the bits
in its own PCIe Link Control Register before starting the link.

Perhaps the host side could also make use of a similar property, but I'm not
sure, you don't know from the host side which endpoint will be plugged in.

From the EP side, you do know if your SoC only supports common-clock or
SRNS/SRIS, since that depends on if the board can source the clock from
the PCIe slot or not (of all the DWC based drivers, only Qcom and Tegra
can do so, rest uses SRNS/SRIS), so this property definitely makes sense
in an EP side DT binding.


Kind regards,
Niklas

