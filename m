Return-Path: <linux-pci+bounces-34908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2B3B37F96
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 12:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07D6360324
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 10:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96A42F9C39;
	Wed, 27 Aug 2025 10:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="G6j39L9T"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011036.outbound.protection.outlook.com [52.103.67.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0612D34A31C;
	Wed, 27 Aug 2025 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289684; cv=fail; b=VVN5RdoVfVP+vMfSxvEYAHXBpRZ+BPIyMJbrtidg24RRoVcgjWKteQu9u8GLobB2Q/+rMehKCXujHIsiT5kXymptBYGjA6vzexyTjcLzDSdrH0PyrGOnZRuLsh8dFIh7n09pWOo9ugfluKd9LcM355LJYL81q5cJCr1t9I+bsD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289684; c=relaxed/simple;
	bh=JehgWv6asjN8tjkPgOnB/8ioMCOvhuVG11AIOkDb53U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qb8GiM+kVL8yFvxpiX76kUy7WHw311nzGF+QddWE/X/Sruedox3rKh4StrQ93ec2gjt+g5175UXM+OGVfJC191oZQRB92XM4ulxHdosJBlY0jeRV2R9DneWq1XlB8CAGE/QnZfMFUYfBS3SSHbEWVuEfoCGzhYfYpvjrXE1X9eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=G6j39L9T; arc=fail smtp.client-ip=52.103.67.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ds409OIxMG4VGc5tr7CmGh7PzdJC1NS8OgvYR909NWTrBWnAb/Jl+LWnqZFv8ZZMmrQlqwghqUHxe+4+baG4QTgESCSr8AKNao5etr9uHCUsVQw9Mk/dnR0oWgA7jAuyEeaoN1+2IyJdaj40Rsh0r8+byefE2qNcYZh89kUy9Qb3pLuaVvPkI2I/sedGutL4CjXlcFIbsogFw8uS9RJcoW46bcytmPBmOlksBLlprDhpFGipcULnYJg9uYVY1m21W09gyvgSE9Aob9wACOMnFwhQ+ktoEmwDkObqT83vBoGFpkSWkoIbgfLY71IPk5++aa7j4YzljuLtmkmrIVRx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrmP5RkHunAp1p2CSYNA3okhHGhqCeTJOmFNqLXnUIM=;
 b=fw9qJV0VuzzSrxTYEQMt9ANckWJscTFHEjKvdGO4bzDcwMjBfNK4IRZlHUXO5F1RmXFpUg2hdXz8ft5PsDtY1VvOj9NzTobbk28azXAmy3JSEzL8bLUTMeBDd/RnHQYHzHOGBht7y6vi6Ai0DUT7y1/Sz7uSlnAS22H7yivLt3Wi4WTbM8fcfezJugGw5/aRTMJqcjcgu3tTEsrXxegCRYMfMRCr4b55Ya2aToJgYqon+N5i+aTD9cHAyEikpN51braUIelogHPkWYchFsGAJwGV+w4H4sLSNU7sg6aZS14MUxsCsc4hYmhRtJIeNjlNsz0nwYaanHoicTd1vEZ39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrmP5RkHunAp1p2CSYNA3okhHGhqCeTJOmFNqLXnUIM=;
 b=G6j39L9TDwADwTdEnyD+wRA8XRA4rI0EWTxvJhJJDppHe5jHMpHnpvhS0AMn7xmMs8OJl9R9+08yeBb47or4tMVz51REObd4oMx5/nSVjlXE1snFBOO3rQHWw5DnTsFBQBYe560/cecNpm8NBTid8BCspjYJw3A6OyTpjmEc1Nt/f3dW/5L8pCMGGF3xMSRYrwSgQNU6UqP3lyRZKEUv3M5grK7xjfcBaCVTaP4VdfVZlVzYxbf5PJGejhNkT+EOqDPARbMk+xYXd+NkEn4F9vcCVfzsjORKW5MvDLrOq54Y/64jVOSO5emRtAY5GIPrXHw1ohR+Vcp88yiqCqa5IQ==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by PN2PPF67B3DF79B.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04:1::1aa) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 10:14:30 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 10:14:30 +0000
