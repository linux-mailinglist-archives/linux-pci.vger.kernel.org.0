Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B9152542F
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 19:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357366AbiELRwy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 13:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357318AbiELRwt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 13:52:49 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D11D9D4FD;
        Thu, 12 May 2022 10:52:48 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2f7b815ac06so65728717b3.3;
        Thu, 12 May 2022 10:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBss9hrCuzZOJevykbo5hNyYyc/K/PeGC6/bLZL7lmM=;
        b=jmVo1myFREvhykbGOkQEemjM4TchoWyzAH5Oq10RoBeb53PaOizKvxnHUMHXsPblGY
         nNHxUU0IapKpApL5/p/otsMdUm1Ds5d/6lpOR6/L/RxktMhflSqsas36LvTF4Kain9I4
         kbSrSIlfaL1yMZie1brGZVskD/xrDUcNdQj00R7sd3fK+rVnzGqzHbJFdQKsEmgw8v6x
         9ldOYl2BUISesEnRDCa/ufCxjvEPM7WJXFoY94DqPhKqIMD1QxQ4V58YvNZex4YpZwFX
         QlR1hEHKvRCWsV+fl44WKwA5Eeupd+oDnUnFYh78yrkDm+yVjsLsrccBnycMc+8/e5ui
         VnUg==
X-Gm-Message-State: AOAM531SoMYBY7a0LDdP6Wl+UuC+DxwYYEZk/Qv0ngeQLG9oGeIuZVeS
        eaFQ6hbXKEcA8VNi1/24ceoR/wIMn8DIddHlpjk=
X-Google-Smtp-Source: ABdhPJxn7gDezTFI9vZy41RhNiS3+8pRdX0nKFtKHgYCvrkr24aeyO9uBN1olsZ7qiQfkaDbWKLNEUPOvk/DSisa3fc=
X-Received: by 2002:a81:260a:0:b0:2f4:ca82:a42f with SMTP id
 m10-20020a81260a000000b002f4ca82a42fmr1330494ywm.149.1652377967329; Thu, 12
 May 2022 10:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <70d0c0d4-093f-ae8a-9654-5a433285ab12@intel.com> <20220512174239.GA851224@bhelgaas>
