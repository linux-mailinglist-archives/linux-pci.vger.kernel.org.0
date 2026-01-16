Return-Path: <linux-pci+bounces-45018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C243D2B8FF
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 05:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 102383033988
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 04:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B5D34AB0B;
	Fri, 16 Jan 2026 04:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Upj64Fn4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEBD34A795;
	Fri, 16 Jan 2026 04:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768538750; cv=fail; b=Q1wpSigkmljvGo1IevKXwu0vGDBO/rQ7L5lMsScJj8+SMhPrgtmWsERjFNoAy59XTqoPrS9P9wBlOaBK/b/DTwExZkvJ/aSJ+P6tHHxXWLlEWSlHPpThaUZMyvQvzI6Fy8Kx8eQTe6ig9ynDsJJiwjCDq73pNUe3V8JhmKvJebI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768538750; c=relaxed/simple;
	bh=0ketiv/ArYqnjUMP3vVQOrPsbgnmuqnnABA/mqHtnio=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=NQQMDSitlGQgXC5/8BnCefCPmlNZt7M/EhpDNyd5k/Hc1XLUViC/BetLO7O7waqRB2F6nNkglRGPSJUZaSNa+f/hx92a8I5I4Wkyg7fg8cuEXEBoQb9Xt1R9a73ns6liTeQnFu1zUbjNHdktRSeriaMJPgqiwalSkqyd1rZtDkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Upj64Fn4; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768538737; x=1800074737;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=0ketiv/ArYqnjUMP3vVQOrPsbgnmuqnnABA/mqHtnio=;
  b=Upj64Fn4HefcqBRl/mnRSBmwMLhAH5mbgRlEcb+NiryJARd9r1NT2tTx
   I0xkEkOfNk02JUbeA1DL94np+zmpiuzsyW+UFA/VGDbZ5QNQWJFnbz0RB
   jZBJK+Bd+ibHel4NCjqliurmydvKd3illdgSG+e8+8bmqHgrbDt4fkcRX
   XKU5KKgVFPbZnyAhw7A1svb0nITtLcP12Z3QGUbJuK0ySOkDfAlPsUnvJ
   SWyOVzTZxKpsvbBm5so2eOse1yMAjUXjyMCELZEAFN6IKxZ+Ku++QeVc8
   pk7Pq4bQogbA4JVd8PUU459D/5RKKIY2O0pFRaB961wwsXR4ZhaDZWHFa
   g==;
X-CSE-ConnectionGUID: 04Cv5Dt6ReiT53b8M6RT3A==
X-CSE-MsgGUID: WUhfkXZBSj2QwbGJ6/BdqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="73484044"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="73484044"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 20:45:28 -0800
X-CSE-ConnectionGUID: ymiO2oYeRTuDe03tWPM5kA==
X-CSE-MsgGUID: rhMMqzgRSMWQiUiV8o/TSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="204350790"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 20:45:27 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 20:45:27 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 20:45:27 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 20:45:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ev9bvhSrQKt73hEK8vHs8C2GvaL6+vkyZ9KYQZk1n8/hpzGyzig946M/XyyH2Y/BotCi5gMSmRlWj6QRwuegpamkY4mpRZ3rtGY8Aa0f3XgFCCfiWS3bgaGTQhK6d7veR193Kfs7QUEIp2Mb+NEFjLVh05oZpuJv9WkAvH6+mdtn83xmqgKt3Vr1qI1Tf2CKztzQnIjev5WbA/CqRG8Xm5d3ERikETy8VjHuploSSAMa/S0Ok3wYzCudZGL64yfj6FTLfighsSA3CEf35jY+CeiyMHNNRJ7kExMcaSa6lExJMNMj+OfK2eAEOQh4+uUtwtTAmeem3s1jIjMjrOktnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du5lgc6NBDK6FSacW4Pw7xc7+DXIH/mIvXXFqf6Kgjk=;
 b=GIJckpYqx5gm1m12Ptk6sxaSbD2xAN50T7XoJX5om23kR8FB78VBIMnI0bq/lHaHoVsrR/+UNm1++mtbTHzmeSZB1FfbQ9T6caJX1lP6PFNucyCIIRrJVkI+3pGlXEwyCjaicOlJnH1UiZson65CbnGgYk9MM9ou/UNPnkFP9dYjpP5EBKhwESdtjLqYPF9Mii2ZXjxFdegu7iDf5ewU0VVZm67ZwGiYvgi4QF6liL2EUCYzbEvKO0uRtltDZI68o4q2C08Cg6GDw6HXQCd4HxvWmrRARfAcO+iNXC/uGvkTVnfjWkrlFNthljDbZi2tR6itX0FQ0J6Y+kTInJq6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 04:45:23 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%2]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 04:45:22 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 15 Jan 2026 20:45:20 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Terry Bowman
	<terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Message-ID: <6969c260b7998_34d2a100f6@dwillia2-mobl4.notmuch>
In-Reply-To: <20260115144605.00000666@huawei.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-20-terry.bowman@amd.com>
 <20260115144605.00000666@huawei.com>
