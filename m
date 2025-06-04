Return-Path: <linux-pci+bounces-28930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E58ACD523
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 03:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FE51749DD
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 01:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096C4B5AE;
	Wed,  4 Jun 2025 01:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpRRBtxd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3EA35975
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749001997; cv=fail; b=a0P3hGnsweycI6tYMtrup2g9StwIHbLpqZE48DeH1jnGL5eH/XLzF6sTl2pR9zMzUc/d0K9X+DcCmVSHmZ8baOUZzdtL9Pn1wKVCN81Ao6ql0N9ljAcfVXvZpMUGoJn9AgZxnnZ4Vbu7R0GdaIvpXzRTztKv639KAB6/IbtdcME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749001997; c=relaxed/simple;
	bh=W5L0i4qQedowcNtkRYxUc2tK76KDQrvCmfPIu/kogxc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JER3q3fFTdgIDxVWwuLLrFDO0gJMVV41BoiznTLORZfGyAp0UjhmAHGEQ9/z8otC9+NEckb7lyN2nnFdWTyI6icSPcSoxRraI79cYWFeNBZNhDtlaea6KOxOn48gg9prs7ufP0lZuUh/k8kKhcZfKt+QqPns7K7zRmA2A8MxR5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpRRBtxd; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749001996; x=1780537996;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W5L0i4qQedowcNtkRYxUc2tK76KDQrvCmfPIu/kogxc=;
  b=FpRRBtxd2YOdKMBAJ4u8/DB7TZavNHWVvxZFkkYe7bg1gAbr6Ul8NFVs
   kk8bFJULtvjYMZwpcHoddajytGyvLqGj2kALDIo5R8gaXeznxLhUJPlY5
   HvP5BWeAuztPz/wwrUymv3hLGqU/dsnOuDMNn22DWgNUZP78ubSF/Gcm2
   wFh+lHc5dImds6sSNKU0GnOOGt3/cBTzdQQ159QWhWf9Ju5ZxeawCXU3I
   F9Af+Y4A1n7Bw5pWxI9E1EDsAb2co75quVCXa2Tg5lelWVt/uUl1S5zvD
   yd8qLHfHMpK4JvqWLZhua16/PkQ0amx6jNG49cOuHNujiJecJpoh7sBIR
   Q==;
X-CSE-ConnectionGUID: alnEvB33Ro+ezASLPEu/Dg==
X-CSE-MsgGUID: GaJbIZkBRCmQIKvcdD2IXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="51161081"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="51161081"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 18:53:15 -0700
X-CSE-ConnectionGUID: PWoSCt0US9WFjHzFRihG1g==
X-CSE-MsgGUID: VDkAujmgQhuzL3ojrvv0UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="148873147"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 18:53:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 18:53:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 18:53:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.58)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 18:53:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foitecfd2rWw/BdoCmYTlOoiUOOrn4uKYd46xH+qE/ztYjdxs58m21gdeHgJw6j/lyukDLNFlGzHoIQU5Kk1svUQPTbVFOlBoKOHrACYOn4AtSoyyEm2bTkfQOXIx7VgoLDUhYRS1ign6x9EmiYbmWnw5z9Kfv4eDXGjaw+4PAzTVtUQC+m9F+eSxjuM796Un2FqQ/3H7iSFkFJgGCIOBSpbr0k/9s1MO6lpqdEUPFCFpOJIfMKzafqxOhvIBZvVudR6iRtsRZLElclphEYeYc97tc6EHAH6Fty1y7g+5SvWUSbmmLfeVkZID8SZVb6GH2B73gkhCmAMyrfxUNN/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ9onFlRmCn5ewmpwKf9FealhESQVUbnxt0xwlTy0lc=;
 b=ZACDMgeW6WYR7p7NosD4CnL+6Lm9tkSkOpW0G7AqJ40pDgAq7Am00waOoWWy1wS4JywgPPylI96Bv2I47yX4MoFyF/yb/KRYim0oCE6CBQU1OAgh/YIkAg2//Ve8iwPSLc2HMetDVqEiBhyNoZzYByK8BDuUWNvKyVA5Wh7UHrwF9DoRWGTXFj7FrStcpNRLAfI9KV6QZZAD7Tv43ImwB4u1ps/8t/DX18bkwfENY6K1Mlmu+cmh5kEQL5eoqX9iC9owHllbCWA9QRnU2ZqAQwpRGUr1AWs7fG3g1Q98iPb3B5SjqmTu1MTOmZsJ20FpVpKRDqIKQ5OBvZemJd2Uuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7398.namprd11.prod.outlook.com (2603:10b6:8:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Wed, 4 Jun
 2025 01:52:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Wed, 4 Jun 2025
 01:52:57 +0000
