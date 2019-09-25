Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05DF8BDA5D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2019 11:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfIYJAg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Sep 2019 05:00:36 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:34231 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfIYJAY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Sep 2019 05:00:24 -0400
Received: from windsurf (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id A5CD4100009;
        Wed, 25 Sep 2019 09:00:14 +0000 (UTC)
Date:   Wed, 25 Sep 2019 11:00:13 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Ley Foon Tan <lftan@altera.com>,
        Tom Joseph <tjoseph@cadence.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michal Simek <michal.simek@xilinx.com>,
        rfi@lists.rocketboards.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH 06/11] PCI: of: Add inbound resource parsing to helpers
Message-ID: <20190925110013.43ffbce6@windsurf>
In-Reply-To: <20190924214630.12817-7-robh@kernel.org>
References: <20190924214630.12817-1-robh@kernel.org>
        <20190924214630.12817-7-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 24 Sep 2019 16:46:25 -0500
Rob Herring <robh@kernel.org> wrote:

> Extend devm_of_pci_get_host_bridge_resources() and
> pci_parse_request_of_pci_ranges() helpers to also parse the inbound
> addresses from DT 'dma-ranges' and populate a resource list with the
> translated addresses. This will help ensure 'dma-ranges' is always
> parsed in a consistent way.
> 
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Toan Le <toan@os.amperecomputing.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Tom Joseph <tjoseph@cadence.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
> Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: rfi@lists.rocketboards.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c |  3 +-
>  drivers/pci/controller/pci-aardvark.c         |  2 +-
>  drivers/pci/controller/pci-ftpci100.c         |  3 +-
>  drivers/pci/controller/pci-host-common.c      |  2 +-
>  drivers/pci/controller/pci-v3-semi.c          |  2 +-
>  drivers/pci/controller/pci-versatile.c        |  2 +-
>  drivers/pci/controller/pci-xgene.c            |  1 +
>  drivers/pci/controller/pcie-altera.c          |  2 +-
>  drivers/pci/controller/pcie-cadence-host.c    |  2 +-
>  drivers/pci/controller/pcie-iproc-platform.c  |  1 +
>  drivers/pci/controller/pcie-mediatek.c        |  2 +-
>  drivers/pci/controller/pcie-mobiveil.c        |  4 +-
>  drivers/pci/controller/pcie-rcar.c            |  3 +-
>  drivers/pci/controller/pcie-rockchip-host.c   |  3 +-
>  drivers/pci/controller/pcie-xilinx-nwl.c      |  2 +-
>  drivers/pci/controller/pcie-xilinx.c          |  2 +-
>  drivers/pci/of.c                              | 44 ++++++++++++++++++-
>  drivers/pci/pci.h                             |  8 +++-
>  include/linux/pci.h                           |  2 +
>  19 files changed, 72 insertions(+), 18 deletions(-)

for the AArdvark bits:

Tested-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
(on Armada 3720-DB, with a E1000E NIC)

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
