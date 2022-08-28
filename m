Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1D55A3DFF
	for <lists+linux-pci@lfdr.de>; Sun, 28 Aug 2022 16:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiH1OVX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Aug 2022 10:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiH1OVW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Aug 2022 10:21:22 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9747D1928D;
        Sun, 28 Aug 2022 07:21:21 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 92-20020a9d0be5000000b0063946111607so4286226oth.10;
        Sun, 28 Aug 2022 07:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=rUI2VT6Iw56Sqt/jpeUDwdmczi3LF4N/g0TNbppEwFE=;
        b=7oOwWB3SUOblS9nAI16fGA1buWYXAbGzts4KR4i6+MhqT4ICRPjKVZ45eJiDHGZVC6
         DrtHOaFYxIlPqcQOfCR2kCAV/yuAjL8jtOfGgmJy9Ub0eieOaH56/ZnmsFvHIkm4drsx
         8D5PL5irdTqcUFfkmmim4pPafGe/qEDyqdTKuSlN2d71lIL3u4/VVLBn9Q7fbDb/L7F0
         W9zFTsUDKY0IqFlHXu/lYnSt0l5NUrJ8qhiADwH9NHKSHFpUo9SSJBKxkGB4031e+uPp
         Z+bQKJFJvPGAx4bkHFyffvEERoajH9AJolL5E77lIEaluFppoKekeL0zId2D014GZ9KW
         rpKA==
X-Gm-Message-State: ACgBeo3GUrA0RwGuOSsAZjxXeRdovSe/NIzzvS9spwAG9FIOw8eIgost
        USzQf3RK28YCyxv6Sh3Q06s8cnf2ug==
X-Google-Smtp-Source: AA6agR7okA3F1K7VqQ8PLpFXR4j/yALNpclI5ZXmCYf1ZdhmmniWSGI8/eCGeOVDocPZwgNu2G3VLg==
X-Received: by 2002:a9d:61d2:0:b0:639:31ca:87fe with SMTP id h18-20020a9d61d2000000b0063931ca87femr4782241otk.22.1661696480879;
        Sun, 28 Aug 2022 07:21:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q5-20020a4a88c5000000b0043540f7701esm3735892ooh.31.2022.08.28.07.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 07:21:19 -0700 (PDT)
Received: (nullmailer pid 3159704 invoked by uid 1000);
        Sun, 28 Aug 2022 14:21:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, kw@linux.com, bhelgaas@google.com,
        andersson@kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org
In-Reply-To: <20220826181923.251564-11-manivannan.sadhasivam@linaro.org>
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org> <20220826181923.251564-11-manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 10/11] dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC
Date:   Sun, 28 Aug 2022 09:21:16 -0500
Message-Id: <1661696476.862958.3159703.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 26 Aug 2022 23:49:22 +0530, Manivannan Sadhasivam wrote:
> Add devicetree bindings support for SM8450 SoC. Only the clocks are
> different on this platform, rest is same as SDX55.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml:15:5: [error] duplication of key "const" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dts'
Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml:15:5: found duplicate key "const" with value "qcom,sm8450-pcie-ep" (original value: "qcom,sdx55-pcie-ep")
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml:15:5: found duplicate key "const" with value "qcom,sm8450-pcie-ep" (original value: "qcom,sdx55-pcie-ep")
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml: ignoring, error parsing file
make: *** [Makefile:1420: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

