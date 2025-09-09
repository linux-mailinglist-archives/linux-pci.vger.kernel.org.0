Return-Path: <linux-pci+bounces-35764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 331A3B50671
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 21:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A97C1C27062
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 19:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D242B343D9C;
	Tue,  9 Sep 2025 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0clw1fX"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD6A238D3A
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 19:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757446420; cv=none; b=GGBHmZ3TJEEcdg0lhtMSMRophYO6WUUWzKMYBszCJLc0COyXVwVC5TyUA2HzgrrAOmHKDcSPCeg/ZpdI/sphyDHJgWHTdAV3XYMTjr/Igi1BbugUc1lmilxRZ+Wubuc9mQaTsvir6SuZiCW7wuevZi7/RdCl9t04te4xRE2bsRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757446420; c=relaxed/simple;
	bh=mUgqnSrCeNtyPRzp40kafmu2emrwvDGauUeKsNnrkLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKtOVVwwgdIDX7ZyoNA7Pgnn2uxrIr2ya0ui3p9QOnRRPVm/p/a+ck2RKYUfgSFHveH0iEQl1Qm7qWvpVCHwSG4c7D1kWEQG0NyZPXM4GcLOMQBPzYjXLhS6pfCw3xvooCPAmHT1ysoOnklpYLgssVs1JWFcTStSJu74sXRHpPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0clw1fX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757446417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xv0UmvOM6iq9BarO5ln98fc4nB6oP2f7t4wXJ04yBgo=;
	b=G0clw1fX6AvGkMrAm6568HS4gLuy0l0CLv8+1ItuSYXfoarZAVMB8f3Hj7ojKN4e1i/34R
	4+vD1lsrye4OmmmvyVBVpPySVeHm6NJISTRtTueKZQOH484WnQio9kfa5A4d4vVDK4xVxc
	lz3xd8OBPoSyLLL/di+QmY35o3nINdo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-v7mydvpcNt6KIFRh666Y2w-1; Tue, 09 Sep 2025 15:33:35 -0400
X-MC-Unique: v7mydvpcNt6KIFRh666Y2w-1
X-Mimecast-MFC-AGG-ID: v7mydvpcNt6KIFRh666Y2w_1757446415
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b6090aeaacso76821591cf.3
        for <linux-pci@vger.kernel.org>; Tue, 09 Sep 2025 12:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757446415; x=1758051215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xv0UmvOM6iq9BarO5ln98fc4nB6oP2f7t4wXJ04yBgo=;
        b=sdI/RFrV+4BuomiYmsemZ4Mn+cRS192SCOecJuqpFkSt8Gbn37s/m1vU6O4IaP9AkK
         5EkP8fGP+pU8PUt76HpnXNKGGTsptMZTPFcCCgNitGTl8siIhva+5WFlSVkj6FWRnr+0
         XFHFUydCHmPANLu8o2GRQVhIH4whGLCSqYaur90Zi94t3iT99cworrjCNy96/WwOCTSq
         elGP3na0ddeGX7Zd+bFj/BXHG0tp/IJiFUhYtREGGHudPN3ShAKmNrec7NMMJj5gacK5
         YDZGur7+Hl6bOnhgT7aLeNfgsVWCcL/TVhIgEBs1tFx8wRNORG3DsH+ilvfNhV5aEsSS
         EDtA==
X-Forwarded-Encrypted: i=1; AJvYcCV7FXCG/y7ejR4Cjhh6n+7bG9zKVy5IeSeN6HyqPJg5fM7sA/lBaiyUhJRZn+GAjVz6UNbXVF9JwSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOTU74T1Ug6sv5Fh4q9+4H5DPO9AQ+O6ACCr6qdhyOPIvgRLOE
	woQr9qO/ob4RUG/lL1AQFg3ZN4f+TapekoTpYbNzE3FwN/J24CQFPuKn0uCi6rN7Yntg0muxQ4Z
	YwYiYhyzdNWUqvq5uNY8rn+7xgBnu9/7EwTZgpAyC827zxKd7/kF6obzj5vO8lQ==
X-Gm-Gg: ASbGncsxacztkvL9LKSiDI5xudKjFqWcEYJV+ULk0CmRUlNTyqLyrQJNsYpBcbmHQ3W
	yQOT9fNXCS9out/cnVhr3px2vpdudHOPO6jXnuhvFLY1B4nCcAYoTs1fM/5wlsZLQeMrNqt+VeE
	qUb+MaE1kR4s4wjy8tb3CG9NAGe7miLEuerPBJ5yVZSNBeFMwHqiGhuVabVQqqvh5WuV6JIUwqV
	TD3YCYfabn+8RpiAd9r3HLoKmUVnpc6M94y7lYe5H/29oCwrH9Dseqs/cZ0StSuHP+MdIt4hcR1
	8mJmu+yrjyQCyoRrN2oeyHc1ySUwetGFRNwJ+5rF
X-Received: by 2002:a05:622a:1343:b0:4b5:ee26:5373 with SMTP id d75a77b69052e-4b5f83c8b18mr157023811cf.21.1757446415060;
        Tue, 09 Sep 2025 12:33:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt6ZFsxR50RVtcwNCWmeGZgkt2Iz2ZbSC15FzqztkMn3bYZzGFWhNgqOHOvkUWFbY7XPZ5nA==
X-Received: by 2002:a05:622a:1343:b0:4b5:ee26:5373 with SMTP id d75a77b69052e-4b5f83c8b18mr157023411cf.21.1757446414556;
        Tue, 09 Sep 2025 12:33:34 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b61bbbc3a3sm12895041cf.24.2025.09.09.12.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 12:33:33 -0700 (PDT)
Message-ID: <3d775106-2610-4766-afdb-0820cf92e6c1@redhat.com>
Date: Tue, 9 Sep 2025 15:33:32 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] iommu: Compute iommu_groups properly for PCIe
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
References: <3-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
 <3634c854-f63f-4dc0-aa53-0b18c5a7ea1c@redhat.com>
 <20250909121845.GI789684@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250909121845.GI789684@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/9/25 8:18 AM, Jason Gunthorpe wrote:
> On Tue, Sep 09, 2025 at 12:14:00AM -0400, Donald Dutile wrote:
> 
>>> -/*
>>> - * Use standard PCI bus topology, isolation features, and DMA alias quirks
>>> - * to find or create an IOMMU group for a device.
>>> - */
>>> -struct iommu_group *pci_device_group(struct device *dev)
>>> +static struct iommu_group *pci_group_alloc_non_isolated(void)
> 
>> Maybe iommu_group_alloc_non_isolated() would be a better name, since that's all it does.
> 
> The way I've organized it makes the bus data a per-bus thing, so
> having pci in the name when setting BUS_DATA_PCI_NON_ISOLATED is
> correct.
> 
> What I did was turn iommu_group_alloc() into
> 
> static struct iommu_group *iommu_group_alloc_data(u32 bus_data)
> 
> Then
> 
> struct iommu_group *iommu_group_alloc(void)
> {
> 	return iommu_group_alloc_data(0);
> }
> 
> And instead of pci_group_alloc_non_isolated() it is just:
> 
> 	return iommu_group_alloc_data(BUS_DATA_PCI_NON_ISOLATED);
> 
> So everything is setup generically if someday another bus would like
> to have its own data.
> 
/my bad, I scanned pci_group_alloc_non_isolated() as calling iommu_group_alloc() & not iommu_group_alloc_data() as you pointed out.
Looks good.

Reviewed-by: Donald Dutile <ddutile@redhat.com>

> Jason
> 


