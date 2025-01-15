Return-Path: <linux-pci+bounces-19800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CD7A11604
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 01:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0753A169C0E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D696AD5A;
	Wed, 15 Jan 2025 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FEBNZAe9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0132111;
	Wed, 15 Jan 2025 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736900412; cv=fail; b=cgDVW1XH5F+DF9S4q7j/iqaYBmUe/uoKxHDJ7h5A+8xFYHMxTfkjqWxdbtMfW42OCRdHnb1URtIeS9Y7Tlq6AbxfERu2Okkidv1WpVWm/MAyLaff4HhSsd4NXx1BRWjBPLLhpAluqTOrgXK52tTb8y0nhMmpyK6KBZ60b8ZYeZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736900412; c=relaxed/simple;
	bh=+fGfFZqIwjgR/HVynNsyhLyJ2nPM2UYLw5ZNkYzNTCY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cnoU6r6TZ9n7hFfvvRD+whT5gHZU13W1arkYcS303F1Qfqu6OmrEy0i1yUHhyiksfAdRHv2gvijvDgvWegEe1lB0K5FFm8wQ1jOZkC8rCSwmaNFBMBXuuMPD3ysnD892h4/nvfwoipiUaTMvdH1Ty7SYCR1KmMbLTepoBSvA2LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FEBNZAe9; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2Y39GG9+3XhvcI2VGAx5WPIDBLEhF+Q7CbYyPaK0x0uNDdYp+LuuFHnMevLuDpgQSBruWF/dcA1NVVq6kqUJm7VSzAvC/Ei4Zhq+WjpAGm0zA+NgOfggDKcKOagA7Xz/4m3RMKcBuaTZW+x2iJs8jSFwyPI/7EBqY6eTaxQEAC+xf78F2tZ0mTi+yPpWMglcvTEDGEu744YYcybEWHq+NLdjM3Gm99lI6ar1DD1xBaJkrHFcdlSwZfhylKVR3tn2IGe9yU78sXvgiwyi9FCT7I/bFczOhppohTDF8jQPC6jOb8jO34ou0GvK7uhbAC5T70eSHmaW3fnkHDze9Ia3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3peYxjlQGkCqK8CDIrFKG53UNv8U2Ba2QeoX/ffmfQ0=;
 b=Y4DVhCMX+soXzbGxZIDVjUfFdaRknI6Pj2kBuVr8OIcFpLKUJDoFBqpyIaYb9Ri6J1BsHU4ZkziZoCYIX14pleLSFz9LYqusQ4a2WXpc57WsFoLftrDEvj0HckBbBh8swxKUZhYJB8dmu4tQEQFV8edx8qSunPX11obNrwohJtal3ib72qCpViE7/Ct0qcaKJd+l2YtpzNhDF1BHIj94DIwxHD1TGQoNhmAYG9tQBV+8S0o8sSvF31hHq0XLVtQxOarFKUmYJNs7ULYsYPSOyynLKP1iS2A+Ca+SVIk8jsHqxeRFeZW62jkIvVuO9CZinok0OmPxBw91sa+F9IV5fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3peYxjlQGkCqK8CDIrFKG53UNv8U2Ba2QeoX/ffmfQ0=;
 b=FEBNZAe9Mmxfdv7RPpoqwiPbLUg0H8ADcToYxskyv7alhZ1dTXtZwKfGl0YvMZPk9BLIWZreFMd3f/DCLUdH8if9XXSxY9f+pn2DWUqYuoCjTYNhC2Z88kutX7ACH99PqD3QiwiylcdTShpN5O6R3fOhlvlqkYU09jVq5yYg4XE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Wed, 15 Jan 2025 00:20:08 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 00:20:08 +0000
