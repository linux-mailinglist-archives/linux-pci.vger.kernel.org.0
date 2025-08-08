Return-Path: <linux-pci+bounces-33624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AFAB1E736
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 13:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB789586FD0
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 11:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AA9274B4F;
	Fri,  8 Aug 2025 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OANtEjdE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE63274B29
	for <linux-pci@vger.kernel.org>; Fri,  8 Aug 2025 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652270; cv=none; b=FZjT3509ud+OhPsJHbElRlgTj4z3uxxs2Qz8plEKiHGrncywvBJC6oojTI0UBAdEiTvauXuESYCATtk567kDRAXM5d2T2W7CHj5jh2oDmWtyQ2jOQx0yK2BXbfJX17pa0Vn0chtWkdUimEAw+rn6IQ7CNKPSFbnRqUc+WeAilPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652270; c=relaxed/simple;
	bh=vnReVjyJO9D/GqTCq1unXf8mPy4GF77C18VgZS57b4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvfFTAYNUA1aKB5854MTnZzGJxoQPQnd53pG0Edxse2CPv/XWr7MLCHkabywdbJGAGrnugBDMsUv0HpK9LfC5yMq/HaG3O/oFF8JthkBK2bv1dGESbKcrr1dkQLvQQS/QxnGHolPFZz3O4HnIYLeFTT0pbQZRnNfLH3V0fryWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OANtEjdE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b7848df30cso1624620f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 08 Aug 2025 04:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754652266; x=1755257066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QerUatP1FwXy5qM8prcSB6YRZFg5hvH6e9jGVmXCTU=;
        b=OANtEjdE+vbgxODzAmM0o+THPiLOkAUHWtsb8yGjdIQulEhsQsGxzcuYZQ53jW8Dpu
         jDKWG+FyYJDkAx7GXAWiGR35RJe7q2tRqkiEyq7rsSsp+V9ltNmbN6fAkR2sdbUkBZA+
         /nMtjvAxG837h1VU4LujQEFbpSXLYEBTqSYlAQUBuspTfkq/ZzD0QCPym8RR080WdAiZ
         5M6LyMwHHeucQP0eFfocxtOUcXzCl+A5OhDCWSAK1PeIHX92GF9YkN9EWs8Z2lO+0tqY
         fSeJaZLuz6dxexV9x9PLHGZajrAtN/M9CIgo1AE7j90tARJ8xCBxUVd7iWoc3BOWuexx
         XwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652266; x=1755257066;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QerUatP1FwXy5qM8prcSB6YRZFg5hvH6e9jGVmXCTU=;
        b=N/ZDxeIAhFVvGEG6ZRbzM8jtSAlc2UdA/vHiFaTvt6/1FTM9AqCHmJOQxrJVElok+z
         o1A5tMPeurkzcBwxTiR5+QoPx5escvIUWhmtIsrF9dhH5vE9j3zsjpAAN8VrqtEv9dON
         92DT5TvaxieunL8yY/A5CDD2hrLsOZ/WOULhfoBQeMAgQHjUC3XohyPDY+oXUJlWFTiB
         CKcRHpfRPBq0nn/dua9PVK/iUw5POMAArs9Q8KqpC57ykf58Pvh2X1xNJbDoh586uyre
         rTA5UQWJrE+h0xSGZh+isZ5n/REkRXLSNF8XPhL0mCGhfeTLqcnb0dX+5tjmaHphRv8Q
         KLfg==
X-Forwarded-Encrypted: i=1; AJvYcCWhSOAFuiyu2MHiqv0q5nWV3WKJp7Jwb0tlKdKKgJVv+zXa6/jSYqNzALO4dmZ4xVZ/y5rVmJJeu7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOfolZE4F6jUtQGi7bmWvy67tzx0RZfbBsVVBAhngfpWyPwvwW
	SKL2Pnr7YK6aLpxmyorkykiAKtHC/AAbnhHMd6P4+0a/RR9+vKV7ACtr2VsMEYgOCDs=
