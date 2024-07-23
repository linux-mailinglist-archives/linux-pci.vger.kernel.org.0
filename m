Return-Path: <linux-pci+bounces-10680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C276F93A985
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 00:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAB11F22D5F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 22:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8174148FF2;
	Tue, 23 Jul 2024 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYxwu10z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8D41487F9;
	Tue, 23 Jul 2024 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775294; cv=none; b=lnXpu9ny99w6E8PM9dkC/Vbto/hHE3TRRVZeUMKDNBoi2Hmr+qU3Sai8ncWyhFi6U0zYR5LjttW2WQDHCLK0E4nBdeFtu97y+D0lpbmh9SXakY4UztNceM+XGbOvQ4MTbPAMpP8Rl/yZWyMKOZvKDNmit8zWjp3YfH8vh9/iPEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775294; c=relaxed/simple;
	bh=7yl7pweRsUb/Cz4uzMnBbIvjB393ruYlONQQ/MK1d9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s11umWy2x1rORc0LAHUgLx6dUa73EBJk9Kh9k13BAxl1hJPFiFzPbByDrrBQeQAFm4n+IPM9VDLnAHThrjBWWZhF6iDOsCtwEU6Vkmgaa7SrAKF2kueX+zF7KeqYt5EfIA8QldJeMXD5/lUxkf3RSZ0OK9azonxuhFifXRu/loc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYxwu10z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76859C4AF09;
	Tue, 23 Jul 2024 22:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721775294;
	bh=7yl7pweRsUb/Cz4uzMnBbIvjB393ruYlONQQ/MK1d9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cYxwu10z5OHmkGQRUgijf1f/SRxT0dVPX2MkHzZ+24lrUWB8pLFMqoBbZSJQe7ZqX
	 TwQ8stHcyHiRpcsqYpgYWBMbWA0b80okC3O4iHaCpUCQqJsW3nXu6mwhv7ap2Jpslm
	 3gu35oqshyEDpN6XdUCp4L0hvI9T+dDTQrZ0JpCLvooTmr7D9d8/GKj99xkadZMqcQ
	 ZvFvAqC+aMnI2mTrS3zU8n0yQJsPLNVA5LHn/HQCRybrhnKNp3PaOhQYN6Kxego95b
	 kieihj7tORN814FXDDg99GVwDban6fQojEoQ6iLhG5S37BWMVjaWU8g1MkRCSDTfc6
	 947QCP7HuE3Gg==
Message-ID: <b77f741f-24da-445b-99bc-8765dabdf820@kernel.org>
Date: Wed, 24 Jul 2024 07:54:47 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] genirq/msi: Silence set affinity failed warning
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Aleksandr Mishin <amishin@t-argos.ru>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Anup Patel <apatel@ventanamicro.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Jim Quinlan <jim2101024@gmail.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
 Jon Hunter <jonathanh@nvidia.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Joyce Ooi <joyce.ooi@intel.com>,
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Koichiro Den
 <den@valinux.co.jp>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Marc Zyngier <maz@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Niklas Cassel
 <cassel@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>, Rob Herring <robh@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org
References: <20240723132958.41320-1-marek.vasut+renesas@mailbox.org>
 <20240723132958.41320-2-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240723132958.41320-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/24 10:27 PM, Marek Vasut wrote:
> Various PCIe controllers that mux MSIs onto single IRQ line produce these
> "IRQ%d: set affinity failed" warnings when entering suspend. This has been
> discussed before [1] [2] and an example test case is included at the end
> of this commit message.
> 
> Controller drivers which create MSI IRQ domain with MSI_FLAG_USE_DEF_CHIP_OPS
> flag set and which do not override the .irq_set_affinity irqchip callback get
> assigned default .irq_set_affinity = msi_domain_set_affinity() callback. That
> is not desired on controllers where it is not possible to set affinity of each
> MSI IRQ line to a specific CPU core due to hardware limitation.
> 
> Introduce dedicated flag MSI_FLAG_NO_AFFINITY, which keeps .irq_set_affinity
> unset in case the controller driver did not assign the callback. This way, the
> migrate_one_irq() code in cpuhotplug.c can exit right away, without printing
> the aforementioned warning. The .irq_set_affinity implementations which only
> return -EINVAL can be removed from multiple controller drivers.
> 
> ```
> $ grep 25 /proc/interrupts
>  25:   0 0 0 0 0 0 0 0   PCIe MSI   0   Edge   PCIe PME
> 
> $ echo core > /sys/power/pm_test ; echo mem > /sys/power/state
> ...
> Disabling non-boot CPUs ...
> IRQ25: set affinity failed(-22). <---------- This is being silenced here
> psci: CPU7 killed (polled 4 ms)
> ...
> ```
> 
> [1] https://lore.kernel.org/all/d4a6eea3c5e33a3a4056885419df95a7@kernel.org/
> [2] https://lore.kernel.org/all/5f4947b18bf381615a37aa81c2242477@kernel.org/
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


