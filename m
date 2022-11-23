Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2000636075
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 14:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbiKWNvk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 08:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbiKWNvS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 08:51:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D572181D;
        Wed, 23 Nov 2022 05:42:13 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669210931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3w3v4/UzR7fUI27II1khhAoE3yCMnYi0dCnXEjA/Pt0=;
        b=QymXP1PfA635NFW9W28ggBDHxu7s38hd04fusJX8sm5j7x+P1R+au45E4fMe8yib9E/YAL
        W56eUNygUmzDIu9e9pEIfgmvvZXDl5V2dDX9xQwj5Om1clHLvl12pJBCszscS9cwqysIeB
        9iQ310MaxjcPg22AJr/u28F5Vz6yILIz/lnLKEiBwy+IjzM52/6E0P3fPHPpnSMyAJJlQW
        V3uT0wtcoDfqosln8wBR9rR3tY3zyB3UHPINmgNH+Y1qPJPkGg0CRKIg3j8I3nTX196ZJS
        TgEPnwgrUthIahonWcrnRYJ96RzkpoOw2yk8Dm9pIr6IzTHcFp5nsiNa/0WeUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669210931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3w3v4/UzR7fUI27II1khhAoE3yCMnYi0dCnXEjA/Pt0=;
        b=8lxeHUvSB1L6YbyJW9i+pEva3FYbsyr5CgAYvhxaDO46eruMuk68rr6WBYoJdecnntzVx+
        lmvqYnvE57EUwGAA==
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: RE: [patch V2 13/33] x86/apic/vector: Provide MSI parent domain
In-Reply-To: <BN9PR11MB5276223A2114DD96420C7B1D8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.217466288@linutronix.de>
 <BN9PR11MB5276223A2114DD96420C7B1D8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Wed, 23 Nov 2022 14:42:10 +0100
Message-ID: <87tu2peqj1.ffs@tglx>
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

On Wed, Nov 23 2022 at 08:16, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Sent: Monday, November 21, 2022 10:38 PM
>> 
>> +bool pci_dev_has_default_msi_parent_domain(struct pci_dev *dev)
>> +{
>> +	struct irq_domain *domain = dev_get_msi_domain(&dev->dev);
>> 
>> -int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
>> -		    msi_alloc_info_t *arg)
>> +	if (!domain)
>> +		domain = dev_get_msi_domain(&dev->bus->dev);
>> +	if (!domain)
>> +		return false;
>> +
>> +	return domain == x86_vector_domain;
>
> the function name is about parent domain but there is no check on
> the parent flag. Probably just remove 'parent'?

No. This checks whether the device has the default MSI parent domain,
which _IS_ the vector domain.

I really don't have to check whether the vector domain has the MSI
parent flag set or not. It _IS_ set. If that gets lost later then the
result of the above function is the least of our problems.

>> +/**
>> + * x86_init_dev_msi_info - Domain info setup for MSI domains
>> + * @dev:		The device for which the domain should be created
>> + * @domain:		The (root) domain providing this callback
>
> what is the purpose of '(root)'? it's also used by intermediate domain
> i.e. IR.

It _can_ be used, yes. But the way I implemented IR MSI parents it is
not used by it.

>> +
>> +	/*
>> +	 * Mask out the domain specific MSI feature flags which are not
>> +	 * supported by the real parent.
>> +	 */
>> +	info->flags			&= pops->supported_flags;
>> +	/* Enforce the required flags */
>> +	info->flags			|=
>> X86_VECTOR_MSI_FLAGS_REQUIRED;
>> +
>> +	/* This is always invoked from the top level MSI domain! */
>> +	info->ops->msi_prepare		= x86_msi_prepare;
>> +
>> +	info->chip->irq_ack		= irq_chip_ack_parent;
>> +	info->chip->irq_retrigger	= irq_chip_retrigger_hierarchy;
>> +	info->chip->flags		|= IRQCHIP_SKIP_SET_WAKE |
>> +					   IRQCHIP_AFFINITY_PRE_STARTUP;
>
> Above are executed twice for both IR and vector after next patch comes.
> Could skip it for IR.

How so?

+static const struct msi_parent_ops dmar_msi_parent_ops = {
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_MSI,
+	.prefix			= "IR-",
+	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
+};

IR delegates the init to its parent domain, i.e. the vector domain. So
there is no double invocation.

Thanks,

        tglx
