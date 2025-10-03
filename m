Return-Path: <linux-pci+bounces-37577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 102C7BB809A
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B32964ED5A5
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F2721D3E6;
	Fri,  3 Oct 2025 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bqc9EbXw"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8856244660;
	Fri,  3 Oct 2025 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522310; cv=fail; b=JX8tFkDmm6KTXTqSnCjT4fTztD1glYDmjqOGK6KrZ70evYmbWG1BtPx6ZlyMAOJOqtlXno34B0QO54pwtZ04wbQkNgVHQi1efxIEdBpzpe6M7P/HzUHBwecXCs5XJlmsQO1La5ucKOU9S8ryMCOyWPtXAqFYqXGXwYjKZpCrXCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522310; c=relaxed/simple;
	bh=6HvgtzyspfkdsWnC/wVeSQwPZrqdL4eoqb3PR3okwic=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=UUbB5ze1hl3man5AgQ8sBZzWJT/c8SxXGdH1dyx25KAOLxKouKm4G8w4aQX9vOV+XASVymhYykv+hQjYkSYGqx3PCvRVdSxKjOTqiknPSRM0W+orgOUFkcGh1nJl+OZKX+Fte4whYXDEFbr6OxjJFXWgn/+jNe2BfPRWqQ8ku+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bqc9EbXw; arc=fail smtp.client-ip=52.101.56.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTavcid3pZh76vUmqEBASPfpM2olif0CO6PJZLkstR/qfH5ZpkLWX7KcLBAKWzvyfRWmLPYk2s2LeaNpgnX/X/vDmnOSpab9p+zqetrWlKnG34flHtVwx4oB29hNX3T/l8VGqgiVQxyyHx3753KTgisWWbxjZpLMTiycD5QxrpsnYfhyxNu8qRD70vM0foE24s0EaztF82ZOUYHcKh95xrJAdPSD53tNqvh/VND6LqDZ+l8wdoHkKp5G5GaoTfD0HOhaYbQfRDRNB9Zvyox2BextF/23lvn8B3lJf4jnk2GacRXl5bDw4qb/dt4XnBzWvsD5tEwOZdMXAudZCyzePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vU2Z3CViS45Mtot6KfLkt2MkAIQBLqaQRxAPehkITc=;
 b=fivJJrDgg4rxn5yh7hyhmvoVeF0CAfhG/Ufd3dLFjyr18jI3MMp8FoAbkYLJs83t2tpC6Ee3hoygHmnlw92oiU6EaNDlZqu0P/5PEejHG3tIjtsClhpTXcozs8SWvN5+mxWHY5DPlOi4C2He909PvVTyKU5/DZXvWCI0ny1Z0d4HTg2iOgXm6+m1j7NYUAgGjR0OfWQJUtXomer5P4OFCtFzcRfqHEtn5m1og/7Z9iuJSpt8RvC0IVaiTdRJUkYk7hs5+GmoJhYOz9gsXPP7E645nF4ofZgml2fzUjoq7HeLQfPWNuaQppN0Y5NMF9EPGwMCgGHwc8N3C9Jo5SCRJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vU2Z3CViS45Mtot6KfLkt2MkAIQBLqaQRxAPehkITc=;
 b=bqc9EbXwr9yhc/7UuvSIp1SRJPC7SmCc3/RIgusuJULdCvpICNTR7Gpx3twt98AdX8BBAUkqROm9iQwv2rU0eQ3eECxr4pEA/TlOXbdBcZ1DfipI+27DjqYiXRODpJ1WP7L2sExdiFG395BPyP2cOvybpSPTHJbBLcIejzUx0qs=
