Return-Path: <linux-pci+bounces-9250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5003917050
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 20:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518121F2284F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338F17A932;
	Tue, 25 Jun 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l29Qj+GI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407F17C9F7;
	Tue, 25 Jun 2024 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340167; cv=fail; b=fta2ZtQK7PdYXqlRy7J04JT99jDniEN6jYmBt4giKI+D/0jXSqacfk+SmJMZWenbSQDI7A1XNtJQAXmwLrvv1+ldbVOK3SIxDlmSYN2m+FU5fmOV3+KsxKBo1oqBAQn/3ucYHemlJmiSgRy8ry9rfgZ91os4PC/dtlg82W1/AIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340167; c=relaxed/simple;
	bh=EUs2fHhadGg0v6MsGsfkc5FWEHWbbm8CBi5RpI+3Pew=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=esY2SNk0x3uM6EMOTInGvmOAtaDtO3erIHg8zSVPw3sSoCuBQbOtni0CiUr6m76ygaTLF1EiJi8y92WjVcdIKKpm/ZYyabejkr23IJuFIAArNS47Ve56WB4qBDjq/OG0ra3kZsiS8djOOnq7KZ4we1nfpJws4X2Mlk3OdeCh3JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l29Qj+GI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719340166; x=1750876166;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EUs2fHhadGg0v6MsGsfkc5FWEHWbbm8CBi5RpI+3Pew=;
  b=l29Qj+GIklltDWAO2xKAM/+/9HUS45TNBwqdcmMZpKMQHp0yebSHh74G
   aq1QVc561nf0BRp+UH+0AcLGTsoof0/R25DPdoRq9pym9vrQ8D4BaYst2
   BQBoRzBmb4AXt8xrYyHC1FqesgMpvQVQXFXukkZlHOYRfU/gt3v9PIjsi
   1Db7vtK9sy/Q4L5/p230hE8pBXf7V0G3GI6SH3gLBWnUFkGyxoSNxviF4
   ksSRBxzBx01Dwyu8itATIEPHF0RdFUfFGQi54Khk5Q4EQhvExAikl5PYh
   VOMNZbWzQE7xpXH/jrvehwM+pPddrZWqJx91GLvv+4bG/1ZVZuKjz5vi7
   Q==;
X-CSE-ConnectionGUID: DDccCK/iQqC0IptKJ57Nng==
X-CSE-MsgGUID: Cii91mHeSd2gynCOo8R5TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16256579"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16256579"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:29:25 -0700
X-CSE-ConnectionGUID: JZ7xxjBxQ1yJbhG0pAqTdg==
X-CSE-MsgGUID: kcDxPW7RR227EK+3wQhAMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="44388881"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 11:29:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 11:29:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 11:29:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 11:29:24 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 11:29:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frc0QZSv0UNB8xQtuCMk9uLa+wjYYj/NMJTPLQTB59+cYcK6PXUKJY/z+vNNjFak71t5YIRnAi3lT7xRL91JPVJ2lIweQ2NVX+C8v1Tz681Y398EoHX0anUtGFkFqDqrGyXbq41vAI2ww8o0w3jkHIibXLuEcvcx/0Q/9DixRM4dl4KtpUefnPfRT5HmzDVfdQlGY/KpdAY7AGbZUe6yG5FtRR2T2f3Ae4B+XiAizroC+ORI40eZAYJmlBDJJNhKOCx0KzoLXR47/UdGbvF+7RBqZxywrGSdypWY9qxpk4dKKdzoJ11ZQSwSDL6IXRszUkDMNGpPRX+C6siRXnLlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vnTRjdB6IACvmJ5oA4vWcyiitC0cNiK223hWLCkafo=;
 b=YkvAwp1sbNSt7S0hu/g35vitOg1pUv+xI01CVKFlip9sa1LiYHN0hjtKq77PxgnDW8eCf0DkjtX1Go2druIjfdQK53xcLN/69Br1dX097chsM1zTouAlFM6H+LnaB7oUaPA+/hnitVmBd85E0M3F2BUagepeq7kpTtjFIUhgn6WCPCJmH8jAwDvp2GyjB41puJxToL74ACZsAkrpHGzzWbBdTxFNBCDfVIBx/yI6P6RWPYYS8Y/8R+h5O9GUrvhF8RveoMT80DTHyf5lx3Ou4PWF9FU46ACU1XIXdpYxHiaUwzIF1kikDCs66+yOE2/YmVcf2mzGqGImRhpMZAGUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 18:29:23 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 18:29:22 +0000
