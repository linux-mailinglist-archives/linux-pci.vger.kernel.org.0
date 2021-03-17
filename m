Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBB733F590
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 17:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhCQQbt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 12:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbhCQQbW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 12:31:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415C1C06174A
        for <linux-pci@vger.kernel.org>; Wed, 17 Mar 2021 09:31:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w18so3081727edc.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Mar 2021 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KI1R824OvaDi8EtBJ+cCqzUwxRnNlDdyV/9bYCzn8Iw=;
        b=JJ8ujRoH22SvRQdBFA5n9qmv2MO4sYqWieR1gWLN3cVpaoq8y4F1znWnR2Dqr42LBt
         KKfWlfdUjv/y914o2KmjfEGRI2rTK5cUEHSzcUlesrIiBj2/kXQnE8iiNH+XEpleEvJ9
         6AhmE2MBfGhRIXFywgON0EKdGoZptBHQ/wv1vLbjFbaCRx5hQaBkog6PMXL3ZRO7YNL9
         dM9NFzvXaXwcuaYGw/oRJwNwvUuNleCA/KDC5/h7UKKaq9uVtMw6sF5mEB7fZ/i2r/iw
         NE8kFtDiWFmYvaP+xkSQWVHUYQKYs9AK7zQOZ+PcFAbGO6PakjQ3xLvhs5uLioAcFhP4
         JVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KI1R824OvaDi8EtBJ+cCqzUwxRnNlDdyV/9bYCzn8Iw=;
        b=OinLOl5Fv2M2hthRPPU64m06lgzqqzG6UH9SYHuB+MprffV3kzHn+0iHYjwkdUHmP+
         sxBw6hwumU2YnFfg6Ox4+fytg/Dr25y382Zgxb+FKVUJNxHC6+BX2a7i2AoH7bUgm6h0
         vvwds7/YHJ6hKZRSKrqmAloZLZc4btk8uz4sKFpraMWq62A2/nVwjXahxcba9z48RAAL
         0dnTiFsgkxRxVnI/PjWQv+ehYJFcBrFjDq7Qa0QfBzSvWOFstObDzcrJezOr0h04sH43
         m3qaQVbI2vMkwhmcSXzTTvYwkQ9UvqtJ/3iIkK521jjebAhiuNRnwyLR1+xPCBUcoAiO
         rbsA==
X-Gm-Message-State: AOAM533f9nkXa/hRe9S0t6fBEJnZp/8rJOeK4hwV6SAefV5iYfJI85KV
        Sh29ZaYF0RUW2d4uJDaYOR0Gb6zy8mv4LvEZqLRs/Q==
X-Google-Smtp-Source: ABdhPJx/7oU+TXH89BbDG5p40lEtXPidNB3nMUivvIeEILs4lXiuEKtlPk5r+KuUvGKh6fT4Q5se3U54MhbPsc/B6PY=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr42578746edr.52.1615998681018;
 Wed, 17 Mar 2021 09:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210317041342.GA19198@wunner.de> <CAPcyv4jxTcUEgcfPRckHqrUPy8gR7ZJsxDaeU__pSq6PqJERAQ@mail.gmail.com>
 <20210317053114.GA32370@wunner.de>
In-Reply-To: <20210317053114.GA32370@wunner.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Mar 2021 09:31:14 -0700
Message-ID: <CAPcyv4j8t4Y=kpRSvOjOfVHd107YemiRcW0BNQRwp-d9oCddUw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: pciehp: Skip DLLSC handling if DPC is triggered
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, knsathya@kernel.org,
        Sinan Kaya <okaya@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 16, 2021 at 10:31 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, Mar 16, 2021 at 10:08:31PM -0700, Dan Williams wrote:
> > On Tue, Mar 16, 2021 at 9:14 PM Lukas Wunner <lukas@wunner.de> wrote:
> > >
> > > On Fri, Mar 12, 2021 at 07:32:08PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > +     if ((events == PCI_EXP_SLTSTA_DLLSC) && is_dpc_reset_active(pdev)) {
> > > > +             ctrl_info(ctrl, "Slot(%s): DLLSC event(DPC), skipped\n",
> > > > +                       slot_name(ctrl));
> > > > +             ret = IRQ_HANDLED;
> > > > +             goto out;
> > > > +     }
> > >
> > > Two problems here:
> > >
> > > (1) If recovery fails, the link will *remain* down, so there'll be
> > >     no Link Up event.  You've filtered the Link Down event, thus the
> > >     slot will remain in ON_STATE even though the device in the slot is
> > >     no longer accessible.  That's not good, the slot should be brought
> > >     down in this case.
> >
> > Can you elaborate on why that is "not good" from the end user
> > perspective? From a driver perspective the device driver context is
> > lost and the card needs servicing. The service event starts a new
> > cycle of slot-attention being triggered and that syncs the slot-down
> > state at that time.
>
> All of pciehp's code assumes that if the link is down, the slot must be
> off.  A slot which is in ON_STATE for a prolonged period of time even
> though the link is down is an oddity the code doesn't account for.
>
> If the link goes down, the slot should be brought into OFF_STATE.
> (It's okay though to delay bringdown until DPC recovery has completed
> unsuccessfully, which is what the patch I'm proposing does.)
>
> I don't understand what you mean by "service event".  Someone unplugging
> and replugging the NVMe drive?

Yes, service meaning a technician physically removes the card.

>
>
> > > (2) If recovery succeeds, there's a race where pciehp may call
> > >     is_dpc_reset_active() *after* dpc_reset_link() has finished.
> > >     So both the DPC Trigger Status bit as well as pdev->dpc_reset_active
> > >     will be cleared.  Thus, the Link Up event is not filtered by pciehp
> > >     and the slot is brought down and back up even though DPC recovery
> > >     was succesful, which seems undesirable.
> >
> > The hotplug driver never saw the Link Down, so what does it do when
> > the slot transitions from Link Up to Link Up? Do you mean the Link
> > Down might fire after the dpc recovery has completed if the hotplug
> > notification was delayed?
>
> If the Link Down is filtered and the Link Up is not, pciehp will
> bring down the slot and then bring it back up.  That's because pciehp
> can't really tell whether a DLLSC event is Link Up or Link Down.
>
> It just knows that the link was previously up, is now up again,
> but must have been down intermittently, so transactions to the
> device in the slot may have been lost and the slot is therefore
> brought down for safety.  Because the link is up, it is then
> brought back up.

I wonder why we're not seeing that effect in testing?
