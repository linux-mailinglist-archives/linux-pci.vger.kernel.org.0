Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763C22B99E9
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 18:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgKSRp1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 12:45:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:40769 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbgKSRp1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 12:45:27 -0500
IronPort-SDR: Hv3h+aFSzqMMN1Ep+T+YHOBl39zlE4s2ZXUCi+Xz21hvT6RmRllrNA5L8LUTBFUrBVuxlt9Qpv
 03hKs7lP9DOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171499596"
X-IronPort-AV: E=Sophos;i="5.78,353,1599548400"; 
   d="scan'208";a="171499596"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 09:45:26 -0800
IronPort-SDR: +bf+G675BRCLA6Z8sHKcXIqKGLu6Q/3eOF0tOWS/rj47s0G1YHVc+SC9cmCacMkZJkbDpyMqH8
 2v3i2j1JDIOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,353,1599548400"; 
   d="scan'208";a="534860651"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 19 Nov 2020 09:45:26 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 7A172580814;
        Thu, 19 Nov 2020 09:45:26 -0800 (PST)
Message-ID: <cdb520abba97ccf083788ed8ccb44fc042939468.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] PCI: Disable Precision Time Measurement during
 suspend
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <len.brown@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 19 Nov 2020 09:45:26 -0800
In-Reply-To: <CAJZ5v0hGhyPySUdabwW5_LhyAKC3A4zdgj7H=55R=Xk3jvt3Yw@mail.gmail.com>
References: <20201119001822.31617-1-david.e.box@linux.intel.com>
         <20201119001822.31617-2-david.e.box@linux.intel.com>
         <CAJZ5v0hGhyPySUdabwW5_LhyAKC3A4zdgj7H=55R=Xk3jvt3Yw@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2020-11-19 at 13:01 +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 19, 2020 at 1:17 AM David E. Box
> <david.e.box@linux.intel.com> wrote:
> > On Intel client platforms that support suspend-to-idle, like Ice
> > Lake,
> > root ports that have Precision Time Management (PTM) enabled can
> > prevent
> > the port from being fully power gated, causing higher power
> > consumption
> > while suspended.  To prevent this, after saving the PTM control
> > register,
> > disable the feature.  The feature will be returned to its previous
> > state
> > during restore.
> > 
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209361
> > Reported-by: Len Brown <len.brown@intel.com>
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  drivers/pci/pci.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 6fd4ae910a88..a2b40497d443 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/module.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/string.h>
> > +#include <linux/suspend.h>
> >  #include <linux/log2.h>
> >  #include <linux/logic_pio.h>
> >  #include <linux/pm_wakeup.h>
> > @@ -1543,7 +1544,7 @@ static void pci_save_ptm_state(struct pci_dev
> > *dev)
> >  {
> >         int ptm;
> >         struct pci_cap_saved_state *save_state;
> > -       u16 *cap;
> > +       u16 *cap, ctrl;
> > 
> >         if (!pci_is_pcie(dev))
> >                 return;
> > @@ -1560,6 +1561,17 @@ static void pci_save_ptm_state(struct
> > pci_dev *dev)
> > 
> >         cap = (u16 *)&save_state->cap.data[0];
> >         pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
> > +
> > +       /*
> > +        * On Intel systems that support suspend-to-idle,
> > additional
> > +        * power savings can be gained by disabling PTM on root
> > ports,
> > +        * as this allows the port to enter a deeper pm state.
> 
> I would say "There are systems (for example, ...) where the power
> drawn while suspended can be significantly reduced by disabling PTM
> on
> PCIe root ports, as this allows the port to enter a lower-power PM
> state and the SoC to reach a lower-power idle state as a whole".

Okay.

> 
> > +        */
> > +       if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&
> 
> AFAICS the target sleep state doesn't matter here, so I'd skip the
> check above, but otherwise it LGTM.

The target sleep state doesn't matter so much but that it's suspending
does. pci_save_state() is called during probe for the root ports (and
many other pci devices - I'm curious as to why). So without this check
the capability gets disabled on boot.

> 
> > +           pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> > +               ctrl = *cap & ~(PCI_PTM_CTRL_ENABLE |
> > PCI_PTM_CTRL_ROOT);
> > +               pci_write_config_word(dev, ptm + PCI_PTM_CTRL,
> > ctrl);
> > +       }
> >  }
> > 
> >  static void pci_restore_ptm_state(struct pci_dev *dev)
> > --

David

