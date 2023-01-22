Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FC4676D69
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jan 2023 15:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjAVOJT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Jan 2023 09:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAVOJS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Jan 2023 09:09:18 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ED91A8
        for <linux-pci@vger.kernel.org>; Sun, 22 Jan 2023 06:09:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so8884994wma.1
        for <linux-pci@vger.kernel.org>; Sun, 22 Jan 2023 06:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9NpMSfkooTiSv2ZBQPfxArsfZPBfz7GqCCR+XSaAOg=;
        b=OHuy7+aZrOI8AjcM8rXiRTGA3F82tyHoun7dlV3o8JzEZmu1Nib00YrXclUIX/IbyW
         HZMEi4IkWMmrLwsEnwqjOUM0hEcQT8eP8GEGCYUAhXpKrCYv9p+0oo99ESXe7IwBM9pC
         cX9ZcC7snaiqc5qFHw6dsS6iAA7cLqR2k2s90SqJIALSOQ0xp0IY7fra+WkISkChBjXL
         6iKH/5fp67J/EhDZ2Ql+huD+NgZupKYXqSsuZhPOMUZaKwq+f3Uc+P2GTq/5LPi084M9
         2hjWiw0Xb+/cUfzetx93dAXrOYxU4SJFL8C8co7LdHA53ZusDtvuHhBzi6KFtjHrCMN1
         Y4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9NpMSfkooTiSv2ZBQPfxArsfZPBfz7GqCCR+XSaAOg=;
        b=fpnrqZj6Li/fHI6CuBr26cQDgoYHJdZElYwh7Iqay/pf8xlgWqAOEDuBdLRAq8vBF8
         slIIN9L4zFNs2ip1jPj3BDBTjjnSDFX7E/36ZtbyDYf17rT0qBJhbHrv8gFTgOXYM8qT
         uQak9xJZCfQYJB5zKdwjt24CtYoPeAl7uvv/y9gPFSxBOS3xrytj6DutMk7B0ym5BdiA
         5k/RIXOwzuEphiH3VKukS+lKdh+AhZEZgJ9juumgDZBIkZGfFDfiu2+EvVnsMZKO9esk
         dlu3j8oFv5jrzKHY7hKfPu0F9NaAaLRgEaPrQk28bkvzQiyYvTzGKm6axBoAih+TxFnT
         4XWA==
X-Gm-Message-State: AFqh2kpw+K3wSUsNq6tuZPFSnqhaMn9gt1x7HE4uVgK5T8r3gxeQYloq
        qqrytKVueAoT1L7UDh9l4rICxw==
X-Google-Smtp-Source: AMrXdXtDA46PnZEz1olLAyyVedLaw70rB9bL/u8qM6NXPsKsze4CIEalUOanBH3tAqmcu3CtNmfDPQ==
X-Received: by 2002:a05:600c:3b05:b0:3d6:b691:b80d with SMTP id m5-20020a05600c3b0500b003d6b691b80dmr20881250wms.21.1674396556168;
        Sun, 22 Jan 2023 06:09:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d544a000000b00273cd321a1bsm2853845wrv.107.2023.01.22.06.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 06:09:15 -0800 (PST)
Message-ID: <938a5115-48e4-73f9-8a7a-ae890eb10077@linaro.org>
Date:   Sun, 22 Jan 2023 15:09:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 01/12] dt-bindings: phy: Add QMP PCIe PHY comptible for
 SM8550
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
 <20230119140453.3942340-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119140453.3942340-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19/01/2023 15:04, Abel Vesa wrote:
> Document the QMP PCIe PHY compatible for SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> This patchset relies on the following patchset:
> https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/
> 
> The v3 of this patchset is:
> https://lore.kernel.org/all/20230118005328.2378792-1-abel.vesa@linaro.org/
> 
> Changes since v3:
>  * increased the allowed number of resets to allow ncsr reset
>  * added vdda-qref-supply which is used by pcie1_phy node in MTP dts
>  * added both compatibles to the allOf:if:then clause to constrain the
>    number of possible clocks to 5
> 
> Changes since v2:
>  * added back the binding compatible update patch
> 
> Changes since v1:
>  * split all the offsets into separate patches, like Vinod suggested
> 
>  .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml      | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index 8a85318d9c92..4b4566f90811 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -20,6 +20,8 @@ properties:
>        - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>        - qcom,sc8280xp-qmp-gen3x4-pcie-phy
>        - qcom,sm8350-qmp-gen3x1-pcie-phy
> +      - qcom,sm8550-qmp-gen3x2-pcie-phy
> +      - qcom,sm8550-qmp-gen4x2-pcie-phy
>  
>    reg:
>      minItems: 1
> @@ -43,16 +45,21 @@ properties:
>      maxItems: 1
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    reset-names:
> +    minItems: 1
>      items:
>        - const: phy
> +      - const: nocsr

I think it is valid only for this phy variant, so please constrain it to
1 entries for all others.

Best regards,
Krzysztof

