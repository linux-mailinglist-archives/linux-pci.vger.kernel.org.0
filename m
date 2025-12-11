Return-Path: <linux-pci+bounces-42937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 671A9CB527A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 09:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6542B300BA0F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EFC1E2606;
	Thu, 11 Dec 2025 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXdDdISc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7B2C234E;
	Thu, 11 Dec 2025 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442771; cv=fail; b=iCnWI5dBtvoyU04CVlWyy5IJKIouRq6DPXtdiH6tQhp3counlt5GI7EnxF7sMgueEcfRdvpSAU5Pgq74Wtk9c71HwQIJrO/Mr4n/EYFUuMVzJqHqDRM4yL2vjYqt8nb4GV9iUqDd71GlozMSUn+u6rJu1zx3WT0v02ubDepgiz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442771; c=relaxed/simple;
	bh=tu7v2oHpvv9ymEK7PHc4Y0qG4jsatf78N4weiCIRcco=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SFV3TnmySQ0z1XL64gBJzJyPC7ey7EEDXLmGt4YN8JFub7OXO/UPlLHUZ+nyNs2tUipAw2jhQH2tmldG/5DpZOxfEYBDHS+UXK85LityZ8/7O3jSxNgaNxU4E7IhR3u4zSukZP7T0eYd14IX3u+dXCDuSsNvYxI4t9e8iTTlWYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXdDdISc; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765442767; x=1796978767;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tu7v2oHpvv9ymEK7PHc4Y0qG4jsatf78N4weiCIRcco=;
  b=TXdDdIScr5Mha1W/28S7Wd6uQNOCWcwsPmC9tuMnxHZ2wnPTXh+dlHtI
   Mi5LEAf9nIluFYrMhv9uRA+xX/lSLfInN7SoUhMZX3DGsaCrC+JRvAXG4
   G2D0t8bR7jTvuyEteS747My4pDab8cRG9IACjrilag7930Fo58hC9TuD0
   yfeD0EZCCZobzrWKouiEP2PzwiURBZAk4+7KQWeD3cUURcexSvv2UGWY4
   aWC8nA5z5lgjYIE+kfFff7+PnKri8YWIgT9PPHDEtVEbhhO0kTAG7pzLL
   4oCGFwtnjMPSk8SpabDFIOXqvxadT+zHFW5efBsSopkC4vQ/DbnmeNiqH
   Q==;
