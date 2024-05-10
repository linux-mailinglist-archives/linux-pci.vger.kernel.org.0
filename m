Return-Path: <linux-pci+bounces-7360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD808C25D3
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 15:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76922814DF
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFBC7E583;
	Fri, 10 May 2024 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Inp7VG6E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F85339E
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347971; cv=fail; b=OK7LKEba84Cr/r7BB1/ksgbso0pMc16Q7EoPkdxop7WbvnoeIDSH4vH4RKaLtyO3A8R/Z4hLkcM/Q8whX9+K76Egx/t7njlJskfOy7mP0YNkLGBJn3jAr74wRKkkVZCjdE3wwwsIFjjo+JuRF5Ogyo07nocjGNxdovmgUWjlD1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347971; c=relaxed/simple;
	bh=3Jy+5zT9ogCb+c7Li9MPmkBc6ii5f9ocr47/erLD8dk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V1Nahv7I7I4UdZXY8LXDJti4AReyBBZKRXJ7rSbdEehCGD0pdTCy2bYEFHfBkNusx5gfGPos70V/l13trRNUwVoxn8IhZXfZsxDmCA6/7XSULXchZZupZTlsKPb1TJ/fhi0ZzXCs05+F3qm4jG9fqEu2VRoyiGBWjXFi82+dcJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Inp7VG6E; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715347971; x=1746883971;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3Jy+5zT9ogCb+c7Li9MPmkBc6ii5f9ocr47/erLD8dk=;
  b=Inp7VG6E2ToKftMXVCUrYW55MXeRa8bdQvrG4quKhASwINdbz/NfQECD
   Qg6pkIqkEuqJ5zKfL8HuQqqWs+ekytexF3Lv6qA+WuzDL+isd5fH/jgVm
   bmfYOkFCzSKBUfodEyWPN8w6ZnpfmU4OegH8SdDVZVwVhMbPpROmmMOr8
   IwZDXlFM9vl2TBvnllk9tOy5AjqbnEMDKTOVFa2EbRHDq0wpgKiiJ91kH
   ORNttn2HbqRwiXfzIPfHZfRa6uLI20E0DoC+ER11DrNwau73ysX4Pxe5j
   pb3SftQ9OJ2PhsjUeIUtvPIc0CDw+ML66YmZjB0dkGa0R98oqm2h8Ye3H
   w==;
X-CSE-ConnectionGUID: NNtIUGDuT4q7UvgB+kT83g==
X-CSE-MsgGUID: T10Q2uhmS8miMCrkR6XkfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28811548"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="28811548"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:32:51 -0700
X-CSE-ConnectionGUID: phJ3jp09RNWjMecpC/PAcA==
X-CSE-MsgGUID: QSY5iqlVRTWgw7jhgJoHMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29724190"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 06:32:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 06:32:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 06:32:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 06:32:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsFXOxylzpvW+vvrZiGAn46EzOzpuWZvkteIK3g3i1GyRVAtgbh16czKYmV9vcu8Ij2c9X375PsYMc7l7ExXtAAih503fvRrBXOynB+wKUcEbRa8XxIHzpLNrK2M8vMbzizeve3GnT127AtXLtSUTc5S4yLt78PX75eGHLri9kbBGF0BXS1lmiWxLcEUIMzUobegK5lMlgaN33VtPCVagkx5H5PzWQWT+yCOCSlip3yQSNSchk6OlrrvB7+lWxHN8nRsbsjdvLZPeJTsYEro/mtQ8VIIloRnV+qrk4w6Zu7yCcn+E9OICxr23sSg3RDoEdp21EPHhaci86hlV68izQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT6yn14O/wG9bHGXdgMzQHpFVjXYvnC2walzBBfATss=;
 b=FbsKVF4g3OlQWIeowX/dxLUnbf5O4PLtegg57BiFX+b4eOA8x2fs165ImrmPMaFYkESOkWrNfbu2seyQXIUm5LY3rKgkFZQ3B4rx6Q+0Z9hqVbsovXkoe/+zwoa16lv9BQrbye2F4CrPdPUPiRKvIFUJPFz5Qcmnt7HpAW7KDJKAQEaDn1jY1UBU3pgvw+lxQOsNdt+d0NCOiSuXDYEC4aT75BQ1iRBVTBsa+QoeVV56U8ZCqnuDDaPihffjDcqWuSPzc8pZ1qreYEt47ZI/Z3kxDIwGKwIJx/gQbWjDP27UAfBIxMGJ6LbJQnjBHUOJ3vk5T5O8T1cNt8b3xW10rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by BL3PR11MB6386.namprd11.prod.outlook.com (2603:10b6:208:3b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:32:47 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::cf6f:eb9e:9143:f413%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 13:32:47 +0000
Date: Fri, 10 May 2024 09:32:42 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 5/8] drm/i915/pciids: don't include WHL/CML PCI IDs in CFL
Message-ID: <Zj4h-t91O0xP_M2o@intel.com>
References: <cover.1715340032.git.jani.nikula@intel.com>
 <7cca91dc78ed2b5982f14e400f03a1704645e475.1715340032.git.jani.nikula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7cca91dc78ed2b5982f14e400f03a1704645e475.1715340032.git.jani.nikula@intel.com>
