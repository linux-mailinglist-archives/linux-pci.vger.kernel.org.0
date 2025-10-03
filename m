Return-Path: <linux-pci+bounces-37572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DCEBB8073
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315194C40A3
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24471218AAD;
	Fri,  3 Oct 2025 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DTHuUuXJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB7A1F3FE2;
	Fri,  3 Oct 2025 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522278; cv=fail; b=FkSVgKhJi1UHkyKcDXtemUdJdNFx3B+C1/ybT4hEVqaZyHLcQuu28+2B1nOoLkqnbZ0X5/mWT0VuXe3L2+WNuV+zry4N3sq/OTG8v8uejstWDFV36HtL1SFvrqxzG0eingYJgwFTmKLCneJnz4gEFKCc0hMSdaTIblhTPVl77mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522278; c=relaxed/simple;
	bh=nNbmTLwm9mX+VfbDyoqI3ZyX3D4zyRBNl+yOUNlWrz4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=h5vUnU7aFFMDR4DEEUKd5keEQoHPUJCl6RqfDsg2/vIhtWoi8EYmaBNkdXWjMRLrbI5fDa+5vRh2GIwZ7VT35rFzKZG7zKWTcpkMQxkQ0qYPqP6FDePWja2aCKEwkjMN1dIOdwMXUTeuRD5DRUiMlF2KoPXp4pWIxn/wG7ThZbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DTHuUuXJ; arc=fail smtp.client-ip=40.93.194.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMSXhG1vfQO3kGbAPYbimiyHtJgMRzs7liGZ0priKvRsbl7bKce2Zu2gVW0IVVU/ePUDi7ovGAUUkHcNGttgI6VUm6z0/AVzKkh7bcGh4Nm/JWlNe8TlyehzZlpxv/O6hXBs+axnAOOJPQ34IfAI5fpo1Izu21LeDY05l8kaUi1gj+Uep2G9WBqDc15QsS3wZslqIXFB5oXEwwpo0E+ACaRUWoegVed6GSYDSW/yhzymjBcmj4n2uxGH1JqlOtUucM1FjnKeVs7B4OUAfr+In/jTgvixKSAiKTFapa8ZS00H3mPsleRh0ZqfPOeMvVpi2ryz8MekC0bRy59QgItHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Fwt3F1KY+Uf5rrLo89lQb/TwIh5WcGB75wPJrvqyfo=;
 b=KQNvOtSqq1OodqD9b3zqq0Rj29vpQRm3L/hcyyqEaQW1TIur4YGSpC+vSlu9KnKYw/Qy6cl8iearTKTj5kQKftGul8Qfkw5iYdlMdzw1xolIxODzGA4S9oIpSh/WdHwzkMm8kSl6Zweaem17v1UCBOy33GbflPrnl/ZSr6S3yBrFD37sKpjrPhLSygVIi7xeLJ6cd2IxDHhrFhKrEZ+SoWMHxcRE0eWfrpDU1VEbGlSL1el5/5Y87kCWvbnLUyLdUq7U0PbE3rYKVOZAUiFUsi9+FjvBYkPvUNTj5+7cwYDFhdjSEQOuHudWJuELY6M5+z43rpxTBxROlWk1hUMFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Fwt3F1KY+Uf5rrLo89lQb/TwIh5WcGB75wPJrvqyfo=;
 b=DTHuUuXJ5xHL4sAfT0kmZF6SECCS2ILtw3x4tlCDSdas8gPXhZMtyiclpo+qqWenISYwxbfXjkXptb4topnrzZPTrp2Zy/iZ2bMOtMCxy7B1rjK1Y8Uadkti2iaOgyHsa7884TgMD3WmWPx/UizaVRbY3B2Lq2o5B2fxich3MsI=
