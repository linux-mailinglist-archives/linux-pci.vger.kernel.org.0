Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BF973FE84
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 16:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjF0Olv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 10:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0Olu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 10:41:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F94D3583;
        Tue, 27 Jun 2023 07:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FF37611C5;
        Tue, 27 Jun 2023 14:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A701C433C0;
        Tue, 27 Jun 2023 14:41:15 +0000 (UTC)
Date:   Tue, 27 Jun 2023 20:11:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: PCI: qcom: ep: Add interconnects path
Message-ID: <20230627144105.GH5490@thinkpad>
References: <1687827692-6181-1-git-send-email-quic_krichai@quicinc.com>
 <1687827692-6181-2-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1687827692-6181-2-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 27, 2023 at 06:31:29AM +0530, Krishna chaitanya chundru wrote:
> Some platforms may not boot if a device driver doesn't
> initialize the interconnect path. Mostly it is handled
> by the bootloader but we have starting to see cases
> where bootloader simply ignores them.
> 
> Add the "pcie-mem" interconnect path as a required property
> to the bindings.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 8111122..bc32e13 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -71,6 +71,13 @@ properties:
>      description: GPIO used as WAKE# output signal
>      maxItems: 1
>  
> +  interconnects:
> +    maxItems: 1
> +
> +  interconnect-names:
> +    items:
> +      - const: pcie-mem
> +
>    resets:
>      maxItems: 1
>  
> @@ -98,6 +105,8 @@ required:
>    - interrupts
>    - interrupt-names
>    - reset-gpios
> +  - interconnects
> +  - interconnect-names
>    - resets
>    - reset-names
>    - power-domains
> @@ -167,7 +176,9 @@ examples:
>    - |
>      #include <dt-bindings/clock/qcom,gcc-sdx55.h>
>      #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interconnect/qcom,sdx55.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
>      pcie_ep: pcie-ep@1c00000 {
>          compatible = "qcom,sdx55-pcie-ep";
>          reg = <0x01c00000 0x3000>,
> @@ -194,6 +205,8 @@ examples:
>          interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
>                       <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
>          interrupt-names = "global", "doorbell";
> +        interconnects = <&system_noc MASTER_PCIE &mc_virt SLAVE_EBI_CH0>;
> +        interconnect-names = "pcie-mem";
>          reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
>          wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
>          resets = <&gcc GCC_PCIE_BCR>;
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
