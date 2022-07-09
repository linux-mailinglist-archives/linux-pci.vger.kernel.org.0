Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA72F56C7D1
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 10:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiGIICS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 04:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGIICR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 04:02:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3805470993
        for <linux-pci@vger.kernel.org>; Sat,  9 Jul 2022 01:02:16 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j3so865847pfb.6
        for <linux-pci@vger.kernel.org>; Sat, 09 Jul 2022 01:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1LvIk6cTreIksV1+554QjuQj/Z56N830zZ3HcrbhmJ8=;
        b=iK839jPA0ee/NDlgGSNMk3CfEMb5iiG/k6trAWJmFJ9F5viM42OicX/uxr+G/gvdY9
         78C8vs7JlyEkbFzf/K9mwfPvU2LeNIvNTeT7eVjsnR+4b5vbMEoL4i67EoRec95ikhbY
         QevioK66sYcElRiu/XMMYp0cYoRQr+vTPZLR0WFfCmAFsOyCXih5+XbcMqPzKo7iLJH/
         mcIh9uMS70yZJlzjuZP+oK1I5VlESskqTmO3a+AA32dUvjulCJbJHN2dOf/BNYrQUNem
         39JWBOEm2XiF9Q2FvH2dBL/rTzxGjzSiHXPppjWhKfa830TTQJr1j9oDQ0qvVwzjZVBM
         taEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1LvIk6cTreIksV1+554QjuQj/Z56N830zZ3HcrbhmJ8=;
        b=DLVGbvraiL5TrVKunKFuol9iRinrKiG3jo3Wj1cP9/GFUvo/DyuFMl63JWzag1DiM9
         bhDnI3lEtwg0D9QNO5E8KDLncgYFqkmpTN5oEedoA4mjmwYmLEUzyl/Cex8tykyrou1C
         W2eHhd4AOsz1FF+pAoR7B5IZSuUlwPPSUWf8MXlRn7VSTOHyz9nwgsKdE1ew1LoPkn99
         ANQyocr2bFovoKerz7De+74ALNMEhaRvVYCNWA2fVEKrB55yGaq2B6Mhyef6/ajsyUgh
         fkjCrtMlEe55s5qOtky2+cC4j1XyQRfSPrlGf2JabBoBvEx5AX1T0DL3OuOnlsVliSx3
         x2WA==
X-Gm-Message-State: AJIora+PLvcEiOWrvWQKkPwMNcdPg61WQSgBvljqzPh1Nt0pIYZtItG+
        aYQhkLz/Q6F9IZ9oSPtWZ/lm
X-Google-Smtp-Source: AGRyM1tGTy3DTZXBtPorHiVELfYxch7JhUKQaVRjoVbPbNa5mkwRHMzp+8j0Hbq40sGlrc2K23ggvg==
X-Received: by 2002:a63:e446:0:b0:412:937b:5a3c with SMTP id i6-20020a63e446000000b00412937b5a3cmr6781523pgk.316.1657353735753;
        Sat, 09 Jul 2022 01:02:15 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902784300b001641b2d61d4sm770685pln.30.2022.07.09.01.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 01:02:15 -0700 (PDT)
Date:   Sat, 9 Jul 2022 13:32:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: PCI: qcom: Add SA8540P to binding
Message-ID: <20220709080203.GL5063@thinkpad>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-6-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629141000.18111-6-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 29, 2022 at 04:09:55PM +0200, Johan Hovold wrote:
> SA8540P is a new platform related to SC8280XP but which uses a single
> host interrupt for MSI routing.
> 

The newer chipsets are supposed to use 8 MSI's. How come this one uses only 1?

Thanks,
Mani

> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index a039f6110322..e9a7c8c783e7 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -25,6 +25,7 @@ properties:
>        - qcom,pcie-ipq4019
>        - qcom,pcie-ipq8074
>        - qcom,pcie-qcs404
> +      - qcom,pcie-sa8540p
>        - qcom,pcie-sc7280
>        - qcom,pcie-sc8180x
>        - qcom,pcie-sc8280xp
> @@ -603,6 +604,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,pcie-sa8540p
>                - qcom,pcie-sc8280xp
>      then:
>        properties:
> @@ -720,6 +722,7 @@ allOf:
>                - qcom,pcie-ipq8064
>                - qcom,pcie-ipq8064-v2
>                - qcom,pcie-ipq8074
> +              - qcom,pcie-sa8540p
>                - qcom,pcie-qcs404
>      then:
>        properties:
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
