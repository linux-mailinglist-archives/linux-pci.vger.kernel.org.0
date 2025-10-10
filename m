Return-Path: <linux-pci+bounces-37804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24033BCCD75
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 14:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CB53C03B8
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 12:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E452882AC;
	Fri, 10 Oct 2025 12:11:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF86B1F63FF;
	Fri, 10 Oct 2025 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760098262; cv=none; b=nRzj0/bPaD+yH5QuWdw/FUgbP6ZhXxrLrBl8Z+uZEb3t2Un3BiY4u6cakbc+jcanBK9CpJeM3erYAQ9bKnqYxV3XBNXGe68jl7WJfYYZbC+UJgb08MBCilWdn9IW8se7EK7nWHlcReZHHW+kCylBipTXik6DjPX1cH2dsFpHKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760098262; c=relaxed/simple;
	bh=Rf79rZFiOw6r+O6kn1K8Xn5L0CWlYxIVq8z4Vl++tBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D33292Q+18v6N/IZj4sS8Kc0mBh1luuz7MyxWDUj65vZ7pHulpHl83XGkws++7zye7CCFrF3NcV4pWbyd1GlbOSGpe7k/wkEiwWbCfPt9MIU6wCjU5bDXb9ok68MnGTUQSLIpiKhud0Z7e3kRhs1ixWE+fgvIFc1+PZF3fS7Z94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A1721596;
	Fri, 10 Oct 2025 05:10:52 -0700 (PDT)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E04C3F738;
	Fri, 10 Oct 2025 05:10:59 -0700 (PDT)
Message-ID: <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
Date: Fri, 10 Oct 2025 07:10:58 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
To: Greg KH <gregkh@linuxfoundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>,
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
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <2025073035-bulginess-rematch-b92e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


On 7/30/25 8:07 AM, Greg KH wrote:
> On Wed, Jul 30, 2025 at 01:23:33PM +0100, Jonathan Cameron wrote:
>> On Wed, 30 Jul 2025 11:38:27 +0100
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>>
>>> On Wed, 30 Jul 2025 14:12:26 +0530
>>> "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> wrote:
>>>
>>>> Jason Gunthorpe <jgg@ziepe.ca> writes:
>>>>    
>>>>> On Tue, Jul 29, 2025 at 06:10:45PM +0100, Jonathan Cameron wrote:
>>>>>     
>>>>>>> +static struct platform_device cca_host_dev = {
>>>>>> Hmm. Greg is getting increasingly (and correctly in my view) grumpy with
>>>>>> platform devices being registered with no underlying resources etc as glue
>>>>>> layers.  Maybe some of that will come later.
>>>>>
>>>>> Is faux_device a better choice? I admit to not knowing entirely what
>>>>> it is for..
>>>
>>> I'll go with a cautious yes to faux_device. This case of a glue device
>>> with no resources and no reason to be on a particular bus was definitely
>>> the intent but I'm not 100% sure without trying it that we don't run
>>> into any problems.
>>>
>>> Not that many examples yet, but cpuidle-psci.c looks like a vaguely similar
>>> case to this one.
>>>
>>> All it really does is move the location of the device and
>>> smash together the device registration with probe/remove.
>>> That means the device disappears if probe() fails, which is cleaner
>>> in many ways than leaving a pointless stub behind.
>>>
>>> Maybe it isn't appropriate it if is actually useful to rmmod/modprobe the
>>> driver.
>>>
>>> +CC Greg on basis I may have wrong end of the stick ;)
>> This time with at least one less typo in Greg's email address.
> 
> Yes, use faux_device if you need/want a struct device to represent
> something in the tree and it does NOT have any real platform resources
> behind it.  That's explicitly what it was designed for.

Right, but this code is intended to trigger the kmod/userspace module 
loader.

AFAIK, the faux device is currently missing a faux_device_id in 
mod_devicetable, alias matching logic in file2alias, and probably a few 
other things which keeps it from performing this function.

thanks,


