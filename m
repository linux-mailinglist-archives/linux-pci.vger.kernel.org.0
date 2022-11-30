Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EC863DC94
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 19:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiK3SC2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 13:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiK3SC1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 13:02:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2BE2EF68;
        Wed, 30 Nov 2022 10:02:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70A82B81C5E;
        Wed, 30 Nov 2022 18:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22A3C433C1;
        Wed, 30 Nov 2022 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669831344;
        bh=PxN7ZdJLfEd8pxwZrcru/DKCXudV+wCmunE5yEOkGuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YauE7EA6ZdEw8pk2kkZhXdBqBb67P3YatKxmq2WFv3K8imgh1iIsOnCAdmx+v3QSu
         aXf8foT6dZlXJCjEE9HJecjlAdb0R1UUz7cbOkcxhv5NXYX7pct1HCg3PrKij2lVND
         XsAZdPCH8StZ3tJMOgUuHOpNleDs7mXOj6Ew45EyizoWU8sQl9Jsdgg2NXcGBUexTL
         VSSaWuubS9RbSgDb3HnhXLxXnxhlWUJkR8KXkBZwVmqAeTwZvyzLMt9R2qtN21+aN7
         uJJIAW2ghpc05c7uLOYyhA2Oli5SXkQCFpLBAWf+au1mJO3674/llPCEdOKU5mWc3I
         Q9/J3nATFkHQQ==
Date:   Wed, 30 Nov 2022 23:32:16 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom-ep: Fix PERST register description
Message-ID: <20221130180216.GA41385@thinkpad>
References: <20221018093115.7537-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221018093115.7537-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 18, 2022 at 11:31:15AM +0200, Johan Hovold wrote:
> The 'qcom,perst-regs' property holds a single phandle array with the
> phandle of the TCSR syscon and offsets of the two PERST registers, but
> the current schema does not capture this.
> 
> Update the binding to describe the single phandle array and its three
> elements.
> 
> Fixes: 31c9ef002580 ("dt-bindings: PCI: Add Qualcomm PCIe Endpoint controller")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml          | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 977c976ea799..7574291646ad 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -42,13 +42,13 @@ properties:
>      maxItems: 8
>  
>    qcom,perst-regs:
> -    description: Reference to a syscon representing TCSR followed by the two
> -                 offsets within syscon for Perst enable and Perst separation
> -                 enable registers
> +    description: PERST TCSR registers
>      $ref: "/schemas/types.yaml#/definitions/phandle-array"
>      items:
> -      minItems: 3
> -      maxItems: 3
> +      - items:
> +          - description: phandle of TCSR syscon
> +          - description: offset of PERST Enable register
> +          - description: offset of PERST Separation Enable register
>  
>    interrupts:
>      items:
> -- 
> 2.37.3
> 

-- 
மணிவண்ணன் சதாசிவம்
