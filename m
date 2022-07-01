Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E48562E7D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 10:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiGAIiA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 04:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiGAIh7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 04:37:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B28170E59
        for <linux-pci@vger.kernel.org>; Fri,  1 Jul 2022 01:37:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ge10so2738506ejb.7
        for <linux-pci@vger.kernel.org>; Fri, 01 Jul 2022 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1WQVuVIPexBahkdV6MZa+vck0C6FxbSUn0ebkIBxpsI=;
        b=qPCwwRZZZAtW5TPWaSuLrZFrLZwU/E53jamwnAT7IeifiKEgnejqkRUa2KDdV6qwLL
         XN/LvtQhaUwgqsCuTW2FmNJpaa2C9BnFeOpCl293PHT3l3+YgJTzGjj/5DVDUGXzAhwD
         fTywKkVAoiU0sijdS62J9SDGsQBX50BctVS+4hyBbdw+VAPXuYYmFHQzA37ijFOXOSfe
         Q+izGAFFv4i/+1OjXCr6gagHVARRTcUa24u2JyBz4gPFj2Rd0KfcB7nDUh9P9tZr+jeW
         diUR5/Z57C+5MRYq4vWsca5MBt7uU0oN1P+26j0jzfAr5T1VSL3qIPIyljHhMuyS+uSw
         ybBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1WQVuVIPexBahkdV6MZa+vck0C6FxbSUn0ebkIBxpsI=;
        b=U/lFOOlFtD4vevjfhSvy6z4G9T4r3bZbvsQNq0rJe6MBUTDQtTqYGaK1vqg681SFk0
         Aan8Y+21G45WDKLNJ09iqocxUDHlZpTyP5+3aBObxoLLUipv58WT/xrQ0fl1sIHwAZdL
         z/B9/6aMAlW6rDeFZaw5nixCl3LumoTznOChPhhGtdw262ija+yQWxHpnN93o8rakFj8
         21PZZH19n1PrBKJmvftRsWR/RVZPbct6J/FUXQvbeAXrcKpW7hVdBQdG5X+mhh7/06IL
         4t0g7ljDXo1CA12ZjaT1zrobuLm+KwzrQoL6jmwHkozQ1Jw5dWfX6ra11iAqLwlDNnFY
         mvSg==
X-Gm-Message-State: AJIora+zr5m7QeccZDI8hSs/sSi35HTpOUo7iWRS764jUepwcS+AcR9p
        y1BNUwWdzD4cPEq78aZ/6MSbjw==
X-Google-Smtp-Source: AGRyM1tTf/7FBhjFpRJ2xfo7v2mGuhaFbpwjmhRkpCnK0UbZgh1sS6O4o+vXBCjB0zUKyFHc31qfJQ==
X-Received: by 2002:a17:907:3dac:b0:722:e6ab:8d9 with SMTP id he44-20020a1709073dac00b00722e6ab08d9mr14484157ejc.20.1656664676652;
        Fri, 01 Jul 2022 01:37:56 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d6-20020a170906174600b00715705dd23asm10177288eje.89.2022.07.01.01.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 01:37:56 -0700 (PDT)
Message-ID: <2f3cc247-d56d-2338-d8e8-3ab32bf7f7ad@linaro.org>
Date:   Fri, 1 Jul 2022 10:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 04/10] dt-bindings: PCI: qcom: Add SC8280XP to binding
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-5-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629141000.18111-5-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/06/2022 16:09, Johan Hovold wrote:
> Add the SC8280XP platform to the binding.
> 
> SC8280XP use four host interrupts for MSI routing so remove the obsolete
> comment referring to newer chipsets supporting one or eight interrupts
> (e.g. for backwards compatibility).
> 

(...)

>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sc8280xp
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 4
> +          maxItems: 4
> +        interrupt-names:
> +          items:
> +            - const: msi0
> +            - const: msi1
> +            - const: msi2
> +            - const: msi3

What the previous #3 commit is missing is:
"This allows for adding further platforms with for example four MSI
interrupts, without resorting to nested conditionals."

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