X-ClientProxiedBy: MW4PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:303:b4::17) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|BL3PR11MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: b11f6097-424f-451c-0687-08dc70f5ae2d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fp4gwIVsczJBUw+ebUpSgUVw2n6xMzkCwR1lJsdDxPr3KjTX2UuBwFDn9Snu?=
 =?us-ascii?Q?5wPNG1k0qlr/JLxFGFcHTC8ga8reXoZfOD6weRfcRTJGyKLtIeY0fAxGUpAP?=
 =?us-ascii?Q?SxKr77w29VmxkySSE9aai4kOTizqumKVHu9BSwrqe7y4gQYcKLp/8DtVEeM+?=
 =?us-ascii?Q?FYuN7d3wEG/BFMxEnbDs5kzPJ+ga7ccQI7zzCpCER688KUJa6CZH7zJzyXFM?=
 =?us-ascii?Q?dZED79Btg7BQyShxwnO352At7swS9L/9L97UVQcDBc0ptqntkWLUo5Hn9QQB?=
 =?us-ascii?Q?NSvKXiFgsBFttiZbtRivpWc6SowD3TmYRt23C4u1hydU17ao4QMyYkoo5KOU?=
 =?us-ascii?Q?Czt7XXXDsSsvnFpV7HZOqlKWQV9MwHNC8oi4olDsKJGD9GY2KoUy3E9Yex6j?=
 =?us-ascii?Q?QLUMIA2aTBtohVQQiGCOkvMWhnqN4kWazSd+HswPUu4zIDLkDsXtvmENPbpq?=
 =?us-ascii?Q?+egBWAbLgJo6cn5SOqlj75R/VvVa81Axz547QcTrFfrZ0b6UXSbZka1YllWi?=
 =?us-ascii?Q?T/VU0I+EUpv72uRZA4hOTBDI/i0Hl/K+r8U6hcZEM/3B+3E29HoscMGqA2AG?=
 =?us-ascii?Q?aM9is1swhOI7Xqs5jmt4aEe0TePyzTNa3O8ElPVKB9zlfx1iw4AjZHjZHpIR?=
 =?us-ascii?Q?neY1krw7iz8HnhV3pJYwz/EREjDt0lT6nGLWVfOQ3sg0JEo1aUoNauJwSRmO?=
 =?us-ascii?Q?LU3BFroigDJX3DdfpdnBZ0dRTqVfjyzXZkau0Uc7s7/TSA9hGn/iy+xyUrqt?=
 =?us-ascii?Q?eDtAxmCP+rMUGfF/rOuA5InHCmbKkKsU/AmOMDqY0+WRdlfQwdl0vqyFliEY?=
 =?us-ascii?Q?PoM2zPv6aBS2oF6HHWqfOWHZS3xJfkG+feMNTKRwDVrhEe22hL+6Abvngc41?=
 =?us-ascii?Q?8revfrQI4KEeJfHn3W+ZQ9el/3J1imVZa0Vf0CupQRZVCIX/CoEknmlDaqb5?=
 =?us-ascii?Q?j9E7IE+cjWd8SEx0xI8RKqCnFZ1FJeCOYKSVRg9uVDwjC2TOCvNMZ1j+fAnq?=
 =?us-ascii?Q?uYonJgsSSrN/QmTqNKVMCLzKZ/2W5KUDhOI+L/1oYhhMWbvuVzfUqRpw3xJF?=
 =?us-ascii?Q?xZJcYItp0n5Ui651jK0KoQbSYRz5O3bUW6iKAaeTb+33ThCTaNz5n+5VaAZO?=
 =?us-ascii?Q?0tzbIBzdxKPGLMwkIOIbETa0ZaQPoD0/2gn7Lid8SiPjOT0GdWP6/oRb7OOB?=
 =?us-ascii?Q?doM0Tqu8Y5AYxh6/b3RfxxfphlRoC2SBskr5qa2Bzw6z0fc3JXZk+Nucteoq?=
 =?us-ascii?Q?mBWuw/Zi8i3yEk4B2YdslDtWhIznG2iNtMxXIu0icw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yvQCfUSaWqMzSzoYgBqP01qHVKvjyvlbHPH7Vjo5wEBLHetNl/9s+THBdOnp?=
 =?us-ascii?Q?+lAiP54bLgi1dSahPlTnqH9BTcJRQLZYLuu2CCq6aFu5e4DCcUvdbZeO0IU6?=
 =?us-ascii?Q?6vFGV4Hl9JE+JXZY1A28iqQqTxUJGStY/Ks1FU3JSI+JzoGXoTJ0KI7rSN9B?=
 =?us-ascii?Q?rHpu9l4h6XrRzz5pmn1TnGPpegPglNBkRVRd6eApOByjpzO4S2b11ENOnUv+?=
 =?us-ascii?Q?yIN61HtJDZNclNuY6JgVhzuKLTo4nDf6Lzcy1JZgMBtvbfPzUhcl9N+5LWMI?=
 =?us-ascii?Q?yExLhz9m6e+6yMCs/lwH5Ocak+zewm8lK+PTwfy0QbDp/j+RLo3jN37K5Ekr?=
 =?us-ascii?Q?MsPfRY2V4GZQouxeZGE5FOAArLHz2FjSB1E0OomfdVP4aD6Z4GUHGKxqBTQb?=
 =?us-ascii?Q?HZG94eeULMjBlBtpmlO7ZKmbO35CE40RlicJ5Hd0CR+NknKVKS+RSTIz/ug6?=
 =?us-ascii?Q?CNgTAjEq3xYZlgMAD++bAm2fGk+h1qNqo924sUY79hgdcc7zeiDejBv3120G?=
 =?us-ascii?Q?+l/9gGQf2cKAW84Bi74xVy3Hq6567MxeSKsb+ReKdyWX3CWyvAkthk8iirwv?=
 =?us-ascii?Q?b3ZTsBkXIBDhRkyKiRNUT1mhwy8m3EN+CznF9xsFkw4n9YTNjSO0McXzVYDz?=
 =?us-ascii?Q?+J7J6Nb+eRIipTyhUzeqEC5iDO1/mn5ejJgAbJqV5VaaxREv+hOWrGegK+qD?=
 =?us-ascii?Q?qO+lkBN/jmFjRegI9JneMXQlGd6ZE13HuBJT6xhIuijYXne9S7gm9z4OsXKD?=
 =?us-ascii?Q?uZSNDI532K8+CYre7MgAfPeowpqYiWRpqMiT71vyLN7azn4wTvV6NQQKuqdu?=
 =?us-ascii?Q?K9TIP9CMoZLR1XUoXtvCIkN9y8IrqXw34XP8sV3Dmd/l65tNvZnRdVDMkDyk?=
 =?us-ascii?Q?h1DLcKPbzC0NgtOpvbJ01Pivu1TMzeeQVTPTOxAlP2siCgcEasGZEj4ZkCV5?=
 =?us-ascii?Q?EixpH+dePNQPbAvwQDT2PsqpR+jR2iJ9qLlPfV/RQn+z8Nmaq5RYhdE5MvwN?=
 =?us-ascii?Q?7goM7kvkWOJbxbomlExGux85mr19WskFXmilyCE6Fn1MNADde8OKOVJKCDyg?=
 =?us-ascii?Q?rlSAkpZNK7K2ExJKYB4QzwhK7xBKg5Ica6AV9BBVRzc8m2Ir6aWJ0xFd2kYI?=
 =?us-ascii?Q?n+bXGkajkUm5cnWT9Gz7lc0IsXhn+lSSDN4QB+VnJTM40tDV2w/AF289I77G?=
 =?us-ascii?Q?VZXlLCifclSpNfZyCYHF12cTb72R13EvTcLjQGRSM376KqgKX2re9XOm7nCA?=
 =?us-ascii?Q?NzG3nQnK/WUtQNkCRDMc1ZiL4sMqIhJS/Mx3eKBc8XoL5wz6IDg4lC/rWC/k?=
 =?us-ascii?Q?XBWC/ik5Os/QU+PBJs75+JmlHmxwYvCdrKXXyB17/ljpdKEZWMut/MCtOASW?=
 =?us-ascii?Q?DFRchkc09sc57VRFndy+vhtZ7VhpzQnwRw+X1P1fsnuiSdOEgMKFP9vc3ls9?=
 =?us-ascii?Q?wF7Ybcz8izdbyJVUeWXe+go+IndY9DYRqtqVmvSoj8xd+PbEpJ5b1dcRvD5J?=
 =?us-ascii?Q?v4lHk0OB58Wtymz92MXyc5kjgQquX3NT37LFT6x2edYWD4cLLcbvQoHn7SiF?=
 =?us-ascii?Q?9UdPAo84i3Bpn+39SiFQxwc0QVMDAveMgR0RrSnRlsGm3VoqeyBZUGaCTZQw?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b11f6097-424f-451c-0687-08dc70f5ae2d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:32:47.4181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6LkcvCNFbczZrkeBX7XEGGnVjQ5FCLAFu1PTqi2d6NrbKn58c6jyk4MwCE9e7NA3Ie+6wY3f9jX//3k3sQ+2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6386
