Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CAE3E49C3
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 18:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhHIQZZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 12:25:25 -0400
Received: from foss.arm.com ([217.140.110.172]:36284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232310AbhHIQZP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Aug 2021 12:25:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5FD6D6E;
        Mon,  9 Aug 2021 09:24:51 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C00E3F718;
        Mon,  9 Aug 2021 09:24:51 -0700 (PDT)
Subject: Re: [PATCH 3/3] PCI/ACPI: Add new quirk detection, enable bcm2711
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210806221256.GA1891371@bjorn-Precision-5520>
 <5f4f484b-9eef-2722-405d-a7ff6259aa0f@arm.com>
 <CAL_JsqL=ipGBOsMUaCDvAETX5DQ2tCunNSAtFs6VZybOW7Xrdg@mail.gmail.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <ba0409df-dbd7-b765-48d4-a2db846de689@arm.com>
Date:   Mon, 9 Aug 2021 11:24:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL=ipGBOsMUaCDvAETX5DQ2tCunNSAtFs6VZybOW7Xrdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thanks for looking at this.

On 8/9/21 10:27 AM, Rob Herring wrote:
> On Fri, Aug 6, 2021 at 6:35 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>>
>> Hi,
>>
>> Thanks for looking at this.
>>
>> On 8/6/21 5:12 PM, Bjorn Helgaas wrote:
>>> In subject, this or similar would match history:
>>>
>>>     PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
>>>
>>> On Thu, Aug 05, 2021 at 04:12:00PM -0500, Jeremy Linton wrote:
>>>> Now that we have a bcm2711 quirk, we need to be able to
>>>> detect it when the MCFG is missing. Use a namespace
>>>> property as an alternative to the MCFG OEM.
>>>
>>> Rewrap to use ~75 columns.
>>>
>>> Mention the DT namespace property here.
>>>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>> ---
>>>>    drivers/acpi/pci_mcfg.c | 14 ++++++++++++++
>>>>    1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>>>> index 53cab975f612..7d77fc72c2a4 100644
>>>> --- a/drivers/acpi/pci_mcfg.c
>>>> +++ b/drivers/acpi/pci_mcfg.c
>>>> @@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
>>>>       ALTRA_ECAM_QUIRK(1, 13),
>>>>       ALTRA_ECAM_QUIRK(1, 14),
>>>>       ALTRA_ECAM_QUIRK(1, 15),
>>>> +
>>>> +    { "bcm2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
>>>> +      DEFINE_RES_MEM(0xFD500000, 0xA000) },
>>>>    };
>>>>
>>>>    static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
>>>> @@ -198,8 +201,19 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
>>>>       u16 segment = root->segment;
>>>>       struct resource *bus_range = &root->secondary;
>>>>       struct mcfg_fixup *f;
>>>> +    const char *soc;
>>>>       int i;
>>>>
>>>> +    /*
>>>> +     * This could be a machine with a PCI/SMC conduit,
>>>> +     * which means it doens't have MCFG. Get the machineid from
>>>> +     * the namespace definition instead.
>>>
>>> s/SMC/SMCCC/ ?  Cover letter uses SMCCC (not sure it's relevant anyway)
>>> s/doens't/doesn't/
>>>
>>> Rewrap comment to use ~80 columns.
>>>
>>> Seems pretty reasonable that a platform without standard ECAM might
>>> not have MCFG, since MCFG basically implies ECAM.
>>
>>
>> Sure, on all the above comments.
>>
>>>
>>> Is "linux,pcie-quirk" the right property to look for?  It doesn't
>>> sound very generic, and it doesn't sound like anything related to
>>> ECAM.  Is it new?  I don't see it in the tree yet.  Should it be in
>>> Documentation/devicetree/bindings/pci/pci.txt so we don't get a
>>> different property name for every new platform?
> 
> No, it should not be in pci.txt. Nothing to do with DT and I don't
> review ACPI bindings (someone should) if I can help it.

That is the intention of the uefi properties registry I referred to 
earlier. It has a code first model too, which allows us to review it 
here and then update the document with the property and the intended 
behavior.

> 
>> Yes, I made it up. Someone else commented about the "linux," partially
>> because it should be "linux-" to conform with
>> https://github.com/UEFI/DSD-Guide. But also in the same context of it
>> being linux specific.  I think that guide is where it should end up,
>> rather than the devicetree bindings.
>>
>> I guess we can request addition to the uefi- but that seems like a
>> mistake this is really (hopefully?) a Linux specific properly as other
>> OS's will simply use the SMC. I think we could request another prefix if
>> we come up with a good one and think it belongs in that guide.
> 
> It's only Linux specific until it's not.
> 
> What happens when there's a second PCIe quirk here? Say what the quirk
> is (and not in terms of Linux policy).

This is really just a stand in for the existing MCFG oem id, its an 
identifier to key off, nothing else.  Maybe a better name is 
"linux-ecam-quirk-id" or something to that effect?

> 
> Don't you know the device here and can imply all this (like implying
> off of 'compatible' in DT)? Adding properties to address issues
> creates compatibility issues. Maybe not an issue in this case if the
> firmware is not stable, but not a good practice to be in.

Yes, and no, I think there was some discussion a few years back about 
using non standard HID's for these nonstandard implementations, but that 
was discouraged at the time in favor of using the standard identifiers 
and and keying off a Soc/platform specific ID to enable a "quirk". Given 
we are a bit far down that path and the decision was made to continue 
down it (rather than solving much of it with a new firmware interface) 
this seems like the straightforward solution. The vast majority of these 
are SoC specific, and just minor tweaks for alignment/etc. Given its an 
ACPI/UEFI machine we are already hiding a lot of the platform specific 
behavior for configuring the bridge/etc that might require DT like 
properties in the firmware.


Thanks again.

