Return-Path: <linux-pci+bounces-26545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B432A98C92
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6623AE016
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 14:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187FC27054C;
	Wed, 23 Apr 2025 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OhudICsc"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A463149E17;
	Wed, 23 Apr 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417748; cv=none; b=YeiofIzVpSEX/sCo+cW7+q0k1MVR16o8SQP7+houhvkcZvjnwFu66g8J5Cj2Qdhdfav4vgqFrOkVLZuMP4MU6FXo4Jw0WbKrR5ZKtc1MAGMoErtKonwLWEmEYLnizD2KLX3VX3owlM5ZvnJn3lcdYjq7bHJYsaB3XQAQFvV0uT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417748; c=relaxed/simple;
	bh=/DMHVsEnD/BzUR8poZu4/uOWVkwpTFT3gHjSxGkCoR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVkUdHsmxivs8qgeye/YNwqhE5sAOS96J/JZuanR0w3j/tocxKnKf36HkaoXSSGwA3KaI35ya4YbubVhzUS+VKIXsWuwV4120Rd3Z6HO/d+gBaReei6lbJFG1OhYD1fqYw8lB1pMk4jcINHLJbTqjtkcXEGN5yToEe9GvDGYKyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OhudICsc; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=6xbZYXykMjgKMSpp52ywZEBlzjIEow9Ok6NjY0siqUc=;
	b=OhudICscJ21Kt98vX6rUiv4cDB7SwN1mK2jKC53EgKi7bz9iuBd6o/OE+zMLPn
	h22rs/khVJeHuPHZ0OA+edvEA6E1n/cPPN9+Y3cU6bJa/Yn28bnAYQPf0J8DGPQe
	Q3WkU7dElgsQe6x4t39U2vpOY5z5mL0muVjmEway1Grho=
Received: from [192.168.71.89] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDHnCTi9QhoY7rzBQ--.27617S2;
	Wed, 23 Apr 2025 22:14:59 +0800 (CST)
Message-ID: <352e40a0-65e2-499f-a7dd-904a4a7b19da@163.com>
Date: Wed, 23 Apr 2025 22:14:57 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: dw-rockchip: Reorganize register and bitfield
 definitions
To: Niklas Cassel <cassel@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250423105415.305556-1-18255117159@163.com>
 <20250423105415.305556-3-18255117159@163.com> <aAjufPQnBsR6ysAH@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aAjufPQnBsR6ysAH@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgDHnCTi9QhoY7rzBQ--.27617S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wr1xGry5KryDKF4ktr1xAFb_yoWxur1fp3
	4DAFyIyr45tay7Z3s5uFs8XFWIqrnxKFWUWrsagrWUZ3WkAw48Gw1j9FyrWFy3Jr4kCrWf
	uwn8C34SgFWakrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBq2_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxg4o2gI7X36cgAAs0



On 2025/4/23 21:43, Niklas Cassel wrote:
> On Wed, Apr 23, 2025 at 06:54:14PM +0800, Hans Zhang wrote:
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
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 71 ++++++++++++-------
>>   1 file changed, 45 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index fd5827bbfae3..6cf75160fb1c 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -34,30 +34,49 @@
>>   
>>   #define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
>>   
>> -#define PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
>> -#define PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
>> -#define PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
>> -#define PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
>> -#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
>> -#define PCIE_CLIENT_INTR_STATUS_MISC	0x10
>> -#define PCIE_CLIENT_INTR_MASK_MISC	0x24
>> -#define PCIE_CLIENT_POWER		0x2c
>> -#define PCIE_CLIENT_MSG_GEN		0x34
>> -#define PME_READY_ENTER_L23		BIT(3)
>> -#define PME_TURN_OFF			(BIT(4) | BIT(20))
>> -#define PME_TO_ACK			(BIT(9) | BIT(25))
>> -#define PCIE_SMLH_LINKUP		BIT(16)
>> -#define PCIE_RDLH_LINKUP		BIT(17)
>> -#define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
>> -#define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
>> -#define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
>> -#define PCIE_CLIENT_GENERAL_CONTROL	0x0
>> +/* General Control Register */
>> +#define PCIE_CLIENT_GENERAL_CON		0x0
>> +#define  PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
>> +#define  PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
>> +#define  PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
>> +#define  PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
>> +
>> +/* Interrupt Status Register Related to Message Reception */
>> +#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x4
>> +
>> +/* Interrupt Status Register Related to Legacy Interrupt */
>>   #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
>> +
>> +/*  Interrupt Status Register Related to Miscellaneous Operation */
> 
> double spaces, other comments just have one space.
> 

Hi Niklas,

Thank you very much for your reply. Will change.

