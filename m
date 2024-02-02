Return-Path: <linux-pci+bounces-3053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3B1847C89
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 23:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622B528F92E
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 22:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16569126F38;
	Fri,  2 Feb 2024 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su95Moq8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D174A12C7F1;
	Fri,  2 Feb 2024 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914279; cv=none; b=Ja69yV/GXAU3uzNj+kf+pk+jwWLAfFmGRT43yt3M/cmjknzDYfbuuAcDja6VOsm2K9Z/wAiBisApwM4WbhVMhhOHIykcDWzvZah6dlhRudQuQb+OpUre7EXnVSsHPYAXXukHFgHLJjzpLlJnHRKtQqjwyB+h17CrBoBUtwPC9yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914279; c=relaxed/simple;
	bh=qyAXgTBLLnh8SxD11iUAbf5QXHShn7TzaQqXX7GyvVU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=izw5GMxI4qHAz9/qH8sKUyc6FgxjQ1NhSnn0Sy9dQv+pHPakgCnol1Pl+8yG/efdygD+QCyfEK7JYX2ZsV5UdqZILtHK+h2giGR9p2rqDXT5XULb8yHsvoyuz+E9X7TIWUSXQirpU0BdfRRAFaCrvfjkfaymeXyAKEicoGbRTQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=su95Moq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286A6C43390;
	Fri,  2 Feb 2024 22:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706914278;
	bh=qyAXgTBLLnh8SxD11iUAbf5QXHShn7TzaQqXX7GyvVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=su95Moq88Nxy71XnTsLYPUhqiJNf7+84hTe2WOhFiR/k43Bz3yuNIyS0Emk0N+SxK
	 kfN3BgtafQxLef9wu0PDcnYnKyemL5IwEd40YuxbCMdOZqry7M9o++6WdqrmK6SAiu
	 wMr8enCyRbRG/R6QDVLtswIRVSHsiFP32V7+3rX6BlekOXDlSBCxvw5TFMOyZp2vKi
	 AgxOIIurWCjKnZcYYQzBFyI5/64jy/bNw1CFzvkMY/gBRSzg+iSTA1F28muCmzkoBQ
	 200pSm+umS39YPymHDGC4V+D4Qk/wua+6ieG9b6oNPq55uHUiRn+dbf+4lWkawEWxZ
	 iKAhbDKVxmOsw==
Date: Fri, 2 Feb 2024 16:51:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>, Rob Herring <robh+dt@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v9 05/16] PCI: imx6: Using "linux,pci-domain" as slot ID
Message-ID: <20240202225116.GA732628@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb1rD4WK5D0ckKos@lizhi-Precision-Tower-5810>

[Rob to to: line]

On Fri, Feb 02, 2024 at 05:22:07PM -0500, Frank Li wrote:
> On Fri, Feb 02, 2024 at 03:54:31PM -0600, Bjorn Helgaas wrote:
> > On Fri, Jan 19, 2024 at 12:11:11PM -0500, Frank Li wrote:
> > > Avoid use get slot id by compared with register physical address. If there
> > > are more than 2 slots, compared logic will become complex.
> > > 
> > > "linux,pci-domain" already exist at dts since commit:
> > > 	commit (c0b70f05c87f3b arm64: dts: imx8mq: use_dt_domains for pci node).
> > > 
> > > So it is safe to remove compare basic address code:
> > > 	...
> > > 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > > 		imx6_pcie->controller_id = 1;
> > > 	...
> > 
> > I have no idea what this is telling me.  I guess you don't want to use
> > IMX8MQ_PCIE2_BASE_ADDR to decide something?  That much sounds good:
> > the *address* of some MMIO space doesn't tell us anything about the
> > function of that space.
> 
> You are right. If there are more than two controller. The check logic
> will be extremely complex.
> 
> There are some discussin at below thread about linux,pci-domain
> https://lore.kernel.org/imx/20231206165953.GA717921@bhelgaas/

My response here was too low level, just about trivial syntactic and
style issues.  I should have seen the larger issue at the time; sorry
about that.

> https://lore.kernel.org/imx/20231217175158.GF6748@thinkpad/

That's a good response from Mani, but again not relevant to my point.

My point here is that "compatible" should tell the driver how to
operate the device, i.e., the driver knows what registers are present
and how they work.

If you have two variant devices that both implement a register that
can be used to distinguish them, a single "compatible" string might be
enough because the driver can use that register to tell the
difference.

If the driver can't tell the difference by looking at the hardware
itself, I think you need a separate "compatible" string for it.  Of
course I'm far from a DT expert, so please correct this if necessary,
Rob, et al.

> > I expect the "compatible" string to tell the driver what the
> > programming model of the device is.
> > 
> > > +	/* Using linux,pci-domain as PCI slot id */
> > > +	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
> > > +	/*
> > > +	 * If there are no "linux,pci-domain" property specified in DT, then assume only one
> > > +	 * controller is available.
> > > +	 */
> > > +	if (imx6_pcie->controller_id == -EINVAL)
> > > +		imx6_pcie->controller_id = 0;
> > > +	else if (imx6_pcie->controller_id < 0)
> > > +		return dev_err_probe(dev, imx6_pcie->controller_id,
> > > +				     "linux,pci-domain have wrong value\n");
> > 
> > Maybe I'm missing something here.  It looks like this driver uses
> > controller_id to distinguish between hardware variants or maybe
> > between two Root Ports (slots?) in the same SoC?
> 
> Yes!
> 
> >   imx6_pcie_grp_offset
> >     return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
> > 
> >   imx6_pcie_configure_type
> >     id = imx6_pcie->controller_id
> >     if (!drvdata->mode_mask[id])         # <-- looks unsafe
> 
> I can add safe check here.
> 
> >       id = 0;
> >     regmap_update_bits(drvdata->mode_off[id], ...)
> > 
> > (This "mode_mask[id]" looks like it will reference garbage if the DT
> > supplies "linux,pci-domain = <2>".  A bogus DT shouldn't be able to
> > cause a driver to misbehave like that.)
> 
> Suppose I can use dt-bind doc to force to 0,1 and safe check here.

Nope.  The driver must protect itself from garbage in the DT.

> > That doesn't seem related to "linux,pci-domain" at all.
> 
> I added comments about
> /* Using linux,pci-domain as PCI slot id */

That doesn't make it related :)

> We may add new property about controller-id, but there already have common
> one "linux,pci-domain", which value in upstreamed dts exactly match our
> expection, I also found other platform use it as slot id in kernel tree.
> 
> Any way, we can continue discuss the better solution here. But I hope
> it was not block whole 16 patches. we can skip this one firstly.
> 
> I still have more than 10 clean up patches my local tree.
> 
> > 
> > Bjorn

