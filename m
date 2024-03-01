Return-Path: <linux-pci+bounces-4301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B4E86DDD4
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 10:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F801C22F82
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 09:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672706A03E;
	Fri,  1 Mar 2024 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uwBnz4EB"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83466A329;
	Fri,  1 Mar 2024 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283998; cv=none; b=FsjnqxoDtW6xVIDH4U3N1bykjT3c9XQuEKmhNwOZteXV3n4/k944+ANTtRnzHBB8fpetG/HLySJzpouYNf69xcZAP1hUHEvgJlOm0N1JGHNFjJkpavCST7D9QY433Apf+QipSe3VPYqal2L/xwJ8rG5JclSyjynbfKl4ZagWVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283998; c=relaxed/simple;
	bh=t77D3hvYZjR15Q549ojSRDIMkv4v3gVrHr+1V9N+rL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+67/PvHV8FaBmUnvwIIxxvJ9Va3NQkkupKZezrCTThIJWrSxAtD+0X/B3WKppdrTnd3wrzLqzJs5U85qksT5HZHWYruro2/YigLgXwwLJ3+Sb4IKG0GiM0vaakIPiG3YKzjOogK4m4yPZ67a1zTFwmECY1zXAC1uUE6Kp+qxo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uwBnz4EB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709283994;
	bh=t77D3hvYZjR15Q549ojSRDIMkv4v3gVrHr+1V9N+rL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uwBnz4EBydDQpkGmpplf+4b/eYMciswh5zSoUmYvkIdces6Ahwl1mXDgcCyxMsVDJ
	 yGKRWPhhP8oURbxsVglpDWzv0xU4x+gIf/MPc+k+NzfQfqwomPsgvn5z1LY0mzqx2U
	 LlUBgbXCutq2ej76v9MoDWGxfFaelHwoDoUZXsCUV79yIQstIhpSnE/P9KCxqAFW5z
	 uuyP1nUn27QGiQAPK+8pxn7RXLQgxFy0oMzdJQ5J1XS032saweZIM9VwPwbet/aShX
	 QyhagQzGQnlxWm5UElT1hpU7rP4Fy36pXbqH+uh8B6k7yxkD0TcLwoLWNum/Vvt26w
	 5b9UA+X7Ib9dQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0454E37814A4;
	Fri,  1 Mar 2024 09:06:33 +0000 (UTC)
Message-ID: <2b2effdd-0b9d-40fd-a88d-ab364f2b0668@collabora.com>
Date: Fri, 1 Mar 2024 10:06:33 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Assert MAC reset only if PHY reset
 also present
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
 jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
 matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, wenst@chromium.org, nfraprado@collabora.com
References: <20240229092449.580971-1-angelogioacchino.delregno@collabora.com>
 <a55428b8-27b3-42f7-8154-ccc7dde469df@ti.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <a55428b8-27b3-42f7-8154-ccc7dde469df@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/03/24 07:42, Siddharth Vadapalli ha scritto:
> On Thu, Feb 29, 2024 at 10:24:49AM +0100, AngeloGioacchino Del Regno wrote:
>> Some SoCs have two PCI-Express controllers: in the case of MT8195,
>> one of them is using a dedicated PHY, but the other uses a combo PHY
>> that is shared with USB and in that case the PHY cannot be reset
>> from the PCIe driver, or USB functionality will be unable to resume.
>>
>> Resetting the PCIe MAC without also resetting the PHY will result in
>> a full system lockup at PCIe resume time and the only option to
>> resume operation is to hard reboot the system (with a PMIC cut-off).
>>
>> To resolve this issue, check if we've got both a PHY and a MAC reset
>> and, if not, never assert resets at PM suspend time: in that case,
>> the link is still getting powered down as both the clocks and the
>> power domains will go down anyway.
>>
>> Fixes: d537dc125f07 ("PCI: mediatek-gen3: Add system PM support")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>
>> Changes in v2:
>>   - Rebased over next-20240229
>>
>>   drivers/pci/controller/pcie-mediatek-gen3.c | 25 ++++++++++++++-------
>>   1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
>> index 975b3024fb08..99b5d7a49be1 100644
>> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
>> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
>> @@ -874,17 +874,26 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
>>   	return err;
>>   }
>>   
>> -static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
>> +static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie, bool is_suspend)
>>   {
>> +	bool suspend_reset_supported = pcie->mac_reset && pcie->phy_reset;
>> +
>>   	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>>   
>>   	pm_runtime_put_sync(pcie->dev);
>>   	pm_runtime_disable(pcie->dev);
>> -	reset_control_assert(pcie->mac_reset);
>> +
>> +	/*
>> +	 * Assert MAC reset only if we also got a PHY reset, otherwise
>> +	 * the system will lockup at PM resume time.
>> +	 */
>> +	if (is_suspend && suspend_reset_supported)
>> +		reset_control_assert(pcie->mac_reset);
>>   
>>   	phy_power_off(pcie->phy);
>>   	phy_exit(pcie->phy);
> 
> Wouldn't this power off the shared PHY? Or will the PHY driver make this
> NO-OP if the PHY is shared, in which case the above two statements could
> be combined with the other statements in the:
> if (is_suspend && suspend_reset_supported)
> condition to get a single block of code that also combines the
> reset_control_assert(pcie->phy_reset)
> present below.
> 

No, that'd be fine:

static int mtk_phy_power_off(struct phy *phy)
{
	struct mtk_phy_instance *instance = phy_get_drvdata(phy);
	struct mtk_tphy *tphy = dev_get_drvdata(phy->dev.parent);

	if (instance->type == PHY_TYPE_USB2)
		u2_phy_instance_power_off(tphy, instance);
	else if (instance->type == PHY_TYPE_PCIE)
		pcie_phy_instance_power_off(tphy, instance);

	return 0;
}

...it's two different PHY instances that we're dealing with, here :-)

Cheers,
Angelo

>> -	reset_control_assert(pcie->phy_reset);
>> +	if (is_suspend && suspend_reset_supported)
>> +		reset_control_assert(pcie->phy_reset);
>>   }
>>   
> ...
> 
> Regards,
> Siddharth.



