Return-Path: <linux-pci+bounces-14589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE66499FAA9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 23:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B69281A94
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 21:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C752521E3B4;
	Tue, 15 Oct 2024 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5hlu9cq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF421E3A0;
	Tue, 15 Oct 2024 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029518; cv=none; b=KLXGAaSM1GagAJ2oiaQwkBl8GQBiQdEEMowaOiGaWTt0ToM5blXN/ur/fRbCDekIQjQdccKVlv3lVKVE5rNATRkT94WVabvgyzmUzIE2YzpQG9mR6PVrnx6mjY/sj3Fy4iigSfC0Otk9TS2VbnbPsQiQ1GVvCqPOumz5pJcwV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029518; c=relaxed/simple;
	bh=JjirfYOBICS63RdNb4ix+9Zt0rkV4u0oor5q7jb/hWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFZ386iBnsBSdjw8nRpgwIjkZ7ncf5Lbt8sLQJ+N/Mqw7olMkuvm/Gc4X1moHko6Rnoh2olYCJ/1CHcdvszhq/XqQTcvaZbFT8jBNvRWntEkNdCoK4T5EJ0OpWuc3wxS1U/+Ug9wfRzkFyULpI8HA00A9mF7t4nMkWSlKdlnzKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5hlu9cq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40763C4CEC6;
	Tue, 15 Oct 2024 21:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729029518;
	bh=JjirfYOBICS63RdNb4ix+9Zt0rkV4u0oor5q7jb/hWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5hlu9cq3oRtd5VPPs60R0hS432xRp3nC5dRhY7yppsPlYMQtwu/NHSFh2mWNrN1o
	 Pt5m1vjiLOp0mvS7JkBFNna7BuKWq79pFD7PfQD3/fcnlSwWUp40ytMDmPReUsihRu
	 /sQzrUKFZr6XUstfzS1wacifbGZpWU3apIqc31YxdmSGO/OiKMjsNDc/C4bFsvlLJM
	 CjEI+6QmbBKL2SQB3yRkkuoPAKH53wpRVjUY0VJcLdnIkzrRYzXrklQ36xxDuymwLI
	 lHjlaO3yLcsYfJu0hbZwwpIDzTkGSHThVT/xeBJNvb1SKXPAJRlEUrCEyH5gUZo23v
	 idvl9b8VJbuGg==
Date: Tue, 15 Oct 2024 16:58:37 -0500
From: Rob Herring <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com, Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Message-ID: <20241015215837.GA2022846-robh@kernel.org>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015125841.1075560-3-wei.fang@nxp.com>

On Tue, Oct 15, 2024 at 08:58:30PM +0800, Wei Fang wrote:
> The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
> ID and device ID have also changed, so add the new compatible strings
> for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
> or RMII reference clock.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes: remove "nxp,imx95-enetc" compatible string.
> ---
>  .../devicetree/bindings/net/fsl,enetc.yaml    | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> index e152c93998fe..409ac4c09f63 100644
> --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> @@ -20,14 +20,25 @@ maintainers:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - pci1957,e100
> -      - const: fsl,enetc
> +    oneOf:
> +      - items:
> +          - enum:
> +              - pci1957,e100
> +          - const: fsl,enetc
> +      - items:

You can omit items here.

> +          - const: pci1131,e101
>  
>    reg:
>      maxItems: 1
>  
> +  clocks:
> +    items:
> +      - description: MAC transmit/receiver reference clock
> +
> +  clock-names:
> +    items:
> +      - const: enet_ref_clk

Clock names are local to the block, so 'enet_' is redundant. It's all 
clock names, so '_clk' is redundant too. IOW, just use 'ref'.

> +
>    mdio:
>      $ref: mdio.yaml
>      unevaluatedProperties: false
> -- 
> 2.34.1
> 