X-OriginatorOrg: intel.com

On Fri, May 10, 2024 at 02:22:18PM +0300, Jani Nikula wrote:
> It's confusing for INTEL_CFL_IDS() to include all WHL and CML PCI
> IDs. Even if we treat them the same in a lot of places, CML is a
> platform of its own, and the lists of PCI IDs should not conflate them.
> 
> Largely go by the idea that if a platform has a name, group its PCI IDs
> together.
> 
> That said, AML is special, having both KBL and CFL variants. Leave that
> alone.

fine by me, and thanks for the CML WHL.


Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>


> 
> v2: Also split out WHL not just CML (Rodrigo)
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  arch/x86/kernel/early-quirks.c                |  2 ++
>  .../drm/i915/display/intel_display_device.c   |  2 ++
>  include/drm/i915_pciids.h                     | 30 +++++++++++--------
>  3 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index 6549507003ec..2b698a3f56ef 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -543,6 +543,8 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
>  	INTEL_BXT_IDS(&gen9_early_ops),
>  	INTEL_KBL_IDS(&gen9_early_ops),
>  	INTEL_CFL_IDS(&gen9_early_ops),
> +	INTEL_WHL_IDS(&gen9_early_ops),
> +	INTEL_CML_IDS(&gen9_early_ops),
>  	INTEL_GLK_IDS(&gen9_early_ops),
>  	INTEL_CNL_IDS(&gen9_early_ops),
>  	INTEL_ICL_11_IDS(&gen11_early_ops),
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> index bb681c8ed8a0..23909a8e2dc8 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -829,6 +829,8 @@ static const struct {
>  	INTEL_GLK_IDS(&glk_display),
>  	INTEL_KBL_IDS(&skl_display),
>  	INTEL_CFL_IDS(&skl_display),
> +	INTEL_WHL_IDS(&skl_display),
> +	INTEL_CML_IDS(&skl_display),
>  	INTEL_ICL_11_IDS(&icl_display),
>  	INTEL_EHL_IDS(&jsl_ehl_display),
>  	INTEL_JSL_IDS(&jsl_ehl_display),
> diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
> index 16778d92346b..0c5a20d59801 100644
> --- a/include/drm/i915_pciids.h
> +++ b/include/drm/i915_pciids.h
> @@ -488,6 +488,12 @@
>  	INTEL_VGA_DEVICE(0x9BCA, info), \
>  	INTEL_VGA_DEVICE(0x9BCC, info)
>  
> +#define INTEL_CML_IDS(info) \
> +	INTEL_CML_GT1_IDS(info), \
> +	INTEL_CML_GT2_IDS(info), \
> +	INTEL_CML_U_GT1_IDS(info), \
> +	INTEL_CML_U_GT2_IDS(info)
> +
>  #define INTEL_KBL_IDS(info) \
>  	INTEL_KBL_GT1_IDS(info), \
>  	INTEL_KBL_GT2_IDS(info), \
> @@ -527,6 +533,15 @@
>  	INTEL_VGA_DEVICE(0x3EA7, info), /* ULT GT3 */ \
>  	INTEL_VGA_DEVICE(0x3EA8, info)  /* ULT GT3 */
>  
> +#define INTEL_CFL_IDS(info)	   \
> +	INTEL_CFL_S_GT1_IDS(info), \
> +	INTEL_CFL_S_GT2_IDS(info), \
> +	INTEL_CFL_H_GT1_IDS(info), \
> +	INTEL_CFL_H_GT2_IDS(info), \
> +	INTEL_CFL_U_GT2_IDS(info), \
> +	INTEL_CFL_U_GT3_IDS(info), \
> +	INTEL_AML_CFL_GT2_IDS(info)
> +
>  /* WHL/CFL U GT1 */
>  #define INTEL_WHL_U_GT1_IDS(info) \
>  	INTEL_VGA_DEVICE(0x3EA1, info), \
> @@ -541,21 +556,10 @@
>  #define INTEL_WHL_U_GT3_IDS(info) \
>  	INTEL_VGA_DEVICE(0x3EA2, info)
>  
> -#define INTEL_CFL_IDS(info)	   \
> -	INTEL_CFL_S_GT1_IDS(info), \
> -	INTEL_CFL_S_GT2_IDS(info), \
> -	INTEL_CFL_H_GT1_IDS(info), \
> -	INTEL_CFL_H_GT2_IDS(info), \
> -	INTEL_CFL_U_GT2_IDS(info), \
> -	INTEL_CFL_U_GT3_IDS(info), \
> +#define INTEL_WHL_IDS(info) \
>  	INTEL_WHL_U_GT1_IDS(info), \
>  	INTEL_WHL_U_GT2_IDS(info), \
> -	INTEL_WHL_U_GT3_IDS(info), \
> -	INTEL_AML_CFL_GT2_IDS(info), \
> -	INTEL_CML_GT1_IDS(info), \
> -	INTEL_CML_GT2_IDS(info), \
> -	INTEL_CML_U_GT1_IDS(info), \
> -	INTEL_CML_U_GT2_IDS(info)
> +	INTEL_WHL_U_GT3_IDS(info)
>  
>  /* CNL */
>  #define INTEL_CNL_PORT_F_IDS(info) \
> -- 
> 2.39.2
> 

