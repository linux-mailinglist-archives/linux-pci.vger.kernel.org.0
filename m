Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9272B5F6F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 13:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgKQMzL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 07:55:11 -0500
Received: from mail-oo1-f41.google.com ([209.85.161.41]:42336 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgKQMzK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 07:55:10 -0500
Received: by mail-oo1-f41.google.com with SMTP id g4so4696962oom.9;
        Tue, 17 Nov 2020 04:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMMRuYViSm/P06w2h0LMNk8Q4hsk4EKGQOMKopq1p4k=;
        b=Cp7tlgKHpAH6d4vuIOsyDlOzzK3MqqdK4Y5ILDk7JMdBVtkszA+7UpoqyEYmTpOwrT
         aG8RzcO58rEs27M+uKenJun464PniQkwJopXRKX06YtuNIV9IBXC8HdDq4dOFxPOUSCZ
         jKVlHW0W4yJVY4X0ng1vcBPn9rxGpqhSXLP3yIz6vvfvSymK+qp9+DhTBjuoFBfFgRNy
         p3qH64+tuiOU6SD/2EiLbGRWipBBHCUaH3iWjou2q11Zi6OzElcMo9KCYdvNrlAiiekD
         O1TbNAjf53UssdduOr7NvG4RrVSPFUeosmxOcNGZUdWqxika6koHwUSo+CBJFWlgf0+x
         hSKQ==
X-Gm-Message-State: AOAM5306TAZRcSJEdtl64u7D7aO3BjMwKWJCd0JEa4J9Ij4xgl6js6kw
        Hc8GA3RrYAdHOB4KW/9ox5rcHlK7znj3YPJJSqI=
X-Google-Smtp-Source: ABdhPJxUvS202AqJmumZU34scvmzfxxdpHkn/iNWaHi1XHQXOpyNx1s/T3+FHnCvkT5MiswarUhgHyAGeuxmChyNkPU=
X-Received: by 2002:a4a:c018:: with SMTP id v24mr2872558oop.2.1605617708192;
 Tue, 17 Nov 2020 04:55:08 -0800 (PST)
MIME-Version: 1.0
References: <20201116192320.GA1290192@bjorn-Precision-5520> <40579a7ed0692d535f002112b18d1bb6e25aad0e.camel@linux.intel.com>
In-Reply-To: <40579a7ed0692d535f002112b18d1bb6e25aad0e.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Nov 2020 13:54:56 +0100
Message-ID: <CAJZ5v0h0Y-MD3LQ_q3AO8ioBDh_jwJ9HF_hZn3nYyQud8w0fXg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable PTM during suspend on Intel PCI bridges
To:     David Box <david.e.box@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <len.brown@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16, 2020 at 9:58 PM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> On Mon, 2020-11-16 at 13:23 -0600, Bjorn Helgaas wrote:
> > On Mon, Nov 16, 2020 at 06:53:09PM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Oct 7, 2020 at 7:10 PM Bjorn Helgaas <helgaas@kernel.org>
> > > wrote:
> > > > On Wed, Oct 07, 2020 at 06:53:16PM +0200, Rafael J. Wysocki
> > > > wrote:
> > > > > On Wed, Oct 7, 2020 at 6:49 PM David E. Box <
> > > > > david.e.box@linux.intel.com> wrote:
> > > > > > On Intel Platform Controller Hubs (PCH) since Cannon Lake,
> > > > > > the Precision
> > > > > > Time Measurement (PTM) capability can prevent PCIe root ports
> > > > > > from power
> > > > > > gating during suspend-to-idle, causing increased power
> > > > > > consumption on
> > > > > > systems that suspend using Low Power S0 Idle [1]. The issue
> > > > > > is yet to be
> > > > > > root caused but believed to be coming from a race condition
> > > > > > in the suspend
> > > > > > flow as the incidence rate varies for different platforms on
> > > > > > Linux but the
> > > > > > issue does not occur at all in other operating systems. For
> > > > > > now, disable
> > > > > > the feature on suspend on all Intel root ports and enable
> > > > > > again on resume.
> > > > >
> > > > > IMV it should also be noted that there is no particular reason
> > > > > why PTM
> > > > > would need to be enabled while the whole system is
> > > > > suspended.  At
> > > > > least it doesn't seem to be particularly useful in that state.
> > > >
> > > > Is this a hardware erratum?  If not, and this is working as
> > > > designed,
> > > > it sounds like we'd need to apply this quirk to every device that
> > > > supports PTM.  That's not really practical.
> > >
> > > Why not?
> >
> > My objection was that the original patch is a quirk that applies only
> > to Intel devices.
> >
> > If this is a generic thing that should be done for *all* devices that
> > support PTM, that's fine, but it should not be a quirk, and it should
> > not involve a list of Vendor or Device IDs.
> >
> > > It looks like the capability should be saved by pci_save_state()
> > > (it
> > > isn't ATM, which appears to be a mistake) and restored by
> > > pci_restore_state(), so if that is implemented, the saving can be
> > > combined with the disabling in principle.
> >
> > Yup, looks like a mistake.  Maybe David can fix that at the same time
> > (probably a separate patch, though).  I don't have a way to test it,
> > but he probably does.
>
> Yes, I can test save/restore of the PTM capability and submit a patch.
>
> >
> > > > The bugzilla says "there is no erratum as this does not affect
> > > > Windows," but that doesn't answer the question.  What I want to
> > > > know
> > > > is whether this is a *hardware* defect and whether it will be
> > > > fixed in
> > > > future hardware.
> > >
> > > I cannot answer this question, sorry.
> > >
> > > ATM we only know that certain SoCs may not enter the deepest idle
> > > state if PTM is enabled on some PCIe root ports during suspend.
> > >
> > > Disabling PTM on those ports while suspending helps and hence the
> > > patch.
> > >
> > > It doesn't appear to qualify as a "hardware defect".
> > >
> > > > If it's a "wont-fix" hardware issue, we can just disable PTM
> > > > completely on Intel hardware and we won't have to worry about it
> > > > during suspend.
> > >
> > > I'm not following the logic here, sorry again.
> > >
> > > First of all, there are systems that never suspend, so why would
> > > they
> > > be affected by the remedy (whatever it is)?
> > >
> > > Second, it is not about the suspend failing entirely.  It's about
> > > being able to make the system draw less power while suspended.
> > >
> > > Generally, if someone said "I can make the system draw less power
> > > while suspended if I disable PCIe feature X during suspend", would
> > > you
> > > disregard that?
> >
> > My questions were all prompted by the Intel-specific nature of the
> > original patch, which suggests an ongoing maintenance burden.  If it
> > can be done generically, I have no problem with it.
>
> Okay. I'll add this to the save/restore patch then with the comment
> that it saves power on some Intel platforms.

I'd suggest doing two patches, then, one to save/restore the PTM
capability and the other to add disabling it to the "save" path (with
a comment as appropriate).
