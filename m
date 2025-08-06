Return-Path: <linux-pci+bounces-33454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAC9B1BF74
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 05:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612D818A3C11
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 03:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF211E260A;
	Wed,  6 Aug 2025 03:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaIG4eYD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194519AD5C;
	Wed,  6 Aug 2025 03:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754452716; cv=fail; b=olL+un67xamTKybRpg5/Kd3hiKDJTXPvA/hIpWqneH2B3KdvpHDSKVwgQyTtos/CTk7CltN0DD8wyQHS8WqQRLlBtenChGC5bVWcAE/v3hjqjU1Id5fYtGN5HHntOC5Yr24rl19xL6SxMkEZqlc7DI4N0qPSy94fEK4NuHRei60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754452716; c=relaxed/simple;
	bh=NCCk8MpXHm87LiZ8eNFgwQl/gD9iXwfOfoh3lUG7tYw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=HB8xj1fMINyqKErO5kgpgM9gN8F4jGmEkr+68WH7mFQVQGwo8pZfm3gmrNzGT0IiA8eVaM/I2SPTjP5Nw/LaVwTsRuRG4rhXSV32Vlpv4KaL9h3Q14y+OGbgeZOFwFT+Km8HQk1lfsHZfVoRM59jsCOqRH2RQ60blieGpVB6mzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaIG4eYD; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754452714; x=1785988714;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=NCCk8MpXHm87LiZ8eNFgwQl/gD9iXwfOfoh3lUG7tYw=;
  b=EaIG4eYDz3gpIQOi1SQOMyrLJnVXHGR42OedLNVf9HUBNxVvrjHMzZk0
   Gh65ZmFqIudzHurpkwFwSI++C8AfeAICBNDmClUWO95SQOPYWWc5CPUCJ
   BErMa3R+ZElQjs5NzNbdy7S8i0xC/gMI3nv7SWGE5Q1YHO4BcZ3AA2OaA
   mmC9P++OaXUfdSuUx+PZBqiGq6Qjb8iWz9xpP+mzVIU8d84+r1nwX7YU7
   ggpvjPX1qyhvhmgAnr0peH1PFQ+QZzdyPIS40XlLZ9LKJvrQxau+pO5kg
   lwo2W8c/LF3DHQJNb9uigqknqYwuX3a8x4OBk80qg518eCAHLZq0HNIQB
   A==;
