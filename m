Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFAB3C22BC
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jul 2021 13:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhGILYF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 07:24:05 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:33338 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhGILYF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jul 2021 07:24:05 -0400
Received: by mail-oi1-f180.google.com with SMTP id s17so11888814oij.0;
        Fri, 09 Jul 2021 04:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJBfn8KrookS9VA95B+AE2i8GXpFZrKK3T2F0bIumXM=;
        b=aRc+NklbSTsnfQpicbSPgqTYz7uxH4Q8uLRJtUa32G54awU6QbaW2vgeUK8UvhQ90J
         MCSR0f4lYd9d6vZE+AjP4dflHDTq4VbmFDRNs690cQb0Tm+CQ5cfDAdXF+kvdhTokx4+
         DhaYOncmRGQ4X8IsOUJt0w6kDg8B++en/su8IfnOBVqj03yipqbg67qWWlKp7GRQauNb
         2Z72AY1X0vW+jEQkTWrLjl5U6nr66hm6EQ84me9bmqbXJnOUylwQnbhfytAiAHhajecV
         N996kkk7wKMfbxEkja3FNfh4iDi5i/1PCNIpc8NOQBxxxd+SxcrY8Gs47DORuf1crdK8
         ljUw==
X-Gm-Message-State: AOAM53391wvwXp7Pz6saGQCmMj6BhrJ9dbJX5vchZzi3b7zSsXQ+7Lp2
        IKEGwLKE0lxSYGpjlo0juyzzdXoBybK2/pkjWUE=
X-Google-Smtp-Source: ABdhPJz9yAt/PUrlHk09vA7sJVdy62jMOZClvCnSc027dfScoZVvS7LtBwJ72GxAOGWJR67ndQvr7S5AgSL8Ny9/ozU=
X-Received: by 2002:aca:c457:: with SMTP id u84mr17485471oif.69.1625829681556;
 Fri, 09 Jul 2021 04:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <4327888.LvFx2qVVIh@kreacher> <5327028b-6e0b-e83c-b147-da083a23634c@gmail.com>
In-Reply-To: <5327028b-6e0b-e83c-b147-da083a23634c@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Jul 2021 13:21:09 +0200
Message-ID: <CAJZ5v0iCyLircAL928bA4-+Pd1UtaBcZ-PVRNk3qJScSybzwCQ@mail.gmail.com>
Subject: Re: [PATCH][RFT] PCI: Use pci_update_current_state() in pci_enable_device_flags()
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 8, 2021 at 10:34 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> On 7/8/21 3:25 PM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Updating the current_state field of struct pci_dev the way it is done
> > in pci_enable_device_flags() before calling do_pci_enable_device() may
> > not work.  For example, if the given PCI device depends on an ACPI
> > power resource whose _STA method initially returns 0 ("off"), but the
> > config space of the PCI device is accessible and the power state
> > retrieved from the PCI_PM_CTRL register is D0, the current_state
> > field in the struct pci_dev representing that device will get out of
> > sync with the power.state of its ACPI companion object and that will
> > lead to power management issues going forward.
> >
> > To avoid such issues, make pci_enable_device_flags() call
> > pci_update_current_state() which takes ACPI device power management
> > into account, if present, to retrieve the current power state of the
> > device.
> >
> > Link: https://lore.kernel.org/lkml/20210314000439.3138941-1-luzmaximilian@gmail.com/
> > Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Hi Maximilian,
> >
> > Because commit 4514d991d992 ("PCI: PM: Do not read power state in
> > pci_enable_device_flags()"), the issue addressed by it is back, so
> > we need an alternative way to address it.
> >
> > Can you please check if this patch makes that issue go away?
>
> Hi,
>
> just tested this on v5.13 and it works, thanks! Feel free to add
>
> Tested-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you!
