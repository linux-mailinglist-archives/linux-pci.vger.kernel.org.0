Return-Path: <linux-pci+bounces-10569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A6193839F
	for <lists+linux-pci@lfdr.de>; Sun, 21 Jul 2024 08:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A5C2813F9
	for <lists+linux-pci@lfdr.de>; Sun, 21 Jul 2024 06:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0425256;
	Sun, 21 Jul 2024 06:51:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B83D66;
	Sun, 21 Jul 2024 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721544697; cv=none; b=DqhZ1NLkI+x8mI8lT0Jwsa5NLCKp6eRovAUGhdtsugReTzZmfEp3cvNs7TRQkV109loYXXgJ8a3m0z+024Vrzaq8gFwBmCbtv16XN918waJtTMaAVg6SxES/0X7MWtQVuPhfY4sKCMze31l1jliI72lV7UwqJflQt4iTH7fg54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721544697; c=relaxed/simple;
	bh=nBGbb3a+TRLLJqXXb6EAjC1BPjyzbQsVsCf6QyMMqQ4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=i4ly+ymjhpr5QKvnF8n9PD/13SBeJKqL1AxKPzHpaL84KFHqsRbndf3PXzggX8EB2f0PduN15WkdVM47SZDd1eNL3HzwqQAdhi6NNpMjAv9ri+O21Q6slk222wvwEkhftVoDVw2R6lIGj34IM5emckTBUMkBJIz3WBVRGScLWxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.4] (ip5f5af54b.dynamic.kabel-deutschland.de [95.90.245.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 46A1C61E5FE05;
	Sun, 21 Jul 2024 08:50:43 +0200 (CEST)
Message-ID: <6e967a85-09c6-4230-9e73-b0710444def4@molgen.mpg.de>
Date: Sun, 21 Jul 2024 08:50:39 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Dell XPS 13 9360: `slp_s0_residency_usec` stays 0
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: "David E. Box" <david.e.box@linux.intel.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Cc: David E Box <david.e.box@intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
References: <38fc334a-7c8c-4e43-bf63-6ac9aa882a2f@molgen.mpg.de>
 <c73a9072-27eb-4d42-b74a-52619a81837e@molgen.mpg.de>
 <81e937f0-df95-4e07-8d0f-3e20fce8481f@amd.com>
 <36a91aa1-84e3-4ad5-8384-1bd999c15675@molgen.mpg.de>
 <49bd6fea5a77a2b419e5c808e400f02fe275d9b1.camel@linux.intel.com>
 <0e25d09e-ca8a-407c-8a6e-8955fea765b5@molgen.mpg.de>
 <0ae5aef7-f65f-492b-86d6-ab8a3a3e2a54@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <0ae5aef7-f65f-492b-86d6-ab8a3a3e2a54@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear David, dear Rajneesh,


Am 14.06.24 um 15:36 schrieb Paul Menzel:

> Am 31.05.24 um 05:52 schrieb Paul Menzel:
> 
>> Am 30.05.24 um 23:24 schrieb David E. Box:
>>
>>> On Fri, 2024-05-24 at 06:53 +0200, Paul Menzel wrote:
>>
>>>> Am 22.05.24 um 18:37 schrieb Mario Limonciello:
>>>>> On 5/22/2024 10:52, Paul Menzel wrote:
>>>>
>>>>>> On the Intel Kaby Lake laptop Dell XPS 13 9360,
>>>>>> `/sys/kernel/debug/pmc_core/slp_s0_residency_usec` does stay 0 even
>>>>>> after a s2idle suspend/resume cycle.
>>>>>
>>>>> It won't change your numbers but FWIW you can also read from
>>>>>
>>>>> $ cat /sys/power/suspend_stats/last_hw_sleep
>>>>>
>>>>> which is also accessible under kernel lockdown.
>>>>>
>>>>>>       $ sudo dmesg
>>>>>>       […]
>>>>>>       [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>>>>>>       […]
>>>>>>       [10176.745124] PM: suspend entry (s2idle)
>>>>>>       [10176.757275] Filesystems sync: 0.012 seconds
>>>>>>       [10176.769118] Freezing user space processes
>>>>>>       [10176.771693] Freezing user space processes completed (elapsed 0.002 seconds)
>>>>>>       [10176.771710] OOM killer disabled.
>>>>>>       [10176.771714] Freezing remaining freezable tasks
>>>>>>       [10176.773487] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>>>>>>       [10176.773504] printk: Suspending console(s) (use no_console_suspend to debug)
>>>>>>       [10176.948337] ACPI: EC: interrupt blocked
>>>>>>       [10176.951016] intel_pch_thermal 0000:00:14.2: CPU-PCH is cool [48C]
>>>>>>       [10181.281827] ACPI: EC: interrupt unblocked
>>>>>>       $ sudo more /sys/kernel/debug/pmc_core/slp_s0_residency_usec
>>>>>>       0
>>>>>>
>>>>>> Is that expected?
>>>>>
>>>>> Is it a regression?  If so; probably it's worth bisecting.
>>>>
>>>> Sorry, I do not know. It’s the first time [1] I heard about this file,
>>>> and that fwts [2] checks it. Do you remember, if Dell has any public
>>>> logs from testing, containing `slp_s0_residency_usec`?
>>>>
>>>>> If it's not a regression IIUC you should probably run
>>>>> https://github.com/intel/S0ixSelftestTool for assistance in next steps
>>>>> on debugging why this is happening.
>>>>
>>>> Thank you for the pointer. Please find the log file from `sudo
>>>> ./s0ix-selftest-tool.sh -s` attached. Some PCIe ports are flagged.
>>
>>> The report suggests checking the kernel log for any error loading drm 
>>> firmware.
>>
>> Did you conclude that from the lines below?
>>
>>     GFX DC5 after S2idle: 59
>>     GFX DC6 after S2idle: 0
>>
>>     Your system CPU Model ID is: 142, and the graphics DC6 value is not expected to enter DC9,
>>     please check the latest display DMC FW load status:
>>
>>     Your system Intel graphics DMC FW loaded status is:yes
>>
>>> If the firmware is loaded properly, you should see a message similar to the
>>> following:
>>>
>>>      [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
>>
>> The firmware is loaded:
>>
>>      [  124.536942] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
> 
> Further tries show, the system does not reach PC10 state without 
> ignoring LTR 8 (PMC0:SOUTHPORT_C). With that LTR ignored, I think there 
> are sometimes problems regarding suspend/resume ACPI S3, but I have to 
> test that further. But even if with PC10 states being reached, after 
> S0ix suspend/resume, `slp_s0_residency_usec` remains 0.
> 
> Newly booted with nothing attached:
> 
> ```
> $ sudo turbostat --quiet --show 
> CPU%c1,CPU%c6,CPU%c7,GFX%rc6,Pkg%pc2,Pkg%pc3,Pkg%pc6,Pkg%pc7,Pkg%pc8,Pkg%pc9,Pk%pc10,SYS%LPI rtcwake -m freeze -s 10
> rtcwake: assuming RTC uses UTC ...
> rtcwake: wakeup from "freeze" using /dev/rtc0 at Fri Jun 14 09:05:12 2024
> 
> 10.931644 sec
> CPU%c1    CPU%c6    CPU%c7    GFX%rc6    Pkg%pc2    Pkg%pc3    Pkg%pc6    Pkg%pc7    Pkg%pc8 Pkg%pc9    Pk%pc10    SYS%LPI
> 1.40    0.56    96.21    589.96    2.83    0.44    0.13    0.01 92.07    0.00    0.00    0.00
> 0.84    0.24    96.89    589.96    2.83    0.44    0.13    0.01 92.07    0.00    0.00    0.00
> 1.40
> 1.94    0.89    95.53
> 1.41
> ```
> 
> Disable LTR 8:
> 
> ```
> $ sudo cat /sys/kernel/debug/pmc_core/ltr_show
> 0    PMC0:SOUTHPORT_A                         LTR: RAW: 0x8460846 Non-Snoop(ns): 0                   Snoop(ns): 0
> 1    PMC0:SOUTHPORT_B                         LTR: RAW: 0x0 Non-Snoop(ns): 0                   Snoop(ns): 0
> 2    PMC0:SATA                                LTR: RAW: 0x0 Non-Snoop(ns): 0                   Snoop(ns): 0
> 3    PMC0:GIGABIT_ETHERNET                    LTR: RAW: 0x0 Non-Snoop(ns): 0                   Snoop(ns): 0
> 4    PMC0:XHCI                                LTR: RAW: 0x88a0 Non-Snoop(ns): 0                   Snoop(ns): 163840
> 5    PMC0:Reserved                            LTR: RAW: 0x0 Non-Snoop(ns): 0                   Snoop(ns): 0
> 6    PMC0:ME                                  LTR: RAW: 0xc000c00 Non-Snoop(ns): 0                   Snoop(ns): 0
> 7    PMC0:EVA                                 LTR: RAW: 0x0 Non-Snoop(ns): 0                   Snoop(ns): 0
> 8    PMC0:SOUTHPORT_C                         LTR: RAW: 0x89f489f4 Non-Snoop(ns): 512000              Snoop(ns): 512000
> 9    PMC0:HD_AUDIO                            LTR: RAW: 0x0 Non-Snoop(ns): 0                   Snoop(ns): 0
> 10    PMC0:LPSS                                LTR: RAW: 0x0 Non-Snoop(ns): 0                   Snoop(ns): 0
> 11    PMC0:SOUTHPORT_D                         LTR: RAW: 0x0 Non-Snoop(ns): 0                   Snoop(ns): 0
> 12    PMC0:SOUTHPORT_E                         LTR: RAW: 0x0 Non-Snoop(ns): 0                   Snoop(ns): 0
> 13    PMC0:CAMERA                              LTR: RAW: 0x0 Non-Snoop(ns): 0                   Snoop(ns): 0
> 14    PMC0:ESPI                                LTR: RAW: 0x0 Non-Snoop(ns): 0                   Snoop(ns): 0
> 15    PMC0:SCC                                 LTR: RAW: 0x0 Non-Snoop(ns): 0                   Snoop(ns): 0
> 16    PMC0:ISH                                 LTR: RAW: 0x0 Non-Snoop(ns): 0                   Snoop(ns): 0
> 17    PMC0:CURRENT_PLATFORM                    LTR: RAW: 0x40201 Non-Snoop(ns): 0                   Snoop(ns): 0
> 18    PMC0:AGGREGATED_SYSTEM                   LTR: RAW: 0x3eca251 Non-Snoop(ns): 0                   Snoop(ns): 593
> $ echo 8 | sudo tee /sys/kernel/debug/pmc_core/ltr_ignore
> 8
> ```
> 
> and test again:
> 
> ```
> $ sudo turbostat --quiet --show CPU%c1,CPU%c6,CPU%c7,GFX%rc6,Pkg%pc2,Pkg%pc3,Pkg%pc6,Pkg%pc7,Pkg%pc8,Pkg%pc9,Pk%pc10,SYS%LPI rtcwake -m freeze -s 10
> rtcwake: assuming RTC uses UTC ...
> rtcwake: wakeup from "freeze" using /dev/rtc0 at Fri Jun 14 09:06:29 2024
> 11.025682 sec
> CPU%c1    CPU%c6    CPU%c7    GFX%rc6    Pkg%pc2    Pkg%pc3    Pkg%pc6    Pkg%pc7    Pkg%pc8 Pkg%pc9    Pk%pc10    SYS%LPI
> 1.45    0.57    96.39    1273.23    3.08    0.31    0.08    0.01    1.54    0.00    90.76    0.00
> 1.25    0.39    96.47    1273.21    3.08    0.31    0.08    0.01    1.54    0.00    90.76    0.00
> 1.90
> 1.48    0.75    96.31
> 1.16
> ```
> 
> Daniel Holz (Bcc) with a similar Dell XPS 13 9365 (also Kaby Lake) 
> reports similar issues [3].
> 
> Does somebody have an idea?

The problem persists with Linux 6.10-09675-g12cc3d5389f3.


Kind regards,

Paul


>>>> [1]: https://review.coreboot.org/c/coreboot/+/81595/10/src/mainboard/cwwk/adl/Kconfig#9
>>>> [2]: https://wiki.ubuntu.com/FirmwareTestSuite/
> [3]: https://bugzilla.kernel.org/show_bug.cgi?id=207893

>>>>>> PS: Some system details:
>>>>>>
>>>>>> ```
>>>>>> $ LANG= lspci -nn
>>>>>> 00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers [8086:5904] (rev 02)
>>>>>> 00:02.0 VGA compatible controller [0300]: Intel Corporation HD Graphics 620 [8086:5916] (rev 02)
>>>>>> 00:04.0 Signal processing controller [1180]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903] (rev 02) 
>>>>>> 00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller [8086:9d2f] (rev 21)
>>>>
>>>> […]

