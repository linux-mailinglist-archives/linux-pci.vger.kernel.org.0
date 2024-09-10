Return-Path: <linux-pci+bounces-12998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E522B973CCD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 17:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9573285111
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 15:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F143819DFAC;
	Tue, 10 Sep 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3YvGKIku";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nOXDYXyK"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB49191F97;
	Tue, 10 Sep 2024 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983899; cv=none; b=pPDdm6xx7b1BD3LxA92pfQf30Ngf/23y7adXOX+Va+AhaUkVbnakh8Ywv0teobNdaMi86LyhjAukJoP4iyk8cI7cOP7EUh9EQ5cbmq1qfrm3HWOnETph6TXshtkoa49C6rxSURHQPZ4deps+AFEvz+b4rOXME2NQKe+zI9Z5mM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983899; c=relaxed/simple;
	bh=BcDQ0tP+lMxKgQtrtnU7NkgYviUPvUeZT8xDP42dGxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HrnNlZLl0c4Kw5VakIEZXCyM3Z7hNdjxBKSFxmNjzKricO391SA9Qe/YjWk+UMR/OVuEhnNujNyQVgkHMAVEYdYxeqU87Jgs+PJWGaDUZ0oo6JxxkuUxGdFUoHk72X9CFQGCEIguWuqENYl9w5NOaQQcMuoUDP7qi5SU03VbkrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3YvGKIku; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nOXDYXyK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725983896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYuy0gE/Csnq6CPjPynB+thwHl+NK+QDx3CCg79tANw=;
	b=3YvGKIkulMjWSxMFtwlNIAzmYpBeHw1URc4C+ycSUDYGdD7pxLEXc2TowKAXLwT5dEjtNa
	BxO24vkHV9ZJ3ucu78nX1lVOgRX/F8a5bbW+3kykcbckVInhZ45OmFFv2CWKJwnMXGxg3i
	YWKNX2ZprZdXQD1B+hreQXeebltGuXPo/mMusaHNZu1RbA2KpuXnaKbs6Q9UrVZ7a7H10G
	SDWTc2wM7i1QWGTW+Gftr/SQujQNlUSYzBDX9dsaPJclyKdaCGPDDoyPurjD70hUfYbZPv
	6sGlVTfnhOANxZxdP+n2f9Am6kHPAjEnTANBJPU0WLft8WIHS5OMApmbjXupnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725983896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYuy0gE/Csnq6CPjPynB+thwHl+NK+QDx3CCg79tANw=;
	b=nOXDYXyK81ou96bJppft20Co7EtkQ9rWp78zV/nliuCMzMamIfannFVkrWzA+tpOrsUzs3
	WgA9TSp9xOC4dICg==
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 kw@linux.com, Philipp Zabel <p.zabel@pengutronix.de>, Andrea della Porta
 <andrea.porta@suse.com>, Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>
Subject: Re: [PATCH v2 -next 03/11] irqchip: mip: Add Broadcom bcm2712 MSI-X
 interrupt controller
In-Reply-To: <20240910151845.17308-4-svarbanov@suse.de>
References: <20240910151845.17308-1-svarbanov@suse.de>
 <20240910151845.17308-4-svarbanov@suse.de>
Date: Tue, 10 Sep 2024 17:58:16 +0200
Message-ID: <87o74va4br.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 10 2024 at 18:18, Stanimir Varbanov wrote:
> +
> +struct mip_priv {
> +	/* used to protect bitmap alloc/free */
> +	spinlock_t lock;
> +	void __iomem *base;
> +	u64 msg_addr;
> +	u32 msi_base;
> +	u32 num_msis;
> +	unsigned long *bitmap;
> +	struct irq_domain *parent;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

And please read the rest of the document too.

> +};
> +
> +static void mip_mask_msi_irq(struct irq_data *d)
> +{
> +	pci_msi_mask_irq(d);
> +	irq_chip_mask_parent(d);
> +}
> +
> +static void mip_unmask_msi_irq(struct irq_data *d)
> +{
> +	pci_msi_unmask_irq(d);
> +	irq_chip_unmask_parent(d);

This is asymmetric vs. mask(), but that's just the usual copy & pasta
problem.

> +}
> +static int mip_init_domains(struct mip_priv *priv, struct device_node *np)
> +{
> +	struct irq_domain *middle_domain, *msi_domain;
> +
> +	middle_domain = irq_domain_add_hierarchy(priv->parent, 0,
> +						 priv->num_msis, np,
> +						 &mip_middle_domain_ops,
> +						 priv);
> +	if (!middle_domain)
> +		return -ENOMEM;
> +
> +	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(np),
> +					       &mip_msi_domain_info,
> +					       middle_domain);
> +	if (!msi_domain) {
> +		irq_domain_remove(middle_domain);
> +		return -ENOMEM;
> +	}

This is not much different. Please convert this to a proper MSI parent
domain and let the PCI/MSI core handle the PCI/MSI part.

See

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=irq-msi-2024-07-22

for reference.

Thanks,

        tglx

