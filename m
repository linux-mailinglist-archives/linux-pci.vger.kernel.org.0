Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF340766C78
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 14:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbjG1MEO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 08:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjG1MD5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 08:03:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA3A4211
        for <linux-pci@vger.kernel.org>; Fri, 28 Jul 2023 05:03:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so22542045e9.2
        for <linux-pci@vger.kernel.org>; Fri, 28 Jul 2023 05:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690545801; x=1691150601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/vKoaITIyW9xcwG8PtxXcCtwnXHm7Y94zVK2jGbtSY=;
        b=F8c164DEg1U2zHFVL6A881PvtLW8arBQxTSuYi6BsazIikM8FKwJt8677VhL/YR5mf
         Yrfv6VsM7uTf7JAiIr8/yfKWx3erIUq+snXxdTpCLqgqBoA623kze3xRWtyjyn1P+hcr
         4pcxiMf53FRCFPdyflSJvROwRCNscn92er3ClH8x/+exjTFmrAu8zKcaTUeSo+H6PlSd
         G8/bUjD6pgiejWLBS1iZDqZxLhkEjcf22QXMUkEvIFjQSIVXOyWMjULvU3Q+xoyBVOWf
         dm8ji7904cyWSd5XGhEjkClg5KYREauq7FmA9Xq5NhMUIOFPygk/wrb867ojZ08nS06C
         ZP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690545801; x=1691150601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/vKoaITIyW9xcwG8PtxXcCtwnXHm7Y94zVK2jGbtSY=;
        b=UrUaJhJj01khRvzVbKyiHVFT1fO/p2DOPlCsuynYkGYjU0ls0MMoG7aezzWExtMvs1
         aqxGunlNXRWYrOvIdOU2MwqDLGq5QmD3Ru2t478t0gos+yzRsCT1sJmoatavO0cvM6qi
         XVpIX8vmZEnY8kIAa18Utx3mbBoe3htuDWcfMqGKXmGu1hcSmfsm2/f2y63Tp5QNIg+D
         HezCbWo3MWEAhwJDs9YNoX2RhzFbD5jJZVcKrrFL8cEGbxIXOhGWO6BoeXmB5cHmdqTS
         w9yluk2OU0XZFfCEKdH2ES4pZ0VNdatTi35AxgbG6yj8jiRIsyo1QhC7lxPwRx04JOhA
         iMKA==
X-Gm-Message-State: ABy/qLbQUPVomPcCnzTEB/RLgLrtpEu90D9P/3+V2V6pwrmcC54bD7Q7
        ZdrLQ/iNvJbRa76anzAbCJqoJA==
X-Google-Smtp-Source: APBJJlEkuI6UTwqW0VTko2uWsPFht7OoyEgxGr2mGh5SPlgfnShLErAkXAEfZK43dAqhK7yX5s44Rw==
X-Received: by 2002:a05:600c:d5:b0:3fb:e206:ca5f with SMTP id u21-20020a05600c00d500b003fbe206ca5fmr1392256wmm.31.1690545801567;
        Fri, 28 Jul 2023 05:03:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c015100b003fbfef555d2sm6778983wmm.23.2023.07.28.05.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 05:03:21 -0700 (PDT)
Message-ID: <17c2ba50-3b72-523c-d92b-1ecbf9be7450@linaro.org>
Date:   Fri, 28 Jul 2023 14:03:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add PCIe0 node
Content-Language: en-US
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
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
        <devicetree@vger.kernel.org>
References: <1690540760-20191-1-git-send-email-quic_krichai@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1690540760-20191-1-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/07/2023 12:39, Krishna chaitanya chundru wrote:
> Add PCIe dtsi node for PCIe0 controller on sc7280 platform.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Thank you for your patch. There is something to discuss/improve.


> +		pcie0_phy: phy@1c06000 {
> +			compatible = "qcom,sm8250-qmp-gen3x1-pcie-phy";
> +			reg = <0 0x01c06000 0 0x1c0>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_CLKREF_EN>,
> +				 <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "refgen";
> +
> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			assigned-clocks = <&gcc GCC_PCIE0_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			status = "disabled";
> +
> +			pcie0_lane: phy@1c0e6200 {

Isn't this old-style of bindings? Wasn't there a change? On what tree
did you base it?

> +
> +			pcie0_wake_n: pcie0-wake-n {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Nodes end with 'state'.


> +				pins = "gpio89";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
Best regards,
Krzysztof

