Return-Path: <linux-pci+bounces-10222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D559A930151
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 22:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E541F22C58
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 20:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08D53BBF2;
	Fri, 12 Jul 2024 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJslttH7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83F2C879
	for <linux-pci@vger.kernel.org>; Fri, 12 Jul 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720816870; cv=none; b=En8NLZ4qQBpoQPgA7Sp7Xf/KG8THYQzgp4aFEUOqA+/Xn5tmkwvoux4o+AdMSi7LesAUekNa2fqfb+QkGhIhGXodgLYIAVR9VKb6NG/sryAHEqZnAThhnHACSWgBZVtbxdGNnLCwsyQV6ukYS+xDM72/QhZFE6tbNRo0+rNth2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720816870; c=relaxed/simple;
	bh=dTCn1JYLyphG0HhWrMCWZ3fJpATH0SVWmU5AKhmUuB4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p+Rdr2DrElZQhK6XjVsuEztgzEDoofHeWtziYkzD9VXPUpKnGZRKY1ii27XvCFyHKE1bxETr1PBcJKR8FeanZIJWd/U8pCNhLQlScJYYOwpvAXKHPBS4w+VfgWhhsXZAWoCben33jKVGIGGGTbZTpaW8WH7qWaIP4y0xwEM1VvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJslttH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33009C32782;
	Fri, 12 Jul 2024 20:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720816869;
	bh=dTCn1JYLyphG0HhWrMCWZ3fJpATH0SVWmU5AKhmUuB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sJslttH73a0cpLDLwR87f0mObTZUfDNuCKXbAOGIY6SF6g/OkijCAmpQfJcov7YR3
	 9ctuwnfbtDYGuPVUtwBtCJTq0nHS5ThC0Ov0u9hT7yb9GrXWPHqQtsGNr2i4vS86OR
	 jIK9HXN6CxvCSVwDheGTjzRjGqWuScQ3FQ2NzRuvdKqnwfIKuBgcVs/zzzYGNMAiXu
	 Rmy6djQQaNlP0DlSat5r3z7DcfR6tvazV/KvEMaTgvWhknzT6XLBX4r5lscKz/i9KZ
	 s8dpQR0Oe1T/0R6IGgTm/ln4wOInXCVlb2YLR35zIbwuZCTdf2vj9Scig/9FIQLyGi
	 EpuZRX6W9zqXg==
Date: Fri, 12 Jul 2024 15:41:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] PCI: mvebu: Dispose INTx IRQs before to removing INTx
 domain
Message-ID: <20240712204106.GA336836@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240711132544.9048-1-kabel@kernel.org>

[+cc Pali, seems like the author should be included,
Thomas, Marc since they actually know about IRQs, unlike me]

On Thu, Jul 11, 2024 at 03:25:44PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> The documentation for the irq_domain_remove() function says that all
> mappings within the IRQ domain must be disposed before the domain is
> removed.
> 
> Currently, the INTx IRQs are not disposed in pci-mvebu driver .remove()
> method, which causes the kernel to crash when unloading the driver and
> then reading /sys/kernel/debug/irq/irqs/<num> or /proc/interrupts.
> 
> Unmapping of the IRQs at this point of the .remove() method is safe,
> since the PCIe bus is already unregistered, and all its devices are
> unbound from their drivers and removed. If there was indeed any
> remaining use of PCIe resources, then it would mean that PCIe hotplug
> code is broken, and we have bigger problems.
> 
> Fixes: ec075262648f ("PCI: mvebu: Implement support for legacy INTx interrupts")
> Reported-by: Hajo Noerenberg <hajo-linux-bugzilla@noerenberg.de>

Is there a URL for this report?

> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> [ Marek: refactored a little, added more explanation to commit message ]
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Changes since v1:
> - added explanation into commit message about why this is safe to do,
>   as suggested by Andy. The explanation originally comes from Pali:
>     https://lore.kernel.org/linux-arm-kernel/20220809133911.hqi7eyskcq2sojia@pali/
> ---
>  drivers/pci/controller/pci-mvebu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 29fe09c99e7d..91a02b23aeb1 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1683,8 +1683,15 @@ static void mvebu_pcie_remove(struct platform_device *pdev)
>  			irq_set_chained_handler_and_data(irq, NULL, NULL);
>  
>  		/* Remove IRQ domains. */
> -		if (port->intx_irq_domain)
> +		if (port->intx_irq_domain) {
> +			for (int j = 0; j < PCI_NUM_INTX; j++) {
> +				int virq = irq_find_mapping(port->intx_irq_domain, j);
> +
> +				if (virq > 0)
> +					irq_dispose_mapping(virq);

I am not an IRQ expert, so all I can really do is compare this to
usage in other drivers.

There are 20+ drivers in drivers/pci/controller, and I don't see
irq_dispose_mapping() usage similar to this elsewhere.  Does that mean
most or all of the other drivers have a similar defect?

> +			}
>  			irq_domain_remove(port->intx_irq_domain);
> +		}
>  
>  		/* Free config space for emulated root bridge. */
>  		pci_bridge_emul_cleanup(&port->bridge);
> -- 
> 2.44.2
> 

