Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0987656C7C2
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 09:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiGIHu3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 03:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGIHu1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 03:50:27 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436D23ED65
        for <linux-pci@vger.kernel.org>; Sat,  9 Jul 2022 00:50:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id l124so845173pfl.8
        for <linux-pci@vger.kernel.org>; Sat, 09 Jul 2022 00:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yMfpiE9grWAGWTOlyBH6CFYlcFupIx5Mf4UNkVo3g3Q=;
        b=Vlek+yevX1Ayy2RxpRcADiBJMyxptQdotOEAbiPPZlSpAuDRSHZQUbMGvXCdWvXcM6
         61fRPwhNDjGsOirYSsuV7Dh+tpcqvR2/1b46fZOVHspGx6FPFn1ByH6XL6N/O12pCtzl
         U29gdhuN3pZH91DyeHOq9+Zw7KZdK5m6dWo3Igt+THctHV8THGoiqDNb8pD2ynwJ+P5F
         dZglCk7lYAQCTOOnB45nj530SaW6tSlTFVQYlWNG1DmManJhx+UujqKKq/nDR5M29utH
         eRqGwYggXi5E8Gd1vLekFwYj/4kHuZpOJgCCWSF4RUta9HJuqX0ZMSxaj2L91aZaV+EG
         TQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yMfpiE9grWAGWTOlyBH6CFYlcFupIx5Mf4UNkVo3g3Q=;
        b=Ncyb/02E4dcxpRON7Tt+XqNXqL/FM3QW6l2EZnm/tYKLMsMY2bK/J6M9YRyL78JGPh
         sbyiDbs/iLmLKCZ2SWFC3WXmBgPArcWpi4ch/EpJPHaPbGi5L0ag+STfVsTcXdA3/n6T
         FfJHbju2U0/nD9dcdv7VbJ3+Rj2A6zy1B/W7lSClUWO+5f+P/tZTOcC20cLoOUD4yFRQ
         xYcOmIUpj49fpE9FkUSxyvA00OSHIRsKS8YoYaA8BVi5Y7Gid6A4MJ3UAeVcYPj8QLeR
         MqzZ8vNHHYoCmJzkkfhc4Yq5zvke8rDBXjbm/0DJ3TQOES8aLBUxPjdFvo72pRoOlUkT
         cYng==
X-Gm-Message-State: AJIora/unb2nUDME73CD1Q+MqBjyPQ8ewt8g5YSXQbDXSYIZ5FrigV7F
        3ngEkmdnIb8ncSI5w1KspsA1
X-Google-Smtp-Source: AGRyM1vPoOQg2mf4YJs9uorcFuSPAoAm6lnOZgF1aeZHQrjGq3y0Dt/z46mNPVnqVaaQrse1Jbe4Pg==
X-Received: by 2002:a63:de04:0:b0:412:b0b0:88a2 with SMTP id f4-20020a63de04000000b00412b0b088a2mr6474955pgg.585.1657353025697;
        Sat, 09 Jul 2022 00:50:25 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b0015e8d4eb2ddsm703844plx.295.2022.07.09.00.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 00:50:25 -0700 (PDT)
Date:   Sat, 9 Jul 2022 13:20:17 +0530
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
Subject: Re: [PATCH 02/10] dt-bindings: PCI: qcom: Fix msi-interrupt
 conditional
Message-ID: <20220709075017.GI5063@thinkpad>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629141000.18111-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 29, 2022 at 04:09:52PM +0200, Johan Hovold wrote:
> Fix the msi-interrupt conditional which always evaluated to false due to
> a misspelled property name ("compatibles" in plural).
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index ed9f9462a758..a1b4fc70e162 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -628,7 +628,7 @@ allOf:
>      # On older chipsets it's always 1 msi interrupt
>    - if:
>        properties:
> -        compatibles:
> +        compatible:
>            contains:
>              enum:
>                - qcom,pcie-msm8996
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
