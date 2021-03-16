Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2483C33D4F8
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 14:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhCPNhI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 09:37:08 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:36469 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbhCPNhF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Mar 2021 09:37:05 -0400
Received: by mail-oo1-f54.google.com with SMTP id w1-20020a4adec10000b02901bc77feac3eso1004695oou.3;
        Tue, 16 Mar 2021 06:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhLaOWaIrJwS9w94aLoGXQMXup2Yi5nytxfqyx+Z2eY=;
        b=IO7LDc7W91GvsTqFZISMXxGH7aYEIMV/D7hIS+XmomUl4/rAZ5HpNJVCX2jjPczAt6
         Ol5SdYnz8lsjdPS+z3cIuJ9wie9L12unY+MPLiO0dPpNCiOQ47Vy0IcmL+2vtuYUdB//
         w3FRv+qWxRlI7i5LOTPXGoR/Flya16cI+km8RpzG3T48laNNJRkdUZsDiTpZJjspG6hJ
         Gx9vfY8S++pY74kMaeYr1RKIkm4/yFeDM//WpgtIAsKlO3kyHQQ+2MY1h+4qvNIH5Ycn
         NwYxvpozv8QHbTA5s6VPWaVwSxoWW9kX9hbD1J8zrkL5kqy0LneekMNoDUW8x6D0X/3y
         cGLw==
X-Gm-Message-State: AOAM532dlZkKsFXWjVPkOfizeAGlW/C+i34LAZM+9hOBJobcBIJ1TJFc
        P8qPCvEGfjriTS2YCzV6F4fov2AXeOCX81DLdXI=
X-Google-Smtp-Source: ABdhPJzwQHSmFwhqAsyF7zjgrycMBhrHMnwnbNNkjLhTMtmKEeI2iQWDOfqbB5CPa7+ftrRb8bJxReNbRW3IrP8TOwQ=
X-Received: by 2002:a4a:d781:: with SMTP id c1mr3885934oou.44.1615901824913;
 Tue, 16 Mar 2021 06:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210314000439.3138941-1-luzmaximilian@gmail.com>
 <CAJZ5v0hY=NgKAU+N_kaya=q3Vk6SnkRTfXuiiP0ttoxHq+pRTA@mail.gmail.com> <781f0963-4ce6-74c9-e884-1e57f1ff9673@gmail.com>
In-Reply-To: <781f0963-4ce6-74c9-e884-1e57f1ff9673@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Mar 2021 14:36:52 +0100
Message-ID: <CAJZ5v0g+wkyzrD120yiyyBFjVO=LYS3j0WK1Fi-j+LS5fwgqZg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Run platform power transition on initial D0 entry
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 15, 2021 at 7:28 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> On 3/15/21 4:34 PM, Rafael J. Wysocki wrote:
> > On Sun, Mar 14, 2021 at 1:06 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> >>
> >> On some devices and platforms, the initial platform (e.g. ACPI) power
> >> state is not in sync with the power state of the PCI device.
> >>
> >> This seems like it is, for all intents and purposes, an issue with the
> >> device firmware (e.g. ACPI). On some devices, specifically Microsoft
> >> Surface Books 2 and 3, we encounter ACPI code akin to the following
> >> power resource, corresponding to a PCI device:
> >>
> >>      PowerResource (PRP5, 0x00, 0x0000)
> >>      {
> >>          // Initialized to zero, i.e. off. There is no logic for checking
> >>          // the actual state dynamically.
> >>          Name (_STA, Zero)
> >>
> >>          Method (_ON, 0, Serialized)
> >>          {
> >>              // ... code omitted ...
> >>              _STA = One
> >>          }
> >>
> >>          Method (_OFF, 0, Serialized)
> >>          {
> >>              // ... code omitted ...
> >>              _STA = Zero
> >>          }
> >>      }
> >>
> >> This resource is initialized to 'off' and does not have any logic for
> >> checking its actual state, i.e. the state of the corresponding PCI
> >> device. The stored state of this resource can only be changed by running
> >> the (platform/ACPI) power transition functions (i.e. _ON and _OFF).
> >
> > Well, there is _STA that returns "off" initially, so the OS should set
> > the initial state of the device to D3cold and transition it into D0 as
> > appropriate (i.e. starting with setting all of the power resources
> > used by it to "on").
> >
> >> This means that, at boot, the PCI device power state is out of sync with
> >> the power state of the corresponding ACPI resource.
> >>
> >> During initial bring-up of a PCI device, pci_enable_device_flags()
> >> updates its PCI core state (from initially 'unknown') by reading from
> >> its PCI_PM_CTRL register. It does, however, not check if the platform
> >> (here ACPI) state is in sync with/valid for the actual device state and
> >> needs updating.
> >
> > Well, that's inconsistent.
> >
> > Also, it is rather pointless to update the device's power state at
> > this point, because nothing between this point and the later
> > do_pci_enable_device() call in this function requires its
> > current_state to be up to date AFAICS.
> >
> > Have you tried to drop the power state update from
> > pci_enable_device_flags()?  [Note that we're talking about relatively
> > old code here and it looks like that code is not necessary any more.]
>
> I had not tried this before, as I assumed the comment was still
> relevant. I did test that now and it works! I can't detect any
> regressions.
>
> Do you want to send this in or should I do that?

I'll post it, thanks!
