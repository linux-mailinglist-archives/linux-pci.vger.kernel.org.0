Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28585B4F65
	for <lists+linux-pci@lfdr.de>; Sun, 11 Sep 2022 16:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiIKOPA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 10:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiIKOO7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 10:14:59 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772A0DFCD
        for <linux-pci@vger.kernel.org>; Sun, 11 Sep 2022 07:14:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a14so5576581ljj.8
        for <linux-pci@vger.kernel.org>; Sun, 11 Sep 2022 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ddlxEjUCTa5p+PAW4T51jeoxEb5xm1//QtVZS2B2ZgI=;
        b=Pm5lgItTseorDVzE7EcLBSIE7xajSLwpFiaQ7ZXfo/QmOGxopfTWQiCuzwkc5Vee5n
         hYqVXFbIFAxcKLG8SKRBEzvjCblPH0Em4s0y3JyZN/7qHdE8sH12SsLjtMYPfZloGC9H
         r2TXYqW6LvWmJSLNFuPo4Wt2WXUuA78oOJ78yE5B/xgjE4bsW7nLG/ZAuxcA+0QL5feZ
         zV9ou4IIxW7ZdOrVRQFlIZDyjn4pYiQKysTmnzxGInc4d3JgIYfHEFIrLkErn7wOZSjV
         b9PBLy11MqGtddV6ZnyNFN7dPnbFtHyyDRiNOJSJSzCT7L/V4YPWNLyqq94x5304S+SG
         lbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ddlxEjUCTa5p+PAW4T51jeoxEb5xm1//QtVZS2B2ZgI=;
        b=tL04Ws3HbUNjxdzgwRf8RvKw+gdRj7A6aombaFpKSpeyqwH4PcLe53u29J4Ynd5RDp
         heA4osMEtep2aiWIHvHINlE3YyMfYJcoFriY8Pwu5BJ/9RhKhm1HjruS+gC2mR/M0GKw
         NOTQ29+x0vIs9XbqyNgk/LSevS/Y6e/+Xher3/XESbrUy68//YC9HhDyZq1TGa+YOpq4
         hyPRP/VJWOAdlvkrbARyzUy1DswWqzsAXQFT835ydyrO3u52mRu6bE3/E0dwrreyUNHK
         FvUjykykx+hsLTPqiZLg2whQc5rEgLXyZrAmufvDIz6HMQyaupbr711t0lmcJdu7BouS
         JiwA==
X-Gm-Message-State: ACgBeo1o3J0mxh6EjtaMX4Hx5o2r6Uac4Z0u/aY5RGOhXESB362N8ukp
        yLBmWUZbbf/MmqSti+9XAOIXnw==
X-Google-Smtp-Source: AA6agR6/WvcfCz+aB6nzGKHOQzd/f18YPvf0ok5/H1DGcGun+eLMBpR7AZ8TZeI7MuUlFXNCufiC2Q==
X-Received: by 2002:a2e:9b91:0:b0:26a:ce59:c517 with SMTP id z17-20020a2e9b91000000b0026ace59c517mr6117571lji.181.1662905695793;
        Sun, 11 Sep 2022 07:14:55 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c9-20020ac25309000000b0049488c97d39sm617989lfh.212.2022.09.11.07.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 07:14:55 -0700 (PDT)
Message-ID: <11e61fa5-f770-9c9f-23b9-3d1dcb205bc5@linaro.org>
Date:   Sun, 11 Sep 2022 16:14:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: pci: qcom,pcie-ep: correct qcom,perst-regs
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20220911135547.23106-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220911135547.23106-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/09/2022 15:55, Krzysztof Kozlowski wrote:
> qcom,perst-regs is an phandle array of one item with a phandle and its
> arguments.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 3d23599e5e91..077e002b07d3 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -60,8 +60,10 @@ properties:
>                   enable registers
>      $ref: "/schemas/types.yaml#/definitions/phandle-array"
>      items:
> -      minItems: 3
> -      maxItems: 3
> +      - items:
> +          - description: Syscon to TCSR system registers
> +          - description: Perst enable offset
> +          - description: Perst separateion enable offset

Unfortunately this still complains:

qcom-sdx55-t55.dtb: pcie-ep@40000000: qcom,perst-regs:0: [28] is too short


where 28 is the phandle...


Best regards,
Krzysztof
