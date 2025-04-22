Return-Path: <linux-pci+bounces-26394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF564A969EC
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 14:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689DA7A8915
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAECB27C15E;
	Tue, 22 Apr 2025 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AxBH6coe"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D84A27CB04;
	Tue, 22 Apr 2025 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325023; cv=none; b=rlvTyfF1g9NWIHfSBMEcyNHo1Kc4IbS5leXRideLQyZjhuDNdyr/RSrHhwVHxhLzryrbJ6hJ+EHzk4l+x94YYuYEL9hRknmpXTWKLO8cjh2GvC+ik47laaf8/tXblyLI8CEKMt6u5/SDGfSgXqDLBMzsYBXxP55niyuUO6dKYeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325023; c=relaxed/simple;
	bh=KQ5da+cv1eTYcFQf+D+q3cBtDTH+OiygQ1KCjtnXgVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYmqbPoHvfsXrdOJMuiUdi7fovLHTbUAi99z1LA+XGzeoqRq9CY5QcLi8fc73B2ws4crKIC81knOJWt601EgxJ4a5qqSbEWrv0cwXZ+7HBPkTxaAS9htmRXqton55UVg1LLImQzn5nRahTAUB03mSs8YxRhhSuquinV1YJ9VdJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AxBH6coe; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Olj6Biy2uWlsyIHDCf7izc2r8uqisRfOK7x96H1nFwQ=;
	b=AxBH6coe/WvRZ61+t+GOxNo9h7IRzo8T7OQSwR5A6rVrUO38zUkBDvPH0XC4mm
	vvTSrjZ105t+ECOPbRjZgVe/IJGmJIOkwsfxikouG21ExLzyEJMPZOiHH52yVmdk
	gcy5UD8MyaGKg2jvLOxwRiVT+1USb8PyD2JV/ronf+if4=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3nwStiwdoMaJdBw--.13540S2;
	Tue, 22 Apr 2025 20:29:34 +0800 (CST)
Message-ID: <44121a71-26a9-4203-a219-eeb26ff8763c@163.com>
Date: Tue, 22 Apr 2025 20:29:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: dw-rockchip: Unify link status checks with
 FIELD_GET
To: Niklas Cassel <cassel@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250422112830.204374-1-18255117159@163.com>
 <20250422112830.204374-4-18255117159@163.com> <aAeAAhb4R8ya_mBO@ryzen>
 <7716b76f-be79-4ed1-b8d2-29258cb250ab@163.com> <aAeKcEfyDS1ImynJ@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aAeKcEfyDS1ImynJ@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3nwStiwdoMaJdBw--.13540S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF47Ar1kZr4kWr18tFWfuFg_yoW3Jry8pa
	98AFy2kr4UJ3ya9w1vkFn8ZF47tFnIkFWUGrsag3y7u3Zayw18Gr1UWF9Igryxtr4kCFy3
	Cwn8Ga47WF43CwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULyCXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwc3o2gHiX9OCQAAsC



On 2025/4/22 20:24, Niklas Cassel wrote:
> On Tue, Apr 22, 2025 at 07:50:50PM +0800, Hans Zhang wrote:
>>
>>
>> On 2025/4/22 19:39, Niklas Cassel wrote:
>>> On Tue, Apr 22, 2025 at 07:28:30PM +0800, Hans Zhang wrote:
>>>> Link-up detection manually checked PCIE_LINKUP bits across RC/EP modes,
>>>> leading to code duplication. Centralize the logic using FIELD_GET. This
>>>> removes redundancy and abstracts hardware-specific bit masking, ensuring
>>>> consistent link state handling.
>>>>
>>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 +++++----------
>>>>    1 file changed, 5 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>> index cdc8afc6cfc1..2b26060af5c2 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>>> @@ -196,10 +196,7 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
>>>>    	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>>>>    	u32 val = rockchip_pcie_get_ltssm(rockchip);
>>>> -	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
>>>> -		return 1;
>>>> -
>>>> -	return 0;
>>>> +	return FIELD_GET(PCIE_LINKUP_MASK, val) == 3;
>>>
>>> While I like the idea of your patch, here you are replacing something that
>>> is easy to read (PCIE_LINKUP) with a magic value, which IMO is a step in
>>> the wrong direction.
>>>
>>
>> Hi Niklas,
>>
>> Thank you very much for your reply. How about I add another macro
>> definition?
>>
>> #define PCIE_LINKUP 3
> 
> Yes, adding another macro for it is what I meant.
> 