Message-ID: <28d730b5-77fc-4d5e-864f-03c0cd4ed4b3@amd.com>
Date: Tue, 14 Jan 2025 18:20:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/16] PCI/AER: Enable internal errors for CXL Upstream
 and Downstream Switch Ports
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
 alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-17-terry.bowman@amd.com>
 <6786f2a7b2b7f_186d9b294f7@iweiny-mobl.notmuch>
 <e3df211d-b699-401f-ac00-1715f7a2d15f@amd.com>
 <6786f7301088a_1963352947c@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6786f7301088a_1963352947c@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:806:121::15) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM4PR12MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: c17d9150-cf34-4cca-c7d6-08dd34fa5e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkhTZDNmUjdQc2lXcndnTkRVa1lYMnV3R2V0SGdBVk1CTWxaaElaNXZKelUx?=
 =?utf-8?B?cWltV2owTS80NDZoRERNTXRvaWlTeng5YTU2dUZOM1VJZ3NZWlhyaWxMNmc2?=
 =?utf-8?B?Sm5UNzJWd2dYQ3JmcDVtRlNSNDk2bWpxbUZNYysvaDlsc1Vnd2pYNzh6OEpL?=
 =?utf-8?B?cmFsRURqaFI2bjRaT21abnNYZ2czTHVhRElkajNXUjI4SUtVaWhGWkxVdHFy?=
 =?utf-8?B?bnNKWUdCcnY2WWpNOVR1VkxSU3M5b3FFZFltbUZoVXlmMCt3U3ZMRjhZUTg0?=
 =?utf-8?B?MHEwUmQwd2xWUlVqcDh5T3ZuU0R2RFBub1F1U1czRjhXajhDNlJodlRiSkEy?=
 =?utf-8?B?RVd3aG45bFZDRmFzUDFNOXhUaDhMQ3M3THpZNGNiN3J3bUVqdFBrN2U1bWcr?=
 =?utf-8?B?NGZURWN4djhncHFPR0xPZzZwR2Ewd2s5U1ZPblkwTFdLc2tOY1ZzZ3Ryc3dL?=
 =?utf-8?B?NlR2S3FMalFudDRrL2drdkpuWDVSYjRwQ2R5bm5WM3B1aEs5REUrOENnL3Np?=
 =?utf-8?B?SFZ3ZFRtQ00zR1RRYzF2OTRqZXNVdnNSampDWVp2REcwQVYycU82ZHlHaFY5?=
 =?utf-8?B?cjlScmdpeis1TzZBOWx2dnNOYXMzLzBBOE9LWG8xcngyV1VYa0hGTGlwREpz?=
 =?utf-8?B?eklQb0hSME9pbGg4anNCNTFJWWpoQWk1MUV2dzl0ckQ0cGw3dHFxOGpuQmpz?=
 =?utf-8?B?WDNiem5laUZqcDdtNXBUbHhGR0tTcnlaUndWYzhFbXBqWUg0K1lGdDJiaVJT?=
 =?utf-8?B?YWxBWFdIMFFIa085dEtNNHpIMHhpdUxKY1Uva2cvY0l6cjBmR3c0dVc4ZzRG?=
 =?utf-8?B?S0lHVXNvek9pYVRhVWdzdldXRzM5U2RVampCQVN4RHloYitiSXltaEFGSmda?=
 =?utf-8?B?MSs3SUNUTlF2UFhzd2E4V0pGU0h1ZVd6ZGRsM1R1NHk0QWVnNW1UeEhTT2pB?=
 =?utf-8?B?NkxFVENFVHpFWFBXYXZlYWJXVDBKeGUzRXg3S0t2cTRYT2tDT3d2RUFITWJV?=
 =?utf-8?B?S3Q2c0cxY0wzNHZYOTFrcG5aeVR4L1kzYWs2N1hydWx3UDRBM3ZyVEx3Nkpi?=
 =?utf-8?B?U01MZUFvcmNOd3FtRnZieENMTk45YzNkNk1GOVkvc2ZGMFNpNWV4Vjc0TEN0?=
 =?utf-8?B?V0ZOSXlmTm1vSW0xSzdEdmJVeHJIR0ZyVVhzUUgxS0F4NGx4QVF4YjNxOEM4?=
 =?utf-8?B?ZkVEUEJoRE9Va3FMUDc1L2hWcEJUU2xZZVY4K0NzcTA5TWlIaGhSNktucnJ5?=
 =?utf-8?B?Y0JHOXUzdFlISmtWQ0tKck0xZXBISE9NK1g4Nm1xRk16dEgyQllVaTNtWDlD?=
 =?utf-8?B?aHVyL2l6eVFSRTdFS1ZBZXNsNUJDakliNEhOTzRUVXhlMS93eEQwQWRuNUJ6?=
 =?utf-8?B?R2N3dFIxYm5HT2ttcDZDZ0ErVzdsYllQWElRVk1kcHpsMW1vZWYvK1pwQ1pr?=
 =?utf-8?B?RC83MTFnQUs4bmcrcGJ1SGsvOEJPeDVqdFNRbklVL0JuUWYwQ29ZV29RamtQ?=
 =?utf-8?B?Qjd0bzlsc3MzVHh3UmtRZzFXUElsckNkRDM2Q0MxL0NSd2pkdU1vKzA5a3Y3?=
 =?utf-8?B?aDhqZ29JTG5DUW85VVBrWC9CTTlYWFIzSHZEenFNMHgxdSttQzFiSGlMdytI?=
 =?utf-8?B?VnhhZUxwb25uWGhsRWlRcWR0K0lCTVdjOEs0MFlCVnFaeGxFZWZGdFhsYWIx?=
 =?utf-8?B?RjUvRmlHcEtQN1BGSUtPcTNQVEpESnNxcXhqclJHMmNNNEZqT2xHRXZIUjZW?=
 =?utf-8?B?SHJDRHFJWmJ5MDZqSGgvYzRTQVd0Ukk5ckxLa0ppbGp1Yksyb2JaREFmdjJy?=
 =?utf-8?B?ZGkzSDhBaTBPVVR0ZnV6NG4wOEE2OUwyVUhHOFdXOXNxTDFYZXBNK0tyR3Fi?=
 =?utf-8?B?S3hRTkJobXFIT3dqQmtkOTdUQjV3N0FEdzVQU21MYkQvZVpqQm5uNmJsUnFC?=
 =?utf-8?Q?RA9+sg5QVZo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnYxT1YvRXI2VlNSVlJQSmF2V091ZjVkWHhRYTlyYWFoUzZCbkVGeGU3dDUz?=
 =?utf-8?B?U3hRUVIxdUtUMUdONjBscjkyN3dUYVZmV3ZKOHNXdFUxNEo3b2FPbWoxSVp2?=
 =?utf-8?B?MWNza0YvdHY5QUZRRmZpQTZGemo1YkpnVnZTYXJrMmRCbEdXQUYvNHhEOFlZ?=
 =?utf-8?B?djJkZkRUVncvZk1FS1BzcnJkS3Q1YmtITkwvbW5qajE4RUVtUmZtYk5VVXJ1?=
 =?utf-8?B?N3FoRTdsTjk0Szc3U0NLWEd6Q2RIWGgyeWRGSkZFaHF0T0tVeVg0ekJTN2Nq?=
 =?utf-8?B?R0lIOW9xNmcwSnJqbkxKVFlNenZ3cWJ2b1dmUTRTZWdsbHpRZlBEMjB5b0lV?=
 =?utf-8?B?NDcwZG93ZTB3bVR3T1Q2T0k4b1RJcXdSaXlXZjArS1FUd3AyTk1NaVJER0h4?=
 =?utf-8?B?d3g0T1ZVaS9oMDRoNzd5dzNrMXlzRDkwVm5UTUFlZXUzT2s3M2J5c0Q5dHJn?=
 =?utf-8?B?UDhxUGhLdm56aVdNVktHQ2VXUG9Gc2N3clRQVmVmYTlIL2FnV3BIeWNjMGV0?=
 =?utf-8?B?b0pkVWt1a3VPaVZmelg5OXIxT2Yzdm53c1ZaRFVDSTJJRm50TEsxa0pDbEU4?=
 =?utf-8?B?eXd0dmk1TC9vUURicUhUZ1FzZVZ5QTM5VktBQkdVS0U5emVhYXZVT21RZlNJ?=
 =?utf-8?B?UzZuZmUzRjJ6V0p6alhqNHhqRk8vMGFTeUZVOEsrTkNQY0lpOGJrQlNjODRp?=
 =?utf-8?B?TmdxVFpXOGlRRjlPd28rWk1yQXlnSTAvd2dqYjJNMjR3YW9YS3BpNHhsamg0?=
 =?utf-8?B?TnkwcFZoNDhhVHFWWGJyYW5HRUdVSUV1YUdCNFN3M3BYS0VkbnVOSVBNUTFm?=
 =?utf-8?B?QWZKZCt1cWRLaHMwTDN2aTlrSXArbWw1NkR2ekVuUlBubjNIazBtRTV6N3ky?=
 =?utf-8?B?bXpwSlhHT0NtenRTN0pEVlNMY2gySk11aHNyVXJPcEZpUnBsNGR5ekx0MGdZ?=
 =?utf-8?B?ei9peXlmcDQyU3o5VDVZMnJRRVFvYVlzYUU0Z0pHUnZ5SDA1RStLL2dnL3hn?=
 =?utf-8?B?VFhLckZvdVp2cFF3VTZjb0lqS3poazZiSHlOQ1VhbFFmMEVHODJvdFFkN0pp?=
 =?utf-8?B?L0FaaVV2N0NYS3NxRlZOMmltTjg0T29waE5YSmxGVm1qR2tpbWNMNzEzY3Vx?=
 =?utf-8?B?TjVTMlVOT1pHUzF3bGxXWElVb2JCZnM2TWlUaVBvZ0dJREVpTkErV0RvRDQy?=
 =?utf-8?B?VFpEUXdlUDdLK3RldDBLV2RMSWNsVmV1dUY0eFJIRnduNWRRRW5xblUzaisv?=
 =?utf-8?B?a1BlOWJJZTZjZ3RTMnJvdHI2ZlY2a1QvTUdIbm54RmRSU05reU1lMTEyQXlG?=
 =?utf-8?B?TStOOVlyalY2ZThSdDBxTGxhUkpqeUJuY212alZYRk5DOXc4aU5rK1BkOVhw?=
 =?utf-8?B?THhkMkJoVlVzU2V6WTFuQTNHWk5EZ0YzeWdZaldKNHIrekJmTUVXOFNDSmEx?=
 =?utf-8?B?bnJPVldnQ0FYLzNxZmd6THNWdmYxQnoyNHNtUFBoMXJoRTA2NTdLclkwOFpu?=
 =?utf-8?B?MXlaWUV5TzJpb0ZNbE9mWVp4aVRyaGp6ditHQWlIUmlJd3ZvSVlqWHFNNHY1?=
 =?utf-8?B?TjlXMDVVeUd4SFZQTkFWQ25mODk3VWVqQzA0VkRSeWd5cEpDM2g4b3kyYUZ2?=
 =?utf-8?B?VG1MUEE2SnFwbzR5NTRsTmtmV25hSVVWdEtTcjlJU3kxSkl1U2dZdHJ2c0Fl?=
 =?utf-8?B?ZHdvdFNQYXFJd2ZRUk9DMXNuZWtyWjBMRzE0NHd1UmxWL3V5K1dZUkEweExQ?=
 =?utf-8?B?Y3BQMkhJMmRybDJJeGhLdHF3WXdyS1N3TFpkNjhJSnZhSDJiN1MxQVV6cXJH?=
 =?utf-8?B?ZDVWR0xBWW5jYTVETGYxTG91R0hNMHk0dGVyZ0NnUzU5blpuWTkwRkFKU1VT?=
 =?utf-8?B?Ump3dUtVUXdJQVJ1cy9LMnhBMmZEQ1F4Z0trazZFbzJ5WW1MN2xTZFc3cVVS?=
 =?utf-8?B?YTNkbFJUZWtJb1ZSd1BFVkNRNENja3ZqTGxwSkNYUHBmb3JSL0RxQUZhQi91?=
 =?utf-8?B?endtaXg3cVNzeU1RUzJJWEJvVzl5Z2d5emlBNElna3orbG5XbFhscW92UENN?=
 =?utf-8?B?ai9mSSsySDJpZVVDNG4zNlEzU1Ztb0lrTThaL2hTNTlRR2ZrcnFtb1NkV1JE?=
 =?utf-8?Q?7TuR0PTYpJqvlCbKcub8SOybN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17d9150-cf34-4cca-c7d6-08dd34fa5e0f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 00:20:08.2754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCpENd1JIAtjofC2YTjvlEuOZltEiPBthz0E8vJiDNrH+yjix+biQZYuudtGJUKRoI629yzpSJWFsPiHr9raLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255




