Return-Path: <linux-pci+bounces-39486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E664C127AD
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 02:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621C95E3AE4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 01:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FA320297E;
	Tue, 28 Oct 2025 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="aKPeZjdr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3271.qiye.163.com (mail-m3271.qiye.163.com [220.197.32.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518B5221F17;
	Tue, 28 Oct 2025 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761613211; cv=none; b=WaQSaLtSXVtFETJHxIsMlfuT866XBEieAsBjWlJXK1p50HvfOOE9etAuUstYTayjYTjNDwX0PNrLaBOv3/hKlUh6Uy0Sl79RgKfi/2553MpkyGlSM/vQkfe9KmGK0T1BTjznPaE6P0/o2i/Ylj8d1IgqylbC3L2LQxXtA9JLCX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761613211; c=relaxed/simple;
	bh=/MgNSB4BmLt0vPgHTRHS6LKWGzxG4RX8Wp1NJWxp58Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HoU4wJm70B7XCn3JNUW++A4jp6i4nXz9f7X8Mazt9/XukyscqNgxgQ563uQp2GidcmjEtVKErauLmi0ZGC1iHhTrXSHslNrQTHFxPwsVYPVJy++O5awnZcpaPCuYXExu0r3c7uNgfsjP8RUolkEpfjkiwK+TpxsIm3lFSBO6c84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=aKPeZjdr; arc=none smtp.client-ip=220.197.32.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2764cdbd9;
	Tue, 28 Oct 2025 08:44:37 +0800 (GMT+08:00)
Message-ID: <cfaa4824-a59a-4106-b2c1-befce2af0324@rock-chips.com>
Date: Tue, 28 Oct 2025 08:44:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com
Subject: Re: [PATCH v1 2/2] PCI: dw-rockchip: Add runtime PM support to
 Rockchip PCIe driver
To: Anand Moon <linux.amoon@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Niklas Cassel <cassel@kernel.org>, Hans Zhang <18255117159@163.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251027145602.199154-1-linux.amoon@gmail.com>
 <20251027145602.199154-3-linux.amoon@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251027145602.199154-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2846258d09cckunmfb2044f69bef6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpJSVYfTE5DGRgZGk9MTEtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=aKPeZjdrPMbSfHYI71aE7ibLXgYuDZdEaanjrVCXkI88WLjfdtNNEkHyLOVQX4iP4ccGH9O87aczzz9yJgpt0qIvPf9vUNeBnOk5yYERMivQXertqgmAhYLcerqfPVC3t9fVqBs/V6CtNquFh6vxTcC1yCd6Obb6gD2aRfvr3FA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=A+HDiRgC5t4Ys8kCexpdAvL//Urk5g0DuwaI2Z/zH6k=;
	h=date:mime-version:subject:message-id:from;

在 2025/10/27 星期一 22:55, Anand Moon 写道:
> Add runtime power management support to the Rockchip DesignWare PCIe
> controller driver by enabling devm_pm_runtime() in the probe function.
> These changes allow the PCIe controller to suspend and resume dynamically,
> improving power efficiency on supported platforms.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 21 +++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index b878ae8e2b3e..5026598d09f8 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -20,6 +20,7 @@
>   #include <linux/of_irq.h>
>   #include <linux/phy/phy.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/regmap.h>
>   #include <linux/reset.h>
>   
> @@ -690,6 +691,20 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto deinit_phy;
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
>   	switch (data->mode) {
>   	case DW_PCIE_RC_TYPE:
>   		ret = rockchip_pcie_configure_rc(pdev, rockchip);
> @@ -709,7 +724,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>   
>   	return 0;
>   
> +disable_pm_runtime:

We need to call reset_control_assert(rockchip->rst) before releasing the
the pm refcount. The problem we faced on vendor kernel is there might be 
still on-going transaction from IP to the AXI which blocks genpd to be
powered down.

> +	pm_runtime_disable(dev);
>   deinit_clk:
> +	pm_runtime_no_callbacks(dev);
>   	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>   deinit_phy:
>   	rockchip_pcie_phy_deinit(rockchip);
> @@ -725,6 +743,9 @@ static void rockchip_pcie_remove(struct platform_device *pdev)
>   	/* Perform other cleanups as necessary */
>   	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>   	rockchip_pcie_phy_deinit(rockchip);
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	pm_runtime_no_callbacks(dev);
>   }
>   
>   static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {


