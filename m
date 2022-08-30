Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ADD5A6C64
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 20:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiH3SlL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 14:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiH3SlF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 14:41:05 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E1A4DF33
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 11:41:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bt10so16762694lfb.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=whr6DsPc0YpQivNDZQFyeGw5fN+mBCcZ18Z6UAvm9sg=;
        b=Rpd6Ew4iEx/DBhQPDIm7iU/aVsRKanTgd/uFQ49Dmw2HgayJ0KXQO0dfniF+F3KYFj
         2tDZl2Z7hOlhvxBIhqE36WG9PP/dp0UH3KzzpUZhOT2W9OhpBTbztuB3yTznz39rZiIm
         yiyEv3pKSa8OT4TwF9QjZf7tW+CiPL7ZYFf4eGuAt95EWd00w6AwgWOK00Oy4c+3qUtt
         qeg8eg1fYJF+oEMV+7N8oEo3ovJiMFvvC30N8TgN/XYOMHALQCdnooaqPDd4CvbtjSoi
         a/T/Do+jAlghN6jlNVj4nDGMpCHCnc7F8VHdIODKnv0MdFx1yihi94QmpPbMl+TvgNgW
         EUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=whr6DsPc0YpQivNDZQFyeGw5fN+mBCcZ18Z6UAvm9sg=;
        b=5RXiITZuUm3fZRJOQ80zSsW6ze2KArAKBFPIEGTcnkEcU3RU4/bY/dEwzfOBSBHDyn
         LNtT9bUKVhvg1t/J/Y5HwE1aDw9zqPNC0znRjvMW7qyHMJz+VeKpvIyOWfmkAT7sDeai
         3jX2bVjJVaC/FTfZqrPIzVCrrWQZaTsPhitMlPK/AIOJdZpNjTzAyAzwrUT0m9SO7JAW
         uggaloeTbHnCurNaiaDROVIrn/2YdcQ/0d/IHdHUJyxfP79K0H6UNoTA44XUy1g+pjjD
         fO3jQUwM83R5dmzxnC6i6+iZVJgxlUzFCJr4nibbGjx/wY6gLxRYG6FLkc/pD6US697R
         7T3Q==
X-Gm-Message-State: ACgBeo2MJfeREIFvHBY0QceKEZ+IXJRUxtU6JbzXl+dGdWSkh6uhgY6e
        taG2b9S8y2/Rq64SnB4RkFqvbA==
X-Google-Smtp-Source: AA6agR7uzUMU5pJwXm8j90akKK+hS5iuQ/1f7T9YtWDas3OtBJVsQazsaOBVXkgtA+NzkUBx8xlVDQ==
X-Received: by 2002:a05:6512:260f:b0:492:8e9f:c647 with SMTP id bt15-20020a056512260f00b004928e9fc647mr7650980lfb.443.1661884862629;
        Tue, 30 Aug 2022 11:41:02 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id a28-20020a2eb55c000000b0025e2c5a12b6sm999660ljn.129.2022.08.30.11.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 11:41:02 -0700 (PDT)
Message-ID: <69960d7f-321f-f8b6-66d3-456bbf697858@linaro.org>
Date:   Tue, 30 Aug 2022 21:41:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 10/11] dt-bindings: PCI: qcom-ep: Add support for
 SM8450 SoC
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org
References: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org>
 <20220830165817.183571-11-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830165817.183571-11-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/08/2022 19:58, Manivannan Sadhasivam wrote:
>    clock-names:
> -    maxItems: 7
> +    minItems: 7
> +    maxItems: 8
>  
>    qcom,perst-regs:
>      description: Reference to a syscon representing TCSR followed by the two
> @@ -125,6 +129,36 @@ allOf:
>              - const: sleep
>              - const: ref
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm8450-pcie-ep
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 8

Same as in previous patch - maxItems is not needed now.

Best regards,
Krzysztof
