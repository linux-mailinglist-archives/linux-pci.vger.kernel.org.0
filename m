Return-Path: <linux-pci+bounces-3136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4061B84B110
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 10:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDD4285D32
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E9212DD93;
	Tue,  6 Feb 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6OkSwdk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C1012D151;
	Tue,  6 Feb 2024 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211406; cv=none; b=dctInU3eW0OPGJtvMU4BWA3DzgsZHOYdcSzjzhbgeyr2l9hGIr7abWumeQpci5hKHfAuwv/vuVWOtjSEt5m7iHgpyvJc8H4B7+w5waCASgu4Isdw3tg7lkN30KTDqnFMhawTu+FH5A/UNcETJxjLjMt5V3AP3fl0uXTWKhdw4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211406; c=relaxed/simple;
	bh=OsUGkPdqDQyuFkmYKqt4shx9dyA+PqArb74I3usMKzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3N9ENaJDIGN/jUS+FGgfZZ47NqmYyAhxOWeCyPWkn8iqHvc+3fERTEc5r9KqxwkTyY9AzkEfFiuSQv1KoHDRHnvUWyayCp4IcKKwJbzKm2YkOKLGeHq9+XMoCu0En6EDKVdKpouuSv8sj2INxAHXvBp8juDksMYS2kenpSmo5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6OkSwdk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707211406; x=1738747406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OsUGkPdqDQyuFkmYKqt4shx9dyA+PqArb74I3usMKzs=;
  b=d6OkSwdkdyGIwCLijKgx2Xovsex2dLdk/Z+1wVFfVuV2xK1k/nFRocp7
   BC1K8dTdzNzADxbKiEhHIpx7T51W0kF2NVmsCod9bY/hRuhhGDdYsA5PC
   78tTvE1f2FzUj9vUHv5x7SNXVY2bthAKkI+UvoHWPo8ak8tz9T82uT+53
   2yOfclKaYcYSXYw8CHhsfo2fOdXrpjAWRcdRVx4mwEiKGef97FCqlP89W
   WGCNJ3el8cBPJ4dSF9J8zEyJMKT9a3k+uCTdEkKI8+ZMgm2nM3dKT8lib
   4dJVo42BgI7PpPzrxKw062M7bTk7yIzj46xqsC9C8jAcN5gfapm5l3Vuj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4586667"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="4586667"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 01:23:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="5584235"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.196])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 01:23:19 -0800
Date: Tue, 6 Feb 2024 10:23:17 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Onkarnarth <onkarnath.1@samsung.com>
Cc: rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	r.thapliyal@samsung.com, maninder1.s@samsung.com
Subject: Re: [PATCH 2/2] kernel: sched: print errors with %pe for better
 readability of logs
Message-ID: <ZcH6hR+QnjKsv7+4@linux.intel.com>
References: <20240206051120.4173475-1-onkarnath.1@samsung.com>
 <CGME20240206051402epcas5p2ae3737fc0d71ba1d7a7f8bee90438ff2@epcas5p2.samsung.com>
 <20240206051120.4173475-2-onkarnath.1@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206051120.4173475-2-onkarnath.1@samsung.com>

On Tue, Feb 06, 2024 at 10:41:20AM +0530, Onkarnarth wrote:
> From: Onkarnath <onkarnath.1@samsung.com>
> 
> instead of printing errros as a number(%ld), it's better to print in string
> format for better readability of logs.
> 
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  kernel/sched/cpufreq_schedutil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index eece6244f9d2..2c42eaa56fa3 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -671,7 +671,7 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>  				"sugov:%d",
>  				cpumask_first(policy->related_cpus));
>  	if (IS_ERR(thread)) {
> -		pr_err("failed to create sugov thread: %ld\n", PTR_ERR(thread));
> +		pr_err("failed to create sugov thread: %pe\n", thread);
>  		return PTR_ERR(thread);
>  	}
>  
> -- 
> 2.25.1
> 
> 

