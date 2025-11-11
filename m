Return-Path: <linux-pci+bounces-40838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B121BC4C240
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 08:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6733B77FA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 07:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1E129DB6A;
	Tue, 11 Nov 2025 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="kj0fp8Gs"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B787A31BC80
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846839; cv=none; b=laM9PELw28Bs9qbnPyZAJHkbFmS59mf/1WEQDkZxi8P5erlpsfoFe32WnP39MNs6HEWt/qCabbRjAJ5IFNIerjEC3M/IdFJjsr2KHZmwhpIH4ZE82OnJpwgQHrxccpdq1pkKf4XMQaUV8lZdIVjbblNq9x9laTXgaFpeR8N76S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846839; c=relaxed/simple;
	bh=/eAcCADFx1KN9TUNrzyCjPaC853i99Gc+U9+8pcCGB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8Ndcmlqdi96UpXiEIBEfCmYHVbcLb/mK28yJ1WZ8xN87QmS/0O6JJxBI18sJtEppBIeJNmheuuL3sOhlKcH7y9uj8w+fY/0cQwQzVW4E0AFW/u/1SLqe42E8C6Zxz4bAWr1UtQ5kJi3DVNGu1qm3NPE+V1xZtFg1eWj5CY5zaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=kj0fp8Gs; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <c27b5514-1691-448a-9823-8b35955b0fc6@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1762846824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eSCPUFxckyk8DCfOmruedDrJB+PpW6As/uwDjHVXw0=;
	b=kj0fp8GszZ+3R1nRN0IU+NipUQ6W2ywmEDXw9Gb1tforA+jEjkBCKuvFGzFUkYjuZtSUKi
	5mhP7jivZrXjI3yqkV/XWw8W11SUr5KC3B+YQKgm9KY1yz5jFoZRJs6QrVR2nRll1zlin2
	CBWNyCs1IxKl7Mo7zcKP9wOjt+4scFRWYPtnd0Ev4Z11ytiDJ/+h+bZU2Pyf3yVzT1FXXf
	uG5+z13kbKJFFmgMqa9lyMe/kpt05ZLJWYeugprNdqL+3bo+p1QGicE8nio3p4UAHExbu3
	4ZdxHSPURnpPRStgAG+6BNSWBqob7hekQ1ZYlkrrjo52bEb/7NugefSuuAyWnA==
Date: Tue, 11 Nov 2025 04:40:01 -0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] PCI/ASPM: Enable ASPM and Clock PM by default on
 devicetree platforms
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 manivannan.sadhasivam@oss.qualcomm.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Valentine Burley <valentine.burley@collabora.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 "David E. Box" <david.e.box@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Chia-Lin Kao <acelan.kao@canonical.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <20250922-pci-dt-aspm-v2-0-2a65cf84e326@oss.qualcomm.com>
 <4cp5pzmlkkht2ni7us6p3edidnk25l45xrp6w3fxguqcvhq2id@wjqqrdpkypkf>
 <36f05566-8c7a-485b-96e7-9792ab355374@packett.cool>
 <qy4cnuj2dfpfsorpke6vg3skjyj2hgts5hhrrn5c5rzlt6l6uv@b4npmattvfcm>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <qy4cnuj2dfpfsorpke6vg3skjyj2hgts5hhrrn5c5rzlt6l6uv@b4npmattvfcm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/11/25 4:19 AM, Manivannan Sadhasivam wrote:
> On Tue, Nov 11, 2025 at 03:51:03AM -0300, Val Packett wrote:
>> On 11/8/25 1:18 PM, Dmitry Baryshkov wrote:
>>> On Mon, Sep 22, 2025 at 09:46:43PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
>>>> Hi,
>>>>
>>>> This series is one of the 'let's bite the bullet' kind, where we have decided to
>>>> enable all ASPM and Clock PM states by default on devicetree platforms [1]. The
>>>> reason why devicetree platforms were chosen because, it will be of minimal
>>>> impact compared to the ACPI platforms. So seemed ideal to test the waters.
>>>>
>>>> This series is tested on Lenovo Thinkpad T14s based on Snapdragon X1 SoC. All
>>>> supported ASPM states are getting enabled for both the NVMe and WLAN devices by
>>>> default.
>>>> [..]
>>> The series breaks the DRM CI on DB820C board (apq8096, PCIe network
>>> card, NFS root). The board resets randomly after some time ([1]).
>> Is that reset.. due to the watchdog resetting a hard-frozen system?
>>
>> Me and a bunch of other people in the #aarch64-laptops irc/matrix room have
>> been experiencing these random hard freezes with ASPM enabled for the NVMe
>> SSD, on Hamoa (and Purwa too I think) devices.
>>
> Interesting! ASPM is tested and found to be working on Hamoa and other Qcom
> chipsets also, except Makena based chipsets that doesn't support L0s due to
> incorrect PHY settings. APQ8096 might be an exception since it is a really old
> target and I'm digging up internally regarding the ASPM support.
>
>> Totally unpredictable, could be after 4 minutes or 4 days of uptime.
>> Panic-indicator LED not blinking, no reaction to magic SysRq, display image
>> frozen, just a complete hang until the watchdog does the reset.
>>
> I have KIOXIA SSD on my T14s. I do see some random hang, but I thought those
> predate the ASPM enablement as I saw them earlier as well. But even before this
> series, we had ASPM enabled for SSDs on Qcom targets (or devices that gets
> enumerated during initial bus scan), so it might be that the SSD doesn't support
> ASPM well enough.

I certainly remember that ASPM *was* enabled by default when I first got 
this laptop, via the custom way that predates this series.

Actually that custom enablement code getting removed was how I 
discovered it was ASPM related!

I pulled linux-next once and suddenly the system became stable!.. and 
then I noticed +2W of battery drain..

> But I'm clueless on why it results in a hang. What I know on ARM platforms is
> that we get SError aborts and other crazy bus/NOC issues if the device doesn't
> respond to the PCIe read request. So the hang could be due to one of those
> issues.

Could the kernel be making requests before the device fully resumed from 
a sleep state?

>> I have confirmed with a modified (to accept args) enable-aspm.sh script[1]
>> that disabling ASPM *only* for the SSD, while keeping it *on* for the WiFi
>> adapter, is enough to keep the system stable (got to about a month of uptime
>> in that state).
>>
> So this confirms that the controller supports it, and the device (SSD) might be
> of fault here.
>
>> If you have reproduced the same issue on an entirely different SoC, it's
>> probably a general driver issue.
>>
>> Please, please help us debug this using your internal secret debug equipment
>> :)
>>
> Starting from v6.18-rc3, we only enable L0s and L1 by default on all devicetree
> platforms. Are you seeing the hangs post -rc3 also? If so, could you please
> share the SSD model by doing 'lspci -nn'?

Yes, still seeing them on 6.18.0-rc4-next-20251107. At least with 
pcie_aspm=force (have been using that recently, so likely all my testing 
"post -rc3" was with force on.. but others have been testing without it)

I'm currently using the stock drive: Sandisk Corp PC SN740 NVMe SSD 
(DRAM-less) [15b7:5015] (rev 01)

Though for a couple months I've used a 3rd party one, an SK Hynix BC901 
[1c5c:1d59]

And other users have different other models and still have the same issue.

// Every time something PCIe related is posted to the mailing lists I've 
been wondering if it could solve this :D
"Program correct T_POWER_ON value for L1.2 exit timing" didn't help. 
Testing "Remove DPC Extended Capability" now..


~val