On 1/14/2025 5:45 PM, Ira Weiny wrote:
> Bowman, Terry wrote:
>>
>>
>> On 1/14/2025 5:26 PM, Ira Weiny wrote:
>>> Terry Bowman wrote:
>>>> The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
>>>> Correctable Internal errors (CIE) for CXL Root Ports. The UIE and CIE are
>>>> used in reporting CXL Protocol Errors. The same UIE/CIE enablement is
>>>> needed for CXL Upstream Switch Ports and CXL Downstream Switch Ports
>>>> inorder to notify the associated Root Port and OS.[1]
>>>>
>>>> Export the AER service driver's pci_aer_unmask_internal_errors() function
>>>> to CXL namespace.
>>>>
>>>> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
>>>> because it is now an exported function.
>>> This seems wrong to me.  As of this patch CXL_PCI requires PCIEAER_CXL for
>>> the AER code to handle the errors which were just enabled.
>>>
>>> To keep PCIEAER_CXL optional pci_aer_unmask_internal_errors() should be
>>> stubbed out in aer.h if !CONFIG_PCIEAER_CXL.
>>>
>>> Ira
>> Bjorn (I believe in v1 or v2) directed me to remove
>> pci_aer_unmask_internal_errors() dependency on PCIEAER_CXL because it is
>> now exported. He wants the behavior for other users (and subsystems) to
>> be consistent with/without the PCIEAER_CXL setting.
>>
> I see...  If PCIEAER_CXL is not enabled why even set the cxl error
> handlers and enable these?
>
> I guess this is just adding some code which eventually calls
> handles_cxl_errors() which returns false in the !PCIEAER_CXL case?
>
> Ira

