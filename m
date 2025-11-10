Return-Path: <linux-pci+bounces-40692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5301EC4618B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 12:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3625C4E05AD
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAAF26B756;
	Mon, 10 Nov 2025 11:01:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023099.outbound.protection.outlook.com [40.107.44.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CC12EAB81;
	Mon, 10 Nov 2025 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772492; cv=fail; b=IV152XOY4JsGIcrZ5MDbx7F5ymhdquDSXCnVdQ/7iRnXLLKFswP3KllMDGqgIGCBvgSjJFT1B9aRsoCouwH0dYWiRtlYGqSHALMgUcU5O/fMmNYPGTB554i1iPudwTzkwyR0HzqW942ZpQfLEM2l64S3QbHv5/t8Ie9PX+G/Vio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772492; c=relaxed/simple;
	bh=qpqXPt19idA/dK4tY5vqpGTsn+CEv+A2zrZ73cYoFYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r0LKFM8IeS0mWvOebEY/26giYtiyK6UaWe2u7wtmjSwrVQe5DM5UXtdYAWw5RjuFd6MKYFpdqfsreGZjNmETNy6aC+mz47jbaNTTtBT3jvaQvR6VjNKHhWQKepCPEFEteVwlICs0W+QqrshCxSV1PaaE0pnu/cT5BoMEEywA6NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcYaJB8XnFuKuUUPrwng8rsZawZGB4KtGJnD1st014URuPyF+bfPCINPgaqvun2dzo8yfloUsovegs3mgzPyNt0wujFSRPkHa8bPFwe2SA1vQUbeHPtmSlOFKpLDVGfwD7DUPS1UQE8r1orMDfFVX4DVEqFL/dMS4g+dozznYWbos6ueAWmuuMId26BjZW0HgFVeZWMNuaHSQ/H6cNvGrwoei27jy3TmY37nhEnIcfVcpvIce4OjrtBgNOot5/X4X09z6NEbCEMEeUtFaVhW3gQImvA5hG6oKdm2Sqjd6aQG8RhtJlAJn+2XAcg54N+KiWWqMmK4LVqJzyFaJVhlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yw1ltW9RDEK28nEsc9RSTrlXC6AUcuvWPGRN56ibQ+g=;
 b=yvTaUWfkRA1p275AFRXQVKbCNtWsygXTjNAx3oT3MXsEoKmixtR/mdnjNr0Zh+SlYIUElXhe0p7wuPNLv9p3uhCCTaGac4DmgCyTDMPpAmqNQpCaZFRgub21evMjignnpG0fHxAfDLaTXOO4uVTu3QOXhVYWi42SV3bZzxJz//exjypRbikTxjG+31vnmmS/8kFvCMZwhu/omkaBi/LYu2Hu7u1atitPbXRKw0/PVxvXnufiSqSdwGz4vebHm6bb4XY1igbPc8b3lLVY8RSPf8p3OTpS5xrOEf1cU4nSfhgvjA4kaUVf8NeuDpSK8CxhUaEzRJlbf6OmqJ3iMFLupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=amd.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PUZP153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::13)
 by SG2PR06MB5108.apcprd06.prod.outlook.com (2603:1096:4:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Mon, 10 Nov
 2025 11:01:24 +0000
Received: from OSA0EPF000000CD.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::36) by PUZP153CA0015.outlook.office365.com
 (2603:1096:301:c2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.3 via Frontend Transport; Mon,
 10 Nov 2025 11:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CD.mail.protection.outlook.com (10.167.240.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 11:01:23 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 4B6C540A5BD4;
	Mon, 10 Nov 2025 19:01:22 +0800 (CST)
Message-ID: <cfd99dc6-24e3-4b4d-97cc-12505f03d2c3@cixtech.com>
Date: Mon, 10 Nov 2025 19:01:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: of: Drop error message on missing of_root node
To: Andrea della Porta <andrea.porta@suse.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, mbrugger@suse.com, guillaume.gardet@arm.com,
 tiwai@suse.com, Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>
References: <20251110105415.9584-1-andrea.porta@suse.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20251110105415.9584-1-andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CD:EE_|SG2PR06MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c057e8-e1aa-4918-feab-08de20487cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1ZTVUpaUENCai85VUpmcWZYcmNDT2w0eWsxeVFZb0RRL2lyZDN5MVhPUmlJ?=
 =?utf-8?B?aEJheURBbXJ5OFFqT2NLSGE3dHF6emxiWjl3TnRWazY1RzhtTlJSYkFkSDhh?=
 =?utf-8?B?NjJERlJoNWVQSHlReTlzWk9ZelNJejNseFdraHdPRjFEd1FIUUVDUithS3lO?=
 =?utf-8?B?Zm9udnJ0NXJ2Ylc5am5Qd3JWeXBoSVFrVmJlVTFZMmczdVZjdk4rU1ZFbkVJ?=
 =?utf-8?B?NjV4dnBOTmxmK2FMMzBJbnUxU0dBVmVuWnRuR2drS0lSWDA3Skl3QnJYdy9w?=
 =?utf-8?B?MmxmMDV5M3U5eUxOOERmVmFKdkx5aWJldjRRQ0c3TUd3ZWgzaEJyZ2tBdklE?=
 =?utf-8?B?WTVUMW9ZeXJLeGVxekQyWnlXelFETkROOW1CYzR6MzhPMHdLTXc2QXUzb3hZ?=
 =?utf-8?B?c1J3bVhoc0RTeHp6S084MU0vcTlRZC9HMldpUlFLRVFjMEJNVjF0cW1uTEE5?=
 =?utf-8?B?RC9Ed2RmU2tBNGxUNFdCcStzOWdWQ1RwYk9wWnhtVmRleDErb0tQQmFmWUVN?=
 =?utf-8?B?d0d6bGNSRm9vdW8waDJ2SmRCM3Nza1lsRHZURUhOVjMxRHJTeE9GZ3dVZjN6?=
 =?utf-8?B?eDdTSUxVajVXdTZTWWtlV1plMm9FMkR0MVgxblhwRmFKYVdibEl3bERLRHRq?=
 =?utf-8?B?ZU01NmhVMFhZdzNOc0ZqdnFOYTJpZzErVTAvWDRGYTVuRUc3eGVmUGV1UFFC?=
 =?utf-8?B?OCtUKytlREpIOU5KOG5WbTdvdG40R2tNYnlEVGRPbWRZVTFtZVUvcGd0b1FU?=
 =?utf-8?B?VVhFZTM3Q3Nhc3I2WWozZUxzNTUzcjRyUUNXTEMvY2tVNE43ZEYyRFFLUTdK?=
 =?utf-8?B?ZnUwaVlqWHFVWWRjbmlQd0lBajA1TmRPRjZRNXowZkh0M3hkOElFcGFkTW9t?=
 =?utf-8?B?NWNGM1k4cDNsZjk3RDdtNEVvOTFEYjRLNTFjMXNrVG1QQ3QxSnB4d1Y2d3ZB?=
 =?utf-8?B?aEpJSjVNOHNRS2xVWStuK1orRE50UDZzejFNSXZJaG0rZG9vQjV6bVQxNFRm?=
 =?utf-8?B?MTZ0cklFNGZyVzdaSlBYS3YwVVRmU0loaDZrV254bllKL2o5eDJEODIwbHNC?=
 =?utf-8?B?QW8xVjRHS0xBSWtoWU5ycWtVMVZSVCtGREdXdTRuaUdFcFdHeVlTci9iRkhT?=
 =?utf-8?B?NUs5d292WHkrdk1zUHNkdTFTb3JYNzE4ZkpDaU1ZUlJqTFAvK29rTXBxSHUv?=
 =?utf-8?B?N21nT2VNYWVpT0hET3RwMW1yQlVIbGxuV3Zjc1RTTkFxM3JGVENZbWFDcnlC?=
 =?utf-8?B?djNtZ0lIZ0RxYnFKUFVlSFRRMWpHTHNIeVVicE5FLytEMG9pam96QTQ0QXZn?=
 =?utf-8?B?UGFRZytSMmJTNDdlL0tMeVBpYkhwR1VoeG5ZeWRPUy9vM3FSVjFONmN0WGZs?=
 =?utf-8?B?Q1Y1QXJETXIwZHRncDNwUVB4Q1VBdVZXZjdZSU1TajR3aS9xcHVibDZFVmpG?=
 =?utf-8?B?TVJySnYvQzNGQWhOMTVRQ1FXSC9pNHRyTEhNRGg0U0s5aXJxRXlIMnNsTVBr?=
 =?utf-8?B?QWxuU2lGT0Vld3JwMTJTVFZYWGVqVklvZTY0a1Yvbk8xVGFsR2dZR0pWdGVW?=
 =?utf-8?B?NnRlbTFwS2F4UnhDS2pIaUhPTUR5YUsxMlh6SzVGSjM5U3V6aUJBK3QzN0Va?=
 =?utf-8?B?d2w5dXZkY1F5V1lkTTRHM2RKVnN5QUF0cDFPWVJPZ3V3S1hFczdGUFNMZWhO?=
 =?utf-8?B?dmlMQjd0TjFzeWwrTysvOXpaSzZPYnJIUTBHRXZXUHh6a2IydXB6b0hzYk9B?=
 =?utf-8?B?czZxamdUR21hdzVrZTZxMWN1Z2Z1Zm1YL0xWY29PaFhpWDRMTWJwdHp0SGht?=
 =?utf-8?B?d1Y5UVVVUGsxZ2NZdFIyaHByeG44SmxBK0pZbm9QdUFGNjk0TnVYak0wTGwr?=
 =?utf-8?B?YTMvZUxuaGExOXlkL2tmVkwxeUpYbjF1OHJMcjlFenFGNHpSSWIzVGNoaEVs?=
 =?utf-8?B?ZHFOUHhlUW5sMlJGdW5LWTFkNVJrbVRSSVFpNytCK0FOZFJJbVJOWTRqdzQ5?=
 =?utf-8?B?SkFUY2lsODQ5UnphdHNtb1ZkNUdFY2Q3Q2RmYzNjN3pXZmJ2V0lJSE9jYTlL?=
 =?utf-8?B?YnFFV3ZMT3dWTHFNT0I5YS9CVWFCMm9CbTdya29GZ2g4NFhLY2Z4VDNCNUFR?=
 =?utf-8?Q?t4yI=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:01:23.7528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c057e8-e1aa-4918-feab-08de20487cff
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CD.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5108



On 11/10/2025 6:54 PM, Andrea della Porta wrote:
> EXTERNAL EMAIL
> 
> When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
> is generated if no 'of_root' node is defined.
> 
> On DT-based systems, this cannot happen as a root DT node is
> always present.
> On ACPI-based systems that declare an empty root DT node (e.g.
> x86 with CONFIG_OF_EARLY_FLATTREE=y), this also won't happen.
> On platforms where ACPI is mutually exclusive to DT (e.g. ARM)
> the error will be caught (and possibly shown) by drivers that
> rely on the root node.
> 
> Drop the error message altogether.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
> Changes in V3:
> - Dropped the error message
> - Changed the commit subject
> 
> V2: https://lore.kernel.org/all/955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com/
> ---
>   drivers/pci/of.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..71899b385f7c 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -775,7 +775,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
> 
>          /* Check if there is a DT root node to attach the created node */
>          if (!of_root) {
> -               pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
>                  return;
>          }
Hi,

Can {} also be deleted?

Best regards,
Hans

> 
> --
> 2.35.3
> 
> 


