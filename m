Return-Path: <linux-pci+bounces-37820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2BABCDDF8
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 17:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 679434F8411
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3B3261B8C;
	Fri, 10 Oct 2025 15:50:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12D625DAF0;
	Fri, 10 Oct 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111408; cv=none; b=fr/kBxkP2MQtnXFabxxTfHpi7ycOYYQIrcFRW946LaUAf7msdfsnHXBZZHpUdPh/bl86aiZhOhpYUAhQGsTgY4VydnVNn+EGIMQ11t02zJZsuPvzJFsWs+TXXza8Vkw8ZL1So4c7HGqgaNMdVSj86j7czMUNUi2ljCmBuXHpRkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111408; c=relaxed/simple;
	bh=Zfnj6x7VmAlOK54hg3XHiIHlBbeE4/euzteOAJlxeDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOAXB1h8yNUqnzDRyvRBKfrsOqeTzQMaHL3X2QysXXPYQNB/xQ9O25Z1GIYWmnoQpgJgr7qJU6CjRuaJzatPf943y+gM+sz3NGU7vfn8NHM0u7475T+wnl4Dhrbt7z9rk0tBA+sULuiyucQvJ3tEDS8k7IylT5aPKLsQwMt4UjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AA931595;
	Fri, 10 Oct 2025 08:49:58 -0700 (PDT)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3BF63F66E;
	Fri, 10 Oct 2025 08:50:04 -0700 (PDT)
Message-ID: <f6cf20f6-0f19-4814-b917-4f92dad39648@arm.com>
Date: Fri, 10 Oct 2025 10:50:03 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
References: <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com> <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org> <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
 <4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.com>
 <20251010153046.GF3833649@ziepe.ca>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20251010153046.GF3833649@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/25 10:30 AM, Jason Gunthorpe wrote:
> On Fri, Oct 10, 2025 at 10:28:36AM -0500, Jeremy Linton wrote:
> 
>>> So you could use auxiliary_device, you'd consider SMC itself to be the
>>> shared HW block and all the auxiliary drivers are per-subsystem
>>> aspects of that shared SMC interface. It is not a terrible fit for
>>> what it was intended for at least.
>>
>> Turns out that changing any of this, will at the moment break systemd's
>> confidential vm detection, because they wanted the earliest indicator the
>> guest was capable and that turned out to be this platform device.
> 
> Having systemd detect a software created platform device sounds
> compltely crazy, don't do that. Make a proper sysfs uapi for such a
> general idea please.

Yes, I agree, its just at the time the statment was around what is the 
most reliable early indicator, and since there isn't a hwcap or anything 
that ended up being the choice, as disgusting as it is.

Presumably once all this works out the sysfs/api surface will be more 
'defined'


> 
> Jason