Received: from BL0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:91::15)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 20:11:07 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::d) by BL0PR05CA0005.outlook.office365.com
 (2603:10b6:208:91::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.7 via Frontend Transport; Fri, 3
 Oct 2025 20:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:11:07 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:11:05 -0700
Message-ID: <c1b197a0-31b3-4321-94c0-9f0394b78065@amd.com>
Date: Fri, 3 Oct 2025 15:11:04 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 05/25] cxl: Move CXL driver RCH error handling into
 CONFIG_CXL_RCH_RAS conditional block
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
 <20250925223440.3539069-6-terry.bowman@amd.com>
X-Mozilla-News-Host: news://news://nntp.lore.kernel.org
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-6-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3af8d5-fea8-4092-bb52-08de02b8fcc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUUvL0lUT0hIMlMrdVczRTIzb3dEVkwvWFJ1Qm1XWFlDV2lzV0hrbkxoZ2pP?=
 =?utf-8?B?emtlbnpaUVpqYzVTV1FTbTVhc1oyU0h3WjF6MEMySUxHOVhnK0VOb0pvOFcz?=
 =?utf-8?B?Yzh6bWVnbEZFRTNmdDJhQ1BlVExnQ0pUaHhxLzE3dFVCVm81UVFybDJtaXZ3?=
 =?utf-8?B?YWdMYWs3QnVNOXh4bkpvUDVKM2VOTHluOG5oeGIxSFpjWmlHMjlNM3ZwRUhJ?=
 =?utf-8?B?dGxsUk40ZmpQaUExMWFXOUtLZVFNRC9PbmR0dHVZZ0NTWDZXK1ArbzFxbGlr?=
 =?utf-8?B?c2QvcFdEV2UrSU5pSHFVM0R4cnFseFJPSGk2WnBLQ09HcHZsYlE3clprcTJO?=
 =?utf-8?B?WVZEaFYrZjRMazZvaWJDOHVkKzZ6dFdMOVFUQ3RpWUNudjJNbDd0TnFZOWFq?=
 =?utf-8?B?YWh4REtqV1dzYTByZVJvT2lucnZGS2hmMjBHc0JsNXBHc1VVRHI5Y0lKdTVM?=
 =?utf-8?B?NWw1TkhjQnhkbkdabU1XK2UwZmdEeGFPN1ZoeTJxS3IvVVYzTHRXYUNSNElE?=
 =?utf-8?B?Q1lxRkJDbkpYZm45NUxzbG9mTmFQK1laU0UvMkRLUGM2bVRoMHVERkxYQlI1?=
 =?utf-8?B?am5JLzJ3N0xQWFBxY2ZrUEVhc3hXSFM3N2U0WkE1a1R3M1RCaTQ1ZXd2eG9v?=
 =?utf-8?B?eDRqajhRMFpCMnVUNGViM1VQTzlaYmJ2UENCS2NnR0tVTTROb3djRTJFbnlT?=
 =?utf-8?B?SWduYzFSUDkrZmxOMXp5d3gyZmZXUTJ5S202dmJsRG5QaU5WSXFoOHM3SjE0?=
 =?utf-8?B?V29BMThOdXRXTVhVbVBHelVrVmhIaEw1QjBVZG9hd3BlUEhwSE1ucXBibjlq?=
 =?utf-8?B?SFVZNVpsOXNpMEVDSXJlbEZyL2lva2ZMS09DSVdqRDk3bFZpa29YS3FJR0FB?=
 =?utf-8?B?NldJbUtEbmI4T1JyWGxXakRmV3NBVWgrblJ0RnlvZms0eVcrRFoxbnJZK2c2?=
 =?utf-8?B?WGNKc2s1bFkxWGJmdmxUYStoNG1TZFo5em8xNENwK01yQS9sdENGbTNBSE9Z?=
 =?utf-8?B?L2VLK0ZaUHprd1IvN3pMdlRmS0czWVpaTTBGekwyNWVLalpxZzFWU3I5bjZK?=
 =?utf-8?B?VUE5VjA5dmsvcHRnWDQ0V2g4b01tQUt0MFBPTGw1RHlIL1VFOU1pTGF5S0Y1?=
 =?utf-8?B?bnNHYWJHa0ZXNmFackVjdjV4RFRReFp4WEtHV1Rsd29veGpMdkp3dXBJeEEz?=
 =?utf-8?B?RWNKTloyeEJRMkZkVDhqQUwzRmRSRXdwMHRwTGp3SWFYRGtKM2tlTnNmY0V6?=
 =?utf-8?B?eW1IQWM4M1JCd2tjUERTYk02TW5JWEJvRU9SYis3WTlkWUlndkd5NzhqUURK?=
 =?utf-8?B?cGtIMzBrKzlHODV4WFg3b0xOT0xrWUlyQ0FHbytzc1FCSzVmTThjRm0yd1k3?=
 =?utf-8?B?clpUMFFyK0c0RnJGU041eWMwblBLd2NoZUVMakMwVHhNaUNFMnZDbUlkMHRr?=
 =?utf-8?B?RUtwNzFMVUt6WWwrV1AwZlhxSHZrTnNmOXBkMkdSRmpzaTJsOVEzN1BPMTRn?=
 =?utf-8?B?TmI1cjJEUVdGd2dydHpRSzZFd0RwaW1yMFh2UU82LytMWDlTOG1wemdQU0Vn?=
 =?utf-8?B?ZjJVa3RIS3hSTGwxdUljZG1CTHU0ZW4rQ2o0NzZsMGxTc1BwcWlRdWRRbzNv?=
 =?utf-8?B?NStFdnp4Tkh4NWpxZXJ2R3l1dTV3Z0NtZisvVVRSYjZFQ2JSUzRKWTVXR0E1?=
 =?utf-8?B?c3NWd1FKUm5xRWJVblpuV29PMThRclUwSWh3WG5qRUxEN3o5akRGY2lXWDBN?=
 =?utf-8?B?cnd3Slgwd2l4eGx6Zm5vZXNsWElBdkxjRzZhOEVQUnBvd09Hc3Awa3BFODJD?=
 =?utf-8?B?YkF6Q1ptRWprQ1FWMlB6T1Q4MWJEa2Q0cmpIRkcrTHBuYmhCMlNKQS9RcTFI?=
 =?utf-8?B?bktWdldvdVIrd2I3czNoZHBmMDlVdHh3UVdtcWZYQjQvYmg5N0FQdXA4a3J4?=
 =?utf-8?B?TGtWQkxJbzRWUzZoTlRlTmZubHlsenNKbFVqcm4rRGFoWHRPdDcwcVExRlBi?=
 =?utf-8?B?cEZIZXgvdDFUZ3h3Z054U0RYU0Ewak4vZlRaVEM2bmJJdXRhbUprL29kaDRH?=
 =?utf-8?B?RVViVFNkMGNTMzVWQWhsU2w5RWNNU3c5RWd5ZGhhSDhnSm94TnUrTEZtVWJp?=
 =?utf-8?Q?6650=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:11:07.0808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3af8d5-fea8-4092-bb52-08de02b8fcc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261

[snip]

> +
> +config CXL_RCH_RAS
> +	bool "CXL: Restricted CXL Host (RCH) protocol error handling"
> +	def_bool n
> +	depends on CXL_RAS
> +	help
> +	  RAS support for Restricted CXL Host (RCH) defined in CXL1.1.

Seems a little terse for a config help message. Maybe something like: "RAS support for
Restricted CXL Hosts (RCH) as defined in the CXL 1.1 specification."?

Do we also want to default to 'n' here? I realize that 1.1 devices aren't exactly popular
but 2.0+ devices/hosts are still pretty new. I haven't looked at the rest of the series yet,
but if this is the majority of the RCH support then it's small enough to include by default
imo.

I'm fine with leaving 'n' as the default but I thought I'd make the argument for including
it by default just in case.

