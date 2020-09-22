Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CE9274D4E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 01:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgIVX1S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 19:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVX1S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 19:27:18 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26C4A22206;
        Tue, 22 Sep 2020 23:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600817237;
        bh=eyyVOuMbNc1KJWbqEKXbyHjr+ZDT6KvrtdZF4IV+YD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UX2E/qqkeJV5RuPr5PrBorxSb4xqxjH+GncQQIylk6kNaMTYsu6+IbfACIL8K7wud
         2bGgZOh17h8fepORLcnLn8Q+XEdLcpLDZbEpPaV3phCB7TK3Ma5wEWeBv75I7fdjbP
         OIFefsO0cM42QWj9cAQJQ4EghDUmg5WOL6VomFSk=
Date:   Tue, 22 Sep 2020 18:27:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-rockchip@lists.infradead.org,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Robert Richter <rrichter@marvell.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] PCI: Unify ECAM constants in native PCI Express drivers
Message-ID: <20200922232715.GA2238688@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200905204416.GA83847@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob, who's doing a lot of cleanup in these drivers]

On Sat, Sep 05, 2020 at 10:44:16PM +0200, Krzysztof Wilczyński wrote:
> Hello Jonathan,
> 
> Thank you for the review!  Also, apologies for late reply.
> 
> On 20-08-28 10:08:43, Jonathan Cameron wrote:
> [...]
> > 
> > Might potentially be worth tidying up the masks as well?
> > Or potentially drop them given I suspect that there are no cases
> > in which the mask is actually doing anything...
> 
> Just to confirm - you have the following constants in mind?
> 
> drivers/pci/controller/pcie-rockchip.h:
> 
> #define PCIE_ECAM_BUS(x)	(((x) & 0xff) << 20)
> #define PCIE_ECAM_DEV(x)	(((x) & 0x1f) << 15)
> #define PCIE_ECAM_FUNC(x)	(((x) & 0x7) << 12)
> 
> drivers/pci/controller/dwc/pcie-al.c:
> 
> #define PCIE_ECAM_DEVFN(x)	(((x) & 0xff) << 12)
> 
> I can move PCIE_ECAM_BUS, PCIE_ECAM_DEV and PCIE_ECAM_FUNC (as
> PCIE_ECAM_FUN) to the linux/pci-ecam.h file, as these seem useful, but
> without the masks, and then update other files to use these.  We could
> then leverage these, for example:
> 
>  	pci_base_addr = (void __iomem *)((uintptr_t)pp->va_cfg0_base +
> -					 (busnr_ecam << 20) +
> -					 PCIE_ECAM_DEVFN(devfn));
> +					 PCIE_ECAM_BUS(busnr_ecam) +
> +					 PCIE_ECAM_FUN(devfn));
> 
> What do you think?  Bjorn, would that be acceptable?

It would be nice to use the same style and same macros for all of
the following, which are all really doing the same thing:

  al_pcie_conf_addr_map()
    pci_base_addr = (void __iomem *)((uintptr_t)pp->va_cfg0_base +
				     (busnr_ecam << 20) +
				     PCIE_ECAM_DEVFN(devfn));

  rockchip_pcie_rd_other_conf()
    busdev = PCIE_ECAM_ADDR(bus->number, PCI_SLOT(devfn),
			    PCI_FUNC(devfn), where);

  nwl_pcie_map_bus()
    relbus = (bus->number << ECAM_BUS_LOC_SHIFT) |
		    (devfn << ECAM_DEV_LOC_SHIFT);

    return pcie->ecam_base + relbus + where;

  xilinx_pcie_map_bus()
    relbus = (bus->number << ECAM_BUS_NUM_SHIFT) |
	     (devfn << ECAM_DEV_NUM_SHIFT);

    return port->reg_base + relbus + where;

Maybe that's something like using PCIE_ECAM_ADDR() everywhere?  I'm
not sure there's value in having the caller do the PCI_SLOT() and
PCI_FUNC() decomposition, though, i.e., maybe it's something like
this?

  #define PCIE_ECAM_REG(x)  ((x) & 0xfff)

  #define PCI_ECAM_OFFSET(bus, devfn, where) \
    PCIE_ECAM_BUS(bus->number) | \
    PCIE_ECAM_DEVFN(devfn) | \
    PCIE_ECAM_REG(where)
