Return-Path: <linux-pci+bounces-44085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ADECF74EC
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 09:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4336130057D4
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 08:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6236B1D5CC6;
	Tue,  6 Jan 2026 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="dy8CAjWd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49246.qiye.163.com (mail-m49246.qiye.163.com [45.254.49.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5DCAD24
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767688013; cv=none; b=kzKgqzoYwDLi4agFX+s4/97zeVHKAfp8ZzZ6gPw1Hyq/bcONaXH7b8KGjQeVKFBxGXEdWTpY9YvMqv662wkFM3Oxana76i9Qgt1YnM1spBS3vb0f7XkzJZ0q+Aovt9IL5gEo/U0wXmeu0HMdiXKGCBcVd0qhC8lrWfe3Km+Ik/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767688013; c=relaxed/simple;
	bh=jMuyBsLDoD2oKU8a5Ool8KImMLbZJO2Y/hZEW41SEj8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xb4hO3cdnwCrhJHPCXCCWUBdmI5pGjnzroMQiQjK466zqQLNP0gO16D/JEC1AnSTVd85IvSCAUtMbFXQv9tmEPC1OMGCAqly/FfPmvxfToRwLjwMoz9GOc+Pq7timFymi3usZXbf6GT1wdvHeePy1GsLRxrd4Jc+dv+Ie7/lxK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=dy8CAjWd; arc=none smtp.client-ip=45.254.49.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9aa005e;
	Tue, 6 Jan 2026 09:37:01 +0800 (GMT+08:00)
Message-ID: <1ed9d1a4-bd51-408a-9399-f81ac1ea4ba9@rock-chips.com>
Date: Tue, 6 Jan 2026 09:37:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Damien Le Moal <dlemoal@kernel.org>, Koichiro Den <den@valinux.co.jp>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
References: <20251210071358.2267494-2-cassel@kernel.org>
 <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
 <s5mbvhnummcegksauc7kyb2442ao27dwc63gyryetuvxojnxfj@a67nopel52tx>
 <aUknSzSpNxLeEN5o@ryzen>
 <3b34aa66-a418-4f6b-930a-0728d87d79b6@oss.qualcomm.com>
 <aUlA7y95SUC-QA4T@ryzen>
 <a24a5d8b-5818-4e11-bc09-47090de164c7@rock-chips.com>
 <63321b7d-74a7-448f-ab20-08cc771beb5d@oss.qualcomm.com>
 <424133b7-bd6b-4602-96ea-4413ce4f985d@rock-chips.com>
 <aVubPUphGP59bH09@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aVubPUphGP59bH09@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b90f3464c09cckunm81268efb792a80
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkwfHVYYTh5CGk5JHkMeQkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dy8CAjWd6v56qJC68yiNUUClE0N6jGHg4AIo3Mhw1Gv8FeRkYysw5DZisGarUicVZs/Wh5PfXnwsiab4XI2ttmAJwFj5jlBKNusg+wZDDqXCvCxd3mcy3BUkHpDqUHXwDqOiVKxvcgRtXqww/BWx/0w0Z0jtSP8IdLb2ROVKA4U=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=vpMqSgyqi30rX4JlOAApsUNToyufnl5AYHy3hORa9Xo=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/05 星期一 19:06, Niklas Cassel 写道:
> Hello all,
> 
> On Tue, Dec 23, 2025 at 02:23:39PM +0800, Shawn Lin wrote:
>>>> I checked the IP configurtion parameters for RK3588 DM controller for
>>>> sure, it sets MSIX_TABLE_EN=1.
>>>>
>>>> Looking into dw_pcie_ep_raise_msix_irq_doorbell(), it doesn't seem to
>>>> match the dwc databook. No matter for non-AXI mode or AXI access mode,
>>>> shouldn't we need to generate a MSI-X table RAM with data/address/
>>>> vector/TC in advanced? Am I missing anything because I didn't look
>>> The MSI-X table will updated automatically when host updates the MSI-X
>>> table, when MSI-X is enabled
>>> by host.
>>
>> Thanks for these details.
>> I re-read the databook, especially "Figure 3-49 iMSIX-TX: MSIX
>> Transmit ". Yes, it's updated automatically when host write access
>> it, which either comes from RX or local DBI(for debug purpose).
> 
> With the help of Shawn, I managed to get dw_pcie_ep_raise_msix_irq_doorbell()
> to work on RK3588.
> 
> By default, on RK3588, the MSI-X table is stored in BAR4 at offset 0x4000.
> 
> There seems to be a limitation that the iMSIX-TX doorbell feature only
> works when the MSI-X table is stored in this default location.
> 
> 

I believe the limitation comes from IP, the databook implies this:
"When you enable this feature (MSIX_TABLE_EN =1), the upstream
controller implements the logic and *RAM required* to generate MSI-X
requests."

Using non-AXI mode(MSIX_DOORBELL_OFF), MSI-X FSM need fetch MSI-X table
stored in RAM. The IP configuration could decide which type of RAM is
used by setting CX_RAM_AT_TOP_IF value. And it's also IP integration
decision to make sure RAM accessable by which BAR. That being said, BAR0
could store the table to a system memory address(DRAM), not to the RAM.


> As you know, by default, pci-epf-test stores the MSI-X table in BAR0,
> after the registers defined by pci-epf-test itself.
> This works fine when triggering a MSI-X using dw_pcie_ep_raise_msix_irq(),
> but does not work when using dw_pcie_ep_raise_msix_irq_doorbell() (at least
> not or RK3588).
> 
> Additionally, on RK3588, at offset 0x0 in BAR4, the eDMA registers are
> mapped, so we cannot simply use BAR4 as test_reg_bar, as that would conflict
> with the registers defined by pci-epf-test-itself.
> 
> 
> The solution here is most likely to let EPC drivers define a
> "HW limitation" of the MSI-X table (BAR number and offset), and create a new
> API in the PCI endpoint framework that exposes this, and modify all EPF
> drivers to use this API before calling pci_epc_set_msix().
> 

Ack, except that it's not HW limitation but IP integration decision,
because limitation sounds like a workaround for defects.

> 
> Personally, I'm too busy to work on this right now.
> For our use case with the NVMe PCI EPF, we can simply force it to only
> use MSI (instead of MSI-X).
> 
> But... I could submit a WARN() in dw_pcie_ep_raise_msix_irq() that explains
> that this function is broken, and that dw_pcie_ep_raise_msix_irq_doorbell()
> should be used instead, on platforms that support it.
> 
> Or, if it is preferred, we could simply modify all DWC based drivers that is
> not using dw_pcie_ep_raise_msix_irq_doorbell() (i.e. all except layerspace)
> to simply not set "msix_capable = true" in epc_features, as we know that all
> drivers that are using dw_pcie_ep_raise_msix_irq() are broken.
> 
> Thoughts?
> 
> 
> Kind regards,
> Niklas
> 


