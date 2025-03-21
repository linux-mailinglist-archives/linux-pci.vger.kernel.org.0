Return-Path: <linux-pci+bounces-24353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08ABA6BC3C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E713B00B8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE9C78F47;
	Fri, 21 Mar 2025 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jIXoe2XE"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E4E78F30;
	Fri, 21 Mar 2025 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565501; cv=none; b=XChysODE+dqG+zk96OTKqRS838d3KwHRU+tARzwYvfuDXOzWy+uX3aQ5fgrGJEOWmwT/B4PFKsAIfNXHQknSG1LvddPZJ4k0dHS9kIOLiZHh97QP1TphBDA9wVokztUfi8L9ZBU13Tk1jCdCK69rlbA7GU0bUQketcWMCScnS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565501; c=relaxed/simple;
	bh=u9+pCxJ+sZ+M8TFCYPDcfeJjTdyKSPr8xUSrtA8xXvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjFY7Bx37NqPXtqz2DHvMSWCUPnDYeo0g5jXia2a1USWS3AAErutpYV9HXsoKw+g+Z8jA7kJC8tl+0MLAi47xfNJ+9UiiEYYknZOrNvKQfhsnQfuJe+jJGAJw6kwDyIqquy9UqDpC7tMfPacHVZuvrqJrICD/ZJg05Nalprk4OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jIXoe2XE; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=0ySma77ZxxQ6aT+4clvHKO3TmdAoszwwa+Xa3O6R6WA=;
	b=jIXoe2XEvdmHieMmZLKFmfn9bRsZ40xB9Xph0EmsS6hTbjmVUHa1zu4sA2psDY
	zlEHxYbeSQyy+5K3sYXIDtNnZEG4ssuXHgDCk322wrJc3vs0vSHnOxtjtHA9UjXa
	sX4ahOPrl6S8SG6jf/evgMeaI6vjnv5diWRIiL8TIBlvE=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnL39RcN1nGTTLAw--.57738S2;
	Fri, 21 Mar 2025 21:57:38 +0800 (CST)
Message-ID: <370e4055-c44b-460c-9ac3-ccac37527c8f@163.com>
Date: Fri, 21 Mar 2025 21:57:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 1/4] PCI: Introduce generic capability search functions
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250321101710.371480-1-18255117159@163.com>
 <20250321101710.371480-2-18255117159@163.com>
 <20250321130010.s6svrtqlpdkgxmir@thinkpad>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250321130010.s6svrtqlpdkgxmir@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnL39RcN1nGTTLAw--.57738S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw18uF17ArWUJF43AF4UCFg_yoW8Gw4xpF
	4rXFnayaykXr4SkF1qvF4UAFy3Gan7JrWxJF98G3sY9FnruF1Ig3yxt348uF9rJF17XF10
	vF4jqrykuF1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UK1v3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxAXo2fdalpqUwABsN



On 2025/3/21 21:00, Manivannan Sadhasivam wrote:
> On Fri, Mar 21, 2025 at 06:17:07PM +0800, Hans Zhang wrote:
>> Existing controller drivers (e.g., DWC, custom out-of-tree drivers)
>> duplicate logic for scanning PCI capability lists. This creates
>> maintenance burdens and risks inconsistencies.
>>
>> To resolve this:
>>
>> 1. Add pci_generic_find_capability() and pci_generic_find_ext_capability()
>> in drivers/pci/pci.c, accepting controller-specific read functions
>> and device data as parameters.
>>
> 
> I'd reword pci_generic* as pci_host_bridge* to reflect the fact that these APIs
> are meant for host bridges.
> 

Hi Mani,

Thanks your for reply. Will change.

>> 2. Refactor dwc_pcie_find_capability() and similar functions to utilize
>> these new generic interfaces.
>>
> 
> This is not part of this patch. So should be dropped.

Will change.

>> 3. Update out-of-tree drivers to leverage the common implementation,
>> eliminating code duplication.
>>
> 
> This also.

Will change.

>> This approach:
>> - Centralizes critical PCI capability scanning logic
>> - Allows flexible adaptation to varied hardware access methods
>> - Reduces future maintenance overhead
>> - Aligns with kernel code reuse best practices
>>
>> Tested with DWC PCIe controller and CDNS PCIe drivers.
>>
> 
> This tested info is also not required since the DWC and CDNS changes are not
> part of this patch.

Will change.

Best regards,
Hans


