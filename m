Return-Path: <linux-pci+bounces-31991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AADB02A18
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 10:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF416563F73
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 08:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F45F26B942;
	Sat, 12 Jul 2025 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxjBjYpX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C7826B775;
	Sat, 12 Jul 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752308975; cv=none; b=Aq08wC8Ku8guTPgDDtB22L01+ckwp66HjIhkMn/zsVZzYjHUSEtriA40fKyHX4ON5UP6NWYdzfxw2f8T3yVYb7yzoDxCvHxCQZzxpeWGQCacXoSJzpgtGp1Pnsl++r1QTgA4n1qaKEI3DjwmbQdfFLbUb7Kus/3zbERyKzmxmB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752308975; c=relaxed/simple;
	bh=fY3DMvLhSnZgbH49QN8fZgcCcB8eBslJ0093fZ1HZZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFZNJDi867qookYSxqOqlBZ2TnvKy2faJJ1zKBLTuRl66CVMNBk3LCjSCNvKt+R0huEzcfctiW0qznpqBiJ/7E87ptCf6FSg9aXF0W/gPBCRdODXhniA97CN/uSXCej+CW+KKzN5TDs0OT5/h71T8XDALP2iI6ykXsZEXlzBHw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxjBjYpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84636C4CEEF;
	Sat, 12 Jul 2025 08:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752308974;
	bh=fY3DMvLhSnZgbH49QN8fZgcCcB8eBslJ0093fZ1HZZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QxjBjYpXmIg+Q5/Y7IU5jmnEe6ZC2gf/oyR8UfDAYKFzRlq10yOpHkUyoYyMG4Rgs
	 ae7T2cDUGj/jjxSBFT0ROmbrOoox1EJodOeQooydSod4ruC+E0ODuVaaf7W/0rSnFt
	 vmorSbzvI1wYaMQQ7BKt5OlTP4qG6GVhJb5rFJlXKDeayGrAip15cVo/6n9paDfPkp
	 45trZjaH71iHpUFMiJbS+w6bcX0AAXuqcngcsov34ovXtTBVIm3OdGFXTtCvbAMcwX
	 JsS0Oj7ZcBE5lNhoXxFz1GMnDCgbC6zkDJUzhsRab1nQJp9CAETX/umH0yHqRDQ5z1
	 W2htCUkGBiRCQ==
Date: Sat, 12 Jul 2025 13:59:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 2/3] PCI/pwrctrl: Allow pwrctrl core to control
 PERST# GPIO if available
Message-ID: <k5rf5azftn4mpztcjtvdxiligngmaz7fecdryv244m726y5rfd@mobway4c4ueh>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <20250707-pci-pwrctrl-perst-v1-2-c3c7e513e312@kernel.org>
 <aHGueAD70abjw8D_@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHGueAD70abjw8D_@google.com>

On Fri, Jul 11, 2025 at 05:38:16PM GMT, Brian Norris wrote:
> Sorry for so many individual reviews, but I've passed over this a few
> times and had new questions/comments several times:
> 

That's fine. I'm happy to answer as someone other than me is interested in
pwrctrl :)

> On Mon, Jul 07, 2025 at 11:48:39PM +0530, Manivannan Sadhasivam wrote:
> > PERST# is an (optional) auxiliary signal provided by the PCIe host to
> > components for signalling 'Fundamental Reset' as per the PCIe spec r6.0,
> > sec 6.6.1.
> 
> >  void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
> >  {
> > +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dev->parent);
> > +	int devfn;
> > +
> >  	pwrctrl->dev = dev;
> >  	INIT_WORK(&pwrctrl->work, rescan_work_func);
> > +
> > +	if (!host_bridge->perst)
> > +		return;
> > +
> > +	devfn = of_pci_get_devfn(dev_of_node(dev));
> > +	if (devfn >= 0 && host_bridge->perst[PCI_SLOT(devfn)])
> 
> This seems to imply a 1:1 correlation between slots and pwrctrl devices,
> almost as if you expect everyone is using drivers/pci/pwrctrl/slot.c.
> But there is also endpoint-specific pwrctrl support, and there's quite
> a bit of flexibility around what these hierarchies can look like.
> 
> How do you account for that?
> 
> For example, couldn't you have both a "port" and an "endpoint" pwrctrl? Would
> they both grab the same PERST# GPIO here? And might that incur excessive
> resets, possibly even clobbering each other?
> 

If both port and endpoint nodes are present, then only one will contain
'reset-gpios'. Right now, the DT binding only supports PERST#, WAKE#, CLKREQ#
properties in RP node, but that won't work if we have multiple lines per slot/
controller. Ideally, we would want the properties to be present in endpoint node
if available. But if we have only standard expansion slots, then it makes sense
to define them in the port node. But doing so, we can only expect the slot to
have only one instance of these properties as we cannot reliably map which
property corresponds to the endpoint.

I've opened a dtschema issue for this:
https://github.com/devicetree-org/dt-schema/issues/168

This is what I have in my mind:

1) For expansion slots:

pcie_port0{
	device_type = "pci";
	reg = <0x0 0x0 0x0 0x0 0x0>;
	bus-range = <0x01 0xff>

	reset-gpios = <>;
	wake-gpios = <>;
};

2) For endpoint nodes:

pcie_port0{
	device_type = "pci";
	reg = <0x0 0x0 0x0 0x0 0x0>;
	bus-range = <0x01 0xff>

	pcie@0 {
		reg = <0x10000 0x0 0x0 0x0 0x0>;
		reset-gpios = <>;
		wake-gpios = <>;
	};

	pcie@1 {
		reg = <0x10800 0x0 0x0 0x0 0x0>;
		reset-gpios = <>;
		wake-gpios = <>;
	};

	...
};

I don't think there is any usecase to have both slot and endpoint nodes defining
these properties.

But for your initial question on what if the platform doesn't define any supply
and uses non-GPIO based PERST#/WAKE#/CLKREQ#, I don't know how to let PCI core
create the pwrctrl device. This is something we need to brainstorm.

> Or what if multiple slots are governed by a single GPIO? Do you expect
> the bridge perst[] array to contain redundant GPIOs?
> 

It is common for devices within a slot/hierarchy to share these GPIOs (with some
drawbacks), but I'm not sure how all slots can share a single GPIO. That would
mean, if the host wants to reset one endpoint in a slot, it has to reset all the
endpoints connected to all slots. Sounds like a bizarre design to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

