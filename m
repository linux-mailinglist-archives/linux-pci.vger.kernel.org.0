Return-Path: <linux-pci+bounces-29397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E6DAD4BFD
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 08:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C23189C08A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 06:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97E542A9D;
	Wed, 11 Jun 2025 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="Zl9UHl8l"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020088.outbound.protection.outlook.com [52.101.84.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C6C133;
	Wed, 11 Jun 2025 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749624346; cv=fail; b=qfxR35ExrrSgdhhAJQpBKiawxqpSb2D3b9yRg4zbUq74jLhbF+jdahrjjkR5D+oFlKp+fFZwhRdGwfBJJgJIBtCZbIBDXxAYb/F36NKbnZCNGkNbrHXIyQfQp1R3E3LjDmogyh+hnAQIvzjldxJQImZ/IPmeLV9dD4apZam4XQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749624346; c=relaxed/simple;
	bh=PlYVbwqWVOzC+xbaxt6PmLata/LpMIHj4cCkTaHRP6g=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cGaufoS10k9L9TbHROF2dIJ63oOs24RHz01BlDAskjrYatXdFbeAUXiAlLuinK+4um4f5s6mCsJq4agdYds3sDaq97NxgvJCflWsqXGlnnRvQuuYbmY43LQuQzAhDanUYlkOEAOqghxDX4WfnLnUZPCtGyOl6TGaveDARcZ+nyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=Zl9UHl8l; arc=fail smtp.client-ip=52.101.84.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lnv2ee86xqiiCQkFH8g1RKMoDCuVWPvneG2et338uzq/TJFg33DFC67ZLH7N4/J2qob2qr19qe9WT7NieIu8ZyAP76jNzym6y0mys+nW+fq3hDaLfTLzP7Wb2VSIxp9ktOceb88gmbF15lvp9b0F7sV9iOH0Qo1eGfk+MGXPJLnbBFiheB3PcRuDcgDill9cdJOMEIO/kcC7nQOAlibuP6JM5SLyk1YUXfxv+QYp5M92de5RSmfoCW4+FLYu3G3uwnEWc5LEDp0Y2xNipr39TV563fJ8QHm23wMcs6EjYbMyjCuAEshoW8A7L16oQKds3JOxdmu0WW4uRubLqeat+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alEAdeiPWhu8GZqowtQkimh4ku9gmfIMgoc4+fQpi5U=;
 b=qiQTj5Qzj1Ralk/5o8RLhUHcNOhn6JG0S9IzuG5/Vw0DSy3EAmSIFf7vzN8CM6pjzXKHYpvNffL0OeEiLSsA0f9t3DI3YCA00qsMIJebPMmOFWD/WveeqTDCdW9kDeW9c3XXeUqPfs3QBPftd/89uAK5DVZ14T+HjrAdo/eCvNYyc0hzPHZpKOyUwkbLtH5EERS9DCpxcEk+Vk3CJiviBz30lY7imuN5JBZ0AYwBCHy0IJxPheyrv/loibhNF2AHA1J5kcf+Yb2vULPT/6+xDDq79HtH+Fj/KwI6sdhgkkTahdVkNtF3Ojih6acqRSDQGSkd54RVj4XTt/Ua8nyyfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=kernel.org smtp.mailfrom=topic.nl; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alEAdeiPWhu8GZqowtQkimh4ku9gmfIMgoc4+fQpi5U=;
 b=Zl9UHl8lfBS+OQRoAMh5lWgVJfZUB0RzQYMIohXMPO2gvOCL+KvMSPbmL3sWpymeuKtmi0cNOQnEwOsFr8F0/XFnJ7dF48CInymiNFUQXHFvLRZ+SfuJ1bF5OF5kVjf18SbMLL1NhcOt0mx/06N9CnYp+/BEtim/AjmHEo8smad4ThWwOba1bJxyYr+x8HJKhT/xyG2fEfu4vP4ODEFmcXzGQM72b/XB9cexXBPifI8TFTBX+DTMhaN2mAzVWnEaE2SOrkTxck8IaWedhQvaIbpV29dTTPPjqjoiE0iUKIy6AfpwBb+vvw8UZeOoGo3AP35fxQ8bIVMJNJF7HExiDg==
Received: from DUZPR01CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::15) by PA3PR04MB11180.eurprd04.prod.outlook.com
 (2603:10a6:102:4b2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 06:45:38 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::9b) by DUZPR01CA0077.outlook.office365.com
 (2603:10a6:10:46a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 06:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 06:45:38 +0000
Received: from MRWPR03CU001.outbound.protection.outlook.com (40.93.69.30) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 11 Jun 2025 06:45:38 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Wed, 11 Jun
 2025 06:45:33 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 06:45:33 +0000
Message-ID: <ec74b712-4fe8-46dc-b446-6cb244a94198@topic.nl>
Date: Wed, 11 Jun 2025 08:45:32 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v4 2/2] PCI: xilinx: Support reset GPIO for PERST#
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250610190718.GA819844@bhelgaas>
Content-Language: nl, en-US
Organization: TOPIC
In-Reply-To: <20250610190718.GA819844@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR02CA0218.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::25) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|VI0PR04MB10464:EE_|DB1PEPF000509F4:EE_|PA3PR04MB11180:EE_
X-MS-Office365-Filtering-Correlation-Id: 156f63c8-ae8e-428a-a457-08dda8b393c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?akhEUVk0b01WWHJVOTFyMDd5aDhERk9tMm9meHpROWNNRHZoMnNYNG5BR2Rt?=
 =?utf-8?B?QWp5NWpBaDQ5WHExQ0VMRDYyVFRaRWJmYnk3bDFQSUovK0FHa1loVi9KcHJh?=
 =?utf-8?B?emN0Nk82WGVmc2llREd4SFJLUi9KSTI0WndxQjAwenJEYnd4Rkg5Y1pZQmJH?=
 =?utf-8?B?UlBKRzJaRExZTkU0U3dTVCtNRlE4a1ZnL1N4Ykc1aXI3M0dJeGJvOEdHNFYz?=
 =?utf-8?B?Ylk1eXNCVEpaTk5idEUvUGlLOW1iZUtvcmJiMy9VSGtNUlB0d0F1M3hpaXgv?=
 =?utf-8?B?TUhiNXJGaXU2bTJocnRvUnlhUmlBSmVJbDVQMmF4SDVhVTNFUWtxM1l4Vmxl?=
 =?utf-8?B?MGxia1UvbkoyenhoTmhtQVJ6UGF0Y2N4alhmRjNTWjhYWkxWbFVQZFM4TlZG?=
 =?utf-8?B?d2hpamt4dy9tRUNFRGVRcmtzNC81clpodW54cEJPOGlJd3l3OW9vOWxvSVgw?=
 =?utf-8?B?blNhdUwwQXFUWWlFKyt1bUQ2UEZpS3ZjOHBNY052MFdBcnRyNWUvM1pRL05q?=
 =?utf-8?B?WmlhTDBIOEVYMEMyTktJTE0wQnZWOTlYMWdPbEhOeTlGc281aS94VHc2cW5N?=
 =?utf-8?B?d0NBbWtKSGFLNHZzUXp0QnNHaENkcXhvelFXb2xTaCttZ3NsOVp0cW95aFdM?=
 =?utf-8?B?aXo1SU8zdWVXSi93aFhOVGkwaVZGODc0RGVlYnJ3dTJMdlc0cGtadWZ3RXBz?=
 =?utf-8?B?VUMvS3ZPejNjQ3VnYVFETndMMmszS3ZmSjhjU2hiNUM3QW1yMlVjbjA0ejFM?=
 =?utf-8?B?bE55SjVmODFiUGxiNFVKWCtsTEdkdUxQSlVMZTNicGVsSUxqL2p2NmNEZjZr?=
 =?utf-8?B?YklMZ2dkUGU3R3YyQlZDanZjYk8yUnFoY2Qrd1JnLzZDMUNDcDR5bWh5SmY0?=
 =?utf-8?B?bjhuempDQTgrMHhybEd2ZVp5RWkzMG9jc2dFelg2d21ZUE4xelI3bXpKeU9k?=
 =?utf-8?B?SHFyekZ0YnNXNVJjb2NYcEZIZ1d1S3RaZTNoQ1lpbkpvKzlRd09OcWIyeStp?=
 =?utf-8?B?RzF4b201MENTWWJtMmd2eWhMWEpSRENWbVgrRDVINTNkTmdSdVcwOFc5UVpt?=
 =?utf-8?B?TFd6Zi91TjRnQWV6SU9KMWs0SXRDaEF3cTd0QTB2VGd1ekd0QVUxRENhRnV5?=
 =?utf-8?B?Z1J3UWJYZ1hZUG4rTFRFT2Z5TEZBWUNYOXJIWVhyU0xVbHhxZThqY2JnVktp?=
 =?utf-8?B?U052SHJySFpDOGZhRWp3MWdDcWZRUmVkZSt5a0JZdUZ6L3dPN0pZdHJoSkx6?=
 =?utf-8?B?SndSTFdwNHRabWVjZUpCWkdlcGt4aU9pa1BHWjdaOHJ1aCtNaHdMSEVQa1Nt?=
 =?utf-8?B?WmVucVV0VHk1NDFPMVlqY3RLQVlDYzlZSGhxNld6S0RLZjd3ZE1FQktvKzFH?=
 =?utf-8?B?cnREQlpZZTJrUW5xQk1keGZxTDZ4d2ZlTnNjVXJMYzJKUkFhTVpuU2lFZjZD?=
 =?utf-8?B?TUo1aGx5bXhCRUJvT0c0UDA4L1JLN1J6enVIaW1qY0ZVSGwzUTMxengwSmVM?=
 =?utf-8?B?WTZKZ2pucUxTVUpLQ2NYZ0Z4ck1DN2VCNncxMHRVc1U4R1JydDNoMHRMU242?=
 =?utf-8?B?MFV0Y1ZiU3hMbVY5cWhSMHVGUFFuZGJDcTc0L3VCUWRDYVQ0VllHSk5RMGhs?=
 =?utf-8?B?RE0rTlBPV3BHMUN5a2xDNDVQd0hHaEgwRzV0TWF1K3dlZG5uczJtWXFyOUN3?=
 =?utf-8?B?Ri9XbU5QVGozR1VpK2UyR0p3d3B5aE9vUFg2eFUzQlFWR3g3VVlkbFc5NmlL?=
 =?utf-8?B?bkM4Zm1iUUF5SEROUkNnams5WTVXOHV5bmhEMGdKbUpidDBLV1EwQWdaWXVr?=
 =?utf-8?B?azhOVCsvaGk1TFkxTE1qTTlkOGZURFlGczg4c2lSWENhSGtRclRwUmtWRk9r?=
 =?utf-8?B?dU8wdkhtaGlCYk1nVVR4ZjZDUEExU29QUEpDWE1td3hEWElKcEl4MUg1NWxq?=
 =?utf-8?Q?IuOOBC3My0o=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464
