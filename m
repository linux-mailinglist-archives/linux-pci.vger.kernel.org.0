Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514ED500378
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 03:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiDNBNJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 21:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiDNBNH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 21:13:07 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C74231DE0;
        Wed, 13 Apr 2022 18:10:43 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2855F92009C; Thu, 14 Apr 2022 03:10:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 213D592009B;
        Thu, 14 Apr 2022 02:10:43 +0100 (BST)
Date:   Thu, 14 Apr 2022 02:10:43 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid handing out address 0 to devices
In-Reply-To: <20220414000626.GA700213@bhelgaas>
Message-ID: <alpine.DEB.2.21.2204140118350.9383@angie.orcam.me.uk>
References: <20220414000626.GA700213@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 13 Apr 2022, Bjorn Helgaas wrote:

> > Address 0 is treated specially however in many places, for example in 
> > `pci_iomap_range' and `pci_iomap_wc_range' we require that the start 
> > address is non-zero, and even if we let such an address through, then 
> > individual device drivers could reject a request to handle a device at 
> > such an address, such as in `uart_configure_port'.  Consequently given
> > devices configured as shown above only one is actually usable:
> 
> pci_iomap_range() tests the resource start, i.e., the CPU address.  I
> guess the implication is that on RISC-V, the CPU-side port address is
> the same as the PCI bus port address?

 Umm, for all systems I came across except x86, which have native port I/O 
access machine instructions, a port I/O resource records PCI bus addresses 
of the device rather than its CPU addresses, which encode the location of 
an MMIO window the PCI port I/O space is accessed through.  E.g. my RISC-V 
SiFive Unmatched has this:

# cat /proc/ioports
00000000-0000ffff : pcie@e00000000
  00000000-00001fff : PCI Bus 0000:01
    00000000-00001fff : PCI Bus 0000:02
      00000000-00001fff : PCI Bus 0000:05
        00000000-00001fff : PCI Bus 0000:06
          00000000-00000fff : PCI Bus 0000:07
          00000004-00000007 : 0000:07:00.0
          00000004-00000006 : parport0
          00000008-0000000f : 0000:07:00.0
          00000008-0000000a : parport0
          0000000b-0000000f : parport0
          00001000-00001fff : PCI Bus 0000:08
          00001000-00001fff : PCI Bus 0000:09
          00001000-000010ff : 0000:09:02.0
          00001100-0000117f : 0000:09:01.0
# 

and my MIPS MTI Malta has this:

# cat /proc/ioports
00000000-0000001f : dma1
00000020-00000021 : pic1
00000040-0000005f : timer
00000060-0000006f : keyboard
00000070-00000077 : rtc0
00000080-0000008f : dma page reg
000000a0-000000a1 : pic2
000000c0-000000df : dma2
00000170-00000177 : ata_piix
000001f0-000001f7 : ata_piix
000002f8-000002ff : serial
00000376-00000376 : ata_piix
00000378-0000037a : parport0
0000037b-0000037f : parport0
000003f6-000003f6 : ata_piix
000003f8-000003ff : serial
00001000-001fffff : GT-64120 PCI I/O
  00001000-0000103f : 0000:00:0a.3
  00001040-0000105f : 0000:00:0a.2
  00001060-0000107f : 0000:00:0b.0
    00001060-0000107f : pcnet32_probe_pci
  00001080-000010ff : 0000:00:14.0
  00001100-0000110f : 0000:00:0a.3
  00001400-000014ff : 0000:00:13.0
  00001800-0000180f : 0000:00:0a.1
    00001800-0000180f : ata_piix
# 

(though this is not strictly correctly reported, because the legacy junk 
is also behind the GT-64120).  It is especially clear with the Malta that 
PCI port I/O addresses have nothing to do with CPU addresses given this:

# cat /proc/iomem
00000000-0fffbfff : System RAM
  00100000-0076e9bf : Kernel code
  0076e9c0-0097665f : Kernel data
  00ab0000-00ae6ccf : Kernel bss
10000000-17ffffff : GT-64120 PCI MEM
  10000000-100fffff : 0000:00:0b.0
  10100000-101fffff : PCI Bus 0000:01
    10100000-10101fff : 0000:01:00.0
      10100000-10101fff : xhci-hcd
  10200000-1021ffff : 0000:00:13.0
  10220000-1022ffff : 0000:00:0c.0
  10230000-1023ffff : 0000:00:14.0
  10240000-10240fff : 0000:00:0c.0
  10241000-10241fff : 0000:00:13.0
  10242000-1024207f : 0000:00:14.0
    10242000-1024207f : defxx
  10242080-1024209f : 0000:00:0b.0
1e000000-1e3fffff : 1e000000.flash flash@1e000000
1f000900-1f00093f : serial
# 

where we have system RAM from CPU address 0 onwards (of course the Malta 
has legacy PC/ISA junk in the southbridge, so it only allocates native PCI 
port I/O resources from 0x1000 up and therefore it avoids the problem with 
port I/O address 0).

 Maybe there are systems that don't do that and use CPU addresses for port 
I/O resources, but I haven't come across one.

> Is that actually a requirement?  Maybe you could also avoid this by
> remapping the ports in CPU address space?

 Sadly it's not recorded in /proc/iomem, but from my understanding of the 
Unmatched DTS the CPU address of PCI I/O port 0 is 0x60080000, and for the 
Malta likewise it's 0x18000000, so the remapping is already there.

> Is the same true for PCI memory addresses?  They are identical to CPU
> addresses, i.e., no translation is applied?

 For MMIO I guess this isn't a problem for the systems I know of, but it 
would be if the PCI MMIO access window was decoded at 0 somewhere.  For 
the Unmatched and the Malta the windows are at 0x60090000 and 0x10000000 
respectively.

> On the PCI side, zero is a perfectly valid address, so it's a shame to
> throw it away if we don't have to, especially since throwing away even
> 16 bytes of MMIO space means a 4GB 32-bit BAR cannot be mapped at all.

 A problem with considering an address special, be it 0 or another value, 
is that such a designated location is thrown away.  Buses usually do not 
treat any addresses specially, it's merely a software convention.

  Maciej
