Return-Path: <linux-pci+bounces-32247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F60B07070
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 10:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE52188510F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 08:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8A82EAB63;
	Wed, 16 Jul 2025 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iiu//ig0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD6829A9D3;
	Wed, 16 Jul 2025 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654270; cv=none; b=KUiSi2XY+U4CFbF/JqrDggEA7z+xMhCZAal4xPs/Yk5t7LuG/0gJTxAHS8sR6ru4jX0IZOvVrtNHGdGxpCGdssbFwQHgsALBnyoY3sFyrgaBITsjoTjffQVTtYRzshnKLjDWzRES4vUbproUEhLVF3zjEZzjOBE2VwexFe8yu9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654270; c=relaxed/simple;
	bh=Sx6GtXQhUUHM3FrpmZ+GaCxjq7UxqdGBPOXm9TRFxoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb/iklETi6KWS5nPzu+GVvRJrYPfbVqHcANk23pnrlDuYw69rCX5iT3RTWw0fMkNuFFsLnHO01x1HUhTWl81FLHyc5fP9uoebpnD/NY6AZKzNbanGcAi9FUnt9TrMb45ajA7zWO3QRUjugBBSK89FGjr7r7pX+CgXOQ1HAl2rqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iiu//ig0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFDEC4CEF0;
	Wed, 16 Jul 2025 08:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752654270;
	bh=Sx6GtXQhUUHM3FrpmZ+GaCxjq7UxqdGBPOXm9TRFxoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iiu//ig0tvsYWLj3RYhibc9P+zvAzAbb29UT0vX3qk8p/xgxwKLdf3zW7fwGYc1Oj
	 AjEzWR0K269SObv38lNZWA5KeWYZ/Wv1szxIR7/2VkY64vkA3AXs+op48eVXtKkXCr
	 Rf5f2m7eVMdB4efgBFeU+ydDBGGB2kkZEilBlSb36zDBslg2cOU5mprxqHxhCXPSWL
	 jCOs/zzWzvSsfcyHaG7AJwtVPbQpy1VuNCV7y5zNqCOAD0y7XMJ4N6DUDGoa0eMaT6
	 N1ZW3ORoGmddFRSF1oL2BQu0Y2TrfHglL1GyLHzrmTcSLym1gc186GnN1KeSWs2wNt
	 87f12ZxVIRozQ==
Date: Wed, 16 Jul 2025 10:24:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 01/10] dt-bindings: soc: aspeed: Add ASPEED PCIe
 Config support
Message-ID: <20250716-wine-partridge-of-wonder-af10a6@krzk-bin>
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
 <20250715034320.2553837-2-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715034320.2553837-2-jacky_chou@aspeedtech.com>

On Tue, Jul 15, 2025 at 11:43:11AM +0800, Jacky Chou wrote:
> +maintainers:
> +  - Jacky Chou <jacky_chou@aspeedtech.com>
> +
> +description: |

Drop |

> +  The ASPEED PCIe configuration syscon block provides a set of registers shared
> +  by multiple PCIe-related devices within the SoC. This node represents the
> +  common configuration space that allows these devices to coordinate and manage
> +  shared PCIe settings, including address mapping, control, and status
> +  registers. The syscon interface enables for various PCIe devices to access
> +  and modify these shared registers in a consistent and centralized manner.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,pcie-cfg

NAK, see writing bindings. You already received comments about generic
compatible in the past.

Best regards,
Krzysztof


