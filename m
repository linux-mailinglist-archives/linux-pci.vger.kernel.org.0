Return-Path: <linux-pci+bounces-22605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38E1A48D6A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 01:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7585171221
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 00:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE107FBD6;
	Fri, 28 Feb 2025 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Id691BEw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B86E81749
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702627; cv=fail; b=XXtlCq0Rs4l+WW+W/FYHJGSJDp0usVFP5VCoLTVg2XsjYYXAZl9RA0HRFDr+M1p71bwnAc6RSUlQymCGdmtp1CdrVCv8Ug7fbpe9qcy3xvTgfLwogNjS3FAOrV58smtUIxZPn+8YzqCIc2xwhIfUiYP34equ+IWmPlOU+2uZlCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702627; c=relaxed/simple;
	bh=HAuMQyQUb8V6FjVaTlcliC6k9AvqIIdJAb8uYCWlTZ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KyF95rPtrEhOrasLx68T5iJW7SCAy25R8W0dboDXi3XmxBgsqB2W28/pBvr+RwcR5ijQQSWaCkmGqNEkFwpA8s9xmjnYzlesfO3CRFPSW214SoOkbJzQtlgzAzJWW0ClFDDXJt5PbLQQfb/FZXDNyU6ZpCUBAWRc36Islqsllss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Id691BEw; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740702625; x=1772238625;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HAuMQyQUb8V6FjVaTlcliC6k9AvqIIdJAb8uYCWlTZ8=;
  b=Id691BEw3oWSvngXWfsSUpIgC5cPv0pRlUW7vXziIAGzvnglC+gzFqmR
   j9xNiqjliXOHPNs/txQ/qVx4EgUZCzWe3IOlJMHTUAloKqia3osf4e/ph
   XdOnt0YXZmkcC6wCjroLa1qLYYVjyYSze7d5T+VSKYj3Uq067BOXMqXcH
   680CLtixqP/sm+EfVIi+0vIEdmSJjwk831K7OLGLG0tJnGGyiFewO2Q85
   Ty03c4G1tkOTnPohUWl/thnwSCozB9E59w45bR6Riw25NX+dKBM8xUoRX
   kuN0BBqlH6KuVGy0Frxt2ziffLiGDnwwZD72WQ+UP4xGRF0kxg9ALgaWi
   g==;
