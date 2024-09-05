Return-Path: <linux-pci+bounces-12856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED8296E2BC
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 21:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA2A1F293DE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 19:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382A918BC15;
	Thu,  5 Sep 2024 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BhoIrvps"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2B188017;
	Thu,  5 Sep 2024 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563267; cv=fail; b=L0O/9yS2lCi1Sc76qLCGL0gwK4KPQoLacqtimK2UDsyKwADzl2VISXgMZocJXc0tdblWCxIRs8gKwVwt5wCR1w8/XWLNivUdr3jn6AuCNVjpvzPc/wrLEv967oscsw6DBL8wnzmPRkQpkHpWm+LBnb2O46HDtFvnH7H8M88ktSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563267; c=relaxed/simple;
	bh=S9YN4Bnf6y4SiNkYeHZV0c881O/ua2+ssLL3vKquvZw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C+XtJwpZfPxv+WYRdp24Qy/WU5hqa5RJCbE2FErsnPIh+zCHaNmu8rn6GnuYgDw3wopJvre7i22udd72vQ+cwvStJa2HUS/+GxfZc4j2mMXxBNvIU9vSgElFZYrLZfbFuohSWjMQ0IfNXbD5W9iskTsCBz9xxyLIQVDw2iAnDUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BhoIrvps; arc=fail smtp.client-ip=40.107.241.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYf7Qt9tSnCccdD0eNZDgRrbvJAPiQ0OgeldN+xVz9BKEPF87avlzrprDWIM8rOP8pcvRPoYL25I/GbOy8Yvg0mCME60as7pEE3egL3+/p0S+NEwcvEMf2egwtELqgOcwMVnZic1db/ejD8C0ujAbhtzUGQKnzlulesQ9/RwbvYlyCaPUcShu1mblpUdILkl4CbUE7mFGbgeExy2Bewdz80TxDL2qKMTRRb+sSgdJtIAKxxMaGPQhenEs7G+XmOWM53Jy5Lxrxu4b5+0a2tGLR4GQ7i0o2DJaFHdSwq2+HdwM8Lw7OzVChU5Vw7F0Gin0/ToBe5PGqwh8gU1LmIn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG+QnZIHlh4ihWGziBg4qCFIEDC1i4vNmUN0Oz5xyLs=;
 b=Z45buGnlysB2gPT+5SFI5pGXCjziilK+ln1OeiauZqhaUT05edJcAZJVnQkERaCXsZHX0T2hbbS6ScDJz3q5NcVYggXUZ78Tf8CKf6CXpDuUZQ4td/cvacJZcY2mFEx0hVcXIeGP3Y2JW3YJ/YAI7VpPmDiBJra52pit3giK3YFQxloSBfvleLgpvpq+phZq1jsfyMWJf5SujbYXMuiDVzEDYv7YohxaGelKNZX9B62PVFT8Bjxdx4/tizvsIuYN2LtTY2AjFLdChh/pwUTWYUP+yQJckBWOBv6lzZlIYLBTUEX45Ra3EBk0hOs5OQuERvAUN07thaGIuvuXdHwq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG+QnZIHlh4ihWGziBg4qCFIEDC1i4vNmUN0Oz5xyLs=;
 b=BhoIrvps6vUNJ2prGSlVLROGBRAzHn9k2Z2iLHtdJ7N0UX+rceycTwYu7+Bq4BNRnthhp3Epb77JMrBUtmh0AE//jFhwjO+xbnb4pFixQlTh1NcG8B3V05qXnoVD2Ja35ZroogVoCwsgMaMYkGfOKVa6tdluZoAVIvm9dJydGcso5hKxBqqC/65pNK7qlxDmE9K9p3cMCkUAU12svYXN81bG3H94dTH/Etatj2abBp/vGCFwhj/Xho26Kk7GDcpQNKwgPD34d3cE+j7SzkkHT/H4nJSA2hrhauyKJr0P+iPLUjNJK9srL0KqZE4/ubwN0s5g4XydJVaaV0IiOSXzKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6188.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 19:07:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 19:07:39 +0000
