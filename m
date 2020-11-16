Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F932B50FC
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 20:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgKPTXX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 14:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgKPTXX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 14:23:23 -0500
Received: from localhost (189.sub-72-105-114.myvzw.com [72.105.114.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBB302225B;
        Mon, 16 Nov 2020 19:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605554602;
        bh=g0rPF891hY5n20OTuoyLNjb51WCLMjcMNMxWkW5x6r4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VIZWt/gjTQ1W6GTJzcOu2+w+1Ha5xbdud4IgZiDCWP5doSWm55i2h73+907fxRY16
         ibe+ErD/e4baLmQZPeoImfqKuVP/mYVU4OAv/a/9SFT9FhIXpPXvWsQ1jhpbDlsaAD
         9lyN61KTZBXdK6L+bzT8WvWOe3BJnFmsF9J6KIkI=
Date:   Mon, 16 Nov 2020 13:23:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <len.brown@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable PTM during suspend on Intel PCI bridges
Message-ID: <20201116192320.GA1290192@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gwSe=o_Ta0MR6XTn4BmHjs=ewTVJHe6OTp18ho+5h1Eg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16, 2020 at 06:53:09PM +0100, Rafael J. Wysocki wrote:
> On Wed, Oct 7, 2020 at 7:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Oct 07, 2020 at 06:53:16PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Oct 7, 2020 at 6:49 PM David E. Box <david.e.box@linux.intel.com> wrote:
> > > >
> > > > On Intel Platform Controller Hubs (PCH) since Cannon Lake, the Precision
> > > > Time Measurement (PTM) capability can prevent PCIe root ports from power
> > > > gating during suspend-to-idle, causing increased power consumption on
> > > > systems that suspend using Low Power S0 Idle [1]. The issue is yet to be
> > > > root caused but believed to be coming from a race condition in the suspend
> > > > flow as the incidence rate varies for different platforms on Linux but the
> > > > issue does not occur at all in other operating systems. For now, disable
> > > > the feature on suspend on all Intel root ports and enable again on resume.
> > >
> > > IMV it should also be noted that there is no particular reason why PTM
> > > would need to be enabled while the whole system is suspended.  At
> > > least it doesn't seem to be particularly useful in that state.
> >
> > Is this a hardware erratum?  If not, and this is working as designed,
> > it sounds like we'd need to apply this quirk to every device that
> > supports PTM.  That's not really practical.
> 
> Why not?

My objection was that the original patch is a quirk that applies only
to Intel devices.

If this is a generic thing that should be done for *all* devices that
support PTM, that's fine, but it should not be a quirk, and it should
not involve a list of Vendor or Device IDs.

> It looks like the capability should be saved by pci_save_state() (it
> isn't ATM, which appears to be a mistake) and restored by
> pci_restore_state(), so if that is implemented, the saving can be
> combined with the disabling in principle.

Yup, looks like a mistake.  Maybe David can fix that at the same time
(probably a separate patch, though).  I don't have a way to test it,
but he probably does.

> > The bugzilla says "there is no erratum as this does not affect
> > Windows," but that doesn't answer the question.  What I want to know
> > is whether this is a *hardware* defect and whether it will be fixed in
> > future hardware.
> 
> I cannot answer this question, sorry.
> 
> ATM we only know that certain SoCs may not enter the deepest idle
> state if PTM is enabled on some PCIe root ports during suspend.
> 
> Disabling PTM on those ports while suspending helps and hence the patch.
> 
> It doesn't appear to qualify as a "hardware defect".
> 
> > If it's a "wont-fix" hardware issue, we can just disable PTM
> > completely on Intel hardware and we won't have to worry about it
> > during suspend.
> 
> I'm not following the logic here, sorry again.
> 
> First of all, there are systems that never suspend, so why would they
> be affected by the remedy (whatever it is)?
> 
> Second, it is not about the suspend failing entirely.  It's about
> being able to make the system draw less power while suspended.
> 
> Generally, if someone said "I can make the system draw less power
> while suspended if I disable PCIe feature X during suspend", would you
> disregard that?

My questions were all prompted by the Intel-specific nature of the
original patch, which suggests an ongoing maintenance burden.  If it
can be done generically, I have no problem with it.

Bjorn
