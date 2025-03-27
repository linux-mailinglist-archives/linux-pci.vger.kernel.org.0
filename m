Return-Path: <linux-pci+bounces-24824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 379EAA72B7E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 09:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05CE3B0064
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193C52054FD;
	Thu, 27 Mar 2025 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQLeFeYB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9862054F6;
	Thu, 27 Mar 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743064175; cv=fail; b=oTl0R2v4Q21GRMrrkRjbxoGU+EtOYk7tFwCLBVIDoABuJpeI26J+m15+PvCEdM7kHTW1k0KsZye4lWBSiBiN/cmpABVAxy1I2fSqKU6YGzG9sxdgGuYZJ9p6DhmM3EFzGt3FwleNGoNRit1/tL7WDLK7Oka8eFzCfrQWX/A8bcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743064175; c=relaxed/simple;
	bh=tqKqoSn9OHUgJH9+agTAVBP3Nm7fSmiFE619J/tRecw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=SvigbV2PkPIBfOCIgzPz0MATVxj1s2n4eEHG7CVTULUyAH6xlzNofIvSHkRI7dMfphZV71F0Kn9VGXYcGjc64IFmnLhFaqd+TsQQJ8i625K7w2FEFiUp50xfvavXEZVcAB3niIbgl/ijYuiSwEgZcY1abdIxsDSLqYa8aTzBXcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQLeFeYB; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743064173; x=1774600173;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tqKqoSn9OHUgJH9+agTAVBP3Nm7fSmiFE619J/tRecw=;
  b=hQLeFeYBvQMkL4JzeRwdnvW7RVh/+acaoIcMWgSCtVzuLk4zuwbLaUsW
   B9ptNc5t0Q8zU5IX8DRBPvqomlXaM1Lacr9GqySYX5jSPu+vqk8KHXKTk
   6CqYnBJzryB1DAVL3c0kX1R2zzRsdy8HL9BS4ZTJ/qI7PufJJOB8mfNnp
   oa31/ea/wvwNn5b4ASBVBLqCRQpdsXUTcptccYjjr1fJ5/W9Jf0IpLleN
   amIePeiYQFKr0Eb3sPa2FsU84DeIz20J3X/TJ3xUwut5LYVtVnXtEYzrq
   f1s6TWGBX3UHGcDpYYS3qJXANbCBCVm1r0UNVJoVp0H3S/P1XVe7m3nkg
   w==;
X-CSE-ConnectionGUID: SqOPZJ+VSjGMPl9WNjKZPQ==
X-CSE-MsgGUID: wiKt/arbSjiys5rgZBry/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44258082"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44258082"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 01:29:32 -0700
X-CSE-ConnectionGUID: uGsA84PnRE6NMVNhNxbYFQ==
X-CSE-MsgGUID: cqHGeZjMRd6j2li8MOQ1mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="125998603"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 01:29:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 01:29:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 01:29:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 01:29:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhTZbM+niuuhQSKVPodlWbX9mgvmNhniiHBXyQO16D4rl/V21BFRhLnGd5VeVZJoDtFvAocMRUl/RJkPtKHuL1VVDwW+gOtLIg/+5k12jd75zg3I7d7R9wFs523kPMY3a7MQIwlUeuRsTk35gXEpXC3JVUYqmdCnzBW8RjYoxS6VX2825yfiMf8/wPaJaEHrXKzoKl5+A+b/aKGTiTxdkSbk9yohzwEmzyFqBc7WXIIVPh1bIVeAtxdniinZlhlr9DojU94L0IrNQZNNDaHVC/MPuOI+RDLlXGHgDGQQmoJIsiM1fL8d8iKTcCs3P1EyxuYl2CMRescHtBMG11dDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpLdLTFTw5ulZKWQUefRgbe0u/yDE+SwfhwrHJkbreY=;
 b=VQnCpNMMtF6fGtTTE3jMVY0BswTjcczekk21sQv+ejXJ4Je2xlgn9nNIaJ2zg7ePgnC/yw8ugWEsOdybn/8PVL1F2A+7noNSMV0BIeKnWSc4lLRIdXcubwpwag8gsLLqopNKIvg0mgRARd07ZNm10ZFXk3bJUHMBCl06P2QK4kuwXwXznj7csoX0ycNkswE2aBhaaM/SyztDpYPpbR2BizLzXhPj1F2isKGHOfzny94HHq5SMBfQ9cXyzNRS+wk4mIr90wwRAvZ6MvI6Ito6J9sdojFuUC3yAfvNqlIdLxA4rkVojtqm0ph89jfD9UfBHumCwa2Mcg/vqUd0xxFbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 08:29:12 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 08:29:12 +0000
