Return-Path: <linux-pci+bounces-5984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138E689E5D0
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 00:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318A41C21986
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 22:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47211158D8D;
	Tue,  9 Apr 2024 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjZ7Adag"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0CC158878;
	Tue,  9 Apr 2024 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712703376; cv=fail; b=RywOlBOzwDug8sQfZqrFtRvkyjdMGjgipi5TPLJhq+ZkovIUiQONKtfmMONc8+mPc6box8/lH4pzLq/2JFeG2Y8erkJzPDCqery7E57TSXBIfI2zi1+tsOvrtATvOOhdtRWnHMT8q3GMkGsJjJTNwI1xMPzHDOgPWVK3/nGPxAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712703376; c=relaxed/simple;
	bh=BsPK8Gx4EJDrsvN2B562bHu7ACc2+guHoan1obmBXVM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OtLgbnf4qxxkBtKIT7ddUZE4m8Y4XQrT0RWzFZNw6Tr0Z/7Riu9vebRosW9vx4ftXpygjANBaKKVK7l4Px/OM9WPK9rWhAJ2vbzHv40Qbgg85WVHAi6HcATm/3lc2kEA3gKFJF56aMGQL5GaZ0vqkKplqSC+ErClFNkqoJRbab8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjZ7Adag; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712703375; x=1744239375;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BsPK8Gx4EJDrsvN2B562bHu7ACc2+guHoan1obmBXVM=;
  b=mjZ7Adagd6VShvqYfR0Erz5VuXNdV/lHuuQlWfU37ku8onioIFzdV2hT
   fJHi+Uw8pAthNbIXNPUWKJAuBl0y3HWceQd4RtrfpSM1frq8fXnjM9Sev
   Efkm2zjNEjxkHWxnj4W9UHW7WWx0+0ld5MfWsR2qBpf3F8owHcnUr8gYp
   odKGVahiXLZf7eKbPM1cxSGWVRW5LFEDN6nnipkUtgdS1rVlMNfjVKDkF
   r0qUuFvllFEloX+/AvwUQMc0+nsNELWtejYcBOBBBdE5BHL4RHqZBn0OR
   3+ccbw18bz5HRM0qmtO15mCoIzMcO16cIHz4Z0N7WA9xF8os7RFwHsYnv
   Q==;
