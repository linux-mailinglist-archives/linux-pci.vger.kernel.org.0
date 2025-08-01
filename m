Return-Path: <linux-pci+bounces-33319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796EDB188C9
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 23:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C1356552A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 21:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052F4270ED7;
	Fri,  1 Aug 2025 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEJFuXVU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC80220F4B;
	Fri,  1 Aug 2025 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084034; cv=none; b=LLtAmBt+PCXkihJVR4osQx1X4lzMdA7miIAwC6NyIdQ3j45PF7F1Cxhx7UF8xU5ARSTVDjy3wlZqWAbn96pCdqs/MJfLB8uzbThvg+xAiOPkoUVSLZ3kik5Rfg8k+j4kPjfS9nLo+i4ZWpww+PF855qsUXvMvWGrkOLMB/uFIfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084034; c=relaxed/simple;
	bh=+pXG+/8x+eovxVFUgbrD5YQLJQEUBlpsiR9an1SRSUk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zwt0f81L1lyBJRaCcGm/nm3uuwgrMUEAqpttqSGYLX0JZOq2XsrEwVwNHYOMcc6trFzpyK38o30s8QrFj0cIozAxPcua2PN7V6IgsWjFovjIpDQKfptdiv9NIg8eJNzSFVu6Qvd3ySSwwzWEXhYZXHeXZQG28XsGrKR5qL4jrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEJFuXVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADCCC4CEE7;
	Fri,  1 Aug 2025 21:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754084034;
	bh=+pXG+/8x+eovxVFUgbrD5YQLJQEUBlpsiR9an1SRSUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dEJFuXVUpIXNqVnLu3QVmq4JfP26f/yuEPleAj+PZbjcPkFXJ3hNEwE+Ea33zwB3T
	 yTebhUob6kuVT1jRDV+XIqDksoyzYfvuZgW0umz6tbStW3c4ljN3ewPd/uu2xlqEJ2
	 00/Jj9thTraNR+PxHwC3km18lK5oP/AHunuTpBIu1MhgY1ImOGNVM/dANHT6Vuk8/T
	 hQ0qDN6yILZxCa0Uwc0WMPwMVztv9T7mZ7ubMQQFi3nSCpArTPiQ/LM+yIHSOvbNCT
	 YabR5DqoiFrjV40nIqngb0zKmPLUVkXvZnvUETgKjgHc+eW8CuGLkrvOn9eqSJlCEn
	 IHSBguVjpWCeA==
Date: Fri, 1 Aug 2025 16:33:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: Add missing "#address-cells" to
 interrupt controllers
Message-ID: <20250801213353.GA3511997@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801200728.3252036-2-robh@kernel.org>

On Fri, Aug 01, 2025 at 03:07:27PM -0500, Rob Herring (Arm) wrote:
> An interrupt-controller node which is the parent provider for
> "interrupt-map" needs an "#address-cells" property. This fixes
> "interrupt_map" warnings in new dtc.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> PCI maintainers, Please ack, I'll take this with the dtc update for 
> 6.18.
> 
>  Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml    | 1 +
>  .../devicetree/bindings/pci/marvell,armada-3700-pcie.yaml     | 4 ++++
>  .../devicetree/bindings/pci/marvell,kirkwood-pcie.yaml        | 3 +++
>  .../devicetree/bindings/pci/socionext,uniphier-pcie.yaml      | 4 ++++
>  Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml  | 3 +++
>  5 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> index 5434c144d2ec..18e7981241b5 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> @@ -108,6 +108,7 @@ examples:
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>      gic: interrupt-controller {
> +        #address-cells = <0>;
>          interrupt-controller;
>          #interrupt-cells = <3>;
>      };
> diff --git a/Documentation/devicetree/bindings/pci/marvell,armada-3700-pcie.yaml b/Documentation/devicetree/bindings/pci/marvell,armada-3700-pcie.yaml
> index 68090b3ca419..8403c79634ed 100644
> --- a/Documentation/devicetree/bindings/pci/marvell,armada-3700-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/marvell,armada-3700-pcie.yaml
> @@ -42,6 +42,9 @@ properties:
>      additionalProperties: false
>  
>      properties:
> +      '#address-cells':
> +        const: 0
> +
>        interrupt-controller: true
>  
>        '#interrupt-cells':
> @@ -92,6 +95,7 @@ examples:
>              reset-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
>  
>              pcie_intc: interrupt-controller {
> +                #address-cells = <0>;
>                  interrupt-controller;
>                  #interrupt-cells = <1>;
>              };
> diff --git a/Documentation/devicetree/bindings/pci/marvell,kirkwood-pcie.yaml b/Documentation/devicetree/bindings/pci/marvell,kirkwood-pcie.yaml
> index 7be695320ddf..3d68bfbe6feb 100644
> --- a/Documentation/devicetree/bindings/pci/marvell,kirkwood-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/marvell,kirkwood-pcie.yaml
> @@ -101,6 +101,9 @@ patternProperties:
>          additionalProperties: false
>  
>          properties:
> +          '#address-cells':
> +            const: 0
> +
>            interrupt-controller: true
>  
>            '#interrupt-cells':
> diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> index 638b99db0433..c07b0ed51613 100644
> --- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie.yaml
> @@ -56,6 +56,9 @@ properties:
>      additionalProperties: false
>  
>      properties:
> +      '#address-cells':
> +        const: 0
> +
>        interrupt-controller: true
>  
>        '#interrupt-cells':
> @@ -109,6 +112,7 @@ examples:
>                          <0 0 0  4  &pcie_intc 3>;
>  
>          pcie_intc: interrupt-controller {
> +            #address-cells = <0>;
>              interrupt-controller;
>              #interrupt-cells = <1>;
>              interrupt-parent = <&gic>;
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> index 69b499c96c71..c704099f134b 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -99,6 +99,9 @@ properties:
>      additionalProperties: false
>  
>      properties:
> +      '#address-cells':
> +        const: 0
> +
>        interrupt-controller: true
>  
>        '#interrupt-cells':
> -- 
> 2.47.2
> 

