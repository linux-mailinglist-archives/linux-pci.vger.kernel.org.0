Return-Path: <linux-pci+bounces-28139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CFCABE48C
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 22:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01647188C85B
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26059286407;
	Tue, 20 May 2025 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvTpAulK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483722853E8
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747771942; cv=fail; b=ns0BxKP/XM9LxhfOauuoF1uNus3Szo9y3bvfBuOsos6Mepm5ho3HmiuZSElFljo2Bw2hpScex/x9KpuoTKnIPCuiErHRhIoKRmUWM6U3zkJNPcm9jhuDd88PfUsQVJtn/eY7KOR2sHp+UQkybYtjTvKgxtGCOX9Sn+Jf+n5vat4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747771942; c=relaxed/simple;
	bh=9iMtg8xKUdkecN56EhK80fD9vfafJm6sYaZV1yi75N0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g+EsoHeZHghxH3+Igfshdb1BGn/hmftOtxBB6yiQF+I3sucqj/+kOYnZswfTJ4DkVuU4AVfqTC2pzyBlV34AWc+k4DDonepZPx7tkW2Ln6Q4RM/7ur8czFNS0OYoSifnE0UgJyRafbZkBw9yoTNyanRLNVTuBfT3iywcbVTU3+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvTpAulK; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747771940; x=1779307940;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9iMtg8xKUdkecN56EhK80fD9vfafJm6sYaZV1yi75N0=;
  b=PvTpAulK41vZfxeO5mO1oNM5tjk88WPoE2o1Mbw8hFojIXbOkfWITiml
   rNNsFPsDZH78ec4vKOUvqr+ljRClhzkDwEjrS7SjoJuX3gtxO+j+D/hfN
   UBWAlBAmXLPJyrcNyMXPgExzkvfF608d3JsF+KJcmSXIBHil55ieVPu75
   ORRZh/DttuJXQtyesIsBTrweXpeqTozOUzFcuHDubRrIH3BGGIncYipCd
   Jy15PxGhuIOrz1bXdb7l5WZKGKPTEYg5y0ejGUzqNxGhhW5x6QzespPA8
   OLH2mjsuoicPtSYWa6CBPM3ENJVwYKa19q9bS9IgLZoGPRxfsmxHwBMn3
   g==;
