Return-Path: <linux-pci+bounces-27146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBB1AA9202
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 13:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C6E188B28C
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6F54BC6;
	Mon,  5 May 2025 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="U68JEeNw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E069201116
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746444411; cv=none; b=EsbyhbUpZ+8IvMwmioLyDjiZH8HOtHTF7qxuZw9+ntjiWW26QfDbsgGTyZYLjC6dB054YlwrdjV5lN2gqNyxm6N1VkPqkoo0bStBZF1q62TQt0t5UY8AaIgh0na7SzTCT5m55My2/C2jJYqUqtUr+nT+CZPGeUkdTz9cXK7ydG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746444411; c=relaxed/simple;
	bh=ZA2z6cJRHQYDJ8d+kqKuQv28t55EAKg9bMI/g/+ksG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+MZ62ZoVAB62wUQeVwRTQoMWTrMnEchcXNypoyNQaw9QXfAAg0YrPwjK5sZnzf6RF0uCKgUjDzHJF7C7HGyQ0mn97DAfr6RPq8LUxxO3xYNjDLzq6/igLJC949JiqzXi8ypnfb8+RfN6rsE6BvxZboOioyFCF52qoGEP3gGxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=U68JEeNw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2963dc379so613529766b.2
        for <linux-pci@vger.kernel.org>; Mon, 05 May 2025 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746444407; x=1747049207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCvqM0r6z/uk3aGi4ylWlG5lxduJ69/W6EjVsgplTuc=;
        b=U68JEeNwmWjVqpmpx2J36Kp5jSiExSqcEx6d1BwstMYifRCE/v6JxgluKUvxIxNub3
         T07uF7oPANvPPYv55WFNO+aeuzJ51lXWiBw4xwBEZyiNfib13UUBbd44aP7iisly4kBl
         +chn8VHv8WzCQCq1uRYwEy304h5jHkP1YFkmuTmdOg91lhZOTQ0zxIKTUoHhnjdc5ymN
         pI1EWVj4JITfpTvcCMjjeoFSPTONuYbvAIF2GiJjJvWZs9FQmPbVPTZRZWMTuZR9ffKM
         gcKeGIYHfpUsc5pV6HSY4rnxMxy9BBN/fogr9we1FsQ+/DgL+Oldjomr5eQB8Jj7Hvjn
         qYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746444407; x=1747049207;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCvqM0r6z/uk3aGi4ylWlG5lxduJ69/W6EjVsgplTuc=;
        b=eSXTSu6k4730CHEoY+ZwCXOSJoZKYvx/ZmZBSMCbpP6LCDbw3XvYIXWo0KcZ/QcbbY
         CXfpOxZ4A9wm9wCvFHbU/VquAFDUDtyBtiAnLkfqS+hLArUP6oLTVdqpo7IwE8N9n4vX
         61tgmAdzQewJqWuHgqi0JAlslLO4y1wAXlYMCydfRiBnNbGvXj2Ajm1p+1ihDfdWaiMf
         gH+/ul/r6QWgnvZaKRUCojR1zrDomB5uK2W7WczERCOpKF406tLwbYBQzgIWfralNiZe
         6chTvtWQ9wPDZ3SaERZisIn//Qq+Nxnfa+4fyWNIxLIpNzuPMDp+Wgc0CwuhPS3MUjGM
         zodw==
X-Forwarded-Encrypted: i=1; AJvYcCUUdCC2aofw8HcXNXfTq21UPgD8Edk9aFif9Bbi4sW4uJp2jtsWi59ULjB2QbXoKgr6ayqiJWUmTDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgO26gWrExVROAHXoUjO+QAlqZ4ulOb4U1DxChYBLePhIRxQNp
	+wX1YQnHk6rYRGUG/DN6jAK0ayraorCF8MfXLev8Y99ClDgG6TxX/HB06WfxIkpeWatumqCk0Fd
	B
