Return-Path: <linux-pci+bounces-34855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524DBB378DE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549D81B673CE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBC730DD0A;
	Wed, 27 Aug 2025 03:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnirxDja"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2530498F
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266704; cv=fail; b=YRJ++CpItztbxbvP95XWPR0fQRDE2n0sBIfaB2dDRmsE+HVpdS8O/g9H8/9bmc6G+W8a7sgUxaReCtVMvFJdF2cR0awZOkdqf8w8T2EJeGfQgSJFWXWdeY/CL2nAbic826y1k++vQyf3WS+lnKqdkwSBO09iu+et7v4ExyVMOHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266704; c=relaxed/simple;
	bh=isYquUBgRTOXhvVOkuwFyf9kucOqksUZFOfApoSnEt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kKN9XivNMb4CRV70sjiCUrViBUPD5wiQLXoNlHLWWCpXo2SSjYYBttW9bRC76L4dIpc0Fm6mgqdviMeGYXaYpDbucqMITed3bDcaWydqmPVmBv1B8IGV9J3awTGMgtoUX/z3hKOafFCrFi3y3CFBYe+7pHNfLEZXhnzyC9ZnLBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnirxDja; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266702; x=1787802702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=isYquUBgRTOXhvVOkuwFyf9kucOqksUZFOfApoSnEt4=;
  b=TnirxDja2YXyDBA1KmF9VbEk/QWf+B+oBT7DZ9WuwJAzUzucjXNxn27t
   9Z1qrqmhHIdCGGYPBFxHQ5pElzrqktzz7hbVtkGb9ArU01WjNkViYWTj9
   2WJ+xt4cJeTbxwe+dil0nvega9pQYxqHl3/FnMrz+zAbulyhc/eH7At/p
   yL+CJ+23Cl51TVW89z8VqRhvgfonr4ce3BCFn4SOT1KKNRAu8mvlv0ZLU
   7FdGvItPRsN1kEUtAi7UVbdpat3PSophgOSjsoe1PpKvTdMsdpdTxJpeh
   KZkjp3dh6OYklBX6UtXc3nmGi3yS485GTXfkOQgycWgohp39D9pwPWbBg
   Q==;
X-CSE-ConnectionGUID: Jd7uCtrSQPWnJb9aEWHsLQ==
X-CSE-MsgGUID: 3A8Ls//iT6OiJnndLEZIcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62159176"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62159176"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:42 -0700
X-CSE-ConnectionGUID: vUTZ14sdTISJwKCm7CAp4w==
X-CSE-MsgGUID: jupFaPPHTqiF4jyt1T+YfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169685140"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:51:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:51:41 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.46)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:51:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edo5OFO4StynqoJ+WMpjkq/zOgbuLrU5AHRi/9qEZ3fx+Q6HIEjxvbm4BYko1Cqpbe2KYjJy316mpQZTJwGDMecCgK1cfOgP6m6Oe+8S8EwJEBW6LxMGezdxa7p3Cm21oMdgb2tN4hLZMY3QlEJMjhAsOupv4o8gD3Li/a7QBpXViy9udx0oFA0aohQJf3520XyP6Wwn5N1MV004J4m2k/p1kLIWgDSKDBIG7cTWvFQHfOgQn0MHFMqyAvy0RPiIJC1BdpzKBNHJSFiAGGG7Dxxwj3R4os1YsJMiq9suJyHqhWg+8oQH7XCMw6Cxl2ND9x5bJ+0OyHkIGriIJdTXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N69uqdpxCqhxrC7GbLOo5CfNJP+LkdQzr5X4q2mLR5A=;
 b=SK0wVT52OcThpp5pLj7sLaxL73pOr8jg+Uzp5uzjOB+5IlxmKrbBkVvvKTGHuv1O5cAeGhmKqjTTWnpKjsWf7eWbfXxDjY5a+dYuNXLq3OOh2oSNCqKEPWh7ejrya6t4E/WP070ttCEYdjibM1wcodHUIyJOSfnSoRMyN7xh14jD3Fzy4z2KZ5g+/b4sA5KqairsQdmB5MzDJkGOqQ4tA2j2qnU5+097jZMmVnDd1xSZjb2uvmHeYUjZEyBi29F7elKrM3tZbm7vjtTGQJgqrrs6mDvhP2gHYeLNfK29R1hgPnR2Cxv38P20YeZW561hpWndKf3MiM62wO5AtFZxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 03:51:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:51:37 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>,
	<gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>
