Return-Path: <linux-pci+bounces-18510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18409F3316
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 15:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EE21693CB
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9AF20628C;
	Mon, 16 Dec 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RwqwjQb4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D683206268
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358808; cv=fail; b=nzjPO62iGEV54dG4F1EZIP46B8X6xbLb+qdd9nNwD2lehJdJrF9EfTbZFzppuUIJQUhL46RMqG2Om/78hvsinLCl5vsTJ8GwK3S5FIyT9HVH6bH479mi3Keuu/sfXR4OA5eTydB98t34o2GAqI+oiXNYtgjMgoe7j7NQmRaF1DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358808; c=relaxed/simple;
	bh=10xqq2DK9JhCJununRDTUw9ZB4v4mLFx5dI5Pjq3GX0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T3mV0PplyX/mzQVo/iMcaxaEbzDHbDJfZaiHpEO5b0h67tiVThqHhJxCDsG+g9NzuWiWqd4jXHmryQwyBck3D/6g1SFSOozqO8b40c8acelk5wwXtG4WX7EwuWFQzOQ0gLTk2YMVx6pb3erx4OvC0c/BuLh+zKCehJ/YOo9gc2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RwqwjQb4; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+BQTzNc52HvLN25KPBASq4m4dT/1HnG7Z8kfDQnZYc/993QzaX5pe0F93l5qk1/17a+J575aSKxLuA4+bozO8quvkE0a/9GoZYIdi1qsdrcKmR3L4TLwNUZ+tNrwKk+FDE1t93hpSAPSTrc3BuK6p1pYWBewO5/LBA3wxTeNDHsWZSLg83b/t225CraaHRUiXp5lgbq9UBnadpeZf5nKttUI97kNp+a0/Knhq/sAda/sQ3Y+uPosfy5KSEOAYb1Zff8G5O9TmZTLlo0QZ5a+ZC556m/12Oh1zVjRXMsLUThK03FgAvTINdio+x297ZaHM6VrLz2cliS6ckbuwanPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjKZJyWABJykB3y3xVsfnpillInKDa1vlBuv2ngj9zU=;
 b=S2hIt4DQ78IAfutsGKSqWsZ8i4kFhfenNNLjIpOe6NivJ1Em99RcOas+Wk05mrvYBREWCoUoMgRWYi62VyE75QOMnrJUwJqhOzestujJqq6r1tEWC0YGUwo9hGhCTuq4MQ9Xq4nrDCHGpj9CRb1vvSOIkW3P85gD8XL4PN+wS8Kx238Davm06W0alJw6JjQX2+g7y1JOV74eEN5yAT4Jt7XrEa81USgWJ5rKyPE2evRQ3uSPIIst9XoY68trIv5B3vME2HmUEL66ik7/iQ4S7ywMCy7kSrXkE8+MZ3tfkhJsVtJjGxOBoMhpMj0NpX59A0zkOVzNJBy6I11gLAFsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjKZJyWABJykB3y3xVsfnpillInKDa1vlBuv2ngj9zU=;
 b=RwqwjQb4z/Dh3tc+0HGujcBlOL6CO+sBPdolHCSd9F6o4r4pl6L4YcHBeWNwGZ5icpPZa0I2fKHUGgH4ITG3c8oI54a79SZLrvu84TwN5EZbb6OdmF83CL0zl+TjnIgyUSCsSSDrGCi5386k4P3ikNpJdB/Xiwu7PtcXP3i7kyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Mon, 16 Dec
 2024 14:20:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:20:04 +0000
