Return-Path: <linux-pci+bounces-37978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5A4BD63A9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 22:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3262819204A9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 20:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D30230AACE;
	Mon, 13 Oct 2025 20:42:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F051A309EEE;
	Mon, 13 Oct 2025 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388178; cv=none; b=mPHOQPMj248gduoP2gxMhh64mszspme9fLuAFnMOysNllgGi6jzKsw8eQIVXharmDEN/yfHh1hw15/X7Ji+r1LW1KHjJk13Hrj64+6xdSB8lnRYIJn8XyNKXoLcWoiJJIOM7vtoPxPhPpsY6pG7ORF7UzvlGU9j+oX/mIQyRlKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388178; c=relaxed/simple;
	bh=xKtQgJRsuX5tKVTVViYkngB+tljb7gYCso27qJYidUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRsotlBTjMno6AnkLEhotCkrxE6rsEnpen5GN4wA578CO/7zHQd4tZvOhk/2vsehR4Si5RTeW+6s62x/EHVYNy9Bu1cah4gaaVTrCmKTpcjYrUI0SpOcPMBYtnNsbW+M9DXHEwjhui2876orZnYPgiZCr78wMnJGQO8Mc0F5Twg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CCE71063;
	Mon, 13 Oct 2025 13:42:47 -0700 (PDT)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F12F3F738;
	Mon, 13 Oct 2025 13:42:50 -0700 (PDT)
Message-ID: <ef4c0cbc-bf5e-4e55-b495-8bafa8a84c32@arm.com>
Date: Mon, 13 Oct 2025 15:42:50 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
To: Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev,
 kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
References: <yq5aqzxy9ij1.fsf@kernel.org> <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
 <4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.com>
 <20251010153046.GF3833649@ziepe.ca>
 <f6cf20f6-0f19-4814-b917-4f92dad39648@arm.com>
 <68e953f484464_1992810065@dwillia2-mobl4.notmuch>
 <20251010223444.GA3938986@ziepe.ca>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20251010223444.GA3938986@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/10/25 5:34 PM, Jason Gunthorpe wrote:
> On Fri, Oct 10, 2025 at 11:44:04AM -0700, dan.j.williams@intel.com wrote:
>> Jeremy Linton wrote:
>>> On 10/10/25 10:30 AM, Jason Gunthorpe wrote:
>>>> On Fri, Oct 10, 2025 at 10:28:36AM -0500, Jeremy Linton wrote:
>>>>
>>>>>> So you could use auxiliary_device, you'd consider SMC itself to be the
>>>>>> shared HW block and all the auxiliary drivers are per-subsystem
>>>>>> aspects of that shared SMC interface. It is not a terrible fit for
>>>>>> what it was intended for at least.
>>>>>
>>>>> Turns out that changing any of this, will at the moment break systemd's
>>>>> confidential vm detection, because they wanted the earliest indicator the
>>>>> guest was capable and that turned out to be this platform device.
>>>>
>>>> Having systemd detect a software created platform device sounds
>>>> compltely crazy, don't do that. Make a proper sysfs uapi for such a
>>>> general idea please.
>>>
>>> Yes, I agree, its just at the time the statment was around what is the
>>> most reliable early indicator, and since there isn't a hwcap or anything
>>> that ended up being the choice, as disgusting as it is.
>>>
>>> Presumably once all this works out the sysfs/api surface will be more
>>> 'defined'
>>
>> It has definition today.
>>
>> All guest-side TSM drivers currently call tsm_report_register(), that
>> establishes /sys/kernel/config/tsm/report which is the common cross-arch
>> transport for retrieving CVM launch attestation reports.
> 
> I suspect this ins't a TSM question but an existing question if any of
> the underlying CC frameworks are enabled.
> 
> It is this stuff:
> 
> https://github.com/systemd/systemd/blob/main/src/basic/confidential-virt.c
> https://github.com/systemd/systemd/commit/2572bf6a39b6c548acef07fd25f461c5a88560af
> 
>    Like the s390 detection logic, the sysfs path being checked is not labeled
>    as ABI, and may change in the future. It was chosen because its
>    directly tied to the kernel's detection of the realm service interface
>    rather to the Trusted Security Module (TSM) which is what is being
>    triggered by the device entry.
> 
> Maybe a /sys/firmware/smc/rsi file might be appropriate?

Except that you can see from the code that this problem is being solved 
in a hw platform dependent way for 4+ platforms now.

Ideally the sysfs node would be common across all those hw platforms and 
reflect the vm capabilities so the code doesn't' need #ifdef's. Meaning 
it shouldn't have the smc/rsi arm'ism in the name, and maybe shouldn't 
be in /sys/firmware


Thanks,

> 
> Given how small a deployed fooprint ARM CCA has right now (ie none) it
> would be good to fix this ASAP so it doesn't become entrenched.
> 
> Jason


