Return-Path: <linux-pci+bounces-40800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9403AC49D16
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 00:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABA43AD71A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666EA30498E;
	Mon, 10 Nov 2025 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWzx6i2U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E663043BF
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762818695; cv=fail; b=qSdcTB55ioIdDN1NeTv156k3GHRGKSxJMjm2xNRNhLIW5+cFSEUiSbXZl/cDE6CYgFjFVyc/PSQcb15M7I7EfgqHNItQClxnKwtWVVH8BlXVe33+ck/9QvlEu4VZi0qCwicz/C3nJlvt057rJLQcELRgXIa3iW2fcxsaPzYndto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762818695; c=relaxed/simple;
	bh=duyEbVJxjrAc0qeOgkg6HjVBQZH0n7blo/funJTZaJw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=BUkIQsNDM1byi2WQeFZriD91L1Wt2aN6vUjGDg8aNlVGYYEO8kEOHozklpb93VKhHrbjFtZJzXz6mqScdWgMyIiMhVrRlWaAkpFxUWc/yC05yVRT/IM+NvJpdBY+T3Dcj1TBYlgiikt2a1DVqHFr5+NSyUohq7bCyFcgIVOfGfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWzx6i2U; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762818694; x=1794354694;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=duyEbVJxjrAc0qeOgkg6HjVBQZH0n7blo/funJTZaJw=;
  b=lWzx6i2UvUfZrCyPBHeKA4dYUPtRlI0qrxmF5tM6czX7LsjcqYuQZ+iL
   YCiZOPYSGNGSPhx+EUsrgHAvIVxSIkygLxWPr7tbA0EDRvySRdWTdy85w
   maS5z8tRUeF+NuEwA4tUl5rmT8QY79eaFsdCOXe2E6sY6j3la8KczWLyZ
   WGmxO7P4WLolmyYW6+OqqVfGVGeBN3R0qPzDVptOmYiT4v9tXIGdKOlVA
   3bZKhNRjmm8pSE2Ff3ksqaVOVvb80A+wkq2lBKGj6kSd+rRDvqSIVFjp5
   icImgaoN3dRLFiG9WWnldrU/k+lpZz0BgO+HuItgqZ6bIsiPwOkL2K+5Y
   Q==;
