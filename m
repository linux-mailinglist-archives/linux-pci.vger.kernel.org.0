Return-Path: <linux-pci+bounces-17711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DCB9E4866
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 00:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542222829C6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952811A3AB9;
	Wed,  4 Dec 2024 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+kHUQVe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3447D1917D7;
	Wed,  4 Dec 2024 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353571; cv=none; b=mJapMWOJ2lcPHi5r1l8GcqBEKURHO0QVL6tspbc2hnuBpAzZXYuCGJCtcPYHYvWLHYixALG74SkAeZJrqa6Uhwv+bvhtXNR6lP+nGCEvtsWr2GDU3REVaKyfi/j9z+T4rj0A3nVuPMDt0DVHTj51QthAMqKeZ339GWvadYY8OGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353571; c=relaxed/simple;
	bh=nq3UPcM/wl/X++1UbycTK10/8mtIH93/EHJYpVsInYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPQIivolFk2SClHJoi+Ib+Vk6I6hTF6khchmWBPnCMVzF9+Ag8CHYz0est5ynvEj6mDgdISjFCWN+gGBHL7AozWnuHmctlc+53jhNzAazVYt1HFKacEYSapuAgjyyl1PV2mYcHqIjwf108kwOInrk0BGJJgB6cX8j+7MRCkn3Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+kHUQVe; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733353569; x=1764889569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nq3UPcM/wl/X++1UbycTK10/8mtIH93/EHJYpVsInYc=;
  b=a+kHUQVeava5QdVA5EQwSbogteaDSRFg6ugDeNgO2FMwMqzS7VvnAHSD
   vTfcJLeIyWYJX/TMnDyv0JGjTpvTcdG30NpIhn6ndK5jMkppKAu1XyTdX
   yNOBgqzp0G8xIoExnSC4N7l0m8RugWKtv+a2UGyVv1QVlDElEe0pOn4dB
   +Aa3SvsUcN0LascjzFcco93Cjmnn8ef3O3swYBWVu343E4es+B7hUZY/l
   sx8ldDx8PomfH/URm6LjcmNAO+fcfDvxy/bL05k6LRSxOsgFz7H/9lgxl
   PZoPVbVreB8QHTshU/l4zJtDO/uwW0hkZn64j6u7mpdbKh8zUQUS2Z66u
   w==;
X-CSE-ConnectionGUID: WimGkI5JSPWwpevt1o0rUw==
X-CSE-MsgGUID: I8A/y1sCT3ylL9bhNhLLxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="59050534"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="59050534"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 15:06:09 -0800
X-CSE-ConnectionGUID: I5D4CJ5wQUS+bPsbMXcRSQ==
X-CSE-MsgGUID: Md7Bev2ZT9KUuGh1zg2Q5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98938291"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.90])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 15:06:09 -0800
Date: Wed, 4 Dec 2024 15:06:06 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com
Subject: Re: [PATCH] resource: harden resource_contains
Message-ID: <Z1DgXiqhclSRN4z0@aschofie-mobl2.lan>
References: <20241129091512.15661-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129091512.15661-1-alucerop@amd.com>

+ linux-cxl

On Fri, Nov 29, 2024 at 09:15:12AM +0000, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> While resource_contains checks for IORESOURCE_UNSET flag for the
> resources given, if r1 was initialized with 0 size, the function
> returns a false positive. This is so because resource start and
> end fields are unsigned with end initialised to size - 1 by current
> resource macros.
> 
> Make the function to check for the resource size for both resources
> since r2 with size 0 should not be considered as valid for the function
> purpose.
> 

Hi Alejandro,

Can this patch be included in the CXL Type-2 patchset, as a replacement for:

[PATCH v6 10/28] cxl: harden resource_contains checks to handle zero size resources
https://lore.kernel.org/20241202171222.62595-11-alejandro.lucero-palau@amd.com/T/#u

Keeping it in that set also keeps the discussion history.

DaveJ may be able to take it through the CXL tree with Bjorn's ACK.

--Alison


Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  include/linux/ioport.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 6e9fb667a1c5..6cb8a8494508 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -264,6 +264,8 @@ static inline unsigned long resource_ext_type(const struct resource *res)
>  /* True iff r1 completely contains r2 */
>  static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
>  {
> +	if (!resource_size(r1) || !resource_size(r2))
> +		return false;
>  	if (resource_type(r1) != resource_type(r2))
>  		return false;
>  	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
> -- 
> 2.17.1
> 

