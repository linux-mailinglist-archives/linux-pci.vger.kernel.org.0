Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA55509E28
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388638AbiDULCA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 07:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388636AbiDULB5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 07:01:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5482CCA9
        for <linux-pci@vger.kernel.org>; Thu, 21 Apr 2022 03:59:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x33so8039535lfu.1
        for <linux-pci@vger.kernel.org>; Thu, 21 Apr 2022 03:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fWzbz0uK61AwfD+yiXMsbQRKrFNjfCltGVfKBy1niE4=;
        b=OkHo6k4V3Od8Y9k7bmR5u7hmBKOfMahHiIlwoiA0TohJ7+6U1/S38EXZg5mFiACLqV
         QCIKeei0tPByChIuHTCEFnFBuChGPSMCsiqF53H5baVVmqWJDmTlqRnbt7ScvOWj7bzT
         WVhMf3hWTai/yWOAkOggQiRru5QgciR+HqurdCUVOemB1DCtWhIfNHNUwqGegIXrJvhb
         PVTrfPzOqdR3XiV8xBFWjKFixz7V3IzSigpvvlYgFMzIBRhbKNjhHG1x79wjPvn/aM+j
         L9hbuKu0pWW32ull9aQ4gfpdXxe2yCNjkw3CU4cGM8H5ieq9inAiu53ZG2saXY5hPAxe
         giKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fWzbz0uK61AwfD+yiXMsbQRKrFNjfCltGVfKBy1niE4=;
        b=Xt1FSq0+6tGQLeNYC2mI82AtwHkLMZNfjMbtcG6nUnlxzlmHBVt3p9wlwAoacwioi8
         dVC4uFQnjmfUmRwoMV2KTKPp9WOQ0LkbnMRfgSmWbFK0Mfb/BDJW0xkSjBu59pnUJqHj
         IJJQ3Or2vV5pyykPz8vtb2bk9St41WNWLHAHntz6IzD9V7agYj/oPGswyEaT1ft3D2oM
         Z+4+2MG0UXPrrQ5/HAla4b/iTp3z+6PxisciBJAeseoOpAmEMRV1pAdLQAgc7VDMgd3D
         aJm9GaHgrLiy8xgFrd8tE40uIEG52hoZOqnsrQmtjoREyYJPcAyr3T8UoSHpfnWFYNgK
         KWJA==
X-Gm-Message-State: AOAM530igiU33RQtaOoRCgm2ToQdN5WzK5OFBVeXvP/RJnOYC9qnAc5F
        8IsbieIHOGazbNTxlqmw4cYsFsO1WDP+Zw==
X-Google-Smtp-Source: ABdhPJxhGbbAtY3JdnXrm5gM7UPgEd3lOaM94kpLzor20vzd+pu5M1xuypG+GGFQTvA/Gy36/z3n+Q==
X-Received: by 2002:a05:6512:21cd:b0:46b:b89e:186c with SMTP id d13-20020a05651221cd00b0046bb89e186cmr17933321lft.250.1650538745402;
        Thu, 21 Apr 2022 03:59:05 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bi2-20020a0565120e8200b0044826a117bcsm2150569lfb.44.2022.04.21.03.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 03:59:05 -0700 (PDT)
Message-ID: <55d6e32b-9cf4-384c-1036-1adfb867ece8@linaro.org>
Date:   Thu, 21 Apr 2022 13:59:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RFC 2/5] arm64: dts: qcom: sc7280: move pipe mux handling
 to phy
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220421102041.17345-1-johan+linaro@kernel.org>
 <20220421102041.17345-3-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220421102041.17345-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/04/2022 13:20, Johan Hovold wrote:
> The QMP PHY pipe clock remuxing is part of the PHY, which is both the
> producer and the consumer of the pipe clock.
> 
> Update the PCIe controller and PHY node to reflect the new binding.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index c07765df9303..b3a9630262dc 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1837,11 +1837,7 @@ pcie1: pci@1c08000 {
>   					<0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>,
>   					<0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>;
>   
> -			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
> -				 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
> -				 <&pcie1_lane 0>,
> -				 <&rpmhcc RPMH_CXO_CLK>,
> -				 <&gcc GCC_PCIE_1_AUX_CLK>,
> +			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
>   				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
>   				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
>   				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> @@ -1849,11 +1845,7 @@ pcie1: pci@1c08000 {
>   				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
>   				 <&gcc GCC_DDRSS_PCIE_SF_CLK>;
>   
> -			clock-names = "pipe",
> -				      "pipe_mux",
> -				      "phy_pipe",
> -				      "ref",
> -				      "aux",
> +			clock-names = "aux",
>   				      "cfg",
>   				      "bus_master",
>   				      "bus_slave",
> @@ -1910,8 +1902,10 @@ pcie1_lane: lanes@1c0e200 {
>   				      <0 0x01c0e600 0 0x170>,
>   				      <0 0x01c0e800 0 0x200>,
>   				      <0 0x01c0ee00 0 0xf4>;
> -				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
> -				clock-names = "pipe0";
> +				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
> +					 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
> +					 <&rpmhcc RPMH_CXO_CLK>;
> +				clock-names = "pipe0", "mux", "ref";

This will not be compatible with earlier DTB files, which was a problem 
up to now.

>   
>   				#phy-cells = <0>;
>   				#clock-cells = <1>;


-- 
With best wishes
Dmitry
