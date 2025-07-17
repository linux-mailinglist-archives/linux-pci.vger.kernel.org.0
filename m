Return-Path: <linux-pci+bounces-32440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1F8B09407
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 20:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EDB18909D0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC222FF48D;
	Thu, 17 Jul 2025 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVtPtuHw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89F12FEE25;
	Thu, 17 Jul 2025 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777264; cv=fail; b=l4UcDPT0UUwxYpJRSyrYn179bLQBJ/oWlLPnMOtuTauqzZRddvW+VY76mT+W78cF2OlGSmYRi0IiqH4+OuJr2LVHZOLBE0QZ1puFk/fEDxhaiT3qMOA4Hu4bJS0aCkaILVdjeoi9e9oDMX2HdR6wcfkJP7dxvxfYx9C40aDKblA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777264; c=relaxed/simple;
	bh=20uN+k324oX2WcTKyzEIxdQeivvu18eCP/K99vjT1RU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iQonNQDbwq7G1JK0UhDNodmsFIJr35OGRvqElUMKzLZldpareO3n5If9yyWFuNgGWxOgSl1nb575/L/5u9Uai0bWZhqQy8hPvtXiSaoy5SR9+vO9YD5pZFsXSgdFRusGB3d/0iMzPtYPytYe1StqVaED5VvRHA4HaRijfwAKnXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVtPtuHw; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777262; x=1784313262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=20uN+k324oX2WcTKyzEIxdQeivvu18eCP/K99vjT1RU=;
  b=QVtPtuHwuj5BMVRVI7Lt32YDqdwFwRuDWKt/RfiRU4iVsUBePwfHb/pi
   Jhwb68pOqq7C/+2SpigZqp61n0SGBiz0NHvvTTKDd5V9ZWQHOffuo0moN
   O0wk5DARYdnQUCQReIzovD08DRSyIJWUHw7ziVeAYJupArNNIYbF9OcOn
   e0kSt3q14iPf8cVihdZ2gpPmj1kxo7whuPF2ibxYQwWcZJUCyM8BJAS+1
   qa8eXIPhMr9t76V4UATuxpe5XubqnDC1UTtrQ47fypJ1N2xAysmYBUrZ6
   m3f5msDqc17LqZK+4Mbe+vnBje0nUt0Ghi0HqAroznsQVHSXTyluh3s3V
   w==;
