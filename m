Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470233BBB9A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 12:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhGEK5b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 06:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhGEK5b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 06:57:31 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C33C5C061574;
        Mon,  5 Jul 2021 03:54:54 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BE50C92009D; Mon,  5 Jul 2021 12:54:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B823892009B;
        Mon,  5 Jul 2021 12:54:51 +0200 (CEST)
Date:   Mon, 5 Jul 2021 12:54:51 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] x86/PCI: SiS PIRQ router updates
In-Reply-To: <alpine.DEB.2.21.2107030031550.33206@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2107051246330.33206@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106240047560.37803@angie.orcam.me.uk> <60DF4C75.7020609@gmail.com> <alpine.DEB.2.21.2107030031550.33206@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 3 Jul 2021, Maciej W. Rozycki wrote:

> > >   Nikolai, can you please give it a hit with the extra debug patch as
> > > requested in my other message?
> > 
> > With
> > linux-x86-pirq-router-sis85c503.diff applied
> > linux-x86-pirq-router-sis85c497.diff applied
> > and DEBUG 1 in arch/x86/include/asm/pci_x86.h
> > here is new log:
> > 
> > https://pastebin.com/n3udQgcq
> > 
> > My feeling is that something went a bit wrong because:
> > 
> > 8139too 0000:00:0d.0: can't route interrupt
> 
>  More important is actually the previous line:
> 
> PCI: Attempting to find IRQ router for [0000:0000]
> 
> meaning that the PIRQ structure defined by the BIOS has not specified the 
> vendor:device ID pair for the router [1039:0496] which we match against.

 So it's actually both the vendor:device ID pair and the bus address that 
matter here.  I've now posted a patch I am fairly sure about that combined 
with the earlier changes it will fix your issue.  I have verified it in a 
simulated environment where the PIRQ routing table has an invalid vendor 
ID given, with correct results produced:

PCI: Attempting to find IRQ router for [0000:0000]
PCI: Trying IRQ router for [8086:1250]
PCI: Trying IRQ router for [8086:7000]
pci 0000:00:07.0: SIO/PIIX/ICH IRQ router [8086:7000]

 Please let me know of the outcome.

  Maciej