Subject: Re: [PATCH v14 19/34] cxl/port: Fix devm resource leaks around with
 dport management
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::26) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SJ0PR11MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 15bfc2e2-92d2-4657-de5c-08de54ba0ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzI2ZjZYNkE1ZkZ4R3EvdDhLTjBOc01SbzRsQk9McmExRGRtTnQ4WlpvN1NW?=
 =?utf-8?B?RGMrc0tIKzd6ZFpjc05ZMFNlR2hXY1g2YzV0M1BpSzVyVzNjdUNMYk5oakx5?=
 =?utf-8?B?YzNwSUFJKzZkK1BiTTFsWXpDN29qVlVJZG03OHpZaWJpdGpmOTNUaFMzRTJS?=
 =?utf-8?B?dCtnZFRudnVKdmg3T1FDakQvWWZmUlJGWFh6Wkd1c1pRN2hzV0JDdHd4WnFU?=
 =?utf-8?B?SVVHTS84V3JwVlF2NmcvT1VKNjNUNFllWWxYdzFaem5CQ3BRRVl3OGpvMjdW?=
 =?utf-8?B?WXJGZjYxQzhWZHQ3cGF3Y0I1TTdyZ3VvSlM0Y3RQZkJHbzh3Y1dHVWNWRVVs?=
 =?utf-8?B?YndYZGR3alZSRkJPSUx2YVR1QlFjTUduQ0FZcXB3eTg4cVhKTEdpeFMyOTJj?=
 =?utf-8?B?c1l5emptWkppc1VNaTgrUmtoR1BxQVFML0poMEtCNGZSRmJjLzNRc0ZsdnRZ?=
 =?utf-8?B?emVqV2tXM0k1aERaNEU5ejFFL2JuOWdlaHl6bW5ZM2I1N0EvaWsxKzcwUUNt?=
 =?utf-8?B?NGRidVR3cVRvS25sbXlJU3BkY2F4SXBPQ1JFVUVkazdORlRyY3BNQ28xVStU?=
 =?utf-8?B?WGlzTzA2K3RmNlUwaXVudWI4NTd1VnBkZlo4aTF4Tis3akFZWXRVbUZFS0hP?=
 =?utf-8?B?UzRQcldkUkE2ZzlIWDRnb1JDcnlxS240TGJxMkJZekxvZ05aS3F6U21uRHBy?=
 =?utf-8?B?YVExRmh0ajd5V1dSY0tSdG9qa0xKMFhURU9Sa3ZKdXNFaEpkeWFTaTJtOWhZ?=
 =?utf-8?B?VmxWSitaaUs1SE80MEc5cG15VkMwSVdTVnlJcHdjclUvcEZmZEN3bVRCdWZo?=
 =?utf-8?B?ZzB0TWZFaHgxeGVEbjh5dXFDUk5SNWxCVTF5NmxNQnI1b1ZxVHg1RE9tdTVS?=
 =?utf-8?B?STA5ejFWNHdQSytHUzRFR0FOdTBMQ3kyTnVkaUdDa0tveGNhMkZhUUhOY3lM?=
 =?utf-8?B?YkpOUjhyZzM2bkpZb3JPR3pTY3VxS0d5ZDg2RmxnZk1NUnVtQlFGcEZPZzhK?=
 =?utf-8?B?emY3Q0Y1enhiUkpRS2hUSWptci9XT2N3Z1JoRStsY3dhQjR1WWt0Mnd6VTE5?=
 =?utf-8?B?MHZtakJqak5XS3NVTjd0RlBEZExzTG13a1JsNmx3a1pERUt3QUEycEROUU9E?=
 =?utf-8?B?VlhXb2xoZzM1RXZMNTZZRnV1YXVFSmNDODJ5V3N2NmZuRDJTWk9QSmM2TnN0?=
 =?utf-8?B?aEI2WkdPWjN3V0VqdG9lMUlOZ0NEYVB2aTQ2SnZsTTNwUHRZMTJBcjBJN2Zz?=
 =?utf-8?B?L1dRUVFxWE1HeHlXSk85Y0dlZ2Y4a2Vrb1dVV0ZKR2ozZVozNXAxUmtKQzBJ?=
 =?utf-8?B?RUgraHN6cGRNWkgxYTRyMzhuYmRaM3dtdlZlcG9hR1phOStkRjBZTEltTlRC?=
 =?utf-8?B?RE52UEJ6dUFBclJpM0hzTFdQSzBzZHRhTDUyWFAxWjIxakZSRDhHZ3BzWlFt?=
 =?utf-8?B?L3lOeDNoKy9nK0thVHN1SnBsc3dKd0duRFhWYzlHeGRhTG8wOE94V3J3dE9w?=
 =?utf-8?B?a2VJNUFGSldzVFZCU3NQTzJ1ejJpU0lzUVJncG1ocjBnaXUxVGZpOVc4YjU4?=
 =?utf-8?B?VDhkbERUa29nUWhFRFpjUFVVN1hvdko1MkwrMGwrNVEyRy9ZU28wc2pRaU42?=
 =?utf-8?B?RjdHNlY4US9vblVLc1B4SUxqL29xZ0VheW5hR0NJQTdWYlo5SnpaQUNWZ2xY?=
 =?utf-8?B?R3RYdGxUdGY3Yld2VDlKL29EcGRXS2Z0dk45TlA5L2xlUDZETi9MamMrekRo?=
 =?utf-8?B?MlFLQzh6SUcrenNmSmNZL2paL2Judk53am9DZEpXMUtEYXQ5Njc5R3dvYjBr?=
 =?utf-8?B?VUNXeW1MeGVYZmRQMlBtenFsSkNaTEwydmVIdHpjdmZUd3ZMRXRUWTJuM1Nh?=
 =?utf-8?B?aCtRbElvWFYwa2NTNEFsTjR5VXA0OStINnAxOGNuYUQrUSs1RG1XU00vZ1VJ?=
 =?utf-8?B?QzVMbWpVTWtESGxiQ0VvajhOb1lrakhiZGI0L251NElPUkpJN1EvWUVDRTBV?=
 =?utf-8?B?NDdlYjEvVlhCdVpSdVVWcmVGMFpHTGRrd28wQnFTbHlVdVZUUEROekZvVGFK?=
 =?utf-8?B?am9idmZhYTQxWDkvTlNYNVFuZi8wTmZMM2xZR05HNVdWZEkraWxwL01jUXlo?=
 =?utf-8?Q?czCk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXpxYmhvNWl1MTJyc0ZqZHMyQzNlYnJ6SEhIN0Y0cFpCTWU4Yk5JV2N5SGR3?=
 =?utf-8?B?NlZicGdKbWNDWUY3bEhJbld2VVJicHppOXBJK3YrdFlkVVNhOENIejFpemd4?=
 =?utf-8?B?bjczZjlXQnhGaFZRNHZyQmNSeUlXWVJ0bVBGZUJtMkhtQmtadmFHK1RHZEM2?=
 =?utf-8?B?ZmphQ0RCWU5ONjJxbmZBZ3NjblBRczROZmVUUm1rWmY4UzJCdGZPMzljU2ZC?=
 =?utf-8?B?S29xVGZpa0ZwclZPKzdmRTFDSU9JRkJTVGFqSnJQV0lXdmlvVmhObE9SbGNZ?=
 =?utf-8?B?dEJESVFaYmgrV3dPVTdRNWxaY3B2VkNJaml3MmoxTTlFeWZMdWVKRytpR2hY?=
 =?utf-8?B?bHZERzloNXU0azNVNTFoZmJxNnJXNlM2dzcwTnJubHBBdFVJeXI0eEJlTFhT?=
 =?utf-8?B?M2taclFjZy95dmoyVzRpWFZxRWtmczJpeFYxRmU2L1ZDS2RVdEd5VVhVQ0Fx?=
 =?utf-8?B?aFAvTjhJdUUvRC9tRzNJYW5NUXZmQUhqcmU3anZMbnR6VWlGZzUxbm1rbFVT?=
 =?utf-8?B?ZzUvdFhvQXhPWTRvaWtUQVkzSkNRUEFQQjhETHR4UUZDOWp1Y0dlMU9Selo5?=
 =?utf-8?B?STR6WTlyY2RZMWFKdUNLb0pSUmloaXl1Y2xnM2RPbERKcjY2bm4xYVBzQmNV?=
 =?utf-8?B?c2xLT003cjM1b1F1MS9iRHJmalNGUWFKdzk4eUhwb1QrR2N6SkVFV09SaU5W?=
 =?utf-8?B?d1JXQ1lKbGtUdnpnZDI5OEcxdzhiUWN5VHJYY2xQZC9Wb1dMNnNhZlRFVmFk?=
 =?utf-8?B?T21JWGtkR0tnRjVLV3Urd0tHNmZSZnJGbFRJa3lUU04wem9NaThXZ2RzdVJV?=
 =?utf-8?B?ZDIzVFpMWTEvTGxKUDdJVDhHQmFrWHVtL0pmTC9yTWZWcVB3V1hoeTZnUUl5?=
 =?utf-8?B?NVo4dlo2TWpnZkNtdDE1RUN5cmVtZ3NwZTNzK3VjVEd6M3FPVXBac0xJYVJ3?=
 =?utf-8?B?QWFOUGpCWWhjSkI0YlZCODVmcEtVUnJ0UWRYckVJaUQ3em9HcnRCcEhKRFoy?=
 =?utf-8?B?VnlsV25xUFNwZkovQmVYZlo5cStjWTRqQ3NNRVNzcGpyeDd4RllYSWo5b0RX?=
 =?utf-8?B?MENZL05idVprQVFQOU1LbFRHbTNsdi9VVDZDTHgvbmZBZUVnZUFWbEMzck9u?=
 =?utf-8?B?a3hkSE5DTzJIN1VLc1g3MGRaTnZGR2l2Nnh2RitHWSsvWDhXdHlEMHhDMS9F?=
 =?utf-8?B?MHRVelhJN2MwOEd2N2toWllMTVBQUzJ0YnN6NVN4TGdWcC9CWEIvSWIwNytY?=
 =?utf-8?B?SkFkM0VKNDhXZW1IMkFNOFA2dkY2M0VtYUlidWp6RE1nMlpqeENJT0w0WjZa?=
 =?utf-8?B?dEFnNlpoVEUzcm9xbFM4NW5LSUhSdzg4cVJNZk4wM044OEJsNUVEWnJQWGxM?=
 =?utf-8?B?cGh5SjB6WTJLeE5HTVhqMlkxZkVMQld3LzExSFRLN0pEV0dUSUFQbTF0VWtl?=
 =?utf-8?B?aXF0OVlMbmVkWEVUNDEwVTY1ejdDM1ZXWWNNeTVwVmMxbTRMdzZNNm9vcloz?=
 =?utf-8?B?WXdVZmROWjRjMEF3dEVGT0JVbFdSeTFsWHA1UmhtRUJlRlBDQlErd2VsYnEx?=
 =?utf-8?B?ZGd2TmZhK251MFoyN0lFdyt0Um5rSVRIeWJaeGZtTUZoRGc5TEVKZGEzV1Mv?=
 =?utf-8?B?NUFJVUI1WjlSa1ZxUUhybG1VMkRxSlJnSHFxM2prOW8xSGk5T004RzZib3Qw?=
 =?utf-8?B?VzIrZ1E1cFZ1TlVnWEtybVdnU2NHSEZPK1RxNDlRTzNwVEFNemcreWxwQ1hM?=
 =?utf-8?B?UlB5a3J3STNkSjVvOFBORW5NejJvYThaYkdtTDM3eHlzY2d0VjgzSS9zUmgx?=
 =?utf-8?B?b2JzRHdqWU01dG1INEcvQndQM01oRlhVZDVudDhZR2ZkcTBiMUtabGNCNWwr?=
 =?utf-8?B?QmtRZnorVXpITGZBb0V5aFhDUCtJcjFUbmlMemp1a3QvVEVSRlVIT1krQlBY?=
 =?utf-8?B?TDJPcFlyeVVZYTdCLzJEMFQzSXo0ZlNMZTNMTUp4VnkyK2wrc3N1M1EzbFZG?=
 =?utf-8?B?Yk9HMUh4YU5GSnJlcVdsbTduZTBXOGw2bS9oWWhWWWJBNnpyQXFiWUxZYSs2?=
 =?utf-8?B?YUxxUjNTbXNwWEMzTzJqenhLTzc1OWFsOFNkOUErWCtXbG9TVXN1STRqRVls?=
 =?utf-8?B?UE52NVhITlAxdnJWUjRLVFBlMVk3ZmZZNENGa1N0dXRXUjM5TEEvSEpzMzFp?=
 =?utf-8?B?UE1XZ1RNTDI5eXVOQ2hSSnBLSG10MU5hb3p0YVh1ME1yRVk0c055aWl1U01j?=
 =?utf-8?B?RDI2bG16dHRYV0tvdU9HOHpLQWhwc2kzS25rTllwOXJtZ0ZlUjRGZmlOQUFi?=
 =?utf-8?B?R3p4Um51bkw3aEt3cmRPdTc4ZnU5di9LWGFJUWlMZmVvQ1hNWkVIYWkrMXhQ?=
 =?utf-8?Q?Ash3qscQ+vyr8aaQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bfc2e2-92d2-4657-de5c-08de54ba0ee1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 04:45:22.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGpLuJuoWdmOgVDUtOLKH9tLW7PoXTID7OBGE4WkA6j30GQ6hWw59mv5ahSSCEWOa0bC+PY2BDhWCO/jeBM6BlwsOsW9r3SneTqnrreTTvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 12:20:40 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> > From: Dan Williams <dan.j.williams@intel.com>
