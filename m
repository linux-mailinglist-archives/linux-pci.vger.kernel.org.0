Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841D43A36AD
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 23:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFJVwl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 17:52:41 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45066 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhFJVwl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 17:52:41 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lrSZV-0006lk-N8; Thu, 10 Jun 2021 23:50:41 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     helgaas@kernel.org, robh+dt@kernel.org,
        Punit Agrawal <punitagrawal@gmail.com>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com
Subject: Re: [PATCH v3 4/4] arm64: dts: rockchip: Update PCI host bridge window to 32-bit address memory
Date:   Thu, 10 Jun 2021 23:50:40 +0200
Message-ID: <3105233.izSxrag8PF@diego>
In-Reply-To: <20210607112856.3499682-5-punitagrawal@gmail.com>
References: <20210607112856.3499682-1-punitagrawal@gmail.com> <20210607112856.3499682-5-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Am Montag, 7. Juni 2021, 13:28:56 CEST schrieb Punit Agrawal:
> The PCIe host bridge on RK3399 advertises a single 64-bit memory
> address range even though it lies entirely below 4GB.
> 
> Previously the OF PCI range parser treated 64-bit ranges more
> leniently (i.e., as 32-bit), but since commit 9d57e61bf723 ("of/pci:
> Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses")
> the code takes a stricter view and treats the ranges as advertised in
> the device tree (i.e, as 64-bit).
> 
> The change in behaviour causes failure when allocating bus addresses
> to devices connected behind a PCI-to-PCI bridge that require
> non-prefetchable memory ranges. The allocation failure was observed
> for certain Samsung NVMe drives connected to RockPro64 boards.
> 
> Update the host bridge window attributes to treat it as 32-bit address
> memory. This fixes the allocation failure observed since commit
> 9d57e61bf723.
> 
> Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Rob Herring <robh+dt@kernel.org>

just for clarity, should I just pick this patch separately for 5.13-rc to
make it easy for people using current kernel devicetrees, or should
this wait for the update mentioned in the cover-letter response
and should go all together through the PCI tree?

If so, I can provide an
Acked-by: Heiko Stuebner <heiko@sntech.de>



> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 634a91af8e83..4b854eb21f72 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -227,7 +227,7 @@ pcie0: pcie@f8000000 {
>  		       <&pcie_phy 2>, <&pcie_phy 3>;
>  		phy-names = "pcie-phy-0", "pcie-phy-1",
>  			    "pcie-phy-2", "pcie-phy-3";
> -		ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x1e00000>,
> +		ranges = <0x82000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x1e00000>,
>  			 <0x81000000 0x0 0xfbe00000 0x0 0xfbe00000 0x0 0x100000>;
>  		resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
>  			 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>,
> 




