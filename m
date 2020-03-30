Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3221986C6
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 23:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgC3Vr0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 17:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbgC3Vr0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 17:47:26 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F53720733;
        Mon, 30 Mar 2020 21:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585604845;
        bh=6/8IMtsBYVs/ZL7NiDKLX3paM96z8lTPX2wEv7zaKfU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t8W4J+XQjr3z6eAglVlitJGmOmiJZMSlDej7zIE58C/b82pmZeKp+W3rh1wAFg5vA
         LlMSCCG7EKzxQFuYai0lVPqaCSMbissPGkxXDtelwI0osColYKtQr0s3yMK5Yuc8XN
         OgW3SItZrsnVux2srolpCsfeCzPR876KzCDRS4qI=
Date:   Mon, 30 Mar 2020 16:47:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 5/5] PCI: tegra: Add support for PCIe endpoint mode in
 Tegra194
Message-ID: <20200330214721.GA128269@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303181052.16134-6-vidyas@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 03, 2020 at 11:40:52PM +0530, Vidya Sagar wrote:
> Add support for the endpoint mode of Synopsys DesignWare core based
> dual mode PCIe controllers present in Tegra194 SoC.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> V5:
> * Added Acked-by: Thierry Reding <treding@nvidia.com>
> * Removed unwanted header file inclusion
> 
> V4:
> * Addressed Lorenzo's review comments
> * Started using threaded irqs instead of kthreads
> 
> V3:
> * Addressed Thierry's review comments
> 
> V2:
> * Addressed Bjorn's review comments
> * Made changes as part of addressing review comments for other patches
> 
>  drivers/pci/controller/dwc/Kconfig         |  30 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c | 679 ++++++++++++++++++++-
>  2 files changed, 691 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 0830dfcfa43a..169cde58dd92 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -248,14 +248,38 @@ config PCI_MESON
>  	  implement the driver.
>  
>  config PCIE_TEGRA194
> -	tristate "NVIDIA Tegra194 (and later) PCIe controller"
> +	tristate
> +
> +config PCIE_TEGRA194_HOST
> +	tristate "NVIDIA Tegra194 (and later) PCIe controller - Host Mode"
>  	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	select PHY_TEGRA194_P2U
> +	select PCIE_TEGRA194
> +	default y

Sorry I missed this before, but why is this "default y"?  From
Documentation/kbuild/kconfig-language.rst:

  The default value deliberately defaults to 'n' in order to avoid
  bloating the build. With few exceptions, new config options should
  not change this. The intent is for "make oldconfig" to add as little
  as possible to the config from release to release.

I do see that several other things in other drivers/pci/ Kconfig files
are also "default y", and we should probably change some of them.  But
I don't want to add even more unless there's a good reason.

I'm not looking for more reactions like these:

https://lore.kernel.org/r/CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com
https://lore.kernel.org/r/CA+55aFzPpuHU1Nqd595SEQS=F+kXMzPs0Rba9FUgTodGxmXsgg@mail.gmail.com

Can you please update this patch to either remove the "default y" or
add the rationale for keeping it?

> +	help
> +	  Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
> +	  work in host mode. There are two instances of PCIe controllers in
> +	  Tegra194. This controller can work either as EP or RC. In order to
> +	  enable host-specific features PCIE_TEGRA194_HOST must be selected and
> +	  in order to enable device-specific features PCIE_TEGRA194_EP must be
> +	  selected. This uses the DesignWare core.