> > 
> > With dport addition moving out of cxl_switch_port_probe() it is no longer
> > the case that a single dport-add failure will cause all dport resources
> > to be automatically unwound.
> > 
> > devm still helps all dport resources get cleaned up when the port is
> > detached, but setup now needs to avoid leaking resources if an early exit
> > occurs during setup.
> > 
> > Convert from a "devm add" model, to an "auto remove" model that makes the
> > caller responsible for registering devm reclaim after the object is fully
> > instantiated.
> > 
> > As a side of effect of this reorganization port->nr_dports is now always
> > consistent with the number of entries in the port->dports xarray, and this
> > can stop playing games with ida_is_empty() which is unreliable as a
> > detector of whether decoders are setup. I.e. consider how
> > CONFIG_DEBUG_KOBJECT_RELEASE might wreak havoc with this approach.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Terry Bowman <terry.bowman@amd.com>
> > 
> > ---
> > 
> > Changes in v13 -> v14:
> > - New patch
> Hi Dan, Terry,
> 
> I think this needs a little reorganization to ensure we don't have
> dport and dport_add both being the same pointer for different free
> reasons.  Adding a helper and we can combine them with a clear
> hand over of ownership.
> 
> Wrapping devres_remove_group() in a function that is called close_group()
> rings alarm bells.
> 
> Jonathan
[..]
> 
> > @@ -1176,48 +1175,27 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
> >  			&component_reg_phys);
> >  
> >  	cond_cxl_root_lock(port);
> > -	rc = add_dport(port, dport);
> > +	struct cxl_dport *dport_add __free(remove_dport) =
> > +		add_dport(port, dport);
> 
> This pattern of having both dport and dport_add effectively
> pointing to the same pointer concerns me from a readability / maintainability
> point of view. We've often made use of helper functions to avoid doing
> this and I think that would make sense here as well.

