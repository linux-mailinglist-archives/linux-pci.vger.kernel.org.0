Return-Path: <linux-pci+bounces-37817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8964EBCDCCE
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 17:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE803BA08A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42C32F90D4;
	Fri, 10 Oct 2025 15:28:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A125235044;
	Fri, 10 Oct 2025 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110119; cv=none; b=ctJ/Qc8P4ecfE65pwyTYRi2I85hhepTQV0uLqY/YvEdwLRne5HBFKKwkk90LZ+I8oncyLciyurzEmOwlrNPz/TxtRWHu2+VrOrbEsVTw/fYzB0CCWgILb0lSJ0Ql1ykN3yh7pxPI2xDMmsCwxpBS1+ul/f//yLee8k3Gzlrk+XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110119; c=relaxed/simple;
	bh=UNtfwV6gt9YzjTUxdiegipEiAdiDLfreV8nIpQ/mlQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChMrvA/KRwS0xN4dv3XZIIy4lf797yfK3URbNcXKsNw1WfriRHIdP/XNvglu8lfrsLAdSGAqtPtGamcr46V+Xeq3YyE2poH+3L3b5oSbHeRlrguQNeHVpLkBm50UhHmppps7ejW00+jmF7CumJBk4tcObFYNXWjn91C60Igkizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3A431595;
	Fri, 10 Oct 2025 08:28:29 -0700 (PDT)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AFE43F66E;
	Fri, 10 Oct 2025 08:28:37 -0700 (PDT)
Message-ID: <4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.com>
Date: Fri, 10 Oct 2025 10:28:36 -0500
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
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com> <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org> <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20251010135922.GC3833649@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/10/25 8:59 AM, Jason Gunthorpe wrote:
> On Fri, Oct 10, 2025 at 07:10:58AM -0500, Jeremy Linton wrote:
>>> Yes, use faux_device if you need/want a struct device to represent
>>> something in the tree and it does NOT have any real platform resources
>>> behind it.  That's explicitly what it was designed for.
>>
>> Right, but this code is intended to trigger the kmod/userspace module
>> loader.
> 
> Faux devices are not intended to be bound, it says so right on the label:
> 
>   * A "simple" faux bus that allows devices to be created and added
>   * automatically to it.  This is to be used whenever you need to create a
>   * device that is not associated with any "real" system resources, and do
>   * not want to have to deal with a bus/driver binding logic.  It is
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^
>   * intended to be very simple, with only a create and a destroy function
>   * available.
> 
> auxiliary_device is quite similar to faux except it is intended to be
> bound to drivers, supports module autoloading and so on.
> 
> What you have here is the platform firmware provides the ARM SMC
> (Secure Monitor Call Calling Convention) interface which is a generic
> function call multiplexer between the OS and ARM firmware.
> 
> Then we have things like the TSM subsystem that want to load a driver
> to use calls over SMC if the underlying platform firmware supports the
> RSI group of SMC APIs. You'd have a TSM subsystem driver that uses the
> RSI call group over SMC that autobinds when the RSI call group is
> detected when the SMC is first discovered.
> 
> So you could use auxiliary_device, you'd consider SMC itself to be the
> shared HW block and all the auxiliary drivers are per-subsystem
> aspects of that shared SMC interface. It is not a terrible fit for
> what it was intended for at least.

Turns out that changing any of this, will at the moment break systemd's 
confidential vm detection, because they wanted the earliest indicator 
the guest was capable and that turned out to be this platform device.



