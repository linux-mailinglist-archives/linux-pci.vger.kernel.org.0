Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4777F0FF8
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 11:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjKTKLm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 05:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjKTKLl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 05:11:41 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B4995
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2023 02:11:38 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a87ac9d245so46373537b3.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2023 02:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700475097; x=1701079897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B4DwwxeJHrf/t+v6tAUC2iWPA37bLE7YwlZADB165iU=;
        b=cjckvdx2SEB19MVZii0zOffZHTCzdGQ4TITxng5434/UGoEIgS8yERrNoGwPkNgr2o
         wu30R6a6SbgpIXgu7g5Mxp7afqSowegMjjWuX8woWr+GR2xIzDgxa8F4Jb9IdvF+Osd7
         bXAa2sI7LYbZRN6KJP4H8jUcVXpK6kTidcrkUzvGI6DSqg33ajWdIb6JlXwCuwFXF2FO
         oYWGdO6Ps2nagzafb/upkcCSWPLwpeTsbNqjrrMNOrLslNgmlZJq/NSa1xkaJdhv5uK3
         L+tO9ogdMbX33gIf9iHu5Jq5fo70pMes5pDJ22YIq6BdJuZtnR2gF2mc6k9KLr6g1FcX
         W6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700475097; x=1701079897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4DwwxeJHrf/t+v6tAUC2iWPA37bLE7YwlZADB165iU=;
        b=gf2VqWi4etd9tfMKM5RZs5WWPOyMbRPOOceb8bBP6f90CS40SQdfZL2FlziWoiIPzb
         XUftJC/dsAwOe+ad01PCLeWWzLbmZzlEap6mTyHWfX1Uh1YhkwFIzalB0PDEsz7X1xxD
         AIJ41kpcNgWbgeMPJNbb7RlJXZdln76m9WvoK6kU3aGT8DQJf9idZjftcGeSaKfy2+2M
         BBfAMfCDmgo279Y4TDf38spCSknz/EubxiE6XqncGJ/K9D60Mr/hje3VVSPK2HgB9+/T
         XpYnZSedttbkSSARXA4m2kXjScrjibZv+tWK7XhGdzBxudCiVqACG/do+xEc/eyb9RgW
         iWWw==
X-Gm-Message-State: AOJu0YxRVCk3o19G/2/u0bcvXn15ieUsvnclmJ96jSgs2RSbsDIRsRkL
        SeFF9w9YntWSugaMnLDrN3B7bUBXhYJeKB1r0UpiYA==
X-Google-Smtp-Source: AGHT+IGXOxTwa1HRllY+uHq817UzeWInj/FqsIOPEgBTZ/NXrLJ4PhyRsQMjxvVa3Ll/96WsDJM/S80Cek1vwMq+dO0=
X-Received: by 2002:a0d:d403:0:b0:5a7:a874:d83e with SMTP id
 w3-20020a0dd403000000b005a7a874d83emr7186294ywd.42.1700475097489; Mon, 20 Nov
 2023 02:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20231120070910.16697-1-krzysztof.kozlowski@linaro.org> <20231120070910.16697-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231120070910.16697-2-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 20 Nov 2023 12:11:26 +0200
Message-ID: <CAA8EJpq6YOYGvxFwreNSoTShrKryqeEy79CTb0dFO-Dv8RNxZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: qcom: correct clocks for SC8180x
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

On Mon, 20 Nov 2023 at 09:09, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> PCI node in Qualcomm SC8180x DTS has 8 clocks, while one on SM8150 has 7
> clocks:
>
>   sc8180x-primus.dtb: pci@1c00000: 'oneOf' conditional failed, one must be fixed:
>     ['pipe', 'aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'ref', 'tbu'] is too short
>
>   sm8150-hdk.dtb: pci@1c00000: 'oneOf' conditional failed, one must be fixed:
>     ['pipe', 'aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'tbu'] is too short
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Changes in v2:
> 1. Add Acs/Rb.
> 2. Correct error message for sm8150.
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

Mani promised to check whether we should use the 'ref' clock for the
PCIe hosts or not.
I'd ask to delay this patch until we finish that investigation.

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
