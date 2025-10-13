Return-Path: <linux-pci+bounces-37980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1DABD63FA
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 22:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13291882C35
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 20:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B3421CFF7;
	Mon, 13 Oct 2025 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZBuPTvl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646241CAA92
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388530; cv=none; b=MiyHe+RlzomlOhUX3vfVdaHQFB6Bczsgw5rWrkU4EGC/IWeP9ayXrYDfZdGqfzsSS8wmilZY2zPW72hUlcP3aUmFOYwpSKjO0jGfOCwDa0LcoEYYonLA8906EWJ4sbddxxaF2ktcn/KBFX2sN9ydWEass9JbAljb8nMjkhAXTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388530; c=relaxed/simple;
	bh=pyDPp24I/7VnQHW/ZQI+4Jc0hftTq8BmO+KF8SAV8So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=API8miOZDA/dqmexfSBLSg96ZavMj7GurhZHGsbBzx7yWGx6xl5pXbY2YTPaMbjyyJzwfcqnl3k8HjtO1HabMrQsRSAfYZn/xnlsfAi6RfXVYpMq9KhObjkmEHR+VwF/NdpDaotnX6LqsG3aSOqSzlCuKoRCkABs+sWnyubdbyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZBuPTvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E995C4CEE7;
	Mon, 13 Oct 2025 20:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760388529;
	bh=pyDPp24I/7VnQHW/ZQI+4Jc0hftTq8BmO+KF8SAV8So=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eZBuPTvl7YK4vTzMT/FOV4DzPCgnGAazEQO31/oop7F6AJnDtk751tIXunUVBPN/u
	 0Eoxd33JeK5nRYvYyz7HtAhS/h0GeQrl1rTo9EAQH63K/p17zVbb61nEA6V7tv09CP
	 qdky9xyxdvO2KusAXjqJ/QsZdK5h9ybhI7ENU+jw74hEZDxUsTn7FIjUxGW9yFK+9T
	 fvBUh0NekZXxsIZPgczjbWTTLobItormEzzdyAYpGVSwJmDYCUD/EAXqpEx/VPacAf
	 dWk/9UKQjQbC+BA6F22Be2wRlylfV4tIRpSIwToLQqMkSbhnmOYvc2pY97yVyxTCvl
	 E/u+nNsaSL5Gg==
Message-ID: <6bb7a607-174d-4914-9452-fe0e36be9e2e@kernel.org>
Date: Mon, 13 Oct 2025 15:48:48 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/VGA: Select SCREEN_INFO
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, tzimmermann@suse.de,
 Eric Biggers <ebiggers@kernel.org>, linux-pci@vger.kernel.org
References: <20251013204738.GA863114@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251013204738.GA863114@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 3:47 PM, Bjorn Helgaas wrote:
> On Mon, Oct 13, 2025 at 12:55:25PM -0500, Bjorn Helgaas wrote:
>> On Mon, Oct 13, 2025 at 10:44:23AM -0500, Mario Limonciello (AMD) wrote:
>>> commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
>>> a screen info check") introduced an implicit dependency upon SCREEN_INFO
>>> by removing the open coded implementation.
>>>
>>> If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default()
>>> would now return false.  Add a select for SCREEN_INFO to ensure that the
>>> VGA arbiter works as intended. Also drop the now dead code.
>>>
>>> Reported-by: Eric Biggers <ebiggers@kernel.org>
>>> Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
>>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>
>> Applied to for-linus for v6.18, thanks!
> 
> Oops, dropped because of this regression:
> 
>    https://lore.kernel.org/r/176038554347.1442.9483731885505420131@15dd6324cc71

Ah thanks for that.  I hadn't had non-x86 to test.

I'll try to cross compile to repro and come up with a solution.

> 
>>> ---
>>> v2:
>>>   * drop dead code (Ilpo)
>>> ---
>>>   drivers/pci/Kconfig  | 1 +
>>>   drivers/pci/vgaarb.c | 8 +-------
>>>   2 files changed, 2 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>> index 7065a8e5f9b14..c35fed47addd5 100644
>>> --- a/drivers/pci/Kconfig
>>> +++ b/drivers/pci/Kconfig
>>> @@ -306,6 +306,7 @@ config VGA_ARB
>>>   	bool "VGA Arbitration" if EXPERT
>>>   	default y
>>>   	depends on (PCI && !S390)
>>> +	select SCREEN_INFO
>>>   	help
>>>   	  Some "legacy" VGA devices implemented on PCI typically have the same
>>>   	  hard-decoded addresses as they did on ISA. When multiple PCI devices
>>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>>> index b58f94ee48916..8c8c420ff5b55 100644
>>> --- a/drivers/pci/vgaarb.c
>>> +++ b/drivers/pci/vgaarb.c
>>> @@ -556,13 +556,7 @@ EXPORT_SYMBOL(vga_put);
>>>   
>>>   static bool vga_is_firmware_default(struct pci_dev *pdev)
>>>   {
>>> -#ifdef CONFIG_SCREEN_INFO
>>> -	struct screen_info *si = &screen_info;
>>> -
>>> -	return pdev == screen_info_pci_dev(si);
>>> -#else
>>> -	return false;
>>> -#endif
>>> +	return pdev == screen_info_pci_dev(&screen_info);
>>>   }
>>>   
>>>   static bool vga_arb_integrated_gpu(struct device *dev)
>>> -- 
>>> 2.43.0
>>>


