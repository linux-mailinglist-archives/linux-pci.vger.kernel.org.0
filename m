Return-Path: <linux-pci+bounces-32485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FA1B09A64
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 06:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243543B4C47
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 04:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8081A316E;
	Fri, 18 Jul 2025 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hogjkqIC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m21466.qiye.163.com (mail-m21466.qiye.163.com [117.135.214.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F51DA3D;
	Fri, 18 Jul 2025 04:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752811326; cv=none; b=bLIxW7ePqPc1wSIjCW1X+oblt7OdmM2+5mk0aGIK5Rn+3VYr1/siozgWe3Pwxy6QJuD8XLXvr0yccX3Q69TGJ+WzPR9bXBzDNmx52XziwcrznzogTvZFuwg+0KNg3qZq0cl4e+1DTjN3bd5m9Zye80YzKBJcGJ5WBF55gHm+w9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752811326; c=relaxed/simple;
	bh=apzk4AFnosM6WwA0jevaOpnhNpzku0YBagtUjk9x4b0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dzCeAiK8uuPMfEgZgjyszYCGWJ7UVSYpDp5cwcG1uRZ5h8UO/0BLAReFWg1Gp95AYBthrBH9boA7qryMvlPSlGxtELWEfV9KwP5BQyMgWP92JjOrEvXCTw6cz04hWxpWt6niP0o2PnbEaFgemVU4igFkkCXSKafvcXVq8kOsQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hogjkqIC; arc=none smtp.client-ip=117.135.214.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c6eff80b;
	Fri, 18 Jul 2025 11:46:42 +0800 (GMT+08:00)
Message-ID: <067e1833-8527-4c66-90f5-d284f7d2ca5c@rock-chips.com>
Date: Fri, 18 Jul 2025 11:46:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Hugh Cole-Baker <sigmaris@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH v3 2/3] PCI: rockchip-host: Retry link training on
 failure without PERST#
To: Geraldo Nascimento <geraldogabriel@gmail.com>
References: <cover.1749582046.git.geraldogabriel@gmail.com>
 <b7c09279b4a7dbdba92543db9b9af169776bd90c.1749582046.git.geraldogabriel@gmail.com>
 <ac48d142-7aec-4fdd-92a4-6f9bc10a7928@rock-chips.com>
 <aHnAcbXuFqcMXy_5@geday>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aHnAcbXuFqcMXy_5@geday>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhgdTVZDTBlKHUoaSB9MT09WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a981ba430bd09cckunm6356e98e1fd4594
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OS46FAw4AjE4M1YKNDcBKgMu
	OEwKCk1VSlVKTE5JQ0pLT0tITkxCVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU9JT0I3Bg++
DKIM-Signature:a=rsa-sha256;
	b=hogjkqICVDrRageskiwzn6+yGseT8QcNqZBVNH6DKYgPt1bTvPWF0EL4YFgvxFZDCUTkLfrPHhj+4nVKFbYlZ6NxPSDL8CIQSY9YbPsW1bRv9jWhGSCOeXn8PhMHs/JmrrLMyX/CRLKidBSv7XNHHuO6MKKbL6Ktiuh03Wz3bO4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=tAEW8nh82M3n6oKElIg12pDpIa7tqdkjZDGaRgfT/xk=;
	h=date:mime-version:subject:message-id:from;

在 2025/07/18 星期五 11:33, Geraldo Nascimento 写道:
> On Fri, Jul 18, 2025 at 09:55:42AM +0800, Shawn Lin wrote:
>> Hi Geraldo,
>>
>> 在 2025/06/11 星期三 3:05, Geraldo Nascimento 写道:
>>> After almost 30 days of battling with RK3399 buggy PCIe on my Rock Pi
>>> N10 through trial-and-error debugging, I finally got positive results
>>> with enumeration on the PCI bus for both a Realtek 8111E NIC and a
>>> Samsung PM981a SSD.
>>>
>>> The NIC was connected to a M.2->PCIe x4 riser card and it would get
>>> stuck on Polling.Compliance, without breaking electrical idle on the
>>> Host RX side. The Samsung PM981a SSD is directly connected to M.2
>>> connector and that SSD is known to be quirky (OEM... no support)
>>> and non-functional on the RK3399 platform.
>>>
>>> The Samsung SSD was even worse than the NIC - it would get stuck on
>>> Detect.Active like a bricked card, even though it was fully functional
>>> via USB adapter.
>>>
>>> It seems both devices benefit from retrying Link Training if - big if
>>> here - PERST# is not toggled during retry.
>>>
>>
>> I didn't see this error before especially given RTL8111 NIC is widelly
>> used by customers.
> 
> Hi Shawn, great to hear from you!
> 
> Notice that my board exposes PCIe only via NVMe connector, and not
> directly via a proper PCIe connector, so it is necessary for me to
> adapt with inexpensive riser card that exposes proper PCIe connector.
> 
> I say this because while I don't doubt that the RTL8111 NIC works
> out-of-the-box for boards that directly expose PCIe connector, the
> combination of riser card plus NIC has a similar effect - though not
> entirely equal, as described above - of connecting known good SSDs
> that simply refuse to work with Rockchip-IP PCIe.
> 
> I admit that patch 1 looks a little crazy, but is has the effect of
> enabling use of presently non-working devices or combination of devices
> on this IP, at least on the board I have access to.
> 
>>
>> Could you help tried this?
>> [1] apply your patch 3 first
> 
> Sure, I'm always open for testing, but could you clarify the patch 3
> part? AFAIK this series of mine only has 2 patches, so I'm a little
> confused about exactly which patch to apply as a preliminary step.

Patch 3 refers to "arm64: dts: rockchip: drop PCIe 3v3 always-on and
boot-on" which let kernel fully controller the power in case firmware
did it in advanced.

> 
> Also, since you're asking me to test some code, I think it is only fair
> if I ask you to test my code, too. It shouldn't be too hard for you to
> find a otherwise working NVMe SSD that refuses to complete link training
> with current code. Connect this SSD please to a RK3399 board and let us
> know if my proposed code change does anything to ameliorate the
> long-standing issue of SSD that refuses to cooperate.

Sure, I don't have Samsung PM981a SSD now, but I could try to test all
my SSDs to find if I could pick up one that won't work.

> 
> Thank you,
> Geraldo Nascimento
> 


