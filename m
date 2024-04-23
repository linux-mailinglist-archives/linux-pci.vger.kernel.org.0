Return-Path: <linux-pci+bounces-6553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A86F8ADD61
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 08:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA341C208DC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 06:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AB6224EF;
	Tue, 23 Apr 2024 06:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NEGiVzkH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B918AED;
	Tue, 23 Apr 2024 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713852961; cv=fail; b=GwsYrFqCjcPuZSXwxgfL7V/R9ATT9lBR7UhDWVieICODHlcDcwEIPW5DOrAXffDbgRHhBmbIBRvSvzS+tNik33LAmtxW5WtN++5T5GEtRdhgLM1aXAurS3IQCZkMKHIt6+kTacv9P9WGWjHBUjhDjNRxZdYrJ25dK0FyaTjxKPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713852961; c=relaxed/simple;
	bh=E90vUCQiZxbA0wa8s7kM+YwO0MrLmHZLSLOoNQsdpEk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KHN2KFrVoIMs07Ka44vQ9YXYCitLlik9Q9VoKpsUHEM9nRulqxWnwT609Zx+pGJPRsHhYthrNfgl/MDuqiplmLF+6D21V7yOZ+Z2Tx5JzLf699G5cLYCqZWvOPmPtfTpwDoTtY4HFAsEYasqPZr/vYm0di9phBN78nV0F4h/Im0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NEGiVzkH; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIFLv42v4Ygfu3CNLj5aBpEWnHzk6TzkPQ7YS3ojRqGptwCnxX32Pdoi8BGlIYmtNKznf32HKjLYqx/NbM/77n2G6txv5A+BTEod408eosXCB+Q103FYtw9Bd3gIwSK4KFJgKygTghbAjHznpzsSnmG4/zynQ85XkUe4TQm/hDsvEw0SNHcQQiw4FUTdqta/xhdwVNrrTEpgl91guLmtODuKvVdis5OFDRRipc9sS1+oX8Xi6Jdo5CUzaGjqZ30dc0ePxonpx8rZYXtu5OwEL91li3wVasy5nLiBERqCLOYR2bJe2/NQGvXJ8y0q+7EgVDMsoGGjhw4b3n0QZUbNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eCQaUbUmUUcPwIKhhFIDLNg8/z/nv3FzXvKFQvLo0M=;
 b=bqTly3Na0L7w7LkaI+L31KEuD63rQV9Zj19OX+TJVX4SNO9XXY09Cv82nhvwWzZwEZg4xyUnEL1bcxJjCqeXkbO5xRY02WWNc+x+AHVdOXV2TUiXxIN27WOPkzUPMg9vo5ZESJy+TNnV1vmngAVgG6hDHOHAAdfdmfXQZAbBgJV1MgRLPOMizmwBbFonHDIsMENJLPaQP29z0bkEjQ98H8gM8kmYriRCZ6vER5bRi3HRvTXrPdn5ixtAc0It7LOtLttBmgroYOImfTHlf4bq8Axeec4h21qn2RdmGTEgCqv3KulmCNdUNV7cab7C7WSa3JybLt2dRG4JFylOP7IxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eCQaUbUmUUcPwIKhhFIDLNg8/z/nv3FzXvKFQvLo0M=;
 b=NEGiVzkHC7Dol6olYVG3kDU4cc1ERiaYEkanOpO25pkG7SIrOMViB8Em/GcB0GUGJ6mtl0p4Zwqrx3XIU4cfP5XRz0B6QU8vsNXg0xsKXU0nwiKxSOUpwRqxvZrNp8s7SkltdWmztAC63kGg79R+rJ/2bylxuYmxsWiav2FNzd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 06:15:57 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 06:15:57 +0000
