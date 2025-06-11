Return-Path: <linux-pci+bounces-29398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D21DAD4C06
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 08:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5B617B8AF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 06:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40258C133;
	Wed, 11 Jun 2025 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="mnw9CJCw"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020114.outbound.protection.outlook.com [52.101.69.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D2142A9D;
	Wed, 11 Jun 2025 06:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749624572; cv=fail; b=t3/X4O4s3IAuDBG2jGDGiMPws6Uw/P+Vz58PuOyVtkP4jyjgqzlVCYJyqCDTRwic04lavLrKDHQSwstbwOovO9g+wS19zJ+Iy9Oie60jDefQf59HtZRp0c4v05MhdysePENImi/5fGMH+Pr+v2kVfb2Q45JQdH59AbtVTevzlcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749624572; c=relaxed/simple;
	bh=GkWpN4h/NVhiWMzwkKJjLeE+M+xLPTByiroMcBlwFkE=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fZewdieBWlOohyC8D8DSJZhAtuyFBmeRqU5L3lIs/95e69P3kh8hUR10+r8wN6lDf1vUM42/zzYNIWoO2Bclxi0Q3CcOgfw7jwN7q0udDM1/Mk/q7liKumZDo8lPTKRvGGHj8H28XmUsxgC9PfiYVFzFqL+qN7X9mgSSjrjRuDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=mnw9CJCw; arc=fail smtp.client-ip=52.101.69.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rH+HaJ6IdEKIEwxNtkqdlO80CqHdYEejYsLCwNjKwC33Ebw7DB/T9I6/kgh7pupWI1ZW3o71GNlYGwl4KIMNfjbk1kXmXAO2woExosAqOCoTRyCX2WLtlPqHscKDGPFsl9i29Oxj7pQnB4bPQzowfaxtAliPxcm06ddSi8P7gcgF6N0yy9fU+1meA24Dso4ZVCBGu2P3nWR6cR1WR/dzqP5644efuxKJu8LZYxaNEspcb041ZQZiYnqt5fvM7XjVTDibWW3mbyXj4Ya70QbTIVyL4cp8QbNdgNc+mq9HDmcJNKkeLlsJoq9YSZzvjBwP30rXqkBMqWbZQ9b/oV3j+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gEePvVteGlezR8qihY8fAlNsANRp3dQthQtDf2V+8w=;
 b=vsGTpHn0UN3zocKYGK1a6yrky5M0klsLENhDXjViYCMVz17jnVSpO7wKU+mcjTEJxzxZ0Bsh9b5xo1oeWCSxoZaDqXsM6wLl/I3FQSB5W1pI1kh/pz/bGohL0fpbmGsArtvQSDjgG7CeUA3xeBWfwCgbMoDPN6fVDClrQR22GqX0bzK8I8eMNQa3KdmqiCdmYr6H78RCafoT7IdlPgjsYGSa4no4lsOwEeELyPG5W+CuhSWhic7XkYqUMG+sAQkfTmf2xfgtnY9epCIrVHNfEKHW+olti/6LvcOOG5WRkph8DFO+qxL7oSpN7Nl6Byqyh5yPEordyAzVBKXm1jhqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=kernel.org smtp.mailfrom=topic.nl; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gEePvVteGlezR8qihY8fAlNsANRp3dQthQtDf2V+8w=;
 b=mnw9CJCwA3Rb5cK1YabY7AyJElg74RccPQc1oBOiLnlW1p63wtfkOgK73rlAVDqnv/QC8PQgUrPI7PkZSP/zd3lmaFuhrdVr8yzX8moPItEDSPpsnuuhnkSn8n753IdYxe+7yWLSuDqTEtKV0Ic20XWF4NbXXZ5zC4siHCn8WMvaBeQsZe00eUcHJhd2hH3yZ09hqBMPN2tZ6Y/q+k/9j3ulQyT9y446z6ytj23/0F67Hglfzxnm/SHfNG9txa0asloAPv+gvhUM3KYnEDj2f5OxsyTxLfFQZn81BVo6Nx41aAcBfOnLhKCvVyhokKVh9dx55AnSzJLa9yW9R10uOw==
Received: from DUZPR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::9) by DBBPR04MB7548.eurprd04.prod.outlook.com
 (2603:10a6:10:20c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 11 Jun
 2025 06:48:56 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::7a) by DUZPR01CA0005.outlook.office365.com
 (2603:10a6:10:3c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 06:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 06:48:56 +0000
Received: from PA4PR04CU001.outbound.protection.outlook.com (40.93.76.78) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 11 Jun 2025 06:48:55 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VI0PR04MB10662.eurprd04.prod.outlook.com (2603:10a6:800:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Wed, 11 Jun
 2025 06:48:52 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 06:48:52 +0000
Message-ID: <9f8a7c43-4862-45aa-951c-bf3e3c1f5513@topic.nl>
Date: Wed, 11 Jun 2025 08:48:51 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v4 1/2] PCI: xilinx: Wait for link-up status during
 initialization
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250610185734.GA819344@bhelgaas>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.bd37b5e5-7e20-4db7-b2f4-b11b97bc1326@emailsignatures365.codetwo.com>
Content-Language: nl, en-US
Organization: TOPIC
In-Reply-To: <20250610185734.GA819344@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P192CA0024.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::16) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|VI0PR04MB10662:EE_|DU6PEPF0000952A:EE_|DBBPR04MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 55169798-c478-437c-1a79-08dda8b40995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TWwvVGJyMzcyblZrS3c5NXlPbUo0VDNRTXNmUkEzR1Qvd3FYSytCeUtlOUJL?=
 =?utf-8?B?SGFkQVpKazlzRXFvRHFBVytFSXNSU3JXTFV5cE1GRzdiS0NpM2gvWmJidU5R?=
 =?utf-8?B?YTFpamgvTUJnb0dmay9xVTltWG1rMnFReStWM1BhMStuNjA0OEZZT0pUTHVu?=
 =?utf-8?B?a1ZlVTRQS21NN3VrWjRzNm42cUI2KytZVDRQbU11dmNVQkMwbDRiL1hNcWl3?=
 =?utf-8?B?K2Nta25kMW9ETFc5ZHpXc3U0L2dvSTlDU21RSHhmYWIyUUYxdDBmSnFsUXB3?=
 =?utf-8?B?dzRxVDVnSXRUWERtUXE3bmlIRmRSREk3anNDeXluNmp4VTJtbUZtOUlNSzdj?=
 =?utf-8?B?U21xSDZ0NWpTYUhyYUJSdE01QU4zTlJ4b2lzN1ljd0xBU3VtMGs3YnhjOHlX?=
 =?utf-8?B?a0lnWFlCbkN2ZVRydDk3M3JSVDROWDZhbVNGTVF3b1JxVU94UnBVYXBYYmxQ?=
 =?utf-8?B?QWRoUWpGTi9GSktHMTh3V2RaL3AwMm4yVjBkT1cya0p1K1g3dTVXQ2ErUlFn?=
 =?utf-8?B?dHJLVWVWS25TOFJQWUtwazVFVEllTjBzUDBUWFNIV2ZORjBCQTFhOGtCbHpz?=
 =?utf-8?B?RC9YZGtWOTlTbDV0dTd2Z0ZFVTBqMUJ3Y2N5UWtXMzl2MG54USs2UlFtR0NZ?=
 =?utf-8?B?ODhKTTRnRGIyZnhrNDBNdzI4MGl4cEJRVDdZcTk0MS8rRS9VQnI3SWM0K2Qz?=
 =?utf-8?B?cjZOT0JiWlU2QTVXaDdBeitTWTFVbWorb2V0bWwrU1pjYjlRVlo0WDZ0bjJ0?=
 =?utf-8?B?aDRwSTQ2RWtrU0MxNmdwWlBKcjRPYjBYN0pSM2lZNUJudTFld1ZvSXF1Y01i?=
 =?utf-8?B?ZWdoY3ZVYUk5RzYrZ1ZkL000ZUZDOHcwS3gyUkZtTU5pbGhRbGIrYWM4cUd1?=
 =?utf-8?B?ZE43NjZWa0hBMHBMczkvazVXSUN1WVNpVDZXdUFKU2NXZ2lSaTZhTjIwU3U1?=
 =?utf-8?B?Z3B3VEJlYndZUmFXYlhyUnc0NGJhWU83dzNML2xlRTR2YmdsR3h3UUZhSHFn?=
 =?utf-8?B?SDdBQ05zUWFyTUlvRzBxdnluT3Z6ZmtPMkRIY2dOb1NlRllqNDlmQ3QvZE92?=
 =?utf-8?B?VTJhcHJ5bFBHMlI4cnMxOHFyaFUza3c0dTdMM1hENVk4cXhmU3YxWmZaV0lu?=
 =?utf-8?B?Nmx0dlV5TEN3NFhicFZ3NXlhZkZnQnRsVTBmOVFMWGZ3NE8vdk9CbEFnVXFw?=
 =?utf-8?B?aFplT3VNVDRHdWxTSStuQ1JSYkU5aUVLckhPcHJGMUxVd1phcjBoRWhvVlNB?=
 =?utf-8?B?ejUwakIrSDJmb3dIcDZiUzd3alFiemQ0R1ZzV2YxZGJsQjk5eWFmd244cXFR?=
 =?utf-8?B?c1YydE9aK2ZLZHd0cjVoWGtVUkN3UGQ3ZXNrTS9VRUVMZTUrM0RyQTJQbC9I?=
 =?utf-8?B?WXBOWjdSbzdUWUdBTEtFNHo0RzNQNWY1dUJGNzJqS1VMWFlBUTIrQmZYc0V3?=
 =?utf-8?B?OWFQZ1BtSGdqK2tOUXJMcXhRUFBxNDlEei9DdXpGbWhaS1NsSDJ2NTdFaVli?=
 =?utf-8?B?OXIxK2VmN2hUVDQxaEpVSFQwcGNSaEpNbHRReHpEVVpURGV2MGJkdEZMRWJu?=
 =?utf-8?B?bXlXWDdHVUZ4WlV6MzVjNFZsL0ZkOHo2eTRBMW9WK2d6akVRUlViVTNQRWx4?=
 =?utf-8?B?SkhBbFByZ1N2VWpSbERvQ1ZLMUIrd1lLcjJRR1UyTzhtMkIyQXFKREo1MmF3?=
 =?utf-8?B?Vm1xWUp0NU5XZFU4UXlGU0tYdXFUS016bTF2bHk2VzhUeEE4U1Zpb1UwME9Z?=
 =?utf-8?B?VExPeGY5SmhreUhubTY5bStXdDJIcmRQb1ZwMzZHZGg3a2hjZHZ0b2tCT0xu?=
 =?utf-8?B?cTVZOFZyc2grZkVJdjg2VWRuRlhhdURQUStaUTdkVlBlU0FYRHI5UEpkZDY0?=
 =?utf-8?B?aGhnb2tkRG9GQmhTeHRwT2xiMEFzVXdrWVUwQzRGNGYvQjR6SGRHU1FsZWNT?=
 =?utf-8?Q?w5j6qhihsP0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10662
