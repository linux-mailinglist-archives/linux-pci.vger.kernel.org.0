Return-Path: <linux-pci+bounces-22715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC0FA4B0C5
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 10:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E463A9D4C
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 09:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8575515624B;
	Sun,  2 Mar 2025 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GypIFtvj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="alBn7Xau"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D5FC0E;
	Sun,  2 Mar 2025 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740906067; cv=none; b=Q906tMTYjM3Ns1lWwhRSnlUqTi8JKQK3GZCnkC3mRpN1TFAbX5sfowk7fQ7zADBqgVmrfzKa0MR4L6AMVSPxvU4z9jM9AODV/bWtbZWsignGRyiRBSDwHb24xkDTz/1d5L5xLBT/ctJvnuprZ3UgD0o2cRdPUhw1kkOX7+A4KEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740906067; c=relaxed/simple;
	bh=C6tq+Dlkj8fuLHJjs2IpPWa9ylx/Xwa5aOmduQBT0QI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g+UhO0SFcpyyWr55WyPDNHuBguWZeePcf+pUK/AgDUHB+GOlMNtztT9Eb6CMnfZb8AyfAwWG5gHGIGyhKPLGmr6WmTVO+9L6BXWiqWUh9v5lxx0qamddbfSKsHGjbz3JdWBKZCsQ4GMgJ9wQk8flpkI7m+bZXGoqpSvzQLCrVSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GypIFtvj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=alBn7Xau; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740906062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQYzc6zsy7BVJfHkAaJxgxJ42ZnaVDHORnyS6oWMR/k=;
	b=GypIFtvj3hxRXzg7f8uxJTd52Tn5hUkbAILZHWdGc2vHbWpaw6NpWWfSbgWnE8quXPII6/
	gooHMVln+coU69y9knIULoUTv3E8LdXyRbm87xVjfl+GDduSXt+L3ZNTSRnNmN47EqhQZV
	mskF0OYBAW7FkMeXlOpq6nluBUIHI7FSBpdTFU2omB0xE/HWoCb1rLNKrlyqUzjCbqBjew
	yTkTTWsqB9z7khIWAv2tTPWK7NCSzWzCHANdWLG3Ve9pMxLjgSV1XYDrtSCtgErWGkosW3
	4I9MwwglCLo6jaPxEmAADvaWXZsnO2wU3j6/VGVRJQoZcsYtVpAk9zCtu7I2gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740906062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQYzc6zsy7BVJfHkAaJxgxJ42ZnaVDHORnyS6oWMR/k=;
	b=alBn7XauSzoChXOicRdwxPVSOUm7GhEbHyOG/HgPcSK7ruhmsetRdi9lXLNO1ttKxBOIB7
	M25JGqeVZFo1WtCA==
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kwilczynski@kernel.org,
 bhelgaas@google.com, Frank.Li@nxp.com, cassel@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Hans Zhang
 <18255117159@163.com>
Subject: Re: [v2] genirq/msi: Add the address and data that show MSI/MSIX
In-Reply-To: <20250301123953.291675-1-18255117159@163.com>
References: <20250301123953.291675-1-18255117159@163.com>
Date: Sun, 02 Mar 2025 10:01:02 +0100
Message-ID: <87plizdcxd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hans!

On Sat, Mar 01 2025 at 20:39, Hans Zhang wrote:
> The debug_show() callback function is implemented in the MSI core code.
> And assign it to the domain ops::debug_show() creation.
>
> cat /sys/kernel/debug/irq/irqs/msi_irq_num, the address and data stored
> in the MSI capability or the address and data stored in the MSIX vector
> table will be displayed.

So this explains what the patch is doing and what the output is. But it
fails to explain the _why_. Documentation gives proper guidance:

 https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
 https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-changes