Message-ID: <9ab76c49-885e-4688-9ab5-4a6b657e6ba5@amd.com>
Date: Mon, 16 Dec 2024 08:20:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-linus v2 3/3] PCI/bwctrl: Enable only if more than one
 speed is supported
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 Niklas Schnelle <niks@kernel.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <cover.1734257330.git.lukas@wunner.de>
 <2292e75dcf26f1c6d7c1f715edfe0e49f079149d.1734257330.git.lukas@wunner.de>
 <20241216113222.000033a4@huawei.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241216113222.000033a4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:806:122::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 0977f8c6-4e1b-49ac-bfe1-08dd1ddcbbec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkcrYVhHRnpkemhrU1JSUncrY1dJNHltUmc3MWdMTzdTZHpVVUJjcW5VZXdJ?=
 =?utf-8?B?RUpXVE9XeVAyeEk2aTZjS0dlcWpnK0h0aDFTdUNzSi9JQU9oUVl5VkMxOUd2?=
 =?utf-8?B?eGY1Vjk0VVcrSWZxY0VjTGs2L3lsZVBDcmpSR2dTMUs0SWU5bmtZM3cxOTN5?=
 =?utf-8?B?Unl1Mms1NWNTK3lvYThBNGZBWWFSaEJPWEZiUDU3NkFHVXVDV2ZSZ2JQTk1q?=
 =?utf-8?B?R0lFbW1LSGtkd0VwMGdRbjc0VVo2R3VqNkhrUWw4aENUM1VNVzNSRUZ0akRr?=
 =?utf-8?B?VmVKSlJoclV4ckU1Z05DOEtJSjdDSmtUbjc4ZDQ5V0lCWTZCZTBJNWxJaGI3?=
 =?utf-8?B?V3g4dWtVdXRsQVhnajdlVGhoTjBEczB6dlRSN3RmbGlqdE53MGZjRTFDM2E3?=
 =?utf-8?B?VXY2NXF5UnI2RHd3SXo5cGtTaEdPbnlReHpTS2VycW9kNmNPODQxQ2RkelVw?=
 =?utf-8?B?SG43eVMwNzZ5QUdtQkduSFE3SU9sWWN1OVBVTWFFV1NsdHpmNE9BWFlxZ3Vl?=
 =?utf-8?B?UHhUZUtZZWRqbFF3QlpyMjAxY00zR1lwRjlZTHV3Y1RoZjYwam1zelZGd0cz?=
 =?utf-8?B?b0JPNlNIcTRBWXVqUXFpajlxNDBwUXlwSmRNODRsaUFCOC92bHV4aG5xTXMx?=
 =?utf-8?B?d1ZsWmZBU0NuODZPNWpSSmNZWUpVam5Od1k3UXBxeXpwL2tMRitHMGtVTTBN?=
 =?utf-8?B?ek5FTW9NOXZndkhhQTN0cHpaeng5aFQwaHd5R1FadGF5YlZGd0M2ZWJDSUVv?=
 =?utf-8?B?T3R5Q3VKaEpGNlpzWllxamFiREtNQWhMRHgxSndCdGhuUlJxemJUWHJiYTRL?=
 =?utf-8?B?MUd2Rm50ZVZHRVU1dUg3MHgyRUZRK3ptdXZ2bkh6dk9WdDIxbGZoOWNkQkVR?=
 =?utf-8?B?SXlDVXR6UE5JYnRldWM1ZDkyN28xRExuRlJFUnJNb3pLandtSW1hSVNiOXU3?=
 =?utf-8?B?SmczVzE5QXVMT0ZnTWE3am5uWURuUVJSaVUwa3BrM3N6SjRSSGRZN0RObmdE?=
 =?utf-8?B?MmpmZVpQU1ppR0h0M1U1Rk5QQll3NHNtdmtLcHZLV0VlQ2JhZ1hVOWxaa0lE?=
 =?utf-8?B?K2dpTXcrMnQ1MkNVVGltUllqeDIzRXRPZlYrYzVXYzQ1Z2lPNFNJY2xrZlNa?=
 =?utf-8?B?eDZyQ0ZGb25mWktOMkdDZVRrNmdQaWlMeFVrYU1ERXh4T3F1dkEvRDRnL3Zn?=
 =?utf-8?B?azdzZlhxYVhxUGVoL1hxdnpwZnR5TURiazlPcjJpQXJCY2NpU2NNQWdiSmhi?=
 =?utf-8?B?SENGc1RnSWFjdGwxUVBJbzgxN2Ric0xoeVE3N0JaMzN0cHM0UzJLTlhLZndr?=
 =?utf-8?B?NmVuYzhDMWFNN1RxWWtXWktoL3pCdmoxK3VUcW5nMGxKM3VsSXlhc2sxY1Jk?=
 =?utf-8?B?ZW1DYzNwSjgrc1ZzM0I0OEZBTzZNQXF1L0FvdlZTaEVrSmUvajBEN0FpNnZp?=
 =?utf-8?B?U3FHU3NWMzh5bndEUnN2ZzEzclNHNXVMK3pZRE81U01lV2NvenJGVEhjM2Zu?=
 =?utf-8?B?R1QyclJxV3hLNWlHWldIUXVNL25QVmk4SmJ3eXF1YkdmT1ZBeExQbjEreDUx?=
 =?utf-8?B?TlBFTWxHY3ZTaUtIMjBROTdHSXB1M0tBSUE0M241cUZZNnB4YW54R2IwR214?=
 =?utf-8?B?UmZMR0ZISldINWlXbVVwMnhtbS9DTVp0QU5JemtoQzJ1cVdZcXIzUjZBcVI3?=
 =?utf-8?B?eFNKYWxVa2NhaWk2V3JpUXBxUTMzc082ZGFBNzZ6b2dxdXRzOUJPNEhXZldP?=
 =?utf-8?B?eDZ1SVNndEd5N0d1RzByQnNyM2ovMU8vS0ZJaG54ZGZpSmZOWkNsTnI0elFV?=
 =?utf-8?B?L3hKcS9panloQ1hweStzYnpvcnAxM2o3Q1JaTzR0N3BDY3BlQ0Zxck03d2pD?=
 =?utf-8?Q?pzgpYjxd1OhTF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3d3aDFoNDhYMXNwUzN6cWp5MjlTSjVoemFsSGlpYlhRandPaWZ3TUtQM1hE?=
 =?utf-8?B?eVh0cStoVjhQb1BtZ3hnQ3dLbUtzUmxtYlNhQlU5cnlVSGx5ZHd0b055RE9G?=
 =?utf-8?B?bldHVzBua05ldXo4cTdGejZTdndpMHl3VFl2MzNmMHQ0MmNLK1JUMkFWSDBo?=
 =?utf-8?B?VnV1czJNVUkxNTNBY1NtN2o4bWZvRXRkLzU0ZnArSkhabVVnd2t6aDNZTDJ1?=
 =?utf-8?B?MGpIZEJhWkdxZm9tZlRLYk9BaUpmOEpwZHBLU0JWZXgvUWNkTmFoSEIvM1A0?=
 =?utf-8?B?OWdJSE9rcGMrWTRVZWJaN2tIcEhGc2ZtbEI4dC9tUlpOUGxiT2poRVlYRkpB?=
 =?utf-8?B?YkhUY29WMTVUQ2dzcDhkdmxQenA4WnZZMkNab21tUHdvSFJBcXF2SkFMZmZW?=
 =?utf-8?B?NHhKZnQ4d0RiOE5VUlJwcGh6bE83L2x5RzFHVXFremhmY3p5S2pxVFFPQmgz?=
 =?utf-8?B?WGpJdkJlVTNiSU5zSjB5MDRFRW1ZRFBvUWdhcUg5aGozNTlMdmozSlI1S0dm?=
 =?utf-8?B?UTMvSjJpL0tFdHhLUGllZ1dDZkEyckhJZ1VjTmdyVURDM0o3L1FlT2U4Y1Bi?=
 =?utf-8?B?Z3ZFZVpmLytCNncvek9DMERZYXJBdDNHbjJweW1ieWwrQ1lWaFZmdHNvNzNO?=
 =?utf-8?B?RDVyZW1UUjVxQ1hLcmV6a1FQUTU2UkVSdU9CL2xqZnlqaHd5c0EzUDFoM3ln?=
 =?utf-8?B?MGh6aU1pVkJQODNQcEdoNHRzLzRIMklhNitKTEtZUnoxQkJxdzlQM0lpZE9Y?=
 =?utf-8?B?OUJzd1pXT2xPeExhV2IwdnJRdnRaR05XK1BFbElrcmRGdHdVU0gyNW1CMHFx?=
 =?utf-8?B?aEpBUGdlMU02RTRFUUEwZEN4YjMrSDhXRERxWXpCM2NPZzg2MU5TVTgwR000?=
 =?utf-8?B?aDJ1U3BuQ3ZLMkp4UWRWbFJXbjBFYlJmd3A0N1pIaFYzZkptcHVGcllOanNY?=
 =?utf-8?B?Mk8vdmcyNVNTOFo5bHhnUksycjQvMy82dXlZRnRZU25saExMU1hiZEtreCtY?=
 =?utf-8?B?NEhUNHNnODk0a3NWMVF4YnV1WG4zbzkxZFBOb2JldVc2dUxYNjg2Q0VMMnkw?=
 =?utf-8?B?cmp1ZHFsYUtsRkM3WitnOG5rOGhybmROeHYwNDQ0aDl0OGJ3cXpXbjNZWnho?=
 =?utf-8?B?cnRlWW1HVnVqcGJFTWI2OVpob0Fqb2x5RlVJMWwwNVBWMzg2Q1JtNUxaSlBa?=
 =?utf-8?B?TGtha0trdllUS1o1Yi9Ob0xyNm1QSk1OcTJleThFdDI1K1hjOUFhZThiSUZP?=
 =?utf-8?B?T2RKOUh1K3ZWQTlsaGk2WThTd1VpeUxldXk0Uyt6dDBNMFJQYkdzUmhBMUpU?=
 =?utf-8?B?TWhOb21hVXVsOGNlNWNMT0RueEY0UThSQ2hqaGE0K3NWdnBRK2ExeTBwN2Vo?=
 =?utf-8?B?anBJTFBWM1FtSnBJUzBMTUQ5dmpzbWYyY2dEMzVuY2lCRzF5VEtLR21hNmZ2?=
 =?utf-8?B?S1JNV1BubWMrNmNkQStITFJFUnpjNnI5cGlYWWdydmdYcGNiYXFFT1VMVndL?=
 =?utf-8?B?UndrOUlVL21TQlV5WHZ5Tjg3dWJheVFyNkQ4QlJ2OG9xNGhRSVdtTWJSMnQ0?=
 =?utf-8?B?QWlma0VoL3pBbGlOOWdyR0RuSFhydjJVMWYxaDZVSTFFNzRtdUlUckN5SWpu?=
 =?utf-8?B?YjZiTE45dkpaWWZWcXp2b1UwbjBiYTlBbVVjMFREOVRIbGtsdFc0dTYrUVBO?=
 =?utf-8?B?L2N4RlU3U0hKWloxamdDamZnMmZHK0NaNGxaUG5hVUNXcHFzTW9qS1dFQlox?=
 =?utf-8?B?TnVHb3FJQU8raGFGTm5NV3NpaTgzR1BqY1dYd1dZVGtVeWRwYWluL2o5b3Rz?=
 =?utf-8?B?MDBDQTg3bjdsa3JuYTlTbWF4VU5sRnhBdEJPL3lQMmdlcEM3NzY4TnpyaUJJ?=
 =?utf-8?B?UGZITVV2NmdrNVFsSWI0dmpYRWZHY0c5bllGSUpzMlE1cVA0NXV1WG5sNEtO?=
 =?utf-8?B?b1RtNEc0WkRsemNjekFOQTEzdjhPNHh3RktVamkwQk0veVpkZDVxZHJUWFNs?=
 =?utf-8?B?ODdJSXlJYis5a1ZOSlhLK0Z0Slh1R0JkallpRFNaYzBRQVpXT3AzczdRWlJG?=
 =?utf-8?B?MUk1SHBhUDNwTkdjeDYxcmh5Z1J4d2ZuamczQUNNeCtScUYrcHRUekhpL3di?=
 =?utf-8?Q?ng0cfUDx8G9PKxqgCYJXlNwDs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0977f8c6-4e1b-49ac-bfe1-08dd1ddcbbec
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:20:04.0833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFew2P4uX7SEg0M1S2i7jQqkRvGj20QkvKD38ATIkgK87hGMljh67/WJ4OTVzx+60yhr37XGgbyPSFRkNBSsiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286

