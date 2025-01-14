Return-Path: <linux-pci+bounces-19779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726ACA113FD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D943A3EFC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 22:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4B420F077;
	Tue, 14 Jan 2025 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQOTWmYo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05A20E6E7;
	Tue, 14 Jan 2025 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736893316; cv=fail; b=RMcAhHgdek8uuQfoKlLxxJMDL059rBe87V6V0b0/aVuItr42xNFKMugZjtAM9kAnOlRgbVLPr3Gp0cnSLn+Df8EtDyZu8o79A2gUDav6x2jvkPbfHme2x8bk90S0mUEWP7kDQDapyDeXS2NMqiY8g5T9OuQ3P5F0WXJl8tkQTTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736893316; c=relaxed/simple;
	bh=mCHiIHLLnuH6b0Ocr86KAIhduEnlFiIwzKnXBWsZFxg=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=noV3V2QrHhyJwPdz4O0GO9Fd5mZu+2k3W7FJiKaqOIo0H/42kALwWBG56OZjDQggYlrj2H3b+Rp+adVpQwvITL6Ptu28NlJLJVHQCipxcS45lJOa7voWBkBLsfJuIchCU54bKPIC7FLP+4uFsVAQV5ebir4CL7PghAczguyPh0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQOTWmYo; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736893315; x=1768429315;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=mCHiIHLLnuH6b0Ocr86KAIhduEnlFiIwzKnXBWsZFxg=;
  b=kQOTWmYo8Lm+FEByQVDNIsp/dLZONmRJe7P2jqe8+PoDvGeIQzwu883h
   oEnN6C5Og1I3alW0MKRNwVuzZ0Z7Rdqs4tov2aP4kHLwS5+V+C61SIBm7
   Cd+DWVilRE7T+qTuZO3kWj6+1uhmNYMckyGcZn6cuFeNV/rPkp1RIDZxy
   9KHIJvEY5BIJt8yH0mFcbfgXEbaGMPq6gYexnJ2IcJW9MHAvHOtFvV4/s
   9WTLOKhOFPqYFSuYDv0IhqoP6OntGWMhUN2rJFbtntV05SutC0DkqzyFI
   yca37p9LcGpZ9JYMbtNF3p2FzJF0aA1jNTqq+B1jMXmKgW7DAsBe9OxPZ
   Q==;
