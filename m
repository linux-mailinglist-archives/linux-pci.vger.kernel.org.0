Return-Path: <linux-pci+bounces-39131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7C4C00714
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 12:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB8934E15A7
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 10:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FDB2C3257;
	Thu, 23 Oct 2025 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UBy+sSM0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3274.qiye.163.com (mail-m3274.qiye.163.com [220.197.32.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A026224AE6
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214958; cv=none; b=mJgT0VdboUf92cXdjnGrwUAJff8NwFAl95lBIesb/60y5i44A80RZSnwAFftEZfrMNvPbAGMm39Ac/w1JsnMgkaFYV9u4DYbTz1E8FLE/5+PpMLveIF5rSuF+gkFnrOv2xYfe3XfVZrYpXiQJue/0JyAa6pka1aZAJkdhcY6VNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214958; c=relaxed/simple;
	bh=VwJV/9fkdrDLNxd9vDmjY5855CARG0xYR8SNNImRt7U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tdYuDFRpxsff/U6uqR/3amdd5SZKQ7D+gNFtfJ8lvzjwSMmlASCqyPw3DqYuOqgKdfENSOgabFV9rCj8dI4hXckOmzpR3zEUqWxTbblyQMbYwgly9QvT9gTz84uYQfOk/g4EJIZlVFQi9t9hKjH9gDenhBeAYwrT9JUFyleRNRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UBy+sSM0; arc=none smtp.client-ip=220.197.32.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26f0320aa;
	Thu, 23 Oct 2025 18:22:23 +0800 (GMT+08:00)
Message-ID: <1a524cac-a133-4117-b07a-5a90dd77747c@rock-chips.com>
Date: Thu, 23 Oct 2025 18:22:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
 Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>, Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/2] PCI: dw-rockchip: Configure L1sub support
To: Diederik de Haas <diederik@cknow-tech.com>
References: <1761187883-150120-1-git-send-email-shawn.lin@rock-chips.com>
 <DDPLWD21EDEB.25TD1X46N5BDK@cknow-tech.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <DDPLWD21EDEB.25TD1X46N5BDK@cknow-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a1097528f09cckunmf729716f9690c3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUlPT1ZOTR5MGEsZHR1DSBhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UBy+sSM0Taw8yNOSMOYRENyLyBEN734ff8Tl1pW8eeCbF4o68naIGWnHQLG8BuDYN+fuGpiSRyWWrd4l8IASMilI6EWyIkYjKPWhTK68NIhEnYmj3xuq8GE3k7vMaa2A+rysUw/yTRvwIlocSJo/rLC0KoTHgpWv4NN6Wm4qZwU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=bZf9GLaDuOpYri9NkWFlwZ1QBQTJPfORe94Rrb6agFo=;
	h=date:mime-version:subject:message-id:from;



在 2025/10/23 星期四 17:49, Diederik de Haas 写道:
> On Thu Oct 23, 2025 at 4:51 AM CEST, Shawn Lin wrote:
>> L1 PM Substates for RC mode require support in the dw-rockchip driver
>> including proper handling of the CLKREQ# sideband signal. It is mostly
>> handled by hardware, but software still needs to set the clkreq fields
>> in the PCIE_CLIENT_POWER_CON register to match the hardware implementation.
>>
>> For more details, see section '18.6.6.4 L1 Substate' in the RK3658 TRM 1.1
>> Part 2, or section '11.6.6.4 L1 Substate' in the RK3588 TRM 1.0 Part2.
>>
>> Meanwhile, for the EP mode, we haven't prepared enough to actually support
>> L1 PM Substates yet. So disable it now until proper support is added later.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v3:
>> - rephrease the changelog
>> - use FIELD_PREP_WM16
>> - rename to rockchip_pcie_configure_l1sub
>> - disable L1ss for EP mode
>>
>> Changes in v2:
>> - drop of_pci_clkreq_presnt API
>> - drop dependency of Niklas's patch
>>
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 43 +++++++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index 3e2752c..25d2474 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -62,6 +62,12 @@
>>   /* Interrupt Mask Register Related to Miscellaneous Operation */
>>   #define PCIE_CLIENT_INTR_MASK_MISC	0x24
>>   
>> +/* Power Management Control Register */
>> +#define PCIE_CLIENT_POWER_CON		0x2c
>> +#define  PCIE_CLKREQ_READY		FIELD_PREP_WM16(BIT(0), 1)
>> +#define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
>> +#define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
>> +
>>   /* Hot Reset Control Register */
>>   #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
>>   #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
>> @@ -85,6 +91,7 @@ struct rockchip_pcie {
>>   	struct regulator *vpcie3v3;
>>   	struct irq_domain *irq_domain;
>>   	const struct rockchip_pcie_of_data *data;
>> +	bool supports_clkreq;
>>   };
>>   
>>   struct rockchip_pcie_of_data {
>> @@ -200,6 +207,37 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
>>   	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
>>   }
>>   
>> +/*
>> + * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for the steps
>> + * needed to support L1 substates. Currently, just enable L1 substates for RC
>> + * mode if CLKREQ# is properly connected and supports-clkreq is present in DT.
>> + * For EP mode, there are more things should be done to actually save power in
> 
> "For EP mode, more things should be done ..." or
> "For EP mode, there are more things that should be done ..."
> 
> Q: Is this patch set to fix the problem I and others reported wrt ASPM?
> 
> Because there's Niklas' patch which has been accepted, there's another
> patch by Bjorn which initially didn't land on the linux-rockchip ML and
> there's this patch set.
> To me, those *seem* all 3 different solutions to the same issue, but
> it's quite possible I'm wrong in that. Apparently to try Bjorn's patch,
> one should not have Niklas' patch applied. And I have no idea what, if
> any, the relationship is of this patch set with those others.
> 
> Some clarification would be helpful for n00bs like me.

I think Bejorn's patch is for v6.18 to not enable L1ss support on
different platforms. And Niklas' patch is for v6.19 to explicitly
disable L1ss on Rockchip platforms, because even with Bejorn's
patch, someone could still enable L1ss and make dw-rockchip broken.

This $subject patch just try to implement L1ss support on Rockchip's
platform for v6.19 cycle too. And by previous discussion, we will
replace Niklas' patch with this one. Hope it explains the situation
clearly.

> 
> Cheers,
>    Diederik
> 
>> + * L1 substates, so disable L1 substates until there is proper support.
>> + */
>> +static void rockchip_pcie_configure_l1sub(struct dw_pcie *pci)
>> +{
>> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>> +	u32 cap, l1subcap;
>> +
>> +	/* Enable L1 substates if CLKREQ# is properly connected */
>> +	if (rockchip->supports_clkreq && rockchip->data->mode == DW_PCIE_RC_TYPE ) {
>> +		rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY, PCIE_CLIENT_POWER_CON);
>> +		return;
>> +	}
>> +
>> +	/* Otherwise, pull down CLKREQ# and disable L1 PM substates */
>> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
>> +				 PCIE_CLIENT_POWER_CON);
>> +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
>> +	if (cap) {
>> +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
>> +		l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
>> +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
>> +			      PCI_L1SS_CAP_PCIPM_L1_2);
>> +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
>> +	}
>> +}
>> +
>>   static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>>   {
>>   	u32 cap, lnkcap;
>> @@ -264,6 +302,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>>   	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>>   					 rockchip);
>>   
>> +	rockchip_pcie_configure_l1sub(pci);
>>   	rockchip_pcie_enable_l0s(pci);
>>   
>>   	return 0;
>> @@ -301,6 +340,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>>   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>   	enum pci_barno bar;
>>   
>> +	rockchip_pcie_configure_l1sub(pci);
>>   	rockchip_pcie_enable_l0s(pci);
>>   	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
>>   
>> @@ -412,6 +452,9 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
>>   		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
>>   				     "failed to get reset lines\n");
>>   
>> +	rockchip->supports_clkreq = of_property_read_bool(pdev->dev.of_node,
>> +							  "supports-clkreq");
>> +
>>   	return 0;
>>   }
>>   
> 
> 


