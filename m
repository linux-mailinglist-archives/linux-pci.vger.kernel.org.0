Return-Path: <linux-pci+bounces-40070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34EEC2916E
	for <lists+linux-pci@lfdr.de>; Sun, 02 Nov 2025 17:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1F43AC34C
	for <lists+linux-pci@lfdr.de>; Sun,  2 Nov 2025 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1E01DF985;
	Sun,  2 Nov 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXhs0E7Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C24381C4;
	Sun,  2 Nov 2025 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762099476; cv=none; b=temMZVICra9j+k0ppItQHrW8NN8gBQ/ujRrqsqFdwHrZctsd8LVvGgC6OPIO7G4CGIo51vjxNJDbJXf1ZqqyLPoCuEjY9TTw2+TaJRmm+UJxbPsG0t9YovSnd0azYsjh5H2eWvvQy4fJGwZH3mCpYMHzvrhYJFpW4//AJH6kI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762099476; c=relaxed/simple;
	bh=LDVvvx4d31uLUm6uFJRNmDhHPt6c/ETBVWcMM1W43j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FH8RUItmsugBQ+1EpfSJoFgEncoVFkpNqLOnXZtv7P+7+tD5tmU+jSNHq7wb3pZP500OHItoFV/bezDmNk3Y0Jl0FMX+FMEWEbvbM1orFFBHoyokQJBp57VMmEX4/aVT2AI7h+/lSl4S6JOlxb4NFHf4RX7rCuhnnf0JBnJg8Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXhs0E7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FABEC4CEF7;
	Sun,  2 Nov 2025 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762099475;
	bh=LDVvvx4d31uLUm6uFJRNmDhHPt6c/ETBVWcMM1W43j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXhs0E7QOaDTPLyzD8sh/jKT2Lz+iJJI6iYwTOW9F8nF60mefcKIvxTvQ63fAj9lV
	 yC/ha9bLOKwUfgg4yyx8MbxaPZTQNCsPyrEnf9qZbFHkSpJuQL+nVECb+iEDNk3un5
	 3ZQ1hqAVbhb8YasBBjC8vp88snPxhgN9yV06v8vIGm8pbvggNmh9qIzIhQKZMl8tvE
	 GlAYumEoNncebVpQCc+LrXzrQpraQmPERM9dgM6bZGaPV0CTvaE328gAQoFiWrOkqX
	 nMSxdODCL8ahHVpU6MGMrUBaYU20ezVq2hMZfRvnAb97pskQHt6UoGb6x71fV7qlJt
	 P4wLy5vt+5kDQ==
Date: Sun, 2 Nov 2025 17:04:33 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/3] dt-bindings: PCI: pci-imx6: Add external
 reference clock input
Message-ID: <20251102-complex-placid-frog-09cbed@kuoka>
References: <20251031031907.1390870-1-hongxing.zhu@nxp.com>
 <20251031031907.1390870-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031031907.1390870-3-hongxing.zhu@nxp.com>

On Fri, Oct 31, 2025 at 11:19:06AM +0800, Richard Zhu wrote:
> i.MX95 PCIes have two reference clock inputs: one from internal PLL, the
> other from off chip crystal oscillator. The "extref" clock refers to a
> reference clock from an external crystal oscillator.
> 
> Add external reference clock input for i.MX95 PCIes.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index ca5f2970f217c..703c776d28e6f 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -44,7 +44,7 @@ properties:
>  
>    clock-names:
>      minItems: 3
> -    maxItems: 5
> +    maxItems: 6
>  
>    interrupts:
>      minItems: 1
> @@ -212,14 +212,17 @@ allOf:
>      then:
>        properties:
>          clocks:
> -          maxItems: 5
> +          minItems: 4
> +          maxItems: 6
>          clock-names:
> +          minItems: 4
>            items:
>              - const: pcie
>              - const: pcie_bus
>              - const: pcie_phy
>              - const: pcie_aux
>              - const: ref

This was required last time. Nothing in commit msg explained changing
that.

> +            - const: extref  # Optional

Drop the comment, do not repeat the schema. And why only this is marked
as optional if 'ref' is optional as well now.

It is v9, can you please really think thoroughly what you are sending,
so obvious issues won't be there?

Best regards,
Krzysztof


