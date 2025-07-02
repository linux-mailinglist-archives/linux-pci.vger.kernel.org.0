Return-Path: <linux-pci+bounces-31307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CD1AF62E9
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 21:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0BB1C45BA3
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 19:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152D72E03F7;
	Wed,  2 Jul 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iFXUZU2j"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F11F1306;
	Wed,  2 Jul 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751486282; cv=fail; b=t8FEsBdr6z6iNhrO27FIM3KG69k1C4lJoHRAClB+XLIbI6SqvOyYvhUf7lnp2LZgJY4+AXGkwMJ5Al4xOOTqusxXoUdAGkoYzmwyjm3+hY+5bDVslpJTKcq6kqc0VlhmV9GzFxMhw/JxG5w3NuKDSRiw95NFUbglzAdminfUR80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751486282; c=relaxed/simple;
	bh=iIjNFlFP1y1pmpkjhx8TiRXF95958rc3LpdLncOoP2g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QG2n+ZXtrDfFzeITk8lu+ewAZhkxzkFeFjlf+9DxO4nQIOpFJzYIeI91jut30qD09+trCpSolXsf61k5LjqWSeXNzfyx70jhg9eKyOesO0GOtZ3mRZ7KdrXP4/6UcYtL1nNzGCkN/yI2Kefy986S4hQfAWJ+HqDq/KMMAAC3qO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iFXUZU2j; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3yaYbywit1zcMsPql9ML6GPFVHLuOwZVFBEwv/li8p7EBOGzt8N5rUYUOr5LutVE0d+qBumMu4Q6Kh6kDygskH27bxwul08H1Mgn6dl9vZSXQgnoquRf/PIv1IUlsHAbAEWGGCdfc2Wu3Lz2wqZRhzuLsPTSf+mzI+dkpOiO1Uzha+V1wNvRGdLZiqkypzljqqeJZxTKSd/aMOfuqjS2wRr9Zu76mfAwyKmAlsePiARuH8SXOafK1il1NxNAH5QlqrxRVSVLM9kN5NGrlIJtJxnJBMXFbvGFOs7O/luR1QZMtRgJVIFICpQ1AnHDu9RoDJh5rEt3yety67dTnx28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIjNFlFP1y1pmpkjhx8TiRXF95958rc3LpdLncOoP2g=;
 b=f/MNlqZkzD20jVtA23ql4Lu96056vR3owY5McFYLsDh2DSjHx6X7JnNlA6j0t4/g68n4VYc9WN3HOPeerm/PYi2iDj2ARyGsZMO2S4HOnCh7NOTBZ/A/AmnlOTUx45hL+pyEOX8tJFsU0Nw0aW8kRbJ8gfl10h2wOd1QzQ21lvzZwSJ41+F22W9dgn5jNtHJv5aXuWWjBWA6v3FYsFcYn/p89JxbllTKFKrVb1vmusprVUOje+pj2igv9hpkCslhchdF/CiYk5fuGGA1VKpqG9v3sdSwDm4VpeBe2ak+5qPvdUyEUjGwOYw9rKBmAL4MffeVhJNnUzylKVSr7JEyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIjNFlFP1y1pmpkjhx8TiRXF95958rc3LpdLncOoP2g=;
 b=iFXUZU2jKbjsOcp7JmHMqE8rOVmh5ik3RmnjKXsieeEAPQu1UDXi1FUBvOL0rYDM/QyvgWGBLe4v1sa0mq8TATfYe4Z37ytudzBwFcDaghvo84EWi9ympxHKFgvlW0xrZFa2hlAW2AZjY/qtRaOnFQ0cV4yc/On0dB38IoLyxXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Wed, 2 Jul
 2025 19:57:57 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 19:57:56 +0000
