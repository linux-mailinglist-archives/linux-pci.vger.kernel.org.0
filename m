Return-Path: <linux-pci+bounces-25484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F18A8069F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 14:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8793464ECD
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 12:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F2626A0C2;
	Tue,  8 Apr 2025 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Tc41mAAb"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316826A0A2;
	Tue,  8 Apr 2025 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114823; cv=none; b=Y0n6q4fZFcwiImhMGFNmwaRN83M8CozN4DygCh1yNSZNkWIaKEoXYBrN4RNnKxljIyZFjfPOnjpc9XuD7r1sfG9Z0pSEZ4g/323zME+APb6W6IMg2oHATqesLt/7bZRrZWo9NOSNswADtNmWviZtigM2tUGaxHCCMDntea0wYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114823; c=relaxed/simple;
	bh=xkgWSbBzdqqLXJy/39XzllAyrbjhTZ9l7lh68zk2T00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjALT6BIdRkq5kIaompW1akgJJx78anwxrnD0srJvslZv31/AYe5e4V7/apKsCRcqZUUbxIc3olfgjXr8S6zO2N7KsCxgevfIGvhx4OBUZcOxtDikAn1nJf30oP6ggsvDyAx940RKyitcGAp9ZEB3jXcRLQvDVBBVN8P+PFl97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Tc41mAAb; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=M/mRRxi/pJ+TRogyDsxVwnB/JJd9QGzb3vycIpfmcbo=;
	b=Tc41mAAbRkRgHeL6snbQwChEiCMd7YP8aXStUYoaUzlZVJTThOAj2ljJvDDjn5
	lhpMuRB+B8f684beHh328eIfo9sqDZObLr/P87vRPP2Q0cHkNlLVdhbO7O3WY9o9
	YrIxKj8bWu+QRW+h3BfjkmNjEQV/ykRXyGIBmtSwYlr9A=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3n81dFPVnaTsKFA--.34605S2;
	Tue, 08 Apr 2025 20:19:44 +0800 (CST)
Message-ID: <ef311715-3e61-4bf5-bdae-58fd87a3d5e7@163.com>
Date: Tue, 8 Apr 2025 20:19:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v7 2/5] PCI: Refactor capability search functions to eliminate
 code duplication
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250402042020.48681-1-18255117159@163.com>
 <20250402042020.48681-3-18255117159@163.com>
 <8b693bfc-73e0-2956-2ba3-1bfd639660b6@linux.intel.com>
 <c6706073-86b0-445a-b39f-993ac9b054fa@163.com>
 <bf6f0acb-9c48-05de-6d6d-efb0236e2d30@linux.intel.com>
 <f77f60a0-72d2-4a9c-864e-bd8c4ea8a514@163.com>
 <ef0237d9-f5da-44d7-ab45-2be037cf0f25@163.com>
 <3689b121-1ff2-f0f6-59f4-293cda8ea6a8@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <3689b121-1ff2-f0f6-59f4-293cda8ea6a8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n81dFPVnaTsKFA--.34605S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr4UKrWxCrWkKrWDAw4DCFg_yoW5uFW5pF
	WfAa1akr1kGr43C3ZxXw40qFyYqws7Ar4UWry3Gw1FqF1DCF9xtry8t3WrAF9rGrW2y3W2
	qrWaqa4UGF15CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULzV8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhUpo2f1EJlU0wABs4



On 2025/4/8 01:03, Ilpo Järvinen wrote:
>> Hi Ilpo,
>>
>> The [v9 3/6]patch I plan to submit is as follows, please review it.
>>
>>  From 6da415d130e76b57ecf401f14bf0b66f20407839 Mon Sep 17 00:00:00 2001
>> From: Hans Zhang<18255117159@163.com>
>> Date: Fri, 4 Apr 2025 00:20:29 +0800
>> Subject: [v9 3/6] PCI: Refactor capability search into common macros
>>
>> - Capability search is done both in PCI core and some controller drivers.
>> - PCI core's cap search func requires PCI device and bus structs exist.
>> - Controller drivers cannot use PCI core's cap search func as they
>>    need to find capabilities before they instantiated the PCI device & bus
>>    structs.
>>
>> - Move capability search into a macro so it can be reused where normal
>>    PCI config space accessors cannot yet be used due to lack of the
>>    instantiated PCI dev.
>> - Instead, give the config space reading function as an argument to the
>>    new macro.
>> - Convert PCI core to use the new macro.
> None of these bullets are true lists so please write them as normal
> English paragraphs. Also please extend some of shortened words lke "cap"
> --> "Capability", "PCI dev" -> PCI Device (for terms, the capitalization
> of the first letter, you should follow what the PCI specs use).
> 

Dear Ilpo,

Thank you very much for your reply. Is it OK to modify it like this?

The PCI Capability search functionality is duplicated across the PCI 
core and several controller drivers.  The core's current implementation
requires fully initialized PCI device and bus structures, which prevents
controller drivers from using it during early initialization phases 
before these structures are available.

Move the Capability search logic into a header-based macro that accepts 
a config space accessor function as an argument.  This enables 
controller drivers to perform Capability discovery using their early 
access mechanisms prior to full device initialization while maintaining 
the original search behavior.

Convert the existing PCI core Capability search implementation to use 
this new macro, eliminating code duplication. The refactoring preserves 
the original functionality without behavioral changes, while allowing 
both the core and drivers to share common Capability discovery logic.

Best regards,
Hans

>> The macros now implement, parameterized by the config access method. The
>> PCI core functions are converted to utilize these macros with the standard
>> pci_bus_read_config accessors. Controller drivers can later use the same
>> macros with their early access mechanisms while maintaining the existing
>> protection against infinite loops through preserved TTL checks.
>>
>> The ttl parameter was originally an additional safeguard to prevent
>> infinite loops in corrupted config space.  However, the
>> PCI_FIND_NEXT_CAP_TTL macro already enforces a TTL limit internally.
>> Removing redundant ttl handling simplifies the interface while maintaining
>> the safety guarantee. This aligns with the macro's design intent of
>> encapsulating TTL management.
>>
>> Signed-off-by: Hans Zhang<18255117159@163.com>
>> ---
>>   drivers/pci/pci.c | 70 +++++---------------------------------
>>   drivers/pci/pci.h | 86 +++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 95 insertions(+), 61 deletions(-)


