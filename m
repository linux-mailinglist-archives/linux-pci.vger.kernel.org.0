Return-Path: <linux-pci+bounces-35164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8D4B3C727
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 03:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987C71C81B5F
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 01:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B1724466C;
	Sat, 30 Aug 2025 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ChxEywsv"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010008.outbound.protection.outlook.com [52.103.68.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023042566;
	Sat, 30 Aug 2025 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756518155; cv=fail; b=tlL/u9n5KQ1XHVdzxmaYLNsKppwTHr6qXhuR6Z0TbMX3StA2alLO+9GKJX128UwwTcQVs4MnoPt1icJaOHwJ2Q7o1b51fo/VcRHk9e9pWzFl5uf4cAWoywBuyKmD0ajp5SeRtB1N+/5nWvfC65E2QREHTIQsszzlNnH9zjCDdU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756518155; c=relaxed/simple;
	bh=voDwNnNW0mqOr38eR2Ynmxem2TbnN4ANPAA9lqDF1+Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kRjLd3SNH+maEMbhwA8ydytMISwKcpTDm+Ca33bNVP2jz1P2AfPM+c33ZE/p9Qe/iPimHEz9wA0RuBMF8JA03K6Id8Y9JpkU35efzbTwB5GLA8Q02Pfz7yIUlpOrp1eQnNn+uS3FFdf2axO+T1bi/fk5pMit5WpWV9oCNpZShoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ChxEywsv; arc=fail smtp.client-ip=52.103.68.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr7pEOgB61EUHqRzfIt/z7eeyDe7Dce7+iKczKLk2mexJFbISGpS2yW35KY6EQGobhkMZja2bCpxj3S+Pnh96UXG1y8UYSzilc/Lj56jFJ1x9HBPqPEwIcZjV4lRqoBte3XCuPm1jWTCSJDlJJFjBmi/rLeyQvrWiMwBd/VSK++RmtLFM5qDi24HF5zdEqbAIL9hYP/5i7fwi03EOZGn+5JTB6LOSzyLQryfwygQM+K+GEam2aiSGCZtymwZl5KQijRfIS5YmJ4tOuMp//bp9ARcl1V45fXQAGrz3wMtd13dYpHWiABhQMFkrB3gw8A6QTDVFniy5r6YGpqQZUsx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sE9dSgSuniW1/yPUJUeWUKT9+0D44fxOydGxnHf70qY=;
 b=l/tbFYce1OT0jMxitB6LYFB5+MUOYs/+iHpqQ1cV475knuM6GDTK6HPzuvpAf2rjvJefoj1KHuKP3FNByfZwrIV9SDqHK9MMrQ2mU7u43PgWGnpClcQI78DixiKTjadh1D09vG6GAaId24UxrIO745iaRTtSchivud3jfx9i3zCNmBn1chJgsVQPskVpaMjWh8Z4gEbBJREz8/dWhXLEcY0jQCqBPDDxtty+w88JTFk6RjSKbcqumbgtZf5ZbPLexPhbsnQBPqCzFYs4pRqdtWbQer33g5dFtGTiT/1P4tF+bFW6+ZtxOfD3vjvsjw2aSurkWIk24cjeaYIO0kWcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE9dSgSuniW1/yPUJUeWUKT9+0D44fxOydGxnHf70qY=;
 b=ChxEywsvjj/FsjYEffJHDrYmM8XiHnDuC5tLqDg0ANYYJCEHmAxYEMSR8rL7lsBWKUJYBp7c+/uINPGGFovbEOjNPOmgbflh+SELXS1TcjT+FFcJHThUYFjO2WsKqDht0Edw898OXNV9/uKB2Pqeag73issbYmZ9IpRnL3Cx9Q5OjX3AKbuhdg1PTqk1DAV6cGSi7qsme9UkXYvbnWxx85yS7pwBRRiN7Sow8wMsj+XfZhGXvZwDCmP/WQSqjCrdR9TCeU2Kvsj7BQhLd9h6B/5FyLBKPoZQga5AUGKObxOt9VvZLFWMtbRxh+wJGzA1Uj70keDB+ESAtTPwcgkspA==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by PN0PR01MB6686.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:77::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sat, 30 Aug
 2025 01:42:21 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9052.019; Sat, 30 Aug 2025
 01:42:21 +0000
Message-ID:
 <MAUPR01MB110724EF2C8233B40B1E485C6FE05A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Sat, 30 Aug 2025 09:42:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
