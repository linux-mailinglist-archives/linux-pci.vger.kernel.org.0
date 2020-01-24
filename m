Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54FA7148F6A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 21:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392498AbgAXUf2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jan 2020 15:35:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:55326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387548AbgAXUf1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jan 2020 15:35:27 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D86F2072C;
        Fri, 24 Jan 2020 20:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579898126;
        bh=qL67LPbRm0gwuNb+oeddj46XlTu8jpHDWEiYvLb9kzc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0WF6W5LvnFymdP9cYB99vwaSYsflgBXnpJDjm4GKegXXfK+hE7dJ/VaF4SQ0C0157
         z1h7ADGYANEF8cuuJkTfSmIt2Z+QqPJC6jl0TPD8wua3bcfkiYeAl0tnXYlThQB4Pg
         s+yDcxK1kvKq2BCic0xrb9P8ofikTz8JXqSrwKjA=
Date:   Fri, 24 Jan 2020 14:35:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Cc:     Prabhakar Kushwaha <pkushwaha@marvell.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Kamlakant Patel <kamlakantp@marvell.com>
Subject: Re: [PATCH] ata: ahci: Add shutdown to freeze hardware resources of
 ahci
Message-ID: <20200124203524.GA47417@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2QiJKLJCa7QKs3MFn1_EgsjD7-Qp7ab1DLab87hhqTr-Cnzg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[FYI, your reply was a multipart message (not a simple plain text
message), so I think the mailing lists discarded it and it doesn't
appear in the archives]

On Thu, Jan 23, 2020 at 08:05:04PM +0530, Prabhakar Kushwaha wrote:
> Thanks Bjorn for review. Reply is in-lined.
> 
> On Thu, Jan 23, 2020 at 7:24 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Thu, Jan 23, 2020 at 10:41:57AM +0000, Prabhakar Kushwaha wrote:
> > > device_shutdown() called from reboot/power_shutdown expect all
> > > devices to be shutdown. Same is true for ahci pci driver.
> > > As no shutdown function was implemented ata subsystem remains
> > > always alive and DMA/interrupt still active.
> > >
> > > It creates problem during kexec, here "M" bit is cleared to stop
> > > DMA usage.
> >
> > Maybe this is obvious to AHCI folks, but I don't know what "M" bit you
> > are referring to, and I don't see anything in the patch itself that
> > looks like an "M" bit.  I thought maybe you meant the "Bus Master
> > Enable" bit (PCI_COMMAND_MASTER), but I don't see an obvious
> > connection to that either.
> >
> I missed to explain M bit. Thanks for pointing it out.
> M bit is PCI_COMMAND_MASTER bit i.e. Bus Master Enable.

Please don't call it the "M" bit.  Neither the Conventional PCI nor
the PCIe specs call it that, and it could just as easily refer to the
"Memory Space Enable" bit.  Just call it the "Bus Master Enable" bit
like the specs do.

> There are 2 flow in kernel which calls device_shutdown() which inherently
> call pci_device_shutdown()().
> a) reboot flow
> b) kexec -e flow
> 
> issue seen in kexec -e flow where hard-disk is not getting detected in
> second kernel.
> There is special code in pci_device_shutdown() which clear M bit during
> kexec -e i.e. kexec_in_progress flag is set.
> 
> if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
>                 pci_clear_master(pci_dev);
> 
> There should not be any transaction after pci_clear_master() but i am
> seeing filesystem sync function calls after this.
> this is the reason shutdown function is added(this patch) which disable
> interrupt, stop DMA and freeze SATA port before execution of
> pci_clear_master()

I don't see where your patch adds anything that clears Bus Master
Enable.  You're adding ahci_shutdown_one(), so pci_device_shutdown()
will now call it, and maybe something inside ahci_shutdown_one() will
clear Bus Master Enable, but I couldn't find it with a quick look.

pci_device_shutdown() *does* clear it, of course, but only when
kexec_in_progress, and it does that even without this patch.

Just to be clear, I don't object to the patch itself -- that's an AHCI
thing that I don't know much about.  I'm just complaining because it's
not obvious that your commit log describes what the patch actually
does.

ahci_shutdown_one() might indeed stop the AHCI port DMA, but I suspect
it's doing that via the AHCI programming model, not by clearing Bus
Master Enable.  So maybe all you need to do is remove the references
to BME.

> After adding shutdown function, i can see hard-disk getting detected in
> second kernel.
> 
> > > Any further DMA transaction may cause instability and
> > > the hard-disk may even not get detected for second kernel.
> > > One of possible case is periodic file system sync.
> >
> > I think "may cause instability" and "disk may even not get detected"
> > is too vague and hand-wavy to really add useful information to the
> > commit log.
> >
> let me rework on this.. Thanks
> 
> > > So defining ahci pci driver shutdown to freeze hardware (mask
> > > interrupt, stop DMA engine and free DMA resources).
