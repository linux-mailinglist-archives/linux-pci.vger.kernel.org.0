Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD795B471C
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 16:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiIJOyN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 10:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiIJOyE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 10:54:04 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011364457C;
        Sat, 10 Sep 2022 07:54:01 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-11e9a7135easo11480343fac.6;
        Sat, 10 Sep 2022 07:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ifo6TqrA2757G8HR38HLney0ZLAz01R6aY9dPCdXl3Y=;
        b=k0oVd3dbSdyuqmjUmykogS9H32fNgp02tCg8uSK/Pm7zpEhuzUMoD0BMQUXkyF3Oxk
         racPEyEATactf+oomg5iqQffKDRI186EqjQ4t+j41XyRe8gF5858VpOD6I7MMlaHWBBr
         7Wz1DPA7S0PFNsXDu8TXc6IdJ98SDtd2yA5T5hOuQsZLTFBTyRSIZg2khzYz4mEy21LV
         +mcmtQump+NLXvO1KA5q+1iz7VkS5/4bmVuQpcla8FbeqZBIL6u+BbAAJmRlYFjfDDJw
         WUZsaZWss8Nq6hB15mE+XqmIzXJfxU5PdFwFQFsDhJJ5UU8UVG+w6f9BJe6LVXSdYlCA
         MBwg==
X-Gm-Message-State: ACgBeo0mKW5dIy1VeNfFUb1rXbuxejim0+EJbhZm3Pr4qjNzgi67TLri
        3cvPDpkaprGpBSJueYKIwA==
X-Google-Smtp-Source: AA6agR6hmwMiw/lR9B81JNdMbO+Ia+MDJeL8CcqEriha2MtNkYuBKBnxij76O3KxYU3E3dSWcCANaw==
X-Received: by 2002:a05:6808:e8e:b0:34d:7829:135 with SMTP id k14-20020a0568080e8e00b0034d78290135mr5211741oil.252.1662821640212;
        Sat, 10 Sep 2022 07:54:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b9-20020a4aba09000000b0044b125e5dabsm1292104oop.35.2022.09.10.07.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 07:53:59 -0700 (PDT)
Received: (nullmailer pid 34703 invoked by uid 1000);
        Sat, 10 Sep 2022 14:53:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lpieralisi@kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        dmitry.baryshkov@linaro.org, kw@linux.com
In-Reply-To: <20220910063045.16648-12-manivannan.sadhasivam@linaro.org>
References: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org> <20220910063045.16648-12-manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 11/12] dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC
Date:   Sat, 10 Sep 2022 09:53:55 -0500
Message-Id: <1662821635.191877.34702.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 10 Sep 2022 12:00:44 +0530, Manivannan Sadhasivam wrote:
> Add devicetree bindings support for SM8450 SoC. Only the clocks are
> different on this platform, rest is same as SDX55.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 39 +++++++++++++++++--
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


pcie-ep@40000000: qcom,perst-regs:0: [27] is too short
	arch/arm/boot/dts/qcom-sdx55-mtp.dtb

pcie-ep@40000000: qcom,perst-regs:0: [28] is too short
	arch/arm/boot/dts/qcom-sdx55-t55.dtb
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dtb

pcie-ep@40000000: Unevaluated properties are not allowed ('qcom,perst-regs' was unexpected)
	arch/arm/boot/dts/qcom-sdx55-mtp.dtb
	arch/arm/boot/dts/qcom-sdx55-t55.dtb
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dtb

