Return-Path: <linux-pci+bounces-37573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023E8BB8076
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B1E19E4140
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771FC227EA4;
	Fri,  3 Oct 2025 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zXSwVYUH"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A141F3FE2;
	Fri,  3 Oct 2025 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522282; cv=fail; b=n4IIFOcMYRmSRrjzIlHWukyWNqqjFA+NYMNki5k7TlIYxIQaMD2hOMao2FJi1oyGZ2dTg/b3YtOJBaz/v2GmVO8izL/kkkUeu132gw/SCikLjK1RiX/3pSHmi+m9HaR/a3MUehQTn+W3NrBVzyEUUyJsAJzBS/yfMsZ3++Jji+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522282; c=relaxed/simple;
	bh=X8Xbeaa6BnNwRpfnIa0pB/dIUo5nn8pAiVvKKtLZWJs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=lY+JNWJgA6ObGe+uwDp6Yc6vrG+B/tPolMh3O1oSt9TYIiB4JBJuagul58h2YC/rMQKc1eLOPKopNJSDvqa8QpU8IE3bh//I08C8grj9gqHtJbmAiwDU246IsuST8Z+Qc1r6Jbnbd3wMM498aLSqOvzJPFVLDG8l0N3XjO63N1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zXSwVYUH; arc=fail smtp.client-ip=40.93.195.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wpds3vVavSvNmwnu3xZP1kXeSAhx3nu1lr4uIV70L+QwEJJHPPhhBvdXzUjAZ3LAfBkvsNqPh35eGewZ7+onZ406edLzRu0ELySCFdqcoiqZageIODm7CKOzotEtSFEzgXJm6pkhqRQnCiHP1ytPedGgDuYcwEgCoWjqKod94rkCUFBAyfzDefl/kGxhKZIEZ9/mQ7bcsoBiUjn44+RREz5dy7/HrOuvHM6wZgpfvl+a13sVdjp+5X+f35QzMrn6sH7qElO2v9Wf9SQgRI0Kxtt6+pZzS8teLcfeY7+e9Wzfc2rzHZVt2G1zGwt+Mjy1C0rVbPxrtmDoOQNG8dq/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/E6pieqpGeNBBbW5lec8Exn6jsoWimQ0WWNDBuUr4M=;
 b=GUc28lYsov7ct45h3tVzC6l9MGp694PNn5gymG4qQ3pT0lSltuMru1pYGMJP+fI7gqpQ9LRjVCl21OAZNRMB8ayczYoJymh5DVUchmiympxSLn9dgjmdNTadYVsNzxD2jc4goG5JWk/tnqx81WRNDyeMKjx3V71QPD0eSLXpCsGye9M0X9LoVkD2dDwPar+RoE9qOyE7nkAFramACqm9B2HTx+JlJJxY7LgM0NlijWIi7fiFHXU1+QU2Tj1Mdzfe8hie6JNGmZ9yD2zhabQNyalX/Tio70K9ergMgWSB5GBw71iPce3CNGoa7cDy+1aQQFeYeIxkv7AZZ1ss6TxT5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/E6pieqpGeNBBbW5lec8Exn6jsoWimQ0WWNDBuUr4M=;
 b=zXSwVYUHKFwnCg8G06uicHAbmOE/5hFgsk8Zi+JMgQLP4+4SyUSikCRJ98JKs4eECEaLvD06mEGhAtxU2QoLfsieve0OtLVpznQWs4d1KSUFL7+EDI23S0zv2W26gEQslumLFx2urN4REZkSz/GOKk3QfsW5uRo26iVMI+fgLvg=
