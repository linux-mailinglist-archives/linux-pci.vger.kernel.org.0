Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1564430C7
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 15:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhKBOwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 10:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232941AbhKBOwH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Nov 2021 10:52:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E13560C4B;
        Tue,  2 Nov 2021 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635864572;
        bh=0gzjGPbTbWWRcc0SsPOGB293mdUumRiH7yGEhUiWRNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hk+bqY54hAjCxl2dbLTXy/Cbu90+I2wTQ3Oj8AiemS2N5+G12QV0doOkIBdEG43/S
         lJUAjKvHlYpCIy/vw7RmbhI5HavAVY2mSrsfbaTYSxE1eaKXjz8q6GZueNOYFwSjrt
         7lmCXMiIio8rZnBfo23AIvTSGcQCwMTMGI6aBD4I3xCTJXHDegBOnqw4q6slPn69Yl
         4PKr+d81SgLPQrRP8iH9J0EkZGlu+BEyoQ1xDIncDr5MGDr7YUUrKhNnTQKXQdtepi
         DZRKEXyZVk8IhFBt88gDk10xnnOWCI2pAhf0YRiYUP+Y9uPJmp1kZ4zH/jO3pQEZTq
         JFig1OF3SfC+w==
Received: by pali.im (Postfix)
        id 25765A41; Tue,  2 Nov 2021 15:49:30 +0100 (CET)
Date:   Tue, 2 Nov 2021 15:49:29 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Marvell: Update PCIe fixup
Message-ID: <20211102144929.c5wt5pbl42ocrxly@pali>
References: <20211101150405.14618-1-pali@kernel.org>
 <20211102084241.GA6134@alpha.franken.de>
 <20211102090246.unmbruykfdjabfga@pali>
 <20211102094700.GA7376@alpha.franken.de>
 <20211102100034.rhcb3k2jvr6alm6y@pali>
 <alpine.DEB.2.21.2111021210180.57165@angie.orcam.me.uk>
 <20211102125843.sqsusis4krnmhorq@pali>
 <alpine.DEB.2.21.2111021312160.57165@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2111021312160.57165@angie.orcam.me.uk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 02 November 2021 14:01:41 Maciej W. Rozycki wrote:
