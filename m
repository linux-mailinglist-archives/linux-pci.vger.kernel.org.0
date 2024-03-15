Return-Path: <linux-pci+bounces-4838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E8687C7E1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 04:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9035D282A00
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 03:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A34AD272;
	Fri, 15 Mar 2024 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WADzmfjh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6DB8F6D;
	Fri, 15 Mar 2024 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710472541; cv=fail; b=NQV4Mkoqxm9bVvJWQdo2uVTJzK6UY8wk82Wln0bS1YnYEn4Ywp4SPBYI56N8e9QY0rNbyn3ac0QJO35Mw3bImWZEZ9dTD2/h1IQhxgEOEK34euzauu1sMjkhpuVbB6BISiSpjx+5WvhbqD8xDThBS9oZNYp7rATVCyIQssqlhXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710472541; c=relaxed/simple;
	bh=7ijNCUur97LferFgioaDCUKp2+GwdYFyxt9TUXcsJYo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bfu/bH7IQAlAXWr6UYt6Lx2uOJlgg6WAYMwoBsvzBOVX8/8xnG019H1kZyxLjxzOTP4QtpFy7ncxiUc0Hd8W7JdcTdVaDben3+9Wb+RT1brsJhLhCmrzbY1l79J6e5xov5Zc1l2UrZJTMbStnIwFC8Xj2pgLKqsR1R7hgbUJC5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WADzmfjh; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710472538; x=1742008538;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7ijNCUur97LferFgioaDCUKp2+GwdYFyxt9TUXcsJYo=;
  b=WADzmfjhU3t4/F1UeTDSBix8jmhN//sURhCyXShcQhWweICKqqNgEwHl
   1It5mYRIj635CC5lkq5QfZZQBK0G8PxhuQbX2PTtBiLq+UpGjiEzDsWpr
   /6OM3PM7OYVQsU1DoMAZdvneO9DEpsp8Y8Bz8w48RF0Q6b9IohnTfJcoP
   GlfRT6AuOIDRCcnctWqbVOW0aXKlDxpfaJAjNz2tqmJZUulO8uDQcFQNU
   mOdaiCHYxhtBvfrMmdL71nRHl9u/ftHJTf5SpyTQ1xGNzKBLO4dhFGjR9
   BySsQMKYgLFe3MwsHFLPIGv0K27wz65jMHDae9CJZFkVdgowdOQqsABsM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5265122"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="5265122"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 20:15:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="17131958"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 20:15:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 20:15:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 20:15:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 20:15:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvMxoiEdY1ooWoXDTZkv91jpqLEZQKZmMfRgsFxq6U9blFi/ECp2p6Kn3mstO7EJgx8yAbBU8nqPj/sXxA+EcVJiJBChnV7+2Jk/oDzJcUsOEgaeAlNEyF/XA/stziJTgE6OwbU5lwszjXgO1fNknlMzNb8OSpI3g873Dx7YyQnGhrIw3Pocs4REmg6KyfZangydhB0Xk7bolBiji+ka3CgeoywzQJkwmVPP4LM3TfkZLXInhGkmlQj/ufFdmRP1W84+J2WF3PUGOdbBdNLITz3xi/snJ+GtIO5FWnKRdp5qsYS5fg1yK+PuK7fuKhe76Sqcuc0Ty9Nj1MhssPUlCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJKaEO2VBMOm38pd6Fo3sH0gXiJX6f3f6E3dFniFTfA=;
 b=QJ3Oe/h7EKYAC+H6DbYQAL3dP1x7nggQKuClGiD1B68KYQHy78sO/7d18JTOopnuAAG/s5qcTYGZzeFZNqWfxcTYsgtVEJBdmWe3cU/OTF1pGyaPXGmrfIqH4W9ETOf7HDTD7YLnegnuPIGkw/o+ZI7oJeYzxFt+U186TMYHx6uWX3/bGtXa+oc8l+jPeje9hBfBk0tqx9B9D4Pc8VcqAhlDok5EvbNpkl1XLPYO4wed6qVO/OEy1fZVxt+BBqyE1eD87gRCp3b8fQQOMgBtUoN3+W+rwtRjC2YoXE0MEE2Akbfwiul2TQxHSfgZXxZCL9XYS1Gb7Oe9w+T9k2csCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by SJ1PR11MB6155.namprd11.prod.outlook.com (2603:10b6:a03:45e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 03:15:34 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::7e2b:daee:37b2:c2b9]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::7e2b:daee:37b2:c2b9%7]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 03:15:34 +0000
