Return-Path: <linux-pci+bounces-28926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D649ACD45D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 03:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC4117ABCB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 01:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D792749C1;
	Wed,  4 Jun 2025 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YuoD3rLY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A16F2749DA
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999182; cv=fail; b=HZ3BGs432kEwZ6VD8jGt4gmIWGRdYk33aRm5H6ZPDbwk0otx/6Yvb48fSlhc69/WIZ1g9cPPIatu2aC1uuuMDkx59gcavHLZSIFqqsML4hRSavY2A8uWz1fy8w1014y/+OUg7MfiyJ6vBXKO5NxJ45Nc91J5YzTawRDNWu5F2u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999182; c=relaxed/simple;
	bh=0gFI3vqPOpLek4+pcPFI9xuX1+Z5wY/me8M1kg0tUjA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JCLII3gbfeWrK4jgidvy+G7xrnuMHR8rUubdzlHHJyF1t//GGk8NOeZ/voY0ct5WaKNL4bWmalUAAlToJUw5A4BZb/dxcfeECoWQQfq4JskVVl+GsNNl4lpPOsLJ52wUA9p3BxFGqADl/jzVxFRO2Yj1/PK7junI3aHxSyBYAeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YuoD3rLY; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748999181; x=1780535181;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0gFI3vqPOpLek4+pcPFI9xuX1+Z5wY/me8M1kg0tUjA=;
  b=YuoD3rLYKkjr/6ItwcdrqUThSTGXu/LTtu2Y/W+MYRM2upCFAUkZAVgf
   5EdgwKpz1jB1OsuVxsYpJDqJS6aTZR5YBwVheBrAJIAdZ70wHjE4lUinH
   yLSDm6JcoMbQQLtox5FXms/h9RvCvmSHLMtz/yOL9tVwUqJ33Hi+3LRdl
   2KXjOKcfXnzIRzzJTTRBa8PyfiUx9jxL8Fmv1wIt9hS74RVWDDRw9g2cn
   a0VXBRR2OCgOeESfEKXty+eo2WkytDFyYIDLJNrMfHzL6+nwbYJgEcgoA
   bnK76Af9cf/lEy1XWPFLoqA7uJDlTaww/PCs6b5mjqomxSVaYj7B9/l0D
   w==;
