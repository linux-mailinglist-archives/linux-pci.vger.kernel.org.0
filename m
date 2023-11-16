Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF17EDB57
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 06:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjKPF7G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Nov 2023 00:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPF7F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Nov 2023 00:59:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC460199;
        Wed, 15 Nov 2023 21:59:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886BDC433C8;
        Thu, 16 Nov 2023 05:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700114342;
        bh=zIBoIMjkQLDuaFd4ozL0mTsfE2T9J5hDZSe6xZBhCJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E1Iqy3y7jh6BFZb2lB98bTX699JnCUdr9D5+WAEDFYS/vICKSBwJbH1Gbm1dOtWFD
         fK1d4RE9JV70ET68I4SHqnEEAU6Fhx5uwnYVi1hMUfGME8orECIb+8sGiOXRvLLZDH
         IdGFqNDyyT30HPXPp0UlzzXOX+dPyRPYIninma6jyeoy5HgOQ8pol+UWdelrvnetJe
         9l5RbraB2tTghn19QeBbmFCDo7YwkDCVJ8DvNeTUdq4H1MC3nUxihGeTmbFQ4wApVQ
         JZb2OtyqqEKnEenTQ2smR3/Bp87yUoXGNLFFQ8at8F3XqpW/sY97sXLJYJ+5KV0X+x
         J08UYLL5ARSwA==
Date:   Thu, 16 Nov 2023 11:28:47 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom: adjust iommu-map for
 different SoC
Message-ID: <20231116055847.GB3443@thinkpad>
References: <20231112184557.3801-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231112184557.3801-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 12, 2023 at 07:45:56PM +0100, Krzysztof Kozlowski wrote:
> The PCIe controller on SDX55 has five entries in its iommu-map, MSM8998
> has one and SDM845 has sixteen, so allow wider number of items to fix
> dtbs_check warnings like:
> 
>   qcom-sdx55-mtp.dtb: pcie@1c00000: iommu-map: [[0, 21, 512, 1], [256, 21, 513, 1],
>     [512, 21, 514, 1], [768, 21, 515, 1], [1024, 21, 516, 1]] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 8bfae8eb79a3..14d25e8a18e4 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -62,7 +62,8 @@ properties:
>      maxItems: 8
>  
>    iommu-map:
> -    maxItems: 2
> +    minItems: 1
> +    maxItems: 16
>  
>    # Common definitions for clocks, clock-names and reset.
>    # Platform constraints are described later.
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
