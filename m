Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6114460958
	for <lists+linux-pci@lfdr.de>; Sun, 28 Nov 2021 20:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353363AbhK1T1u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Nov 2021 14:27:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49012 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhK1TZs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Nov 2021 14:25:48 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638127351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E8ZA6r18LEZgOr5P11pd+i/cnzZnNK1YQYI4tPYAbOM=;
        b=1YKU3JyEyoZRh+5u8fo5O/vBh7sicXRx7Fj4DTxbEdtFf6aqbsmBhL0Q5WtmRUHghVxiam
        rKbyEBozj1+buwXrREWtFxjJ8Y4Y6rOWOE6EWLB1+TTIOhZ/IVmPttmH/o0DpsZ5ZdLRuV
        lJR/qDH3ubxNoq2bodlwpuaJbIiyryUmwleic4odgu2IkmitmIopuqjKg8Qj2JRIhnp9fc
        2HrXJBx/9JEYig1cqAol7nCxoQeQjwUfd0EzLFje9FUkj/RxYWqjIT13gg64dPTjA0lhP6
        biYCAullKh2samIVc2cvdQw3N4Vh1BgOEfrqSQyb/PvJhY1ZVpJpu9eX3ikjZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638127351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E8ZA6r18LEZgOr5P11pd+i/cnzZnNK1YQYI4tPYAbOM=;
        b=FiJeG6EV1QNjM8G/zn+0eV9ZRIvTcZ/40YSeBolEBORH/p5Ai5/fXABtEaB7X4cOTebr+5
        NmiMXS+QE5FVTxBg==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch 04/32] genirq/msi: Provide a set of advanced MSI
 accessors and iterators
In-Reply-To: <20211128010037.GV4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.531194050@linutronix.de>
 <20211128010037.GV4670@nvidia.com>
Date:   Sun, 28 Nov 2021 20:22:30 +0100
Message-ID: <877dcsf5l5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 27 2021 at 21:00, Jason Gunthorpe wrote:
> On Sat, Nov 27, 2021 at 02:22:33AM +0100, Thomas Gleixner wrote:
>> + * Notes:
>> + *  - The loop must be protected with a msi_lock_descs()/msi_unlock_descs()
>> + *    pair.
>> + *  - It is safe to remove a retrieved MSI descriptor in the loop.
>> + */
>> +#define msi_for_each_desc_from(desc, dev, filter, base_index)			\
>> +	for ((desc) = __msi_first_desc((dev), (filter), (base_index)); (desc);	\
>> +	     (desc) = msi_next_desc((dev)))
>
> Given this ends up as an xarray it feels really weird that there is a
> hidden shared __next/__iter_idx instead of having the caller provide
> the index storage as is normal for xa operations.
>
> I understand why that isn't desirable at this patch where the storage
> would have to be a list_head pointer, but still, seems like an odd
> place to end up at the end of the series.
>
> eg add index here unused and then the last patch uses it instead of
> __iter_idx.

TBH, didn't think about doing just that. OTH, given the experience of
looking at the creative mess people create, this was probably also a
vain attempt to make it harder in the future.

> Also, I don't understand why filter was stored in the dev and not
> passed into msi_next_desc() in the macro here?

No real reason. I probably just stored it along with the rest. Lemme try
that index approach.

Thanks,

        tglx
