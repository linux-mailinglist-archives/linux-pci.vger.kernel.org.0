Return-Path: <linux-pci+bounces-37583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE89DBB80B2
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CF844EE8CD
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BEB226CF7;
	Fri,  3 Oct 2025 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VXnS6rRA"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17410224AF7;
	Fri,  3 Oct 2025 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522342; cv=fail; b=TlYPRXDgSO8uAC1QCiH+0REsfrggqDQ0QVlThqdFEOTnsHXw9daYzWRTm0/1T1qinTguhk0hf9UTdVRKpuI41FC8KYEyaF1JEj21KHcMPwJjeUOzxltwGHMZn7lrjabzaXBEk2SAnv6gc73uTBsmI+eIJji7zNVE4Bjgj4d6NQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522342; c=relaxed/simple;
	bh=YVSf69g1kbt35lGNY4m7n28E50R01UUWi0Mte+Gu2+E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=GchOyggijl06HiC60mH7xOcWA6R26deC2O4lG4ei8nXhzl+Kr9mNf959Nr7Y2j0iE3anuek8iXxHIiK6gZSob8Jei1QWd6Ab+YC2Q/6XUWlyA1LWfERnm3xjKDwI7jmQlTnid4EA/PHYzhemkmLd+1bQu0J9xNCjTSkJ30k10R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VXnS6rRA; arc=fail smtp.client-ip=52.101.53.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbnIlr+bIr+/KlfEBjkyZI6snYC0+OKGvfMU2Zmgsleuomv579AgDI+oP2ElXDpnRDb7UBGSzRnp8wCsfp+nnGI/claif4FO6iyokDn2SU+lu0K/n/QVlqUYhF7vZCwGtcYtbLpH7rAMZlMhe4IAbGwKQeihoXMimno+d+wyOfiA2mlCK8Li9SwIyJRvlxb3cD9REESzN5BTh9lJMa+sT3wtGktnOADnuo0qM/+s2FbSxYrd289t1dwcHgjqiP8fJJzCyKBZrwnFkTXMcA7s2Bqo9cateaxitanZEKHcKBwN+/HSPJDRTL3DsTZs4rf8vngPZuHaEhPA/Fum+vzLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5142sCWRSCD4j8Tfyn4xvlhXgnHM+pj+LnFpmmjghyI=;
 b=L0U1ChmVVDncX2SPF/4ipBDVpW/TwHNoa5119ypHvtfhdmLkdeWhb0ZU2Hy74N1UzptZhSDThC8sx+KTxVFaXRHKH5EzkMkbnMrUcMrKFWEbQi1wm2XOMERnyWxFnrp2QUmc4uIomnHlupVE9m12MbVZyQ3wIb1pvynQ6bdLk/oCB13UV6jk6D++PWPbbLlmqxHSBJsoJOBXDfqm3mWBlO8Si3ZluPgj/2yPcKv5w4xoNXrm+Ml3UXzPs3EtgTv2WYvphTMQWn51wR8L58fFIJMLF9iqKYjIIzTTfVGAC2Fj2P00gyfZe7G3fMKCpgVRKWrTRN2teITylEWtfC+oMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5142sCWRSCD4j8Tfyn4xvlhXgnHM+pj+LnFpmmjghyI=;
 b=VXnS6rRAkGxgj4eSqg0TDOjx/CYAx+9m3nEMPYf3DboKTV8kAG6e/rgXMec3Nvh620YfDPD5pybXrelhUDSATogThr4BL6jKFTAwF5VARYah4IQsWqxv50vCF7Xx7xMJ1I7hmyGq4IZt+aeJJa5uMI50itMzurYVuSCHbKXdzeA=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 20:12:13 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::2f) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Fri,
 3 Oct 2025 20:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:12:13 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:12:11 -0700
