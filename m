Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949FA501C98
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 22:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241908AbiDNUZK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 16:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241246AbiDNUZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 16:25:10 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96C46CD661;
        Thu, 14 Apr 2022 13:22:44 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D86C192009C; Thu, 14 Apr 2022 22:22:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id D2CF492009B;
        Thu, 14 Apr 2022 21:22:42 +0100 (BST)
Date:   Thu, 14 Apr 2022 21:22:42 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid handing out address 0 to devices
In-Reply-To: <20220414170743.GA753251@bhelgaas>
Message-ID: <alpine.DEB.2.21.2204142111010.9383@angie.orcam.me.uk>
References: <20220414170743.GA753251@bhelgaas>
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

On Thu, 14 Apr 2022, Bjorn Helgaas wrote:

> > > > Address 0 is treated specially however in many places, for example in 
> > > > `pci_iomap_range' and `pci_iomap_wc_range' we require that the start 
> > > > address is non-zero, and even if we let such an address through, then 
> > > > individual device drivers could reject a request to handle a device at 
> > > > such an address, such as in `uart_configure_port'.  Consequently given
> > > > devices configured as shown above only one is actually usable:
> > > 
> > > pci_iomap_range() tests the resource start, i.e., the CPU address.  I
> > > guess the implication is that on RISC-V, the CPU-side port address is
> > > the same as the PCI bus port address?
> > 
> >  Umm, for all systems I came across except x86, which have native port I/O 
> > access machine instructions, a port I/O resource records PCI bus addresses 
> > of the device rather than its CPU addresses, which encode the location of 
> > an MMIO window the PCI port I/O space is accessed through.
> 
> My point is only that it is not necessary for the PCI bus address and
> the struct resource address, i.e., the argument to inb(), to be the
> same.

 Sure, but I have yet to see a system where it is the case.

 Also in principle peer PCI buses could have their own port I/O address 
spaces each mapped via distinct MMIO windows in the CPU address space, but 
I haven't heard of such a system.  That of course doesn't mean there's no 
such system in existence.

> I tried to find the RISC-V definition of inb(), but it's obfuscated
> too much to be easily discoverable.

 AFAICT the RISC-V port uses definitions from include/asm-generic/io.h.  
Palmer, did I get this right?

  Maciej
