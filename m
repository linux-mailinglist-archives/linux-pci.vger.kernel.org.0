Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6703EE74D
	for <lists+linux-pci@lfdr.de>; Tue, 17 Aug 2021 09:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbhHQHf0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 03:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234601AbhHQHf0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Aug 2021 03:35:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B59060FA0;
        Tue, 17 Aug 2021 07:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629185693;
        bh=SemVCuGqjhzqig8PxA4tle98CZxitX+M8IpUnKNEyUA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OXr83AwRHiFqs1oqVG1TVqjHBFonZfn/qj2J0TnkQlvi1H+VSJEZBjtKrVjpSr+65
         NarL9M7xI5huBerrqXPxOJHPD6AD3fjQPLqZHoUDgwFt0I5wdJzV5vOw71uZnCGXuM
         AgsxghosI/L4IklLbZWc78qF7jDaeVJhiOZ3RhKhC0VsbLXVD6o2Yg4oZYy83frnBp
         L9DhJo4UbsBlPfLGPtNzVYHgS+QPbr1HCUq/l/KJAitZt1GAY2NRwc9F97w/RxlJeG
         WyBgQwS7Zhs8MNGt04x7dma09CqjE8n2WkKfc3/eumPiP7kYPxTlmVxYIRPmfcI7rJ
         SEgioVVlQv2ww==
Received: by mail-wr1-f52.google.com with SMTP id r7so27248897wrs.0;
        Tue, 17 Aug 2021 00:34:53 -0700 (PDT)
X-Gm-Message-State: AOAM531gf/T9OnTdWH3bIp+U0mL3USD26k7kCm6Za/6AutTXGVqDTpFe
        WZ+KUGTLHyvseQ+0ckwo2w00eNuXTC+EddfhqxU=
X-Google-Smtp-Source: ABdhPJzC9G4r4ojNPIiUqEHZhs2nqnS08mHa9NRUHYAZJyDs7A0fV2N4cjAAbV6G5sALGYsnq27bRNX1pLc5miW5+RE=
X-Received: by 2002:adf:f202:: with SMTP id p2mr2327557wro.361.1629185691739;
 Tue, 17 Aug 2021 00:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210815042525.36878-1-alyssa@rosenzweig.io> <20210815042525.36878-3-alyssa@rosenzweig.io>
 <87a6lj17d1.wl-maz@kernel.org> <YRm//JU0otojw+rV@sunset> <87tujpyrxu.wl-maz@kernel.org>
In-Reply-To: <87tujpyrxu.wl-maz@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 17 Aug 2021 09:34:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3_NBek+w2xYp5Kscc9d+6DFOuF-vy1ySYo81qAmebk9A@mail.gmail.com>
Message-ID: <CAK8P3a3_NBek+w2xYp5Kscc9d+6DFOuF-vy1ySYo81qAmebk9A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] PCI: apple: Add driver for the Apple M1
To:     Marc Zyngier <maz@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 16, 2021 at 11:57 PM Marc Zyngier <maz@kernel.org> wrote:
> On Mon, 16 Aug 2021 02:31:40 +0100, Alyssa Rosenzweig <alyssa@rosenzweig.=
io> wrote:
>
> > > Please use relaxed accessors. If the barriers are actually needed,
> > > please document what you are ordering against. This applies throughou=
t
> > > the patch.
> >
> > Relaxed accessors are used throughout in v2... it Works For Me=E2=84=A2=
 but no
> > guarantees I didn't introduce a race...
>
> That's not exactly what I wanted to read... You really need to make an
> informed decision on the need of barriers. If the MMIO write needs to
> be ordered after a main memory write (i.e. a memory write that is
> consumed by the device you are subsequently writing to), you then need
> a barrier. If, as I suspect, the device isn't DMA capable and doesn't
> require ordering with the rest of the memory accesses, then no
> barriers are required.

My normal rule is to always use the normal accessors, and only use
any special variants if this is either required for correct operation
(e.g. heavy barriers on arm32 may call code that must not recursively
use heavy barriers) or that you have proven to /both/ be correct and
relevant for performance. IOW, don't use the relaxed accessors just
because it isn't wrong in your driver, other developers may copy the
code into a driver that can't do it.

      Arnd
