Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFBB46E4CE
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 10:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhLIJGh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 04:06:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37772 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbhLIJGf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 04:06:35 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639040580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E26dnRV33umx8ChJ6qCSA81TgS29bOEnlTFznvEPm70=;
        b=UBAjhrFqIfvy92gOjMu/92luLZEtQxcB8EnSkIXWAFQBXMfp6FG+CIy6k5fzSZFuMERG/8
        xFfVtetcOEbsB3znL7bUlgxjs4cz7rEv4z2maPrBY4od7F+YFZUnlxgZiVyKf7nPqzKqZo
        P6WDalcMWkcD1E4tHNsUxBCWBhcJQXXL67VA9WD/pk40bDo6014XJfmtDBLxn8Zj3ILXcm
        Fm2H1blgC+OVRbQuDp50QNRDGU4OLKHx5WuixE2ZlDDNvNG1GPQlUnkRK7WMjm0z4QOn5K
        7+pEpTjkMsQM6XtjDYmPSwQbt/B5mBUSba2zDYbSeit7s9Szp5MWWI+4e9OCpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639040580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E26dnRV33umx8ChJ6qCSA81TgS29bOEnlTFznvEPm70=;
        b=Jyj5PjJVVV9UfiYBlLmlLN+yWi9guY+BWs5hyOKN3TpwCmfxKHuQbAic8qnXl2XG/UWEI9
        pik8o3FpwATUUiAg==
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <BN9PR11MB52766CC46D3D4865308F61D98C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com> <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
 <BN9PR11MB52766CC46D3D4865308F61D98C709@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Thu, 09 Dec 2021 10:03:00 +0100
Message-ID: <87pmq6ywu3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kevin,

On Thu, Dec 09 2021 at 06:26, Kevin Tian wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> I don't know of any use case for more than one interrupt on a queue,
>> and if it did come up I'd probably approach it by making the queue
>> handle above also specify the 'queue relative HW index'
>
> We have such use case with IDXD.
>
> Basically the IDXD queue allows software to put an interrupt handle
> (the index of MSI-X or IMS entry) in the submitted descriptor. Upon
> completion of the descriptor the hardware finds the specified entry 
> and then generate interrupt to notify software.
>
> Conceptually descriptors submitted to a same queue can use different
> handles, implying one queue can be associated to multiple interrupts.

I think you are looking at that from the internal implementation details
of IDXD. But you can just model it in an IDXD implementation agnostic
way:

     ENQCMD(PASID, IMS-ENTRY,.....)

implies an on demand allocation of a virtual queue, which is deallocated
when the command completes. The PASID and IMS-ENTRY act as the 'queue'
identifier.

The implementation detail of IDXD that it executes these computations on
an internal shared workqueue does not change that.

Such a workqueue can only execute one enqueued command at a time, which
means that during the execution of a particular command that IDXD
internal workqueue represents the 'virtual queue' which is identified by
the unique PASID/IMS-ENTRY pair.

No?

Thanks,

        tglx
