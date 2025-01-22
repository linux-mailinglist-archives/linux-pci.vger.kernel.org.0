Return-Path: <linux-pci+bounces-20252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C23A19A6B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 22:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659313A83A2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 21:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0351BC9FB;
	Wed, 22 Jan 2025 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/oDyyl2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7228F7D;
	Wed, 22 Jan 2025 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737581586; cv=none; b=Dyzsw10uSKGYo/1tf8EB4qM5pBuDd8PA2kgykRyqxwUAJDZCAw4fwcKUdeTEne27J1/PBl595rrRhPkBG+wcV4oGudOdbhFN9iBRsGFv8pnytmCDo/u7naNeJRDUw+eArXIgNA5t02p7gJ0mViPLvlNrhzDDUtTZS2iEcHLb8YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737581586; c=relaxed/simple;
	bh=t/PUmyDqQjOM3NJQYXmc2AiphKcUaKRy63lOZHv1bSU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KUEQzV3FdlezwRdqppfKyDVtgZUwdgxBvc2gFDpxZzUhnqw2Sv03b0GPYF+y1a0rQfiyIvHxCrvXoNO8ecP8v2H6Tm31loYC4Wcmhv4XQir3e+fCYZfjzEzSrJXs+sWFzTO+EvSn1/bb1g+sZm8EuA5KckbQV99+JhA41qY7cMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/oDyyl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427FFC4CED2;
	Wed, 22 Jan 2025 21:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737581585;
	bh=t/PUmyDqQjOM3NJQYXmc2AiphKcUaKRy63lOZHv1bSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=G/oDyyl26vQOZBi7lsPKiHRP0D40odETzwNTgA6oJHXbngjSg31rCQ6ZuwYOK/dsp
	 LfF7TcTdD+gh3/+tZFl6I9Tfb+S+fxhTgLhzNCXVMGF54RfDUOpdpt3M39nhX62n2e
	 f7ujshMhbre7llf62XCeRxlVOY1pD+wDw3Y3ZbmM1zjZTckDCrDi0gnQAJ08hexBT6
	 eAKVCaS5ejWE/gIn34C1LNIVmpSwMY3+j5tJxAQBn2QrENICUY7rqdQvGn/vx0VpOz
	 bEDFi3jKn1N5/5Ms+ZLqyK1Do7/XmoBE/XClY3MlQVCxlJL1ujKQxVXGgBY1RX0X+y
	 VuUDgjokNUMSQ==
