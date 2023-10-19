Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3210F7CEDB7
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 03:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjJSBul convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 18 Oct 2023 21:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSBuj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 21:50:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D059F;
        Wed, 18 Oct 2023 18:50:30 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39J1npUQ32308559, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39J1npUQ32308559
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 09:49:52 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 19 Oct 2023 09:49:51 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 19 Oct 2023 09:49:50 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Thu, 19 Oct 2023 09:49:50 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on PCIe Link Down
Thread-Topic: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on
 PCIe Link Down
Thread-Index: AQHZ/+WX29Sx+yjN7keHtkFSV38Z/LBLoV4AgAIjnlCAAQSEgIABkvFw
Date:   Thu, 19 Oct 2023 01:49:50 +0000
Message-ID: <02ee7e47166a463d8d4e491b61cdd33f@realtek.com>
References: <20231016040132.23824-1-kai.heng.feng@canonical.com>
 <20231016093210.GA22952@wunner.de>
 <263982e90fc046cf977ecb8727003690@realtek.com>
 <20231018094435.GA21090@wunner.de>
In-Reply-To: <20231018094435.GA21090@wunner.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.81.100]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> [cc -= unrelated mailing lists bpf, kernel-hardening]
> 
> On Tue, Oct 17, 2023 at 10:25:39AM +0000, Ricky WU wrote:
> 
> I can only guess here as the dmesg and lspci output I requested hasn't been
> provided:
> 
> I assume that this card reader may contain a PCIe switch with a regular SD
> card reader below a first Downstream Port (which is hotplug-capable).  If an
> SD express card is inserted, the regular SD card reader disappears from the
> Downstream Port and the inserted card appears as an NVMe drive (possibly
> below a second Downstream Port, or below the first Downstream Port).
> 
> The commit message is somewhat misleading in that it links the unhandled
> page fault to card insertion.  That may be the trigger, but the root cause
> appears to be that a runtime PM request is performed asynchronously after
> the SD card reader has iounmap'ed
> pcr->remap_addr.
> 
> If that is indeed the root cause (as I suspect), the fix needs to be placed
> somewhere else.
> 
> pciehp is only one of several hotplug drivers and fixing this only in pciehp may
> leave the other hotplug drivers vulnerable to the same issue.
> 
> Unfortunately the information provided so far is insufficient to recommend a
> better fix.  It would be necessary to debug why the asynchronous RPM
> request is not canceled even though rtsx_pci_remove() runtime resumes the
> device before iounmap'ing pcr->remap_addr.
> Perhaps there's a bug in runtime PM code that causes asynchronous requests
> to not be canceled upon a pm_runtime_get_sync()?
> Or perhaps a wmb() is necessary in pci_device_remove() after setting
> pci_dev->driver = NULL?
> 
> Thanks,
> 
> Lukas

Hi Lukas,

Sorry for late, the dmesg as below 

