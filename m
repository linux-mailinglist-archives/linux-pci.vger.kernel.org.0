Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF0D23081A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgG1KvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 06:51:25 -0400
Received: from foss.arm.com ([217.140.110.172]:60798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbgG1KvZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 06:51:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 692271FB;
        Tue, 28 Jul 2020 03:51:24 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A21B3F66E;
        Tue, 28 Jul 2020 03:51:21 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:51:18 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Anson Huang <Anson.Huang@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     catalin.marinas@arm.com, will@kernel.org, robh@kernel.org,
        bhelgaas@google.com, p.zabel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        bjorn.andersson@linaro.org, leoyang.li@nxp.com, vkoul@kernel.org,
        geert+renesas@glider.be, olof@lixom.net,
        amurray@thegoodpenguin.co.uk, treding@nvidia.com,
        vidyas@nvidia.com, hayashi.kunihiko@socionext.com,
        jonnyc@amazon.com, eswara.kota@linux.intel.com, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V3 3/3] pci: imx: Select RESET_IMX7 by default
Message-ID: <20200728105118.GB905@e121166-lin.cambridge.arm.com>
References: <1595254921-26050-1-git-send-email-Anson.Huang@nxp.com>
 <1595254921-26050-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595254921-26050-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[CCing IMX6 maintainers]

On Mon, Jul 20, 2020 at 10:22:01PM +0800, Anson Huang wrote:
> i.MX7 reset driver now supports module build and it is no longer
> built in by default, so i.MX PCI driver needs to select it explicitly
> due to it is NOT supporting loadable module currently.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
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
