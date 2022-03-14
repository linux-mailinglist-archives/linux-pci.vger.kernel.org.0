Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60864D7FB1
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 11:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbiCNKTe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 06:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbiCNKTe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 06:19:34 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B1733A0A
        for <linux-pci@vger.kernel.org>; Mon, 14 Mar 2022 03:18:23 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id g26so29647297ybj.10
        for <linux-pci@vger.kernel.org>; Mon, 14 Mar 2022 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wDGDeehEZPGpze0RO6FQvp0IceNJoA8QmK4KQwTNeLI=;
        b=XB0hyhTUjLV57hBJO7gtymm36NYBUxu8UTErl31LbAmygBTfvoqRAd0cZItho7Y9qE
         r2rT7LRTjtpLEFFSRZ48lcUdYK7HB6Iun+AFIh0D9jHTcfBpHKRrn6ZFx9OCinTfdcSZ
         Co0JzLHP8WfwBwGLfCP5QN/S4Q96Uw+bj+ZlOaUoGPkpAqeG5XxaosrSERFFUfD3W3iL
         yOc0KkwT1brnLQhv7OMUOpQC+xzxt2f1pEPtFuW2FDw6eaKeZPShVjLzDdIs0EN1G1RD
         nBsm68xuRkJ3QsQYeA9hc3LJiLCiovX/lqWhivrrKy9PdsqDr7nQUJXHrB24DLFwYiVJ
         YOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wDGDeehEZPGpze0RO6FQvp0IceNJoA8QmK4KQwTNeLI=;
        b=DsWRYkKSbG3sTD7XXXXFyL2Etrc7Ixca8x/idZTcvWfiVZ0tbFjkycC9e/1ogXqxAQ
         9elNOw1XuUQbxdtZdr4PC0VAjNeHecFcuee8MKun1yF2ZIM2UQWeEMJPyXhpPb075zz3
         qceXkYAsm/RHU6dmBrOmitqs1Mq87XhR3UZ0oNn7rcvKb5DuHqE6zZJlPtF5GFoOw6Pe
         EM46FY3STcZIiGXqEdOhSlGL/6dTElBCsJnlRtDJRHof1KHqkQb7deH5/HOqqTqXX67L
         lBsjbIdFmnUAaPJphkkLhP40/EbkHQEHy229nLdrwGGX8QbsY8DAJ2wuRsofrtEAAxsX
         XUfA==
X-Gm-Message-State: AOAM530sx9l6B+BJiuezB/MdQ9LTPsuvROku0/cNak42lVcyWJR5qbJJ
        MoO57n9OHAi5E8M5OPkWUki6MkLAoYMg5Fv/Lj7bOp/2ezfmq5fN
X-Google-Smtp-Source: ABdhPJx37yGfdMLVDH3YVC2JGDsN3FPzTfyd52eymvP0wDjULht1ChFDKmjqIKQb1l3NsJkbdMVYDM/z+Q1SIHZxs/w=
X-Received: by 2002:a25:5090:0:b0:628:b76b:b9d3 with SMTP id
 e138-20020a255090000000b00628b76bb9d3mr17135646ybb.128.1647253103104; Mon, 14
 Mar 2022 03:18:23 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 14 Mar 2022 15:48:12 +0530
Message-ID: <CA+G9fYtX3RzYbpZRAktPNfbP51obcBi=_PJZ6RT-x+BnE-9ESQ@mail.gmail.com>
Subject: [next] pci_x86.h:105:8: error: unknown type name 'raw_spinlock_t'
To:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     PCI <linux-pci@vger.kernel.org>, X86 ML <x86@kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Linux next-20220310 i386 build failed due to below warnings / errors.

  CC      arch/x86/kernel/resource.o
In file included from arch/x86/kernel/resource.c:4:0:
arch/x86/include/asm/pci_x86.h:105:8: error: unknown type name 'raw_spinlock_t'
 extern raw_spinlock_t pci_config_lock;
        ^~~~~~~~~~~~~~
arch/x86/include/asm/pci_x86.h:141:20: error: expected '=', ',', ';',
'asm' or '__attribute__' before 'dmi_check_pciprobe'
 extern void __init dmi_check_pciprobe(void);
                    ^~~~~~~~~~~~~~~~~~
arch/x86/include/asm/pci_x86.h:142:20: error: expected '=', ',', ';',
'asm' or '__attribute__' before 'dmi_check_skip_isa_align'
 extern void __init dmi_check_skip_isa_align(void);
                    ^~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/include/asm/pci_x86.h:146:19: error: expected '=', ',', ';',
'asm' or '__attribute__' before 'pci_acpi_init'
 extern int __init pci_acpi_init(void);
                   ^~~~~~~~~~~~~
arch/x86/include/asm/pci_x86.h:153:20: error: expected '=', ',', ';',
'asm' or '__attribute__' before 'pcibios_irq_init'
 extern void __init pcibios_irq_init(void);
                    ^~~~~~~~~~~~~~~~
arch/x86/include/asm/pci_x86.h:154:19: error: expected '=', ',', ';',
'asm' or '__attribute__' before 'pcibios_init'
 extern int __init pcibios_init(void);
                   ^~~~~~~~~~~~
arch/x86/include/asm/pci_x86.h:174:19: error: expected '=', ',', ';',
'asm' or '__attribute__' before 'pci_mmcfg_arch_init'
 extern int __init pci_mmcfg_arch_init(void);
                   ^~~~~~~~~~~~~~~~~~~
arch/x86/include/asm/pci_x86.h:175:20: error: expected '=', ',', ';',
'asm' or '__attribute__' before 'pci_mmcfg_arch_free'
 extern void __init pci_mmcfg_arch_free(void);
                    ^~~~~~~~~~~~~~~~~~~
arch/x86/include/asm/pci_x86.h:182:40: error: expected '=', ',', ';',
'asm' or '__attribute__' before 'pci_mmconfig_add'
 extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
                                        ^~~~~~~~~~~~~~~~
  CC      net/core/filter.o
make[2]: *** [scripts/Makefile.build:288: arch/x86/kernel/resource.o] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


--
Linaro LKFT
https://lkft.linaro.org
[1]  https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-core2-32,label=docker-buster-lkft/1207/consoleText
