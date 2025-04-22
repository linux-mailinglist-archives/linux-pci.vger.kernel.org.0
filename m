Return-Path: <linux-pci+bounces-26389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568D3A96833
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CE33A5AA4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BA020127A;
	Tue, 22 Apr 2025 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KDD7lAyc"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F260151985;
	Tue, 22 Apr 2025 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322742; cv=none; b=d6xsDZTsiENWMs1qUpugnq0wNF6ky5R2OVshE5ryMvuUcF5X2xr/mFD/RMnISII29e9+BT7icmg1RtZPC9yrHRJDlW//90xVkGVvYooImjoWSDrCsRgRPKqJTpRJ+3kGkP5b8gPjbXSQp20ilzpl6qSljUpOQo6SwQobdd+xBKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322742; c=relaxed/simple;
	bh=1R20NVaEfYW32eWGyKQBwcuLA6iHxqqiXcM7E9ZQ8xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bapBPabPQPImgSHdnNxN9rNGyALU4VZ0CsazgEtojgXiyW9jqSxHqmQ82rQJsJYD47f4mfIgVfDoNwd/LtTOLTcTky2dGlfHr9MBGjYpS0IMyePfHCkY1oiDVLBXKKXsOw8xDr4/TbsLjMOHwFgmi9Ah86o4gJcCiuQ7yUb01No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KDD7lAyc; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=4dJB4XRowZmBjucJ2qGpzWQ/DySAT7Z1DcoSxmqRS4g=;
	b=KDD7lAyc04ximgpITMQyK7AaoWbHS/IIhkl03AVIVWM7FaYb808qQxuBQLODRq
	HEXw4COiIHCbA/ZDb72EU0IntDVuPJngpqiQSPrjRYqCGrVkJVInePgGltmiEyET
	bD6L/E9gNuJbHBFQFQtsvr6VJxl8+s3wEhdtph5OuBXrA=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBn9mzXggdoHWyRBg--.12994S2;
	Tue, 22 Apr 2025 19:51:52 +0800 (CST)
Message-ID: <7c685f63-65ac-4817-9bd9-365e307eb965@163.com>
Date: Tue, 22 Apr 2025 19:51:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] PCI: dw-rockchip: Reorganize register and bitfield
 definitions
To: Niklas Cassel <cassel@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250422112830.204374-1-18255117159@163.com>
 <20250422112830.204374-3-18255117159@163.com> <aAeB7fO_LCzi-xCh@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aAeB7fO_LCzi-xCh@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBn9mzXggdoHWyRBg--.12994S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFW7ArW8CF18Xr4kuF4UArb_yoW5KFyrp3
	yUJFyayrs8tay7CwnYg3Z0yFy7tr4fKF4jgr4agrWUCan5Aw18Gr1jgF15Wry2qr4kWr1f
	u3s8Ww1IgF9IkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVwZcUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx43o2gHfn+RWwAAs1



On 2025/4/22 19:47, Niklas Cassel wrote:
> On Tue, Apr 22, 2025 at 07:28:29PM +0800, Hans Zhang wrote:
>> Register definitions were scattered with ambiguous names (e.g.,
>> PCIE_RDLH_LINK_UP_CHGED in PCIE_CLIENT_INTR_STATUS_MISC) and lacked
>> hierarchical grouping. Magic values for bit operations reduced code
>> clarity.
>>
>> Group registers and their associated bitfields logically. This improves
>> maintainability and aligns the code with hardware documentation.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 42 +++++++++++--------
>>   1 file changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index fd5827bbfae3..cdc8afc6cfc1 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -8,6 +8,7 @@
>>    * Author: Simon Xue <xxm@rock-chips.com>
>>    */
>>   
>> +#include <linux/bitfield.h>
>>   #include <linux/clk.h>
>>   #include <linux/gpio/consumer.h>
>>   #include <linux/irqchip/chained_irq.h>
>> @@ -34,30 +35,35 @@
>>   
>>   #define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
>>   
>> -#define PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
>> -#define PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
>> -#define PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
>> -#define PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
>> -#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
>> +#define PCIE_CLIENT_GENERAL_CONTROL	0x0
>> +#define  PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
>> +#define  PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
>> +#define  PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
>> +#define  PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
>> +
>> +#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x4
>> +#define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
>> +
>>   #define PCIE_CLIENT_INTR_STATUS_MISC	0x10
>> +#define  PCIE_RDLH_LINK_UP_CHGED	BIT(1)
>> +#define  PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
>> +
>> +#define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
>>   #define PCIE_CLIENT_INTR_MASK_MISC	0x24
>> +
>>   #define PCIE_CLIENT_POWER		0x2c
>> +#define  PME_READY_ENTER_L23		BIT(3)
>> +
>>   #define PCIE_CLIENT_MSG_GEN		0x34
>> -#define PME_READY_ENTER_L23		BIT(3)
>> -#define PME_TURN_OFF			(BIT(4) | BIT(20))
>> -#define PME_TO_ACK			(BIT(9) | BIT(25))
>> -#define PCIE_SMLH_LINKUP		BIT(16)
>> -#define PCIE_RDLH_LINKUP		BIT(17)
>> -#define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
>> -#define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
>> -#define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
>> -#define PCIE_CLIENT_GENERAL_CONTROL	0x0
>> -#define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
>> -#define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
>> +#define  PME_TURN_OFF			HIWORD_UPDATE_BIT(BIT(4))
>> +#define  PME_TO_ACK			HIWORD_UPDATE_BIT(BIT(9))
>> +
>>   #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
>> +#define  PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
>> +
>>   #define PCIE_CLIENT_LTSSM_STATUS	0x300
>> -#define PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
>> -#define PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
>> +#define  PCIE_LINKUP_MASK		GENMASK(17, 16)
> 
> Here you are adding a macro (PCIE_LINKUP_MASK) that is not used.
> 
> I suggest that you move the addition to the patch where it is actually used.
> 


Hi Niklas,

Thank you very much for your reply. Will change.

Best regards,
Hans


