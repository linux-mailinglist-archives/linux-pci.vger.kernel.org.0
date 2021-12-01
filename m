Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95A24655B2
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 19:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352575AbhLASob (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 13:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbhLASoa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 13:44:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF544C061574;
        Wed,  1 Dec 2021 10:41:07 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638384066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bhEQ++VjG+PbbDX/TL/y2PNwVGcmNGkMLPfFWSCRFRg=;
        b=agHzhYjACT4x3oSSvJ5fOd6AYVcAl+deHne0yglVQuC/xGnXGYrjYvqtxd/BFYwrP2st5s
        dmum8JsI5po8i518PwfB97/CKWjAcaOMSEJBqJ+kSyo7TwewXq8/1YBRC2q/PaGUT/+hBy
        0W0sf3FPBvlmfDwCW2z88FkHiC7u8nojGT9JCekmtbVS14LIIbazKoX2RR1rJGTsm77J6V
        jzqVWJaXQNFdK/UZTzjbOUiE+WcsDd+mq6GAsIusqJw6BQvcrzFp769DeZ4R+IDsOcDkvc
        b9gn5fETZ1uhLBdFrJjOEFgKdHYcJYu7F+XplHyi4WzDqi1lZCPBUu2OQ+Frtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638384066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bhEQ++VjG+PbbDX/TL/y2PNwVGcmNGkMLPfFWSCRFRg=;
        b=TUbiaXymVThVmwvRi5kHv4ue+jn8XuRm2m9I9z04Kji8zwA82A6uSywSrcuib7TBuNMJjb
        fO7i3twMyhNJC4DA==
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
In-Reply-To: <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
Date:   Wed, 01 Dec 2021 19:41:05 +0100
Message-ID: <87pmqg88xq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dave,

please trim your replies.

On Wed, Dec 01 2021 at 09:28, Dave Jiang wrote:

> On 12/1/2021 3:16 AM, Thomas Gleixner wrote:
>> Jason,
>>
>> CC+ IOMMU folks
>>
>> On Tue, Nov 30 2021 at 20:17, Jason Gunthorpe wrote:
>>> On Tue, Nov 30, 2021 at 10:23:16PM +0100, Thomas Gleixner wrote:
>>
>> Though I fear there is also a use case for MSI-X and IMS tied to the
>> same device. That network card you are talking about might end up using
>> MSI-X for a control block and then IMS for the actual network queues
>> when it is used as physical function device as a whole, but that's
>> conceptually a different case.
>
> Hi Thomas. This is actually the IDXD usage for a mediated device passed 
> to a guest kernel when we plumb the pass through of IMS to the guest 
> rather than doing previous implementation of having a MSIX vector on 
> guest backed by IMS.

Which makes a lot of sense.

> The control block for the mediated device is emulated and therefore an
> emulated MSIX vector will be surfaced as vector 0. However the queues
> will backed by IMS vectors. So we end up needing MSIX and IMS coexist
> running on the guest kernel for the same device.

Why? What's wrong with using straight MSI-X for all of them?

Thanks,

        tglx
