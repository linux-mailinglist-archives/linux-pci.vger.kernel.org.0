Return-Path: <linux-pci+bounces-36098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C92B0B568AA
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 14:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FD03A7F79
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 12:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD76238C0D;
	Sun, 14 Sep 2025 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOgSdU8A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD692AF00
	for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757853329; cv=none; b=EwtOaGu2qITVD7CmMrn0WLfAc6NLN9M+3H5X1VugKGIKJpToORXBUHFVISfVv587yDt1DO/B1ofowl6HMQojgQNWklorBuAxA1xG9G1GFevk/jPKufS4HYGZowF+j/Ejc6oGSR2HhkGThLdHyXYhYepzwh3NeufCbKvVkVvEo/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757853329; c=relaxed/simple;
	bh=0l6e2uz7dqK5Bhp1JeqeKMsK5CGH7BCCZfsnejEoWKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZStOudedGmUU3+k6cLiDYBJZGfrFVAABEwBQD7C8c+n6Xg1TqXBSRCB3WMewRZaoXiBPC1iRcBUTj7vMZ0cQ0ueE307hM+nhKPvGJFk1nXN7yfjkWiQn3zZxdq3kl0Xmmea93P4sDQZkuH2fCDjNsyUGw5fEQbLWtX2ZdzD+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VOgSdU8A; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so6320158a12.3
        for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 05:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757853326; x=1758458126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kZRPj8VFGD82gxi1pIqE3YbUy5FZEodVqHSWuZV8rz0=;
        b=VOgSdU8ACJX8+GwT8wweNQs4EZmPaW0/l89tUleAVU9mrfsZIxaXat1IGUNeM1cyW1
         YAZu7c8tabOyxQMFPLq4nqJeelRoMAyvKA7Q4xa7A5LUMOZ7HyIVPzK5mhm7lKMiaGgp
         mZrsQbsK1KJIlCIug1oIgF/BltVBY9DnyNv5UY/SvcHfQ8ZPJaArtSxB2uWTfI/S6Kji
         rPU0nA4lKr8z7IsyXgxjWNQP3VIixvyIkRiWO36eOq5GRh9f4gpmhpsE2jeQgTtiKaSj
         axsIoRaiwMQwnmguX6JEX2Yd+hkLSVy6hhiwvgp3jLP5qmc+918Jsd+aNZ7zVD/LpyYm
         HijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757853326; x=1758458126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZRPj8VFGD82gxi1pIqE3YbUy5FZEodVqHSWuZV8rz0=;
        b=B8kB/aibxgKY3hokcxtRFxEIXnqTOlN17+Dj6OTfwWjIQYuh8mEGR3spYVOugYK/yd
         +msSeP+w8Ooenf/xT9k0Q0sgAgifKZxlTNE/pqQ/ynL4e/nFynCbKXJ35BS3T5C+PpBB
         x4ItVs2sP9EuJ9iVdHFmV0KBZiKECZYGIr7WCnbI+LQ4pAbSdGOc4719SjA5Vcs3Lt6z
         L57/r//6EXp6V9tIiePbIM9m9sxHmLtgf8xwLS6vQq+cSrkWgy/HSE0ii6SxFC7zFrDw
         rIz0EU54QyhXhS9is3JK8CjHSGAbluQOPG9Sdl5aQls3syExMv/X4HM5eYRxO7vPOnlq
         a2vA==
X-Forwarded-Encrypted: i=1; AJvYcCVPLKbnxtRMsh1aXKJ2W8vJ8CsVNJyTPDgTSjhsZk27g360l9Ny8Vvv2ul1nn9nhzP2MldWu1Je3Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6eC1Jmj/roi6buevY2GSQaHFoGzZyw5gC4Tae4ymHTn2OnIR4
	fHtFMvR+NfoR0zHlb5Cd3PPcJChVtVO5P/6XLF3RounyX/5QiBMuzKbHBg3xKvn6zdq9qXVil6K
	J2SkKmcSNgJ6jI7YQeRfMmF0cQg9RF1xtvDrlyq9pxA==