Date: Wed, 22 Jan 2025 15:33:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, bhelgaas@google.com, unicorn_wang@outlook.com,
	conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
	krzk+dt@kernel.org, lee@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: Re: [PATCH v3 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <20250122213303.GA1102149@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddedd8f76f83fea2c6d3887132d2fe6f2a6a02c1.1736923025.git.unicorn_wang@outlook.com>

On Wed, Jan 15, 2025 at 03:06:57PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add support for PCIe controller in SG2042 SoC. The controller
> uses the Cadence PCIe core programmed by pcie-cadence*.c. The
> PCIe controller will work in host mode only.

> + * pcie-sg2042 - PCIe controller driver for Sophgo SG2042 SoC

I'm guessing this is the first of a *family* of Sophgo SoCs, so
"sg2042" looks like it might be a little too specific if there will be
things like "sg3042" etc added in the future.

> +#include "../../../irqchip/irq-msi-lib.h"

I know you're using this path because you're relying on Marc's
work in progress [1].

But I don't want to carry around an #include like this in drivers/pci
while we're waiting for that, so I think you should use the existing
published MSI model until after Marc's update is merged.  Otherwise we
might end up with this ugly path here and no real path to migrate to
the published, supported one.

[1] https://lore.kernel.org/linux-riscv/20241204124549.607054-2-maz@kernel.org/

> + * SG2042 PCIe controller supports two ways to report MSI:
> + *
> + * - Method A, the PCIe controller implements an MSI interrupt controller
> + *   inside, and connect to PLIC upward through one interrupt line.
> + *   Provides memory-mapped MSI address, and by programming the upper 32
> + *   bits of the address to zero, it can be compatible with old PCIe devices
> + *   that only support 32-bit MSI address.
> + *
> + * - Method B, the PCIe controller connects to PLIC upward through an
> + *   independent MSI controller "sophgo,sg2042-msi" on the SOC. The MSI
> + *   controller provides multiple(up to 32) interrupt sources to PLIC.

Maybe expand "PLIC" the first time?

s/SOC/SoC/ to match previous uses, e.g., in commit log
s/multiple(up to 32)/up to 32/

> + *   Compared with the first method, the advantage is that the interrupt
> + *   source is expanded, but because for SG2042, the MSI address provided by
> + *   the MSI controller is fixed and only supports 64-bit address(> 2^32),
> + *   it is not compatible with old PCIe devices that only support 32-bit MSI
> + *   address.

"Supporting 64-bit address" means supporting any address from 0 to
2^64 - 1, but I don't think that's what you mean here.

I think what you mean here is that with Method B, the MSI address is
fixed and it can only be above 4GB.

> +#define REG_CLEAR_LINK0_BIT	2
> +#define REG_CLEAR_LINK1_BIT	3
> +#define REG_STATUS_LINK0_BIT	2
> +#define REG_STATUS_LINK1_BIT	3

> +static void sg2042_pcie_msi_clear_status(struct sg2042_pcie *pcie)
> +{
> +	u32 status, clr_msi_in_bit;
> +
> +	if (pcie->link_id == 1)
> +		clr_msi_in_bit = BIT(REG_CLEAR_LINK1_BIT);
> +	else
> +		clr_msi_in_bit = BIT(REG_CLEAR_LINK0_BIT);

Why not put the BIT() in the #defines for REG_CLEAR_LINK0_BIT,
REG_STATUS_LINK0_BIT, ...?  Then this code is slightly simpler, and
you can use similar style in sg2042_pcie_msi_chained_isr() instead of
shifting there.

> +	regmap_read(pcie->syscon, REG_CLEAR, &status);
> +	status |= clr_msi_in_bit;
> +	regmap_write(pcie->syscon, REG_CLEAR, status);

> +static void sg2042_pcie_msi_irq_compose_msi_msg(struct irq_data *d,
> +						struct msi_msg *msg)
> +{
> +	struct sg2042_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	struct device *dev = pcie->cdns_pcie->dev;
> +
> +	msg->address_lo = lower_32_bits(pcie->msi_phys) + BYTE_NUM_PER_MSI_VEC * d->hwirq;
> +	msg->address_hi = upper_32_bits(pcie->msi_phys);

This seems a little suspect because adding "BYTE_NUM_PER_MSI_VEC *
d->hwirq" could cause overflow into the upper 32 bits.  I think you
should add first, then take the lower/upper 32 bits of the 64-bit
result.

> +	if (d->hwirq > pcie->num_applied_vecs)
> +		pcie->num_applied_vecs = d->hwirq;

"num_applied_vecs" is a bit of a misnomer; it's actually the *max*
hwirq.

> +static const struct irq_domain_ops sg2042_pcie_msi_domain_ops = {
> +	.alloc	= sg2042_pcie_irq_domain_alloc,
> +	.free	= sg2042_pcie_irq_domain_free,

Mention "msi" in these function names, e.g.,
sg2042_pcie_msi_domain_alloc().

> +static int sg2042_pcie_init_msi_data(struct sg2042_pcie *pcie)
> +{
> ...
> +	/* Program the MSI address and size */
> +	if (pcie->link_id == 1) {
> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_LOW,
> +			     lower_32_bits(pcie->msi_phys));
> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_HIGH,
> +			     upper_32_bits(pcie->msi_phys));
> +
> +		regmap_read(pcie->syscon, REG_LINK1_MSI_ADDR_SIZE, &value);
> +		value = (value & REG_LINK1_MSI_ADDR_SIZE_MASK) | MAX_MSI_IRQS;
> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_SIZE, value);
> +	} else {
> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_LOW,
> +			     lower_32_bits(pcie->msi_phys));
> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_HIGH,
> +			     upper_32_bits(pcie->msi_phys));
> +
> +		regmap_read(pcie->syscon, REG_LINK0_MSI_ADDR_SIZE, &value);
> +		value = (value & REG_LINK0_MSI_ADDR_SIZE_MASK) | (MAX_MSI_IRQS << 16);
> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_SIZE, value);
> +	}

