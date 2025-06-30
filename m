Return-Path: <linux-pci+bounces-31080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DABAAEDF84
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 15:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE173AAD9E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F0218CC1D;
	Mon, 30 Jun 2025 13:48:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5AE3D69;
	Mon, 30 Jun 2025 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291313; cv=none; b=ZK9pSxqgtZMC7jNTi77buV2U7olW64cpkkzJbIaaSvBClH8miihFne+vlDweCRjZTtSOqSTxf3fPtfZ88Lx7AhCEMoQqCDpK/KRYen7/Z1Eko7mcmNYgOEU99gi8jZzMcSHdVTDjcqwtDL7qxu8Mkqnce23OG78E5SJD9MJiioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291313; c=relaxed/simple;
	bh=9TAY8jZb5Z212171M14dLLiCClT2QNMSWod8zvWs9qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rebRyyf9Am1G/hg9tNcf07DSBnkvdMEjHKSp7umGy4d+ytCN4t1oAnxJaCOGXcW1mFBBgvEdBPKAznDvmcZ96wcOnHofGf+q6tZRnV6N2Hyh8BAEPcDjUuOqc58NREmRpTWqzttBe46sHYCATc6M0Fe9eKPfkTTuKifrwSN1qBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2465C1D34;
	Mon, 30 Jun 2025 06:48:14 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70DC03F6A8;
	Mon, 30 Jun 2025 06:48:27 -0700 (PDT)
Message-ID: <2affed16-f3c4-47d3-9ca6-e4f48e875367@arm.com>
Date: Mon, 30 Jun 2025 14:48:25 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] phy: rockchip-pcie: Enable all four lanes if
 required
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
References: <cover.1751200382.git.geraldogabriel@gmail.com>
 <b203b067e369411b029039f96cfeae300874b4c7.1751200382.git.geraldogabriel@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <b203b067e369411b029039f96cfeae300874b4c7.1751200382.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/06/2025 9:58 pm, Geraldo Nascimento wrote:
> Current code enables only Lane 0 because pwr_cnt will be incremented on
> first call to the function. Let's reorder the enablement code to enable
> all 4 lanes through GRF.

As usual the TRM isn't very clear, but the way it describes the 
GRF_SOC_CON_5_PCIE bits does suggest they're driving external input 
signals of the phy block, so it seems reasonable that it could be OK to 
update the register itself without worrying about releasing the phy from 
reset first. In that case I'd agree this seems the cleanest fix, and if 
it works empirically then I think I'm now sufficiently convinced too;

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>   drivers/phy/rockchip/phy-rockchip-pcie.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
> index bd44af36c67a..f22ffb41cdc2 100644
> --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> @@ -160,6 +160,12 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
>   
>   	guard(mutex)(&rk_phy->pcie_mutex);
>   
> +	regmap_write(rk_phy->reg_base,
> +		     rk_phy->phy_data->pcie_laneoff,
> +		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
> +				   PHY_LANE_IDLE_MASK,
> +				   PHY_LANE_IDLE_A_SHIFT + inst->index));
> +
>   	if (rk_phy->pwr_cnt++) {
>   		return 0;
>   	}
> @@ -176,12 +182,6 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
>   				   PHY_CFG_ADDR_MASK,
>   				   PHY_CFG_ADDR_SHIFT));
>   
> -	regmap_write(rk_phy->reg_base,
> -		     rk_phy->phy_data->pcie_laneoff,
> -		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
> -				   PHY_LANE_IDLE_MASK,
> -				   PHY_LANE_IDLE_A_SHIFT + inst->index));
> -
>   	/*
>   	 * No documented timeout value for phy operation below,
>   	 * so we make it large enough here. And we use loop-break

