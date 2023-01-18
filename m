Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEB6671E07
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 14:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjARNgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 08:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjARNfj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 08:35:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F58599B1;
        Wed, 18 Jan 2023 05:03:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5F0BB81B79;
        Wed, 18 Jan 2023 13:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A79FC433D2;
        Wed, 18 Jan 2023 13:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674047032;
        bh=H9OnX6tOzIQ0Ao5RbA/08LRthWY8/pH4phATDneivAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EmwuKUzeMsYm71VpkSSqTqSYqnGqgW4bIsKRzXGreRemKLoaUthkjZjFqlWtBLbgw
         t5eLf218/BN2dvC9hJ7niiPuCOHkSJlKL/K4hnoV8OXGysY36w0vvnYVCQdFLEkXeq
         QJBcZWNFOsD2vXW1zqni75xmARVqbf0/zqzsSGxBHbym6z2LoaNhXCMUuM+NLo89id
         tr/m5Jx2ol2BnRMk939km4gn5FFUhL/y45EeNDt6RrzSRUZSgmBOg+u5wlzqMX6BkL
         jDhPsOjD0Z3g2iNvMIp+NRbZQG+NZ18DhEADzbEteV+7/S19cCWoBZyTlRj8mSR7o6
         VfX0LmohFCt8w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pI86y-00063F-U2; Wed, 18 Jan 2023 14:04:16 +0100
Date:   Wed, 18 Jan 2023 14:04:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom: Add SM8550 compatible
Message-ID: <Y8fuUI4xaNkADkWl@hovoldconsulting.com>
References: <20230118111704.3553542-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118111704.3553542-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 18, 2023 at 01:17:03PM +0200, Abel Vesa wrote:
> Add the SM8550 platform to the binding.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v1 was here:
> https://lore.kernel.org/all/20221116123505.2760397-1-abel.vesa@linaro.org/
> 
> Changes since v1:
>  * Switched to single compatible for both PCIes (qcom,pcie-sm8550)
>  * dropped enable-gpios property
>  * dropped interconnects related properties, the power-domains properties
>    and resets related properties the sm8550 specific allOf:if:then
>  * dropped pipe_mux, phy_pipe and ref clocks from the sm8550 specific
>    allOf:if:then clock-names array and decreased the minItems and
>    maxItems for clocks property accordingly
> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index a5859bb3dc28..78e8babd11d9 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -34,6 +34,7 @@ properties:
>        - qcom,pcie-sm8250
>        - qcom,pcie-sm8450-pcie0
>        - qcom,pcie-sm8450-pcie1
> +      - qcom,pcie-sm8550
>        - qcom,pcie-ipq6018
>  
>    reg:
> @@ -197,6 +198,7 @@ allOf:
>                - qcom,pcie-sm8250
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
> +              - qcom,pcie-sm8550
>      then:
>        properties:
>          reg:
> @@ -611,6 +613,40 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sm8550
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 8
> +          maxItems: 9
> +        clock-names:
> +          items:
> +            - const: pipe # PIPE clock

The pipe clock is managed by the PHY and should not be here either.

> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: ddrss_sf_tbu # PCIe SF TBU clock
> +            - const: aggre # Aggre NoC PCIe0 AXI clock

The comment referring to a specific controller instance (PCIe0) looks
wrong.

We used a noc_ prefix to separate it from the cnoc_ clocks for sc8280xp
(e.g. noc_aggr_4).

> +            - const: cnoc_pcie_sf_axi # Config NoC PCIe1 AXI clock

The _pcie infix looks unnecessary, same comment about PCIe1 as above.

> +        iommus:
> +          maxItems: 1
> +        iommu-map:
> +          maxItems: 2
> +        resets:
> +          minItems: 1
> +          maxItems: 2
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +            - const: pcie_1_link_down_reset # PCIe link down reset

No need to repeat the resource type in the name. Shouldn't this just be
'link_down' or similar?

> +
>    - if:
>        properties:
>          compatible:
> @@ -694,6 +730,7 @@ allOf:
>                - qcom,pcie-sm8250
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
> +              - qcom,pcie-sm8550
>      then:
>        oneOf:
>          - properties:

Johan
