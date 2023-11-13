Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361D07E9D41
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 14:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjKMNfY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 08:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjKMNfX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 08:35:23 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA151A5
        for <linux-pci@vger.kernel.org>; Mon, 13 Nov 2023 05:35:19 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so4168022276.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Nov 2023 05:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699882518; x=1700487318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WxaBetmt1VHQkxFwpab5NRYOQI6Xx5tYoo4BJzlpyR0=;
        b=MJvRt5fbADU8RJrP8b9qlxdsPqtT6uMryfJBfliBWtKzmnri5+XoL99zl+lI5KRoVd
         nHuBsluSpH4VUf7YlouQ3CQCSWMDbGZz1TDUNPY1GWXEtBDQjXXIVj/qHeWasDWsHYoi
         N2pQfZ1d/oZKsTWMs2lVrW2H5566xhqFCYN0ezQNuwKHvftaKXzJAa5GlofisvdCfCpA
         wI4y0zRDWRU2tZr8OuTdvIeAKiVZp9voA0cIPpCdCSaW4/U0UrHUIko+nWFNFDt9I8ro
         8BAxNtND0UqkJgXbM6H7mdT9HXqyTRDd4GAv1xKjUdruj+omORfcGTmnnKwpXub+2BhA
         V34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699882518; x=1700487318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxaBetmt1VHQkxFwpab5NRYOQI6Xx5tYoo4BJzlpyR0=;
        b=upEkVAziX6AMVb76b1W3eBwHG9XqSbcPCfhXt51/+Ebf+k9+mq6oXULkpFRs4qPGa2
         JkxqPLyIkGxtO1m3eeONIdrsz+VJlaHl6kI1URVogwNK1FvNbyOkzIOlPSZ+ZuPOPHdY
         Fr7MEQ7sZ7m0HZKBSLClEsppP8jBU7WqWoi14l6NIbbIOleqm0Q8xy2FUtTHHlMHvMR/
         BX+NowZz1loTDZfcZhn2aluBMcIDR4OOgiVvISgKbHvvTBpcnJICUfBkuVZF43vNjJag
         ZEXsvANm2OcHKO7+ytXKzjTm4lEd2hHd1MwCl/ZBFH/Xl72Pk3mdofErAHXmetW9I4CH
         ZfsQ==
X-Gm-Message-State: AOJu0Yxs0Muf0FXxVQ6z5qiLokIsOJ+5RX/zM25TFYryX1L/8eOJ0k7N
        oQCYfzGyd4cIgLrQu8QOi3BWiX5MkfnIFRZZlRYCdw==
X-Google-Smtp-Source: AGHT+IGPu7Rn5TQZs+nbjVZoYL/TJSffa3l5p9Nq+lau/Fo1c7x1h4SnyWxankMCKEl1H6csQ9NB+nxzflMOa4pF/l0=
X-Received: by 2002:a25:c048:0:b0:da0:69e4:29d5 with SMTP id
 c69-20020a25c048000000b00da069e429d5mr3641047ybf.43.1699882518441; Mon, 13
 Nov 2023 05:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20231112184557.3801-1-krzysztof.kozlowski@linaro.org> <20231112184557.3801-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231112184557.3801-2-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 13 Nov 2023 15:35:07 +0200
Message-ID: <CAA8EJpqGNF=j4Ym-mFGb9XyQkXWd2DWm3MzRKmnQckFkBh1X7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: PCI: qcom: correct clocks for SC8180x
 and SM8150
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 12 Nov 2023 at 20:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> PCI node in Qualcomm SC8180x DTS has 8 clocks, while one on SM8150 has 7
> clocks:
>
>   sc8180x-primus.dtb: pci@1c00000: 'oneOf' conditional failed, one must be fixed:
>     ['pipe', 'aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'ref', 'tbu'] is too short
>
>   sm8150-hdk.dtb: pci@1c00000: 'oneOf' conditional failed, one must be fixed:
>     ['pipe', 'aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'ref', 'tbu'] is too short
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 58 ++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 14d25e8a18e4..4c993ea97d7c 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -479,6 +479,35 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sc8180x
> +    then:
> +      oneOf:
> +        - properties:
> +            clocks:
> +              minItems: 8
> +              maxItems: 8
> +            clock-names:
> +              items:
> +                - const: pipe # PIPE clock
> +                - const: aux # Auxiliary clock
> +                - const: cfg # Configuration clock
> +                - const: bus_master # Master AXI clock
> +                - const: bus_slave # Slave AXI clock
> +                - const: slave_q2a # Slave Q2A clock
> +                - const: ref # REFERENCE clock
> +                - const: tbu # PCIe TBU clock
> +      properties:
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -527,8 +556,35 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - qcom,pcie-sc8180x
>                - qcom,pcie-sm8150
> +    then:
> +      oneOf:
> +        - properties:
> +            clocks:
> +              minItems: 7
> +              maxItems: 7
> +            clock-names:
> +              items:
> +                - const: pipe # PIPE clock
> +                - const: aux # Auxiliary clock
> +                - const: cfg # Configuration clock
> +                - const: bus_master # Master AXI clock
> +                - const: bus_slave # Slave AXI clock
> +                - const: slave_q2a # Slave Q2A clock

Which actually brings up a question, there is the corresponding clkref
gcc clock.
Mani, do you know if we should use it on sm8150?

> +                - const: tbu # PCIe TBU clock
> +      properties:
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
>                - qcom,pcie-sm8250
>      then:
>        oneOf:
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry
