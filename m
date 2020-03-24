Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8581917AB
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 18:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgCXRb4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 13:31:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25741 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727296AbgCXRb4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2020 13:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585071115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJHNzYzu8vMBhLyQungT7C1b2BGUh9KVFCtBdVqVQ8A=;
        b=AKITq8tQjo03kFRbQIXetmVvduN8mg9sjNRQQBSqGsDYlHSXmTmmNEZ4F5+2Eb9RaDQT1p
        iDcb4KZZedekvdUaKY7Y5iGpLmz+/7Y7UR97MXogyK2n+yXOk1btE/gf3j1KuWT1Wuou4f
        +Lyxez2D6Xeconu4Q2ZI7rKXaA4dd14=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-PN7zb5u2M2mGg5AwzNYIEQ-1; Tue, 24 Mar 2020 13:31:53 -0400
X-MC-Unique: PN7zb5u2M2mGg5AwzNYIEQ-1
Received: by mail-qv1-f69.google.com with SMTP id m5so16513496qvy.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2020 10:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJHNzYzu8vMBhLyQungT7C1b2BGUh9KVFCtBdVqVQ8A=;
        b=fDffdJOeRdoBkfe/LbFs8rB/p1qL41gG4sis9a4NhLOL4UjtK6nGoSbMh2lZsUeG98
         HS2ApNLMODfQEqBuUTo5fCUZDqY/fNO4mE486Ik809iddR9BXUZmSlZ79qo215obOX1e
         rR1hWsr1vNlfXhE0FI8Yw8HiFFavL00ANxZjKxIpthqX3aDi+fRYwigeDpyN+ajpIXs/
         /QFiuUs/qC6YCpJpNzD7WX7u9LVzAcXYgcKoOoLKBnMRQWCCOzghSIwAWeDJWcBF4ULh
         1nqjtOiJsIeR9L7rbkb9V+06dr0mwi9c/ZLO4mtdCZI/mOFp3tzjbzhjX9fH4oIleAYG
         E7zA==
X-Gm-Message-State: ANhLgQ26NJfpypJk5sdGQsZhNvFjQILEj5rCQKOap+3cSbLqKmGmw8Iv
        bc4AzvGmmoiddgqPPRspAt2VvfpiH/xLzXfhHp/qf7iyHW3G7fC9huCdcoPxGjUoEKs6sE4kUDu
        c0F+qiqbCs1E/iv6Nzz1eXrU7GLfuV1WlEuKV
X-Received: by 2002:a37:a151:: with SMTP id k78mr15810449qke.62.1585071113023;
        Tue, 24 Mar 2020 10:31:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsT3+/NsUg5fFEiC7sl/xL5+Je1Wup8Qo3qgB+ijo3E137wcTx+VJFpMve9UNQQtDpuEDBDe/wRAdiHFGyqiS4=
X-Received: by 2002:a37:a151:: with SMTP id k78mr15810420qke.62.1585071112699;
 Tue, 24 Mar 2020 10:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200310192627.437947-1-kherbst@redhat.com> <20200320221931.GA23783@google.com>
 <CACO55tsamLG5WE16U=psJpRWfz=7Fy5K8haGKHnhic1h0WAmqA@mail.gmail.com>
In-Reply-To: <CACO55tsamLG5WE16U=psJpRWfz=7Fy5K8haGKHnhic1h0WAmqA@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 24 Mar 2020 18:31:08 +0100
Message-ID: <CACO55ttvb5uC37ORiLuVBidhfSn-+WSReJ+aCfWR3k-fLtPBnA@mail.gmail.com>
Subject: Re: [PATCH v7] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 21, 2020 at 2:02 AM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Fri, Mar 20, 2020 at 11:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Mar 10, 2020 at 08:26:27PM +0100, Karol Herbst wrote:
> > > Fixes the infamous 'runtime PM' bug many users are facing on Laptops with
> > > Nvidia Pascal GPUs by skipping said PCI power state changes on the GPU.
> > >
> > > Depending on the used kernel there might be messages like those in demsg:
> > >
> > > "nouveau 0000:01:00.0: Refused to change power state, currently in D3"
> > > "nouveau 0000:01:00.0: can't change power state from D3cold to D0 (config
> > > space inaccessible)"
> > > followed by backtraces of kernel crashes or timeouts within nouveau.
> > >
> > > It's still unkown why this issue exists, but this is a reliable workaround
> > > and solves a very annoying issue for user having to choose between a
> > > crashing kernel or higher power consumption of their Laptops.
> >
> > Thanks for the bugzilla link.  The bugzilla mentions lots of mailing
> > list discussion.  Can you include links to some of that?
> >
> > IIUC this basically just turns off PCI power management for the GPU.
> > Can you do that with something like the following?  I don't know
> > anything about DRM, so I don't know where you could save the pm_cap,
> > but I'm sure the driver could keep it somewhere.
> >
>
> Sure this would work? From a quick look over the pci code, it looks
> like a of code would be skipped we really need, like the platform code
> to turn off the GPU via ACPI. But I could also remember incorrectly on
> how all of that worked again. I can of course try and see what the
> effect of this patch would be. And would the parent bus even go into
> D3hot if it knows one of its children is still at D0? Because that's
> what the result of that would be as well, no? And I know that if the
> bus stays in D0, that it has a negative impact on power consumption.
>
> Anyway, I will try that out, I am just not seeing how that would help.
>

so it seems like that has worked unless I screwed up locally. Will do
some proper testing and then I think we won't need to go through the
pci tree anymore as no changes are required there with that.

> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> > index b65ae817eabf..2ad825e8891c 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> > @@ -618,6 +618,23 @@ nouveau_drm_device_fini(struct drm_device *dev)
> >         kfree(drm);
> >  }
> >
> > +static void quirk_broken_nv_runpm(struct drm_device *drm_dev)
> > +{
> > +       struct pci_dev *pdev = drm_dev->pdev;
> > +       struct pci_dev *bridge = pci_upstream_bridge(pdev);
> > +
> > +       if (!bridge || bridge->vendor != PCI_VENDOR_ID_INTEL)
> > +               return;
> > +
> > +       switch (bridge->device) {
> > +       case 0x1901:
> > +               STASH->pm_cap = pdev->pm_cap;
> > +               pdev->pm_cap = 0;
> > +               NV_INFO(drm_dev, "Disabling PCI power management to avoid bug\n");
> > +               break;
> > +       }
> > +}
> > +
> >  static int nouveau_drm_probe(struct pci_dev *pdev,
> >                              const struct pci_device_id *pent)
> >  {
> > @@ -699,6 +716,7 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
> >         if (ret)
> >                 goto fail_drm_dev_init;
> >
> > +       quirk_broken_nv_runpm(drm_dev);
> >         return 0;
> >
> >  fail_drm_dev_init:
> > @@ -735,6 +753,9 @@ nouveau_drm_remove(struct pci_dev *pdev)
> >  {
> >         struct drm_device *dev = pci_get_drvdata(pdev);
> >
> > +       /* If we disabled PCI power management, restore it */
> > +       if (STASH->pm_cap)
> > +               pdev->pm_cap = STASH->pm_cap;
> >         nouveau_drm_device_remove(dev);
> >         pci_disable_device(pdev);
> >  }
> >

