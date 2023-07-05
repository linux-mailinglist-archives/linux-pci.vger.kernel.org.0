Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF60747F9A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 10:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGEI0v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 04:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjGEI0t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 04:26:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060FE184;
        Wed,  5 Jul 2023 01:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98F7D61472;
        Wed,  5 Jul 2023 08:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E69C433C8;
        Wed,  5 Jul 2023 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688545607;
        bh=vbVB+2RsUlsWIw6dl4Q4bSyMWzFos1EUXHH6bK3/yy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACz0NMoLXOYC827FB2f9E8fs7GHHqax4xUJr2SkTX50NGlbcLbFamx+mc5pMJ3G4h
         nNa153G8FGm0ANZRn7cJv2elOBQ1zqVKnStGP59VRjczwArQAdulm/QyAdXyD1UlJm
         WUEWBMUkcGr76YKChfhn4RhHFcEIKoeGN4kt1Dqlp8eBA9O39vLFm5Nyw5a+JJAQD/
         GS1JVdpRy8Gtml2v/sPosrA7MHdRA7XLp8uOishmw77FjVD+fcJJDrFTSC56ufP5OR
         Zp5fq0sr6MJ5Yx2FMoUTt37B5lAgdl2PFjJhAEjCbav+XjEbOWmL+P7ZnZ09W/Wnvo
         Bp0YpdDZVEcvA==
Date:   Wed, 5 Jul 2023 13:56:29 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 2/6] dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe
 PHY
Message-ID: <20230705082629.GB11854@thinkpad>
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <1688545032-17748-3-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1688545032-17748-3-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 01:47:07PM +0530, Mrinmay Sarkar wrote:
> Add devicetree YAML binding for Qualcomm QMP PCIe PHY
> for SA8775p platform.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index a0407fc79563..9309066bfcee 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -23,6 +23,8 @@ properties:
>        - qcom,sm8350-qmp-gen3x1-pcie-phy
>        - qcom,sm8550-qmp-gen3x2-pcie-phy
>        - qcom,sm8550-qmp-gen4x2-pcie-phy
> +      - qcom,sa8775p-qmp-gen4x2-pcie-phy
> +      - qcom,sa8775p-qmp-gen4x4-pcie-phy

Same comment as patch 1.

- Mani

>  
>    reg:
>      minItems: 1
> @@ -30,7 +32,7 @@ properties:
>  
>    clocks:
>      minItems: 5
> -    maxItems: 6
> +    maxItems: 7
>  
>    clock-names:
>      minItems: 5
> @@ -39,6 +41,7 @@ properties:
>        - const: cfg_ahb
>        - const: ref
>        - const: rchng
> +      - const: phy_aux
>        - const: pipe
>        - const: pipediv2
>  
> @@ -136,6 +139,20 @@ allOf:
>          clock-names:
>            minItems: 6
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sa8775p-qmp-gen4x2-pcie-phy
> +              - qcom,sa8775p-qmp-gen4x4-pcie-phy
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 7
> +        clock-names:
> +          maxItems: 7
> +
>    - if:
>        properties:
>          compatible:
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
