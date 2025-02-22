Return-Path: <linux-pci+bounces-22061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DEEA40429
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 01:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3D6189D6FE
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8078494;
	Sat, 22 Feb 2025 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJRbtnP+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C3481B3
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184281; cv=fail; b=kSUIEVulL6m8qtHIGLX15t6hoRSbeZSU3SA/ormDsgc+eVFGib3VYOhuxKLQTxv1Nt6dcDbD18D4z3jemYsffvwyatmK7jHWkOBU0vzV7edD+O8o5zODlnPA5PmhMDZhbsVhXgjBGlcYUbwH4oDc1gZYRKdud4l21Qs4npapoE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184281; c=relaxed/simple;
	bh=9Sgtm0Pupj02gilr5JnuInStfxwPrLczWgYBq5gENwk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ORl4NgON4cKFoeaJqi0UMYKd/y1DxVpB3EUnyDsTU4+lGx7Gpl08r4UG11XuPjtQJRZ40cc3ncn8gNzev6jX/1XnVSKda8FT6Ew1iw5zK5LJUzo2Uamm5wJWZxxMcH5J847N9aX38Zq7v22oZox2B+Fqd50alfbKKK4iYu6TSpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJRbtnP+; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740184279; x=1771720279;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9Sgtm0Pupj02gilr5JnuInStfxwPrLczWgYBq5gENwk=;
  b=NJRbtnP+iTrNGBS68QtM82QYWJxSj1sHVRNpLlyqpsvAhhMamVhMfF7q
   6C0vCarpCLcqh7n2M0DDLC25EZwuJINlCwjt2RwgNJOe2KxMgm74IMAUY
   VyH2YgWp4kufU1NYjQj7wAtPB6sxRVzCtDFgiT68FwMJz3Nb57DIl8K2S
   HurGJnIFEhHk8iaW3WHOTv+/j4tc79dgpB9NukMp8Mp64g6kjVtbBLHpo
   JlNU+eKcSchAssbZLwgX3v+8eUqiJ5WEjiLH8wUDGe7yniPV7Ir5EeJhJ
   IgwQZxZ+KBwyiRQlw6R0ly8sTGNXlZwspyWRdIuLIrbTWfxDpJyuOgfCW
   Q==;
