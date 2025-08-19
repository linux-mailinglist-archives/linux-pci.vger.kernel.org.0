Return-Path: <linux-pci+bounces-34318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EFAB2CB85
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 19:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E9CA05458
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 17:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950F330DD3E;
	Tue, 19 Aug 2025 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGCuDVAF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A62550CA;
	Tue, 19 Aug 2025 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626061; cv=none; b=Pso+26TcEB7NW1J97rBZJeNBSOzzHYa6c+JlKu4BxBG5cLnhHlDTGbqvjSNfbGKhoe8TDjnU8gLF7LLIarI8nY7+e8bnwaQZDzp4RzSBVlPjWjX7F2ay4lf396U3X5yfydNh60XZ9FG4WumyhFkavWbyuYejcLmmfJPxbh0YnmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626061; c=relaxed/simple;
	bh=JD7kYuxO92z/JJFCG1cOJ4aq6L3v+QS95O3Ph2Iqvv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDf5fKnPeoqBiCYiiB3uMYGRWlIelOwFKPYX2PkmK44sHnaN5Vtv7IkSLC7GmSa5akk9zrqurLGsL2x+lqZZmXybGzjekRxE9ouAKhdtgleLULngzlYKbUjKdxHhZgA43iz5mJBDK/vNpOWYYW5xuk7eC6c8bAKR3LuG2/r7+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGCuDVAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B4BC4CEF4;
	Tue, 19 Aug 2025 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755626060;
	bh=JD7kYuxO92z/JJFCG1cOJ4aq6L3v+QS95O3Ph2Iqvv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGCuDVAFFGJ22zJ+TsHWsIQ8Q64K+hB1hXHKSf624lWatIXeLvjl35BmXROfMT6nd
	 Jm9R9Yo76iVxVpkXKiXgDfDxWKNk/OuGxq+GgHrXUYgVx+mcEah4yhalrbxBIgeZZz
	 l44TfWhfNrAyvsZr62oPFPAAfQrdccWsOUuTKK3apHCICs+hNhRa3sz41sjOIe8hLR
	 pDiMhDZEHk2zCIGKrOeR3ZUNEXxqOhAJcFqX7Tw8cRPqnEUgMHKi0KORzUiirnMGd9
	 L/sGmPITkOBxKU+gTuJxUeTFggzfZ4eiZ0+w/OlOqUBP5AwAEnp1HXI8c2Od20W3at
	 T9v7qnSv6AC6A==
Date: Tue, 19 Aug 2025 23:24:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, kernel@collabora.com, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek-gen3: Assert MAC Reset only for a delay
 during PM suspend sequence
Message-ID: <nlbmei3vwti6lybvukqgti4zqfb42w5tmyd7oodlpwkm5q3jqs@sj52ifgulvl6>
References: <20250709-mtk8395-fix-pcie-suspend-v1-1-0c7d6416f1a3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709-mtk8395-fix-pcie-suspend-v1-1-0c7d6416f1a3@collabora.com>

On Wed, Jul 09, 2025 at 05:42:21PM GMT, Louis-Alexis Eyraud wrote:
> In the pcie-mediatek-gen3 driver, the PM suspend callback function
> powers down the PCIE link to stop the clocks and PHY and also assert
> the MAC and PHY resets.
> 
> On MT8195 SoC, asserting the MAC reset for PCIe port 0 during suspend
> sequence and letting it asserted leads the system to hang during resume
> sequence because the PCIE link remains down after powering it up:
> ```
> mtk-pcie-gen3 112f0000.pcie: PCIe link down, current LTSSM state:
>   detect.quiet (0x0)
> mtk-pcie-gen3 112f0000.pcie: PM: dpm_run_callback(): genpd_resume_noirq
>   returns -110
> mtk-pcie-gen3 112f0000.pcie: PM: failed to resume noirq: error -110
> ```
> Deasserting it before suspend sequence is completed, allows the system
> to resume properly.
> 

This feels strange. 'mac_reset' is getting deasserted in mtk_pcie_power_up(),
which gets called before mtk_pcie_startup_port() from where the 'PCIe link down'
message is getting printed for Link Down condition. This same sequence is
carried out during probe() stage also.

So this indicates that the reset is not deasserted properly at resume time? Does
the SoC has some quirk like SKIP_PCIE_RSTB?

- Mani

