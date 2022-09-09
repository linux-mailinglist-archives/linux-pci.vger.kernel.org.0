Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F395B30D5
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 09:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiIIHrk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 03:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiIIHrP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 03:47:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4387E290D;
        Fri,  9 Sep 2022 00:43:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA1BE61ED4;
        Fri,  9 Sep 2022 07:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D795EC433D7;
        Fri,  9 Sep 2022 07:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662709376;
        bh=fX3uAg8WI8sIS3BxSEy1dFAlMXqykzIyR3bPWIiiy5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9MJfu/DyopZa2FrUTmYMsJLSqL4s07q/tY2zzTNmMMYpBIMFKpCddCHUschDpy27
         A6u8V5jeBRM/Aqd/GxAIZvNo73euiWznVWH8zfWUtMDthIlEduk/Coa80E3AQ11+yj
         1lwf1BAGErjSRmykkjR2NCLyhKCoMPtfsl28KXxE=
Date:   Fri, 9 Sep 2022 09:42:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        whitehat002 <hackyzh002@gmail.com>
Subject: Re: [PATCH] PCI/ACPI: do not reference a pci device after it has
 been released
Message-ID: <YxrufXoPZnKCxqRP@kroah.com>
References: <20220428142854.1065953-1-gregkh@linuxfoundation.org>
 <20220428155858.GA14614@bhelgaas>
 <Ymq/W+KcWD9DKQr/@kroah.com>
 <CAJZ5v0hCiO6_deYnUK-5pfqE+fy1XLSUiBvkBgWw2nbqu9ggXA@mail.gmail.com>
 <CAJZ5v0itRry98=7X=NOmituD3VH=GYdY3REtrhx3ubH0wf=ckw@mail.gmail.com>
 <YrnHrF8WLy4296Z1@kroah.com>
 <CAJZ5v0hfdnRg0EqG2Zcp9=Kjq+P1NC45iudatisVL_G=QjOC+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hfdnRg0EqG2Zcp9=Kjq+P1NC45iudatisVL_G=QjOC+A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 27, 2022 at 06:37:06PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 27, 2022 at 5:07 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 28, 2022 at 10:30:38PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Apr 28, 2022 at 10:15 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Apr 28, 2022 at 6:22 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Thu, Apr 28, 2022 at 10:58:58AM -0500, Bjorn Helgaas wrote:
> > > > > > On Thu, Apr 28, 2022 at 04:28:53PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > In acpi_get_pci_dev(), the debugging message for when a PCI bridge is
> > > > > > > not found uses a pointer to a pci device whose reference has just been
> > > > > > > dropped.  The chance that this really is a device that is now been
> > > > > > > removed from the system is almost impossible to happen, but to be safe,
> > > > > > > let's print out the debugging message based on the acpi root device
> > > > > > > which we do have a valid reference to at the moment.
> > > > > >
> > > > > > This code was added by 497fb54f578e ("ACPI / PCI: Fix NULL pointer
> > > > > > dereference in acpi_get_pci_dev() (rev. 2)").  Not sure if it's worth
> > > > > > a Fixes: tag.
> > > > >
> > > > > Can't hurt, I'll add it for the v2 based on this review.
> > > > >
> > > > > >
> > > > > > acpi_get_pci_dev() is used by only five callers, three of which are
> > > > > > video/backlight related.  I'm always skeptical of one-off interfaces
> > > > > > like this, but I don't know enough to propose any refactoring or other
> > > > > > alternatives.
> > > > > >
> > > > > > I'll leave this for Rafael, but if I were applying I would silently
> > > > > > touch up the subject to match convention:
> > > > > >
> > > > > >   PCI/ACPI: Do not reference PCI device after it has been released
> > > > >
> > > > > Much simpler, thanks.
> > > > >
> > > > > >
> > > > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > > > > Cc: Len Brown <lenb@kernel.org>
> > > > > > > Cc: linux-pci@vger.kernel.org
> > > > > > > Cc: linux-acpi@vger.kernel.org
> > > > > > > Reported-by: whitehat002 <hackyzh002@gmail.com>
> > > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > ---
> > > > > > >  drivers/acpi/pci_root.c | 3 ++-
> > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > > > > > index 6f9e75d14808..ecda378dbc09 100644
> > > > > > > --- a/drivers/acpi/pci_root.c
> > > > > > > +++ b/drivers/acpi/pci_root.c
> > > > > > > @@ -303,7 +303,8 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
> > > > > > >              * case pdev->subordinate will be NULL for the parent.
> > > > > > >              */
> > > > > > >             if (!pbus) {
> > > > > > > -                   dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
> > > > > > > +                   dev_dbg(&root->device->dev,
> > > > > > > +                           "dev %d, function %d is not a PCI-to-PCI bridge\n", dev, fn);
> > > > > >
> > > > > > This should use "%02x.%d" to be consistent with the dev_set_name() in
> > > > > > pci_setup_device().
> > > > >
> > > > > Ah, missed that, will change it and send out a new version tomorrow.
> > > >
> > > > I would make the change below (modulo the gmail-induced wthite space
> > > > breakage), though.
> > >
> > > That said ->
> > >
> > > > ---
> > > >  drivers/acpi/pci_root.c |    5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > Index: linux-pm/drivers/acpi/pci_root.c
> > > > ===================================================================
> > > > --- linux-pm.orig/drivers/acpi/pci_root.c
> > > > +++ linux-pm/drivers/acpi/pci_root.c
> > > > @@ -295,8 +295,6 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
> > > >              break;
> > > >
> > > >          pbus = pdev->subordinate;
> > > > -        pci_dev_put(pdev);
> > > > -
> > > >          /*
> > > >           * This function may be called for a non-PCI device that has a
> > > >           * PCI parent (eg. a disk under a PCI SATA controller).  In that
> > > > @@ -304,9 +302,12 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
> > > >           */
> > > >          if (!pbus) {
> > > >              dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
> > > > +            pci_dev_put(pdev);
> > > >              pdev = NULL;
> > > >              break;
> > > >          }
> > > > +
> > > > +        pci_dev_put(pdev);
> > >
> > > -> we are going to use pbus after this and it is pdev->subordinate
> > > which cannot survive without pdev AFAICS.
> > >
> > > Are we not concerned about this case?
> >
> > Good point.
> >
> > whitehat002, any ideas?  You found this issue but it really looks like
> > it is not anything that can ever be hit, so how far do you want to go to
> > unwind it?
> 
> I have an idea, sorry for the delay here.
> 
> I should be ready to post something tomorrow.

Was this ever posted?

thanks,

greg k-h
