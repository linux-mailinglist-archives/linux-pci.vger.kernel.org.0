Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DDD66AF59
	for <lists+linux-pci@lfdr.de>; Sun, 15 Jan 2023 05:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjAOE2h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Jan 2023 23:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjAOE2g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jan 2023 23:28:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EE54C07;
        Sat, 14 Jan 2023 20:28:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D87F60C66;
        Sun, 15 Jan 2023 04:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A77C433D2;
        Sun, 15 Jan 2023 04:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673756914;
        bh=VEsZLAnyUzrv+Gt0raQAzpjaxouHdUfnw0Kj2Jmxwr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g1IpJw0eu2mEM9qSkVFAwGYi6HNQyfGGL/mAO6ESJuw7pYLtepeld7QruKCKrTUyI
         VtNRz7nlw99XOygUmfQkYHtZIHxWptAumEjVCGm8GtDTRAGV70FI860i/wlaMakiVl
         4QOjTgHK+MyrBM6ws/Sh+vj3blrJrwf7R1eX+KlLjX25lVeyVAiHPkH8nuYXykQmV8
         55KSQ3CqncDSkwN3+sidFaXfOc9HJOmP2hlgWHPY2gcqlZl/PyR7U2eAngAbGlCY4f
         o3mD37j3bMe7RjkM+XcWfUmEVtaIol39wPP/ik4k+0m6+9vTZkmIWBpxR3uW4ywjq0
         Fb4IdVukxB3jw==
Date:   Sun, 15 Jan 2023 09:58:26 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] dt-bindings: PCI: qcom: document IPQ8074 Gen3 port
Message-ID: <20230115042826.GJ6568@thinkpad>
References: <20221116214841.1116735-1-robimarko@gmail.com>
 <20221116214841.1116735-6-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221116214841.1116735-6-robimarko@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 10:48:38PM +0100, Robert Marko wrote:
> IPQ8074 has one Gen2 and one Gen3 PCIe port, with Gen2 already supported.
> Document Gen3 port which uses the same controller as IPQ6018.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 1e94c210429a..59f4c9990f85 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -24,6 +24,7 @@ properties:
>        - qcom,pcie-ipq8064
>        - qcom,pcie-ipq8064-v2
>        - qcom,pcie-ipq8074
> +      - qcom,pcie-ipq8074-gen3
>        - qcom,pcie-msm8996
>        - qcom,pcie-qcs404
>        - qcom,pcie-sa8540p
> @@ -151,6 +152,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,pcie-ipq6018
> +              - qcom,pcie-ipq8074-gen3
>      then:
>        properties:
>          reg:
> @@ -371,6 +373,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,pcie-ipq6018
> +              - qcom,pcie-ipq8074-gen3
>      then:
>        properties:
>          clocks:
> @@ -662,6 +665,7 @@ allOf:
>                  - qcom,pcie-ipq8064
>                  - qcom,pcie-ipq8064v2
>                  - qcom,pcie-ipq8074
> +                - qcom,pcie-ipq8074-gen3
>                  - qcom,pcie-qcs404
>      then:
>        required:
> @@ -744,6 +748,7 @@ allOf:
>                - qcom,pcie-ipq8064
>                - qcom,pcie-ipq8064-v2
>                - qcom,pcie-ipq8074
> +              - qcom,pcie-ipq8074-gen3
>                - qcom,pcie-qcs404
>                - qcom,pcie-sa8540p
>      then:
> -- 
> 2.38.1
> 

-- 
மணிவண்ணன் சதாசிவம்