Yeah, while I do think the multi-variable pattern is useful for
many-step object construction, I can usually easily be persuaded to
consider a helper function.

> Take everything down to and including dport_add() as a helper called
> something like (naming needs work!)
> 	struct dport_dev *dport __free(remove_and_free_dport) =
> 		add_dport_wrapper();

I ended up with the patch below which is similar in spirit to this
without a new DEFINE_FREE().


> 
> >  	cond_cxl_root_unlock(port);
> > -	if (rc)
> > -		return ERR_PTR(rc);
> > -
> > -	/*
> > -	 * Setup port register if this is the first dport showed up. Having
> > -	 * a dport also means that there is at least 1 active link.
> > -	 */
> > -	if (port->nr_dports == 1 &&
> > -	    port->component_reg_phys != CXL_RESOURCE_NONE) {
> > -		rc = cxl_port_setup_regs(port, port->component_reg_phys);
> > -		if (rc) {
> > -			xa_erase(&port->dports, (unsigned long)dport->dport_dev);
> > -			return ERR_PTR(rc);
> > -		}
> > -		port->component_reg_phys = CXL_RESOURCE_NONE;
> > -	}
> > +	if (IS_ERR(dport_add))
> > +		return dport_add;
> >  
> > -	get_device(dport_dev);
> > -	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
> > -	if (rc)
> > -		return ERR_PTR(rc);
> > +	if (dev_is_pci(dport_dev))
> > +		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
> >  
> >  	rc = sysfs_create_link(&port->dev.kobj, &dport_dev->kobj, link_name);
> >  	if (rc)
> >  		return ERR_PTR(rc);
> >  
> > -	rc = devm_add_action_or_reset(host, cxl_dport_unlink, dport);
> > -	if (rc)
> > -		return ERR_PTR(rc);
> > -
> > -	if (dev_is_pci(dport_dev))
> > -		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
> > -
> >  	cxl_debugfs_create_dport_dir(dport);
> >  
> > -	return dport;
> > +	retain_and_null_ptr(dport_add);
> > +	return no_free_ptr(dport);
> >  }
> 
> 
> 
> > +
> > +/*
> > + * Note: this only services dynamic removal of mid-level ports, root ports are
> > + * always removed by the platform driver (e.g. cxl_acpi). @host can be
> > + * hard-coded to &port->dev.
> > + */
> >  static void del_dport(struct cxl_dport *dport)
> >  {
> >  	struct cxl_port *port = dport->port;
> >  
> > -	devm_release_action(&port->dev, cxl_dport_unlink, dport);
> > -	devm_release_action(&port->dev, cxl_dport_remove, dport);
> > -	devm_kfree(&port->dev, dport);
> > +	devm_release_action(&port->dev, unlink_dport, dport);
> >  }
> >  
> >  static void del_dports(struct cxl_port *port)
> > @@ -1597,10 +1603,24 @@ static int update_decoder_targets(struct device *dev, void *data)
> >  	return 0;
> >  }
> >  
> > -DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
> > +static struct cxl_port *cxl_port_devres_group(struct cxl_port *port)
> > +{
> > +	if (!devres_open_group(&port->dev, port, GFP_KERNEL))
> > +		return ERR_PTR(-ENOMEM);
> > +	return port;
> > +}
> > +DEFINE_FREE(cxl_port_group_free, struct cxl_port *,
> > +	if (!IS_ERR_OR_NULL(_T)) devres_release_group(&(_T)->dev, _T))
> > +
> > +static void cxl_port_group_close(struct cxl_port *port)
> 
> This feels like misleading naming and I'm not sure what intent is. 
> Would have expected it to call devres_close_group()

Agree. The hastiness of this patch shows. Switched all the naming to not
be surprising. The flow is:

cxl_port_open_group(): start recording devres resource acquisition
cxl_port_remove_group(): on success, stop tracking the group, leave the resources
cxl_port_release_group(): on failure, destroy the group, free the resources

New patch, added a Fixes: tag.

-- 8< --
From 9731bb6cb5638a0d2141dc072f90db0d00400680 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 14 Jan 2026 12:20:40 -0600
Subject: [PATCH] cxl/port: Fix devm resource leaks with dport management

With dport addition moving out of cxl_switch_port_probe() it is no longer
the case that a single dport-add failure will cause all dport resources
to be automatically unwound.

devm still helps all dport resources get cleaned up when the port is
detached, but setup now needs to avoid leaking resources if an early exit
occurs during setup.

Convert from a "devm add" model, to an "auto remove" model that makes the
caller responsible for registering devm reclaim after the object is fully
instantiated.

As a side of effect of this reorganization port->nr_dports is now always
consistent with the number of entries in the port->dports xarray, and this
can stop playing games with ida_is_empty() which is unreliable as a
detector of whether decoders are setup. I.e. consider how
CONFIG_DEBUG_KOBJECT_RELEASE might wreak havoc with this approach.