X-Gm-Gg: ASbGncux6V/C0PG7gdWoQMyEQ+nYndPRYShSL3UxkwmFhInv0NpTr0XKKgvs3XlHbmz
	1PXOo1ULKtwQUSeSp139jKjVFPeMqVROdnSwqHyKrjHSyZU1Jdx6oUZij4w+LT6Pq3lpm0nEbp5
	V46aaX/WLakdCjoRsefwZqzdUDPS+rs8rLLUdrI8WSRlp/qplzYGlRq5lzaYjS5UXiO0FQJIUef
	2tfEkbLQm8fOSi5BnDBUC/BoPiso72ByIMxavJcxV39PJ63ROdqqvo26+Z2Y6SkaSqGR68HLCys
	iwNjJBRAkoAVWPU5oen58u448MEiHlY+liWHrE6U94y71xSE5fj7fuMIkl9a
X-Google-Smtp-Source: AGHT+IE/BbfbnYQze2kaqqgFxS+06OA8NFnbPS8TBkXLo8cERNYeU7a+LhmpysBXuNhwrmO3RWpezA==
X-Received: by 2002:a17:907:86a1:b0:ac8:1126:ac15 with SMTP id a640c23a62f3a-ad1a4ad4ca6mr634522866b.41.1746444406393;
        Mon, 05 May 2025 04:26:46 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a7467sm481981866b.67.2025.05.05.04.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 04:26:45 -0700 (PDT)
Message-ID: <26bdfbd6-7bf5-4688-b793-5d0f613d340b@tuxon.dev>
Date: Mon, 5 May 2025 14:26:43 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 mturquette@baylibre.com, sboyd@kernel.org, saravanak@google.com,
 p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250501201211.GA768334@bhelgaas>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250501201211.GA768334@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Bjorn,

On 01.05.2025 23:12, Bjorn Helgaas wrote:
> On Wed, Apr 30, 2025 at 01:32:33PM +0300, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
>> only as a root complex, with a single-lane (x1) configuration. The
>> controller includes Type 1 configuration registers, as well as IP
>> specific registers (called AXI registers) required for various adjustments.
>>
>> Other Renesas RZ SoCs (e.g., RZ/G3E, RZ/V2H) share the same AXI registers
>> but have both Root Complex and Endpoint capabilities. As a result, the PCIe
>> host driver can be reused for these variants with minimal adjustments.
> 
> I guess this current driver only supports RZ/GS3 in Root Complex mode?

That's right.

> If so, I don't think this paragraph is necessary or really relevant.

OK, I'll drop it.

> 
>> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
>> @@ -0,0 +1,1561 @@
> 
> I can't figure out the line width you're using.  Generally code in
> drivers/pci/ is formatted to fit in 80 columns.  Much of this file is
> formatted for that, but there are many cases that seem to use 90 or
> 100 columns.

I formated it at 100 columns where the lines were longer. I wasn't aware
the PCI rule is to have line formated at 80 columns. I'll switch to it in
the next version.

> 
> For single-line comments that are not a sentence or are a single
> sentence, it's typical to omit the period at end.

I'll follow this rule, too.

> 
>> +static void rzg3s_pcie_update_bits(void __iomem *base, u32 offset, u32 mask, u32 val)
>> +{
>> +	u32 tmp;
>> +
>> +	tmp = readl(base + offset);
>> +	tmp &= ~mask;
>> +	tmp |= val & mask;
>> +	writel(tmp, base + offset);
>> +}
> 
> Nothing rzg3s-specific here.
> 
> I think u32p_replace_bits() (include/linux/bitfield.h) is basically this.

I wasn't aware of it. I'll use it in the next version. Thank for pointing it.

