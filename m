Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7113D24B5
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 15:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhGVM4Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 08:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhGVM4N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jul 2021 08:56:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D94C061798
        for <linux-pci@vger.kernel.org>; Thu, 22 Jul 2021 06:36:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nt18-20020a17090b2492b02901765d605e14so4588466pjb.5
        for <linux-pci@vger.kernel.org>; Thu, 22 Jul 2021 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dQRSdqJHeeMJDOz5ZSW1d87/+iZoLjHZ6vait6LUEHk=;
        b=QqQ7cjyEBhhilwQPaeIKg4zI0iccVErHES/cTqSQUz/6stMBRADT2U5nAtFHuPa71L
         LppY/2Vx3jWsKXN39pqFYA6nzsDMrfzDxKrI/Hi37lLpLrvs2lYuK+fxHGlShdFvbn4b
         FPeba056dapTjD/BQCiKyp9yhX6RZpxaFd/ELGzv0Ua9Cb196v2QLHjjXCiA9KBU97It
         v+ny/N+9RuXLBU2QhAXBjDBBc7JdYyPPVmjHrPRtMLW7ZuwyyYQ7Bw2aaIeMtgM6N5MR
         fRgmTu6oS+icDWY7eGx2h+6UJ1E3FQQ5yT2XNCm4I4Acem11RHFPATn3Z6JkYEcP6P2n
         7hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dQRSdqJHeeMJDOz5ZSW1d87/+iZoLjHZ6vait6LUEHk=;
        b=knqQUFrRubNRZ6exNNtjS8vT/KD2SGZ25Q6bppN7sISMiaowHLOWPHYxUmLdQPV2uT
         sfK/dFf6KRcPwCmJ+i0B+jlzwzAPEtVRG7N4v/Tm05F9AVNnwhlqG2fsBxWqi5mwUICM
         ZbKi5vqqhD6qK+9WUfwsdeGDfJssmemWzwhsoKWPOkgPr9xIvRwGOXa+VgdoOV3mirKf
         o4OS1dTcLYQU6JJXk42DfOdt9BOQsfpBzzbR6Sr3tzAgqpOKAHDciaD78x7DZt9CJ1bs
         J7E+t4z+bFLfkBjB1Brwr3/Dlpt8+k3Pq7Fn6EorKYuBB14vWyCZ6daUFRgqawsyuGyY
         5gZg==
X-Gm-Message-State: AOAM530lXi446h/R1QQGkStLkiLHE9cKw+GtVhOdL7qS2p+APMSpKCYc
        TjuycMZ4NnuvTqXnLXyK5IKs
X-Google-Smtp-Source: ABdhPJyPTv5G2MEh/0/fFEWI/KXocy6A6idw0FWeAcfor6Y7ixqS1F3Y65v4fdoBAkrzTQHD3PdAvA==
X-Received: by 2002:a17:90a:d244:: with SMTP id o4mr9278289pjw.71.1626960994386;
        Thu, 22 Jul 2021 06:36:34 -0700 (PDT)
Received: from workstation ([120.138.13.30])
        by smtp.gmail.com with ESMTPSA id p53sm30256597pfw.168.2021.07.22.06.36.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Jul 2021 06:36:33 -0700 (PDT)
Date:   Thu, 22 Jul 2021 19:06:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 08/10] arm64: dts: HiSilicon: Add support for HiKey
 970 PCIe controller hardware
Message-ID: <20210722133628.GC4446@workstation>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
 <e483ba44ed3d70e1f4ca899bb287fa38ee8a2876.1626855713.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e483ba44ed3d70e1f4ca899bb287fa38ee8a2876.1626855713.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 10:39:10AM +0200, Mauro Carvalho Chehab wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Add DTS bindings for the HiKey 970 board's PCIe hardware.
> 
> Co-developed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 71 +++++++++++++++++++
>  .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  1 -
>  drivers/pci/controller/dwc/pcie-kirin.c       | 12 ----
>  3 files changed, 71 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> index 1f228612192c..6dfcfcfeedae 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -177,6 +177,12 @@ sctrl: sctrl@fff0a000 {
>  			#clock-cells = <1>;
>  		};
>  
> +		pmctrl: pmctrl@fff31000 {
> +			compatible = "hisilicon,hi3670-pmctrl", "syscon";
> +			reg = <0x0 0xfff31000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +

Irrelevant change to this patch.

>  		iomcu: iomcu@ffd7e000 {
>  			compatible = "hisilicon,hi3670-iomcu", "syscon";
>  			reg = <0x0 0xffd7e000 0x0 0x1000>;
> @@ -660,6 +666,71 @@ gpio28: gpio@fff1d000 {
>  			clock-names = "apb_pclk";
>  		};
>  

[...]

> +			#interrupt-cells = <1>;
> +			interrupts = <0 283 4>;

Use the DT flag for interrupts instead of hardcoded value

> +			interrupt-names = "msi";
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0x0 0 0 1
> +					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x0 0 0 2
> +					 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x0 0 0 3
> +					 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x0 0 0 4
> +					 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
>  		/* UFS */
>  		ufs: ufs@ff3c0000 {
>  			compatible = "hisilicon,hi3670-ufs", "jedec,ufs-2.1";
> diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
> index 48c739eacba0..03452e627641 100644
> --- a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
> @@ -73,7 +73,6 @@ ldo33: LDO33 { /* PEX8606 */
>  					regulator-name = "ldo33";
>  					regulator-min-microvolt = <2500000>;
>  					regulator-max-microvolt = <3300000>;
> -					regulator-boot-on;

Again, irrelevant.

>  				};
>  
>  				ldo34: LDO34 { /* GPS AUX IN VDD */
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index bfc0513f7b15..9dad14929538 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -347,18 +347,6 @@ static const struct regmap_config pcie_kirin_regmap_conf = {
>  	.reg_stride = 4,
>  };
>  
> -/* Registers in PCIeCTRL */
> -static inline void kirin_apb_ctrl_writel(struct kirin_pcie *kirin_pcie,
> -					 u32 val, u32 reg)
> -{
> -	writel(val, kirin_pcie->apb_base + reg);
> -}
> -
> -static inline u32 kirin_apb_ctrl_readl(struct kirin_pcie *kirin_pcie, u32 reg)
> -{
> -	return readl(kirin_pcie->apb_base + reg);
> -}
> -

Same here...

Thanks,
Mani