X-CodeTwo-MessageID: 015314e7-55ef-4107-bf7a-062d6fb5f6c2.20250611064537@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	86558f8d-a974-4a33-b4f5-08dda8b39064
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|82310400026|376014|36860700013|1800799024|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkgrS3NkVGtVOHdIZEJlNG9nYzhBMGVMNkt5ZUsxLzl5SHVLQWdIcUJIdG16?=
 =?utf-8?B?cWNtbmVBRzBuazBtYzhWcGhpSlE2Q2RUR1JPWmx6REpxQWwydW9kNWtpODhC?=
 =?utf-8?B?clc0TWE1TVYvZ2kwMlY4VWxjODJSTXJaN0NRUnI3NzNLcmFqVEljVGhmZ0J1?=
 =?utf-8?B?bzhjNDVnV2xLTUxBR0VoU0YvcFVEeUhkeUxGS2lDOEFPZzBLdHZPMU5lNmZL?=
 =?utf-8?B?a1QrU0k2WWtiT0Jhand5MnZVZHBqd1pudFZ3M3VFWlYwUXZJMXAxQnB5cEpH?=
 =?utf-8?B?MElyMGZHN3ppcnlxOEpad1hoZlZUZEhVWW9pdWRIVFEwNkozMU9uZTNSUFFj?=
 =?utf-8?B?QlZLNWp6a29zRzIvMnBIcGpONnhYdHhqK3B2c2dBdXFyMlFzdTdzc2xhelJK?=
 =?utf-8?B?UHNGVDZQMEh1VGt5ODZBUkZiYmlDV2VLZHoxZS9SVDdWNTY4K0YrYlcvLzRv?=
 =?utf-8?B?d0xYUzFBazZWUUU3RE55VGpOQUlmOWFEdG1xb1BDS1Z3Q01lZHdSRnRLWStI?=
 =?utf-8?B?YTFiTFhZYms5TGJJZjRFRHBtZWdVelJadml5TTB2cUVRcHNwTWxJUVZ1dkxj?=
 =?utf-8?B?WFo1cStsM1kvNmhSTWtKS05zenN1dFM1UXEyN0QzYTBWa2owdUFxbDRzSUN0?=
 =?utf-8?B?Z3hIcXlPTFVCR1Y5THVBNktVMEtXT2JmSDZRZ2dIdG1jY2p0QW84MWhUekl6?=
 =?utf-8?B?SE14ZGo4dFdjMjBPVzI3UE42TzJvenYvWERuOEZMNWtvZDRiRks3ejdCem4w?=
 =?utf-8?B?ZDlocEFkbk1EZHRmaHpERzUvN2FOQ2RkZUV6WWFGT3Q4bEZpWDU0NWN6M1Bv?=
 =?utf-8?B?QzVMSVVKREVwUmZlVTV4UkdybE9EejEyemdDODRMTXBJdUpVWjI5WWdNdGtO?=
 =?utf-8?B?Umhsd2l3aCs1eVNXRi9QL1duaFFZS3FRQ3FobW02MnUyZVVYdXdpeG1QWTNx?=
 =?utf-8?B?azZwSkNPL201YnNiVnc1S09HWVpxcm5pMWs0RlEzbmFOWjYxZDJxUmVKV09Y?=
 =?utf-8?B?R0QvMGRWUi9EcHlZem5LTG90WktLZ0k0VHFPRGxqSFF6bytBNzFTbURUaDBK?=
 =?utf-8?B?bkpkVWY3eDIzMmlwaTBCT3ZmVUR5TElaWEJ6OXNObXpWdGlFTTQ2aEEzT1ND?=
 =?utf-8?B?RGR2TlZzV2w4ZUNrMUUyQ0NGRTV5ZitESlY4eS9iaUNyZVhSRTg0RDgxYzZ4?=
 =?utf-8?B?bmFmMm95WWgxeWFMczZRUGd2ME5sUFlWQlVGSUtCa1BUZS94dHBDdnpORi9K?=
 =?utf-8?B?TVo5M2czSmtqT1JOK3dhZFFoOGFxdEpFVVJiUElhRUJnR0VjSld5enBCZUc3?=
 =?utf-8?B?ZllYMGxPY1hHTU9CU3pZSjVqMnJmbktBZmovSjlNcGFZdWdOOHpIU05KckND?=
 =?utf-8?B?YkpGTnBPMDRXTW8xbW5JUU1VRFdLNGVvVjZLK3pRblNXbUJnbVV2VXd6OFlj?=
 =?utf-8?B?REFrNElNN3h2QzhVWlpiOUtiMnRxUEtXZ2FMcWhrdFFUdFRTVmJmZElOSkxQ?=
 =?utf-8?B?NG9GWTFGRzNPU3RydWEvNFh1WXlvdWpKZlU0YlBZZzhxbERwK0pSZnNQbm5V?=
 =?utf-8?B?c1BQTzdsNTRXZUlUQ3RycU56NW1ISmlJZkVZbE9ZMlBDVkxucnZHbmkyRUFQ?=
 =?utf-8?B?cEl0L1dZTE1XVjN1NkpqTjZsSDBmMXBaaDVSVlV6ZGRJOVA2NUVOSnU3aEpq?=
 =?utf-8?B?bTJlZG1YUDh5cFpsWUNnTkJLTWVWQUVndTFPUDlVd2cyNUpHak5NaVBadEY3?=
 =?utf-8?B?UlVlY1Ywa2p2VmJIV0tobWsvZDZTSnl0R1VmYkxWZjNLam1TZit0RjA3TFdt?=
 =?utf-8?B?bUFCdGZ6Umd5cVMwd1BaWmkyRFFncC9paENpNnJvRzJLREZRRjJzWjAxR3RH?=
 =?utf-8?B?MXFobkZZVVJxWmZDMlhBdG5WWWVZWitWOGZTQnJpTERJRlFwN3RzbVdKNzh6?=
 =?utf-8?B?ZGpJOWI3SGplS0NXM2V2TmlTUEFYdUFONXJyNTRFY1hFYWJzaXlZZEJCN1gz?=
 =?utf-8?B?Vk80aVdscFZvSm56dGQ1OUZQY3cwUE1sU1YwOFlvU2xKMHBUZThMQUEvU3ZP?=
 =?utf-8?Q?xmWsgu?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(82310400026)(376014)(36860700013)(1800799024)(7416014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 06:45:38.6439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 156f63c8-ae8e-428a-a457-08dda8b393c3
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11180

On 10-06-2025 21:07, Bjorn Helgaas wrote:
> On Tue, Jun 10, 2025 at 04:39:04PM +0200, Mike Looijmans wrote:
>> Support providing the PERST# reset signal through a devicetree binding.
>> Thus the system no longer relies on external components to perform the
>> bus reset.
>> @@ -576,11 +577,17 @@ static int xilinx_pcie_probe(struct platform_devic=
e *pdev)
>>   	struct device *dev =3D &pdev->dev;
>>   	struct xilinx_pcie *pcie;
>>   	struct pci_host_bridge *bridge;
>> +	struct gpio_desc *perst_gpio;
>>   	int err;
>>  =20
>>   	if (!dev->of_node)
>>   		return -ENODEV;
>>  =20
>> +	perst_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(perst_gpio))
>> +		return dev_err_probe(dev, PTR_ERR(perst_gpio),
>> +				     "Failed to request reset GPIO\n");
>> +
>>   	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
>>   	if (!bridge)
>>   		return -ENODEV;
>> @@ -595,6 +602,13 @@ static int xilinx_pcie_probe(struct platform_device=
 *pdev)
