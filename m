Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0CE461117
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 10:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243818AbhK2Jbb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 04:31:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243995AbhK2J3b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 04:29:31 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638177972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=vsQfYjhiBM4r7l7V0nZmUO3oNlQtIhI3OMTj1eyI/yY=;
        b=nJiWamimirlRvKEdNsX2fBgwvYCCn9sR0fworYU1e5X/OaMTPxTSgzyGd0flO3B2jcqmXN
        UYv1JQYV9GCd0ejevd1Ub9OnENXKUn/OA2QFn8xXj/sAX0BcCQy1sALSFg8bfV1CfD01Yr
        vXCJHIl5OfIkIx0xbSIGcyIiO7GiZvvsQlTiHUfke6tXUWLYBm7kKgYKx6Paroj+LA8C2w
        luN+p+aDstwwYHSWwzluIAk/1XqYaCSkPf6h3q1iPkAscoWQKhIE8UM85kdNoLHvSAcykl
        YyigM7O67ykaWw4Gc7g4bF0rQgLpFAj5EdNGD4jeHaTIFgkaGYj15uJwdOCwmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638177972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=vsQfYjhiBM4r7l7V0nZmUO3oNlQtIhI3OMTj1eyI/yY=;
        b=Hln4q+IFuycSbrNa+go3njlxYP/OFv40X+QILw3q5t55RcCnD12KZEM9fQtyQaIOVJ/gnK
        DduA4aH3uyI7GKDA==
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
In-Reply-To: <877dcsf5l5.ffs@tglx>
Date:   Mon, 29 Nov 2021 10:26:11 +0100
Message-ID: <87o863e2j0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jason,

On Sun, Nov 28 2021 at 20:22, Thomas Gleixner wrote:
> On Sat, Nov 27 2021 at 21:00, Jason Gunthorpe wrote:
>> On Sat, Nov 27, 2021 at 02:22:33AM +0100, Thomas Gleixner wrote:
>> I understand why that isn't desirable at this patch where the storage
>> would have to be a list_head pointer, but still, seems like an odd
>> place to end up at the end of the series.
>>
>> eg add index here unused and then the last patch uses it instead of
>> __iter_idx.
>
> TBH, didn't think about doing just that. OTH, given the experience of
> looking at the creative mess people create, this was probably also a
> vain attempt to make it harder in the future.
>
>> Also, I don't understand why filter was stored in the dev and not
>> passed into msi_next_desc() in the macro here?
>
> No real reason. I probably just stored it along with the rest. Lemme try
> that index approach.

After looking at all the call sites again, there is no real usage for
this local index variable.

If anything needs the index of a descriptor then it's available in the
descriptor itself. That won't change because the low level message write
code needs the index too and the only accessible storage there is
msi_desc.

So the "gain" would be to have a pointless 'unsigned long index;'
variable at all usage sites.

What for? The usage sites should not have to care about the storage
details of a facility they are using.

So it might look odd in the first place, but at the end it's conveniant
and does not put any restrictions on changing the underlying mechanics.

Thanks,

        tglx

