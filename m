Return-Path: <linux-pci+bounces-31063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9025FAED692
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 10:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022B41891FE9
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 08:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA74423ABB3;
	Mon, 30 Jun 2025 08:02:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023132.outbound.protection.outlook.com [40.107.44.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E1321B191;
	Mon, 30 Jun 2025 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270579; cv=fail; b=MVoc/2GswKX5peEMJxftshYo9KzEqvFehov9kaBe3K9rgOWA1hFx5Cbl+y8Nl8wNE+UfLjTvrQt+wczfcliBEyB6P0GorFqUBp4dopNT9xopEGHqscHTGkgyK6XBV7YEwAONmJvmEjGVuI8D2GgFI7ktKWUs1SEhL/ESu6UmSEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270579; c=relaxed/simple;
	bh=HeVJNhAmf1lNQS/q8VEDjMYQqF5Tt5OoNVPmwKh68iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luRMn1OyMlKpMi0i0oni0Ra88sHVQg595WUfvT+swqCQ8QlZYf3eskmXRzzMHpYMWCNGpA0IClbSFZT2+sQUxkVFp6kLcsvHz980oQ9/iRtDuN542O0X2uG/8Pju/DuAotBoGYbnjeoa0AW/uoLjW73otqOlxgYZcQCEd2GpB54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocIuveDVWXNqAFI7OAWH4yh+xmB2Tzj5hYzt/HE8s0egCwCO479+LSBa10NVln1oiDUOoWfdDMnqUq2hctBOF3mO2MBFshZ+78s1YBT67R5LVckF1ZcpIzAWTwqJrigUauzME0NG40s9k2u8szsab29FVTpsO72hW8uN73MG44BvAavWd4PROw9/kWvMUEkxYxHjyfINwhOmlv1ke2+VooJ4swcT9dP+G5Alp/O5OHNzDswD/eQx59WhCfSrhkOFAYT9LqcJ1eo0NYUfPbVYYh5DD/OY7Gj+LqhifncDJuWb47lwQ5OdIs+K1kZrH5NKWbv+SeDkgCOX29uwRvd50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJnmzNsuF7G5YZni2Ipu6cU5cBn/S7Wm4f1EU3GnDa8=;
 b=A3bMadK08w8PBQej/dpBVUMw6HGWsmUHpTDbxjASKo4fwaWIxziccjskSvyhsXkAV0IsEb2PPc4r3v+BMhuzQ2WxuDnmG8fSp7wMK9WzMgF5CkiwRr0jIX+HHETBHZdRzoF88v0R0QnbBmURvxFbfRU1POCHgUxaw0MDhiqzxJVTQqHC/NL1HDnBltWr27SDKGy/HFFdipbj4QCpdMcN0OXSwqXn/CpCX9GJ63zsZpFK52GwBYbsfJTfGATBCeaWSSZoYvamgBHoo9iSslFQ3bJLDXt5RE4Zv0sPwi/FKXEQfBVP6KbUBYmiJZsCejQWywIXKIkK5hhLGjyP/Vsa/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY2PR02CA0065.apcprd02.prod.outlook.com (2603:1096:404:e2::29)
 by KL1PR06MB6162.apcprd06.prod.outlook.com (2603:1096:820:d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 08:02:52 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:404:e2:cafe::f9) by TY2PR02CA0065.outlook.office365.com
 (2603:1096:404:e2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.25 via Frontend Transport; Mon,
 30 Jun 2025 08:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 08:02:50 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0873E44C3CAA;
	Mon, 30 Jun 2025 16:02:45 +0800 (CST)
Message-ID: <afeda0c7-1959-4501-b85b-5685698dc432@cixtech.com>
Date: Mon, 30 Jun 2025 16:02:44 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/14] dt-bindings: pci: cadence: Extend compatible for
 new RP configuration
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-2-hans.zhang@cixtech.com>
 <20250630-heretic-space-bullfrog-d6b212@krzk-bin>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250630-heretic-space-bullfrog-d6b212@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|KL1PR06MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 664117c1-2c3e-4d38-24e4-08ddb7ac8275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MllndEZDOUcrVmFaM25aeVJYMk5SamR5UTQxRlM0UjhoZXdpS1VxTE95ZDBt?=
 =?utf-8?B?VXdxVWR2dnBOVTRwWFpNZ0FELzd3b1dxWTV6TmpyZmNSWThacnRMK1JSbnBj?=
 =?utf-8?B?VkpnVG40akgrOFh4Nkl6Z2VDeitVdTVrNVJHVXdlVWt3blh6ekZGL2FZSXJt?=
 =?utf-8?B?eS96cHA4VGZDeXoxMWxPSnJiSTVkY1o0aHhBbXNiUnlFY2NOWk9JTTNhakV6?=
 =?utf-8?B?cUNDNXRvS0VOaGRlSFZVRGFjRlZ0SSs1bXBEZjJrRlpRWnppRjZiWDZzalJE?=
 =?utf-8?B?cjROazdERjlvcS9wMmRQRGUyRlFsampZTGxmWE9NTWQ3UXFETnZWYldBSlZD?=
 =?utf-8?B?N3JHdkpjc1Z3Uk1FSzMyUWxFZzhiZlVqeE1JZThZTWQyRzBvcGpKcXBQR3pY?=
 =?utf-8?B?WlRqdlJMSmhSSFVhYnRGVTVmeWdQazM2QWVtU2prVTEvNlJYUWlPaVIzRE95?=
 =?utf-8?B?LzNQUXdiVkhlTStNU1RvSC9lU1NkeXN6UEhHVWNsSHlUN1BHUnlwSldPQTUw?=
 =?utf-8?B?bWNCd2ZYL01yZDBPb3ZyNXVYdlpmZ1RHTklWQ0R0b3VCc014azZRczcwL3U4?=
 =?utf-8?B?cGo5dy8ydVNFcktJTXRhd3lIZTNYdFZQelNjVXJHcTIzMHo2ZE54NGtkZncz?=
 =?utf-8?B?cEgyWTIxTEJiTnU3bTA2a2dmaStLeVN4VFFuc0ZIMXo5RnMxYXc0bnFMak5w?=
 =?utf-8?B?cTk2OVhxMEp3djl5TURlcTRhOHlvN1JUNVJYWjA4ZUtvVmc4MkE0Q2M2REpr?=
 =?utf-8?B?RTU0dUFIM1NxbXFkUFhvUHYrMTliUHlQdkQ3Y0RZbGl4RFpZZ2pjNlpRcGFZ?=
 =?utf-8?B?eFE0MWlYWjNwUzBBUjlTVktRMThHNFZqMk1FZXBzQnBON253NGJLeGVzYzRI?=
 =?utf-8?B?WllhbHhsQUhpN3R1a2VMRDBiNWMrUFdURWhYMFp1aHA5VDBSUjhaQ1diSW5Y?=
 =?utf-8?B?SXAzREFlSEkwL1FOQkNHL0FZM0JDUlNmeCtOYUtEN0dyMHFsNEt5RldhUlkw?=
 =?utf-8?B?ZmNZbTh2N0lvVHBEN3RQRi9EYWhaMm5KSjNLaGQ4Nk9Uc0YySnZEOFdnS1J5?=
 =?utf-8?B?QlZmckpMUCs4RW1MSjYxTnNYYVdndk10eHJybVZ5eldvY1BkRlNDc1ZUNVV6?=
 =?utf-8?B?bFZDWEVqNWlmMU1uYnlsdUlRTGxMVTBuYWQ2R0F5Mmd6aUR3NUN1QXptcHd1?=
 =?utf-8?B?YVpGTjRXYVNWVjhVRW0zVlVSc28vbmVqeFR5VXlVSUJ4d1orQkNHSTkyM3Yx?=
 =?utf-8?B?dEtraUhDSDhEeE1mZ0dPODB4bzFJRUhTT3JRNVlYNVdCUUxoVnZYR005MXpD?=
 =?utf-8?B?ZEdDTVlSOXloRVJTdnVnRHJjMFhicUx3TSt1WGNwU0haa01lYnpDKzlaTlBK?=
 =?utf-8?B?dEp5bkZOWDRDMm44STlJUHBVemFnRnRyQ0JmTmJVb1ExRkg3V1NCTjRTZ0Yw?=
 =?utf-8?B?TnZIZHdrWmhwL01QYnBubExrSlVtaCtOM3lZaXhTaFFaalRKQ0w0emZldW82?=
 =?utf-8?B?WW1iTms2SFBvMk1hbE5FdDVPRnE4T2dNWFJCSGlxUUVTd1pXWlR4a0JaL2p3?=
 =?utf-8?B?VXlCS0Z3S1NVQ1FSRnRrK01lazRTcWVSSm02NTVHT01RNlJ6OW5WUzVDZHgx?=
 =?utf-8?B?NktsU3J5bHliNFZZUWFsTFlObmJiWEF6R2RuZEdMN1pZbWhGZTUvTDNNMzBY?=
 =?utf-8?B?V0pzVlBHNXNWUm96cHNseGhkYW9DbmE5MCtSdksxZ0JIeHc5NzBUVVovaGY0?=
 =?utf-8?B?K0M5OXRmVUJaY1BYd0k4Q3pUN2VCMkQ0eFNCWlc2dGhCY2FDTkVQTVJUYmpO?=
 =?utf-8?B?YWVJVWtBNkJROHdFRlFGNEEwZzdCMGFZTzE4RVFMQzUzbzVkU05QRDI3MXov?=
 =?utf-8?B?ZU13aDI3dDJ6blltLzBQdnVwOGhIZ3V5RUVvRU0xVWZ1WGYyVFplZld2cEVX?=
 =?utf-8?B?S3VHR3VpU3NTTXYvNUxGOExuYXdnQUtmelVDNFloejUyYkRROE1BZ2lxT2NU?=
 =?utf-8?B?WDBzRlZsMUhQa09VMUMwTUxOREtkZGNXOSs0R0lHaENQejVLL00yODNYM1VU?=
 =?utf-8?B?dVRLanFVeE5XKzIxWndodjdSWUkrSHVYNS9pUT09?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:02:50.5318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 664117c1-2c3e-4d38-24e4-08ddb7ac8275
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6162



On 2025/6/30 15:30, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On Mon, Jun 30, 2025 at 12:15:48PM +0800, hans.zhang@cixtech.com wrote:
>> From: Manikandan K Pillai <mpillai@cadence.com>
>>
>> Document the compatible property for HPA (High Performance Architecture)
>> PCIe controller RP configuration.
> 
> I don't see Conor's comment addressed:
> 
> https://lore.kernel.org/linux-devicetree/20250424-elm-magma-b791798477ab@spud/
> 
> You cannot just send someone's work and bypassing the review feedback.
> 
>>
>> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> 
> SoB.

Dear Krzysztof,

Thank you very much for your reply. The questions mentioned above, 
please answer by Manikandan.

Sorry, I missed it. Will add:
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>

Best regards,
Hans

> 
> Best regards,
> Krzysztof
> 