Date: Tue, 3 Jun 2025 18:52:54 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <sameo@rivosinc.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <683fa6f622abb_1626e100e0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050>
 <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050>
 <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <5d8483bb-ceb7-4ef3-920c-d6286a7de85d@arm.com>
 <683f7b6fec30f_1626e100ab@dwillia2-xfh.jf.intel.com.notmuch>
 <53c7523b-5cf3-4047-831f-12e0422cdf5d@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53c7523b-5cf3-4047-831f-12e0422cdf5d@amd.com>
X-ClientProxiedBy: SJ0PR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:332::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 24001101-beb2-4b0e-c7c5-08dda30a8755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cGPU299tzZRExDhtxhAc7Ht4Dm0qcAZIKE7REM+x9M8onMOn3j0qrdPh/t4a?=
 =?us-ascii?Q?cAIBR9AEjKWqGoaE9tjYAwf8JZuCV1g0AdEQrHJK9Fh9uxOnQOIpH+kNEqHl?=
 =?us-ascii?Q?8huzlnmfoqryEWIk/UmeS+L7dvnTZi3BM8KUjuMwXKFW0IIglay2yjMemfgc?=
 =?us-ascii?Q?kjI1CZr7vTZ8J9kzqURjUmga1Gi3E1AnpSZnO8zci/mudUTcp9x+k1zbhkg9?=
 =?us-ascii?Q?MGqUnl7OHkZFgHV5sgtaIy7JMtPtY4vd0pEFPTCIvtfSs1tXEbKXILqq0kFQ?=
 =?us-ascii?Q?gcVzl8pEbvOWHbol2R4EfgvF35IM6UaiOlcSymE4kUt1jS4+HYFKuk+FxE+9?=
 =?us-ascii?Q?AudElHh2n18y4eRzNFS2EvyVYMzP2JqVP0/Mu6Np2cySDIT06PQwqNoM9zF2?=
 =?us-ascii?Q?LYqqkFZqc6ZzATKR+UhbMMq7Td7b/Ttpup0p3QNSyX4/oy6q3TW1DCJO4LRg?=
 =?us-ascii?Q?lcxpM8ROfB/nQQ3MZn6SNriE+Qoss0P71doaFcbyQ2YxVp9urjBU/8LoupAt?=
 =?us-ascii?Q?b1EBYep9ozMHt3acUwCtamyyww6zkHMnI8kKquKAiG2KBiKYK/OvyIx9b4v7?=
 =?us-ascii?Q?U/9VqqB/UWOHEZyNZNHnYPNPuQDePq++/TPt/wkvm/VBjhcZZUsyIq/nc9M7?=
 =?us-ascii?Q?+7OXSo60bgiH4w77VXYUGmcpGLTGo6EFJtmsKkBSqbpmYj7THPEIH8BoI820?=
 =?us-ascii?Q?KNoivB/OqOkcNy96ZQU+MzqaVk5b89bWdnKQYNSB0n17dbFAAwgmc5WWbRf8?=
 =?us-ascii?Q?rIsrzocNWnv82oCIzdNMmz8wcgpg+iV6SZ5bkwdERMIvENCTDmGtSNTEyvE1?=
 =?us-ascii?Q?76KxdkSc+BZ2ftwIvFzrIJe4ZkKEpXRTc1uN8O1LctGWmBgUkooQ/XgafI68?=
 =?us-ascii?Q?o7rcJ7E+hvSaFDHPPQ14JMoHdOKnIr6wvbNCbrV1oi8oHcAP5MV264qTdeLB?=
 =?us-ascii?Q?8I7uDtEauY5yA5fWCJXKDl3IlZ6vd4BQuQ62QZhfvylGSncfWESk5TXeLTK0?=
 =?us-ascii?Q?5CitCs9JLmvumeqVdq03F4RGS3vasuy5AVFDc/YD3xDqHn8IRdwZ/FJvcPZp?=
 =?us-ascii?Q?spHUIPhFIstN+23tCFzRBUqko6m5VPhE1/SVkLZmYTfxLjhwvZE/oW1PY7ND?=
 =?us-ascii?Q?HlucXWYOY/Ipas7Wz7nQMI9DZ67/7EyFa0rP+PNtjBr4MZXlQcrpPC/tqoFK?=
 =?us-ascii?Q?QqeXBY72BpBEJ0s7oatmbBzR73o+ktm9t0WkqaFOGwAwzQqenl4PJYPOay2j?=
 =?us-ascii?Q?BVLau/DXO1FaBSXl6BWfkLYgiaiqCVSr+MgIytCV3UPfLAv5Ym7cqxzC3aHB?=
 =?us-ascii?Q?1diIs95DrwZF1Hw4orsk9fhq59TV/W6RKf3AjvlNc4lWmhXKn9xB4RD4LfFw?=
 =?us-ascii?Q?o9h7fLyIZEG3vHShRCvmPs3vPZpz+zuiZTOCqrLOlL00E67lTbbvBT0IWLVG?=
 =?us-ascii?Q?zJr2q8H0cdQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+wko1Yvk/trUo8tPj3EXQ87miPX1E1HjZhUCWuLcOBtON+Pqu7v2poHL8Y21?=
 =?us-ascii?Q?lYa0Jgq+D+PGMUHXXhQrTIR/PTOFzCiav7pg0u/eOPAtiHWACEz0HSsDlSm3?=
 =?us-ascii?Q?GNrSNr0BKbeGPMjNvd4h/blS8caP6KJjKdywp5Fzj6270iRMEju81IYds55s?=
 =?us-ascii?Q?AFOnLMdBuxavnNq9J0lMXM02+G5aINrqllfxRW1x4S1EvBVMTdfuX0kYMiso?=
 =?us-ascii?Q?+BL3t5lsyckt1d0lCkH38oJ2fVbEUV5Nv1pT1KKX8r4WYcpMCiKbtUWp1sfT?=
 =?us-ascii?Q?51sucgnSEFFS531r0ijHy7Nli2+wAAVYsgA60kT5ZMiW74k2iAsayuwSO7j+?=
 =?us-ascii?Q?Xgp8OXSmbB3XS31CagtL3BfPR55t+zT+/f7wmZK7Woe8T0K0nfl+kZpoeEGT?=
 =?us-ascii?Q?eLzcGXjgXs3UaM6FHoai/sYTYvGtOGQ+cwc8M3TnA7YwKRdSjubh82KAxn53?=
 =?us-ascii?Q?OAchubzh2OmR/saLye7sUik1swJQGoMIvgRUq48vnqilQ5oJnasggsolJlih?=
 =?us-ascii?Q?3F2gpNGMNB9vXiHgbpQ962Uo1dOrYDgcUa4XyH8RGqFSE3I//nkT9CYLWxtC?=
 =?us-ascii?Q?KjjJ2WOk0TpQH5AAiwWZAo3F/DaJnmu0t8rq/m2x0b0Xi+IOjrycENm3zWs7?=
 =?us-ascii?Q?55tQnmpfZ0Gh39qpogPtIw+1kzIH+HPt+m05rdJbitY1JWi51vIZ0Glbw8Yv?=
 =?us-ascii?Q?zXChIe6aTb6IVRrtGwQwWCKPRVfe/oSfcifxv4OLgC0gBiacqEBiNjdhhEKA?=
 =?us-ascii?Q?D82mKYUkPgexCaa9WiOOtVllylQwFQYBiXaeTcKn67O3MNOQy45uGlQTTchD?=
 =?us-ascii?Q?p4JCiO7A/1EBT8tbLII8g3IPrFYjFwuW0XdPdo/nNTIFAam25e94o17e9gco?=
 =?us-ascii?Q?MkA8g70KLBOKl0PcvIAirVr0aUtruOITrEh5DOZSdO4tmApq7YecwT68HPHY?=
 =?us-ascii?Q?GcFRUHH8lEfrKKkAx5hdqkzZwVRCP+SPD1xNUoHcsIG2ZxuvWy9E5ply+Ck+?=
 =?us-ascii?Q?zRyafulr/acs+D8dzfBs+DZfOfJtMSsUQANxSZ5fCZgsvN2TiUkEhrRFpMpQ?=
 =?us-ascii?Q?DFxiTJBs6A1YubU7G3giJ8B2bKi0XvjLC+XywUWrIcaeCMyS4Jz08Ik64Qu5?=
 =?us-ascii?Q?iLxJQZY3ZtmEk8ckloKxcU2SWn8dmkoLMomf4F46LzTofiPejGVqe7gVDDgU?=
 =?us-ascii?Q?dSz+pn60peqc8EB34ef2rApZPvUDk4yqErCxwC6uNZT1GvLJkvhb3hMWTr2U?=
 =?us-ascii?Q?UBdhZWKE8KGfCHK+F8n6FKjaoLLNwHlqxHVdHBdbdGafBz7ufdBvFpsxWsx6?=
 =?us-ascii?Q?xzu4JxUF7l1+LZXtzD7NI1o9upASK46APBgy96QG749f3l2djQJx9Vx6/5gQ?=
 =?us-ascii?Q?LLyxAplo7ipz5Kb087/bB+bESc3SEzMhjPYr3HUK/5Ty2ZXqn1MkhSKtFR8f?=
 =?us-ascii?Q?K+1enSvv5Fxz8Jo+Y3HT8J7rdMYP6qULYgaXLx7KUrh25BopM+VSOukfIZqY?=
 =?us-ascii?Q?s2LeajOqb7GImjhWDLLhuIkaS9AJcP/QIqg57KdIZWCd1wM7M193K+1BHlVq?=
 =?us-ascii?Q?4/Y7qsGQbcOlgtFAhHRggjTBQvYB37Y22HbVLvsc4fLIn97KBPWhnq4rH1BB?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24001101-beb2-4b0e-c7c5-08dda30a8755
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 01:52:57.3926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNIhUsXKRqBmAdYTH9lBJYNRAZDh+2GpPFbrdtCAnVKRYoD+iPFhoIQeDVqRo63J1/XhIETqZd9YtPVbUrT9yi/TQSt+9B4jFGQy4l+kr20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7398
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 4/6/25 08:47, Dan Williams wrote:
> > Suzuki K Poulose wrote:
> > [..]
> >>> Ok, something like this? and iommufd will call tsm_bind()?
> >>
> >> Remember that there may be other devices, AMBA CHI based devices
> >> being assigned. Not sure if they pretend to be PCI or not.
> > 
> > I have been thinking about this especially with the relative ease of
> > creating samples/devsec/ given the existing Linux infrastructure
> > emulating PCI host bridges.
> > 
> > Why not require PCI emulation for non-PCI devices? The tipping point is
> > whether the relative maintenance burden of not needing to maintain
> > multi-bus Device Security infrastructure outweighs the complexity of
> > impedance matching those other buses to PCI.
> > 
> > Make "PCI" the lingua franca of Device Security.
> 
> This is how virtio started, and now it has to behave like a proper PCI
> device, i.e. use DMA API. Or ivshmem which maps memory as "PCI" (which
> it is not PCI but the guest does not know it) and is deprecated now.
> Not the best idea to enforce PCI from day1 imho.

VFIO is a Linux convention. PCIe TDISP is an industry standard protocol.
The goal here is not have platform leak "oh, but my bus is special"
details throughout the tree vs keep that limited to the PCIe bus adapter
drivers for these things that want to speak a TDISP-ish like language.

That said it is difficult to speak in the abstract and the proof needs
to be in demonstrating that "tipping point" I mention above has been reached.

As it is, we already have our hands full with the industry standard
mechanism for the foreseeable future.

