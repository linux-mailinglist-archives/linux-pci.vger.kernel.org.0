Return-Path: <linux-pci+bounces-42676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32800CA604B
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 04:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98ADA31940A0
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 03:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44C0221DB3;
	Fri,  5 Dec 2025 03:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUgMbJP8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE6518DB1E;
	Fri,  5 Dec 2025 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764905789; cv=fail; b=gPYo+R1xxfCy3/Tccf4na8RV01Q69ivozGc2q05+yuc2+kzqX1Z83lQ+WI0EImOydSUTB+mkkQmugZCjy+9GFT+5cIi2eDr1cR8WqyJ82cUcMZk2Pi22D4G5oJlw3g+iFqf0qD/EJ7clm+CCQ6vax9IToiWM8YDUcSvfacBCWQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764905789; c=relaxed/simple;
	bh=NFeLnXBBAWBAAXwnPkUpxdJgK15wQkbg3XkpO020RYc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jKVNL+bP9txJZf7F3A3jg20DSh/szGqaPQ/RBHTrWRot9RtJ/epJIz9YgUCzkkiZGbFNM90v63NCmtzx0Cz0PgR7cQAr/9CHshZjBlda6sF4QxQvLDv9O3P2T+3X2yw+M8i7EJDH7+ZdAY4sw0E0b27vfWqC37steU7njvk0D6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUgMbJP8; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764905788; x=1796441788;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NFeLnXBBAWBAAXwnPkUpxdJgK15wQkbg3XkpO020RYc=;
  b=nUgMbJP8jihBqXDsUPQD2WlETw16gkkSNzeZytgusb4WaDq7n6pp1DLJ
   WqW46y8Yca5NmtUYPL7ZOLMAV5Jjnh522VmtEpXzyQRDdWfLSfPNRnRsL
   fZ27ZlVgwNNrM2YD/93gip0uYsQbV1679S8yeKQva6p5muTTd00Xtdy/d
   QYDwNRA2YIqCdpjlxCQXjOMmL7QTaDJ8bUHxX/yOdgF8n0avM+lP5scbd
   E1DKsF5q1U9EWLYTYxJAHtlRrdpvcTiM4kCcFIV6AxSBXNo+q2MsnEunl
   MYACRy9iD+cMACfhQN+OPF9amTw/jWx41WgMgrXaosIEdLWb6qd9VkFvo
   g==;
X-CSE-ConnectionGUID: 2IE3PYgkQX6aTnNcqpHoGg==
X-CSE-MsgGUID: Mo2aj147RaaD4l2M+l2onQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="84544994"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="84544994"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 19:36:27 -0800
X-CSE-ConnectionGUID: wrL4q6r8RMyDE2OKeMHvIA==
X-CSE-MsgGUID: dL5DiZ94Qk2FDAcT6F2jcA==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 19:36:27 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 19:36:26 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 19:36:26 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 19:36:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw5zPlvr5U20Z5Z+MfvqW5CoUoFkK5p3OtCF3sLPRgKYhoI7wk4yp06yFf9dP0q7vmqR7iFFN9VNX5fsZZKHD8OZOvv+GMqipTHf5GkBzUEUhrrXj+WDh6Vr8qA8g3vPXgJ1wOhV7vIuAnvginnezrSeHXh49khCqeO8cXKg2HFSAYcAsS/NqBGagET1rWrFR86zWPwPmYvvOT0hD5a3EFuRLeWRZgEk+3fbdDXRpsCXif5KZyAQ5J1t1c0+3go3v1OqFXzafrDwbvrbjRHGQBN9RZ402qVg4MfmOYAYzp5catrkh5ndFsQ1hoGn1fg1PXb8MqloUZtEcFP2xsPDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIpGQDqx4J/OhPP/WhU/2SpqwUrbKmSsIfAHVZHr1jQ=;
 b=pgpinmS9PZbDzLgjsIekSJSZCYjN15s2zyBgsqZfmfnYtIZYRQ0q0QICuD1UvvKjusCecz8cD/NUFGYelp37/ARlPUMc9EDufJA4+npvHDoRZTwLVrU/e7dETvdPHM6a9dH3MeMJflgpo+NiEsrdsSB25xWLPdiPThhXKsVACurx4+SI742iKOJUDfiGr3p2YXpnPRihGGMz+xefNKDAaBPjNhRB2whZpndosNFAc8+gDniAImeCBBhgqP318kIYdsQtSxWpl9AND7RWfhAQV4TAbJQhxLtUZm1AUyBRupB70zeAMmlHxis3clSdW7C6JslE8txF5P9oVIx1qggoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB7967.namprd11.prod.outlook.com (2603:10b6:510:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 5 Dec
 2025 03:36:24 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 03:36:24 +0000
Date: Thu, 4 Dec 2025 19:36:20 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH 3/6] cxl/port: Arrange for always synchronous endpoint
 attach
