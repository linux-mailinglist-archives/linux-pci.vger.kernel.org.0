Return-Path: <linux-pci+bounces-22233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E92A42718
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03243BC598
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E862B261378;
	Mon, 24 Feb 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a7aQeM4g"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9442586E8;
	Mon, 24 Feb 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412284; cv=fail; b=SCj4VY8Dh2htDq0wrkORSzQwkMvNkoZvig3cZOrRN7vx1GDfmBdCQWRWfFKheAufbz77A4OLfu0tqKVSAGVvqpc97MI/1//P74p7K94OPXabhTchJQdI0nX5UudunihQ5IPvm3f1pkkAY4A4BlBNhQ8CA4GYiD1KV65oULi/01A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412284; c=relaxed/simple;
	bh=rXDEJb0p6tygxGLBWTMpfKvdDsYuk1+08/oFj4bl+yw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MMTg7Ph8bix24e3AfIFfZAOlADIffcP/9odLC0assyWesr05JY5KA03iIxPoU9yvykzXbW845HuMw2KWQT12jewmeXChjdQ8eoNJNnvvwnUkfXNmW0rF3c7hL64+xespiQv7+gANF55XkU3IESmvPTyZh9dW1KCYDCS9w8tbJHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a7aQeM4g; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jScxGZHcBgRtXuGMkPC7ffoI16V244m9mYdt8jW5GydcYVWTgQ4W7q4Bqrx13km5BA3gVmFgvf7/rSjzIJEy1v8iKQGZaALlzmsFp2kJs/PWbmqAqENo88L1cC5XbkmHIZmodroKZqQqHCEyPrqY8q4nhsxINv2mdFGXCpLN0Er/vjoxy/wzE97NPcKrCEM7Vo1WvBSYXvY9tsRrQNYwM8CoR0mk9SQ+Xs/uT5i5IQ+d8aVrKN3wYKfL9VBiWWf+YOzydTYwBXg04BLmAa6n1xHowu+iVdGYI+3eAmXCDmNfnCROZiZZnxq0rms+S1uGIeIMiqVDhSCkQEtRIQ0RPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXDEJb0p6tygxGLBWTMpfKvdDsYuk1+08/oFj4bl+yw=;
 b=tYmk54uTNJjcWAuzhqTJgnSuowxeOemDHbQDo6tI3QhCuqXyqOoeJ6DTPxg+t9myd+f6o3Cfi7nBsaDl03WsPefDGCIDRjj135iKePuUA2JGS+5femw5Y+lTtXsXNzQhPqxbYHIbP2VU2thkYwMgyZ4zreE5EA8wLO/J6TW2uqjrNYot9FbD9pNKwe8sJKfvAQPwwMFgKLJSZxWa58ywU9EI60JrukSU9APZ9hkE5Dpe15L7efmV9QtfKEX7PmcE9OEwxewY+r1BYuwDhLVxsU6FKfAQjc86DtJD2aU0jkpD0ldkiMPbCemV3UsP6JpNSdfZCFINY4wdxxh8qa1/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXDEJb0p6tygxGLBWTMpfKvdDsYuk1+08/oFj4bl+yw=;
 b=a7aQeM4gEn3id8TFUqnGWZWQhtxyOre2YMUxaCrONEjtYnTmJyjf4snptKsr8dNx3dN0gYLTaRBixO8shXN1nY1pPOXZMd/8z+7LFks0voXjhQ37othNM9NNOrdwPGgWTM3L0pZLZgyANnRXK3Aj8LFOdUrtOT/1zkMev34uJNw=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 15:51:15 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 15:51:15 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal Net CPM5NC
 Root Port controller
Thread-Topic: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal Net
 CPM5NC Root Port controller
Thread-Index: AQHbho+bOvyIQPF4WUK3tb5hxErFp7NWGPYAgACBngA=
Date: Mon, 24 Feb 2025 15:51:14 +0000
Message-ID:
 <SN7PR12MB7201DD2E33A18770C04DCDDC8BC02@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250224074143.767442-1-thippeswamy.havalige@amd.com>
 <20250224074143.767442-3-thippeswamy.havalige@amd.com>
 <20250224080644.ldgltonirrtfzrgp@thinkpad>
