Return-Path: <linux-pci+bounces-27075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1854AA6498
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 22:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5003D7B5CD6
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 20:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84DB24A067;
	Thu,  1 May 2025 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcOCIuvY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07F21C183;
	Thu,  1 May 2025 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746130333; cv=none; b=EIUct0tyfX6g6BVDivl9mgKsFeVVYl9CTDndoxUw3YrRN7c16aIcIqLLeHj5QW7o8ghuw2igoUj4elE+jyaPEdexmmwFmuHQrHdvmxhysB9cnrN4jt5IidJi5t7AcuQXsQim6OEMsRh4weC/ICYhAPu2fSrp4rU9PwSDvwPc94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746130333; c=relaxed/simple;
	bh=XrRb459uroJoO9qEw2VwUdS7OlcuUspffa1aqenJIr8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Uhq1zVGLR4KHcPiAkrOPiyAAdupUunLC5lYFWMe2XlzAg8cKJUiyVNiOASr97qq1TBcMfmhJn57u9OSWOBLNJT4HdnW6xeNxkAj5OBmWPHlUbsMst0t2HSng5LuEAV/xkYzbjf7k2JU7lueonIGKNsV+MMla24m5xAda0D1BH9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcOCIuvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA570C4CEE3;
	Thu,  1 May 2025 20:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746130333;
	bh=XrRb459uroJoO9qEw2VwUdS7OlcuUspffa1aqenJIr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fcOCIuvYhbjkl/+lgLFp5OGgG0YvjQEfAtvUn915QhEXPUMBXB8aM++rwEKASptE5
	 uGJIiQYjsqamlV8SLulKKtb78CF3px6090vR9sxIT0GbSeF5kWN8oGpUle7XtEnZGb
	 AJe7aTnwZdqzi+V3399cZ0b8pM9pQxqrOkR/1FYbDCYtS5zIr33dTcosxvJu5CuZWt
	 vuMbOhxm//sUvv5cHuWBD9qupNA5nIZfqelS6ole8CbwHWQgjBQ5hKIff+kTVIjjfU
	 FZXo9yv3zl5rC7CNOhVHEgbPXrMkls2X3Kb05n7SSFD4PLrN+ZpeWj5rs4JC+bcI1Y
	 8My5ij7AunGKw==
Date: Thu, 1 May 2025 15:12:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
	saravanak@google.com, p.zabel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 5/8] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
Message-ID: <20250501201211.GA768334@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430103236.3511989-6-claudiu.beznea.uj@bp.renesas.com>

On Wed, Apr 30, 2025 at 01:32:33PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> only as a root complex, with a single-lane (x1) configuration. The
> controller includes Type 1 configuration registers, as well as IP
> specific registers (called AXI registers) required for various adjustments.
> 
> Other Renesas RZ SoCs (e.g., RZ/G3E, RZ/V2H) share the same AXI registers
> but have both Root Complex and Endpoint capabilities. As a result, the PCIe
> host driver can be reused for these variants with minimal adjustments.

I guess this current driver only supports RZ/GS3 in Root Complex mode?
If so, I don't think this paragraph is necessary or really relevant.

> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -0,0 +1,1561 @@

I can't figure out the line width you're using.  Generally code in
drivers/pci/ is formatted to fit in 80 columns.  Much of this file is
formatted for that, but there are many cases that seem to use 90 or
100 columns.

For single-line comments that are not a sentence or are a single
sentence, it's typical to omit the period at end.

> +static void rzg3s_pcie_update_bits(void __iomem *base, u32 offset, u32 mask, u32 val)
> +{
> +	u32 tmp;
> +
> +	tmp = readl(base + offset);
> +	tmp &= ~mask;
> +	tmp |= val & mask;
> +	writel(tmp, base + offset);
> +}

Nothing rzg3s-specific here.

I think u32p_replace_bits() (include/linux/bitfield.h) is basically this.