Cc: <stable@vger.kernel.org>
Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h                    |  23 +--
 tools/testing/cxl/exports.h          |   4 +-
 tools/testing/cxl/test/mock.h        |   4 +-
 drivers/cxl/acpi.c                   |  11 +-
 drivers/cxl/core/pci.c               |  10 +-
 drivers/cxl/core/port.c              | 252 ++++++++++++++++-----------
 drivers/cxl/port.c                   |   8 +-
 tools/testing/cxl/cxl_core_exports.c |  13 +-
 tools/testing/cxl/test/cxl.c         |   6 +-
 tools/testing/cxl/test/mock.c        |  25 ++-
 tools/testing/cxl/Kbuild             |   3 +-
 11 files changed, 209 insertions(+), 150 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6f3741a57932..47ee06c95433 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -796,12 +796,12 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 				   struct cxl_dport **dport);
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
 
-struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
-				     struct device *dport, int port_id,
-				     resource_size_t component_reg_phys);
-struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
-					 struct device *dport_dev, int port_id,
-					 resource_size_t rcrb);
+struct cxl_dport *cxl_add_dport(struct cxl_port *port, struct device *dport,
+				int port_id,
+				resource_size_t component_reg_phys);
+struct cxl_dport *cxl_add_rch_dport(struct cxl_port *port,
+				    struct device *dport_dev, int port_id,
+				    resource_size_t rcrb);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
@@ -824,6 +824,7 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
 	return cxl_decoder_autoremove(host, &cxlrd->cxlsd.cxld);
 }
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
+int cxl_dport_autoremove(struct cxl_dport *dport);
 
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
@@ -937,10 +938,10 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c2);
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
-struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
-					    struct device *dport_dev);
-struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
-					      struct device *dport_dev);
+struct cxl_dport *cxl_add_dport_by_dev(struct cxl_port *port,
+				       struct device *dport_dev);
+struct cxl_dport *__cxl_add_dport_by_dev(struct cxl_port *port,
+					 struct device *dport_dev);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
@@ -964,7 +965,7 @@ u16 cxl_gpf_get_dvsec(struct device *dev);
  */
 #ifndef CXL_TEST_ENABLE
 #define DECLARE_TESTABLE(x) __##x
-#define devm_cxl_add_dport_by_dev DECLARE_TESTABLE(devm_cxl_add_dport_by_dev)
+#define cxl_add_dport_by_dev DECLARE_TESTABLE(cxl_add_dport_by_dev)
 #define devm_cxl_switch_port_decoders_setup DECLARE_TESTABLE(devm_cxl_switch_port_decoders_setup)
 #endif
 
diff --git a/tools/testing/cxl/exports.h b/tools/testing/cxl/exports.h
index 7ebee7c0bd67..cbb16073be18 100644
--- a/tools/testing/cxl/exports.h
+++ b/tools/testing/cxl/exports.h
@@ -4,8 +4,8 @@
 #define __MOCK_CXL_EXPORTS_H_
 
 typedef struct cxl_dport *(*cxl_add_dport_by_dev_fn)(struct cxl_port *port,
-							  struct device *dport_dev);
-extern cxl_add_dport_by_dev_fn _devm_cxl_add_dport_by_dev;
+						     struct device *dport_dev);
+extern cxl_add_dport_by_dev_fn _cxl_add_dport_by_dev;
 
 typedef int(*cxl_switch_decoders_setup_fn)(struct cxl_port *port);
 extern cxl_switch_decoders_setup_fn _devm_cxl_switch_port_decoders_setup;
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index 2684b89c8aa2..fa13aca4e260 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -22,8 +22,8 @@ struct cxl_mock_ops {
 	int (*devm_cxl_switch_port_decoders_setup)(struct cxl_port *port);
 	int (*devm_cxl_endpoint_decoders_setup)(struct cxl_port *port);
 	void (*cxl_endpoint_parse_cdat)(struct cxl_port *port);
-	struct cxl_dport *(*devm_cxl_add_dport_by_dev)(struct cxl_port *port,
-						       struct device *dport_dev);
+	struct cxl_dport *(*cxl_add_dport_by_dev)(struct cxl_port *port,
+						  struct device *dport_dev);
 	int (*hmat_get_extended_linear_cache_size)(struct resource *backing_res,
 						   int nid,
 						   resource_size_t *cache_size);
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 77ac940e3013..1e1383eb9bd5 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -679,16 +679,19 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
 		dev_dbg(match, "RCRB found for UID %lld: %pa\n", ctx.uid,
 			&ctx.base);
-		dport = devm_cxl_add_rch_dport(root_port, bridge, ctx.uid,
-					       ctx.base);
+		dport = cxl_add_rch_dport(root_port, bridge, ctx.uid, ctx.base);
 	} else {
-		dport = devm_cxl_add_dport(root_port, bridge, ctx.uid,
-					   CXL_RESOURCE_NONE);
+		dport = cxl_add_dport(root_port, bridge, ctx.uid,
+				      CXL_RESOURCE_NONE);
 	}
 
 	if (IS_ERR(dport))
 		return PTR_ERR(dport);
 
+	ret = cxl_dport_autoremove(dport);
+	if (ret)
+		return ret;
+
 	ret = get_genport_coordinates(match, dport);
 	if (ret)
 		dev_dbg(match, "Failed to get generic port perf coordinates.\n");
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index b838c59d7a3c..ce117812e5c8 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -41,14 +41,14 @@ static int pci_get_port_num(struct pci_dev *pdev)
 }
 
 /**
- * __devm_cxl_add_dport_by_dev - allocate a dport by dport device
+ * __cxl_add_dport_by_dev - allocate a dport by dport device
  * @port: cxl_port that hosts the dport
  * @dport_dev: 'struct device' of the dport
  *
  * Returns the allocated dport on success or ERR_PTR() of -errno on error
  */
-struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
-					      struct device *dport_dev)
+struct cxl_dport *__cxl_add_dport_by_dev(struct cxl_port *port,
+					 struct device *dport_dev)
 {
 	struct cxl_register_map map;
 	struct pci_dev *pdev;
@@ -67,9 +67,9 @@ struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
 		return ERR_PTR(rc);
 
 	device_lock_assert(&port->dev);
-	return devm_cxl_add_dport(port, dport_dev, port_num, map.resource);
+	return cxl_add_dport(port, dport_dev, port_num, map.resource);
 }
-EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_dport_by_dev, "CXL");
+EXPORT_SYMBOL_NS_GPL(__cxl_add_dport_by_dev, "CXL");
 
 static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
 {
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fef3aa0c6680..41b65babd057 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1066,11 +1066,28 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
 		return -EBUSY;
 	}
 