Message-ID: <83c970f7-d2d6-4c90-9838-bf53da7fb466@amd.com>
Date: Fri, 3 Oct 2025 15:12:11 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 24/25] CXL/PCI: Enable CXL protocol errors during CXL
 Port probe
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
 <20250925223440.3539069-25-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-25-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 9595c97c-5c42-4e1e-092c-08de02b9246b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1lJOWdraTY3emRVa3dXYk02WEk0QmphS2VYTHRadG5mcjA5NWZTbi9qbXVB?=
 =?utf-8?B?eXRjL1pjRWc4bWlsZWhabGp6cmV4VE15VFJnVHVCS1lpMjljdTR6WjZrVU5W?=
 =?utf-8?B?VTk5dnB3amgrRTlrNmxlamFmQXZtS0tvWjlTeitqRHgxY1B0QUJhbjhKRTA1?=
 =?utf-8?B?SHhUZWVEcXFHWTYyMzU3UlVIZmd0bFlOK25JdjRneHRMb1NzcTltQjNMK2JG?=
 =?utf-8?B?dHB5eEdQZUY1c1Q1NmtRSi9LcktVdDNwY1E4VlJ1d3BzTmRYRFdJUW5MbEdF?=
 =?utf-8?B?SmFUSEN5U2IyRnlqUmNyL3lnaGFNeWlKclBnNHpXTXRHRStSM3hSRmlGMEJh?=
 =?utf-8?B?WXVTQkg4bFRYYUhYS0tDVlFMaWZkMzNicUhDWStOTGtyYkZXZlU3T0p1dHAv?=
 =?utf-8?B?azg3OUVyOVd2OWl4SVNoS1Ryc2tmNnVsM2E1NlpYTGl3UldXdnNTZThYalgw?=
 =?utf-8?B?U2R4dEN0RG1nSzVWYjM3d3NsR1k0aVlsbVFXNGV4R2lnMXF2ZitjUXp4UHda?=
 =?utf-8?B?RndXdW1KQU5IRWNOdHA2UHlPUE1VMGpQNjlRQzNGbjN5ZWplekZ4akdhTUpR?=
 =?utf-8?B?YkVBSGFOd0N6UCtjaXMyUnFkanJYMUxPeGV5K0ZremRwMnZUcUZZcXJhNEkz?=
 =?utf-8?B?eEw3OXBsZjR4cjBzclJHZWE3UnNtUUo1VzEzanZWcGkzV3BXdnJQdWJCTHgy?=
 =?utf-8?B?OTZnRzRQcTJwTDJGMEJhdnlpc1BiNXZ2eHhuVE1MUjVLRndta29iUjZ2UDNO?=
 =?utf-8?B?empHek55R3ozV2RTL21YL011Ulg2MWpuSzludGdnYTAyVWpta3duK2hjeHd5?=
 =?utf-8?B?YkQ2aFI4T0lxTXBHOGNVL0JXN3FmbGFiQUZBLzhRVkxQa3pyZUplcnJpUGpH?=
 =?utf-8?B?bk1UOTJsM2hocm9UbVJLN0R6K0VTdHpNVk5HSjJ6ZldmbXMycEd3QUU1OUJt?=
 =?utf-8?B?K3lDYmZaNXQwZUQyalRxNFdZUThDWFZvcDJYRFA0dHQ5bTZBSDZlaERKYkxW?=
 =?utf-8?B?U09xYlJSK1pOeldFZE1Hc3Y1MEpCV2FNem5pd21qKzhMNmp4bzF0ODh6T2Jq?=
 =?utf-8?B?YUFhS2xCSUNwWlAwVkpVSnkyVzYyRkpmeGZuTnU4eUV6R1VYTWY4bDdPNS92?=
 =?utf-8?B?V01uUmZwUXgxTEFnREMvVGhWT1U2ZjFKRFR2N2VwbEYxYWMzK0IzaEZOdlhl?=
 =?utf-8?B?L3VnQS9KaUtBSnJBTDFMRTR4d2ZSOGdua2QyNkpJa1B1ZnhOOUs0M2lpRWZy?=
 =?utf-8?B?MDgyNmxBSWlzSjdxRmNIeFlUVDhZYlh5aWE5WUpscVZSdWY2WFpLY21uOW5S?=
 =?utf-8?B?NmpJanEzYzJvclFQdmhNLzJuVWJQWjJYaEFOQXhMeTk4dXJZSVZuM2FIVExF?=
 =?utf-8?B?a0t6a3lSMjBaUDFOM2lOUUlhME9OWTFkcGdMcitPR2JFQ3U5SHJvd0pQK2pW?=
 =?utf-8?B?S3pEUXh6amNkSnh4UUhvVDZPbjBGQUoxbVcyL29rL1hsdHJSQk5ZaENVanVS?=
 =?utf-8?B?emJHL1dMSzhOQlNOczlLdk9VQy81Z0FpQVAxVjV2RGlnVEYzUlJDNWxBcStr?=
 =?utf-8?B?OVN3d3YrNFh0THZlUnhzQXBTNm1LbXc4K3BFRWwvSlNmakNwR3FVTndUUXpU?=
 =?utf-8?B?VThvZVpuN3BaK09uMjdkTDFxQWw5NjMwQ1JGQ1VCRlhZaS80cC9kMWwyZ0Y0?=
 =?utf-8?B?R0gzSm9MMUgvNUM5UjRrWkY2NFBjUGZhR3RrVWdVSGU1SUhEY0U2emtHMElE?=
 =?utf-8?B?MkpLc1NIVUJyaTJiWmxNRG5GOXk3bEVldjhBaE9TREhKcG9vRjQwbFFqMVNU?=
 =?utf-8?B?dXk0ZlB4RHpaYnNEOWJyQWtuNWswSmgwVHoxSXdVT051MG9XenV6N2pvcHI2?=
 =?utf-8?B?Tis1VWFZYXhtbjlvbjRkc3lYanczL2p1NXJRYlR6SFR0dGNpeUVRa2c3UXR2?=
 =?utf-8?B?bHI4a2JLckhZMDg4MkNYU3hqK0VkbE1XYkcwM2ZHNlFGQVltV01VTExLVDNn?=
 =?utf-8?B?Z3dHU29GVWFKd01URzQ5Wk9kSXV6VUQ5TlN1dWl3bjRYeUVhc0U1cFpPMjdJ?=
 =?utf-8?B?czE1bGtOdmtNVGxNMjFqa2xTY0ZIZ1NYK1NmWTYzWmkxTGx1c2tud3BNVk1Z?=
 =?utf-8?Q?6s2A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:12:13.5635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9595c97c-5c42-4e1e-092c-08de02b9246b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808

On 9/25/2025 5:34 PM, Terry Bowman wrote:
> CXL protocol errors are not enabled for all CXL devices after boot. These
> must be enabled inorder to process CXL protocol errors.
> 
> Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
> pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
> But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
> Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
> correctable internal errors and uncorrectable internal errors for all CXL
> devices.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