X-Gm-Gg: ASbGnctwTtLL7lmdnG6ovdnkyrpvywZubvTpJH93VHZYE+qe0GsgYfCJmIWeziuQeyq
	HI8+9venBDiIacKpkwZSmKY0Flkx7tiHBo8dHD3BWChMPQIlrDLxTYGZ81Xli+Prl6J8qji43v2
	6DhtrLxdQ+Sv6wSzEhMUdWBHSKsqXhtIj2syvgLMTulEYcqVnX7bDl3GKQjTxCILtcbR5nrYatQ
	KWGZHIHhQyze/25fdCrT913GMWGqLlIVgUW63gnAGZe42M=
X-Google-Smtp-Source: AGHT+IGC5U6e2Dn1tMsLyF18gYUHRa22VodbP73NxQ0EqXqogritItpRUDjrhDJduFW7Qc87Fq6Zc0iIgGpKneFSjR0=
X-Received: by 2002:a05:6402:390c:b0:628:6af4:595 with SMTP id
 4fb4d7f45d1cf-62ed82fc9f7mr8593311a12.20.1757853326146; Sun, 14 Sep 2025
 05:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912141436.2347852-2-vincent.guittot@linaro.org> <20250912225004.GA1651547@bhelgaas>
In-Reply-To: <20250912225004.GA1651547@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 14 Sep 2025 14:35:14 +0200
X-Gm-Features: Ac12FXzoBnTdY1zYFeG3eA1G823XRIjgcnE5BClULnG3hfvuq5oVWCbfskuc7HM
Message-ID: <CAKfTPtCfjJ8-30aAeEyigeLyuKtTq+k6PQg+5w4-0Wa7pduZvg@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Sept 2025 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Sep 12, 2025 at 04:14:33PM +0200, Vincent Guittot wrote:
> > Describe the PCIe controller available on the S32G platforms.
> >
> > Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> > Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> > Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> > Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> > Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  .../devicetree/bindings/pci/nxp,s32-pcie.yaml | 169 ++++++++++++++++++
> >  1 file changed, 169 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> > new file mode 100644
> > index 000000000000..287596d7162d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
> > @@ -0,0 +1,169 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/nxp,s32-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP S32G2xx/S32G3xx PCIe controller
> > +
> > +maintainers:
> > +  - Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> > +  - Ionut Vicovan <ionut.vicovan@nxp.com>
> > +
> > +description:
> > +  This PCIe controller is based on the Synopsys DesignWare PCIe IP.
> > +  The S32G SoC family has two PCIe controllers, which can be configured as
> > +  either Root Complex or End Point.
>
> s/End Point/Endpoint/ to match spec usage.

Ok

