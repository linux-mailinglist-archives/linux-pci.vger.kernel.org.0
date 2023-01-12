Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8082668497
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 21:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjALUyo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 15:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbjALUx2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 15:53:28 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932AE17581;
        Thu, 12 Jan 2023 12:31:55 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id mp20so1004821ejc.7;
        Thu, 12 Jan 2023 12:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2nFgdDb65kynrrmfmzSLp/jRdwKd3Nk1yZl/VPrHZs=;
        b=DN5b560iNswoycqndzNzb8swfw01ooPIMdVp3pe5EaSOknyKsO59E92VttsBN73Lwt
         iLIVBWyje3HZfwa9FrGsEdiMdBfpqdKizVltKyuo2mUpTix7oUTvOioQGOjpejT31hBb
         8SuG8SP0dNcbDPMvxyaEmz/iEaprz01LPQyYONePTtB5QELDa+Xzti7QfK/kdvXZ7j15
         SagVHfUVg3K8ItGz0TGrSgrL9dBASVfXJKQpRuyLL4WJQXnMMOjkK7odYtWaABNmOO8E
         /liy/AVdcmZZ7gBlBQDh2Wpq+/7UlGV6iAo2ve3js8/GfxtXAKntBSVf8DSEQeRLGVMz
         l0PA==
X-Gm-Message-State: AFqh2kp8+Cv1srM08aZsN5AusUJkje/VBcfvyY00c2HIr7jj47P5qODV
        awFuMc8wWM0+Nvdg8C/CFZI1JxlPfxiuHqD6m6g=
X-Google-Smtp-Source: AMrXdXvN5SBlmpldVVXQjqra/kzAOUvvwIr688rrELNMvTTVMYkAJOEGgxACXyoLu4sLkPSJ8TokhYn7N2hye/e40VY=
X-Received: by 2002:a17:907:75ea:b0:7c0:f118:7e4e with SMTP id
 jz10-20020a17090775ea00b007c0f1187e4emr4485732ejc.478.1673555514054; Thu, 12
 Jan 2023 12:31:54 -0800 (PST)
MIME-Version: 1.0
References: <5659681.DvuYhMxLoT@kreacher> <20230112202132.GA1788706@bhelgaas>
In-Reply-To: <20230112202132.GA1788706@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Jan 2023 21:31:42 +0100
Message-ID: <CAJZ5v0ijTE4A8Q8kLD4xXAqqzEmfXewjtiG7gimg30etk+BKZQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI / ACPI: PM: Take _S0W of the target bridge into
 account in acpi_pci_bridge_d3(()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 12, 2023 at 9:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jan 11, 2023 at 11:38:55AM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is generally questionable to allow a PCI bridge to go into D3 if
> > it has _S0W returning D2 or a shallower power state, so modify
> > acpi_pci_bridge_d3(() to always take the return value of _S0W for the
> > target bridge into accout.  That is, make it return 'false' if _S0W
> > returns D2 or a shallower power state for the target bridge regardless
> > of its ancestor PCIe Root Port properties.  Of course, this also causes
> > 'false' to be returned if the PCIe Root Port itself is the target and
> > its _S0W returns D2 or a shallower power state.
> >
> > However, still allow bridges without _S0W that are power-manageable via
> > ACPI to enter D3 to retain the current code behavior in that case.
> >
> > Link: https://lore.kernel.org/linux-pci/20221031223356.32570-1-mario.limonciello@amd.com/
> > Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2 -> v3:
> >    * Use rpadev for the ACPI companion of the Root Port in acpi_pci_bridge_d3(()
> >      to avoid confusion.
> >    * Make the function evaluating _S0W return the value produced by it or "unknown
> >      state" on errors and let its caller deal with that value.
> >
> > ---
> >  drivers/acpi/device_pm.c |   19 +++++++++++++++++++
> >  drivers/pci/pci-acpi.c   |   45 +++++++++++++++++++++++++++++++--------------
> >  include/acpi/acpi_bus.h  |    1 +
> >  3 files changed, 51 insertions(+), 14 deletions(-)
> >
> > Index: linux-pm/drivers/pci/pci-acpi.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci-acpi.c
> > +++ linux-pm/drivers/pci/pci-acpi.c
> > @@ -976,24 +976,41 @@ bool acpi_pci_power_manageable(struct pc
> >  bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >  {
> >       struct pci_dev *rpdev;
> > -     struct acpi_device *adev;
> > -     acpi_status status;
> > -     unsigned long long state;
> > +     struct acpi_device *adev, *rpadev;
> >       const union acpi_object *obj;
> >
> >       if (acpi_pci_disabled || !dev->is_hotplug_bridge)
> >               return false;
> >
> > -     /* Assume D3 support if the bridge is power-manageable by ACPI. */
> > -     if (acpi_pci_power_manageable(dev))
> > -             return true;
> > +     adev = ACPI_COMPANION(&dev->dev);
> > +     if (adev) {
> > +             /*
> > +              * If the bridge has _S0W, whether or not it can go into D3
> > +              * depends on what is returned by that object.  In particular,
> > +              * if the power state returned by _S0W is D2 or shallower,
> > +              * entering D3 should not be allowed.
> > +              */
> > +             if (acpi_dev_power_state_for_wake(adev) <= ACPI_STATE_D3_HOT)
>
> The comment suggests that this should check for "<= ACPI_STATE_D2"
> (not ACPI_STATE_D3_HOT).  Or is there some subtlety here that I'm
> missing?

No, this is a mistake.  I'll send a v4.
