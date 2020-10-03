Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691C52821E1
	for <lists+linux-pci@lfdr.de>; Sat,  3 Oct 2020 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJCHFt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Oct 2020 03:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJCHFs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Oct 2020 03:05:48 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F09C0613D0;
        Sat,  3 Oct 2020 00:05:48 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u8so4791375ejg.1;
        Sat, 03 Oct 2020 00:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJyOcOKILBJdWGFJmI1yQoUhibY5AAXXh2Y4ApfaMWE=;
        b=AZD7OG/+LqTNmUAFpueGqp7AJ+zOuQmlmqEWDJbKcdCXjxTGHZL0KcgszQ0z7ovAMH
         ev0DM9g6Glb8goNvE5YELOhqxd129DqHqlE77+jbBfzVXQct2096+NQoj6DxqvDFWLQT
         SvXBnSzok9IU/IX6ccM2eOQdWzd8hayx6FPtcdc2BVmmo+c8wx9vDb8ED6cdibU9sC02
         sxGU7cO7cGbNTONruIufd2N04t7RV+a46Q1picwtxhO6mxjz2mCrHFKWVLaAwYgKhekK
         ygt7OFtNEmcG9tVQntO8KuG9S7IllexJ8G1qGP7JCalsR5GY4mK/puK0KvRby6s8p9og
         Dvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJyOcOKILBJdWGFJmI1yQoUhibY5AAXXh2Y4ApfaMWE=;
        b=f+4FjSn10Yy87MeyvGOKRhgDNxWoILTtVNLbqYTLzPo6f2WnXYoxFFQYFxvhQM8iiK
         hbGPp/0n01Gk9vfw/+da1bU/S9eQZLyv5NUWF07og8WwEp0QZIWMNahz1SdRvDysNcum
         65dQymbGyE5eQ8y4h2fe6UncDFt/PHupN+z7HYLviYF5kME/YQicYDoVqJXnXznvYcrW
         mNeTpChEd/J74iOT6FsCZm8odFo220v0s5LecPZwpmVBStvn+0u0ANwpfElmU3S90JU6
         3QU1hP1bTZW62paO8ByVDdgG2j1+TCIXtlI3xf5NDWaOytt1FcJQ84Jy5fiWKAw3jQRE
         Nn2g==
X-Gm-Message-State: AOAM530hn4k5O/B9gxzvSQd/LHJ7ZJjHkCE5gAyH24MrWKOwi35Jf/Bd
        vHl5BWrkabpJmtT4FyEU0K6YGEsa737Df5p/RUo=
X-Google-Smtp-Source: ABdhPJyRdaEBSpZ4tYSMUGSfEnrZX3HOFbRHaf79cu2SKJZlojw4l+3UaJaTvrA4l2bfHrkRLjE0FvsB7w/K5ntiQIM=
X-Received: by 2002:a17:906:30c5:: with SMTP id b5mr5655000ejb.98.1601708747130;
 Sat, 03 Oct 2020 00:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200930070537.30982-5-haifeng.zhao@intel.com> <20201002172913.GA2809822@bjorn-Precision-5520>
In-Reply-To: <20201002172913.GA2809822@bjorn-Precision-5520>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Sat, 3 Oct 2020 15:05:35 +0800
Message-ID: <CAKF3qh2b4kjQ348ukD1fv6zcYn55Es4wbwJh2DiKtBL_G+PYjg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] PCI: only return true when dev io state is really changed
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
        ashok.raj@linux.intel.com,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        Sinan Kaya <okaya@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

