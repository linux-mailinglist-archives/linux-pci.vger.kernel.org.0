Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9A264E31A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 22:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLOVcO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 16:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLOVcM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 16:32:12 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2995226494;
        Thu, 15 Dec 2022 13:32:11 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id q186so330074oia.9;
        Thu, 15 Dec 2022 13:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HTynDeXNkpS7KCYu7E7+Jn4FCRjkOmWYF6pd3r5Dpxw=;
        b=JXpJ4egZXf4IaVI2A1tT2nYpTA/Eeu3CmJYLuEhqpWpKxCIceuEKsBER71odVG5D12
         B7qngV8IlNnOq1UeJi+rNhvWZVf6t1c9iv5MqCxFQkNaIRrtF7saU3PGjIRL7PdVrZfO
         BS6Kdj4Xw454Oc75ILdSNKYDgq0IasbA/B6Lu0hmSpA5fftwxMLBAQNR4IVA1wcntvW+
         XXuRLAUPu1D4YP4vTEDJ2fJs6txD6yVLZbZ+8UjvagFfyu5zVIpmiMyHzEViTmFPIAef
         wuo7x64Jvgd3GI6COLHOU1ib2RDD6GWoHKGaJ0oIlkS8MVqHzqTz7TyVALrNlDb83fkL
         /Oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTynDeXNkpS7KCYu7E7+Jn4FCRjkOmWYF6pd3r5Dpxw=;
        b=xB+KhtLTvNrOwMzoK8gL7iFoMknTtmrH6GesBvtNc3iUIcDa66WI9eLbh+G/NmPM9q
         QMzxujsaCZbR9KJ0NwbGsi9AE8hiHGfX89UQlCRpp4CkNplcBCRDprjdbImr5C3JAlVo
         ZBKVNoD4AlrrCSqDY3dri60gf2EtuKBrzMmiVso81Dw9aD0qoAW2xhKfDG238OgZMEHC
         fdnYbmCWMWS929D+gxhp+5PPqCQgu8XB6gxqf4b0JVqbu+99a2rW9m9t/rfg19POgZCb
         XDiJ+BQjGG2pgYraAlT3PjQsS4oXsbCV7MAm8XBnPaNpzOX8pIj6HqTseeDlfDULGnTk
         4l4Q==
X-Gm-Message-State: ANoB5pklLxiA4SC9uVl1mz0jF47cxgIc/fIYGQ+bLV/ELKD8D4hyk/eB
        Hiu4JEMTVcob/Bal6L3sR9ZHMxCLezU=
X-Google-Smtp-Source: AA0mqf5cavguWrRfnmR9asWG7YLxZoANBrnbwbiz68yYdRhsIfgaQ0cf+g+0YKvqnHmP2Htp2lyuug==
X-Received: by 2002:a05:6808:170b:b0:357:7558:d7c6 with SMTP id bc11-20020a056808170b00b003577558d7c6mr20885867oib.20.1671139930403;
        Thu, 15 Dec 2022 13:32:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q11-20020a9d578b000000b0066c34486aa7sm32048oth.73.2022.12.15.13.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 13:32:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <53e93f9c-f8a3-6252-a5ab-431b5f69d954@roeck-us.net>
Date:   Thu, 15 Dec 2022 13:32:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [patch V3 09/33] genirq/msi: Add range checking to
 msi_insert_desc()
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
 <20221213190425.GA3943240@roeck-us.net>
 <4e0a129855490febb1c57e7e979bcfb579d39054.camel@linux.ibm.com>
 <87fsdgzpqs.ffs@tglx> <e570e70d-19bc-101b-0481-ff9a3cab3504@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <e570e70d-19bc-101b-0481-ff9a3cab3504@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/15/22 08:23, Matthew Rosato wrote:
