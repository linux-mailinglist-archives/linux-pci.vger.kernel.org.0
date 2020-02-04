Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6091151C86
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2020 15:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgBDOsE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Feb 2020 09:48:04 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:54486 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgBDOsD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Feb 2020 09:48:03 -0500
Received: by mail-wm1-f41.google.com with SMTP id g1so3592183wmh.4;
        Tue, 04 Feb 2020 06:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3w1h+lRRfIpIEUdjt/Pa7xTQOn5j0pYRtKr5A2aGqqE=;
        b=iqlf35kMVH6QZnkCDUtO9VxLzLbryZekhFqhzbOfC2q1N7Lu0/fSYKd9vxFLa6Z458
         28/EdLI8XKeBsL4QKQsXtHw9cUBitSTb/AFnu51DffAPJWwTybsgEgcM6gfipNH/tAem
         zLKSVkMic1j6CSTh5eWvCrxRyEU0XC6pZtRuwYUnA2Oj1T8GxYUNee93F6gBRF1rnBCQ
         5OaDM3nqD9iiYyzuecTtAFJUh5CMbmCdlHquDbXQXBefLSWuUPHGOuEtBw0MWW65J+ep
         94vBfxJCpMsU+NL3G5LWAyMm537D+cGCuNL1WYPfprdG7j3hOQsZZgH43zi5v6HWl4KC
         XlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3w1h+lRRfIpIEUdjt/Pa7xTQOn5j0pYRtKr5A2aGqqE=;
        b=bM7GXRS1F8b+GKiFSescOTLaI3SE3ZhJvbBO0ZNx5Hm5Hyg7t4u3MiKdOUV3Xzaei1
         z7i/ORNfaguSRIskUztRaX+LyQhFOiuzpy4KMLv8BbpxjthZkpcEe24xLakGO+b9WTw0
         JZGoOZRd3H00DQtiIEdC6NraZ87W48l1FvW3X5JsF9aRIwzizInwG9FtMmtQ6Ixo8jpM
         ar4iZ+J0Tab+qrr0Qo62olkaf8lb/y7CR3mebzKzjFuIRK3ZKZ7G9jHzh/ej5+SLK18r
         29d29GmPfiyO/brwg5tcjtHqEslvJUC03KvNoeZcMMz2g7i4EDMiRZOy0Er5Gq6HrOhf
         gANw==
X-Gm-Message-State: APjAAAXXtwRXZhTWKLgUNQ6z9J8y+JTFC5poZLm5ze4fDjZfQdYTbl7g
        rqaEgyFZBaCi0jmaKTddzOnWwjYp32Csfpnwz+4=
X-Google-Smtp-Source: APXvYqxU46ENi0uRw9NyCsjZimEEDcPdsgH0ACk6iTg6jaS/gTDOT7kEvzl1tiWV7OMZTcXqZup/Jx90UqC325dMLTQ=
X-Received: by 2002:a05:600c:218b:: with SMTP id e11mr6311726wme.56.1580827681631;
 Tue, 04 Feb 2020 06:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20200120023326.GA149019@google.com> <b9764896-102c-84cb-32ea-c2a122b6f0db@gmail.com>
 <8409fd7ad6b83da75c914a71accf522953a460a0.camel@pengutronix.de>
 <CAPM=9twvggZqVu=HmXZMN70+-6hAPGdog-dGFnM7jp3RhjAB9w@mail.gmail.com>
 <CAPM=9tz9dOLL=onbA-73T-hwzFYMXjSywCufqmnM7bP5dT_x0Q@mail.gmail.com>
 <CADnq5_PRQJmG_NYHmqWhv2R1utaNf0LcTVgFA7LMeYr75fy55w@mail.gmail.com> <20200204043825.thpbqpz3ao7zqvlh@wunner.de>
In-Reply-To: <20200204043825.thpbqpz3ao7zqvlh@wunner.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 4 Feb 2020 09:47:50 -0500
Message-ID: <CADnq5_PFuZZnZXzhJ0PkuPdCPNRt=ogXFYgrp4k5XSC9XTZGeg@mail.gmail.com>
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth notification"
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Dave Airlie <airlied@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Ben Skeggs <skeggsb@gmail.com>,
        Karol Herbst <karolherbst@gmail.com>,
        "Alex G." <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jan Vesely <jano.vesely@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 3, 2020 at 11:38 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, Feb 03, 2020 at 04:16:36PM -0500, Alex Deucher wrote:
> > AMD has had a micro-controller on the GPU handling pcie link speeds
> > and widths dynamically (in addition to GPU clocks and voltages) for
> > about 12 years or so at this point to save power when the GPU is idle
> > and improve performance when it's required.  The micro-controller
> > changes the link parameters dynamically based on load independent of
> > the driver.  The driver can tweak the heuristics, or even disable the
> > dynamic changes, but by default it's enabled when the driver loads.
> > The ucode for this micro-controller is loaded by the driver so you'll
> > see fixed clocks and widths prior to the driver loading.  We'd need
> > some sort of opt out I suppose for periods when the driver has enabled
> > dynamic pcie power management in the micro-controller.
>
> Note that there are *two* bits in the Link Status Register:
>
> * Link Autonomous Bandwidth Status
>   "This bit is Set by hardware to indicate that hardware has
>   autonomously changed Link speed or width, without the Port
>   transitioning through DL_Down status, for reasons other than to
>   attempt to correct unreliable Link operation.  This bit must be set if
>   the Physical Layer reports a speed or width change was initiated by
>   the Downstream component that was indicated as an autonomous change."
>
> * Link Bandwidth Management Status
>   "This bit is Set by hardware to indicate that either of the
>   following has occurred without the Port transitioning through
>   DL_Down status. [...] Hardware has changed Link speed or width to
>   attempt to correct unreliable Link operation, either through an
>   LTSSM timeout or a higher level process."
>
> See PCIe Base Spec 4.0 sec 7.8.8, 7.8.7, 4.2.6.3.3.1.
>
> The two bits generate *separate* interrupts.  We only enable the
> interrupt for the latter.
>
> If AMD GPUs generate a Link Bandwidth Management Interrupt upon
> autonomously changing bandwidth for power management reasons
> (instead of to correct unreliability issues), that would be a
> spec violation.
>
> So the question is, do your GPUs violate the spec in this regard?

I don't know off hand.  I can ask the firmware team.  That said, I
haven't seen any reports of problems with our GPUs with this code
enabled.

Alex