X-Gm-Gg: ASbGncvjuvpjX755g7cknZYpGRhYgdFjnPreAlaAq1qvnFS18VUQP4soOy777lF8qqU
	eAh39/xUdVjNLAsznx5DCSMLj2Q73LyfuMO8z/okgquvFkL5ZsuHKZoHdUPIX0BUcUtvAIk6icR
	yfHwSBtYkKqtv0DKxk/Lo3iKSpeN9c2xKRGFkMtskECTmKD10bQx/d/2Bs70mUgAZnnIMZXxQax
	2mUAI+YJssJQiLcO8jAjdUIgmGdrDEXwzDQr+jrIxgwENMVwNRtpxvpr7VzmHEbs/RbqVpRpFB6
	27UDI4FPK5QxlxMucYIYX7rKbUPDRbJVlrQ6doUl/O0GTO6HjJEchTIKZTJztwDikA7dDiWYuwQ
	U7SfOUYYkBb0whb73UKEOlbPj9mDTFPk=
X-Google-Smtp-Source: AGHT+IHcXV1rLgWWMBZQXeDM6S9Vc4tpauCBc93JgLdUvQwTkrp4rucAKzWGxgdL0s3pD83tO3p5vg==
X-Received: by 2002:a05:6000:4308:b0:3b7:915c:5fa3 with SMTP id ffacd0b85a97d-3b900fe7e69mr2310478f8f.24.1754652265560;
        Fri, 08 Aug 2025 04:24:25 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm31580576f8f.9.2025.08.08.04.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 04:24:24 -0700 (PDT)
Message-ID: <eb59607d-6662-4a5a-bf14-77ce53f872b3@tuxon.dev>
Date: Fri, 8 Aug 2025 14:24:22 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, catalin.marinas@arm.com,
 will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 p.zabel@pengutronix.de, lizhi.hou@amd.com, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Nam Cao <namcao@linutronix.de>
References: <20250708192458.GA2148570@bhelgaas>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250708192458.GA2148570@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Bjorn,

Apolgies for taking so long to reply to this.

On 08.07.2025 22:24, Bjorn Helgaas wrote:
> [+cc Nam for MSI parent domain conversions, head of this thread at
> https://lore.kernel.org/r/20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com]
> 
> In subject:
> 
>   PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver
> 
> so the important stuff is up front instead of being wrapped at the
> end.

OK

> 
> On Fri, Jul 04, 2025 at 07:14:05PM +0300, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
>> only as a root complex, with a single-lane (x1) configuration. The
>> controller includes Type 1 configuration registers, as well as IP
>> specific registers (called AXI registers) required for various adjustments.
>>
>> Hardware manual can be downloaded from the address in the "Link" section.
>> The following steps should be followed to access the manual:
>> 1/ Click the "User Manual" button
>> 2/ Click "Confirm"; this will start downloading an archive
>> 3/ Open the downloaded archive
>> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
>> 5/ Open the file r01uh1014ej*-rzg3s.pdf
>>
>> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
>> +static bool rzg3s_pcie_child_issue_request(struct rzg3s_pcie_host *host)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_REQISS,
>> +			       RZG3S_PCI_REQISS_REQ_ISSUE,
>> +			       RZG3S_PCI_REQISS_REQ_ISSUE);
>> +	ret = readl_poll_timeout_atomic(host->axi + RZG3S_PCI_REQISS, val,
>> +					!(val & RZG3S_PCI_REQISS_REQ_ISSUE),
>> +					5, RZG3S_REQ_ISSUE_TIMEOUT_US);
>> +
>> +	return !!ret || (val & RZG3S_PCI_REQISS_MOR_STATUS);
> 
> From the context in the caller, I guess returning "true" means we
> timed out or RZG3S_PCI_REQISS_MOR_STATUS contained some failure
> status, and "false" means success.  This is a little bit mind-bending,
> and it's a pain to have to deduce the bool meaning from the context.
> 
> Personally I would return 0 for success or a negative errno, e.g.,
> 
>   if (val & RZG3S_PCI_REQISS_MOR_STATUS)
>     return -E<something>;
>   return ret;
> 

