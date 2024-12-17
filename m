Return-Path: <linux-pci+bounces-18602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC029F4A76
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 12:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9BE1890EB8
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 11:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E85E1F12E2;
	Tue, 17 Dec 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="jhT86YjT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C21C1F03D5;
	Tue, 17 Dec 2024 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436706; cv=none; b=RJtMKb6AGY+0Wna6mhgzGVBGfj+P4S10IfKOTeluNT9Is7/d0wtLQtC0l5Ab+U5JX6umd05/lc/3ypEtx9YkGh3OC6rnfrEmSPBKKyRj/0Z3QLB9VytXtcjLsOgkWeFEkgWGZ5BR099s/d55Eg5iwCnkladKa4rx97k8Hc+RMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436706; c=relaxed/simple;
	bh=sNB0/mopqWBZrWkYm91RwbMAPkpal76ZKCSo7HLHqnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+ByyaGXckoBea4g2QleDAt9K2M4E/gs3PJ8YYY/7LIfipidrlRlAWATSnweTX8AaEpWNdH9CyLN6GhTHkZZI6ONGc1/7lnc4hwChtX+8Lb2CMCADAW2OXZSZcikO/wG1yoflpKQ6eMA3rmfYf3LT5TfoO+KKlY1mjtXW4uC6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=jhT86YjT; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5de4533f.dip0.t-ipconnect.de [93.228.83.63])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id DAF762FC0055;
	Tue, 17 Dec 2024 12:58:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1734436699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hg/CBHPS+TFSiHbxKKcff+TrS4vY7EHmmOIQMsntDq4=;
	b=jhT86YjTGE00qCaRxlZcGCa8j3XP/trcX9H7c63TkHsqMQNYXjJKBM1BYZmFYB3EIhFF17
	8hw42a8MHcpSvBHxD3RnB0QoeIrNOV5/aNFwwHt0b2DBUWGXVEMCA3aWDnxaRs5A34lmrb
	sh/y0cvqLbH4eSnZSj2J2ch6PZGPCVc=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <6c5eb555-4642-42ef-8e4d-9c0c61292ba8@tuxedocomputers.com>
Date: Tue, 17 Dec 2024 12:58:18 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
To: Richard Hughes <richard@hughsie.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
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
 <2b762f16-fe50-4dec-8f3f-dfe21977d807@tuxedocomputers.com>
 <C9ewaxwQKbro-b58prMr4pYnBsbGXBokgIk3OMYfT2OTCUPqSKeabS2ED02pN44ukBu88wjq1JCzyc4Rb9KHK5qce8L1WufgA27O3NKmTvA=@hughsie.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <C9ewaxwQKbro-b58prMr4pYnBsbGXBokgIk3OMYfT2OTCUPqSKeabS2ED02pN44ukBu88wjq1JCzyc4Rb9KHK5qce8L1WufgA27O3NKmTvA=@hughsie.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 17.12.24 um 11:10 schrieb Richard Hughes:
> On Monday, 16 December 2024 at 23:37, Werner Sembach <wse@tuxedocomputers.com> wrote:
>> - AfuEfix64.efi <bios>.bin /p /r /capsule -> overwrites nothing
>> I tried to explain fwupd and the requirements to our contact at the ODM, but
>> just got the unhelpful reply to use the command above.
> Can you name the ODM? I think essentially all the ODMs are uploading [valid] capsules to the LVFS now. If it helps, it's the same capsule needed for the LVFS as for the Microsoft WU (Windows Update) process and all ODMs should be intimately familiar with those requirements.

In this case it was a Tonfang/Uniwill barebone and I talked to a Tongfang 
representative.

Want to point out again that I could determine that /k did do nothing in the 
/capsule mode while /p and /r did effect the flash (iirc /p was required for 
/capsule or the flash didn't start). I could not determine if /b /n and /l did 
something (and probably can't without proper documentation, which I don't have 
access to). I guess /x is irrelevant as long as the flash works.

Do you have a Microsoft help page for OEMs about BIOS and EC upgrades via 
Windows Update? Having some Windows requirements to point to often helps when 
talking with ODMs in my experience.

>   
>> Do you know how these AfuEfix64.efi flags are passed over to the capsule flash
>> process? Then it might be possible to implement them in fwupd too.
> The capsule, as expected by LVFS and WU, is actually a single *signed* binary that contains the flasher binary and the payload all wrapped up into one. The only time I've seen AfuEfix64.efi in use is for the system preload, as done in the factory.
Yeah but since at least the /r flag influences the flash process there must be 
some way the efi shell can pass on options to the flasher included in the 
capsule ... EFI variables? Some bits appended to the capsule?
>
> Richard.
>

