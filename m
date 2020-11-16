Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C152B4E92
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 18:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbgKPRxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 12:53:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43406 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732758AbgKPRxV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 12:53:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id y22so16846139oti.10;
        Mon, 16 Nov 2020 09:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7+Z3mrIb8Sp0oVQFXi8OYd9zBdaHaRXhlQ8/Dy+0xg=;
        b=Ryru2wbXXLNUWNAzbJoowtDcA3rIoCtvzq+d6RI51iTi9x2HN6U51B8sjI8SL5C1X5
         4RL5QcRY0gHZY4tGfn4/Ql+EcEv0ke95qdMfCLM5gc+nYXBbtjH+yWPqQIjbzyiEIrg9
         GOWe+a2N569WEYeufSuXIYC5ykHkA+jLYD1Fo1bk7Oe4n1z5xEJ2BuWNUVOgfUT/yXjx
         81veXU1KG626WOauEgLizN+B78Iulj5KWrMLt5/uIJjFblb4HVwiOhZtY64d8hfNd9R2
         KgbFN7eIuvBouIGrIKGaXhN1xZOkW6nILqlbNjiVBbzn8b7YCcP/pxuelus4CzKm8POC
         XlsQ==
X-Gm-Message-State: AOAM532EgA8GbM0IRe/DUGQB8jJSwfxwz/O6AXthgplbzr4Owb2qFzX1
        ttT6oBgwwmlYnhT3QJiLIA1NaSZ9pvQUU/yGs9k=
X-Google-Smtp-Source: ABdhPJxc7w+YIJgU/sF8DM8t4ZQPGnBVp2AsN1ZOK0nspYoAfne633B/qNgtj2Qq+5bp4UroC0ZID28fsOp812JpIB4=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr345705ota.260.1605549200640;
 Mon, 16 Nov 2020 09:53:20 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gRph3UMffWqUVqTnDE149Ai-SbzmhjzZU1x=QOzAZeZA@mail.gmail.com>
 <20201007171024.GA3252529@bjorn-Precision-5520>
In-Reply-To: <20201007171024.GA3252529@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Nov 2020 18:53:09 +0100
Message-ID: <CAJZ5v0gwSe=o_Ta0MR6XTn4BmHjs=ewTVJHe6OTp18ho+5h1Eg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable PTM during suspend on Intel PCI bridges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <len.brown@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 7, 2020 at 7:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Oct 07, 2020 at 06:53:16PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Oct 7, 2020 at 6:49 PM David E. Box <david.e.box@linux.intel.com> wrote:
> > >
> > > On Intel Platform Controller Hubs (PCH) since Cannon Lake, the Precision
> > > Time Measurement (PTM) capability can prevent PCIe root ports from power
> > > gating during suspend-to-idle, causing increased power consumption on
> > > systems that suspend using Low Power S0 Idle [1]. The issue is yet to be
> > > root caused but believed to be coming from a race condition in the suspend
> > > flow as the incidence rate varies for different platforms on Linux but the
> > > issue does not occur at all in other operating systems. For now, disable
> > > the feature on suspend on all Intel root ports and enable again on resume.
> >
> > IMV it should also be noted that there is no particular reason why PTM
> > would need to be enabled while the whole system is suspended.  At
> > least it doesn't seem to be particularly useful in that state.
>
> Is this a hardware erratum?  If not, and this is working as designed,
> it sounds like we'd need to apply this quirk to every device that
> supports PTM.  That's not really practical.

Why not?

It looks like the capability should be saved by pci_save_state() (it
isn't ATM, which appears to be a mistake) and restored by
pci_restore_state(), so if that is implemented, the saving can be
combined with the disabling in principle.

> The bugzilla says "there is no erratum as this does not affect
> Windows," but that doesn't answer the question.  What I want to know
> is whether this is a *hardware* defect and whether it will be fixed in
> future hardware.

I cannot answer this question, sorry.

ATM we only know that certain SoCs may not enter the deepest idle
state if PTM is enabled on some PCIe root ports during suspend.

Disabling PTM on those ports while suspending helps and hence the patch.

It doesn't appear to qualify as a "hardware defect".

> If it's a "wont-fix" hardware issue, we can just disable PTM
> completely on Intel hardware and we won't have to worry about it
> during suspend.

I'm not following the logic here, sorry again.

First of all, there are systems that never suspend, so why would they
be affected by the remedy (whatever it is)?

Second, it is not about the suspend failing entirely.  It's about
being able to make the system draw less power while suspended.

Generally, if someone said "I can make the system draw less power
while suspended if I disable PCIe feature X during suspend", would you
disregard that?
