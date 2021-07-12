Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B413C5F48
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 17:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhGLPdH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 11:33:07 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:44560 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbhGLPdF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 11:33:05 -0400
Received: by mail-ot1-f41.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so19225004otq.11;
        Mon, 12 Jul 2021 08:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIcjLpM0TOpXZTd92NOgPEpW4iOJiRiNmUMPa8oLMG8=;
        b=hRYtu88Uj6zLgLFEge+NF62ZR8FTddxvs/Dx+/7tBY9TnX2o41sMRhjFw8p/LL8WP3
         hwTfZqp8qzxRgjrQTUNjM/6SNXNutsjt8jQKnaRMbXLxP3Onx0ce/drdIqiNkbPH+rK7
         0sxJEzJ9ofFV2AVn/VOm2A1IDNW2x75tmrrow0PcvCZoY6+vTYtO7co9s4bAbauN8QyL
         bTE+SFWFWPsOc1baiRYmAQDGxwKtxxBzeCrV3DoinKrPgVbFu1pkRf3vERiE7WD7YCTT
         3Qra0G5bPjDyNLi+37OZJ74Vw/xpBE+QAPSKpsBq1DKDiZcPZtok4Hs5uPeiHT6mX/fo
         vDkQ==
X-Gm-Message-State: AOAM532Yu9IQsdXQfXMl7ZctVzzspRe1hMeNl84P2D6bo4jL6HYZSYPQ
        tYJlT5XpLb4X8rxWfhl5Oa3bGjcWBOHvB60CF7Y=
X-Google-Smtp-Source: ABdhPJyM8Pg8fUSod2fGtTmWMy+1+OppLgJBSgWphicleWbqL+fCTp26P9e1YMHyR4B7RvoPYwFe2uTmHr/YbHfPV/c=
X-Received: by 2002:a9d:604e:: with SMTP id v14mr41175279otj.260.1626103815664;
 Mon, 12 Jul 2021 08:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <4327888.LvFx2qVVIh@kreacher> <5327028b-6e0b-e83c-b147-da083a23634c@gmail.com>
 <CAJZ5v0iCyLircAL928bA4-+Pd1UtaBcZ-PVRNk3qJScSybzwCQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iCyLircAL928bA4-+Pd1UtaBcZ-PVRNk3qJScSybzwCQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jul 2021 17:30:04 +0200
Message-ID: <CAJZ5v0iw==AbxPR9P=SBWYWKi8PVwp9DafoXe3MTuqA8BVmAsw@mail.gmail.com>
Subject: Re: [PATCH][RFT] PCI: Use pci_update_current_state() in pci_enable_device_flags()
To:     Michael <phyre@rogers.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 9, 2021 at 1:21 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jul 8, 2021 at 10:34 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> >
> > On 7/8/21 3:25 PM, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Updating the current_state field of struct pci_dev the way it is done
> > > in pci_enable_device_flags() before calling do_pci_enable_device() may
> > > not work.  For example, if the given PCI device depends on an ACPI
> > > power resource whose _STA method initially returns 0 ("off"), but the
> > > config space of the PCI device is accessible and the power state
> > > retrieved from the PCI_PM_CTRL register is D0, the current_state
> > > field in the struct pci_dev representing that device will get out of
> > > sync with the power.state of its ACPI companion object and that will
> > > lead to power management issues going forward.
> > >
> > > To avoid such issues, make pci_enable_device_flags() call
> > > pci_update_current_state() which takes ACPI device power management
> > > into account, if present, to retrieve the current power state of the
> > > device.
> > >
> > > Link: https://lore.kernel.org/lkml/20210314000439.3138941-1-luzmaximilian@gmail.com/
> > > Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > Hi Maximilian,
> > >
> > > Because commit 4514d991d992 ("PCI: PM: Do not read power state in
> > > pci_enable_device_flags()"), the issue addressed by it is back, so
> > > we need an alternative way to address it.
> > >
> > > Can you please check if this patch makes that issue go away?
> >
> > Hi,
> >
> > just tested this on v5.13 and it works, thanks! Feel free to add
> >
> > Tested-by: Maximilian Luz <luzmaximilian@gmail.com>

Michael, Salvatore, since this alternative to commit 4514d991d992
works for Maximilian, I'm going to queue it up for 5.15 (barring any
objections from Bjorn), so I would appreciate it if you could test it
and let me know whether or not there were any problems with it.

The patch can be downloaded from
https://patchwork.kernel.org/project/linux-pm/patch/4327888.LvFx2qVVIh@kreacher

Thanks!