Date: Thu, 27 Mar 2025 16:29:02 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Roger Pau Monne <roger.pau@citrix.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Juergen Gross
	<jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas
	<bhelgaas@google.com>, <xen-devel@lists.xenproject.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: [linux-next:master] [PCI/MSI]  d9f2164238:
 Kernel_panic-not_syncing:Fatal_exception
Message-ID: <202503271537.b451d717-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 69eb18ba-15fe-44c8-017c-08dd6d0973b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?30DDTL3+jhbyjccBFMsOpEYWdQtMW+Zq2Oeip8Dj4FHWtmk4JvJ17TaaA7Nj?=
 =?us-ascii?Q?DDY4M9Jhw2Y/EQSHAgq+46iA9FNqlnbUbAwaPwYYt7rXiVesL0NSKPgqu8mf?=
 =?us-ascii?Q?gLs17TTD4qVDlTpjEoDpToXCy0qycFetsrcakz92D/Uktqt+UDzNovkb7So4?=
 =?us-ascii?Q?mYyVmULdJERV6LUFquW6WoWppGKNKIs+Mjl6ECfcT2LYDnQLKhK9QIy47Iuv?=
 =?us-ascii?Q?9iRER/yjr5lzBFrIvs9zMhpfjA534aj1r3/SF53g65XTRQyNAa2Pn1L7Xd5o?=
 =?us-ascii?Q?5wmv8MAcUToAIstN8Pg/PJJz+REGEniI5B16XJHt8tfTl3kAGWITil3G76Sg?=
 =?us-ascii?Q?Uy5oVAvB4AGRbVgEGgH03bsYvgPnOFualpqfccbiJNmyvrrV9IURatXtjkB+?=
 =?us-ascii?Q?3z4lL3s1Zwns4QKlLGisMiLTuZraRUW9cmdo1waJgBVp45ecR2HNYW4A20+k?=
 =?us-ascii?Q?+5ltmXMv0mMPJuSqcMxwoNzs85hYi6J8LZ3W7VDuJqwsJ3m7L1bxFjWIlqPd?=
 =?us-ascii?Q?109HqwElwzF+yZy6XOZ6D4p8CL4UufM4frhbWbY8tfvsAMot7v2YEv6WArAY?=
 =?us-ascii?Q?IQ/Mw5cxncGIsBYL5vrLn7Tz2ZpqWhQWuUOYPgLYm1JqAVvzTNxT4JrbR73w?=
 =?us-ascii?Q?bs4pG0344aD2BpoL/yBr7jjjpuoxZMvEZFEfa0oGCIJm1l3ejF0UFaq+ObN9?=
 =?us-ascii?Q?HtPQROqCsS128hHNV3o1HsVpxWAzmD2UxS6AgqkuAoJdkjtIenCXAZZSu3V/?=
 =?us-ascii?Q?ifNsZcNHCcHV3iq7VxeEaSf31tugVDmrXa2zpS+Wg5Qge4yOX9hRLhxlbqOD?=
 =?us-ascii?Q?H1XGhuM/cC3+NX13jSEwPDpn2oG/CB+Wgbjwoldq3uN9LYIoMApypPf24d0d?=
 =?us-ascii?Q?Nr0sg5UB6C67HZNtP4XU7dXNX5tMZP033IcDld0sAAahmlxtqo39ZPxMvGHR?=
 =?us-ascii?Q?4/mZ3SBWibIdwdVPqqUrHu3WZovMmCA/kkdFYMnKYVpEyxlJ6rq4olK6Psm6?=
 =?us-ascii?Q?ekFRaUAS0m28kqqTRBZuv4P7BwPmSvR3MlpupLjMdtPxVJl/ACThnXhQ+QU7?=
 =?us-ascii?Q?E3KsQY707hPmut5DaI8HopA6BXt3RktZombzvVCeUFZ+ugqZgnAQotcEZgA8?=
 =?us-ascii?Q?MEeEvw7auDYt75ZJgjkOt7N+6usGRFhDQV8GeC6SYL46dXiIhWkVx/1cCJgy?=
 =?us-ascii?Q?9Fp/cu3xBeaqtzgwEuv1R9x9dl6uV9/tyFAzPV9eQensVXyaVWuYjlEy+fu+?=
 =?us-ascii?Q?HUb6hsg11spCVL99YznlSWeZRpOd9H4IPB2Au6QAjSII34lT+GCgzC/ABxSt?=
 =?us-ascii?Q?8wU5ObkIYGeI3oB1YfheNm6nKBm6REPr9iQdXXzi/gNR8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QIs5v+/ugsE6AfRDUXZQpdl/oeLc73Zepg1EjMVIssoqBvGEioppxO5LicmV?=
 =?us-ascii?Q?lGjpB849Tx/8EMyiQ7+SDCztac0nJY3d2uEowPrER4Ibs2AkoRPvF8vG/MvB?=
 =?us-ascii?Q?mjDYWZULDyHBBbUTJu3S7yoKyekYajgg8Mjud7AVp00iuue6a+wRIJzUvyF5?=
 =?us-ascii?Q?h7xCcp6jbnFu/cdCyTdEVoWWWJnGMxupquAF/TyjIsLgtHgAMZziBk7qeemy?=
 =?us-ascii?Q?uZtKVNjBzgRHYUUmbpAV/Rg60wmMUlh3frLKYPiJE/n9UsQF4QcHcBCAcVWq?=
 =?us-ascii?Q?iZlnR0pM+wg9MIMM9w5+CJ8bLZTwuEzBaYT6NxFCR0MyJkiZSg4RuLxKih9p?=
 =?us-ascii?Q?dy60DZOxPwyOUOQLQWXvwpIrOW4o2ulLsBuNJW0iXjSSkHo/GmmCJrOB3nT/?=
 =?us-ascii?Q?a4sCOTSrg6gur7CDUdN7lPwnHiYUWCotwIcAQxbenn1jg+9l7IkO0CMhmGDq?=
 =?us-ascii?Q?MNvCFxyY4bg3AqeT7Qs8JIwx2zRY6FYQajU4lwKSnQHElu+/FoChGcrqFDjQ?=
 =?us-ascii?Q?+HaKhR5XhQZL4XIddaWBr9Ov1GcEnFyGB30f/eeJuvyf48pMgaOMdwYofSA3?=
 =?us-ascii?Q?U57uMZhYK3Rjfpz8W6JaNWsEmACPYxNT78qmF8tuKTjtSPXzOfnIGDu4l38d?=
 =?us-ascii?Q?+bi+u4T4Wkxj4LAgM6+a/PcQDL3UWufFaFvMwK3Yv6FM6wrI45usWCeojQ9b?=
 =?us-ascii?Q?PRn6SICcqN363Qe4yVZyvtqDJZ7DjQ/ct28m7Y1cXp5giQNox+us8R34KDX9?=
 =?us-ascii?Q?0ThAPe7iIoJkWK95JvG54IoHeoP4mnEyj+Urd6rBMrticmgJRd574WD/jtvL?=
 =?us-ascii?Q?nUia9/W5hoTIvOmt/p+3n/2MdfQznhBTWNCc8ap4iorqSJFssodvqJvbHIsp?=
 =?us-ascii?Q?d0FiIaxV2C/Etr/jGwpQrx5Hgd1oNCeqgyPBDEO+gB8xCo+dmz77L4wIjydV?=
 =?us-ascii?Q?OIfEA34zv4Bga+lHUgiOnEk2TVRYwOX6ciTi01M8jE5Vj/fpDRGlXP+78bvY?=
 =?us-ascii?Q?KG3oZhIdwtXOd8A4n5ATsEFS+zLTAmxe6u1tjB8cc8WkhCK8oGSxqJQjBJ+a?=
 =?us-ascii?Q?VOzV62mRnhHu3pctVVyE71SglbgRi9HpypNj0tIWECiE5g8E9LXa9pvERy0O?=
 =?us-ascii?Q?hL+biUnzvI2m40wrJNMmzfxhFAWfOWpN37DNkwkfMiUAZzW1vCfBcSgK5wyr?=
 =?us-ascii?Q?IItOtLMbKSznDm06K17wE/J6/8426SHYnmwKeAHjT7uyF6rpxvJUfAKTxgMI?=
 =?us-ascii?Q?ctHtVFg0wzfsiZIubaDzL8C53vJGOXtReWP149TQ6ErnJU3dKjqPeO3quWkt?=
 =?us-ascii?Q?QzR3wYnRGZ56IqIees/89cHL0RXUNgL/aOArwJlQAvmuj0NQuOvwV+SN25Yv?=
 =?us-ascii?Q?vWMIAJRheE4gM3mp2jTfeaxpkItjrt/rrpJOzSQlbYTMVuPJwFU1wyEApyjg?=
 =?us-ascii?Q?gohqquz8rgFYWm2oqZ+JZVZfE8EmshaHWCmReRUJxyhwBPSer+s7H0UBjk1n?=
 =?us-ascii?Q?pr0gwqmdLSFUKiBwQSJARihA+2KXKvWs53u462ZkLEWrOH0APJPEwJNyeRFI?=
 =?us-ascii?Q?bvDaQz6JqqGCk55xZoG0gayKFNZ6l+28+qLoxHjhZWojFKDWnzmAhnAR++go?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69eb18ba-15fe-44c8-017c-08dd6d0973b4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 08:29:12.0630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIKjO0/IE7/Vu0gvA3XlEAfd3VSwhGOPQP+WzMZV0SUtatkAeGT/5c0KWqvbA8IjyO9ZuWu34p1k9HiJDDiNgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "Kernel_panic-not_syncing:Fatal_exception" on:

commit: d9f2164238d814d119e8c979a3579d1199e271bb ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 0e871365f7f9aeb9b590e345458b2083e067cd13]

in testcase: ltp
version: ltp-x86_64-042eff32a-1_20250322
with following parameters:

	test: net.rpc_tests



config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503271537.b451d717-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250327/202503271537.b451d717-lkp@intel.com


[    5.420499][    T1] IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:1)
[    5.429420][    T1] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    5.439557][    T1] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
[    5.452040][    T1] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[    5.460040][    T1] CPU: 5 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6-00007-gd9f2164238d8 #1
[    5.469031][    T1] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[    5.477030][    T1] RIP: 0010:msi_setup_msi_desc+0x172/0x3c0
[    5.484132][    T1] Code: 44 24 30 f6 83 47 08 00 00 10 74 0d 66 89 44 24 0c 80 cc 01 66 89 44 24 30 48 ba 00 00 00 00 00 fc ff df 4c 89 f9 48 c1 e9 03 <0f> b6 14 11 84 d2 74 09 80 fa 03 0f 8e f7 01 00 00 41 8b 17 81 e2
[    5.504013][    T1] RSP: 0000:ffffc9000006f588 EFLAGS: 00010246
[    5.509034][    T1] RAX: 0000000000000080 RBX: ffff888106b5a000 RCX: 0000000000000000
[    5.517035][    T1] RDX: dffffc0000000000 RSI: 0000000000000246 RDI: ffff888106b5a846
[    5.525034][    T1] RBP: 0000000000000001 R08: 0000000000000001 R09: fffff5200000de8b
[    5.533035][    T1] R10: 0000000000000003 R11: ffffffff81d93300 R12: 1ffff9200000deb3
[    5.541033][    T1] R13: ffffc9000006f5c8 R14: ffff888106b5a06d R15: 0000000000000000
[    5.549034][    T1] FS:  0000000000000000(0000) GS:ffff88838e880000(0000) knlGS:0000000000000000
[    5.558003][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.563005][    T1] CR2: 0000000000000000 CR3: 000000043c06c001 CR4: 00000000003706f0
[    5.572049][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    5.580047][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    5.588024][    T1] Call Trace:
[    5.590035][    T1]  <TASK>
[    5.594008][    T1]  ? die_addr+0x3c/0xa0
[    5.598035][    T1]  ? exc_general_protection+0x150/0x230
[    5.604003][    T1]  ? asm_exc_general_protection+0x22/0x30
[    5.609042][    T1]  ? kasan_save_track+0x10/0x30
[    5.614035][    T1]  ? msi_setup_msi_desc+0x172/0x3c0
[    5.618005][    T1]  ? msi_setup_msi_desc+0x115/0x3c0
[    5.624005][    T1]  ? __pfx_msi_setup_msi_desc+0x10/0x10
[    5.630034][    T1]  ? __pfx_mutex_lock+0x10/0x10
[    5.634005][    T1]  msi_capability_init+0x1d2/0x7c0
[    5.638034][    T1]  ? __pfx_msi_capability_init+0x10/0x10
[    5.645043][    T1]  ? __pfx_yield_to+0x10/0x10
[    5.650005][    T1]  ? mutex_unlock+0x7f/0xd0
[    5.654034][    T1]  ? __pfx_mutex_unlock+0x10/0x10
[    5.658004][    T1]  ? irq_domain_update_bus_token+0x123/0x180
[    5.665043][    T1]  ? __msi_create_irq_domain+0x1c1/0x470
[    5.670037][    T1]  ? msi_create_device_irq_domain+0x594/0x760
[    5.676004][    T1]  __pci_enable_msi_range+0x28e/0x3b0
[    5.682005][    T1]  ? __pfx___pci_enable_msi_range+0x10/0x10
[    5.686165][    T1]  ? e1000e_check_options+0x3e2/0x1180
[    5.693036][    T1]  pci_enable_msi+0x16/0x30
[    5.696005][    T1]  e1000e_set_interrupt_capability+0x109/0x670
[    5.701035][    T1]  ? mutex_unlock+0x7f/0xd0
[    5.708003][    T1]  e1000_sw_init+0x1f2/0x7c0
[    5.711004][    T1]  e1000_probe+0xab6/0x2a80
[    5.717005][    T1]  ? __pfx_e1000_probe+0x10/0x10
[    5.721006][    T1]  ? do_nanosleep+0x2e0/0x460
[    5.726036][    T1]  ? __pfx_e1000_probe+0x10/0x10
[    5.731005][    T1]  local_pci_probe+0xd9/0x190
[    5.735036][    T1]  pci_call_probe+0x183/0x510
[    5.739006][    T1]  ? _raw_spin_lock+0x81/0xe0
[    5.744005][    T1]  ? __pfx_pci_call_probe+0x10/0x10
[    5.749035][    T1]  ? kernfs_add_one+0x2dd/0x450
[    5.754004][    T1]  ? pci_assign_irq+0x81/0x2a0
[    5.759084][    T1]  ? pci_match_device+0x38b/0x690
[    5.764049][    T1]  ? kernfs_put+0x18/0x40
[    5.768035][    T1]  pci_device_probe+0x19c/0x230
[    5.773007][    T1]  ? pci_dma_configure+0x121/0x180
[    5.777045][    T1]  really_probe+0x1e3/0x920
[    5.783035][    T1]  __driver_probe_device+0x18c/0x3d0
[    5.786004][    T1]  driver_probe_device+0x4a/0x120
[    5.793047][    T1]  __driver_attach+0x1dd/0x4a0
[    5.797044][    T1]  ? __pfx___driver_attach+0x10/0x10
[    5.801048][    T1]  bus_for_each_dev+0xf0/0x170
[    5.807197][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    5.812005][    T1]  ? __kmalloc_cache_noprof+0x149/0x3e0
[    5.818006][    T1]  ? klist_add_tail+0x132/0x260
[    5.823004][    T1]  bus_add_driver+0x29a/0x5c0
[    5.827006][    T1]  driver_register+0x130/0x450
[    5.832033][    T1]  ? __pfx_e1000_init_module+0x10/0x10
[    5.837005][    T1]  do_one_initcall+0x8e/0x390
[    5.842006][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    5.847005][    T1]  ? __pfx_parse_args+0x10/0x10
[    5.852007][    T1]  ? __kmalloc_noprof+0x1d4/0x4d0
[    5.857045][    T1]  ? do_initcalls+0x2e/0x360
[    5.861045][    T1]  do_initcalls+0x198/0x360
[    5.865046][    T1]  kernel_init_freeable+0x813/0xc80
[    5.871002][    T1]  ? __pfx_kernel_init+0x10/0x10
[    5.876006][    T1]  kernel_init+0x1b/0x1f0
[    5.880192][    T1]  ? calculate_sigpending+0x56/0x90
[    5.885046][    T1]  ret_from_fork+0x30/0x70
[    5.889047][    T1]  ? __pfx_kernel_init+0x10/0x10
[    5.893046][    T1]  ret_from_fork_asm+0x1a/0x30
[    5.898037][    T1]  </TASK>
[    5.902006][    T1] Modules linked in:
[    5.906069][    T1] ---[ end trace 0000000000000000 ]---
[    5.911439][    T1] RIP: 0010:msi_setup_msi_desc+0x172/0x3c0
[    5.917163][    T1] Code: 44 24 30 f6 83 47 08 00 00 10 74 0d 66 89 44 24 0c 80 cc 01 66 89 44 24 30 48 ba 00 00 00 00 00 fc ff df 4c 89 f9 48 c1 e9 03 <0f> b6 14 11 84 d2 74 09 80 fa 03 0f 8e f7 01 00 00 41 8b 17 81 e2
[    5.936715][    T1] RSP: 0000:ffffc9000006f588 EFLAGS: 00010246
[    5.942693][    T1] RAX: 0000000000000080 RBX: ffff888106b5a000 RCX: 0000000000000000
[    5.950583][    T1] RDX: dffffc0000000000 RSI: 0000000000000246 RDI: ffff888106b5a846
[    5.959042][    T1] RBP: 0000000000000001 R08: 0000000000000001 R09: fffff5200000de8b
[    5.966940][    T1] R10: 0000000000000003 R11: ffffffff81d93300 R12: 1ffff9200000deb3
[    5.974827][    T1] R13: ffffc9000006f5c8 R14: ffff888106b5a06d R15: 0000000000000000
[    5.982728][    T1] FS:  0000000000000000(0000) GS:ffff88838e880000(0000) knlGS:0000000000000000
[    5.991591][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.998093][    T1] CR2: 0000000000000000 CR3: 000000043c06c001 CR4: 00000000003706f0
[    6.006000][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    6.013929][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    6.021832][    T1] Kernel panic - not syncing: Fatal exception
[    6.026005][    T1] Kernel Offset: disabled



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


