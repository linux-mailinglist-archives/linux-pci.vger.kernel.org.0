Return-Path: <linux-pci+bounces-39900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F922C23C7E
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 09:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6447E189555F
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 08:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9437F2DF710;
	Fri, 31 Oct 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3zR/XC7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C52E6105;
	Fri, 31 Oct 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899217; cv=none; b=miOy5DNyK7aK/qyTQTUZYXIzLStT0judovkKusy0DTFbEe/IHBCR4SCJLF8Y8ecsv22wfcQGlyDF9xd7jvk2e+M1HXbYrJujPlrCWse1OnkbXE7sas/1aO8mVyXwULR0ziDOWjy6cx3CSum+JPPhb9y7V1Ocl8P2s7VZQPaRDRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899217; c=relaxed/simple;
	bh=7FtxklPeT6kKf2wTFmqdmmGJFJ7GxQ6bHxoFQMYY/V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueVUtmJwlM11LvVgmhSMuAt4paGrlO7+lLtxew/jz8+dsgjza6+9B2xw4rzbGvuvIOKRT1OHpjuimxy/KzV+Jh2F4CgnWsnXdJORbrond/t3Iqati5g8TMCCORZUKJ2FBvyGswnuN8gGrffoYLXfr7+L4Mudu9gEq/N/z5kl0Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3zR/XC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D0FC4CEE7;
	Fri, 31 Oct 2025 08:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761899216;
	bh=7FtxklPeT6kKf2wTFmqdmmGJFJ7GxQ6bHxoFQMYY/V4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3zR/XC7p6Zomw1FOVOBxx9Hg3K/K3GJWlmPCCuxACNGowc+e/9Lnz3fDyl1oam56
	 HN6xulnnJf4h19cSOG0ColJf3c/MoRjB91E03+KslAEijYiNWoO0jNmmBotvaMzzfE
	 CaVyetElwwXlVUospfMZWUmXYPpk46l4h/Doc1CNXHm+ZXdt1rSKJ9loGBPwNfog3J
	 UDQxJ8XqbftMrM5RT67moTYhKVxDL2tzKX15TfAIBlEdscNmNc9iyb+B3+/I/bU9tF
	 aBXiJxaLh7pt4mt993I2WiNqJaud8c2vrGlJL5fXWZXbOgoGlJb8sM3c+T45jdoqeO
	 FRQ8TsN2su5aw==
Date: Fri, 31 Oct 2025 13:56:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, "open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: rockchip: Propagate dev_err_probe return value
Message-ID: <kgnhru4vpkt6vgsmphrvxhpeuvl73tlt35vmi5ubgmnxyvdk5k@6tpvzojpaflz>
References: <20251018061127.7352-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251018061127.7352-1-linux.amoon@gmail.com>

On Sat, Oct 18, 2025 at 11:41:26AM +0530, Anand Moon wrote:
> Ensure that the return value from dev_err_probe() is consistently assigned
> back to return in all error paths within rockchip_pcie_init_port()
> function. This ensures the original error code are propagation for
> debugging.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 0f88da3788054..124ab7b9f3404 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -134,7 +134,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	err = reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS,
>  					rockchip->core_rsts);
>  	if (err) {
> -		dev_err_probe(dev, err, "Couldn't assert Core resets\n");
> +		err = dev_err_probe(dev, err, "Couldn't assert Core resets\n");

This change is pointless. Is the 'err' value going to change with the
reassignment? NO. Then what this change is about?

Please do not send cleanup patches that does nothing useful.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

