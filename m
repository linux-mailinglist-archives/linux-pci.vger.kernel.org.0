Return-Path: <linux-pci+bounces-12036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F5A95BEE8
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 21:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B751F23343
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 19:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED57B1D0DF7;
	Thu, 22 Aug 2024 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yGElwiAx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE61D0DE8;
	Thu, 22 Aug 2024 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354880; cv=fail; b=CvaVgk8Qshq0v1qX/kzJ9qxiENsdnHMOdqMCQFhnKsEmZqPs4gXuqcDWV518olMndyyiAEjrcTuBEkNCWRHPBc6GOxpmMugz7myavixtj85RZVHw6PYi6hbynyLcgZXJWbpnpYQZWqtE0ZOVJsWOXd3JpqULhAHLyDdUGMWPhb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354880; c=relaxed/simple;
	bh=J/21KWgebescv2lND9PrMftXnignm7VabRGxMmkO/MI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fnH/2kns+TlHpqdFjQE8k877yo2ksQcre8TLH4dGPN+HuEG8HKXegbS/jxygr3pmndqoF9/asuJxz4cEjEfzZQKwGJn4Sf4vp8fJwn7rrcxJNTpGHC1u6O2bfMN/jbeawuTZPetMhMtSBWYjp8A/A2tpEnzok7wYlzRtXoHsz40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yGElwiAx; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQYrCr8jh1ZYDOZ6yTWRQhuT61v0q4XZPtO/eyiPLyAH6OV5ydXqFHRVqohJDtWnQT3BvGClJGtRQWqGMpdLnnwzCuybdr3rGxgeCUc3SpNkXwpNz2TYtIqnN8TfbsRJD6IFOG1EhOmuDUscO03nz7JcLbMNS5/FvJYcp8cD8zyda1w7jBldHoN3GH8T9y/IG5AWs7EA8lAZM+9drf0ijmqj/lqIxEe2mzM4tef9TKmqIKATVPIfomLduyE6aG0ygkxZ8NJF/UxKQ0BUCgDDNOx35mYhoKBL94+9nvyVSgsWQzyPLtPHVU9xzw8CD3MhTKq10TWE6R2Yavj24+wcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olO+At1XU7EihUrcRXHe64vQW6eX69WC0aURbYFZulY=;
 b=nVZA0QrN8P/K3M3gjAa5tFzT9JtVUORvQuN0BdETh2Su46PoskiIve2ElT0JoXfclgTqj9MidWRfqIst+ziN+VlNDYkz23RTmIbKa8ubYt6vvFI+04+Kk84PoIbYbvnAY4zw4jYgf5xohRp/a3XmOdDEnSGicX/8KhuZBamXyRAhAPc0kkDIaRgRXkKZWoSTUMxsxtOrz3E1fohAwWLCMNHdZsEysfuJqogU6PuSemOM3Kn2UE+3rjVmBw61NbgvqJXNem9K9K7RgxNeAhhzAm8cS/hGuy/KRg9eemwpIv6LJIX5+oHEEcJIPC3XU9wsiEOx0xS5mJ4FF3ENuNRVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olO+At1XU7EihUrcRXHe64vQW6eX69WC0aURbYFZulY=;
 b=yGElwiAxmqZomD40igHFpj8hJswB4B9DZw5vPhEPdn0VMMBIJxm5jDIJlzaO2mb8/xmhcGx8tbp3j7/CVy6RK/EUf6zECfT3v3sviaEG8MEew2xMkqbklu2jqXrem2ADbIxBKMkg641H/pm+0rSsuiB7wricNugheeL60bWHTs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 19:27:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Thu, 22 Aug 2024
 19:27:56 +0000
