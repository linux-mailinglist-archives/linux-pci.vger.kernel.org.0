Return-Path: <linux-pci+bounces-24864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAABA73731
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB82D3BD696
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365951C6FF7;
	Thu, 27 Mar 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fIf647ry"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F01AA795;
	Thu, 27 Mar 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093813; cv=fail; b=lvQTyyA4N07sbzCVPh0ZrvToUVY1Mce/BIaDSQZ+TY4qsBEZuCvnalvLlnFAtw2hgTtMtlwKA1uAm+kcMq2DSB2IU3Bis7hcjSzmpLuchcxCxB0wag9VKc42vuOTbKGvDKiOgrTBcrzHxct2oT1tHrNsLb9pph7R6W7rEauiG18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093813; c=relaxed/simple;
	bh=PR2eT1X4Swi1OCbVK02pRx+ys1XnHYkKKsaTi93CvDA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MDcFaqCDnpb4oWR49WpefVsxIYFbrseE85UaYwk+5ezMnfGW1WyaWjwTZ3Z1om2ssQ/OTW0iCI2g79ChhqiVln8QY2koZwRo/iupAfG3WlGcXqiCLCABqNZO/HR8i0qZ6EX17NM/JykHHJ+mhmZxd7BF6CiKO6yzSBxjGmZQfgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fIf647ry; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743093811; x=1774629811;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PR2eT1X4Swi1OCbVK02pRx+ys1XnHYkKKsaTi93CvDA=;
  b=fIf647ryQXW50pMm2z5GnK95fP/pHdw9GdJtYIetysMn/+eKyfVwvLhu
   eeYQfOq0WE77g0/9RuDMruOpQ3QQ95H+rQve77NMdOPt4dRMNOaqGh2WS
   LZnkFnoEXCbHdtOKsZDHce3AtN9c3AnCGsnbWvilBMmgnsgIWKNcDDNRk
   Jia4OjZPDsDg1rLS6oR31LocEHwirqcCHld97E8PMuVUsytY+Qmq07NZE
   yP83K6u0rTcuf28FQQX23IgzFd26eTglKMRIkQOmFaXKwR3LUgTGCaRQH
   a/tnGXtXPM0glF26yEVSwvp6HYiNrv7+7NVDslUko95HWrUYco2KFB28T
   Q==;
X-CSE-ConnectionGUID: 5Owlr1DDQfqfh9roZKNvZA==
X-CSE-MsgGUID: DVEHbbUQQPWXshSBVi3aiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55089339"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="55089339"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 09:43:30 -0700
X-CSE-ConnectionGUID: HCgXPAMKSqOZ+YCrreFc0g==
X-CSE-MsgGUID: 5caQqhSATeijj1n8S27qKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="126006676"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 09:43:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 09:43:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 09:43:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 09:43:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maWOXvu/I5afhe/hLpBUyIitC/vfZw4FW3yvX5AUI5+RxShPym3hJkN7wzlhz27ZUNNKlQ5qmVAYT1vz1DhtHgc3VhjznByCPG12NgWxuJYBuxTk4M7JOJB02vcQqi3Z2OY7Q/8kPsbvGdGUnDRalFj+eg6JjSysPypkfroZ+WmXcThkmoGO7LweBS2YVCFD/h14aWQ9CiSopmamYTzaBbvkIb8X4qg8/VsZ8SIrI7IKlkHQwrFAD0X4oIpS2UXGic0pHK4T6ikdgQZLLEMzXT+YyqdRtAeNSYapzRqzQALLs1r2EtgV2RUD7pWJE4aiFa4rn1j1kVqljvbU2kHwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0aUed0z5O0pOn8rNWsqYZipNibZBQTczCkJjtv3JDg=;
 b=xvEcb4aef5E4DVFq4HW7muo4UgmXAsNz7Q0KCP2z50SdkN++rzbOPOtpyt/y50tMvRlktE24+mOucir9gDqgQ71giAX45Ekut8jHFlFO/RJmo5ADDw/NeFlU1g1PUcdfczGfxHjoxDgFd8om1BGM0u14zu1LDPFxLUosVLxOJ3bF1UtffXD5IhBlESS0QAWSYeg/CVx3beZlIZJgGVxgVvh3FgIO72boZNsw9qPEcuQtdklF0A8wAUlarwGPM81RN0gSc9zhHJzMTo7eLzwWQ1ylexre7oarN8XLShCAmg3O93NJ68q3f4fSp7m2lFFSYS/a+9dGQzGbBg0bJIIU4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8465.namprd11.prod.outlook.com (2603:10b6:610:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 16:43:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 16:43:23 +0000
Date: Thu, 27 Mar 2025 12:43:19 -0400
From: Dan Williams <dan.j.williams@intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>, <bhelgaas@google.com>,
	<tglx@linutronix.de>, <jgross@suse.com>, <roger.pau@citrix.com>,
	<pstanner@redhat.com>, <andriy.shevchenko@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH] PCI/MSI: Fix x86 VMs crash due to dereferencing NULL
