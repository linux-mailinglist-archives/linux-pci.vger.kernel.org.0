Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57A95A7C4C
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 13:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiHaLjY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 07:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaLjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 07:39:24 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623B0A7A8C;
        Wed, 31 Aug 2022 04:39:23 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11f0fa892aeso15143517fac.7;
        Wed, 31 Aug 2022 04:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Z1f87H1PJFe4akLNOjaLrcNqXkR7W1AVw321QPPsh6A=;
        b=tQeX7rtCJW6cZ1wluNaEfOJRKQcW/eyLxA455LQ/XJzttkx3kVSnOV8aWzLpoOWdsT
         Yoe4pzNd2Vi5jXt1XrY8s5FsArwSoqA0DhBbAmXvNTYbpqmspmx5if7NcsLf10NGj2JS
         RtfPJor8TJ3Z+jVqLs1bYLXUdCbbhGWEv42eIiI/Zl9+6SSCvtqNYEzegy1iCCGQV/Y8
         mawO5+LxTQUCkjzjbrLaX+pWryIsQCbZN66Ioq9fIRKBfBYMp2oHBk2VMArmSdPi+O0l
         P96NWEXWRl38/nGhACZFF87B1pZRRWvywXg/2QUIJWepVWWRGdy/iPU9J+/gr0R6xrxo
         u7Lw==
X-Gm-Message-State: ACgBeo1siT7Mni2T76/PkzD3rduA0beH/B7n3X4YRZIB8qdQIBXk0B7a
        HP1MpcykPErDkZzn68bPJH7nfuKi7g==
X-Google-Smtp-Source: AA6agR7w54goHzQ8TCm0mSRb3zB+M43ANVNtzpbzFy5mh2e30F1Rhzycat7svTyJqT4E0HA7xPapVA==
X-Received: by 2002:a54:4899:0:b0:343:3f7c:713d with SMTP id r25-20020a544899000000b003433f7c713dmr987350oic.116.1661945962690;
        Wed, 31 Aug 2022 04:39:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h7-20020a9d2f07000000b0063736db0ae9sm6463845otb.15.2022.08.31.04.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 04:39:22 -0700 (PDT)
Received: (nullmailer pid 3614526 invoked by uid 1000);
        Wed, 31 Aug 2022 11:39:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kw@linux.com, andersson@kernel.org, linux-kernel@vger.kernel.org,
        lpieralisi@kernel.org, dmitry.baryshkov@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, linux-pci@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        bhelgaas@google.com
In-Reply-To: <20220830165817.183571-10-manivannan.sadhasivam@linaro.org>
References: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org> <20220830165817.183571-10-manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 09/11] dt-bindings: PCI: qcom-ep: Define clocks per platform
Date:   Wed, 31 Aug 2022 06:39:21 -0500
Message-Id: <1661945961.468486.3614525.nullmailer@robh.at.kernel.org>
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

On Tue, 30 Aug 2022 22:28:15 +0530, Manivannan Sadhasivam wrote:
> In preparation of adding the bindings for future SoCs, let's define the
> clocks per platform.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 51 ++++++++++++-------
>  1 file changed, 32 insertions(+), 19 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml: allOf:1:then:properties:clocks: {'maxItems': 7, 'items': [{'description': 'PCIe Auxiliary clock'}, {'description': 'PCIe CFG AHB clock'}, {'description': 'PCIe Master AXI clock'}, {'description': 'PCIe Slave AXI clock'}, {'description': 'PCIe Slave Q2A AXI clock'}, {'description': 'PCIe Sleep clock'}, {'description': 'PCIe Reference clock'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml: ignoring, error in schema: allOf: 1: then: properties: clocks
Documentation/devicetree/bindings/pci/qcom,pcie-ep.example.dtb:0:0: /example-0/pcie-ep@40000000: failed to match any schema with compatible: ['qcom,sdx55-pcie-ep']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

