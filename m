Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3497A20D2DC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jun 2020 21:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgF2SxE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 14:53:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbgF2SxD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jun 2020 14:53:03 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2087020656;
        Mon, 29 Jun 2020 18:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593456783;
        bh=AtlRuJKLlODGcf0YKJZLfj2RAej3mthtdV/MDVcMw4Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=D5mspzYz7Wk9Rrwkob53bTTIf0YdxQK699Y4YNft6y1B9ucikwsOU2AFa1F7eoySC
         mNJWCyhxn++LR0bUgvkTObNDVZgI+o7heUO+YKg3tK3eBowzAX6keVdy/lB8ceHesF
         sJkORmtTMG1Iwqvv/lyVwHzWpxVfnibZYEIzMayM=
Date:   Mon, 29 Jun 2020 13:53:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        p.zabel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        bjorn.andersson@linaro.org, leoyang.li@nxp.com, vkoul@kernel.org,
        geert+renesas@glider.be, olof@lixom.net, treding@nvidia.com,
        gustavo.pimentel@synopsys.com, amurray@thegoodpenguin.co.uk,
        vidyas@nvidia.com, xiaowei.bao@nxp.com, jonnyc@amazon.com,
        hayashi.kunihiko@socionext.com, eswara.kota@linux.intel.com,
        krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 3/3] pci: imx: Select RESET_IMX7 by default
Message-ID: <20200629185301.GA3280149@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593443129-18766-3-git-send-email-Anson.Huang@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If you post a V3, "git log --oneline
drivers/pci/controller/dwc/pci-imx6.c" says the subject line could be:

  PCI: imx6: Select CONFIG_RESET_IMX7

If you don't need a V3 for any other reason, whoever applies this
series might adjust that for you.

On Mon, Jun 29, 2020 at 11:05:29PM +0800, Anson Huang wrote:
> i.MX7 reset driver now supports module build and it is no longer
> built in by default, so i.MX PCI driver needs to select it explicitly
> due to it is NOT supporting loadable module currently.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch.
> ---
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 044a376..bcf63ce 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -90,6 +90,7 @@ config PCI_EXYNOS
>  
>  config PCI_IMX6
>  	bool "Freescale i.MX6/7/8 PCIe controller"
> +	select RESET_IMX7
>  	depends on ARCH_MXC || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
