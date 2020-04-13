Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE01A6D35
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 22:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbgDMUZu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 16:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388320AbgDMUZt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Apr 2020 16:25:49 -0400
Received: from localhost (mobile-166-175-184-103.mycingular.net [166.175.184.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA2220663;
        Mon, 13 Apr 2020 20:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586809549;
        bh=7PcGTf+Br3iofGrHqpT1Lk86E7HQeOdsnGtnmkXmQXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=at1uT8/PSg/+IWjPO7DOJs5nfPYZthY1ltxXmI5cn1TByUbMH4Uqus6jTmfnvKdbx
         fPnj04MTgRm1UPZAc2+zQdLr+uHnTLQVgryUeGLtrK02GEsQpuO4MYFsO3a4+mCf8m
         qNA5QJvKmPUCDr/YMcvS4/dfyC3ORWClhg6vO+Z4=
Date:   Mon, 13 Apr 2020 15:25:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     devicetree@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] drivers: pci: dwc: pci-imx6: update binding to
 generic name
Message-ID: <20200413202546.GA147401@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410004738.19668-3-ansuelsmth@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If/when you repost this, please update the subject to match the
convention:

  $ git log --oneline drivers/pci/controller/dwc/pci-imx6.c
  2170a09fb4b0 PCI: imx6: Propagate errors for optional regulators
  075af61c19cd PCI: imx6: Limit DBI register length
  1b8df7aa7874 PCI: imx6: Allow asynchronous probing
  87cb312777b5 PCI: imx6: Use usleep_range() in imx6_pcie_enable_ref_clk()

As Fabio pointed out, we can't break backward compatibility without a
good reason.

On Fri, Apr 10, 2020 at 02:47:36AM +0200, Ansuel Smith wrote:
> Rename specific bindings to generic name.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index acfbd34032a8..4ac140e007b4 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1146,28 +1146,28 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Grab PCIe PHY Tx Settings */
> -	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
> +	if (of_property_read_u32(node, "tx-deemph-gen1",
>  				 &imx6_pcie->tx_deemph_gen1))
>  		imx6_pcie->tx_deemph_gen1 = 0;
>  
> -	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-3p5db",
> +	if (of_property_read_u32(node, "tx-deemph-gen2-3p5db",
>  				 &imx6_pcie->tx_deemph_gen2_3p5db))
>  		imx6_pcie->tx_deemph_gen2_3p5db = 0;
>  
> -	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-6db",
> +	if (of_property_read_u32(node, "tx-deemph-gen2-6db",
>  				 &imx6_pcie->tx_deemph_gen2_6db))
>  		imx6_pcie->tx_deemph_gen2_6db = 20;
>  
> -	if (of_property_read_u32(node, "fsl,tx-swing-full",
> +	if (of_property_read_u32(node, "tx-swing-full",
>  				 &imx6_pcie->tx_swing_full))
>  		imx6_pcie->tx_swing_full = 127;
>  
> -	if (of_property_read_u32(node, "fsl,tx-swing-low",
> +	if (of_property_read_u32(node, "tx-swing-low",
>  				 &imx6_pcie->tx_swing_low))
>  		imx6_pcie->tx_swing_low = 127;
>  
>  	/* Limit link speed */
> -	ret = of_property_read_u32(node, "fsl,max-link-speed",
> +	ret = of_property_read_u32(node, "max-link-speed",
>  				   &imx6_pcie->link_gen);
>  	if (ret)
>  		imx6_pcie->link_gen = 1;
> -- 
> 2.25.1
> 
