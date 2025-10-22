Return-Path: <linux-pci+bounces-39007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E17BFBD44
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 14:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC2440171E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1372B285C8B;
	Wed, 22 Oct 2025 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LaObT5Qv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m1973173.qiye.163.com (mail-m1973173.qiye.163.com [220.197.31.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF37A3081AD
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135776; cv=none; b=jc82eHQs7UOiG/cxBzyHQalwJUMBeDJCnPANl4pABHHg5h4uFUqdt6rxNIt7eyf8ci4H21PmUdYlKNTeCifGOM0iUrr9vu5aWbZsr8mfQZsxYw4B7oI7iLAuMAY7Svt30PQrUp3Uv1qh10pve7zn0u5XD8Vd7sB1LqO7ncWzN/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135776; c=relaxed/simple;
	bh=bireERmYAoQqB2e9neARibMCYj13LfA4C+nUd2jznMw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t4vhIiF8qr/TfG4olatf+xwLWZc9YifHaovEkwmEEFnisMMh5nJSziCXlGDa3qhjhfaW7nsvlmUD/CLz+xOZgdRJHct0hQXZ0zDs2nxBFJm52R+ZCVVlnno+n0DvvltMbA9oQ3W1BUpPg+DIhYjjVT+nepw47fBb7LI/qe5Mkqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LaObT5Qv; arc=none smtp.client-ip=220.197.31.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26ceeb4fb;
	Wed, 22 Oct 2025 20:22:41 +0800 (GMT+08:00)
Message-ID: <ffe10dbd-1297-45af-86d5-42023820f2c7@rock-chips.com>
Date: Wed, 22 Oct 2025 20:22:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
 Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dw-rockchip: Add L1sub support
To: Hans Zhang <hans.zhang@cixtech.com>, Heiko Stuebner <heiko@sntech.de>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <1761132954-177344-1-git-send-email-shawn.lin@rock-chips.com>
 <8b569a35-3913-4dfe-a586-7ec9669edbc1@cixtech.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <8b569a35-3913-4dfe-a586-7ec9669edbc1@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a0bdf186f09cckunmd6a4b529805a7b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUIYGlZDHh8fTE8YH0wfSBhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LaObT5QvNYHbRnvsZQ33p9VT1XHFBoUSnvmsfiT6GhqIjsld1Pde7ve/ZegoBfgylNZRsY1C+xY2Izt7X0HkxEL7nlIaYLZ9xYJtgtHwS9NQoFMbkKoeM7B72YYNrJOrX9hFPUGV3e1UBQq6ZVLGC62VUF6fp9i5D1kgFkMOw40=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=W0dJsJnfhYqZmHn/6VAKPHTyM9nOiqGuzrIQ/d0D4gk=;
	h=date:mime-version:subject:message-id:from;

在 2025/10/22 星期三 19:52, Hans Zhang 写道:
> 
> 
> On 10/22/2025 7:35 PM, Shawn Lin wrote:
>> EXTERNAL EMAIL
>>
>> The driver should set app_clk_req_n(clkreq ready) of PCIE_CLIENT_POWER 
>> reg
>> to support L1sub. Otherwise, unset app_clk_req_n and pull down CLKREQ#.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v2:
>> - drop of_pci_clkreq_presnt API
>> - drop dependency of Niklas's patch
>>
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 36 +++++++++++++++++ 
>> ++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/ 
>> pci/controller/dwc/pcie-dw-rockchip.c
>> index 3e2752c..18cd626 100644
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
>> @@ -85,6 +91,7 @@ struct rockchip_pcie {
>>          struct regulator *vpcie3v3;
>>          struct irq_domain *irq_domain;
>>          const struct rockchip_pcie_of_data *data;
>> +       bool supports_clkreq;
>>   };
>>
>>   struct rockchip_pcie_of_data {
>> @@ -200,6 +207,31 @@ static bool rockchip_pcie_link_up(struct dw_pcie 
>> *pci)
>>          return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
>>   }
>>
>> +static void rockchip_pcie_enable_l1sub(struct dw_pcie *pci)
>> +{
>> +       struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>> +       u32 cap, l1subcap;
>> +
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
>> +       cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
>> +       if (cap) {
>> +               l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
>> +               l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | 
>> PCI_L1SS_CAP_ASPM_L1_1 |
>> +                             PCI_L1SS_CAP_ASPM_L1_2 | 
>> PCI_L1SS_CAP_PCIPM_L1_1 |
>> +                             PCI_L1SS_CAP_PCIPM_L1_2);
>> +               dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
>> +       }
>> +}
>> +
>>   static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>>   {
>>          u32 cap, lnkcap;
>> @@ -264,6 +296,7 @@ static int rockchip_pcie_host_init(struct 
>> dw_pcie_rp *pp)
>>          irq_set_chained_handler_and_data(irq, 
>> rockchip_pcie_intx_handler,
>>                                           rockchip);
>>
>> +       rockchip_pcie_enable_l1sub(pci);
>>          rockchip_pcie_enable_l0s(pci);
>>
>>          return 0;
>> @@ -301,6 +334,7 @@ static void rockchip_pcie_ep_init(struct 
>> dw_pcie_ep *ep)
>>          struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>          enum pci_barno bar;
>>
>> +       rockchip_pcie_enable_l1sub(pci);
>>          rockchip_pcie_enable_l0s(pci);
>>          rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
>>
>> @@ -412,6 +446,8 @@ static int rockchip_pcie_resource_get(struct 
>> platform_device *pdev,
>>                  return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
>>                                       "failed to get reset lines\n");
>>
>> +       rockchip->supports_clkreq = of_property_read_bool(pdev- 
>> >dev.of_node, "supports-clkreq");
> 
> Hi Shawn,
> 
> This line exceeds 80 characters. Can it be like this?
> 

Thanks for the reivew.

I think we've been drop this rule[1] for quite a long time :)

[1]https://www.phoronix.com/news/Linux-Kernel-Deprecates-80-Col

> rockchip->supports_clkreq = of_property_read_bool(pdev->dev.of_node,
>                            "supports-clkreq");
> 
> I have no doubts about the rest.
> 
> Reviewed-by: Hans Zhang <hans.zhang@cixtech.com>
> 
> 
> Best regards,
> Hans
> 
>> +
>>          return 0;
>>   }
>>
>> -- 
>> 2.7.4
>>
>>
> 
> 