> e.g.
> root@root:/sys/kernel/debug/irq/irqs# cat /proc/interrupts | grep ITS
>  85:          0          0          0          0          0          0          0          0          0          0          0          0   ITS-MSI 75497472 Edge      PCIe PME, aerdrv
>  86:          0         30          0          0          0          0          0          0          0          0          0          0   ITS-MSI 76021760 Edge      nvme0q0
>  87:        287          0          0          0          0          0          0          0          0          0          0          0   ITS-MSI 76021761 Edge      nvme0q1
>  88:          0        265          0          0          0          0          0          0          0          0          0          0   ITS-MSI 76021762 Edge      nvme0q2
>  89:          0          0        177          0          0          0          0          0          0          0          0          0   ITS-MSI 76021763 Edge      nvme0q3
>  90:          0          0          0         76          0          0          0          0          0          0          0          0   ITS-MSI 76021764 Edge      nvme0q4
>  91:          0          0          0          0        161          0          0          0          0          0          0          0   ITS-MSI 76021765 Edge      nvme0q5
>  92:          0          0          0          0          0        991          0          0          0          0          0          0   ITS-MSI 76021766 Edge      nvme0q6
>  93:          0          0          0          0          0          0        194          0          0          0          0          0   ITS-MSI 76021767 Edge      nvme0q7
>  94:          0          0          0          0          0          0          0         94          0          0          0          0   ITS-MSI 76021768 Edge      nvme0q8
>  95:          0          0          0          0          0          0          0          0        148          0          0          0   ITS-MSI 76021769 Edge      nvme0q9
>  96:          0          0          0          0          0          0          0          0          0        261          0          0   ITS-MSI 76021770 Edge      nvme0q10
>  97:          0          0          0          0          0          0          0          0          0          0        127          0   ITS-MSI 76021771 Edge      nvme0q11
>  98:          0          0          0          0          0          0          0          0          0          0          0        317   ITS-MSI 76021772 Edge      nvme0q12

How is this relevant to describe the patch?

> root@root:/sys/kernel/debug/irq/irqs#
> root@root:/sys/kernel/debug/irq/irqs# cat 87
> handler:  handle_fasteoi_irq
> device:   0000:91:00.0
> status:   0x00000000
> istate:   0x00004000
> ddepth:   0
> wdepth:   0
> dstate:   0x31600200
>             IRQD_ACTIVATED
>             IRQD_IRQ_STARTED
>             IRQD_SINGLE_TARGET
>             IRQD_AFFINITY_MANAGED
>             IRQD_AFFINITY_ON_ACTIVATE
>             IRQD_HANDLE_ENFORCE_IRQCTX
> node:     0
> affinity: 0
> effectiv: 0
> domain:  :soc@0:interrupt-controller@0e001000:its@0e050000-3
>  hwirq:   0x4880001
>  chip:    ITS-MSI

This output is from a pre 6.11 kernel...

>   flags:   0x20
>              IRQCHIP_ONESHOT_SAFE
>  msix:
>   address_hi: 0x00000000
>   address_lo: 0x0e060040
>   msg_data:   0x00000001

For demonstration it's enough to stop here, no?
  
> +static void msi_domain_debug_show(struct seq_file *m, struct irq_domain *d,
> +				  struct irq_data *irqd, int ind)
> +{
> +	struct msi_desc *desc;
> +	bool is_msix;
> +
> +	desc = irq_get_msi_desc(irqd->irq);

Move this up to the declaration.

> +	if (!desc)
> +		return;
> +
> +	is_msix = desc->pci.msi_attrib.is_msix;

That's not valid for non PCI MSI interrupts.

This function is used for all types of MSI interrupts. So for non PCI
MSI interrupts this will output random garbage. Just print the address
and be done with it. The MSI variant is visible from the chip name on
current kernels. It's either ITS-PCI-MSI or ITS-PCI-MSIX and not
ITS-MSI.

> +	seq_printf(m, "%*s%s:", ind, "", is_msix ? "msix" : "msi");
> +	seq_printf(m, "\n%*saddress_hi: 0x%08x", ind + 1, "", desc->msg.address_hi);
> +	seq_printf(m, "\n%*saddress_lo: 0x%08x", ind + 1, "", desc->msg.address_lo);
> +	seq_printf(m, "\n%*smsg_data:   0x%08x\n", ind + 1, "", desc->msg.data);
> +}
> +
>  static const struct irq_domain_ops msi_domain_ops = {
>  	.alloc		= msi_domain_alloc,
>  	.free		= msi_domain_free,
>  	.activate	= msi_domain_activate,
>  	.deactivate	= msi_domain_deactivate,
>  	.translate	= msi_domain_translate,
> +	.debug_show     = msi_domain_debug_show,

This does not build when CONFIG_GENERIC_IRQ_DEBUGFS=n.

Thanks,

        tglx

