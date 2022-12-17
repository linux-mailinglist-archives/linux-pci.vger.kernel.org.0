Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0259E64F91C
	for <lists+linux-pci@lfdr.de>; Sat, 17 Dec 2022 14:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiLQNgv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Dec 2022 08:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiLQNgt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Dec 2022 08:36:49 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6007DFB0;
        Sat, 17 Dec 2022 05:36:48 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1441d7d40c6so6512976fac.8;
        Sat, 17 Dec 2022 05:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RpJvH6AiAJeYi8qsi/DnAQCpW34c5rPL8YXBbeT9+FQ=;
        b=AZKLZSm0jeclDdd9ROYkW7P25x+5yNrOmJ9sHxua/Xrsj/fUcqyW7N+fozM8FtBytb
         LLVdWqt3xd4Q/OOHsk8XWOqgPlkG4sZtXFja7CBk0890DC7YZ90jQtih4v2kDilu2gdf
         8nVZCas3ktrQRju//DLbShoOp9p2quBadeQRuauoDboCpruhSHD0nltyNIsuzXEwgTq1
         Pea6kZ+3SqNY9cslG01cBvEbQ8EqukP+p6i8iQVfY+yIcRaFDR0sFe49PnQD9nej/il0
         IKxrViMSVNZrwWwIWbuHB+ddBc3Xa9jiRmI0U8VkRpCUrNFPlH7mIvjoqZ2VwT88bPuS
         T/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpJvH6AiAJeYi8qsi/DnAQCpW34c5rPL8YXBbeT9+FQ=;
        b=o0nMGK6yhT1gVNn6eij3VNv4AjyIWfh8/nkX7Vcabec81QC1M+IwGt2W1gxFs6UOQl
         1xeLriy4augHsSVktvBLVMxnaaenSK2xG5uGmhD3gBBw2WdA794ztXyuW0+jgbgzDxsE
         SvL0eJMxMZIemviF9R9oourib3RFbRl/47eqUYjGw9gfRoLFLTUiM+y6HSFgLh9bmhO6
         F2lQVG8O3+njViBLaH9szUpHL1XZusZ7E4W0cak6q8DzpFUYCWS5cdTmSdBiZo17RoUJ
         VWEM6EKqT2YhUcnv55WQD58+lw45dj9B2RqXraqj3Y1XkFYxKJfq1vYd7UFg2wMbJ/6u
         b/aw==
X-Gm-Message-State: ANoB5pl7t4k2oqDfJWJfu2fJdZTmu2QKD5jmBJs4DiYcA/lP1FnFYWIa
        xwLG/NkMmxNNVy0HkTf8YbU=
X-Google-Smtp-Source: AA0mqf6tGD0GzQZU6o204kR99SH2Pp9iJD5ytrtNPp+CA19K59+HPfTXmfLcLUWyep9jzJHzJouSqw==
X-Received: by 2002:a05:6870:a18a:b0:141:fbdd:53b3 with SMTP id a10-20020a056870a18a00b00141fbdd53b3mr19488907oaf.41.1671284208152;
        Sat, 17 Dec 2022 05:36:48 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9-20020a056870d28900b00143d4709a38sm2215370oae.55.2022.12.17.05.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 05:36:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <50bd7cc7-74bb-b1af-f817-54aa877dd10c@roeck-us.net>
Date:   Sat, 17 Dec 2022 05:36:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [patch V3 09/33] genirq/msi: Add range checking to
 msi_insert_desc()
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
 <20221213190425.GA3943240@roeck-us.net>
 <4e0a129855490febb1c57e7e979bcfb579d39054.camel@linux.ibm.com>
 <87fsdgzpqs.ffs@tglx> <e570e70d-19bc-101b-0481-ff9a3cab3504@linux.ibm.com>
 <86wn6rptdu.wl-maz@kernel.org>
 <0acb8c63-7f6c-6df6-cb40-66b265a6e6ce@linux.ibm.com>
 <86v8mbphzw.wl-maz@kernel.org>
 <70dab88e-6119-0c12-7c6a-61bcbe239f66@roeck-us.net>
 <86sfhepat1.wl-maz@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <86sfhepat1.wl-maz@kernel.org>
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

