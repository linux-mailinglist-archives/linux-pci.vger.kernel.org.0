Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7A265C825
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 21:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjACUjV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 15:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjACUjU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 15:39:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3859DD2F0;
        Tue,  3 Jan 2023 12:39:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C629561509;
        Tue,  3 Jan 2023 20:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAA7C433D2;
        Tue,  3 Jan 2023 20:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672778358;
        bh=qHvw7TqJ6cPDkYRnlA1AfRE2VUgBjuTgxJT0EOvT+mA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n4W6E+l9mqKxp8pq4uTlXkUofQBU28moAscYkumViFYhakx33ESmTHMVOPRvyrmBh
         bFmrQAWwmlM700lNqBUMJXONMjcEba2ULla6VQIlXTDUIjB7tV2eCf+bonCgr/vX/G
         oEQoxReeywHawrC/fTYDrQmtZxVzykoywUzbUku9AZBjjSU/lYzTYg16IwFVSTqU3a
         +fqJda6sYo4dTq9Jbvwmx+EOUkOWQRrhoS+DhDyTNxL2TIdsmKSEpbeIoaWjjPhp/3
         0sIa8GYH31KH3rPDT3JMaGAyGg+1q9hCfTYlRfYpRv+z/yZbzh0BfegR1bU0peFss2
         COTkABJRG/80Q==
Date:   Tue, 3 Jan 2023 14:39:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: PCI: qcom: add MSM8998 specific
 compatible
Message-ID: <20230103203915.GA1020424@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115125310.184012-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 01:53:07PM +0100, Krzysztof Kozlowski wrote:
> Add new compatible for MSM8998 (compatible with MSM8996) to allow
> further customizing if needed and to accurately describe the hardware.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hi Krzysztof,

Would you mind splitting this into two patches?

  - Convert "compatible:" from enum: to oneOf:
  - Add MSM8998

Having them combined makes the history a little bit harder to follow.

Bjorn

> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 42 ++++++++++---------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 54f07852d279..0411e2e67661 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -16,25 +16,29 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - qcom,pcie-ipq8064
> -      - qcom,pcie-ipq8064-v2
> -      - qcom,pcie-apq8064
> -      - qcom,pcie-apq8084
> -      - qcom,pcie-msm8996
> -      - qcom,pcie-ipq4019
> -      - qcom,pcie-ipq8074
> -      - qcom,pcie-qcs404
> -      - qcom,pcie-sa8540p
> -      - qcom,pcie-sc7280
> -      - qcom,pcie-sc8180x
> -      - qcom,pcie-sc8280xp
> -      - qcom,pcie-sdm845
> -      - qcom,pcie-sm8150
> -      - qcom,pcie-sm8250
> -      - qcom,pcie-sm8450-pcie0
> -      - qcom,pcie-sm8450-pcie1
> -      - qcom,pcie-ipq6018
> +    oneOf:
> +      - enum:
> +          - qcom,pcie-ipq8064
> +          - qcom,pcie-ipq8064-v2
> +          - qcom,pcie-apq8064
> +          - qcom,pcie-apq8084
> +          - qcom,pcie-msm8996
> +          - qcom,pcie-ipq4019
> +          - qcom,pcie-ipq8074
> +          - qcom,pcie-qcs404
> +          - qcom,pcie-sa8540p
> +          - qcom,pcie-sc7280
> +          - qcom,pcie-sc8180x
> +          - qcom,pcie-sc8280xp
> +          - qcom,pcie-sdm845
> +          - qcom,pcie-sm8150
> +          - qcom,pcie-sm8250
> +          - qcom,pcie-sm8450-pcie0
> +          - qcom,pcie-sm8450-pcie1
> +          - qcom,pcie-ipq6018
> +      - items:
> +          - const: qcom,pcie-msm8998
> +          - const: qcom,pcie-msm8996
>  
>    reg:
>      minItems: 4
> -- 
> 2.34.1
> 
