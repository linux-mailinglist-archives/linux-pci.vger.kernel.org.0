Return-Path: <linux-pci+bounces-39903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C43CC23D9E
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 09:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7133B54C8
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 08:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319D72EBBA8;
	Fri, 31 Oct 2025 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVthp2o3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50A2E8B81;
	Fri, 31 Oct 2025 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899960; cv=none; b=Nbc4nqdw1iztYLpJho2tDr+2uchRcbo6wjTb3ow76DpNM5chpTyU8ThVoGNcR6b/dXtntZYWIWXIRF0DrKUzJTiu1J3cFdB3rKrwjRos/OeELEDF0kuNe9wbyR4TACGFlvHCWYz0j/AXkDrgXtw5uTV4OYmgX4YZWM7uPTcvJdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899960; c=relaxed/simple;
	bh=k79R0Hpx74QOJ14uPbnMxmO5AYu0XzyA/jnOzGhcDXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlIozpXtFznRcHHnvAVlZEY5+M3tbaTN+W4/EBoMoa2hds8BFmkTBum4qpKPK06SNSH6ZqLwa0ELLCoGQ8Lt2u3doLIqcWLVT7sAzJ0uACLoXojLPkHiyWpUuxw2wPqZtTANUdqDSjZjcN0fxMmT8Om0lGyakO3cQTI2P82aq1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVthp2o3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8112EC4CEE7;
	Fri, 31 Oct 2025 08:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761899959;
	bh=k79R0Hpx74QOJ14uPbnMxmO5AYu0XzyA/jnOzGhcDXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVthp2o3amxt2TBTbBgyM45rfymEwJoPZwEW9FhdA7296shiaUGS1dax/8mhMdXH7
	 ogY9IlrGVeamaW8vqfi0VaLkm+60ibSG6d1B+ANO+kJi53cf/BOFIi130riPokoKgA
	 qg38nsA5JflgYuxLpSBOpzWbClZVWwVodc0jvx0y1EDuLIpRj2zgH+zRQ5hvMP3yfs
	 Y7eyaTzvuXq4BVseuffgmanbQIwniOfpzthdZGLnGR6wmR/7VJGS/ijIg10UHph/pv
	 /ybpYX75EQuKWzIOn3BVIVpsva8pvLZFEGITebmzL311N0Bci+62OhdiB/Z5lFnhfZ
	 f7p0Tq13gdDlg==
Date: Fri, 31 Oct 2025 14:09:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] PCI: dw-rockchip: Add runtime PM support to
 Rockchip PCIe driver
Message-ID: <ukgkfetbggzon4ppndl7gpitlsz7hjhzhyx3dgxqhdo52exguy@bqksd7d27lpy>
References: <20251027145602.199154-1-linux.amoon@gmail.com>
 <20251027145602.199154-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027145602.199154-3-linux.amoon@gmail.com>

On Mon, Oct 27, 2025 at 08:25:30PM +0530, Anand Moon wrote:
> Add runtime power management support to the Rockchip DesignWare PCIe
> controller driver by enabling devm_pm_runtime() in the probe function.
> These changes allow the PCIe controller to suspend and resume dynamically,
> improving power efficiency on supported platforms.
> 

Seriously? How can this patch improve the power efficiency if it is not doing
any PM operation on its own?

Again a pointless patch.

- Mani

> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index b878ae8e2b3e..5026598d09f8 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  
> @@ -690,6 +691,20 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto deinit_phy;
>  
> +	ret = pm_runtime_set_suspended(dev);
> +	if (ret)
> +		goto disable_pm_runtime;
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret) {
> +		ret = dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +		goto deinit_clk;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		goto disable_pm_runtime;
> +
>  	switch (data->mode) {
>  	case DW_PCIE_RC_TYPE:
>  		ret = rockchip_pcie_configure_rc(pdev, rockchip);
> @@ -709,7 +724,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +disable_pm_runtime:
> +	pm_runtime_disable(dev);
>  deinit_clk:
> +	pm_runtime_no_callbacks(dev);
>  	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>  deinit_phy:
>  	rockchip_pcie_phy_deinit(rockchip);
> @@ -725,6 +743,9 @@ static void rockchip_pcie_remove(struct platform_device *pdev)
>  	/* Perform other cleanups as necessary */
>  	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>  	rockchip_pcie_phy_deinit(rockchip);
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	pm_runtime_no_callbacks(dev);
>  }
>  
>  static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
> -- 
> 2.50.1
> 

-- 
மணிவண்ணன் சதாசிவம்

