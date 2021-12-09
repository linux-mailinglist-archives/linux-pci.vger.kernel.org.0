Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E8246F4A5
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 21:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhLIUKz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 15:10:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41512 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhLIUKy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 15:10:54 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639080439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t8vWSJsQ3BPUuA0dl4ZxOCitpzQBCnAQcAG9d/AyszY=;
        b=sHhovCXYznLQvrGNlUrM3WEopSb51XowtYU6ZRg8/yzFTDuzz216Ewv7DolyvFsUKx/1ke
        B5ybiEluLUSMnv6nlypjKB3an/Ik19E8hELGvpGfaVsmyqlgRZ28jDTwg9X2YLdv0WXzyT
        qC8D+iAPLh/KVpR+ate3DDYaz+32FbJXuKAi1Tm3x4JYB4PJdhnn64H+G0JP8NQWxBBKW9
        mGg+435IBYg7crZEFeHp62q1iA+vdQWU3kcVjCOYWzqdyfdsUINMLHQRoPn27ryaaZ5Q87
        tnfir7pXGA6MtmMp/oUILSVBjMo1EPXed/tAn3VW13a5C37FiNh4kwD3IB7i4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639080439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t8vWSJsQ3BPUuA0dl4ZxOCitpzQBCnAQcAG9d/AyszY=;
        b=JfqQs3MQSjnfAkz1VIzKG+EbEjFfElIM5AarYArIkvLdqdh5RCIVK40SvG1K0tmOwfjy8O
        tm5NFzpfUpuOaxAQ==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch V2 02/31] genirq/msi: Add mutex for MSI list protection
In-Reply-To: <20211209004702.GL6385@nvidia.com>
References: <20211206210600.123171746@linutronix.de>
 <20211206210747.708877269@linutronix.de>
 <20211209004702.GL6385@nvidia.com>
Date:   Thu, 09 Dec 2021 21:07:18 +0100
Message-ID: <87bl1pzgnd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 08 2021 at 20:47, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 11:51:05PM +0100, Thomas Gleixner wrote:
>> +++ b/kernel/irq/msi.c
>> @@ -127,12 +127,37 @@ int msi_setup_device_data(struct device
>>  		return -ENOMEM;
>>  
>>  	INIT_LIST_HEAD(&md->list);
>> +	mutex_init(&md->mutex);
>>  	dev->msi.data = md;
>>  	devres_add(dev, md);
>>  	return 0;
>>  }
>>  
>>  /**
>> + * msi_lock_descs - Lock the MSI descriptor storage of a device
>> + * @dev:	Device to operate on
>> + */
>> +void msi_lock_descs(struct device *dev)
>> +{
>> +	if (WARN_ON_ONCE(!dev->msi.data))
>> +		return;
>
> Is this useful? Other places that call msi_lock_descs will continue on and deref
> null dev->msi anyhow - is the dump from the WARN_ON that much better
> than the oops from the null deref here:
>
>> +	mutex_lock(&dev->msi.data->mutex);

I put it there for paranoia reasons and forgot to revist it later. In
that case yes, it's of questionable value.

Thanks,

        tglx