Would be nicer to set temporaries to the link_id-dependent values (as
you did elsewhere) so it's obvious that the code is identical, e.g.,

  if (pcie->link_id == 1) {
    msi_addr = REG_LINK1_MSI_ADDR_LOW;
    msi_addr_size = REG_LINK1_MSI_ADDR_SIZE;
    msi_addr_size_mask = REG_LINK1_MSI_ADDR_SIZE;
  } else {
    ...
  }

  regmap_write(pcie->syscon, msi_addr, lower_32_bits(pcie->msi_phys));
  regmap_write(pcie->syscon, msi_addr + 4, upper_32_bits(pcie->msi_phys));
  ...

> +
> +	return 0;
> +}
> +
> +static irqreturn_t sg2042_pcie_msi_handle_irq(struct sg2042_pcie *pcie)

Which driver are you using as a template for function names and code
structure?  There are probably a dozen different names for functions
that iterate like this around a call to generic_handle_domain_irq(),
but you've managed to come up with a new one.  If you can pick a
similar name to copy, it makes it easier to compare drivers and find
and fix defects across them.

> +{
> +	u32 i, pos;
> +	unsigned long val;
> +	u32 status, num_vectors;
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	num_vectors = pcie->num_applied_vecs;
> +	for (i = 0; i <= num_vectors; i++) {
> +		status = readl((void *)(pcie->msi_virt + i * BYTE_NUM_PER_MSI_VEC));
> +		if (!status)
> +			continue;
> +
> +		ret = IRQ_HANDLED;
> +		val = status;

I don't think you need both val and status.

> +		pos = 0;
> +		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
> +					    pos)) != MAX_MSI_IRQS_PER_CTRL) {

Most drivers use for_each_set_bit() here.

> +			generic_handle_domain_irq(pcie->msi_domain,
> +						  (i * MAX_MSI_IRQS_PER_CTRL) +
> +						  pos);
> +			pos++;
> +		}
> +		writel(0, ((void *)(pcie->msi_virt) + i * BYTE_NUM_PER_MSI_VEC));
> +	}
> +	return ret;
> +}

> +static int sg2042_pcie_setup_msi(struct sg2042_pcie *pcie,
> +				 struct device_node *msi_node)
> +{
> +	struct device *dev = pcie->cdns_pcie->dev;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> +	struct irq_domain *parent_domain;
> +	int ret = 0;

Pointless initialization of "ret".

> +	if (!of_property_read_bool(msi_node, "msi-controller"))
> +		return -ENODEV;
> +
> +	ret = of_irq_get_byname(msi_node, "msi");
> +	if (ret <= 0) {
> +		dev_err(dev, "%pOF: failed to get MSI irq\n", msi_node);
> +		return ret;
> +	}
> +	pcie->msi_irq = ret;
> +
> +	irq_set_chained_handler_and_data(pcie->msi_irq,
> +					 sg2042_pcie_msi_chained_isr, pcie);
> +
> +	parent_domain = irq_domain_create_linear(fwnode, MSI_DEF_NUM_VECTORS,
> +						 &sg2042_pcie_msi_domain_ops, pcie);

Wrap to fit in 80 columns like 99% of the rest of this file.

Bjorn

