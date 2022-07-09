Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB356C7BE
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 09:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiGIHtx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 03:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIHtw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 03:49:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6CB3ED55
        for <linux-pci@vger.kernel.org>; Sat,  9 Jul 2022 00:49:51 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r22so756925pgr.2
        for <linux-pci@vger.kernel.org>; Sat, 09 Jul 2022 00:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wXEuGgRi51l2syvM4ARsgEPhDOGnzDNF9DFPgJcZZnk=;
        b=a5m3CwIAb+1euRmCus/AnvTYW9zYm8zhUR9XWNn0eliatK6fhAYMoSpvcUw06GHZEG
         5Li3wTgGKrGOnv5t6SbO754aeeE6lqWG7YmNPcAH4SAMuN+s65iKWp1UJE6kxYiHvkb7
         v2ovx1Yu9OSiSF8G9o3mZlqKc8kdlr0gUKEvSRiKKEp7shA3ypumiZQaJEBoMG5iciKp
         TS1lMch+xeAhuPA9ox8M3r7Xc9gBqgu5JvXYl42R+HolvmOhyv70Zh+EKV2U2Z9EoJm3
         km4hzLbf7JUqD7iGEqNxuNbu5zIM6gNLOppaOhiEo79vo8diBNxs0k0G4cMY7yllLsBW
         R/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wXEuGgRi51l2syvM4ARsgEPhDOGnzDNF9DFPgJcZZnk=;
        b=Ixf93SfIHGCwsiJVbFXwXOw+v5n7GIEd20terEVNrqhiHHx0Qm77Fqs/9X860eEuGw
         IQBymNnzCK4tV8c+fEXssPEcVBG+PnpUK1frXVIpDio37OCYTSdFZBTik+oEeKCdiLkx
         I/VftMcEs7XkqRoVoZprgqs+yHQZdDOuBhVV7B+AaUQ7nHItT6n4g3pAT+PRTczDHBfE
         Q8VZICCSsJaIX/ZYbJmnypPdPmTvjn9NI0p7htmQ5gbAMzqdj8dnRxWxUumepjz1D7xl
         +HnulWsiHjMKKvFEPDn7eStUATlgqLtPWWQMRMODaXWyMf5op9DcLJJylaiWOwttWZvo
         xcZQ==
X-Gm-Message-State: AJIora+WD8fsL0JsFssnW/Hm2+4wVaWjAG2gzpEEfY8GhWL125LglCBl
        R45n0CESfQTTbNIInsXrjzGh
X-Google-Smtp-Source: AGRyM1tq4rokl+r1RApjoxd1FVwBBLzf85OQrAlOwVbv1zM5WeR09TN/Z3OMCzYIIVRuGiAV5E2XCw==
X-Received: by 2002:a63:6b49:0:b0:40e:64ef:1be7 with SMTP id g70-20020a636b49000000b0040e64ef1be7mr6731591pgc.552.1657352991109;
        Sat, 09 Jul 2022 00:49:51 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id z24-20020aa79498000000b0052542cbff9dsm868514pfk.99.2022.07.09.00.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 00:49:50 -0700 (PDT)
Date:   Sat, 9 Jul 2022 13:19:38 +0530
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
Subject: Re: [PATCH 01/10] dt-bindings: PCI: qcom: Fix reset conditional
Message-ID: <20220709074938.GH5063@thinkpad>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629141000.18111-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 29, 2022 at 04:09:51PM +0200, Johan Hovold wrote:
> Fix the reset conditional which always evaluated to true due to a
> misspelled property name ("compatibles" in plural).
> 
> Fixes: 6700a9b00f0a ("dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 7e84063afe25..ed9f9462a758 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -615,7 +615,7 @@ allOf:
>    - if:
>        not:
>          properties:
> -          compatibles:
> +          compatible:
>              contains:
>                enum:
>                  - qcom,pcie-msm8996
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
