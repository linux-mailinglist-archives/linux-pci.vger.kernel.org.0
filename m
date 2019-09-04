Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77998A7E93
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 10:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfIDI5G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 04:57:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbfIDI5G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Sep 2019 04:57:06 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CDB8C341603829889F06;
        Wed,  4 Sep 2019 16:57:04 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 16:56:56 +0800
Subject: Re: PCI/kernel msi code vs GIC ITS driver conflict?
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>
References: <f5e948aa-e32f-3f74-ae30-31fee06c2a74@huawei.com>
 <5fd4c1cf-76c1-4054-3754-549317509310@kernel.org>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ef258ec7-877c-406a-3d88-80ff79b823f2@huawei.com>
Date:   Wed, 4 Sep 2019 09:56:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <5fd4c1cf-76c1-4054-3754-549317509310@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/09/2019 17:16, Marc Zyngier wrote:
> Hi John,
>
> On 03/09/2019 15:09, John Garry wrote:
>> Hi Marc, Bjorn, Thomas,

Hi Marc,

>>
>> We've come across a conflict with the kernel/pci msi code and GIC ITS
>> driver on our arm64 system, whereby we can't unbind and re-bind a PCI
>> device driver under special conditions. I'll explain...
>>
>> Our PCI device support 32 MSIs. The driver attempts to allocate msi
>> vectors with min msi=17, max msi = 32, and affd.pre vectors = 16. For
>> our test we make nr_cpus = 1 (just anything less than 16).
>
> Just to confirm: this PCI device is requiring Multi-MSI, right? As
> opposed to MSI-X?

Right, Multi-MSI.

>
>> We find that the pci/kernel msi code gives us 17 vectors, but the GIC
>> ITS code reserves 32 lpi maps in its_irq_domain_alloc(). The problem
>> then occurs when unbinding the driver in its_irq_domain_free() call,
>> where we only clear bits for 17 vectors. So if we unbind the driver and
>> then attempt to bind again, it fails.
>
> Is this device, by any chance, sharing its requested-id with another
> device? By being behind a bridge of some sort?There is some code to
> deal with it, but I'm not sure it has ever been verified in anger...

It's a RC iEP and there should be no requested-id sharing:

root@ubuntu:/home/john#  lspci -s 74:02.0 -v
74:02.0 Serial Attached SCSI controller: Huawei Technologies Co., Ltd. 
HiSilicon SAS 3.0 HBA (rev 20)
Flags: bus master, fast devsel, latency 0, IRQ 23, NUMA node 0
Memory at a2000000 (32-bit, non-prefetchable) [size=32K]
Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
Capabilities: [80] MSI: Enable+ Count=32/32 Maskable+ 64bit+
Capabilities: [b0] Power Management version 3
Kernel driver in use: hisi_sas_v3_hw

>
>> Where the fault lies, I can't say. Maybe the kernel msi code should
>> always give power of 2 vectors - as I understand, the PCI spec mandates
>> this. Or maybe the GIC ITS driver has a problem in the free path, as
>> above. Or maybe the PCI driver should not be allowed to request !power
>> of 2 min/max vectors.
>>
>> Opinion?
>
> My hunch is that it is an ITS driver bug: the PCI layer is allowed to
> give any number of MSIs to an endpoint driver, as long as they match the
> requirements of the allocation for Multi-MSI.

I would tend to say that, but isn't the requirement to allocate power of 
2 msi vectors, which doesn't seem to be enforced in the kernel msi layer?

  That's the responsibility
> of the ITS driver. If unbind/bind fails, it means that somehow we've
> missed the freeing of the LPIs, which isn't good.
>
> Is the device common enough that I can try and reproduce the issue?

No, it's integrated into the hi1620 SoC found in the D06 dev board only, 
but I don't think that there is anything special about this HW.

If
> there's a Linux driver somewhere, I can always hack something in
> emulation and find out...

Ok, the interrupt allocation for this particular driver in this test is 
in 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c#n2393

Cheers,
John

>
> Thanks,
>
> 	M.
>


