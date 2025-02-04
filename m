Return-Path: <linux-pci+bounces-20719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D75A27E15
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 23:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664313A3AA4
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 22:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231E621ADB5;
	Tue,  4 Feb 2025 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tn0SqKjW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E3F204F9F;
	Tue,  4 Feb 2025 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707123; cv=none; b=YtnjdV7FFvEAlWpLi8MFUp3MfnUT4X0OIYb6MtlwFu6lb2ZiZ5CkdGLf7VvZSoGZ5KT0rPUx+jwlu39pg2pxtsuHOODqPD9k/ltyNoF3em6lh2YEzFU/v7QQLMab3CpQ4Jykss5cebMkYH0Ct7/AOX4deRvXYYU1HSp7hKMeNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707123; c=relaxed/simple;
	bh=2MJOZ+0ZhXf0wuVda3xUY/zHi+eBY29O/mjKfPbp+Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d9uSsn+hTYu74MhcohoyOIoCjerimaDwpSfkLocT7wznZZpOtyVnk36JDzKCUhatQl3tLcUxDXcfPvy9Kx76bNNzQufYR75oz4GDGmYoEiBCUy1BwpfuNyq8p/MJjCR5/jXC0/L/axPSmLY1ZS39wrBocNePgnTdfySdv+HfsBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tn0SqKjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116A9C4CEDF;
	Tue,  4 Feb 2025 22:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738707122;
	bh=2MJOZ+0ZhXf0wuVda3xUY/zHi+eBY29O/mjKfPbp+Fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tn0SqKjW5N6UgRbbGtimFRbe3v+1lOJjW1/EOnJKl8+ERjImHiipNfiYxHKdPE3UN
	 UXwE8TYoNtLJewYGQN4CTvlc5AZcwp0dVRZgyvPN/qgBN6dR1/jEl0asYlVLZtCBYc
	 zkmLl0IsC6DoL08sbUWz5WcVpFooSNQxlnMx8fOEsXtaXtCYUBf0CdNRThLz+HPFeH
	 1Zek2uc8VJ1OPfoxJtI6TgYcuPR6fuy2+FJUrhYN9H1BNWPoAvYMWsoU12tQrLoM1B
	 wfaLmSvJ0r5GvcsafjaJN9QD1YyDVl2pOrIhwIwMNrSsI9YfWWfEXrdRjj0oxr8Ado
	 5KHZ8puSpI/pg==
Date: Tue, 4 Feb 2025 16:11:59 -0600
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
Message-ID: <20250204221159.GA863758@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB7201EAC37631E10EBA5A299B8BF42@SN7PR12MB7201.namprd12.prod.outlook.com>

On Tue, Feb 04, 2025 at 09:37:51AM +0000, Havalige, Thippeswamy wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> ...
> > On Wed, Jan 29, 2025 at 05:00:29PM +0530, Thippeswamy Havalige wrote:
> > > Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.

> > > +#define AMD_MDB_PCIE_INTR_INTA_ASSERT		16
> > > +#define AMD_MDB_PCIE_INTR_INTB_ASSERT		18
> > > +#define AMD_MDB_PCIE_INTR_INTC_ASSERT		20
> > > +#define AMD_MDB_PCIE_INTR_INTD_ASSERT		22
> > 
> > It's kind of weird that these skip the odd-numbered bits, since
> > dw_pcie_rp_intx_flow(), amd_mdb_mask_intx_irq(),
> > amd_mdb_unmask_intx_irq() only use bits 19:16.  Something seems wrong
> > and needs either a fix or a comment about why this is the way it is.
>
> ... the odd bits are meant for deasserting inta, intb intc & intd I
> ll include this in my next patch 

> > > +#define IMR(x) BIT(AMD_MDB_PCIE_INTR_ ##x)
> > > +#define AMD_MDB_PCIE_IMR_ALL_MASK			\
> > > +	(						\
> > > +		IMR(CMPL_TIMEOUT)	|		\
> > > +		IMR(INTA_ASSERT)	|		\
> > > +		IMR(INTB_ASSERT)	|		\
> > > +		IMR(INTC_ASSERT)	|		\
> > > +		IMR(INTD_ASSERT)	|		\
> > > +		IMR(PM_PME_RCVD)	|		\
> > > +		IMR(PME_TO_ACK_RCVD)	|		\
> > > +		IMR(MISC_CORRECTABLE)	|		\
> > > +		IMR(NONFATAL)		|		\
> > > +		IMR(FATAL)				\
> > > +	)
> > > +
> > > +#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
> > 
> > I would drop AMD_MDB_PCIE_INTR_INTA_ASSERT, etc, and just use
> > AMD_MDB_TLP_PCIE_INTX_MASK in the AMD_MDB_PCIE_IMR_ALL_MASK
> > definition.
> > 
> > If there are really eight bits of INTx-related things here for the
> > four INTx interrupts, I think you should make two #defines to
> > separate them out.

> Yes, there are 8 intx related bits I ll define them in my next
> patch. I was in confusion here regarding "PCI_NUM_INTX " since this
> macro indicates INTA INTB INTC INTD bits so I discarded deassert
> bits here.

It seems like what you have is a single 8-bit field that contains both
assert and deassert info, interspersed.  GENMASK()/FIELD_GET() isn't
enough to really separate them.  Maybe you can do something like this:

  #define AMD_MDB_TLP_PCIE_INTX_MASK          GENMASK(23, 16)

  #define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)    BIT(1 << x)

If you don't need the deassert bits, a comment would be useful, but
there's no point in adding a #define for them.  If you do need them,
maybe this:

  #define AMD_MDB_PCIE_INTR_INTX_DEASSERT(x)  BIT((1 << x) + 1)

> > > +static irqreturn_t dw_pcie_rp_intx_flow(int irq, void *args) {
> > > +	struct amd_mdb_pcie *pcie = args;
> > > +	unsigned long val;
> > > +	int i;
> > > +
> > > +	val = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> > > +			pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));
> > > +
> > > +	for_each_set_bit(i, &val, 4)
> > 
> >   for_each_set_bit(..., PCI_NUM_INTX)

> In next patch I will update value to 8 here.

And here you could do:

  val = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
                  pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));

  for (i = 0; i < PCI_NUM_INTX; i++) {
    if (val & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
      generic_handle_domain_irq(pcie->intx_domain, i);

> > > +		generic_handle_domain_irq(pcie->intx_domain, i);

> > > +	d = irq_domain_get_irq_data(pcie->mdb_domain, irq);
> > > +	if (intr_cause[d->hwirq].str)
> > > +		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> > > +	else
> > > +		dev_warn_once(dev, "Unknown IRQ %ld\n", d->hwirq);
> > 
> > What's the point of an interrupt handler that only logs it?
>
> At this stage, our objective is to notify the user of the occurrence
> of an event. While we intend to integrate these events with the AER
> subsystem in the future, for the time being, we will limit the
> functionality to notifying the user.

OK, just add a comment to that effect here.

Bjorn