X-CSE-ConnectionGUID: hH1FqNRzQFWAG9jEc96qoA==
X-CSE-MsgGUID: 9oIHJ6HsQpOEo9WNjIzyuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="62581230"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="62581230"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 14:21:52 -0800
X-CSE-ConnectionGUID: Bh9plN4sTa+ZpT+9KmnLBw==
X-CSE-MsgGUID: T5iTfg/yQNyE1AeA5pcR5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128182768"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 14:21:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 14:21:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 14:21:50 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 14:21:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJr1D/v7wFFpIDxSfLEIYE2p3N/9LNDiNQWa2MyDyYpHv06KGLyVHLunrl9XeKk5GZqyCx5xqPUgbqZCS310JsbU8H4XF9/oVTzSzVObJB6wwnQXRTh6ZsWpkAmbYCbj7hscJ5WDWeWVBF+wTHtMqPPHyHIMiU5Dr0p2U4xAdASuqjk1A31+TLChyW3Lxy/2BGWkVXjSgdvW5Xz05vOcMFBFeSaqUcWdMB/zNKguf/TZ0BDNx4SqJF9SDIw8ujxfS5DSpf/YQ54fY9HAcq7Ul7/xxzBCBQe88gHMwDa7HozcUiMGT1HFC6HY1MfSHBnOHhGoWA+nEO5hoxR8uXnE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwlsKOQEJoDMGPcaayhXcBIhmp3wJ7xbp7qA7AvRgO0=;
 b=aRXspluMTkpLdyOHF5qeM/+kqZcI6tybmj8XdAOXjpd+2MqvyGO4bXTJ+0WzInpoxuWPb9fPIqQxoz371Be6Aho1uqHS5AjF72JgfIeJogwhvDt0qH3afhjL8G1VZXwhCylsa9tTYXCXZ6UeFuvzphqR19uajHnv9jwXaOjFe9u2nhzRLZOCqRePG4niL5emTqaKHrqVp4rNVCEn8aX4hi4Si8DGXUxMkOTdRIAvlo5jQgHbtozY3x2RHPGy48EmNdPhQdq7vRtgQ9jf/RgJPUqGFDeDcL4RMA1SNfqfWVTL2kMK76FXmtBRC87HUaRdQbGHWPuWCmqzUxK/4O48jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6190.namprd11.prod.outlook.com (2603:10b6:8:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 22:21:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Tue, 14 Jan 2025
 22:21:47 +0000
Date: Tue, 14 Jan 2025 16:21:41 -0600
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
Subject: Re: [PATCH v5 11/16] cxl/pci: Add log message for umnapped registers
 in existing RAS handlers
Message-ID: <6786e375ba578_186d9b2947@iweiny-mobl.notmuch>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-12-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-12-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:303:b6::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2f75bd-bd5a-499d-ffa5-08dd34e9d5ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZA4nFTEOMBw3joFfLoMrao9SwGZ6wQMYJm5TiEUE2NxSOsog+fnTnHKOHJ19?=
 =?us-ascii?Q?9TEcrvRVf5YJ9+iEQ1osefs24GTks+yjpjh+0XydQ7MvIvBBqm7IGTM4DGol?=
 =?us-ascii?Q?EQsSAQTx/s0lfIKBq2k4fcpg4qbMrzt3yFXw0xSF5db9fJ1hnfB2+238fo5v?=
 =?us-ascii?Q?pWbySASDeoYAJR5m4kzOJwyPV3YHpHpTOR36pmpvIo1m/D7UawN88GeB3crq?=
 =?us-ascii?Q?VDsTZ+TyuWNWDcfTtg1O1f1BGewDlieWPxZ7YV3Q3MSZ/U63NgLQMWmUBta9?=
 =?us-ascii?Q?8qc/53h59AgkV5i8K0Lxo6QZbZZueSImXi5nLWLgNyRdAKkLfn5LxFfDhV1Y?=
 =?us-ascii?Q?CMEVn90Mx3O6PJdBjT3208w/Hyz41hGeFizYp/JvOfIFRxUIXGXxMMcTdhZi?=
 =?us-ascii?Q?/SWUhOXP45dErxNLvouwS25uji3FXO8C5hz3Yriicbuje0eMH6y2LSxe886j?=
 =?us-ascii?Q?asazrU3QScR8JhUTfL4McMRFTmRYaZOUuW7q0PJMr6atpunibJMqcVdTFyPL?=
 =?us-ascii?Q?2WESIHL0dwgEZqonAh5b3L3fTkUwUCRutW+I2aS1xF+voulGkcnUbyhlp5Oz?=
 =?us-ascii?Q?q895Zz3GGD0GvoW2niT9Ma8KI9xpRyexZyD4B7viKLFn17yZ5oUoJNgB7j5i?=
 =?us-ascii?Q?s81H2oIPCgV+XrtsKqA6wKPM7Se+PiVclyENPue68826y1qNT4m153e3x1yz?=
 =?us-ascii?Q?BP3VooJ1K+m6RAKcevH5duFJELIb09RPfJeaD3RE6AEyCDzgX4ctBGp6cpU3?=
 =?us-ascii?Q?mF9LkmpDjuqYIZAb+SfEDQhEjUC7SGgRaWTjSoY97e8kMH6tZoGAEasDHn8t?=
 =?us-ascii?Q?y/CwPt4at9/q05x1GloIzobhEGMTtrY5Op9dbOUoYzKxtU+yxCHfe3kWDSDd?=
 =?us-ascii?Q?ofkiXlD7M8FwYKKsAV2hJi1az6vY3TRC5ABtL1JYs0MEGeHGlCeD9yqUid4B?=
 =?us-ascii?Q?XkiIjSiNwVtkiEFoLjnEfHYphHloY0BOxSZo7/CJ0L1hRKGXtZPoSNcSyV38?=
 =?us-ascii?Q?O4uYSmu5Wn2E0UZAdPitgwI5dNV7fyaJSMBjWRIa7VPThHcltUqaT3Gr4cN0?=
 =?us-ascii?Q?xk2FeUOzSseIPcLpX4YDQjclA8PuBYOhD3jREjlg3muOgLlqBQx1X9u2ztQJ?=
 =?us-ascii?Q?zRssf1J06ekqIqh1OJx8BlMettvoj/Q7BcJCq/t6xFNeJHC5xuu6mXRhPdpr?=
 =?us-ascii?Q?BEjAnWh2r0toP/LDBhOw9+oafrxXNNepauCqyj1y5mB2hINhc8T43MSx9CX1?=
 =?us-ascii?Q?h08V2ckEsyDlhKpto/CngvLny4AxfpjIgCD2F4Qp9Kn+CMrakAmgpWdvrFen?=
 =?us-ascii?Q?8vhm71W2LmBDrsa9OrNLly3HUfLCaoiOW+NAYt2KtDLGRxxLszCpO0uRWfp1?=
 =?us-ascii?Q?oJxdpXJOUXWUuF5lMQHYXheEm2hCxHw0AIx18D9bWrE21bcL10+AI2gEEFNL?=
 =?us-ascii?Q?RV3WIFfUYUs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YHtZfuazr0rI7UuRA5Na2yI4NfxxAtG0RNLq++tqZgkm650OEJR2QBBy/GDJ?=
 =?us-ascii?Q?mt8NHoeZjZ358dyz4c6F6Qcoc1Ty3nxyXy+MzX91Ubv27VqYSVeHC3dby66S?=
 =?us-ascii?Q?BW9gjLV2hIIdBWqVnONRpWPcDhWVQb3JAeAKZxPyn06zjEK6a3PMlur9xFMX?=
 =?us-ascii?Q?wbaQ1TOsvedc3pfIj9/Fw2pd6WD+t0kCrH8tpdAZ5oJHh23vC+YmxKdEF/2o?=
 =?us-ascii?Q?AwRxHUzgOX1wyxwDHa8L5JjpURW5oYDYOgMF6okhzf6a3HzR/CjYFXiWBMIx?=
 =?us-ascii?Q?C1mZU921kDfseUXbq1H3Qib78X2amIKdLYBEvCwPDNBfAUp5VAd3IRKEGRH0?=
 =?us-ascii?Q?zSeSDfEbfqly4rliGI0bEqRtqjHDcShZy3fixuHQIXjYfKn8n3xyEKo2WA/R?=
 =?us-ascii?Q?fJY6bCQYJ+978vJypWKDmFB9odUrkBbo2tFeh0/yh4BAQ7uDXQtRgY720iHu?=
 =?us-ascii?Q?6rtDpqsLcqx457q5kPZwlkD4/ij7/TXY5CTTaQ5qWnLQH/ImQkXn7D3YKmzi?=
 =?us-ascii?Q?QcWH6XoZJRVyumgITqbdXQIro+TiTB7Cp+N4851imNhN6JA+x1wgTRcGLV1m?=
 =?us-ascii?Q?wmTh3hhcAUdrVjOd2yxhgho7sVmSUqqFAz92LQHYrbUNMMImhIMDxwLxfWdK?=
 =?us-ascii?Q?9eoHkENMLFSQkRUAuybpn8DT91JY8B3RW3vz49Bbp1d7FJNkuCZjx+4TJNgh?=
 =?us-ascii?Q?f25KGjhkj7H1+yWQOn2cIInASY/dlNRObu+cDxP8MCWedHXN1b1VxLvbWyMc?=
 =?us-ascii?Q?qmfg6l1saH3U7SOz3p9+1PLlZZRY32t3k6/RMea1xaeXpMYZ/y8bfB5IDC3m?=
 =?us-ascii?Q?HOL0XBWQc3oIhd9m11V9VjQU4acPVnMFQ+w3chj/iyFPq8/QKYV3obzFgYYw?=
 =?us-ascii?Q?tqu6ls1RInGZBmUtq9xABwno5kYZDgRCh/Vl3PTI7ZJcI/4WE+1y3gkCJxPD?=
 =?us-ascii?Q?7NsT1JHy9W4uD9u1uOS3UNSc+qtJ0Du5SSgKMK3du2La5bM7GzzXi9rHyFQ4?=
 =?us-ascii?Q?+9zYUUrmfK5nSos4B4MER9WsOUGaBEdrtjv4LyE8A1r6Qf5rXUBZVMQfNuwS?=
 =?us-ascii?Q?X8fwodHyveFNaPAx7W3NSVc2l7b8pD0FORrdJIrAlsLjAp/n7vJLIibooTkV?=
 =?us-ascii?Q?8fmQiLuuB5o5ou4PWplPSE/giKOD2nG5tVj2GfJ4JqVxk9+Q3c/7NZ48TAyw?=
 =?us-ascii?Q?K/6Y4q6Ugjfst7+SkKD2T4yFco0HmYRZVx7pPJgSdlnSO/5HJO5/ZyZh5sDA?=
 =?us-ascii?Q?a1uGu4DcXHAFNDZxqXuyox2wUNzdTlYWbsEwa61nnSyny2aJF4f1aq0vRigu?=
 =?us-ascii?Q?lFxVOjP45uys3vk8Rfz3QsE23DSc7iiI9sdL/28CfyXHzmeuOGbWD3RHmmLf?=
 =?us-ascii?Q?5dfIqYNud98MTTR5KYyXIEM/2yOrf1E6972wG/tX7PsmOAB2XwEXIzvHLTz6?=
 =?us-ascii?Q?M+CFeuhtRmfpOQhyyEyDXQTfmXEcPGN0ueBrCViFINvCN7XMb4U0WO8uG83m?=
 =?us-ascii?Q?BsjjG+fm4oWs6DA8C6P+l1Y+sSuxOpAvO9qvmmkCgc+VNgUyEcBS23EKS3pz?=
 =?us-ascii?Q?Vk1NbGCAKk9czpHtWSlSp+a1jEVGvwn/fncR2HwI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2f75bd-bd5a-499d-ffa5-08dd34e9d5ba
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 22:21:47.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: no2vm1sZVB1Qu6+OkjhiTYCw+UcEIfg3xpfXGTtVeTgdpOehaxgul+253tRPxIZvLQfyQKXopPe/jJYDSi2hww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6190
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL RAS handlers do not currently log if the RAS registers are
> unmapped. This is needed inorder to help debug CXL error handling. Update
                           ^^^^^^^
                           in order


Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

