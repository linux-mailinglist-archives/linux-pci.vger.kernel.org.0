Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A6462C110
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 15:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiKPOiv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 09:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiKPOis (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 09:38:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB222700;
        Wed, 16 Nov 2022 06:38:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1494061E58;
        Wed, 16 Nov 2022 14:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6889AC433D6;
        Wed, 16 Nov 2022 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668609526;
        bh=806tl/QndXB0wVKw4pYwW3gzI2QMaLxTZtaoVS0cosA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRKZe6t5Tl59Bj/6LffUgj7hg2bKlst+S86PFiuyf4p9OCBjHCrThV4pfcv3nopmC
         Ts2Zia1Vz8tyhaXCDwb4pBVq5Kr2N2klT828gGofk4U0zeqWnLIv4g6k0xY6rqRnuj
         LJMKqmH49Yrwq0nBKQx3Ys9yJsigq2J7mtxKHLae66199UcR8jqTyHeHaPU08IifDc
         byyRANpOQ8lUYpzjFzEUI1KGVqcx/obpz0euSuGbblmSvgMW57DcrT1J2b24ROVCZ1
         O3rGHKX2t8NxNZ0X6Yfy5xlo04/tT4ca36MelOfxXe8t9lIY+lyC0pdz64Rh+FA0qs
         CGGV108LapqMw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovJYO-0003GW-1t; Wed, 16 Nov 2022 15:38:16 +0100
Date:   Wed, 16 Nov 2022 15:38:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: PCI: qcom: Add sm8350 to bindings
Message-ID: <Y3T12JK1CHELFQHY@hovoldconsulting.com>
References: <20221110183158.856242-1-dmitry.baryshkov@linaro.org>
 <20221110183158.856242-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110183158.856242-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 10, 2022 at 09:31:51PM +0300, Dmitry Baryshkov wrote:
> Add bindings for two PCIe hosts on SM8350 platform. The only difference
> between them is in the aggre0 clock, which warrants the oneOf clause for
> the clocks properties.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 54f07852d279..502c15f7dd96 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -32,6 +32,7 @@ properties:
>        - qcom,pcie-sdm845
>        - qcom,pcie-sm8150
>        - qcom,pcie-sm8250
> +      - qcom,pcie-sm8350
>        - qcom,pcie-sm8450-pcie0
>        - qcom,pcie-sm8450-pcie1
>        - qcom,pcie-ipq6018
> @@ -185,6 +186,7 @@ allOf:
>                - qcom,pcie-sc8180x
>                - qcom,pcie-sc8280xp
>                - qcom,pcie-sm8250
> +              - qcom,pcie-sm8350
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
>      then:
> @@ -540,6 +542,49 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sm8350
> +    then:
> +      oneOf:
> +          # Unfortunately the "optional" aggre0 clock is used in the middle of the list

As Krzysztof mentioned, you can just move it last (and the driver will
still enable aggre0 before aggre1 if that's a concern).

> +        - properties:
> +            clocks:
> +              maxItems: 9
> +            clock-names:
> +              items:
> +                - const: aux # Auxiliary clock
> +                - const: cfg # Configuration clock
> +                - const: bus_master # Master AXI clock
> +                - const: bus_slave # Slave AXI clock
> +                - const: slave_q2a # Slave Q2A clock
> +                - const: tbu # PCIe TBU clock
> +                - const: ddrss_sf_tbu # PCIe SF TBU clock
> +                - const: aggre0 # Aggre NoC PCIe0 AXI clock
> +                - const: aggre1 # Aggre NoC PCIe1 AXI clock

Have you verified that you actually need the bus clock for the second
controller here?

> +        - properties:
> +            clocks:
> +              maxItems: 8
> +            clock-names:
> +              items:
> +                - const: aux # Auxiliary clock
> +                - const: cfg # Configuration clock
> +                - const: bus_master # Master AXI clock
> +                - const: bus_slave # Slave AXI clock
> +                - const: slave_q2a # Slave Q2A clock
> +                - const: tbu # PCIe TBU clock
> +                - const: ddrss_sf_tbu # PCIe SF TBU clock
> +                - const: aggre1 # Aggre NoC PCIe1 AXI clock
> +      properties:
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +

Johan
