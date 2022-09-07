Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527A85B03D7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 14:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiIGMWM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 08:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiIGMWL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 08:22:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA410AB197
        for <linux-pci@vger.kernel.org>; Wed,  7 Sep 2022 05:22:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bq23so22152346lfb.7
        for <linux-pci@vger.kernel.org>; Wed, 07 Sep 2022 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+WkJBmsyH1vsBqkEXP+qbFWoUijLTNIoydGFYIhgXJI=;
        b=CfkxBrTwWAK8tTr73FjBvDdxCOCy499JJMLu90hQ/cxz+G1eMjnyHSXykAey6okcEU
         xsUzc356u8kqsid+5qlbMB2e69cPc0L5hsVyOjVRdVDG16B1tUWazIZDVUt2KTjJzUWp
         vdcPGSDBr2gqdoE+5E4q6wMyE4IbkbvEofVR5gBxwIGluvC23HoQx23wqJKgo9XDEqL+
         YdQTyxEnny4IONKqEtddIkriNQbAG/8LidAD0rjL9DToYJMsM98xT+/hN76aDqeV+VFU
         mS+PrGCOI3g/0lhFNmVFcEbikR1tcpyt1gAKBvCTMTF0YoJ6AWkbDPuluRBQXobX/dzj
         GHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+WkJBmsyH1vsBqkEXP+qbFWoUijLTNIoydGFYIhgXJI=;
        b=C/PiVguHnsD8pl+br2HK/VT3he/HKATgC7hAzHfWUso0s4Q2a110UNP7w2s2fE2ng2
         DW72BIa+9hrD51LXxqHlmP9dMcwQrDoR+Oyriii/nF7F2DuIaCOfNBGJYkbnRVzVCkCV
         +yCOqOcdyiPo/wdWP7q7DSqtBr2iI0C+Iw1OtKmNY939UVh+gG1UIdh6RE8QhDBUb3ij
         h7MzsLhhrGGRIn63ImRlQNz79WWRggSs5FAYcLOqIReNvhnESdK5ctjF/lZ1rV15SMRw
         wy9IyUfTNoSA7ZOr8ecpcEv/3jThXTA42StM0QpAvLfppw9tr5mDf+GoLIkaI5Uem//X
         TN3g==
X-Gm-Message-State: ACgBeo0ikIuzcWexAyo2dJMm1y5tL0QEmBSGZ391WMLdHaSO8HSrWtOU
        +JCSHotKklob+phUFdW+hEOjLw==
X-Google-Smtp-Source: AA6agR6JoL1nZuFPzHt37TZNIcdOdWFyxLpGOtAmPbV/or30uevMdL/iW8HwmWCC7w6CRktHeU8WHg==
X-Received: by 2002:a05:6512:b0d:b0:492:d661:b368 with SMTP id w13-20020a0565120b0d00b00492d661b368mr985485lfu.466.1662553328032;
        Wed, 07 Sep 2022 05:22:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v8-20020a056512348800b0048b256bb005sm2462006lfr.49.2022.09.07.05.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 05:22:07 -0700 (PDT)
Message-ID: <5630d0e7-bdfb-36f4-6cd8-9ca986bb2a11@linaro.org>
Date:   Wed, 7 Sep 2022 14:22:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 2/3] dt-bindings: pci: QCOM Add missing sc7280 aggre0,
 aggre1 clocks
Content-Language: en-US
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1662171184-25211-1-git-send-email-quic_krichai@quicinc.com>
 <1662171184-25211-3-git-send-email-quic_krichai@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1662171184-25211-3-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/09/2022 04:13, Krishna chaitanya chundru wrote:
> Add missing aggre0 and aggre1 clocks.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
> changes since v2:
> 	- Increase the max items of clock's in common properties.
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 0b69b12..b759465 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -53,11 +53,11 @@ properties:
>    # Platform constraints are described later.
>    clocks:
>      minItems: 3
> -    maxItems: 12
> +    maxItems: 13
>  
>    clock-names:
>      minItems: 3
> -    maxItems: 12
> +    maxItems: 13
>  
>    resets:
>      minItems: 1
> @@ -423,8 +423,8 @@ allOf:
>      then:
>        properties:
>          clocks:
> -          minItems: 11
> -          maxItems: 11
> +          minItems: 13
> +          maxItems: 13
>          clock-names:
>            items:
>              - const: pipe # PIPE clock
> @@ -437,6 +437,8 @@ allOf:
>              - const: bus_slave # Slave AXI clock
>              - const: slave_q2a # Slave Q2A clock
>              - const: tbu # PCIe TBU clock
> +            - const: aggre0 # Aggre NoC PCIe CENTER SF AXI clock
> +            - const: aggre1 # Aggre NoC PCIe1 AXI clock
>              - const: ddrss_sf_tbu # PCIe SF TBU clock

Why adding them in the middle, not at the end of list? It does not match
other variants and affects the DTB ABI (order is strict).

Best regards,
Krzysztof
