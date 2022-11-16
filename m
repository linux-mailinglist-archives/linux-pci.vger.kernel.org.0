Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A9C62BF94
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 14:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiKPNe7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 08:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiKPNez (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 08:34:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C729A6308;
        Wed, 16 Nov 2022 05:34:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 620C461DF3;
        Wed, 16 Nov 2022 13:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF30C433D6;
        Wed, 16 Nov 2022 13:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668605693;
        bh=zlY4mrIv0s5cE8xdBAeTBqSjaL9Tl9EQS+raR3pCQ2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYQqBhcDXeEq2QL2JmFHGJK3Tj4P9EKXRaACb5i3uhghyscPxmFiZEQ8+nlhhWVR0
         GUhOk8J2YSZcsOAoevlc3MkgR9TLSrfB0CXPcRo41NjJ/v5oHSxyypEUcLNPeOFrwX
         StXcGyTnOy8++FMmkG4OVTGQGXwH1HhY/Q43zyqh/yB5KgfAow+/sKuOnW6gC/ioGo
         Uch2eUL14/+f5d3Qxo6tDM+fys7daoYB+bDO+9QkQ9VcOG+p5HW1QnUNJNREOAy6oV
         cTdd0WMJZ+LUGV1x3MSybJSVA/N3AeWd2N9P279nHycdAUY0IxirZEU8NERnqLUHXv
         9L9+CSHzIzxqg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovIYZ-0002cK-Ts; Wed, 16 Nov 2022 14:34:23 +0100
Date:   Wed, 16 Nov 2022 14:34:23 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kw@linux.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom: Add SM8550 to binding
Message-ID: <Y3Tm30LKs7IX76+3@hovoldconsulting.com>
References: <20221116123505.2760397-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116123505.2760397-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 02:35:04PM +0200, Abel Vesa wrote:
> Add the SM8550 platform to the binding.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 54f07852d279..efa01a8411c4 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -34,6 +34,8 @@ properties:
>        - qcom,pcie-sm8250
>        - qcom,pcie-sm8450-pcie0
>        - qcom,pcie-sm8450-pcie1
> +      - qcom,pcie-sm8550-pcie0
> +      - qcom,pcie-sm8550-pcie1

You should only need one compatible even if there are differences in
which bus clocks you need to enable.

>        - qcom,pcie-ipq6018
>  
>    reg:
> @@ -92,6 +94,10 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  enable-gpios:
> +    description: GPIO controlled connection to ENABLE# signal
> +    maxItems: 1
> +
>    perst-gpios:
>      description: GPIO controlled connection to PERST# signal
>      maxItems: 1
> @@ -187,6 +193,8 @@ allOf:
>                - qcom,pcie-sm8250
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
> +              - qcom,pcie-sm8550-pcie0
> +              - qcom,pcie-sm8550-pcie1
>      then:
>        properties:
>          reg:
> @@ -601,6 +609,92 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
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

The mux and pipe output does not belong in the binding and instead the
muxing should be handled by the clock driver (cf. sc8280xp). You can
probably drop the refclock too.

> +            - const: ref # REFERENCE clock
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: ddrss_sf_tbu # PCIe SF TBU clock
> +            - const: aggre0 # Aggre NoC PCIe0 AXI clock

Johan