X-CSE-ConnectionGUID: vyldHqyMQkKn9zwOG8M5Tw==
X-CSE-MsgGUID: As63EkSXSM2mYCIWODvfgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44927797"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="44927797"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:31:18 -0800
X-CSE-ConnectionGUID: hGZ1kCs8TbSOrIkMeu3tpw==
X-CSE-MsgGUID: kaYzgGlUQgqOn6DmjQhxfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="115325011"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:31:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 16:31:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 16:31:17 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 16:31:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGj31LFhQmyz6VNxzKTnLhtrgFGMuYJMVJ/6k1aIuVRsAaDXjHCqg2Zt5P2bi0br4xtvPt04v8GOmx3dtKOsmDtzVec4B5lX9VzzlxBKtXDhszi+uzHtQyqMpKla6XwNN9yjTwyeP8gQprU2cHv3XUAHn+rm3AzIJBhsatwQiznBS8CwJuwKIetZfbTQXA9zG69wBP1W0UqAvU+7n8c1UmsAnOfVEuPtMIMP3XfxtX+JmvCDhpOWsA3Z4DHLwwAV6VIiiell974TO5bwC10TIsvznJpWvoWCt7JtURt039YNXmSw2ueEE6YIDRmmNGQGKJvW1QnPhOPTdVr+O4pXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JpZJqKDCbJzyYm/fLbWH22D1YFC0fG0t4rsb9Vye+M=;
 b=fOtiupbJRxumrrTbWyK/w/jrYcF8LoCvD6oj0UpfUYEqJkwRn9z6AP6JPbCVZ3E+ryux6EjUIf9DaxQ3n+LLWKRvu4FXCUIvQpvJPs1c2wbyuuct80/ZFL1Yl1u9bbEG6CAVuxvuhnwgtJAOwX7pQR9K1xPb8p0YH82IKmjrzwWMJ7Oee9SljeozACt6tt6A+uwXc2e/UGr7OL4L/lCw94aiqq/Ii52+TFlpjK1D6puvqLlf5SLGjm4m/WkDNIvzc8I3c/iyXx1YLSl2NIlQWWhstOVB/K/MLjETHn6mnxOPG6A0nSerNoZ+yCAQ7UFTQQAj87durP40pwYy+ofSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7403.namprd11.prod.outlook.com (2603:10b6:208:431::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 00:30:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.015; Sat, 22 Feb 2025
 00:30:33 +0000
Date: Fri, 21 Feb 2025 16:30:31 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Alexey Kardashevskiy <aik@amd.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Message-ID: <67b91aa742e46_1c530f294b9@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
 <2e7f85ea-40ce-4b38-acd9-56c02718771c@amd.com>
 <Z1p9f6HHkjlOw5Fc@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z1p9f6HHkjlOw5Fc@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 667d4898-8dec-4a0b-eed5-08dd52d81e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Hr/Y0QzvmJ8hdlpN+f+BybAucSdtb3xLvw9fEsg9gpPcIY7NakrAtPvFTDt?=
 =?us-ascii?Q?RxxZUaxcoSSmckph5Y3POOh00M0z3B+zG4LfOf7VIXv73hZX1CjvTK8rzxSt?=
 =?us-ascii?Q?QdTo6AZfL9IWckWfBxJsHz/IVKHvcttKzQ3e+VWESAyFc5E0CSgmqrfYoFBB?=
 =?us-ascii?Q?HUWFUU6mN2XwK8KRn0UVx0aXGauhLADW/K0MoZXS+QgZOW6iGRwHT7JZ5dIR?=
 =?us-ascii?Q?XCaeF9t3Eqk1AKKrXzgQr2jxVRe356N/3Ewbb8FQHNRJgUiTOvGAg7bFQUWz?=
 =?us-ascii?Q?2T1ZvTdHL3Z6gECFKj+YAjpBsaH2xElOsB/GJabsZZF4Wd4WfA8hkO880i7m?=
 =?us-ascii?Q?6ahtuUKE3SakuJ5MebHQyr+o+sIVxpuqpvL7s1NXW8rpFOU/5eYVa20UNpI4?=
 =?us-ascii?Q?nHm8L9bFWBGhMgbWurCPZc9QIHRUSrjwhoGccRk1Wu7O/EIhoTZmPnAWH69U?=
 =?us-ascii?Q?che2jZp8tUYr4z4opSrcN1dl38IdZH34PKu+7mMlQFumz+Apui5S2oSycqVh?=
 =?us-ascii?Q?6GOvLQkhlYeJJKz15dLRC6pPE5atpY0uY2PsWp3J4a/aacf5HYetDvA0spvK?=
 =?us-ascii?Q?t9smEzwIsMApCdERxkyNXJpxkxFObBIQ6G0YB/11HR4XXbZDccAgsy7zag+j?=
 =?us-ascii?Q?BbKavLrxqun5ypKHPFIPYs2vV+rOmH7qa70CiweHkJNZb27XH4ZQvT+RbLXB?=
 =?us-ascii?Q?G9Uq8mvs95hMOYBUwlh72sEEF5thn/TlDrKNj1vLr8q8Zmvw1ALP7TDVeAWD?=
 =?us-ascii?Q?6R9Awb7zo7ozoYZCqVe1fUaRA2ZtWeJpRZXVu9WNL9KYQboKLG6MRay/JVCw?=
 =?us-ascii?Q?X4pmOsrX0wdZ2+cb/KpKodGQzmzaK8fUFvJRJJvfsadjOaC1F9zY2DIKgKh/?=
 =?us-ascii?Q?WDDzdilodUk/m0vF/0Z4zoWDjQMEgE/9QG7QZqtAeMM73+o/e0v8qL87pX+h?=
 =?us-ascii?Q?5PEP2DCKpx6RRHfx4aMF8d7yT+CumuWnU8d3/Fzg/rB/YkVOFqvrLVSzzMcu?=
 =?us-ascii?Q?3j74Z4Gnm7t+Qy+7j6paWyGWh6mu6v5ZlgoCLL5ZZoH10rFUpFTKHpngJdrW?=
 =?us-ascii?Q?y1y5YtofzIV45KDNNVrRyKyva7ZvhavZtJT/xXxTO3sJpMQLNPnAI4P4Ywdw?=
 =?us-ascii?Q?5eJuJdbYEEdz2+Lx4z9BdKQhwArpTr1hqyt4v185U6tysmYA29/Lmrz42idr?=
 =?us-ascii?Q?0WOHVTIGCMFhw+CdebQUyfspFzP7dL39rtOqObXX+V9Mf3bYHXOT76qNbckS?=
 =?us-ascii?Q?SS+7uV/nrTMflhT93kT0ek7dVwFdZZnD40wFHdd/AvK7T26uow1SUykImbol?=
 =?us-ascii?Q?DeXLr+CnOa9rvJ8xy3RcVtMk91PIyKASuOe4gwWXHfRTAbo07T6lkGqKthZH?=
 =?us-ascii?Q?Gf2CCNRUyEUs6Sl/Pnm/DpW7o+F2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tsDra/Syk/HiwDXKFRe2PD/x18MtPR+te429NW8p5Rd3YqhM7a/Qj1b7+htD?=
 =?us-ascii?Q?Ij9NNyKzpdX7HfuX3HiX0QVgvm9zWMOMQO8HfXIp1jGHyevj6YQRrCKwvXRt?=
 =?us-ascii?Q?RTrcDLA0+JybMEiN+5tZwu2zTAh9bz4+zOxoG2gaImGvYDTlQix5w+rubnBK?=
 =?us-ascii?Q?JTV5XmsxyIZbPPNAUxXtCbyTGOm8yep40HaQOnS7TfdjPXRq0D8Gmif1Ja7I?=
 =?us-ascii?Q?nTU/YCndFbCmqQDZ98DAPd/2bwOAUZ68ueCsfMXSu/0oALsxgXycojrPldc0?=
 =?us-ascii?Q?rzBn+cncKOjAT4w6n9XevDcd+pUa4dtaFpOIN+AWq+BmDbTxEMJf92EOM6ba?=
 =?us-ascii?Q?Ht+DGdeenz9yH72Pvj2c5Wgdcyjl5UKYz5dOIdi9o5Ch5uQg7Ya3CZcNJ65n?=
 =?us-ascii?Q?UNQwQZj8vP2mrbQBV3IfD+FWkC3jdeeeZm13VMUsY5MZ2yzVy6xolfLX2e+q?=
 =?us-ascii?Q?eknqRm567g69/4435nghbKx1vlUJoxefEpEXGK3I+Wp3REjBv5k7Vcfgz5EI?=
 =?us-ascii?Q?3wTMI80FKyXgXPfyxVLLE4hhrIRzsFcAVDI18EhXXww3MVmE0UozkTmr7b8x?=
 =?us-ascii?Q?OEpNF5HU56qUvbvpoMBgGBnjLwEMKOFuWazZoAQzuUJOEStUrzm3Gd6Hkvi1?=
 =?us-ascii?Q?t7H6UGAXcF1/RA6kydL0IyFQDC/Da0moIaZ4USWzyh23xUzYUx/FSeZHE1Qq?=
 =?us-ascii?Q?sH9N6ZBrN81GpQMPrU0NFECz0XS4PxyweWEPm876A/cS3iVDrOqbbjM/gQVV?=
 =?us-ascii?Q?vb0dITmFAT/QA6ggo3iKB5d0w9Z9KUJ5Um1eAmxD5nA5NJrf3M9gNbZms24m?=
 =?us-ascii?Q?Laj/M1H7j4hNwHuchtQ+gUZZ3jIQC/yTBl9/dBrbcRgocRJSXx4kyLSCol4k?=
 =?us-ascii?Q?/cFggyftB0IAqiXKpYA5MmxdaUbxZpoERV/nxpmy3jDh9sWHhdBMU/QNSBRl?=
 =?us-ascii?Q?498nggfIEjTFCJgnTdgjI/9dLEy0dKpjr927xheLorLx19sk1xv9nz5s9KWN?=
 =?us-ascii?Q?wWtRTWT3sMepsboks431v9fmfo00P6aYNteTzwOHwxEJCB26OxbLXy3Re/Qn?=
 =?us-ascii?Q?yVwCKddu3AEOVH1GNBjHRoW2WqteEoa9PjifDZJgyr8hjg3KJRupddCmFG7h?=
 =?us-ascii?Q?9z3jwUfprIwA6C59uKMT0EYBVmENXpfOwrgWKZlhgWqplvRXQDhGCZkSNNCc?=
 =?us-ascii?Q?fkWoH1edWLE8mwRcJTJ8Ck5y4ngMy+2F9aZDOIWvfm0zxYjvFX4RbYeDXZSw?=
 =?us-ascii?Q?481rjQOdy0QPPc6MDTw33iwFAbsD8wA6C7XPCRRHx+UBxKs1QSvuILem3d9F?=
 =?us-ascii?Q?Qp5D7gQuAR3Va27+A9lSymY6lHF3lxi7hVTzPZDxPCiV2nIb7N+y+QidPpPR?=
 =?us-ascii?Q?rIVN8nOVcYYFdVpXf5Ci6riX+CFRU6pq4XEJL01hi+3tWm77x4jQafZ7FTsn?=
 =?us-ascii?Q?a5Hepfdrak1Nw7QnddmqN/tq456ej3c3pJpXXu7i55OkGLD7Qlr+a3quaOmk?=
 =?us-ascii?Q?F+QpJDruy6FT8vQbbg1Q96M/c9NnZoJ61NGGQ2k8lKgQ0pYPPiSDrE6wC7UH?=
 =?us-ascii?Q?B9qRp+qTyBOq37PI0qCWkAJ3RQMjwrY3mJ0tGemwWwz4QO2+mPuAc6EnjvRk?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 667d4898-8dec-4a0b-eed5-08dd52d81e48
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 00:30:33.2301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rELpTSDJ4BS7DFRjfEuIst6detvIxlsO030siWyQ7svHjsIxEp/RloPvE/g60IzVt7zwnU6Vw8DiFv/q8QqiKVGwlfUKYa3innUPsGXLzWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7403
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> > > +/* Selective IDE Stream Capability Register */
> > > +#define  PCI_IDE_SEL_CAP		 0
> > > +#define  PCI_IDE_SEL_CAP_ASSOC_NUM(x)	 ((x) & 0xf) /* Address Association Register Blocks Number */
> > > +#define  PCI_IDE_SEL_CAP_ASSOC_MASK	 0xf
> 
> PCI_IDE_SEL_CAP_ASSOC_NUM_MASK is better?

Agree, updated.

> 
> > > +/* Selective IDE Stream Control Register */
> > > +#define  PCI_IDE_SEL_CTL		 4
> > > +#define   PCI_IDE_SEL_CTL_EN		 0x1	/* Selective IDE Stream Enable */
> > > +#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
> > > +#define   PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
> > > +#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> 
> These fields are more likely to be written to the register than read
> out, so may need other definitions.
> 
> I think generally _XXX(x) Macros are less useful than _MASK because of
> FIELD_PREP/GET(), so maybe by default we define _MASK Macros and on
> demand define _XXX(x) Macros for all registers.

I also agree with this. I had copied these from Alexey, but for the ones
that actually got used in the code I ended up using mask defines with
FIELD_PREP/GET(). I think I will just delete them for now, and we can
add them back as masks later.

[..]
> > > +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT 20
> 
> I don't think _SHIFT MACRO is needed, also because of FIELD_PREP/GET().
> 
> > 
> > I like mine better :) Shows in one place how addr_1 is made:
> > 
> > #define  PCI_IDE_SEL_ADDR_1(v, base, limit) \
> > 	((FIELD_GET(0xfff00000, (limit))  << 20) | \
> > 	(FIELD_GET(0xfff00000, (base)) << 8) | \
> > 	((v) ? 1 : 0))
> 
> This Macro is useful for SEL_ADDR_1 but not generally useful for other
> registers like SEL_CTRL, which has far more fields to input. So I'd
> rather have only _MASK Macros here to make things simpler. This
> specific Macro for SEL_ADDR_1 could be put in like pci-ide.h if really
> needed.

Agree, I ended up with this definition inline in ide.c:

#define SEL_ADDR1_LOWER_MASK GENMASK(31, 20)
#define PREP_PCI_IDE_SEL_ADDR1(base, limit)                   \
        FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |             \
        FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,          \
                   FIELD_GET(SEL_ADDR1_LOWER_MASK, (base))) | \
        FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,         \
                   FIELD_GET(SEL_ADDR1_LOWER_MASK, (limit)))

