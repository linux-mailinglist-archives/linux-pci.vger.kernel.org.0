Return-Path: <linux-pci+bounces-34596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF9B31F93
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DC2661490
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF5534A32E;
	Fri, 22 Aug 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gkm3JskI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BBE34A324;
	Fri, 22 Aug 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876974; cv=none; b=UMHp4GOJPQ8BVIGbVrQd0Ikmu4W7wR9MYh4B8BydHzS79yEVrxT0RaYPu+YR0asVHXuYvAaMfYxwCVNVQuns3RkAg9TXyTyy1tNtukscrUKmz3xBpNBITa+MfXgfY8Yjx7s1/ZfQEuRjFNAPwyrleM8EodLwcds7gZjHbDUqYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876974; c=relaxed/simple;
	bh=M4axMQs8H13c09qWo6K3CitPMFiulFvZkPJOaBof5qk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o2Ob5mdBgrZP5JoFZ9w4FbA3nXtRT7li1NESUsEiRpmSurZwg3LvDRpGYgvtNqnornkg1a4jr/rjHCd8U8m49J+ipi1YwhAmaiSnUzCz0xPuKtClA8KC9FjzriW2draMdgy6D2nMc0Np7FBFt4ZoUphkAfOceDBe5AELfsxQMcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gkm3JskI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AE6C4CEED;
	Fri, 22 Aug 2025 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755876974;
	bh=M4axMQs8H13c09qWo6K3CitPMFiulFvZkPJOaBof5qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Gkm3JskIl9AEISSDTxGOPEQ5Ekw+yO/AvQdomznGVF8QhL2AKSjB9ug0fr1l8cDAC
	 R5sn0gLRNWsiAEXDV/8IqKrKhmFhfaIV0eZ2Ifeh4tLF63tK6IWjZnREefRXi/M03D
	 sonYkEFxAHk5WnTO9vZYeGm/kLZ++fqGgDYfTihFHvZFAojKUxRz39rTZqvajG+zmS
	 C5cdC9xRurIk0OtWquWGUHHvSsQMbdCi9wn8LX+sUhjGWTlzoGERhtdVdDoJXui0e5
	 RMD+nlwye1ZCE/pFkHY1ti7fjopPKBrl36OGkQOSbkQ95P59TCZ58RYnkJ70Qa5E+H
	 M8+0Xh8w08Hdg==
Date: Fri, 22 Aug 2025 10:36:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [PATCH v2 09/10] PCI:
 aspeed: Add ASPEED PCIe RC driver
Message-ID: <20250822153611.GA684739@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134692DCCFD55F5ABD812F39D3DA@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Fri, Aug 22, 2025 at 07:00:25AM +0000, Jacky Chou wrote:
> > v1 posting was
> > https://lore.kernel.org/r/20250613033001.3153637-1-jacky_chou@aspeedtech
> > .com
> > Links to previous postings are helpful in the cover letter.
> > 
> > On Tue, Jul 15, 2025 at 11:43:19AM +0800, Jacky Chou wrote:
> > > Introduce PCIe Root Complex driver for ASPEED SoCs. Support RC
> > > initialization, reset, clock, IRQ domain, and MSI domain setup.
> > > Implement platform-specific setup and register configuration for
> > > ASPEED. And provide PCI config space read/write and INTx/MSI interrupt
> > > handling.

> > > +#define MAX_MSI_HOST_IRQS	64
> > > +#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	500
> > 
> > Where does this value come from?  Is there a generic value from
> > drivers/pci/pci.h you can use?
> 
> We check the PCIe specification to find these contents.
>
> "With a Downstream Port that supports Link speeds greater than 5.0
> GT/s, software must wait a minimum of 100 ms after Link training
> completes before sending a Configuration Request to the device
> immediately below that Port."
>
> So, we think delay 500ms to let kernel issue the first configuration
> command is enough after deassert PERST.

Isn't this PCIE_RESET_CONFIG_WAIT_MS?

I prefer to use #defines from the PCI core whenever possible because
it makes it easier to ensure that all drivers include the required
delays.

> > > +#define PCIE_RESET_CONFIG_RC_WAIT_MS		10
> > 
> > Ditto.  If it's an Aspeed-specific value, can you point to the
> > source in the Aspeed datasheet?
> 
> This delay is set to ensure that the RC internal settings are
> completely reset.  We do not put its usage in our datasheet.

The "PCIE_" prefix suggests something required by the PCIe base spec.
If this is an Aspeed-specific value, perhaps remove the "PCIE_"
prefix?

> > > +static int aspeed_ast2700_child_config(struct pci_bus *bus, unsigned int
> > devfn,
> > > +				       int where, int size, u32 *val,
> > > +				       bool write)
> > > +{
> > > +	struct aspeed_pcie *pcie = bus->sysdata;
> > > +	u32 bdf_offset, status, cfg_val;
> > > +	int ret;
> > > +
> > > +	bdf_offset = aspeed_pcie_get_bdf_offset(bus, devfn, where);
> > > +
> > > +	cfg_val = CRG_PAYLOAD_SIZE;
> > > +	if (write)
> > > +		cfg_val |= (bus->number == 1) ? CRG0_WRITE_FMTTYPE :
> > CRG1_WRITE_FMTTYPE;
> > > +	else
> > > +		cfg_val |= (bus->number == 1) ? CRG0_READ_FMTTYPE :
> > > +CRG1_READ_FMTTYPE;
> > 
> > I don't think you should assume that bus 0 is the root bus.  The root bus
> > number should come from the DT bus-range.

Just making sure you saw this part since you didn't mention it.

Bjorn

