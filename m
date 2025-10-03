Return-Path: <linux-pci+bounces-37590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D252BB80F7
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2964C53F6
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAFA2580F2;
	Fri,  3 Oct 2025 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jh0o3ypS"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186412580E2;
	Fri,  3 Oct 2025 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522386; cv=fail; b=MSCWe/LqfB1CwdYNyQ2UMwSWtc3gdMo2ZVcK2IZ1B5dPqi8uViBgjW/41AN+hVRsfIjjnGdF9Z2gHg0nnt2l3S/jlgrmkRek1bDLmYcjZ2p/Mn5gT2tLPz2Y6xfHROuKlfEcuop+Ga6ot3UNZQ0rvKIqgozI0F+vJW7bIQAz4gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522386; c=relaxed/simple;
	bh=J2q5igbJlFk0nVoPcODHaRlB7prBGEBn2EZaMxq404c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=olGQatFn0kHjDBCsWJ/PRuXELbvi8qSxDtmcoADQUTypzU31IqtFQlEeST1spb3agf6Dte8fp8RbTgjy1YmQ0aZUcfH4MLfzHgQTkO2hQ2dxS2/wCp1+Sv84WdC4zDDjE+gu2sPIOxOJgQWodmU/V8ww6TnSG20ZtgSkExVfaCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jh0o3ypS; arc=fail smtp.client-ip=52.101.61.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3t51k5MfjfWcjaOp4EcAlxhGnIXnfE20ZtOBktkkEn4drStbl+v7S+9Wzbzkz9uj/TyE5TaVjZ8cjHwf95cjBJrVOZaSdWxEq0toJYFSc1Pax/36ycolMTZ+Tt4PwY2ZWrdz3qXj3jJTU7LaPys07i1Q2Fl19gNUeWOiACddEZe7xrkL7ZWBO2RAuFmOs+7OkqaMIiAMdd9prK+XpZVrAC9atu4FRfL/yklO0Z1auxO853WiFidp08mVoK5LjafVaTHgEF8qKF+fP2AJjGOlr4gfG2sSBgPNaOL22iJzyybdOro8sM9GQd89b7cMaajpi22hM+RWbEdd2H6N869Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOoEHxaj55pR4YDx5aMEs9Dq3H2k3Zb3HiYwj+w2h8M=;
 b=WH4cGjFxJKr6EhwsUGK6WVOi3VWwNB8WGzOeQyaOiH0V5JUuvjrGzAdbFmM9sKI2uWJdUWYRsfzb0PiXZBdQBKaOBDPR2HQSfkgWQ5M3xhUQVPTH24bAiPQFp6RdShnLjw3EWqb8+WaTjV6PMazDKGQvpRuFoAy0wC8+JOZLmgEKUKTsqT6IzyXrcYpFqef1IUIxWqTc53BUqdzULihK0Jn76fSbsKQVXl3I7k9KUWozfP0p2dbbRC3vlvT2PnpfqSs3bVcIvCYWVpD3xjFBtabEWl892KFCSWKwIRVZ0AntV7v1LAfF0eJO3fQLG5dpvLgNGWbsdxmKpNRxH8D4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOoEHxaj55pR4YDx5aMEs9Dq3H2k3Zb3HiYwj+w2h8M=;
 b=Jh0o3ypSKsHmobUPKv3vd/bL26SQm3dpcn0LHa99XM65ejZbX/+1DVB7stRiI8wNnASVKpOCuuczKIVcLBj3U1Jy30VWDFh3mf+ILIehAuZ0LlMLZN2U6h4ynWJKs8uNEUTSDlgXsHXlOEFAHpW+wUNC7tXOdDC2XtMLslfri4o=
