Return-Path: <linux-pci+bounces-28142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5209EABE5D4
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044A24C806D
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455E825392D;
	Tue, 20 May 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="POf1A7zN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1903252906
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775553; cv=fail; b=q24peuN8iFgxP+xNWIg3K5qP17nXFEIosrChrfDxd0U2kockivUzvZ46RxaaUZ6YQYu2oZl//A9Q0SHWn4kqsAjYhIMEWjeZEZcttQ9At8zdFyBhuHyqkd4uniVRk2zZVtQvtLdkLtG8XkfIOY7h8aARCVp4j/DomP2k3SAbEq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775553; c=relaxed/simple;
	bh=dWGdV2ARWVygQXNSibr6hPtNITHpsw+tRdR0FYmQ+zk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SeyRVmT1wLQt2CkElFL8D7RopK879veb1xFpnL+qwKogI9cLWo+9YJY5S3mRiut00kpSTyFQjZlQLYzsTcDIgqHxlgJ4Rf2WHyJ5744ljfJ036Xnivo83cKh5eCf0Z7oDo9BvlHcqCuaRz4fAsOTHGn0ex1nCJNFDnYqFn+ptFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=POf1A7zN; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747775551; x=1779311551;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dWGdV2ARWVygQXNSibr6hPtNITHpsw+tRdR0FYmQ+zk=;
  b=POf1A7zNPZ2EZIR5nmv8vDeRJx4taqXn1Ap2PHuJCnksqYcXSgUaa4jc
   IXj5mDtA9t/M+AGr7LDFYdNDaThofmW8cSg9ghYH2n0EWyAgF7iQnUuou
   rXiyMNAyYD3iAu8p1E2uX/2CvED+ggBE2Uduldv5rw9sGlmGSsmGtZWOj
   x0+tFmEmKJ+JfKLMoSqEixlF1o9D5Yt37n+eSof8UafgBHVLWZeYvDLv6
   +/6Z5W59fK1dSMSAk45CnNDLkQ1BzanHfFHV1pef3zxbIndrOFPwzdWAp
   Vwt9FeaNgSpPRaxmukdDrt6sjM3aS4zComXgUT+0I+cX0FuWZ7WdQfALb
   w==;
