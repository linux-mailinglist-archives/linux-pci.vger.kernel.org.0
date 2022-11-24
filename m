Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28E36374CD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 10:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiKXJIo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 04:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiKXJIg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 04:08:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB66B9BB1;
        Thu, 24 Nov 2022 01:08:34 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669280911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vf5+/aiHla/4ly0OoP7CLfyVx7qM6ZIIFk9d+ZXvjMc=;
        b=E89LVilE3e6XbkR6X9uDZKKzxi03YzZUjVl4CePB0jlbeE9d8/7TlYbNAKF9S/x37tm3gR
        T52XSfM8XRu4I86l1xI/mZqPv9JpIjDvjqhh2dSKPTYfjmILdsAdF4EtqbPhLNLpPYtAti
        fRJpG7f732NRs09YUvPA4OmbTwegnRJegyclA2U22FzXqb96GHEVchpRkrH5I2x8+5h8lt
        /sYYIKMGBEpekz5S/FNwC9mQe0HNpegt7kJBGj8EhNInta0qQ6Q4cGFoPHdnXojOKKPvEN
        U2nqmdds2R1SaH8Y4Dm/ZMfXqUkQWRf5iNu8Tpc+Dc+KvPjhbEmqTpF/S/MKcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669280911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vf5+/aiHla/4ly0OoP7CLfyVx7qM6ZIIFk9d+ZXvjMc=;
        b=8+DEVL1J12Cn9H7OIatnawR2Ez/52Y3OObvV/7YWFsre4tCC6OAkwuITbzOnkA2znqIX6n
        11bu0XNmztteaiDg==
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
Subject: RE: [patch V2 25/33] PCI/MSI: Provide post-enable dynamic
 allocation interfaces for MSI-X
In-Reply-To: <BN9PR11MB527668DB0B5B9C8D8C36C95F8C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.869774994@linutronix.de>
 <BN9PR11MB527668DB0B5B9C8D8C36C95F8C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Thu, 24 Nov 2022 10:08:31 +0100
Message-ID: <87r0xsd8j4.ffs@tglx>
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

On Thu, Nov 24 2022 at 02:58, Kevin Tian wrote:
>> +
>> +/**
>> + * pci_msix_free_irq - Free an interrupt on a PCI/MSIX interrupt domain
>> + *		      which was allocated via pci_msix_alloc_irq_at()
>> + *
>> + * @dev:	The PCI device to operate on
>> + * @map:	A struct msi_map describing the interrupt to free
>> + *		as returned from the allocation function.
>> + */
>
> Can this be used on preallocated descriptors? If not any guard required
> or just treat it as a driver responsibility to not misuse?

The preallocated descriptors are only relevant during setup, but not
post setup. So yes, you can do:

pci_alloc_irq_vectors(dev, 10, 10, PCI_IRQ_MSIX);

and then

    map = { .index = 9, .virq = $IRQ };
    pci_msix_free_irq(dev, &map);

It just works.

>> +void pci_msix_free_irq(struct pci_dev *dev, struct msi_map map)
>> +{
>> +	if (WARN_ON_ONCE(map.index < 0 || map.virq <= 0))
>
> map.virq cannot be negative.

Why? Callers can make up whatever they want, no?

Thanks,

        tglx
