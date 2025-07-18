Return-Path: <linux-pci+bounces-32479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE77B099AC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 04:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF899A45D00
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 02:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8613A70825;
	Fri, 18 Jul 2025 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="i6J9wKv2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49224.qiye.163.com (mail-m49224.qiye.163.com [45.254.49.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BEF1BC2A;
	Fri, 18 Jul 2025 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804674; cv=none; b=ukIwMTAnFUSh7Oe5R2+Ynl02ksnxdt1/Zdt9/TtKBZ3pEWoQyN2ANL1Gbkps21uUTe8tGIvgumZ3wCon9ZtmtxGdKba2A/9nbSKZOipwcl3bjWIC6vkjyEr+WH3Rc9VuLFBkS6zGQ9Gsf9oFRAvIWUf8y/jO1cmTsaJd9lDGerE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804674; c=relaxed/simple;
	bh=1N7ytZis29CPZTGf/iePZSRhIyuhTGoGr3mV+MXU8UQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FxHStpou4pTBgv5r30fiu5/pJHdSLRCDvFm+Qn9xuUWLyypSw3Q0qmKJ/db3aVQucCw5f7yh915+5qQpH3EriJU9hGFt0Sml0Wu2gSBS8GGZb29Upl0+PfZ4Tu+Mmske0gua5pjyEcAYCs5Oq5Ni0XwnqDMK0Uz3/MN0R5z4oMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=i6J9wKv2; arc=none smtp.client-ip=45.254.49.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c6a85541;
	Fri, 18 Jul 2025 09:55:50 +0800 (GMT+08:00)
Message-ID: <ac48d142-7aec-4fdd-92a4-6f9bc10a7928@rock-chips.com>
Date: Fri, 18 Jul 2025 09:55:42 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Hugh Cole-Baker <sigmaris@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH v3 2/3] PCI: rockchip-host: Retry link training on
 failure without PERST#
To: Geraldo Nascimento <geraldogabriel@gmail.com>
References: <cover.1749582046.git.geraldogabriel@gmail.com>
 <b7c09279b4a7dbdba92543db9b9af169776bd90c.1749582046.git.geraldogabriel@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <b7c09279b4a7dbdba92543db9b9af169776bd90c.1749582046.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh9MTFYZQxgYGB1CTE5MSkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a981b3eb22b09cckunm9ba9285b1f9de7b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PS46MSo4AzE3P1ZNATguNxEY
	TQJPCzNVSlVKTE5JQ0tITE5JS09JVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU1DS0g3Bg++
DKIM-Signature:a=rsa-sha256;
	b=i6J9wKv2sF8hty+9HcYY7Grx2KFg7v7tdWpFM6j9VKKFMuYavSInJCeIrPUv3bfq9gU0krIP8YR6oB3JncO+CDd/Q55N7THricQKXBdmc+SZmxD/2LnpW/U9kJDPnyAwOwoPH7+gpU2c5Zgu8QcWkSAyv/TCol6SpwigDy7FZB0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=XT+RZ7WEBbWIWW/Jed62+BDDdP8o1iduIJiqKrv6b/A=;
	h=date:mime-version:subject:message-id:from;

Hi Geraldo,

在 2025/06/11 星期三 3:05, Geraldo Nascimento 写道:
> After almost 30 days of battling with RK3399 buggy PCIe on my Rock Pi
> N10 through trial-and-error debugging, I finally got positive results
> with enumeration on the PCI bus for both a Realtek 8111E NIC and a
> Samsung PM981a SSD.
> 
> The NIC was connected to a M.2->PCIe x4 riser card and it would get
> stuck on Polling.Compliance, without breaking electrical idle on the
> Host RX side. The Samsung PM981a SSD is directly connected to M.2
> connector and that SSD is known to be quirky (OEM... no support)
> and non-functional on the RK3399 platform.
> 
> The Samsung SSD was even worse than the NIC - it would get stuck on
> Detect.Active like a bricked card, even though it was fully functional
> via USB adapter.
> 
> It seems both devices benefit from retrying Link Training if - big if
> here - PERST# is not toggled during retry.
> 

I didn't see this error before especially given RTL8111 NIC is widelly
used by customers.

Could you help tried this?
[1] apply your patch 3 first
[2] apply below changes

--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -314,7 +314,7 @@ static int rockchip_pcie_host_init_port(struct 
rockchip_pcie *rockchip)
         rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
                             PCIE_CLIENT_CONFIG);

