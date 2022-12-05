Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982F2643776
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 22:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiLEVy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 16:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiLEVxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 16:53:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F3B1C129;
        Mon,  5 Dec 2022 13:52:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6EEFB81151;
        Mon,  5 Dec 2022 21:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537DFC433C1;
        Mon,  5 Dec 2022 21:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670277176;
        bh=IgKvO2pTgDtqxJCdjeqES53WonPY2/VY3lrlG8YhaPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VR9hqnwZXb/aa72RHD1NKo6cqSeJSoNdAmwPrw6OUOrPc7fBwBWEbmmWRdADfIyni
         20FTzfCAY0zNj6lnQPHJH1x5TYJnaRXz06CXQa2+Qli1SbJbyy3mrEY1Kfy4Ef6str
         L6+NpdqjzZpAqEYFxz3JLFK6bFf/FUQ+Rjswg2FnhWIwschJCkY6JWLUzPvsJjgNOx
         H5whEfiI5SIrQlc/XIEGAIFoM2RGYEEfKSAkk0arOWApuSy970PXHTYfIcva6Izm9p
         4AqK39EkcBx2HVePJcJ/HfrGfa9wOZgCh8jatkZpXBxVHEjJ1QGHAfu47u3eKLTmD0
         SA4jV5sg7DAxQ==
Date:   Mon, 5 Dec 2022 15:52:53 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mani@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe QMP PHY
Message-ID: <20221205215253.itobukkyiecn7xi7@builder.lan>
References: <20221116214841.1116735-1-robimarko@gmail.com>
 <20221116214841.1116735-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116214841.1116735-2-robimarko@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 10:48:34PM +0100, Robert Marko wrote:
> IPQ8074 comes in 2 silicon versions:
> * v1 with 2x Gen2 PCIe ports and QMP PHY-s
> * v2 with 1x Gen3 and 1x Gen2 PCIe ports and QMP PHY-s
> 
> v2 is the final and production version that is actually supported by the
> kernel, however it looks like PCIe related nodes were added for the v1 SoC.
> 
> Now that we have Gen3 QMP PHY support, we can start fixing the PCIe support
> by fixing the Gen3 QMP PHY node first.
> 
> Change the compatible to the Gen3 QMP PHY, correct the register space start
> and size, add the missing misc PCS register space.
> 

Does this imply that the current node doesn't actually work?

If that's the case, could we perhaps adopt Johan Hovolds' new binding
and drop the subnode in favor of just a flat reg covering the whole
QMP region?

Regards,
Bjorn

> Fixes: 33057e1672fe ("ARM: dts: ipq8074: Add pcie nodes")
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index 6649a758d8df..9503dfb25d50 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -232,9 +232,9 @@ qusb_phy_0: phy@79000 {
>  			status = "disabled";
>  		};
>  
> -		pcie_qmp0: phy@86000 {
> -			compatible = "qcom,ipq8074-qmp-pcie-phy";
> -			reg = <0x00086000 0x1c4>;
> +		pcie_qmp0: phy@84000 {
> +			compatible = "qcom,ipq8074-qmp-gen3-pcie-phy";
> +			reg = <0x00084000 0x1bc>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -248,10 +248,11 @@ pcie_qmp0: phy@86000 {
>  				      "common";
>  			status = "disabled";
>  
> -			pcie_phy0: phy@86200 {
> -				reg = <0x86200 0x16c>,
> -				      <0x86400 0x200>,
> -				      <0x86800 0x4f4>;
> +			pcie_phy0: phy@84200 {
> +				reg = <0x84200 0x16c>,
> +				      <0x84400 0x200>,
> +				      <0x84800 0x1f0>,
> +				      <0x84c00 0xf4>;
>  				#phy-cells = <0>;
>  				#clock-cells = <0>;
>  				clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
> -- 
> 2.38.1
> 
