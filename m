Return-Path: <linux-pci+bounces-18712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FC29F69F2
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 16:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689EE165D5B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 15:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC96B5FEE6;
	Wed, 18 Dec 2024 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bm3j7QYD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9EB481B3;
	Wed, 18 Dec 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535486; cv=fail; b=KKnGy4v2gnNurtUv9tv4WngrjdlYUDu7CtNwsmWD7AltvPx7dWL/TiOhIGzD3Ybwc1aPDz/PXU/E3JbCeCuODoTbrg7CJy8uElakFjBVtlggsq0snVb3xY5JL0xFt9fA9rgV36ncev7wByi5FcR+oCoeBjppxu4m2GFsXKi2wto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535486; c=relaxed/simple;
	bh=m7ntCBC00RUmqzVGd8EmD/xMvbfJfL/z3jnTgU55mx0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TnAxKtFVzFSlqrc2ipyiHW6MsBDKNCdYs/YbmpSX9AAA7/8Yu0JLcMTp1Z0XxFwBGViasFjSxERsW8YouvDLqObRYfhiLM8X5Cw/snK1tRBJcYtSmeI5dotih8TmhCUQdO6EkQZ8Xd8kM4fNeTXo5c6K2y5p320dygDwOMUvF0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bm3j7QYD; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734535485; x=1766071485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m7ntCBC00RUmqzVGd8EmD/xMvbfJfL/z3jnTgU55mx0=;
  b=Bm3j7QYDQIrbjMMecSWDR+icZnD7Uh5R872Z1TVNwnhF6T2OmNexgPRA
   oqT5kAYIekLzlWZ71be0mVqNWbxuukcKj651qIQRS0LGzwdPY6PQLRsGV
   ByR+J6T+2bzbg6LwUw3FFPfPOYpvJ9JzUjIFWYHvtm/zLTYlUrKUNRlRF
   zhzqO3hHMQqZSmct3X+BS69u9SqMjAhnvQxNC+pdUi1CVjNuatLDTfMPZ
   faoWZ+2jL+bj1q+wefKkRqQrWJv+oNnyANWPwDzSu1Ga4hpvaj7cfXvHt
   0FusbSS9oQUAQqb0cFwGpEIbEpMix/MMWBWYfz4DPRU+TQ12h1YbgRK4T
   g==;
X-CSE-ConnectionGUID: +jNpyHQ9RiO9pRwOQkUFBg==
X-CSE-MsgGUID: A4K2JG8hQOaPxqgbSzlp1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35231697"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="35231697"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:24:42 -0800
X-CSE-ConnectionGUID: 1ELn4dnbSsOnROSY2j3+bQ==
X-CSE-MsgGUID: L8rVVWylRmC6r4wryhyJaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102498387"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 07:24:36 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 07:24:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 07:24:31 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 07:24:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zH3LO4UazTQV5/UFYvLziATyW4PzVTdDQVbeIl3M/79MtCay2KcYC8MS0uyZ5Eym7jmEPt03vF8487PGyYWaojkDDCRHYv7/HEPb1dhFlvMkMYJKWcsBES0HcKwrEabeSDF8qvu/csCzdVLCS5t9IrtjYroLQMVrJxW7HGuQSzY45y2ry/ZrXL2sYh2D4PnIzvdWJ31RoDCgC4GBCvp+tsHLE+74hdnUYZLUwIQCpxUkWv04iwy0TqdnEdSDOnS5A1Ay633RuhB0BRlXJwPm2h+jtdJRT4PAeGRt0huEsaYbNgA+21gtmYJLIeWu93gSNsaVI0yYZdTljOKygsv6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBHLJqrzejd+R9BlCJGrB7+wPwYoOn90ZJXoGh4C6BI=;
 b=ZoZ2QqRi8jxFR+9s8ciuJrekf/wmY7JP7+/j26DXdKI+YB8bajS7eo2HMmG/Q3bTwcxzT7gpw4jx//74qyUN+M5c/FOd8FfarYK94eyFxH6l+2ZBlB327hr+//sq6a0reEfvTGScrxCd6BN4Y4QIVZlPTiehNN54mytjyDahsUXJZNF4c0o7BTsjwLqg23EXMUFMdd3MtBpauByhrA++6S3Vj32hKnmJieEr/ijift1JPbQvipdNX2MVjDRrrrBGtGTn9BDg6q3XBivP1wHSYuFVGQ8yid+l3vQD8Kw4DBFx84NtrmJxlHtzwhSwzZRCiWAIk0NomIKpCBAigrQQUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:23:53 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 15:23:51 +0000
Message-ID: <9889f570-a2a0-4a71-b140-41278f1e8639@intel.com>
Date: Wed, 18 Dec 2024 16:23:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3] e1000e: Fix real-time violations on link up
To: Gerhard Engleder <gerhard@engleder-embedded.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <bhelgaas@google.com>, <pmenzel@molgen.mpg.de>, "Gerhard
 Engleder" <eg@keba.com>, Vitaly Lifshits <vitaly.lifshits@intel.com>
References: <20241214191623.7256-1-gerhard@engleder-embedded.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241214191623.7256-1-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0042.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd4524e-5a30-454c-0eec-08dd1f77f9ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmluaXl6UzdibTZBOElNNmxrU2QrMHNPQWtxZEpFTTQ1eU1qVk5YeUpWYVJx?=
 =?utf-8?B?NUVENXlyUFBNTGIxMGRWMFQyTEt5ZDhxZ1BNLysrTUtUOWxPbkE0VG1CeURT?=
 =?utf-8?B?Z2huaFROd0RYSkNzLzJsNjc1RVRGOVZ3dzRyRWlTaWo5Nll5dXNEZFhvWG4w?=
 =?utf-8?B?VWpWSGRHQTgzZ1Nwb3NuQkhZTmJ5WktodTZMTk5BQlNSa20rSjRqYUpKOTdy?=
 =?utf-8?B?ZHUwME5JRk00SlFoZ3FCa0V4SkQ3L2h1eXZDMHRKWGJyZmpnRm5pVlRablQy?=
 =?utf-8?B?bWpTbXo1aEFZZGFMcTV1UU50SzNPck9teGs5M3BwKzlFK3NnSjRRRGxlWms4?=
 =?utf-8?B?N1lMTmZCR2oxQkpycjMzZEJMYWJDQk9lVitjU3pYY2ovRjFFR1lnV0FBWkVa?=
 =?utf-8?B?dnc1dGRFcm91aHBuUGpyRWtSLzcvODI3R0R4WTgwY0NtN1RaRzI0R3FidHY2?=
 =?utf-8?B?VU5JODNubmlWeE4xZzU1ZXlRVkNYVWRYanozMzN4RmVYM0poZkJzM3lLMEF2?=
 =?utf-8?B?WDhXRnFOWEY1RVFwYnllaCtGQ1Jsd3NhV2VwSmtwOU1wQkhUL2JYZThHVW5T?=
 =?utf-8?B?eWtyWFZucTZNVVFkM0RKdGhBMkpQZDgySWgrQzdSLy9Pck1VTEVIeVRyRkhZ?=
 =?utf-8?B?QkVpU0tCdGM1dVcveVNrdXdVa20rS2tUZGdUQllTa1JKSUVRV2FyMm9MbDhy?=
 =?utf-8?B?VjJoRG5jV3J4N1pqdXNtNTMrS0lWdml2d09sMDFaYTc1NGdYTTQvUjlub3o1?=
 =?utf-8?B?Sk5Ob2xNSS9ESXpneDJvdVd5SGlvRm1KWFl1OGtOOXNremNLMHd2dm1laWdp?=
 =?utf-8?B?ODBNK2FYaXBSalJ1bVBJUEZycy9wNnBmbW1iUEdoRWxjRFVheGhXVXp2NDV1?=
 =?utf-8?B?akJHQkg1UzNqaEJSUk92dVVsK2liTzc1eEdXcXZmM2xVc3UzTlpMSjF1MERw?=
 =?utf-8?B?UlIxNW1YQzJQTnJuTkNTbUJtQnVqWTlBUVczZHVrcVFYT283WmF3Q2U0TEh4?=
 =?utf-8?B?bWI0YTM1SU1mUTU1eVBvOEhWV0xBaDJsNTFJMzBqNC9KWXBodDArZEhFSzF1?=
 =?utf-8?B?UUVYMml2TDFTNkgyTk5UMytEdElPa21JV3JLWkg3YXc3SytSWEtRL3NKempo?=
 =?utf-8?B?ZkIzSU9QZXpKMXJMbFhXYkk5b2g5dndhNDc0SHhIMWtlZ284WDRFV3ZqaFlC?=
 =?utf-8?B?WUZ3YkEzN29wYmRhM2lQb1h2blA0ZHlVZ0VGUi8xZk9jRU94eG1Tc29OMy9z?=
 =?utf-8?B?aDdCcmNWcnlET3FuT0dnVHU5R0hKYVhTcEFMdGg0Lyt0V0cyN2ZRMjgzNXFo?=
 =?utf-8?B?WkRZYVRtaVoyR2RWZDVMYUd0ZE1FaWJ0RDlPM2tiL2tZZCsxL1N5RVVXNFhR?=
 =?utf-8?B?ZVRqbEkzVklOOUlzN2FTait2OS9BTUF4aU1GdXo3SFFKTzlOdzFCdTZSUC9n?=
 =?utf-8?B?UXhDclhqaFNvN3NEbnFkZ3l1VndzTzNWdTMwZGFIWDVnZEo0dXlyUXo1REp5?=
 =?utf-8?B?bTN3VncxcVVjdDdyREJmWW9tR2dJKzlITThoaExVeVNxOEovTmNPaExOYVRQ?=
 =?utf-8?B?RjdiY0psUWZWTzdKMkZobE55N3B1YUJDWVV0alhTNm9Od1VINGdEYWdMSmxj?=
 =?utf-8?B?Z0xBSWRMU1dVZ3RnNHk3N1lkaTFkVWlhMndjTWxxT2NGcDRnYXJhS1RpWkpq?=
 =?utf-8?B?UzAxN05sbXlaaFNLVkdHdkNoNjYveEdaZ1VweWcwRGFlUW1QUGk0WkZhMTMw?=
 =?utf-8?B?MjBMMEd3anZUVG9HT1NiTVlXaEY2MG9VN1NGekttU3YrRjY0TStqQ29pVGk4?=
 =?utf-8?B?VVRQWjRyMUorc0pmRlE0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFViWDZQbElqa0E0UlV5NWRKeG5rR3Rmd2dCdWZ6Tnl1cDhRRmNWdHNHdDh2?=
 =?utf-8?B?dEZybld4UFBLRk41dEU3S1YvZTdYRFd5cThzcTRyWDRZYm53M3J3Vzg0K1Bk?=
 =?utf-8?B?aFZvSVg3UlRyQWpJVzZIUEc1cjUxcUlnOWhEaXBvbE5YaUhmeUo1Y0tHandq?=
 =?utf-8?B?d3UxemswNnd3ZXBieENlV3E5ZVpqRzRDemhXSzc0MzJ4dmd4NjY2WnVSOW50?=
 =?utf-8?B?Q3QzRDNCNmIwb2pua3VDTXZvZjVQTWE0dzJLbkJiVU54a01zbXZBWjdTVXdu?=
 =?utf-8?B?OWltZUVITnFwOGtCaGJ0QzlWY1RMd0g5Y2dvSDkyazE4bEpQdmJiMXZrWStr?=
 =?utf-8?B?RkpxS0ZCbWkyQ3c0UmNhK1Byb1dya1VXV0xCdkc0aFhUb0p2cTFLemtrSTlV?=
 =?utf-8?B?V1FSVzZMb2crN0crbVdjSVhtYkRwQzUwSzVJbUJEK2tEc2NjNThsYytKUlZY?=
 =?utf-8?B?MjY5azZDYm51QU5Tend6bStvb01EVXE5YkluMWVaMkJKVUFnYTVlZVdnd0RV?=
 =?utf-8?B?eGp0cEl1UmxEeGlaRnc1M0g2ZTVlZkFadUNPZVloS0d4b0RIWlNIVXpuOGg2?=
 =?utf-8?B?ZUJ3VzNNRFZ6ZmtpZ25XTSt5TWRtd3RQZWE2SzNkS01aYjZVTm5NVU5CcWFi?=
 =?utf-8?B?ZU4xOWIzdTk4TXlWdFN4bStDV0pmSm5hRHpqbTJYcGVsVGIvOC94SDUxNmhX?=
 =?utf-8?B?VnlsWnc4eUtBaHNXOGlhYWZnRTRud0IrRENnYlE3Q2kzaXRsVndqN05pVWlJ?=
 =?utf-8?B?ekdmYjh4aDBPWTVIMW9ZRkNvYlh3eTEra3FHdkVIWjI3WEtvNzB1elpJRUYy?=
 =?utf-8?B?L3RqQXIxNjl1Uit1N05USmF4VFhjYmVqSlExcFBoRWFXUkdGT0tBVjZiVE03?=
 =?utf-8?B?TmE4TllJeGgxSHk5ZnhnRHRpQTF0N2tteWplamVtZm9KSW40MTU4Y1d4QlRj?=
 =?utf-8?B?R3VaQzhXL0dNZXlkS0ZKREtkbW12OEpDaWd5aEFEK1hEWWF6dm1rTHp4QlJX?=
 =?utf-8?B?Z01DUXRHNVVMZ2UxRkVoaEhFdWxGTEI1QWFhYU94TDBRbW1vNHc3S1gwU2FR?=
 =?utf-8?B?K29kQUZXU3FRWDZZV0draWxidjRtMi9vUHZJdElYTk81TVM1dmI5WG9vdnVq?=
 =?utf-8?B?ekxKcHV5bG1SMnFBSlUwbWtPcnJFOHFwNENaajRTWDNUc240V0tOVHJrbGJB?=
 =?utf-8?B?Y1I0c1NjV1pZTVNlVnBSZmk1TXBxQnhKa3pWREJRc2tCbmtTQzRhSkgvQVdx?=
 =?utf-8?B?MXY0NklZd2pXRHRrSXZoRkI3MFFqVTk0MWtncDBGc0lQRmNKQWpSektsSlpP?=
 =?utf-8?B?ZytCTHlBQWZhU1JFK01nRmYwWGp0UWM4WnhROEFlVm5UWTBxQTF2NVg4NjN3?=
 =?utf-8?B?bllpQ05DNWovaGxpNTFwa0JneDkvaklqYnZYSTcwc1RuNFZldnlmNVk2ekxv?=
 =?utf-8?B?NUgxYXFKek1jS09RaFdHVjUrcG8yMDJHSytZV2t1Q1VJWUJwbGJhZzdGQjZF?=
 =?utf-8?B?cWZMZmNCUzJleWN4RHYwbDJidFk5eFd5ZVdmY1BFRzdyS0d3Wi9DQ3FibXFQ?=
 =?utf-8?B?dFpPaDV4WjRPdUhZb2xWekNnRW1pNzI0YzdFbHRCdGQrM1hWbzZqbTJoVFJp?=
 =?utf-8?B?NFBXb0JOZXkrVlhRMm9DaW44REpENWNMbE15Q2s3c3AwMUtmcWN3UnlUcUd2?=
 =?utf-8?B?Yit2bFhIZmwxOWhRNXlQQ2YxZWNCOGo1NmxETjNwY2szSmtmY2orc0JXRW1O?=
 =?utf-8?B?QkZWL0NJM0kvRjUzTHJhSUJDdkEzTGYvbUVnOTc3ZjR1ci9HbER4cVdHalpS?=
 =?utf-8?B?QnNsaWJ4WFZPdGdMNmNqRzZwOXhNZG5LUzFja2JHaEhQM2FRNWJkUWRYV0ZZ?=
 =?utf-8?B?ZHMvZDRmQ0FuSmc3LzVOSnV6KzJRdWhZRnUyWGd3ZnFFeFNNQ0pQREd0Z2d0?=
 =?utf-8?B?U0o4VEk5b2dwTGh4K05SQlJZbGc0RFJPc3YrMHBSWTI4bkExbDZJV3FEbmUy?=
 =?utf-8?B?UEN1bmRzQlRTajQvL2wrUHhlVm1DclZGVXVkMXN5dll1QU1JZlVYa0IzeXBO?=
 =?utf-8?B?a3hYZ3RUWWNBM2c1c3g5YkhHcnhWSnQ5WTkybWN5OS92amtudFM4YXlhcXYz?=
 =?utf-8?B?WHIzWFJKeEgrT3Y4YWJuMG1GUmgrK0dCQ3FpTGUvOGhJUmFYNDNtMjNYbFZJ?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd4524e-5a30-454c-0eec-08dd1f77f9ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:23:51.4383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seuClFAE2HagK0RhYGdyyUB/UHTgFnwdnV0pGeskKzKSlJdLSkXY74XV3ARMp97undLqRfzSJyOrjBqxveRKe8qZhbsgyGsc0MLoa0kY1Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
