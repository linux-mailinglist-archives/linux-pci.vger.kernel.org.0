Return-Path: <linux-pci+bounces-39077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D27DBFF38E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B2AB4ED2BF
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 05:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1496326562D;
	Thu, 23 Oct 2025 05:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lb0od8Yx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2912258EE1
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761196029; cv=none; b=i16f5w6/Qb1qP8buihDBhQmUNArr9kf2HcK2fsBYCc5F4+StnnGt/srbYc291iSvAWkGHebPS7tjqkeyTE7BVdxnnssYTnMYYlV5RhYE+aOvbZieybpq/XaQAVd6aVA5IklAwm/EYyob4vy+Gch9qAf5Tm+WK+SojCskWdxI3iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761196029; c=relaxed/simple;
	bh=NzdJQP8m6XvcdrZE8aPNgKoWH6PxaP6bTK6w0q/5mP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXYF/41dHjCgpcKuQ39J3K8B0Cg6q/xii3vhxotiUzeJTDqGj2S763SX/JzljlJBvGuMvr0P8W8MSOA6ZVqci+6dJusXuR56HuM4Gcp20HD9rriffnCemn1IHtLY8sLNy9V8MKHVulHNTv/3q7+/LAUQDWhpfK56oBN9VaHb23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lb0od8Yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35909C4CEE7;
	Thu, 23 Oct 2025 05:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761196028;
	bh=NzdJQP8m6XvcdrZE8aPNgKoWH6PxaP6bTK6w0q/5mP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lb0od8Yxk/0ggE9lUW7Esd3FdxcAZC0BO2c/+oHMWV7q8Fq7ciDtlbpbFA/qFR3qq
	 Q4B0AOOrkzurrA+XacQCTtjCsogEq81cQecxwX1tckOmYBMiAIPXUwSku2YPRk+rs8
	 5kh0Pu/8D2nLTpb4d6GLHcOx5t+ej4Y1M/Oo5FTPO8ZModPEvcGSx+exrOlEndsNjq
	 6A6ZrNVUze9p7w75yLWTwgO0DdApvao11AoNF1ZFzUD93NI/bI4rnZOIt4AfF959/8
	 MQXV+4bHLkrU8DPwzhuSxaHJ6ExI7Vb2HVxErOywJRqBOvn8UXgDlml3OaEda6Mhdv
	 A7P8vRQKzCG4A==
Date: Thu, 23 Oct 2025 10:36:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add PCIe clkreq stuff for
 RK3588 EVB1
Message-ID: <w6t2ecg6gxflebglqfzf3wxtf436huscepxb5adbox4dah5y34@k7mj6p2tlsla>
References: <1761187883-150120-1-git-send-email-shawn.lin@rock-chips.com>
 <1761187883-150120-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1761187883-150120-2-git-send-email-shawn.lin@rock-chips.com>

On Thu, Oct 23, 2025 at 10:51:23AM +0800, Shawn Lin wrote:
> Add supports-clkreq and pinmux for PCIe ASPM L1 substates.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> Reviewed-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
> 
> Changes in v3:
> - add Hans' tag
> 
> Changes in v2: None
> 
>  arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> index ff1ba5e..c9d284c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> @@ -522,6 +522,7 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pcie2_0_rst>, <&pcie2_0_wake>, <&pcie2_0_clkreq>, <&wifi_host_wake_irq>;
>  	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> +	supports-clkreq;
>  	vpcie3v3-supply = <&vcc3v3_wlan>;
>  	status = "okay";
>  
> @@ -545,7 +546,8 @@
>  &pcie2x1l1 {
>  	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie2_1_rst>, <&rtl8111_isolate>;
> +	pinctrl-0 = <&pcie2_1_rst>, <&rtl8111_isolate>, <&pcie30x1m1_1_clkreqn>;
> +	supports-clkreq;
>  	status = "okay";
>  };
>  
> @@ -555,7 +557,8 @@
>  
>  &pcie3x4 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie3_reset>;
> +	pinctrl-0 = <&pcie3_reset>, <&pcie30x4m1_clkreqn>;
> +	supports-clkreq;
>  	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>  	vpcie3v3-supply = <&vcc3v3_pcie30>;
>  	status = "okay";
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