Subject: [PATCH v5 09/10] PCI/TSM: Report active IDE streams
Date: Tue, 26 Aug 2025 20:51:25 -0700
Message-ID: <20250827035126.1356683-10-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827035126.1356683-1-dan.j.williams@intel.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:907:1::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cc0774-31d2-4640-0b7d-08dde51d05a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WNvQcbKqxA/wq02yIS9P0GfhQ/x1VExz5ZnRf0WNUIbCZz0hJ+vPpNfiMhEU?=
 =?us-ascii?Q?HKEbJhCFAdj9Sk43gdlf+m7tBB5QgjAEM1vny1fPHXAKI81KHK9yrrMfYU2k?=
 =?us-ascii?Q?5lZjUw9xRbaefdnjaadyXQo+JVvXfZ7Y3BKqSmornwFNlcgEAfu1V2wp1kss?=
 =?us-ascii?Q?SDIyr1Hd1GaxAKwWBuN/AkMX2yCe7EnA2etTjAgDv3I60Hk/YQF8MBXUSzZn?=
 =?us-ascii?Q?BLOYfyrCTVI+kvWY6lqF9LWK8DuVZv2YaigLcKgBekqE11BknejHRIgU3ozx?=
 =?us-ascii?Q?4GJ9V0nXxwcouaxv0oRoK5pIde+tDKHrZs6KcJdjeQpx6H0MOiK/7jihuEBG?=
 =?us-ascii?Q?2wKtZoPkvxpAoheLHL/SD7n+lwIdzvayOJs5ewtUpL310OJ6Inln5/2gCsbB?=
 =?us-ascii?Q?3mEqDm9hztD5nElOxqbVU3xIrvoBc4TQiEwDov2xux6VrR36AeA/zHtIflBc?=
 =?us-ascii?Q?nWMn9n760jOgQOnDcE6JFipkUrpU7cKWaOLMyqbcvg0zfP3AeooXOa3cGlkd?=
 =?us-ascii?Q?bXt+uBcXz2aOOqehED00r3kP9AYqXUduW1DOY7ySKV7VJH1LgUYJ0v1w8CY9?=
 =?us-ascii?Q?fPC5bD7gGAR3eFqwTEK0jFlz/lSz2JywWsShUBFqbBgoowChrkgwAvHMLUor?=
 =?us-ascii?Q?4ksDVPrC4zEYZCEwbvJnPUiY00g2aFF/zRvyNFN7AJm7uYwlcxNLv57gSMRv?=
 =?us-ascii?Q?rZcCJP3taDX/9CR5I/oCounuVaRaAF/jr2zAW22jUU4mD+5nV2LDMCtKZASk?=
 =?us-ascii?Q?esSwZrk/Q3fDIMJ+dKLBD3NENpU8tDRlrtAdqxadWaeONRLgtidCQ8Hm1kv4?=
 =?us-ascii?Q?zC8t5UwugYhnBy6ZXIj/Bln/l10zxopf5jRv4+MMuLqhVhabhp7/UXMIHS3q?=
 =?us-ascii?Q?v8SytBY0CQ5n/rYdzTZgUgMN/mq+Qv4wt3sjck/mQArfJJqeonOfuXK3/Zgc?=
 =?us-ascii?Q?QQ+zu3ZvUD1YGPVvQnqoWmu7qnOfIns1reA5EqWWK1LTjiUn48BwY+9iEVAj?=
 =?us-ascii?Q?Mq30rqA6tqjQ4ap9ApNGBu6oON8TCfumAR2Rw41icenyHNEuhz9Yt2Co2d1C?=
 =?us-ascii?Q?9fgPox+3i7STmga6f9jRnP8R6eNGTJq5npeEajcdCs2ZZr2VmhS5xJaYdSh3?=
 =?us-ascii?Q?aoJMwiTHPY2xsUMDFTn2MMSzVKpsKuAds7/Kfv9OiR2/2vtxqcnbvL9SXgVz?=
 =?us-ascii?Q?c24quvQUN3Cn6/rl3RgiQxN+/b3q1nZtp76WCfFn0BQsgERvuQZpQTyg0bsr?=
 =?us-ascii?Q?wTx9A+ZmS2dV+UdVjazWzt+DfeEbvUyOVitAwfIkSCIALGC4ILoZKumSw0Z6?=
 =?us-ascii?Q?eMYrB/EfkbUfb7t2xBYzZEEVP9raC/Dr46VWLxBUIagOPcFmhdKG4Ma0o1EA?=
 =?us-ascii?Q?OS8G2N8tDzEO3tn5S1fIWEp69TTlA0EltcaksWnjwQl+mw2dI4N3wT9rthuC?=
 =?us-ascii?Q?IlY+UX645E0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4GT2/Dhcgu68fNq0gnCso5Qk0282KBs2X0v4Eq11oy7JqaG4KvylmTVzhZYP?=
 =?us-ascii?Q?q6lhPo5y1B1DpsGpbCaUPlSwlju/M5N5yDJ/dlRKOJUAHYrqAFqygoKC7KLT?=
 =?us-ascii?Q?jiKoij1xNdevwZTVg5IW/JUpWid2ujvj0mLiHfpor3uxaaC9lWM3RTwfHr1p?=
 =?us-ascii?Q?0uaeJojJnx2fqhgEmljkYcPKkgaELF1i1tWCC0hc1h7P9338kNRlIiogyA4B?=
 =?us-ascii?Q?VwVGGKfKFJIvaQIocdZS/wsIfbdkwAuD9B7Xnd0Dh7SP4lpFmFO3D4yQ8t1h?=
 =?us-ascii?Q?33v/NevI9eXU64Ya9lAEio4EwXhyt6xH58VxtQCHdGA2ikHCcA2gcn5EzpGV?=
 =?us-ascii?Q?9pm4WYARiaj5CGuKwd4gA3R9vCl9VKVp5lgCJahU817o6inRL79tgTaJV9RQ?=
 =?us-ascii?Q?9hhmILbV0SM0C18+Gh55fsMmDlj6O8RRyQztpxqEXXqDKs03b69eWyxl/4oB?=
 =?us-ascii?Q?yYBKN/+8v7G+UpqBlLcpPJz/V+ZNoc8m4g9AH0mcJ7B3oU5OQNopkCzASWHx?=
 =?us-ascii?Q?h9e3VaIK3TuOFTNhzUjbkjN+U+UfBmisNDCqn86yyWUTf9GY95YY/a83HK/2?=
 =?us-ascii?Q?INJXJzdO6evFHIQ3xdsWETxf9bWtWUHvBvH2olgZciRUquf+XqsxDqYqIXKd?=
 =?us-ascii?Q?IKNN/sNO4Kme5RVuhMTnbfC557n75Fc9rKFZE0U0IqwoPxUR4G81ambg4d3y?=
 =?us-ascii?Q?lVkz0oq3lsNJNlGTrjvG/lEP+FdtKONBmjDOyvJlG8P8FYCieQy3SQbcN11u?=
 =?us-ascii?Q?pDcqh1v3TXW9IFUHCvxHPsSn01AOqgDQYmRjD36oe5gSlGrQ+pbCoAZgk/Qj?=
 =?us-ascii?Q?YG9Y3wak1Kzur1fKhjlDNUXBI3bj4g+4WR96wIz7DJ7Orl4GNiQ6Wv9NjWit?=
 =?us-ascii?Q?KCkvVPF/iJ+v4iDdqQDHA9clJ5fdXFw4UhXPCw3FdGTZOp14LU3fzOgEsjBZ?=
 =?us-ascii?Q?CRnTIfa4KvMlILVwlRmXHO84EH9rOV7Td395WDwVYutklCO8presryHgojSa?=
 =?us-ascii?Q?nSNvU7SsV2U3IaDrFITBIJyAqwmtjOLz+CzHsfXFtw7+34CLtBV7WAws9CY7?=
 =?us-ascii?Q?waNYjAYCCyGAzQvlVGOQQGDMnCIx+dVcK0YPIvhcLAALP5HO6CnilDeNDaMr?=
 =?us-ascii?Q?EtwRC8pI205EFL+kHr1pm8bcxcf56ptmNQWIU0nAYAY5Dq0v4ODeGIyTSItp?=
 =?us-ascii?Q?xdNn7iyscbZYFLPddt+jdgGSFBch3+b8Ps6Co8aMnKmZ6RIgbju3U/H4mo77?=
 =?us-ascii?Q?/5nb6Dxk5ppgy5J4qhyH8XtrF2fcsBMFo8po5TV9tGtD0wW3bj0h6MtHYztc?=
 =?us-ascii?Q?giUKhjCcPBVZvsA9GuQi7/wOIxOBEOS4U0t694HMFvlCegmcURUxQ2Ku+HRk?=
 =?us-ascii?Q?qMtP6wNweLgiSYF15DczV3DsVGK28/89cPAQqA40hPTdfL4Gyz99zQ701D9o?=
 =?us-ascii?Q?d054aH2UQrihI3MW4fc40juTLDHvPCwdYp5BjChBWfjWEMgULVzNNIgVJZQs?=
 =?us-ascii?Q?HeufmiFctYHP/t8iJTHgWNqWty/faoAXNC3+SbEcvnNNAKUHuY6LnDz5nk6v?=
 =?us-ascii?Q?WEuKyqJLZhOuSUZIMyJBLLmlC61nj3N0zCtUVyV4gwykIcT4U2+5P9+zouzA?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cc0774-31d2-4640-0b7d-08dde51d05a7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:51:36.9731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxSWngB/f4ZIubz+cqVjFmPATfCZThswXwJYddQ6GdFiDFpHrh9qm5J0gZpPwwPSjLOBkHX0j3HT+XfYbn+BXPu35H5SH7S95kjeOkwpmQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

