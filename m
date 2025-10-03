Return-Path: <linux-pci+bounces-37576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C0ABB8091
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 22:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3774C42A9
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 20:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE19218AAD;
	Fri,  3 Oct 2025 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="axQNuAaL"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC8021D3E6;
	Fri,  3 Oct 2025 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522305; cv=fail; b=qXzeMgyBbdpe4XCHtE9l3f0rwN7KDuMfkMTcwCcWGnh3jVz57rE5BosOrJvjRNk7nsww9TIQQk7ejvxfwqieh1yiUBYGxbFRyjTiX8fUFUhuTygQGt9vNBz6HjbHkXK2LTLrRks0x8rd+yNVBSGndGsbMeKM7pYtyGMbiymbSGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522305; c=relaxed/simple;
	bh=8Fzdenpx0MhNQBXKe/PcFHEQTjNx3QnscCiGDSq7Trs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=dte9g+eRNBQ51x6AKjlPWkVheNvoXw2ff87jscVZPDFVvzMLV7pynsB53qJPEodwILsVK52y1Ri0Mzn/gUFhLMXp8dOxatHCsrOzlQ5z1hQksrdE0oQ6VKc0g+YGStRQQWBNp0sagpIIr0EZM4rGl1Welw2r72MY7fx8LF6Utko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=axQNuAaL; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jnw7BBsOrc4dfM47MwR6YBaQLvKl/NWohZ5Koh5Oze8iOMbxUiHewlyQXuR3keOUkbt4+s+L/VK7Rzu0z/DhsaCcWRHFUmvx7E3qM3LJuyNAuZcY+5iExG231ZaCpxsD3JIGVL3NJE+Giw8zt2sHQGXlSpTkdcF6nzr3lNX++/9n0POvVKXyqBq8G6fS27eEQUMc7Di3PPwN8YNJ2L35BZJL+zG+5eKQAj+6iSNaunuYRf1N42DogeLgxa8d5WN1HD0dvoDqGn+YK7Eq7QPd+tqUiw5U7h4a4f5QgWivmt8plIna0j9Vn0cvlg19wSjf1FAbAm2DE34vczQlItjC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCcDX+qqS7zarve3jmeSq33Z4Uh/L3zl9oiHccplL1g=;
 b=QrUNVLAxE/entr2RQNlJ3g91Azffe4mM2IJM61LlEjC5iczuudGv9lcvMHLEucOHtSRoO58YzE9DNxwwgntnQ6WAsZXuhG7TZtgH94PehLAcOiBefBzso9vAQWbM6lN7xmlSJuJSFs7nBco1PU2h00KBGau6WqHc+eKIE69VuH/9GklTglrISTaTOQQFPJ2IrU3PZeHtb31jVttHyL5PV5fTqYuckADHVt3lt4yybOWSrhqVX0bIigAb58CIrC34ea7zywXACg8wxua3E7USJnfzxSCyuUWR0cGJKceg8JMU8bTy3peYpSXji/UUaUjwu7B9gU6i5m3bvi4sAAEjsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCcDX+qqS7zarve3jmeSq33Z4Uh/L3zl9oiHccplL1g=;
 b=axQNuAaLJz5dRZ2kyGS4KKKZi1fMWOQu5hgdM2GuYwgZfSU4dCuP3NOGBGyIEGvxVnEcWBYVKDZwLdw02a1u6Yzqt5OliWyWxULMJFODtLoRKU0mGo5iKbL1EoM56WV4/4CG6ewl5c7cKEqxjCeu3KAgkSG0fRqSjecx47Ise0o=
Received: from BL1PR13CA0345.namprd13.prod.outlook.com (2603:10b6:208:2c6::20)
 by IA0PPF8FC6E1236.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bda) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Fri, 3 Oct
 2025 20:11:36 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::21) by BL1PR13CA0345.outlook.office365.com
 (2603:10b6:208:2c6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.7 via Frontend Transport; Fri, 3
 Oct 2025 20:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 20:11:36 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 13:11:30 -0700
Message-ID: <58e759a1-3c0d-4753-8d28-8379b944a6bb@amd.com>
Date: Fri, 3 Oct 2025 15:11:30 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v12 14/25] cxl/pci: Update cxl_handle_cor_ras() to return
 early if no RAS errors
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
 <20250925223440.3539069-15-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20250925223440.3539069-15-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|IA0PPF8FC6E1236:EE_
