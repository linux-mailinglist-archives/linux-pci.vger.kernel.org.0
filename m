Return-Path: <linux-pci+bounces-11459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE75594B146
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 22:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCB81C212B6
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 20:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84664145A07;
	Wed,  7 Aug 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWNSa9AW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048214262C;
	Wed,  7 Aug 2024 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723062517; cv=fail; b=bkMkEZE7Lu2YK/AmNri5DRFqtePspZNElu1PBvj47offiPfAMFEUIvCvphsRfReUos25lneKruXZ41U3xLzhjgKMDyGa8/bENfOSDTpy0anJowJzsE1baNVWmq3lScP+3fxGjANt6yW6jRlTn+/Fu4F4fJuMXdhp3AYBkuRBSCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723062517; c=relaxed/simple;
	bh=rG7a9oNYH7iALs0OG6bNPS46FD6hupfk0ThmKa1uRm4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k2hACWKyAgF0cVPQyEDzjuIXqGgksv4ogKP8u9npHp7iU0M/aeS7Cbl7xaEmD2Z7aMfzoULVW6GFTEbvYu6oxbxiH7Oqv4MzfnQQ3vXPFXe2YE0yW4KmyxG3lCLSnqGpzuTKw61TiiRNiKHfvmD6wH8gsX5yS7fVJmXCvFMWby4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWNSa9AW; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723062515; x=1754598515;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rG7a9oNYH7iALs0OG6bNPS46FD6hupfk0ThmKa1uRm4=;
  b=TWNSa9AWJvLpqxa4P3HpSq6Ru9su9BVr/U575x6zgHmcBtsCAiNURJhg
   MH/SrQRY7VbLiILQhxY4WyflaVtwDs0nDJQrnm0GP0Pe2Mx5/62Hwevnm
   dculzkytafCMQCiQqsZIr0Noqy7kFq/tRC/cm10+i0KDIH5iMMcXD1+5f
   MZgjZjgO56WGWxbbSszl4Ns6vkej92EIfNrNaafaUX+vQYOyTSbxgBJyA
   5ldCiB4E6kyLV86Q3srJmss5GstbIvToq/s2iJu2vyzqEmWYRaSKT29Ug
   uZ1J2o3jaSNtn1aSTyBcDyNhsV4e9YoKb0i3vStBapsc1ZLpyVnw3Jkhm
   Q==;
