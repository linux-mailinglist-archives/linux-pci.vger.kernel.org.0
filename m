Return-Path: <linux-pci+bounces-34073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8594B27066
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 22:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E346B1CC76F6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B2273805;
	Thu, 14 Aug 2025 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVn6XjXk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E31272E5E;
	Thu, 14 Aug 2025 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204689; cv=none; b=HqY4lDNgWdqDualnWsO6jgPRAr+0+lzUktzUclxDymL7RXl3KAJ4/AZxSZqLTo7nW/QI3vufY8WNwySmWXqsjf9+I0FIGjKxTkLk2l7aDuEIB3alUxCtNOevg1wxQbFUfmSZvAlM9BbbQgtz96DACYluXt9A8xi/OTO6cdcJulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204689; c=relaxed/simple;
	bh=/M4EE7DFqLJynRJpaxxdZKYC5XpUZmPw2hnoERrqOp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trxHumNqpy+5TsUC7MpgI7bcbTC8iaahL2ylnXGGXLC8aCM5hDqk6gOeykn/ISCpYcTRpxOHOeUgIrESjcAam7lLCTjSzLYERjMZyN3w9kp1Vn6Ixo6X8syyn3mxjSYIdvCzsm1pwKShGXWcCR4ZiFnQLwqZr27MUY8TkQZU+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVn6XjXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC8DC4CEED;
	Thu, 14 Aug 2025 20:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755204689;
	bh=/M4EE7DFqLJynRJpaxxdZKYC5XpUZmPw2hnoERrqOp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OVn6XjXkVgHKX31q8ZfXo7rw69ZgSzBWspUWLyQB3kVd5itiTtfuFBvXWGnEPnlNH
	 cVN536Wy1xooiv/AYneWTv9Q1ftQuxJwOsji2f0HR8OBJ3knOX5kA2oPTBPIlfuEiY
	 hoLmiMQT02eO2M5fA8wpc51tUbPMp3nhwTv5nNrrU8nlyOnwzE07HQw/oFHowNr1Ce
	 LsaGcLzhbszy3+41SAnLDDpj8Fg+yqCAOstZmhjsz8TZbcXoBGmQut9q9oBGGQvpMa
	 J8tXi/RpjBlBTOcbcf2W7NwGGej/V0cUSamfgSLYgWWks1TgKjA3eNht+rxAJPSdFv
	 iGooIKvdVXTvg==
Date: Thu, 14 Aug 2025 15:51:28 -0500
From: Rob Herring <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com,
	vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, p.zabel@pengutronix.de, tglx@linutronix.de,
	johan+linaro@kernel.org, thippeswamy.havalige@amd.com,
	namcao@linutronix.de, mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com, inochiama@gmail.com,
	quic_schintav@quicinc.com, fan.ni@samsung.com,
	devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: phy: spacemit: add SpacemiT PCIe/combo
 PHY
Message-ID: <20250814205128.GA3873683-robh@kernel.org>
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813184701.2444372-2-elder@riscstar.com>

On Wed, Aug 13, 2025 at 01:46:55PM -0500, Alex Elder wrote:
> Add the Device Tree binding for the PCIe/USB 3.0 combo PHY found in
> the SpacemiT K1 SoC.  This is one of three PCIe PHYs, and is unusual
> in that only the combo PHY can perform a calibration step needed to
> determine settings used by the other two PCIe PHYs.
> 
> Calibration must be done with the combo PHY in PCIe mode, and to allow
> this to occur independent of the eventual use for the PHY (PCIe or USB)
> some PCIe-related properties must be supplied: clocks; resets; and a
> syscon phandle.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../bindings/phy/spacemit,k1-combo-phy.yaml   | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml b/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
> new file mode 100644
> index 0000000000000..ed78083a53231
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/spacemit,k1-combo-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SpacemiT K1 PCIe/USB3 Combo PHY
> +
> +maintainers:
> +  - Alex Elder <elder@riscstar.com>
> +
> +description:

You need a '>' or the paragraphs formatting will not be maintained 
(should we ever render docs from this).

> +  Of the three PHYs on the SpacemiT K1 SoC capable of being used for
> +  PCIe, one is a combo PHY that can also be configured for use by a
> +  USB 3 controller.  Using PCIe or USB 3 is a board design decision.
> +
> +  The combo PHY is also the only PCIe PHY that is able to determine
> +  PCIe calibration values to use, and this must be determined before
> +  the other two PCIe PHYs can be used.  This calibration must be
> +  performed with the combo PHY in PCIe mode, and is this is done
> +  when the combo PHY is probed.
> +
> +  During normal operation, the PCIe or USB port driver is responsible
> +  for ensuring all clocks needed by a PHY are enabled, and all resets
> +  affecting the PHY are deasserted.  However, for the combo PHY to
> +  perform calibration independent of whether it's later used for
> +  PCIe or USB, all PCIe mode clocks and resets must be defined.
> +
> +properties:
> +  compatible:
> +    const: spacemit,k1-combo-phy
> +
> +  reg:
> +    items:
> +      - description: PHY control registers
> +
> +  clocks:
> +    items:
> +      - description: DWC PCIe Data Bus Interface (DBI) clock
> +      - description: DWC PCIe application AXI-bus Master interface clock
> +      - description: DWC PCIe application AXI-bus Slave interface clock.

End with a period or don't. Just be consistent.

You need DWC PCIe clocks for your PHY? A ref clock would make sense, but 
these? I've never seen a PHY with a AXI master interface.

> +
> +  clock-names:
> +    items:
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +
> +  resets:
> +    items:
> +      - description: DWC PCIe Data Bus Interface (DBI) reset
> +      - description: DWC PCIe application AXI-bus Master interface reset
> +      - description: DWC PCIe application AXI-bus Slave interface reset.

Same here (on both points).

> +      - description: Global reset; must be deasserted for PHY to function
> +
> +  reset-names:
> +    items:
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +      - const: global
> +
> +  spacemit,syscon-pmu:
> +    description:
> +      PHandle that refers to the APMU system controller, whose
> +      regmap is used in setting the mode
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  "#phy-cells":
> +    const: 1
> +    description:
> +      The argument value (PHY_TYPE_PCIE or PHY_TYPE_USB3) determines
> +      whether the PHY operates in PCIe or USB3 mode.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - spacemit,syscon-pmu
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
> +    combo_phy: phy@c0b10000 {

Drop unused labels.

> +        compatible = "spacemit,k1-combo-phy";
> +        reg = <0xc0b10000 0x1000>;
> +        clocks = <&syscon_apmu CLK_PCIE0_DBI>,
> +                 <&syscon_apmu CLK_PCIE0_MASTER>,
> +                 <&syscon_apmu CLK_PCIE0_SLAVE>;
> +        clock-names = "dbi",
> +                      "mstr",
> +                      "slv";
> +        resets = <&syscon_apmu RESET_PCIE0_DBI>,
> +                 <&syscon_apmu RESET_PCIE0_MASTER>,
> +                 <&syscon_apmu RESET_PCIE0_SLAVE>,
> +                 <&syscon_apmu RESET_PCIE0_GLOBAL>;
> +        reset-names = "dbi",
> +                      "mstr",
> +                      "slv",
> +                      "global";
> +        spacemit,syscon-pmu = <&syscon_apmu>;
> +        #phy-cells = <1>;
> +        status = "disabled";
> +    };
> -- 
> 2.48.1
> 

