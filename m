Return-Path: <linux-pci+bounces-43033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0CFCBCECB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 09:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F14A3005FEF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF852D9784;
	Mon, 15 Dec 2025 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8t68scw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A7286417;
	Mon, 15 Dec 2025 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765786106; cv=fail; b=DhbCCmdirdkNC/DexrBfILh4ojOxF2JUmJkhB9jmAQ+QYS0/TprBsRyD/b4j5Oxsnf+tLNGO2zzptqWBVGZNviZOVIC7ppto+ptY5d8yHK/sHEdACj+FSJfVnZA/CwrfkQuS+7y0m/ipXZDBPvpXxu5BM45vHVa//LEqYLgDPXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765786106; c=relaxed/simple;
	bh=14M3aiOM3Ex0l7u3jce0rHQkIQaq7S8/ppTWdB5QcSU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g2NLprj8rRjUHtDqt0q3ZMQxGLo95qZWbz3COXi6TEnUPE8vV0i/sa06ijDjvm9EBqIBE3CVEv/bJaBLudEAyzF8ZqvYhKVooU+McdkNSnaeVI1Tm2gGwg6V7W8s0Zi6qt3BFffZkFCFv4CklkZzf0EglXXgV7mjF7NAGdlRNyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8t68scw; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765786104; x=1797322104;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=14M3aiOM3Ex0l7u3jce0rHQkIQaq7S8/ppTWdB5QcSU=;
  b=G8t68scwnyJ5a0RWd1ydVrh1cHOapAEVDtBwBsBiEcYjSGwIXDSKSHxj
   05bcp/wq9Hfwv1/2QNyr5v6Zv+jA8dM/DL+Cm2DtanV0j4uBsqLHVHY2H
   MlsURbwMwkqsPMXcbQmRGv3O34o8tAjQj/lFMDK/oMP31y+zmmE7iE/He
   V5NRfMvZuYdfz1POgJozAVpm86QqDDbnQCmwtGTMpIky8qZmGvgEBX01+
   SGW/6/T0WbLnNJgDDu4E4/XYI0oxvZBi015Bibg5c99s6QjVhtOcV52hx
   aKg1XoOhZwsniO5zpuqBITdhIns42LdN5rmtilW6Yvag9yEwDYm3nIyL+
   w==;
