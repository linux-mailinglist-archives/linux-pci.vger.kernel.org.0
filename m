Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798D07495AD
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 08:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjGFGfe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 02:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGFGfd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 02:35:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C11B6
        for <linux-pci@vger.kernel.org>; Wed,  5 Jul 2023 23:35:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9928abc11deso39436766b.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Jul 2023 23:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688625330; x=1691217330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Fcrx7Yb80pNkp2uhYzBT6R9rq95NqVLKKCQ4kXAxd0=;
        b=jmW5yDabP4Ok8Fr/e5sXXdC2reJet2oCtHDLIyzUXl3RZi/+e8lR3yq1hjaq2ucTd6
         on95I68Rzc8dD/EKyjP0KklY7Mzf+7LFof+c8R/R4P1iBwS/IEDigfTtU7+0yAWpFV+A
         ZlQN3IbSxQnLLVuFHLOkROx2k+m3HxVlKpkcu0yjxDkW/9K5JrmIhf/38vBuH3xOoTI9
         2iZFd29zoiaETJfADJ0bPy8DqF3T2BLt32ioCIOUBatYqruMmT72VvI7KhDnRWlJ5Jno
         3QnxCNTEXvQpck3Cf9H+87dBECpfJE876XuYTsTxjv5/waJ7PzZQp/1THCKWcW7EnsZS
         vzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688625330; x=1691217330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Fcrx7Yb80pNkp2uhYzBT6R9rq95NqVLKKCQ4kXAxd0=;
        b=H7tFhKvHuSEe7BB8iYvsMB5h5YFWJolFQCTo7cIONJOj3DNJmyApLiDHw9AlPggrlH
         8WcCJtoWJGMZZsj5ysD01cIlsMAVwSs91qc+z0bFJCtAWyiRghaHpi3dIWaHACjn18Y7
         CJxMLOCHgEDUr07quitH3AsV56Z+GeSv/oWdo+wWBCmJeJMGjUqTeeHOohLlzhHVXh2w
         BiHINgOcQtVx3ahv+I0g/g9ClImDmbPE2xLMLnS1J+8Et9eUAfYrwFp/yDxqbOUpl96B
         L+5ioWX13UZAcK6qRKfQQFGiIhcA5S7xwWD5Ofx/OTPaJYhEYiNyc0XIBPPz8F/665Hb
         KKUA==
X-Gm-Message-State: ABy/qLYIGcxf9LY6Yas+uUBmk9O+pcSK/GtXZZ0X/0OBSyBB72fV81zl
        zNYiMzp02dS8D/noWCdpX+/77w==
X-Google-Smtp-Source: APBJJlEwPvUUd4Sh/nUSdZr5t/lb9kULYOIyiN8QYiEi0U71/oBuWIa+ml3DArx10T5OowOhav02nA==
X-Received: by 2002:a17:906:5358:b0:98e:886:f27f with SMTP id j24-20020a170906535800b0098e0886f27fmr786493ejo.20.1688625330457;
        Wed, 05 Jul 2023 23:35:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id gf3-20020a170906e20300b00992665694f7sm383818ejb.107.2023.07.05.23.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 23:35:29 -0700 (PDT)
Message-ID: <6203ab10-c9b2-3ea8-a18e-dfd2905ec83f@linaro.org>
Date:   Thu, 6 Jul 2023 08:35:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 2/6] dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe
 PHY
Content-Language: en-US
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <1688545032-17748-3-git-send-email-quic_msarkar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1688545032-17748-3-git-send-email-quic_msarkar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/07/2023 10:17, Mrinmay Sarkar wrote:
> Add devicetree YAML binding for Qualcomm QMP PCIe PHY
> for SA8775p platform.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index a0407fc79563..9309066bfcee 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -23,6 +23,8 @@ properties:
>        - qcom,sm8350-qmp-gen3x1-pcie-phy
>        - qcom,sm8550-qmp-gen3x2-pcie-phy
>        - qcom,sm8550-qmp-gen4x2-pcie-phy
> +      - qcom,sa8775p-qmp-gen4x2-pcie-phy
> +      - qcom,sa8775p-qmp-gen4x4-pcie-phy
>  
>    reg:
>      minItems: 1
> @@ -30,7 +32,7 @@ properties:
>  
>    clocks:
>      minItems: 5
> -    maxItems: 6
> +    maxItems: 7
>  
>    clock-names:
>      minItems: 5
> @@ -39,6 +41,7 @@ properties:
>        - const: cfg_ahb
>        - const: ref
>        - const: rchng
> +      - const: phy_aux

Nope, you didn't test, did you? You cannot just add entries in the
middle - you break all the boards.

Plus, you clearly missed to update the if:else and all this won't work.
Just test the bindings before sending them.

>        - const: pipe
>        - const: pipediv2
>  
> @@ -136,6 +139,20 @@ allOf:
>          clock-names:
>            minItems: 6

This is not valid anymore.

>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sa8775p-qmp-gen4x2-pcie-phy
> +              - qcom,sa8775p-qmp-gen4x4-pcie-phy
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 7
> +        clock-names:
> +          maxItems: 7

Keep the same approach for clocks and clock-names. Not min here, max there.

> +
>    - if:
>        properties:
>          compatible:

Best regards,
Krzysztof

