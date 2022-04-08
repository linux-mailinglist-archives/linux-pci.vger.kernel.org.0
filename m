Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8244F9C72
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 20:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbiDHSXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 14:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiDHSXV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 14:23:21 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC82360437;
        Fri,  8 Apr 2022 11:21:17 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2ebdf6ebd29so34699217b3.2;
        Fri, 08 Apr 2022 11:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCVpHEZAuFYpT8MoYL/wQ4fDYm6F2aWVl7tmD78GJ5A=;
        b=yTdG7iM0rTMFQvDClGza8PQw9GrLpjlYWIfN5vMUi1SM8GpH225/CF+n5bSVpLBfNS
         FiGq7bveFnVFvAV+jVbFI2LUrXnVymDYRRaOKu7a9NEz96xbyGf8qmer/fuaTr/W5zDH
         m5KoVRvnVICOxRmElz2Wuti+6p++rnJSRaIempnXJ/sGNV/J92vuOgMjDFJPkn8aB4Kg
         mLu/7H67XqpDTXmEGnHxIQrdEfIRhdczD8/GOoNv9XyVPevbrZC6TltPxtFUHS8n5WhK
         yEz6ONbxAkG+aX5meV1dzQMVWEHFlLxmhkjyAaylqO1Oc4oBjK88Cnib/kUBS1B31KWh
         +Dvg==
X-Gm-Message-State: AOAM530ApCRRZxBkUGFDNTnSpHs/oyA6snI5ytx4LmYLDVldpJpgKMKY
        YRt1cuGR1uzHZPgmGBvmoMi/nuORPQ103xi64bGMrMjv
X-Google-Smtp-Source: ABdhPJzGh+iKXmN5NP9Y/+KpdVxbwKsYfj7oFxaxISg2qW8gZjldXVGjXW/suZ2XAiJyRtuNMMgiDnTN939LblH5yaw=
X-Received: by 2002:a81:7c45:0:b0:2eb:4759:cc32 with SMTP id
 x66-20020a817c45000000b002eb4759cc32mr17293086ywc.515.1649442076610; Fri, 08
 Apr 2022 11:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <4412361.LvFx2qVVIh@kreacher> <20220407154901.GA239301@bhelgaas>
In-Reply-To: <20220407154901.GA239301@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Apr 2022 20:21:05 +0200
Message-ID: <CAJZ5v0hC1Z6TrRtG8nkDJ4uk=qg=PQ1m6k4W_ho6G2YR2iZ0LQ@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: PM: Power up all devices during runtime resume
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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

On Thu, Apr 7, 2022 at 5:49 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Apr 06, 2022 at 09:00:52PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Currently, endpoint devices may not be powered up entirely during
> > runtime resume that follows a D3hot -> D0 transition of the parent
> > bridge.
> >
> > Namely, even if the power state of an endpoint device, as indicated
> > by its PCI_PM_CTRL register, is D0 after powering up its parent
> > bridge, it may be still necessary to bring its ACPI companion into
> > D0 and that should be done before accessing it.  However, the current
> > code assumes that reading the PCI_PM_CTRL register is sufficient to
> > establish the endpoint device's power state, which may lead to
> > problems.
> >
> > Address that by forcing a power-up of all PCI devices, including the
> > platform firmware part of it, during runtime resume.
> >
> > Link: https://lore.kernel.org/linux-pm/11967527.O9o76ZdvQC@kreacher
> > Fixes: 5775b843a619 ("PCI: Restore config space on runtime resume despite being unbound")
> > Reported-by: Abhishek Sahu <abhsahu@nvidia.com>
> > Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Applied with Mika's reviewed-by to pci/pm for v5.19, thanks!

This doesn't compile when CONFIG_PM_SLEEP in uset, sorry about this.

I'll send a v2, but if you prefer an incremental fix, please let me know.

>
> > ---
> >  drivers/pci/pci-driver.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/pci/pci-driver.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci-driver.c
> > +++ linux-pm/drivers/pci/pci-driver.c
> > @@ -1312,7 +1312,7 @@ static int pci_pm_runtime_resume(struct
> >        * to a driver because although we left it in D0, it may have gone to
> >        * D3cold when the bridge above it runtime suspended.
> >        */
> > -     pci_restore_standard_config(pci_dev);
> > +     pci_pm_default_resume_early(pci_dev);
> >
> >       if (!pci_dev->driver)
> >               return 0;
> >
> >
> >