Given that the platform TSM owns IDE Stream ID allocation, report the
active streams via the TSM class device. Establish a symlink from the
class device to the PCI endpoint device consuming the stream, named by
the Stream ID.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-class-tsm | 10 ++++++++
 drivers/pci/ide.c                         |  6 ++++-
 drivers/pci/pci.h                         |  2 +-
 drivers/virt/coco/tsm-core.c              | 29 +++++++++++++++++++++++
 include/linux/pci-ide.h                   |  2 ++
 include/linux/tsm.h                       |  3 +++
 6 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
index 2949468deaf7..6fc1a5ac6da1 100644
--- a/Documentation/ABI/testing/sysfs-class-tsm
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -7,3 +7,13 @@ Description:
 		signals when the PCI layer is able to support establishment of
 		link encryption and other device-security features coordinated
 		through a platform tsm.
+
+What:		/sys/class/tsm/tsmN/streamH.R.E
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) When a host bridge has established a secure connection via
+		the platform TSM, symlink appears. The primary function of this
+		is have a system global review of TSM resource consumption
+		across host bridges. The link points to the endpoint PCI device
+		and matches the same link published by the host bridge. See
+		Documentation/ABI/testing/sysfs-devices-pci-host-bridge.
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 7383ee542972..3f772979eacb 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -11,6 +11,7 @@
 #include <linux/pci_regs.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/tsm.h>
 
 #include "pci.h"
 
