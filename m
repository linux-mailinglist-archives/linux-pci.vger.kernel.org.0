Return-Path: <linux-pci+bounces-41848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CABEC77A85
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 08:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 732FF29145
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 07:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85970335BAD;
	Fri, 21 Nov 2025 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hnghXR09"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m1973186.qiye.163.com (mail-m1973186.qiye.163.com [220.197.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD82335074;
	Fri, 21 Nov 2025 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763709308; cv=none; b=DuuNuRXCAkg/V1RKMYpKI2ef2S/iG+Ilgjjm6qW/jmkH+DlmsSougiku2GrcXqzd8DDAtjaEGxcwyc/QsuMS9H4J7vHuBhzV+Yrgif/h6N8wPExGAoaxh6Yg9mMt5njUbpGvfuQ+pN8YN9zbuYN0K3AOdZczdLA9dBOxOuPcXZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763709308; c=relaxed/simple;
	bh=NOLQ1RHAqJ4Ke4Lu5YgZmaFnKVuyY/Xwb1CbjdrKD88=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U2EJWb09ZDa51wVHb1IBd/ITu1n56C8c8PdjcjCo6G7Ptqb0RGcozceYAGVqDRRrkAYlrXHUO1M+LlA1gvwI7w9SjWiEHWc7xRcFzoRZ2c2fa9xRDDNuxSUB5Z6JnXH+Us/CH/c7pi5pdi+aa6Vo00KPWMB5j5n34RLVi0biEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hnghXR09; arc=none smtp.client-ip=220.197.31.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a6655444;
	Fri, 21 Nov 2025 15:14:52 +0800 (GMT+08:00)
Message-ID: <c77bb3c8-f658-4275-b0f5-37ac215142f7@rock-chips.com>
Date: Fri, 21 Nov 2025 15:14:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, bhelgaas@google.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
 robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com,
 gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com,
 shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
 thippeswamy.havalige@amd.com, inochiama@gmail.com,
 ningyu@eswincomputing.com, linmin@eswincomputing.com,
 pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com,
 Frank.li@nxp.com, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v6 3/3] PCI: dwc: Add no_suspport_L2 flag and skip
 PME_Turn_Off broadcast
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
References: <20251120101018.1477-1-zhangsenchuan@eswincomputing.com>
 <20251120101236.1538-1-zhangsenchuan@eswincomputing.com>
 <dux47crrf6ranvexkpzw667hzmkgfguqadseco52svgvglalye@alxqq4ybu672>
 <11367b43.6d3.19aa52bc596.Coremail.zhangsenchuan@eswincomputing.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <11367b43.6d3.19aa52bc596.Coremail.zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9aa544106509cckunm2b944a13204b7d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0wfTVZOGkpISB9NSElIQk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hnghXR09CoBe9P9V051IBP5XN/mFDqnVhFIJm06cf4rte7Yb3mAdOuU9fqchAYKJ0sK8oixonMaGIDNK9z8f3H5k92JhxyditoZLvaHq1AZwyY8048F3jiAKbmHbcF3t31VpTaDOlEfkQmCbFsr3G+0sdlp5Iz59qooy/VwJRR0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=+PT3x6dFyDPHSY1UQdVOiSUBX7jV1afOUTNQD7zbnaI=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/21 星期五 14:48, zhangsenchuan 写道:
> 
> 
> 
>> -----Original Messages-----
>> From: "Manivannan Sadhasivam" <mani@kernel.org>
>> Send time:Thursday, 20/11/2025 20:45:38
>> To: zhangsenchuan@eswincomputing.com
>> Cc: bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com, inochiama@gmail.com, ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com, Frank.li@nxp.com
>> Subject: Re: [PATCH v6 3/3] PCI: dwc: Add no_suspport_L2 flag and skip PME_Turn_Off broadcast
>>
>> On Thu, Nov 20, 2025 at 06:12:35PM +0800, zhangsenchuan@eswincomputing.com wrote:
>>> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
>>>
>>> The ESWIN EIC7700 soc does not support enter L2 link state. Therefore add
>>> no_suspport_L2 flag skip PME_Turn_Off broadcast and link state check code,
>>> other driver can reuse this flag if meet the similar situation.
>>>
>>> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
>>> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
>>> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
>>
>> Does this patch work for you?
>> https://lore.kernel.org/linux-pci/20251119-pci-dwc-suspend-rework-v1-1-aad104828562@oss.qualcomm.com/
> 
> if the PCIe link is not up, this suits me too, but if the PCIe link up,
> our hardware does not support entering the L2 link state. At this point,

Per PCIe spec, 5.2 Link State Power Management:
"L2/L3 Ready transition protocol support is required.
The L2/L3 Ready state entry transition process must begin as soon as
possible following the acknowledgment of a PME_Turn_Off Message, (i.e.,
the injection of a PME_TO_Ack TLP). The Downstream component initiates
L2/L3 Ready entry by sending a PM_Enter_L23 DLLP. "

"L2 support is optional, and dependent upon the presence of auxiliary power"

I interpret it as it is mandatory support for broadcast PME_Turn_Off and
ack PME_TO_Ack, which is what the original code does. Then your IP can't
really go into L2 for whatever reasons? Will your controller be broken 
if acking PME_Turn_Off?  Otherwise we could still let L2/L3 Ready
transstion happen and leave the device in L3 to save power.


> it is also necessary to skip the broadcast PME_Turn_Off message and wait
> for L2 transition.
> 
> Kind regards,
> Senchuan Zhang
> 
>>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
>>>   drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>>>   2 files changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index e92513c5bda5..a203577606e5 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -1156,6 +1156,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>>>   	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>>>   		return 0;
>>>
>>> +	if (pci->no_suspport_L2)
>>> +		goto stop_link;
>>> +
>>>   	if (pci->pp.ops->pme_turn_off) {
>>>   		pci->pp.ops->pme_turn_off(&pci->pp);
>>>   	} else {
>>> @@ -1182,6 +1185,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>>>   	 */
>>>   	udelay(1);
>>>
>>> +stop_link:
>>>   	dw_pcie_stop_link(pci);
>>>   	if (pci->pp.ops->deinit)
>>>   		pci->pp.ops->deinit(&pci->pp);
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>>> index e995f692a1ec..170a73299ce5 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>> @@ -539,6 +539,7 @@ struct dw_pcie {
>>>   	 * use_parent_dt_ranges to true to avoid this warning.
>>>   	 */
>>>   	bool			use_parent_dt_ranges;
>>> +	bool			no_suspport_L2;
>>>   };
>>>
>>>   #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
>>> --
>>> 2.25.1
>>>
>>
>> -- 
>> மணிவண்ணன் சதாசிவம்