X-CSE-ConnectionGUID: v9u/N9HwQAuViDTXZ2V8vg==
X-CSE-MsgGUID: Q+v01eW1RmKxRwxySpMJ7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21280070"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="21280070"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 13:28:35 -0700
X-CSE-ConnectionGUID: c0fbuxKwSmmFfZZvdGdb8w==
X-CSE-MsgGUID: Rx3bawQERJKbAEPXzJO9Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="56907761"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 13:28:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 13:28:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 13:28:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 13:28:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 13:28:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYPPW2ho1iPtbZXZnoAfQGuei7a81uNGhKm+cniDLTfjb4FeZldt/lggRVeE9lhDA/LQ97kEzb7I8ujt5w0FYqIBSrFzLqAa/7dWeyw1Zuole2UmGYaKvAmOahGUJPS6vHbK1hiDTNvx7NtQFxtFVLUnmCPsweWW5w3JEpPJHOVKrIuvfprrUGX//g3/pVtlWyUsinm0Y33/S7naY94MmfQPzuxB6R70GwuJIL3+JEb3e+WpEcBRz6MUIKHDPA4t+N5ZFDusr5mfdTEo/o66STeLJmOGhx8gje+t6iyCtH/4tNfAee4e8tY3F5jES1Vl5Uy4cDgHws0nGMLk0ip2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRe15pECEbrv6rBaetnahzQoYpj38NYdmoN1YTV/2Ds=;
 b=YFbWOlHcF/MaQzjDF7ineELXZ2NTpmc0eqj2502jhej67DJGiCaZCGgngRCYNjQOFqXO9uT/WAtovpbCDmpukEv8AnmVFC0BttsVIa/msiWNsbMuX8scJrkIjmZEBXxSjMg2PZF2qcD8B8O1Xafujpu4r4UQi2ysWcSNDDZbn10jm+EU7gmAGgNlC3z6uQTWYxoaZ+IgVri/KUfXDkY4/LrA7D/YFJaV02dL40SkBIsoMa3azVmWSOMd3FHGbXA84TkSfM6InhCaMMJGpiYtMLd/kX2OhatPf7NKWCzMy0IfeUi3tWz/KJXIYTjYKMdtFAU10ZliZJo2u0QmBBu/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5900.namprd11.prod.outlook.com (2603:10b6:806:238::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 20:28:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Wed, 7 Aug 2024
 20:28:31 +0000
Date: Wed, 7 Aug 2024 13:28:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran
	<oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
Subject: Re: [PATCH 2/2] ACPI: extlog: Trace CPER PCI Express Error Section
Message-ID: <66b3d8ec30e74_2142c2945d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240527144356.246220-3-fabio.m.de.francesco@linux.intel.com>
 <20240806213118.GA78822@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240806213118.GA78822@bhelgaas>
X-ClientProxiedBy: MW2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:907::38)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 89936126-78a5-45d5-5d4b-08dcb71f8093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LOw6wwH7dZOyTt0Vbwnjd5aCqj1bPw3FTFEjLI8Vt1b7CH3PWWFTqmg95hTc?=
 =?us-ascii?Q?RshlVSFARdPPgcIgkE9HNsbRJU8TZ5k8AqHnweZyE3cKhvBU3JH7gxRGOkTU?=
 =?us-ascii?Q?HtvbK9PLQPwH8chvsQ/xyETW6tUnoXisHHMDOOrs2IKAuoCbiOO2aha/T1VG?=
 =?us-ascii?Q?mUb9w6DBy+S5t+FJQ6Iq6EzYctCG4V+Z6OnjHKtSh9+NYND1oj/yRlCk4NPi?=
 =?us-ascii?Q?y4CsVkgFkBHxwxVBnHGZ9JVS7T0HVSP2eNk7aqRzbYyruRI0dAIrUNKoqUYX?=
 =?us-ascii?Q?xTbtSPx6U77sVn2LRVw8NAHUveegsEogyiJeAPF79PNTrBVD3q/jTukAv14M?=
 =?us-ascii?Q?q33H2vX//FdpOS0+tq/Iq/CTA3c+Xfc6POsEbQpBz38oqJACUGm91xGrgQpx?=
 =?us-ascii?Q?kKUpo/MDkl0G1SV96oR/sq1rBlX9wzp7hNj0YUSo6zWTJ3xw23Rq3B9bcrmT?=
 =?us-ascii?Q?rak4Z99DFQGkufIUhGSR8VnWlt9bAD8KvlLCKN7D3+U361xjgj7C/g7a2Xb6?=
 =?us-ascii?Q?6Sc7P88ntLXwrM6XQUgug4wiZKrtlFi6X7no0GZAOaIjWPKULiPX3ioRaZBe?=
 =?us-ascii?Q?CGAFCO+Lfa8BIS8dyAWfkHnMjISBYqchGIaw9zbdCfplenDFSMyu0K4Ewuzf?=
 =?us-ascii?Q?So4JDTtrBo75UrR2PY5Bm/PsuFIltNHHUNDTsVI7OJxfCueYAgEKe/U6mwmr?=
 =?us-ascii?Q?ucfJCMjWPOyxeCwW8etz720AwDskzbw29Rt1hjwFc5t0qWSZJaLOD7hkF99J?=
 =?us-ascii?Q?SI6pA3Qcsi6iCM6gOOaPT6gPa7Gjzdgtnuq70koO0t6jYXG3prhDJSnKbm2g?=
 =?us-ascii?Q?cdSycPpJ7w8mIPFi44hc2Ik5qWg31goKmjJW0e6CXmUA2HTuSb41aEjhMNuj?=
 =?us-ascii?Q?19T6ZmwIMEyFW6eLVkSIhV4aYg3B4mvXecBgfzpvzx3wHMr/ninvdiz9HII1?=
 =?us-ascii?Q?zuTYGDWbWofgZLUK/nVG18blPtdrhu0Ta5CUwy1RzmkcZc1U2WNXOJVhFbry?=
 =?us-ascii?Q?jnSIK9KDlyAWwe1F8yN8D23bXPtx7QBueT69q3CR0mX/JYgu+uS0N8lqFDl1?=
 =?us-ascii?Q?UrdNHY66fTpuxfFG8xKUBk9xOuKsnz1XoZ//qmMu7wwpSNDtyi9dvb2uPiDN?=
 =?us-ascii?Q?QNgwGBLnUsM4lPagbGiQYvTH4yqWAVdf6stMNdcgk9wZXUk/zc/EK+fWrtsj?=
 =?us-ascii?Q?y+v0xm9Ea9d+EbiHl8/BKEdOxlIWtPvYfw3MSm37EUBJLMwSyKbx5J4J00xp?=
 =?us-ascii?Q?RRd8+ncgv0IeBtvuWPPjH+25NnSRD9vIEAZtTdxS6HDacwdJrfKp6q3lUEHs?=
 =?us-ascii?Q?99LsDHnJNV7kAnEHbyHz7abM8EQL6tpYqg06PlCJxfdNMA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fTD/n3ctw6Uv4VIiD9YGJX1MGBv+ZJMDTJNWRrPNF7fPnPYIpdAXwDPunLp/?=
 =?us-ascii?Q?wmlByFjD6n9DDAr61foOerNn/2cyzPvsKLA+C7KNX+TaF5xvQCxK7SvMpLTd?=
 =?us-ascii?Q?Q5WyyECBvpwZjp/CvNC8/zTNSp4K0PRNZIfQFr9vRMtXj4j0Noeo6BugcT9Q?=
 =?us-ascii?Q?sNpWuafo3fVf6du3rUL/FMxEkMbzAOWhnLuNEwEUXorWqaMX3KNOH5REiMwP?=
 =?us-ascii?Q?pEHps19iryO56kHf38tlxkJHSUtYnlFnKnuQo+6WMWInpW21FmS+0rbULwsL?=
 =?us-ascii?Q?tNwYG20kETVWI4z5iRquRkIu27QgDjI6lAco9tejNS0JQ4nQKAO0E6XVPctV?=
 =?us-ascii?Q?x924XHwl6bOwGSRgfXl+/t22+uxZDo1wbmx76DdqDTuSxsXgN7dBJLpmhVuZ?=
 =?us-ascii?Q?OJmn5MbPuEKrxfYELKy/JgdMTK1Wy0qQ4DMzMa2cNS3r2gQBom5pSdh++TC0?=
 =?us-ascii?Q?LvcljQWKR0RQXt++DhU1CwZyPQz2Ut1ZFjLwjNaWjU6eVvPQKbwxbwSTgr7I?=
 =?us-ascii?Q?d7TO4hLdcdszMYqTBbw3lzY2MWXRN1U7NuUE72G9wLbkKdHRFrJcogGSV5+M?=
 =?us-ascii?Q?X0xWVet49jbzWU7PKxwgnvuKWb47qFwtndbM9bjWOHrRl9tACzZUFEGCWtAU?=
 =?us-ascii?Q?KYBxpEDOX8EZMkD/KYUfVs82wBkaSNGKCQD/CV1LMYJd/1ClerMIFEJtLGnz?=
 =?us-ascii?Q?/w3sGyZeI3DVNVq5jjXtZEm4BRpExF1aAnWhxAOoHr28MAr0MckyJcy69zip?=
 =?us-ascii?Q?kfJiRePGaA4GemeMl0cr27yg7Bnehus598K0RjbGUdEJ2MSSSsOb5aTeDODG?=
 =?us-ascii?Q?/u7YnmRiXOOniaChMDpQH5MKFHOC1bAPEaoZCnCr9ATA46PWP7HUUVFH3haP?=
 =?us-ascii?Q?lWX8j07wCF9ADz5ARd7RyKghDn/y1O+N7MyGrgVxeRfoIzkB1bIjzZnJZZkS?=
 =?us-ascii?Q?lQmHGYTEYAGbr+wTYAcCWmEWrJb13Pj9LlApW3PFuXtUGHZxwJlH7FMOrCqF?=
 =?us-ascii?Q?mYwEGuDwVGNH/RlAvLCjQRIUCSJj/2xftfnHb+h9JBB4frd9tGRKzynzkMX4?=
 =?us-ascii?Q?R/dC5W9qZW2b3A2taLV7v9F6XC6wFWPsPztiaMnRWLgXYO1/Tnqho/uQ7sT6?=
 =?us-ascii?Q?KdmvFAdp2cxuVP2b1Nte9LyBMN8pTjW6ps67hkmT5LYdqByR/p16gPLhBw1n?=
 =?us-ascii?Q?YIizxI5kkxxbnQ1FfO9BXM+bbtSxsqcTa9LMlhNUxK7ygmQ0uZacf5sGAV7p?=
 =?us-ascii?Q?iOIaf2PUVg1lGp6Ke4mFHqJsCx0YuCd1c84DNZ99FUwWTb+fOvThLr1PMWKw?=
 =?us-ascii?Q?pXPsggc99PvzXI4W9xdsRp/2q21/6vFIlFvPv2F9rj1gGIKT62sgZ3dbFTAR?=
 =?us-ascii?Q?aTHIasOBNlZH0M9RUjt0coonPTVohOuFK3vazLejfjrXgX4Nxg356pu4SGQ3?=
 =?us-ascii?Q?BufGv20BywqcF4oZItLGLJafF7mDekxGIKlfaqolhB/o6Hmii9Ia9LhVoSJK?=
 =?us-ascii?Q?jDD6Lu62vzccsFwC2AXrdjPkywyIQ5C+xOI2S6WfB6GkhlSWX7HjwgOrbX1J?=
 =?us-ascii?Q?WKQjein0DllVp2zS0SkWNGYMPvg86rnakj7Mz4v2bVSyAHsX9nT9B46KOzz6?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89936126-78a5-45d5-5d4b-08dcb71f8093
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:28:30.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJ94lGEDzrJXvxVeRz8c3dcdUlS2+6VB1oXjrtmPVVTHL5MNQMhGvDq2mfVNabmdApGXXv28Epy8PR+dG+YGjC0mBVAhbCOwrm9m0MDY5Xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5900
X-OriginatorOrg: intel.com

