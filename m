Return-Path: <linux-pci+bounces-43554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ED3CD83F3
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 07:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 712F13013739
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 06:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473822F9998;
	Tue, 23 Dec 2025 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="c7U0/5F9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3272.qiye.163.com (mail-m3272.qiye.163.com [220.197.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7D1DA60D
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766471035; cv=none; b=ICaNhTI05YyFHSGhZS3Wa9KGNLcO0RzXcqofZxMkWvarkK8hT6SMKcq/xYXuM5VzOL0tsuCR3L/hCiOhQ8jCaOY+jIAnLgsC8xMo1J63LXmowS0ZE2JvjWrT+cu+AFoDC2TjAuEuHDOE+6r3XbFfNRHSpWtUEB9HefczAS0BX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766471035; c=relaxed/simple;
	bh=S2wBEozRxyFx7SFHFfqEADID3qR4h6p089PXQnBo5qA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ei3iAOwCtoRmrpgvD9cBxlKzYw4DnpMHxnd1P/CjxuGkxbY+Xtuw7TaBQyljhTsfIRszR4Olbl8Ul7S3d0xcYwlklkXiBLqg3IJd+6PeTIUfJ/TNpD6TQoAUqgbtfBd7Q+LIV2zCdYeRKKc8Oy/oQwouysHYhxCo5BOyioo+xrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=c7U0/5F9; arc=none smtp.client-ip=220.197.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e3d2e72c;
	Tue, 23 Dec 2025 14:23:40 +0800 (GMT+08:00)
Message-ID: <424133b7-bd6b-4602-96ea-4413ce4f985d@rock-chips.com>
Date: Tue, 23 Dec 2025 14:23:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Manivannan Sadhasivam <mani@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Damien Le Moal <dlemoal@kernel.org>, Koichiro Den <den@valinux.co.jp>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20251210071358.2267494-2-cassel@kernel.org>
 <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
 <s5mbvhnummcegksauc7kyb2442ao27dwc63gyryetuvxojnxfj@a67nopel52tx>
 <aUknSzSpNxLeEN5o@ryzen>
 <3b34aa66-a418-4f6b-930a-0728d87d79b6@oss.qualcomm.com>
 <aUlA7y95SUC-QA4T@ryzen>
 <a24a5d8b-5818-4e11-bc09-47090de164c7@rock-chips.com>
 <63321b7d-74a7-448f-ab20-08cc771beb5d@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <63321b7d-74a7-448f-ab20-08cc771beb5d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b49e0ae7409cckunm88aaff1a2eef49
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh0eTVYaGBhIS0IaHUMYHktWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=c7U0/5F9fXd62/CeEVQTZ82z7t3sFD8Ht1AReRI8o9sVBC35VQmtxTS1xfDU6xbW7J4QZ2Vw1cPDVgaht8A7AJE1nQRcwczt1hDk51U/ZFtmTuwKFF8KuN6AVcSRJIwnbZ/RaH0O1u49rdV40q2s1pd8eiJoOymiWcBEZxwN/Bc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=WK2DkkiWbMlw+eHi/3GaghFq//0Kd1aIYgNWLyatkNs=;
	h=date:mime-version:subject:message-id:from;

