Return-Path: <linux-pci+bounces-3563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552F88571C3
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 00:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2D01C21A08
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 23:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAD5145B14;
	Thu, 15 Feb 2024 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYIpmAU8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FBA145347;
	Thu, 15 Feb 2024 23:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040667; cv=fail; b=NgMLewnMwTVPAsIFAdDBQtEUJ4bBTHFV8RXtebwv9y4El3ypBkZnoon83+z/L6eU3RULimhdi43L2Gw/FjRb7V9t8yyU2inJ0Hn+VA0htSAjDGJyGXtPPWSsudsA+FYiJNq7y1t8qdXQK6D6ld5MnEgMqHtn6QN/H7OkeOXU0zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040667; c=relaxed/simple;
	bh=px4f8OTWP3Ao527gVrmUGuN1TAqL8J3YKDncuQMNnDU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZCwlLFBzSb+8oclu0C7AAMkqwYfFUo4Tu6X4FkeaivI9GjfCrsgypsRuacJIdZKHxTmaTjAHTStgvOa3FL66L9WeNGiu7xTEjPs+CyWiLGnluBhT+/aSqqWkGE5jsWJmw0d+7G4VuxbmcIoh+nyiKojl0VuK4jRN28Pc+iXm1Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYIpmAU8; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708040665; x=1739576665;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=px4f8OTWP3Ao527gVrmUGuN1TAqL8J3YKDncuQMNnDU=;
  b=RYIpmAU8sqAyD7FB4THap6ALWInBIgLYT0fCreTmt+RBvNG8+t89qOp7
   G9eUijXQ1zOBsuVS/qGd81TouaUsAnhW6vumEaz2IMmGG0QFzuTPY7NB0
   D6SmsjExlW9MbeobAuHT+LJi3SlEZXSYJvLyvXkV3W8drqgMWVUNsU2kO
   GbIrEfmjf9ZjumujIO+/gDql0b6dAdS13SZhkyWW5sV9MEnE8nrL6ADPT
   /Z+NrZTj8LPOL27tAQGFcl3nP6kEXYDT9LZB8OL3Ukb8jG5mYu2kaCyvy
   3BRnsS4H7ZoFmf1TMWgFzWZfw32lZF7o6/d/TOqwE91XWHsbsQ+ffoqBX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2294501"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2294501"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:44:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,163,1705392000"; 
   d="scan'208";a="4003804"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 15:44:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 15:44:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 15:44:07 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 15:44:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOPNzlu3YcYhaYu2mgQWZi6ULLGT44l6bZfq3wlNye8ov5XQ8EHCWKLTq0UFmxRGY843LV4Yx2QJiQYp8PP9TuGBNT16OKKF93djDn3BWQDWHkTRJ2a5MMyai7tLmypf4kmARXCjY9DKb+S1srEGP/mLykEJRR2T8/oxZoUOcXbuaySceQM2n4VjofweVnIeFWClHM3WXi+MDaTNxiDhMc4UbgjAgYTICfkFGWCahXwHIz17PdjNiBf1K3Kutmk7++0697Bn2E860jQnGbaokox9nOldvD9zVKOdnbV1LfTE37lATSF7wjEtwNjpvnsqtaXjP+HDGx+ppqSaS3rXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8180xlLZ9XQPoY7jiEJDW56QuC2uMP7b1aivFtIg+4=;
 b=CVhV5UHBAz79azVPmeiOLGdfujB42Z6o81MCTAEtOUD/+3G9sUxhXgG6VJcCMEcN0hUD4AYJb5c2jMqL3mvTvpIbDh9k6RhfJN900npVcmF36s5P7tRJqzbVvuKopI9JA9GKt/pSOyXoVfGhLNzE90H4+IbO3JNPjt0wArk8Zdn63R1F3AI8AhTmKY0jcI3JzHZwfKsRVZXAXYgyS47cNbqMh1aAUoOtmEeJvOYAZ9LKmeNMI4a7G+2yciTdntWoy2deyf9aFCvDZsJepRVLnX1SVwOED5mgiZTJmCjCll8HH7H8yeygKfIIrOGqNGcYIccZabFXBiCfJvb48IBJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8315.namprd11.prod.outlook.com (2603:10b6:610:17e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Thu, 15 Feb
 2024 23:43:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 23:43:59 +0000
Date: Thu, 15 Feb 2024 15:43:56 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<benjamin.cheatham@amd.com>, <linux-mm@kvack.org>
Subject: RE: [RFC PATCH 0/6] Implement initial CXL Timeout & Isolation support
Message-ID: <65cea1bc6ac0c_5e9bf294ed@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR04CA0291.namprd04.prod.outlook.com
 (2603:10b6:303:89::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: 232e31fc-a9a4-4a9e-c362-08dc2e7ffb30
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNbYC1/ZhHZ2KYEOMiA+TiJBo5oHQ0AhB6EepeItbwCzOBx2WGu6eKl33PAgLBETVSIoixJUk5ga7urdK+F9NT0EK1KNsHVslr15r8u5/8/b7rHIbmsa6ayhBavhzosOKG6uMN5eFhdXIavyLZubBa4dwMxt8VO+9ffFAm04xT1KMrzw+OckYiLu5pWPGoHSHEIMXRs3VLh/rfaVfDvRRXQEO+wPgWvUBLXRYA6rTnIq4svWAHoBXLvq6RNReao4RhG0YVxYlWiAsZZ3FAJU6xcSDFzh8QxqaGAI3k59jjA/sDOk8b5p0VUyYlCNVLfU5KJsJYlxb/9XetD9E9aP7zFECqZVubI5R55430ZskvY2Sv47JbUeZQbWeTB+MqBXDLfbTYTcSXg5O8de92f3IypXjhYhyqte9u4bDjSv/KUenXLeIbrfYOr8/Fh0P0sWer15Yf3ue8ED6r3Erf/lONEUR/0iVfP0RJ+n1Nxvmoaxs+Dl6+HfuzBK03Xr118AXpe4ZGI3jDBrlaa91a89t+9bipKntcOuCPGlCGaPOtr10csmq6p2x54/eSsb8zHL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(38100700002)(66899024)(82960400001)(2906002)(316002)(4326008)(6666004)(6486002)(6512007)(6506007)(8676002)(8936002)(41300700001)(66946007)(66556008)(66476007)(9686003)(26005)(5660300002)(478600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tT4PgUgEPypIafEHkVSWrQtF5A9Z58BHO4lVDWrKg0kPBaQ3muNfulah6bOU?=
 =?us-ascii?Q?XVamA3KpBD7MhT/FRLBpoGt4KXmlL7XpENxuDSYcvmMEd0jJfdEmD8Ae4SAH?=
 =?us-ascii?Q?IYh8nAZNLWTwYXMX6v9qKLZMc3mjvWDDvbZo5TKZF2soFUEn6BkIHFnWd8Z3?=
 =?us-ascii?Q?Y19f1vRpJJpZ15tK17XhpvarYA2bzZoXh5IpIalejkRjjEb55ZOMmLeQjYR1?=
 =?us-ascii?Q?giaDpX/HSfyyN/u1QU9LLQhFxtb0vBpOyZ4Asio28ZGtm9NkY5Tg2uos7Vb1?=
 =?us-ascii?Q?oSgvqlb3pfyFDzyqdHemL8yjbOBotJi5yWXc7YmtSLsShKB7kpdVUba9Taqf?=
 =?us-ascii?Q?Rm3BfGMSgROci8xHW5mH0SX8JU0gErrY02ku7FADamjk07vZoAOz2RAvnVWZ?=
 =?us-ascii?Q?bqslgBSpqz4C8/3G1TWSIWI4IsGMjoH2Zc2uVhyXmRG1wyiNHI2VvesnN0ff?=
 =?us-ascii?Q?PVLUq1XVFCpNH4ENXC8DgCRvbq5u+hWQ7SFo00/pOdBtzIQ6cMQljXupfvc+?=
 =?us-ascii?Q?fMCIHrouPwtNgSe/HHM5cS+tt10LI12p+HwXurKojw+82VRvhKNY2b5DBvu3?=
 =?us-ascii?Q?jhzVLOZF95uatjBgzJO8bRIangRL/lbS4dDZDBuAp7DZfoNTv1yzArpoJ9Bq?=
 =?us-ascii?Q?bMHYivkUv34E8t7KJP0iCDieOpTpcjyWPVzfcE426QgkdWIj2jAR9Hr8Nzp3?=
 =?us-ascii?Q?DDhdZqgQJ8HwzlgWaq4OOvX3vsbgyYw6nhteWSiDrD/KPhxwaTjiFdVWmdJ9?=
 =?us-ascii?Q?I1TME2K/LQvOmyAmmbF0CjS4jCnJM8EUq49sRXRlW15FRTvqWX1dJstChTnM?=
 =?us-ascii?Q?dglff8bgXPhSwlB7a0bRAir8fxTYdsZAIlUOosAY850Zw3Wgaj7Vg3vBmY1W?=
 =?us-ascii?Q?wi5W5KMeHNV1gh3EoHbEKFPASWIMEcFm1ZD1iRVNIo64EXUPbN8oPNmoelql?=
 =?us-ascii?Q?str2qm6b6nwDDl7FufgkDQvLzJ22FVJ8Yzo1pVEJGiIHoVxlwesFLxDRIVTL?=
 =?us-ascii?Q?jYpcEch2MNzajCToIGN+uo5QgFaZip0RCUyOTKSxUDuEw99M7cdlvgvUPGH4?=
 =?us-ascii?Q?zGjhdhMp5pXbWF4510pQN7drpZpYZ3ypdUlQIn0nzoiy7NCJE/ZD0DcXAkrY?=
 =?us-ascii?Q?s1c8G3U6vFv8rL5mCIfPQ44CiQHMzeMh5pDWxtC3l+tHgKQCjipxlWlD5t/n?=
 =?us-ascii?Q?+JO3Wf/MdhHWEVLYdMkkrbgwjvGYB612I04EtT+ZgN9wUvPBfdfssNbbbM6P?=
 =?us-ascii?Q?WE4+Z1Dy/vo4rPRYkrW3O0DXmBc64MFs2ExPap26KMV1Hvp3+agv0XlMU4rB?=
 =?us-ascii?Q?ZgLV7OLb5kxbufVn6KXBZpI1WEqf8E9lShcPSHAnf3j5mA4kCmuhjzDco10g?=
 =?us-ascii?Q?q3EWnSZ7rlyeXs9XP+2Wn/v542yA76K+SyG53hbm+SpdtqG1lLFiJVdLdQQ1?=
 =?us-ascii?Q?EUjqVU2CpczcP6x0zdq6RZiUBDuPWOSqHqdQuXqY+1DrGKBWstMY0cD4MmcX?=
 =?us-ascii?Q?jyvkexazpTtJLVtEKke1jEQ6KeShnExfK/e9AIY30jw1XnsUII2y5d2SOFMH?=
 =?us-ascii?Q?reYaWiyMp7i144wjPEYJsOByUQBeSw8C/dNaCl3oHGjIGvA/ubu2xbyt3n+i?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 232e31fc-a9a4-4a9e-c362-08dc2e7ffb30
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 23:43:59.1354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IuO8j0dekoi/VeamV2441opnxDUUORmgz2o541GRVYtttYLRL1TMccWDcOytcTmW1FCgQ077T1s/HQ9KXST3L9dxTP1lbUc4v/1CIt3HxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8315
X-OriginatorOrg: intel.com

[ add linux-mm because the implications of this feature weigh much
  heavier on mm/ than drivers/ ]

Ben Cheatham wrote:
> Implement initial support for CXL.mem Timeout & Isolation (CXL 3.0
> 12.3.2). This series implements support for CXL.mem enabling and
> programming CXL.mem transaction timeout, CXL.mem error isolation,
> and error isolation interrupts for CXL-enabled PCIe root ports that
> implement the CXL Timeout & Isolation capability.
> 
> I am operating under the assumption that recovery from error isolation
> will be more involved than just resetting the port and turning off
> isolation, so that flow is not implemented here.

That needs to be answered first.

The notification infrastructure is trivial in comparison. The use case
needs to be clear *before* we start adding infrastructure to Linux that
may end up just being dead code, and certainly before we further burden
portdrv.c with more entanglements.

I put together the write-up below in a separate context for my thoughts
on the error isolation capability and that Linux really needs an end
user to stand up and say, "yes, even with all those caveats CXL Error
Isolation is still useful for our environment." The tl;dr is "are you
abosolutely sure you would not just rather reboot?"

> There is also no support for CXL.cache, but I plan to eventually
> implement both.

To date there are zero upstream drivers for CXL.cache initiators, and
CXL 3.0 introduced HDM-DB to supplant HDM-D. All that to say, if there
are zero mass-market (devices with upstream drivers) adopters of HDM-D,
and there are zero HDM-DB platforms available today it seems Linux has
time for this to continue to evolve. If anyone reading this has a
CXL.cache initiator driver waiting in the wings, do reach out on the
list to clarify what commons belong in the Linux CXL and/or PCI core.

> The series also introduces a PCIe port bus driver dependency on the CXL
> core. I expect to be able to remove that when when my team submits
> patches for a future rework of the PCIe port bus driver.

We have time to wait for that work to settle. Do not make the job harder
in the near term by adding one more dependency to unwind.

> I have done some testing using QEMU by adding the isolation registers
> and a hacked-up QMP command to test the interrupt flow, but I *DID NOT*
> implement the actual isolation feature and the subsequent device
> behavior. I'd be willing to share these changes (and my config) if
> anyone is interested in testing this.
> 
> Any thoughts/comments would be greatly appreciated!

---
Memory Error Isolation is a mechanism that *might* allow recovery of CXL
Root Port Link Down conditions or CXL transaction timeouts. When the
event occurs, outstanding writes are dropped, and outstanding reads
terminate with machine check. In order to exit Isolation, the link must
transition through a "link down" status. Effectively Isolation behaves
like a combination of a machine check storm until system software can
evacuate all users and then a surprise hot-removal (unplug) of the
memory before the device can be recovered. Where recovery is effectively
a hot re-plug of the device with a full re-enumeration thereafter. From
the Linux perspective all memory contents are considered forfeited. This
poses several challenges for how to utilize the memory to achieve
reliable recovery. The criteria for evaluating the Linux upstream
maintenance cost for overcoming those challenges is whether the sum
total of those mitigations remains an improvement over a system-reboot
to recover from the same Isolation event. Add to that the fact that not
fully accounting for all the mentioned challenges is still going to
result in a reboot due to kernel panic.

In order to understand the limits of Isolation recovery relative to
reboot recovery, it is important to understand the fundamental
limitations of Linux machine check recovery and memory-hotremove.
Machine checks are typically only recoverable when they hit user memory.
Roughly, if a machine check occurs in a kernel mapped page the machine
check handler triggers a kernel panic. Machine checks are often
recoverable because failures are limited to a few cachelines at a time
and the page allocation distribution is heavily skewed towards
user-memory.

CXL Isolation takes down an entire CXL root port, and with interleaving
can lead to a region spanning multiple ports to be taken down. Even if
the interleave configuration forfeited bandwidth to contain isolation
events to a single CXL root port, it is still on the order of 100s of
GBs that will start throwing machine checks on access all at once. If
that memory is being used by the kernel as typical System-RAM, some of
it is likely to be kernel mapped. Marking all CXL memory as ZONE_MOVABLE
to avoid kernel allocations is not a reliable mitigation for this
scenario as the kernel always needs some ratio of ZONE_NORMAL to access
ZONE_MOVABLE memory.

The "kernel memory" problem similarly effects surprise removal events.
The kernel can only reliably unplug memory that it can force offline and
there is no facility to force-offline ZONE_NORMAL memory. Long term
memory pinning like guests VMs with assigned devices or RDMA, or even
short-term pins from transient device DMA, can hold off memory removal
indefinitely which means recovery may be held off indefinitely. For
System-RAM there is no facility to notify all users to evacuate, instead
the memory hot-removal code walks every page in the range to be offlined
and aborts if any single page has an elevated reference count.

It follows from the above that Isolation requires that the CXL memory
ranges to be recovered must never be online as System-RAM, the kernel
cannot offer typical memory management services for memory that is
subject to "surprise removal". Instead, device-dax is a facility that
has some properties that may allow recovery to be reliable. The
device-dax facility arranges for a given memory range to be mappable via
a device-file. This effectively allows userspace management of that
memory, but at the cost of application changes.

If, for example, the intended use case of Isolation capable CXL memory
is to place VMs that can die during an Isolation event while keeping the
rest of the system up, then that could be achieved with device-dax. For
example, allocate a device-dax instance per-VM and specify it as a
"memory-backend-file" to qemu-kvm.

Again the loss of typical core mm memory semantics and the need for
application changes raises the question of whether reboot is preferred
over Isolation recovery. Unlike System-RAM that supports anonymous
mappings disconnected from the physical memory device, device-dax
implements file-backed mappings which includes methods to reverse-map
all users and revoke their access to the memory range that has gone into
Isolation.
---

So if someone says, "yes I can tolerate losing a root port at a time and
I can tolerate deploying my workloads with userspace memory management,
and this is preferable to a reboot", then maybe Linux should entertain
CXL Error Isolation. Until such an end use case gains clear uptake it
seems too early to worry about plumbing the notification mechanism.

