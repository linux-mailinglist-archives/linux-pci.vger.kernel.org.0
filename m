Return-Path: <linux-pci+bounces-26778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CB5A9CEBC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FE99C1737
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591C31DEFDA;
	Fri, 25 Apr 2025 16:47:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021117.outbound.protection.outlook.com [52.101.129.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7F1DDA31;
	Fri, 25 Apr 2025 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599664; cv=fail; b=qjGpcV9hBSLTr+kZnN+nEJRLRO7ONYZOfpsSDtsSXfndG2VHW9P2/hlU1WhGkeAMXOafk7mrUbLlfL/POeNejfLrGx0CcXqe/QxWVnd5ygxo4D1DINUaegS2jBD3GWdcZi5S7Z99wdSSKtJmnFnbC/pXCqo8c6Y0rWjy45sQgHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599664; c=relaxed/simple;
	bh=MQN6u8xjaNd3vllZQxrA0NbNi0CLgkKP9SRlNJYJ9bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObPEdqYjSyEZ4ogEmnnmPdpepLaS8hk8PJPOKTVKc0j6r8WzgmQFFqRPQWEcZJr7Xjgq3O9u+VAA00vAo0btyGPqUSdskkuMxw2XMjqpo1/VnctMbruupSVLhelNYP+WjNpQRKnA+r+oNww333u6fiWZOIKaKxQANf5EhONy2dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQ+s+kAaRQnmOPxFeHhV+8pBWAuKlqW9qLlNHWjz3vnyryilbVyf7psNFG0d/PqtD7ml3X2tZH6q9ysCOejX/veHMyqOPpspO/a7ZJc2MTRk/tF5JmoeGHSSzBtit6oWOaRPWxp/vTuxU2xnnFg6iIHRZAZkl7ZGDV8LfwzQMuOE8V/QTLR7UBrLAdC2rCD3Cyf4I1UtD+eI7WWJmZUWwqHBqkcluVCKrqafYwZWbJ1dufT6sTuvPPsbfmNaAWdDIRutZK0rCTHNEcsnxtqMcl8D251zrouLJU/EvQLVJatZ0WccW1AisLemBnaSKQ2OXIdf5O25BEU66T/TVJ08Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSJCRRP6Pn6iWRiZvLOOXbaI7O4Cx9EoU1qStjwXR+4=;
 b=dxcdEhcP3CmF8ZCMV3nC0Q5Wyyqd2WenKkpQp+wHcGDgejahuYBmocUaonjLCdKlm9Ar1uLFRPYVpOVZGg4ikm9j45tNHumUVQAgSgOMXrFAatFm26fbGSYx80/kLhWKd6RdlyR6sep9J0KgsWUlLWl5Rb9n+pnHNXkTgmgeQS8EeGw4qei5psazjudQZ6ble9yG1A7rQZcQU+Yq4AoLYGe77m7EqUUkWrGhzyPnsI/c7riiiUP/ksN0haTdtPtEaOMHXCwhR/puGj2rqvbCr/Mbh3TrsZoLhfQako8t9P2es2FbbcGd3OJyQKvI4zJbZZz15ktqrCVOdHUzGEhOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0338.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:38e::17)
 by JH0PR06MB6851.apcprd06.prod.outlook.com (2603:1096:990:42::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Fri, 25 Apr
 2025 16:47:34 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:400:38e:cafe::e) by TYCP286CA0338.outlook.office365.com
 (2603:1096:400:38e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Fri,
 25 Apr 2025 16:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 16:47:32 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id F202F41604EB;
	Sat, 26 Apr 2025 00:47:31 +0800 (CST)
Message-ID: <20d64403-d778-4601-80a4-b782225f70ff@cixtech.com>
Date: Sat, 26 Apr 2025 00:47:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] dt-bindings: pci: cadence: Extend compatible for
 new EP configurations
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>,
 Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "peter.chen@cixtech.com" <peter.chen@cixtech.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
 <20250424010445.2260090-3-hans.zhang@cixtech.com>
 <20250424-elm-magma-b791798477ab@spud>
 <20250424-proposal-decrease-ba384a37efa6@spud>
 <CH2PPF4D26F8E1CB9CA518EE12AFDA8B047A2842@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250425-drained-flyover-4275720a1f5a@spud>
 <5334e87c-edf3-4dd9-a6d5-265cd279dbdc@cixtech.com>
 <b25406dc-affd-48f2-bccb-48ee01bdfcf1@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <b25406dc-affd-48f2-bccb-48ee01bdfcf1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|JH0PR06MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cb3ba4-cb55-43a1-155e-08dd8418e034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTFuNWRrcFpJdW5hY29jMm1QN0d3REJQZFZSdkJ0YmdGZTQ3RFZqV1gySHF2?=
 =?utf-8?B?RHBqVmxGVXhNVnBibVMyMUMzYi9jSTF2aFJCSHNWRHZHV0t6cHVuSEs1cVd0?=
 =?utf-8?B?eVZTRy9CZ3VmSXppeGZ3cHJWOEhBYlVJUElad3ljV3VXNFRhMmg0S0lueDZo?=
 =?utf-8?B?RTBqcmVhL0VFbTg4aGhrWXhXSk5SM1ZCT2pNTHZsREFNQitmY3FoRnUzWmZC?=
 =?utf-8?B?alFCWjhEckJWaG8yUmtkNDlyaHRMT1A4NEovaHZRblZmeURMckplRzJFSlRB?=
 =?utf-8?B?cVlxQjRQQksvRVZEdk43U1BqcGRGdUhEWkM1dW1hQWdvRDdZQms0Ui9OZFh5?=
 =?utf-8?B?K2NkS2REM2VOOXhtMkhtYUZTYm9uQlRVblZscFdsRGhURld5WGlJWUJlODFq?=
 =?utf-8?B?OUJ2b3lRUWlEQ0lnQzB5R1JnbXc2aWpISUc1NEY4allveHc0T1krdzF6bzVB?=
 =?utf-8?B?U2lTRDlBUzdLYXF0czRseDBicm9NM3BEL05tRmJwblR5ZExhbUt0clFCRG4r?=
 =?utf-8?B?QnlKLzhWZVlZelEzWGJwa2xqd3ViaGFpSmNhR0tIZmcxU05HMzRKNEgyVURk?=
 =?utf-8?B?a3k1aWFoNCtMWTJzWGtQRUo2WURlVWsxWEIwVXlFYy9rZzlKckFjb2lCSnhE?=
 =?utf-8?B?eDhxZnhOL2dOTXI0TjBnSWhKZzFGSjVNQWt3bUdtbHdCTGVGS2dFYTg0Vi94?=
 =?utf-8?B?ZFFNcWVwNUZQcjc1aDFTeXVDVVJpV3VnLzZTUDBCVGpRSW9zRUMweUY1THZV?=
 =?utf-8?B?UG9WeVVTZ0NqUFgreFAyUjFRaGtpL1RSZ0V3UXJRN0VNcWZTMWM3ZklZRFZo?=
 =?utf-8?B?WEkxMGxjZEgzQythQzVPbXUzR3VnSFlqNFBSd21LdmQ0M3VuZ0RETmc0OHVh?=
 =?utf-8?B?bytsMzNpRzR6OUZUWUhBa2dJVDZ4eEM0aGhEd1llTmErcy9JS215aytKU3lk?=
 =?utf-8?B?ckxLSXBKRWw3bEpRTmE1MHhWeTVoSTVlUFZ6UytIS2FLNkFMbFF6a0xqVG5n?=
 =?utf-8?B?MXA5cDF2UDBQNzBXTktDS2Y5aTZKTk9DK2dDK1FlWGJIVUxUcnBYVG1ZL2dL?=
 =?utf-8?B?dVRzS2hXbU1iQnFFY2dYK0RhbUMvNXVaNTJseFMzRDRydnRwb1l5dFowWUt1?=
 =?utf-8?B?dWFTVC93VGRZL2dIbUYrVU1NQ1ZTVkJnMDJKSkwvWjkvbUtTbW1CTmlBL251?=
 =?utf-8?B?UFJJL0xHU0wzeldIQ05ZWDR5NnI2bjZhQjB6RXlwblEwazF5KzJhMGVMd2xk?=
 =?utf-8?B?VmVoQVExS0FnYngyNHNrVDQxZzFsT2dRSWdGd2svcHdkMEE0dmVsOXRvNEI3?=
 =?utf-8?B?UkZQMkRHSXpXdTFTMUx2eUthaG1MWERIRjExTFREVmUrRHJhNUw2VzJJT3E2?=
 =?utf-8?B?S2xydjFiTjNzWElnNCtqOWVqSjdqVjFBRGJzNE9DVEJPZ3ZtQVdxN2pkU29t?=
 =?utf-8?B?UmZLdzY5SUdOTEg5NGhsNDBOZ20vN1NCVjZVSm9aU29EL0l6S3Q3bmYrWSt0?=
 =?utf-8?B?b1VKZnFmZlVtOEtydnR3b0ljaFFRbzFIUFJQV3hod0hJOXpDeThUV3JrL2ZK?=
 =?utf-8?B?K2NvcE1lUVAxb1RyNko2YzcxSWhmQkY0dnRvUG15bUFDbFpUaE9SRE5Yc3RF?=
 =?utf-8?B?OEI5c2RucTYxTFRNYmt1QnJrQ296NEErVVRJWmV2Q2lEOWdnZ0FBYnJ1MVlh?=
 =?utf-8?B?REhtWmhaR1A5OC9SaklEZGdnRDNhZzc2WnBISXJmbzdSb0FpQThIVzRUR0Vv?=
 =?utf-8?B?NWNMeDJabERtajYzNWZwOU84L01QMU53and2Zm05TFVybjRROGpoTXZNOFF5?=
 =?utf-8?B?TG1ocjJSbmRqeGNpdzJzMStDZWpuUERiVVdXdXR3MHZYV2FicWtmTm15TDIw?=
 =?utf-8?B?N1QvTStHY1dnbHZKOGdGaE5MbGNQc1lyMVhRUkU4cVp2QkhIMGVPZG1WQjNG?=
 =?utf-8?B?bWtSYSttOEIrdjdYMjRoVEVRclcrSUZmZkkvL1d1TXQxZ2VFa05mcWkwR3k4?=
 =?utf-8?B?aHBWUS92RHZXdjl6b2tPNTVRbk9aMEtRcjlubmlDOWc2RWlyakxTbFQ3ZDJI?=
 =?utf-8?Q?ZacmoJ?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:47:32.9568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cb3ba4-cb55-43a1-155e-08dd8418e034
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6851



