Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE936AC995
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 18:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjCFRQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 12:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCFRQh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 12:16:37 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCE827D53;
        Mon,  6 Mar 2023 09:16:13 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id nf5so7104060qvb.5;
        Mon, 06 Mar 2023 09:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678122806;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+bLdlPkAM7xv+jzPUTz78iNnMt7Nmi2WO7mB0hfQVa0=;
        b=DTzpG8j7UDS1AACXzvwiWATzkRyoZDbsdzvfIyc0X1FyHpPcs0epkP8RLO+r4BN97p
         VqGyIMnwg5vm0kicssiR2gJCan9A/QAxM8IQ2/1hOIdRPwa7LThEHrvxW3/3qpzuNOSN
         vuPr8b3+THTWKQyK/u4vwM1rKSN0B3WBdVRRZ7YsyT4oiSJbh4aWaOGMMagetq5WWIiN
         eReJEVrfOWYOIpbqEzPzni+5DubKQNt0fKw398UzohlvjWFpX17TSOyhEI+upfkY91vq
         kVjGDt2QfvrVgO3bNIg1DYwcTClWmSTyC7PxXoKo+o4cGLAb/JnTJjVpNZea91zvPPG/
         Al9Q==
X-Gm-Message-State: AO0yUKU+a9dAPrQinEQx9rJfBJ0uIbtN3bO3S3tmlx2y7asFbJmPRRuG
        8pm5xQADZ57vGustO5lgJChf6ZnupXoN
X-Google-Smtp-Source: AK7set+n3z+Cmz26lZdjyATRzB6SM0aW1T+cCpCgQB6/nTfwbWaHGtMvxBXH03hZ+lgyf7YXpLORPg==
X-Received: by 2002:a05:6214:2424:b0:56e:9da4:831c with SMTP id gy4-20020a056214242400b0056e9da4831cmr21362209qvb.46.1678122805633;
        Mon, 06 Mar 2023 09:13:25 -0800 (PST)
Received: from robh_at_kernel.org (adsl-72-50-0-7.prtc.net. [72.50.0.7])
        by smtp.gmail.com with ESMTPSA id 69-20020a370548000000b007426f115a4esm7840609qkf.129.2023.03.06.09.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:13:25 -0800 (PST)
Received: (nullmailer pid 197984 invoked by uid 1000);
        Mon, 06 Mar 2023 17:13:23 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        kw@linux.com, lpieralisi@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, linux-pci@vger.kernel.org,
        quic_srichara@quicinc.com, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org
In-Reply-To: <20230306153222.157667-16-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
 <20230306153222.157667-16-manivannan.sadhasivam@linaro.org>
Message-Id: <167812270103.178940.8497593560794226489.robh@kernel.org>
Subject: Re: [PATCH 15/19] dt-bindings: PCI: qcom: Add "mhi" register
 region to supported SoCs
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


On Mon, 06 Mar 2023 21:02:18 +0530, Manivannan Sadhasivam wrote:
> "mhi" register region contains the MHI registers that could be used by
> the PCIe controller drivers to get debug information like PCIe link
> transition counts on newer SoCs.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie.example.dtb: pcie@fc520000: reg-names:1: 'mhi' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie.example.dtb: pcie@fc520000: reg-names:2: 'dbi' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie.example.dtb: pcie@fc520000: reg-names:3: 'elbi' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/qcom,pcie.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230306153222.157667-16-manivannan.sadhasivam@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

