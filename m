Return-Path: <linux-pci+bounces-37578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FEBBB80A3
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151AE4C478B
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBDD247299;
	Fri,  3 Oct 2025 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dyOrOmWJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E72376FC;
	Fri,  3 Oct 2025 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522310; cv=fail; b=T6+1tfXs+qZG5QkDBvP4GR+x9StbgvM8TNJrFd+4pEwr00Go8699PUfcWmHyy7ppwIhlvP0uwmrdplsH9En44k357NyKNwpdJSR/rvkbyBoMc5+eiOkndwBC3dV+20paHz3CkiWTSI9pPAJvggA0ep1KVxSWmDuDgsLO3XNsf38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522310; c=relaxed/simple;
	bh=Z2z8ami3oXEFOJqo7MwIocA0riTgvVsnZQ3YZ4AzrSQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=bpv9oI0Xg45LdzHgmhzOAdOe9GInQ2QzZxlLtA//k1KvyLwd8xnH7qg1Q9HzISF3oytseCRoMpv0ZgXR/g1Babk6P5UOh5AjzHiVx7TMUy783bVXGd97jERY4UnXsSuKJMWpR7Fwj2hbU+ShIov8GrHhQZjunfFOM5QPyAy2haM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dyOrOmWJ; arc=fail smtp.client-ip=40.93.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTXkfDgvN04RN3E6UaLhWU1P4UDiqMHr5TeIEBmXp9e6RBBBOhIXXOs4ZEX9dXI1lgnaYCVZAbhQkvAAO5QerUxj6qVSfwL976y24bz+Yk++Ewqr6jeJDo4IVfiIFCUCHfFw6OtrhMVL4tfZsKtgMXvAUuMCtr8kj/AbFOvDjrmRdxKIZ+Mklw6hM3GIDsWvz82f7Dksn/UepZ+yCW3O2p5zp2bs22mReGXBBp96i7NMubHqsqs21gWZKZcjBXGElCb4Zct9bonYEtsukRjQrpqNGfCvGNOAA4gosAc+r1VyFle0hnbJIrLXkjQDinrBAODQc2M9+aa+5IpXt/KrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKtwoP14pm6NT4gmbPQuxHRgFNGrtX+NFrQsCX1HGks=;
 b=OU5aGrA3s1S4ABXLnkzBGzdSwnrt3kWwWY6GrDC6LuYrIfJVuXo6ZkVSztB0/imytAijoz246WnIVLNhJIDBmKrI78EYOBgb0QHa2JjzhvRo/JQVJhQhftzG+sIkGdY6RLWY5pTdjEZN/daFe5qCS37Sga4v7Eain7sWfR0pKk1Xe0uBNVXp7KH5RNjWjZZACghpIpPLmeBd2aC+fMtUsT/Pprbqq+S5DLrzhAjkdp9VWHLM6zsIuZf+Tisw9xaZyPPvro01WxpOKdcp6aLtu4AskZrUUIPJs1j3K1y+AjqUk4eLE4dEf/feJ81mrxtaJjWBY6GL7mVnjaUj7ymP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKtwoP14pm6NT4gmbPQuxHRgFNGrtX+NFrQsCX1HGks=;
 b=dyOrOmWJxVlVfoZNOYrzbyZn/Jq3uwZn1uKXsytwFRsbbXp1Jwm5a7/DKoL+Kis46c1LJ/RJyZhvtWdCn1Q5yBZ0hFKCZQkEc78J6hIak/ECVufZql0D4Nl1ejk0FYvdZzMaONJkbzfZo8zKE0X7ALGKeBKZpV6DnastkfjJAyE=
