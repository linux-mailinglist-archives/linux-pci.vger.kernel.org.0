Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9630A3BA637
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 01:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhGBXMW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 19:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBXMW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 19:12:22 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87E0DC061762;
        Fri,  2 Jul 2021 16:09:49 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D35AA92009C; Sat,  3 Jul 2021 01:09:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C43C092009B;
        Sat,  3 Jul 2021 01:09:45 +0200 (CEST)
Date:   Sat, 3 Jul 2021 01:09:45 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] x86/PCI: SiS PIRQ router updates
In-Reply-To: <60DF4C75.7020609@gmail.com>
Message-ID: <alpine.DEB.2.21.2107030031550.33206@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106240047560.37803@angie.orcam.me.uk> <60DF4C75.7020609@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Nikolai,

> >   Nikolai, can you please give it a hit with the extra debug patch as
> > requested in my other message?
> 
> With
> linux-x86-pirq-router-sis85c503.diff applied
> linux-x86-pirq-router-sis85c497.diff applied
> and DEBUG 1 in arch/x86/include/asm/pci_x86.h
> here is new log:
> 
> https://pastebin.com/n3udQgcq
> 
> My feeling is that something went a bit wrong because:
> 
> 8139too 0000:00:0d.0: can't route interrupt

 More important is actually the previous line:

PCI: Attempting to find IRQ router for [0000:0000]

meaning that the PIRQ structure defined by the BIOS has not specified the 
vendor:device ID pair for the router [1039:0496] which we match against.

 I don't know where exactly the definition our `struct irq_routing_table' 
corresponds to comes from (I'll appreciate pointers!); it has not been 
given in the PCI BIOS 2.1 specification, only individual IRQ routing 
entries have.  It may well be that [0000:0000] is a legitimate blanket 
entry requesting the OS to figure out itself which device is the hardware 
router.

 Anyway it is something we can handle in a reasonably staightforward 
manner, so I'll spend some time to implement such wildcard matching.  Most 
importantly your system does have the router structure, so barring this 
minor snag it can be handled properly without horrible hacks.  We're very 
close now.

> Note: I still used 4.14 kernel for this test but your patches applied cleanly
> with no fuzz so I suppose it should be ok.

 Indeed, that does not matter.  This code is very old, dating back to 
1990s.

  Maciej