X-CSE-ConnectionGUID: qmEQbOa0QjKklmlmaBdGKg==
X-CSE-MsgGUID: ZZN0mqc5S8SKKZVP+SkZ2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45535501"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="45535501"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 16:30:24 -0800
X-CSE-ConnectionGUID: w14OuswBSDSZttWDNL8r4Q==
X-CSE-MsgGUID: LAU3SUKUQqeM6VWfgAAnpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117370966"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 16:30:21 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 16:30:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 16:30:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 16:30:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8hPq4gx0eqBnCgAak+yl3UMH0IYjT+h2rBjB8b2ZHlQzRao4o43Vql5xF60LtMFrYPzm4Xej0qHx/zDHw1oOKydTkGrb3RF4Bu71pZTWyz2vVylx7aSWSXap8nKZ/u5lxtXdv3Gc1SoJXVJR+TVJADNKVqOPUpNNqntOfT+yOaT1t2TtWhC26XtucBRIm8RlSvE4/sZ8M0VmLQu89Y1DIm+63EpQfy2aj+pNnEVRDsKNB+rqRV9LufLBJ58Tz7fTdrIvwLn7lKKCbbE7blX6ZhbMe8CHgeC93UTqU1a23UFbjvaIA9eJa9IzgrD8xk4lpuPJTu9M0r3E5rGnSsXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSzVvhdbKmLXt7Se9ewJ9rafLfpSEeSWW/WGhqzrPyI=;
 b=PDvafD+xF/blQ7QpRyDz2AXucjVdUq3Qv7cf9hKj6Ehx6FpmNnuZ9wU3TM04BlVuY/FOA3mML/4gRowYNPBfUAB+H72Mf5rMjIvAWou4kyvBSffqUgckeqowGeo+KL+hUdkU2/btzRhKsGefktMGp/erCtB0Nl0M+LL0jopgLt4n4HZRVBiNagQtAFtdwwXni8OuhBeQ0k1XTl1SxEhLBvrVwo3XIY1RmrkYlobkO+rFMNVZdUuL8fxloz+UVoeAccjF8cFm7FfACGHkwhqQ5HlZOxW5QZO7RYLCxBBhndonHqFdtu9lmDfWO6Kt+GdSj7mKaArch2wD+TBzxXkX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8247.namprd11.prod.outlook.com (2603:10b6:208:449::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 00:29:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 00:29:50 +0000
Date: Thu, 27 Feb 2025 16:29:48 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-coco@lists.linux.dev>, "Lukas
 Wunner" <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, <linux-pci@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 07/11] PCI: Add PCIe Device 3 Extended Capability
 enumeration
Message-ID: <67c1037c1922b_1a772943a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241210192140.GA3079633@bhelgaas>
 <c7fce545-e369-0dba-fbbe-3d90b67e5cfb@linux.intel.com>
 <67b9172eb5eca_2d2c294b4@dwillia2-xfh.jf.intel.com.notmuch>
 <83d1985d-a843-1d9f-840d-226f68de7d1f@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83d1985d-a843-1d9f-840d-226f68de7d1f@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0261.namprd04.prod.outlook.com
 (2603:10b6:303:88::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 109ab9f7-e15d-4b2d-d77c-08dd578f034f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?9ZJd6SdHIgbbXbbAatbsAnM+CgEpYux6kSXrwYLQAQZKkKLlm1ZALdY8Rs?=
 =?iso-8859-1?Q?pXgO6l422BiRDwoZZSdl4/q6KYIv7jNtJ/zmi/R3CO5hjAviGgrOz7KBCn?=
 =?iso-8859-1?Q?AW2ghFCGOxe270zUVvkiSBWYLJDY5t83GiT8zH4FU2ObE1nUvvWwwpRYMN?=
 =?iso-8859-1?Q?1aba9vw4bfzh5OpXwJp4ZCNj8sFf+n7+J5sJ0n+fA+4jRhLCH1kwdaEZgX?=
 =?iso-8859-1?Q?Mp+hJe1DPfI73yJsSe4+suGWIZsaTcg2QkXrbyMDAYNgVUoPRv3Z69JAJv?=
 =?iso-8859-1?Q?UeU/2aZekmZQ9WT6heZz00VQ2mNpWWCnPsuLe+6+65H7vM5Q8LYqi24UHE?=
 =?iso-8859-1?Q?cyCBpPUtPU2XJLVlhB0Zg/HE4sdE3JBqLIwekKCfu6VgG6XnObnn5Ra5d1?=
 =?iso-8859-1?Q?Kg7iSJ4OxRMIEtLi+SPBZAX5GqDcEBo6Hx7dY0IHp4aMYUK2zud2Mbdcvf?=
 =?iso-8859-1?Q?10/mk/fwtKGM62E+Xcp/uyPGE5nZQtdzwNDQB8Rkbu6n0Opu9JO119HQRw?=
 =?iso-8859-1?Q?oMFhR1uaXblE+wCaPlatUJmrZ0+wqPdmTKay4cXHHfTczkqfzEDzBgoFdw?=
 =?iso-8859-1?Q?MMp7DwgjOBWk+pb+xSKOni7VPFptzxXujLhCGKFT1pYF4MzVZpW/dJwGs8?=
 =?iso-8859-1?Q?bfa3dKTkReXiA7xV//wIg4fssiQtABCc0odtEap5MM1pzsoR6Gpol5qQRN?=
 =?iso-8859-1?Q?1v/PsqMxV2qh2OMfnGbGbbchhRa+HvocMl7vDsde2B+RrdOA4YstErttUg?=
 =?iso-8859-1?Q?r9eO0qia6G8z/62JHDTq24Za/mL2DlE2UJlmD8Fe0dRhAl0s5kvXkizBnX?=
 =?iso-8859-1?Q?WgZRCVIriqLEu9RRPpRUoF73gyBXqpG/9R8YAVPX2LpeTWQncoHRCp1yA4?=
 =?iso-8859-1?Q?92Pg5bvwp1wFbIKQDNMQbMwvdGy0uPexLBrTpnPAevPWa1EpwqLC+dR+24?=
 =?iso-8859-1?Q?vqZXdSYva29yVJsuJj818Ek6sNUD5pYNzoC5/K/8/QmBPdHGPClIMay/aa?=
 =?iso-8859-1?Q?xQuuy+0zR2YDhx9BU2tnzyLRiWd0GDR6Lu/A3LH3Adfk5lClweGvXJExd1?=
 =?iso-8859-1?Q?np+URNanh2btTqizN6xaibF1PBklV7GfMsO2BBsrutMl2zi0YIFLszb80w?=
 =?iso-8859-1?Q?K4OC9iJBXkkOA6PIjR+PPm/3a9d7gqQHrh4FKI2qFNx3JQTBlywA7LQMy3?=
 =?iso-8859-1?Q?UUhKAT10nyfsdiT9NHpnaWyGBUp87apjYTRgYe9xGsuuuFK45PWOte74Bz?=
 =?iso-8859-1?Q?BSg7YWrPQ2QZmtiPOBT9tysp6KvBLZ6wkNz6m1kPS5zRD0whKGAHVLFn0s?=
 =?iso-8859-1?Q?FgOQzMCDUUYGPlieuzoysTRBXvvlEORVVSKgcAFj314xoVkZGWXFBgZBfe?=
 =?iso-8859-1?Q?68FDc9eq2gucxxt5QDy20BNnjG50PzuM5Xvt3tY40t0eI/UmhqPg7BiRKN?=
 =?iso-8859-1?Q?vfQDMKTa4g3enX0w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?s8Fvj+1U629J9UK7f+vdfZPwuhPc7dShnhuL6cZMCSF9ojEMBNfaIiLQBY?=
 =?iso-8859-1?Q?OvZNaJ6kCkRRDulefI2hheQGn0UiQd3KYDo4iy2YROM+QeF8qsNYDjWATa?=
 =?iso-8859-1?Q?ngWzNa81Wcu9/sY+qEOgV8qQZVoWopa7uUzl3Wi0+T9SwmSsDIrvIPIHkn?=
 =?iso-8859-1?Q?X4PHaJndZo+HtPpOPGsLlGOJNOvErQIBXH3DNCQEYVkntd+JgaVW7pzp2G?=
 =?iso-8859-1?Q?ASxxO/qE7TdxsUVFRpYfY+APtuz+ymXiGtj1vm59lJ3wn3IdQ4PXXI/iWv?=
 =?iso-8859-1?Q?eqPHvRL8IHnBL32a8D+PciTMUz3lXtoKDDwl+QEtZbp9LMQrgL7RKHv+wq?=
 =?iso-8859-1?Q?rfqvBj7Go/JMAZYAlHoKBGu8HW7savsn5G0Ml9hwILrsywy8yyH9r55IFq?=
 =?iso-8859-1?Q?vcYOmq9g3hdGPS7psDZbXkySn0rRhz3BVzAv4XmXmXTXJB5Qsu/ZY4xGg4?=
 =?iso-8859-1?Q?LJoVu5WC2n3i5KmL/+ZC40MRoqyUCxen5PCORzTTh2/7DEZWNwBFfd3XO7?=
 =?iso-8859-1?Q?HifeuHW8BGV2xG11NzVzAXEUznmKI4El0kLi4LRkckN3jTM5UVuZy7R5qZ?=
 =?iso-8859-1?Q?nzgMSYE3pS1dRYQNzygJKuMCa37jKJ8KLb9xYMeWM+moF6sH+NGCOlIgTV?=
 =?iso-8859-1?Q?pQv3nx+wUuW0uvgJ1BeUMHton2A+Ok46HiTVeB/QMSF7c9DOkcsjD/lTLM?=
 =?iso-8859-1?Q?dMNJfxl0eLn7/AerSv6M8/BR18gTUVikO4eT6JTYhTif5yGCgWvskhkLnR?=
 =?iso-8859-1?Q?EyRq7bzC45V8jU2CGMtbCiO5OSPk4zZ2xAEcRfs3GBVW9bwMlYoUIWo3jq?=
 =?iso-8859-1?Q?4Qx8S5B+GYRIlfxqqBRHK6YEK++k92btrlHeXuRFCL/b0LAqeLxM4AUCRb?=
 =?iso-8859-1?Q?HGFw9raakdrZC/y6Hc1OBeQnvaB1g2L65Y7lnuto6OIwOQUXnkc7gxiSTh?=
 =?iso-8859-1?Q?zjj8W/avkgzZ0YugO0vn6IOcPxW9r/UR3Mn6JY/vKAfF95j2RuhozdqSDR?=
 =?iso-8859-1?Q?cjYDJhkOteJsf04qjq7YkQZhoMtAPvvCUewfwDjhwvl44xTMOeCNJNEA/d?=
 =?iso-8859-1?Q?B6RbADANyjs+VQgMvgRvmK8oDzGwUs92XlavbYxB7y8UEIfgOW/cpkO+3X?=
 =?iso-8859-1?Q?Ex/e3CEJ4Lof4Nsrc6VyuKDpCaMmDDt+akAOOtnEbbve3w68w+su3fF8qq?=
 =?iso-8859-1?Q?3nO7TryA2Ot9zzpMNQEaiHRbqZQTEY3pGgw4fOqX6cgdezWMmC9qhal1E4?=
 =?iso-8859-1?Q?IUust6JXlIhhoIvVv5PgTyd4HGFijDG8BH92aMFq3ViQgLtTazHKFzimOR?=
 =?iso-8859-1?Q?yTTxXxnVI53aSDW6Dfz/ltsNluhcBFTbbfXSEShIC7RyikC8DrKJTvsccT?=
 =?iso-8859-1?Q?qC0wmR2Vgtgj8fhcM8KL2bcbA1BvthGWO4Ti9Xia9BMmMGbRZh18NkIOdI?=
 =?iso-8859-1?Q?5uvPkVwxuwH+zQP1lNZViFqJjoC2lZ4DofexQUZqNnJRMDRn1v96SGEVJh?=
 =?iso-8859-1?Q?JB/GijJPQrg0BlJErSMnXkByzYn+hwqDWaenwjY+f9y6/JlXlWqVB85Ies?=
 =?iso-8859-1?Q?CeMVCWQADGTxhzvFt8OPL9meo38Qqz62M+TA9YeidFiTbADwrw0Q0UQXDr?=
 =?iso-8859-1?Q?zFUV2OvHFsr6/ZE8bKbW3qJHPl2wqYUzqVFkV8A+kC25wPDsrz60AKPw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 109ab9f7-e15d-4b2d-d77c-08dd578f034f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 00:29:50.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikNV6zplKIwhp2EWXYG/5dAKC7o1pmMophVwopsLlCo+d68OFtEO7ecleHPtBz0QyYR85nHj/tb5nI5d68i2lEQuoVZMVKNxPzr0rxWKmm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8247
X-OriginatorOrg: intel.com

Ilpo Järvinen wrote:
> > Oh, good to hear (the dangers of replying to patch feedback in response
> > order unfortunately means I missed this in my earlier reply). Please
> > copy me on those patches so I can keep track of that discussion.
> 
> Hi Dan,
> 
> I've seemingly Cc'ed you back then:
> 
> https://lore.kernel.org/linux-pci/20241211134840.3375-1-ilpo.jarvinen@linux.intel.com/
> 
> (Np of not noticing, we do get way too much email to pick up everything.)

Oh, I indeed missed it.

> ...There has been no discussion about it though.

Might just need to bump it with Martin with the new information that the
kernel is going to start caring about it soon.