>>   		return err;
>>   	}
>>  =20
>> +	if (perst_gpio) {
>> +		msleep(PCIE_T_PVPERL_MS); /* Minimum assertion time */
>> +		gpiod_set_value_cansleep(perst_gpio, 0);
> Are we assured that PERST# was already asserted when we entered
> xilinx_pcie_probe()?

Yes, because of the GPIOD_OUT_HIGH a few lines up, the reset GPIO is assert=
ed=20
when we arrive here.


>> +		/* Initial delay to provide endpoint time to initialize */
>> +		msleep(PCIE_T_RRS_READY_MS);
> I don't think this is the right spot for PCIE_T_RRS_READY_MS, details
> in https://lore.kernel.org/r/20250610185734.GA819344@bhelgaas
>
> I guess the spec assumes that for ports that don't support speeds
> greater than 5.0 GT/s, 100ms is enough for the link to come up *and*
> the endpoint to initialize.  But since you're going to wait for the
> link to come up immediately *after* this PCIE_T_RRS_READY_MS sleep, I
> would think you could extend the timeout in xilinx_pci_wait_link_up()
> and then do the PCIE_T_RRS_READY_MS sleep.

That would change the behavior of the original driver though, which never d=
id=20
any sleep during init. But it appears to match the spec better. Note that t=
he=20
hardware is limited to 5GT/s.

M.





