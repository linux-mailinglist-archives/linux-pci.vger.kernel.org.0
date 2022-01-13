Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F45348D2AF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 08:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiAMHOC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 02:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiAMHOB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 02:14:01 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7661EC06173F
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 23:14:01 -0800 (PST)
Received: from smtp2.mailbox.org (unknown [91.198.250.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4JZFzC6FgszQjgJ;
        Thu, 13 Jan 2022 08:13:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <8aa08fac-369b-096c-8d49-eeb9dd15fa59@denx.de>
Date:   Thu, 13 Jan 2022 08:13:55 +0100
MIME-Version: 1.0
Subject: Re: PCIe AER generates no interrupts on host (ZynqMP)
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20220112174915.GA264064@bhelgaas>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220112174915.GA264064@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/12/22 18:49, Bjorn Helgaas wrote:
> [+cc Rafael, mentioned 2bd50dd800b5 again]
> 
> On Tue, Jan 11, 2022 at 09:14:13AM +0100, Stefan Roese wrote:
>> On 1/10/22 13:16, Stefan Roese wrote:
>>> On 1/7/22 11:04, Pali Rohár wrote:
>>>> Hello! You asked me in another email for comments to this email, so I'm
>>>> replying directly to this email...
>>>
>>> Thanks a lot for you input here. Please find some comments below...
>>>
>>>> On Tuesday 04 January 2022 10:02:18 Stefan Roese wrote:
>>>>> Hi,
>>>>>
>>>>> I'm trying to get the Kernel PCIe AER infrastructure to work
>>>>> on my ZynqMP based system. E.g. handle the events
>>>>> (correctable, uncorrectable etc). In my current tests, no AER
>>>>> interrupt is generated though. I'm currently using the
>>>>> "surprise down error status" in the uncorrectable error status
>>>>> register of the connected PCIe switch (PLX / Broadcom
>>>>> PEX8718). Here the bit is correctly logged in the PEX switch
>>>>> uncorrectable error status register but no interrupt is
>>>>> generated to the root-port / system. And hence no AER
>>>>> message(s) reported.
>>>>>
>>>>> Does any one of you have some ideas on what might be missing?
>>>>> Why are these events not reported to the PCIe rootport driver
>>>>> via IRQ? Might this be a problem of the missing MSI-X support
>>>>> of the ZynqMP? The AER interrupt is connected as legacy IRQ:
>>>>>
>>>>> cat /proc/interrupts | grep -i aer
>>>>>    58:          0          0          0          0
>>>>> nwl_pcie:legacy   0 Level
>>>>> PCIe PME, aerdrv
>>>>
>>>> Error events (correctable, non-fatal and fatal) are reported by
>>>> PCIe devices to the Root Complex via PCIe error messages
>>>> (Message code of TLP is set to Error Message) and not via
>>>> interrupts. Root Port is then responsible to "convert" these
>>>> PCIe error messages to MSI(X) interrupt and report it to the
>>>> system. According to PCIe spec, AER is supported only via MSI(X)
>>>> interrupts, not legacy INTx.
>>>
>>> This seems not correct. From the ML link reported by Bjorn, there
>>> seems to be a platform specific interrupt on ZynqMP, to report the
>>> AER events.  At least this is how I interpret the patch from
>>> Bharat from that time.  In the meantime Bharat from Xilinx has
>>> sent me a link to a newer, updated patch series to use this "misc"
>>> interrupts for AER instead. I'll get into more details on this in
>>> another reply.
>>>
>>>> Via Bridge Control register (SERR# enable bit) on the Root Port
>>>> it is possible to enable / disable reporting of these errors
>>>> from PCIe devices on the other end of PCIe link to the system.
>>>
>>> Here the BridgeCtl of the Root Port:
>>>     BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>>>
>>>> Then via Command register (SERR# enable bit) and Device Control
>>>> register it is possible to enable / disable reporting of all
>>>> errors (from Root Port and also devices on other end of the
>>>> link).
>>>
>>> The command registers have SERR disabled on all PCIe devices:
>>>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>> Stepping- SERR- FastB2B- DisINTx-
>>>
>>> Not sure if this is a problem. I would expect the Kernel PCI subsystem
>>> and the AER driver to enable the necessary bits. So is 'SERR-' here
>>> a problem?
>>>
>>> Device Control has the error reporting enabled:
>>>     DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>>
>> A small update on this:
>>
>> Just now I noticed, that these bits in the DevCtl register are
>> disabled in the PCIe switch setup downstream and upstream ports.
>> Actually, these bits are only enabled in the root port PCIe device.
>> After enabling these bits via setpci in the PEX switch the surprise
>> down message is reported correctly to the root port:
>>
>>   nwl-pcie fd0e0000.pcie: Fatal Error in AER Capability
>>   pcieport 0000:02:02.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>>   pcieport 0000:02:02.0:   device [10b5:8718] error status/mask=00000020/00000000
>>   pcieport 0000:02:02.0:    [ 5] SDES                   (First)
>>
>> Nice! :)
>>
>> So the question now is, why are these bits in the DevCtl registers of
>> these other PCIe devices disabled? Debugging shows that
>> get_port_device_capability() calls pci_disable_pcie_error_reporting()
>> *after* it has been enabled via the AER driver:
>>
>>   pcieport 0000:00:00.0: get_port_device_capability (225): pcie_ports_native=1 host->native_aer=1
>>   pcieport 0000:00:00.0: AER: pci_disable_pcie_error_reporting (246): rc=0
>>   pcieport 0000:00:00.0: AER: set_device_error_reporting (1218): enable=1
>>   pcieport 0000:00:00.0: AER: pci_enable_pcie_error_reporting (233): rc=0
>>   pci 0000:01:00.0: AER: set_device_error_reporting (1218): enable=1
>>   pci 0000:01:00.0: AER: pci_enable_pcie_error_reporting (233): rc=0
>>   pci 0000:02:01.0: AER: set_device_error_reporting (1218): enable=1
>>   pci 0000:02:01.0: AER: pci_enable_pcie_error_reporting (233): rc=0
>>   pci 0000:02:02.0: AER: set_device_error_reporting (1218): enable=1
>>   pci 0000:02:02.0: AER: pci_enable_pcie_error_reporting (233): rc=0
>>   pci 0000:04:00.0: AER: set_device_error_reporting (1218): enable=1
>>   pci 0000:02:03.0: AER: set_device_error_reporting (1218): enable=1
>>   pci 0000:02:03.0: AER: pci_enable_pcie_error_reporting (233): rc=0
>>   pcieport 0000:01:00.0: get_port_device_capability (225): pcie_ports_native=1 host->native_aer=1
>>   pcieport 0000:01:00.0: AER: pci_disable_pcie_error_reporting (246): rc=0
> 
> Ah.  I assume you have:
> 
>    00:00.0 Root Port to [bus 01-??]
>    01:00.0 Switch Upstream Port to [bus 02-??]
>    02:0?.0 Switch Downstream Port to [bus 04-??]

This is correct, yes.

> pcie_portdrv_probe() claims 00:00.0 and clears CERE NFERE FERE URRE.
> 
> aer_probe() claims 00:00.0 and enables CERE NFERE FERE URRE for all
> downstream devices, including 01:00.0.
> 
> pcie_portdrv_probe() claims 01:00.0 and clears CERE NFERE FERE URRE
> again.
> 
> aer_probe() declines to claim 01:00.0 because it's not a Root Port, so
> CERE NFERE FERE URRE remain cleared.
> 
>>   pcieport 0000:02:01.0: get_port_device_capability (225): pcie_ports_native=1 host->native_aer=1
>>   pcieport 0000:02:01.0: AER: pci_disable_pcie_error_reporting (246): rc=0
>>   pcieport 0000:02:02.0: get_port_device_capability (225): pcie_ports_native=1 host->native_aer=1
>>   pcieport 0000:02:02.0: AER: pci_disable_pcie_error_reporting (246): rc=0
>>   pcieport 0000:02:03.0: get_port_device_capability (225): pcie_ports_native=1 host->native_aer=1
>>   pcieport 0000:02:03.0: AER: pci_disable_pcie_error_reporting (246): rc=0
>>
>> Looking at the comment in get_port_device_capability() this might be the
>> wrong order (e.g. AER driver enabling vs pcieport disabling):
>>
>> static int get_port_device_capability(struct pci_dev *dev)
>> ...
>> 		/*
>> 		 * Disable AER on this port in case it's been enabled by the
>> 		 * BIOS (the AER service driver will enable it when necessary).
>> 		 */
>> 		pci_disable_pcie_error_reporting(dev);
>> 	}
>>
>> I'll look deeper into this today. But perhaps someone else has a quick
>> idea already?
> 
> This was added by 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services
> during port initialization").  Strangely, this same 11 year old commit
> came up yesterday [1] :)

;)

