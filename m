Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2F2C88F4
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 17:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgK3QGo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 11:06:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgK3QGo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 11:06:44 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A445420855;
        Mon, 30 Nov 2020 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606752363;
        bh=1GPOYWKEqPNGZW+D562IP8XHFWfvy0me5bE6J0pU+d8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2HEFFHdTywl4CAx/p1hd7QiYvhS8NPF2Ea8lnZGgE9ImRRreBXzRmxXufDNlcLYC8
         GTq3r6CtCLehaJ7DLWvw0+E5NwB5M45pzGg+/S0+ZPz59nYqfmjftDVq7XgZ6CTrQr
         sIDgmoTV5zhOunGNY9jfhnDbbBTAN2guug6UW26g=
Received: by mail-ej1-f44.google.com with SMTP id s13so7438772ejr.1;
        Mon, 30 Nov 2020 08:06:02 -0800 (PST)
X-Gm-Message-State: AOAM533MrOXqaiiL2XxEK0sS8Nm7gL5dGczBBXsoNwIyacd0IWyJIcqh
        J4EoXsGg5LElePIk5FCbQU7XA/5vk4hnKOpaPw==
X-Google-Smtp-Source: ABdhPJxfgVyP4bnFkAOZrDfHIcdnZWjZa+nSBKw43ABRjzDjIuoZF/30uk3bcc5ez7+cDtG5GS+Y7unmH8ERNOmZGjc=
X-Received: by 2002:a17:907:2718:: with SMTP id w24mr15879083ejk.525.1606752361083;
 Mon, 30 Nov 2020 08:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20201119202825.GA197305@bjorn-Precision-5520> <1606113913.14736.37.camel@mhfsdcap03>
In-Reply-To: <1606113913.14736.37.camel@mhfsdcap03>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Nov 2020 09:05:48 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLdqCE-sVb8T6p2E5Zf1b3pvPBtapZ8dsQGFDW3GsArjQ@mail.gmail.com>
Message-ID: <CAL_JsqLdqCE-sVb8T6p2E5Zf1b3pvPBtapZ8dsQGFDW3GsArjQ@mail.gmail.com>
Subject: Re: [v4,2/3] PCI: mediatek: Add new generation controller support
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Miller <davem@davemloft.net>,
        PCI <linux-pci@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sj Huang <sj.huang@mediatek.com>,
        Youlin Pei <youlin.pei@mediatek.com>,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        qizhong.cheng@mediatek.com, sin_jieyang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 22, 2020 at 11:45 PM Jianjun Wang <jianjun.wang@mediatek.com> wrote:
>
> On Thu, 2020-11-19 at 14:28 -0600, Bjorn Helgaas wrote:
> > "Add new generation" really contains no information.  And "mediatek"
> > is already used for the pcie-mediatek.c driver, so we should have a
> > new tag for this new driver.  Include useful information in the
> > subject, e.g.,
> >
> >   PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
> >
> > On Wed, Nov 18, 2020 at 04:29:34PM +0800, Jianjun Wang wrote:
> > > MediaTek's PCIe host controller has three generation HWs, the new
> > > generation HW is an individual bridge, it supoorts Gen3 speed and
> > > up to 256 MSI interrupt numbers for multi-function devices.
> >
> > s/supoorts/supports/
> >
> > > Add support for new Gen3 controller which can be found on MT8192.
> > >
> > > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > > Acked-by: Ryder Lee <ryder.lee@mediatek.com>

[...]

> > > +static int mtk_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> > > +                               int where, int size, u32 *val)
> > > +{
> > > +   struct mtk_pcie_port *port = bus->sysdata;
> > > +   int bytes;
> > > +
> > > +   bytes = ((1 << size) - 1) << (where & 0x3);
> >
> > This seems like some unusual bit twiddling; at least, I don't remember
> > seeing this before.  Can you skim other drivers and see if others do
> > the same thing, and adopt a common style if they do?
>
> Hi Bjorn,
>
> Thanks for your review, I will fix it in the next version.
> >
> > > +   writel(PCIE_CFG_HEADER_FORCE_BE(devfn, bus->number, bytes),
> > > +          port->base + PCIE_CFGNUM_REG);
> > > +
> > > +   *val = readl(port->base + PCIE_CFG_OFFSET_ADDR + (where & ~0x3));
> >
> > These look like they need to be atomic, since you need a writel()
> > followed by a readl().
> >
> > pci_lock_config() (used in pci_bus_read_config_*(), etc) uses the
> > global pci_lock for this unless CONFIG_PCI_LOCKLESS_CONFIG is set.
> >
> > But I would like to eventually move away from this implicit dependency
> > on pci_lock.  If you need to make this atomic, can you add the
> > explicit locking here, so there's a clear connection between the lock
> > and the things it protects?
>
> Sure, I will split it to a map_bus() function and use the standard
> pci_generic_config_read32/write32 functions as Rob's suggestion. I think
> the potential risks of atomic read/write can be avoided.

The generic functions have no effect on atomicity, but using them does
make it easier to find the non-atomic cases.

I'm not sure that having host drivers do their own locking is the best
approach. That's a recipe for more cleanups. It's a common enough
issue that I think it's better if we have locking done in 1 place.
Then host drivers can simply say if they need locking or not via some
bus flag.

Rob