+	/*
+	 * Unlike CXL switch upstream ports where it can train a CXL link
+	 * independent of its downstream ports, a host bridge upstream port may
+	 * not enable CXL registers until at least one downstream port (root
+	 * port) trains CXL. Enumerate registers once when the number of dports
+	 * transitions from zero to one.
+	 */
+	if (!port->nr_dports) {
+		rc = cxl_port_setup_regs(port, port->component_reg_phys);
+		if (rc)
+			return rc;
+	}
+
+	/* Arrange for dport_dev to be valid through remove_dport() */
+	struct device *dev __free(put_device) = get_device(dport->dport_dev);
+
 	rc = xa_insert(&port->dports, (unsigned long)dport->dport_dev, dport,
 		       GFP_KERNEL);
 	if (rc)
 		return rc;
 
+	retain_and_null_ptr(dev);
 	port->nr_dports++;
 	return 0;
 }
@@ -1094,51 +1111,64 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
 		device_unlock(&port->dev);
 }
 
-static void cxl_dport_remove(void *data)
+static void remove_dport(struct cxl_dport *dport)
 {
-	struct cxl_dport *dport = data;
 	struct cxl_port *port = dport->port;
 
+	port->nr_dports--;
 	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
 	put_device(dport->dport_dev);
 }
 
-static void cxl_dport_unlink(void *data)
+static struct cxl_dport *__register_dport(struct cxl_dport *dport)
 {
-	struct cxl_dport *dport = data;
-	struct cxl_port *port = dport->port;
+	int rc;
 	char link_name[CXL_TARGET_STRLEN];
+	struct cxl_port *port = dport->port;
+	struct device *dport_dev = dport->dport_dev;
 
-	sprintf(link_name, "dport%d", dport->port_id);
-	sysfs_remove_link(&port->dev.kobj, link_name);
-}
+	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", dport->port_id) >=
+	    CXL_TARGET_STRLEN)
+		return ERR_PTR(-EINVAL);
 
-static struct cxl_dport *
-__devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
-		     int port_id, resource_size_t component_reg_phys,
-		     resource_size_t rcrb)
-{
-	char link_name[CXL_TARGET_STRLEN];
-	struct cxl_dport *dport;
-	struct device *host;
-	int rc;
+	cond_cxl_root_lock(port);
+	rc = add_dport(port, dport);
+	cond_cxl_root_unlock(port);
+	if (rc)
+		return ERR_PTR(rc);
 
-	if (is_cxl_root(port))
-		host = port->uport_dev;
-	else
-		host = &port->dev;
+	if (dev_is_pci(dport_dev))
+		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
 
-	if (!host->driver) {
-		dev_WARN_ONCE(&port->dev, 1, "dport:%s bad devm context\n",
-			      dev_name(dport_dev));
-		return ERR_PTR(-ENXIO);
+	rc = sysfs_create_link(&port->dev.kobj, &dport_dev->kobj, link_name);
+	if (rc) {
+		remove_dport(dport);
+		return ERR_PTR(rc);
 	}
 
-	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
-	    CXL_TARGET_STRLEN)
-		return ERR_PTR(-EINVAL);
+	cxl_debugfs_create_dport_dir(dport);
 
-	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
+	return dport;
+}
+
+static struct cxl_dport *register_or_free_dport(struct cxl_dport *dport)
+{
+	struct cxl_dport *result = __register_dport(dport);
+
+	if (IS_ERR(result))
+		kfree(dport);
+	return result;
+}
+
+static struct cxl_dport *__cxl_add_dport(struct cxl_port *port,
+					 struct device *dport_dev, int port_id,
+					 resource_size_t component_reg_phys,
+					 resource_size_t rcrb)
+{
+	int rc;
+
+	struct cxl_dport *dport __free(kfree) =
+		kzalloc(sizeof(*dport), GFP_KERNEL);
 	if (!dport)
 		return ERR_PTR(-ENOMEM);
 
@@ -1175,49 +1205,11 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
 			&component_reg_phys);
 
-	cond_cxl_root_lock(port);
-	rc = add_dport(port, dport);
-	cond_cxl_root_unlock(port);
-	if (rc)
-		return ERR_PTR(rc);
-
-	/*
-	 * Setup port register if this is the first dport showed up. Having
-	 * a dport also means that there is at least 1 active link.
-	 */
-	if (port->nr_dports == 1 &&
-	    port->component_reg_phys != CXL_RESOURCE_NONE) {
-		rc = cxl_port_setup_regs(port, port->component_reg_phys);
-		if (rc) {
-			xa_erase(&port->dports, (unsigned long)dport->dport_dev);
-			return ERR_PTR(rc);
-		}
-		port->component_reg_phys = CXL_RESOURCE_NONE;
-	}
-
-	get_device(dport_dev);
-	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
-	if (rc)
-		return ERR_PTR(rc);
-
-	rc = sysfs_create_link(&port->dev.kobj, &dport_dev->kobj, link_name);
-	if (rc)
-		return ERR_PTR(rc);
-
-	rc = devm_add_action_or_reset(host, cxl_dport_unlink, dport);
-	if (rc)
-		return ERR_PTR(rc);
-
-	if (dev_is_pci(dport_dev))
-		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
-
-	cxl_debugfs_create_dport_dir(dport);
-
-	return dport;
+	return register_or_free_dport(no_free_ptr(dport));
 }
 
 /**
- * devm_cxl_add_dport - append VH downstream port data to a cxl_port
+ * cxl_add_dport - append VH downstream port data to a cxl_port
  * @port: the cxl_port that references this dport
  * @dport_dev: firmware or PCI device representing the dport
  * @port_id: identifier for this dport in a decoder's target list
@@ -1227,14 +1219,13 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
  * either the port's host (for root ports), or the port itself (for
  * switch ports)
  */
-struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
-				     struct device *dport_dev, int port_id,
-				     resource_size_t component_reg_phys)
+struct cxl_dport *cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
+				int port_id, resource_size_t component_reg_phys)
 {
 	struct cxl_dport *dport;
 
-	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
-				     component_reg_phys, CXL_RESOURCE_NONE);
+	dport = __cxl_add_dport(port, dport_dev, port_id, component_reg_phys,
+				CXL_RESOURCE_NONE);
 	if (IS_ERR(dport)) {
 		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
 			dev_name(&port->dev), PTR_ERR(dport));