X-CSE-ConnectionGUID: nevcAOCpQi2edKa4Ovu1sg==
X-CSE-MsgGUID: do1C+YHiR0ObdU08XjxwHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49859691"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49859691"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 13:12:19 -0700
X-CSE-ConnectionGUID: mKAEuAT+SomFHrl5dN0tIA==
X-CSE-MsgGUID: oG/8ZDmFRIGJGkgnij3kkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="176937272"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 13:12:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 13:12:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 13:12:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 13:12:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DV+i2GO3n+lvqt5+kA4/MkCKoPl3KnnXQD7YUZa7zjpQ1lqyQKhuepzO8C/oOR4bUR3uR/PpDw93vCrs8G1OothyJijjK7R8KxjtgQOZ3v72KOglu+cFVrw4SZEM0YSR7uYbnXzRB4xpFlEQ6bAysCw9Eyyl2OTANbBST5VM9ebzZqp7YuO/PLfLWNCUjwhQfSxvamSEhgh7EqDWadXkSBkqzKhomTF5HpjSEWYeK3iJtWRQBwsJ44Xwb0w1zRn422stJHBGCCdBqurR8+xyfLRx69ifOUSl5bUWuyknNu+xQwIRNqJ2d6XClIeXrjKnM3xWGEmffafp4h+RLWITOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TqjuzrQvz5A3Dil1b3UIBdYsLk9OIlzRHHuDhi+qGk=;
 b=N7EfNF5zv7nsp1jiajN2bDak6pAMleGWpc04dh41dwt4JBNLeezVxohQDEcB6MWKCHgRnc4d/Uv6OUYpzu9eFdj69Ltm+1xlQwSO0tKas62Y0LvwwyYen2Qy17JjBLD2ez0ccDF7LHf0BTyR7OvzfrfDd26ZyaiiwyqxGNZXniDdIUIdBxW8WPta2UwFILlCRNOQW0M1myPi7XQWWiEFSOwAdupAytoOKKJvqnH+IHaP3LYqt7Kb/tV+6hwrS0bfI6dGkwgoGy5dfAf3yS5n8jNYu+FrdVA6LxiWuIKn3ymA2KaUQENgIL7Ya7JthZm3JGETCpNBlwnx314jhNkIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7886.namprd11.prod.outlook.com (2603:10b6:8:d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 20:12:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 20:12:15 +0000
Date: Tue, 20 May 2025 13:12:12 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <682ce21c17363_1626e1004e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <153d5223-169d-4379-bc2c-6ad279489560@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <153d5223-169d-4379-bc2c-6ad279489560@amd.com>
X-ClientProxiedBy: BYAPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f7016bf-e4f2-4219-e92c-08dd97da9d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3hlfCy8Zy5qovNhnGxJb++dKYNGWtCK071VU44ytDdgWYD4DGJXb0IKycPlv?=
 =?us-ascii?Q?OvreZ55H98JBB4xXH/EFnPmrujgZ4Dhxa6uKExR7Oiyqz6osEmk/VFbIfpBD?=
 =?us-ascii?Q?QJU9i+ZXNqPo1i2WQ4vqYSnL5fNCjyFKVdxmxAC9p5BxW541rC0fRjqHnBe0?=
 =?us-ascii?Q?9hjM5EcP87XKhgJLVbcSeFWR6yhWPgrCOoyHOFCiRYQqtxI80uT4Glw6Ucg2?=
 =?us-ascii?Q?PiF+MYpjKJ6Av8mDhQNvqfal6x6UysK3ybuFE/cBBOvnQXzsibSsLrmRc7eO?=
 =?us-ascii?Q?AeHaeca4lbwNazGVxJEcmzaBR0sqGUVtq3ypSm6vrP85cnrfLlgeS+vbsYT1?=
 =?us-ascii?Q?2GKRyEkF1mu//tHi+fznwqEAEH5b7S9nCBlXHxgGGwd5trdgKAJ7EbITVgYg?=
 =?us-ascii?Q?IRmpjAlwa1h+aB6lDHtPtPntVCqI9wc1xoy3VwfGm/uDc+dry5RE+o2n8c9j?=
 =?us-ascii?Q?qkVJ2A34NWy16IzkEqIbGM+6o6r+AVMlwvt+q+UZ6nRxJwQ/LT9wGEqqHxzB?=
 =?us-ascii?Q?pt6mH6klH7MVRmJ75DQ7uFM5YX5pL8VbpPTW8nkgiRHLC7Pdhp9qEVqOrKt0?=
 =?us-ascii?Q?0GXUNnPdazijSHn5/XULAmvksQjxuzEDkGocI2jyUpVZKlVHimqrOfmZZxrY?=
 =?us-ascii?Q?5e3JP3o2WXgTYzqytXCCy8z3w1luOyeJhRxJIqZ5cJZq0Rre4YIKHYepznCY?=
 =?us-ascii?Q?DJGKw6wQC2Lu9Ire4CPZaSLQA8bmIXQdQQw3GYULgMAKW9IIPTys6ElItaIG?=
 =?us-ascii?Q?hOeVRAKr+mLmvxAEFEUQGcUbA0Gf6wGfqVT0Q3KCZ0dy0JOWwU9oNrN9qVMb?=
 =?us-ascii?Q?dC1OdlPIunIxyX0m4UccmFHlosVzYGsjCq7eheHAnl8boJmd0y5vuDP5a/wz?=
 =?us-ascii?Q?u6A72UT30mSfupEPmk/bVviFu9rRvXUMBBbLh1E/SstITWnNhcTLR1a90WFL?=
 =?us-ascii?Q?AhabCpmEbAoqUeHvV2xE+0orsnADlmPSJlNITd+2MmcrRBeMcIbOtn/ZmhV5?=
 =?us-ascii?Q?FjuEiHA9C+dZ3AlDLqb7rz88tHSsv9kD7pvTasU+YelHv0xBQnFJlG/apyy/?=
 =?us-ascii?Q?DhcwBjPpEhWEUOWBk4EyfI4iJwFCqharbvSvXZISULT/ClxtbOQA50/SPFoo?=
 =?us-ascii?Q?1+pikQUGFQH9FZKI4QhbSu1wLr0bghrcpWuKSEHLra/sEQ6JMREHiZTOPkt2?=
 =?us-ascii?Q?rFHq3jXhppOoMZuvHnAQpKu1mKtR3W02SKfMaAn+QFqxqKEenYN8ClYmUkwF?=
 =?us-ascii?Q?KsodwpJhk+y+wY+avytKQlW3bbvfNqwRc/VYPzhgT76t2/0J2MLhjBBuLU88?=
 =?us-ascii?Q?gIoyMrSxv5A1SRpSm/0nQM9+FAJQK0BfksECi0u826/FDroTaDCd7V1Yb+q9?=
 =?us-ascii?Q?JUc366VfnnYE0SYfVav5aYcJFmgwW34VCIt5V1v3NxfT7DlP5/nacnoDOhpZ?=
 =?us-ascii?Q?4oUCdZ0Q3V4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AzPOoQA04i3/35DQy0WrAUIfMMnMvmi0/PAEkSguEe3RDLt+jPWhPkL6KwQ4?=
 =?us-ascii?Q?F+11HXE/0YLXHTzosukk+SZsr5cBDNdusNZpR2ZKh0EbDDXIeEHJIYWz7AEl?=
 =?us-ascii?Q?teBO5V3xJsRkbeTlaPCfoE8ASLfZ8eYuzjhKPQB/acic4hDSw6S5XTJxjywh?=
 =?us-ascii?Q?StH8QIF/66R9CvrvzCGtPRH8fLwsa6aa0BVFaBtdGZBrGtLGFSrjfGeHJZJU?=
 =?us-ascii?Q?gqGeJoAe0HWExxlLBmi3SEECjBcNwMfGYoz3cS1BWHRa0hU3dhWSBt0JRk3Z?=
 =?us-ascii?Q?5xmwnB8Lh4QZXjw/8vf3YdDDIbEDGdQFY1gw5XIVK6QNY8JoXaZ5+ndRBob3?=
 =?us-ascii?Q?zrlVp0jpsYeE739kTa79N5dp2eQ7Es5+L67D3GrGI0MONK/NlelVNy5jZsem?=
 =?us-ascii?Q?zFUa9ze4OZVOFy2dNKhHESGNiCRjcIN5INghDCABUcyDd44YJ85ZFZe7lzyv?=
 =?us-ascii?Q?2TQJ5egTLG5Ss7OrPRMF5dd4gSHPAJe9YoZNbHUo69J2BDClOlQ7AiB8KiYj?=
 =?us-ascii?Q?Rd0EcIsrcZqIIEL7Ql0WsBWg79oSq11bmX1FRUI6tWGPGQHijWWLK+g7woAl?=
 =?us-ascii?Q?0hZET4UJXJuo1kAJn6nZZUKCwtRUrDD6Fu4ShFkjVYbcMOFncZZs3ko9Qefy?=
 =?us-ascii?Q?5urS/yNGuhNXWC7SR8LmEBNDTX6HgfgKp0Mim6aWL7sWrLmsCGlY2z4xezq0?=
 =?us-ascii?Q?Pc70evJgSqA4o7sB+stseyv5yvrwMN41pmdfJWXmTp7291MehRjbfvVpfDEd?=
 =?us-ascii?Q?OpRDWN7qxaEge2mPQgbl+DEcFimFzJ/y3/hXC3eLFICQRTxB3j+FBuHTbAZO?=
 =?us-ascii?Q?wPzeCllpv51tGSnIt61/pLnpmk+/Z8otNFmjdZw2OVsASuNbjKXy/J8c0uvb?=
 =?us-ascii?Q?koxX7/9t6jI3EmRM9CJ4rByKpg1S8Z0/GacEFjrH33s3tQ9T3l4SXZsgHzh6?=
 =?us-ascii?Q?x7ZXQsGRN+qAC4Z1JwCi8V27aQ+tpzo/xM/9fex05iIrrDZi/rgaz1I0Bael?=
 =?us-ascii?Q?Fv3NcSV/aBV2t/fo2Y2bu5P43XbGSX/6SsNe79yaUOuHqLr+6ft4iObj3YYl?=
 =?us-ascii?Q?yGrw9WNwC8EwmN/1m6H9epXRgTaJXS8AIKPZxWmVCfr2Ji4m5suTN8QkjvKD?=
 =?us-ascii?Q?dq+d+C8078swIJ2XEGpqgP5rGFNkgTbYRTFtIfFWNqObLWsAt/KZzKpYQ0dp?=
 =?us-ascii?Q?Gaq8GPMvH9X/AGTnNRuIVGYqa3sHAgu9vC/gqT9y8+o4tlY93CwGkAbxUVf/?=
 =?us-ascii?Q?9XPbFCVQBxf9hatsbUG9ktRfet37sAJFi+Q3T8Vr9zZgAa/xuY8WrPG6MnO6?=
 =?us-ascii?Q?cKRGuizL7Ls7o1cQ6DkCTaUJl4aCGZBHErYVll8PXY+v21uLYmE6uwu1alCS?=
 =?us-ascii?Q?6Lm/rq0tMfuKZ9qKrBH/DBqvsNRKErWutBZ1cRU6yy3sdtee0bi6F3pMJIBI?=
 =?us-ascii?Q?cYeXdCaW6ErAVCb27WWGpLUip5RJGO95eZbSVPYfny8ge1s4tDNLMTONVu8z?=
 =?us-ascii?Q?IBhTvtLHCTDx6q0tmclLdebAhAK+fR+dnkeAxwZfJ7ch+Qaq3rDFgAaYxgqT?=
 =?us-ascii?Q?MdxtFvj+WhukBRIWGjCCeW0KsrgLFPCyy5xTZIfSX3Agaxp2WKPQ2gnj7NSa?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7016bf-e4f2-4219-e92c-08dd97da9d2f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 20:12:15.4320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeWLlGblGt1AZ+KTUDwPsBUFwVnK0AgEIRhY0Rmt4B4SP4FIGSdkxClUuy6MdvmIi1t51Ie7cDpQR6ipk/ioMdX/VKANuK6zlffCjZG3egQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7886
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
> > +{
> > +	struct pci_tdi *tdi;
> > +
> > +	if (!kvm)
> > +		return -EINVAL;
> 
> Does not belong here, if the caller failed to get the kvm pointer from
> an fd, then that caller should handle it.

Sure.

[..]
> > +static int __pci_tsm_unbind(struct pci_dev *pdev)
> > +{
> > +	struct pci_tdi *tdi;
> > +
> > +	lockdep_assert_held(&pci_tsm_rwsem);
> > +
> > +	if (!pdev->tsm)
> > +		return -EINVAL;
> 
> Nothing checks for these errors.

True this function signature should probably drop the error code
altogether and become a void helper. I.e. it should be impossible for a
bound device to not have a reference, or not be in the right state.

> 
> > +
> > +	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> > +	if (!pf0_dev)
> > +		return -EINVAL;
> > +
> > +	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> > +	if (IS_ERR(lock))
> > +		return PTR_ERR(lock);
> > +
> > +	tdi = pdev->tsm->tdi;
> > +	if (!tdi)
> > +		return 0;
> > +
> > +	tsm_ops->unbind(tdi);
> > +	pdev->tsm->tdi = NULL;
> > +
> > +	return 0;
> > +}
> > +
> > +int pci_tsm_unbind(struct pci_dev *pdev)
> > +{
> > +	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
> > +	if (!lock)
> > +		return -EINTR;
> > +
> > +	return __pci_tsm_unbind(pdev);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_tsm_unbind);
> > +
> > +/**
> > + * pci_tsm_guest_req - VFIO/IOMMUFD helper to handle guest requests
> > + * @pdev: @pdev representing a bound tdi
> > + * @info: envelope for the request
> > + *
> > + * Expected flow is guest low-level TSM driver initiates a guest request
> > + * like "transition TDISP state to RUN", "fetch report" via a
> > + * technology specific guest-host-interface and KVM exit reason. KVM
> > + * posts to userspace (e.g. QEMU) that holds the host-to-guest RID
> > + * mapping.
> > + */
> > +int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info)
> > +{
> > +	struct pci_tdi *tdi;
> > +	int rc;
> > +
> > +	lockdep_assert_held_read(&pci_tsm_rwsem);
> > +
> > +	if (!pdev->tsm)
> > +		return -ENODEV;
> > +
> > +	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> > +	if (!pf0_dev)
> > +		return -EINVAL;
> > +
> > +	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> > +	if (IS_ERR(lock))
> > +		return -ENODEV;
> > +
> > +	tdi = pdev->tsm->tdi;
> > +	if (!tdi)
> > +		return -ENODEV;
> > +
> > +	rc = tsm_ops->guest_req(pdev, info);
> > +	if (rc)
> > +		return -EIO;
> 
> return rc.

Agree.

[..]
> > @@ -86,12 +101,40 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
> >   	return PCI_FUNC(pdev->devfn) == 0;
> >   }
> >   
> > +enum pci_tsm_guest_req_type {
> > +	PCI_TSM_GUEST_REQ_TDXC,
> 
> Will Intel ever need more types here?

I doubt it as this is routing to a TDX vs TIO vs ... blob handler. It is
unfortunate that we need this indirection (i.e. missing
standardization), but it is in the same line-of-thought as
configfs-tsm-report providing a transport along with a
technology-specific "provider" identifier for parsing the blob.

> > + * struct pci_tsm_guest_req_info - parameter for pci_tsm_ops.guest_req()
> > + * @type: identify the format of the following blobs
> > + * @type_info: extra input/output info, e.g. firmware error code
> 
> Call it "fw_ret"?

Sure.

[..]
> > @@ -102,6 +145,11 @@ struct pci_tsm_ops {
> >   	void (*remove)(struct pci_tsm *tsm);
> >   	int (*connect)(struct pci_dev *pdev);
> >   	void (*disconnect)(struct pci_dev *pdev);
> > +	struct pci_tdi *(*bind)(struct pci_dev *pdev, struct pci_dev *pf0_dev,
> > +				struct kvm *kvm, u64 tdi_id);
> 
> p0_dev is not needed here, we should be able to calculate it from pdev.

The pci_tsm core needs to hold the lock before calling this routine. At
that point might as well pass the already looked up device rather than
require the low-level TSM driver to repeat that work.

> tdi_id is 32bit.

@Yilun, I saw that you had it as 64-bit in one location, was that
unintentional.

Note that INTERFACE_ID is Reserved to be 12-bytes, but today FUNCTION_ID
is indeed only 4-bytes. I will fix this up unless some arch speaks up
and says they need to pass a larger id around.

> Should return an error code. Thanks,

Lets make it an ERR_PTR() because the low-level provider likely needs to
allocate more than just a 'struct pci_tdi' on bind.

