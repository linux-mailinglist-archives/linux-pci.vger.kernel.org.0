Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFFA12A8EF
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2019 19:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfLYSyW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Dec 2019 13:54:22 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43311 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfLYSyW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Dec 2019 13:54:22 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id CF474240003;
        Wed, 25 Dec 2019 18:54:17 +0000 (UTC)
Date:   Wed, 25 Dec 2019 20:02:20 +0100
From:   Remi Pommarel <repk@triplefau.lt>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/5] dt-bindings: Add AXG PCIE PHY bindings
Message-ID: <20191225190220.GF7304@voidbox>
References: <20191224173942.18160-1-repk@triplefau.lt>
 <20191224173942.18160-6-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224173942.18160-6-repk@triplefau.lt>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 24, 2019 at 06:39:42PM +0100, Remi Pommarel wrote:
> Add documentation for PCIE PHYs found in AXG SoCs.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  .../bindings/phy/amlogic,meson-axg-pcie.yaml  | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
> new file mode 100644
> index 000000000000..c622a1b38ffc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/amlogic,meson-axg-pcie.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic AXG PCIE PHY
> +
> +maintainers:
> +  - Remi Pommarel <repk@triplefau.lt>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,axg-pcie-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  aml,hhi-gpr:
> +    maxItems: 1

My bad, I didn't know about devicetree schemas and their verification,
I will fix the missing $ref: '/schemas/types.yaml#/definitions/phandle'
here, add a description and add the missing include for reset in the
example below in v4 along with upcoming comments on the other patches.

Sorry about that.

> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: phy
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - aml,hhi-gpr
> +  - resets
> +  - reset-names
> +  - "#phy-cells"
> +
> +examples:
> +  - |
> +    pcie_phy: pcie-phy@ff644000 {
> +          compatible = "amlogic,axg-pcie-phy";
> +          reg = <0x0 0xff644000 0x0 0x2000>;
> +          aml,hhi-gpr = <&sysctrl>;
> +          resets = <&reset RESET_PCIE_PHY>;
> +          reset-names = "phy";
> +          #phy-cells = <0>;
> +    };
> -- 
> 2.24.0
> 
