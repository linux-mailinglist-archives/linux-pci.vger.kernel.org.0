Return-Path: <linux-pci+bounces-32869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 974C9B1011A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 08:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7641CC1EDD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 06:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2AD20126A;
	Thu, 24 Jul 2025 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxmMO8Bo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535E1F9E8;
	Thu, 24 Jul 2025 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339867; cv=none; b=mWbjFEAlzN3f/n0S5gk4mbSDBy+il8vofDzBB9+rXaElQx+48qwQjO2GSnpdzR4nqGFYo+OM6dERyVHC8Af3Y8Hcblenb2K4ZOPb7fahP7Dg4+C7Q7mlXPZ01xdXCo+1bJfNxlHXD+61uKo3JAsXo75Y7vCpRTCAcdCJskMRsGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339867; c=relaxed/simple;
	bh=w0X0br7o2eWaC/sCuDPbuNtjMrXI9dlkmLAYFCHsKxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0PgkO+7lqkuB0JLlsyVVqkkQvYdCa3iKvVT7bjrTB0lg2PZc3HpiVv0zv8LyqN177LWkOH70UJhCUPGZiu2xfO2RP458edLQ+zj0VMoINmu1l+y2NLuNZaJ56GGKjTACyhkmCwBHMGDEaF+ZkTU/yc+GvVpQwv1dxVhS6ahZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxmMO8Bo; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-45600581226so6157005e9.1;
        Wed, 23 Jul 2025 23:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753339864; x=1753944664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzVCG5SoHn4Tr6BCxb/1N9GpLGi9jl777U0laKdYkLA=;
        b=RxmMO8BorFBF0mjlPVAVCgLA3M3vEHHFjUYDfZCg2rcDKU9ZYmjOIL6XS+b3H55ZFC
         4stupBolSL6/0UEuz5mRhu5iigBeaBemy3vl8pylq2DixeRd78voeQtKaAdJ+jFTrRaV
         6c2aL4DOZszTgOln0lEMBEciFsiYwbmjz3FQkwGSDARH+3C9gISf/Zd5ZOGyXkmXYLbr
         lE2hg5aZAWCvdLyxAXvYqgGP6B9VAdqQdzULAC1cS6hIxdKiaU49rh+NgJ9R4imsygzQ
         jufGUOQXsRJZ0b8W7u3OOeG+DB+tgqk1JYQeyflEOkAUihV3foZNdXuuINhd5hdZhaNJ
         +voQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753339864; x=1753944664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzVCG5SoHn4Tr6BCxb/1N9GpLGi9jl777U0laKdYkLA=;
        b=m7l1PX8JRX1SRocJT2QLDDogLzo4VaccOsTgZJ5CQ2mFjtmE3dxOOSBy1xaaJi7Qwo
         pPanIn2/iuWAd44Scfv0Xj5qB++8CH1HLbUc+x6t/+cW9PYO3AXEif/TWN4bZQtdQBmW
         7Vd7ER2BWHKUmkyPsAHSqvp/DaaBBtjWH1bLG9Yip3+BIVgTk+wbmW0psmmkvsNdXFVK
         cfVzgQ1BoZ6QEBcH4/d616yUg8ml7zhzZZaOuGmZVM+DETMIC5NWkoNh4WAqcPA7N6Dw
         cNF7cx38SG0utbd1yTYhwjeyO4b3CP3gR1UlBx/FXqjmAg6OdRZuxhsQkBMQu/0FpALf
         SWHA==
X-Forwarded-Encrypted: i=1; AJvYcCUMTIcDvMqq9cuxkeyHqSr+ENYYF89rlhkumWSIjYuR6DbNe0BqvBEtbwqDcCfcnGEk1M8Hmh/Cbnle@vger.kernel.org, AJvYcCWLeNBmu/5X89H1giwRkEqvofEPj81JKNDUOdZeCC1gnNFy/YX+dLL2zoCqA4zhN3PnkqTrsC7eOFbzI+cR@vger.kernel.org, AJvYcCXC2wGVfr36RH/yotRVwTjyGbNdumON8c+A5suGd65doErLL30KfJvRwgvc3F+jDg5A92dP1c9QNR5E@vger.kernel.org
X-Gm-Message-State: AOJu0YwsNZ7KuuH0HToH6heGJyQ4pF2nbOkn5ylv84gr/b8jwgiKTE7k
	+cWmYAt4BOAciuX92CxZ5DfWRG51pMdXMZZjVX4PPSLSS42wiTVlPoFB
X-Gm-Gg: ASbGncsmDyTRNMAMIbxmxPESj/Y36npqN4b/mbgD98PKNg64LM820/aijbjr2e/n5L5
	YfHdGHZHSyjO9HZof8GHn21tMPGZgabDjY0Wd1xeYun6fHmxM2ksKdvqUZyick8RgD9sjXhoAgF
	SBhIF7TE2xzgVtUf3TtGg2rDwaoUihg58cKlNhG/yWgl7clpdlH2sBRQwEn7jnCyCDRk0kNzEqU
	+Op+M/SCDxa0U/KJCuXqIq6ZXBwNm3rLxAE52CozzZHC4Q89CLRii53BTESX3IEoj4QDUucvG8v
	DVK5DGO20BtsY6RGgh/15WmzjS4nSO2AxR0a/tm7/lpd0jT8Qne84WbJ/QycRWBahjeoRhE3+Wn
	80QVxuDuoLxSKuDjj6nrfGPrr0Fpl+VoFUoR+54MTJAmNwObvchtSytkV0Z485v0H2otJc723dc
	Ch91h4aXbJLfXkrQ==
