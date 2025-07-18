Return-Path: <linux-pci+bounces-32571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9604B0ABB7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 23:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E053A9A6A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 21:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB4221FF28;
	Fri, 18 Jul 2025 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrpmS24x"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E494921CA0C
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874920; cv=none; b=M5vuNIvTFJxDF+DLzSB0YSkCFJF4Tud+l1xs348wauI7BRSjRY9buNhd4FkzPAe7wh0egwHzX1ZzMp7nTXqGpebYTkA2AFttP8lgsVfEyRC5w8tuqtTCB27t23NrS8+SBoYuBmCzzMQfsNyGzOzS1dZWuZ+hUZ5X+xWncxyk02k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874920; c=relaxed/simple;
	bh=uxXpdkcHdOrQaJc+eu4/GeOXinhx7hO5tirp5wkNhw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/YCNEKww0qkCUqW9BGO8DjhPxTh25cT22xbG30tmO2i0mHOaY7BUv9zHqYo2M+OKwbA6fGmr7IhopHWnhCkW4Dhnf20VyYQYU3tSAPTOK53CipvRY37XrkaQCvRLdfuFnb6Qb92/NJCNG+gZxRx0kj6aZ7C0j3AWYC5fYY9gek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NrpmS24x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752874918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pl8HYJY2kuf3xc5dYY1A2bTJiaSaxCFVikVVLsHu9SQ=;
	b=NrpmS24xcQhFf7z3zT/77jdGQCvMJ90RGt8bYYURVEc4M0ttWaTWzXebb0nxLJsjVVyIuo
	l09bxWed3YPytbDbPy2Ua0KrRazop3j6LAyeSJMxqQjuwcObJ2eO8f7MZwzyGNenAht3gX
	h3EBiAANRHuIEdJPi0tWcPo0jHckT8c=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-9r3eZgRkNwmsE1g70LH0HA-1; Fri, 18 Jul 2025 17:41:57 -0400
X-MC-Unique: 9r3eZgRkNwmsE1g70LH0HA-1
X-Mimecast-MFC-AGG-ID: 9r3eZgRkNwmsE1g70LH0HA_1752874914
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234a102faa3so21941395ad.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 14:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752874914; x=1753479714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl8HYJY2kuf3xc5dYY1A2bTJiaSaxCFVikVVLsHu9SQ=;
        b=qKI77ivr3URv3BvvzLe6jsT53zwnS+Ss11jlFJZol11ImPL14zsOjGRcupNQCUSSa2
         9wkMDrpcvRVOliOnDtjSrZ1PMofCfhJU2rxPtfhxU1iFN+X8wyN7WQ5EinCgXS4RwEEz
         gk8pMewKt+U5RUfbqwBFwz6ZRdCLrz/qokcbT9sbhM5Oew3uwkCVWvKlG7ddNaZZXVEC
         YCIzExXTs+2JnlLTrARfo/zYaB2dado9FFumQA15kTcQv1Ql5Nf7xWI38x7gWCSOAYim
         kzEGhOAMGfCenIr3WemmCP4pK6kvjDyDzCCft4ET28KRG9se36Oay8sANrEMvzOqhSqN
         r2mg==
X-Forwarded-Encrypted: i=1; AJvYcCXNR4KwFbUUF04pDLl7O6zYQ97LMNyBHmG6tbzGQCE40PuMOwigk7F4k0AkLOacwgfkvA09EEltJAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzofZ3ioBAoEbrWHw0hTblu76M3O74qcoWnlyNSv+JM0k9JQkcK
	kN1/PaEycCnsTFCBkCK4+V9AIw9lo9E4B+E8V+fQCWQNM/wD1vTttsZy5b9hkX484HxT0r7/n3C
	XbLggmAZRS1UZUfirPhW8eX4FKq2o3Ae6qsDelKxm9EzIXDMPPAEwn4khthG3Ww==
X-Gm-Gg: ASbGncu9Zg+jx49x0x4XD2ohwwfqln3Mmk7t98SfsGDUu/NwqTTnbiKLNlvZpPdB1aE
	D+lO6hGcn9DicsDn+A4MCi3Ye1sQgf2eq2HMTTPgUsxpnBGFwooCGr2pTrBEK4nRdndnt6ro/TH
	jGKzO5gwtHfIDaMMvLSGLTkFF9jR6GCyYzTXr8+36D1yQDGPZ5jCMURqBadKROUDO8ptcfG5LBo
	UOuS3WOYm5jzjHfRI5yYFbBfW4JWkUxgj8XfsUQoC8lQcef+K4HJn5LB/HWzA3pB2Fvu4lthu7Z
	ijBJfQ4lw/aFWeoxX2HRS9vnemSM0zuHP/tjOC0F
