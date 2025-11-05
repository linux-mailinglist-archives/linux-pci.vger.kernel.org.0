Return-Path: <linux-pci+bounces-40323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F093C348A7
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 09:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03BD466F93
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6683B2D9EE6;
	Wed,  5 Nov 2025 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nnBhHArV"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1422127B;
	Wed,  5 Nov 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332353; cv=none; b=fQPTiEWCArhui4SGelvwtOY64N9KcKXAAu8UtOfMxzyLsBtaS65AM3TQ+dprVpClbWushI1SR7ow6aUeo6vV+rgzzcf6YcYbKf1FSUw2jQO900rXe/CKVf8bLvo7UaEZT372uL76x9NnYC/Fz8ODGZXisGfElqj3oj9j9zROMkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332353; c=relaxed/simple;
	bh=dcXhKr8PghVDm1g0KRmMujIo6k9hqQExl/ksAmmmqXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzyvdUQ1FXC0JqZK3V1vljDG9cM9KABTFM32OzmSdR8TG0cNmpch2XtpcUTn4CREHlRk22yl6oh859530MruGOKMkTFOFeGJB0RfcNChaVUr70v6EPuhZR96HnrVDu8DxMwc9olOE7bi8LLGlZq9nLohFGuZmIGjn5b2a6RvSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nnBhHArV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762332349;
	bh=dcXhKr8PghVDm1g0KRmMujIo6k9hqQExl/ksAmmmqXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nnBhHArV/D205ZnfrfDXvDi2wDtW0jmATrnFaq2TVTL8sn6NhMwZ0hTuDlvOuR+CF
	 EHvmDqcsBHrX+kERg5NBd78GuhP3zU2apbJGlZV40pfaH+Rptxna738AH9Pm9L3KEM
	 atf7EvTl5MYI9fJYk1YuVfVP4MNRuT+NtMziPGVA3B40UPXlLhiAV7rTe1dE8vl+f5
	 T/tODOUii/W+MXHqa4OMp3evWqYrN7uKKG0R+ef07WqSKJAWniNHUqx5Gugv7ac8OT
	 B9dt/8eN35Ije3/YnDtczwMfbctCrVmoUJXLotBxq01RwRnaIw143Pucn8Gc8opZor
	 ZwofItHkseP1A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 96BD417E0CA1;
	Wed,  5 Nov 2025 09:45:48 +0100 (CET)
Message-ID: <7250ae04-866f-489c-b1b6-b8a3d8200529@collabora.com>
Date: Wed, 5 Nov 2025 09:45:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: mediatek-gen3: Ignore link up timeout
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251105062815.966716-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251105062815.966716-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/11/25 07:28, Chen-Yu Tsai ha scritto:
> As mentioned in commit 886a9c134755 ("PCI: dwc: Move link handling into
> common code") come up later" in the code, it is possible for link up to
> occur later:
> 
>    Let's standardize this to succeed as there are usecases where devices
>    (and the link) appear later even without hotplug. For example, a
>    reconfigured FPGA device.
> 
> Another case for this is the new PCIe power control stuff. The power
> control mechanism only gets triggered in the PCI core after the driver
> calls into pci_host_probe(). The power control framework then triggers
> a bus rescan. In most driver implementations, this sequence happens
> after link training. If the driver errors out when link training times
> out, it will never get to the point where the device gets turned on.
> 
> Ignore the link up timeout, and lower the error message down to a
> warning.
> 
> This makes PCIe devices that have not-always-on power rails work.
> However there may be some reversal of PCIe power sequencing, since now
> the PERST# and clocks are enabled in the driver, while the power is
> applied afterwards.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Ok, that's sensible.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> The change works to get my PCIe WiFi device working, but I wonder if
> the driver should expose more fine grained controls for the link clock
> and PERST# (when it is owned by the controller and not just a GPIO) to
> the power control framework. This applies not just to this driver.
> 
> The PCI standard says that PERST# should hold the device in reset until
> the power rails are valid or stable, i.e. at their designated voltages.

I completely agree with all of the above - and I can imagine multiple PCI-Express
controller drivers doing the same as what's being done in MTK Gen3.

This means that the boot process may get slowed down by the port startup sequence
on multiple PCI-Express controllers (again not just MediaTek) and it's something
that must be resolved in some way... with the fastest course of action imo being
giving controller drivers knowledge of whether there's any device that is expected
to be powered off at that time (in order to at least avoid all those waits that
are expected to fail).

P.S.: Chen-Yu, did you check if the same applies to the MTK previous gen driver?
       Could you please check and eventually send a commit to do the same there?

Cheers,
Angelo

> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 75ddb8bee168..5bdb312c9f9b 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -504,10 +504,15 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>   		ltssm_index = PCIE_LTSSM_STATE(val);
>   		ltssm_state = ltssm_index >= ARRAY_SIZE(ltssm_str) ?
>   			      "Unknown state" : ltssm_str[ltssm_index];
> -		dev_err(pcie->dev,
> -			"PCIe link down, current LTSSM state: %s (%#x)\n",
> -			ltssm_state, val);
> -		return err;
> +		dev_warn(pcie->dev,
> +			 "PCIe link down, current LTSSM state: %s (%#x)\n",
> +			 ltssm_state, val);
> +
> +		/*
> +		 * Ignore the timeout, as the link may come up later,
> +		 * such as when the PCI power control enables power to the
> +		 * device, at which point it triggers a rescan.
> +		 */
>   	}
>   
>   	mtk_pcie_enable_msi(pcie);