X-CSE-ConnectionGUID: jkJlS+XbQnmmPjmo5QHcbw==
X-CSE-MsgGUID: S5ZKx4z8RZCFTUg3/5Yymg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="54968794"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="54968794"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 00:46:06 -0800
X-CSE-ConnectionGUID: iJGZBWEjTXiazD//zYbb5g==
X-CSE-MsgGUID: bEWRb8qzQVmwH8o+JXazgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="197571045"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 00:46:06 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 00:46:05 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 00:46:05 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 00:46:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NP6e2/nnyVOdSUqVkHeGVJDqZnLbR6Z6SUslIdIg9L9SWpEM6qDOiIdQcW7D3N8OaILorHLJYopvPdmYH1HCrBqh+cLuDDr4hFSFCss6gcwZlfE/HwwFLBk2BrUSEQPFkn1WPZuuMcSNvcTuzvk5vogJGRV4X8ru9IylzAiFss58rfpCgfe+bSK3SIIS1KZ3XNfM+P0swC4sXAYuAzeWK/wH/PzSRtEXCWNr3kpQ6oS0P1SyXiGwTfurC/3opCNyCb0oiAlS63XC6rS8Z6LESwQt2DMZsLkXhkvExeMDwzyr48VuLBs0x4TnOTeeyIr2HDDLTSpXZV2hwL0Gm8wzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieGNyXyTGdec37ow0WmTw50Z0j+MfKMaRKlxr5Pgz7M=;
 b=ZR/GIFar9LoRYUNv8LxostZJ4Q0M9xxwyges99lzRpu3NVLqu14iKNOr1JWyvmh5uhwOHhCMY/rduTCIWGaTaj0Xiadx3XxfbR8G35ub1AMtjZEGHqtKt+QSJakKslj5no0+F1ZPtarppArs2MEL87F5f3PreJQ1qgv25fuH61+dEclNQaWxKAY4s6CC5tbURGvNNHWHXAv1mJBU99FHR7tRcwE80+3sENfpbfdaVsXpbCt7p3ueuixcccU3j4+h5lAROhcQtZTGqL6Ar1G6hmi4mgg1FIV/DtgN3zJPzy6g/fUY88HiSOx+QG8piBk26w1Jk3JzOWvrqrH1QOsrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by CYYPR11MB8331.namprd11.prod.outlook.com (2603:10b6:930:bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 08:46:04 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 08:46:03 +0000
Message-ID: <2b05635f-560b-45a2-87fb-670c144b6be2@intel.com>
Date: Thu, 11 Dec 2025 09:45:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ASoC: Fix acronym for Intel Gemini Lake
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood
	<liam.r.girdwood@linux.intel.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Daniel Baluta <daniel.baluta@nxp.com>,
	Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
	=?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
	<amadeuszx.slawinski@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<sound-open-firmware@alsa-project.org>
References: <20251210115545.3028551-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20251210115545.3028551-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0159.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::16) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|CYYPR11MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 488739db-45eb-42f2-e228-08de3891b796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzY0VjdaVEtWV0JTemFIUE5jVUp5b3RRUFZxdFdJdDhRZGwwSXVLV3hhTlNo?=
 =?utf-8?B?bStDelEwbHVQbTNPa0RzQXM4Q3JqbXpPWS9pY2QyU2pOWDY3bFBCY3pCUWgw?=
 =?utf-8?B?L0N2SEJXeEUzd080RnhpaDZjbmJrSEh0dkx3K2o5WTdDUWJrQklXL0xSSW9L?=
 =?utf-8?B?TTZNeFFYZVAxYzFFc2lTekx5RHN3MWFId3J2MW9PTU95aTk4cGFZWUdPWVhh?=
 =?utf-8?B?M3RFRWhRdURPTXUza2hwL0MwNVdwUk54RkY1RURhNkl3SThRYjBMV21CYS80?=
 =?utf-8?B?b2R1QkhuL3hKTEhrcW4xb2J6N2ZSQWRvODBrQ3pNUzY3OEZrODI3bzNyVXZY?=
 =?utf-8?B?WjQzbE80R0VwcDFrZ2wyN051dXhFdktHWTFXelQxQ0FPZUdheGxHaktJV3lw?=
 =?utf-8?B?RWpwNVo4cXh3RVZtcUdqQkFQVzYyS3Jmc1pEVkh6YkFudmdhbk5PSC9TQ1Nv?=
 =?utf-8?B?eTlvV1NFSldQWkVuYk00YUpoejVRYXRkS25iT1g0WEZjQ2lIYkI4Szh1UnB0?=
 =?utf-8?B?YVhyUGgxcXdZdWdrdVRkbUUrcVAvUzY5aWhJUkRiSm9iMmxLUlFjZm44dGth?=
 =?utf-8?B?RzJEWWdxM1I3YktBWE1XZkpiN1NGZkp5bkNzcEpFL3p6dHdoc1ZzdGo2UnNO?=
 =?utf-8?B?SlZZVm9mVEZ1WmVvVmNGR1JEazlFMDFHTi80YlY4ZjdYWmQrNVBxYXo4eEpi?=
 =?utf-8?B?MVo2VmZ0RDFmWXl5L2ptTTZtekdZL0hoalNPdjZVWnY1NGRBVGVobFRZU2Iz?=
 =?utf-8?B?MkJCWkdYazI1SWVybnBldU5CNEtQMW5wbGFSQWI0K0RZZ295RkxPUWJncFpq?=
 =?utf-8?B?eDlhZThpTy9hdklKdEd3bGVOYXRhbU5VS2Npa3JGVDhKbUZGZEhsV0VGWUd2?=
 =?utf-8?B?ckw0QmM1c2VLR1BDUXhucVQ4OVNKOSs0eHowYm54UmFhcWhSQ1NadjJITTBL?=
 =?utf-8?B?YS91czRQRUZNL0UvVklvemJSMHc2R3MxUEFKdkpiblM2YkFTdVZJdWt1Q3Bk?=
 =?utf-8?B?bTQxYUNnM3MxcUtUQk9SZGU1QWRETG5FblhYeTJsVzdCYXpqZVJpVk9qenVU?=
 =?utf-8?B?UVFQS2thSWJuRkNnc2F0eUZuVVhBZC9rblZ0OXY1R0w3aFNIWEU3Y3VSRDdC?=
 =?utf-8?B?MXQ5T0xIc29nR3o3NCtEVi9uQ05TNkNrU3BwZElVTHQ1QUtvTVNzVzZxeGN5?=
 =?utf-8?B?VnN3amlrbkJ6empEOFpaU29JZ3lhOVRsTEI5NzQ3UDl2R2hqdTZZSCtHNytZ?=
 =?utf-8?B?eFpwYTZGWlVEcmtNSnp2R0paRDBOMVc5cHk0Tmc1czROUjZ5d2RtMG95alBn?=
 =?utf-8?B?dDhhMFVqQjc5eVBseHVvWHd5K3hVbENBUHgxRnROMi9uTGxubGVhOHh3ODdR?=
 =?utf-8?B?NmxXWWR0Y0RVQ1BnTkswR0J1dkJNempTSTNvT2gyUlJ6RDRhWWorMExtSUg4?=
 =?utf-8?B?MU5lSkhraE0zNVZ1YmxJMUo0YkNZWS9jN1ZMQ014NCtUTkh5U2VsRTdBcWRD?=
 =?utf-8?B?QkhER3BUYTV5TDBza1VRY2ZqZHhZUlMzWGJPb3BiQzY1b2VsS1JNeVN2VDAv?=
 =?utf-8?B?K3FReHFoUjhQQldwQytSM2pUVGNxQWhtVTlFeERCMTR1V2VDdjQvalZWa1Qy?=
 =?utf-8?B?UDlDY0t3N0QrcWdtZWxRSk0wRVltR2Y3S0ZhVyt6bkVXcmVVakc3WDhteWhl?=
 =?utf-8?B?RWlSWHl3bE9oL3k5Y09jR1FJc2lhZ1cwK0U5QUMralZYbmlKZmhGUGxvcUR0?=
 =?utf-8?B?M1M1K0dwcEQ3Z3FzVWdGOVprOU4xYjdSUHM5SkcvTEk1d3ZwSUVScEEwSUFW?=
 =?utf-8?B?cDVRMTVjMHZkamgzV0Z4ZGhXcFJNenlUQzJTekhrdHdBZTZXaWpsZWVCVjZH?=
 =?utf-8?B?RFNjQk9tYmloWjEvN3gyaCtXV2QvNnFHRHRqMFliVUlGcDUvVzhocUFTQ1ZI?=
 =?utf-8?Q?eaHE2ShXh02fAyMhhppHKbzOU+UGv/KI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHdlZU1mTHlPc3NxNjlBakIzanBFKzhaREp2U0VjSnR1TmpGL3QwZXpDbERa?=
 =?utf-8?B?ZVpLbkhQWStYVGtUMmE1UDdvNjQ4NzZxcXpzdmptL1BEUEhhdDFOS2xIV2Q5?=
 =?utf-8?B?MUt4LzdzSUFmWDJoeDRENDdlRXdMWTVMSVRWZE1QVHEydXZjYnZUYXpDajdS?=
 =?utf-8?B?bEY1TXFsaCt2b2dKU25USHE2cTJvTGluWWFHMG5LMVZkZzF5TEhvb29veXEz?=
 =?utf-8?B?TUNhQXJ6a0ZGZW9zNkNESi84a0twbFoyK2M5ZUc4akZJUkNta3FwMng1c0JY?=
 =?utf-8?B?RDhXZzY5cXlwL0RiMEE3cVI2bjg3N09kTG1PeDNnYXk3YUhTb00zUHV6cUNi?=
 =?utf-8?B?dU13RHBaWmhhYlJxYTZiYndsaExmeDh6RzlCK016WVIxSzAyZGhYSWJhT00z?=
 =?utf-8?B?aEpOdzNETDhBZEVlSVVKYWhYNy9uQzRSTW1nZ1QxSmdJQVpsbjNnZFNKVU5N?=
 =?utf-8?B?RUltR3QzS0s0QTFvajYzVGVOM29xYmtpei9ZTTNYMUlxVlZVZDV6Q1BWUFhk?=
 =?utf-8?B?c251TlZiVEoyT1VDY205RUtzYjlyVTdpTWt5OUQwMlRZcGVuOGZjNng2emp5?=
 =?utf-8?B?ZEpPVHhNbWtFOUI5RDBhaW5odkEyVC9PMDh4dDhsOWJURUpiS1JyTW5YMHVi?=
 =?utf-8?B?VHdlemFCdjdndnhvdkZuaTNLcFkzMXJzb3FMZFl5bFdmVzk0cm5lMUx1dlJ1?=
 =?utf-8?B?VW16dXd3bUNEQkVDZGVwMytqU2FXYXBlRGlGWk5rd2krVm82SDdmbHdVOTZr?=
 =?utf-8?B?d0xCYlF0V1M5UDJQVXZSdlhkVldoTHpNdklRbXZzNVZJQ1JPMkpKbFVOanZT?=
 =?utf-8?B?cEtwMlhTRXBUM0U4UlZhY29LNjhTYTVlMmwzcHBNazYvTm42OTBiT0ZUakU0?=
 =?utf-8?B?UEhKV3FuWDFTSmJSUGZpSXBaYWI4ZUVRNlVjeU1MWFBvaFlrWlN2bkVKT3lQ?=
 =?utf-8?B?Q2pwQ1RyRnJDUVR6dUtPbk0vQ0NNQ2tnQ29ETi96cXlDS0NudXJHRlNYYTNj?=
 =?utf-8?B?ZFlobUxUbTBaYk1wL3R5OTNCOTdnU0xFZGczQVJoVzJYbWtWdm9pcStTT0My?=
 =?utf-8?B?QlFrcTVwZWtkdjBudmVFd3dURzU1b0cwUSswR3RYVzMvK2RKa09xVExkS3pS?=
 =?utf-8?B?RWlFQmhDZ0YzOGZPT1ZzWk1DNE96L3I1YVdER2d3aGx4NFVMZHBaWVhNQ2ZY?=
 =?utf-8?B?VUhtZCtqdEV3LzdJMTczdnNkWXNValBad1VZVm5QcnpTVGdLVkR3c3RIb0tU?=
 =?utf-8?B?Z0E4WmZUTjNzUkV4bHorajdFZExrMWVRc2p4WkdOeGhpVFhGVVR6Y2RCSllj?=
 =?utf-8?B?clN3RWJtSUlpTlc0UXNJVWkwU0ZBV29paEE5SzNOREF2WGJUMjRNdzJBU1Np?=
 =?utf-8?B?ZDNlWS9iTEpmdEo3dzJrVjBlc3RERk9aMlhkUkdHWUZmYVBSSXJhbnJhS1BL?=
 =?utf-8?B?U3cxWDFudkkvVmtUaUFmV1NzT1lIMXpyM2tpU2t3bTQ4V2h2dklqM0s2MUl5?=
 =?utf-8?B?WnIxQTZaOU1wYVNNMmRUWG9RQWpSNXVxT3l4QmFDcUlYZkQzVGVod2JYZjRl?=
 =?utf-8?B?WlZsWThkNFpFYldjamVqR29VNkdZOTI0YmJmY25kQmNlWDZjcWsxOWpUQmVJ?=
 =?utf-8?B?NWE4emk4QUwrZXNzMzRhSGFhODljZDY4c0FpeXR6aGhVVkJlUzhxRE1JQ25M?=
 =?utf-8?B?ZnpQVzlmNWo1UDBBS0xGUENEOEpHWm5XSGJtMGlhQmhsbjB1TW9xQ1IvTTA5?=
 =?utf-8?B?alJPcDI4V1FBdTZuUWFxRlArN2QveklOWklMUTJiZmRoU3daS3FHaVlSU3BU?=
 =?utf-8?B?NFgwR3htenhsSzVMb2d1REtQR3ZRaXBacFVBUkc0cWJ6REY3cVArYzZxQW14?=
 =?utf-8?B?eEhDSjFBelpUTGkxaHR0blZ1dGIrclpwMjNMaUU1L0IrKzM3bFpyV0FqUE15?=
 =?utf-8?B?eTBxZ0FsYitXVXN4REtvWEQ2NTlOU1BIOHF3aW41R3ZpY3RLY2FFMnN0TFZh?=
 =?utf-8?B?aUptV0w1RU83L054NDJYYWpFZzdvU2FKSWV4S3JKdFVGTjllTllnSkNxeDlk?=
 =?utf-8?B?REZKWVBZUTMweDI4NERRVTlDSnN5MGRraU4xb1h3Qkd1d0lqcmUwTDFLUlJF?=
 =?utf-8?B?UW5yU3ZiTy9yWlY0YXZ3TTlMbGZRTmNhR2JoeWIyLzdrYXhSbTN5WDNJLzUr?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 488739db-45eb-42f2-e228-08de3891b796
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:46:03.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWkA4+QvpMILYWGs6NHgQqBAOtDbtrg2a94K/Di5k3bZIAWraAwWz9iB3HjhHfRltU92z1lQeeODOSTuGQTRvXuh+asDwdRUuU3DF8kIKM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8331
X-OriginatorOrg: intel.com