Received: from BL1PR13CA0348.namprd13.prod.outlook.com (2603:10b6:208:2c6::23)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Fri, 3 Oct
 2025 20:11:38 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::cf) by BL1PR13CA0348.outlook.office365.com
 (2603:10b6:208:2c6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.5 via Frontend Transport; Fri, 3
 Oct 2025 20:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:11:37 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:11:34 -0700
Message-ID: <0d516dbc-15bb-4dcd-b98b-e97f373e681d@amd.com>
Date: Fri, 3 Oct 2025 15:11:34 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 12/25] cxl/pci: Log message if RAS registers are
 unmapped
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
 <20250925223440.3539069-13-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-13-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 74098d94-0b63-444c-3419-08de02b90f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REJxazIzamRBd1JpbDh6K3hRenR4QWpSdktLMG5pL1dUNzRjbVBxaTBRYnJV?=
 =?utf-8?B?YktQUlFGeHE2eC80clhSNEV5ajc4RU9FSkZ0L1I4U2ZhTGVrNTRRZWIyeGx5?=
 =?utf-8?B?T0JqZEJvaDZrL1VHV042ZEFZWFZEUlJxTGhud3dFSUVXR2pFbXBOZWJ3cks1?=
 =?utf-8?B?Z0lOYmdUalk5WFRhUEJRVVpJaDFCOVVZUm1uT3FaeU5nUmZMTGR2MDdnaUFw?=
 =?utf-8?B?VXdSQkVkTVZFUWVGQitrcEhUOHJJdlFJZEhlRmtEcE82cU5aOFA1dEJMMWcz?=
 =?utf-8?B?Wkp0bFpFM1grbW1oUTNOUE5XMWVQRUZMKytUNlZtVTVMeHBQSFBBYk1EUHF2?=
 =?utf-8?B?TGI3ekRLZG9FNjJmaEQ3UGdEMlIrcU9NSjZGdzV5aXE1dVJ1VUM2OXpENmlM?=
 =?utf-8?B?dVc5SU54S0xXNlV1TmZnRVdRNHMweHR0ZEVuWGtQSUNkaGdXdDdPTUdyUHdI?=
 =?utf-8?B?ZjR2WXk5WWliMWpYQ3JtQklRNzFRNGRqenJJTThRQm41OUpFZmlpSDJwWDFq?=
 =?utf-8?B?QkU2MFFmYXVpK2txd0lQRjdjeTFUZWdPRU1iOEN4RjN0MXA4M3YybVFUYVhx?=
 =?utf-8?B?UTR3Tno2K05jN0ptbFhSU3RyMkkwa0V3K0lZaUdVSTRaazc1ME0ydU5BbzVk?=
 =?utf-8?B?emgrNWFOWmR3bmdOdFRrUG9CZjEyM2JPUXM1ejkyR3B1V0prdzB3Q1VTM2Na?=
 =?utf-8?B?OFVQekozemxNR2VLMjA5RjNzTURwVXVIbitQY3N0UnFJRFBrQjBQdkZnSmNL?=
 =?utf-8?B?NC94bDNVdHBVdXVoemIwdWpaR0hURVNUT3B4Z1R1dzNCcVhQTng3bFl2MEZR?=
 =?utf-8?B?Z2JJZVRPWlN3cWg4WkFPeEFWRU1rWUpwR2ZLV2Zzbm9kRjYrS3dlYjRvd1Q4?=
 =?utf-8?B?ZzNFb3A0a09FR0pMT1FZdUN2a0dJbUk2blpIN1FRejhxdDlPdkk4cVRFRGdS?=
 =?utf-8?B?NTNMdG5ZN2h6RHNpMmx0YkV6b1NGSytkU29TbEpRZEVlRlZzaXV1Q1FVZVhu?=
 =?utf-8?B?Zm5NU2NtY3BpbUxsNnF4S2hDVEw1aWVjaFpIcldFRnRlZlZ2OFl1NFp3MCtS?=
 =?utf-8?B?bFloV25XQjNObEloeVpoNUt5OTRKTGo0bFdPRnU3K1JoeGNjbnd2d3MxWTB4?=
 =?utf-8?B?a3poMU5RbWNKdmZtNm5aL1h0UUk5S3diYlFIV0MwMElKdjVWUVdzNHRaYWps?=
 =?utf-8?B?WlJjdEtUZlNiRUJnbXFNRXB1K25HSUIyeUg1MHYwenI0dkZxZ2FtTXdzT3Bq?=
 =?utf-8?B?eFNRcWg1c3JuY2NhcXJ0SmxPUGtKZHhlOWc2TUFjangvRnNLMC8xUkNLekdv?=
 =?utf-8?B?QklGOXZpWEx2MzYrWkFnSWtKRXhqb1B2SlNkSWs1WjNQK1NjMWtYc243UldU?=
 =?utf-8?B?Y1RkdEh6cUdjbHU2TzBaUUNDYk9jTFFxTTF5QTMwQmczTlMxdzV5RXdzR2tw?=
 =?utf-8?B?UXFvRjV1Q054ZkJHN2crM09BdStuQkJwMGhwc2xPWG1nYTRyOFZJQlRTZzV6?=
 =?utf-8?B?S2YxNjFNWkJ0aEJ6WHgxSzMybXZIM2diV0gvZGtNVlI5QldMa1B3OVZDZytU?=
 =?utf-8?B?YmE0SkhVSDd4a2FBMjlGcGZORW9EYnJpTnlwM3g3UXdiRnVNQlpRVDBHOVdj?=
 =?utf-8?B?WENZMitzUnY0MzdSWkxCamVwZVQ3MGlRekJsVVFQZUdhN0hzbnA0ci9EWjVQ?=
 =?utf-8?B?OHJUQ0hTaXdndDhlS1VvejZwRU9jK3J5RGhXRWY2bzJlWERhNDB2Y3FCLzIr?=
 =?utf-8?B?SjZNeXVNS2hIQ2RsYTdiV2hnbGFoMWwydWhxekQyVnprbUVYK1N1ZUYvNHBj?=
 =?utf-8?B?eVBGVTE1MkZZdkltODVBV0xobVNwL1U0RGgwQWxid1QyOEVOenRGaUpMZE1N?=
 =?utf-8?B?cmlVcU9yV0swOEd0UldKWkVxSktQTHZkbDgxUkU5dUlyNkxzL1BDc0l4MHR4?=
 =?utf-8?B?WTl0QlhId2M1NDhacENveVBOR2hjbUJmNW94eEFZdFM0QmRNVFJtMGVRMHM0?=
 =?utf-8?B?dUt4S0hkcFMwY3BmTUxtNjI4c0JtTXY2M0JWeEpLUkZHV0t6MzRiVW5majFE?=
 =?utf-8?B?M3pQUVBpSk5kYmFWUVk4TmMvbUkxTzh1NHVmVzVWMkovL0F5N2svLzMyTGRk?=
 =?utf-8?Q?CmMY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:11:37.8066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74098d94-0b63-444c-3419-08de02b90f16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115

On 9/25/2025 5:34 PM, Terry Bowman wrote:
> The CXL RAS handlers do not currently log if the RAS registers are
> unmapped. This is needed in order to help debug CXL error handling. Update
> the CXL driver to log a warning message if the RAS register block is
> unmapped during RAS error handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

