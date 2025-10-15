Return-Path: <linux-pci+bounces-38217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2F1BDE9C7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8963AE7B1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B4F3277AA;
	Wed, 15 Oct 2025 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="MnJown0D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49213.qiye.163.com (mail-m49213.qiye.163.com [45.254.49.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC6C213E6D;
	Wed, 15 Oct 2025 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533255; cv=none; b=Ze0NWiO0erOSc+8+qP7FU006Q9/FPZTa/Qg6VPxw7bHZXMtk2uTuBl9BBOeIBk9AFH/SWtQfDq2IfEIhXluwfehLVXQPPor7NuRHftEsiS0b46PZGT7Wf/kzXlgTp+w5icmQ5+dNwHJyvW30lGQmC4Z8WUqQ9dQGM2GT02l6vC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533255; c=relaxed/simple;
	bh=hkJE8sXFd8jfjci/WrMDy5NPoTLcGcP5wIk4WRBxH3I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z9MgfpOkiAwhhGez9nVzdjs/Nutiv6QTHKWoUD4uWUW2O/8W2YCm5OiMdZkmOj30403HOcJzEwO+kCBHH3rTIcgnw9Jai3RpHry+XoE4NP+8i4nAbkFIZV9WxIkyQV8hkR4Nv5k4ULrw9PSfr83sVVm2pz1LyPwWszFfdmL6k+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=MnJown0D; arc=none smtp.client-ip=45.254.49.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2603e3c44;
	Wed, 15 Oct 2025 21:00:42 +0800 (GMT+08:00)
Message-ID: <7df0bf91-8ab1-4e76-83fa-841a4059c634@rock-chips.com>
Date: Wed, 15 Oct 2025 21:00:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <helgaas@kernel.org>,
 manivannan.sadhasivam@oss.qualcomm.com, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 "David E. Box" <david.e.box@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Chia-Lin Kao <acelan.kao@canonical.com>, Dragan Simic <dsimic@manjaro.org>,
 linux-rockchip@lists.infradead.org, regressions@lists.linux.dev,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
References: <22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com>
 <20251014184905.GA896847@bhelgaas>
 <5ivvb3wctn65obgqvnajpxzifhndza65rsoiqgracfxl7iiimt@oym345d723o2>
 <823262AB21C8D981+8c1b9d50-5897-432b-972e-b7bb25746ba5@radxa.com>
 <7ugvxl3g5szxhc5ebxnlfllp46lhprjvcg5xp75mobsa44c6jv@h2j3dvm5a4lq>
 <a9ca7843-b780-45aa-9f62-3f443ae06eee@rock-chips.com>
 <aO9tWjgHnkATroNa@ryzen>
 <ud72uxkobylkwy5q5gtgoyzf24ewm7mveszfxr3o7tortwrvw5@kc3pfjr3dtaj>
 <aO-Q3QsxPBXbFieG@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aO-Q3QsxPBXbFieG@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99e7f5640409cckunm9ee5080b67e11f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpPSVZJGUpNSENOGUtLSk5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=MnJown0DuqdL6rBGsWoMzb7QGazNNRXYCSyjsDzS1g/MQFdtuSaV6b2JCV1PiL946uSdg0z4vo++UMvUhTssThFFtzWld2BrJCljFwP5hZ8yBbD0MFVrub/uzCJoIOZOe+1nlsSgAkHQU63JObM0WQWR9EtNKBQDXN+jjYi404Q=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=taV+QKqHlZL9re707Lmw1ucCaaR0gNqdOHHbY6rf7MY=;
	h=date:mime-version:subject:message-id:from;