On 2025-12-10 12:55 PM, Andy Shevchenko wrote:
> While the used GML is consistent with the pattern for other Intel * Lake
> SoCs, the de facto use is GLK. Update the acronym and users accordingly.
> 
> Note, a handful of the drivers for Gemini Lake in the Linux kernel use
> GLK already (LPC, MEI, pin control, SDHCI, ...) and even some in ASoC.
> The only ones in this patch used the inconsistent one.

A number of times I've fought for the 'GLK' to disappear from the 
Intel's audio subsystem as clearly the "right" shortcut is 'GML'.

However, I do understand where are you coming from - the corrections 
came late and the "mistake" has been widely spread.

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   include/linux/pci_ids.h               | 2 +-
>   sound/hda/controllers/intel.c         | 2 +-
>   sound/hda/core/intel-dsp-config.c     | 4 ++--
>   sound/soc/intel/avs/board_selection.c | 4 ++--
>   sound/soc/intel/avs/core.c            | 2 +-
>   sound/soc/sof/intel/pci-apl.c         | 2 +-
>   6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a9a089566b7c..22b8cfc11add 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2950,7 +2950,7 @@
>   #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_ADDR_REV2  0x2db1
>   #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_RANK_REV2  0x2db2
>   #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_TC_REV2    0x2db3
> -#define PCI_DEVICE_ID_INTEL_HDA_GML	0x3198
> +#define PCI_DEVICE_ID_INTEL_HDA_GLK	0x3198