X-CSE-ConnectionGUID: V2F3xnzmQCugKAw7ByFflA==
X-CSE-MsgGUID: aCYUXRaTTrO//cdYKaBrGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54945699"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54945699"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:22 -0700
X-CSE-ConnectionGUID: cdtCdmvsTGOOgRLpvfMzHA==
X-CSE-MsgGUID: n3dUXqWmS1C9NKPqeW8Rnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158222627"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:34:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kW1x4gCVKI/LH6tBuPMoXUXJHEMdz+G/U5CLzcuGfB3CaYCV2SZ82btcO2ZoyZoCvx9O2JdaAl1o3LKCEDl7mI+UdQRBX8Aa39fuY93Gra78VhmJ2DzMmwPkWk0S5xouXtn0kMCt/BSPz9pMb5vTU2SoUCxEEBjFlAn3MbpYCwVpgCVDHodAlBvJ9troVgc2ucedx5cz4c2qXUFkQtyAV7vcpb7N+N8dpzobDRQMdH6Yswg8XeQiDfKuJNcwX1D5ARTEVyvPliPL7noYPTltfcNvaBpjzgVLvWU4533CdrVh/499P2n04YWcjflbeTx5WnMn2hI5zcnikSTcHWe0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ynw21CvL38RWYypXi23wc0VUMC8cDxrP8QRyHdlq0g=;
 b=o+qHuYaXspEhIwTVL9CptjfiecEPaRyrfwZtqS9XVqgOI2DUYrQ1JvHqXXe4BlOtuo9zdpa3o3ARVcE/W3nw4KfKIOZjfAMrmIGjwDjfGq64NIaV9N7HYb4ZCWXAi08hgKrY/gIzE40e7k+PEnUomfXXp4UhSxqWRsOvbsTu/MonnQXhGsYlZSashuBFiOfdm6ZGf/r48l4H6rLFIiJpPFww6AAuP2TxUSTZ+bEIpPYwZ2/V3Oz5tpuhwZFQoobN7rk8yvAz3KRWEyCkkpDpokhze+ppL+AXY4Wa4RmfA1PlCViPZVu6oO/MeESsjHzZ49A0aKRi5taQl2mEoB4V+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7066.namprd11.prod.outlook.com (2603:10b6:806:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 18:34:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 18:34:09 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yi lun
	<yilun.xu@linux.intel.com>
Subject: [PATCH v4 08/10] PCI/IDE: Report available IDE streams
Date: Thu, 17 Jul 2025 11:33:56 -0700
Message-ID: <20250717183358.1332417-9-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717183358.1332417-1-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: ab068871-405b-42e7-6839-08ddc5608502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VLdB+kvqoW+UQOTHbOL4UDJE/TiPVCghbp9M3EGza+OcyTnQ2CDYoecL32Px?=
 =?us-ascii?Q?6LbmdsMHzv4ylux4EJRklJaTIjAA7Ax3h/2EJAoIVMtCSLybdwBnPelGQ+KI?=
 =?us-ascii?Q?FNjaECAVlxOTlaxRicILlEIMvSpKaPOtC3zMa09KMU5mxYlXW+7Lga1WMbFy?=
 =?us-ascii?Q?jR+KJYsatoLgaLSjitnnhAbgGbOqQxdaK5dSraCOqm4AnMiH4pkAuhcSg3xv?=
 =?us-ascii?Q?YBtJLXyYbbFGVvijaIyp5sq6RgeWbfpSVoDxoP2D6jOCyrKFjsLBy6xtRerq?=
 =?us-ascii?Q?VoFEbJWOHUWqnBg6ikf2/91Z994dt/fyf7BS/7IHXabXFansrglbU16iQ5AS?=
 =?us-ascii?Q?b9FBtNTou47XRWX2H8mx+iNAM2BFzDhWHf9+IVX7lfwtQCKl4QPEzr+Xzg8/?=
 =?us-ascii?Q?MRu/ZXtGMOXFrbkCfKxBb8C7Fo37x+dFUVu8+1K1fzpDMwHkSSUlgYZEK8uA?=
 =?us-ascii?Q?mbgAFJ+GOBXkypIjo9SrdMOzQJ81IAP1emj9XqBOC1W2IQupfZCsfrAY/dPh?=
 =?us-ascii?Q?4fUtzMSOHuEpzM+w27gAOJ+BLRnrXPOa47OF2lkH8o9X7s+QQ3Wp18LcIsBm?=
 =?us-ascii?Q?0PDrZ/xXngimO9oFkHZIauOIzpfY/6pghimWItNGySoFQL0lJCTzZ0j9slCx?=
 =?us-ascii?Q?kJG96Va5YCRB/Tv/gdMW1mZLPmqjld5SxfnegeEmKX7/3FOnQbL9ebXDPCJ9?=
 =?us-ascii?Q?C8+zrBm9GvC033YH+0LFbmZA+jqD/HVbiZt6tAKNpLbrbclMoblN3RzAcODz?=
 =?us-ascii?Q?p/XpY0VLYStgm/kqqazgEvm2AXh7+K4aPAc7bKl+M0hPniG/sHUDOJ7N7i71?=
 =?us-ascii?Q?2MoGEAstzEPd0uBpyYpJIKcemz5s5LQIqye00onq7FZ4jcO8MTGY1UAhop6X?=
 =?us-ascii?Q?xh0IfPQIglhrhonC1iwDXl1lPCQyVdP+JxLDMMlCIGq9cx5eh6sZ21JxI0Pr?=
 =?us-ascii?Q?aFYBkq5dgxmMawWZlTnhXa/3cdjau4frdqs8P3JyiJGFLrpyhtmdUNDTcZO0?=
 =?us-ascii?Q?5dphWInTACPrgohmQQ9rEFAwYJY/ob9EAvw733h91EA2ABBmH70Mj1uIfB6R?=
 =?us-ascii?Q?HJSPo9aB2czscVgA+u2O00WQ1HV3+eB8ZhXTJ62KFB4f+6aF4WomhS8nHIbA?=
 =?us-ascii?Q?onQYoibU5dt/1t724aEkwcEI6zLqVJPLt1lpnwV1OWf7ZpkxCMLby9aTVz74?=
 =?us-ascii?Q?bvMwuullGvXBfH34MAV/GdUj8RP3Exq5HRGhrc7hoGIrOtPo4y9vcEjsuqfy?=
 =?us-ascii?Q?nMtWLT0H/ZSeCaZ/tIILk5Jf0E7OFVJ/SteSGRBH6oLGulAAGz4LxPYdKkEw?=
 =?us-ascii?Q?UqwCVbQJ0l2adcApe2xqyqG4Nn3qScuD0Cr557pBkh8ALDuAS9QMjgBmDOTq?=
 =?us-ascii?Q?rzzg1/iriqq1Hu9XZLLyTsq07YBXk8LXS8ZjtzeQuR1JhBKcJvjc0VvTUNhh?=
 =?us-ascii?Q?YoKsrMKi5Pw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JUlMgL/GK3TJKHJkYBgO8hG01ib9PcjRp0h4ZMxTWOywhasSJa1nIMj2nL7b?=
 =?us-ascii?Q?zF+io0KxCZxMSiuCRpe6Bxjeggi+CLAHrBiKz0alcQan3opUHyILoICKnmmU?=
 =?us-ascii?Q?/TeXKWNBQUAedCegQGsjOPvpzim/m1sbbS0T1ljfFQffre6IiPweiBZO4zdB?=
 =?us-ascii?Q?Nq0Pl42fwkCm5hY2UdKTnXrXg4VwKP+qTSDR+D7lKfxMRUxOs0n1S++HNs9l?=
 =?us-ascii?Q?6gPUkerbNl0LTAEpKR9hhpeVJ/8vGtEz0oqeJHw28bspKTXamQ6jBikKqhn2?=
 =?us-ascii?Q?OswyHiLtiHz4UVDXuL200OAZ8O8ZXfjNzHIK9fAL7OBVWBWbwjjTHjU8R/u8?=
 =?us-ascii?Q?xdjq+HZhp/b2FmB/n5iTZTmGmGcfxmkiD9F3zAQhK24/hKBfjb6k48XvQ14B?=
 =?us-ascii?Q?QWvKrbo17rHR842Wl6kfFlTe0iaNcphKFa1BlSmTPVuGtstELdLfuAtge4MA?=
 =?us-ascii?Q?Z0tTD0YLxc+EWoBrhFCrM9kQki1+6I10OacokzjVYNvRS94f4HikViCde41D?=
 =?us-ascii?Q?FCgk9Txiji7fGyBC13CpK3fSxOkIEkERcwd+8MACyPzvlp2AdC9jv3E+Vo6D?=
 =?us-ascii?Q?fmhAIuVCSw9RFYXs12fu7swZE7DkfZrnqKe6UlLTCmhGCD5ievj1xixAcoP4?=
 =?us-ascii?Q?NnlU+GCuFvJYOyqzdjQdyXftP6sA24fIrUDzcTfsCeURfhf2zkJEVZoQKF7Q?=
 =?us-ascii?Q?XW7d01OCTujY7lqjFDX5pIryHITOiaAU3DPT6LKbIBjhtU1QSPkjqWurvZgQ?=
 =?us-ascii?Q?nnNPxnnmeErbW17IWiq25oUI22k+xGCl3Bt+Igdjf1TqCr/KxnAnGoQMVM0C?=
 =?us-ascii?Q?NbUgSenLxL4jEQnvB5mCIiiIMFE09hxORyt+rnTTqZU2MF6L7n3dHAWnBqoJ?=
 =?us-ascii?Q?mWqh9mNvMOJVqChjCwxB0xGp7yx/Sza5XvA33tRnJVn6SnpTmXmb5mAYBGSp?=
 =?us-ascii?Q?HQ2hhH3ZjfMWz8S6Ag4X52x4PRfcqrpnDwsGdX5xf3T7J2/TGBhNER3thlUt?=
 =?us-ascii?Q?KDxPtoQCpd4GqnBBVse67P7hUmU91fCNf5W4AWETk4iOw6SkT62BCuVmfREK?=
 =?us-ascii?Q?Gp2iKbSiMdiZ88BcDMp75btxteemyMCnsEw264hN4BIprC7agXrBcdohTHQt?=
 =?us-ascii?Q?j+1djRFxiMWV1ELmGCtewV72k/wDRKcnxGt9pN4qzeWS/XjSjQt4PUl3aSiz?=
 =?us-ascii?Q?uzsyaLHzjDBfoG/xOQpgyEjeHei9CmnKUEdMlX1yz6nKdJYHjV6AirscmWxp?=
 =?us-ascii?Q?p1T3YkYWaLFgAQ6+UWVesAa0fzRfABRBUpC9aYvd3F9rujDGPQPxx2ghTId+?=
 =?us-ascii?Q?craCGgvO/3ZvqHSZg5YJ/lxW/GSgPxgT0ZHJoQNyx/ZunJpVcyekZuYMxDKY?=
 =?us-ascii?Q?TbQPm5kBjqGfTpkYBKj/91FPf+DuED2F03KniYINuR74/bhX8Z4NryJAUxkZ?=
 =?us-ascii?Q?kV2gmO+GSigAZSHV+xkJyvVFJ3Ey3TDis7pD2WeD5+22pJ+bSkpPvv63cqpW?=
 =?us-ascii?Q?YGpy28OBigfw6/nPzLM1NFuiJCxdXKa8m+MtC+w2LlbBy2+UN82F5HJNPZMu?=
 =?us-ascii?Q?0O6q4Nzns/ZH3YBXi7ArtUymZIwmaGqqxq4ZRdBkx2Raqr86pH/ELPv9GOvM?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab068871-405b-42e7-6839-08ddc5608502
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:34:09.7740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lHoRMnXLKOFvgo0/dTp1cyXvJ8GNx59AX6OrP27TEcfFiI+3BLJeEwt8LZV5XRAnZwFJjDqfPOPiLh0eVoMeNJ2N0UqRABcAKWHj0InRZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
X-OriginatorOrg: intel.com

The limited number of link-encryption (IDE) streams that a given set of
host bridges supports is a platform specific detail. Provide
pci_ide_init_nr_streams() as a generic facility for either platform TSM
drivers, or PCI core native IDE, to report the number available streams.
After invoking pci_ide_init_nr_streams() an "available_secure_streams"
attribute appears in PCI host bridge sysfs to convey that count.

Introduce a device-type, @pci_host_bridge_type, now that both a release
method and sysfs attribute groups are being specified for all 'struct
pci_host_bridge' instances.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yi lun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .../ABI/testing/sysfs-devices-pci-host-bridge | 13 ++++
 drivers/pci/ide.c                             | 59 +++++++++++++++++++
 drivers/pci/pci.h                             |  3 +
 drivers/pci/probe.c                           | 12 +++-
 include/linux/pci.h                           |  8 +++
 5 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
index c67d7c30efa0..067d0879e353 100644
--- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -33,3 +33,16 @@ Description:
 		resources shared by the Root Ports in a host bridge. See
 		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
 		format.
+
+What:		pciDDDD:BB/available_secure_streams
+Date:		December, 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a host bridge has Root Ports that support PCIe IDE
+		(link encryption and integrity protection) there may be a
+		limited number of Selective IDE Streams that can be used for
+		establishing new end-to-end secure links. This attribute
+		decrements upon secure link setup, and increments upon secure
+		link teardown. The in-use stream count is determined by counting
+		stream symlinks.  See /sys/devices/pciDDDD:BB entry for details
+		about the DDDD:BB format.
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index cdc773a8b381..cafbc740a9da 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -513,3 +513,62 @@ void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
 	settings->enable = 0;
 }
 EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