Received: from BN9PR03CA0871.namprd03.prod.outlook.com (2603:10b6:408:13c::6)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 20:11:13 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::f1) by BN9PR03CA0871.outlook.office365.com
 (2603:10b6:408:13c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Fri,
 3 Oct 2025 20:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:11:13 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:11:11 -0700
Message-ID: <58b0d32c-72cf-4b15-9e2b-e9d46e96cb35@amd.com>
Date: Fri, 3 Oct 2025 15:11:10 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 04/25] CXL/AER: Remove CONFIG_PCIEAER_CXL and replace
 with CONFIG_CXL_RAS
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-pci@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-5-terry.bowman@amd.com>
X-Mozilla-News-Host: news://news://nntp.lore.kernel.org
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-5-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5e50e4-8e44-4863-30e5-08de02b90063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em1uMVYxeEZhamd2a2grcXNpMkxXc2FLRDhTdWpEV05MUWJXeVRmZVlxSTky?=
 =?utf-8?B?MktpVklZOWtVUDEwYmQ2Tlo3dHY1Mm85WlFtOUxKTEhmeXZpRmQrMnd5TWpy?=
 =?utf-8?B?WWhxVE9ZL1lhQjRMSmlJZFZtWVBZKzNyUUZacmhXZU9hL0YwbUNHSW9sODZ1?=
 =?utf-8?B?MENVSFg3RUcrTlRscTFnM2s3aHBybWhVdC9GMkllVm5NcGdHY0YrQkplcmNq?=
 =?utf-8?B?QXJMYlpIMXJRK0dZNXgrTDhpdGlQMzJtVG9QUHdWTkt3VkhVN3BiRzJIZmhr?=
 =?utf-8?B?UU1FSUVNNFZLQW9MaXgzZjNHR2pOUTNuNGdSQm9ycmRFVWcxdnB0WWNRclJm?=
 =?utf-8?B?bFpabzRlWG8zMnRUYjVWVEcxK052QmZEN2FvR3RTL0RaWjl1cmw1TW8rNkJq?=
 =?utf-8?B?TTNiVnNtNnpEdTJmU2VPN05DWUdXZVJiY0p5UFdubThFMUdpNG5xTGs0STRm?=
 =?utf-8?B?OXVob1A1eWh1V1FGS202cjNIYTRMa2t6TGIyVE9oWDlNNENNMENXcDVwRHRZ?=
 =?utf-8?B?ZytyOU1WcHJjNnkwcXl1V2VKY3Y0ZEZPSm1UTEdldFRUQ1V4UlRodjRoWlND?=
 =?utf-8?B?elhpa3BubzRVNlBRL0MrWnByaDVFbHpLQWIzdWF6SUdUUFBFZjMyMEhJUUJ5?=
 =?utf-8?B?OVV3cXY1MThDNWsxRnpzRXNwaThmSEZrNWRscHE0WlBzY2p2T2xOZ244bndG?=
 =?utf-8?B?NjJQSXcxSUJqYmxsby9manAyN3pBN0dOTzVLdDV1TUF6clNpMEx6ZEhFVitt?=
 =?utf-8?B?Ung4ODRHMmgwZm9sQ3daYkZIZnJuWVJZS3BHblJxQVk1OFkxWWZzcm16QVZu?=
 =?utf-8?B?YzZkZVhWRGl5NmJwTzNXaUxESFZxcUtzdzNzQlhnSnZERmdEZmZOMVV0MzRl?=
 =?utf-8?B?NEtQN3BjMi9TYnUzaEpLdmYzNStidDB2cDJDdVlsRmg5SUoxMDdLVGROSFFT?=
 =?utf-8?B?S3pFUnZ5aWdrWldsaUZXMnFVTjA4OWlvN0FpUFkra1NlbFFKbnUrNDVTYjRt?=
 =?utf-8?B?VHpLekY2ckV2QzBCRE1oRFBzSTRBMTN1RWw0cVN6K3ArYjJRZHUzZ0NWUzA3?=
 =?utf-8?B?eld3eHh2UlE4Ym1tSGU5aCtZL3V2NzdyVGlxbE1OUHJXMWpueGdTN3l0Sm1B?=
 =?utf-8?B?V2FTenU3Q1VUU2RzNDY4Mm12QjUvSlRLWWRYTmRLSmwwVU5RbVUzbVlYYVl6?=
 =?utf-8?B?RUJBNE5acWVZQTNYM1M3MEhZR2tpMHBiUGZWSmVCRkJtM1VMNllpak1GeDZp?=
 =?utf-8?B?TzhVczhISjVYaWx2Vi9jTjlsODliL1BjUVJoZ1JvRE9JeGsvMDJOV2ZIdEFH?=
 =?utf-8?B?S0JpdS9ZZy90dmdWYzdtS2JnV0pGT3RxNVM2eUdCbFpURlRldlpFMW5SdWwr?=
 =?utf-8?B?d1I1U2t3UVJmMFFPdUFoWERyZXZVUkpTRHZlOFpXM3AxN1lQdXAwNGNiWGh6?=
 =?utf-8?B?eW5CVHRHaDU3cWVZbTJjWUJqZy84dmVDY3lYYnFDMGNhb2VnMGM5ZkJVN1hR?=
 =?utf-8?B?bEVCNWcrK0c0QndYMXNlbE82VWV1ZFF0YTdzYmZVd3Urd0hCemcxZ3o2L0Jq?=
 =?utf-8?B?N1MrcFMydmRYeUx1N1grMlh1NkZSRXJOS3NjYjEwM3R4emRTSU8vVlh3dFk3?=
 =?utf-8?B?MUREcVUwbU9zKzFBVG9rM0c4NG5hR0ZnbzhGTUNRdmFJbnVyU015NlFzZjdS?=
 =?utf-8?B?SCtUYmhLL2dxT0o1Y1BxRXg1QTgxZUZvdHJJbVdJVW4wbllybktTSzkwRDZ1?=
 =?utf-8?B?cjVvamdTeXljdnhWc09nYS9xVU9hZHlkbS9TMUl0aGdQMjFaSXlJSlVCUU5k?=
 =?utf-8?B?YTBXUEltUGY0KzNTS0R5MUtFSldaVkRPSktLclByNjhFUXlDTlIzQkZ1ejJJ?=
 =?utf-8?B?TFNzTngzRWtGYWpidkpHTDB5U0EyaTl0VkkxdVZOYVJ0bWk3Z05LdEloSk40?=
 =?utf-8?B?RmoxR3V0YmZhM2ZZMlJvT1kzNS9xYlliWlBSZTY0RnhXMUxsMURvK25qdzJK?=
 =?utf-8?B?UTE3SDU1NFhTNG03WldjZ3FmQVM4WkozaldLWEZRTVg0Ty9pMmZNOE1oQ1BH?=
 =?utf-8?B?bkdSa2R5REtEaXU4eTk5QUk5ZG9PdWpNZFVRcXlHdTBsNmtuWmpydEIxNFVM?=
 =?utf-8?Q?n5NU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:11:13.1459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5e50e4-8e44-4863-30e5-08de02b90063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813

On 9/25/2025 5:34 PM, Terry Bowman wrote:
> CXL RAS compilation is enabled using CONFIG_CXL_RAS while the AER CXL logic
> uses CONFIG_PCIEAER_CXL. The 2 share the same dependencies and can be
> combined. The 2 kernel configs are unnecessary and are problematic for the
> user because of the duplication. Replace occurrences of CONFIG_PCIEAER_CXL
> to be CONFIG_CXL_RAS.
> 
> Update the CONFIG_CXL_RAS Kconfig definition to include dependencies 'PCIEAER
> && CXL_PCI' taken from the CONFIG_PCIEAER_CXL definition.
> 
> Remove the Kconfig CONFIG_PCIEAER_CXL definition.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

