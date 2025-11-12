Return-Path: <linux-pci+bounces-40982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2929AC51DC2
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 12:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79763A40C9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD87304BA4;
	Wed, 12 Nov 2025 11:04:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023126.outbound.protection.outlook.com [40.107.44.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300DAE56A;
	Wed, 12 Nov 2025 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945462; cv=fail; b=UVU8b7FlnsG//UeT+usjah+pjo9mSfh9C3MB7OS1lGFNRG/P40HBcQDgQC9wx1whljH2ldN9SX0jwG6AkSPSVYpEKTTQnx3Uvdr7D4RqbIOMqPJHM1o6/qvJOtrWr0EtKfysvUpwTvSMBLMeTbCokac5SLQ2xED9jcPJEq+z948=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945462; c=relaxed/simple;
	bh=MhyrXZKGimvgiILhHUbLE2HQ0cvRDmLZeppganDPGcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIsdgb6S3xiL8wIzD0Ic5oPD3GPanai3VqzNMLv7sn/qFnKcK6p56gE4kFbrUGSz80bblmlZF/H0ATXR1JTgv+ENjFTj114D28sAnCfdAesXFkl+uoFaaGLRqeLF1Pn93QNoTmthzTf0Lau3Mt1vTjf3t6OiJpio6d9/zjm0d1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWN2aHpk2T5k3GawjwPPmFplPP9R+pNNQXBDVh7uYzJc9c0vpzfYMXRs7dG1Uzhwh6Br5OGc+erDceoU1YIG3X6kAUnmgAJNW8bWVFp0jvJ4bkuAmS26H2BRg2SCe5O6mAwBQalPtaxWi2RifCQFl0ly6SCMRT9fNML+tlM4WDLhjFr0qUD7g4pvJjudwfl0EUqiNrSMesyaA01bVOj5pmmJBnM1K3pxtakoFqw9gI5dUTUAnOlGGdilKVArExMLsjnCJa6O4v6/q7VwdUNBAaZxwcc5zKgbWNQ1hpEwnHSdD0xNVIUJHrV8Ih+D1f8ozDL5nWro5hggctMSw1M/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zA848SkabEn1QnVAIPBikXdCbqRN1MdWv+kVvgT+r5w=;
 b=nvbaOx72e36jUgWyJZO8kH5vKrn+dSwe7ccYn2aO01wLWtxG9lawNcIW1ovkm9D1dv/lvqLVsPQdPEY6wJQShIewvsoDhCzs+Gwri42wftD8aX7GXWFgr3bbiC09BrqLA3v7E1P0Ng2QxkdZZvcJmx07Ae9rQyGqsQbgBm0zw5IufLmbtLYlgGXfa4DBYBBL0kgAq2UkB2dp8hS3HHwiqs9XlPVgcjyC2Qf52dcfe8YRcIWqGmqgEHTJDuOmVF6ObX0TfuqNimtduJ35ZYrQ8x9svcWObuAvXjQ2QBQjyeT85PjaYPpJ14HTB5ebUDxKklrLtr4PXCeF0+iEjk3opA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=163.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR04CA0014.apcprd04.prod.outlook.com (2603:1096:4:197::18)
 by TY0PR06MB5756.apcprd06.prod.outlook.com (2603:1096:400:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 11:04:13 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:197:cafe::1d) by SI2PR04CA0014.outlook.office365.com
 (2603:1096:4:197::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 11:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:04:12 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 23CB440A5BD4;
	Wed, 12 Nov 2025 19:04:11 +0800 (CST)
Message-ID: <6bd16478-4bf9-436a-b862-02d1ebac3d29@cixtech.com>
Date: Wed, 12 Nov 2025 19:04:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] PCI: Configure Root Port MPS during host probing
To: Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>,
 lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 helgaas@kernel.org, heiko@sntech.de, mani@kernel.org, yue.wang@Amlogic.com
Cc: pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, cassel@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20251104165125.174168-1-18255117159@163.com>
 <20251104165125.174168-2-18255117159@163.com>
 <ef433574-3e81-4636-82c8-9bc3552addca@rock-chips.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <ef433574-3e81-4636-82c8-9bc3552addca@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|TY0PR06MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: c57403e5-38e8-4caf-6227-08de21db369f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmFBTlJiUlJzdnJzV2dqUkNjNjJmYk5UUklDVlRWL05kU0xLWXFhYWt2UjZw?=
 =?utf-8?B?NHI2ZURTRlVTZ1pQeGFpL1VvcWdyeVZTdnRPTlV0L29lSDhxZ0kvbTRaNlBG?=
 =?utf-8?B?aTRUOVRqNzgvWnFrNWwwN25CR2dSbmNVdVRtRzlaaFRxc3A5cllwT2htTjVo?=
 =?utf-8?B?Y3ZiNHA4WVJGWUVUVXpERHUyWnlkVlV5SVdPNlhYVUlmaXQrZm9FdDRYS28w?=
 =?utf-8?B?cWM3ZmFCZzZIVWN3aGZrandIK1FCa2pvdHl6Q0R2cTdpSlNMdWRoQjFIeHpM?=
 =?utf-8?B?MDdmVldQcEo2MDNkUHhSYXFmV0FiZ1NVRWhVVTBDQWFaaXpSdFZYaHBKRkdD?=
 =?utf-8?B?ZldvZDhpQTc1bysrbEJPV0lHUVdnT2ZCZjI5Wll1cTZwSnZWR0RFQXFpRXMz?=
 =?utf-8?B?OUw1emc5cG5MczFVTEk0MFE5UGhaUUcxTExOaTltYjRYNVROMnp0ME50dHJH?=
 =?utf-8?B?akF4aGQ1Q0R1cnRady9iT0U1UDZtOWtMNjNLUm1XZlAwVmJnaWhMZmZHWWZa?=
 =?utf-8?B?T0JNZ2s4bStTdmpDb1BOZW5wQU5VZWNZbnljSll4cnhjUUFRYzVzTkVobGxS?=
 =?utf-8?B?NEFzSFg4TXo0Nis0TERKQngwQ2xEd1p1b3NCaWZWaVN3Q29pRm1pL0VJdHJW?=
 =?utf-8?B?VE9ENmx5bEh6aUt0cVl0Sjh3Rm1yVTY5YnBuaUdvSEh1aDN6Q1MySUd5eFQv?=
 =?utf-8?B?OVFvSVAvVFZPRVVLWXVlN1dkVDM4Q1FtT1QzODRGdWxva0FjTU0zMHpMT0Uv?=
 =?utf-8?B?Y2FYVFZUWmtQZmhOUVNUTG1hVDBPZVlOWVBockcxUCtDQThqaDZKK3Y3aXpW?=
 =?utf-8?B?ZkFjSFFNU1ZRaHFMSmJIbmpKWmJ3aEl2UFdpMjJpU1cxL21HaEtIUUY0K2Fh?=
 =?utf-8?B?NWFlNk9GMVFoZEtxTGhHbUEyckdJek1qaDlwT0FOeVd6VUpPK1NROWhRNHZP?=
 =?utf-8?B?NmN3ZWpFdld1RXlFVytKTG9iVEV6MVZUT1VmMEp2d2lsb1c0TTFTUHNhOHJm?=
 =?utf-8?B?SG5aalBoTWs1cGl4YW5YQkVQdXhpVkVUaENQMW16QXVackp2WThHZmpjc1h2?=
 =?utf-8?B?aGFLMlYvQ2o2cGk3aEtScU5RVnhxa09pZThCQUVSVjRLMHFhNUhuaUljMXlp?=
 =?utf-8?B?OGErVmxuSTVONlczRU02Sy9KbDZjZUJsbWlZU3RzdXhNbkFxNFArNldWbTZJ?=
 =?utf-8?B?UjN5K0ZPaVIyYWo0N2svcDgzbE1zOWVkVFVOVlg3K0ZidkIvdm1WeGVwYXRG?=
 =?utf-8?B?TVYxcXoyMCtKVTFwemJ0eWZTZlIwUzhqOWJVd2gyTG81THg4M3Y5empsSUtG?=
 =?utf-8?B?RE01a2Y0U2RONmc4WXFmdzZpUnN5TytUUmQ1SEd3ekVSKy9jdnVqaTZPOTZT?=
 =?utf-8?B?UlQ1R0l3TjY5b3R2cHh1N1RXbG4ySm9CUnBGUWpvMWZuVXhIRE5NZlNtNHJY?=
 =?utf-8?B?WFFJTUoxNmY2Q0hWRTdMN3pldkcvYjJ0dGlseHY1YXAvYURvVkFLVlVydFVX?=
 =?utf-8?B?dWZGUEgzTWp4WU5VTTgwL1NlOG5PaVVlQnFmbWpMdU1rOVVkR3U5emJZN3NL?=
 =?utf-8?B?MWZwNGhlNWFKUmV5ZkMwUUtqSldHcnU5TTRlZE95b3ZVMjN2aDRzSktRSlAx?=
 =?utf-8?B?aDZNWE16Z0JpcGEzNWkyOEw5VTBGWkd6RjZRQzlVc3NNQW5PSUtVNjgvNHho?=
 =?utf-8?B?NFIycGNTbDVBT2FvYXc2V254Q3oyNURZKzdjUTJBVXdHSkJwdXk0ZjRGY2oz?=
 =?utf-8?B?S0h2SXo0VGFIZmhkNWhyM1NGSmZjZnhlT0NhQVZOazhybjJtUlo5dE0xZWpV?=
 =?utf-8?B?SFoxQStnVWVsMHY5c3R0eUZjOXpWSGZYMGZ6MEJrbS80cktzdjRic2lNNkY4?=
 =?utf-8?B?OUlpY0pQb1N1dHBRd2x1dVpFNmR1MGltSjR2bUZkUm5RN00vNG5CT2Y0elJz?=
 =?utf-8?B?VnpHREV3NkVjdGs2V0M5djlWTWtxbzdmK1lkdW1DSzZjemJFWXBKUEhjbEY0?=
 =?utf-8?B?WGlueXpnNks5eG05SWVSVldoSmtYQ2tXdDhrbUx6dHNpc1lHbVZFUVlFdWUv?=
 =?utf-8?B?SnFYZldTZVcwS1p4aklRMGx0TlFtWHBSTE1XaXREdk56b1B5aHhKbkd0VnZ4?=
 =?utf-8?Q?pInQ=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:04:12.9423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c57403e5-38e8-4caf-6227-08de21db369f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5756



On 11/12/2025 4:31 PM, Shawn Lin wrote:
> EXTERNAL EMAIL
> 
> 在 2025/11/05 星期三 0:51, Hans Zhang 写道:
>> Current PCIe initialization logic may leave Root Ports (root bridges)
>> operating with non-optimal Maximum Payload Size (MPS) settings. Existing
>> code in pci_configure_mps() returns early for devices without an upstream
>> bridge (!bridge) which includes Root Ports, so their MPS values remain
>> at firmware/hardware defaults. This fails to utilize the controller's 
>> full
>> capabilities, leading to suboptimal data transfer efficiency across the
>> PCIe hierarchy.
>>
>> With this patch, during the host controller probing phase:
>> - When PCIe bus tuning is enabled (not PCIE_BUS_TUNE_OFF), and
>> - The device is a Root Port without an upstream bridge (!bridge),
>> The Root Port's MPS is set to its hardware-supported maximum value
>> (128 << dev->pcie_mpss).
>>
>> Note that this initial maximum MPS setting may be reduced later, during
>> downstream device enumeration, if any downstream device does not suppor
>> the Root Port's maximum MPS.
>>
>> This change ensures Root Ports are properly initialized before downstream
>> devices negotiate MPS, while maintaining backward compatibility via the
>> PCIE_BUS_TUNE_OFF check.
>>
> 
> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

Hi Shawn,

Thank you for your test.

Best regards,
Hans

> 
>> Suggested-by: Niklas Cassel <cassel@kernel.org>
>> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/probe.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 0ce98e18b5a8..2459def3af9b 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2196,6 +2196,18 @@ static void pci_configure_mps(struct pci_dev *dev)
>>               return;
>>       }
>>
>> +     /*
>> +      * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at 
>> all),
>> +      * start off by setting Root Ports' MPS to MPSS. This only 
>> applies to
>> +      * Root Ports without an upstream bridge (root bridges), as 
>> other Root
>> +      * Ports will have downstream bridges. Depending on the MPS 
>> strategy
>> +      * and MPSS of downstream devices, the Root Port's MPS may be
>> +      * overridden later.
>> +      */
>> +     if (!bridge && pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
>> +         pcie_bus_config != PCIE_BUS_TUNE_OFF)
>> +             pcie_set_mps(dev, 128 << dev->pcie_mpss);
>> +
>>       if (!bridge || !pci_is_pcie(bridge))
>>               return;
>>
> 
> 


