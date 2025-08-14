Return-Path: <linux-pci+bounces-34045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD858B26A5E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BAD5A02453
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D59D1E520B;
	Thu, 14 Aug 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ywh0rKA+"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D711D8E10;
	Thu, 14 Aug 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183142; cv=none; b=L45R8snJ2+IjCt+vEyeHHxdXAl9qPxZ1eleb73cJl/BtOaWdGbYPitfUBTpU/0dpughLUCJVx0FQqQfEK4jSomInp5dybvEzUI/TU8eAuP3e8dC3cr9gcXotH6ATpsPNnAGxl+32qgp0c22Nnhc9qIJUtnJEcwQzuJg7cyvAw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183142; c=relaxed/simple;
	bh=A/1Dx+EmXGmCUQMBqX5c4h2Fh46t8yiSdNxyKXOPqLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cb0Oc81l8fl8E1HU5rKxYtkNwVpI08TCTD9d2fnmdeazoQB+/sC/eLe49+n9nLtnuptkEZp5Upv86cJSDWXQ6wIYQzz5QLveo9H8vFh2zcJXHRcZZpoyQhfT+XadDrlUaL0ruunohkeHmgOpSma7SW9I8XFMl47sAbpEC3Y2oGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ywh0rKA+; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=yNBxAsOW8EbclsTwkaYfdFQhFlRaLddS/ekeHmhtBUE=;
	b=Ywh0rKA++bgZFaDeK2MD9ryc4ggoet6HezmoyjzYJenQydha8n6SmzTg6izXDs
	/NdHaoj+Vyl54Vp+PrAHPv+R4Pv/sTrUWOTqUHjr7hnfI7uj9nmuYe2uvfY/Ensv
	skIigoXiEH91WE8rGqUZFq1+7OpTUxewigsX+S6XVZOzY=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnH4zm951o0bLmBw--.49739S2;
	Thu, 14 Aug 2025 22:51:19 +0800 (CST)
Message-ID: <215953a5-658d-4cb2-ab02-57be3ac72697@163.com>
Date: Thu, 14 Aug 2025 22:51:18 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/6] Refactor capability search into common macros
To: Niklas Schnelle <schnelle@linux.ibm.com>, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, helgaas@kernel.org,
 jingoohan1@gmail.com, mani@kernel.org
Cc: robh@kernel.org, ilpo.jarvinen@linux.intel.com, gbayer@linux.ibm.com,
 lukas@wunner.de, arnd@kernel.org, geert@linux-m68k.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250813144529.303548-1-18255117159@163.com>
 <39e654cfcce848d57671cbd5d7038f2f9667789a.camel@linux.ibm.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <39e654cfcce848d57671cbd5d7038f2f9667789a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnH4zm951o0bLmBw--.49739S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary3CrW5urWxKr1DuF48WFg_yoW8tFyxpa
	4kA3ZIyayUJFy7C3Wvqa1IvFyYqF92y343J3s8G345XF9I9FyUXryftw4F9F9rGr4293WI
	vrW2qa48ZFn8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5nYwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxGpo2id9ecyeAAAst



On 2025/8/14 16:32, Niklas Schnelle wrote:
> On Wed, 2025-08-13 at 22:45 +0800, Hans Zhang wrote:
>> Dear Maintainers,
>>
>> This patch series addresses long-standing code duplication in PCI
>> capability discovery logic across the PCI core and controller drivers.
>> The existing implementation ties capability search to fully initialized
>> PCI device structures, limiting its usability during early controller
>> initialization phases where device/bus structures may not yet be
>> available.
>>
>> The primary goal is to decouple capability discovery from PCI device
>> dependencies by introducing a unified framework using config space
>> accessor-based macros. This enables:
>>
>> 1. Early Capability Discovery: Host controllers (e.g., Cadence, DWC)
>> can now perform capability searches during pre-initialization stages
>> using their native config accessors.
>>
>> 2. Code Consolidation: Common logic for standard and extended capability
>> searches is refactored into shared macros (`PCI_FIND_NEXT_CAP` and
>> `PCI_FIND_NEXT_EXT_CAP`), eliminating redundant implementations.
>>
>> 3. Safety and Maintainability: TTL checks are centralized within the
>> macros to prevent infinite loops, while hardcoded offsets in drivers
>> are replaced with dynamic discovery, reducing fragility.
>>
>> Key improvements include:
>> - Driver Conversions: DesignWare and Cadence drivers are migrated to
>>    use the new macros, removing device-specific assumptions and ensuring
>>    consistent error handling.
>>
>> - Enhanced Readability: Magic numbers are replaced with symbolic
>>    constants, and config space accessors are standardized for clarity.
>>
>> - Backward Compatibility: Existing PCI core behavior remains unchanged.
>>
>> ---
>> Dear Niklas and Gerd,
>>
>> Can you test this series of patches on the s390?
>>
>> Thank you very much.
> 
> Hi Hans, I gave this series a try on top of v6.17-rc1 on s390
> and a bunch of PCI devices including the mlx5 cards that Gerd we
> originally saw issues with. All looks well now. So feel free to
> add as appropriate:
> 
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 

Hi Niklas,

Thank you very much for your test. Let's see what others think.

Best regards,
Hans


