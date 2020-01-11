Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C521382DD
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2020 19:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbgAKSdD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jan 2020 13:33:03 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43322 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730699AbgAKSdD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Jan 2020 13:33:03 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so5491250ioo.10;
        Sat, 11 Jan 2020 10:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHKy6sP4q/jszsnrjUSGz6lJhsm0cQK7CaZ5RcUUJmw=;
        b=WCiQukZ9NwvA2wCS/2MHkw5FREFgqhX/Bi1vPMtIbsDFzebnpnQVbrvxZn1VwjRRVI
         O1gSlCQdAqT1kYLx7qcmcznEmq4Q1PWHGrbvxtEjUuBeqrcf4oHjNLroSSd6/MuS4j7b
         Af1Zgk/64bQoWXigMOGPhWQ5rxw+mkquUhL2Fll6KnQb7g73qhAgS+M/MIY/Rq4pgaBU
         UWbGK/us5CSvKPO/P+4qgg2OV4DgecEU0F1WlZkQ1vmuaKlB3WS90D8M158qk3XVk/Lt
         siwVpcIfOUyS37JwGoxUfZBBTo57vKBf1QJss25VceE3XPtB0u61pG3vWOpJDAgmT5mG
         PgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHKy6sP4q/jszsnrjUSGz6lJhsm0cQK7CaZ5RcUUJmw=;
        b=OqPslGSHKJgRc4BBCbPKTN5UO+yRP2CT4GgWC9L31wUjygUy6Jda5+fEZW9UbeHC4+
         96rQXcDiRWxvL06C7yKHjkOrR3bpa9/ylWyKWjQOopxpPre3ZdW92iSPs2lYQcBG9j70
         71h5gl3nzWtVW3X8nJ6ADf93E2Ix96XVgPw2eJBlVeb/CSVeWF95jV/UptMWCc9lFTH8
         /XLa/w3eSFkctTo+IeK4TWZEYjGfO4DLJhA3C7PSkd9HvCzCbOBzRS8lioyLY430MlJQ
         5i95gHNaKrv3QsJ5+pUaBggmUgz3xqxkc1kABdiyDAknWqK70T5W943m+rwxSM471olN
         3IoA==
X-Gm-Message-State: APjAAAVfSnSxdjkXO31U7Up4tmIMTCbA9wzgL+aZKg9H/1Q9h5vO60mw
        XCJVMf6s5Zfc4DbPB2EdaCyCcsFPb3mGx/kcewE=
X-Google-Smtp-Source: APXvYqzLa9J0R960aMyOgVH0pHxEAL3cPWTk+hUUJtGClH06AtPVaaG/DSG0u8SMvVzY8wYEQMCwkwhND9aCJriSEok=
X-Received: by 2002:a5e:8516:: with SMTP id i22mr7623995ioj.130.1578767582287;
 Sat, 11 Jan 2020 10:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20200110214217.GA88274@google.com> <e0194581-4cdd-3629-d9fe-10a1cfd29d03@gonehiking.org>
 <20200110230003.GB1875851@anatevka.americas.hpqcorp.net> <d2715683-f171-a825-3c0b-678b6c5c1a79@gonehiking.org>
 <20200111005041.GB19291@MiWiFi-R3L-srv> <dc46c904-1652-09b3-f351-6b3a3e761d74@gonehiking.org>
 <CACPcB9c0-nRjM3DSN8wzZBTPsJKWjZ9d_aNTq5zUj4k4egb32Q@mail.gmail.com>
In-Reply-To: <CACPcB9c0-nRjM3DSN8wzZBTPsJKWjZ9d_aNTq5zUj4k4egb32Q@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 11 Jan 2020 10:32:51 -0800
Message-ID: <CABeXuvqquCU+1G=5onk9owASorhpcYWeWBge9U35BrorABcsuw@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Kairui Song <kasong@redhat.com>
Cc:     Khalid Aziz <khalid@gonehiking.org>, Baoquan He <bhe@redhat.com>,
        Jerry Hoemann <Jerry.Hoemann@hpe.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Wright <rwright@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Hi, there are some previous works about this issue, reset PCI devices
> in kdump kernel to stop ongoing DMA:
>
> [v7,0/5] Reset PCIe devices to address DMA problem on kdump with iommu
> https://lore.kernel.org/patchwork/cover/343767/
>
> [v2] PCI: Reset PCIe devices to stop ongoing DMA
> https://lore.kernel.org/patchwork/patch/379191/
>
> And didn't get merged, that patch are trying to fix some DMAR error
> problem, but resetting devices is a bit too destructive, and the
> problem is later fixed in IOMMU side. And in most case the DMA seems
> harmless, as they targets first kernel's memory and kdump kernel only
> live in crash memory.

I was going to ask the same. If the kdump kernel had IOMMU on, would
that still be a problem?

> Also, by the time kdump kernel is able to scan and reset devices,
> there are already a very large time window where things could go
> wrong.
>
> The currently problem observed only happens upon kdump kernel
> shutdown, as the upper bridge is disabled before the device is
> disabledm so DMA will raise error. It's more like a problem of wrong
> device shutting down order.

The way it was described earlier "During this time, the SUT sometimes
gets a PCI error that raises an NMI." suggests that it isn't really
restricted to kexec/kdump.
Any attached device without an active driver might attempt spurious or
malicious DMA and trigger the same during normal operation.
Do you have available some more reporting of what happens during the
PCIe error handling?

"The reaction to the NMI that the kdump kernel takes is problematic."
Or the NMI should not have been triggered to begin with? Where does that happen?

I couldn't access the bug report.

-Deepa
