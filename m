Return-Path: <linux-pci+bounces-7217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A08BF89B
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 10:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB21E1C2346B
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BA8BA27;
	Wed,  8 May 2024 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VaMI90pQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA6153E28
	for <linux-pci@vger.kernel.org>; Wed,  8 May 2024 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157231; cv=none; b=HJ0NvGF6euy5rMMtrWXWk0oDJg1q84ymTnK3HgyBTA5MobwsfDBd56SgAoWJOC2eFpyUh5hbMUbNQeuBPbicriNQkWiB4ViGMyv6o8AzidDDTn0Ak+JGb50Ql6rGl4zZsxc6GFUwpi7+hVm3w7XgAToOqXZ9x0sciwTZBW+8X70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157231; c=relaxed/simple;
	bh=YCsg1u+niEczogssz+PTwGFiNoFiKGD6NSqDv/+3zqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LIDIDhwyjv5947EEiv9Ei3j+XsexFHKH/kh+soS0HzfPPgzaBmXArfe5MLfX6WzQ82xJLBMGnR6N3EgotVw/J9igZvpeFw9M776dJUia5Ek/gbOWAJdz4p2hr71YdzViGTX7tLWWXmComhCUESjURRTjTXxEU37+o2DqeBuU1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VaMI90pQ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715157230; x=1746693230;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=YCsg1u+niEczogssz+PTwGFiNoFiKGD6NSqDv/+3zqM=;
  b=VaMI90pQSxuEG+b5+YgTva9gwYdFbvF5jhmYNO+qjp1NHPErFQISLYRl
   hRH8hlXEunrO3SL6LKIkCSqBm3VvvrFBmVaoo5vvkO2szaTm5aMfqBio1
   2lIu5DdyoR4aW0rfb7yFn0G+Bz6kETLYxt2o/wxIYuqv06u/lj/cGcQyl
   ppUff46BM7Ph3jnie2v4plI81v87O5rznOFD+jZiqE109W1HYRV2LPJBS
   x5iM8Mc+oVRmhIiNsj190ETopol4kR3d8wQCbX5AgDXaK//pRPIvuLiOm
   NXzzYLLF2Cxbr6iMJtCk/KV7QTcQAg6yMJAGSlYZ3Dte5oBEPmvx9YjQ9
   g==;
X-CSE-ConnectionGUID: xgqBVen3QtG+GbvlSU7xUw==
X-CSE-MsgGUID: FFPWjwr/S32z7BysMLGnwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22155810"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="22155810"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 01:33:49 -0700
X-CSE-ConnectionGUID: 4zQr7uIDSSGGu2cIeWHoQA==
X-CSE-MsgGUID: tUlY151TTQunbj2t184GZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="52023373"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO localhost) ([10.245.246.76])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 01:33:46 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, lucas.demarchi@intel.com, Bjorn
 Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/i915: don't include CML PCI IDs in CFL
In-Reply-To: <Zjow5HXrXpg2cuOA@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1715086509.git.jani.nikula@intel.com>
 <bebbdad2decb22f3db29e6bc66746b4a05e1387b.1715086509.git.jani.nikula@intel.com>
 <Zjow5HXrXpg2cuOA@intel.com>
Date: Wed, 08 May 2024 11:33:43 +0300
Message-ID: <87cypwln2w.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 07 May 2024, Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
> On Tue, May 07, 2024 at 03:56:48PM +0300, Jani Nikula wrote:
>> @@ -535,11 +541,7 @@
>>  	INTEL_WHL_U_GT1_IDS(info), \
>>  	INTEL_WHL_U_GT2_IDS(info), \
>>  	INTEL_WHL_U_GT3_IDS(info), \
>> -	INTEL_AML_CFL_GT2_IDS(info), \
>> -	INTEL_CML_GT1_IDS(info), \
>> -	INTEL_CML_GT2_IDS(info), \
>> -	INTEL_CML_U_GT1_IDS(info), \
>> -	INTEL_CML_U_GT2_IDS(info)
>> +	INTEL_AML_CFL_GT2_IDS(info)
>
> Why only CML and not AML and WHL as well?

Mainly because we don't have a separate enumeration in enum
intel_platform for AML or WHL, while for CML we do. We don't even have
subplatforms for AML or WHL. So we don't need to distinguish them.

That said, we could also have a rule that anything with a name needs to
have a PCI ID macro. Could lean either way.

BR,
Jani.

>
>>  
>>  /* CNL */
>>  #define INTEL_CNL_PORT_F_IDS(info) \
>> -- 
>> 2.39.2
>> 

-- 
Jani Nikula, Intel

