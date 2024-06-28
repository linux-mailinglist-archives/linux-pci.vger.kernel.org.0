Return-Path: <linux-pci+bounces-9410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6332C91C6CA
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 21:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1A11C23CC1
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 19:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7356F315;
	Fri, 28 Jun 2024 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOEhQh50"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ADB6026A;
	Fri, 28 Jun 2024 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603931; cv=none; b=RQrKfpxaRQf5Lyp967hQWM6/CqD3aQbF3pNx+BcCp+pa6XgjG1QxFuk055y1ByiN8GWc0FwptF8tsVKqwOftCvn85cXabwIro2tv2yhwHrN6frAw6NbgnD+jIoO/Su6cflIyTgaW9BF5AQxi1gH2zhO+nb1Oanei+7u5yv+gRYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603931; c=relaxed/simple;
	bh=+rsJw1URSZZTnoBatuivHpXNy+C9BdH8uE2OqsLRkKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mH4PYxq6MVig4nVH/cBPIwYmi+HZ+GhSyI+zKXbV2KHa3I86vpOUImZ0sJ9LpICOkUY1DaSzdjcOQ0JcV2nFLAy8WsjquhAAy61b2YRLmkcuktmwCtyKjOoc09WZW/aqAOfjRWXyjrrMz/JadRHRaiWW+OFN6O+bBcywkZIm9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOEhQh50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C782C116B1;
	Fri, 28 Jun 2024 19:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719603931;
	bh=+rsJw1URSZZTnoBatuivHpXNy+C9BdH8uE2OqsLRkKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EOEhQh50sHrr4d6/28vhXk3OLs8gqY5qV+q0/s3rjUG0PxmaF/65Htzcyle95pgh5
	 QAz+TkRm6Ew2lw5IkuZmYKEslsCc7bWPPNrc41CvkHTWgR/HMYK1OI96sHgJ1J0R6V
	 WEgOo53TV0ZWypZZ5r3fDsX4lWE/lJeiHjlebCx72RxCsPxnvWilsfsBqYD/M8H0F8
	 v5kaPVFETGSaI2AsDYXTuF56fINvPC6NmRMVKG/VJMEQpv5ffOGhEJYmYFk5/0fz46
	 gH2ajcVVKquqSk/y+S4aSawxFNoQoUMeydn0YsqbuK+yuI4VOrLfkMjTwAjuwPtnoq
	 R2/muRRzdzNhA==
Date: Fri, 28 Jun 2024 13:45:30 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: PCI: layerscape-pci: Fix property
 'fsl,pcie-scfg' type
Message-ID: <20240628194530.GA99543-robh@kernel.org>
References: <20240628144858.2363300-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628144858.2363300-1-Frank.Li@nxp.com>

On Fri, Jun 28, 2024 at 10:48:57AM -0400, Frank Li wrote:
> fsl,pcie-scfg actually need an argument when there are more than one PCIe
> instances. Change it to phandle-array and use items to describe each field
> means.
> 
> Fix below warning.
> 
> arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: pcie@3400000: fsl,pcie-scfg:0: [22, 0] is too long
>         from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - update commit message.
> ---
>  .../devicetree/bindings/pci/fsl,layerscape-pcie.yaml      | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> index 793986c5af7ff..679c2989de7a2 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> @@ -43,10 +43,16 @@ properties:
>        - const: config
>  
>    fsl,pcie-scfg:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: A phandle to the SCFG device node. The second entry is the
>        physical PCIe controller index starting from '0'. This is used to get
>        SCFG PEXN registers.
> +    items:
> +      items:
> +        - description: A phandle to the SCFG device node
> +        - description: PCIe controller index starting from '0'
> +      minItems: 1

Are there any cases with only the phandle? I don't see any in tree and 
looks like the driver requires the 2nd entry.

> +    maxItems: 1
>  
>    big-endian:
>      $ref: /schemas/types.yaml#/definitions/flag
> -- 
> 2.34.1
> 

