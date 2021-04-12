Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BDF35D198
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 22:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbhDLUBN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 16:01:13 -0400
Received: from mail-eopbgr750071.outbound.protection.outlook.com ([40.107.75.71]:8103
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236978AbhDLUBN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Apr 2021 16:01:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLFUruR2vhMWQUP9xR5A91cQ52IN5FIBfJ5ktlH0ZDpf8yXjHwUztxGrhcxeewNwEMnoFtkqrghNBxULNhnGRmOrKI0z4myv2aSUmgbewrnPcx9WAboOISZHv1QS1iCQg5X603do5gnibf22u7I4yJUDbHMpSaS7HQRrQuO+VJfngqJ7z75iRreyaS8PeOB303j96v3i8XgkfFz/fA0E0ujGL3V1QYYpIHvS9/qTg1YoKTHfHHPYzZdQctrfxjvvJmnSk6GK8hypZxGdic3H+gGkB0hZ6lKI7JNQYdUFyCzm0UTNDCRR9wqYm5sjqqQyfGWFDjYI0DEhO2LLHE9MKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VorQfXBgtpdRn7YSY2KFbZCAoyi0OawSklJlghBN7bE=;
 b=hK5TRKgKp+5jT7MfDiYWeWET3gi8zbP0jX8KfBkKK6fplvlWhWv96TMgVETB+cH0hlxRFtsijTysawK+62pJ3eeImH07BBywdVzCJ2wIdqqj9SJWj6NUzJQ188m8y9wJRHfzE9QIaU135pi0d+wQBcpHAT+NBi1POCxOHOLGAVWKTk3WJ3tyj8v6tLMrkOk1KmK0SYtU6S4F9JqAE6MwXJnwT06tGZewTYPrMQnp3UyOiCcIl4PG5W0zgxbZ0vjy4irY1l+099ypLyJK1CFlqpC+lutGGAKl+r/usbFQ2/d1puHDHZdhbj28mG2+VhZ+oNXumPYlG9DBvVxRwbmshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VorQfXBgtpdRn7YSY2KFbZCAoyi0OawSklJlghBN7bE=;
 b=A1K50KtblEHYHzQp2ilafOsO1YLhJI16/HsaskN8fjwsxVCe2tlzHDce4j0wheTGLQDk8TQ3DHRqneZ6xzg11xk4jKAWe4KfsXxZknJ+KHEKPlb69k6YYg4YMSGZOHR3drX68UmXvD2lAP4utPL3SfCaaAVpOivfzTI1LTvTrmk1HmJcqPM7zEI/6KuCXNWkDW1vZhw9IQ7Q0IzsoOzJZWJ/vD9+BEXzISg3HPyK2TxlwotrLyP8XW5ZvrByXtyUVrwtLk3hrtn5Hv3VYm2hHhFdxToLqNRstWnL6YpTfJtGF5jfXSwsvhpUVhIw1X4f57+K4veI1xNzSbCkjtcFGw==
Received: from CO2PR04CA0204.namprd04.prod.outlook.com (2603:10b6:104:5::34)
 by MN2PR12MB3215.namprd12.prod.outlook.com (2603:10b6:208:101::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 20:00:53 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::4f) by CO2PR04CA0204.outlook.office365.com
 (2603:10b6:104:5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Mon, 12 Apr 2021 20:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 20:00:52 +0000
Received: from ace.plattnerplace.us (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 20:00:52 +0000
Subject: Re: [Nouveau] [PATCH v2] ALSA: hda: Continue to probe when codec
 probe fails
To:     Roy Spliet <nouveau@spliet.org>, Lukas Wunner <lukas@wunner.de>
CC:     Karol Herbst <kherbst@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        nouveau <nouveau@lists.freedesktop.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <tiwai@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mike Rapoport <rppt@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        open list <linux-kernel@vger.kernel.org>
References: <CAAd53p6Ef2zFX_t3y1c6O7BmHnxYGtGSfgzXAMQSom1ainWXzg@mail.gmail.com>
 <s5hsg85n2km.wl-tiwai@suse.de> <s5hmtydn0yg.wl-tiwai@suse.de>
 <CAAd53p6MMFh=HCNF9pyrJc9hVMZWFe7_8MvBcBHVWARqHU_TTA@mail.gmail.com>
 <s5h7dpfk06y.wl-tiwai@suse.de>
 <CAAd53p53w0H6tsb4JgQtFTkYinniicTYBs2uk7tc=heP2dM_Cw@mail.gmail.com>
 <CAKb7UvjWX7xbwMKtnad5EVy16nY1M-A13YJeRWyUwHzemcVswA@mail.gmail.com>
 <CAAd53p4=bSX26QzsPyV1sxADiuVn2sowWyb5JFDoPZQ+ZYoCzA@mail.gmail.com>
 <CACO55tsPx_UC3OPf9Hq9sGdnZg9jH1+B0zOi6EAxTZ13E1tf7A@mail.gmail.com>
 <d01e375f-bf16-a005-ec66-0910956cc616@spliet.org>
 <20210410192314.GB16240@wunner.de>
 <bddba2ca-15d5-7fd3-5b64-f4ba7e179ec0@spliet.org>
 <81b2a8c7-5b0b-b8fa-fbed-f164128de7a3@nvidia.com>
 <8d358110-769d-b984-d2ec-825dc2c3d77a@spliet.org>
X-Nvconfidentiality: public
From:   Aaron Plattner <aplattner@nvidia.com>
Message-ID: <d616715e-b0e3-74f6-9621-805fb5a0c898@nvidia.com>
Date:   Mon, 12 Apr 2021 13:00:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <8d358110-769d-b984-d2ec-825dc2c3d77a@spliet.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7e2bd62-4060-412d-3158-08d8fdedad49
X-MS-TrafficTypeDiagnostic: MN2PR12MB3215:
X-Microsoft-Antispam-PRVS: <MN2PR12MB32153AE1C6296E30987F7873CD709@MN2PR12MB3215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N8YrVPtI8jI9OqIlLJC9Zbt1Sujm7J8IzTAKiuPeJhKRy3jrVYOUH793QktHU777ztqTGUiARpuvdbihDJBRZkIXX1XBFIq/RXKso8OWGSrLChrCS0TVDgdhE4FpH7qJiWWiUj8vOrTrmyUhV7o4ldv014ZpnnDyyJklDfj8F4xny2FBAHdVNJ7dhWP5YSHaDV7I/DGeWuJ+CBJhgZp2KSJgndg7KN5Jsob9kDk9FC6pAEl5RRYgz1ioC46GxjnGydkxa8RT7tBgqomhRO9lesGCkw7T4ycZSTts4hjuJTdSM5mrOq/Hhpy4+MhOBCKmT6CxokhE3g1EZQBQvVjxHKqb5jCkQR55lO/1WzDmV5FI5Z4/nFrvHjzm7lQ6+yhcs4Epsz8OkhNQL9zhg9SwZXMVdbse2cSDZKAJICxlXlgRwKdF42kaPzSCsVsPjLX8JgAswJPsgL7mTCBNGs0A2rrPoMSwrPgQShtprfNvz18ikEJ8TO/vmy68GEo6P2qNzS4MYAk3m9v9ibVxJWkfraLnEWZTu/vb/fRQYXQ0JtyMuLt0SF62s+JFXaGlCRqc/kVI46c03K9t0PuHredkVbRSgb39zmodUx3YoeA6SFasYqmpQaWXrxAVZ4yHzNmkog+3uup8fK+wFXJ+eVQ+6RfvetdByhrTq9j/eRl0/jjqynUrzzXEi+1a9fuk9f4mMiJ3h90vnw6dxDXFCPg/BlnrkDebJOz2OB4UG5/y7kYGp+a2vKymAxBL3BRtEjgI5x4LfHqVuBZpOTau1ynwD/lZOP8N7wWY1S/p9u4a8Uk=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966006)(36840700001)(70586007)(966005)(7636003)(26005)(82740400003)(478600001)(356005)(36756003)(4326008)(8936002)(336012)(5660300002)(82310400003)(36906005)(16526019)(186003)(86362001)(83380400001)(2906002)(31686004)(31696002)(2616005)(53546011)(110136005)(8676002)(47076005)(426003)(7416002)(316002)(70206006)(36860700001)(54906003)(75396010)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 20:00:52.8637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e2bd62-4060-412d-3158-08d8fdedad49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3215
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/12/21 12:36 PM, Roy Spliet wrote:
> Hello Aaron,
>
> Thanks for your insights. A follow-up query and some observations 
> in-line.
>
> Op 12-04-2021 om 20:06 schreef Aaron Plattner:
>> On 4/10/21 1:48 PM, Roy Spliet wrote:
>>> Op 10-04-2021 om 20:23 schreef Lukas Wunner:
>>>> On Sat, Apr 10, 2021 at 04:51:27PM +0100, Roy Spliet wrote:
>>>>> Can I ask someone with more
>>>>> technical knowledge of snd_hda_intel and vgaswitcheroo to 
>>>>> brainstorm about
>>>>> the possible challenges of nouveau taking matters into its own 
>>>>> hand rather
>>>>> than keeping this PCI quirk around?
>>>>
>>>> It sounds to me like the HDA is not powered if no cable is plugged in.
>>>> What is reponsible then for powering it up or down, firmware code on
>>>> the GPU or in the host's BIOS?
>>>
>>> Sometimes the BIOS, but definitely unconditionally the PCI quirk 
>>> code: 
>>> https://github.com/torvalds/linux/blob/master/drivers/pci/quirks.c#L5289 
>>>
>>>
>>> (CC Aaron Plattner)
>>
>> My basic understanding is that the audio function stops responding 
>> whenever the graphics function is powered off. So the requirement 
>> here is that the audio driver can't try to talk to the audio function 
>> while the graphics function is asleep, and must trigger a graphics 
>> function wakeup before trying to communicate with the audio function.
>
> I believe that vgaswitcheroo takes care of this for us.
>
>> I think there are also requirements about the audio function needing 
>> to be awake when the graphics driver is updating the ELD, but I'm not 
>> sure.
>>
>> This is harder on Windows because the audio driver lives in its own 
>> little world doing its own thing but on Linux we can do better.
>>
>>>> Ideally, we should try to find out how to control HDA power from the
>>>> operating system rather than trying to cooperate with whatever 
>>>> firmware
>>>> is doing.  If we have that capability, the OS should power the HDA up
>>>> and down as it sees fit.
>>
>> After system boot, I don't think there's any firmware involved, but 
>> I'm not super familiar with the low-level details and it's possible 
>> the situation changed since I last looked at it.
>>
>> I think the problem with having nouveau write this quirk is that the 
>> kernel will need to re-probe the PCI device to notice that it has 
>> suddenly become a multi-function device with an audio function, and 
>> hotplug the audio driver. I originally looked into trying to do that 
>> but it was tricky because the PCI subsystem didn't really have a 
>> mechanism for a single-function device to become a multi-function 
>> device on the fly and it seemed easier to enable it early on during 
>> bus enumeration. That way the kernel sees both functions all the time 
>> without anything else having to be special about this configuration.
>
> Right, so for a little more context: a while ago I noticed that my 
> laptop (lucky me, Asus K501UB) has a 940M with HDA but no codec. Seems 
> legit, given how this GPU has no displays attached; they're all hooked 
> up to the Intel integrated GPU. That threw off the snd_hda_intel 
> mid-probe, and as a result didn't permit runpm, keeping the entire 
> GPU, PCIe bus and thus the CPU package awake. A bit of hackerly later 
> we decided to continue probing without a codec, and now my laptop is 
> happy, but...

What is the PCI class of the GPU in your system? If it has no display 
outputs it's probably 0x302 ("3D Controller") rather than 0x300 ("VGA 
Controller"). Looking at the code it looks like this workaround is being 
applied to both but maybe it should be restricted to just VGA controllers.

-- Aaron

> A new problem popped up with several other NVIDIA GPUs that expose 
> their HDA subdevice, but somehow its inaccessible. Relevant lines from 
> a users' log:
>
> [    3.031222] MXM: GUID detected in BIOS
> [    3.031280] ACPI BIOS Error (bug): AE_AML_PACKAGE_LIMIT, Index 
> (0x000000003) is beyond end of object (length 0x0) 
> (20200925/exoparg2-393)
> [    3.031352] ACPI Error: Aborting method \_SB.PCI0.GFX0._DSM due to 
> previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    3.031419] ACPI: \_SB_.PCI0.GFX0: failed to evaluate _DSM (0x300b)
> [    3.031424] ACPI Warning: \_SB.PCI0.GFX0._DSM: Argument #4 type 
> mismatch - Found [Buffer], ACPI requires [Package] 
> (20200925/nsarguments-61)
> [    3.031619] pci 0000:00:02.0: optimus capabilities: enabled, status 
> dynamic power,
> [    3.031667] ACPI BIOS Error (bug): AE_AML_PACKAGE_LIMIT, Index 
> (0x000000003) is beyond end of object (length 0x0) 
> (20200925/exoparg2-393)
> [    3.031731] ACPI Error: Aborting method \_SB.PCI0.GFX0._DSM due to 
> previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    3.031791] ACPI Error: Aborting method \_SB.PCI0.PEG0.PEGP._DSM 
> due to previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    3.031856] ACPI: \_SB_.PCI0.PEG0.PEGP: failed to evaluate _DSM 
> (0x300b)
> [    3.031859] ACPI Warning: \_SB.PCI0.PEG0.PEGP._DSM: Argument #4 
> type mismatch - Found [Buffer], ACPI requires [Package] 
> (20200925/nsarguments-61)
> [    3.032058] pci 0000:01:00.0: optimus capabilities: enabled, status 
> dynamic power,
> [    3.032061] VGA switcheroo: detected Optimus DSM method 
> \_SB_.PCI0.PEG0.PEGP handle
> [    3.032323] checking generic (d0000000 410000) vs hw (f6000000 
> 1000000)
> [    3.032325] checking generic (d0000000 410000) vs hw (e0000000 
> 10000000)
> [    3.032326] checking generic (d0000000 410000) vs hw (f0000000 
> 2000000)
> [    3.032410] nouveau 0000:01:00.0: NVIDIA GK107 (0e71f0a2)
> [    3.042385] nouveau 0000:01:00.0: bios: version 80.07.a0.00.11
> --- snip ---
> [    8.951478] snd_hda_intel 0000:01:00.1: can't change power state 
> from D3cold to D0 (config space inaccessible)
> [    8.951509] snd_hda_intel 0000:01:00.1: can't change power state 
> from D3hot to D0 (config space inaccessible)
> [    8.951608] snd_hda_intel 0000:01:00.1: Disabling MSI
> [    8.951621] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio 
> client
> [    8.952461] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops 
> i915_audio_component_bind_ops [i915])
> [    8.952642] snd_hda_intel 0000:01:00.1: number of I/O streams is 
> 30, forcing separate stream tags
>
> Now I don't know what's going on, but the snd_hda_intel messages are 
> ominous. And so are the ACPI warnings. But I don't know how much these 
> two are related.
>
> You say that it is desirable to switch on HDA at boot-time because the 
> PCI subsystem doesn't play nicely with changing a device to 
> multi-function. That rules out the option of only enabling the HDA 
> device once a cable is plugged in. Are there any other trap doors that 
> snd_hda_intel needs to navigate around to make this work fault free on 
> all hardware, such as:
> - Codecs not revealing themselves until a display is plugged in, 
> requiring perhaps a "codec reprobe" and "codec remove" event from 
> nouveau/rm to snd_hda_intel,
> - Borked BIOSes just blindly assigning the MMIO space of the HDA 
> device to another device, or nothing at all,
> - ... other things that might give any of us nightmares and heart burn?
>
> Thanks!
>
> Roy
>
>>
>> -- Aaron
>>
>>>> Thanks,
>>>>
>>>> Lukas
>