To: Rob Herring <robh@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: kwilczynski@kernel.org, u.kleine-koenig@baylibre.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, arnd@arndb.de, bwawrzyn@cisco.com,
 bhelgaas@google.com, conor+dt@kernel.org, 18255117159@163.com,
 inochiama@gmail.com, kishon@kernel.org, krzk+dt@kernel.org,
 lpieralisi@kernel.org, mani@kernel.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, s-vadapalli@ti.com, tglx@linutronix.de,
 thomas.richard@bootlin.com, sycamoremoon376@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, rabenda.cn@gmail.com, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <cover.1756344464.git.unicorn_wang@outlook.com>
 <1df25b33f0ea90a81c34c18cadedd38526a30f01.1756344464.git.unicorn_wang@outlook.com>
 <20250829170908.GA1016165-robh@kernel.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250829170908.GA1016165-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <4ad2e897-cd56-45a7-99ca-72903bf1e535@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|PN0PR01MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: a7997005-f405-47f3-f6ef-08dde76675cd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|461199028|15080799012|41001999006|5072599009|8060799015|6090799003|19110799012|440099028|41105399003|52005399003|40105399003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW02V0RFdlBhd2Mva2NFSjNGbFFkQXU1bHZ5eHdMRTFsQXVqZUdRcXFNaWpi?=
 =?utf-8?B?UEMrdjJpTUJPWWk1M1c1R0RqTU1KN0c1VG8vVi9mbTRhbEd4ZC80SWZibnM0?=
 =?utf-8?B?SlE2QmxnQkxPVG9xNlNpQnlJbUVSY0krY0RxQ2xaRFl1QzZrV2hweVRlZjhN?=
 =?utf-8?B?aVZ2dEphamtpQVJzZHRLNkV0aG40NnE0N1d5bWNRak1HUllLNy8xSHg1OE43?=
 =?utf-8?B?TWZnakdPcXhZbDczSjUyODUrajRiNVl5UGdwV3RXY0JxVVlRd044MCtHQkZ0?=
 =?utf-8?B?Sm1kN0ptOGVKSit2RkZIOXdVSGdVQndOWTNjYXZqcyswQlZlUFlsbWJCd3Qx?=
 =?utf-8?B?TFVHeWpnRXFkVE9tR1hDM0IrNWxrZWlJTHZSMWl6TWd6NDVPNFV3Q0d5QWQw?=
 =?utf-8?B?YmdBc0pzSC92S3VuSGJIS1FUb0c0MHFYZHhwSGh0M1hwK3QxRUFvVGxEL0Mz?=
 =?utf-8?B?Yjl0cTJ1Q3UxRnFpdzNVWkJuaUtHaitmWThjU2lncG50SjFqSjlJcWl5dDBC?=
 =?utf-8?B?eUtpVWsxUmc4SkUwVzFta1hNaUZoYTJLalg5UVFoQ2hHTzlzK1ZCSGp0R2I2?=
 =?utf-8?B?dXBIZTNoV1NrTVNUcndBNkR1UzJYTDFzVTFmaUxlRHZEdklLWHo1MEV2MzVX?=
 =?utf-8?B?cVFkV3lPWkt4djB3N3BUWXc1MUZCZDNMblZGRnhDZ1Zudk8vOUpFdU5xK2lz?=
 =?utf-8?B?MkZ6bjUyRE9HR20xYlQ3UmpyNHFPYnlPSkRTZTcwai92U0J3d1R5ZnpKVE1y?=
 =?utf-8?B?KzJmb3cvWnNVMGpYd2NtVHNRUjRzNHlRR21oL3pvQWF6bGErSWZod0ZLZXhB?=
 =?utf-8?B?UmJEWXBGQkpqRlhaMlJwTXBOQ0xORkFDMlZxVHdBT1lweHdiTHlpT0taclJw?=
 =?utf-8?B?NytLZlZYenBGVkpMUXFkV1ZCMlZqVEJyUVkyRTBDTDBoSE9qeXRPSEoyYXkx?=
 =?utf-8?B?bEFLOHpqemxCZEJFY29QTWdNUjZHTmtBclZCbGU5dGFibUdXb2JwWksrNjZD?=
 =?utf-8?B?cEZvUXRiSmtZUGtVQzJ4Ui96SkRlSG1zcHhLZm9MQ1k3dGcreEQxa2IyaklU?=
 =?utf-8?B?VnJtQzFIODAzUk1sWmp1WVZsOURadTVSN1l2ZnBnWnBtK3NMcSsvUDFrc0JO?=
 =?utf-8?B?L3E0S05QNW1pKzdHTHZzWFdJM092eXc5ZFEvTHJveVNiYVEvNEpYS0FiRHdV?=
 =?utf-8?B?R2k0MDJ1R1hQMGFKN2JCVUEvazBGNFhzdG54L2c4TlorS3hyUVhZbkRQRHhj?=
 =?utf-8?B?NkN3aWF1d0RqYytkamlyeU5sRzhBQXduemhDcm5EcnhPaEs0RlVLcW54YVdl?=
 =?utf-8?B?TlNuUS9vaHI3U2NuOWNzMElpR0svNGZacXFvekNMc0lDaEwrRGhZZDNVVnZ5?=
 =?utf-8?B?OWFqMHRNd3l1b0c0SE93akhNMTJ1S1E2TVBYQlUyV0lsZHBWOXlRcHpzRm92?=
 =?utf-8?B?UkNHVzZYbS9IUXFyZmc3SnZZZmRPN1VpVFExUU9vNGZhMjlZYml5ZW5CQVJz?=
 =?utf-8?B?M3FEQXZuRlRyeUYyV0dSbkowYmJrVm51Ylo0T2IrZDBOWWxmbmxkTkt3dmJh?=
 =?utf-8?B?ZlFzaG01UmpjS1dIK1hpdkpteUpRZUQxQU05WXZhTkVzU1NFK1BmT3U1ZUNW?=
 =?utf-8?B?SE5BelNzMG4wekM2R3JaSTUzOUREWm9Tajd6MmhNQTlJS2pMT1NtbUp5eStX?=
 =?utf-8?B?Q2wrVk9ZSmN1WmVZaHEzQzNFWWU5MXRuVUdIeTJPcFZBUm5ocERIb1RBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0t6bmZGTnQ1Q3hId0JBRkE4clBSamhvUVBzY3FrdzNRMlVwSXIvcHhxQjN2?=
 =?utf-8?B?ejR0NERkMHRwZy90UEtXU3NYR3NqOERaMkp0c2NYSWh0RmhNRTkwTHJCdGlV?=
 =?utf-8?B?OWNCeWZWbXNJRGtTRnlMUFV6NmJ4ZGlmUVA3aHFZYkttblUwS1hsWXBxcDhV?=
 =?utf-8?B?SzVET3B1d0w3Q1psQmVFRjVsN1NWRlZzcDhpTUs1NXF3b1VpM2p6NUUvbU1y?=
 =?utf-8?B?emlQQ3hLMmdwUlhETDUwaVNZY2lpVDUzelgxOFFPc0FuMjFmaDViTjkyY2hD?=
 =?utf-8?B?NTVXZkkrR25rTUZVWTdPOVh0SDZoR0hTN1g4Z0dqc3JtdXBSOVMzdjEyTmVB?=
 =?utf-8?B?M09jT0VsU3BOUDE0VzVwUFZ5dk5XVU1JbkRNTmhSM0Znb1l2NXM3azZHTXoz?=
 =?utf-8?B?OGpSMS9rNmExWExJbWdhWUwxbCtBSHRkUXk3Qjd6YWxpVWNjMVcyai9WeFYr?=
 =?utf-8?B?a2cxYkNtVE9SWDNLVGQ1endtSHBlNVQrMEkyZFlhMlMvb1ZGaTUzLzg3T1Bv?=
 =?utf-8?B?QmxnaDZOR0RaNHBZdE9pRUZsS0E0SGNVYlE5ZkR5SXJtUDE2Q0lub2QvV3VD?=
 =?utf-8?B?d3o4NFNiTkhqQUJGWUpqa3c2VE1yNUxYUHZLeG5FL2pnK1dEVWlsRHV0MmpX?=
 =?utf-8?B?RlRERDhTYVUvT0dWN3FKYyt6WXBrdlhneFRVWkxQZE9pNWgvNUZ3bUJETFVn?=
 =?utf-8?B?YWFueEdHcEFtUFI5S0krbWdhRmNrRGxrRnU4a01LeEpBTW1hQnFMWTBQRStV?=
 =?utf-8?B?eGZhQjhvbEhYRndNTVBQUGFZMFB1eXYra1Y2TUVPWUQra01CMjg1YUR0d2Vk?=
 =?utf-8?B?VG1nd2NKSVRxSUV5QzZpU3orQkRXOS9sWXd5MjlQZmJCYm9DdzdtVmR1Y1pW?=
 =?utf-8?B?dnFyQ2ZEREd0T1BxRFBveG90STR4S3hRc1plV05IV1hNOVQwNUkyK1RYWGJB?=
 =?utf-8?B?bjRkeGRBSUZBT3VERW84OU9Fc2QycnliZW9iU011SXhuL2lDV2ZyaHpwRndD?=
 =?utf-8?B?Z3ZKNGJ6d2JRaW4vTEJnb1ZVNWxwT2g2VWltUmNwVmpNcHRaOURMek9BUlI1?=
 =?utf-8?B?cmRPajgwR0h4YkJDZ3ZtS2RvdjZzMk5YVlJuQjM5S0RhajhERUdoU05uL1ZC?=
 =?utf-8?B?N1dCT2p6M2tnZzRMWVl6NCtuTkFSVFgwTCs3MkxyOHRmanMwNGlPV2d3S25U?=
 =?utf-8?B?N2llZTJtYURPcXM1dWt1M2QvZ2JmOW4zZnhRUnk2eUd2K3ZvOEw4NVdzZEZG?=
 =?utf-8?B?SlJZN3ZRd2VxaEliMWtIcjJkK3NyRmhwZ2orZHl1L1JuOWVzSjNKZnZGdElV?=
 =?utf-8?B?MmdFZitCMGFsejRnbWFVMW9RRTVPY0I4ZFc5NzVxbUdnZXVaRFZGSEFqVk5s?=
 =?utf-8?B?a21sbG12ak81UUJHeWEvaFFMeHR6Q01BQ0E3cGhSM3RWUWtrMENlb3hhMHYw?=
 =?utf-8?B?WDlBMk9LVkoxdFQxeEQva1k4azRNWG9lUjRxdldoYTdtTFlOUU0yUmx1NHk2?=
 =?utf-8?B?d3RpcDFZMDNvUlYydktJblZReHJSK3lEVklnRnl2MmlMejFIMFgvVytLNDFm?=
 =?utf-8?B?MlE3dUJzODE0Zlg2czJQbUIvU3F3WmtlaTl2M2cxRVNnellDUGhwenlST25B?=
 =?utf-8?B?RkNtZkh1YURmNVlXTW5iVW5XSGVYdlF5Y3ZFMzAwblBiRzl3bHFRL3g4RFJk?=
 =?utf-8?B?SE0vVTUwOG5ubk5xcThWdlN0bzM4SHJtQk9zYjV2VFhWT2JSMDhkODArejdr?=
 =?utf-8?Q?Jv1iZCdL1t6Nepf8+k=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7997005-f405-47f3-f6ef-08dde76675cd
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 01:42:20.8704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6686


