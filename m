Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D84659A25
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 16:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiL3PqL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 10:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3PqL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 10:46:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A3D1B9EF;
        Fri, 30 Dec 2022 07:46:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CF68B81B92;
        Fri, 30 Dec 2022 15:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC7CC433D2;
        Fri, 30 Dec 2022 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672415167;
        bh=2AVHoufg330kW2hssR4nmveKmkX70vDH6IXBOdzJ9fU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcruFRIUZkPRQHPXbnqaHB82Mo/IXsBbr1P+H1EZJz/ni784t42Bd6DF7dkcbXJrQ
         TpsU56Gff/NaVrtVvp234kLyCnZUHJGZcxKiVS7u+658/DHm2k07WG/fc+hWDbcSt6
         hG0huUfXoB9n/CuvFXE51jeuIykxhJyJeu3bujuNg3TJ932sk9GqA8+qi5VTfvgV+z
         nRmVooB6q5CvZbZQ2YpCuU7n3LYbqRPepCfH60y2da18RyS4aubs+jAQPpH2gC/H6L
         HNPcx76oaWPdWurtRnaCkHC0rFMtSin6nXmPBpE86Xm80SDKbYNHS5GLNDxlwvHi1q
         Egi7clqxVyIdg==
Date:   Fri, 30 Dec 2022 16:46:01 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhelgaas@google.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: qcom: Document msi-map and
 msi-map-mask properties
Message-ID: <Y68HucsiuX+/0DJa@lpieralisi>
References: <20221222133123.50676-1-manivannan.sadhasivam@linaro.org>
 <20221222133123.50676-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222133123.50676-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 22, 2022 at 07:01:22PM +0530, Manivannan Sadhasivam wrote:
> The Qcom PCIe controller is capable of using either internal MSI controller
> or the external GIC-ITS for receiving the MSIs from endpoint devices.

"For signaling MSIs sent by endpoint devices"

> Currently, the binding only documents the internal MSI implementation.
> 
> Let's document the GIC-ITS imeplementation by making use of msi-map and
> msi-map-mask properties. Only one of the implementation should be used
> at a time.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 02450fb26bb9..10fec6a7abfc 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -104,14 +104,20 @@ required:
>    - compatible
>    - reg
>    - reg-names
> -  - interrupts
> -  - interrupt-names
> -  - "#interrupt-cells"
>    - interrupt-map-mask
>    - interrupt-map
>    - clocks
>    - clock-names
>  
> +oneOf:
> +  - required:
> +      - interrupts
> +      - interrupt-names
> +      - "#interrupt-cells"
> +  - required:
> +      - msi-map
> +      - msi-map-mask
> +
>  allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
>    - if:
> -- 
> 2.25.1
> 