Hi Niklas,

Thank you very much for your reply and reminder. The second and third 
patches will be changed as follows:


patch 0002:

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c 
b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index fd5827bbfae3..4d5c8ed18953 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -34,30 +34,37 @@

  #define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)

-#define PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
-#define PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
-#define PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
-#define PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
-#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
+#define PCIE_CLIENT_GENERAL_CONTROL	0x0
+#define  PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
+#define  PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
+#define  PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
+#define  PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
+
+#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x4
+#define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
+
  #define PCIE_CLIENT_INTR_STATUS_MISC	0x10
+#define  PCIE_RDLH_LINK_UP_CHGED	BIT(1)
+#define  PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
+
+#define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
  #define PCIE_CLIENT_INTR_MASK_MISC	0x24
+
  #define PCIE_CLIENT_POWER		0x2c
+#define  PME_READY_ENTER_L23		BIT(3)
+
  #define PCIE_CLIENT_MSG_GEN		0x34
-#define PME_READY_ENTER_L23		BIT(3)
-#define PME_TURN_OFF			(BIT(4) | BIT(20))
-#define PME_TO_ACK			(BIT(9) | BIT(25))
-#define PCIE_SMLH_LINKUP		BIT(16)
-#define PCIE_RDLH_LINKUP		BIT(17)
-#define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
-#define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
-#define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
-#define PCIE_CLIENT_GENERAL_CONTROL	0x0
-#define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
-#define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
+#define  PME_TURN_OFF			HIWORD_UPDATE_BIT(BIT(4))
+#define  PME_TO_ACK			HIWORD_UPDATE_BIT(BIT(9))
+
  #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
+#define  PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
+
  #define PCIE_CLIENT_LTSSM_STATUS	0x300
-#define PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
-#define PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
+#define  PCIE_SMLH_LINKUP		BIT(16)
+#define  PCIE_RDLH_LINKUP		BIT(17)
+#define  PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
+#define  PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)

  struct rockchip_pcie {
  	struct dw_pcie pci;




patch 0003:

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c 
b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 4d5c8ed18953..0553e7e80e1b 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -8,6 +8,7 @@
   * Author: Simon Xue <xxm@rock-chips.com>
   */

+#include <linux/bitfield.h>
  #include <linux/clk.h>
  #include <linux/gpio/consumer.h>
  #include <linux/irqchip/chained_irq.h>
@@ -61,9 +62,8 @@
  #define  PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)

  #define PCIE_CLIENT_LTSSM_STATUS	0x300
-#define  PCIE_SMLH_LINKUP		BIT(16)
-#define  PCIE_RDLH_LINKUP		BIT(17)
-#define  PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
+#define  PCIE_LINKUP			0x3
+#define  PCIE_LINKUP_MASK		GENMASK(17, 16)
  #define  PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)

  struct rockchip_pcie {
@@ -197,10 +197,7 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
  	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
  	u32 val = rockchip_pcie_get_ltssm(rockchip);

-	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
-		return 1;
-
-	return 0;
+	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
  }

  static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
@@ -500,7 +497,7 @@ static irqreturn_t 
rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
  	struct dw_pcie *pci = &rockchip->pci;
  	struct dw_pcie_rp *pp = &pci->pp;
  	struct device *dev = pci->dev;
-	u32 reg, val;
+	u32 reg;

  	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
  	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
@@ -509,8 +506,7 @@ static irqreturn_t 
rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
  	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));

  	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
-		val = rockchip_pcie_get_ltssm(rockchip);
-		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
+		if (rockchip_pcie_link_up(pci)) {
  			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
  			/* Rescan the bus to enumerate endpoint devices */
  			pci_lock_rescan_remove();
@@ -527,7 +523,7 @@ static irqreturn_t 
rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
  	struct rockchip_pcie *rockchip = arg;
  	struct dw_pcie *pci = &rockchip->pci;
  	struct device *dev = pci->dev;
-	u32 reg, val;
+	u32 reg;

  	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
  	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
@@ -541,8 +537,7 @@ static irqreturn_t 
rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
  	}

  	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
-		val = rockchip_pcie_get_ltssm(rockchip);
-		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
+		if (rockchip_pcie_link_up(pci)) {
  			dev_dbg(dev, "link up\n");
  			dw_pcie_ep_linkup(&pci->ep);
  		}

Best regards,
Hans


