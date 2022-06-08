Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E378543618
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 17:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243494AbiFHPKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 11:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243370AbiFHPKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 11:10:05 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AB444C75D;
        Wed,  8 Jun 2022 07:59:25 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id x75so12258024qkb.12;
        Wed, 08 Jun 2022 07:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rseWESTZZ3sgQEq2yMKxEjVoiFjpbE9ug4xL4+RqKlo=;
        b=3xVpbmC7Ka5BMTzY0NvT6MDQvqKO7f0Xgr8I/uQ4nbSxLt9boVBAr3VFRrrUAIQC1p
         o4lmSCNm824LheQbLcCaZPqqIOl5xtdbVGugNA9E/uv/u9yL12seBCJ3veGYSIMnDT52
         iwrNA0Q2+FuGBJ4yR1JPEVLv0VJMpior4RGNFuDSX+uhihUucXNzBedx2rr/j/hrjM7k
         +8l1vmI3Tk3MX6UIV+kH9UIuaaMfVRRdj7WtYPLMHgMEpxDAm/1QLhGjGoQTyw6l8Djc
         KlcmfhF5eStLghgJe4P5Hvl9umToigPB7vnaQprB/MPDhuLl/xF/hcbCSVjD2w8gH5Ye
         gkJg==
X-Gm-Message-State: AOAM532qceeZgPBvige0jQnfsNWAbYw+oR9pVno8UWLgU+IjY0Ua4JWu
        XCEJi70FxzTvM3HpAYsBpImxzBadeA==
X-Google-Smtp-Source: ABdhPJyeZH8Mdu5d3tBwNWSsnW8byi52kRMGjV6KjaZws4sh3j01ytqRp7F3bh9M+1q7Ggx+kcJsrA==
X-Received: by 2002:a05:6638:1c19:b0:331:d0b7:4cfe with SMTP id ca25-20020a0566381c1900b00331d0b74cfemr4628587jab.311.1654699909700;
        Wed, 08 Jun 2022 07:51:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t25-20020a02ab99000000b00331c1e117absm2660205jan.29.2022.06.08.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:51:49 -0700 (PDT)
Received: (nullmailer pid 1378913 invoked by uid 1000);
        Wed, 08 Jun 2022 14:51:47 -0000
Date:   Wed, 8 Jun 2022 08:51:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
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
Subject: Re: [PATCH v14 5/7] dt-bindings: PCI: qcom: Support additional MSI
 interrupts
Message-ID: <20220608145147.GA1376031-robh@kernel.org>
References: <20220608102208.2967438-1-dmitry.baryshkov@linaro.org>
 <20220608102208.2967438-6-dmitry.baryshkov@linaro.org>
 <1654695907.391751.1272089.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654695907.391751.1272089.nullmailer@robh.at.kernel.org>
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

On Wed, Jun 08, 2022 at 07:45:07AM -0600, Rob Herring wrote:
> On Wed, 08 Jun 2022 13:22:06 +0300, Dmitry Baryshkov wrote:
> > On Qualcomm platforms each group of 32 MSI vectors is routed to the
> > separate GIC interrupt. Document mapping of additional interrupts.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../devicetree/bindings/pci/qcom,pcie.yaml    | 53 +++++++++++++++++--
> >  1 file changed, 50 insertions(+), 3 deletions(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie.yaml: allOf:19:then:oneOf:0:properties:interrupt-names: {'maxItems': 1, 'items': [{'const': 'msi'}]} should not be valid under {'required': ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie.yaml: allOf:19:then:oneOf:1:properties:interrupt-names: 'oneOf' conditional failed, one must be fixed:
> 	[{'const': 'msi0'}, {'const': 'msi1'}, {'const': 'msi2'}, {'const': 'msi3'}, {'const': 'msi4'}, {'const': 'msi5'}, {'const': 'msi6'}, {'const': 'msi7'}] is too long
> 	[{'const': 'msi0'}, {'const': 'msi1'}, {'const': 'msi2'}, {'const': 'msi3'}, {'const': 'msi4'}, {'const': 'msi5'}, {'const': 'msi6'}, {'const': 'msi7'}] is too short
> 	False schema does not allow 8
> 	1 was expected
> 	8 is greater than the maximum of 2
> 	8 is greater than the maximum of 3
> 	8 is greater than the maximum of 4
> 	8 is greater than the maximum of 5
> 	8 is greater than the maximum of 6
> 	8 is greater than the maximum of 7
> 	hint: "minItems" is only needed if less than the "items" list length
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie.yaml: ignoring, error in schema: allOf: 19: then: oneOf: 0: properties: interrupt-names
> Documentation/devicetree/bindings/pci/qcom,pcie.example.dtb:0:0: /example-0/pcie@1b500000: failed to match any schema with compatible: ['qcom,pcie-ipq8064']
> Documentation/devicetree/bindings/pci/qcom,pcie.example.dtb:0:0: /example-1/pcie@fc520000: failed to match any schema with compatible: ['qcom,pcie-apq8084']

These are due to a new check in dtschema main branch not yet released.

Rob
