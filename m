Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D70750CCAC
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiDWRpS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 13:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiDWRpR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 13:45:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B742B1C82DB
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 10:42:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z19so718377edx.9
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LbRzeDAjy6fnrJr6yVrq75r/UBTFpWYg7kr1cOLO86c=;
        b=OiINMpUtZfOhCA0Gwct8tazoRImEUSdbADFnsLxRR3qqtJQsHu9qQkynHHdJPIA8cB
         v3yJJbhtQOYmwTfGRst1GsOno+mpxKEXeYbYqZO558Bsfj5BGf+fBKyC550FQNllQK/5
         SJzFd135YJPBGl+gpbz0L16/7JC6M1ZhOVb9wsxY2H4oTx9lYVv303XXVarmxcMmxgM+
         NMUcA5RI+SewINPXd+rYVLnKhQLx+T1psn3aeR8iv8CnqgliC6Zl/fLy0N66/8TbZM6T
         OH5AqYt4OSmEaxD4gTbwZU6PMmwA3CAXYDfLuGXOg4I5xK9X628zlC9mhXPneWTXHh5X
         76Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LbRzeDAjy6fnrJr6yVrq75r/UBTFpWYg7kr1cOLO86c=;
        b=W+p6Io9dSCefqgxAE4GPu6aXOgRTtEYU1zWQW7hGwBZOXTKVjUEwNB04nVNRvx9okq
         PY4o/HxpUba4ckEf1+mF5wxhzv0Ahn+UZmdn9DISyBMVPM0r53l+zcs/AbOZLJBiQN3o
         +Z9/L3OgZb9ky6rH90f70eajOy25ePvGA0tZRkis8B4nFMy3XNXhc6cZ6u678IvNzn4R
         KqNeuYR6Am3P/kvlWvRGw0Iin3pn5BfvobtWwh1XdX0F0nCd2F7RjWMoP8YNdnYVOdF2
         jnPJiv8QVXrIZwTr9g1Y/0CQ3PYlXxPDu+7pwXk0nRJzrhTA0YMgrQoQthXRsNbE/3Wj
         WaSw==
X-Gm-Message-State: AOAM530M6iNmWiSdawG3kUv9HaIR8kPI0nFjMlAHjjAAStpOjB05B8tv
        uDu8UIKOszjvUogV/VCAJF+DdQ==
X-Google-Smtp-Source: ABdhPJyWfTWnUqm+XYX//SH7CuN+w8thcuMK/NbaH9V3Cv4kHlU+uprsMr2wijKMYKM7LicdlVCq3Q==
X-Received: by 2002:a50:baa1:0:b0:418:849a:c66a with SMTP id x30-20020a50baa1000000b00418849ac66amr11178279ede.234.1650735738292;
        Sat, 23 Apr 2022 10:42:18 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t1-20020a170906178100b006e7edb2c0bdsm1868427eje.15.2022.04.23.10.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 10:42:17 -0700 (PDT)
Message-ID: <a6230e2e-3bb0-c47b-959a-1d4ed236ebd9@linaro.org>
Date:   Sat, 23 Apr 2022 19:42:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/7] dt-bindings: pci/qcom,pcie: convert to YAML
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220422211002.2012070-1-dmitry.baryshkov@linaro.org>
 <20220422211002.2012070-2-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422211002.2012070-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/04/2022 23:09, Dmitry Baryshkov wrote:
> Changes to the schema:
>  - Fixed the ordering of clock-names/reset-names according to
>    the dtsi files.
>  - Mark vdda-supply as required only for apq/ipq8064 (as it was marked
>    as generally required in the txt file).
> 

Thank you for your patch. There is something to discuss/improve.

(...)

> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: "msi"

Skip quotes. You anyway later remove them in other patchset.

> +
> +  # Common definitions for clocks, clock-names and reset.
> +  # Platform constraints are described later.
> +  clocks:
> +    minItems: 3
> +    maxItems: 12
> +
> +  clock-names:
> +    minItems: 3
> +    maxItems: 12
> +
> +  resets:
> +    minItems: 1
> +    maxItems: 12
> +
> +  resets-names:
> +    minItems: 1
> +    maxItems: 12
> +
> +  vdda-supply:
> +    description: A phandle to the core analog power supply
> +
> +  vdda_phy-supply:
> +    description: A phandle to the core analog power supply for PHY
> +
> +  vdda_refclk-supply:
> +    description: A phandle to the core analog power supply for IC which generates reference clock
> +
> +  vddpe-3v3-supply:
> +    description: A phandle to the PCIe endpoint power supply
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    items:
> +      - const: "pciephy"

Skip quotes.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
