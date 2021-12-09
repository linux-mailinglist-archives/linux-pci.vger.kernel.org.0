Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4176C46F684
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 23:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbhLIWNa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 17:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhLIWN3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 17:13:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA64EC061746;
        Thu,  9 Dec 2021 14:09:55 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639087793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B+lqUDLWtnvLeY/KahuIZ2Xvfr4Bwoi1ABSMRvnITCk=;
        b=WW18ExaRnpYiWwbxv1Oo+xyj2rfXtsbPW+X7DVsTiaqB6wgXzATusvwhCl2GaS0rdR+WnS
        tJqrFACnb/P7aMyauV0Fi+Y2Ij1B/GX/eVn6EGdEM6K0YI6JQPA4aM+WtDI3/kaLnHJ2QX
        nipiipByknmKWpGePlYzrzCt1B7GA4MVVwpoZbz8+GW4x4UCOWa7s+e/WbNp3weWyzEOkB
        ChXF2+m0tC/eW9+h/iL1fdpba0kWZqBeWFWjFofAKXGAntdvIInQwwsjY75CFMBPXGsfyC
        5gDlVAIJET2FXFHnFwbuWUKB2ii1p17poTV9Hn4kr4bxvGjeaFlv5zW+2fiLpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639087793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B+lqUDLWtnvLeY/KahuIZ2Xvfr4Bwoi1ABSMRvnITCk=;
        b=qVn3U9HWxK+h6v6N25iCCmQPsywBb9D/DewlfObPZ14vxsbLUpThsREQ0c1etj4ttkaC80
        m8v8EwcoDdMel9DA==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211209205835.GZ6385@nvidia.com>
References: <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
 <87pmqg88xq.ffs@tglx> <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx> <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
Date:   Thu, 09 Dec 2021 23:09:52 +0100
Message-ID: <8735n1zaz3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 09 2021 at 16:58, Jason Gunthorpe wrote:
> On Thu, Dec 09, 2021 at 09:32:42PM +0100, Thomas Gleixner wrote:
>> That was my thought to avoid having different mechanisms.
>> 
>> The address/data pair is computed in two places:
>> 
>>   1) Activation of an interrupt
>>   2) Affinity setting on an interrupt
>> 
>> Both configure the IRTE when interrupt remapping is in place.
>> 
>> In both cases a vector is allocated in the vector domain and based on
>> the resulting target APIC / vector number pair the IRTE is
>> (re)configured.
>> 
>> So putting the hypercall into the vIRTE update is the obvious
>> place. Both activation and affinity setting can fail and propagate an
>> error code down to the originating caller.
>> 
>> Hmm?
>
> Okay, I think I get it. Would be nice to have someone from intel
> familiar with the vIOMMU protocols and qemu code remark what the
> hypervisor side can look like.
>
> There is a bit more work here, we'd have to change VFIO to somehow
> entirely disconnect the kernel IRQ logic from the MSI table and
> directly pass control of it to the guest after the hypervisor IOMMU IR
> secures it. ie directly mmap the msi-x table into the guest

That makes everything consistent and a clear cut on all levels, right?

Thanks,

        tglx

