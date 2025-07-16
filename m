Return-Path: <linux-pci+bounces-32287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDF6B07AB6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F401F1C24BB6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A117C1A238C;
	Wed, 16 Jul 2025 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6Y5KcmN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4647F2F547B;
	Wed, 16 Jul 2025 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682133; cv=fail; b=hLk1Bw/8TGVhL8mDPKykHj7KPNOz7eFW79VpXCeHiZc8tE2csYd3GvbJ99tfLBXUqXyX6HeN4PGd+CXWKkjDhkYgRRhYEec83oFZDIrgxXaJHn2R96ADdEfp3wAbJR1O59ZRKV/tMUscUV+7SvTv2r4Baie7/P9D9/l0AvjIh+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682133; c=relaxed/simple;
	bh=IFZ92FL+9rS6LgAc08DaxS6euR480ba8IrbIknrIA6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tI8CN4CVhdtqKBRxBBacwQh3DiQCjE/meYqPlGve5yc8cLXS2FiKxiVCSbk65yU5U91TYRkvYll24HAvrdIeXaNGrC0V4UWFvFFhAtdpQGyhFTVWp7vLaGcBDS6C4eoxMszUKOVvDOX7cWT5vbTY26bLww3SsVK2OK34Zqpe1YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6Y5KcmN; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752682131; x=1784218131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=IFZ92FL+9rS6LgAc08DaxS6euR480ba8IrbIknrIA6E=;
  b=J6Y5KcmNPoVWqZCfmk6KfXN5lECt2BIdGR48GAzCBLGZgsoAocw6IwvF
   /tMRZkWkVO2mDxYYFrGnknD/7P0Jd6zUll5wQcASMaaJodQ+dGyuwkc00
   ghiPFyCl2NUQDeh4O0KKhv3j08EtXgkGGuLUWsm4UniZgQFAbMoGoxssD
   woqTTj7MpPex7j/+WepNAYTNF394n+Ue8gx8MSDGUPFCiwWrTyhlaH8yd
   pnxIJc8HCkXaLZiRU26p1PRDvo14HQ5EoG01o/KeFc08PEwDqyitJLpQf
   JlwEe//3NZ5xZomL1NfZzxu/Dxuk4nFLbTlk8fkmRKw3KOnXweC5y+g0X
   A==;
X-CSE-ConnectionGUID: RvbAZ+91QsqLymB8aZPb6w==
X-CSE-MsgGUID: 22uijkGZQX2FXW9bf5lRVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55028191"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="55028191"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 09:08:48 -0700
X-CSE-ConnectionGUID: Jp2HyWEZSWChLa/wtiHfeg==
X-CSE-MsgGUID: g+LUq2FNQ92AarPR4yQjMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="188494747"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 09:08:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 09:08:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 09:08:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.80)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 09:08:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJs3hO2YamwkdeyRord3F0OcNFVAcIpc9o4KeFUV6wagLKxuXRIkDYVq3+lSqrR1M7shsnzx2sClB1c9l9ZSkuZzWFdL07jCROYnFYAzsqDk5iZ3c92DfrQg4uNJ6cQQCWpFM3tGyQNsgfB5tdLYV1mqz1CVNpTl4EiqJJbPuW4U9d1Hs4nnMXVS8mb1MKai1r6+PECDEl7Av2hAWLy523FInDSuXLxl1t5fptKhvOKlR9tRr2Is05VzfDXBfCEBpPm9UO02bwyTS0Rqz7tqWTOFBOZn6PqINX5m085iA56Ok1h6awqB6DelgnxkwkdAr6tuy/1w20WXD5vUsr2x+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SJbWuTauBEnlcdeV69O/OJ2JQCfRkD1+7IISQU3rAo=;
 b=V7dEUZg7Y5QLjqyt38RHOYhKJL14mSMVDdpyezI/HqKqHtCo55lKDGjSXqKMUnOWtG92sO1rTN5WloitHH1oqlxI/1Ji5v7+BIP0eb2PKUOepVE1bQDQbZ6AMmfuG6K4uyEHoWaq44NzYxL2oR/cHJQH8QfdDL/1xANSrcgsGDxm1JnMT+AeFHCKqDzEb4G0UbLGdcJIgEgQRD1CnFvQyq17ak8g4tAp8OkefyVuqdlhcibysKyHm6PulVlCRk45TGDUcLLEy5nYsjPX2/sE2zk5FXkK+Nzgni6Pwq8J+3mli1cYUnUVph6ePfAvMiok0tenymFq1Hwwwa23UIV2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4954.namprd11.prod.outlook.com (2603:10b6:806:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 16:08:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 16:08:39 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
	<linux-kernel@vger.kernel.org>, <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/3] PCI: Establish document for PCI host bridge sysfs attributes
