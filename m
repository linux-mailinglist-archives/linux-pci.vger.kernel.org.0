Return-Path: <linux-pci+bounces-37575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CCBB807E
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE8219E3CD9
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E15E23185E;
	Fri,  3 Oct 2025 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zpthLhz5"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15342288F7;
	Fri,  3 Oct 2025 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522294; cv=fail; b=IOktw0Jw4txMZscYeEVTOZgF56vCRnhgLBZtegketI4EpP4+0815gqmXxpXuRPH5N1bX0pavvEBrtlXBA7C01Qh6WCMgQvJm0wTJ3CC6wdP5YAS7gHt9t/uKsp2irowT6M944zGY08Ixc+38uy2YOOg1J1UHfDnb7dejZzt25qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522294; c=relaxed/simple;
	bh=p4FQvbj9bX4rT1KHMnKyM+FVhSAD0NEcLsKIgCrEn0g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=qDwN0d2YUQJJzjSxI3Gr8XRRGJtuZq+wmJ5DKZjucXsaXbVGMvfM3TBdxwturwsHzGzO5RUoEvrzYVek5woC5NSzsBr1DTguggGt0UcqkLA2zD5vUL7pccvHKw8H+KaJO2qzZDpZAL4pJCpui0hCf2Mw7VgCIFJW5vwp9CkvwsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zpthLhz5; arc=fail smtp.client-ip=40.107.208.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCdTc2zB2tZs+qW50Wxuo6kpwC7xoDAbThGXmQNbezQkPpzxt/wwNJ40q6kmQ5mkSLtQwupoIKC5SdSYi4IgtDR4O0Nf6cnjAw5rZa8JM15No4GMBPwOybMnMl/3ERfQ6whdY2K/AyeZXLfPG0+707m9aev0r5JO7F2RJ8pelw6EscQlPTDGUza8t4KYfVqpEY1ptbBjElJFac2OZtUN3QgBgb+yl1h4UY/50KstKa7IK/j4IxwA3OFdb0CYdx7NRHbZg5Z0LUdJnO/EbdOWaJnFP3LTzYtBsNaxGX72yfj7TqxkZqmmVo1qbPkxf/WoK1ywI9XECiR0SZG/1mnT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lzrmzq2ekyv2Ly3qO/ktEtyza9Da4Xo/xAduQaKiU/c=;
 b=YJ+ggBxV/QAqBbywKGxTMijBvnl4IwTHjkZhd6oBbVJ8H+5U/wbBaB+j9cPYMonqgarK3X0YXv1+lPYs7k8Z8WLd8p7139+n8oBDkO7bsFZuwpk/+r+vlJwZ3vFHsCAea3WN0A6Fwj+iuDM0cCbYGVlK237HT7v8o9S4PfDAO+z2MzN8fqgGg+2oMtWUWtl4P6q3DwO1zXEJ1zIDoAo7jEIZGCOlMTFNRrj5RKQfI0Ql4l7tWifzB9hpuQDn1qIt23IEDN/xZDy7cYYOsi9vTtFq2OWS8yh+7JbPCZus0RMWgU3UTJnuBxJcz2lQzEKpExw4Y8bBVKBTskZ6uTCHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lzrmzq2ekyv2Ly3qO/ktEtyza9Da4Xo/xAduQaKiU/c=;
 b=zpthLhz5zWjtMvoDHi7BqGSDNHEqhkXTUfsiY5Sk6jz8b1vRsOVVsUkCMtReCuX0GVHmD1NWEv8ywaJcc9jxSSmllV5rjYZPyGIHqkNO7OtPgcHXJU6XyaJqMwQe+KXPp0lDNDrDCB1K+zrSMTfwfvrbJG+M8vPfkNmfMujtUDk=
