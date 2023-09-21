Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852217A9A71
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 20:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjIUSjy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 14:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjIUSjp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 14:39:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A788B0F5E;
        Thu, 21 Sep 2023 11:39:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A46C433C7;
        Thu, 21 Sep 2023 18:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695321533;
        bh=Jo3M7JtBDMiHK2zM7MVLMg4fZ9vIWVE8KTJC0QLndO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcnsYo6A8D09XBG+riw76rhi9G0pfINMuDAzNBm524D+q7PUAIk1b3wUl5vL4ug18
         hgJfsn8lAIay59okmDzzZwjUKxpAnKyoGIxQ9Q1cvfaRd0ZnV3LchtOZi8alhoZtkl
         QLpEEFlUpgggXoSESoS1Scm1qIBqt6Cfnj7rzPUkGzvPjAbQI4LHFFeD7AqJpwSD21
         PIeVEK+LegHr1y88bqx+U9dXi70CoZA9tjFag7pxUk/GRgGVpsVtV9Yzv2VD232p8w
         QqTO8HIV5FhRxbPI84b2rnjLD23VMFddu64fvvrJBWf5XrNIsrOaur8YH/XXrVRyAk
         Duge0PLfpwgZA==
Received: (nullmailer pid 782544 invoked by uid 1000);
        Thu, 21 Sep 2023 18:38:50 -0000
Date:   Thu, 21 Sep 2023 13:38:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 1/5] dt-bindings: PCI: qcom-ep: Add support for
 SA8775P SoC
Message-ID: <20230921183850.GA762694-robh@kernel.org>
References: <1695218113-31198-1-git-send-email-quic_msarkar@quicinc.com>
 <1695218113-31198-2-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695218113-31198-2-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 20, 2023 at 07:25:08PM +0530, Mrinmay Sarkar wrote:
> Add devicetree bindings support for SA8775P SoC.
> Define reg and interrupt per platform.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 130 +++++++++++++++++----
>  1 file changed, 108 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index a223ce0..e860e8f 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -13,6 +13,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - qcom,sa8775p-pcie-ep
>            - qcom,sdx55-pcie-ep
>            - qcom,sm8450-pcie-ep
>        - items:
> @@ -20,29 +21,19 @@ properties:
>            - const: qcom,sdx55-pcie-ep
>  
>    reg:
> -    items:
> -      - description: Qualcomm-specific PARF configuration registers
> -      - description: DesignWare PCIe registers
> -      - description: External local bus interface registers
> -      - description: Address Translation Unit (ATU) registers
> -      - description: Memory region used to map remote RC address space
> -      - description: BAR memory region
> +    minItems: 6
> +    maxItems: 7
>  
>    reg-names:
> -    items:
> -      - const: parf
> -      - const: dbi
> -      - const: elbi
> -      - const: atu
> -      - const: addr_space
> -      - const: mmio
> +    minItems: 6
> +    maxItems: 7

Don't move these into if/then schemas. Then we are duplicating the 
names, and there is no reason to keep them aligned for new compatibles.

Rob
