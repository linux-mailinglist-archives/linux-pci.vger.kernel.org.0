Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14FF768C67
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 08:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjGaGyf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 02:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGaGyc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 02:54:32 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E8B10D
        for <linux-pci@vger.kernel.org>; Sun, 30 Jul 2023 23:54:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so8658311a12.1
        for <linux-pci@vger.kernel.org>; Sun, 30 Jul 2023 23:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690786468; x=1691391268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4qUpAieG+xE08h9GZl+Gc2LW4JHHh2vTdj6E2mVehSY=;
        b=QZQhRAtBIIZv+wMv6Lxz/k+jf0zqv0L4vBqgBg37tCl2/VZ2sjNccomO1Bbl3DcCBY
         8aTMsta4hgFyt4+y2HEPbVx1/RwJh9suiK4o8EGnaIImBnM0L3hz5FJTMKluDfGrAsfH
         5a5/i0Oy8MkSl03+PbLPMXMJqL1dMpKiDj7YtBb+lctxZ+iuWNwp/YbcaV5k70W7QJrL
         fN9W/W5Ygb/zGvzJ5n0uHRMl/cqeexeZwBHtEOSKuQlE2tFZqQRl4Ogcyhns6/dQHEpl
         3gKLQ3AHcA6MAIex5cr6tr5IRJlN+kCeLO7EzTdz0Rhd+dW9CmkCcQPCbWS0wWGpRuFJ
         DyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690786468; x=1691391268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4qUpAieG+xE08h9GZl+Gc2LW4JHHh2vTdj6E2mVehSY=;
        b=JDPqsR6htIBC9nM5Ze3m3fe7M7c92zvnTTaSxbX+E3clAA9NaafQ9mhzgqgCzWxhW7
         tQjhaSBlagEym+dLrmBZiUdiqNzmvhUawRLYLgQHOzQ6ho9B5XO8Zqb5SxYB7s+BYZjH
         ECv1WJ0zcWodV/tOvsMElqJxQMqdYmrXJLxD2O+UOwWWpHmI4W/V9CX3v+Cn0WkNYrIa
         bMxznMG3fYxiD7t1rCnY7ktLqLwG6YY8blBJJBeiaaud00XHSaOKivBx1G7N47UgS0Qu
         Ur3SS7PrrKQesr5zG+5vKNb8SweZ4HuGH+U9O85R6ARa94CnQin+/DTU6Sqj4Md1uNUn
         RFlQ==
X-Gm-Message-State: ABy/qLa0JOgshlMpauTUFRGz6rc7EXq5flLJHmltAWy4BQK0cdih0EHW
        sh7EXf9Z0pJD4lo9xWs7F0DMmw==
X-Google-Smtp-Source: APBJJlGCmJaHU50ObdvcR/6bwTGIuiXDtnox3Cuhxi7HnSlDCaucG+LhabDEzLzNd3EdVAvCwUifNw==
X-Received: by 2002:aa7:db52:0:b0:522:abaf:1b0b with SMTP id n18-20020aa7db52000000b00522abaf1b0bmr7501888edt.18.1690786467642;
        Sun, 30 Jul 2023 23:54:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id e12-20020a50ec8c000000b0051e0eba608bsm4953487edr.19.2023.07.30.23.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 23:54:27 -0700 (PDT)
Message-ID: <0617841a-5d1f-b703-daa9-fedba148a05d@linaro.org>
Date:   Mon, 31 Jul 2023 08:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add PCIe0 node
Content-Language: en-US
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com,
        "reviewer:ARM/QUALCOMM CHROMEBOOK SUPPORT" 
        <cros-qcom-dts-watchers@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <1690540760-20191-1-git-send-email-quic_krichai@quicinc.com>
 <17c2ba50-3b72-523c-d92b-1ecbf9be7450@linaro.org>
 <f3d5c72d-90d3-b091-f995-5ad0bf93ae1d@quicinc.com>
 <a2024453-e749-b659-52a0-83ded8bb5c38@linaro.org>
 <1cfdf3c4-6e4f-e73d-c711-3890ceabb69d@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1cfdf3c4-6e4f-e73d-c711-3890ceabb69d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31/07/2023 07:29, Krishna Chaitanya Chundru wrote:
> 
> On 7/28/2023 9:27 PM, Krzysztof Kozlowski wrote:
>> On 28/07/2023 17:10, Krishna Chaitanya Chundru wrote:
>>> On 7/28/2023 5:33 PM, Krzysztof Kozlowski wrote:
>>>> On 28/07/2023 12:39, Krishna chaitanya chundru wrote:
>>>>> Add PCIe dtsi node for PCIe0 controller on sc7280 platform.
>>>>>
>>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>> Thank you for your patch. There is something to discuss/improve.
>>>>
>>>>
>>>>> +		pcie0_phy: phy@1c06000 {
>>>>> +			compatible = "qcom,sm8250-qmp-gen3x1-pcie-phy";
>>>>> +			reg = <0 0x01c06000 0 0x1c0>;
>>>>> +			#address-cells = <2>;
>>>>> +			#size-cells = <2>;
>>>>> +			ranges;
>>>>> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
>>>>> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
>>>>> +				 <&gcc GCC_PCIE_CLKREF_EN>,
>>>>> +				 <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
>>>>> +			clock-names = "aux", "cfg_ahb", "ref", "refgen";
>>>>> +
>>>>> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
>>>>> +			reset-names = "phy";
>>>>> +
>>>>> +			assigned-clocks = <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
>>>>> +			assigned-clock-rates = <100000000>;
>>>>> +
>>>>> +			status = "disabled";
>>>>> +
>>>>> +			pcie0_lane: phy@1c0e6200 {
>>>> Isn't this old-style of bindings? Wasn't there a change? On what tree
>>>> did you base it?
>> The work was here:
>> https://lore.kernel.org/all/20230324022514.1800382-5-dmitry.baryshkov@linaro.org/
>>
>> But I don't remember the status.
>>
>>> Let me rebase and send it again.
>> This anyway looks like wrong compatible. You used sm8250.
> 
> The patch was send on latest linux-next only and the above change is not 
> merged yet.

I don't think we will want old DTS syntax... but this actually depends
on the status of Dmitry's patchset.

> 
> We are using the same compatible string as sm8250 because the phy is 
> same both from hardware and software perspective for sm8250.
> 
> that is why we are using the same compatible string.
> 
> Can you let me know if we want create a separate compatible string for 
> this even though  we are using same phy?

https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#42


Best regards,
Krzysztof

