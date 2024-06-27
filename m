Return-Path: <linux-pci+bounces-9382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A1391ABDB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 17:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3E5282017
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 15:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B6A197545;
	Thu, 27 Jun 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHOIG5hy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63122EF2;
	Thu, 27 Jun 2024 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503572; cv=fail; b=OjzpXsiZPIN9OmERjHW2HWEQC1+9KyWKsAs2exjY1SE0h6+j/1mOq9NdidBySzfimTe+ionpyMSSRmAM7S0auGocJ9FsteYNX8RzNlaLln1MNsyVjnshfX7PyUwXDcbb2zNPCTZLaH4FZo9V3vJfmd5ytuT5xV5aN9HACuFVQH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503572; c=relaxed/simple;
	bh=unlV+lZ6V7LDEmHniCNldP+LUhpKqoTkTSYRrhMsavg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r8/Zuz9JUzRJTz4CUKogpEVt04BQWl9xGNPpXG0dswdkU7BwABmk9AWLWW8Ap9oEvIElHqMPopLndMTZ1eG65Z7kuKRvDRw02ys1SKm28KXXj+LiBxmqPtp5nROoICMmkweYB3wKcvSo87QMjRBHT+dKXi4r3u9ejC1co0h6ge8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHOIG5hy; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719503569; x=1751039569;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=unlV+lZ6V7LDEmHniCNldP+LUhpKqoTkTSYRrhMsavg=;
  b=VHOIG5hyZMVrmwxgkm2NeKvn6sXJI9QaDLeHSEp29tusdulFvA8EUHIR
   nemKPh82OlUDIcTBYqimDaeKblzzYjpAPSib/Ha95HvVs9/OyKRVoReP0
   JookLoZ2dg0HuG/j+AjZtImiMcfbuhNpyJipQDjU+cCigM3pggrIB6680
   Q0r+xuXZugYtde9I9/A+AsjG3zsK2Db1xWbb9spVghI3nbyhZVA/jLiz4
   5sudKRhD6kcOAFD9r8U5RxST2dDGDkfc6r2m9C5w5aPJ72xxCBP/fGIPZ
   8tVSdEMTmrT2fy6GZQm6KYbrJqp/Pm4m04jTbTjcM+bXMHQCPA1u+u1qI
   g==;
X-CSE-ConnectionGUID: ZLu1iY6iRx2LZGl53wUD5w==
X-CSE-MsgGUID: Tx4EGxiDTTG18QFRVjbB3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="34187329"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="34187329"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 08:50:31 -0700
X-CSE-ConnectionGUID: pSrTxNspRUaBLWMIv/zGhg==
X-CSE-MsgGUID: Rbwd263hRKSXg/myrQkWlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44247014"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 08:50:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 08:50:31 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 08:50:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 08:50:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 08:50:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRffNK2JUOMFAmAV3EUuEnjLqbQmYUlT+UwI2S01lXyMBDssIMiyVHqo+alJJ3GOC4nWqRxfQD1EiYwc1gBFEa0VvDjyBboStbHQ2gWP0Vk5HSv+K+I6mo2zTO+o7HivjikuTvYLtvChN6uNJyANm7juDdEh5/F2sVTHqgqTU7shiKI+tnfqarvLtDtmpsH4BNy6ibAm7rwjgM3quVgpJ/piO6ihStQQWA8sr2gF4/hyMUXuoF7yq0fM/b5QiEfCClZk9UeZRVqf4Xcihbc7297j50lKzt132DFMuc1m9kQ4T7hNuneegCu6FFgspG0f6KfutfhIpBW+HMI7OKG09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DlEgy1BeuSrQ1CLjV32X5w8l8nAZH79oUFV62fV5CY=;
 b=f1r0o1nrYgOVYyv5XyxBzn/RBG9JakviXsH8LAInSZjDr7tQQBP/BoPvZPcNj17UvURlY/4GvgsiMElJupLkVrf1xjjLGfjJvSbCxdFljCMToo4JgO+9hACSOkjAt/SjFK4xJ0Nh6fJ+e2KWa1IT1v1B3IpQiDELbk1ORmjPrcKOOgf2tftG/VZehUI4rO9rduXv5EcX/RzRT6lvdQA/7LNzr0rmBlj5vhN1fBKeQn7OVWj3B6RgQSVR1ceFiyqWA9lEZLwIzhBfW2YIks7AtsRNI5BWbeirRLFfBBX+MlT6JUujMX+XTv7IpOWr09kHWSFEH4GkOAT7+7rQXFyOMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB4777.namprd11.prod.outlook.com (2603:10b6:806:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 15:50:24 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.7719.022; Thu, 27 Jun 2024
 15:50:24 +0000
Date: Thu, 27 Jun 2024 10:50:18 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v5 2/2] cxl: Calculate region bandwidth of targets with
 shared upstream link
