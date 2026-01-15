Return-Path: <linux-pci+bounces-44964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A301AD255CF
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E64A30E3789
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A13B8BCD;
	Thu, 15 Jan 2026 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z11DJnqL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096943B8D4B;
	Thu, 15 Jan 2026 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490772; cv=fail; b=abUhHRVm9XJJ+yAyyZUPlupmdJ1YNoo81zmWpjFFx9GNu9nU//VwA36Cw09n35SYXCfjz+ceB2sZoGnVFlaQXDf3mmsEU049JAGQ1aO9NrOLW1JbWCA2Ugl/k7wy7rP/drI8D9OOUG7JDvxfpcqho2vL/j9jm2fEfJLllhe+jCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490772; c=relaxed/simple;
	bh=PZbX+zc7i2Ez6ntXR4wGWXXU3z004j6oy034Jl04Prk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PETJm1X4DwniRmcfdJXl25HjSFKOI+Sai137x1CaOSjZc6mKNwTcOPvIg3aLyzgn2EBLOF/JU4pUCKjJq8sJUC+uPCoEVIW191FbDJ+tdROXRAmJS39s4QcV9KxAo1g5wmq3MG7EeKENFKLZMtD/Kqok9adPI757YZYGmL4Q6hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z11DJnqL; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768490768; x=1800026768;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PZbX+zc7i2Ez6ntXR4wGWXXU3z004j6oy034Jl04Prk=;
  b=Z11DJnqLOYO+hW2QGqThuvNH2L8fR4f2JtbU8TDfakhF90KbAyo0wMHr
   p9Df0x1I5eGGgdsab0FeknGztqrP+TWe9uAlxSqubOEaZ4fPKwbvAX1vy
   g8+Wa/JflmP+Ikm9UEzc2d9k22FO+QNPXgD6A5vn9Tic2I4yqDedAouVR
   GyVVKrBeMhByVbkWydbQDOcFvNaV3fv6LYoavhZNBzstLp5mr4xtipZJd
   hY+HKC+wlXW6KsvgSmGARQhGCotdEBpGgvsF4MyC7VEzGzI7UEcnfTslG
   F7p5uhIC5AJJAWHmsExShlM0hzlUSd0Ww+GHBmn83ymcnQ+oRwDS5faBr
   Q==;
X-CSE-ConnectionGUID: hJzDULlsSBy9hnTVYKPLBA==
X-CSE-MsgGUID: BxmVeOfPS1SBqWbljanLDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="73650713"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="73650713"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 07:25:37 -0800
X-CSE-ConnectionGUID: az6AUwNbS3anS9EAiZtXTA==
X-CSE-MsgGUID: H+/2RV0ER+KNpeCimxP7Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="228053466"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 07:25:36 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 07:25:35 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 07:25:35 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.61)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 07:25:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4A22wx86nJRXRouffQCzCiAOJ3o5fA90w0kPVpgCr53muHyRl7qfrppwLn/KvcOTiiNsOsu6zJxahNxDJCxNzrsoF2FRWr3IrQp4JBEJNcnNHg0d7kUZNH/cxrHHjPx9JbX+l8C6RocoHQ7G4gtdVaAJr8uSayAFHaUnYXvGbzhI4Ag4psmasmeKJ++cmR1kOZt07hs5WwIQeImo3YY99EUpP/DFKE0F2QKjsHcxNwNilMDkUyFCRagSL4Kv4kKUC1gND7n6tgpEiS80fOJ4ILPdWvIxzoKfjLXHLXx5nzaC/j4QBGyBZKvLXgrRynYIKl6J+cctUsZSrWZhA3iew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3G1VXhA39ta5UsWt8J3P2BUEXDcgiZqDa93kbczGyIY=;
 b=GYz9x9pQgyyrRbnyUxbfCF9ma3dFRs7OBXXLTI0ko74PeFSGcT6MFm8e+4rkQYVcrpitvY0ufhOMQH8pzDiR26XcPuGeanYLwREsSTAOJGYtaaq+c0wCxXP1mwBO/uB2LXvEgDcRla7IrxrDHe7xvqaTplD8lM/XDn0j7lckh7EzpWR5Tk59/ZGd1y5SXQnyF0O45XmUCRGt21cd+8KbA/XNkh83BKwLnaQ4a+sCk6WP8lN2N91j0Mr4mIU37z6l9nhSfmMnRK8YP7V9ycNvU8bFhglpS5Mi5jJM4vSfSdiPiY+tTmVVTIqKr8T+aCRgdp0ccymkjNZvRWrM1ABl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 15:25:32 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 15:25:32 +0000
