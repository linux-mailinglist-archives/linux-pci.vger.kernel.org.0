Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669DB4A812D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 10:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349712AbiBCJKR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 04:10:17 -0500
Received: from foss.arm.com ([217.140.110.172]:33004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349716AbiBCJKP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Feb 2022 04:10:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8072A113E;
        Thu,  3 Feb 2022 01:10:15 -0800 (PST)
Received: from [192.168.1.11] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF3973F73B;
        Thu,  3 Feb 2022 01:10:14 -0800 (PST)
Subject: Re: [Bug 215560] New: _PRS/_SRS methods should be optional
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20220202174255.GA22220@bhelgaas>
From:   Pierre Gondois <pierre.gondois@arm.com>
Message-ID: <b0a94d3d-b91f-6c54-3a02-91e053ce1ddf@arm.com>
Date:   Thu, 3 Feb 2022 10:10:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220202174255.GA22220@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn

On 2/2/22 6:42 PM, Bjorn Helgaas wrote:
> Hi Pierre,
> 
> Thanks a lot for the report!
> 
> On Wed, Feb 02, 2022 at 10:20:44AM +0000, bugzilla-daemon@kernel.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=215560
>>
>>              Bug ID: 215560
>>             Summary: _PRS/_SRS methods should be optional
>>             Product: Drivers
>>             Version: 2.5
>>      Kernel Version: v5.17-rc2
>>            Hardware: All
>>                  OS: Linux
>>                Tree: Mainline
>>              Status: NEW
>>            Severity: enhancement
>>            Priority: P1
>>           Component: PCI
>>            Assignee: drivers_pci@kernel-bugs.osdl.org
>>            Reporter: pierre.gondois@arm.com
>>          Regression: No
>>
>> The PCI legacy interrupts can be described with link devices, cf ACPI 6.4,
>> s6.2.13 "_PRT (PCI Routing Table)".
>> Link devices can have optional _SRS/_PRS methods to set the interrupt.
> 
> Is this a direct quote?  I don't see text similar to this in ACPI
> v6.4.
> 

No it was not a direct quote. However from ACPI 6.4, s6.2.12 "_PRS
(Possible Resource Settings)":
'''This optional object evaluates [...]'''

and similarly at s6.2.16 "_SRS (Set Resource Settings)"
'''This optional control method [...]'''


> I do see this in sec 6.2.13:
> 
>    There are two ways that _PRT can be used. Typically, the interrupt
>    input that a given PCI interrupt is on is configurable.  For
>    example, a given PCI interrupt might be configured for either IRQ 10
>    or 11 on an 8259 interrupt controller. In this model, each interrupt
>    is represented in the ACPI namespace as a PCI Interrupt Link Device.
> 
>    These objects have _PRS, _CRS, _SRS, and _DIS control methods to
>    allocate the interrupt. Then, OSPM handles the interrupts not as
>    interrupt inputs on the interrupt controller, but as PCI interrupt
>    pins. The driver looks up the device’s pins in the _PRT to determine
>    which device objects allocate the interrupts. To move the PCI
>    interrupt to a different interrupt input on the interrupt
>    controller, OSPM uses _PRS, _CRS, _SRS, and _DIS control methods for
>    the PCI Interrupt Link Device.
> 
>    In the second model, the PCI interrupts are hardwired to specific
>    interrupt inputs on the interrupt controller and are not
>    configurable. In this case, the Source field in _PRT does not
>    reference a device, but instead contains the value zero, and the
>    Source Index field contains the global system interrupt to which the
>    PCI interrupt is hardwired.
> 
> For the first model (configurable inputs), it says "These objects have
> _PRS, _CRS, _SRS, and _DIS," which could be read as requiring those
> objects.
> 
> For the second model (hardwired inputs), the interrupts are not
> configurable, and I don't think there would be any reason to have an
> interrupt link device at all.
> 
>> In PCI Firmware Specification Revision 3.3, s4.3.2.1. "Resource Setting":
>> """
>> A non-configurable device only specifies _CRS. However, if they are
>> configurable, devices include
>> _PRS to indicate the possible resource setting and _SRS to allow OSPM to
>> specify a new resource
>> allocation for the device.
>> """
> 
> My copy of the PCI Firmware spec r3.3 (dated Jan 20, 2021), sec
> 4.3.2.1 says:
> 
>    Host bridges resources programming is communicated to the operating
>    system using ACPI methods _CRS, _SRS, and _PRS. _CRS indicates the
>    current resource setting for the host bridge. This includes I/O
>    space, memory space, and bus range assigned to the bridge by
>    platform firmware.
> 
>    A non-configurable device only specifies _CRS. However, if they are
>    configurable, devices include _PRS to indicate the possible resource
>    setting and _SRS to allow OSPM to specify a new resource allocation
>    for the device.
> 
> So this is specifically talking about methods of a PCI host bridge
> (PNP0A03 or PNP0A08), not about methods of an interrupt link device
> (PNP0C0F).
> 

Yes indeed, this quote was not relevant.

>> However, _PRS/_SRS methods are checked in drivers/acpi/pci_link.c, and the
>> driver aborts if they are absent.
>> E.g.: When _PRS is missing:
>> ACPI: \_SB_.PCI0.LNKA: _CRS 36 not found in _PRS
>> ACPI: \_SB_.PCI0.LNKA: No IRQ available. Try pci=noacpi or acpi=off
> 
> I assume this bug report is because something isn't working.  Can you
> update the bugzilla with a note about what specifically isn't working
> and also attach a complete dmesg log and acpidump?
> 

The question arose while writing link devices code, so there is no platform
with missing _PRS/_SRS methods that I know.
The question was more about spec compliance and the necessity to have these
methods when legacy interrupts are not configurable.
The message above (_CRS XXX not found in _PRS) can be generated for a Juno
for instance, and the ACPI tables are at:
https://github.com/tianocore/edk2-platforms/blob/master/Platform/ARM/JunoPkg/AcpiTables/AcpiSsdtRootPci.asl
The ACPI table need to be modified (remove _PRS and set _CRS correctly).

If the conclusion is that _PRS/_SRS are mandatory, even for hard-wired
interrupts, then the bugzilla can be closed.

Thanks for the quick answer,
Pierre

> Bjorn
> 
