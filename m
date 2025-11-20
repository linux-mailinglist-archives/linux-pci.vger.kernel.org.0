Return-Path: <linux-pci+bounces-41778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF782C73BDB
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 12:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC03A4E7F68
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 11:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F68B2D062F;
	Thu, 20 Nov 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ/RcFCS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E72C3258;
	Thu, 20 Nov 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638072; cv=none; b=fH9wIAnb6wsPg9NATm2xjVbzZmlK3H4YuozmFwjhY7Ti7cRhfnC3kvW0os0HpUmxN7M4B+VP89AdNpWPXMsSqAH5hAJBgNOnYZZSYU1LeGDaw07FXzVTYFhEKXiJy9z/O2j3Rs12JcT+9YFaYla5F0yP++9jLQ5ndUwPX9R5ky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638072; c=relaxed/simple;
	bh=Hcer97dP75o+T5ehV5+nCdf+Z1PlLJkSc7iXUrcY7QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaMVBLzVueflMU89ABu3yHJIGQbPestfRzcuzZftUHaU2HCSyxiWcr0VIET4HC0s+cSolVSEsY46ITGnEvK6Ns4jhtHgMocI8wYpOHtx9kAAm7mieFKzvtwFufuIVWSoIYQRl+fHZfLtQomMjwZ5/CVEFmo0HO5Z3Y2V40cM+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ/RcFCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC9BC4CEF1;
	Thu, 20 Nov 2025 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763638069;
	bh=Hcer97dP75o+T5ehV5+nCdf+Z1PlLJkSc7iXUrcY7QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJ/RcFCSf/9oyLwA92DEMR3vVQhNGdAx64A7q2NbsQv+RyiM/XK06NJbe1FCniiRN
	 nZxuk+nWhio4q2FaZS6jlMRjIO7W93lCwAFgp6nioD5n1X0rC6WohaRRSCjhXCjQ9t
	 vzFuJ9j8tKImtv+rw+ksexSmxnMzO3e19orbPJCgmOOfd17MDVa3HGUgcSIi9sMlPo
	 Y+1mdVf7u3iTcQDHnH0YqC9IL+aEGdTwUInn+oI2jLhrpvQvapLbizZQPn0lM4DvKM
	 +QIItI7Po9QnGTYnyKhCe9sjGont9ApZognpTaMgirh3IjK7fHOwHnFVyBak6mB4pW
	 lrt3Y7LYp4SzA==
Date: Thu, 20 Nov 2025 16:57:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, 
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	Frank.li@nxp.com, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org
Subject: Re: [PATCH 1/4 v5] dt-bindings: PCI: s32g: Add NXP PCIe controller
Message-ID: <gnfp6pmdfk7n2kask3qmp7qtjcwdze2ltheibqctsl3ap4fxjj@kxgegsjroooh>
References: <20251118160238.26265-1-vincent.guittot@linaro.org>
 <20251118160238.26265-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251118160238.26265-2-vincent.guittot@linaro.org>

On Tue, Nov 18, 2025 at 05:02:35PM +0100, Vincent Guittot wrote:
> Describe the PCIe host controller available on the S32G platforms.
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
>  .../bindings/pci/nxp,s32g-pcie.yaml           | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> new file mode 100644
> index 000000000000..da3106dfcf58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/nxp,s32g-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP S32G2xxx/S32G3xxx PCIe Root Complex controller
> +
> +maintainers:
> +  - Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> +  - Ionut Vicovan <ionut.vicovan@nxp.com>
> +
> +description:
> +  This PCIe controller is based on the Synopsys DesignWare PCIe IP.
> +  The S32G SoC family has two PCIe controllers, which can be configured as
> +  either Root Complex or Endpoint.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nxp,s32g2-pcie
> +      - items:
> +          - const: nxp,s32g3-pcie
> +          - const: nxp,s32g2-pcie
> +
> +  reg:
> +    maxItems: 6
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: atu
> +      - const: dma
> +      - const: ctrl
> +      - const: config
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +      - const: dma
> +    minItems: 1
> +
> +  pcie@0:
> +    description:
> +      Describe the S32G Root Port.
> +    type: object
> +    $ref: /schemas/pci/pci-pci-bridge.yaml#
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      phys:
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +      - phys
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - ranges
> +  - pcie@0
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +unevaluatedProperties: false
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
> +        pcie@40400000 {
> +            compatible = "nxp,s32g3-pcie", "nxp,s32g2-pcie";
> +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> +                  <0x5f 0xffffe000 0x0 0x00002000>;   /* config space */
> +            reg-names = "dbi", "dbi2", "atu", "dma", "ctrl", "config";
> +            dma-coherent;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            device_type = "pci";
> +            ranges =
> +                     <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> +                     <0x82000000 0x0 0x00000000 0x58 0x00000000 0x0 0x80000000>,
> +                     <0x82000000 0x1 0x00000000 0x59 0x00000000 0x6 0xfffe0000>;

Please drop the 'relocatable' flag (bit 31) from all the entries.

With that,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்

