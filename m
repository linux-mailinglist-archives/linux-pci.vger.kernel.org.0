Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7913A487F00
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 23:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiAGWhJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 17:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiAGWhI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 17:37:08 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AA1C061574
        for <linux-pci@vger.kernel.org>; Fri,  7 Jan 2022 14:37:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k18so13622290wrg.11
        for <linux-pci@vger.kernel.org>; Fri, 07 Jan 2022 14:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+ftPPg+mBtDFE1Rumj/v9cdHX74g8JsGDvIeuaB0sw=;
        b=AP4vnWnjNZ0+FbyV/paMdWCoPqlJsNv7u/VAZmbyQPIQYIkKmM9xtluYweMfGDCwlx
         M6xlF3WNOEXlhJIw5eYbOUznnu+94L5InBLgV7SPnjq7TeH+Tly04IZtkTcFGb0zS0Ry
         30CmLfIo2fCaXdYowRSZPyRgSImplqOqzG+tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+ftPPg+mBtDFE1Rumj/v9cdHX74g8JsGDvIeuaB0sw=;
        b=K1LrFNGKGuLYH0kojXPfLjQa5ALjjH+TUhyuMzPjKY1w6XeZfO1gViWTkm1B2AS9fm
         0WLqU28JTODSJl1WGlA6YylHow/y49y0l7J3B8kspGzoICdyDHiixgw0I9zB2O6ByeAO
         3LfiFCW/Fb02c87TYOAs1tYYbVdme6JhFDgpfGqlQyLVANtGzBSWu9XhiIoCvortT9Ud
         s2rtud9M2w06QDYXtGBI0EjFr+YxSggJz7jzpPIUpVeMvpeQpJhyB9VT8QxqJAuG7wKb
         K82goCoWze0z0oNa1enaU108n6dkRGnNootzXfic0lytU8E6X58KQigzWH6ED3F9FsZ6
         TlJA==
X-Gm-Message-State: AOAM531C0g2buiUmYGwm8RVxjwiu5QZmGRMqAbSztj9SHmHJfgrDyKuQ
        cDvTjdxuUE8wqCLqDpWRKxKpI+/RT6OjN2sxcuE+zw==
X-Google-Smtp-Source: ABdhPJxBgtZis30xOXNXG44kdaru7DxXX4kR8w0Gqb6L6sTYxtDqty53dbly3IotCoc7BxQNTyR5PLfs45h7sgxRwXM=
X-Received: by 2002:a05:6000:18af:: with SMTP id b15mr56930329wri.616.1641595026619;
 Fri, 07 Jan 2022 14:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20211209204726.6676-1-jim2101024@gmail.com> <20220105104202.GD7009@alpha.franken.de>
In-Reply-To: <20220105104202.GD7009@alpha.franken.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 7 Jan 2022 17:36:55 -0500
Message-ID: <CA+-6iNyjDvuTFo9usprg9OX9a-vsieoh2z2-KAfaxAAZ2cw_Og@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] PCI: brcmstb: Augment driver for MIPs SOCs
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, linux-mips@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 5, 2022 at 5:42 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Thu, Dec 09, 2021 at 03:47:21PM -0500, Jim Quinlan wrote:
> > With this patchset, the Broadcom STB PCIe controller driver
> > supports Arm, Arm64, and now MIPs.
> >
> > Jim Quinlan (4):
> >   dt-bindings: PCI: Add compatible string for Brcmstb 74[23]5 MIPs SOCs
> >   MIPS: bmips: Add support PCIe controller device nodes
> >   MIPS: bmips: Remove obsolete DMA mapping support
> >   PCI: brcmstb: Augment driver for MIPs SOCs
> >
> >  .../bindings/pci/brcm,stb-pcie.yaml           |   2 +
> >  arch/mips/Kconfig                             |   1 -
> >  arch/mips/bmips/dma.c                         | 106 +-----------------
> >  arch/mips/boot/dts/brcm/bcm7425.dtsi          |  30 +++++
> >  arch/mips/boot/dts/brcm/bcm7435.dtsi          |  30 +++++
> >  arch/mips/boot/dts/brcm/bcm97425svmb.dts      |   9 ++
> >  arch/mips/boot/dts/brcm/bcm97435svmb.dts      |   9 ++
> >  drivers/pci/controller/Kconfig                |   2 +-
> >  drivers/pci/controller/pcie-brcmstb.c         |  82 +++++++++++++-
> >  9 files changed, 161 insertions(+), 110 deletions(-)
>
> if nobody objects I'd like to add this series to mips-next.
Hi Thomas,

I have another pullreq in progress [1] that may possibly be accepted
soon.  I have tested that
these two pullreqs do not conflict or cause compiler errors regardless
of their merge order.

Regards,
Jim Quinlan
Broadcom STB

[1] [PATCH v10 0/7] PCI: brcmstb: root port turns on sub-device power


[PATCH v10 0/7] PCI: brcmstb: root port turns on sub-device power

>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]
