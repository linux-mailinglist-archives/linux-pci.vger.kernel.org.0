Return-Path: <linux-pci+bounces-40028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D6CC2806E
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 15:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E41189F317
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC8C1ADC83;
	Sat,  1 Nov 2025 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="midrRS9r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3302CDDC3;
	Sat,  1 Nov 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762005596; cv=none; b=MB9ctok/bSFXiZe7KeaKfl0TkO2yg8VAQBYaeAjkNHlWJ9DtChqtkv1zjH4neXupv55PFkcDqjo8vM7gvx/ks01gjyek4Ah3PD0/exluupUufSdfzbTt378+IDXhQGxJC7tQUX/bdmZYDQJtZhqo9d0IOF5CsRqSkNQj2vT3arM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762005596; c=relaxed/simple;
	bh=m7C3U3qzThf33XwoRsd1OWSRs7f7Z7SEULSpUd0++FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSw/VyJjQ+O/t9tvtYD8NJFGMZxcUO4NnoVZnW9n/dB6zVaKkzRPCwPYtCy2D4Y5BrtUXc7DyDQVSx/eGbfTV1iZWF5VfQyeuHk6wYi9W/exK5SctYMwyAM+6eLQonsfC2M2eGZyvsg7Zyei1edAbhAtw5HKQdAK4xrN8xZJZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=midrRS9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF889C4CEF1;
	Sat,  1 Nov 2025 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762005595;
	bh=m7C3U3qzThf33XwoRsd1OWSRs7f7Z7SEULSpUd0++FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=midrRS9rdrC+XyGBuprUT4byWe1Zbx/aHwRVsM+laKgkIPY7Hx0MJsydN9UB+Mv1u
	 LbjwBJ0uN6ZNQlsengRus2AVi7f6atWT6IJu7UjpqkpWDAZamMvSWB3BNNYmUwAmmy
	 zR9gHFpHDvN6JJxI4WpQYjKhQsgMlRV4KOVeQIQNqQtdNRtbw5Z5AJtWih8S9HhBbb
	 392hKPrCZIEMqw4uzD3aHXmWt084ouHdWBexpDvcUYuupitHWxQ80xCGsYj1Q50qJi
	 cTIpw3gZ3ylkPAMmbZC1FX7GqXEHUDAHY5CZ3pHoTgurhIc0I2X1DvN70aD/U529w2
	 pp8HI2n2Tgf8Q==
Date: Sat, 1 Nov 2025 19:29:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v4 0/9] PCI: dw-rockchip: add system suspend support
Message-ID: <cf6zumlp4iiltglu7bbrpdeysaznrkyvlemwl4lxwkfjkgux7a@wl37bxilsprx>
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>

On Wed, Oct 29, 2025 at 06:56:39PM +0100, Sebastian Reichel wrote:
> I've recently been working on fixing up at least basic system suspend
> support on the Rockchip RK3576 platform. Currently the biggest open
> issue is missing support in the PCIe driver. This series is a follow-up
> for Shawn Lin's series with feedback from Niklas Cassel and Manivannan
> Sadhasivam being handled as well as some of my own changes fixing up
> things I noticed.
> 
> In opposite to Shawn Lin I did not test with different peripherals as my
> main goal is getting basic suspend to ram working in the first place.

Wouldn't it break users who have connected endpoint devices and suspend their
platform? I don't want to have an untested feature that could potentially cause
regressions, just for the sake of getting basic system PM.

But if your goal is to just add basic system PM operations for CI testing, then
I would suggest you to do something minimal in the suspend/resume path that
don't disrupt the operation of a device.

But this also should be tested with some devices for sanity.

- Mani

> I
> did notice issues with the Broadcom WLAN card on the RK3576 EVB.
> Suspending that platform without a driver being probed works, but after
> probing brcmfmac suspend is aborted because brcmf_pcie_pm_enter_D3()
> does not work. As far as I can tell the problem is unrelated to the
> Rockchip PCIe driver.
> 
> Changes since PATCHv3:
>  * https://lore.kernel.org/linux-pci/1744940759-23823-1-git-send-email-shawn.lin@rock-chips.com/
>  * rename rockchip_pcie_get_ltssm to rockchip_pcie_get_ltssm_status_reg
>    in a separate patch (Niklas Cassel)
>  * rename rockchip_pcie_get_pure_ltssm to rockchip_pcie_get_ltssm_state
>    in a separate patch (Niklas Cassel)
>  * Move devm_phy_get out of phy_init to probe in a separate patch
>    (Manivannan Sadhasivam)
>  * Add helper function for enhanced LTSSM control mode in a separate patch
>    (Niklas Cassel)
>  * Add helper function for controller mode in a separate patch
>    (Niklas Cassel)
>  * Add helper function for DDL indicator in a separate patch
>    (Niklas Cassel)
>  * Move rockchip_pcie_pme_turn_off implementation in a separate patch
>  * Rebase to v6.18-rc3 using new FIELD_PREP_WM16()
>  * Improve readability of PME_TURN_OFF/PME_TO_ACK defines (Manivannan Sadhasivam)
>  * Fix usage of reverse Xmas (Manivannan Sadhasivam)
>  * Assert PERST# before turning off other resources (Manivannan Sadhasivam)
>  * Improve some error messages (Manivannan Sadhasivam)
>  * Rename goto labels as per their purpose (Manivannan Sadhasivam)
>  * Add extra patch for dw_pcie_resume_noirq, since I've seen errors
>    during resume on boards not having anything plugged into their PCIe
>    port
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Sebastian Reichel (9):
>       PCI: dw-rockchip: Rename rockchip_pcie_get_ltssm function
>       PCI: dw-rockchip: Support get_ltssm operation
>       PCI: dw-rockchip: Move devm_phy_get out of phy_init
>       PCI: dw-rockchip: Add helper function for enhanced LTSSM control mode
>       PCI: dw-rockchip: Add helper function for controller mode
>       PCI: dw-rockchip: Add helper function for DDL indicator
>       PCI: dw-rockchip: Add pme_turn_off support
>       PCI: dw-rockchip: Add system PM support
>       PCI: dwc: support missing PCIe device on resume
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c |  13 +-
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c     | 220 ++++++++++++++++++----
>  2 files changed, 198 insertions(+), 35 deletions(-)
> ---
> base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
> change-id: 20251028-rockchip-pcie-system-suspend-86cf08a7b229
> 
> Best regards,
> -- 
> Sebastian Reichel <sebastian.reichel@collabora.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

