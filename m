Return-Path: <linux-pci+bounces-15390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3459B1499
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 06:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0615028363B
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 04:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DBC16DC28;
	Sat, 26 Oct 2024 04:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="QC4pep3h"
X-Original-To: linux-pci@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB16161326
	for <linux-pci@vger.kernel.org>; Sat, 26 Oct 2024 04:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729916373; cv=none; b=gEReb5+n4pxbp1znCXcNfCME0ymHK8bSqmgXiw8EmyEywPs/9PvXoXZ/IajY52X6l359sfgy3yBRzH74XdqtsCpJgUU3QIAOwuzsGVoXG9Gdmvh9/IAPoZ+thPfqvLZlcuNggHh6sX4NTw7RscRG2bqjQvfqwxrX4fxDn7o1rSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729916373; c=relaxed/simple;
	bh=fC97e1wJ6PsBGE9n522+YPXw1cMGRwuPINFWylcGqH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juBsSPmu4Q96OkrOIZwHgIoabUlQX/gOKfUUgDdLn5BQzzL+xADUZRVLr5RE5q8CeyUPspLToPiEkNvF8bujS8mlDfuBsBajE/LLRUxO0BeRT72Oab/t4OAkGn60rbu338sw6BfsKKZpMvcAqaQ5w0Q+q19ThU817okGgQYpBW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=QC4pep3h; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 271EE88E5C;
	Sat, 26 Oct 2024 06:19:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729916369;
	bh=mTHMtI4z8VRI2EKYTQ2CtcEKE4We89qKwusc7KQb0mY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QC4pep3h8UFrp7+lJehDkHJaa7ZeEsbCFfFg3SkI6L/KDyY4MWKLQGtGwfNI6LEo7
	 RfwvDPThFd1hVbM+7OepQYURPgwDsRyv8p6CEp6xV88mTOOEcrHqYryUhbz+tVuBl5
	 eUbfANXC5YBuMD5cryMnWZDOWapd8QwtBkOFE2EzaBcU74aLNToPGNw2h8aQ7PTPGS
	 hjC6phllpqzrUNRlwURYhevcIvKmFOIVVqOIzQjz8V7vn0393EizkcnjwRJyh7l2xL
	 FFcBBGfdmKmYgKRb8Lif+cYBJuWJ04fv6p7X7WKEwAOajlegmDu4X4k+OC117Pj7co
	 hu0spSix4nZRw==
Message-ID: <52b90ab1-2759-45e9-ae86-3d3073a0add0@denx.de>
Date: Sat, 26 Oct 2024 02:19:21 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] PCI/PM: Do not RPM suspend devices without drivers
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20241012004857.218874-1-marex@denx.de>
 <ZwupHAAwTo5mDyyA@wunner.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZwupHAAwTo5mDyyA@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/13/24 1:03 PM, Lukas Wunner wrote:
> On Sat, Oct 12, 2024 at 02:48:48AM +0200, Marek Vasut wrote:
>> The pci_host_probe() does reallocate BARs for devices which start up with
>> uninitialized BAR addresses set to 0 by calling pci_bus_assign_resources(),
>> which updates the device config space content.
>>
>> At the same time, pci_pm_runtime_suspend() triggers pci_save_state() for
>> all devices which do not have drivers assigned to them to store current
>> content of their config space registers.
> [...]
>> Work around the issue by not suspending pci_bus_type devices which do
>> not have driver assigned to them, keep those devices active to prevent
>> pci_save_state() from being called. Once a proper driver takes over, it
>> can RPM manage the device correctly.
> 
> It sounds like you may want to acquire a runtime PM reference
> or disable runtime PM for the duration of the bus scan (or at
> least device scan) rather than the proposed workaround.
I was hoping to get at least an confirmation that this issue really 
exists and that I'm not chasing some nonsense. Thoughts ?

