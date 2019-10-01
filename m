Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB57FC2F5D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 10:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfJAI4x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 04:56:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbfJAI4w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Oct 2019 04:56:52 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E52BB36961
        for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2019 08:56:51 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id r20so37063263ioh.7
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2019 01:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4MCB39tSojzPSG5F8motQYTFmJxxDn1nUNabNxkafU=;
        b=sIFCETNIi+kmibtfMXlF4FFRDqdl0QZvxla3mvKaBLlYQOwaii8LMbvWi3hqtpWXzq
         qUt0SOnjIlAyzBI6rAiv86GCn1kcW6WRWvXuEZ1q2V5C5+FmAsmRSHVachWy0us+3ZKQ
         JSTRlHJRWZbANTp/yUSmLKT94MHq8Yhb1dfb75g+52R2eWH50MxnLk58mWdpcrS2IS/R
         utY8bPf6tR+oWcHmir635RKaLG+S/kpnCUqJSZKS5g6oSi20tW6ysXKnDs2u7TIVdapc
         SLCU5t5XAzt4VdOs3L/t6DYl4e/q/IySQrnjGoyzKDHCHNswWJHKTPPKneXMi0k5Fvda
         dlIA==
X-Gm-Message-State: APjAAAWtN+TuLYf6sN3uQPfMVUKkzB0VUibeVuiaXDhXbRECMdIWQMV2
        l8Y6rwHOxtIM8an2c7h2eIT4n46F4o2lhAYmHCdhg6NBzg7qlsIgw/KP8rHjq+dbtjAbzeVKQ5Q
        Ij1r6tffSFTZErhTIZBXDayM/bko/E5waXipq
X-Received: by 2002:a02:3785:: with SMTP id r127mr23230732jar.40.1569920211282;
        Tue, 01 Oct 2019 01:56:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwoNzktoaUof8b0H3sFnkM9bXtOd3VgXH5Bw47BtxohVXwwNwKIPvNn8hjvUfNCqV1BTAm2hn7ua8hYHfXP2xc=
X-Received: by 2002:a02:3785:: with SMTP id r127mr23230713jar.40.1569920210929;
 Tue, 01 Oct 2019 01:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190927144421.22608-1-kherbst@redhat.com> <20190927214252.GA65801@google.com>
 <CACO55tuaY1jFXpJPeC9M4PoWEDyy547_tE8MpLaTDb+C+ffsbg@mail.gmail.com>
 <20190930080534.GS2714@lahna.fi.intel.com> <CACO55tuMo1aAA7meGtEey6J6sOS-ZA0ebZeL52i2zfkWtPqe_g@mail.gmail.com>
 <20190930092934.GT2714@lahna.fi.intel.com> <CACO55tu9M8_TWu2MxNe_NROit+d+rHJP5_Tb+t73q5vr19sd1w@mail.gmail.com>
 <20190930163001.GX2714@lahna.fi.intel.com> <CACO55tuk4SA6-xUtJ-oRePy8MPXYAp2cfmSPxwW3J5nQuX3y2g@mail.gmail.com>
 <20191001084651.GC2714@lahna.fi.intel.com>
In-Reply-To: <20191001084651.GC2714@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 1 Oct 2019 10:56:39 +0200
Message-ID: <CACO55ts9ommYbA5g4=G+f0G=v90qGM7EsurU7AL7bU=PFzQMnw@mail.gmail.com>
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

On Tue, Oct 1, 2019 at 10:47 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Sep 30, 2019 at 06:36:12PM +0200, Karol Herbst wrote:
> > On Mon, Sep 30, 2019 at 6:30 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Mon, Sep 30, 2019 at 06:05:14PM +0200, Karol Herbst wrote:
> > > > still happens with your patch applied. The machine simply gets shut down.
> > > >
> > > > dmesg can be found here:
> > > > https://gist.githubusercontent.com/karolherbst/40eb091c7b7b33ef993525de660f1a3b/raw/2380e31f566e93e5ba7c87ef545420965d4c492c/gistfile1.txt
> > >
> > > Looking your dmesg:
> > >
> > > Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: DCB version 4.1
> > > Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: MM: using COPY for buffer copies
> > > Sep 30 17:24:27 kernel: [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 1
> > >
> > > I would assume it runtime suspends here. Then it wakes up because of PCI
> > > access from userspace:
> > >
> > > Sep 30 17:24:42 kernel: pci_raw_set_power_state: 56 callbacks suppressed
> > >
> > > and for some reason it does not get resumed properly. There are also few
> > > warnings from ACPI that might be relevant:
> > >
> > > Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.GFX0._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> > > Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.PEG0.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> > >
> >
> > afaik this is the case for essentially every laptop out there.
>
> OK, so they are harmless?
>

yes

> > > This seems to be Dell XPS 9560 which I think has been around some time
> > > already so I wonder why we only see issues now. Has it ever worked for
> > > you or maybe there is a regression that causes it to happen now?
> >
> > oh, it's broken since forever, we just tried to get more information
> > from Nvidia if they know what this is all about, but we got nothing
> > useful.
> >
> > We were also hoping to find a reliable fix or workaround we could have
> > inside nouveau to fix that as I think nouveau is the only driver
> > actually hit by this issue, but nothing turned out to be reliable
> > enough.
>
> Can't you just block runtime PM from the nouveau driver until this is
> understood better? That can be done by calling pm_runtime_forbid() (or
> not calling pm_runtime_allow() in the driver). Or in case of PCI driver
> you just don't decrease the reference count when probe() ends.
>

the thing is, it does work for a lot of laptops. We could only observe
this on kaby lake and skylake ones. Even on Cannon Lakes it seems to
work just fine.

> I think that would be much better than blocking any devices behind
> Kabylake PCIe root ports from entering D3 (I don't really think the
> problem is in the root ports itself but there is something we are
> missing when the NVIDIA GPU is put into D3cold or back from there).

I highly doubt there is anything wrong with the GPU alone as we have
too many indications which tell us otherwise.

Anyway, at this point I don't know where to look further for what's
actually wrong. And apparently it works on Windows, but I don't know
why and I have no idea what Windows does on such systems to make it
work reliably.
