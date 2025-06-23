Return-Path: <linux-pci+bounces-30388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A3CAE40F3
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8453118872F9
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17385246BAC;
	Mon, 23 Jun 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M05T7r7m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3F3245023;
	Mon, 23 Jun 2025 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682756; cv=none; b=r/qZBTMVOI8aC52zGz9SXBYn+NLuCUjmMBCPupWFyjjVmRzmggJVbsVwn0wzubIzRvgnZErG+hCCK/I1p8Pb3VxIiqRiPXe0eHXBloFTgrV5zi4J55NAJHQUxFHBqXOGOmKKT6Jbukqba/cVr3e6VIQGwKyabf5UaRvYQrwfsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682756; c=relaxed/simple;
	bh=9DsE9pgH0OjJ0Mzzhwz4Z+mnCC9niQMJkihdpIBDL0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXIpspbB+K1cvt6m8uT8hvi5WGZoV15qTAoKjwYo0JxhWFtgJJ6Injb6PYnEWe19/QZVkz+MrPAKIX0PbC9Faa5Nnv4U+zz3Gc7aT3jtWbZP8xPlcsP1U+UAtZSNWs50ZqBdSATua2gFvIymsw3nG6Kt80p93pz0RNVm4TQZ+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M05T7r7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE24C4CEEA;
	Mon, 23 Jun 2025 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750682754;
	bh=9DsE9pgH0OjJ0Mzzhwz4Z+mnCC9niQMJkihdpIBDL0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M05T7r7mavmT+UvPHXVjlQhqT31sQt5wbhaMxzjFcZIU3mZhaJddruoqab6QxTw32
	 wy5XpXOITGcbg7wDs/BcjXo1IRM4BUUFfrJ7iNzz9AJ7CA4+NmlCXz9HRZITc0Xfz/
	 wjhvMsAO4kVjbDngriL1bB++M1KjkLQVzzyKvBBVBRFanV4IDx7yAe+2twpogWAhaE
	 6XB8OWRZtzIn/rJ2POQUK21Uph7nbpR7uyd3IQIh85bPuewZxbgGnuUBv8Y5oOXrtu
	 oPMRyN9ZvamesgV9CCZBVQRpbSHP1OQU4tDMWGz18wtkAH8yztzgJfNuk5s+TtOmXC
	 waE0GwyEJJqLw==
Message-ID: <0cb7ae0e-3bc6-434f-9c34-0995b83ffd02@kernel.org>
Date: Mon, 23 Jun 2025 07:45:52 -0500
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
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250620025535.3425049-3-superm1@kernel.org>
 <aFcCaw_IZr-JuUYY@wunner.de>
 <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>
 <aFeJ83O9PRUrM2Ir@wunner.de>
 <295bf182-7fed-4ffd-93a4-fb5ddf5f1bb4@kernel.org>
 <aFj3jUAM42lSyfpe@wunner.de> <aFkEI2jXg7YiwL7b@wunner.de>
 <aFkm8njX-NEIiTcv@wunner.de>
 <CAJZ5v0jfuAjhskbwG1XHByGpdgP1pSHwVSMnz3jcOy7VDyjnRQ@mail.gmail.com>
 <7dde3873-4239-4be8-801a-dcf37472664d@kernel.org>
 <aFlGPaITSa3IAB8s@wunner.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aFlGPaITSa3IAB8s@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/23/25 7:19 AM, Lukas Wunner wrote:
> On Mon, Jun 23, 2025 at 06:37:33AM -0500, Mario Limonciello wrote:
>> On 6/23/25 5:11 AM, Rafael J. Wysocki wrote:
>>> On Mon, Jun 23, 2025 at 12:05???PM Lukas Wunner <lukas@wunner.de> wrote:
>>>> On Mon, Jun 23, 2025 at 09:37:07AM +0200, Lukas Wunner wrote:
>>>>> On Mon, Jun 23, 2025 at 08:43:25AM +0200, Lukas Wunner wrote:
>>>>>> On Sun, Jun 22, 2025 at 01:39:26PM -0500, Mario Limonciello wrote:
>>>>>>> I did this check and yes specifically on this PCIe port with
>>>>>>> the underflow the d3 possible lookup returns false during
>>>>>>> pcie_portdrv_remove().  It returns true during
>>>>>>> pcie_portdrv_probe().
>>>>>>
>>>>>> That's not supposed to happen.  The expectation is that
>>>>>> pci_bridge_d3_possible() always returns the same value.
>>>>>
>>>>> I'm wondering if the patch below fixes the issue?
>>
>> Yes this works, thanks!
> 
> Could you still check what the value read from the Slot Capabilities
> register is in pciehp_is_native() (if the patch is not applied)?
> 
> I guess it must be something else than "all ones" and I'd like to
> understand why.
> 
> Thanks,
> 
> Lukas

At probe:
0x00240060

At remove:
0x00000000

