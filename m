Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9332603DF
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 19:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgIGLWB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 07:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbgIGLV6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 07:21:58 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 834A0206D4;
        Mon,  7 Sep 2020 11:21:21 +0000 (UTC)
Date:   Mon, 7 Sep 2020 12:21:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     George Cherian <gcherian@marvell.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [PATCH] arm64: PCI: fix memleak when calling pci_iomap/unmap()
Message-ID: <20200907112118.GD26513@gaia>
References: <20200907104546.GC26513@gaia>
 <BYAPR18MB267959E6FE4BEF38D0A4611EC5280@BYAPR18MB2679.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR18MB267959E6FE4BEF38D0A4611EC5280@BYAPR18MB2679.namprd18.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Lorenzo

On Mon, Sep 07, 2020 at 10:51:21AM +0000, George Cherian wrote:
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Sat, Sep 05, 2020 at 10:48:11AM +0800, Yang Yingliang wrote:
> > > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c index
> > > 1006ed2d7c604..ddfa1c53def48 100644
> > > --- a/arch/arm64/kernel/pci.c
> > > +++ b/arch/arm64/kernel/pci.c
> > > @@ -217,4 +217,9 @@ void pcibios_remove_bus(struct pci_bus *bus)
> > >  	acpi_pci_remove_bus(bus);
> > >  }
> > >
> > > +void pci_iounmap(struct pci_dev *dev, void __iomem *addr) {
> > > +	iounmap(addr);
> > > +}
> > > +EXPORT_SYMBOL(pci_iounmap);
> > 
> > So, what's wrong with the generic pci_iounmap() implementation?
> > Shouldn't it call iounmap() already?
> 
> Since ARM64 selects CONFIG_GENERIC_PCI_IOMAP and not
> CONFIG_GENERIC_IOMAP,  the pci_iounmap function is reduced to a NULL
> function. Due to this, even the managed release variants or even the explicit
> pci_iounmap calls doesn't really remove the mappings leading to leak.

Ah, I missed the fact that pci_iounmap() depends on a different
config option.

> https://lkml.org/lkml/2020/8/20/28

So is this going to be fixed in the generic code? That would be my
preference.

A problem with the iounmap() in the proposed patch is that the region
may have been an I/O port, so we could end up unmapping the I/O space.

-- 
Catalin
