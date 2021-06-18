Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1773AD2E7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 21:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhFRTek (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 15:34:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58578 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhFRTej (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jun 2021 15:34:39 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624044748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uGYDUibjRJnL82nD8o3BWNGmm7rRgf7fDGXt/JOep+Y=;
        b=sUzKg4BepwE7mv3qWCix1guOBHZSMT8DXBkwFLMTULjbfeKMG/v0Be1pssBXpuJ7qBTefD
        EAZZcGJtwmWTWqNQOzwsdfNv+JGakxIdAvjKTy5DhKOEa2tb9jZpjFwLshZ5nXdaR/vWFB
        +f82bgqbIbec0ACPaDMfh0QHpV8mQBNW/Ngi6TnKCRMlJlivQvuWcSJC8OaGKXFAa6/C4e
        1igh80HtnFSygR8IyCIwjJbh5jNhn/ZA4LT2UB1cEZSuWMW7SN9uyidMjirfiMM5/9FUzL
        bTk2LH8lobMsGTlcV6Om83acKgM4PUNr2UFCR+yBKRgUyS12TvSAVrFOOEnffA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624044748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uGYDUibjRJnL82nD8o3BWNGmm7rRgf7fDGXt/JOep+Y=;
        b=O4Tyuu3AGxQcKB3jYIokFBqi7TQbdNSdn3r02m2Tb81waKj+8YkqzliySHPtD3MwGFeKI3
        49tR6qJY2A6WWYDQ==
To:     Ming Lei <ming.lei@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [patch v6 3/7] genirq/affinity: Add new callback for (re)calculating interrupt sets
In-Reply-To: <YMlIbt3EPyRJHNWf@T590>
References: <20190216172228.512444498@linutronix.de> <20210615195707.GA2909907@bjorn-Precision-5520> <YMlIbt3EPyRJHNWf@T590>
Date:   Fri, 18 Jun 2021 21:32:28 +0200
Message-ID: <875yybezoz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 16 2021 at 08:40, Ming Lei wrote:
> On Tue, Jun 15, 2021 at 02:57:07PM -0500, Bjorn Helgaas wrote:

> +static inline void irq_affinity_calc_sets_legacy(struct irq_affinity *affd)

This function name sucks because the function is really a wrapper around
irq_affinity_calc_sets(). What's so legacy about this? The fact that
it's called from the legacy PCI single interrupt code path?

> @@ -405,6 +405,30 @@ static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
>  	affd->set_size[0] = affvecs;
>  }
>  
> +static void irq_affinity_calc_sets(unsigned int affvecs,
> +		struct irq_affinity *affd)

Please align the arguments when you need a line break.

> +{
> +	/*
> +	 * Simple invocations do not provide a calc_sets() callback. Install
> +	 * the generic one.
> +	 */
> +	if (!affd->calc_sets)
> +		affd->calc_sets = default_calc_sets;
> +
> +	/* Recalculate the sets */
> +	affd->calc_sets(affd, affvecs);
> +
> +	WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS);

Hrm. That function really should return an error code to tell the caller
that something went wrong.

> +}
> +
> +/* Provide a chance to call ->calc_sets for legacy */

What does this comment tell? Close to zero. 

> +void irq_affinity_calc_sets_legacy(struct irq_affinity *affd)
> +{
> +	if (!affd)
> +		return;
> +	irq_affinity_calc_sets(0, affd);
> +}

What's wrong with just exposing irq_affinity_calc_sets() have that
NULL pointer check in the function and add proper function documentation
which explains what this is about?

Thanks,

        tglx
