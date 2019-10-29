Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EED8E92DE
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 23:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfJ2WM1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 18:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJ2WM0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 18:12:26 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DFA92054F;
        Tue, 29 Oct 2019 22:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572387146;
        bh=yEsO971/WTtVJLXlhquhSunZEYk3y36yVtfl9IyRQc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JQxF2ReJIJ7HE+ov3dSB9pHFT4qEi+2+PRmzDYx/wE97ofUZJlW9AL3HMlRzQ534u
         3INp7qC4QAwRRUAO0VGQTijuKTP3jKlSyVc2yKtF5bUgCIK3Y3FeNYPGxWXM2SjaNl
         djqjvmJIiduYTwavBL4KBL29ax5z4eFrsCgHSXDM=
Date:   Tue, 29 Oct 2019 17:12:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Christoph Hellwig <hch@infradead.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 19/25] PCI: of: Add inbound resource parsing to helpers
Message-ID: <20191029221224.GA117069@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029110751.GB27171@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 29, 2019 at 11:07:51AM +0000, Lorenzo Pieralisi wrote:
> On Mon, Oct 28, 2019 at 11:32:50AM -0500, Rob Herring wrote:
> > Extend devm_of_pci_get_host_bridge_resources() and
> > pci_parse_request_of_pci_ranges() helpers to also parse the inbound
> > addresses from DT 'dma-ranges' and populate a resource list with the
> > translated addresses. This will help ensure 'dma-ranges' is always
> > parsed in a consistent way.
> > 
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Toan Le <toan@os.amperecomputing.com>
> > Cc: Ley Foon Tan <lftan@altera.com>
> > Cc: Tom Joseph <tjoseph@cadence.com>
> > Cc: Ray Jui <rjui@broadcom.com>
> > Cc: Scott Branden <sbranden@broadcom.com>
> > Cc: bcm-kernel-feedback-list@broadcom.com
> > Cc: Ryder Lee <ryder.lee@mediatek.com>
> > Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
> > Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Shawn Lin <shawn.lin@rock-chips.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > Cc: rfi@lists.rocketboards.org
> > Cc: linux-mediatek@lists.infradead.org
> > Cc: linux-renesas-soc@vger.kernel.org
> > Cc: linux-rockchip@lists.infradead.org
> > Tested-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com> # for AArdvark
> > Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> > Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> >  - Fix crash in INIT_LIST_HEAD when ib_resources is NULL
> > ---
> >  .../pci/controller/dwc/pcie-designware-host.c |  3 +-
> >  drivers/pci/controller/pci-aardvark.c         |  2 +-
> >  drivers/pci/controller/pci-ftpci100.c         |  3 +-
> >  drivers/pci/controller/pci-host-common.c      |  2 +-
> >  drivers/pci/controller/pci-v3-semi.c          |  3 +-
> >  drivers/pci/controller/pci-versatile.c        |  3 +-
> >  drivers/pci/controller/pci-xgene.c            |  3 +-
> >  drivers/pci/controller/pcie-altera.c          |  2 +-
> >  drivers/pci/controller/pcie-cadence-host.c    |  2 +-
> >  drivers/pci/controller/pcie-iproc-platform.c  |  3 +-
> >  drivers/pci/controller/pcie-mediatek.c        |  2 +-
> >  drivers/pci/controller/pcie-mobiveil.c        |  3 +-
> >  drivers/pci/controller/pcie-rcar.c            |  3 +-
> >  drivers/pci/controller/pcie-rockchip-host.c   |  3 +-
> >  drivers/pci/controller/pcie-xilinx-nwl.c      |  3 +-
> >  drivers/pci/controller/pcie-xilinx.c          |  3 +-
> >  drivers/pci/of.c                              | 45 ++++++++++++++++++-
> >  drivers/pci/pci.h                             |  8 +++-
> >  include/linux/pci.h                           |  9 ++--
> >  19 files changed, 82 insertions(+), 23 deletions(-)
> 
> Hi Bjorn,
> 
> please let me know if you are OK with this patch, the series is
> ready to go upstream IMO.

Yep, looks good to me.  If you want it:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
