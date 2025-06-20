Return-Path: <linux-pci+bounces-30251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26543AE1A70
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 14:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7663F5A5482
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 12:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2782289E21;
	Fri, 20 Jun 2025 12:04:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143921C18E;
	Fri, 20 Jun 2025 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421092; cv=none; b=HY3krCgwKawvYNQqH/8hRpmUBMmdbmyu5ci0IvCVyWDABTzHB5Fx0OS+VBcHdZVjrjerRhb+F0kGJg0YHOTpX9Pl8oFkaGHpGwUinKpEvUaxo1UjBNAa6LaLLHCrx6bJdMkvzMUROLOcjepvorGDylirs6ZAok+zy42o3vxPjWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421092; c=relaxed/simple;
	bh=tCIXfMiKQccXCO9quG8rjG7WtEugWSAaDnbrbxXHMoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASd51WVNxFtFKr3X9gptizu7i9eVm7ul1rl3hHtt5rblaqi6luztyd2A0moJchTJcIfj8hCGUxJFAXo9qR57Q9gx8Tp7UKRZqQQuARdDu5RnAHShk2GbpHxwwzSCj/8nXboCX7aVg+0InUjz1fEFjGrgBabjZstbCQ+2YtEGRe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E59D106F;
	Fri, 20 Jun 2025 05:04:30 -0700 (PDT)
Received: from [192.168.1.102] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD2173F58B;
	Fri, 20 Jun 2025 05:04:47 -0700 (PDT)
Message-ID: <4c2c9a15-50bc-4a89-b5fe-d9014657fca7@arm.com>
Date: Fri, 20 Jun 2025 13:04:46 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 3/4] phy: rockchip-pcie: Enable all four lanes
To: Geraldo Nascimento <geraldogabriel@gmail.com>,
 linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rick wertenbroek <rick.wertenbroek@gmail.com>,
 linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1749833986.git.geraldogabriel@gmail.com>
 <ce661babb3e2f08c8b28554ccb5508da503db7ba.1749833987.git.geraldogabriel@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ce661babb3e2f08c8b28554ccb5508da503db7ba.1749833987.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-13 6:03 pm, Geraldo Nascimento wrote:
> Current code enables only Lane 0 because pwr_cnt will be incremented
> on first call to the function. Use for-loop to enable all 4 lanes
> through GRF.

If this was really necessary, then surely it would also need the 
equivalent changes in rockchip_pcie_phy_power_off() too?

However, I'm not sure it *is* necessary - the NVMe on my RK3399 board 
happily claims to be using an x4 link, so I stuck a print of inst->index 
in this function, and sure enough I do see it being called for each 
instance already:

[    1.737479] phy phy-ff770000.syscon:pcie-phy.1: power_on 0
[    1.738810] phy phy-ff770000.syscon:pcie-phy.2: power_on 1
[    1.745193] phy phy-ff770000.syscon:pcie-phy.3: power_on 2
[    1.745196] phy phy-ff770000.syscon:pcie-phy.4: power_on 3

Thanks,
Robin.

> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>   drivers/phy/rockchip/phy-rockchip-pcie.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
> index bd44af36c67a..48bcc7d2b33b 100644
> --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> @@ -176,11 +176,13 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
>   				   PHY_CFG_ADDR_MASK,
>   				   PHY_CFG_ADDR_SHIFT));
>   
> -	regmap_write(rk_phy->reg_base,
> -		     rk_phy->phy_data->pcie_laneoff,
> -		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
> -				   PHY_LANE_IDLE_MASK,
> -				   PHY_LANE_IDLE_A_SHIFT + inst->index));
> +	for (int i=0; i < PHY_MAX_LANE_NUM; i++) {
> +		regmap_write(rk_phy->reg_base,
> +			     rk_phy->phy_data->pcie_laneoff,
> +			     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
> +					   PHY_LANE_IDLE_MASK,
> +					   PHY_LANE_IDLE_A_SHIFT + i));
> +	}
>   
>   	/*
>   	 * No documented timeout value for phy operation below,


