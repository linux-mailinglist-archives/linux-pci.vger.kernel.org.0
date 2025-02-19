Return-Path: <linux-pci+bounces-21830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D3BA3C73C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 19:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61583AAA54
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764761B85E2;
	Wed, 19 Feb 2025 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEuHK7X9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498A08468;
	Wed, 19 Feb 2025 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989195; cv=none; b=ocwkS9miayzivoz0ybwmmTn7lfdLYNjD2QeuC4kyayBiyW6I0hoIEqUJ98/mfgqhYT1WYx6Kdr4TuFQDnTVwvzJMUrof9juyO2CasEf7CzOVD7XPrH+9JsFgQzSNguPW1CqNLqKrnDm9Vg2KjEy7Gt9IcPeEubabjgVx0R0GVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989195; c=relaxed/simple;
	bh=sHLR2umxSZ85uY5OTldNfRDRYKI9Bn9zbd8hKKtL81s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S8CIlEqRIt+23jvuWady3s8gCBswMuwcyPNwQYpu5xsX8392vbQuOuhKYs7lL9gyCEKhwGv8QZRMo6gHZCWrcGE2VMG7xJHwu/jUPrx4vcxrPebGsTx+RcW0E9dZ6xKrh1lsAhd7QeDFtISSRXujzN0xlxzgvuseGph1J5hVEg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEuHK7X9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032C1C4CED1;
	Wed, 19 Feb 2025 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739989195;
	bh=sHLR2umxSZ85uY5OTldNfRDRYKI9Bn9zbd8hKKtL81s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gEuHK7X9eCCR3c9KY3NED3a0CLUl+TAoWzoMJT6n7P0V2TwmstBmIee1a4Uatuj3z
	 gC88UeGuL6zp8W6ho275A8vY/9N4RAklRoPFeb7O4uF78mllmFItNB4nEU2pWPxjEb
	 zygLfW8wNapYSGYemf75nlbtfqgkjFjQGpu/rqhnvLZxJLtVb+n4ZKszTFx6Y9Ejlt
	 vW9AZ8cDSP4+/4Tc16Il4BbuvuLX5zCdIk0vGfXjPxO9zifLQBWFgCxUD77ewRXcGl
	 RpiEHy4TzdGUEesFXW+v17ST0tsnMh63WXnmBFvVRa0A/ohhA+hQLHHPnIwJZQ52ai
	 QtU7FFpoERfJA==
Date: Wed, 19 Feb 2025 12:19:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	jingoohan1@gmail.com
Subject: Re: [PATCH v13 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250219181952.GA225098@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219102124.725344-4-thippeswamy.havalige@amd.com>

On Wed, Feb 19, 2025 at 03:51:24PM +0530, Thippeswamy Havalige wrote:
> Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.

> +#define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
> +#define AMD_MDB_TLP_IR_MASK_MISC		0x4C4
> +#define AMD_MDB_TLP_IR_ENABLE_MISC		0x4C8
> +#define AMD_MDB_TLP_IR_DISABLE_MISC		0x4CC
> +
> +#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
> +
> +#define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)	BIT((x) * 2)

> +#define AMD_MDB_PCIE_INTX_BIT(x) (1U << (2 * (x) + AMD_MDB_PCIE_INTR_INTX))

I don't think you need both AMD_MDB_PCIE_INTR_INTX_ASSERT() and
AMD_MDB_PCIE_INTX_BIT().

AMD_MDB_PCIE_INTX_BIT() is essentially the same as
FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK, AMD_MDB_PCIE_INTR_INTX_ASSERT).

I would just do this:

  #define AMD_MDB_PCIE_INTR_INTX(x)     BIT((x) * 2)

and in amd_mdb_intx_irq_mask() and amd_mdb_intx_irq_unmask(), do this:

  val = FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
                   AMD_MDB_PCIE_INTR_INTX(data->hwirq));

Then all the users do FIELD_PREP() or FIELD_GET() at the point of use.

It's a little confusing for dw_pcie_rp_intx_flow() to do the
FIELD_GET() there, but amd_mdb_intx_irq_mask() and
amd_mdb_intx_irq_unmask() have the equivalent of FIELD_PREP() hidden
inside AMD_MDB_PCIE_INTX_BIT().

> +static void amd_mdb_intx_irq_mask(struct irq_data *data)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = AMD_MDB_PCIE_INTX_BIT(data->hwirq);
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_DISABLE_MISC);

I guess AMD_MDB_TLP_IR_DISABLE_MISC and AMD_MDB_TLP_IR_ENABLE_MISC are
set up so writing zero bits does nothing, and writing a one bit only
masks or unmasks that single interrupt?  It's somewhat unusual, so a
comment to that effect might be useful.

> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void amd_mdb_intx_irq_unmask(struct irq_data *data)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = AMD_MDB_PCIE_INTX_BIT(data->hwirq);
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_ENABLE_MISC);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}

> +static irqreturn_t dw_pcie_rp_intx_flow(int irq, void *args)
> +{
> +	struct amd_mdb_pcie *pcie = args;
> +	unsigned long val;
> +	int i;
> +
> +	val = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK,
> +			val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC));

The "val = pcie_read()" looks like a useless assignment to val.  I
would do something like this:

  val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
  intx_status = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK, val);

  for (i = 0; i < PCI_NUM_INTX; i++) {
    if (intx_status & AMD_MDB_PCIE_INTR_INTX(i))
      generic_handle_domain_irq(pcie->intx_domain, i);
  }

> +	for (i = 0; i < PCI_NUM_INTX; i++) {
> +		if (val & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
> +			generic_handle_domain_irq(pcie->intx_domain, i);
> +	}
> +
> +	return IRQ_HANDLED;
> +}