Date: Tue, 25 Jun 2024 13:29:18 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v5 0/2] cxl: Region bandwidth calculation for targets
 with shared upstream link
Message-ID: <667b0c7e2ace5_2ccbfb294d5@iweiny-mobl.notmuch>
References: <20240618231730.2533819-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618231730.2533819-1-dave.jiang@intel.com>
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc342da-a5a5-4fc9-dc81-08dc9544bc35
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cyJXU4W0cTn6D7fn4kAxvB2CgaTYBjtaq/D38FbkLDe78vUWej5OzbVNyKbH?=
 =?us-ascii?Q?CyWs2/1BJje8ZctggJ0zcdl/rkqP2L+rMDRt3DJVEJ0BZz5G4k+9mCSLs09s?=
 =?us-ascii?Q?7wzwFsn6iYAFQw9zD5bHxGtSIcqeYlui23SaCVxyuakzDv8dVdCvHAutX1KD?=
 =?us-ascii?Q?alYnmra4FSkYV1jbjh9vrDBoyOFS4k/wUYh9iQR4N8ne7orvRAVrxBQefI4V?=
 =?us-ascii?Q?YBtvvh2Jnfu2QoUaxRxV7zN2jECJ3rWGGSJ+8u4t4ZZYWUYUhv/W/2lHoL2Z?=
 =?us-ascii?Q?pSrQGK5S2GuMTONT/GycG8VpkZ+7qW7FQg5lwkfYPUTN+DWa2Jxkg7iQxW7g?=
 =?us-ascii?Q?HiJvctE1VV80/QP0Pihd728D5hKJrZkHZ7xsDaHxWW8RaqOgVPB/3xo3m2w1?=
 =?us-ascii?Q?Q08rc9JO2/j4X5UR1u50noa+OxbHt9qOlEvJ97QACrv61PU0X4o39cb7jUQm?=
 =?us-ascii?Q?q1DmkWdDRfjP7pru8NUv84aJr4U0nIembcj7rDOfpn5n9D3/IngrHAXft3FE?=
 =?us-ascii?Q?yuF7rhM0RqQFEJemAd7DPvfgIG1VpzWfUKwlV8InsNb0hvg5Fb6MV0BKREOG?=
 =?us-ascii?Q?NmdNBsl2eDdamXzDN5r/GVF9m1HT9+m9W/NiXAxq1H//zuNVddEt2vLjNQXa?=
 =?us-ascii?Q?vU2AwapjPs11ZuIjSABO8rAweaLz6diuJ1HqVDKGBkUDv0FwA6gtOoHX7ASZ?=
 =?us-ascii?Q?I29uuULw5vpKkchVLNgtxsTwxCI5Q8kwbY0eWW3NYGsblVLvCgbodfTezX1Y?=
 =?us-ascii?Q?t9VckfITOvCJZbYTqi0R0KJt13yvgFk87EsSRAR3Ed+e2+JUJgDQRQPCmmAF?=
 =?us-ascii?Q?KBRmg40kqNUnwkWNBrZ5kOC6FmrzIo5gdOt4eWFtCNFzzJBOL3pAVFTjHgK3?=
 =?us-ascii?Q?RYNJSO+8PwWXbrug7/nunAGq8Q1CR+ExLmKNBU9vy5s71DXiN1DQdaMa+qyr?=
 =?us-ascii?Q?Qjse8b+cY8D5JHaCZPVZ+Lufm38ge9Gw1XjRanw9s7tQD/O4sJeLWmF0nD8w?=
 =?us-ascii?Q?7OjbV04jyVzTY8+aCyCvoMaL15hcGvjU/qxXlCsSrXNps9hLaSFK+PAQdxg2?=
 =?us-ascii?Q?FGwPC5EhZVEzMCukjEVEiCCgEHzGVKdMcw1f5cqPv8IZ3AWU1h9om+P0SMTq?=
 =?us-ascii?Q?dL0JGh+MrywWKFoSVwEC7ME8QLtL5n3VOSE4TZTWLpfYCq0a9cHDKqK78XmU?=
 =?us-ascii?Q?K6ueT3HOwJNpfF3VySuKuCXUlnBxGm9izP7wsQdZYb9Ebu6tzqhz0LfO5Zzj?=
 =?us-ascii?Q?lT2lIDGY1PGYANg58qFbUemKMPhV2c+rjKUGo8H+AuEngEEnanKvrv0CU4ou?=
 =?us-ascii?Q?Gcy1EPS6RC8j5u39G2gyKf1+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pa9XKwp4n22Fq9DxLLY8InTKuUz/S+9oUgJrRhGjhOkDgLsfuenT1Nw9d8GF?=
 =?us-ascii?Q?l3j2E64CIp5lgMQYha7Tl5KpuA10UDoeYDMrrYU5OrpJF21BbygM3Ctolxki?=
 =?us-ascii?Q?e64nsHuWtgYaKKd/TjT2/VgtSSSoJjBVIiEdGtU0RpfvyfeWNybrTJzZ8QVR?=
 =?us-ascii?Q?EGQRqrW+UnmmeCLCgUf5hE4UFwNr52u/GTnPkqRjdOoTHoqTg0HEvp0ZkNH5?=
 =?us-ascii?Q?i+7FlDQsUXbXcnnOVfOoiVNHkXP3SgIieq/MDfv3NJhS/yS+CwrN8QqOgNBs?=
 =?us-ascii?Q?gufCHN5k72dTuT/2uRWW2ZcM3mxbayX6feaWS4VJB7ng6FpABghZrLaWZqad?=
 =?us-ascii?Q?//mPBDmr7Pt1xyzyTa+6Afxm/zLFZ1zB5UjMqS4/Znhq85SX/LdU8MprJOwu?=
 =?us-ascii?Q?SSR7MaXjvTPJSupZlj2OtzMhPwxUfKB8emen7QXLCDQ2f97fh5FSwBDlwosv?=
 =?us-ascii?Q?I0Z5XyzLH05shSa7N5n3ojUobXM+dDpF2bA7RgaJOv6nwtAC7eNuzCnuXTtS?=
 =?us-ascii?Q?Seof0EStTvQnU6fwWD15ORLzsLvZt+a9OQ7uTytqajgq99GZjj6owkjkl2XE?=
 =?us-ascii?Q?2qon9Nt8BHXj1ta4Pvg0xybFdVO3vZnqVT6nnDxZ/XMwJhSU0g/KAa6/5/jn?=
 =?us-ascii?Q?EBsocYbNV/ZT7jOa3N2vlMpdXUZXs5cvi1qf/1xmRKPsDyt1pLWDOzzdUjwQ?=
 =?us-ascii?Q?6WF+cjxgTgEUPPxXMFCgvUh2YwzDE/Cn/kw2QNOq53TqGWv8i3GznmqTO37Z?=
 =?us-ascii?Q?WaAqIcJ4BhmbQzFuI7P8eynvZ9qAOuZL8rmPHMMBfBWl09WGrRHsKGsanm9R?=
 =?us-ascii?Q?wfN5pHhUoATylKSIc2SwWlZco17zPwdM+FVrPGLFGtM0HqfN/v2+nojDR2Ga?=
 =?us-ascii?Q?PjsLhBPpRxiJoxjV8zofy1KYhZNl0Hs23MvWvmFqn5VI5LMqCTwwgPIGRTa8?=
 =?us-ascii?Q?oXRcmc2oMef7YORku2kLUq7OKNYYWMKpB8frci/vibzL8FcK1I7JmP9/TaZS?=
 =?us-ascii?Q?UrJNlp8Y8+GEKQQpCyJsR5Zj4eB/oKOy1YekcIC9TicrmsbPYEMteFWtAP5v?=
 =?us-ascii?Q?uJg+3+qjpCm5v799YiOhbjz64dRKEB9u+XCBveZk/5HgVRyJveV0kinMAt+b?=
 =?us-ascii?Q?53k7u3tT+9zOCeN2hbOmrXzbQEm8vZP6Cx2F02ZCBobUyfvP5MNisXxCTfL9?=
 =?us-ascii?Q?v+WhiqUbqtGES6c3DGq3ONamZY9oa7f6+59effwP/gX6Mi/Z3cbFMGlqmnA/?=
 =?us-ascii?Q?UarEvYUGMhr144eJTYheWHtwmGtaQK4B0emEW17RwU11nNkOimWoxy4LFIbw?=
 =?us-ascii?Q?m5VLCUsXJ7U2BRpL/Q7YPMJF5PWF6q0LZXNGH1p6GGPAjzMj3rvomMtDN9lt?=
 =?us-ascii?Q?pEj0ss3i/ya8DJ9X7jP2Et8ruvrWzIW8DjF073Hujjp0L5riYiQDZWyVVSJU?=
 =?us-ascii?Q?mX7gcsmTEAtFSduMAYPXyskxABdjDApvq0Vpl6NOO6/4CsIjc/wnavKv4HMF?=
 =?us-ascii?Q?OFXYI4SXRYqRzulV0s2L4mmUmalM9F1cEk5OYE1KWtox7CEYb8nApv3aOukz?=
 =?us-ascii?Q?SY3CxIA8+Y0scsRBt+jDXiGsFI95xZAKQjNGhPMF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc342da-a5a5-4fc9-dc81-08dc9544bc35
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 18:29:22.8821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ki4uG7tuMIqlHTjVYy9H7lVN0uPtstkhvUS8SdbieQwBYmslqSHGU/4kf2/b15iGPRhtCiN8323ShEhlbZ6rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> v5:
> - Adjust calculation of RPs under HB to only active RPs (Jonathan)
> - See patches for specific change log
> 
> This series provides recalculation of the CXL region bandwidth when the targets have
> shared upstream link by walking the toplogy from bottom up and clamp the bandwdith
> as the code trasverses up the tree. An example topology:

              traverses

