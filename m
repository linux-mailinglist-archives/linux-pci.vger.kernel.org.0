Return-Path: <linux-pci+bounces-32244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D74B06FFC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 10:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7E31A600B2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 08:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C59028EA62;
	Wed, 16 Jul 2025 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CJ8W5uj2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3499D28C2DE;
	Wed, 16 Jul 2025 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653610; cv=fail; b=eiH7P90VHdj6IUWpXkWnV51FVD0KYL/0KPxLowPkSWhtViOGlDhxwqGurHg3+daKfO0b6NaYP9pzpwnCWLtWHhwk5+44pd0OJ0Z2+gcOWYYgpkGupaVexpSKYRG1CkmRcaoPqxRCn8UyFic00L9CxLGTeG5uPLZOLsTjaRKfL/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653610; c=relaxed/simple;
	bh=XMmTsuo1m9hwSxpxfIo5b2vAMeKi9042+gT+sKwnfOY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ZNFaW+1CMf26DjpK31yrgcGsh60/W9EZH1wAyQi3fvQXDT5Ny0suoSgFS9RIVY0Lj7IvdhDFvbBA0yNr0ewpNghsEuYAy8wocy0laGPo962GrB/ZeW1rQG6Grv01NTPZePNpHMv6aXtmgosS3H/eZo8fRpbIyiJN6vQQB/L6LiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CJ8W5uj2; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLSPTGYNw3Fj8YqLRj2egLRdVaH5UyJt8CnVzgVtQY4fsDU+GufLHuV6Kt/8XcSV/cykQFToc8MatQ3hXMQM9x+W34aM96DH6qRV6of60yT2272iYc1SJhhFNB67Blp7jfxFNdNUQc0NPnMSVxTHVDXPcUxXVGVifGu8uHSeatq/roGpZ89TzPJjnR2Ug8UeFOcmkB3L8At5KZ594+STr/Yn325+/2DefiVBVfojXKnav4jeUqlzTIYuH3SvT9X75AoACORgfez9Q2X9O3gAtrUOfoClmVhU+0PoiS872rurwOJrXehqAyWj8z5HRWeTMxJ0cnIBhiRlUKnhw+HzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bg569OzgIFNjuzOXY58IA1GzMk34MIfd7icc/Eoz/fk=;
 b=JD57z7NmJHsNWmQPmnIkmG8X1JS3zlENnZd4w07wFtNVHxODGs9mqjE1Kv/YAY8xctVig0lfO2F7B9RER9dLyvMA+n5i7RlKd7qP6q8BOiMDUfLiY7V6t46Stcz40flnLL6pQOdQHb2ZySNP3FMJ8zo9ffiyWJPPjlxLsUcb/qUAXLzif5HiC3jEi2Wi5GcAQAD2uhAsMM6JKRVKvLmRjUw6mNjEehmcv9eVL51Oel3uQLInCG1v1jQlvXDy/MqilMsV5zEtseAPCNQDeHOwMDhzStPOnCrV9a9r/HmuldBxnbXVLVsFp9sxyaOf/8fL86nkAAs6fzaSOowSUSO9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg569OzgIFNjuzOXY58IA1GzMk34MIfd7icc/Eoz/fk=;
 b=CJ8W5uj2wduOPiM7FLSSu7YMhT9Tp1g1vKASMBzO+06RPDyUC+FCEN9KzO3ZLdNgnHiChAacT83I1+sACItp/PsyM+9wlkwt0QC6IsRqaco2d1saA0AnB6KOKgjm/8bf0RbahHVUpcKueWGzYdLiN7YL4pmZG8Bt7kQthLBXT5wr0FZlLFSfeNVqprkgZWCJhIb6FMQwkMRK6CbvJJDJZlscireThjZXJz2cFvxrpm/2zNPAhzEJk33Zi3u8DQHwKxdhuufnf285Uqa1LjsutAdAKkQudlQOSXlqA5v/SfS88Ars9cDy2u+WzLwWsAMkxmGlF7wmO3WQ8SWX6ogtMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 16 Jul
 2025 08:13:26 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316%5]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 08:13:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 17:12:53 +0900
