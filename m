Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB52B9A6E
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 19:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgKSSNe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 13:13:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46791 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgKSSNd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2020 13:13:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id g19so6160281otp.13;
        Thu, 19 Nov 2020 10:13:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRCdNCjOfunXbAIS7K4tkE2IMIlCbdlGRdRWxA2SgIU=;
        b=Xdugvpfoqt0PLHESs/y2YlIeC5xc9WTVX8Ix87eHFkX5flqTS3glWxTVAxwYkrKyCM
         0lu59pBq+qMCNib71wpJJX53ugMleqFVIgjvK3CRMubJaftm70eObqMqrZH8ohm+cL9v
         3TRq7PEP/DTKBd8PBSD6PxLCBKsofGm+yiZkkcXfztRF/9X7ddcbgHnjUMy8gLKSrmvX
         nHD8DIH+xbSjA3L6hT6/eQbDguyZVjclVF9J+UidFHzEO7stDlaLd6xtQifaqG+IRnyM
         YFTC0ex1bFq0KzVwUcE0SWEyrrKVqPfMoff2CCYUgSP48FOIfcuHUlLoDvJmh2tYVlUy
         ldlg==
X-Gm-Message-State: AOAM530VkLevXwHWbLg4P+MYLhyi+duIP44bzAMalS1tXJj79NQ5Tall
        2TPtMsY2we90W+wppoLcEP0FKeJPOZx4oT3iLi4=
X-Google-Smtp-Source: ABdhPJwiRPjiimByPjBBGnZzxNa++f2UPo5zI1YYZtL4mFWCeBNcbtF/rVxR4NFxBHTRzuryPJSmoe/F8WTtRw16Ep4=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr11558331ota.260.1605809612651;
 Thu, 19 Nov 2020 10:13:32 -0800 (PST)
MIME-Version: 1.0
References: <20201119001822.31617-1-david.e.box@linux.intel.com>
 <20201119001822.31617-2-david.e.box@linux.intel.com> <CAJZ5v0hGhyPySUdabwW5_LhyAKC3A4zdgj7H=55R=Xk3jvt3Yw@mail.gmail.com>
 <cdb520abba97ccf083788ed8ccb44fc042939468.camel@linux.intel.com>
In-Reply-To: <cdb520abba97ccf083788ed8ccb44fc042939468.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Nov 2020 19:13:21 +0100
Message-ID: <CAJZ5v0gyzYEiFWC4qvQZNDUC4wwcXK60mR=zJ9=Bwb27K1F=Ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Disable Precision Time Measurement during suspend
To:     David Box <david.e.box@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <len.brown@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 19, 2020 at 6:45 PM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> On Thu, 2020-11-19 at 13:01 +0100, Rafael J. Wysocki wrote:
> > On Thu, Nov 19, 2020 at 1:17 AM David E. Box
> > <david.e.box@linux.intel.com> wrote:
> > > On Intel client platforms that support suspend-to-idle, like Ice
> > > Lake,
> > > root ports that have Precision Time Management (PTM) enabled can
> > > prevent
> > > the port from being fully power gated, causing higher power
> > > consumption
> > > while suspended.  To prevent this, after saving the PTM control
> > > register,
> > > disable the feature.  The feature will be returned to its previous
> > > state
> > > during restore.
> > >
> > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209361
> > > Reported-by: Len Brown <len.brown@intel.com>
> > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > ---
> > >  drivers/pci/pci.c | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 6fd4ae910a88..a2b40497d443 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/spinlock.h>
> > >  #include <linux/string.h>
> > > +#include <linux/suspend.h>
> > >  #include <linux/log2.h>
> > >  #include <linux/logic_pio.h>
> > >  #include <linux/pm_wakeup.h>
> > > @@ -1543,7 +1544,7 @@ static void pci_save_ptm_state(struct pci_dev
> > > *dev)
> > >  {
> > >         int ptm;
> > >         struct pci_cap_saved_state *save_state;
> > > -       u16 *cap;
> > > +       u16 *cap, ctrl;
> > >
> > >         if (!pci_is_pcie(dev))
> > >                 return;
> > > @@ -1560,6 +1561,17 @@ static void pci_save_ptm_state(struct
> > > pci_dev *dev)
> > >
> > >         cap = (u16 *)&save_state->cap.data[0];
> > >         pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
> > > +
> > > +       /*
> > > +        * On Intel systems that support suspend-to-idle,
> > > additional
> > > +        * power savings can be gained by disabling PTM on root
> > > ports,
> > > +        * as this allows the port to enter a deeper pm state.
> >
> > I would say "There are systems (for example, ...) where the power
> > drawn while suspended can be significantly reduced by disabling PTM
> > on
> > PCIe root ports, as this allows the port to enter a lower-power PM
> > state and the SoC to reach a lower-power idle state as a whole".
>
> Okay.
>
> >
> > > +        */
> > > +       if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&
> >
> > AFAICS the target sleep state doesn't matter here, so I'd skip the
> > check above, but otherwise it LGTM.
>
> The target sleep state doesn't matter so much but that it's suspending
> does. pci_save_state() is called during probe for the root ports (and
> many other pci devices - I'm curious as to why).

I tend to forget about this, sorry.

> So without this check the capability gets disabled on boot.
>

So instead of calling this from here, why don't we invoke the code
below from pci_prepare_to_sleep() and pci_finish_runtime_suspend(),
before enabling wakeup (and it needs to be re-done on failures, eg. by
restoring the cap from the saved copy)?

> > > +           pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> > > +               ctrl = *cap & ~(PCI_PTM_CTRL_ENABLE |
> > > PCI_PTM_CTRL_ROOT);
> > > +               pci_write_config_word(dev, ptm + PCI_PTM_CTRL,
> > > ctrl);
> > > +       }
> > >  }
> > >
> > >  static void pci_restore_ptm_state(struct pci_dev *dev)
> > > --
