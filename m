Return-Path: <linux-pci+bounces-36067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 400D3B559B4
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 00:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5BC5C033E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 22:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E032459EC;
	Fri, 12 Sep 2025 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsgNWuAR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45882DC789;
	Fri, 12 Sep 2025 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757717406; cv=none; b=KtOq8609OwqkACQZ6o1B6QCKqqy6Mh7DIn+ipE8lCsZy8qjooR+m174/xDh4Lsk8TVPTpk2l1MLTIWm7yaTt1az368jrAivbGfPCuN4RhwsjZB2RyPBgutDezSHrim/PEucqWZbl4KqqLTrBWSPPLTwIY14ez02ncquVwvuPsdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757717406; c=relaxed/simple;
	bh=llL5i4JcGr00lkqdNb+4OnrW+J9u96jdBnm9y/x4iE0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b7YqbUkH5ju0PEwKy/MnrgZcPqbF2BZg6pgwkutZaPFsyl2nc0elTVQVCGYEDgO1kYNR40AmUfcvdYwAHM3b2elFGRo2JkVfVVknhc4eu0MIiNuYehMAhhCynFSNNLEs6SxD7OcJD7auNyfCy0BgXaa0v71vS1l3jCWZ+gNn+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsgNWuAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2126EC4CEF5;
	Fri, 12 Sep 2025 22:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757717406;
	bh=llL5i4JcGr00lkqdNb+4OnrW+J9u96jdBnm9y/x4iE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EsgNWuARrB8BcekinBkI5ai0HtqFm7+m9JAImUPxyVHCAj6PzRC9xNX6lQJ/gdJq1
	 6Doz0yYnBsov5se3z9fEgFX9W2vMQOElUUPHwse7Lhkwv1F7UmAC+PGATMXT60aVYI
	 C3+rQd8b1aEwoxupU9QiG/rEjoA0WHKBKOLvWahuy5X31IfarZ9FNT2hTP2qff0guF
	 HkKsYcetOF0xC0927vl57tWDWWmUiFrJi3iq/J/5qCTaxeo24gWTTnJHUf+kRXSs45
	 axeNIxahq12skZOmqDrnq1WYO8YARqDzhRJqKoUvqV1CoJeFZI0XeMCR6HYgeABapY
	 1vhma/U2WUZcA==
Date: Fri, 12 Sep 2025 17:50:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
Message-ID: <20250912225004.GA1651547@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912141436.2347852-2-vincent.guittot@linaro.org>

On Fri, Sep 12, 2025 at 04:14:33PM +0200, Vincent Guittot wrote:
> Describe the PCIe controller available on the S32G platforms.
> 
> Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  .../devicetree/bindings/pci/nxp,s32-pcie.yaml | 169 ++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> new file mode 100644
> index 000000000000..287596d7162d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> @@ -0,0 +1,169 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/nxp,s32-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP S32G2xx/S32G3xx PCIe controller
> +
> +maintainers:
> +  - Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> +  - Ionut Vicovan <ionut.vicovan@nxp.com>
> +
> +description:
> +  This PCIe controller is based on the Synopsys DesignWare PCIe IP.
> +  The S32G SoC family has two PCIe controllers, which can be configured as
> +  either Root Complex or End Point.

s/End Point/Endpoint/ to match spec usage.

> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nxp,s32g2-pcie     # S32G2 SoCs RC mode
> +      - items:
> +          - const: nxp,s32g3-pcie
> +          - const: nxp,s32g2-pcie
> +
> +  reg:
> +    minItems: 7
> +    maxItems: 7
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: atu
> +      - const: dma
> +      - const: ctrl
> +      - const: config
> +      - const: addr_space
> +
> +  interrupts:
> +    minItems: 8
> +    maxItems: 8
> +
> +  interrupt-names:
> +    items:
> +      - const: link_req_stat
> +      - const: dma
> +      - const: msi
> +      - const: phy_link_down
> +      - const: phy_link_up
> +      - const: misc
> +      - const: pcs
> +      - const: tlp_req_no_comp
> +
> +  msi-parent:
> +    description:
> +      Use this option to reference the GIC controller node which will
> +      handle the MSIs. This property can be used only in Root Complex mode.
> +      The msi-parent node must be declared as "msi-controller" and the list of
> +      available SPIs that can be used must be declared using "mbi-ranges".
> +      If "msi-parent" is not present in the PCIe node, MSIs will be handled
> +      by iMSI-RX -Integrated MSI Receiver [AXI Bridge]-, an integrated
> +      MSI reception module in the PCIe controller's AXI Bridge which
> +      detects and terminates inbound MSI requests (received on the RX wire).
> +      These MSIs no longer appear on the AXI bus, instead a hard-wired
> +      interrupt is raised, documented as "DSP AXI MSI Interrupt" in the SoC
> +      Reference Manual.
> +
> +  nxp,phy-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: Select PHY mode for PCIe controller
> +    enum:
> +      - crns  # Common Reference Clock, No Spread Spectrum
> +      - crss  # Common Reference Clock, Spread Spectrum
> +      - srns  # Separate reference Clock, No Spread Spectrum
> +      - sris  # Separate Reference Clock, Independent Spread Spectrum
> +
> +  max-link-speed:
> +    description:
> +      The max link speed is normaly Gen3, but can be enforced to a lower value
> +      in case of special limitations.

s/normaly/normally/

But I doubt you need this here at all.

> +    maximum: 3
> +
> +  num-lanes:
> +    description:
> +      Max bus width (1 or 2); it is the number of physical lanes
> +    minimum: 1
> +    maximum: 2
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - ranges
> +  - nxp,phy-mode
> +  - num-lanes
> +  - phys
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/phy/phy.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie0: pcie@40400000 {
> +            compatible = "nxp,s32g3-pcie",
> +                         "nxp,s32g2-pcie";
> +            dma-coherent;
> +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> +                  /* RC configuration space, 4KB each for cfg0 and cfg1
> +                   * at the end of the outbound memory map
> +                   */
> +                  <0x5f 0xffffe000 0x0 0x00002000>,
> +                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr space */
> +                  reg-names = "dbi", "dbi2", "atu", "dma", "ctrl",
> +                              "config", "addr_space";
> +                  #address-cells = <3>;
> +                  #size-cells = <2>;
> +                  device_type = "pci";
> +                  ranges =
> +                  /* downstream I/O, 64KB and aligned naturally just
> +                   * before the config space to minimize fragmentation
> +                   */
> +                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> +                  /* non-prefetchable memory, with best case size and
> +                  * alignment
> +                   */
> +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
> +
> +                  nxp,phy-mode = "crns";
> +                  bus-range = <0x0 0xff>;
> +                  interrupts =  <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> +                  interrupt-names = "link_req_stat", "dma", "msi",
> +                                    "phy_link_down", "phy_link_up", "misc",
> +                                    "pcs", "tlp_req_no_comp";
> +                  #interrupt-cells = <1>;
> +                  interrupt-map-mask = <0 0 0 0x7>;
> +                  interrupt-map = <0 0 0 1 &gic 0 0 0 128 4>,
> +                                  <0 0 0 2 &gic 0 0 0 129 4>,
> +                                  <0 0 0 3 &gic 0 0 0 130 4>,
> +                                  <0 0 0 4 &gic 0 0 0 131 4>;
> +                  msi-parent = <&gic>;
> +
> +                  num-lanes = <2>;
> +                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;

num-lanes and phys are properties of a Root Port, not the host bridge.
Please put them in a separate stanza.  See this for details and
examples:

  https://lore.kernel.org/linux-pci/20250625221653.GA1590146@bhelgaas/

> +        };
> +    };
> -- 
> 2.43.0
> 