Received: from BL1PR13CA0343.namprd13.prod.outlook.com (2603:10b6:208:2c6::18)
 by CH2PR12MB9460.namprd12.prod.outlook.com (2603:10b6:610:27f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 20:11:28 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::e4) by BL1PR13CA0343.outlook.office365.com
 (2603:10b6:208:2c6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.5 via Frontend Transport; Fri, 3
 Oct 2025 20:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:11:28 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:11:26 -0700
Message-ID: <6e6544ad-95c8-4dc2-be44-b5b463bf516c@amd.com>
Date: Fri, 3 Oct 2025 15:11:25 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 16/25] CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-17-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-17-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|CH2PR12MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf0737c-5541-4b46-4981-08de02b9099b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REh6RnBrYSs1Zy80U3poZ29ZaER6YmIxRmUzNHMwMzFoU1RIem1ha2NObHNx?=
 =?utf-8?B?eDhDSW1GVjhwMDZjR2FqaW81dkhHS1gvS0ZEN0p6S2xTbVhlb1B5ZXNTZVN3?=
 =?utf-8?B?ZUlabEtYckRsbytDb0toaXpKblJXa2Q1Zm5wMmV6VjFoNmg0NVpuV214clp4?=
 =?utf-8?B?Y2xQNHFPU3hvVXR3N1BsdTNvWkYvVXYrMnJCOHJsamxtcnRtWUpGVXJpZVpO?=
 =?utf-8?B?NFRZU2NXL1dhVmdFT3BuS0ppREp3Z3RNRzNaMnJIVEJpOEtjN1dESURYWmF5?=
 =?utf-8?B?aHZGdEJobFQ1SDk3REpjZ2Y1Ykk4b2xBdnh0ei9QMHA3WDVJd2xjWnRhaEc0?=
 =?utf-8?B?cldTbjA1QTk1T29NTG4vekFkM2xTa1NMQkE4ajg0T082WE1DWis1UVZaTWxl?=
 =?utf-8?B?YkVrSHFrM3V0dlhEdW5SZ1hRRElsWUdZUkJKdTdPZ283bllRRWJLcU1mbTNB?=
 =?utf-8?B?NFlIZFVkYXZSeldLVjIxTHVlVTJwOUtrSTBtU1NPYi8xM2RhL0wza0ZDelY5?=
 =?utf-8?B?aHRLYmU3TnBoRHduZk11UVNQaXQ0Vkh3RHFPUjI1NzJVVkk0UmpMQXQxVnNS?=
 =?utf-8?B?NWk0UWFOYjQweUdOZ1FHbHYwUzdXbGRMZU16MjRYZ2ZSb0hRaFlaZlNmVnBo?=
 =?utf-8?B?RmNINlBtYi9Rc2ZiVTBWY0szQ0tzZ09yT1BSQ282WlFpdW9FcTNQVXFRa0JJ?=
 =?utf-8?B?dlJxME0xNXdzeU5maWNMOU80RXVkSjN5MDZia0RsUDJlVW1BU3o3Z0RaZHpI?=
 =?utf-8?B?dElhRHl2aHJiUXdkZ09Bd1Q1NmMvT21OVUpZaVJkeW8vdnpXd2VvLzVsSFlZ?=
 =?utf-8?B?aFFSS2NXbzBoZVRETFpmVlIzdHRUVHZONzltaHRTdVdtbkRrVzJKbnFQR3Y2?=
 =?utf-8?B?YjZpVnFwVjF1VS83S3lpQS85dWZvRjlYS3NHUEtIN2JDR2doVnNSL0lVK3Rl?=
 =?utf-8?B?VGtIeHZLTFJOQytzL2pvblZ6SnV0ZGQrQ3JGNC9oQU1rOE50WDlicUZyR0xl?=
 =?utf-8?B?bFd1YWVxQXBORXZqR1ZIWVc0a1ZWaUxteERyYXR3VlI1OE4yUHA3MDlpUXFy?=
 =?utf-8?B?cFRaeW0wZ245Z0pQRVVrTVNXZHVIYWVkWmF1Vm85aVc1V25HOWxRN3R2UDdp?=
 =?utf-8?B?a3plNkkxY2VpbmxjUEZFZXA2TEsrRlZJdXh6ZmpVYUVVU0FzckZhQWJCZXh5?=
 =?utf-8?B?V2pPSHJGMkl0Sk15YXVzL2g5eExITDRrd0pHVitxUG8vUWNJT1dwdzBNb0NB?=
 =?utf-8?B?SlhqdFV3WkpCeC9qUElpd21XSlVMVlcrVEdzVzgwM01GQWRGT3ZjaHZCSjli?=
 =?utf-8?B?ektwOTA4ejZ2TzdpalZXaENZN01RNXZiS0hwcTh6VXVORFFWaUpuZWIxRCt5?=
 =?utf-8?B?WnhieEF5NmdIY2lhVlVCRm1aZEVuMm1HSlpXaXliQ04yOGFLcURuaFgvTU5R?=
 =?utf-8?B?aXRnbWhaRmZxSU5WRWowZWI1L2hhdVF6WklrQ1RPZ2lBTnhKU0dHT3p5bDFM?=
 =?utf-8?B?MTJtOXpjR0syMnhtUEx1Nk5RUGxpUi9lS2p5azdWMXRScjZLSjhUaXF0RWY4?=
 =?utf-8?B?bUhxYk1qYTdRZHR2alNqRHF0L3AxdVhlbG1EKysrNURyNlI5dmVxeHNmWkpN?=
 =?utf-8?B?OTBSSnZWdlB6UlpEdzVYM2IxK1d6azUvS2ZhVSthRXFiMTJMQWZ5VzRmTTRT?=
 =?utf-8?B?bnhEbmxlN04zVnZ5eXR5eURNUnhzSjR1SGRDTm1HME96ZnB1MmlabHhUYVBk?=
 =?utf-8?B?eTE0ZmlINnR6emYvaUV4U1I0R3JLSVBDZ0ZlaDBhK2Fpb01PL2dCb2NSbllx?=
 =?utf-8?B?bWxnTVhWVmdqOVRYZ2IwOHkxcjROSk1FQk5nQWswNWI3WWwxMnVHZlJrcFFH?=
 =?utf-8?B?c3RuRUlsbnQ1c2hBZEpkMzdhNU93TjRCT05xeGRVUzFjeTk2NTFlOG52KzBJ?=
 =?utf-8?B?M2d4eUU5SzM4OVNEMXlqcHdocG9hNy9kTWkzblZkNWtMdTU4bDVxZjlQRDAx?=
 =?utf-8?B?K3AzeG1SQ0hhd0JpSitudk5UbUMvVWZTSlF1enpnR2IrNENESjFzRzhnUkRC?=
 =?utf-8?B?M3ZmMUN1UVlPeFpxWUE4Um9idzY5Qkhkc2Y0ZWg3ckdCL0daMWk1YVhUMGND?=
 =?utf-8?Q?igVg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:11:28.6127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf0737c-5541-4b46-4981-08de02b9099b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9460

