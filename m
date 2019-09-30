Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91545C2540
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 18:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbfI3QgZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 12:36:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732326AbfI3QgZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 12:36:25 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B11A6C0568FA
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2019 16:36:24 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id e14so31314412iot.16
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2019 09:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6TZwGZ6BwH01Gtc+GZbV82I7jDbXiJPW011pcYuI0Q=;
        b=pTDxYP2kFfoQRqZnz87v445HrzAwkOEkN38+K5X8BUHtZY5VF/6Hb02aEqxxmvO6y5
         UDRrXbAefMxTi3XhR/nCeF/fnyNHhMxQ5ith1yU1P8A8gPdDJUXgMtUf2XFxyD49Vet4
         Zc6PerFddCrMLHIwAMoYVJHcaPVvdfSD+8zlcl5PmBt241pjC40BDwcwMnKn7RPcdjzy
         DKop85TVk3pyHLCLtulp4b790PAuXZoUEkO9PkGE+6660LODtCogEKSN7cQmLNvbupW1
         vgLGbZ9fRiYyy/VPyw/fsxoNausVQFMeJuiWHfPvfSbcaNcdn9MU38Urh4+oE25XJA+c
         5QLA==
X-Gm-Message-State: APjAAAWkACXu9GQkcGiX0eCwyRjzUvV9mrYFRTnCbPuPaHgPn5qUruMY
        MTQFJRqMNpi9EG4NcAnl1tQiR+hqvuBfhCaULetkUC9Q6b0fJXQz3DqlAspvHB+ViXV/MwhrreU
        CmF4Hkwmgye0Sq3a4JDgjkIuRyYWbdkizkK8w
X-Received: by 2002:a6b:3804:: with SMTP id f4mr7902608ioa.166.1569861384021;
        Mon, 30 Sep 2019 09:36:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxTi7C+3z1z5gBDBQSyyub19LVPhCynfHDYm5iNSEA04yROLKW+AsLuHu877bWM07L3lw3ItDdT4w5mzyKMATY=
X-Received: by 2002:a6b:3804:: with SMTP id f4mr7902576ioa.166.1569861383788;
 Mon, 30 Sep 2019 09:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190927144421.22608-1-kherbst@redhat.com> <20190927214252.GA65801@google.com>
 <CACO55tuaY1jFXpJPeC9M4PoWEDyy547_tE8MpLaTDb+C+ffsbg@mail.gmail.com>
 <20190930080534.GS2714@lahna.fi.intel.com> <CACO55tuMo1aAA7meGtEey6J6sOS-ZA0ebZeL52i2zfkWtPqe_g@mail.gmail.com>
 <20190930092934.GT2714@lahna.fi.intel.com> <CACO55tu9M8_TWu2MxNe_NROit+d+rHJP5_Tb+t73q5vr19sd1w@mail.gmail.com>
 <20190930163001.GX2714@lahna.fi.intel.com>
In-Reply-To: <20190930163001.GX2714@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 30 Sep 2019 18:36:12 +0200
Message-ID: <CACO55tuk4SA6-xUtJ-oRePy8MPXYAp2cfmSPxwW3J5nQuX3y2g@mail.gmail.com>
Subject: Re: [RFC PATCH] pci: prevent putting pcie devices into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 30, 2019 at 6:30 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Sep 30, 2019 at 06:05:14PM +0200, Karol Herbst wrote:
> > still happens with your patch applied. The machine simply gets shut down.
> >
> > dmesg can be found here:
> > https://gist.githubusercontent.com/karolherbst/40eb091c7b7b33ef993525de660f1a3b/raw/2380e31f566e93e5ba7c87ef545420965d4c492c/gistfile1.txt
>
> Looking your dmesg:
>
> Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: DCB version 4.1
> Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: MM: using COPY for buffer copies
> Sep 30 17:24:27 kernel: [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 1
>
> I would assume it runtime suspends here. Then it wakes up because of PCI
> access from userspace:
>
> Sep 30 17:24:42 kernel: pci_raw_set_power_state: 56 callbacks suppressed
>
> and for some reason it does not get resumed properly. There are also few
> warnings from ACPI that might be relevant:
>
> Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.GFX0._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.PEG0.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
>

afaik this is the case for essentially every laptop out there.

> This seems to be Dell XPS 9560 which I think has been around some time
> already so I wonder why we only see issues now. Has it ever worked for
> you or maybe there is a regression that causes it to happen now?

oh, it's broken since forever, we just tried to get more information
from Nvidia if they know what this is all about, but we got nothing
useful.

We were also hoping to find a reliable fix or workaround we could have
inside nouveau to fix that as I think nouveau is the only driver
actually hit by this issue, but nothing turned out to be reliable
enough.
