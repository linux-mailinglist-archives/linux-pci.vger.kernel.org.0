Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB1E2859E5
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 09:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgJGHu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 03:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGHu7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 03:50:59 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26D6C061755;
        Wed,  7 Oct 2020 00:50:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a3so1566029ejy.11;
        Wed, 07 Oct 2020 00:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yK+TtzICLfp2nmfuxf7NcvdpIVXOd86cA4QsKvR9tAw=;
        b=T5If2aVVQ1EmHDS4G7YpniQUAAHw3cazxRaBnXZngdOln2rLvZRaReHiJGMyyOUXCk
         4wQlgf4ciKX+UGHX8PCzh360qR45avxLd82CKHobdiAze8lKiUMzGDOY9iWyecr4eMmm
         A8W8ltDRG6Vj09RzaSNRkTgdnlGuVMFzy3Hs/47xYe9VADfF0bg6Y9iWpgX0DXRGUXf5
         n5wdlWsAGoOgUMqdCsw8Juy6UQUgk//Q6Ff2NuoiulkiBLhSCID3EqCgyexIgFBZBWXP
         OXahofka0k6YRnniQLe5mBxgFBCUlEXNE9gVdA0uefWJU+fGmE70LH9yL2xLePMIDnmi
         1e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yK+TtzICLfp2nmfuxf7NcvdpIVXOd86cA4QsKvR9tAw=;
        b=P1aONDvkp8FQkwNjp3vvweluFUyNBs2ES4Z4ZYHNVjebKn1ev7FXzOhghCEwW9vGUg
         dQvC1JqETB4hr/p5OltmfJk+b/Svx8nTYmVJDqVFmU85hmZmc3Dk8V0ghEx6zHwIqCqU
         biFDkSlzS5M4LxEnfUZzO8WVIpkUgE3GiYa3x9/V7qQ/Cg7pQDUnNx4NHiNh2JF0C6T9
         tz0M8p7Vmqwp9wQn5SL7jhFhlsExrkLYOBJzYPbDYHRz8/ksuqXqX6qQpfXs3qqnmpIl
         vQ6RZXetHDnJmo2tFWal7HDxhOzR+GJW2ounfCsBudHWWRHv6GOx3FQaEqvX/6tM+7SC
         jXxw==
X-Gm-Message-State: AOAM5313qhgz/t2iijMJkhGUQu8FZodLTK5HAuardMChjOPXjhQoqr9I
        JwsiEvTTLSArkyC/hjcSyDZXZc2pWXvGUAO3D2Y=
X-Google-Smtp-Source: ABdhPJzmMxBLRZJzVbKi7vX/b/OeOCkQJSCC2GgVJ4WaH4XiYfF+kJx9bt6J5OE9zmgh1Fdl1FArhkkA9Fs1wLvljTk=
X-Received: by 2002:a17:906:6409:: with SMTP id d9mr2040618ejm.344.1602057057351;
 Wed, 07 Oct 2020 00:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201003075514.32935-5-haifeng.zhao@intel.com> <20201003164421.GA2883839@bjorn-Precision-5520>
In-Reply-To: <20201003164421.GA2883839@bjorn-Precision-5520>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Wed, 7 Oct 2020 15:50:45 +0800
Message-ID: <CAKF3qh0Dy6eUfpXqXkpd7Xbt8yLfxzrTKyqBNqXeUs95421vcg@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] PCI: only return true when dev io state is really changed
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ethan Zhao <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@linux.intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

On Sun, Oct 4, 2020 at 12:44 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Oct 03, 2020 at 03:55:13AM -0400, Ethan Zhao wrote:
> > When uncorrectable error happens, AER driver and DPC driver interrupt
> > handlers likely call
> >
> >    pcie_do_recovery()
> >    ->pci_walk_bus()
> >      ->report_frozen_detected()
> >
> > with pci_channel_io_frozen the same time.
> >    If pci_dev_set_io_state() return true even if the original state is
> > pci_channel_io_frozen, that will cause AER or DPC handler re-enter
> > the error detecting and recovery procedure one after another.
> >    The result is the recovery flow mixed between AER and DPC.
> > So simplify the pci_dev_set_io_state() function to only return true
> > when dev->error_state is really changed.
> >
> > Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
> > Tested-by: Wen Jin <wen.jin@intel.com>
> > Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
> > Reviewed-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> > Changnes:
> >  v2: revise description and code according to suggestion from Andy.
> >  v3: change code to simpler.
> >  v4: no change.
> >  v5: no change.
> >  v6: no change.
> >  v7: changed based on Bjorn's code and truth table.
> >
> >  drivers/pci/pci.h | 53 ++++++++++++++++++-----------------------------
> >  1 file changed, 20 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 455b32187abd..47af1ff2a286 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -354,44 +354,31 @@ struct pci_sriov {
> >   *
> >   * Must be called with device_lock held.
> >   *
> > - * Returns true if state has been changed to the requested state.
> > + * Returns true if state has been really changed to the requested state.
> >   */
> >  static inline bool pci_dev_set_io_state(struct pci_dev *dev,
> >                                       pci_channel_state_t new)
> >  {
> > -     bool changed = false;
> > -
> >       device_lock_assert(&dev->dev);
> > -     switch (new) {
> > -     case pci_channel_io_perm_failure:
> > -             switch (dev->error_state) {
> > -             case pci_channel_io_frozen:
> > -             case pci_channel_io_normal:
> > -             case pci_channel_io_perm_failure:
> > -                     changed = true;
> > -                     break;
> > -             }
> > -             break;
> > -     case pci_channel_io_frozen:
> > -             switch (dev->error_state) {
> > -             case pci_channel_io_frozen:
> > -             case pci_channel_io_normal:
> > -                     changed = true;
> > -                     break;
> > -             }
> > -             break;
> > -     case pci_channel_io_normal:
> > -             switch (dev->error_state) {
> > -             case pci_channel_io_frozen:
> > -             case pci_channel_io_normal:
> > -                     changed = true;
> > -                     break;
> > -             }
> > -             break;
> > -     }
> > -     if (changed)
> > -             dev->error_state = new;
> > -     return changed;
> > +
> > +/*
> > + *                   Truth table:
> > + *                   requested new state
> > + *     current          ------------------------------------------
> > + *     state            normal         frozen         perm_failure
> > + *     ------------  +  -------------  -------------  ------------
> > + *     normal        |  normal         frozen         perm_failure
> > + *     frozen        |  normal         frozen         perm_failure
> > + *     perm_failure  |  perm_failure*  perm_failure*  perm_failure
> > + */
> > +
> > +     if (dev->error_state == pci_channel_io_perm_failure)
> > +             return false;
> > +     else if (dev->error_state == new)
> > +             return false;
> > +
> > +     dev->error_state = new;
> > +     return true;
>
> No, you missed the point.  I want
>
>   1) One patch that converts the "switch" to the shorter "if"
>      statements.  This one will be big and ugly, but should not change
>      the functionality at all, and it should be pretty easy to verify
>      that since there aren't very many states involved.
>
>      Since this one is pure code simplification, the commit log won't
>      say anything at all about AER or DPC or their requirements
>      because it's not changing any behavior.
>
>   2) A separate patch that's tiny and makes whatever functional change
>      you need.

       Make sense, clear,  this time.

     Thanks,
     Ethan
>
> >  }
> >
> >  static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> > --
> > 2.18.4
> >