On 9/25/2025 5:34 PM, Terry Bowman wrote:
> The CXL driver's error handling for uncorrectable errors (UCE) will be
> updated in the future. A required change is for the error handlers to
> to force a system panic when a UCE is detected.
> 
> Introduce PCI_ERS_RESULT_PANIC as a 'enum pci_ers_result' type. This will
> be used by CXL UCE fatal and non-fatal recovery in future patches. Update
> PCIe recovery documentation with details of PCI_ERS_RESULT_PANIC.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes v11 -> v12:
> - Documentation requested by (Lukas)
> ---
>  Documentation/PCI/pci-error-recovery.rst | 6 ++++++
>  include/linux/pci.h                      | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
> index 42e1e78353f3..f823a6c1fb23 100644
> --- a/Documentation/PCI/pci-error-recovery.rst
> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -102,6 +102,8 @@ Possible return values are::
>  		PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
>  		PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
>  		PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
> +		PCI_ERS_RESULT_NO_AER_DRIVER, /* No AER capabilities registered for the driver */
> +		PCI_ERS_RESULT_PANIC,       /* System is unstable, panic. Is CXL specific */
>  	};
>  
>  A driver does not have to implement all of these callbacks; however,
> @@ -116,6 +118,10 @@ The actual steps taken by a platform to recover from a PCI error
>  event will be platform-dependent, but will follow the general
>  sequence described below.
>  
> +PCI_ERS_RESULT_PANIC is currently unique to CXL and handled in CXL
> +cxl_do_recdovery(). The PCI pcie_do_recovery() routine does not report or

s/recdovery/recovery

With that:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

