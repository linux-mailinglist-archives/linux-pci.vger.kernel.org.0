Return-Path: <linux-pci+bounces-30898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F8FAEAF42
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 08:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C777169191
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F8C21ABCF;
	Fri, 27 Jun 2025 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKoDSdFG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5339421ABA3;
	Fri, 27 Jun 2025 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007290; cv=none; b=WmfQ1MfcqWPjeqR/noYRgmJ05LzTUrZu4v0k2bZzCHeMWyjxO/GjFs97mwfrSS8JlTKlA0dtWqFYkGxEH0OAo05lPVDc46AdW0apeCgV90zymvSJxDwtiilsdMTLrOX5oYstWjVaj5bZU/KBWunuIMyw54Lm+loubhq/Gn6ymrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007290; c=relaxed/simple;
	bh=JfCgW9HbTpeOku1zvHWwMxVzRgAAq76SRmjvxE7JOHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3dhO26XIRTm0YvM6xa7pIJkbF/qG378NE8ZE9nY9j9q03o2W5eRb0HH/DXgtPNGdVSBK+b9UAv2/T5dT8yIHLd5Qnu7xAKH6p6DB6oj0GBueGjnkPzFqGPUsmG7v/QJ0wPbAwoXjIRhnaGhDcWJqZvBTMxEP8Il1LgfGacJ6/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKoDSdFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1128CC4CEE3;
	Fri, 27 Jun 2025 06:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751007289;
	bh=JfCgW9HbTpeOku1zvHWwMxVzRgAAq76SRmjvxE7JOHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKoDSdFGJkCNvhF3Xu1UasZIiLobiK8/6c9da6j/VV9fKBmwFDWN77p/WbpQQfSkn
	 rnb+e8dpEm/mvMYW+NZjEr0bFfD1KWXiQ6y7R3yRMmCMH4s1L7XAAqq7lcigB+6J5c
	 N5QQMeXpFoIc3IEImjtpc2/PzTRx34UsY6kdQlUmkYR7QfbRA+mR2PjHFjsrqjr2zs
	 SYVurFWT7N5AtwZdqR/ETq5i13glR8pPLkxRJ1hoXtun39if5eU5Jwy2fvwEv9aEA2
	 W5Ua5/LSVUXsOUeYSC2KZKaGdvYGN3+e34GW0UBC1p2fOlyd3Oj9eEgY0qXHimvt+B
	 KU1/tGB99Mdaw==
Date: Fri, 27 Jun 2025 08:54:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: dwc: Add one more reference
 clock
Message-ID: <20250627-sensible-pigeon-of-reading-b021a3@krzk-bin>
References: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
 <20250626073804.3113757-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250626073804.3113757-2-hongxing.zhu@nxp.com>

On Thu, Jun 26, 2025 at 03:38:02PM +0800, Richard Zhu wrote:
> Add one more reference clock "extref" to be onhalf the reference clock
> that comes from external crystal oscillator.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index 34594972d8db..ee09e0d3bbab 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -105,6 +105,12 @@ properties:
>              define it with this name (for instance pipe, core and aux can
>              be connected to a single source of the periodic signal).
>            const: ref
> +        - description:
> +            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
> +            inputs, one from internal PLL, the other from off chip crystal
> +            oscillator. Use extref clock name to be onhalf of the reference
> +            clock comes form external crystal oscillator.

How internal PLL can be represented as 'ref' clock? Internal means it is
not outside, so impossible to represent.

Where is the DTS so we can look at big picture?


Best regards,
Krzysztof


