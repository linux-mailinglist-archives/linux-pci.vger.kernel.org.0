Return-Path: <linux-pci+bounces-44887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F39FD22322
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 03:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33CDB30185EB
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 02:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F1E1E834B;
	Thu, 15 Jan 2026 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="O59yGBAt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3291.qiye.163.com (mail-m3291.qiye.163.com [220.197.32.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412617C220
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 02:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768445614; cv=none; b=mOcrm6vjIpby41lV/cQWEbaPHY/qDUUPJ3S+tlezMOeK2/Nnj6K9SEa3sESFgcK2elRHNmn7rGthTrEYuHtCT8jNCAZFjBAHi2UKIxPF/KlpoC8+IRyMVBH3CuSnVr4G3V7l2SL0EaEEoTypeBZ7+v8fDeh9XSVPgKq8zwTw1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768445614; c=relaxed/simple;
	bh=9kWBRcYqF9B0n2UtVJyLciNYJhyFDvJJtdMozxcSZvo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JOtOU5I4E4/iktBR+ky576Mqr4GcNI3rvI7yXSMoIA1Lm9qRr9CmVXAdkwihaEONw19q2SZP5X0an3pnbCo62qEB2mKnhIxFrTrYb8wkgDv5j4roXmA1b5AG+tjSICRp8RKNjnKkwYc33bn98Y6MZQcR9YRZRJra5yupSyW5OjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=O59yGBAt; arc=none smtp.client-ip=220.197.32.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30b01ff0a;
	Thu, 15 Jan 2026 08:31:01 +0800 (GMT+08:00)
Message-ID: <9c41f3c1-f3e4-4a5c-bbe6-9156a6df69b4@rock-chips.com>
Date: Thu, 15 Jan 2026 08:30:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Heiko Stuebner <heiko@sntech.de>, Neil Armstrong
 <neil.armstrong@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 3/5] phy: rockchip-snps-pcie3: Increase sram init timeout
To: Vinod Koul <vkoul@kernel.org>
References: <1766560210-100883-1-git-send-email-shawn.lin@rock-chips.com>
 <1766560210-100883-4-git-send-email-shawn.lin@rock-chips.com>
 <aWeaUG45FWtdgscG@vaman>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aWeaUG45FWtdgscG@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bbf1016da09cckunmf3402868502a5f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkgdSFYfHhkaGE0eH0oYHkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=O59yGBAtHIuDx0oDSA+AqCLCIkTSJaKGMpEihDPZA1fm0LXj0fVO9FTuowNm5DCTfB2g312PrD01EMWZZpZbeW89SBtPtVrEF0J+xJirxfLTtQ7eUvNg3pEm1M7FzpYtGp+6OtgilKI/oQ3vjB/zSCCZMMY1GMRJ844+BDZt0nU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=gIslVA5eTsBjIlpxhO6gDQs8srSs4OYlHc81qc0pSiY=;
	h=date:mime-version:subject:message-id:from;


在 2026/01/14 星期三 21:29, Vinod Koul 写道:
> On 24-12-25, 15:10, Shawn Lin wrote:
>> Per massive test, 500us is not enough for all chips, increase it
>> to 20000us for worse case recommended.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
>> index 9933cda..f5a5d0af 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
>> @@ -19,6 +19,9 @@
>>   #include <linux/regmap.h>
>>   #include <linux/reset.h>
>>   
>> +/* Common definition */
>> +#define RK_SRAM_INIT_TIMEOUT_US			20000
>> +
>>   /* Register for RK3568 */
>>   #define GRF_PCIE30PHY_CON1			0x4
>>   #define GRF_PCIE30PHY_CON6			0x18
>> @@ -28,6 +31,7 @@
>>   #define GRF_PCIE30PHY_WR_EN			(0xf << 16)
>>   #define SRAM_INIT_DONE(reg)			(reg & BIT(14))
>>   
>> +
> 
> why this empty line here?
> 

Oops, will fix it.

>>   #define RK3568_BIFURCATION_LANE_0_1		BIT(0)
>>   
>>   /* Register for RK3588 */
>> @@ -134,7 +138,7 @@ static int rockchip_p3phy_rk3568_calibrate(struct rockchip_p3phy_priv *priv)
>>   	ret = regmap_read_poll_timeout(priv->phy_grf,
>>   				       GRF_PCIE30PHY_STATUS0,
>>   				       reg, SRAM_INIT_DONE(reg),
>> -				       0, 500);
>> +				       0, RK_SRAM_INIT_TIMEOUT_US);
>>   	if (ret)
>>   		dev_err(&priv->phy->dev, "lock failed 0x%x, check input refclk and power supply\n",
>>   			reg);
>> @@ -203,11 +207,11 @@ static int rockchip_p3phy_rk3588_calibrate(struct rockchip_p3phy_priv *priv)
>>   	ret = regmap_read_poll_timeout(priv->phy_grf,
>>   				       RK3588_PCIE3PHY_GRF_PHY0_STATUS1,
>>   				       reg, RK3588_SRAM_INIT_DONE(reg),
>> -				       0, 500);
>> +				       0, RK_SRAM_INIT_TIMEOUT_US);
>>   	ret |= regmap_read_poll_timeout(priv->phy_grf,
>>   					RK3588_PCIE3PHY_GRF_PHY1_STATUS1,
>>   					reg, RK3588_SRAM_INIT_DONE(reg),
>> -					0, 500);
>> +					0, RK_SRAM_INIT_TIMEOUT_US);
>>   	if (ret)
>>   		dev_err(&priv->phy->dev, "lock failed 0x%x, check input refclk and power supply\n",
>>   			reg);
>> -- 
>> 2.7.4
> 


