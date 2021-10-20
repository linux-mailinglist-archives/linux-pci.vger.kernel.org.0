Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891C0434784
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 11:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJTJDq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 05:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229600AbhJTJDp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 05:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634720491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hiiori2pDPMIM5jGb2jBjJEZ34cwSk9hIYaLjsY3xNQ=;
        b=Q0GqC4M8N8m4WPkBDlQJBBkJEe227dpmWoOUyWOCW9A7VoH83ydELaIpaN2sJ9rPtXjkq7
        7Tg4L3KbeDTAosaiamtPUN01mDfNk+VL2iyTMyhLNsJnf7O36EGHIGP6avBog5Z2DscCh5
        ibA6m00xxU+KoBbFnKLQyYv11ttowCw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-d0mcwiDlMAq2xmsLN6jPhA-1; Wed, 20 Oct 2021 05:01:30 -0400
X-MC-Unique: d0mcwiDlMAq2xmsLN6jPhA-1
Received: by mail-ed1-f72.google.com with SMTP id l10-20020a056402230a00b003db6977b694so20311500eda.23
        for <linux-pci@vger.kernel.org>; Wed, 20 Oct 2021 02:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hiiori2pDPMIM5jGb2jBjJEZ34cwSk9hIYaLjsY3xNQ=;
        b=12/UOmHtc993dBBLCL+HItoT7JD038OSzURLVTty5sjeuirOO+yLStNzbqsdIb5a1/
         nwina9wtjVY3ySgjVTaOShqakIDYx2ozlaO+biIEhDYd1KA+ivyyowmKiucr0+4LX/ag
         0NL62m+1BQtKmDyR0FopRRc7n1L0ELPvNhK2Aj8a6J/wW46Ie4qaeQeLeiWKE6Zk4e4I
         GjOXcCvjpXemx6C4cnPoXgm4wDLKGuMwvP4eCmICVaPiTE2u50AOKVSW3WBKrv4anAJx
         anmnawPtflJ+Pu8Q6vhTX1DTb/B83pfDqv5506JGal+dDS+YF74mw9+Lqkpd+yiQX8xs
         6EpQ==
X-Gm-Message-State: AOAM533BrFSkZv1xQtMliIZyaBydTwtYTtBLqlE/jb//Jp/4tVkLzIqJ
        0+GLzQaXH2m2MJWQq+dBWATwmImX5OGdOLQ0UR11PhEmPIXT/Zr9ZmOPxuje9VIlGD/KAwrRtmE
        CWoAJRx8QAQCdddlOAbUq
X-Received: by 2002:a17:906:4f19:: with SMTP id t25mr44743209eju.176.1634720488745;
        Wed, 20 Oct 2021 02:01:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfNwjSMauDQ85mzygTguVk3LpUvmBdqU1PjDUVgybcAVwRk6u0E5I3AKF20erJ8guOexlYJQ==
X-Received: by 2002:a17:906:4f19:: with SMTP id t25mr44743191eju.176.1634720488551;
        Wed, 20 Oct 2021 02:01:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q11sm820275edv.80.2021.10.20.02.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 02:01:28 -0700 (PDT)
