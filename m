Return-Path: <linux-pci+bounces-4665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE487649F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 14:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9917E1F22362
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199871BC30;
	Fri,  8 Mar 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="r9xrE2na"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF0EEA9;
	Fri,  8 Mar 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902962; cv=none; b=F+LvqQ2IYg4wc1dVaKr92LkBgWhSMpBAWKACQ8obITmHzMWm/mwZw6BN1ti8XFv9MpFaAvP+sZ5/siMBpJlMYcCe7Prge58pgd/Zu2z/HpbHq06q+MzX1OMLCsNieFqX7PtcXsluOOVesqgzhC5r8LXvDG5fDhsuHvwf8j1n7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902962; c=relaxed/simple;
	bh=I5YqwpsiX0KclggNHlj9WYV+KI4BcMpB3JvbIPa7aE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbmj0TbF/CVdz66wWcx7mDKaE+8o7Y4TQVI4Vw37TnNoGtiI16Xfq1rHhaRw+sCauJPpGXACkCCIoAXaAjpqPUUkBUZg7ftIDzCNZFNA3HOrKyNzoiE3F3AtfxkO1VCIZ8FfxJ9xIfgMWm/Xpt+G/gowgOgMNOBLFN27ISZf+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=r9xrE2na; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709902958;
	bh=I5YqwpsiX0KclggNHlj9WYV+KI4BcMpB3JvbIPa7aE8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r9xrE2nabgTtZAH/PPwUSYXsCuq1IRkOzlpGXqpMVx5LSMT05p6H/i88jyvzyB6Wh
	 PE7EdHwWohUfzABm8rD5N1ghF0/MjwxqPN5aBBOW5dIlUm/F/aLWGOqEWqnGQHLVo7
	 ULBh85CVs3dXCZOxihT5QadU54uug8BnLDGprKySAr3NvgO6ztAGYi7BOkRqk1HyC4
	 adRXIcKRw8ZvpLpWhciUs+rAi8kUB1HAcULzUrZmcXbKi6Lgu3bxdd9LzKRF6LQ6m/
	 BarzvfjjTD9u4Vxk1afjkPHnrdodV0RKzhsNAv0HvQQNbuHE2iZb29zOiNgR2v9BsX
	 fbYrdehduz7vQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 50CC937813CA;
	Fri,  8 Mar 2024 13:02:37 +0000 (UTC)
Message-ID: <fb9d4791-73e2-491a-8117-e8e5f811fe7a@collabora.com>
Date: Fri, 8 Mar 2024 14:02:36 +0100
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
To: =?UTF-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "wenst@chromium.org" <wenst@chromium.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 Ryder Lee <Ryder.Lee@mediatek.com>,
 "nfraprado@collabora.com" <nfraprado@collabora.com>
References: <20240229092449.580971-1-angelogioacchino.delregno@collabora.com>
 <30824df32636dec25b9a5972b1ee8de76b295feb.camel@mediatek.com>
 <c55f2c6e-1de8-4248-a52a-d6c9e49b565a@collabora.com>
 <8a5a695ccbc4401954f7df5a9690af726fc59173.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8a5a695ccbc4401954f7df5a9690af726fc59173.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 08/03/24 10:44, Jianjun Wang (王建军) ha scritto:
