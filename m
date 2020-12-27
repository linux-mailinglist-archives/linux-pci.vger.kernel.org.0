Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F51C2E3269
	for <lists+linux-pci@lfdr.de>; Sun, 27 Dec 2020 19:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgL0S2z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Dec 2020 13:28:55 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:38890 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgL0S2y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Dec 2020 13:28:54 -0500
Received: by mail-ua1-f53.google.com with SMTP id j59so2732653uad.5;
        Sun, 27 Dec 2020 10:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHXagY3A/DK4pEpN7boYvTeZV4qY/yf7WrSua4i2PV8=;
        b=qzkBdntEP/1gH7TEIYZg6UdGx88ClwehGinPsHa7ulQjE72CPtlvxPiMp/3lgjcYHu
         1tDO6EeZp9pOKVOMDxHn5xMeBlxUcgqxC3tU5+Yv5TaM9xKyzXy51nwpcY8MvTyjFXnl
         6ZhFYSJLct33BAwkoOjfJhGmUyb9kN2cBb5leM/pnxDJWYipzhy6D3fg67ZecHFaKLK8
         dLk/XEnucEO0qJ5qWSLZ7uDIGUcZJF8bho9wyyA0xBmDI4iKbWObK6lh1GeaiDyWNuzN
         syvzgR1OIrYNMC+Xh/cDRcRuzYFmXwVpKXmsY9SHUmZaM6FP0959VyU92IM/MhpURyfN
         M3fg==
X-Gm-Message-State: AOAM531OuuiRoSJKmdilSGm4AQqFqPSEnyNCnz+Z18Q+bk6/kHmh7B68
        9K3JUSDKkqrBZVUm59I6ZAq05jxPJETZsZL7Dcc=
X-Google-Smtp-Source: ABdhPJz1BQy9K3ilducip6gKHDgDVrGXFEjWVw2n3lxHJwDA/WOsfUGMlfTMwsAOI7/ZySlBlBJisayfcDG/BcJU0UI=
X-Received: by 2002:ab0:3806:: with SMTP id x6mr26004284uav.58.1609093693309;
 Sun, 27 Dec 2020 10:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20200908002935.GD20064@merlins.org> <20200529180315.GA18804@merlins.org>
 <20201226111209.GA2498@merlins.org>
In-Reply-To: <20201226111209.GA2498@merlins.org>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Sun, 27 Dec 2020 13:28:02 -0500
Message-ID: <CAKb7UvhuWdPBgqV+Nf+KJ_Eb9SOJrbTxfBwiA-7HtdurVd+LiA@mail.gmail.com>
Subject: Re: [Nouveau] 5.9.11 still hanging 2mn at each boot and looping on
 nvidia-gpu 0000:01:00.3: PME# enabled (Quadro RTX 4000 Mobile)
To:     Marc MERLIN <marc_nouveau@merlins.org>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 27, 2020 at 12:03 PM Marc MERLIN <marc_nouveau@merlins.org> wrote:
>
> This started with 5.5 and hasn't gotten better since then, despite some reports
> I tried to send.
>
> As per my previous message:
> I have a Thinkpad P70 with hybrid graphics.
> 01:00.0 VGA compatible controller: NVIDIA Corporation GM107GLM [Quadro M600M] (rev a2)
> that one works fine, I can use i915 for the main screen, and nouveau to
> display on the external ports (external ports are only wired to nvidia
> chip, so it's impossible to use them without turning the nvidia chip
> on).
>
> I now got a newer P73 also with the same hybrid graphics (setup as such
> in the bios). It runs fine with i915, and I don't need to use external
> display with nouveau for now (it almost works, but I only see the mouse
> cursor on the external screen, no window or anything else can get
> displayed, very weird).
> 01:00.0 VGA compatible controller: NVIDIA Corporation TU104GLM [Quadro RTX 4000 Mobile / Max-Q] (rev a1)

Display offload usually requires acceleration -- the copies are done
using the DMA engine. Please make sure that you have firmware
available (and a new enough mesa). The errors suggest that you don't
have firmware available at the time that nouveau loads. Depending on
your setup, that might mean the firmware has to be built into the
kernel, or available in initramfs. (Or just regular filesystem if you
don't use a complicated boot sequence. But many people go with distro
defaults, which do have this complexity.)

>
>
> after boot, when it gets the right trigger (not sure which ones), it
> loops on this evern 2 seconds, mostly forever.

The gpu suspends with runtime pm. And then gets woken up for some
reason (could be something quite silly, like lspci, or could be
something explicitly checking connectors, etc). Repeat.

Cheers,

  -ilia
