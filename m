Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9FF5A5BB0
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 08:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiH3GXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 02:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiH3GXL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 02:23:11 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8AE79632
        for <linux-pci@vger.kernel.org>; Mon, 29 Aug 2022 23:23:08 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bx38so10234281ljb.10
        for <linux-pci@vger.kernel.org>; Mon, 29 Aug 2022 23:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=gjDGsH3K0hav1h9g3C72Xj3//qxC6le1H42uGY/mBiM=;
        b=Pf/XffTBOaSOvmodI3nui/CvjpQihOA8COvcUp5kjW91REX+FKBaRP1Mzs6+TIj0KP
         FsSod0D25SEuL8mzXy/Zr6/hQ/4DhiM3M4CPNMZGZ19aX6W3qH/Ctxe4YdGJA5TxoD6L
         mBbtxBDyyXq7/5kuUo3VABPrkVzcUkQOJrZ8+d/evSJqq2lTivv91eaQmUYDktL/b1Pr
         +C7rgoZLi+Wgb5VvgVrdm9dtzLx3np2a4XO1Pc/xtHhQPTPPEavmzntzEGGwoNu8sx0o
         vrMP+PfhkPoVMoobUnHn4a1zKkDIMwPEj98zj8hSb2wBbJqqUzIF0FsG3uda+0jPqR+D
         gmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=gjDGsH3K0hav1h9g3C72Xj3//qxC6le1H42uGY/mBiM=;
        b=FaPGIG+AIraR9q9atGUMqyuvIzkySPklyBWmn/iNATyNJDES8finEWcQPJgBEnsLOe
         BUiSYa9pqHjD8WLWTlcq30jgOFW2QkiDihsoAN8rYIEtb9v7lxNzjjHmJjrmD3d0nAs4
         JlRE9HvWEefpAnBe4IwuDXSYeYYL4qHw4E2SAD1dyMqsl1+8Baey5zIzoCyzKx8DhEuf
         Dwb8mS5tsWLFGbYSv6pyj81NToA1Cn7YkFQ8kSa1zuR0Arx0F9o8MwWvnOazCRAX8lVR
         gA3cQYOf22PDDsDmVATYQ3UfoeCiuG+81A1i8Vl4W1vXpubpwDPRGqc/zbq2YNpO2ELO
         FuQA==
X-Gm-Message-State: ACgBeo1udDNHBriV8Lt5X3VVmbgbcN+I5TjlI9ZXo4mr8oQ4Rtjd07mu
        MeyX8QoKmNx58rNVjKwoQZODPg==
X-Google-Smtp-Source: AA6agR7fe8InFzc2jm/fK/Xk2GRf49YPHz4tkTRjfGWj4cnI8Q9eDvrkyq/7cIRuQZLll6lXAz2T4g==
X-Received: by 2002:a2e:954a:0:b0:264:9f50:a407 with SMTP id t10-20020a2e954a000000b002649f50a407mr2610512ljh.374.1661840586801;
        Mon, 29 Aug 2022 23:23:06 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id bk37-20020a05651c23a500b00261ca006158sm349288ljb.54.2022.08.29.23.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 23:23:05 -0700 (PDT)
Message-ID: <dbbef6f3-cf47-a921-fd89-e940af3e2f85@linaro.org>
Date:   Tue, 30 Aug 2022 09:23:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/3] dt-bindings: pci: QCOM Adding sc7280 aggre0,
 aggre1 clocks
Content-Language: en-US
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
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
References: <1656062391-14567-1-git-send-email-quic_krichai@quicinc.com>
 <1656691899-21315-1-git-send-email-quic_krichai@quicinc.com>
 <1656691899-21315-3-git-send-email-quic_krichai@quicinc.com>
 <1fb5f0c6-ff72-b9ba-175a-b5197ed658a7@linaro.org>
 <9de4c3a0-eb95-f4e9-b828-2343241fff41@quicinc.com>
 <75f8b257-7e0a-d871-ab30-37a72f7da56e@linaro.org>
 <3dd98ae4-8b19-e241-3b64-fe24509d2cb4@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3dd98ae4-8b19-e241-3b64-fe24509d2cb4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/08/2022 20:45, Krishna Chaitanya Chundru wrote:
> Sorry for very late reply.
> 
> If we increase the common definitions of clocks properties to "13" it is 
> sufficient right.
> 
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml 
> b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 92402f1..c9e268d 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -53,11 +53,11 @@ properties:
>     # Platform constraints are described later.
>     clocks:
>       minItems: 3
> -    maxItems: 12
> +    maxItems: 13
> 
>     clock-names:
>       minItems: 3
> -    maxItems: 12
> +    maxItems: 13
> 

Yes.

Best regards,
Krzysztof
