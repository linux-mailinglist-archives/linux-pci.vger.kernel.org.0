Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2B048986B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 13:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245276AbiAJMRr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 07:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiAJMRr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jan 2022 07:17:47 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDC7C06173F
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 04:17:47 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4JXXs51lVwzQjgn;
        Mon, 10 Jan 2022 13:17:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <590a3be9-6ef6-b93e-165d-d8269497eceb@denx.de>
Date:   Mon, 10 Jan 2022 13:17:40 +0100
MIME-Version: 1.0
Subject: Re: PCIe AER generates no interrupts on host (ZynqMP)
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>
References: <20220107203415.GA398389@bhelgaas>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220107203415.GA398389@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/7/22 21:34, Bjorn Helgaas wrote:
> On Fri, Jan 07, 2022 at 11:04:58AM +0100, Pali Rohár wrote:
>> Hello! You asked me in another email for comments to this email, so I'm
>> replying directly to this email...
>>
>> On Tuesday 04 January 2022 10:02:18 Stefan Roese wrote:
>>> Hi,
>>>
>>> I'm trying to get the Kernel PCIe AER infrastructure to work on my
>>> ZynqMP based system. E.g. handle the events (correctable, uncorrectable
>>> etc). In my current tests, no AER interrupt is generated though. I'm
>>> currently using the "surprise down error status" in the uncorrectable
>>> error status register of the connected PCIe switch (PLX / Broadcom
>>> PEX8718). Here the bit is correctly logged in the PEX switch
>>> uncorrectable error status register but no interrupt is generated
>>> to the root-port / system. And hence no AER message(s) reported.
> 
> I think the error should also be logged in the Root Port AER
> Capability.  And of course the interrupt enable bits in the Root Error
> Command register would have to be set.

I'm seeing no change at all in the Root Port PCIe device after the
surprise down on one of the PCIe switch downstream ports via
"lspci -vvv".

>>> Does any one of you have some ideas on what might be missing? Why are
>>> these events not reported to the PCIe rootport driver via IRQ? Might
>>> this be a problem of the missing MSI-X support of the ZynqMP? The AER
>>> interrupt is connected as legacy IRQ:
>>>
>>> cat /proc/interrupts | grep -i aer
>>>   58:          0          0          0          0  nwl_pcie:legacy   0 Level
>>> PCIe PME, aerdrv
> 
> I guess this means whatever INTx the Root Port is using is connected
> to IRQ 58?  Can you tell whether that INTx works if a device below the
> Root Port uses it?  Or whether it is asserted for PMEs?

INTx works just fine for "normal" legacy interrupts, e.g. a PCIe
driver requesting a non-MSI interrupt.

>> Error events (correctable, non-fatal and fatal) are reported by PCIe
>> devices to the Root Complex via PCIe error messages (Message code of TLP
>> is set to Error Message) and not via interrupts. Root Port is then
>> responsible to "convert" these PCIe error messages to MSI(X) interrupt
>> and report it to the system. According to PCIe spec, AER is supported
>> only via MSI(X) interrupts, not legacy INTx.
> 
> Where does it say that?  PCIe r5.0, sec 6.2.4.1.2 and 6.2.6, both
> mention INTx, and the diagram in 6.2.6 even shows possible
> platform-specific System Error signaling.
> 
> But I doubt Linux is smart enough to configure this correctly for
> INTx.  You could experiment by setting the AER control bits with
> setpci.
> 
> There was some previous discussion, and it even mentions ZynqMP as a
> device that has a dedicated non-MSI mechanism for AER signaling:
> 
>    https://lore.kernel.org/linux-pci/1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com/
>    https://lore.kernel.org/all/1464242406-20203-1-git-send-email-po.liu@nxp.com/T/#u
> 
> But I don't think it went anywhere.
> 
> It seems like maybe this *could* be made to work.

Thanks Bjorn for the reference. As already mentioned to Pali in the
other mail, Bharat from Xilinx has sent me a link to a newer, updated
patch series to use this "misc" interrupts for AER in the meantime:

https://lore.kernel.org/lkml/1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com/

AFAICT, this patch series was not really reviewed. At least I can't find
any comments / replies.

I now applied this series (after some merge issues) to v5.16 and re-
tested with this new MISC interrupts for AER. Still no cigar. No
interrupt / AER event upon surprise down on the PEX switch received.

I might have missed something in the setup / configuration though. Is
my understanding correct, that I don't need to "manually" tune the SERR
in the Command register? And is my understanding correct that '0' / '-'
in the AER mask register enables this AER event?

Thanks,
Stefan
