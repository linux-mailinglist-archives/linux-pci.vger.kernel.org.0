Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E559D442FB4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 15:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhKBOES (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 10:04:18 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:36590 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhKBOES (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Nov 2021 10:04:18 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B92D992009D; Tue,  2 Nov 2021 15:01:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B1C7B92009B;
        Tue,  2 Nov 2021 14:01:41 +0000 (GMT)
Date:   Tue, 2 Nov 2021 14:01:41 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
In-Reply-To: <20211102125843.sqsusis4krnmhorq@pali>
Message-ID: <alpine.DEB.2.21.2111021312160.57165@angie.orcam.me.uk>
References: <20211101150405.14618-1-pali@kernel.org> <20211102084241.GA6134@alpha.franken.de> <20211102090246.unmbruykfdjabfga@pali> <20211102094700.GA7376@alpha.franken.de> <20211102100034.rhcb3k2jvr6alm6y@pali> <alpine.DEB.2.21.2111021210180.57165@angie.orcam.me.uk>
 <20211102125843.sqsusis4krnmhorq@pali>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2 Nov 2021, Pali Rohár wrote:

> >  None of the Galileo system controllers I came across had the class code 
> > set incorrectly.
> 
> In kernel there is quirk only for one device with id:
> PCI_VENDOR_ID_MARVELL (0x11ab) PCI_DEVICE_ID_MARVELL_GT64111 (0x4146)
> 
> So for some reasons quirk is needed... Anyway, patch for this quirk just
> adds comment as there is no explanation for it. It does not modify quirk
> code.
> 
> So it is possible that Marvell (or rather Galileo at that time) included
> some config space fixup in some products and 0x4146 did not have it.
> Just guessing... We can really only guess what could happen at that time
> 20 years ago...

 Ah, there you go! -- sadly I don't seem to have a copy of the datasheet 
for the GT-64111, but the GT-64115 has it[1]:

Table 158: PCI Class Code and Revision ID, Offset: 0x008
 Bits  Field name Function                                     Initial Value
 7:0   RevID      Indicates the GT-64115 PCI Revision          0x01
                  number.
 15:8  Reserved   Read only.                                   0x0
 23:16 SubClass   Indicates the GT-64115 Subclass - Mem-       0x80
                  ory controller.
 31:24 BaseClass  Indicates the GT-64115 Base Class -          0x05
                  memory controller.

and then:

"Device and Vendor ID (0x000), Class Code and Revision ID (0x008), and 
Header Type (0x00e) fields are read only from the PCI bus.  These fields 
can be modified and read via the CPU bus."

Likewise with the GT-64120[2]:

Table 208: PCI_0 Class Code and Revision ID, Offset: 0x008 from PCI_0 or CPU; 0x088 from
           PCI_1
 Bits  Field name Function                                      Initial Value
 7:0   RevID      Indicates the GT-64120 PCI_0 revision number. 0x02
 15:8  Reserved   Read Only 0.                                  0x0
 23:16 SubClass   Indicates the GT-64120 Subclass               Depends on value
                  0x00 - Host Bridge Device.                    sampled at reset
                  0x80 - Memory Device.                         on BankSel[0]. See
                                                                Table 44 on page
                                                                11-1.
 31:24 BaseClass  Indicates the GT-64120 Base Class             Depends on value
                  0x06 - Bridge Device.                         sampled at reset
                  0x05 - Memory Device.                         on BankSel[0]. See
                                                                Table 44 on page
                                                                11-1.

Table 209: PCI_1 Class Code and Revision ID, Offset: 0x088 from PCI_0 or CPU; 0x008 from
           PCI_1
 Bits  Field name Function                                      Initial Value
 31:0  Various    Same as for PCI_0 Class Code and Revision ID.

and then also:

"Device and Vendor ID (0x000), Class Code and Revision ID (0x008), and 
Header Type (0x00e) fields are read only from the PCI bus.  These fields 
can be modified and read via the CPU bus."

-- so this is system-specific and an intended chip feature rather than an 
erratum (or rather it is a system erratum if the reset strap or the boot 
firmware has got it wrong).

 The memory device class code is IIUC meant to be typically chosen when 
the Galileo/Marvell device is used without the CPU interface, i.e. as a 
PCI memory controller device only[3].

> > The lack of a quirk with a platform does not mean it cannot have a certain 
> > PCI/e device.
> 
> This is 11ab:4620 device an there is no PCIe capability in its config
> space (you can inspect it via 'lspci -F dump.txt -nn -vv' but there is
> nothing interesting).

 Of course, just as Thomas told you about the GT-64111 too.  But you were 
right in that the memory controller feature seems shared across all the 
chip line, whether PCI or PCIe.

References:

[1] "GT-64115 System Controller for RC4640, RM523X, and VR4300 CPUs", 
    Galileo Technology, Datasheet Revision 1.11, APR 04, 2000, Section 
    18.16 "PCI Configuration", p. 161

[2] "GT-64120 System Controller For RC4650/4700/5000 and RM526X/527X/7000 
    CPUs", Galileo Technology, Datasheet Revision 1.4, SEP 14, 1999, 
    Section 17.16 "PCI Configuration", p. 17-59

[3] same, Chapter 14. "Using the GT-64120 Without the CPU Interface", p. 
    14-1

  Maciej
