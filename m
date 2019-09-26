Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29355BEDC8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 10:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfIZItD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 04:49:03 -0400
Received: from foss.arm.com ([217.140.110.172]:42610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfIZItD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Sep 2019 04:49:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D1901000;
        Thu, 26 Sep 2019 01:49:02 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 785163F67D;
        Thu, 26 Sep 2019 01:49:01 -0700 (PDT)
Date:   Thu, 26 Sep 2019 09:49:00 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-rockchip@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Simon Horman <horms@verge.net.au>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Scott Branden <sbranden@broadcom.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        rfi@lists.rocketboards.org, linux-renesas-soc@vger.kernel.org,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 00/11] PCI dma-ranges parsing consolidation
Message-ID: <20190926084859.GB9720@e119886-lin.cambridge.arm.com>
References: <20190924214630.12817-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924214630.12817-1-robh@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 24, 2019 at 04:46:19PM -0500, Rob Herring wrote:
> This series moves the DT 'dma-ranges' parsing into common helpers
> utilizing a resource list. In the process of doing this, I noticed
> several cases where pci_parse_request_of_pci_ranges() could be used so
> I converted those drivers first. The last 5 patches make the actual
> change to use the common 'dma_ranges' resource list. There's no
> (intended) functional change in this series though I'm also working on
> a separate series to improve the handling of 'dma-ranges' and dma
> masks.
> 
> pci-rcar-gen2 is the only remaining driver doing its own dma-ranges
> handling as it is still using the old ARM PCI functions. Looks like it
> is the last one (in drivers/pci/).

It also seems that pcie-tango is using of_pci_dma_range_parser_init
and so parsing dma-ranges. Though it's using the dma_ranges for a
slightly different purpose.

Thanks,

Andrew Murray

> 
> Compile tested only.
> 
> Rob
> 
> Rob Herring (11):
>   PCI: aardvark: Use pci_parse_request_of_pci_ranges()
>   PCI: altera: Use pci_parse_request_of_pci_ranges()
>   PCI: mediatek: Use pci_parse_request_of_pci_ranges()
>   PCI: versatile: Enable COMPILE_TEST
>   PCI: versatile: Use pci_parse_request_of_pci_ranges()
>   PCI: of: Add inbound resource parsing to helpers
>   PCI: ftpci100: Use inbound resources for setup
>   PCI: v3-semi: Use inbound resources for setup
>   PCI: xgene: Use inbound resources for setup
>   PCI: iproc: Use inbound resources for setup
>   PCI: rcar: Use inbound resources for setup
> 
>  drivers/pci/controller/Kconfig                |  2 +-
>  .../pci/controller/dwc/pcie-designware-host.c |  3 +-
>  drivers/pci/controller/pci-aardvark.c         | 58 ++---------------
>  drivers/pci/controller/pci-ftpci100.c         | 29 ++++-----
>  drivers/pci/controller/pci-host-common.c      |  2 +-
>  drivers/pci/controller/pci-v3-semi.c          | 40 +++++-------
>  drivers/pci/controller/pci-versatile.c        | 62 ++++--------------
>  drivers/pci/controller/pci-xgene.c            | 33 ++++------
>  drivers/pci/controller/pcie-altera.c          | 38 +----------
>  drivers/pci/controller/pcie-cadence-host.c    |  2 +-
>  drivers/pci/controller/pcie-iproc-platform.c  |  1 +
>  drivers/pci/controller/pcie-iproc.c           | 63 +++----------------
>  drivers/pci/controller/pcie-mediatek.c        | 47 +++++---------
>  drivers/pci/controller/pcie-mobiveil.c        |  4 +-
>  drivers/pci/controller/pcie-rcar.c            | 48 ++++++--------
>  drivers/pci/controller/pcie-rockchip-host.c   |  3 +-
>  drivers/pci/controller/pcie-xilinx-nwl.c      |  2 +-
>  drivers/pci/controller/pcie-xilinx.c          |  2 +-
>  drivers/pci/of.c                              | 44 ++++++++++++-
>  drivers/pci/pci.h                             |  8 ++-
>  include/linux/pci.h                           |  2 +
>  21 files changed, 162 insertions(+), 331 deletions(-)
> 
> --
> 2.20.1
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
