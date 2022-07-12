Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B955726C2
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 21:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiGLTy2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 15:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbiGLTyK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 15:54:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4C41B3;
        Tue, 12 Jul 2022 12:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3EC2B81BD9;
        Tue, 12 Jul 2022 19:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDADC3411C;
        Tue, 12 Jul 2022 19:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657655499;
        bh=Ge9R3Wmr/GScs3XnbQ//iMRn3devKcZEs90fxqb2FWc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ir7BXwmnt/b/13fI4ruCiujBC/4Fyjpzg3OAYJMiB4KmnSwkWAEWJ5f81xYZfuIvR
         RTqAtkTB1eEKcVonLk7bw1gjOZTIgyrUgWaL75RUlIyNbo0IYesYbFHivN7t5IicH2
         G6EU5DbSVSFrszh+lvPdrUwhoAfs8lgsu9VwwdKj09kNbS1cpTX92ZnGhGWE1s8p9e
         HJ9TCbkIxbjfxkSHqbKRzmzORuU2FpxqTgeD+/p40iEh++nQ8wurkL/SAQUjT14yFi
         7B4oU+0Nq2hv3h+7M+IBY2EJEPSieQc+IF3MSMFsNu03fs1reP3jZPXnzQC6Dyr6q7
         uCCSBKVPHwAFQ==
Date:   Tue, 12 Jul 2022 14:51:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: qcom: fix typo in condition guarding
 resets
Message-ID: <20220712195137.GA790567@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707134552.2436442-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Applied for v5.20, thanks!

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
> -- 
> 2.35.1
> 
