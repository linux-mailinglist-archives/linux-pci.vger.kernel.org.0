Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C957247099B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 20:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245716AbhLJTD4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 14:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbhLJTDz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 14:03:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962CFC061746;
        Fri, 10 Dec 2021 11:00:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639162819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0BeH0Kn3WigadkhEUoB01iDiT99PSY041SAX6KkeNTw=;
        b=4xfvC4nabHIrP128E7J3+ba2aohYO0zDXeNPk+xDnNx7Z2NZyrxL2Oe9Gh1Lch5CK7l0QO
        +45W1CLIx7HFeiPsQkgJVk0x/Qq3Cz5yUikSIO9x3qkqyLbHkptlY5WxYMsz2RNk27nUys
        Akjf2x2mwW+weMYa8w36SiS8vEvaB1FjizaSljDaxN+XAuAd0U9YZc1/KnqwvF3csRSDHS
        oZibDVLb9Fs67KpVVAJDgreCUAKD/F6+bxTo2O8pQLqBFmkPNKy94+HKEqEw1rCWDl3bBu
        EYA1E2GcDvYsOAtjGe0m3kJQb7sX0rtmaOl5lkjvc0DBhARAoiaoNtEls8gfMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639162819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0BeH0Kn3WigadkhEUoB01iDiT99PSY041SAX6KkeNTw=;
        b=6Dm1RTza5oJL5j7gcbgZrAwSYr6Qrei6L2Aw/pJtG3lIhtudTxPHkn/HtZp13oVAVakIkV
        lG/H1wTRd9DQnhDw==
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
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
In-Reply-To: <20211210123938.GF6385@nvidia.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com>
Date:   Fri, 10 Dec 2021 20:00:18 +0100
Message-ID: <87fsr0xp31.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jason,

On Fri, Dec 10 2021 at 08:39, Jason Gunthorpe wrote:

> On Fri, Dec 10, 2021 at 07:29:01AM +0000, Tian, Kevin wrote:
>> >   5) It's not possible for the kernel to reliably detect whether it is
>> >      running on bare metal or not. Yes we talked about heuristics, but
>> >      that's something I really want to avoid.
>> 
>> How would the hypercall mechanism avoid such heuristics?
>
> It is clever, we don't have an vIOMMU that supplies vIR today, so by
> definition all guests are excluded and only bare metal works.

Dammit. Now you spilled the beans. :)

>> > The charm is that his works for everything from INTx to IMS because all
>> > of them go through the same procedure, except that INTx (IO/APIC) does
>> > not support the reservation mode dance.
>
> Do we even have vIOAPIC?

It does not matter much. INTx via IOAPIC is different anyway because
INTx is shared so it's unclear from which device it originates.

> It seems reasonable - do you have any idea how this all would work on
> ARM too? IMS on baremetal ARM is surely interesting. I assume they
> have a similar issue with trapping the MSI

On baremetal it should just work once ARM is converted over. No idea
about guests. Marc should know.

>> Then Qemu needs to find out the GSI number for the vIRTE handle. 
>> Again Qemu doesn't have such information since it doesn't know 
>> which MSI[-X] entry points to this handle due to no trap.
>
> No this is already going wrong. qemu *cannot* know the MSI information
> because there is no MSI information for IMS.
>
> All qemu should get is the origin device information and data about
> how the guest wants the interrupt setup.
>
> Forget about guests and all of this complexity, design how to make
> VFIO work with IMS in pure userspace like DPDK.
>
> We must have a VFIO ioctl to acquire a addr/data pair and link it to
> an event fd.
>
> I'm not sure exactly how this should be done, it is 90% of what IMS
> is, except the VFIO irq_chip cannot touch any real HW and certainly
> cannot do mask/unmask..
>
> Maybe that is OK now that it requires IR?

IR unfortunately does not allow masking, but we surely can come up some
emergency button to press when e.g. an interrupt storm is detected.

Thanks,

        tglx
