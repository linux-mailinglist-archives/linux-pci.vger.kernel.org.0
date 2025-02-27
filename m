Return-Path: <linux-pci+bounces-22601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4079AA48CC8
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 00:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675A6168AC6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 23:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A892276D02;
	Thu, 27 Feb 2025 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhUDKW3M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D0276D0A
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698886; cv=fail; b=SIkuCQcloTQwbbd/aXHCCUZjciMLW5jPlEoMDMgG2RHsW7Eq3QwGCu9MUuyrvEm4Q1914z/YKo2kfZJueFF1U1kNEvUig0YSDEvkOWm2J5BvMaYxPx+Upkk1nrm0tQj3SMKO6cAxJbJ8g+MyTP4ekGTBZP+J02pLG/TjvloMe4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698886; c=relaxed/simple;
	bh=TxEeugAU7GfvOkb6XU9H8S+PCaU4IfyGBu94CFj3Fa4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=inoP254AJLI7VmuDD6547QLnE3wNdbxyuhYBn6s40b8WbkrebAhmzIrIrrDke3eGzxR+EoKyDDhnDrso1F8ew0/lu4+GxMKsYVfgiVxQf9Davw/Zii/bwp7eHxqCi0WCjxcbW4ysekmpI8nTydAV2fVhrM+xCwTJ4WrAzsee1P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhUDKW3M; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740698884; x=1772234884;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TxEeugAU7GfvOkb6XU9H8S+PCaU4IfyGBu94CFj3Fa4=;
  b=hhUDKW3MZy5+TpkUpgQYSl/a7XIrC+9rsBPMA4S5+Bj6Vc7MIqFREOcu
   gpAhXY4B7/v6V5vxMrVOvYTJeq+gcerFaH4SXQEmUTJ90ovlTbjOamv+1
   67Li52qbyb5bN8QGJTn3bgdskl/KThks84STVXjK3FNgCz3v+BN7rrgql
   HLzGXv05YbbJ6L7fv8xg40aNt4oAs36sFt9KUx8zMec0SObLjjCZpQzrt
   LMWaxxCD1AKJ0xxQmKiC5akj9sutwBNEEKwwkw0K1RX2hYhlqkNZTj1k8
   I0M9ccnjlqgJLEHZQwiqosGQ31g6YryAJvgoYX0c+QPIaNqa5sKcNSj0G
   Q==;
X-CSE-ConnectionGUID: 0EUf/ColTbi0vsnXNXJX4w==
X-CSE-MsgGUID: eDhq+9NOTbiiRsQane54WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45264918"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="45264918"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 15:28:04 -0800
X-CSE-ConnectionGUID: mw647Q+2SSqFx1q+N+sNDw==
X-CSE-MsgGUID: 44yqdvYORUSi9R+l3QVjnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154354508"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2025 15:28:03 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Feb 2025 15:28:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 15:28:02 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 15:28:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vN4Bo5t3OuRSL1FFKKw+AtLXE9Uja5G53j7G8/ClRJGlfXyQCz2xlGCKRjHP0/7gu4EBBleqNgpP5hHI6TQLBIUFEjPJBBxapSIvmsadvzURUcvz5WZqT8hTgAKMmVA7lu2XZZVHVsV+jUfELLEnFyqZyM4zEwDC+X0/ARkC1KNmwVrEZOUcCFip0I03HkPH3paoaePMxkrV3isl01nbQbitIseCabwpYCWSJ0prcXBx5p9OD69ufyQrVDbyeOO+8iyGDdpRI/XEUzTfTIEwnPECg+SboDobFGYyCguHqLvDG2yo2PmoHy1tYw0P7ieoboFtSopYc7uGjQxh+Brt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oetTXHR4QuBLUHWOUOu9at1bdoICAKHorXcoJbLPahY=;
 b=UVEpRts5+WfsjKoKvCXeSlai8Zc1+OXlq6pBhAFxGPsvauikON2byfqhrNxRMq9Apj0ysxqFBr2Xk2EHfuOi4QL7wAgN1iBVmUdBulvnw3LUU49StY9Bd/N1kvc3AkAGAJ6EcHEu5CCNO9SqkHiZ5kmmNdySUoQ1o0LJqSMD/vPe/qBs9iKC3FRCa2GseR/1gA05iCDdlRXsmkgkqEBByuuqu+Z3eyUoQ9TotQDMyiVygW5dupfsqpk6M59fg3v6DUu+c6YF/H5I3X6pZwSX9lJHioDkLSBAGFrNiuIRENuEZFeyywtqypaSnF5h9nlTQ3FrMk0cc1tGjRjKdJJzeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8571.namprd11.prod.outlook.com (2603:10b6:510:2fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 23:27:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 23:27:18 +0000
Date: Thu, 27 Feb 2025 15:27:15 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 11/11] samples/devsec: Add sample IDE establishment
Message-ID: <67c0f4d357529_1a7729483@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343745958.1074769.12896997365766327404.stgit@dwillia2-xfh.jf.intel.com>
 <20250130133917.0000539c@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250130133917.0000539c@huawei.com>
