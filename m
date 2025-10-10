Return-Path: <linux-pci+bounces-37816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23095BCDC24
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 17:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 262B94EDB80
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1BD2F7AC1;
	Fri, 10 Oct 2025 15:14:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EE92F83BB;
	Fri, 10 Oct 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109263; cv=none; b=kepkv5pTdUXqmXzfk6jOL270L5fKDfRQLSOOxSXyL2CNp03h7AhCKufZM4nPAYO7AqDK2Gan8AymA6LbIfwFcKaf5U1r4jOyJ/IlaEbHor+NShqP9QJupD6jHGfzZOnsydbCFV015D+SYSCaeuivugLflIQUQX3g0qlNNIrZjw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109263; c=relaxed/simple;
	bh=rPfID8jYOxFYJphhHu3Zc0WXiMhGaGrrgflFiatI1wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpVauguUXH7qtnLPN6V0wg09b0STTyZBL1uARYNEFhGgBTbsVUy/gVg4GEUzNjjsTAKDkkHZA539fSsjN2zvB9/HdaFpCqUv7FHPR3zxUDd6PFFiDYMtrigagFGk/m2TuCzKd9bC3KHhX0DU7V8lIpgncjhjc7SYfeTqQtC/4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D1F41595;
	Fri, 10 Oct 2025 08:14:12 -0700 (PDT)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA0F43F66E;
	Fri, 10 Oct 2025 08:14:19 -0700 (PDT)
Message-ID: <cf848664-351d-429d-ad0d-7e3d02bbd989@arm.com>
Date: Fri, 10 Oct 2025 10:14:19 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>,
 linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
 lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com> <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org> <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <2025101020-tiara-procreate-e56f@gregkh>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <2025101020-tiara-procreate-e56f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/10/25 7:38 AM, Greg KH wrote:
> On Fri, Oct 10, 2025 at 07:10:58AM -0500, Jeremy Linton wrote:
>> Hi,
>>
>>
>> On 7/30/25 8:07 AM, Greg KH wrote:
>>> On Wed, Jul 30, 2025 at 01:23:33PM +0100, Jonathan Cameron wrote:
>>>> On Wed, 30 Jul 2025 11:38:27 +0100
>>>> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>>>>
>>>>> On Wed, 30 Jul 2025 14:12:26 +0530
>>>>> "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> wrote:
>>>>>
>>>>>> Jason Gunthorpe <jgg@ziepe.ca> writes:
>>>>>>> On Tue, Jul 29, 2025 at 06:10:45PM +0100, Jonathan Cameron wrote:
>>>>>>>>> +static struct platform_device cca_host_dev = {
>>>>>>>> Hmm. Greg is getting increasingly (and correctly in my view) grumpy with
>>>>>>>> platform devices being registered with no underlying resources etc as glue
>>>>>>>> layers.  Maybe some of that will come later.
>>>>>>>
>>>>>>> Is faux_device a better choice? I admit to not knowing entirely what
>>>>>>> it is for..
>>>>>
>>>>> I'll go with a cautious yes to faux_device. This case of a glue device
>>>>> with no resources and no reason to be on a particular bus was definitely
>>>>> the intent but I'm not 100% sure without trying it that we don't run
>>>>> into any problems.
>>>>>
>>>>> Not that many examples yet, but cpuidle-psci.c looks like a vaguely similar
>>>>> case to this one.
>>>>>
>>>>> All it really does is move the location of the device and
>>>>> smash together the device registration with probe/remove.
>>>>> That means the device disappears if probe() fails, which is cleaner
>>>>> in many ways than leaving a pointless stub behind.
>>>>>
>>>>> Maybe it isn't appropriate it if is actually useful to rmmod/modprobe the
>>>>> driver.
>>>>>
>>>>> +CC Greg on basis I may have wrong end of the stick ;)
>>>> This time with at least one less typo in Greg's email address.
>>>
>>> Yes, use faux_device if you need/want a struct device to represent
>>> something in the tree and it does NOT have any real platform resources
>>> behind it.  That's explicitly what it was designed for.
>>
>> Right, but this code is intended to trigger the kmod/userspace module
>> loader.
> 
> Why?

Originally it was because without the tsm drivers loaded there wasn't 
any way for a CCA guest to know it is running in a confidential compute 
environment. That is a bit of a problem for generic distro kernels which 
don't want to load a bunch of functionality on devices that don't 
support it. So, this triggers the tsm module load, which in turn 
provides enough metadata for userspace to start attestation/whatever it 
needs. (Ex: systemd-detect-virt --cvm).

I think Jason clarifies whats going on too.




> 
>> AFAIK, the faux device is currently missing a faux_device_id in
>> mod_devicetable, alias matching logic in file2alias, and probably a few
>> other things which keeps it from performing this function.
> 
> How would a faux device ever expect to get auto-loaded?  That's not what
> is supposed to be happening here at all.
> 
> If you have real hardware backing something, then use the real driver
> type.  that is NOT a faux driver, which is, as the name says, for "fake"
> devices that you wish to add to the device/driver tree.
> 
> thanks,
> 
> greg k-h


