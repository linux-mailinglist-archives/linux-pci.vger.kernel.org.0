Return-Path: <linux-pci+bounces-14961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E06A9A9596
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 03:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A68B213DF
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 01:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2BB131BDD;
	Tue, 22 Oct 2024 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+AyI+FG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D15312E1D9;
	Tue, 22 Oct 2024 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561435; cv=fail; b=Xcm8T7UyjM7iLkZpLd3poPBJMIfuekn6OodZRWiyYqKuWuMCzt+tj91NMXy9kyEeSzu1+ADoJP8f0NAsnE0f+uWeZAhPTlYE0r8/YtRf5S9MSRMtvqweg+EboCH52N1Xc8XVJnj/Xo83D+Y95nvhjWya8xoZbFnpwjC4I/iFr94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561435; c=relaxed/simple;
	bh=hemhL6TphvFGaMF11IrycNGbXjLoBIph1aonWRffJTQ=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HXkrBx9Vp+yBMpCTUxC5VNVynWtANFp+Dv77Grw+LTX7DCuoakjMu9brHI42t5AOmNvW8hpoxvhylp2YJF0y9UCocABMnsn1eQGdmmWTvwiBNie/et9pjbJcAt6hy5mJ/EALEoPATcI3jQ7HHT3stVEUAo/hmdJc4FbCVu7Of/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+AyI+FG; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729561433; x=1761097433;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=hemhL6TphvFGaMF11IrycNGbXjLoBIph1aonWRffJTQ=;
  b=b+AyI+FGEGoIRkSGVBi3eNDuR83n1HviVzQjayqPwkWHW3O9wETPw4PA
   aEpaHX3lPGGUf+WGLAdWu5WUSm5x6O8W4ZAtrRJXhbKmmMib+6aOSZbc1
   0VhRzqdm7YzOsz5eRiZYVrCxZnJ57utbxZXEX+Sb8cBm/j2ob8Dbo410o
   uGXzkHt72GJyeB9D8T1ypLs9CEPb54lDEwUDZ1ziNgP9sVZN3y9Kr1Pxp
   yNTeGuZdtT1WnDc4gRahoL+42C5nw5OaL3TtLZJ9VL4Psqbn8SlUmOWpm
   n6VkZAFrgXyIeNEBca62XrQ3nnhdSiPtqkbIpctvSdk7seepyu9KVOOdY
   g==;
X-CSE-ConnectionGUID: Ic8d5NptSkOH/3l8hHk/zw==
X-CSE-MsgGUID: wmJwrL+YQBWTgcKVENW3mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="46560559"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="46560559"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:43:53 -0700
X-CSE-ConnectionGUID: Tv8ErXtnQf+RrY9BJbI7zg==
X-CSE-MsgGUID: ENMtTEzfTeeLXq8OcOzLtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="80065038"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 18:43:52 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 18:43:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 18:43:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 18:43:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGXEtyCLXi83BZaP3w9rBcb6EkKdMStDJymF9fH96K3jKvUVHhC8cD79TmtoKsLuB7DbEIO/FN/DyuKwJAlHO/r8GywJlDRbr0bWqR3MafL8h94GDemHWUQBA1y9UYraOtKUIGi98mCvjUJhIbbtVq5KgkIeLJFvmGK5FRDMWIVRgmVlH907QCmwwOBOsgeHihlO48GSJrsH2SF3QOMRCsAX82VmoWKPVrmFfha6jXzre5POlezsEDJ2+2NwoozFxuMjLwEScGTvOlf0WNxF6ZLGNxWnffQugrY9XuimKsq94S3lH5e5Il5higEk0AuepWEkSG+SPFcXdUtWefqV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spZHkooL9x6hTtFDPUz9UW5w0IIrdXHan7Moj9++caA=;
 b=NwbCOEQfTm3Ca77UEbd0/9PnIXdOrK6ywt3eL77j+oQmGYyQVOWT9i4PvvDXqf/kxmq3Be2NuUlkhpwW1nVU5DV8OImsV7kxo8xO3C68JY4+9b8m5GRYjqRzKb+ByCKAcYh5US4Ur5uoQ6Hu1HwCL2ttBjsn5uJQbA5ueLU5w9VZPdxLsZubWLSyeFc1K3HRWaA1RdsDwqkYr8SDsubnnH7V4iFE/Ie78owZDpL1jbndi/ab12X1Gw6rhEp3w2x08SehqvwJW63NXQTyM8QfKw46EyQnw5Vqquj5VarwdUjrlPEXQqDyqsWNW16QrJj0cksElc4ajbv4KvSS4GW4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 01:43:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 01:43:49 +0000