Message-ID: <35b5f0ff-50e7-42f9-8b66-b967476dd6c5@siemens.com>
Date: Thu, 5 Sep 2024 21:07:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] PCI: keystone: Add supported for PVU-based DMA
 isolation on AM654
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>
References: <20240905163329.GA389144@bhelgaas>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240905163329.GA389144@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0372.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab29abd-d2e9-4dfc-991d-08dccdde0293
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGFKWk1hdklsR0lLaGJuc0pNZUtMTk5VU1lHV0d4V093aDF6U0I5TTBJK0ly?=
 =?utf-8?B?OHlKNkJCak4yU0VXRlk2ZjlTQ0VjNmdkUTZBRThkNFRoalJCMjduNFAzaE5W?=
 =?utf-8?B?RVZBRHJXVHY5ejdnU0x2bU9LZ1F0Nlg3YllERmRzVUcyMTlKT0oramNaZkJ1?=
 =?utf-8?B?aWpwUHV6SnpTbGlvbWo0VElTQWlURGpJT2M4VUx3ZUVMMlVMVVlxcVN2aGJ0?=
 =?utf-8?B?MDFZRGl2L01PTWVDOTFaRTExU1hLbWhPakJUZWZESTJzYWFvU2RQZnVWcmRw?=
 =?utf-8?B?aWtrZnlyRmZkQVRvUDc4SktHYWNqUW1tRTJtZkIyUVVDRUtXM1Vkd1Z4Rmtp?=
 =?utf-8?B?NmVCdVYrR0o2TFpRQWhmUDQyYzlocDlzOU1UaDR5YVUrV2VNeHk0SnFYRWlQ?=
 =?utf-8?B?ajBlMHgzZndIVnp2ZWpMZk5MZTREMnhleFpDVVEyajRTVW96SEhOVHJHek5n?=
 =?utf-8?B?KzljQUpuUG9aeVVDaWhqQm0yZGV1ZDh3V3Z5cXpXYzVwS3J6RHZoMytVcFUv?=
 =?utf-8?B?emJaS3M5dkZMeEdMY0xFcGVDRlpCRFQ4aVJIaGZROXVLdXhEejg5cDFRbkNh?=
 =?utf-8?B?ZlJiM3kyUG4zOEZzWkZFZVF6cXNhckg2ZmJHNzJOY1N4Tm1qZUE2cmxqNVEz?=
 =?utf-8?B?SlcwMzdyWmcrSnpsZlpNemIwN0F0ZDNrdzJZL2trOTNGNm9wTC9iU0NwTjJw?=
 =?utf-8?B?c1JzaGxJdC9XVWZiTEJXUDZvV2RXTm11aVp5M1BtR1RNOWEwMXpVditFckF2?=
 =?utf-8?B?YUpyaTkvSlZkOTk4MDJNWi9EUXVtSHFYcjZycExzVEhsNGl4YUgwb0Fnazlw?=
 =?utf-8?B?T04za1l3clBwTTJXUWNoRmxrRU0wT1R6c1R3YU5tTGVUZGdmcFUwVVVrN3M2?=
 =?utf-8?B?QUxkaUtuNlFwWTRmTVJRV0t6NlhEVXU0cy9aM1BkVTlIa3NiWDNwYy9POEUz?=
 =?utf-8?B?eGY4TU9jMFdDK2RYTklpNm55L2ZlUVV2aUovNXpTWW8xckFla2lOdTdYZkZ5?=
 =?utf-8?B?Q3MxbG8zY1pubitINzJqNWNBbW45eVdERHowaWtFaWowVi9OQmNZSEdyRHdV?=
 =?utf-8?B?ZGpQc1k2QzVwVEdCRlVOZTloTnJ6WFY0ZDZrVjhPYTl5NjhDYnpKdDJOQm9a?=
 =?utf-8?B?OFovOWtwVjVsTUVFdzFWNzRhWjlycWlab2VOb2RaTVZ6RTNTUGp6THZ6dWU4?=
 =?utf-8?B?Z0RXOTZ4SDgrL2VUYTlYYTB3NEsyU0VSZE1USndZUHFsMlR2NGM1cXlYcmdW?=
 =?utf-8?B?Q2g1Y1JRMzFpV25TVXpzbldFK3YyMjNqYnRzb1V4ZkZGeHcyQUczUTNCb0xG?=
 =?utf-8?B?OUEvN28xcHpZV21kcGJMclpPeW9XVkdpQmZWNzgxd0xYcjlNaHRoMkkzMGlu?=
 =?utf-8?B?M0VHYUFSdDdXZTh6bnB6YUxzME03UUpWeWs4Mk5aa2l0K0ZhdEVRekJtYk9t?=
 =?utf-8?B?MWRVSkhmbGRVK2VEOVY4bEdzalVLYjZ2dTVvTDlZaHFmNHhzYi9OdEhqQUN5?=
 =?utf-8?B?Q3RmdzY5YkZUaG9vUThvWkJzeWxOSXZyaHNZWkgrMDE5c1BlaVRTYzZBRlJu?=
 =?utf-8?B?RjhJR1pweUd1SGRkZDB5M0syTWZNaC9iK3BTZVV0QWdvQUIvYWtka05tZWR4?=
 =?utf-8?B?ZWdqREJnSjE4VmdMNHltRUk5SEo4Q0FWam80c1p6d3JrUWpJNkZCSGFaVU52?=
 =?utf-8?B?S0RVUzA1emhVd3lPNU5DOVc0cmhmdy9sSXMxYlpjMS80TE40ZGhkdU1DeVls?=
 =?utf-8?B?Z0NvTlRMajlXY1kxdW9XU1JsTjJwWHpIMENLd251ZTFaTlowc29ZU0FFRy9u?=
 =?utf-8?B?djRkV1N4c1JTOVd0b3FXdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWFIN3NaanBKZDBJUUxrLzhaMjdJTFIxdEVnN2ZUaytmc1gwZ3AvNmhQcVk1?=
 =?utf-8?B?TURWNmVycTFQakRCTU80a20reVE2UGVvNVNsMGpkRU9JdjJiZnp6eHJWeFZH?=
 =?utf-8?B?NkovNGp5YlUzcC9Sa1ptbEt1c0NkK2FudkFxMU55Y0JoVFVrWnF0Vmp0N1Zp?=
 =?utf-8?B?SGdEaXpxKzJqajFHaXRHMVAzUzIvVG1UODlrMmx6eHMwRm5wMjJYNUlnTVRy?=
 =?utf-8?B?M1kwUkcwdndvTmYyYzVIZVhkS1kwTE5lL1lsREorRE1LVW54MXdBcmg1RUdu?=
 =?utf-8?B?UDA2b3FST2FVc0VGVXIwdmhHUlZlc1djVEtuSTRxbFhmUy9OUDlBRFBXak4v?=
 =?utf-8?B?d3RrMjROZm1INStiMmZUZFVXWVJtMVpWaUR3MGxVdnRFallZMFo5Snc2bnNC?=
 =?utf-8?B?NCtOS3lyZEJqNERCS2hKTGJyY3RiVmZHOUUzWUV3Q1BELzBEUnU5ek5tSldF?=
 =?utf-8?B?M2kvNE9CNkl1OHlqR3pKRVN0cCtDSjNaY21QZmR3NFhTbUt0c1Y2c2VGOFRj?=
 =?utf-8?B?SURaUWUzSXNvRjBnaGhBQnF2TElEbmQwMnJ2eHJrRFp2WHh5Tjl3OHVBVGl4?=
 =?utf-8?B?S0FFaWhSUTMyVmRhRzdZZUhoQjlielR0Rk52NWwxZzJ2U0dWTDkxZjNIdElI?=
 =?utf-8?B?MkNaZldFaTNrU1hkK29wSnFkZ2tmTVY2dGhNTGZUeS94Z25jVEJxODJSSmVS?=
 =?utf-8?B?cFN0amVQa1FJWXJCNng4UnhaTThLeDYwS2tRdEswT3NSck5abkRVdzIrWlBB?=
 =?utf-8?B?Wkt2ZlFKZFZHV0p2OVJVbHdlT2NBYm5xVlZRczRwbEhteFVIV0tFMXphdHU1?=
 =?utf-8?B?MS9mSU1idVV2K1RGVFJpaURkYlYzbVFTeWZhRDNiZkhMbUFtRFpjOHc1b1Fo?=
 =?utf-8?B?ZkNYZGZtUHRwOHZGWkZ5OGw3elVmZ1c0dTdRMmp5NXVUS2ZOOEtYN3hHQXl4?=
 =?utf-8?B?bjNuVGZBYVZaS0NZaEpzNkJEb29RRDhsRFppWllOR3p2TjRiekhhUEpZTFBD?=
 =?utf-8?B?U1dMMkZ2YTBtdWVreC96SDdXbno5VlNhQjRWS1B5SVVOOXd5R1VLNUsrdVJR?=
 =?utf-8?B?bVAzMzU0VTVKTU1VQUY1UE9HWVZMbUlPOUp0SGVUSXByanJoVmhwZGRNK244?=
 =?utf-8?B?UzZsSTFBRFQ0NjU4WHA2MXdzQ0dYdUYzbFlWc2xrMkxrbkV6S2YrTzBlZkU0?=
 =?utf-8?B?UHliK2lxRHo2cUNRLzZvd3cydnBEVGg0blZ0bmFVVXBFMTFVZVBUR2hkZDl6?=
 =?utf-8?B?OXdIWHBmZEs4Rll1cDB0dEpsUlIxdjk5Z0EvbDl6RXFWK29tMmdRdGYra053?=
 =?utf-8?B?bEJ0eDh1LzUrS1JBV0xNTElCNzVDaU5Nd2xFWTBHWEhxVlRENTR6QlZ5ZThH?=
 =?utf-8?B?U0FPdUJDWDhYVDR4NU5jdXRhYW0vTkxHSXhoUHNYblIwZS9QUFlJUGM5bUp1?=
 =?utf-8?B?akNQMm11ejFhTGlJcE9FVnVQcmtDeGdIYURlZ2NtRVMvKzN5YzdRdkRiaUt3?=
 =?utf-8?B?b1pTd2FiUUdjb1RkWFVCRkpDV2FseEw5QW44RWNWbGthTGNlaXR5N1JhNTNq?=
 =?utf-8?B?VEVwaDk3bnJJb3dzamd2Qk9EZGJER3RtcEtMdTJZRDVMTWxXSnZXdXo2VEkz?=
 =?utf-8?B?WUVoT1ZPYmFrYUczK0RrdkRzd25kUlZwbHdwUnFwYkdXaW5wbWRoVkFDL3Y0?=
 =?utf-8?B?NlFkN0hjdEdWMkRZbGpOdnFhR1NqZkc1cGJJRFRmRFlPdHRKRXRjRVhrYjhR?=
 =?utf-8?B?bTNIRnFySUVRUFZYVXZ3YS9vRjlLb2k2QWlNcHpXREFGdnh0a3pRK0ZPa29T?=
 =?utf-8?B?WVhYckRaWVFEOGpHb0tKM3V2U3J3UE51OTIySkQvUzZaUWJnUitIN2ppcTFL?=
 =?utf-8?B?bis4QlZlK2FRYkpwMWxYVHpLR3U3dm9rY0pxYkt3Q0pRWi8yajQ0Q29jZXda?=
 =?utf-8?B?YWVaWlR6bG5pU3JNZzJoMkRjQTFEQkp4NU1HZG5oTkhhNHJvM3ZtZWNYbTBE?=
 =?utf-8?B?M1ZzTnlvUkRMTk5ySW1TU2N2Q29OWDk3cjlXblFzNUR1cW1GejZ6dWdjNmlK?=
 =?utf-8?B?S1BYK0pjOVg1eVlSNGdaS3Znb2pDTFYwRzRaenhyTTdiMFZlR2hJSTlqUzBB?=
 =?utf-8?Q?I3jMvZG+YM4dJPV3OzkwULmAk?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab29abd-d2e9-4dfc-991d-08dccdde0293
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 19:07:39.0575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbq9DXWJ+/TFw1lE2nqWd7u5iOfDVYb2CvgFWLPsgPMcUaWXORlp/wZigZmHtv77u8tvZ4k2iKury0t8IEpFIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6188

