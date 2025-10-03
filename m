Return-Path: <linux-pci+bounces-37574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC34BB8079
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE6F19E3C53
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDF41F3FE2;
	Fri,  3 Oct 2025 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nYWO54A9"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A317A2E1;
	Fri,  3 Oct 2025 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522292; cv=fail; b=AzseMUzdHoyp96cJrb1VsxkThyDrMC6FvpnnTAnHu2m9gJopxr6P1tbin0o4xvF/ptgaFfo21btKSaSThrhHneAb5eB5keGix7JCouxY6T+j/ex8Wi1JD+Kwyz145bBL/f8emypaI8XGCOYCjqykudz1L9s7Lw2KEJzQS0wfjak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522292; c=relaxed/simple;
	bh=SG7OVOPfHRmz4QOQ0SqINT/jOmUblWgBsC4c1H0cIKo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=r0vUd0tFM3IIfR4dzT8w5TOVt4EkYcmruJQLhXzU4+ERa4lweh7t/4nt14QsqaQwaVS1/b6jS4O6XpwVj0sj9tMWDsG2xZHn1ZOFOumF2Ivrw7H2HFoC7DL8H07yDJDMMa01OUtkgYmnGCvoAG8FDLEAJi4W1c4bFZimVDY0MxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nYWO54A9; arc=fail smtp.client-ip=52.101.193.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lK4EdjFtpvvvq/YVPb6E3Dy939MZlYiVCUJV7rFpObiRc+lkzqVZa+3tfq7KsTkwoSi/pdC5V3i8qz6CW3PZyg1GyHB/KUItzcuUnXJOsH4byDx5EiGoioPNrnqnHf663SPK8tCHB9yanv9vYbyP9M2wfeMXebpALyVz21/4FvhFW55spr/0vxBLUhGnvSdCdnrcqbO4/BgWE5JhEjP7Ml+NGCGiORhcjD6A0rYok30fb4mGEoz0ZuQmnfOeAoAO71uyAG0MH1zRcxJ3oVhXMfgm3B/3reipbpibuz2gBODtPB/SasU7L5xuFhtaLLxvNq5sdWqhXdzpL11V+zMRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20ybNR0KIK2Z8Y3xDCs57yoRTW/pmxqdt+ZFec1bh4g=;
 b=qd7vXrh2p7yyEfa60XF4TFR8Re6DAIr3DEjFazq6ru1wkr3NiF/rVhwHQHFd+97hu+8M/Rni5vqv77BVvDD1WfcLqEWkFSv+FSaFOCuNeSY9rFJoIyQPl94smM0pPRlnVFY5lEg/BY/ZMF2jUp/swRpfbrKFOq3qBgcypca56ATbl1ytWBsB7NIHL8vg6/dRyW2uNwLt214x7Cz5TO3BGWu3V1UyaC8xB188G1Ol588bcHs4NIMvH2LAJczioD3C0VKxVQpCLWkEEYYXsKgepsWDvaHbMO2G8ogj0hY8iWQMtJDjhIzUBYoH4CaBv5YeEJYFrZBLVPZF78iluwfp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20ybNR0KIK2Z8Y3xDCs57yoRTW/pmxqdt+ZFec1bh4g=;
 b=nYWO54A9t5yS8Yaw0bsx1xyZv9G+WdiyNJlnQXLMF99lKgXxLSVt90kbs8vySxI4ZiPe+O+F/wQrU48ZMVT6Da1gf0gx4TzrtGOlpDFsCrnch8V62Ct7oIAA3oGiE7RwDtWk7GxMNyGguVA/1//vd+IcrUjsjSm72nG9uhF9vuo=
