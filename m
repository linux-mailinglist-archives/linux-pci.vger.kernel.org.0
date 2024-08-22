Return-Path: <linux-pci+bounces-11985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B5F95AFE5
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 10:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A5F1C22B1B
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35D316D9AE;
	Thu, 22 Aug 2024 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od5wLCEb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C52165F11;
	Thu, 22 Aug 2024 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314145; cv=none; b=e0W12YHa/OqH8IIZC3oDHDy8x/TGM+6jKp7yCE0ij+Lp28+Z34xrE7/wMg7yFk1J8yDcJzvyccwYljsXd25uWqEDn0zzBV+0/qQxCwLlBtyn3LjVr6wQIqFiFCE7dCEU1vhEpWmf2KLOTDe4aJdwwxPuo7+lHAN7FhuPNXRfEa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314145; c=relaxed/simple;
	bh=FZCH7Q6neR/4XD7AGTYofIt0crMpnTbJZK58w00SlDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOT0/pGb3p+chGAD7BDVATFWrU98QKgzig3RuH/4uA84WeGMNqhV1H6CA1CRkVXCTwrFwaq4en5VtwElXRMwa2rQIhPPZ4MT2V1UNJSw6aGJV4jZcBHZlPqD6n23RGwXkCDUs5yOb4kpnxF0Mr2CDfJWuht/f5XT1V9t0v4LZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od5wLCEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F82C4AF0B;
	Thu, 22 Aug 2024 08:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724314145;
	bh=FZCH7Q6neR/4XD7AGTYofIt0crMpnTbJZK58w00SlDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Od5wLCEbDz2OrQv5ZEGb312brP7xfsOyI2olGQZXZbTpqx3isNqTzEhQIJSsJ3UNz
	 +0O2C4U4hsmNaFGBAs4iQTiI2t9zZMJAhXoaehaQTmGj2X6NiuB6dUKe+2ZQVuv7k1
	 yzkrHjq/jtr1APdqaGkcFe2aEDN1VdKcLJ6JfZiVXwKQiR9F7FGojOFHuA/6Sqi7bp
	 nWGe+RrM1zssc95riRMCCoJPWHI4gcGmO2ICqiX8V9NazDqgxCBtBxST1mACRq6sF0
	 Dk3eKaeeVN9YDmZmUIqO92lgJfPy62TQCsVVeHvI2fhWNmnOy+qfiv2Wz4aFZU4Otk
	 tPMbZRpxU/agw==
Date: Thu, 22 Aug 2024 10:08:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: marek.vasut+renesas@gmail.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4M
 compatible
Message-ID: <3y4w5ljxho5btyriajwwgzyltk3v4n4xt55br2dphimgrirb7l@44llshuapdo4>
References: <20240822064459.1133748-1-yoshihiro.shimoda.uh@renesas.com>
 <20240822064459.1133748-2-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822064459.1133748-2-yoshihiro.shimoda.uh@renesas.com>

On Thu, Aug 22, 2024 at 03:44:58PM +0900, Yoshihiro Shimoda wrote:
> Document bindings for R-Car V4M (R8A779H0) PCIe host module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