> On Tue, 2 Nov 2021, Pali Rohár wrote:
> 
> > >  None of the Galileo system controllers I came across had the class code 
> > > set incorrectly.
> > 
> > In kernel there is quirk only for one device with id:
> > PCI_VENDOR_ID_MARVELL (0x11ab) PCI_DEVICE_ID_MARVELL_GT64111 (0x4146)
> > 
> > So for some reasons quirk is needed... Anyway, patch for this quirk just
> > adds comment as there is no explanation for it. It does not modify quirk
> > code.
> > 
> > So it is possible that Marvell (or rather Galileo at that time) included
> > some config space fixup in some products and 0x4146 did not have it.
> > Just guessing... We can really only guess what could happen at that time
> > 20 years ago...
> 
>  Ah, there you go! -- sadly I don't seem to have a copy of the datasheet 
> for the GT-64111, but the GT-64115 has it[1]:
> 
> Table 158: PCI Class Code and Revision ID, Offset: 0x008
>  Bits  Field name Function                                     Initial Value
>  7:0   RevID      Indicates the GT-64115 PCI Revision          0x01
>                   number.
>  15:8  Reserved   Read only.                                   0x0
>  23:16 SubClass   Indicates the GT-64115 Subclass - Mem-       0x80
>                   ory controller.
>  31:24 BaseClass  Indicates the GT-64115 Base Class -          0x05
>                   memory controller.
> 
> and then:
> 
> "Device and Vendor ID (0x000), Class Code and Revision ID (0x008), and 
> Header Type (0x00e) fields are read only from the PCI bus.  These fields 
> can be modified and read via the CPU bus."
> 
> Likewise with the GT-64120[2]:
> 
> Table 208: PCI_0 Class Code and Revision ID, Offset: 0x008 from PCI_0 or CPU; 0x088 from
>            PCI_1
>  Bits  Field name Function                                      Initial Value
>  7:0   RevID      Indicates the GT-64120 PCI_0 revision number. 0x02
>  15:8  Reserved   Read Only 0.                                  0x0
>  23:16 SubClass   Indicates the GT-64120 Subclass               Depends on value
>                   0x00 - Host Bridge Device.                    sampled at reset
>                   0x80 - Memory Device.                         on BankSel[0]. See
>                                                                 Table 44 on page
>                                                                 11-1.
>  31:24 BaseClass  Indicates the GT-64120 Base Class             Depends on value
>                   0x06 - Bridge Device.                         sampled at reset
>                   0x05 - Memory Device.                         on BankSel[0]. See
>                                                                 Table 44 on page
>                                                                 11-1.
> 
> Table 209: PCI_1 Class Code and Revision ID, Offset: 0x088 from PCI_0 or CPU; 0x008 from
>            PCI_1
>  Bits  Field name Function                                      Initial Value
>  31:0  Various    Same as for PCI_0 Class Code and Revision ID.
> 
> and then also:
> 
> "Device and Vendor ID (0x000), Class Code and Revision ID (0x008), and 
> Header Type (0x00e) fields are read only from the PCI bus.  These fields 
> can be modified and read via the CPU bus."
> 
> -- so this is system-specific and an intended chip feature rather than an 
> erratum (or rather it is a system erratum if the reset strap or the boot 
> firmware has got it wrong).
> 
>  The memory device class code is IIUC meant to be typically chosen when 
> the Galileo/Marvell device is used without the CPU interface, i.e. as a 
> PCI memory controller device only[3].
> 
> > > The lack of a quirk with a platform does not mean it cannot have a certain 
> > > PCI/e device.
> > 
> > This is 11ab:4620 device an there is no PCIe capability in its config
> > space (you can inspect it via 'lspci -F dump.txt -nn -vv' but there is
> > nothing interesting).
> 
>  Of course, just as Thomas told you about the GT-64111 too.  But you were 
> right in that the memory controller feature seems shared across all the 
> chip line, whether PCI or PCIe.
> 
> References:
> 
> [1] "GT-64115 System Controller for RC4640, RM523X, and VR4300 CPUs", 
>     Galileo Technology, Datasheet Revision 1.11, APR 04, 2000, Section 
>     18.16 "PCI Configuration", p. 161
> 
> [2] "GT-64120 System Controller For RC4650/4700/5000 and RM526X/527X/7000 
>     CPUs", Galileo Technology, Datasheet Revision 1.4, SEP 14, 1999, 
>     Section 17.16 "PCI Configuration", p. 17-59
> 
> [3] same, Chapter 14. "Using the GT-64120 Without the CPU Interface", p. 
>     14-1
> 
>   Maciej

Hello Maciej! Thank you very much for the explanation!

Now it makes sense and looks like that for GT-64111 it is "system
erratum" that strapping pins are incorrectly set which leads to wrong
PCI class code.

I will update comment for GT-64111 quirk in v2.

I'm surprised that Marvell copied this 20 years old MIPS Galileo PCI
logic into followup ARM SoC PCIe IPs (and later also into recent ARM64
A3720 SoC PCIe IP), removed configuration of PCI class code via
strapping pins and let default PCI class code value to Memory device,
even also when PCIe controller is running in Root Complex mode. And so
correction can be done only from "CPU bus".

Just Marvell forgot to include chapter about usage without CPU interface
in new ARM and ARM64 SoCs and origin/usage of that Memory Controller
Device was lost in history, even Marvell people was not able to figure
out what was wrong with PCIe IP in their ARM SoCs...
https://lore.kernel.org/linux-pci/20211003120944.3lmwxylnhlp2kfj7@pali/

Maciej, if I had known that you have this kind of information I would
have written you year ago :-)
