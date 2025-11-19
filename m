Return-Path: <linux-pci+bounces-41598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9F2C6DFB7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 11:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 941FA3681F7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 10:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5606534C990;
	Wed, 19 Nov 2025 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MiU7xOEM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707CD3446B8;
	Wed, 19 Nov 2025 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763548037; cv=none; b=dRSeZ8LDNfgUew98rmwGSBUhsATKcvL0qflJm2YvRMbUc5pcDL8czuy5DJkHChOslbWl430nP/cxuospn/LS4F+uUGFJ81E6wRIrgHqxDPkXoGQt6+49qAe+Z0MDQQS3wHeMgc1Q+fENHeYTfCWJIncHi7WcaF4GM7LAv+QbKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763548037; c=relaxed/simple;
	bh=jmw9bhTP6DqEEo8SaI642JH1s3dFqQGzetmEw8f3+f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDEndxOQsGURyNyw7HJ+3V+/jE0nKso+pQgMGxupM6YJ2sUFd8ByT5zUdqRku+eLZ/bVdynuKs7sPZ5pqALwV5kMjzwfg5VTY37HYidePcJ+UWS5jym+sVUxabI3v10TTkJHSTuvzO/b0fEfj/1JAKGuzcuYStaCZWlv5FiVTVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MiU7xOEM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763548035; x=1795084035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jmw9bhTP6DqEEo8SaI642JH1s3dFqQGzetmEw8f3+f0=;
  b=MiU7xOEMrvpSHRKoOGFoxjvp2olCkMHYcgyVqGCXYhxtUSjKS4HqPHZY
   jwn1jZ20MYSLYgPZepTcbeT44WCjzhtiyp+/af2F23uBo2SxPny1E+O0E
   i35l1wp5ztEr/UgnTalJgnFm37qhWHVpZKg8LSXY/NLmt0PE9WL14Y8tO
   k3h/zOCwTRmKYN7LyemrWXS3V9sFi2e4KayP+OT7P6pLnL9tii32X9EIR
   Lpgv24Cc1EEW8J6mJRkCTzvjuPiiwhLzT1y6FWYPeBcXX3xztfuWgYKGf
   GVLiIWrx11wXkoB91Fm9V6NPb59zQvI7HbI0Bo9UlmO1kmJt9DFQYly3E
   w==;
X-CSE-ConnectionGUID: 2bBlveQeQxCd7RgNC0YNsw==
X-CSE-MsgGUID: njPqeXaCSmC15wNSdDdbLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65286211"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65286211"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 02:27:12 -0800
X-CSE-ConnectionGUID: BabbyDhyQAOE+ZtEsTT7/g==
X-CSE-MsgGUID: bIH3DAOlTZmt1WuzGTp/dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="195322765"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 02:26:53 -0800
Date: Wed, 19 Nov 2025 12:26:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Corey Minyard <corey@minyard.net>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sagi Maimon <maimon.sagi@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
	ceph-devel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 19/21] scsi: fnic: Switch to use %ptSp
Message-ID: <aR2bazZn8m4EMHdW@smile.fi.intel.com>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
 <20251113150217.3030010-20-andriy.shevchenko@linux.intel.com>
 <aR2XAYWTEgMZu_Mx@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR2XAYWTEgMZu_Mx@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 11:08:01AM +0100, Petr Mladek wrote:
