Return-Path: <linux-pci+bounces-24190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1F9A69DC2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 02:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169E916B33C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 01:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601D31BD517;
	Thu, 20 Mar 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZBsYgzSj"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E9F17991
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742435401; cv=none; b=nxrTQg7jKb8l3y27j06nPC/uAz3d0v00BGGxPktkJ+BLxggDvihyi48AA/Hvfn5Uy75F4dgeQ8AcZXg+D68S9VY/BqD7w89iUYEu16luqLPANW9K0mt5ngu6qN9/eIPlACX3jinBoLG4fDP2k/t9LtNd4zXN9K8PZZ9cMrQWDj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742435401; c=relaxed/simple;
	bh=vJabVz+Qi89oZhON7zsyD78m7L7w+iI7vfC28PvLN/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSIlmoKBhdhFWlmiFv5IfqpjWaMHAJEeXZPmJRr6hRqhTr60KIyYB3Pq6Fin29AO1lAqDTWpiaZn6xZSJeBz1ZQ+b9zT51PSrFIYznJg38s2/As4VfcJ6/3iCkW2tcjNFb88BigRky8mBGw6FA1+IQ56v+C+319a9C0mq5Ivi38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZBsYgzSj; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=WqgdMH8bqebdyfiETXisRahv5bZl2bgwUenNhpSP83o=;
	b=ZBsYgzSjuN/YVPqlc7AY/rzRNLSXwUBh8mEckmg7VFI0tiNs2yllYj2z3IxwLE
	rkZei9BNFOFwwaW766B4n83LaIrchN/nyFkthAdiRUg9xMKoSdxEsWAMVd81zWzz
	SgJzI/UyTARGXUMdpVuEqFPgSlqad/5C9O87fxyZdM8CU=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnDyIzdNtnNSlUAg--.27401S2;
	Thu, 20 Mar 2025 09:49:40 +0800 (CST)
Message-ID: <bf87661f-6b18-4882-8b9f-bc419363d172@163.com>
Date: Thu, 20 Mar 2025 09:49:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Query Regarding PCI Configuration Space Mapping and BAR
 Programming
To: Bjorn Helgaas <helgaas@kernel.org>, Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-pci@vger.kernel.org
References: <20250319191542.GA1053142@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250319191542.GA1053142@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnDyIzdNtnNSlUAg--.27401S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF47GF1DXr1fKFW3JFy7Jrb_yoW8tw4rpF
	WYqFyUKr4kJF1rtw4vga92gayUGan3C3yUZryYywn0krn8uFyxCr4DCa43Ja4UJr1DZ3W0
	qFW0qFyqga4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zid-PUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwAWo2fbdCUCMwAAsy



On 2025/3/20 03:15, Bjorn Helgaas wrote:
> EXTERNAL EMAIL
> 
> On Wed, Mar 19, 2025 at 11:27:07PM +0530, Muni Sekhar wrote:
>> Dear Linux-PCI Maintainers,
>>
>> I have a few questions regarding PCI configuration space and Base
>> Address Register (BAR) programming:
>>
>> PCI Configuration Space Mapping:
>> PCI devices have standard registers (Device ID, Vendor ID, Status,
>> Command, etc.) in their configuration space.
>> These registers are mapped to memory locations.
> 
> In general, config registers are not mapped to memory locations.
> 

Yes, this is just a segment of the address visible to the CPU, not the 
actual memory.

Best regards,
Hans

> Some systems use the ECAM mechanism for config access, which is
> basically memory-mapped I/O that converts CPU memory accesses to PCI
> config accesses.  This mechanism is hidden inside the Linux config
> accessors (pci_read_config_word(), etc), and drivers should not use
> ECAM directly.
> 
>> How can we determine
>> the exact memory location where these configuration space registers
>> are mapped?
> 
> Drivers use pci_read_config_word() and similar interfaces to access
> config registers.  Userspace can use the setpci utility.
> 
>> Base Address Registers (BARs) Programming:
>> How are BAR registers programmed, and what ensures they do not
>> conflict with other devices mapped memory in the system?
>> If a BAR mapping clashes with another device’s memory range, how does
>> the system handle this?
>>
>> Does the BIOS/firmware allocate BAR addresses, or does the OS have a
>> role in reconfiguring them during device initialization?
> 
> On x86 systems, the BIOS generally assigns BAR addresses.  Linux
> doesn't change these unless they are invalid.  Some firmware does not
> assign BARs, and generally firmware does not assign BARs for hot-added
> devices.  In those cases, Linux assigns them.
> 
> If Linux notices a conflict, it tries to reassign BARs to avoid the
> conflict.
> 
>> If you could provide any source code references from the Linux kernel
>> that handle these aspects, it would be greatly appreciated.
> 
> Here's the function that reads BARs when Linux enumerates a device:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/probe.c?id=v6.13#n176
> 