Date: Mon, 21 Oct 2024 18:43:46 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 0/15] Enable CXL PCIe port protocol error handling and
 logging
Message-ID: <671703521fd1f_2312294e3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241008221657.1130181-1-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0255.namprd04.prod.outlook.com
 (2603:10b6:303:88::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 639a2ee0-3230-49f2-94f9-08dcf23af991
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F4x2qkRi2s6mQrmKFY1Kdwt18lfbQyyLjP/1hvYjukset52+EZYlJwveeUN6?=
 =?us-ascii?Q?Y3qxKXuhtXMPoLNjOZTrBgcMiSXr2JxaVUS8iIC6cBVmG2EqTUToxvrE+Ayf?=
 =?us-ascii?Q?j/k+kI2Wf2AhWnFDJH4WpGxT+yxs+tnHFEY6IxOdwsTMtpaTznYcL8ANmfcw?=
 =?us-ascii?Q?uOnAQyWy6OD6Mc4zXu1ywcAHKKNwA3l7WT1SyjNluY6gse2WMtbyvNdP7sg/?=
 =?us-ascii?Q?TYnRBKsLa8TebJxvMHQLoVcMPEWnI7Z8SeUSL/gRyZIHNSv5vcx+YtLG31rt?=
 =?us-ascii?Q?9NGqgFrJN/rD5gzvn2x9IlFVTDvWDWDrRTZg60HXiRQMto7ICwBwaN476+YF?=
 =?us-ascii?Q?5geJZMCl/18Ll0nZqNZI2D46TWlH5jGwVDWgb8un+w4lrvl4StHp8giqipzw?=
 =?us-ascii?Q?CphpXTxtJVf76ycGHvicKh+LaG/PvF4dhrSSd7615SJSJj4utJlBn5UjlPcM?=
 =?us-ascii?Q?IflztJ6A8LImlpsuYE8Bfy8DhqxqL60871PjDbyOy+QOWnWBI02GEhhChRsa?=
 =?us-ascii?Q?BFePAz8EwAZD3kmrLx8zYCUMJ8yi8fwYoVDnUo2DYOaHXuvaeKvf71uY+ikg?=
 =?us-ascii?Q?LNGU5j1fltfugt/OqKfezL9f4YhE4sR7/ShzDwPxKDTNSVSd/cwluJDq1eC4?=
 =?us-ascii?Q?Vt/rII13BiUszBWoJLQv4GbO3zlphYqeo2HEZWghXJzJf5yTmNQc2j57h661?=
 =?us-ascii?Q?LxVF0RbKvmvBo1pMlPCBxYU/+R/MF0AiEuoyTN2OVbbHDWEu95wDL6rq/I4Z?=
 =?us-ascii?Q?bQgVPfFJXmruUmLE2J1XvRApTNhHK/V2BXu14ZFG8cPgeoaPpqyNCncCQ7eQ?=
 =?us-ascii?Q?lNa+0dHMMeVDp19JRlyFvuHMBIgau+ZElvLptTFTvn2QUMrI6ja+oZnO/Bux?=
 =?us-ascii?Q?UCXrmxMvPgSDrgy18muKaegwpmeI1Ca6vgfpnkP17xBKmFLrCTEhdFGLKEUQ?=
 =?us-ascii?Q?8e/Wo+J37M7GIfnEFS42gfGbqUzmBWhBD7DwXEKl+/yrU9jgmGE30muEyCFk?=
 =?us-ascii?Q?II7d3C793ubPAx6SNsaSC7RfJAC/AUpPLY6MYfhVCsuRhbxa9X4ijAhScuhP?=
 =?us-ascii?Q?VDT4pCP9dyZ3+A4VMUmrbfbszBDeCc7jB0GfVBf0YqibnQBwoYumxkwqmDLr?=
 =?us-ascii?Q?6MZG6dGZnIS4GytFWg6Cn25e4rbI6srE67Bi0T7MYHotbHjv3sNWvUWkXJ7o?=
 =?us-ascii?Q?oNX5qYobII25gnSdG4KfcjhE0iNpYCxKEirUj//UF+3g82UEgmIHFTtUBr5m?=
 =?us-ascii?Q?1bkete55vDNyg/e6zpQxdxrACpAu2tF8uwPQ7whRi7lmFQbv6MgABvdL9MGd?=
 =?us-ascii?Q?YeR6WOTObWx69umghtRUHmrrnAEY7tC/Hkwy1Gh75EdJvMlpqlwEwpv5XhLj?=
 =?us-ascii?Q?4Oqgi34=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MSTqp+pqWbzXoeKTxdaVMWJnh2X/r+7dO9Cji2jjSoV9hzV5l63zJ9GYg9Ru?=
 =?us-ascii?Q?d7AhCEGfjQEyWzU28sa+7v+SCiC1EBoRLSmtJsXtMCeVvwwEo6ODzr8wwmAA?=
 =?us-ascii?Q?2haZ9rV15A+9yBlPnldpGtQ48f/c4c4Kg/nmLsY5kks99SXWQ2uTlWLFuln0?=
 =?us-ascii?Q?qmdOt7Szrj6TNb160Piu8RlNO/bO5qc6bupcnndOUB1mBlV2VBr69igFnTtu?=
 =?us-ascii?Q?FfxfwoIhGP4BuiiDu6s4oM9ElQsgEOjomcze3+EjyC9m6OFYepCrYAiri1G0?=
 =?us-ascii?Q?DAXGPba9VvcQbmGIQJAXeFIj2nrFJPQSYVAs8T9rqEftHp0jsfjElMzJ5Xm2?=
 =?us-ascii?Q?pfCJo5l29048BBb7pRckUnZyoeMdXZkRZUHhKhqRWy5rIWRD2bmxif9HWZDG?=
 =?us-ascii?Q?9GTesKF9Wj/r+K9yo/joC1LzrMkJ/SZ1nQpmvmiuOjMMgqxsX5XF06EzRvCj?=
 =?us-ascii?Q?z3FUfK5LaIvVKwVI5sxF5XbNxyzwKN2oTQPF6W/6C2YAEPG6pePSyQUuYKry?=
 =?us-ascii?Q?UNHws//3zCulnqfBNnIRpCFyxlk25CfP2CqwWXcIVkG2AxToL71bJy48CI48?=
 =?us-ascii?Q?hKHTmkmLJQ1qi17G9bQhWVVApiz8qay4Irx+NWd0FA7nNsV5Ac6mvh9ZOwnP?=
 =?us-ascii?Q?D6UeW5RQABJSYPOuj7xxbMC40ucRp2jewd2wq/8AzJgoZtlCC47q52NC3W1J?=
 =?us-ascii?Q?GISWyldBb/Qd6nDVDuzFrKkl1zjfs1FodJzqunnd7vZSn7R7PAKVMvb1kDSP?=
 =?us-ascii?Q?ObIFvJK+oY8MqgkJ7ic5FSR6TMFz303JDZnUdZ/FGvzCkkG0ur24MjjYvnwE?=
 =?us-ascii?Q?mUZ9SdhntG99dKvCoEPP1ui2TB8NI5vfImLNxfjhaeBA9/YY1pHjhmkFAP3v?=
 =?us-ascii?Q?EO5zCVPTTw7c7FbgDCoierEx+ibUsdg0/7LAlpv9ajzMvoJyt+2Fvd83ka/f?=
 =?us-ascii?Q?pRjPH66el5PVbv1zvRFNIofH1evTdwE59Twy/QnUwZlSQZyBgAkHh5AxduJl?=
 =?us-ascii?Q?1vzXws4HuixKul8Ypd2JYr9SJrixfcbhnFucg+mLGIb0BunqhN/w58fnMA4i?=
 =?us-ascii?Q?DYy3PL3gKG86C3e3Re7F7cCNBVcInXupFOOzwN+BBX6WgUsHgZn3QuW4jmxH?=
 =?us-ascii?Q?cCpQDDav1KmDJDFAjpmT8I6swplkD62Yn/gU6B/RCIEihZdB/JUe3Gp7/qD2?=
 =?us-ascii?Q?l2jNuL9mPcfO9Qj1z/dfFvmGz781Bt+XVg7oDnqm6NjSRKp7S1hPf7NEiNpr?=
 =?us-ascii?Q?h/+0RCSgbUhWzMh4IsbxmwwTmVclafsa/UyXjovkKaVwE5zOw2xPqOp5vU80?=
 =?us-ascii?Q?iQrhxx3OvYMbguGOFWJoXN801au7tKRqOJmwoYl6yCjiaT2zVHvoW6ZbuXcG?=
 =?us-ascii?Q?CvyjvC8MJkB6yE/QhcAHVC/Pq58HLJhEZOV5WjZry9eh4YUon683YyfyBboI?=
 =?us-ascii?Q?sooC9D5Dua00qoC1MBqhSgTe/Dqi+pvf1utgBSZswZOzsHDVteXvVKglF0+y?=
 =?us-ascii?Q?NmzIcH7wm+2cGErEs+QQOOw1ZZwijM3BMymdT6/dkkq7LuFjRX0Jd+jDyE/0?=
 =?us-ascii?Q?FnqFWfSElQHIPZpkXnZdwyXAkyACbM8cEyHWMXErN1QnfGgWG2mrvzj8gqTC?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 639a2ee0-3230-49f2-94f9-08dcf23af991
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 01:43:49.0201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4KA/DeA2lxTPZlk66BWTS0zFRe5TutcD90IJFZvDGULCs0tgeTiFul4dfBQVzhqCzR+YsGqu5vTxmdctpoZLFEWGU/Xk0SaO8sS83NOQtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-OriginatorOrg: intel.com

Terry Bowman wrote:
[..]
> Testing:
> 
> Below are test results for this patchset. This is using Qemu with a root
> port (0c:00.0), upstream switch port (0d:00.0),and downstream switch port
> (0e:00.0).
> 
> This was tested using aer-inject updated to support CE and UCE internal
> error injection. CXL RAS was set using a test patch (not upstreamed).

Thanks for these test outputs!

> 
>     Root port UCE:
>     root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
>     [   27.318920] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
>     [   27.320164] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
>     [   27.321518] pcieport 0000:0c:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>     [   27.322483] pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
>     [   27.323243] pcieport 0000:0c:00.0:    [22] UncorrIntErr
>     [   27.325584] aer_event: 0000:0c:00.0 PCIe Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available

It strikes that by this point the code knows that it is a "CXL Bus"
error and no longer a "PCIe Bus" error. Given the divergent  responses
to Fatal errors based on bus I think it would help to clarify that the
kernel is panicking due to "CXL Bus", not "PCIe Bus" errors.

>     [   27.325584]
>     [   27.327171] cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Memory Address Parity Error'

...i.e. someone may not notice that this is "cxl" reference in the
backtrace.