On 12/17/22 02:46, Marc Zyngier wrote:
> On Sat, 17 Dec 2022 00:45:50 +0000,
> Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 12/16/22 05:58, Marc Zyngier wrote:
>> [ ... ]
>>
>>>> With both these fixes applied, it actually then leads to the very
>>>> next WARN_ON failing in msi_ctrl_valid...  Because ctrl->last ==
>>>> hwsize.  I think Thomas' initial fix for msi_domain_get_hwsize has
>>>> an off-by-1 error, I think we should return MSI_XA_DOMAIN_SIZE for
>>>> msi_domain_get_hwsize instead.
>>>
>>> Yes, that's a good point, and that's consistent with what
>>> __msi_create_irq_domain() does already, assuming MSI_XA_DOMAIN_SIZE
>>> when info->hwsize is 0. No reason to do something else here.
>>>
>>> I'll update Thomas' patch. Once Guenter confirms that PPC is OK, I'll
>>> send it out.
>>>
>> With
>>
>> 7a27b6136dcb (local/testing, testing-msi) genirq/msi: Return MSI_XA_DOMAIN_SIZE as the maximum MSI index when no domain is present
>> c581d525bb1d genirq/msi: Check for the presence of an irq domain when validating msi_ctrl
>> 9d33edb20f7e Merge tag 'irq-core-2022-12-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>
>> I still get the following runtime warning.
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 8 at kernel/irq/msi.c:196 .msi_domain_free_descs+0x144/0x170
>> Modules linked in:
>> CPU: 0 PID: 8 Comm: kworker/u2:0 Tainted: G                 N 6.1.0-01957-g7a27b6136dcb #1
>> Hardware name: QEMU ppce500 e5500 0x80240020 QEMU e500
>> Workqueue: nvme-reset-wq .nvme_reset_work
>> NIP:  c000000000107d54 LR: c000000000107d44 CTR: 0000000000000000
>> REGS: c0000000041e74d0 TRAP: 0700   Tainted: G                 N  (6.1.0-01957-g7a27b6136dcb)
>> MSR:  0000000080029002 <CE,EE,ME>  CR: 44002282  XER: 20000000
>> IRQMASK: 0
>> GPR00: c000000000107d44 c0000000041e7770 c000000001629c00 c000000004e748a0
>> GPR04: 000000005358db0a c000000001ce7a00 c00000000423b5d0 000000004735aaa2
>> GPR08: 0000000000000002 0000000000000013 c00000000423acc0 c00000000214a998
>> GPR12: 0000000024002282 c000000002579000 c00000000008e190 c000000004173540
>> GPR16: 0000000000000000 c0000000043810b8 0000000000000000 0000000000000001
>> GPR20: c0000000060b22d8 c0000000060a70f0 0000000000000000 c000000001996800
>> GPR24: c0000000017df6c0 c0000000043810b8 c0000000060b2388 c0000000060b2000
>> GPR28: ffffffffffffffff c0000000041e7888 c000000006025ac8 c000000004e748a0
>> NIP [c000000000107d54] .msi_domain_free_descs+0x144/0x170
>> LR [c000000000107d44] .msi_domain_free_descs+0x134/0x170
>> Call Trace:
>> [c0000000041e7770] [c000000000107d44] .msi_domain_free_descs+0x134/0x170 (unreliable)
>> [c0000000041e7810] [c0000000001085d8] .msi_domain_free_msi_descs_range+0x38/0x70
>> [c0000000041e78a0] [c0000000008d000c] .pci_msi_teardown_msi_irqs+0x4c/0xa0
>> [c0000000041e7920] [c0000000008cf9e8] .pci_free_msi_irqs+0x18/0x50
>> [c0000000041e79a0] [c0000000008cd8d0] .pci_free_irq_vectors+0x80/0xb0
>> [c0000000041e7a20] [c000000000a6d2a0] .nvme_reset_work+0x870/0x1780
>> [c0000000041e7bb0] [c000000000080e68] .process_one_work+0x2d8/0x7b0
>> [c0000000041e7c90] [c0000000000813d8] .worker_thread+0x98/0x4f0
>> [c0000000041e7d70] [c00000000008e2cc] .kthread+0x13c/0x150
>> [c0000000041e7e10] [c0000000000005d8] .ret_from_kernel_thread+0x58/0x60
>> Instruction dump:
>> 7fc3f378 48ff1ca9 60000000 7c7f1b79 41c2002c e8810070 7fc3f378 48ff3491
>> 60000000 813f0000 2c090000 41e2ffb0 <0fe00000> 60000000 60000000 ebc10090
>> irq event stamp: 98168
>> hardirqs last  enabled at (98167): [<c00000000110a274>] ._raw_spin_unlock_irqrestore+0x84/0xd0
>> hardirqs last disabled at (98168): [<c000000000010b58>] .program_check_exception+0x38/0x120
>> softirqs last  enabled at (97760): [<c00000000110b4dc>] .__do_softirq+0x60c/0x678
>> softirqs last disabled at (97749): [<c000000000004d20>] .do_softirq_own_stack+0x30/0x50
>> ---[ end trace 0000000000000000 ]---
>> nvme nvme0: 1/0/0 default/read/poll queues
>> nvme nvme0: Ignoring bogus Namespace Identifiers
>> ...
>>
>> The system boots fine, though. This is seen when booting the ppce500
>> machine with e5500 CPU and corenet64_smp_defconfig from nvme.
> 
> +PPC folks.
> 
> Thanks for the report.
> 
> I managed to reproduce this, although in a limited way (a SMP qemu
> instance wouldn't boot at all). The problem is that the core MSI code
> now assumes that if the arch code is in charge of breaking the
> association of a MSI with a device, it is also in charge of clearing
> the irq in the MSI descriptor.
> 
> This matches the s390 behaviour, but not powerpc's, hence the splat
> and the leaked MSI descriptors. The minimal fix should be as follow,
> which I'll add to the pile of patches.
> 

Confirmed, the patch below fixes the ppc problem.

Thanks,
Guenter

> Thanks,
> 
> 	M.
> 
> diff --git a/arch/powerpc/platforms/4xx/hsta_msi.c b/arch/powerpc/platforms/4xx/hsta_msi.c
> index d4f7fff1fc87..e11b57a62b05 100644
> --- a/arch/powerpc/platforms/4xx/hsta_msi.c
> +++ b/arch/powerpc/platforms/4xx/hsta_msi.c
> @@ -115,6 +115,7 @@ static void hsta_teardown_msi_irqs(struct pci_dev *dev)
>   		msi_bitmap_free_hwirqs(&ppc4xx_hsta_msi.bmp, irq, 1);
>   		pr_debug("%s: Teardown IRQ %u (index %u)\n", __func__,
>   			 entry->irq, irq);
> +		entry->irq = 0;
>   	}
>   }
>   
> diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
> index 5b012abca773..0c11aad896c7 100644
> --- a/arch/powerpc/platforms/cell/axon_msi.c
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -289,6 +289,7 @@ static void axon_msi_teardown_msi_irqs(struct pci_dev *dev)
>   	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ASSOCIATED) {
>   		irq_set_msi_desc(entry->irq, NULL);
>   		irq_dispose_mapping(entry->irq);
> +		entry->irq = 0;
>   	}
>   }
>   
> diff --git a/arch/powerpc/platforms/pasemi/msi.c b/arch/powerpc/platforms/pasemi/msi.c
> index dc1846660005..166c97fff16d 100644
> --- a/arch/powerpc/platforms/pasemi/msi.c
> +++ b/arch/powerpc/platforms/pasemi/msi.c
> @@ -66,6 +66,7 @@ static void pasemi_msi_teardown_msi_irqs(struct pci_dev *pdev)
>   		hwirq = virq_to_hw(entry->irq);
>   		irq_set_msi_desc(entry->irq, NULL);
>   		irq_dispose_mapping(entry->irq);
> +		entry->irq = 0;
>   		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq, ALLOC_CHUNK);
>   	}
>   }
> diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
> index 73c2d70706c0..57978a44d55b 100644
> --- a/arch/powerpc/sysdev/fsl_msi.c
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -132,6 +132,7 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
>   		msi_data = irq_get_chip_data(entry->irq);
>   		irq_set_msi_desc(entry->irq, NULL);
>   		irq_dispose_mapping(entry->irq);
> +		entry->irq = 0;
>   		msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, 1);
>   	}
>   }
> diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
> index 1d8cfdfdf115..492cb03c0b62 100644
> --- a/arch/powerpc/sysdev/mpic_u3msi.c
> +++ b/arch/powerpc/sysdev/mpic_u3msi.c
> @@ -108,6 +108,7 @@ static void u3msi_teardown_msi_irqs(struct pci_dev *pdev)
>   		hwirq = virq_to_hw(entry->irq);
>   		irq_set_msi_desc(entry->irq, NULL);
>   		irq_dispose_mapping(entry->irq);
> +		entry->irq = 0;
>   		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq, 1);
>   	}
>   }
> 

