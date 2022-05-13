Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E183052616F
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 13:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352163AbiEMLzD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 07:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344951AbiEMLzC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 07:55:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F90B285AF7;
        Fri, 13 May 2022 04:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BE5861D7F;
        Fri, 13 May 2022 11:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD24C34100;
        Fri, 13 May 2022 11:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652442900;
        bh=h8LjBcuAU7++hKV39SXxeZk2NnPv/cQLwgcVip/Iqg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Onh8ctGtMJQKYmr+U297Q2iX8033k9+W3DjqD9112f2hBMep6Qf8gZWmEzxy/iw4X
         U06R0kGcWJKr0X2Wx/SH6lEpA6kMuUhN65e+yHmGXLzXCAIbHGIsy7iUbIdEfhFCKX
         6NlZtquABABkw0n05u66jfXXkij+CA1wW3pvWwGca5KxKcuUytMnU2nbhlAuL87cn/
         QP3jQjO9jksB79wNnv+q9gyJCB7Fv3MgCyTuj4SlIPRCSLzu+2+KMYRt86h1C99ErV
         q8PFiDPyPL+H1ekV/li8X1bQvtW9W9uX0ez7SzdvurbQmOpqb9SgiaCdYTghXfYOTo
         xU5MOGyQpi44A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npTsn-0002Kb-Du; Fri, 13 May 2022 13:54:57 +0200
Date:   Fri, 13 May 2022 13:54:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 10/10] arm64: dts: qcom: sm8250: provide additional
 MSI interrupts
Message-ID: <Yn5HEUkNW+g20u58@hovoldconsulting.com>
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
 <20220512104545.2204523-11-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512104545.2204523-11-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 01:45:45PM +0300, Dmitry Baryshkov wrote:
> On SM8250 each group of MSI interrupts is mapped to the separate host
> interrupt. Describe each of interrupts in the device tree for PCIe0
> host.
> 
> Tested on Qualcomm RB5 platform with first group of MSI interrupts being
> used by the PME and attached ath11k WiFi chip using second group of MSI
> interrupts.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 410272a1e19b..ef683a2f7412 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -1807,8 +1807,15 @@ pcie0: pci@1c00000 {
>  			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
>  				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
>  
> -			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi", "msi1", "msi2", "msi3", "msi4", "msi5", "msi6", "msi7";

You must use "msi0" instead of "msi" or you only get 32 MSI regardless
of what follows currently (and this wouldn't pass DT validation either).

>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 0x7>;
>  			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

Johan
