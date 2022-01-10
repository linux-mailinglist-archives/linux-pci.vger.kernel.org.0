Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B75B489866
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 13:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245307AbiAJMRA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 07:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbiAJMQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jan 2022 07:16:17 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E48C061759
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 04:16:17 -0800 (PST)
Received: from smtp102.mailbox.org (unknown [91.198.250.119])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4JXXqL6QCyzQjkl;
        Mon, 10 Jan 2022 13:16:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <db802a46-b210-900e-25ad-25b31086b970@denx.de>
Date:   Mon, 10 Jan 2022 13:16:09 +0100
MIME-Version: 1.0
Subject: Re: PCIe AER generates no interrupts on host (ZynqMP)
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>
References: <4736848c-7b3b-a99d-8fd3-540ec6eb920b@denx.de>
 <20220107100458.sfqcq7gy6nwwamjt@pali>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220107100458.sfqcq7gy6nwwamjt@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/7/22 11:04, Pali Rohár wrote:
> Hello! You asked me in another email for comments to this email, so I'm
> replying directly to this email...

Thanks a lot for you input here. Please find some comments below...

> On Tuesday 04 January 2022 10:02:18 Stefan Roese wrote:
>> Hi,
>>
>> I'm trying to get the Kernel PCIe AER infrastructure to work on my
>> ZynqMP based system. E.g. handle the events (correctable, uncorrectable
>> etc). In my current tests, no AER interrupt is generated though. I'm
>> currently using the "surprise down error status" in the uncorrectable
>> error status register of the connected PCIe switch (PLX / Broadcom
>> PEX8718). Here the bit is correctly logged in the PEX switch
>> uncorrectable error status register but no interrupt is generated
>> to the root-port / system. And hence no AER message(s) reported.
>>
>> Does any one of you have some ideas on what might be missing? Why are
>> these events not reported to the PCIe rootport driver via IRQ? Might
>> this be a problem of the missing MSI-X support of the ZynqMP? The AER
>> interrupt is connected as legacy IRQ:
>>
>> cat /proc/interrupts | grep -i aer
>>   58:          0          0          0          0  nwl_pcie:legacy   0 Level
>> PCIe PME, aerdrv
> 
> Error events (correctable, non-fatal and fatal) are reported by PCIe
> devices to the Root Complex via PCIe error messages (Message code of TLP
> is set to Error Message) and not via interrupts. Root Port is then
> responsible to "convert" these PCIe error messages to MSI(X) interrupt
> and report it to the system. According to PCIe spec, AER is supported
> only via MSI(X) interrupts, not legacy INTx.

This seems not correct. From the ML link reported by Bjorn, there seems
to be a platform specific interrupt on ZynqMP, to report the AER events.
At least this is how I interpret the patch from Bharat from that time.
In the meantime Bharat from Xilinx has sent me a link to a newer,
updated patch series to use this "misc" interrupts for AER instead. I'll
get into more details on this in another reply.

> Via Bridge Control register (SERR# enable bit) on the Root Port it is
> possible to enable / disable reporting of these errors from PCIe devices
> on the other end of PCIe link to the system.

Here the BridgeCtl of the Root Port:
   BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-

> Then via Command register
> (SERR# enable bit) and Device Control register it is possible to enable
> / disable reporting of all errors (from Root Port and also devices on
> other end of the link).

The command registers have SERR disabled on all PCIe devices:
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-

Not sure if this is a problem. I would expect the Kernel PCI subsystem
and the AER driver to enable the necessary bits. So is 'SERR-' here
a problem?

Device Control has the error reporting enabled:
   DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+

> And via AER registers on the Root Port it is
> also possible to disable generating MSI(X) interrupts when error is
> reported.

Here is what the Root Port reports:
         Capabilities: [140 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
                 RootCmd: CERptEn+ NFERptEn+ FERptEn+
                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                          FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0

Mask (..Msk) is set to "-" which is correct for not masking this error
I assume.

> And IIRC via PCIe Downstream Port Containment there is also
> way how to "mask" reporting of error events. But I do not have PCIe
> devices with DPC support, so I have not played with it yet.

Me neither.

> So there are
> many places where error event can be stopped. But important is that
> kernel AER driver should correctly enable all required bits to start
> receiving MSI(X) interrupts for error events.

Agreed.

> On other devices I'm seeing following issues... Root Ports are not
> compliant to PCIe spec and do not implement error reporting at all. Or
> they do not implement those enable/disable bits correctly. Or they do
> not implement proper support for extended PCIe config space for Root
> Port (AER is in extended space). Or they report error events via custom
> proprietary interrupts and not via MSI(X) as required by PCIe spec. This
> is the case for (all?) Marvell PCIe controllers and I saw here on
> linux-pci list that it applies also for PCIe controllers from some other
> vendors. Also drivers for Marvell PCIe controllers requires additional
> code to access extended PCIe config space of Root Port (accessing config
> space of PCIe devices on the other end of PCIe link is working fine).
> 
> So the first suspicious thing is why kernel AER driver is using legacy
> shared INTx interrupt as in most cases Root Port would not report any
> error event via INTx. And the second thing, try to look into
> documentation for used PCIe controller, just in case if vendor
> "invented" some proprietary and non-compliant way how to report error /
> AER events to OS...

At least this seems to be the case. Even though I'm still not receiving
the surprise down error status with additional change. More to this in
the other mail.

> I saw more issues with PCIe controllers as with PCIe switches so in my
> opinion issue would be either in controller driver or controller hw
> itself. And if you see event status logged in PCIe switch register I
> would expect that switch correctly sent PCIe Error message to Root
> Complex.

That is my understanding and best guess right now as well.

Thanks,
Stefan
