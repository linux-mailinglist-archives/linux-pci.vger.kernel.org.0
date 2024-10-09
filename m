Return-Path: <linux-pci+bounces-14095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02587996F16
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 17:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185DC1C21196
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 15:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9EF19F130;
	Wed,  9 Oct 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW6eSMY6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE3537FF;
	Wed,  9 Oct 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486024; cv=none; b=SNmtSb47fhvRr3fWkFPBSKya/HfPLTtO0M0+1sacPR/pSbTXTaDR8Ux7eAGOy5QeSrqFy+YW5uqO5WJEHtakjPL84F2PUIBI/w0GBaBgGq/MQS2jXH4ABiHpHMwS4O82GrJfTif8/9hDm6BuDNzseSrtVb6RQqhOU50gziQDJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486024; c=relaxed/simple;
	bh=D0XqC48xeaaF/Gw7gpqXxx4RqDkm+MnppecvEnCEpig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9GxapzJwEZN2kdDZc6JBhmWmnLAegS4Q/ta7Ds+oEmGyQ1J5H5Y0PDSgpIYo9x4uYbjM2p02ImxPeBpVVTHNsZ5twGYj5enZoMfAB7UKyMsqYXDYM1vHMnsVWaSQ3Y8X3njtLGvG+g5Jrg3pDQ6Pf3wNSzv8+YtjoDArQLbeGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qW6eSMY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBD4C4CEC3;
	Wed,  9 Oct 2024 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728486024;
	bh=D0XqC48xeaaF/Gw7gpqXxx4RqDkm+MnppecvEnCEpig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qW6eSMY6s7/qAll04dwOz/7yMIlizS8cRC64xwYK/Sza+B2Y00qXklitkmq0kG2+X
	 9PR6K2OzUIIY+RbX1D081p3egbuR4lGlmviKUQ8r8Mew2t5FZx1vH+SNdq5kAvy1Wl
	 hcv1Ehk49H2IdeF4kp3bzm3J/pHClJeN7qgv8Vxue900lhJ1ZvXolRgyAm+d/f1XWn
	 IY0mXmkaj/4nL+SwkcyEDFo+QxF+h6U7tHpf6nJtV6hdUa2sI76OkGZImanWKzw+8F
	 spwEkdsZFy0AQz8lj2/UYJ3SGOEWjheJm/6qH6BlxImUtp89uMh07CKC6XoX+HHMxX
	 kyGHUlblJn6Vg==
Date: Wed, 9 Oct 2024 17:00:18 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Message-ID: <ZwaagtTx1ar1CW4V@ryzen.lan>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <1723534943-28499-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1723534943-28499-2-git-send-email-hongxing.zhu@nxp.com>

On Tue, Aug 13, 2024 at 03:42:20PM +0800, Richard Zhu wrote:
> Add reg-name: "dbi2", "atu" for i.MX8M PCIe Endpoint.
> 
> For i.MX8M PCIe EP, the dbi2 and atu addresses are pre-defined in the
> driver. This method is not good.
> 
> In commit b7d67c6130ee ("PCI: imx6: Add iMX95 Endpoint (EP) support"),
> Frank suggests to fetch the dbi2 and atu from DT directly. This commit is
> preparation to do that for i.MX8M PCIe EP.
> 
> These changes wouldn't break driver function. When "dbi2" and "atu"
> properties are present, i.MX PCIe driver would fetch the according base
> addresses from DT directly. If only two reg properties are provided, i.MX
> PCIe driver would fall back to the old method.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml  | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> index a06f75df8458..84ca12e8b25b 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> @@ -65,12 +65,14 @@ allOf:
>      then:
>        properties:
>          reg:
> -          minItems: 2
> -          maxItems: 2
> +          minItems: 4
> +          maxItems: 4

Now it seems like this patch has already been picked up,
but how is this not breaking DT backwards compatibility?

You are here increasing minItems, which means that an older DT
should now fail to validate using the new schema?

I thought that it was only acceptable to add new optional properties
after the DT binding has been accepted.

What am I missing?


If the specific compatible isn't used by any DTS in a released kernel,
then I think that the commit log should have clearly stated so,
and explained that that is the reason why it is okay to break DT backwards
compatibility.


Kind regards,
Niklas

>          reg-names:
>            items:
>              - const: dbi
>              - const: addr_space
> +            - const: dbi2
> +            - const: atu
>  
>    - if:
>        properties:
> @@ -129,8 +131,11 @@ examples:
>  
>      pcie_ep: pcie-ep@33800000 {
>        compatible = "fsl,imx8mp-pcie-ep";
> -      reg = <0x33800000 0x000400000>, <0x18000000 0x08000000>;
> -      reg-names = "dbi", "addr_space";
> +      reg = <0x33800000 0x100000>,
> +            <0x18000000 0x8000000>,
> +            <0x33900000 0x100000>,
> +            <0x33b00000 0x100000>;
> +      reg-names = "dbi", "addr_space", "dbi2", "atu";
>        clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
>                 <&clk IMX8MP_CLK_HSIO_AXI>,
>                 <&clk IMX8MP_CLK_PCIE_ROOT>;
> -- 
> 2.37.1
> 

