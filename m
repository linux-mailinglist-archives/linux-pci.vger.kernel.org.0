Return-Path: <linux-pci+bounces-21932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B69A3E6EE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 22:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374A8702223
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 21:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40911DFE00;
	Thu, 20 Feb 2025 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMvzm0lr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6226463B
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087876; cv=fail; b=IqAbqGKRHF6zib4sd6O2IZCepga2ASe3IJBytDk1xReRGUJC6OibpIVHTGKkh2z53RtZVkwNUanmmtGwtDPMrcAkW0C2f05XI3MVKvCdIJT7zOYVXLk7dAqKMjw4auz+1Pi7SIIi5+bsMnZ9jCa1D17zTcFzwhDF5rR98406biw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087876; c=relaxed/simple;
	bh=73X6QAWhJv7if5GIAzLq8ZvYJNenN/zvpXPmsKA5uE4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e0fSp6Ly1LIZrvng0ajeIjfgw0Ym1WOE4CAiGVIK/veAwOubw/9op/H6EnnueWhByU6hbF79qXQxh0R1EYJqWiSGIfe1u8GAXIpwvHPdjvqCW34vSyMgYAfNqIAYwxrjq/9dy1KHeW2mmGW8yFScaEMetL5kF/L2b6MthC1EhIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMvzm0lr; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740087873; x=1771623873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=73X6QAWhJv7if5GIAzLq8ZvYJNenN/zvpXPmsKA5uE4=;
  b=SMvzm0lr21japrrrM7P/7gHnBYZRVPxSc0khEu/OYt/eW2l559T+bYf8
   MLQFakutaOJ75OTqJsecPtPAtJS9F43SMiLkGFzEWQkHbNqyu6MZVKP5n
   OfICdZq9qyW2BTjwlugCwyeI0MCAHmYlDqyw/4kUO5KrKuEmVfzqbGWCW
   8lXzNmfOLZ7CdmqNPrp81FaRIaCLkf3HJkKVGSjp29gCvXzkT05R1w0WM
   DCHLFVeqSdKOGWu0tua4+N+8JBEYsdKV6HH/Jtd7hYQgJs6Lg3cEWD0yh
   Y4dNeRmquMJ04bGUV51oZqo7+G+2tgkPrjNT7hVEK08x6Ne8zC+oJ/8M4
   g==;