> 
>> +static int rzg3s_pcie_config_access(struct rzg3s_pcie_host *host, struct pci_bus *bus,
>> +				    unsigned int devfn, int where, u32 *data,
>> +				    enum rzg3s_pcie_cfg_access_type access_type)
>> +{
>> +	bool type0 = pci_is_root_bus(bus->parent) ? true : false;
>> +	unsigned int dev, func, reg, tr_type;
>> +	int ret;
>> +
>> +	dev = PCI_SLOT(devfn);
>> +	func = PCI_FUNC(devfn);
>> +	reg = where & ~0x3;
> 
> This obviously has to be serialized with other config accesses.  Can
> you add a comment about what provides that serialization?  I assume
> it's probably pci_lock via pci_lock_config()?

Yes, it is the pci_lock via pci_{lock, unlock}_config(). I'll add a comment
for it.

> 
>> +	/* Set the destination. */
>> +	writel(FIELD_PREP(RZG3S_PCI_REQADR1_BUS, bus->number) |
>> +	       FIELD_PREP(RZG3S_PCI_REQADR1_DEV, dev) |
>> +	       FIELD_PREP(RZG3S_PCI_REQADR1_FUNC, func) |
>> +	       FIELD_PREP(RZG3S_PCI_REQADR1_REG, reg),
>> +	       host->axi + RZG3S_PCI_REQADR1);
>> +
>> +	/* Set byte enable. */
>> +	writel(RZG3S_PCI_REQBE_BYTE_EN, host->axi + RZG3S_PCI_REQBE);
>> +
>> +	if (access_type == RZG3S_PCIE_CFG_ACCESS_RD) {
>> +		tr_type = type0 ? RZG3S_PCI_REQISS_TR_TP0_RD : RZG3S_PCI_REQISS_TR_TP1_RD;
>> +	} else {
>> +		tr_type = type0 ? RZG3S_PCI_REQISS_TR_TP0_WR : RZG3S_PCI_REQISS_TR_TP1_WR;
>> +
>> +		/* Set the write data.  */
>> +		writel(0, host->axi + RZG3S_PCI_REQDATA(0));
>> +		writel(0, host->axi + RZG3S_PCI_REQDATA(1));
>> +		writel(*data, host->axi + RZG3S_PCI_REQDATA(2));
>> +	}
>> +
>> +	/* Set the type of request. */
>> +	writel(tr_type, host->axi + RZG3S_PCI_REQISS);
>> +
>> +	/* Issue the request and wait to finish. */
>> +	ret = rzg3s_pcie_issue_request(host);
>> +	if (ret) {
>> +		if (access_type == RZG3S_PCIE_CFG_ACCESS_RD)
>> +			PCI_SET_ERROR_RESPONSE(data);
>> +
>> +		return PCIBIOS_SET_FAILED;
>> +	}
>> +
>> +	/* Read the data. */
>> +	if (access_type == RZG3S_PCIE_CFG_ACCESS_RD)
>> +		*data = readl(host->axi + RZG3S_PCI_REQRCVDAT);
>> +
>> +	return PCIBIOS_SUCCESSFUL;
>> +}
> 
>> +static int rzg3s_pcie_read_conf(struct pci_bus *bus, unsigned int devfn, int where, int size,
>> +				u32 *val)
>> +{
>> +	struct rzg3s_pcie_host *host = bus->sysdata;
>> +	int ret;
>> +
>> +	/*
>> +	 * Bus number for root complex is set to zero. 
> 
> A root bus is not always bus number zero.  It sounds like the bus
> number is configurable on this hardware?

According to the documentation, yes, it is configurable. However, I haven't
tried with anything other than zero.

>  I don't see a dependency on
> the bus number, so I'm wondering why this sentence is here.

In probe, this function is called from
https://elixir.bootlin.com/linux/v6.14.5/source/drivers/pci/probe.c#L2992
with devfn in range [0, 256).
I had issues with letting the code configuring the controller with these
requests. Double checking it now, I think I've managed to make it work.
Thank you for pointing it.

> 
>> +	   ... Skip other requests for
>> +	 * vendor and device ID (where = 0x00).
> 
> Why do we need to avoid config reads for root bus devices other than
> 00.0?  Does the hardware not fabricate ~0 read data when a PCI error
> occurs?
> 
> It looks like you allow reads for other root bus devices at non-zero
> offsets?  E.g., we could read the Device ID at offset 0x02?

I had initially issues with the initialization sequence pointed above. But
your question made me re-checking it and I've manage to make it work. I'll
drop this limitation in the next version.

> 
>> +	 */
>> +	if (pci_is_root_bus(bus) && PCI_SLOT(devfn) && !where)
>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>> +
>> +	ret = rzg3s_pcie_read_config_access(host, bus, devfn, where, val);
>> +	if (ret != PCIBIOS_SUCCESSFUL)
>> +		return ret;
>> +
>> +	if (size == 1)
>> +		*val = (*val >> (BITS_PER_BYTE * (where & 3))) & 0xff;
>> +	else if (size == 2)
>> +		*val = (*val >> (BITS_PER_BYTE * (where & 2))) & 0xffff;
>> +
>> +	dev_dbg(&bus->dev, "%s(): bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
>> +		__func__, bus->number, devfn, where, size, *val);
>> +
>> +	return PCIBIOS_SUCCESSFUL;
>> +}
> 
>> +static int rzg3s_pcie_write_conf(struct pci_bus *bus, unsigned int devfn, int where, int size,
>> +				 u32 val)
>> +{
>> +	struct rzg3s_pcie_host *host = bus->sysdata;
>> +	u32 shift, data;
>> +	int ret;
>> +
>> +	ret = rzg3s_pcie_read_config_access(host, bus, devfn, where, &data);
>> +	if (ret != PCIBIOS_SUCCESSFUL)
>> +		return ret;
> 
> I guess this controller can't do an atomic config write, so you have
> to do a read/modify/write?

That's true.

>  That's broken in some corner cases, e.g.,
> it can corrupt RW1C bits in adjacent registers.
> 
> We emit a warning about this in pci_generic_config_write32().  I don't
> think we've been consistent about similar warnings in driver-specific
> code like this, but I would like to have a dmesg hint so that if we
> ever trip over this, it might be easier to debug.

OK, I'll add a one time debug message for this.

> 
>> +	dev_dbg(&bus->dev, "%s(): bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
>> +		__func__, bus->number, devfn, where, size, val);
>> +
>> +	if (size == 1) {
>> +		shift = BITS_PER_BYTE * (where & 3);
>> +		data &= ~(0xff << shift);
>> +		data |= ((val & 0xff) << shift);
>> +	} else if (size == 2) {
>> +		shift = BITS_PER_BYTE * (where & 2);
>> +		data &= ~(0xffff << shift);
>> +		data |= ((val & 0xffff) << shift);
>> +	} else {
>> +		data = val;
>> +	}
>> +
>> +	return rzg3s_pcie_write_config_access(host, bus, devfn, where, data);
>> +}
> 
>> +static struct irq_chip rzg3s_pcie_msi_bottom_chip = {
>> +	.name			= "rz-pcie-msi",
>> +	.irq_ack		= rzg3s_pcie_msi_irq_ack,
>> +	.irq_mask		= rzg3s_pcie_msi_irq_mask,
>> +	.irq_unmask		= rzg3s_pcie_msi_irq_unmask,
>> +	.irq_compose_msi_msg	= rzg3s_pcie_msi_compose_msg,
> 
> s/msi_compose_msg/compose_msi_msg/
> to match .irq_compose_msi_msg, which doesn't quite match the others
> but makes it easier to grep and compare .irq_compose_msi_msg
> implementations.

OK

> 
>> +	 * According to the RZ/G3S HW manual (section 34.4.5.2 Setting the MSI Window)
>> +	 * the MSI window need to be within any AXI window. Find an AXI window to setup
>> +	 * the MSI window.
> 
> There may be several revisions of the RZ/G3S spec and they might not
> preserve section numbers, so it might be worth including "r1.0" or
> whatever to make the citation unambiguous.

OK

> 
>> +static struct irq_chip rzg3s_pcie_intx_irq_chip = {
>> +	.name = "PCIe INTx",
>> +	.irq_ack = rzg3s_pcie_intx_ack,
>> +	.irq_mask = rzg3s_pcie_intx_mask,
>> +	.irq_unmask = rzg3s_pcie_intx_unmask,
> 
> Would prefer *_irq_ack, *_irq_mask, *_irq_unmask similar to MSI ops
> above.

OK

> 
>> +static int rzg3s_pcie_intx_setup(struct rzg3s_pcie_host *host)
>> +{
>> +	struct device *dev = host->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct device_node *intc_np __free(device_node) = of_get_child_by_name(np,
>> +								"legacy-interrupt-controller");
>> +	int irq_count;
>> +
>> +	if (!intc_np) {
>> +		dev_warn(dev, "legacy-interrupt-controller node is absent\n");
>> +		return 0;
>> +	}
>> +
>> +	irq_count = of_irq_count(intc_np);
>> +	if (irq_count != PCI_NUM_INTX)
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "Invalid IRQ entries in legacy-interrupt-controller\n");
> 
> We now know the value of irq_count, so why not just use PCI_NUM_INTX
> below?

Will use PCI_NUM_INTX in the next version.

> 
>> +	for (int i = 0; i < irq_count; i++) {
>> +		int irq = irq_of_parse_and_map(intc_np, i);
>> +
>> +		if (!irq)
>> +			return dev_err_probe(dev, -EINVAL, "Failed to parse and map INTx IRQ\n");
> 
> Could say which one?

Sure!

> 
>> +
>> +		host->intx_irqs[i] = irq;
>> +		irq_set_chained_handler_and_data(irq, rzg3s_pcie_intx_irq_handler, host);
>> +	}
>> +
>> +	host->intx_domain = irq_domain_add_linear(intc_np, irq_count,
>> +						  &rzg3s_pcie_intx_domain_ops, host);
>> +	if (!host->intx_domain)
>> +		return dev_err_probe(dev, -EINVAL, "Failed to add irq domain for INTX irqs\n");
> 
> s/INTX/INTx/ to match above.
> s/irqs/IRQs/ to match above.

OK

> 
>> +static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
>> +{
>> +	u32 lcs, cs2, link_speed, remote_supported_link_speeds, tmp;
>> +	u8 ltssm_state_l0 = 0xc;
>> +	int ret;
>> +
>> +	/*
>> +	 * According to the RZ/G3S HW manual (section 34.6.3 Caution when Changing
>> +	 * the Speed Spontaneously) link speed change can be done only when the
>> +	 * link training and status state machine in the PCIe Core Link is L0.
>> +	 */
>> +	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, tmp,
>> +				 FIELD_GET(RZG3S_PCI_PCSTAT1_LTSSM_STATE, tmp) == ltssm_state_l0,
>> +				 100, 1000);
> 
> Where do these timeout values come from?

These were obtained from experimenting.

>  Is there or should there be
> a #define for them?

I'll add defines in the next version.

> 
>> +static void rzg3s_pcie_cfg_init(struct rzg3s_pcie_host *host)
>> +{
>> +	/* Enable access control to the CFGU. */
>> +	writel(RZG3S_PCI_PERM_CFG_HWINIT_EN, host->axi + RZG3S_PCI_PERM);
>> +
>> +	/* Update vendor ID and device ID. */
>> +	writel(FIELD_PREP(RZG3S_PCI_CFG_VID_VENDOR, host->vendor_id) |
>> +	       FIELD_PREP(RZG3S_PCI_CFG_VID_DEVICE, host->device_id),
>> +	       host->pcie + RZG3S_PCI_CFG_VID);
>> +
>> +	/* HW manual recommends to write 0xffffffff on initialization. */
>> +	writel(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
>> +	writel(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
>> +
>> +	/* Primary bus = 0, secondary bus = 1, subordinate bus = 1. */
>> +	writel(FIELD_PREP(RZG3S_PCI_CFG_BNR_SUBORDINATE_BUS, 1) |
>> +	       FIELD_PREP(RZG3S_PCI_CFG_BNR_SECONDARY_BUS, 1),
>> +	       host->pcie + RZG3S_PCI_CFG_BNR);
> 
> I assume this configures a Root Port.  Is the primary bus hardwired to
> zero?

The documentation doens't mentioned anything about limiting it to zero.

>  There's no PCIe requirement that a root bus be bus 0.  This
> looks like it limits the subordinate bus unnecessarily.  The PCI core
> can program the secondary and subordinate bus numbers to accommodate
> the attached hierarchy.

I'll work on dropping this limitation in the next version.


> 
>> +static void rzg3s_pcie_irqs_init(struct rzg3s_pcie_host *host)
> 
> This and many of the following functions have names that don't
> correspond to anything in other drivers, which makes it harder to
> transfer knowledge between the drivers.  If you can find a pattern
> somewhere to follow, it will make it easier for others to read the
> driver.

OK, I'll think about it. Do you have a recomentation?

> 
>> +static int rzg3s_pcie_hw_init(struct rzg3s_pcie_host *host, bool probe)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	/* Set the PCIe related registers. */
>> +	rzg3s_pcie_cfg_init(host);
>> +
>> +	/* Set the interrupts. */
>> +	rzg3s_pcie_irqs_init(host);
>> +
>> +	ret = rzg3s_pcie_resets_bulk_set(reset_control_bulk_deassert, host->cfg_resets,
>> +					 host->num_cfg_resets);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Wait for link up. */
>> +	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
>> +				 !(val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS), 5000, 500000);
> 
> Ditto (source of timeout values).
> 
>> +static int rzg3s_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	void *devres_group_id;
>> +	int ret;
>> +
>> +	devres_group_id = devres_open_group(dev, NULL, GFP_KERNEL);
>> +	if (!devres_group_id)
>> +		return -ENOMEM;
> 
> What's the benefit of using devres_open_group()?  No other PCI
> controller drivers use it.

This driver uses devm_add_action_or_reset() to keep the error path simpler.
Some of the action or reset registered handlers access the controller
registers. Because the driver is attached to the platform bus and the
dev_pm_domain_detach() is called right after driver remove [1] having devm
action or reset handlers accessing controller register will later lead to
hangs when the device_unbind_cleanup() -> devres_release_all() will be
called on remove path. Other issue described in [2] may arries when doing
continuous unbind/bind if the driver has runtime PM API (not case for this
driver at the moment) that access directly controller registers.

This is because the dev_pm_domain_detach() drops the clocks from PM domain
and any subsequent pm_runtime_resume() (or similar function) call will lead
to no runtime resume of the device.

There is a solution proposed to this here [2] but it slowly progresses.
Until this will be solved I chosed the appraoch of having the devres group
opened here. If you agree with it, I had the intention to drop this call if
there will be an accepted solution for it. If you are OK with going forward
like this, for the moment, would to prefer me to add a comment about the
reason the devres_open_group() is used here?

This is not PCIe specific but platform bus specific. There are other
affected drivers on this side (e.g. rzg2l-adc [3], rzg3s-thermal [4]).

A similar solution as [2] is already used by the i2c subsystem.

[1]
https://elixir.bootlin.com/linux/v6.14.5/source/drivers/base/platform.c#L1425
[2]
https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com/
[3] https://lore.kernel.org/all/20250330163627.152d76ef@jic23-huawei/
[4]
https://lore.kernel.org/all/20250324135701.179827-3-claudiu.beznea.uj@bp.renesas.com/

> 
>> +	ret = rzg3s_pcie_probe_helper(pdev, devres_group_id);
> 
> This is the only driver that uses a *_pcie_probe_helper() function.
> 
>> +static DEFINE_NOIRQ_DEV_PM_OPS(rzg3s_pcie_pm_ops, rzg3s_pcie_suspend, rzg3s_pcie_resume);
> 
> Adding "_noirq" to the function names would be a good hint.

I missed it. I'll add it in the next version.

> 
> Only a dozen drivers in the whole tree use DEFINE_NOIRQ_DEV_PM_OPS(),
> which makes me wonder why this one is different.  There are a dozen or
> so PCI drivers that use NOIRQ_SYSTEM_SLEEP_PM_OPS().

This is how I'm used to approach it when there are simple dev_pm_ops. I
didn't know the:

const struct dev_pm_ops name = {

        NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)

};

is prefered. I'll switch to it in the next version.

Thank you for your review,
Claudiu

