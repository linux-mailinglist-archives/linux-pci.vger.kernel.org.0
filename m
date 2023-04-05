Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EAC6D74D3
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 08:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbjDEG6L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 02:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236967AbjDEG6K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 02:58:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EDB4699
        for <linux-pci@vger.kernel.org>; Tue,  4 Apr 2023 23:58:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cn12so138651396edb.4
        for <linux-pci@vger.kernel.org>; Tue, 04 Apr 2023 23:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680677887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0Tz16hU06t/jQvjXVl+O8i4gFgw1SyUWujyjlJaCwE=;
        b=PpeuMEURank6WUN37V4HZv7lRqZapYIrqDhEh/0MAOF0xAM6iGWHE3p8+TaQbwKqqt
         SqBNO0Se7fAt0U4SLk+d1uBfYaIB7XEsMdmz+E32OPu/fPKk+ITy79f3ExewF+X66HYx
         0bjVb1NfXnBvhNXvfOhgltXAl1uRRp3fSKPkxlADVSGEvak1/2cZ4Xfeuw+azyOEegnS
         Fw0rWnlbSXuycNRHp9YYphMyg6Q7i+IajYa+p6r/9ph+dnezsvf2Ewti+4+CzjcH1u11
         BcClMQhgyNnYjKsgPxfhLurW/gyHXJRbgb1ncHIgxQ7sGG3oVfU9WX5OLXhFd30i25Cd
         YyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680677887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0Tz16hU06t/jQvjXVl+O8i4gFgw1SyUWujyjlJaCwE=;
        b=KzlLMwH+0ZQaEzAa8tIlxaQbZyhZNYItVQYMm6VfbGe2kNb2w/LTjHD8uzM9UcYtmd
         QyRmym3x6MovJ1IQFxl0pPmrSTg32TOC76kI7cLiDE7HSe/PFLp4xcbBju2WbipfpZOa
         8XzQyoK5goMOPrlA2ky0C18GzppxO6I+R3yWtuTNN2RINeN2swxi8W+Pdr3rJp5tGizt
         eNl5UG6gTpGBbNb05LDhGGjESZ3rK1Gu5iXEbvOwgobCoizahAxBshnrFLDKF42S/lXa
         nUDeg7ZIqTPCIgC3t5c5oi4UBz0hjWzipi5y+wk3ZvwRBNJFHha6op3Z+VFw4HjL0OBh
         sl8Q==
X-Gm-Message-State: AAQBX9fWQpPZw9RP6bGZ0227/XbFrjDsPNtLqQGv9QatEVygie+eUa33
        fvoOmjGsorpe0kLhZ53unlpQaA==
X-Google-Smtp-Source: AKy350ZE3HG/9IWJXBZKKUuUf6EPSfW9JpqSBUDBkoR1mNRrxXUL7GIWWbjCguslGb4ZJPTIDoA3gg==
X-Received: by 2002:a17:906:384a:b0:931:6641:9897 with SMTP id w10-20020a170906384a00b0093166419897mr1759666ejc.44.1680677886921;
        Tue, 04 Apr 2023 23:58:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3f:6b2:54cd:498e? ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906d18a00b00923f05b2931sm6938769ejz.118.2023.04.04.23.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 23:58:06 -0700 (PDT)
Message-ID: <79ddaff0-00a9-36db-2bc0-4c844ffd9528@linaro.org>
Date:   Wed, 5 Apr 2023 08:58:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 5/9] dt-bindings: PCI: qcom: Add IPQ9574
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, mani@kernel.org, p.zabel@pengutronix.de,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
References: <20230404164828.8031-1-quic_devipriy@quicinc.com>
 <20230404164828.8031-6-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230404164828.8031-6-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/04/2023 18:48, Devi Priya wrote:
> Add bindings for PCIe hosts on IPQ9574 platform and allow
> msi-parent property

Missing full stop. Also in your other patches.

> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V2:
> 	- Updated the commit message and dropped the aggr_noc entries
> 	  as it will be handled via interconnect driver
> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index fb32c43dd12d..8657ab65008c 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -26,6 +26,7 @@ properties:
>            - qcom,pcie-ipq8064-v2
>            - qcom,pcie-ipq8074
>            - qcom,pcie-ipq8074-gen3
> +          - qcom,pcie-ipq9574
>            - qcom,pcie-msm8996
>            - qcom,pcie-qcs404
>            - qcom,pcie-sa8540p
> @@ -105,6 +106,8 @@ properties:
>      items:
>        - const: pciephy
>  
> +  msi-parent: true

Isn't this conflicting with Mani's series:
https://lore.kernel.org/all/20230108203340.GA229573-robh@kernel.org/
https://lore.kernel.org/all/20230111123004.21048-1-manivannan.sadhasivam@linaro.org/#t

Although for some reason Mani's patch references non-existing commit and
hunk...

Best regards,
Krzysztof

