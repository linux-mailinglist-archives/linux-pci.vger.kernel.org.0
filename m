Return-Path: <linux-pci+bounces-6963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2958B8DCA
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 18:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD391F22F6D
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7B51304BD;
	Wed,  1 May 2024 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1vHk2DD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C112FF97;
	Wed,  1 May 2024 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579769; cv=fail; b=tcNRRmzKg7MtFsnhi41kU3Ob0okmJbQIJPqV/a3wUWI4dForXNjuRptokU/YtrYYtMjRY+i0uVslTT9wgBauEOmbOxO146bYptS5pPJvVmAGq45WYpCJKPPvNc2rrOuvMP9snC53evGiaMm8d6NyBRKVQOiNtyZkBxL/iddB4UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579769; c=relaxed/simple;
	bh=9eaJtf00LJhY8xM188vuiVE8PfT0N3vzVmQqt9Kyetw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mhLDtMd9o8qFmoLf4JpY8Uh1ztpMz/itN3/jk1rGIFAhaUL8jOFOP9qdK5nfwAhLiyxbeJU/3Y5Eb/Kj4JhV+VKao3Vh8O9CNN2LPT+TnlNNc0bbUx3PCwUrbAs6oQI28vrtxZkqab72JOtWA9JD47x74RasgxS0z/cgZ1lfbaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1vHk2DD; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714579769; x=1746115769;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9eaJtf00LJhY8xM188vuiVE8PfT0N3vzVmQqt9Kyetw=;
  b=a1vHk2DDSaK5rT71OxcicgCmWgoIw3PFNIWFZKBh++LdJ7ZgDxqZqcM9
   0GIc6ErB5SdqZ+Pbmd/ONdNzonuvQpSa+0+e6aySv5oUjsLtXJgXjeNYQ
   ds38001Hl1qVUOQNsWz50AHXJdG9AjBpZZW/uf9n56z5lJO4V6Th6W8r4
   Njby3OMn+TDpdJu9PCEo2OIjtk8ZO57/vwesOh7ImlKBbTEMLxddaqLeo
   nUlba+h/7fXHt6Lnuo3Y764lWswjdeb4eQtIbYinquvZQwjy+zNKE24Zp
   GE4DYLDFDvEPuS1ZACC9PoXIrl6I+hBCntht8wGIZ1C39haWpIcrv77yY
   A==;
X-CSE-ConnectionGUID: cwF6+0YXSZqhSwr78hPapg==
X-CSE-MsgGUID: i23mdNexSbKO7NCsMSTTaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10487641"
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="10487641"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 09:09:27 -0700
X-CSE-ConnectionGUID: PJXq3SvPTiii92SKasageQ==
X-CSE-MsgGUID: 86z26ft4TOaJxFQ7ZYFsyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="26839805"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 May 2024 09:09:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 09:09:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 09:09:24 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 1 May 2024 09:09:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxLQA3MnEMMMs/LgSGY9HmSi5QPT18q2t+uUlkzo27SmyZJ0gAIVb9UJykk0OSek4r3WmFAPHK2ESEK2EJoTfK1fTR/ht7HO4zwk8blqZkBTbfrWUP5Z7XPI8cEb4NxZKr2hrG+mh4bBCG3P3e6n9Hefqh4ZjJPWx/t7cde2+cZX7VJi2I8FlQGEk89FZi8S6bbqafZBh2OsF3Qx8wZgn/+0pwaGO0Ng78B6t6q7FQ9FcMcIuX0vsEBF+EwZS8I1kTkt3y0z9YnGsts4bakZu/eXaIFi4TuUrH8JO5SMX8QX7zPt+ChoLeGLzZSBP1yRdAeOodgdZBiwUgKQg4S/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1vKuamlnsvgM2vbBGPzmsXj8cAe1ar4oih+gEEWtP0=;
 b=bzRy+LnrAbqMa02plnb0pgGQ9CNicD34Ls85MMd7mVdVmv/gVa/o2X6qJnuPKFfO0wO3OWj6y6wsxWWvZHnw+knkHd/E38mwzA1ZfsIpLy+xht1310tqXf85r+Szt0OOe/JDFf3fF3v0008/tRXLc9fD1MV+X4akVSNsfA2aAxQWKBv9ec6xrKvZxC+s+TyOMtlwY+EI+mqM6qSByst+DWNOPAmIjXLcY9mlhCQIB5Z47nwJo59/qWe4GJpskEcITMVgLkki9hynEm/Y5cB1N6hGl/7p5d4iBRZc+CXhy5UfgSjnmwims+TJPwu+2Thrw5V3ztZHtDLkJuIQjBJ2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5068.namprd11.prod.outlook.com (2603:10b6:806:116::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24; Wed, 1 May
 2024 16:09:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 16:09:22 +0000
Date: Wed, 1 May 2024 09:09:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, PJ Waskiewicz <ppwaskie@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5 1/4] PCI/cxl: Move PCI CXL vendor Id to a common
 location from CXL subsystem