Message-ID: <aTJTNP5VVbjCQC97@aschofie-mobl2.lan>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-4-dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204022136.2573521-4-dan.j.williams@intel.com>
X-ClientProxiedBy: SJ2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:a03:505::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ed702f-fc2c-42ad-3505-08de33af7718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DcdaSeiUBM7L314uGIBp4MhAQvb+BFVdrX2LW167lqagxMCduq0LSpG7Gwgl?=
 =?us-ascii?Q?xgjLm3D7HbYwTPHz2CYzo6MvZPsIVhfZ7i+4BYSLFF4VlsaVo4oZ1YypB0rY?=
 =?us-ascii?Q?EhNDf9Z4kMJ7KANX0S3sL3YL6R+Eh1xipWyFjozTgbBuW/AJLn8NejCshIMb?=
 =?us-ascii?Q?1ivelfQf9jK5PtbahmKJ3PzUHo5wZVGmPezn000Esru/IbmNBEWQodBpOYE9?=
 =?us-ascii?Q?vqTh33pHodwxws66onuo9q3ZVJruBaYwx0y0nngaT8Ol6PU8AaIc7cG2SQAL?=
 =?us-ascii?Q?wXpoNPnD0z+uOMWFPXBe0tDMyG5jDrG2wwxDBrl7UyGvUQeofaNbz19GNnvO?=
 =?us-ascii?Q?LSVWi2MbEsc6b2czy6v2krRmYmOVkeAqhktZiXuyc29NOpzDx6dKlCta+6Hd?=
 =?us-ascii?Q?6S40sAZcPJfRQxdMrQ+rvPx6IxalIUzh4GxA5kBZs7qUxBY7cn4Drnm6RROX?=
 =?us-ascii?Q?AqqtOMPzUqybXjwrd+X3TRo2fOPa5Fzvhms/w7+DtAnoztZUs8ApfkDacujn?=
 =?us-ascii?Q?o96R9Ey1YfNqYsZSuX3anrC8vA01fbzoKSvZRELn7zTnYBeUIim3Z/KZuCRT?=
 =?us-ascii?Q?4P+5QL/qGioJV9gpe8kxbb0CeigY7/M1LkPXHg2ISaathefoYB32YahB5iby?=
 =?us-ascii?Q?S8MfmOivAzjBfUdf9Hu+rwXnKENBJgh23CTN6OTt+YtDMD9r888yJdbzWh/r?=
 =?us-ascii?Q?n7N3Fv0DvW/a0h9kI38rFkeJe54CXwettX94sQxBvwVzMXP0HZmjYAI3piEg?=
 =?us-ascii?Q?ZkFuttLx4uQQTVs1g4/iEJKfTdHn40jczQroL6paglzVJRiwS3eLo1Fh7lMl?=
 =?us-ascii?Q?Jilu9UL5ovymVytYhtEGszg8xKMZfGuM9ivlvMq8r17tRNUBOxGY5yyIopQh?=
 =?us-ascii?Q?8havI0yz+M25tuzMOTbZcMBwzLIBIbo2KcIVX5WiBl7P7y8RVzEx1O59qEs2?=
 =?us-ascii?Q?RlBj1w9xZW6qTOsQ91NbTlaxbzE21jcdoyLgIcjAOdsj0z05A7k6un1zAj84?=
 =?us-ascii?Q?FGNQ1GXG4TZfjX47xeiuGSTb2u1ZCPSrOXYLcSuxcmHkMHoCAdhNWNCDlPzT?=
 =?us-ascii?Q?YtKwGR/2+OLmgwyqa6E3gSPA4+t0h9uxPpRsfIA9hwsg+VI9BrXR5Mls6CD5?=
 =?us-ascii?Q?KDkg3F1kWIpIshJCP3t/FizSafQD//DmDPjvhlSguLxHTCofmcoSJfP+XkBE?=
 =?us-ascii?Q?L6A0y6ZTfrmgYVfUvpYfi1fZIPLmKD1h3dDALr+Qn6GETYT0BRShsSD3eACW?=
 =?us-ascii?Q?DUPSV8rpt7eMc8PTV3y6LJGDE/KRBP3A9VCnpEkt6yfSd30lAp7RRzrOah6G?=
 =?us-ascii?Q?bUrz2voYzJnWCVq5ukaACKr2M/uk840epoOnnOYpHMhPRxErwepUn4Zxn5Bc?=
 =?us-ascii?Q?BqWk0K7qqC+Z/XG1sRU/ClZbhziEol0xeGNSoabRXvU9iyrGE/74ABDMn6vr?=
 =?us-ascii?Q?vh9DG5rRrGrdknJMte6x5xSjth86tVLr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PXk5EG/8n9PS1MAUdEowSs83f46J8s29s+yOjIIpuXvqg+RMp46A7aRViIir?=
 =?us-ascii?Q?XtZ9iPqZktYzmcQuDaxlwyN+/o/gLbMh4eVJsYuPteq68PPdBBqkZ/QE1b1j?=
 =?us-ascii?Q?aA15LEijk2Iwlow2GsA0RaaPCTwZ6uYL9e8/kXiCEoJKZIFe+8OwNJ6c/jj3?=
 =?us-ascii?Q?Eiu4v9dbvaq3FN2lb+LEGfEZz++18sjm2by77MMJf5gmt+iJvfwKc12lm1zq?=
 =?us-ascii?Q?dvwrYevRMDrNl543Ijh/KSHjVamvpLaEwh6DKbZcOb/0HYBQC2y0FpYH40w2?=
 =?us-ascii?Q?aC2wj/8py7iz3lebLDcue/T7X6jmdwZouT6jFnWehmDFjWIjcAYEQ6oLdyDT?=
 =?us-ascii?Q?59HvumcsPLnjWcNGuu2NFRBIx/FatusElKfOQJfEiqQmAB+tsXx3ugtLkh3P?=
 =?us-ascii?Q?cT30chixNhgBh8Op/YQzKtNwC9WtwuMVJ/rYMof/KMeWfmdQ70R2bioWD+js?=
 =?us-ascii?Q?QX9Uc/VKxk5k7dMjzwjVq4X88fa8bX+O16ZVvmD4lD31c5sVSlk9Csk2hw3n?=
 =?us-ascii?Q?ig9f4KupLS/dONdzCjRhd1cb5vNTQbXcnWZmhE3Yt7CYIV3WC/ib+hlx3+jh?=
 =?us-ascii?Q?fSbC3ZJct5tsA5kiBrM5kG/t5hi+39Bv0IjpxiZ0uxlNQdGw3O/NvBttLn6V?=
 =?us-ascii?Q?xpHifUZZE+YTW8d6RryQbYnSBbVn6u2VugrTYANOi6ab9cGgOG7WltUdMMWT?=
 =?us-ascii?Q?4Mul2QB3ObNR8MF88Uy4xYaUznKY90z9gLCjV7LNW5lZhOG8md/T7z9Ggnr1?=
 =?us-ascii?Q?zIQaitzy1iZJeHdf70rDMNP7YWEzWsPHXKRDtI0bDUX1ltQ0bybUzQItMiIQ?=
 =?us-ascii?Q?AFUoQ8HutyYJdhX6GyvMpOJLd6d3aHWB6YFnPIyDha4l8/ZkjNZLBXXS17YH?=
 =?us-ascii?Q?HIKmbW1egZTsLBfweeuHU9LQxSSX+SpUi7ke4CqWbELqwouqpMo0CY1OLq9j?=
 =?us-ascii?Q?UWYinh1z8n5txXA1Dn+i+Ep1JDIEsqIZahy1mvatR9OS3+ZXIpQ3vt0AJ0ta?=
 =?us-ascii?Q?jZLkuN+j3rb7IkiRfdl33EI8Ui1aI7rrx8IFHP+bM05PnS98xBKgJYrF2+Xf?=
 =?us-ascii?Q?15pcYd5DPq0uunRzo2BTfPpEHgVfBv9y8yD/rk5U2pxvSfgHilZaabDjd7hF?=
 =?us-ascii?Q?pF/xSERiWcMNQT1sFKiOeaFHgnAcXhAHM53MN2zlej1zmt9Gwxy71w0/FJys?=
 =?us-ascii?Q?4RWgY/l5K+yTk0cJvrSMvVsPRq0g4bHoY162rFRdX70YwtLCFYDKwbKT5kLq?=
 =?us-ascii?Q?83gJ55xvCn0Wp/JXiL9FtZszqzN7lyapm2N/aYR05UhW28p7m5qUHBX3wz+o?=
 =?us-ascii?Q?Li/m8zEvrpR7LENu21yJLwZFubHyyQehXeGm5JeGd4E6xOfIlK22eA8M3ku9?=
 =?us-ascii?Q?XPIYLcI+hnhcuBjTUVjIwpxlCMTp9LPE1f592GNRagCMBmZRPVjcN8mzofvy?=
 =?us-ascii?Q?FrpHyBKVGe7dtIpxBnYilNJvPtVe+mULna1/pd63W3V1nIOwoQUwr0U6Vsf2?=
 =?us-ascii?Q?hoR1Uy7YKP84m4bQP/S+r33Y8g0cgAiAT+/9fpwGGBEnf/yOWzEf/mN2Dwp+?=
 =?us-ascii?Q?/6UmS2Wgyeemw9Ih+DdTt/Y+U4/muv8m/qhbxiA1k/UYzPkd7PKSjaXVlAVO?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ed702f-fc2c-42ad-3505-08de33af7718
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 03:36:24.5005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEGKGQiFiSrY6o+KWuQFQyNZ8INRuFGHC2hGASUQpb5NC2bdcAMhN8bZmjVNxuZ+pBZxnqj8mkMRBIP4r6A70kWBD/mvg/JzWEEi+KjCrnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7967
X-OriginatorOrg: intel.com

On Wed, Dec 03, 2025 at 06:21:33PM -0800, Dan Williams wrote:
> Make it so that upon return from devm_cxl_add_endpoint() that
> cxl_mem_probe() can assume that the endpoint has had a chance to complete
> cxl_port_probe().  I.e. cxl_port module loading has completed prior to
> device registration.
> 
> Delete the MODULE_SOFTDEP() as it is not sufficient for this purpose, but a
> hard link-time dependency is reliable. Specifically MODULE_SOFTDEP() does
> not guarantee that the module loading has completed prior to the completion
> of the current module's init.
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Tested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

