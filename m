Return-Path: <linux-pci+bounces-40933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1EFC4F3F7
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 18:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2DE189D2C6
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B197A3730D3;
	Tue, 11 Nov 2025 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="imcz45oJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1A7393DF8
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882211; cv=none; b=RgT/hdvChXXL0FxHVfm75kXYb9SK3TXGTrLlXfVqxnbZ1blFtBsmlL7hNsxg5nWMm52zb+kbpdQDVNqsRDcoQHjaas+DDAmwmA577e0Ps/LaAb0HmbkXma4iPPNuHXql6K4FoRTqg+mUO7+14+952qvdahNgwuoy/4/7svAVF0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882211; c=relaxed/simple;
	bh=exlQD63SqVGMKyRLRu2V27JAcGxlgNW1zdjyDK87WjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pivlPQM76WL4LLh7Igz1WvMKnqyL8AM01lWW6J/xloDklJtWDk+QYx7tPybGh17wRwtK9tz9h7JNkWPl/vrXFvzwVErmJsZCyncSyXQUr2aAMPdTQjhIZkuafGHR3yeFwlAhCNDmVooLu3I43JHyWEbVLBIILNeLLHDCoqy6nis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=imcz45oJ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <666481e9-4ce3-415f-bad4-e0b4ccf9a4d2@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1762882206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=alJdU9Lb6Tc8Lmz8IV8/RslU3w9fXrIJxB7VP1A4xVo=;
	b=imcz45oJII5//pZBJiM0/wBF61l6ANNykPVFuwlg1glsJBg/AXR1arbycirMIsu/5oPuNA
	E30JjT0ax+ljp5hQFf+LeZRfg9n0hS9VRfXARCk+5a31x3WBBpgaaVSJ2eARTgSEDJ4sE3
	hreXr38mHOIwgaBU6s6AET6ohi0i5NT97J7MbDBfQYABG1s7w5h2ByqSXPC8KyRetcvBMa
	5Pf9xlnU6wk9e8Jz+n6+ozC0wYQ7Lxmmb7omDRtwaGKVAiFy+BxIj7Iiq4EZu5deT3wXyw
	SUoOXRqR0RQiQNtBdQ0Me73jDqdeCmZS1WstIvw3UD1rh4AM9es5BADXQTwWQQ==
Date: Tue, 11 Nov 2025 14:29:57 -0300
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
 <c27b5514-1691-448a-9823-8b35955b0fc6@packett.cool>
 <twn5ryedkpv76ph3i7xbovktz3abqszthl6cxhtv6uczbv4ap7@4wrmlczxzjll>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <twn5ryedkpv76ph3i7xbovktz3abqszthl6cxhtv6uczbv4ap7@4wrmlczxzjll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/11/25 7:06 AM, Manivannan Sadhasivam wrote:
> On Tue, Nov 11, 2025 at 04:40:01AM -0300, Val Packett wrote:
>> On 11/11/25 4:19 AM, Manivannan Sadhasivam wrote:
>>> [..]
>>>> Totally unpredictable, could be after 4 minutes or 4 days of uptime.
>>>> Panic-indicator LED not blinking, no reaction to magic SysRq, display image
>>>> frozen, just a complete hang until the watchdog does the reset.
>>> I have KIOXIA SSD on my T14s. I do see some random hang, but I thought those
>>> predate the ASPM enablement as I saw them earlier as well. But even before this
>>> series, we had ASPM enabled for SSDs on Qcom targets (or devices that gets
>>> enumerated during initial bus scan), so it might be that the SSD doesn't support
>>> ASPM well enough.
>> I certainly remember that ASPM *was* enabled by default when I first got
>> this laptop, via the custom way that predates this series.
>>
>> Actually that custom enablement code getting removed was how I discovered it
>> was ASPM related!
>>
>> I pulled linux-next once and suddenly the system became stable!.. and then I
>> noticed +2W of battery drain..
> Because, we only enable L0s and L1 by default and not L1ss.

Back in that short time period between the old code getting removed and 
this series landing, the default behavior was no ASPM at all, I'm pretty 
sure.

Again, with the SK hynix SSD I used back then, I *definitely* saw the 
issue with this series in and no args applied.

> [..]
>> I'm currently using the stock drive: Sandisk Corp PC SN740 NVMe SSD
>> (DRAM-less) [15b7:5015] (rev 01)
> I'm suspecting the L1ss issue with this SSD since you said above that
> next/master works fine until you pass 'pcie_aspm=force'. Could you try the below
> diff with that cmdline option?

I did *not* say that it works fine with no arg!

I said that I've only tested this stock WD SSD with 'force' so far, and 
don't have any data on *this* SSD without 'force' yet.

Now testing with this drive and no arg:

                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
                         ExtSynch+ ClockPM- AutWidDis- BWInt- AutBWInt- 
FltModeDis-

                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                            T_CommonMode=0us LTR1.2_Threshold=156672ns

Let's see how it goes.

But it sounds very odd that all the SSDs would be to blame and not the 
controller.. Other platforms don't seem to be having this issue. Don't 
Intel and AMD enable L1ss by default?

~val