[ add Boris ]

Bjorn Helgaas wrote:
> On Mon, May 27, 2024 at 04:43:41PM +0200, Fabio M. De Francesco wrote:
> > Currently, extlog_print() (ELOG) only reports CPER PCIe section (UEFI
> > v2.10, Appendix N.2.7) to the kernel log via print_extlog_rcd(). Instead,
> > the similar ghes_do_proc() (GHES) prints to kernel log and calls
> > pci_print_aer() to report via the ftrace infrastructure.
> > 
> > Add support to report the CPER PCIe Error section also via the ftrace
> > infrastructure by calling pci_print_aer() to make ELOG act consistently
> > with GHES.
> > 
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> > ---
> >  drivers/acpi/acpi_extlog.c | 30 ++++++++++++++++++++++++++++++
> >  drivers/pci/pcie/aer.c     |  2 +-
> >  include/linux/aer.h        | 13 +++++++++++--
> >  3 files changed, 42 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> > index e025ae390737..007ce96f8672 100644
> > --- a/drivers/acpi/acpi_extlog.c
> > +++ b/drivers/acpi/acpi_extlog.c
> > @@ -131,6 +131,32 @@ static int print_extlog_rcd(const char *pfx,
> >  	return 1;
> >  }
> >  
> > +static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
> > +			      int severity)
> > +{
> > +	struct aer_capability_regs *aer;
> > +	struct pci_dev *pdev;
> > +	unsigned int devfn;
> > +	unsigned int bus;
> > +	int aer_severity;
> > +	int domain;
> > +
> > +	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> > +	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
> > +		aer_severity = cper_severity_to_aer(severity);
> > +		aer = (struct aer_capability_regs *)pcie_err->aer_info;
> > +		domain = pcie_err->device_id.segment;
> > +		bus = pcie_err->device_id.bus;
> > +		devfn = PCI_DEVFN(pcie_err->device_id.device,
> > +				  pcie_err->device_id.function);
> > +		pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
> > +		if (!pdev)
> > +			return;
> > +		pci_print_aer(pdev, aer_severity, aer);
> > +		pci_dev_put(pdev);
> > +	}
> 
> I'm 100% in favor of making error reporting work and look the same
> across GHES and ELOG.  But I do have to gripe a bit...
> 
> It's already unfortunate that GHES and the native AER handling are
> separate paths that lead to the same place (__aer_print_error()).
> 
> I'm sorry that we need to add a third path that again does
> fundamentally the same thing.  The fact that they're separate means
> all the design, reviewing, testing, and maintenance effort is diluted,
> and error handling always gets too little love in the first place.
> I think this is a recipe for confusion.
> 
>   ghes_do_proc                                        # GHES
>     apei_estatus_for_each_section
>       ...
>       if (guid_equal(sec_type, &CPER_SEC_PCIE))
>         ghes_handle_aer
>           cper_severity_to_aer
>           aer_recover_queue
>             kfifo_in_spinlocked(&aer_recover_ring)    # add to queue
>           aer_recover_work_func                       # another thread
>             kfifo_get(&aer_recover_ring)              # remove from queue
>             pci_print_aer
>               __aer_print_error         <---
> 
>   aer_irq                                             # native AER
>     kfifo_put(&aer_fifo)                              # add to queue
>   aer_isr                                             # another thread
>     kfifo_get(&aer_fifo)                              # remove from queue
>     ...
>     aer_isr_one_error
>       aer_process_err_devices
>         aer_print_error
>           __aer_print_error             <---
> 
>   extlog_print                                        # extlog (x86 only)
>     apei_estatus_for_each_section
>       ...
>       if (guid_equal(sec_type, &CPER_SEC_PCIE))
>         extlog_print_pcie
>           cper_severity_to_aer
>           pci_get_domain_bus_and_slot
>           pci_print_aer
>             __aer_print_error           <---
> 
> And we also have CXL paths that lead to __aer_print_error(), although
> it seems like they at least start in the native AER (and maybe GHES?)
> path and branch out somewhere.  My head is spinning.
> 
> Do I *object* to this patch?  No, not really; it's a trivial change in
> drivers/pci/, and Rafael can add my
> 
>   Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> as needed.  But I am afraid we're making ourselves a maintenance
> headache.

To be honest, I am too. Upon discovering that extlog_print() behaves
differently than ghes_do_proc(), I had the snarky thought "great, can we
now just go ahead and deprecate the extlog path, it's just a source of
maintenance pain.".

So *if*we keep acpi_extlog it then I definitely think it should be
consistent with other CPER handlers (needs this patch). But, I am also
open to entertaining "deprecate it".

To me, the fact that ras_userspace_consumers() is only honored for
acpi_extlog is clear evidence that the kernel has already painted itself
into a confusing user ABI corner and maybe the proper path forward at
this point is to cut acpi_extlog loose.