在 2025/12/23 星期二 12:35, Krishna Chaitanya Chundru 写道:
> 
> 
> On 12/23/2025 6:42 AM, Shawn Lin wrote:
>> 在 2025/12/22 星期一 21:00, Niklas Cassel 写道:
>>> + Shawn
>>>
>>> On Mon, Dec 22, 2025 at 05:53:27PM +0530, Krishna Chaitanya Chundru 
>>> wrote:
>>>>
>>>>
>>>> On 12/22/2025 4:41 PM, Niklas Cassel wrote:
>>>>> On Mon, Dec 22, 2025 at 03:28:30PM +0530, Manivannan Sadhasivam wrote:
>>>>>>> Use the MSIX doorbell method which will not use iATU at all,
>>>>>>> dw_pcie_ep_raise_msix_irq_doorbell().
>>>>>>>
>>>>>> I think this is the safe bet since this feature doesn't seem like 
>>>>>> an optional
>>>>>> one.
>>>>>>
>>>>>> Niklas, if you can just fix MSI in this patch and leave out MSI-X 
>>>>>> for the vendor
>>>>>> drivers to transition to doorbell, I'm OK to merge it. Otherwise, 
>>>>>> I don't know
>>>>>> how you can reliably fix MSI-X generation with AXI slave interface.
>>>>> FWIW, I did try to simply change:
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/ 
>>>>> drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>>> index 8f2cc1ef25e3..00770f9786e3 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>>> @@ -319,7 +319,8 @@ static int rockchip_pcie_raise_irq(struct 
>>>>> dw_pcie_ep *ep, u8 func_no,
>>>>>           case PCI_IRQ_MSI:
>>>>>                   return dw_pcie_ep_raise_msi_irq(ep, func_no, 
>>>>> interrupt_num);
>>>>>           case PCI_IRQ_MSIX:
>>>>> -               return dw_pcie_ep_raise_msix_irq(ep, func_no, 
>>>>> interrupt_num);
>>>>> +               return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
>>>>> + interrupt_num);
>>>>>           default:
>>>>>                   dev_err(pci->dev, "UNKNOWN IRQ type\n");
>>>>>           }
>>>>>
>>>>>
>>>>> For the pcie-dw-rockchip driver, but it is not working:
>>>>> [  130.042849] nvme nvme0: I/O tag 0 (1000) QID 0 timeout, 
>>>>> completion polled
>>>>>
>>>>> Without this change, things work.
>>>>>
>>>>> Perhaps this feature is not an optional one, but at least we will 
>>>>> require
>>>>> more changes than a simple one liner.
>>>> Hi Niklas,
>>>>
>>>> It should be automatic only, no extra configurations should be
>>>> required, I believe your
>>>> HW doesn't support this feature, from spec 6..0a, sec 3.9.1.3
>>>> iMSIX-TX: Integrated MSI-X Transmit (USP)
>>>> I believe your HW is not generated with MSIX_TABLE_EN =1. In that
>>>> case you can't use this feature.
>>>
>>> Looking at the RK3588 TRM, it does have register:
>>> USP_PCIE_PL_MSIX_DOORBELL_OFF
>>> Address: Operational Base + offset (0x0248)
>>>
>>> Port Logic registers start at offset 0x700 on this SoC,
>>> so 0x700 + 0x248 == 0x948, which matches:
>>> drivers/pci/controller/dwc/pcie-designware.h:#define 
>>> PCIE_MSIX_DOORBELL         0x948
>>>
>>> I don't think the TRM would include this register if the
>>> DWC coere was not generated with MSIX_TABLE_EN=1.
>>>
>>
>> I checked the IP configurtion parameters for RK3588 DM controller for
>> sure, it sets MSIX_TABLE_EN=1.
>>
>> Looking into dw_pcie_ep_raise_msix_irq_doorbell(), it doesn't seem to
>> match the dwc databook. No matter for non-AXI mode or AXI access mode,
>> shouldn't we need to generate a MSI-X table RAM with data/address/ 
>> vector/TC in advanced? Am I missing anything because I didn't look
> The MSI-X table will updated automatically when host updates the MSI-X 
> table, when MSI-X is enabled
> by host.

Thanks for these details.
I re-read the databook, especially "Figure 3-49 iMSIX-TX: MSIX
Transmit ". Yes, it's updated automatically when host write access
it, which either comes from RX or local DBI(for debug purpose).


> 
> - Krishna Chaitanya.
>> too much regarding to the EPC side?
>>
>>> Shawn, any suggestions?
>>> For full thread, see:
>>> https://lore.kernel.org/linux-pci/3b34aa66- 
>>> a418-4f6b-930a-0728d87d79b6@oss.qualcomm.com/T/#t
>>>
>>>
>>> FWIW, Krishna Chaitanya, I did try the 
>>> dw_pcie_ep_raise_msix_irq_doorbell()
>>> change above also with the pci-epf-test EPF driver, and it also 
>>> caused the
>>> pci-epf-test driver to stop working.
>>>
>>>
>>> Kind regards,
>>> Niklas
>>>
>>
> 
> 


