Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D982771CE
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 15:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgIXNHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 09:07:41 -0400
Received: from foss.arm.com ([217.140.110.172]:45824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbgIXNHl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 09:07:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F31212FC;
        Thu, 24 Sep 2020 06:07:41 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E4223F718;
        Thu, 24 Sep 2020 06:07:38 -0700 (PDT)
Date:   Thu, 24 Sep 2020 14:07:34 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
        kishon@ti.com, leoyang.li@nxp.com, gustavo.pimentel@synopsys.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, andrew.murray@arm.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv8 10/12] arm64: dts: layerscape: Add PCIe EP node for
 ls1088a
Message-ID: <20200924130734.GA17981@e121166-lin.cambridge.arm.com>
References: <20200918080024.13639-1-Zhiqiang.Hou@nxp.com>
 <20200918080024.13639-11-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918080024.13639-11-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 18, 2020 at 04:00:22PM +0800, Zhiqiang Hou wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> Add PCIe EP node for ls1088a to support EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> ---
> V8:
>  - s/pcie_ep/pcie-ep.
> 
>  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)

Dropped this patch. dts files updates should be sent via arm-soc along
with platform support.

Thanks,
Lorenzo

> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 169f4742ae3b..f21dd143ab6d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -499,6 +499,17 @@
>  			status = "disabled";
>  		};
>  
> +		pcie-ep@3400000 {
> +			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";
> +			reg = <0x00 0x03400000 0x0 0x00100000
> +			       0x20 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			num-ib-windows = <24>;
> +			num-ob-windows = <128>;
> +			max-functions = /bits/ 8 <2>;
> +			status = "disabled";
> +		};
> +
>  		pcie@3500000 {
>  			compatible = "fsl,ls1088a-pcie";
>  			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
> @@ -525,6 +536,16 @@
>  			status = "disabled";
>  		};
>  
> +		pcie-ep@3500000 {
> +			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";
> +			reg = <0x00 0x03500000 0x0 0x00100000
> +			       0x28 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			num-ib-windows = <6>;
> +			num-ob-windows = <8>;
> +			status = "disabled";
> +		};
> +
>  		pcie@3600000 {
>  			compatible = "fsl,ls1088a-pcie";
>  			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
> @@ -551,6 +572,16 @@
>  			status = "disabled";
>  		};
>  
> +		pcie-ep@3600000 {
> +			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";
> +			reg = <0x00 0x03600000 0x0 0x00100000
> +			       0x30 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			num-ib-windows = <6>;
> +			num-ob-windows = <8>;
> +			status = "disabled";
> +		};
> +
>  		smmu: iommu@5000000 {
>  			compatible = "arm,mmu-500";
>  			reg = <0 0x5000000 0 0x800000>;
> -- 
> 2.17.1
> 
