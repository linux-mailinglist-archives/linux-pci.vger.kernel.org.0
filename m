Return-Path: <linux-pci+bounces-15735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C40F9B8017
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCAB284C5D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FEC1BC061;
	Thu, 31 Oct 2024 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UJAm8Gea"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4E1C9DCD;
	Thu, 31 Oct 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392059; cv=fail; b=td+nhlcu7XeYul0WdqgwjmnrJGRCbIFzcZ/lMTYu4MwY4UhGcN49MCqDumMPEdTJgPAKX72ziPdl8IBgFUIeehelMWGPwZypt+8I7ZiFrufSihd8037fiPC2kxtZMh+rTAWYbf74lKGDuWc2a3FgmjQFOj6NPya79GE3jEx2gCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392059; c=relaxed/simple;
	bh=i6aZ3BpLlZvTDNHNcifM1VjlyX/rs1wNUbpxzMJy3Ik=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bqt6cyqC3XvGHLn98DRchu8zE1tmHKvkDZH0dd78GTfNNJulW5Tgsl/LJUbf9NbP2w/Mc0TXUHHHk8ZBHqMdt7omK3fP2agkD2wa7xAWLug6U9b8GjCl7tle2xJgAiRyf+V3YU2IpPOtayKOyOaEUmrnSO6EzA1OPL28IoleaMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UJAm8Gea; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o98czCV4LFC+SDKgiCWv4HrYfo2UZU6FVqX+IO+cofqvXjJJJzLKdaJLwukDkxlwi/ehKv47MQEhvqHUwIK0pwUqKtskbY6UlGM+kQNttUltyKb/xPVRu64JCM+Y0/1drWq+zfXhjbDJtC+3wAt3DNxX5xWgZXBYAUHXFNwIEDzSRbepiViccBNxr07Y0SCYnlb1jQWKABmDT6R7gZK6ZAohDwvG72wHq3YPyJOjXTnnZwq4FUtCm4D6PvnMt3J/O5bnF5zapObjp+41pnLLuWDNQpEXR8fPiZLXNVcUAUheX9kfziKchXvko2M8PcHX10p/woW2NOhgLJyO4o7iOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdsDZcZopyzwIsuh8/N0Z3TaMLcl/E/eqRHf10fBk4A=;
 b=aRARyyujoXSSoHwTQch8M1SKXZrLQzi4+JoT7gXHFJqM8HlTLt9BKeDCH5NeBOy71NgUnIknzIdwUo0kpGdnC0H79IJXgD0eFnTFNSOb3IVQUI1FJl5bvPxcyFdjonF1whBgPCCr80+K28Hh57g6bUP40WTAs+q5WBS9ikWmuNF0tS5vexe9CFFlGfV7KmNKDqzHjAxStTyD20WgmTvq/pr+QAWqzcWPpjBvgd0fnkx0hqVmODCUyyeQBdFyCbYKLGX8OmRZs2aiPqqEhTH/1WG13NxhBzxVJBYWrelrdIato2TLVKZuxSZnqSirPLUWVNERnM+Mn9szJNTDPUXGlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdsDZcZopyzwIsuh8/N0Z3TaMLcl/E/eqRHf10fBk4A=;
 b=UJAm8GeaNVNtWEwcQZ+4XyKzNdNTW5sGzo+54SPaYYPyIM6eCnySMeWsWyJz7KaQ+ONg2OTwRAERUv1pyWlyxoK5bhZi/nb5Hn4T5+Hn45cVCU5ek22lBZ4Wpjj28Mzk0aJ+HgWX8tUgfAqgsHaQHNSghqsrP4F9QmG3ViIikOQA7NeDGmCzwO3Bo9IfdnmQOjXESrRhAtWbRdtth3pp/4fIoZz0kD+qIadcDwRrzcRU8hSBSYXM4S1VWSWzufBS6Hp+WuBL9+2N2t3nw4D/OYY18YDYUa0RKj1Zn4Au/2sBVwK9QcOXiUqePg83mLHPTVhIPy62en9DMDuKC2Af0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB11081.eurprd04.prod.outlook.com (2603:10a6:102:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 16:27:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 16:27:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 31 Oct 2024 12:27:03 -0400
Subject: [PATCH v4 4/5] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-ep-msi-v4-4-717da2d99b28@nxp.com>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
In-Reply-To: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730392028; l=5224;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=i6aZ3BpLlZvTDNHNcifM1VjlyX/rs1wNUbpxzMJy3Ik=;
 b=5jELuiH5oQz+YJD33m0qwKHJuSgQnlfEdt3F7+EOGKN3nfGuwoR0EzfLnaC1WJnhQTaKPi9Af
 HMOguLXZSh9BlWtf4mkSpwoi1/n+vsifws3EQ8W+bi5VDMNZbNbowDC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB11081:EE_
X-MS-Office365-Filtering-Correlation-Id: ec108188-9697-44fe-ac73-08dcf9c8e8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2xoUFVTaWJBVmJJVk1ha0RxZDJ0cHdqOWhOZWljWi9JM0llbDNqeGdsZXov?=
 =?utf-8?B?MzlhSmJ6a015RFIwNzBtM0dWbUhXSnp6MHJjWUVVSjBXcW80VFU3eThROG5D?=
 =?utf-8?B?NERXbnhzTEdsOFEzcFhGanh0WEpCWWdRTjRTVGRIVjRxNldYR0JKZDM5MTJw?=
 =?utf-8?B?YnhhN1d2U2xVSTNCWERhQk90U1dQbGtidjZXMlVjSk5HV2xDZXZzTXZidWhN?=
 =?utf-8?B?R2tPUDU1ZEhOaE5qWm1PNk1ETTZNZlJZK1VJam91aE13RDB5aCs2dFozTmR4?=
 =?utf-8?B?dzJHa1BwSFNTd3AyOHhUeVNLSm5aZFRvOFUwai9VVnZ5N1hRK0l4UmpHQmdy?=
 =?utf-8?B?c3RZazFtWGhaRjZMczVBMGVwNVVDYVV1VFNjYjcva0lKay9KLzI3WWpwVzRu?=
 =?utf-8?B?MDV3NEZIY0tnUnVMejR6QzVPMnlCT1dGRVJOZ1RZc0hKZjR5d1lNdFF3SzZH?=
 =?utf-8?B?elh6TEZxMTFnemFDU3VEd0V4WkxEQ2xHN1pRaXdaS3ZsYlZZNlgvTnhOWDNT?=
 =?utf-8?B?Ull5WnBNdStFYjJscmZFbnpNc0tXOER6Q1FZQzVHZWdIS0Z4QUJ2bzZFc2t3?=
 =?utf-8?B?d3lSS3BrSWRQaW15cDl5UzY0MEI0aEV1REtlcndNNHRtejdkL0R1aFlKS2M1?=
 =?utf-8?B?Y2RYU05rak9xNmwxVUZrcloxVlFMZkZVdlA4aHlDbFJrT05MQ2VaOXd0UUFq?=
 =?utf-8?B?R2YzdE84QndZcW9SM01ISlNQZnJtMnU5WHkrakZEK21YOXB5U1JKcHlYOE4z?=
 =?utf-8?B?MW5ERGtRVjZYTTJxYnljVTl5VHFZSVJ4ZWhoUk1xazZsZjN0YVhtOFhZNlNq?=
 =?utf-8?B?MzMrNnMyWWp6OHRUbTNZcWVnVmlVUmt2Wk5QdTRMZ1poQlhXY1dzTHRsWnJ2?=
 =?utf-8?B?V1VMd2xVQkxLQWpvV2pPMTRQU3lCbmZEUGQ3WFhzSUs0NVJXdEdwNzFEaVMv?=
 =?utf-8?B?VWhKUkdwb05SZXFZUmxxcWxEZmlMQmFEeVkvSml3ejBlOStQQWJDRTFXZm5L?=
 =?utf-8?B?YjhXb2RMbElPRHk0QXd0blZyU3lROFg2SGszelVIblhnczhEUXFzdFhQc1BS?=
 =?utf-8?B?RVFxOUlRenBSbk9TemZWaEFBNHlqTUVnUnRWcklra3MzTUtBSW9NbERkYlFW?=
 =?utf-8?B?NlBCZlM3V0dnaldrSlpxQVkwK0E5SmhVWHMvQ0IwRDAyamtkdGk2UTQ1TFor?=
 =?utf-8?B?UlFKMW9NbS9XWVpiMHd4ZHZ0NHdPQ29pNFBkVXNIb2dtRS9xclZJWlBmNW8v?=
 =?utf-8?B?VEhBaG02WVRLWjB5WVJCc3FEYmkvSWJVU1BPR05PQTJXVUN2UVphTGdycmtQ?=
 =?utf-8?B?ZFZIQkJXeXZFMFhlZGJ1ekpaNFJpTzBDQjh3SWdWMVhrMkJsb3JKMnVaK0Mz?=
 =?utf-8?B?NWNhbEQ3Y2tLa1ZycVltL0QzNHE3Z0IvbCs0Q2VtUVJsRmZ0ekRiZE1ocHRl?=
 =?utf-8?B?YXJWckZ0dVBKNnA3a0dUV3JzVUJ0U3FWS2xQanJDQnVkZU1rMHpPLytlcEk2?=
 =?utf-8?B?Lys4NjkvU0NweUdEWFFPbzdBYTFTaE5LZ0prT0t2Z00zUUl5R0NiT0xqMW02?=
 =?utf-8?B?MGhodE9GVUIvTUgyRCt4SHIyODdFeDV1c3Q1c214OVAweDk2SXJTTmxqQ1Mr?=
 =?utf-8?B?aHRla2VaaUp5Z1BqVUNiUUxkSE1vb1hFV09HczFHWk0zaTN5eVdGbGdDc2Q3?=
 =?utf-8?B?d3BteW5hV0RwdDNjQ2w5UzBaN1lnelVicEl2ZmNYM1l1NmJEM0hWV2VwVVlx?=
 =?utf-8?B?bUh2LzZyRFREaGpxYlN1ZkJFUW9mOVg2dmVkMmFjUThnMzNwSFdlYUlDdjgy?=
 =?utf-8?Q?cg/jFuGGfckF2OUkzg97wyqq+VdaKD0gHbUso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU9wWTQxK20zdHA1YjUreFlraDUwV25xNTZzckNyTzU2U0ZBSHVIM2M3OWdX?=
 =?utf-8?B?aUptbzlIaUV6ZEV0c242SXlPc3pScEcwOElFbjBNNndYWk94L1d2UG9pTnJX?=
 =?utf-8?B?V0duOCtITEM3WWxhUUJaRmprUHZWK1hFNHRNZFNOTjYxWXhOenA3bVhJVWYx?=
 =?utf-8?B?N1Q4KzR1RHVhaEZ1SzJjVCtvWnhReitEa1J5cjBxbnlTbUdXeVdtV2xRRWFl?=
 =?utf-8?B?NkZReVh3a05XWGh3VXhRaXkwcWI1ektuR0hwWURzc3VwT2lSenloclVMTmQ2?=
 =?utf-8?B?SjV5V3RydG1NZEt4QmRFVXJpdWNOTDRURHZic1BsdE9oMVVmRlBMNFpSdG1v?=
 =?utf-8?B?Rm5CNm5NUG9SRDdZTm41cnExY2xGSWpSemEzNGswTUttVkk2YUxTa0E3TWdS?=
 =?utf-8?B?N0xHU0lja3YwTmFtWG5YWFhxOThrQnJTOHdFOGYzMjJBTnQ0QUtFdkVibEQ0?=
 =?utf-8?B?TnpBTklOUDBBNjRXbUU1SHhsT041VklmQVUrMFVlYXEyTnZjdURGYllweVVp?=
 =?utf-8?B?b0ZrZlkvbDVIeGZETFVFVFdXaDJOUzNpTFlLd2NUOGp3MCs1OWhlL1ovd2RP?=
 =?utf-8?B?NVZSbEtra1ZkZ1UrYWN4Vkt3aEJlR0xnemR6TzZxS3FMZTBNd2s2b3ZiaFlm?=
 =?utf-8?B?YWJTSVVJOTN5cHRqWnRoZlVKUjdDZk1HVlJITmVPRHo4cE5lcEZKVVBDUncv?=
 =?utf-8?B?VmhGeGJUT2VkdmhqOW14NDF0UTVWb1NIejlJTHRKRDRtUTBkcFlhY1pJbVB2?=
 =?utf-8?B?L2c4V1hoc25OZm9aZGk1VmhEUEFqQVZ2OThoVE9TOVZ5Z0oxZURudHVjcW1a?=
 =?utf-8?B?M0g4NkhrNjhhb0UxRDF3OThHblBNS0RWZXprWkJDNksxK1psTTZBY0tlNkhq?=
 =?utf-8?B?bnRFcTB4SG9wMi9zSXo3TEN5dkdrbG1ib0VtcTBCNHY2VXA1RFVGYWovS29p?=
 =?utf-8?B?ZU5CZnNqWXZESXA2Y1kxOTF3a2lUczZCbnJjTFV1bHJ4RlRBY1J0K1NhSHNp?=
 =?utf-8?B?dFFTekFwblkzd0JwYjFGZ004cHdIMklxZlVITjc3SXVBZmFwZFFueHg4bU5p?=
 =?utf-8?B?ckc1dmwyZ0dORk14OWlERXZCRWdBT2l5a1dyZnU1ZHE4RGR6VlF0U2JnUXpp?=
 =?utf-8?B?K0RpcEc3eWMwSmZRT09hbWo4aUR3TXI0bGZ6MllOTG9ScEVZWWdZTXo1UGJw?=
 =?utf-8?B?RjExM2puK3RCRnFPSTU3OXpJSDdRYVM3ejVyNk9TMU5Ha01pRyt1a3RwNWN3?=
 =?utf-8?B?Sy9rTThDVkN5aCtnbXN6bm9HVnNGQ25SSUxxRmdPcFlaTlJXWE1QMHRPemtV?=
 =?utf-8?B?YXVFcnNYRUVqNFFkRnZRSjBUajE4c05JSU9QNHQ4TURyVVBqcDM2L3F4aTBj?=
 =?utf-8?B?dE9mdXJacmhCSnNDbGNmc2FEaDZwTDQzcVBkK2V1eVR0QnpKeUhnRFdqa3Bk?=
 =?utf-8?B?QldHbmtaRkpmOHdWY1BnSFNkdHpWOVJPS2J5UkFWOGd1QlVKZUhiK2VwcXVt?=
 =?utf-8?B?TUJXMzhRd216Z2lDWWtIQlRkb3Z6VitiZVVQbDFaeXQwRHBaSkFJZCtabml6?=
 =?utf-8?B?VFg2Y0NkZU1kUEs2cXlNRmdWckFsamE1RktRWWM3UGxiUm0xNkdjTjd2L2ht?=
 =?utf-8?B?S0FrQzdkN0xydkJzMWVVbWF0MFVCT3FCSXlzTHY4RFlseVlWYW91c2dseVdD?=
 =?utf-8?B?TkxWK3RibTlVNVA2TjIxTGcyeEt3S2FBVEpzcVBsaHlUNkNJdmtGRFJKVlJ3?=
 =?utf-8?B?QnRicjZ4WmJ3NTJIV2tYblFna2VKdG9tL3BKTTJ4T2ptZDVLd3E2Qm9tZjF3?=
 =?utf-8?B?Wk9wVnI1NTJxWmx2TWFXb3VrZUR6OUNPWCtXS1dYLzFvK2Izc1FMR2hHb0Ja?=
 =?utf-8?B?ZmRPUE9nQTRuRVNiVk92UEM5bEY2M3JTRlFpSGlNZWlwSVlCdXl0MHlpVno0?=
 =?utf-8?B?cDZYMUliUjduOTNzNU95WDY0dTlyRHpNOWpxMmJhL3BkbWltcWErVXBONjJH?=
 =?utf-8?B?NVNKVWl2TWp5WVBGZXJhaEdWYnd2dmhXYXl4Mk5CYS94ODZtd2MvTlFQUFdF?=
 =?utf-8?B?Q3BSb3dsb0QxUEUrRjVFWTYvRmY4RGdJM2dCM0dRNGNNREo5clQ2WWdyOUhR?=
 =?utf-8?Q?D6pk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec108188-9697-44fe-ac73-08dcf9c8e8c6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:27:27.5115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEpcAi2OqKo1sim7hcv0WG/wURBMySfU4Fi+D+XPC2NRotx5hJeYfctbLmjmyjnepiJlnvVuhYXvBR5m2LuXAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11081

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
and PCIE_ENDPOINT_TEST_DB_DATA.

Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
address provided by PCI_ENDPOINT_TEST_DB_ADDR and wait for endpoint
feedback.

Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
to enable EP side's doorbell support and avoid compatible problem.

		Host side new driver	Host side old driver
EP: new driver		S			F
EP: old driver		F			F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- Remove new DID requirement.
---
 drivers/misc/pci_endpoint_test.c | 63 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 64 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 3aaaf47fa4ee2..d8193626c8965 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -42,6 +42,8 @@
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
+#define COMMAND_ENABLE_DOORBELL			BIT(6)
+#define COMMAND_DISABLE_DOORBELL		BIT(7)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -53,6 +55,11 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -67,7 +74,12 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+#define PCI_ENDPOINT_TEST_DB_BAR		0x30
+#define PCI_ENDPOINT_TEST_DB_ADDR		0x34
+#define PCI_ENDPOINT_TEST_DB_DATA		0x38
+
 #define FLAG_USE_DMA				BIT(0)
+#define FLAG_SUPPORT_DOORBELL			BIT(1)
 
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
@@ -75,6 +87,7 @@
 #define PCI_DEVICE_ID_TI_J721S2		0xb013
 #define PCI_DEVICE_ID_LS1088A			0x80c0
 #define PCI_DEVICE_ID_IMX8			0x0808
+#define PCI_DEVICE_ID_IMX8_DB			0x080c
 
 #define is_am654_pci_dev(pdev)		\
 		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
@@ -108,6 +121,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -746,6 +760,52 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	enum pci_barno bar;
+	u32 data, status;
+	u32 addr;
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_ENABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_DOORBELL_ENABLE_FAIL)
+		return false;
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
+	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_ADDR);
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	writel(data, test->bar[bar] + addr);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_DISABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if ((status & STATUS_DOORBELL_SUCCESS) &&
+	    (status & STATUS_DOORBELL_DISABLE_SUCCESS))
+		return true;
+
+	return false;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -793,6 +853,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 94b46b043b536..06d9f548b510e 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -21,6 +21,7 @@
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
+#define PCITEST_DOORBELL	_IO('P', 0x11)
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001
 

-- 
2.34.1


