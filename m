Return-Path: <linux-pci+bounces-15312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 508269B0516
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C1F28493A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4819514884C;
	Fri, 25 Oct 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX+p1F+S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129AB70815;
	Fri, 25 Oct 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865267; cv=none; b=Rqdlaf5VtzFRW7oGGoW55uwvWw7TpnTjqBdMgh8Gc2539Gk/eY6RDqlK55ijYyr6+S42H6efxoaDoMok1yUIomjsKdBvmT0JW5wwTbEK2lqALEINF89N8eGCWgeMU3s//cpqsCq3k19K+YajALwpu+KsdXU82H5VynJljZ5yPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865267; c=relaxed/simple;
	bh=gND61iG+K/9p0y+1117PkpZdIqHcRUWD0xS62lpezW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEz0P4ws49u3v2cLuYKjR6kYPhwwzExiro49YkNc1oIYxJ/z5Toy6XiPk1zzDdioz0/x7gxy0U9H4suOAiwRDYhSdUuqOQE194iMoAA2VCQxSKAFNayUUq7STx18yej77bohT2saOVec2FaLs808h+EOuQNvYYxL933XFmA6CLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX+p1F+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D212C4CEE3;
	Fri, 25 Oct 2024 14:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729865266;
	bh=gND61iG+K/9p0y+1117PkpZdIqHcRUWD0xS62lpezW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BX+p1F+SOzZT9BkIcdyNjKmbv0cIonvd2FBG7v4LLrUCE9nZWrKB4xgODPeXhH1wy
	 zS26PxyXHhrkDjqT09rbiaOkpAEt3YnunzGQv8/+4g+KH9Xy5rW3MB6VnBpxIvkdpS
	 yhgorz6fW+bZp+ymmwA9Fb6WX0PU3csGuuyB02Ydo1qYNwITtxDRCzrg0euJAR4fMC
	 8z7xhswj7lgeX4doIYje1k9n5hGZ3lkrd9lvqDKx/KqDl93ykkarMI/yRLyM8oeRoH
	 uE4Jrovawz/TPYCHoYGWZtdwyqwMyBCOcpSLVU6SxX9eMOsZgk9Vl5JUHSZ9kwvaXn
	 SGqQl7N6VjFQw==
Date: Fri, 25 Oct 2024 09:07:45 -0500
From: Rob Herring <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com, Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v5 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Message-ID: <20241025140745.GA2021164-robh@kernel.org>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065328.521518-3-wei.fang@nxp.com>

On Thu, Oct 24, 2024 at 02:53:17PM +0800, Wei Fang wrote:
> The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
> ID and device ID have also changed, so add the new compatible strings
> for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
> or RMII reference clock.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2: Remove "nxp,imx95-enetc" compatible string.
> v3:
> 1. Add restriction to "clcoks" and "clock-names" properties and rename
> the clock, also remove the items from these two properties.
> 2. Remove unnecessary items for "pci1131,e101" compatible string.
> v4: Move clocks and clock-names to top level.
> v5: Add items to clocks and clock-names
> ---
>  .../devicetree/bindings/net/fsl,enetc.yaml    | 34 +++++++++++++++++--
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> index e152c93998fe..72d2d5d285cd 100644
> --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> @@ -20,14 +20,23 @@ maintainers:
>  
>  properties:
>    compatible:
> -    items:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - pci1957,e100
> +          - const: fsl,enetc
>        - enum:
> -          - pci1957,e100
> -      - const: fsl,enetc
> +          - pci1131,e101
>  
>    reg:
>      maxItems: 1
>  
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    maxItems: 1
> +
>    mdio:
>      $ref: mdio.yaml
>      unevaluatedProperties: false
> @@ -40,6 +49,25 @@ required:
>  allOf:
>    - $ref: /schemas/pci/pci-device.yaml
>    - $ref: ethernet-controller.yaml
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - pci1131,e101
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: MAC transmit/receiver reference clock

This goes in the top-level or can just be dropped.

> +
> +        clock-names:
> +          items:
> +            - const: ref

This goes in the top-level.


> +    else:

Then negate the 'if' schema (not: contains: ...) and you just need the 
part below:

> +      properties:
> +        clocks: false
> +        clock-names: false
>  
>  unevaluatedProperties: false
>  
> -- 
> 2.34.1
> 

