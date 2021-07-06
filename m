Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518ED3BD4F6
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 14:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhGFMSZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 08:18:25 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60388 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbhGFLiT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jul 2021 07:38:19 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0B6BD920110; Tue,  6 Jul 2021 13:35:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 08FB69200CE;
        Tue,  6 Jul 2021 13:35:40 +0200 (CEST)
Date:   Tue, 6 Jul 2021 13:35:39 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Handle PIRQ routing tables with no router device
 given
In-Reply-To: <60E43052.8040802@gmail.com>
Message-ID: <alpine.DEB.2.21.2107061330490.1711@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2107051133010.33206@angie.orcam.me.uk> <60E43052.8040802@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Nikolai,

> > PIRQ routing tables provided by the PCI BIOS usually specify the PCI
> > vendor:device ID as well as the bus address of the device implementing
> > the PIRQ router, e.g.:
> [...]
> > linux-x86-pirq-router-nodev.diff
> 
> This one throws a panic in bus_find_device() here.
> I can not yet get a good printout because scrollback does not work.
> Maybe it is because of 4.14 kernel, and in order to apply it I had to change
> pci_get_domain_bus_and_slot back to pci_get_bus_and_slot.
> I'll try to also test with 5.x kernel later today.

 Umm, my bad; I missed the initialisation of `dev' for `for_each_pci_dev'.  
I have posted v2, with another `dev'-related fix as well.  Please try that 
instead, and sorry for the mess-up.

  Maciej
