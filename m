Return-Path: <linux-pci+bounces-22393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C6AA4515E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 01:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A848189EAEB
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 00:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2337C611E;
	Wed, 26 Feb 2025 00:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8ZVk0kk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D014A8B
	for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 00:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740529328; cv=fail; b=PrHie+fGlk1oDAZASPRghN0zk6WPTpg6yV9uofjLJT9NUAfZ6f7+hVfTag1+nkv80mF/o1+uktZwanyC/5LJEQ5aJoXo3euiWM51jrF5J553RpPw/sYzSLDPamvp2iA+9bFXe81fDHiwuU5kPkzGabf/kb/2lFs0gECeHu0peXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740529328; c=relaxed/simple;
	bh=YIjBdfAXu9E3KYFKOHKY25hi3fZ2OWpGaLdOCqoepA0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OPvQOuqtNGiijfjj/UaBhEifz5rEZiGOaBopF3R/HqSyky0Ij65E3ebc0x3jyHsAIYX5aPZ0CQQwn8CINNqkEBoVbaS0hvOrGRFUJ12LEULi42XVAmerGRQ29evNKwHnbJ+jv08ZGXNH8EbB0xbXour5Dv88acg0mhS19Pd0m/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8ZVk0kk; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740529325; x=1772065325;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YIjBdfAXu9E3KYFKOHKY25hi3fZ2OWpGaLdOCqoepA0=;
  b=b8ZVk0kk2wlfDFQdphbG7MAjR5UyxLH6yt3HF+2mwINnUZNMMa0bD/TY
   W481nxBgu18uj+LX+FclsAGT/P3LLOiNaZ+z1Xc8tdPvyE4pp4Y0AGf25
   ghBSlWENipbmeeTm25ukUFbJQcQzXPCuqn9D3KmcY+Ifp28ibCxyOwUqC
   O4k6m5XEh1oQWcoqxXQzpd5/AfZfgYR8Nctu3koKZxWu4W5mJqAu/CmQw
   dR/1wkEMu5yHW439JcBv8DOovoKJ6rtdSaiCWsfY4IJthZpxGdHB58TOA
   VZyj+iQbz8pPdvJV2d7jo9UvzaMjiyCquCM2VSs0we51VcNi9WOTS2hTw
   Q==;