> On Wed, 2024-03-06 at 09:50 +0100, AngeloGioacchino Del Regno wrote:
>> Il 01/03/24 03:48, Jianjun Wang (王建军) ha scritto:
>>> Hi Angelo,
>>>
>>> Thanks for your patch.
>>>
>>> On Thu, 2024-02-29 at 10:24 +0100, AngeloGioacchino Del Regno
>>> wrote:
>>>> Some SoCs have two PCI-Express controllers: in the case of
>>>> MT8195,
>>>> one of them is using a dedicated PHY, but the other uses a combo
>>>> PHY
>>>> that is shared with USB and in that case the PHY cannot be reset
>>>> from the PCIe driver, or USB functionality will be unable to
>>>> resume.
>>>>
>>>> Resetting the PCIe MAC without also resetting the PHY will result
>>>> in
>>>> a full system lockup at PCIe resume time and the only option to
>>>> resume operation is to hard reboot the system (with a PMIC cut-
>>>> off).
>>>>
>>>> To resolve this issue, check if we've got both a PHY and a MAC
>>>> reset
>>>> and, if not, never assert resets at PM suspend time: in that
>>>> case,
>>>> the link is still getting powered down as both the clocks and the
>>>> power domains will go down anyway.
>>>>
>>>> Fixes: d537dc125f07 ("PCI: mediatek-gen3: Add system PM support")
>>>> Signed-off-by: AngeloGioacchino Del Regno <
>>>> angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>>    - Rebased over next-20240229
>>>>
>>>>    drivers/pci/controller/pcie-mediatek-gen3.c | 25
>>>> ++++++++++++++-----
>>>> --
>>>>    1 file changed, 17 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c
>>>> b/drivers/pci/controller/pcie-mediatek-gen3.c
>>>> index 975b3024fb08..99b5d7a49be1 100644
>>>> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
>>>> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
>>>> @@ -874,17 +874,26 @@ static int mtk_pcie_power_up(struct
>>>> mtk_gen3_pcie *pcie)
>>>>    	return err;
>>>>    }
>>>>    
>>>> -static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
>>>> +static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie, bool
>>>> is_suspend)
>>>>    {
>>>> +	bool suspend_reset_supported = pcie->mac_reset && pcie-
>>>>> phy_reset;
>>>>
>>>> +
>>>>    	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
>>>>    
>>>>    	pm_runtime_put_sync(pcie->dev);
>>>>    	pm_runtime_disable(pcie->dev);
>>>> -	reset_control_assert(pcie->mac_reset);
>>>> +
>>>> +	/*
>>>> +	 * Assert MAC reset only if we also got a PHY reset, otherwise
>>>> +	 * the system will lockup at PM resume time.
>>>> +	 */
>>>> +	if (is_suspend && suspend_reset_supported)
>>>> +		reset_control_assert(pcie->mac_reset);
>>>>    
>>>>    	phy_power_off(pcie->phy);
>>>>    	phy_exit(pcie->phy);
>>>> -	reset_control_assert(pcie->phy_reset);
>>>> +	if (is_suspend && suspend_reset_supported)
>>>> +		reset_control_assert(pcie->phy_reset);
>>>>    }
>>>>    
>>>>    static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>>>> @@ -920,7 +929,7 @@ static int mtk_pcie_setup(struct
>>>> mtk_gen3_pcie
>>>> *pcie)
>>>>    	return 0;
>>>>    
>>>>    err_setup:
>>>> -	mtk_pcie_power_down(pcie);
>>>> +	mtk_pcie_power_down(pcie, false);
>>>>    
>>>>    	return err;
>>>>    }
>>>> @@ -951,7 +960,7 @@ static int mtk_pcie_probe(struct
>>>> platform_device
>>>> *pdev)
>>>>    	err = pci_host_probe(host);
>>>>    	if (err) {
>>>>    		mtk_pcie_irq_teardown(pcie);
>>>> -		mtk_pcie_power_down(pcie);
>>>> +		mtk_pcie_power_down(pcie, false);
>>>>    		return err;
>>>>    	}
>>>>    
>>>> @@ -969,7 +978,7 @@ static void mtk_pcie_remove(struct
>>>> platform_device *pdev)
>>>>    	pci_unlock_rescan_remove();
>>>>    
>>>>    	mtk_pcie_irq_teardown(pcie);
>>>> -	mtk_pcie_power_down(pcie);
>>>> +	mtk_pcie_power_down(pcie, false);
>>>
>>> Is there any reason not to reset the MAC and PHY when probe fails
>>> and
>>> driver removing? Some SoCs may not have MTCMOS to cut off their
>>> power,
>>> we need to assert the reset signal to save power in that case.
>>>
>>
>> Sorry for the late reply - yes, there is a reason.
>>
>> On platforms needing this quirk, resetting at .remove() time will
>> hang the
>> machine if the module is reinserted later (hence, .probe() called at
>> a later
>> time).
> 
> Does this only happen when the PCIe MAC is reset without resetting the
> PHY? Is it related to the reset framework?
> 

Happens only when MAC is reset without resetting the PHY after calling
phy_power_off(); phy_exit();

It's not a reset framework issue, that's for sure.

Angelo

> Thanks.
>>
>> Regards,
>> Angelo
>>
>>> Thanks.
>>>
>>>>    }
>>>>    
>>>>    static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
>>>> @@ -1044,7 +1053,7 @@ static int mtk_pcie_suspend_noirq(struct
>>>> device
>>>> *dev)
>>>>    	dev_dbg(pcie->dev, "entered L2 states successfully");
>>>>    
>>>>    	mtk_pcie_irq_save(pcie);
>>>> -	mtk_pcie_power_down(pcie);
>>>> +	mtk_pcie_power_down(pcie, true);
>>>>    
>>>>    	return 0;
>>>>    }
>>>> @@ -1060,7 +1069,7 @@ static int mtk_pcie_resume_noirq(struct
>>>> device
>>>> *dev)
>>>>    
>>>>    	err = mtk_pcie_startup_port(pcie);
>>>>    	if (err) {
>>>> -		mtk_pcie_power_down(pcie);
>>>> +		mtk_pcie_power_down(pcie, false);
>>>>    		return err;
>>>>    	}
>>>>    
>>
>>
>>

-- 
AngeloGioacchino Del Regno
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718


