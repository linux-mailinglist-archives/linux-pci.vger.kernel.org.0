Return-Path: <linux-pci+bounces-42116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BE759C8A0A4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 14:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D9423566E3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8486D296BCD;
	Wed, 26 Nov 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTLKoOxJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F4324B1C;
	Wed, 26 Nov 2025 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764163813; cv=none; b=M8FAWCheh1z/gzwRKHMi2au/WtgJuVtTMxZZ5QPqh47J03QX4Sh5gkhsovTJPxTcvB4lzG5XyW6nYLWmBgQa4v9xUoXnUYiWwynx+9Fcd39K2JZm6D31xrPuybd6NjOCqGUldRCdk0gBPnNSXW/IrHRtQxMOWDvBMLpXMgyrC4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764163813; c=relaxed/simple;
	bh=Z216M+xUGw2GstoG94tVpUUtHanANw2APL6ZZLCKi5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICZSlK2A6tIzgM0quJWyCnpOcpQYHZhHqbM9Y1yLJtt8u/iJi5VgJgInlGYJsePbfEXT6gEMg9NAftP7z2yJezp66/kL15x7c5cDQHCnFUQtLeoUDGu45itvD5zyDFus64lOZKZ5qxItdn1DIO5ksnjxlCLU15Km2pz5nEdjz/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTLKoOxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D588C113D0;
	Wed, 26 Nov 2025 13:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764163811;
	bh=Z216M+xUGw2GstoG94tVpUUtHanANw2APL6ZZLCKi5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JTLKoOxJ/NGVlRDVdmfNjZa18GbXEZhc/GKcGJ3CLW3pq9T0qkySQnQXJ4ibnLPcN
	 tnuQd8LWO9dNUyyTuqthIWzFeB19q8bXniLWRurwd4AmRtRAUgKITQdRmRJshX5cOH
	 rdPpL/zNG3SP6Ak8U6cLFZyZR+yx+U9e5Z0qbMFi6m8pRYGY5gOy/oBGaUZp+gk6PC
	 iHS3cu0DDfTOgpAtWvP3WL+nYUi1g7s8M+HCDIjX1MfML/ovyTlxOBIAJ+RVQDOZ4G
	 cZXUdI4OryIP5JsYiZjVSO28j986fydaGlVI3nrJe4o1ZzVPl/aYFiL/94cyJ/aKzo
	 c6IxUrgl0JNTg==
Date: Wed, 26 Nov 2025 19:00:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: andersson@kernel.org, robh@kernel.org, krzk@kernel.org, 
	helgaas@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com, 
	lukas@wunner.de
Subject: Re: [PATCH v3] schemas: pci: Document PCIe T_POWER_ON
Message-ID: <ek7xcuknyoadyel7btqqhdeqlw77yjt6itzzsujxud36rj4hjw@yzxj6lce2qy4>
References: <20251126103112.838549-1-krishna.chundru@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251126103112.838549-1-krishna.chundru@oss.qualcomm.com>

On Wed, Nov 26, 2025 at 04:01:12PM +0530, Krishna Chaitanya Chundru wrote:
> From PCIe r7, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
> minimum amount of time(in us) that each component must wait in L1.2.Exit
> after sampling CLKREQ# asserted before actively driving the interface to
> ensure no device is ever actively driving into an unpowered component and
> these values are based on the components and AC coupling capacitors used
> in the connection linking the two components.
> 
> This property should be used to indicate the T_POWER_ON and drivers using
> this property are responsible for parsing both the scale and the value of

s/parsing/programming

> T_POWER_ON to comply with the PCIe specification.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> Changes in v2:
> - Move the property to pci-device.yaml so that it will be applicable to
>   endpoint devices also (Mani).
> - Use latest spec (Lukas)
> - Link to v2: https://lore.kernel.org/all/20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com/
> Changes in v1:
> - Updated the commiit text (Mani).
> - Link to v1: https://lore.kernel.org/all/20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com/#t
> 
>  dtschema/schemas/pci/pci-device.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/dtschema/schemas/pci/pci-device.yaml b/dtschema/schemas/pci/pci-device.yaml
> index ca094a0..4baab71 100644
> --- a/dtschema/schemas/pci/pci-device.yaml
> +++ b/dtschema/schemas/pci/pci-device.yaml
> @@ -63,6 +63,15 @@ properties:
>      description: GPIO controlled connection to WAKE# signal
>      maxItems: 1
>  
> +  t-power-on-us:
> +    description:
> +      The minimum amount of time that each component must wait in
> +      L1.2.Exit after sampling CLKREQ# asserted before actively driving
> +      the interface to ensure no device is ever actively driving into an
> +      unpowered component. This value is based on the components and AC
> +      coupling capacitors used in the connection linking the two
> +      components(PCIe r7.0, sec 5.5.4).
> +
>  required:
>    - reg
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

