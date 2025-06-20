Return-Path: <linux-pci+bounces-30256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 893C9AE1B26
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 14:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BACA67A4512
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA1A27E7D9;
	Fri, 20 Jun 2025 12:47:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C29F21C17D;
	Fri, 20 Jun 2025 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423662; cv=none; b=D3N7B9Tv6ZHErvyLx6+EKsiVEB6sSYBs+Gb8o7jwK2P3s8LYWaOru0JSodeb5sCyiEXtsYYjtTHOvf5tEWlLvfpsqQu93GL7lgfSBHSLZgsmSaj4E30b0KF4phnCbpMpNe5HyOo/CBQWP3OT3tqbwytFB2/gbIlZEDR5E1A6n5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423662; c=relaxed/simple;
	bh=WxQdWAW0bSSHvBvtVzl7jN97x6tGEWp71VMdnr6DKR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMi9FC/ohhfq0EUE3N54B1lzj6ti3oXR5haaWrhbNlAEhaaAly7nYWVCb0RV3qmZu7jY28Za/uaRXDH36iYAkO+H/Q7NBDa3IeCiKK2cndNizHlsyCGCJ6Y7m0Ybf0NUOWjkElkDE52Q2rxRgk9x8M/Jyyv5psCjSrlDj2mGyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EC8216F2;
	Fri, 20 Jun 2025 05:47:20 -0700 (PDT)
Received: from [10.57.27.59] (unknown [10.57.27.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 895973F58B;
	Fri, 20 Jun 2025 05:47:37 -0700 (PDT)
Message-ID: <413e7ed5-fc4d-4e4e-9cb4-234c41db267b@arm.com>
Date: Fri, 20 Jun 2025 13:47:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 3/4] phy: rockchip-pcie: Enable all four lanes
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>,
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
 <4c2c9a15-50bc-4a89-b5fe-d9014657fca7@arm.com> <aFVTdYWxuq9YzVQR@geday>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aFVTdYWxuq9YzVQR@geday>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-20 1:26 pm, Geraldo Nascimento wrote:
> On Fri, Jun 20, 2025 at 01:04:46PM +0100, Robin Murphy wrote:
>> On 2025-06-13 6:03 pm, Geraldo Nascimento wrote:
>>> Current code enables only Lane 0 because pwr_cnt will be incremented
>>> on first call to the function. Use for-loop to enable all 4 lanes
>>> through GRF.
>>
>> If this was really necessary, then surely it would also need the
>> equivalent changes in rockchip_pcie_phy_power_off() too?
>>
>> However, I'm not sure it *is* necessary - the NVMe on my RK3399 board
>> happily claims to be using an x4 link, so I stuck a print of inst->index
>> in this function, and sure enough I do see it being called for each
>> instance already:
>>
>> [    1.737479] phy phy-ff770000.syscon:pcie-phy.1: power_on 0
>> [    1.738810] phy phy-ff770000.syscon:pcie-phy.2: power_on 1
>> [    1.745193] phy phy-ff770000.syscon:pcie-phy.3: power_on 2
>> [    1.745196] phy phy-ff770000.syscon:pcie-phy.4: power_on 3
>>
> 
> Hi Robin, and thanks for caring, it's excellent to rely on your
> extensive expertise on ARM in general and RK3399 specifically!
> 
> However, on my board I'm positive it does not work without proposed
> patch and I get stuck with x1 link without it.
> 
> There are currently very similar patches applied downstream to Armbian
> and OpenWRT so at least I'm confident that is not only my board which is
> quirky and other people experienced the same problem.

Ah, I put that print at the top of the function - on second look now I
see that there's an awkward mix of per-lane and global data, and pwr_cnt
is actually the latter. Sure enough, moving the print past that check I
only see it once.

However, I still don't think blindly enabling all the lanes is the right
thing to do either; I'd imagine something like the (untested) diff below
would be more appropriate. That would then seem to balance with what
power_off is doing.

Thanks,
Robin.

----->8-----
diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index bd44af36c67a..a34a983db16c 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -160,11 +160,8 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
  
  	guard(mutex)(&rk_phy->pcie_mutex);
  
-	if (rk_phy->pwr_cnt++) {
-		return 0;
-	}
-
-	err = reset_control_deassert(rk_phy->phy_rst);
+	if (rk_phy->pwr_cnt++)
+		err = reset_control_deassert(rk_phy->phy_rst);
  	if (err) {
  		dev_err(&phy->dev, "deassert phy_rst err %d\n", err);
  		rk_phy->pwr_cnt--;
@@ -181,6 +178,8 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
  		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
  				   PHY_LANE_IDLE_MASK,
  				   PHY_LANE_IDLE_A_SHIFT + inst->index));
+	if (rk_phy->pwr_cnt)
+		return 0;
  
  	/*
  	 * No documented timeout value for phy operation below,


