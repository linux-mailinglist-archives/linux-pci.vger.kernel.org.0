Return-Path: <linux-pci+bounces-45014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2313D2A88A
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 04:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DD0F301B4A9
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 03:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310BC30FF27;
	Fri, 16 Jan 2026 03:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3+WpZWY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE93385BE;
	Fri, 16 Jan 2026 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768532881; cv=fail; b=T2HdWR4x96drGeI/WECP4NX4yoVO8uKFXA84uZ0dPMlnQbefbhaPSDd38M8xwNLYx8wtHrYf5pgbJiG+p6MTsQlJRMq3bpZRi/CWSFYM8QdMQ4p0ExuV/ADohn48CV3P35CREN+WCobHqxXlWk2Awy7fDw1EFUisI2Jeh0lUK+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768532881; c=relaxed/simple;
	bh=OGIx6CK0WvIpJwARReD7R6ZaWyfR29TR7P4Hw0vFB1I=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=D7nKZqGWlfqZIKibOKDrUuQvHj/t9M6kioL9l//hmF+/Jt3qI4vR0T+OmhQV/0WNGIp4JdBdJCFRxIMUz9Rg57WM4BF7piw74og4eZSD/fGat54cLM/cg2IJCjIp89RD82cglyf7ZNZdxZHRd8koXRd74LALiRG+UV+2kd3Aksk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3+WpZWY; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768532879; x=1800068879;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=OGIx6CK0WvIpJwARReD7R6ZaWyfR29TR7P4Hw0vFB1I=;
  b=A3+WpZWYQAKJPG+gZZANkLIVppn0nWH1iCWclDtwrHtowAIlSR7Wy7Tc
   0inKp6dILjjPnUU+0235PqD54HaJplPqw1JO0P9AJuSS7HoY48jWUMN7w
   JHXko/iW6xPVQAn1qbe1b0BNg0LrNtAy1vyOlgqEvJGjZU2tjJh7uSAYq
   lERFTkRKCG2v7jnSEbdgVwi0OPtQHRadThNXwEcy85RTSszut3T5j4C6X
   GtCcUARrQ24rjMpyIZmWDis6q6VYTecxxytgR/TRzWAe/InpcEHE6TIWT
   e5QjjUc6r65778cUTmH66tMMaR878MRYAOcB28I+M27GAdHGl8jrF34o8
   g==;
X-CSE-ConnectionGUID: ucUv1m3kRS6M58nQg8uS9g==
X-CSE-MsgGUID: gmGMmXWcTAuF2DqQ91Wqbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="80153329"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="80153329"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 19:07:59 -0800
X-CSE-ConnectionGUID: qtH0Wfo4TR21rmCPR4zijA==
X-CSE-MsgGUID: GZBNCzPzSweElXCKKufJVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="209612452"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 19:07:58 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 19:07:57 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 19:07:57 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 19:07:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knQm9tIbv2Yn5+f1c3/ijX1fK0HI3MbQutrCVWeMHMdPd9gsO9vxoT42s1VmDC6H8+1DfjXHSXG+M5RfxlUdqrokurbfIgldhjn3fc7ii1hjY57kOEvK/1vd6PAqRKeWk14/3Y0+k3PX1r0r3m1uvGQxeEFXSNG5xsuFvRD4nJUKCiwc0cQiI1Lc8pYm9tdsuaj21znItGAoM8cpRx0FyxDZkKKGS78NJ3dlaMNx7+xAixzdu4ov4WWG9g6dmxwCsQyurLgEsWNwhDNcFEbD+qMYnTBzbX2VzR0uty9l6gE4wLUzOfngQh2ypl83oHsX0be9FsjSqiojrfM7UyiPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roGkH/SB9ZSeQhhKLPbuOqSlz0miGSV5ddDIeJCtajA=;
 b=O+2g8tWaK6iQUryFYba5QpZTwi5DtEVhREYH4SE0WD0nYBZsazNagprLoGFhX2FcYAop7V1xYDkDA1d0CgQq8tP9NGFhm5DsijkTbKt6mAgQS5/Scegd1HVNwnT8iCPoyxW346kjvbrnNbuPY1HvkIi16H86Jh9bbaCHM4K6jHPYzp1ZFPurr0TbVfup3qZRhefZJN/GMww3yFzaqwdwUyUNAF5rvUiGORUddBFPYY115NiRzLPCpMGObvtbnhrmYfcEqzkE8LEDI1F7dStC3rVzeZhruFQUSn1dwaEYccs+fDcZNEAgi0Pg4lUrkicHOFVxc1XgcOGKcgE1AO4p5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH0PR11MB4808.namprd11.prod.outlook.com (2603:10b6:510:39::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 03:07:47 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%2]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 03:07:47 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 15 Jan 2026 19:07:46 -0800
