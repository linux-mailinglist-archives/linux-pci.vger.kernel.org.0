Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2636416C1
	for <lists+linux-pci@lfdr.de>; Sat,  3 Dec 2022 13:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLCMpP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Dec 2022 07:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLCMpO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Dec 2022 07:45:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B59D17435
        for <linux-pci@vger.kernel.org>; Sat,  3 Dec 2022 04:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670071454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ftKoBSk9SQAk/6weki4c2aOPY4exs8cyFZvUVVU/uc=;
        b=GdV2H7kch9en/1sqB8sO2GbccZV60zUv1LUaMYe4mAXnxgw+/h7sW5frspfiTnU2VVNKsA
        YB3rBFoMwWu7wT/cI62uBg5FFuhXEPtI0PSw/QaWy+dzedIGxpeDIBCE0tZhqtr01oROWU
        Ztz5Sxial1k7PA5Dp7BLydZjjr6t7aU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-347-FdHqRPp7Ppuf78nI4PAgwQ-1; Sat, 03 Dec 2022 07:44:13 -0500
X-MC-Unique: FdHqRPp7Ppuf78nI4PAgwQ-1
Received: by mail-ej1-f70.google.com with SMTP id gb8-20020a170907960800b007bef177dddeso5147510ejc.10
        for <linux-pci@vger.kernel.org>; Sat, 03 Dec 2022 04:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ftKoBSk9SQAk/6weki4c2aOPY4exs8cyFZvUVVU/uc=;
        b=shEK3T46UShbxGDx9UX0IP7Jmum/K+iA1OySHyjVvpOC6757LBy+LsH8j8cpBqGTga
         Cn2XyPtafXSmgnpTZodFUEk+erKbl76IgnE3LwA9pgPu27exopkefW+H+njd923uAeyy
         +MgGVsjIEYcPq6yrztQv6ZsNwLP56ArlhnHbOpS0Bzv/g4AEdPlnzGu+1rUsYd+EKqJ9
         7Nk+bxjytl/5NDOZydkqIz+jPEJ9HH6HTSHmYyjcd7IGeKR2jLw0siLW43MHv+Gl0MzZ
         6OQYIFE+p3gzvr3iaiszHSW1XgrfucNAzoTaz9qlO58GlTkTBfuyVUYlMkkPGDcxN3p8
         I2xQ==
X-Gm-Message-State: ANoB5pmR/8TBI9G+SEk/kJpz3CmKND3l1+8zXCrd30cSNppyPTP6ZHJf
        JKgt+6cBolzpZ693CdvNovEN0gbrLqlZUJQ/3uItHim0XT3B3MpVkFOkkQkgV0UQ61+FTPOLJH4
        GHKfgEIHwrj5tq/q48bdJ
X-Received: by 2002:a17:906:22d0:b0:7b2:a7aa:173d with SMTP id q16-20020a17090622d000b007b2a7aa173dmr4306582eja.140.1670071452253;
        Sat, 03 Dec 2022 04:44:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5yrCijzMjkr+9SinSB3NRMLGy4YUrpAHe8ZzGiu5RPvKykX0LC62O2JjotzpBPLXd1gXXBaw==
X-Received: by 2002:a17:906:22d0:b0:7b2:a7aa:173d with SMTP id q16-20020a17090622d000b007b2a7aa173dmr4306572eja.140.1670071452023;
        Sat, 03 Dec 2022 04:44:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090618aa00b007bd0bb6423csm4075077ejf.199.2022.12.03.04.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Dec 2022 04:44:11 -0800 (PST)