Message-ID: <6632692fc5862_10c21294e9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240429223610.1341811-1-dave.jiang@intel.com>
 <20240429223610.1341811-2-dave.jiang@intel.com>
 <91fe797284f433a76bdc1f804a6d86e0077a905f.camel@kernel.org>
 <0c7663b0-b812-4f41-a29d-f56b7cda81e6@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0c7663b0-b812-4f41-a29d-f56b7cda81e6@intel.com>
X-ClientProxiedBy: MW4PR04CA0144.namprd04.prod.outlook.com
 (2603:10b6:303:84::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5068:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f41ed65-fbbd-4dcc-20b5-08dc69f9107c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YmDJKgPjg2HF8yiIo+ioGiTqf0n3QGu+RoMzywUGlbXnSJABPymdylPh82NN?=
 =?us-ascii?Q?ZXfUJqup5iOt/wLx0rP5a2aPyL14jfqD6MRY+GbZxVd/eHK+EfyKE/Fv/YwV?=
 =?us-ascii?Q?ooec8pLkQOwxKligqgUOCQsgtkwN9uSAJC/UJelvqrBofNziGDRfQbz/Nno7?=
 =?us-ascii?Q?YEGAE+hVaakXXHYpF1qtQl0X5EtWMoNer3DX7cbvtP4wq+tUaldv3cLxecIx?=
 =?us-ascii?Q?4Aa8qP4Wtg//0Iuvf+A7O4X2sZUBkDCxUaATKmGPyT1xTyqUcqbRYH27kANQ?=
 =?us-ascii?Q?n0UgkEwygKsbQhuXsA0ISsvFcxTFHYQ3X8ya4HLlB+OTQHg3JXAbFVHOtkYg?=
 =?us-ascii?Q?6d7gRRAzty+zVfK9WS12EcTBTJni8QvK0IdlRkeCIOmmDKLBGffNyI8YWsPA?=
 =?us-ascii?Q?Q1OYs4U6v2F7b7RQ7GvokqEBCm3FB959bjcuoLuE2Sut9OkBZcEV1H1JCnJa?=
 =?us-ascii?Q?k+wzWt3Aj0ScEMb7JETO9HpLY3GdQwjRRtdJJ5CuP5/hLdnUF1Sstg7vdZL9?=
 =?us-ascii?Q?ip6gOVBUijnxdwG/a1d+LorJvLQ3TInaXCxqyHglW+yoBd916+Sb/nysTqLE?=
 =?us-ascii?Q?1gzwEEn7IuopAM0bo2LjU8UU8MOazGMSlUAGc8Sn/hrO4LsNj6VagOJBbpjI?=
 =?us-ascii?Q?+4FNZ/ODT0io6NYhamJIIu1b8os34SkRRak5VsV7JcQoqEhJyKLkrSvGi1pD?=
 =?us-ascii?Q?TESWjquyjcYEZdCkg2VHWXpQt/qWGkDGcFfPGu2vDBpitTwwvABWVobXnKTx?=
 =?us-ascii?Q?zJJNM2pdebL9HoBhRJ61mLMH5HTY9lBqQ8c4JpFvqGReuxubEL5QeHWBRGKS?=
 =?us-ascii?Q?gcfwkf5dG83hWBVuk2pOssaX6/Zzx/TYEreZ46mZTMBSQU9tpHgiSjQ34RqD?=
 =?us-ascii?Q?FxtLUZg4+GYuxwQgwmamQboP7qVtGop9c4VR0M7ngydakXFRay9vuaIxN70+?=
 =?us-ascii?Q?vgFAbLlXDSYroded0sXR5Y2luJETDoYxBYtHxPxSDU1qRFsJP6tnnpiBlDnX?=
 =?us-ascii?Q?hk7b6pSxp7QOOvK8lzrcGcIywDNnlpc/11E9bD1DmdhpuejWT9mn3ZELnNY+?=
 =?us-ascii?Q?+mTn0it4jB94A/CKhRvg+mymkNiQflzm0xwVs2xf0F0RsJJPSSTNzYRak6sD?=
 =?us-ascii?Q?MhwZnX4s3hpuvB/K80COxx59H7o3lPV/tEC+7uvjLpKB0h0JO1RzKDuIOqfO?=
 =?us-ascii?Q?ASM6EZdLGUe2tULo6d6KBW59VrmOCtFW89TJkB+7UsYNO1xrtVmjfAyZXHqb?=
 =?us-ascii?Q?EL7P5Cxf0i0ysbG6tPwmJZWcAqkOu//haMu64Sk7tA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ZJ4kB4v9toCFpu+jUrxf/1wsn2exQHIilFjrBcFSES7g3at/4x5MbOmpV7p?=
 =?us-ascii?Q?L4I8PoTupWTFA8Q0xL46iIq4ylhbfbrNzMNbxN+dgJYSHr17ZtvYIFbwEUXt?=
 =?us-ascii?Q?zxGFqDx7SHu5lromOoM2IuVwzUq8QDNTyQEqvpbE/gek9Mf22xqzLptjbh7K?=
 =?us-ascii?Q?f4CmFdQKXSwqiQ3KUGGglu9oFJYS3HnQPTEM6o5lNqOhzxNY2f/BiElFeJ/b?=
 =?us-ascii?Q?lpGDGyALPWY1BptY53KqDQvQrmXoqVKUjX4ROUoC6JAp85x4jdL/+dz+dL4m?=
 =?us-ascii?Q?l4KnBFl7UapCNgb3KR+HmskaWjlvA2HtcNFmp2ogrQdZuBhTIu5GnaYG660N?=
 =?us-ascii?Q?7XndFhd2ua+DUzac+d5Jl+ChKbB1EGLrZe37gJH1tn5VAIMnG5klUiaHCyQz?=
 =?us-ascii?Q?7iTt5ugVFyLLN+ZuOtP/kSQ+dTMjHCrSK2WUEnNynMqS5bTCq13UtyBSLx6y?=
 =?us-ascii?Q?4s0O0Ek2TwngVAfotKL2QpFiE0UKfio39Oow0tpxo/aAowAxx5zFmLqZb39G?=
 =?us-ascii?Q?j2wmMoXdtQ0wQiaLAAZ6BkYZ49hAD9kOjkHa8pfDhBMijbLxqgWId1A90EP0?=
 =?us-ascii?Q?bGz1D7JRShxudUZbgAwVVWEg0sx2NeeasiB60Z3GxJcizHSKGkoBm2Mtcyt5?=
 =?us-ascii?Q?i2R64uif6Mb65QHYLD5/CP6kXjQDjzdW9oaWAkJ59zuzoM3gviZLWyc3S5PN?=
 =?us-ascii?Q?t/jGmcQMf17dxVI/Q8Br0gYmGmELWACO8hz+sHdLowJMhSUjowygVQuEEDqW?=
 =?us-ascii?Q?fX3KWltl7f9u8jpdCnlejWX7isfd13aAA3AmqQX+8Bm95ByNqZL/lpHFXuzX?=
 =?us-ascii?Q?hW1BVMbd9OabpnqxcLiJ91JpOB//JaSjJ9xhZb6J0XoGBKy7mUbMZWko67Tx?=
 =?us-ascii?Q?8J6LIqw74deaFHa4667ey/sR2t2h/ZcUC4FP87nJIOgWosWs0pIQl3+nliUv?=
 =?us-ascii?Q?Je1nkx0USwdCp0fozkuja5QdiXF/SLHgZqqAskChc3NtdD8x2m9t7Bprh7rB?=
 =?us-ascii?Q?vmQOLFd6mVUjwfu1UsvsnPW5didMmc3pxx18zqezv902lFLQvDc/dKtrJ6n+?=
 =?us-ascii?Q?Z2v91dbtRs/Ta9U75I9N2PekGZM6MzKxAAQJ21aEE4qMjgR6Rcix+SgXxFQf?=
 =?us-ascii?Q?Ed7NqqtvG07BJf7yNWZJiHmZaWoRDZFvj+4eH8SycMpQiB0/T0CuXSyR9WVI?=
 =?us-ascii?Q?ISd37uP87le6W5Lti7o0BWIIZTSJDJ+dfJpvEzXSFbiVnlpdpNIDUb6Xm0dc?=
 =?us-ascii?Q?8N34NRzmU3d8zHluugmu419Q5fXwIzBqB1wOdY0jxujdYHmp5Po8iE1CedTe?=
 =?us-ascii?Q?qAxU1hutwTqV7wx0V5ZeB+DszP+oGPUyPnU3y8mAR0gPAHFjvXOEjjW1OV7U?=
 =?us-ascii?Q?5XGyfDb7NiCvlbz2MsZ2I4GSzu6HAY+HvpVwvtxTMmlZ9/pVUsLpcIbouLhJ?=
 =?us-ascii?Q?hJY0RgJ9y/Av4DElzIotepuBiANXghdV2rJhJpjZwrTMMDX6VRyXgWdsL25v?=
 =?us-ascii?Q?Ub0YP0i3K7rLkNNZSWrnjxG/7CKTQxMJV09/tAWp91VLSdFVy/FvWHymY9V1?=
 =?us-ascii?Q?rLp2GYYl7ACP/ud+lHcGd8kaL3UEbIgUTJDTkg9I6YRi8LSGRDQ0G67gm8y2?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f41ed65-fbbd-4dcc-20b5-08dc69f9107c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:09:22.5344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e00lLq0MPQrRAAFrnOguYeweg40KP7IYyyAYua9rXlTna44FSTvfDuKT/ljtcmaiZPfJW8080YdG42Ewmk6EGC+K4NIHvLxIflLS4eeKe9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5068
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 5/1/24 8:37 AM, PJ Waskiewicz wrote:
> > On Mon, 2024-04-29 at 15:35 -0700, Dave Jiang wrote:
> >> Move PCI_DVSEC_VENDOR_ID_CXL in CXL private code to PCI_VENDOR_ID_CXL
> >> in
> >> pci_ids.h in order to be utilized in PCI subsystem.
> >>
> >> When uplevelling PCI_DVSEC_VENDOR_ID_CXL to a common locatoin Bjorn
> >> suggested making it a proper PCI_VENDOR_ID_* define in
> >> include/linux/pci_ids.h. While it is not in the PCI IDs database it
> >> is a
> >> reserved value and Linux treats it as a 'vendor id' for all intents
> >> and
> >> purposes [1].
> > 
> > Would you consider a patch, after this series merges, to upstream
> > pciutils to sync up lspci's name of this value as well?  It would be
> > less confusing to anyone looking at both codebases and trying to line
> > up #define's.
> > 
> 
> Yes I can look into doing that. 

Wait, isn't this Martin's call? If pcituils follows the kernel, great,
if it does not, that's pciutil's prerogative.

