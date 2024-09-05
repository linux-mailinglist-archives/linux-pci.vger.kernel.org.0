Return-Path: <linux-pci+bounces-12807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6EB96CF86
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 08:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F4E1C21B4B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 06:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0A118950D;
	Thu,  5 Sep 2024 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tR+plKwD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D543612D;
	Thu,  5 Sep 2024 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518463; cv=fail; b=YAyhw2yd1QdHuGvCmSipI9pKfUHdZormAaKHsbLorHxZtArfsBwGpRkuAkBPPAuKtqLoYavAoIyQJrf555Xf9VJS6Xy/oh6Op2nrrSgm97X+vbpbTi0dVC/QCEAXZly7ayyVW+gJnpXHmBb8Jt4toMjgAJztlIXjAePhmVIRyBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518463; c=relaxed/simple;
	bh=Zs/RBkV5xf3KXeMOv/HLRE60iDL3Wmg59KuPkoL6iI0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZwAMz6CqPPrc0D1IhQ9CQVB6pYYRzqGWODpM88bbevaBdiwDpRjRxpNBavrJcpW9X+1GY8/CRB2PKgEep1V4lfV55OZqfDDPNTcBlBer9v/jLXAGjuh+FLj8LA1kxL2ooXEuL9K2roz5NBCVI8lrn5GCYp0lVGbTR2Px1O4ZMY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tR+plKwD; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWGMVTWeSOOmo2zMqv3DvFXpoy4RSjXjtGKHPw3YO9Jir9b+ucjxSeBjLUKXxbGcu2kQgjSliLoXEi5JrWc7edFMQyggx5vH99/ZVyl546tvbcat7rN/wLsAir8VckoWe06LZ/1Jb06lkusRQtN/m36cJio2T+4Kht/R26DWGh2utyJ0kzeEZ9m7AQMk8IXLBJ5HSOytHH/sxt0aGoJRr/x1Kp1/qcirYySI+wXDa+iOqsFrVXO0JhK/tvsCDJWAIYJaKOJkgk0S8OQhjlvwkqdhZqGC98/5LaxYDfakDveqEXRaCcEvKcQ2Aw/NlK+80fCEUi0PUbpbGiIcdaAzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFVY/WwhL7Z5ZTBX4MvnKvl8GQg+AtaWeThpkcDrTHw=;
 b=myAqIeeRdj9k8fEb25Qr8zT9jZ7JSRVeadtU1WZ0g3Cama1xbfO1ULZRSu163Orvcq1RQJvl4AncerTxwIYck4/gDaPLUL5S7hwCRzclXyRWKNBMlwYeO6swnAG+vqm23ADNx1tIYgJc2E6ebiDbfmSwGQTM8iZHyub4uQQI3IK7OvdyALQJymJUkOajl0zseWdW4p8/LYi0eIrowD2zMHVquUBir7CizunjZIwcEMcqI5ExCx5yatEsqV/k1ibjll/iSXI1sVsZhamKG0zhPLds+Q2zMmzZotUrnImV1QKXvFY0vDmXuTImJAxBAEmST3WAha9dl+QLRA8ROaTARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFVY/WwhL7Z5ZTBX4MvnKvl8GQg+AtaWeThpkcDrTHw=;
 b=tR+plKwDurZ6Vp8ZQLOUw1q/yDyf34o8fEQ1M8JHrMELo0uiqRk4q6kR2HcF4s0t8cZO7G9562ImkJhR4cAuoFePMBmwDZLLfY82gohX4xIg0P7q+riGWA9kJRLRhYPJ8adIQQ8D6pTKFtgjR7xOqcxBH28od7cHQa4BEdB7YjM6iCVg8h6rPQA9IA3BzFkqFVRqlL8LEs4n/JmGKnAWeM1/DGYMeuCNxLq+vfPJdetCRZ15FtrOZOrsSDHq3gpqH1PnlPEp5X55mqyR3b0fW3GWqeAqpbIQY8pk8k6lM7nog3KR7cuu0Hen7s61Rb5apjyHlXVWkg8DjsCq9Cey+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:446::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 06:40:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 06:40:57 +0000