> On Thu 2025-11-13 15:32:33, Andy Shevchenko wrote:
> > Use %ptSp instead of open coded variants to print content of
> > struct timespec64 in human readable format.
> 
> I was about to commit the changes into printk/linux.git and
> found a mistake during the final double check, see below.
> 
> > diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
> > index cdc6b12b1ec2..0a849a195a8e 100644
> > --- a/drivers/scsi/fnic/fnic_trace.c
> > +++ b/drivers/scsi/fnic/fnic_trace.c
> > @@ -215,30 +213,26 @@ int fnic_get_stats_data(struct stats_debug_info *debug,
> >  {
> >  	int len = 0;
> >  	int buf_size = debug->buf_size;
> > -	struct timespec64 val1, val2;
> > +	struct timespec64 val, val1, val2;
> >  	int i = 0;
> >  
> > -	ktime_get_real_ts64(&val1);
> > +	ktime_get_real_ts64(&val);
> >  	len = scnprintf(debug->debug_buffer + len, buf_size - len,
> >  		"------------------------------------------\n"
> >  		 "\t\tTime\n"
> >  		"------------------------------------------\n");
> >  
> > +	val1 = timespec64_sub(val, stats->stats_timestamps.last_reset_time);
> > +	val2 = timespec64_sub(val, stats->stats_timestamps.last_read_time);
> >  	len += scnprintf(debug->debug_buffer + len, buf_size - len,
> > -		"Current time :          [%lld:%ld]\n"
> > -		"Last stats reset time:  [%lld:%09ld]\n"
> > -		"Last stats read time:   [%lld:%ld]\n"
> > -		"delta since last reset: [%lld:%ld]\n"
> > -		"delta since last read:  [%lld:%ld]\n",
> > -	(s64)val1.tv_sec, val1.tv_nsec,
> > -	(s64)stats->stats_timestamps.last_reset_time.tv_sec,
> > -	stats->stats_timestamps.last_reset_time.tv_nsec,
> > -	(s64)stats->stats_timestamps.last_read_time.tv_sec,
> > -	stats->stats_timestamps.last_read_time.tv_nsec,
> > -	(s64)timespec64_sub(val1, stats->stats_timestamps.last_reset_time).tv_sec,
> > -	timespec64_sub(val1, stats->stats_timestamps.last_reset_time).tv_nsec,
> > -	(s64)timespec64_sub(val1, stats->stats_timestamps.last_read_time).tv_sec,
> > -	timespec64_sub(val1, stats->stats_timestamps.last_read_time).tv_nsec);
> > +			 "Current time :          [%ptSp]\n"
> > +			 "Last stats reset time:  [%ptSp]\n"
> > +			 "Last stats read time:   [%ptSp]\n"
> > +			 "delta since last reset: [%ptSp]\n"
> > +			 "delta since last read:  [%ptSp]\n",
> 
> Both delta times are printed at the end.
> 
> > +			 &val,
> > +			 &stats->stats_timestamps.last_reset_time, &val1,
> > +			 &stats->stats_timestamps.last_read_time, &val2);
> 
> I think that this should be:
> 
> 			 &stats->stats_timestamps.last_reset_time,
> 			 &stats->stats_timestamps.last_read_time,
> 			 &val1, &val2);
> 
> >  	stats->stats_timestamps.last_read_time = val1;
> 
> The original code stored the current time in "val1". This should be:
> 
> 	stats->stats_timestamps.last_read_time = val;
> 
> > @@ -416,8 +410,8 @@ int fnic_get_stats_data(struct stats_debug_info *debug,
> >  	jiffies_to_timespec64(stats->misc_stats.last_ack_time, &val2);
> 
> Just for record. Another values are stored into @val1 and @val2 at
> this point.
> 
> >  	len += scnprintf(debug->debug_buffer + len, buf_size - len,
> > -		  "Last ISR time: %llu (%8llu.%09lu)\n"
> > -		  "Last ACK time: %llu (%8llu.%09lu)\n"
> > +		  "Last ISR time: %llu (%ptSp)\n"
> > +		  "Last ACK time: %llu (%ptSp)\n"
> >  		  "Max ISR jiffies: %llu\n"
> >  		  "Max ISR time (ms) (0 denotes < 1 ms): %llu\n"
> >  		  "Corr. work done: %llu\n"
> > @@ -437,10 +431,8 @@ int fnic_get_stats_data(struct stats_debug_info *debug,
> >  		  "Number of rport not ready: %lld\n"
> >  		 "Number of receive frame errors: %lld\n"
> >  		 "Port speed (in Mbps): %lld\n",
> > -		  (u64)stats->misc_stats.last_isr_time,
> > -		  (s64)val1.tv_sec, val1.tv_nsec,
> > -		  (u64)stats->misc_stats.last_ack_time,
> > -		  (s64)val2.tv_sec, val2.tv_nsec,
> > +		  (u64)stats->misc_stats.last_isr_time, &val1,
> > +		  (u64)stats->misc_stats.last_ack_time, &val2,
> 
> So, this is correct!
> 
> >  		  (u64)atomic64_read(&stats->misc_stats.max_isr_jiffies),
> >  		  (u64)atomic64_read(&stats->misc_stats.max_isr_time_ms),
> >  		  (u64)atomic64_read(&stats->misc_stats.corr_work_done),
> 
> 
> Now, I think that there is no need to resend the entire huge patchset.
> 
> I could either fix this when comitting or commit the rest and
> you could send only this patch for review.

Thank you for the thoroughly done review, I changed that patch between the
versions and the problem is that for printf() specifiers (extensions) we do not
have an automatic type checking. We starve for a GCC plugin for that, yeah...

In any case, if you fold your changes in, I will appreciate that!
Otherwise it's also fine with me to send a patch separately later on.

> PS: All other patches look good. Well, nobody acked 7th patch yet.
>     But I think that the change is pretty straightforward and
>     we could do it even without an ack.

This is my understanding as well. It changes the output, but that output is
debug anyway. So I don't expect breakage of anything we have an obligation
to keep working.

-- 
With Best Regards,
Andy Shevchenko