Message-ID: <6685e124-4a7d-44bb-80a9-fc5fa51269a9@amd.com>
Date: Thu, 22 Aug 2024 14:28:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc: mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240712062411.35732-1-kai.heng.feng@canonical.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240712062411.35732-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0058.namprd05.prod.outlook.com
 (2603:10b6:803:41::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8fdabf-7f6d-40a3-1f6f-08dcc2e08626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amkvWkkyMjA3MjU0bW1PaUh1RFI4cG9xK1c3aUhvQi9NbUFTTHZBTGdUejVs?=
 =?utf-8?B?RFVKRTdJZjJ6aEpDdUM3N1NzNlN0anN5M2dsZ3F5VlhlaERtT054N1Y3YjlM?=
 =?utf-8?B?cEp4elA1VEZZc1hVQWlDekEwNW0zVldlYk5yUFd4dGRoVExpdkI2UjI5OEVu?=
 =?utf-8?B?NkxBZjhWQ3o0eGZNbmFPVUxJQkhGWCszQW1jaTNlRFI3RFlXenBOTzBJS3dW?=
 =?utf-8?B?QlE5YkFmWUZQcGpvUGhUSTZXNSt2YndmeHowc0R1dXpUWG8yTXdLZlVyekZy?=
 =?utf-8?B?TVJDSHFEcnJIUk4zTTBVcXBzMTExZHYwTjlLZFp6ODlxN1h5Mm1iYldqVVZV?=
 =?utf-8?B?M05NYSthems3N1pacWs0TXhFYXNscklvcFpHekQ4TmdVZHdQUjl4UHFiR21Q?=
 =?utf-8?B?WUxJcmFxQmRuRCtucnVmUE5maXE1QU5ZS3pBQUFHOXZaQXFOMmk0akxPVFVu?=
 =?utf-8?B?OG5NYWRtc0lLdEd5ODNqb2FyU20zTFEyWjZsZ1lwRTJRUXBEd0owM0lRbThI?=
 =?utf-8?B?RldTczJXdVhwRmF4YUI2UjNQYlQyOXlqKysxTlJLZGZJb0s3SnRmWkxtT0Zn?=
 =?utf-8?B?MlV0bjl0ME05enhac28reUpZN1JBN2o0UVEzUytYRmNNMjc2bzRSZTloemFk?=
 =?utf-8?B?eS8xRm1DNDBQRlhEaTBzVWFmRmZyZThyUmJlSzJ0dFQ5SnE4SGF6WTMvT2Qv?=
 =?utf-8?B?b01DWjNjekp0YmtJL3Y0ckdUc25IUzkzUlhSZXhrbEVOeUdVQzlqMHBET3BE?=
 =?utf-8?B?U0JJNVcrd2g3TkFtdjNJc1dCNjJ1bWtzVkROUHB6YUk3aGhFOGx3UWRmd2hS?=
 =?utf-8?B?VlplOFlGOExSQTVLZW53OHd4blJpbWNoaDhVS2R6WlZ2aVpiRFJRRitqZjVo?=
 =?utf-8?B?dktqclBLakZyQ1N1WXhNaDBpbnltZjQ3NUc2L2tuOVpnUDd4U3NCdzd3dE5i?=
 =?utf-8?B?eEN1ZTBoKzcxQkFQNUpBckFFMzdVck9xT3FGTTE1RmZPQWR4MjNmNWdxYkJF?=
 =?utf-8?B?aGpPMTlRNjZaZFZJQjg4aHZnS1lOQlpLcDlSODBBVVROS0hFejJaQXU3OXZz?=
 =?utf-8?B?NHpqcThldXNOS2pGaUlNOXNTck54bXlvOEFseXNRN1B1Zi90RWZ0Tkt4cHV1?=
 =?utf-8?B?Yk04NjJjYVppUTU5VnIyY2J0NzVIckR3b3J0bjdzaHNONUVONHAwVnkyZ2Ja?=
 =?utf-8?B?OFNLYlpsb0lGNlRKYlBCRkwyUmhTbXB4ZUFhbmZUS2V0SzFFZGFjdzVFMS9W?=
 =?utf-8?B?cWU5cjZzalFlTmdQUmxweWdTeHBvMjZjaUNBU2JKS0hocUxvNjYybEdnQU5T?=
 =?utf-8?B?dWU2eVdwcWVxMFZ4L0NNWFNkS29vRFBaZmFhRlFUM0R3STZVZ2xDTXhldUJ0?=
 =?utf-8?B?enNFdGtEQ2hJcWFteEkrZG5uTDIwWWsrNE5xcjNOSUJMeEF3blM1Y2VKd2x4?=
 =?utf-8?B?TW9pZFZCZ1Ruakl4SWRQWTNLWG03cldNV0xQWDF6ZkdabERYMHpXZysvMmxP?=
 =?utf-8?B?Y0I0TVJTV2Vnb2Y0a2xlZEdUSnZnaTZBVHY1VTkwZmRCQVRuSmhldENnUXIr?=
 =?utf-8?B?TjVEU1h5SXJlMDREcEpRVnBnaXB0K0JBYVZUWWZrbjFNUVVpcnBNWG4rT3FV?=
 =?utf-8?B?NEdibEJoYk9VTVVkR0RjamtpeXBxckJSbkR2TExDRjdCMjhOQXJJS2w2TUlY?=
 =?utf-8?B?cEZxT0VvQUluQmRyYUFHWmdqOFdEYU15ZjhWWmhLMzUwTTN1UmtyamhlTWpn?=
 =?utf-8?Q?oJ6OWD8XYTwDFovG/g1zn/8wwpgHyZEopO9ZX7v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmVrcVUwSnJDQ2g5VjZSeXlqZStYdDVPYStGZHlXaytBaVVYRkw5clpNb3M4?=
 =?utf-8?B?ZDEyejBTc0QrMnBDblcyVlU3azRhNGN1bmtkM1Uxc25MMVNkQTk3K1B5SW90?=
 =?utf-8?B?bVBtQ1VpcG4xbXR6QTZEbE9jS0dTNm0vUWN6OXpUeGNuWGVTdks4Skd4VDRx?=
 =?utf-8?B?c0h0Q3grTTdYN01udXNDelQ3SXp1WitrT3NwcmpIcmF6MXMrVFhBN1dhL0k0?=
 =?utf-8?B?TmJzQmVxTFJqRFNWU2lzd01mNEc3T0wyYjYwMEM2aEJsZ3pLR3c5ZUMzK0Jv?=
 =?utf-8?B?V0xURnNaM1Iva0JSOE0rWnhncHliaXc3a3Fyd2JEZTZwRWlkOC96SjM2QlZT?=
 =?utf-8?B?RFB1MEtMZmtJU0h3N045RkdkbWJCNm5MaXpaM2d5V2NTblhwRUFCOTlTMjhM?=
 =?utf-8?B?MFhrd2s1aXQ4UU51Y2NUclJiUXZmdUIrQjRKMjJoYWwyTnNibm85R082SE02?=
 =?utf-8?B?Nk9Ga2ZPeVVadjNBZlZIQWQxUTFlaXVEYllJMHB1L090a3hLTkVlQjJOWUlr?=
 =?utf-8?B?a0FuSU02Mk1qMlJCdGNiMEdTcW1FQ0diZWRMV0VyN3l6S0tVcjNaVEtKekpS?=
 =?utf-8?B?WWRXb1RNaFdzU3IwVElMd0NJbmdvQnhJK3A2RU83NkZpK2NBTjBweHdYcnZn?=
 =?utf-8?B?ODFkc2ZBTGpmQU82STIrUU9vNmUxeEJad3ZQNXcvNWVnN3luT2lsTWtyaEQ2?=
 =?utf-8?B?Q0x0MkJ6elVac3FBdGw3RCtFMWxvQ3NKeDVJQ0prb2xFVXR5Z21SajZIZXZ1?=
 =?utf-8?B?UFNYR0ZheENZVXdndU5zNHoxdHVzejg5TmRDVXlnVDloL3Z3dHhCVUI5b0Ur?=
 =?utf-8?B?R2MraXI2SHl2UnBzYmhyODI3QStVYzUvVGxDTXJ0TGUzR0k0SW8vdTdUaHJ1?=
 =?utf-8?B?ZHMvL0F5WFpOMjFGekNQQkZPZkNWRC9LUXFObFlYRmZ6WTN6dFNTNnVxdmJs?=
 =?utf-8?B?YnZNSVE3QThiakp5c2NjS2lsY3Rib1ZxZ01EbmxuU3lhWDdpSUY2b3NPQXZR?=
 =?utf-8?B?bXdyeUxiQ2FDT3ZEMzVRbVBkbk5SSnNUMzdmYSt2NU9icFFjU2tjUnA3WWRG?=
 =?utf-8?B?cjNoMzA3enFrSW1qN1RnVllYZGxkM1VUSWwxcHFmOWF1UTJZcVU1cHh4UDZr?=
 =?utf-8?B?VUZLd1VoSDNGSkVJNDJzUDIzeUN4d1NPbUVTOW1DV01kY3ArNisrNGtWN2Fi?=
 =?utf-8?B?OTcwRy9WVUdlRllEZEsvdGNKMGJFcllaeGxYYXVwbG1EMXAyYkNKMU9qY1Er?=
 =?utf-8?B?amRlOTVUYjBVTjFZT2E0U0d1STR0UnYzS1dIODRwdjcyRVhNWERRZGVHTTdx?=
 =?utf-8?B?UERQUFZldUVjSHN4MndlQmdZSy96bWdua3hhQTRHQlNiWjV4eE54L0pITEQ2?=
 =?utf-8?B?ZVZRQzh0NmJqTHh2djRvSDA2b01SaFVudnFKTFVzbFlmdFBHZEhUSjZsSDFX?=
 =?utf-8?B?N2pTMTBzbmtYSXQ1S2VNNE1XNUxVR1E5MmZJRnBqOWpFenZFNVQ0RXhVWlhV?=
 =?utf-8?B?ajB5dGZEL1BGYi9ENUNZc3dabk15aC9NQzFvZXR5VitoVzBaMXRFQkRmRWtz?=
 =?utf-8?B?dmYrd1BabGJSOEJQSDVGcEhoRmxrdENyZGJjQ1FaSDF1UzVRaDBDdmY0SDNI?=
 =?utf-8?B?TEhRK21UUTdFamZub3RVOGVLeHVTM1pzRTdpc2FYcUY3aGpSR3FrQllhTDRK?=
 =?utf-8?B?aHJtUW9xWmIwc3cxVitUNEpJUGdneTQ1SnZDZVRMY0hORDdCRmxlOThaY3dN?=
 =?utf-8?B?aHgyWWt4Mmc3R0t4UUk3aFpWenl4MXFLZUJ5anUxc2tpR1kvV3RPRDNOa3Ev?=
 =?utf-8?B?QnJld0ZNRUtBemxmcHJrWXk0NlhDNUhObmNzdmpuR2ZXblhReWFobDFqaXpF?=
 =?utf-8?B?OHZaT3Z5REV5YUZlckE1SXhXZW83THlET2orYUpYbk4vdmViYnl3ZERyWnV0?=
 =?utf-8?B?Wk1SNEhNdVpydmMyb2dPSE1aaG1iNjFhU2NRVUN0N0thcXk4aGpoZXV2cXlR?=
 =?utf-8?B?UityOEp3VjBLY2dxMDRxQnEraHFQbytpVG8xMmNPaFUrbUMzY3V6UFBzb2k0?=
 =?utf-8?B?SWFLMXppRTRwa1lMRjc4SjJUTjJqUzMwOVdqT3ZyclViUXNmQ2ZwU0J6M0lx?=
 =?utf-8?Q?J5vB+OayCes0WuICj3LQYrbnu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8fdabf-7f6d-40a3-1f6f-08dcc2e08626
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:27:56.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OycQVcZHqxpCIqOOomoks2QNXiYx9xILkSitD5P420coPihWAX03PlfaN+K+ZxOqWfubIRzpNF6OBz266HCxpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

On 7/12/2024 01:24, Kai-Heng Feng wrote:
> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> connected.
> 
> The following error message can be found during shutdown:
> pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
> pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
> pcieport 0000:09:04.0:    [ 7] BadDLLP
> 
> Calling aer_remove() during shutdown can quiesce the error message,
> however the spurious wakeup still happens.
> 
> The issue won't happen if the device is in D3 before system shutdown, so
> putting device to low power state before shutdown to solve the issue.
> 
> I don't have a sniffer so this is purely guesswork, however I believe
> putting device to low power state it's the right thing to do.

KH,

I did testing with your patch along with a few others, and found that it 
does the best job to put a majority of devices into a low power state 
properly.

I have the details of what happens at S5 outlined on this Gist:
https://gist.github.com/superm1/f8f81e52f5b1d55b64493fdaec38e31c

* KH column is this patch.
* ML column is 
https://lore.kernel.org/linux-usb/43594a1c-c0dd-4ae1-b2c4-f5198e3fe951@amd.com/T/#m03d0b36f86fb4722009b24a8ee547011128db80b
* FS column is 0fab972eef49 being applied again

I also have power testing data from an OEM's system that shows that it 
improves things well enough that a previously failing energy star 
certification is now passing.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>

> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/pci/pci-driver.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index af2996d0d17f..4c6f66f3eb54 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>   	if (drv && drv->shutdown)
>   		drv->shutdown(pci_dev);
>   
> +	/*
> +	 * If driver already changed device's power state, it can mean the
> +	 * wakeup setting is in place, or a workaround is used. Hence keep it
> +	 * as is.
> +	 */
> +	if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
> +		pci_prepare_to_sleep(pci_dev);
> +
>   	/*
>   	 * If this is a kexec reboot, turn off Bus Master bit on the
>   	 * device to tell it to not continue to do DMA. Don't touch