Date: Fri, 15 Mar 2024 11:10:40 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "Maciej W. Rozycki" <macro@orcam.me.uk>, Bjorn Helgaas
	<bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: Correct error reporting with PCIe failed link
 retraining
Message-ID: <ZfO8MKCVy7ZthUQr@xpf.sh.intel.com>
References: <alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk>
 <alpine.DEB.2.21.2402100045590.2376@angie.orcam.me.uk>
 <ZfKk+dYXkiRRkk+p@xpf.sh.intel.com>
 <d223a58a-8a4b-b745-c8c9-2e19d4742cdb@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d223a58a-8a4b-b745-c8c9-2e19d4742cdb@linux.intel.com>
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To SA2PR11MB4844.namprd11.prod.outlook.com
 (2603:10b6:806:f9::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4844:EE_|SJ1PR11MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: d65ed4e1-78d6-480c-68ef-08dc449e2d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1DHOMq2u8SpM2uX3fThPmfHMZapuCCgnb/ezba9qsdwLJzQNyrKaJQBttr1WfTCOvVwapdWF8TLnL6Ebm2/uOPG2DdDSULIV32lqEh38tl8Fj3inHTaRn6JBriiy9gc5v6GkYrgoIWGCZwzr01r/1xjvLdNmWlc/WCuGXjyluKs+X/aeFPTOCtpgz61v3VzseVbsoKehZTegDqE7tqWQIUngwFRN5Je8JAcNANgNkLQztCPdRb5od0GQFxVOKvV+r7UOrxmL+nlFOUh9nJuOpQhIeH7vmvPsoKtW2amDrPLjL+djoWUswKC6a5RyqJXqE2c0evlOEugbXfbQKj106fP5YGWm2ETKmbo2GEretuNtFxdYY7/Yq3VSK4klS2O0lr7e8C09sVMb8tggm4wWiKyEXGLVLGaFHmMwdYNSwssawoJsxThnBwgdnye919gfn5zosk3hu4SqIcFYkhPzTqHk+r+06CjFA4A7rza6OcB9F8CWfcvOjbQTW4DGAVR26bDjcfw52q8c7k+R0HYTyGPxQXLRKdPH41QrKNCVI8pw8XCJamnpMEnw6gOpr3xfQqow5ZzrdmlfNk+YY4+My1XmuirlOrlpZKg7WJn8Rz68vivYWwvmK9McsNbNfSPn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QAgSdgKVTAPmLfkPEv2SsDqIE/6rXoJxCG6/n9eCP7Ts+1l4UP3mWh1SmI?=
 =?iso-8859-1?Q?6QMbLK6Sqbc16ssc7ZmmrZpf0A2oyB3WXG6PcIFty60HkGA5RaN7nIL7dK?=
 =?iso-8859-1?Q?s5hfb13rLn9g+78ukVZIy55KqYd+hbX9AoNSOV+bGcms6l9Ca8SfBZwgFV?=
 =?iso-8859-1?Q?023ctVJT/ki9whmdmc8gE4Uy3VrFOVnM1/CWnbzcLQYT/X33OuTLwzb9j4?=
 =?iso-8859-1?Q?I76pGcaL7mxnsN+E2Y7X93D/4UJbS45Qh7L/entmm65tLd0B8apT9Dt+eY?=
 =?iso-8859-1?Q?0f6AkH/8/7GHxaq22bMh8ASU1Hxq3IIEkzLrZG1t4OUwrgBDJq2IRobMC1?=
 =?iso-8859-1?Q?UZFNr1yUvZFmo9LUwHzU2h4S9PuEsFqrwrBQnrlK5v4dDT1tVMugvtoeS0?=
 =?iso-8859-1?Q?NILCFeSuHCOWpPj7Ls6Umfrn37zX7J/iyzbKwCKcTRCgsoLuUqt4H7CZsK?=
 =?iso-8859-1?Q?FJWf1SEkOzxjkJNyIAKEXtW0a7gCZ0mbP0/L2h4M3J1k22sMkCV9AJ/lde?=
 =?iso-8859-1?Q?2/ScwwvWT4/vwuAZyd7qRa6V3zA1fbu0vHDCV5MwjQjXzoKU9wXMAu6Nps?=
 =?iso-8859-1?Q?fEJPzAa1eG1Sbbu/uaNltfor7lZo7lDvJN/fOEDINut+aEgtRk4nikcrOk?=
 =?iso-8859-1?Q?VFd+vQH7L8FsIfN/UfeOVoRyl0Z6nqkWtZHufRUQ+eabcX187gmA1GGAa/?=
 =?iso-8859-1?Q?nrPfj3T5m6yUF+td9JEvARuHoa5Hmg1uCXjA5T8gq6Oj3zwoW/3oSqRWye?=
 =?iso-8859-1?Q?eRoBjjRX7g6LOe2Pcn65Mfr3F6EbSejzoNubdaJ82dS/Xapkz+O5VKsYWL?=
 =?iso-8859-1?Q?z8IfEqiYtl9CmZ7og8MTWihhzE/q07W0VXKPTkvOn7vUOn1QkVDGhCLYsG?=
 =?iso-8859-1?Q?pfndCgj3h86byjHlOXvR9i/ABS4Y3JUUK90WPBjJnT3km/+c3ycjkoJ5k6?=
 =?iso-8859-1?Q?QdwlHQQojXB+f8mmbHBAI8RdhLEP7LVuv/6OJwNn6wTfosKZgyb5YVN4xS?=
 =?iso-8859-1?Q?RhXlbuMC83cLAtqjiwZo6MmXaX+arXW+XtSpcVmvrf/0wFyqJ29sdJKkRD?=
 =?iso-8859-1?Q?uIySLfHig9XzfZV9RmYNAVbZQzovwzVUhJmNf72+cdSHaoqbiiMbn5G+8Q?=
 =?iso-8859-1?Q?HX8dILOrRI4pUO8kiBrQJ6FToF9cwFcYq7OdWmQzfQGPTQRcS52CF522n7?=
 =?iso-8859-1?Q?OdNKwg+yd2tGoyr26xGFuVqXVkNWbOXA/2X86wMbluckNUejOn6VZ9i0NN?=
 =?iso-8859-1?Q?SvbHwM3vfxHzlLMMDm8PuY9krpj3klL4lKDzb3YxSVYmjPu6K8qKQmJArq?=
 =?iso-8859-1?Q?gU4Q3wRbyPUuRelI+tL+cP2SsV6d1e9rarWllg2CNTHB+nZsBfIuQZ28K6?=
 =?iso-8859-1?Q?FdeuDUPAlhdAObYKR83Z8czmZwahkjyLE4UE0VKYibNS6zEcxJEl6d2ioG?=
 =?iso-8859-1?Q?KFN+1ac4jAyjlafCkl0fdip/f4f9U9iZhiqxdI9HjnXEPfqD+ChSHbZlBb?=
 =?iso-8859-1?Q?nKEf8ZItLIndfHUZodL65Jv8AhX9tJOiEgNcLNrW005wUrqJootc1oX3Zc?=
 =?iso-8859-1?Q?/v9ResKXTqgT4vUk7lx4u7Gu2fZGAXq7xjUiebP4XZLIPSUHGlf4y9F4x6?=
 =?iso-8859-1?Q?/cMX6j1yHeIaa0eK3zeop+fxYMRowrBA2B?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d65ed4e1-78d6-480c-68ef-08dc449e2d89
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 03:15:34.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmPA4cljlGsX5FbTS7I+ojisrzqloj0s4gXH80sgEBSr6scUXKFDUNM4rLJDy171ore4WPQgmhEOhBQ3iaZU3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6155
X-OriginatorOrg: intel.com

Hi Ilpo Järvinen,

On 2024-03-14 at 19:27:36 +0800, Ilpo Järvinen wrote:
> On Thu, 14 Mar 2024, Pengfei Xu wrote:
> 
> > Hi Maciej W. Rozycki,
> > 
> > Greeting!
> > 
> > We tested intel internal Linux next kernel by syzkaller fuzz testing and met
> > "CPU soft lockup in __run_timers" problem in guest.
> > 
> > Bisect and find that the following patch is the first bad commit.
> 
> Hi,
> 
> I'm skeptical of this bisect result (perhaps some of the kernels marked 
> good are actually bad because the problem does not always trigger?).
> 
> Did you check what is the result if you put that patch on top of 6.8?

  Thanks for suggestion!
  I tried this commit on top of v6.8, CPU softlockup could be reproduced in
  23020s(6h23min), but not related to "__run_timers".
  And tried again v6.8 mainline kernel, it reproduced CPU softlockup in
  176s, but not related to "__run_timers".

  So, this issue triggered by "perf and ioctl" syscalls could lead to CPU
  softlockup with varying reasons.

  This issue cannot be reliably reproduced, resulting in incorrect
  bisection results.

  Please ignore the report specific to this commit.
  Sorry for inconvenience.

  Best Regards!
  Thanks!

