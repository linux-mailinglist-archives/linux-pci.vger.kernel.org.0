Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C69462DBF5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 13:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiKQMvR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 07:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiKQMu4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 07:50:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40956EF8;
        Thu, 17 Nov 2022 04:50:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1EF661B9D;
        Thu, 17 Nov 2022 12:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C55C433C1;
        Thu, 17 Nov 2022 12:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668689454;
        bh=1a06KWkjecMLhklDpZ9gKeF7p20g4Jg+8/l7J4th3DA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uQI8fJZvy/OqooWhKanaVet9mE1ia1m3MLLCP+ziuc+YrxxG1wjEWmBMHRE+c9Yh6
         70AppzRVhOi62bnRaG7siA6th40i0k9/wcDaZf7+zv5mGuJU+IJhlpnA9Z1Qv1KoHI
         II+0zQl3O7t72CieDMEWj1Vnj3HgYWhAr9U9kpDYbi8nQNVv2wRNvcUuSLEWjJ4IoJ
         t7nY5hdgphyln3QPfvoSHL/n6rivxlYMZgFepxJClwWUosNArIT/FXEPlIU6jIa9U5
         FNwJsI+kbYRgQ+dfYhNKZhOqma/90AWQJgtHCVYaocmc0PNQyQtrKsJC2L2BepJHQS
         9I4lP8KCPt10Q==
Message-ID: <429fd44a-34e1-be31-2c6c-c1106e3c98cb@kernel.org>
Date:   Thu, 17 Nov 2022 14:50:47 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom: Add SM8550 to binding
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kw@linux.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20221116123505.2760397-1-abel.vesa@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20221116123505.2760397-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Abel,

On 16.11.22 14:35, Abel Vesa wrote:
> Add the SM8550 platform to the binding.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 96 +++++++++++++++++++
>   1 file changed, 96 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 54f07852d279..efa01a8411c4 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -34,6 +34,8 @@ properties:
>         - qcom,pcie-sm8250
>         - qcom,pcie-sm8450-pcie0
>         - qcom,pcie-sm8450-pcie1
> +      - qcom,pcie-sm8550-pcie0
> +      - qcom,pcie-sm8550-pcie1
>         - qcom,pcie-ipq6018
>   
>     reg:
> @@ -92,6 +94,10 @@ properties:
>     power-domains:
>       maxItems: 1
>   
> +  enable-gpios:
> +    description: GPIO controlled connection to ENABLE# signal
> +    maxItems: 1
> +
>     perst-gpios:
>       description: GPIO controlled connection to PERST# signal
>       maxItems: 1
> @@ -187,6 +193,8 @@ allOf:
>                 - qcom,pcie-sm8250
>                 - qcom,pcie-sm8450-pcie0
>                 - qcom,pcie-sm8450-pcie1
> +              - qcom,pcie-sm8550-pcie0
> +              - qcom,pcie-sm8550-pcie1
>       then:
>         properties:
>           reg:
> @@ -601,6 +609,92 @@ allOf:
>             items:
>               - const: pci # PCIe core reset
>   
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sm8550-pcie0
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 11
> +          maxItems: 11
> +        clock-names:
> +          items:
> +            - const: pipe # PIPE clock
> +            - const: pipe_mux # PIPE MUX
> +            - const: phy_pipe # PIPE output clock
> +            - const: ref # REFERENCE clock
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: ddrss_sf_tbu # PCIe SF TBU clock
> +            - const: aggre0 # Aggre NoC PCIe0 AXI clock
> +        interconnects:
> +          maxItems: 1
> +        interconnect-names:
> +          const: icc_path
> +        iommus:
> +          maxItems: 1
> +        iommu-map:
> +          maxItems: 2
> +        power-domains:
> +          maxItems: 1
> +        power-domain-names:
> +          const: gdsc
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sm8550-pcie1
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 12
> +          maxItems: 12
> +        clock-names:
> +          items:
> +            - const: pipe # PIPE clock
> +            - const: pipe_mux # PIPE MUX
> +            - const: phy_pipe # PIPE output clock
> +            - const: ref # REFERENCE clock
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: ddrss_sf_tbu # PCIe SF TBU clock
> +            - const: aggre1 # Aggre NoC PCIe1 AXI clock
> +            - const: cnoc_pcie_sf_axi # Config NoC PCIe1 AXI clock
> +        interconnects:
> +          maxItems: 1
> +        interconnect-names:
> +          const: icc_path

The name of the path is too generic. Probably something like "pcie-mem" or "pcie-ddr" would be
more appropriate to indicate that this is for requesting bandwidth on the path between PCIE and
DDR memory.

Thanks,
Georgi

> +        iommus:
> +          maxItems: 1
> +        iommu-map:
> +          maxItems: 2
> +        power-domains:
> +          maxItems: 1
> +        power-domain-names:
> +          const: gdsc
> +        resets:
> +          maxItems: 2
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +            - const: pcie_1_link_down_reset # PCIe link down reset
> +
>     - if:
>         properties:
>           compatible:
> @@ -672,6 +766,8 @@ allOf:
>                 - qcom,pcie-sm8250
>                 - qcom,pcie-sm8450-pcie0
>                 - qcom,pcie-sm8450-pcie1
> +              - qcom,pcie-sm8550-pcie0
> +              - qcom,pcie-sm8550-pcie1
>       then:
>         oneOf:
>           - properties:

