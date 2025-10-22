Return-Path: <linux-pci+bounces-39032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DCFBFC8AF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 16:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8A60354510
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 14:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2B8331A59;
	Wed, 22 Oct 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="N4xlMxpq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3268.qiye.163.com (mail-m3268.qiye.163.com [220.197.32.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D352F323411
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143277; cv=none; b=Nb8au9nTQgUDS7ACiiWfxX0yFl/+WfM7iId+Q+HLj+XZZbZ/15+pf/CHobD/DTuNlPhZnvMec4jCd5jgvYp+lq9FkYVz+t5M7QhSGXYZsrwN9kZj61TqQ5LaRiLjwbzVU8zv9JufMLBQ4ii6kqLuPAHwS6Lm0F9C/j/7KrzTOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143277; c=relaxed/simple;
	bh=Oh4hyNq3/v9N56y5O9AEvUZQNxp9Ez36cc1CvMCUcBs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dC4unuiK/MqOYH8dfffYjVceGKd/Xf479/9jt23iUCrwtecRMBhfks9he83R6b9GMUX3Nrq7DmnopXMz2Ubneto/xAv+90PULwq2ibf6JaddxW5U0TzzmX8FBhAlb4qo31GtBQVGu6uJuD/zd/bvJ70Jue85tatfdG3Tu3SpX/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=N4xlMxpq; arc=none smtp.client-ip=220.197.32.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26d16730b;
	Wed, 22 Oct 2025 22:27:40 +0800 (GMT+08:00)
Message-ID: <988940fe-7cc3-4b24-b02d-f6e1d28145b7@rock-chips.com>
Date: Wed, 22 Oct 2025 22:27:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Heiko Stuebner <heiko@sntech.de>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dw-rockchip: Add L1sub support
To: Manivannan Sadhasivam <mani@kernel.org>
References: <1761132954-177344-1-git-send-email-shawn.lin@rock-chips.com>
 <lvixfsccgsodm4hfwxejofjnms5l7xhcskn7fgfdxryfs3ez7z@fh6uajlce6x6>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <lvixfsccgsodm4hfwxejofjnms5l7xhcskn7fgfdxryfs3ez7z@fh6uajlce6x6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a0c51865009cckunm9956190681cee7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hJTlZKHhkfShpMHUtDGB9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=N4xlMxpq/EpDvo4QgWAYvx+aIsxGRoP4lQNxubX/QvRu8gKGrW/XXFWbAg0bjQf/rAz9dl+PQ7UlT61KpHt1E5bAZU0v/C1qk1d6jw9pkXHW00bUWpU8gXav/IUjXvaw75/+gSZ1mxGgZmmRIAMp5j0FjY4NpisVnHdiwJSktk4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=9kDxZWzAAls1ouptzc4upW3mlcbCpwa90Qvybgb/170=;
	h=date:mime-version:subject:message-id:from;


在 2025/10/22 星期三 21:04, Manivannan Sadhasivam 写道:
> On Wed, Oct 22, 2025 at 07:35:53PM +0800, Shawn Lin wrote:
>> The driver should set app_clk_req_n(clkreq ready) of PCIE_CLIENT_POWER reg
>> to support L1sub. Otherwise, unset app_clk_req_n and pull down CLKREQ#.
>>
> 
> You can definitely improve the commit message on explaining why L1 PM Substates
> need to be disabled when the DT property is not present etc... Please refer the
> patch from Niklas.

Will do.

> 
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v2:
>> - drop of_pci_clkreq_presnt API
>> - drop dependency of Niklas's patch
>>
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 36 +++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index 3e2752c..18cd626 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -62,6 +62,12 @@
>>   /* Interrupt Mask Register Related to Miscellaneous Operation */
>>   #define PCIE_CLIENT_INTR_MASK_MISC	0x24
>>   
>> +/* Power Management Control Register */
>> +#define PCIE_CLIENT_POWER		0x2c
>> +#define  PCIE_CLKREQ_READY		0x10001
>> +#define  PCIE_CLKREQ_NOT_READY		0x10000
>> +#define  PCIE_CLKREQ_PULL_DOWN		0x30001000
> 
> Can you use bitfields instead of magic values?

Of course, will fix.

> 
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
>> @@ -200,6 +207,31 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
>>   	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
>>   }
>>   
>> +static void rockchip_pcie_enable_l1sub(struct dw_pcie *pci)
> 
> rockchip_pcie_configure_l1sub()? since this function is not just enabling L1ss.
> 
>> +{
>> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>> +	u32 cap, l1subcap;
>> +
>> +	/* Enable L1 substates if CLKREQ# is properly connected */
>> +	if (rockchip->supports_clkreq) {
>> +		/* Ready to have reference clock removed */
> 
> This comment is misleading (maybe wrong). The presence of this property implies
> that the link could enter L1 PM Substates. REFCLK removal only happens when the
> link is in L1ss.
> 
> So drop the comment.

Will drop.

> 
>> +		rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY, PCIE_CLIENT_POWER);
>> +		return;
>> +	}
>> +
>> +	/* Otherwise, pull down CLKREQ# and disable L1 substates */
> 
> "L1 PM Substates"
> 
>> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
>> +				 PCIE_CLIENT_POWER);
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
>> @@ -264,6 +296,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>>   	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>>   					 rockchip);
>>   
>> +	rockchip_pcie_enable_l1sub(pci);
>>   	rockchip_pcie_enable_l0s(pci);
>>   
>>   	return 0;
>> @@ -301,6 +334,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>>   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>   	enum pci_barno bar;
>>   
>> +	rockchip_pcie_enable_l1sub(pci);
> 
> I don't think you can decide the CLKREQ# routing on the EP side. The
> 'supports-clkreq' property is meant only for the RC afaik.

You are right, we cannot decide the CLKREQ# routing on the EP side. But
what I have in mind is we at least need to set pinmux to CLKREQ function
because on Rockchip platforms, the CLKREQ# of EP mode could also be used
as GPIO or other funcions if guys never need L1ss to be supported.


> 
>>   	rockchip_pcie_enable_l0s(pci);
>>   	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
>>   
>> @@ -412,6 +446,8 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
>>   		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
>>   				     "failed to get reset lines\n");
>>   
>> +	rockchip->supports_clkreq = of_property_read_bool(pdev->dev.of_node, "supports-clkreq");
> 
> Bjorn still likes to preserve 80 column width for most of the cases.

Ok, will fix it.

> 
> - Mani
> 