On 05.09.24 18:33, Bjorn Helgaas wrote:
> [+cc Kishon, just in case you have time/interest ;)]
> 
> On Wed, Sep 04, 2024 at 12:00:13PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The AM654 lacks an IOMMU, thus does not support isolating DMA requests
>> from untrusted PCI devices to selected memory regions this way. Use
>> static PVU-based protection instead.
>>
>> For this, we use the availability of restricted-dma-pool memory regions
>> as trigger and register those as valid DMA targets with the PVU.
> 
> I guess the implication is that DMA *outside* the restricted-dma-pool
> just gets dropped, and the Requester would see Completion Timeouts or
> something for reads?

I cannot tell what happens on the PCI bus in that case, maybe someone 
from TI can help out.

On the host side, the PVU will record an error and raise an interrupt 
which will make the driver report that to the kernel log. That's quite 
similar to what IOMMU drivers do on translation faults.

> 
>> In
>> addition, we need to enable the mapping of requester IDs to VirtIDs in
>> the PCI RC. We only use a single VirtID so far, catching all devices.
>> This may be extended later on.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> CC: "Krzysztof Wilczyński" <kw@linux.com>
>> CC: Bjorn Helgaas <bhelgaas@google.com>
>> CC: linux-pci@vger.kernel.org
> 
> Regrettably we don't really have anybody taking care of pci-keystone.c
> (at least per MAINTAINERS).
> 
>> ---
>>  drivers/pci/controller/dwc/pci-keystone.c | 101 ++++++++++++++++++++++
>>  1 file changed, 101 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 2219b1a866fa..96b871656da4 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/mfd/syscon.h>
>>  #include <linux/msi.h>
>>  #include <linux/of.h>
>> +#include <linux/of_address.h>
>>  #include <linux/of_irq.h>
>>  #include <linux/of_pci.h>
>>  #include <linux/phy/phy.h>
>> @@ -26,6 +27,7 @@
>>  #include <linux/regmap.h>
>>  #include <linux/resource.h>
>>  #include <linux/signal.h>
>> +#include <linux/ti-pvu.h>
>>  
>>  #include "../../pci.h"
>>  #include "pcie-designware.h"
>> @@ -111,6 +113,16 @@
>>  
>>  #define PCI_DEVICE_ID_TI_AM654X		0xb00c
>>  
>> +#define KS_PCI_VIRTID			0
>> +
>> +#define PCIE_VMAP_xP_CTRL		0x0
>> +#define PCIE_VMAP_xP_REQID		0x4
>> +#define PCIE_VMAP_xP_VIRTID		0x8
>> +
>> +#define PCIE_VMAP_xP_CTRL_EN		BIT(0)
>> +
>> +#define PCIE_VMAP_xP_VIRTID_VID_MASK	0xfff
>> +
>>  struct ks_pcie_of_data {
>>  	enum dw_pcie_device_mode mode;
>>  	const struct dw_pcie_host_ops *host_ops;
>> @@ -1125,6 +1137,89 @@ static const struct of_device_id ks_pcie_of_match[] = {
>>  	{ },
>>  };
>>  
>> +#ifdef CONFIG_TI_PVU
>> +static const char *ks_vmap_res[] = {"vmap_lp", "vmap_hp"};
>> +
>> +static int ks_init_restricted_dma(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct of_phandle_iterator it;
>> +	bool init_vmap = false;
>> +	struct resource phys;
>> +	struct resource *res;
>> +	void __iomem *base;
>> +	unsigned int n;
>> +	u32 val;
>> +	int err;
>> +
>> +	of_for_each_phandle(&it, err, dev->of_node, "memory-region",
>> +			    NULL, 0) {
>> +		if (!of_device_is_compatible(it.node, "restricted-dma-pool"))
>> +			continue;
>> +
>> +		err = of_address_to_resource(it.node, 0, &phys);
>> +		if (err < 0) {
>> +			dev_err(dev, "failed to parse memory region %pOF: %d\n",
>> +				it.node, err);
>> +			continue;
>> +		}
>> +
>> +		err = ti_pvu_create_region(KS_PCI_VIRTID, &phys);
>> +		if (err < 0)
>> +			return err;
>> +
>> +		init_vmap = true;
>> +	}
> 
>   if (!init_vmap)
>     return 0;
> 
> would unindent the following.
> 
>> +
>> +	if (init_vmap) {
>> +		for (n = 0; n < ARRAY_SIZE(ks_vmap_res); n++) {
> 
> Since the only use of ks_vmap_res is here, this might be more readable
> if there were a helper that would be called twice with the constant
> strings, e.g.,
> 
>   helper(pdev, "vmap_lp");
>   helper(pdev, "vmap_hp");

OK.

> 
>> +			res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +							   ks_vmap_res[n]);
> 
> Seems like we should check "res" for error before using it?

Oh, unfinished constructions.

> 
>> +			base = devm_pci_remap_cfg_resource(dev, res);
>> +			if (IS_ERR(base))
>> +				return PTR_ERR(base);
>> +
>> +			writel(0, base + PCIE_VMAP_xP_REQID);
>> +
>> +			val = readl(base + PCIE_VMAP_xP_VIRTID);
>> +			val &= ~PCIE_VMAP_xP_VIRTID_VID_MASK;
>> +			val |= KS_PCI_VIRTID;
>> +			writel(val, base + PCIE_VMAP_xP_VIRTID);
>> +
>> +			val = readl(base + PCIE_VMAP_xP_CTRL);
>> +			val |= PCIE_VMAP_xP_CTRL_EN;
>> +			writel(val, base + PCIE_VMAP_xP_CTRL);
> 
> Since there's no explicit use of "restricted-dma-pool" elsewhere in
> this patch, I assume the setup above causes the controller to drop any
> DMA accesses outside that pool?  I think a comment about how the
> controller behavior is being changed would be useful.  Basically the
> same comment as for the commit log.

Right, this is what will happen. Will add some comment.

> 
> Would there be any value in a dmesg note about a restriction being
> enforced?  Seems like it's dependent on both CONFIG_TI_PVU and some DT
> properties, and since those are invisible in the log, maybe a note
> would help understand/debug any issues?

This is what you will see when there are reserved region and PVU in 
play:

keystone-pcie 5600000.pcie: assigned reserved memory node restricted-dma@c0000000
ti-pvu 30f80000.iommu: created TLB entry 0.2: 0xc0000000, psize 4 (0x02000000)
ti-pvu 30f80000.iommu: created TLB entry 0.3: 0xc2000000, psize 4 (0x02000000)
...
ath9k 0000:01:00.0: assigned reserved memory node restricted-dma@c0000000

> 
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void ks_release_restricted_dma(struct platform_device *pdev)
>> +{
>> +	struct of_phandle_iterator it;
>> +	struct resource phys;
>> +	int err;
>> +
>> +	of_for_each_phandle(&it, err, pdev->dev.of_node, "memory-region",
>> +			    NULL, 0) {
>> +		if (of_device_is_compatible(it.node, "restricted-dma-pool") &&
>> +		    of_address_to_resource(it.node, 0, &phys) == 0)
>> +			ti_pvu_remove_region(KS_PCI_VIRTID, &phys);
> 
> I guess it's not important to undo the PCIE_VMAP_xP_CTRL_EN and
> related setup that was done by ks_init_restricted_dma()?
> 

Right, I didn't find a reason to do that.

>> +	}
>> +}
>> +#else
>> +static inline int ks_init_restricted_dma(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void ks_release_restricted_dma(struct platform_device *pdev)
>> +{
>> +}
>> +#endif
>> +
>>  static int ks_pcie_probe(struct platform_device *pdev)
>>  {
>>  	const struct dw_pcie_host_ops *host_ops;
>> @@ -1273,6 +1368,10 @@ static int ks_pcie_probe(struct platform_device *pdev)
>>  	if (ret < 0)
>>  		goto err_get_sync;
>>  
>> +	ret = ks_init_restricted_dma(pdev);
>> +	if (ret < 0)
>> +		goto err_get_sync;
>> +
>>  	switch (mode) {
>>  	case DW_PCIE_RC_TYPE:
>>  		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_HOST)) {
>> @@ -1354,6 +1453,8 @@ static void ks_pcie_remove(struct platform_device *pdev)
>>  	int num_lanes = ks_pcie->num_lanes;
>>  	struct device *dev = &pdev->dev;
>>  
>> +	ks_release_restricted_dma(pdev);
>> +
>>  	pm_runtime_put(dev);
>>  	pm_runtime_disable(dev);
>>  	ks_pcie_disable_phy(ks_pcie);
>> -- 
>> 2.43.0
>>

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


