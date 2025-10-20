Return-Path: <linux-pci+bounces-38777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAEEBF27AF
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 18:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8743218A3F70
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 16:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB21296BC2;
	Mon, 20 Oct 2025 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUYMDsZP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A9296BB2;
	Mon, 20 Oct 2025 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978265; cv=none; b=qumzpJrLuRBhnHnvVp7vnUn0p0UTz62U6AcbQss7vqjMAaOmB7WTkV+vSkB/2JJ+JmrN28IuI8ahkfVHgQKTeBU+IVHmXoxmHl83QYY7Q35n9TG1WuqIUfhzyy/FGBb3h1HaMUZot/vJLkTN+QCKlBhRyfsvdQp4ESIirBLtPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978265; c=relaxed/simple;
	bh=3Wg+AymCy/fsBe4Too+VbMYHfF6QlP4BEeEz3nj7Ijw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rC+bV2lMIcp7amL+4lcs1bK+pjrQvLHQH8GGtr9tlJOUpT0nvERAEha/NddHFrjppLf3COwcWXp4XyyKhqxIVMDOmELGeU96k3GCNVs1L3ulxGl2DryZbbJvfc3dBgKvCHXhs8oj+4ZzHYebDAad7Bn3kggL30DAW96GJOIXczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUYMDsZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472ADC116B1;
	Mon, 20 Oct 2025 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760978264;
	bh=3Wg+AymCy/fsBe4Too+VbMYHfF6QlP4BEeEz3nj7Ijw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KUYMDsZPFeDG2p0Fm1Q1WnnCP9ITchDnV9JG695UCNmSmPFAz4Desf2E8KXB5Z/EU
	 DTYGZ44kDHrE+Xe0l67SxznCk9oqVOpOU9iKoET4kYtnAV7NLldrza8Xou9X7o65Dz
	 GZJ/QLNjDkuGJ3Laui+7oNrEMoZr4veZ6e3PbyKju/+dLCw+HYmBpN64W9TSNHQqE/
	 hsHvOROdFPc9ViVvYR3i7bHTFn1JEdubBE3c7FRrGri1qkLcM6ofpyFeqy2cbd93hk
	 ZelbQ12+ybAM96gTIqf26gtqjmDvwep33MWbRAHNH2ddaIofPjUT9aMp+CHsgKZQxZ
	 S93G4XQrjoWWg==
Message-ID: <149b04c5-23d3-4fd8-9724-5b955b645fbb@kernel.org>
Date: Mon, 20 Oct 2025 11:37:43 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Intel Wireless adapter is not detected until
 suspending to RAM and resuming
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
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <lpntymy3w6ryvyo2trpqkl7i3aibofzqcp7p5jhxjlkse645iq@fepikfj4tcyk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/20/2025 7:56 AM, Adrià Vilanova Martínez wrote:
> On Sun, Oct 19, 2025 at 07:25:08PM -0500, Mario Limonciello wrote:
>> Thanks, knowing that pcie_aspm=off helps I think we should compare output
>> for:
>>
>> # sudo lspci -vvnn
> 
> Sure, I'm attaching the outputs of this command for all the scenarios.
> There are some differences, so it seems promising.
> 

Surprisingly there is nothing different about ASPM though.  It's all 
PCI-PM differences.

Looking at your log again I noticed this from the bridge:

pcieport 0000:00:1c.0: pciehp: Slot(0): Card not present
pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up
...
pcieport 0000:00:1c.0: pciehp: Slot(0): No device found
...
(suspend)
...
pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up


> I'm building the Kernel on the following commits:
> 
> - "Kernel without 4d4c10f763 and 907a7a2e5b": 1c64efcb08, applying on
> top reverts for these 2 commits. [locally compiled version
> 6.18.0-rc1-local-reverted-pci-issues-00351-gbbaff7ff47dd]
> - "Kernel with 4d4c10f763 and 907a7a2e5b": 1c64efcb08 (last commit I
> pulled from mainline last week). [locally compiled version ???]
> 
>> In the following cases (all without pcie_aspm=off):
>>
>> 1) At bootup; a kernel without 4d4c10f763 and 907a7a2e5b
> 
> See 01_lspci_bootup_without_4d4c10f763_907a7a2e5b.txt
> 

OK so the bridge at 00:1c.0:
L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1-

01:00.0 is present

>> 2) At bootup; a kernel with 4d4c10f763 and 907a7a2e5b
> 
> See 02_lspci_bootup_with_4d4c10f763_907a7a2e5b.txt
> 

OK so the bridge at 00:1c.0:
L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-

01:00.0 is NOT present

>> 3) After suspend/resume; a kernel without 4d4c10f763 and 907a7a2e5b4
> 
> See 03_lspci_after_suspend_resume_without_4d4c10f763_907a7a2e5b.txt
> 

OK so the bridge at 00:1c.0:
L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1-

01:00.0 is present

>> 4) After suspend/resume; a kernel with 4d4c10f763 and 907a7a2e5b
> 
> See 04_lspci_after_suspend_resume_with_4d4c10f763_907a7a2e5b.txt
> 

OK so the bridge at 00:1c.0:
L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-

01:00.0 is present

> Again, thank you so much! I really appreciate your help in
> troubleshooting this.

My interpretation is that the BIOS by default starts with PCI PM 
enabled.  When you test without 4d4c10f763 and 907a7a2e5b it will stay 
enabled.  But when those commits are present it gets disabled when going 
to D0 and that causes device to drop off the bus.

How about with pcie_port_pm=off instead of pcie_aspm=off?  Do things work?

My current thought is that the change (setting to D0 explicitly at 
boot-up) exposed a bug in the platform.  But the fact that it works 
without ASPM is confusing to me.

Bjorn - any thoughts here?

> 
> PS: I'm trimming the email quotes as per
> https://subspace.kernel.org/etiquette.html#trim-your-quotes-when-replying.
> I've never done this before and it feels wrong, but it is indeed easier
> to follow the conversation if I do this.