Message-Id: <DBDBU8IFSBBR.1KWPOHV33NCPW@nvidia.com>
Cc: <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] rust: dma: add DMA addressing capabilities
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250710194556.62605-1-dakr@kernel.org>
 <20250710194556.62605-3-dakr@kernel.org>
 <DBD5KXIOSD22.L4RPVLDQ7WDQ@nvidia.com>
 <DBDBNRC9VEU5.2MXQF7KLR2HA7@kernel.org>
In-Reply-To: <DBDBNRC9VEU5.2MXQF7KLR2HA7@kernel.org>
X-ClientProxiedBy: TYCPR01CA0160.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: a5cea6f6-ffd2-4526-3990-08ddc440974b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bksxOFpFc1ZEZWFLUW5EZ1Q4RXc3TjhGdlM2RmRHUnQ2ejdSVnJOWC9Jbmts?=
 =?utf-8?B?TDhtU0pJZlNVSTdNKzA0VE1tNDlib0Y4ekFucVRiajBuU0hWZDBuT1VvUlFS?=
 =?utf-8?B?ZHhudmV5Z1VCS0NSNUwwVHdESUxuc1JJM2pXeVFaZWhPSmhLNkF1UVY3YzFQ?=
 =?utf-8?B?c29WTWxEMnFCZ3pIUVNRVk9yNllhZ3dycnk5OVRiV0Z1NW40ZDBwR0M1V0g4?=
 =?utf-8?B?TlhwYm9GQ20wcXZkWStOMTdkNTY4SlcrSUJQc1ZxNTFzZjNnbVM3QUVnZnJp?=
 =?utf-8?B?dkowK09va2tIZzA0djhTMlNGZUkzSGVBbWlsOHc1QzVGNi8vU0VodTd3NU5C?=
 =?utf-8?B?Vk00Q09yVjBBOG5HbGlrTVh2UGlzWWd5bDJUSnNWMlRnaUFXT3FIRG5oZjh3?=
 =?utf-8?B?R2MwNCt1cDIyeHdhbnM5a0Z1UUE5d1dwT1N5UG1hUEpaMGhpekJtS3I2ZTNE?=
 =?utf-8?B?MjZuQ2ZXTDQreTAxd0daN28xQVM4NHFBWlVPMENlS2E3czBaTTA5OTdMK2FY?=
 =?utf-8?B?ZXMrRldzZHdMNWM0VHRoUGdHQkJnKyt6elY2ZzNBbGNCWkJpaDVJTHFoVlpY?=
 =?utf-8?B?UlZZUXZjeTJDVUM4cGxSbTVWeGxtVmtiTEFkcDd0T1pnYmZrWVlnaGpGZHRv?=
 =?utf-8?B?bHlGTWRqc3J5MEpnRy9zNUJpUzh2RGMvOVA3VXM3M1BrQm82QS8rbGtnTldJ?=
 =?utf-8?B?RmVzZnVxR2hpNG4xWFZhMWZKcG84RnlEbTFYbzgxbnhrRVhzUk1aVWZlOTNs?=
 =?utf-8?B?OVIxdnBpcWZhTG5xbzRxUEwydEdpa1BhYVl5SldISEFIRFROZHJmMTRtdGx1?=
 =?utf-8?B?Z3FMdkhUV2J5WDVtVTl2SXRBSVJHdEtIQ3JsMFpGTUFlLzMxTlpaVEdISnJj?=
 =?utf-8?B?SVlaRnVjdEk5VE5FdjB5UEltWUM3cUs1OWlwSW9zTnd6V29aOVB5dlpxZDVG?=
 =?utf-8?B?dm5oVjZNOW5TN0ZFUVdTNGhOakNEcjFobEhZUFViSldVbExrenpVekFHaDI0?=
 =?utf-8?B?MVM0YW5UUDU3ckc4anVETWs4bmZTWU1OOUlzNVVBcGFBUG5hN3VxYWNTMDBV?=
 =?utf-8?B?UDZ6ZnBFSlkzT3UrM2VyL0lOVVR4bGxBbE50VFhoWk1yNUxoNnduMjBOeDFX?=
 =?utf-8?B?STZCZk0zRkIvSWFjNUd1emZVazZSQlJSaGlJbi9VOWREUUN6UG1CNmJ5UDQy?=
 =?utf-8?B?Z211VG1rOFQvKzBKYnlOdVVYelJhdlR1RVJtcGNhY1AwYUxzT2xWd1NEMlJS?=
 =?utf-8?B?OG1yaXc5eFFVU2d3TkNuSkNSVEthOGRkbzBpY2tCU3R4c081QWlZSmRucU5D?=
 =?utf-8?B?Y1J0c3FENHJVRUNybk5aYUNsMHBndGZJaW5ZNGxlZXhIWFhrNnNhUmFSN1dK?=
 =?utf-8?B?SzdXeXorT21BblJ6MjU0dXltSVpyZ2VaUHpPV2JJRFJLNWE4VVcwSm41T1Br?=
 =?utf-8?B?a0V4UkFHRVVGMG05MFprZEo5KzRSVjdjYU1JSGlETTd0c3Jqa2hpb3ZucDho?=
 =?utf-8?B?N1JiR3VsZGw0eGlJZzJ0YWtaME9lZktXU045aTkyU3NqTUw2MGdYR01qeWRr?=
 =?utf-8?B?YW0zL3pkQmYwZXczcGNzUjltMytxaVE2ZG5vYjNoQzB6MjVhZnp6TVFWbitM?=
 =?utf-8?B?VXFsTnBRcTZCcFBSMzQ0REtRZDQzNFJLdU5RR0FZOTJubnFyQWZvWFV5aU9T?=
 =?utf-8?B?QkJPNTNCMVY1ckJkdytWL2dQWGRsTUtBZUk1MWpPaFFyeWM3L0lvbGpONSt5?=
 =?utf-8?B?Nm0rZjJzZWRvYWpaNDJlUEZ0YWxDeis4M0hINFNlVTZtUlV2VlUvVDZrV0RK?=
 =?utf-8?B?RlNDL3FRZHFKQWZGdTR3QWgwcHJQU2NPVndFSnh2M01Wdm1Ta2k1U2JJQzNt?=
 =?utf-8?B?Q3dvRlNzSWhWbmJkZUtPSDFzSG80cHpwazU0VEpGNHExcUhPREh5ZXZBYkZl?=
 =?utf-8?Q?XC2sPKX75kw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTBYdVA1YVZqaVAzdzNpOE5kcXUzNElCRWVLdW9KckYyRGR2eG02alpJMTZ6?=
 =?utf-8?B?K3ZRMGpVY2hpenhXemo1Z1FXUWdvc2M4dzU5cUVDUFZJMWpYUjAvYmtZYURG?=
 =?utf-8?B?d0xxRkJqbjBTMitXL0RXMkxiZjBMMlR3L1UwM0oyalJUclB3MWI0ejAxc3A0?=
 =?utf-8?B?S3QxdUhvTFZLQ1IwVlltZ3BqekhFSnBxNkNHLzVPeE1MWkJzVklOMFJFYTR4?=
 =?utf-8?B?QzFtdHFaY244UWFSSTA0RVFUV3d3a3BPWjJlNWYwaDdhYXNublBwbVlPZXIv?=
 =?utf-8?B?ZVl4Smd6SFJuL1VXNzM1cE5PWmdYb2ZVS1p3dnVTbTdlanc0NXFZVzlNZTRI?=
 =?utf-8?B?NlJldHQ5dEc5N3AvbGpkMGJqOEVWZ3puNnlzRS9tM25QdlZMSzZHY1VhSGVt?=
 =?utf-8?B?L1p0Rm1uTy8zdmlMakRTMFF2YTAxdVBacnZkWW9WTXlHd3dNVVVJNE5jdDd1?=
 =?utf-8?B?ZWR1RWxCMS9yenZGM0E3S2FMS1lsc0pFTldXK0FHNGE5S2VPZWs3UklFMDNk?=
 =?utf-8?B?THVBK1FrWWpIamY2d0NjOGtwTlZZRURFUWs5Y0I5SHFLNDR0cExjYi90SW5p?=
 =?utf-8?B?NUVpM0hOYnMxaTZGdmt1TVJoaW93Y09hNE43NmM4WlB5QXNyQjdadEx0UzFT?=
 =?utf-8?B?Q1BuTXF3ZUs3dXFTdTRsWFNvaXJ5ZUdnZDVpNnpocjhnbS9JNk1ZM0RFb3Ra?=
 =?utf-8?B?VWdTWDlWdnV5a1VMd1NFREQ5V1VvKzR2Y0dzMnRhWDN3Wmd2eFFqeksvMDZu?=
 =?utf-8?B?Szc4Wko3VnJwQkFzTU5QWXFkYnBkeDg5NWNaN29RK0ZncU5pdS9MNTR3a0tM?=
 =?utf-8?B?UGtZSDEzd3pLak5vL0xDS04xTVR0Vk5rSGNQRlJ6ZGwyUG1UVVlZRDJFVTJS?=
 =?utf-8?B?cEI3YlpQamMxbXZuWTcrdnpuSlBoNVJlcG9XdHAvUmpiM3VQY084TkoyWHJC?=
 =?utf-8?B?bEV6RGRwMzdZOTRKaXFpL3BQR29iK2tjSzF2WGxpTVhaVkIzY2xxa25jSFF0?=
 =?utf-8?B?Sm5PM0xYVGRnOS95TFhLamRFSFJ6b25CcXFEdEVjUjlRVitFUGRQdStXTEZV?=
 =?utf-8?B?dzVVVW5qR0hzc0VCNlNVNkxCRU5IYVRHcllHZE9ONGI5QW5CdDlMQzg2d3JN?=
 =?utf-8?B?SmJGckJjN29kLzd0bW5ldW93cTJJTlM2S29nUGpPMkRxbDFMVDRNV3JZNDlP?=
 =?utf-8?B?cjBIWnU0RUk3S3d1amQ2Y0FRbGhXYzdFdWQ2cmcxU041Z3djSnB1ZmhCN1RB?=
 =?utf-8?B?aFFSdGw3enJ3S0R0dDVxWHNPTTZmRFlleCt1MWZkeUtSSGpYMDNBS25ESHJj?=
 =?utf-8?B?NnpYM3FpNkVuQXVoL2FVa2VmUzhEUU1RUk0xcFliRWx6eWxyZkwrYVpUVUp6?=
 =?utf-8?B?c3FUQ2dJZSs4Z0FBcitmSWdUa25TTUF3N2dsckM1Nmw4bVY5Sm5jSEU3Vmtr?=
 =?utf-8?B?ZmJHa0tiRUVXQm1zYXFMZjd5RlEwc2RDbGQ1UUZ2bThCVk9lY2ZTdDlmK2I0?=
 =?utf-8?B?OVc3UGZvRzJKNHpLc3VvUVVQOEZaemRqaDVUckNhRUo2VXVZelZnUlo4MjlN?=
 =?utf-8?B?QTl3Tk16ZENoZU9kbCs3eHcwcTBwZG5CZ1RYM2ZRbGxFYWMzbk1OWDc1Y00w?=
 =?utf-8?B?c28zL1daaktoV2xqSHJVN1JZOXJ3M2szRWZ3eVJjV3g4WUZhZW5VSXZIWlp2?=
 =?utf-8?B?MXVkYlpxS0xGcDV5bHZ4SUE5OXJ0UGt3UzBCTjR4ZjFMWTB0YkxqWW53d0F1?=
 =?utf-8?B?bFM1Wk1kQWIzWnF2dHVBM09BRWY2Vlo1TkhyTVlkS0VFY0FUeVliVTdDd3NJ?=
 =?utf-8?B?aGtBSHMwWTd4dlZUWFhxczgxTlB6UkNMNTRYbWtnQWJ0UFhySWZWMTBIN3V2?=
 =?utf-8?B?d1duQldtSzQyUDFvSnVISmRueHlJcVBYSTdRMnF2WEVJSzNGdUhQWGRWb01Z?=
 =?utf-8?B?Qm9pM0Y5YlpSYjdjUG0ya3ZYOGVwbkIwQTJvTWMyV1hST0I3VVpQMHBleVVH?=
 =?utf-8?B?ZnZJMHRiRDJhWDJPc0JjVHpJamRqaVZYNzhrVXYzZm14Y29oL2J4N0RtdUVH?=
 =?utf-8?B?YXIySkVmTm1zM21SUGtzUGhKL0U4S1BhcFgwd1Rkemg5NHBuczZEMmtzd29X?=
 =?utf-8?B?NUJoamNoakl1cnVkc0wwU2VmMHV5NDVURVpUUkRENGh2UUFGZmlsd0ZSQlVt?=
 =?utf-8?Q?LgONNzZKZ2W7LDCS/Ym+3PvTdnEa3kKKIHok8f/FUa48?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cea6f6-ffd2-4526-3990-08ddc440974b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 08:13:24.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTzxe6tp+JQCrA75etgfQwayTPbo5DaUQg7H8GvI0X1PuRgYLkkUM57QOAo2tA5t0Qd8duTpuhcHKc5Y+SKDSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951