X-CSE-ConnectionGUID: qkSzWP4XSYOdMCQd9wWMfg==
X-CSE-MsgGUID: 4eGr8kB9QuuK4MIV9DA07g==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50757949"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="50757949"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 18:06:13 -0700
X-CSE-ConnectionGUID: sx0ZV1eTTD6LBXe73JEpqQ==
X-CSE-MsgGUID: wfHCDtDkQt2nVAQJZMvXEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="150071694"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 18:06:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 18:06:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 18:06:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 18:06:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQ2woaAie+JtTeaw7BbWDkNr6aJ4vwcILv9uP9TndhYIYNcdNdqs9oxbKiR33iY93CUOWcPN2g2tQwv360wcVR74rfpnvSzvZJy6wpRlC82DGTCnhX++/vME6FFBi9An/D3T5436JOfBtOW2oySpdFn2LIGPfXKCKze2f+khow3YCMF0wfos2S1MHXtiDvahi/X1IJLX3TSJAk1dWbLRHGxxPAAp3F5LFRUKSiibp9qlFsxPmGSb6InAk3Xr5oU1a9XszxHWwf6vmOQlNRKjJSq8voKY4Wfe/DAXRrgsMISe4IZjp0LxXNpR9wnyHLVjhJQVkT/wFl6eQ5HvkEoNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hr1A9uZmFJSxu1e1gjrBoZD7AFho3iGkUrS+DWVC+XE=;
 b=QYHGdZRGM6/Tkn9IlyFKKkZgsPr2CNmDm2Un4uL8BfhslW14oV5ai8XWzASkvDhmGqMNFbnwwE82zj0cb1sJWAy5wZfpMP73Y8cs2b0xvl6izWsLWKJ15TNWAuAxKG9N10oXeadKf+Tv+g/N+cm+N6XRJGYw13RnVpok+4hfwljm4MXxNElw1B8jJV7lexFKpXw6v7R7gAphGOJKV2vaOj2Nxn/tgnqCDXwAqVVERCmkHSHKah0jm+WU9EyJzGi4aE6ygqdsIL/DRIdKWcQIPvV3jZzgB4npvOW/jDozCv7w348OihPYnsxS2vxwEQYqMSKNgthOdEHXshiy4H4bBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7867.namprd11.prod.outlook.com (2603:10b6:610:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 01:06:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Wed, 4 Jun 2025
 01:06:10 +0000
Date: Tue, 3 Jun 2025 18:06:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>
CC: Xu Yilun <yilun.xu@linux.intel.com>, Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <zhiw@nvidia.com>
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <683f9c0019be3_1626e100e8@dwillia2-xfh.jf.intel.com.notmuch>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <yq5ao6v5ju6p.fsf@kernel.org>
 <20250603121858.GG376789@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250603121858.GG376789@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: a0cd6afc-7022-4ef5-957b-08dda303fe2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?snIz04u3eWA38gvmZ//tWbrbGnlAWX9AElhsNMJvx+pFu7qwatw6MB8RS6rW?=
 =?us-ascii?Q?y6A4cuW4aBvGBgJO3MJWUjbXXJ9XLMwvPA4CmVUUwmBDUym7qkxyZfX13Grl?=
 =?us-ascii?Q?inOpeNAHs7q/l9EWxvyjG7OG0i2ntsMyMG0+gSumM/6Z8rjqYe+eNKxVZlN8?=
 =?us-ascii?Q?6iikMhdMW7KI7rYd1uN6K7W78pqTkmscry+ycP+UowmNbhuTj9q/2KPw6jj1?=
 =?us-ascii?Q?s475VNPP0IWxke2AGSiei8Bhyh6Xt1BQpCoCSocvCkSKXhLAgUsm+eTyAdUn?=
 =?us-ascii?Q?6KU3MguAO/xxiymoNGiRrBOTR4x4JEMgd3GPLwT1rlPgf/r8hrEgyTuqmDxh?=
 =?us-ascii?Q?c6J4RV8KlQOLWOaUMPstDBX/+v43vZGEwAgnYj0Bj9KdOnE8NuWC6E/sCyD/?=
 =?us-ascii?Q?P2nirx+5hcP8Y269Tv0B6U4YDtU7RXfK90PRDGfsg2z2Uc1whcHaWlIVukHi?=
 =?us-ascii?Q?0qs/PpY1ysEpAFz5puy8KlYu1XTlY9yvqCAuL1yfdjDNsgkXRA1Y+X5JJge2?=
 =?us-ascii?Q?1gx30kAz1EDWQr5+/q+Q+/kZEUuLKM472Fcea09ClnGTX1PoULL7iRUqpA+R?=
 =?us-ascii?Q?O2HsR1A8nFf/chZiJCGwyUYvVQ8b1WnD21vqBw60/+1VOGLG4z1ZkNTxribb?=
 =?us-ascii?Q?6AawGZsHB4gbhyCvdA9z6MkRNSMmQUrr6RONdFPDb7Vl/Ih+H+tZqc75N120?=
 =?us-ascii?Q?IdqrJeryJbOs7Sw0L4ML5c0U14/TmbTuZDMS7Oi4nH6iVW0D0XnmeJ3srVEw?=
 =?us-ascii?Q?lEWEKvgu65tGyN+0Knry+KxDls/EOrDWQZZlJ/rKicbD3VXEcIO2QNEsIlIX?=
 =?us-ascii?Q?iJg0ZR2WwX2Oo/PlUMQksxPUTWPG7lhEDTz1Njyc9KGtJ7UWlzkWEd25DElW?=
 =?us-ascii?Q?/FoZl1nmbbfzR1CdVfGiS+7Av2acP+u8rsAyLKfK5N+6R8sJCKesTcIsyVIY?=
 =?us-ascii?Q?7mF7YMcGv3komc8HN1oEdvaJeu0A/T/wqpPNPwEVyYAXDg9lW8obPs9Bod7J?=
 =?us-ascii?Q?Nifw+50dQsNcnYCnKCz+5alxuUTPK9zaBC3BJsVovlIK90YpotZ/U02/PXIh?=
 =?us-ascii?Q?z/PRaBG52IjVBqbomTMf/sddO7OMlKyAZZiOaYOhOVjHpIx7Tt7vKHzSoP5x?=
 =?us-ascii?Q?f1+ZG6VehRzF4Ku2s0yN2cmxOhAyyv3cw5xmX/4G6EkU58eUSnYHLJoxHvFx?=
 =?us-ascii?Q?Jb0nKkmlx8tICNJfnW1A8G261SMyzIBshKAcFsaZKlab/e3OPdZq3JK/BVzP?=
 =?us-ascii?Q?sNW5pEeJHHnvbGWO400FEdXeU9ngBQAefiSRLbMYIeo6sPYKn6Hp2MoVV/yB?=
 =?us-ascii?Q?Fit/+OqGW8KCtJ51H1Op8SPdrUYe5C6Xtq5RGCGq4jNv11J0nShuXAV7wmc5?=
 =?us-ascii?Q?y5yhgG4b7DzII3oHAnG5hxXfElUyuEp95QmJY4pbgx4BtT1HiHyt7IlIE2dM?=
 =?us-ascii?Q?NAkrDrkDW/s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c7mAVOtJKPxXNqyXPx1LV7jdIcI4nz32L0jLifLAChI1Ov6vDmri0qwjC9n/?=
 =?us-ascii?Q?Q1t4h27FFS5FWOVmsi7xjO45E7JnTUik1Lo+/ooeCrSUFQ2psgtZ5Jigvqh4?=
 =?us-ascii?Q?zfunrSmRGCCeQX1HXVpzUnakhiiPg8QDuI8WbVyWqdgiC06Ua/ZoOlxkIkyt?=
 =?us-ascii?Q?oLyHmdQUHyBN0vQBk1WoR/MvzHnrAPAy73/qQ01Yi/YM1fIpx/2zvRldp27s?=
 =?us-ascii?Q?1fHo6zPjLFjWjhO3b0gQ2UDTPHGo08/Wr/N/iMVhWoXSB12Biw1Oo7oRTF5n?=
 =?us-ascii?Q?EhILtNf6FK0UEW1dCk5G2tUwwv3X26Sxt2HfTtxoVuq0z4dRnM2qZVCGMc+4?=
 =?us-ascii?Q?Rs1vyEYoHviQVMVzfAzpgHtO4RJ1Sy0WFoo4CwMiT4QIyccuKhxQ933XpqWQ?=
 =?us-ascii?Q?VVa4Es5PSOdkl2/WBbG9NcCdd0Rj1p0XY2aEzlyYRFdUsOFLzBB96UPgf64R?=
 =?us-ascii?Q?aCToz+0spnRo0EZtwPbbt+ZKzqPr7t3X+KAu0J0oTuRofNJw610vN3gDo80n?=
 =?us-ascii?Q?7REPZoeSJA1X+7K9toLnNDYl1qLAofeHU3prb7gw7aLSCoZFDs1+3SaR92u7?=
 =?us-ascii?Q?LU5741No/ZS7x3A0ch244NVK0Cei9TzNyaesf2jbpep86sOaceHid/WY/Aqn?=
 =?us-ascii?Q?hEcqfl9c7t1mYr+t0OX6XyD5JZDh4NgrSe3YOOudxztOzHSGyYn7QqUExB9u?=
 =?us-ascii?Q?/sZfX5WkuJ5/eYLwm53vvh5E36aLJnOMGPjNror1M3ceco7cufFiJkfuuLSj?=
 =?us-ascii?Q?LtS7Fkbb7t/f1sXGVVo5/VDwE0HhXT9SsfWNHtFx4UuC8rvM4KyHXKJFtG3T?=
 =?us-ascii?Q?x9+6c5ECnmvaWC4foi4HLqj/fj3GjxL4XV1A8JdpGNpX41SRwvSNgq8zD5Ga?=
 =?us-ascii?Q?IhShz+BlvkwKyK9q+0qbERugoNhSO4OivY3l/9IwXPV0k/5Lid2ToT5pEDY1?=
 =?us-ascii?Q?90HTWKeMgcW2YdiT9av1ke/v/W0J79eYBrV0IdEMmAl0etivRsR8U1LQX63b?=
 =?us-ascii?Q?Zo0jHDYAIqVg9v9hT+1ilx1PBafRM1zSJLjMZz0jUiA4Qq/3K8Jq6t8BHWMP?=
 =?us-ascii?Q?kAyt2Isqrm43zzz9lfFyNcWeqShhbEMrrzmUk1LW7L3B3sfVFJVl2SSx3Gaj?=
 =?us-ascii?Q?5av4bhT+3Ramx5vb6CMUXMoJBsx3z2joLTnP1Y/rYOlhGGXbSdz7ytTpwHXU?=
 =?us-ascii?Q?spi9Za2q0gEeDNjBirHXm0pCk0wIoO39U3HolsCiRBZzMOx8hGKIZVQLSvvy?=
 =?us-ascii?Q?MS2p/roY2I6nBD+L7E5tgVSl77/W5B+ljIunPDEbWAQov3NAP9khPiSmbQl6?=
 =?us-ascii?Q?nDOHudvacBWSZPXWd0zsxazVDax0/nocwlhvajtjV2r9uOqUYRQMygpxafTT?=
 =?us-ascii?Q?QZ0lOloZFhxL9ALq6fpZh5Y8o0SQKst87ayitcEUoQi8s7uaP/c4wt2PGD6r?=
 =?us-ascii?Q?vlPHynJAoSXPJOZuRMUWd5knJLDsIgGTMpkG+YRkqLnN03DuFOkerT1fSFxE?=
 =?us-ascii?Q?4ozJAPrPIjBJe73qi//ZV075DFy98vj/YzeGMLYchpBD1JvTDW4YcD6tug/C?=
 =?us-ascii?Q?C4VIonWOcY59i6paox5elm08R/OGS8gFMBhIkOF5SvlsAcpNsvabaZgMgJz8?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cd6afc-7022-4ef5-957b-08dda303fe2d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 01:06:10.2878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzBYUH0jLDzmLRlwXyRLCK1LkfqC9/Cv8z5rzOFm14IsKvhVsEhhzfNY73oSVyToNbYX1NCo00eFqSbUDRgIeTTbBsOohBiBHIVuKkiC1uU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7867
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Tue, Jun 03, 2025 at 10:30:30AM +0530, Aneesh Kumar K.V wrote:
> 
> > static struct mutex *vdev_lock(struct iommufd_vdevice *vdev)
> > {
> > 	if (mutex_lock_interruptible(&vdev->mutex) != 0)
> > 		return NULL;
> > 	return &vdev->mutex;
> > }
> > DEFINE_FREE(vdev_unlock, struct mutex *, if (_T) mutex_unlock(_T))
> 
> Dn't do things like this.
> 
> We already have scoped_cond_guard(mutex_intr) for this pattern and
> there was a big debate about its design.

The work in progress proposal to improve upon the ergonomics of
scoped_cond_guard() is the ACQUIRE() + ACQUIRE_ERR() proposal [1]. I
need to circle back with Peter about moving that forward:

https://lore.kernel.org/all/20250512185817.GA1808@noisy.programming.kicks-ass.net/

> It doesn't make alot of sense to use that here, this is a place where
> you should not use cleanup.h.

What are those situations in your mind? We can capture that in
include/linux/cleanup.h doc.

My main "don't use cleanup" is when the function still has goto for
other reasons. Make it all or nothing which is already documented that
header:

"I.e. for a given routine, convert all resources that need a "goto"
 cleanup to scope-based cleanup, or convert none of them."