I'm baffled a bit, that this problem of AER reporting being disabled in
the DevCtl regs of PCIe ports (all non root ports) was not noticed for
this long time. As AER is practically disabled in such setups.

> I'm not 100% convinced that get_port_device_capability() should be
> calling pci_disable_pcie_error_reporting().  IMO, BIOS should not
> leave an interrupt enabled unless it has arranged to handle it.

Agreed.

> It's true that disabling it might work around a BIOS bug.  But the
> usual reason we call pci_disable_pcie_error_reporting() here is
> because host->native_aer is true, and that is usually because
> CONFIG_PCIEAER is set (and, for ACPI systems, _OSC granted us control
> of AER).  That means we're going to call aer_probe(), which should
> enable or disable AER interrupts as it needs.
> 
> So I'm curious whether just removing that call (and removing
> "pcie_ports=native" if you're using it) helps in your case.

Yes, removing the call to pci_disable_pcie_error_reporting() in
get_port_device_capability() helps in my case. DevCtl in the PCIe switch
upstream and downstream ports keeps the AER reporting enabled this way.

> I assume this is probably not an ACPI system, right?  Are you testing
> with Bharat's series [2] applied?

Yes and yes.

I'll work on a v3 of Bharat's series shortly. With your comments from
above, I'll also generate a patch to remove
pci_disable_pcie_error_reporting() from get_port_device_capability().
Let's see, where this does.

Thanks a lot for all your input,
Stefan
