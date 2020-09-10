Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C55264A37
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIJQsN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 12:48:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37239 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIJQsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 12:48:01 -0400
Received: by mail-io1-f65.google.com with SMTP id y13so7853527iow.4;
        Thu, 10 Sep 2020 09:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8fGVKyujTXfspLo9JJxZPzvPko08bc51xw+f5J3oCdk=;
        b=HlVE4pEp0qLe9fJp9qEuw540NgYxi6sd5xsUsV8yV3BOk/qiamWT/MhNDO6iGT+it7
         gOGpFpZmV2338ILARRSqcSOnyw6ge8fNh4l+x8P4Ojs1Tk3+o6I48jEtRS+1ouWAO7Fc
         p0h/zXva7RPFnzslAku3w2mTU7scHyDjo7T3Ru/9qPLiQ215spEA8D8QeW5zhUfksp4R
         I3PhlgCHgtUkcNxPhhTHi0ZNQ54SXtT7uzy1tU7mt6RW/Ef5xG32t1hHqm1GSoccLGnb
         htVQkbSIY9b2EQi69UtPzCpe1AwaN+1LLNBUblostVKKGBcA21Se2jOkS9+xGjSB2y9E
         /pUA==
X-Gm-Message-State: AOAM533XyxfSmt55e1nX6GK9cr3foXHS5Y9RYllpBulCzBmGBc3/KcyB
        nJFjpDSz+hI0uVSGaQFFkw==
X-Google-Smtp-Source: ABdhPJwkuwX0aPaAkSbWdGm7o1Ri1aLdjcJ5kGgtZ1S+LH4iKuSnnyuKFwKcAm7mIz2wxQQQ1TSTTg==
X-Received: by 2002:a5d:8245:: with SMTP id n5mr2399112ioo.149.1599756474870;
        Thu, 10 Sep 2020 09:47:54 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id d23sm3039062ioh.22.2020.09.10.09.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 09:47:53 -0700 (PDT)
Received: (nullmailer pid 505061 invoked by uid 1000);
        Thu, 10 Sep 2020 16:47:51 -0000
Date:   Thu, 10 Sep 2020 10:47:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
        kishon@ti.com, gustavo.pimentel@synopsys.com, roy.zang@nxp.com,
        jingoohan1@gmail.com, andrew.murray@arm.com, mingkai.hu@nxp.com,
        minghuan.Lian@nxp.com, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv7 10/12] arm64: dts: layerscape: Add PCIe EP node for
 ls1088a
Message-ID: <20200910164751.GA501845@bogus>
References: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
 <20200811095441.7636-11-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811095441.7636-11-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 11, 2020 at 05:54:39PM +0800, Zhiqiang Hou wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> Add PCIe EP node for ls1088a to support EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V7:
>  - Rebase the patch without functionality change.
> 
>  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 169f4742ae3b..915592141f1b 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -499,6 +499,17 @@
>  			status = "disabled";
>  		};
>  
> +		pcie_ep@3400000 {

pci-ep@...

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
> +		pcie_ep@3500000 {
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
> +		pcie_ep@3600000 {
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
