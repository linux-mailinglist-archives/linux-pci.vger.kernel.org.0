Return-Path: <linux-pci+bounces-29223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFFFAD1E76
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 15:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD63188499A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 13:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7442571A2;
	Mon,  9 Jun 2025 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZvYuiHw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B3219EB;
	Mon,  9 Jun 2025 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749474339; cv=none; b=j7jACwvJ3xpGllpjVAZ8GARuBCduLe/nuPeG6Ea2/2nwnz9aUwAnlg1Q7JweP78Mu/0ET+nhHpBEWxQBWQCtSkY0RywG7ECfHxAYupl1FgxEXQOdvEBagoAjRYEI8a/dfcRJ/hPOf+W7cz0uMWomqIDp7s9RPsgciQvsJvXTTJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749474339; c=relaxed/simple;
	bh=W9d4gGhqmdjRGgPe3a3yXcLH/Le19acpI+RDsCAl7IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOSQkoGuFPpWtfcJkA/Ie/ol3t5hB3cF0fQ9Zj1FZZfiAvaqBZQLaBlGfeyoHh5D3vdYHWtmRL11+s/0igwCodGUoRNPxgb8qVUrrzOe/rGwpKUwhXvqkG1wXqXebxWZoduv4rXdkjTGlI/7pSuicoQfutHzI6Mzg/ai/JAQBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZvYuiHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F41C4CEEB;
	Mon,  9 Jun 2025 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749474338;
	bh=W9d4gGhqmdjRGgPe3a3yXcLH/Le19acpI+RDsCAl7IE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AZvYuiHw15bYABLU2Z8b+zmmn8K1WjQjPO8GZ3qAIqwcSwBkGgHUeR3i9RCFA7GuZ
	 El4hXmUF2UFmeIpjM2Wt98YRx2Pik0kMQwEimWlLvUN6fYAXq/w6ObHM+dFVIsmJsT
	 cb7Qa36FhKQccdM0RgImdzsA5PYWJAXMb+ptjm+5uDaQAZQ8TuyxjMbmmye7S4pTGg
	 seQUCid3aXuHWFYmZmxnE4tlP80nBd4j2PwjqIPyzSHvQr/IkEgcd12fhJrqDC++hK
	 l7qyKpnbR343Em6HNxqHyxuwoYj9w98kDP7iISzqtHeUuVBfnXTKdifb0nHeBqCHhf
	 vvNChfPsmvBQQ==
Message-ID: <18e93f06-ad5f-4335-8646-ce51cbdb783c@kernel.org>
Date: Mon, 9 Jun 2025 08:05:36 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Don't make noise about disconnected USB4 devices
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com,
 linux-pci@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250609020223.269407-1-superm1@kernel.org>
 <20250609111913.55153009@foxbook>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250609111913.55153009@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/9/2025 4:19 AM, Michał Pecio wrote:
> Hi,
> 
> General remarks:
> - broken threading on 1/2 and 2/2
> - some Cc missing on individual patch emails

Yeah; sorry about that.  I got bit by 
https://github.com/kworkflow/kworkflow/issues/1207 once again.  Once I 
realized that happened I figured unthreaded was better than missing so I 
ended off sending the missing ones to each of the lists that missed them.

If I send a v2 with them together again I'll just manually do to/cc for 
everything.

> 
> On Sun,  8 Jun 2025 20:58:00 -0500, Mario Limonciello wrote:
>> When a USB4 or TBT3 dock is disconnected a lot of warnings and errors
>> are emitted related to the PCIe tunnels and XHCI controllers in th
>> dock.
> 
> These patches will probably also trigger on any loss of PCIe link for
> any reason: badly seated card, worn connector, EMI, etc.
> 
> Will there be any remaining message about dead PCIe links, or just
> a silent disappearence? Like dev_info("USB disconnect ...") in USB.
> 

Good point on the PCIe patches with other failures.  Those wouldn't have 
any "hotplug event" though would they?  This all stems from the hotplug 
event, so would it be worth storing the state on the struct pci_dev to 
conditionally show these PCIe messages?

>> The messages are loud, but it's mostly because the functions that
>> emit the messages don't check whether the device is actually alive.
>> The PCIe hotplug services mark the device as perm dead, so that
>> can be used to hide some of the messsages.
>>
>> In the XHCI driver the device is marked as dying already, so that
>> can also be used to hide messages.
> 
> Are PCI drivers expected to stay silent on sudden removal mid operation?
> Is there no "safe ejection" procedure for those Thunderbolt devices?
> 

With docking surprise hot removal is a standard operation.
Userspace doesn't offer anything for a clean removal event of PCIe like 
USB storage does.

>> Mario Limonciello (4):
>>    PCI: Don't show errors on inaccessible PCI devices
>>    PCI: Fix runtime PM usage count underflow
>>    usb: xhci: Avoid showing errors during surprise removal
>>    usb: xhci: Avoid showing warnings for dying controller
> 
> Regards,
> Michal


