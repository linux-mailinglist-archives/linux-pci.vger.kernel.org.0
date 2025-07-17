Return-Path: <linux-pci+bounces-32388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1800CB08D21
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 14:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C671C25987
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB952C1780;
	Thu, 17 Jul 2025 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuLmqI2i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC52C159C;
	Thu, 17 Jul 2025 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755937; cv=none; b=V8vUV5h4SWiAQjGT2BckqncQ0IOlJwb/Cau+4tmtw5jJmLTJPJVKiz538h1ushH9RIBGz45W3AG5r8a8u5GQwexTC/40jLgdIpPlzEfUxrJ23hzzrTEg0Ii9VvUyRhiM4Mj1UDIvvcJurOgmmhJFpZi1dHmz9RLHA6OjEl/C4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755937; c=relaxed/simple;
	bh=TP5rMj9dlXv1lXfyZ6bSZIOXkMvBLOg/7AxE1E2WJ0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7Db7oRdKZM8AsAq7M2gikMZZKN0oZICNN3YOkcx4Hsp7/+Fwa1yUiJ+1VW3SSlN1nBKAq2VitsaBIhZjGjagnJsLThJdQJHV/ZYQKWvE8Qmm8nBi1DIeINjhfzXz0gyVoK1gfAOcyn/WydD7hNTwpJkW0Cz7M2x7GI4VlwaFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuLmqI2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5650AC4CEE3;
	Thu, 17 Jul 2025 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752755935;
	bh=TP5rMj9dlXv1lXfyZ6bSZIOXkMvBLOg/7AxE1E2WJ0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuLmqI2ioiVo7XkWRx+pJanQ7t8F5mGs6z6mDKw/KJowfT2Vw6JcUeAdb59TNj+G+
	 gafjIqc8fRg0jhLv1usO9YpUTMiutQIoNtRw4+FvG2ri0zgozb4Z8c9ohovj1MOXVL
	 90c8EdZw9+a+lX+B+6OKPWj2sRcASpBe0VSSKrSr3aDYhAEZudlRXdq4OO7DtdqH5m
	 xiH7NydqddFan1+iuYAKatAUcwy3Pjl4OgaPPQUszjT6B3gNlf/Hy0jRg0kkyujTXz
	 WzLPdi2FS0IpwemfY00TFFGVU0VV52+J5Wo1PaDnMjlviOYTVCcZlUHCm8ubpO2tLU
	 27DeIVFtjfTsw==
Date: Thu, 17 Jul 2025 18:08:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:BROADCOM STB PCIE DRIVER" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: brcmstb: Replace open coded value with
 PCIE_T_RRS_READY_MS
Message-ID: <gghfznmeu3o6wegyr4seqxervrwsszrqvdbrusetsbvravq4cr@mcbvcwi3zh3p>
References: <20250624231923.990361-1-florian.fainelli@broadcom.com>
 <20250624231923.990361-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250624231923.990361-3-florian.fainelli@broadcom.com>

On Tue, Jun 24, 2025 at 04:19:23PM GMT, Florian Fainelli wrote:
> The delay that we are waiting on in brcm_pcie_start_link() is
> PCIE_T_RRS_READY_MS, use it.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 92887b394eb4..7fa2087e85db 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1337,7 +1337,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>  	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
>  	 * sections 2.2, PCIe r5.0, 6.6.1.
>  	 */

We don't need this comment also since it is part of RRS definition. I'll remove
it while applying.

- Mani

> -	msleep(100);
> +	msleep(PCIE_T_RRS_READY_MS);
>  
>  	/*
>  	 * Give the RC/EP even more time to wake up, before trying to
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

