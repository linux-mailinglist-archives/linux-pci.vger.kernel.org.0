Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278B662F0C9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 10:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbiKRJPp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 04:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241843AbiKRJPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 04:15:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB9754B3C;
        Fri, 18 Nov 2022 01:15:36 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668762933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0RtDA5btK0ampea0tB4KiJj2jZ4ymQLBCgNs6QX082s=;
        b=zBl7wBItViz1JXxmDYMYuwJikf3fa2m4RWvXJfX47lxyWQxGRgK4Daji2wxZCBvaHYLD/q
        SBNuBv74B/60sDOSa65W3rH+BLRDyliHSzLNF5ZrLfkvvp9fTWI33BmaU7hN02u1FFqs7U
        N4aY7z7JgQnhz6IZSCF34d0au0fZjKWBrEzeMV3zTk8VwxQszkhCC2mTu1YJHW0naH/rhE
        CNkGyPWdYyFqsoYtqse5GA2gzXdD7pakEp4MJzYWuD+ixOTRYa0Ibysf4J8dFYNA7cJDY9
        D2FYo2bZf4mrbEnjsAfUoEaL42hOtlGaZFCqmJldvdb0Yd3FQtFHj8dxK5NSrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668762933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0RtDA5btK0ampea0tB4KiJj2jZ4ymQLBCgNs6QX082s=;
        b=bDHnS/NamRxER+XFoJbT1HcWSjju0Fl0Qb1/NAadQLSuEMyZrKFHBq9OLs5LZH4wkfNcrR
        oxE/MxsFYXc0BMCA==
To:     Reinette Chatre <reinette.chatre@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: Re: [patch 21/33] genirq/msi: Provide msi_domain_alloc_irq_at()
In-Reply-To: <87k03tkrii.ffs@tglx>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.463650635@linutronix.de>
 <0cbf645b-b23a-6c85-4389-bb039a677a52@intel.com> <87k03tkrii.ffs@tglx>
Date:   Fri, 18 Nov 2022 10:15:33 +0100
Message-ID: <87zgcok4i2.ffs@tglx>
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

On Fri, Nov 18 2022 at 01:58, Thomas Gleixner wrote:
> On Thu, Nov 17 2022 at 15:33, Reinette Chatre wrote:
>> When calling pci_ims_alloc_irq(), msi_insert_desc() ends up being
>> called twice, first with index = MSI_ANY_INDEX, second with index = 0.
>> (domid = 1 both times)
>
> How so?
>
>>>  	}
>>>  
>>>  	hwsize = msi_domain_get_hwsize(dev, domid);
>>> -	if (index >= hwsize) {
>>> -		ret = -ERANGE;
>>> -		goto fail;
>>> -	}
>>>  
>>> -	desc->msi_index = index;
>>> -	index += baseidx;
>>> -	ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
>>> -	if (ret)
>>> -		goto fail;
>>> -	return 0;
>>> +	if (index == MSI_ANY_INDEX) {
>>> +		struct xa_limit limit;
>>> +		unsigned int index;
>>> +
>>> +		limit.min = baseidx;
>>> +		limit.max = baseidx + hwsize - 1;
>>>  
>>> +		/* Let the xarray allocate a free index within the limits */
>>> +		ret = xa_alloc(&md->__store, &index, desc, limit, GFP_KERNEL);
>>> +		if (ret)
>>> +			goto fail;
>>> +
>>
>> This path (index == MSI_ANY_INDEX) is followed when msi_insert_desc()
>> is called the first time and the xa_alloc() succeeds at index 65536.
>>
>>> +		desc->msi_index = index;
>>
>> This is problematic with desc->msi_index being a u16, assigning
>> 65536 to it becomes 0.
>
> You are partially right. I need to fix that and make it explicit as it's
> a "works by chance or maybe not" construct right now.
>
> But desc->msi_index is correct to be truncated because it's the index
> within the domain space which is zero based.

It should obviously do:

   desc->msi_index = index - baseidx;

>>> +		return 0;
>>> +	} else {
>>> +		if (index >= hwsize) {
>>> +			ret = -ERANGE;
>>> +			goto fail;
>>> +		}
>>> +
>>> +		desc->msi_index = index;
>>> +		index += baseidx;
>>> +		ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
>>> +		if (ret)
>>> +			goto fail;
>>
>> This "else" path is followed when msi_insert_desc() is called the second
>> time with "index = 0". The xa_insert() above fails at index 65536
>> (baseidx = 65536) with -EBUSY, trickling up as the return code to
>> pci_ims_alloc_irq().
>
> Why is it called with index=0 the second time?
>>> +	desc = msi_alloc_desc(dev, 1, affdesc);
>>> +	if (!desc) {
>>> +		map.index = -ENOMEM;
>>> +		goto unlock;
>>> +	}
>>> +
>>> +	if (cookie)
>>> +		desc->data.cookie = *cookie;
>>> +
>>> +	ret = msi_insert_desc(dev, desc, domid, index);
>>> +	if (ret) {
>>> +		map.index = ret;
>>> +		goto unlock;
>>> +	}
>>
>> Above is the first call to msi_insert_desc(/* index = MSI_ANY_INDEX */)
>>
>>> +
>>> +	map.index = desc->msi_index;
>>
>> msi_insert_desc() did attempt to set desc->msi_index to 65536 but map.index ends
>> up being 0.
>
> which is kinda correct.
>
>>> +	ret = msi_domain_alloc_irqs_range_locked(dev, domid, map.index, map.index);
>>
>> Here is where the second call to msi_insert_desc() originates:
>>
>> msi_domain_alloc_irqs_range_locked() -> msi_domain_alloc_locked() -> \
>> __msi_domain_alloc_locked() -> msi_domain_alloc_simple_msi_descs() -> \
>> msi_domain_add_simple_msi_descs() -> msi_insert_desc()
>
> but yes, that's bogus because it tries to allocate what is allocated already.
>
> Too tired to decode this circular dependency right now. Will stare at it
> with brain awake in the morning. Duh!

Duh. I'm a moron.

Of course I "tested" this by flipping default and secondary domain
around and doing dynamic allocations from PCI/MSI-X but that won't catch
the bug because PCI/MSI-X does not have the ALLOC_SIMPLE_DESCS flag set.

Let me fix that.

Thanks,

        tglx