@@ -272,6 +273,9 @@ void pci_ide_stream_release(struct pci_ide *ide)
 	if (ide->partner[PCI_IDE_EP].enable)
 		pci_ide_stream_disable(pdev, ide);
 
+	if (ide->tsm_dev)
+		tsm_ide_stream_unregister(ide);
+
 	if (ide->partner[PCI_IDE_RP].setup)
 		pci_ide_stream_teardown(rp, ide);
 
@@ -551,7 +555,7 @@ static umode_t pci_ide_attr_visible(struct kobject *kobj, struct attribute *a, i
 	return a->mode;
 }
 
-struct attribute_group pci_ide_attr_group = {
+const struct attribute_group pci_ide_attr_group = {
 	.attrs = pci_ide_attrs,
 	.is_visible = pci_ide_attr_visible,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 22e0256a10ba..716eb7fecb16 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -521,7 +521,7 @@ static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
 
 #ifdef CONFIG_PCI_IDE
 void pci_ide_init(struct pci_dev *dev);
-extern struct attribute_group pci_ide_attr_group;
+extern const struct attribute_group pci_ide_attr_group;
 #define PCI_IDE_ATTR_GROUP (&pci_ide_attr_group)
 #else
 static inline void pci_ide_init(struct pci_dev *dev) { }
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index 6fdcf23d57ec..f5bab1a9c617 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -2,14 +2,17 @@
 /* Copyright(c) 2024 Intel Corporation. All rights reserved. */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/tsm.h>
 #include <linux/idr.h>
+#include <linux/pci.h>
 #include <linux/rwsem.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
 #include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
 
 static struct class *tsm_class;
 static DECLARE_RWSEM(tsm_rwsem);
@@ -124,6 +127,32 @@ void tsm_unregister(struct tsm_dev *tsm_dev)
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
 
+/* must be invoked between tsm_register / tsm_unregister */
+int tsm_ide_stream_register(struct pci_ide *ide)
+{
+	struct pci_dev *pdev = ide->pdev;
+	struct pci_tsm *tsm = pdev->tsm;
+	struct tsm_dev *tsm_dev = tsm->ops->owner;
+	int rc;
+
+	rc = sysfs_create_link(&tsm_dev->dev.kobj, &pdev->dev.kobj, ide->name);
+	if (rc)
+		return rc;
+
+	ide->tsm_dev = tsm_dev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_ide_stream_register);
+
+void tsm_ide_stream_unregister(struct pci_ide *ide)
+{
+	struct tsm_dev *tsm_dev = ide->tsm_dev;
+
+	sysfs_remove_link(&tsm_dev->dev.kobj, ide->name);
+	ide->tsm_dev = NULL;
+}
+EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index cf1f7a10e8e0..c3838d11af88 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -43,6 +43,7 @@ struct pci_ide_partner {
  * @host_bridge_stream: track platform Stream ID
  * @stream_id: unique Stream ID (within Partner Port pairing)
  * @name: name of the established Selective IDE Stream in sysfs
+ * @tsm_dev: For TSM established IDE, the TSM device context
  *
  * Negative @stream_id values indicate "uninitialized" on the
  * expectation that with TSM established IDE the TSM owns the stream_id
@@ -54,6 +55,7 @@ struct pci_ide {
 	u8 host_bridge_stream;
 	int stream_id;
 	const char *name;
+	struct tsm_dev *tsm_dev;
 };
 
 struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index c99d85fe56f4..749824498f32 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -117,4 +117,7 @@ void tsm_unregister(struct tsm_dev *tsm_dev);
 const char *tsm_name(const struct tsm_dev *tsm_dev);
 struct tsm_dev *find_tsm_dev(int id);
 const struct pci_tsm_ops *tsm_pci_ops(const struct tsm_dev *tsm_dev);
+struct pci_ide;
+int tsm_ide_stream_register(struct pci_ide *ide);
+void tsm_ide_stream_unregister(struct pci_ide *ide);
 #endif /* __TSM_H */
-- 
2.50.1


