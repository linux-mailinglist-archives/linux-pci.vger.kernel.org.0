Return-Path: <linux-pci+bounces-21406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03758A3549D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713E1188CB14
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C16134D4;
	Fri, 14 Feb 2025 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBTIHLgM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478823C17;
	Fri, 14 Feb 2025 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499537; cv=fail; b=X4wlrPQb2klBVvgB+hOXJWgKy1288y+hhy9Hlkt2iJaz4SAEQ/4Icqwy8stbcxZMwzuu6yQPD5oR6ux2v3ZLp0vRgOoNR2It5FRcszF6WcYUKP/lrE4qAz6GrtnMEuR/3XO5TkkzpDsPJtSpMPNybrQJUG2B4bOnpN9j01Ck1OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499537; c=relaxed/simple;
	bh=qaJqP71JnHIFkEcxcgDKNWUdDFI0u1MCyJ9Z6Cqz81Y=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kRwvosXaXTjwicw9e+qOmR2NpWrKZylKYqQRT8SeLUivtuWaPsDFrCg5Fiq3bfIM2kJthWAuB8YmZHf2QZqxTHDEeSdjWzDJsts+kQFCIqL7tEYjDHMaeEnaw2fdPHgFTFTZrcK0cZDGSVWyw+N4o0fZ8dzbITx/6ox5aZEPmBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBTIHLgM; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739499536; x=1771035536;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=qaJqP71JnHIFkEcxcgDKNWUdDFI0u1MCyJ9Z6Cqz81Y=;
  b=bBTIHLgM9773tUNKsZeAIyu1/tfJAdOokf7G0sG2b0hHd7WpAJtCbpe4
   jClqrDFLR2au10Q8zjo3kpa6tyB9B+bXy1B53yWd4aN+amMSWiQ/kUAiB
   aoQgw4gq4EVTOAguoxrkHJM2Dn/MaxbAv77fcfr0K0nZ7bNGirNmmt9TS
   NmgEa2qCoWmyrVp9GqONMmyNE8J9OFoggDYQAMrO6GPGtGp7cT9kDoMIe
   CcU3apir06DySx4FFUS+ZPlpqs95k0iHY2LJbRGnE/hOqcmMVEuziZlDt
   U+gCEH6pFXtL47nvTs+9Wd4NnSwiiDtVI/m8Fbzf4Rw/NlEn40AWUrcQ1
   A==;