[    0.000000] microcode: updated early: 0x96 -> 0xf4, date = 2023-02-23
[    0.000000] Linux version 6.4.0 (root@cr-desktop) (gcc (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #6 SMP PREEMPT_DYNAMIC Wed Aug 30 20:35:48 CST 2023
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.4.0 root=UUID=74fe52d0-e90f-4b0a-92f4-581b5fa98519 ro quiet splash vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[3]:  576, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  640, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1b, context size is 704 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 2032
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000005efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000005f000-0x000000000005ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000060000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007c764fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007c765000-0x000000007dfd0fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007dfd1000-0x000000007e04dfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007e04e000-0x000000007e526fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007e527000-0x000000007ed0dfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007ed0e000-0x000000007ed0efff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ed0f000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000016dffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x68808018-0x68818057] usable ==> usable
[    0.000000] e820: update [mem 0x68808018-0x68818057] usable ==> usable
[    0.000000] e820: update [mem 0x687f7018-0x68807e57] usable ==> usable
[    0.000000] e820: update [mem 0x687f7018-0x68807e57] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000005efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000005f000-0x000000000005ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000060000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x00000000687f7017] usable
[    0.000000] reserve setup_data: [mem 0x00000000687f7018-0x0000000068807e57] usable
[    0.000000] reserve setup_data: [mem 0x0000000068807e58-0x0000000068808017] usable
[    0.000000] reserve setup_data: [mem 0x0000000068808018-0x0000000068818057] usable
[    0.000000] reserve setup_data: [mem 0x0000000068818058-0x000000007c764fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007c765000-0x000000007dfd0fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007dfd1000-0x000000007e04dfff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000007e04e000-0x000000007e526fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000007e527000-0x000000007ed0dfff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007ed0e000-0x000000007ed0efff] usable
[    0.000000] reserve setup_data: [mem 0x000000007ed0f000-0x000000008fffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000016dffffff] usable
[    0.000000] efi: EFI v2.7 by American Megatrends
[    0.000000] efi: ACPI 2.0=0x7e468000 ACPI=0x7e468000 TPMFinalLog=0x7e4d1000 SMBIOS=0x7ea7a000 SMBIOS 3.0=0x7ea79000 MEMATTR=0x7955a098 ESRT=0x7adf4118 MOKvar=0x7ea92000 RNG=0x7e04d018 TPMEventLog=0x68819018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem45: MMIO range=[0xe0000000-0xefffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
[    0.000000] efi: Not removing mem46: MMIO range=[0xfe000000-0xfe010fff] (68KB) from e820 map
[    0.000000] efi: Not removing mem47: MMIO range=[0xfec00000-0xfec00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem48: MMIO range=[0xfed00000-0xfed03fff] (16KB) from e820 map
[    0.000000] efi: Not removing mem49: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
[    0.000000] efi: Remove mem50: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.1.1 present.
[    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./H370M Pro4, BIOS P3.40 10/25/2018
[    0.000000] tsc: Detected 3700.000 MHz processor
[    0.000000] tsc: Detected 3699.850 MHz TSC
[    0.000602] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000605] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000611] last_pfn = 0x16e000 max_arch_pfn = 0x400000000
[    0.000615] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000975] last_pfn = 0x7ed0f max_arch_pfn = 0x400000000
[    0.007022] found SMP MP-table at [mem 0x000fcd30-0x000fcd3f]
[    0.007032] esrt: Reserving ESRT space from 0x000000007adf4118 to 0x000000007adf4150.
[    0.007036] e820: update [mem 0x7adf4000-0x7adf4fff] usable ==> reserved
[    0.007050] Using GB pages for direct mapping
[    0.007209] Secure boot disabled
[    0.007209] RAMDISK: [mem 0x68822000-0x7153ffff]
[    0.007213] ACPI: Early table checksum verification disabled
[    0.007216] ACPI: RSDP 0x000000007E468000 000024 (v02 ALASKA)
[    0.007219] ACPI: XSDT 0x000000007E4680B0 0000DC (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007224] ACPI: FACP 0x000000007E4A7808 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.007228] ACPI: DSDT 0x000000007E468220 03F5E6 (v02 ALASKA A M I    01072009 INTL 20160527)
[    0.007231] ACPI: FACS 0x000000007E526080 000040
[    0.007233] ACPI: APIC 0x000000007E4A7920 000084 (v04 ALASKA A M I    01072009 AMI  00010013)
[    0.007236] ACPI: FPDT 0x000000007E4A79A8 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007238] ACPI: FIDT 0x000000007E4A79F0 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007241] ACPI: MCFG 0x000000007E4A7A90 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.007243] ACPI: SSDT 0x000000007E4A7AD0 000378 (v01 SataRe SataTabl 00001000 INTL 20160527)
[    0.007246] ACPI: SSDT 0x000000007E4A7E48 001B1C (v02 CpuRef CpuSsdt  00003000 INTL 20160527)
[    0.007248] ACPI: AAFT 0x000000007E4A9968 00023D (v01 ALASKA OEMAAFT  01072009 MSFT 00000097)
[    0.007251] ACPI: SSDT 0x000000007E4A9BA8 0031C6 (v02 SaSsdt SaSsdt   00003000 INTL 20160527)
[    0.007253] ACPI: HPET 0x000000007E4ACD70 000038 (v01 ALASKA A M I    00000002      01000013)
[    0.007256] ACPI: SSDT 0x000000007E4ACDA8 001C01 (v02 ALASKA CflS_Rvp 00001000 INTL 20160527)
[    0.007258] ACPI: SSDT 0x000000007E4AE9B0 002950 (v02 INTEL  xh_cfsd4 00000000 INTL 20160527)
[    0.007261] ACPI: UEFI 0x000000007E4B1300 000042 (v01 ALASKA A M I    00000002      01000013)
[    0.007263] ACPI: LPIT 0x000000007E4B1348 00005C (v01 ALASKA A M I    00000002      01000013)
[    0.007266] ACPI: SSDT 0x000000007E4B13A8 0014E2 (v02 ALASKA TbtTypeC 00000000 INTL 20160527)
[    0.007268] ACPI: DBGP 0x000000007E4B2890 000034 (v01 ALASKA A M I    00000002      01000013)
[    0.007271] ACPI: DBG2 0x000000007E4B28C8 000054 (v00 ALASKA A M I    00000002      01000013)
[    0.007273] ACPI: SSDT 0x000000007E4B2920 001B67 (v02 ALASKA UsbCTabl 00001000 INTL 20160527)
[    0.007276] ACPI: SSDT 0x000000007E4B4488 000144 (v02 Intel  ADebTabl 00001000 INTL 20160527)
[    0.007278] ACPI: DMAR 0x000000007E4B45D0 0000A8 (v01 INTEL  EDK2     00000002      01000013)
[    0.007281] ACPI: BGRT 0x000000007E4B4678 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007283] ACPI: TPM2 0x000000007E4B46B0 000034 (v04 ALASKA A M I    00000001 AMI  00000000)
[    0.007285] ACPI: WSMT 0x000000007E4B46E8 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007288] ACPI: Reserving FACP table memory at [mem 0x7e4a7808-0x7e4a791b]
[    0.007289] ACPI: Reserving DSDT table memory at [mem 0x7e468220-0x7e4a7805]
[    0.007290] ACPI: Reserving FACS table memory at [mem 0x7e526080-0x7e5260bf]
[    0.007290] ACPI: Reserving APIC table memory at [mem 0x7e4a7920-0x7e4a79a3]
[    0.007291] ACPI: Reserving FPDT table memory at [mem 0x7e4a79a8-0x7e4a79eb]
[    0.007292] ACPI: Reserving FIDT table memory at [mem 0x7e4a79f0-0x7e4a7a8b]
[    0.007292] ACPI: Reserving MCFG table memory at [mem 0x7e4a7a90-0x7e4a7acb]
[    0.007293] ACPI: Reserving SSDT table memory at [mem 0x7e4a7ad0-0x7e4a7e47]
[    0.007294] ACPI: Reserving SSDT table memory at [mem 0x7e4a7e48-0x7e4a9963]
[    0.007294] ACPI: Reserving AAFT table memory at [mem 0x7e4a9968-0x7e4a9ba4]
[    0.007295] ACPI: Reserving SSDT table memory at [mem 0x7e4a9ba8-0x7e4acd6d]
[    0.007296] ACPI: Reserving HPET table memory at [mem 0x7e4acd70-0x7e4acda7]
[    0.007296] ACPI: Reserving SSDT table memory at [mem 0x7e4acda8-0x7e4ae9a8]
[    0.007297] ACPI: Reserving SSDT table memory at [mem 0x7e4ae9b0-0x7e4b12ff]
[    0.007297] ACPI: Reserving UEFI table memory at [mem 0x7e4b1300-0x7e4b1341]
[    0.007298] ACPI: Reserving LPIT table memory at [mem 0x7e4b1348-0x7e4b13a3]
[    0.007299] ACPI: Reserving SSDT table memory at [mem 0x7e4b13a8-0x7e4b2889]
[    0.007299] ACPI: Reserving DBGP table memory at [mem 0x7e4b2890-0x7e4b28c3]
[    0.007300] ACPI: Reserving DBG2 table memory at [mem 0x7e4b28c8-0x7e4b291b]
[    0.007301] ACPI: Reserving SSDT table memory at [mem 0x7e4b2920-0x7e4b4486]
[    0.007301] ACPI: Reserving SSDT table memory at [mem 0x7e4b4488-0x7e4b45cb]
[    0.007302] ACPI: Reserving DMAR table memory at [mem 0x7e4b45d0-0x7e4b4677]
[    0.007303] ACPI: Reserving BGRT table memory at [mem 0x7e4b4678-0x7e4b46af]
[    0.007303] ACPI: Reserving TPM2 table memory at [mem 0x7e4b46b0-0x7e4b46e3]
[    0.007304] ACPI: Reserving WSMT table memory at [mem 0x7e4b46e8-0x7e4b470f]
[    0.007625] No NUMA configuration found
[    0.007625] Faking a node at [mem 0x0000000000000000-0x000000016dffffff]
[    0.007632] NODE_DATA(0) allocated [mem 0x16dfd5000-0x16dffffff]
[    0.007775] Zone ranges:
[    0.007776]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.007777]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.007779]   Normal   [mem 0x0000000100000000-0x000000016dffffff]
[    0.007780]   Device   empty
[    0.007781] Movable zone start for each node
[    0.007783] Early memory node ranges
[    0.007783]   node   0: [mem 0x0000000000001000-0x000000000005efff]
[    0.007784]   node   0: [mem 0x0000000000060000-0x000000000009ffff]
[    0.007785]   node   0: [mem 0x0000000000100000-0x000000007c764fff]
[    0.007786]   node   0: [mem 0x000000007ed0e000-0x000000007ed0efff]
[    0.007787]   node   0: [mem 0x0000000100000000-0x000000016dffffff]
[    0.007788] Initmem setup node 0 [mem 0x0000000000001000-0x000000016dffffff]
[    0.007791] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.007792] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.007812] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.012369] On node 0, zone DMA32: 9641 pages in unavailable ranges
[    0.016537] On node 0, zone Normal: 4849 pages in unavailable ranges
[    0.016610] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.016626] Reserving Intel graphics memory at [mem 0x80000000-0x8fffffff]
[    0.017053] ACPI: PM-Timer IO Port: 0x1808
[    0.017058] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.017060] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.017060] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.017061] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.017125] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.017127] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.017129] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.017132] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.017133] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.017138] e820: update [mem 0x78a54000-0x78a94fff] usable ==> reserved
[    0.017147] TSC deadline timer available
[    0.017148] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.017160] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.017161] PM: hibernation: Registered nosave memory: [mem 0x0005f000-0x0005ffff]
[    0.017163] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.017164] PM: hibernation: Registered nosave memory: [mem 0x687f7000-0x687f7fff]
[    0.017165] PM: hibernation: Registered nosave memory: [mem 0x68807000-0x68807fff]
[    0.017166] PM: hibernation: Registered nosave memory: [mem 0x68808000-0x68808fff]
[    0.017167] PM: hibernation: Registered nosave memory: [mem 0x68818000-0x68818fff]
[    0.017168] PM: hibernation: Registered nosave memory: [mem 0x78a54000-0x78a94fff]
[    0.017170] PM: hibernation: Registered nosave memory: [mem 0x7adf4000-0x7adf4fff]
[    0.017171] PM: hibernation: Registered nosave memory: [mem 0x7c765000-0x7dfd0fff]
[    0.017171] PM: hibernation: Registered nosave memory: [mem 0x7dfd1000-0x7e04dfff]
[    0.017172] PM: hibernation: Registered nosave memory: [mem 0x7e04e000-0x7e526fff]
[    0.017172] PM: hibernation: Registered nosave memory: [mem 0x7e527000-0x7ed0dfff]
[    0.017174] PM: hibernation: Registered nosave memory: [mem 0x7ed0f000-0x8fffffff]
[    0.017174] PM: hibernation: Registered nosave memory: [mem 0x90000000-0xfdffffff]
[    0.017175] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.017175] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    0.017176] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.017177] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.017177] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
[    0.017178] PM: hibernation: Registered nosave memory: [mem 0xfed04000-0xfedfffff]
[    0.017178] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.017179] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xffffffff]
[    0.017180] [mem 0x90000000-0xfdffffff] available for PCI devices
[    0.017181] Booting paravirtualized kernel on bare hardware
[    0.017183] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.017188] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.017641] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u524288
[    0.017647] pcpu-alloc: s217088 r8192 d28672 u524288 alloc=1*2097152
[    0.017649] pcpu-alloc: [0] 0 1 2 3 
[    0.017667] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.4.0 root=UUID=74fe52d0-e90f-4b0a-92f4-581b5fa98519 ro quiet splash vt.handoff=7
[    0.017736] Unknown kernel command line parameters "splash BOOT_IMAGE=/boot/vmlinuz-6.4.0", will be passed to user space.
[    0.018341] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.018622] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.018673] Fallback order for Node 0: 0 
[    0.018675] Built 1 zonelists, mobility grouping on.  Total pages: 945096
[    0.018676] Policy zone: Normal
[    0.018680] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.018686] software IO TLB: area num 4.
[    0.047991] Memory: 3457148K/3841040K available (18432K kernel code, 3203K rwdata, 6968K rodata, 4432K init, 16780K bss, 383632K reserved, 0K cma-reserved)
[    0.048089] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.048098] Kernel/User page tables isolation: enabled
[    0.048126] ftrace: allocating 52011 entries in 204 pages
[    0.055493] ftrace: allocated 204 pages with 4 groups
[    0.056091] Dynamic Preempt: voluntary
[    0.056112] rcu: Preemptible hierarchical RCU implementation.
[    0.056113] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
[    0.056114] 	Trampoline variant of Tasks RCU enabled.
[    0.056114] 	Rude variant of Tasks RCU enabled.
[    0.056115] 	Tracing variant of Tasks RCU enabled.
[    0.056115] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.056116] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.058547] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
[    0.058808] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.059150] Console: colour dummy device 80x25
[    0.059152] printk: console [tty0] enabled
[    0.059192] ACPI: Core revision 20230331
[    0.059542] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.059685] APIC: Switch to symmetric I/O mode setup
[    0.059687] DMAR: Host address width 39
[    0.059688] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.059693] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.059695] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.059698] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.059699] DMAR: RMRR base: 0x0000007e809000 end: 0x0000007ea52fff
[    0.059701] DMAR: RMRR base: 0x0000007f800000 end: 0x0000008fffffff
[    0.059702] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.059704] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.059704] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.063135] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.063137] x2apic enabled
[    0.063159] Switched APIC routing to cluster x2apic.
[    0.072497] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.091603] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6aa99074b1c, max_idle_ns: 881590506587 ns
[    0.091608] Calibrating delay loop (skipped), value calculated using timer frequency.. 7399.70 BogoMIPS (lpj=14799400)
[    0.091611] pid_max: default: 32768 minimum: 301
[    0.093745] LSM: initializing lsm=lockdown,capability,yama,apparmor,integrity
[    0.093752] Yama: becoming mindful.
[    0.093775] AppArmor: AppArmor initialized
[    0.093806] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.093815] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.093998] x86/cpu: SGX disabled by BIOS.
[    0.094005] CPU0: Thermal monitoring enabled (TM1)
[    0.094039] process: using mwait in idle threads
[    0.094042] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.094043] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.094047] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.094049] Spectre V2 : Mitigation: IBRS
[    0.094049] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.094050] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.094051] RETBleed: Mitigation: IBRS
[    0.094052] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.094053] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.094054] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.094060] MDS: Mitigation: Clear CPU buffers
[    0.094061] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.094065] SRBDS: Mitigation: Microcode
[    0.113482] Freeing SMP alternatives memory: 40K
[    0.113771] smpboot: CPU0: Intel(R) Pentium(R) Gold G5400 CPU @ 3.70GHz (family: 0x6, model: 0x9e, stepping: 0xa)
[    0.113889] cblist_init_generic: Setting adjustable number of callback queues.
[    0.113891] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.113905] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.113916] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.113926] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.113950] ... version:                4
[    0.113951] ... bit width:              48
[    0.113951] ... generic registers:      4
[    0.113952] ... value mask:             0000ffffffffffff
[    0.113953] ... max period:             00007fffffffffff
[    0.113954] ... fixed-purpose events:   3
[    0.113954] ... event mask:             000000070000000f
[    0.114070] Estimated ratio of average max frequency by base frequency (times 1024): 1024
[    0.114090] rcu: Hierarchical SRCU implementation.
[    0.114093] rcu: 	Max phase no-delay instances is 1000.
[    0.114531] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.114590] smp: Bringing up secondary CPUs ...
[    0.114675] x86: Booting SMP configuration:
[    0.114676] .... node  #0, CPUs:      #1 #2
[    0.115687] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.115687] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
[    0.115726]  #3
[    0.115994] smp: Brought up 1 node, 4 CPUs
[    0.115994] smpboot: Max logical packages: 1
[    0.115994] smpboot: Total of 4 processors activated (29598.80 BogoMIPS)
[    0.117300] devtmpfs: initialized
[    0.117300] x86/mm: Memory block size: 128MB
[    0.117300] ACPI: PM: Registering ACPI NVS region [mem 0x7e04e000-0x7e526fff] (5083136 bytes)
[    0.117300] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.117300] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.117300] pinctrl core: initialized pinctrl subsystem
[    0.117300] PM: RTC time: 17:02:18, date: 2097-08-22
[    0.117300] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.119628] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.119661] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.119692] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.119702] audit: initializing netlink subsys (disabled)
[    0.119713] audit: type=2000 audit(4028029338.052:1): state=initialized audit_enabled=0 res=1
[    0.119745] thermal_sys: Registered thermal governor 'fair_share'
[    0.119746] thermal_sys: Registered thermal governor 'bang_bang'
[    0.119747] thermal_sys: Registered thermal governor 'step_wise'
[    0.119748] thermal_sys: Registered thermal governor 'user_space'
[    0.119748] thermal_sys: Registered thermal governor 'power_allocator'
[    0.119756] EISA bus registered
[    0.119765] cpuidle: using governor ladder
[    0.119768] cpuidle: using governor menu
[    0.119813] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.119813] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.119813] PCI: not using MMCONFIG
[    0.119813] PCI: Using configuration type 1 for base access
[    0.119895] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.119901] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.119901] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.119901] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.119901] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.119901] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.119901] fbcon: Taking over console
[    0.119901] ACPI: Added _OSI(Module Device)
[    0.119901] ACPI: Added _OSI(Processor Device)
[    0.119901] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.119901] ACPI: Added _OSI(Processor Aggregator Device)
[    0.197478] ACPI: 9 ACPI AML tables successfully acquired and loaded
[    0.205812] ACPI: Dynamic OEM Table Load:
[    0.205818] ACPI: SSDT 0xFFFF9074C0D01300 0000F4 (v02 PmRef  Cpu0Psd  00003000 INTL 20160527)
[    0.207381] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[    0.209303] ACPI: Dynamic OEM Table Load:
[    0.209309] ACPI: SSDT 0xFFFF9074C1225C00 000400 (v02 PmRef  Cpu0Cst  00003001 INTL 20160527)
[    0.211047] ACPI: Dynamic OEM Table Load:
[    0.211052] ACPI: SSDT 0xFFFF9074C1276000 0006CB (v02 PmRef  Cpu0Ist  00003000 INTL 20160527)
[    0.213253] ACPI: Dynamic OEM Table Load:
[    0.213258] ACPI: SSDT 0xFFFF9074C1277800 0005FC (v02 PmRef  ApIst    00003000 INTL 20160527)
[    0.215224] ACPI: Dynamic OEM Table Load:
[    0.215230] ACPI: SSDT 0xFFFF9074C1264000 000AB0 (v02 PmRef  ApPsd    00003000 INTL 20160527)
[    0.217635] ACPI: Dynamic OEM Table Load:
[    0.217640] ACPI: SSDT 0xFFFF9074C1224C00 00030A (v02 PmRef  ApCst    00003000 INTL 20160527)
[    0.222682] ACPI: Interpreter enabled
[    0.222716] ACPI: PM: (supports S0 S3 S4 S5)
[    0.222717] ACPI: Using IOAPIC for interrupt routing
[    0.222825] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.224645] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved as ACPI motherboard resource
[    0.224660] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.224661] PCI: Using E820 reservations for host bridge windows
[    0.226114] ACPI: Enabled 9 GPEs in block 00 to 7F
[    0.241818] ACPI: \_SB_.PCI0.XDCI.USBC: New power resource
[    0.242002] ACPI: \_SB_.PCI0.PAUD: New power resource
[    0.245815] ACPI: \SPR2: New power resource
[    0.246159] ACPI: \_SB_.PCI0.SAT0.VOL0.V0PR: New power resource
[    0.246595] ACPI: \_SB_.PCI0.SAT0.VOL1.V1PR: New power resource
[    0.247026] ACPI: \_SB_.PCI0.SAT0.VOL2.V2PR: New power resource
[    0.249905] ACPI: \_SB_.PCI0.I2C1.PXTC: New power resource
[    0.253671] ACPI: \_SB_.PCI0.CNVW.WRST: New power resource
[    0.257923] ACPI: \PIN_: New power resource
[    0.258121] ACPI: \SPR0: New power resource
[    0.258182] ACPI: \SPR1: New power resource
[    0.258247] ACPI: \SPR3: New power resource
[    0.258307] ACPI: \SPR5: New power resource
[    0.258651] ACPI: \ZPDR: New power resource
[    0.259131] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.259138] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.262396] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
[    0.263902] PCI host bridge to bus 0000:00
[    0.263905] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.263907] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.263908] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.263910] pci_bus 0000:00: root bus resource [mem 0x90000000-0xdfffffff window]
[    0.263911] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
[    0.263912] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.264003] pci 0000:00:00.0: [8086:3e0f] type 00 class 0x060000
[    0.264087] pci 0000:00:02.0: [8086:3e90] type 00 class 0x030000
[    0.264094] pci 0000:00:02.0: reg 0x10: [mem 0xa2000000-0xa2ffffff 64bit]
[    0.264099] pci 0000:00:02.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
[    0.264103] pci 0000:00:02.0: reg 0x20: [io  0x5000-0x503f]
[    0.264116] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.264119] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.264468] pci 0000:00:12.0: [8086:a379] type 00 class 0x118000
[    0.264494] pci 0000:00:12.0: reg 0x10: [mem 0xa453d000-0xa453dfff 64bit]
[    0.264726] pci 0000:00:14.0: [8086:a36d] type 00 class 0x0c0330
[    0.264753] pci 0000:00:14.0: reg 0x10: [mem 0xa4520000-0xa452ffff 64bit]
[    0.264855] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.266303] pci 0000:00:14.2: [8086:a36f] type 00 class 0x050000
[    0.266326] pci 0000:00:14.2: reg 0x10: [mem 0xa4536000-0xa4537fff 64bit]
[    0.266340] pci 0000:00:14.2: reg 0x18: [mem 0xa453c000-0xa453cfff 64bit]
[    0.266509] pci 0000:00:16.0: [8086:a360] type 00 class 0x078000
[    0.266532] pci 0000:00:16.0: reg 0x10: [mem 0xa453b000-0xa453bfff 64bit]
[    0.266619] pci 0000:00:16.0: PME# supported from D3hot
[    0.267122] pci 0000:00:17.0: [8086:a352] type 00 class 0x010601
[    0.267143] pci 0000:00:17.0: reg 0x10: [mem 0xa4534000-0xa4535fff]
[    0.267154] pci 0000:00:17.0: reg 0x14: [mem 0xa453a000-0xa453a0ff]
[    0.267166] pci 0000:00:17.0: reg 0x18: [io  0x5090-0x5097]
[    0.267177] pci 0000:00:17.0: reg 0x1c: [io  0x5080-0x5083]
[    0.267188] pci 0000:00:17.0: reg 0x20: [io  0x5060-0x507f]
[    0.267199] pci 0000:00:17.0: reg 0x24: [mem 0xa4539000-0xa45397ff]
[    0.267260] pci 0000:00:17.0: PME# supported from D3hot
[    0.267813] pci 0000:00:1c.0: [8086:a33c] type 01 class 0x060400
[    0.267964] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.268007] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.268725] pci 0000:00:1d.0: [8086:a330] type 01 class 0x060400
[    0.268864] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.269548] pci 0000:00:1d.3: [8086:a333] type 01 class 0x060400
[    0.269712] pci 0000:00:1d.3: PME# supported from D0 D3hot D3cold
[    0.269758] pci 0000:00:1d.3: PTM enabled (root), 4ns granularity
[    0.270453] pci 0000:00:1f.0: [8086:a304] type 00 class 0x060100
[    0.270985] pci 0000:00:1f.3: [8086:a348] type 00 class 0x040300
[    0.271043] pci 0000:00:1f.3: reg 0x10: [mem 0xa4530000-0xa4533fff 64bit]
[    0.271128] pci 0000:00:1f.3: reg 0x20: [mem 0xa3000000-0xa30fffff 64bit]
[    0.271267] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.274038] pci 0000:00:1f.4: [8086:a323] type 00 class 0x0c0500
[    0.274111] pci 0000:00:1f.4: reg 0x10: [mem 0xa4538000-0xa45380ff 64bit]
[    0.274192] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.274499] pci 0000:00:1f.5: [8086:a324] type 00 class 0x0c8000
[    0.274519] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    0.274685] pci 0000:00:1f.6: [8086:15bc] type 00 class 0x020000
[    0.274729] pci 0000:00:1f.6: reg 0x10: [mem 0xa4500000-0xa451ffff]
[    0.274963] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.275241] pci 0000:01:00.0: [10ec:5261] type 00 class 0xff0000
[    0.275315] pci 0000:01:00.0: reg 0x10: [mem 0xa3b00000-0xa3b00fff]
[    0.275782] pci 0000:01:00.0: supports D1 D2
[    0.275784] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.276490] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.276494] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.276499] pci 0000:00:1c.0:   bridge window [mem 0xa3b00000-0xa44fffff]
[    0.276506] pci 0000:00:1c.0:   bridge window [mem 0xa0a00000-0xa13fffff 64bit pref]
[    0.276606] acpiphp: Slot [1] registered
[    0.276616] pci 0000:00:1d.0: PCI bridge to [bus 02]
[    0.276719] pci 0000:00:1d.3: PCI bridge to [bus 03]
[    0.276723] pci 0000:00:1d.3:   bridge window [io  0x3000-0x3fff]
[    0.276728] pci 0000:00:1d.3:   bridge window [mem 0xa3100000-0xa3afffff]
[    0.276735] pci 0000:00:1d.3:   bridge window [mem 0xa0000000-0xa09fffff 64bit pref]
[    0.278108] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.278190] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.278271] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.278352] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.278432] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.278512] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.278593] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.278673] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.288341] iommu: Default domain type: Translated 
[    0.288341] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.288341] SCSI subsystem initialized
[    0.288341] libata version 3.00 loaded.
[    0.288341] ACPI: bus type USB registered
[    0.288341] usbcore: registered new interface driver usbfs
[    0.288341] usbcore: registered new interface driver hub
[    0.288341] usbcore: registered new device driver usb
[    0.288341] pps_core: LinuxPPS API ver. 1 registered
[    0.288341] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.288341] PTP clock support registered
[    0.288341] EDAC MC: Ver: 3.0.0
[    0.288341] efivars: Registered efivars operations
[    0.288341] NetLabel: Initializing
[    0.288341] NetLabel:  domain hash size = 128
[    0.288341] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.288341] NetLabel:  unlabeled traffic allowed by default
[    0.288341] PCI: Using ACPI for IRQ routing
[    0.368970] PCI: pci_cache_line_size set to 64 bytes
[    0.369055] e820: reserve RAM buffer [mem 0x0005f000-0x0005ffff]
[    0.369057] e820: reserve RAM buffer [mem 0x687f7018-0x6bffffff]
[    0.369058] e820: reserve RAM buffer [mem 0x68808018-0x6bffffff]
[    0.369059] e820: reserve RAM buffer [mem 0x78a54000-0x7bffffff]
[    0.369060] e820: reserve RAM buffer [mem 0x7adf4000-0x7bffffff]
[    0.369061] e820: reserve RAM buffer [mem 0x7c765000-0x7fffffff]
[    0.369062] e820: reserve RAM buffer [mem 0x7ed0f000-0x7fffffff]
[    0.369063] e820: reserve RAM buffer [mem 0x16e000000-0x16fffffff]
[    0.371615] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.371615] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.371616] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.371621] vgaarb: loaded
[    0.372806] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.372813] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.375634] clocksource: Switched to clocksource tsc-early
[    0.375733] VFS: Disk quotas dquot_6.6.0
[    0.375745] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.375859] AppArmor: AppArmor Filesystem Enabled
[    0.375881] pnp: PnP ACPI init
[    0.376221] system 00:00: [io  0x0280-0x028f] has been reserved
[    0.376224] system 00:00: [io  0x0290-0x029f] has been reserved
[    0.376226] system 00:00: [io  0x02a0-0x02af] has been reserved
[    0.376227] system 00:00: [io  0x02b0-0x02bf] has been reserved
[    0.376606] pnp 00:01: [dma 0 disabled]
[    0.376750] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.376752] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.376872] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.377096] system 00:04: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.377098] system 00:04: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.377099] system 00:04: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.377101] system 00:04: [mem 0xe0000000-0xefffffff] has been reserved
[    0.377102] system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.377104] system 00:04: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.377105] system 00:04: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.377107] system 00:04: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.377317] system 00:05: [io  0x1800-0x18fe] could not be reserved
[    0.377320] system 00:05: [mem 0xfd000000-0xfd69ffff] has been reserved
[    0.377321] system 00:05: [mem 0xfd6c0000-0xfd6cffff] has been reserved
[    0.377322] system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    0.377324] system 00:05: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.377325] system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved
[    0.377327] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.377609] system 00:06: [io  0x2000-0x20fe] has been reserved
[    0.377902] system 00:07: [mem 0xfd6e0000-0xfd6effff] has been reserved
[    0.377904] system 00:07: [mem 0xfd6d0000-0xfd6dffff] has been reserved
[    0.377905] system 00:07: [mem 0xfd6b0000-0xfd6bffff] has been reserved
[    0.377907] system 00:07: [mem 0xfd6a0000-0xfd6affff] has been reserved
[    0.379872] pnp: PnP ACPI: found 9 devices
[    0.385811] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.385883] NET: Registered PF_INET protocol family
[    0.385953] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.386745] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.386772] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.386803] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.386948] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.387039] TCP: Hash tables configured (established 32768 bind 32768)
[    0.387099] MPTCP token hash table entries: 4096 (order: 4, 98304 bytes, linear)
[    0.387114] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.387124] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.387159] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.387164] NET: Registered PF_XDP protocol family
[    0.387178] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.387187] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    0.387193] pci 0000:00:1c.0:   bridge window [mem 0xa3b00000-0xa44fffff]
[    0.387197] pci 0000:00:1c.0:   bridge window [mem 0xa0a00000-0xa13fffff 64bit pref]
[    0.387204] pci 0000:00:1d.0: PCI bridge to [bus 02]
[    0.387219] pci 0000:00:1d.3: PCI bridge to [bus 03]
[    0.387221] pci 0000:00:1d.3:   bridge window [io  0x3000-0x3fff]
[    0.387227] pci 0000:00:1d.3:   bridge window [mem 0xa3100000-0xa3afffff]
[    0.387231] pci 0000:00:1d.3:   bridge window [mem 0xa0000000-0xa09fffff 64bit pref]
[    0.387238] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.387240] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.387241] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.387243] pci_bus 0000:00: resource 7 [mem 0x90000000-0xdfffffff window]
[    0.387244] pci_bus 0000:00: resource 8 [mem 0xfc800000-0xfe7fffff window]
[    0.387245] pci_bus 0000:01: resource 0 [io  0x4000-0x4fff]
[    0.387247] pci_bus 0000:01: resource 1 [mem 0xa3b00000-0xa44fffff]
[    0.387248] pci_bus 0000:01: resource 2 [mem 0xa0a00000-0xa13fffff 64bit pref]
[    0.387249] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
[    0.387251] pci_bus 0000:03: resource 1 [mem 0xa3100000-0xa3afffff]
[    0.387252] pci_bus 0000:03: resource 2 [mem 0xa0000000-0xa09fffff 64bit pref]
[    0.388247] PCI: CLS 64 bytes, default 64
[    0.388264] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.388265] software IO TLB: mapped [mem 0x0000000074a54000-0x0000000078a54000] (64MB)
[    0.388305] Trying to unpack rootfs image as initramfs...
[    0.388462] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    0.388894] Initialise system trusted keyrings
[    0.388901] Key type blacklist registered
[    0.388950] workingset: timestamp_bits=36 max_order=20 bucket_order=0
[    0.388968] zbud: loaded
[    0.389152] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.389225] fuse: init (API version 7.38)
[    0.389341] integrity: Platform Keyring initialized
[    0.395426] Key type asymmetric registered
[    0.395430] Asymmetric key parser 'x509' registered
[    0.395455] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    0.395523] io scheduler mq-deadline registered
[    0.395968] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    0.396009] pcieport 0000:00:1c.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.396235] pcieport 0000:00:1d.0: PME: Signaling with IRQ 123
[    0.396536] pcieport 0000:00:1d.3: PME: Signaling with IRQ 124
[    0.396563] pcieport 0000:00:1d.3: pciehp: Slot #15 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.396730] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.397270] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    0.397293] ACPI: button: Sleep Button [SLPB]
[    0.397325] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.397341] ACPI: button: Power Button [PWRB]
[    0.397371] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.397403] ACPI: button: Power Button [PWRF]
[    0.397978] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.419972] 00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.423779] Linux agpgart interface v0.103
[    0.437969] loop: module loaded
[    0.438340] tun: Universal TUN/TAP device driver, 1.6
[    0.438408] PPP generic driver version 2.4.2
[    0.438623] VFIO - User Level meta-driver version: 0.3
[    0.438757] i8042: PNP: No PS/2 controller found.
[    0.438877] mousedev: PS/2 mouse device common for all mice
[    0.439018] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.440618] rtc_cmos rtc_cmos: registered as rtc0
[    0.440930] rtc_cmos rtc_cmos: setting system clock to 2097-08-22T17:02:18 UTC (4028029338)
[    0.440967] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nvram
[    0.440979] i2c_dev: i2c /dev entries driver
[    0.441050] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    0.441064] device-mapper: uevent: version 1.0.3
[    0.441112] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    0.441142] platform eisa.0: Probing EISA bus 0
[    0.441145] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.441147] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.441149] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.441151] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.441152] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.441154] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.441156] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.441157] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.441159] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.441160] platform eisa.0: EISA: Detected 0 cards
[    0.441163] intel_pstate: Intel P-state driver initializing
[    0.441425] intel_pstate: Disabling energy efficiency optimization
[    0.441426] intel_pstate: HWP enabled
[    0.444231] ledtrig-cpu: registered to indicate activity on CPUs
[    0.444273] efifb: probing for efifb
[    0.444299] efifb: showing boot graphics
[    0.445232] efifb: framebuffer at 0x90000000, using 8100k, total 8100k
[    0.445235] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    0.445236] efifb: scrolling: redraw
[    0.445237] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.445378] Console: switching to colour frame buffer device 240x67
[    0.447308] fb0: EFI VGA frame buffer device
[    0.447448] intel_pmc_core INT33A1:00:  initialized
[    0.447619] drop_monitor: Initializing network drop monitor service
[    0.447729] NET: Registered PF_INET6 protocol family
[    0.752379] Freeing initrd memory: 144504K
[    0.758893] Segment Routing with IPv6
[    0.758908] In-situ OAM (IOAM) with IPv6
[    0.758935] NET: Registered PF_PACKET protocol family
[    0.759034] Key type dns_resolver registered
[    0.759500] microcode: Microcode Update Driver: v2.2.
[    0.759506] IPI shorthand broadcast: enabled
[    0.761201] sched_clock: Marking stable (752002498, 8487670)->(763339334, -2849166)
[    0.761362] registered taskstats version 1
[    0.761448] Loading compiled-in X.509 certificates
[    0.761960] Loaded X.509 cert 'Build time autogenerated kernel key: 417a18f9c0ec7ef9b042b8731fef1cec608b3690'
[    0.764147] Key type .fscrypt registered
[    0.764148] Key type fscrypt-provisioning registered
[    0.764254] Key type trusted registered
[    0.767319] Key type encrypted registered
[    0.767323] AppArmor: AppArmor sha1 policy hashing enabled
[    0.768294] integrity: Loading X.509 certificate: UEFI:db
[    0.768321] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.768322] integrity: Loading X.509 certificate: UEFI:db
[    0.768338] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.769080] Loading compiled-in module X.509 certificates
[    0.769496] Loaded X.509 cert 'Build time autogenerated kernel key: 417a18f9c0ec7ef9b042b8731fef1cec608b3690'
[    0.769498] ima: Allocated hash algorithm: sha1
[    0.798364] ima: No architecture policies found
[    0.798409] evm: Initialising EVM extended attributes:
[    0.798413] evm: security.selinux
[    0.798418] evm: security.SMACK64
[    0.798422] evm: security.SMACK64EXEC
[    0.798425] evm: security.SMACK64TRANSMUTE
[    0.798429] evm: security.SMACK64MMAP
[    0.798431] evm: security.apparmor
[    0.798434] evm: security.ima
[    0.798437] evm: security.capability
[    0.798441] evm: HMAC attrs: 0x1
[    0.799410] PM:   Magic number: 13:435:37
[    0.799431] bdi 7:2: hash matches
[    0.800077] RAS: Correctable Errors collector initialized.
[    0.800145] clk: Disabling unused clocks
[    0.803806] Freeing unused decrypted memory: 2036K
[    0.805692] Freeing unused kernel image (initmem) memory: 4432K
[    0.824569] Write protecting the kernel read-only data: 26624k
[    0.825870] Freeing unused kernel image (rodata/data gap) memory: 1224K
[    0.901419] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.901420] x86/mm: Checking user space page tables
[    0.940887] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.940891] Run /init as init process
[    0.940893]   with arguments:
[    0.940894]     /init
[    0.940895]     splash
[    0.940895]   with environment:
[    0.940896]     HOME=/
[    0.940897]     TERM=linux
[    0.940898]     BOOT_IMAGE=/boot/vmlinuz-6.4.0
[    1.108327] rtsx_pci 0000:01:00.0: enabling device (0000 -> 0002)
[    1.109979] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    1.112320] i2c i2c-0: 1/4 memory slots populated (from DMI)
[    1.113099] i2c i2c-0: Successfully instantiated SPD at 0x51
[    1.116456] ahci 0000:00:17.0: version 3.0
[    1.118112] e1000e: Intel(R) PRO/1000 Network Driver
[    1.118115] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.119630] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.120343] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    1.120409] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.121579] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000000009810
[    1.127049] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.127056] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.127061] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
[    1.127115] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.04
[    1.127119] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.127121] usb usb1: Product: xHCI Host Controller
[    1.127123] usb usb1: Manufacturer: Linux 6.4.0 xhci-hcd
[    1.127125] usb usb1: SerialNumber: 0000:00:14.0
[    1.127358] hub 1-0:1.0: USB hub found
[    1.127391] hub 1-0:1.0: 16 ports detected
[    1.127768] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    1.127774] ahci 0000:00:17.0: flags: 64bit ncq sntf clo only pio slum part ems deso sadm sds apst 
[    1.131610] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.04
[    1.131613] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.131615] usb usb2: Product: xHCI Host Controller
[    1.131616] usb usb2: Manufacturer: Linux 6.4.0 xhci-hcd
[    1.131618] usb usb2: SerialNumber: 0000:00:14.0
[    1.131776] hub 2-0:1.0: USB hub found
[    1.131798] hub 2-0:1.0: 8 ports detected
[    1.189316] scsi host0: ahci
[    1.189520] scsi host1: ahci
[    1.189672] scsi host2: ahci
[    1.189911] scsi host3: ahci
[    1.190053] scsi host4: ahci
[    1.190311] scsi host5: ahci
[    1.190383] ata1: SATA max UDMA/133 abar m2048@0xa4539000 port 0xa4539100 irq 126
[    1.190387] ata2: SATA max UDMA/133 abar m2048@0xa4539000 port 0xa4539180 irq 126
[    1.190389] ata3: SATA max UDMA/133 abar m2048@0xa4539000 port 0xa4539200 irq 126
[    1.190392] ata4: SATA max UDMA/133 abar m2048@0xa4539000 port 0xa4539280 irq 126
[    1.190394] ata5: SATA max UDMA/133 abar m2048@0xa4539000 port 0xa4539300 irq 126
[    1.190396] ata6: SATA max UDMA/133 abar m2048@0xa4539000 port 0xa4539380 irq 126
[    1.376544] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
[    1.384567] usb 1-7: new low-speed USB device number 2 using xhci_hcd
[    1.408772] tsc: Refined TSC clocksource calibration: 3695.986 MHz
[    1.408790] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6a8d0c5822e, max_idle_ns: 881591143436 ns
[    1.408856] clocksource: Switched to clocksource tsc
[    1.447378] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 70:85:c2:a4:19:95
[    1.447392] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    1.447559] e1000e 0000:00:1f.6 eth0: MAC: 13, PHY: 12, PBA No: FFFFFF-0FF
[    1.503818] ata6: SATA link down (SStatus 4 SControl 300)
[    1.503871] ata1: SATA link down (SStatus 4 SControl 300)
[    1.503926] ata5: SATA link down (SStatus 4 SControl 300)
[    1.503978] ata2: SATA link down (SStatus 4 SControl 300)
[    1.507797] ata4: SATA link down (SStatus 4 SControl 300)
[    1.507854] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.510432] ata3.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
[    1.510448] ata3.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
[    1.511170] ata3.00: ATA-11: WDC  WDS250G2B0A-00SM50, 401020WD, max UDMA/133
[    1.511772] ata3.00: 488397168 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.513389] ata3.00: Features: Dev-Sleep
[    1.516158] ata3.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
[    1.516174] ata3.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
[    1.519574] ata3.00: configured for UDMA/133
[    1.519936] scsi 2:0:0:0: Direct-Access     ATA      WDC  WDS250G2B0A 20WD PQ: 0 ANSI: 5
[    1.521574] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    1.521657] sd 2:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
[    1.521755] sd 2:0:0:0: [sda] Write Protect is off
[    1.521764] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.521843] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.521975] sd 2:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    1.525811]  sda: sda1 sda2
[    1.526296] sd 2:0:0:0: [sda] Attached SCSI disk
[    1.537077] usb 1-7: New USB device found, idVendor=17ef, idProduct=6044, bcdDevice= 0.08
[    1.537099] usb 1-7: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    1.537113] usb 1-7: Product: ThinkPad USB Laser Mouse
[    1.545518] e1000e 0000:00:1f.6 eno1: renamed from eth0
[    1.672576] usb 1-8: new low-speed USB device number 3 using xhci_hcd
[    1.826477] usb 1-8: New USB device found, idVendor=046d, idProduct=c31c, bcdDevice=64.00
[    1.826492] usb 1-8: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.826500] usb 1-8: Product: USB Keyboard
[    1.826506] usb 1-8: Manufacturer: Logitech
[    1.855188] hid: raw HID events driver (C) Jiri Kosina
[    1.877874] usbcore: registered new interface driver usbhid
[    1.877886] usbhid: USB HID core driver
[    1.886411] input: ThinkPad USB Laser Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/0003:17EF:6044.0001/input/input3
[    1.886811] hid-generic 0003:17EF:6044.0001: input,hidraw0: USB HID v1.11 Mouse [ThinkPad USB Laser Mouse] on usb-0000:00:14.0-7/input0
[    1.887468] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/0003:046D:C31C.0002/input/input4
[    1.944988] hid-generic 0003:046D:C31C.0002: input,hidraw1: USB HID v1.10 Keyboard [Logitech USB Keyboard] on usb-0000:00:14.0-8/input0
[    1.945593] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.1/0003:046D:C31C.0003/input/input5
[    2.004866] input: Logitech USB Keyboard System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.1/0003:046D:C31C.0003/input/input6
[    2.005167] hid-generic 0003:046D:C31C.0003: input,hidraw2: USB HID v1.10 Device [Logitech USB Keyboard] on usb-0000:00:14.0-8/input1
[    2.137604] EXT4-fs (sda2): mounted filesystem 74fe52d0-e90f-4b0a-92f4-581b5fa98519 ro with ordered data mode. Quota mode: none.
[    2.333222] systemd[1]: Inserted module 'autofs4'
[    2.398894] systemd[1]: systemd 245.4-4ubuntu3.22 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    2.399002] systemd[1]: Detected architecture x86-64.
[    2.461334] systemd[1]: Set hostname to <cr-desktop>.
[    2.497970] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=1 'systemd'
[    2.699291] systemd[1]: Created slice system-modprobe.slice.
[    2.699521] systemd[1]: Created slice system-postfix.slice.
[    2.699716] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    2.699914] systemd[1]: Created slice User and Session Slice.
[    2.699983] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    2.700140] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    2.700179] systemd[1]: Reached target User and Group Name Lookups.
[    2.700190] systemd[1]: Reached target Remote File Systems.
[    2.700199] systemd[1]: Reached target Slices.
[    2.700209] systemd[1]: Reached target Mounting snaps.
[    2.700317] systemd[1]: Listening on Syslog Socket.
[    2.700395] systemd[1]: Listening on fsck to fsckd communication Socket.
[    2.700446] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    2.700622] systemd[1]: Listening on Journal Audit Socket.
[    2.700699] systemd[1]: Listening on Journal Socket (/dev/log).
[    2.700792] systemd[1]: Listening on Journal Socket.
[    2.700887] systemd[1]: Listening on udev Control Socket.
[    2.700945] systemd[1]: Listening on udev Kernel Socket.
[    2.720720] systemd[1]: Mounting Huge Pages File System...
[    2.721716] systemd[1]: Mounting POSIX Message Queue File System...
[    2.723249] systemd[1]: Mounting Kernel Debug File System...
[    2.724663] systemd[1]: Mounting Kernel Trace File System...
[    2.726034] systemd[1]: Starting Journal Service...
[    2.727541] systemd[1]: Starting Set the console keyboard layout...
[    2.728927] systemd[1]: Starting Create list of static device nodes for the current kernel...
[    2.730266] systemd[1]: Starting Load Kernel Module chromeos_pstore...
[    2.731599] systemd[1]: Starting Load Kernel Module drm...
[    2.732964] systemd[1]: Starting Load Kernel Module efi_pstore...
[    2.734353] systemd[1]: Starting Load Kernel Module pstore_blk...
[    2.737969] systemd[1]: Starting Load Kernel Module pstore_zone...
[    2.739458] pstore: Using crash dump compression: deflate
[    2.755800] systemd[1]: Starting Load Kernel Module ramoops...
[    2.756665] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[    2.756718] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
[    2.758718] systemd[1]: Starting Load Kernel Modules...
[    2.760081] systemd[1]: Starting Remount Root and Kernel File Systems...
[    2.761530] systemd[1]: Starting udev Coldplug all Devices...
[    2.764391] pstore: Registered efi_pstore as persistent store backend
[    2.765525] systemd[1]: Starting Uncomplicated firewall...
[    2.767875] systemd[1]: Mounted Huge Pages File System.
[    2.768043] systemd[1]: Mounted POSIX Message Queue File System.
[    2.768191] systemd[1]: Mounted Kernel Debug File System.
[    2.768323] systemd[1]: Mounted Kernel Trace File System.
[    2.769398] systemd[1]: Finished Create list of static device nodes for the current kernel.
[    2.769836] systemd[1]: modprobe@pstore_blk.service: Succeeded.
[    2.776581] systemd[1]: Finished Load Kernel Module pstore_blk.
[    2.776951] systemd[1]: modprobe@pstore_zone.service: Succeeded.
[    2.777567] systemd[1]: Finished Load Kernel Module pstore_zone.
[    2.778195] systemd[1]: Finished Uncomplicated firewall.
[    2.786382] EXT4-fs (sda2): re-mounted 74fe52d0-e90f-4b0a-92f4-581b5fa98519 r/w. Quota mode: none.
[    2.788765] systemd[1]: Finished Remount Root and Kernel File Systems.
[    2.789161] systemd[1]: modprobe@chromeos_pstore.service: Succeeded.
[    2.789705] systemd[1]: Finished Load Kernel Module chromeos_pstore.
[    2.791131] systemd[1]: Activating swap /swapfile...
[    2.798616] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[    2.811189] systemd[1]: Starting Load/Save Random Seed...
[    2.817916] Adding 2097148k swap on /swapfile.  Priority:-2 extents:6 across:2260988k SSFS
[    2.819454] systemd[1]: Starting Create System Users...
[    2.819567] systemd[1]: Activated swap /swapfile.
[    2.820097] systemd[1]: modprobe@efi_pstore.service: Succeeded.
[    2.820742] systemd[1]: Finished Load Kernel Module efi_pstore.
[    2.821081] ACPI: bus type drm_connector registered
[    2.821189] systemd[1]: modprobe@ramoops.service: Succeeded.
[    2.821712] systemd[1]: Finished Load Kernel Module ramoops.
[    2.822906] systemd[1]: Reached target Swap.
[    2.822985] systemd[1]: Condition check resulted in Platform Persistent Storage Archival being skipped.
[    2.823853] systemd[1]: modprobe@drm.service: Succeeded.
[    2.824373] systemd[1]: Finished Load Kernel Module drm.
[    2.834857] lp: driver loaded but no devices found
[    2.840286] ppdev: user-space parallel port driver
[    2.853157] systemd[1]: Finished Create System Users.
[    2.853849] systemd[1]: Finished Load/Save Random Seed.
[    2.855110] systemd[1]: Starting Create Static Device Nodes in /dev...
[    2.860726] systemd[1]: Started Journal Service.
[    2.874425] systemd-journald[222]: Received client request to flush runtime journal.
[    2.910112] loop0: detected capacity change from 0 to 8
[    2.939647] loop1: detected capacity change from 0 to 114000
[    2.940326] loop2: detected capacity change from 0 to 448512
[    2.956870] loop3: detected capacity change from 0 to 447264
[    2.956931] loop4: detected capacity change from 0 to 25240
[    2.956987] loop5: detected capacity change from 0 to 994336
[    2.957030] loop6: detected capacity change from 0 to 994336
[    2.960594] loop7: detected capacity change from 0 to 129944
[    2.960964] loop8: detected capacity change from 0 to 151296
[    2.989276] loop9: detected capacity change from 0 to 109072
[    2.989415] loop11: detected capacity change from 0 to 133320
[    2.990015] loop10: detected capacity change from 0 to 113992
[    3.001464] loop12: detected capacity change from 0 to 130848
[    3.005343] loop14: detected capacity change from 0 to 104360
[    3.016129] loop15: detected capacity change from 0 to 133424
[    3.019776] loop13: detected capacity change from 0 to 187776
[    3.311804] EDAC ie31200: No ECC support
[    3.390717] ee1004 0-0051: 512 byte EE1004-compliant SPD EEPROM, read-only
[    3.410393] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    3.517293] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    3.517297] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    3.517299] RAPL PMU: hw unit of domain package 2^-14 Joules
[    3.517300] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    3.517302] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    3.527882] cryptd: max_cpu_qlen set to 1000
[    3.550411] SSE version of gcm_enc/dec engaged.
[    3.822452] intel_rapl_common: Found RAPL domain package
[    3.822455] intel_rapl_common: Found RAPL domain core
[    3.822456] intel_rapl_common: Found RAPL domain uncore
[    3.822458] intel_rapl_common: Found RAPL domain dram
[    4.287882] Console: switching to colour dummy device 80x25
[    4.287942] i915 0000:00:02.0: vgaarb: deactivate vga console
[    4.291998] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    4.293495] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[    4.295550] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
[    4.320960] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[    4.323784] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    4.324347] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7
[    4.324481] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    4.453028] fbcon: i915drmfb (fb0) is primary device
[    4.504699] Console: switching to colour frame buffer device 240x67
[    4.522763] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    4.591516] vfat filesystem being mounted at /boot/efi supports timestamps until 2107-12-31 (0x10391447e)
[    4.645541] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC892: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[    4.645555] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.645563] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    4.645569] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    4.645573] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    4.645577] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[    4.645583] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[    4.645587] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[    4.696503] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input8
[    4.696585] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
[    4.696660] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
[    4.696743] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[    4.696821] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    4.696898] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    4.696968] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    4.697084] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[    4.932641] audit: type=1400 audit(4028029342.987:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-senddoc" pid=516 comm="apparmor_parser"
[    4.933595] audit: type=1400 audit(4028029342.987:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-xpdfimport" pid=515 comm="apparmor_parser"
[    4.938509] audit: type=1400 audit(4028029342.991:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=514 comm="apparmor_parser"
[    4.938519] audit: type=1400 audit(4028029342.991:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=514 comm="apparmor_parser"
[    4.938523] audit: type=1400 audit(4028029342.991:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=514 comm="apparmor_parser"
[    4.938527] audit: type=1400 audit(4028029342.991:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/{,usr/}sbin/dhclient" pid=514 comm="apparmor_parser"
[    4.938531] audit: type=1400 audit(4028029342.991:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cups-browsed" pid=520 comm="apparmor_parser"
[    4.941453] audit: type=1400 audit(4028029342.995:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine" pid=519 comm="apparmor_parser"
[    4.941461] audit: type=1400 audit(4028029342.995:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=519 comm="apparmor_parser"
[    5.132577] kauditd_printk_skb: 19 callbacks suppressed
[    5.132580] audit: type=1400 audit(4028029343.187:30): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap-update-ns.sublime-text" pid=557 comm="apparmor_parser"
[    5.135090] audit: type=1400 audit(4028029343.187:31): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/snap/snapd/19457/usr/lib/snapd/snap-confine" pid=555 comm="apparmor_parser"
[    5.135098] audit: type=1400 audit(4028029343.187:32): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/snap/snapd/19457/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=555 comm="apparmor_parser"
[    5.136211] audit: type=1400 audit(4028029343.187:33): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap.snap-store.hook.configure" pid=558 comm="apparmor_parser"
[    5.143517] audit: type=1400 audit(4028029343.195:34): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap.snap-store.snap-store" pid=559 comm="apparmor_parser"
[    5.147196] audit: type=1400 audit(4028029343.199:35): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap-update-ns.snap-store" pid=556 comm="apparmor_parser"
[    5.164996] audit: type=1400 audit(4028029343.219:36): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap.snap-store.ubuntu-software" pid=560 comm="apparmor_parser"
[    5.165157] audit: type=1400 audit(4028029343.219:37): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap.snap-store.ubuntu-software-local-file" pid=561 comm="apparmor_parser"
[    5.185193] audit: type=1400 audit(4028029343.239:38): apparmor="STATUS" operation="profile_load" profile="unconfined" name="snap.sublime-text.subl" pid=562 comm="apparmor_parser"
[    6.463469] loop16: detected capacity change from 0 to 8
[   10.094244] rfkill: input handler disabled
[   43.180701] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
[   43.180709] pcieport 0000:00:1c.0: pciehp: Slot(8): Card not present
[   44.403768] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
[   44.403772] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
[   44.540631] pci 0000:01:00.0: [15b7:5007] type 00 class 0x010802
[   44.540688] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[   44.540744] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x000000ff 64bit]
[   44.541588] pci 0000:01:00.0: BAR 0: assigned [mem 0xa3b00000-0xa3b03fff 64bit]
[   44.541622] pci 0000:01:00.0: BAR 4: assigned [mem 0xa3b04000-0xa3b040ff 64bit]
[   44.541650] pcieport 0000:00:1c.0: PCI bridge to [bus 01]
[   44.541667] pcieport 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[   44.541681] pcieport 0000:00:1c.0:   bridge window [mem 0xa3b00000-0xa44fffff]
[   44.541691] pcieport 0000:00:1c.0:   bridge window [mem 0xa0a00000-0xa13fffff 64bit pref]
[   44.605052] nvme nvme0: pci function 0000:01:00.0
[   44.605069] nvme 0000:01:00.0: enabling device (0000 -> 0002)
[   44.671175] nvme nvme0: 4/0/0 default/read/poll queues
[   44.675841]  nvme0n1: p1 p2
[   51.682628] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
[   51.716800] nvme0n1: detected capacity change from 495050752 to 0
[   51.793382] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
[   51.793392] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
[   51.928633] pci 0000:01:00.0: [10ec:5261] type 00 class 0xff0000
[   51.928685] pci 0000:01:00.0: reg 0x10: [mem 0xa3b00000-0xa3b00fff]
[   51.928807] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 256)
[   51.928828] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
[   51.928996] pci 0000:01:00.0: supports D1 D2
[   51.929002] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[   51.929637] pci 0000:01:00.0: BAR 0: assigned [mem 0xa3b00000-0xa3b00fff]
[   51.929657] pcieport 0000:00:1c.0: PCI bridge to [bus 01]
[   51.929673] pcieport 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[   51.929686] pcieport 0000:00:1c.0:   bridge window [mem 0xa3b00000-0xa44fffff]
[   51.929697] pcieport 0000:00:1c.0:   bridge window [mem 0xa0a00000-0xa13fffff 64bit pref]
[   54.872928] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
[   56.146581] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
[   56.146584] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
[   56.284632] pci 0000:01:00.0: [15b7:5007] type 00 class 0x010802
[   56.284688] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[   56.284745] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x000000ff 64bit]
[   56.285596] pci 0000:01:00.0: BAR 0: assigned [mem 0xa3b00000-0xa3b03fff 64bit]
[   56.285629] pci 0000:01:00.0: BAR 4: assigned [mem 0xa3b04000-0xa3b040ff 64bit]
[   56.285659] pcieport 0000:00:1c.0: PCI bridge to [bus 01]
[   56.285675] pcieport 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[   56.285688] pcieport 0000:00:1c.0:   bridge window [mem 0xa3b00000-0xa44fffff]
[   56.285699] pcieport 0000:00:1c.0:   bridge window [mem 0xa0a00000-0xa13fffff 64bit pref]
[   56.286092] nvme nvme0: pci function 0000:01:00.0
[   56.286113] nvme 0000:01:00.0: enabling device (0000 -> 0002)
[   56.413757] nvme nvme0: 4/0/0 default/read/poll queues
[   56.419167]  nvme0n1: p1 p2
[   60.635845] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
[   60.676842] nvme0n1: detected capacity change from 495050752 to 0
[   60.748953] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
[   60.748958] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
[   60.884619] pci 0000:01:00.0: [10ec:5261] type 00 class 0xff0000
[   60.884662] pci 0000:01:00.0: reg 0x10: [mem 0xa3b00000-0xa3b00fff]
[   60.884767] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 256)
[   60.884778] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
[   60.884917] pci 0000:01:00.0: supports D1 D2
[   60.884921] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[   60.885537] pci 0000:01:00.0: BAR 0: assigned [mem 0xa3b00000-0xa3b00fff]
[   60.885570] pcieport 0000:00:1c.0: PCI bridge to [bus 01]
[   60.885585] pcieport 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[   60.885598] pcieport 0000:00:1c.0:   bridge window [mem 0xa3b00000-0xa44fffff]
[   60.885630] pcieport 0000:00:1c.0:   bridge window [mem 0xa0a00000-0xa13fffff 64bit pref]
[   63.898861] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
[   63.912118] BUG: unable to handle page fault for address: ffffb24d403e5010
[   63.912122] #PF: supervisor read access in kernel mode
[   63.912125] #PF: error_code(0x0000) - not-present page
[   63.912126] PGD 100000067 P4D 100000067 PUD 1001fe067 PMD 100d97067 PTE 0
[   63.912131] Oops: 0000 [#1] PREEMPT SMP PTI
[   63.912134] CPU: 3 PID: 534 Comm: kworker/3:10 Not tainted 6.4.0 #6
[   63.912137] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./H370M Pro4, BIOS P3.40 10/25/2018
[   63.912138] Workqueue: pm pm_runtime_work
[   63.912144] RIP: 0010:ioread32+0x2e/0x70
[   63.912148] Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 08 d9 54 01 b8 ff ff ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc <8b> 07 c3 cc cc cc cc 55 83 ea 01 48 89 fe 48 c7 c7 98 6f 15 99 48
[   63.912150] RSP: 0018:ffffb24d40a5bd78 EFLAGS: 00010296
[   63.912152] RAX: ffffb24d403e5000 RBX: 0000000000000152 RCX: 000000000000007f
[   63.912153] RDX: 000000000000ff00 RSI: ffffb24d403e5010 RDI: ffffb24d403e5010
[   63.912155] RBP: ffffb24d40a5bd98 R08: ffffb24d403e5010 R09: 0000000000000000
[   63.912156] R10: ffff9074cd95e7f4 R11: 0000000000000003 R12: 000000000000007f
[   63.912158] R13: ffff9074e1a68c00 R14: ffff9074e1a68d00 R15: 0000000000009003
[   63.912159] FS:  0000000000000000(0000) GS:ffff90752a180000(0000) knlGS:0000000000000000
[   63.912161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.912162] CR2: ffffb24d403e5010 CR3: 0000000152832006 CR4: 00000000003706e0
[   63.912164] Call Trace:
[   63.912165]  <TASK>
[   63.912167]  ? show_regs+0x68/0x70
[   63.912171]  ? __die_body+0x20/0x70
[   63.912173]  ? __die+0x2b/0x40
[   63.912175]  ? page_fault_oops+0x160/0x480
[   63.912177]  ? search_bpf_extables+0x63/0x90
[   63.912180]  ? ioread32+0x2e/0x70
[   63.912183]  ? search_exception_tables+0x5f/0x70
[   63.912186]  ? kernelmode_fixup_or_oops+0xa2/0x120
[   63.912189]  ? __bad_area_nosemaphore+0x179/0x230
[   63.912191]  ? bad_area_nosemaphore+0x16/0x20
[   63.912193]  ? do_kern_addr_fault+0x8b/0xa0
[   63.912195]  ? exc_page_fault+0xe5/0x180
[   63.912198]  ? asm_exc_page_fault+0x27/0x30
[   63.912203]  ? ioread32+0x2e/0x70
[   63.912206]  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
[   63.912217]  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
[   63.912226]  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
[   63.912234]  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
[   63.912243]  ? __pfx_pci_pm_runtime_idle+0x10/0x10
[   63.912246]  pci_pm_runtime_idle+0x34/0x70
[   63.912248]  rpm_idle+0xc4/0x2b0
[   63.912251]  pm_runtime_work+0x93/0xc0
[   63.912254]  process_one_work+0x21a/0x430
[   63.912258]  worker_thread+0x4a/0x3c0
[   63.912261]  ? __pfx_worker_thread+0x10/0x10
[   63.912263]  kthread+0x106/0x140
[   63.912266]  ? __pfx_kthread+0x10/0x10
[   63.912268]  ret_from_fork+0x29/0x50
[   63.912273]  </TASK>
[   63.912274] Modules linked in: nvme nvme_core snd_hda_codec_hdmi snd_sof_pci_intel_cnl snd_sof_intel_hda_common snd_hda_codec_realtek snd_hda_codec_generic snd_soc_hdac_hda soundwire_intel ledtrig_audio nls_iso8859_1 soundwire_generic_allocation soundwire_cadence snd_sof_intel_hda_mlink snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi soundwire_bus snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel i915 snd_intel_dspcfg snd_intel_sdw_acpi intel_rapl_msr snd_hda_codec intel_rapl_common snd_hda_core x86_pkg_temp_thermal intel_powerclamp snd_hwdep coretemp snd_pcm kvm_intel drm_buddy ttm mei_hdcp kvm drm_display_helper snd_seq_midi snd_seq_midi_event cec crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_simd rc_core cryptd rapl snd_rawmidi drm_kms_helper binfmt_misc intel_cstate i2c_algo_bit joydev snd_seq snd_seq_device syscopyarea wmi_bmof snd_timer sysfillrect input_leds snd ee1004 sysimgblt mei_me soundcore
[   63.912324]  mei intel_pch_thermal mac_hid acpi_tad acpi_pad sch_fq_codel msr parport_pc ppdev lp ramoops drm parport reed_solomon efi_pstore ip_tables x_tables autofs4 hid_generic usbhid hid rtsx_pci_sdmmc crc32_pclmul ahci e1000e i2c_i801 i2c_smbus rtsx_pci xhci_pci libahci xhci_pci_renesas video wmi
[   63.912346] CR2: ffffb24d403e5010
[   63.912348] ---[ end trace 0000000000000000 ]---
[   64.067753] RIP: 0010:ioread32+0x2e/0x70
[   64.067762] Code: ff 03 00 77 25 48 81 ff 00 00 01 00 77 14 8b 15 08 d9 54 01 b8 ff ff ff ff 85 d2 75 14 c3 cc cc cc cc 89 fa ed c3 cc cc cc cc <8b> 07 c3 cc cc cc cc 55 83 ea 01 48 89 fe 48 c7 c7 98 6f 15 99 48
[   64.067764] RSP: 0018:ffffb24d40a5bd78 EFLAGS: 00010296
[   64.067767] RAX: ffffb24d403e5000 RBX: 0000000000000152 RCX: 000000000000007f
[   64.067769] RDX: 000000000000ff00 RSI: ffffb24d403e5010 RDI: ffffb24d403e5010
[   64.067770] RBP: ffffb24d40a5bd98 R08: ffffb24d403e5010 R09: 0000000000000000
[   64.067772] R10: ffff9074cd95e7f4 R11: 0000000000000003 R12: 000000000000007f
[   64.067773] R13: ffff9074e1a68c00 R14: ffff9074e1a68d00 R15: 0000000000009003
[   64.067775] FS:  0000000000000000(0000) GS:ffff90752a180000(0000) knlGS:0000000000000000
[   64.067776] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   64.067778] CR2: ffffb24d403e5010 CR3: 0000000119402003 CR4: 00000000003706e0
[   64.067780] note: kworker/3:10[534] exited with irqs disabled
