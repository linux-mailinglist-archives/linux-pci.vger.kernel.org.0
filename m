Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D6323A8F8
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 16:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgHCOzL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 10:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgHCOzL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Aug 2020 10:55:11 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 941822076C;
        Mon,  3 Aug 2020 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596466509;
        bh=qjp447E1FdrQ1VZ023mmW0i+s+n2xlSEVcNx6++grCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=js72JAn2bH2xSm+hYcTQJGVkYXneeZJu3WaUZn6z6vYSOzv7YKwhBYVr6t9avSQXt
         qU1B6g/sav0/hQvP8lshLpuLg09vHpm0tBm1iPdgP8Oy8IOEVvOnZHpFaz1vJf+fWC
         OM3gS2l2KadBq5i7cExyeKjGHeiEM+cd7lXZK83k=
Date:   Mon, 3 Aug 2020 09:55:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        rfi@lists.rocketboards.org
Subject: Re: [PATCH 00/10] Remove surplus dev_err() when handing an error
 from platform_get_irq()
Message-ID: <20200803145508.GA332368@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200803020151.GA291575@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 02, 2020 at 09:01:51PM -0500, Bjorn Helgaas wrote:
> On Sun, Aug 02, 2020 at 02:25:52PM +0000, Krzysztof Wilczyński wrote:
> > At the moment a lot of error handling code would print a duplicated
> > error message should either the platform_get_irq() or
> > platform_get_irq_byname() function fails to obtain an IRQ for a device.
> > 
> > There is no need to call the dev_err() function directly to print
> > a custom message when handling an error from either of these functions
> > as both are going to display an appropriate error message in case of
> > a failure.
> > 
> > This series aims to remove surplus call to dev_err() when handing an
> > error originating from either platform_get_irq() or
> > platform_get_irq_byname() function as per suggestion from Coccinelle.
> > 
> > Related commits are commit 7723f4c5ecdb ("driver core: platform: Add an
> > error message to platform_get_irq*()") and commit 98051ba2b28b
> > ("coccinelle: Add script to check for platform_get_irq() excessive
> > prints").
> > 
> > Krzysztof Wilczyński (10):
> >   PCI: dwc: Remove dev_err() when handing an error from
> >     platform_get_irq()
> >   PCI: mobiveil: Remove dev_err() when handing an error from
> >     platform_get_irq()
> >   PCI: tegra: Remove dev_err() when handing an error from
> >     platform_get_irq()
> >   PCI: altera: Remove dev_err() when handing an error from
> >     platform_get_irq()
> >   PCI: host-generic: Remove dev_err() when handing an error from
> >     platform_get_irq()
> >   PCI: v3-semi: Remove dev_err() when handing an error from
> >     platform_get_irq()
> >   PCI: altera-msi: Remove dev_err() when handing an error from
> >     platform_get_irq()
> >   PCI: xgene-msi: Remove dev_err() when handing an error from
> >     platform_get_irq()
> >   PCI: rockchip: Remove dev_err() when handing an error from
> >     platform_get_irq()
> >   PCI: xilinx-nwl: Remove dev_err() when handing an error from
> >     platform_get_irq()
> > 
> >  drivers/pci/controller/dwc/pci-dra7xx.c              |  8 ++------
> >  drivers/pci/controller/dwc/pci-exynos.c              |  9 +++------
> >  drivers/pci/controller/dwc/pci-imx6.c                |  4 +---
> >  drivers/pci/controller/dwc/pci-keystone.c            |  4 +---
> >  drivers/pci/controller/dwc/pci-meson.c               |  4 +---
> >  drivers/pci/controller/dwc/pcie-armada8k.c           |  4 +---
> >  drivers/pci/controller/dwc/pcie-artpec6.c            |  4 +---
> >  drivers/pci/controller/dwc/pcie-histb.c              |  4 +---
> >  drivers/pci/controller/dwc/pcie-kirin.c              |  5 +----
> >  drivers/pci/controller/dwc/pcie-spear13xx.c          |  5 ++---
> >  drivers/pci/controller/dwc/pcie-tegra194.c           |  4 +---
> >  .../pci/controller/mobiveil/pcie-layerscape-gen4.c   |  5 ++---
> >  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c |  4 +---
> >  drivers/pci/controller/pci-tegra.c                   |  8 ++------
> >  drivers/pci/controller/pci-v3-semi.c                 |  5 ++---
> >  drivers/pci/controller/pci-xgene-msi.c               |  2 --
> >  drivers/pci/controller/pcie-altera-msi.c             |  1 -
> >  drivers/pci/controller/pcie-altera.c                 |  4 +---
> >  drivers/pci/controller/pcie-rockchip-host.c          | 12 +++---------
> >  drivers/pci/controller/pcie-tango.c                  |  4 +---
> >  drivers/pci/controller/pcie-xilinx-nwl.c             | 11 ++---------
> >  21 files changed, 29 insertions(+), 82 deletions(-)
> 
> I squashed these together and applied them to pci/irq-error for v5.9,
> thanks!
> 
> The cover letter claims there should be 10 patches, but I only got 9.
> Just FYI.

I picked up and applied 10/10 as well.  And added Jesper & Ley Foon's
reviewed-by and acked-by.  Thanks!
