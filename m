Return-Path: <linux-pci+bounces-29440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A877AD55C1
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 14:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF9C16EF06
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DDF27E1CA;
	Wed, 11 Jun 2025 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pypKI3Ia"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A669253F08;
	Wed, 11 Jun 2025 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645567; cv=none; b=cjwC4iD6PX4NlcnpPDZcQC4EoCPIAkEzUTov4FPqjqJ9UmPQ5y1byKIhpTQ7F8EKgX2cWxeOA0LsC7HZTK9sRXZ/XND5MS7H3jT2lJgxMVLWti1ZN1QFe642W+0rYY0cA5ieanWTQw25OXUiM3R9cwUvU1vo4JewsVXG+Tc/ovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645567; c=relaxed/simple;
	bh=OuFVXbIWmWJvGOj5ECS98GbcO0BbdJQump2TJj6s/1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5CxbRm3zmgqbStWWcCDyzj/905NazJYUHoQeqShgSMFYU+UE6mU8un0zzdBC5Cszl5brSXZWs99/6uM+kjmRk0/mZFJqCTnG+7WAenG7uoEWNUvGe53pRvLPPYCi4C6x7IPJ8qs/aQcIrBbiMwifiyHrWKZVJZ6I7kSwLCV2H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pypKI3Ia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A387DC4CEEE;
	Wed, 11 Jun 2025 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749645567;
	bh=OuFVXbIWmWJvGOj5ECS98GbcO0BbdJQump2TJj6s/1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pypKI3IadYZZ+Exqnu92P70tL6RYFiAd+Fx+g1v09JhS7HAuioJpp778S5zDamWGS
	 jIC/UxnIR8dktqlpa5yxWBIAsVqRuAfNbdehHaxmvIXcS85a/DTfSLjU6PSLaJwmpM
	 /J/OcE9vDzrYdtllI995p5la13a1UAzSIb/XLjcutGhZ8SorM2ILffyjP5Cs5fuvSG
	 /K3kb1JnptIGKxssmO9c20B5zARkOPVBZIwcZXheX/RBDIb7tUbETj/3oh/6seVTXq
	 rplR9diwAyvUHhMRvltjhro9lmZ9fYQSpNkPKdXPqX6G4SaGOjQXO8qoo5wjM/C447
	 x0qqs2PYThB2g==
Date: Wed, 11 Jun 2025 18:09:18 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] schemas: pci: bridge: Document clocks
Message-ID: <advhonmqnxm4s6r3cl7ll5y3jfc566fcjvetvlzvy7bztzetev@t75xmo5fktde>
References: <20250607194353.79124-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250607194353.79124-1-marek.vasut+renesas@mailbox.org>

On Sat, Jun 07, 2025 at 09:43:24PM +0200, Marek Vasut wrote:
> The PCIe slot may have clocks which are explicitly controlled
> by the OS, describe the clocks property.

The slot can only have 'REFCLK' as per the spec, not any other random clocks.

> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

With that fixed,

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Related to https://lore.kernel.org/all/CAMuHMdUFHKHKfymqa6jwfNnxZTAuH3kbj5WL+-zN=TR6XGd0eA@mail.gmail.com/
> ---
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  dtschema/schemas/pci/pci-bus-common.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
> index ca97a00..3c512cf 100644
> --- a/dtschema/schemas/pci/pci-bus-common.yaml
> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
> @@ -82,6 +82,8 @@ properties:
>      items:
>        maximum: 255
>  
> +  clocks: true
> +
>    external-facing:
>      description:
>        When present, the port is externally facing. All bridges and endpoints
> -- 
> 2.47.2
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

