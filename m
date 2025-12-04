Return-Path: <linux-pci+bounces-42663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F36CA5784
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 22:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6887B300BF99
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 21:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0052FF16D;
	Thu,  4 Dec 2025 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="k51yt5SV"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0D72DCC13
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764883692; cv=none; b=rgCEkx3gMeaS7L7F20eF0FSaDtjKRI8NIMLloNZrktDbYIJXzruXwreKd1XROq5k4Ug0z1YfhowsI9JgLwuFv/4/4Gf+PhcwIarCqlsBjnTloASZhVn/u9m/nfmm0cGfU8e2Gt/n2G27HBWJnaAX4ospy7SQJbJIhIfqwpiWdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764883692; c=relaxed/simple;
	bh=nycDVPJ8L0Q0kAsy2hlB/COjXzIV8c0OB9bltII2cZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kh7puNrhEenBv7IuMZFkUjijNRUTl1esaxebjkET2D3Urp1Qf/LKsK1TdnixEJA6gVIu9CU4FDN+EqSYPCzV9uaM6xN3Yxq07kQ24sxuGUpbZaVJQMdsPDfMmuGaMyH8/CDW+7JeV3t9F6nhj3Y9ehiWeWArUOeTsSpOjLAfVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=k51yt5SV; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <23475d2b-3201-41f1-9a60-a951250a9d60@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1764883687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iwto1rx3CIVNJePk0zxNQsI8gWCznDZFiYUJfo+2sPY=;
	b=k51yt5SVLwglAow/PibFfFFmQ4bBbDq/urryoQd8kaptrCJkjkqWRqlKvT1j8OLjlAa1v8
	I6FvsO52yYtq2ZfZ8LD2buz7oxAW867RWrFYVqrIbbHcEMsotzLEOT85GwduMZKpga8B7s
	++u3KJP1hc/JsZy8MGk1JyuqFPxwrZkywKDyGEdDGq9nK3PJQ7r6I4M19lq98wZZPPFMmm
	ZPQum+gvs44ayZ6ZyBFQSLC0udXEF3hhpUkAyDs0dtuffhcKCp2cTBwBlBF2n0LqyMjfjM
	VV6zl9GmTqkpO8VuNetHlXbYPfG1aicp1SB5RDH8ondGerazwEdsfBCvF7ZQaA==
Date: Thu, 4 Dec 2025 18:28:00 -0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: Add quirk to disable ASPM L1 for Sandisk SN740
 NVMe SSDs
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251120161253.189580-1-mani@kernel.org>
 <20251124235307.GA2725632@bhelgaas>
 <tiadpmogdxom5h2bquct2ch6hoc6ozh6bgnzdmnj3mia22vtue@c5yjxbx65lsm>
 <9a9280e7-d29a-475a-83fa-671acfab9d92@packett.cool>
 <6c45abe8-6c1c-4cf1-b538-abf65edefba5@oss.qualcomm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <6c45abe8-6c1c-4cf1-b538-abf65edefba5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/4/25 9:51 AM, Konrad Dybcio wrote:

> On 12/1/25 7:48 AM, Val Packett wrote:
>> On 11/25/25 2:21 AM, Manivannan Sadhasivam wrote:
>>> [..]
>>> There are a couple of points that made me convince myself:
>>>
>>> * Other X1E laptops are working fine with ASPM L1.
>>> * This laptop has WCN785x WiFi/BT combo card connected to the other controller
>>> instance and L1 is working fine for it.
>>> * There is no known issue with ASPM L1 in X1E chipsets.
>>>
>>> Because of these, I was so certain that the NVMe is the fault here.
>> There is *a* known issue with ASPM L1 on X1E, reported by maaaany users on #aarch64-laptops, that we discussed in another thread..
>>
>> But it is a full system freeze, **not** a correctable AER message, and it definitely happens with a bunch of various SSDs on various laptops. I personally have had it happen both with the SN740 and an SK Hynix drive, on a Latitude 7455. It's an SSD-only issue (disabling ASPM just for the drive, but keeping it on for the WiFi, was enough to get to month-long uptime) but not specific to any SSD model.
> Are the steps to reproduce roughly
>
> * boot without disabling ASPM
> * wait
> * system reboots on its own (or just freezes?)
>
> ?

Yeah.

Wait can be anywhere from minutes to days, it seems completely random 
and "luck based".

In EL1, the system freezes for a minute and gets rebooted by the watchdog.

In EL2 as I have just now discovered, some cores can still be running 
(presumably those that haven't tried accessing the drive) as others 
hang, and we can get a proper panic, I got this logged to efi_pstore:

<0>[ 1500.017790] watchdog: CPU3: Watchdog detected hard LOCKUP on cpu 4
<4>[ 1500.017801] Modules linked in: [..]
<6>[ 1500.017937] Sending NMI from CPU 3 to CPUs 4:
<0>[ 1510.017956] Kernel panic - not syncing: Hard LOCKUP
<4>[ 1510.017970] Call trace: [one with watchdog_hardlockup_check, from 
CPU3]
<2>[ 1510.018062] SMP: stopping secondary CPUs
<4>[ 1511.085450] SMP: failed to stop secondary CPUs 4-11

No traces from the frozen cores are logged as they don't respond to NMI. 
They are *completely* wedged.

~val


