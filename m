Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201D2642979
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 14:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiLENfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 08:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLENfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 08:35:22 -0500
X-Greylist: delayed 488 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 05:35:20 PST
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DDB10FC9;
        Mon,  5 Dec 2022 05:35:20 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 8C311C80094;
        Mon,  5 Dec 2022 14:27:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id CoHbXArkXHk7; Mon,  5 Dec 2022 14:27:10 +0100 (CET)
Received: from [192.168.178.52] (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id A5FDFC80091;
        Mon,  5 Dec 2022 14:27:09 +0100 (CET)
Message-ID: <9869d438-a715-fa5e-2877-b58f1bb6fc91@tuxedocomputers.com>
Date:   Mon, 5 Dec 2022 14:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] PCI: Continue E820 vs host bridge window saga
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221203175743.GA1121812@bhelgaas>
 <d7f1408d-ae9f-ad55-5fc9-9d9886384a3d@redhat.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <d7f1408d-ae9f-ad55-5fc9-9d9886384a3d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

Am 04.12.22 um 10:29 schrieb Hans de Goede:
> Hi Bjorn,
> 
> On 12/3/22 18:57, Bjorn Helgaas wrote:
>> On Sat, Dec 03, 2022 at 01:44:10PM +0100, Hans de Goede wrote:
>>> Hi Bjorn,
>>>
>>> On 12/2/22 22:18, Bjorn Helgaas wrote:
>>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>>
>>>> When allocating space for PCI BARs, Linux avoids allocating space mentioned
>>>> in the E820 map.  This was originally done by 4dc2287c1805 ("x86: avoid
>>>> E820 regions when allocating address space") to work around BIOS defects
>>>> that included unusable space in host bridge _CRS.
>>>>
>>>> Some recent machines use EfiMemoryMappedIO for PCI MMCONFIG and host bridge
>>>> apertures, and bootloaders and EFI stubs convert those to E820 regions,
>>>> which means we can't allocate space for hot-added PCI devices (often a
>>>> dock) or for devices the BIOS didn't configure (often a touchpad)
>>>>
>>>> The current strategy is to add DMI quirks that disable the E820 filtering
>>>> on these machines and to disable it entirely starting with 2023 BIOSes:
>>>>
>>>>    d341838d776a ("x86/PCI: Disable E820 reserved region clipping via quirks")
>>>>    0ae084d5a674 ("x86/PCI: Disable E820 reserved region clipping starting in 2023")
>>>>
>>>> But the quirks are problematic because it's really hard to list all the
>>>> machines that need them.
>>>>
>>>> This series is an attempt at a more generic approach.  I'm told by firmware
>>>> folks that EfiMemoryMappedIO means "the OS should map this area so EFI
>>>> runtime services can use it in virtual mode," but does not prevent the OS
>>>> from using it.
>>>>
>>>> The first patch removes any EfiMemoryMappedIO areas from the E820 map.
>>>> This doesn't affect any virtual mapping of those areas (that would have to
>>>> be done directly from the EFI memory map) but it means Linux can allocate
>>>> space for PCI MMIO.
>>>>
>>>> The rest are basically cosmetic log message changes.
>>>
>>> Thank you for working on this. I'm a bit worried about this series though.
>>>
>>> The 2 things which I worry about are:
>>>
>>>
>>> 1. I think this will not help when people boot in BIOS (CSM) mode rather
>>> then UEFI mode which quite a few Linux users still do because they learned
>>> to do this years ago when Linux EFI support (and EFI fw itself) was still
>>> a bit in flux.
>>>
>>> IIRC from the last time we looked at this in CSM mode the BIOS itself
>>> translates the EfiMemoryMappedIO areas to reserved E820 regions. So when
>>> people use the BIOS CSM mode to boot, then this patch will not help
>>> since the kernel lacks the info to do the translation.
>>
>> Right, if BIOS CSM puts EfiMemoryMappedIO in the E820 map the same way
>> bootloaders do, and the kernel doesn't have the EFI memory map, this
>> series won't help.
> 
> So I just got the requested dmesg in BIOS CSM mode from:
> https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> 
> And it says:
> 
> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
> [    0.316140] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
> 
> So I'm afraid that I remembered correctly and the CSM adds
> the EfiMemoryMappedIO regions to the E820 map as reserved :(
> 
> So as you said, this series won't help for people booting in
> BIOS compatibility mode. Which means that we should at least keep
> the current list of no_e820 quirks to avoid regressing those models
> when booted in BIOS compatibility mode.
> 
> And maybe still add at least the Clevo model for which I recently
> submitted a new no_e820 quirk so that that will work in BIOS CSM
> mode too ?
Do you mean the X170KM-G? I don't think it has the option to switch to Legacy 
BIOS mode (At least i didn't found an option in the bios version i have)
> 
> Note I know you did not propose to drop the quirks in this series,
> just covering all the bases here.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
Kind regards,
Werner Sembach
