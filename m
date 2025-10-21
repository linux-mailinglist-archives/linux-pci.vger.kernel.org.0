Return-Path: <linux-pci+bounces-38865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA17BF5664
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 11:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDADB18C6F81
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 09:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282121F0E26;
	Tue, 21 Oct 2025 09:03:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022125.outbound.protection.outlook.com [52.101.126.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4093B28C037
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037390; cv=fail; b=RmPxgcVRbmVXeC8rV8jwQzeo7wrhMdyzH5vHY5KbQOl6dMKDsKvea4k3FWqiJcoykVUNX36XwYuEPWzI+qdW2AuK+NYffinQ8NGiOVN2PwFE2baLCsz0f1ncLOvlT69np/8DF/vNvDm84+gn4Yp9anIz1nY57X+b043n8E30W4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037390; c=relaxed/simple;
	bh=36donwJOThBqKz0OosPV/5PF3fNXz6FISpwWgX5j6jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H33ItKZrv2p7m8lGKBKdz9xYMUp0p7CZCVzWvXFJnXylbgb+uDgIKR7ixg1NnFg4d4SOdRsYxR1RT9vxn29KAcdMuSAdTLnfj2Bh0DFQslOd7B7Vcm3Rrd09OGeCij66nnNxGuSLi/kdHot8MdVVD8xtwxj0mhiIvxfoZC95bLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqIq9sZLobpZeCDBfKKx0chHZXFm9+w0vincBWNMjMI3Xx2X9UNcbn8lJ4wpQwikyr/kEOahJOFqRJJ8Fb1zeQFEloWOu/OAzk9FWegE+GQs3yaPpUuuIHzWkJwK508HX617568YxMt9jRYIX6n2K6Kfj1nu7AsrcRmWER2e/M79AUuhdgmmGx9Ur7odN1z7awj40pSqUiAiqSQdAZR0FWJc4CQ3H776yfCeXQMoLu0e0GYkyQJ87h3RAen79KVIpO0Q1Qn8NBNtEsV8uqhAUpoPlTDuRbqxVwsFxT5619dTve+5gwvbqDUpA0YDa/5u4mJZZC9a3RqGeBMdCW7tDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW6UvI9Xj8I4cu2Fi5BI1RpY7Hg7Tdvanlq1SALBi2M=;
 b=CrAfJUVH1gHfOYL048s4WwAAKjDFnHO7pCCPRfDJAdyUZFr8xrmKnil88/wgBdDz02IjgmOW9pxLs6mClKE8SX4turiP/C5adVM8vp6TzS3VzXRwdIdZDl+aUWDRqNJJVbajJMGcekP6elkx6aMyzF4dt3wVo/IidoulG5v0hAFftzSYT5aiOD4LFrRR/DMrnpG1q9HJO8NXI7IgMS0eDykYhBXnzMCKxI+9bkpwWMWYtWfYDzv94PMYRJEEdRJ8R0IsKUOW1udZoNmNW2LrV1llvIf9tGaAvBtkEfgqiW6NKqUMMgi+EKaiSFp4VI/85OrBNFMpo8+B0z11xWPKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0044.apcprd02.prod.outlook.com (2603:1096:4:196::17)
 by SEYPR06MB6661.apcprd06.prod.outlook.com (2603:1096:101:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 09:03:03 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:196:cafe::66) by SI2PR02CA0044.outlook.office365.com
 (2603:1096:4:196::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Tue,
 21 Oct 2025 09:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 09:03:01 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 312C641604E0;
	Tue, 21 Oct 2025 17:03:01 +0800 (CST)
Message-ID: <ea1f6a6d-14d5-4655-9eed-110c02c8f487@cixtech.com>
Date: Tue, 21 Oct 2025 17:03:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] PCI: dw-rockchip: Add L1sub support
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>,
 linux-pci@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
 <1761032907-154829-4-git-send-email-shawn.lin@rock-chips.com>
 <3f90b0f9-06bb-44d3-97a3-a13ced9b1c3a@cixtech.com>
 <162e1af2-7de3-4aed-93d1-fa7120254e69@rock-chips.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <162e1af2-7de3-4aed-93d1-fa7120254e69@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|SEYPR06MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b80ccc-ea8a-4e15-3a2d-08de1080a396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y09SeFRTbThSclpoNHNUcXdodlZYNGI2QkF0b2NIaUdNYlZLSHRwbmhyYXpj?=
 =?utf-8?B?WXZXMEVsbE1YL0xHZStOdWc4ZGFUaEtlNDMyZXRUdVEzS1FxNGtRWUFTbXZy?=
 =?utf-8?B?eHFkV3daWHpvN0IyT05mVDMyMS9pK3h1ZVZQYXdhUml6RlJCR2hya2lRSGdw?=
 =?utf-8?B?c2NNalRnVmprOEw2OWdQa0tSeDh3VzROek40YjF2UzBrNDZOd3QwekxNSkt2?=
 =?utf-8?B?YkpqTTRvb21ZZ3JmOUtJQVJ0dDZuK1E2UlZSdEViWGZ1YnlHZFZJaDVnV3NT?=
 =?utf-8?B?a2JxQXpTOUR6Z3ZuTzY3YXF5U3ZUeWp0Z2dFeFJCQWp2TXRramgwR3hUSk5r?=
 =?utf-8?B?NW5oM1YvQVBBeGdjWWI2QUltZ1pOTXFXb1Mzd24yQjJ4QVFEOElYdkJxOGFE?=
 =?utf-8?B?U0ZGTHp1NWowZ0hXLzUrdnRRcU1LSkd2YzRQWGhoOE0wNkRsN2xjVUlaeTR5?=
 =?utf-8?B?TTJnT25Ja1pPb1psVCtPTlBZblh4aVBxeDZiRWwrTGd5K0tHckIvYXVyTmI2?=
 =?utf-8?B?enc4eUlXNEJLUHFsNFFpVUdYTE5UakZ6RjF6Y2l5dVpaMlgyN2VSakxxSys0?=
 =?utf-8?B?ZC9LVW5YY2RrR1pqNG4yYVdoOFZlWUJDVXJPMnZKUzlEZWVlM3VsdDZvM2s3?=
 =?utf-8?B?MzNtMHpsL01XVVdYUit4eHRrdlZnTUgzRUQ4SHhkWFFXT2trbi9tN0RDUmtz?=
 =?utf-8?B?bENERE9PNjFOd24zS2xQOHgyTkZaSmVOaVdKRGxHMmdFZWgzRU9BMWZRcUI0?=
 =?utf-8?B?ZHZuSXZhUDVLTTBvUVBscFlLT3NPUDlZcE5wTTNhcUtqMndGSGo1OGxtQ3Zq?=
 =?utf-8?B?UzRZMGlWejFiRjVRMlIvUGEwQW05NmJObm1BNGcxS2VUelBIUzlkejI1M2Rx?=
 =?utf-8?B?b25TcXpkVFJEUk03L2FVbHQzZVhaSktaT2dIRXhuQlNWNVM5ck9rYVBpenpu?=
 =?utf-8?B?SVl6cEVPcjVybER0M0RXKzNGVkh6NXRQQ1pDVUEvcks4VHBiK1dvSEQ4OFdD?=
 =?utf-8?B?OHcvRmFpcFNya3h2czlDalFzMG45V1ovZ3V6QUhTdGhScWxOOHEwalZhMFFa?=
 =?utf-8?B?QkkwZUd3ZG93Q2dPeHJwbTl6RTJqRXliSWd0WmNNMWw5ZWxlUG5pRHhJVVpJ?=
 =?utf-8?B?RE5FZGVLa1BURkNnRTJteENmTUFDWlhzUmJNdEJTeGtBWWNDdkxJM3FwWnNu?=
 =?utf-8?B?ZCtITUtFY2xHUHBlOVdiV0d5YVY2NjNpbVZaTlBSSzQzcG5ybUZSbEp1dGVB?=
 =?utf-8?B?QWxOUEZ1K0tuQ1pxS2dFck1uQjFxRlVadEpTU3JkSksxazJUU3M3WWkwQk1z?=
 =?utf-8?B?OW5RZFNreVRFTUpWWGlPT0pSUjB4MVYzZ2RuK2drMlh2ak5ZLzVVSTRMSjRy?=
 =?utf-8?B?WG9zcEJrN25KaXRVQ2RBLzM1SzNVSURNdHRQbnpTNzcrOWJyZEY1aXF6aUIz?=
 =?utf-8?B?WU90Y3VrS1Z4Q01LaXVQVUtHSzF1M1JGQXBvYTkxRWswNFpxckI3eFVyM0hl?=
 =?utf-8?B?T082eGJ3TnZMRjYvR3dYUC82cjNvZXdvUVA5a1Q4RU1nTUF0MkxEY3c3OTMz?=
 =?utf-8?B?cldJQ0ZiL20rK1Uyb1JROWRWRWlUQXV3K1h5RnAwaS9RWmFEa3d0ZThEODNm?=
 =?utf-8?B?eTFtcmhCTTFacGJ0Mko5M0dBZnhrN0FLdlRsWVNrQURMMnNMcnFIV0UvV3Uy?=
 =?utf-8?B?ZUxqNU5rMkNMOGpuWVpJNEl1WXBSOUpncUwyM21iRUZtQzBDcWJYL1cwVlBw?=
 =?utf-8?B?Y3Joa09hSFZwQ2NCd3lLbU10MllsZW1rOW1ES29RaGhvc3J6U25WSFh4QzV0?=
 =?utf-8?B?Uko3STZBSEVWQSt5OFdIRnBqcnJjRUZEY2dQVE5Gc3Y1YWJ1ZHhhaDBBT3Nv?=
 =?utf-8?B?UW1wY0E5M3g2QloyREVpczJmZUs4V3E1RTdHaHV3RVVLMXhaSGNRbzN4NFJ5?=
 =?utf-8?B?eitUS0VWYy8rNkxaZVAzWmtFMjdWNGREbSt3RUhNSTRDLzBVUkhKM1Bra1hH?=
 =?utf-8?B?bkV0cVpUVnROelZ5Y1UwL2ppVlZXQXprYjlXZjNKekp0cE9RejFTV0h1Qjdj?=
 =?utf-8?B?QitOcXRWd2RWOFZ5UVc4TVhRbjdUT1ZZR253VWlSbkJZTzI5OWp2ckxTMlA2?=
 =?utf-8?Q?0kAo=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 09:03:01.7963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b80ccc-ea8a-4e15-3a2d-08de1080a396
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6661



On 10/21/2025 4:42 PM, Shawn Lin wrote:
>>>
>>> -/*
>>> - * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for
>>> the steps
>>> - * needed to support L1 substates. Currently, not a single rockchip
>>> platform
>>> - * performs these steps, so disable L1 substates until there is
>>> proper support.
>>> - */
>>> -static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
>>
>> Hi,
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?
>> h=controller/dw-rockchip&id=40331c63e7901a2cc75ce6b5d24d50601efb833d
>>
>> Mani has already placed this part in the above branch. Can it be removed?
>>
> 
> I think it's better to apply the changes on top of Niklas's commit
> rather than removing it, out of respect for Niklas's credit.


Hi Shawn,

Sorry, maybe I'm just looking at this issue from the perspective of 
patch and understand what you mean.

Best regards,
Hans