On 2025/4/26 00:21, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 25/04/2025 17:33, Hans Zhang wrote:
>>
>>
>> On 2025/4/25 22:48, Conor Dooley wrote:
>>> On Fri, Apr 25, 2025 at 02:19:11AM +0000, Manikandan Karunakaran Pillai wrote:
>>>>>
>>>>> On Thu, Apr 24, 2025 at 04:29:35PM +0100, Conor Dooley wrote:
>>>>>> On Thu, Apr 24, 2025 at 09:04:41AM +0800,hans.zhang@cixtech.com  wrote:
>>>>>>> From: Manikandan K Pillai<mpillai@cadence.com>
>>>>>>>
>>>>>>> Document the compatible property for HPA (High Performance
>>>>> Architecture)
>>>>>>> PCIe controller EP configuration.
>>>>>> Please explain what makes the new architecture sufficiently different
>>>>>> from the existing one such that a fallback compatible does not work.
>>>>>>
>>>>>> Same applies to the other binding patch.
>>>>> Additionally, since this IP is likely in use on your sky1 SoC, why is a
>>>>> soc-specific compatible for your integration not needed?
>>>>>
>>>> The sky1 SoC support patches will be developed and submitted by the Sky1
>>>> team separately.
>>> Why? Cixtech sent this patchset, they should send it with their user.
>>
>> Hi Conor,
>>
>> Please look at the communication history of this website.
>>
>> https://patchwork.kernel.org/project/linux-pci/patch/CH2PPF4D26F8E1C1CBD2A866C59AA55CD7AA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com/
> 
> And in that thread I asked for Soc specific compatible. More than once.
> Conor asks again.
> 
> I don't understand your answers at all.

Dear Krzysztof,

I'm very sorry. Due to the environmental issue of Manikandan sending 
patches, I just want to express that I'm forwarding the patches for 
Manikandan. Some parts were developed together by us and verified by me.

Please also ask Manikandan to reply to Conor and Krzysztof's questions.

Best regards,
Hans

