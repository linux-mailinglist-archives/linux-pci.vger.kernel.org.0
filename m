Return-Path: <linux-pci+bounces-16064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 744D99BD332
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 18:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6401F23466
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 17:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0981C3050;
	Tue,  5 Nov 2024 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyRuaU3m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C20166F1A;
	Tue,  5 Nov 2024 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827111; cv=none; b=hJwLzcxQVr1vnn1G0ByLl8f/n9xYXWT1DYCTPwKBHB4EUWdH9mWsYSW5vFwSJ4xIzn5aUVA7TOx+CEO6PQNWW6U7TyVNEK7gpeo+HbDPAsngwGea9LZGqgZXMxg7zuLBX8mYAmChz0f68iEdYfbLpHU4S1i0VWE8YNaJ+mS79YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827111; c=relaxed/simple;
	bh=9swtDu2MiH44n97pp1Y1dGpeIR7FF3ZuO/eaWS+/fms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FqfftHhCRr3CZPdZ9YaY5G8tHk7uE89h1CAIsJ3gx5uYx6jhZ/OW+tZZJNmwZX+tyd8xoOFCsCBIukKYvecSe2knfJpYSeQHKn9NKUK2QTozUOZe1F9ngil52qszCGilIAaeGsCiRn482MftQWRtF9SA2ZwKzqyDwAQrAbs00kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyRuaU3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA699C4CECF;
	Tue,  5 Nov 2024 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730827110;
	bh=9swtDu2MiH44n97pp1Y1dGpeIR7FF3ZuO/eaWS+/fms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NyRuaU3mAqVyBJ2Cdj7wtgjmaCAPEROP8WeCLFEDLXTtWYJ8LvAEnx41zJTF19TZR
	 WqNiCmQeYYppdQ/G7coVDO99ruUXbINQnnjX0jV0nVx2fUwsXGUeOOzB+ZVwt01Dat
	 CwLkpQ62vQHoZM1x8Q1WPdsQfGQJsM7YuVbMbSwSL23Xo1CPBzT4h1W8HjT8TVJdUp
	 5jng8y7vU44SbyjS4eoQ7f9aaJVsrRfw+MySbATBvgHaXdihocDaZSZxGuBXX94NbT
	 CMqhkOdLGphKcMFR3tByCtnx/a8GPTnPkE0InsbOiM54BBtCx/7PPqTTQPHHWPncZJ
	 ixdkddyDGx3PQ==
Date: Tue, 5 Nov 2024 11:18:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-pci@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 2/2] PCI: microchip: rework reg region handing to
 support using either instance 1 or 2
Message-ID: <20241105171828.GA1474726@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104-stabilize-friday-94705c3dc244@spud>

On Mon, Nov 04, 2024 at 11:18:43AM +0000, Conor Dooley wrote:
> On Fri, Nov 01, 2024 at 02:51:29PM -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 14, 2024 at 09:08:42AM +0100, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > > 
> > > The PCI host controller on PolarFire SoC has multiple "instances", each
> > > with their own bridge and ctrl address spaces. The original binding has
> > > an "apb" register region, and it is expected to be set to the base
> > > address of the host controllers register space. Defines in the driver
> > > were used to compute the addresses of the bridge and ctrl address ranges
> > > corresponding to instance1. Some customers want to use instance0 however
> > > and that requires changing the defines in the driver, which is clearly
> > > not a portable solution.
> > 
> > The subject mentions "instance 1 or 2".
> > 
> > This paragraph implies adding support for "instance0" ("customers want
> > to use instance0").
> > 
> > The DT patch suggests that we're adding support for "instance2"
> > ("customers want to use instance2").
> > 
> > Both patches suggest that the existing support is for "instance 1".
> > 
> > Maybe what's being added is "instance 2", and this commit log should
> > s/instance0/instance 2/ ?  And probably s/instance1/instance 1/ so the
> > style is consistent?
> 
> Hmm no, it would be s/instance1/instance 2/ & s/instance0/instance 1/.
> The indices are 1-based, not 0-based.
> 
> > Is this a "pick one or the other but not both" situation, or does this
> > device support two independent PCIe controllers?
> > 
> > I first thought this driver supported a single PCIe controller, and
> > you were adding support for a second independent controller.
> 
> I don't know if they are fully independent (Daire would have to confirm)
> but as far as the driver in linux is concerned they are. As far as I
> know, you could operate both instances at the same time, but I've not
> heard of any customer that is actually doing that nor tested it myself.
> Operating both instances would require another node in the devicetree,
> which should work fine given the private data structs are allocated at
> runtime. I think the config space is shared.
> 
> > But the fact that you say "the [singular] host controller on
> > PolarFire", and you're not changing mc_host_probe() to call
> > pci_host_common_probe() more than once makes me think there is only a
> > single PCIe controller, and for some reason you can choose to operate
> > it using either register set 1 or register set 2.
> 
> The wording I've used mostly stems from conversations with Daire. We've
> kinda been saying that there's a single controller with two root port
> instances. 

If these are two separate Root Ports, can we call them "Root Ports"
instead of "instances"?  Common terminology makes for common
understanding.

> Each root port instance is connected to different IOs,
> they're more than just different registers for accessing the same thing.

Sounds like some customers use Root Port 1 and others use Root Port 2,
maybe based on things like which pins are more convenient to route.

I would very much like to reword these commit logs using as much
standard PCIe terminology as possible.  Most of these native PCIe
controller drivers have Root Complex and Root Port concepts all mixed
together, and anything we can do to standardize them will be a
benefit.

Bjorn

