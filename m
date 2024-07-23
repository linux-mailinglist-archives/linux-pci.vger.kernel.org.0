Return-Path: <linux-pci+bounces-10679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2F593A97D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 00:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38721F22A64
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 22:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C739525760;
	Tue, 23 Jul 2024 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYN6yv+F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801728E8;
	Tue, 23 Jul 2024 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775211; cv=none; b=bWfeeiS58JQx+lVcqj6bKNo2nI1ucgLQEOmCJsIEYMKn5C5hHp1iTLwjlMY7g+I9O3o7It2izjC3OJkQ0v2wmIQ4XZQzqGvaIaDU7sbVGMZMaE3qyR3JQylfHDcdxD9RFD/1wyzQgEFuIPzfvsCYI3Qzy8S+gh9hL2+YgAiu4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775211; c=relaxed/simple;
	bh=cHJbPDlIH0oCEqFdHMXc1f/SmzHKfHRg/D0V77IKE/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPhqzSbZXw4vZMeveK7bZx4AfpdLXWibS3e9IAUt1Z5og8xX9fuwpz8mi7r+sNwmvpb5/4KMImpCtSdJdR7H3YcoL1QKRi7IKc/VbrNDw1MHy0npvFRchpJEWoKNZqkKFlm1nC8Xk0D1CFe9SXxYCVfU5ziwTpgccNanw9od6wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYN6yv+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7690FC4AF0A;
	Tue, 23 Jul 2024 22:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721775211;
	bh=cHJbPDlIH0oCEqFdHMXc1f/SmzHKfHRg/D0V77IKE/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sYN6yv+FHlTLQYks25mPie6POPe6J0L437WXBzUx2BVXXHSKQ/tcNWSqUUBRayhzC
	 NEAMi+W+qkJ0iKbJWCx80P94jdwSRvxy9VRpaQBnuQhmxw/15M3E8ovoNJI3R8qA3i
	 g+dEicUhSjbRL0mGXUPibqbkQRsqVWQuZj6LQtfla8lb6TXLMxnL1hPIlctls7nxau
	 OBiKOsmRvtcDWqbf87Ul9l1zLNbJgvsJQSVyjHowgvhoUhr1fdgPK48DOUT+0zycHQ
	 CSssFzuPELhamsa2kR92pf3IhgxaVaWaMfxpguhYzwEKzv0EqeG4XnIxa51iU0j1e9
	 ampGEo3+E8tFg==
Message-ID: <a49bb411-f96d-4574-96ec-5b03668cdf87@kernel.org>
Date: Wed, 24 Jul 2024 07:53:21 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/15] PCI: dwc: Silence set affinity failed warning
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
 <20240723132958.41320-6-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240723132958.41320-6-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/24 10:27 PM, Marek Vasut wrote:
> Use newly introduced MSI_FLAG_NO_AFFINITY, which keeps .irq_set_affinity unset
> and allows migrate_one_irq() code in cpuhotplug.c to exit right away, without
> printing "IRQ...: set affinity failed(-22)" warning.
> 
> Remove .irq_set_affinity implementation which only return -EINVAL from this
> controller driver.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


