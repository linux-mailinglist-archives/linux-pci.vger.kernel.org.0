Return-Path: <linux-pci+bounces-30269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C91AE1F9E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 17:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82DE87AD382
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699E82DCC0B;
	Fri, 20 Jun 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="J4fitMSV"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D45B292936;
	Fri, 20 Jun 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435163; cv=none; b=RGvCvpyq+1NZ10q423ekhytwpnvj1mvMC5fo4yjFdwHBMkUfYZswSWS2sdrFOMSEm0LQBUQMDTpQ+vkbeuNgn+1hZhpEGgL+1DOXO8VTVl+k8UjGoghR7DbQe9RqBli8+H9fPV+n3BN/zkuwdun3hmmecK7uhXnAd+KPOL/yEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435163; c=relaxed/simple;
	bh=YWywS6coQ5SLZX7nQ9wv5WL8S0zIjuBiMyIx4hdFcZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBCvkfAgnSFl9EJimrgHAH0yZV+CEKpQRNpYpcUuPmKuM3WKDA+Mz1Xam3AeQ/3HyQpHkiYZwnWOStOqkqdOO+oSJLfuDHcJxz8jc7yAc3FKYWTgoZc2H4Qr/ptTA3uHG71PVxmLICqpoRJDgTUguYiCcvQHKLjvzspyZVVISJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=J4fitMSV; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=0zrM8W2TbSsSIHvT1Fq4IVGHy7WN7Km4fk5n2KCsDZg=;
	b=J4fitMSVfCyFl9sFMsejJfExQJjX5ak/mbOya/qJbysx2L2x6nfErZb0HeEn2t
	4u1d8czktvXwNmZTtXizOgBTIs59ATRW7ZbUk2LowXejD5t/XYtNA2K9GobExCeh
	pOIIK2ouvF0xt8SkVj2G249iaVqK5g0eiYGF+rwejVsLQ=
Received: from [IPV6:240e:b8f:919b:3100:8440:da7c:be7e:927f] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnzAA9hVVoKwqyAA--.25131S2;
	Fri, 20 Jun 2025 23:58:54 +0800 (CST)
Message-ID: <4bfc8c05-c6e6-4246-960c-ee5802840523@163.com>
Date: Fri, 20 Jun 2025 23:58:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: rockchip: Remove redundant PCIe message routing
 definitions
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 shawn.lin@rock-chips.com, heiko@sntech.de, robh@kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250620154202.GA1292011@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250620154202.GA1292011@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgCnzAA9hVVoKwqyAA--.25131S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw1DWF4xAF4xCF1kCrWfXwb_yoW5Jw4rpr
	WUXayFyF48Jr43ua4aqan3XF47XanrtF4jgr1I9w4fKF1fWryrWa4Yvr45Grn8XrW8Xrn2
	k390ka4DKFZ8J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UntxhUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxVyo2hVgqRJRAAAsJ



On 2025/6/20 23:42, Bjorn Helgaas wrote:
> On Sat, Jun 07, 2025 at 11:49:13PM +0800, Hans Zhang wrote:
>> The Rockchip driver contained duplicated message routing and INTx code
>> definitions (e.g., ROCKCHIP_PCIE_MSG_ROUTING_TO_RC,
>> ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTA). These are already provided by the
>> PCI core in drivers/pci/pci.h as PCIE_MSG_TYPE_R_RC and
>> PCIE_MSG_CODE_ASSERT_INTA, respectively.
>>
>> Remove the driver-specific definitions and use the common PCIe macros
>> instead. This aligns the driver with the PCIe specification and reduces
>> maintenance overhead.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/controller/pcie-rockchip.h | 14 --------------
>>   1 file changed, 14 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
>> index 5864a20323f2..12bc8da59d73 100644
>> --- a/drivers/pci/controller/pcie-rockchip.h
>> +++ b/drivers/pci/controller/pcie-rockchip.h
>> @@ -215,20 +215,6 @@
>>   #define RC_REGION_0_TYPE_MASK			GENMASK(3, 0)
>>   #define MAX_AXI_WRAPPER_REGION_NUM		33
>>   
>> -#define ROCKCHIP_PCIE_MSG_ROUTING_TO_RC		0x0
>> -#define ROCKCHIP_PCIE_MSG_ROUTING_VIA_ADDR		0x1
>> -#define ROCKCHIP_PCIE_MSG_ROUTING_VIA_ID		0x2
>> -#define ROCKCHIP_PCIE_MSG_ROUTING_BROADCAST		0x3
>> -#define ROCKCHIP_PCIE_MSG_ROUTING_LOCAL_INTX		0x4
>> -#define ROCKCHIP_PCIE_MSG_ROUTING_PME_ACK		0x5
>> -#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTA		0x20
>> -#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTB		0x21
>> -#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTC		0x22
>> -#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTD		0x23
>> -#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTA		0x24
>> -#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTB		0x25
>> -#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTC		0x26
>> -#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTD		0x27
> 
> Thanks for doing this!  In fact, these definitions are not only
> redundant, they're not even used at all.
> 
>>   #define ROCKCHIP_PCIE_MSG_ROUTING_MASK			GENMASK(7, 5)
>>   #define ROCKCHIP_PCIE_MSG_ROUTING(route) \
>>   	(((route) << 5) & ROCKCHIP_PCIE_MSG_ROUTING_MASK)
> 
> And neither are these ROUTING and CODE definitions.

Dear Bjorn,

Yes, this driver has too many unused definitions. I can delete the other 
unused definitions next. For this series, I just delete the similar 
macro definitions in drivers/pci/pci.h.

Best regards,
Hans


