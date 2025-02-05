Return-Path: <linux-pci+bounces-20740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D42EA28F05
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 15:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26ED160997
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A8314D2A2;
	Wed,  5 Feb 2025 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlMAjmbo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743261519BE;
	Wed,  5 Feb 2025 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765240; cv=none; b=RKC0Ui/9ybOI+s7vNtHetZB0KKqQLIBLv4K1seOhtjtNyzqRPU1deyw2w2OiJqmnlbg/rPnvZI15FOX5KzgHpuFEcLPubGgEX6fGpMcXMJQFDvVi839AFQJCfT96rzz9SsKUg6ilkhb01HTDlLIPQ98mbTbFUIzYKskHkCe7ROY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765240; c=relaxed/simple;
	bh=yoec46gh87HaP4fDB1yuBhMWsZEwbV90eci8orhKPq0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Pq/7mjc8RvLxwrHYPkDOKtPh0m/N6cr2cDNAFc1ykd2miflvLaRpMYUdU9WTWHDqa0egnaeE0rvcLLRosOsNOiS0VQ6OaKGDNVd1EkzhMacw+6rt24+KA7NSQ2fLbLXdIWhoj4aEJFekylzol8jlSUbHlpCyFWfyFl2pFDRW9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlMAjmbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA8DC4CED1;
	Wed,  5 Feb 2025 14:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738765240;
	bh=yoec46gh87HaP4fDB1yuBhMWsZEwbV90eci8orhKPq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZlMAjmbohWFds9Oumf1XiNL+EsBOg0WoQK7nNbp/+kDfWUlvNPMpYVQpaivAlFElj
	 +7R6QBiygD3F2p+gK8lxyl9aS8UodkDapsowSKXluihI9fkpsmLTqBjZDzorSQ604a
	 CPt5TNQ+hTGIBSauGlaVEh0kgMmvPaA2iT3k6TABDPpnQc/ibOx++YU+2ElbJ4ML85
	 i8NZRCChyNUm7sS95URe7ieZyzzyKrNc3uAszEjHZ+hOvt8g+j+ThPyQGXfakZUBm7
	 +hjoQTm9ba5FFebh3qUyvv+oaLkQQO8RKtpD9DtDmtFdH6+bi97cahxF0HaCIP9ITD
	 5f1uDYSN7+68Q==
Date: Wed, 5 Feb 2025 08:20:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: Re: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250205142038.GA910930@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB720115611148E80D555A1A1E8BF72@SN7PR12MB7201.namprd12.prod.outlook.com>

On Wed, Feb 05, 2025 at 11:53:53AM +0000, Havalige, Thippeswamy wrote:
> > -----Original Message-----
> > From: Havalige, Thippeswamy
> > Sent: Wednesday, February 5, 2025 5:08 PM
> > To: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> > manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; jingoohan1@gmail.com; Simek, Michal
> > <michal.simek@amd.com>; Gogada, Bharat Kumar
> > <bharat.kumar.gogada@amd.com>
> > Subject: RE: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver

> > > > > It's kind of weird that these skip the odd-numbered bits,
> > > > > since dw_pcie_rp_intx_flow(), amd_mdb_mask_intx_irq(),
> > > > > amd_mdb_unmask_intx_irq() only use bits 19:16.  Something
> > > > > seems wrong and needs either a fix or a comment about why
> > > > > this is the way it is.
> > > >
> > > > ... the odd bits are meant for deasserting inta, intb intc &
> > > > intd I ll include this in my next patch

Tangent: I don't know what "deassert" would mean here, since INTx is
an *incoming* interrupt and the Root Port is the receiver and can mask
or acknowledge the interrupt but not really deassert it.

