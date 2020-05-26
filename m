Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C071E22F7
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 15:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgEZNfA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 09:35:00 -0400
Received: from foss.arm.com ([217.140.110.172]:50816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgEZNe7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 09:34:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C24351FB;
        Tue, 26 May 2020 06:34:58 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DF703F6C4;
        Tue, 26 May 2020 06:34:57 -0700 (PDT)
Date:   Tue, 26 May 2020 14:34:50 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        robh+dt@kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: Add UniPhier PCIe endpoint
 controller description
Message-ID: <20200526133450.GA24169@e121166-lin.cambridge.arm.com>
References: <1589457801-12796-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1589457801-12796-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589457801-12796-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 14, 2020 at 09:03:20PM +0900, Kunihiko Hayashi wrote:
> Add DT bindings for PCIe controller implemented in UniPhier SoCs
> when configured in endpoint mode. This controller is based on
> the DesignWare PCIe core.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/pci/socionext,uniphier-pcie-ep.yaml   | 92 ++++++++++++++++++++++
>  MAINTAINERS                                        |  2 +-
>  2 files changed, 93 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml

Hi Rob,

are you OK with this patch ? Please let me know, I'd like to pull
the series, thanks.

Lorenzo

> diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
> new file mode 100644
> index 0000000..f0558b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/socionext,uniphier-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Socionext UniPhier PCIe endpoint controller
> +
> +description: |
> +  UniPhier PCIe endpoint controller is based on the Synopsys DesignWare
> +  PCI core. It shares common features with the PCIe DesignWare core and
> +  inherits common properties defined in
> +  Documentation/devicetree/bindings/pci/designware-pcie.txt.
> +
> +maintainers:
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +allOf:
> +  - $ref: "pci-ep.yaml#"
> +
> +properties:
> +  compatible:
> +    const: socionext,uniphier-pro5-pcie-ep
> +
> +  reg:
> +    maxItems: 4
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: link
> +      - const: addr_space
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: gio
> +      - const: link
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: gio
> +      - const: link
> +
> +  num-ib-windows:
> +    const: 16
> +
> +  num-ob-windows:
> +    const: 16
> +
> +  num-lanes: true
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: pcie-phy
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pcie_ep: pcie-ep@66000000 {
> +        compatible = "socionext,uniphier-pro5-pcie-ep";
> +        reg-names = "dbi", "dbi2", "link", "addr_space";
> +        reg = <0x66000000 0x1000>, <0x66001000 0x1000>,
> +              <0x66010000 0x10000>, <0x67000000 0x400000>;
> +        clock-names = "gio", "link";
> +        clocks = <&sys_clk 12>, <&sys_clk 24>;
> +        reset-names = "gio", "link";
> +        resets = <&sys_rst 12>, <&sys_rst 24>;
> +        num-ib-windows = <16>;
> +        num-ob-windows = <16>;
> +        num-lanes = <4>;
> +        phy-names = "pcie-phy";
> +        phys = <&pcie_phy>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92657a1..7f26748 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13211,7 +13211,7 @@ PCIE DRIVER FOR SOCIONEXT UNIPHIER
>  M:	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/pci/uniphier-pcie.txt
> +F:	Documentation/devicetree/bindings/pci/uniphier-pcie*
>  F:	drivers/pci/controller/dwc/pcie-uniphier.c
>  
>  PCIE DRIVER FOR ST SPEAR13XX
> -- 
> 2.7.4
> 
