Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9FE4658CA
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 23:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbhLAWG3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 17:06:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43618 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353290AbhLAWG0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 17:06:26 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638396182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ADwxWazAFdxjnnTjDcEZ69QP7SpknGKLWrCglJZzXdA=;
        b=QK/m6+RYPwia5iAr3NXO/05AHAjPLCSzrsxc6Ktr32hn13hDblo2sRMPP1PxKwJYYxRUEl
        sCNTDTPJRbK+jFICII8cx1uRTV/LMZ41abXLgbjs9TcsKI5FxsxVx1g/jpj7oHJPUaPPBF
        L6pNnbq40ttJDHKvrHDJpDauCRL/QbkiskY1zOCZkmhepI0pw2w2vSmb69S62+fEIn+d3A
        gU7m2pAB1ZbuJwl4w3P95hvccRHQMFAAu+0dr+GLphihi0/Yn+5k7cJ8MJe71JDyRXAdOu
        kWxuAU5+Sx+weFWOI7iDHXe/OiRCQE8B1bgyu3QqG7R3UXBDoTV71yHX6UrnVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638396182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ADwxWazAFdxjnnTjDcEZ69QP7SpknGKLWrCglJZzXdA=;
        b=CIcddPGNmHG0Q/Y/LWnRlffIbbnQdDGWmDfpzGwfLJhOJGBvuWpowJSI4GBTe7cwqYpBd1
        N/K0G4B0vGPJ7oBw==
To:     Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        linux-ntb@googlegroups.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <45302c9d-f7a0-5a47-d0be-127d0dea45fb@intel.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com> <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com> <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com> <878rx480fk.ffs@tglx>
 <45302c9d-f7a0-5a47-d0be-127d0dea45fb@intel.com>
Date:   Wed, 01 Dec 2021 23:03:02 +0100
Message-ID: <875ys87zl5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 01 2021 at 14:49, Dave Jiang wrote:
> On 12/1/2021 2:44 PM, Thomas Gleixner wrote:
>> How that is backed on the host does not really matter. You can expose
>> MSI-X to the guest with a INTx backing as well.
>>
>> I'm still failing to see the connection between the 9 MSIX vectors and
>> the 2048 IMS vectors which I assume that this is the limitation of the
>> physical device, right?
>
> I think I was confused with what you were asking and was thinking you 
> are saying why can't we just have MSIX on guest backed by the MSIX on 
> the physical device and thought there would not be enough vectors to 
> service the many guests. I think I understand what your position is now 
> with the clarification above.

This still depends on how this overall discussion about representation
of all of this stuff is resolved.

>> What needs a subdevice to expose?

Can you answer that too please?

Thanks,

        tglx