> +static int rzg3s_pcie_config_access(struct rzg3s_pcie_host *host, struct pci_bus *bus,
> +				    unsigned int devfn, int where, u32 *data,
> +				    enum rzg3s_pcie_cfg_access_type access_type)
> +{
> +	bool type0 = pci_is_root_bus(bus->parent) ? true : false;
> +	unsigned int dev, func, reg, tr_type;
> +	int ret;
> +
> +	dev = PCI_SLOT(devfn);
> +	func = PCI_FUNC(devfn);
> +	reg = where & ~0x3;

This obviously has to be serialized with other config accesses.  Can
you add a comment about what provides that serialization?  I assume
it's probably pci_lock via pci_lock_config()?

> +	/* Set the destination. */
> +	writel(FIELD_PREP(RZG3S_PCI_REQADR1_BUS, bus->number) |
> +	       FIELD_PREP(RZG3S_PCI_REQADR1_DEV, dev) |
> +	       FIELD_PREP(RZG3S_PCI_REQADR1_FUNC, func) |
> +	       FIELD_PREP(RZG3S_PCI_REQADR1_REG, reg),
> +	       host->axi + RZG3S_PCI_REQADR1);
> +
> +	/* Set byte enable. */
> +	writel(RZG3S_PCI_REQBE_BYTE_EN, host->axi + RZG3S_PCI_REQBE);
> +
> +	if (access_type == RZG3S_PCIE_CFG_ACCESS_RD) {
> +		tr_type = type0 ? RZG3S_PCI_REQISS_TR_TP0_RD : RZG3S_PCI_REQISS_TR_TP1_RD;
> +	} else {
> +		tr_type = type0 ? RZG3S_PCI_REQISS_TR_TP0_WR : RZG3S_PCI_REQISS_TR_TP1_WR;
> +
> +		/* Set the write data.  */
> +		writel(0, host->axi + RZG3S_PCI_REQDATA(0));
> +		writel(0, host->axi + RZG3S_PCI_REQDATA(1));
> +		writel(*data, host->axi + RZG3S_PCI_REQDATA(2));
> +	}
> +
> +	/* Set the type of request. */
> +	writel(tr_type, host->axi + RZG3S_PCI_REQISS);
> +
> +	/* Issue the request and wait to finish. */
> +	ret = rzg3s_pcie_issue_request(host);
> +	if (ret) {
> +		if (access_type == RZG3S_PCIE_CFG_ACCESS_RD)
> +			PCI_SET_ERROR_RESPONSE(data);
> +
> +		return PCIBIOS_SET_FAILED;
> +	}
> +
> +	/* Read the data. */
> +	if (access_type == RZG3S_PCIE_CFG_ACCESS_RD)
> +		*data = readl(host->axi + RZG3S_PCI_REQRCVDAT);
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}

> +static int rzg3s_pcie_read_conf(struct pci_bus *bus, unsigned int devfn, int where, int size,
> +				u32 *val)
> +{
> +	struct rzg3s_pcie_host *host = bus->sysdata;
> +	int ret;
> +
> +	/*
> +	 * Bus number for root complex is set to zero. 

A root bus is not always bus number zero.  It sounds like the bus
number is configurable on this hardware?  I don't see a dependency on
the bus number, so I'm wondering why this sentence is here.

> +	   ... Skip other requests for
> +	 * vendor and device ID (where = 0x00).

Why do we need to avoid config reads for root bus devices other than
00.0?  Does the hardware not fabricate ~0 read data when a PCI error
occurs?

It looks like you allow reads for other root bus devices at non-zero
offsets?  E.g., we could read the Device ID at offset 0x02?

> +	 */
> +	if (pci_is_root_bus(bus) && PCI_SLOT(devfn) && !where)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	ret = rzg3s_pcie_read_config_access(host, bus, devfn, where, val);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		return ret;
> +
> +	if (size == 1)
> +		*val = (*val >> (BITS_PER_BYTE * (where & 3))) & 0xff;
> +	else if (size == 2)
> +		*val = (*val >> (BITS_PER_BYTE * (where & 2))) & 0xffff;
> +
> +	dev_dbg(&bus->dev, "%s(): bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
> +		__func__, bus->number, devfn, where, size, *val);
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}

