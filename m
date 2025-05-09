Return-Path: <linux-pci+bounces-27521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C59AB1C2D
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 20:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDA717555C
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 18:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC6C239E9D;
	Fri,  9 May 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGEunP5W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9323717F;
	Fri,  9 May 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746814709; cv=none; b=Yk4nLbQrJx+YxRYk0m8+o/mYq5Ns4G+brW3xpwpoyM0Q8kZHnnb2c/frSscotYMz82d19N8z/qvYdhU11LYL9YDfbGfyH5d+DYxmaRFx6oB79D76YWa5ZP2oDRXivFgdlndJ+nCiUC803u5pm8jWVq3p4HLg9oIlDfGuQu0I07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746814709; c=relaxed/simple;
	bh=QgkMIQSFhwC8cFW+87HfiPAgAAhFZlcFwtyVE28nzu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFgurCINyGrNJV44216W6fBnPGmSz0fJs8aTB+UmR2CNtWRGLV3Pb0lFVP9SmIk3b9koyff3Rd+4blAB+Rn1AgDkUYdFmWuNRb2RcXZmwlXMvJHD7gz0CW5auLu72hLanNQOvuXLkTXnp3UsSZZKx23QVDsnSNTzUVmBEzgRkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGEunP5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CE8C4CEE4;
	Fri,  9 May 2025 18:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746814709;
	bh=QgkMIQSFhwC8cFW+87HfiPAgAAhFZlcFwtyVE28nzu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGEunP5WIUZOiPSGqkzo+8zOFj6OlxwdggXSHKnz/xHdO8Ed9TUIm0LSFufUCHfN+
	 4ZpUAhcYmvisVBS+lzP8dw2e7lrecWsCof5NA6oCJrI9PuYpZmjrgMX4Ebtsz6r7+v
	 g3I8TXqOKjlrzkr+f5olUgPVg0UQx8PT6Yxx/cMT6gfRUJSxZvb2bvzRvGFvBMMbJu
	 5GpbiQScIuigladtokH6XQZErIkzd3xGqHw/9VMp9GcMtiRuxhg5Il3QTPqjxITXhT
	 zP3purUq+Mabv+4pV+4pAaiC5ni3jyk9qwkrzM7c99IP2SbTBLRURm3KsYVE6uIlau
	 V0+9e1DVi3k4Q==
Date: Fri, 9 May 2025 13:18:27 -0500
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	dlemoal@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: pci-ep: Add ref-clk-mode
Message-ID: <20250509181827.GA3879057-robh@kernel.org>
References: <20250425092012.95418-2-cassel@kernel.org>
 <7xtp5i3jhntfev35uotcunur3qvcgq4vmcnkjde5eivajdbiqt@n2wsivrsr2dk>
 <aBHOaJFgZiOfTrrT@ryzen>
 <dxgs3wuekwjh6f22ftkmi7dcw7xpw3fa7lm74fwm5thvol42z3@wuovkynp3jey>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dxgs3wuekwjh6f22ftkmi7dcw7xpw3fa7lm74fwm5thvol42z3@wuovkynp3jey>

On Wed, Apr 30, 2025 at 01:23:03PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Apr 30, 2025 at 09:16:56AM +0200, Niklas Cassel wrote:
> > Hello Mani,
> > 
> > On Wed, Apr 30, 2025 at 12:35:18PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Apr 25, 2025 at 11:20:12AM +0200, Niklas Cassel wrote:
> > > > While some boards designs support multiple reference clocking schemes
> > > > (e.g. Common Clock and SRNS), and can choose the clocking scheme using
> > > > e.g. a DIP switch, most boards designs only support a single clocking
> > > > scheme (even if the SoC might support multiple clocking schemes).
> > > > 
> > > > This property is needed such that the PCI controller driver, in endpoint
> > > > mode, can set the proper bits, e.g. the Common Clock Configuration bit and
> > > > the SRIS Clocking bit, in the PCIe Link Control Register (Offset 10h).
> > > > (Sometimes, there are also specific bits that needs to be set in the PHY.)
> > > > 
> > > 
> > > Thanks for adding the property. I did plan to submit something similar to allow
> > > Qcom PCIe EP controllers to run in SRIS mode.
> > > 
> > > > Some device tree bindings have already implemented vendor specific
> > > > properties to handle this, e.g. "nvidia,enable-ext-refclk" (Common Clock)
> > > > and "nvidia,enable-srns" (SRNS). However, since this property is common
> > > > for all PCI controllers running in endpoint mode, this really ought to be
> > > > a property in the common pcie-ep.yaml device tree binding.
> > > > 
> > > 
> > > We should also mark the nvidia specific properties deprecated and use this one.
> > > But that's for another follow up series.
> > > 
> > > > Add a new ref-clk-mode property that describes the reference clocking
> > > > scheme used by the endpoint. (We do not add a common-clk-ssc option, since
> > > > we cannot know/control if the common clock provided by the host uses SSC.)
> > > > 
> > > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/pci-ep.yaml | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> > > > index f75000e3093d..206c1dc2ab82 100644
> > > > --- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> > > > @@ -42,6 +42,15 @@ properties:
> > > >      default: 1
> > > >      maximum: 16
> > > >  
> > > > +  ref-clk-mode:
> > > 
> > > How about 'refclk-mode' instead of 'ref-clk-mode'? 'refclk' is the most widely
> > > used terminology in the bindings.
> > 
> > I does seem that way.
> > Will use your suggestion in V2.
> > 
> > 
> > > 
> > > > +    description: Reference clocking architechture
> > > > +    enum:
> > > > +      - common-clk        # Common Reference Clock (provided by RC side)
> > > 
> > > Can we use 'common-clk-host' so that it is explicit that the clock is coming
> > > from the host side?
> > 
> > Sure.
> > 
> > I take it that you prefer 'common-clk-host' over 'common-clk-rc' ?
> > 
> 
> That's what I intended previously, but thinking more, I feel that we should
> stick to '-rc'i, as that's what the PCIe spec uses.

Couldn't this apply to any link, not just a RC? Is there PCIe 
terminology for upstream and downstream ends of a link?

The 'common-clk' part seems redundant to me with '-rc' or whatever we 
end up with added.

Finally, this[1] seems related. Figure out a common solution.

Rob

[1] https://lore.kernel.org/all/20250406144822.21784-2-marek.vasut+renesas@mailbox.org

