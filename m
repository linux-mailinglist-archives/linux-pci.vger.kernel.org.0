Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382C950E86A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Apr 2022 20:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbiDYSmi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 14:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiDYSmW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 14:42:22 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EBA47AC3;
        Mon, 25 Apr 2022 11:39:18 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2f7d19cac0bso51559667b3.13;
        Mon, 25 Apr 2022 11:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qK8e2AVrSefevGs2imvyVDDkPKL0eZ2yImHKmj2kieU=;
        b=hiIh9yliRYgIIqZdaqIq91nhnKPeMl6dnP+7PltevRma+jXQ10CJpo8IIiAz57Tkll
         sJhzZY54q+Y56Z4XGA3ZyR17whxkUbrjP519rv/UsU2T1RVPRWDJc2cpb7Qji5/p92Iv
         C7IuMr0VSuT/zsDI4qRE3RcuhhmfFJKckci7O4doM+1STycvO4pQP0Czu0WcNbmR7V/6
         qGhcjl91XHoJ+QkbQW/Yzh/2hX89w0DT8sPibuykEWIIRTD3Rj3y2ricg65IzF5E3v/J
         kAreLplkGv0kgBdim6Ij6NFi0llv8FhHTzFDMf9xJO1At4f5pRpp+ICYNIM/iI6beObA
         BZ0Q==
X-Gm-Message-State: AOAM5339X2GHeZTNqnAW3eYApG60w6mQDuBvthxvbthzyQXVpBVevaDI
        R8TPVagWlhKKAap/jAzuMyCV639G7Wy4+iKSmgY=
X-Google-Smtp-Source: ABdhPJyX2wtgcldMFdGQD6xuBRzIvUcLOck00Bh9QMuV5obcAZBrDOa4Dhb+1z3doxcjU9Q/k7OQjfZ8azxMw1ZuAQc=
X-Received: by 2002:a81:36cf:0:b0:2e5:2597:a026 with SMTP id
 d198-20020a8136cf000000b002e52597a026mr18178120ywa.301.1650911956879; Mon, 25
 Apr 2022 11:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220423150132.GA1552054@bhelgaas> <44ebf450aa3300e02aba6ec009d8bea20c0fc535.camel@linux.intel.com>
In-Reply-To: <44ebf450aa3300e02aba6ec009d8bea20c0fc535.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Apr 2022 20:39:05 +0200
Message-ID: <CAJZ5v0hs1HPaJNZticZfxz+CeAVuq-Rrw7J50-wv6-wWn5L_2Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
To:     David Box <david.e.box@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Jingar, Rajvi" <rajvi.jingar@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "koba.ko@canonical.com" <koba.ko@canonical.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 25, 2022 at 8:33 PM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> On Sat, 2022-04-23 at 10:01 -0500, Bjorn Helgaas wrote:
> > On Sat, Apr 23, 2022 at 12:43:14AM +0000, Jingar, Rajvi wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > On Thu, Apr 14, 2022 at 07:54:02PM +0200, Rafael J. Wysocki wrote:
> > > > > On 3/25/2022 8:50 PM, Rajvi Jingar wrote:
> > > > > > For the PCIe devices (like nvme) that do not go into D3 state still
> > > > > > need to
> > > > > > disable PTM on PCIe root ports to allow the port to enter a lower-
> > > > > > power PM
> > > > > > state and the SoC to reach a lower-power idle state as a whole. Move
> > > > > > the
> > > > > > pci_disable_ptm() out of pci_prepare_to_sleep() as this code path is
> > > > > > not
> > > > > > followed for devices that do not go into D3. This patch fixes the
> > > > > > issue
> > > > > > seen on Dell XPS 9300 with Ice Lake CPU and Dell Precision 5530 with
> > > > > > Coffee
> > > > > > Lake CPU platforms to get improved residency in low power idle states.
> > > > > >
> > > > > > Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
> > > > > > Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
> > > > > > Suggested-by: David E. Box <david.e.box@linux.intel.com>
> > > > > > ---
> > > > > >   drivers/pci/pci-driver.c | 10 ++++++++++
> > > > > >   drivers/pci/pci.c        | 10 ----------
> > > > > >   2 files changed, 10 insertions(+), 10 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > > > > index 8b55a90126a2..ab733374a260 100644
> > > > > > --- a/drivers/pci/pci-driver.c
> > > > > > +++ b/drivers/pci/pci-driver.c
> > > > > > @@ -847,6 +847,16 @@ static int pci_pm_suspend_noirq(struct device
> > > > > > *dev)
> > > > > >       if (!pci_dev->state_saved) {
> > > > > >               pci_save_state(pci_dev);
> > > > > > +             /*
> > > > > > +              * There are systems (for example, Intel mobile chips
> > > > > > since
> > > > Coffee
> > > > > > +              * Lake) where the power drawn while suspended can be
> > > > significantly
> > > > > > +              * reduced by disabling PTM on PCIe root ports as this
> > > > > > allows the
> > > > > > +              * port to enter a lower-power PM state and the SoC to
> > > > > > reach a
> > > > > > +              * lower-power idle state as a whole.
> > > > > > +              */
> > > > > > +             if (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT)
> > > > > > +                     pci_disable_ptm(pci_dev);
> > > >
> > > > Why is disabling PTM dependent on pci_dev->state_saved?  The point of
> > > > this is to change the behavior of the device, and it seems like we
> > > > want to do that regardless of whether the driver has used
> > > > pci_save_state().
> > >
> > > Because we use the saved state to restore PTM on the root port.
> > > And it's under this condition that the root port state gets saved.
> >
> > Yes, I understand that pci_restore_ptm_state() depends on a previous
> > call to pci_save_ptm_state().
> >
> > The point I'm trying to make is that pci_disable_ptm() changes the
> > state of the device, and that state change should not depend on
> > whether the driver has used pci_save_state().
>
> We do it here because D3 depends on whether the device state was saved by the
> driver.
>
>         if (!pci_dev->state_saved) {
>                 pci_save_state(pci_dev);
>
>                 /* disable PTM here */
>
>                 if (pci_power_manageable(pci_dev))
>                         pci_prepare_to_sleep(pci_dev);
>         }
>
>
> If we disable PTM before the check, we will have saved "PTM disabled" as the
> restore state. And we can't do it after the check as the device will be in D3.
>
> As to disabling PTM on all devices, I see no problem with this, but the
> reasoning is different. We disabled the root port PTM for power savings.

Right.  As per the comment explaining why it is disabled.

> >
> > When we're putting a device into a low-power state, I think we want to
> > disable PTM *always*, no matter what the driver did.  And I think we
> > want to do it for all devices, not just Root Ports.
> >
> > Bjorn
>
