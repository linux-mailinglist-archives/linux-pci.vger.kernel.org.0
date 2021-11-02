Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD17443460
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 18:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhKBRON (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 13:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhKBROJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Nov 2021 13:14:09 -0400
X-Greylist: delayed 479 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Nov 2021 10:11:34 PDT
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2254BC061714;
        Tue,  2 Nov 2021 10:11:27 -0700 (PDT)
Received: from smtp1.mailbox.org (unknown [91.198.250.123])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4HkGSW5PLRzQlDX;
        Tue,  2 Nov 2021 18:03:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211101150405.14618-1-pali@kernel.org>
 <20211102084241.GA6134@alpha.franken.de>
 <20211102090246.unmbruykfdjabfga@pali>
 <20211102094700.GA7376@alpha.franken.de>
 <20211102100034.rhcb3k2jvr6alm6y@pali>
 <alpine.DEB.2.21.2111021210180.57165@angie.orcam.me.uk>
 <20211102125843.sqsusis4krnmhorq@pali>
 <alpine.DEB.2.21.2111021312160.57165@angie.orcam.me.uk>
 <20211102144929.c5wt5pbl42ocrxly@pali> <20211102154831.xtrlgrmrizl5eidl@pali>
From:   Stefan Roese <sr@denx.de>
Message-ID: <aa580000-b4c6-2590-6196-48c10998320a@denx.de>
Date:   Tue, 2 Nov 2021 18:03:18 +0100
MIME-Version: 1.0
In-Reply-To: <20211102154831.xtrlgrmrizl5eidl@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F064618BF
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02.11.21 16:48, Pali Rohár wrote:
> On Tuesday 02 November 2021 15:49:29 Pali Rohár wrote:
>> On Tuesday 02 November 2021 14:01:41 Maciej W. Rozycki wrote:
>>> On Tue, 2 Nov 2021, Pali Rohár wrote:
>>>
>>>>>   None of the Galileo system controllers I came across had the class code
>>>>> set incorrectly.
>>>>
>>>> In kernel there is quirk only for one device with id:
>>>> PCI_VENDOR_ID_MARVELL (0x11ab) PCI_DEVICE_ID_MARVELL_GT64111 (0x4146)
>>>>
>>>> So for some reasons quirk is needed... Anyway, patch for this quirk just
>>>> adds comment as there is no explanation for it. It does not modify quirk
>>>> code.
>>>>
>>>> So it is possible that Marvell (or rather Galileo at that time) included
>>>> some config space fixup in some products and 0x4146 did not have it.
>>>> Just guessing... We can really only guess what could happen at that time
>>>> 20 years ago...
>>>
>>>   Ah, there you go! -- sadly I don't seem to have a copy of the datasheet
>>> for the GT-64111, but the GT-64115 has it[1]:
>>>
>>> Table 158: PCI Class Code and Revision ID, Offset: 0x008
>>>   Bits  Field name Function                                     Initial Value
>>>   7:0   RevID      Indicates the GT-64115 PCI Revision          0x01
>>>                    number.
>>>   15:8  Reserved   Read only.                                   0x0
>>>   23:16 SubClass   Indicates the GT-64115 Subclass - Mem-       0x80
>>>                    ory controller.
>>>   31:24 BaseClass  Indicates the GT-64115 Base Class -          0x05
>>>                    memory controller.
>>>
>>> and then:
>>>
>>> "Device and Vendor ID (0x000), Class Code and Revision ID (0x008), and
>>> Header Type (0x00e) fields are read only from the PCI bus.  These fields
>>> can be modified and read via the CPU bus."
>>>
>>> Likewise with the GT-64120[2]:
>>>
>>> Table 208: PCI_0 Class Code and Revision ID, Offset: 0x008 from PCI_0 or CPU; 0x088 from
>>>             PCI_1
>>>   Bits  Field name Function                                      Initial Value
>>>   7:0   RevID      Indicates the GT-64120 PCI_0 revision number. 0x02
>>>   15:8  Reserved   Read Only 0.                                  0x0
>>>   23:16 SubClass   Indicates the GT-64120 Subclass               Depends on value
>>>                    0x00 - Host Bridge Device.                    sampled at reset
>>>                    0x80 - Memory Device.                         on BankSel[0]. See
>>>                                                                  Table 44 on page
>>>                                                                  11-1.
>>>   31:24 BaseClass  Indicates the GT-64120 Base Class             Depends on value
>>>                    0x06 - Bridge Device.                         sampled at reset
>>>                    0x05 - Memory Device.                         on BankSel[0]. See
>>>                                                                  Table 44 on page
>>>                                                                  11-1.
>>>
>>> Table 209: PCI_1 Class Code and Revision ID, Offset: 0x088 from PCI_0 or CPU; 0x008 from
>>>             PCI_1
>>>   Bits  Field name Function                                      Initial Value
>>>   31:0  Various    Same as for PCI_0 Class Code and Revision ID.
>>>
>>> and then also:
>>>
>>> "Device and Vendor ID (0x000), Class Code and Revision ID (0x008), and
>>> Header Type (0x00e) fields are read only from the PCI bus.  These fields
>>> can be modified and read via the CPU bus."
>>>
>>> -- so this is system-specific and an intended chip feature rather than an
>>> erratum (or rather it is a system erratum if the reset strap or the boot
>>> firmware has got it wrong).
>>>
>>>   The memory device class code is IIUC meant to be typically chosen when
>>> the Galileo/Marvell device is used without the CPU interface, i.e. as a
>>> PCI memory controller device only[3].
> 
> I have found on internet some copy of GT64111 datasheet ("GT-64111
> System Controller for RC4640, RM523X and VR4300 CPUs", Galileo
> Technology, Product Preview Revision 1.1, FEB 4, 1999) and in section
> "17.15 PCI Configuration Registers" there is subsection "Class Code and
> Revision ID, Offset: 0x008" with content:
> 
> Bits  Field name Function                                           Initial Value
> 7:0   RevID      Indicates the GT-64111 Revision number.            0x10
>                   GT-64111-P-0 = 0x10
> 15:8  Reserved                                                      0x0
> 23:16 SubClass   Indicates the GT-64111 Subclass (0x80 - other mem- 0x80
>                   ory controller)
> 31:24 BaseClass  Indicates the GT-64111 Base Class (0x5 - memory    0x05
>                   controller).
> 
> And in section "6.5.3 PCI Autoconfiguration at RESET" is following
> interesting information:
> 
> Eight PCI registers can be automatically loaded after Rst*.
> Autoconfiguration mode is enabled by asserting the DMAReq[3]* LOW on
> Rst*. Any PCI transactions targeted for the GT-64111 will be retried
> while the loading of the PCI configuration registers is in process.
> 
> It is highly recommended that all PC applications utilize the PCI
> Autoconfiguration at RESET feature. The autoload feature can be easily
> implemented with a very low cost EPLD. Galileo provides sample EPLD
> equations upon request. (You can always pull the EPLD off your final
> product if you find there are no issues during testing.)
> 
> NOTE: The GT-64111’s default Class Code is 0x0580 (Memory Controller)
> which is a change from the GT-64011.
> 
> The GT-64011 used the Class Code 0x0600 which denotes Host Bridge. Some
> PCs refuse to configure host bridges if they are found plugged into a
> PCI slot (ask the BIOS vendors why...). The “Memory Controller” Class
> Code does not cause a problem for these non-compliant BIOSes, so we used
> this as the default in the GT-64111. The Class Code can be reporgrammed
> in both devices via autoload or CPU register writes.
> 
> The PCI register values are loaded from the ROM controlled by BootCS*
> are shown in Table 21, below.
> 
> TABLE 21. PCI Registers Loaded at RESET
> Register                        Offset Boot Device Address
> Device and Vendor ID            0x000  0x1fffffe0
> Class Code and Revision ID      0x008  0x1fffffe4
> Subsystem Device and Vendor ID  0x02c  0x1fffffe8
> Interrupt Pin and Line          0x03c  0x1fffffec
> RAS[1:0]* Bank Size             0xc08  0x1ffffff0
> RAS[3:2]* Bank Size             0xc0c  0x1ffffff4
> CS[2:0]* Bank Size              0xc10  0x1ffffff8
> CS[3]* & Boot CS* Bank Size     0xc14  0x1ffffffc
> 
> ===
> 
> So the conclusion is that there is also some RESET configuration via
> BootCS (I have no idea what it is or was). And default value (when RESET
> configuration is not used) is always "Memory controller" due to
> existence of "broken PC BIOSes" (probably x86).
> 
> Hence the quirk for GT64111 in kernel is always needed. And Thomas
> already confirmed in his pci hexdump that PCI Class code is set to
> Memory Controller.
> 
> I hope that now this mystery of this GT64111 quirk is solved :-) I will
> update patch with correct comment, why quirk is needed.
> 
> So due to the fact that 20 years ago there were broken x86 BIOSes which
> did not like PCI devices with PCI Class code of Host Bridge, Marvell
> changed default PCI Class code to Memory Controller and let it in this
> state also for future PCIe-based ARM and AR64 SoCs for next 20 years.
> Which generally leaded to broken PCIe support in mvebu SoCs. I have no
> more comments about it... :-(

If this is really the case, that all this was "copied" in such a bad
design state into newer SoC's for that many years, which I don't doubt
right now any more, then this is absolutely amazing and pretty sad IMHO.

Pali, many thanks for being persistant enough to dig through this.

Thanks,
Stefan
