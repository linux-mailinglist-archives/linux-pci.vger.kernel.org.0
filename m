Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73BA614CC4
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 15:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKAOiK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiKAOiJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 10:38:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FC51C11E;
        Tue,  1 Nov 2022 07:38:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A01B1B81DE9;
        Tue,  1 Nov 2022 14:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C9BC433D6;
        Tue,  1 Nov 2022 14:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313484;
        bh=kXIES3fUfmzO3HJbLiS5y/Jt0Jn+5tsME6+CcibsmBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nd1RzC5/4V/HY9n0QcSbWzhxKVyETUTh38ZBhXbEnOWbpZhO29Rmq+sL7CocZvXRC
         zypQa7TxV9+aLi3m6Z2GARHHVNvKl3bwYMZ9v58iXCVFJsYKvfKOpuhz3urtn7kXoE
         7M5T2ud/lwVlkEdSG23H4F7D6PKdSfqGeZgB3zwLVeyZshHnLfzrKCkuhlbs2ipr2L
         ryf/Utxx4mtmS2ezTwmkgvQTtqdPck1QDq5DTCr7dIAMhdAAsEC1+LoWZ4JRJyjKOy
         rwv3BT4M/NMHcrInbaKq26Jxt3z3Ra+vBGmYK5qQ2giDt+5n2EKJiDn/ARD4XY8iUG
         pCilnbJq8Z1lQ==
Date:   Tue, 1 Nov 2022 20:07:49 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        quic_vbadigan@quicinc.com, Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom: Add SC8280XP/SA8540P
 interconnects
Message-ID: <20221101143749.GB244012@thinkpad>
References: <20221021064616.6380-1-johan+linaro@kernel.org>
 <20221021064616.6380-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221021064616.6380-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 21, 2022 at 08:46:15AM +0200, Johan Hovold wrote:
> Add the missing SC8280XP/SA8540P "pcie-mem" and "cpu-pcie" interconnect
> paths to the bindings.
> 
> Fixes: 76d777ae045e ("dt-bindings: PCI: qcom: Add SC8280XP to binding")
> Fixes: 76c4207f4085 ("dt-bindings: PCI: qcom: Add SA8540P to binding")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani 

> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 54f07852d279..2f851c804bb0 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -62,6 +62,14 @@ properties:
>      minItems: 3
>      maxItems: 13
>  
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: pcie-mem
> +      - const: cpu-pcie
> +
>    resets:
>      minItems: 1
>      maxItems: 12
> @@ -631,6 +639,18 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sa8540p
> +              - qcom,pcie-sc8280xp
> +    then:
> +      required:
> +        - interconnects
> +        - interconnect-names
> +
>    - if:
>        not:
>          properties:
> -- 
> 2.37.3
> 

-- 
மணிவண்ணன் சதாசிவம்