> So, add in the mtk_pcie_power_down function a flag parameter to say if the
> device is being suspended and in this case, make the MAC reset be
> deasserted after PCIE_MTK_RESET_TIME_US (=10us) delay.
> 
> Fixes: d537dc125f07 ("PCI: mediatek-gen3: Add system PM support")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
> This patch fixes a hang issue during a suspend/resume sequence that
> occurs on Mediatek Genio 1200 EVK board at least with commands such as
> `systemctl suspend` or `echo mem > /sys/power/state` with the
> following error (with no_console_suspend kernel parameter):
> ```
> PM: suspend entry (deep)
> Filesystems sync: 0.044 seconds
> Freezing user space processes
> Freezing user space processes completed (elapsed 0.001 seconds)
> OOM killer disabled.
> Freezing remaining freezable tasks
> Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> queueing ieee80211 work while going to suspend
> dwmac-mediatek 11021000.ethernet end0: Link is Down
> Disabling non-boot CPUs ...
> psci: CPU7 killed (polled 0 ms)
> psci: CPU6 killed (polled 0 ms)
> psci: CPU5 killed (polled 4 ms)
> psci: CPU4 killed (polled 0 ms)
> psci: CPU3 killed (polled 0 ms)
> psci: CPU2 killed (polled 0 ms)
> psci: CPU1 killed (polled 4 ms)
> Enabling non-boot CPUs ...
> Detected VIPT I-cache on CPU1
> GICv3: CPU1: found redistributor 100 region 0:0x000000000c060000
> CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
> CPU1 is up
> Detected VIPT I-cache on CPU2
> GICv3: CPU2: found redistributor 200 region 0:0x000000000c080000
> CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
> CPU2 is up
> Detected VIPT I-cache on CPU3
> GICv3: CPU3: found redistributor 300 region 0:0x000000000c0a0000
> CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
> CPU3 is up
> Detected PIPT I-cache on CPU4
> GICv3: CPU4: found redistributor 400 region 0:0x000000000c0c0000
> CPU4: Booted secondary processor 0x0000000400 [0x411fd410]
> CPU4 is up
> Detected PIPT I-cache on CPU5
> GICv3: CPU5: found redistributor 500 region 0:0x000000000c0e0000
> CPU5: Booted secondary processor 0x0000000500 [0x411fd410]
> CPU5 is up
> Detected PIPT I-cache on CPU6
> GICv3: CPU6: found redistributor 600 region 0:0x000000000c100000
> CPU6: Booted secondary processor 0x0000000600 [0x411fd410]
> CPU6 is up
> Detected PIPT I-cache on CPU7
> GICv3: CPU7: found redistributor 700 region 0:0x000000000c120000
> CPU7: Booted secondary processor 0x0000000700 [0x411fd410]
> CPU7 is up
> mtk-pcie-gen3 112f0000.pcie: PCIe link down, current LTSSM state:
>   detect.quiet (0x0)
> mtk-pcie-gen3 112f0000.pcie: PM: dpm_run_callback(): genpd_resume_noirq
>   returns -110
> mtk-pcie-gen3 112f0000.pcie: PM: failed to resume noirq: error -110
> dwmac4: Master AXI performs any burst length
> dwmac-mediatek 11021000.ethernet end0: Enabling Safety Features
> dwmac-mediatek 11021000.ethernet end0: IEEE 1588-2008 Advanced 
>   Timestamp supported
> dwmac-mediatek 11021000.ethernet end0: configuring for phy/rgmii-rxid
>   link mode
> SVSB_GPU_LOW: svs_init02_isr_handler: VOP74~30:0x1e1f1f20~0x21222324,
>   DC:0x00000000
> ```
> 
> Tested on Mediatek Genio 1200-EVK board with a kernel based
> on linux-next (tag: 20250708).
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 5464b4ae5c20c6c167b172dba598a77af70c6ad2..e4c33275abfae20f0652d136d5cc4b21237ac4e9 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -1107,13 +1107,18 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
>  	return err;
>  }
>  
> -static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
> +static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie, bool is_suspend)
>  {
>  	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>  
>  	pm_runtime_put_sync(pcie->dev);
>  	pm_runtime_disable(pcie->dev);
>  	reset_control_assert(pcie->mac_reset);
> +	if (is_suspend) {
> +		/* deassert after a delay to avoid hang issue at resume time */
> +		usleep_range(PCIE_MTK_RESET_TIME_US, 2 * PCIE_MTK_RESET_TIME_US);
> +		reset_control_deassert(pcie->mac_reset);
> +	}
>  
>  	phy_power_off(pcie->phy);
>  	phy_exit(pcie->phy);
> @@ -1179,7 +1184,7 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>  	return 0;
>  
>  err_setup:
> -	mtk_pcie_power_down(pcie);
> +	mtk_pcie_power_down(pcie, false);
>  
>  	return err;
>  }
> @@ -1211,7 +1216,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>  	err = pci_host_probe(host);
>  	if (err) {
>  		mtk_pcie_irq_teardown(pcie);
> -		mtk_pcie_power_down(pcie);
> +		mtk_pcie_power_down(pcie, false);
>  		return err;
>  	}
>  
> @@ -1229,7 +1234,7 @@ static void mtk_pcie_remove(struct platform_device *pdev)
>  	pci_unlock_rescan_remove();
>  
>  	mtk_pcie_irq_teardown(pcie);
> -	mtk_pcie_power_down(pcie);
> +	mtk_pcie_power_down(pcie, false);
>  }
>  
>  static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
> @@ -1306,7 +1311,7 @@ static int mtk_pcie_suspend_noirq(struct device *dev)
>  	dev_dbg(pcie->dev, "entered L2 states successfully");
>  
>  	mtk_pcie_irq_save(pcie);
> -	mtk_pcie_power_down(pcie);
> +	mtk_pcie_power_down(pcie, true);
>  
>  	return 0;
>  }
> @@ -1322,7 +1327,7 @@ static int mtk_pcie_resume_noirq(struct device *dev)
>  
>  	err = mtk_pcie_startup_port(pcie);
>  	if (err) {
> -		mtk_pcie_power_down(pcie);
> +		mtk_pcie_power_down(pcie, false);
>  		return err;
>  	}
>  
> 
> ---
> base-commit: 82c74bc3880ee6bd6c1bcb9ad5c4695eb1fb7cb7
> change-id: 20250708-mtk8395-fix-pcie-suspend-f9b7686bf6cb
> 
> Best regards,
> -- 
> Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