Message-ID:
 <MAUPR01MB11072150E8F3640550092DABFFE38A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 27 Aug 2025 18:14:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] PCI/MSI: Add startup/shutdown for per device
 domains
To: Wei Fang <wei.fang@nxp.com>, inochiama@gmail.com
Cc: Jonathan.Cameron@huwei.com, bhelgaas@google.com, dlan@gentoo.org,
 haiyangz@microsoft.com, jgg@ziepe.ca, jgross@suse.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 looong.bin@gmail.com, lpieralisi@kernel.org, maz@kernel.org,
 nicolinc@nvidia.com, shradhagupta@linux.microsoft.com, tglx@linutronix.de
References: <20250813232835.43458-3-inochiama@gmail.com>
 <20250827093911.1218640-1-wei.fang@nxp.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250827093911.1218640-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <6510ca31-59b8-4cb4-a748-5e1fdaad96e3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|PN2PPF67B3DF79B:EE_
X-MS-Office365-Filtering-Correlation-Id: 722414ea-e60e-49d1-a12d-08dde55282b7
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3idnJD6lc/nqZLIFT+Fye11AWCIkcLfOdncB7pa5X4beYNRF1Eg4JNWNO9PWvGbHmp7ad/JKlPSZkQo4Wg3hOhzNjkOAnEOCAMp/tcmGKNTAB5YQEl2NmDPrwX6/v/gXX5mAhMnfh3uKb9cN5GchQ5lfNojkXMvo3pvQSzJQn0X+8Z1PNe/WwpQi1fuagmaV9svYaPxP7mOXOUEp+NR0msKSXg8HqEDnt72HoxRR3WemxD3fMD9drWzS4FR13YVRo/oFh8XxAxIyA4zortEnFtr0bMr5gJYsc/iYowo5yi/3zioB7lq5pO1jmufqjAPVgrZBuroR3HpEINB44oT3L96qOF9ttbPjTqyaL51SDJ4pMK1hxHosM6OFvdpg/VcMH+rdmOmfK6YmWYwwaV/fLgFXDQPCtHubKFqG16EcUwzNwrnRkVybRzQWdZpmsfs/rj4lTBfHKCIDvWceNbYgb7b9jwxhhSz0/utgHCI5INqjIb3uB3tzLhpGfUA1+ciBtbdxeQTAOIM3JHAuVMwXQkynhH5Y8Ta9UgzDiD/LUH8fPob4ss0C55MWQ49gcYmeSItO2cxvhChYG6n+8d5CAx8tiYwB7Gb7QSO0/sbqqP16Ql7JqcVEU/ZxwsG11/LivaiWcDPBENPhIS0M6gAeCxEQkC7AaEZpOVvOmU9V3VK52d7Cs/5BfLPT5BudV9xnXyAZATa1djxqbZkOvyZ37mEkjYuLn0jfj/V/8eefCnSsN4gkLvSWhqyt8uEzaTJg05K+OBNNiEJQWLXntoj00cDj5/vxyaR8e0=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799012|461199028|6090799003|8060799015|41001999006|19110799012|23021999003|440099028|40105399003|3412199025|51005399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTVQOFhpVmQwN2xzdGJ1Q2VlSHliZ1JGZ0svU2pFWDlwZXpIc2NmYWIvckYw?=
 =?utf-8?B?TnRvTmFoSmFQa21CY0JnK2FUVUxFWDlHNkRISS9WTFc0UlpyL1FiY2p0TitT?=
 =?utf-8?B?L1ZtMXRFaGN6ZkFPbk5uM3htR0o5UDVNRW00L2NSTGVYcVA2b1d2WHdYWW5u?=
 =?utf-8?B?U1pnSjMzRHhzMVlNTWtvS09Td1VMTHh0cVZnQWhhNDVMYW9SVmZJSEl4aW84?=
 =?utf-8?B?Zms5UTMwS0tEWjdRa2pVWmNZU1hNaVdHVnpVYU1PUit0elgxN1N4ak9SdVlz?=
 =?utf-8?B?OFNESXJxdWZRVlJOMDYyMDBCK2JxS0pUTkplaUE3S2FmY29XRnk0ZGo2OW44?=
 =?utf-8?B?SDlOMEV4Tkl2TWxoZU5KTFFSblcvVlIxWE50dEJ1VFZXdzdoaGlJWEwvUXRC?=
 =?utf-8?B?a2RiL1NBdnkvUkFZbStTSmx6a01naG16a3poQ010REsvcGFhS0JtVXFFNmYz?=
 =?utf-8?B?WkIrVWQ5Q04zb25ZZUwreUJYczBqY3pQRnRwRHgwOG4xZWhUN0g1ZmowWWNv?=
 =?utf-8?B?Nm5BR2k2ZERheHkvWFVwSy9YMUJValRXQ3dUd09MTzFaY01WM2JxbGdiYlVQ?=
 =?utf-8?B?dDlSaEE5cU1HVDN3dDBVTDdrSS92d3h4dU4zRkJhMytwUjZCVFpSZjdhNlhs?=
 =?utf-8?B?NEhmclkzZmNFVHVseC9WbVBGdlBoOXdCSGNvZ3E1dm9lZGVHQUZNdFdwZ0Mw?=
 =?utf-8?B?ZGtSOVVUeDdUelF5Ti9JTkRnMjM1M3p3VW43QXVjdkhHby9TT3RyQWppc2ZI?=
 =?utf-8?B?UW0vT1FyVVpRR2dBMWJ1Vkd5ZTVRdDhiRXJJRGNYd1UzRlJxek5Dc3pjMDBn?=
 =?utf-8?B?WmcvY290dHBnaDdzNWRhU29NcXhLNGR5VkdMejN4dUFndnFEZ1JhNFBiS0k2?=
 =?utf-8?B?ZG16bzgxYnNDT0ttc1FrMnJzSnFIUjdnNjErRTd3VVZ6OGFCTEN1OXdMOFRs?=
 =?utf-8?B?MjV2T1FkWlVjUUNmSXkzNlZ5Y0Y1ajlITU40S2J1VkJIN2Y0d2c1Q0QzS1BJ?=
 =?utf-8?B?c0pWR0lUeGVHTmgzRzN0TlpXY0tydHpnSzVzRWhNVE5kQUtncmxnZVpTVVJW?=
 =?utf-8?B?cmg5QStITDIzVzUwc1lVakdrUjlkckpHYWxvY2ZwTHVpUWJsSldCTitVczJh?=
 =?utf-8?B?ZlFVQTlXY3V4M09aRWxTb2xmK0FXWVd6ZjU2M25pVzg4ZkFaeGQ0OUUweUx6?=
 =?utf-8?B?WWQ1U1BEWFRDYjVvU0FWeGovK2RqWEJtZjNxRkpQUGFvdUs1WE8xalVOVFdN?=
 =?utf-8?B?ekJqYlV0U3ZDVDduUnRFSHNDT21QdThCSEtSYVFMSWF4SVZKdU9Vb016emFJ?=
 =?utf-8?B?TzBuRmxteEhUWjc5Q0tYVTkrQlNZcHNPZ1ZRcFB5ajhxZXVTOHNDRTdIUU5r?=
 =?utf-8?B?RDA0c1hxRCtJRmdaMStJYmo5NUxIS0tJQXI3N2ZhS0ZmdzVpb1RqTjlkVFZt?=
 =?utf-8?B?OGlKbWNOYmtkVkI2bzZaRDljVjU2U3pRcVZvMTVuNS9sOGlwaGxHOVVxcDcv?=
 =?utf-8?B?NXRVSEhKQXJOUThiSVplYWV0TjBFajNtZTZ5ODlKS3htYWY1UlVuSFNvK3FG?=
 =?utf-8?B?clBkcWs1VXEybkhsK29URkI4ekdXTHVEZndrcWc5VnlQcUE5WUtiamV6ai9K?=
 =?utf-8?Q?p9qb/0KomTAcnKqQgftSpE7vaha5bG5eQ1UBjFvoBqe8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUpTbUxCNktRUTJoWVZmaC82anp2QUQxc2JBbDdMRmZFNGtheWd2cnZKS05S?=
 =?utf-8?B?TnMvMWFYU09LbVJIMGN3RnNpSHhHR3E2cUw2ckJHUk4xd1ArREU4THozdXpv?=
 =?utf-8?B?clBDdlB1aTRCS0R5Z0dLUE04R0QxZm1VSnU5eG4yV0dkbmx1NlpUaXV2UHhL?=
 =?utf-8?B?VXdwNnhsZlhzVmgremp6MVdIQlVraFpRdlhhTktXclgyMUtYZnBPRUNoWVg4?=
 =?utf-8?B?bVdoT3kvZ2M5b3RKU1Y0bE9lRkErbTl6RDByMmtBQzFCSGhmVnpTTjh0cmJp?=
 =?utf-8?B?RW81cnNha2RhWmZ2eHBxdXV1WkdUeDlsOTVtTVZDOGs2Ymx5S2pqUU9INTVU?=
 =?utf-8?B?cUhGdDZ0TzF1NmNMb3ZNZ1ZEb3J3aFRkTmxaSTcraEwvdXZRSDA3TlZmV1Ey?=
 =?utf-8?B?RGFIN0Evb1MyakRKTkh4bVZRdGJ5MHROL1I0MnV0eEUxMHFRS1BuemRrbGZy?=
 =?utf-8?B?Vm9CYjJ0TTg0OVlNS1VkQi91ZlBHNEpKZ2E4OXV5U1dmbGxuNVRHK3U3ejAw?=
 =?utf-8?B?K1hXNnFGMllzZ2hvUHVDK3R0UitZYUlycUMvRU1rb3NQU2RTMXhNeXpodU5U?=
 =?utf-8?B?NVd4UjZzRTJEcUhqemFTUDhOZHA5UVdLNno5UlZFMnRHclZpMjZ3U25ldWFk?=
 =?utf-8?B?TmVhUmNiOGovbDZuejBnUThSa0xYakxWaEFuVHM1RktYYi9FeDE1ODVMNDNC?=
 =?utf-8?B?UnpzUU13TVp5VHhQRFQxTlQ4eGZyL04zSjBIYThhVzY3eWxacWk5d0VFaDRs?=
 =?utf-8?B?RkIwQURwcnAwQVp0WVA5eUgwcWo2SUs4T0M2ektnV2Y3WENGanBOa0Q2QlZn?=
 =?utf-8?B?Vm5ORE9TbzYydGJLRzJhUVhpRXp6YndLalRGUjVWS0N0YmJBbTBFZldSV3B6?=
 =?utf-8?B?a2tuQXQzcXRha3l0aG1jRE9LVmJqb2RrSG1KTFVNajJockRkSnlVeDU3a3hu?=
 =?utf-8?B?c3VNbVk0aHlnTzNiUEhmcnhqSzdYSDRzTGdtckxtREx0VGc2RFA0eTRvN1A1?=
 =?utf-8?B?VDVlUUF5aUFsbWxRL0ZmSHBOODRiL1RuNStpUm15Q2p6NzJLcFFrdy9TTlpl?=
 =?utf-8?B?andFQ0ZSUWNlNzViVFBBWVJLZ0hqVUJKRHFpSHMvOTJpZXgzUWd6RGxkS0dQ?=
 =?utf-8?B?WlNVNEhMNGZ0U1pOK2V0RU90WGppR3UxVVZ4dTlzK1Awa29XNTVuNzRoU09s?=
 =?utf-8?B?NjZlMFZTeWdKUldlMktIamttYlhhaS9OSjQ0dlZsZ2g3UjR6SENxdTgwL1Nv?=
 =?utf-8?B?dzlXaE5nSWVCbkhLUU1nVHJRYXFmZ3NycTErMk1IT2RsbWtpSGEzYzdBR0hw?=
 =?utf-8?B?Wkh3bTY4OFlEK1Rubmx6WmlldXdiZ3hWS0h6QSsyV0xTSU1McStMS3FUeUlS?=
 =?utf-8?B?cURONllPcHA2V2lIaU1jd1FWMkFlZ1JiQzROQWY0U3h2Kzk2SkgwenhoTnlC?=
 =?utf-8?B?bXM4L1Z0L3c2VGc0dXdqcUdBbTA0UHBISy9VYzUvVGxvdVVoWFRzU0hUb242?=
 =?utf-8?B?OVVRbk9JWTNOU0orM1EybUtuZDEwQjU2TE44SXlENUlicFRXYmIrU2tZYlIy?=
 =?utf-8?B?QXlIaFlvaFlJNDl4ZnBoZzNCS015cWRQN05Ua1Nja280U2owd1hVTmtXZGh1?=
 =?utf-8?B?UzZQQ0NJNkZ6V3hjb2RpOWZZK0ZDZkl6NGI4NnNUbUltSWRBT3BIQmZDemNx?=
 =?utf-8?B?V1BUM3VRQStRNzhvOHI2TnJrU2R2aDloZlVhZWpWOFdNYmNQcU1qNjQ1QkdV?=
 =?utf-8?Q?nUT6tg3k2EPPRTSaCs23CNBIl3LMXJo2ajeI9gk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722414ea-e60e-49d1-a12d-08dde55282b7
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 10:14:30.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF67B3DF79B


