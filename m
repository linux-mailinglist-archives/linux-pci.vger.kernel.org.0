Return-Path: <linux-pci+bounces-10330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238D0931D17
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 00:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5661F2274D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 22:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9DC13C816;
	Mon, 15 Jul 2024 22:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARZRvy8C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8794561FFA;
	Mon, 15 Jul 2024 22:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721081880; cv=none; b=rBm4lg1yp3Pt/e4HRXG69mG2QnAaM/9iLLcsbJAaHqmhvPljfQqdmreHzOoIfUMasLxx8tqIM+oxEn72XvYPKEyYZWMa4m0rIqMPTrM/iplJAXwd8725SwA0eEH3P6Uq3BxX7moV/cuNgqkPzgh7j3UD2GGg95DavShZqWfDJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721081880; c=relaxed/simple;
	bh=eNIWdn2Y+uQISVE4IpyxR+lz1+SOJ5dMjA7qAsRlSyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jjd14/Fz4vTjD5FG4/qogcmMYp6mxAsWvyGI13oeqP1Xv5BdXz61n4z8C0iHUN4i8Rd/GP2ysQ8NlwZVm8V2Xaoy5CP8CzKquc6ap31/BlxKVnyGekqx4wepCrVpbEf0Px5rhOtS3uR+yg/iK3VW3RO8KXTa8IsTQMMHrOjuKAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARZRvy8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCB6C32782;
	Mon, 15 Jul 2024 22:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721081880;
	bh=eNIWdn2Y+uQISVE4IpyxR+lz1+SOJ5dMjA7qAsRlSyc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ARZRvy8CBlPjhYmh11m/4bOdvnCGJfwzcqlretzSRdukta/rvlNHoCA5al0Ihx5q/
	 Z0rUT4I+B8lMnadXrJPWQrKlN2kC67j80MhI77CIk338H4FCmDIf7iFP7d6BTNdQk7
	 QAbB6gCLexdCSWqMLYtKUf8irHnBDbjMuUmUitMYcrptBmmrjYFnTl0U6DEPMZs/L2
	 8HHsDqme/9o9XsXfj5EC7kUOIJQOT57idGX3T52PjezOjsulf0R9NddONHmoz3MqC9
	 UpXE5DeWpyNcKwGxXGoFtWgdje/ECGh7OvLNGs4l7LeWTKHet8Q+eCdlEzVlrMV86M
	 8PAXh+4nj6ntw==
Message-ID: <57791455-5c70-4ede-97d9-d5784eef7abe@kernel.org>
Date: Tue, 16 Jul 2024 07:17:55 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Kees Cook <kees@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxarm@huawei.com,
 David Box <david.e.box@intel.com>, "Li, Ming" <ming4.li@intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Alexey Kardashevskiy
 <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
 Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
 Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>,
 Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Jann Horn <jannh@google.com>
References: <Zo_zivacyWmBuQcM@wunner.de>
 <66901b646bd44_1a7742941d@dwillia2-xfh.jf.intel.com.notmuch>
 <ZpOPgcXU6eNqEB7M@wunner.de> <202407151005.15C1D4C5E8@keescook>
 <20240715181252.GU1482543@nvidia.com>
 <66958850db394_8f74d2942b@dwillia2-xfh.jf.intel.com.notmuch>
 <20240715220206.GV1482543@nvidia.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240715220206.GV1482543@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/24 07:02, Jason Gunthorpe wrote:
> On Mon, Jul 15, 2024 at 01:36:32PM -0700, Dan Williams wrote:
>> Jason Gunthorpe wrote:
>>> On Mon, Jul 15, 2024 at 10:21:48AM -0700, Kees Cook wrote:
>>>
>>>> Anyway, following the threat model, it doesn't seem like half measures
>>>> make any sense. If the threat model is "we cannot trust bus members" and
>>>> authentication is being used to establish trust, then anything else must
>>>> be explicitly excluded. If this can only be done via the described
>>>> firewalling, then that really does seem to be the right choice.
>>>
>>> There is supposed to be a state machine here, devices start up at VM
>>> time 0 unable to DMA to secure guest memory under any conditions. This
>>> property must be enforced by the trusted platform.
>>>
>>> Further the trusted plaform is supposed to prevent "replacement"
>>> attacks, so once the VM says it trusts a device it cannot be replaced
>>> with something else.
>>>  
>>> When the guest decides it would like the device to reach secure memory
>>> the trusted platform is part of making that happen.
>>>
>>> From a kernel and lifecycle perspective we need a bunch of new options
>>> for PCI devices that should be triggered after userspace has had a
>>> look at the device.
>>>
>>>  - A device is just forbidden from anything using it
>>>  - A device used only with untrusted memory
>>>  - A device is usable with trusted memory
>>>
>>> IMHO this determination needs to be made before the device driver is
>>> bound.
>>
>> Yes, and it depends on the device. Some devices should be filtered
>> early, some devices need to be operated against untrusted memory just
>> to get to the point where they can complete the acceptance flow into the
>> TCB.
> 
> Operating a device with both trusted and untrusted iommu
> configurations is complex to manage and depends on how the trusted
> iommu HW works.
> 
>> The motivation for the security policy is "there is trusted memory to
>> protect". Absent trusted memory, the status quo for the device-driver
>> model applies.
> 
> From what I can see on some platforms/configurations if the device is
> trusted capable then it MUST only issue trusted DMA as that is the
> only IO translation that will work.
> 
> Meaning the decision to operate a device as trusted or not really has
> to be done before any driver is probed and probably needs to involve
> the iommu layer to try and do something about this mess in some way.

As I commented already, for storage device using SPDM-over-storage (scsi/ata and
nvme devices), the device authentication requires the device driver since we
need a gendisk and request queue to be able to issue the commands transporting
SPDM messages. So this is applicable only to PCI devices.

Of note though is that in the case of SCSI/ATA storage, the device (the HDD or
SSD) is not the one doing DMA directly to the host/guest memory. That is the
adapter (the HBA). So we could ask ourselves if it makes sense to authenticate
storage devices without the HBA being authenticated first.

And for PCI nvme devices that can support SPDM either through either PCI DOE or
SPDM-over-storage (SECURITY SEND/RECV commands), then I guess we need some
special handling/config to allow (or not) SPDM-over-storage authentication as
that will require the device driver to be loaded and to execute some commands
before authentication can happen.

> I have yet to see a complete plan for how these details should work :)
> 
> And I only know in detail how the iommu works for one platform, not
> the others, so I don't know how prevalent these concerns are..
> 
> Jason

-- 
Damien Le Moal
Western Digital Research