Message-ID: <c7fd3e67-89cf-17ed-c680-f5d44a6952e7@redhat.com>
Date:   Sat, 3 Dec 2022 13:44:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/4] PCI: Continue E820 vs host bridge window saga
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221202211838.1061278-1-helgaas@kernel.org>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221202211838.1061278-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 12/2/22 22:18, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> When allocating space for PCI BARs, Linux avoids allocating space mentioned
> in the E820 map.  This was originally done by 4dc2287c1805 ("x86: avoid
> E820 regions when allocating address space") to work around BIOS defects
> that included unusable space in host bridge _CRS.
> 
> Some recent machines use EfiMemoryMappedIO for PCI MMCONFIG and host bridge
> apertures, and bootloaders and EFI stubs convert those to E820 regions,
> which means we can't allocate space for hot-added PCI devices (often a
> dock) or for devices the BIOS didn't configure (often a touchpad)
> 
> The current strategy is to add DMI quirks that disable the E820 filtering
> on these machines and to disable it entirely starting with 2023 BIOSes:
> 
>   d341838d776a ("x86/PCI: Disable E820 reserved region clipping via quirks")
>   0ae084d5a674 ("x86/PCI: Disable E820 reserved region clipping starting in 2023")
> 
> But the quirks are problematic because it's really hard to list all the
> machines that need them.
> 
> This series is an attempt at a more generic approach.  I'm told by firmware
> folks that EfiMemoryMappedIO means "the OS should map this area so EFI
> runtime services can use it in virtual mode," but does not prevent the OS
> from using it.
> 
> The first patch removes any EfiMemoryMappedIO areas from the E820 map.
> This doesn't affect any virtual mapping of those areas (that would have to
> be done directly from the EFI memory map) but it means Linux can allocate
> space for PCI MMIO.
> 
> The rest are basically cosmetic log message changes.

Thank you for working on this. I'm a bit worried about this series though.

The 2 things which I worry about are:


1. I think this will not help when people boot in BIOS (CSM) mode rather
then UEFI mode which quite a few Linux users still do because they learned
to do this years ago when Linux EFI support (and EFI fw itself) was still
a bit in flux.

IIRC from the last time we looked at this in CSM mode the BIOS itself
translates the EfiMemoryMappedIO areas to reserved E820 regions. So when
people use the BIOS CSM mode to boot, then this patch will not help
since the kernel lacks the info to do the translation.\

We may also hit the same case when the bootloader has done the
translation which I believe is what upstream grub does. Fedora grub
has been patched to use the kernel EFI stub when booting a kernel
on EFI, so just an EFI equivalent of "exec" on the kernel EFI binary.

Where as upstream grub does a more BIOS like boot, where it skips the
EFI stub and instead does a whole bunch of stuff itself and then
jumps to the kernel's start vector. So this might also not work with
upstream grub, which is what I believe Ubuntu and Debian use.

Although I case in this case we will still have access to the EFI
memory map and I see that your patch removes the entries stemming
from the EfiMemoryMappedIO areas from the E820 map, rather then
never adding them. So I guess this will also work in the case
when the bootloader has done the translation (leaving just
the BIOS CSM case as an issue) ?

This won't cause regressions, but it does mean that e.g. the
touchpad i2c-controller / hotplugged PCI devices will still not
work when booted in BIOS (CSM) mode / through upstream grub.

I have asked the reporter of:

https://bugzilla.redhat.com/show_bug.cgi?id=1868899

To do a BIOS mode boot of a Fedora 37 live USB and then collect
dmesg output, then we can check if that indeed has the
EfiMemoryMappedIO areas as reserved E820 regions in a way where
we cannot identify them anymore since we don't have access to
the EFI memory map in this case.


2. I am afraid that now allowing PCI MMIO space to be allocated
in regions marked as EfiMemoryMappedIO will cause regressions
on some systems. Specifically when I tried something similar
the last time I looked at this (using the BIOS date cut-off
approach IIRC) there was a suspend/resume regression on
a Lenovo ThinkPad X1 carbon (20A7) model:

https://bugzilla.redhat.com/show_bug.cgi?id=2029207

Back then I came to the conclusion that the problem is that not
avoiding the EfiMemoryMappedIO regions caused PCI MMIO space to
be allocated in the 0xdfa00000 - 0xdfa10000 range which is
listed in the EFI memmap as:

[    0.000000] efi: mem46: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)

And with current kernels with the extra logging added for this
the following is logged related to this:

[    0.326504] acpi PNP0A08:00: clipped [mem 0xdfa00000-0xfebfffff window] to [mem 0xdfa10000-0xfebfffff window] for e820 entry [mem 0xdceff000-0xdfa0ffff]

I believe patch 1/4 of this set will make this clipping go away,
re-introducing the suspend/resume problem.

I will reach out to the reporter and see if I can get them to
test this patch-set.

Regards,

Hans


