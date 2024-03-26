Return-Path: <linux-pci+bounces-5199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E235388CCDF
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 20:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216A1B24A3A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 19:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733F713CC4A;
	Tue, 26 Mar 2024 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wb66Hvwg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822F13C9D1;
	Tue, 26 Mar 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480533; cv=fail; b=tzEIHANvNirA9LOIeqk5pfpzezfO2lyaRaS5Am1ypdXXp3CaWJcBwD1VNvbUHkW8u9w2Kfee2p2iy17RLX/qhVnl14IYoEfM4AsdKzFVtYb2854A2dfpIXFxwD/W/EGlUosbVn/82LQfo0EXUNjcudTAH/HLJbCx8fo9WE0wUcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480533; c=relaxed/simple;
	bh=tfZNc8yZ51v0lbzRrBTuk8+UYrrdTKYGY4PrFd1DNnU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K+E94ZgbOEmTH3pGcWXSHPLPOgTxfsYyuWCahKohkOgm8KgGhTntTv3b5WONj5++CLGFUpvsb/SKXrmcGAcTfLupm43gIIoV36KQzxSfMKM9iCNAOYWVdzF07oYCOySZSXbRG/tb+oOWCV4uqRotZSnxTV7tX/pugfPZ1G0lkLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wb66Hvwg; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711480532; x=1743016532;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tfZNc8yZ51v0lbzRrBTuk8+UYrrdTKYGY4PrFd1DNnU=;
  b=Wb66HvwgTSH3I6BqeFR9433RLnF1i+2bBNVdKP1RCplOL6nDxeMHkziT
   l2rKelcZIyirXLubzr5kUXDmbHtMCuk6Fj8UYBiegbuwqjvTjxH+zf76s
   m4JZz2kS5PvWxkXd2cHiZEWzjLzoXvUheawW+ADGplV91d78v5ZZ9YiEv
   Fh3q2RSoYldiHDhR15o4LayKUmwr8W/T9PVWVIW6Xq6gpdHMvDPwAQ1So
   kXjVma74UCZp6Pjc1F//Z4dPFhvcAV9406Kv21qHc5EWPBBsdONjA3EpH
   ZlxNjUSpq7RCgEbkBFMLmnc5nu+oLygKwGhPyC+3IoERmJAimdE97Cd//
   A==;
X-CSE-ConnectionGUID: 9KBVQsA6SmquTl2YQEIHPA==
X-CSE-MsgGUID: 87gOCjp2TX+9wA2iWpCE5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="23995964"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="23995964"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 12:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16052490"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 12:15:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 12:15:29 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 12:15:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 12:15:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 12:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuRaVSTM8wLr9JsuSMP/j4n1bI65v7oxYm9+Xv+0j27JITd5ia32Dadv6K6asTGhJFKwy7Z9e3+EzviBYFJOZmSPnwXHmqVUbDwP5FQ3uptQQiYOJRkXucNbiQBS+e3i7HCs6HkA1qtflUQ/cSuKf7J5uJDloGvjAwNeKLZMrvrzUZwvyia9VCTWzBWmX0nDv80UWFlqrcOEvFmXpSphEMd+HNOR4sDcXjjVIsUZpkw2UKe4J7kQG1deAb6lnswByofWCYB3t5wekjcIst9sQU74xxWYp+Kwy3Gv6hMMNexSqGpH2Iw+F868d+MUs/C83HXaSVd704uVFWBP1d1irg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BSLbiDSqydfaLVHFAjyUQaSXx0KDNOG6W0fpP6hAwc=;
 b=iVwv+ibrM9oZf+mFZiY2Fi4wFzSXaDY4A8CM8PBxwEUq4Ms7vmA7YFYDFhz24YafXh4n7kjm1PrPNcfAJhxpG0apRRCHK3Msm1ec91nvv3eoxQG8Lc+pbyO+OOx1/LIWnc1flBsRYMsC4xioLRqFWprWB6OO7+uypneX/76B996G4Hhgg+ydO7VjKZki8R8CKKFcxfz6fwsARl2jXJ3ij4SRwJVFRZm/ev22DpgidqjLVfCdicVoQ2k1RI2DAeCPNH7Hq9DYGEBkwCHKG0lWd3jJldLqhpJc5zh+KSvlSTSktq1A/E7aV5GIhZtFua6J7q4Rkb5jNVrXfEb8vcuPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 19:15:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 19:15:25 +0000
Date: Tue, 26 Mar 2024 12:15:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	<kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>
CC: <y-goto@fujitsu.com>, <linux-pci@vger.kernel.org>, <mj@ucw.cz>,
	<dan.j.williams@intel.com>, "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: Re: [PATCH v3 0/3] Display cxl1.1 device link status