On 8/30/2025 1:09 AM, Rob Herring wrote:
> On Thu, Aug 28, 2025 at 10:17:40AM +0800, Chen Wang wrote:

[......]

>> diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
>> new file mode 100644
>> index 000000000000..fe434dc2967e
>> --- /dev/null
>> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
>> @@ -0,0 +1,134 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * pcie-sg2042 - PCIe controller driver for Sophgo SG2042 SoC
>> + *
>> + * Copyright (C) 2025 Sophgo Technology Inc.
>> + * Copyright (C) 2025 Chen Wang <unicorn_wang@outlook.com>
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
> Looks like you just need mod_devicetable.h instead.

Thanks, I tried and seems just mod_devicetable.h does work.

To be honest, I am more curious about how to know which header files 
should be included. Is it just based on experience, because sometimes 
including these or those header files will compile without any problems.

>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +#include "pcie-cadence.h"
>> +
>> +/*
>> + * SG2042 only support 4-byte aligned access, so for the rootbus (i.e. to read
>> + * the Root Port itself, read32 is required. For non-rootbus (i.e. to read
>> + * the PCIe peripheral registers, supports 1/2/4 byte aligned access, so
>> + * directly using read should be fine.
>> + *
>> + * The same is true for write.
>> + */
>> +static int sg2042_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
>> +				   int where, int size, u32 *value)
>> +{
>> +	if (pci_is_root_bus(bus))
> You can have separate pci_ops for the root bus and child buses. Do that
> and then sg2042_pcie_config_read() goes away. IIRC, there's examples in
> the tree of your exact issue (root bus being 32-bit only).

Yes, you're right, I learned it. Thanks,

>> +		return pci_generic_config_read32(bus, devfn, where, size,
>> +						 value);
>> +
>> +	return pci_generic_config_read(bus, devfn, where, size, value);
>> +}
>> +
>> +static int sg2042_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
>> +				    int where, int size, u32 value)
>> +{
>> +	if (pci_is_root_bus(bus))
>> +		return pci_generic_config_write32(bus, devfn, where, size,
>> +						  value);
>> +
>> +	return pci_generic_config_write(bus, devfn, where, size, value);
>> +}
>> +
>> +static struct pci_ops sg2042_pcie_host_ops = {
>> +	.map_bus	= cdns_pci_map_bus,
>> +	.read		= sg2042_pcie_config_read,
>> +	.write		= sg2042_pcie_config_write,
>> +};
>> +
[......]
>> +
>> +static struct platform_driver sg2042_pcie_driver = {
>> +	.driver = {
>> +		.name		= "sg2042-pcie",
>> +		.of_match_table	= sg2042_pcie_of_match,
>> +		.pm		= &cdns_pcie_pm_ops,
>> +	},
>> +	.probe		= sg2042_pcie_probe,
>> +	.shutdown	= sg2042_pcie_shutdown,
>> +};
>> +builtin_platform_driver(sg2042_pcie_driver);
> What prevents this from being a module?

Well, I'll check again.

Thanks.

Chen

> Rob
>

