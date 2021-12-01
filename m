Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01AE465A12
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 00:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343671AbhLBAAf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 19:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbhLBAAf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 19:00:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB201C061574;
        Wed,  1 Dec 2021 15:57:13 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638403030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HeJ90O/nT9kyUM6cIwdOXyo+g8KJsD3Gi26lD2bQV58=;
        b=Ex/oTvgGSoTBWF6LWMPCNMEGr46k2oN2F5UHorWtjjvkWSu7tsz6+w4i8IXmcqyJPAfmxK
        7kWjv35aCk2BqYGE0UWyrmuYmLHrFfy2mvM7JuVYBqTRPbBVnrM6bsu8mJDOKrKhNuhPB7
        7t300i+5cxb2ynpJ5K/jbvMJSxKCqgqRa5bPQokztvP+YFXFcYakoMnBpm68dU7XDDnQFf
        KWvotsFEbiycrbQ5kxoObIrOClr+QRfLlqLOTJ0KjSxEi7b8s6Fog4Z9ZgIJfOhkXhbEKa
        o8p7WT2KrTGcz1442sRcJOM+e957Zv2YaLRU40F7tirG7e0lB5j+nBkuEMd8dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638403030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HeJ90O/nT9kyUM6cIwdOXyo+g8KJsD3Gi26lD2bQV58=;
        b=WYMlfyx42u3s1VqqWnoMyiwtxeJvKCZe3SZ7PJ3oPJJ9lUEj9H1OOPXNXVtxOKdZQd+58m
        4sDuhQwyKK6iy0Dg==
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
In-Reply-To: <0eab4c0e-c672-1138-2d95-3c9bee9ecdb1@intel.com>
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
 <45302c9d-f7a0-5a47-d0be-127d0dea45fb@intel.com> <875ys87zl5.ffs@tglx>
 <0eab4c0e-c672-1138-2d95-3c9bee9ecdb1@intel.com>
Date:   Thu, 02 Dec 2021 00:57:10 +0100
Message-ID: <87tufr7uax.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

dave,

On Wed, Dec 01 2021 at 15:53, Dave Jiang wrote:
> On 12/1/2021 3:03 PM, Thomas Gleixner wrote:
>> This still depends on how this overall discussion about representation
>> of all of this stuff is resolved.
>>
>>>> What needs a subdevice to expose?
>> Can you answer that too please?
>
> Sorry. So initial version of the IDXD sub-device is represented with a 
> single queue. It needs a command irq (emulated) and a completion irq 
> that is backed by a device vector (currently IMS).

thanks for clarification! Let me think about it some more.

       tglx
