Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BEE5045C5
	for <lists+linux-pci@lfdr.de>; Sun, 17 Apr 2022 01:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiDPXd0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 19:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiDPXdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 19:33:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72722C105;
        Sat, 16 Apr 2022 16:30:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89FC1B80A0B;
        Sat, 16 Apr 2022 23:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E860DC385A3;
        Sat, 16 Apr 2022 23:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650151849;
        bh=nd58mF27wY5dwLAgcNLOqzjElU7YpZR3Sqgx6KMTHsQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CxkZ57ZY0YSf0tqM3LLSzmXfOTlRCIFafAFh8ewm7kECNWlAsOQD0hn8/YaEa8D4/
         AkZ/SBqlDh/2qX0SyhIKeKoPhP+u06oXkDlw+w57iVvLuG0o8JcwQxqr56MtjN7s2D
         IgFYIjIrJmvRY7bWhgVfaXR8KWnPWhMheaW8ePLY1tbfBcEokJrVf9lZ4DhFvdihXV
         9BFdl8PU4cWHxHRFiit2boF1OrYIEUFhWXF53ey1CcV3B+LYW2EbAsx68TkMTvO3f3
         6osWFM2d7qpf4Z4laoiC86U+Wsm194awp7BmnnCYBtVPaiKVzgrtjDs/FWrBW2Ipe6
         /Iu4b2l2XBuEg==
Date:   Sat, 16 Apr 2022 18:30:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [RFC/RFT 4/6] PCI: rockchip-dwc: add pcie bifurcation
Message-ID: <20220416233047.GA938296@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416135458.104048-5-linux@fw-web.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 16, 2022 at 03:54:56PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> PCIe Lanes can be split to 2 slots with bifurcation.
> Add support for this in existing pcie driver.

Please s/pcie/PCIe/ in subject and above to be consistent.  You also
have kind of a random usage in other patches.

Mention the DT property used for this in the commit log.

Is the "rockchip,bifurcation" DT property something that should be
generalized so it's not rockchip-specific?  Other controllers are
likely to support similar functionality.

> Co-developed-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 863374604fb1..1b0c2115b32e 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> +#include <linux/phy/pcie.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -59,6 +60,7 @@ struct rockchip_pcie {
>  	struct regulator                *vpcie3v3;
>  	struct irq_domain		*irq_domain;
>  	raw_spinlock_t			irq_lock;
> +	bool				bifurcation;
>  };
>  
>  static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
> @@ -273,6 +275,12 @@ static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
>  		return dev_err_probe(dev, PTR_ERR(rockchip->phy),
>  				     "missing PHY\n");
>  
> +	if (rockchip->bifurcation) {
> +		ret = phy_set_mode_ext(rockchip->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_BIFURCATION);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = phy_init(rockchip->phy);
>  	if (ret < 0)
>  		return ret;
> @@ -345,6 +353,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (device_property_read_bool(dev, "rockchip,bifurcation"))
> +		rockchip->bifurcation = true;
> +
>  	ret = rockchip_pcie_phy_init(rockchip);
>  	if (ret)
>  		goto disable_regulator;
> -- 
> 2.25.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy
