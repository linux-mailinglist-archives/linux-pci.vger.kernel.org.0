Return-Path: <linux-pci+bounces-18571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C77589F3E4B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 00:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D647161536
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 23:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFB71D63C4;
	Mon, 16 Dec 2024 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="QK0jC8Pa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F8139CEF;
	Mon, 16 Dec 2024 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392252; cv=none; b=hj/WGaTkdnNYJsMR60H33MMJdsmn1gsCCHDtO5yojcL+RnqtnwF6Tgz7oP5VLHEljfmT1BAj0LI8ZkJMYRLxLqnO8STqd2hEFD57aoJcIhk1DNlCChrXgHalC7fI9k66CSrXTwMEtIH8c8pnfZsMmd9H10vNhJgLRByJhhJ7n14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392252; c=relaxed/simple;
	bh=2Ujd819ZoH84F+rPTjD8dKjw8d+8/3y2KYQXmyMmTls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhUM9C8ZvTzO+2Wzw/xY/3MtdGx+8o3RbUrVTHpcACHhRhF8xmU7Q+tMGNNeTkSZK8ou9tHNItidtfnsyW9yqBfeTIb09C+yFea5BHhQ0SiyqgdT6NhQaqsfkmXnx+HJH1xFbUOuIaIC5rWn538RGktBlR4NtnbbH0Czl/Zl7eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=QK0jC8Pa; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [10.6.0.9] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id E99372FC0055;
	Tue, 17 Dec 2024 00:37:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1734392245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5GAYNNOWyNg1bgIK1K5PEC3zhubidO5xanYzMAVJ08=;
	b=QK0jC8PakttUR1ACoQt6emjJnUrkDzbwcypaZweq4aILhT8JrI3NvlHR/kPqXhTe7SPx+c
	Mymu/LkucmpasAXHo1KvaqJk52a8fL/MphxmBhwpxpw+6s/NQMF51+M+LFsur2+nAAQbmk
	yEIvmfX3hntAYxPAeBF/rbSPaH/heZ0=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <2b762f16-fe50-4dec-8f3f-dfe21977d807@tuxedocomputers.com>
Date: Tue, 17 Dec 2024 00:37:24 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
To: Richard Hughes <richard@hughsie.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Richard Hughes <hughsient@gmail.com>, ggo@tuxedocomputers.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241209193614.535940-1-wse@tuxedocomputers.com>
 <215cd12e-6327-4aa6-ac93-eac2388e7dab@amd.com>
 <23c6140b-946e-4c63-bba4-a7be77211948@tuxedocomputers.com>
 <823c393d-49f6-402b-ae8b-38ff44aeabc4@amd.com>
 <2b38ea7b-d50e-4070-80b6-65a66d460152@tuxedocomputers.com>
 <e0ee3415-4670-4c0c-897a-d5f70e0f65eb@amd.com>
 <6a809349-016a-42bf-b139-544aeec543aa@tuxedocomputers.com>
 <20cfa4ed-d25d-4881-81b9-9f1698efe9ff@amd.com>
 <vVLu9MdNWVCG96sN3xqjkmMVQpr_1iu61hX0w0q5dSQtFBi9ERc3b6hSoCjobPSTNgkIp3PBheheyUlayhMeQjShsx62zNqxWnPsrHt-xaM=@hughsie.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <vVLu9MdNWVCG96sN3xqjkmMVQpr_1iu61hX0w0q5dSQtFBi9ERc3b6hSoCjobPSTNgkIp3PBheheyUlayhMeQjShsx62zNqxWnPsrHt-xaM=@hughsie.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 13.12.24 um 11:05 schrieb Richard Hughes:
> On Thursday, 12 December 2024 at 19:01, Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>>>> Sadly fwupd/LVFS does not support executing arbitrary efi binaries/
>>>>>> nsh scripts which still is the main form ODMs provide bios updates.
> Of course fwupd can't do this; it would be a huge security hole as the nsh script isn't signed.
>
>> It sounds like some bugs in the implementation of the capsule handler
>> for this system.
> I've seen this with AmiFlash + BIOS.ROM, but never from a capsule. I'm pretty sure Aptio builder is more than capable of constructing a capsule file with the correct DMI data.

The DMI data also includes a serial number that cannot be baked into the 
capsule. And I don't have access to the Aptio builder or other AMI dev tools, 
just the Afu* flash tools.

The command provided by the ODM:

AfuEfix64.efi <bios>.bin /p /b /n /r /x /l /k /capsule

with <bios>.bin being a capsule and:

/p Program Main BIOS -- With recovery flash this does not include DMI strings, 
but does with capsule flash. -> Does flash some /k regions in /capsule flash 
(but not, for example, the logo region).
/b Program Boot Block
/n Programm NVRAM
/r Preserve ALL SMBIOS structure during programming
/x Don't check ROM ID
/l Programm all ROM Holes
/k Programm all non-critical Blocks -- No effect in /capsule flash, does include 
both the logo and the DMI string region.
/capsule Flash using the capsule update process (without it the bios is flashed 
directly by AfuEfix64.efi)

I played around with the command with the conclusion:

- AfuEfix64.efi <bios>.bin /p /capsule -> overwrites DMI strings
- AfuEfix64.efi <bios>.bin /p /r /capsule -> overwrites nothing

I also flashed with fwupd with the result:

- DMI strings where overwritten
- Main BIOS was flashed
- I don't know if Boot Block was flashed
- I don't know if NVRAM was flashed
- I don't know if ROM Holes were flashed
- I don't know if non-critical Blocks were flashed

I tried to explain fwupd and the requirements to our contact at the ODM, but 
just got the unhelpful reply to use the command above.

Do you know how these AfuEfix64.efi flags are passed over to the capsule flash 
process? Then it might be possible to implement them in fwupd too.

>
>> It's not an Insyde problem. I use Insyde capsules regularly myself from
>> fwupd. I also know several other OEMs that ship capsules to LVFS that
>> use Insyde.
> 100% agreed; Insyde firmware makes up more than 20% of the updates on the LVFS now.

Good to know. Sadly the ODM does not care :(.

To be fair all my work I described here is now 2 or 3 years old. I didn't start 
a second try since.

Kind regards,

Werner

>
> Richard.

