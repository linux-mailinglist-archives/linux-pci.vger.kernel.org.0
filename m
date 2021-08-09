Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BE13E4E55
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 23:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhHIVVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 17:21:48 -0400
Received: from foss.arm.com ([217.140.110.172]:41270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhHIVVr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Aug 2021 17:21:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2705D6D;
        Mon,  9 Aug 2021 14:21:26 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1DEB3F40C;
        Mon,  9 Aug 2021 14:21:25 -0700 (PDT)
Subject: Re: [PATCH 2/3] PCI: brcmstb: Add ACPI config space quirk
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        nsaenz@kernel.org, bhelgaas@google.com, rjw@rjwysocki.net,
        lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210809203323.GA2184624@bjorn-Precision-5520>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <e3d3394d-c241-77f7-e40a-b14726cc0063@arm.com>
Date:   Mon, 9 Aug 2021 16:21:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210809203323.GA2184624@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/9/21 3:33 PM, Bjorn Helgaas wrote:
> On Mon, Aug 09, 2021 at 02:48:17PM -0500, Jeremy Linton wrote:
>> Hi,
>>
>> On 8/9/21 12:42 PM, Bjorn Helgaas wrote:
>>> On Fri, Aug 06, 2021 at 09:55:27PM -0500, Jeremy Linton wrote:
>>>> Hi,
>>>>
>>>> On 8/6/21 5:21 PM, Bjorn Helgaas wrote:
>>>>> On Thu, Aug 05, 2021 at 04:11:59PM -0500, Jeremy Linton wrote:
>>>>>> The PFTF CM4 is an ACPI platform that is following the PCIe SMCCC
>>>>>> standard because its PCIe config space isn't ECAM compliant and is
>>>>>> split into two parts. One part for the root port registers and a
>>>>>> moveable window which points at a given device's 4K config space.
>>>>>> Thus it doesn't have a MCFG (and really any MCFG provided would be
>>>>>> nonsense anyway). As Linux doesn't support the PCIe SMCCC standard
>>>>>> we key off a Linux specific host bridge _DSD to add custom ECAM
>>>>>> ops and cfgres. The cfg op selects between those two regions, as
>>>>>> well as disallowing problematic accesses, particularly if the link
>>>>>> is down because there isn't an attached device.
>>>>>
>>>>> I'm not sure SMCCC is *really* relevant here.  If it is, an expansion
>>>>> of the acronym and a link to a spec would be helpful.
>>>>>
>>>>> But AFAICT the only important thing here is that it doesn't have
>>>>> standard ECAM, and we're going to work around that.
>>>>
>>>> I will reword it a bit.
>>>>
>>>>> I don't see anything about _DSD in this series.
>>>>
>>>> That is the "linux,pci-quirk" in the next patch.
>>>
>>> The next patch doesn't mention _DSD either.  Is it obfuscated by
>>> being inside fwnode_property_read_string()?  If so, it's well and
>>> truly hidden; I gave up trying to connect that with ACPI.
>>
>> Right, the fwnode stuff works as a DT/ACPI abstraction for reading values
>> from firmware tables. In this case the ACPI definition looks something like:
>>
>> Device(PCI0) {
>> ...
>>    Name (_DSD, Package () {
>>    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>      Package () {
>>      Package () { "linux-pcie-quirk", "bcm2711" },
>>    }
>>    })
>>
>> ...
>> }
>>
>> Which explains a bit of why the underlying code is a bit uh... complicated.
> 
> Wow, that's ... special.
> 
> I think I would include "ecam" or something in the name.  There might
> be a variety of quirks, e.g., "P2PDMA allowed between root ports",
> that could reasonably fit under "linux-pcie-quirk".
> 

I think I mentioned "linux-ecam-quirk-id" in the bit with Rob. How is that?

I think the description would be something roughly: MCFG oem id override 
string which selects a platform specific ECAM accessor quirk.

Thanks,
