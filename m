Return-Path: <linux-pci+bounces-27049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDA4AA50C7
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 17:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC03173BD6
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C425D2DC760;
	Wed, 30 Apr 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iNpPjjLD"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EB52609EC;
	Wed, 30 Apr 2025 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028244; cv=none; b=lSqzzW3jvBaq+Qn0vyNnQwtyvNmYOA7zfrsDs9bLsWb7JwoD8REPlqx6Vnh1J57HkPIaH9DYaRsnJcgxCDmcPQ89Fr+XbetlpPTJT4IjJeuw3to/A6vqRCo4u5Fby1br5liGHeRXtV/G60WxoMxh+iLttzxfpA2O61OFPiY0vbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028244; c=relaxed/simple;
	bh=/W2Ic4tKA97M9bMUtoPjZi1J8CCbti4QeU2swqC2iFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qiesdVmciqVx4olfkPSHVhmP3gHcOB95/ToY4fI7XXQqodcWhmPppL5UC9/5rkGQ/X02IqADaNdngXrYAkJVgxW55f4AynHos5uLnLf1pAKoIttbVeeY76Mxk4bTPlseefFy0D7PZ/3ObsSX74ybZPWOuGMtgjVJOUyUBQwWciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iNpPjjLD; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=2ipwuktyL4IYrX9QXx/qInbelFH4y7kMFN28HkTAvhQ=;
	b=iNpPjjLDz6EdD5R4/9fK8E9OmIw40897IJyzAwoAG6brClDAePPB9KPJS73B2M
	c0SHXHZutwDtPNHUe6B0CgkUR0tpBlNMv7gGtA7xm5cANRMrnczaV72BCfGPMHLD
	+GjKsGThSkDkIjK/b9dBHaLdcRVst7yvq0x3MBUBcSkR4=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnt_CXRhJok9OzDQ--.16197S2;
	Wed, 30 Apr 2025 23:49:43 +0800 (CST)
Message-ID: <96f0f689-5fa1-40b1-9381-41dbd4836ad6@163.com>
Date: Wed, 30 Apr 2025 23:49:42 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/6] PCI: Refactor capability search into common
 macros
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com,
 manivannan.sadhasivam@linaro.org, kw@linux.com, cassel@kernel.org,
 robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250429125036.88060-1-18255117159@163.com>
 <20250429125036.88060-4-18255117159@163.com>
 <df929c0d-f318-023e-cf7d-97a2b344f6fc@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <df929c0d-f318-023e-cf7d-97a2b344f6fc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnt_CXRhJok9OzDQ--.16197S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1fWryxWr4ktF4kuw48WFg_yoW8CFy8pF
	y8Aw4aya1DKay3Ca4DZa18XFyaq393CrW7Wrn8Jw1FqFs09F9aqr4rKa1rAFW2kr95A3W2
	qrWYqFyUA3WUCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVMKtUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxM-o2gSP2WsegAAs2



On 2025/4/30 16:03, Ilpo Järvinen wrote:
> On Tue, 29 Apr 2025, Hans Zhang wrote:
> 
>> The PCI Capability search functionality is duplicated across the PCI core
>> and several controller drivers. The core's current implementation requires
>> fully initialized PCI device and bus structures, which prevents controller
>> drivers from using it during early initialization phases before these
>> structures are available.
>>
>> Move the Capability search logic into a header-based macro that accepts a
>> config space accessor function as an argument. This enables controller
>> drivers to perform Capability discovery using their early access
>> mechanisms prior to full device initialization while sharing the
>> Capability search code.
>>
>> Convert the existing PCI core Capability search implementation to use this
>> new macro.
>>
>> The macros now implement, parameterized by the config access method. The
> 
> This sentence is incomplete (and sounds pretty much duplicated
> information anyway).
> 

Dear Ilpo,

Thank you very much for pointing out my problems patiently. These will 
be deleted.

>> PCI core functions are converted to utilize these macros with the standard
>> pci_bus_read_config accessors.
> 
> This info is duplicated.
> 

Will delete.

>> Controller drivers can later use the same
>> macros with their early access mechanisms while maintaining the existing
>> protection against infinite loops through preserved TTL checks.
>>
>> The ttl parameter was originally an additional safeguard to prevent
>> infinite loops in corrupted config space.  However, the
>> PCI_FIND_NEXT_CAP_TTL macro already enforces a TTL limit internally.
>> Removing redundant ttl handling simplifies the interface while maintaining
>> the safety guarantee. This aligns with the macro's design intent of
>> encapsulating TTL management.

Best regards,
Hans