I'll change it in the next version.

>> +}
>> +
>> +static int rzg3s_pcie_child_read_conf(struct rzg3s_pcie_host *host,
>> +				      struct pci_bus *bus,
>> +				      unsigned int devfn, int where,
>> +				      u32 *data)
>> +{
>> +	int ret;
>> +
>> +	bus->ops->map_bus(bus, devfn, where);
>> +
>> +	/* Set the type of request */
>> +	writel(RZG3S_PCI_REQISS_TR_TP0_RD, host->axi + RZG3S_PCI_REQISS);
>> +
>> +	/* Issue the request and wait to finish */
>> +	ret = rzg3s_pcie_child_issue_request(host);
>> +	if (ret)
>> +		return PCIBIOS_SET_FAILED;
>> +
>> +	/* Read the data */
>> +	*data = readl(host->axi + RZG3S_PCI_REQRCVDAT);
>> +
>> +	return PCIBIOS_SUCCESSFUL;
>> +}
> 
>> +static irqreturn_t rzg3s_pcie_msi_irq(int irq, void *data)
>> +{
>> +	u8 regs = RZG3S_PCI_MSI_INT_NR / RZG3S_PCI_MSI_INT_PER_REG;
>> +	DECLARE_BITMAP(bitmap, RZG3S_PCI_MSI_INT_NR);
>> +	struct rzg3s_pcie_host *host = data;
>> +	struct rzg3s_pcie_msi *msi = &host->msi;
>> +	unsigned long bit;
>> +	u32 status;
>> +
>> +	status = readl(host->axi + RZG3S_PCI_PINTRCVIS);
>> +	if (!(status & RZG3S_PCI_PINTRCVIS_MSI))
>> +		return IRQ_NONE;
>> +
>> +	/* Clear the MSI */
>> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
>> +			       RZG3S_PCI_PINTRCVIS_MSI,
>> +			       RZG3S_PCI_PINTRCVIS_MSI);
>> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSGRCVIS,
>> +			       RZG3S_PCI_MSGRCVIS_MRI, RZG3S_PCI_MSGRCVIS_MRI);
>> +
>> +	for (u8 reg_id = 0; reg_id < regs; reg_id++) {
>> +		status = readl(host->axi + RZG3S_PCI_MSIRS(reg_id));
>> +		bitmap_write(bitmap, status, reg_id * RZG3S_PCI_MSI_INT_PER_REG,
>> +			     RZG3S_PCI_MSI_INT_PER_REG);
>> +	}
>> +
>> +	for_each_set_bit(bit, bitmap, RZG3S_PCI_MSI_INT_NR) {
>> +		int ret;
>> +
>> +		ret = generic_handle_domain_irq(msi->domain->parent, bit);
>> +		if (ret) {
>> +			u8 reg_bit = bit % RZG3S_PCI_MSI_INT_PER_REG;
>> +			u8 reg_id = bit / RZG3S_PCI_MSI_INT_PER_REG;
>> +
>> +			/* Unknown MSI, just clear it */
>> +			writel(BIT(reg_bit),
>> +			       host->axi + RZG3S_PCI_MSIRS(reg_id));
>> +		}
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void rzg3s_pcie_msi_top_irq_ack(struct irq_data *d)
>> +{
>> +	irq_chip_ack_parent(d);
>> +}
>> +
>> +static void rzg3s_pcie_msi_top_irq_mask(struct irq_data *d)
>> +{
>> +	pci_msi_mask_irq(d);
>> +	irq_chip_mask_parent(d);
>> +}
>> +
>> +static void rzg3s_pcie_msi_top_irq_unmask(struct irq_data *d)
>> +{
>> +	pci_msi_unmask_irq(d);
>> +	irq_chip_unmask_parent(d);
>> +}
>> +
>> +static struct irq_chip rzg3s_pcie_msi_top_chip = {
>> +	.name		= "PCIe MSI",
>> +	.irq_ack	= rzg3s_pcie_msi_top_irq_ack,
>> +	.irq_mask	= rzg3s_pcie_msi_top_irq_mask,
>> +	.irq_unmask	= rzg3s_pcie_msi_top_irq_unmask,
>> +};
>> +
>> +static void rzg3s_pcie_msi_irq_ack(struct irq_data *d)
>> +{
>> +	struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(d);
>> +	struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
>> +	u8 reg_bit = d->hwirq % RZG3S_PCI_MSI_INT_PER_REG;
>> +	u8 reg_id = d->hwirq / RZG3S_PCI_MSI_INT_PER_REG;
>> +
>> +	guard(raw_spinlock_irqsave)(&host->hw_lock);
>> +
>> +	writel(BIT(reg_bit), host->axi + RZG3S_PCI_MSIRS(reg_id));
>> +}
>> +
>> +static void rzg3s_pcie_msi_irq_mask(struct irq_data *d)
>> +{
>> +	struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(d);
>> +	struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
>> +	u8 reg_bit = d->hwirq % RZG3S_PCI_MSI_INT_PER_REG;
>> +	u8 reg_id = d->hwirq / RZG3S_PCI_MSI_INT_PER_REG;
>> +
>> +	guard(raw_spinlock_irqsave)(&host->hw_lock);
>> +
>> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSIRM(reg_id), BIT(reg_bit),
>> +			       BIT(reg_bit));
>> +}
>> +
>> +static void rzg3s_pcie_msi_irq_unmask(struct irq_data *d)
>> +{
>> +	struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(d);
>> +	struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
>> +	u8 reg_bit = d->hwirq % RZG3S_PCI_MSI_INT_PER_REG;
>> +	u8 reg_id = d->hwirq / RZG3S_PCI_MSI_INT_PER_REG;
>> +
>> +	guard(raw_spinlock_irqsave)(&host->hw_lock);
>> +
>> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSIRM(reg_id), BIT(reg_bit),
>> +			       0);
>> +}
>> +
>> +static void rzg3s_pcie_irq_compose_msi_msg(struct irq_data *data,
>> +					   struct msi_msg *msg)
>> +{
>> +	struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(data);
>> +	struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
>> +	u32 drop_mask = RZG3S_PCI_MSIRCVWADRL_ENA |
>> +			RZG3S_PCI_MSIRCVWADRL_MSG_DATA_ENA;
>> +	u32 lo, hi;
>> +
>> +	/*
>> +	 * Enable and msg data enable bits are part of the address lo. Drop
>> +	 * them.
>> +	 */
>> +	lo = readl(host->axi + RZG3S_PCI_MSIRCVWADRL) & ~drop_mask;
>> +	hi = readl(host->axi + RZG3S_PCI_MSIRCVWADRU);
>> +
>> +	msg->address_lo = lo;
>> +	msg->address_hi = hi;
>> +	msg->data = data->hwirq;
>> +}
>> +
>> +static struct irq_chip rzg3s_pcie_msi_bottom_chip = {
>> +	.name			= "rzg3s-pcie-msi",
>> +	.irq_ack		= rzg3s_pcie_msi_irq_ack,
>> +	.irq_mask		= rzg3s_pcie_msi_irq_mask,
>> +	.irq_unmask		= rzg3s_pcie_msi_irq_unmask,
>> +	.irq_compose_msi_msg	= rzg3s_pcie_irq_compose_msi_msg,
>> +};
>> +
>> +static int rzg3s_pcie_msi_domain_alloc(struct irq_domain *domain,
>> +				       unsigned int virq, unsigned int nr_irqs,
>> +				       void *args)
>> +{
>> +	struct rzg3s_pcie_msi *msi = domain->host_data;
>> +	int hwirq;
>> +
>> +	scoped_guard(mutex, &msi->map_lock) {
>> +		hwirq = bitmap_find_free_region(msi->map, RZG3S_PCI_MSI_INT_NR,
>> +						order_base_2(nr_irqs));
>> +	}
>> +
>> +	if (hwirq < 0)
>> +		return -ENOSPC;
>> +
>> +	for (unsigned int i = 0; i < nr_irqs; i++) {
>> +		irq_domain_set_info(domain, virq + i, hwirq + i,
>> +				    &rzg3s_pcie_msi_bottom_chip,
>> +				    domain->host_data, handle_edge_irq, NULL,
>> +				    NULL);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void rzg3s_pcie_msi_domain_free(struct irq_domain *domain,
>> +				       unsigned int virq, unsigned int nr_irqs)
>> +{
>> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
>> +	struct rzg3s_pcie_msi *msi = domain->host_data;
>> +
>> +	guard(mutex)(&msi->map_lock);
>> +
>> +	bitmap_release_region(msi->map, d->hwirq, order_base_2(nr_irqs));
>> +}
>> +
>> +static const struct irq_domain_ops rzg3s_pcie_msi_domain_ops = {
>> +	.alloc	= rzg3s_pcie_msi_domain_alloc,
>> +	.free	= rzg3s_pcie_msi_domain_free,
>> +};
>> +
>> +static struct msi_domain_info rzg3s_pcie_msi_info = {
>> +	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>> +		  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_NO_AFFINITY,
>> +	.chip	= &rzg3s_pcie_msi_top_chip,
>> +};
>> +
>> +static int rzg3s_pcie_msi_allocate_domains(struct rzg3s_pcie_msi *msi)
>> +{
>> +	struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
>> +	struct device *dev = host->dev;
>> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
>> +	struct irq_domain *parent;
>> +
>> +	parent = irq_domain_create_linear(fwnode, RZG3S_PCI_MSI_INT_NR,
>> +					  &rzg3s_pcie_msi_domain_ops, msi);
>> +	if (!parent)
>> +		return dev_err_probe(dev, -ENOMEM,
>> +				     "failed to create IRQ domain\n");
>> +	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
>> +
>> +	msi->domain = pci_msi_create_irq_domain(fwnode, &rzg3s_pcie_msi_info,
>> +						parent);
>> +	if (!msi->domain) {
>> +		irq_domain_remove(parent);
>> +		return dev_err_probe(dev, -ENOMEM,
>> +				     "failed to create MSI domain\n");
>> +	}
> 
> Can you please rework this to follow what Nam Cao is doing for
> existing drivers:
> https://lore.kernel.org/r/cover.1750858083.git.namcao@linutronix.de

Sure! Thank you for pointing it!

> 
>> +static int rzg3s_pcie_intx_setup(struct rzg3s_pcie_host *host)
>> +{
>> +	struct device *dev = host->dev;
>> +
>> +	for (int i = 0; i < PCI_NUM_INTX; i++) {
>> +		struct platform_device *pdev = to_platform_device(dev);
>> +		char irq_name[5] = {0};
>> +		int irq;
>> +
>> +		scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 97 + i);
> 
> Can you use 'a' instead of 97?

Yes!

> 
>> +		irq = platform_get_irq_byname(pdev, irq_name);
>> +		if (irq < 0)
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "Failed to parse and map INT%c IRQ\n",
>> +					     65 + i);
> 
> And 'A' instead of 65?

Yes!

> 
>> +static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
>> +{
>> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
>> +	struct resource_entry *ft;
>> +	struct resource *bus;
>> +	u8 subordinate_bus;
>> +	u8 secondary_bus;
>> +	u8 primary_bus;
>> +
>> +	ft = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
>> +	if (!ft)
>> +		return -ENODEV;
>> +
>> +	bus = ft->res;
>> +	primary_bus = bus->start;
>> +	secondary_bus = bus->start + 1;
>> +	subordinate_bus = bus->end;
>> +
>> +	/* Enable access control to the CFGU */
>> +	writel(RZG3S_PCI_PERM_CFG_HWINIT_EN, host->axi + RZG3S_PCI_PERM);
>> +
>> +	/* Update vendor ID and device ID */
>> +	writew(host->vendor_id, host->pcie + PCI_VENDOR_ID);
>> +	writew(host->device_id, host->pcie + PCI_DEVICE_ID);
>> +
>> +	/* HW manual recommends to write 0xffffffff on initialization */
>> +	writel(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
>> +	writel(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
>> +
>> +	/* Update bus info. */
> 
> Drop period at end to match other one-line single-sentence comments.

Missed it. I'll drop it.

> 
>> +	writeb(primary_bus, host->pcie + PCI_PRIMARY_BUS);
>> +	writeb(secondary_bus, host->pcie + PCI_SECONDARY_BUS);
>> +	writeb(subordinate_bus, host->pcie + PCI_SUBORDINATE_BUS);
>> +
>> +	/* Disable access control to the CFGU */
>> +	writel(0, host->axi + RZG3S_PCI_PERM);
>> +
>> +	return 0;
>> +}
> 
>> +static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host, bool probe)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	/* Initialize the PCIe related registers */
>> +	ret = rzg3s_pcie_config_init(host);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Initialize the interrupts */
>> +	rzg3s_pcie_irq_init(host);
>> +
>> +	ret = reset_control_bulk_deassert(host->data->num_cfg_resets,
>> +					  host->cfg_resets);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Wait for link up */
>> +	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
>> +				 !(val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS),
>> +				 PCIE_LINK_WAIT_SLEEP_MS,
>> +				 PCIE_LINK_WAIT_SLEEP_MS *
>> +				 PCIE_LINK_WAIT_MAX_RETRIES * MILLI);
>> +	if (ret) {
>> +		reset_control_bulk_assert(host->data->num_cfg_resets,
>> +					  host->cfg_resets);
>> +		return ret;
>> +	}
>> +
>> +	val = readl(host->axi + RZG3S_PCI_PCSTAT2);
>> +	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
>> +
>> +	val = FIELD_GET(RZG3S_PCI_PCSTAT2_STATE_RX_DETECT, val);
>> +	dev_info(host->dev, "PCIe x%d: link up\n", hweight32(val));
> 
> Maybe a little verbose for production use?

OK, I'll drop it.

> 
>> +	if (probe) {
>> +		ret = devm_add_action_or_reset(host->dev,
>> +					       rzg3s_pcie_cfg_resets_action,
>> +					       host);
>> +	}
>> +
>> +	return ret;
>> +}
> 
>> +static int rzg3s_soc_pcie_init_phy(struct rzg3s_pcie_host *host)
>> +{
>> +	static const u32 xcfgd_settings[RZG3S_PCI_PHY_XCFGD_NUM] = {
>> +		[8]  = 0xe0006801, 0x007f7e30, 0x183e0000, 0x978ff500,
>> +		       0xec000000, 0x009f1400, 0x0000d009,
>> +		[17] = 0x78000000,
>> +		[19] = 0x00880000, 0x000005c0, 0x07000000, 0x00780920,
>> +		       0xc9400ce2, 0x90000c0c, 0x000c1414, 0x00005034,
>> +		       0x00006000, 0x00000001,
>> +	};
>> +	static const u32 xcfga_cmn_settings[RZG3S_PCI_PHY_XCFGA_CMN_NUM] = {
>> +		0x00000d10, 0x08310100, 0x00c21404, 0x013c0010, 0x01874440,
>> +		0x1a216082, 0x00103440, 0x00000080, 0x00000010, 0x0c1000c1,
>> +		0x1000c100, 0x0222000c, 0x00640019, 0x00a00028, 0x01d11228,
>> +		0x0201001d,
>> +	};
>> +	static const u32 xcfga_rx_settings[RZG3S_PCI_PHY_XCFGA_RX_NUM] = {
>> +		0x07d55000, 0x030e3f00, 0x00000288, 0x102c5880, 0x0000000b,
>> +		0x04141441, 0x00641641, 0x00d63d63, 0x00641641, 0x01970377,
>> +		0x00190287, 0x00190028, 0x00000028,
>> +	};
>> +
>> +	/*
>> +	 * Enable access permission for physical layer control and status
>> +	 * registers.
>> +	 */
>> +	writel(RZG3S_PCI_PERM_PIPE_PHY_REG_EN, host->axi + RZG3S_PCI_PERM);
>> +
>> +	for (u8 i = 0; i < RZG3S_PCI_PHY_XCFGD_NUM; i++)
>> +		writel(xcfgd_settings[i], host->axi + RZG3S_PCI_PHY_XCFGD(i));
>> +
>> +	for (u8 i = 0; i < RZG3S_PCI_PHY_XCFGA_CMN_NUM; i++) {
>> +		writel(xcfga_cmn_settings[i],
>> +		       host->axi + RZG3S_PCI_PHY_XCFGA_CMN(i));
>> +	}
>> +
>> +	for (u8 i = 0; i < RZG3S_PCI_PHY_XCFGA_RX_NUM; i++) {
>> +		writel(xcfga_rx_settings[i],
>> +		       host->axi + RZG3S_PCI_PHY_XCFGA_RX(i));
>> +	}
> 
> Why "for (unsigned int i = 0; ...)" above and "u8" here?  Seems like
> similar situation here and no benefit for using u8 vs unsigned int.

OK, I'll use unsigned int here as well.

> 
>> +	writel(0x107, host->axi + RZG3S_PCI_PHY_XCFGA_TX);
>> +
>> +	/* Select PHY settings values */
>> +	writel(RZG3S_PCI_PHY_XCFG_CTRL_PHYREG_SEL,
>> +	       host->axi + RZG3S_PCI_PHY_XCFG_CTRL);
>> +
>> +	/*
>> +	 * Disable access permission for physical layer control and status
>> +	 * registers.
>> +	 */
>> +	writel(0, host->axi + RZG3S_PCI_PERM);
>> +
>> +	return 0;
>> +}
> 
>> +static int
>> +rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
>> +		      int (*intx_setup)(struct rzg3s_pcie_host *host),
>> +		      int (*msi_setup)(struct rzg3s_pcie_host *host),
>> +		      bool probe)
>> +{
>> +	struct device *dev = host->dev;
>> +	int ret;
>> +
>> +	/* Set inbound windows */
>> +	ret = rzg3s_pcie_parse_map_dma_ranges(host);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "Failed to set inbound windows!\n");
>> +
>> +	/* Set outbound windows */
>> +	ret = rzg3s_pcie_parse_map_ranges(host);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "Failed to set outbound windows!\n");
>> +
>> +	/* Set the PHY, if any */
>> +	if (host->data->init_phy) {
>> +		ret = host->data->init_phy(host);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "Failed to set the PHY!\n");
>> +	}
>> +
>> +	if (intx_setup) {
>> +		ret = intx_setup(host);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "Failed to setup INTx\n");
>> +	}
>> +
>> +	/* Set the MSIs */
>> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>> +		ret = msi_setup(host);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "Failed to setup MSIs\n");
>> +	}
>> +
>> +	/* Initialize the host */
> 
> Superfluous comment since you have a good function name.

