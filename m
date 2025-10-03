Return-Path: <linux-pci+bounces-37582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE9ABB80AF
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807EF1B20835
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E30258EF0;
	Fri,  3 Oct 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bm8IlXHr"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3702571AA;
	Fri,  3 Oct 2025 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522324; cv=fail; b=r6K3luAXXUTBP8PXj3G/O/EjSBh09eIz2e1VouC/jHIqF35BuETd/fh7xB9ldVuSLkXa9WyXmwmOGAqCBHjev1dVlpZe0PK7VZ0qfAwcba7F6ty+Ns4n79m91sAEhyadTYZu3/TpV8lD0gtEvz1WWlTSJSnZTX6JRHol82VRyfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522324; c=relaxed/simple;
	bh=zSjNYibG/Nor/UB5h2+h1ldTdFXNLeozqTqc0Zk0FYM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=dPPaRybiVUMmUJC7ZhK9vq+rDET6jvf/Sn75KYCmJoF9FzsgXfN/Ev1YGMG8wTcdgsNGpeKEkq5HwTfJoLrVOCIFDrO9hKs+QsPD9qmG/lGHftlpcDgElfcekkPZKlbn+V6IyN60QQrcl1E2o4G5Vzovfy1lT2EGu9sVMpuXaTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bm8IlXHr; arc=fail smtp.client-ip=52.101.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqkJDqFTBUyQw4xraoO5SReRMbqc3mryxNMNXSgjBH0Zm0gl+XCp9DrE/og7oQRUorO7bBRuLzGyzFyNx2dCSiV3dfSluMowAFiP5iKNrg6F/6IujH3S8chP13XdQV8hTVM1kUmfI/U9LcpEHLX9vTysGvHPXcoVjIrtuombhN9vrl+hVOjg1ReEJQBuyt9t4v72TN275tQ2UDRdYnUjbFRO9uciP7ppeOu19Q6hvuKEyIxTB3Tys7twLHXzXG8CwdHTh/8rDOBZA6U0kWD74c9wcJ7M9fUwrdk3F00SkWlsvL3SIOTnBGF/x5ZL8ehIG221+jWH6AOk7ZznbxKdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+77oSLVIJZd/aqcDFwEqTDJmmMMWge0J6jPSYVpBLQ=;
 b=DszujNh46OalYZ/21Tloij9H3wgJ2YcRUlqfRRP5yCnI6h8YJMnLyrQb2IOXhSw3kxcR2nk0dq0w6v+lxtzpNOXdq0vbbkBRkbFJe1q4O8aXXc/Iv9Om+m5gtZk+uRjR2k/0W0yoP5hXwo+cv2niYmVju+pLy/d8gW/Msb51FDutgrfmu+ME77sbTCdTJsh6E15bHDsv1+siNHsxuKC0cc+wdgNewdzSz9C3xjcHrdnmMirbQjrVr28bxfYlhQdPol8YePhWFHZVYJMYICYxuyHHSFIKfnaKoA6H7IjXDdik3iyi1LqxkcJr4D3fLTnFvVP3tH5UoTB/VbjENLybHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+77oSLVIJZd/aqcDFwEqTDJmmMMWge0J6jPSYVpBLQ=;
 b=bm8IlXHrzNMU25awKWWNfJcuOij4UZPn5wCkJMOM/ncfX4/T/pRISJjZYs2nH1IKp/xkql5rj9PN/hBnAN7hGV6vnhnMGU9Cms+qjkyOSRhCn414XLjdAAoI3Dvno0kfVuyeYfaSiDqyaKkfrqtPTK3+Jrk9x4RKn/4QJ5md3sM=
Received: from BL0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:91::34)
 by DS2PR12MB9800.namprd12.prod.outlook.com (2603:10b6:8:2b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 20:11:55 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::1d) by BL0PR05CA0024.outlook.office365.com
 (2603:10b6:208:91::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.7 via Frontend Transport; Fri, 3
 Oct 2025 20:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:11:54 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:11:53 -0700
Message-ID: <1328e810-3093-4d96-8b9b-5e52bb524458@amd.com>
Date: Fri, 3 Oct 2025 15:11:53 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 06/25] CXL/AER: Introduce aer_cxl_rch.c into AER
 driver for handling CXL RCH errors
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
 <20250925223440.3539069-7-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-7-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS2PR12MB9800:EE_
