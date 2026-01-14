Return-Path: <linux-pci+bounces-44689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AE3D1BFCA
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 02:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24C6F300C172
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 01:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFA41DF25C;
	Wed, 14 Jan 2026 01:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="MTEX6kXV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m15590.qiye.163.com (mail-m15590.qiye.163.com [101.71.155.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148914AD20
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 01:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768355304; cv=none; b=hoJsrbCQxZQ2UFIxXJ9vEobD0eCgZD1NqtEGHWJY77xR6uSi40MAqy4/kA8mNNJDCIAhcu7ThwTTRejzf6Lq4kdBFMpbzS5l/qY0MvyS288XpT01h+6EoAiF+dhDwODQFyfcLG3Kh9qbX/1aw2uhpB+s7BvK4U08bzFFSLWLc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768355304; c=relaxed/simple;
	bh=aCNS0lS5c6fltu2MzNadI4I1ln44SEVfhwg3z0ql52M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FBcIWSKal5nN6ccApht0DjWVflfksVngYfEx0yndyKzz453j4mneUoJu/Vi1zNjLjscGXm04bdU1nniuPoHIhQkXXfAppz5p0RyqmgOCRZfofmptZ0QxRS8vQqatG64aOd1obHdLgfslzErnAxG0JpCAoaxF0WYQmK/eixMhnR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=MTEX6kXV; arc=none smtp.client-ip=101.71.155.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 308ba3e68;
	Wed, 14 Jan 2026 09:32:56 +0800 (GMT+08:00)
Message-ID: <1814707c-1ab1-414e-8f84-fce748b6f165@rock-chips.com>
Date: Wed, 14 Jan 2026 09:32:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Disable BAR 0 and BAR 1 for RC mode
To: Manivannan Sadhasivam <mani@kernel.org>
References: <1766570461-138256-1-git-send-email-shawn.lin@rock-chips.com>
 <jrah3krizuwyfwhmvq67wjsye2eeompjflpuo4dz2mgugi5txt@np6gknrtbkqo>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <jrah3krizuwyfwhmvq67wjsye2eeompjflpuo4dz2mgugi5txt@np6gknrtbkqo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bba2269fa09cckunmeed149924252e5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkwZGFYeH00fH04fGE4ZH0tWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=MTEX6kXVb9GwYym+vUUGXj0LzWIjA8mOHM1ygjN5OJ3/8S2sIxAU8C+p+aN/L/ohDAaUbTQ1ln7ZH8GqZo4YykFTzgwW4u087OC0Hg4z4be+kO3yQ2RN6Ik+sblWGa4MQRCeTFqTQDqmLLzCWg87IMcIXWY6usY7NbtunGSsedw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=RwuldkTHkRdgDbBtixJ83jhlVo/aPu3UyniC5of32nU=;
	h=date:mime-version:subject:message-id:from;

Hi Mani

在 2026/01/13 星期二 22:29, Manivannan Sadhasivam 写道:
> On Wed, Dec 24, 2025 at 06:01:01PM +0800, Shawn Lin wrote:
>> To slitence the useless bar allocation error log of RC when
>> scanning bus, as RC doesn't need BARs at all.
> 
> It is not RC, but Root Port. It is OK to disable the Root Port BARs if they
> don't serve any purpose, but I think the issue is that the BAR size is bogus.
> Both BARs report 1GiB of size, which I don't think it makes sense for a Root
> Port.
> 

Sure, it's the root port reports the bogus BARS size.

> Can I reword the commit message as:
> 
> Some Rockchip PCIe Root Port report bogus size of 1GiB for the BAR memories and
> they cause below resource allocation issue during probe. Since there is no use
> of the Root Port BAR memories, disable both of them.
> 

Looks fine to me. Would you prefer a v2 or you could amend the commit
msg while applying this patch?

Thanks.

> - Mani
> 
>>
>>    pci 0000:00:00.0: [1d87:3588] type 01 class 0x060400 PCIe Root Port
>>    pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x3fffffff]
>>    pci 0000:00:00.0: BAR 1 [mem 0x00000000-0x3fffffff]
>>    pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
>> 	...
>>    pci 0000:00:00.0: BAR 0 [mem 0x900000000-0x93fffffff]: assigned
>>    pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: can't assign; no space
>>    pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: failed to assign
>>    pci 0000:00:00.0: ROM [mem 0xf0200000-0xf020ffff pref]: assigned
>>    pci 0000:00:00.0: BAR 0 [mem 0x900000000-0x93fffffff]: releasing
>>    pci 0000:00:00.0: ROM [mem 0xf0200000-0xf020ffff pref]: releasing
>>    pci 0000:00:00.0: BAR 0 [mem 0x900000000-0x93fffffff]: assigned
>>    pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: can't assign; no space
>>    pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: failed to assign
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index f8605fe..e421fa0 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -80,6 +80,8 @@
>>   #define  PCIE_LINKUP_MASK		GENMASK(17, 16)
>>   #define  PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
>>   
>> +#define PCIE_TYPE0_HDR_DBI2_OFFSET      0x100000
>> +
>>   struct rockchip_pcie {
>>   	struct dw_pcie pci;
>>   	void __iomem *apb_base;
>> @@ -292,6 +294,8 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>>   	if (irq < 0)
>>   		return irq;
>>   
>> +	pci->dbi_base2 = pci->dbi_base + PCIE_TYPE0_HDR_DBI2_OFFSET;
>> +
>>   	ret = rockchip_pcie_init_irq_domain(rockchip);
>>   	if (ret < 0)
>>   		dev_err(dev, "failed to init irq domain\n");
>> @@ -302,6 +306,10 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>>   	rockchip_pcie_configure_l1ss(pci);
>>   	rockchip_pcie_enable_l0s(pci);
>>   
>> +	/* Disable RC's BAR0 and BAR1 */
>> +	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, 0x0);
>> +	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_1, 0x0);
>> +
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.7.4
>>
>>
> 


