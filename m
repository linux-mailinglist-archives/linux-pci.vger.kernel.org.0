Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD51624C57
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 22:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiKJVCp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 16:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiKJVCl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 16:02:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1098A45EE4;
        Thu, 10 Nov 2022 13:02:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9A1FB82381;
        Thu, 10 Nov 2022 21:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFFAC433C1;
        Thu, 10 Nov 2022 21:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668114157;
        bh=dFjwsB2x4Vktj11UP1nFbKy1JuZUspP3pjwcHIsSSnc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iJwMckJy0uCcByLR5dTqb/sLhh/p4neWekIYZaZ3yeonbwH09ch8EqoG8ecGOC/gh
         LxSdAJBLbKmEE3CXGDI3A7Vc6BCxXLJ/bsFq5hQJgqS/nai15IhiKGetEeKH4+vpT2
         j9Ld+7uAe0Uz9IipZQ/88pm8pLqURo9XzvxQWuunebeReJqpcbJfuCN8BWniAwIWF9
         a+ZwQoYjb1mS5vRmT3xSXjeYdGWxfBo/pZQHhYRV38fM2nHaPFfGhzmt8f50haLCEQ
         7sSMDQr3yt4Z74/HTNY4ceRxsq+32kGBXwaNszYjSX1Y2pvyiMxqjjRM7Gykh+Y6zM
         XSZjD4/Y6CHGA==
Date:   Thu, 10 Nov 2022 15:02:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Joyce Ooi <joyce.ooi@intel.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 0/5] PCI: Remove unnecessary <linux/of_irq.h> includes
Message-ID: <20221110210235.GA671572@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031153954.1163623-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 31, 2022 at 10:39:49AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Many host controller drivers #include <linux/of_irq.h> even though they
> don't need it.  Remove the unnecessary #includes.
> 
> v2: https://lore.kernel.org/r/20221025185147.665365-1-helgaas@kernel.org/
> v1: https://lore.kernel.org/r/20221019195452.37606-1-helgaas@kernel.org/
> 
> Changes from v2 to v3:
>   - Include <linux/irqdomain.h> explicitly in xgene-msi, which doesn't need
>     <linux/of_irq.h> itself, but relied on it to include
>     <linux/irqdomain.h>.  On x86, this was covered up by the fact that
>     <linux/msi.h> includes <asm/msi.h>, which includes <asm/irqdomain.h>,
>     which includes <linux/irqdomain.h>.  But on parisc, <asm/msi.h> is
>     actually asm-generic/msi.h, which does *not* include
>     <linux/irqdomain.h>
>   - Pick up tags from Conor Dooley and Thomas Petazzoni
> 
> Changes from v1 to v2:
>   - Include <linux/irqdomain.h> explicitly in altera-msi and microchip,
>     which don't need <linux/of_irq.h> itself, but relied on it to include
>     <linux/irqdomain.h>
>   - Include <linux/irqdomain.h> explicitly in mvebu, which needs both it
>     and <linux/of_irq.h>
> 
> Bjorn Helgaas (5):
>   PCI: altera-msi: Include <linux/irqdomain.h> explicitly
>   PCI: microchip: Include <linux/irqdomain.h> explicitly
>   PCI: mvebu: Include <linux/irqdomain.h> explicitly
>   PCI: xgene-msi: Include <linux/irqdomain.h> explicitly
>   PCI: Remove unnecessary <linux/of_irq.h> includes
> 
>  drivers/pci/controller/cadence/pci-j721e.c   | 1 -
>  drivers/pci/controller/dwc/pci-layerscape.c  | 1 -
>  drivers/pci/controller/dwc/pcie-armada8k.c   | 1 -
>  drivers/pci/controller/dwc/pcie-tegra194.c   | 1 -
>  drivers/pci/controller/pci-mvebu.c           | 1 +
>  drivers/pci/controller/pci-v3-semi.c         | 1 -
>  drivers/pci/controller/pci-xgene-msi.c       | 2 +-
>  drivers/pci/controller/pci-xgene.c           | 1 -
>  drivers/pci/controller/pcie-altera-msi.c     | 2 +-
>  drivers/pci/controller/pcie-iproc-platform.c | 1 -
>  drivers/pci/controller/pcie-iproc.c          | 1 -
>  drivers/pci/controller/pcie-microchip-host.c | 2 +-
>  drivers/pci/controller/pcie-rockchip-host.c  | 1 -
>  drivers/pci/controller/pcie-xilinx-cpm.c     | 1 -
>  drivers/pci/controller/pcie-xilinx-nwl.c     | 1 -
>  15 files changed, 4 insertions(+), 14 deletions(-)

I put these on a pci/kbuild branch that I propose to merge in after
everything else.  Lorenzo, let me know if you prefer another approach.

Bjorn
