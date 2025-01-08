Return-Path: <linux-pci+bounces-19560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D571A065AA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 20:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A0316180D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 19:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC3F202C42;
	Wed,  8 Jan 2025 19:59:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FA120127E;
	Wed,  8 Jan 2025 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736366379; cv=none; b=U0Nx6/Z++2/D1TUhcNgVPc7Mr6gfcjWeue9ScigniylZ8dX5WHe6w4mOE2wfZKpR8FfbmZAnAlMYNxePoQcY9YWL4izD47GLIX7EkliU9sQXOUUdYa3cPjQk6hYcjNZqkrQ24bnwqPIOIOcaG5SaLEgt81S+qB5uL8kTUv6BELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736366379; c=relaxed/simple;
	bh=/KGS/8rQgUDzOWmbIuVURj9WEuwmEg34L0vx2hkYIUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3fyiflpJcxWmdSig2aNKXLGRLmIIYuRGwdn2yji8Tvy/pu96byLoZfOnwEq3YADOqfLIG0stHCzFgBtv3e+iaS6/ti9v1ImiZQ2jEWvcfDdwVXPmuAx3Ophxpz28AHHzP7nWm3xR70szcqZjmWmnoxdUAMBn+LLkT18reudACQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 673C213D5;
	Wed,  8 Jan 2025 12:00:04 -0800 (PST)
Received: from [172.27.42.68] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FF2C3F66E;
	Wed,  8 Jan 2025 11:59:35 -0800 (PST)
Message-ID: <d35924de-a560-40aa-a99d-7278009c5ff3@arm.com>
Date: Wed, 8 Jan 2025 13:59:35 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] GENL interface for ACPI _DSM methods
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, lenb@kernel.org, robert.moore@intel.com,
 bhelgaas@google.com, wei.huang2@amd.com, honnappa.nagarahalli@arm.com,
 dhruv.tripathi@arm.com, rob.herring@arm.com
References: <20250106163045.508959-1-wathsala.vithanage@arm.com>
 <20250106180140.00005132@huawei.com>
 <85fb2b19-9d15-44ea-8f76-b3cac14e2810@arm.com>
 <20250107174842.GN5556@nvidia.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20250107174842.GN5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 1/7/25 11:48 AM, Jason Gunthorpe wrote:
> On Tue, Jan 07, 2025 at 11:37:01AM -0600, Jeremy Linton wrote:
>> Hi,
>>
>> On 1/6/25 12:01 PM, Jonathan Cameron wrote:
>>> On Mon, 6 Jan 2025 16:30:43 +0000
>>> Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:
>>>
>>>> Linux v6.13-rc1 added support for PCIe TPH and direct cache injection.
>>>> As already described in the patch set[1] that introduced this feature,
>>>> the cache injection in supported hardware allows optimal utilization of
>>>> platform resources for specific requests on the PCIe bus. However, the
>>>> patch set [1] implements the functionality for usage within the kernel.
>>>> But certain user space applications, especially those whose performance
>>>> is sensitive to the latency of inbound writes as seen by a CPU core, may
>>>> benefit from using this information (E.g., the DPDK cache stashing
>>>> feature discussed in RFC [2]).
> 
> There is no way for userspace to program TPH information into a PCI
> device without going through a kernel driver, and the kernel driver
> must be the exclusive owner of the steering tag configuration or chaos
> would ensue. Having a way for sysfs to override this seems very wrong
> to me, and I think you should not go in this direction.
> 
> DPDK runs on VFIO or RDMA. It would natural to have an VFIO native API
> to manipulate the steering tags, and we are already discussing what
> RDMA support for steering tag would look like.
> 
>>> Superficially this feels like another potential interface that could be wrapped
>>> up under appropriate fwctl. Jason, what do you think?
> 
> As above, I think this very squarely belongs under the appropriate
> subsystems that are providing the kernel drivers for the device. There
> is no reasonable way to share steering tags with unrelated userspace
> through any mechanism. Basically it fails the independence test of
> fwctl.
> 
>> I think this was similar to a conversation we had internally, which was
>> basically to detect the PCIe extended capability and export a 'steering'
>> entry in sysfs on each PCIe device which can take a logical cpu/cache value,
>> translate those on write to the ACPI cpu/cache id's, make the firmware call,
>> then directly update the PCIe device's capability with the result.
> 
> Seems wrong, driver must do this. If the driver was already using that
> entry for something else you've just wrecked it.

Can you clarify what you mean by 'wrecked'? AFAIK a valid, if poorly 
chosen, steering tag is going to be sub-optimal performance.

I'm under the impression this is a similar problem to cpu/irq/numa 
affinity where the driver/subsystem should be making the choice, but the 
user is provided the opportunity to override the defaults if they think 
there is benefit in their environment. Again AFAIK, the whole 
OS/software stashing is already well down the 'I know better than the HW 
where to store this data' rabbit hole.


Thanks,


