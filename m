Return-Path: <linux-pci+bounces-44942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0400D24CD7
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 14:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFC2430021F9
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC7036CDEC;
	Thu, 15 Jan 2026 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvinfmyR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC53361DD1;
	Thu, 15 Jan 2026 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484940; cv=none; b=dKcpipfKDO7H9+O5uRmMYRDZD6xFZKNACxz2MOlKvr+rgHCLZor7tQ13xnlYqP7pExman6wxwrz65d4XX+1/Zdxfpomm85P8aaIR0WxV9yb8EIkswWyRuDMwXbtlguuBltuPhoCniYuDurXL6/V0/lOkN5kV4C6HhQBIsAJPhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484940; c=relaxed/simple;
	bh=FWCj01EER32/5ZyQsKacN6nLKsoC3Xai8qLFf8R1U0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HioW0cFW4s6mGe9P60sE1Lp5zXzZQzwELCMji6jdynJ2F+WEA2G22MSBl+wR8oL+jerqo4Z3Bo4mp+srQOGYgbeLIE5Cv6Eei+juS/uq9hVQFFz/AV9yATJ3pdR+YiK4gQKeIqxCXku8ExVpFt4y+ebsy2mfYVUh/uLjiiYcDCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvinfmyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04A3C16AAE;
	Thu, 15 Jan 2026 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768484939;
	bh=FWCj01EER32/5ZyQsKacN6nLKsoC3Xai8qLFf8R1U0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvinfmyRwlyGAdQJjmbpqL+Nx1PDjRzxRj/igzyEleLHHc7oqDhz9MK2B8XHYet9F
	 4Hf6sYVcMV4C4huBPyDGz1XjA3exjyvUOnEbSIkwcNCwJyvBXQw34J1QHJr0c+gCeH
	 1wCz9TFS3EKI1VgXpAxnNzlAIxqwAfEetl/dvAfOaOJbleLF6eHbCctrU+M6Pw2KUy
	 wfLtpCk9llB3hlXuxBdawdXaPqIKnowf1x1G1cuwJc/xNXexaGzmFGxz+JW7i9LxGr
	 4fbN8jytwpatfFnIPJYycNgXRw7Ad1xhBJk/eo5MmOqT4hrEgpwLMrSRi7dUVVAhNw
	 vI7b0h4XaW+Kw==
Date: Thu, 15 Jan 2026 14:48:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be, krzk+dt@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
Subject: Re: [PATCH 05/16] dt-bindings: PCI: renesas,r9a08g045s33-pcie:
 Document RZ/G3E SoC
Message-ID: <20260115-beautiful-ambitious-swine-c26a0d@quoll>
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
 <20260114153337.46765-6-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114153337.46765-6-john.madieu.xa@bp.renesas.com>

On Wed, Jan 14, 2026 at 04:33:26PM +0100, John Madieu wrote:
> Extend the existing device tree bindings for Renesas RZ/G3S PCIe
> controller to include support for the RZ/G3E (renesas,r9a09g047e57-pcie) PCIe
> controller. The RZ/G3E PCIe controller is similar to RZ/G3S but has some key
> differences:
> 
>  - Uses a different device ID
>  - Supports PCIe Gen3 (8.0 GT/s) link speeds
>  - Uses a different clock naming (clkpmu vs clkl1pm)
>  - Has a different set of interrupts, interrupt ordering, and reset signals
> 
> Add device tree bindings for renesas,r9a09g047e57-pcie compatible IPs.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>  .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 243 +++++++++++++-----
>  1 file changed, 172 insertions(+), 71 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> index d668782546a2..c68bc76af35d 100644
> --- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> @@ -10,85 +10,34 @@ maintainers:
>    - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>  
>  description:
> -  Renesas RZ/G3S PCIe host controller complies with PCIe Base Specification
> -  4.0 and supports up to 5 GT/s (Gen2).
> +  Renesas RZ/G3{E,S} PCIe host controllers comply with PCIe
> +  Base Specification 4.0 and support up to 5 GT/s (Gen2) for RZ/G3S and
> +  up to 8 GT/s (Gen3) for RZ/G3E.
>  
>  properties:
>    compatible:
> -    const: renesas,r9a08g045-pcie # RZ/G3S
> +    enum:
> +      - renesas,r9a08g045-pcie # RZ/G3S
> +      - renesas,r9a09g047-pcie # RZ/G3E
>  
>    reg:
>      maxItems: 1
>  
> -  interrupts:
> -    items:

Same review as already in the past for Renesas. Broadest constraints
always stay here and list should share items.