X-MS-Office365-Filtering-Correlation-Id: 49467465-3977-45f0-7485-08de02b90e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGdsWmZheXB4Q2wrblNxR1RYTFh2VkwyY3Mxa0pKUHJiUjV1VDljNE9GbmFG?=
 =?utf-8?B?REJPNW5lVHh1dmczMmtlMGRpdm9FYmwzQ0tRMi9RcjB3UXRTVnNKSmxZa0Zz?=
 =?utf-8?B?eVFkN3ZaZGtIQXAvb05GY1NaNlc5V2g2cXBHTk9Md0Z0TmZjbWNQdW44MVlJ?=
 =?utf-8?B?Q0dtRUhUdzRrZVQzRHgwbi9LT0J3SVErblF0NzdrSnNuSXJ6b1YwVFlmOHRh?=
 =?utf-8?B?ckN5eVlCU0V5bTBYd0dDNDJ1cGpPbnBNSWRJK2NCTjJxbzRsM2xIRFRZV1o3?=
 =?utf-8?B?MWJGSUdIdE42VUp3dEMrUkRtcEs1MlAwNEYwV2ZvYlRMbnlKQzNRbWZvZ3Ri?=
 =?utf-8?B?OW1xVVdUcGVZOTZvU2RFTHA4Q0JVMUx0aVkrU3VwdWp6WTkvdk52OUZrZllF?=
 =?utf-8?B?alRWc252Ti8va3VYSXc4Nmpyd0JZUzN4UzJXQkU3aXNySG8vVzlDa25TZStr?=
 =?utf-8?B?YzI2Mm1ybHVzcDBRZ2NUampPQ056VTJoaDFJL3FoSDNkT0VBMExsWWQzN01S?=
 =?utf-8?B?Rm82OENaejQ4UXNzUVQvck9GY00waE1rZlpTZURodWROZXN3RzRiMG15ZnJz?=
 =?utf-8?B?SXpMM1lXTXJQQXh3US9JK3ppeTBCRUtZNlFDMzk5N0JnR2pzb1o2MzB5ZGdr?=
 =?utf-8?B?VGdzMW40SmtuRDdOWWtiK0lpbi9BamtUcXFzQlhNajE3bzF0eEJqTmlPVlZH?=
 =?utf-8?B?U2RsUHBRWkVzMFJYdmhQaFRFOHZFRnVhTHRjTXdtK2Eyb2s3SkNUcGdBdjFE?=
 =?utf-8?B?eXVpN0VuQkxvR0M3YitScmhDMWNnVjFmSldXRkZYV2VKb1IzUTBkQkw0T3Fl?=
 =?utf-8?B?cTc1ZGpqZ1RSMzI0MzBQR2JRWXd6cHRrUTN6SDFTKzJ3UU03Uk50U1NYOGNv?=
 =?utf-8?B?MG9EbExCemVGdWdYZFcyRXlaWVVSeTI0VXlJTXhheE9WcHJHMmZ5RVl2S3FW?=
 =?utf-8?B?Vlh0MUd1NXJmN0UxdHkwNnZLRldpVTk4V0I2SXRlZ2hVWVpzN0pGV3dNTy9x?=
 =?utf-8?B?Wk52R1hrUGtmOGpRUWNSai9xTnVRQzBKTGpTcE0wdzBmWThtYkgzVUt2azdW?=
 =?utf-8?B?Nlp2aWcrUkkyVTl4ZWhwNkFHc0plcG5CK1hRYThuMDBUUGcwdWF0M1l5cE8r?=
 =?utf-8?B?RmxYdHFYRmxVbU4vQlFjbGwvUHZwZm55b3VqdmxtaitWWWVuSHVSUXRwalBO?=
 =?utf-8?B?dkFrVUVDcVZwQWlBTGpUOGNlMDBzVzhQNmd1UEVPTUdXMmxMNCtUUWppRFJN?=
 =?utf-8?B?d2tpTm9MdnFiUm1iMXk5bjZCdEZ5dDErMkFKWDU0SEVmOTh1K1NEWHJYZDBi?=
 =?utf-8?B?aHpqRWFjdzE2cFowTGpiVVBpbDVQSWR0cnEyQjlCSkZwVndEQ0VUWnFuSFh6?=
 =?utf-8?B?RG5KRmVSd1ZiZVVtQXNhL3F2L2VqaUxuV042TGcwMVA4ZkhrTVVkTGVxNUJi?=
 =?utf-8?B?VExsR0dINWRqcW5ZWnNIQzlRcktoOWJnNUdBY0NtT2srTGhKeXpQYnhPSkRx?=
 =?utf-8?B?blZ3VEFHNndrR0x6TW9wSGsvQVRiVTYrSUIyU1JZbGdkK3hWa3k5K09CQmE2?=
 =?utf-8?B?Q3lTVjN5UkR5OSt5SThRUDVBemdUcFYvMGtqeXFGQmdBRlkwb3MxS3hyVjN5?=
 =?utf-8?B?SnBHZFFkWlJtV3hCY09oMFVMTnU5T1VPRVdOZXZOS1FaY09iVkpYdlVDbDBR?=
 =?utf-8?B?eURRUyswK1JZNlRZTSsyVER4dG4zNHZqSFRkTzMzbFJRSmQ3K0FubVNEVzhk?=
 =?utf-8?B?dDFVbUIzYk1rckt2OHpnM1A4QVNtOGloT1FSQUU3ZSt4dEZZT0thU1VmbjMz?=
 =?utf-8?B?TWEzZm9CaWgvNVQxdnNZYzFwdFJEbkJUamtsbStGaDZkQi9adUlZYjMzR3Rl?=
 =?utf-8?B?enVJOGtJVlYxMmZmeG8vUzdIemFzaTdnY1JzUXJMcTJ2Nlk5SHBab3R0THlo?=
 =?utf-8?B?bCtCcjRxWkxaUnFJcVk1blJSQnQvaU9SSnNNeXBwZzBEOWlCRU1SRmhvK20w?=
 =?utf-8?B?VVNiWjRpVEM1Y2d3d1pYYnl6bno4T1FPajZ1cmRIT2x1dGJmS1lLbktjcjZm?=
 =?utf-8?B?OUxxQSt3NkF3akhUdER2QlJRdXZwTWl5K0xsanNSSmFXcW9rT28wanpkc0Ru?=
 =?utf-8?Q?Q8kc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:11:36.4385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49467465-3977-45f0-7485-08de02b90e45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8FC6E1236

On 9/25/2025 5:34 PM, Terry Bowman wrote:
> Update cxl_handle_cor_ras() to exit early in the case there is no RAS
> errors detected after applying the status mask. This change will make
> the correctable handler's implementation consistent with the uncorrectable
> handler, cxl_handle_ras().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

