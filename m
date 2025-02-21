Return-Path: <linux-pci+bounces-22045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFC1A402BA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 23:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1AD177613
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 22:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B0B254B11;
	Fri, 21 Feb 2025 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gT4mE/Q+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C321B204685
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177212; cv=fail; b=RM+iz1pD/2B4LIom4CfrE5pshFtHTcQFr53OVROdJbbz3HPIxluvSpuOyNkgaByHhzfekVpd+feX284C9Y8h05Y1BNAoUz2LZCjpxMBkhBZo6OvVHPUkA2WEQCsnYdou+C3mqU7pSjLrHDmQ3R4cCZRZ5ER6IyiGWA2vB3u6Cmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177212; c=relaxed/simple;
	bh=BRCH8FQnY3+yzhPPtlgSTtduXESm2IkInzJXOD8EE9o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X4EBajZtkN0UJ8yRHX1lBCiUHOWa8xT/Uk4WLaAXZ7nJsFmBwGqBNDsKNdso/vuKw+PXK5B8PvKtEKHqdJXEVCpMoRENVa/YY/AB7hLAJhk8t/WbCeUSljITeuu4rcCQimKd/W72UBxiR2pLdE3BgB978iyhVfNzZrc9HV8x8Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gT4mE/Q+; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740177210; x=1771713210;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BRCH8FQnY3+yzhPPtlgSTtduXESm2IkInzJXOD8EE9o=;
  b=gT4mE/Q+En9b6DdNXhGfXPCCTgb9GTJ4P6nvEheHQlnJOsVE8emffTxj
   dtEbiQekaCCCRFivvyt3E08qoJ0Olt3U2L+8gZIeLwF9OnnXHLyCOCv75
   c6NVXnbG9Bm6gq3vbJ6uwgbhvmFxqx4hNIiBBpf84XvQDrIPwAOgB4TyU
   BRRr4DwBGLQb6OqPPst2G0inj8OaY3HYmblwmYUSW2m2c9DvarEKdNykM
   nLdsK7gFD8dokEQLL1aLfhrE7cl6kw+yIjVQ03Oo+orhYoM2QaZSODWLz
   8/TLSD0ZCVE6k6t4MWmmyto4qw4AsGSn7605ryuUFAUSSIFK6HZmPk9xT
   Q==;
