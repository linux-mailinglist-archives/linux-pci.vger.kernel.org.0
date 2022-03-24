Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A587E4E69E0
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 21:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350748AbiCXUgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 16:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244145AbiCXUgL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 16:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4136A8EDE
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 13:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648154076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hbu1HvrkM4W0PJLtiQLJ6l3oZ/ihtt3CiDq5Shp1hyc=;
        b=HDMtSCsm7s6MKB2ObiaeJWr8jAz2qEEq7Nc9MOpG9QcFMRy4/p+sERmKOSA7Se15K85rsD
        PZ2LHDG57QM+IlOFhWO7b8j2Q1xSsEKcLHBZirInGTVCSf6OCmxqpDVrZAB+8wvVAzTJQ4
        v3EHk5dL26s690H48aJOVUBo3uE9qPY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-VJpnG3fgN9S8cdmyUdMJnw-1; Thu, 24 Mar 2022 16:34:33 -0400
X-MC-Unique: VJpnG3fgN9S8cdmyUdMJnw-1
Received: by mail-ej1-f69.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso3043512ejc.22
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 13:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hbu1HvrkM4W0PJLtiQLJ6l3oZ/ihtt3CiDq5Shp1hyc=;
        b=EQIO9uhNdRuGSgFYH4TqTOKvmqQjpc7AsWTsIb4nusJKWhQnzu5hWOKb0ghQr2iSzK
         IfSli40jD37aPr6CgMzqIcP3oYsfw9XRZzZsL2zY7/hGq/VHVmtRJhRQYsXS/Bf+ia/Y
         kGmm99Ws8AALBU399so5VXP+uiz+kSkM+RhVRh6i2Spt6Mz1+b2ST++oQbmNgeKoen/h
         60K4P9yKp+OUQDrs3ru3fV1eJwAf2k2fgdtJaz+wn7Z68zKxCaF0uD8EuTLGVWd9x04k
         13Gxv6ybtiorMz/P1e5sMpnNr3h2LEB6U8jbojjwYerHpUca3dwp86sp/cnyFezwFehb
         w6LA==
X-Gm-Message-State: AOAM532CCPZpAhmDCam/hxAqj5rDxU+2xiqXWEDyNoDGuDNBkSrWOBQd
        xfEOIAdhdSPEGpa1TAMIyvT2dAFZI6ea6EzyaD199uKLEar8yHqXmwPukAEKFwDkQdboDUAgWKs
        2HS4fzx6WjuPkjUs/wB68
X-Received: by 2002:a17:906:b102:b0:6db:1487:e73 with SMTP id u2-20020a170906b10200b006db14870e73mr7510778ejy.474.1648154071826;
        Thu, 24 Mar 2022 13:34:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMaYLqaPk9H376S8Ft5rBlcte0m3jo1RxWq5SYASB+4hmHzEINpMmfEMgp3zf79R+tY73bDw==
X-Received: by 2002:a17:906:b102:b0:6db:1487:e73 with SMTP id u2-20020a170906b10200b006db14870e73mr7510749ejy.474.1648154071442;
        Thu, 24 Mar 2022 13:34:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id i11-20020a05640242cb00b0041922d3ce3bsm2010019edc.26.2022.03.24.13.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 13:34:31 -0700 (PDT)
Message-ID: <4e9fca2f-0af1-3684-6c97-4c35befd5019@redhat.com>
Date:   Thu, 24 Mar 2022 21:34:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org
References: <623c13ec.1c69fb81.8cbdb.5a7a@mx.google.com>
 <Yjyv03JsetIsTJxN@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yjyv03JsetIsTJxN@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mark,

Thank you for the report.

On 3/24/22 18:52, Mark Brown wrote:
> On Wed, Mar 23, 2022 at 11:47:08PM -0700, KernelCI bot wrote:
> 
> The KernelCI bisection bot has identified commit 5949965ec9340cfc0e
> ("x86/PCI: Preserve host bridge windows completely covered by E820")
> as causing a boot regression in next on asus-C523NA-A20057-coral (a
> Chromebook AIUI).  Unfortunately there's no useful output when starting
> the kernel.  I've left the full report below including links to the web
> dashboard.
> 
> The last successful boot in -next had this log:
> 
>    https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html