Message-ID: <4fa9908a-7350-4f66-b806-651ca1a3e6f1@amd.com>
Date: Wed, 2 Jul 2025 14:57:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/17] CXL/AER: Introduce kfifo for forwarding CXL
 errors
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-6-terry.bowman@amd.com>
 <20250627112429.00007155@huawei.com>
 <a76be312-9f27-491a-99d2-79815ed98d3e@amd.com>
 <c5dce0c6-ef8c-44fe-a0cf-aa8fcb856745@suswa.mountain>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <c5dce0c6-ef8c-44fe-a0cf-aa8fcb856745@suswa.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:806:f2::31) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: afbbec0a-38b7-4e4b-65a1-08ddb9a2bcf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZC9UYWFzcFhHdmpoeUEybnl2K01vUWRnRDVVVDJwUHRZZG00MWxPVUk0bVZ1?=
 =?utf-8?B?MlFIT2RCNkFiRGd4SWxTRmV1UW1tY2tNUnpCUGJIOEdadER5K2dNem00WDVh?=
 =?utf-8?B?cjZ2bE92cDRGL0RPeXJXd3RTcGhUVzVTWFZMVHgyMWhyNGRKWUR6V0hUUFhy?=
 =?utf-8?B?c3N1eEVaYlpkL0wwTExhSnU5SFZvcmhyK2gzS0kvZ3AwZTdwSjNYZmI4em9a?=
 =?utf-8?B?NXlqb3ZPRklTaDdKMGF5NjBybDE0S3R0ZXgxV2lDclJJYWRKZ3JPUUN1Zmxi?=
 =?utf-8?B?d0dzMFJ3V0tFNHdDcUZsSkpFZzVFcXdyM041OW52V0gwYmNhK2VXbjJzQlBW?=
 =?utf-8?B?VGdRSW9LRzRWN0RCcGNoMDczQW5ZNUtPcHVsVXA0QXF3UmU3UnlNMCtqdWtz?=
 =?utf-8?B?YmFibzFhYmYrb1FSUFRlb3hQaDg0cFhXR2hhQVVGaUkxZ3prc0FBSVg0QnNk?=
 =?utf-8?B?MlBvZk9nZjViZHBTSWFVemluR1FLQkliUExaUlVNaUQ1YVllTUNWblVoL2tx?=
 =?utf-8?B?R1hOaUJkbnd0TlVSNjVWbWE0Q2gzTE0vaDFWSjhhNWdhdkpNdGJncmJCdm1E?=
 =?utf-8?B?MXRHejMrR1JnUk1QU1VtQnM2cXBGUFhrK01FZUdSUXJ2QldBUndjbVF3TDgx?=
 =?utf-8?B?empqUzVScmtmRi92emNBaVRvTmVNVU1NbUJCWkRsN0tFa29jSUx5WVR0S0lD?=
 =?utf-8?B?cnZydm4wRTFHdFAwRGlPUzQzKzBXUUN3QzRKVy92Z1RxV0ZCbFpBMTVOQ3c0?=
 =?utf-8?B?Y0NtNDBrK1ZKNXBaZnRsZ2d2SFYrZXRSczF6ZjJ4dnloWDJLblJKT0lBdHd1?=
 =?utf-8?B?TnlUVXNza3ltVlJXSXBiZllXUHowYXlTekVKVjRmUUdmOUpHWXd3THo3L1k3?=
 =?utf-8?B?WXFXUWtadVpBZ1BDVXdsaTFUbVZzaysvTGV5MDBVVkVMYUduNElRTjBpcEtx?=
 =?utf-8?B?bmlidUtqOEtDVG5MM09mQmplMzNRc09RMnZUeWt6aVpEMWZkSzF2c0tSZUZQ?=
 =?utf-8?B?UnAwb250ZmU4NzZjK3NQQlo1bnp3dWZoeDViWVpFK1g2em5LYUpXd2JianV1?=
 =?utf-8?B?QVlTUVN4N2J0b25FS0ZSM0JPaE9ib3R2SkFjNHc2QWk1YVd0djAwRmgzS251?=
 =?utf-8?B?RWZEMmVZZm1jWG13M3loZUJES3JWV21zU2FoOGZicE54YU8zWjZFYWhDUTlC?=
 =?utf-8?B?VitnVlFMbXdzWG8vcWtUY25nTmVNUU0zVVpJZUVrT1llOWlxenRKcFd5anpo?=
 =?utf-8?B?RStpeXdVRnJwU1JrRGlOMWdtckVBbkx4TjlyYWFvRGNNR0ZHTUw1Sjl2aUF6?=
 =?utf-8?B?eHU5Nit6VSsweGN0czBzSTNjYjcxcnBodVNnZGdhN29DVXBIbDVjRWJDdWto?=
 =?utf-8?B?Mk50OENLU0hhelFURExGbWg3NUxPVGVFZFFkZnp6cDd5anhWYnRMWDJON2hp?=
 =?utf-8?B?eSswcWNkbnpFbk9IME9zS3hFTmtmQm5KL1NGelJpVWxBNVJhZjZ2RTlieU5o?=
 =?utf-8?B?aXI3aEo1cGp3UUdGMHREY1NDZ1I2RzNXTEJnMnJXbEJReXRrRDBxa2NUbnpW?=
 =?utf-8?B?cC93REo2OFNOWXNoQ0szbEZwYU9NdUJCLzhDU2h2dWZZOHZDdVdpaUJZS1Zi?=
 =?utf-8?B?L2FRK3JiK1hqenBTaWorVmRsc1RZTXcyMVBNMXF3RG9UZXd2Qk8zQUFDQklK?=
 =?utf-8?B?bng1eDlhY2lIZFNBMTRpYWl6TUlZTENQUCt2VmpQRjczY1N5WTJYMmNJNnpa?=
 =?utf-8?B?TjNESmQrZ1lYOTBEeGJhSXBVNUlpR3hVSFN4bXBDZ2hlK0RESmVkRmxhR1hO?=
 =?utf-8?Q?csEH7Exi8Ixem62iaX3WQDECUQniimNzxcqqc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmQwRG9zeFBvQlhOdWYyY0pTQ3JLTkNFeWVCd2JES0xVTWthUUNET1FMTHdx?=
 =?utf-8?B?RXRWSGQ5ektZMWdhOWx1ZHlNUVNSSm80SnRXQkNpYlo2Y1Jvc0p4NElNZHZJ?=
 =?utf-8?B?Y21zNWg2UmdTY0piT3I1RDVRVHIzZ1JKRWNhbWF1SytnQ293anNGV3oyVk5G?=
 =?utf-8?B?TVUyUlp2ektlbHMxQmhkWHFraE5BQnNZYUdCZldSMmdNOTZXOWcvdDlGaFQv?=
 =?utf-8?B?Y2hVeUFlQmpxSEY5SXB1d2JxcEdYU0M0YVdQVWN1MThWUHg4V2o3NGd2blNN?=
 =?utf-8?B?cWE0MVJRTjlLSHNTTzRLNmQ1aUg0Q0ZBWmVieWtvN0wvQ0tqUmUzL095akNm?=
 =?utf-8?B?RGVrS1Flb0FTdldVZE1IZUNkNEtUd3J1ZUtyVWZFc29aVis0UGJkTEphcm43?=
 =?utf-8?B?VFQ3ZTYwYzE1R2JHRm81ZGJlR0IyMWRTcXlmU0lpditabVJsTm8vc0I5OFM1?=
 =?utf-8?B?ZW1PUGFUcVBBQkVZQVNiV3JWTCticU94Uyt6MGxjU0VyYjY4RzFSTVJoMmho?=
 =?utf-8?B?dFZFR2NXTVpwQmlzRVRrdExmRzFTNkRZejlIWkR0dWIycVRnamlLaDhEaWVE?=
 =?utf-8?B?WWI1QS9KWjBidGNCdmZCaVE4MURYQjVnSnhsMHdvb25VSEhVdkdLNEgwRGUx?=
 =?utf-8?B?ejE4QzF0RHVnS0xXaUtVUE05NnByY1FwSWVaOEZtSytpeEo5QWdYUHViTk9I?=
 =?utf-8?B?N1ZHaVptRXg3VXE2M1JMS2xVMTVRYlpGVmxKMitJL1B1MXE2T3BOS1I5TjVU?=
 =?utf-8?B?UnlqTTFhMlBJRTl3WmExS0FNK3VhSTVRTzNqbmNod1lYSzkva1d3UWxDbnRO?=
 =?utf-8?B?emUvMTV5VzVZL3ZhdlUzQWxmN1J0UkkxSTRxTnF2R2FKTGQ0cTNHM1RXcWln?=
 =?utf-8?B?bHBLQmZaVXkxT1M3UkxTVlR4SGxnUTdMWVBiMURXaWMvYmZhMy9JNmt6WkVU?=
 =?utf-8?B?dGxSeWhVRVV3VjRDWFQwTVdtQTJoaDJVcXY0OGh4Z2pvbHhYWmxHS1FhTmw2?=
 =?utf-8?B?TnNGN1hKOUpBbGhSSmlnLzdlMDBnK2pDMStWdS9wMkNPN0FxZGNVR3NTOWky?=
 =?utf-8?B?eHRoSjhMMm5PNWsyNzhUZE1tWTJjQ3dMdE5oN1dNd3Ewclc4azdxTHBrMTdX?=
 =?utf-8?B?R09pM2c0RXpIQVNEY1V0OHFyVGJnMzF6K2wyMHByL0I2NnRHNUE5NTBRZWNO?=
 =?utf-8?B?VEZHK0NGRUR4MzhQRVUxdmxsY2ZrSm9pNzJGNnJMemRDbjJpK1JjVi9FNDFT?=
 =?utf-8?B?NHZpR2wxUVFTeCswV0tNVHNGS3RvVEt1OXNPaHdaa2xWcE8vTTV0bmZTT3Ur?=
 =?utf-8?B?WThKcEVqdXF4OERLTEN3ZnBkbEhORDVhYU05cmIzNWhLZmpxTlJDT3FIOGcy?=
 =?utf-8?B?ME9pNC91cXhBcEV1TnhrU3F3Nk9oVFZwbXVTc0cxVWhDZ3NPMUMzdEJxekdO?=
 =?utf-8?B?dW1tY0ZVUnBUYWxSMVFhbTMzcVpXcjNRcEVOUG5pUEZJL3VMbDNqYityUzRJ?=
 =?utf-8?B?WHg0RmRjNHkxVjFyd01EUnZ3RW8xMnV0V0xkZkU5bk1yaDhmWSt1ZTVXTTdL?=
 =?utf-8?B?OUlQUUpCVU1mK2E2R05ZY1R2NGluU0E1N0pBd3BubmJ5K3E3QTZVb0VGQndu?=
 =?utf-8?B?cTRqL1lYN2JYRFZvVDRnMHlHQzVaVE9QUjJkZkdpWjI3YWdYU2tBRmUybWt6?=
 =?utf-8?B?a2xGOGFoWFlTOGI4Z3JDd0tXVkhjRDhocUJkTDVCVW5zcC94WVg3R2dkcFZp?=
 =?utf-8?B?QXhuR0JudVY2aW5LVjdPeWRpVGk4Sk1UcDVrZkhURUd3a0srN01FelEyb2J6?=
 =?utf-8?B?YVcwdDRzUDIrb0tEcmZLSzJSK3F5NW1YdDFHb3liWHdTMU1LTEFSSFZ1MUg5?=
 =?utf-8?B?aUEwdHczeElSVkRrRmlkbko2V29TQnVOOENoNEdFQzZqYTg3T2lNeEtLQUhE?=
 =?utf-8?B?b21SOTV5UmNTRGZmQTd4SnY4VGFpZVhWcDhuc1F1MGNpdkJZWlc0MThRSSs1?=
 =?utf-8?B?Q01adGNKbjhmNkQwOXoyMWowQ29iY0hwbVR1d1BFSzhUdlNKNlRLV21SbTd3?=
 =?utf-8?B?UkNkOEozZ0JxTU5EaUFuRHQvUlRkRlkrTnYxSzVST1BFZ1lpbDhvbnhoVWlF?=
 =?utf-8?Q?UhunceqDOPQfAH4cVfKlOK42y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbbec0a-38b7-4e4b-65a1-08ddb9a2bcf5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 19:57:56.6763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwKlCbpqDf07uHx0dAI6HJNH79O8oYvn1pPk1C8Cy/uvxibb2yI9dm5C11z3Ww+kDfwtszHY+jOCtnEW1zJTuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050