X-CSE-ConnectionGUID: 20nRFCKtQbGDsY/Ier5BYg==
X-CSE-MsgGUID: zTT11sUNT8aKf3GsOI0TYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40497199"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40497199"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 18:18:54 -0800
X-CSE-ConnectionGUID: 7yIManT9RQOn7YfWY28q0g==
X-CSE-MsgGUID: /7+Vhl4xTF6C2jzjEljAAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="118339183"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 18:18:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 18:18:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 18:18:51 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 18:18:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCzBn5v4ZevcDZpP+zFbkWTwkMyoXfPxi4VdEmmSfwo5yxNUjmMw/zZNOHh4Un1KGoTz0VjpWeFVvY6GtOnSFo4o3LevK02HSGbfjcpCbIV5ykNoP2yLK3+xJNrykFqojmamoI3HgmD6R8MtF+GnTv0naqW5X2CXh8U5KVWLW12iIoJ88QsRhHEnBErSSRHKDwIOc8guGpRG/x2wKNp4f0sM5WJmBefc/d28eFMjwfbqvC5LrHiObpcAT2bgSYY+sYxEsExxP1XWb8w0Tkh4heyOvyNiAoMXsiaA3nEzZF0QfSgjXcueOtAGqdcZ5JSMtzSjYTuxEA1ZVvNam3+HYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgPRrBpw3FJaF8l8pV470lNWy8kPkEmd76+NUd5A66o=;
 b=VjpM2Czy0l4lYdQIkHPa9Fd6THRXpuo6VevLLMvDV+1TzSzzr1e+ftyIjT3YUBOITNz8F/sZVCnhqjSFpxEGc3IeD5rVC992Q9gsrUjiC0IJQNniPIfWP1b99hBQRzik8MFfh7lFbiNVbMAQBTNrPiQAEh/eGG3Q0qONiROWc65mQDb6U08ja+grgk2Wp7dbQqEZg3/v5E5QVKVBD07dr4lmuV5nTdzV0PFZL4OybFwzztber2i1kQum88/RMZSCgGkoRLGVrxPrS+VgaLtRjzzf3iGJ4JmadVRcp2Lhna+LGfCaB+e7Jo1CXA+s3ZqNFApIMOkGu5SUsaK1PU5Y0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6359.namprd11.prod.outlook.com (2603:10b6:8:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 02:18:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 02:18:43 +0000
Date: Thu, 13 Feb 2025 18:18:40 -0800
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
Subject: Re: [PATCH v7 12/17] cxl/pci: Add error handler for CXL PCIe Port
 RAS errors
Message-ID: <67aea8002a005_2d1e29466@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-13-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-13-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0337.namprd04.prod.outlook.com
 (2603:10b6:303:8a::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ec122e-8d10-4378-3af1-08dd4c9de74c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pM6sKPU5Ey525buA4nZGlQ/+ad4Qrq/qvCSJ435skRXCBm3tdly+9PYDH9+n?=
 =?us-ascii?Q?D635oQpxeGv6OHqXxVxU3JxQBeeA5T5qAI3z+IXa0qaZG8k8QPtTW8KzPrpN?=
 =?us-ascii?Q?opvVyEhEYD50PoR1PkBQ0BZxfqWQOv7QHXQZTHOxzDbbFaMU8OpLCpT0uPMi?=
 =?us-ascii?Q?6OsXYyaQgMQaSPSsGZ3S8nSG0UAz2pK2e1h1BIcNu+X+lb2yZWn23nKFsFom?=
 =?us-ascii?Q?3ehd/G4Qf9mt4uleX374VugOM3/fb+zvpbdWYw424jjKY284Jss9iSOT7/p1?=
 =?us-ascii?Q?rqXc8DQ/6GWi5ufVpRepbydwWF/BD/8GgeornWLHhoydL+rnEkC6ts6bZWh7?=
 =?us-ascii?Q?YIxU8yI0SIwXTGe2Gc58chPqFgpVkp9LlkFP8p+Op6eAyy76/fAUeFcf4z4+?=
 =?us-ascii?Q?MF6pzlz5456Ch0WXqRNQ+GLeQ4HseGQP8ISR3koPx5woKvYJzPwbwE1uRCdn?=
 =?us-ascii?Q?+aTNiXsKS6seKqbSH4P/7KJfHM5X99BQSTakKrYBVQPO9tFsKVCC6IlgmCxW?=
 =?us-ascii?Q?q9JynKFWy39fRtM/atmEzwlmcJzRjyfrVtl4/bOD2h+EQmvLNUYcvSdA0LBE?=
 =?us-ascii?Q?rnDxpgCU/uRsq2LpF/YIWPk3bo0rdo4T8yAAuptVL/ytYMIsAY7Ql3W+3y9x?=
 =?us-ascii?Q?gK7wpnQczS8KL/TCuWEm+0x/Tdw58SgUE4YMqCUJbYp0CuGFzkU5Yo8DdLau?=
 =?us-ascii?Q?DfGZ6wgk8+bgTWfvi7QsZo/nwv9DjgPAfzSvDY8qNAlx1eHRDgZY1gAtfG/d?=
 =?us-ascii?Q?bIhMJYofMFTFQXJofZvkoZKrh7DXDuopQpXDee5aPeEF1+rjheQj8iwxU4km?=
 =?us-ascii?Q?xEZfEUVhUItieELuYVRJHIgOURufWzVsSWXBIz507hZyzLcADeEtRDDLgM+k?=
 =?us-ascii?Q?B2bPBjm6H7pnepnV2sEqTEIDt7ryeiJlapSJMJChpzMVHFa0duJUU2+IaT59?=
 =?us-ascii?Q?fMBKuTc1KxH0xlM39Gh4K5MoNAh+pjP+e9cXBtTQtTD3R/FK9sN2XqJOUpwQ?=
 =?us-ascii?Q?QT2H2ky1+1YM8kZax5e0WoEfa3ekNUhB0nF3+RRent4Wwe/17XQ6s16/V0Ki?=
 =?us-ascii?Q?oCW2CTqYL8muDGl/ZnYubS3JiIcusNrOoFmFjCWCq+lMb4vSbsqbJdFEw7rk?=
 =?us-ascii?Q?gweFo3kR+3tjvo0mnbH6hiFlcCHQ2hRUGTndfgQRPSZFbKRA8aJGYtJQpDA7?=
 =?us-ascii?Q?5Npx+TK1JO0ejiUhItFqZGv8THr15G/VjFIlubd64OlaxUDzzJFn7ie8MgWG?=
 =?us-ascii?Q?pG5ZqtwIgnpJyOpyH+EC4brwAg6Dlvhp0eYB4qU1up4KybuXruwb6t+ovJDP?=
 =?us-ascii?Q?dhA0FpAKc+8dO/FI+ZXLD1s2aD8+rwIQ8GadECa6hFsh5EEZD/uNgbRxhR6k?=
 =?us-ascii?Q?JXnZqks0AP53IV9DYB140Zd7grNqgy3jFjQDuju2jcIWhu0NAISNyLUCXkTA?=
 =?us-ascii?Q?DtcvsW/r7I4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ScXCpuKswVUI3aZ55fBSn+KyKbi51C41+Wp6vRCwGu0auDFzcO6+1Y9Y4NpW?=
 =?us-ascii?Q?1Lvev4ZE3AgixR3iGBQP0bOWKeYDXlJyIqGb+u/o7QQLBQdvoBKowv+4b7gW?=
 =?us-ascii?Q?ItC4itsQes0WYCu51yWJuWHzfqnhLttR+dV8O5g3EGv7DMOz0hwp7rJqk/LA?=
 =?us-ascii?Q?4qdd1DBB4cM+UCIOxl2QoHC7l7Z3EaW1brcB3LnOsX5PDSmQDj8p6ul/8WR4?=
 =?us-ascii?Q?pt+7aYvtr0r7+KpJG3+p3pVxlojqE5NjxV9umFBNnJQtOW2y1spzDQPelftq?=
 =?us-ascii?Q?h7fAnoh9N3Rh/8d5SdvxwG6jvEy2Tv3CeAVZbtc42Q0hEI9lHHAcrHIEKNZ0?=
 =?us-ascii?Q?5t9qthpZSAPajM8yafvARaSyHmoFaL43LWxbnDCs54I4iDgxB1TPHh4GCJgb?=
 =?us-ascii?Q?DBmG7l+a5nO77QvxOWiEvj77bJ3EmZjPhy4T9kbzZsPlAtvUcIPSHjYixTUL?=
 =?us-ascii?Q?IAK3fbgu55n9DqtcQqzOS6knIK24ag2Up0xOX5e21uYWtxuaTrBbdU8iBVgG?=
 =?us-ascii?Q?34YFclA76+1rr6C+GesphsyMmG0dmdctWKbpfCMESDHBl+iyTaaBY/CTL+co?=
 =?us-ascii?Q?h8mV3iusMpE7zLZVf6JYvSuEKmi1yKRXDAOcnTIUsVNZJyg1ZSjbs7eh6W4I?=
 =?us-ascii?Q?pIaWLSVG48orYWMob63L2V4ulQJ7EretFZBW9moUy682p9Z7NMMAW3S4+G3g?=
 =?us-ascii?Q?OrJtdIu8LTix/cq8CFAh/meRFqA5zJ+XYFwbFhCo2pDcdPuXYKs8PDKRF5d0?=
 =?us-ascii?Q?ljkZ+YZ/u8UUiVGaoYFX44LW5+pFEXdAm/3VAPV3yXkiUdZkBW+X3l62gcah?=
 =?us-ascii?Q?qbHDuUIifnri+TYwT0W3BN+l/KxrnCDWsX06tye8h5Nm17EwY5hD8kf4evPY?=
 =?us-ascii?Q?i3RxATEZmjKmJz+BuzvzqNKAB41EkvwSn01noi2ky0wICoYVagiYbPPG+EvB?=
 =?us-ascii?Q?/Lw2KQLerbGWj4hOVcXensg7m9uTnmMm7FgobpgNbLScGiVRiMlCKJiAb0aH?=
 =?us-ascii?Q?KQ3aFNZeDMOc80YCwxLqX4ZYsKFJZS2HUVJ/tKSa2MTm47XMEvyLTMlCdG7E?=
 =?us-ascii?Q?Hx5OWzO7ITrUgYzN7E+2A9sp7fgTBJPS/YRUvJ5+JbRTWBdZlwrJPdcprWky?=
 =?us-ascii?Q?8SBK16h7S00nwbnslw0HYQ/PQFENLcZWdGQ35S/411OQAW3QA7/XIoGDYLR8?=
 =?us-ascii?Q?WPxQhmUNPrnmDfXsWt40M6D/gMPp/BGxu4hZoG1Hv4rw3PS224T6kzvEIiPn?=
 =?us-ascii?Q?Z5v7HUCCAIbc6VowtCzbI62qqybj9uH57xKjAnWs3YfYEWXszea+6aA/csl/?=
 =?us-ascii?Q?Dup77OO+L/EVzJMGhz+4iP0Ak+8/mjwKmE2sFbfxknA4WNdVIgnPOOdGUorl?=
 =?us-ascii?Q?QBEgcDuqwj/2skfUYp35zKUxEI0vAr2nPl4Otyc1Fhak7QHQlHjdGvyBFSvU?=
 =?us-ascii?Q?pkoejE6dqcnHRXzVSLnwWWshALoBj1/IihEuYuqL0yXDqnAhleLb+r8S47Wd?=
 =?us-ascii?Q?Y61khSpHtGrUCHujRRFTWeil6NVQbktF5Dt8hVzQgyhG7Ny85d3y2txcF7Om?=
 =?us-ascii?Q?0qeV9AJSF4h+rYLLuqsgIr7Po09yCRjiq7B3w4kF5j5ZFkIjg0de2L/tethO?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ec122e-8d10-4378-3af1-08dd4c9de74c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 02:18:43.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63mhanrKKcjaA36Jf6Xy95c/km5V/iRr7X8B3T5U6GZ+Lq4YEB++W+zBC+lN6INBK/gOPckUlRSOl7QlmIFufRjnkBN/rXlQm9rzvi+nOoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6359
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> Introduce correctable and uncorrectable (UCE) CXL PCIe Port Protocol Error
> handlers.
> 
> The handlers will be called with a 'struct pci_dev' parameter
> indicating the CXL Port device requiring handling. The CXL PCIe Port
> device's underlying 'struct device' will match the port device in the
> CXL topology.
> 
> Use the PCIe Port's device object to find the matching CXL Upstream Switch
> Port, CXL Downstream Switch Port, or CXL Root Port in the CXL topology. The
> matching CXL Port device should contain a cached reference to the RAS
> register block. The cached RAS block will be used in handling the error.
> 
> Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() using
> a reference to the RAS registers as a parameter. These functions will use
> the RAS register reference to indicate an error and clear the device's RAS
> status.
> 
> Update __cxl_handle_ras() to return PCI_ERS_RESULT_PANIC in the case
> an error is present in the RAS status. Otherwise, return
> PCI_ERS_RESULT_NONE.

So I have been having this nagging feeling while reviewing this set that
perhaps the CXL error handlers should not be 'struct pci_error_handlers'
relative to a 'struct pci_driver', but instead 'struct
cxl_error_handlers' that are added to 'struct cxl_driver', in particular
'cxl_port_driver'.

See below for what I *think* are insurmountable problems when a PCI
error handler is tasked with looking up @ras_base in a race free manner.
Note I say "think" because I could be misreading or missing some other
circumstance that makes this ok, so do please challenge if you think I
missed something because what follows below is another major direction
change.
  
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 81 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 77 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index af809e7cbe3b..3f13d9dfb610 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -699,7 +699,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> +static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -708,13 +708,13 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  
>  	if (!ras_base) {
>  		dev_warn_once(dev, "CXL RAS register block is not mapped");
> -		return false;
> +		return PCI_ERS_RESULT_NONE;
>  	}
>  
>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
>  	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
> -		return false;
> +		return PCI_ERS_RESULT_NONE;
>  
>  	/* If multiple errors, log header points to first error from ctrl reg */
>  	if (hweight32(status) > 1) {
> @@ -733,7 +733,7 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
> -	return true;
> +	return PCI_ERS_RESULT_PANIC;
>  }
>  
>  static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
> @@ -782,6 +782,79 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>  }
>  
> +static int match_uport(struct device *dev, const void *data)
> +{
> +	const struct device *uport_dev = data;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +
> +	return port->uport_dev == uport_dev;
> +}
> +
> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev, struct device **dev)
> +{
> +	void __iomem *ras_base;
> +
> +	if (!pdev || !*dev) {
> +		pr_err("Failed, parameter is NULL");
> +		return NULL;
> +	}
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		struct cxl_port *port __free(put_cxl_port);
> +		struct cxl_dport *dport = NULL;
> +
> +		port = find_cxl_port(&pdev->dev, &dport);

side comment: please always declare and assign scope-based-cleanup
variables on the same line, i.e.:

        struct cxl_port *port __free(put_cxl_port) =
                find_cxl_port(&pdev->dev, &dport);

Yes, that means violating the coding-style rule of preferring variable
declarations at the top of blocks. This is for 2 reasons:

* The variable is uninitialized. If future refactoring injects an early
  exit then unitialized garbage gets passed to put_cxl_port().

* The cosmetic order of the declaration is not the unwind order. If
  future refactoring introduces other scope-based-cleanup variables it
  requires additional cleanup to move the declaration to satisfy unwind
  dependencies.

> +		if (!port) {
> +			pci_err(pdev, "Failed to find root/dport in CXL topology\n");
> +			return NULL;
> +		}
> +
> +		ras_base = dport ? dport->regs.ras : NULL;
> +		*dev = &port->dev;

Ok, so here is where the trouble I was alluding to earlier begins. At
this point we leave this scope which means @port will have its reference
dropped and may be freed by the time the caller tries to use it.

Additionally, @ras_base is only valid while @port->dev.driver is set. In
this set, cxl_do_recovery() is only holding the device lock of @pdev
which means nothing synchronizes against @ras_base pointing to garbage
because a cxl_port was unbound / unplugged / disabled while error
recovery was running.

Both of those problems go away if upon entry to ->error_detected() it
can already be assumed that the context holds both a 'struct cxl_port'
object reference, and the device_lock() for that object.

As for how to fix it, one idea is to have the AER core post CXL events
to their own fifo for the CXL core to handle. Something like have
aer_isr_one_error(), upon detection of an internal error on a CXL port
device, post the 'struct aer_err_source' to a new kfifo and wake up a
CXL core thread to run cxl_do_recovery() against the CXL port device
topology instead of the PCI device topology.

Essentially, the main point of cxl_do_recovery() is the acknowledgement
that the PCI core does not have the context to judge the severity of
CXL events, or fully annotate events with all the potential kernel
objects impacted by an event. It is also the case that we need a common
landing spot for PCI AER notified CXL error events and ACPI GHES
notified CXL CPER records. So both PCI AER, and CPER notified errors
need to end up in the same cxl_do_recovery() path that walks the CXL
port topology.

The CXL Type-2 series is showing uptake on accelerators registering
'struct cxl_memdev' objects to report their CXL.mem capabilities. I
imagine that effort would eventually end up with a scheme that
accelerators can register a cxl_error_handler instance with that memdev
to get involved in potentially recovering CXL.mem errors. For example,
it may be the case that CXL error isolation finally has a viable use
case when the accelerator knows it is the only device impacted by an
isolation event and can safely reset that entire host-bridge to recover.
That is difficult to achieve in the PCI error handler context.