In-Reply-To: <20220512174239.GA851224@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 May 2022 19:52:36 +0200
Message-ID: <CAJZ5v0g_p+Yb-VLo8b6-SYU17=GQOqZh2E5-52dkq-3rzU=57A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajvi Jingar <rajvi.jingar@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 7:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Hi Rajvi,
>
> I received your v1, v2, v3, v4, v5 postings because they were sent
> directly to bhelgaas@google.com, but for some reason vger doesn't like
> them so they don't show up on the mailing list:
>
>   https://lore.kernel.org/all/?q=a%3Arajvi.jingar
>
> I looked at the ones I received directly and don't see an obvious
> problem.  Maybe there's a hint here?
>
>   http://vger.kernel.org/majordomo-info.html
>
> All patches should appear on the linux-pci mailing list before
> applying them, so we need to figure this out somehow.  In fact, I read
> and review patches from linux-pci, so I often don't even see things
> that are just sent directly to bhelgaas@google.com.
>
> On Thu, May 12, 2022 at 03:49:18PM +0200, Rafael J. Wysocki wrote:
> > On 4/29/2022 11:05 PM, Rajvi Jingar wrote:
> > > For the PCIe devices (like nvme) that do not go into D3 state still need to
> > > disable PTM to allow the port to enter a lower-power PM state and the SoC
> > > to reach a lower-power idle state as a whole. Move the pci_disable_ptm()
> > > out of pci_prepare_to_sleep() as this code path is not followed for devices
> > > that do not go into D3. This fixes the issue seen on Dell XPS 9300 with
> > > Ice Lake CPU and Dell Precision 5530 with Coffee Lake CPU platforms to get
> > > improved residency in low power idle states.
>
> I think the paragraph above is a distraction, and the real reason is
> the paragraph below.
>
> > > Also, on receiving a PTM Request from a downstream device, if PTM is
> > > disabled on the root port, as per PCIe r6.0, sec 6.21.3, such a request
> > > would cause an Unsupported Request error. So it must first disable PTM in
> > > any downstream devices.
> > >
> > > Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
> > > Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> > > Suggested-by: David E. Box <david.e.box@linux.intel.com>
> > > ---
> > >   v1 -> v2: add Fixes tag in commit message
> > >   v2 -> v3: move changelog after "---" marker
> > >   v3 -> v4: add "---" marker after changelog
> > >   v4 -> v5: move pci_disable_ptm() out of the pci_dev->state_saved check.
> > >        disable PTM for all devices, not just root ports.
> > > ---
> > >   drivers/pci/pci-driver.c | 28 +++++++++++++++++++---------
> > >   drivers/pci/pci.c        | 10 ----------
> > >   2 files changed, 19 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > index 8b55a90126a2..400dd18a9cf5 100644
> > > --- a/drivers/pci/pci-driver.c
> > > +++ b/drivers/pci/pci-driver.c
> > > @@ -813,6 +813,7 @@ static int pci_pm_suspend_late(struct device *dev)
> > >   static int pci_pm_suspend_noirq(struct device *dev)
> > >   {
> > > +   unsigned int dev_state_saved;
> > >     struct pci_dev *pci_dev = to_pci_dev(dev);
> > >     const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> > > @@ -845,16 +846,25 @@ static int pci_pm_suspend_noirq(struct device *dev)
> > >             }
> > >     }
> > > -   if (!pci_dev->state_saved) {
> > > +   dev_state_saved = pci_dev->state_saved;
> >
> > If pci_dev->state_saved is set here, the device may be in D3cold already and
> > disabling PTM for it will not work.  Of course, it is not necessary to
> > disable PTM for it then, but this case need to be taken care of.
> >
> > > +   if (!dev_state_saved)
> > >             pci_save_state(pci_dev);
> > > -           /*
> > > -            * If the device is a bridge with a child in D0 below it, it needs to
> > > -            * stay in D0, so check skip_bus_pm to avoid putting it into a
> > > -            * low-power state in that case.
> > > -            */
> > > -           if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
> > > -                   pci_prepare_to_sleep(pci_dev);
> > > -   }
> > > +
> > > +   /*
> > > +    * There are systems (for example, Intel mobile chips since Coffee
> > > +    * Lake) where the power drawn while suspended can be significantly
> > > +    * reduced by disabling PTM as this allows the SoC to reach a
> > > +    * lower-power idle state as a whole.
>
> I think the argument for disabling PTM is that:
>
>   - If a PTM Requester is put in a low-power state, a PTM Responder
>     upstream from it may also be put in a low-power state.
>
>   - Putting a Port in D1, D2, or D3hot does not prohibit it from
>     sending or responding to PTM Requests (I'd be glad to be corrected
>     about this).
>
>   - We want to disable PTM on Responders when they are in a low-power
>     state.
>
>   - Per 6.21.3, a PTM Requester must not be enabled when the upstream
>     PTM Responder is disabled.
>
>   - Therefore, we must disable all PTM on all downstream PTM
>     Requesters before disabling it on the PTM Responder, e.g., a Root
>     Port.
>
> This has nothing specifically to do with Coffee Lake or other Intel
> chips, so I think the comment should be merely something to the
> effect that "disabling PTM reduces power consumption."
>
> > Something like this should suffice IMV:
> >
> > if (!dev_state_saved || pci_dev->current_state != PCI_D3cold)
> >
> >         pci_disable_ptm(pci_dev);
>
> It makes sense to me that we needn't disable PTM if the device is in
> D3cold.  But the "!dev_state_saved" condition depends on what the
> driver did.  Why is that important?  Why should we not do the
> following?
>
>   if (pci_dev->current_state != PCI_D3cold)
>     pci_disable_ptm(pci_dev);

We can do this too.  I thought we could skip the power state check if
dev_state_saved was unset, because then we would know that the power
state was not D3cold.  It probably isn't worth the hassle though.