在 2025/10/15 星期三 20:17, Niklas Cassel 写道:
> On Wed, Oct 15, 2025 at 04:03:53PM +0530, Manivannan Sadhasivam wrote:
>> On Wed, Oct 15, 2025 at 11:46:02AM +0200, Niklas Cassel wrote:
>>> Hello Shawn,
>>>
>>> On Wed, Oct 15, 2025 at 05:11:39PM +0800, Shawn Lin wrote:
>>>>>
>>>>> Thanks! Could you please try the below diff with f3ac2ff14834 applied?
>>>>>
>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>> index 214ed060ca1b..0069d06c282d 100644
>>>>> --- a/drivers/pci/quirks.c
>>>>> +++ b/drivers/pci/quirks.c
>>>>> @@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>>>>     */
>>>>>    DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>>>>>
>>>>> +
>>>>> +static void quirk_disable_aspm_all(struct pci_dev *dev)
>>>>> +{
>>>>> +       pci_info(dev, "Disabling ASPM\n");
>>>>> +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
>>>>> +}
>>>>> +
>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ROCKCHIP, 0x3588, quirk_disable_aspm_all);
>>>>
>>>> That's not true from my POV. Rockchip platform supports all ASPM policy
>>>> after mass production verification. I also verified current upstream
>>>> code this morning with RK3588-EVB and can check L0s/L1/L1ss work fine.
>>>>
>>>> The log and lspci output could be found here:
>>>> https://pastebin.com/qizeYED7
>>>>
>>>> Moreover, I disscussed this issue with FUKAUMI today off-list and his
>>>> board seems to work when only disable L1ss by patching:
>>>>
>>>> --- a/drivers/pci/pcie/aspm.c
>>>> +++ b/drivers/pci/pcie/aspm.c
>>>> @@ -813,7 +813,7 @@ static void pcie_aspm_override_default_link_state(struct
>>>> pcie_link_state *link)
>>>>
>>>>          /* For devicetree platforms, enable all ASPM states by default */
>>>>          if (of_have_populated_dt()) {
>>>> -               link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
>>>> +               link->aspm_default = PCIE_LINK_STATE_L0S |
>>>> PCIE_LINK_STATE_L1;
>>>>                  override = link->aspm_default & ~link->aspm_enabled;
>>>>                  if (override)
>>>>                          pci_info(pdev, "ASPM: DT platform,
>>>>
>>>>
>>>> So, is there a proper way to just disable this feature for spec boards
>>>> instead of this Soc?
>>>
>>> This fix seems do the trick, without needing to patch common code (aspm.c):
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> index 3e2752c7dd09..f5e1aaa97719 100644
>>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>>> @@ -200,6 +200,19 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
>>>   	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
>>>   }
>>>   
>>> +static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
>>> +{
>>> +	u32 cap, l1subcap;
>>> +
>>> +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
>>> +	if (cap) {
>>> +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
>>> +		l1subcap &= ~(PCI_L1SS_CAP_ASPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_L1_PM_SS);
>>> +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
>>> +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
>>> +	}
>>> +}
>>> +
>>>   static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>>>   {
>>>   	u32 cap, lnkcap;
>>> @@ -264,6 +277,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>>>   	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>>>   					rockchip);
>>>   
>>> +	rockchip_pcie_disable_l1sub(pci);

For now, this is a acceptable option if default ASPM policy enable L1ss
w/o checking if the HW could supports it... But how about adding
supports-clkreq stuff to upstream host driver directly? That would help
folks enable L1ss if the HW is ready and they just need adding property
to the DT.

>>>   	rockchip_pcie_enable_l0s(pci);
>>>   
>>>   	return 0;
>>> @@ -301,6 +315,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>>>   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>>   	enum pci_barno bar;
>>>   
>>> +	rockchip_pcie_disable_l1sub(pci);
>>>   	rockchip_pcie_enable_l0s(pci);
>>>   	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
>>>
>>
>> But this patch removes the L1SS CAP for all boards, isn't it?
> 
> Yes, all boards supported by pcie-dw-rockchip.c, which matches what their
> downstream driver does.
> 
> (Their downstream driver disables L1 substates for all boards that have
> not defined 'supports-clkreq', and a grep through their downstream tree,
> for all their all their different branches, shows that not a since rockchip
> DTS has this property specified.)

The L1ss support is quite strict and need several steps to check, so we
didn't add supports-clkreq for them unless the HW is ready to go...

For adding supports of L1ss,
[1] the HW should support CLKREQ#, expecially for PCIe3.0 case on 
Rockchip SoCs , since both  CLKREQ# of RC and EP should connect to the
100MHz crystal generator's enable pin, as L1.2 need to disable refclk as
well. If the enable pin is high active, the HW even need a invertor....

[2] define proper clkreq iomux to pinctrl of pcie node
[3] make sure the devices work fine with L1ss.(It's hard to check the 
slot case with random devices in the wild )
[4] add supports-clkreq to the DT and enable
CONFIG_PCIEASPM_POWER_SUPERSAVE


> 
> So, let me submit a real patch with the above.
> 
> 
> Kind regards,
> Niklas
> 


