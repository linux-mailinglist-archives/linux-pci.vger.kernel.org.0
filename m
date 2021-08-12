Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9C93E9DE4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 07:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhHLFUo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 01:20:44 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:57024
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233995AbhHLFUn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 01:20:43 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 57BBB40644
        for <linux-pci@vger.kernel.org>; Thu, 12 Aug 2021 05:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628745618;
        bh=y53JKgE+GbCZ7nxa4ybqSQLIhghBQQHZOHkhwGSHjJg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Z1WPRsv3tXQaLNiOmnDaycwK7qMOefz1ozU+3yKubuzwDyEp2w/CV1bJdNBzfFDto
         kSNJQ5bi0oSy3ZAgkSeNlDfi85qByqbwVJLjl515+E08SY6wrqr9cF5R+n8mgNzZjS
         DVbBqifU5k23L3MCp+x79Au+8++FiiBhBaktsfebD9VgcYZEEdyPdbyKvMJgqlVjX3
         TtR2V0K8jySHas4IiXv4Zs3SzFmqSbCj0Kd1YnSwe0cNDJxRhRKfQkWyec8bCZ6jGL
         6vDaQcLbBeJ4T9FwLdi3LLEIP0lIXfFWuWslpu1hWyT3uJIpMOskFOS9aeCn/xTwMc
         NlMOKFIxPrOEg==
Received: by mail-ed1-f70.google.com with SMTP id e18-20020a0564020892b02903be9702d63eso1236745edy.17
        for <linux-pci@vger.kernel.org>; Wed, 11 Aug 2021 22:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y53JKgE+GbCZ7nxa4ybqSQLIhghBQQHZOHkhwGSHjJg=;
        b=TS3WpksUJrOEqzi9I+VVafVONO5xHs22ttLRGUKOP3cHMRB0paqgylKRkgWN2sTLmM
         p4Fzu9xiu8q6kheaue3eZ6vflzfyq8u5tloSKfIzwyRLsWZsytigBmvHMUogmpUBzWtg
         BqUo1CIPw7iuxhgq1cjcmC/jRGEIZ2MgrJQq/LO2Ot8j78K4WlQF3Cwh9a2OuSZdWE4q
         9ob/x0jdILEAsl3ioj1p4J36MJ/Ydi2lYErBzJYNU9whFpP2DB+9Vlzpy1jBTQJee4LB
         /msFlWgqNPYZduhIjmUIiYubdlL4oTF08KKHUFTgQzOQP2fEvrN9zwnp/ZRF+4C1PBu0
         3OvQ==
X-Gm-Message-State: AOAM532aTs03RHKOe0TASYQTBcrOTq6iaJahIuGImkvgHGZsmJ/GE7Ih
        hZmT+K5oszILVW/hhS9nDr7V2c0nWxqj197SltfNHzzC6MKGOO/6MsJfNy4Yy61EtK4lkrQJVxA
        N2wvaBs5bfTGH6uLgNjHW6ZyOAzsjxXVAWnn08N8D+vsLL8IeyAOL+g==
X-Received: by 2002:a17:907:7609:: with SMTP id jx9mr2038261ejc.432.1628745617933;
        Wed, 11 Aug 2021 22:20:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSvUS0DzG4kZfST0R85WvsA6A2kHxxEv4uzlyLwbpFLymNo3x/SHPFI8aa1nE7BTWt+JYmf8S/4aRDckBQa/o=
X-Received: by 2002:a17:907:7609:: with SMTP id jx9mr2038244ejc.432.1628745617688;
 Wed, 11 Aug 2021 22:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
 <20210809042414.107430-1-kai.heng.feng@canonical.com> <20210809094731.GA16595@wunner.de>
 <CAAd53p7cR3EzUjEU04cDhJDY5F=5k+eRHMVNKQ=jEfbZvUQq3Q@mail.gmail.com>
 <20210809150005.GA6916@wunner.de> <CAAd53p7qm=K99xO1n0Pwmn020Q7_iDj2S6-QGjeRjP0CpSphTg@mail.gmail.com>
 <20210810162144.GA24713@wunner.de> <CAAd53p7bMm5KyjXvUOTevspm9e0mtPP2KWoq5xZSWng8q1kGPg@mail.gmail.com>
 <20210811071158.GB6104@wunner.de>
In-Reply-To: <20210811071158.GB6104@wunner.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 12 Aug 2021 13:20:04 +0800
Message-ID: <CAAd53p56OyxPuH5VdDTbBoxqO4q2e6ht-9XPKXCwsjUsR=sSXg@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Disallow runtime suspend when waekup is
 required but PME service isn't supported
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 11, 2021 at 3:11 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Wed, Aug 11, 2021 at 01:06:27PM +0800, Kai-Heng Feng wrote:
> > On Wed, Aug 11, 2021 at 12:21 AM Lukas Wunner <lukas@wunner.de> wrote:
> > >
> > > On Tue, Aug 10, 2021 at 11:37:12PM +0800, Kai-Heng Feng wrote:
> > > I honestly don't know.  I was just wondering whether it is okay
> > > to enable PME on devices if control is not granted by the firmware.
> > > The spec is fairly vague.  But I guess the idea is that enabling PME
> > > on devices is correct, just handling the interrupts is done by firmware
> > > instead of the OS.
> >
> > Does this imply that current ACPI doesn't handle this part?
>
> Apparently not, according to the "lspci-bridge-after-hotplug" you've
> attached to the bugzilla, the PME Interrupt Enable bit wasn't set in
> the Root Control register.  The kernel doesn't register an IRQ handler
> for PME because firmware doesn't grant it control, so it's firmware's
> job to enable and handle the IRQ (or poll the relevant register or
> whatever).
>
>   RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
>                                                    ^^^^^^^^^^

OK, I'll send a patch that checks this flag for PME capability.

>
> > The Windows approach is to make the entire hierarchy stays at D0, I
> > think maybe it's a better way than relying on PME polling.
>
> Including the endpoint device, i.e. the NIC?

Yes, including the endpoint device.

>
>
> > > If you do want to change core code, I'd suggest modifying
> > > pci_dev_check_d3cold() so that it blocks runtime PM on upstream
> > > bridges if PME is not handled natively AND firmware failed to enable
> > > the PME interrupt at the root port.  The rationale is that upstream
> > > bridges need to remain in D0 so that PME polling is possible.
> >
> > How do I know that firmware failed to enable PME IRQ?
>
> Check whether PCI_EXP_RTCTL_PMEIE was set by firmware in the Root Control
> register.

I originally thought there can be a special ACPI method to query this info.

>
>
> > > An alternative would be a quirk for this specific laptop which clears
> > > pdev->pme_support.
> >
> > This won't scale, because many models are affected.
>
> We already have quirks which clear pdev->pme_support, e.g.
> pci_fixup_no_d0_pme() and pci_fixup_no_msi_no_pme().
> Perhaps something like that would be appropriate here.

OK, I'll take this approach.

Kai-Heng

>
> Thanks,
>
> Lukas
