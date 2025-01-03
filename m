Return-Path: <linux-pci+bounces-19211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9728EA00694
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 10:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332261881519
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 09:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E81C9DD7;
	Fri,  3 Jan 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bHPeFGJ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C318A950;
	Fri,  3 Jan 2025 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895691; cv=none; b=dmEeI04ltphIoFRxnp4pzGJwuU3P0vZm6VemAUArKVlqDsIaLtxzHZk5Qp2wB3MnmU/ryfzSagCOzkODBTlIXSt290nmN8W/HrA78PycNmTZByMNimZZcy7eUlNY+uL2u8TRtkzp+qJZUOxnnqCum4zD6n+jM+TTRzkRni+25L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895691; c=relaxed/simple;
	bh=87NFexTc1MyhVTnaxRXYUPIPkVUDQPmZsOB6r5tc5go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkzNe5QFZqJMUE1Vt+cJT9kmHsTfCXqVFGEpkUm3hKV5Wr8zeHuES2L2+iv4XsingP0Mw9RO8SK8ZOw7TSkLfP/PdWV/2q3ht+MiH2mRswHg1Lp5C8w8tQgw6IfniCdaLoDQxvEodqAzN4Cm0NXyI7mucmy6wScsAYh4IvSfCIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bHPeFGJ1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1735895686;
	bh=87NFexTc1MyhVTnaxRXYUPIPkVUDQPmZsOB6r5tc5go=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bHPeFGJ1NwUKWS7llEBq/Mc+Y1g3AeSjTi25nxdmeV/TJIGpm4plKhafik7Q4Hr4v
	 vbhyuBCf/TGK+j1n7KDXVhW+xHqfJG/kXf5ytfToN2sJyn5CVhOHq9G89UFdJZ+mdy
	 zRJ4dfxWtPuLh0wDU1BSjUNsRZiUk86hBE7/QtxD0IZFs/Ljb2FH1GUQoEjXZepEBe
	 PccH/eZBIJe5gC/7zEpQ5vlZ/Whd+/O0ojxbSkB541h9qQwaqSoGqihF7KH4QB0Wsw
	 P2pEK9QBdJ3tRsdE36AZeYZvMzprKipyxFacwTe88F9k6OMY9La/i7//9cySbgFhgb
	 vZ6zvtmXYD61A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 266C817E153E;
	Fri,  3 Jan 2025 10:14:46 +0100 (CET)
Message-ID: <f23dd67e-d3a5-47b5-af14-bf0120348ec8@collabora.com>
Date: Fri, 3 Jan 2025 10:14:45 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] PCI: mediatek-gen3: Keep PCIe power and clocks if
 suspend-to-idle
To: Jianjun Wang <jianjun.wang@mediatek.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Xavier Chang <Xavier.Chang@mediatek.com>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
 <20250103060035.30688-6-jianjun.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250103060035.30688-6-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/01/25 07:00, Jianjun Wang ha scritto:
> If the target system sleep state is suspend-to-idle, the bridge is
> supposed to stay in D0, and the framework will not help to restore its
> configuration space, so keep its power and clocks during suspend.
> 
> It's recommended to enable L1ss support, so the link can be changed to
> L1.2 state during suspend.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 48f83c2d91f7..11da68910502 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -1291,6 +1291,19 @@ static int mtk_pcie_suspend_noirq(struct device *dev)
>   	int err;
>   	u32 val;
>   
> +	/*
> +	 * If the target system sleep state is suspend-to-idle, the bridge is supposed to stay in
> +	 * D0, and the framework will not help to restore its configuration space, so keep it's
> +	 * power and clocks during suspend.
> +	 *
> +	 * It's recommended to enable L1ss support, so the link can be changed to L1.2 state during
> +	 * suspend.
> +	 */
> +	if (pm_suspend_default_s2idle()) {

AFAIK, this works only if s2idle is the default system sleep state.

...and besides, for good measure (especially in the event that in the future we
get hotplug support) you should also check if there is any active PCI-Express
device on the controller instance before deciding to leave the controller and
link UP, as PCI-Express controllers may be enabled even if there's no actually
connected device on a PCIe slot (full PCIe, or mPCIe, or M.2).

So, I suggest to:

- Add a `bool suspended` member to `struct mtk_gen3_pcie`, then

static int mtk_pcie_suspend_noirq(struct device *dev)
{
	struct mtk_gen3_pcie *pcie = dev_get_drvdata(dev);
	int err;
	u32 val;

	val = readl(pcie->base + PCIE_LINK_STATUS_REG);
	val &= PCIE_PORT_LINKUP;

	if (val && pm_suspend_target_state == PM_SUSPEND_TO_IDLE) {
		dev_dbg(....)
		return 0;
	}

	/* Trigger link to L2 state */
	err = mtk_pcie_turn_off_link(pcie);
	if (err) {
		dev_err(pcie->dev, "cannot enter L2 state\n");
		return err;
	}

	pcie->suspended = true;

	/* Pull down the PERST# pin */
	.... etc etc


and

static int mtk_pcie_resume_noirq(struct device *dev)
{
	struct mtk_gen3_pcie *pcie = dev_get_drvdata(dev);
	int err;

	if (!pcie->suspended)
		return 0;

	err = pcie->soc->power_up .... etc etc


... so you only check if we're going in s2idle in the suspend handler, as
that dictates the value of pcie->suspended :-)

Cheers,
Angelo

> +		dev_info(dev, "System enter s2idle state, keep PCIe power and clocks\n");
> +		return 0;
> +	}
> +
>   	/* Trigger link to L2 state */
>   	err = mtk_pcie_turn_off_link(pcie);
>   	if (err) {
> @@ -1316,6 +1329,11 @@ static int mtk_pcie_resume_noirq(struct device *dev)
>   	struct mtk_gen3_pcie *pcie = dev_get_drvdata(dev);
>   	int err;
>   
> +	if (pm_suspend_default_s2idle()) {
> +		dev_info(dev, "System enter s2idle state, no need to reinitialization\n");
> +		return 0;
> +	}
> +
>   	err = pcie->soc->power_up(pcie);
>   	if (err)
>   		return err;