If two #defines are no-go (PCI_DEVICE_ID_INTEL_HDA_GLK and _GML), then 
perhaps at least a comment to the right of the ID mentioning the "GML" 
would help.

>   #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
>   #define PCI_DEVICE_ID_INTEL_IOAT_TBG4	0x3429
>   #define PCI_DEVICE_ID_INTEL_IOAT_TBG5	0x342a
> diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
> index 1e8e3d61291a..bb9a64d41580 100644
> --- a/sound/hda/controllers/intel.c
> +++ b/sound/hda/controllers/intel.c
> @@ -2555,7 +2555,7 @@ static const struct pci_device_id azx_ids[] = {
>   	/* Apollolake (Broxton-P) */
>   	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
>   	/* Gemini-Lake */
> -	{ PCI_DEVICE_DATA(INTEL, HDA_GML, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
> +	{ PCI_DEVICE_DATA(INTEL, HDA_GLK, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
>   	/* Haswell */
>   	{ PCI_DEVICE_DATA(INTEL, HDA_HSW_0, AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL) },
>   	{ PCI_DEVICE_DATA(INTEL, HDA_HSW_2, AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL) },
> diff --git a/sound/hda/core/intel-dsp-config.c b/sound/hda/core/intel-dsp-config.c
> index c401c0658421..948fd468d2fe 100644
> --- a/sound/hda/core/intel-dsp-config.c
> +++ b/sound/hda/core/intel-dsp-config.c
> @@ -154,7 +154,7 @@ static const struct config_entry config_table[] = {
>   #if IS_ENABLED(CONFIG_SND_SOC_SOF_GEMINILAKE)
>   	{
>   		.flags = FLAG_SOF,
> -		.device = PCI_DEVICE_ID_INTEL_HDA_GML,
> +		.device = PCI_DEVICE_ID_INTEL_HDA_GLK,
>   		.dmi_table = (const struct dmi_system_id []) {
>   			{
>   				.ident = "Google Chromebooks",
> @@ -167,7 +167,7 @@ static const struct config_entry config_table[] = {
>   	},
>   	{
>   		.flags = FLAG_SOF,
> -		.device = PCI_DEVICE_ID_INTEL_HDA_GML,
> +		.device = PCI_DEVICE_ID_INTEL_HDA_GLK,
>   		.codec_hid =  &essx_83x6,
>   	},
>   #endif
> diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
> index 52e6266a7cb8..46723618d458 100644
> --- a/sound/soc/intel/avs/board_selection.c
> +++ b/sound/soc/intel/avs/board_selection.c
> @@ -227,7 +227,7 @@ static struct snd_soc_acpi_mach avs_apl_i2s_machines[] = {
>   	{},
>   };
>   
> -static struct snd_soc_acpi_mach avs_gml_i2s_machines[] = {
> +static struct snd_soc_acpi_mach avs_glk_i2s_machines[] = {
>   	{
>   		.id = "INT343A",
>   		.drv_name = "avs_rt298",
> @@ -367,7 +367,7 @@ static const struct avs_acpi_boards i2s_boards[] = {
>   	AVS_MACH_ENTRY(HDA_SKL_LP,	avs_skl_i2s_machines),
>   	AVS_MACH_ENTRY(HDA_KBL_LP,	avs_kbl_i2s_machines),
>   	AVS_MACH_ENTRY(HDA_APL,		avs_apl_i2s_machines),
> -	AVS_MACH_ENTRY(HDA_GML,		avs_gml_i2s_machines),
> +	AVS_MACH_ENTRY(HDA_GLK,		avs_glk_i2s_machines),

To be honest, I'd leave 'avs_gml_i2s_machines' as is.

>   	AVS_MACH_ENTRY(HDA_CNL_LP,	avs_cnl_i2s_machines),
>   	AVS_MACH_ENTRY(HDA_CNL_H,	avs_cnl_i2s_machines),
>   	AVS_MACH_ENTRY(HDA_CML_LP,	avs_cnl_i2s_machines),