> > > > > > +#define IMR(x) BIT(AMD_MDB_PCIE_INTR_ ##x)
> > > > > > +#define AMD_MDB_PCIE_IMR_ALL_MASK			\
> > > > > > +	(						\
> > > > > > +		IMR(CMPL_TIMEOUT)	|		\
> > > > > > +		IMR(INTA_ASSERT)	|		\
> > > > > > +		IMR(INTB_ASSERT)	|		\
> > > > > > +		IMR(INTC_ASSERT)	|		\
> > > > > > +		IMR(INTD_ASSERT)	|		\
> > > > > > +		IMR(PM_PME_RCVD)	|		\
> > > > > > +		IMR(PME_TO_ACK_RCVD)	|		\
> > > > > > +		IMR(MISC_CORRECTABLE)	|		\
> > > > > > +		IMR(NONFATAL)		|		\
> > > > > > +		IMR(FATAL)				\
> > > > > > +	)
> > > > > > +
> > > > > > +#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
> > > > >
> > > > > I would drop AMD_MDB_PCIE_INTR_INTA_ASSERT, etc, and just
> > > > > use AMD_MDB_TLP_PCIE_INTX_MASK in the
> > > > > AMD_MDB_PCIE_IMR_ALL_MASK definition.
> > > > >
> > > > > If there are really eight bits of INTx-related things here
> > > > > for the four INTx interrupts, I think you should make two
> > > > > #defines to separate them out.
> > >
> > > > Yes, there are 8 intx related bits I ll define them in my next
> > > > patch.  I was in confusion here regarding "PCI_NUM_INTX "
> > > > since this macro indicates INTA INTB INTC INTD bits so I
> > > > discarded deassert bits here.
> > >
> > > It seems like what you have is a single 8-bit field that
> > > contains both assert and deassert info, interspersed.
> > > GENMASK()/FIELD_GET() isn't enough to really separate them.
> > > Maybe you can do something like this:
> > >
> > >   #define AMD_MDB_TLP_PCIE_INTX_MASK          GENMASK(23, 16)
> > >
> > >   #define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)    BIT(1 << x)
> > >
> > > If you don't need the deassert bits, a comment would be useful,
> > > but there's no point in adding a #define for them.  If you do
> > > need them, maybe this:
> > >
> > >   #define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)  BIT((1 << x) + 1)
> > >
> > > > > > +static irqreturn_t dw_pcie_rp_intx_flow(int irq, void *args) {
> > > > > > +	struct amd_mdb_pcie *pcie = args;
> > > > > > +	unsigned long val;
> > > > > > +	int i;
> > > > > > +
> > > > > > +	val = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> > > > > > +			pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));
> > > > > > +
> > > > > > +	for_each_set_bit(i, &val, 4)
> > > > >
> > > > >   for_each_set_bit(..., PCI_NUM_INTX)
> > >
> > > > In next patch I will update value to 8 here.
> > >
> > > And here you could do:
> > >
> > >   val = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> > >                   pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));
> > >
> > >   for (i = 0; i < PCI_NUM_INTX; i++) {
> > >     if (val & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))

> > This condition never met observing zero here.

> To satisfy this condition need to modify macros as following.
> #define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)    BIT(x)
> #define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)    BIT(x+1)

Maybe I don't understand how the assert/deassert bits are laid out in
the register.

The original patch has this:

  +#define AMD_MDB_PCIE_INTR_INTA_ASSERT    16
  +#define AMD_MDB_PCIE_INTR_INTB_ASSERT    18
  +#define AMD_MDB_PCIE_INTR_INTC_ASSERT    20
  +#define AMD_MDB_PCIE_INTR_INTD_ASSERT    22

and if the odd bits are for deassert I thought that meant they would
look like this:

   #define AMD_MDB_PCIE_INTR_INTA_DEASSERT  17
   #define AMD_MDB_PCIE_INTR_INTB_DEASSERT  19
   #define AMD_MDB_PCIE_INTR_INTC_DEASSERT  21
   #define AMD_MDB_PCIE_INTR_INTD_DEASSERT  23

  +#define AMD_MDB_TLP_PCIE_INTX_MASK     GENMASK(23, 16)

If we extract AMD_MDB_TLP_PCIE_INTX_MASK with FIELD_GET(),
the field gets shifted right by 16, so we should end up with
something like this:

  INTA assert     0000 0001  ==  BIT(0)
  INTA deassert   0000 0010  ==  BIT(1)
  INTB assert     0000 0100  ==  BIT(2)
  INTB deassert   0000 1000  ==  BIT(3)
  INTC assert     0001 0000  ==  BIT(4)
  INTC deassert   0010 0000  ==  BIT(5)
  INTD assert     0100 0000  ==  BIT(6)
  INTD deassert   1000 0000  ==  BIT(7)

But maybe that's not how they're actually laid out?

I think the argument to AMD_MDB_PCIE_INTR_INTX_ASSERT() should
be the hwirq (0..3 for INTA..INTD), so if we use

  #define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)    BIT(x)
  #define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)  BIT(x+1)

as you propose, don't the assert/deassert bits collide?

  AMD_MDB_PCIE_INTR_INTX_ASSERT(0)   == BIT(0) for INTA assert
  AMD_MDB_PCIE_INTR_INTX_ASSERT(1)   == BIT(1) for INTB assert

  AMD_MDB_PCIE_INTR_INTX_DEASSERT(0) == BIT(1) for INTA deassert

> > >       generic_handle_domain_irq(pcie->intx_domain, i);
> > >
> > > > > > +		generic_handle_domain_irq(pcie->intx_domain, i);