In-Reply-To: <20250224080644.ldgltonirrtfzrgp@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d9ef7113-7336-4730-9590-ce0e3eaa0154;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-24T15:50:38Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DS0PR12MB7827:EE_
x-ms-office365-filtering-correlation-id: acf06a96-e584-42bc-6638-08dd54eb11d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZjJ6eUNQUlYyQWhVMjRYb2RNSVFobVNlK3lRRXZuNDhSdEt2MUkxT3dzdjNI?=
 =?utf-8?B?YUZIYmd1c0xSdTZwcTczTXRicUpaaGhLVFQwTm11cGtkR2xYVXUzOGxxcXpE?=
 =?utf-8?B?bnZTUmZsQjdkYk0vOXpvZ0laUERIN1N1S0VYT1dPTzlacFMxVmJDbXkyOUVs?=
 =?utf-8?B?Ui95SENEeHFZTHdNbDQ1UWs0S1lKQnJNc1RVTjQwdVBxRUUzQ0l3Z2VUeThx?=
 =?utf-8?B?b3Q5cFBaY2g0d205engwTThwUEpQcDZiWmhpN0gxTVRBNUpyZ0R4UWdUMk9w?=
 =?utf-8?B?cjNSY0tuU2dDc3M3a1gyVGl2RENxM0hTdGFVemtOOHhydnJZRlBuWGYxSGk2?=
 =?utf-8?B?NGJZRmY4RXpQSGxKL0hmS1ZyclAzQkZIUnBzbWtacUNWakVvMEJCeWZldVQw?=
 =?utf-8?B?bHl3RmYzOG1laGhRVWgya2s3L0piYmNVNXF3dnVTVEpRenFFV3FQbnJGdTN4?=
 =?utf-8?B?dUhKM09qbm9RTC9PcnJUdERPSmYxUFhTQm80a2Z2dDZuZHQ2N0R2RkVyTVAx?=
 =?utf-8?B?N2tsZTZHSk1Xc3d0Y3NrbUdyNlM3ekJ4VERzNDNIVHloM2VsazZDTjVkeG5Z?=
 =?utf-8?B?MUpkYjE1Vkw1UUZwY2gzQ0tZVU1IVEdUdk9zcndycTh1Wm01bHppRDBSQVRm?=
 =?utf-8?B?RzBwRTRKNEtLMXlwNTh1OVJjZFNHdmt6aWphU2hRVUhTdk5iVjhLcFlBRlE2?=
 =?utf-8?B?V280Z0NQZmJhSStHcHRmc1loL3ZlM0ZYOWRYYi9zckdpTTFKckprWk8rQU1u?=
 =?utf-8?B?OGpCclF3QUJNcTVxRmhvSUhYNkZ1bUxSV1VzY0M2VzVQNFZhbFlrcVdsVmFD?=
 =?utf-8?B?M2RLWXRVWWMvOW1nc25DYTR2a0Ivdm9XM2NKN1RCSW9kMS9iZVNYWjAza0l3?=
 =?utf-8?B?bzRSYVFrMjVMeldEUEtzR3V6YUlGOWMvbTFiWlJXY0R4UDhaYmt6c1lEdzVp?=
 =?utf-8?B?YnUrU0Y5dUpnRmg3NHoyYzh5NDBhKzQ1VTQyZVUwdWRDcExnMndrS3JiNDNn?=
 =?utf-8?B?Z3g4V20xNmQ0N3ZhNlpnWG9aUmdsUGF6WEh1MUJua0ZySEQ3b0hPd3dtMW5P?=
 =?utf-8?B?NlF4dWlJc1RqV3JQOUZrRzlRNGQyb2ZWOGx4OTMrb2NXWVBaOWF6TThyalJL?=
 =?utf-8?B?N21FUHgrZmFUaVJaUnYwYndVdGp4YlkxanF4ZWlFVWxYc2tQQnBQcmozUnVS?=
 =?utf-8?B?MXJNYm5rTjlyTCtjVmZkV2hPMUUyNHYzTkFmY1dic25OZWJTRXZZTDMvWkhU?=
 =?utf-8?B?NzdIZkdSaC84Y09EdmZiYXNIM2FVU1RxMG02Y2w4N29VeHZKMm91REhTZjFl?=
 =?utf-8?B?YlR0UWNyRTdWc2NXcmxnT3V6ZmtLQ01MSEZjVzdPamt4ZzI2UjdWNGFxSitJ?=
 =?utf-8?B?OWF0bnloYS9LMmcrVnBCQ1Y0UlRISENyKytiS1N3dzBvbmUzZWk3dHh1V3ZR?=
 =?utf-8?B?WUZYcTJMSyt2eFFFYis0M2FMeUt2eWVMM0RLa1pMOThmYlNnbGhldnB6Ukxr?=
 =?utf-8?B?RDJzUlpSVjlScDhTWm9JdVdBUElnL1VldTI0eHFKK1NmWi9KS1NKUG1La2ZP?=
 =?utf-8?B?ajJpSElmc3FhaTNobmo5bEQzc1RicGh1UUNtenRicjc1QUhCRGV6WFUxWE1v?=
 =?utf-8?B?TGR4aHdIMGdubTlOK0UxQnBkYVVUamk3SjB3dktCamNzMEd6TFV1MmxXM2hu?=
 =?utf-8?B?L2VNMmM2c0RIMVUvNVRrVTRMUDI3NUFnUE9OVlFzTGdRbHgramJVVTBRMlpV?=
 =?utf-8?B?RkRFZ1daRHNYOGQxNHZrejg1K1l6QjJ5WVNLTDEyVUpZeUdPeDdXNVFKVERy?=
 =?utf-8?B?OGxGdFNadTNQU0Z4Q0RSZkViTVVDSWJBS24yWG1laGJBRTd2aUFKUzdWekc3?=
 =?utf-8?B?OFd0VnBTTUZsZVZ2Ync2aUx0TFdnWW5PaFpXMUl0OXl3bWZzQWdSVEVDTWtm?=
 =?utf-8?Q?EgHiMhJ6p2pp18pHoIQeqvOiEmzdUcZC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTBOUzFCNGJSOTVkSThsd0xkV1p6dktFeXRVUDNnOHJnTlNTOUxPRlZoVENt?=
 =?utf-8?B?WFRNdks0RkJIQmZ4V1JBdGhOVHBWWkNlMnZnUzVaZ3g2NVZ0eklzZUhsTlE2?=
 =?utf-8?B?SnV0MEZUcmJ0eVR4SHFOZkxEcDM3MHMzNTlqRWo3OGJaQy9WRjR6UlNOWk1W?=
 =?utf-8?B?THJOazg2RU1Yc3BoVjFUbm5pb0F2SThoZVhoUFB0c2F2WDZXU0ZjTTI4d25m?=
 =?utf-8?B?QUtncFlEWW11UXluM3R3Yko2NThXK0Y3OURrdEt5WTJ1WmZieXZPenVqb1kv?=
 =?utf-8?B?d0ZYcE01RVpvRzRja29aSGE2SFEwb0k3ZnJVZHA1NkdyRU10Kzc1WDNrbFJC?=
 =?utf-8?B?UkYyQzRSVU9uQWd2WUVsa0tiSVh5eXRsd2lDUVk0MitkemZNSU9LaDVBTjhr?=
 =?utf-8?B?RVM2S1h0ZzhNRmNIUFdVRW01OWFhK0NiQnh4Y1BjNHltRG1kZ3czZDFCSUw4?=
 =?utf-8?B?SXMyY3Bic25sZGlCajk4RktvQjJ6NHBrZ25MaG9RdUxXSXpPMXlPVXhsaFNk?=
 =?utf-8?B?ZHoxUFUxdnhKaFJFV2hETVdJeGo4THppWVFEemhwUEM0dXhDWW5Pa2NFSEdV?=
 =?utf-8?B?UTdieGVNSUlKSVdXbjVwMkN2R2dRQTcxbXhGZ0ZEVzB0YTBKMjBrKzRkaG5m?=
 =?utf-8?B?ajR0K2VWdk1HWklaMGtnSjRhaXRJanRSY1RiMStoOExadjZjQmMyV0EwTDJy?=
 =?utf-8?B?aUxkcVZ6aVI1N01uV2xnQ0x5UnVCSUVVN2NTWEZYWkhOVXlEaitXSy9rQ2ZC?=
 =?utf-8?B?R2FPNXV6YmZTSUJsNVdtWnFNYXdNNGZLMkd3c0M1VUtNcHdzamxzaVhZenZr?=
 =?utf-8?B?WGV5czdiaS9Za0x1bzF6K2QveFd6dGsvelhQcE9aeUtraHhuc2F3a0RJNlo1?=
 =?utf-8?B?ZGpjQzhxSmpDODhsTVJPb2hrZHdvcWJ1UkZqY3VsSEF6SkQ3bWFRZUplVnJk?=
 =?utf-8?B?MUhSb2Jqa1BURHJ5WWtjdUc1Vm53MDJtK0EyQ2JGQ1dlVmdQNE8vS05YVVBN?=
 =?utf-8?B?YlJCY1FHcllNT1ViVUVXeVlJNG56SFViNE9LaDhmVEVWUkk4RjZuaVQ1bGVH?=
 =?utf-8?B?OWQ1ZVdOVGJ2OHlCOFY1QmJlbXBLMVppZWFIMERMSzVzOEduaXhlUzRVdjBZ?=
 =?utf-8?B?ZkZhSTlrNGwrVjlxZzNLZEloZ3RmU1F5eXdiUFFMRkliYUgxTGZYWERWT2VX?=
 =?utf-8?B?d0JDRXBYc3gvT2hSKytFM0QvZWFBVGJ1bmFLYkJWTzh2bnVlRmNkbXM4Zk5T?=
 =?utf-8?B?ak4xaGVZMWpkR3Byc3lzNUpIdmN2b1ByM2ZmbVJJcVZDQTJJYjl3RGdQbU9i?=
 =?utf-8?B?dy9JdTJNSXJQdDRQQUJkSDBzd2YvcFBuSllCYTA0WjlGbys3NGNwcnZ0UjNs?=
 =?utf-8?B?SFhsOTNIazZMaG0rUFlNMzJuQUZjYmRaelRTakErY05tMHpWdU9Od0s5d3A3?=
 =?utf-8?B?QzJlTTFHQWNNTXYwYTczNUgra0crZFVkc0hzeXg4MXRkcHQ2Y3YxZ2hWL1Iz?=
 =?utf-8?B?WGVESkRHNW5uWGpod3hUMXovdkZmY2xxN29jSkhKMXk1YXMwc2YzcXhZVXFm?=
 =?utf-8?B?RlhjS3A3WXhzWVRuSmovcVlONGtRV3Nhdk9heTVkT0pXTWE4WHJwVXFuRnox?=
 =?utf-8?B?OVZhV0FrdGpTUk5XczcydTZOS25PbGR1ZVFTWnlWeDFmSXNMdFJBdEtQcU1W?=
 =?utf-8?B?YkVJVS9uKzZlZ2xKWTlrWVZRVWFnT3ovT0gwbzZ5U29leGtTbTZNMytTKzFi?=
 =?utf-8?B?Rjh3bFhadWpsZEZGMEx0bUE1K2pqM2x5dWROekdMbzRMaDF1dFJVSTFyT1Qy?=
 =?utf-8?B?ZEJkb2p1K3ZpK3RMUE5leUVVLzlacFFGYW1IeUFwMVBSV3pTNXRRUFF6RVA2?=
 =?utf-8?B?UkxhaXRaMmV6RkdTcUN1TGFKeWlnQ1lIeXFqQWdsbnQ0d1JvLzNaUGtuZjBV?=
 =?utf-8?B?ekpJQ3JPT2Y2bEhyMXAzTllVMDVobWRLVDFheVlxdXZxVitXczhZdUZsdk9n?=
 =?utf-8?B?bEVrQ2lQUzRqa0NuazlSU2t2NU52LzV4dkl3UVZQOHNhcEdJSlhIdVJuUlhr?=
 =?utf-8?B?MTlxTEV0WDBibXZHQllhOWhoKzQxeERmbXZOTzFrMnoyL0FwZ3Nmd1BHc2ZR?=
 =?utf-8?Q?fb3E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf06a96-e584-42bc-6638-08dd54eb11d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 15:51:14.9405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gH5VNSX9PSCEm2E6qnGGMwRytuSVzE0l8HCoQCepbxjE/2fI4RaKTRdjElOouLaf4FMaNJvcGPlKiMYlmnv9kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KVGhhbmtzIGZvciByZXZpZXdpbmcsIEkgaGF2ZSB1cGRhdGVkIGFuZCBzZW50IGxhdGVzdCBw
