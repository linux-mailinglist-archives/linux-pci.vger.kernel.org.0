Return-Path: <linux-pci+bounces-29958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CC9ADDA32
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 19:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C79617A7CD
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075AF2FA654;
	Tue, 17 Jun 2025 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlC18b1v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118A2FA62D;
	Tue, 17 Jun 2025 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179889; cv=none; b=R5O5QIgG8m2dW1/v+L9DpGIkh1gGEJO7bop/w/rR3rhdSEwG1Eo2bnBbbzKf9HySuu7ZCV5U8uPqsMYlcU9Rt+o6ZSK95zbZYJG/44r6eMtpdTWIkoE3NR9AY3ux2fSatbMJ2JamQae9W2NwXpTafQVywSyOL0+3jSpzDbDeobs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179889; c=relaxed/simple;
	bh=AZZ54kpbaOyDLy+/ubXOlw8lKqafcE1tTXmUjCQGWkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elp8Fubyv97lO9R1JJsPIYidfrzIMhVH96u5n8nCeHPzqFR6zxeL8c46tL0QmIG6iqHVa3Io11AlYrThcK2+cInJVHlXtgirUZZUvH8b9S5opldwD1E42i80ILgZQnXcMDICh+woRuH+y+/HRTf6hIWfdpO+jAY2teB65ynp/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlC18b1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98668C4CEE7;
	Tue, 17 Jun 2025 17:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750179889;
	bh=AZZ54kpbaOyDLy+/ubXOlw8lKqafcE1tTXmUjCQGWkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlC18b1vd0B4fVN9w5YHP3iWoS2zcaCPsljwmcoX3+nufojAu9ux9GD648NXkZ6Xu
	 ykGAkZdR8/9deA/XSWZvkRsvZMHP9KSlCRFc7zhzxvC1bxom2VpbDB6SDUPtoY96rP
	 reXO92NmQ1FCVKBDLdrlkPvGpNS9uvnANRnhC1oTjEULrVggTIxfBYqH2vfhL5uQ8e
	 pzVR8TAqhfQYn1E6XZUb90/p15T5/SHj5DbMyDKjzRmLcX1sKORaVX5dd6DEcFuPJ6
	 NF+3Kg1GhbDypYEuZpfgp/w9NoMbx8TQsMLeVMQneJK/QxM9q7T0G0FIqimZUm6Wx4
	 LQSZLYLEBI/nw==
Date: Tue, 17 Jun 2025 22:34:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, john.madieu.xa@bp.renesas.com, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add
 documentation for the PCIe IP on Renesas RZ/G3S
Message-ID: <cmh64utcezpq6thnfrfm7z4dxm63fxzkidirtyjj53cbuzu5ef@v73majd6kepz>
References: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>
 <20250530111917.1495023-4-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530111917.1495023-4-claudiu.beznea.uj@bp.renesas.com>

On Fri, May 30, 2025 at 02:19:12PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
> Base Specification 4.0. It is designed for root complex applications and
> features a single-lane (x1) implementation. Add documentation for it.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v2:
> - update the interrupt names by dropping "int" and "rc" string; due
>   to this the patch description was adjusted
> - added "interrupt-controller" and made it mandatory
> - s/clkl1pm/pm/g
> - dropped the legacy-interrupt-controller node; with this the gic
>   interrupt controller node was dropped as well as it is not needed
>   anymore
> - updated interrupt-map in example and added interrupt-controller
> - added clock-names as required property as the pm clock is not
>   handled though PM domains; this will allow the driver to have
>   the option to request the pm clock by its name when implementation
>   will be adjusted to used the pm clock
> - adjusted the size of dma-ranges to reflect the usage on
>   SMARC module board
> - moved "renesas,sysc" at the end of the node in example to align
>   with dts coding style
> 
>  .../pci/renesas,r9a08g045s33-pcie.yaml        | 202 ++++++++++++++++++
>  1 file changed, 202 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
> new file mode 100644
> index 000000000000..8ba30c084d1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
> @@ -0,0 +1,202 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/renesas,r9a08g045s33-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

[...]

> +examples:
> +  - |
> +    #include <dt-bindings/clock/r9a08g045-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@11e40000 {
> +            compatible = "renesas,r9a08g045s33-pcie";
> +            reg = <0 0x11e40000 0 0x10000>;
> +            ranges = <0x03000000 0 0x30000000 0 0x30000000 0 0x8000000>;

This 'ranges' property looks bogus. The bitfield specifies that the memory is
64 bit non-prefetchable, which can't be true.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