> 
>> +#define PCIE_CLIENT_INTR_STATUS_MISC	0x10
>> +#define  PCIE_RDLH_LINK_UP_CHGED	BIT(1)
>> +#define  PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
>> +
>> +/* Interrupt Mask Register Related to Legacy Interrupt */
>>   #define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
>> +
>> +/* Interrupt Mask Register Related to Miscellaneous Operation */
>> +#define PCIE_CLIENT_INTR_MASK_MISC	0x24
>> +
>> +/* Power Management Control Register */
>> +#define PCIE_CLIENT_POWER_CON		0x2c
>> +#define  PME_READY_ENTER_L23		BIT(3)
>> +
>> +/*  Message Generation Control Register */
> 
> double spaces, other comments just have one space.
> 

Will change.

> 
>> +#define PCIE_CLIENT_MSG_GEN_CON		0x34
>> +#define  PME_TURN_OFF			HIWORD_UPDATE_BIT(BIT(4))
>> +#define  PME_TO_ACK			HIWORD_UPDATE_BIT(BIT(9))
>> +
>> +/* Hot Reset Control Register */
>>   #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
>> +#define  PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
>> +
>> +/* LTSSM Status Register */
>>   #define PCIE_CLIENT_LTSSM_STATUS	0x300
>> -#define PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
>> -#define PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
>> +#define  PCIE_SMLH_LINKUP		BIT(16)
>> +#define  PCIE_RDLH_LINKUP		BIT(17)
>> +#define  PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
>> +#define  PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
>>   
>>   struct rockchip_pcie {
>>   	struct dw_pcie pci;
>> @@ -176,13 +195,13 @@ static u32 rockchip_pcie_get_pure_ltssm(struct dw_pcie *pci)
>>   static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
>>   {
>>   	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
>> -				 PCIE_CLIENT_GENERAL_CONTROL);
>> +				 PCIE_CLIENT_GENERAL_CON);
>>   }
>>   
>>   static void rockchip_pcie_disable_ltssm(struct rockchip_pcie *rockchip)
>>   {
>>   	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DISABLE_LTSSM,
>> -				 PCIE_CLIENT_GENERAL_CONTROL);
>> +				 PCIE_CLIENT_GENERAL_CON);
>>   }
>>   
>>   static int rockchip_pcie_link_up(struct dw_pcie *pci)
>> @@ -274,8 +293,8 @@ static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>>   	u32 status;
>>   
>>   	/* 1. Broadcast PME_Turn_Off Message, bit 4 self-clear once done */
>> -	rockchip_pcie_writel_apb(rockchip, PME_TURN_OFF, PCIE_CLIENT_MSG_GEN);
>> -	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_MSG_GEN,
>> +	rockchip_pcie_writel_apb(rockchip, PME_TURN_OFF, PCIE_CLIENT_MSG_GEN_CON);
>> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_MSG_GEN_CON,
>>   				 status, !(status & BIT(4)), PCIE_PME_TO_L2_TIMEOUT_US / 10,
>>   				 PCIE_PME_TO_L2_TIMEOUT_US);
>>   	if (ret) {
>> @@ -294,7 +313,7 @@ static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
>>   
>>   	/* 3. Clear PME_TO_Ack and Wait for ready to enter L23 message */
>>   	rockchip_pcie_writel_apb(rockchip, PME_TO_ACK, PCIE_CLIENT_INTR_STATUS_MSG_RX);
>> -	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_POWER,
>> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_POWER_CON,
>>   				 status, status & PME_READY_ENTER_L23,
>>   				 PCIE_PME_TO_L2_TIMEOUT_US / 10,
>>   				 PCIE_PME_TO_L2_TIMEOUT_US);
>> @@ -552,7 +571,7 @@ static void rockchip_pcie_ltssm_enable_control_mode(struct rockchip_pcie *rockch
>>   	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
>>   	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
>>   
>> -	rockchip_pcie_writel_apb(rockchip, mode, PCIE_CLIENT_GENERAL_CONTROL);
>> +	rockchip_pcie_writel_apb(rockchip, mode, PCIE_CLIENT_GENERAL_CON);
> 
> I can see why you renamed PCIE_CLIENT_GENERAL_CONTROL to PCIE_CLIENT_GENERAL_CON
> (to match PCIE_CLIENT_MSG_GEN_CON).
> 
> But now we have PCIE_CLIENT_MSG_GEN_CON / PCIE_CLIENT_GENERAL_CON and
> PCIE_CLIENT_HOT_RESET_CTRL.
> 
> _CTRL seems like a more common shortening. How about renaming all three to
> end with _CTRL ?

I saw that TRM is named like this.

PCIE_CLIENT_GENERAL_CON / PCIE_CLIENT_MSG_GEN_CON / 
PCIE_CLIENT_HOT_RESET_CTRL

Shall we take TRM as the standard or your suggestion?

Best regards,
Hans




