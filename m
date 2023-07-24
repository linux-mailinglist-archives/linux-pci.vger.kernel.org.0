Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7475EB4C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 08:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGXGRF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 02:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGXGRE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 02:17:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6016B1B4;
        Sun, 23 Jul 2023 23:17:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DABD160F25;
        Mon, 24 Jul 2023 06:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADC9C433C8;
        Mon, 24 Jul 2023 06:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690179421;
        bh=54FIbV0uolapPF1pZMiAwThu+twaSkdErRK7mohWjA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sM7W7N1b2+KvnVHTFOET9VVBhel/MNGje/6cOWCs6qqPKeHKSnocQf70zXLlKPe0z
         GPZefphWHMn3m6vYb3isKY3R+Saofi9kGLFdbMy2JwRrrIdGpsUDjNt+JhY1QKOMfi
         gKRUZYrxMYqVwK5bclhM/cM3zZtujM25JqreySMvGENlCxSPBlMO8ikWl9t5AIr87v
         fjkglzyT0wxVMD8Vv6PCL4np5h6KLdM0fpHBycXRzbTO581f8xHX3YcBkoUlU94QAS
         +diR8bkTW72Hl1DyJREYk0GyBDBiJJh8gKhJZilEwUYFHp4oZve5HH4LfW5lVJhvuP
         04RxXkoXw5+dw==
Date:   Mon, 24 Jul 2023 11:46:45 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: PCI: qcom: Add sa8775p compatible
Message-ID: <20230724061645.GH2370@thinkpad>
References: <1689960276-29266-1-git-send-email-quic_msarkar@quicinc.com>
 <1689960276-29266-2-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1689960276-29266-2-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 10:54:32PM +0530, Mrinmay Sarkar wrote:
> Add sa8775p platform to the binding.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 81971be4..eadba38 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -29,6 +29,7 @@ properties:
>            - qcom,pcie-msm8996
>            - qcom,pcie-qcs404
>            - qcom,pcie-sa8540p
> +          - qcom,pcie-sa8775p
>            - qcom,pcie-sc7280
>            - qcom,pcie-sc8180x
>            - qcom,pcie-sc8280xp
> @@ -211,6 +212,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,pcie-sa8775p
>                - qcom,pcie-sc7280
>                - qcom,pcie-sc8180x
>                - qcom,pcie-sc8280xp
> @@ -748,7 +750,32 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,pcie-sa8775p
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 5
> +          maxItems: 5
> +        clock-names:
> +          items:
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
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
>                - qcom,pcie-sa8540p
> +              - qcom,pcie-sa8775p
>                - qcom,pcie-sc8280xp
>      then:
>        required:
> @@ -790,6 +817,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,pcie-msm8996
> +              - qcom,pcie-sa8775p
>                - qcom,pcie-sc7280
>                - qcom,pcie-sc8180x
>                - qcom,pcie-sdm845
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
