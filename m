Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C006AC8B6
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 17:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjCFQul (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 11:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjCFQui (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 11:50:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2747C20692;
        Mon,  6 Mar 2023 08:50:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 43DB0CE13BE;
        Mon,  6 Mar 2023 16:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377D6C433D2;
        Mon,  6 Mar 2023 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678121344;
        bh=iBKApfgP69TuqiYuJl4EoYVR8pMAhT0OCMK5XuShs24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5dKb+o3w8SKk29OcBokO4VZ7vJezJAvCvn5Qup4SuvnrvpGYCQjos7aEFx7+7Zae
         y+cgUGf4pBanRndJwupF7M515vz3/KM5DLtwL9XUFnP/nLaUfMY53BFUB7iMXppOdu
         UFj3+h1bctZ/ArS0VFmRRk3OQ/YuPjM5Y2n0ITzPtpb3Yfg5H2yrMp63ztnLH9aS1v
         NTGIWh4AZZ7oBm8gvS3gqFQsv4kbYNqOXxp2GGhLWDR/Eb4MjHh/ufDxPDyEuBVfWd
         o6Zdq1r5B5snE0umVZdbnI3lwKBHC1c+ZOs7iq28CdHg6bsFd7PpTKuMT6trEdt3C3
         p6H95KBe8djAw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pZE1w-0005kc-Tf; Mon, 06 Mar 2023 17:49:44 +0100
Date:   Mon, 6 Mar 2023 17:49:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH 15/19] dt-bindings: PCI: qcom: Add "mhi" register region
 to supported SoCs
Message-ID: <ZAYZqH2/vB7r9L4L@hovoldconsulting.com>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
 <20230306153222.157667-16-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306153222.157667-16-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 06, 2023 at 09:02:18PM +0530, Manivannan Sadhasivam wrote:
> "mhi" register region contains the MHI registers that could be used by
> the PCIe controller drivers to get debug information like PCIe link
> transition counts on newer SoCs.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index fb32c43dd12d..2de6e7154025 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -44,11 +44,11 @@ properties:
>  
>    reg:
>      minItems: 4
> -    maxItems: 5
> +    maxItems: 6
>  
>    reg-names:
>      minItems: 4
> -    maxItems: 5
> +    maxItems: 6
>  
>    interrupts:
>      minItems: 1
> @@ -185,10 +185,12 @@ allOf:
>        properties:
>          reg:
>            minItems: 4
> -          maxItems: 4
> +          maxItems: 5
>          reg-names:
> +          minItems: 4
>            items:
>              - const: parf # Qualcomm specific registers
> +            - const: mhi # MHI registers

You need to add the new (optional) registers at the end.

>              - const: dbi # DesignWare PCIe registers
>              - const: elbi # External local bus interface registers
>              - const: config # PCIe configuration space

Johan