Date: Thu, 15 Jan 2026 10:25:25 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
CC: Badal Nilawar <badal.nilawar@intel.com>, <intel-xe@lists.freedesktop.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<anshuman.gupta@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>, <karthik.poosa@intel.com>, <matthew.auld@intel.com>,
	<sk.anirban@intel.com>, <raag.jadav@intel.com>
Subject: Re: [PATCH v6 06/12] drm/xe/vrsr: Enable VRSR on default VGA boot
 device
Message-ID: <aWkG5cEapt_attfS@intel.com>
References: <20260113164200.1151788-14-badal.nilawar@intel.com>
 <20260113164200.1151788-20-badal.nilawar@intel.com>
 <64894565d5eace99fd65f290ee807dabaa2de04f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64894565d5eace99fd65f290ee807dabaa2de04f@intel.com>
X-ClientProxiedBy: BYAPR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:a03:80::31) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|DS0PR11MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cee31ea-6082-4a76-5280-08de544a521f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EldUA5sbtE6mAH3hzLSxzCbyNKb8+C9peRdWM8OzBALV86k3I3TV2VK4z3/6?=
 =?us-ascii?Q?NLfFkjM1dj+XkwAlgqnyoa65jD+5xPlaRFJkwKcC1I68DzlZyKk3WZ9VubYs?=
 =?us-ascii?Q?jVR5iGQne5OjkIDJAy/HWy9zku2Vz6EemNPpK3XQ7o3nmlnBrJgFi9QlC52Q?=
 =?us-ascii?Q?dd+VppVytdzALcuH7z/CVVfO69L8KXc2uXtHR/gyfw2ZL95YP0FJvhJm4ExB?=
 =?us-ascii?Q?PBC1uPWizive88kp4FnAp3+J+CEuttNreaRewEugYMRPnGiXJGCwW2NoXw8i?=
 =?us-ascii?Q?vDkVJ9r0cM+gqTRtO0mt0j8uqJFPHui/2fVYkObfX7Dcvf34Fs7Kb+J3ll6f?=
 =?us-ascii?Q?aqmU6s1hcrnnPPAjQPzr0pAys8LOUsH6cKe0ObfAnZ5sXN5v3aDCG8NKkyM+?=
 =?us-ascii?Q?40D1aShSDwlPD1KxO3v6EKJ7jf1RLCwYGPCVd2qMI/hpoF/Us+ssvDunrRZv?=
 =?us-ascii?Q?lsbWaG5gr8bR2Btd5wJepfQDDGbfHZuy/dzgfFfNpdyzJ5UOkXg01DCNHy9e?=
 =?us-ascii?Q?U/JyXc2Ob+I+wm0LeW+MtySodItRj2bYQ/oyIi0rHXwhlZ4j1ZNBeTmse+Do?=
 =?us-ascii?Q?eg0rtg5gzZIOiF/EuA3xZuCfi2Z3xuAZSAw+V4qt4GA6POuTRNLu+QtyfgYb?=
 =?us-ascii?Q?nQuuEqxh3Zalhw2toTKrZJHHMprSa3baL2fXSrY+JUoQUuGFKr9Hli4mqNsc?=
 =?us-ascii?Q?YbjdH34SkAlXeBHsoWatk3o9ScC9hb03/0ghAu2fNYsI/oSnL8y4rk3nSCxZ?=
 =?us-ascii?Q?wnxUpdsIKh5dUgOSCaYqOcZh+UUQIqEEl0nqI8dCWLkMWz4Ke7oAZzPriL6f?=
 =?us-ascii?Q?dFrpLp2mJomB9kJbeacDJPHPjhHMX0iERtZuGvx25WHPcTFnd1SYVlrKgpSQ?=
 =?us-ascii?Q?nblzpUiAh672T2FmsfG6Yrc59KOiGSKCNiZY4nEZPmdJCd6i7wwl+RfpqLLX?=
 =?us-ascii?Q?9e74MO4ECf6eqRnio/z8mYmztZSQoTYOWNTPJhkT3YJjjNOBgEnXAFHylMSK?=
 =?us-ascii?Q?whEfVc1mcEjdAFkW4/MBY2xlUSXrPyBSI7VjJViPg10FsdyY7/68qIzuC9oO?=
 =?us-ascii?Q?7g/+Q0zmPjUnyTkMbppEr0dtNivuKj9oiXmVCdh+bIlo9rRes9+843vRh+yt?=
 =?us-ascii?Q?TgxVG/QvUo6O0ZZUMYgx2oztj2SyfF0YIv6taqy0zjG0bY65kylBeSsru2iD?=
 =?us-ascii?Q?u9d/0RnlG4kXkWyhADyXb3ITa8zJDKuaOprEGkMmV4kIWMwLraktyEVOVdlK?=
 =?us-ascii?Q?oyrKXPXUBonCKJePDHoq9YMwX80bF16YzjbcrBXs8TGvhi7/eRJ/H1lI1bNr?=
 =?us-ascii?Q?wc0EPT/jzudwgoXVgTQ7WQIje1r8DQpwFBGacLfxZws4SBWQxrmU3jhd0iwd?=
 =?us-ascii?Q?v3qA0UsO4TnU9LMBcj6LpG3Ig9XKrSjaOMdBy/PdP6eX/6NlyHOG5H858+hz?=
 =?us-ascii?Q?tblSqpqsxD5vpwF68+yM+N20K+hmDiC8nI+goGe7FzenURGeFVScSrCyKQBW?=
 =?us-ascii?Q?RCjo8RMANrLwZB4SX3x8D6cH32MPHCZqdPlRQ9wHhBb6eJ4SsRU7vyHUZeGv?=
 =?us-ascii?Q?OLsiYlvUrbv8v9Krus8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xXJeFiNYYayfX1/VBcLBymNCOr1IjJFcUrGmBfx/VWOC2FaLkc6DjlsE4C3K?=
 =?us-ascii?Q?QN+n7tNvnYtgfXfFB0kr47QTdVfbxvYYqs0oyo7LxaoUVE/inN0pKiTzyBVO?=
 =?us-ascii?Q?3ya98Vu08dcWc6pPqyDusCgWigcshhT8sbduze4p55TjB99yf+fezVMr6gwK?=
 =?us-ascii?Q?2O8agAdjlLdVqHrJ2YDVS8IIbLVmaEeNVjB0j2vw9eWwnnVyud+6xsxTBkJJ?=
 =?us-ascii?Q?X0jfdvdQioX0aXJDr/ciMdEX4LG2/3GxUhJ1Y1WnMwG1qKsOrtAHIh9wp1q8?=
 =?us-ascii?Q?nW3Nfh0bVlClIh2krpbA+OlO9PiiC+Q8cM0LWhxDPZ0sDuBEu2+ePl0p1d0j?=
 =?us-ascii?Q?lIbE2/c0oIeZvtr8gnGYPVIPSOtaGJzL4sC4YWmBB6Hq2SXu0ECXRuFTxQgS?=
 =?us-ascii?Q?onj6Vte23vX3+2qFwT+bca/CdXyJOxjqsFtb5M6wTgdYS/3uJf2yqrx2kXFb?=
 =?us-ascii?Q?ojxJU30DH8lbazctJO6IgEExUNwFOzC3oychRbq6AaniR3WppLiF5vfDRwAA?=
 =?us-ascii?Q?A9wMTivEovK8BBzeVLf4velpHmB6RtXoXEA3h0n6psXsNCCBcaIUM3pfgc7F?=
 =?us-ascii?Q?mn11l6CO4qe1kOqp1hrDaQU0QPWa0Ro4jIb0Z4Jz8oUS8k65DBXWapAv/lLt?=
 =?us-ascii?Q?DlCDbNI/RSX9XwE2iZV4S5IEWbFAgyAALS7+gyUVoVt2by+E3IBTUHVN/372?=
 =?us-ascii?Q?6BmJd2Vb/CgyItA02d65EDGGqS8xuqEOdvD4wyJ962tdy4tItOM5ix2vcTT/?=
 =?us-ascii?Q?GI4A+M8kPx6gniFwNNpxd90bjOQQaFYqzCSbwzoitGpGMI7UzCkosbqHJHh+?=
 =?us-ascii?Q?uEuAJQfm9eGRaawcw6u5L38H0NmDXNO03USA3DmqHWAxsIjgqxavr8cWnmsO?=
 =?us-ascii?Q?Cw1x6qqm+bgVexAn2tJvmPxkoCWnAg2xig4Dkko5UdkIhEXM+vHCjfEx17uN?=
 =?us-ascii?Q?quSfIzo3v84+ZR5Tsi3WcnKBtLEAOUaBw83e20yujnqG1v6Ci+Hb7qu+cJ4D?=
 =?us-ascii?Q?R/ZK/VlRWdnER+wFbGMj/lxZqLuNWhXy6G44pfeNiWDbiHbQ9hgS5QDz24Xw?=
 =?us-ascii?Q?ly1iU4Lg6meMVWcFHeWihS1y7NGsb9vWEi1jvVJiH+TNqJd12C2Nu6Lv9fUS?=
 =?us-ascii?Q?NcottoVQ6UFw6xKJeWKL8GG/Dd+5IyFOyBnF5x6I4VCcp4jmI0TfOGXVr8Lk?=
 =?us-ascii?Q?XW2Ys9oUz6k/2sfhMk29BxddiCklMjSZuxOSk8r5Us9wAgtX+DZdD3KUaQ2q?=
 =?us-ascii?Q?FC0BOCWLy0suVq7wPQY2/WdI852NCY0FqZR6Sqk8fUDAlhHFeR17JiXK27QJ?=
 =?us-ascii?Q?kMlKyk+6X5wpwoffH5+F67XPMMriqdBPM/twDOvpjQ5uZdC2uvh2w7UkaGoz?=
 =?us-ascii?Q?Q6FayUK3X+Ah+Mkw8CPYpCtvSA7ec+/PmP2BcpakOShKcq+L69Jy9/7yv772?=
 =?us-ascii?Q?tso49SYm68djOgXfVeQLDR6b/lg3xYQ1j5sYOuy2j3wVO0ypfRdkAgXx8Yqp?=
 =?us-ascii?Q?A6OZVqqowfAL9sBASSn0L/EPrqkdyvno2pPsoaeMuNbpX+N7bkakPerKpwz9?=
 =?us-ascii?Q?OogWhUK2hwnONkVFn6GM4zLovEXll+rZIv7+GoL7gd8reTS8bzrgc8Cmx9ED?=
 =?us-ascii?Q?aWHp63bYPXz26/Fz4zgNG9UkcQ/aLSCpt4Mle6bEkENEbAFyF5I9dnv943xO?=
 =?us-ascii?Q?Jgun9fF/UaMKkRGevCdhuZ/8opuLWBe7WzqZsqppS91ze8+9rhQLoVfKnF0S?=
 =?us-ascii?Q?9w9ohI+Mkg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cee31ea-6082-4a76-5280-08de544a521f
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 15:25:31.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfttEAso0QKYezvUgfRV0to1tdGwYXNk1C8O9G4LsfwEHjl3I/fQr0rRwAFxVmPDCaoifdmIxAAMh0LkUxWRPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
X-OriginatorOrg: intel.com