Message-ID: <66031eca92f5a_4a98a29427@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:303:b4::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5300:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dc1fvm8jLhecDAvP+jEt5XS7Wrf2+ScZ/NnBDZA8NRsSIDu1PmRoTky7D33rVoZucgPzNgc8yjRszQrkNebvREbHNix2klvFnEce7wqPQQ/KZ68X1x/sMiKeVEtkbg3S7F6wrt4STe6KwRezKHqw/iCUGSD2Ql94W9PJeveS42LhsOqaiouYbaG2sYzDXu5/cONwOFLTpynqIAQGX5XujWndvmcyn7Ca+I8XSgE3453WYoT7meW8C4kiV2QP0StIA3JLdYc9drNMT6eYLpPN/bqi+ow7tULeJmZkEA05Fmm8+r0XUHD7v4y8HUovxTpSpHXQgNddyUIh6uqYZkQQbEV9JS5AC+x/n0AyqgU+6oTDu1OzJvU/hJT7DCUDZqAaRnKJHLlJEtAapcGsDM1UYO6OmA/5cKwQ03umWHtH6erJhdHuVL7zxzb/ACvZsrxAa0q5paCWuS7dO5pQNZo4MOCN/vu2arbQG9Si4fm3pEDL8OwWm5/BqDTVhba17kAZwy2NNgwl7vM2+ruWf4+J+FfM2NJym7MbE5Lbl723qQLdDu4vsJRo2lhpTLlZDeDCjhh7r1+YBXOBtzU8LnEkJdiXYeiZBywhr71v8xxWHuEXqark5bW8wE9xZ/Gzuujo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gCroQGZRTzX9BgSRy7vOMovKsQQSDLK2jyl8iBos3lgrrTO89X8F64KHHd0R?=
 =?us-ascii?Q?EkJ8OLSlTYVliYKtNOOYqtfBInytoGc/fNL11sJLjhmvioykeTjh0HvrmUb7?=
 =?us-ascii?Q?C6ycDbstGblwCJFzpq+hopS2gci66o7hOHAzK7HaTv3Kwk9ARf+lr5DgqteH?=
 =?us-ascii?Q?VFHDz+IFZaInVJhfZxgxJbXe9LClQGQIT8ElwaDT7TYKSaEmRTqixPC5hlV3?=
 =?us-ascii?Q?HnvR6X89dc6N6Tfd0lrDTEfqM6oQ2rFJU/pu7VyrZ5GWI1RFFvyNkNShhgcR?=
 =?us-ascii?Q?lDXlWXT4FkmiFMVGVw8Lv8/SWgQZNxTlRSnXiNhWeXKp4XlXt2YBZ/AZwR5d?=
 =?us-ascii?Q?f1WDGG+TI6oeVOXhQE3kFn4z0ref+HgmcTY/ESeF+7pdZtKruS/OhhsXipzk?=
 =?us-ascii?Q?2jppemFhVboKkmQ8nKHLd2jDv3nnqhMuKTAGhcTvLNnvP8uUjtuSmCIKWHLP?=
 =?us-ascii?Q?buTX5oDImpvCYysNTWb68zFu6NLQ8E49ZGtYFE86vinc3fmJmoLzli/X5Zl5?=
 =?us-ascii?Q?0CQmXrcxj6bAB8PsYbZsGto0Z2AgIL99P3tHx5o+FJyMsUJcTMCaFGI8u3Pc?=
 =?us-ascii?Q?muqXblu61gCVyXYNcY4snPmG1DS+cvbdtTvtq/EAbFleN8fII4o6I3aOQgsO?=
 =?us-ascii?Q?NePLJtH1mUz65uPc306cLydppOJXGph4jeMwIn9soqL1iP1J7HbNXvJtpPT3?=
 =?us-ascii?Q?20O2OXi9MEIRtzajzpD4R4GCshDxyl+b1cSKCrE/pMXnafwfIk8rn0EQ1M/X?=
 =?us-ascii?Q?N4uijQrZrqqQ6UcyG9sTeyoElb+4hvqo1asts7cYZoVya0z59ovQl2bum7Lb?=
 =?us-ascii?Q?j4deGicYXaIfCwJpT6NjGZiDNGPPmlaIx/r1Nildytud+wwYZRBbpVsZjrqV?=
 =?us-ascii?Q?eoi1YQ6Bi+lZTRagTcDWJGFTRWY10dROrBSV5BsaIKcTYPlKk+t2UFV2L1LY?=
 =?us-ascii?Q?h9zlg2ZF+PhuuBDEVXD7ez/dk7DF4aIUmtDlfPrkZ4JEFMUHelquMiv3d7nu?=
 =?us-ascii?Q?toD0vr2EVdQvbhUVe3ec7cEhI/4Udv1URivfGAqt9J4tDXfdkpNyUg4tzwJz?=
 =?us-ascii?Q?aiANtQv279/LhbcEZBNDlsyb9Zy21nj2Ml6kdjGUM2C+uDQsJidceyjBbVu+?=
 =?us-ascii?Q?l8WdHeRFwF9erO7uJ68IU8pXbJIzeOy7HYW5Cdx6lo2jcIWHxsKHdTjbhIkG?=
 =?us-ascii?Q?hxdzm+A1f4QGlBINgw5p5u/i0VeyqqBBAhn3PJeoB6FENFEr6Z3reY6hGs4w?=
 =?us-ascii?Q?cPW3I2iLhKhJ6N3iuCnwD/50Q3tZbKI50MWot2XMfbbJLOSG8xwvtIozgRji?=
 =?us-ascii?Q?WmnWEOXMymi8gv688x6SKLeYhPZbR/NzzliFmXbURkwgoHjOe/ykIrDRpFif?=
 =?us-ascii?Q?BicuS+x7dofWjDVu8H723jTHReNuOQ29tHZ0bNw6Cpx3j6qLO69GuAGW3sXG?=
 =?us-ascii?Q?15Dh3n13CyMLE/Pk2FZivBPP0dl2zIaazHZq3XA0O4CoGbgj92YgIRrOWeOg?=
 =?us-ascii?Q?5L410hbgD/5yG90Kho+tQoirL9T5u61miWURMudyciLat4LYS6NHCeK0dSRW?=
 =?us-ascii?Q?176SZFX1+hoJ/EeCJC7c8HzrxCd91Rqme4KltReP656xEGQp6ZM+v1lTu6sD?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5daec6c9-7a51-42ab-7aec-08dc4dc91715
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 19:15:25.4520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nz/J8uDtcHgBBzFw+GKhUOMyDc5wEist1M91gCQE4E6d7uOY3vCp4aLOqMOp5ovpS+DHDGJ9KkIV/eSNnVCt9Q1JYUvqHuN01Yia7qeTdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5300
X-OriginatorOrg: intel.com