> 
> -- 
>  i.
> 
> > Check the commit content is same as following patch.
> >
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240313_174939___run_timers
> > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240313_174939___run_timers/repro.c
> > Syzkaller reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240313_174939___run_timers/repro.prog
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240313_174939___run_timers/bisect_info.log
> > Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240313_174939___run_timers/0a53950322bc80aeebf56f5a9d38c847186a082a_dmesg.log
> > bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240313_174939___run_timers/bzImage_v6.8_problem.tar.gz
> > 
> > "
> > [   34.599994] hrtimer: interrupt took 63789 ns
> > [  102.443957] clocksource: Long readout interval, skipping watchdog check: cs_nsec: 3343956725 wd_nsec: 3343956627
> > [  393.043326] watchdog: BUG: soft lockup - CPU#1 stuck for 27s! [repro:2653]
> > [  393.043704] Modules linked in:
> > [  393.043856] irq event stamp: 17486443
> > [  393.044019] hardirqs last  enabled at (17486442): [<ffffffff855b0ebe>] irqentry_exit+0x3e/0xa0
> > [  393.044462] hardirqs last disabled at (17486443): [<ffffffff855aed94>] sysvec_apic_timer_interrupt+0x14/0xc0
> > [  393.044925] softirqs last  enabled at (14336234): [<ffffffff8126c828>] __irq_exit_rcu+0xa8/0x110
> > [  393.045332] softirqs last disabled at (14336237): [<ffffffff8126c828>] __irq_exit_rcu+0xa8/0x110
> > [  393.045740] CPU: 1 PID: 2653 Comm: repro Not tainted 6.8.0-0a53950322bc+ #1
> > [  393.046062] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [  393.046618] RIP: 0010:preempt_count_sub+0x6c/0x160
> > [  393.046856] Code: ed 07 85 c9 75 1b 65 8b 05 d9 7b d2 7e 89 c2 81 e2 ff ff ff 7f 39 da 7c 1b 81 fb fe 00 00 00 76 6b f7 db 65 01 1d bc 7b d2 7e <48> 8b 5d f8 c9 c3 cc cc cc cc e8 d5 36 9d 01 85 c0 74 ed 48 c7 c0
> > [  393.047696] RSP: 0018:ffff88806cd09da0 EFLAGS: 00000213
> > [  393.047950] RAX: 0000000000000102 RBX: 00000000ffffffff RCX: 0000000000000000
> > [  393.048281] RDX: 0000000000000102 RSI: 0000000000000102 RDI: 0000000000000001
> > [  393.048611] RBP: ffff88806cd09da8 R08: 0000000000000001 R09: fffffbfff11caa46
> > [  393.048943] R10: ffffffff88e55237 R11: 0000000000000001 R12: ffff88806cd32a00
> > [  393.049277] R13: ffffffff81516e90 R14: dffffc0000000000 R15: ffff88806cd32a00
> > [  393.049611] FS:  0000000000000000(0000) GS:ffff88806cd00000(0000) knlGS:0000000000000000
> > [  393.049987] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  393.050261] CR2: 00007febf5bfa838 CR3: 000000000bda4006 CR4: 0000000000770ef0
> > [  393.050596] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [  393.050928] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> > [  393.051262] PKRU: 55555554
> > [  393.051396] Call Trace:
> > [  393.051521]  <IRQ>
> > [  393.051630]  ? show_regs+0xa9/0xc0
> > [  393.051805]  ? watchdog_timer_fn+0x531/0x6b0
> > [  393.052019]  ? __pfx_watchdog_timer_fn+0x10/0x10
> > [  393.052255]  ? __hrtimer_run_queues+0x1a4/0xc00
> > [  393.052505]  ? __pfx___hrtimer_run_queues+0x10/0x10
> > [  393.052770]  ? hrtimer_interrupt+0x324/0x7a0
> > [  393.052994]  ? __sysvec_apic_timer_interrupt+0x105/0x3c0
> > [  393.053254]  ? sysvec_apic_timer_interrupt+0x4b/0xc0
> > [  393.053495]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
> > [  393.053757]  ? __pfx_clocksource_watchdog+0x10/0x10
> > [  393.054002]  ? preempt_count_sub+0x6c/0x160
> > [  393.054213]  _raw_spin_unlock_irq+0x3c/0x60
> > [  393.054423]  __run_timers.part.0+0x6c9/0xa40
> > [  393.054647]  ? __pfx___run_timers.part.0+0x10/0x10
> > [  393.054883]  ? sysvec_irq_work+0x8b/0x100
> > [  393.055087]  ? asm_sysvec_irq_work+0x1f/0x30
> > [  393.055314]  run_timer_softirq+0xbc/0x1c0
> > [  393.055517]  __do_softirq+0x1cb/0x84a
> > [  393.055709]  __irq_exit_rcu+0xa8/0x110
> > [  393.055899]  irq_exit_rcu+0x12/0x30
> > [  393.056078]  sysvec_apic_timer_interrupt+0xa5/0xc0
> > [  393.056314]  </IRQ>
> > [  393.056422]  <TASK>
> > [  393.056532]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
> > [  393.056781] RIP: 0010:__schedule+0xbe/0x30c0
> > [  393.056993] Code: c0 e8 e6 a8 fd ff 48 98 48 8d 3c c5 a0 dc 75 86 48 89 fa 48 c1 ea 03 42 80 3c 2a 00 0f 85 81 28 00 00 4c 03 24 c5 a0 dc 75 86 <49> 8d 84 24 58 0a 00 00 48 89 c2 48 89 85 e0 fe ff ff 48 b8 00 00
> > [  393.057847] RSP: 0018:ffff888024f3f6e8 EFLAGS: 00000282
> > [  393.058101] RAX: 0000000000000001 RBX: 0000000000046380 RCX: 0000000000000001
> > [  393.058437] RDX: 1ffffffff0cebb95 RSI: 0000000000000001 RDI: ffffffff8675dca8
> > [  393.058771] RBP: ffff888024f3f820 R08: 0000000000000001 R09: 0000000000000002
> > [  393.059107] R10: 0000000000406000 R11: 0000000000000001 R12: ffff88806cd46380
> > [  393.059442] R13: dffffc0000000000 R14: ffffffff855da674 R15: 0000000000406000
> > [  393.059779]  ? __cond_resched+0x24/0x30
> > [  393.059982]  ? __schedule+0x9a/0x30c0
> > [  393.060173]  ? lockdep_hardirqs_on+0x8a/0x110
> > [  393.060408]  ? trace_hardirqs_on+0x26/0x120
> > [  393.060637]  ? __pfx___schedule+0x10/0x10
> > [  393.060836]  ? __this_cpu_preempt_check+0x21/0x30
> > [  393.061068]  ? lock_release+0x417/0x7e0
> > [  393.061267]  ? __this_cpu_preempt_check+0x21/0x30
> > [  393.061497]  ? lock_is_held_type+0xf0/0x150
> > [  393.061705]  ? __cond_resched+0x24/0x30
> > [  393.061895]  preempt_schedule_common+0x4a/0xd0
> > [  393.062118]  __cond_resched+0x24/0x30
> > [  393.062302]  unmap_page_range+0xab4/0x3690
> > [  393.062530]  ? __pfx_unmap_page_range+0x10/0x10
> > [  393.062752]  ? __this_cpu_preempt_check+0x21/0x30
> > [  393.062989]  ? uprobe_munmap+0xb0/0x590
> > [  393.063186]  unmap_single_vma+0x1ac/0x2d0
> > [  393.063390]  unmap_vmas+0x210/0x470
> > [  393.063572]  ? __pfx_unmap_vmas+0x10/0x10
> > [  393.063769]  ? __pfx_lock_release+0x10/0x10
> > [  393.063977]  ? lock_release+0x417/0x7e0
> > [  393.064167]  ? __pfx_folio_batch_move_lru+0x10/0x10
> > [  393.064410]  ? __pfx_lock_release+0x10/0x10
> > [  393.064624]  ? mlock_drain_local+0x281/0x4b0
> > [  393.064844]  exit_mmap+0x19b/0xac0
> > [  393.065018]  ? mark_lock.part.0+0xf3/0x17a0
> > [  393.065233]  ? __pfx_exit_mmap+0x10/0x10
> > [  393.065427]  ? __kasan_check_write+0x18/0x20
> > [  393.065644]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
> > [  393.065909]  ? mutex_unlock+0x16/0x20
> > [  393.066096]  __mmput+0xde/0x3e0
> > [  393.066256]  mmput+0x74/0x90
> > [  393.066407]  do_exit+0xa59/0x28c0
> > [  393.066580]  ? lock_release+0x417/0x7e0
> > [  393.066778]  ? __pfx_lock_release+0x10/0x10
> > [  393.066989]  ? __pfx_do_exit+0x10/0x10
> > [  393.067179]  ? __this_cpu_preempt_check+0x21/0x30
> > [  393.067410]  ? _raw_spin_unlock_irq+0x2c/0x60
> > [  393.067630]  ? lockdep_hardirqs_on+0x8a/0x110
> > [  393.067845]  ? _raw_spin_unlock_irq+0x2c/0x60
> > [  393.068064]  ? trace_hardirqs_on+0x26/0x120
> > [  393.068287]  do_group_exit+0xe5/0x2c0
> > [  393.068489]  __x64_sys_exit_group+0x4d/0x60
> > [  393.068707]  do_syscall_64+0x73/0x150
> > [  393.068894]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [  393.069140] RIP: 0033:0x7febf5b18a4d
> > [  393.069319] Code: Unable to access opcode bytes at 0x7febf5b18a23.
> > "
> > 
> > ---
> > 
> > If you don't need the following environment to reproduce the problem or if you
> > already have one reproduced environment, please ignore the following information.
> > 
> > How to reproduce:
> > git clone https://gitlab.com/xupengfe/repro_vm_env.git
> > cd repro_vm_env
> > tar -xvf repro_vm_env.tar.gz
> > cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
> >   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
> >   // You could change the bzImage_xxx as you want
> >   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> > You could use below command to log in, there is no password for root.
> > ssh -p 10023 root@localhost
> > 
> > After login vm(virtual machine) successfully, you could transfer reproduced
> > binary to the vm by below way, and reproduce the problem in vm:
> > gcc -pthread -o repro repro.c
> > scp -P 10023 repro root@localhost:/root/
> > 
> > Get the bzImage for target kernel:
> > Please use target kconfig and copy it to kernel_src/.config
> > make olddefconfig
> > make -jx bzImage           //x should equal or less than cpu num your pc has
> > 
> > Fill the bzImage file into above start3.sh to load the target kernel in vm.
> > 
> > 
> > Tips:
> > If you already have qemu-system-x86_64, please ignore below info.
> > If you want to install qemu v7.1.0 version:
> > git clone https://github.com/qemu/qemu.git
> > cd qemu
> > git checkout -f v7.1.0
> > mkdir build
> > cd build
> > yum install -y ninja-build.x86_64
> > yum -y install libslirp-devel.x86_64
> > ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> > make
> > make install
> > ---
> > 
> > Best Regards,
> > Thanks!
> > 
> > On 2024-02-10 at 01:43:50 +0000, Maciej W. Rozycki wrote:
> > > Only return successful completion status from `pcie_failed_link_retrain' 
> > > if retraining has actually been done, preventing excessive delays from 
> > > being triggered at call sites in a hope that communication will finally 
> > > be established with the downstream device where in fact nothing has been 
> > > done about the link in question that would justify such a hope.
> > > 
> > > Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> > > Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > Link: https://lore.kernel.org/r/aa2d1c4e-9961-d54a-00c7-ddf8e858a9b0@linux.intel.com/
> > > Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> > > Cc: stable@vger.kernel.org # v6.5+
> > > ---
> > >  drivers/pci/quirks.c |   18 +++++++++++-------
> > >  1 file changed, 11 insertions(+), 7 deletions(-)
> > > 
> > > linux-pcie-failed-link-retrain-status-fix.diff
> > > Index: linux-macro/drivers/pci/quirks.c
> > > ===================================================================
> > > --- linux-macro.orig/drivers/pci/quirks.c
> > > +++ linux-macro/drivers/pci/quirks.c
> > > @@ -74,7 +74,8 @@
> > >   * firmware may have already arranged and lift it with ports that already
> > >   * report their data link being up.
> > >   *
> > > - * Return TRUE if the link has been successfully retrained, otherwise FALSE.
> > > + * Return TRUE if the link has been successfully retrained, otherwise FALSE,
> > > + * also when retraining was not needed in the first place.
> > >   */
> > >  bool pcie_failed_link_retrain(struct pci_dev *dev)
> > >  {
> > > @@ -83,10 +84,11 @@ bool pcie_failed_link_retrain(struct pci
> > >  		{}
> > >  	};
> > >  	u16 lnksta, lnkctl2;
> > > +	bool ret = false;
> > >  
> > >  	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
> > >  	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
> > > -		return false;
> > > +		return ret;
> > >  
> > >  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
> > >  	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> > > @@ -98,9 +100,10 @@ bool pcie_failed_link_retrain(struct pci
> > >  		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
> > >  		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
> > >  
> > > -		if (pcie_retrain_link(dev, false)) {
> > > +		ret = pcie_retrain_link(dev, false) == 0;
> > > +		if (!ret) {
> > >  			pci_info(dev, "retraining failed\n");
> > > -			return false;
> > > +			return ret;
> > >  		}
> > >  
> > >  		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> > > @@ -117,13 +120,14 @@ bool pcie_failed_link_retrain(struct pci
> > >  		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
> > >  		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
> > >  
> > > -		if (pcie_retrain_link(dev, false)) {
> > > +		ret = pcie_retrain_link(dev, false) == 0;
> > > +		if (!ret) {
> > >  			pci_info(dev, "retraining failed\n");
> > > -			return false;
> > > +			return ret;
> > >  		}
> > >  	}
> > >  
> > > -	return true;
> > > +	return ret;
> > >  }
> > >  
> > >  static ktime_t fixup_debug_start(struct pci_dev *dev,
> 