Message-ID: <6f7355f6-ae84-4246-83ad-3450e036b111@amd.com>
Date: Tue, 23 Apr 2024 08:15:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] [RFT] arm64: zynqmp: Add PCIe phys
To: Sean Anderson <sean.anderson@linux.dev>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240422195904.3591683-1-sean.anderson@linux.dev>
 <20240422195904.3591683-8-sean.anderson@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240422195904.3591683-8-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0243.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f78af8d-28ab-4f81-c468-08dc635cd6c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDRFZ3NpZkRKemlDejlEUThqMForRFpqTWxIVnB4MVpicnhuOS9xbEEwbzVi?=
 =?utf-8?B?M3JwVlh6V2RvTnY3dXRPTGV1Znh3NzlQdUYwVDdnYUtkQmRwWmNpM0hWdGJB?=
 =?utf-8?B?V25wRnJVeEFXRTBqaTVSRjdwcmxNL0E0cjVXN0t6UEdlalI0aXpIbTBsUmRX?=
 =?utf-8?B?NWlrNXJFNUcwWXV5RzN3WTF3NHAzY3g1eHdRaXZYbmtvd2hwK1JrZG5iWnBL?=
 =?utf-8?B?MDM2ZHRjZEVkS0ozbm9pQWlYRE9KL2EwUGVjVElFcGJDNnVLczQ2dWU0bWRt?=
 =?utf-8?B?UmJLaWw5NnZXcWY5Ti9oUXJ2d2hxYm1hNUJEaUpRaHZOSk4wVVA3NlRrR0Zp?=
 =?utf-8?B?WWttNk1YeUMrSXc1K2FGRm9tTHE1OGxveFVhZkcrOWx2QzNHa1ZOeTU4S2xQ?=
 =?utf-8?B?TTMxTFVqK3RhdkFTVEFTNGswUWE2YWExdFlyUDhLV2xlcE5MWDlPUXc4Mmds?=
 =?utf-8?B?RU5LYS85TTNzVmtkNkdmM0ZUMTZPOS9hNVA3NFJLT1JzbU9pQWZKNHFLbXNa?=
 =?utf-8?B?ZnNSbCtGbEtETWt2SlBRSkswMk5kZ3pwSUIxY3FBMDhqbzhVd3V3bkkzVEl3?=
 =?utf-8?B?VWdvYlUzVWhrVzZHSEgxVDZCOFNVb0d5aUVpVXNGaFh5cSsxNkJlRUdnL1I5?=
 =?utf-8?B?THNydmRaM3l0MUJheUMyYVo5N0R6aFRyYXEyTWQrQ2VsVkFmWEUrZjlwQXcv?=
 =?utf-8?B?cmhoSThDK2ZGRkRGYktyN1EzODdtUUsvRFpsQkF3ckJvajVDeHFwdlNLa3Rw?=
 =?utf-8?B?MFVkSityNGdia09HbXZOdmxVWlptNnRGbFFEa3ZPRG5LWkQza1lxUkVvNTJR?=
 =?utf-8?B?WDkvYnVVUm5yVFAwVXJDNmRHd2JSMWQzWVdBYWhlblRwc3FWUWRDQXNLMlBU?=
 =?utf-8?B?ZWZrdU5vOWJyUS84R3I1c0FsMXpETjZwTUkrMXh2TUZCMmwzMnNTNDRDdzRa?=
 =?utf-8?B?MFpkdDJvU1R1UEpaOGtjOXAwMDgwUVJvcGhzVmZ2alN3dG1KOGxFbkdJSEJl?=
 =?utf-8?B?S2VYMUFxenJoQ3NSQjRsVVVzMExWemlsRlVKTSt1WDIwM0NUaExhQmJSRmw3?=
 =?utf-8?B?aXh0a1ZMWWRCSkhXRDRHTmp1am9yRFFFTlpTM0ZHa2NCN2F2T3owVitGUk51?=
 =?utf-8?B?M08zajV1STRWaGtUWm5WazlkaHdNbnMrUzJ3QkZFMjZWNks4SWlnb2dZZ1Ex?=
 =?utf-8?B?R2M4aE1ycnAxU3ZySjZrckxzaGpJblZpTVN6eHBCZVdqVTE5OGRrMFJERUpw?=
 =?utf-8?B?QUhyamh3ZUZ6ZFNpclNzWVE3WStPQkRkTSsyendpNDBhMDJ1TU9wVWJBUW8r?=
 =?utf-8?B?VmpwNmE2N2hOMkpYWlFvMzhEaWtDWmE5Ry9WV3g1M3hIR2RVbGFTNnU3TG8v?=
 =?utf-8?B?RTZrdmxHeXpPUmNnRkg5TXNkM21VUWtPRzdKZU5RQkRTMEVlb1d5NStPbXJK?=
 =?utf-8?B?VklHZm9aVC9KRTE1blRNWUo4T2JJSEUybkxBakxON0dxOXliRGhIUURhSUlk?=
 =?utf-8?B?YXVPL0Q1NDdRNHpDSndBWFh3aFpjc0VJcDQ5aU5adlJKVExuQjNReXpia3VW?=
 =?utf-8?B?a2Y3YjRsTUM4TjJ6UkpMZWZQSWVJNzV5TGYyRUtMSUw5UkwxZFJaL0p5YmhS?=
 =?utf-8?B?RkEwTzA4U0Q1aXJiU1Y0RkUxWldnQ3pKbjcwbDlFRHJmWG1MaFRNNlgxZXZS?=
 =?utf-8?B?UktmdDZjbmZLZTdzRmx6WEd2U2hmenJiZmNnYVpiNmIzbWEvcDVyS1BnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEp3ZXBQWGY2MWVoKzh2d3FsdUpoUUlpSTVmWTVvN0JuTFhkZVJPeUtvaWtZ?=
 =?utf-8?B?MEhUckxlUW96T2NFQ25SdmdUck1tMW5OeFpsTVRjS0JxL3dScjhadmkvMGFE?=
 =?utf-8?B?aDVSWWZTajN4QWtjVjBuQmlBdW9ISFMxZTl4UzA1ZDAzWmNmdWRmMUl3RjYr?=
 =?utf-8?B?RStpQXIwU01ySjN5akd3eEVqYm53TUZYbFcvQ2NNMDJNN2thRFI3c00zUDBh?=
 =?utf-8?B?NzBTZVpzUWdtcWl0cnNzODkrVVBwUmhMOTVXSUhIVnJ2ODIzRVI3ZmxUc2Vp?=
 =?utf-8?B?U2hHNC9VbHNDVzBscVN4ZUFQdDRFbUdCQTJjeXdHN1JBMVU1OGNBV014b3I2?=
 =?utf-8?B?dUVaZWgrTnBUNkczZHU5UG56TlE3c3p1VGd3WnNXc1F1UDduWXEybm1EQXFx?=
 =?utf-8?B?ZGVGVEJFQW1wR1A0OFBGRE9JcFdLcEFHaVlES1FNMURzbENWMFhjK3F5VU1O?=
 =?utf-8?B?bXRPNlJvbzgvSE1EcEU0cHY4empwY2dITlVsYkNWcXJSZ3MvYXVrSDFpcGJS?=
 =?utf-8?B?WUNoSVNhd2VPUFFSM2poZitaOWNHMWw4TktMNWFEcDRicHllcG5pWjM1OWtR?=
 =?utf-8?B?ZlVET28xeFVaZVg2Zi81Y01vSnhWSUxsRmtBTTY4emFvTklDTHVRMWJWSTZW?=
 =?utf-8?B?NklWd0tyZzZCZXRUalZBN2ZUR1ZpUVE0WmY1bGs2dWlYb1FOVm9kTEtMclB2?=
 =?utf-8?B?WjJtdHgyRDl3SEx4dTVYVlhlZlA3NmsyMGpJMFZoNnFFSjJieUtnb3QzQllX?=
 =?utf-8?B?bFZ3dUVpVzJSWjhZZlBITnozUFMzS2o3ODRKMUhVS3ZEYnkzQkZaZlM1TzN3?=
 =?utf-8?B?RHdTckczZS9VS0FiWWdjcWpDdm5uaU1uTVpkTE1NRjNxTGF6NlgvNW1hckxF?=
 =?utf-8?B?SEMweXdndTI2eVJCUkxwUkVFNnl2TGdlVXEvVGplNTVkVmd1MlcrTTNiUkZY?=
 =?utf-8?B?VTFMUllSRWRuN0Y0Mmt4Umc2RUZIM05wbnZQbm9UUXZucEg3aTIrZU1FRjVL?=
 =?utf-8?B?b1ZaWVVwYkdQSnh4bkJGckNkRVAyYU5kZkI1QUE2RkJrM2dlNE53ZEVWM2Mx?=
 =?utf-8?B?ZXRkV0EwRnphVVNOcjdFSWFWWXNIZHVCZlIrcjJEcDU0cFA3TU0wUkZYeUhi?=
 =?utf-8?B?R2hoVWJXUVRzY0V0ZGJXTkRZOFB3eVFmYmE4MkJnWEt1RS8xZHZIUk5xb05O?=
 =?utf-8?B?aVlpbStFTlo3VUxvZWdVTzZsVk5UczhBY2M2M2dUUEYwUG1wcTZPc1FTQThL?=
 =?utf-8?B?a2xxMlJ3U3d3dkx1SCt5Z3NRU0tpTmd4SXpTdGM2UkxEQmtONkNzb3ZsTTBj?=
 =?utf-8?B?SDFzRk9BQ1ZHVjkrZnptall6SGRrdmRMNEQzTUQrRTdWSWpZYmtMa0F5TW92?=
 =?utf-8?B?RW1VVHd3WGx0elpKbWRITit1YW9KOGJQekIxOGJQTG9tZ0lGbFNMdCszQ0NS?=
 =?utf-8?B?UlU4MHF1MHhJM2YwTVNIREdqemF5ZVpaMXBIUk1wYytBRUN1Q2lycm9YNTRr?=
 =?utf-8?B?UlBkTks3QlNGd2xEZlBXVjBsT1UrMm1Xd216STlKQllydkV0QWZQcWRyZGFz?=
 =?utf-8?B?Q2hWNEpDclo3VUhyanU3RTVsS000QTBnTExrV21yQndYUW9DUmdwUlpFNnYx?=
 =?utf-8?B?Yy90YVVvZ3BUdjJYN2lQWFA5bjFtU3k2UDZMKzdYczJOQ3Zsd0Y5bW51WldD?=
 =?utf-8?B?Z3hvcUgxNVdEYWhlMUI4WjVZdVRUVC9iNEY1RGZwOEVKdk9mWklZWStMN3NX?=
 =?utf-8?B?dzE4ckxpZ1pBeVd4SE5iang1by84eVJ1UW16MVJYRzRVajJiSzZmZ01RTGx5?=
 =?utf-8?B?R3MyS2F3RlFiYXdyNW5wRUo4bzBmTnU1WVpiOEJvUFluclZOS3hsMDMwR3Jz?=
 =?utf-8?B?RkY4WEVDbzFCclkybGdrbjhreEJQaWNveDVUT2d4QjF2K1ZSQmphUitBTG5k?=
 =?utf-8?B?cWh2WUpseVRRY2xHOWxPV1p5dWpPRlBqbTZMSnNTS29YR1NMTmhHcFBTZ3I3?=
 =?utf-8?B?SGRXdisrWnJ1cU5sZXl6WTlEcCtoQmRySEF3VFZsVTlRY0FBZFA4UEw5Ykx2?=
 =?utf-8?B?OTZFYVM0VjdnV082MC9malhVWENZVTVpa2RyL2E1SGQ0N0dGaEdIcmdiY1pq?=
 =?utf-8?Q?phe47sNmmol3J/5CKTPZoioqp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f78af8d-28ab-4f81-c468-08dc635cd6c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 06:15:57.3569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqVnPmeuAFDDbCQ9ppJlyD65rH+WxkHOofamSQZVCgekWKyK78lGKEP3Mru4E0hA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929

Hi Bharat,

On 4/22/24 21:59, Sean Anderson wrote:
> Add PCIe phy bindings for the ZCU102.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> I don't have a ZCU102, so please test this.
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index ad8f23a0ec67..68fe53685351 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -941,6 +941,8 @@ conf-pull-none {
>   
>   &pcie {
>   	status = "okay";
> +	phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
> +	phy-names = "pcie-phy0";
>   };
>   
>   &psgtr {

Please review and test this series.

Thanks,
Michal

