Return-Path: <linux-pci+bounces-32766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18293B0E88C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 04:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324AD3A54C0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 02:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DEA1C5D46;
	Wed, 23 Jul 2025 02:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/WlILZu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5368D19D88F;
	Wed, 23 Jul 2025 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753237429; cv=none; b=k5hIsIUwu2IJo1BG8y8Jy4uyj6zlzi2QMbHFi49wLPYhjH+bQf5dpeKia16sxBpN/SjSYPqkZkGKVlW7ezzoqQWCcvXdGlD3uT4m0b6KE/p3sqLzxeQx1Ia925mjO5lA1Ugj/esXc0Wt+TWCEOQv0CfIkh8mfYtlOtxGPL8W60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753237429; c=relaxed/simple;
	bh=eaqzaNsmnRz4JozLBC3l1KVRqD1x/YTuAOgIetggADE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yr7wFZJ2MXGrKfEWHQML1/sgt7ZdTzwplUpsplMUSKl+rCv5NJzSAbE8GYgyQgTDCvdE7AESWpHwe80/gxaskRy2dcEzTptdtBMTUwSq0WILmscu2LMfssLLzZ5b1SOLmcDarnKJ8to3T5Na+uVjnRHO07mitssOfepnGAY3VVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/WlILZu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753237428; x=1784773428;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eaqzaNsmnRz4JozLBC3l1KVRqD1x/YTuAOgIetggADE=;
  b=F/WlILZurGcGWOa4A6/lbBkETv65NMBY5IGm0NkVa09QhfQI3gfsboax
   5YCruRx8Wl4rO4plOngctbDj9hqJoM0U/U7RhmVGeljXgYu2fx5MFxg33
   9rH+JfiHEqstzdHsZO49o/ASch50HNZourVQKcodentF11llywlgj9iKB
   DFPOnKkt5X/RKm8F1x603126zqYqwoNek4Qv+M8Dl/nAG8Ms0rrcj23RM
   gLk3ndA+GikG8p8Z3PiQYRurCez3LTJMrj0lzenIyLtIlOZAzVltFAZqX
   a2Q0W9GFSxu3HkVRbgx/vrx/c7OfY47O9s5pkrcOFLf+JZqKp6fNlo7Wu
   g==;
X-CSE-ConnectionGUID: 9VCoJxOBTxyaEZRbSo6aDg==
X-CSE-MsgGUID: yAtRgZ/qRxmUTsfAnkfErQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="65769197"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="65769197"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 19:23:47 -0700
X-CSE-ConnectionGUID: G8nG4E3WQ2Ci98bm9FvtHA==
X-CSE-MsgGUID: Kgc0ETjvQRO9lwOcbReXSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="190268779"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 19:23:45 -0700
Message-ID: <c57ba058-4b25-42a9-8076-98b72b304d51@linux.intel.com>
Date: Wed, 23 Jul 2025 10:21:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/4] iommu: Introduce iommu_dev_reset_prepare() and
 iommu_dev_reset_done()
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
 helgaas@kernel.org
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <9042270b6c2d15a53e66d22d29b87c1c59e60669.1751096303.git.nicolinc@nvidia.com>
 <20250704154342.GN1410929@nvidia.com> <aIAJfYMKYKyZZRqx@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aIAJfYMKYKyZZRqx@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 05:58, Nicolin Chen wrote:
>>     return 0;
>>
>> guard(mutex)(&group->mutex);
> I recall Baolu mentioned that Joerg might not like the guard style
> so I am keeping mutex_lock/unlock().

You may be misremembering or mixing something up. I didn't see Joerg
express that opinion. :-)

My understanding is that cleanup.h could be used in new or refactored
code, but people don't like converting existing lock/unlock mechanisms
for no real benefit.

Thanks,
baolu

