Return-Path: <linux-pci+bounces-30367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9ECAE3E1D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF31E3B62C5
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 11:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8512A2405EB;
	Mon, 23 Jun 2025 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WasCrCaZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959823C390;
	Mon, 23 Jun 2025 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678655; cv=none; b=IZuj2SgnzJYimBcYCEKeMsYULkqJ/G8WtiMkl3YLLpMkus8L6r0dqPTzFs69Pvkw5gfrlFzAJWG4kLZ2Xv8dmRL4P0b7SCEkfmfEH82DQ8yUEnL6AHaBqSomYDiVBFdmXf0G21foQB++moPC69r4EOs+RNr+MINmkZrIErCRe+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678655; c=relaxed/simple;
	bh=N3ZEnTEH+l7IJGIVTDFdKBNaCAZ76atFgLKs4FjLyvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDWzFeXzmW9A/ABzb6yUJWxhCyFmKGgo537WhMh8zmGBZavaHtZCSpMJnOJfUMjnCJV8of2j0TA8D3BngzqkDkB6/KfNg2aWA75UPATn1op7ZAQIt2nIKAVoLWNO3GHzwvcjcsiQighfs7diD+ccF5VYsakY/avH76Q6vE/GHnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WasCrCaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216DBC4CEEA;
	Mon, 23 Jun 2025 11:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750678654;
	bh=N3ZEnTEH+l7IJGIVTDFdKBNaCAZ76atFgLKs4FjLyvw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WasCrCaZYcTUiqoJ2P2N362Tx95aBV9Yxaeyl8dcOGO8zNnkRmemX+yZ7sW2McJew
	 3/x+2zj9hAkslcsEjaUykOzSQe1+5Zn4W9AwiwhY+LtfzdC+wbSVQXmPJdAUpcDxCq
	 C4w866mWJIgFE3r6mWZjCH0523WCuiRMouR8VqTxhdWyRL8Cv8zPMoDUaqVKBTd+w0
	 6KIcB3Cx1EnWcAL0rqEAZ58R7krXJiDXSD9e33tEBQMBNkSYznYiQHA8oW5skvTw9n
	 L8UJYWLnoR2fBVMuAd6kqq8HDi/TinywC5w1ifxutZgXMtq7HAhn/YNbqgMkOSF09d
	 1EjQAswioszKQ==
Message-ID: <7dde3873-4239-4be8-801a-dcf37472664d@kernel.org>
Date: Mon, 23 Jun 2025 06:37:33 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: Fix runtime PM usage count underflow on
 device unplug
To: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250620025535.3425049-1-superm1@kernel.org>
 <20250620025535.3425049-3-superm1@kernel.org> <aFcCaw_IZr-JuUYY@wunner.de>
 <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>
 <aFeJ83O9PRUrM2Ir@wunner.de>
 <295bf182-7fed-4ffd-93a4-fb5ddf5f1bb4@kernel.org>
 <aFj3jUAM42lSyfpe@wunner.de> <aFkEI2jXg7YiwL7b@wunner.de>
 <aFkm8njX-NEIiTcv@wunner.de>
 <CAJZ5v0jfuAjhskbwG1XHByGpdgP1pSHwVSMnz3jcOy7VDyjnRQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0jfuAjhskbwG1XHByGpdgP1pSHwVSMnz3jcOy7VDyjnRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/23/25 5:11 AM, Rafael J. Wysocki wrote:
> On Mon, Jun 23, 2025 at 12:05 PM Lukas Wunner <lukas@wunner.de> wrote:
>>
>> On Mon, Jun 23, 2025 at 09:37:07AM +0200, Lukas Wunner wrote:
>>> On Mon, Jun 23, 2025 at 08:43:25AM +0200, Lukas Wunner wrote:
>>>> On Sun, Jun 22, 2025 at 01:39:26PM -0500, Mario Limonciello wrote:
>>>>>>> On 6/21/25 2:05 PM, Lukas Wunner wrote:
>>>>>>>> So the refcount decrement happens in pcie_portdrv_probe() and
>>>>>>>> the refcount increment happens in pcie_portdrv_remove().
>>>>>>>> Both times it's conditional on pci_bridge_d3_possible().
>>>>>>>> Does that return a different value on probe versus remove?
>>>>>
>>>>> I did this check and yes specifically on this PCIe port with the underflow
>>>>> the d3 possible lookup returns false during pcie_portdrv_remove().  It
>>>>> returns true during pcie_portdrv_probe().
>>>>
>>>> That's not supposed to happen.  The expectation is that
>>>> pci_bridge_d3_possible() always returns the same value.
>>>
>>> I'm wondering if the patch below fixes the issue?
>>
>> Refined patch below with proper commit message,
>> also avoids a compiler warning caused by an unused variable.

Yes this works, thanks!

>>
>> -- >8 --
>>
>> From: Lukas Wunner <lukas@wunner.de>
>> Subject: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug capable
>>   ports
>>
>> pcie_portdrv_probe() and pcie_portdrv_remove() both call
>> pci_bridge_d3_possible() to determine whether to use runtime power
>> management.  The underlying assumption is that pci_bridge_d3_possible()
>> always returns the same value because otherwise a runtime PM reference
>> imbalance occurs.
>>
>> That assumption falls apart if the device is inaccessible on ->remove()
>> due to hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(),
>> which accesses Config Space to determine whether the device is Hot-Plug
>> Capable.   An inaccessible device generally returns "all ones" for such
>> Config Read Requests.  Hence the device may seem Hot-Plug Capable on
>> ->remove() even though it wasn't on ->probe().
>>
>> Use the cached copy of the Hot-Plug Capable bit to avoid the Config Space
>> access and the resulting runtime PM ref imbalance.
>>
>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> 
> LGTM
> 
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

Tested-by: Mario Limonciello <mario.limonciello@amd.com>>
>> ---
>>   drivers/pci/pci-acpi.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index b78e0e4..8859cce 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -816,13 +816,11 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
>>   bool pciehp_is_native(struct pci_dev *bridge)
>>   {
>>          const struct pci_host_bridge *host;
>> -       u32 slot_cap;
>>
>>          if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>>                  return false;
>>
>> -       pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
>> -       if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
>> +       if (!bridge->is_hotplug_bridge)
>>                  return false;
>>
>>          if (pcie_ports_native)
>> --
>> 2.47.2
>>
>>
> 


