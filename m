Return-Path: <linux-pci+bounces-39211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C34AC03F9D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 02:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB561A672BD
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 00:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6530578F4B;
	Fri, 24 Oct 2025 00:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="X0OPoN5P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3274.qiye.163.com (mail-m3274.qiye.163.com [220.197.32.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14C13D503
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761266928; cv=none; b=Gnp4i7z0M3E8q0Ko4xiWeFeaU3TAfVu1IFOJfk3NWQ42tJEcpJjxNkSpfOPbbNptLuYS77sKHVDwtQP6fe1UF4ORgtUjww/mUs9e7062BptelOLGQNo1fDSeA+yYIIbhceviypeacsTD/a+5dXDxv1qF6x/iGbN5JAcT9T68QxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761266928; c=relaxed/simple;
	bh=U7I7UmT8ZZaqIDMvBiQ2Kas2wOY+X2tZvy3ILwsnly8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tcOy+gcAN5CxityT9Oya6vs/J3TI7vFfz9hTnpOb0Mh5Wxhv6ybbJlh+bpOdfQVMMoCe6Xu4HfAP4//bDeV0Cg3bUuFe+3D2Nhf+i5/EkATIWV8aTtnAFh5QAfkDK77gmLLwvaNCW30VKy7JML+e7AMB9jurXCc6//kM+Xuqmi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=X0OPoN5P; arc=none smtp.client-ip=220.197.32.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26fea3291;
	Fri, 24 Oct 2025 08:43:32 +0800 (GMT+08:00)
Message-ID: <de9371a6-654c-4360-a34d-7f8a20848a6a@rock-chips.com>
Date: Fri, 24 Oct 2025 08:43:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Heiko Stuebner <heiko@sntech.de>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: dw-rockchip: Configure L1sub support
To: Frank Li <Frank.li@nxp.com>
References: <1761187883-150120-1-git-send-email-shawn.lin@rock-chips.com>
 <aPpN2NX7IkAEU9Rh@lizhi-Precision-Tower-5810>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aPpN2NX7IkAEU9Rh@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a13abb81609cckunma2207a01a01b22
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxkfS1YdQh8eGB1PTRpNTENWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=X0OPoN5P7MZoU2nmEafBC9Nd6tMwZRE7kH2yWY13tjy7Px4axFpibPM7aOtSycN0NrgWjGAVCxpH5tZYgEyELAOKpbFINza9RZph0Y5FoSZ/NJUDvSRIlnckmWh+k+omA//s9U+OGNhgjk7qXjVVnQBudIZVy4lsjE0YVLyJQwM=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=vLdASWS6hMDq9hfJAMq1F7hWQl1L7+yAq0gnF7xM+W4=;
	h=date:mime-version:subject:message-id:from;

在 2025/10/23 星期四 23:46, Frank Li 写道:
> On Thu, Oct 23, 2025 at 10:51:22AM +0800, Shawn Lin wrote:
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
> 
> Looks like you force pull down clkreq should be enough, needn't disable
> L1SS. when RC force clkreq is low, Ref CLK always on even if L1SS enabled.
> 
> Of course it depend on hardware implementation, But I think FULL_DOWN have
> high priority to force clkreq to low then PCI_L1SS control.
> 

Hi Frank,

Thanks for your review. TBH, the basic idea here I think is not to
advertise a capability if the HW as whole hasn't been well prepared to
support it yet. So I'd prefer to keep it as-is.

> Frank
> 
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
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 