X-Google-Smtp-Source: AGHT+IE9DAuzXlfO0T8BGbEaaDzrFKFbm9v9bayHfXRPMGOtvkB3z1CVZtyVEbYlFxT1eRAuNH/DWg==
X-Received: by 2002:a05:600c:1e26:b0:456:25e7:bed with SMTP id 5b1f17b1804b1-45868c97accmr53096245e9.14.1753339863187;
        Wed, 23 Jul 2025 23:51:03 -0700 (PDT)
Received: from [26.26.26.1] (9.126.207.35.bc.googleusercontent.com. [35.207.126.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcace54sm1166324f8f.45.2025.07.23.23.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 23:51:02 -0700 (PDT)
Message-ID: <4f7e4bfb-1bc7-4c87-a9f1-8c8b6ee9a336@gmail.com>
Date: Thu, 24 Jul 2025 14:50:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/4] Disable ATS via iommu during PCI resets
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, rafael@kernel.org, lenb@kernel.org,
 bhelgaas@google.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
 helgaas@kernel.org, baolu.lu@linux.intel.com
References: <cover.1751096303.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <cover.1751096303.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/28/2025 3:42 PM, Nicolin Chen wrote:
> Hi all,
> 
> PCIe permits a device to ignore ATS invalidation TLPs, while processing a
> reset. This creates a problem visible to the OS where an ATS invalidation
> command will time out: e.g. an SVA domain will have no coordination with a
> reset event and can racily issue ATS invalidations to a resetting device.
> 
> The OS should do something to mitigate this as we do not want production
> systems to be reporting critical ATS failures, especially in a hypervisor
> environment. Broadly, OS could arrange to ignore the timeouts, block page
> table mutations to prevent invalidations, or disable and block ATS.
> 
> The PCIe spec in sec 10.3.1 IMPLEMENTATION NOTE recommends to disable and
> block ATS before initiating a Function Level Reset. It also mentions that
> other reset methods could have the same vulnerability as well.
> 
> Provide a callback from the PCI subsystem that will enclose the reset and
> have the iommu core temporarily change all the attached domain to BLOCKED.
> After attaching a BLOCKED domain, IOMMU drivers should fence any incoming
> ATS queries, synchronously stop issuing new ATS invalidations, and wait
> for all ATS invalidations to complete. This can avoid any ATS invaliation
> timeouts.

This approach seems effective for reset operations initiated through 
software interface functions, but how would we handle those triggered by 
hardware mechanisms? For example, resets caused by PCIe DPC mechanisms, 
device firmware, or manual hot-plug operations?

Thanks,
Ethan
> 
> When a device is resetting, any new domain attachment should be deferred,
> until the reset is finished. The iommu callback will log the
> 
> However, if there is a domain attachment/replacement happening during an
> ongoing reset, the ATS might be re-enabled between the two function calls.
> Introduce a new pending_reset flag in iommu_group to defer any attachment
> during a reset, allowing iommu core to cache the target domains in the SW
> level but bypassing the driver. The iommu_dev_reset_done() will re-attach
> these soft-attached domains via __iommu_attach_device/set_group_pasid().
> 
> Notes:
> - This only works for IOMMU drivers that implemented ops->blocked_domain
> correctly with pci_disable_ats().
> - This only works for IOMMU drivers that will not issue ATS invalidation
> requests to the device, after it's docked at ops->blocked_domain.
> Driver should fix itself to align with the aforementioned notes.
> 
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/iommu_dev_reset-rfcv2
> 
> Changelog
> v2
>   * [iommu] Update kdocs, inline comments, and commit logs
>   * [iommu] Replace long-holding group->mutex with a pending_reset flag
>   * [pci] Abort reset routines if iommu_dev_reset_prepare() fails
>   * [pci] Apply the same vulnerability fix to other reset functions
> v1
>   https://lore.kernel.org/all/cover.1749494161.git.nicolinc@nvidia.com/
> 
> Thanks
> Nicolin
> 
> Nicolin Chen (4):
>    iommu: Lock group->mutex in iommu_deferred_attach
>    iommu: Pass in gdev to __iommu_device_set_domain
>    iommu: Introduce iommu_dev_reset_prepare() and iommu_dev_reset_done()
>    pci: Suspend iommu function prior to resetting a device
> 
>   include/linux/iommu.h  |  12 +++
>   drivers/iommu/iommu.c  | 180 ++++++++++++++++++++++++++++++++++++++---
>   drivers/pci/pci-acpi.c |  21 ++++-
>   drivers/pci/pci.c      |  84 +++++++++++++++++--
>   drivers/pci/quirks.c   |  27 ++++++-
>   5 files changed, 307 insertions(+), 17 deletions(-)
> 


