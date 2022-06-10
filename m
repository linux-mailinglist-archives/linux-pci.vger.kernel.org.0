Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A58546A89
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 18:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344108AbiFJQgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 12:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243076AbiFJQfc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 12:35:32 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF80580D1;
        Fri, 10 Jun 2022 09:35:18 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id v7so21326674ilo.3;
        Fri, 10 Jun 2022 09:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6WiSMsOLySqA1zzWLpUGSSiDSpEDDT1e44SuNKCC/8M=;
        b=1xvoI7o/8AGGqymYgMapMOgu94b5VV6MDYhMn6rbNGKaz9iMie99s2EgXXXt/icYop
         RiIDI25K2DjOn92nlJujOy2tns92VXtypDeLPqSmxDx+493LbMNMPCDyJrVq5j+puo1n
         A8joNT74PwSVqYFoDxke1UL4sbIvvglkkcc1ii8GIwekE9hc1RvY9CIsFOMyZ5WusckQ
         SRf5AQ9u22Ulq7X0viowwfsx5WPpe0BLKp+N2dDstV7pVvYgyX/ATP1BRfuD/1TYa4B7
         8P5pL6TgrZXloyGTvPyHKLPjSNaEq9lfCyBicgT961/47/+nlRyeSZRDcXiEBd1iIzrB
         ztYg==
X-Gm-Message-State: AOAM53067dRev+rtwBcF9XTWTyAdAVG9q5voOyGHYDHGdJ1Fn+x4YR45
        nfBdAiDAG7MKlQhmo14arA==
X-Google-Smtp-Source: ABdhPJx9rCJEJhQwUrgcsOX0fAI+l7nqTtEvtRxIZd8vvwiYijCY+LcYDEBpEPbyrQHdQZX/z8qz3w==
X-Received: by 2002:a92:c568:0:b0:2d3:da8d:76cc with SMTP id b8-20020a92c568000000b002d3da8d76ccmr24976216ilj.161.1654878917583;
        Fri, 10 Jun 2022 09:35:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id j12-20020a02630c000000b0033074471f78sm10882934jac.101.2022.06.10.09.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 09:35:17 -0700 (PDT)
Received: (nullmailer pid 1796678 invoked by uid 1000);
        Fri, 10 Jun 2022 16:35:14 -0000
Date:   Fri, 10 Jun 2022 10:35:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
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
Message-ID: <20220610163514.GB1787330-robh@kernel.org>
References: <20220608145147.GA1376031-robh@kernel.org>
 <20220608191902.GA412670@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608191902.GA412670@bhelgaas>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 08, 2022 at 02:19:02PM -0500, Bjorn Helgaas wrote:
> On Wed, Jun 08, 2022 at 08:51:47AM -0600, Rob Herring wrote:
> > On Wed, Jun 08, 2022 at 07:45:07AM -0600, Rob Herring wrote:
> > > On Wed, 08 Jun 2022 13:22:06 +0300, Dmitry Baryshkov wrote:
> > > > On Qualcomm platforms each group of 32 MSI vectors is routed to the
> > > > separate GIC interrupt. Document mapping of additional interrupts.
> > > > 
> > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > >  .../devicetree/bindings/pci/qcom,pcie.yaml    | 53 +++++++++++++++++--
> > > >  1 file changed, 50 insertions(+), 3 deletions(-)
> > > > 
> > > 
> > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > > 
> > > yamllint warnings/errors:
> > > 
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie.yaml: allOf:19:then:oneOf:0:properties:interrupt-names: {'maxItems': 1, 'items': [{'const': 'msi'}]} should not be valid under {'required': ['maxItems']}
> > > 	hint: "maxItems" is not needed with an "items" list
> > > 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie.yaml: allOf:19:then:oneOf:1:properties:interrupt-names: 'oneOf' conditional failed, one must be fixed:
> > > 	[{'const': 'msi0'}, {'const': 'msi1'}, {'const': 'msi2'}, {'const': 'msi3'}, {'const': 'msi4'}, {'const': 'msi5'}, {'const': 'msi6'}, {'const': 'msi7'}] is too long
> > > 	[{'const': 'msi0'}, {'const': 'msi1'}, {'const': 'msi2'}, {'const': 'msi3'}, {'const': 'msi4'}, {'const': 'msi5'}, {'const': 'msi6'}, {'const': 'msi7'}] is too short
> > > 	False schema does not allow 8
> > > 	1 was expected
> > > 	8 is greater than the maximum of 2
> > > 	8 is greater than the maximum of 3
> > > 	8 is greater than the maximum of 4
> > > 	8 is greater than the maximum of 5
> > > 	8 is greater than the maximum of 6
> > > 	8 is greater than the maximum of 7
> > > 	hint: "minItems" is only needed if less than the "items" list length
> > > 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie.yaml: ignoring, error in schema: allOf: 19: then: oneOf: 0: properties: interrupt-names
> > > Documentation/devicetree/bindings/pci/qcom,pcie.example.dtb:0:0: /example-0/pcie@1b500000: failed to match any schema with compatible: ['qcom,pcie-ipq8064']
> > > Documentation/devicetree/bindings/pci/qcom,pcie.example.dtb:0:0: /example-1/pcie@fc520000: failed to match any schema with compatible: ['qcom,pcie-apq8084']
> > 
> > These are due to a new check in dtschema main branch not yet released.
> 
> Even though these are new checks, I guess we should fix them before
> merging this series?  If not, let me know.

Yes, or it is more wack-a-mole for me.

Rob
