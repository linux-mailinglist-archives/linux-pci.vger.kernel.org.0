Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2732D534C29
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 11:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbiEZJCA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 05:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbiEZJB7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 05:01:59 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8CD7E3C;
        Thu, 26 May 2022 02:01:53 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 May 2022 18:01:51 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id CC40320774D5;
        Thu, 26 May 2022 18:01:51 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 26 May 2022 18:01:51 +0900
Received: from [10.212.183.88] (unknown [10.212.183.88])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 60E5DB62E2;
        Thu, 26 May 2022 18:01:50 +0900 (JST)
Subject: Re: [PATCH] dt-bindings: PCI: socionext,uniphier-pcie: Add missing
 child interrupt controller
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220525210117.2489333-1-robh@kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <35c700f6-ce67-89d5-0f29-426acd33efa9@socionext.com>
Date:   Thu, 26 May 2022 18:01:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220525210117.2489333-1-robh@kernel.org>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 2022/05/26 6:01, Rob Herring wrote:
> The Socionext interrupt controller internal to the the PCI block isn't
> documented which causes warnings when unevaluatedProperties check is
> also fixed. Add the 'interrupt-controller' child node and properties and
> fixup the example so that interrupt properties can be parsed.

Surely internal interrupt controller isn't described, and should be documented.
And the child node name "legacy-interrupt-controller" also should be fixed.

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

BTW I can't reproduce such warnings with my environment.
Can you show the command line to reproduce the warnings?

Thank you,

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../bindings/pci/socionext,uniphier-pcie.yaml | 23 ++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> index f5926d0fb085..638b99db0433 100644
> --- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> @@ -51,6 +51,19 @@ properties:
>     phy-names:
>       const: pcie-phy
>   
> +  interrupt-controller:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      interrupt-controller: true
> +
> +      '#interrupt-cells':
> +        const: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
>   required:
>     - compatible
>     - reg
> @@ -62,6 +75,13 @@ unevaluatedProperties: false
>   
>   examples:
>     - |
> +    bus {
> +        gic: interrupt-controller {
> +            interrupt-controller;
> +            #interrupt-cells = <3>;
> +        };
> +    };
> +
>       pcie: pcie@66000000 {
>           compatible = "socionext,uniphier-pcie";
>           reg-names = "dbi", "link", "config";
> @@ -80,6 +100,7 @@ examples:
>           phys = <&pcie_phy>;
>           #interrupt-cells = <1>;
>           interrupt-names = "dma", "msi";
> +        interrupt-parent = <&gic>;
>           interrupts = <0 224 4>, <0 225 4>;
>           interrupt-map-mask = <0 0 0  7>;
>           interrupt-map = <0 0 0  1  &pcie_intc 0>,
> @@ -87,7 +108,7 @@ examples:
>                           <0 0 0  3  &pcie_intc 2>,
>                           <0 0 0  4  &pcie_intc 3>;
>   
> -        pcie_intc: legacy-interrupt-controller {
> +        pcie_intc: interrupt-controller {
>               interrupt-controller;
>               #interrupt-cells = <1>;
>               interrupt-parent = <&gic>;
> 

---
Best Regards
Kunihiko Hayashi