X-MS-Office365-Filtering-Correlation-Id: e27ad90b-ea30-4eb0-b59e-08de02b91951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFc1K2JJbUgxR2xueWlNN05zeGJ0MXUwc0lNMkExRk5NUzBucG1ZMVNkL2sr?=
 =?utf-8?B?TTBZZEp4Y0lMTWpLbGpET0ZvUFR6cExKc2xWbTFVWXNPZkQrNk5iK1RyUG5F?=
 =?utf-8?B?cWF5bkZDZjhETXhVRnJPWjJXR2RZaUd5SVQ1Q2JIM1JEd3NrYW03V0F3ZkZV?=
 =?utf-8?B?VERiMWJ6bGNnUWFvYk0yVDVhYzg4Q3cveGdtQTVpMGd3T2ExbkNvcWhUcUVt?=
 =?utf-8?B?bXdwaDVDUGxGQy9aeTMzWldqRDJGb3NPODJxSElyOUJsTkcyQmg5M3UrRU5L?=
 =?utf-8?B?eTN6M2NpakF0YVhJVFl4T3lyRkwwYWtYc3lHYUpUY2dhR1lJMzVQNWUyTjJ2?=
 =?utf-8?B?RDVlTHdxOFpjajFVa3g4WFZmNFRaenRTVDhFdmluZ3pWbHk4MGZoTzJpWDhP?=
 =?utf-8?B?Y3N6SGVHSFhHQ29EZWtCMksvdmxrNXdnQWkzR0h1WHh3dDFKeEJGeVRtd3Za?=
 =?utf-8?B?UEZENmMveWVXamdlUTdUVXVkOGE3NTh5Z2crWG5JUlFmMGswOEtLSkVuWkQ1?=
 =?utf-8?B?K1BQZ2xVTXZFc1dEemo0bmJOSjZQeCszNUxKSndGUHhLZDdKSTZwRU1DR2Fr?=
 =?utf-8?B?K0NxL1NIS0RBMnp1MlNMNE1NYnpJWFpTek42WDFNREl2NjdWb1kxZ1JFY1RO?=
 =?utf-8?B?eUhCaFB6OGtSMVBhTlB6Y0VMYk9INGJVL0JRRkR0K2hDdWY2TFdIR203S3dn?=
 =?utf-8?B?VGdCNStyK3gxQ20zTGJadjJkR1hFa1dPVFFyeWRMelBtUXFsb3BYdkNjOGhH?=
 =?utf-8?B?d0Y4eXpnQ1V1K0huSk4xTW5jcnRzbFRsYjhOU1VvUzFSUkwyMXJaZ2o4REQz?=
 =?utf-8?B?bktiRExOcU1wd2laNDc0c2dhTGVDK0ppUGczSFFsWGJyZVhFZXdGa2UxQm1j?=
 =?utf-8?B?anRteG1OSHA3TUZJZzVpeTU1N0ViVEJ4SmpXWXVBeEJFU0d1QmE1Z3hIdGRN?=
 =?utf-8?B?akplbk9oYi9hZGJPR3BuYVd6b0VvbG5GcXc0M1NwcDFtbzErdm1lNldWZEt0?=
 =?utf-8?B?aldDRDc1cFIyMjZBTjA4V1FTbHFWYXEzUVZDUHY5K2hRRXI3RlNVMXE0WFpt?=
 =?utf-8?B?L0lLMGMzVDhNdUNqUjE2blNvaU43TnUySGZRY0l1TkxyZXBYUEZWbDljU2pR?=
 =?utf-8?B?dDZpaEprSUR6N0UwOEtRR2dlcDVQTGwzU3cyeFNwNTdFRngxVXViQ3RhRHd4?=
 =?utf-8?B?emFzaGNHZmJwRFAxaDl3bmJtSUNLZndZUE5nbUowUjgzRG9WQ0pDMlF4NlRz?=
 =?utf-8?B?VDMzaG0zVjNyWnRxY3V2Q1dUcjBIWXczY0NIMnd5dWhlU2ZDckZhV0RUTWJm?=
 =?utf-8?B?VUtCYUxLV0UyclVNTmhINWpKSmtYaDkxL012RTBRcFM2U1lEaEpxVm8rSEhR?=
 =?utf-8?B?dWFJaDBwV3l4Z1hWTEdpdUpReDZab3FXVE05VVhGS0hwK3JsUHJBNWRpSW90?=
 =?utf-8?B?MFNjT0Q1MFZHZExLNHRCNEFYZ3Ava2JvcHRmNEU5UU1BL0J0ZTRmMGpJalNz?=
 =?utf-8?B?SUlRS3E4cGl5K1RKMzdyOXFTdUpzSFp2RnJId1YwdDVIK3UzdjVkM25tSEVP?=
 =?utf-8?B?OHlNSStlSXlXNXYyMUFuU0dHM3hjd0FFbUxsSVlsb1RzVHVBK1Z2MUhHRkFP?=
 =?utf-8?B?RytIYUtYNmlJYlhBdTZTY1p2RzhJT21HRzdxVitUd1hqdU1OL1V0S0Y1UXpR?=
 =?utf-8?B?N05nenoyTkhtK1FBK1RzL0hQVTFaVEhjQ0k1RnFMUUVHdkw1eUMrZFhmUE9D?=
 =?utf-8?B?NE55MGh0NjcyTDhYNFUybVJ1V1VnRzV4SktRQ0cwVFc1TlRYclpZUHpVY05t?=
 =?utf-8?B?QXdVSXVhSk1GREZmL3hHckMvNWtyZnZzTlZBbG52aTRlNW0rblZOc3lFQ0Vs?=
 =?utf-8?B?UUMzWFdVZnBuQjRKTVFkK05YNG9XcW9ueGt3TlpQM1VkVmVzSG8wMHROL1U2?=
 =?utf-8?B?UllxTC95TFh4WUFoSWJZWFl3SVU4MFo4ODV1L203WEc1L2VBQ3VGUnUyY1By?=
 =?utf-8?B?czZrRmRpcTJMcU91S0VKZXFFZzBiOCtOTDZTeHkzYXZhSytXRWhCNXpkU0J4?=
 =?utf-8?B?d05RRmJnamFNMUE1WURzRmZqZkZrOW5kMTdHTExqVTJSY2ltbDJkc3pxaFMy?=
 =?utf-8?Q?eDI4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:11:54.9743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e27ad90b-ea30-4eb0-b59e-08de02b91951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9800

On 9/25/2025 5:34 PM, Terry Bowman wrote:
> The restricted CXL Host (RCH) AER error handling logic currently resides
> in the AER driver file, drivers/pci/pcie/aer.c. CXL specific changes are
> conditionally compiled using #ifdefs.
> 
> Improve the AER driver maintainability by separating the RCH specific logic
> from the AER driver's core functionality and removing the ifdefs. Introduce
> drivers/pci/pcie/aer_cxl_rch.c for moving the RCH AER logic into.
> Conditionally compile the file using the CONFIG_CXL_RCH_RAS Kconfig.
> 
> Move the CXL logic into the new file but leave helper functions in aer.c
> for now as they will be moved in future patch for CXL virtual hierarchy
> handling. Export the handler functions as needed. Export
> pci_aer_unmask_internal_errors() allowing for all subsystems to use.
> Avoid multiple declaration moves and export cxl_error_is_native() now to
> allow for cxl_core access.
> 
> Inorder to maintain compilation after the move other changes are required.
> Change cxl_rch_handle_error() & cxl_rch_enable_rcec() to be non-static
> inorder for accessing from the AER driver in aer.c.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
With the build bot fix:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