YXRjaA0KV2l0aCBiZWxvdyByZXZpZXcgY29tbWVudC4NCg0KUmVnYXJkcywNClRoaXBwZXN3YW15
IEgNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNh
ZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25k
YXksIEZlYnJ1YXJ5IDI0LCAyMDI1IDE6MzcgUE0NCj4gVG86IEhhdmFsaWdlLCBUaGlwcGVzd2Ft
eSA8dGhpcHBlc3dhbXkuaGF2YWxpZ2VAYW1kLmNvbT4NCj4gQ2M6IGJoZWxnYWFzQGdvb2dsZS5j
b207IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOw0KPiByb2JoQGtlcm5lbC5v
cmc7IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsgbGludXgtDQo+IHBj
aUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5j
b20+OyBHb2dhZGEsDQo+IEJoYXJhdCBLdW1hciA8YmhhcmF0Lmt1bWFyLmdvZ2FkYUBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIvMl0gUENJOiB4aWxpbngtY3BtOiBBZGQgc3Vw
cG9ydCBmb3IgVmVyc2FsIE5ldA0KPiBDUE01TkMgUm9vdCBQb3J0IGNvbnRyb2xsZXINCj4NCj4g
T24gTW9uLCBGZWIgMjQsIDIwMjUgYXQgMDE6MTE6NDNQTSArMDUzMCwgVGhpcHBlc3dhbXkgSGF2
YWxpZ2Ugd3JvdGU6DQo+ID4gVGhlIFZlcnNhbCBOZXQgQUNBUCAoQWRhcHRpdmUgQ29tcHV0ZSBB
Y2NlbGVyYXRpb24gUGxhdGZvcm0pIGRldmljZXMNCj4gPiBpbmNvcnBvcmF0ZSB0aGUgQ29oZXJl
bmN5IGFuZCBQQ0llIEdlbjUgTW9kdWxlLCBzcGVjaWZpY2FsbHkgdGhlDQo+ID4gTmV4dC1HZW5l
cmF0aW9uIENvbXBhY3QgTW9kdWxlIChDUE01TkMpLg0KPiA+DQo+ID4gVGhlIGludGVncmF0ZWQg
Q1BNNU5DIGJsb2NrLCBhbG9uZyB3aXRoIHRoZSBidWlsdC1pbiBicmlkZ2UsIGNhbg0KPiA+IGZ1
bmN0aW9uIGFzIGEgUENJZSBSb290IFBvcnQgJiBzdXBwb3J0cyB0aGUgUENJZSBHZW41IHByb3Rv
Y29sIHdpdGgNCj4gPiBkYXRhIHRyYW5zZmVyIHJhdGVzIG9mIHVwIHRvIDMyIEdUL3MsIGNhcGFi
bGUgb2Ygc3VwcG9ydGluZyB1cCB0byBhDQo+ID4geDE2IGxhbmUtd2lkdGggY29uZmlndXJhdGlv
bi4NCj4gPg0KPiA+IEJyaWRnZSBlcnJvcnMgYXJlIG1hbmFnZWQgdXNpbmcgYSBzcGVjaWZpYyBp
bnRlcnJ1cHQgbGluZSBkZXNpZ25lZCBmb3INCj4gPiBDUE01Ti4gSU5UeCBpbnRlcnJ1cHQgc3Vw
cG9ydCBpcyBub3QgYXZhaWxhYmxlLg0KPiA+DQo+ID4gQ3VycmVudGx5IGluIHRoaXMgY29tbWl0
IHBsYXRmb3JtIHNwZWNpZmljIEJyaWRnZSBlcnJvcnMgc3VwcG9ydCBpcw0KPiA+IG5vdCBhZGRl
ZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRoaXBwZXN3YW15IEhhdmFsaWdlIDx0aGlwcGVz
d2FteS5oYXZhbGlnZUBhbWQuY29tPg0KPg0KPiBSZXZpZXdlZC1ieTogTWFuaXZhbm5hbiBTYWRo
YXNpdmFtDQo+IDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4NCj4gT25lIGNv
bW1lbnQgYmVsb3cgd2hpY2ggaXMgbm90IHJlbGF0ZWQgdG8gKnRoaXMqIHBhdGNoLCBidXQgc2hv
dWxkIGJlIGZpeGVkDQo+IHNlcGFyYXRlbHkgKGlkZWFsbHkgYmVmb3JlIHRoaXMgcGF0Y2gpLg0K
Pg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBVcGRhdGUgY29tbWl0IG1lc3Nh
Z2UuDQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiAtIEFkZHJlc3MgcmV2aWV3IGNvbW1lbnRzLg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LWNwbS5jIHwg
NDANCj4gPiArKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI5
IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxpbngtY3BtLmMNCj4gPiBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS14aWxpbngtY3BtLmMNCj4gPiBpbmRleCA4MWU4YmZhZTUzZDAuLmEw
ODE1YzUwMTBkOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUt
eGlsaW54LWNwbS5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXhpbGlu
eC1jcG0uYw0KPiA+IEBAIC04NCw2ICs4NCw3IEBAIGVudW0geGlsaW54X2NwbV92ZXJzaW9uIHsN
Cj4gPiAgICAgQ1BNLA0KPiA+ICAgICBDUE01LA0KPiA+ICAgICBDUE01X0hPU1QxLA0KPiA+ICsg
ICBDUE01TkNfSE9TVCwNCj4gPiAgfTsNCj4gPg0KPiA+ICAvKioNCj4gPiBAQCAtNDc4LDYgKzQ3
OSw5IEBAIHN0YXRpYyB2b2lkIHhpbGlueF9jcG1fcGNpZV9pbml0X3BvcnQoc3RydWN0DQo+ID4g
eGlsaW54X2NwbV9wY2llICpwb3J0KSAgew0KPiA+ICAgICBjb25zdCBzdHJ1Y3QgeGlsaW54X2Nw
bV92YXJpYW50ICp2YXJpYW50ID0gcG9ydC0+dmFyaWFudDsNCj4gPg0KPiA+ICsgICBpZiAodmFy
aWFudC0+dmVyc2lvbiAhPSBDUE01TkNfSE9TVCkNCj4gPiArICAgICAgICAgICByZXR1cm47DQo+
ID4gKw0KPiA+ICAgICBpZiAoY3BtX3BjaWVfbGlua191cChwb3J0KSkNCj4gPiAgICAgICAgICAg
ICBkZXZfaW5mbyhwb3J0LT5kZXYsICJQQ0llIExpbmsgaXMgVVBcbiIpOw0KPiA+ICAgICBlbHNl
DQo+ID4gQEAgLTU3OCwxNiArNTgyLDE4IEBAIHN0YXRpYyBpbnQgeGlsaW54X2NwbV9wY2llX3By
b2JlKHN0cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPg0KPiA+ICAgICBwb3J0
LT5kZXYgPSBkZXY7DQo+ID4NCj4gPiAtICAgZXJyID0geGlsaW54X2NwbV9wY2llX2luaXRfaXJx
X2RvbWFpbihwb3J0KTsNCj4gPiAtICAgaWYgKGVycikNCj4gPiAtICAgICAgICAgICByZXR1cm4g
ZXJyOw0KPiA+ICsgICBwb3J0LT52YXJpYW50ID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRl
dik7DQo+ID4gKw0KPiA+ICsgICBpZiAocG9ydC0+dmFyaWFudC0+dmVyc2lvbiAhPSBDUE01TkNf
SE9TVCkgew0KPiA+ICsgICAgICAgICAgIGVyciA9IHhpbGlueF9jcG1fcGNpZV9pbml0X2lycV9k
b21haW4ocG9ydCk7DQo+ID4gKyAgICAgICAgICAgaWYgKGVycikNCj4gPiArICAgICAgICAgICAg
ICAgICAgIHJldHVybiBlcnI7DQo+ID4gKyAgIH0NCj4gPg0KPiA+ICAgICBidXMgPSByZXNvdXJj
ZV9saXN0X2ZpcnN0X3R5cGUoJmJyaWRnZS0+d2luZG93cywgSU9SRVNPVVJDRV9CVVMpOw0KPiA+
ICAgICBpZiAoIWJ1cykNCj4gPiAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4NCj4gSGVy
ZSwgeGlsaW54X2NwbV9mcmVlX2lycV9kb21haW5zKCkgc2hvdWxkIGJlIGNhbGxlZCBpbiB0aGUg
ZXJyb3IgcGF0aC4NCj4NCj4gLSBNYW5pDQo+DQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCu
o+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

