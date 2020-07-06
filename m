Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3212155CE
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 12:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgGFKsC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 06:48:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52700 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGFKsC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 06:48:02 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594032480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ryULezFbU3iE3FV+1KiAcyS0B3KQeoB+0E7m+OMxzY=;
        b=1VTzGoaEVLU5NgThrv68vdE8A4mZDp358FgtovyrayXqeYnMYx+vffjdtYluQUBn7ziw6f
        pQMFP+jHt1KC47MjkAyg8cYlGKreqHTnJ0IOjYofMmb8Hkv+rHSSmuB55B9r8YP9UouMAK
        ktOe3tvZPUFdp8FgbabNzIY/pzcNPdXeHdp2dRszQaDC1Zq0yVh8aRxJv87y6Aqg3b2BaU
        4kPnWVg3Zam7afIsrKqZlNO+LnpNoceksS24GVH5kUnFyPDeZbTSaoF5Rv01qK7b4KEkbS
        mAcyf3/19HNsCGKHAh8fhwjMGrDyQ5tLq48P6EbgXy46nS761eg8H7L3htsYNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594032480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ryULezFbU3iE3FV+1KiAcyS0B3KQeoB+0E7m+OMxzY=;
        b=IPvRAFzkVI93Cus+spJhSR6HotJrPYdZiPG7zZfdbzSMtIb7fTvI7J7l2TvUBT55Cbi/As
        SheIr6mxRD5heQAA==
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain life
In-Reply-To: <20200630163332.GA3437879@bjorn-Precision-5520>
References: <20200630163332.GA3437879@bjorn-Precision-5520>
Date:   Mon, 06 Jul 2020 12:47:59 +0200
Message-ID: <873664syw0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Tue, Jun 30, 2020 at 12:39:08PM +0300, Andy Shevchenko wrote:
>> The problem here is in the original patch which relies on the
>> knowledge that fwnode is (was) not used anyhow specifically for ACPI
>> case. That said, it makes fwnode a dangling pointer which I
>> personally consider as a mine left for others. That's why the Fixes
>> refers to the initial commit. The latter just has been blasted on
>> that mine.

No. The original patch did not create a dangling pointer because fwnode
was not stored for IRQCHIP_FWNODE_NAMED and IRQCHIP_FWNODE_NAMED_ID type
nodes.

The fail was introduced in:

711419e504eb ("irqdomain: Add the missing assignment of domain->fwnode for named fwnode")

> IIUC, you're saying this pattern:
>
>   fwnode = irq_domain_alloc_named_id_fwnode(...)
>   irq_domain = pci_msi_create_irq_domain(fwnode, ...)
>   irq_domain_free_fwnode(fwnode)
>
> leaves a dangling fwnode pointer.  That does look suspicious because
> __irq_domain_add() saves fwnode:
>
>   irq_domain = pci_msi_create_irq_domain(fwnode, ...)
>     msi_create_irq_domain(fwnode, ...)
>       irq_domain_create_hierarchy(..., fwnode, ...)
> 	irq_domain_create_linear(fwnode, ...)
> 	  __irq_domain_add(fwnode, ...)
> 	    domain->fwnode = fwnode
>
> and irq_domain_free_fwnode() frees it.  But I'm confused because there
> are several other instances of this pattern:
>
>   bridge_probe()                      # arch/mips/pci/pci-xtalk-bridge.c
>   mp_irqdomain_create()
>   arch_init_msi_domain()
>   arch_create_remap_msi_irq_domain()
>   dmar_get_irq_domain()
>   hpet_create_irq_domain()
>   ...
>
> Are they all wrong?  I definitely think it's a bad idea to keep a copy
> of a pointer after we free the data it points to.  But if they're all
> wrong, I don't want to fix just one and leave all the others.
>
> Thomas, can you enlighten us?

Did so. And yes, all instances which do alloc/create/free are busted
since that commit.

Thanks,

        tglx
