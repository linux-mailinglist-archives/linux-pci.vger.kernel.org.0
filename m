Return-Path: <linux-pci+bounces-40153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C73C2E682
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 00:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E200A4E382F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 23:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC832BE7D6;
	Mon,  3 Nov 2025 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glMJqLrs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87E23BD02
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212863; cv=fail; b=THEqKaxptJpq4gOvOg5eBI0jGsO+K6nmLbjsiwYjVIzLr5EN0/6IhN1LDHa2cqUMdytK+/i5RuSoiNYv1vK+bz4J4JZA5cIjHNoenBLfiDIqBFn2tCwuFysQZuzCaN5gIRhccbowPTYeIzECvt11a7qaaujT25eXFAd5Z3Ix17k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212863; c=relaxed/simple;
	bh=wcq3pSruoA/P6rYiyb4qAhk5mOlPo1eZFO/cRnU5/vg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=KL4yhdCOCsTvH0HPTq4ETfRh5GTINaq5N0HagKYl1ZKd47HtYI85iSOVHChFeMxr+tkZNXW2NM54+0RAdDoehD+JLW5NMklMtHIBytIxFgxa4uWU7yImpbilWDI3M9b1bSasCkEQsjljMJgaovpBXna/oNtaMTIEscbGJN5Ig2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glMJqLrs; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762212862; x=1793748862;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=wcq3pSruoA/P6rYiyb4qAhk5mOlPo1eZFO/cRnU5/vg=;
  b=glMJqLrsu4+Oabjagtutz0jbvacN+V7MvFooyu7E72kO+2XR2TNa+KHC
   oFOfSuCD/gs3wNnF/xm3oAT3QDOm4xad5+KSACpn6vX2Kkxebtr1pfA9I
   G08TYe3BAMyUfFlg1X/nhVp8qeZQxbFWIzQ0x/GXwWofinQqTB6q+sIJ1
   kmJp1sQR6bfgsQy2kRJwHOLkvV3o6flBruRfZ+K1UhVnhDkAGBuQfOd/j
   MKC466yxAghwgdKAfQOTs5w/Q0+sr7D6Vl3NZAm6JZtETui6FY9uFICNB
   ZzvrQ7Ln5SyLvZw5R2qeHj2940QG0U3fRha5wrzqyjBErgatwe4CoYNaA
   w==;
X-CSE-ConnectionGUID: fs8Yl0IbSqWlWTWuKW5n3Q==
X-CSE-MsgGUID: WmoHMeRIQ3q858yB4iGt2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64450897"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="64450897"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:34:21 -0800
X-CSE-ConnectionGUID: 4YClBvuEQAqb54ZmMmGi7g==
X-CSE-MsgGUID: 5Ia2qQbPQSGihQ1Ry/gmbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186676997"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:34:21 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:34:20 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 15:34:20 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 15:34:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f889l40o8aD1w+JKzUlHquR40G6teT+23bzhz8ISu9kfVpEEwtf3mnnR+yaicdrdq/Cwvwy0ak13fB/g6ZKiXtA9V3BxuMIlFNzJ/+nCIecOsYw7avCaTMHvLM8IOZNc3MZJeCs9WWhmN/DTxfHqHYUAAgYgykaroRSH3aMS7lq9aAHHf3svTVPAIBSJZtduFtDx5EDv7mIJksdA5vzFsxdtL/l63dkc/6S08HM8Fg7rgcFdedD09brQoj8zkynTt6froDrnxHNpwYwTabtUdlkel9i39zR1jpxP+GLCzNLYDn9j7FDvzt2o/s9TUVKbEWPJQJb6WCgbAij2iZw87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxIpVt76of/E7lYRRsdKyryTUgggPDFbBrXQjZAVICM=;
 b=t66ZzCiCljtJnWnzx5IqYQ5r7kotKcIYV99RpEz4zgECGM0G0huz+pixyU//QWc8+QpRfLOCKvL1uzn5QECjZuqpNPrIrRgRcivxE+KbzVR8kColtjCVYxkEHzJQW9g2q2oIdyp8kl5ORSLdqRJeroD0mSkEzQCrMhoIrN1lhI7K7AWLyaMK79Z9ld2kAgbXEmpn47L/k2gzvi4p2gwMobjke9XSVMVjGrHb0m3DXuD8f7yGsmJX6DhiyWQ1j8cv2EeH/unjmKditxmLafHKGL0cBG337LHdSmqcjWm3ZoXc2edbk1UjqlLCeAyVKRgJAUgwM4kRCEAKmsNIYlI0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4640.namprd11.prod.outlook.com (2603:10b6:806:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 23:34:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 23:34:16 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 3 Nov 2025 15:34:15 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Message-ID: <69093bf7d6ee_74f59100fe@dwillia2-mobl4.notmuch>
