Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30A25136FC
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 16:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348478AbiD1Oi3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 10:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348459AbiD1Oi2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 10:38:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6424C25C49;
        Thu, 28 Apr 2022 07:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44F7C61E58;
        Thu, 28 Apr 2022 14:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79351C385AA;
        Thu, 28 Apr 2022 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651156510;
        bh=N0XcSvKTdsYeY2zjrrNVUSFn2kZQ+Q3KoGNVA2J+bbI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=er1heUVHB1A4I6fS13L3S6mNL/aj31xo+DhclBi2OD2p68LjADhKFMedUwldKMaPl
         Mxp5CjmEb939XhsXsg7CuNHT1cVBMDGNFSaGfXLgi7xovLdlrGKL3aAIPsg2OR77pp
         yDxXdYTf9CnqBEP51uHyziBuD453Jbfl/v6Wj39vFx/4LrxU3tt36Z1t7aZH3wnMKY
         Ad4iXhZROvtqF6e5yffIqbewILhzwH94fqhLqCRLEaWhfFL2OwrtaSdo0ZIR+j/Gtq
         KnWhOVKMCpiU/qcKIN/sxb4A3CmQBEWrgjLW/za8CNm1nHr3t6Uo+9gNZpoCHIooiw
         n6Eam3qHjz6XQ==
Date:   Thu, 28 Apr 2022 09:35:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 2/8] dt-bindings: pci/qcom,pcie: resets are not
 defined for msm8996
Message-ID: <20220428143508.GA12269@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428114113.3411536-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unlike the other patches in this series, this subject line mentions a
problem (actually, I don't even know whether it's a *problem* or just
a statement of fact), but doesn't say what this patch does.

Based on the patch, I guess this does something like:

  Require resets except for MSM8996/APQ8096

I don't know whether you're changing the prefix convention for this
file, or just didn't look to see how it was done in the past, but it's
nice to have some consistency:

  $ git log --oneline Documentation/devicetree/bindings/pci/qcom,pcie.txt
  f52d2a0f0d32 dt-bindings: pci: qcom: Document PCIe bindings for SM8150 SoC
  dddb4efa5192 dt-bindings: pci: qcom: Document PCIe bindings for SM8450
  45a3ec891370 PCI: qcom: Add sc8180x compatible
  320e10986ef7 dt-bindings: PCI: update references to Designware schema
  9f7368ff1210 dt-bindings: pci: qcom: Document PCIe bindings for IPQ6018 SoC
  c9f04600026f dt-bindings: PCI: qcom: Document ddrss_sf_tbu clock for sm8250
  458168247ccc dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
  d511580ea9c2 dt-bindings: PCI: qcom: Add ipq8064 rev 2 variant
  b11b8cc161de dt-bindings: PCI: qcom: Add ext reset
  736ae5c91712 dt-bindings: PCI: qcom: Add missing clks
  5d28bee7c91e dt-bindings: PCI: qcom: Add support for SDM845 PCIe
  29a50257a9d6 dt-bindings: PCI: qcom: Add QCS404 to the binding
  f625b1ade245 PCI: qcom: Add missing supplies required for msm8996
  8baf0151cd4b dt-bindings: PCI: qcom: Add support for IPQ8074
  90d52d57ccac PCI: qcom: Add support for IPQ4019 PCIe controller
  d0491fc39bdd PCI: qcom: Add support for MSM8996 PCIe controller
  845d5ca26647 PCI: qcom: Document PCIe devicetree bindings

Including both "pci" and "pcie" in the prefix seems like overkill.

On Thu, Apr 28, 2022 at 02:41:07PM +0300, Dmitry Baryshkov wrote:
> On MSM8996/APQ8096 platforms the PCIe controller doesn't have any
> resets. So move the requirement stance under the corresponding if
> condition.

s/stance/stanza/

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 16f765e96128..ce4f53cdaba0 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -114,8 +114,6 @@ required:
>    - interrupt-map
>    - clocks
>    - clock-names
> -  - resets
> -  - reset-names
>  
>  allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
> @@ -504,6 +502,18 @@ allOf:
>        required:
>          - power-domains
>  
> +  - if:
> +      not:
> +        properties:
> +          compatibles:
> +            contains:
> +              enum:
> +                - qcom,pcie-msm8996
> +    then:
> +      required:
> +        - resets
> +        - reset-names
> +
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.35.1
> 