Re-sending because I somehow sent from Outlook earlier.

cxl_dport_init_ras_reporting() and cxl_uport_init_ras_reporting() assign the error 
handlers and are within #ifdef PCIEAER_CXL. The stubs are in cxl.h.

Correct. handles_cxl_errors() returns false in the !PCIEAER_CXL case.

Terry
>>>> Call pci_aer_unmask_internal_errors() during RAS initialization in:
>>>> cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().
>>>>
>>>> [1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>>>  drivers/cxl/core/pci.c | 2 ++
>>>>  drivers/pci/pcie/aer.c | 5 +++--
>>>>  include/linux/aer.h    | 1 +
>>>>  3 files changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>>> index 9c162120f0fe..c62329cd9a87 100644
>>>> --- a/drivers/cxl/core/pci.c
>>>> +++ b/drivers/cxl/core/pci.c
>>>> @@ -895,6 +895,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>>>  
>>>>  	cxl_assign_port_error_handlers(pdev);
>>>>  	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
>>>> +	pci_aer_unmask_internal_errors(pdev);
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
>>>>  
>>>> @@ -935,6 +936,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>>>  	}
>>>>  	cxl_assign_port_error_handlers(pdev);
>>>>  	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
>>>> +	pci_aer_unmask_internal_errors(pdev);
>>>>  	put_device(&port->dev);
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index 68e957459008..e6aaa3bd84f0 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -950,7 +950,6 @@ static bool is_internal_error(struct aer_err_info *info)
>>>>  	return info->status & PCI_ERR_UNC_INTN;
>>>>  }
>>>>  
>>>> -#ifdef CONFIG_PCIEAER_CXL
>>>>  /**
>>>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>>>   * @dev: pointer to the pcie_dev data structure
>>>> @@ -961,7 +960,7 @@ static bool is_internal_error(struct aer_err_info *info)
>>>>   * Note: AER must be enabled and supported by the device which must be
>>>>   * checked in advance, e.g. with pcie_aer_is_native().
>>>>   */
>>>> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>>>  {
>>>>  	int aer = dev->aer_cap;
>>>>  	u32 mask;
>>>> @@ -974,7 +973,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>>>  	mask &= ~PCI_ERR_COR_INTERNAL;
>>>>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>>>>  }
>>>> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
>>>>  
>>>> +#ifdef CONFIG_PCIEAER_CXL
>>>>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>>>>  {
>>>>  	/*
>>>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>>>> index 4b97f38f3fcf..093293f9f12b 100644
>>>> --- a/include/linux/aer.h
>>>> +++ b/include/linux/aer.h
>>>> @@ -55,5 +55,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>>>  int cper_severity_to_aer(int cper_severity);
>>>>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>>>>  		       int severity, struct aer_capability_regs *aer_regs);
>>>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>>>>  #endif //_AER_H_
>>>>  
>>>> -- 
>>>> 2.34.1
>>>>
>


