Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54C166AF5E
	for <lists+linux-pci@lfdr.de>; Sun, 15 Jan 2023 05:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjAOEaE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Jan 2023 23:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjAOEaC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jan 2023 23:30:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A1E4C07;
        Sat, 14 Jan 2023 20:30:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7010E60C68;
        Sun, 15 Jan 2023 04:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF86FC433EF;
        Sun, 15 Jan 2023 04:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673757000;
        bh=PSgulVEUUqTRzSvn8RnkocUwVzd4cBE7bCXVPN4Ajzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SkzsTARwVi56jFRgk/TdixKKXoLEfnWs7bMiHxNe2tVtQ9ZOb9xykaIhCwraqZghG
         +iVZqhtMSv8o2qdropaI5Fe9zI7rZCAjKgmvtvk+yasQYOsyrdFf7Br6YhF8QDzp5w
         PVDqvzXNyHD42eZ/4x2kP4WWMD97Ez87tMIt16sbMQJOp1iGVsvOxKZVNvAi57c/7X
         yFQgKeV4oo6C/URgwjEuG0HZj9VX05LJn3HgNhOOUOg63P2aPohY8E2T7c3lMLXP2W
         c42MzMM/2q2XKf/QLNK+Wog7hwXuBl4Ov5mhJsh5pypjkxTaVbgJMFeSJJek/si8Os
         zrIlq3kH2kyZQ==
Date:   Sun, 15 Jan 2023 09:59:51 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, svarbanov@mm-sol.com, shawn.guo@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] dt-bindings: PCI: qcom: alphabetically sort
 compatibles
Message-ID: <20230115042951.GK6568@thinkpad>
References: <20221116214841.1116735-1-robimarko@gmail.com>
 <20221116214841.1116735-5-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221116214841.1116735-5-robimarko@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 10:48:37PM +0100, Robert Marko wrote:
> Sort the compatibles list alphabetically for maintenance.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 2f851c804bb0..1e94c210429a 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -17,13 +17,14 @@ description: |
>  properties:
>    compatible:
>      enum:
> -      - qcom,pcie-ipq8064
> -      - qcom,pcie-ipq8064-v2
>        - qcom,pcie-apq8064
>        - qcom,pcie-apq8084
> -      - qcom,pcie-msm8996
>        - qcom,pcie-ipq4019
> +      - qcom,pcie-ipq6018
> +      - qcom,pcie-ipq8064
> +      - qcom,pcie-ipq8064-v2
>        - qcom,pcie-ipq8074
> +      - qcom,pcie-msm8996
>        - qcom,pcie-qcs404
>        - qcom,pcie-sa8540p
>        - qcom,pcie-sc7280
> @@ -34,7 +35,6 @@ properties:
>        - qcom,pcie-sm8250
>        - qcom,pcie-sm8450-pcie0
>        - qcom,pcie-sm8450-pcie1
> -      - qcom,pcie-ipq6018
>  
>    reg:
>      minItems: 4
> -- 
> 2.38.1
> 

-- 
மணிவண்ணன் சதாசிவம்
