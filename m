Return-Path: <linux-pci+bounces-11552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFA194D610
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 20:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD911F23C70
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 18:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C44145B3F;
	Fri,  9 Aug 2024 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy8bqaIN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2556413D512;
	Fri,  9 Aug 2024 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227010; cv=none; b=ssjSAnjSbeNvXY0h025YOE86ZN79RTdpFtYJy5kEE3qLKae6NuD3Lniye1dFvOMu1j/RPrlqB39+CHXE8EvLxXFMTJLIKWjfB5NsNPgCEQg7KS/G3qUZc9iGGokE4yA2Z/yHvdRU1HAmQzxBafU+o4rKiW26g2BY3+WDxVhcbgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227010; c=relaxed/simple;
	bh=ps6unyElBa8V3B369PXGF09PFDZoznk+uwxeku8zQRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvzRySTQWB529ACU8lN0VVOIBhJJbvL0gu2yND5+zRP9Q3xqz2h+Kllv4OKkiptgm9pH9lpxsQ/Q2tPHWvkVCi+1JTkRZvl2gJbk6KVsGkSS8M+knQmsGjr8UsvzqNJeRVkCZQx9TuCV5GO4aO48jNy0ppEwL2ZI4UiU3YfsvLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy8bqaIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4122AC32782;
	Fri,  9 Aug 2024 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723227009;
	bh=ps6unyElBa8V3B369PXGF09PFDZoznk+uwxeku8zQRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gy8bqaINlNhZfAv6ihJGwo7i1eC0/Pum9J0j8PcRxdxX7NU17seqO6TBsKSZn4uWs
	 UCzGjpOlvDqXU/tSp3q2ildCLBO8WIHigzX0o5KDMf2eJWk6S/thINKdEfK/JttYW7
	 VKx7e7gh/YHi25D/+CEDGXD5lvIHOM2TOrJT0A63j9Rbf5sKxuPkKyZKFUh4OPyPyy
	 JlGdTEXuOUMd8l583sT/a8LbwiVTOGHJCiycAbzCfiD6Yczvu17Cz8Jj8nnDmWZOMg
	 aLc7K0hGu9mqHt02kdxLmwk7kZEiq9YYLOFIVf56VnZO20q1vSNbPQele6UPpTZBfA
	 HHhIwcbi4gzAg==
Date: Fri, 9 Aug 2024 12:10:07 -0600
From: Rob Herring <robh@kernel.org>
To: Thippeswamy Havalige <thippesw@amd.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, thippeswamy.havalige@amd.com,
	linux-arm-kernel@lists.infradead.org, michal.simek@amd.com
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for
 Xilinx QDMA PCIe Root Port Bridge
Message-ID: <20240809181007.GA967711-robh@kernel.org>
References: <20240809060955.1982335-1-thippesw@amd.com>
 <20240809060955.1982335-2-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809060955.1982335-2-thippesw@amd.com>

On Fri, Aug 09, 2024 at 11:39:54AM +0530, Thippeswamy Havalige wrote:
> Add YAML devicetree schemas for Xilinx QDMA Soft IP PCIe Root Port
> Bridge.
> 
> Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
> ---
>  .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 36 ++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> ---
> changes in v3
> - constrain the new entry to only the new compatible.
> - Remove example.
> 
> changes in v2
> - update dt node label with pcie.
> ---
> diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> index 2f59b3a..f1efd919 100644
> --- a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> @@ -14,10 +14,21 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: xlnx,xdma-host-3.00
> +    enum:
> +      - xlnx,xdma-host-3.00
> +      - xlnx,qdma-host-3.00

Kind of odd that both IP have the exact same version number. Please 
explain in the commit message where it comes from. If you just copied it 
from the previous one, then nak.

>  
>    reg:
> -    maxItems: 1
> +    items:
> +      - description: configuration region and XDMA bridge register.
> +      - description: QDMA bridge register.
> +    minItems: 1
> +
> +  reg-names:
> +    items:
> +      - const: cfg
> +      - const: breg
> +    minItems: 1
>  
>    ranges:
>      maxItems: 2
> @@ -76,6 +87,27 @@ required:
>    - "#interrupt-cells"
>    - interrupt-controller
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - xlnx,qdma-host-3.00
> +then:
> +  properties:
> +    reg:
> +      minItems: 2
> +    reg-names:
> +      minItems: 2
> +  required:
> +    - reg-names
> +else:
> +  properties:
> +    reg:
> +      maxItems: 1
> +    reg-names:
> +      maxItems: 1
> +
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 1.8.3.1
> 

