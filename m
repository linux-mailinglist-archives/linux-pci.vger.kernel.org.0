Return-Path: <linux-pci+bounces-40689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F290C45DD3
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 11:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC903A3B54
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 10:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB193054C2;
	Mon, 10 Nov 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="GaomGJcZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731101.qiye.163.com (mail-m19731101.qiye.163.com [220.197.31.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100530100C;
	Mon, 10 Nov 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769743; cv=none; b=Jqqzn7/iazDf5+m3dUveWElEFpLYaqZI/StatjokGF0yMovhr0Tj2rV4wdwM6hogaDdv2lEzSjImF8Mig20ekVdJkPDz9Uql/t5MkNWUVrLewTUtp99f0Jz7IO9oUWqNG2MMRa1OOeuE9xDPg9XUO1bYv2n1OFNr4+FiUi0zsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769743; c=relaxed/simple;
	bh=O8EVIs+xuKhjj0/Qcm4jV97y/fyO7N1TPbS+b2dkZAk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QpVZj8zvQNsW0z6pUuXw4SafY8HK4EATR7b+dVQMxzOlDn/va0Pvw6Ju5AOWJqdQkEIEjDIgnmJ9LnfuAt1bj7Wacz5nKgEe6wnbiK5f5WeX9qPF4/irSG/5yKX3bzdDSHqG1rG7hQDbTnNjx6dHpDVIKwWUKz1leS/YkwZEyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=GaomGJcZ; arc=none smtp.client-ip=220.197.31.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2909a128f;
	Mon, 10 Nov 2025 18:15:35 +0800 (GMT+08:00)
Message-ID: <dc932773-af5b-4af7-a0d0-8cc72dfbd3c7@rock-chips.com>
Date: Mon, 10 Nov 2025 18:15:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Damien Le Moal <dlemoal@kernel.org>,
 Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Dragan Simic <dsimic@manjaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, mani@kernel.org
Subject: Re: [RESEND] Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
To: FUKAUMI Naoki <naoki@radxa.com>, Niklas Cassel <cassel@kernel.org>
References: <20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org>
 <1E8E4DB773970CB5+5a52c9e1-01b8-4872-99b7-021099f04031@radxa.com>
 <6e87b611-13ea-4d89-8dbf-85510dd86fa6@rock-chips.com>
 <aQ840q5BxNS1eIai@ryzen> <aQ9FWEuW47L8YOxC@ryzen>
 <55EB0E5F655F3AFC+136b89fd-98d4-42af-a99d-a0bb05cc93f3@radxa.com>
 <aRCI5kG16_1erMME@ryzen>
 <F8B2B6FA2884D69A+b7da13f2-0ffb-4308-b1ba-0549bc461be8@radxa.com>
 <780a4209-f89f-43a9-9364-331d3b77e61e@rock-chips.com>
 <4487DA40249CC821+19232169-a096-4737-bc6a-5cec9592d65f@radxa.com>
 <363d6b4d-c999-43d4-866e-880ef7d0dec3@rock-chips.com>
 <0C31787C387488ED+fd39bfe6-0844-4a87-bf48-675dd6d6a2df@radxa.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <0C31787C387488ED+fd39bfe6-0844-4a87-bf48-675dd6d6a2df@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a6d438d5d09cckunm2a41cfe81382c3e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhgaSFYaGkgaSkNJGU9PHx9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=GaomGJcZFoXy9dmKjLqxt7SSQwarCMv4UTRUnrqYXArfcRVHwNXTJEHw2s9PSPE9iGfN8S0vj7/5FE4SI677ltHzqcx8kqhuDDOr/4Cvmv4GuwiC1PderlOoae7sw3AVJSuz5uBBzLbtDsdOy6roqwSdbIwwONzCSx8H2PtfC1g=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=VAr21MtQeeygUzAg/O3leSHmqCylhYlryIgLa6wjxJs=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/10 星期一 15:52, FUKAUMI Naoki 写道:
> Hi Shawn,
> 
> On 11/10/25 16:12, Shawn Lin wrote:
> (snip)> Thanks for testing. I just got a ASM2806 switch as yours and 
> verified it
>> on vanilla v6.18-rc5. After 30 times of cold boot, two NVMes behind
>> ASM2806 work as expected. Nothing special happened when I checked
>> with PA as well. You could help check the log and lspci dump there[1].
>>
>> [1]https://pastebin.com/sAF1fT0g
> 
> Thanks for the info!
> 
> I tried ASM2806 on Radxa ROCK 5B (RK3588).
>   https://gist.github.com/RadxaNaoki/640e47d377add9fe38301de164d4058e
> 
> It doesn't work on PCIe 2.0 (M.2 E Key), but it does work on PCIe 3.0 
> (M.2 M Key).
> 
> Could you try PCIe 2.0 slot on your board?

I did, it doesn't work on PCIe 2.0 slot. From the PA, I could see
the link is still in training during pci_host_probe() is called.
Add some delay before pci_rescan_bus() in pcie-dw-rockchip doesn't
help. But the below change should work as we delayed pci_host_probe().

--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -236,6 +236,8 @@ static int rockchip_pcie_start_link(struct dw_pcie *pci)
         msleep(PCIE_T_PVPERL_MS);
         gpiod_set_value_cansleep(rockchip->rst_gpio, 1);

+       msleep(50);
+
         return 0;

Otherwise we got:

[    0.841518] pci_bus 0003:33: busn_res: can not insert [bus 33-31] 
under [bus 32-31] (conflicts with (null) [bus 32-31])
[    0.842596] pci_bus 0003:33: busn_res: [bus 33-31] end is updated to 33
[    0.843184] pci_bus 0003:33: busn_res: can not insert [bus 33] under 
[bus 32-31] (conflicts with (null) [bus 32-31])
[    0.844120] pci 0003:32:00.0: devices behind bridge are unusable 
because [bus 33] cannot be assigned for them
[    0.845229] pci_bus 0003:34: busn_res: can not insert [bus 34-31] 
under [bus 32-31] (conflicts with (null) [bus 32-31])
[    0.846309] pci_bus 0003:34: busn_res: [bus 34-31] end is updated to 34
[    0.846898] pci_bus 0003:34: busn_res: can not insert [bus 34] under 
[bus 32-31] (conflicts with (null) [bus 32-31])
[    0.847833] pci 0003:32:06.0: devices behind bridge are unusable 
because [bus 34] cannot be assigned for them
[    0.848923] pci_bus 0003:35: busn_res: can not insert [bus 35-31] 
under [bus 32-31] (conflicts with (null) [bus 32-31])
[    0.850014] pci_bus 0003:35: busn_res: [bus 35-31] end is updated to 35
[    0.850605] pci_bus 0003:35: busn_res: can not insert [bus 35] under 
[bus 32-31] (conflicts with (null) [bus 32-31])
[    0.851540] pci 0003:32:0e.0: devices behind bridge are unusable 
because [bus 35] cannot be assigned for them
[    0.852424] pci_bus 0003:32: busn_res: [bus 32-31] end is updated to 35
[    0.853028] pci_bus 0003:32: busn_res: can not insert [bus 32-35] 
under [bus 31] (conflicts with (null) [bus 31])
[    0.853184] hub 3-0:1.0: USB hub found
[    0.853931] pci 0003:31:00.0: devices behind bridge are unusable 
because [bus 32-35] cannot be assigned for them
[    0.854262] hub 3-0:1.0: 1 port detected
[    0.855144] pcieport 0003:30:00.0: bridge has subordinate 31 but max 
busn 35
[    0.855722] hub 4-0:1.0: USB hub found
[    0.856109] pci 0003:32:00.0: PCI bridge to [bus 33]
[    0.856939] pci 0003:32:06.0: PCI bridge to [bus 34]
[    0.857133] hub 4-0:1.0: 1 port detected
[    0.857430] pci 0003:32:0e.0: PCI bridge to [bus 35]
[    0.858236] pci 0003:31:00.0: PCI bridge to [bus 32-35]

> 
> Best regards,
> 
> -- 
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 
> 


