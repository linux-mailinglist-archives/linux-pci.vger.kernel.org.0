Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484AC6FAE26
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 13:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbjEHLlu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 07:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbjEHLl1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 07:41:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A623F56D
        for <linux-pci@vger.kernel.org>; Mon,  8 May 2023 04:40:56 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac81d2bfbcso47128961fa.3
        for <linux-pci@vger.kernel.org>; Mon, 08 May 2023 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683546053; x=1686138053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/0/R7Cq6U8SlQWleqb6tEswncZDX0yNUZixCGv7fr8=;
        b=bcXiJfH7O8NhM8nAG85bPEfRAE0hbvoGPNWnp+d3bJHxZoX6lAa7rnUpe8LtMKgMeW
         5RQWAHa5CTEQcnHXu/Rrc1VjXLKe//ngxzsfLa7xY4VVwsVSzekXDi1PnYIivnhhMTzL
         nvax+Dk+Flog9MZdGWqqWTRf8eau8OsITItpwYxefyiSYxGIvgma7ywCuj1eKvj1C7OU
         oiVtnHldGFCxA6y8hosfJ9QT+vYiMUAH6ueFZWF2EXxwZFBsofARqYH76VCJPNXVk+Lq
         OhK3NZP/EvoqSIzAgDuSkiHj3VbmiYvtmz2YlQSLm57RJ5UdCs1MyX1W7A7cWtvNewQQ
         aTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683546053; x=1686138053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/0/R7Cq6U8SlQWleqb6tEswncZDX0yNUZixCGv7fr8=;
        b=fsVxQAGPpiksQIcQ4pguk6VqcVRmPoaVnuHM4FMUrcAcW9wtiEt2qYZ2H7mLz29zXD
         Jhz0USnMaBZSKza+wlRk3u5ALJqT1WQLitsmZd0eEVixa/+P/mqn+A5y3PIovIhrszwO
         6NZdN/ZBowWAsY/65xC7F9R0zHj/wEWEfhkCQDab9m1BymNlfQ8c8IpCIqOSOzhTbeNn
         YX0e8/VyCVVojT+K5jjl4ZEjkCumnBa7sFBn/XchRjkPRVGZlH20sSLIcZ1F9Ino9EZl
         gTZE0nRPScw9ESL5xkOfq+sJwqfHU+gCLjcIv4Plukre1HCbWsdQRMhs76TUIWvATgjH
         rD1A==
X-Gm-Message-State: AC+VfDzw8m9eSz2fwAjg3njDqOi5O0jeWpQlhsee2sPwcM3T7SwGPCRZ
        +UcziWdec5FcEdxU77S6mf1GYFdofDFN/a5xnLs=
X-Google-Smtp-Source: ACHHUZ7A6Qv5Jovb9uRxxsxHGntyKoCI8Xj409tfm0bPvOo1hzWykCX5ydZS5HWGovCibjXYQc4nCA==
X-Received: by 2002:a2e:99da:0:b0:2a7:6e85:e287 with SMTP id l26-20020a2e99da000000b002a76e85e287mr3080950ljj.45.1683546052833;
        Mon, 08 May 2023 04:40:52 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a5-20020a05651c010500b002ac9138a419sm1101212ljb.80.2023.05.08.04.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 04:40:52 -0700 (PDT)
Message-ID: <e7b4afde-2cd7-0ab5-8a15-446173b42c40@linaro.org>
Date:   Mon, 8 May 2023 14:40:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 4/6] arm64: dts: qcom: ipq9574: Add PCIe PHYs and
 controller nodes
Content-Language: en-GB
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, mani@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
References: <20230421124938.21974-1-quic_devipriy@quicinc.com>
 <20230421124938.21974-5-quic_devipriy@quicinc.com>
 <CAA8EJppyro1wM3KmDU3DVjKCqXH5+KaNoT_7ObVuuYNMoZKpoA@mail.gmail.com>
 <a220e00d-0559-35d5-80e9-7e11e566851a@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <a220e00d-0559-35d5-80e9-7e11e566851a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/05/2023 13:53, Devi Priya wrote:
> 
> 
> On 4/22/2023 5:49 AM, Dmitry Baryshkov wrote:
>> On Fri, 21 Apr 2023 at 15:50, Devi Priya <quic_devipriy@quicinc.com> 
>> wrote:
>>>
>>> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
>>> found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
>>> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>>>
>>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>> ---
>>>   Changes in V3:
>>>          - Fixed up the PCI I/O port ranges
>>>
>>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 375 +++++++++++++++++++++++++-
>>>   1 file changed, 370 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi 
>>> b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> index e757b57957cf..953a839a1141 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> @@ -6,8 +6,8 @@
>>>    * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights 
>>> reserved.
>>>    */
>>>
>>> -#include <dt-bindings/interrupt-controller/arm-gic.h>
>>>   #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>>   #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>>>
>>>   / {
>>> @@ -116,6 +116,58 @@
>>>                  #size-cells = <1>;
>>>                  ranges = <0 0 0 0xffffffff>;
>>>
>>> +               pcie0_phy: phy@84000 {
>>> +                       compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>>> +                       reg = <0x00084000 0x1000>;
>>> +
>>> +                       clocks = <&gcc GCC_PCIE0_AUX_CLK>,
>>> +                                <&gcc GCC_PCIE0_AHB_CLK>,
>>> +                                <&gcc GCC_ANOC_PCIE0_1LANE_M_CLK>,
>>> +                                <&gcc GCC_SNOC_PCIE0_1LANE_S_CLK>,
>>> +                                <&gcc GCC_PCIE0_PIPE_CLK>;
>>> +                       clock-names = "aux", "cfg_ahb", "anoc_lane", 
>>> "snoc_lane", "pipe";
>>> +
>>> +                       assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
>>> +                       assigned-clock-rates = <20000000>;
>>> +
>>> +                       resets = <&gcc GCC_PCIE0_PHY_BCR>,
>>> +                                <&gcc GCC_PCIE0PHY_PHY_BCR>;
>>> +                       reset-names = "phy", "common";
>>> +
>>> +                       #clock-cells = <0>;
>>> +                       clock-output-names = "gcc_pcie0_pipe_clk_src";
>>> +
>>> +                       #phy-cells = <0>;
>>> +                       status = "disabled";
>>> +
>>> +               };
>>> +
>>> +               pcie2_phy: phy@8c000 {
>>> +                       compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
>>> +                       reg = <0x0008c000 0x2000>;
>>> +
>>> +                       clocks = <&gcc GCC_PCIE2_AUX_CLK>,
>>> +                                <&gcc GCC_PCIE2_AHB_CLK>,
>>> +                                <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
>>> +                                <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>,
>>> +                                <&gcc GCC_PCIE2_PIPE_CLK>;
>>> +                       clock-names = "aux", "cfg_ahb", "anoc_lane", 
>>> "snoc_lane", "pipe";
>>> +
>>> +                       assigned-clocks = <&gcc GCC_PCIE2_AUX_CLK>;
>>> +                       assigned-clock-rates = <20000000>;
>>> +
>>> +                       resets = <&gcc GCC_PCIE2_PHY_BCR>,
>>> +                                <&gcc GCC_PCIE2PHY_PHY_BCR>;
>>> +                       reset-names = "phy", "common";
>>> +
>>> +                       #clock-cells = <0>;
>>> +                       clock-output-names = "gcc_pcie2_pipe_clk_src";
>>> +
>>> +                       #phy-cells = <0>;
>>> +                       status = "disabled";
>>> +
>>> +               };
>>> +
>>>                  rng: rng@e3000 {
>>>                          compatible = "qcom,prng-ee";
>>>                          reg = <0x000e3000 0x1000>;
>>> @@ -123,6 +175,58 @@
>>>                          clock-names = "core";
>>>                  };
>>>
>>> +               pcie3_phy: phy@f4000 {
>>> +                       compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
>>> +                       reg = <0x000f4000 0x2000>;
>>> +
>>> +                       clocks = <&gcc GCC_PCIE3_AUX_CLK>,
>>> +                                <&gcc GCC_PCIE3_AHB_CLK>,
>>> +                                <&gcc GCC_ANOC_PCIE3_2LANE_M_CLK>,
>>> +                                <&gcc GCC_SNOC_PCIE3_2LANE_S_CLK>,
>>> +                                <&gcc GCC_PCIE3_PIPE_CLK>;
>>> +                       clock-names = "aux", "cfg_ahb", "anoc_lane", 
>>> "snoc_lane", "pipe";
>>> +
>>> +                       assigned-clocks = <&gcc GCC_PCIE3_AUX_CLK>;
>>> +                       assigned-clock-rates = <20000000>;
>>> +
>>> +                       resets = <&gcc GCC_PCIE3_PHY_BCR>,
>>> +                                <&gcc GCC_PCIE3PHY_PHY_BCR>;
>>> +                       reset-names = "phy", "common";
>>> +
>>> +                       #clock-cells = <0>;
>>> +                       clock-output-names = "gcc_pcie3_pipe_clk_src";
>>> +
>>> +                       #phy-cells = <0>;
>>> +                       status = "disabled";
>>> +
>>> +               };
>>> +
>>> +               pcie1_phy: phy@fc000 {
>>> +                       compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>>> +                       reg = <0x000fc000 0x1000>;
>>> +
>>> +                       clocks = <&gcc GCC_PCIE1_AUX_CLK>,
>>> +                                <&gcc GCC_PCIE1_AHB_CLK>,
>>> +                                <&gcc GCC_ANOC_PCIE1_1LANE_M_CLK>,
>>> +                                <&gcc GCC_SNOC_PCIE1_1LANE_S_CLK>,
>>> +                                <&gcc GCC_PCIE1_PIPE_CLK>;
>>> +                       clock-names = "aux", "cfg_ahb", "anoc_lane", 
>>> "snoc_lane", "pipe";
>>> +
>>> +                       assigned-clocks = <&gcc GCC_PCIE1_AUX_CLK>;
>>> +                       assigned-clock-rates = <20000000>;
>>> +
>>> +                       resets = <&gcc GCC_PCIE1_PHY_BCR>,
>>> +                                <&gcc GCC_PCIE1PHY_PHY_BCR>;
>>> +                       reset-names = "phy", "common";
>>> +
>>> +                       #clock-cells = <0>;
>>> +                       clock-output-names = "gcc_pcie1_pipe_clk_src";
>>> +
>>> +                       #phy-cells = <0>;
>>> +                       status = "disabled";
>>> +
>>> +               };
>>> +
>>>                  tlmm: pinctrl@1000000 {
>>>                          compatible = "qcom,ipq9574-tlmm";
>>>                          reg = <0x01000000 0x300000>;
>>> @@ -146,10 +250,10 @@
>>>                          reg = <0x01800000 0x80000>;
>>>                          clocks = <&xo_board_clk>,
>>>                                   <&sleep_clk>,
>>> -                                <0>,
>>> -                                <0>,
>>> -                                <0>,
>>> -                                <0>,
>>> +                                <&pcie0_phy>,
>>> +                                <&pcie1_phy>,
>>> +                                <&pcie2_phy>,
>>> +                                <&pcie3_phy>,
>>>                                   <0>;
>>>                          #clock-cells = <1>;
>>>                          #reset-cells = <1>;
>>> @@ -478,6 +582,267 @@
>>>                                  status = "disabled";
>>>                          };
>>>                  };
>>> +
>>> +               pcie1: pci@10000000 {
>>> +                       compatible = "qcom,pcie-ipq9574";
>>> +                       reg =  <0x10000000 0xf1d>,
>>> +                              <0x10000F20 0xa8>,
>>> +                              <0x10001000 0x1000>,
>>> +                              <0x000F8000 0x4000>,
>>> +                              <0x10100000 0x1000>;
>>> +                       reg-names = "dbi", "elbi", "atu", "parf", 
>>> "config";
>>> +                       device_type = "pci";
>>> +                       linux,pci-domain = <2>;
>>> +                       bus-range = <0x00 0xff>;
>>> +                       num-lanes = <1>;
>>> +                       #address-cells = <3>;
>>> +                       #size-cells = <2>;
>>> +
>>> +                       ranges = <0x01000000 0x0 0x00000000 
>>> 0x10200000 0x0 0x100000>,  /* I/O */
>>> +                                <0x02000000 0x0 0x10300000 
>>> 0x10300000 0x0 0x7d00000>; /* MEM */
>>> +
>>> +                       #interrupt-cells = <1>;
>>> +                       interrupt-map-mask = <0 0 0 0x7>;
>>> +                       interrupt-map = <0 0 0 1 &intc 0 35 
>>> IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>>> +                                       <0 0 0 2 &intc 0 49 
>>> IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>>> +                                       <0 0 0 3 &intc 0 84 
>>> IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>>> +                                       <0 0 0 4 &intc 0 85 
>>> IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>>> +
>>
>> No iommu-map?
> We do not enable the IOMMU stage1 translation for PCIe and the registers
> have secure access only from TrustZone (It enables only stage2 for
> Access control)

So, no SMMU protection for PCIe transactions? This sounds like a step 
backwards.

-- 
With best wishes
Dmitry