> On 12/15/22 9:49 AM, Thomas Gleixner wrote:
>> On Wed, Dec 14 2022 at 10:42, Niklas Schnelle wrote:
>>> On Tue, 2022-12-13 at 11:04 -0800, Guenter Roeck wrote:
>>>> This patch results in various s390 qemu test failures.
>>>> There is a warning backtrace
>>>>
>>>>     12.674858] WARNING: CPU: 0 PID: 1 at kernel/irq/msi.c:167 msi_ctrl_valid+0x2a/0xb0
>>>>
>>>> followed by
>>>>
>>>> [   12.684333] virtio_net: probe of virtio0 failed with error -34
>>>>
>>>> and Ethernet interfaces don't instantiate.
>>> As far as I'm aware so far he tracked this down to code calling
>>> msi_domain_get_hwsize() which in turn calls msi_get_device_domain()
>>> which then returns NULL leading to msi_domain_get_hwsize() returning 0.
>>> I think this is related to the fact that we currently don't use IRQ
>>> domains.
>>
>> Correct and for some stupid reason I thought 0 is a good return value
>> here :)
>>
>>
>>
>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>> index bd4d4dd626b4..8fb10f216dc0 100644
>> --- a/kernel/irq/msi.c
>> +++ b/kernel/irq/msi.c
>> @@ -609,8 +609,8 @@ static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid
>>   		info = domain->host_data;
>>   		return info->hwsize;
>>   	}
>> -	/* No domain, no size... */
>> -	return 0;
>> +	/* No domain, default to MSI_MAX_INDEX */
>> +	return MSI_MAX_INDEX;
>>   }
>>   
>>   static inline void irq_chip_write_msi_msg(struct irq_data *data,
> 
> Ah, that makes sense...  So, with that diff applied, that fixes most of the issues I'm seeing incl. the virtio one that Guenter mentioned.  But it looks like NVMe devices are still broken on s390 with a different backtrace -- the bisect for that one points to another patch in part2 of this work and looks like another issue with missing irq domain:
> 
> 40742716f294 genirq/msi: Make msi_add_simple_msi_descs() device domain aware
> 
> 
> [    4.308861] ------------[ cut here ]------------
> [    4.308865] WARNING: CPU: 7 PID: 9 at kernel/irq/msi.c:167 msi_domain_free_msi_descs_range+0x3c/0xd0
> [    4.308877] Modules linked in: mlx5_core aes_s390 nvme des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 nvme_core sha1_s390 sha_common pkey zcrypt rng_core autofs4
> [    4.308896] CPU: 7 PID: 9 Comm: kworker/u20:0 Not tainted 6.1.0 #179
> [    4.308898] Hardware name: IBM 3931 A01 782 (KVM/Linux)
> [    4.308900] Workqueue: events_unbound async_run_entry_fn
> [    4.308905] Krnl PSW : 0704c00180000000 00000000b6426b78 (msi_domain_free_msi_descs_range+0x40/0xd0)
> [    4.308909]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [    4.308911] Krnl GPRS: 0700000080eda0a0 0000000000000000 0000000080eda0a0 0000000000000000
> [    4.308913]            0000000000000000 0000000000000000 0000000000000cc0 0000000080eda000
> [    4.308914]            00000000b7ddc000 0000000091934aa8 000000000000ffff 0000000000000000
> [    4.308915]            0000000080344200 0000000080f2b1c0 0000037fffb5b918 0000037fffb5b8c8
> [    4.308924] Krnl Code: 00000000b6426b68: e54cf0ac0000	mvhi	172(%r15),0
> [    4.308924]            00000000b6426b6e: ec3c000b017f	clij	%r3,1,12,00000000b6426b84
> [    4.308924]           #00000000b6426b74: af000000		mc	0,0
> [    4.308924]           >00000000b6426b78: eb9ff0b00004	lmg	%r9,%r15,176(%r15)
> [    4.308924]            00000000b6426b7e: 07fe		bcr	15,%r14
> [    4.308924]            00000000b6426b80: 47000700		bc	0,1792
> [    4.308924]            00000000b6426b84: b90400a5		lgr	%r10,%r5
> [    4.308924]            00000000b6426b88: b9040013		lgr	%r1,%r3
> [    4.308935] Call Trace:
> [    4.308938]  [<00000000b6426b78>] msi_domain_free_msi_descs_range+0x40/0xd0
> [    4.308945]  [<00000000b6bb126e>] pci_free_msi_irqs+0x26/0x48
> [    4.308950]  [<00000000b6baf4d4>] pci_disable_msix+0x6c/0x80
> [    4.308954]  [<00000000b6baf716>] pci_free_irq_vectors+0x26/0x88
> [    4.308956]  [<000003ff7fdfa8f4>] nvme_setup_io_queues+0x18c/0x398 [nvme]
> [    4.308968]  [<000003ff7fdfbf1e>] nvme_probe+0x2e6/0x3b0 [nvme]
> [    4.308972]  [<00000000b6ba44cc>] local_pci_probe+0x44/0x80
> [    4.308974]  [<00000000b6ba46d8>] pci_call_probe+0x50/0x180
> [    4.308976]  [<00000000b6ba5166>] pci_device_probe+0xae/0x110
> [    4.308978]  [<00000000b6c0a19a>] really_probe+0xd2/0x480
> [    4.308982]  [<00000000b6c0a6f8>] driver_probe_device+0x40/0xf0
> [    4.308984]  [<00000000b6c0a80e>] __driver_attach_async_helper+0x66/0xf0
> [    4.308986]  [<00000000b63cfb72>] async_run_entry_fn+0x4a/0x1b0
> [    4.308987]  [<00000000b63c1368>] process_one_work+0x200/0x458
> [    4.308991]  [<00000000b63c1aee>] worker_thread+0x66/0x480
> [    4.308993]  [<00000000b63caa00>] kthread+0x108/0x110
> [    4.308996]  [<00000000b634f2dc>] __ret_from_fork+0x3c/0x58
> [    4.308999]  [<00000000b6f8da2a>] ret_from_fork+0xa/0x40
> [    4.309006] Last Breaking-Event-Address:
> [    4.309007]  [<00000000b6426ba8>] msi_domain_free_msi_descs_range+0x70/0xd0
> [    4.309009] ---[ end trace 0000000000000000 ]---
> [    8.957187] nvme: probe of 0003:00:00.0 failed with error -22

With this patch applied, I see the same error on powerpc, followed by

WARNING: CPU: 0 PID: 21 at arch/powerpc/kernel/irq.c:348 .virq_to_hw+0x1c/0x60
Modules linked in:
CPU: 0 PID: 21 Comm: kworker/u2:2 Tainted: G        W        N 6.1.0-10397-g8a1566869bf4 #1
Hardware name: QEMU ppce500 e5500 0x80240020 QEMU e500
Workqueue: events_unbound .async_run_entry_fn
NIP:  c00000000000415c LR: c000000000004150 CTR: 0000000000000000
REGS: c0000000043c2f70 TRAP: 0700   Tainted: G        W        N  (6.1.0-10397-g8a1566869bf4)
MSR:  0000000080029002 <CE,EE,ME>  CR: 24828842  XER: 00000000
IRQMASK: 0
GPR00: c000000000004150 c0000000043c3210 c00000000169dd00 0000000000000000
GPR04: 0000000000000013 0000000000000000 0000000000000000 c000000005000368
GPR08: c0000000050002a8 0000000000000001 c000000005000360 fffffffffffffffd
GPR12: c00000000186a400 c0000000025f2000 c0000000060da000 c00000000433ca40
GPR16: 0000000000000004 c00000000617a020 0000000000000000 0000000000000000
GPR20: 0000000000000001 0000000000000000 c0000000043c3758 c00000000617a020
GPR24: 0000000000000000 0000000000000001 0000000000000001 c0000000043810b8
GPR28: c0000000043810b8 0000000000000041 fffffffffffffff0 c00000000602e4b8
NIP [c00000000000415c] .virq_to_hw+0x1c/0x60
LR [c000000000004150] .virq_to_hw+0x10/0x60
Call Trace:
[c0000000043c3210] [c000000000004150] .virq_to_hw+0x10/0x60 (unreliable)
[c0000000043c3280] [c000000000041d58] .fsl_teardown_msi_irqs+0x48/0xe0
[c0000000043c3310] [c00000000002b204] .arch_teardown_msi_irqs+0x34/0x50
[c0000000043c3380] [c0000000008d6e68] .pci_msi_legacy_teardown_msi_irqs+0x28/0x40
[c0000000043c3400] [c0000000008d66c0] .pci_msi_teardown_msi_irqs+0x30/0xa0
[c0000000043c3480] [c0000000008d590c] .__pci_enable_msix_range+0x5fc/0x990
[c0000000043c35e0] [c0000000008d3934] .pci_alloc_irq_vectors_affinity+0x154/0x1d0
[c0000000043c36c0] [c000000000a74360] .nvme_setup_io_queues+0x2b0/0x9c0
[c0000000043c3830] [c000000000a76298] .nvme_probe+0x538/0x620
[c0000000043c38d0] [c0000000008c6e84] .pci_device_probe+0xc4/0x190
[c0000000043c3960] [c0000000009a9f38] .really_probe+0x108/0x460
[c0000000043c39f0] [c0000000009aa3a4] .driver_probe_device+0x44/0x120
[c0000000043c3a80] [c0000000009aa4e4] .__driver_attach_async_helper+0x64/0x120
[c0000000043c3b10] [c000000000094ca0] .async_run_entry_fn+0x50/0x140
[c0000000043c3bb0] [c000000000081e98] .process_one_work+0x2d8/0x7b0
[c0000000043c3c90] [c000000000082408] .worker_thread+0x98/0x4f0
[c0000000043c3d70] [c00000000008f2ac] .kthread+0x13c/0x150
[c0000000043c3e10] [c0000000000005d8] .ret_from_kernel_thread+0x58/0x60
Instruction dump:
78630020 ebc1fff0 ebe1fff8 7c0803a6 4e800020 7c0802a6 f8010010 f821ff91
480fb275 60000000 7c690074 7929d182 <0b090000> 38210070 e8630008 e8010010
irq event stamp: 96256
hardirqs last  enabled at (96255): [<c000000001114314>] ._raw_spin_unlock_irqrestore+0x84/0xd0
hardirqs last disabled at (96256): [<c000000000010b68>] .program_check_exception+0x38/0x120
softirqs last  enabled at (96188): [<c00000000111557c>] .__do_softirq+0x60c/0x678
softirqs last disabled at (96181): [<c000000000004d30>] .do_softirq_own_stack+0x30/0x50
---[ end trace 0000000000000000 ]---
Kernel attempted to read user page (d8) - exploit attempt? (uid: 0)
BUG: Kernel NULL pointer dereference on read at 0x000000d8
Faulting instruction address: 0xc0000000000e5540
Oops: Kernel access of bad area, sig: 11 [#1]
BE PAGE_SIZE=4K SMP NR_CPUS=24 QEMU e500
Modules linked in:
CPU: 0 PID: 21 Comm: kworker/u2:2 Tainted: G        W        N 6.1.0-10397-g8a1566869bf4 #1
Hardware name: QEMU ppce500 e5500 0x80240020 QEMU e500
Workqueue: events_unbound .async_run_entry_fn
NIP:  c0000000000e5540 LR: c0000000000e44a4 CTR: 0000000000000000
REGS: c0000000043c2c90 TRAP: 0300   Tainted: G        W        N  (6.1.0-10397-g8a1566869bf4)
MSR:  0000000080029002 <CE,EE,ME>  CR: 44828842  XER: 00000000
DEAR: 00000000000000d8 ESR: 0000000000000000 IRQMASK: 1
GPR00: c0000000000e44a4 c0000000043c2f30 c00000000169dd00 00000000000000d8
GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000001
GPR08: 0000000000000001 0000000000000001 c00000000003f5a4 0000000000000001
GPR12: 0000000044828842 c0000000025f2000 00000000000000d8 0000000000000000
GPR16: 0000000000000004 c00000000617a020 c0000000043e8040 0000000000000000
GPR20: 0000000000000001 c0000000019e5918 c00000000182e738 0000000000000000
GPR24: 0000000000000000 0000000000000001 0000000000000000 00000000000000d8
GPR28: 0000000000000001 0000000000000000 0000000000000000 c00000000182e738
NIP [c0000000000e5540] .__lock_acquire+0x2f0/0x1e90
LR [c0000000000e44a4] .lock_acquire+0x144/0x450
Call Trace:
[c0000000043c2f30] [c0000000043c2ff0] 0xc0000000043c2ff0 (unreliable)
[c0000000043c3060] [c0000000000e44a4] .lock_acquire+0x144/0x450
[c0000000043c3160] [c000000001113ebc] ._raw_spin_lock_irqsave+0x5c/0xb0
[c0000000043c31f0] [c00000000003f5a4] .msi_bitmap_free_hwirqs+0x34/0x90
[c0000000043c3280] [c000000000041da4] .fsl_teardown_msi_irqs+0x94/0xe0
[c0000000043c3310] [c00000000002b204] .arch_teardown_msi_irqs+0x34/0x50
[c0000000043c3380] [c0000000008d6e68] .pci_msi_legacy_teardown_msi_irqs+0x28/0x40
[c0000000043c3400] [c0000000008d66c0] .pci_msi_teardown_msi_irqs+0x30/0xa0
[c0000000043c3480] [c0000000008d590c] .__pci_enable_msix_range+0x5fc/0x990
[c0000000043c35e0] [c0000000008d3934] .pci_alloc_irq_vectors_affinity+0x154/0x1d0
[c0000000043c36c0] [c000000000a74360] .nvme_setup_io_queues+0x2b0/0x9c0
[c0000000043c3830] [c000000000a76298] .nvme_probe+0x538/0x620
[c0000000043c38d0] [c0000000008c6e84] .pci_device_probe+0xc4/0x190
[c0000000043c3960] [c0000000009a9f38] .really_probe+0x108/0x460
[c0000000043c39f0] [c0000000009aa3a4] .driver_probe_device+0x44/0x120
[c0000000043c3a80] [c0000000009aa4e4] .__driver_attach_async_helper+0x64/0x120
[c0000000043c3b10] [c000000000094ca0] .async_run_entry_fn+0x50/0x140
[c0000000043c3bb0] [c000000000081e98] .process_one_work+0x2d8/0x7b0
[c0000000043c3c90] [c000000000082408] .worker_thread+0x98/0x4f0
[c0000000043c3d70] [c00000000008f2ac] .kthread+0x13c/0x150
[c0000000043c3e10] [c0000000000005d8] .ret_from_kernel_thread+0x58/0x60
Instruction dump:
2c0a0000 40c200bc 3c82ffe4 3c62ffe3 38841f48 38639c50 4bf6eeb1 60000000
0fe00000 60000000 60000000 60000000 <e9430000> 3d22006c 3929cc98 7c2a4800
---[ end trace 0000000000000000 ]---

Guenter


