Return-Path: <linux-pci+bounces-38232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 911E9BDF2B7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 800C84EFC78
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392E2D46D9;
	Wed, 15 Oct 2025 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riF91sar"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32832D239A;
	Wed, 15 Oct 2025 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539939; cv=none; b=ZcG/DeiGBXDpKnx3Qvhpz2db4CB0yHGvjDofSOCJDw66G0S0e0XtrsQZc1NYzzqCxYpDa0rmf7QmZdszO1HWsuN1SVCzKIZj6E6Yp1cMhdeZk7ijd4dIYTbAUlMtSzjlSxoUYtZgFqzxHnn9DVWggE1w9l+634gj0LHCfBhZrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539939; c=relaxed/simple;
	bh=ADw0XbUINFXw+99thMlJyEEKMXz1G33Y6Fyz/udOs7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLXBmkdJXF9iOrPDJMs2OMQGpnUMRdhLEL00+chcw/Us7xg22t2Q+B8KR8AUtRV9B7RdzKXO1kwIOk3x/DXxo4N8Exavw8I9pPRL6vZf8CVPMZtYL6VN3FLS9emcdCCgb/9VSe56+b45O69WEkey6rf2TvW1eJzK8XGOWzPfE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riF91sar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F48AC4CEF8;
	Wed, 15 Oct 2025 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760539939;
	bh=ADw0XbUINFXw+99thMlJyEEKMXz1G33Y6Fyz/udOs7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=riF91sarHuoK7t4am2+p5dxxUbrgULuYBx2SVwAhxTpeD1NYtB46wNTalCGGwGWtq
	 iHehp0VZnF2Ufr7jLAGIAUtAvlIFvJJa/4tuGo91bGJW4oYsm3B2uy8XWD+244DvCH
	 k0ST8OCUPYfPGyFRe5boeRN1qFELPWzIXSWbsA+dRgf5o3t/9hB635UTAwt2RbPioF
	 yZXJqHqdBaB4x2KSdwbzTH21133KVuVRbeGdsKpqMDdF4RO+5OJZgSzFl2+CZthuXX
	 Caal7DGqDslWIEWXwJSuXV+kntKZi8z5IYayeXfNHvp6JjWA/6kA9jvXUqY7qVvzsN
	 iFttDi/Vu7gGA==
Date: Wed, 15 Oct 2025 09:52:17 -0500
From: Rob Herring <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	christian.bruel@foss.st.com, shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
	namcao@linutronix.de, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: phy: spacemit: add SpacemiT
 PCIe/combo PHY
Message-ID: <20251015145217.GA3554740-robh@kernel.org>
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013153526.2276556-2-elder@riscstar.com>

On Mon, Oct 13, 2025 at 10:35:18AM -0500, Alex Elder wrote:
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
> v2: - Added '>' to the description, and reworded it a bit
>     - Added an external oscillator clock, "refclk"
>     - Renamed the "global" reset to be "phy"
>     - Renamed a phandle property to be "spacemit,apmu"
>     - Dropped the label and status property from the example
> 
>  .../bindings/phy/spacemit,k1-combo-phy.yaml   | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml b/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
> new file mode 100644
> index 0000000000000..6e2f401b0ac27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
> @@ -0,0 +1,114 @@
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
> +description: >
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
> +  The combo PHY uses an external oscillator as a reference clock.
> +  During normal operation, the PCIe or USB port driver is responsible
> +  for ensuring all other clocks needed by a PHY are enabled, and all
> +  resets affecting the PHY are deasserted.  However, for the combo
> +  PHY to perform calibration independent of whether it's later used
> +  for PCIe or USB, all PCIe mode clocks and resets must be defined.
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
> +      - description: External oscillator used by the PHY PLL
> +      - description: DWC PCIe Data Bus Interface (DBI) clock
> +      - description: DWC PCIe application AXI-bus Master interface clock
> +      - description: DWC PCIe application AXI-bus slave interface clock
> +
> +  clock-names:
> +    items:
> +      - const: refclk
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +
> +  resets:
> +    items:
> +      - description: DWC PCIe Data Bus Interface (DBI) reset
> +      - description: DWC PCIe application AXI-bus Master interface reset
> +      - description: DWC PCIe application AXI-bus slave interface reset
> +      - description: PHY reset; must be deasserted for PHY to function
> +
> +  reset-names:
> +    items:
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +      - const: phy

I think phy should be first as that's the main one to the phy and the 
others are somewhat questionable. Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

