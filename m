Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C724D88B3
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 17:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiCNQDJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 12:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242545AbiCNQDI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 12:03:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C377E443F9
        for <linux-pci@vger.kernel.org>; Mon, 14 Mar 2022 09:01:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7196CB80E64
        for <linux-pci@vger.kernel.org>; Mon, 14 Mar 2022 16:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B02C340E9;
        Mon, 14 Mar 2022 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647273716;
        bh=upEagSimI3eDc0IEuZZM6YkhK1yfgOmZCHQz5CWHQNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RBca2aVXMrAdQLUY/cYDcawnRCJGYE2N1SV+1+XUGDPokH7eQpVCwIgjrIWnfEWhC
         Vt4vYUmljEPH4PpFVeQJZ7N+L70d3jhZ/fOmTQdZGi5nq+a3m8punrPU6E2I8spynp
         lhilLk2Whl4HKv8WSWLTKvfhZrTjwlMMwtd1MEHKDgPuxlPP1E/5NyI1BD3wfUq8Xu
         KOvFi6svjhDWjZE88FOYB2bUvFbexpbd9A6Mp4IXryhq4kLcQz54OWYgohIismwrFK
         bo9dw+fmlOTNSaDJ6TiWepaAAgBUqawMK87tG8G1vWkRyFETDiinOhox33ET2UdZXp
         AICU3DcYa9XdQ==
Date:   Mon, 14 Mar 2022 11:01:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        PCI <linux-pci@vger.kernel.org>, X86 ML <x86@kernel.org>,
        lkft-triage@lists.linaro.org
Subject: Re: [next] pci_x86.h:105:8: error: unknown type name 'raw_spinlock_t'
Message-ID: <20220314160154.GA501271@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtX3RzYbpZRAktPNfbP51obcBi=_PJZ6RT-x+BnE-9ESQ@mail.gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 14, 2022 at 03:48:12PM +0530, Naresh Kamboju wrote:
> Linux next-20220310 i386 build failed due to below warnings / errors.
> 
>   CC      arch/x86/kernel/resource.o
> In file included from arch/x86/kernel/resource.c:4:0:
> arch/x86/include/asm/pci_x86.h:105:8: error: unknown type name 'raw_spinlock_t'

I don't know what to do with this.  It works for me:

  $ gsr
  71941773e143 ("Add linux-next specific files for 20220310")
  $ ARCH=i386 make defconfig
  $ ARCH=i386 make arch/x86/kernel/resource.o
    ...
    CC      arch/x86/kernel/resource.o
  $ echo $?
  0

What config did you use?  How can I reproduce this?

>  extern raw_spinlock_t pci_config_lock;
>         ^~~~~~~~~~~~~~
> arch/x86/include/asm/pci_x86.h:141:20: error: expected '=', ',', ';',
> 'asm' or '__attribute__' before 'dmi_check_pciprobe'
>  extern void __init dmi_check_pciprobe(void);
>                     ^~~~~~~~~~~~~~~~~~
> arch/x86/include/asm/pci_x86.h:142:20: error: expected '=', ',', ';',
> 'asm' or '__attribute__' before 'dmi_check_skip_isa_align'
>  extern void __init dmi_check_skip_isa_align(void);
>                     ^~~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/include/asm/pci_x86.h:146:19: error: expected '=', ',', ';',
> 'asm' or '__attribute__' before 'pci_acpi_init'
>  extern int __init pci_acpi_init(void);
>                    ^~~~~~~~~~~~~
> arch/x86/include/asm/pci_x86.h:153:20: error: expected '=', ',', ';',
> 'asm' or '__attribute__' before 'pcibios_irq_init'
>  extern void __init pcibios_irq_init(void);
>                     ^~~~~~~~~~~~~~~~
> arch/x86/include/asm/pci_x86.h:154:19: error: expected '=', ',', ';',
> 'asm' or '__attribute__' before 'pcibios_init'
>  extern int __init pcibios_init(void);
>                    ^~~~~~~~~~~~
> arch/x86/include/asm/pci_x86.h:174:19: error: expected '=', ',', ';',
> 'asm' or '__attribute__' before 'pci_mmcfg_arch_init'
>  extern int __init pci_mmcfg_arch_init(void);
>                    ^~~~~~~~~~~~~~~~~~~
> arch/x86/include/asm/pci_x86.h:175:20: error: expected '=', ',', ';',
> 'asm' or '__attribute__' before 'pci_mmcfg_arch_free'
>  extern void __init pci_mmcfg_arch_free(void);
>                     ^~~~~~~~~~~~~~~~~~~
> arch/x86/include/asm/pci_x86.h:182:40: error: expected '=', ',', ';',
> 'asm' or '__attribute__' before 'pci_mmconfig_add'
>  extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
>                                         ^~~~~~~~~~~~~~~~
>   CC      net/core/filter.o
> make[2]: *** [scripts/Makefile.build:288: arch/x86/kernel/resource.o] Error 1
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> [1]  https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-core2-32,label=docker-buster-lkft/1207/consoleText
