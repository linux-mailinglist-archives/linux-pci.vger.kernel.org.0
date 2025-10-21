Return-Path: <linux-pci+bounces-38864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E89C4BF550E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 10:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C90B54E3615
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 08:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C9331AF21;
	Tue, 21 Oct 2025 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="PJcoCCMP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731119.qiye.163.com (mail-m19731119.qiye.163.com [220.197.31.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EC431AF1F
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036186; cv=none; b=dFKnOZ0poQr2q9tO5oKuupF7wmL0bQONXwpLfdx9BlWS9juIgs6+CHYjhcFQ9Hkw6b0hoUkqxmMEH28RzMrdkoBRg8KrbfkfRbtrs8j4IwZdD6FI6FtbaTt/qRD4TOjyLlDf3x/mlYBK7p4Cs7wCj4JBucrVSPOT1TDZIcvazhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036186; c=relaxed/simple;
	bh=ix6QbMjTokwCN0tMBBg5yEl4QAl4fMPbFZ+n7SS2dDQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JM+DyWnNa+r9723ZI7K5Feb9E0OoYSgqUxW3zb931+qhzjysXHhb15oB0Y2dUUGXqUoWq6hQbiLrhpge2WkFvBL9vAib2iYJv8GKUxu+qJP7qxYA9T/g0AbZot2PlIMyYIT7IV9LjoWDeJPWi3Waf6WV9vZj0ZsHuB18AbA4rR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=PJcoCCMP; arc=none smtp.client-ip=220.197.31.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26a41c81c;
	Tue, 21 Oct 2025 16:42:54 +0800 (GMT+08:00)
Message-ID: <162e1af2-7de3-4aed-93d1-fa7120254e69@rock-chips.com>
Date: Tue, 21 Oct 2025 16:42:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Thierry Reding <thierry.reding@gmail.com>,
 linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>,
 linux-pci@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/4] PCI: dw-rockchip: Add L1sub support
To: Hans Zhang <hans.zhang@cixtech.com>
References: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
 <1761032907-154829-4-git-send-email-shawn.lin@rock-chips.com>
 <3f90b0f9-06bb-44d3-97a3-a13ced9b1c3a@cixtech.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <3f90b0f9-06bb-44d3-97a3-a13ced9b1c3a@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a05ef832609cckunm01e5e79b65f352
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hDS1YaQhhKThodGBoZT0lWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PJcoCCMPvgW2WvvdGXLHF+H9UGDMHJ+QaLFbSaCPjowJFgQ2I1eIo+wgXaLBmapTsGacvsRoEUXrtkenqRT0ar3QrF2iuGtFUEPe6JksOTK7lW153ILwePQ/Oxr3RyaoEy0565ZFUiZG7yqtBYVuDFNdvwCCPKc32jwibKNGdzQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=sJzjhfTYU0Au/zOdVEyMsueBh9VAFR9q1ut8Hr7CQCM=;
	h=date:mime-version:subject:message-id:from;


在 2025/10/21 星期二 16:01, Hans Zhang 写道:
> 
> 
> On 10/21/2025 3:48 PM, Shawn Lin wrote:
>> EXTERNAL EMAIL
>>
>> The driver should set app_clk_req_n(clkreq ready) of PCIE_CLIENT_POWER 
>> reg
>> to support L1sub. Otherwise, unset app_clk_req_n and pull down CLKREQ#.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 31 ++++++++++++++-----
>>   1 file changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/ 
>> pci/controller/dwc/pcie-dw-rockchip.c
>> index 87dd2dd188b4..8a52ff73ec46 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -62,6 +62,12 @@
>>   /* Interrupt Mask Register Related to Miscellaneous Operation */
>>   #define PCIE_CLIENT_INTR_MASK_MISC     0x24
>>
>> +/* Power Management Control Register */
>> +#define PCIE_CLIENT_POWER              0x2c
>> +#define  PCIE_CLKREQ_READY             0x10001
>> +#define  PCIE_CLKREQ_NOT_READY         0x10000
>> +#define  PCIE_CLKREQ_PULL_DOWN         0x30001000
>> +
>>   /* Hot Reset Control Register */
>>   #define PCIE_CLIENT_HOT_RESET_CTRL     0x180
>>   #define  PCIE_LTSSM_APP_DLY2_EN                BIT(1)
>> @@ -84,6 +90,7 @@ struct rockchip_pcie {
>>          struct gpio_desc *rst_gpio;
>>          struct irq_domain *irq_domain;
>>          const struct rockchip_pcie_of_data *data;
>> +       bool supports_clkreq;
>>   };
>>
>>   struct rockchip_pcie_of_data {
>> @@ -199,15 +206,21 @@ static bool rockchip_pcie_link_up(struct dw_pcie 
>> *pci)
>>          return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
>>   }
>>
>> -/*
>> - * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for 
>> the steps
>> - * needed to support L1 substates. Currently, not a single rockchip 
>> platform
>> - * performs these steps, so disable L1 substates until there is 
>> proper support.
>> - */
>> -static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
> 
> Hi,
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/? 
> h=controller/dw-rockchip&id=40331c63e7901a2cc75ce6b5d24d50601efb833d
> 
> Mani has already placed this part in the above branch. Can it be removed?
> 

I think it's better to apply the changes on top of Niklas's commit 
rather than removing it, out of respect for Niklas's credit.


> Best regards,
> Hans
> 
> 
>> +static void rockchip_pcie_enable_l1sub(struct dw_pcie *pci)
>>   {
>> +       struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>>          u32 cap, l1subcap;
>>
>> +       /* Enable L1 substates if CLKREQ# is properly connected */
>> +       if (rockchip->supports_clkreq) {
>> +               /* Ready to have reference clock removed */
>> +               rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY, 
>> PCIE_CLIENT_POWER);
>> +               return;
>> +       }
>> +
>> +       /* Otherwise, pull down CLKREQ# and disable L1 substates */
>> +       rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_PULL_DOWN | 
>> PCIE_CLKREQ_NOT_READY,
>> +                                PCIE_CLIENT_POWER);
>>          cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
>>          if (cap) {
>>                  l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
>> @@ -282,7 +295,7 @@ static int rockchip_pcie_host_init(struct 
>> dw_pcie_rp *pp)
>>          irq_set_chained_handler_and_data(irq, 
>> rockchip_pcie_intx_handler,
>>                                           rockchip);
>>
>> -       rockchip_pcie_disable_l1sub(pci);
>> +       rockchip_pcie_enable_l1sub(pci);
>>          rockchip_pcie_enable_l0s(pci);
>>
>>          return 0;
>> @@ -320,7 +333,7 @@ static void rockchip_pcie_ep_init(struct 
>> dw_pcie_ep *ep)
>>          struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>          enum pci_barno bar;
>>
>> -       rockchip_pcie_disable_l1sub(pci);
>> +       rockchip_pcie_enable_l1sub(pci);
>>          rockchip_pcie_enable_l0s(pci);
>>          rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
>>
>> @@ -432,6 +445,8 @@ static int rockchip_pcie_resource_get(struct 
>> platform_device *pdev,
>>                  return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
>>                                       "failed to get reset lines\n");
>>
>> +       rockchip->supports_clkreq = of_pci_clkreq_present(pdev- 
>> >dev.of_node);
>> +
>>          return 0;
>>   }
>>
>> -- 
>> 2.43.0
>>
>>
> 
> 


