Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8CB655332
	for <lists+linux-pci@lfdr.de>; Fri, 23 Dec 2022 18:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiLWRSj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Dec 2022 12:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiLWRSg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Dec 2022 12:18:36 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAB813EB7
        for <linux-pci@vger.kernel.org>; Fri, 23 Dec 2022 09:18:34 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 1so7827627lfz.4
        for <linux-pci@vger.kernel.org>; Fri, 23 Dec 2022 09:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDIg5CY2JaKsFGB2lcAV6dA1ibP6/hePKm8xnPYIyyI=;
        b=yJYm1pAib+wICXrxYFK2jPIHwFRLEozpLEIbNnVCzvDCKe57uaavGiw8OzXMIkiSmK
         MtyeKQ/SbZ4dyFTXrbaaU9HIwVOVsq6OJO++fDkt7DGCKA2f3z9LH2d/47PWDBF+R+cQ
         jdprSYLmZ5CtNgP5aRuyDhRb8NzAPxz9DVNo0n9SI7FHebWfZDApLN9spi7YvEhnY8qw
         2qO9PevYIMP7+qozKR7/eazXOGQRlqpviBxRFzQOf/A0tUrNWCAp0mTN/n/W8Lajdd4D
         9JlBthW3JAKGjligd5tCxEonP4T/NdKOjZkzBpvz4zIs3Il0j9/fpUm/WPtHY3N0kGEx
         xXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDIg5CY2JaKsFGB2lcAV6dA1ibP6/hePKm8xnPYIyyI=;
        b=lPt5Swt/8H7AVeR4EVum4pTzUxBdL+u200BJtVg7ZzJ9QUT3eX6042vpPNEclXmA1y
         ei4GT4So12dZWm1Kh2bIdxy8Fks1tkLDQdS8vjQJcC/ubneZN0LaPlj7gpcyn6BwdU+l
         dbq5iYUqQ9+x/hOWUbQwTVZkMuZJVDr0FNJNPaD0qqjkZfHubpwNhTrMagrtvljIWdbw
         DxPBttX8s12PTcDNmLnhCVOAvpi6Ed9clFJT1ZPeV6pQsWhuXttdDQM+YvcjHY2Mn4RI
         56hoppmSAXNhJgkAE/ciIkKanAMPihEZJ7bQL3Faj6Yt5m1njONddKzqw6sT7BJU2z9W
         0lcQ==
X-Gm-Message-State: AFqh2kr18tddYVf6bWHsIJ3EllrtIkx5cEPHIxOUq7lITK98ikRlotih
        KyJDTl29kVjB2dQTeJGH7DFBgA==
X-Google-Smtp-Source: AMrXdXvvsu3U+CTeN5RlwXk8JTCbHz7bldvaiykJXtPi5Io9oYhMPsqrmNZh1jnU3+4uazLFhiVYhQ==
X-Received: by 2002:ac2:46c3:0:b0:4b5:39fa:6de with SMTP id p3-20020ac246c3000000b004b539fa06demr3156696lfo.41.1671815913128;
        Fri, 23 Dec 2022 09:18:33 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c26-20020ac2531a000000b004a6f66eed7fsm591039lfh.165.2022.12.23.09.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 09:18:32 -0800 (PST)
Message-ID: <e756516a-a5e2-a6ac-fd7f-71726766fa81@linaro.org>
Date:   Fri, 23 Dec 2022 19:18:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0
 and PCIe1
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221222133123.50676-1-manivannan.sadhasivam@linaro.org>
 <20221222133123.50676-4-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221222133123.50676-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/12/2022 15:31, Manivannan Sadhasivam wrote:
> Both PCIe0 and PCIe1 controllers are capable of receiving MSIs from
> endpoint devices using GIC-ITS MSI controller. Add support for it.
> 
> Currently, BDF (0:0.0) and BDF (1:0.0) are enabled and with the
> msi-map-mask of 0xff00, all the 32 devices under these two busses can
> share the same Device ID.
> 
> The GIC-ITS MSI implementation provides an advantage over internal MSI
> implementation using Locality-specific Peripheral Interrupts (LPI) that
> would allow MSIs to be targeted for each CPU core.
> 
> It should be noted that the MSIs for BDF (1:0.0) only works with Device
> ID of 0x5980 and 0x5a00. Hence, the IDs are swapped.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 570475040d95..c4dd5838fac6 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -1733,9 +1733,13 @@ pcie0: pci@1c00000 {
>   			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
>   				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
>   
> -			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";
> -			#interrupt-cells = <1>;
> +			/*
> +			 * MSIs for BDF (1:0.0) only works with Device ID 0x5980.
> +			 * Hence, the IDs are swapped.
> +			 */
> +			msi-map = <0x0 &gic_its 0x5981 0x1>,
> +				  <0x100 &gic_its 0x5980 0x1>;

This definitely doesn't match what has been used in the downstream.

Also if I understand correctly this change would prevent us from using 
multiple MSI interrupts for the connected device, as the last value of 
the 0x100 mapping is 0x1, while the vendor kernel uses <0x100 &its 
0x5981 0x20>.

Do you know by chance, why do we differ from the vendor dtsi?

> +			msi-map-mask = <0xff00>;
>   			interrupt-map-mask = <0 0 0 0x7>;
>   			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>   					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> @@ -1842,9 +1846,13 @@ pcie1: pci@1c08000 {
>   			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
>   				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
>   
> -			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";
> -			#interrupt-cells = <1>;
> +			/*
> +			 * MSIs for BDF (1:0.0) only works with Device ID 0x5a00.
> +			 * Hence, the IDs are swapped.
> +			 */
> +			msi-map = <0x0 &gic_its 0x5a01 0x1>,
> +				  <0x100 &gic_its 0x5a00 0x1>;
> +			msi-map-mask = <0xff00>;
>   			interrupt-map-mask = <0 0 0 0x7>;
>   			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>   					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */

-- 
With best wishes
Dmitry