X-CSE-ConnectionGUID: wKcxuSnnTvqhJWUqqRWzTA==
X-CSE-MsgGUID: gLy5VZaGSCO/zdnBU/4Zvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="58898784"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="58898784"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 16:22:04 -0800
X-CSE-ConnectionGUID: a/+NYrMoRPeRaecqCnisAw==
X-CSE-MsgGUID: q5Iftz9mT9Wke6luW+4piw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116399247"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 16:22:04 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 16:22:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 25 Feb 2025 16:22:03 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 16:22:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7RrsIOfgfVMvHw2dgS4I/jcB/0J5i6I7XQo9TdnuWOTo35B1DaK8+y2wflR/XwkSSId21ELrlRjaEmbRJ/WSpl29ipCy28Ze/e2p/DyBGQKRZ2lU9l6gYXdhFrkqvPmuFQq82+0Xg6zxk9AVTpWLNOwNePIuK9cCYfZ+xZKb1mx6ZCGhlBtv2XzAFSt4sLiztBE+rwueUGwDJYZGNiBJKgLqbXU99aBZNrlIOw+6VJYrWFx4XEcIAK+jwBW+vGLhzXqxcK8Cp2OZDa/x5pRDxR/rlJs/O1jsnF7On7Pf3pc5d5xNIgbUw7uE8iuP6t018uHj/IIo64RWg1AAKqC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEx+PvKhdUHaI7uVyRFC7ICIwMK7x6sZSieb1MUC6Ik=;
 b=p5UA7Nb1+OLToH49c2/Zgj1nJKzGeAkSnBlaenOOF05QBjEm6ZG0xIMn13LPhDHSugng5oeevIrBweEZj89549HIChWX1FKZsLqiyG+Kp7Sg4x8yp7bPTcgrJpOVC+sXpSQPD2JXLFmd/OHDL+CHGlERlVPq9u6NvWajnWEINyqow1Iz8e0dlvz/eCtVJ4t1Ftcw1OrlvQQQU0WfsYF9m1YS6SnVWt1qa61aRixOf893FygiG8P2lxsEm0ft9V1G/iuCVXFoy8XnJ9rTVVtbawWQNz2tUr76tSIgzEz5Hx2wToKZdByz3q7+2UJlfeasDmyOurrS9idQFJuFl7E7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5211.namprd11.prod.outlook.com (2603:10b6:806:fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 00:22:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 00:22:01 +0000
Date: Tue, 25 Feb 2025 16:21:58 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Alexey Kardashevskiy <aik@amd.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Message-ID: <67be5ea65e96c_1a7729453@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
 <20250130104507.00004446@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250130104507.00004446@huawei.com>
X-ClientProxiedBy: MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 233d85d7-4c05-4831-6947-08dd55fb96a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?moSnzeSfOYApZarZngZ5pBTdifCgmpjzZQT821sxGkBliCauimkZ3e5Zt47A?=
 =?us-ascii?Q?bpQCaGIw4vm/OtI8bwHFc2D8sMrvh4JnW3XDD0Wl1AOFMwbuyhh4ebbr2bjj?=
 =?us-ascii?Q?ZskiEtlWlvzqJGFzOirrB1OGe9sdQqwCEW7cdosIq7lsdAKUby9U3SMmg4zg?=
 =?us-ascii?Q?acFkmWPd/uz+9wzav5puQSs8p/M/PTBCDWeH+FTZTqkumuI8SVR/t9aHizl/?=
 =?us-ascii?Q?BDFmCbM8cn4rutuT8gLqGLTRpftLJo1qIcqHUcZgcgUtWoGXrud1NIctLrOi?=
 =?us-ascii?Q?dPY5TobrV9F447rQsutDHrbVEtJes8PNyhIBdTCDTtSkB6rZQVZKm8q9nzX2?=
 =?us-ascii?Q?rRvG7IaSrj22tinwppbAkaSSjHX+FZuLDM+pvpDmtZNeluvCt66ZRNxh8BHz?=
 =?us-ascii?Q?6f+JpzccAuQ19agfR6po2QKbjJJJA933Kt4ZTAgErTr89x6fKoC0+aeBmP6O?=
 =?us-ascii?Q?NISKmM8ImKcdvMOB6bYPTsPOWe1U+OuioKYmOSub878zu2ga1QuTKdPyBY+p?=
 =?us-ascii?Q?x4I1NszpzlrU1cS05dbqS+09x8B1W1+4WL7a5MAzsUYwTSAi39H7WlNbOPZd?=
 =?us-ascii?Q?gzWCzKzWGdIulg+6Nas7WjM2myFtSxq2wawR25ih/0beq65dAP9Suk2iSLpN?=
 =?us-ascii?Q?EyaKAnkf0ZWTSESSkMrHinrmQoVRn3SpKSTuxVJubxdPYQFkWR2TYfVStG26?=
 =?us-ascii?Q?ixu5KDGKSSj31GWXyewGET6c4vglwnCVD93UMEkVFDeHomd6n4yJlChyo1gZ?=
 =?us-ascii?Q?QgpFYMOhmjKpLqDodDUg7vNjJhJhX57KuVvaIVAfYPBYyifJHCdp2UKxlefD?=
 =?us-ascii?Q?57vjhe91qfsuA4lKnr7gmazYYp69uJC94pEcTvE6HHt3znFbR0+/8GZ7Qh3I?=
 =?us-ascii?Q?Y2l3e37YDU9kNIJnmzPJSM3MFa3B7MtQB19dh2M0ps5aypSJlAiBcvvN267Q?=
 =?us-ascii?Q?mLTj94KLf57E3THx3sYavGI3md1NemIs42YQby9UeEOzYvhxMnfgKhTWRYeZ?=
 =?us-ascii?Q?AEbonkZiWq3OHYh2SeGYo2829stVFQm3azgNPkzSW7+8Rq18Xg0KVimwE7bR?=
 =?us-ascii?Q?J8cqdZDRTuON1eWoene9dfSAtQsXSUoFzuJCJUfYxRNIDe9EQ5iNpCNrPZqb?=
 =?us-ascii?Q?ZPx32Jclcef1un6x9+tQlgHJbt/MkZhwSd1sMH2m/X+h3vqNS4ofdOjxQJyu?=
 =?us-ascii?Q?L3hkPiMboizpVk5utE4g2D9YOfhnxg5gbtnRRPexTsquZrSO0YXUgaDurTQC?=
 =?us-ascii?Q?zyWCLfJ+/sGQt5yhcuOLZr/842ERTcxhtB+NLaGtuZns8/JrYc918iDeDQGn?=
 =?us-ascii?Q?fH/85i8TqV3i1J1pfPB7lkY1jUO8ktlfC9V419Tc97642g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8tcbTVA9dsSN6OKzJBMPPpDe532g4RK4VdVyAxELTaoGSwqkdeFipLkibVrv?=
 =?us-ascii?Q?CBpIbIaXbba705P1GsOS8myJYTOwNpC++6Eno8+rayHOey+IM5ymPra/jPJd?=
 =?us-ascii?Q?cv6zexsKNjjEPqR+5l5grr4ivTqJLTjMw1dzvMcCuGrIWtKiM3Iq4Qpv/8O2?=
 =?us-ascii?Q?XY8Y+mzX2ew/mKBhiMtFxAjtAECOleieXFSNSdpLui+FKGmkDNXO+vuur38+?=
 =?us-ascii?Q?jRqqd0lCLS51KY6RCJYDiI0u3GAMbNwlMvT40kK0JnUUBwz2CIFD9IXZkega?=
 =?us-ascii?Q?GsxlcBZiP+BVdKvAIyBIfOhtj5Txrt2eT++Hd0dRJjkxWONNInAEYVgrfmA8?=
 =?us-ascii?Q?uui+04PwbwXowEqpDXRKRQpfoH/iZt33GhCajniekITCtyoJcl0f0HWEPdsY?=
 =?us-ascii?Q?U2c4aCvyirvu4u+L20zDJPFA7B5/GlHf6HnVhmNbxBDOzF/qUBuW8v/6c4+m?=
 =?us-ascii?Q?S0QtZiN3p/L82XTcCWlyyeXzAeEXa5Bd7ahlOzyxDEtfOGBwPYzwNgsJgQUE?=
 =?us-ascii?Q?vQWnZ282bJjHZkgk7ddyV/Jczs5Wse5qTdwdLQi6+aPU5hyYDoZW3GeKD9Bq?=
 =?us-ascii?Q?/CCbptAPM/sax+Ru9E8YRJlwTIr5kR3bhezi044u89lPXi4/4XBGHd0+c0dX?=
 =?us-ascii?Q?sxMoG5xP7tUTdXLqBDPHcAWpAKF//TdFhOkGd+VwgtVkMlYX2rJrOWxjR8yF?=
 =?us-ascii?Q?YERzgFG470/CuPGfshdMVpZ2h5hWNmMJQLXBkRr3eTE4fDSB8ECxrvJqqwik?=
 =?us-ascii?Q?5/SLPIszT3V0Di7JVf7RBfs3WjlU6epCsi1HURhY8Dkb5MfwrVlaABx42ybf?=
 =?us-ascii?Q?K8IR7aygytYZULu44hIAD6xrgcyQr4/HZOqMVZrKA1JfxeM+SGj4z99/TabA?=
 =?us-ascii?Q?NLyYqQPz2UvsXJ/o0gAJbFKUhqx5xxLIpdNj3T2okhHW3AJp0nAwnYVkg8Zx?=
 =?us-ascii?Q?ukxJ5SJX5DngBpTx5yokNWx4vL8gY0pa9EcbtdUn2hy0TVuWKPp24+heq+iS?=
 =?us-ascii?Q?C3dGOxhouu5ZX4y7fbTYElQIyDz01C8B7gWv0M2WGUDj0hNuKTXoHTCnKDrY?=
 =?us-ascii?Q?AhLmeJoC9ZRBglB+sK14EWy6jGG1uU+UxFxlZU1jw/tOhQSqvkOAfM8v7D6O?=
 =?us-ascii?Q?PQNY6uIn3jESo66R9Y/TrpErqR3oEk1ZFSyOH4SZf8bP8i1AaZFPr3qPKV3T?=
 =?us-ascii?Q?8dqTCZFCeKP4xSAw2ztjdADFV015ACj8NqCscZkp0Hg/++8SEpTrFKN9OCnI?=
 =?us-ascii?Q?ZXAVxTbmGdPkwzCdQJ/yikb8M5KWNrTv0yWgxCaWj+m7S88w+qRgaaRV4wIR?=
 =?us-ascii?Q?zhPeYjHFHWAyUiMXxh9RW4B80ScLrwf9yy5SmonNeSuFXXAQMz6PtuUcjWh+?=
 =?us-ascii?Q?u50BD4NNj+QLcvG6BhhkFplkGFFRm93cgz8C6kt4//po/pBNcPwsQ6eDqkcH?=
 =?us-ascii?Q?a6oIy8gpXWuAPV6cVdm1oWcmNT2Pzk+RTkJihyEfuY+6hT0C9g8OnFiq66fw?=
 =?us-ascii?Q?LSKX1YjiISr4R2Pg8tM05BsUnCt79wisJYyw/hkaTssMG/38Rezwwf078o3r?=
 =?us-ascii?Q?0OQMN7JOE5mKYiqMcCp2ZR76feThR0kJRn4FxrFmgPqVABAxQBRF2SUSQqBv?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 233d85d7-4c05-4831-6947-08dd55fb96a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 00:22:01.0468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeTtZ4LWPPGfYmegtzZXfqczQMoAYkS9D+gXzxudMOzmV+jL/k97ngL66vdEkPsBrG9Ten56AFXISAqB0PHbuyC04eUi5FfgaK9EKdGc5VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5211
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 05 Dec 2024 14:23:39 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Link encryption is a new PCIe capability defined by "PCIe 6.2 section
> > 6.33 Integrity & Data Encryption (IDE)". While it is a standalone port
> > and endpoint capability, it is also a building block for device security
> > defined by "PCIe 6.2 section 11 TEE Device Interface Security Protocol
> > (TDISP)". That protocol coordinates device security setup between the
> > platform TSM (TEE Security Manager) and device DSM (Device Security
> > Manager). While the platform TSM can allocate resources like stream-ids
> > and manage keys, it still requires system software to manage the IDE
> > capability register block.
> > 
> > Add register definitions and basic enumeration for a "selective-stream"
> > IDE capability, a follow on change will select the new CONFIG_PCI_IDE
> > symbol. Note that while the IDE specifications defines both a
> > point-to-point "Link" stream and a root-port-to-endpoint "Selective"
> > stream, only "Selective" is considered for now for platform TSM
> > coordination.
> > 
> > Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Some overlap in here with other reviews probably...
> 
> Jonathan
> 
> > ---
> >  drivers/pci/Kconfig           |    3 +
> >  drivers/pci/Makefile          |    1 
> >  drivers/pci/ide.c             |   73 ++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h             |    6 +++
> >  drivers/pci/probe.c           |    1 
> >  include/linux/pci.h           |    5 ++
> >  include/uapi/linux/pci_regs.h |   84 +++++++++++++++++++++++++++++++++++++++++
> >  7 files changed, 172 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/pci/ide.c
> > 
[..]
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > new file mode 100644
> > index 000000000000..a0c09d9e0b75
> > --- /dev/null
> > +++ b/drivers/pci/ide.c
> > @@ -0,0 +1,73 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > +
> > +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> > +
> > +#define dev_fmt(fmt) "PCI/IDE: " fmt
> > +#include <linux/pci.h>
> > +#include "pci.h"
> > +
> > +static int sel_ide_offset(u16 cap, int stream_id, int nr_ide_mem)
> > +{
> > +	return cap + stream_id * PCI_IDE_SELECTIVE_BLOCK_SIZE(nr_ide_mem);
> 
> I'd be tempted to have a define to go from base of the IDE extended cap
> directly to the sel_ide_offset rather than this use of a block based
> offset.  Maybe it ends up too complex though.

Considering other feedback below, I will make this change.


> > +}
> > +
> > +void pci_ide_init(struct pci_dev *pdev)
> > +{
> > +	u16 ide_cap, sel_ide_cap;
> > +	int nr_ide_mem = 0;
> > +	u32 val = 0;
> > +
> > +	if (!pci_is_pcie(pdev))
> > +		return;
> > +
> > +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> > +	if (!ide_cap)
> > +		return;
> > +
> > +	/*
> > +	 * Check for selective stream capability from endpoint to root-port, and
> > +	 * require consistent number of address association blocks
> 
> on the EP.
> (for avoidance of confusion).
> 
> Also, from here just seems to mean at the RP and the EP.  Not seting a bus
> walk here to check anything else.  Note I'm not sure we need to but this
> comment is implying a 'from/to' aspect that this code doesn't seem to check.

The from/to aspect is that the ide_cap of endpoints is ignored if the
device's root-port does not have IDE capability.

I will move the comment next to the "if (!rp->ide_cap)" check to make
this clearer.

> > +	 */
> > +	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
> > +	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
> > +		return;
> > +
> > +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
> > +		struct pci_dev *rp = pcie_find_root_port(pdev);
> > +
> > +		if (!rp->ide_cap)
> > +			return;
> > +	}
> > +
> > +	if (val & PCI_IDE_CAP_LINK)
> > +		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM +
> > +			      (PCI_IDE_CAP_LINK_TC_NUM(val) + 1) *
> > +				      PCI_IDE_LINK_BLOCK_SIZE;
> > +	else
> > +		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM;
> Maybe cleaner as
> 	int link_tc_count = 0;
> 	if (val & PCI_IDE_CAP_LINK)
> 		//see suggestion in header to make macro include +1.
> 		link_tc_count = PCI_IDE_CAP_LINK_TC_NUM(val) + 1;
> 
> 	sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM +
> 		      link_tc_count * PCI_IDE_LINK_BLOCK_SIZE;
> I'm not that bothered either way. Just didn't like that
> ide_cap + PIC_IDE_LINK_STREAM is in both legs.

Makes sense, fixed.

> Or have a macro that always gets you to the selective part without
> using a zero length PCI_IDE_LINK_STREAM block.

Unless it gets multiple use I would open code it in ide.c.

> > +
> > +	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val); i++) {
> > +		if (i == 0) {
> > +			pci_read_config_dword(pdev, sel_ide_cap, &val);
> > +			nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val);
> 
> Yank out and index from 1 for the loop?
> Note though that PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val) of 1
> means 2 streams so you want <= or just +1 in the macro so the PCI
> header gets to deal with that!

