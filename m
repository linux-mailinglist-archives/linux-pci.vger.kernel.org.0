Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA52A33BFE2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 16:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCOPeX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 11:34:23 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:33894 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhCOPeO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 11:34:14 -0400
Received: by mail-ot1-f52.google.com with SMTP id n23so7213964otq.1;
        Mon, 15 Mar 2021 08:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2PzQp98xEVljnuInqGfZNpkRUMzLCMEZ5M6TM/sg/0=;
        b=qBerCCiV3UsDsZgvgOxDfEzsfqmXUDUQK3HBe1tQ95dv1tPDCyvnzOSKZ+Sr43glfr
         a9n2GkVti5+kSPrBeAfpJEzSrU6OYodGVXwtgv0LFGd4mUyOoApmchSdFiXa0sKAkKQh
         miouKQqZs7+f0mVWScpFvRxN8XuZCAyUVyjptsN7tnvDvdURoVDpCIwi7JMeaI65gWUc
         T2rp/EVh418R94Ih36RlIzWKKjxewe99PENV9sPu77SgbX62lwsUWkGdgQVyZEeaDFMm
         y1KmOZTezNPfm0nIaL5Wm1bEFmthJcBlpGukkASc+vtSjNtcQDF8lEbpxwJBWe7stJ62
         BOcA==
X-Gm-Message-State: AOAM533o98jipz/LPxH6O72JI2uzvsfiltQYink8xglh6Xu7EntBhXkO
        cgm5ztmcGGanZjuo0su/U0HQnQy3uN1YNgRLtQ0=
X-Google-Smtp-Source: ABdhPJyl/cbr7pq28PHZ/0h31pXlvj6SfsiJtApwzlRSUKiFzC/UHOEFF4rEujy7pXbWO9dTlmsXetPUp2PHgNx7OEE=
X-Received: by 2002:a9d:3422:: with SMTP id v31mr14466855otb.260.1615822453930;
 Mon, 15 Mar 2021 08:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210314000439.3138941-1-luzmaximilian@gmail.com>
In-Reply-To: <20210314000439.3138941-1-luzmaximilian@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 15 Mar 2021 16:34:02 +0100
Message-ID: <CAJZ5v0hY=NgKAU+N_kaya=q3Vk6SnkRTfXuiiP0ttoxHq+pRTA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Run platform power transition on initial D0 entry
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 14, 2021 at 1:06 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> On some devices and platforms, the initial platform (e.g. ACPI) power
> state is not in sync with the power state of the PCI device.
>
> This seems like it is, for all intents and purposes, an issue with the
> device firmware (e.g. ACPI). On some devices, specifically Microsoft
> Surface Books 2 and 3, we encounter ACPI code akin to the following
> power resource, corresponding to a PCI device:
>
>     PowerResource (PRP5, 0x00, 0x0000)
>     {
>         // Initialized to zero, i.e. off. There is no logic for checking
>         // the actual state dynamically.
>         Name (_STA, Zero)
>
>         Method (_ON, 0, Serialized)
>         {
>             // ... code omitted ...
>             _STA = One
>         }
>
>         Method (_OFF, 0, Serialized)
>         {
>             // ... code omitted ...
>             _STA = Zero
>         }
>     }
>
> This resource is initialized to 'off' and does not have any logic for
> checking its actual state, i.e. the state of the corresponding PCI
> device. The stored state of this resource can only be changed by running
> the (platform/ACPI) power transition functions (i.e. _ON and _OFF).

Well, there is _STA that returns "off" initially, so the OS should set
the initial state of the device to D3cold and transition it into D0 as
appropriate (i.e. starting with setting all of the power resources
used by it to "on").

> This means that, at boot, the PCI device power state is out of sync with
> the power state of the corresponding ACPI resource.
>
> During initial bring-up of a PCI device, pci_enable_device_flags()
> updates its PCI core state (from initially 'unknown') by reading from
> its PCI_PM_CTRL register. It does, however, not check if the platform
> (here ACPI) state is in sync with/valid for the actual device state and
> needs updating.

Well, that's inconsistent.

Also, it is rather pointless to update the device's power state at
this point, because nothing between this point and the later
do_pci_enable_device() call in this function requires its
current_state to be up to date AFAICS.

Have you tried to drop the power state update from
pci_enable_device_flags()?  [Note that we're talking about relatively
old code here and it looks like that code is not necessary any more.]

Either it should be possible to do that and all should work, or there
is a good reason to make current_state reflect the real current power
state of the device upfront, but then that should be done by putting
it into D0 diractly at that point rather than later.

Calling pci_power_up(dev) instead of pci_set_power_state(dev, PCI_D0)
when current_state is already 0 only pokes at the power resources,
because pci_raw_set_power_state() will do nothing then, but that is a
rather less-than-straightforward way of doing this.  Moreover, the
ordering of actions mandated by the spec is to set power resources to
"on" first and then write to the PMCSR, not the other way around.