On 8/27/2025 5:39 PM, Wei Fang wrote:
> We found an issue that the ENETC network port of our i.MX95 platform
> (arm64) does not work based the latest linux-next tree. According to
> my observation, the MSI-X interrupts statistics from
> "cat /proc/interrupts" are all 0.
>
> root@imx95evk:~# cat /proc/interrupts | grep eth0
> 123:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   1 Edge      eth0-rxtx0
> 124:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   2 Edge      eth0-rxtx1
> 125:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   3 Edge      eth0-rxtx2
> 126:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   4 Edge      eth0-rxtx3
> 127:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   5 Edge      eth0-rxtx4
> 128:          0          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   6 Edge      eth0-rxtx5
>
>
> So I reverted this patch and then the MSI-X interrupts return to normal.
>
> root@imx95evk:~# cat /proc/interrupts | grep eth0
> 123:       4365          0          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   1 Edge      eth0-rxtx0
> 124:          0        194          0          0          0          0 ITS-PCI-MSIX-0002:00:00.0   2 Edge      eth0-rxtx1
> 125:          0          0        227          0          0          0 ITS-PCI-MSIX-0002:00:00.0   3 Edge      eth0-rxtx2
> 126:          0          0          0        219          0          0 ITS-PCI-MSIX-0002:00:00.0   4 Edge      eth0-rxtx3
> 127:          0          0          0          0        176          0 ITS-PCI-MSIX-0002:00:00.0   5 Edge      eth0-rxtx4
> 128:          0          0          0          0          0        233 ITS-PCI-MSIX-0002:00:00.0   6 Edge      eth0-rxtx5
>
> It looks like that this patch causes this issue, but I don't know about
> the PCI MSI driver, so please help investigate this issue, thanks.

Some people reported a similar issue, check the whole mail thread and 
inochi has provided a fixing patch, you can try it out.

Thanks,

Chen