@@ -1245,10 +1236,10 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 
 	return dport;
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_add_dport, "CXL");
 
 /**
- * devm_cxl_add_rch_dport - append RCH downstream port data to a cxl_port
+ * cxl_add_rch_dport - append RCH downstream port data to a cxl_port
  * @port: the cxl_port that references this dport
  * @dport_dev: firmware or PCI device representing the dport
  * @port_id: identifier for this dport in a decoder's target list
@@ -1256,9 +1247,9 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, "CXL");
  *
  * See CXL 3.0 9.11.8 CXL Devices Attached to an RCH
  */
-struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
-					 struct device *dport_dev, int port_id,
-					 resource_size_t rcrb)
+struct cxl_dport *cxl_add_rch_dport(struct cxl_port *port,
+				    struct device *dport_dev, int port_id,
+				    resource_size_t rcrb)
 {
 	struct cxl_dport *dport;
 
@@ -1267,8 +1258,8 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 		return ERR_PTR(-EINVAL);
 	}
 
-	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
-				     CXL_RESOURCE_NONE, rcrb);
+	dport = __cxl_add_dport(port, dport_dev, port_id, CXL_RESOURCE_NONE,
+				rcrb);
 	if (IS_ERR(dport)) {
 		dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
 			dev_name(&port->dev), PTR_ERR(dport));
@@ -1279,7 +1270,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 
 	return dport;
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_add_rch_dport, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_add_rch_dport, "CXL");
 
 static int add_ep(struct cxl_ep *new)
 {
@@ -1439,13 +1430,42 @@ static void delete_switch_port(struct cxl_port *port)
 	devm_release_action(port->dev.parent, unregister_port, port);
 }
 
+static void unlink_dport(void *data)
+{
+	struct cxl_dport *dport = data;
+	struct cxl_port *port = dport->port;
+	char link_name[CXL_TARGET_STRLEN];
+
+	sprintf(link_name, "dport%d", dport->port_id);
+	sysfs_remove_link(&port->dev.kobj, link_name);
+	remove_dport(dport);
+	kfree(dport);
+}
+
+int cxl_dport_autoremove(struct cxl_dport *dport)
+{
+	struct cxl_port *port = dport->port;
+	struct device *host;
+
+	if (is_cxl_root(port))
+		host = port->uport_dev;
+	else
+		host = &port->dev;
+
+	return devm_add_action_or_reset(host, unlink_dport, dport);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dport_autoremove, "CXL");
+
+/*
+ * Note: this only services dynamic removal of mid-level ports, root ports are
+ * always removed by the platform driver (e.g. cxl_acpi). @host can be
+ * hard-coded to &port->dev.
+ */
 static void del_dport(struct cxl_dport *dport)
 {
 	struct cxl_port *port = dport->port;
 
-	devm_release_action(&port->dev, cxl_dport_unlink, dport);
-	devm_release_action(&port->dev, cxl_dport_remove, dport);
-	devm_kfree(&port->dev, dport);
+	devm_release_action(&port->dev, unlink_dport, dport);
 }
 
 static void del_dports(struct cxl_port *port)
@@ -1597,10 +1617,24 @@ static int update_decoder_targets(struct device *dev, void *data)
 	return 0;
 }
 
-DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
+static struct cxl_port *cxl_port_open_group(struct cxl_port *port)
+{
+	if (!devres_open_group(&port->dev, port, GFP_KERNEL))
+		return ERR_PTR(-ENOMEM);
+	return port;
+}
+DEFINE_FREE(cxl_port_release_group, struct cxl_port *,
+	if (!IS_ERR_OR_NULL(_T)) devres_release_group(&(_T)->dev, _T))
+
+static void cxl_port_remove_group(struct cxl_port *port)
+{
+	devres_remove_group(&port->dev, port);
+}
+
 static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 					    struct device *dport_dev)
 {
+	struct cxl_dport *new_dport;
 	struct cxl_dport *dport;
 	int rc;
 
@@ -1615,29 +1649,47 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 		return ERR_PTR(-EBUSY);
 	}
 
-	struct cxl_dport *new_dport __free(del_cxl_dport) =
-		devm_cxl_add_dport_by_dev(port, dport_dev);
-	if (IS_ERR(new_dport))
-		return new_dport;
-
-	cxl_switch_parse_cdat(new_dport);
+	/*
+	 * With the first dport arrival it is now safe to start looking at
+	 * component registers. Be careful to not strand resources if dport
+	 * creation ultimately fails.
+	 */
+	struct cxl_port *port_group __free(cxl_port_release_group) =
+		cxl_port_open_group(port);
+	if (IS_ERR(port_group))
+		return ERR_CAST(port_group);
 
-	if (ida_is_empty(&port->decoder_ida)) {
+	if (port->nr_dports == 0) {
 		rc = devm_cxl_switch_port_decoders_setup(port);
 		if (rc)
 			return ERR_PTR(rc);
-		dev_dbg(&port->dev, "first dport%d:%s added with decoders\n",
-			new_dport->port_id, dev_name(dport_dev));
-		return no_free_ptr(new_dport);
+		/*
+		 * Note, when nr_dports returns to zero the port is unregistered
+		 * and triggers cleanup. I.e. no need for open-coded release
+		 * action on dport removal. See cxl_detach_ep() for that logic.
+		 */
 	}
 
+	new_dport = cxl_add_dport_by_dev(port, dport_dev);
+	if (IS_ERR(new_dport))
+		return new_dport;
+
+	rc = cxl_dport_autoremove(new_dport);
+	if (rc)
+		return ERR_PTR(rc);
+
+	cxl_switch_parse_cdat(new_dport);
+
+	/* group tracking no longer needed, dport successfully added */
+	cxl_port_remove_group(no_free_ptr(port_group));
+
+	dev_dbg(&port->dev, "dport[%d] id:%d dport_dev: %s added\n",
+		port->nr_dports - 1, new_dport->port_id, dev_name(dport_dev));
+
 	/* New dport added, update the decoder targets */
 	device_for_each_child(&port->dev, new_dport, update_decoder_targets);
 
-	dev_dbg(&port->dev, "dport%d:%s added\n", new_dport->port_id,
-		dev_name(dport_dev));
-
-	return no_free_ptr(new_dport);
+	return new_dport;
 }
 
 static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 51c8f2f84717..167cc0a87484 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -59,8 +59,12 @@ static int discover_region(struct device *dev, void *unused)
 
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
-	/* Reset nr_dports for rebind of driver */
-	port->nr_dports = 0;
+	/*
+	 * Unfortunately, typical driver operations like "find and map
+	 * registers", can not be done at port device attach time and must wait
+	 * for dport arrival. See cxl_port_add_dport() and the comments in
+	 * add_dport() for details.
+	 */
 
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
index 6754de35598d..02d479867a12 100644
--- a/tools/testing/cxl/cxl_core_exports.c
+++ b/tools/testing/cxl/cxl_core_exports.c
@@ -7,16 +7,15 @@
 /* Exporting of cxl_core symbols that are only used by cxl_test */
 EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, "CXL");
 