Message-ID: <67e580273996c_13cb29480@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250327162155.11133-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250327162155.11133-1-Ashish.Kalra@amd.com>
X-ClientProxiedBy: MW4PR04CA0129.namprd04.prod.outlook.com
 (2603:10b6:303:84::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c367e46-cef5-4bda-c4cc-08dd6d4e7d24
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ePkVmgAfZZ/hdSp9jRpIg0Idme8H1WmFp0/TqkHc7n+jzVtAX+0mYGxnecVV?=
 =?us-ascii?Q?G65hghUhCojESZ0jLr1s+8/Pfn/48xPcNagZV1TvoYLh9spm7goCORCeWYFL?=
 =?us-ascii?Q?0y459w7Pbp+zTQu/wDdmij2epNCqFDPoSM0xFFO0H3w6g9w1G2oZmadqqmlw?=
 =?us-ascii?Q?yG23PyLmtSF7Lo1SCA5qrVEDRxO5qoeWjIyUOY8rXvaAnUOrSA0na16kqqPo?=
 =?us-ascii?Q?SuKODueHhI1WI9lAx8PP50US2xAvOwidjuU0u7r/A8iOGHJLYIQc2iUmgOcm?=
 =?us-ascii?Q?G4o4TCP46Xp15t9C1r5B5nrianrTVGt88of7ZYa43Wli8kCmxSvShZ6HfyYs?=
 =?us-ascii?Q?CZWNv6/K4JJ07e9NS6OWWmcU/2Sr0qdymRmBu393wjWbue6Zn6xURbXzw6BU?=
 =?us-ascii?Q?KlvCIGEDqzaYkKkZjXqvp/hwdaCL1N3CyiOu5WwWRZ7UQhznyNLHLRek10Ta?=
 =?us-ascii?Q?KB4Ufjk6yEKIxhrX6GLBaUlbz3rAK+jj+vPZFw6KvYKOSjrdJ97PHWMqUb86?=
 =?us-ascii?Q?JU9A2X2aamjLNmU+7qqSRRl36zNF5UkXdGAKV2krkBHHKTZ4zMvFfuGvAl5V?=
 =?us-ascii?Q?97M22kJlynxi6nnQMT3yWZpFWaGK5t0pVaix1eG4cNjvPJZZz0EPDJJC2r4P?=
 =?us-ascii?Q?Zu6N+F4VhkLIxJcLYRSmL3oKw5IgrYjVDK+DzPpeLiebjG9ux9H6XxnriXdr?=
 =?us-ascii?Q?muBz6kqwgGw/pzJahNmA0h/CD2dEQSvssfRmEgQozp2iUVuQ9LME2J63cg1N?=
 =?us-ascii?Q?FwnPTLDvKGg76WoDct0adMaQFAKI3tig3run8fHdDwIrvYfR1ckjZK8ikPb5?=
 =?us-ascii?Q?C/Me4mOK7ZCuV9B4b8aSmtRtc56rFpQUh7mhCEez8sGMa6tl+4UgBHQ1Qvag?=
 =?us-ascii?Q?HxzeCxlWxriZQLXHJdelQWNbDM3f63AN5GiAj3j9SamRm3iuNZmhC3jkEz3V?=
 =?us-ascii?Q?yAmKT0KtYxFH4ZwBztTW0BL75twf0YR135l5JlHQ6tUsPZp4WOF2bRUvKUMP?=
 =?us-ascii?Q?qg49aRElMIx63iyrEBsVMr0jssNVcwzmynXSd8GicgeUGdKTQJXZ31yOzoGI?=
 =?us-ascii?Q?SrCxkl6LQjPKdglc4t8zOPa/h7twUk1Q93v4ICyP3mX+bsfwBvP6CCmVfJ1+?=
 =?us-ascii?Q?aAopU1ljE0++CHidXvhM6+U0/NM4ipJL9HJX+Jvwgmz0UAbRqctYbalxu61+?=
 =?us-ascii?Q?O8GRp2va/H/ZLzsZZLqsrgbL7oEMTzEQxHF8p6QOQQnyWHt7i1c0/S5edF8q?=
 =?us-ascii?Q?YIaFrsG1oMYWmKgXxnD20acitoUoQCyZmojU851cTIMbSE+5s32HKYGoFX4M?=
 =?us-ascii?Q?t3GeYodkmLgq/BTDIXUOKi+CrolX7i9oCQrgJuryY9Z8Pf2R1FHywCRSMDNX?=
 =?us-ascii?Q?hFBbbx0zs87TBPrBW6ftHxzLdTVw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/L/eD3A30ees4+lnQcZIw4MLvmfIlcMuWtdNVmmpNSXYdQbv5mPGoTJdQWjO?=
 =?us-ascii?Q?YDNDXDGeO90qBjmpfnn1as1BnDK3pxRbvAnXaNfBMCiUQappeAVz/fJVywNv?=
 =?us-ascii?Q?sKFZE+afrIPEwhlGu6gqCO4ytyjOyTkZDJuAHqkvWIoxZIUE/xmNn9Z1sF3b?=
 =?us-ascii?Q?EZcU9idssLGxOdk5i9LoyX1QwXvHC+KNuy8Hg6y9L37j2gNQHacGruxPAvPw?=
 =?us-ascii?Q?sd8hT8hK/imFQr2bwzFymZSQ8o3qZVMEFYsv7f5bz7ifFAs7pjgswalIoJiH?=
 =?us-ascii?Q?M9tsHPXLa5/cEX2Upx6WQ0eA8sLaXK2yUE53aCYKtDcWA4Y7Ukrt1rtnbduM?=
 =?us-ascii?Q?P8F+ylyAsk8el/R9LWsJQCPvlLsCRVL5cgeMYbmSX4lxcpwbf7fSOX/eGSDV?=
 =?us-ascii?Q?hL0pYQztHPV2c+mnUp/jN/zL3l72+LgewgxsqtCVoySE9uo5qtqvLU/dGF3x?=
 =?us-ascii?Q?gnAxnttCN1Oa2rFBm2dPhYgLqU18+GUF3a2Q2gT11NsKS8ONeMgaWrpm9uN9?=
 =?us-ascii?Q?GqSkHkua8HIe5hYW6DdMUxEt6F4rA/FKRgy4ndjQwVWG6X4Pq2SLO53TKTlM?=
 =?us-ascii?Q?FQwwVcDe91KklvkhLuokbWiK+g0K7GvkWEBUZlicPpH26DBvLmhBKam8p0p1?=
 =?us-ascii?Q?9Na+EkOiml0kCrwkZzPH9HSB8EO8g+4Xr757CLTcxgm9nJssgUYWdTDLlyMd?=
 =?us-ascii?Q?oX1eKEXtzlQpdIiYd0B5YSIJc0Gko0mA5qfxjJapw3RzIL3p32CdqRERkPJl?=
 =?us-ascii?Q?jIMI/UXrE9C3XjH84U6WiT8AvqaydQs5nicXKOYL8juNb1Hh0VyzlklNUsCV?=
 =?us-ascii?Q?l9DUBGQSItcUM1uFzuwToPKoe5VyxBDB8NklIrPuCC9Dm7HYl6lbM3vBZnQ3?=
 =?us-ascii?Q?9T1BftLanB/7FQlm4KNaos44l7luQHP/G4m6nxYtKEW/JSL6i1GJ2mf+CB9C?=
 =?us-ascii?Q?hzC/eccFuxbTfb6DtTLoYqKygGMbmds4CSsrBQMxYQ4/17eFB0Ilx5X+RaNX?=
 =?us-ascii?Q?Zijj3uO2Dz6M2ZE8iSnOTjqfbU19wmmMCuymh33ygjk1aDXn53PQXpw+9khv?=
 =?us-ascii?Q?ZvLb2+SAlRFT1NZmutH0lcHxRK6ifwnh+qxzyg6AZRTtGQ5fFVrYL9wPDLar?=
 =?us-ascii?Q?kNowKI94vhrY1vChGtJSX42Jj2xEDez/Vc966keukhYNxNFvez6FES0fq4vA?=
 =?us-ascii?Q?IlyszqdawmDe8c/3+6sjWQ4qIgA+Z3NkWkatMg1h1vtivDoczkuwOBfUcael?=
 =?us-ascii?Q?QhUrnCB35Wo4dLnJtjUIein8MXGR7S4GgMAcfWArM8SNhuaO0pR/Ew/1AhD0?=
 =?us-ascii?Q?UwqOavrPAF6LhnaeVAco8uGm3NJR/ooWElFdZuQKdLB8lXRpL4HkBFGav0rH?=
 =?us-ascii?Q?hoKXP+4PQf0aOJbpgbaLWVgFk/AGEcHGUrVpXxpQi68LsTJE6G91cPlRPE+r?=
 =?us-ascii?Q?qU9ZMsUQvKjyPsiZM+xjYM3M8Udh0FnqOUiLjeFAkuT8EkFZmhOWDAkPaSqQ?=
 =?us-ascii?Q?LwUuTtcv5gWCvdZiLXXI3wJUvQ+1jnhIVELdiMY5hkM/U8/2AevNeDWThz5s?=
 =?us-ascii?Q?2OzGuWwasxeyJ6N6OLgW/lTEmoYkGzK3336HAVh9TfcFs6urZpDhoZeXGeud?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c367e46-cef5-4bda-c4cc-08dd6d4e7d24
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 16:43:23.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+b5J2PtyUOtfFpMUD7qBKGQYs9KiH+G3wTav6try//4TZ+PQXGRdf/r893dbWddAIHFrZNLP8tSe33lBN476S3YZiQf3G1lWQcyfmrswKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8465
X-OriginatorOrg: intel.com

Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Moving pci_msi_ignore_mask to per MSI domain flag is causing a panic
> with SEV-SNP VMs under KVM while booting and initializing virtio-scsi
> driver as below :
> 
> ...
> [    9.854554] virtio_scsi virtio1: 4/0/0 default/read/poll queues
> [    9.855670] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    9.856840] #PF: supervisor read access in kernel mode
> [    9.857695] #PF: error_code(0x0000) - not-present page
> [    9.858501] PGD 0 P4D 0
> [    9.858501] Oops: Oops: 0000 [#1] SMP NOPTI
> [    9.858501] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-next-20250326-snp-host-f2a41ff576cc #379 VOLUNTARY
> [    9.858501] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
> [    9.858501] RIP: 0010:msix_prepare_msi_desc+0x3c/0x90
> [    9.858501] Code: 89 f0 48 8b 52 20 66 81 4e 4c 01 01 c7 46 04 01 00 00 00 8b 8f b4 03 00 00 48 89 e5 89 4e 50 48 8b b7 b0 09 00 00 48 89 70 58 <8b> 0a 81 e1 00 00 40 00 75 25 0f b6 50 4d d0 ea 83 f2 01 83 e2 01
> [    9.858501] RSP: 0018:ffffa37f4002b898 EFLAGS: 00010202
> [    9.858501] RAX: ffffa37f4002b8c8 RBX: ffffa37f4002b8c8 RCX: 0000000000000017
> [    9.858501] RDX: 0000000000000000 RSI: ffffa37f400b5000 RDI: ffff984802524000
> [    9.858501] RBP: ffffa37f4002b898 R08: 0000000000000002 R09: ffffa37f4002b854
> [    9.858501] R10: 0000000000000004 R11: 0000000000000018 R12: ffff984802924000
> [    9.858501] R13: ffff984802524000 R14: ffff9848025240c8 R15: 0000000000000000
> [    9.858501] FS:  0000000000000000(0000) GS:ffff984bae657000(0000) knlGS:0000000000000000
> [    9.858501] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    9.858501] CR2: 0000000000000000 CR3: 000800003c260000 CR4: 00000000003506f0
> [    9.858501] Call Trace:
> [    9.858501]  <TASK>
> [    9.858501]  msix_setup_interrupts+0x10e/0x290
> [    9.858501]  __pci_enable_msix_range+0x2ce/0x470
> [    9.858501]  pci_alloc_irq_vectors_affinity+0xb2/0x110
> [    9.858501]  vp_find_vqs_msix+0x228/0x530
> [    9.858501]  vp_find_vqs+0x41/0x290
> [    9.858501]  ? srso_return_thunk+0x5/0x5f
> [    9.858501]  ? __dev_printk+0x39/0x80
> [    9.858501]  ? srso_return_thunk+0x5/0x5f
> [    9.858501]  ? _dev_info+0x6f/0x90
> [    9.858501]  vp_modern_find_vqs+0x1c/0x70
> [    9.858501]  virtscsi_init+0x2d2/0x340
> [    9.858501]  ? __pfx_default_calc_sets+0x10/0x10
> [    9.858501]  virtscsi_probe+0x135/0x3c0
> [    9.858501]  virtio_dev_probe+0x1b6/0x2a0
> ...
> ...
> [    9.934826] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> 
> This is happening as x86 VMs only have x86_vector_domain (irq_domain)
> created by native_create_pci_msi_domain() and that does not have an
> associated msi_domain_info. Thus accessing msi_domain_info causes a
> kernel NULL pointer dereference during msix_setup_interrupts() and
> breaks x86 VMs.
> 
> In comparison, for native x86, there is irq domain hierarchy created
> by interrupt remapping logic either by AMD IOMMU (AMD-IR) or Intel
> DMAR (DMAR-MSI) and they have an associated msi_domain_info, so
> moving pci_msi_ignore_mask to a per MSI domain flag works for
> native x86.
> 
> Also, Hyper-V and Xen x86 VMs create "virtual" irq domains
> (XEN-MSI) or (HV-PCI-MSI) with their associated msi_domain_info,
> and they can also access pci_msi_ignore_mask as per MSI domain flag.
> 
> Fixes: c3164d2e0d18 ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  drivers/pci/msi/msi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index d74162880d83..05c651be93cc 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -297,7 +297,7 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
>  	/* Lies, damned lies, and MSIs */
>  	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
>  		control |= PCI_MSI_FLAGS_MASKBIT;
> -	if (info->flags & MSI_FLAG_NO_MASK)
> +	if (info && info->flags & MSI_FLAG_NO_MASK)
>  		control &= ~PCI_MSI_FLAGS_MASKBIT;
>  
>  	desc.nvec_used			= nvec;
> @@ -612,7 +612,8 @@ void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
>  	desc->pci.msi_attrib.is_64		= 1;
>  	desc->pci.msi_attrib.default_irq	= dev->irq;
>  	desc->pci.mask_base			= dev->msix_base;
> -	desc->pci.msi_attrib.can_mask		= !(info->flags & MSI_FLAG_NO_MASK) &&
> +	desc->pci.msi_attrib.can_mask		= info ? !(info->flags & MSI_FLAG_NO_MASK) &&
> +						  !desc->pci.msi_attrib.is_virtual :
>  						  !desc->pci.msi_attrib.is_virtual;

I think this would look better, and more like the original code, with an
pci_msi_ignore_mask() helper that takes an @info arg and returns bool.
Otherwise, this looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

