Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5571F5A67FB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 18:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiH3QRr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 12:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiH3QRq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 12:17:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3CD9A965;
        Tue, 30 Aug 2022 09:17:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33964B81CD4;
        Tue, 30 Aug 2022 16:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFCCC433C1;
        Tue, 30 Aug 2022 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661876262;
        bh=DSrVqL1VD3WM18Xm2UsNFG860qRy8Dj2FnWp76OHsZ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pjYn6czElsD94jyIbkijnC7xpBdqszyie5eTJWsdxwH4hXVGkAh4lkJbRPoWRwWqV
         R3WwWajEbk/uJo+Nr2fBCDrHKRyQWk0oPq6XhsWDNpINX4PjTiZ8I6JrrUskXJZlap
         XNX0wqhzibFIRfQLgSQ5pqhbs8/mHKrx54gHUc7TlA9ATD7V6STEL3Ipgb5KFUi6h2
         T9SxrdZr5V8EoxrddAjdmR724ii7QJuglAUJ+vI1tuNoMh0D9tKaXPMi4GNNttzavU
         daJCUHPk78+pFtYt+9CGgByExF10rzrAjFpxjC0KpoNWnVUVw9oXrBE9Xal78j17nX
         C4W0d6MtGfifQ==
Date:   Tue, 30 Aug 2022 11:17:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RESEND PATCH v3 1/2] PCI/PM: refactor pci_pm_suspend_noirq()
Message-ID: <20220830161741.GA105724@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hhc+n+WbLCxbJ2VPSWj0RAy4AM+pvqy8eiAJVtBecVWg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 30, 2022 at 01:44:43PM +0200, Rafael J. Wysocki wrote:
> Hi Bjorn,
> 
> On Tue, Aug 30, 2022 at 12:49 PM Rajvi Jingar
> <rajvi.jingar@linux.intel.com> wrote:
> >
> > The state of the device is saved during pci_pm_suspend_noirq(), if it
> > has not already been saved, regardless of the skip_bus_pm flag value. So
> > skip_bus_pm check is removed before saving the device state.
> >
> > Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> I have reviewed this and the [2/2] already and they are clear
> improvements to me.
> 
> Do you have any concerns regarding any of them?

Since the log doesn't mention fixing a problem, I guess this one is
only a simplification, right?  It looks functionally equivalent to me.

> If not, do you want me to pick them up or do you plan to take care of
> them yourself?

Let me take them; I want to at least wrap the comment to align with
the rest of the file.

> > ---
> >  v1->v2: no change
> >  v2->v3: no change

Why are we bumping the version numbers if there's truly no change?

> > ---
> >  drivers/pci/pci-driver.c | 18 ++++++------------
> >  1 file changed, 6 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 49238ddd39ee..1f64de3e5280 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -867,20 +867,14 @@ static int pci_pm_suspend_noirq(struct device *dev)
> >                 }
> >         }
> >
> > -       if (pci_dev->skip_bus_pm) {
> > +       if (!pci_dev->state_saved) {
> > +               pci_save_state(pci_dev);
> >                 /*
> > -                * Either the device is a bridge with a child in D0 below it, or
> > -                * the function is running for the second time in a row without
> > -                * going through full resume, which is possible only during
> > -                * suspend-to-idle in a spurious wakeup case.  The device should
> > -                * be in D0 at this point, but if it is a bridge, it may be
> > -                * necessary to save its state.
> > +                * If the device is a bridge with a child in D0 below it, it needs to
> > +                * stay in D0, so check skip_bus_pm to avoid putting it into a
> > +                * low-power state in that case.
> >                  */
> > -               if (!pci_dev->state_saved)
> > -                       pci_save_state(pci_dev);
> > -       } else if (!pci_dev->state_saved) {
> > -               pci_save_state(pci_dev);
> > -               if (pci_power_manageable(pci_dev))
> > +               if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
> >                         pci_prepare_to_sleep(pci_dev);
> >         }
> >
> > --
> > 2.25.1
> >