> +static int rzg3s_pcie_write_conf(struct pci_bus *bus, unsigned int devfn, int where, int size,
> +				 u32 val)
> +{
> +	struct rzg3s_pcie_host *host = bus->sysdata;
> +	u32 shift, data;
> +	int ret;
> +
> +	ret = rzg3s_pcie_read_config_access(host, bus, devfn, where, &data);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		return ret;

I guess this controller can't do an atomic config write, so you have
to do a read/modify/write?  That's broken in some corner cases, e.g.,
it can corrupt RW1C bits in adjacent registers.

We emit a warning about this in pci_generic_config_write32().  I don't
think we've been consistent about similar warnings in driver-specific
code like this, but I would like to have a dmesg hint so that if we
ever trip over this, it might be easier to debug.

> +	dev_dbg(&bus->dev, "%s(): bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
> +		__func__, bus->number, devfn, where, size, val);
> +
> +	if (size == 1) {
> +		shift = BITS_PER_BYTE * (where & 3);
> +		data &= ~(0xff << shift);
> +		data |= ((val & 0xff) << shift);
> +	} else if (size == 2) {
> +		shift = BITS_PER_BYTE * (where & 2);
> +		data &= ~(0xffff << shift);
> +		data |= ((val & 0xffff) << shift);
> +	} else {
> +		data = val;
> +	}
> +
> +	return rzg3s_pcie_write_config_access(host, bus, devfn, where, data);
> +}

