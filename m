Return-Path: <linux-pci+bounces-19450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C40A04861
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 18:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D853A06B1
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 17:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075E318C031;
	Tue,  7 Jan 2025 17:37:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70C418BC3B;
	Tue,  7 Jan 2025 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736271427; cv=none; b=GucXMTMsGSqnr6NmxUocslXbCCzff2n/bcAQbumxxU4uYVSS0oTnGvKIVNgoiBrtyPU3GBkcvXUyTB3izFOCuftdTfgvdz9nbAZAD9nlYzgDBisJSnIjNqKHJQJtqWSEk+2lG9hgaZ+6SOiTJCqsGeut6NpoMFepOyvJZi4Lv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736271427; c=relaxed/simple;
	bh=MCGVPEPwHTz5c7Yp4A7t785cwKwFxolZ7+d6KKuFyRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V08/0Eyso0R77BM809dsdB9JlCzhcvGR0pv0eRqAFUZwwQqmb1vBKKrKacaW2jg1MWNsBCGoXU9ldZnldVLY+jz9XO4j/9AOSVdp7P/LCSCTDnayUY9gmzOrL7BaTS6owTHDtDWXBrKA4t5fwULr+GSDgyUBDyEn1QoPFhB2KKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D53C1424;
	Tue,  7 Jan 2025 09:37:31 -0800 (PST)
Received: from [172.27.42.65] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A30DF3F59E;
	Tue,  7 Jan 2025 09:37:02 -0800 (PST)
Message-ID: <85fb2b19-9d15-44ea-8f76-b3cac14e2810@arm.com>
Date: Tue, 7 Jan 2025 11:37:01 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] GENL interface for ACPI _DSM methods
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, lenb@kernel.org,
 robert.moore@intel.com, bhelgaas@google.com, wei.huang2@amd.com,
 honnappa.nagarahalli@arm.com, dhruv.tripathi@arm.com, rob.herring@arm.com,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20250106163045.508959-1-wathsala.vithanage@arm.com>
 <20250106180140.00005132@huawei.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20250106180140.00005132@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 1/6/25 12:01 PM, Jonathan Cameron wrote:
> On Mon, 6 Jan 2025 16:30:43 +0000
> Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:
> 
>> Linux v6.13-rc1 added support for PCIe TPH and direct cache injection.
>> As already described in the patch set[1] that introduced this feature,
>> the cache injection in supported hardware allows optimal utilization of
>> platform resources for specific requests on the PCIe bus. However, the
>> patch set [1] implements the functionality for usage within the kernel.
>> But certain user space applications, especially those whose performance
>> is sensitive to the latency of inbound writes as seen by a CPU core, may
>> benefit from using this information (E.g., the DPDK cache stashing
>> feature discussed in RFC [2]). This RFC is an attempt to obtain the PCIe
>> steering tag information from the kernel to be used by user mode
>> applications. We understand that there is more than one way to provide
>> this information. Please review and suggest alternatives if necessary.
>>
>> The first of the two patches introduced in this RFC attempts to overcome
>> the kernel-only limitation by providing an API to kernel subsystems to
>> hook up relevant _DSM methods to a GENL interface. User space
>> applications can invoke a _DSM hooked up to this interface via the
>> "acpi-event" GENL family socket, granted they have the minimum
>> capabilities and message formats demanded by the kernel subsystem that
>> hooked up the _DSM method. This feature is added by extending the
>> "acpi-event" GENL family that multicasts ACPI events to the user-space
>> applications such as acpid.
>>
>> The second patch of this RFC hooks up the PCIe root-port TLP Processing
>> Hints (TPH) _DSM to the ACPI GENL interface. User space applications
>> like [2] can now request the kernel to execute the _DSM on their behalf
>> and return steering-tag information.
>>
>> [1] lore.kernel.org/linux-pci/20241002165954.128085-1-wei.huang2@amd.com
>> [2] inbox.dpdk.org/dev/20241021015246.304431-2-wathsala.vithanage@arm.com
> 
> Hi Wathsala,
> 
> Superficially this feels like another potential interface that could be wrapped
> up under appropriate fwctl. Jason, what do you think?
> 
> Mind you I'm not personally convinced that an interface that focuses on
> exposing _DSM calls to userspace makes sense as opposed to subsystem specific
> stuff.
> 
> Maybe consider associating the actual interface with the individual PCI functions
> (which provides the first chunk of the message directly).

Right,

I think this was similar to a conversation we had internally, which was 
basically to detect the PCIe extended capability and export a 'steering' 
entry in sysfs on each PCIe device which can take a logical cpu/cache 
value, translate those on write to the ACPI cpu/cache id's, make the 
firmware call, then directly update the PCIe device's capability with 
the result. This also leaves the door open for future 
cpu/cache->steering tag translation methods to transparently replace the 
_DSM call while leaving the userspace API the same.


> 
> Also, _DSM is just one form of firmware interface used for PCI supporting
> system. Tying the userspace interface to that feels unwise.  I can certainly
> foresee a PSCI/SCMI or similar interface for this on ARM platforms
> wrapped up in _DSM where ACPI is present but directly accessed when DT
> is in use.
> 
> I'd also request that you break out what goes in ARG0,1,2 as that is all
> stuff that the kernel is aware of and not all reviewers have access to the
> ECN (I do though).  In particular the fact there are ACPI UIDs may
> need a more generic solution.
> 
> Jonathan
> 
>> Wathsala Vithanage (2):
>>    ACPI: Add support for invoking select _DSM methods from user space
>>    PCI: Add generic netlink interface to TPH _DSM
>>
>>   drivers/acpi/Makefile                 |   3 +-
>>   drivers/acpi/{event.c => acpi_genl.c} | 110 ++++++++++++++++++++++-
>>   drivers/acpi/acpi_genl_dsm.c          |  76 ++++++++++++++++
>>   drivers/pci/tph.c                     | 121 ++++++++++++++++++++++++++
>>   include/acpi/acpi_genl.h              |  54 ++++++++++++
>>   include/linux/acpi.h                  |   1 +
>>   6 files changed, 360 insertions(+), 5 deletions(-)
>>   rename drivers/acpi/{event.c => acpi_genl.c} (63%)
>>   create mode 100644 drivers/acpi/acpi_genl_dsm.c
>>   create mode 100644 include/acpi/acpi_genl.h
>>
> 