X-Received: by 2002:a17:902:ef02:b0:234:9656:7db9 with SMTP id d9443c01a7336-23e24f4ae0emr193121195ad.32.1752874914360;
        Fri, 18 Jul 2025 14:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElJIwNy/gAl1oOb5k7nEBq38Uon8tJbJo/3EEmGz51w51P0ZBbNDEpVhWKCJJ33lSWOle8bg==
X-Received: by 2002:a17:902:ef02:b0:234:9656:7db9 with SMTP id d9443c01a7336-23e24f4ae0emr193120855ad.32.1752874913939;
        Fri, 18 Jul 2025 14:41:53 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4b20sm18055975ad.121.2025.07.18.14.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 14:41:53 -0700 (PDT)
Message-ID: <1cda6f16-fb56-450e-8d33-b775f57ae949@redhat.com>
Date: Fri, 18 Jul 2025 17:41:47 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] iommu: Compute iommu_groups properly for PCIe
 switches
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, galshalom@nvidia.com,
 Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, maorg@nvidia.com, patches@lists.linux.dev,
 tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <3-v2-4a9b9c983431+10e2-pcie_switch_groups_jgg@nvidia.com>
 <5b1f12e0-9113-41c4-accb-d8ab755cc7d7@redhat.com>
 <20250718180947.GB2394663@nvidia.com>
 <1b47ede0-bd64-46b4-a24f-4b01bbdd9710@redhat.com>
 <20250718201953.GI2250220@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250718201953.GI2250220@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/25 4:19 PM, Jason Gunthorpe wrote:
> On Fri, Jul 18, 2025 at 03:00:28PM -0400, Donald Dutile wrote:
>>>>> +	/*
>>>>> +	 * !self is only for SRIOV virtual busses which should have been
>>>>> +	 * excluded above.
>>>> by pci_is_root_bus() ?? -- that checks if bus->parent exists...
>>>> not sure how that excludes the case of !bus->self ...
>>>
>>> Should be this:
>>>
>>> 	/*
>>> 	 * !self is only for SRIOV virtual busses which should have been
>>> 	 * excluded by pci_physfn()
>>> 	 */
>>> 	if (WARN_ON(!bus->self))
>>>
>> my Linux tree says its this:
>> static inline bool pci_is_root_bus(struct pci_bus *pbus)
>> {
>>          return !(pbus->parent);
>> }
>>
>> is there a change to pci_is_root_bus() in a -next branch?
> 
> Not that, at the start of the function there is a pci_physfn(), the
> entire function never works on a VF, so bus is never a VF's bus.
> 
Well, i guess it depends on what you call 'a VF's bus' -- it returns the VF's->PF(pdev)->bus if virt-fn,
which I would call the VF's bus.
thanks for pointing further up... now I get your added edit above (which I didn't read carefully, /my bad).

>>>>> +	 */
>>>>> +	if (WARN_ON(!bus->self))
>>>>> +		return ERR_PTR(-EINVAL);
>>>>> +
>>>>> +	group = iommu_group_get(&bus->self->dev);
>>>>> +	if (!group) {
>>>>> +		/*
>>>>> +		 * If the upstream bridge needs the same group as pdev then
>>>>> +		 * there is no way for it's pci_device_group() to discover it.
>>>>> +		 */
>>>>> +		dev_err(&pdev->dev,
>>>>> +			"PCI device is probing out of order, upstream bridge device of %s is not probed yet\n",
>>>>> +			pci_name(bus->self));
>>>>> +		return ERR_PTR(-EPROBE_DEFER);
>>>>> +	}
>>>>> +	if (group->bus_data & BUS_DATA_PCI_NON_ISOLATED)
>>>>> +		return group;
>>>>> +	iommu_group_put(group);
>>>>> +	return NULL;
>>>> ... and w/o the function description, I don't follow:
>>>> -- rtn an iommu-group if it has NON_ISOLATED property ... but rtn null if all devices below it are isolated?
>>>
>>> Yes. For all these internal functions non null means we found a group
>>> to join, NULL means to keep checking isolation rules.
>>>
>> ah, so !group == keep looking for for non-isolated conditions.. got it.
>> Could that lead to two iommu-groups being created that could/should be one larger one?
> 
> The insistence on doing things in order should prevent that from
> happening. So long as the larger group is present in the upstream
> direction, or within the current bus, then it can be joined up.
> 
> This doesn't work if it randomly applies to PCI devices, it is why the
> above has added the "PCI device is probing out of order" detection.
> 
ok, will keep that concept in mind when reviewing.

> Jason
> 


