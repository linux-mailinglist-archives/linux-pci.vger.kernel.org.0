Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D5862CDDC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 23:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbiKPWj0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 17:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbiKPWjM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 17:39:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892A76CA20;
        Wed, 16 Nov 2022 14:38:54 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668638333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zZBmGjrWNywxUCFJ3IifR4CdgFbRJ2FrenmoJtPTe4=;
        b=e5HwP7KdGxIAeXgk4rVPee3lmodoWeXo+HSuoRqoOhGBQ9YekKQtIPTt1y/+iNmlsBXyEt
        UOnJSLMCpag6pIXSbhqxPnCGpuXhRXUFjej7tIytSqRO+V+4ycMszLk4S5ICJ4wQBaHa0L
        xs+2jjhx56WlVSMRLZ3ZNuKYW1t1tMasgSt30igDfkWyhPO9qqLLyYjvIUAu/j1kcfpz89
        lwd3TYUVxtO/4dOx/30y+Et5TgMJyNn6PcXzP1BnOvdAmW4/D4Y56iDcHxtX98O3qBDT48
        BwP/OPK0ID8LcQVmSM3wKMfFd6ncZaJfbnv4U+FZ273+KJhl4F8ZJ2Won6bMVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668638333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zZBmGjrWNywxUCFJ3IifR4CdgFbRJ2FrenmoJtPTe4=;
        b=ZAPQya+IEoGSfYiyF4S36PGfB5cX1+c7kBfmwJaOzdop1RlQfHqzml0yRaKn+aVaAJr66O
        Jutfq2lT9iecFDCQ==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 12/33] PCI/MSI: Add support for per device MSI[X] domains
In-Reply-To: <Y3U2QFeoDB17kbIC@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135205.951710169@linutronix.de> <Y3U2QFeoDB17kbIC@nvidia.com>
Date:   Wed, 16 Nov 2022 23:38:52 +0100
Message-ID: <87tu2yo77n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16 2022 at 15:13, Jason Gunthorpe wrote:
> On Fri, Nov 11, 2022 at 02:58:30PM +0100, Thomas Gleixner wrote:
>> +	.info = {
>> +		.flags			= MSI_COMMON_FLAGS | MSI_FLAG_PCI_MSIX,
>> +		.bus_token		= DOMAIN_BUS_PCI_DEVICE_MSIX,
>> +	},
>> +};
>
> I like this splitting alot, it makes the whole thing make so much more
> sense.

:)

>> +bool pci_setup_msi_device_domain(struct pci_dev *pdev)
>> +{
>> +	if (WARN_ON_ONCE(pdev->msix_enabled))
>> +		return false;
>> +
>> +	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSI))
>> +		return true;
>> +	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSIX))
>> +		msi_remove_device_irq_domain(&pdev->dev, MSI_DEFAULT_DOMAIN);
>> +
>> +	return pci_create_device_domain(pdev, &pci_msi_template, 1);
>
> Hardwired to one 1? What about multi-msi?

MSI has exactly ONE descriptor whether it's single or multi-MSI.

Multi-MSI can have several interrupts hanging off the same descriptor,
but that's not how MSI looks at it because you write ONE message and the
hardware does the substitution of the low bits depending on which vector
is raised.

I pondered to change that, but that would have required to create yet
another code path for the 20years legacy and to adjust every single
implementation of PCI/MSI domains or the underlying parents to handle
this new world order. About 5 years later we might talk about per device
domains then.

Thanks,

        tglx