X-OriginatorOrg: intel.com

From: Gerhard Engleder <gerhard@engleder-embedded.com>
Date: Sat, 14 Dec 2024 20:16:23 +0100

> From: Gerhard Engleder <eg@keba.com>
> 
> Link down and up triggers update of MTA table. This update executes many
> PCIe writes and a final flush. Thus, PCIe will be blocked until all
> writes are flushed. As a result, DMA transfers of other targets suffer
> from delay in the range of 50us. This results in timing violations on
> real-time systems during link down and up of e1000e in combination with
> an Intel i3-2310E Sandy Bridge CPU.
> 
> The i3-2310E is quite old. Launched 2011 by Intel but still in use as
> robot controller. The exact root cause of the problem is unclear and
> this situation won't change as Intel support for this CPU has ended
> years ago. Our experience is that the number of posted PCIe writes needs
> to be limited at least for real-time systems. With posted PCIe writes a
> much higher throughput can be generated than with PCIe reads which
> cannot be posted. Thus, the load on the interconnect is much higher.
> Additionally, a PCIe read waits until all posted PCIe writes are done.
> Therefore, the PCIe read can block the CPU for much more than 10us if a
> lot of PCIe writes were posted before. Both issues are the reason why we
> are limiting the number of posted PCIe writes in row in general for our
> real-time systems, not only for this driver.
> 
> A flush after a low enough number of posted PCIe writes eliminates the
> delay but also increases the time needed for MTA table update. The
> following measurements were done on i3-2310E with e1000e for 128 MTA
> table entries:
> 
> Single flush after all writes: 106us
> Flush after every write:       429us
> Flush after every 2nd write:   266us
> Flush after every 4th write:   180us
> Flush after every 8th write:   141us
> Flush after every 16th write:  121us
> 
> A flush after every 8th write delays the link up by 35us and the
> negative impact to DMA transfers of other targets is still tolerable.
> 
> Execute a flush after every 8th write. This prevents overloading the
> interconnect with posted writes.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> CC: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Link: https://lore.kernel.org/netdev/f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch/T/
> Signed-off-by: Gerhard Engleder <eg@keba.com>
> ---
> v3:
> - mention problematic platform explicitly (Bjorn Helgaas)
> - improve comment (Paul Menzel)
> 
> v2:
> - remove PREEMPT_RT dependency (Andrew Lunn, Przemek Kitszel)
> ---
>  drivers/net/ethernet/intel/e1000e/mac.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
> index d7df2a0ed629..0174c16bbb43 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -331,8 +331,15 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
>  	}
>  
>  	/* replace the entire MTA table */
> -	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
> +	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
>  		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
> +
> +		/* do not queue up too many posted writes to prevent increased
> +		 * latency for other devices on the interconnect
> +		 */

I think a multi-line comment should start with a capital letter and have
a '.' at the end of the sentence.

+ netdev code doesn't have the special rule for multi-line comments,
they should look the same way as in the rest of the kernel:

		/*
		 * Do not queue up ...
		 * latency ...
		 */

> +		if ((i % 8) == 0 && i != 0)
> +			e1e_flush();

IIRC explicit `== 0` / `!= 0` are considered redundant.

		if (!(i % 8) && i)

I'd also mention in the comment above that this means "flush each 8th
write" and why exactly 8.

> +	}
>  	e1e_flush();
>  }

Thanks,
Olek

