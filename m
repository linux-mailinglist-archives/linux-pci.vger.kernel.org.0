Return-Path: <linux-pci+bounces-10236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D27930728
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 21:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F9E1C20B28
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2024 19:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D502E403;
	Sat, 13 Jul 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiTncbKg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B718E20
	for <linux-pci@vger.kernel.org>; Sat, 13 Jul 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720899123; cv=none; b=eUFUcvW2o69SyFW6LMicNDfPZUirkrSteyPBCYN6t3LjTYWs1oHBpgWeHQ6I31LxqdeK2RdgakMPfkZPmCwBt91ccUAV5SVQZ+0CjJoC3png3Tk+RFIk8Cg25GJ3HS2cqwTBeyLjiTFrtTCBBMcHRUHqklxmyRsF/FmZco1AbL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720899123; c=relaxed/simple;
	bh=RytnnRCtAKvR5Km7Qqa/hbTzyGibJIsp0j4xPcfBwBY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Lofor/HEYbxgE8iWPllhMfLQqNKm4wy1zLzJhWXQSXOY5PA6BLlc3A8bFIMyNy1CZ08XSakTqQ26ejw+GR/7LhOh9HwRfNJ322s8CzySWvgsRDYyi0uNpK9lxdROXGMkWZ63QGjRrt9/t/v5tE162wrpmnyaH0bLgw2sA7AcefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiTncbKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAAAC32781;
	Sat, 13 Jul 2024 19:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720899122;
	bh=RytnnRCtAKvR5Km7Qqa/hbTzyGibJIsp0j4xPcfBwBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tiTncbKgCxI87hyZsX91jqLP5rzVVQJRIINWw01D4Wj3EzfJfLvZAer0bp7TxOviq
	 UR69vTy11/Q2XieJ9xpjmXPwKsJzjxnHljnssTi/nxflNWGvatydqUtuVG94n7WmSi
	 X/QCr2Z6kUZ3GxALgxdEyQfXRlPEbn6QItfZoxPnyccnLw/DfdSM9bsuQo3diQAj29
	 w3A37asvcHDs7DvxjxalIkMDUXKmU4kau0uBWfFodAVhIj8WqNSgqi+fiqi31eJMAM
	 dc+oScFGnm5G4S/Ce8K6osgRneVPmAw0WOY+pA254l7/gBCkbjOGUSlcImyxnkq2a/
	 Z+AasA+u+gQ0w==
Date: Sat, 13 Jul 2024 14:32:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] PCI: mvebu: Dispose INTx IRQs before to removing INTx
 domain
Message-ID: <20240713193200.GA374767@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sewdshs6.ffs@tglx>

On Sat, Jul 13, 2024 at 12:33:29PM +0200, Thomas Gleixner wrote:
> On Fri, Jul 12 2024 at 15:41, Bjorn Helgaas wrote:
> > On Thu, Jul 11, 2024 at 03:25:44PM +0200, Marek Behún wrote:
> >>  		/* Remove IRQ domains. */
> >> -		if (port->intx_irq_domain)
> >> +		if (port->intx_irq_domain) {
> >> +			for (int j = 0; j < PCI_NUM_INTX; j++) {
> >> +				int virq = irq_find_mapping(port->intx_irq_domain, j);
> >> +
> >> +				if (virq > 0)
> >> +					irq_dispose_mapping(virq);
> >
> > I am not an IRQ expert, so all I can really do is compare this to
> > usage in other drivers.
> >
> > There are 20+ drivers in drivers/pci/controller, and I don't see
> > irq_dispose_mapping() usage similar to this elsewhere.  Does that mean
> > most or all of the other drivers have a similar defect?
> 
> Right.
> 
> But the real question is why is such a mapping not torn down by the
> entity (device, bridge, whatever) which set it up in the first place?

Marek/Pali, the commit log mentions a crash when unloading.  Do you
have a pointer to any details?  Maybe there's a driver there that we
can fix?

Bjorn

