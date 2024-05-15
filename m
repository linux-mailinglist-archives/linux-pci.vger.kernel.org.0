Return-Path: <linux-pci+bounces-7536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD118C6DB5
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 23:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03AE1C212DA
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 21:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4040B15B145;
	Wed, 15 May 2024 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3dFccox"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD92155A57;
	Wed, 15 May 2024 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807929; cv=none; b=WNk5N8UeVu90ZGOwUDAoXQpL97h6UINlSUr44mS3tlFN6BOUsup7mL+Z7a2Vrkz0li9jATQNdFZESMaa1PzlCZX0t/zUMNwPANmK0l5kS9ppn3aXEu8Dd5JaE7K9a7xKY86c+sZOamk0DnPIKrQ0gRRiFIE+u01taCXzkdhCrNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807929; c=relaxed/simple;
	bh=GV4ctJ7S6o2h1VMQ6K3QvFDmjV30mayxRlqtKeBqg1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LGyevu7B8TA9LuKM5eFCIB1N1T9gVFROSFnNTUuP7IAJPMl7RJfsy3o6jGOqxm4ZfkksnwqyQaCxupQcPh5XUBLKkzqm8Wa85MBeVFJXuTMk8B5gmXwkUvW46J048nE2xGF7AZnTg0qq9PL1m6chVKhEaHk+3tZrvXpbwbE019A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3dFccox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A86C116B1;
	Wed, 15 May 2024 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715807928;
	bh=GV4ctJ7S6o2h1VMQ6K3QvFDmjV30mayxRlqtKeBqg1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P3dFccoxomCIHJqy4XeaDnH+WifIbD1n9DRECJaYOjnB+pHNmRRXshO4DdAU+2FLb
	 NlhEW6MafzcM0Jbcj+2VwkslZzf09wUlmRFmnFGeMCKCGuQiSiCXRyuvUskvBfYJ4L
	 9YDfoS7RbZBpcdhYecRCenElUV5ttxPpFcjhji8zret1J/jejjnGAfsCGAzIrywguU
	 RNfW1bWqB9RHZNuQilAHblPZjMOR8GJcShYynFvRsCD97XsAt6bNHqTsLBltZ8qsUC
	 nffGptSFneFjepbnxK3AjYyTduFnuCsBgq/8XBr0adLLkcxWlvo9sKO/GwSRTDbP98
	 2Q6fb1M5tmZeg==
Date: Wed, 15 May 2024 16:18:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Brian Norris <briannorris@chromium.org>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, stable@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: Re: [PATCH] PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting
 ep_gpio
Message-ID: <20240515211846.GA2139223@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-pci-rockchip-perst-fix-v1-1-4800b1d4d954@linaro.org>

On Tue, Apr 16, 2024 at 11:12:35AM +0530, Manivannan Sadhasivam wrote:
> Rockchip platforms use 'GPIO_ACTIVE_HIGH' flag in the devicetree definition
> for ep_gpio. This means, whatever the logical value set by the driver for
> the ep_gpio, physical line will output the same logic level.
> 
> For instance,
> 
> 	gpiod_set_value_cansleep(rockchip->ep_gpio, 0); --> Level low
> 	gpiod_set_value_cansleep(rockchip->ep_gpio, 1); --> Level high
> 
> But while requesting the ep_gpio, GPIOD_OUT_HIGH flag is currently used.
> Now, this also causes the physical line to output 'high' creating trouble
> for endpoint devices during host reboot.
> 
> When host reboot happens, the ep_gpio will initially output 'low' due to
> the GPIO getting reset to its POR value. Then during host controller probe,
> it will output 'high' due to GPIOD_OUT_HIGH flag. Then during
> rockchip_pcie_host_init_port(), it will first output 'low' and then 'high'
> indicating the completion of controller initialization.
> 
> On the endpoint side, each output 'low' of ep_gpio is accounted for PERST#
> assert and 'high' for PERST# deassert. With the above mentioned flow during
> host reboot, endpoint will witness below state changes for PERST#:
> 
> 	(1) PERST# assert - GPIO POR state
> 	(2) PERST# deassert - GPIOD_OUT_HIGH while requesting GPIO
> 	(3) PERST# assert - rockchip_pcie_host_init_port()
> 	(4) PERST# deassert - rockchip_pcie_host_init_port()
> 
> Now the time interval between (2) and (3) is very short as both happen
> during the driver probe(), and this results in a race in the endpoint.
> Because, before completing the PERST# deassertion in (2), endpoint got
> another PERST# assert in (3).
> 
> A proper way to fix this issue is to change the GPIOD_OUT_HIGH flag in (2)
> to GPIOD_OUT_LOW. Because the usual convention is to request the GPIO with
> a state corresponding to its 'initial/default' value and let the driver
> change the state of the GPIO when required.
> 
> As per that, the ep_gpio should be requested with GPIOD_OUT_LOW as it
> corresponds to the POR value of '0' (PERST# assert in the endpoint). Then
> the driver can change the state of the ep_gpio later in
> rockchip_pcie_host_init_port() as per the initialization sequence.
> 
> This fixes the firmware crash issue in Qcom based modems connected to
> Rockpro64 based board.
> 
> Cc:  <stable@vger.kernel.org> # 4.9
> Reported-by: Slark Xiao <slark_xiao@163.com>
> Closes: https://lore.kernel.org/mhi/20240402045647.GG2933@thinkpad/
> Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied by Krzysztof to pci/controller/rockchip, but his outgoing mail
queue was broken.  Trying to squeeze it into v6.10.

> ---
>  drivers/pci/controller/pcie-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 0ef2e622d36e..c07d7129f1c7 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -121,7 +121,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  
>  	if (rockchip->is_rc) {
>  		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
> -							    GPIOD_OUT_HIGH);
> +							    GPIOD_OUT_LOW);
>  		if (IS_ERR(rockchip->ep_gpio))
>  			return dev_err_probe(dev, PTR_ERR(rockchip->ep_gpio),
>  					     "failed to get ep GPIO\n");
> 
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240416-pci-rockchip-perst-fix-88c922621d9a
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