Kobayashi,Daisuke wrote:
> Hello.
> 
> This patch series adds a feature that displays the link status
> of the CXL1.1 device.

Good write up! One minor feedback going forward is to drop usage of
"This patch" in a description as that is self evident.

> CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
> the link status can be output in the same way as traditional PCIe.
> However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
> different method to obtain the link status from traditional PCIe.
> This is because the link status of the CXL1.1 device is not mapped
> in the configuration space (as per cxl3.0 specification 8.1).
> Instead, the configuration space containing the link status is mapped
> to the memory mapped register region (as per cxl3.0 specification 8.2,
> Table 8-18). Therefore, the current lspci has a problem where it does
> not display the link status of the CXL1.1 device. 
> This patch solves these issues.

One common way to rewrite a "This patch..." sentence is in "imperative"
tense, so for example:

"Solve these issues with sysfs attributes to expose the status
registers hidden in the RCRB."

...i.e. write the commit log as if the patch is commanding the code to
change. You can find some more notes about this here:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-submission-notes

...but really, this cover letter is higher quality than most, so thanks
for that!

> 
> The procedure is as follows:
> First, obtain the RCRB address within the cxl driver, then access 
> the configuration space. Next, output the link status information from
> the configuration space to sysfs. Finally, read sysfs within lspci to 
> display the link status information.
> 
> Changes
> v1[1] -> v2:
> The following are the main changes made based on the feedback from Dan Williams.
> - Modified to perform rcrb access within the CXL driver.
> - Added new attributes to the sysfs of the PCI device.
> - Output the link status information to the sysfs of the PCI device.
> - Retrieve information from sysfs as the source when displaying information in lspci.
> 
> v2[2] -> v3:
> - Fix unnecessary initialization and wrong types (Bjohn).
> - Create a helper function for getting a PCIe capability offset (Bjohn).
> - Move platform-specific implementation to the lib directory in pciutils (Martin).
> 
> [1]
> https://lore.kernel.org/linux-cxl/20231220050738.178481-1-kobayashi.da-06@fujitsu.com/
> [2]
> https://lore.kernel.org/linux-cxl/20240227083313.87699-1-kobayashi.da-06@fujitsu.com/
> 
> Kobayashi,Daisuke (3):
>   Add sysfs attribute for CXL 1.1 device link status
>   Remove conditional branch that is not suitable for cxl1.1 devices
> 
>  drivers/cxl/acpi.c |   4 -
>  drivers/cxl/pci.c  | 193 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 193 insertions(+), 4 deletions(-)
> 
>   Add function to display cxl1.1 device link status
> 
>  lib/access.c | 29 +++++++++++++++++++++
>  lib/pci.h    |  2 ++
>  ls-caps.c    | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 104 insertions(+)

The typical way I handle cases where I am updating the kernel side and
the user tooling side of a problem is to post the kernel changes and
then separately post the user changes with a lore link to the kernel
submission.

For PCI utils I believe you will need to send a separate pull request
via github once the kernel changes are accepted.

