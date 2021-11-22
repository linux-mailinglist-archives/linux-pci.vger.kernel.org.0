Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B77458764
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 01:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhKVAXv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Nov 2021 19:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhKVAXv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Nov 2021 19:23:51 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5181C061574;
        Sun, 21 Nov 2021 16:20:45 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B6E6E92009C; Mon, 22 Nov 2021 01:20:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B0AA792009B;
        Mon, 22 Nov 2021 00:20:42 +0000 (GMT)
Date:   Mon, 22 Nov 2021 00:20:42 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Work around ASMedia ASM2824 PCIe link training
 failures
In-Reply-To: <alpine.DEB.2.21.2111201924390.10804@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2111212320300.10804@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2111201924390.10804@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 20 Nov 2021, Maciej W. Rozycki wrote:

>  One case that has been nurturing me though is the reverse scenario, that 
> is where the Pericom PI7C9X2G304 switch is upstream while the ASMedia 
> ASM2824 switch is downstream.  Presumably the same situation will happen, 
> so matching on the ASM2824 ID only would be a problem.  Unfortunately the 
> other device does not implement the Data Link Layer Link Active status 
> bit, so a more complex approach, such as clearing and then checking for 
> the Link Bandwidth Management Status having been set again might be an 
> option.  Unlike U-Boot we cannot do aggressive polling of the Link 
> Training bit.
> 
>  Option hardware with M.2 slots is commercially available with the ASM2824 
> onboard, so a test environment can be in principle arranged, though I'm 
> not sure if just for the sake of such an experiment I'm willing to spend 
> money that will ultimately go to a manufacturer that cannot be bothered to 
> take responsibility for their faults and at the very least respond to a 
> problem report.  And without verifying the actual problem exists I'm 
> reluctant to try and implement a workaround.  On the other hand the 
> problem with the Unmatched board is real and this change addresses it, at 
> least for me.

 NB I have realised the reverse scenario cannot actually be reproduced 
with the Delock device as the downstream ports of the PI7C9X2G304 chip 
appear to have been strapped for 2.5GT/s operation.  Or so it seems, as 
the Pericom datasheet seems unclear about such an option; all it says is:

"
7.2.67 LINK CAPABILITIES REGISTER -- OFFSET CCh

   BIT  FUNCTION     TYPE DESCRIPTION

                          Indicates the maximum speed of the Express link.
   3:0  Maximum Link  RO  0001b: 2.5 Gb/s
        Speed             0010b: 5.0 Gb/s
                          Reset to 0010b.

                          Indicates the maximum width of the given PCIe Link.
   9:4  Maximum Link  RO  Reset to 000010b (x2) for Port 0.
                          Reset to 000001b (x1) for Port 1.
                          Reset to 000001b (x1) for Port 2.
"

and then:

"
7.2.77 LINK CONTROL REGISTER 2 -- OFFSET F0h

   BIT  FUNCTION          TYPE DESCRIPTION

   3:0  Target Link Speed RWS  Reset to 0010b.
"

so it does tell the upstream port (port 0) and the downstream ports (port 
1 & 2) apart where appropriate (link width), but says nothing about any 
ports capable of being strapped for 2.5GT/s operation.  However the actual 
device reports:

06:01.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch [12d8:2304] (rev 05) (prog-if 00 [Normal decode])
[...]
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
[...]
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM not supported
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
[...]
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
[...]
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
[...]

-- note the discrepancy between the Maximum Link Speed and the Target Link 
Speed, possibly a device erratum.  Also there's no usable Supported Speeds 
Vector to confirm either way:

"
7.2.76 LINK CAPABILITIES REGISTER 2 -- OFFSET ECh

   BIT  FUNCTION            TYPE DESCRIPTION

  31:0  Link Capabilities 2  RO  Reset to 0000_0000h.
"

It could be possible to verify the reverse scenario perhaps with another 
manufactured device featuring the PI7C9X2G304 chip though, as they seem 
somewhat common.

 Also I got distracted mid-way through my submission and then forgot to 
mention that I was unable to verify the resume part of this workaround as 
the Unmatched hardware does not provide such a capability (it's out of 
scope for this kind of a development/evaluation board).

 And I have only minimally checked hot-plug operation as I dared not live 
unplug and replug hardware which may not be prepared for that (I did that 
once with an ISA board, not exactly on purpose as I didn't realise power 
was still applied, and all the pieces survived, but the system had to be 
power-cycled).  Removing and rescanning buses behind the ASM2824 switch 
did work (and triggered rather a surprising oops/panic with the nicstar 
driver handling an ATM board downstream, which I then had to remove from 
my configuration for the purpose of this verification), but did not cause 
the offending link to go down, so the workaround didn't (have to) trigger.

 Last but not least I have chosen the timeout for retraining somewhat 
heuristically, so I'll appreciate advice from someone more experienced 
with PCIe than I am -- most of my involvement in this area so far has been 
with conventional PCI.

  Maciej
