Return-Path: <linux-pci+bounces-22841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6291DA4E067
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120AF1660E2
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 14:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4A9204C2C;
	Tue,  4 Mar 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YktOHWf6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C684204C1A;
	Tue,  4 Mar 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097605; cv=fail; b=sSa2yNQ/JWj1eho+gI72AFXDrOOEpRGDcol+cwvTQa03JEUv493tghV3PPqk/yBdg5aEftMf4BXKKAits/c2A0T7JElJagIu0RUELhXUSgP9RH3EP+Gkdtn4YwBdlWbUhMkkPGsQ2irpC6KwFBRz8F9IzoTsKR2hzO16xXJHGzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097605; c=relaxed/simple;
	bh=gH6ma6kjwrCwPK9mtXlJXctp/p22Ntg0nL1LT16U9Ps=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DQi5JsT2iDcTgn+aBOq4faIKN6vsyVDnFnG+rsKkwvEx766Lm+Hj3A5hSzrNwFzI2jMrTPzUUd9cHSHCNK1gGnXvzosb9RtCCmu9ZPHcpIe6iN+t4n1SHmGJ+M0j2BNiCz4j3Co0prHgoObaiIW51nP8EEcbbVMmVIFZgk1ZD1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YktOHWf6; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741097604; x=1772633604;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=gH6ma6kjwrCwPK9mtXlJXctp/p22Ntg0nL1LT16U9Ps=;
  b=YktOHWf6oF2SQm3gvp6rIgT6ksYBUh3o604qivGo6SlgoKmGGNgZS7o9
   IfqHoeU8rTPeBGYwytKykK5kaWFDyj9+bhHhIMt7n8kBTp2qnZhBsSFSX
   a3SrTAKphqEW8lVnZ2YFZjRj9ieeLZODnu6snFzqt9lwXJ6MKywFwqX0K
   5ENP+S3Z72ZjmOuM5knT4bk5Qa8nsNU50nnVmvsjGDMkgFIwlNSrnir5R
   /Z4tuX/LnOhsUHi9PW1gYJtJGr0jLNfKZ9EZRdKKwmKHvLAjT2icOidGS
   wUjaX3dlmwbC3FprX6CWu5aYrQHsyeR8d8UlCi2URzZQbA8ZaECT2jAk2
   Q==;
X-CSE-ConnectionGUID: U4buRPJdSwGsMH5AV8TEIA==
X-CSE-MsgGUID: AsX/ZfRyThOtH5WBzZE5ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29604702"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="29604702"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:13:23 -0800
X-CSE-ConnectionGUID: z29VIbqTS+uNM/gQg/YGpw==
X-CSE-MsgGUID: Nnhx4zE0Sl2137ZNcrNUIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="155573375"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:13:24 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 06:13:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 06:13:22 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 06:13:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQ7dH5Ref9Zrhi6fdIGMcD3Rv24MDn3IxxP9/xO+DmI+ALzEstGX0tmOgNM9KpY/ThK9XbgZz42gonBIOQYF380XMwSrrMzMwlCMGAT6j/GkeVM92Q149Ec2zd+T/Snmk1aWkzoqAySX55m+jHvTNdrNVXu/UMJ0FwV+65Nb0xXfkFo6zN4qfBeU9XHIYN1JbuccP12OWw0AKaDFOGmSXVr0zLyFUswNb07f/Kn80y0kRO4jRh9EvgfHuh0xd6g+qTMRY4bvhF8Ahr/aOfpcoV7K/76eOJwEX+T609851gh49DMWJOw9riTS7e2TPKw3yLu1pskhFCLk8+jfiKt8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2AVQ3GtMc9SO7/qWkg8fTgQbPvZfGselQ2W+pPSJik=;
 b=v2jxeI59me7+CKe7tZwcDx3N36y2HwHVyLGms9aXP7PAUyBBj2GvU7kG2ZXLTM4c78bm07sLbD5GD6XX6wnYyY+ZwgqheaKtIlplDFr+C4soodIF4khN3ahYcVlwh0O2QPOtG3h2DVfqQeRRlODCDwkjnVuy4xln0C4+fIA4S3zd1RZB3jp5d+C9JwpvpHYEsMXIQawr4EbTlD9HTpEUB1bfHboeljlUXkTIdftDOyTcYoRSR+K6pNTy1VqsJqX794JJgIytdoW8jroQ9E3N6YyLwctUhsw2By7PAbYd8k7XbEbfMu7gdVhgAu1Vo9RcmThtXYPUx65AEUAXDXgTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Tue, 4 Mar
 2025 14:12:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 14:12:58 +0000