> +static struct irq_chip rzg3s_pcie_msi_bottom_chip = {
> +	.name			= "rz-pcie-msi",
> +	.irq_ack		= rzg3s_pcie_msi_irq_ack,
> +	.irq_mask		= rzg3s_pcie_msi_irq_mask,
> +	.irq_unmask		= rzg3s_pcie_msi_irq_unmask,
> +	.irq_compose_msi_msg	= rzg3s_pcie_msi_compose_msg,

s/msi_compose_msg/compose_msi_msg/
to match .irq_compose_msi_msg, which doesn't quite match the others
but makes it easier to grep and compare .irq_compose_msi_msg
implementations.

> +	 * According to the RZ/G3S HW manual (section 34.4.5.2 Setting the MSI Window)
> +	 * the MSI window need to be within any AXI window. Find an AXI window to setup
> +	 * the MSI window.

There may be several revisions of the RZ/G3S spec and they might not
preserve section numbers, so it might be worth including "r1.0" or
whatever to make the citation unambiguous.

> +static struct irq_chip rzg3s_pcie_intx_irq_chip = {
> +	.name = "PCIe INTx",
> +	.irq_ack = rzg3s_pcie_intx_ack,
> +	.irq_mask = rzg3s_pcie_intx_mask,
> +	.irq_unmask = rzg3s_pcie_intx_unmask,

Would prefer *_irq_ack, *_irq_mask, *_irq_unmask similar to MSI ops
above.

> +static int rzg3s_pcie_intx_setup(struct rzg3s_pcie_host *host)
> +{
> +	struct device *dev = host->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *intc_np __free(device_node) = of_get_child_by_name(np,
> +								"legacy-interrupt-controller");
> +	int irq_count;
> +
> +	if (!intc_np) {
> +		dev_warn(dev, "legacy-interrupt-controller node is absent\n");
> +		return 0;
> +	}
> +
> +	irq_count = of_irq_count(intc_np);
> +	if (irq_count != PCI_NUM_INTX)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid IRQ entries in legacy-interrupt-controller\n");

We now know the value of irq_count, so why not just use PCI_NUM_INTX
below?

> +	for (int i = 0; i < irq_count; i++) {
> +		int irq = irq_of_parse_and_map(intc_np, i);
> +
> +		if (!irq)
> +			return dev_err_probe(dev, -EINVAL, "Failed to parse and map INTx IRQ\n");

Could say which one?

> +
> +		host->intx_irqs[i] = irq;
> +		irq_set_chained_handler_and_data(irq, rzg3s_pcie_intx_irq_handler, host);
> +	}
> +
> +	host->intx_domain = irq_domain_add_linear(intc_np, irq_count,
> +						  &rzg3s_pcie_intx_domain_ops, host);
> +	if (!host->intx_domain)
> +		return dev_err_probe(dev, -EINVAL, "Failed to add irq domain for INTX irqs\n");

s/INTX/INTx/ to match above.
s/irqs/IRQs/ to match above.

> +static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
> +{
> +	u32 lcs, cs2, link_speed, remote_supported_link_speeds, tmp;
> +	u8 ltssm_state_l0 = 0xc;
> +	int ret;
> +
> +	/*
> +	 * According to the RZ/G3S HW manual (section 34.6.3 Caution when Changing
> +	 * the Speed Spontaneously) link speed change can be done only when the
> +	 * link training and status state machine in the PCIe Core Link is L0.
> +	 */
> +	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, tmp,
> +				 FIELD_GET(RZG3S_PCI_PCSTAT1_LTSSM_STATE, tmp) == ltssm_state_l0,
> +				 100, 1000);

Where do these timeout values come from?  Is there or should there be
a #define for them?

> +static void rzg3s_pcie_cfg_init(struct rzg3s_pcie_host *host)
> +{
> +	/* Enable access control to the CFGU. */
> +	writel(RZG3S_PCI_PERM_CFG_HWINIT_EN, host->axi + RZG3S_PCI_PERM);
> +
> +	/* Update vendor ID and device ID. */
> +	writel(FIELD_PREP(RZG3S_PCI_CFG_VID_VENDOR, host->vendor_id) |
> +	       FIELD_PREP(RZG3S_PCI_CFG_VID_DEVICE, host->device_id),
> +	       host->pcie + RZG3S_PCI_CFG_VID);
> +
> +	/* HW manual recommends to write 0xffffffff on initialization. */
> +	writel(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
> +	writel(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
> +
> +	/* Primary bus = 0, secondary bus = 1, subordinate bus = 1. */
> +	writel(FIELD_PREP(RZG3S_PCI_CFG_BNR_SUBORDINATE_BUS, 1) |
> +	       FIELD_PREP(RZG3S_PCI_CFG_BNR_SECONDARY_BUS, 1),
> +	       host->pcie + RZG3S_PCI_CFG_BNR);

I assume this configures a Root Port.  Is the primary bus hardwired to
zero?  There's no PCIe requirement that a root bus be bus 0.  This
looks like it limits the subordinate bus unnecessarily.  The PCI core
can program the secondary and subordinate bus numbers to accommodate
the attached hierarchy.

> +static void rzg3s_pcie_irqs_init(struct rzg3s_pcie_host *host)

This and many of the following functions have names that don't
correspond to anything in other drivers, which makes it harder to
transfer knowledge between the drivers.  If you can find a pattern
somewhere to follow, it will make it easier for others to read the
driver.

> +static int rzg3s_pcie_hw_init(struct rzg3s_pcie_host *host, bool probe)
> +{
> +	u32 val;
> +	int ret;
> +
> +	/* Set the PCIe related registers. */
> +	rzg3s_pcie_cfg_init(host);
> +
> +	/* Set the interrupts. */
> +	rzg3s_pcie_irqs_init(host);
> +
> +	ret = rzg3s_pcie_resets_bulk_set(reset_control_bulk_deassert, host->cfg_resets,
> +					 host->num_cfg_resets);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for link up. */
> +	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
> +				 !(val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS), 5000, 500000);

Ditto (source of timeout values).

> +static int rzg3s_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	void *devres_group_id;
> +	int ret;
> +
> +	devres_group_id = devres_open_group(dev, NULL, GFP_KERNEL);
> +	if (!devres_group_id)
> +		return -ENOMEM;

What's the benefit of using devres_open_group()?  No other PCI
controller drivers use it.

> +	ret = rzg3s_pcie_probe_helper(pdev, devres_group_id);

This is the only driver that uses a *_pcie_probe_helper() function.

> +static DEFINE_NOIRQ_DEV_PM_OPS(rzg3s_pcie_pm_ops, rzg3s_pcie_suspend, rzg3s_pcie_resume);

Adding "_noirq" to the function names would be a good hint.

Only a dozen drivers in the whole tree use DEFINE_NOIRQ_DEV_PM_OPS(),
which makes me wonder why this one is different.  There are a dozen or
so PCI drivers that use NOIRQ_SYSTEM_SLEEP_PM_OPS().

Bjorn

