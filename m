Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15D43C889
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 13:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhJ0L3b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 07:29:31 -0400
Received: from foss.arm.com ([217.140.110.172]:42234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhJ0L3b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Oct 2021 07:29:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B68C91FB;
        Wed, 27 Oct 2021 04:27:05 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 114503F73D;
        Wed, 27 Oct 2021 04:27:04 -0700 (PDT)
Date:   Wed, 27 Oct 2021 12:26:53 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 02/14] PCI: aardvark: Fix return value of MSI domain
 .alloc() method
Message-ID: <20211027112644.GA26799@lpieralisi>
References: <20211012164145.14126-1-kabel@kernel.org>
 <20211012164145.14126-3-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012164145.14126-3-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 12, 2021 at 06:41:33PM +0200, Marek Behún wrote:
> MSI domain callback .alloc() (implemented by advk_msi_irq_domain_alloc()
> function) should return zero on success, since non-zero value indicates
> failure.

AFAICS the .alloc() method is called in:

irq_domain_alloc_irqs_hierarchy()

which in turn is called by:

__irq_domain_alloc_irqs() -> that checks (ret < 0)

irq_domain_push_irq() -> that checks for rv != 0

irq_domain_alloc_irqs_parent() called by many drivers and also
by msi_domain_alloc() (that checks ret < 0)

This patch is fine, I am just asking, given the above:

- How did you detect it (given that aardvark would not fail ret < 0) ?
- Should we consolidate the .alloc() return value handling ?

Apologies if I missed something in the IRQ domain code.

Lorenzo

> When the driver was converted to generic MSI API in commit f21a8b1b6837
> ("PCI: aardvark: Move to MSI handling using generic MSI support"), it
> was converted so that it returns hwirq number.
> 
> Fix this.
> 
> Fixes: f21a8b1b6837 ("PCI: aardvark: Move to MSI handling using generic MSI support")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/controller/pci-aardvark.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 10476c00b312..b45ff2911c80 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1138,7 +1138,7 @@ static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
>  				    domain->host_data, handle_simple_irq,
>  				    NULL, NULL);
>  
> -	return hwirq;
> +	return 0;
>  }
>  
>  static void advk_msi_irq_domain_free(struct irq_domain *domain,
> -- 
> 2.32.0
> 
