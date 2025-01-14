Return-Path: <linux-pci+bounces-19773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91022A11321
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 22:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BDA188A866
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 21:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD96C20A5D2;
	Tue, 14 Jan 2025 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyppnMzH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4309E2080DA;
	Tue, 14 Jan 2025 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890686; cv=fail; b=YE9LlkeH/Nv7S2sYk3clryr/ilrkVI5mO4+cO8txEYXAutYl/AhqdY915wckdANN3W/QDZU16zHJx+1pTNvfS2eI3jRZ8pgL9m+QbrZqiRNH+ubTYfGtEPCIUc5HLR1b9ClRY4PV4b+Tq65Z25UFzzcZGt3Abt0MYw3jLsPVEI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890686; c=relaxed/simple;
	bh=MhyTe9Pm08POdRiLyG35Cp0KWmmK87M6KEiC3p9ijl0=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XmmMrDiISAZCbAAgQxwJADToMcF8TkQml5rrLTdaBQJW7A7uYyZ584qoqL05KrLLDVh85gu8qdW3OVd05VBDDQcYxKf8IIdqdGRuMVmVue05bKzQYxsROFvChcZoPBmNVGyQV8rL0ZhAy/uNmi/qy9c9ytZ8wJy54j5vTg6Hzc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyppnMzH; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736890684; x=1768426684;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=MhyTe9Pm08POdRiLyG35Cp0KWmmK87M6KEiC3p9ijl0=;
  b=DyppnMzHVYu2mjd2PfCS7vgIMEXAg4p7A1wgPk7eKXfDmKxw4p/jYZEr
   Z8Ml0Ffgk9c+F06aAbscsVQQgZrae1UGMiIMrlmimON4kQ1kqHTXMzrLX
   hcvMFjkZ/eAyH7HxheXqzu0Tai4gsvYoQNK43if8kMBFr62lkHGoFf/zs
   Tz9X/YVliFN3KewZkzw8V80t2KYxzs9rv2bBmFWcQPqKlnir2fSog3mWQ
   OBNHIttlC6KqyDbEh/aLPOBPAKEmP41pjG36pia7q0qocyndgc+qXwEDW
   pamVS2sCG5RupNSYzVvFcBBr8td/M9ZhxhMzAb6oq3oHcrdxQSFAd2dnt
   A==;
X-CSE-ConnectionGUID: aDqIKey+QZWk3zmeXHpZwQ==
X-CSE-MsgGUID: J9pum+ZPScivhyEurcv1rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37436912"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="37436912"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 13:38:03 -0800
X-CSE-ConnectionGUID: W2Q5wj7jQuuzUX9H0HhNuA==
X-CSE-MsgGUID: URmQ3s4rROuCBCIhIBgPVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="109874313"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 13:38:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 13:38:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 13:38:02 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 13:38:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTzflgZ8hLjje54rMCgZ1MFRChBC1Q4mPH1KkwWkor49jbqULUlnQ1MVdODonNldR07dik83BPCt02HnjbOdqytlV8er+sDN8IzxZIUBpIxXbpLZtVgApvQ7us9ZytiToOtSGzRiezoRnthYn1YKksGxRHuPY9yxlUDEIUW2BeWJH4fUaIP5/nuTMd8jlYYLPMOVyGHtUZspxwu1HE0oE7FOxu2XpkPtUZ9AF3CV1FlMgBc6NEniJ73/GceHqPk9h5ZX4lqMtqy7QsFZxmSerYL/mUoe62ld1WZNFCTc1RUGfz0IvSD0PaASHbDfP5qjqJcOuBdtUBblFAZMRfm3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaphfFqfr/St28aLCpPO1atk7w/k680hqW6rbODrJhI=;
 b=A5iP7V2aI442omTswQhA0dFJ3wA3fVPbx5InnPHBGKJXoCkqB/uNRIYDhmQwTPPxZz1d7qqTBs0Ugwldj/aedk6NQJ4x3Dq8v3pFJo6Mk1fWvnVUcJXVLWeRMfIJRmV8+doJKxso+NjR/fBQSrzzWivIqO8KNFtbp5vJzhhU/QGb5HpfgPij184bLzwIyAjK/DIyVP35hlXmLLt6ZkSf+C7wDYbhylI2ZpBUCHOji3cptFlEXohK75qXQGmuQ16z920p1FbTb6u0GW2Ivyse8RjaF01WnG6UOEsKGsSgObybrzcbUYKZiCaQn0uSEaIt+zssHPeKl0zybwXgeTUUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.19; Tue, 14 Jan
 2025 21:38:00 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 21:38:00 +0000