On Sat, Oct 3, 2020 at 1:29 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Sinan]
>
> On Wed, Sep 30, 2020 at 03:05:36AM -0400, Ethan Zhao wrote:
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
> > when dev->error_state is changed.
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
> >
> >  drivers/pci/pci.h | 37 +++++--------------------------------
> >  1 file changed, 5 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 455b32187abd..f2beeaeda321 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -359,39 +359,12 @@ struct pci_sriov {
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
> > +     if (dev->error_state == new)
> > +             return false;
> > +
> > +     dev->error_state = new;
> > +     return true;
> >  }
>
> IIUC this changes the behavior of the function, but it's difficult to
> analyze because it does a lot of simplification at the same time.
>
> Please consider the following, which is intended to simplify the
> function while preserving the behavior (but please verify; it's been a
> long time since I looked at this).  Then maybe see how your patch
> could be done on top of this?
>
> Alternatively, come up with your own simplification patch + the
> functionality change.
>
>
> commit 983d9b1f8177 ("PCI/ERR: Simplify pci_dev_set_io_state()")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue May 19 12:28:57 2020 -0500
>
>     PCI/ERR: Simplify pci_dev_set_io_state()
>
>     Truth table:
>
>                                   requested new state
>       current          ------------------------------------------
>       state            normal         frozen         perm_failure
>       ------------  +  -------------  -------------  ------------
>       normal        |  normal         frozen         perm_failure
>       frozen        |  normal         frozen         perm_failure
>       perm_failure  |  perm_failure*  perm_failure*  perm_failure
>
>       * "not changed", returns false
>
>     No functional change intended.
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 6d3f75867106..81408552f7c9 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -358,39 +358,21 @@ struct pci_sriov {
>  static inline bool pci_dev_set_io_state(struct pci_dev *dev,
>                                         pci_channel_state_t new)
>  {
> -       bool changed = false;
> -
>         device_lock_assert(&dev->dev);
> -       switch (new) {
> -       case pci_channel_io_perm_failure:
> -               switch (dev->error_state) {
> -               case pci_channel_io_frozen:
> -               case pci_channel_io_normal:
> -               case pci_channel_io_perm_failure:
> -                       changed = true;
> -                       break;
> -               }
> -               break;
> -       case pci_channel_io_frozen:
> -               switch (dev->error_state) {
> -               case pci_channel_io_frozen:
> -               case pci_channel_io_normal:
> -                       changed = true;
> -                       break;
> -               }
> -               break;
> -       case pci_channel_io_normal:
> -               switch (dev->error_state) {
> -               case pci_channel_io_frozen:
> -               case pci_channel_io_normal:
> -                       changed = true;
> -                       break;
> -               }
> -               break;
> +
> +       /* Can always put a device in perm_failure state */
> +       if (new == pci_channel_io_perm_failure) {
> +               dev->error_state == pci_channel_io_perm_failure;
> +               return true;
>         }
> -       if (changed)
> -               dev->error_state = new;
> -       return changed;
> +
> +       /* If already in perm_failure, can't set to normal or frozen */
> +       if (dev->error_state == pci_channel_io_perm_failure)
> +               return false;
            This line goes to the first.
> +
> +       /* Can always change normal to frozen or vice versa */
> +       dev->error_state = new;
> +       return true;
>  }
Per code grepping,  there are two kinds of cases
pci_dev_set_io_state() are called.
1. doesn't care about the return value, just set it to
pci_chnnel_io_perm_failure.
     and later handling depends on dev->error_state,  whatever the
value changed or not.
    pciehp_unconfigure_device()
     -> pci_walk_bus()
         -> pci_dev_set_disconnected()
              ->pci_dev_set_io_state()  with pci_chnnel_io_perm_failure

2.  cares about the return value or the dev->error_state is changed or not. and
   the later handling also depends on if the value of dev->error_state
is changed or not.

    pcie_do_recovery()
    ->pci_walk_bus()
        ->report_frozen_detected()
            ->report_error_detected()
                ->pci_dev_set_io_state()   with pci_channel_io_frozen.

    This case, if the original value was pci_channel_io_frozen, no
need to set it again
     and say it is *changed*.   ----- return true only it is really changed.

    pcie_do_recovery()
    ->pci_walk_bus()
        ->report_resume()
            ->pcI_dev_set_ios_state() with pci_channel_io_normal.

   The same.

    pcie_do_recovery()
    ->pci_walk_bus()
        ->report_normal_detected() with pci_channel_io_normal

    The same.

    I will combat the 'Truth Table'  to keep the original functions
and let it return true
    only when it really changes to avoid re-enter the later handling process.

    Will send v7 for your review.

   Thanks,
    Ethan
>
>  static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
