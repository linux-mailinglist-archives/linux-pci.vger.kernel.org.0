Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80AD42C8C0
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 20:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhJMShV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 14:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhJMShV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 14:37:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D17E560F21;
        Wed, 13 Oct 2021 18:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634150117;
        bh=9Otllm2GC3gVjaVzNTWWyjCLCOdkUBQMvbyes4AWr7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TZ1hgMEieNxKVh5cK/xTkyTn161II9RBtSuwzvap2XAIWDC5IRQ+XIIj9OXuRjXU1
         kOw8PX0y7ksY77hGOZHf4CvA4YMAYkbrw5Bm6fBs6hEJim5geLBFf0HqfiM5XGVC87
         5gcaLEKynNJ9osbadNfjvDFDOJJWcxxepQY/jKygG7kBFHwdXqaxLdIPL21fmy3ew4
         WEdeJ+DfeDfyGJSvznhCur9Mlnmhwcvtv8d5PF8oQ+1dW+1ljZlSJDBVQq321AXfVX
         DRbYBQKSXydmYylkx3ZKuEurnwWnm9bTC8Ghh2DVZkU650OWxEDcoIZlPJVKH8Wtoi
         M3SeiMcHbty4g==
Date:   Wed, 13 Oct 2021 13:35:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        qizhong.cheng@mediatek.com, Ryan-JH.Yu@mediatek.com,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Disable DVFSRC voltage request
Message-ID: <20211013183515.GA1907868@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013075328.12273-1-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 13, 2021 at 03:53:28PM +0800, Jianjun Wang wrote:
> When the DVFSRC feature is not implemented, the MAC layer will
> assert a voltage request signal when exit from the L1ss state,
> but cannot receive the voltage ready signal, which will cause
> the link to fail to exit the L1ss state correctly.
> 
> Disable DVFSRC voltage request by default, we need to find
> a common way to enable it in the future.

Rewrap commit log to fill 75 columns.

Does "L1ss" above refer to L1.1 and L1.2?  If so, please say that
explicitly or say something like "L1 PM Substates" (the term used in
the PCIe spec) so it's clear.

This seems on the boundary of PCIe-specified things and Mediatek
implementation details, so I'm not sure what "DVFSRC," "MAC," and
"voltage request signal" mean.  Since I don't recognize those terms,
I'm guessing they are Mediatek-specific things.

But if they are things specified by the PCIe spec, please use the
exact names used in the spec.

> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> Tested-by: Qizhong Cheng <qizhong.cheng@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index f3aeb8d4eaca..79fb12fca6a9 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -79,6 +79,9 @@
>  #define PCIE_ICMD_PM_REG		0x198
>  #define PCIE_TURN_OFF_LINK		BIT(4)
>  
> +#define PCIE_MISC_CTRL_REG		0x348
> +#define PCIE_DISABLE_DVFSRC_VLT_REQ	BIT(1)
> +
>  #define PCIE_TRANS_TABLE_BASE_REG	0x800
>  #define PCIE_ATR_SRC_ADDR_MSB_OFFSET	0x4
>  #define PCIE_ATR_TRSL_ADDR_LSB_OFFSET	0x8
> @@ -297,6 +300,11 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
>  	val &= ~PCIE_INTX_ENABLE;
>  	writel_relaxed(val, port->base + PCIE_INT_ENABLE_REG);
>  
> +	/* Disable DVFSRC voltage request */
> +	val = readl_relaxed(port->base + PCIE_MISC_CTRL_REG);
> +	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
> +	writel_relaxed(val, port->base + PCIE_MISC_CTRL_REG);
> +
>  	/* Assert all reset signals */
>  	val = readl_relaxed(port->base + PCIE_RST_CTRL_REG);
>  	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
> -- 
> 2.25.1
> 
