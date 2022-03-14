Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38BE4D8CDF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 20:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244367AbiCNTsS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 15:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244358AbiCNTsQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 15:48:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0FB3DA79
        for <linux-pci@vger.kernel.org>; Mon, 14 Mar 2022 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=DANVV7tautgzGakgpv9z7D8U8hLFLyK+D43eHHtNBLQ=; b=fmR26TPcHeUodJL+YWjjk6deRa
        y4eO5+vMIpXg4fxrd0CEwIOlw8LdTmdfuxpC4L2L/LM/21nazYwEFSesWWB2NGWDv+rwDawWidJ9o
        TleahNdbDxeJ2E98CQWJmHxjrnSogPwzAl8GGeUl4nOcVxeY7GLGRn3WvNinvhU7Qd+LkrSP9Z9sO
        ngMsoLtnioh52NJJA64r9osY/ALvhZjsWO6k76buEs9gD4fLc0vuk+mMphJ3K/NqZKEwGdzXG3q0T
        P4QGHCmRhQRab8jHZZNAdOeJIQUEHC7ROje9CAvJvYy92/VkWaRDB3GecmQ+b5P0p44iogD8kjTeM
        qFQzLP9Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTqeY-000xJH-MX; Mon, 14 Mar 2022 19:46:51 +0000
Message-ID: <33c1aca6-aa4b-77fe-bf49-9376effe932a@infradead.org>
Date:   Mon, 14 Mar 2022 12:46:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [next] pci_x86.h:105:8: error: unknown type name 'raw_spinlock_t'
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        PCI <linux-pci@vger.kernel.org>, X86 ML <x86@kernel.org>,
        lkft-triage@lists.linaro.org
References: <20220314160154.GA501271@bhelgaas>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220314160154.GA501271@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/14/22 09:01, Bjorn Helgaas wrote:
> On Mon, Mar 14, 2022 at 03:48:12PM +0530, Naresh Kamboju wrote:
>> Linux next-20220310 i386 build failed due to below warnings / errors.
>>
>>   CC      arch/x86/kernel/resource.o
>> In file included from arch/x86/kernel/resource.c:4:0:
>> arch/x86/include/asm/pci_x86.h:105:8: error: unknown type name 'raw_spinlock_t'
> 
> I don't know what to do with this.  It works for me:
> 
>   $ gsr
>   71941773e143 ("Add linux-next specific files for 20220310")
>   $ ARCH=i386 make defconfig
>   $ ARCH=i386 make arch/x86/kernel/resource.o
>     ...
>     CC      arch/x86/kernel/resource.o
>   $ echo $?
>   0
> 
> What config did you use?  How can I reproduce this?

I sent a patch for this a few weeks ago.

https://lore.kernel.org/lkml/20220226213703.24041-1-rdunlap@infradead.org/

I sent it to the x86 maintainers...

> 
>>  extern raw_spinlock_t pci_config_lock;
>>         ^~~~~~~~~~~~~~
>> arch/x86/include/asm/pci_x86.h:141:20: error: expected '=', ',', ';',
>> 'asm' or '__attribute__' before 'dmi_check_pciprobe'
>>  extern void __init dmi_check_pciprobe(void);
>>                     ^~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/pci_x86.h:142:20: error: expected '=', ',', ';',
>> 'asm' or '__attribute__' before 'dmi_check_skip_isa_align'
>>  extern void __init dmi_check_skip_isa_align(void);
>>                     ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/pci_x86.h:146:19: error: expected '=', ',', ';',
>> 'asm' or '__attribute__' before 'pci_acpi_init'
>>  extern int __init pci_acpi_init(void);
>>                    ^~~~~~~~~~~~~
>> arch/x86/include/asm/pci_x86.h:153:20: error: expected '=', ',', ';',
>> 'asm' or '__attribute__' before 'pcibios_irq_init'
>>  extern void __init pcibios_irq_init(void);
>>                     ^~~~~~~~~~~~~~~~
>> arch/x86/include/asm/pci_x86.h:154:19: error: expected '=', ',', ';',
>> 'asm' or '__attribute__' before 'pcibios_init'
>>  extern int __init pcibios_init(void);
>>                    ^~~~~~~~~~~~
>> arch/x86/include/asm/pci_x86.h:174:19: error: expected '=', ',', ';',
>> 'asm' or '__attribute__' before 'pci_mmcfg_arch_init'
>>  extern int __init pci_mmcfg_arch_init(void);
>>                    ^~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/pci_x86.h:175:20: error: expected '=', ',', ';',
>> 'asm' or '__attribute__' before 'pci_mmcfg_arch_free'
>>  extern void __init pci_mmcfg_arch_free(void);
>>                     ^~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/pci_x86.h:182:40: error: expected '=', ',', ';',
>> 'asm' or '__attribute__' before 'pci_mmconfig_add'
>>  extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
>>                                         ^~~~~~~~~~~~~~~~
>>   CC      net/core/filter.o
>> make[2]: *** [scripts/Makefile.build:288: arch/x86/kernel/resource.o] Error 1
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>>
>> --
>> Linaro LKFT
>> https://lkft.linaro.org
>> [1]  https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-core2-32,label=docker-buster-lkft/1207/consoleText

-- 
~Randy
