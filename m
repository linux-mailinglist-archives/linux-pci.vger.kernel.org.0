Return-Path: <linux-pci+bounces-31088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9DEAEE316
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 17:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9602E3BD216
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 15:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FFC28DF20;
	Mon, 30 Jun 2025 15:54:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023118.outbound.protection.outlook.com [52.101.127.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612128C2D7;
	Mon, 30 Jun 2025 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751298891; cv=fail; b=jwuKyBrisMXCo6zGQNlNJVA9uTg5sNjJ3FA80ZutF4jpJgU7/zgCEArlef5H9hcbF7A2LdOkr1e49lYHlYPgjVta3ZIpb4Wl57VNOzzk5sUu5JOgnAeAeHU4U1ceIUumBN2G4jaj8bs1Gm4HN+s9TyPyO4ddAHZKDcQsj5Ixnl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751298891; c=relaxed/simple;
	bh=ZI6/tsoFGVkVfH0WAidO7Ep+CZXzygUVi7NDhwH9Sm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVXp+6iYIUA5gQJNdzT+U4fml8D61P7JxqgeA6MPH8oqNk6i8OE+AzH/I2saagzzaeDos1ShQqUCRBXEOp9AL7m1GA+P/DgS2CQeNIUqOhGXxqf08oM4F0e9/FXPAkK8hxU+607duWuYStr3NFWpOhgvVoMFfnzJXdmZUcHkiOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pW/VrxmIZRjf9jcAr906Nqm7bGKohnDCEe5Xe3q6AEp803/6uvtq/6cBxbi+wAQlrD/VhJWYEvCUIbYbWtuMMQH2nh4VPVUjlOMyqLG4+3cA+ps/c5IWCH5p5714ZAokpbyv25VQ7+nTyL1RnabbxnhAOsxEIIviKMV82Jb/9rPTJN6Gkz+dKg7/CrT1jn0bCpLygj041Ir7KTbaPEp+72q5WSM99jssnj2z9M2sI84HSDjGtxTD7EjLWnxzOFkZw415OC5OpPY+u6lnQ1bvOqt2yVg37Wmc/Raedt5+aqzreXYfef6ZL06Cf7WTEGpMMc7DBiq1vYjbUhz5ltRN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDGAi7XZGYsNzuf5B7qihPiTDTHY0yH5qHd4OXjQ+QE=;
 b=pFxCqmMS1N+0iPXQoSmJSKg5aOqPwIjlc9IfdvHyVNVkSE+a7HecGcLDkD0UE0Y21u5Tp9363xutXjJbKWdgePzN/igoR+h7pdTorxFCmG4Ine9hZV6TtMQzOytSefj3ey3/Hz7OL/5p62GpKulk9vsFZncgYTX48BCJAcneYWOXXPdwOcymv27TXBK+/pO0+FjkltTcBgITvCxjt9YSSq1+FCIzFfj5DQRcM/y84e8CLjXrK1bLiDVz83BXh+lMEs7fZLAMTh4Wy+BqmgaZ5oaW2GMocbrHH6PHgvnJgUX5giSXCMMgTpY0yoizSP+1BNqV73WBIc05U7+uhFmZfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0121.apcprd02.prod.outlook.com (2603:1096:4:188::21)
 by SEYPR06MB6755.apcprd06.prod.outlook.com (2603:1096:101:165::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.28; Mon, 30 Jun
 2025 15:54:44 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:188:cafe::5a) by SG2PR02CA0121.outlook.office365.com
 (2603:1096:4:188::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Mon,
 30 Jun 2025 15:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 15:54:41 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id F0CBF44C3CB6;
	Mon, 30 Jun 2025 23:54:40 +0800 (CST)
Message-ID: <5e9ddbe4-c94c-4087-8b34-0407ea278888@cixtech.com>
Date: Mon, 30 Jun 2025 23:54:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/14] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-11-hans.zhang@cixtech.com>
 <20250630-graceful-horse-of-science-eecc53@krzk-bin>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250630-graceful-horse-of-science-eecc53@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|SEYPR06MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6264cf-f941-4044-fbdb-08ddb7ee6d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3hPenN2YzlVeGR6eSt6eU5JMjNsYUN4M3RaOFhTcVE0UENFZTF5Qm1EdFE5?=
 =?utf-8?B?OGtOeDJLaDJUU01uZ1FzNmpKY2hBNU1namRUSHpTOE9vMmV5VEU1eTBoWGl0?=
 =?utf-8?B?ZWhOTXJjMUUyL1NWd2lWTjBGditNdm9sdFlNT2dBdjBRR3YyZHR1N01pSVdu?=
 =?utf-8?B?RlhYS2N1SzFJai9iTUxlSDl4aHZuYUpDTnVJY012RXRUSytUdDNNYXcwYUlR?=
 =?utf-8?B?WHJhTlpoRU1VdmsydnRObnRMS2Y5UGNsMnZFR0VTVEM2b2xzckRkd2liQk1t?=
 =?utf-8?B?S3dsdDMwRUpVeGF4d3hiaXF5NnlEUCtVWitFVGZ0RCs4WG1kODRsZVE2eUEz?=
 =?utf-8?B?L2N4UnYrL25JdVVqRWVjTWV1R09ydEdNUHV1M2MzRXoyRDdLQU51UkRLcHJG?=
 =?utf-8?B?TExKSTFLS05qYkxNZGNkTERBcFdBSWhYZ1pvcUV6YW55ajVXUlRsWkVMenM1?=
 =?utf-8?B?UTZNdi9oQVp1cEdjY3pja1pzWm1qV0xzM3lJTC9pV2RhQ3lYdGF1MWNYb05M?=
 =?utf-8?B?TStWY2hTaStkVVV3MlhnSUpNOEJnZHlVSExHWDVFTzBGZDZmQ0d3bzRBMnY3?=
 =?utf-8?B?VVlQYzZHbkNTZ3RLZHZobGtWZWlSWWxJaERKak9relFwSDFUcWt5cThvZW8x?=
 =?utf-8?B?NGNkZlpFTmM1WWpUTFBiZm8rdWJGdnF0K2g1OFRSUGQ3OWJYWC8zRHRiK1RX?=
 =?utf-8?B?VWpHTmRCbmtVY0ZtQmRJK3pNalZsT3hnUjRoLzlPdmRBVkc4WnJtMGxQUHFI?=
 =?utf-8?B?emtTa1hKVXVEN2w4NzFGVW81VzNCS1h2YlFLc005bEZtbVp4akowWmY2SVBq?=
 =?utf-8?B?RktQQmFHdjMzNEMzRmJpai9xejJINXFDZ29nejZuTXNSUmtIUmtlTGpzdDJB?=
 =?utf-8?B?WlV4eHVVMXB6eDZvUytXaVd2RGk3NXB4elprdkdWYThQdEloRUVackh3Qmt4?=
 =?utf-8?B?QmR3SWtoNjN4UWhKdnNlY3VyM25vcCtudDFJdGJ0SERLV1g2aU1VRFZyWjVy?=
 =?utf-8?B?ckEvaTdGYlgzNW54N1dVRHRTaTBVSVE1aElKRDl2UEtvU29VOWsvbVBzeVNv?=
 =?utf-8?B?M3dJR0hld0wrNThDQzd0WWtCQnFqa3dXbGdhSEwvbUhoK2hwbUxrK3ZIUkdK?=
 =?utf-8?B?UDczL2N2bEQyQ0FqZDBjM0ZLSDh0MXp6NnU4ZFdxNW1yT0hzY2ZTanNNWCtF?=
 =?utf-8?B?M2laaCtTbHREdllxNGhzdVRhcFg3QUIxcGVmM2RBSUZiR0xKZmxOYlFmZGw5?=
 =?utf-8?B?ckNLaTFnenR6Wkx5ZXkyTk9FV25pTGFCTWt3UFdZVXdSQTBTeVArMkZhdFVj?=
 =?utf-8?B?VFdlSCtzQnoxTTRCYi90ejV6T25zTFJSaXFMYjV2azNmVFZQS0NGRUdXR3RU?=
 =?utf-8?B?TURZT3pJdVZWWHdRSkg5c3IwMUEvSm85S2pQMWEvSW9ZK3R6YjRTNExMUW1E?=
 =?utf-8?B?emFkWnhma2RkekJOamEzTVU3WGg0eDFja1ROcVlHc29HcWlPeHZWREJoOE53?=
 =?utf-8?B?UGdmUzBWQ3d3NHdpTWxTL3ZqZnZLS3VDOVl2WkdRb0ozdVY2Q3locnFyU2ZY?=
 =?utf-8?B?eXZ2bjZ5RHpXOStYL1lsNkJpYjJSb3FmNWk0OHY1UVJrcmtWMkFiTVU4YjBJ?=
 =?utf-8?B?MTNhT1dITGxTdVJqTXUySStMQUlFN3pZclg5Z3dLMW9GL1hpVjczQ3hRaHVP?=
 =?utf-8?B?Vm1lYS9hdVQ3azI0YUtzL3VtMDdrZTJiMHNaQko1Tm1mQ2tlcVFqc2VGVUhj?=
 =?utf-8?B?dGZVcWtPQ3pkQ09iOFhBTy83VkNRTkIzVEp5c2JZOWJqU01peHl0bGROQWhj?=
 =?utf-8?B?b3NCZkFmeTVNaThnZjh1VVR1S3g4cnZseS91OHRTUVBVR1NjaUFnVkk2azJG?=
 =?utf-8?B?UVAyV1BUdnZjY2Z6cFlOSk9JRHZBeXN3V1VkS2huUHdwbno4bmpYTW1PZkdD?=
 =?utf-8?B?U0FlVDVlS2Q2YlVPZXM4NDhDcTZzZmxpanF5VDcrUjY1YmRicHh1K2pwb3Fq?=
 =?utf-8?B?RGgyTWRBTVNVRlI4eWoyZ2J6SDkvckVMa3FLc3R2VHFnQm11MUM3OTRtbDI0?=
 =?utf-8?Q?TQH7q0?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:54:41.9543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6264cf-f941-4044-fbdb-08ddb7ee6d7b
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6755



On 2025/6/30 15:26, Krzysztof Kozlowski wrote:
>> +  sky1,pcie-ctrl-id:
>> +    description: |
>> +      Specifies the PCIe controller instance identifier (0-4).
> No, you don't get an instance ID. Drop the property and look how other
> bindings encoded it (not sure about the purpose and you did not explain
> it, so cannot advise).


Dear Krzysztof,

Sorry, I missed your reply to this in the previous email.

Because our Root Port driver needs to support 5 PCIe ports, and the 
register configuration and offset of each port are different, it is 
necessary to know which port it is currently. Perhaps I can use the 
following method and then delete this attribute.

aliases {
		......
		pcie_rc0 = &pcie_x8_rc;
		pcie_rc1 = &pcie_x4_rc;
		pcie_rc2 = &pcie_x2_rc;
		pcie_rc3 = &pcie_x1_0_rc;
		pcie_rc4 = &pcie_x1_1_rc;
		
id = of_alias_get_id(dev->of_node, "pcie_rc");

Best regards,
Hans

