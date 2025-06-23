Return-Path: <linux-pci+bounces-30435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63941AE4BC3
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 19:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809413BAEDC
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0727F299A90;
	Mon, 23 Jun 2025 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6n0L4FS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E923C17;
	Mon, 23 Jun 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699551; cv=none; b=DLRNTv8VS0Ds/Iuusfy7gYyZ1WZna/OYbehQqHN9M1LM2zJQcp072xRQ4ABdjTBgVldWS2lDSJEZY5rDHv98ntHVUwy0H9FN98D9CyP08y8jNS/z7tc2yRZtdm0yJqJw/OxDRf3dU598ZhB/0P1PtRqB3LYYf9K7/qsMn5iJN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699551; c=relaxed/simple;
	bh=GugnWEZDn4gyyGnQXDDxiJ3GDbZJazyD/R97Kq8EciE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBTmRS8d9J5GNQh9T1qRNIFNj+5paoSqdYIkDlxK4xVu9SbL0A8nkJcsN66ImU+RrFLWoD19HM6rOMWeywtzRdSMQPLdxDAX0xK/43wBDUgb7CDYRToXhcImKxttgUaC89jhMmoag9Z1kvjApWxLDDjPcIaJ/5JU0Z6egzw2Dc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6n0L4FS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA91C4CEEA;
	Mon, 23 Jun 2025 17:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750699551;
	bh=GugnWEZDn4gyyGnQXDDxiJ3GDbZJazyD/R97Kq8EciE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z6n0L4FSQHZAoNOIO4jg+4+Po2etjK1Ohm8lesdhSQZLwqb6onT9eqasAGJy57go2
	 qpnqBDlucunZBkXv24Ub0mb74YxerNsZ9EKrwAmunZJIBLwCWKLkXiiQX0xO9m75IB
	 MHOhI9yYGhXERSCz+Slf392GusYhQTbYpPZEgiizmMQXT7WZuVKmllFypPDdbPqewP
	 y0U4s7WEDArCQK4S31QyRATJZoo8FLBW011plBrFUbHPZK6Ya3cV38kkCMvP0JHJ5A
	 lwJxwpI6N0YoA91kwd2O54AaIhwfWg7FkyCk1fhe/3pxTwEzWPo64osv5war/1J7xD
	 VUmT87rzx43iw==
Message-ID: <4a302594-9ab6-44dd-b851-34cb564f4081@kernel.org>
Date: Mon, 23 Jun 2025 12:25:49 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: Fix runtime PM usage count underflow on
 device unplug
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mika Westerberg <westeri@kernel.org>
References: <20250620025535.3425049-3-superm1@kernel.org>
 <aFcCaw_IZr-JuUYY@wunner.de>
 <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>
 <aFeJ83O9PRUrM2Ir@wunner.de>
 <295bf182-7fed-4ffd-93a4-fb5ddf5f1bb4@kernel.org>
 <aFj3jUAM42lSyfpe@wunner.de> <aFkEI2jXg7YiwL7b@wunner.de>
 <aFkm8njX-NEIiTcv@wunner.de>
 <CAJZ5v0jfuAjhskbwG1XHByGpdgP1pSHwVSMnz3jcOy7VDyjnRQ@mail.gmail.com>
 <7dde3873-4239-4be8-801a-dcf37472664d@kernel.org>
 <aFmNfkIWaIA1mq52@wunner.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aFmNfkIWaIA1mq52@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 12:23 PM, Lukas Wunner wrote:
> [cc += Mika]
> 
> On Mon, Jun 23, 2025 at 06:37:33AM -0500, Mario Limonciello wrote:
>> On 6/23/25 5:11 AM, Rafael J. Wysocki wrote:
>>> On Mon, Jun 23, 2025 at 12:05 PM Lukas Wunner <lukas@wunner.de> wrote:
>>>> pcie_portdrv_probe() and pcie_portdrv_remove() both call
>>>> pci_bridge_d3_possible() to determine whether to use runtime power
>>>> management.  The underlying assumption is that pci_bridge_d3_possible()
>>>> always returns the same value because otherwise a runtime PM reference
>>>> imbalance occurs.
>>>>
>>>> That assumption falls apart if the device is inaccessible on ->remove()
>>>> due to hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(),
>>>> which accesses Config Space to determine whether the device is Hot-Plug
>>>> Capable.   An inaccessible device generally returns "all ones" for such
>>>> Config Read Requests.  Hence the device may seem Hot-Plug Capable on
>>>> ->remove() even though it wasn't on ->probe().
>>>>
>>>> Use the cached copy of the Hot-Plug Capable bit to avoid the Config Space
>>>> access and the resulting runtime PM ref imbalance.
>>>>
>>>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
>>>
>>> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
>>
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>>
> 
> I ended up changing the patch significantly, so I did not include
> Rafael's Reviewed-by and Mario's Tested-by in the final patch.
> My apologies for this!
> 
> Looking at the commit which introduced the Config Space read,
> 5352a44a561d, I got the impression that Mika may have deliberately
> avoided using the is_hotplug_bridge flag.  Notably, is_hotplug_bridge
> is also set by check_hotplug_bridge() in acpiphp_glue.c, and his
> intention was probably to avoid matching those bridges in
> pciehp_is_native().
> 
> So I decided to err on the side of caution and keep the Config Space
> read if pciehp_is_native() is called from hotplug_is_native().
> Just to avoid any potential regressions since the fix is tagged for
> stable.
> 
> I also searched lore for occurrences of the keywords...
> 
>    pcieport Runtime PM usage count underflow
> 
> ...and did find quite a few reports, but this error message was just
> a side effect and the reports were about completely different issues.
> It does prove though that this bug has existed for a while!
> 
> Thanks Laurent for the report and Mario for root-causing this!
> 
> Lukas

Thanks Lukas!

I still do think my patch 1/2 in this series makes sense though, can you 
review that separately?