Will drop it.

> 
>> +	ret = rzg3s_pcie_host_init(host, probe);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "Failed to initialize the HW!\n");
>> +
>> +	/* Try to set maximum supported link speed */
> 
> Ditto.

OK.

> 
>> +	ret = rzg3s_pcie_set_max_link_speed(host);
>> +	if (ret)
>> +		dev_info(dev, "Failed to set max link speed\n");
>> +
>> +	return 0;
>> +}
> 
>> +static int rzg3s_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct pci_host_bridge *bridge;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct device_node *sysc_np __free(device_node) =
>> +		of_parse_phandle(np, "renesas,sysc", 0);
>> +	struct rzg3s_pcie_host *host;
>> +	int ret;
>> +
>> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*host));
>> +	if (!bridge)
>> +		return -ENOMEM;
>> +
>> +	host = pci_host_bridge_priv(bridge);
>> +	host->dev = dev;
>> +	host->data = device_get_match_data(dev);
>> +	platform_set_drvdata(pdev, host);
>> +
>> +	host->axi = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(host->axi))
>> +		return PTR_ERR(host->axi);
>> +	host->pcie = host->axi + RZG3S_PCI_CFG_BASE;
>> +
>> +	ret = of_property_read_u32(np, "vendor-id", &host->vendor_id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = of_property_read_u32(np, "device-id", &host->device_id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	host->sysc = syscon_node_to_regmap(sysc_np);
>> +	if (IS_ERR(host->sysc))
>> +		return PTR_ERR(host->sysc);
>> +
>> +	ret = regmap_update_bits(host->sysc, RZG3S_SYS_PCIE_RST_RSM_B,
>> +				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
>> +				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 1));
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_add_action_or_reset(dev, rzg3s_pcie_sysc_signal_action,
>> +				       host->sysc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = rzg3s_pcie_resets_prepare(host);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_pm_runtime_enable(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_add_action_or_reset(dev, rzg3s_pcie_pm_runtime_put, dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	raw_spin_lock_init(&host->hw_lock);
>> +
>> +	ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_intx_setup,
>> +				    rzg3s_pcie_msi_enable, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msleep(PCIE_RESET_CONFIG_WAIT_MS);
> 
> We also call rzg3s_pcie_host_setup(), where rzg3s_pcie_host_init()
> deasserts all the resets and waits for the link to come up, from
> rzg3s_pcie_resume_noirq().
> 
> Seems like the rzg3s_pcie_resume_noirq() path needs similar delay?
> Perhaps the delay should be in rzg3s_pcie_host_init() where the event
> that defines the beginning of the required delay is?

You're right. I'll add the delay to rzg3s_pcie_host_setup().

> 
>> +	bridge->sysdata = host;
>> +	bridge->ops = &rzg3s_pcie_root_ops;
>> +	bridge->child_ops = &rzg3s_pcie_child_ops;
>> +	ret = pci_host_probe(bridge);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_add_action_or_reset(dev, rzg3s_pcie_host_remove_action,
>> +					host);
>> +}
> 
>> +static int rzg3s_pcie_resume_noirq(struct device *dev)
>> +{
>> +	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
>> +	const struct rzg3s_pcie_soc_data *data = host->data;
>> +	struct regmap *sysc = host->sysc;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
>> +				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
>> +				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 1));
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = rzg3s_pcie_power_resets_deassert(host);
>> +	if (ret)
>> +		goto assert_rst_rsm_b;
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
>> +	if (ret)
>> +		goto assert_power_resets;
>> +
>> +	ret = rzg3s_pcie_host_setup(host, NULL, rzg3s_pcie_msi_hw_setup, false);
>> +	if (ret)
>> +		goto rpm_put;
>> +
>> +	return 0;
>> +
>> +	/*
>> +	 * If any error happens there is no way to recover the IP. Put it in the
>> +	 * lowest possible power state.
>> +	 */
>> +rpm_put:
>> +	pm_runtime_put_sync(dev);
>> +assert_power_resets:
>> +	reset_control_bulk_assert(data->num_power_resets,
>> +				  host->power_resets);
>> +assert_rst_rsm_b:
>> +	regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
>> +			   RZG3S_SYS_PCIE_RST_RSM_B_MASK,
>> +			   FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
>> +	return ret;
>> +}