-       msleep(PCIE_T_PVPERL_MS);
+       msleep(500);
         gpiod_set_value_cansleep(rockchip->perst_gpio, 1);

         msleep(PCIE_RESET_CONFIG_WAIT_MS);
@@ -322,7 +322,7 @@ static int rockchip_pcie_host_init_port(struct 
rockchip_pcie *rockchip)
         /* 500ms timeout value should be enough for Gen1/2 training */
         err = readl_poll_timeout(rockchip->apb_base + 
PCIE_CLIENT_BASIC_STATUS1,
                                  status, PCIE_LINK_UP(status), 20,
-                                500 * USEC_PER_MSEC);
+                                5000 * USEC_PER_MSEC);
         if (err) {
                 dev_err(dev, "PCIe link training gen1 timeout!\n");
                 goto err_power_off_phy;
@@ -951,6 +951,8 @@ static int rockchip_pcie_probe(struct 
platform_device *pdev)
         if (err)
                 return err;

+       gpiod_set_value_cansleep(rockchip->perst_gpio, 0);
+
         err = rockchip_pcie_set_vpcie(rockchip);
         if (err) {
                 dev_err(dev, "failed to set vpcie regulator\n");


> For retry to work, flow must be exactly as handled by present patch,
> that is, we must cut power, disable the clocks, then re-enable
> both clocks and power regulators and go through initialization
> without touching PERST#. Then quirky devices are able to sucessfully
> enumerate.
> 
> No functional change intended for already working devices.
> 
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>   drivers/pci/controller/pcie-rockchip-host.c | 47 ++++++++++++++++++---
>   1 file changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 2a1071cd3241..67b3b379d277 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -338,11 +338,14 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
>   static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>   {
>   	struct device *dev = rockchip->dev;
> -	int err, i = MAX_LANE_NUM;
> +	int err, i = MAX_LANE_NUM, is_reinit = 0;
>   	u32 status;
>   
> -	gpiod_set_value_cansleep(rockchip->perst_gpio, 0);
> +	if (!is_reinit) {
> +		gpiod_set_value_cansleep(rockchip->perst_gpio, 0);
> +	}
>   
> +reinit:
>   	err = rockchip_pcie_init_port(rockchip);
>   	if (err)
>   		return err;
> @@ -369,16 +372,46 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>   	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>   			    PCIE_CLIENT_CONFIG);
>   
> -	msleep(PCIE_T_PVPERL_MS);
> -	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
> -
> -	msleep(PCIE_T_RRS_READY_MS);
> +	if (!is_reinit) {
> +		msleep(PCIE_T_PVPERL_MS);
> +		gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
> +		msleep(PCIE_T_RRS_READY_MS);
> +	}
>   
>   	/* 500ms timeout value should be enough for Gen1/2 training */
>   	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
>   				 status, PCIE_LINK_UP(status), 20,
>   				 500 * USEC_PER_MSEC);
> -	if (err) {
> +
> +	if (err && !is_reinit) {
> +		while (i--)
> +			phy_power_off(rockchip->phys[i]);
> +		i = MAX_LANE_NUM;
> +		while (i--)
> +			phy_exit(rockchip->phys[i]);
> +		i = MAX_LANE_NUM;
> +		is_reinit = 1;
> +		dev_dbg(dev, "Will reinit PCIe without toggling PERST#");
> +		if (!IS_ERR(rockchip->vpcie12v))
> +			regulator_disable(rockchip->vpcie12v);
> +		if (!IS_ERR(rockchip->vpcie3v3))
> +			regulator_disable(rockchip->vpcie3v3);
> +		regulator_disable(rockchip->vpcie1v8);
> +		regulator_disable(rockchip->vpcie0v9);
> +		rockchip_pcie_disable_clocks(rockchip);
> +		err = rockchip_pcie_enable_clocks(rockchip);
> +		if (err)
> +			return err;
> +		err = rockchip_pcie_set_vpcie(rockchip);
> +		if (err) {
> +			dev_err(dev, "failed to set vpcie regulator\n");
> +			rockchip_pcie_disable_clocks(rockchip);
> +			return err;
> +		}
> +		goto reinit;
> +	}
> +
> +	else if (err) {
>   		dev_err(dev, "PCIe link training gen1 timeout!\n");
>   		goto err_power_off_phy;
>   	}