Date: Tue, 14 Jan 2025 15:37:53 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 08/16] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
Message-ID: <6786d9313b98a_186d9b29432@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-9-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-9-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:303:8d::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 7873fd1d-361a-4b49-75f9-08dd34e3b7c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y8+0+qvqGB7ShYAsYsbx8OriyrbTktDJmSrympajXJPoSVwkgu11aLYCCuvw?=
 =?us-ascii?Q?542jgTrVpVK16hlI3/ZPspSV7XxloS56AWzDbD3mP5JUSWzIvvIg8VcOv0IF?=
 =?us-ascii?Q?cNfRf4SagIdf3kaABnrHybmcEwN9mDM3AvPtJgNuulistnvfFtyZ80oo1JKy?=
 =?us-ascii?Q?JZQem6iNWdgZ06CJiYapjDaOkzupClaSvjIWj1jkXERLBjbeWZNC6jDZxbcl?=
 =?us-ascii?Q?Vio+l6CV4WcEX9qrPlOlD7Kjx9xkc5DGMymXBMYu6qX0ovI3GmVeBvTesKvo?=
 =?us-ascii?Q?bJDGkEW/cIx74BGOhq1wPawC1tfKtn5q1h+B+NtuD4UK0Y+n92gg7Fka2NxP?=
 =?us-ascii?Q?J2oESXWaLRwDdhFYAtjEuBliuwTVMIBwo50NvQYauATCH8h7273URI1O3p2I?=
 =?us-ascii?Q?bA5/Tdm27JDH+Q71ZgoC1HLWYcwAfGujz/sq2PLLxFy1U7mr2LJ197S7H/LD?=
 =?us-ascii?Q?poIXOhs1uZwG5bKOkrDlaK1zGmBMOMEFKfa7FHF8K5vfLL88cL06qsY7Qfd1?=
 =?us-ascii?Q?zem4bKM5BYP3lMrpa8TzXnOYvS8+pi908/lclrsEhociMNvMsJzS+lkTIeUD?=
 =?us-ascii?Q?tvp2je3rCqIvl590he165BDcZc3bzY0C6ea/TvjKWPEBUyMLTOHWMgybVeUz?=
 =?us-ascii?Q?gvB5UqruYI9/oAxt63OGyi0ZxcHcFZ4fujrrur3vowTmMeb972T1uctsJ4cu?=
 =?us-ascii?Q?+KN/BPlAoGxmOru9lHPgzSCVGjAYMEhRS6P9Oji378MufrLJ1LwHV/WFbHtC?=
 =?us-ascii?Q?lY7QLuoZN2wBIC+avnE1nM4YYXZGrNizAwZGPcoHzl6m7Qq9FrJl7SFUh/3Y?=
 =?us-ascii?Q?MiPkoax//0m3E3EQefZUOZP1f1+eIEO7NMkLguA8wpAJE7plXjhBhrs9lSdK?=
 =?us-ascii?Q?i1+/gkCNF9UnEv0omrf+Q6FX3s3WhDVHJ8USVbzcJ5xfBAn93yJA3UOgRjl4?=
 =?us-ascii?Q?xkrY9JVawdPOqCb1PldT+lCTreJz+VV1r4TzEhoJo3rDSBbv8/iIF2LbIT2k?=
 =?us-ascii?Q?xTTMn/04RPnjGVmVsmbiYkxtm+BUnMnlxRQlKuXDDDGg8OXggj7EsQ51iXPw?=
 =?us-ascii?Q?HL1lGNR7rju+ipFZfLd6KELytE2Yd965ZVx52UGbmo1JxbLfqpkh35i36jj7?=
 =?us-ascii?Q?1JvYozxYFKkbKhCXu8oYeGUwWawbOYpnC8HLtGQpkcvhpNRCE4zssilOW14D?=
 =?us-ascii?Q?y+8RPum6UpbVMk5SYOoF76OoN/3VhPqeQ0ygvMB4SV8VOzsJ801T/L/n51/9?=
 =?us-ascii?Q?X0CW/EWiySKEOUlaDTDWNPShfLBJ6agzb3i3CFA9ZhtcvALd0w7z+5+qXoxU?=
 =?us-ascii?Q?7c5/lEdgpSIwe8oL0ostB8tS7sihiAXzesXwFUQsVpiuRu/6/mG4rILzQehi?=
 =?us-ascii?Q?UPw2Wsdhlzvh8fPEyTmIwokawicOKBozLL8YyBAX0aGUMkJwetojCMRemmGN?=
 =?us-ascii?Q?Hsqo0RSmdjw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zk0mcdGLXrlrHckbevAGPoHrOsR/iZaUylsgHoDmXEARKfaR7smtEHSVljO0?=
 =?us-ascii?Q?bRJJNeC+nRWv33dvhcsN2Z3Hy1goMnwavZLXdfk02Abh1Ew9r3dMqp1tff/o?=
 =?us-ascii?Q?BnzwY7TbK9JBevUlmVKyhffKcTfMcs72Q2Xmrzj3OeA/X8iyTc2fgrEDjbeZ?=
 =?us-ascii?Q?OMOsw81/I+11FVzMpQihKMszu84p4JnPM4irGUjZLQlTAGXZbb8FhF8U3hcC?=
 =?us-ascii?Q?dRzFjhdQcg10phsXbRPEzuS8hHbqL6hPRTqiEqKfhjN+G5OwQ3Kt9lCKugHr?=
 =?us-ascii?Q?fi/Rqq7Dzazk6h7z6JCYrj2m89r2s0GGYTtjmHueU3NYOSc/TpZqzosjzghm?=
 =?us-ascii?Q?7805NcIXROW65lrO9zU919DvC9jgyRfIBG8b+JXRevPxIOUi5jPWGw28zYHh?=
 =?us-ascii?Q?kEhL/oncUvz4LD6/A3xhXv5nU3ZCxa5NV11+eEbNXf4H6qXdqV1G3xWl4lrK?=
 =?us-ascii?Q?E0gEngBdtGge9w57Wh+BBS+bcFJB4G7fS3RV/zP5UHd5QMg9ytcK9j0rNOxr?=
 =?us-ascii?Q?pHPCn+lcMLCzq4jPYsChO3UctkZ2ygpcxEWOJd9gzl/zg+DwDaf6NGytcr3f?=
 =?us-ascii?Q?qZnuf+q83fYw+KOJ+SR53ks4i0OnV9zMQVAuetA0UIoF/l93cc24P1XmxLhM?=
 =?us-ascii?Q?rCpV9VIQAsgijLsDRj9pOQJWUqKKYi8sciIir0adbTYu8VbRzS2NgmUSPY/B?=
 =?us-ascii?Q?SU4T4ARO4t9nWj/wWfgFm4XkNE0wfCds1cmuvEKtznPDadVk/hOb8HO0HIPh?=
 =?us-ascii?Q?5IsjJ4T9jvc/5Ewh7Zbobci2T9nhRGbSrloFx7o3SeTURkH3cH+hYVFAa9ua?=
 =?us-ascii?Q?v3pejbRnRNIAQbA2k+p/+4ERdBc30iWOnRqUXelKo4w+Kk131RMnxMsGOSGI?=
 =?us-ascii?Q?B4gJ6s/quAuo4IwlJhNoe/i8QejUYVe7Z9ipS21YXONbXLUqlX7S+mYk9JQh?=
 =?us-ascii?Q?MvABb9pqzIaFuEn1uBag5AUnM49vJs4y84tIDSRayxG4zLsa9fwriRuRt5KA?=
 =?us-ascii?Q?hbsyQuNKtSSzo6GncJ0c2Ddp9YE0xgXLY5VEhwd3UFJRmoBu4pnfk3gSxhzE?=
 =?us-ascii?Q?JSgh6lFfQUMZjM61aXnM/9eEUxFh0QTqjyGyHajL8qWU2ZE30OHzHstOmVAn?=
 =?us-ascii?Q?nb30YnicRUFRheM2glCbI1pAK2QCfQdzX9xwfzUztayVuCsuaw9+baOppZD8?=
 =?us-ascii?Q?L0G+LH5flAbVh1d4gF/h7n3oj/HKz60lTOlHFOpwDVDhqa5f7U1Q6aJoo6cw?=
 =?us-ascii?Q?WzbY13bsAvNoUz7GhHiHyXhCRzOvfFTf43YwQqc55okas9lZfeR9Toj9oPSA?=
 =?us-ascii?Q?41rfNn8LbPPjh0yAT9vkL1QMGN3lAnAE8UrvC4aDlXGcyTjTKqbGkbiyGfC3?=
 =?us-ascii?Q?h9e8AiRwFY0J3VhieIfSeZHWERixgJ9tZSB/sf0QwCJle9PhVPZy1iAuJDpt?=
 =?us-ascii?Q?6i9BaQ345FVJI5LSE9h1csIVghHxo0KM9PyaGVYqWhi/Ckz+QyMWeX6wqIqW?=
 =?us-ascii?Q?KPCk+DxtNbj4JXCxbiJUJ8ougIctzWGIwYY77fCGLxjXWCeTbjhghpc7R3eq?=
 =?us-ascii?Q?3U7p98MYawApT4Y2Fcqc7mFq31v3/U8cbyiZ3WE+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7873fd1d-361a-4b49-75f9-08dd34e3b7c6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 21:38:00.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JGhDOnaO0lqAusGZcD5BZneHCf6zc4RgJrnElyIK7t7AXC96FNcQ05aEDw13//SRTFcS8vZwTBQbANU6Gkqnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4893
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
> registers for the endpoint's Root Port. The same needs to be done for
> each of the CXL Downstream Switch Ports and CXL Root Ports found between
> the endpoint and CXL Host Bridge.
> 
> Introduce cxl_init_ep_ports_aer() to be called for each CXL Port in the
> sub-topology between the endpoint and the CXL Host Bridge. This function
> will determine if there are CXL Downstream Switch Ports or CXL Root Ports
> associated with this Port. The same check will be added in the future for
> upstream switch ports.
> 
> Move the RAS register map logic from cxl_dport_map_ras() into
> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
> function, cxl_dport_map_ras().
> 
> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
> the RAS registers for CXL Downstream Switch Ports and CXL Root Ports.
> 
> cxl_dport_init_ras_reporting() must check for previously mapped registers
> before mapping. This is required because multiple endpoints under a CXL
> switch may share an upstream CXL Root Port, CXL Downstream Switch Port,
> or CXL Downstream Switch Port. Ensure the RAS registers are only mapped
> once.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