Message-ID: <667d8a3a4cdd2_2ccbfb294e4@iweiny-mobl.notmuch>
References: <20240618231730.2533819-1-dave.jiang@intel.com>
 <20240618231730.2533819-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618231730.2533819-3-dave.jiang@intel.com>
X-ClientProxiedBy: BYAPR11CA0108.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::49) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB4777:EE_
X-MS-Office365-Filtering-Correlation-Id: 126cdc66-4fc1-4809-dbc3-08dc96c0db77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yFAZuWFL5isjfNmLWdhCnBxXMp6LjCd8uVUl4DmWHk4QVrFkDDxnxiZqsMFN?=
 =?us-ascii?Q?1c0I7WqO3fwCGaryEC0BxDbU3OKFmLTAzld0uoqy+E5teoEPKitxKcV28WS6?=
 =?us-ascii?Q?eGjHfB5lnfERyzFPSTCixB8wTxzV6WyCovCncE/GlWiQzXCN1Mc1FQn69FcY?=
 =?us-ascii?Q?DdrPwC/2QrkYttNmMq0c6JJNsuQV41sb1/A7886/0bJ4FP1G9hcEx+KQ8pnL?=
 =?us-ascii?Q?oOvKmvszPytHp3bjZvxCxm91xo9M007wOxPxyFZD5VvogGMjNoRQWthjKDIo?=
 =?us-ascii?Q?iLZjhdowSoIGx0zXHw5JzVQ1X3pego5JQk1plvUDHGsfKP6DQUg2g/UxF+OT?=
 =?us-ascii?Q?qZezUDvcq6GZyB91hDG81NwQZiiF0k1aqCsMhK/lsfmt54ceLnXRF04oDXsQ?=
 =?us-ascii?Q?qgyd5c/VYrOv3Nve5D/9nRIXqtYqZLPur7SCBzCaFYusGQ7TiHExjL5DfUCw?=
 =?us-ascii?Q?AqoQIEov9I9IpoD34XGIBYGmhaDAWtySOxCKVWGcBs6FI59uL3+3xG/T+EDs?=
 =?us-ascii?Q?HnxG0VRnto6LzJgTU9G4J1dC48ayTSvPVBXO9pLT9zEieRND9nZp+CewtgxZ?=
 =?us-ascii?Q?6o7js6S1K9WEN8Xa8Npaf9P49XHYxIaC5lLFYnA4mrF7/hpeOAGA/Pxmxl3d?=
 =?us-ascii?Q?wJgzFreXKzxuPdd6JxtwS8y6AF36QMD79wkmT5+qGcOnpB+V9x+b+HP9GJ18?=
 =?us-ascii?Q?jSOzTzhHF2Wy0ixbnhu4bVrYBnUDWkBFqJPFiHAnRaQe0tGyd7MBBsqqNeeS?=
 =?us-ascii?Q?QOBk1OOyRewhQ65+k1WYut9dTo8Mwafp6HZHXVzdF0UqIgB23jN9w+dsQzlt?=
 =?us-ascii?Q?Ta+jp1p/AYV7+IlyghDvMi+WIODlaBpzDq8qJE1gcig4wRf3Qn1IUf4d0uE6?=
 =?us-ascii?Q?yePelXK7yXKsNIubJURJsmZiirCk55X3VUKYvQYSBwbW3Mem7kXKPwqypKZW?=
 =?us-ascii?Q?jYKTl4M74Q9AyI+TqC+1vgqxzZzTJvYAxFCZFoTAMKo2SqsKuRzNuFqAujvn?=
 =?us-ascii?Q?H3WRanhdn6gjzSAzbnhIohmjxnW1lC0Yq7kh47mUm3+Cb0IoVisql8gL1vMq?=
 =?us-ascii?Q?BPrHzK9Jk2/F4ORaf5Whmh6Ef5cQE2N2rJYo1E4aiRt4W41I721GxcWGGcOW?=
 =?us-ascii?Q?CRKN9WP4w7renvQ+us4PVkQ2b62R9SYgj6nNkqsGX9woZVgjq/+B8s9JPD+J?=
 =?us-ascii?Q?krbJurs+UhZTH7S7E8fvHtYyAnrsaKrV8L9GqUTiZxUjsmq4iByY4kKOoPYE?=
 =?us-ascii?Q?la2O2cgsRjQeTlRZC/M9JZAbHCL+m1K5eNbcQcRCNdNzOu8civtgyO+GMijW?=
 =?us-ascii?Q?udw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yGOk5iitB0QSVqrWkA3jfXbAiWjyKq19JD70zVfdMG9hV5KtZhh9fmb+u1Vd?=
 =?us-ascii?Q?+iPZ5BVBaL/w8q8uCrLC3UcIvberGAPC1QsHaSWi0YzLK0HQU13c3QAGij+D?=
 =?us-ascii?Q?Sf7aYWq9AP1mBqHtu/Z2x8zb0L+7/y6eJlokJk+aFdyPjvEzstKP+Fhynfiv?=
 =?us-ascii?Q?F9jnrHqsltG0D+udC22xJaZFKVpXcJhtBqga5Ud9p9wswa0aMS03Yg76FHmd?=
 =?us-ascii?Q?SspUkMlgquhjHnjTzjxzQEI+VbjfjKr2GYhlAbDPfCgUvsbehc+3XrLrnl4g?=
 =?us-ascii?Q?wntW/8J0k9kXVRoH2zKrn+VjipifSFkJ3l+P6i2KD0h/iccPFUqtOA1g60gV?=
 =?us-ascii?Q?jFHHpcDbQfhOLQ8duflDWuSORL1pvoFPevz106/TYVKINc+QgrtzVvQPNwpW?=
 =?us-ascii?Q?uql0NLR2M62Q+xZ8sL9B4WxTN4VXWL+5p1j15llaHJMaLHkarDPEHBR80k9Q?=
 =?us-ascii?Q?Ugm62il9r2j4yXB5JL8X+mmK+0bxRC2OA5xHbM+DTj8fANuLxX+Ira/kgNj4?=
 =?us-ascii?Q?JVoImWdRlMIq+Ki4MVX0EZAnv56j9JyUQc93eW8Mbyq9XcM3zFaxyMAkMJI7?=
 =?us-ascii?Q?OrBWE8w98/sYJVpIZ5GCDemv/qN4y3NP91LGAywvDovM2sFa4GV2gMetb5vc?=
 =?us-ascii?Q?gfmze9THSpi6xmdZBUbEMQoP96r13w9zTD0egcnEA+fkvDu2T/TaStOFrw/l?=
 =?us-ascii?Q?r3vcp0UxPNknkBY0onfaaGgQetvf6jQaOEMQzJg8rccadYjr6uytJlgU4/WW?=
 =?us-ascii?Q?Fb3UI25XCbMNcKKL7WDWIUKmS+ONi2ZtVvmgf9bFZv/xjh+9/YyUWp+59Bdj?=
 =?us-ascii?Q?com66E9V+C8qo6a+KjvNdqxyV0ZrR0653CW7lje/Tqqzr7ZphSiOHkJCuiDu?=
 =?us-ascii?Q?T/R24WefXCK+lgDWZZ9qVFOjnXqxcRHY+9V/qtSBxlii/y/qrXFTQlmpWpi9?=
 =?us-ascii?Q?J0JsNJKYAYatKajXko0glDo/p+S9EJzO8NehKND5o92CBNw6LHO+DHYEXru+?=
 =?us-ascii?Q?i3HShUJCteunyJpvCfZKcQKWLNjBMH+2Qyhc5k+d/PNxhq1NpbGyDxVFkVaO?=
 =?us-ascii?Q?7hcU8Wjy7HjKUR1SCEHJFW+2JNbJWLYHakv3y965o+y1vei0LsC6NKXZqQOw?=
 =?us-ascii?Q?R/Use0qa0cUPp/uRYXW+LCTebUnP23+2vZ+nMnP1x/p5Y8vbsj1He13QBC4h?=
 =?us-ascii?Q?BCJ9b+WVeU84KolcM5DuuHBdDqa7a/ftpdEe1zsreGVdCwoH7ziNjSbLNR9F?=
 =?us-ascii?Q?fTE6HUYLUMhwAVHMHT+W3MuGMAgjz7jQyWfNoDeMyq8GYWdV/zr5bT+SH5mk?=
 =?us-ascii?Q?U8GegUpvFPF3ZlRbHJbsHvSNWK4XGcszU41SqT4EU80ZXI2VvdPPFHl2ztCL?=
 =?us-ascii?Q?nEe41uSC/njE6ETk5Ac/EmlG0GbVfat2soeFYPZiCePNBzYqlNRnSKt64i/7?=
 =?us-ascii?Q?Vdm53mqHSi15DoHN798EiQSKNyz1aKOIFmZM8SOV18qcoVwjjCXXZqR8JKeb?=
 =?us-ascii?Q?LVRfXvOtRuqeZK2ywLXK1X+uJEEYWqebP2Ri+rEQHuK+jWfaI4SNZ/XCCOv7?=
 =?us-ascii?Q?gB3ioYERpThBsa3D8CMRIIbQlsK3WPV+JgAz2D8R?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 126cdc66-4fc1-4809-dbc3-08dc96c0db77
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 15:50:24.1209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyvQH9SiLv8nTIBJLA4WQMJt4JmQfXtXoA5VkfMnfzVAeVfqBVXlgvjRPKeQiD4MKopFHm4iMmO66zlO9FQlNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4777
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> The current bandwidth calculation aggregates all the targets. This simple
> method does not take into account where multiple targets sharing under
> a switch where the aggregated bandwidth can be less or greater than the
> upstream link of the switch.
> 
> To accurately account for the shared upstream uplink cases, a new update
> function is introduced by walking from the leaves to the root of the
> hierarchy and adjust the bandwidth in the process. This process is done
> when all the targets for a region are present but before the final values
> are send to the HMAT handling code cached access_coordinate targets.
> 
> The original perf calculation path was kept to calculate the latency
> performance data that does not require the shared link consideration.
> The shared upstream link calculation is done as a second pass when all
> the endpoints have arrived.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Link: https://lore.kernel.org/linux-cxl/20240501152503.00002e60@Huawei.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v5:
> - Fix cxl_memdev_get_dpa_perf() default return. (Jonathan)
> - Direct return dpa_perf_contains(). (Jonathan)
> - Fix incorrect bandwidth member reference. (Jonathan)
> - Direct return error for pcie_link_speed_mbps(). (Jonathan)
> - Remove stray edit. (Jonathan)
> - Adjust calculated bandwidth of RPs sharing same host bridge. (Jonathan)
> - Fix uninit var gp_is_root. (kernel test robot)
> ---
>  drivers/cxl/core/cdat.c   | 411 ++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/core/core.h   |   4 +-
>  drivers/cxl/core/pci.c    |  23 +++
>  drivers/cxl/core/port.c   |  20 ++
>  drivers/cxl/core/region.c |   4 +
>  drivers/cxl/cxl.h         |   1 +
>  6 files changed, 446 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index fea214340d4b..72f86bc99750 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -548,32 +548,411 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  MODULE_IMPORT_NS(CXL);
>  
> -void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> -				    struct cxl_endpoint_decoder *cxled)
> +static void cxl_bandwidth_add(struct access_coordinate *coord,
> +			      struct access_coordinate *c1,
> +			      struct access_coordinate *c2)
>  {
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct range dpa = {
> -			.start = cxled->dpa_res->start,
> -			.end = cxled->dpa_res->end,
> -	};
> -	struct cxl_dpa_perf *perf;
> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> +		coord[i].read_bandwidth = c1[i].read_bandwidth +
> +					  c2[i].read_bandwidth;
> +		coord[i].write_bandwidth = c1[i].write_bandwidth +
> +					   c2[i].write_bandwidth;
> +	}
> +}
>  
> -	switch (cxlr->mode) {
> +struct cxl_perf_ctx {
> +	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> +	struct cxl_port *port;
> +};
> +
> +static struct cxl_dpa_perf *cxl_memdev_get_dpa_perf(struct cxl_memdev_state *mds,
> +						    enum cxl_decoder_mode mode)
> +{
> +	switch (mode) {
>  	case CXL_DECODER_RAM:
> -		perf = &mds->ram_perf;
> -		break;
> +		return &mds->ram_perf;
>  	case CXL_DECODER_PMEM:
> -		perf = &mds->pmem_perf;
> -		break;
> +		return &mds->pmem_perf;
>  	default:
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static bool dpa_perf_contains(struct cxl_dpa_perf *perf,
> +			      struct resource *dpa_res)
> +{
> +	struct range dpa = {
> +		.start = dpa_res->start,
> +		.end = dpa_res->end,
> +	};
> +
> +	return range_contains(&perf->dpa_range, &dpa);
> +}
> +
> +static int cxl_endpoint_gather_coordinates(struct cxl_region *cxlr,
> +					   struct cxl_endpoint_decoder *cxled,
> +					   struct xarray *usp_xa)
> +{
> +	struct cxl_port *endpoint = to_cxl_port(cxled->cxld.dev.parent);
> +	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_port *parent_port, *gp_port;
> +	struct cxl_perf_ctx *perf_ctx;
> +	struct cxl_dpa_perf *perf;
> +	bool gp_is_root = false;
> +	unsigned long index;
> +	void *ptr;
> +	int rc;
> +
> +	if (cxlds->rcd)
> +		return -ENODEV;
> +
> +	parent_port = to_cxl_port(endpoint->dev.parent);
> +	gp_port = to_cxl_port(parent_port->dev.parent);
> +	if (is_cxl_root(gp_port))
> +		gp_is_root = true;
> +
> +	perf = cxl_memdev_get_dpa_perf(mds, cxlr->mode);
> +	if (IS_ERR(perf))
> +		return PTR_ERR(perf);
> +
> +	if (!dpa_perf_contains(perf, cxled->dpa_res))
> +		return -EINVAL;
> +
> +	/*
> +	 * The index for the xarray is the upstream port device of the upstream
> +	 * CXL switch.
> +	 */
> +	index = (unsigned long)parent_port->uport_dev;
> +	perf_ctx = xa_load(usp_xa, index);
> +	if (!perf_ctx) {
> +		struct cxl_perf_ctx *c __free(kfree) =
> +			kzalloc(sizeof(*perf_ctx), GFP_KERNEL);
> +
> +		if (!c)
> +			return -ENOMEM;
> +		ptr = xa_store(usp_xa, index, c, GFP_KERNEL);
> +		if (xa_is_err(ptr))
> +			return xa_err(ptr);
> +		perf_ctx = no_free_ptr(c);
> +	}
> +
> +	/* Direct upstream link from EP bandwidth */
> +	rc = cxl_pci_get_bandwidth(pdev, pci_coord);
> +	if (rc < 0)
> +		return rc;
> +
> +	/*
> +	 * Min of upstream link bandwidth and Endpoint CDAT bandwidth from
> +	 * DSLBIS.
> +	 */
> +	cxl_coordinates_combine(ep_coord, pci_coord, perf->cdat_coord);
> +
> +	/*
> +	 * If grandparent port is root, then there's no switch involved and
> +	 * the endpoint is connected to a root port.
> +	 */
> +	if (!gp_is_root) {
> +		/*
> +		 * Retrieve the switch SSLBIS for switch downstream port
> +		 * associated with the endpoint bandwidth.
> +		 */
> +		rc = cxl_port_get_switch_dport_bandwidth(endpoint, sw_coord);
> +		if (rc)
> +			return rc;
> +
> +		/*
> +		 * Min of the earlier coordinates with the switch SSLBIS
> +		 * bandwidth
> +		 */
> +		cxl_coordinates_combine(ep_coord, ep_coord, sw_coord);
> +	}
> +
> +	/*
> +	 * Aggregate the computed bandwidth with the current aggregated bandwidth
> +	 * of the endpoints with the same switch upstream port.
> +	 */
> +	cxl_bandwidth_add(perf_ctx->coord, perf_ctx->coord, ep_coord);
> +	perf_ctx->port = parent_port;
> +
> +	return 0;
> +}
> +
> +static struct xarray *cxl_switch_iterate_coordinates(struct xarray *input_xa,
> +						     bool *parent_is_root)
> +{
> +	struct xarray *res_xa __free(kfree) = kzalloc(sizeof(*res_xa), GFP_KERNEL);
> +	struct access_coordinate coords[ACCESS_COORDINATE_MAX];
> +	struct cxl_perf_ctx *ctx, *us_ctx;
> +	unsigned long index, us_index;
> +	void *ptr;
> +	int rc;
> +
> +	if (!res_xa)
> +		return ERR_PTR(-ENOMEM);
> +	xa_init(res_xa);
> +
> +	*parent_is_root = false;
> +	xa_for_each(input_xa, index, ctx) {
> +		struct cxl_port *parent_port, *port, *gp_port;
> +		struct device *dev = (struct device *)index;
> +		struct cxl_dport *dport;
> +		struct pci_dev *pdev;
> +		bool gp_is_root;
> +
> +		gp_is_root = false;
> +		port = ctx->port;
> +		parent_port = to_cxl_port(port->dev.parent);
> +		if (is_cxl_root(parent_port)) {
> +			*parent_is_root = true;
> +		} else {
> +			gp_port = to_cxl_port(parent_port->dev.parent);
> +			gp_is_root = is_cxl_root(gp_port);
> +		}
> +
> +		dport = port->parent_dport;
> +
> +		/*
> +		 * Create an xarray entry with the key of the upstream
> +		 * port of the upstream switch.
> +		 */
> +		us_index = (unsigned long)parent_port->uport_dev;
> +		us_ctx = xa_load(res_xa, us_index);

Does this handle unbalanced topologies?

For example in the first iteration given the following topology:

       CFMWS 0
        |
        |
        |
    ACPI0017-0
 GP0/HB0/ACPI0016-0
    |       |    |
   RP0     RP1  RP2
    |       |    |   <== these ctx's are in usp_xa right?
  SW 0     EP2  EP3
  |   |
 EP0 EP1

I'm not seeing where those contexts are carried to res_xa.


> +		if (!us_ctx) {
> +			struct cxl_perf_ctx *n __free(kfree) =
> +				kzalloc(sizeof(*n), GFP_KERNEL);
> +
> +			if (!n)
> +				return ERR_PTR(-ENOMEM);
> +
> +			ptr = xa_store(res_xa, us_index, n, GFP_KERNEL);
> +			if (xa_is_err(ptr))
> +				return ERR_PTR(xa_err(ptr));
> +			us_ctx = no_free_ptr(n);
> +		}
> +
> +		us_ctx->port = parent_port;
> +
> +		/*
> +		 * Take the min of the downstream aggregated bandwdith and the
> +		 * GP provided bandwidth if parent is CXL root.
> +		 */
> +		if (*parent_is_root) {
> +			cxl_coordinates_combine(us_ctx->coord, ctx->coord, dport->coord);
> +			continue;
> +		}
> +
> +		/* Below is the calculation for another switch upstream */
> +		if (!gp_is_root) {
> +			/*
> +			 * If the device isn't an upstream PCIe port, there's something
> +			 * wrong with the topology.
> +			 */
> +			if (!dev_is_pci(dev))
> +				return ERR_PTR(-EINVAL);
> +
> +			/* Retrieve the upstream link bandwidth */
> +			pdev = to_pci_dev(dev);
> +			rc = cxl_pci_get_bandwidth(pdev, coords);
> +			if (rc)
> +				return ERR_PTR(-ENXIO);
> +
> +			/*
> +			 * Take the min of downstream bandwidth and the upstream link
> +			 * bandwidth.
> +			 */
> +			cxl_coordinates_combine(coords, coords, ctx->coord);
> +
> +			/*
> +			 * Take the min of the calculated bandwdith and the upstream
> +			 * switch SSLBIS bandwidth.
> +			 */
> +			cxl_coordinates_combine(coords, coords, dport->coord);
> +
> +			/*
> +			 * Aggregate the calculated bandwidth common to an upstream
> +			 * switch.
> +			 */
> +			cxl_bandwidth_add(us_ctx->coord, us_ctx->coord, coords);
> +		} else {
> +			/*
> +			 * Aggregate the bandwidth common to an upstream switch.
> +			 */
> +			cxl_bandwidth_add(us_ctx->coord, us_ctx->coord,
> +					  ctx->coord);
> +		}
> +	}
> +
> +	return_ptr(res_xa);
> +}
> +
> +static void cxl_region_update_access_coordinate(struct cxl_region *cxlr,
> +						struct xarray *input_xa)
> +{
> +	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> +	struct cxl_perf_ctx *ctx;
> +	unsigned long index;
> +
> +	memset(coord, 0, sizeof(coord));
> +	xa_for_each(input_xa, index, ctx)
> +		cxl_bandwidth_add(coord, coord, ctx->coord);
> +
> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> +		cxlr->coord[i].read_bandwidth = coord[i].read_bandwidth;
> +		cxlr->coord[i].write_bandwidth = coord[i].write_bandwidth;
> +	}
> +}
> +
> +static void free_perf_xa(struct xarray *xa)
> +{
> +	struct cxl_perf_ctx *ctx;
> +	unsigned long index;
> +
> +	if (!xa)
> +		return;
> +
> +	xa_for_each(xa, index, ctx)
> +		kfree(ctx);
> +	xa_destroy(xa);
> +	kfree(xa);
> +}
> +
> +/*
> + * cxl_region_shared_upstream_perf_update - Recalculate the access coordinates
> + * @cxl_region: the cxl region to recalculate
> + *
> + * For certain region construction with endpoints behind CXL switches,
> + * there is the possibility of the total bandwdith for all the endpoints
> + * behind a switch being less or more than the switch upstream link. The
> + * algorithm assumes the configuration is a symmetric topology as that
> + * maximizes performance.
> + *
> + * There can be multiple switches under a RP. There can be multiple RPs under
> + * a HB.
> + *
> + * An example hierarchy:
> + *
> + *                 CFMWS 0
> + *                   |
> + *          _________|_________
> + *         |                   |
> + *     ACPI0017-0          ACPI0017-1
> + *  GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
> + *     |          |        |           |
> + *    RP0        RP1      RP2         RP3
> + *     |          |        |           |
> + *   SW 0       SW 1     SW 2        SW 3
> + *   |   |      |   |    |   |       |   |
> + *  EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
> + *
> + * Computation for the example hierarchy:
> + *
> + * Min (GP0 to CPU BW,
> + *      Min(SW 0 Upstream Link to RP0 BW,
> + *          Min(SW0SSLBIS for SW0DSP0 (EP0), EP0 DSLBIS, EP0 Upstream Link) +
> + *          Min(SW0SSLBIS for SW0DSP1 (EP1), EP1 DSLBIS, EP1 Upstream link)) +
> + *      Min(SW 1 Upstream Link to RP1 BW,
> + *          Min(SW1SSLBIS for SW1DSP0 (EP2), EP2 DSLBIS, EP2 Upstream Link) +
> + *          Min(SW1SSLBIS for SW1DSP1 (EP3), EP3 DSLBIS, EP3 Upstream link))) +
> + * Min (GP1 to CPU BW,
> + *      Min(SW 2 Upstream Link to RP2 BW,
> + *          Min(SW2SSLBIS for SW2DSP0 (EP4), EP4 DSLBIS, EP4 Upstream Link) +
> + *          Min(SW2SSLBIS for SW2DSP1 (EP5), EP5 DSLBIS, EP5 Upstream link)) +
> + *      Min(SW 3 Upstream Link to RP3 BW,
> + *          Min(SW3SSLBIS for SW3DSP0 (EP6), EP6 DSLBIS, EP6 Upstream Link) +
> + *          Min(SW3SSLBIS for SW3DSP1 (EP7), EP7 DSLBIS, EP7 Upstream link))))
> + */
> +void cxl_region_shared_upstream_perf_update(struct cxl_region *cxlr)
> +{
> +	struct xarray *usp_xa, *iter_xa, *working_xa;
> +	bool is_root;
> +	int rc;
> +
> +	lockdep_assert_held(&cxl_dpa_rwsem);
> +
> +	usp_xa = kzalloc(sizeof(*usp_xa), GFP_KERNEL);
> +	if (!usp_xa)
>  		return;
> +
> +	xa_init(usp_xa);
> +
> +	/*
> +	 * Collect aggregated endpoint bandwidth and store the bandwidth in
> +	 * an xarray indexed by the upstream port of the switch or RP. The
> +	 * bandwidth is aggregated per switch. Each endpoint consists of the
> +	 * minimum of bandwidth from DSLBIS from the endpoint CDAT, the endpoint
> +	 * upstream link bandwidth, and the bandwidth from the SSLBIS of the
> +	 * switch CDAT for the switch upstream port to the downstream port that's
> +	 * associated with the endpoint. If the device is directly connected to
> +	 * a RP, then no SSLBIS is involved.
> +	 */
> +	for (int i = 0; i < cxlr->params.nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = cxlr->params.targets[i];
> +
> +		rc = cxl_endpoint_gather_coordinates(cxlr, cxled, usp_xa);
> +		if (rc) {
> +			free_perf_xa(usp_xa);
> +			return;
> +		}
>  	}
>  
> +	iter_xa = usp_xa;
> +	usp_xa = NULL;
> +	/*
> +	 * Iterate through the components in the xarray and aggregate any
> +	 * component that share the same upstream link from the switch.
> +	 * The iteration takes consideration of multi-level switch
> +	 * hierarchy.
> +	 *
> +	 * When cxl_switch_iterate_coordinates() detect the grandparent
> +	 * upstream is a cxl root, it aggregates the bandwidth under
> +	 * the host bridge. A RP does not have SSLBIS nor does it have
> +	 * upstream PCIe link.
> +	 *
> +	 * When cxl_switch_iterate_coordinates() detect the parent upstream
> +	 * is a cxl root, it takes the min() of the aggregated RP perfs and
> +	 * the bandwidth from the Generic Port (GP). 'is_root' is set at this
> +	 * point as well.
> +	 */
> +	do {
> +		working_xa = cxl_switch_iterate_coordinates(iter_xa, &is_root);
> +		if (IS_ERR(working_xa))
> +			goto out;
> +		free_perf_xa(iter_xa);
> +		iter_xa = working_xa;
> +	} while (!is_root);
> +
> +	/*
> +	 * Aggregate the bandwidths in the xarray (for all the HBs) and update
> +	 * the region bandwidths with the newly calculated bandwidths.
> +	 */
> +	cxl_region_update_access_coordinate(cxlr, iter_xa);
> +
> +out:
> +	free_perf_xa(iter_xa);
> +}
> +
> +void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> +				    struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_dpa_perf *perf;
> +
> +	perf = cxl_memdev_get_dpa_perf(mds, cxlr->mode);
> +	if (IS_ERR(perf))
> +		return;
> +
>  	lockdep_assert_held(&cxl_dpa_rwsem);
>  
> -	if (!range_contains(&perf->dpa_range, &dpa))
> +	if (!dpa_perf_contains(perf, cxled->dpa_res))
>  		return;
>  
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 625394486459..c72a7b9f5e21 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -103,9 +103,11 @@ enum cxl_poison_trace_type {
>  };
>  
>  long cxl_pci_get_latency(struct pci_dev *pdev);
> -
> +int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>  int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
>  				       enum access_coordinate_class access);
>  bool cxl_need_node_perf_attrs_update(int nid);
> +int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
> +					struct access_coordinate *c);
>  
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 8567dd11eaac..23b3d59c470d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1074,3 +1074,26 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>  				     __cxl_endpoint_decoder_reset_detected);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
> +
> +int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
> +{
> +	int speed, bw;
> +	u16 lnksta;
> +	u32 width;
> +
> +	speed = pcie_link_speed_mbps(pdev);
> +	if (speed < 0)
> +		return speed;
> +	speed /= BITS_PER_BYTE;
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
> +	bw = speed * width;
> +
> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> +		c[i].read_bandwidth = bw;
> +		c[i].write_bandwidth = bw;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 887ed6e358fb..054b0db87f6d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2259,6 +2259,26 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_get_perf_coordinates, CXL);
>  
> +int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
> +					struct access_coordinate *c)
> +{
> +	struct cxl_dport *dport = port->parent_dport;
> +
> +	/* Check this port is connected to a switch DSP and not an RP */
> +	if (parent_port_is_cxl_root(to_cxl_port(port->dev.parent)))
> +		return -ENODEV;
> +
> +	if (!coordinates_valid(dport->coord))
> +		return -EINVAL;
> +
> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> +		c[i].read_bandwidth = dport->coord[i].read_bandwidth;
> +		c[i].write_bandwidth = dport->coord[i].write_bandwidth;

Does latency need to be included here?

Ira

> +	}
> +
> +	return 0;
> +}
> +
>  /* for user tooling to ensure port disable work has completed */
>  static ssize_t flush_store(const struct bus_type *bus, const char *buf, size_t count)
>  {
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3c2b6144be23..e8b8635ae8ce 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3281,6 +3281,10 @@ static int cxl_region_probe(struct device *dev)
>  		goto out;
>  	}
>  
> +	down_read(&cxl_dpa_rwsem);
> +	cxl_region_shared_upstream_perf_update(cxlr);
> +	up_read(&cxl_dpa_rwsem);
> +
>  	/*
>  	 * From this point on any path that changes the region's state away from
>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 603c0120cff8..34e83a6c55a1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -891,6 +891,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  				      struct access_coordinate *coord);
>  void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  				    struct cxl_endpoint_decoder *cxled);
> +void cxl_region_shared_upstream_perf_update(struct cxl_region *cxlr);
>  
>  void cxl_memdev_update_perf(struct cxl_memdev *cxlmd);
>  
> -- 
> 2.45.1
> 



