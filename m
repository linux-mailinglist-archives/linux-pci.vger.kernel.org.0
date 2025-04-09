Return-Path: <linux-pci+bounces-25548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B608A820FB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 11:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AFD47B28C6
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 09:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F039525D53C;
	Wed,  9 Apr 2025 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="P4o+RGJw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m1973173.qiye.163.com (mail-m1973173.qiye.163.com [220.197.31.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA725A338
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190724; cv=none; b=QGgRNuY8QPWwYKBAkT8guUc41tojEMJHeIKIAbfvwDn4zZin4deaCVDtEr5Byqn6A4LrPiXJRELsXLSp98jSe6VFKv772wi7y+HVECr1QOD/0WT5qj3Gq0NopjCkJjapVCq0JzOSk9pjK8VXt+Yhug7AZwvQLWKeKy7IDyFiFXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190724; c=relaxed/simple;
	bh=yS5rcrf2rX2WYFCpzKwAyOt3w8DfDf2g4Qb/Lz/M1is=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l+/yJ0DzauZBcAi1H6mN8m2UaNV+xVTgDKEWDsW5Z5Is3mjjY0vX6Qqu8NL+kmCii2Rgbzb7AWUkbELOrQMFtMcdONrIrHO5ptfslFcn0iPDTHnYabHbVEAjGtVqAEU7ObSAcDAGUU7ahKRcb4k55F+M5WK1/VLtmi0qDFVUkCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=P4o+RGJw; arc=none smtp.client-ip=220.197.31.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1138104d1;
	Wed, 9 Apr 2025 17:09:55 +0800 (GMT+08:00)
Message-ID: <38e69551-cc40-11a9-191f-de9a193c5e51@rock-chips.com>
Date: Wed, 9 Apr 2025 17:09:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from
 rockchip_pcie_link_up()
To: Niklas Cassel <cassel@kernel.org>
References: <1744180833-68472-1-git-send-email-shawn.lin@rock-chips.com>
 <Z_YwNt6WUuijKTjt@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <Z_YwNt6WUuijKTjt@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR4ZSlYZSk4dQh4dSU0dQx1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9619d02e2109cckunm1138104d1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OQg6Ohw5LTIMKDw#OB8vIR8r
	EBEwCQxVSlVKTE9PSkNCTEJNQk1CVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU5LTkk3Bg++
DKIM-Signature:a=rsa-sha256;
	b=P4o+RGJwYMZ4PHS0GwP39nuCMM4m06Y9usjsKEsfW54xAgwHlRStxumNr94eVUa+Htxw18p68Wzw3U0a0vw0caqJYbkxgaEB2EsRTqypsalnIipnLyB9Dzzkr/lzNvz8/ZdNvugRI5atofv1nmuPu2yAqG/IP0vAFZ4TsGWsqPU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=VKh4xrTeGOu0jwgiXvFn8iADbjhHgliSJABtaxU9mvY=;
	h=date:mime-version:subject:message-id:from;

在 2025/04/09 星期三 16:30, Niklas Cassel 写道:
> On Wed, Apr 09, 2025 at 02:40:33PM +0800, Shawn Lin wrote:
>> Two mistakes here:
>> 1. 0x11 is L0 not L0S, so the naming is wrong from the very beginning.
>> 2. It's totally broken if enabling ASPM as rockchip_pcie_link_up() treat other
>> states, for instance, L0S or L1 as link down which is obvioult wrong.
>>
>> Remove the check.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index c624b7e..21dc99c 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -44,7 +44,6 @@
>>   #define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
>>   #define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
>>   #define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
>> -#define PCIE_L0S_ENTRY			0x11
>>   #define PCIE_CLIENT_GENERAL_CONTROL	0x0
>>   #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
>>   #define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
>> @@ -177,8 +176,7 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
>>   	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>>   	u32 val = rockchip_pcie_get_ltssm(rockchip);
>>   
>> -	if ((val & PCIE_LINKUP) == PCIE_LINKUP &&
>> -	    (val & PCIE_LTSSM_STATUS_MASK) == PCIE_L0S_ENTRY)
>> +	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
>>   		return 1;
>>   
>>   	return 0;
>> -- 
>> 2.7.4
>>
> 
> You should probably also add:
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
> 

Will add.

> 
> Considering that dw_pcie_link_up() looks like this:
> https://github.com/torvalds/linux/blob/v6.15-rc1/drivers/pci/controller/dwc/pcie-designware.c#L714-L725
> 
> Why not simply remove the rockchip_pcie_link_up() callback completely?
> 
> Is there any advantage of using a rockchip specific way to read link up,
> rather than just reading link up via the DWC PCIE_PORT_DEBUG1 register?

This is a very good question which we tried but made real products
suffer from it for a long time, and finally we found the reason and
discarded it.

Quoted from DWC databook, section 8.2.3 AXI Bridge Initialization,
Clocking and Reset:

"In RC Mode, your AXI application must not generate any MEM or I/O
requests, until the host software has enabled the Memory Space Enable
(MSE), and IO Space Enable (ISE) bits respectively. Your RC application
should not generate CFG requests until it has confirmed that the link is
up by sampling the smlh_link_up and rdlh_link_up outputs."

Quoted from DWC databook, section 5.50 SII: Debug Signals
"[36]: smlh_link_up: LTSSM reports PHY link up or LTSSM is in
Loopback.Active for Loopback Master" which refers to
PCIE_PORT_DEBUG1_LINK_UP per code.

The timing in dwc core is drving smlh_link_up->L0->rdlh_link_up->FC
init(a fixed delay) from IC simulation when linking up.

The dw_pcie_link_up() wasn't reliably work as expected by massive test.
The problem is clear from our ASIC view, that cxpl_debug_info from DWC
core is missing rdlh_link_up. cxpl_debug_info[32:63] is indentical to
PCIE_PORT_DEBUG1, So reading PCIE_PORT_DEBUG1 and check
smlh_link_up isn't enough.

The problem was introduced by commit 1 and fixed by commit 2 but not to
the end. And finally commit 3 rename the register but not fix anything.

It was broken from the first time. Any dwc controllers should not be use
the buggy default method to check link up state from our view.
So this's the whole story for it, which may help you understand the
indeed problem and why we reinvent rockchip_pcie_link_up() here.

[1]. commit dac29e6c5460 ("PCI: designware: Add default link up check if
     sub-driver doesn't override")

[2]. commit 01c076732e82 ("PCI: designware: Check LTSSM training bit
     before deciding link is up")

[3]. commit 60ef4b072ba0 ("PCI: dwc: imx6: Share PHY debug register
     definitions")


> 
> 
> Kind regards,
> Niklas
> 

