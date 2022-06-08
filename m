Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB3A5431CD
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 15:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbiFHNpc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 09:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240801AbiFHNpZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 09:45:25 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB0726E90E;
        Wed,  8 Jun 2022 06:45:23 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id f7so16573847ilr.5;
        Wed, 08 Jun 2022 06:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=8s0YrfWn9fhADGPEGf3nKU4A+tmSBSkKOwYBtdSyIws=;
        b=VvZmwoj1LsXC9IsSWEEaBFminavVqxSGP2tt5Wnp7K9ephaEDyZS9l3uXC/uLm1fW0
         uJirx2AaRDqp1QFzaVHUfrAESH08hQUYgLcBodwt8smhZO4cjdePT3gVb7fUMby0N9fK
         +M7chUHSYmB4q1e33ZjT/4BHMEu9IFKbhdPkdx3BfsnWuWPTn8LWVJX3f4rQmiOmN2Jw
         F2mn5jC2YlzE5bQxwthUlWaNXY69oEP5lyZJfRjXRWbTdEGQRMABsow1/zBQ2r5PaNrR
         6N7nyXrRVJFvqgzHgSbFJNdWWGtaY8J95njJGMAULNqK23QASNnv1OBdD2z/LqtNkrGt
         jJKQ==
X-Gm-Message-State: AOAM531M1Y2V6lB1dkWGkViKhZh+gj6JVQLekm3lILfOcU0ss2Jzitef
        2lM2t+zNceX8gilDIC7I1Q==
X-Google-Smtp-Source: ABdhPJz7Q8MLtTkPwji36IpKE2im28oPmR3QxFQufPLcocka4qU8MkFuhTbPDygOZ9plX+RHb35PPQ==
X-Received: by 2002:a92:ca4d:0:b0:2d3:dce1:1ee1 with SMTP id q13-20020a92ca4d000000b002d3dce11ee1mr19266018ilo.301.1654695923518;
        Wed, 08 Jun 2022 06:45:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p5-20020a056e02144500b002d392d98afdsm8971338ilo.9.2022.06.08.06.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 06:45:23 -0700 (PDT)
Received: (nullmailer pid 1272090 invoked by uid 1000);
        Wed, 08 Jun 2022 13:45:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andy Gross <agross@kernel.org>
In-Reply-To: <20220608102208.2967438-6-dmitry.baryshkov@linaro.org>
References: <20220608102208.2967438-1-dmitry.baryshkov@linaro.org> <20220608102208.2967438-6-dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v14 5/7] dt-bindings: PCI: qcom: Support additional MSI interrupts
Date:   Wed, 08 Jun 2022 07:45:07 -0600
Message-Id: <1654695907.391751.1272089.nullmailer@robh.at.kernel.org>
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

On Wed, 08 Jun 2022 13:22:06 +0300, Dmitry Baryshkov wrote:
> On Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Document mapping of additional interrupts.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 53 +++++++++++++++++--
>  1 file changed, 50 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie.yaml: allOf:19:then:oneOf:0:properties:interrupt-names: {'maxItems': 1, 'items': [{'const': 'msi'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie.yaml: allOf:19:then:oneOf:1:properties:interrupt-names: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'msi0'}, {'const': 'msi1'}, {'const': 'msi2'}, {'const': 'msi3'}, {'const': 'msi4'}, {'const': 'msi5'}, {'const': 'msi6'}, {'const': 'msi7'}] is too long
	[{'const': 'msi0'}, {'const': 'msi1'}, {'const': 'msi2'}, {'const': 'msi3'}, {'const': 'msi4'}, {'const': 'msi5'}, {'const': 'msi6'}, {'const': 'msi7'}] is too short
	False schema does not allow 8
	1 was expected
	8 is greater than the maximum of 2
	8 is greater than the maximum of 3
	8 is greater than the maximum of 4
	8 is greater than the maximum of 5
	8 is greater than the maximum of 6
	8 is greater than the maximum of 7
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie.yaml: ignoring, error in schema: allOf: 19: then: oneOf: 0: properties: interrupt-names
Documentation/devicetree/bindings/pci/qcom,pcie.example.dtb:0:0: /example-0/pcie@1b500000: failed to match any schema with compatible: ['qcom,pcie-ipq8064']
Documentation/devicetree/bindings/pci/qcom,pcie.example.dtb:0:0: /example-1/pcie@fc520000: failed to match any schema with compatible: ['qcom,pcie-apq8084']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

