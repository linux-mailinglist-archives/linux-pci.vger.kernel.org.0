Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C64D22F6EE
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 19:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgG0RoB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 13:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbgG0RoA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 13:44:00 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 211BE20714;
        Mon, 27 Jul 2020 17:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595871840;
        bh=5/5EvEs7O/GbKgoqLg5+MWxLEXrZ46oBpCe/CaHYkO8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CwTbdQCXWvWHwgA+JYFxW0azkKcOxlQEhzfgzha/WDlC1ft9S6JYo2t+m6DSc6YBE
         GudlawXr13klWVSd2jUHHMTT0yqh5xmcTYmlQLkoWZw4Jg3OLfMKbjcCnd69l5Bey6
         ceRG3Y2rp1s91fD7EaXCmBFfptOP5OFxCQtPxw9Q=
Received: by mail-oi1-f170.google.com with SMTP id 12so15059632oir.4;
        Mon, 27 Jul 2020 10:44:00 -0700 (PDT)
X-Gm-Message-State: AOAM5338kTMR0WtwjExv9sETwCDw8hRmtIHKvJBVTx14Hs2k+EataB33
        fW+FrurmXDZB8xaj8KJYz5QQjpuXvUO83tz9jg==
X-Google-Smtp-Source: ABdhPJxZ3dUGKZJ+t4+ExDE8iFtHmcY0Xe9S6fQlgx62P2z/ibIBpDxX9HohgCSHBmCtqT4HADrnqJc/41O56XTECzI=
X-Received: by 2002:aca:4844:: with SMTP id v65mr378915oia.152.1595871839488;
 Mon, 27 Jul 2020 10:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200623145528.1658337-1-thierry.reding@gmail.com>
 <20200623145528.1658337-2-thierry.reding@gmail.com> <CAL_Jsq+u=oFUAuURy-f8wCzagA-xKJES8RRf=kUSXJHoxOipBQ@mail.gmail.com>
 <20200727172149.GA3683017@ulmo>
In-Reply-To: <20200727172149.GA3683017@ulmo>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 27 Jul 2020 11:43:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKztykYZDdeHgWEnwW_9rasDrNwz0Cz9K2Pe1BtmvembQ@mail.gmail.com>
Message-ID: <CAL_JsqKztykYZDdeHgWEnwW_9rasDrNwz0Cz9K2Pe1BtmvembQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: tegra: Remove PLL power supplies
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 27, 2020 at 11:21 AM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Mon, Jul 27, 2020 at 10:21:42AM -0600, Rob Herring wrote:
> > On Tue, Jun 23, 2020 at 8:55 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > The Tegra PCI controller driver doesn't need to control the PLL power
> > > supplies directly, but rather uses the pads provided by the XUSB pad
> > > controller, which in turn is responsible for supplying power to the
> > > PLLs.
> > >
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > >  drivers/pci/controller/pci-tegra.c | 10 ++--------
> > >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > What's going to happen here with a new dtb and an old kernel? Is it
> > going to error out due to missing supplies?
>
> It's not going to error out but fallback to the "dummy" regulator, so
> this should be fine from a forwards-compatibility point of view. Though
> I didn't think we technically cared about that direction very much.

AIUI, SUSE ships newer DTs with stable kernels. Of course, the dtb's
shouldn't really come from the OS vendors, but you wouldn't want a
newer firmware (w/ dtb) to break your OS either.

In any case,

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