Received: from BL1PR13CA0356.namprd13.prod.outlook.com (2603:10b6:208:2c6::31)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 20:11:23 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::7) by BL1PR13CA0356.outlook.office365.com
 (2603:10b6:208:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.6 via Frontend Transport; Fri, 3
 Oct 2025 20:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:11:23 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:11:16 -0700
Message-ID: <1fce1895-1444-443f-8342-b3244b59d06f@amd.com>
Date: Fri, 3 Oct 2025 15:11:16 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 03/25] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL
 from core/pci.c
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
 <20250925223440.3539069-4-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 341eafbc-e3dc-445f-8b60-08de02b90656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEtxeVFBdHl0VTNhMlk5NzBWMzJnT0hPejk0c2pyM0tUdTNuanpZL2J2Z0hS?=
 =?utf-8?B?Vk1YU0ZWWHVvY1dzRXZuVlQ1WThIeWgwcms3bkF2emtNdFppQXpJbW9VSzdu?=
 =?utf-8?B?QXRnNHc0T2F5MmNZRGZDWnNURDJGQ0pYUjYrT1NNd2dkWXFlV2JkeVVSNUVk?=
 =?utf-8?B?enlmQ2hNTzFvQmQydTl4MWJtU05HYmRoT21CMG93cVhhUFB2T0Frb243VWRz?=
 =?utf-8?B?Ym5EdE5MYjJXc09LUzFiVFc0TnVhdjErZDRLSkNSelNvSmE1aTdCdWlxMFdn?=
 =?utf-8?B?ZC9iazl5dExlN3pUVlJLM1dhaWJPMTFuVEFyT3UwZVdOd0FLa01Gd3JtQkJn?=
 =?utf-8?B?R3owM0xTb1Y0dUEvb0NzbEtIYW1tNXZOb2dyZ2ZRalF1QnZQcVJOYWNxSzUx?=
 =?utf-8?B?S0p3d2FGUjMyc1RrZmlOSVZWTEFqZjBUdlQ0ZEoyVkpSRW9RSnFja1NCV3VV?=
 =?utf-8?B?TzhreFU3WWk4aUJQUTVXQjRDa256bFV3VkFXZTU5ZHliK1dSWnQ2VWZlMEdr?=
 =?utf-8?B?UGpOZDRwRUpGbXluMTFQWjE2enRKWEMyWFN3emNqODNjazZBQzNtcmJPbWpu?=
 =?utf-8?B?Qk5FKzB3YnNWYjV4MHRWbmdhM04veEV1TzhqM0IwRnM3WmQyeWZPYmk3dytC?=
 =?utf-8?B?OEpCb1prOTk2NjkwZVJVQVJVZVYvbzBGbFpET2picjF5UGhUYTJMZy93Z0hx?=
 =?utf-8?B?U3BDSFFCN29keDdnNmhPSzFHRGs3aTIvbFlBb29lUGM5QXFacTY3NjVGNmhT?=
 =?utf-8?B?a2lZQ0NnRjAxYmdOelAxMEJjY1ZuR2xVTVNJMm8zbjgwZTdkVDErQUZLOEh0?=
 =?utf-8?B?ZmFuWi94REpMQjRtVnR1eGVtVHp0WUhQSUp1cUYyYlRJTW5Xemk5V2R0bGkv?=
 =?utf-8?B?UUFIYWM3a3VXRWt3YzBid3ArZElycnpnUStZaGNLRGJ4STBocDI2QXlPVHlL?=
 =?utf-8?B?UDFvNFlNWHk1a2tMazVNd2pEcENFcnRHcDRCSWNuZ3BudWM5ZXBQNVJzRXNt?=
 =?utf-8?B?QUwrY3dTdWc1eWdiTytnOFAydkdyZjlhcmZQdW9qM0JHT0Y5WGwyZkNwN3FG?=
 =?utf-8?B?Yk41N3BFNEhoTTRpSFBTR0NGN2NWQndBVVozUCt4SUMzKzlMTXBkdWsybVpz?=
 =?utf-8?B?WEFSdlVvN2l6bnd1TDllSk94eXFRSXU4T0RreWFmdlUvenJLaXF5cVFpM3Bk?=
 =?utf-8?B?dmZEN0R2encxcWRvS1BlZUhOVkNaUnJqNXoxQUpXM2dQSUhra2IrNmg5dDJx?=
 =?utf-8?B?RGZBMnFtL09XbUVHdkJnRDRBbEFzL2FjWll0M1J0bkgzbFRsVWFwREFKSVRi?=
 =?utf-8?B?UnIwT3dic1lHb0JBZW1ZdDFSZzlmTFRnWkNGaU94OXNOaTI0dTZxMUF1RUdN?=
 =?utf-8?B?VE54a1JHdjZjVjlVVGRBMzgvZUpsMTY3cTdqNU9QK0tmMmVaR1hUMTlzamlk?=
 =?utf-8?B?WmFETWNTbnRkV0pKMUt1N2pCUE5uRzdaMGtpY2xsd3YySTVSOXU3NGZNSDdI?=
 =?utf-8?B?bnp0YUkwMmVJdUkvU1lxeWJvQ3NTbGZ4TVNlS2xTMzZESFRqYUdvZERKV2Iv?=
 =?utf-8?B?OVUvWnBNNlIwdjhyRHlQa0J2dzgrZUpRcE8waTRRMUZqZGo4Rzh3cHNIZmJU?=
 =?utf-8?B?VkUwRjRvcXpNMEl4Tlk4YkpxeDZ3Ykc3V213MXhhUG4vcElUdlR3Y0lZUkRF?=
 =?utf-8?B?d0l0RDZhUElHSnFKaWJ5ck5IdTg3dkVhQkFrNFJwU0c1bE9RWTZzdm43R3J1?=
 =?utf-8?B?NmRwQU01N3dvWUNYVFhib21sSjBzanJCM0RnTzVwVk82cE0xOHNsaTBZaFpm?=
 =?utf-8?B?ZjNLUzRHdUJhWDNHUk1ZK20xcWowOURIdUJVK0RoL25SVGpKbEpIa3Q3U29Z?=
 =?utf-8?B?cTV3MThWQ0w1Y1ZRYjRIaFN3cU1lMjRWUzBmRC83SitYMXhwNjBVUnZUOTF2?=
 =?utf-8?B?em1JQUlTSkpTWjVsMUdBVnJMaWlNaDVSemgydDU1RmVVMFcyaDR1a0pOSFpL?=
 =?utf-8?B?ejg0eVU3emRZbDNVcEQ5VkJBMmVlSXNJQnRqNmV0dGdnY24rV2hpZE5KemY3?=
 =?utf-8?B?cW5IdDJIdWxtZmVoK2xHSG1KWmh3WjRzaGtSQ0w0L3RkV3YvY2lDVzcxY3lL?=
 =?utf-8?Q?0MGM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:11:23.1272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 341eafbc-e3dc-445f-8b60-08de02b90656
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293

[snip]

> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1fb66132b777..9f4eb7e2feba 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -144,8 +144,20 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>  int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  					struct access_coordinate *c);
>  
> +#ifdef CONFIG_CXL_RAS
>  int cxl_ras_init(void);
>  void cxl_ras_exit(void);
> +#else
> +static inline int cxl_ras_init(void)
> +{
> +	return 0;
> +}
> +
> +static inline void cxl_ras_exit(void)
> +{
> +}
> +#endif // CONFIG_CXL_RAS

Nit: Comment style is wrong for this file, should be /* CONFIG_CXL_RAS */

With that:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