On 12/16/2024 05:32, Jonathan Cameron wrote:
> On Sun, 15 Dec 2024 11:20:53 +0100
> Lukas Wunner <lukas@wunner.de> wrote:
> 
>> If a PCIe port only supports a single speed, enabling bandwidth control
>> is pointless:  There's no need to monitor autonomous speed changes, nor
>> can the speed be changed.
>>
>> Not enabling it saves a small amount of memory and compute resources,
>> but also fixes a boot hang reported by Niklas:  It occurs when enabling
>> bandwidth control on Downstream Ports of Intel JHL7540 "Titan Ridge 2018"
>> Thunderbolt controllers.  The ports only support 2.5 GT/s in accordance
>> with USB4 v2 sec 11.2.1, so the present commit works around the issue.
>>
>> PCIe r6.2 sec 8.2.1 prescribes that:
>>
>>     "A device must support 2.5 GT/s and is not permitted to skip support
>>      for any data rates between 2.5 GT/s and the highest supported rate."
>>
>> Consequently, bandwidth control is currently only disabled if a port
>> doesn't support higher speeds than 2.5 GT/s.  However the Implementation
>> Note in PCIe r6.2 sec 7.5.3.18 cautions:
>>
>>     "It is strongly encouraged that software primarily utilize the
>>      Supported Link Speeds Vector instead of the Max Link Speed field,
>>      so that software can determine the exact set of supported speeds on
>>      current and future hardware.  This can avoid software being confused
>>      if a future specification defines Links that do not require support
>>      for all slower speeds."
>>
>> In other words, future revisions of the PCIe Base Spec may allow gaps
>> in the Supported Link Speeds Vector.  To be future-proof, don't just
>> check whether speeds above 2.5 GT/s are supported, but rather check
>> whether *more than one* speed is supported.
> 
> It has long felt like the need for the very low speeds will become optional
> eventually, though the challenges of getting a backwards compatibility
> change into the specification may make that take a while.  Hence
> I agree this approach makes sense.
> 
> Reviewed-by: Jonathan Cameron <Jonthan.Cameron@huawei.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> 
>>
>> Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
>> Reported-by: Niklas Schnelle <niks@kernel.org>
>> Closes: https://lore.kernel.org/r/db8e457fcd155436449b035e8791a8241b0df400.camel@kernel.org/
>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
>> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> ---
>>   drivers/pci/pcie/portdrv.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>> index 5e10306b6308..02e73099bad0 100644
>> --- a/drivers/pci/pcie/portdrv.c
>> +++ b/drivers/pci/pcie/portdrv.c
>> @@ -265,12 +265,14 @@ static int get_port_device_capability(struct pci_dev *dev)
>>   	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
>>   		services |= PCIE_PORT_SERVICE_DPC;
>>   
>> +	/* Enable bandwidth control if more than one speed is supported. */
>>   	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
>>   	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
>>   		u32 linkcap;
>>   
>>   		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
>> -		if (linkcap & PCI_EXP_LNKCAP_LBNC)
>> +		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
>> +		    hweight8(dev->supported_speeds) > 1)
>>   			services |= PCIE_PORT_SERVICE_BWCTRL;
>>   	}
>>   
> 