X-CodeTwo-MessageID: 21e8da7b-ef22-4670-a7b8-e91449d04111.20250611064855@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b7ce279e-8c02-4f45-f351-08dda8b406f2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|7416014|82310400026|376014|1800799024|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am5yL2IvQUdHWWpuMnhNOUdRaHp1dC83aUN0bDE5S0xIcy9MVkdPN3dnR2NX?=
 =?utf-8?B?VU1JU1ZCMVBoSldaQ29LS3lDQ0k0RXM0NTIrSStDK0ZXQytWb2hsdjRTWC9o?=
 =?utf-8?B?dGhnUG1oQzhHdnFRWVdXTmdmdmNXNnRheDF2WXBVV09HREdDVUtwcHVoV0hG?=
 =?utf-8?B?Vkx3ZkZ0UkhWdlIvM3ZiU2E3OUtDMis1blpiYWJsTVJROHJPeElnYm5UbnRD?=
 =?utf-8?B?TUdrR1F0NktJMmpzdXMxSG94WmpZa0RmNDBaZTRMK2VLeFJiSXFNa0ZJZ0dm?=
 =?utf-8?B?NDRVdkkybWZvNWhVdnN0eTJaY21MSzRKYXZuZmwzK1RRQUFML0U0RzJDVXc0?=
 =?utf-8?B?L2V6clpEN3RpODUrY1I4VHc1VkJGdE45VEMyc1FsL2RKOWYwOUp2Q1dPY0w1?=
 =?utf-8?B?YVF5dnhmTTBCcktmcGt6VDNPNmRORzRHekwyMUs1VFo4ZCs5NGpOWTBMRzFy?=
 =?utf-8?B?bDhyRXJCRlFNbjFEWWRST3lYdGtiRVZSOUVlT2JyeFRKZG1RWnQ2VGhpVXlU?=
 =?utf-8?B?WCtXWHZhK1FibHQ4alh5SFBtLzJ6TCtSY1prOVJndDgyOS9abndJWlJuR2lv?=
 =?utf-8?B?RmdmMFM4M1ZidEpYeTA4N3NZM3A4b3RZejVJSDVRZGdocUk3b1gvd3h0VVMy?=
 =?utf-8?B?R1hKakxoelZ3SWZpMlZqYlZtSXRLUWVQamdBRDBzYTh1SXFpY0NQSXI0cHdL?=
 =?utf-8?B?YkZNaDBsTElXMjFia1JiZCt3RnpwYVFuNndFa1E1ZzJJQTY4V1hwTUNuZEdv?=
 =?utf-8?B?RTJqZ1JrVFRvdmZ3dHh3cElRMGl6RFUxYkRDeEx1bzVPTHMycFBGZVkxQyto?=
 =?utf-8?B?ZWp6cGtWM1RFSS9nbllEWFRPNjVRZEpuSUE4N3l1anlYcUtHdW00NEJBV0ow?=
 =?utf-8?B?M0pZaFNrL3RidTdkaE1RT3FSUnJ6SlpST3pqRzZoa1VBR0lMV3RzQ2xuR3U5?=
 =?utf-8?B?NndmS1NMYnV0RUMwaDlXMGoycU5FRXVFSmFXOE1RSGljYkhKKzdXQVgvYkJY?=
 =?utf-8?B?cWE0RmljaTVQK0paTzlRNzN0Sm50OEtTZjB6QkhHbFd1Zm8rZHYybnU1YjRX?=
 =?utf-8?B?Zks0aEdCMDdHK2ltNlZFbFVsY3E5ZS9Bc3dJKzMxUUpDNFFDOVhEVmdYWExN?=
 =?utf-8?B?M0g3MmtndDVtSlkyVnMyQm1MVDcvQkswMlpvMkFQL1pvWXgzcENZZHpUZkpv?=
 =?utf-8?B?bFJlWDNEdGxRWGRmdnBvSTJWUXI2UHV2RlRieDQ0dElDT0R6K1NkZXlDU2J6?=
 =?utf-8?B?bCt4Q25maXJvMEJhdS9VTk9LWWU3VStCbFlvRVVva05JUVpkRWY0MXBQYUk3?=
 =?utf-8?B?Q3dURkxHdVJwbUx6SFVNOHF4bFlYdVg4bFFMMjNSM2xpN3Z2VzlIV1NpNkFT?=
 =?utf-8?B?ZUF0T21OdHpnYnBjNm5saW8zMjlnWWlTbUxUcXpOQlh2WnZ2SzhnT3JlRFQv?=
 =?utf-8?B?ZVRaZUJSOEpVV0hMUlVTYWlFeG5OcHZvamhGUVlQWDZZWmppWjZ0eFRpWTJ4?=
 =?utf-8?B?Z0hUaFRIZTI4ZlVPZW5sNytsKytYOXRKZlc1dnoxREkzUmozS0h6VWJsc0I3?=
 =?utf-8?B?elk4T1I2aThPajNrS25rbkJmNEhyVTVPVkVKY0FnU0FnUGpweUtjNG5mMDJt?=
 =?utf-8?B?V284V1dqQUQxb1JSMzhTdnh5MHJzY3B4VU1tSXgwd0VQdVg5anZMUWxSTTVG?=
 =?utf-8?B?U1VUUmplMFF4dUY0UExUTTBobi9vYm90NVlaUjkwREhGTDZCQWQ2Y1J4enRP?=
 =?utf-8?B?K045dVN2Z1RaTEQ3eG1HdnkyVjFlYzBXYVJBV1BiOFhuM2luWFh6cVVEdFpX?=
 =?utf-8?B?MHZRSGtrVHVEb3FoN1FaZDhRc2IxZVAwM3l5cmJsTGg3RnV6OUhLdy9jbjRN?=
 =?utf-8?B?UFJwMlpHMVdZN28xM3c4NlpzeHdMaGVnUFJLSFMvTFNVa1VHQTFvVGxBMTdH?=
 =?utf-8?B?eFg0R3BhNHh2K0w0c1ZyYm95cFd0b1FWcFBnV1EyRGk0Vm8rVWpXZEdLdHU4?=
 =?utf-8?B?bHUyTm5JZDh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(7416014)(82310400026)(376014)(1800799024)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 06:48:56.2944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55169798-c478-437c-1a79-08dda8b40995
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7548


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 10-06-2025 20:57, Bjorn Helgaas wrote:
> On Tue, Jun 10, 2025 at 04:39:03PM +0200, Mike Looijmans wrote:
>> When the driver loads, the transceiver and endpoint may still be setting
>> up a link. Wait for that to complete before continuing. This fixes that
>> the PCIe core does not work when loading the PL bitstream from
>> userspace. Existing reference designs worked because the endpoint and
>> PL were initialized by a bootloader. If the endpoint power and/or reset
>> is supplied by the kernel, or if the PL is programmed from within the
>> kernel, the link won't be up yet and the driver just has to wait for
>> link training to finish.
>>
>> As the PCIe spec allows up to 100 ms time to establish a link, we'll
>> allow up to 200ms before giving up.
>> +static int xilinx_pci_wait_link_up(struct xilinx_pcie *pcie)
>> +{
>> +	u32 val;
>> +
>> +	/*
>> +	 * PCIe r6.0, sec 6.6.1 provides 100ms timeout. Since this is FPGA
>> +	 * fabric, we're more lenient and allow 200 ms for link training.
>> +	 */
>> +	return readl_poll_timeout(pcie->reg_base + XILINX_PCIE_REG_PSCR, val,
>> +			(val & XILINX_PCIE_REG_PSCR_LNKUP), 2 * USEC_PER_MSEC,
>> +			2 * PCIE_T_RRS_READY_MS * USEC_PER_MSEC);
>> +}
> I don't think this is what PCIE_T_RRS_READY_MS is for.  Sec 6.6.1
> requires 100ms *after* the link is up before sending config requests:
>
>    For cases where system software cannot determine that DRS is
>    supported by the attached device, or by the Downstream Port above
>    the attached device:
>
>      =E2=97=A6 With a Downstream Port that does not support Link speeds g=
reater
>        than 5.0 GT/s, software must wait a minimum of 100 ms following
>        exit from a Conventional Reset before sending a Configuration
>        Request to the device immediately below that Port.
>
>      =E2=97=A6 With a Downstream Port that supports Link speeds greater t=
han
>        5.0 GT/s, software must wait a minimum of 100 ms after Link
>        training completes before sending a Configuration Request to the
>        device immediately below that Port. Software can determine when
>        Link training completes by polling the Data Link Layer Link
>        Active bit or by setting up an associated interrupt (see =C2=A7
>        Section 6.7.3.3).  It is strongly recommended for software to
>        use this mechanism whenever the Downstream Port supports it.
>
Yeah, true, I misread the comment in pci.h. I cannot find any #define to ma=
tch=20
the "how long to wait for link training". Each driver appears to use its ow=
n=20
timeout. So I should just create my own?