+
+static ssize_t available_secure_streams_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
+	int avail;
+
+	if (!hb->nr_ide_streams)
+		return -ENXIO;
+
+	avail = hb->nr_ide_streams -
+		bitmap_weight(hb->ide_stream_map, hb->nr_ide_streams);
+	return sysfs_emit(buf, "%d\n", avail);
+}
+static DEVICE_ATTR_RO(available_secure_streams);
+
+static struct attribute *pci_ide_attrs[] = {
+	&dev_attr_available_secure_streams.attr,
+	NULL
+};
+
+static umode_t pci_ide_attr_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
+
+	if (a == &dev_attr_available_secure_streams.attr)
+		if (!hb->nr_ide_streams)
+			return 0;
+
+	return a->mode;
+}
+
+struct attribute_group pci_ide_attr_group = {
+	.attrs = pci_ide_attrs,
+	.is_visible = pci_ide_attr_visible,
+};
+
+/**
+ * pci_ide_init_nr_streams() - sets size of the pool of IDE Stream resources
+ * @hb: host bridge boundary for the stream pool
+ * @nr: number of streams
+ *
+ * Platform PCI init and/or expert test module use only. Enable IDE
+ * Stream establishment by setting the number of stream resources
+ * available at the host bridge. Platform init code must set this before
+ * the first pci_ide_stream_alloc() call.
+ *
+ * The "PCI_IDE" symbol namespace is required because this is typically
+ * a detail that is settled in early PCI init. I.e. this export is not
+ * for endpoint drivers.
+ */
+void pci_ide_init_nr_streams(struct pci_host_bridge *hb, u8 nr)
+{
+	hb->nr_ide_streams = nr;
+	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
+}
+EXPORT_SYMBOL_NS_GPL(pci_ide_init_nr_streams, "PCI_IDE");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3b282c24dde8..8154f829d303 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -517,8 +517,11 @@ static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
 
 #ifdef CONFIG_PCI_IDE
 void pci_ide_init(struct pci_dev *dev);