>
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - nxp,s32g2-pcie     # S32G2 SoCs RC mode
> > +      - items:
> > +          - const: nxp,s32g3-pcie
> > +          - const: nxp,s32g2-pcie
> > +
> > +  reg:
> > +    minItems: 7
> > +    maxItems: 7
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: dbi2
> > +      - const: atu
> > +      - const: dma
> > +      - const: ctrl
> > +      - const: config
> > +      - const: addr_space
> > +
> > +  interrupts:
> > +    minItems: 8
> > +    maxItems: 8
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: link_req_stat
> > +      - const: dma
> > +      - const: msi
> > +      - const: phy_link_down
> > +      - const: phy_link_up
> > +      - const: misc
> > +      - const: pcs
> > +      - const: tlp_req_no_comp
> > +
> > +  msi-parent:
> > +    description:
> > +      Use this option to reference the GIC controller node which will
> > +      handle the MSIs. This property can be used only in Root Complex mode.
> > +      The msi-parent node must be declared as "msi-controller" and the list of
> > +      available SPIs that can be used must be declared using "mbi-ranges".
> > +      If "msi-parent" is not present in the PCIe node, MSIs will be handled
> > +      by iMSI-RX -Integrated MSI Receiver [AXI Bridge]-, an integrated
> > +      MSI reception module in the PCIe controller's AXI Bridge which
> > +      detects and terminates inbound MSI requests (received on the RX wire).
> > +      These MSIs no longer appear on the AXI bus, instead a hard-wired
> > +      interrupt is raised, documented as "DSP AXI MSI Interrupt" in the SoC
> > +      Reference Manual.
> > +
> > +  nxp,phy-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: Select PHY mode for PCIe controller
> > +    enum:
> > +      - crns  # Common Reference Clock, No Spread Spectrum
> > +      - crss  # Common Reference Clock, Spread Spectrum
> > +      - srns  # Separate reference Clock, No Spread Spectrum
> > +      - sris  # Separate Reference Clock, Independent Spread Spectrum
> > +
> > +  max-link-speed:
> > +    description:
> > +      The max link speed is normaly Gen3, but can be enforced to a lower value
> > +      in case of special limitations.
>
> s/normaly/normally/
>
> But I doubt you need this here at all.

I'm going to remove the description

>
> > +    maximum: 3
> > +
> > +  num-lanes:
> > +    description:
> > +      Max bus width (1 or 2); it is the number of physical lanes
> > +    minimum: 1
> > +    maximum: 2
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - ranges
> > +  - nxp,phy-mode
> > +  - num-lanes
> > +  - phys
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/phy/phy.h>
> > +
> > +    bus {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        pcie0: pcie@40400000 {
> > +            compatible = "nxp,s32g3-pcie",
> > +                         "nxp,s32g2-pcie";
> > +            dma-coherent;
> > +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> > +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> > +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> > +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> > +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> > +                  /* RC configuration space, 4KB each for cfg0 and cfg1
> > +                   * at the end of the outbound memory map
> > +                   */
> > +                  <0x5f 0xffffe000 0x0 0x00002000>,
> > +                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr space */
> > +                  reg-names = "dbi", "dbi2", "atu", "dma", "ctrl",
> > +                              "config", "addr_space";
> > +                  #address-cells = <3>;
> > +                  #size-cells = <2>;
> > +                  device_type = "pci";
> > +                  ranges =
> > +                  /* downstream I/O, 64KB and aligned naturally just
> > +                   * before the config space to minimize fragmentation
> > +                   */
> > +                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> > +                  /* non-prefetchable memory, with best case size and
> > +                  * alignment
> > +                   */
> > +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
> > +
> > +                  nxp,phy-mode = "crns";
> > +                  bus-range = <0x0 0xff>;
> > +                  interrupts =  <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> > +                  interrupt-names = "link_req_stat", "dma", "msi",
> > +                                    "phy_link_down", "phy_link_up", "misc",
> > +                                    "pcs", "tlp_req_no_comp";
> > +                  #interrupt-cells = <1>;
> > +                  interrupt-map-mask = <0 0 0 0x7>;
> > +                  interrupt-map = <0 0 0 1 &gic 0 0 0 128 4>,
> > +                                  <0 0 0 2 &gic 0 0 0 129 4>,
> > +                                  <0 0 0 3 &gic 0 0 0 130 4>,
> > +                                  <0 0 0 4 &gic 0 0 0 131 4>;
> > +                  msi-parent = <&gic>;
> > +
> > +                  num-lanes = <2>;
> > +                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
>
> num-lanes and phys are properties of a Root Port, not the host bridge.
> Please put them in a separate stanza.  See this for details and
> examples:
>
>   https://lore.kernel.org/linux-pci/20250625221653.GA1590146@bhelgaas/

Ok, I'm going to have a look

>
> > +        };
> > +    };
> > --
> > 2.43.0
> >

