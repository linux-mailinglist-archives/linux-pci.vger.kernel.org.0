Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CA23C1AAE
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 22:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhGHUsT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 16:48:19 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60510 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhGHUsT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jul 2021 16:48:19 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E867992009C; Thu,  8 Jul 2021 22:45:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id D9ED792009B;
        Thu,  8 Jul 2021 22:45:34 +0200 (CEST)
Date:   Thu, 8 Jul 2021 22:45:34 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/PCI: Handle PIRQ routing tables with no router
 device given
In-Reply-To: <60E726E2.2050104@gmail.com>
Message-ID: <alpine.DEB.2.21.2107082226040.6599@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2107061320570.1711@angie.orcam.me.uk> <60E726E2.2050104@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nikolai,

> > Changes from v1:
> > 
> > - preinitialise `dev' in `pirq_find_router' for `for_each_pci_dev',
> > 
> > - avoid calling `pirq_try_router' with null `dev'.
> > ---
> >   arch/x86/pci/irq.c |   64
> > ++++++++++++++++++++++++++++++++++++-----------------
> >   1 file changed, 44 insertions(+), 20 deletions(-)
> > 
> > linux-x86-pirq-router-nodev.diff
> 
> Success!
> Here is new log:
> 
> https://pastebin.com/QXaUsCV4

 This is great news, thank you for doing this verification!

 I have since discovered and posted a fix for an issue with our PIRQ
routing code that turned out incapable of routing interrupts behind 
PCI-to-PCI bridges, which were sometimes used even on classic PCI option 
cards (I think I have at least two such devices) either to bundle multiple 
devices or to meet PCI bus load limits.

 Such devices may work regardless if the BIOS has been developed enough to 
handle them and assign an IRQ number, but surely they make the likelihood 
of interrupt sharing rise considerably, so I think the more of them we can 
handle ourselves the better.  Plus these days now that PCIe has come into 
picture you can get quite complex topologies with multiple logical 
PCI-to-PCI bridges via external expansion even with classic PCI systems.

 So I have also posted a PIRQ router implementation for the Intel SIO 
southbridge and I have also identified further two Intel devices, the IB 
ISA bridge and the PCEB/ESC EISA bridge combo, that have their PIRQ 
routers documented in my resources but not handled in Linux.  I'll see if 
I can find some time the following days to get them implemented too just 
for the sake of people experimenting with odd hardware.

 Have you tried contacting Nvidia about your ALI chipset?  Back in the day 
I tried to avoid undocumented stuff and Intel was reasonably open about 
most of their chipsets.

  Maciej