To: Dave Jiang <dave.jiang@intel.com>, Terry Bowman <terry.bowman@amd.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <6969ab82253a5_34d2a10048@dwillia2-mobl4.notmuch>
In-Reply-To: <7a02a650-cbd6-46a8-a6b1-b0d816dd6376@intel.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-17-terry.bowman@amd.com>
 <7a02a650-cbd6-46a8-a6b1-b0d816dd6376@intel.com>
Subject: Re: [PATCH v14 16/34] cxl/mem: Clarify @host for
 devm_cxl_add_nvdimm()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:a03:80::31) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|PH0PR11MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f8794c-8b2a-4f14-ef31-08de54ac6d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enc1VjZYeGs0b2tKZzJxWEFDcUVTUTFWNmxQeVkzWXB5a0Y4YitaWDlxbWhB?=
 =?utf-8?B?bTkrMHJpdkhRcjc1UzMvMTAveExYZEpJdXZiRC9GdENMSkdOdFpmRnJvaU1k?=
 =?utf-8?B?ejBnbmdDcldLeEE5TnlmbG1EbndPOFRPQlgrWTZMU3plaFFNc0lMQWpqMjc4?=
 =?utf-8?B?eEQvSllHN0ZVMUsrM2FGb3pYVUIrOXJPdUJwdXFBZys3OHd4K3VHNW84UmZJ?=
 =?utf-8?B?dFlxTXFVa0xLVDluZXZleW5CUjVZajZPcGJKZU9ZZlJUenRhT1Fpc00ycHlG?=
 =?utf-8?B?Rm01WjhNMHZIakJnQ2ZVOUFzeWYrdy9zSkZnUXhYZ2orR0tOS0lJdzA4Vm9k?=
 =?utf-8?B?eDd6SVM4Y1Q4UjRNVzZjQXIzNGxTaDlkYTlvWDZURnBPTWNENjlVMlRUT0V6?=
 =?utf-8?B?YncrNWtPQnhYRWZUM0VEVlpQQTdldTA4b0hxOHVxU3FGWnRxNkM0cFQwZUJt?=
 =?utf-8?B?MUlldmdOczlXcTZORm10UDNJU041WEhUZWRNM1ZJQ3V0NHlKOHJrZk5zNjRp?=
 =?utf-8?B?cDk5dTVwTCtlWEtyNEZYS3VCSTdabit0KzJNeUpCaHdObXFobGtWL05oVEZy?=
 =?utf-8?B?MUFkZUs2d2FMQ0MzUWNQTXpSaTFHTVI3K3BnRXpRTHhSQUJXSHYyWFBnczBl?=
 =?utf-8?B?OWJ1cUxyOVJHaW1PT001VUxiYmhLM3ZxM3NjWlpxRUFMZWtzZ21RV09GQXVw?=
 =?utf-8?B?bG0vL1Y5Qi8zOWtiY3lHdEM3VlR0cmszaGN5RHczVmV2SUdTZnRUN0YyazdM?=
 =?utf-8?B?QjdlOWVkaXB5T2FVNFhkeGJFb2ZQNmQ3UFlVODQvNGgyd0NUNzdRQXB4LzJz?=
 =?utf-8?B?WGJJdHYzVlo4Z2lMZ2Y0OU1iZFVxWkFIVGl0aGoxbDRwTW5scHNWc0NkUGRT?=
 =?utf-8?B?Mm5RUmlXb3VRWXBJaEpuK29ZUW8xZ1hmZEN1V1A3RFpQdDZFdm9zQlZlTnU4?=
 =?utf-8?B?c0NIcjhSaFlZSEllNUNKbmFIY1NBUWwySFMxRi9DcS83U1RZSVlrdkZ1Qjlr?=
 =?utf-8?B?NFdvN0FJdnBIYnR3bjZ6SkJFS0FrUVVOcENaaEY2dW9PKytqSDdQSEx6YjNI?=
 =?utf-8?B?U0RjMDJqa1JnbEUrOHQvbmRMSHB1cE5CT1RUNzh0dkM4eGNZWVFzUXZTWTI3?=
 =?utf-8?B?dmJ6QTYwTy9rdXJRdzk0eVRsdzVmL2ZtWEhMZkYzZDRKaEcyUy9xWXloaDdz?=
 =?utf-8?B?Qy90SWV1OFdScFAzNjJjN1VmQUphbkd0djdOYXViYmhsOUhLR1h2Q010NmIy?=
 =?utf-8?B?czkySEFHSTNMTGRZd1l4Z2RhYmRpa0xCK2FNeUFiNEhodjUvUmZ1U1lXVXpV?=
 =?utf-8?B?d0NncEhiTG1XUHczTmUzWGxjUUdqQUo0c3luVklONWlEODVOeDZTZndHdURw?=
 =?utf-8?B?VGkwUEoyMU5DSmlnYWozdUhMUmhSM0FWUVBVSGRyRXhzVVhkUjBmbGxSYys5?=
 =?utf-8?B?N3ZhQUsxN0JNODNPZ25rTW9KMUZxUGQyWVRoWHJlMXBuUmJzOGIrTGdqS3cy?=
 =?utf-8?B?N0doZnF4UHpzb3FxMXRNREY3NGFkUlQ5TEhPRk5uclJsUFFLbDJLNzRKOHBY?=
 =?utf-8?B?Szc3cmdJL2M0SGJBMEZwbTJLaE5lM1RSb2dVeG83bGhNZGVjK1doZEx0V1U5?=
 =?utf-8?B?a1NycW1nNFRCRVBjYkdsZXBad2J5VnJFNllZZ005dFYyTWRmQ3RqZ1NkbEM2?=
 =?utf-8?B?c0lSdGlLTEsyR3JrSDM3dEd2cGtac1J2WWhISHk5aFZGcUJsbnBEUEJlRFBl?=
 =?utf-8?B?RHRGZmJ5K2prclltVHZIQjZyRGViczMwNmVONE9TRnJqLzVuZ0RNNmFVSVBr?=
 =?utf-8?B?ZkxJU09kdTJSRUF0bnBFWll1WjB0RjQ2dXYrYWJtbTNzRE4xSEpiZEVaWTJ1?=
 =?utf-8?B?RWJDTEl3TStwaXBoYnlXaW55dzZFVlN4UzFIbkREeFBGTXBJRGpkaUh6MFBo?=
 =?utf-8?B?TVJaK1pMblNaLzNaUE44dlJqb3ZHV0NieWU3Y2VJTEhHMHR3Sm96ckZtRERC?=
 =?utf-8?B?T3dRL2U5Q2JHT0pRd0FiWW9mQTFCRDhPYm1BK213VWhVZ1F6MTRDK3N6dXhD?=
 =?utf-8?B?SmtXeXRRN0lybENBVEJDOEM4ZzVVZGhvTlF6a2VGUHIyYk1NRVg1NFQzYkdw?=
 =?utf-8?B?WmtSck9rdG1nQ0Z1Wms5cVpBWjNuV3o5NmNCcXZ0dUpKek1MWnV4N0FlZ1RP?=
 =?utf-8?B?WkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdWUlZSbnViUFQ5SGc2SE5iU2hKZlRoQzgxdytYSEcvcXpmYWcxbUNWUTlo?=
 =?utf-8?B?ejJ6bDhjVzB6bFErQWk0akNxMEQvZGt1UGVYVFFxVldUQThYMDhDdmdHN3E0?=
 =?utf-8?B?R0FRY2ZqQkE5THMrVTZzR1dUV0d1S2dvN1dUL0hqTXpseVNCM1BLNzlZMzZP?=
 =?utf-8?B?ankxOHQ4S3VNRDlSTWRhSE9uZ1V6M1NyWTR6SURBM2VQV0k2cXdTMmhKOHZR?=
 =?utf-8?B?WjRBY0dyTFlmTUxURHNuZVlBUUlZaWlEc2NodFd5REd6eDlZMkFCeXN6QjdN?=
 =?utf-8?B?N1o3VWlhUTQ3NVhJWmtiY05HWS9qeUZBVXQ4dkI4WmFRRGdnR0lWc1laT1FE?=
 =?utf-8?B?a3VLTlJLLzJTMVgwSzdqci9QWWVNVUFNbDFsNmtYeVEzUTRManZhRzU3TENi?=
 =?utf-8?B?WXFqRmw1ckpSVWJjdXhYYnltcVA4ZjR0RTFrMU1yaVo4c0lQZ2UwYXlvWlpj?=
 =?utf-8?B?UzRsSGVQYytXYjRnbG93MzVvYXRBMkRJcG5DbGtEME5wMjlYMGJGMWlVeTcr?=
 =?utf-8?B?eC9kY0E4aUdXSnl2NjVoa2hoTGc3WVhvYjhQWjhnbEdjejFkMmF4QTh3Vkw2?=
 =?utf-8?B?SlRRZUhvbmxrUmJOVkwrRGV1dlN5NnFZd2M2WDJlZThPT3ZjczhtMmlZWExs?=
 =?utf-8?B?NGd6OFFtQXBxbFp6RHVLT2lTVnRibEtEZ24xQlJzYlBRQnk5dVowaFgxY21H?=
 =?utf-8?B?TXNhK25WVnhZaU5rRWVRTVc2V2YrMG9PL3o4a0YzTkorTFR3OTV4UTVWQVlS?=
 =?utf-8?B?RGh5QkNJRWMwV2NwRFdTZVRMRktMNGJjRFJTNE9qZWxqZDZoMm5mSWNJcW5K?=
 =?utf-8?B?ZVNRa3ZkRW5MY0NhUjhBd1NlUFNucmo0WU1xZ0FkN1hHdExzT2FRekIyd3lF?=
 =?utf-8?B?OXhjTDNNdWQva0syZEZOV2JnSDFvU3ZGdms1RWwzaVZKQk11eDFzV3d5U2cx?=
 =?utf-8?B?UGFTamc4bFhpd3RSRjJMRjJmR3JzbEtQRmJpOWZQSVB4eHlTTWhBSWZwQWJ1?=
 =?utf-8?B?cWNiKzd4b2RKRmYzQkFBbWtQKzRtTVBzdlpZRGlzS2tWNTJyeWg0eGJ0MVBq?=
 =?utf-8?B?UHU5cmVOUTVxNjZBV0RyTi85cExPNDBPMUgrcDA4TzVYRitobGc5NVZHZUp0?=
 =?utf-8?B?MDJFelFadFBHQkQxR0QxWEFxalJ4QWVMSmtUMG5sRWYzeUJsMG81U0dCbWhY?=
 =?utf-8?B?MDM5ZDlzWHowNFQwRVovQWwweHZEdFdkMU1Oa1gwOE5IM3l6OVMrdE5ydFFz?=
 =?utf-8?B?NFQ4RDRsYzUxam1uTmNrNGl2QkdDOWE1ZTRBS29HdENmYkU1U1pUSFBWOUJ1?=
 =?utf-8?B?Ylg2Z0Q1Y3psc255WHB1THpBWUxiUm1wV2cyd0JzNVFsQ0NYNDdzUk04MW5N?=
 =?utf-8?B?NlhNazRLZGtETDdNdHF5Uk1mdGdiZldHTU00ZVRuYXBTTG9DUHlEbzRmV0J1?=
 =?utf-8?B?T1lpTUtsbWRydGFEbTk5eDdhQXh0bkJzbGhvSGVMS3JEQUZieVNtMFlRaVQw?=
 =?utf-8?B?OUtEOG16b1ZIZTRWQktLT3FKMlEvcm9HK2FkckFKbzhjblhnd3IrZTFXcFFt?=
 =?utf-8?B?NjdyMWgzaGQ5alVCT1BSTmQydlh3akw1OUJsaWZkL2ZSalB0NjNNMjU5VjZC?=
 =?utf-8?B?NWxvZHhheUhKVUJ6QUh0Mk9aK0dubEtRanhSQ1djYVBPT3NuY3VsVTV3UFps?=
 =?utf-8?B?NThOeDdWeEFOU0QvRXBpVmE3WlUxaVZmd2JjKzA2SzVTM0pkL0dVUUU5Zlg2?=
 =?utf-8?B?djk4aUhic1JPOW4zN3hRbzdmZUpuZmNzSzRxT0UzMGRxeVp6akMzVnh1WnRX?=
 =?utf-8?B?VU1uRHU1VnM2Q0xIaUE5QUhhdWxkaFFoRmFsOWdBUEV5Nm9QMC9hbDBKRi9Q?=
 =?utf-8?B?NUpDR215Ym93UFRtSnkwMHd6S3dGUWJ5UU1zMGJNQ2svREYrOGkyclZ0V2M4?=
 =?utf-8?B?dDFPdUNLc0doK0wzcmloaElCZmdVNVNtYmFyYWhNQTdhM1duVVBpUk9manFJ?=
 =?utf-8?B?dHdnTE9DWWhsY0RDTGh3TGRVVkxhWUZuUUg5MGpNaXZtTlVjb3dLSWM0eVdQ?=
 =?utf-8?B?TzJIY2o1VGJ0cktDUk1UUlZXNlMwZ2gwOUxOcFhNMCtsb3NGYTdYbjZwNklt?=
 =?utf-8?B?Rk9Dd2pWWWEyMmtCYk9OUEZ3SDJqRHpyeWs4SVNGZkd0R2tFMEtoWFpmSzlQ?=
 =?utf-8?B?dVZGRGxZamc3dVFBcUU0bDBrS3BjTitjMVBvTWJvSkdPOUloYy9TSnA5cVph?=
 =?utf-8?B?Tzd3NHEzdDl4TGttOXBDcG5PZ3ZwRGRSdG1mdGx0dnVoaTdDcXdScjRzMGVi?=
 =?utf-8?B?UXlxVUJaeXBEQWdmK1BHUk1haEI4MDJxMXZDVDB6VVN1U1lCbG1HSkw1dXVU?=
 =?utf-8?Q?xGQjO1I8c/RBFF54=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f8794c-8b2a-4f14-ef31-08de54ac6d31
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:07:47.7437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKF3EWfuAz+zpfI3ycYqt2blku1VGAn3q6RmPWZCa+FIQXhKAIo4iWKM4hyTwJ+YJV29lLZq+6sk9k3zFDALL12xuy7S9Gg6aFNDfLHv0zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4808
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 1/14/26 11:20 AM, Terry Bowman wrote:
> > From: Dan Williams <dan.j.williams@intel.com>
> > 
> > The convention for devm_ helpers in the CXL driver is that the first
> > argument is the @host for the operation (locked driver::probe() context).
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Terry Bowman <terry.bowman@amd.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> A nit below
> 
> > 
> > ---
> > 
> > Changes in v13 -> v14:
> > - New patch
> > ---
> >  drivers/cxl/core/pmem.c | 13 +++++++------
> >  drivers/cxl/cxl.h       |  3 ++-
> >  drivers/cxl/mem.c       |  2 +-
> >  3 files changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> > index 8853415c106a..e7b1e6fa0ea0 100644
> > --- a/drivers/cxl/core/pmem.c
> > +++ b/drivers/cxl/core/pmem.c
> > @@ -237,12 +237,13 @@ static void cxlmd_release_nvdimm(void *_cxlmd)
> >  
> >  /**
> >   * devm_cxl_add_nvdimm() - add a bridge between a cxl_memdev and an nvdimm
> > - * @parent_port: parent port for the (to be added) @cxlmd endpoint port
> > - * @cxlmd: cxl_memdev instance that will perform LIBNVDIMM operations
> > + * @host: host device for devm operations
> > + * @port: any port in the CXL topology to find the nvdimm-bridge device
> > + * @cxlmd: parent of the to be created cxl_nvdimm device
> >   *
> >   * Return: 0 on success negative error code on failure.
> >   */
> > -int devm_cxl_add_nvdimm(struct cxl_port *parent_port,
> > +int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,
> 
> s/port/parent_port/ to maintain clarity of the port

...but it is not used as a "parent" port in this function. Any port in
the topology will do. The reason a port argument is needed is
disambiguate when there are multiple CXL root devices. That currently
only happens when cxl_test is loaded.

However, after writing that, it may make more sense to make that
semantic explicit and just have the caller responsible for passing in an
@cxl_root argument.

A change for not this series.