In other review feedback the discussion settled on only shipping offset + masks
in include/uapi/linux/pci_regs.h [1], and put any other logic related to
bitfield.h in ide.c.

[1]: http://lore.kernel.org/67b91d86a48aa_1c530f29431@dwillia2-xfh.jf.intel.com.notmuch


[..]
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index db9b47ce3eef..50811b7655dd 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -530,6 +530,11 @@ struct pci_dev {
> >  #endif
> >  #ifdef CONFIG_PCI_NPEM
> >  	struct npem	*npem;		/* Native PCIe Enclosure Management */
> > +#endif
> > +#ifdef CONFIG_PCI_IDE
> > +	u16		ide_cap;	/* Link Integrity & Data Encryption */
> > +	u16		sel_ide_cap;	/* - Selective Stream register block */
> 
> I'd not call it cap as people will go looking for a selective IDE extended capability.
> I'm a little dubious about it being necessary vs a helper function that grabs
> the necessary count info directly from the device.

I was trying to avoid extra config cycles in the common case, but there
is no precedent for caching extra offsets in 'struct pci_dev'.

I am ok to drop sel_ide_cap.

> 
> > +	int		nr_ide_mem;	/* - Address range limits for streams */
> >  #endif
> >  	u16		acs_cap;	/* ACS Capability offset */
> >  	u8		supported_speeds; /* Supported Link Speeds Vector */
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index 1601c7ed5fab..9635b27d2485 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -748,7 +748,8 @@
> >  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
> >  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
> >  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> > -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> > +#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
> > +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
> >  
> >  #define PCI_EXT_CAP_DSN_SIZEOF	12
> >  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> > @@ -1213,4 +1214,85 @@
> >  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
> >  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> >  
> > +/* Integrity and Data Encryption Extended Capability */
> > +#define PCI_IDE_CAP			0x4
> > +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> > +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
> > +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
> > +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
> > +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
> > +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
> > +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
> 
> Looks like 3.2 has a bit 7 defined as well.  Selective IDE for configuration requests supported.
> Probably worth adding that.

Might as well.

> 
> > +#define  PCI_IDE_CAP_ALG(x)		(((x) >> 8) & 0x1f) /* Supported Algorithms */
> > +#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> > +#define  PCI_IDE_CAP_LINK_TC_NUM(x)	(((x) >> 13) & 0x7) /* Link IDE TCs */
> Maybe add 1 here as the macro name kind of implies it is returning the number of link IDE TCs
> rather than 1 less that that. It is a little tricky given the spec calls this field "Number of"
> 
> > +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Selective IDE Streams */
> 
> Similar here. I'm not sure what precedence we have int his file. I can't immediately see any
> either way. 
> 
> > +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_MASK	0xff0000
> Why have the mask if you are providing the macro above to get the value?

A mix of copying from the SEV-TIO vs TDX Connect RFCs. Per other
feedback, I have now resolved to only defines masks and offsets and drop
the decorated helpers that are open coding bitmask.h.

It turns out that __GENMASK is available in uapi/linux/bits.h, so I will
switch to that.

> > +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
> > +#define PCI_IDE_CTL			0x8
> > +#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4	/* Flow-Through IDE Stream Enabled */
> > +#define PCI_IDE_LINK_STREAM		0xc
> I couldn't find specific precedence for this but my gut would say add a _0 postfix
> to indicate it's the first of a number of these.
> All the similar cases seem to explicitly enumerate _0, _1 etc which makes little
> sense here.
> 
> > +#define PCI_IDE_LINK_BLOCK_SIZE		8
> > +/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
> > +/* Link IDE Stream Control Register */
> I'd expect a _0 define for the first ctrl and one for the first status.
> 
> Then index each register via
> PCI_IDE_LINK_CTL_0 + i * PCIE_IDE_LINK_BLOCK_SIZE
> PCI_IDE_LINK_STS_0 + i * PCIE_IDE_LINK_BLOCK_SIZE
> 
> Again, not immediately seeing precedence, but having register field defines without
> a register address define (even a constructed one as will be relevant
> for the selective IDE stream blocks) seems odd to me.

I will add the _0, but skip the rest for now. There is no precedence I
can see for the amount of degrees of freedom in this IDE register block for
the location of the selective registers, and Linux does not currently
have a use case for Link IDE. I imagine any Link Register Block walking
will live in ide.c. I.e. given Selective Stream block offset calculation
lives in ide.c might as well do the same for Link IDE when/if needed.

> 
> > +#define  PCI_IDE_LINK_CTL_EN		 0x1	/* Link IDE Stream Enable */
> > +#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
> > +#define  PCI_IDE_LINK_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
> > +#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> > +#define  PCI_IDE_LINK_CTL_PCRC_EN	 0x100	/* PCRC Enable */
> > +#define  PCI_IDE_LINK_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
> > +#define  PCI_IDE_LINK_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
> Perhaps nice to throw in a reference to the supported algs list above.

Ok

> 
> > +#define  PCI_IDE_LINK_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
> > +#define  PCI_IDE_LINK_CTL_ID(x)		 (((x) >> 24) & 0xff) /* Stream ID */
> > +#define  PCI_IDE_LINK_CTL_ID_MASK	 0xff000000
> > +
> > +
> > +/* Link IDE Stream Status Register */
> > +#define  PCI_IDE_LINK_STS_STATUS(x)	((x) & 0xf) /* Link IDE Stream State */
> > +#define  PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
> 
> 
> I'd put some white space here.

Ok

> 
> > +/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
> > +#define PCI_IDE_SELECTIVE_BLOCK_SIZE(x)  (20 + 12 * (x))
> 
> Probably want a better name than 'x' for that parameter as it's not
> immediately obvious what it is. (number of IDE address association
> register blocks).
> Also that 12 probably wants a define. It's used a few times.

Ok

> 
> > +/* Selective IDE Stream Capability Register */
> > +#define  PCI_IDE_SEL_CAP		 0
> > +#define  PCI_IDE_SEL_CAP_ASSOC_NUM(x)	 ((x) & 0xf) /* Address Association Register Blocks Number */
> > +#define  PCI_IDE_SEL_CAP_ASSOC_MASK	 0xf
> 
> If the mask make sense to keep at all would be good to build
> the macro above using it.

Dropped the macro, kept the mask.

> 
> > +/* Selective IDE Stream Control Register */
> > +#define  PCI_IDE_SEL_CTL		 4
> > +#define   PCI_IDE_SEL_CTL_EN		 0x1	/* Selective IDE Stream Enable */
> > +#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
> > +#define   PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
> > +#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> > +#define   PCI_IDE_SEL_CTL_PCRC_EN	 0x100	/* PCRC Enable */
> > +#define   PCI_IDE_SEL_CTL_CFG_EN	 0x200	/* Selective IDE for Configuration Requests */
> > +#define   PCI_IDE_SEL_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
> This is a control register. Seems likely we'll mostly be writing these.
> So how useful is it to provide just a read macro?
> Maybe I'm missing something!

I agree and this matches other feedback prompting the "masks only"
stance.


> > +#define   PCI_IDE_SEL_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
> > +#define   PCI_IDE_SEL_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
> > +#define   PCI_IDE_SEL_CTL_DEFAULT	 0x400000 /* Default Stream */
> > +#define   PCI_IDE_SEL_CTL_TEE_LIMITED	 (1 << 23) /* TEE-Limited Stream */
> 
> Why this one as a shift and all the rest as explicit hex values?

Fixed.

> 
> > +#define   PCI_IDE_SEL_CTL_ID_MASK	 0xff000000
> > +#define   PCI_IDE_SEL_CTL_ID_MAX	 255
> > +/* Selective IDE Stream Status Register */
> > +#define  PCI_IDE_SEL_STS		 8
> > +#define   PCI_IDE_SEL_STS_STATUS(x)	((x) & 0xf) /* Selective IDE Stream State */
> > +#define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
> > +/* IDE RID Association Register 1 */
> > +#define  PCI_IDE_SEL_RID_1		 12
> > +#define   PCI_IDE_SEL_RID_1_LIMIT_MASK	 0xffff00
> > +/* IDE RID Association Register 2 */
> > +#define  PCI_IDE_SEL_RID_2		 16
> > +#define   PCI_IDE_SEL_RID_2_VALID	 0x1
> > +#define   PCI_IDE_SEL_RID_2_BASE_MASK	 0x00ffff00
> 
> Why leading zeros on this one?

Fixed.

> 
> > +#define   PCI_IDE_SEL_RID_2_SEG_MASK	 0xff000000
> > +/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
> > +#define  PCI_IDE_SEL_ADDR_1(x)		     (20 + (x) * 12)
> > +#define   PCI_IDE_SEL_ADDR_1_VALID	     0x1
> > +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK   0x000fff0
> 
> more leading zeros which doesn't seem consistent. Also, as Alexey
> pointed out value is wrong as that's 4 bits in not 8.
> 
> 
> > +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT  20
> 8?

This was defining how much to shift the lower 32-bits of an address to
feed this value. Moved all that detail to ide.c

> 
> > +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK  0xfff0000
> > +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT 20
> Also missing a zero (Alexey got this one as well I see)

Got it, thanks for going through all that!