-cxl_add_dport_by_dev_fn _devm_cxl_add_dport_by_dev =
-	__devm_cxl_add_dport_by_dev;
-EXPORT_SYMBOL_NS_GPL(_devm_cxl_add_dport_by_dev, "CXL");
+cxl_add_dport_by_dev_fn _cxl_add_dport_by_dev = __cxl_add_dport_by_dev;
+EXPORT_SYMBOL_NS_GPL(_cxl_add_dport_by_dev, "CXL");
 
-struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
-					    struct device *dport_dev)
+struct cxl_dport *cxl_add_dport_by_dev(struct cxl_port *port,
+				       struct device *dport_dev)
 {
-	return _devm_cxl_add_dport_by_dev(port, dport_dev);
+	return _cxl_add_dport_by_dev(port, dport_dev);
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport_by_dev, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_add_dport_by_dev, "CXL");
 
 cxl_switch_decoders_setup_fn _devm_cxl_switch_port_decoders_setup =
 	__devm_cxl_switch_port_decoders_setup;
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 81e2aef3627a..b7a2b550c0b0 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1060,8 +1060,8 @@ static struct cxl_dport *mock_cxl_add_dport_by_dev(struct cxl_port *port,
 		if (&pdev->dev != dport_dev)
 			continue;
 
-		return devm_cxl_add_dport(port, &pdev->dev, pdev->id,
-					  CXL_RESOURCE_NONE);
+		return cxl_add_dport(port, &pdev->dev, pdev->id,
+				     CXL_RESOURCE_NONE);
 	}
 
 	return ERR_PTR(-ENODEV);
@@ -1126,9 +1126,9 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.devm_cxl_switch_port_decoders_setup = mock_cxl_switch_port_decoders_setup,
 	.devm_cxl_endpoint_decoders_setup = mock_cxl_endpoint_decoders_setup,
 	.cxl_endpoint_parse_cdat = mock_cxl_endpoint_parse_cdat,
-	.devm_cxl_add_dport_by_dev = mock_cxl_add_dport_by_dev,
 	.hmat_get_extended_linear_cache_size =
 		mock_hmat_get_extended_linear_cache_size,
+	.cxl_add_dport_by_dev = mock_cxl_add_dport_by_dev,
 	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
 };
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 44bce80ef3ff..660e8402189c 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -15,14 +15,13 @@
 static LIST_HEAD(mock);
 
 static struct cxl_dport *
-redirect_devm_cxl_add_dport_by_dev(struct cxl_port *port,
-				   struct device *dport_dev);
+redirect_cxl_add_dport_by_dev(struct cxl_port *port, struct device *dport_dev);
 static int redirect_devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
 
 void register_cxl_mock_ops(struct cxl_mock_ops *ops)
 {
 	list_add_rcu(&ops->list, &mock);
-	_devm_cxl_add_dport_by_dev = redirect_devm_cxl_add_dport_by_dev;
+	_cxl_add_dport_by_dev = redirect_cxl_add_dport_by_dev;
 	_devm_cxl_switch_port_decoders_setup =
 		redirect_devm_cxl_switch_port_decoders_setup;
 }
@@ -34,7 +33,7 @@ void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
 {
 	_devm_cxl_switch_port_decoders_setup =
 		__devm_cxl_switch_port_decoders_setup;
-	_devm_cxl_add_dport_by_dev = __devm_cxl_add_dport_by_dev;
+	_cxl_add_dport_by_dev = __cxl_add_dport_by_dev;
 	list_del_rcu(&ops->list);
 	synchronize_srcu(&cxl_mock_srcu);
 }
@@ -207,7 +206,7 @@ int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_await_media_ready, "CXL");
 
-struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
+struct cxl_dport *__wrap_cxl_add_rch_dport(struct cxl_port *port,
 						struct device *dport_dev,
 						int port_id,
 						resource_size_t rcrb)
@@ -217,19 +216,19 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (ops && ops->is_mock_port(dport_dev)) {
-		dport = devm_cxl_add_dport(port, dport_dev, port_id,
-					   CXL_RESOURCE_NONE);
+		dport = cxl_add_dport(port, dport_dev, port_id,
+				      CXL_RESOURCE_NONE);
 		if (!IS_ERR(dport)) {
 			dport->rcrb.base = rcrb;
 			dport->rch = true;
 		}
 	} else
-		dport = devm_cxl_add_rch_dport(port, dport_dev, port_id, rcrb);
+		dport = cxl_add_rch_dport(port, dport_dev, port_id, rcrb);
 	put_cxl_mock_ops(index);
 
 	return dport;
 }
-EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_add_rch_dport, "CXL");
 
 void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 {
@@ -257,17 +256,17 @@ void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dport_init_ras_reporting, "CXL");
 
-struct cxl_dport *redirect_devm_cxl_add_dport_by_dev(struct cxl_port *port,
-						     struct device *dport_dev)
+struct cxl_dport *redirect_cxl_add_dport_by_dev(struct cxl_port *port,
+						struct device *dport_dev)
 {
 	int index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 	struct cxl_dport *dport;
 
 	if (ops && ops->is_mock_port(port->uport_dev))
-		dport = ops->devm_cxl_add_dport_by_dev(port, dport_dev);
+		dport = ops->cxl_add_dport_by_dev(port, dport_dev);
 	else
-		dport = __devm_cxl_add_dport_by_dev(port, dport_dev);
+		dport = __cxl_add_dport_by_dev(port, dport_dev);
 	put_cxl_mock_ops(index);
 
 	return dport;
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 6eceefefb0e0..4d740392aac5 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -5,7 +5,8 @@ ldflags-y += --wrap=acpi_evaluate_integer
 ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=cxl_await_media_ready
-ldflags-y += --wrap=devm_cxl_add_rch_dport
+ldflags-y += --wrap=cxl_add_rch_dport
+ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
 ldflags-y += --wrap=cxl_dport_init_ras_reporting
 ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
-- 
2.52.0

