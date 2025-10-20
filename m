Return-Path: <linux-pci+bounces-38786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92B4BF2C23
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 19:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2311742458B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 17:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FC83321C4;
	Mon, 20 Oct 2025 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJw+V2OX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F03321BD;
	Mon, 20 Oct 2025 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981888; cv=none; b=D40e+D9qj/QYDUJc9WwL90p8R48bXD2TRBaDzdE9HJLmayXWPkwhD4X4HC6BllzdLNT2gSPBAM3sna/Al5MvmrJYo6ykqZa5eRLJe34cVsJSa9PqOYvDv+uIjFUqjEOFGfi8D/lwseAeERGjsWfpY9uSnSrEk7tUZucPjMILx1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981888; c=relaxed/simple;
	bh=e+OULNAMu/Zn3ArvIQhJPBZIurmxOnAUZLoa5y67Az0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fH8cls/huZGEEctVpYEiqoFETQsrG6owQJyPHilYIYgLTD/JKCn7X17yw0KvdAHkLEOHkaQz8bylznEY4r82ze81UCdeo+wEQFJFiQ9kXpn6neeElPXeO300r5Dfl8jdGJ0ODscB/VIvHnuUBjcp/YvH3i+8QtXisllcYkDWiMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJw+V2OX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6E3C116B1;
	Mon, 20 Oct 2025 17:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981887;
	bh=e+OULNAMu/Zn3ArvIQhJPBZIurmxOnAUZLoa5y67Az0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=dJw+V2OX6rAuRwX4jFd9wkVkaJmg9X0p4lPTC9iFgvygqzZLfDCCwjqBQ2w+oMwmp
	 EAz5G32fP1QFnxJwI656yTJVxB6L0vctMKhD/rhhYLQR4P+KzfK9qpXtWEL+1M5n1l
	 GX9UDubyINfGgo9t4XlL6tFBjIr7QzzBH/YB9MVGTshGiL5eAOG0BnjASbLYcrDTs+
	 GkVnio/uTjDUvTRYZOReOwiTyRSWNRBQ6T8d9An0dWQpfNfA0/C5PNzSzi65ISKQ6e
	 XAw+e/Vy6sjMbSSMDmVJqN2jVwtRZM8hzU0crNr6V1mJ+b1mpKqitivfX+Yl5Cawa2
	 FNXy2eti9NqXg==
Message-ID: <60380893-c323-4d4c-a9a1-d43fcb4da1b3@kernel.org>
Date: Mon, 20 Oct 2025 12:38:05 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Intel Wireless adapter is not detected until
 suspending to RAM and resuming
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
To: =?UTF-8?Q?Adri=C3=A0_Vilanova_Mart=C3=ADnez?= <me@avm99963.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: regressions@lists.linux.dev, linux-pci@vger.kernel.org
References: <owewi3sswao4jt5qn3ntm533lvxe3jlovhjbdufq3uedbuztxt@76nft22vboxv>
 <d0b6105f-744f-40d9-b4b7-1fa645038d0b@kernel.org>
 <h6wkxjrkxh3ea5aqexqrx4d6xb2t2xbirvznupnbgro64qytfs@mn2jg2c6owrj>
 <rvep55wtk2q4j46eqcxkfgb2bwijunefyltygfyb44trbzblx2@3ou3jcybjt3p>
 <6b3d282c-b3cd-4979-b26b-ae9b28b9d634@kernel.org>
 <kaieqe37mjmizjv4regyw67z7hwa3ac3k2mwcjsgq2mj7redpm@xsfb4mtyjblf>
 <a08c71e2-18ca-491b-8982-47214a35445b@kernel.org>
 <lpntymy3w6ryvyo2trpqkl7i3aibofzqcp7p5jhxjlkse645iq@fepikfj4tcyk>
 <149b04c5-23d3-4fd8-9724-5b955b645fbb@kernel.org>
Content-Language: en-US
In-Reply-To: <149b04c5-23d3-4fd8-9724-5b955b645fbb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/20/2025 11:37 AM, Mario Limonciello (AMD) (kernel.org) wrote:
> 
> 
> On 10/20/2025 7:56 AM, Adrià Vilanova Martínez wrote:
>> On Sun, Oct 19, 2025 at 07:25:08PM -0500, Mario Limonciello wrote:
>>> Thanks, knowing that pcie_aspm=off helps I think we should compare 
>>> output
>>> for:
>>>
>>> # sudo lspci -vvnn
>>
>> Sure, I'm attaching the outputs of this command for all the scenarios.
>> There are some differences, so it seems promising.
>>
> 
> Surprisingly there is nothing different about ASPM though.  It's all 
> PCI-PM differences.
> 
> Looking at your log again I noticed this from the bridge:
> 
> pcieport 0000:00:1c.0: pciehp: Slot(0): Card not present
> pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
> pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up
> ...
> pcieport 0000:00:1c.0: pciehp: Slot(0): No device found
> ...
> (suspend)
> ...
> pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
> pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up
> 
> 
>> I'm building the Kernel on the following commits:
>>
>> - "Kernel without 4d4c10f763 and 907a7a2e5b": 1c64efcb08, applying on
>> top reverts for these 2 commits. [locally compiled version
>> 6.18.0-rc1-local-reverted-pci-issues-00351-gbbaff7ff47dd]
>> - "Kernel with 4d4c10f763 and 907a7a2e5b": 1c64efcb08 (last commit I
>> pulled from mainline last week). [locally compiled version ???]
>>
>>> In the following cases (all without pcie_aspm=off):
>>>
>>> 1) At bootup; a kernel without 4d4c10f763 and 907a7a2e5b
>>
>> See 01_lspci_bootup_without_4d4c10f763_907a7a2e5b.txt
>>
> 
> OK so the bridge at 00:1c.0:
> L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1-
> 
> 01:00.0 is present
> 
>>> 2) At bootup; a kernel with 4d4c10f763 and 907a7a2e5b
>>
>> See 02_lspci_bootup_with_4d4c10f763_907a7a2e5b.txt
>>
> 
> OK so the bridge at 00:1c.0:
> L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
> 
> 01:00.0 is NOT present
> 
>>> 3) After suspend/resume; a kernel without 4d4c10f763 and 907a7a2e5b4
>>
>> See 03_lspci_after_suspend_resume_without_4d4c10f763_907a7a2e5b.txt
>>
> 
> OK so the bridge at 00:1c.0:
> L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1-
> 
> 01:00.0 is present
> 
>>> 4) After suspend/resume; a kernel with 4d4c10f763 and 907a7a2e5b
>>
>> See 04_lspci_after_suspend_resume_with_4d4c10f763_907a7a2e5b.txt
>>
> 
> OK so the bridge at 00:1c.0:
> L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
> 
> 01:00.0 is present
> 
>> Again, thank you so much! I really appreciate your help in
>> troubleshooting this.
> 
> My interpretation is that the BIOS by default starts with PCI PM 
> enabled.  When you test without 4d4c10f763 and 907a7a2e5b it will stay 
> enabled.  But when those commits are present it gets disabled when going 
> to D0 and that causes device to drop off the bus.
> 
> How about with pcie_port_pm=off instead of pcie_aspm=off?  Do things work?
> 
> My current thought is that the change (setting to D0 explicitly at boot- 
> up) exposed a bug in the platform.  But the fact that it works without 
> ASPM is confusing to me.
> 
> Bjorn - any thoughts here?

By happenstance I came across this earlier.

https://lore.kernel.org/linux-pm/aPJ4pZFENCTx9yhy@google.com/T/#m55aceae9153a1aa195635fe48aadb0888c795e49

Does that help by chance?

> 
>>
>> PS: I'm trimming the email quotes as per
>> https://subspace.kernel.org/etiquette.html#trim-your-quotes-when- 
>> replying.
>> I've never done this before and it feels wrong, but it is indeed easier
>> to follow the conversation if I do this.
> 
> 