In-Reply-To: <20251030112055.00001fcb@huawei.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
 <20250919142237.418648-21-dan.j.williams@intel.com>
 <20251030112055.00001fcb@huawei.com>
Subject: Re: [RFC PATCH 20/27] coco/tdx-host: Add connect()/disconnect()
 handlers prototype
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4640:EE_
X-MS-Office365-Filtering-Correlation-Id: a5618578-2fa8-4426-b517-08de1b318122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjI2WWdZY2JCamc4OWMwVVRsWVNuc1l3WHBKakhVcUxrejZPVWRNUUZQNzZy?=
 =?utf-8?B?NWd0ODVROGFuTGJWOFZrZ244Z3hWNktNTFZTOUhCaW41UkRnakdNSFRPcmVX?=
 =?utf-8?B?cnFnaitsNnVvWEJ0VEUzUWwrdktMcmZOWHhpcHd0U2pRV0lxYXZQbElXRkkr?=
 =?utf-8?B?UHR3aHFtZDZnNCt0dW01ODVsWEQzSlp4RDlqeWZRbWdpeWNpT0JzUDQ5V0wx?=
 =?utf-8?B?YzN6NGg5N3NoMFZpL2M3d05WSWxOcDM3aWtXODZBd3JVUWV0OGVKNHQwTmRx?=
 =?utf-8?B?WXIyanpKR0hTNnBKaEhPNk5QZWFZWncyWVJpblMwTWpicnAwUDN1UEszcDUr?=
 =?utf-8?B?enZaYzkzQlBsaUYxb1JDd0FscXdwR1dqM3B4VFNZT0VVWC9RNFlqM1BBM2VT?=
 =?utf-8?B?Z1VBMGNmaWpVUUlmaWhzSlA3SDBEMFR2NWsvN2IzbVdSSjRnVHgvWlVvUUkz?=
 =?utf-8?B?R1Nsb2JYNSsycnRhc3huZGZyNHl0dmkxUlNvV053ZFo1RENSL2FlOEFKR0NH?=
 =?utf-8?B?SHE2RlBDc1gxeG83RERIR1QxSVZVV3BQd29iQWp5RmhtNk83MVZWOEpsZVpy?=
 =?utf-8?B?R0hBUVhVVnlrOGRFZFVqOHhhenZzWGVHWSsrTjVwTVQ4WU9ObHBLUjRweFZL?=
 =?utf-8?B?MWI2K0xJNnQ4NDdnTkxLTW9WTU9YLzFGZzF1UXBZSXpFSTdCYnpVSHlwOC9q?=
 =?utf-8?B?Uy96UFFvWXUwMUZPV2MzaWRpNU03b3I4MUlzR1ltMlltYVVSUXFEdElLQ1dY?=
 =?utf-8?B?OUlXQkxuanlSRHNRQXNvQ3hYS0wyUS91VDBJV1liTUQ3N3BsNTlMamtxdm5i?=
 =?utf-8?B?MitiOUw2WG1tZVl6eFpjeTl6VkE1U3VuR0hsV2ZXcit4OUJhamg5SUFKR3Nq?=
 =?utf-8?B?b3ZnZUlJM3U1RlhjVFRJWVJTTTVIT0ozZkhJUTBLdTZDdHVpUVhKaW9sczdl?=
 =?utf-8?B?MUtLSUozOXhRYlBEWGU1S0h2bGU0WEVlWEpYT3F2Ujl6OXNyUjBhTmw3OUpt?=
 =?utf-8?B?eEJ6U3lObVcyd0hUYUxPVFM5cGNJQk9GRERqSURJNnYvcDJZZ0dwSGJqb1VJ?=
 =?utf-8?B?emI3eHNxVW45NmUxYUZkOHQvSUFYTk93VGYrZUtFYjg1VGtmbDRqSnBlMExE?=
 =?utf-8?B?dTZWY3FncmlKN1Z1UzV1ZVRjL0YrbTJ5L2JRcTZ0Z0NIdTI3b09tOEpMRmVZ?=
 =?utf-8?B?aTBTQU9vbG5pd3VLQllCY1I5ME5kbWNJWkl2elRhSzZNQmdndnhLZlhJek84?=
 =?utf-8?B?b2Z3aXNGSmJTREVLR2pwTmJnVlE5VEpHa2E3emF5QXIrbkZNVTRCNEtzYzY2?=
 =?utf-8?B?Q3pXYnRCS0RUMjE3aG9Rakt5SmVPNlp6Wm0vN2gzZ3A5L3ZpbTdlQXB0MXpM?=
 =?utf-8?B?VmdKbC9LQ2tPa2J3YlBvVzdBMjl2cUJvVTZhbldNU3ZaK09GcExQeUlJVm9J?=
 =?utf-8?B?dGg0NUVIVy9hT3lVd3BHODNmaXVQUVMvbnRiajlueHpyRjRlNTV6NEZIWDhu?=
 =?utf-8?B?Vk5rejlNWGpiclZhL3NoeWVadlJ5RG5sZnhvM3NwWDBIMDVUaytUUy8zdTJK?=
 =?utf-8?B?WU9ZT0NTditzelVmQVhLL3FBdmU1NzN2aExzVzhCZVNtRFkveXlyWEVQZnlk?=
 =?utf-8?B?S1N6ZHdPUzhtR0xjckRrUUtoWW81ckR3NmNaaVU0RlZqSE1vY0lnTHdPTG9j?=
 =?utf-8?B?Q1p0NVRoeFdSRTN0bFpWTWQyZVNSSXducncrZmhtbEQrMXVqd1FGbHZMQk9R?=
 =?utf-8?B?M1BvQW1iUzVTUjZuRXVjbEJvb01zYWxTQytTT0x6L2hQdE1xSGRQb05SbFpS?=
 =?utf-8?B?aTRBVFBBZUxqbFJ5WDlpYjFVbTFMRXlma0FRYThSZ0FxMi9vYXQ5RkZudUI0?=
 =?utf-8?B?MjJCY0dPN1JNQzRGUHc0a0U1cXRHZUJCUEYwckJpOUVsdnMvb2VmUG44aVhJ?=
 =?utf-8?Q?DDyyoi/+0dfBt6DKtmHhfVHpdte92dip?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUxYdk52V0g0czBLTWFwSmo0OGpCWTFRNWlMVGtzdk5IVnA2VlpadDR3ZXhR?=
 =?utf-8?B?bHpINEZ3UitkZEQwWks3L0l1RUxPOERYeS9Jb05XT2VJV00wSlFnMkFSTUkv?=
 =?utf-8?B?ekw5UGZ1MmdzMnpsVmJQNE1KeEJyblJzd2dYZ0dDOCtodmtwdm1NRGZXK3Fl?=
 =?utf-8?B?djlPWmdwVkh5MFVhMGJrV1NRMG5iY1VtWVdsYXkzaFlMNmZhL0ZyU1RKTjNl?=
 =?utf-8?B?ZUJ2YmhGbXRWcWozMi8rQy9MemtrSUNVVkdSdXJJK3ZJYVZ5SFcxdnZ2MXBs?=
 =?utf-8?B?clljbzdPSVdZSTNWTGxMVkt1RjM4K0FzbERmNDVyeWU2T2dYQkpQbkxselpG?=
 =?utf-8?B?Q1ZQTVdOM1FzZzFPc29TMHZXTFpYMlJuanVsNm5yU3IzRFBXWkxKVSsxTlZp?=
 =?utf-8?B?eTd3US9raW1QMjg5SGdRMllGSW51UFE4bTZqM2JWR05kRXBEL3hRaVg0Z1RT?=
 =?utf-8?B?dmx6Wmc5Wmh2aHhVUnVpbmtlOGFIbWI3czZZeGQ5RUUxZWVDb0l0cHhRcEtL?=
 =?utf-8?B?SE9icGpKeGEvM25qWWpQT3JoUFVZc0tJRmZTWHVXSXQxaXdlMGVqbkE2dWtS?=
 =?utf-8?B?Sk4zc2haQ3lQa1FoZnBOcHMvNFAvTTRKV1FYNlBkd0RiVm1OS1dVWkpRdmJY?=
 =?utf-8?B?amxHeXRFdGQyQkJXL2FNNHpjT2Joam1YRDRUVnYzTGVnRm1meWorMXBKamZZ?=
 =?utf-8?B?VHJqV2c0Z2FIQ2dLYkVSalA1MzZEQ1BIRTliTGFERFZXWWY3bzZjQ0ttd09C?=
 =?utf-8?B?TEdnaG5sS1BnWThoSUlYMHdiUXovTnc2UWNuQnJza2ZxWmh1ck43WkV2L2hC?=
 =?utf-8?B?RjBBMUQ0WUZLUzVFQmJKV3JveTJpUm1tRzVxK3Y5L1NyZExrQjQ0WVNQWnJZ?=
 =?utf-8?B?VHVCRE9GRjJieGNwK24reFpWdFQxeGt0amNrODBKY1VGS0tQaElTUmwrUGZV?=
 =?utf-8?B?ZTkvdlV5S2lIV21VYitRenRtTUp0S0YveHIxc1lBTkI3UVlpYkdzMHZwZFMv?=
 =?utf-8?B?QS85YzZ2Y0JyQXo1RTF2YVNkbnExVkdXdkZvcysrYjV4dnNVSFVxQUpGdmNa?=
 =?utf-8?B?TW53M0FkcTRMR0RMK1FwWU1GZmlMWXF6Y0h1THczc0NxRzRHVmVMZFhCYXpF?=
 =?utf-8?B?SHJua0NPWThwWlVubStndlEzUE44YWdBSW0veUYyV0t1R2xCN2hFVUhmNmo5?=
 =?utf-8?B?RG05dTV1bFJ1UDlOaVZldmZKcTlDUVNGeS91QVU2NEFNUVJWdS9naE9VYmgz?=
 =?utf-8?B?aG5kUVlYSnJsVWtZMzc2cCs1Wll6WHBXRDBJRHVJVzROMmp6MGFNamJYK2FK?=
 =?utf-8?B?WXlreTZwM2JwRFBIS1MwbEo4enBIanhYZ0ltaE91elVuSXBzdDMxZFdqSlJH?=
 =?utf-8?B?S3lJQkVPbmJ5OVJONFkrd1UyVy9aK0c4b1R6YXRDQzQzUnR6SDF6VmVQZndo?=
 =?utf-8?B?SE14bGZCTmNCWi95bkNtMWNSR0tudm9hNmZ4aFZXR1BydGhuclk2K0ZSeXJF?=
 =?utf-8?B?eld0aVdnVXRpc0c4WEtqSTY4K29BdHl4c0MvMFVJZTJXQ29QSzZ5eE9xQ2JO?=
 =?utf-8?B?amZMQW9WWmszSWlTZzJBWjNPalV3NXB4WHh1TnFPZjhrelNjRG56dE9oWWE4?=
 =?utf-8?B?VVBpbWRMZVpCeFVqd0ttTjd6YW1IQi9aVEtBempZU1pMaldPbm5zT3FIRHBZ?=
 =?utf-8?B?bEZaOEVsd2o0a1haZlF3R3BqU01tejZrZ0xydXdBVys1WnBTRHBub1NTUXU4?=
 =?utf-8?B?b2U0V3dYNlVXejVLTkVOR1h0bGQzVlFLbjdVeTAxWkNpUHBZMFlhM3N4WnBC?=
 =?utf-8?B?SjVOSDJvZkJ5bkFhUUVWUHNBeGhVRXBXTGY2Y1l6MUNoZjVhTTd0R1B4T0Yy?=
 =?utf-8?B?RE5VZ0VsVjBpd2ZFbVRFTmcxYUZGTDdTZG5JdGJBVk5sS3lQYnl1ejEzdXZP?=
 =?utf-8?B?VTRQcU1nbmRjYjhSbW5md2YvNzdHZzZEZ2JaUEYwajJWZkdNcG5MdlROb2tW?=
 =?utf-8?B?MUZqL1N5YWdLWWtURmRMaHNLa2t2b1JhSzFDeWFLWko3b3lGSXhZYTJ5cE9O?=
 =?utf-8?B?SGdpVGVuQi81WHR5bitld0RiYkUvNUJjM1ptbGRTcGNMZDZhcFRiSmh4SS9o?=
 =?utf-8?B?VmZQUUtRZ01Zc1cwaVl2SmgydmtWM2MxQWpMejA5eTRqWitaK0U4Rzk0d2lQ?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5618578-2fa8-4426-b517-08de1b318122
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 23:34:16.8830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUxBnf7o0+L3yOL9PAreR3vTzTsq6QwJcc8mIq5mxL/yNi0u4XBxzfUPe1uTo+RDMg87LndJ3DU9piNyhApyHPlPUncLEI1xpPTOaBddJfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4640
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 19 Sep 2025 07:22:29 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > 
> > Add basic skeleton for connect()/disconnect() handlers. The major steps
> > are SPDM setup first and then IDE selective stream setup.
> > 
> > No detailed TDX Connect implementation.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Feels like use of __free() in here is inappropriate to me.
> 
> > ---
> >  drivers/virt/coco/tdx-host/tdx-host.c | 49 ++++++++++++++++++++++++++-
> >  1 file changed, 48 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> > index f5a869443b15..0d052a1acf62 100644
> > --- a/drivers/virt/coco/tdx-host/tdx-host.c
> > +++ b/drivers/virt/coco/tdx-host/tdx-host.c
> > @@ -104,13 +104,60 @@ static int __maybe_unused tdx_spdm_msg_exchange(struct tdx_link *tlink,
> >  	return ret;
> 
> > +
> > +static void __tdx_link_disconnect(struct tdx_link *tlink)
> > +{
> > +	tdx_ide_stream_teardown(tlink);
> > +	tdx_spdm_session_teardown(tlink);
> > +}
> > +
> > +DEFINE_FREE(__tdx_link_disconnect, struct tdx_link *, if (_T) __tdx_link_disconnect(_T))
> > +
> >  static int tdx_link_connect(struct pci_dev *pdev)
> >  {
> > -	return -ENXIO;
> > +	struct tdx_link *tlink = to_tdx_link(pdev->tsm);
> > +	int ret;
> > +
> > +	struct tdx_link *__tlink __free(__tdx_link_disconnect) = tlink;
> I'm not a fan on an ownership pass like this just for purposes of cleaning up.

Yeah this needs a rethink. The session and the stream are independent
resources. It can be a composite object that encapsulates both
resources, but not tlink directly.

...chalk this up to RFC expediency.

> I'd be a bit happier if you could make it
> 	struct tdx_link *tlink __free(__tdx_link_disconnect) = to_tdx_link(pdev->dsm);
> 
> but I still don't really like it.  I think I'd just not use __free and stick
> to traditional cleanup in via a goto. 

I would not go that far, but certainly I can see that being preferable
than reusing the existing base 'struct tdx_link *' as the cleanup
variable.

