Return-Path: <linux-pci+bounces-34093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE765B27871
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 07:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA59E1892307
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 05:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A9729B78D;
	Fri, 15 Aug 2025 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTvHZwL4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E5825A32C;
	Fri, 15 Aug 2025 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235817; cv=none; b=jSz0amgfpWaPNlO3J+sMcmpOh/P5Wrhx7Wvj9cXvSTC3l8YHBLtD80vQdJoew/svvYbIIdsCMR7ucV5KAl3rXJ/L3t982QSxQlMxmMenAJnqlQN4MMMUsD/Vl5/iExE5UXGDC71dmJTbDmgWAZnbYrNk9aiiCfd82jQ/WEIiC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235817; c=relaxed/simple;
	bh=y0xyaJyPtcDPNLHhbPevkPLJ5VRQZj0+f0qVNL2ihWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQ8dEV1R/t+Plulya+WP7oAabE+WGg1bg+wpF/Fm0pIYP+p8lT+LJh2qwgDI1Tkm64Ln0QJwUC8PQSnPVya2KlF6gqiJPg3srZ9/CJP4ZpEqqVD3CvkmWGTf7idSXPBIMlQXbfvRUYAqQHNn0bKfHMo6s1CXWCPPSyrdICH0DsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTvHZwL4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755235817; x=1786771817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y0xyaJyPtcDPNLHhbPevkPLJ5VRQZj0+f0qVNL2ihWc=;
  b=HTvHZwL45+KtXDJ45o+AG3CJZ4UW52eqxcfL67DmmoI+Lev6gofkSV++
   uGbKZFSk7u3Pv41dr0KfbvIPa2YchRC9jo2y01xQZy5GBfwqPLcc/Aacj
   9ac7KzoxhkoERBSLWKsIvwSWp2q7rW14p6Bq2Mou6JOwzwpNt84p5G/LW
   ZLwijLe0oUtR7E5jPozk34MIP16XIpYR7h0xpwYPARLxgYbQ26WIlS0Hd
   RRlqPVkMWYQ9X7jn24ev43Zva/d3iU/dZHPNoy7H9JVU5bdQQkR3yDfyD
   L5CrKKmHhcmFqq1sExwAOIAwIvuAXKEqQ14k1N6IRugy1zcDKCgq2Y8EU
   A==;
X-CSE-ConnectionGUID: FSuL+xs/Q6ySAaxV7am/0w==
X-CSE-MsgGUID: 47aJqn6SSXKXyplPyuwQkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="82994979"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="82994979"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 22:30:15 -0700
X-CSE-ConnectionGUID: RseyzJmKT36kWr3vroMtQg==
X-CSE-MsgGUID: a9/KIfTrTBati7fQxiXAIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166914870"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 22:30:08 -0700
Message-ID: <aeb04f91-ffce-4092-8dbc-17d116cd7c7e@linux.intel.com>
Date: Fri, 15 Aug 2025 13:28:02 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
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
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 06:59, Nicolin Chen wrote:
> There is a need to attach a PCI device that's under a reset to temporally
> the blocked domain (i.e. detach it from its previously attached domain),
> and then to reattach it back to its previous domain (i.e. detach it from
> the blocked domain) after reset.
> 
> During the reset stage, there can be races from other attach/detachment.
> To solve this, a per-gdev reset flag will be introduced so that all the
> attach functions will bypass the driver-level attach_dev callbacks, but
> only update the group->domain pointer. The reset recovery procedure will
> attach directly to the cached pointer so things will be back to normal.
> 
> On the other hand, the iommu_get_domain_for_dev() API always returns the
> group->domain pointer, and several IOMMMU drivers call this API in their
> attach_dev callback functions to get the currently attached domain for a
> device, which will be broken for the recovery case mentioned above:
>   1. core asks the driver to attach dev from blocked to group->domain
>   2. driver attaches dev from group->domain to group->domain
> 
> So, iommu_get_domain_for_dev() should check the gdev flag and return the
> blocked domain if the flag is set. But the caller of this API could hold
> the group->mutex already or not, making it difficult to add the lock.
> 
> Introduce a new iommu_get_domain_for_dev_locked() helper to be used by
> those drivers in a context that is already under the protection of the
> group->mutex, e.g. those attach_dev callback functions. And roll out the
> new helper to all the existing IOMMU drivers.

Given that iommu_group->mutex is transparent to the iommu driver, how
about

/*
  * Called only by iommu drivers in the callback context where
  * group->mutex has already been held by the core.
  */
struct iommu_domain *iommu_get_domain_for_dev_internal(struct device *dev)
{
	...
	lockdep_assert_held(&group->mutex);
	...
}

?

> 
> Add a lockdep_assert_not_held to the existing iommu_get_domain_for_dev()
> to note that it would be only used outside the group->mutex.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Thanks,
baolu