+extern struct attribute_group pci_ide_attr_group;
+#define PCI_IDE_ATTR_GROUP (&pci_ide_attr_group)
 #else
 static inline void pci_ide_init(struct pci_dev *dev) { }
+#define PCI_IDE_ATTR_GROUP NULL
 #endif
 
 #ifdef CONFIG_PCI_TSM
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9ed25035a06d..a84aaad462ca 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -640,6 +640,16 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	kfree(bridge);
 }
 
+static const struct attribute_group *pci_host_bridge_groups[] = {
+	PCI_IDE_ATTR_GROUP,
+	NULL
+};
+
+static const struct device_type pci_host_bridge_type = {
+	.groups = pci_host_bridge_groups,
+	.release = pci_release_host_bridge_dev,
+};
+
 static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 {
 	INIT_LIST_HEAD(&bridge->windows);
@@ -659,6 +669,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_dpc = 1;
 	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
 	bridge->native_cxl_error = 1;
+	bridge->dev.type = &pci_host_bridge_type;
 
 	device_initialize(&bridge->dev);
 }
@@ -672,7 +683,6 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	pci_init_host_bridge(bridge);
-	bridge->dev.release = pci_release_host_bridge_dev;
 
 	return bridge;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cc83ae274601..ae5f32539a91 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -664,6 +664,14 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 				 void (*release_fn)(struct pci_host_bridge *),
 				 void *release_data);
 
+#ifdef CONFIG_PCI_IDE
+void pci_ide_init_nr_streams(struct pci_host_bridge *hb, u8 nr);
+#else
+static inline void pci_ide_init_nr_streams(struct pci_host_bridge *hb, u8 nr)
+{
+}
+#endif
+
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
 
 #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
-- 
2.50.1