Date: Wed, 16 Jul 2025 09:08:33 -0700
Message-ID: <20250716160835.680486-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716160835.680486-1-dan.j.williams@intel.com>
References: <20250716160835.680486-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:a03:54::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: de653e23-a930-4187-0443-08ddc48306ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E9/td++V2JReOAxVzhQePq7ZOMU5d1yOQ9N9NcRaQ3QFeJTwAmyMqyvguFps?=
 =?us-ascii?Q?imsar4T1OZJmNqnCvN9tGWqccwAuQbhY9yHqgb+EU57CSZmpjaORj/DIeC+f?=
 =?us-ascii?Q?CZaQgmt8tWaT65sNBBOJqz//axpxd27+IkLadSmaPOMz5vw80bCK+A09L0sd?=
 =?us-ascii?Q?whU9dFL2R9HFMsKdrBY+Q0kf77OVJ4jFEl2JjpGHMA2vOw+y5Pgv2BlAzRAL?=
 =?us-ascii?Q?y6R7HLA2u6Kpo/c4wdaIDv8/3/AUMRGIpMHK/Mqcm6e5cfd1Dmgf0XhhtaC5?=
 =?us-ascii?Q?i9w4IP5iLUbg+mlgkmLRLNgd6Xbx/sjWtSsft4YFtvSAETGZLAQjKopb9IAV?=
 =?us-ascii?Q?0xcOoG8/nouLpGpMG3NbIL3PuV+tegYx58RBSH0cU8L7T+73saDXnaaG0Dmk?=
 =?us-ascii?Q?3XnirQPEvozvKoBZombHbRSUhm4xFvUX2lJhTwgcue0bA8e+jmwKwkbSohDn?=
 =?us-ascii?Q?JLscKn2zMyKHaaw7tNl4gY0fp6b6kpqhugyIyy7ttFNfeX+5EG4oea2YKMzc?=
 =?us-ascii?Q?AnyiWoGWLR0AHPLWHlpp+P9z3QqEX3EfXxaQnICoqTz4H7zk6vrXYHmvL79a?=
 =?us-ascii?Q?TzQPknNMpN+7X5BTqr/kWH16nU9afj6bPj5nLxZLIQVfpVU7R3o9NpBKJmrm?=
 =?us-ascii?Q?1Mb9ayL+XoyZmjpjbdb1cANE+nW/3jI6wsOvlQd/lyqL5zBnP2ihJoNbYbIL?=
 =?us-ascii?Q?SzPDEhmFRmDCDw32Bpgvn9AHuIBZL7LWm9CNyEWxc99ppbe1gaTOQ2MEYqMH?=
 =?us-ascii?Q?NVGr3QcXKAnEEQy8nNr0vGJPHD/Mf6k+q7m1Ylw91Xg7oS4k5pzQ/G4jOJUR?=
 =?us-ascii?Q?DUSMJroWX81jt4MwwNO4dSRgXKtA5hhINR8Kt5VoUnr0e7apa7zud5kXT0Sv?=
 =?us-ascii?Q?IkOmbIwnYnTpxbrImj8d6NmgJMz3rZpTuaceqcx5FYz17ZWHVfxieEsutojx?=
 =?us-ascii?Q?BOAmlfiBlq26CNjggcXKhvJBf3MxJwfx7a3rUpnhMyjfOHURLhL6X46goT4s?=
 =?us-ascii?Q?cGsmKSaaTWBBeyqoJP2togTs7whtQMAtDEywRqWMPQDWXEg9yDCsZp6iDPIL?=
 =?us-ascii?Q?IPYrvik44PyaOCEse4agazn590b+gjMU1ru3tPwX5/X+okIySx+AxI6ld4Db?=
 =?us-ascii?Q?hIoc2J9vtOWFhrV4vQFzAmqBD7p4VPEdblZdUp1GhdMDdEvYP3aIg4Q4AC6k?=
 =?us-ascii?Q?Q8OgyodOc8wJ0ogektZ/yaongY6tmICeoySMLKQFErVymvTulwF1kow6Iw7E?=
 =?us-ascii?Q?z4lXfzyDzngN/Khwjmyml6DfY/vhWrJdgY5M2IYQY08pEoV93aJKnVWEbIle?=
 =?us-ascii?Q?5MHsjpDpFjsvTS7fSO1g5Tig3WiT1BbOLapR+i0i1AvJyct2irBVzHGa5RgF?=
 =?us-ascii?Q?pM4wyRA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ct/g95A/0gDrbxRJBjQEibSuvl41A8+s1Fwux+eZLNgWEL6AM7VMRItq4Ez8?=
 =?us-ascii?Q?220hbMncLGFS3QS/qp6+AlyXgGoJB5UYikVt8UC/nd0Y04yrVZ1ys8zIYNtK?=
 =?us-ascii?Q?fMYlW3C2pyACOgVJGaXz2F3VRXy0TeYWBRXUrGv73kCGxlZC9yJ/yCvseZLe?=
 =?us-ascii?Q?F2kcs/JPtdNM3X6DqtWQYf1Wrvj4PXb71gcaXo4VLj2d0kx8ceQRE+TAwk7K?=
 =?us-ascii?Q?nLbmbgSoNJd3hRMIsFg6GHIph1LhwAcn/kkum+SOJPzVVvGWVI7NS+844ZlA?=
 =?us-ascii?Q?7bGJlz4MoCnhuIvN7eik6BujUyKiTYyKVdiechyOvFVoxURrnw/iYF8juW/z?=
 =?us-ascii?Q?WVU7W6IqfUKDHwf98Rj1gUCtK1V95x+XtQBVH6Vtisu+se5xyjO8KyMwrJyT?=
 =?us-ascii?Q?znZ4cZfo59zh/ikiXdcH2xFrHqTb/nxXruCHcv4Es6VbewsUB8uBx+3NZrCO?=
 =?us-ascii?Q?k9cEo9My2vcicDDQannWOeN+vXCJYfA1OPHUzobp6nGauthtWb5213nJQpBr?=
 =?us-ascii?Q?Y/EGMktqscc3qVFMW55J0x/IuX1ED5QbTdWNDZE6UQdKyDVpHf497xRLUkTw?=
 =?us-ascii?Q?fUFDCgLYiE2tohxkc5muLPjU03MFkpTxzETlNEPef/h8mURMRsf1O91xEZRv?=
 =?us-ascii?Q?a+LkIzYSNZlv6C1H1MDvdp8Et5LwGHxtb9PegxpLdJhL7caukiCmM7ZMqj5e?=
 =?us-ascii?Q?lx8LGvOkQk2eDtX2nb4Fk03Z45Ae4seppKyv2A4b+SjJ/ug6DdH03jalGs10?=
 =?us-ascii?Q?YVMBqSlt+H3xXFAtY5diQO32J5mO2c/AOtFdDfs365dMYDsCX+r2XMvhaH2l?=
 =?us-ascii?Q?vI35OIpDCcEjYCci6IMcUtWECFoq3pCuwCeyNBu/nu4GIjsMUMIKCGc9XO/6?=
 =?us-ascii?Q?vaI4i1wjkbioswUg5zUNvlFT5tE1Ep/J4ZTGQEHbv8Y95MteGSy/1ICzPFJL?=
 =?us-ascii?Q?vQTUHFhTtEizj6+Rh+FlkyM4L7aVh5B9dcQJ+MN6AXOxI67aYbA+Aj1nxIdi?=
 =?us-ascii?Q?y9B1xYK4JnF04iFXYu/qmCEcxHwO+fJ1mzuitlz5zErNT5wyOoYZSYdPfexf?=
 =?us-ascii?Q?MzEO4zt3ZyehD7dgH9FzBc6fnceFmV4cTz/0rm/FKfWINhReQjm+cjXAOnQ6?=
 =?us-ascii?Q?AicRQrBtsNGJEv462NwjtJCOFAEXpQzBHuhvev9aZSp3r7X+RKM4RVnT6LdW?=
 =?us-ascii?Q?Lgb13h+Dg8Mz+Kxlm09Q1SpegNzK40kTlUWq9FI5WkU0FEz4/0GVs2wbZzTm?=
 =?us-ascii?Q?M6s0tzUm70MoXzAAdeci7WtfWnsJIbr2lGXh+FvmCAwiuAPe1r3t30YWpw+k?=
 =?us-ascii?Q?ezQWYOY7BdJdw1WsBRd5YU4+/72D8eIIKRNwNLvq1SxbZSnGOqq9xKrI6p+j?=
 =?us-ascii?Q?NV1Eynk6X+yhrQlB/VM2czc0iP633GAVN//odAG87ZmAZq4DZv5VpwS+Y2xJ?=
 =?us-ascii?Q?KOe8b2Gfua0XXAmZ/UuPV0OYVGFCrDT2x48I7nbFCPF3OTb69IpTLsksCbMZ?=
 =?us-ascii?Q?SgRd44n39136ajHYixwrAODxitQq07ookw5sxkcQZ6GhvTXc72ttLFQVQaBd?=
 =?us-ascii?Q?HWitkuvaK7DqYKVh8TpzzwphkbuH1xQJv+gAyK7/2QaRizUuOt2jSUev0gcU?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de653e23-a930-4187-0443-08ddc48306ca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 16:08:39.1979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mr/9Vynq+odlJzcIqXqmUvVn7Z4zR1MdW3c2HaC3/2YlWAcSVw8QHbAWCJw59Pa7LBeRMJvo99C/z6HybfP6O7wv/eTVicaZQ/NuSYUEKBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4954
X-OriginatorOrg: intel.com

In preparation for adding more host bridge sysfs attributes, document the
existing naming format and 'firmware_node' attribute.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .../ABI/testing/sysfs-devices-pci-host-bridge | 19 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 20 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
new file mode 100644
index 000000000000..8c3a652799f1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -0,0 +1,19 @@
+What:		/sys/devices/pciDDDD:BB
+		/sys/devices/.../pciDDDD:BB
+Contact:	linux-pci@vger.kernel.org
+Description:
+		A PCI host bridge device parents a PCI bus device topology. PCI
+		controllers may also parent host bridges. The DDDD:BB format
+		conveys the PCI domain (ACPI segment) number and root bus number
+		(in hexadecimal) of the host bridge. Note that the domain number
+		may be larger than the 16-bits that the "DDDD" format implies
+		for emulated host-bridges.
+
+What:		pciDDDD:BB/firmware_node
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RO) Symlink to the platform firmware device object "companion"
+		of the host bridge. For example, an ACPI device with an _HID of
+		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00). See
+		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
+		format.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1d245bf7b8..368ca0bfdb9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19198,6 +19198,7 @@ Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
+F:	Documentation/ABI/testing/sysfs-devices-pci-host-bridge
 F:	Documentation/PCI/
 F:	Documentation/devicetree/bindings/pci/
 F:	arch/x86/kernel/early-quirks.c
-- 
2.50.1


