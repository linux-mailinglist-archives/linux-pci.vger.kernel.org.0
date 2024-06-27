Return-Path: <linux-pci+bounces-9367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3FB91A2C6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 11:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED581F234CB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A5513B587;
	Thu, 27 Jun 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HfDwFd+z"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4513AD38;
	Thu, 27 Jun 2024 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481210; cv=none; b=fsy/pdQIBkAp/fKj0CKd0XtZccbixs5418GgwrlJHIcxWKWLuCMOT9smHT4vZkxAX3pKICkERQvWl4iOxX9nROw1EYH/M+WDHUpc0QWgg7OMyPaRbMUExpi7mGMFR3nZOFYPmU0Nyt8DCnabre3hvxpgNlILYJCUqysdiEEFST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481210; c=relaxed/simple;
	bh=sPv2gjPKrEsO6IWBmkkAWYYhbPMP+ICh+j0TbkMyX3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loOR61LQXq8HZDQVCkpGIo7pH5H7Y/AwGNFjEdaRxk+Lorx6z4FDOFI5gvMjbiLVgmx4hWVuaKIWNLIfCfC9B3Vg6gpkCIXPOtIuhVgNj/mY4V8MbEqqMDc/e2QYQsXZngVJ4I6uCxpMhY5OjJKxMvulWkHpqFt6WkmARbT+iTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HfDwFd+z; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719481207;
	bh=sPv2gjPKrEsO6IWBmkkAWYYhbPMP+ICh+j0TbkMyX3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HfDwFd+zHoT5Jj8ZGgmgoHp1v3hfIQ8/KX9qu9PyumVNC/JV0Sdv7jiOSGSuqWcXC
	 q8GIKLy6Q3ZwF+yNQtEUQgZN1gXaH5Mao5Whl4E/yPv+WXjwFgBhZUI1NNA/KG2VvU
	 1h8+DOrvkSRcIJdG5wMdDZu+F4A81x2Sd2DO6dEkG6V0xOu239uYgMwCdoFRwIyYf9
	 4swknVx3jWW+tVQTUHnVAP+Y+7eaZ/D1gXrtaEvJDLXSvkCQgQ1VPG4vPLBEdVurKJ
	 MgGwikfbhA6L7pdWbzlECR8EC0w73k6uOsyBTfsYrM3I3ID52UKb7lpuFVS8gGn1Hp
	 uqkUbCy2dU5Ug==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 95D4A37810CD;
	Thu, 27 Jun 2024 09:40:06 +0000 (UTC)
Message-ID: <f97c7ebc-4aad-4125-90df-21cd8a63c68d@collabora.com>
Date: Thu, 27 Jun 2024 11:40:06 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com, jianjun.wang@mediatek.com, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 devicetree@vger.kernel.org, nbd@nbd.name, dd@embedd.com, upstream@airoha.com
References: <cover.1719475568.git.lorenzo@kernel.org>
 <b2c794b21e15ec85a57de144006db9582ce0c949.1719475568.git.lorenzo@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <b2c794b21e15ec85a57de144006db9582ce0c949.1719475568.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/06/24 10:12, Lorenzo Bianconi ha scritto:
> Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> PCIe controller driver.
> 
> Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/pci/controller/Kconfig              |  2 +-
>   drivers/pci/controller/pcie-mediatek-gen3.c | 96 ++++++++++++++++++++-
>   2 files changed, 96 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index e534c02ee34f..3bd6c9430010 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -196,7 +196,7 @@ config PCIE_MEDIATEK
>   
>   config PCIE_MEDIATEK_GEN3
>   	tristate "MediaTek Gen3 PCIe controller"
> -	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
>   	depends on PCI_MSI
>   	help
>   	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 438a5222d986..af567b4355fa 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c

..snip..

> +
>   static const struct of_device_id mtk_pcie_of_match[] = {
>   	{ .compatible = "mediatek,mt8192-pcie", .data = &mtk_pcie_soc_mt8192 },
> +	{ .compatible = "airoha,en7581-pcie", .data = &mtk_pcie_soc_en7581 },

My bad, in the last review I didn't notice that the ordering here is not good.

A ... iroha comes before
M ... ediatek :-)

Please put the airoha entry before the mediatek one, after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, mtk_pcie_of_match);