X-CSE-ConnectionGUID: +VUah75aQimScMwTHUv6kg==
X-CSE-MsgGUID: wM9SVatRQMOMA3qKYIpIqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40078137"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40078137"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 13:44:32 -0800
X-CSE-ConnectionGUID: NbP1M7y4SDOAHgphrcEhfg==
X-CSE-MsgGUID: rMIGZwxMQ2OL9RK9nk8phw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="115372965"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 13:44:32 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 13:44:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 13:44:31 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 13:44:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFm2wZYiFmDrCN1MLYHQHRN6izW8g1xInfI6jxKIWLXc1z/hKEQjsdHW7ZVsJo1W9q+eEE60RRW6vOPT3jDqzW+l70imHfe4PjKOXFbGYTERvuSF2Y5+gFILf9Xb7eDY8z5APlt1tDOH4q7CfAi5IUmrJ3eP/aJLf3hBCvMzsOKBPjTg/njDQEXolOifwobcoWvT9x7xS9qJVXIydcm46Q79qW5oejQ3tgvGbMC9dRGL168f6Eajg1kG7FgEUkhPC3BRrxt3gK5GMYnYD9X7PJPK0V+flH+d78EmZoOUejT/SM2/JRhn7bekamyqHds3XsqWyeqSd0yeLxu88IHUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nz7lqXP4e8sB8cnXnYjQ/MamiEilQvLtUWc0Kt6uGgM=;
 b=nDbuS3qQ8bAlvTGqKdNxB+/8Zts9e7F0pg1cppwVNGmkkPUENalYc/VatmeRbcYtVCTpB/C1UVRXcIqICImDN3qk2aEOMvWLW0BZsQIBcsiKlgIG8Ye6jHxRNxZSgnPxAMUvS3FtJMWg8N+vD0RXZj64Q88JUXe9DinmxrMcZojM1+FAHgSjvQ8O0UUNDmW75IhFV8Or/WGMRQUPqyr3+QwZrydhAqImaUtZP9Uk+sA5iXYxOdnAid8gA8ItFZGD2Zu1Pa9PldnAQ+GvdVQb8PhUbLKnbcdVlfnukU5M/uY2kyXLSnjiXnQbjjysucP+u1+VSFSqjy9PKQausxkCfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7873.namprd11.prod.outlook.com (2603:10b6:930:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 21:44:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 21:44:23 +0000
Date: Thu, 20 Feb 2025 13:44:21 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <67b7a2351d003_2d2c29496@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <ad512345-793b-4cfe-a71b-445f2be64df5@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ad512345-793b-4cfe-a71b-445f2be64df5@amd.com>
X-ClientProxiedBy: MW4PR04CA0236.namprd04.prod.outlook.com
 (2603:10b6:303:87::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e913fc7-151a-44f2-7435-08dd51f7bd7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q5jJdwld/cTK61MwGMQZFHaKC4Vzs1ynGngKa/gWEaDlgwHExZgKWhCxTS3A?=
 =?us-ascii?Q?QMUNkBSoUjETnMyb9T29uALVd48rK2gcVDNc0w73vox22ie/m7C1/WXUHIkL?=
 =?us-ascii?Q?v44Iug56VihqBxHwV5uEkF11g0mYwwugxVvG54eJFMmCPWRGTMdP97BpRzH2?=
 =?us-ascii?Q?EIHBRvYzQhWSxm7mAeEtdh39ylD60xOR5ebOjMcXUJaGPTgFWDhYeD7KSUSe?=
 =?us-ascii?Q?N+gUerLxPRe/5gHdLgrMkasvN0UVgZY8EHiq6UtfiLEv/i78xX75f+A6jfWJ?=
 =?us-ascii?Q?mT0dV5gHVtD6FJdlan49mQyZW4d2HuF8g+1Fo17P0nO8V7eJF3M5B4t8U6h/?=
 =?us-ascii?Q?PasIQ+L1ulZpfdGUPcpeZejpEBh8LBqeSUSK59NaZcatRqV7ffUxbD0Q0DjX?=
 =?us-ascii?Q?GLJ+Zrd63EYgMfDFD0UdmEike3xWZro6KCpXnvpOVD+FNmHIJDYtHQlsNfVu?=
 =?us-ascii?Q?v1NubXbxrIFRgZeHzJ39ag49AM48TfTrGYSAV6QD+O2NzHdDnXLYifsl+JNx?=
 =?us-ascii?Q?3kzTlOl/F3/BVxkCf/2mauacGjclf10gukW0JpQDLNg6izC4Of5+5S4qzItr?=
 =?us-ascii?Q?VaM4XKm7S+ZH/plxL0mhN8wNX5fO3b3QHtd5rAvRqway3h6gt8X3b9JhNxbE?=
 =?us-ascii?Q?iiFQ/2Y5XAYqt4dQxC5jQMUjwtaL/8nbMd7WQqSSqDdiSh+14Tc8bsA+EGgd?=
 =?us-ascii?Q?0lQvAz2aQd74XjE+eZQYKwEdRH6830CpfYkg3SAhj8pv9XUHG+8rKYpPpyuX?=
 =?us-ascii?Q?4pQmmkUBnXlz3YKgXEslLGSNlzu51HbvuzI6PLFmq01J32N9ut7DcS0Z1aPr?=
 =?us-ascii?Q?aNH4qiBEeWahlp98nwdhQ3HNQI9KSq4qVYqnBej33UcLy3/XP9NskizWvROs?=
 =?us-ascii?Q?eCD5TP96ltlZZp0mDV2fXSVrmbX7Y354KDXwrfalNIizaahjGdCymUe1HCBB?=
 =?us-ascii?Q?GHTkOYSfUJCo/cJIWes41YWeGMQM/BS2GXJH9acFnRsutc0OpwGDRk+LN8Vy?=
 =?us-ascii?Q?dIe9Dd1NQB+YyToNvFRxyHze1FnsYyqbgyFzh2QnK/NPEqVlysRXckeTcnip?=
 =?us-ascii?Q?4qdZYfIOvZNnE1D5mwLFvmwqgEzxicNZgAqmwBZGUkdLkQmmJIjNt2YaKubA?=
 =?us-ascii?Q?Zde8KqvvNJfmKtBAYz7AABmoFzgVXPzZUlJLK/BIjBRY4S/WNsrgjUBehLnN?=
 =?us-ascii?Q?E5YeGhIqFYlw34APYyeJhqRE+4ox1DT8hUPS9BGSrMm+wYXpnARcghubIe7c?=
 =?us-ascii?Q?TltIW1+UnvZhBR8s10z0Ndh3yQ0PZ32WllMcyNoywkwtvB85W9pu+H8/bykt?=
 =?us-ascii?Q?/UEUVkrZGzfDcRbZWnHYr+Ca7TkDQCe5TVrxWFt47jcB7zar+86HiIO0SLUK?=
 =?us-ascii?Q?dIeKriXG/GNnHCOJ6atb9DZjx/b2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Wy+joCXnXB4XZjV6thzgcq9XTNqru7DJxu8enJ3xS2nmWiqGWrFxbbnFNML?=
 =?us-ascii?Q?hPlD3d9tNU3ASibgYlr5SI1JjOvzeIynE0WnCJdL+h7FgpF9XvjFpx4iVsp6?=
 =?us-ascii?Q?g812XzLzf2gElxZA2NJCIk8XZ1rEyMwrtt39gVirqJ+UccJRakltbMmpSLZH?=
 =?us-ascii?Q?LMx0KCQgdv+vjTHBDj3eJoLteHOfQ0Ir2Ici7rQu6af6qn333SHpBevqdx3u?=
 =?us-ascii?Q?TowgQpcEysqpEakwTiYcNur4W9ND/mvX1uN/vefGRABnaMzKe/h7LPrZWs1g?=
 =?us-ascii?Q?RomsRr3InkWC4hu/EEGzcLWnx6eYm5XXaqOhY1eicAw9t0zBM5dIT0Ixm32L?=
 =?us-ascii?Q?3B1tSeJMDA8cRPH9grpWUbfY54BGRculMzv/3KI/BUhWVkH/ajoF+l/lhPm7?=
 =?us-ascii?Q?t2hbG7EWbOjKvWjfKWENAy4Y3+j9g+0E6jjnLLy9t4Hyoid4b3/FdurQUAfZ?=
 =?us-ascii?Q?8Ho/o0rV6LWVLhtDW7GyjEZg6jWDQM4mO9vfmnTclcdhncNbyuswpvZUBZHS?=
 =?us-ascii?Q?GIe5pb1U+TjDTyienOEs0EJT4YS6z1K+UqdFz9foil6WikzbWeKoLwcSLKsa?=
 =?us-ascii?Q?+vP1KG8iZeyJGKtrp6fZZSs3lVMktypYIB3899dK/dD/O0sZTckSsNEUJcI3?=
 =?us-ascii?Q?KVIt5RPkXxtrkaidN3xUicL6ril9caEu6yri16zJpJR6u288/CSmf+uicit6?=
 =?us-ascii?Q?yN6tq2Qg4mssEagFDLliLVKvIKZU0364FDi/l8LJ4m3gFcm48pHxss8iiJ/T?=
 =?us-ascii?Q?YBzLtjlfNElE/mzkl5L46iOPYbGKnq7tKYZ5rIIfnE+zdDDI2FUnMm3TyJ87?=
 =?us-ascii?Q?vynCdsSX0lWqxoPJ2aXSzGMZjhisO+y5JhSj7yFB8dGYD3hkGnblbvxLd6dM?=
 =?us-ascii?Q?VdRH25HWwY0vgsqstImsyI2+/NrwrTzzSpGwjy5Q2VVNd0tMDSrF9NLZVCLj?=
 =?us-ascii?Q?wGgfyWDvBn8iyzsT+0bKDrjsjthzCkq3mzyEvYqUCAsxbaIx6SGG/QKQZwEs?=
 =?us-ascii?Q?gqUYYvvtYASQGsgv2MfNpM2H+h6YcufkMahsArp5I4HK2cGK8lWPq+DyKxUo?=
 =?us-ascii?Q?mP9leTOn1MKBVCOo7fmcpacpv8w6wrrY9c4no3mG2CmkYod7zRs9Dn1MJWmF?=
 =?us-ascii?Q?mjdxeKeTQ7SI0i8sau6eplISQvaJ0rqjMfudVYFq7ki0XbpM/TVm/oZFghc1?=
 =?us-ascii?Q?LDdNCfAvfWXh2I70BP65ZTKDxMfy2CzocO32buhetZ7b0rZGz82qvFPcikCZ?=
 =?us-ascii?Q?6QJWP7+sbszAyWU+8fPl9FJrCBLyeCRNPQJSbUHp/rK58/kEGf1NwZdteJIo?=
 =?us-ascii?Q?wjEXWG4ozBPNZd3yX5cn/Rckh108mSddFR/J+3ASBxlLAuo5WxuBs+FQzlUW?=
 =?us-ascii?Q?qjdiqQev0lbqH5RySTPlGm/Qy8Ep3npECyfDhb1DT3wM6+weHkM9GZXZAw95?=
 =?us-ascii?Q?nkv+e+RwVyJGWRewVtrzeB+AzhN8IelQFRecq1KTg2IquD/Ki7XNmowK7wJf?=
 =?us-ascii?Q?2J+kawN/+8tD4bdr9lDhQ+BfWQ7ZPPMN3qbC4chuHBQIP0criIqcNlB3n5oz?=
 =?us-ascii?Q?4g8HqJemBDJbopq043reWEKQhazdDiYRSzdRWlgVAJiybU47A/sKFk7UF2OK?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e913fc7-151a-44f2-7435-08dd51f7bd7d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 21:44:23.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4/q9ckGioJWkpM1Z8Qat4+WqGmOd90YH8h8k2WY3ZZWkEFjBPzM/l1M73z/UGemQIJKV0bnQAzKeVkaU9FmRJ0ABMu9zY6Wo4UwIbQGP00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7873
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> On 6/12/24 09:24, Dan Williams wrote:
> > There are two components to establishing an encrypted link, provisioning
> > the stream in config-space, and programming the keys into the link layer
> > via the IDE_KM (key management) protocol. These helpers enable the
> > former, and are in support of TSM coordinated IDE_KM. When / if native
> > IDE establishment arrives it will share this same config-space
> > provisioning flow, but for now IDE_KM, in any form, is saved for a
> > follow-on change.
> > 
> > With the TSM implementations of SEV-TIO and TDX Connect in mind this
> > abstracts small differences in those implementations. For example, TDX
> > Connect handles Root Port registers updates while SEV-TIO expects System
> > Software to update the Root Port registers. This is the rationale for
> > the PCI_IDE_SETUP_ROOT_PORT flag.
> > 
> > The other design detail for TSM-coordinated IDE establishment is that
> > the TSM manages allocation of stream-ids, this is why the stream_id is
> > passed in to pci_ide_stream_setup().
> > 
> > The flow is:
> > 
> > pci_ide_stream_probe()
> >    Gather stream settings (devid and address filters)
> > pci_ide_stream_setup()
> >    Program the stream settings into the endpoint, and optionally Root Port)
> > pci_ide_enable_stream()
> >    Run the stream after IDE_KM
> > 
> > In support of system administrators auditing where platform IDE stream
> > resources are being spent, the allocated stream is reflected as a
> > symlink from the host-bridge to the endpoint.
> > 
> > Thanks to Wu Hao for a draft implementation of this infrastructure.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> > @@ -71,3 +74,192 @@ void pci_ide_init(struct pci_dev *pdev)
> >   	pdev->sel_ide_cap = sel_ide_cap;
> >   	pdev->nr_ide_mem = nr_ide_mem;
> >   }
> > +
> > +void pci_init_host_bridge_ide(struct pci_host_bridge *hb)
> > +{
> > +	hb->ide_stream_res =
> > +		DEFINE_RES_MEM_NAMED(0, 0, "IDE Address Association");
> 
> out of curiosity - should it be DEFINE_RES_MEM_NAMED(0, UINT_MAX, "IDE 
> Address Association");?

Hmm, yes, an empty resource only makes sense if there is going to be a
later point in the init flow where it is adjusted to map the real
platform probed boundaries, and I do not have that in this code.

The platform iomem_resource boundaries should be settled before the
host-bridge is initialized, so no need to find a later point than this
to set the bounds. Will fold in this incremental change:

@@ -77,8 +77,13 @@ void pci_ide_init(struct pci_dev *pdev)
 
 void pci_init_host_bridge_ide(struct pci_host_bridge *hb)
 {
-       hb->ide_stream_res =
-               DEFINE_RES_MEM_NAMED(0, 0, "IDE Address Association");
+       /*
+        * Match platform iomem resource boundaries for IDE address
+        * association.
+        */
+       hb->ide_stream_res = DEFINE_RES_MEM_NAMED(
+               iomem_resource.start, resource_size(&iomem_resource),
+               "IDE Address Association");
 }
 
 /*


[..]
> > +void pci_ide_enable_stream(struct pci_dev *pdev, struct pci_ide *ide)
> > +{
> > +	int pos;
> > +	u32 val;
> > +
> > +	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
> > +			     pdev->nr_ide_mem);
> > +
> > +	val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
> > +	      FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1);
> 
> 
> FIELD_PREP(PCI_IDE_SEL_CTL_EN) is missing here.

Added.

> And no PCI_IDE_SETUP_ROOT_PORT here, is the platform expected to enable 
> it explicitely? If yes, then we do not need PCI_IDE_SETUP_ROOT_PORT 
> really. If no, then this needs to enable the stream on the rootport.

Hmm, yes, looking at this now, PCI_IDE_SETUP_ROOT_PORT is giving off
"mid-layer" smells and this responsibility should be pushed to the low
level driver.

It is still the case that there is a part of the stream setup that can
fail, like registering the presence of the stream in sysfs, but the
piece that can not fail, __pci_ide_stream_setup(), should be left to the
platform TSM driver to optionally be called for the root-port.

I will rename the parts of the stream setup that needs alloc / free as
"pci_ide_stream_{register,unregister}()", export
__pci_ide_stream_setup() as a standalone helper renamed to just
pci_ide_stream_setup(), and drop the PCI_IDE_SETUP_ROOT_PORT flag
concept.

> Also, my test device wants PCI_IDE_SEL_CTL_TEE_LIMITED to work, I wonder 
> how to showel it in here, add a "unsigned dev_sel_ctl" to pci_ide?
> And the same comment for PCI_IDE_SEL_CTL_CFG_EN on the rootport. 
> "unsigned rootport_sel_ctl"?

I will add that. If the device supports limited stream I see no reason
that Linux would want to not require it (outside of device quirks). So,
the default will be to enable it if supported, but the low-level TSM
driver can always clear that support flag in the pdev (endpoint or root)
if the need arises.

[..]
> > diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> > new file mode 100644
> > index 000000000000..24e08a413645
> > --- /dev/null
> > +++ b/include/linux/pci-ide.h
> > @@ -0,0 +1,33 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > +
> > +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> > +
> > +#ifndef __PCI_IDE_H__
> > +#define __PCI_IDE_H__
> > +
> > +#include <linux/range.h>
> > +
> > +struct pci_ide {
> > +	int domain;
> 
> Not much point in caching this, real easy to calculate in that one spot.

Agree, added an ide_domain_nr() helper to meet the requirement that
software must write 0 if the device has not captured its segment base.

> Thanks,
> 
> ps. I'll probably be commenting more on the same things as I try using 
> all this :)

Hey, yes please! The whole point of this effort is to find a path to
mutual acceptance on all these concerns.

