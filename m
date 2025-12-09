Return-Path: <linux-pci+bounces-42830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C007CAF386
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 08:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EF5930249F1
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BD1266B6B;
	Tue,  9 Dec 2025 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsBB0vYm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7522CBD9;
	Tue,  9 Dec 2025 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765266845; cv=fail; b=qsZ8c2O9SdsyTeSvDvwzmmgURH3MVa//SgyDxqqBQ9Z3UnJx2jWkXjgl7RR60z/G21+LPD71PmDjiw69R1lcR3jVbPThyV7jhcehfH8pnVpttAmfsEePpMIhagki1XRqy3JXOb4bD73fcVRq3G5guRv1e5MpaDra45dJMV0Ekoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765266845; c=relaxed/simple;
	bh=W238gsTOmOu7IyGBAlBeLZc+aKqvZcKx23eyuiw66ik=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=DSvv7FzI/FZYWz2UAs6FSRHyhlixaCVDDDzoLS+ij5X6T09yC5FmG5VwVzuDDSdFbh1YYNErgfWUuCfKwFr5ZLpFa5Iced809vmMRjTc0Lefh8qKwuNprGmHS5n4fI1TvemD4AgoDzO92DanlfsArfC9PwuxCi5K2PgRISIGekI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsBB0vYm; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765266843; x=1796802843;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=W238gsTOmOu7IyGBAlBeLZc+aKqvZcKx23eyuiw66ik=;
  b=HsBB0vYmwuc8YoLV3bMkcnhCbeJjoHmCpMmsBy8cDxCo+XEEKhYTUqHz
   k2NL9eneYvlvqSVlK654XG2zglTjcnTqNiSK6RBLXsVjLxL0oiKjNlO4x
   JMYLa+3UOlWwjzfW+PyuJdOhG95ObC8syPNwt9L7Lsuxk9hQmi+bNEQhL
   1A6lqg95DL4uql9Jngl80q2sE4HJH3gKYIud5H3PXF3Rd9AbKvL8p2EvD
   ipzY6+T33R1QdsLQZTObD1ZQwOlUnx1uckOcBcXHlbF1IvZwrR5yxWW7J
   +33SUB0NXzW1Op+9XlJ+TsT68yumGUQ2HAS9EU+84gzMvaP3c9cEr1T6c
   g==;