On Wed Jul 16, 2025 at 5:04 PM JST, Danilo Krummrich wrote:
> On Wed Jul 16, 2025 at 5:18 AM CEST, Alexandre Courbot wrote:
>> On Fri Jul 11, 2025 at 4:45 AM JST, Danilo Krummrich wrote:
>>> @@ -18,7 +18,83 @@
>>>  /// The [`dma::Device`](Device) trait should be implemented by bus spe=
cific device representations,
>>>  /// where the underlying bus is DMA capable, such as [`pci::Device`](:=
:kernel::pci::Device) or
>>>  /// [`platform::Device`](::kernel::platform::Device).
>>> -pub trait Device: AsRef<device::Device<Core>> {}
>>> +pub trait Device: AsRef<device::Device<Core>> {
>>> +    /// Set up the device's DMA streaming addressing capabilities.
>>> +    ///
>>> +    /// This method is usually called once from `probe()` as soon as t=
he device capabilities are
>>> +    /// known.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// This method must not be called concurrently with any DMA alloc=
ation or mapping primitives,
>>> +    /// such as [`CoherentAllocation::alloc_attrs`].
>>
>> I'm a bit confused by the use of "concurrently" in this sentence. Do you
>> mean that it must be called *before* any DMA allocation of mapping
>> primitives? In this case, wouldn't it be clearer to make the order
>> explicit?
>
> Setting the mask before any DMA allocations might only be relevant from a
> semantical point of view, but not safety wise.
>
> We need to prevent concurrent accesses to dev->dma_mask and
> dev->coherent_dma_mask.
>
>>> +    unsafe fn dma_set_mask(&self, mask: u64) -> Result {
>>
>> Do we want to allow any u64 as a valid mask? If not, shall we restrict
>> the accepted values by taking either the parameter to give to
>> `dma_bit_mask`, or a bit range (similarly to Daniel's bitmask series
>> [1], which it might make sense to leverage)?
>>
>> [1]
>> https://lore.kernel.org/rust-for-linux/20250714-topics-tyr-genmask2-v9-1=
-9e6422cbadb6@collabora.com/
>
> I think it would make sense to make dma_bit_mask() return a new type, e.g=
.
> DmaMask and take this instead.
>
> Taking the parameter dma_bit_mask() takes directly in dma_set_mask() etc.=
 makes
> sense, but changes the semantics of the mask parameter *subtly* compared =
to the
> C versions, which I want to avoid.
>
> Using the infrastructure in [1] doesn't seem to provide much value, since=
 we
> don't want a range [M..N], but [0..N], so we should rather only ask for N=
.

I agree that a dedicated type limiting the possible values to inputs
that make sense would be nice.