X-CSE-ConnectionGUID: YfqD3Es3Q3u4Whe2KwEKHQ==
X-CSE-MsgGUID: bCuMZDTNTfaFthlQP8rA1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="63878951"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="63878951"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 15:51:33 -0800
X-CSE-ConnectionGUID: DOFt7I5xTl+vZioTiONK/g==
X-CSE-MsgGUID: V4FdOGAKSfK4k4YnSTUhTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="193809733"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 15:51:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 15:51:32 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 15:51:32 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 15:51:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCkXCtxhwwYP4MC4KZMwzQKMtxfPm8lUltUC2iXVsiJjJzqguvlVHw2IleBkOlxWAyVgHM1pAnGagW+ks8o5BblF8zbHMAeNaX8nMReE/rEKxSvJsJlLXvUSFT2f6wGUFxtNBIKVlovDj1tDeV7Qoegec+PWz3g0EtIrs+IC0nZCRqiEZYVnikXw5pjOP6XhBqWbc3FZyBUJ+4ry+r0I0092lglaVvUAjXju2keHmKO79w0e/QP722iUJBun6LJqkiCgRdqqvJ5TLUZEE6j46kB4eLN43TZzGYg3MGnMwmTfWQN2V3fbQRxZip4d3X5m5mNd713uxpsfFyG6tQew2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7t/e+16/Fsn7eI1gzl6B6IszYafhepkuwaIYvJd21Q=;
 b=MVqRJegyTPxvH8wKq+QTBplgWfArUP3VGCC2aOK90GB4M/x69K4GDEu+wWrJ0PRHHbM+Bvhf9SPm8bKQaqM+XhHQ7wpmzWEycKvYRT+TQr8GWJRSF0AjfzZVMdvpyDlGEszhiv/vEa8sdNIbTbw56bJL7EP3+1W+KcGqVIe1289C7h9V1hWY6LJVzfHWte7xgsSEIhpBsUD5dFOdDiTD3FM3vffvrc9bIBTBmr/ew/ViB37W5tridkHfXvwHaXT0csiAHiY+/1t9NQMVIxRcid5DBX865ZhDUz02CPO5Pi6RBhhj7C6w3gurbJ/zWsdZuTdWxdSjQi1no0Z0jw9XDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6822.namprd11.prod.outlook.com (2603:10b6:806:29f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 23:51:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 23:51:24 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 10 Nov 2025 16:51:21 -0800
To: Xu Yilun <yilun.xu@linux.intel.com>, <dan.j.williams@intel.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <xin@zytor.com>,
	<chao.gao@intel.com>
Message-ID: <69128889c6c2d_1d911009f@dwillia2-mobl4.notmuch>
In-Reply-To: <aQwvsbZy50ac+xid@yilunxu-OptiPlex-7050>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-21-dan.j.williams@intel.com>
 <20251030112055.00001fcb@huawei.com>
 <69093bf7d6ee_74f59100fe@dwillia2-mobl4.notmuch>
 <aQwvsbZy50ac+xid@yilunxu-OptiPlex-7050>
Subject: Re: [RFC PATCH 20/27] coco/tdx-host: Add connect()/disconnect()
 handlers prototype
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: e6721e85-21ac-4e31-7dbe-08de20b40e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjBwUDlWVnVhakhCdEpwNTRQM0Zqc3Jna0Y2Qm4vbDdQV0lYQkZHWGI1L3c3?=
 =?utf-8?B?ZnAyQzBTSWgvZmhhRERzbnpLZ1JnbzVnakRjaGs1blN5ZlB6RnUzRkVtS3dF?=
 =?utf-8?B?UURtUkZtYUF4NWF6WnFxejRPb0lmdmY0cmlvUUs4MDRrWDhLcjI4akpDRUU4?=
 =?utf-8?B?Rzg0RnhEb3B0NlZqNnUya1QyakFweFM0SjFtYXVvTUlWZm4wVGxvVnlvWnM0?=
 =?utf-8?B?MS9ZT25RdVQ0Tjg5bUhpSlNNeVlLZXJFcWhYWHp3NjR0Z2dsKzlhNCtRdDhu?=
 =?utf-8?B?Z2x2MXFOMUZMenUzQS8rclljOFk1T1JyczZJdEZ2YTRocjNKUWs2R1RubHBF?=
 =?utf-8?B?b2prZ21HVzNNN1dOOVZGR1QrUm9zVGFyVEZuRXRhQTh3Snp6S252aWJtOGNZ?=
 =?utf-8?B?bzRvYlM0Smh3WFAxaW9kS2sybzJ1dlFwTEZRT3IrYmEwTVQ2ajI0QkNVVzlp?=
 =?utf-8?B?c1dSNmRDSHBxYkFFK29IYUV6aW82UTRmTTR3bGt5VVEyL2pvbHl4UnpXclRY?=
 =?utf-8?B?U1ZyUGsyb3dZbTN3aDlZQzFLUThNOWpIbFFjVE8wNmtNLzd2Z292MTdMNGhl?=
 =?utf-8?B?REhNUWhnWEwxZHB0c09SRnRETjJRYXQzbVU5TjBId3h1ZDhDS2pIV0FyL3ZF?=
 =?utf-8?B?eUxOOTI3Z0FMVTRhVHZtSHFVNmdZNGk4VjJYMUYxdk5YaTFPdFU0UWRUWVZO?=
 =?utf-8?B?enp6QWd6T2RMbzV6V3ZNUkowZC9iSmNMMW9KZEYxMWF5aTU1VE0xbTdBWXc3?=
 =?utf-8?B?cldpTGlPZXZWbHBBa0RKRS9WeUJ6aUNGSktRSkxjakg5T3lCN1luMlZpVjVE?=
 =?utf-8?B?NmxZdHNCSkpDMWtsY0ZnTU0zU1d4amtzd0hoNWxIMjN5YlV2bjZFTG9zckpz?=
 =?utf-8?B?RVJ3VW52RnMzQVFIU1JkZWg3cXJiNE1WTVo5eE8xNU1UOE8zczV6Qk1BZUV4?=
 =?utf-8?B?ak5nWVhEenNlYVBzWmlnSW5KMDZWRW5vV2ZsVzhGMEJMdmFXc242dDI0ZzFD?=
 =?utf-8?B?NVUraVpkZUd3QTU2aktqbmw0YjVuK3RITDVRS2Nhd2p2UkNBZ2ZLODQ0Smlq?=
 =?utf-8?B?NDlXbC9CdnNjUjBnd3NzbFBuajZYbnJDc3BXa0tYeGlaVkc5N29Ob1NFb0Rr?=
 =?utf-8?B?RUIxcm9iYWJPTDR4N0VwbExTdkc0NmFkVk9vMHNPTGhEdy9SVTFrZHVuWEti?=
 =?utf-8?B?OVpiNHV4dHZOVjFtU2dBTk1OK09IdUVkTUt0dmJxS0V3WkJRaDh2UE9EUjBQ?=
 =?utf-8?B?bWlKc2RMeFVuMk1lYXE0ZnROZ040cy91TCtoZFVXWFBpL0VTVkdmQ3RUU09R?=
 =?utf-8?B?OVRzWGhkck9tVzA5SSttUjRSelY0aE8yOC92U3h4dVdQN0Q5YnZrRHN5b3N5?=
 =?utf-8?B?MnJtaE1RMlVscDUrSGEvRjMrSDk1aWhpd3V2TWRNQysyZm85UnMrZ0ZaQmlv?=
 =?utf-8?B?N1lkaFF2dVhLdlFwRnN0NkxObDJ2Q1V4UjFsWkJZMXp6V0ZSczhiVDkrSkRz?=
 =?utf-8?B?UVlaM0lTMm0vS24wNlIyRC8wZXQvZTd5OXlTUVRsbGhaaGlERENVejJwN1Iy?=
 =?utf-8?B?RjB5STBjNWNuaE1CM1VHR0F4ZWorL3RrV2tJVEVIQncxTFEvZzQvS3ZUdVFO?=
 =?utf-8?B?dk50ZTh3TDVuVlFheStJWWxqSmdFZm9GMWVzZlhlZUhVR1lTVUdQQkZQZkpG?=
 =?utf-8?B?YWhWVnd2bnVIbDAzcTYxd2dhK2FCM3M3eDBSb0c2bURyY3BNZ1dYOUlhaGE1?=
 =?utf-8?B?K1RYSC93ZkFhTC9wQSt3S1BrS0lmQitFV3N5VFFmcHlvSVZacnpWWE1JYS8w?=
 =?utf-8?B?VXByRS96dExxTFdqc0l0Yzh3dWl3SlJFalJoR200QWQ2cFZmVVlBeFZueTNs?=
 =?utf-8?B?S1ExTnQ5ZDdHUS8xb1lGTHVzVnN4emtEQVM3MXdqbHVSa0VudmZ3d21BZThM?=
 =?utf-8?Q?+9VVqbASY3bZQEpJHMR1Ei6shG7mhWQv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDRYZy82bUVCVnh4d3NyQTM5QXJkZ2M2eFpSbEEzUm1IZlVjazVuam85NU1r?=
 =?utf-8?B?MTJMOGlUL1ViT3pucjQzNlJ4YnVEcHR2TFNQM1N3UjBSOU1TNnl0Z2Q4ZkpV?=
 =?utf-8?B?ekE3OHl6UlFmVnE5UjNwU0cyUEs0dTEwWmVxUGZNTnJ1QTE5Q01ZbWNsaS95?=
 =?utf-8?B?UlNYVGRleFhhOUMrTHZDM2haS3p6d09YZmdIR2hBeG5ZdzZYdlpveHI1VVRD?=
 =?utf-8?B?MzZscUR5OFViNjJ5cHZjWUV3QnBaZVRzNzlyME0rRW50SzZSMGFNTDdVUUhO?=
 =?utf-8?B?bTQyNjdzU3JRdTg1SGs1V0pmTS9HaVhRTExMWCtaNVEvVlNCdjUzYnFuQkxa?=
 =?utf-8?B?RExiQ2xUV0hjSmw3bXAvTTVhUmhMbXQ3MkdWOElIVHlGL2RrNXdVQmhIVDZW?=
 =?utf-8?B?L2tpY0JKdDZDd0VRVlZsYytmSnlmMDdIMjlpNUExOHpDT25oZit0ZjZSNCtx?=
 =?utf-8?B?MFBId24zY0I1dE9uWEZmN2l2NG9RL01ITmVLZUpYa0hyd3pUUXJRM3dEK0Nl?=
 =?utf-8?B?TDhQb2V1bUFjZ0NpTnkzMnBWOUFBZDlQSytYekhUMFgvR21UOGdDV21WU3Er?=
 =?utf-8?B?MDZoa2ZBOVhRMmNOK3d2KzZ0bFMvV0dUeENGNjA5dEI5anVKb3hjWkgzWlRN?=
 =?utf-8?B?cWlGakdkcWQzaVJUN2FKR2QwL3FncXk2ODVvanRER2pKT3d2d0xjWTB4SUVU?=
 =?utf-8?B?YkgxS0JleVFUZklwbmVyQlZhWGh4Nis4M3FFOXFVMUVQaWVtQU1BUExibjMz?=
 =?utf-8?B?WGZlbXIrTmlRR0hGYUxsSEc3UDgwK1R2QXh0K2p5ZXg1eWlMTzlOWmdDUHN6?=
 =?utf-8?B?VnVnNlBSOTF3VmpJZUhuaDNPb3VWQUdzbzR1UkF1SDhoN2l1Vm8ybncwN1Jj?=
 =?utf-8?B?bXVUQTlLS2tkY1gxeUw0eUgvSDkycnRDd0NrQWNSdHJLblFpcU9RQS9lWFhw?=
 =?utf-8?B?RGFsK3JGTWU0RWpKOXlxMm5QVC8wanAycGRpYitiaEI3Q1BXcWp0NEdPZVVn?=
 =?utf-8?B?QnJMdmZ4V1NXeUFNSVg1TVp1NnVlL0x6UjhkUExENTZzVjA0T1ZZMzM3QjJN?=
 =?utf-8?B?Y0hHY0FTcWxBbTdrN0Zja3M4M1lHR04xLzJndEEybDBYdjNTS3Y1VG9yc3Rl?=
 =?utf-8?B?Vlg0ZUZEVXlJT3VMd2JBeFRBVEVzMWdSdEpBeStnSnhiUGU4OTBxQ2ViWDlT?=
 =?utf-8?B?L0thdHZHNGtibzRFYUZCdVpKZjFyS1FjaUh6bDFBdkxsdUZFU3gyMmhMdnRk?=
 =?utf-8?B?U2piS0Z6L2tiUnMvRHY5UFJvWjliOHpYSFRSVnhkbjdWc3ZCRXh3NmhVM2hT?=
 =?utf-8?B?ZUEweENrWnRWSGxaRWhyc1NpQUcxaE9BamZRNGJocHZsYTB4TG5UQnl2TVYy?=
 =?utf-8?B?Zk9vSlZGODEvZkM1WlNRUVdoV01wKzdsRCtWT1Jzc3JSRUU5Tk94Ync3RDls?=
 =?utf-8?B?Mk1XWi9DT0F6MnFDb0NRbFM1S1hLYlJnZkUzRXN0MkcycnlHL3RJZGZPMU9i?=
 =?utf-8?B?WkVMeXJMQ3pSUU9WUXBxdGU5a0lmUEZFVmdnSG9VK082V1VLM2J0ZktiNUY1?=
 =?utf-8?B?SkRMR3VhYXA0RGs0TVROdHdDaWRPQThzbnEwMGlMRkJhTVl0R0duQTU4SEtS?=
 =?utf-8?B?UzNkWEpCRjBjWUFwNDBJaWdia3Z0eWZaWFB2c0VGckNzYTl1WmpyRW1EQ2s3?=
 =?utf-8?B?R1VtUTBDWFdETE1SSzRJQXpEOE81THBUM2FaVm5WVG4vQ0VuZWxTVFdtYWk5?=
 =?utf-8?B?ZDJmaXZxS1UwNUMxWVFaUEg2cGlvbkRLdU9mYnVrK1Z5M3k2ZkNrdXJrVmx5?=
 =?utf-8?B?YWJTUi9jZlF4eHhJcTg3aEV2YjdGNHQvTjNWK3pDTjN2S0Vxa25IRnY0Z0sv?=
 =?utf-8?B?eFdYOHJpd0tmU2JnWm5FQUlqU2tuWmxqZ1JyZzNOQWVvTFBHT1NxdmhObWlG?=
 =?utf-8?B?TnRWQkNwYTBPZ2hRaDZUbEtzcktwU0FxckZRK1M5NThtUnZqVHVNUW5xK0Fn?=
 =?utf-8?B?Z0w4WG5xVWZuSjVEYkxkekVwRjRpanRnbmIzN2tmTmMvT0tESEVlT3A1UW92?=
 =?utf-8?B?ZEpzdjBXQkZ4UnVKb0JHYi9aWHhaWHV2bHE0UFBhZk9WVFRSdEFkaW5sZTk3?=
 =?utf-8?B?QXhISm1heGxzMHdQWUhhQ1Bma2l3MmdOaXBHTnhBYmNXa1BGcEp5T09uNitp?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6721e85-21ac-4e31-7dbe-08de20b40e3c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 23:51:24.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9J1V9EUHk/pKnUAS3h5rCi5gyxWQ5f3Cyo06bQzuxolZtr+L+zJcMSxwQl78f+JWQkXZLa0fNgcwWAXQxHaL0YEIa6FgKp1AaT4msTyO3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6822
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> On Mon, Nov 03, 2025 at 03:34:15PM -0800, dan.j.williams@intel.com wrote:
> > Jonathan Cameron wrote:
> > > On Fri, 19 Sep 2025 07:22:29 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > 
> > > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > > 
> > > > Add basic skeleton for connect()/disconnect() handlers. The major steps
> > > > are SPDM setup first and then IDE selective stream setup.
> > > > 
> > > > No detailed TDX Connect implementation.
> > > > 
> > > > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > Feels like use of __free() in here is inappropriate to me.
> > > 
> > > > ---
> > > >  drivers/virt/coco/tdx-host/tdx-host.c | 49 ++++++++++++++++++++++++++-
> > > >  1 file changed, 48 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> > > > index f5a869443b15..0d052a1acf62 100644
> > > > --- a/drivers/virt/coco/tdx-host/tdx-host.c
> > > > +++ b/drivers/virt/coco/tdx-host/tdx-host.c
> > > > @@ -104,13 +104,60 @@ static int __maybe_unused tdx_spdm_msg_exchange(struct tdx_link *tlink,
> > > >  	return ret;
> > > 
> > > > +
> > > > +static void __tdx_link_disconnect(struct tdx_link *tlink)
> > > > +{
> > > > +	tdx_ide_stream_teardown(tlink);
> > > > +	tdx_spdm_session_teardown(tlink);
> > > > +}
> > > > +
> > > > +DEFINE_FREE(__tdx_link_disconnect, struct tdx_link *, if (_T) __tdx_link_disconnect(_T))
> > > > +
> > > >  static int tdx_link_connect(struct pci_dev *pdev)
> > > >  {
> > > > -	return -ENXIO;
> > > > +	struct tdx_link *tlink = to_tdx_link(pdev->tsm);
> > > > +	int ret;
> > > > +
> > > > +	struct tdx_link *__tlink __free(__tdx_link_disconnect) = tlink;
> > > I'm not a fan on an ownership pass like this just for purposes of cleaning up.
> > 
> > Yeah this needs a rethink. The session and the stream are independent
> > resources. It can be a composite object that encapsulates both
> > resources, but not tlink directly.
> > 
> > ...chalk this up to RFC expediency.
> > 
> > > I'd be a bit happier if you could make it
> > > 	struct tdx_link *tlink __free(__tdx_link_disconnect) = to_tdx_link(pdev->dsm);
> > > 
> > > but I still don't really like it.  I think I'd just not use __free and stick
> > > to traditional cleanup in via a goto. 
> > 
> > I would not go that far, but certainly I can see that being preferable
> > than reusing the existing base 'struct tdx_link *' as the cleanup
> > variable.
> 
> The latest implementation internally is as follows. tlink_spdm &
> tlink_ide represent independent resources though they point to the same
> instance. I'm already comfortable about this code:
> 
> static int tdx_link_connect(struct pci_dev *pdev)
> {
> 	struct tdx_link *tlink = to_tdx_link(pdev->tsm);
> 
> 	struct tdx_link *tlink_spdm __free(tdx_spdm_session_teardown) =
> 		tdx_spdm_session_setup(tlink);

The question I have is why does tdx_spdm_session_setup() return a
'struct tdx_link' instance and not a new 'struct tdx_spdm' object to
represent the new resources that were acquired? 'struct tdx_link' is
base infrastructure created by ->probe(). Perhaps 'struct tdx_spdm'
could be:

struct tdx_spdm {
       u64 spdm_id;
       struct page *spdm_conf;
       struct tdx_page_array *spdm_mt;
}

...and then tdx_link becomes:

struct tdx_link {
	...
	struct tdx_spdm spdm;
};

...and you can do:

       struct tdx_spdm *spdm __free(tdx_spdm_session_teardown) =
               tdx_spdm_session_setup(tlink);

tlink->spdm = *no_free_ptr(spdm);

...to assign it back to the preallocated space in @tlink, or make
it dynamically allocated.

struct tdx_link {
	...
	struct tdx_spdm *spdm;
};

tlink->spdm = no_free_ptr(spdm);

> 	if (IS_ERR(tlink_spdm)) {
> 		pci_err(pdev, "fail to setup spdm session\n");
> 		return PTR_ERR(tlink_spdm);
> 	}
> 
> 	struct tdx_link *tlink_ide __free(tdx_ide_stream_teardown) =
> 		tdx_ide_stream_setup(tlink);
> 	if (IS_ERR(tlink_ide)) {
> 		pci_err(pdev, "fail to setup ide stream\n");
> 		return PTR_ERR(tlink_ide);
> 	}

No strict need for scope-based cleanup if this is the last resource
acquisition, but maybe there are other PCI/TSM core things to do that
are not shown.

