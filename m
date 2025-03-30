Return-Path: <linux-pci+bounces-24987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63429A75A74
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 16:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92C73A8767
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 14:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30021C84CF;
	Sun, 30 Mar 2025 14:59:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2102.outbound.protection.outlook.com [40.107.215.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E112F24;
	Sun, 30 Mar 2025 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743346755; cv=fail; b=Uxh6mmxflTbAFMu4nop8ukFEnKMJJO9maw0ZEXppkzv9eB1oFCx1B7KjBwBdcx5XBmMuJIWfEitJfckyh0dKTj/+2y9b/r/BwQ2PAvXJ76znFeW+jl2pjN0OmXGRPD4BPfJmqoTBfhh06beDOR2vFH2PVxVbio6KweYMaEOA/VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743346755; c=relaxed/simple;
	bh=I3VjKemB99z5QUM/clf6oefbBT7s7HHpMC/0BkejNag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVlESJZAmhDfkeNHAUy/XnqBYQxOLAsqHlNBMpTPtJ6BP/ZLOISjl4VUbXu6kCY25dPUrZnfbPiuWCo1FWJQUTs3Gv0Qd7wNi/fbew+BZqHE5o0z2RG88rt2TsGBRstYoyjro2GxEW7MCR3C+5MHKv5qT3mMlMKw/V3CR0zEh1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlnS5HJCwGiA0i1ovIABrOh0sLLwGbm+3kFW2t36RgjMlffI3wKDMVdl7AQH87wagQ9dpsgjpk49DWXbWLjcAOE3eleOnnAD2gq3SSpn43M1kCkSPqdTm1eO3UfGV0MKXU91emROIieY5EYY6rHARJNCtBpQnC6qh40/B8EHIPO4diYXSNgexOBr7TLRXbtqyGUEKjSjnBjmntMzk2v6v46VXdo6CoX/djsbOe8acYrqSYcLajszZq5YIq99tBMHCSh144LQ6W3Tm3M2eNswVObtNvA7yociyQBNIaEueZcP2//b4VK0YOUvgmAQWpDoRUEXbZDHxshnXABHs9O5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ctOs2s0WltIKZOlDEGhpQJ/HCrfG4dYgn6kaWHaBqA=;
 b=HDHNB+BTvO8yYJuPxn0j7groUyxAmj8Uc2dxCjF86FtFC1UKmDQRSVESO2z5NDZjEESikylqrmh9XIi6mLCkobhtp0n3uYvrZDRYeWhrNGc7LErm7LCWiwv9qJD+kkAQitz2rIWBb7R72DSzjTx9pD+vLVEmAK1fyVaRI573thw2WGXb4FMc0bY5bJoMC0HAuhJizxnFX5yjFuxAVIusov66u5X82EukPbB/ZJDXFbWLnHjfnUEIpGxetIdCPHN8tU+WSlxj+R/gyNHcrdv3mPEr9snWhZu6Cd/arf6mgY2gtYpJutBnK7NK7Wp+mrYgJUsYEYuwJPy1RYB0KqJ8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) by SG2PR06MB5156.apcprd06.prod.outlook.com
 (2603:1096:4:1cf::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Sun, 30 Mar
 2025 14:59:07 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:193:cafe::bf) by SI2PR01CA0043.outlook.office365.com
 (2603:1096:4:193::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Sun,
 30 Mar 2025 14:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 30 Mar 2025 14:59:05 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B75A440A5A01;
	Sun, 30 Mar 2025 22:59:04 +0800 (CST)
Message-ID: <749c663e-5c6b-432f-b716-263361fbad8f@cixtech.com>
Date: Sun, 30 Mar 2025 22:59:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: pci: cadence: Extend compatible for new
 platform configurations
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250327111106.2947888-1-mpillai@cadence.com>
 <CH2PPF4D26F8E1C1CBD2A866C59AA55CD7AA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250328-poised-dolphin-of-sympathy-e1d83e@krzk-bin>
 <4bcc07b1-00ce-4ff9-bf23-e06b78950026@cixtech.com>
 <d275cfe1-db7e-47d6-9ec6-b36f13524d65@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <d275cfe1-db7e-47d6-9ec6-b36f13524d65@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SG2PR06MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 38cace19-2db5-4450-3bd0-08dd6f9b6ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEFtOVlmaTI2VlZ5U3Y5clliRml6UmFEemIyMVpPaWhTc1FzcW14dlY5bE1N?=
 =?utf-8?B?VmFjRVVHVDBxcnhNSCtnZjdqc1NuWjFzNHpxbUpBMWg3bUdseDlHR2hTMGxj?=
 =?utf-8?B?K1JRa2dMYkFjU2tGNmM1TlUydk8vbjVyRDVCQmc1MzJiVXhWSFNJL1Z6OW1v?=
 =?utf-8?B?dDFYeTAyalgzdjZ0eTJNbjJJUklCQ2NRRDlPNVFtUEFKcE9seFA1emNCMXNn?=
 =?utf-8?B?ZUhjSHp0YS8vR2JlVVhrdTduZE5BcGdiTGJzYzlqdEthall2WExUTDQzakNi?=
 =?utf-8?B?Vm1pWSsrTUxjQmNWU3ZCUVBiU3VEOXhkWmgrbFYrUXgyQnFranI3TEMzUlAr?=
 =?utf-8?B?bXdiT2RNakNDK00wNEpDMXV0blZtM0JNeTdYK0RPcWNPTFU4SGhMclRUNnZ5?=
 =?utf-8?B?U2hhRUZUOEpWRTZwZ2ZVaExZYk1SS3dsZFZVYy9xNWFaOFd6cUQ3U1JYUXlp?=
 =?utf-8?B?UXFFYTlucmxnWHlKTXpVbzZ5bGdERi9JeWMzN2w2NEd2Q0FtajV1ZkQrRFRu?=
 =?utf-8?B?VjhBa3MzbTZYMFdGVjlvc2ZNdndYb2xwcGxnWmdRaWdLL0Y4azBuK3hwTDlN?=
 =?utf-8?B?WHVTYTNma095am1jb2k0bHJzNlRsbEw1Y1Z1RnpEdDR5cmR6c3h6b2pUbVZ5?=
 =?utf-8?B?d3dXdnZjK2l5b1pKdjhCaU9EbVVNdlZUM0diNGFXWXE3YllORkQ4Wnh2UnUz?=
 =?utf-8?B?T2Z6SHJUdnBscmdwZGVuZGR1Mnhpc3lRZi9Yc0svVEI1OWsvRFJRRUVWRXpY?=
 =?utf-8?B?MEFpY2ZBWHJvdkc1dStmbmZ2YkZIdC93Ulg4QnFEaGFJLzZPS2N2Q2xNdjJE?=
 =?utf-8?B?MGtoYUJPYjUxcTY4UWo0cElydEswc0xpYW1wYWZuSnR6cCtpU0NJZkYzSDkr?=
 =?utf-8?B?MHJsTENqd2l1ZHh6RXBFNjJZd1FleWR3NHVibGJIQmJsaVQxeUZ3VXc1UjlZ?=
 =?utf-8?B?allJckhjMXFZK0ZKRmtQTkNEcUhGWDIwTUd5OWcxZiszY09TbTJPY3FZMy9O?=
 =?utf-8?B?QnVkeFZ2cWNNbng5WkVEem1hOUYySWl5Qjh0QnRjL2UvMmVHS2dGV2ZKTTJi?=
 =?utf-8?B?b2NIRFVUWkIyK0huSVdEQUNhMGVLODljSVpDdHY0alZ2bVk1czBVWncxSk84?=
 =?utf-8?B?T1NSVDF0VEx6N0NqOEJSSUYxNXlCcG1NVUJkRitsODN3L3poTC9QcEJCanV5?=
 =?utf-8?B?elNTTW85UzV2QmNraFBncGpVWjZsZXhJb1MzSDRkdzd3djNEMTd2VGt5MVhQ?=
 =?utf-8?B?cWt5UGJ0bG5laGJCdFVPNGRxbUNTNVNadHNHUXhVMER6NkVCK3l1dTVSWHk3?=
 =?utf-8?B?SUhzL3lQYTJXc0Z1bHhscHVkTHBtT1BrTGxxSmhVSnhaUWNJQllQNTYvcDVy?=
 =?utf-8?B?VnVST0ZsdzQ3L2oyNzRDT3VaMDBDTjE0cUFjSXZsRGlLSGtsWGN5cXhWUGpt?=
 =?utf-8?B?bUlkcGlISGlZcncrWE01MlhYL3JKbWh1Q2pXdTUvQ1BtNWUyazlUcUx1L1R5?=
 =?utf-8?B?SWZmRTBvUmtJeEpUdTVzYkx2T1VnaHMreHJyaFlyUllWekhRcmxQdHlqOTN4?=
 =?utf-8?B?NnUwN3RlTTRIWE1NV1B0UUo3c2RBRUgxald5TTZDVjdlVDVSNkRlTlBFU1V0?=
 =?utf-8?B?ZllFaGpQRTdkdTgxQjBzYmVadVZSQ01CRzJxQkZNVlJmYXVVWkJZaFRNVm9j?=
 =?utf-8?B?dWZsVmdSUjJkcFFaQ1AvUC9ZU3FuMjZKa3pqU0E1aVR6ZjArWFNpYkUxekJJ?=
 =?utf-8?B?OHNaY0ZyZFpCUTJuYUNBMTJGZ0Z2RkllK3I3MlRJTFFUdGFYN3cvdEQzNUZ4?=
 =?utf-8?B?VlMxRVF4TUV1T1M3L0ZPQkZpRFFkSmRKV09xVGZuZVFJdEdRb1NWYTRqdWxQ?=
 =?utf-8?B?TmlMYlkvR0JEUmJ2NUZIb2UrZHVGZFVWL1JWMnBmaWEzY00wMmlEdjUzVS9s?=
 =?utf-8?B?THAzZTI0eFdOakJ1WFJLaTZVNEFTaTEvY0JzRVFhc09BazRxdHl1RU4yelFz?=
 =?utf-8?Q?xl08ZSAkJ3Ghmpj/jPWrq574gah94Q=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2025 14:59:05.7512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cace19-2db5-4450-3bd0-08dd6f9b6ad4
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5156



On 2025/3/28 17:17, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 28/03/2025 09:48, Hans Zhang wrote:
>>
>>
>> On 2025/3/28 16:22, Krzysztof Kozlowski wrote:
>>> EXTERNAL EMAIL
>>>
>>> On Thu, Mar 27, 2025 at 11:19:47AM +0000, Manikandan Karunakaran Pillai wrote:
>>>> Document the compatible property for the newly added values for PCIe EP and
>>>> RP configurations. Fix the compilation issues that came up for the existing
>>>> Cadence bindings
>>>>
>>>> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
>>>> ---
>>>>    .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  12 +-
>>>>    .../bindings/pci/cdns,cdns-pcie-host.yaml     | 119 +++++++++++++++---
>>>>    2 files changed, 110 insertions(+), 21 deletions(-)
>>>
>>> One more thing: SoB mismatch. Maybe got corrupted by Microsoft (it is
>>> known), so you really need to fix your mailing setup or use b4 relay.
>>>
>>
>> Hi Krzysztof,
>>
>> I have obtained Manikandan's consent and we will collaborate to submit
> 
> It does not matter. You still need proper SoB / DCO chain. Please follow
> submitting patches.
> 

Hi Krzysztof,

Thank you very much for reminding me. I will pay attention to it.

Thanks
Hans


