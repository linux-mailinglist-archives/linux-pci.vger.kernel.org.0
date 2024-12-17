Return-Path: <linux-pci+bounces-18649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BDE9F5076
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E511888A4E
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA48D1FC7EC;
	Tue, 17 Dec 2024 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="F6qiXHl1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5421D1FC7E0;
	Tue, 17 Dec 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451130; cv=none; b=VaFi2TUYaouO6kyJ4BYnDDTuAev/hnXIxxyu4URcbEi9/hU+ch54YYJ7wblXP0hwgwDypXqYqdXYyZXPvVQ7aVszO+/RAy3LLnDpRU09XWm0aMtynoyUhAllgVxEtqrGRrwSO7VGxMnZbdZo/IEY1e1brLZUIgCmPVtNyr4oi48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451130; c=relaxed/simple;
	bh=g7AMDJkTw7BxKeivuzpxUA1diySyBp+hk0KgUQrCSzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oz8eQSOpkdFmUwUrflvpUBbsAkZ41VK1EbGFswYtgFFnvFxtHQoVfY1dviTZ6Rv8Sx0chEITx9d7QBqkl63BYAyNJzZ2NzIM1yM5wPMdnzItD4hTC9iDpT6xMFghweIr0GARjsGlfxxrdUzNOcBg1jJZbEaYZ+84cfUvRoV9FxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=F6qiXHl1; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5de4533f.dip0.t-ipconnect.de [93.228.83.63])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id A50762FC0055;
	Tue, 17 Dec 2024 16:58:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1734451120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79SZt7lkJkRX29XZfbWou0Bi23zCf6f0o7evxNOXn14=;
	b=F6qiXHl1R7ewBrVr16JBs0vNhPSpuXx34PCKa4QEiDNYfQ+PX2oA7PKKMvDzMfGmpjkb0l
	pjuMJqk48qwTMqDFrkHwzPqHZsYQkT/0TfByuNA4Rt0xOJ+0w9C5yxNJicIINBVRPjlk6C
	WWEXxJv/ba9MEk8iO7IvZjOjZFR+brE=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <7a9353d3-b9db-4499-a054-c7050bc7b4d5@tuxedocomputers.com>
Date: Tue, 17 Dec 2024 16:58:39 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ggo@tuxedocomputers.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209193614.535940-1-wse@tuxedocomputers.com>
 <215cd12e-6327-4aa6-ac93-eac2388e7dab@amd.com>
 <23c6140b-946e-4c63-bba4-a7be77211948@tuxedocomputers.com>
 <823c393d-49f6-402b-ae8b-38ff44aeabc4@amd.com>
 <2b38ea7b-d50e-4070-80b6-65a66d460152@tuxedocomputers.com>
 <e0ee3415-4670-4c0c-897a-d5f70e0f65eb@amd.com>
 <90631333-fda0-42cf-9e32-8289c353549f@tuxedocomputers.com>
 <4dac3ff2-e3ab-42c0-b39f-379d5badca42@amd.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <4dac3ff2-e3ab-42c0-b39f-379d5badca42@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 17.12.24 um 15:11 schrieb Mario Limonciello:
> On 12/17/2024 08:07, Werner Sembach wrote:
>
>>> '''
>>> Platform may hang resuming.  Upgrade your firmware or add pcie_port_pm=off 
>>> to kernel command line if you have problems
>>> '''
>> Yes, full log attached (kernel 6.13-rc3 one time without sudo one time with 
>> sudo)
>
> Yes; I see it in your log.
>
>>> "quirk: disabling D3cold for suspend"
>> On the fixed BIOS I see that line. On the unfixed BIOS it aborts the 
>> functions at "if (pm_suspend_target_state == PM_SUSPEND_ON)". Skipping the 
>> check on the unfixed BIOS it still hangs on resume.
>>>
>>> I'm /suspecting/ you do see it, but you're having problems with another root 
>>> port.
>>>
>>> I mentioned this in my previous iterations of patches that eventually landed 
>>> on that quirk, but Windows and Linux handle root ports differently at 
>>> suspend time and that could be why it's exposing your BIOS bug.
>>>
>>> If you can please narrow down which root ports actually need the quirk for 
>>> your side (feel free to do a similar style to 7d08f21f8c630) I think we 
>>> could land on something more narrow and upstreamable.
>>>
>>> At a minimum what you're doing today is covering both Rembrandt and Phoenix 
>>> and it should only apply to Phoenix.
>>
>> I also try to find out how many devices where actually shipped with this very 
>> first BIOS version.
>
> OK.

Ok found out that the initial bios actually works, then there is one in between 
bios where it doesn't and the next one it works again.

So i need to find out if the the in between bios was actually shipped, if not, 
this issue is actually void.