Message-ID: <b5bd6c72-9032-1267-d5a5-3fa628e6aad5@redhat.com>
Date:   Wed, 20 Oct 2021 11:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [helgaas-pci:for-linus 1/1] arch/x86/include/asm/pci_x86.h:142:8:
 warning: '__gnu_inline__' attribute only applies to functions
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <202110201321.kUDqiXb2-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202110201321.kUDqiXb2-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/20/21 07:28, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
> head:   f10507a66e36dde76d71bef8ce6e1c873f441616
> commit: f10507a66e36dde76d71bef8ce6e1c873f441616 [1/1] x86/PCI: Ignore E820 reservations for bridge windows on newer systems
> config: i386-buildonly-randconfig-r004-20211019 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 92a0389b0425a9535a99a0ce13ba0eeda2bce7ad)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=f10507a66e36dde76d71bef8ce6e1c873f441616
>         git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>         git fetch --no-tags helgaas-pci for-linus
>         git checkout f10507a66e36dde76d71bef8ce6e1c873f441616
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/x86/kernel/resource.c:4:
>    arch/x86/include/asm/pci_x86.h:99:8: error: unknown type name 'raw_spinlock_t'
>    extern raw_spinlock_t pci_config_lock;
>           ^
>    arch/x86/include/asm/pci_x86.h:135:19: error: expected ';' after top level declarator
>    extern void __init dmi_check_pciprobe(void);
>                      ^
>                      ;
>    arch/x86/include/asm/pci_x86.h:136:19: error: expected ';' after top level declarator
>    extern void __init dmi_check_skip_isa_align(void);
>                      ^
>                      ;
>    arch/x86/include/asm/pci_x86.h:142:8: error: 'inline' can only appear on functions
>    static inline int  __init pci_acpi_init(void)
>           ^
>    include/linux/compiler_types.h:149:16: note: expanded from macro 'inline'
>    #define inline inline __gnu_inline __inline_maybe_unused notrace
>                   ^
>    In file included from arch/x86/kernel/resource.c:4:
>>> arch/x86/include/asm/pci_x86.h:142:8: warning: '__gnu_inline__' attribute only applies to functions [-Wignored-attributes]
>    include/linux/compiler_types.h:149:23: note: expanded from macro 'inline'
>    #define inline inline __gnu_inline __inline_maybe_unused notrace
>                          ^
>    include/linux/compiler_attributes.h:152:56: note: expanded from macro '__gnu_inline'
>    #define __gnu_inline                    __attribute__((__gnu_inline__))
>                                                           ^
>    In file included from arch/x86/kernel/resource.c:4:
>>> arch/x86/include/asm/pci_x86.h:142:8: warning: '__no_instrument_function__' attribute only applies to functions and Objective-C methods [-Wignored-attributes]
>    include/linux/compiler_types.h:149:58: note: expanded from macro 'inline'
>    #define inline inline __gnu_inline __inline_maybe_unused notrace
>                                                             ^
>    include/linux/compiler_types.h:129:34: note: expanded from macro 'notrace'
>    #define notrace                 __attribute__((__no_instrument_function__))
>                                                   ^
>    In file included from arch/x86/kernel/resource.c:4:
>    arch/x86/include/asm/pci_x86.h:142:20: error: redefinition of '__init' with a different type: 'int' vs 'void'
>    static inline int  __init pci_acpi_init(void)
>                       ^
>    arch/x86/include/asm/pci_x86.h:136:13: note: previous declaration is here
>    extern void __init dmi_check_skip_isa_align(void);
>                ^
>    arch/x86/include/asm/pci_x86.h:142:26: error: expected ';' after top level declarator
>    static inline int  __init pci_acpi_init(void)
>                             ^
>                             ;
>    arch/x86/include/asm/pci_x86.h:148:12: error: redeclaration of '__init' with a different type: 'int' vs 'void'
>    extern int __init pcibios_init(void);
>               ^
>    arch/x86/include/asm/pci_x86.h:136:13: note: previous declaration is here
>    extern void __init dmi_check_skip_isa_align(void);
>                ^
>    arch/x86/include/asm/pci_x86.h:148:18: error: expected ';' after top level declarator
>    extern int __init pcibios_init(void);
>                     ^
>                     ;
>    arch/x86/include/asm/pci_x86.h:168:12: error: redeclaration of '__init' with a different type: 'int' vs 'void'
>    extern int __init pci_mmcfg_arch_init(void);
>               ^
>    arch/x86/include/asm/pci_x86.h:136:13: note: previous declaration is here
>    extern void __init dmi_check_skip_isa_align(void);
>                ^
>    arch/x86/include/asm/pci_x86.h:168:18: error: expected ';' after top level declarator
>    extern int __init pci_mmcfg_arch_init(void);
>                     ^
>                     ;
>    arch/x86/include/asm/pci_x86.h:169:19: error: expected ';' after top level declarator
>    extern void __init pci_mmcfg_arch_free(void);
>                      ^
>                      ;
>    arch/x86/include/asm/pci_x86.h:176:33: error: redeclaration of '__init' with a different type: 'struct pci_mmcfg_region *' vs 'void'
>    extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
>                                    ^
>    arch/x86/include/asm/pci_x86.h:169:13: note: previous declaration is here
>    extern void __init pci_mmcfg_arch_free(void);
>                ^
>    arch/x86/include/asm/pci_x86.h:176:39: error: expected ';' after top level declarator
>    extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
>                                          ^
>                                          ;
>    2 warnings and 13 errors generated.


The issue here is that <asm/pci_x86.h> is now included from
arch/x86/kernel/resource.c and it seems that that file depends on some other
headers already being included.

I'm reproducing these errors now and I will provide a fix when I'm done.

Regards,

Hans



> 
> 
> vim +/__gnu_inline__ +142 arch/x86/include/asm/pci_x86.h
> 
> 8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter  2008-07-02  137  
> 8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter  2008-07-02  138  /* some common used subsys_initcalls */
> 5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya      2018-12-19  139  #ifdef CONFIG_PCI
> 8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter  2008-07-02  140  extern int __init pci_acpi_init(void);
> 5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya      2018-12-19  141  #else
> 5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya      2018-12-19 @142  static inline int  __init pci_acpi_init(void)
> 5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya      2018-12-19  143  {
> 5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya      2018-12-19  144  	return -EINVAL;
> 5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya      2018-12-19  145  }
> 5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya      2018-12-19  146  #endif
> ab3b37937e8f4f arch/x86/include/asm/pci_x86.h Thomas Gleixner 2009-08-29  147  extern void __init pcibios_irq_init(void);
> 8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter  2008-07-02  148  extern int __init pcibios_init(void);
> b72d0db9dd41da arch/x86/include/asm/pci_x86.h Thomas Gleixner 2009-08-29  149  extern int pci_legacy_init(void);
> 9325a28ce2fa7c arch/x86/include/asm/pci_x86.h Thomas Gleixner 2009-08-29  150  extern void pcibios_fixup_irqs(void);
> 5e544d618f0fb2 arch/i386/pci/pci.h            Andi Kleen      2006-09-26  151  
> 
> :::::: The code at line 142 was first introduced by commit
> :::::: 5d32a66541c4683456507481a0944ed2985e75c7 PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set
> 
> :::::: TO: Sinan Kaya <okaya@kernel.org>
> :::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