Message-ID: <4fd1d6e8-8a66-4eff-a995-5f947a4b707d@siemens.com>
Date: Thu, 5 Sep 2024 08:40:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
To: Krzysztof Kozlowski <krzk@kernel.org>
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
 Bjorn Helgaas <bhelgaas@google.com>
References: <cover.1725444016.git.jan.kiszka@siemens.com>
 <28d31a14fe9cc1867f023ebaddd6074459d15e40.1725444016.git.jan.kiszka@siemens.com>
 <t2mqfu62xx5uztlintofp4pquv6jalzace6w5jpymyyarb2wmn@vvo23e4cmu57>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <t2mqfu62xx5uztlintofp4pquv6jalzace6w5jpymyyarb2wmn@vvo23e4cmu57>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0b811b-0ed5-4896-6576-08dccd75b2f4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjV3WWZLZUM1cGl5cmdzT2E1NjBxbk1SWXRrUmJhT2MvbldUWk9uVnljWEdG?=
 =?utf-8?B?U014dGhEVDFYb21ueGQxS3AyUTQ0bG8wbmkvMWJyWFFBZEdZakdNMUV3R2NB?=
 =?utf-8?B?TXh6aUwyVGliUDNvWURucDRjMnBIek1aT0NNc3ZJSG9Kc2NITTcydTk1YndC?=
 =?utf-8?B?cVl3R1huNDJyTlhaV2VrbjhLQzkyMnQvcTJhdzFramZNNllONlFmNk1TZ28w?=
 =?utf-8?B?dVdHSE84bDJtSzdONDNkTTdqbnpsbEtFTDl1a2t6K3dqMmVNZ3RuRjZjZ1JK?=
 =?utf-8?B?WDlmbHI2cDgwbnc4WkIrUDlnVUp6NWdCd0lsYnVVNmhZbjIvWVNkd1pkc2dI?=
 =?utf-8?B?Vkh6V1JKVjUrbmhXM29tT1VOZEdiQkNTWTRUNmNyNmFxR0owdXNac2prNmxX?=
 =?utf-8?B?N0F5VEdEYjZzQkh0Z2t0L2gyMXpESW9kWkp1WXp6bktkQzdNWDJSWEdiT2Rt?=
 =?utf-8?B?QlRhNUlNTnJUZi9FTGFMWnlYRTZqc2M4aW1YODhQOVkrdjhJbGRmWEtXQlVM?=
 =?utf-8?B?Ti8rck1zUnhLYnNjSndoa0VyYlduRUJWR1Z0UXdQZWRVbHp6bXZtblZUZlV2?=
 =?utf-8?B?ODZ5THhpaWFaTnlady9JUGZiNkwya1FUMFNEUXZHWERSMHhFQkNNQjk0VWpI?=
 =?utf-8?B?QkZIWENpZm5ieDV2WFRzQ2RLTmN6QlpORk8zWVZDRHdReHNGRXJad25Yc1o0?=
 =?utf-8?B?SC9VRHRvRTFTZUhQSnNtZjdwQmZ3dmdjaUo5bExxam9remczWFhsV1pWU20y?=
 =?utf-8?B?SXhaMTN6elR0VUVDTWdHVFowZk1XTk0ra015aCtrL2Nxem5TVlRROFVwbXZx?=
 =?utf-8?B?eHNReEdRZDlTbkp0VFdHRFdwRE5weXpGN0VpWVgyMWE2Z2FSTnBVNHpYNURL?=
 =?utf-8?B?SjJBaVBHNjB3Z0ZZQ1gvbzRwV08xcnQ5WW1WbmcvSmh3dlRNVEszSmxJMHBN?=
 =?utf-8?B?VEdOVmFIemUxLzhjb0VwWENlMGxSaExKQnNiSitTcmM5QTdBMDRjeE50dWUz?=
 =?utf-8?B?WnVabGkyQ3VBU1VBYytudUtVb2xTWnF4aGJYbHJDbkJOeDhiVms0WlJtakUw?=
 =?utf-8?B?aUFhbjZGV0J2U1paUnVnaU8yeThOY0srYTV3TjJjU0hYYzEzTmlxS1haa2lu?=
 =?utf-8?B?clBtTVVlTVQ2dXFwSFlOZGFmbFF1L0ZhV0QrbHdDdmN4b2I5NkNEaEUvaExo?=
 =?utf-8?B?OHNIcXBKRUJ0bzRVNzl5cm8rMUJLWUYxVTVNN2drcm1Lc2ludUJ6QXk5NWJ1?=
 =?utf-8?B?eWRPM2tYSThyOVVZT2RjSGt3M1ZMWms1VmpaSzByTlVIQWlnNnYvNGRPOVdS?=
 =?utf-8?B?VVJtU1g5bGVOcWo2azIwSVpVN1VzYjlZS2xISTBNbDhhcXM0VlhVbVJVOC94?=
 =?utf-8?B?UmVxVTlEWk8zNThWWlJiNGVEdGdoWXI4NC9pek9WR0R3aHVtRDRVL3BaM1F0?=
 =?utf-8?B?L21qWDNjVGZRTDlQOHAzQVNDeEZ0TmxGTThyTUJWSXdFdkx2UDl0eHFGSHJ3?=
 =?utf-8?B?OThmQzNhdEdLQ1MwWS9oSmh6bXMwa2lpaER4K1drU2xwUHl3VEUyWVY4RUp4?=
 =?utf-8?B?UCtrc3lQcmZTYTBYeTYyVm5sNmlQWll3Rys4RHhISkVnYzUxRE81d0JFRHJP?=
 =?utf-8?B?L09uZkhFejAyTzQxK1ZIdTNIQ0QrT2hpOEEzWk03RXpyNitNNGg3ZkdDL3N3?=
 =?utf-8?B?aE8wN2dpV2FMSktUZnpHMHNBME42VVNuTWZrUlNlcnFYNGJRTTA4dDRKdk1D?=
 =?utf-8?B?c25sSHdDWGUrUG9xNXRsYWhsUVhnZENycmdzOCs5dTI4a2JoT3loMnRpL3NQ?=
 =?utf-8?B?VU0zY3ZXMUVWeDZaM3p5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXdqcXMvbUVKbEs5MWJTOGlDYUdHZ3U4RmtMNTZ4NGdqOFlNcUlsUm9HbWVt?=
 =?utf-8?B?cEQ1MGNhOXBTSEFlWCt6YXNjcXE1eENTbW1yNmx5THVMd0dmVS9TL2Q0cU83?=
 =?utf-8?B?d3RWNEtBVVZ3TVZWb2liMGlWZHBIcTZHaldqSEFpRGh0V2ZzbjlRT2JGNFBL?=
 =?utf-8?B?THk1bHBBbEtsc0dFU0FNay9naFBLdThxeUZRNUNadlJUR043V2laMzNxNExv?=
 =?utf-8?B?Q2gxbjV5QWFkWThkQ3pxSGxoNGlTODV3VVVtUUl5MUpnaXlxcnhzbHNTNzhE?=
 =?utf-8?B?Y1gwRENsRzNMVDA0YllwMzV0M2Y3NUc4Y0tDY3hkR3h5ZXRVY1FQWDVyWWlj?=
 =?utf-8?B?QmJ4N1IyYkVNU2xYS21YSEpVZG1kSzNhMjJqNTRwSXRQK0I5VExQZ2prSWtx?=
 =?utf-8?B?bnFjYXRkTzdpdFhHSlU1YTd1Ujd3SkorVVRTa3ZaNFVTVGlaWnViSE9xUlR2?=
 =?utf-8?B?dlJ3ZU1yY2JEZGdkSldWWXpKcmI1WFI0SHo1d0FocXZqR0QrVllWTm9NdVF1?=
 =?utf-8?B?WlMzNU9naEw1MHpzeWFyMG5DcnVKcWdQUUhlQzhGTlV6bkN6MjZKbHM5WGhF?=
 =?utf-8?B?OWJnYmt1QnYyV0xTZUJ2Mlk0cU4vdVlnOFBzcHE1dFM0WXkvQ2dGaytWZnpv?=
 =?utf-8?B?bUo2UWNVSjVoT3RWZ0FlZmNqRWZpWkdkR0NlRG9ud1pBbXhkejQ3S3ZZa0x2?=
 =?utf-8?B?K2l6c2RNTjBRZXZaMEM3emg3dm41WmpkODFaVGlSYnVLT0U5UG83OURHa0FJ?=
 =?utf-8?B?T2pmVE41N25WaG5lbTN4aVpsY0lmN2lFdDZhaTY1UFh6MjhPVzh6WU1xRll1?=
 =?utf-8?B?VkVOeWdQL21Ycm05NGNETlRXNG9IbVJiOEtFVDE1emZHbXBiUk00SGJ0VlpW?=
 =?utf-8?B?bEptdkViMkN4dDJGOXZYM0FDbzlJZ05zbUJCcDhVazMyRGR6c1lGSmtKdzBJ?=
 =?utf-8?B?b1NxZGJZT04xTWU0QVB3aU4vdFAySFRHZlVJVlhIb1ZqQ0p0eXRueHF2TkRH?=
 =?utf-8?B?aGRDVkFOdnJIbWhWS2dXLzNDdURGMFFNRHJldEhBSWtUV1FISnhEMzBQN3Jw?=
 =?utf-8?B?cXhBSEZVRGRPTFBOMzI5cjE2WWg5SUoyaVIwdGlTT1Z5dnYzVkhZN2pLb09R?=
 =?utf-8?B?MGN1MEIxM0JGRkRDUWxjTWxaazNlMTdkMGk3TjJ6QXpGbzF3VjdSTUNaSVM5?=
 =?utf-8?B?a2swNEdTdFhpQi9yTGRkTEM2TXNGVjFvbXBSem9RRHNxSjVXNUJBSEpxZHgr?=
 =?utf-8?B?Q3loRWFEWEhDbTgrQWp0RFlaS1VkeHM2TmZ4VlBQZHF4VlF0RVFybGlhZ2xE?=
 =?utf-8?B?MWxNWjhjaVN4U3pjK29obGpnZGZ3TjlqWWdnWmZiaW5ZaVlSN2lheitHVmpC?=
 =?utf-8?B?Tm1sa3hteTVrQ0hOczZGK01ZY3NoRmhvOHFSQ1ExdnNTMUp0MUZwdVNQZTFw?=
 =?utf-8?B?YnEyV0YrMWFnaENjMGZPVjVZNmlVb2d0WitPVTBYb3J4c0syUkZzVjdncExt?=
 =?utf-8?B?b05iUjE5U0J2NUozaGVYLzNSb1hOeERFVUw3a3h5bi9SSW9KT1NQeTdUK213?=
 =?utf-8?B?bG8xTy9DS2lCcFp5cHd5di9nemZjc3ZBbzltdWdRYzlRVlIxNVRqTTVjSjN4?=
 =?utf-8?B?MmtEb0lweGFaZ2xOZzRabHRCZE4xREhQUThSSi8yTG84NUt4K0crZEc1Vm5u?=
 =?utf-8?B?QnBrZk05NzIwYmM5TjdFeWZmYVRiR0VKdUZMdWowWmFMRGMySmE5eUlnWjJJ?=
 =?utf-8?B?N2wyVEdsMFFtczZGcDMrRDlEQkQxaUU2cnhHQWVEUDZTRGJaRnpMT3habnFG?=
 =?utf-8?B?OFA0OUtYRUlNUStLcFpURHN5VWtKTWxYdzBNNHU5ak5CM2lRbXVzV3ZTc3dw?=
 =?utf-8?B?L29iZ2N5UjEzZG9kSHJOb2craStmQjNPb3VpMXV4cEdsVTdldGswRUJSVy9w?=
 =?utf-8?B?cjZtZEt6Q0pPaHhESENjeDRzQ2J3Q3ZwMGtBTkxjNXM4ejllYzMzK0VmdE51?=
 =?utf-8?B?dndiaFR2QnZHM1RqUHpMU29wL2ZSeGV6UFBEM0hkWHJZZzJjRUVtc2JabHRL?=
 =?utf-8?B?a3g4akFXNGlLZ0ErQzdudmJ5ZHJIRmhmZUVTN0d2Ym5TZlJFRWlHb3A2VElz?=
 =?utf-8?Q?tmZT/+7gn19OrdIkBvTas/4du?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0b811b-0ed5-4896-6576-08dccd75b2f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 06:40:57.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adHjD5vcLBNcKZAKupWIYh5i/WkxV0d4GiIiuCvZ1MSMw52d2weGkF5mnoAoTREdoczwKyoAClPLVwMqY7OVqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9102