X-ClientProxiedBy: MW4PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:303:8d::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b8d4ed-1962-4505-92f4-08dd578646e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qzFROl3gfbaKPnrEUjLu6/18OrHtz8WEg1FBWZUy81QFFKRGjozax96OL5fO?=
 =?us-ascii?Q?zjJ4u/4Av9jr1mas/eJlv0RbZDeuZuJNvyyQTNPTy/TgLLh0Ei5ePpJK80P+?=
 =?us-ascii?Q?QJNkY7t9rcB2GMrOPoBUvVwH/CEqoZ6zgnD1ixu9TxVDzurJY9pVpBo4b+zC?=
 =?us-ascii?Q?4ANoX02t35w8Iq9wQOBzBWphtlrrJbLfuzemGsnVhVxv5Psm9vib+9ApW9JB?=
 =?us-ascii?Q?39wtWNE9RFUJiy2Bfb92mocOe08aYKkqIuyuLD/w5/1f3vX8U5EW2kscZUe/?=
 =?us-ascii?Q?HPHWzVkIocRsMBcUjwojXbZmGfkL2yIh5RQXvPCRBUwrsWupEo5/UV0+/9rv?=
 =?us-ascii?Q?uxsDpyXlk1aXE30iR5T3V/5pM3XmPGFkbcR+IRP9tOFz+jg36VI/acFEDK7T?=
 =?us-ascii?Q?tNjNWmDZAjnibG0LAG/PM5joxA3EjBHR1nwjr2D4pEDKYtGfuRfYDhwRcTow?=
 =?us-ascii?Q?Q1wLZp32wmlIbL4fhiC+x6E45jPw3ToZ3mJoH3MoNQdtopG3HWONXG0Spv5Y?=
 =?us-ascii?Q?Bjg7U7T+xptAIQn+CXbbp2hmezljHkZ5OztlUmfW0lPWnv3KBIT9Ka1Z6eqa?=
 =?us-ascii?Q?719YR8xJataPPqvcRm2F0hDIVAX1jkx5lj7XEHpSzwBUwHy5xYPVXBVm7gEb?=
 =?us-ascii?Q?s9TwdIp0ruy+GvJW0AJDSPkPdaQDHIvvJqBoiUirGZ7FxrlTN6fFRmZeKGmh?=
 =?us-ascii?Q?U9/js4DYDG2iJ4FLETm7zDY8ayDeCOQ+LFuOJm2U8QrfNjmNUzh/UqTdbv9p?=
 =?us-ascii?Q?tOPGmKSqyGDOrb41u0LcrvqpyiIuuK8+hDW4qFgQiHO3ondkdNkkTcdFZXUx?=
 =?us-ascii?Q?WJ8d855h9KC1LzdlAhGs4QEtK/7dgBRVXs/NJTHmm4oLubW7TWqHeqOPVALw?=
 =?us-ascii?Q?Xcmtq86axCTOxpbduaqcCm2Om34MPwvCXpMXsRKbbqw9pEVAIIGefVzXm+XI?=
 =?us-ascii?Q?d4847TRV30KTu3NwHy2QnTuoaOsa5D4Oci5XWtKffITUIYTGt+RNoRTHQkeX?=
 =?us-ascii?Q?oh63yMsk4rb453lW2iEwxAt3tkiS7sBRkoZ+zxacUlE9OEpu8LyYskjsdN3Y?=
 =?us-ascii?Q?KufrOMOfykKhPX1ona4nn80F+pR3Y6GV6NJ0kXWQX4SR3TxxBYr/+dSIzJDT?=
 =?us-ascii?Q?Qo5wh4rTaQHbFRYEp469Yq3t7m3LZ/MOTGufqJ5zFYFZKw8G/UVYTVETvyR9?=
 =?us-ascii?Q?Yyb9VxelCyrm6JMpvpsctnQnl0xZ5J4Rkdd5PA8PbrK265/kuCquBV0lncHj?=
 =?us-ascii?Q?xRq/aLRMjQrHDnx09PuPTLVTwWMMuFeyPEsPsSDoFo2Lci99UCkd/2rW41ft?=
 =?us-ascii?Q?zf6Ib3N2C9D+Nhs+jfXq7bYxFv1Z8/Rl5fiICDLZnXecA0NpUMoJSYhGcofG?=
 =?us-ascii?Q?lL5S+IdWhnOKPW8LD3s1VKFdk31q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dHAhmoJamGFRMmuuSpVkIl3od3YsOh5pncv+E7z3fnh1/WZeRidkQQ4V7+7U?=
 =?us-ascii?Q?alGQBFFz3H6HshS0M70ePA4Bpo+i+WKbLo9NzFxnO5+77D6ULy5/2NT3QYDF?=
 =?us-ascii?Q?OCrpFnDROX2S4GTapvry7TfqcQQrx7f58oDgmEUVU2RqSs5tApsS1Z5J1mhT?=
 =?us-ascii?Q?7AHZE17Fbx/P0QBlUWfxpZ8rP8kyMpTJUVmfx1ecQmVEroJxrhL4+mZS88o3?=
 =?us-ascii?Q?5TUcTTcvpAG/iaBFQ1Zdg3DX0Man7ed1BPQKiIifxqNHEH0btS435YBml/am?=
 =?us-ascii?Q?tJxxJjXXWjBtJ4kmNRxtkgbGPNh5ob5F5Ck4lUmALYMv8irhKnTHHN8d0dg3?=
 =?us-ascii?Q?2w0BXGUcWmeW6J53sD3hK1R9dGfFp7qZ2dEkpNeiMOCaqyTYOVz30LPLQPfr?=
 =?us-ascii?Q?1aK2qUNrX9TCEy2mRefg1EXF5y3agfaMcH4qjwRq26Gwrp/i12ZnZTLRqFLj?=
 =?us-ascii?Q?0bvGhVOseSMfyxKtPEDyJTITfz2Hs8FSX0tTMzIx28iMlzVNAQJZka73gBCO?=
 =?us-ascii?Q?g21JZtecXaY7n5QG1XrVjwybFbc5l5GzGwLHMBtaVek6aZlX0PWuR2cPubAx?=
 =?us-ascii?Q?sppeAz+deKPyWZi6pYo/5P47jJtTxjtiGGABvNCdedfLnc/hBOv2+UlDPcIQ?=
 =?us-ascii?Q?rSI/MYhERzcNIezdDwa9PBZAnduR8D3yZZ7s29WvNG/dWSi896BECGEq/K4R?=
 =?us-ascii?Q?APyvZanWAygF20UDDrSCm7i9u4JOTiaxbGDiTKC8kv2Z2Ups4lacCroEVslm?=
 =?us-ascii?Q?+0sv7KA49C5jEXZXSu2X7+fOE4pnOCQ/QQq1fpEhnQVhKB95FMGSscJoP5i9?=
 =?us-ascii?Q?uZIssMrOKTAFcg/GTuEZDqMGSX36VesTAyCqNSa/wnre1AJ0CIPFG+jpHFpb?=
 =?us-ascii?Q?4qk3RYRh3v2FPF5ghhyja5NmXhBd+Sca4j9UUNNHTH3LsFipVCLi0BF8VQGK?=
 =?us-ascii?Q?i7Yv+cdnlkxVPONc46x55snm1IuiTLLC1WVDhDxRTuh4o24KYQppftUqhaGv?=
 =?us-ascii?Q?KYBENNGRGPnR+e98f2ZhnMEUvpERHTZzXtg1Y4LQ5Q8M57LhLLpxjbYfm2M1?=
 =?us-ascii?Q?9V7F5CbqAkPYyyxsO+vCqXQje0tOc31AxyTasNsJbR6guxFCIu0q+Nog5jc0?=
 =?us-ascii?Q?3FTgTwCfSwwpS19RpxBnzND9BBY+zhVv2nPp5csFzPANs2PlvMccLTRYBV4g?=
 =?us-ascii?Q?fXBulAKYYJeBvo+uyXOBfHv+YZ3lckN4XPYAPj4Sy311h1DlCZAT3gWbxyNL?=
 =?us-ascii?Q?lkWsa87Mgj6jiv6jK09x3ka+uxBc2VeWvoHcD2XffAwP5TTptkOJmMfvdkMA?=
 =?us-ascii?Q?g8p28o2Dl1uUQIO9y3oUCUnb92EhbyY6MJXBupl8gOocrGjLnAtw/p2Q4MHj?=
 =?us-ascii?Q?001HkR5w6Ap54yli2eh5XhpqSuQruMlrXhWKx73vxJAuxB8b2Z7P4bM2NRfg?=
 =?us-ascii?Q?CYyj6h6Y0dZ18ocxq65WcXUuZQiURolWmBVjOqucEydYMbdxxFosxDtkXvua?=
 =?us-ascii?Q?7jb+nkAykhZ+Zjve0M/tSwntz1OfnMLBlh6oFNkxnpEf796lhm7Bec7ZZE4/?=
 =?us-ascii?Q?p156cYxGMmk9xiRdWV2vqGxEIr/Opsr6Yi1MPTbQj0iGIs3Zv+N/3h9lIBKR?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b8d4ed-1962-4505-92f4-08dd578646e7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 23:27:18.5188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUHwCv3v9uW69RUG6ZouAV/36kbMV1he10YN/40j1hG7X+uGQY57ihvN9+evGPk6B7EGz28wLs2/OSS5Upie6RxNFfd+Owk1cvIV2TVDmiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8571
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 05 Dec 2024 14:24:19 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Exercise common setup and teardown flows for a sample platform TSM
> > driver that implements the TSM 'connect' and 'disconnect' flows.
> > 
> > This is both a template for platform specific implementations and a test
> > case for the shared infrastructure.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Trivial comments inline.
> 
> >  static int devsec_tsm_connect(struct pci_dev *pdev)
> >  {
> > -	return -ENXIO;
> > +	struct pci_ide *ide;
> > +	int rc, stream_id;
> > +
> > +	stream_id =
> > +		find_first_zero_bit(devsec_stream_ids, DEVSEC_NR_IDE_STREAMS);
> > +	if (stream_id == DEVSEC_NR_IDE_STREAMS)
> > +		return -EBUSY;
> > +	set_bit(stream_id, devsec_stream_ids);
> > +	ide = &devsec_streams[stream_id].ide;
> > +	pci_ide_stream_probe(pdev, ide);
> > +
> > +	ide->stream_id = stream_id;
> > +	rc = pci_ide_stream_setup(pdev, ide, PCI_IDE_SETUP_ROOT_PORT);
> > +	if (rc)
> > +		return rc;
> > +	rc = tsm_register_ide_stream(pdev, ide);
> > +	if (rc)
> > +		goto err;
> > +
> > +	devsec_streams[stream_id].pdev = pdev;
> > +	pci_ide_enable_stream(pdev, ide);
> > +	return 0;
> > +err:
> > +	pci_ide_stream_teardown(pdev, ide, PCI_IDE_SETUP_ROOT_PORT);
> 
> I'd kind of expect to see more of what we have in disconnect here.
> Like clearing the bit.

Yeah, that was a leak, now fixed and symmetric.

> > +	return rc;
> >  }
> >  
> >  static void devsec_tsm_disconnect(struct pci_dev *pdev)
> >  {
> > +	struct pci_ide *ide;
> > +	int i;
> > +
> > +	for_each_set_bit(i, devsec_stream_ids, DEVSEC_NR_IDE_STREAMS)
> > +		if (devsec_streams[i].pdev == pdev)
> > +			break;
> > +
> > +	if (i >= DEVSEC_NR_IDE_STREAMS)
> > +		return;
> > +
> > +	ide = &devsec_streams[i].ide;
> > +	pci_ide_disable_stream(pdev, ide);
> > +	tsm_unregister_ide_stream(ide);
> > +	pci_ide_stream_teardown(pdev, ide, PCI_IDE_SETUP_ROOT_PORT);
> > +	devsec_streams[i].pdev = NULL;
> If this setting to NULL needs to be out of order wrt to what happens
> in probe, add a comment.  If not move it to after pci_ide_disable_steram()

Also fixed with the same symmetry as the connect unwind case.