Date: Tue, 4 Mar 2025 22:12:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>, Christian
 =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, Ilpo
 =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/2] PCI: Avoid pointless capability searches
Message-ID: <202503042124.7627f722-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250215000301.175097-2-helgaas@kernel.org>
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: ba68c748-d274-498f-5990-08dd5b26aa8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fnZqqfaSkJKC9iRO+bASDQLXGzVhCM+PDE+pFLA8Xa7T7/tu6vIWbYIR2b4n?=
 =?us-ascii?Q?HgrHk1+/wyUnWZE+TzuX0Zku/z2U5wy5gcWjAVYyKiK4CtyY2C2OGYdn8Kwm?=
 =?us-ascii?Q?aqkld6OxqOMGf4E9FCIAPddBGSue/bwFcMZ0FGnRLM1uO0qGQrnsDFc+gbko?=
 =?us-ascii?Q?yPBkrvZLJ6Y0s7nGRhTUXFpai36coxHPcBMo4HhEEqQ1aN7aTTXjizy1uOD4?=
 =?us-ascii?Q?n1/fW9JbCvjXxO5bDQ06vQjTfttfIZy7YVBPB5oyx+00Ww8fsm43dBKnDquw?=
 =?us-ascii?Q?pAVehbXPp9P9bwodSZhi4ToDSC4QPB88YRlyxKyYFKb3tn7idi1b/Fdvygg5?=
 =?us-ascii?Q?Eu63wF2pCT0WIK6ybVSGRQ65R6mUTJW9lyPb5GenX7F8QJInNu+WTREJMo82?=
 =?us-ascii?Q?8kHNnHrMR+k0HnZrOUAsWWEd+hbFn6BByRDstCg9aSInehHjPlVr1O3CJZlG?=
 =?us-ascii?Q?kk4n6I8HrzP4itIWcUtzBZ400eChUgOM97YC/d+fr3ZVHGoOeqgUZKeL/2kX?=
 =?us-ascii?Q?plFT7WV9Ru5ThO2vt1pzv6hDZnTikn6VBYP80bIliRYvIzQNCBWqA9KxcC4m?=
 =?us-ascii?Q?m2/BIEMP3ZaAp6/X/MCl/n5mihDkoavpEK6IUR2apNpXh2xHngITbXsLP4Yz?=
 =?us-ascii?Q?WyC7EIrjXsdzDEEBLCsb+5UK3YiKMf5RLdIoOHhRcfaCxBeK4vIFiefDFpaj?=
 =?us-ascii?Q?AxJjA81JtDcjOxBHxpb1GaINflkRJ64zABTt8fz1SxA0ogSwqcYnyhdHUO3n?=
 =?us-ascii?Q?KqzvXnnrS/tqtMST3WTrhPj7bJLCc6t2CnutpQH13ntnmBN6fYzqfzg+FkM2?=
 =?us-ascii?Q?SwBvw7pMgdOtILc98NPHaFKVZ5j8t2JlZ+TNYKVpvwSdG7QQZCh2ETkvUBw7?=
 =?us-ascii?Q?oqzqcHIFo3C0jAi4qKM/JChw/Mch121bl1IAgNczdXc0aPEuOANcHiueb4Mu?=
 =?us-ascii?Q?f601q6Zjgahy8CEgJdTxW/Fub4upgiNAhcCv5qh5xISfUdZV/2otWem5iBap?=
 =?us-ascii?Q?m9QaqqO1m4d0F5Nz9L/xweALqwyqP79NrImfmMoHvt4yWXZ5jIzio1x6QBXV?=
 =?us-ascii?Q?i+jzjnqUvY+VoQALrU48GYdHFh76EXtTKdzTMUiq0jTHyMlGbYPt/UZ9yufw?=
 =?us-ascii?Q?aR+jIiZmajDbLvkJ1AZenXIKRxRyaQnEwTcUJOop9ju45KyUpA29zuf8NVjW?=
 =?us-ascii?Q?wLbXbqVxIj1XoaOHyz++NilA6wCXXLmUkJ5H9x5Pva+QoWiZH+reF/1xnydS?=
 =?us-ascii?Q?ksYsZY9PPsSDSNodZg4YuIWcowotr9t94izawSwQopXJ58OgP2RSpYXKjDrH?=
 =?us-ascii?Q?nUs/yfp1xVANgBM7yJpApMBaYM6We3uhDqOqyQg9Kc2oAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xpk4ED037SVEiZ+BuR7pq+FYZ2tDOH9Z5dK3hFceEw9+TUWyjxlIXdNMKqhY?=
 =?us-ascii?Q?FwKZQmGLEdwPI0+IC2YODjNfOAIbTXHdiLZhm1h5LZQFwtAHwiZyuF3hRewg?=
 =?us-ascii?Q?dLgE83sUsApj1SaKmLNCK5U8vaKwxU3W4406y3RAsZMvV8QWipi0AZMroda2?=
 =?us-ascii?Q?Pgusb9vq61WqDzGU29TsDn2qWPfUTqZLkGdFzIVixjrgEElkOW/GHWCA8gEQ?=
 =?us-ascii?Q?WkczSj4RyoQldZ+JQ4WYBjEX4No6ejJ4+2UfSKPF0Nk8OhSSbdsKva7nXxGh?=
 =?us-ascii?Q?6i0mOiEm4UpUpfojBaP0nSzQ3jcQmz/dMDnr/UNg4AKwMwQHEXAtIV9jbVtn?=
 =?us-ascii?Q?vH3Ijgmkg+89ugQ2ibzcQ66nCYJDwiOXo2uobeYJCF8ZQDLPl925kLJBBVbc?=
 =?us-ascii?Q?FI9BcK79LNd08FcXGxdhtn6Ya5DY2PTAaub/32a9buQ3bFvV0r+H8dSFUf82?=
 =?us-ascii?Q?uTOCdZLhJ8fW3QRdODp79ohaLZGZU31CbJKqUvGj7VjSEYyXBiH/sQYUPRHv?=
 =?us-ascii?Q?6du2WIbO7vnGcoWT7OQAj8k33NJDMvgbsY+JkxmKYFjjC1KwyTAGQTXcHEU4?=
 =?us-ascii?Q?m4Ej2bXONEhl+xaGYlAiRvM3ihqQBMULY86j1UKYcuUoCYUAKsfxmMkwA4+V?=
 =?us-ascii?Q?LohpjAO9xbFjvHgntg5WKeJN3qTb18G8E5pc/WRrvgnuEwcPs1rxoo5SeVGT?=
 =?us-ascii?Q?2WXarIMysm0cG51WJMhUZwQAM+5e+3AmoLBOfmbSOSBBYG5eTWUHLykWHkZa?=
 =?us-ascii?Q?RWDLaPVwD8EqtlW9nQ9TboHj/qqApN18D72nvclXXmvpN7jsTPFXpcNim1fS?=
 =?us-ascii?Q?Gs6QjGW4fr70obam9+0Rty8Y3ubwTTD4GFb9T95nOpVlplZdhTIY/iQCgjHl?=
 =?us-ascii?Q?GL3Trrft7xNfEXyb91NAtgRqXmLODV22zFYnibxxobIml2XGLWIHOkU4WBfZ?=
 =?us-ascii?Q?tcqVpwlm+8qlFgVXGUPS7Vvp3707hRQQ58vQnGQDavYtJwTuh6Fz5lKIJAOH?=
 =?us-ascii?Q?kn6f+670MZAXfMPvVMpePRKcSiS2Uaj6pDfbb1MXbQX/u0s3fDixthYEhdtc?=
 =?us-ascii?Q?6nC9zNtdNoWecZMJPF1QB8cmDupxHwJMhBDZqW8L/eqDffF/EkOdpL9nd2yL?=
 =?us-ascii?Q?KHEWhczPIS1jKqvAlWQYJvfEx7lNIIqdeBgrwBpxX/0o35m837gDJHp9/qzx?=
 =?us-ascii?Q?9Ry2IaVl9MC40qOCJpJOYxmS9zpDrUqB0Tm4Tzum+fnGyhSZrECAfmNBLwZe?=
 =?us-ascii?Q?9caISFCLCAvovK+S3E17KcLOobdGF2d0ediAA7q2Cl0ajqxBARciU7OukmIj?=
 =?us-ascii?Q?Zx3vj6/VP9iThpbc99+ieAvaysog4i1x2tSAuQHFAMvJvHymk+gtRkbD2Lcr?=
 =?us-ascii?Q?XYJ+ZmfxKNZUZ24v9pDLvv12WIFKAH3elATwxr0vHTvkjuSeMpF2HwD2kkNK?=
 =?us-ascii?Q?HywhMuXMbuQnUktpDSp34j73XLUsMlDe6cjWSVWHxX5vEJaSMcvH8MCMWCBr?=
 =?us-ascii?Q?7Ne+Wk8vPENwfsiuixxvIETx13ZF3rc5cgLNFIlx9VoIEBWiONOPqcYx9ZHr?=
 =?us-ascii?Q?uhlzE22XjNAPG8QPsVrcuyZA+VPpzYeiUq9R7TRgkgD7OmuF/aBmCpHdEroc?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba68c748-d274-498f-5990-08dd5b26aa8c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:12:58.6191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViAIKxzkMSQD6gMGdKYMDSdlTfLFrAjn8RuLiH8FpkDRr1oVJbay6mAcwyqSDXTPQYEVwfqH12d8SoSOPVSp1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "last_state.booting" on:

