Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A851047109D
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 03:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbhLKCOF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 21:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhLKCOE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 21:14:04 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD84C0617A1
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 18:10:28 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z8so16153579ljz.9
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 18:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5mmf3FVNjWqjjEHYqk+bNIyyloQFjJWEsTo7/kwY5m4=;
        b=lBM3/W3/ZSrx/1lHNTuHTam6XwNh/lWnYQHkca9P/+69APilWZsSUtz+sotfUAGLjR
         JDNhILZnQboavEuPwLOd3rhV6v6uPniWD7PeqcIw5n05e7PA6X4nBVckaaLTODErnnnV
         qkB+gE0qUcEfMsTY+oN8JgkZ54u8Is4I59Ad7ZaJXiM6LsIQwM2+OvMqFpBeFBpw58iK
         Nbvj6kHk6eM8bvd+QqBS+JIflK2lhSHMwy6V5hHxUa/vmCJ3Qwr9+7UVYl1xQhge1Nxt
         CLig5DCOIBolm8S8XeGDDiBPHgFGzuCmXkjJzuj/wBF0MN8Ev40o2ZSoBPObVXhsTwgL
         YJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5mmf3FVNjWqjjEHYqk+bNIyyloQFjJWEsTo7/kwY5m4=;
        b=noUTUv6lDw5euTHTebsnR1XGAmQUIcG1GmLz5IYj51EJ+EPHMxan+Pc65hSopkKO9V
         efq+rQLjL6ku3y+FUNGuwbJafdqSCt6q9Py8dFvt62NF2ybMonKigr7h96+vIlLQ0ZCG
         Bxd6ATTI8jSm1IEwAvj5gg+7zKgZn8NM+mrBCSDpw6Tr5/emKXyOLq6mzz50EjXc2/Or
         nT4SAOqQO21q0GIQUuoLJV1ZMPcs53e6B/ZuGOcccd8CZ0R69ElGnhKh1pmsBtf2nSaX
         iQrKwt3w38YhDkQB0/pLF10ppZTFU9e0k1gFTvnONaSNSWcd1yU046HYMo5qLVKQTu2K
         F7mQ==
X-Gm-Message-State: AOAM533ms6Z2/IAtxTuaXN3wmWqM8WfAiMgJHpiS/6NJuktozl2YOwSB
        x4NXvYgzzWeloQ/CgzHnMQlgpQ==
X-Google-Smtp-Source: ABdhPJx6rCt0XDxYhAZDn8yN0hvxhjXpMeQyLE7n6bXQ5m6QpV6fOLEjAg5ZfiSeVEeFavNqgGcopw==
X-Received: by 2002:a2e:b04c:: with SMTP id d12mr16061747ljl.338.1639188626520;
        Fri, 10 Dec 2021 18:10:26 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d4sm471176lfg.82.2021.12.10.18.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 18:10:26 -0800 (PST)
Message-ID: <2f2434b7-ea29-0717-a7bd-e2968f9236c8@linaro.org>
Date:   Sat, 11 Dec 2021 05:10:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 07/10] arm64: dts: qcom: sm8450: add PCIe0 PHY node
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
References: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org>
 <20211208171442.1327689-8-dmitry.baryshkov@linaro.org>
 <20211210113720.GG1734@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20211210113720.GG1734@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/12/2021 14:37, Manivannan Sadhasivam wrote:
> On Wed, Dec 08, 2021 at 08:14:39PM +0300, Dmitry Baryshkov wrote:
>> Add device tree node for the first PCIe PHY device found on the Qualcomm
>> SM8450 platform.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 42 ++++++++++++++++++++++++++--
>>   1 file changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 16a789cacb65..a047d8a22897 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -558,8 +558,12 @@ gcc: clock-controller@100000 {
>>   			#clock-cells = <1>;
>>   			#reset-cells = <1>;
>>   			#power-domain-cells = <1>;
>> -			clock-names = "bi_tcxo", "sleep_clk";
>> -			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +				 <&pcie0_lane>,
>> +				 <&sleep_clk>;
>> +			clock-names = "bi_tcxo",
>> +				      "pcie_0_pipe_clk",
>> +				      "sleep_clk";
>>   		};
>>   
>>   		qupv3_id_0: geniqup@9c0000 {
>> @@ -625,6 +629,40 @@ i2c14: i2c@a98000 {
>>   			};
>>   		};
>>   
>> +		pcie0_phy: phy@1c06000 {
>> +			compatible = "qcom,sm8450-qmp-gen3x1-pcie-phy";
>> +			reg = <0 0x01c06000 0 0x200>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
>> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
>> +				 <&gcc GCC_PCIE_0_CLKREF_EN>,
>> +				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
>> +			clock-names = "aux", "cfg_ahb", "ref", "refgen";
>> +
>> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
>> +			reset-names = "phy";
>> +
>> +			assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
>> +			assigned-clock-rates = <100000000>;
>> +
>> +			status = "disabled";
>> +
>> +			pcie0_lane: lanes@1c06200 {
>> +				reg = <0 0x1c06e00 0 0x200>, /* tx */
>> +				      <0 0x1c07000 0 0x200>, /* rx */
>> +				      <0 0x1c06200 0 0x200>, /* pcs */
> 
> Oh, so this platform has "PCS" at the starting offset? This is different
> compared to other platforms as "TX" always comes first.
> 

Yes. this is correct.


> And the size is "0x200" for all?

It is for the PCS block.

As you see below, PCS_PCIE starts at 0x600. Initially I thought about 
extend it further, making it cover few other regions (up to the tx 
region). However as we do not touch other regions, I decided to keep it 
as this way.

> 
> Thanks,
> Mani
> 
>> +				      <0 0x1c06600 0 0x200>; /* pcs_pcie */
>> +				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
>> +				clock-names = "pipe0";
>> +
>> +				#clock-cells = <0>;
>> +				#phy-cells = <0>;
>> +				clock-output-names = "pcie_0_pipe_clk";
>> +			};
>> +		};
>> +
>>   		config_noc: interconnect@1500000 {
>>   			compatible = "qcom,sm8450-config-noc";
>>   			reg = <0 0x01500000 0 0x1c000>;
>> -- 
>> 2.33.0
>>


-- 
With best wishes
Dmitry