On Thu, Jan 15, 2026 at 04:25:06PM +0200, Jani Nikula wrote:
> On Tue, 13 Jan 2026, Badal Nilawar <badal.nilawar@intel.com> wrote:
> > The VRSR feature is to enhance the display screen refresh experience
> > when the device exits from the D3cold state. Therefore, apply the VRSR
> > feature to the default VGA boot device and when a display is connected.
> 
> I don't understand how you get from the 1st sentence "therefore" the 2nd
> sentence. Please elaborate what you're trying to do here, and why.

On a scenario with multiple GPU, only one can use the aux power and the
feature itself was mainly designed for the display case - to bring up
display faster after the d3cold.

But yes, the right explanation for the why needs to be here.

Also, although unlikely, we never know what users can do out there, and
perhaps we will have someone with multiple cards and display plugged in
more than one?! We probably also need a global counter/flag to avoid
a second one to quick in.

But we definitely need to prioritize the first one with display connected.

> 
> So we have xe_pci_probe() -> xe_pm_init() -> xe_pm_vrsr_init() ->
> xe_display_connected() -> intel_display_connected(), and that's the only
> path and point in time to check whether displays are connected. If not,
> the decision is "not VRSR capable", which is just a weird concusion to
> make. The *capability* does not depend on displays, does it?
> 
> If you boot a device without a display, and then plug in a display, no
> VRSR for you?