X-CSE-ConnectionGUID: k7u5uWjzSHuTZTvLmp3f+A==
X-CSE-MsgGUID: gjWqIwYWS4in7Y0j5QJJyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44921057"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="44921057"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 14:33:30 -0800
X-CSE-ConnectionGUID: wVfc7HO0QwqzKEmqeJzZXQ==
X-CSE-MsgGUID: wS0WGGmSSxaaXfVv23t80g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="116018456"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2025 14:33:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 14:33:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 14:33:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 14:33:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPgVehPTcKNgT01Sp6BRWWd2TfwpX0t8IZkYBE+//vhMC47VafSGneEb2RGMwI21twv7Bxw+/EXgtePV77ajc+N06MPVi1Io/K7ml8Itp1T4p2WZNYbGrrib9Zt+KCMz+RikdYNhQpu2vqD2UVwUtsbIvcOS2suWTaqnR1qA/KUgfXlpRTV9UXi/XGrtXkPzo5LK8MgDL+H18abkWMGLEXAMAacjrcZJeWqpWNqpNHZyOxAMmm0A/JqHQQXizY7TCHlAmODtdI/loro482xj0zCg1O9JsCvW2N9KQoFsIMAOyQ1CZGUKOQ24BCDfb3vwP82oziIuY4jhmi0shSHv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoiaG16rVkqGVfdScaLCw+yBxqsGhdJIXQRWS0ubZYA=;
 b=edx7u99mhwC1EdjXro3S63BmUrrO6KcvpYcUwRfxvyymuVHG2WAPP0ajR8j41mIpqPpWW+fujohtMiFdh1GeGbHHDOT4y/tzIE7dpFUYS5N/6QJmH392K4/LdGHTnrxg49qhi36Yp3KZjeJmft99FC1qd2Ih3MH/SvrZJSdgky8sL7Duzc32Wyu4Yxx0jIkOT3VvlVnn8zHwsT9E2aKd5MHi29rwBg0fS5niw1kFJqRjfWWmfUX4o55dOM1Nrw4SLkOTI4UUsfI9ROLwKUheiklzzLalQTiQWNhive4f0j8fbpp3RS3Dz0MASWYi9mRLAQZfmPWeUjrnptSLYFnoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7798.namprd11.prod.outlook.com (2603:10b6:930:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 22:32:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 22:32:45 +0000
Date: Fri, 21 Feb 2025 14:32:42 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <67b8ff0a59f82_2d2c294a@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <20241210185255.GA3251438@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241210185255.GA3251438@bhelgaas>
X-ClientProxiedBy: MW4PR04CA0311.namprd04.prod.outlook.com
 (2603:10b6:303:82::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ce39ce-9ad9-4acb-1b9e-08dd52c7a93e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sPCAv8gJS0zzLCg/9W1TbvUr6XUWthn97HCX/RxQ2c/T6eLLjEYOxeUfDprz?=
 =?us-ascii?Q?SGxjQHaHY4pCCyB7nOJu34V6uNjO1TF67nUZUmsNKkBuNP3PWGilQmKTKOOZ?=
 =?us-ascii?Q?3aNlZIBlYNhLDubLbkZ5ZlvFtrFBPpvU1ELo5Yaiz1i9YDIqYiWuwyc481Yj?=
 =?us-ascii?Q?0aiEJlMUzW7668uFSVafdOufw1beMMioeinfEIDMvKKza4S064wMod6CyxKH?=
 =?us-ascii?Q?23zZr1KH5gDVHJJdrkOcvBI3r4KPTf0ZsA6Whjyxz/7oN3utg+ca6oifXNq/?=
 =?us-ascii?Q?rVn0FEFfgKpG7/Wt+p4VD1OQAomJCjMkzhgcKRd/dNPAdW8uDpJoG8qz/XPn?=
 =?us-ascii?Q?do/wrf1OhUlRzQWtW2jieWCCKM0AtNVcJlw4vXPsOuP1lODOqDyQ+MG4vT0e?=
 =?us-ascii?Q?omOpXX+zQkIvIaXM6pSLwuh3fpPzR2D/bqwgG5nFJI1dBt2SLcmiO0lg/7+0?=
 =?us-ascii?Q?NZdeL+vJ+XtzjZU/AIsKfTuRhSLm5P0V5OlWYELwm0fBtva6g00k4IAB17DE?=
 =?us-ascii?Q?f1qstbw2WfEqH+UUHCN5+rAdW+DRzIINgL2FywtwCEiIZyrWAnxfAa6SrEcA?=
 =?us-ascii?Q?Sq7XZQL5lu013mcFQYUWgsNYKLMRr6MWtiAbUhcRd/ikr0SjJCemFtX7Qj9I?=
 =?us-ascii?Q?d0wXGmBRVudEaRlmkc7imR29A1Xrm9VCU6a+poYvWSUAvaswU3PhLDZmf9O3?=
 =?us-ascii?Q?j89qZRyd6AcfErD7nVqd31kwiywuv2qILFcDQG9Rzlk9HTVzFjAatcvfCm46?=
 =?us-ascii?Q?nnuFpUyGVykt1WkUaBmlRM1h+siN7SH6q2Zd2fHUoo8DrlDSSs95pjBf8M/B?=
 =?us-ascii?Q?4BWk/m8qHJ1E5V1KbYFdvTBwnTmJibLnKAx4L6bpra02wIDzkegzUg4gyzg8?=
 =?us-ascii?Q?ik7pn1/tFulqaDj89O2nDs1HFz3ZwEytrdlkV4F1Hs1QyWxTdklqD9Or76aC?=
 =?us-ascii?Q?/tJ4XBAO5KqtOpnoZFrqQneQOl40mteoo32pIgy2yfGlfpml3+/A3YmFLtdu?=
 =?us-ascii?Q?+ygXLHIRzaDLnPQ5YDFSPwSin6NRc0FhagSCAx7bnqKLLh89HpoL7EZD+0Nq?=
 =?us-ascii?Q?tZvQ2dq0uZnYrTteuxlt9UB77j8U3MUY45uDb0QGzQzUFV2p0NWeKgGHE3Ww?=
 =?us-ascii?Q?Oo3ozTvCTKE6ieL1vJ0hZeYB2gCrHmAomvGujyoZMILgB6r0jGfJDixGknlt?=
 =?us-ascii?Q?VYib60ZiNYgPOk9WlrmgS1/TnyX2SSB+2OdBCbg7W5xa+HCwXX7ZUPVxglj6?=
 =?us-ascii?Q?2QeR3LsE1hjj6TMyKaM0yYr8S43vy2YL+6hI+ISTOKUZ7fVZSqtEXrG9CTQR?=
 =?us-ascii?Q?IT9oacr27aAz583z2l2rXJ+lHbaXQK9/PXZjpLNXnGm8/un8dydtT0xpAk6i?=
 =?us-ascii?Q?8dQqVmsRs3kpw1ltWsyZSWesXOLu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ScGZ5TNp6kNcFcL2eFAzQ3nVUcJOGLTPqmKmUaNklYU4rznuEvMdeGciPIKt?=
 =?us-ascii?Q?+57+nCOaGtrCHhyIrUmYepuIgvd/1Huhlm3lz22DnO4+Bdi+TDGbYQaOTZt9?=
 =?us-ascii?Q?335PDxNc1cm+O1Yc+E4UxbPq4q902aJIqOBEVj91MXq/O8fHOjWSL+nTs+Gd?=
 =?us-ascii?Q?kdprgR0kQAd77zdtFGyAmSK3VsfUD+CyINjRUyIUZ/5jbMtlYTEQIgpNFAwK?=
 =?us-ascii?Q?21lGgw6X3BllavyJWS2cga3j/BzST+mU8oTU5su2biK00UzILfjFZIAZFiy/?=
 =?us-ascii?Q?SixFS7yRy/3ESG9Qor11B6isGbVlcjG+/8ot/ziuGVNPg4Hys6hKTGdT5Kx0?=
 =?us-ascii?Q?X6KZQ6GlviPTiK/TPFLYe6Rtv11+C3tDyAAujfEgS6vWx1tIwK6Nj2CI3Tze?=
 =?us-ascii?Q?UkDEzLcun4ws2TqoRIBvKp8oOOGSLVfrsmp01xfrJ+KDAIGZXCSgxahWCARH?=
 =?us-ascii?Q?wTH0qQZ1fOH2VZMFRMA3jxJ8BOqeu6nzaT/4j/vgCKIXkE2UVLUzbBddpY7X?=
 =?us-ascii?Q?iksCEKvtFOG4wkmflkuaUDbE0m15uFfIXS1QZ5i7W5zJnsf8051CGmW9JihM?=
 =?us-ascii?Q?JJLHW2TeCLaU22jTFvUhK6t7RNUQST0kAbP0ROAvbDK4Sj8crQjcW/7RgIH+?=
 =?us-ascii?Q?2YDLD7ZYvStTeXD39ZSDTLn72vsHkySUlLvtpV0Ni/J3Fwo06b4kHxNsv+gw?=
 =?us-ascii?Q?Vdt2H2gaEwVURIfS32qdAcK8L2Lz36v+m1DdJ7fimFQt4yfWb6CO11hpUK8n?=
 =?us-ascii?Q?uMO+XXSFCscWZpxPbhPk+BzAXY7nJwA9jtA9nMwXo3/VhpX+LXQQ0kgeB7A3?=
 =?us-ascii?Q?Ts8MB2zxebiHoWzfxViNX2faiUBCAI/3zL7zKaM2pminJMQ1daoQEdGnZKvf?=
 =?us-ascii?Q?ZG4EAAjvROtvsInuw9hKjpl34zuog07/OmtCxndjTDMOo3GwIZrcQlwajebP?=
 =?us-ascii?Q?YR+BgfYAo+d/sS/ha6pZb/ElU9/CYGynuzwhB9GgSBWve1ErfQ9TizmPvABG?=
 =?us-ascii?Q?lw3TldsOLTNiL68hjISb0IXbt4ihXnvOdoA475gEOisCUX9P4CYspien8Fvj?=
 =?us-ascii?Q?AkrlJ6I/X87hM/Ypid6cIRNdyHaexaYrPuiEZdxrEaZwWweloeYhxeWbSZBg?=
 =?us-ascii?Q?Y5jPSb6SZ2o/Ww/K7/l3EbKF+FP0LnfuD1Y17W9MKQzl2k58oltnSjlFGC4n?=
 =?us-ascii?Q?8Rtvlnfe30txZzktp/5clGkeU1Q2TDOAQJ4bHkQBLOJJx3QSpYyDMm3depS7?=
 =?us-ascii?Q?xfMbcFHNBTKbMakzpcF3f9xYbQQLjSTiUEy8VgC+Xu5Q3QIczxWjHsiEVkGo?=
 =?us-ascii?Q?ysmxQvA6a0NZsVGmm6fwcWHUfSXs51A4Nbp0NSad4Uab9JY2vdb+HR34ooB/?=
 =?us-ascii?Q?NwF6BaSa9rlyNPKdP3Xi+OUw9nBC6XKSMtSbH07OSMYwO5QO4oTGXyzSyTTH?=
 =?us-ascii?Q?ffsqBExhkRu94WfA1yLirvPl60x7u6fny4sU7sz7On3eE+HYf3/g0igb3n26?=
 =?us-ascii?Q?14cXZ5uxdQcm+kP0K20grK+Kd/9qQZElFGd93iugkOxEahu9m8cc0viDB/2i?=
 =?us-ascii?Q?p/aHdSoNQxdvr9nUjRsecic/pmZhwEEV02PCgBtEzBWHzcQMpBQ5okRwD+ph?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ce39ce-9ad9-4acb-1b9e-08dd52c7a93e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 22:32:44.9572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l06cblewVFqtRUfnkm7mBwmIxBcVf9O6ZqI3PH3q4cS6VZzaSATKB1cpTy1nsxPGykVxcXMkhsgSBg9QzMq2TcFXYytGoc8ZDyvU5hY/ip8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7798
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Thu, Dec 05, 2024 at 02:23:45PM -0800, Dan Williams wrote:
> > The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> > Environment (TEE) Device Interface Security Protocol (TDISP).  This
> > interface definition builds upon Component Measurement and
> > Authentication (CMA), and link Integrity and Data Encryption (IDE). It
> > adds support for assigning devices (PCI physical or virtual function) to
> > a confidential VM such that the assigned device is enabled to access
> > guest private memory protected by technologies like Intel TDX, AMD
> > SEV-SNP, RISCV COVE, or ARM CCA.
> 
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -583,3 +583,45 @@ Description:
> >  		enclosure-specific indications "specific0" to "specific7",
> >  		hence the corresponding led class devices are unavailable if
> >  		the DSM interface is used.
> > +
> > +What:		/sys/bus/pci/devices/.../tsm/
> > +Date:		July 2024
> > +Contact:	linux-coco@lists.linux.dev
> > +Description:
> > +		This directory only appears if a physical device function supports
> > +		authentication (PCIe CMA-SPDM), interface security (PCIe TDISP), and is
> > +		accepted for secure operation by the platform TSM driver. This attribute
> > +		directory appears dynamically after the platform TSM driver loads. So,
> > +		only after the /sys/class/tsm/tsm0 device arrives can tools assume that
> > +		devices without a tsm/ attribute directory will never have one, before
> > +		that, the security capabilities of the device relative to the platform
> > +		TSM are unknown. See Documentation/ABI/testing/sysfs-class-tsm.
> 
> Wrap to fit in 80 columns like the rest of the file.

Good catch, done.

