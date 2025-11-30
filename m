Return-Path: <linux-pci+bounces-42321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7B1C94AB7
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 03:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EBB94E06D4
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 02:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22901E1DF0;
	Sun, 30 Nov 2025 02:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JzLWIGZ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49251.qiye.163.com (mail-m49251.qiye.163.com [45.254.49.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1909B1E0DCB;
	Sun, 30 Nov 2025 02:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764470920; cv=none; b=MMcCN3REmKFZwSDINC+wrvhMvSdTfCT8sm7qdZ6Nwhp319FiXb11r1cT3tw4yNcCmoeBPF8HKUzqZBgv/vs4WEdncOeq9o0dnnH2sf7gA0zE1SXQfZ1sM/ehPzO6l4I5wzal2Pt6+Xcx2zMeZzYhz++kt+RMUmNUrDII0jhtz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764470920; c=relaxed/simple;
	bh=1k+cWOYAukKSkK+vW0sOtzTEkK3a4VTiXYlOWmwlxyM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DmzWy3U5thELLqrJEs+krrJWvy9aiT+88DKTw+UukLCoCzZ1qxPd/Smov0SepXlI8ak16/UnXGS/ynAzdygZM8SXZog02VjY20wVZCI0TjMNQ7I+iWNrreMpoiEdk61lrsAtyVM1NTIT6gIxrO8bTo8YFal0bzTT8vSjw/JTpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JzLWIGZ1; arc=none smtp.client-ip=45.254.49.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2b625e1cc;
	Sun, 30 Nov 2025 10:43:15 +0800 (GMT+08:00)
Message-ID: <c43b637a-a0c1-4106-b37b-df389c085057@rock-chips.com>
Date: Sun, 30 Nov 2025 10:43:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com,
 Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
 Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, cros-qcom-dts-watchers@chromium.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Program device-id
To: Manivannan Sadhasivam <mani@kernel.org>
References: <20251127-program-device-id-v1-0-31ad36beda2c@quicinc.com>
 <20251127-program-device-id-v1-1-31ad36beda2c@quicinc.com>
 <09aed728-51ca-42dd-b680-f6597e0ac00a@rock-chips.com>
 <mp67n7jw3azihax25yw2u25f6nrjl237exw2t66fz3bpt3wzdt@2j4ooqdfgp2l>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <mp67n7jw3azihax25yw2u25f6nrjl237exw2t66fz3bpt3wzdt@2j4ooqdfgp2l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ad2a49dc509cckunm63e59fb97e5053
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR4dHVYYHUlDQx1MSU8YTUhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JzLWIGZ17NOIFOI3ayh5vO6VXFQPw2MCOVDn39SpmB8L8zxnnBzRvZIT1oguG9PvfEPcyT802IjS+J4n0Bvs7szki6SXYoeFaQjkbwfd2UiIMU0zaB8ifvl0ryyHRJ7R+NrRBXZ0wVmDRtiRhH79cKNYJdI2zKpWXu0D9GvnyDU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=AnhHjeoEZhWmtIMeV/a+xErbeAW6DGW2H4faPusNFPI=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/29 星期六 15:34, Manivannan Sadhasivam 写道:
> On Fri, Nov 28, 2025 at 09:03:52AM +0800, Shawn Lin wrote:
>> 在 2025/11/27 星期四 23:30, Sushrut Shree Trivedi 写道:
>>> For some controllers, HW doesn't program the correct device-id
>>> leading to incorrect identification in lspci. For ex, QCOM
>>> controller SC7280 uses same device id as SM8250. This would
>>> cause issues while applying controller specific quirks.
>>>
>>> So, program the correct device-id after reading it from the
>>> devicetree.
>>>
>>> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
>>> ---
>>>    drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
>>>    drivers/pci/controller/dwc/pcie-designware.h      | 2 ++
>>>    2 files changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index e92513c5bda5..e8b975044b22 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -619,6 +619,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>>    		}
>>>    	}
>>> +	pp->device_id = 0xffff;
>>> +	of_property_read_u32(np, "device-id", &pp->device_id);
>>> +
>>>    	dw_pcie_version_detect(pci);
>>>    	dw_pcie_iatu_detect(pci);
>>> @@ -1094,6 +1097,10 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>>>    	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
>>> +	/* Program correct device id */
>>> +	if (pp->device_id != 0xffff)
>>> +		dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, pp->device_id);
>>> +
>>>    	/* Program correct class for RC */
>>>    	dw_pcie_writew_dbi(pci, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>>> index e995f692a1ec..eff6da9438c4 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>> @@ -431,6 +431,8 @@ struct dw_pcie_rp {
>>>    	struct pci_config_window *cfg;
>>>    	bool			ecam_enabled;
>>>    	bool			native_ecam;
>>> +	u32			vendor_id;
>>
>> I don't see where vendor_id is used.
>> And why should dwc core take care of per HW bugs, could someone else
>> will argue their HW doesn't program correct vender id/class code, then
>> we add more into dw_pcie_rp to fix these?
>>
> 
> Device ID and Vendor ID are PCI generic properties and many controllers specify
> them in devicetree due to the default values being wrong or just hardcode them
> in the driver. There is nothing wrong in DWC core programming these values if
> they are available in devicetree.
> 
>> How about do it in the defective HW drivers?
>>
> 
> If the issue is a vendor DWC wrapper specific, for sure it should be added to
> the relevant controller driver. But this issue is pretty common among the DWC
> wrapper implementations.
> 

I think there are already some dwc instances working around this kind of 
defects in their relevant condroller driver.

drivers/pci/controller/dwc/pci-keystone.c:806:  dw_pcie_writew_dbi(pci, 
PCI_VENDOR_ID, id & PCIE_VENDORID_MASK);

drivers/pci/controller/dwc/pcie-spacemit-k1.c:146: 
dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);

drivers/pci/controller/dwc/pcie-spear13xx.c:139: 
dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, 0x104A);

drivers/pci/controller/dwc/pci-keystone.c:807:  dw_pcie_writew_dbi(pci, 
PCI_DEVICE_ID, id >> PCIE_DEVICEID_SHIFT);

drivers/pci/controller/dwc/pcie-spacemit-k1.c:147: 
dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_SPACEMIT_K1);

drivers/pci/controller/dwc/pcie-spear13xx.c:140: 
dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, 0xCD80);

If this patch applied, there are two non-consistent apporaches to work
around this situation. Could dwc core provide a common helper for 
them(this qcom instance inclueded) to call without bothering the dwc core?

> - Mani
> 


