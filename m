Return-Path: <linux-pci+bounces-43552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED88CCD7A87
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 02:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 474DC3025160
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 01:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5F354ACE;
	Tue, 23 Dec 2025 01:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JYpTxDAp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3283.qiye.163.com (mail-m3283.qiye.163.com [220.197.32.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0DE352FB5
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 01:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766453302; cv=none; b=EoNfTxO89kJ2xwtwLGSORvtOdoNEiIqiUgoUJTZaxsHnbJp8hnqNKlpHCIaeRYKwTBbGGlid1pd+0jwBGm/qGuDvS80qUuIyM4LsZqb34eNHvq11ol1+0aaljq+hsjH75JOs0cP+mivsl0Hbgvcj2PdHCFBgxZK9/eeL9kAVmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766453302; c=relaxed/simple;
	bh=/mVYEUPN/6Ay1K4nBp/yH7lD6pXBv9++FMipE9sUYzQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QKtwovKnwOI5pFXanqDi5h1n+c1zG9XWGPBO3GMr9YxCXqsIUrqWGWL2o776Dgh9hAlQCfFPzV5NpfuxyWeoAlSWY7FT0K7Wiyv0sj0NNfGESl75CffHHPjdWAv8jcm1wNs74Uj5kEncSD+zT0VJBVarr22SQnqVpE4ca4kxUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JYpTxDAp; arc=none smtp.client-ip=220.197.32.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e3226a8c;
	Tue, 23 Dec 2025 09:12:52 +0800 (GMT+08:00)
Message-ID: <a24a5d8b-5818-4e11-bc09-47090de164c7@rock-chips.com>
Date: Tue, 23 Dec 2025 09:12:48 +0800
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
To: Niklas Cassel <cassel@kernel.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20251210071358.2267494-2-cassel@kernel.org>
 <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
 <s5mbvhnummcegksauc7kyb2442ao27dwc63gyryetuvxojnxfj@a67nopel52tx>
 <aUknSzSpNxLeEN5o@ryzen>
 <3b34aa66-a418-4f6b-930a-0728d87d79b6@oss.qualcomm.com>
 <aUlA7y95SUC-QA4T@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aUlA7y95SUC-QA4T@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b48c4236c09cckunm8fa69a6e2a7e41
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx5OSFYYSB5KSk0YGRgYHR9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JYpTxDApLntBG/Ct8DOeThwirBQ+BDLtJ4+LtDcFYvZhfj6K9QPW3IueMJyWABvlTFMOGM6I7a5FOd8D/Hp3kqba7E1S8/pOLVkrdoCxuRHGkd7Q6av+xt9Z9rB6f/As8/t5WmddrLkjAZc1mFWev4wgPEIpKyzO+cK6G5jENdo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=4v5BSObKyjJT2uiPjjoNm6tXTlo/77obiPIdyBHt93o=;
	h=date:mime-version:subject:message-id:from;

在 2025/12/22 星期一 21:00, Niklas Cassel 写道:
> + Shawn
> 
> On Mon, Dec 22, 2025 at 05:53:27PM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 12/22/2025 4:41 PM, Niklas Cassel wrote:
>>> On Mon, Dec 22, 2025 at 03:28:30PM +0530, Manivannan Sadhasivam wrote:
>>>>> Use the MSIX doorbell method which will not use iATU at all,
>>>>> dw_pcie_ep_raise_msix_irq_doorbell().
>>>>>
>>>> I think this is the safe bet since this feature doesn't seem like an optional
>>>> one.
>>>>
>>>> Niklas, if you can just fix MSI in this patch and leave out MSI-X for the vendor
>>>> drivers to transition to doorbell, I'm OK to merge it. Otherwise, I don't know
>>>> how you can reliably fix MSI-X generation with AXI slave interface.
>>> FWIW, I did try to simply change:
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> index 8f2cc1ef25e3..00770f9786e3 100644
>>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> @@ -319,7 +319,8 @@ static int rockchip_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>>>           case PCI_IRQ_MSI:
>>>                   return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>>>           case PCI_IRQ_MSIX:
>>> -               return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
>>> +               return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
>>> +                                                         interrupt_num);
>>>           default:
>>>                   dev_err(pci->dev, "UNKNOWN IRQ type\n");
>>>           }
>>>
>>>
>>> For the pcie-dw-rockchip driver, but it is not working:
>>> [  130.042849] nvme nvme0: I/O tag 0 (1000) QID 0 timeout, completion polled
>>>
>>> Without this change, things work.
>>>
>>> Perhaps this feature is not an optional one, but at least we will require
>>> more changes than a simple one liner.
>> Hi Niklas,
>>
>> It should be automatic only, no extra configurations should be
>> required, I believe your
>> HW doesn't support this feature, from spec 6..0a, sec 3.9.1.3
>> iMSIX-TX: Integrated MSI-X Transmit (USP)
>> I believe your HW is not generated with MSIX_TABLE_EN =1. In that
>> case you can't use this feature.
> 
> Looking at the RK3588 TRM, it does have register:
> USP_PCIE_PL_MSIX_DOORBELL_OFF
> Address: Operational Base + offset (0x0248)
> 
> Port Logic registers start at offset 0x700 on this SoC,
> so 0x700 + 0x248 == 0x948, which matches:
> drivers/pci/controller/dwc/pcie-designware.h:#define PCIE_MSIX_DOORBELL         0x948
> 
> I don't think the TRM would include this register if the
> DWC coere was not generated with MSIX_TABLE_EN=1.
> 

I checked the IP configurtion parameters for RK3588 DM controller for
sure, it sets MSIX_TABLE_EN=1.

Looking into dw_pcie_ep_raise_msix_irq_doorbell(), it doesn't seem to
match the dwc databook. No matter for non-AXI mode or AXI access mode,
shouldn't we need to generate a MSI-X table RAM with 
data/address/vector/TC in advanced? Am I missing anything because I 
didn't look
too much regarding to the EPC side?

> Shawn, any suggestions?
> For full thread, see:
> https://lore.kernel.org/linux-pci/3b34aa66-a418-4f6b-930a-0728d87d79b6@oss.qualcomm.com/T/#t
> 
> 
> FWIW, Krishna Chaitanya, I did try the dw_pcie_ep_raise_msix_irq_doorbell()
> change above also with the pci-epf-test EPF driver, and it also caused the
> pci-epf-test driver to stop working.
> 
> 
> Kind regards,
> Niklas
> 


