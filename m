Return-Path: <linux-pci+bounces-41708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA427C71A7A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 02:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 778A329527
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 01:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FB21EA7DB;
	Thu, 20 Nov 2025 01:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Hn1fLys4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731106.qiye.163.com (mail-m19731106.qiye.163.com [220.197.31.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6519B5B1;
	Thu, 20 Nov 2025 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600948; cv=none; b=sY4ghnPGA3B61XJwQ07FuHCPREOoKlKdGOvsfAtdg2iCLi3DJn3MPoxPFFoO8Bk85iuyRChtAN6F+8SomqonV1ptxqME/YDVJtsDN8F9xIGGBwrlaemu1INKgT0M/ozoXUuKGgZMoPD6Gi31Usg50gUV71R+n6HxnLblYgc3jYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600948; c=relaxed/simple;
	bh=xapHrfa+vRD5FcSyfmUtaomgjwEjA/S9EzHJdWFgNUY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uGaeRRnD0lIjDZ/Sr3Jth8cDuOvFSYzmGEjhHedTHTjYMPZcAnjluLKbjtTEt0XvFIRYFvo6leD/AQ55TEIfq/9ESFB5LtM/f/K98hPtBktSMnaHtFCfYrEJVsu+JbubvLtEvfxuezVBoHRy9YVoGohTW0bPlmuH+ORkEIVWka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Hn1fLys4; arc=none smtp.client-ip=220.197.31.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a336e021;
	Thu, 20 Nov 2025 08:53:41 +0800 (GMT+08:00)
Message-ID: <7608cf17-75cf-4b7b-a326-f3233771c662@rock-chips.com>
Date: Thu, 20 Nov 2025 08:53:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Xue <xxm@rock-chips.com>,
 Damien Le Moal <dlemoal@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Diederik de Haas <diederik@cknow-tech.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Hans Zhang <hans.zhang@cixtech.com>,
 linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@pengutronix.de, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/4] PCI: dwc: Advertise L1 PM Substates only if driver
 requests it
To: Frank Li <Frank.li@nxp.com>, Niklas Cassel <cassel@kernel.org>
References: <20251118214312.2598220-1-helgaas@kernel.org>
 <20251118214312.2598220-2-helgaas@kernel.org>
 <aRz0ak6onKzZs2lY@lizhi-Precision-Tower-5810> <aR2lOZDBEdGVd9On@ryzen>
 <aR3pEaJ4oTagaKU8@lizhi-Precision-Tower-5810>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aR3pEaJ4oTagaKU8@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a9ec0b88a09cckunm203edec1101ef1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk5LGVYZGUJLThgdHxoZTk5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=Hn1fLys4wPcT5stgZE2bGvrVp1by1kBMj13HZqwZ6zolCmKp7NhY2RCg3eKrnAWsgeYsZWXwROpuqiqvk500yO25B6GIYHMsppLfJvKVRkbdRM1N9mqOgbtBAsW54bhHiDOCvPRIAndqNPXGa5j4AHqUOZcSHrlcp1WLSl2yiCQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=+IXChYv063/iR7iqcfC8kDbpygHTsdaRPTTsJ9OXMv0=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/19 星期三 23:58, Frank Li 写道:
> On Wed, Nov 19, 2025 at 12:08:41PM +0100, Niklas Cassel wrote:
>> On Tue, Nov 18, 2025 at 05:34:18PM -0500, Frank Li wrote:
>>> On Tue, Nov 18, 2025 at 03:42:15PM -0600, Bjorn Helgaas wrote:
>>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>>
>>>> L1 PM Substates require the CLKREQ# signal and may also require
>>>> device-specific support.  If CLKREQ# is not supported or driver support is
>>>> lacking, enabling L1.1 or L1.2 may cause errors when accessing devices,
>>>> e.g.,
>>>>
>>>>    nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
>>>>
>>>> If the kernel is built with CONFIG_PCIEASPM_POWER_SUPERSAVE=y or users
>>>> enable L1.x via sysfs, users may trip over these errors even if L1
>>>> Substates haven't been enabled by firmware or the driver.
>>>>
>>>> To prevent such errors, disable advertising the L1 PM Substates unless the
>>>> driver sets "dw_pcie.l1ss_support" to indicate that it knows CLKREQ# is
>>>> present and any device-specific configuration has been done.
>>>>
>>>> Set "dw_pcie.l1ss_support" in tegra194 (if DT includes the
>>>> "supports-clkreq' property) and qcom (for cfg_2_7_0, cfg_1_9_0, cfg_1_34_0,
>>>> and cfg_sc8280xp controllers) so they can continue to use L1 Substates.
>>>>
>>>> Based on Niklas's patch:
>>>> https://patch.msgid.link/20251017163252.598812-2-cassel@kernel.org
>>>>
>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> ---
>>>>   .../pci/controller/dwc/pcie-designware-ep.c   |  2 ++
>>>>   .../pci/controller/dwc/pcie-designware-host.c |  2 ++
>>>>   drivers/pci/controller/dwc/pcie-designware.c  | 24 +++++++++++++++++++
>>>>   drivers/pci/controller/dwc/pcie-designware.h  |  2 ++
>>>>   drivers/pci/controller/dwc/pcie-qcom.c        |  2 ++
>>>>   drivers/pci/controller/dwc/pcie-tegra194.c    |  3 +++
>>>>   6 files changed, 35 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>> index 7f2112c2fb21..ad6c0fd67a65 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>> @@ -966,6 +966,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>>>>   	if (ep->ops->init)
>>>>   		ep->ops->init(ep);
>>>>
>>>> +	dw_pcie_hide_unsupported_l1ss(pci);
>>>> +
>>>
>>> And, I don't think EP need clean L1SS CAP flags. If EP don't support L1SS,
>>> it should be force pull down #clkreq.
>>
>> I think the problem is that we cannot force pull down CLKREQ# in a generic
>> DWC function. That would have to be done in glue driver specific callbacks.
>>
>> Bjorn, perhaps we should simply drop the dw_pcie_hide_unsupported_l1ss()
>> call from dw_pcie_ep_init_registers(), and consider hiding L1ss for EPs to
>> be out of scope for this series.
> 
> 
> Agree, we should consider EP later. When work at EP mode, #clkreq default
> it is 0. RC should not turn L1SS if RC don't support. If RC side support,
> it should be fine by turing on EP's L1SS because hardware already support
> it.

I agree to drop it from dw_pcie_ep_init_registers, and queue it up for
6.19.

Don't get me wrong, but I just need clearly speak out the thought: I
think the idea behind is something like quirk that a variant controller
works on EP mode claiming L1ss available through *CAP* regs but actually
it doesn't. This is nothing related to RC side, even if it pulls down
CLKREQ# to reject negotiation for L1ss, it still looks wrong from lspci
view. So of course, we could leave it to the glue driver to explictly
eliminate L1SS capability later. If they want, just export
dw_pcie_hide_unsupported_l1ss() the call it.

> 
> Frank
> 
>>
>> That way, we could still queue this series up for 6.19.
>>
>> Thoughts from everyone?
>>
>>
>>
>> Kind regards,
>> Niklas
> 


