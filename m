Return-Path: <linux-pci+bounces-34092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D824B27850
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 07:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26DE97BF700
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 05:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2786923ABAF;
	Fri, 15 Aug 2025 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZfEpUeR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB51DE3B5;
	Fri, 15 Aug 2025 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235235; cv=none; b=ERgM4/wONR92H2cgCRiF7hm/mHxr4sF5oB1hXcwK8T4r3byZysLqyFtPFSZB264gSZRPXthy8CPklMDKXZeLvzAAAm4RMzjFKYUEPPeHHG7rfM1jMJk4xh+/jq4JKDFBLkRexIgGjuOMu/sJ7QuolI+6KdQWm67S64B8Fc5qiN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235235; c=relaxed/simple;
	bh=bfWN7p/dN5CQdIzjUhkdC/9puNhPF03kOfuc8TkPySk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsYR+31EpeimCqmw+f5C+zlsU5vrkj2ZtxdSix123zTQk79mnSw42bOLGYqj/VltORQZW6lIVkUPSqJ3rTI8eQcjB2AulAwom0K/r7b6wA4Sx7SHtQLIZVIvl8BVIm8hExEI0cI1gQd7hdZqyBw3pNJBNOhh4ZUm1hNQON3PFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZfEpUeR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755235234; x=1786771234;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bfWN7p/dN5CQdIzjUhkdC/9puNhPF03kOfuc8TkPySk=;
  b=GZfEpUeRvhASrdUkBhJT/i3LpH9+oKqMaNsJY9PpOyWbenagy3o/uDyU
   ZVlyVOAiInYgWapf4zlUbZDW9bgPkTqbYMxtuuoefmqRwxRVUatdW/1XX
   Iuh2Ojn2lusPd5FL0aIwDGXKINjQlyXXWuzOqdxZbvMz1cHTO8EEbuFhQ
   6t8TwPnZRu5MK4gP/VnBSzDnZ390xYulBKngEBEj8KAhrfC+1eGsu2y9N
   5nf7osqomvbvoc9kVnC4OjG5JwlLWvOj64ClVkQvqI3tWG4Voy/FWU9ye
   W95Ivph2Nmpcx3B4OenzdPG3FFo/UCvwZeBZ0CZVKLHKSnEPwOpZiZMdt
   g==;
X-CSE-ConnectionGUID: j7QL9BwzQUKDyh2IhBUV3g==
X-CSE-MsgGUID: Y/SpZ5BURoufpk0/XnO9Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="82994558"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="82994558"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 22:20:33 -0700
X-CSE-ConnectionGUID: jEHnJRqjTqGy3Eyj8EPakQ==
X-CSE-MsgGUID: 8mms4+OcTRSPtWyL1PCG4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166913623"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 22:20:27 -0700
Message-ID: <a9cc9b2c-71fa-4ee8-a82e-3254588cf964@linux.intel.com>
Date: Fri, 15 Aug 2025 13:18:20 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iommu: Pass in gdev to __iommu_device_set_domain
To: Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
 joro@8bytes.org, bhelgaas@google.com, jgg@nvidia.com
Cc: will@kernel.org, robin.clark@oss.qualcomm.com, yong.wu@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 rafael@kernel.org, lenb@kernel.org, kevin.tian@intel.com,
 yi.l.liu@intel.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, patches@lists.linux.dev, pjaroszynski@nvidia.com,
 vsethi@nvidia.com, helgaas@kernel.org, etzhao1900@gmail.com
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <b07a15780fd5a8c688f1ae6285438a112a9b9478.1754952762.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <b07a15780fd5a8c688f1ae6285438a112a9b9478.1754952762.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 06:59, Nicolin Chen wrote:
> The device under the reset will be attached to a blocked domain, while not
> updating the group->domain pointer. So there needs to be a per-device flag
> to indicate the reset state, for other iommu core functions to check so as
> not to shift the attached domain during the reset state.
> 
> The regular device pointer can't store any private any private iommu flag.
> So, the flag has to be in the gdev structure.
> 
> Pass in the gdev pointer instead to the functions that will check that per
> device flag.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

