Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B318A56A4A3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 15:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbiGGN4Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 09:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbiGGN4W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 09:56:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A535D24097;
        Thu,  7 Jul 2022 06:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5276FB82011;
        Thu,  7 Jul 2022 13:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B2BC341C6;
        Thu,  7 Jul 2022 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657202178;
        bh=BKaRO/YMm42XuwYjxo89kIvPWzv36vXiBoURM9kzYzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0r+wGxBPPpK+sEeKpjlqjo9PLI+7f9xyfKe5k21z3DBSGiliKTgoB2jgGYKKTkSP
         H3LzPZdn0afXO5MpVcYbDmfK0RAwO7FwzD7TDgKuN7SJLMZsB6y0a8veP5lMJRhjkS
         I3rdXThQL38x7kqx6ni4IG5f7VpfgdhPgrsm166eTPqU6u2vMYrZ8qUt7hCpkmskbF
         n2tKHi0VrSPAcNusn9YnAJRZEcBlFM715u21cwFwZXfL/uPdz/gtFDv/n4uCdlw1TI
         8GJR3+BnMGzlREgBSSN9NRh7rPPq/H5IH5aFl4fQ0xsZ2ULoyGHXdk6IovoQuwygkU
         9RI6v0MoeF+rA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o9RzQ-0001Aw-PU; Thu, 07 Jul 2022 15:56:20 +0200
Date:   Thu, 7 Jul 2022 15:56:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: fix typo in condition guarding
 resets
Message-ID: <YsbmBExeCtehzrvC@hovoldconsulting.com>
References: <20220707134552.2436442-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707134552.2436442-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 07, 2022 at 04:45:52PM +0300, Dmitry Baryshkov wrote:
> Fix the typo (compatibles vs compatible) in the condition guarding the
> resets being required everywhere except MSM8996.
> 
> Fixes: 6700a9b00f0a ("dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I already posted a fix for this a week ago as you probably noticed as I
was the one pointing the issue out to you:

	https://lore.kernel.org/lkml/20220629141000.18111-2-johan+linaro@kernel.org/

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 0b69b12b849e..9b3ebee938e8 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -614,7 +614,7 @@ allOf:
>    - if:
>        not:
>          properties:
> -          compatibles:
> +          compatible:
>              contains:
>                enum:
>                  - qcom,pcie-msm8996

Johan