> 
>  An example topology from Jonathan:
> 
>                  CFMWS 0
>                    |
>           _________|_________
>          |                   |
>      ACPI0017-0            ACPI0017-1
>    GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
>      |          |        |           |
>     RP0        RP1      RP2         RP3
>      |          |        |           |
>    SW 0       SW 1     SW 2        SW 3
>    |   |      |   |    |   |       |   |
>   EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
> 
>  Computation for the example topology:
> 
>  Min (GP0 to CPU BW,
>       Min(SW 0 Upstream Link to RP0 BW,
>           Min(SW0SSLBIS for SW0DSP0 (EP0), EP0 DSLBIS, EP0 Upstream Link) +
>           Min(SW0SSLBIS for SW0DSP1 (EP1), EP1 DSLBIS, EP1 Upstream link)) +
>       Min(SW 1 Upstream Link to RP1 BW,
>           Min(SW1SSLBIS for SW1DSP0 (EP2), EP2 DSLBIS, EP2 Upstream Link) +
>           Min(SW1SSLBIS for SW1DSP1 (EP3), EP3 DSLBIS, EP3 Upstream link))) +
>  Min (GP1 to CPU BW,
>       Min(SW 2 Upstream Link to RP2 BW,
>           Min(SW2SSLBIS for SW2DSP0 (EP4), EP4 DSLBIS, EP4 Upstream Link) +
>           Min(SW2SSLBIS for SW2DSP1 (EP5), EP5 DSLBIS, EP5 Upstream link)) +
>       Min(SW 3 Upstream Link to RP3 BW,
>           Min(SW3SSLBIS for SW3DSP0 (EP6), EP6 DSLBIS, EP6 Upstream Link) +
>           Min(SW3SSLBIS for SW3DSP1 (EP7), EP7 DSLBIS, EP7 Upstream link))))

Looks good,
Ira

