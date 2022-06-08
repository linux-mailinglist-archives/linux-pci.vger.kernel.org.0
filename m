Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6998543CAC
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 21:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiFHTTM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 15:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbiFHTTK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 15:19:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F00B579A;
        Wed,  8 Jun 2022 12:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 438E4B82A1A;
        Wed,  8 Jun 2022 19:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A67C3411C;
        Wed,  8 Jun 2022 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654715945;
        bh=7q+8rJaFoklx3cPK0a9WP62E8/RaEi9cg7l7NLWKwhM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Q6pmBeWs8lnn2vOVGZ1fjy+xpzpTU29yc+a7puv6oa/Y2x6P4pdsjwIa2f4yZorZS
         pb2bM3NVTy5AVSGllTsvNdyZuyFfUyl1VXCqpntqhzJLaDyFRYS7dJSzlTRf7g82Je
         bxqLO4/eZxYXZWpbRMuQ/zAWedHMrpgRjFks+f+TnrHZTG7FFzOBM40+a4hcBfZZYw
         J1VgL74jpjuTRPbQlwpcmfSIhZPm2pIgY9wBi5C5LABS8Zj0cp/C+1XEqJAgxEHAS/
         7TK2CaRDnCBxyS/ODID13AIMLmPko8H2UZbs2KVZYk28UA0UzkySoEcqQjIRiDif8k
         2DGWuBUZijkew==
Date:   Wed, 8 Jun 2022 14:19:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
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
Message-ID: <20220608191902.GA412670@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608145147.GA1376031-robh@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 08, 2022 at 08:51:47AM -0600, Rob Herring wrote:
> On Wed, Jun 08, 2022 at 07:45:07AM -0600, Rob Herring wrote:
> > On Wed, 08 Jun 2022 13:22:06 +0300, Dmitry Baryshkov wrote:
> > > On Qualcomm platforms each group of 32 MSI vectors is routed to the
> > > separate GIC interrupt. Document mapping of additional interrupts.
> > > 
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  .../devicetree/bindings/pci/qcom,pcie.yaml    | 53 +++++++++++++++++--
> > >  1 file changed, 50 insertions(+), 3 deletions(-)
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie.yaml: allOf:19:then:oneOf:0:properties:interrupt-names: {'maxItems': 1, 'items': [{'const': 'msi'}]} should not be valid under {'required': ['maxItems']}
> > 	hint: "maxItems" is not needed with an "items" list
> > 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie.yaml: allOf:19:then:oneOf:1:properties:interrupt-names: 'oneOf' conditional failed, one must be fixed:
> > 	[{'const': 'msi0'}, {'const': 'msi1'}, {'const': 'msi2'}, {'const': 'msi3'}, {'const': 'msi4'}, {'const': 'msi5'}, {'const': 'msi6'}, {'const': 'msi7'}] is too long
> > 	[{'const': 'msi0'}, {'const': 'msi1'}, {'const': 'msi2'}, {'const': 'msi3'}, {'const': 'msi4'}, {'const': 'msi5'}, {'const': 'msi6'}, {'const': 'msi7'}] is too short
> > 	False schema does not allow 8
> > 	1 was expected
> > 	8 is greater than the maximum of 2
> > 	8 is greater than the maximum of 3
> > 	8 is greater than the maximum of 4
> > 	8 is greater than the maximum of 5
> > 	8 is greater than the maximum of 6
> > 	8 is greater than the maximum of 7
> > 	hint: "minItems" is only needed if less than the "items" list length
> > 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/qcom,pcie.yaml: ignoring, error in schema: allOf: 19: then: oneOf: 0: properties: interrupt-names
> > Documentation/devicetree/bindings/pci/qcom,pcie.example.dtb:0:0: /example-0/pcie@1b500000: failed to match any schema with compatible: ['qcom,pcie-ipq8064']
> > Documentation/devicetree/bindings/pci/qcom,pcie.example.dtb:0:0: /example-1/pcie@fc520000: failed to match any schema with compatible: ['qcom,pcie-apq8084']
> 
> These are due to a new check in dtschema main branch not yet released.

Even though these are new checks, I guess we should fix them before
merging this series?  If not, let me know.

Bjorn