> -      - description: System error interrupt
> -      - description: System error on correctable error interrupt
> -      - description: System error on non-fatal error interrupt
> -      - description: System error on fatal error interrupt
> -      - description: AXI error interrupt
> -      - description: INTA interrupt
> -      - description: INTB interrupt
> -      - description: INTC interrupt
> -      - description: INTD interrupt
> -      - description: MSI interrupt
> -      - description: Link bandwidth interrupt
> -      - description: PME interrupt
> -      - description: DMA interrupt
> -      - description: PCIe event interrupt
> -      - description: Message interrupt
> -      - description: All interrupts
> -
> -  interrupt-names:
> -    items:
> -      - description: serr
> -      - description: ser_cor
> -      - description: serr_nonfatal
> -      - description: serr_fatal
> -      - description: axi_err
> -      - description: inta
> -      - description: intb
> -      - description: intc
> -      - description: intd
> -      - description: msi
> -      - description: link_bandwidth
> -      - description: pm_pme
> -      - description: dma
> -      - description: pcie_evt
> -      - description: msg
> -      - description: all
> +  interrupts: true
> +
> +  interrupt-names: true
>  
>    interrupt-controller: true
>  
>    clocks:
> -    items:
> -      - description: System clock
> -      - description: PM control clock
> +    maxItems: 2
>  
>    clock-names:
> -    items:
> -      - description: aclk
> -      - description: pm
> -
> -  resets:
> -    items:
> -      - description: AXI2PCIe Bridge reset
> -      - description: Data link layer/transaction layer reset
> -      - description: Transaction layer (ACLK domain) reset
> -      - description: Transaction layer (PCLK domain) reset
> -      - description: Physical layer reset
> -      - description: Configuration register reset
> -      - description: Configuration register reset
> -
> -  reset-names:
> -    items:
> -      - description: aresetn
> -      - description: rst_b
> -      - description: rst_gp_b
> -      - description: rst_ps_b
> -      - description: rst_rsm_b
> -      - description: rst_cfg_b
> -      - description: rst_load_b
> +    maxItems: 2
> +
> +  resets: true
> +
> +  reset-names: true
>  
>    power-domains:
>      maxItems: 1
> @@ -128,11 +77,12 @@ patternProperties:
>          const: 0x1912
>  
>        device-id:
> -        const: 0x0033
> +        enum:
> +          - 0x0033
> +          - 0x0039
>  
>        clocks:
> -        items:
> -          - description: Reference clock
> +        maxItems: 1
>  
>        clock-names:
>          items:
> @@ -142,8 +92,6 @@ patternProperties:
>        - device_type
>        - vendor-id
>        - device-id
> -      - clocks
> -      - clock-names
>  
>      unevaluatedProperties: false
>  
> @@ -167,6 +115,159 @@ required:
>  
>  allOf:
>    - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a08g045-pcie
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: System error interrupt
> +            - description: System error on correctable error interrupt
> +            - description: System error on non-fatal error interrupt
> +            - description: System error on fatal error interrupt
> +            - description: AXI error interrupt
> +            - description: INTA interrupt
> +            - description: INTB interrupt
> +            - description: INTC interrupt
> +            - description: INTD interrupt
> +            - description: MSI interrupt
> +            - description: Link bandwidth interrupt
> +            - description: PME interrupt
> +            - description: DMA interrupt
> +            - description: PCIe event interrupt
> +            - description: Message interrupt
> +            - description: All interrupts
> +        interrupt-names:
> +          items:
> +            - const: serr

So serr is first...

> +            - const: serr_cor
> +            - const: serr_nonfatal
> +            - const: serr_fatal
> +            - const: axi_err
> +            - const: inta
> +            - const: intb
> +            - const: intc
> +            - const: intd
> +            - const: msi
> +            - const: link_bandwidth
> +            - const: pm_pme
> +            - const: dma
> +            - const: pcie_evt
> +            - const: msg
> +            - const: all
> +        clocks:
> +          items:
> +            - description: System clock
> +            - description: PM control clock
> +        clock-names:
> +          items:
> +            - const: aclk
> +            - const: pm
> +        resets:
> +          items:
> +            - description: AXI2PCIe Bridge reset
> +            - description: Data link layer/transaction layer reset
> +            - description: Transaction layer (ACLK domain) reset
> +            - description: Transaction layer (PCLK domain) reset
> +            - description: Physical layer reset
> +            - description: Configuration register reset
> +            - description: Configuration register reset
> +        reset-names:
> +          items:
> +            - const: aresetn
> +            - const: rst_b
> +            - const: rst_gp_b
> +            - const: rst_ps_b
> +            - const: rst_rsm_b
> +            - const: rst_cfg_b
> +            - const: rst_load_b
> +      patternProperties:
> +        "^pcie@0,[0-0]$":
> +          properties:
> +            device-id:
> +              const: 0x0033
> +          required:
> +            - clocks
> +            - clock-names
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g047-pcie
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: All interrupts
> +            - description: INTA interrupt
> +            - description: INTB interrupt
> +            - description: INTC interrupt
> +            - description: INTD interrupt
> +            - description: MSI interrupt
> +            - description: Link bandwidth interrupt
> +            - description: Link equalization request interrupt
> +            - description: PME interrupt
> +            - description: System error interrupt
> +            - description: System error on correctable error interrupt
> +            - description: System error on non-fatal error interrupt
> +            - description: System error on fatal error interrupt
> +            - description: DMA interrupt
> +            - description: PCIe event interrupt
> +            - description: AXI error interrupt
> +            - description: Message interrupt
> +            - description: Turn off event interrupt
> +            - description: PMU power off interrupt
> +            - description: D3 event function 0 interrupt
> +            - description: D3 event function 1 interrupt
> +            - description: Configuration PMCSR write clear function 0 interrupt
> +            - description: Configuration PMCSR write clear function 1 interrupt
> +        interrupt-names:
> +          items:
> +            - const: all
> +            - const: inta
> +            - const: intb
> +            - const: intc
> +            - const: intd
> +            - const: msi
> +            - const: link_bandwidth
> +            - const: link_equalization_request
> +            - const: pm_pme
> +            - const: serr

And middle? What sort of mess is this?

Please learn from existing review, organize internal knowledge so we
won't be repeating the same.

I am not reviewing the rest.

Best regards,
Krzysztof


