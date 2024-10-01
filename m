Return-Path: <linux-pci+bounces-13670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E85BA98B4BB
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 08:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54625B23A80
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 06:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4F31BC084;
	Tue,  1 Oct 2024 06:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvD/970v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D52A1BC070;
	Tue,  1 Oct 2024 06:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765008; cv=none; b=f6S1N/WSa/CzY9dl98Z7MUkbBJpfl+Iyik/boYpuCCm20OBmD48j+rpmNJb5Es3gd4DlTpwJECbHgw6KQbrWaeorieMhvDPdJwFs7Fv57lXSVKKFq3DrDf0K9qNycmCjttFc8bT+n4+4HkrcXWT/4ijoS7xssq0E/BoDiS5WXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765008; c=relaxed/simple;
	bh=Eqh7CxsxMbg7lUiyrHXHF4V+hK92QACWu7JR6SctAD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0fpUlw1YSXOIEq75oPrctNE2JOHP5FpizeXJUMBxrEA+kants2hx6VeXQL/4W4KrwsmKMq6z9IqISqrUSJq8D9SgtP9Zi/OMi9JwAxu2/TG3Jx1xLF99jcYnPTJtZ+aO2acJ06GuHi9A1m07AIr5E9yO1cxzxayU90rKuouToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvD/970v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9C5C4CEC6;
	Tue,  1 Oct 2024 06:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727765008;
	bh=Eqh7CxsxMbg7lUiyrHXHF4V+hK92QACWu7JR6SctAD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MvD/970vL0gcr+2EgNHBWQ3lL2ODJbQnge8+5weu42T/rJETaaTI84Umy4MKaar3+
	 qKFLsMxIuoUJVsOXRemnpCLlq8FOADhkFNYiFKOt6g5ARxmKidqJ5oWa0HK1dVpvbC
	 j1G7VmCF4ktJPGtkGC8P3u9Yw0aj5yzMU0fFsLDkaQtCNocTei+AV9ZOXOGM04/RRJ
	 VEytpnuvUTnsSnKnb/py5Z51Cl/XOO5vmrbduTIhxZiXKXBI+RHV+KgqWrl3D5HXIO
	 jSopVzWuxFZYPZH1m4EgkS0dfLyZN1288bJp2rHGv4eLSYLuAXvNhgrVcRxF+RJSNM
	 6OhnY7kd2ToIg==
Date: Tue, 1 Oct 2024 08:43:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, Lee Jones <lee@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 1/7] dt-bindings: reset: microchip,rst: Allow to
 replace cpu-syscon by an additional reg item
Message-ID: <emcl3vfclrmy273kknsakpqpzolvo5vohrjnw64ml3op4dwzvu@lwqfgc7jxxzq>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
 <20240930121601.172216-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240930121601.172216-2-herve.codina@bootlin.com>

On Mon, Sep 30, 2024 at 02:15:41PM +0200, Herve Codina wrote:
> In the LAN966x PCI device use case, syscon cannot be used as syscon
> devices do not support removal [1]. A syscon device is a core "system"
> device and not a device available in some addon boards and so, it is not
> supposed to be removed.

That's not accurate. syscon is our own, Linux term which means also
anything exposing set of registers.

If you need to unload syscons, implement it. syscon is the same resource
as all others so should be handled same way.

> 
> In order to remove the syscon device usage, allow the reset controller
> to have a direct access to the address range it needs to use.

So you map same address twice? That's not good, because you have no
locking over concurrent register accesses.

> 
> Link: https://lore.kernel.org/all/20240923100741.11277439@bootlin.com/ [1]
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/reset/microchip,rst.yaml         | 35 ++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> index f2da0693b05a..5164239a372c 100644
> --- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> +++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> @@ -25,12 +25,16 @@ properties:
>        - microchip,lan966x-switch-reset
>  
>    reg:
> +    minItems: 1
>      items:
>        - description: global control block registers
> +      - description: cpu system block registers
>  
>    reg-names:
> +    minItems: 1
>      items:
>        - const: gcb
> +      - const: cpu
>  
>    "#reset-cells":
>      const: 1
> @@ -39,12 +43,29 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: syscon used to access CPU reset
>  
> +allOf:
> +  # Allow to use the second reg item instead of cpu-syscon
> +  - if:
> +      required:
> +        - cpu-syscon
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1
> +        reg-names:
> +          maxItems: 1
> +    else:
> +      properties:
> +        reg:
> +          minItems: 2
> +        reg-names:
> +          minItems: 2
> +
>  required:
>    - compatible
>    - reg
>    - reg-names
>    - "#reset-cells"
> -  - cpu-syscon
>  
>  additionalProperties: false
>  
> @@ -57,3 +78,15 @@ examples:
>          #reset-cells = <1>;
>          cpu-syscon = <&cpu_ctrl>;
>      };
> +
> +    /*
> +     * The following construction can be used if the cpu-syscon device is not
> +     * present. This is the case when the LAN966x is used as a PCI device.
> +     */
> +    reset-controller@22010008 {
> +        compatible = "microchip,lan966x-switch-reset";
> +        reg = <0xe200400c 0x4>,
> +              <0xe00c0000 0xa8>;

If you have here CPU address, then syscon device is present...

Best regards,
Krzysztof