X-CSE-ConnectionGUID: 0lXZNO8UQ7GUlML6ADOvGw==
X-CSE-MsgGUID: AYCybyykSWy1mxrwJh5reg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49712341"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49712341"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 14:12:31 -0700
X-CSE-ConnectionGUID: r9n6MQDqQSeo0Q+DtkR2cA==
X-CSE-MsgGUID: p97zV3vRQvSmWmkoZvcOSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140303886"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 14:12:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 14:12:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 14:12:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 14:12:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kbo7bQbmPDZVi6n1Quy7avNFlfqbrglk8fBKtXe9/bnTCbNSLolTgq/FswWhbfaBRAtG5upmFUeK+jIShoP4A8WYeOk3Lo4KhEdK1x3kqQ5YilYuiOIlwoA/+RuviHhaEUBcJV1+Fl/1o7PvBzYfvxGqg4nEggvtTfmAg6uMivJjripnMDLY4kusf7vT6VMcTgp2v0S16IgVw9aedRBKumnFmyKvzmlacicq2NKrrdo0ji4UMsqOJ96Uz3lhmHzUOm/sG1tVVmYF5TTgvI+5utlZPXnCreVSsUQAsS/Crf8YRxPG0UiRBnfo4FdcCDixrSeIcUO9DDSH1habpts9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmEoXjtWrMWHiqeOFpaaoDJruoPbky5yWVh/dOCmkgU=;
 b=Tqt7MkRgspcNW/w87LC/n+H0/ts0wV1vxq04MzHSvyaYlTzCaNnH9N9rLvlPAxSaJetSN4/3RVq8V76KV1B19ZmDa5Rn4+FubV6NutQf/9xk5S3ZpiwEv7XbQH5cARezzwvrLDsBluqFHduzkF1mYoClm1dznT4bq9rWDKHteoJtAHS7C0diRVxj99a/MrVUMZmRt9n0oQxzKJ0dHHyNcsSuJVtkL7WE1igRZsztrTNHAVRTjQIEh2WPNdqftDsPnEP2B7dwbNDBpEksASYLOIJe9pfploysolyZ7WYARsbMwXXMd+V1SPxZx8s2LbK2bentKUUXqJVEPDxOd0c3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7390.namprd11.prod.outlook.com (2603:10b6:610:14e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 20 May
 2025 21:12:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 21:12:27 +0000
Date: Tue, 20 May 2025 14:12:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>, <suzuki.poulose@arm.com>,
	<sameo@rivosinc.com>, <aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <682cf039687e3_1626e1009a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <yq5a1psj6ep8.fsf@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yq5a1psj6ep8.fsf@kernel.org>
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f708fd9-c470-49e6-8925-08dd97e30655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YuRqOMeeqv9lndV8Y9C2bnXGjoN+7Nx+UL+WfG7/Ez/keGTX440BM1ZW3DoV?=
 =?us-ascii?Q?w1CIczfEyr0jff5HgyAV1SU+iFSUhhEiBKotsCKEB3kB6fzrV46NFQ9r7N1E?=
 =?us-ascii?Q?RlnHaCRfUZVsvRo0/RU7AU/M2eQASBVQl20rbVncdynT5x4f5Z6eePDPGfiH?=
 =?us-ascii?Q?HvexEny5rfF9kK6b1t2A7EKncVMXWFDNSzhRpvK95Hs9/gvePaZHm5u6O5tY?=
 =?us-ascii?Q?iuTgkQuoe01d+3FF4y5LKZnyl4xmSUywnVkMCwKJ1L75ljtanSPYOdkL9qTq?=
 =?us-ascii?Q?GY/LNozQk+aVspAdMFS9TTWvyFW/RerJ2m0Q926rFHM/MYvcx4ok1Fwp1zUY?=
 =?us-ascii?Q?krDzT/nNsYGhE/ekZk7LSQ7V4cgddpxXpSKOP0J8OSYdmRcrwY+x5FKpWeL5?=
 =?us-ascii?Q?8697UA8IVP78LZ+YR30eQypj3bT23q4zCcbewk/VpA4V8yo8/Ue2HPCItHyO?=
 =?us-ascii?Q?dJ46TID6aR1Boc1whRZNYJV3UIXXl/hmRd95ENUBEDo4XN3/j6DE2l+sO6Yd?=
 =?us-ascii?Q?ydYEJf3JW3QxUiHf5gnbmwt98USotGGvE8ABzAa5rMNaOMsjpWGqtCHVnoZG?=
 =?us-ascii?Q?D5qJCZYCf+kRhzV3JMc0Cmz66503oCrp+GPUe6t1sR7IwgD7JKG25SRCs5Y6?=
 =?us-ascii?Q?vr2raUuytVCo8hUxsEuAXejViZQcgNA3DIwKY7v4G6WgFPnxV1ny+1pLyOk+?=
 =?us-ascii?Q?X1nop258esXANQwgXmvZQ5kdDYh/9t36yt0NgsfBkclmDQjYAt3/bZozP3/I?=
 =?us-ascii?Q?9pB8xYKxXDwqVIc3FvKzJn4b7AoCnWB6+iUEAe1RoqZAF6H9S7az5vuywnw+?=
 =?us-ascii?Q?9Kfia4WZ619G89RtSywZB4x0aUpPmEF5t0ZmYzf7xN/hn6m1Gh3gIG2Fa6Kf?=
 =?us-ascii?Q?l+DGSCzrRJogAPwP+bCdvLYyRV++Tmf8Tk8+LOkOSIy/nCbBPRwkwaDuEYw2?=
 =?us-ascii?Q?uIYtMdDlQajdRfTTdcW3UnxCl6yCb8c9RzTh6V8OfXH2Z25KWGqWyHGF1qeT?=
 =?us-ascii?Q?sRwKzd4dpgJNMNCwyVsqWDuKv8orQCRNUEFesjZH3HjC/juG+diG+T5b4Pno?=
 =?us-ascii?Q?f808t+NnbKyS027leDuIsGTdJNwLsGbgG+6OtQc4KTh3GPIR63H1TIIpwFg5?=
 =?us-ascii?Q?TL1iCCG4IKLyAzzZSKLA27JIm+VUSVqypWRHuo4V9IE1EHNu63WCTMTxH8Qr?=
 =?us-ascii?Q?6zUdKGfXzkICODerb9f8tiHhaPm3jfAUgKk9y136M0DSzLTLzJAwK1n/BSwu?=
 =?us-ascii?Q?UfX8sNy9PnzzY2N563MRwyWgjJ+itWbZr+TZRY6nwfkDdmJp53ccorW8L5b9?=
 =?us-ascii?Q?IGLVHcbR/98qA2JuEs3iUBjSb2CkmKCKN0gaeTcW2k43MCcJ+FuilR4pz9hS?=
 =?us-ascii?Q?hMaqVj0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FZ4h6dNkhRAIa/Ie0tcEioyR2VcfiXiQ0c5xFHu8xJEf8r2iTJvv0fclF0WI?=
 =?us-ascii?Q?HaJ5FU3EoUJbdvdNXDB8uyohURUCpYaImFJJUryKk9Z7d8fv6sxFdyHaN1Y5?=
 =?us-ascii?Q?ZvIlpliTW5kFtq57v7Uql+zTKYMeoClWkD2pFrOI0uM9evqK0gH0x5a2SmW8?=
 =?us-ascii?Q?ZdgIOFWGX0hPMuobiWMpio+UU5JSg5u8qu+XAifkEi8M94CCde5P4reSephs?=
 =?us-ascii?Q?hVmhkulvWrwAm9r1cSk+Rf99YyTsmHcItQygP/pRp/6ci0GPrfPVzfyAfYWn?=
 =?us-ascii?Q?z3/9PP/YHykoGYCYAhMJNosdRq46lyfKDeHoxm8xliPsakIg988Gl5xxDPtA?=
 =?us-ascii?Q?Uxr/MVmI2d5UjIotdmbOzUXBloY++VPdsJNXHVU6Idoj+CSDlUch64yErNr8?=
 =?us-ascii?Q?L1nOsGHPeIWn+zUn3m3DpdeuOiQRNlqz4Vz49MSXWEJX7x/CtJs2BNWKARgF?=
 =?us-ascii?Q?+eI4MRXhrglku6XcgWERX8hnejRcS0Ta+Qonq6YoUapgXpEDsQXNBYMEybhY?=
 =?us-ascii?Q?FM/atypNCIFPUap10pNJqbwje8ttcXglyJY75kjsLj47FfsmQF8m6gEHUXX6?=
 =?us-ascii?Q?8CUDfm2nfOdltWRv1OSG16NDct5jREoaDjFNv9ir5Uz1rOPKl910g0f+hCtE?=
 =?us-ascii?Q?+QGWvoD/VoDRU9U0byv99BtL9UatsSCHOY7b5sG95fj8cAp0ZqfiC4uJ/yHD?=
 =?us-ascii?Q?AW79RXLoEFo1XcU9l0OAtjzEqCZJM9q44T7K5UM0wXo+Pxmflegz8dq+VNuf?=
 =?us-ascii?Q?7FWVsVxqxiuJQqjsHK6zWgnNJGBRklMyRR3sw0e9rrB1H40oFE3pQ8MFhV4u?=
 =?us-ascii?Q?f8Ae2GrZp0vZBODWTMnC8oDLgvtkWV8Oc75eIw7n22oZJulLA6gom2w/soG9?=
 =?us-ascii?Q?2DacJRDx/qTEbJ2EGwhLeUEEht8GElBvcyiNNXcohFjLPqOnuqGT5kMNqKlE?=
 =?us-ascii?Q?Bpxck3X88a4iEOEpcpe+k07/fc72S+++EuB8HaSPBuDRONdaZTN9o+IK48wB?=
 =?us-ascii?Q?7HqhD9Ic24el5LRFo+C/ySQHXqnD5NmNAbWBAdntNQ+2ubIGzqsYbtcWoSnh?=
 =?us-ascii?Q?yZrEDctIbnZs+iPHydv2RCQ6WR4sUgqjcNDseaDYV14Lj/+CsvQ12c/xHxwg?=
 =?us-ascii?Q?Rchl2jTPJqZZhlJQKddpPFUCJ3V49JFhBLU2XLScF4m0fY0uhjv+JD+PMFj+?=
 =?us-ascii?Q?2k8ZvPooJakAeJwNRF3ei61UpQKZxeC9s7cV8w0pKFGrRk10alsYcIVLWu+H?=
 =?us-ascii?Q?CO+I1s2TgE2URe05TSkWFE5cfVQ9S8zU+gcJNBrLRGOSqXuVH/lzqddoje40?=
 =?us-ascii?Q?E9VVREv1AiTAIeenMDK4n8fn+3QUxv8aN3vZnmudBJailDW9hNeaYhBMO+ed?=
 =?us-ascii?Q?2JHSYc42IXs6JAZl0sj2x5G8KOAIzDvCHRcdb8LiGQhoGqEA+WEdvoIDegO/?=
 =?us-ascii?Q?oNUVqCU/FsMKB8H5rT0LUcNKmw/IylZXnyFu6XXkXBleQj+3NVKHM2hc1evc?=
 =?us-ascii?Q?zgcCXwv2379pCGYLY6D9juB8DuzBRAOXpRiOVJ8uyvB7JKWdHol5he9hcniB?=
 =?us-ascii?Q?yXzH5SqVtnhfbf3T9MU2AO7FHrBUULTVHcpcr38RzT79vCZen0HDQJj8lehg?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f708fd9-c470-49e6-8925-08dd97e30655
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 21:12:27.7155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XadbQg1AC7rmyeWdnJNhLWZXNlS0NMb50nxvp7plPk8wZQnz2MuuBp/Scd/b/1xYs/pHjcx0dWpD5ItWIoPtRJ+NGQ+jptjGepKuuCahxh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7390
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> >
> > Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
> >
> > pci_tsm_bind/unbind() are supposed to be called by kernel components
> > which manages the virtual device. The verb 'bind' means VMM does extra
> > configurations to make the assigned device ready to be validated by
> > CoCo VM as TDI (TEE Device Interface). Usually these configurations
> > include assigning device ownership and MMIO ownership to CoCo VM, and
> > move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
> > TDISP message. The detailed operations are specific to platform TSM
> > firmware so need to be supported by vendor TSM drivers.
> >
> > pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
> > to TSM firmware about further TDI operations after TDI is bound, e.g.
> > get device interface report, certifications & measurements. So this kAPI
> > is supposed to be called from KVM vmexit handler.
> >
> > A problem to solve here is the TDI operation lock. The TDI operations
> > involve TDISP message communication with devices, which is transferred
> > via PF0's DOE. When multiple VFs or MFDs are involved at the same time,
> > these messages are not intended to interleave with each other. So
> > serialize all TSM operations of one slot by holding the DSM device (PF0)
> > pci_tsm.lock.
> >
> > Add a struct pci_tdi to represent the TDI context, which is common to
> > all PFs/VFs/MFDs so embedded it in struct pci_tsm. The appearing of the
> > tsm::tdi means the device is in BOUND state and vice versa. So no extra
> > enum pci_tsm_state value is added for bind. That also means the access
> > to tsm::tdi must with the DEM device (PF0) TSM lock.
> >
> 
> Now that we have guest kernel also susing tsm_register, should we have
> patch [PATCH 01/13] coco/tsm: Introduce a core device for TEE Security
> Managers add tsm-core.c to drivers/virt/coco/ ?
> 
> Something similar to https://git.gitlab.arm.com/linux-arm/linux-cca/-/commit/2e83f71b4b3a71ee56a77b45f5214b6223dda3b5

Makes sense to me.

