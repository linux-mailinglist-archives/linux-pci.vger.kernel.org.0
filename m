Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397D76AC991
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 18:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCFRQI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 12:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjCFRQH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 12:16:07 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9283B5;
        Mon,  6 Mar 2023 09:15:27 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d7so11295362qtr.12;
        Mon, 06 Mar 2023 09:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678122808;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RsrrIzM0j0FRIx/53yOww37Xy9tl2yPouPmm4wECPj0=;
        b=5qwpPoNpOKot6TvBE3hkkC9m3qmj9CJSPKpjWYQ0QahSUEjtAphegOlWRwO3RmwN97
         HyGJVLIXSkjSLBE5yY+4O15Lh6OI8Zqw088kTPzX8RT945BXHAh6eyvduxQAoudxKE9e
         BDaOFYAksjJYweJ+8fr6t52oO4t/4iW8L8GT46YT9Od0gz6+UFMqonskqsxF77sm4cwc
         e7OL+LlQ6EbyOwAFZSwjyFEyMQghQ1StgxA3UAA244wlKoRVLUby3Xxr2CTexELpDOFr
         IMkKWhp6EG8u8uAzKJbw+vYBoZwHoxJ3lXzLwmYVDDfJRfmF3KuAUcIudjl1P+ul4uJL
         fXiQ==
X-Gm-Message-State: AO0yUKWky1kwU++Vj2C1dfVSdMiy/pH/5rSkBHOZtTdUCwLC5VPFp/Rt
        0Fa7Io7cawhdP9JmcGL8RGZvjXq8v7VU
X-Google-Smtp-Source: AK7set80EMN6nl7xz9iucMUCgSZOjRxVHMMG3Ss3AYHLRrOgawkk6PGGlxbecoJVBRoWNdguuot2Ug==
X-Received: by 2002:a05:622a:1042:b0:3bf:d1c6:d375 with SMTP id f2-20020a05622a104200b003bfd1c6d375mr21079816qte.36.1678122807720;
        Mon, 06 Mar 2023 09:13:27 -0800 (PST)
Received: from robh_at_kernel.org (adsl-72-50-3-187.prtc.net. [72.50.3.187])
        by smtp.gmail.com with ESMTPSA id m8-20020aed27c8000000b003bfc355c3a6sm7926318qtg.80.2023.03.06.09.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:13:27 -0800 (PST)
Received: (nullmailer pid 197991 invoked by uid 1000);
        Mon, 06 Mar 2023 17:13:23 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, lpieralisi@kernel.org,
        andersson@kernel.org, quic_srichara@quicinc.com,
        linux-pci@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kw@linux.com, linux-arm-msm@vger.kernel.org
In-Reply-To: <20230306153222.157667-14-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
 <20230306153222.157667-14-manivannan.sadhasivam@linaro.org>
Message-Id: <167812271142.181001.17686194952985575975.robh@kernel.org>
Subject: Re: [PATCH 13/19] dt-bindings: PCI: qcom-ep: Rename "mmio" region
 to "mhi"
Date:   Mon, 06 Mar 2023 11:13:23 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Mon, 06 Mar 2023 21:02:16 +0530, Manivannan Sadhasivam wrote:
> As per Qualcomm's internal documentation, the name of the region is "mhi"
> and not "mmio". So let's rename it to follow the convention.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230306153222.157667-14-manivannan.sadhasivam@linaro.org


pcie-ep@40000000: reg-names:5: 'mhi' was expected
	arch/arm/boot/dts/qcom-sdx55-mtp.dtb
	arch/arm/boot/dts/qcom-sdx55-t55.dtb
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dtb

pcie-ep@40000000: Unevaluated properties are not allowed ('reg-names' was unexpected)
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dtb