X-CSE-ConnectionGUID: bmdGCcw0R7OYBRmaCUT6sw==
X-CSE-MsgGUID: kCg2ml8BRAKIw1WrYaDL9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56472244"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56472244"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 20:57:38 -0700
X-CSE-ConnectionGUID: I6P0A6vrSM6wa/YeWqJzcA==
X-CSE-MsgGUID: 2fUlQRd8RuKrQCJPNZ7X6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="165002589"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 20:57:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 20:57:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 20:57:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 20:57:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwYQTduYbfRh4eiA4QPJlqMS/W2l9W04m16mKybH4FJGNuzgyG27Mjamw0HxSoaUVDvHdee/+AVGZZ1zVpdQHeA5tRDaObR2VeofeyNciOBIQYsBplCD/zgD8DJwEP4/E3M5adQLO64s4qzLv+s4Lq5PZ2WSzLeCAjz4k90bAXCz2fAX+0oAgBgaUYMvTuxks8sHbeYhAxRt4q0IzLLvlh0WbSr9cWJWjhlv8CcaPzQCUN7hPasb5FGkKJCFSx44tKJYOrJVsLTI9vW8XaTvYrIpKVZeziS192YX7O4KPz/0l0+gMSNZdBXrK+rzeUUyCkRU8coh93EVSbWwIOdafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rD7MNEobeBx7HyQm4AK8jrkIvlyx1fftMVCtz8xRHE=;
 b=ZV/L/hYlnWKDCTpph5j4EPuuXO09Xp8A3U4IJ4V5cBYCAmq3/mKozncbv+AuVsqaNynEjXIjg4wVqFPVDb8jSHnsq9QHTs7mXOXaCV2c82gOJQJeN5EyfNLxhA5IaqQHxJAtKHdbAuEjlCK50JH8vVbJsQ6fXg3Ub6kKIdf0SqJCAo6EoYOPUKUqb0N8a8RJa4K6D2vuQOsSAxY5bxbs27uiYNLmyEAG+3cKpX7P1dHLyctz0NUp2T/HO2wy7L9BSwJ8p+lV6JdoaTAiHB7sbElnjBYHM06lf+CRjcJHzDBsGyPP5rTd9r9JpCR/TkupTDj0rcxv2sjkJ12NfUzdUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7257.namprd11.prod.outlook.com (2603:10b6:208:43e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Wed, 6 Aug
 2025 03:20:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 03:20:32 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 5 Aug 2025 20:20:30 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Message-ID: <6892c9fe760_55f09100d4@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250729161643.000023e7@huawei.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-6-dan.j.williams@intel.com>
 <20250729161643.000023e7@huawei.com>
Subject: Re: [PATCH v4 05/10] samples/devsec: Introduce a PCI device-security
 bus + endpoint sample
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0163.namprd05.prod.outlook.com
 (2603:10b6:a03:339::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: cd05f3ca-c380-46e4-5434-08ddd4983327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODBxSEFPRnhicHh5eFpJV3Q2WU16YVhQSU5mTGRWQjRRZXFNRm9BT1RIOGRM?=
 =?utf-8?B?TmJXeEQvUHp4Tm1KSFdSYWlqTTE0QVpLZVU3RmRsanFZN1h0U2lQakZjTGVC?=
 =?utf-8?B?eFQrRG5TdU9GUnE0dXBUaStPUFJFc1dobzdFcTFjdURGZTFMWGxOeHd2SFdI?=
 =?utf-8?B?QmRjTEhYOXRaY2N3MzVWRklQVTd3MGo2SmhGZjNBV1llNjVmcXNzdlA0c1Nj?=
 =?utf-8?B?aVhkakFJdVlMSEEyZnE0M245OWg4SWdzVFpaTjJwaTlLcDFCbEdvallnRjh0?=
 =?utf-8?B?WU1QMnl5Nnh3SS9KcW9rSzNSSi9WMXIrMWJCdnBjZVA3cVFjcGZQYVZxYllI?=
 =?utf-8?B?NXJHUFlRaGlSSnM2SEpxcGhnaThhejF6TWMxd2NKU0VadFVaYWg3VFA5bWIx?=
 =?utf-8?B?OGFWZ0Zub0lSWGJPUjBOVnVtVHFVQUNwMHpmK01VdGZYU2J4YUZ2M3kzYUNq?=
 =?utf-8?B?RUJGQWlrUDBtSmNlUzZnUUlDTElFckJDV2pLT1l0SzlBYWhWVGpRaXUvVm9m?=
 =?utf-8?B?OUU4Y3A3OTRtcEFXQnVRWmJFQk9LYkQ1cGs4TGVNM0xZU21vcWc2OXBhNFJ1?=
 =?utf-8?B?UTdwdXVVQStwUHZlOEFYWVJvdlQyZzBQUXlCbWJnSjREWWRuTFJZenA3NTMr?=
 =?utf-8?B?RGtSSXMvUGg3dFg2Zis2aDYwNDJvakh1allxQ3cweGZhZS9ubE14MkgvWXB6?=
 =?utf-8?B?VTR6dVVSTDJjbmFFYUU3QzFlRE56UlgxVkJ5STVTcFJXSjA2UmJhRTlCNkc5?=
 =?utf-8?B?dVBjQzhlQXNidEFRUXZBenpTYkIzTWlMbUdiWGRXcEVLQVZLSCtSVkpSS1hK?=
 =?utf-8?B?T2I3UjViRi9uRlgrMFp3RVEvUWRmdVRFM3BRNVdya2RLdnFFQVVwVDJrcUdE?=
 =?utf-8?B?c09QQWJTQUl5ZjdGUmJpVDNHQzJ5NHU4dko0NHh4ZXFDekdQNVhJVGRnOGpi?=
 =?utf-8?B?UUU0UGIrZjZ5RjNheGRva2ZjemZWRjkvVEJXMG5ZbGRpb2cxNGJZMXZvYi9w?=
 =?utf-8?B?RDU5bkN6bHI3d3RJYUd3WjgxV1VLUE42UkkrNzNOZnpoOSttNjVKeFlpc3VT?=
 =?utf-8?B?emFGV2tOaTl4bzdBUFJFODNxZmlCc2JRWk5tcVB3TmFsL0lhM0hpb2ZsZkt2?=
 =?utf-8?B?UWhsdDRBU0ZMTTFoWnVxR3FkOExvb1lHWEtJSmZkM2JxUFZFSFppS3hBbmxB?=
 =?utf-8?B?WmVJdGFtcDNFUVF4V0VKaDV1ZkhSaENCYytSb3UrZFJoUkhkdUh6Y2x0Zndy?=
 =?utf-8?B?WVpsK2hwNnRld1hrK0ZmZ21kMXcxZWViMkZlMHRoVkNrdCtDcWdQMlVvbllZ?=
 =?utf-8?B?TG1WVjN2c0R4Yk9ncUFhaU9WNklCbGdRYUl1eTF0Q0FybXRxVWZ6aHk1Z1FR?=
 =?utf-8?B?YzFmZEV6bkh4WlRzSURHT01RTTFLWGYzUFlRR3NzTlZNaWlma0ZYaStoVm95?=
 =?utf-8?B?TjNJelRGQUpkUTdHa09FRFpjTUhQU3EvdFREOUhaWTErdmh1QllheHdVMnh3?=
 =?utf-8?B?dEdiMnc4RWtvdC9FRlFjSUx1SWlIeEdYNkhTMmZLVmpid21CZlFJZHhDbjRJ?=
 =?utf-8?B?aDRtUVBoeE9uVVRjRnNCODkvR1J1SnROU1lMbERuUCtlR0ZCVW5ya3FLQzJx?=
 =?utf-8?B?V251R2c3eVEzSjVpbHNtNXdQL09NaUJqZ2pRTmlTTUNDZXIvTXppMDZUQ25v?=
 =?utf-8?B?NHQ5MGxSb0NCbng1N1JQZFpxZFZYeDhZU2hnUll6RFdjQUd4UjVwa2QxMXN1?=
 =?utf-8?B?bytuKzR5SzRwVUJSVnJtckhRSUwxR0dSWU42L3MveTZCVEhSZ0c3ZUNQZ2d4?=
 =?utf-8?B?aHFZeVZoMjgrUDFFbmdqWmlscHdubTFLZDBqSUtuTmowTENzQk1LemtUUE1H?=
 =?utf-8?B?MEpSV3RLWGlQTVgxNEQ1MHlFOXVCZklCbll4VE5JSXNwMVg1b0JoN0h3Lzg0?=
 =?utf-8?Q?prCmPEzwsa0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDE2RTdKYVVIUzJiVEk2cVNZMVZ0NmtReUcrak9Qd2pUUHlnT1dZOHlMUDlS?=
 =?utf-8?B?emdjT2xjMXhPNFhka2tPaUc5ZVc0TUZLU2FDdkhhNC9PYURERFlldTJoMy9o?=
 =?utf-8?B?ZEhpWUUrOEZCejhocHJadXVMUENTeVlVeTRQRis3WEZIWFQzV1lqanhRK2NZ?=
 =?utf-8?B?ZWVMVW5ZbzQxQlhJZitiUjA3S2xqb21hRmgxM1UxWFVRSk82SlQ1U21QRURm?=
 =?utf-8?B?SnZhdjlZdDNLMlNsMm9yclo4M1pVMUU5azEzQlJIQ0hlRGtKRjRsUnpzMGV1?=
 =?utf-8?B?VmtTVEdQcW5Na1UzbyttdFhYUXRwbDFXV2lYQUdQUnlOMmo3WHNJblNaUENN?=
 =?utf-8?B?ZEdtNzMrUUI0YnlBN2dKbittdkoyUXdQMmJPaWRlckF3bEJHWDVCWXJJNk5l?=
 =?utf-8?B?NUJGZ0RNM1lXK0s3T3ZickJndDNwQldvZ0NTYzdhMFkvdkRKQnBlbmFreXRK?=
 =?utf-8?B?Y21UUWJiaUt3c291dnVxNFlqb3JrK3Y0M25kY09KU055bGJHbjJ5Qi9qMkdq?=
 =?utf-8?B?NGpPZkZvNzRQZlNGZm03bXRVR2NtUzhFTFl0WEIwNFYwQWhzcTl3QzhuY1VX?=
 =?utf-8?B?NE9oV2xueW9PaHV0M1Z2Sjk3NzNscDZOTFQ1emhJLzVFN0ZpcXMvNnJRbGwr?=
 =?utf-8?B?QlBIOTVIU0JBdThYN1ZJaEhKZEVtYVY4MWVkT3IvNVJXbDVKQm12YlZtT3Fh?=
 =?utf-8?B?UUhFc2U4YXdjWERWM0UwSHJod21xQTFXU2hmeFhsNjZuaWVsaXIxNUwzTSsr?=
 =?utf-8?B?TmExQUdGajJDSHpOWm95WU5yRkxUeEFscE9YVEhCWlM4TjdnaEM4YkRMTld1?=
 =?utf-8?B?YzlJK2t1eFA5YUVjRkY3NFNtWVZJa0VRR21BNlRTb2p4L3lvcEowNXErWVhJ?=
 =?utf-8?B?N2xMMXNCa1Yyd2RVZDBlNU5rZ3VETW04enlXT0k1QUdXTnNvY1JsMS83V3Iw?=
 =?utf-8?B?OGxDdEpwMlBnbkUvM1BHVlNGUWd6eFpBcnFHaHlZeDZrTERhS2xvSHordERn?=
 =?utf-8?B?bkYvUE90Mnh6YTlDdFk1VURGU0FnTFliSkI5dkpVYTFsdVdzTE0wVi82L3Nv?=
 =?utf-8?B?V0pLeWZJUzBsck9kODFxQ3o5bHA4TXplRERRRThiKzRzeU5US0lOekQ1Mnhw?=
 =?utf-8?B?d1BwRVVMb05yaFUrQ28rQzNpL2pmeHlUTnZMNnY1Y1pTTmUvdmNkQnFiQ3gv?=
 =?utf-8?B?azBwVmY5anFQZ3pSbjN5ZXo5UzVYOUdpR2FuNGRFdWVrUzVGQkh5cHNMMW9P?=
 =?utf-8?B?dUxEbE1iU0FhQlJaWDlnMDZtSnk3MHpNVWNxYVc3aDI4L3AvU0JZNHl1RXM2?=
 =?utf-8?B?UUVHZXBlRlFDZ2w0UmJzeUpISmhTbkdKK0laU2FGOHJjaWt0Y2prMzFZVEFa?=
 =?utf-8?B?TUh4YnUzYldsT214UVl1ZmtvUXdQVlhNYktPbWNLVEtTOGkxVE5abittdElK?=
 =?utf-8?B?UDRjT1lJVGszL0EreDNWK25sUTJNMW50a3lSbHlKMWZaSHpaZmhPTml2L2Fq?=
 =?utf-8?B?alJOVk5lUjk2OU9sQk9VUEI1L0VyZ0doYmJzU3g1K2tYOEFzNWJLSVcyejMr?=
 =?utf-8?B?QjdmU01iK0RXcE4vTXZaVERleXpMRFgyUXBDOEZsZDB2SkVVc25GbzNsenFD?=
 =?utf-8?B?dzJLcDd2OHlyZHBLQTc2clJrSk84SU1ZNThZaVQzUnRDL2c4Nmc1T1llTEhx?=
 =?utf-8?B?UGRBTjZBdGM4b3N5VElRMm9YcDBKSlRmQ3FjdkFVeXQxeFV2cnNZRWVWZmtE?=
 =?utf-8?B?V0hpUnVOZnhWYmdoUTdrM3FBVXkrOXJiazBuQ2l3NGlGckRRazZML1FPMGR5?=
 =?utf-8?B?TllEeHhFdHZ0ZUNMd2J0VGl1NXFQQjZnRHdNNGJNZWgrb0xuRVUvekxVcE8v?=
 =?utf-8?B?MmFSUU50aWk4SUFIQ2U0dXF2WWdKWlJXdFpEVTNQUnB3ZytRQmVRSTVBNVdM?=
 =?utf-8?B?VS9KRU43dTVxL1V5TkFUVkpDeWxvdDBtd1p6Z1NLQTZ5dUJSOUc0THFSc2pl?=
 =?utf-8?B?dmUvTHNocmorYXpSNE9Ud1p0dGEvd0taTjJLR3RQTy9vaWc5MEVtb21JdllO?=
 =?utf-8?B?ZnBBWWpwTnhhVm1OOEc4TFhENGFzd2d6SWwyY3lEa1JpZjFuOTUrYUgwRTg0?=
 =?utf-8?B?UW5PTEZ6akxOMlJjZWltN3Mrd24vWUpBZnBkY3U1Q2p1QkRFWGg1VHF3NXdK?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd05f3ca-c380-46e4-5434-08ddd4983327
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 03:20:32.2199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5khQ7KF6G/UVrOZqV4Hmvf3VncAfGo9mJoR+ZgBfwGhrxwhAxRH6zW7oRTxuioJ5StT3j+3Legi74aiASNituxY292WBN7aIa1w/JVyLLiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7257
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 17 Jul 2025 11:33:53 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Establish just enough emulated PCI infrastructure to register a sample
> > TSM (platform security manager) driver and have it discover an IDE + TEE
> > (link encryption + device-interface security protocol (TDISP)) capable
> > device.
> > 
> > Use the existing a CONFIG_PCI_BRIDGE_EMUL to emulate an IDE capable root
> > port, and open code the emulation of an endpoint device via simulated
> > configuration cycle responses.
> > 
> > The devsec_tsm driver responds to the PCI core TSM operations as if it
> > successfully exercised the given interface security protocol message.
> > 
> > The devsec_bus and devsec_tsm drivers can be loaded in either order to
> > reflect cases like SEV-TIO where the TSM is PCI-device firmware, and
> > cases like TDX Connect where the TSM is a software agent running on the
> > host CPU.
> > 
> > Follow-on patches add common code for TSM managed IDE establishment. For
> > now, just successfully complete setup and teardown of the DSM (device
> > security manager) context as a building block for management of TDI
> > (trusted device interface) instances.
> > 
> >  # modprobe devsec_bus
> >     devsec_bus devsec_bus: PCI host bridge to bus 10000:00
> >     pci_bus 10000:00: root bus resource [bus 00-01]
> >     pci_bus 10000:00: root bus resource [mem 0xf000000000-0xffffffffff 64bit]
> >     pci 10000:00:00.0: [8086:7075] type 01 class 0x060400 PCIe Root Port
> >     pci 10000:00:00.0: PCI bridge to [bus 00]
> >     pci 10000:00:00.0:   bridge window [io  0x0000-0x0fff]
> >     pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> >     pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> >     pci 10000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> >     pci 10000:01:00.0: [8086:ffff] type 00 class 0x000000 PCIe Endpoint
> >     pci 10000:01:00.0: BAR 0 [mem 0xf000000000-0xf0001fffff 64bit pref]
> >     pci_doe_abort: pci 10000:01:00.0: DOE: [100] Issuing Abort
> >     pci_doe_cache_protocols: pci 10000:01:00.0: DOE: [100] Found protocol 0 vid: 1 prot: 1
> >     pci 10000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
> >     pci 10000:00:00.0: PCI bridge to [bus 01]
> >     pci_bus 10000:01: busn_res: [bus 01] end is updated to 01
> >  # modprobe devsec_tsm
> >     devsec_tsm_pci_probe: pci 10000:01:00.0: devsec: tsm enabled
> >     __pci_tsm_init: pci 10000:01:00.0: TSM: Device security capabilities detected ( ide tee ), TSM attach
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> A fairly superficial review.  Too much staring at code today
> to check the emulation was right and have any chance of spotting bugs!
> 
> > diff --git a/samples/devsec/bus.c b/samples/devsec/bus.c
> > new file mode 100644
> > index 000000000000..675e185fcf79
> > --- /dev/null
> > +++ b/samples/devsec/bus.c
> > @@ -0,0 +1,708 @@
> 
> > +static int alloc_devs(struct devsec *devsec)
> > +{
> > +	struct device *dev = devsec->dev;
> 
> Similar to below.  Maybe use it inline.

ok.

> > +	for (int i = 0; i < ARRAY_SIZE(devsec->devsec_devs); i++) {
> > +		struct devsec_dev *devsec_dev = devsec_dev_alloc(devsec);
> > +		int rc;
> > +
> > +		if (IS_ERR(devsec_dev))
> > +			return PTR_ERR(devsec_dev);
> > +		rc = devm_add_action_or_reset(dev, destroy_devsec_dev,
> > +					      devsec_dev);
> > +		if (rc)
> > +			return rc;
> > +		devsec->devsec_devs[i] = devsec_dev;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> 
> > +static int init_port(struct devsec_port *devsec_port)
> > +{
> > +	struct pci_bridge_emul *bridge = &devsec_port->bridge;
> > +
> > +	*bridge = (struct pci_bridge_emul) {
> > +		.conf = {
> > +			.vendor = cpu_to_le16(0x8086),
> > +			.device = cpu_to_le16(0x7075),
> 
> Emulating something real?  If not maybe we should get an ID from another space
> (or reserve this one ;)

I am happy to switch to something else, but no, I do not have time to
chase this through PCI SIG. I do not expect this id to cause conflicts,
but no guarantees.

> > +			.class_revision = cpu_to_le32(0x1),
> > +			.pref_mem_base = cpu_to_le16(PCI_PREF_RANGE_TYPE_64),
> > +			.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64),
> > +		},
> 
> 
> > +{
> > +	struct device *dev = devsec->dev;
> 
> Only used once. I'd move it down there.

ok.

> 
> > +
> > +	for (int i = 0; i < ARRAY_SIZE(devsec->devsec_ports); i++) {
> > +		struct devsec_port *devsec_port = devsec_port_alloc();
> > +		int rc;
> > +
> > +		if (IS_ERR(devsec_port))
> > +			return PTR_ERR(devsec_port);
> > +		rc = devm_add_action_or_reset(dev, destroy_port, devsec_port);
> > +		if (rc)
> > +			return rc;
> > +		devsec->devsec_ports[i] = devsec_port;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init devsec_bus_probe(struct platform_device *pdev)
> > +{
> > +	int rc;
> > +	struct devsec *devsec;
> > +	u64 mmio_size = SZ_64G;
> > +	struct devsec_sysdata *sd;
> > +	struct pci_host_bridge *hb;
> > +	struct device *dev = &pdev->dev;
> > +	u64 mmio_start = iomem_resource.end + 1 - SZ_64G;
> > +
> > +	hb = devm_pci_alloc_host_bridge(
> > +		dev, sizeof(*devsec) - sizeof(struct pci_host_bridge));
> 
> I'd move dev up a line.

clang-format disagrees and I prefer just letting a tool do my formatting.

[..]
> > +static int __init devsec_tsm_init(void)
> > +{
> > +	__devsec_pci_ops = &devsec_pci_ops;
> 
> I'm not immediately grasping why this global is needed.
> You never check if it's set, so why not just move definition of devsec_pci_ops
> early enough that can be directly used everywhere.

Because devsec_pci_ops is used inside the ops it declares. So either
forward declare all those ops, or do this pointer assigment dance. I
opted for the latter as it is smaller.

