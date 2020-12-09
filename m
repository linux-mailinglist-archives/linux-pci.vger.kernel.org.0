Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DC72D4E63
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 23:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgLIW4X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 17:56:23 -0500
Received: from halon.esss.lu.se ([194.47.240.54]:10582 "EHLO halon.esss.lu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388129AbgLIW4X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Dec 2020 17:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=wW84N6/fQ2jCRPtKTbwjvgxoe8V8lHWLLMtWBWVR4gw=;
        b=p3uPEuYjx5NKl9X/q2zhb5fxqtDu4ywMFAXbMui6+lcZg3PZFn/g3iEhXGLTN93gfJQSl67jSPzGF
         QKI9ZCktdo41fHzsbnbQJp4AlW5seo9g5C8kz1J7DJHY2NaWLDOKn20POz65egZmHGBN6DOQL0rRIJ
         M8GbrCmc04brXI0uIifF+MfAjwIoa50dTYw3C0T4wOk63Smh8Jk7aO5n7nCzAavxbjJ7zBVS7XdWJ7
         xWSN7+fNXCbUMLJOToRX1pLU/4ypvt4ODqSJkJmZ8bVGEnTY7odUi1X0uj43lAr+TrJnY9eR3SK2Qa
         X+Bqna8PMmUYdGD+WGqYJGym+uT+UJg==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon.esss.lu.se (Halon) with ESMTPS
        id 9d355255-3a71-11eb-93c8-005056a66d10;
        Wed, 09 Dec 2020 23:55:20 +0100 (CET)
Received: from [192.168.0.9] (194.47.241.248) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 9 Dec 2020
 23:55:20 +0100
Subject: Re: Recovering from AER: Uncorrected (Fatal) error
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20201209213227.GA2544987@bjorn-Precision-5520>
From:   Hinko Kocevar <hinko.kocevar@ess.eu>
Message-ID: <6234c1c4-a8cc-1bd6-8366-f359b9b5ef54@ess.eu>
Date:   Wed, 9 Dec 2020 23:55:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209213227.GA2544987@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.47.241.248]
X-ClientProxiedBy: it-exch16-3.esss.lu.se (10.0.42.133) To
 it-exch16-4.esss.lu.se (10.0.42.134)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/9/20 10:32 PM, Bjorn Helgaas wrote:
> On Wed, Dec 09, 2020 at 09:50:17PM +0100, Hinko Kocevar wrote:
>> On 12/9/20 6:40 PM, Bjorn Helgaas wrote:
> 
>>> Hmm.  Yeah, I don't see anything in the path that would restore the
>>> 01:00.0 config space, which seems like a problem.  Probably its
>>> secondary/subordinate bus registers and window registers get reset to
>>> 0 ("lspci -vv" would show that) so config/mem/io space below it is
>>> accessible.
>>
>> I guess the save/restore of the switch registers would be in the core PCI(e)
>> code; and not a switch vendor/part specific.
>>
>> I still have interest in getting this to work. With my limited knowledge of
>> the PCI code base, is there anything I could do to help? Is there a
>> particular code base area where you expect this should be managed; pci.c or
>> pcie/aer.c or maybe hotplug/ source? I can try and tinker with it..
>>
>>
>> Here is the 'lspci -vv' of the 01:00.0 device at the time after the reset:
>>
>> 01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca) (prog-if 00
>> [Normal decode])
>>          Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>          Interrupt: pin A routed to IRQ 128
>>          Region 0: Memory at df200000 (32-bit, non-prefetchable) [virtual]
>> [size=256K]
>>          Bus: primary=00, secondary=00, subordinate=00, sec-latency=0
>>          I/O behind bridge: 0000f000-00000fff [disabled]
>>          Memory behind bridge: fff00000-000fffff [disabled]
>>          Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>> [disabled]
> 
> Yep, this explains why nothing below the bridge is accessible.
> Secondary/subordinate=0 means no config transactions will be
> forwarded, and the windows are all disabled, so no MMIO transactions
> will be forwarded either.
> 
>> Looks like many fields have been zeroed out. Should a bare
>> restoration of the previous registers values be enough or does some
>> other magic (i.e.  calling PCI functions/performing initialization
>> tasks/etc) needs to happen to get that port back to sanity?
> 
> Good question.  Documentation/PCI/pci-error-recovery.rst has some
> details about the design, including this:
> 
>    It is important for the platform to restore the PCI config space to
>    the "fresh poweron" state, rather than the "last state". After a
>    slot reset, the device driver will almost always use its standard
>    device initialization routines, and an unusual config space setup
>    may result in hung devices, kernel panics, or silent data
>    corruption.
> 
> I'm not sure exactly how to interpret that.  It seems like "restoring
> to 'fresh poweron' state" is basically just doing a reset, which gives
> results like your 01:00.0 device above.  IIUC, we call a driver's
> .slot_reset() callback after a reset, and it's supposed to be able to
> initialize the device from power-on state.
> 
> 01:00.0 is a Switch Upstream Port, so portdrv should claim it, and it
> looks like pcie_portdrv_slot_reset() should be restoring some state.
> But maybe dev->state_saved is false so pci_restore_state() bails out?
> Maybe add some printks in that path to see where it's broken?
> 

Adding a bunch of printk()'s to portdrv_pci.c led to (partial) success!

So, the pcie_portdrv_error_detected() returns PCI_ERS_RESULT_CAN_RECOVER 
and therefore the pcie_portdrv_slot_reset() is not called.

But the pcie_portdrv_err_resume() is called! Adding these two lines to 
pcie_portdrv_err_resume(), before the call to device_for_each_child():

         pci_restore_state(dev);
         pci_save_state(dev);

gets the secondary buses and the endpoint restored to the following state:

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen 
Core Processor PCIe Controller (x16) (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca) (prog-if 
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
02:01.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca) (prog-if 
00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
03:00.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI 
Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ca) (prog-if 00 
[Normal decode])
	Physical Slot: 1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
04:11.0 PCI bridge: PLX Technology, Inc. PEX 8748 48-Lane, 12-Port PCI 
Express Gen 3 (8 GT/s) Switch, 27 x 27mm FCBGA (rev ca) (prog-if 00 
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
0e:00.0 Signal processing controller: Xilinx Corporation Device 7011
	Subsystem: Device 1a3e:132c
	Physical Slot: 2
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-


Very nice.

I have not verified if the buses are actually functional, yet, as I 
still see the endpoint not happy; I think its driver is just not doing 
any restoration currently. Knowing what it takes for switch ports to 
recover makes me think I can apply similar save/restore logic to my 
endpoint driver(s), too.


Cheers,
//hinko

> Bjorn
> 