yeap, it looks like the check is in the wrong place. It needs to be
checked when going to d3cold...

> 
> More comments inline.
> 
> > v2: Move generic display logic to i915/display (Jani)
> >
> > Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> > Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_display.c | 22 ++++++++++++++++++++
> >  drivers/gpu/drm/i915/display/intel_display.h |  1 +
> >  drivers/gpu/drm/xe/display/xe_display.c      |  5 +++++
> >  drivers/gpu/drm/xe/display/xe_display.h      |  2 ++
> >  drivers/gpu/drm/xe/xe_pm.c                   |  5 +++++
> >  5 files changed, 35 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> > index 81b3a6692ca2..97c74272fb19 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display.c
> > @@ -8426,3 +8426,25 @@ bool intel_scanout_needs_vtd_wa(struct intel_display *display)
> >  {
> >  	return IS_DISPLAY_VER(display, 6, 11) && intel_display_vtd_active(display);
> >  }
> > +
> > +bool intel_display_connected(struct intel_display *display)
> > +{
> > +	struct drm_connector *list_connector;
> > +	struct drm_connector_list_iter iter;
> > +	bool ret = false;
> > +
> > +	mutex_lock(&display->drm->mode_config.mutex);
> > +	drm_connector_list_iter_begin(display->drm, &iter);
> > +
> > +	drm_for_each_connector_iter(list_connector, &iter) {
> > +		if (list_connector->status == connector_status_connected) {
> > +			ret = true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	drm_connector_list_iter_end(&iter);
> > +	mutex_unlock(&display->drm->mode_config.mutex);
> > +
> > +	return ret;
> > +}
> > diff --git a/drivers/gpu/drm/i915/display/intel_display.h b/drivers/gpu/drm/i915/display/intel_display.h
> > index f8e6e4e82722..20690aa59324 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display.h
> > +++ b/drivers/gpu/drm/i915/display/intel_display.h
> > @@ -560,5 +560,6 @@ bool assert_port_valid(struct intel_display *display, enum port port);
> >  
> >  bool intel_scanout_needs_vtd_wa(struct intel_display *display);
> >  int intel_crtc_num_joined_pipes(const struct intel_crtc_state *crtc_state);
> > +bool intel_display_connected(struct intel_display *display);
> >  
> >  #endif
> > diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
> > index f8a831b5dc7d..54ed39b257ad 100644
> > --- a/drivers/gpu/drm/xe/display/xe_display.c
> > +++ b/drivers/gpu/drm/xe/display/xe_display.c
> > @@ -64,6 +64,11 @@ bool xe_display_driver_probe_defer(struct pci_dev *pdev)
> >  	return intel_display_driver_probe_defer(pdev);
> >  }
> >  
> > +bool xe_display_connected(struct xe_device *xe)
> > +{
> > +	return intel_display_connected(xe->display);
> > +}
> > +
> >  /**
> >   * xe_display_driver_set_hooks - Add driver flags and hooks for display
> >   * @driver: DRM device driver
> > diff --git a/drivers/gpu/drm/xe/display/xe_display.h b/drivers/gpu/drm/xe/display/xe_display.h
> > index 76db95c25f7e..11d4b09808e5 100644
> > --- a/drivers/gpu/drm/xe/display/xe_display.h
> > +++ b/drivers/gpu/drm/xe/display/xe_display.h
> > @@ -37,6 +37,7 @@ void xe_display_pm_resume(struct xe_device *xe);
> >  void xe_display_pm_runtime_suspend(struct xe_device *xe);
> >  void xe_display_pm_runtime_suspend_late(struct xe_device *xe);
> >  void xe_display_pm_runtime_resume(struct xe_device *xe);
> > +bool xe_display_connected(struct xe_device *xe);
> >  
> >  #else
> >  
> > @@ -67,5 +68,6 @@ static inline void xe_display_pm_runtime_suspend(struct xe_device *xe) {}
> >  static inline void xe_display_pm_runtime_suspend_late(struct xe_device *xe) {}
> >  static inline void xe_display_pm_runtime_resume(struct xe_device *xe) {}
> >  
> > +static inline bool xe_display_connected(struct xe_device *xe) { return false; }
> 
> There was a blank line before #endif. Please keep it. Ditto throughout
> the series.
> 
> >  #endif /* CONFIG_DRM_XE_DISPLAY */
> >  #endif /* _XE_DISPLAY_H_ */
> > diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> > index 3fe673f0f87d..e7aa876ce9e0 100644
> > --- a/drivers/gpu/drm/xe/xe_pm.c
> > +++ b/drivers/gpu/drm/xe/xe_pm.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/fault-inject.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/suspend.h>
> > +#include <linux/vgaarb.h>
> >  
> >  #include <drm/drm_managed.h>
> >  #include <drm/ttm/ttm_placement.h>
> > @@ -387,6 +388,7 @@ static int pci_acpi_aux_power_setup(struct xe_device *xe)
> >  
> >  static void xe_pm_vrsr_init(struct xe_device *xe)
> >  {
> > +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> >  	int ret;
> >  
> >  	if (!xe->info.has_vrsr)
> > @@ -395,6 +397,9 @@ static void xe_pm_vrsr_init(struct xe_device *xe)
> >  	if (!xe_pm_vrsr_capable(xe))
> >  		return;
> >  
> > +	if (pdev != vga_default_device() || !xe_display_connected(xe))
> 
> Simply considering the places in the kernel that call
> vga_default_device(), this just doesn't feel right.

I also don't understand why to check this vga default device...

> 
> 
> BR,
> Jani.
> 
> 
> > +		return;
> > +
> >  	/*
> >  	 * If the VRSR initialization fails, the device will proceed with the regular
> >  	 * D3cold flow
> 
> -- 
> Jani Nikula, Intel

