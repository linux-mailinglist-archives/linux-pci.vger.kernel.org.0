Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBA5637C67
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 16:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiKXPCw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 10:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiKXPCt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 10:02:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7633FBB0;
        Thu, 24 Nov 2022 07:02:45 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669302163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=As2quWrcxzQIkDEARcYEWHVDkutncLkwzqhhKmGdvMw=;
        b=34Yd40+UTZBp/sha+xv+rNinYpSfcwi2Jcocjjr9PpyAEm4vrBbGmg8snq/BD4uPPzcuIA
        7SxEuVhcrY2olTmiYO+sS79nXQDdQ+qDiTL1XVwfClY3bAaNoxuQ9eVrP675PT1lBBZXGo
        CP4CKu5omPHllJ0AUFYG/+0cG644GKBu+uKAmFg1YNR4fule5XxYIxjYVpX9I0HMOIQpim
        DnmwfL0pRtvPmuG6+4Psiu3o7Fma8qVMSb8QM1k7RcTqH3ypeG4oxmebPQI78c0ab9NhyR
        ZAkOc+ts2nGXfZo51d1OVLCnqR3gCrjduYbQ5r1/mrzRFc7pAADw1TOgZjXDQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669302163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=As2quWrcxzQIkDEARcYEWHVDkutncLkwzqhhKmGdvMw=;
        b=w2QOB3Yjre/huurRuvL5yVUpNVJHxEd8h7mXvOwjewYm1clQcwxVDxFwyqZo4iPU84fRoX
        c+oVdXuCP3c1bnBw==
To:     Marc Zyngier <maz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V2 08/21] genirq/msi: Add pointers for per device irq
 domains
In-Reply-To: <86sfi8mmee.wl-maz@kernel.org>
References: <20221121083210.309161925@linutronix.de>
 <20221121083325.950255253@linutronix.de> <86sfi8mmee.wl-maz@kernel.org>
Date:   Thu, 24 Nov 2022 16:02:43 +0100
Message-ID: <8735a8cs4s.ffs@tglx>
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

On Thu, Nov 24 2022 at 14:56, Marc Zyngier wrote:
> On Mon, 21 Nov 2022 14:36:28 +0000,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>>  static inline int msi_sysfs_create_group(struct device *dev);
>>  
>> +static inline void msi_setup_default_irqdomain(struct device *dev, struct msi_device_data *md)
>
> Do we really need this to be inline? I'm sure the compiler can figure
> it out.

No. I'll fix that up.

>> +{
>> +	if (!dev->msi.domain)
>> +		return;
>> +	/*
>> +	 * If @dev::msi::domain is a global MSI domain, copy the pointer
>> +	 * into the domain array to avoid conditionals all over the place.
>> +	 */
>> +	if (!irq_domain_is_msi_parent(dev->msi.domain))
>> +		md->__irqdomains[MSI_DEFAULT_DOMAIN] = dev->msi.domain;
>> +}
>> +
>>  /**
>>   * msi_alloc_desc - Allocate an initialized msi_desc
>>   * @dev:	Pointer to the device for which this is allocated
>> @@ -213,6 +225,8 @@ int msi_setup_device_data(struct device
>>  		return ret;
>>  	}
>>  
>> +	msi_setup_default_irqdomain(dev, md);
>> +
>
> nit: if you move the setup below the msi.data assignment, you could
> only pass dev as a parameter. Or pass both and move the assignment in
> the function?

In which order we do that it all looks wrong :)

>>  	xa_init(&md->__store);
>>  	mutex_init(&md->mutex);
>>  	dev->msi.data = md;
>> 
>> 
>
> Irrespective of the above,
>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
>
> 	M.