X-CSE-ConnectionGUID: lOxsi7NkRleoZjeYowUGEw==
X-CSE-MsgGUID: WSJlh2tbTWyuMzCx7HSHvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67149267"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67149267"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 23:54:00 -0800
X-CSE-ConnectionGUID: IRbTB/jYRQCXuSB7pd0XUA==
X-CSE-MsgGUID: zysUMlJ1TC2L28XUNTXBKw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 23:54:00 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 23:53:59 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 8 Dec 2025 23:53:59 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 23:53:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qN/yHLI6RcJvobDENRt0JWfNJ4jUEQtdVUwq2OBssdDyAw7ZnepMmaLNkBIqvge5oNhkkQALPYHqNN9WCkVaMLtVX1o2FR2lZoFh0ejUK5QVdz/6B/Ob+mSaXo+kJcqdPrhvl8x5d159B4zPqQWvSJ4BLzgKUh6LzNswDI9is02WcEyYgIccTEiELwwQoZQEK/FT7h5L+w0on8TeS/b4XY33yEmAZeADgTRpQ1CbAT9YGqt2LxOh1FCDwjXgcfi7BwyJ+iA+2vQyHSG/SO9DdhDHpWsqb+TULqoHwQI35E5wuqwXvdYR5JcQX0NDVsoMrI8Z54xwL0wtsZa2+EwMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfkr7I3i2di+yC5lYXOorpKUFL3YeOu2OuDcFSrBFxw=;
 b=LuiTcRud+PPiCnKYxUxLS86R6c+riWoeEn6c8sHcntUDQj+q8tEx2u5TyqutKCSFPLBh8aCktZfJ1sgdKwg0C/ngNX6TJKvc2Ex81b2K8aLWFuVsf6FE2ffNI67cBH4DW3sj8e++ujWCs8jxv9+ZXV3w/gCvCGxgptixDpKvMTiYYq0px0QZDLD8HWlrI7rLcegog/h/Ye7pv7zYEC/MtfPEgi62EFvZqh6cw1idyEAGqEz8s06QZr33z7F2iZ8voTo4aqA1XOvW+36aAfjsl5zlHeKgfaH0EL6A+3ycLrFozmJNlAUEW2FiylTZfhvBU89pIG1hEaHEDIg0LUD81g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7611.namprd11.prod.outlook.com (2603:10b6:806:304::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 07:53:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 07:53:57 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 9 Dec 2025 16:53:53 +0900
To: Alejandro Lucero Palau <alucerop@amd.com>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Shiju Jose
	<shiju.jose@huawei.com>
Message-ID: <6937d59160f7d_1b2e1001@dwillia2-mobl4.notmuch>
In-Reply-To: <f45b11fc-270d-4047-8149-75081399b2ed@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <143deecb-aa53-42e6-b7eb-91fb392e7502@amd.com>
 <69334c038705b_1b2e100b5@dwillia2-mobl4.notmuch>
 <f45b11fc-270d-4047-8149-75081399b2ed@amd.com>
Subject: Re: [PATCH 0/6] cxl: Initialization reworks in support Soft Reserve
 Recovery and Accelerator Memory
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:334::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: fb67a185-fdbf-4c8a-e3ff-08de36f81b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aThGTldNUEdFd2gzOUQ5aG9FdFB4NzIrYXQxM2prWlJpbkxRWGxDR1VXdkll?=
 =?utf-8?B?TU5vNXVpK1dDY25LbC8rUFhlbXlUZkhodGV5TFl2b3FFZ013QXFhTUg3d1hG?=
 =?utf-8?B?cjRpVUM0YXFvWUNSc3BZMXAxSGVMUmt0cTVtYXJ5YTF3b2QzS3ZES2pFNmhU?=
 =?utf-8?B?ZDk0QWxMazh0c3pMcUR2alBOS3l5UHNXV3kySjF6T00yeVFFTzlIOEVrVU5E?=
 =?utf-8?B?bUpXcnk1eldXeG5QV0JyZ1l1MEVRbzlnL3RmbDhNbUdlNmRhVzR0MWlGMzdC?=
 =?utf-8?B?M3ZnbDF6d1VONVh2cGh5VTVKRnhLaVUwc04xMExGS2lWQndJWHV1ZVNBUFVE?=
 =?utf-8?B?R0RleDA5SEhpWll1cnZ5TEtrbHJPVlRvSXloRlErcXZ4K3Nsc0J4U3Z5ZDIx?=
 =?utf-8?B?RFlFNUhXSVpFc2J5a0JlbFVjT056eTZZby9KVCsrOTY5b05CWDExOHJ0TzRx?=
 =?utf-8?B?MXg0RHZoUzhFVDlyYytpb3U1cktkR3ZobzRTV0FlVXFxaVVZMCt2R2NrS3hu?=
 =?utf-8?B?R1Nha0RxQ21vRHhadTdQZkFIaktnclpNdGk2VStObmVnTGdyWS9ISTA2ejM1?=
 =?utf-8?B?bmgrT2Mrb3IvSkl5dFljWkhVbTJpUllvaXVoclBFbTBnM3pYc0gwYVhsVDJz?=
 =?utf-8?B?TXBCMWZHT012MGlVRXY0T2pwUEhhb2ppQ1NPUzErQmNTVHhManFyV1ZCRzUv?=
 =?utf-8?B?ZndGSkY4N0JGK1QyUlhBbytaaVk5QUtndWdEbkZqNXNtOTBtNEZJa1dhZDZQ?=
 =?utf-8?B?QnhBSkdsUUdnS0ZLRCtYbnhFNWUwVTFOR0l2M3NCejRqYUdMRUs2NjJKTnZu?=
 =?utf-8?B?TVBWWmdXRW51cElqVjdYNjlFVlZwV01LVGZ4c3A2bE9Ra2VsWGsrNTNoY2FN?=
 =?utf-8?B?UlJuZlFLdjlGTGZXZml3eXZlMm9FU0dXMStpZjMvNXlyZjNGa0NmNXpKVUFR?=
 =?utf-8?B?dHlBeGc2NmMwSzkyU1I0QlJBZXNNWkw2bHdFaEpsVXNNcWxhWVEvRXpVY3lr?=
 =?utf-8?B?VGdFalhiMklleWF2NFFlNlRtZU1GOWlYZFFqWmFYdVNiMGVoWWtZdzM5Q1Va?=
 =?utf-8?B?RUN6dzV5ODZ2dVRFbGUvakFQdFBMUG5UdDNZdy93VUNCbEN2d0E4WUlvY1ZZ?=
 =?utf-8?B?bVpxS1lVS255TjRRZHprbmJ4eFh3THFHejV2MWwyOEI2R1JOUkNveEFUNTlH?=
 =?utf-8?B?QUNvanJWWXM1Q0dlWVZCRlA0QW5lN2JsQ1NGTE12Mi9vOGVQWGU2Qk9JaVRC?=
 =?utf-8?B?WFRVUEJUdG5FVEJvLzRhejZ0US9BYzZzNGJxS0pVODFrMTNwUi8xUS9DWFFM?=
 =?utf-8?B?b0xzbC9tZnY4NHVVWThEb1ZuamxQWmVyeUlKWXNXdEZqTGZsaEVtaEpia2tG?=
 =?utf-8?B?U0FETmlzdk1kRE5aczlWLzlLcVljSS9IcGVwOWZReCtGcmc0YVliR0xQajZX?=
 =?utf-8?B?QVJoVUVQYmxzdXVCT3dmRUFvL1k4bzVhWGN6ZHB4ZHBqTENnRndyQ1MyOUhT?=
 =?utf-8?B?QThRc0JvWmZxNzNmVEg4TDE5ZlJtenpmblZORzF4RjVBNmJQRGNhM0pJdUNZ?=
 =?utf-8?B?T0xrVGNUdlFqWVhtMEE3WFdkci93bm5XZmJMNml5MkxLTWZnbkN3NnRuNERW?=
 =?utf-8?B?dVJPSEw4UDBJODlNQzVtWUhlYVZybzcrMzdCK29qbWJQQ3BDaDF5TGZPSDkv?=
 =?utf-8?B?dHI1Tml1QktyRDVTOENjdUpOTFhwZWhta1p6UkMyRU9QbmNRTG5saWNrYkxr?=
 =?utf-8?B?bVZMODZKUkVDRWhoQmlYWW1CY2RXdXIrY0U1QnlNQ2E3K1hWblZpaXJFRm56?=
 =?utf-8?B?OXYrM3doWDMwR3FXU1VoL0t4OGlSR2FTQ3NNb21NVzRSM1BEcEhsYjduYkJm?=
 =?utf-8?B?MzVFSHFWMUhJcG9RQUNxUWF0VVBzTlQvSlJORGdxRWZTaWlsekJXNDB4VUVv?=
 =?utf-8?B?NGtjaWV6Q0VyMEk3TlF1b3VRTE44UEpKTHZHRWxqQ3NicXMzZHB2Z2ludytE?=
 =?utf-8?B?Y09qQWVoWlZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkdzTWR3U3JlT3RVUFlIRHNHR2d6OWVLSFRGRGxWYUJVc2hjMU52Qzh1RWdJ?=
 =?utf-8?B?aWdWR25OVDVQUk0xQTJvYTZNWkhScTFqSmpFWkJGTmFNUEVRdHhjb3lETkFV?=
 =?utf-8?B?L1BjL29LbW53aC85QWdrRUxydTVsUTVobEd1cU1pOG5DSkZBWm5UTmlCK0kw?=
 =?utf-8?B?OWFNdGtmN0tTdHF4MHhxd0Qwc2IxQ3M0TkZXaG11Sk5VQ2NlK2lOdENoSmd5?=
 =?utf-8?B?NDR3Z0h3czNWc0xiRWY1Ry9wb0NFWHBMRk1ZdHRrYmRtY1NHRVRZazIvM09y?=
 =?utf-8?B?VEd2TFpnWWlZV2lkbk9PaC9DU2ZLYWpQVW1NNWNiM3EwYmNiczZvdk5PWTNi?=
 =?utf-8?B?cXdEM0twd0hOdisxWnhvZlFBc1J3aTdFM2RleWcvdUd1VG9hYnlDWXdmUDFw?=
 =?utf-8?B?cjl4VTFWRDJuSkY5WEhvcDQyakVHWklhME5TbkYwQ1RORkdYQUlIa1JkVlZL?=
 =?utf-8?B?RURxNEFGTGJncmVnWEF0MEJNbFlrRGhOWkphMzRCUjRLTnZGalZqaGVvVTYy?=
 =?utf-8?B?QWh6T0lWM3hld3g5ZUFMWFV1Rm9KczI0M0VLNDFnNVJkVmV3MFptQ0FWWWFw?=
 =?utf-8?B?aS9KMVhBbDVhL3dGRkd0aUN6bHRodTQ4Z3FUOW5BSDdBYTV6QVlCVCsxZTJx?=
 =?utf-8?B?aWlnNk5ZR3R5NGdWdXFPK042L0luRVpxdjNtUzBVTHBkbjFyZ0twK0ZJVTdu?=
 =?utf-8?B?VjhvR1NRR1AwbTRPR2x1QmNVeHlJcVBDR2xjdUV5RzlOYytmL0pPVDdwNHJI?=
 =?utf-8?B?YWFQMk5yVGVqSlVGbHhUb0FiYXhteVFDTVNhampwYUZzSDRhNTdudzEvbWpI?=
 =?utf-8?B?RVhZSzRpVVVEeTk3M3ZCWVRqUzE0KzJsTGs1R1JUTlJydXhrTmgvaTdjN2JY?=
 =?utf-8?B?ZnR1NGswTHNuQzlrRHBpeHU4OW5GcEZpUmFzWWxUV1NQdkRMWEhiWWFJSmsr?=
 =?utf-8?B?SjRSbEJJWnlvN0FQU0FMaUN2TjYzKzFVcWphak84OGxxb0hVcDJJcUpmME0v?=
 =?utf-8?B?ZnlzWmt1UVlzTHFmYlMrTVVaYisvZ3FQNmhyV0xsNzZ5a3lNZk5BblBPTm1I?=
 =?utf-8?B?K2o2NnNwZVpLUXdVaWpBVFowRnpDaUN6VzRoVFB6OE8weXFCU3hhNUtiWTVD?=
 =?utf-8?B?L1JrUlVYb3VDUlVGekdZTmloWHp3Q0JxdVNvczcwRmpkUkdGUDR3WmFDN2E5?=
 =?utf-8?B?RWFqN3ZxUjhta0hub3hNMVlkd0YvTFhpdSs3Sm5mTk12Y014TEtLQks5bE0y?=
 =?utf-8?B?aVNGWHIydG50WEY3dWVBVzE5aVlKQUNobFh4WUxueDFadmRRR2JSNTVxQTFD?=
 =?utf-8?B?aUpYTCtwbFVyeWk1Zml4RnJwYllWZ1B6UC93bXVRSTYxcC94NFM2K3NsOTYv?=
 =?utf-8?B?alBPblkzNU1tN0YvRlN0a3M2dmIxN1U2SlFvN1pjTldURmVTeUxxZThoZk9t?=
 =?utf-8?B?ZDB5Z2tzRHpSRk5jby80WVlTNXlSZUVoQk9RZzJEZm03WEVqTmM5eHdlcXpF?=
 =?utf-8?B?aFh0SnpjZ1ZIVHgwL2NYSEVicTAxd1BrZUg2VGR1MGMrR3dFVVE4U1M1V1RG?=
 =?utf-8?B?MlJNZlIycmpVcGpiUFR0ZjBQVzRiR2J4MzlycGprUWlDdHozdDJuOVhoSndB?=
 =?utf-8?B?VGpRZm9NaVhqQVlNNFRaZFc2d2ZJazRVZkdpREF5VW5rVnMxQURncGtlTll3?=
 =?utf-8?B?ZXNpS2R6NUpCcm9pYVp2clJ5cVFBY0F0cUxxTzQ5RE1xQWpFdTdpQVppNFMz?=
 =?utf-8?B?eXd3clJpL2poRTN3WXhabms3K1JndHRwOE1kM05LVmQxYnhPZVJXOU1lL3FL?=
 =?utf-8?B?SjFmOXNmWHhDY3JoOUxEN0llNldUWkNhdXZqbTEzKzZ3dVR5M010QUhjVU53?=
 =?utf-8?B?ZGpsenlERHNyVHdiaE15azhqeEhiVFZ1WUk0Q25SME9EQ3NxL01EYVBLelFE?=
 =?utf-8?B?K3pHdG1sYWhWdlFjNTBGM3dxRGVCeVFWVFFuNVB1SHhCZkVtWXBtb2YwN3p3?=
 =?utf-8?B?ODhJWWJKdkVUaThYYnNFbkM1Q2FTVnVjc0g0M0MyTGZ0c1hVUTVzRjdkZlVO?=
 =?utf-8?B?d0ZqT1BTSk9MVVJJampLTmh0ZGp2Q29aeXFxcjV5NnRUb09CZDVzdTh6OTl0?=
 =?utf-8?B?NTNsR3RUeE1VZUVoNS8wclZqREU3eHlPdlRCYTV6bUlNTWlWZEwzdWR1d2g0?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb67a185-fdbf-4c8a-e3ff-08de36f81b40
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 07:53:57.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HuyTxfKsSCCZqdCh5EY/3vzibIVxIvnctbPBQB8l8aDdlgPOUURZ2GFLgig9ke5RL+pL3jW+t6CdR261dGuk+c0Vo7u4SfpnyAe4HGtZ2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7611
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> If there is no CXL properly initialized, what also implies a PCI-only 
> slot, the driver can know looking at the CXL.mem and CXL.cache status in 
> the CXL control register. That is what sfc driver does now using Terry's 
> patchset instead of only checking CXL DVSEC and trying further CXL 
> initialization using the CXL core API for Type2. Neither call to create 
> cxl dev state nor memdev is needed to figure out. Of course, those calls 
> can point to another kind of problem, but the driver can find out 
> without using them.

It can, but I am not sure why a driver would want to open code a partial
answer to that question and not just rely on the CXL core to do the full
determination?

> >> The HW will support CXL or PCI, and if
> >> CXL mem is not enabled by the firmware, likely due to a
> >> negotiation/linking problem, the driver can keep going with CXL.io.
> > Right, I think we are in violent agreement.
> >
> >> Of course, this is from my experience with sfc driver/hardware. Note
> >> sfc driver added the check for CXL availability based on Terry's v13.
> > Note that Terry's check for CXL availabilty is purely a hardware
> > detection, there are still software reasons why cxl_acpi and cxl_mem
> > can prevent devm_cxl_add_memdev() success.
> >
> >> But this is useful for solving the problem of module removal which can
> >> leave the type2 driver without the base for doing any unwinding. Once a
> >> type2 uses code from those other cxl modules explicitly, the problem is
> >> avoided. You seem to have forgotten about this problem, what I think it
> >> is worth to describe.
> > What problem exactly? If it needs to be captured in these changelogs or
> > code comments, let me know.
> 
> 
> It is a surprise you not remembering this ...

I did not immediately recognize that this statement: "problem of module
removal which can leave the type2 driver without the base for doing any
unwinding". This set is about init time fixes so talking about removal
through me for a loop.

Thanks for the additional context below.

> v17 tried to fix this problem which was pointed out in v16 by you in 
> several patches.
> 
> 
> v17:
> 
> https://lore.kernel.org/linux-cxl/6887b72724173_11968100cb@dwillia2-mobl4.notmuch/
> 
> Next my reply to another comment from you trying to clarify/enumerate 
> different problems which were getting intertwined creating confusion (at 
> least to me). Sadly none did comment further, likely none read my 
> explanation ... even if I asked for it with another email and 
> specifically in one community meeting:
> 
> https://lore.kernel.org/linux-cxl/836d06d6-a36f-4ba3-b7c9-ba8687ba2190@amd.com/

So this also is about the init race, not removal, right?

This is why I think Smita's patches are a precursor to Type-2 because
both need that sync-point to when that platform CXL initialization has
completed.

> Next discussion about trying to solve the modules removal adding a 
> callback by the driver which you did not like:
> 
> https://lore.kernel.org/linux-cxl/6892325deccdb_55f09100fb@dwillia2-xfh.jf.intel.com.notmuch/
> 

A proposal that implements what I talk about there is something like
this:

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 51a07cd85c7b..a4cb6d0f0da7 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -641,6 +641,16 @@ static void detach_memdev(struct work_struct *work)
 	struct cxl_memdev *cxlmd;
 
 	cxlmd = container_of(work, typeof(*cxlmd), detach_work);
+
+	/*
+	 * Default to detaching the memdev, but in the case of memdev ops the
+	 * memdev creator may want to detach the parent device as well.
+	 */
+	if (cxlmd->ops && cxlmd->ops->detach) {
+		cxlmd->ops->detach(cxlmd);
+		return;
+	}
+
 	device_release_driver(&cxlmd->dev);
 	put_device(&cxlmd->dev);
 }

Where that detach implementation is something like:

void accelerator_driver_detach(struct cxl_memdev *cxlmd)
{
	device_release_driver(cxlmd->dev.parent);
	/* the above also detaches the cxlmd via devm action */
	put_device(&cxlmd->dev);
}

What I am not sure about is whether the accelerator driver needs the
ability to do anything besides shutdown when the CXL hierarchy is torn
down. I.e. no ->detach() callback, just make it the rule that when @ops
are specified devm_cxl_add_memdev() failure is a permanent failure at
registration time and CXL hierarchy removal also takes down the
accelerator driver.

