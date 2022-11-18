Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EB562F4B5
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 13:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242010AbiKRM1q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 07:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242045AbiKRM1E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 07:27:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70C08CFD9;
        Fri, 18 Nov 2022 04:26:27 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668774386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=trUxr7rxCEBkNFe0vyBij7OY4sK2AiIIhioyMFdro4A=;
        b=fGeg/5CXa5jubxJgYoF+pXoaCBoNr9py1jmGRj9jLGQ6tktckzl+QgI+nWK0vtuXHEEUwN
        ob62Um0CfCj7q90bJYyP7sZXL7XrGiqW70sYUT4Sq2nZNqmEQfRNP2Y2PePUjua3JmpKr0
        iPkb+wppYBkeRPH/gMjqi7or6qgsUF3QfCnLrFk0M/aYDrBX/PbNwIcOr8Vx0fxQc8L2AV
        rEnJZ64haa/yJd2k19SKCd2Fn3NELz6PFOZC8D9m8DS9s9HSd1rlYCs+aHNHBj0wGZ/2kM
        h3/qq3hQhBz9ELKasUQftLL4/lx2rgjbfRPE1hpj/gSRn7YgWr0gZRkpU/j8Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668774386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=trUxr7rxCEBkNFe0vyBij7OY4sK2AiIIhioyMFdro4A=;
        b=CjIz3Cc56KUDhaEWrMvADnvvbhPgm1kUC3pC9Bf8v8s0RNslcliQJ875Gcrp6jUOZLB3iz
        7AlaFjvUlI+aFXCA==
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
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
Subject: RE: [patch 15/20] genirq/msi: Provide new domain id allocation
 functions
In-Reply-To: <BN9PR11MB527679752FAA7294E33619C98C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.892426212@linutronix.de>
 <BN9PR11MB527679752FAA7294E33619C98C099@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Fri, 18 Nov 2022 13:26:25 +0100
Message-ID: <87iljcjvny.ffs@tglx>
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

On Fri, Nov 18 2022 at 08:43, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Sent: Friday, November 11, 2022 9:57 PM
>> 
>> @@ -597,7 +598,7 @@ static struct irq_domain *msi_get_device
>>  	if (!domain)
>>  		return NULL;
>> 
>> -	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain)))
>> +	if (irq_domain_is_msi_parent(domain))
>>  		return NULL;
>
> Is it intended to remove the warning here? If yes, what specific change
> in this patch leads to that removal?

Valid question

>> +	xa_for_each_range(xa, idx, desc, ctrl->first + base, ctrl->last + base) {
>> +		if (!msi_desc_match(desc, MSI_DESC_NOTASSOCIATED))
>> +			continue;
>> +
>> +		/* This should return -ECONFUSED... */
>> +		if (WARN_ON_ONCE(allocated >= ctrl->nirqs))
>> +			return -EINVAL;
>> +
>
> why is "==" an error?

because if you get here _after_ having allocated all interrupts already
then you have more descriptors than what you want to allocate, which
should never happen right?

Thanks,

        tglx


