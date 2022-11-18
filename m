Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0D962EAA1
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 01:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiKRA6g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 19:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240477AbiKRA6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 19:58:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6622ACE;
        Thu, 17 Nov 2022 16:58:31 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668733110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qYV4fewAjaQ2sDD33+RnlZiIVx3zMWpVOZg2vIO0No=;
        b=qNT49/1LjXrvbcCdPmpd83Jwss/SyMjl/tDxOHcLoSAgzt6KEMTUIGGmfwxnZF/leHqgsH
        62Hj8AwqZs5EL7LXLyq/ho1l4LnprkkaB/D6u/f0aIq4jc9gItLlv80Fq0Y194k65CdXyo
        jX+JnZaHnMO2xxjdtYaTXc2MmE0R2YTqTHYdnnSIpKAcol9/3prtHdBcbVdY1c/2gvhQ97
        zQazKMu3yHy8QsP9ncPG7cCglSNSRwqX3FEarzGV71ZsBdfaUMJD2m1AGjNHpsUurSE7eW
        UDjnLExPwDdjfKT28s7Ek9fNu3YonHUnjHyCdl2XlCmAHm2uxyYszFRgQs+D8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668733110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qYV4fewAjaQ2sDD33+RnlZiIVx3zMWpVOZg2vIO0No=;
        b=pZdiQp7hc/BISUuXk50Qap4WrF6vAURiWNwqjAQsLB5q/2GypfsImTEthPZdTCjMprUVWa
        RCHWQOarjwVRGWDQ==
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
In-Reply-To: <0cbf645b-b23a-6c85-4389-bb039a677a52@intel.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.463650635@linutronix.de>
 <0cbf645b-b23a-6c85-4389-bb039a677a52@intel.com>
Date:   Fri, 18 Nov 2022 01:58:29 +0100
Message-ID: <87k03tkrii.ffs@tglx>
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

On Thu, Nov 17 2022 at 15:33, Reinette Chatre wrote:
> I am trying all three parts of this work out with some experimental
> code within the IDXD driver that attempts to use IMS on the host.
>
> In the test, pci_ims_alloc_irq() always encounters -EBUSY and it
> seems that there is an attempt to insert the struct msi_desc into
> the xarray twice, the second attempt encountering the -EBUSY.
>
> While trying to understand what is going on I found myself looking
> at this code area and I'll annotate this patch with what I learned.

Ok.

> When calling pci_ims_alloc_irq(), msi_insert_desc() ends up being
> called twice, first with index = MSI_ANY_INDEX, second with index = 0.
> (domid = 1 both times)

How so?

>>  	}
>>  
>>  	hwsize = msi_domain_get_hwsize(dev, domid);
>> -	if (index >= hwsize) {
>> -		ret = -ERANGE;
>> -		goto fail;
>> -	}
>>  
>> -	desc->msi_index = index;
>> -	index += baseidx;
>> -	ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
>> -	if (ret)
>> -		goto fail;
>> -	return 0;
>> +	if (index == MSI_ANY_INDEX) {
>> +		struct xa_limit limit;
>> +		unsigned int index;
>> +
>> +		limit.min = baseidx;
>> +		limit.max = baseidx + hwsize - 1;
>>  
>> +		/* Let the xarray allocate a free index within the limits */
>> +		ret = xa_alloc(&md->__store, &index, desc, limit, GFP_KERNEL);
>> +		if (ret)
>> +			goto fail;
>> +
>
> This path (index == MSI_ANY_INDEX) is followed when msi_insert_desc()
> is called the first time and the xa_alloc() succeeds at index 65536.
>
>> +		desc->msi_index = index;
>
> This is problematic with desc->msi_index being a u16, assigning
> 65536 to it becomes 0.

You are partially right. I need to fix that and make it explicit as it's
a "works by chance or maybe not" construct right now.

But desc->msi_index is correct to be truncated because it's the index
within the domain space which is zero based.

>> +		return 0;
>> +	} else {
>> +		if (index >= hwsize) {
>> +			ret = -ERANGE;
>> +			goto fail;
>> +		}
>> +
>> +		desc->msi_index = index;
>> +		index += baseidx;
>> +		ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
>> +		if (ret)
>> +			goto fail;
>
> This "else" path is followed when msi_insert_desc() is called the second
> time with "index = 0". The xa_insert() above fails at index 65536
> (baseidx = 65536) with -EBUSY, trickling up as the return code to
> pci_ims_alloc_irq().

Why is it called with index=0 the second time?
>> +	desc = msi_alloc_desc(dev, 1, affdesc);
>> +	if (!desc) {
>> +		map.index = -ENOMEM;
>> +		goto unlock;
>> +	}
>> +
>> +	if (cookie)
>> +		desc->data.cookie = *cookie;
>> +
>> +	ret = msi_insert_desc(dev, desc, domid, index);
>> +	if (ret) {
>> +		map.index = ret;
>> +		goto unlock;
>> +	}
>
> Above is the first call to msi_insert_desc(/* index = MSI_ANY_INDEX */)
>
>> +
>> +	map.index = desc->msi_index;
>
> msi_insert_desc() did attempt to set desc->msi_index to 65536 but map.index ends
> up being 0.

which is kinda correct.

>> +	ret = msi_domain_alloc_irqs_range_locked(dev, domid, map.index, map.index);
>
> Here is where the second call to msi_insert_desc() originates:
>
> msi_domain_alloc_irqs_range_locked() -> msi_domain_alloc_locked() -> \
> __msi_domain_alloc_locked() -> msi_domain_alloc_simple_msi_descs() -> \
> msi_domain_add_simple_msi_descs() -> msi_insert_desc()

but yes, that's bogus because it tries to allocate what is allocated already.

Too tired to decode this circular dependency right now. Will stare at it
with brain awake in the morning. Duh!

Thanks,

        tglx