So the interesting bits from this log are:

 1839 17:54:41.406548  <6>[    0.000000] BIOS-provided physical RAM map:
 1840 17:54:41.413121  <6>[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] type 16
 1841 17:54:41.419712  <6>[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
 1842 17:54:41.430192  <6>[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
 1843 17:54:41.436207  <6>[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000000fffffff] usable
 1844 17:54:41.446353  <6>[    0.000000] BIOS-e820: [mem 0x0000000010000000-0x0000000012150fff] reserved
 1845 17:54:41.453290  <6>[    0.000000] BIOS-e820: [mem 0x0000000012151000-0x000000007a9fcfff] usable
 1846 17:54:41.459966  <6>[    0.000000] BIOS-e820: [mem 0x000000007a9fd000-0x000000007affffff] type 16
 1847 17:54:41.469549  <6>[    0.000000] BIOS-e820: [mem 0x000000007b000000-0x000000007fffffff] reserved
 1848 17:54:41.476685  <6>[    0.000000] BIOS-e820: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
 1849 17:54:41.486439  <6>[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
 1850 17:54:41.492994  <6>[    0.000000] BIOS-e820: [mem 0x00000000fed10000-0x00000000fed17fff] reserved
 1851 17:54:41.503008  <6>[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000017fffffff] usable
...
 2030 17:54:42.809183  <6>[    0.313771] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
 2031 17:54:42.819092  <6>[    0.314424] pci_bus 0000:00: root bus resource [mem 0x7b800000-0xe0000000 window]

Since the main [mem 0x7b800000-0xe0000000 window] is not fully covered by a single e820 entry, for that
resource there should be no change.

But the ISA MMIO window: [mem 0x000a0000-0x000bffff window] is fully covered by:

BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved

So that will now become available as memory to assign some resources to, where before it was
not.

So I guess we should try adding a patch to skip the "fully covered" tests for ISA MMIO space
and see if that helps ?

Bjorn do you agree?

Mark, if one of use writes a test patch, can you get that Asus machine to boot a
kernel build from next + the test patch ?

Regards,

Hans





> 
> I'd also note that the machine hp-x360-12b-n4000-octopus appears to have
> started failing at the same time with similar symptoms, failing log:
> 
>    https://storage.kernelci.org/next/master/next-20220324/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-n4000-octopus.html
> 
> and passing log:
> 
>    https://storage.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-n4000-octopus.html
> 
> though we didn't get a bisect for that yet.  That's also a Chromebook.
> 
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>> * This automated bisection report was sent to you on the basis  *
>> * that you may be involved with the breaking commit it has      *
>> * found.  No manual investigation has been done to verify it,   *
>> * and the root cause of the problem may be somewhere else.      *
>> *                                                               *
>> * If you do send a fix, please include this trailer:            *
>> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
>> *                                                               *
>> * Hope this helps!                                              *
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>
>> next/master bisection: baseline.login on asus-C523NA-A20057-coral
>>
>> Summary:
>>   Start:      f8833a2b2356 Add linux-next specific files for 20220322
>>   Plain log:  https://storage.kernelci.org/next/master/next-20220322/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.txt
>>   HTML log:   https://storage.kernelci.org/next/master/next-20220322/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-asus-C523NA-A20057-coral.html
>>   Result:     5949965ec934 x86/PCI: Preserve host bridge windows completely covered by E820
>>
>> Checks:
>>   revert:     PASS
>>   verify:     PASS
>>
>> Parameters:
>>   Tree:       next
>>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>   Branch:     master
>>   Target:     asus-C523NA-A20057-coral
>>   CPU arch:   x86_64
>>   Lab:        lab-collabora
>>   Compiler:   gcc-10
>>   Config:     x86_64_defconfig+x86-chromebook
>>   Test case:  baseline.login
>>
>> Breaking commit found:
>>
>> -------------------------------------------------------------------------------
>> commit 5949965ec9340cfc0e65f7d8a576b660b26e2535
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Thu Mar 3 18:03:30 2022 -0600
>>
>>     x86/PCI: Preserve host bridge windows completely covered by E820
>>     
>>     Many folks have reported PCI devices not working.  It could affect any
>>     device, but most reports are for Thunderbolt controllers on Lenovo Yoga and
>>     Clevo Barebone laptops and the touchpad on Lenovo IdeaPads.
>>     
>>     In every report, a region in the E820 table entirely encloses a PCI host
>>     bridge window from _CRS, and because of 4dc2287c1805 ("x86: avoid E820
>>     regions when allocating address space"), we ignore the entire window,
>>     preventing us from assigning space to PCI devices.
>>     
>>     For example, the dmesg log [2] from bug report [1] shows:
>>     
>>       BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>>       pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>>       pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>>     
>>     The efi=debug dmesg log [3] from the same report shows the EFI memory map
>>     entries that created the E820 map:
>>     
>>       efi: mem47: [Reserved |   |WB|WT|WC|UC] range=[0x4bc50000-0x5fffffff]
>>       efi: mem48: [Reserved |   |WB|  |  |UC] range=[0x60000000-0x60ffffff]
>>       efi: mem49: [Reserved |   |  |  |  |  ] range=[0x61000000-0x653fffff]
>>       efi: mem50: [MMIO     |RUN|  |  |  |UC] range=[0x65400000-0xcfffffff]
>>     
>>     4dc2287c1805 ("x86: avoid E820 regions when allocating address space")
>>     works around issues where _CRS contains non-window address space that can't
>>     be used for PCI devices.  It does this by removing E820 regions from host
>>     bridge windows.  But in these reports, the E820 region covers the entire
>>     window, so 4dc2287c1805 makes it completely unusable.
>>     
>>     Per UEFI v2.8, sec 7.2, the EfiMemoryMappedIO type means:
>>     
>>       Used by system firmware to request that a memory-mapped IO region be
>>       mapped by the OS to a virtual address so it can be accessed by EFI
>>       runtime services.
>>     
>>     A host bridge window is definitely a memory-mapped IO region, and EFI
>>     runtime services may need to access it, so I don't think we can argue that
>>     this is a firmware defect.
>>     
>>     Instead, change the 4dc2287c1805 strategy so it only removes E820 regions
>>     when they overlap *part* of a host bridge window on the assumption that a
>>     partial overlap is really register space, not part of the window proper.
>>     
>>     If an E820 region covers the entire window from _CRS, assume the _CRS
>>     window is correct and do nothing.
>>     
>>     [1] https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>>     [2] https://bugzilla.redhat.com/attachment.cgi?id=1711424
>>     [3] https://bugzilla.redhat.com/attachment.cgi?id=1861407
>>     
>>     BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
>>     BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214259
>>     BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>>     BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
>>     BugLink: https://bugs.launchpad.net/bugs/1878279
>>     BugLink: https://bugs.launchpad.net/bugs/1931715
>>     BugLink: https://bugs.launchpad.net/bugs/1932069
>>     BugLink: https://bugs.launchpad.net/bugs/1921649
>>     Fixes: 4dc2287c1805 ("x86: avoid E820 regions when allocating address space")
>>     Link: https://lore.kernel.org/r/20220228105259.230903-1-hdegoede@redhat.com
>>     Based-on-patch-by: Hans de Goede <hdegoede@redhat.com>
>>     Link: https://lore.kernel.org/r/20220304035110.988712-4-helgaas@kernel.org
>>     Reported-by: Benoit Grégoire <benoitg@coeus.ca>   # BZ 206459
>>     Reported-by: wse@tuxedocomputers.com              # BZ 214259
>>     Tested-by: Matt Hansen <2lprbe78@duck.com>
>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>     Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>     Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>     Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
>> index 7378ea146976..90203217c359 100644
>> --- a/arch/x86/kernel/resource.c
>> +++ b/arch/x86/kernel/resource.c
>> @@ -39,6 +39,21 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
>>  		e820_start = entry->addr;
>>  		e820_end = entry->addr + entry->size - 1;
>>  
>> +		/*
>> +		 * If an E820 entry covers just part of the resource, we
>> +		 * assume E820 is telling us about something like host
>> +		 * bridge register space that is unavailable for PCI
>> +		 * devices.  But if it covers the *entire* resource, it's
>> +		 * more likely just telling us that this is MMIO space, and
>> +		 * that doesn't need to be removed.
>> +		 */
>> +		if (e820_start <= avail->start && avail->end <= e820_end) {
>> +			dev_info(dev, "resource %pR fully covered by e820 entry [mem %#010Lx-%#010Lx]\n",
>> +				 avail, e820_start, e820_end);
>> +
>> +			continue;
>> +		}
>> +
>>  		resource_clip(avail, e820_start, e820_end);
>>  		if (orig.start != avail->start || orig.end != avail->end) {
>>  			dev_info(dev, "clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
>> -------------------------------------------------------------------------------
>>
>>
>> Git bisection log:
>>
>> -------------------------------------------------------------------------------
>> git bisect start
>> # good: [5628b8de1228436d47491c662dc521bc138a3d43] Merge tag 'random-5.18-rc1-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random
>> git bisect good 5628b8de1228436d47491c662dc521bc138a3d43
>> # bad: [f8833a2b23562be2dae91775127c8014c44d8566] Add linux-next specific files for 20220322
>> git bisect bad f8833a2b23562be2dae91775127c8014c44d8566
>> # bad: [d2de72259f3d22054272217eac92e624835bfc3b] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
>> git bisect bad d2de72259f3d22054272217eac92e624835bfc3b
>> # bad: [5920db3e4b50218dcf2101f3d87c3b69a1120981] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
>> git bisect bad 5920db3e4b50218dcf2101f3d87c3b69a1120981
>> # bad: [b579dc07dce4637b7f2a3fb84394ebbd6666a81f] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
>> git bisect bad b579dc07dce4637b7f2a3fb84394ebbd6666a81f
>> # bad: [b5475dd9fab03e6867abad00ecb98e0d3827ad31] Merge branch 'for-next' of git://git.armlinux.org.uk/~rmk/linux-arm.git
>> git bisect bad b5475dd9fab03e6867abad00ecb98e0d3827ad31
>> # good: [7b72f3bb0907319e15765ae9dcf1f15fdd112bcf] Merge remote-tracking branch 'asoc/for-5.17' into asoc-linus
>> git bisect good 7b72f3bb0907319e15765ae9dcf1f15fdd112bcf
>> # bad: [077dc6bc0658177057bfd69ef3a990e6d8d32146] Merge branch 'gpio/for-current' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
>> git bisect bad 077dc6bc0658177057bfd69ef3a990e6d8d32146
>> # good: [fd11727eec0dd95ee1b7d8f9f10ee60678eecc29] crypto: hisilicon/qm - fix memset during queues clearing
>> git bisect good fd11727eec0dd95ee1b7d8f9f10ee60678eecc29
>> # good: [646b907e1559f006c79a752ee3eebe220ceb983d] Merge tag 'asoc-v5.18' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus
>> git bisect good 646b907e1559f006c79a752ee3eebe220ceb983d
>> # bad: [f8ed0b7c999405bd12ab9ebb0765e2baa7eb6184] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>> git bisect bad f8ed0b7c999405bd12ab9ebb0765e2baa7eb6184
>> # good: [9fd75b66b8f68498454d685dc4ba13192ae069b0] ax25: Fix refcount leaks caused by ax25_cb_del()
>> git bisect good 9fd75b66b8f68498454d685dc4ba13192ae069b0
>> # good: [3fd177beee75eb2d7e5b19992e8c90eb1a141432] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>> git bisect good 3fd177beee75eb2d7e5b19992e8c90eb1a141432
>> # good: [09005bef55291a99b491a47ce676dfb4f40f8edd] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
>> git bisect good 09005bef55291a99b491a47ce676dfb4f40f8edd
>> # good: [d13f73e9108a75209d03217d60462f51092499fe] x86/PCI: Log host bridge window clipping for E820 regions
>> git bisect good d13f73e9108a75209d03217d60462f51092499fe
>> # bad: [5949965ec9340cfc0e65f7d8a576b660b26e2535] x86/PCI: Preserve host bridge windows completely covered by E820
>> git bisect bad 5949965ec9340cfc0e65f7d8a576b660b26e2535
>> # first bad commit: [5949965ec9340cfc0e65f7d8a576b660b26e2535] x86/PCI: Preserve host bridge windows completely covered by E820
>> -------------------------------------------------------------------------------
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Groups.io Links: You receive all messages sent to this group.
>> View/Reply Online (#25006): https://groups.io/g/kernelci-results/message/25006
>> Mute This Topic: https://groups.io/mt/89994186/1131744
>> Group Owner: kernelci-results+owner@groups.io
>> Unsubscribe: https://groups.io/g/kernelci-results/unsub [broonie@kernel.org]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
>>