Received: from DSZP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::6) by
 BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 20:12:53 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::69) by DSZP220CA0002.outlook.office365.com
 (2603:10b6:5:280::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.16 via Frontend Transport; Fri,
 3 Oct 2025 20:13:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:12:53 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:12:41 -0700
Message-ID: <0d139f83-36a0-4f67-8a2e-421ad1c8663e@amd.com>
Date: Fri, 3 Oct 2025 15:12:41 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 19/25] cxl: Introduce cxl_pci_drv_bound() to check for
 bound driver
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-20-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-20-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c72ac9-9252-46c4-ac3b-08de02b93bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFZnc3htSGo3TUgzQnpTSDFRaE1sWW5TdmR4KzJzMlVrVWM0KzAwK0FuZDlu?=
 =?utf-8?B?ZHVGWWRXNjJUS1o3eGRnUDBaeWkyTHhURHk4SHVnelFPbVIxNHExNjZQNUVo?=
 =?utf-8?B?UThBT01IMXZMZTljbWhMYnVBMVhxSkRFV0g3N3A3clBKUWNnemVCd3VidDBH?=
 =?utf-8?B?OThMVFhHN1RGK0c4UXdMd25TKzYyT2YwdEJsUU9tQ0ZCZlNqczNxMTFFaGgx?=
 =?utf-8?B?eFEvU2hLWkxwbncyQWRxcmxJOGQxWkVDVWs5Mk01OXZ5d0x2d3JsMzd6UXYx?=
 =?utf-8?B?ZjJSMzZETmxOcVBCazVkYVFFVWtoZ2Zncklrc1dheGhwb1YrTlZWWFQxK3BI?=
 =?utf-8?B?aC8vOWQ4akVHc1F0NmtZZnpWZmtINWZrNzBlY2NMNG1WYmpweHdtWkd6NnY1?=
 =?utf-8?B?MTdIbjlQek16eEdDY3VSK2xaTXZWbFR5Q25ad3lGUG5NWXIzVFhsU2pzcEM1?=
 =?utf-8?B?Q2tZQUhzbXZvSnIvWmdjaVNMd0xYeTMvTEhEWDMxdG5pSm1xZzZGeVM5dWpy?=
 =?utf-8?B?UnFKckxvWEZSdWJJS2Z3Sk1vQ1lMZCt1SXRmNlJrRWFMR3ZoenlrWUdLa1ds?=
 =?utf-8?B?dFN5UHhOVHJEQW9kT3ZYMW9yNGJNMGlJZ0FXdWNZZ2ltQjYrUHBDdytKa2VM?=
 =?utf-8?B?TEUrdS9TYUdnL0pERmtTN1JTT0o4L1RjcGpiY3dieTljSDlKak1DWmZ0cVNN?=
 =?utf-8?B?dkZwaG0veHYwM1VZcXJYYmlGUjBQQXZybzNBOGRpLzVVamR4TXhrc2VhcXRW?=
 =?utf-8?B?S1djZGhCMnl3THhIaEZlYk5kVFN0NDVPaXh5VkRCMTJTS0x6Qm5nMXI3Wldv?=
 =?utf-8?B?Mi9yejNURWkrRGZaT1ZVKzRFUlVDSjcybTkyNXNTY2gvU0tPSmZ2Mm9ENUFq?=
 =?utf-8?B?SDkvSkc0M0l5bDZyYXZkbWxxVXpKZ21obUV6endCNjBWZmtDYzBCVEVZRzFl?=
 =?utf-8?B?Z0FFa05EL2dGSGdNQ2ROYlVNLzVjWnlyWGlDTDlMTDJXQjFqaFppTytFTFIy?=
 =?utf-8?B?UFlzdjIra1FkUGlEaWRaVmhqSWx4bnZISzhkZytMVDVDa2V0bGpSbCtoK1lQ?=
 =?utf-8?B?Z0REVlBtcVV2TGdYMXo1K010MSt4U1ZYRUNwSTVYQW1KajBiMlFia0U0b3gr?=
 =?utf-8?B?eVdMbEpBcnRUK1pDQlhwSHNIdUhKbUVYRkdOVnNmL1MrTzB3LzE3WmlwWE0w?=
 =?utf-8?B?Q1FXbzdwZXZicmFOMUUyR1M2YWtIRGVnaW1hR3VqU3FOeDVNVjNqQ0JZNDhU?=
 =?utf-8?B?ZFBCRzE0aW1IaTI0U3NJN3dwZWRqUEdUUlFhTEtPVGFNaitpWVJLRGxseElZ?=
 =?utf-8?B?aTEwOXdndCs3TkxpVm1GT3pwMS9mOG9UN3JkU01lL2w5OGNwRktOeHd1dmE3?=
 =?utf-8?B?bThVME02VXZTV1czQzhhVGZIRjY4MGVzRDE5QVB2cDhtZHR1U0c1WmYvUm5T?=
 =?utf-8?B?VlNqVmZDOTRXNGVORFdBUVRPeGNVVXlHSVRlOEd2czB5VHVvSmhvY09Uazdo?=
 =?utf-8?B?eFI3TGxRdlAwMTNxdWxZUlVPTUVtRXZQbkhtZjZ1eFBuM2RlbFBlQXNyV2Vx?=
 =?utf-8?B?cUNMaXFTU0ZBNG4zS3JFYTZUUE1oN3JxeVB6Wmpwbms3OVZsN2NJSFd0aDhE?=
 =?utf-8?B?Z2VxcTltMDdRKzNHRjBuZmNSUTlESDMwR29oQk1xN2ZJbVcvSFZUZjljcCsr?=
 =?utf-8?B?MVZzbGI0cVBYT2xXclJKWm45WkErVHFXUnhnNGRGcks3dSs1WVJpbm95QjNx?=
 =?utf-8?B?L1FKbTEyYjlaakMyanhoTDk5NWlGQlpod2NabXkyV2phRHBlVkY0NE5weVdR?=
 =?utf-8?B?WWFzN1BKcUhLN0RPbVZubDlNNkZNNFJaZ2ovZ1UvTFZGTGpzYkRyMm9wQkFC?=
 =?utf-8?B?RThhL2RLV0VSTWFyNzJaNWd0OCtQdlIzS2JWTTFHYVVXVHRESkdTc0dLRWRV?=
 =?utf-8?B?UkQ2cThsQmxOVEFQcEp3Q2ZNWUNwb3kxWlZVa0N6dW5hdzFYSy9ZOFo0MzVR?=
 =?utf-8?B?VlhvNE5kTlpUcHU3aFA5dERhbzNDRmNrRmozd0tVc1RtNGRuSGtqaXJ2RWNH?=
 =?utf-8?B?V2l6NWFsZGtLZ3NheEwwdEFJL2ZidlNvUzJXVDNvT3VMR0duMlJVNW5xTjV6?=
 =?utf-8?Q?lPW8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:12:53.0150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c72ac9-9252-46c4-ac3b-08de02b93bee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259

On 9/25/2025 5:34 PM, Terry Bowman wrote:
> CXL devices handle protocol errors via driver-specific callbacks rather
> than the generic pci_driver::err_handlers by default. The callbacks are
> implemented in the cxl_pci driver and are not part of struct pci_driver, so
> cxl_core must verify that a device is actually bound to the cxl_pci
> module's driver before invoking the callbacks (the device could be bound
> to another driver, e.g. VFIO).
> 
> However, cxl_core can not reference symbols in the cxl_pci module because
> it creates a circular dependency. This prevents cxl_core from checking the
> EP's bound driver and calling the callbacks.
> 
> To fix this, move drivers/cxl/pci.c into drivers/cxl/core/pci_drv.c and
> build it as part of the cxl_core module. Compile into cxl_core using
> CXL_PCI and CXL_CORE Kconfig dependencies. This removes the standalone cxl_pci
> module, consolidates the cxl_pci driver code into cxl_core, and eliminates
> the circular dependency so cxl_core can safely perform bound-driver checks
> and invoke the CXL PCI callbacks.
> 
> Introduce cxl_pci_drv_bound() to return boolean depending on if the PCI EP
> parameter is bound to a CXL driver instance. This will be used in future
> patch when dequeuing work from the kfifo.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

