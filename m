Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB64E460136
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 20:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhK0Tg4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 14:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhK0Tey (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 14:34:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103A9C06173E;
        Sat, 27 Nov 2021 11:31:39 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638041497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dBon8SfZp1CEsl8BVx51RpGEII8dcWVBs/L2NZ3qLTE=;
        b=12PZFwTo7dzQMjfEIObW/kTHWjbjA52CzuNfBOGK2uRNbJnVye3Dkjthb5DBQpAbPv7TIC
        TsqmXC/RKQHhFH0JoAJSD/jtQ2oejhyxTYvz0qqHdVGIr1KZVfNESIfcaSejeaTNiTor4r
        W9Y2iyfT6OYXEM8U9FgPnx3RHC8aCxTytiP5bDoYcv6afKfuKbi5UnpFvDIWIlhmL4+t3u
        Xq6qEMUKoTtCgTIRJa8JPhxoqGWKYTp2XzfU1jQwu2xSEbgcbbxwA+/k4wnLBtEzx8V++W
        F+hPOYnOETgCXAUIjN7tQ/1H4iL0wcicT8Zz0vfIwfMcYvTZwglzsfLoi8WH1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638041497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dBon8SfZp1CEsl8BVx51RpGEII8dcWVBs/L2NZ3qLTE=;
        b=JdAw3GTJGlue61YNMCREzj0zPv+Nw+GkUxnJdMLcseVulh7WwPNi/XNiSzdLuLfkV0fjnG
        Y2wbE7D4FTsLxlDw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch 31/32] genirq/msi: Simplify sysfs handling
In-Reply-To: <YaIlX8bef2jPLkUE@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232736.135247787@linutronix.de> <YaIlX8bef2jPLkUE@kroah.com>
Date:   Sat, 27 Nov 2021 20:31:37 +0100
Message-ID: <87lf19fl9i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 27 2021 at 13:32, Greg Kroah-Hartman wrote:
> On Sat, Nov 27, 2021 at 02:23:15AM +0100, Thomas Gleixner wrote:
>> The sysfs handling for MSI is a convoluted maze and it is in the way of
>> supporting dynamic expansion of the MSI-X vectors because it only supports
>> a one off bulk population/free of the sysfs entries.
>> 
>> Change it to do:
>> 
>>    1) Creating an empty sysfs attribute group when msi_device_data is
>>       allocated
>> 
>>    2) Populate the entries when the MSI descriptor is initialized
>
> How much later does this happen?  Can it happen while the device has a
> driver bound to it?

That's not later than before. It's when the driver initializes the
MSI[X] interrupts, which usually happens in the probe() function.

The difference is that the group, (i.e.) directory is created slightly
earlier.

>> +
>> +static inline int msi_sysfs_create_group(struct device *dev)
>> +{
>> +	return devm_device_add_group(dev, &msi_irqs_group);
>
> Much nicer, but you changed the lifetime rules of when these attributes
> will be removed, is that ok?

The msi entries are removed at the same place as they are removed in the
current mainline code, i.e. when the device driver shuts the device
down and disables MSI[X], which happens usually during remove()

What's different now is that the empty group stays around a bit
longer. I don't see how that matters.

> I still worry that these attributes show up "after" the device is
> registered with the driver core, but hey, it's no worse than it
> currently is, so that's not caused by this patch series...

Happens that register before or after driver->probe()?

>> -		}
>> +	desc->sysfs_attrs = NULL;
>> +	for (i = 0; i < desc->nvec_used; i++) {
>> +		if (attrs[i].show)
>> +			sysfs_remove_file_from_group(&dev->kobj, &attrs[i].attr, msi_irqs_group.name);
>> +		kfree(attrs[i].attr.name);
>
> That's a cute hack, but should be documented somewhere in the code (that
> if there is no show function, that means no attribute was registered
> here).
>
> If you add a comment for this (either here or when you register the
> attribute), feel free to add:

Will do.

Thanks,

        tglx