On 05.09.24 08:32, Krzysztof Kozlowski wrote:
> On Wed, Sep 04, 2024 at 12:00:11PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
>> to specific regions of host memory. Add the optional property
>> "memory-regions" to point to such regions of memory when PVU is used.
>>
>> Since the PVU deals with system physical addresses, utilizing the PVU
>> with PCIe devices also requires setting up the VMAP registers to map the
>> Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
>> mapped to the system physical address. Hence, describe the VMAP
>> registers which are optionally unless the PVU shall used for PCIe.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> CC: "Krzysztof Wilczyński" <kw@linux.com>
>> CC: Bjorn Helgaas <bhelgaas@google.com>
>> CC: linux-pci@vger.kernel.org
>> ---
>>  .../bindings/pci/ti,am65-pci-host.yaml        | 52 ++++++++++++++-----
>>  1 file changed, 40 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> index 0a9d10532cc8..d8182bad92de 100644
>> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> @@ -19,16 +19,6 @@ properties:
>>        - ti,am654-pcie-rc
>>        - ti,keystone-pcie
>>  
>> -  reg:
>> -    maxItems: 4
>> -
>> -  reg-names:
>> -    items:
>> -      - const: app
>> -      - const: dbics
>> -      - const: config
>> -      - const: atu
> 
> 
> Nothing improved here.

Yes, explained the background to you. Sorry, if you do not address my
replies, I'm lost with your feedback.

> 
>> -
>>    interrupts:
>>      maxItems: 1
>>  
>> @@ -84,12 +74,48 @@ if:
>>        enum:
>>          - ti,am654-pcie-rc
>>  then:
>> +  properties:
>> +    reg:
>> +      minItems: 4
>> +      maxItems: 6
>> +
>> +    reg-names:
>> +      minItems: 4
>> +      items:
>> +        - const: app
>> +        - const: dbics
>> +        - const: config
>> +        - const: atu
>> +        - const: vmap_lp
>> +        - const: vmap_hp
>> +
>> +    memory-region:
>> +      minItems: 1
> 
> Missing maxItems

Same as above. Please address my answers.

> 
>> +      description: |
>> +        phandle to one or more restricted DMA pools to be used for all devices
>> +        behind this controller. The regions should be defined according to
>> +        reserved-memory/shared-dma-pool.yaml.
>> +      items:
>> +        maxItems: 1
> 
> And this feels redundant.

I can drop that if it's not needed. Unfortunately, schemas are far from
being intuitive to me.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