X-CSE-ConnectionGUID: gmyo4TGtQ4KMdeajA02CqQ==
X-CSE-MsgGUID: XXUxofrITlaRpJOb6iO/cg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7958525"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7958525"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 15:56:14 -0700
X-CSE-ConnectionGUID: UYpgiTTRSr+yT9B4vgUHXw==
X-CSE-MsgGUID: NjoATLoHTamz13rA1NMJtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51343781"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 15:56:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 15:56:13 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 15:56:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 15:56:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 15:56:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsroDn6Fu4tFGpMdR7cNTVG7gJpvz1C5vi2sL3mYg3crJnRMhgiwLUU2dlHqM8cpYbqHKmZzbtRoDMoE7i7ohSLOoDSwGcPrKeA/Q5m3PspIXLu+py5jTGAs4EPPh4UDk+R03/hkiHWrJWUCVz5DzYATRT/eLivIqVYYKUVZY/2FbmInPHi1fsBYNlzMwZ25Quv7vg1LKN4e4FDys9gWr3kTy1XEu8oaPTM+v/cyCeyWJ0ctxAW/R7SrRp1VrW3WCtcWJVdtXDzv/R5W372+lVi9Q0Zk6ToAMh0UHaXPKJ6JM2/rtmrzEggu8vHr3ndkwNMbXnY4Z+/gWJHsXAmBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcylMY7PO6lQE7Bm9didqer0zgOOvOTe94wEV1yCobU=;
 b=izla7deoK3xpI1ax2HCWopNjs/9xz+i6Hlde/5G1sDJA99NT/7iET4GJxENb83EmLhUtd4qgHH2oMFE17VC+FyWcTNVmyUFJGI/Ag0GqHsyYiiOVSaGuqHKx8vj2y9m47ghbySOFy7E0vaHTagNOJESkX063gB8qjR314b08DBXY+4wYrwfhhHJvijybi0cFtnDk2N55ppiB8Pri+4RsVr18ZOrZXH2B+L78IqEtRGj6XOyqx/faQaVl8/QLQLl4HwXbVMqpxm/GtPodnTXzIlMThv5kjhJOhWtCtA+NLc2HKm4juRb6l6T0NHL1qOB674PSEu9THbkhMpKmajEw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5826.namprd11.prod.outlook.com (2603:10b6:806:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 22:56:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Tue, 9 Apr 2024
 22:56:10 +0000
Date: Tue, 9 Apr 2024 15:56:07 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v4 2/4] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <6615c78761bce_24596294cb@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240409160256.94184-1-dave.jiang@intel.com>
 <20240409160256.94184-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240409160256.94184-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:303:b5::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5826:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlWqMzsvm9/QFoLMRNDVa2KCehMIAjUdyiRPGHast7e9CLG0FPEtMkUhccbd2PsTkitLgPYBf4/W2T4+H5rT/0s3dzzScg8BWXMnDLmFy1149kunjR1YdpTeDtjSAfv/Rpxn1BWoscHMKPn2UaYRwTxakjfSt1R6iWpVEkGWG+GdxyOl4xZuc3ZL3+11dc47ZO+ShxPmBXqsBjEPiLT1dOpRpoCrvLV/Bp0/95JbXKnVgBpydhWhuBzl3wfe07RrLtuLFxrOiqcFhLXr4e5tUZb8clpCIXT6rIEi2k/M9VZfxOXvHtOyYHVEOolA1LapSnb6WTyWO4OpD5Vj4rofSHQHW+5YWOfFMa6tFI1hHVcCaqo6p0ay+TonmIXuzDHuLKd1Ge0vOx0L6JgblWOub/O9Dpm2AceI7CYdvaSTR6oLqZZTrbOsZG9RNuV0ndN7Cbc3EMBNCPulyDEBg5ODYtxM0WVTqNcSCGE/35IFB9v0EzqKqBCrmpe/g+KJkav+pXlzlhEMibSfxtlvhWIWjlWYh5/gw4+mTr6lym3saUf/VB6fZON8ErLgzueyt86TGbG47ZpTUqgmVf6GeyKwZPVgLQBNTzaWgBs4EOJuIczcMmf/gHE4Ps6KYYAZ9WiYRhYK5ave9TNbMNyyTStbPnl17/bsFp3D5l/HYeAXJQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m2OwGr4tlG1BCiT3owXirzSHBKKEjeYRy1aKRyosfoVeHkOZlr5vI+u2Y1lh?=
 =?us-ascii?Q?+sqOa88rJw+GIR8ao5v5lxywc/K1g051gYnI7hnm9jGY5Wuj9CJI/S07uo+5?=
 =?us-ascii?Q?aGMXQZVvNgF2AM7yI7cPurmnpJIiSnMO20zc3wj2viKw4Quy4Hq5PwhKHqJz?=
 =?us-ascii?Q?dLgnXsTDwci4WvNWf0lCWy2sZxQ5X4S2qODQgVUmp9+Dgq8yZZ0TdMVhM500?=
 =?us-ascii?Q?6xLPeieQMM6J+8SB+BIlGW3aUPjnchElh6c4aWXoROpPnlN1E6uVPpjZke3t?=
 =?us-ascii?Q?CKmgDsaikSjpl/Oqdd2qI7bqnEdVJoifaVLY4+WID06/F34XIu1DuaDQxk0p?=
 =?us-ascii?Q?QymfJF1xRN9qvvzDj7HzQUHsqzzDhOMGxLbquv5ziohYSIvFKc382dMqrv52?=
 =?us-ascii?Q?NtnwWZYmfeW+af3H3h2r4LZRLHqHUEOkFaUZptMsJbpph0KsjyLopNuHnmxO?=
 =?us-ascii?Q?q5Hg9l4Y5d/w0WjKQ86ro+p+4nsvp8prdTpkxZ8RWqwW2vMGGjCraxpEpJ3U?=
 =?us-ascii?Q?6eE2i3Cg5CUBIrzPjH9DPIrLe14n/DX+kioKpbdcwTZXDDyrr9HwyakoOEIp?=
 =?us-ascii?Q?+jtgE5Nkp+y26S0K0dbB1rOVOwy47i5CXRmQMzRGcdGuZPBRl+31ZnEScFZT?=
 =?us-ascii?Q?s3VsWNzhN5YS/rL1PEc3qwjiDdfhaodFWIE6qM479X3/hcm/iSPNlu8vRK5r?=
 =?us-ascii?Q?1gUvJ/eRwtTsveCDkHvHSPDMMxFWx50iJDuqC8UXLohNuUNEdJImDumm5ute?=
 =?us-ascii?Q?Rz1YF7YGjsQQepB8cwx9Sj86VyXK1KbPjP0Reljiw8XP10kUP8OnwZS0QddB?=
 =?us-ascii?Q?sKXuOOEVgxPTigVZEyvTOZlD0O6y9fUHOfKArFtxvtvvwUXi62UF2DOd01a6?=
 =?us-ascii?Q?Tgsv8S+ERxs+vjT31wQPojRWh8yyDxwsBWoDwZQ9+cqglc6tCXOPpDZPH8Z7?=
 =?us-ascii?Q?Wprq2xIzThifEjgJ+Bi8ZxBMJHahIKxD8Ls7upLBL4iEXcu+9iSCyby3nCUB?=
 =?us-ascii?Q?huSNBVv5Fu955Tgqqqt/htjKqnGJnKDhRKo6sLH30+iGimxKGwgmcDs4sEZK?=
 =?us-ascii?Q?R0spKT0UNcijdhr7qSmAfZqR8mWiNVDCytOCBcLTKgGqh6LbEPNFLscJqAv7?=
 =?us-ascii?Q?Mxj12HaWHSPImyySfhU8FXYX0PijVwpE0dS7xbOh/NFtD/p/+Cd15pwCQSZL?=
 =?us-ascii?Q?yAmC6jUo2StNnX0FqXtRZlBYMt8IgUs8CY6//9NHJdTZGO43gsu13WERC2fi?=
 =?us-ascii?Q?n04ilN71pLPhPBUDqk2Vy/5Ig/d4ceRjVQpMBUsMeS7MLPoMVJrpb3cTPkYx?=
 =?us-ascii?Q?8wfsr1Vxr462h/GjzvIAlcrOODKUtYhASOnIcmTMSdEHZ10ENXZkdP0OttbR?=
 =?us-ascii?Q?fTeTrPRMcn1OxiuU6tfe1K52BT8EQ3HzhretEtBQHxv/DLqSabCFJGdVegED?=
 =?us-ascii?Q?khITKSoq4BcDZZQ0trC2SZ9JR+gzZtyXS02PNt5fTCcazTKoxANU9Y+XCE52?=
 =?us-ascii?Q?PMQDrx3jMbtcRCnqS1Ljg9H9FMmmp5qjQoQNyaVNWGkdE2DFwPsAqJrdz6Fx?=
 =?us-ascii?Q?NwVzm3l/Hf2h0MlIyowObFCYd+OnxS4Vw8HZkh84KYVLJtcgN2bnRjUneFdy?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 390ab23d-cf78-43b2-6cd1-08dc58e83f52
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 22:56:10.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLl1QYOaDrC8DuIi6khWBAOsUWlaZAWHQ/P7OCvWjfkccO+IdC4YOe2ziIVMjq3A2ICR3Xnu5n/HZRK1rlwve4er7i0lO+zgNlb8f5SnLw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5826
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Per CXL spec r3.1 8.1.5.2, Secondary Bus Reset (SBR) is masked unless the
> "Unmask SBR" bit is set. Add a check to the PCI secondary bus reset
> path to fail the CXL SBR request if the "Unmask SBR" bit is clear in
> the CXL Port Control Extensions register by returning -ENOTTY.
> 
> When the "Unmask SBR" bit is set to 0 (default), the bus_reset would

Feels like a missing "Otherwise," at the beginning of this sentence to
indicate transition from what the patch does to what happens without the
patch.

> appear to have executed successfully. However the operation is actually
> masked. The intention is to inform the user that SBR for the CXL device
> is masked and will not go through.
> 
> If the "Unmask SBR" bit is set to 1, then the bus reset will execute
> successfully.

Otherwise, heh heh heh, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...I would say, do not spin the patch just for that small fixup.

