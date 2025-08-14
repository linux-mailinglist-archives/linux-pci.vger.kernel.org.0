Return-Path: <linux-pci+bounces-34020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17091B2599C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 04:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EDF9A1744
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 02:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457A5237713;
	Thu, 14 Aug 2025 02:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="IP0lyHCv"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED32FF64F;
	Thu, 14 Aug 2025 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755139953; cv=none; b=Q0F4ezX8Z/DX2+LdlJK3+HTizTzwAQ31t2piOOfbxd3KtvDYI1jQvaC1ZxkAwhKTD9YX+e+iJmiqDbud4dlbkFZU5MQQmsp/rtobAOq2t/LQsWbg1D7Wm1dknm0D9V8wCspXkjjgTjc6duG7/IHZFQrTi5yi6Tb8PgMuxW8cRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755139953; c=relaxed/simple;
	bh=HTBR17vhoYZ8Fi2t2D3VIezhF9RyLF5ybAAkSkRGq8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/td9ifg0vjVWtEgiEfb4Us0TEvr5mJSvG286E54h6mIGjHEhQDequhDwRZ1LrqAhNqVi0xvk3/j71qJmIAxMp55UmXRxvKWU3/xaGuAg0nenx/0Sy+TX4iOJfPx30ZBfJ1NjMtMqdDZ3vLxrwjS/ZEExu0NVyykVsNKRHeuFAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=IP0lyHCv; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7B03E2524A;
	Thu, 14 Aug 2025 04:52:27 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cu1DZ5Gm8wiw; Thu, 14 Aug 2025 04:52:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755139946; bh=HTBR17vhoYZ8Fi2t2D3VIezhF9RyLF5ybAAkSkRGq8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IP0lyHCvPv+3+laZDJpARS5vDAKdwVsdhv8aZpJ5IvVRrvQM1z27khXbxpnj+zrMB
	 5HcafG2t4IiYPOLHc+fFm3/m3okPNtlifM+Dybdo6Tbb6qDXcejrXy+B9S/rtORe87
	 CFwCebY00Xoo9MC7aAAX7+Q6gKCFG5K5B5W8f+dnGNnkPPDpz2PT7s/gvNMf9CrcdA
	 Juphco4xYgVhAf4Uk/RQCMspBrS/y1vDm7KtATFNruZtsj1GjTrzhjobOW4G5mrFHy
	 erPVFeKHdD2DosHAtc+A7v8eDaX/bTg5ucv1Z4toHLO04pnCYWESuA/1XsVdBkaVQP
	 m1Zirohbl2zOA==
Date: Thu, 14 Aug 2025 02:52:03 +0000
From: Yao Zi <ziyao@disroot.org>
To: Alex Elder <elder@riscstar.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, bhelgaas@google.com, vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	tglx@linutronix.de, johan+linaro@kernel.org,
	thippeswamy.havalige@amd.com, namcao@linutronix.de,
	mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
	inochiama@gmail.com, quic_schintav@quicinc.com, fan.ni@samsung.com,
	devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: phy: spacemit: add SpacemiT PCIe/combo
 PHY
Message-ID: <aJ1PJBax-Pj983OZ@pie>
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

...

> +  spacemit,syscon-pmu:
> +    description:
> +      PHandle that refers to the APMU system controller, whose
> +      regmap is used in setting the mode
> +    $ref: /schemas/types.yaml#/definitions/phandle

Clock controllers and ethernet controllers all use spacemit,apmu to
refer the APMU system controller. Do you think it's better to keep them
aligned?

...

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
> +    combo_phy: phy@c0b10000 {

This label is unnecessary.

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

Best regards,
Yao Zi