X-CSE-ConnectionGUID: 6/gicuw2SSu6oCHkb18nXQ==
X-CSE-MsgGUID: K6V+HX+lQv+tj1Huw95eeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="66863249"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="66863249"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 00:08:23 -0800
X-CSE-ConnectionGUID: PUE7DCVmRPiprUSI7GZAog==
X-CSE-MsgGUID: jtxTB78HRA+1jkEO2kI2iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="196739686"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 00:08:23 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 00:08:22 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 00:08:22 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 00:08:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzsDg8wX2+xq2aEVBSQMXJmpSU/1vBBxcpCPFkNgkVD06kL/R4WvaNDZit33XN1q54s4OX1OOYZJz4mX8MJ9LkK6BYiJ24KkQtB1MPcWGUw31eSNXTmfHy0nZF6EcAPAL7sPkZFAIX4UrN+uk/pyunyfQ0WfFE6Os5JuQSQqvNiyBsk2PiA6NqGlAXIGbj6ZVRQKzhlgTRGgzuSf7wB6bdcdLp8TlLd5eEnju2Vods0HENpJd6lbTFa96arZuiPa8ECUXWkSCMM+y4xkF3GMSaDHOJ/gVFr1L0JEvqZyMFY04cQsP1xgy2G0gUeaDEr/p3NLJ8qKpAip+GqZ+Un95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ1Hmd75S4vyJlAFWyeMJTo+gX8TdejypyPVNiU4haE=;
 b=Q9KHvjPGN4Ja/0av2Q5maICRT6uwWOn8OzaCgvXv9A52c9z03Oo/gvP6k9dxo2qkgj5WeYQzSA+sDo+l7OqP/uqnqNPHwBrU0xnxRAa+96sOlCauAaTc1vPUjZfhOWdMTuGuwG+ooOKf5d6PfsVQp7sOUcG7zXB8uGia5CSYbRg4q0zqiRIvaXw49SmK/5QzlB68fEsxwjV1ohxEVNvNWlPSFiZ1d6W/jOXBoQvUX/7GxRdvHzJVU6WtfUFrsvkM6BNKOwB/0rb2KP0QKNLJmFG4t2EBY+cWasfIT0LH+wgvHgUUJj/eNz3HQ790NVIkkVyMMkd/zs9JasUxDGV5Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 by IA0PR11MB7955.namprd11.prod.outlook.com (2603:10b6:208:3dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 08:08:21 +0000
Received: from SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6]) by SN7PR11MB8283.namprd11.prod.outlook.com
 ([fe80::3:e0a:87af:d4b6%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 08:08:20 +0000
Message-ID: <e3182e87-cd11-4fc6-86c4-091431013380@intel.com>
Date: Mon, 15 Dec 2025 09:08:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] ASoC: Fix acronym for Intel Gemini Lake
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
References: <20251212181742.3944789-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20251212181742.3944789-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0051.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::10) To SN7PR11MB8283.namprd11.prod.outlook.com
 (2603:10b6:806:26c::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8283:EE_|IA0PR11MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de4d91e-eb7f-4bd2-4926-08de3bb11c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmxyeFFzeWR2V1NSZ29TWkNoOFVRY2NNTElzWTRFa3ppSzh0RVR2VEI2TUF5?=
 =?utf-8?B?aFFNbWtjZ2I1NWhNTDFRak5pajR0SlhpeWgvQXVIdVNVYnpqUjU1V0RLYmlI?=
 =?utf-8?B?dGNUanlHTEx1cHZDakxqM2NuMUlkck1ibm9oV3FpdXp4cmhzeVZPNEh4WmZM?=
 =?utf-8?B?WWZ5ODJaeUU4bjYyRGw3d0Rjaktna3hhR1hvQzNZSkswdm4vUUgrQnRZTzlz?=
 =?utf-8?B?Vm5pU3NYSC9kb29wdHFVaDliRS9QNkRaRmkxcFZXUEs0Rjc0SUtkeUhpaUpk?=
 =?utf-8?B?bVNkT0Z0ZDRtc2d5dzhmczNPUGh3OEZWWU1WYzBRbWRXQk5GdEJ2SjBNOHJu?=
 =?utf-8?B?YzVTaFRGZWlzYmUyaEtoRXRHL2ZicFl6bCtaaFhsOUVEYXNkcjBIc0w0TVhD?=
 =?utf-8?B?YUhjYUtLbHZrRWYxNTVPVExvUEhRcEp2OG9zOGFnVnM4Q0svVUFkL20rbkRJ?=
 =?utf-8?B?cXozQk1vTytVcUhSZVBpV014WXBIZXFPak14eTF0MmJZYy8yb0kwcnFFQklx?=
 =?utf-8?B?Tng5OTY5c3Y2aTRsMjVndDRKdkRRUmtZODM5WHJVMTg5aDl3akxteFIyTGdC?=
 =?utf-8?B?VEtUWDdqUUJhVTM0U1ZyRlJYQ3IwaGM2K2dEOHlMcUVLUnJUbTFrWjBlZXpk?=
 =?utf-8?B?VmxvMFdJL0Q3eS91WmFyQ1BHcWxRbSs3cGxGUFVMUUMxU2kxQW12NEpCampF?=
 =?utf-8?B?SzFkcDVEbXQ0RGVneHB5QmtqdTJoQXlJOG5Lbm40RUhGSTFwamxqYnNkeUdV?=
 =?utf-8?B?NzhlM0ppSTQ3dnJ3R2hWR0I4VWNpMmtiZ0c5UExnVTMrK0MyVStjV3pZYWFy?=
 =?utf-8?B?OW9nR0ZNelh3NU1GNk5TL3lpaXhDdXZyU1B5VGpPZE5BZmhta3NqVkhpLzVv?=
 =?utf-8?B?dmh4OVRZUWpIYkJoeVZxZmhHZHF3cWZhOURMYnpnNUlwanFmbFViTG9JTzh1?=
 =?utf-8?B?aFhOdURmTDN5MEtOTVVsOVBReWlnR1dsOUZXbmoySGNDM09jRVV4WW83S1Bl?=
 =?utf-8?B?WFhGQ21WY1dhTDRQbnVURGpITFhZYlp0aHpFa3hRRFI2bFpOUnExVjFwTVc4?=
 =?utf-8?B?UDFleVZ0RU0zV3YzUmVnbnRMUDNqUG5NZmx1dmxhbURhRXVGQkNqTTFRcENN?=
 =?utf-8?B?S3NyNFNlTGRlMjVSZXNoZUV6SkR3QmJlc1FPS3RLY1hZWmx0cjdKNzNIZnhu?=
 =?utf-8?B?YitVeVpwekltaEhLTW9RVi80VUhoWkJxN3RoMURqeTlETjFNT2ZCSnBpeGRy?=
 =?utf-8?B?S2h0WWtjL0tTL0hDMzZQeVpweTAwb1oxZk5aNjRSNjU0d0dMclBOU3RXaGE4?=
 =?utf-8?B?NzkzQ21PdDFXR1hvc05GSytvOWRYQVJXUU9XL09ZaGk2dHR4OGE0MGZ2Zllw?=
 =?utf-8?B?OXJjL1RqL3Vqem5pNXo4VTZ3WmIwVHdoc1Vrak5TSVhLb3hvYW8xZmk4MGtt?=
 =?utf-8?B?aUdReGpTMGh1NjNGbmVkWVRJRzNzNVpUTDB1eFY3Vk5ONk15ZmhZV1Q0YUIw?=
 =?utf-8?B?MlREZnFMclBnd2V2bXdqUWFoR0cxcUtOc2ZTb05TcmJBOVdFNGlYekxtS3Va?=
 =?utf-8?B?amJyMC8wRG82empxZFFnbkVvcEJHdUorNG5WNWxTVnRkYzJpbGJOcWJGdElm?=
 =?utf-8?B?QzdvQkQzdStxUUxwaFNiUWpsRSttV0dlbmRDakxoQ0pid1FSMUxrdWgwUFFu?=
 =?utf-8?B?TkZac1NqeGk5YXdhR3hQYUdTbzlZaWFieitkaW80ai91RzlmM3RLVnNuSG9z?=
 =?utf-8?B?NElOTUFmNHkxaGwwODllelpPQjVZNStYTkJOVUZtNkRTdHJBTUVKc1ZkY2Qx?=
 =?utf-8?B?YTJZM3ZNUUtMWlZXZ3VNUGcwQVV2N0U4T2lSVURFTEM0VElvdUN0S3pIMVZt?=
 =?utf-8?B?QWRyekNMejRTUU81bEFSUmpwYWpDN21Qd2M0dmFVVDRFZ2ZINlRiMENTT0Ju?=
 =?utf-8?Q?kJoTk1dDD7xNJe61/rmZnljGIzqjQgXP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TS9BL2lSTE5zZFZMQi9WeVVPT1JxZTdvV1h0dDhpSVNqdU55VVc5SFFWVGtL?=
 =?utf-8?B?YVc2bDNXR0FyKytLZDR6VzBtU1NrN1JXT05vZG9ScE9zb21pc0VjNVM1SlJN?=
 =?utf-8?B?RXJ6VWlPZEttMWxpV2VYVm45VTBzNXdPRVhlOHRxTHZlc1F5cnd2OTQ5aDB5?=
 =?utf-8?B?S2dwem40MnBOcjRDV01mR2swUndRSVNCcVA4cTJxMHhXelQ0UDBXR0ZnQ1Y3?=
 =?utf-8?B?YTFUSHBFSEhUUFBVQ0ZXaG14KytoSW9MREo5OGYxWnJ2b3pCQlNPL0M2YUx0?=
 =?utf-8?B?TmJjMEsyMmdXYXBKVWRkQ2sxdUhUMlZ5VkxtQUNpWW0xczdXeWNFbytpTjhi?=
 =?utf-8?B?TFdGRXplUjVXc3FHVzZneHB2VW1IV1R6U2x0cFJod3BoUTE2bFRDeTdsTXA1?=
 =?utf-8?B?WHc2TG5zTE9KdWoxVDBHMGU3UHZZQzE5cXhUOURrcGpQNWptSy9wZkpUSkxl?=
 =?utf-8?B?eGJXOU8yanpEN0NrTVZyR2dnZGt0cU5ON20wenhLU2tMeWRqV2JBNXltMFdz?=
 =?utf-8?B?RExRUnRnUHhaakNvcldBb3FHMTB0Q0NtNjRZaHllbDNpSGt0dzYzUGFtOTIx?=
 =?utf-8?B?YU1OaUxqNFFpY1dYWFpoWEFUR1A0SUdRWlY2SmtVaks2NWhBcHpuNnpaMmZa?=
 =?utf-8?B?ZVlUdmxUMlUyTFowUEdzS0UweFZTT1hQcVV0M21zaW5NZlllVGI5SWhwODd5?=
 =?utf-8?B?WmluNjVEMXBGYUxYN2ZWLy9kbjBqOFpFYzFGL2xJK3cvK042cFdMUGRLUklO?=
 =?utf-8?B?WEtKWmxqMSt5NCtjbXNCM0k2T3RHMmQ0ZFBVKzJMaUlRMm42Ym1FM3FGUTVF?=
 =?utf-8?B?ZnNoVU9vWWFNY0tQVGVJUHVNZTg0RGZJb3ZKa3A0SDNZTFRJaFYxelVwWDhk?=
 =?utf-8?B?Y3BlV2xhTUZyY2crSUNXeG8yRDVaRVJmOXJqRUlVcXJwRFRTZTl6NExiQnJK?=
 =?utf-8?B?ZkZvMlZMTkxMRVhnWDFqSWJ4MGRKSForWjdRY1NXd1dNSlNyZ2pUTFE5V2lO?=
 =?utf-8?B?OTdQYkdESGtIZThoWGwzNHplQjNSRmg3elRXMUlkQ0tIalRWZTN5S2ZpZGJP?=
 =?utf-8?B?ZXBVai9VOWQ5WVFqR240cmFhb0hPVlZxQjZPM2lNdm15RmpCT1FLUE56d0Y4?=
 =?utf-8?B?cG95bGtjdDRRNkJES05OcXcvVEYwNFJienZhS3YyNm5oZUQ4eHB0eHpuNXNB?=
 =?utf-8?B?b3hCVzc1OTR6RnpUazlhSVJacU96aHlZSFN2TGV1OFNSL3JoWFhhTkp0Zktt?=
 =?utf-8?B?STF6U1NKU2ZWRFZZQWd1Q2d6U2xHSDB6ekRienVKMWJ4SXNIMEhsaXpKTS90?=
 =?utf-8?B?dEdVd0VRcjdsQXVJMjVKL29HdGx3ZnV6ZFhDQ1YrYXhVZjdQZm53bUtlOUs2?=
 =?utf-8?B?Vm9rMitBQzB2TEZlYmtZTlhPRDltdlBkaERxY0VGcHJSRjY1T2hFeFd6cURi?=
 =?utf-8?B?VGhhQVBmRXI3RXU0SW5JTEVpb1dTSEY0bVRDSlg5Zk4zTUpoMDdiUnViMDRE?=
 =?utf-8?B?NGhzZ3RPbEVmZDFqU0thVjl0RWMva0M4ek81NjFnQlFGTkV2ZDJOUXVNQnVq?=
 =?utf-8?B?Mkc4azVYRWhrNXlnaHloTS9xd2lsVitGZkFDb20rS1FDd1Yzb202VGgxUUpE?=
 =?utf-8?B?YjFSRnJaaHZqV0ZmdFRmYXVkOEpUNTEvL1puNm9Od3JqVnhMYzNqeG5Fci9K?=
 =?utf-8?B?eTVmVDE3Q1llRGFNS1FHQVIzTHB1cm1hRzRyQ0dhS1FXaktRbEZPM0x3TlU5?=
 =?utf-8?B?NTljVk1lUHVCSDB1YWpYNHBYR2JXOVd5SWV4SWs2bUlOU1draU9MMmZROWpZ?=
 =?utf-8?B?SW5SOGcybjlPbGl2eG5UbU1WaFZQa3hvQ0pMVGNNTnR4RFBYZDJKNnlpaGcx?=
 =?utf-8?B?ZS84KzhJTGtxd3M0ZENJZ1NuODh1NnBQQnU0OEhhZ2ZZZW1NK002MUtFV2po?=
 =?utf-8?B?T1RwNHVTd1B6R09HOXUzVnltSTMwQTc3ODhYRjlOYmhYSnkraVpxWDBYbkJk?=
 =?utf-8?B?YmZSTjNFcjBRRkJHNTlGaVNqZFAxOGR3UFBJUTlheU53bE00bWtFNzRoVWE5?=
 =?utf-8?B?UHJpbk96YXFDbktKYnlDRC9OTmRkTHc0UmJ0NTNIWERTamhleUljNWtGOXdZ?=
 =?utf-8?B?Q08yeVc4YUk0WDZ3cmpuUGQvb2QvemwyUzRPQVF4T29TaHFvKzFNaHFEeXZS?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de4d91e-eb7f-4bd2-4926-08de3bb11c7a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 08:08:20.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmNwCZOOU/bvWbu+EM9/07tGXivmAry3LYE22b7/D7jGrjRq69ycZCxetCD4qt46FVA5/ZU4vexXlbAQnXe66kiNls/tUklbH95zUExhr/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7955
X-OriginatorOrg: intel.com

On 2025-12-12 7:16 PM, Andy Shevchenko wrote:
> While the used GML is consistent with the pattern for other Intel * Lake
> SoCs, the de facto use is GLK. Update the acronym and users accordingly.
> 
> Note, a handful of the drivers for Gemini Lake in the Linux kernel use
> GLK already (LPC, MEI, pin control, SDHCI, ...) and even some in ASoC.
> The only ones in this patch used the inconsistent one.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci_ids.h
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v2: added tag (Bjorn), left variable name as is (Cezary), added comment (Cezary)


Looks good.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

