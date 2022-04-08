Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD724F97DA
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 16:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiDHOUM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbiDHOUL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 10:20:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C53C35049F;
        Fri,  8 Apr 2022 07:18:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 565E2113E;
        Fri,  8 Apr 2022 07:18:07 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.11.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EED3C3F73B;
        Fri,  8 Apr 2022 07:18:05 -0700 (PDT)
Date:   Fri, 8 Apr 2022 15:18:09 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Punit Agrawal <punitagrawal@gmail.com>, shawn.lin@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>
Cc:     bhelgaas@google.com, robh@kernel.org, kw@linux.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip: Enable the phy driver when controller is
 enabled
Message-ID: <YlBEIfMl3BbeUNAV@lpieralisi>
References: <20211019120215.793794-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019120215.793794-1-punitagrawal@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 19, 2021 at 09:02:15PM +0900, Punit Agrawal wrote:
> The PCI controller on rk3399 requires the phy to correctly initialise
> the PCIE phy. Without phy initialisation the host and end-point
> controllers cannot be used.
> 
> To prevent building an unusable PCIe driver on rk3399, enable the phy
> driver when the host or end-point driver is enabled.
> 
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> ---
> Hi,
> 
> I've been caught out many times when booting off of PCI and finding
> that the kernel cannot find rootfs due to the missing phy driver. The
> patch should prevents this by fixing the Kconfig dependency
> enablement. 
> 
> Thanks,
> Punit
> 
>  drivers/pci/controller/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)

Shawn, Heiko,

can I go ahead with this patch please ?

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 326f7d13024f..1965df38c4a3 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -214,6 +214,7 @@ config PCIE_ROCKCHIP_HOST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select MFD_SYSCON
>  	select PCIE_ROCKCHIP
> +	select PHY_ROCKCHIP_PCIE
>  	help
>  	  Say Y here if you want internal PCI support on Rockchip SoC.
>  	  There is 1 internal PCIe port available to support GEN2 with
> @@ -226,6 +227,7 @@ config PCIE_ROCKCHIP_EP
>  	depends on PCI_ENDPOINT
>  	select MFD_SYSCON
>  	select PCIE_ROCKCHIP
> +	select PHY_ROCKCHIP_PCIE
>  	help
>  	  Say Y here if you want to support Rockchip PCIe controller in
>  	  endpoint mode on Rockchip SoC. There is 1 internal PCIe port
> -- 
> 2.33.0
> 
