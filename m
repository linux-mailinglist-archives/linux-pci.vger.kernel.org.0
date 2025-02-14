Return-Path: <linux-pci+bounces-21419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3027CA354F5
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D99018907A9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997B713B7AE;
	Fri, 14 Feb 2025 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNFgDwAW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40A58635A;
	Fri, 14 Feb 2025 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739501038; cv=fail; b=BuM+GK9hcTY3qvsiGmT1Gx2CVMckVv6JzS7d6+L+TtdzTVNY13ZcYm7fYiAbCXKCd4j8Rc26VvNbUgO4RpvpgguhYLEo0GamcGxNse/GeQWyR7FFtElfchnJEdUbo09iVpDD7PPOgCJasaMKTbxOZn/ci1zLki2goep3VmtPPdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739501038; c=relaxed/simple;
	bh=jjC3odVsiui0cMcfbiLn/qf+AV8MAPye8FrJY/3bjW0=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bsxkzb7gIUAoTOD/ttPlbZ/GY63izngLb5R+RTJnVfv3lPaFfmP2R8DPHWK7TGeMbG577x3jMI6sC+jP29udJjGelJJml7vx9kBgRLHnxa83qgbADfiJGLslsDzX/lFRlTErTBYwgZlqY2pEmW/1vzenEFNbMS3coR+iEhB8xQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNFgDwAW; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739501037; x=1771037037;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=jjC3odVsiui0cMcfbiLn/qf+AV8MAPye8FrJY/3bjW0=;
  b=jNFgDwAWUfd/iaPTNuJiW0QCYCcdqa6h9q1lmACa75+85376bRbwqmLY
   5OmV+zXD8R9hML/cVLYhlj1Mp0XiF6c3pvLtIjDAoZzylYbPFxHeDoVRP
   2Vt/BLAr29XHb16T62nrD1MLqCJDQK138drmxPPyK3vypWso29iPRaA67
   Cj57ZE055B7i4HjrPIJSikO7G242PctWbKcDm+PWbGvbW3uL+9ik13/Fz
   E/MKdiELDEoYOiEDGISDteoy5UcXkgqQEdflx7ydFMUkTfmRfjAqm1Kwl
   lQYbzhjkyz1ABkgD+UPrdPhICvWaAlh+9vhN3qfyl6lGomd0bpZk5/9il
   g==;
X-CSE-ConnectionGUID: oE/J57xeQ+Sr4J/jRYa0uQ==
X-CSE-MsgGUID: v04jk5kUTYKt2u4HGlDWXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="65588246"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="65588246"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 18:43:56 -0800
X-CSE-ConnectionGUID: AKDov1lBR921Pfa45rWB8Q==
X-CSE-MsgGUID: Ghb/BrDWQnqJI0VO7BDyzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="118426878"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 18:43:55 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Feb 2025 18:43:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 18:43:55 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 18:43:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzIytIrjNcxkKGWgkVT2L+1i5jh8QTnGPXUX7wQ5ZXpH4aEb7CtER/9WwU0u6iHubiRiFxQDPaf0ASBOnaUIqPZdzGUHeiSsJ8HBJCEJlzt74V98s46x0kYjx1KjRUZjQc9b/0/t2la2RwaQtwphBK7drWxKQnzLvYyCtv8GM70JO33kt/0YPMXwV51WiJWOf0i5oxu2LySYMNlbxmh025WZEx38Bw01eH4CbfEbI1SyR7Dz10vOX1yTPVssDb4zYzfig+DCDTUAPWHGyoaS9GQ4jLGEywDi2gPvaiw+PLDkNzztliR0IVrKQo3wxMOagQUXv+hAXkJUSRu6vnxoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWhVZKw9tgm6LBdr0kNx2ad3ykvPPMwQvNXvrCbVsJQ=;
 b=syAZvNpMlFj+HCL0kfwMqzLNtHuXAE+614adqXX1fEbVS36uivXpyTTBRkc0LXy642Fa+vrqiZcGQfvBpfsbYd4v8CN1z+aTu2vEa2libYZp9Men91bODf8xYD9411WxiyxLhvfsxgMOTpd6irDzq+f/5/j3K8nGmOBxbrCmTYnsaZLlvVVp1f2L8WCJvIc+PhnzADuulB4FeZ6zT+SlQbOzce/iQ4GhSEiGfEELCyrZIFt1fjYFF94DTuZCsCUpz1Jn0RapRZEcRvcqpuFzeKIcvKJNoKyX/hiYuPsTNUcpZUYXLtauQNs6Cx5nZAJ/EUYam9GI1nR/2THYsTfq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8512.namprd11.prod.outlook.com (2603:10b6:408:1e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 02:43:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 02:43:52 +0000
Date: Thu, 13 Feb 2025 18:43:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 17/17] cxl/pci: Handle CXL Endpoint and RCH Protocol
 Errors separately from PCIe errors
