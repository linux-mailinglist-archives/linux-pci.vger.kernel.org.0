Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9AA513CA8
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 22:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351817AbiD1UeI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 16:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349078AbiD1UeG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 16:34:06 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB7FC0D3C;
        Thu, 28 Apr 2022 13:30:50 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id y2so11075989ybi.7;
        Thu, 28 Apr 2022 13:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSGOnYTcc5ZEbyXrmCTwPn3swHJvidZ0wfFFy4W9DxE=;
        b=JAZVq1yf4shuv61SA0wIQ8MymZvvQNl3J2Ku3VJNyBVK79/T2e0OVVK24awmHR3PFR
         5NDZ2cUiOxWiXHca4xGSs70ka31dRmSttNkHY9hmC5q6EwQFc2thgwmzyPVWEC3RrGvC
         Q686maKmbyDKx8CTisTQ179g2HoU22DRIDRL6dZibIa6HVoa5QjNAPutrA/qQRORD+TT
         pf4XEbqdDlTSDk4qF4gKf7LnkUZl6LIEd35Y+QI2xYZMPvbCWLjEAoxv7iYv0STysJdo
         c1QjzcRffdPKw7T3YWjcsbpDVeHbeH5KhFqh5H6IrgspZs+z0u57LuaR1fA6IqhVvdtM
         MnWA==
X-Gm-Message-State: AOAM533b83DmVf60f+Di8D9siZFkwuEqboLCGAHeMP7EgG8IjC7zJvdA
        0cyImo/xUGMFzAaN5/lIBPrL/Otmj+cck856Zew=
X-Google-Smtp-Source: ABdhPJyok7JCeyk4IsE+a/CFQvlzuPTnIbkp7HWU7XD1rXNrzQY+xxfTnnOuNS08Pt7JaVKHhYUurgYAfGWjq/2Tyt8=
X-Received: by 2002:a25:da84:0:b0:648:423e:57b0 with SMTP id
 n126-20020a25da84000000b00648423e57b0mr24541320ybf.137.1651177849779; Thu, 28
 Apr 2022 13:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220428142854.1065953-1-gregkh@linuxfoundation.org>
 <20220428155858.GA14614@bhelgaas> <Ymq/W+KcWD9DKQr/@kroah.com> <CAJZ5v0hCiO6_deYnUK-5pfqE+fy1XLSUiBvkBgWw2nbqu9ggXA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hCiO6_deYnUK-5pfqE+fy1XLSUiBvkBgWw2nbqu9ggXA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Apr 2022 22:30:38 +0200
Message-ID: <CAJZ5v0itRry98=7X=NOmituD3VH=GYdY3REtrhx3ubH0wf=ckw@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: do not reference a pci device after it has been released
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        whitehat002 <hackyzh002@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 28, 2022 at 10:15 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Apr 28, 2022 at 6:22 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 28, 2022 at 10:58:58AM -0500, Bjorn Helgaas wrote:
> > > On Thu, Apr 28, 2022 at 04:28:53PM +0200, Greg Kroah-Hartman wrote:
> > > > In acpi_get_pci_dev(), the debugging message for when a PCI bridge is
> > > > not found uses a pointer to a pci device whose reference has just been
> > > > dropped.  The chance that this really is a device that is now been
> > > > removed from the system is almost impossible to happen, but to be safe,
> > > > let's print out the debugging message based on the acpi root device
> > > > which we do have a valid reference to at the moment.
> > >
> > > This code was added by 497fb54f578e ("ACPI / PCI: Fix NULL pointer
> > > dereference in acpi_get_pci_dev() (rev. 2)").  Not sure if it's worth
> > > a Fixes: tag.
> >
> > Can't hurt, I'll add it for the v2 based on this review.
> >
> > >
> > > acpi_get_pci_dev() is used by only five callers, three of which are
> > > video/backlight related.  I'm always skeptical of one-off interfaces
> > > like this, but I don't know enough to propose any refactoring or other
> > > alternatives.
> > >
> > > I'll leave this for Rafael, but if I were applying I would silently
> > > touch up the subject to match convention:
> > >
> > >   PCI/ACPI: Do not reference PCI device after it has been released
> >
> > Much simpler, thanks.
> >
> > >
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > Cc: Len Brown <lenb@kernel.org>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Cc: linux-acpi@vger.kernel.org
> > > > Reported-by: whitehat002 <hackyzh002@gmail.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >  drivers/acpi/pci_root.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > > index 6f9e75d14808..ecda378dbc09 100644
> > > > --- a/drivers/acpi/pci_root.c
> > > > +++ b/drivers/acpi/pci_root.c
> > > > @@ -303,7 +303,8 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
> > > >              * case pdev->subordinate will be NULL for the parent.
> > > >              */
> > > >             if (!pbus) {
> > > > -                   dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
> > > > +                   dev_dbg(&root->device->dev,
> > > > +                           "dev %d, function %d is not a PCI-to-PCI bridge\n", dev, fn);
> > >
> > > This should use "%02x.%d" to be consistent with the dev_set_name() in
> > > pci_setup_device().
> >
> > Ah, missed that, will change it and send out a new version tomorrow.
>
> I would make the change below (modulo the gmail-induced wthite space
> breakage), though.

That said ->

> ---
>  drivers/acpi/pci_root.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/pci_root.c
> +++ linux-pm/drivers/acpi/pci_root.c
> @@ -295,8 +295,6 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
>              break;
>
>          pbus = pdev->subordinate;
> -        pci_dev_put(pdev);
> -
>          /*
>           * This function may be called for a non-PCI device that has a
>           * PCI parent (eg. a disk under a PCI SATA controller).  In that
> @@ -304,9 +302,12 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
>           */
>          if (!pbus) {
>              dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
> +            pci_dev_put(pdev);
>              pdev = NULL;
>              break;
>          }
> +
> +        pci_dev_put(pdev);

-> we are going to use pbus after this and it is pdev->subordinate
which cannot survive without pdev AFAICS.

Are we not concerned about this case?

>      }
>  out:
>      list_for_each_entry_safe(node, tmp, &device_list, node)
