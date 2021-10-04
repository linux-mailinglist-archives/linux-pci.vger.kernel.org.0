Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF66842133C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 17:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbhJDQBK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 12:01:10 -0400
Received: from foss.arm.com ([217.140.110.172]:55590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234175AbhJDQBK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 12:01:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBF306D;
        Mon,  4 Oct 2021 08:59:20 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26E2C3F70D;
        Mon,  4 Oct 2021 08:59:20 -0700 (PDT)
Date:   Mon, 4 Oct 2021 16:59:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqdomain: Export __irq_domain_alloc_irqs() to modules
Message-ID: <20211004155915.GA25619@lpieralisi>
References: <20211004150552.3844830-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004150552.3844830-1-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 04, 2021 at 04:05:52PM +0100, Marc Zyngier wrote:
> The Apple PCIe controller driver allocates interrupts generated
> by the PCIe ports, and uses irq_domain_alloc_irqs() for that.
> THis is an inline function that uses __irq_domain_alloc_irqs()
> as a backend.
> 
> Since the driver can be built as a module, __irq_domain_alloc_irqs()
> must be exported.
> 
> Fixes: 201adeaa9d82 ("PCI: apple: Add INTx and per-port interrupt support")

I have squashed this patch into the commit it is fixing and pushed
pci/apple out.

I could have merged it as a standalone patch before the commit it is
fixing but it would not make sense on its own I believe, happy to
rectify the branch in case that's preferred.

Lorenzo

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
> 
> Notes:
>     Since the offending code is only in the PCI tree so far,
>     it would make sense if Lorenzo could take this patch directly.
> 
>  kernel/irq/irqdomain.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 5a698c1f6cc6..40e85a46f913 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1502,6 +1502,7 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
>  	irq_free_descs(virq, nr_irqs);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(__irq_domain_alloc_irqs);
>  
>  /* The irq_data was moved, fix the revmap to refer to the new location */
>  static void irq_domain_fix_revmap(struct irq_data *d)
> -- 
> 2.30.2
> 
