Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4710D2C8B2D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 18:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbgK3Rd4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 12:33:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387541AbgK3Rd4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 12:33:56 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F5B72073C;
        Mon, 30 Nov 2020 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606757595;
        bh=ikmfcl+yhfQteajZFhY92J11QDZZNVTvlzcz3vXjLSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IRonN+uxEObiBxewJ3FtCeERf5C5Vssf2HsanHgq5cN7IowTUyfHIjn5T7mK+xoUn
         dKVP6gDQ6WQLOjsPYiIPJixrBUsWHF48Ipky+v77OJJH56Hh6ditWIh14iGC9HqAcP
         cAOiVssfWIISuNor3mDTMltNPmys0uvjIBeLtGFw=
Date:   Mon, 30 Nov 2020 11:33:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [v4,2/3] PCI: mediatek: Add new generation controller support
Message-ID: <20201130173313.GA1089760@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLdqCE-sVb8T6p2E5Zf1b3pvPBtapZ8dsQGFDW3GsArjQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 30, 2020 at 09:05:48AM -0700, Rob Herring wrote:
> On Sun, Nov 22, 2020 at 11:45 PM Jianjun Wang <jianjun.wang@mediatek.com> wrote:
> > On Thu, 2020-11-19 at 14:28 -0600, Bjorn Helgaas wrote:
> > > "Add new generation" really contains no information.  And "mediatek"
> > > is already used for the pcie-mediatek.c driver, so we should have a
> > > new tag for this new driver.  Include useful information in the
> > > subject, e.g.,
> > >
> > >   PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192

> > > > +   writel(PCIE_CFG_HEADER_FORCE_BE(devfn, bus->number, bytes),
> > > > +          port->base + PCIE_CFGNUM_REG);
> > > > +
> > > > +   *val = readl(port->base + PCIE_CFG_OFFSET_ADDR + (where & ~0x3));
> > >
> > > These look like they need to be atomic, since you need a writel()
> > > followed by a readl().
> > >
> > > pci_lock_config() (used in pci_bus_read_config_*(), etc) uses the
> > > global pci_lock for this unless CONFIG_PCI_LOCKLESS_CONFIG is set.
> > >
> > > But I would like to eventually move away from this implicit dependency
> > > on pci_lock.  If you need to make this atomic, can you add the
> > > explicit locking here, so there's a clear connection between the lock
> > > and the things it protects?
> >
> > Sure, I will split it to a map_bus() function and use the standard
> > pci_generic_config_read32/write32 functions as Rob's suggestion. I think
> > the potential risks of atomic read/write can be avoided.
> 
> The generic functions have no effect on atomicity, but using them does
> make it easier to find the non-atomic cases.
> 
> I'm not sure that having host drivers do their own locking is the best
> approach. That's a recipe for more cleanups. It's a common enough
> issue that I think it's better if we have locking done in 1 place.
> Then host drivers can simply say if they need locking or not via some
> bus flag.

Yeah, you may be right.  I guess we don't have to make it an issue for
this patch; we do have pci_lock that protects this, whether the
write/read occurs in the driver or in
pci_generic_config_read32/write32.

Bjorn