On 7/2/2025 2:54 PM, Dan Carpenter wrote:
> On Wed, Jul 02, 2025 at 11:21:20AM -0500, Bowman, Terry wrote:
>>
>> On 6/27/2025 5:24 AM, Jonathan Cameron wrote:
>>> On Thu, 26 Jun 2025 17:42:40 -0500
>>> Terry Bowman <terry.bowman@amd.com> wrote:
>>>
>>>> CXL error handling will soon be moved from the AER driver into the CXL
>>>> driver. This requires a notification mechanism for the AER driver to share
>>>> the AER interrupt with the CXL driver. The notification will be used
>>>> as an indication for the CXL drivers to handle and log the CXL RAS errors.
>>>>
>>>> First, introduce cxl/core/native_ras.c to contain changes for the CXL
>>>> driver's RAS native handling. This as an alternative to dropping the
>>>> changes into existing cxl/core/ras.c file with purpose to avoid #ifdefs.
>>>> Introduce CXL Kconfig CXL_NATIVE_RAS, dependent on PCIEAER_CXL, to
>>>> conditionally compile the new file.
>>>>
>>>> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
>>>> driver will be the sole kfifo producer adding work and the cxl_core will be
>>>> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
>>>>
>>>> Add CXL work queue handler registration functions in the AER driver. Export
>>>> the functions allowing CXL driver to access. Implement registration
>>>> functions for the CXL driver to assign or clear the work handler function.
>>>>
>>>> Introduce 'struct cxl_proto_err_info' to serve as the kfifo work data. This
>>>> will contain the erring device's PCI SBDF details used to rediscover the
>>>> device after the CXL driver dequeues the kfifo work. The device rediscovery
>>>> will be introduced along with the CXL handling in future patches.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>> Hi Terry,
>>>
>>> Whilst it obviously makes patch preparation a bit more time consuming
>>> for series like this with many patches it can be useful to add a brief
>>> change log to the individual patches as well as the cover letter.
>>> That helps reviewers figure out where they need to look again.
>>>
>>> A few trivial things inline.
>>>
>>> With those fixed up
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>
>>> Jonathan
>> Hi Jonathan,
>>
>> Do you have an example you can point me to with a change log in the
>> individual patch? I want to make certain I change correctly.
>>
> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
>
> Just put a:
> ---
> v2: white space changes
>
> or whatever.
>
> regards,
> dan carpenter
>
Thanks Dan Carpenter.

-Terry