Received: from BL1PR13CA0346.namprd13.prod.outlook.com (2603:10b6:208:2c6::21)
 by BN7PPFA8145BD40.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 3 Oct
 2025 20:11:41 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::20) by BL1PR13CA0346.outlook.office365.com
 (2603:10b6:208:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.7 via Frontend Transport; Fri, 3
 Oct 2025 20:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:11:41 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:11:38 -0700
Message-ID: <902d4d78-4e34-491f-a830-c24c51c45e73@amd.com>
Date: Fri, 3 Oct 2025 15:11:37 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 11/25] cxl/pci: Update RAS handler interfaces to also
 support CXL Ports
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
 <20250925223440.3539069-12-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-12-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|BN7PPFA8145BD40:EE_
X-MS-Office365-Filtering-Correlation-Id: 955965ff-0bf7-4c53-82be-08de02b91131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUJXaDNkWFJFWG90M2lZVDdyREFabk95bVdaRDBIdDB5OStPQlgxaVZQZElT?=
 =?utf-8?B?NnUrVFNGM0VXR0RqQ0Y3Z21zbzVCNjNvMjA4NjNlaGl5dkNxb1lrN3htb21r?=
 =?utf-8?B?QTNiSnoyTWZidEJhRFRjeTB2QTNFVUdINGVNL2UycERDYzVEOHNVaHBZVTJ5?=
 =?utf-8?B?c3dtcVBWWm5ZNWFMY3JvSThSYWhtSEE0dXhVdFAzR2FlU0NVMTliNFFWNXhP?=
 =?utf-8?B?ZXh5b29MdzFVTndJdGJWdFNILy85NERJQ2p2RGlaem9LR0ZKSVhNOXdibFly?=
 =?utf-8?B?Znp4S1k0YUU3ZVM5NllRK3NzbmNXNytPcGxUTEs5OXlJQlFPbkdKcVJqSnNi?=
 =?utf-8?B?ZlMycEJqSk9CTHVmWEs1RHE2RUZNYlJ1TUVwVXRUek1UdElaZGJLeW5aVU5q?=
 =?utf-8?B?RXk1RzFWMGRseG8vekU5MGtodU52dTVwcHRud3luZWQ1ckR2STFYbS9uLzYz?=
 =?utf-8?B?Qkc0U2s5Yjl0YXBRem9RUndwTFJBZGVSV3dQU2NFR29qaWlidjB5ZE5yU2l0?=
 =?utf-8?B?Q3ZXclFpK2J4ZkRwQ2sxaURKcGxjRHFURXpYeUd2aU9xeHU0M0hjVjBCd1dZ?=
 =?utf-8?B?c0dVSUdWN3QzMG1vSWNPcGk5bXg5YTRiTElJUFdleCtUVkVZb2xYTmRMbUVP?=
 =?utf-8?B?TmVoaEwxRG0zSTRqeWJ5UE1ROVltR2NrdG9PMk5ZMHhSdGdTdXFlVEN1ZFdr?=
 =?utf-8?B?aHdXTTFNNmhpTjF6SzFTNHBUQmNVbFdYRm0wZ3RGRi9CYk91dHdwdGdwRm5y?=
 =?utf-8?B?Y2JlK3ZiTHlyWm1ZVWd1cnE1eDZSTHV3VlBta3ZFRU5yTTB0RnhielB5Y3g5?=
 =?utf-8?B?VGtlQW1KbmljWEtlSXluV1djQnBZVkFqU203RGk3VE5kdzJqT1NsaFhrbGx5?=
 =?utf-8?B?QVdHcWpvZFM1R0pYME9kZUppMExab2lBV1YwUGdDNDVOTWt2enVqbm5nTVpy?=
 =?utf-8?B?ZlhwcVQzU1pnRTNMVVZSRDN5OVZXQWo0bmdSTWRhbUdDUlRRYlhiTFFiUnMv?=
 =?utf-8?B?TDVkdTdlQmphWGZQSGswV2d1WDYybGwxZVRUOVNBRnhnY1l0K0M4WHkxNFV3?=
 =?utf-8?B?bDBnUTdrSFRiVkNQYTNmZ3hzNGJ1R016UXcxanVIZ2k0L0svR0U1VGhhZEJk?=
 =?utf-8?B?MEFjTE1mRWc2SjhBb21vVEFzUDU2UEhaLzltOWVTSXBYYTdtUW5tbmlwbmZU?=
 =?utf-8?B?M3RiQ0VWa3ZMSHhGd2hUeVZwSmtRenRzS0l3K3NBdmYySnRrZ215SmJWTmJn?=
 =?utf-8?B?ZzFlMlc4QlBkR3B6d2hJVnB3dDdEZXBjeU10MUVvUXVHLzdLTmxYSTJBeUJa?=
 =?utf-8?B?WU1MQjJqNHpIQ1RDMExhb3l4QjM0bDRncUtDNERKeE1pbTVITlRhdkhqdDNt?=
 =?utf-8?B?cVNhNnNSc2huZGozMUJoRHRtRGk0RU4xT240Z3VVc0pJRTVPUVlYcHBiQ0FZ?=
 =?utf-8?B?WXlNR2JHdnFYVTBmUzQrSjEvNjYzUUxFTGxUWlFQdEpTckNYWi9kdWZpbERu?=
 =?utf-8?B?VUc5NHgvMVo1RG8yemZocXkvWkV0M2xxa1p0aHBDbFE3K0FmQ3BTbytHZVgz?=
 =?utf-8?B?Sk4wdVNsLzlBRTRDdXl3ODgyTGtJNGR5T1hvNG1KNytiekNvZ2puZDA1WEhL?=
 =?utf-8?B?RW1hN3JEb3hrYkdmSGxuL1VPQW80bFFRVnlEL2pXZmgvbXJac2ZVdW5Oa2FF?=
 =?utf-8?B?Zkx1a0tHR0hjT0wzNjZ6K00rbUErMnhOMXViWGRaWEhFTHVsSDU4V3FvTHpq?=
 =?utf-8?B?dnJNU1NWV3FYWU9acTRqaE1hMldKMlFsRE9oamJsSlZ5MCtlb3psMENFOVBE?=
 =?utf-8?B?UDdFVk1lODFhbklna2pvWDZkTDVqb0F6ZkM4Sm9mdFUzMGhwc3JYR29vdEI5?=
 =?utf-8?B?b0pSajFoTytZU05acjdTbGdSMnZneitxazhkSTFkd1pxbUZDTkcwVjlRblA4?=
 =?utf-8?B?Y2ZsTHZ6YmxhOVljaHFCT2MrZ1Q2R25jTjA0NjF6REVCd2o4QldSN2Z5N0xV?=
 =?utf-8?B?THN0K1RYOVlWbE95SzJKRWlMbVZvbHAwYmFRTGwyL040NVdvWFUxK1VlQm5y?=
 =?utf-8?B?TEd6VkdGLzZ2OVpNOSs1Y3RDSTc5cDBQL3RYcU5aSkJvOEl6VG1TOHFjcFI0?=
 =?utf-8?Q?/Zq0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:11:41.3419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 955965ff-0bf7-4c53-82be-08de02b91131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA8145BD40

On 9/25/2025 5:34 PM, Terry Bowman wrote:
> CXL PCIe Port Protocol Error handling support will be added to the
> CXL drivers in the future. In preparation, rename the existing
> interfaces to support handling all CXL PCIe Port Protocol Errors.
> 
> The driver's RAS support functions currently rely on a 'struct
> cxl_dev_state' type parameter, which is not available for CXL Port
> devices. However, since the same CXL RAS capability structure is
> needed across most CXL components and devices, a common handling
> approach should be adopted.
> 
> To accommodate this, update the __cxl_handle_cor_ras() and
> __cxl_handle_ras() functions to use a `struct device` instead of
> `struct cxl_dev_state`.
> 
> No functional changes are introduced.
> 
> [1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

