Return-Path: <linux-pci+bounces-24282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47243A6B279
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A86C67B1C26
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C24B23DE;
	Fri, 21 Mar 2025 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGb4iK9/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B017184F
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742518862; cv=none; b=m6tz+9lMeOMhyVQegM1Jq846o1jd2DiqZqDka/Ia+Bt/A0zmHWa1yegiosb5WJK7uwIOPY42SyWAqbp/PkBdvtr2XfwAWo57Una1LuX24NmX4C64D0ScqLM9gVSfNBCi0hNLuQdXRAk/s/2K8kBjUtlqkArV04j31Ch8A1Xx/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742518862; c=relaxed/simple;
	bh=5+SW+m/na3Hi3LhgRDxUkuADU/vyUxpxlJ7E3BKrbkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfdJ+wLoNa+eNvYwcL/TCn4g59Pf4Wpk/2gFiOlabgtsqYRvdl+SUks57DL2VFpD03CGpHumbhbr+iWv9yu1aNf6QKDPzV4BsKsx7oOyrTDrf2R0u6PL/izH2kJoRwNomHR626+vkO8vYGHLsDXPRjAZCTEKib2q3+mzGoEPC8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGb4iK9/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742518861; x=1774054861;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5+SW+m/na3Hi3LhgRDxUkuADU/vyUxpxlJ7E3BKrbkU=;
  b=bGb4iK9/uZw6im/7yuT6acw52TSe2AofRGBQcx3iAjRqpkMxsR2zZQh/
   tVZLskOTaxjyd/9jYcZwEdYuoy3yBiblwKTjkUTX4Z0P34HY4lNxQoBO0
   jnML3bc93wjm+DvgsgYaHXWDIvl42htleqs+RleMYXSCFK42bGteU+9HV
   zz1aaKyeHfuaD6RLuGXHBkwX73Hta4J4AK/VG8Z6hxCs+LAyv+qd5GOh+
   jqUovsZZ0XEI8FdSScx6ondNZQIQWN48o9NblDG5fcwr+1Go1g5P4Y1Ah
   qJKImUabO+rc0Wsf+af2dRrB6tP22U/ZdsZHqPvvgNCMMcGLLutUPo0oB
   Q==;
X-CSE-ConnectionGUID: z6QngPscRQ6g0VWj6zRVkA==
X-CSE-MsgGUID: hkCe4sg+QFiSZVQBfbadsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="47552871"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="47552871"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:01:01 -0700
X-CSE-ConnectionGUID: DTTr9aBtSDe3JZ/h62/lHA==
X-CSE-MsgGUID: At1ijvz2R++tk9vcfglTmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="127415450"
Received: from jairdeje-mobl1.amr.corp.intel.com (HELO [10.124.221.27]) ([10.124.221.27])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:00:59 -0700
Message-ID: <82339c3d-d1e2-46b8-839a-70bf44ada56e@linux.intel.com>
Date: Thu, 20 Mar 2025 18:00:59 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] PCI/AER: Add ratelimits to PCI AER Documentation
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Terry Bowman <Terry.bowman@amd.com>
References: <20250320082057.622983-1-pandoh@google.com>
 <20250320082057.622983-7-pandoh@google.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250320082057.622983-7-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/20/25 1:20 AM, Jon Pan-Doh wrote:
> Add ratelimits section for rationale and defaults.
>
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   Documentation/PCI/pcieaer-howto.rst | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index f013f3b27c82..896d2a232a90 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -85,6 +85,17 @@ In the example, 'Requester ID' means the ID of the device that sent
>   the error message to the Root Port. Please refer to PCIe specs for other
>   fields.
>   
> +AER Ratelimits
> +--------------
> +
> +Since error messages can be generated for each transaction, we may see
> +large volumes of errors reported. To prevent spammy devices from flooding
> +the console/stalling execution, messages are throttled by device and error
> +type (correctable vs. uncorrectable).
> +
> +AER uses the default ratelimit of DEFAULT_RATELIMIT_BURST (10 events) over
> +DEFAULT_RATELIMIT_INTERVAL (5 seconds).
> +
>   AER Statistics / Counters
>   -------------------------
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