Message-ID: <67aeade4ee5bc_2d1e2942b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-18-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-18-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0266.namprd04.prod.outlook.com
 (2603:10b6:303:88::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 16817b52-ea50-4723-1b82-08dd4ca16ad8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pQK91MPzGEjnWZV3Dq/4Kfvj2XrQUvlIzURD0QYGYdJlWqXwy7Fh9Ok5mLjX?=
 =?us-ascii?Q?cFdEzr/n3OIRTuCtmT2VAfd8EZbfF/t5pQHJRA5UPkGKPa4lHBa7Z1yX/x7+?=
 =?us-ascii?Q?0/DGz5VrjiwrWchyaDqHeMtrn6UAZKKMUQivpPtUBxxN+0YI4+al+LY8leL2?=
 =?us-ascii?Q?OKqVAxsf3htjLVn7LjcKfp8EBoGLIcOx5l0mT0hoSmGdwxUolPvcxz8sCPW5?=
 =?us-ascii?Q?n8VFkIkk8xuhZjIrMR37sLIhXOt8V9FCmps5HbJ53ACLNtFViG91OU298UVo?=
 =?us-ascii?Q?R9oP96G10QimNzaMMlFlD8KrKbA0Gd8bU3SnR7hJAyL4tnVzF8Pd2dgDm4T/?=
 =?us-ascii?Q?GYK17qhmOe4W05rJ4/+GP8w7oIUk58ZVTGyvJs2G/bZrHkI7GK6OVfPfHfVA?=
 =?us-ascii?Q?rGZXgPFUw0N1t5jCWBwaL74EveNg1o16OKfoubWq24zuFr+gEj7ZhBQKrFia?=
 =?us-ascii?Q?DHy4urJLiYhYqqyxyJ3BRow13hXeAQi4MG1PNtwUrZqWExpFoXoWTjwAdTz5?=
 =?us-ascii?Q?hopS61yDIGHvi4IZn3SWyyWe5Gu0prrnSxn9EDARaHxp1TgO3rTp6tmxDyV2?=
 =?us-ascii?Q?f9tviozMcFcUzIHVZ8rEbBoP7Lo952K44ATjyojJcnc8rF3shMFwulrTcheY?=
 =?us-ascii?Q?+Kipvusw3uf6XsNwt/DB++VD6MZ/ExoXJ2M2CbDcR0aPmbRcm/145C4kzjRj?=
 =?us-ascii?Q?icXDZTHianyQ/GZfn6VcOwHU6B1AoIXg93lsxOPQrgvNSzzxz2pCZ5yqvqXS?=
 =?us-ascii?Q?PfDwd8fthMG09nqGJNqlgCm735aty5UYaZGrCs3+8FrSEmBZOXvynxXiR/Sz?=
 =?us-ascii?Q?wTB0pl4ixPUEph4TEmDQ+Sl7JKBe1BAvxP0UkBQ6bsHKfzR3bZkI4tAOG9Ro?=
 =?us-ascii?Q?nXcwjhMHuc6uLhfzhkOVmEc+cqDxzqAVB4yW96h/WfJ5PHrj2JzJmyvRo5MD?=
 =?us-ascii?Q?3NCK4WuMDQhq7zF0CO4TjR1NY8LC+cSih3lrikkMVud9PJoaTinX+o10XEI1?=
 =?us-ascii?Q?m7mtrB9yMmPFvnjbU+Y3rxpXxVmGp+tum/s/Dowksy7vD4oFKiedrZU7zt+6?=
 =?us-ascii?Q?9gjWD8njIVO1jPdvjQtFW+IPd0PN1rUnmfRRDTZFTZ8MRpEGVktsEBy1+MSB?=
 =?us-ascii?Q?GVWDTOU5skHexZp276nXUlKH/RW/Pb6rupTWXIz8U6/l6SdlNEXjRaHz0vBa?=
 =?us-ascii?Q?t3hxOruA6e7YGL6VoWLehsUJoYfzst7Xy9V46qUChuH3FINkyBv8QDvf4ecd?=
 =?us-ascii?Q?FwBjbtkTRgD4SaU+ePc8WJ8F/R5sH3r8NNED7boq7Eqa6EVBnWD9qowcpE9M?=
 =?us-ascii?Q?gduROSk4eTt9GdkVYWqo3ereHcIiJhrg+8nRuNv9zbtzMXCPEA9xmMcvUPhS?=
 =?us-ascii?Q?8ZChXP42PCwDshiATgiRMDMQjx8wL+t+cF2JiHLPEfR7/MzRZBHJv+1adBa0?=
 =?us-ascii?Q?G/YM/5TC6hk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sdcW8Q8kIS7hgBpDZCTrLQ0aHP4QG6ZisFMEfbDIOWN+DlY+uwyZBxgMZDdt?=
 =?us-ascii?Q?cbnMkXb/YYVLZbmaYJNq9v83OsJKPECX67pmGwrDJOi5dFUf56Kpv7nG5ze1?=
 =?us-ascii?Q?E364GvH6DwWJniVic8Ysxviqv9O7BKKTv+fUaB2ZFFf3fczhnpG9+vJgLg6N?=
 =?us-ascii?Q?nvb/RuVkF2YhUPRM8MjFBW+ZwXMXpwE35t6FCyiXkHslWSpZxwujMQonRuve?=
 =?us-ascii?Q?ES1kfLKuwHxZi8GiHXidsaQc92Oqwjm5MleK97F2lqx8fyCXTllbapn/JP44?=
 =?us-ascii?Q?p1DTmXYBtFKgoWQy2ViDzg1cMVB11zFBeT0EwWYVfzsPkgpgBtyPUMYCKf/G?=
 =?us-ascii?Q?Llez3AgFysVMq4cr/yKjOF2/ZAnTxXo2aKh7ypklBX4ZBEX0CD5s9yTQUQGp?=
 =?us-ascii?Q?InoaRbCRxlZVowUNcNvarOdSZrIlrRyvXNYRIatm14iCbSolnWk/D/Bgfn87?=
 =?us-ascii?Q?j16AR2TaF2xHsqlvqLhkYWw/0EkiCsGSjIcgNsNi84pf7eXTgvLzeYMF2ZDm?=
 =?us-ascii?Q?oBatponBJBMbaOXySE5RaDdFR5pQBz3UJNVpofYe7VgvBgFaN+1m8IP6ID4C?=
 =?us-ascii?Q?NwWewU0qFIR3fqa3X2/kZbO3s2NNgTFYBdKYtWceoIa4smbWPW0hNLB/6wDf?=
 =?us-ascii?Q?ii6PCXNfDII9O2CjT3da079KU0wy71R67jdrzNPsMwV2BCnIrSDPA5MGw9zr?=
 =?us-ascii?Q?i+RZYbcBmAeVEsdJ/fsZqfJLRnoYa68XP4tWWfseYHJHBF9X54SAh/zN7LVk?=
 =?us-ascii?Q?U90czR7v4ZDW+ue+Jjgnbvz5bVY20R+AP4uRbUfcFyfCZ4zhPC5N2TQQSJdF?=
 =?us-ascii?Q?Eozo59W41AwZ+tJxbNyiIWxYeNoHW/nVtL3frufWEzPbEuP5T+EUzDi4IJiR?=
 =?us-ascii?Q?NfMnn5LxSb9T+7uLL9k6HUKYNk8M8TVaygUsoH5YqqCwOxgcjxqZqBapUKb4?=
 =?us-ascii?Q?rhuS1KgCuNImLs9sU8lsZ1Ed4ArQK4CWbhye3FcXr/DPdJkV24dnqKT1Z7/0?=
 =?us-ascii?Q?nHSgHjPkPcE0BhnvLMh8nRNL/iQaqI2BcZzEfNf8mJJNweYCFFma1RtwuQ6x?=
 =?us-ascii?Q?9NFeAQaNhT0qL9f9GPXwLrZqR3cUcvEuq3DWWP5p1u6XSaWcCuN1Hv7auHs1?=
 =?us-ascii?Q?lBloA7CcjUS/3JfbZI9Vatn6m4am/x/jss27HUlTFsE3idAXaPzcvRtURVtA?=
 =?us-ascii?Q?y47nd7kS1ho11EqvmZRPmgo2gN4EG7X7cyCCvpMzHF+9KRy9bXh4isQfiMzi?=
 =?us-ascii?Q?XjV0ERh7NQ3kt9X48GeK5HWjXg9MlE+c/dX2P+BrZlGd5vuYGEFaP/q0tZAv?=
 =?us-ascii?Q?D4ht0MQf8zTne4PELUjzsbU5BrQ7wwC6mnNDfS+a7ASnvnN6pKk+dr1SCRe+?=
 =?us-ascii?Q?tYLKdkWlptr1ItXj3W6wWlOHBlq7pOWCDYWtl3hpo2ix1Clzjw8vPjiUevdP?=
 =?us-ascii?Q?1LS4UXexONpbgooE0RY2fhx4e20XDVFNvuVxX1NWUu0VvdgZoZOT0kGLtCMk?=
 =?us-ascii?Q?41qghXaPMe+PfVAl4ZyfhTOGQGAmRNjVjSVkDJ3xzrqB11vU3ePw8rywohvR?=
 =?us-ascii?Q?NhTyDFE6b3QXlNRMbJmHtl7SzlICk4jdqI/kDV/hE4cEiyuM1nG12hlQbSxV?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16817b52-ea50-4723-1b82-08dd4ca16ad8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 02:43:52.3842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEdQA4wLFcTPUg/nahNlFI3jsTQOfhdXZabwk+MMfdCnDdpGK/1tn0P4Fsm5UeImXC/wpVGkxCy+jvNUK2lw9LaIQhuMrkVOrBJQJe33zA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8512
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL Endpoint and Restricted CXL Host (RCH) Downstream Port Protocol Errors
> are currently treated as PCIe errors, which does not properly process CXL
> uncorrectable (UCE) errors. When a CXL device encounters an uncorrectable
> Protocol Error, the system should panic to prevent potential CXL memory
> corruption.
> 
> Treat CXL Endpoint Protocol Errors as CXL errors. This requires updates in
> the CXL and AER drivers.
> 
> Update the CXL Endpoint driver with a new declaration for struct
> cxl_error_handlers named cxl_ep_error_handlers. Move the existing CE and
> UCE handler assignments from cxl_error_handlers to the new
> cxl_ep_error_handlers. Remove the 'state' parameter from the UCE handler
> interface because it is not used in CXL recovery.
> 
> Update the AER driver to associate CXL Protocol errors with CXL error
> handling. Change detection in handles_cxl_errors() from using
> pcie_is_cxl_port() to instead use pcie_is_cxl().

This all looks ok for what it is, but given the prior discussion about
cxl_error_handlers only running in the CXL domain I think this will
result in the cxl_pci driver having even less to do.

The cxl_core will default register port error handlers that can panic on
notification. The cxl_pci driver's only job is then responding to PCI
events and registering CXL objects to let the core handle.

