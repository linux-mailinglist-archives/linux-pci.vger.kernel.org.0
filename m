Return-Path: <linux-pci+bounces-11915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422B495941B
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 07:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6501C21130
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 05:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAC2166F28;
	Wed, 21 Aug 2024 05:36:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6636E79D1;
	Wed, 21 Aug 2024 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724218594; cv=none; b=VbBV417HhnIqTGfwb1oUf/leTg/wh+s6Zel3NYqMDxMCX4/UV9xHRznNtnPDRmrW5j7E/sAh0jSyXtIOzMsHzYkXGEq2idSuju3dbXS0mq6s5QVIk15Ddp88dfBDud0aprcxah5oS61FcbixFCWwRi8AffnjxImjDRCKtCPYzrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724218594; c=relaxed/simple;
	bh=vUFtQegRHtxTU8cxv+fxM+zQ6Y/AZHrakjEys0A9ksY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvoLrtTcSHRSdq9NvRd6m6Z9qRiSbJAMXV/iBN9QYgx0LST/GWdGcBGsxkLIn7ack/hnGmK9aPzuOd0njACH3Fsf/4A2fpiWmpWyowBarHcDEddykrfVCtXBiMCOJtUGyh6m2taBuFVyVIMzkg7St0QclaNgk91EGhDbl+4SwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af2a8.dynamic.kabel-deutschland.de [95.90.242.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C7EFE61E5FE05;
	Wed, 21 Aug 2024 07:36:04 +0200 (CEST)
Message-ID: <3b42a3cc-2f76-4d42-abe2-5f4e8ffe10e4@molgen.mpg.de>
Date: Wed, 21 Aug 2024 07:36:04 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `powertop --auto-tune` results in `WARN: xHC restore state
 timeout` and lost USB devices
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240821013945.GA207589@bhelgaas>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240821013945.GA207589@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Bjorn,


Thank you for taking the time to respond.

Am 21.08.24 um 03:39 schrieb Bjorn Helgaas:
> On Mon, Aug 19, 2024 at 10:52:02AM +0200, Paul Menzel wrote:

>> On an Intel Kaby Lake laptop Dell XPS 13 9360 connecting a Bizlink DELL
>> DA300 USB-C mobile adapter to the left USB-C port, and connecting a network
>> cable, and then running `sudo powertop --auto-tune` (*powertop* 2.15-3),
>> after the while the network link is lost.
>>
>>      [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.11.0-rc4 root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer mem_sleep_default=deep log_buf_len=8M cryptomgr.notests
>>      […]
>>      [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>>      […]
>>      [   58.478482] r8152-cfgselector 4-1.2: reset SuperSpeed USB device number 3 using xhci_hcd
>>      [   58.501314] r8152 4-1.2:1.0 (unnamed net_device) (uninitialized) Using pass-thru MAC addr 18:db:f2:2d:cc:f3
>>      [   58.547913] r8152 4-1.2:1.0 eth0: v1.12.13
>>      […]
>>      [   61.237907] r8152 4-1.2:1.0 enp57s0u1u2: carrier on
>>      [   62.575204] rfkill: input handler disabled
>>      [  617.828880] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>>      [  617.828954] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>>      [  617.829014] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>>      [  650.597050] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>>      [  735.588700] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>>      [  956.771529] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>>      [  979.298882] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>>      [ 1003.874549] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>>      [ 1031.528218] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>>      [ 1039.713989] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>>      [ 2193.529223] kauditd_printk_skb: 24 callbacks suppressed
>>      [ 2193.529227] audit: type=1400 audit(1724048032.697:36): apparmor="DENIED" operation="capable" class="cap" profile="/usr/sbin/cupsd" pid=9103 comm="cupsd" capability=12 capname="net_admin"
>>      [ 3411.471079] xhci_hcd 0000:39:00.0: WARN: xHC restore state timeout
>>      [ 3411.471097] xhci_hcd 0000:39:00.0: PCI post-resume error -110!
>>      [ 3411.471100] xhci_hcd 0000:39:00.0: HC died; cleaning up
>>      [ 3411.471118] usb 3-1: USB disconnect, device number 2
>>      [ 3411.471120] usb 3-1.1: USB disconnect, device number 3
>>      [ 3411.471230] usb 4-1: USB disconnect, device number 2
>>      [ 3411.471233] r8152-cfgselector 4-1.2: USB disconnect, device number 3
>>
>> Trying to disable auto-suspend for the device, PowerTOP hangs:
>>
>>      $ LANG= sudo strace powertop
>>      […]
>>    readlink("/sys/devices/pci0000:00/0000:00:1c.0/0000:01:00.0/0000:02:02.0/0000:39:00.0/usb3", 0x7ffecaa12c80, 1023) = -1 EINVAL (Invalid argument)
>>      openat(AT_FDCWD, "/sys/bus/usb/devices/usb3/bDeviceClass", O_RDONLY) = 4
>>      read(4, "09\n", 8191)                   = 3
>>      close(4)                                = 0
>>      openat(AT_FDCWD, "/sys/bus/usb/devices/usb3/manufacturer", O_RDONLY) = 4
>>      read(4,
>>
>> After re-connecting the device, PowerTOP shows:
>>
>>      Bad           Autosuspend for USB device DELL DA300 [Bizlink]
>>
>>      Bad           Autosuspend for USB device USB 10/100/1000 LAN [Realtek]
>>
>> The power usage of the laptop is pretty high (> 10 Watts), so trying to
>> decrease the power usage for longer usage time on battery is my goal.
> 
> Hi Paul, thanks for testing these -rc kernels and thanks a lot for
> this report!  Is this a regression?

I am not totally sure. I think, I used `sudo powertop --auto-tune` and 
the USB-C adapter in the past, but need to test.

> I don't have any ideas, but it reminds me a little bit of this issue:
> https://lore.kernel.org/r/60ac8988-ace4-4cf0-8c44-028ca741c0a1@kernel.org
> 
> In the log below, I see:
> 
>    - NOHZ tick-stop error; I have no idea what this means.

This happens seldomly [1].

>    - xhci_hcd HD died; this seems like something went wrong in PCI or
>      the USB adapter.
> 
>    - lots of complaints about not being able to allocate PCI I/O port
>      space; I think those are just noise because the only devices that
>      have I/O BARs are on the root bus.

I think these complaints are common, when using any USB-C adapter with 
this device.

> Sorry, this wasn't really any help.  I hope the USB folks can give us
> a hint.


Kind regards,

Paul


[1]: 
https://lore.kernel.org/all/354a2690-9bbf-4ccb-8769-fa94707a9340@molgen.mpg.de/

>> [    0.000000] Linux version 6.11.0-rc4 (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 13.3.0-2) 13.3.0, GNU ld (GNU Binutils for Debian) 2.42.50.20240710) #272 SMP PREEMPT_DYNAMIC Sun Aug 18 23:58:57 CEST 2024
>> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.11.0-rc4 root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer mem_sleep_default=deep log_buf_len=8M cryptomgr.notests
>> [    0.000000] BIOS-provided physical RAM map:
>> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
>> [    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
>> [    0.000000] BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000556aafff] usable
>> [    0.000000] BIOS-e820: [mem 0x00000000556ab000-0x00000000556abfff] ACPI NVS
>> [    0.000000] BIOS-e820: [mem 0x00000000556ac000-0x00000000556acfff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000556ad000-0x0000000064df3fff] usable
>> [    0.000000] BIOS-e820: [mem 0x0000000064df4000-0x000000006517ffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000065180000-0x00000000651c3fff] ACPI data
>> [    0.000000] BIOS-e820: [mem 0x00000000651c4000-0x000000006f871fff] ACPI NVS
>> [    0.000000] BIOS-e820: [mem 0x000000006f872000-0x000000006fffefff] reserved
>> [    0.000000] BIOS-e820: [mem 0x000000006ffff000-0x000000006fffffff] usable
>> [    0.000000] BIOS-e820: [mem 0x0000000070000000-0x0000000077ffffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000078000000-0x00000000785fffff] usable
>> [    0.000000] BIOS-e820: [mem 0x0000000078600000-0x000000007c7fffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
>> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
>> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004817fffff] usable
>> [    0.000000] NX (Execute Disable) protection: active
>> [    0.000000] APIC: Static calls initialized
>> [    0.000000] e820: update [mem 0x511e0018-0x511f0057] usable ==> usable
>> [    0.000000] extended physical RAM map:
>> [    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
>> [    0.000000] reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
>> [    0.000000] reserve setup_data: [mem 0x0000000000059000-0x000000000009dfff] usable
>> [    0.000000] reserve setup_data: [mem 0x000000000009e000-0x00000000000fffff] reserved
>> [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x00000000511e0017] usable
>> [    0.000000] reserve setup_data: [mem 0x00000000511e0018-0x00000000511f0057] usable
>> [    0.000000] reserve setup_data: [mem 0x00000000511f0058-0x00000000556aafff] usable
>> [    0.000000] reserve setup_data: [mem 0x00000000556ab000-0x00000000556abfff] ACPI NVS
>> [    0.000000] reserve setup_data: [mem 0x00000000556ac000-0x00000000556acfff] reserved
>> [    0.000000] reserve setup_data: [mem 0x00000000556ad000-0x0000000064df3fff] usable
>> [    0.000000] reserve setup_data: [mem 0x0000000064df4000-0x000000006517ffff] reserved
>> [    0.000000] reserve setup_data: [mem 0x0000000065180000-0x00000000651c3fff] ACPI data
>> [    0.000000] reserve setup_data: [mem 0x00000000651c4000-0x000000006f871fff] ACPI NVS
>> [    0.000000] reserve setup_data: [mem 0x000000006f872000-0x000000006fffefff] reserved
>> [    0.000000] reserve setup_data: [mem 0x000000006ffff000-0x000000006fffffff] usable
>> [    0.000000] reserve setup_data: [mem 0x0000000070000000-0x0000000077ffffff] reserved
>> [    0.000000] reserve setup_data: [mem 0x0000000078000000-0x00000000785fffff] usable
>> [    0.000000] reserve setup_data: [mem 0x0000000078600000-0x000000007c7fffff] reserved
>> [    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffffff] reserved
>> [    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
>> [    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
>> [    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
>> [    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
>> [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x00000004817fffff] usable
>> [    0.000000] efi: EFI v2.4 by American Megatrends
>> [    0.000000] efi: ACPI=0x6518d000 ACPI 2.0=0x6518d000 SMBIOS=0xf0000 SMBIOS 3.0=0xf0020 TPMFinalLog=0x6f812000 ESRT=0x6fc86698 MEMATTR=0x62679298 INITRD=0x5577da98 TPMEventLog=0x55778018
>> [    0.000000] efi: Remove mem36: MMIO range=[0xe0000000-0xefffffff] (256MB) from e820 map
>> [    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
>> [    0.000000] efi: Not removing mem37: MMIO range=[0xfe000000-0xfe010fff] (68KB) from e820 map
>> [    0.000000] efi: Not removing mem38: MMIO range=[0xfec00000-0xfec00fff] (4KB) from e820 map
>> [    0.000000] efi: Not removing mem39: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
>> [    0.000000] efi: Remove mem40: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
>> [    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
>> [    0.000000] SMBIOS 3.0.0 present.
>> [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>> [    0.000000] DMI: Memory slots populated: 2/2
>> [    0.000000] tsc: Detected 2900.000 MHz processor
>> [    0.000000] tsc: Detected 2899.886 MHz TSC
>> [    0.000677] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
>> [    0.000680] e820: remove [mem 0x000a0000-0x000fffff] usable
>> [    0.000685] last_pfn = 0x481800 max_arch_pfn = 0x400000000
>> [    0.000688] MTRR map: 4 entries (3 fixed + 1 variable; max 23), built from 10 variable MTRRs
>> [    0.000690] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
>> [    0.000970] last_pfn = 0x78600 max_arch_pfn = 0x400000000
>> [    0.006816] esrt: Reserving ESRT space from 0x000000006fc86698 to 0x000000006fc866d0.
>> [    0.006822] Using GB pages for direct mapping
>> [    0.013327] printk: log_buf_len: 8388608 bytes
>> [    0.013328] printk: early log buf free: 125368(95%)
>> [    0.013329] Secure boot disabled
>> [    0.013330] RAMDISK: [mem 0x511f1000-0x52609fff]
>> [    0.013334] ACPI: Early table checksum verification disabled
>> [    0.013337] ACPI: RSDP 0x000000006518D000 000024 (v02 DELL  )
>> [    0.013341] ACPI: XSDT 0x000000006518D0C8 00010C (v01 DELL   CBX3     01072009 AMI  00010013)
>> [    0.013353] ACPI: FACP 0x00000000651B2A48 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
>> [    0.013357] ACPI: DSDT 0x000000006518D260 0257E7 (v02 DELL   CBX3     01072009 INTL 20160422)
>> [    0.013360] ACPI: FACS 0x000000006F86F180 000040
>> [    0.013361] ACPI: APIC 0x00000000651B2B58 000084 (v03 DELL   CBX3     01072009 AMI  00010013)
>> [    0.013364] ACPI: FPDT 0x00000000651B2BE0 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
>> [    0.013366] ACPI: FIDT 0x00000000651B2C28 0000AC (v01 DELL   CBX3     01072009 AMI  00010013)
>> [    0.013368] ACPI: MCFG 0x00000000651B2CD8 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
>> [    0.013370] ACPI: HPET 0x00000000651B2D18 000038 (v01 DELL   CBX3     01072009 AMI. 0005000B)
>> [    0.013372] ACPI: SSDT 0x00000000651B2D50 000359 (v01 SataRe SataTabl 00001000 INTL 20160422)
>> [    0.013374] ACPI: BOOT 0x00000000651B30B0 000028 (v01 DELL   CBX3     01072009 AMI  00010013)
>> [    0.013376] ACPI: SSDT 0x00000000651B30D8 0012CF (v02 SaSsdt SaSsdt   00003000 INTL 20160422)
>> [    0.013378] ACPI: HPET 0x00000000651B43A8 000038 (v01 INTEL  KBL-ULT  00000001 MSFT 0000005F)
>> [    0.013380] ACPI: SSDT 0x00000000651B43E0 000D84 (v02 INTEL  xh_rvp07 00000000 INTL 20160422)
>> [    0.013382] ACPI: UEFI 0x00000000651B5168 000042 (v01                 00000000      00000000)
>> [    0.013385] ACPI: SSDT 0x00000000651B51B0 000EDE (v02 CpuRef CpuSsdt  00003000 INTL 20160422)
>> [    0.013387] ACPI: LPIT 0x00000000651B6090 000094 (v01 INTEL  KBL-ULT  00000000 MSFT 0000005F)
>> [    0.013389] ACPI: WSMT 0x00000000651B6128 000028 (v01 DELL   CBX3     00000000 MSFT 0000005F)
>> [    0.013391] ACPI: SSDT 0x00000000651B6150 000161 (v02 INTEL  HdaDsp   00000000 INTL 20160422)
>> [    0.013393] ACPI: SSDT 0x00000000651B62B8 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
>> [    0.013395] ACPI: SSDT 0x00000000651B6558 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
>> [    0.013397] ACPI: SSDT 0x00000000651B9560 0000DB (v02 INTEL  TbtTypeC 00000000 INTL 20160422)
>> [    0.013399] ACPI: DBGP 0x00000000651B9640 000034 (v01 INTEL           00000002 MSFT 0000005F)
>> [    0.013401] ACPI: DBG2 0x00000000651B9678 000054 (v00 INTEL           00000002 MSFT 0000005F)
>> [    0.013403] ACPI: SSDT 0x00000000651B96D0 0007DD (v02 INTEL  UsbCTabl 00001000 INTL 20160422)
>> [    0.013406] ACPI: SSDT 0x00000000651B9EB0 0084F1 (v02 DptfTa DptfTabl 00001000 INTL 20160422)
>> [    0.013408] ACPI: SLIC 0x00000000651C23A8 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
>> [    0.013410] ACPI: NHLT 0x00000000651C2520 00002D (v00 INTEL  EDK2     00000002      01000013)
>> [    0.013412] ACPI: BGRT 0x00000000651C2550 000038 (v00                 01072009 AMI  00010013)
>> [    0.013414] ACPI: TPM2 0x00000000651C2588 000034 (v03        Tpm2Tabl 00000001 AMI  00000000)
>> [    0.013416] ACPI: ASF! 0x00000000651C25C0 0000A0 (v32 INTEL   HCG     00000001 TFSM 000F4240)
>> [    0.013418] ACPI: DMAR 0x00000000651C2660 0000F0 (v01 INTEL  KBL      00000001 INTL 00000001)
>> [    0.013420] ACPI: Reserving FACP table memory at [mem 0x651b2a48-0x651b2b53]
>> [    0.013421] ACPI: Reserving DSDT table memory at [mem 0x6518d260-0x651b2a46]
>> [    0.013422] ACPI: Reserving FACS table memory at [mem 0x6f86f180-0x6f86f1bf]
>> [    0.013423] ACPI: Reserving APIC table memory at [mem 0x651b2b58-0x651b2bdb]
>> [    0.013423] ACPI: Reserving FPDT table memory at [mem 0x651b2be0-0x651b2c23]
>> [    0.013424] ACPI: Reserving FIDT table memory at [mem 0x651b2c28-0x651b2cd3]
>> [    0.013425] ACPI: Reserving MCFG table memory at [mem 0x651b2cd8-0x651b2d13]
>> [    0.013425] ACPI: Reserving HPET table memory at [mem 0x651b2d18-0x651b2d4f]
>> [    0.013426] ACPI: Reserving SSDT table memory at [mem 0x651b2d50-0x651b30a8]
>> [    0.013427] ACPI: Reserving BOOT table memory at [mem 0x651b30b0-0x651b30d7]
>> [    0.013428] ACPI: Reserving SSDT table memory at [mem 0x651b30d8-0x651b43a6]
>> [    0.013428] ACPI: Reserving HPET table memory at [mem 0x651b43a8-0x651b43df]
>> [    0.013429] ACPI: Reserving SSDT table memory at [mem 0x651b43e0-0x651b5163]
>> [    0.013430] ACPI: Reserving UEFI table memory at [mem 0x651b5168-0x651b51a9]
>> [    0.013430] ACPI: Reserving SSDT table memory at [mem 0x651b51b0-0x651b608d]
>> [    0.013431] ACPI: Reserving LPIT table memory at [mem 0x651b6090-0x651b6123]
>> [    0.013432] ACPI: Reserving WSMT table memory at [mem 0x651b6128-0x651b614f]
>> [    0.013432] ACPI: Reserving SSDT table memory at [mem 0x651b6150-0x651b62b0]
>> [    0.013433] ACPI: Reserving SSDT table memory at [mem 0x651b62b8-0x651b6556]
>> [    0.013434] ACPI: Reserving SSDT table memory at [mem 0x651b6558-0x651b9559]
>> [    0.013435] ACPI: Reserving SSDT table memory at [mem 0x651b9560-0x651b963a]
>> [    0.013435] ACPI: Reserving DBGP table memory at [mem 0x651b9640-0x651b9673]
>> [    0.013436] ACPI: Reserving DBG2 table memory at [mem 0x651b9678-0x651b96cb]
>> [    0.013437] ACPI: Reserving SSDT table memory at [mem 0x651b96d0-0x651b9eac]
>> [    0.013437] ACPI: Reserving SSDT table memory at [mem 0x651b9eb0-0x651c23a0]
>> [    0.013438] ACPI: Reserving SLIC table memory at [mem 0x651c23a8-0x651c251d]
>> [    0.013439] ACPI: Reserving NHLT table memory at [mem 0x651c2520-0x651c254c]
>> [    0.013439] ACPI: Reserving BGRT table memory at [mem 0x651c2550-0x651c2587]
>> [    0.013440] ACPI: Reserving TPM2 table memory at [mem 0x651c2588-0x651c25bb]
>> [    0.013441] ACPI: Reserving ASF! table memory at [mem 0x651c25c0-0x651c265f]
>> [    0.013442] ACPI: Reserving DMAR table memory at [mem 0x651c2660-0x651c274f]
>> [    0.013567] No NUMA configuration found
>> [    0.013568] Faking a node at [mem 0x0000000000000000-0x00000004817fffff]
>> [    0.013576] NODE_DATA(0) allocated [mem 0x47f3d5000-0x47f3fffff]
>> [    0.013744] Zone ranges:
>> [    0.013745]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>> [    0.013746]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>> [    0.013747]   Normal   [mem 0x0000000100000000-0x00000004817fffff]
>> [    0.013749]   Device   empty
>> [    0.013749] Movable zone start for each node
>> [    0.013751] Early memory node ranges
>> [    0.013752]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
>> [    0.013753]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
>> [    0.013754]   node   0: [mem 0x0000000000100000-0x00000000556aafff]
>> [    0.013755]   node   0: [mem 0x00000000556ad000-0x0000000064df3fff]
>> [    0.013756]   node   0: [mem 0x000000006ffff000-0x000000006fffffff]
>> [    0.013756]   node   0: [mem 0x0000000078000000-0x00000000785fffff]
>> [    0.013757]   node   0: [mem 0x0000000100000000-0x00000004817fffff]
>> [    0.013759] Initmem setup node 0 [mem 0x0000000000001000-0x00000004817fffff]
>> [    0.013762] On node 0, zone DMA: 1 pages in unavailable ranges
>> [    0.013764] On node 0, zone DMA: 1 pages in unavailable ranges
>> [    0.013787] On node 0, zone DMA: 98 pages in unavailable ranges
>> [    0.016136] On node 0, zone DMA32: 2 pages in unavailable ranges
>> [    0.016543] On node 0, zone DMA32: 45579 pages in unavailable ranges
>> [    0.017075] On node 0, zone Normal: 31232 pages in unavailable ranges
>> [    0.017308] On node 0, zone Normal: 26624 pages in unavailable ranges
>> [    0.017316] Reserving Intel graphics memory at [mem 0x7a800000-0x7c7fffff]
>> [    0.017494] ACPI: PM-Timer IO Port: 0x1808
>> [    0.017499] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
>> [    0.017501] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
>> [    0.017501] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
>> [    0.017502] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
>> [    0.017528] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
>> [    0.017530] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>> [    0.017531] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
>> [    0.017534] ACPI: Using ACPI (MADT) for SMP configuration information
>> [    0.017535] ACPI: HPET id: 0x8086a701 base: 0xfed00000
>> [    0.017541] e820: update [mem 0x62260000-0x623ecfff] usable ==> reserved
>> [    0.017548] TSC deadline timer available
>> [    0.017551] CPU topo: Max. logical packages:   1
>> [    0.017552] CPU topo: Max. logical dies:       1
>> [    0.017552] CPU topo: Max. dies per package:   1
>> [    0.017559] CPU topo: Max. threads per core:   2
>> [    0.017561] CPU topo: Num. cores per package:     2
>> [    0.017561] CPU topo: Num. threads per package:   4
>> [    0.017562] CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
>> [    0.017582] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
>> [    0.017584] PM: hibernation: Registered nosave memory: [mem 0x00058000-0x00058fff]
>> [    0.017586] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x000fffff]
>> [    0.017587] PM: hibernation: Registered nosave memory: [mem 0x511e0000-0x511e0fff]
>> [    0.017589] PM: hibernation: Registered nosave memory: [mem 0x511f0000-0x511f0fff]
>> [    0.017590] PM: hibernation: Registered nosave memory: [mem 0x556ab000-0x556abfff]
>> [    0.017591] PM: hibernation: Registered nosave memory: [mem 0x556ac000-0x556acfff]
>> [    0.017593] PM: hibernation: Registered nosave memory: [mem 0x62260000-0x623ecfff]
>> [    0.017594] PM: hibernation: Registered nosave memory: [mem 0x64df4000-0x6517ffff]
>> [    0.017595] PM: hibernation: Registered nosave memory: [mem 0x65180000-0x651c3fff]
>> [    0.017595] PM: hibernation: Registered nosave memory: [mem 0x651c4000-0x6f871fff]
>> [    0.017596] PM: hibernation: Registered nosave memory: [mem 0x6f872000-0x6fffefff]
>> [    0.017598] PM: hibernation: Registered nosave memory: [mem 0x70000000-0x77ffffff]
>> [    0.017599] PM: hibernation: Registered nosave memory: [mem 0x78600000-0x7c7fffff]
>> [    0.017600] PM: hibernation: Registered nosave memory: [mem 0x7c800000-0xfdffffff]
>> [    0.017600] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
>> [    0.017601] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
>> [    0.017602] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
>> [    0.017602] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
>> [    0.017603] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
>> [    0.017603] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xffffffff]
>> [    0.017605] [mem 0x7c800000-0xfdffffff] available for PCI devices
>> [    0.017606] Booting paravirtualized kernel on bare hardware
>> [    0.017607] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
>> [    0.022010] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
>> [    0.022336] percpu: Embedded 94 pages/cpu s290816 r65536 d28672 u524288
>> [    0.022342] pcpu-alloc: s290816 r65536 d28672 u524288 alloc=1*2097152
>> [    0.022344] pcpu-alloc: [0] 0 1 2 3
>> [    0.022362] Kernel command line: BOOT_IMAGE=/vmlinuz-6.11.0-rc4 root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer mem_sleep_default=deep log_buf_len=8M cryptomgr.notests
>> [    0.022420] Unknown kernel command line parameters "BOOT_IMAGE=/vmlinuz-6.11.0-rc4", will be passed to user space.
>> [    0.022446] random: crng init done
>> [    0.023933] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
>> [    0.024695] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
>> [    0.024742] Fallback order for Node 0: 0
>> [    0.024745] Built 1 zonelists, mobility grouping on.  Total pages: 4090767
>> [    0.024746] Policy zone: Normal
>> [    0.024751] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
>> [    0.024757] software IO TLB: area num 4.
>> [    0.043091] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
>> [    0.043093] kmemleak: Kernel memory leak detector disabled
>> [    0.043119] ftrace: allocating 42535 entries in 167 pages
>> [    0.049868] ftrace: allocated 167 pages with 5 groups
>> [    0.050479] Dynamic Preempt: voluntary
>> [    0.050510] rcu: Preemptible hierarchical RCU implementation.
>> [    0.050510] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
>> [    0.050511] 	Trampoline variant of Tasks RCU enabled.
>> [    0.050512] 	Rude variant of Tasks RCU enabled.
>> [    0.050512] 	Tracing variant of Tasks RCU enabled.
>> [    0.050513] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
>> [    0.050513] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
>> [    0.050518] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
>> [    0.050519] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
>> [    0.050521] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
>> [    0.052970] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
>> [    0.053179] rcu: srcu_init: Setting srcu_struct sizes based on contention.
>> [    0.053358] spurious 8259A interrupt: IRQ7.
>> [    0.053383] Console: colour dummy device 80x25
>> [    0.053385] printk: legacy console [tty0] enabled
>> [    0.053421] ACPI: Core revision 20240322
>> [    0.053573] hpet: HPET dysfunctional in PC10. Force disabled.
>> [    0.053574] APIC: Switch to symmetric I/O mode setup
>> [    0.053576] DMAR: Host address width 39
>> [    0.053577] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
>> [    0.053582] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
>> [    0.053584] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
>> [    0.053589] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
>> [    0.053591] DMAR: RMRR base: 0x00000064ec2000 end: 0x00000064ee1fff
>> [    0.053594] DMAR: RMRR base: 0x0000007a000000 end: 0x0000007c7fffff
>> [    0.053597] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
>> [    0.053598] DMAR: ANDD device: 2 name: \_SB.PCI0.I2C1
>> [    0.053600] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
>> [    0.053601] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
>> [    0.053602] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
>> [    0.055405] DMAR-IR: Enabled IRQ remapping in x2apic mode
>> [    0.055407] x2apic enabled
>> [    0.055466] APIC: Switched APIC routing to: cluster x2apic
>> [    0.059291] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x29ccd767b87, max_idle_ns: 440795223720 ns
>> [    0.059296] Calibrating delay loop (skipped), value calculated using timer frequency.. 5799.77 BogoMIPS (lpj=11599544)
>> [    0.059325] CPU0: Thermal monitoring enabled (TM1)
>> [    0.059362] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
>> [    0.059363] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
>> [    0.059367] process: using mwait in idle threads
>> [    0.059370] Spectre V2 : User space: Vulnerable
>> [    0.059371] Speculative Store Bypass: Vulnerable
>> [    0.059374] SRBDS: Vulnerable
>> [    0.059378] GDS: Vulnerable
>> [    0.059383] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
>> [    0.059384] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
>> [    0.059384] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
>> [    0.059385] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
>> [    0.059386] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
>> [    0.059387] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
>> [    0.059388] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
>> [    0.059389] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
>> [    0.059390] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
>> [    0.063294] Freeing SMP alternatives memory: 36K
>> [    0.063294] pid_max: default: 32768 minimum: 301
>> [    0.063294] LSM: initializing lsm=capability,landlock,apparmor,bpf
>> [    0.063294] landlock: Up and running.
>> [    0.063294] AppArmor: AppArmor initialized
>> [    0.063294] LSM support for eBPF active
>> [    0.063294] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
>> [    0.063294] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
>> [    0.063294] smpboot: CPU0: Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz (family: 0x6, model: 0x8e, stepping: 0x9)
>> [    0.063294] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
>> [    0.063294] ... version:                4
>> [    0.063294] ... bit width:              48
>> [    0.063294] ... generic registers:      4
>> [    0.063294] ... value mask:             0000ffffffffffff
>> [    0.063294] ... max period:             00007fffffffffff
>> [    0.063294] ... fixed-purpose events:   3
>> [    0.063294] ... event mask:             000000070000000f
>> [    0.063294] signal: max sigframe size: 1616
>> [    0.063294] Estimated ratio of average max frequency by base frequency (times 1024): 1235
>> [    0.063294] rcu: Hierarchical SRCU implementation.
>> [    0.063294] rcu: 	Max phase no-delay instances is 1000.
>> [    0.063294] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
>> [    0.063294] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
>> [    0.063294] smp: Bringing up secondary CPUs ...
>> [    0.063294] smpboot: x86: Booting SMP configuration:
>> [    0.063294] .... node  #0, CPUs:      #1 #2 #3
>> [    0.063430] smp: Brought up 1 node, 4 CPUs
>> [    0.063430] smpboot: Total of 4 processors activated (23199.08 BogoMIPS)
>> [    0.086723] node 0 deferred pages initialised in 20ms
>> [    0.086723] Memory: 15896632K/16363068K available (14336K kernel code, 2506K rwdata, 9804K rodata, 2892K init, 6576K bss, 455552K reserved, 0K cma-reserved)
>> [    0.086725] devtmpfs: initialized
>> [    0.086725] x86/mm: Memory block size: 128MB
>> [    0.088298] ACPI: PM: Registering ACPI NVS region [mem 0x556ab000-0x556abfff] (4096 bytes)
>> [    0.088298] ACPI: PM: Registering ACPI NVS region [mem 0x651c4000-0x6f871fff] (174776320 bytes)
>> [    0.088675] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
>> [    0.088682] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
>> [    0.088744] pinctrl core: initialized pinctrl subsystem
>> [    0.089187] NET: Registered PF_NETLINK/PF_ROUTE protocol family
>> [    0.089378] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
>> [    0.089493] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
>> [    0.089605] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
>> [    0.089619] audit: initializing netlink subsys (disabled)
>> [    0.089643] audit: type=2000 audit(1724045838.028:1): state=initialized audit_enabled=0 res=1
>> [    0.089643] thermal_sys: Registered thermal governor 'fair_share'
>> [    0.089643] thermal_sys: Registered thermal governor 'bang_bang'
>> [    0.089643] thermal_sys: Registered thermal governor 'step_wise'
>> [    0.089643] thermal_sys: Registered thermal governor 'user_space'
>> [    0.089643] thermal_sys: Registered thermal governor 'power_allocator'
>> [    0.089643] cpuidle: using governor ladder
>> [    0.089643] cpuidle: using governor menu
>> [    0.089643] Simple Boot Flag at 0x47 set to 0x80
>> [    0.089643] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
>> [    0.089643] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
>> [    0.089643] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
>> [    0.089643] PCI: Using configuration type 1 for base access
>> [    0.089643] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
>> [    0.089643] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
>> [    0.089643] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
>> [    0.089643] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
>> [    0.089643] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
>> [    0.091352] ACPI: Added _OSI(Module Device)
>> [    0.091352] ACPI: Added _OSI(Processor Device)
>> [    0.091352] ACPI: Added _OSI(3.0 _SCP Extensions)
>> [    0.091352] ACPI: Added _OSI(Processor Aggregator Device)
>> [    0.122175] ACPI: 11 ACPI AML tables successfully acquired and loaded
>> [    0.127550] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
>> [    0.132008] ACPI: Dynamic OEM Table Load:
>> [    0.132014] ACPI: SSDT 0xFFFF932841622C00 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160422)
>> [    0.132810] ACPI: Dynamic OEM Table Load:
>> [    0.132814] ACPI: SSDT 0xFFFF9328411EE800 0006F6 (v02 PmRef  Cpu0Ist  00003000 INTL 20160422)
>> [    0.134240] ACPI: Dynamic OEM Table Load:
>> [    0.134244] ACPI: SSDT 0xFFFF9328411E8000 00065C (v02 PmRef  ApIst    00003000 INTL 20160422)
>> [    0.135986] ACPI: Dynamic OEM Table Load:
>> [    0.135989] ACPI: SSDT 0xFFFF93284165F400 00018A (v02 PmRef  ApCst    00003000 INTL 20160422)
>> [    0.138378] ACPI: EC: EC started
>> [    0.138379] ACPI: EC: interrupt blocked
>> [    0.143402] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
>> [    0.143404] ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC used to handle transactions
>> [    0.143406] ACPI: Interpreter enabled
>> [    0.143440] ACPI: PM: (supports S0 S3 S4 S5)
>> [    0.143443] ACPI: Using IOAPIC for interrupt routing
>> [    0.143476] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
>> [    0.143477] PCI: Using E820 reservations for host bridge windows
>> [    0.143988] ACPI: Enabled 8 GPEs in block 00 to 7F
>> [    0.148574] ACPI: \_SB_.PCI0.RP09.PXSX.WRST: New power resource
>> [    0.148821] ACPI: \_SB_.PCI0.RP10.PXSX.WRST: New power resource
>> [    0.149065] ACPI: \_SB_.PCI0.RP11.PXSX.WRST: New power resource
>> [    0.149307] ACPI: \_SB_.PCI0.RP12.PXSX.WRST: New power resource
>> [    0.149547] ACPI: \_SB_.PCI0.RP13.PXSX.WRST: New power resource
>> [    0.149788] ACPI: \_SB_.PCI0.RP01.PXSX.WRST: New power resource
>> [    0.150368] ACPI: \_SB_.PCI0.RP02.PXSX.WRST: New power resource
>> [    0.150610] ACPI: \_SB_.PCI0.RP03.PXSX.WRST: New power resource
>> [    0.150852] ACPI: \_SB_.PCI0.RP04.PXSX.WRST: New power resource
>> [    0.151097] ACPI: \_SB_.PCI0.RP05.PXSX.WRST: New power resource
>> [    0.151341] ACPI: \_SB_.PCI0.RP06.PXSX.WRST: New power resource
>> [    0.151585] ACPI: \_SB_.PCI0.RP07.PXSX.WRST: New power resource
>> [    0.151828] ACPI: \_SB_.PCI0.RP08.PXSX.WRST: New power resource
>> [    0.152075] ACPI: \_SB_.PCI0.RP17.PXSX.WRST: New power resource
>> [    0.152319] ACPI: \_SB_.PCI0.RP18.PXSX.WRST: New power resource
>> [    0.152561] ACPI: \_SB_.PCI0.RP19.PXSX.WRST: New power resource
>> [    0.152804] ACPI: \_SB_.PCI0.RP20.PXSX.WRST: New power resource
>> [    0.153808] ACPI: \_SB_.PCI0.RP14.PXSX.WRST: New power resource
>> [    0.154050] ACPI: \_SB_.PCI0.RP15.PXSX.WRST: New power resource
>> [    0.154291] ACPI: \_SB_.PCI0.RP16.PXSX.WRST: New power resource
>> [    0.174233] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
>> [    0.174239] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
>> [    0.174390] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME]
>> [    0.174668] acpi PNP0A08:00: _OSC: OS now controls [PCIeCapability LTR]
>> [    0.174669] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
>> [    0.175401] PCI host bridge to bus 0000:00
>> [    0.175404] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>> [    0.175407] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>> [    0.175409] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
>> [    0.175410] pci_bus 0000:00: root bus resource [mem 0x7c800000-0xdfffffff window]
>> [    0.175411] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
>> [    0.175412] pci_bus 0000:00: root bus resource [bus 00-fe]
>> [    0.175427] pci 0000:00:00.0: [8086:5904] type 00 class 0x060000 conventional PCI endpoint
>> [    0.175491] pci 0000:00:02.0: [8086:5916] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
>> [    0.175497] pci 0000:00:02.0: BAR 0 [mem 0xdb000000-0xdbffffff 64bit]
>> [    0.175502] pci 0000:00:02.0: BAR 2 [mem 0x90000000-0x9fffffff 64bit pref]
>> [    0.175505] pci 0000:00:02.0: BAR 4 [io  0xf000-0xf03f]
>> [    0.175518] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
>> [    0.175639] pci 0000:00:04.0: [8086:1903] type 00 class 0x118000 conventional PCI endpoint
>> [    0.175646] pci 0000:00:04.0: BAR 0 [mem 0xdc320000-0xdc327fff 64bit]
>> [    0.175882] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330 conventional PCI endpoint
>> [    0.175898] pci 0000:00:14.0: BAR 0 [mem 0xdc310000-0xdc31ffff 64bit]
>> [    0.175951] pci 0000:00:14.0: PME# supported from D3hot D3cold
>> [    0.176381] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000 conventional PCI endpoint
>> [    0.176397] pci 0000:00:14.2: BAR 0 [mem 0xdc334000-0xdc334fff 64bit]
>> [    0.176526] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000 conventional PCI endpoint
>> [    0.176555] pci 0000:00:15.0: BAR 0 [mem 0xdc333000-0xdc333fff 64bit]
>> [    0.176871] pci 0000:00:15.1: [8086:9d61] type 00 class 0x118000 conventional PCI endpoint
>> [    0.176900] pci 0000:00:15.1: BAR 0 [mem 0xdc332000-0xdc332fff 64bit]
>> [    0.177181] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000 conventional PCI endpoint
>> [    0.177194] pci 0000:00:16.0: BAR 0 [mem 0xdc331000-0xdc331fff 64bit]
>> [    0.177236] pci 0000:00:16.0: PME# supported from D3hot
>> [    0.177513] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400 PCIe Root Port
>> [    0.177530] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
>> [    0.177535] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
>> [    0.177541] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
>> [    0.177581] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
>> [    0.177951] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400 PCIe Root Port
>> [    0.177971] pci 0000:00:1c.4: PCI bridge to [bus 3a]
>> [    0.177975] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
>> [    0.178032] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
>> [    0.178408] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400 PCIe Root Port
>> [    0.178426] pci 0000:00:1d.0: PCI bridge to [bus 3b]
>> [    0.178429] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
>> [    0.178476] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
>> [    0.178864] pci 0000:00:1f.0: [8086:9d58] type 00 class 0x060100 conventional PCI endpoint
>> [    0.179130] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000 conventional PCI endpoint
>> [    0.179141] pci 0000:00:1f.2: BAR 0 [mem 0xdc32c000-0xdc32ffff]
>> [    0.179337] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040380 conventional PCI endpoint
>> [    0.179355] pci 0000:00:1f.3: BAR 0 [mem 0xdc328000-0xdc32bfff 64bit]
>> [    0.179379] pci 0000:00:1f.3: BAR 4 [mem 0xdc300000-0xdc30ffff 64bit]
>> [    0.179419] pci 0000:00:1f.3: PME# supported from D3hot D3cold
>> [    0.179938] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500 conventional PCI endpoint
>> [    0.179996] pci 0000:00:1f.4: BAR 0 [mem 0xdc330000-0xdc3300ff 64bit]
>> [    0.180066] pci 0000:00:1f.4: BAR 4 [io  0xf040-0xf05f]
>> [    0.180347] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
>> [    0.180672] pci 0000:3a:00.0: [168c:003e] type 00 class 0x028000 PCIe Endpoint
>> [    0.180889] pci 0000:3a:00.0: BAR 0 [mem 0xdc000000-0xdc1fffff 64bit]
>> [    0.182087] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
>> [    0.183864] pci 0000:00:1c.4: PCI bridge to [bus 3a]
>> [    0.183946] pci 0000:3b:00.0: [1c5c:1284] type 00 class 0x010802 PCIe Endpoint
>> [    0.183966] pci 0000:3b:00.0: BAR 0 [mem 0xdc200000-0xdc203fff 64bit]
>> [    0.184074] pci 0000:3b:00.0: PME# supported from D0 D1 D3hot
>> [    0.184391] pci 0000:00:1d.0: PCI bridge to [bus 3b]
>> [    0.187816] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
>> [    0.187861] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
>> [    0.187903] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
>> [    0.187945] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
>> [    0.187987] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
>> [    0.188029] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
>> [    0.188071] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
>> [    0.188113] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
>> [    0.196486] ACPI: EC: interrupt unblocked
>> [    0.196488] ACPI: EC: event unblocked
>> [    0.196493] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
>> [    0.196494] ACPI: EC: GPE=0x14
>> [    0.196495] ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC initialization complete
>> [    0.196497] ACPI: \_SB_.PCI0.LPCB.ECDV: EC: Used to handle transactions and events
>> [    0.196559] iommu: Default domain type: Translated
>> [    0.196559] iommu: DMA domain TLB invalidation policy: lazy mode
>> [    0.196559] pps_core: LinuxPPS API ver. 1 registered
>> [    0.196559] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
>> [    0.196559] PTP clock support registered
>> [    0.196559] EDAC MC: Ver: 3.0.0
>> [    0.196559] efivars: Registered efivars operations
>> [    0.196559] NetLabel: Initializing
>> [    0.196559] NetLabel:  domain hash size = 128
>> [    0.196559] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
>> [    0.196559] NetLabel:  unlabeled traffic allowed by default
>> [    0.196559] PCI: Using ACPI for IRQ routing
>> [    0.221975] PCI: pci_cache_line_size set to 64 bytes
>> [    0.222351] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
>> [    0.222352] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
>> [    0.222353] e820: reserve RAM buffer [mem 0x511e0018-0x53ffffff]
>> [    0.222354] e820: reserve RAM buffer [mem 0x556ab000-0x57ffffff]
>> [    0.222355] e820: reserve RAM buffer [mem 0x62260000-0x63ffffff]
>> [    0.222356] e820: reserve RAM buffer [mem 0x64df4000-0x67ffffff]
>> [    0.222357] e820: reserve RAM buffer [mem 0x78600000-0x7bffffff]
>> [    0.222358] e820: reserve RAM buffer [mem 0x481800000-0x483ffffff]
>> [    0.222387] pci 0000:00:02.0: vgaarb: setting as boot VGA device
>> [    0.222387] pci 0000:00:02.0: vgaarb: bridge control possible
>> [    0.222387] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
>> [    0.222387] vgaarb: loaded
>> [    0.222387] clocksource: Switched to clocksource tsc-early
>> [    0.222387] VFS: Disk quotas dquot_6.6.0
>> [    0.222387] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
>> [    0.222387] AppArmor: AppArmor Filesystem Enabled
>> [    0.222387] pnp: PnP ACPI init
>> [    0.222387] system 00:00: [io  0x0680-0x069f] has been reserved
>> [    0.222387] system 00:00: [io  0xffff] has been reserved
>> [    0.222387] system 00:00: [io  0xffff] has been reserved
>> [    0.222387] system 00:00: [io  0xffff] has been reserved
>> [    0.222387] system 00:00: [io  0x1800-0x18fe] has been reserved
>> [    0.222387] system 00:00: [io  0x164e-0x164f] has been reserved
>> [    0.222387] system 00:02: [io  0x1854-0x1857] has been reserved
>> [    0.222387] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
>> [    0.222387] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
>> [    0.222387] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
>> [    0.222387] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
>> [    0.222387] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
>> [    0.222387] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
>> [    0.222387] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
>> [    0.222387] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
>> [    0.222387] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reserved
>> [    0.222387] system 00:05: [mem 0xdffe0000-0xdfffffff] has been reserved
>> [    0.222387] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
>> [    0.222387] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
>> [    0.222387] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
>> [    0.222387] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reserved
>> [    0.222387] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
>> [    0.222387] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
>> [    0.222387] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
>> [    0.222387] system 00:07: [io  0xff00-0xfffe] has been reserved
>> [    0.222387] system 00:08: [mem 0xfe029000-0xfe029fff] has been reserved
>> [    0.222387] system 00:08: [mem 0xfe028000-0xfe028fff] has been reserved
>> [    0.225984] pnp: PnP ACPI: found 9 devices
>> [    0.231288] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
>> [    0.231332] NET: Registered PF_INET protocol family
>> [    0.231448] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
>> [    0.242733] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
>> [    0.242758] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
>> [    0.242798] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
>> [    0.242981] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
>> [    0.243179] TCP: Hash tables configured (established 131072 bind 65536)
>> [    0.243247] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
>> [    0.243287] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
>> [    0.243319] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
>> [    0.243372] NET: Registered PF_UNIX/PF_LOCAL protocol family
>> [    0.243377] NET: Registered PF_XDP protocol family
>> [    0.243384] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01-39] add_size 1000
>> [    0.243394] pci 0000:00:1c.0: bridge window [io  0x2000-0x2fff]: assigned
>> [    0.243397] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
>> [    0.243399] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
>> [    0.243402] pci 0000:00:1c.0:   bridge window [mem 0xc4000000-0xda0fffff]
>> [    0.243405] pci 0000:00:1c.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
>> [    0.243408] pci 0000:00:1c.4: PCI bridge to [bus 3a]
>> [    0.243412] pci 0000:00:1c.4:   bridge window [mem 0xdc000000-0xdc1fffff]
>> [    0.243417] pci 0000:00:1d.0: PCI bridge to [bus 3b]
>> [    0.243419] pci 0000:00:1d.0:   bridge window [mem 0xdc200000-0xdc2fffff]
>> [    0.243424] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
>> [    0.243425] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
>> [    0.243426] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000dffff window]
>> [    0.243428] pci_bus 0000:00: resource 7 [mem 0x7c800000-0xdfffffff window]
>> [    0.243429] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
>> [    0.243430] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
>> [    0.243431] pci_bus 0000:01: resource 1 [mem 0xc4000000-0xda0fffff]
>> [    0.243432] pci_bus 0000:01: resource 2 [mem 0xa0000000-0xc1ffffff 64bit pref]
>> [    0.243433] pci_bus 0000:3a: resource 1 [mem 0xdc000000-0xdc1fffff]
>> [    0.243434] pci_bus 0000:3b: resource 1 [mem 0xdc200000-0xdc2fffff]
>> [    0.244008] PCI: CLS 0 bytes, default 64
>> [    0.244051] pci 0000:00:1f.1: [8086:9d20] type 00 class 0x058000 conventional PCI endpoint
>> [    0.244110] pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]
>> [    0.244346] DMAR: ACPI device "device:79" under DMAR at fed91000 as 00:15.0
>> [    0.244350] DMAR: ACPI device "device:7a" under DMAR at fed91000 as 00:15.1
>> [    0.244359] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>> [    0.244360] software IO TLB: mapped [mem 0x000000005e260000-0x0000000062260000] (64MB)
>> [    0.244385] Unpacking initramfs...
>> [    0.244415] sgx: EPC section 0x70200000-0x75f7ffff
>> [    0.245091] Initialise system trusted keyrings
>> [    0.245101] Key type blacklist registered
>> [    0.245184] workingset: timestamp_bits=36 max_order=22 bucket_order=0
>> [    0.245212] zbud: loaded
>> [    0.245408] fuse: init (API version 7.40)
>> [    0.245677] Key type asymmetric registered
>> [    0.245681] Asymmetric key parser 'x509' registered
>> [    0.272446] Freeing initrd memory: 20580K
>> [    0.275341] alg: self-tests disabled
>> [    0.275405] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
>> [    0.275431] io scheduler mq-deadline registered
>> [    0.276445] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
>> [    0.278430] thermal LNXTHERM:00: registered as thermal_zone0
>> [    0.278432] ACPI: thermal: Thermal Zone [THM] (25 C)
>> [    0.278572] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>> [    0.279073] hpet_acpi_add: no address or irqs in _CRS
>> [    0.291927] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 4)
>> [    0.328311] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
>> [    0.329901] i8042: Warning: Keylock active
>> [    0.332173] serio: i8042 KBD port at 0x60,0x64 irq 1
>> [    0.332178] serio: i8042 AUX port at 0x60,0x64 irq 12
>> [    0.332269] mousedev: PS/2 mouse device common for all mice
>> [    0.332282] rtc_cmos 00:01: RTC can wake from S4
>> [    0.333064] rtc_cmos 00:01: registered as rtc0
>> [    0.333230] rtc_cmos 00:01: setting system clock to 2024-08-19T05:37:19 UTC (1724045839)
>> [    0.333275] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
>> [    0.333317] intel_pstate: Intel P-state driver initializing
>> [    0.333462] intel_pstate: HWP enabled
>> [    0.333478] ledtrig-cpu: registered to indicate activity on CPUs
>> [    0.333679] efifb: probing for efifb
>> [    0.333690] efifb: framebuffer at 0x90000000, using 22500k, total 22500k
>> [    0.333691] efifb: mode is 3200x1800x32, linelength=12800, pages=1
>> [    0.333693] efifb: scrolling: redraw
>> [    0.333693] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
>> [    0.333760] Console: switching to colour frame buffer device 200x56
>> [    0.333924] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
>> [    0.337147] fb0: EFI VGA frame buffer device
>> [    0.337275] NET: Registered PF_INET6 protocol family
>> [    0.340401] Segment Routing with IPv6
>> [    0.340416] In-situ OAM (IOAM) with IPv6
>> [    0.340438] mip6: Mobile IPv6
>> [    0.340442] NET: Registered PF_PACKET protocol family
>> [    0.340498] mpls_gso: MPLS GSO support
>> [    0.340655] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
>> [    0.340681] microcode: Current revision: 0x000000f6
>> [    0.340682] microcode: Updated early from: 0x000000f0
>> [    0.340726] IPI shorthand broadcast: enabled
>> [    0.341578] sched_clock: Marking stable (334728176, 5989746)->(353045476, -12327554)
>> [    0.341677] registered taskstats version 1
>> [    0.341741] Loading compiled-in X.509 certificates
>> [    0.343119] Demotion targets for Node 0: null
>> [    0.343230] Key type .fscrypt registered
>> [    0.343232] Key type fscrypt-provisioning registered
>> [    0.347707] cryptd: max_cpu_qlen set to 1000
>> [    0.348358] AES CTR mode by8 optimization enabled
>> [    0.361149] Key type encrypted registered
>> [    0.361154] AppArmor: AppArmor sha256 policy hashing enabled
>> [    0.361648] RAS: Correctable Errors collector initialized.
>> [    0.371365] clk: Disabling unused clocks
>> [    0.372038] Freeing unused decrypted memory: 2036K
>> [    0.372403] Freeing unused kernel image (initmem) memory: 2892K
>> [    0.372419] Write protecting the kernel read-only data: 24576k
>> [    0.372729] Freeing unused kernel image (rodata/data gap) memory: 436K
>> [    0.383253] x86/mm: Checked W+X mappings: passed, no W+X pages found.
>> [    0.383258] Run /init as init process
>> [    0.383259]   with arguments:
>> [    0.383260]     /init
>> [    0.383261]   with environment:
>> [    0.383262]     HOME=/
>> [    0.383262]     TERM=linux
>> [    0.383263]     BOOT_IMAGE=/vmlinuz-6.11.0-rc4
>> [    0.445667] hid: raw HID events driver (C) Jiri Kosina
>> [    0.447611] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
>> [    0.447865] idma64 idma64.0: Found Intel integrated DMA 64-bit
>> [    0.455199] i801_smbus 0000:00:1f.4: SPD Write Disable is set
>> [    0.455262] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
>> [    0.458362] ACPI: bus type USB registered
>> [    0.458398] usbcore: registered new interface driver usbfs
>> [    0.458408] usbcore: registered new interface driver hub
>> [    0.458421] usbcore: registered new device driver usb
>> [    0.477093] ACPI: bus type drm_connector registered
>> [    0.484073] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
>> [    0.484289] idma64 idma64.1: Found Intel integrated DMA 64-bit
>> [    0.500575] nvme nvme0: pci function 0000:3b:00.0
>> [    0.519838] nvme nvme0: 4/0/0 default/read/poll queues
>> [    0.525753]  nvme0n1: p1 p2 p3 p4
>> [    0.526819] xhci_hcd 0000:00:14.0: xHCI Host Controller
>> [    0.526828] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
>> [    0.527901] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
>> [    0.528356] xhci_hcd 0000:00:14.0: xHCI Host Controller
>> [    0.528359] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
>> [    0.528362] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
>> [    0.528409] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
>> [    0.528413] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.528415] usb usb1: Product: xHCI Host Controller
>> [    0.528416] usb usb1: Manufacturer: Linux 6.11.0-rc4 xhci-hcd
>> [    0.528418] usb usb1: SerialNumber: 0000:00:14.0
>> [    0.528542] hub 1-0:1.0: USB hub found
>> [    0.528558] hub 1-0:1.0: 12 ports detected
>> [    0.529952] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
>> [    0.529955] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [    0.529956] usb usb2: Product: xHCI Host Controller
>> [    0.529957] usb usb2: Manufacturer: Linux 6.11.0-rc4 xhci-hcd
>> [    0.529958] usb usb2: SerialNumber: 0000:00:14.0
>> [    0.530044] hub 2-0:1.0: USB hub found
>> [    0.530056] hub 2-0:1.0: 6 ports detected
>> [    0.681210] input: DLL075B:01 06CB:76AF Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input2
>> [    0.681353] input: DLL075B:01 06CB:76AF Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input3
>> [    0.681620] hid-generic 0018:06CB:76AF.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL075B:01 06CB:76AF] on i2c-DLL075B:01
>> [    0.782219] usb 1-3: new full-speed USB device number 2 using xhci_hcd
>> [    0.932847] usb 1-3: New USB device found, idVendor=0cf3, idProduct=e300, bcdDevice= 0.01
>> [    0.932862] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
>> [    1.062216] usb 1-4: new full-speed USB device number 3 using xhci_hcd
>> [    1.213383] usb 1-4: New USB device found, idVendor=04f3, idProduct=2234, bcdDevice=11.11
>> [    1.213398] usb 1-4: New USB device strings: Mfr=4, Product=14, SerialNumber=0
>> [    1.213404] usb 1-4: Product: Touchscreen
>> [    1.213409] usb 1-4: Manufacturer: ELAN
>> [    1.246213] tsc: Refined TSC clocksource calibration: 2904.008 MHz
>> [    1.246233] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29dc0d988f1, max_idle_ns: 440795328788 ns
>> [    1.246311] clocksource: Switched to clocksource tsc
>> [    1.342262] usb 1-5: new high-speed USB device number 4 using xhci_hcd
>> [    1.551243] usb 1-5: New USB device found, idVendor=0c45, idProduct=670c, bcdDevice=56.26
>> [    1.551260] usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
>> [    1.551266] usb 1-5: Product: Integrated_Webcam_HD
>> [    1.551271] usb 1-5: Manufacturer: CN09GTFMLOG008C8B7FWA01
>> [    1.580710] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input5
>> [    1.580762] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input6
>> [    1.580779] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input7
>> [    1.580843] hid-generic 0003:04F3:2234.0002: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
>> [    1.580869] usbcore: registered new interface driver usbhid
>> [    1.580870] usbhid: USB HID core driver
>> [    1.590719] device-mapper: uevent: version 1.0.3
>> [    1.590855] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
>> [   37.977234] PM: Image not found (code -22)
>> [   47.825428] EXT4-fs (dm-0): mounted filesystem 32e29882-d94d-4a92-9ee4-4d03002bfa29 ro with ordered data mode. Quota mode: none.
>> [   47.954036] systemd[1]: Inserted module 'autofs4'
>> [   47.986355] systemd[1]: systemd 256.5-1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT +LIBARCHIVE)
>> [   47.986363] systemd[1]: Detected architecture x86-64.
>> [   47.988283] systemd[1]: Hostname set to <abreu>.
>> [   48.198151] systemd[1]: bpf-restrict-fs: LSM BPF program attached
>> [   48.330208] systemd[1]: Queued start job for default target graphical.target.
>> [   48.355361] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
>> [   48.355729] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
>> [   48.356041] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice - Encrypted Volume Units Service Slice.
>> [   48.356355] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
>> [   48.356559] systemd[1]: Created slice user.slice - User and Session Slice.
>> [   48.356623] systemd[1]: Started systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.
>> [   48.356665] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
>> [   48.356840] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
>> [   48.356865] systemd[1]: Expecting device dev-disk-by\x2ddiskseq-1\x2dpart4.device - /dev/disk/by-diskseq/1-part4...
>> [   48.356872] systemd[1]: Expecting device dev-disk-by\x2duuid-2d23fd4c\x2d5d03\x2d4e1a\x2d8a42\x2d0e859d1f00d8.device - /dev/disk/by-uuid/2d23fd4c-5d03-4e1a-8a42-0e859d1f00d8...
>> [   48.356878] systemd[1]: Expecting device dev-disk-by\x2duuid-61be8f50\x2d69c5\x2d49a5\x2dbcad\x2d3f4521e9c7b5.device - /dev/disk/by-uuid/61be8f50-69c5-49a5-bcad-3f4521e9c7b5...
>> [   48.356886] systemd[1]: Expecting device dev-disk-by\x2duuid-96BD\x2d5653.device - /dev/disk/by-uuid/96BD-5653...
>> [   48.356907] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
>> [   48.356936] systemd[1]: Reached target nss-user-lookup.target - User and Group Name Lookups.
>> [   48.356949] systemd[1]: Reached target paths.target - Path Units.
>> [   48.356967] systemd[1]: Reached target remote-fs.target - Remote File Systems.
>> [   48.356978] systemd[1]: Reached target slices.target - Slice Units.
>> [   48.357013] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
>> [   48.358589] systemd[1]: Listening on systemd-coredump.socket - Process Core Dump Socket.
>> [   48.359516] systemd[1]: Listening on systemd-creds.socket - Credential Encryption/Decryption.
>> [   48.359596] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
>> [   48.359689] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
>> [   48.359785] systemd[1]: Listening on systemd-journald.socket - Journal Sockets.
>> [   48.359835] systemd[1]: systemd-pcrextend.socket - TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
>> [   48.359852] systemd[1]: systemd-pcrlock.socket - Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
>> [   48.359932] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
>> [   48.359994] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
>> [   48.361086] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
>> [   48.361796] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
>> [   48.362940] systemd[1]: Mounting run-lock.mount - Legacy Locks Directory /run/lock...
>> [   48.366138] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
>> [   48.367252] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
>> [   48.372872] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
>> [   48.374457] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
>> [   48.377301] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
>> [   48.380996] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
>> [   48.385314] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
>> [   48.385441] systemd[1]: systemd-fsck-root.service - File System Check on Root Device was skipped because of an unmet condition check (ConditionPathExists=!/run/initramfs/fsck-root).
>> [   48.385504] systemd[1]: systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
>> [   48.390898] systemd[1]: Starting systemd-journald.service - Journal Service...
>> [   48.392741] pstore: Using crash dump compression: deflate
>> [   48.395061] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
>> [   48.395092] systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
>> [   48.399692] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
>> [   48.399774] systemd[1]: systemd-tpm2-setup-early.service - Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
>> [   48.401693] systemd[1]: Starting systemd-udev-load-credentials.service - Load udev Rules from Credentials...
>> [   48.405039] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
>> [   48.406479] pstore: Registered efi_pstore as persistent store backend
>> [   48.409592] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
>> [   48.409734] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
>> [   48.409830] systemd[1]: Mounted run-lock.mount - Legacy Locks Directory /run/lock.
>> [   48.409917] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
>> [   48.410015] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
>> [   48.410249] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
>> [   48.410554] systemd[1]: modprobe@configfs.service: Deactivated successfully.
>> [   48.411102] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
>> [   48.412949] systemd[1]: modprobe@drm.service: Deactivated successfully.
>> [   48.413157] systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
>> [   48.413444] systemd[1]: modprobe@efi_pstore.service: Deactivated successfully.
>> [   48.413613] systemd[1]: Finished modprobe@efi_pstore.service - Load Kernel Module efi_pstore.
>> [   48.413872] systemd[1]: modprobe@fuse.service: Deactivated successfully.
>> [   48.414261] systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
>> [   48.414941] lp: driver loaded but no devices found
>> [   48.415860] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Control File System...
>> [   48.416947] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
>> [   48.418987] ppdev: user-space parallel port driver
>> [   48.419476] systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
>> [   48.420600] systemd-journald[422]: Collecting audit messages is disabled.
>> [   48.424498] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Control File System.
>> [   48.426974] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
>> [   48.427358] systemd[1]: Finished systemd-udev-load-credentials.service - Load udev Rules from Credentials.
>> [   48.434849] systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
>> [   48.435408] EXT4-fs (dm-0): re-mounted 32e29882-d94d-4a92-9ee4-4d03002bfa29 r/w. Quota mode: none.
>> [   48.436022] systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
>> [   48.437498] systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
>> [   48.438068] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
>> [   48.438567] systemd[1]: systemd-pstore.service - Platform Persistent Storage Archival was skipped because of an unmet condition check (ConditionDirectoryNotEmpty=/sys/fs/pstore).
>> [   48.442152] systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
>> [   48.442186] systemd[1]: systemd-tpm2-setup.service - TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
>> [   48.442527] systemd[1]: Finished systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully.
>> [   48.442676] systemd[1]: systemd-sysusers.service - Create System Users was skipped because no trigger condition checks were met.
>> [   48.449113] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
>> [   48.449282] systemd[1]: Started systemd-journald.service - Journal Service.
>> [   48.466493] systemd-journald[422]: Received client request to flush runtime journal.
>> [   48.467834] systemd-journald[422]: File /var/log/journal/16ae67b9dca94ecebbc8ec78ab24e074/system.journal corrupted or uncleanly shut down, renaming and replacing.
>> [   48.581618] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input9
>> [   48.586468] ACPI: AC: AC Adapter [AC] (on-line)
>> [   48.586811] input: Intel HID events as /devices/platform/INT33D5:00/input/input10
>> [   48.598367] intel_pmc_core INT33A1:00:  initialized
>> [   48.604720] Consider using thermal netlink events interface
>> [   48.614528] wmi_bus wmi_bus-PNP0C14:01: [Firmware Bug]: WQBC data block query control method not found
>> [   48.615540] intel-hid INT33D5:00: platform supports 5 button array
>> [   48.615600] input: Intel HID 5 button array as /devices/platform/INT33D5:00/input/input11
>> [   48.630518] input: Intel Virtual Buttons as /devices/pci0000:00/0000:00:1f.0/PNP0C09:00/INT33D6:00/input/input12
>> [   48.630538] ACPI: button: Lid Switch [LID0]
>> [   48.631799] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input13
>> [   48.659683] ACPI: battery: Slot [BAT0] (battery present)
>> [   48.677258] mc: Linux media interface: v0.10
>> [   48.683146] Adding 8387904k swap on /dev/nvme0n1p4.  Priority:-2 extents:1 across:8387904k SS
>> [   48.692881] input: DLL075B:01 06CB:76AF Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input15
>> [   48.692896] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
>> [   48.693190] ACPI: button: Power Button [PBTN]
>> [   48.695626] input: DLL075B:01 06CB:76AF Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-2/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input16
>> [   48.696079] hid-multitouch 0018:06CB:76AF.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL075B:01 06CB:76AF] on i2c-DLL075B:01
>> [   48.709637] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input18
>> [   48.717468] iTCO_vendor_support: vendor-support=0
>> [   48.725764] input: PC Speaker as /devices/platform/pcspkr/input/input19
>> [   48.727904] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
>> [   48.729641] videodev: Linux video capture interface: v2.00
>> [   48.731452] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
>> [   48.750598] ACPI: button: Sleep Button [SBTN]
>> [   48.750671] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input20
>> [   48.752035] ACPI: button: Power Button [PWRF]
>> [   48.758233] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
>> [   48.769408] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
>> [   48.769413] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
>> [   48.769414] RAPL PMU: hw unit of domain package 2^-14 Joules
>> [   48.769415] RAPL PMU: hw unit of domain dram 2^-14 Joules
>> [   48.769416] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
>> [   48.769417] RAPL PMU: hw unit of domain psys 2^-14 Joules
>> [   48.780138] intel_rapl_common: Found RAPL domain package
>> [   48.780143] intel_rapl_common: Found RAPL domain dram
>> [   48.794143] usb 1-5: Found UVC 1.00 device Integrated_Webcam_HD (0c45:670c)
>> [   48.878620] Bluetooth: Core ver 2.22
>> [   48.878642] NET: Registered PF_BLUETOOTH protocol family
>> [   48.878644] Bluetooth: HCI device and connection manager initialized
>> [   48.878648] Bluetooth: HCI socket layer initialized
>> [   48.878651] Bluetooth: L2CAP socket layer initialized
>> [   48.878655] Bluetooth: SCO socket layer initialized
>> [   48.894040] input: ELAN Touchscreen as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input21
>> [   48.894141] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input22
>> [   48.894189] input: ELAN Touchscreen UNKNOWN as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/0003:04F3:2234.0002/input/input23
>> [   48.894290] hid-multitouch 0003:04F3:2234.0002: input,hiddev0,hidraw1: USB HID v1.10 Device [ELAN Touchscreen] on usb-0000:00:14.0-4/input0
>> [   48.929232] usbcore: registered new interface driver uvcvideo
>> [   48.992273] intel_rapl_common: Found RAPL domain package
>> [   48.992278] intel_rapl_common: Found RAPL domain core
>> [   48.992280] intel_rapl_common: Found RAPL domain uncore
>> [   48.992281] intel_rapl_common: Found RAPL domain dram
>> [   48.992282] intel_rapl_common: Found RAPL domain psys
>> [   48.994727] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
>> [   48.997783] cfg80211: Loading compiled-in X.509 certificates for regulatory database
>> [   49.007026] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
>> [   49.007476] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
>> [   49.009586] cfg80211: loaded regulatory.db is malformed or signature is missing/invalid
>> [   49.130624] usbcore: registered new interface driver btusb
>> [   49.132627] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
>> [   49.132630] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
>> [   49.351931] input: Dell WMI hotkeys as /devices/platform/PNP0C14:01/wmi_bus/wmi_bus-PNP0C14:01/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input25
>> [   49.356462] stackdepot: allocating hash table of 1048576 entries via kvcalloc
>> [   49.359486] i915 0000:00:02.0: [drm] Found KABYLAKE/ULT (device ID 5916) display version 9.00
>> [   49.360858] Console: switching to colour dummy device 80x25
>> [   49.360919] i915 0000:00:02.0: vgaarb: deactivate vga console
>> [   49.381144] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
>> [   49.383812] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
>> [   49.474301] EXT4-fs (nvme0n1p2): mounted filesystem 2d23fd4c-5d03-4e1a-8a42-0e859d1f00d8 r/w with ordered data mode. Quota mode: none.
>> [   49.491654] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
>> [   49.519939] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
>> [   49.561283] ath10k_pci 0000:3a:00.0: enabling device (0000 -> 0002)
>> [   49.564107] ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
>> [   49.571307] audit: type=1400 audit(1724045888.733:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=578 comm="apparmor_parser"
>> [   49.571313] audit: type=1400 audit(1724045888.733:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=578 comm="apparmor_parser"
>> [   49.572988] audit: type=1400 audit(1724045888.733:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=577 comm="apparmor_parser"
>> [   49.578473] audit: type=1400 audit(1724045888.741:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=579 comm="apparmor_parser"
>> [   49.578481] audit: type=1400 audit(1724045888.741:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=579 comm="apparmor_parser"
>> [   49.578483] audit: type=1400 audit(1724045888.741:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=579 comm="apparmor_parser"
>> [   49.578485] audit: type=1400 audit(1724045888.741:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/{,usr/}sbin/dhclient" pid=579 comm="apparmor_parser"
>> [   49.582978] audit: type=1400 audit(1724045888.741:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=587 comm="apparmor_parser"
>> [   49.582985] audit: type=1400 audit(1724045888.741:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=587 comm="apparmor_parser"
>> [   49.582987] audit: type=1400 audit(1724045888.741:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=587 comm="apparmor_parser"
>> [   49.848525] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
>> [   49.848532] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
>> [   49.848971] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00309- api 6 features wowlan,ignore-otp,mfp crc32 0793bcf2
>> [   49.919035] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
>> [   49.999322] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
>> [   50.013716] ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
>> [   50.014404] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 0
>> [   50.020160] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
>> [   50.024001] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input26
>> [   50.042048] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
>> [   50.047095] fbcon: i915drmfb (fb0) is primary device
>> [   50.064411] Console: switching to colour frame buffer device 200x56
>> [   50.085559] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
>> [   50.104134] ath: EEPROM regdomain: 0x6c
>> [   50.104137] ath: EEPROM indicates we should expect a direct regpair map
>> [   50.104139] ath: Country alpha2 being used: 00
>> [   50.104140] ath: Regpair used: 0x6c
>> [   50.108379] ath10k_pci 0000:3a:00.0 wlp58s0: renamed from wlan0
>> [   50.126370] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC3246: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
>> [   50.126376] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
>> [   50.126378] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
>> [   50.126379] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
>> [   50.126380] snd_hda_codec_realtek hdaudioC0D0:    inputs:
>> [   50.126381] snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
>> [   50.126382] snd_hda_codec_realtek hdaudioC0D0:      Headphone Mic=0x1a
>> [   50.126383] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
>> [   50.204551] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.3/sound/card0/input27
>> [   50.204623] input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input28
>> [   50.204683] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input29
>> [   50.205120] PPP generic driver version 2.4.2
>> [   50.205556] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input30
>> [   50.206788] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input31
>> [   50.209724] NET: Registered PF_PPPOX protocol family
>> [   50.228155] l2tp_core: L2TP core driver, V2.0
>> [   50.229256] Initializing XFRM netlink socket
>> [   50.229705] l2tp_netlink: L2TP netlink interface
>> [   50.231972] l2tp_ppp: PPPoL2TP kernel driver, V2.0
>> [   50.237402] IPsec XFRM device driver
>> [   52.589000] rfkill: input handler disabled
>> [   56.910572] pci 0000:01:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Upstream Port
>> [   56.910606] pci 0000:01:00.0: PCI bridge to [bus 02-39]
>> [   56.910616] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
>> [   56.910627] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
>> [   56.910640] pci 0000:01:00.0: enabling Extended Tags
>> [   56.911217] pci 0000:01:00.0: supports D1 D2
>> [   56.911220] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [   56.911298] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:1c.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
>> [   56.972154] pci 0000:02:00.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
>> [   56.972193] pci 0000:02:00.0: PCI bridge to [bus 03]
>> [   56.972205] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
>> [   56.972234] pci 0000:02:00.0: enabling Extended Tags
>> [   56.972347] pci 0000:02:00.0: supports D1 D2
>> [   56.972350] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [   56.972663] pci 0000:02:01.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
>> [   56.972705] pci 0000:02:01.0: PCI bridge to [bus 04-38]
>> [   56.972715] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
>> [   56.972730] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
>> [   56.972746] pci 0000:02:01.0: enabling Extended Tags
>> [   56.972863] pci 0000:02:01.0: supports D1 D2
>> [   56.972865] pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [   56.973433] pci 0000:02:02.0: [8086:1576] type 01 class 0x060400 PCIe Switch Downstream Port
>> [   56.973481] pci 0000:02:02.0: PCI bridge to [bus 39]
>> [   56.973497] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
>> [   56.973529] pci 0000:02:02.0: enabling Extended Tags
>> [   56.973705] pci 0000:02:02.0: supports D1 D2
>> [   56.973707] pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [   56.974208] pci 0000:01:00.0: PCI bridge to [bus 02-39]
>> [   56.974305] pci 0000:02:00.0: PCI bridge to [bus 03]
>> [   56.974392] pci 0000:02:01.0: PCI bridge to [bus 04-38]
>> [   56.974542] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
>> [   56.974572] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
>> [   56.974673] pci 0000:39:00.0: enabling Extended Tags
>> [   56.974844] pci 0000:39:00.0: supports D1 D2
>> [   56.974846] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [   56.974990] pci 0000:39:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:02:02.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
>> [   56.975261] pci 0000:02:02.0: PCI bridge to [bus 39]
>> [   56.975310] pci_bus 0000:02: Allocating resources
>> [   56.975326] pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
>> [   56.975329] pci 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
>> [   56.975332] pci 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
>> [   56.975335] pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
>> [   56.975339] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
>> [   56.975341] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
>> [   56.975343] pci 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
>> [   56.975345] pci 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
>> [   56.975349] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
>> [   56.975351] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
>> [   56.975353] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
>> [   56.975355] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
>> [   56.975357] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [   56.975358] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
>> [   56.975361] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
>> [   56.975363] pci 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
>> [   56.975365] pci 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [   56.975367] pci 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
>> [   56.975368] pci 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
>> [   56.975370] pci 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
>> [   56.975372] pci 0000:02:00.0: PCI bridge to [bus 03]
>> [   56.975379] pci 0000:02:00.0:   bridge window [mem 0xda000000-0xda0fffff]
>> [   56.975388] pci 0000:02:01.0: PCI bridge to [bus 04-38]
>> [   56.975393] pci 0000:02:01.0:   bridge window [mem 0xc4000000-0xd9efffff]
>> [   56.975398] pci 0000:02:01.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
>> [   56.975406] pci 0000:02:02.0: PCI bridge to [bus 39]
>> [   56.975411] pci 0000:02:02.0:   bridge window [mem 0xd9f00000-0xd9ffffff]
>> [   56.975420] pci 0000:01:00.0: PCI bridge to [bus 02-39]
>> [   56.975426] pci 0000:01:00.0:   bridge window [mem 0xc4000000-0xda0fffff]
>> [   56.975431] pci 0000:01:00.0:   bridge window [mem 0xa0000000-0xc1ffffff 64bit pref]
>> [   56.977330] xhci_hcd 0000:39:00.0: xHCI Host Controller
>> [   56.977338] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
>> [   56.978454] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
>> [   56.978776] xhci_hcd 0000:39:00.0: xHCI Host Controller
>> [   56.978781] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
>> [   56.978785] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
>> [   56.978841] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
>> [   56.978845] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [   56.978847] usb usb3: Product: xHCI Host Controller
>> [   56.978849] usb usb3: Manufacturer: Linux 6.11.0-rc4 xhci-hcd
>> [   56.978850] usb usb3: SerialNumber: 0000:39:00.0
>> [   56.979677] hub 3-0:1.0: USB hub found
>> [   56.979689] hub 3-0:1.0: 2 ports detected
>> [   56.980240] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
>> [   56.980244] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [   56.980246] usb usb4: Product: xHCI Host Controller
>> [   56.980248] usb usb4: Manufacturer: Linux 6.11.0-rc4 xhci-hcd
>> [   56.980249] usb usb4: SerialNumber: 0000:39:00.0
>> [   56.980409] hub 4-0:1.0: USB hub found
>> [   56.980420] hub 4-0:1.0: 2 ports detected
>> [   56.994380] pci_bus 0000:02: Allocating resources
>> [   56.994398] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
>> [   56.994403] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
>> [   56.994406] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
>> [   56.994410] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
>> [   56.994416] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
>> [   56.994418] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
>> [   56.994420] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
>> [   56.994422] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
>> [   56.994427] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
>> [   56.994429] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
>> [   56.994431] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
>> [   56.994433] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
>> [   56.994435] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [   56.994436] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
>> [   56.994439] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
>> [   56.994441] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
>> [   56.994443] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [   56.994445] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
>> [   56.994446] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
>> [   56.994448] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
>> [   57.234076] usb 3-1: new high-speed USB device number 2 using xhci_hcd
>> [   57.385084] usb 3-1: New USB device found, idVendor=2109, idProduct=2820, bcdDevice= 9.f3
>> [   57.385102] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>> [   57.385110] usb 3-1: Product: USB2.0 Hub
>> [   57.385115] usb 3-1: Manufacturer: VIA Labs, Inc.
>> [   57.390461] hub 3-1:1.0: USB hub found
>> [   57.390840] hub 3-1:1.0: 5 ports detected
>> [   57.515999] usb 4-1: new SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
>> [   57.537885] usb 4-1: New USB device found, idVendor=2109, idProduct=0820, bcdDevice= 9.f3
>> [   57.537898] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>> [   57.537903] usb 4-1: Product: USB3.1 Hub
>> [   57.537907] usb 4-1: Manufacturer: VIA Labs, Inc.
>> [   57.543621] hub 4-1:1.0: USB hub found
>> [   57.543735] hub 4-1:1.0: 4 ports detected
>> [   58.118704] usb 3-1.1: new full-speed USB device number 3 using xhci_hcd
>> [   58.282767] usb 3-1.1: New USB device found, idVendor=06c4, idProduct=c412, bcdDevice= 0.01
>> [   58.282776] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>> [   58.282779] usb 3-1.1: Product: DELL DA300
>> [   58.282782] usb 3-1.1: Manufacturer: Bizlink
>> [   58.282784] usb 3-1.1: SerialNumber: MCU Ver0001
>> [   58.293628] hid-generic 0003:06C4:C412.0003: hiddev1,hidraw2: USB HID v1.11 Device [Bizlink DELL DA300] on usb-0000:39:00.0-1.1/input0
>> [   58.354052] usb 4-1.2: new SuperSpeed USB device number 3 using xhci_hcd
>> [   58.379040] usb 4-1.2: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=31.00
>> [   58.379046] usb 4-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=6
>> [   58.379047] usb 4-1.2: Product: USB 10/100/1000 LAN
>> [   58.379048] usb 4-1.2: Manufacturer: Realtek
>> [   58.379049] usb 4-1.2: SerialNumber: 001000001
>> [   58.396320] usbcore: registered new device driver r8152-cfgselector
>> [   58.478482] r8152-cfgselector 4-1.2: reset SuperSpeed USB device number 3 using xhci_hcd
>> [   58.501314] r8152 4-1.2:1.0 (unnamed net_device) (uninitialized): Using pass-thru MAC addr 18:db:f2:2d:cc:f3
>> [   58.547913] r8152 4-1.2:1.0 eth0: v1.12.13
>> [   58.548054] usbcore: registered new interface driver r8152
>> [   58.567500] usbcore: registered new interface driver cdc_ether
>> [   58.569546] usbcore: registered new interface driver r8153_ecm
>> [   58.605762] r8152 4-1.2:1.0 enp57s0u1u2: renamed from eth0
>> [   59.801641] systemd-journald[422]: File /var/log/journal/16ae67b9dca94ecebbc8ec78ab24e074/user-5272.journal corrupted or uncleanly shut down, renaming and replacing.
>> [   60.199420] rfkill: input handler enabled
>> [   61.237907] r8152 4-1.2:1.0 enp57s0u1u2: carrier on
>> [   62.575204] rfkill: input handler disabled
> 
>> [  617.828880] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>> [  617.828954] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>> [  617.829014] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>> [  650.597050] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>> [  735.588700] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>> [  956.771529] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>> [  979.298882] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>> [ 1003.874549] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>> [ 1031.528218] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>> [ 1039.713989] NOHZ tick-stop error: local softirq work is pending, handler #08!!!
>> [ 2193.529223] kauditd_printk_skb: 24 callbacks suppressed
>> [ 2193.529227] audit: type=1400 audit(1724048032.697:36): apparmor="DENIED" operation="capable" class="cap" profile="/usr/sbin/cupsd" pid=9103 comm="cupsd" capability=12  capname="net_admin"
> 
>> [ 3411.471079] xhci_hcd 0000:39:00.0: WARN: xHC restore state timeout
>> [ 3411.471097] xhci_hcd 0000:39:00.0: PCI post-resume error -110!
>> [ 3411.471100] xhci_hcd 0000:39:00.0: HC died; cleaning up
>> [ 3411.471118] usb 3-1: USB disconnect, device number 2
>> [ 3411.471120] usb 3-1.1: USB disconnect, device number 3
>> [ 3411.471230] usb 4-1: USB disconnect, device number 2
>> [ 3411.471233] r8152-cfgselector 4-1.2: USB disconnect, device number 3
>> [ 3494.035138] xhci_hcd 0000:39:00.0: remove, state 4
>> [ 3494.035144] usb usb4: USB disconnect, device number 1
>> [ 3498.507867] xhci_hcd 0000:39:00.0: xHCI host controller not responding, assume dead
>> [ 3498.508087] xhci_hcd 0000:39:00.0: Timeout while waiting for configure endpoint command
>> [ 3498.513451] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
>> [ 3498.513464] xhci_hcd 0000:39:00.0: remove, state 4
>> [ 3498.513468] usb usb3: USB disconnect, device number 1
>> [ 3498.513738] xhci_hcd 0000:39:00.0: Host halt failed, -19
>> [ 3498.513742] xhci_hcd 0000:39:00.0: Host not accessible, reset failed.
>> [ 3498.513888] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
> 
>> [ 3498.529065] pci_bus 0000:02: Allocating resources
>> [ 3498.529088] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
>> [ 3498.529094] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
>> [ 3498.529097] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
>> [ 3498.529101] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
>> [ 3498.529105] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
>> [ 3498.529107] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
>> [ 3498.529109] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
>> [ 3498.529110] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
>> [ 3498.529114] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
>> [ 3498.529116] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
>> [ 3498.529118] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 3498.529119] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
>> [ 3498.529121] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 3498.529122] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
>> [ 3498.529125] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
>> [ 3498.529127] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
>> [ 3498.529129] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 3498.529131] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
>> [ 3498.529133] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 3498.529134] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
>> [ 3499.136602] pci 0000:39:00.0: [8086:15b5] type 00 class 0x0c0330 PCIe Endpoint
>> [ 3499.136627] pci 0000:39:00.0: BAR 0 [mem 0xd9f00000-0xd9f0ffff]
>> [ 3499.136700] pci 0000:39:00.0: enabling Extended Tags
>> [ 3499.137066] pci 0000:39:00.0: supports D1 D2
>> [ 3499.137068] pci 0000:39:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> [ 3499.137478] pci 0000:39:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:02:02.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
>> [ 3499.138444] pcieport 0000:02:02.0: ASPM: current common clock configuration is inconsistent, reconfiguring
>> [ 3499.138505] pci_bus 0000:02: Allocating resources
>> [ 3499.138524] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
>> [ 3499.138527] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
>> [ 3499.138530] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
>> [ 3499.138534] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
>> [ 3499.138538] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
>> [ 3499.138541] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
>> [ 3499.138543] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
>> [ 3499.138545] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
>> [ 3499.138549] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
>> [ 3499.138552] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
>> [ 3499.138554] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 3499.138555] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
>> [ 3499.138557] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 3499.138558] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
>> [ 3499.138562] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
>> [ 3499.138564] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
>> [ 3499.138566] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 3499.138567] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
>> [ 3499.138569] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 3499.138571] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
>> [ 3499.138915] xhci_hcd 0000:39:00.0: xHCI Host Controller
>> [ 3499.138921] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 3
>> [ 3499.140080] xhci_hcd 0000:39:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
>> [ 3499.141244] xhci_hcd 0000:39:00.0: xHCI Host Controller
>> [ 3499.141248] xhci_hcd 0000:39:00.0: new USB bus registered, assigned bus number 4
>> [ 3499.141253] xhci_hcd 0000:39:00.0: Host supports USB 3.1 Enhanced SuperSpeed
>> [ 3499.141296] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
>> [ 3499.141299] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [ 3499.141300] usb usb3: Product: xHCI Host Controller
>> [ 3499.141302] usb usb3: Manufacturer: Linux 6.11.0-rc4 xhci-hcd
>> [ 3499.141303] usb usb3: SerialNumber: 0000:39:00.0
>> [ 3499.141645] hub 3-0:1.0: USB hub found
>> [ 3499.141665] hub 3-0:1.0: 2 ports detected
>> [ 3499.142918] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
>> [ 3499.142922] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> [ 3499.142923] usb usb4: Product: xHCI Host Controller
>> [ 3499.142924] usb usb4: Manufacturer: Linux 6.11.0-rc4 xhci-hcd
>> [ 3499.142926] usb usb4: SerialNumber: 0000:39:00.0
>> [ 3499.143072] hub 4-0:1.0: USB hub found
>> [ 3499.143083] hub 4-0:1.0: 2 ports detected
>> [ 3499.395875] usb 3-1: new high-speed USB device number 2 using xhci_hcd
>> [ 3499.546493] usb 3-1: New USB device found, idVendor=2109, idProduct=2820, bcdDevice= 9.f3
>> [ 3499.546497] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>> [ 3499.546499] usb 3-1: Product: USB2.0 Hub
>> [ 3499.546500] usb 3-1: Manufacturer: VIA Labs, Inc.
>> [ 3499.548314] hub 3-1:1.0: USB hub found
>> [ 3499.548480] hub 3-1:1.0: 5 ports detected
>> [ 3499.672121] usb 4-1: new SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
>> [ 3499.695030] usb 4-1: New USB device found, idVendor=2109, idProduct=0820, bcdDevice= 9.f3
>> [ 3499.695037] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>> [ 3499.695040] usb 4-1: Product: USB3.1 Hub
>> [ 3499.695042] usb 4-1: Manufacturer: VIA Labs, Inc.
>> [ 3499.699500] hub 4-1:1.0: USB hub found
>> [ 3499.699657] hub 4-1:1.0: 4 ports detected
>> [ 3500.279900] usb 3-1.1: new full-speed USB device number 3 using xhci_hcd
>> [ 3500.434357] usb 3-1.1: New USB device found, idVendor=06c4, idProduct=c412, bcdDevice= 0.01
>> [ 3500.434374] usb 3-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>> [ 3500.434381] usb 3-1.1: Product: DELL DA300
>> [ 3500.434386] usb 3-1.1: Manufacturer: Bizlink
>> [ 3500.434390] usb 3-1.1: SerialNumber: MCU Ver0001
>> [ 3500.447384] hid-generic 0003:06C4:C412.0004: hiddev1,hidraw2: USB HID v1.11 Device [Bizlink DELL DA300] on usb-0000:39:00.0-1.1/input0
>> [ 3500.507936] usb 4-1.2: new SuperSpeed USB device number 3 using xhci_hcd
>> [ 3500.532459] usb 4-1.2: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=31.00
>> [ 3500.532464] usb 4-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=6
>> [ 3500.532466] usb 4-1.2: Product: USB 10/100/1000 LAN
>> [ 3500.532467] usb 4-1.2: Manufacturer: Realtek
>> [ 3500.532468] usb 4-1.2: SerialNumber: 001000001
>> [ 3500.618066] r8152-cfgselector 4-1.2: reset SuperSpeed USB device number 3 using xhci_hcd
>> [ 3500.639905] r8152 4-1.2:1.0 (unnamed net_device) (uninitialized): Using pass-thru MAC addr 18:db:f2:2d:cc:f3
>> [ 3500.692511] r8152 4-1.2:1.0 eth0: v1.12.13
>> [ 3500.720977] r8152 4-1.2:1.0 enp57s0u1u2: renamed from eth0
>> [ 3504.120604] r8152 4-1.2:1.0 enp57s0u1u2: carrier on
>> [ 3504.244220] pci_bus 0000:02: Allocating resources
>> [ 3504.244238] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
>> [ 3504.244243] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
>> [ 3504.244246] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
>> [ 3504.244250] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
>> [ 3504.244254] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
>> [ 3504.244256] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
>> [ 3504.244258] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
>> [ 3504.244260] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
>> [ 3504.244263] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
>> [ 3504.244265] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
>> [ 3504.244267] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 3504.244269] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
>> [ 3504.244270] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 3504.244272] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
>> [ 3504.244275] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
>> [ 3504.244276] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
>> [ 3504.244278] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 3504.244279] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
>> [ 3504.244281] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 3504.244282] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
>> [ 7480.544696] r8152 4-1.2:1.0 enp57s0u1u2: carrier off
>> [ 7486.881240] usb 3-1: USB disconnect, device number 2
>> [ 7486.881249] usb 3-1.1: USB disconnect, device number 3
>> [ 7486.933920] xhci_hcd 0000:39:00.0: xHCI host controller not responding, assume dead
>> [ 7486.933935] xhci_hcd 0000:39:00.0: HC died; cleaning up
>> [ 7486.933956] r8152 4-1.2:1.0 enp57s0u1u2: Stop submitting intr, status -108
>> [ 7486.994768] xhci_hcd 0000:39:00.0: remove, state 1
>> [ 7486.994791] usb usb4: USB disconnect, device number 1
>> [ 7487.049211] usb 4-1: USB disconnect, device number 2
>> [ 7487.049232] r8152-cfgselector 4-1.2: USB disconnect, device number 3
>> [ 7487.107109] xhci_hcd 0000:39:00.0: USB bus 4 deregistered
>> [ 7487.107126] xhci_hcd 0000:39:00.0: remove, state 1
>> [ 7487.107131] usb usb3: USB disconnect, device number 1
>> [ 7487.107726] xhci_hcd 0000:39:00.0: Host halt failed, -19
>> [ 7487.107732] xhci_hcd 0000:39:00.0: Host not accessible, reset failed.
>> [ 7487.112330] xhci_hcd 0000:39:00.0: USB bus 3 deregistered
>> [ 7487.127675] pci_bus 0000:02: Allocating resources
>> [ 7487.127722] pcieport 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-38] add_size 1000
>> [ 7487.127732] pcieport 0000:02:02.0: bridge window [io  0x1000-0x0fff] to [bus 39] add_size 1000
>> [ 7487.127747] pcieport 0000:02:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 39] add_size 200000 add_align 100000
>> [ 7487.127754] pcieport 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 2000
>> [ 7487.127764] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
>> [ 7487.127767] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
>> [ 7487.127771] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: can't assign; no space
>> [ 7487.127773] pcieport 0000:01:00.0: bridge window [io  size 0x2000]: failed to assign
>> [ 7487.127792] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
>> [ 7487.127795] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
>> [ 7487.127798] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 7487.127800] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
>> [ 7487.127802] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 7487.127804] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
>> [ 7487.127808] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: can't assign; no space
>> [ 7487.127810] pcieport 0000:02:02.0: bridge window [mem size 0x00200000 64bit pref]: failed to assign
>> [ 7487.127812] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 7487.127814] pcieport 0000:02:02.0: bridge window [io  size 0x1000]: failed to assign
>> [ 7487.127829] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: can't assign; no space
>> [ 7487.127831] pcieport 0000:02:01.0: bridge window [io  size 0x1000]: failed to assign
>> [ 7492.078837] pcieport 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
>> [ 7492.081360] pci_bus 0000:03: busn_res: [bus 03] is released
>> [ 7492.081543] pci_bus 0000:04: busn_res: [bus 04-38] is released
>> [ 7492.081805] pci_bus 0000:39: busn_res: [bus 39] is released
>> [ 7492.081961] pci_bus 0000:02: busn_res: [bus 02-39] is released
>> [ 7555.150365] PM: suspend entry (deep)
>> [ 7555.165236] Filesystems sync: 0.014 seconds
>> [ 7555.176379] Freezing user space processes
>> [ 7555.178882] Freezing user space processes completed (elapsed 0.002 seconds)
>> [ 7555.178896] OOM killer disabled.
>> [ 7555.178899] Freezing remaining freezable tasks
>> [ 7555.180666] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>> [ 7555.180791] printk: Suspending console(s) (use no_console_suspend to debug)
>> [ 7555.777277] ACPI: EC: interrupt blocked
>> [ 7555.813248] ACPI: PM: Preparing to enter system sleep state S3
>> [ 7555.824146] ACPI: EC: event blocked
>> [ 7555.824151] ACPI: EC: EC stopped
>> [ 7555.824153] ACPI: PM: Saving platform NVS memory
>> [ 7555.827432] Disabling non-boot CPUs ...
>> [ 7555.830731] smpboot: CPU 3 is now offline
>> [ 7555.835350] smpboot: CPU 2 is now offline
>> [ 7555.839213] smpboot: CPU 1 is now offline
>> [ 7555.847574] ACPI: PM: Low-level resume complete
>> [ 7555.847618] ACPI: EC: EC started
>> [ 7555.847619] ACPI: PM: Restoring platform NVS memory
>> [ 7555.849494] Enabling non-boot CPUs ...
>> [ 7555.849524] smpboot: Booting Node 0 Processor 1 APIC 0x2
>> [ 7555.850317] CPU1 is up
>> [ 7555.850332] smpboot: Booting Node 0 Processor 2 APIC 0x1
>> [ 7555.851032] CPU2 is up
>> [ 7555.851048] smpboot: Booting Node 0 Processor 3 APIC 0x3
>> [ 7555.851698] CPU3 is up
>> [ 7555.854593] ACPI: PM: Waking up from system sleep state S3
>> [ 7555.883782] ACPI: EC: interrupt unblocked
>> [ 7555.911459] ACPI: EC: event unblocked
>> [ 7555.923340] nvme nvme0: 4/0/0 default/read/poll queues
>> [ 7556.149091] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
>> [ 7556.177300] usb 1-4: reset full-speed USB device number 3 using xhci_hcd
>> [ 7556.453308] usb 1-3: reset full-speed USB device number 2 using xhci_hcd
>> [ 7556.729235] usb 1-5: reset high-speed USB device number 4 using xhci_hcd
>> [ 7556.943282] OOM killer enabled.
>> [ 7556.943286] Restarting tasks ... done.
>> [ 7556.945006] random: crng reseeded on system resumption
>> [ 7557.049558] PM: suspend exit
>> [ 7557.148686] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
>> [ 7557.148702] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
>> [ 7557.310858] warning: `atop' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
>> [ 7557.452750] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
>> [ 7557.512621] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
>> [ 7557.538890] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> 