commit: c8a9382e172ac80bc96820b3ec758e35cdc05c06 ("[PATCH v2 1/2] PCI: Avoid pointless capability searches")
url: https://github.com/intel-lab-lkp/linux/commits/Bjorn-Helgaas/PCI-Avoid-pointless-capability-searches/20250215-080525
base: https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git next
patch link: https://lore.kernel.org/all/20250215000301.175097-2-helgaas@kernel.org/
patch subject: [PATCH v2 1/2] PCI: Avoid pointless capability searches

in testcase: xfstests
version: xfstests-x86_64-8467552f-1_20241215
with following parameters:

	disk: 4HDD
	fs: ext2
	test: generic-holetest



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503042124.7627f722-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250304/202503042124.7627f722-lkp@intel.com



[   62.784123][  T284] LKP: waiting for network...
[   62.784128][  T284] 
[   63.218408][  T284] ls /sys/class/net
[   63.218417][  T284] 
[   63.224484][  T284] lo
[   63.224490][  T284] 
[   64.076175][    T1] watchdog: watchdog0: watchdog did not stop!
[   64.157917][    T1] watchdog: watchdog0: watchdog did not stop!
[   64.196710][    T1] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[   64.202659][    T1] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   64.969888][    T1] pcieport 0000:00:01.0: VC0 negotiation stuck pending
[   64.977342][    T1] ACPI: PM: Preparing to enter system sleep state S5
[   64.986446][    T1] kvm: exiting hardware virtualization
reboot: Restarting system


there is no more useful information, seems our test machine just reboot here.
this is not observed on the parent commit, c71f7bbc5d794, which chosen as the
base by bot.

* a234e07a63859 (linux-review/Bjorn-Helgaas/PCI-Avoid-pointless-capability-searches/20250215-080525) PCI: Cache offset of Resizable BAR capability
* c8a9382e172ac PCI: Avoid pointless capability searches
*   c71f7bbc5d794 Merge branch 'pci/endpoint'

c71f7bbc5d794984 c8a9382e172ac80bc96820b3ec7
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     last_state.booting


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


