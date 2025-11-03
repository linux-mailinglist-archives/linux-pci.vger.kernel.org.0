Return-Path: <linux-pci+bounces-40134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4516DC2D9B0
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 19:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9E784EABEC
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01DC31B130;
	Mon,  3 Nov 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwB/JXL4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDFA2BE7C2;
	Mon,  3 Nov 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193440; cv=none; b=YAPjTLnOy/VEjh++hlTB/gA265oY1m2ROX/zLYNiFDJ2MDWTYglhXDYaKsp8/SBvuPoNVeM3fATorH3tq083L+k+K4LGYIcop48czNSQecNh0oOLOTRzW1pnukg6UOnjuBAyn0cCLyMnYjUn2AGPiKmxcqMCDssJvMQ3z6T5AaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193440; c=relaxed/simple;
	bh=dZ5DzmV8v+EdzX/v24I9P1Dtpu2Lj+7owRynAELiKHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RT7c+z7fjofJclUChLdytbRCWzKCrKLaqPD7dkm8li6FLDVbMSUQxKhBY6pMWt0IlXwLhynrNGDZNEuRD2Q+VvB0viBvdegtFkLEi0W3bizPcdkjTLCu9oHOGZtyex+uXoJJr/6DFr6+tauvsZ8vJgCuDxP4NHhbZuTegTtNEpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwB/JXL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03921C4CEE7;
	Mon,  3 Nov 2025 18:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762193440;
	bh=dZ5DzmV8v+EdzX/v24I9P1Dtpu2Lj+7owRynAELiKHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LwB/JXL47a6IAwbTm9xSakkJCGfu82fn/vpMMT6GFWRB6cQ0dL2vEVWxPkGkmN+N/
	 1EkdRhwDrAHXkytiFeIwv/kWUcnqe1++yX7rQ2xrNS6MoNfcRMuoVUIXLkO546Edak
	 EGkq79cEE0iemsqGiiDdxOTQZgkTya6f4jriLo0bfK2vQso/PHIHxYRjm1BIMXbLkw
	 MRYd/0ugIMaWgcmpGmednsEbbBZYJFD4BBdr5HPZvtN/nk7/C/+VSM0f+h1zscxvHE
	 kuXtZQ32SPf/HLrlhA7hUUtHooqG67Z7hW6Dc/Ez7IRSAiCGEP46p6X0vPqoYkmPaJ
	 FB1RjwG24qhMQ==
Date: Mon, 3 Nov 2025 12:10:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>
Subject: Re: [RFC PATCH 2/2] PCI: rockchip-host: drop wait on PERST# toggle
Message-ID: <20251103181038.GA1814635@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3d0c3a387ff461e62bbd66a0bde654a9a17761e.1762150971.git.geraldogabriel@gmail.com>

On Mon, Nov 03, 2025 at 03:27:25AM -0300, Geraldo Nascimento wrote:
> With this change PCIe will complete link-training with a known quirky
> device - Samsung OEM PM981a SSD. This is completely against the PCIe
> spec and yet it works as long as the power regulator for 3v3 PCIe
> power is not defined as always-on or boot-on.

What is against the spec?  In what way is this SSD "known quirky"?  Is
there a published erratum for it?

Removing this delay might make this SSD work, but if this delay is
required per PCIe spec, how can we be confident that other devices
will still work?

Reports of devices that still work is not really enough to move this
from the "hack that makes one device work" column to the "safe and
effective for all devices" column.

It's easy to see how *lack* of a delay can break something, but much
harder to imagine how *removing* a delay can make something work.
Devices must be able to tolerate pretty much arbitrary delays.

> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index ee1822ca01db..6add0faf6dc9 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -314,7 +314,6 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>  			    PCIE_CLIENT_CONFIG);
>  
> -	msleep(PCIE_T_PVPERL_MS);
>  	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
>  
>  	msleep(PCIE_RESET_CONFIG_WAIT_MS);
> -- 
> 2.49.0
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

