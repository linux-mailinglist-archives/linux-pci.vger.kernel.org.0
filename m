Return-Path: <linux-pci+bounces-33467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F7B1CB85
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 19:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E08518C3634
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 17:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A9823D2B2;
	Wed,  6 Aug 2025 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0mULYNUC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80B1E7C03;
	Wed,  6 Aug 2025 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503111; cv=fail; b=b08Y46WQsjta7FMZYLpXlEb9Mjp8ky5elQyaloRax03yBJln2qCDYmkBouN++I0akLHZs0OOTHNcvtY67sSeABfkuhhKvirprCO5AzfGxv8eiy6PSJuJWhR7G9ShKk8u+cw25hvNsj9bSxAbv/DXsGauzBmtQW1P7O6CAs4YhfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503111; c=relaxed/simple;
	bh=ZwL9pZr5/2lZUQTxDfw/53LDXsnPn/3EwXMmdX02l5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GlpDDBSqIVoAp02ktZp3vIjhOCpuU7HVq1+pDxxGQTTll2h1DyS6FmHsZJrtQss3VrDyten+TWEDVdt8GD5Q6SL14IGGIwEW+VZURcujO3W/9WIJwwfnDcmdolMzSNvFeit16lyoX6c2Fdpgwwqje8T8KL8/pIxmhBK5JtxSnUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0mULYNUC; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuyUvl1Qi1Gw7byofpX0IOjMyTSIduJCBdTthbXzMyx6p0b1nONwDs/aKzAUn4jXS53XEj6X2hnFQyNiOhIMDY/gwt1bQ1cpqNZvDIYQjihGiCJl6BjpLdXxu2MHChOhXzczl8PSH1D0UNht4BswhRmmHzIygdyhienqvUN1KX+E1Mqz23+4KQydh/jXahbcqkrW1zYU4RO1xhJiYf0X7bu7kf+JbVKHsT1mfQ808t1vimmdxLtEMHAzexWxO5EakT4fpbckzYInB4AJYwuGjQ87b8CCVDs8T8pTPe2eCJtl5TutDOeTiZuzXW9Kcom5w4J9c8riiZm0QgnGFhis5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ng1Wuo/RNKb89niKgL8CtiNt2MoZYxrPlL3/c75iIko=;
 b=WO5TYs869rdliPnSUawrxETmawPMIj6ri4pFXaWpPV550cq0nX0fuhs8mjckBOiGKR0Eq26343hN9D2xwO/f/ZdsWKgwSFWiWdLJXq9T+IBE/KWZU4qfMz9nGl3TbJcBQvdYX+WpPxOlXNG3ezkZSZJ+96Sb/O3uQ7YAh0NTj7ceVUnACiHIqIYocZxJGj2BGTCKqdFJkCT6Sg6lCBrmSzdV3NoataYoJXP1smOiQ0bLpeliOuKAvwRab5MuXrhXaHZEdfJV3ot0wNHboClr8wDkuboUde1VGa+DjBnCvsKBhpAcCM+hZWTK5qliFSlreoape1jV3e0Ug2SLDRS6ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng1Wuo/RNKb89niKgL8CtiNt2MoZYxrPlL3/c75iIko=;
 b=0mULYNUCgw3TmniDiJmSO72JIcAAz2YTWemwo97i+Gg/5XmhRl8ElDgBL7iLKl2DDJpdekob7ljDiONG9tCUSVEjkGdBCemidAMbO5WCvtiW1zgZd8WIjqxa5FdWFOW/hsxWmTfkTdWcdmzO7TnqH3XUreg0XTHozGJaUytUSpU=
Received: from BLAPR03CA0099.namprd03.prod.outlook.com (2603:10b6:208:32a::14)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 17:58:26 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::59) by BLAPR03CA0099.outlook.office365.com
 (2603:10b6:208:32a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Wed,
 6 Aug 2025 17:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 17:58:24 +0000
Received: from [172.31.129.107] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 12:58:23 -0500
Message-ID: <99098619-76de-4b69-9095-9cfea8f115f8@amd.com>
Date: Wed, 6 Aug 2025 12:58:22 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] PCI: PCIe portdrv: Allocate CXL isolation MSI/-X
 vector
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
References: <20250804213941.GA3641825@bhelgaas>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250804213941.GA3641825@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f00b0d-bf70-45ec-7bdd-08ddd512d6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TE80d1ZFaWZsUE1xbkhPS2plTzZoWExKMFRCeTBSRERBeDNEL29qajV1cjFZ?=
 =?utf-8?B?TUdHTlk0U1Z6SzMzS1FIQkh3bWdka3pCTFRPV2xvTFBRc090RUdhU3pvcEpB?=
 =?utf-8?B?bVl6NnZTS0JOcllEODByQ0c4MXpHd1hFZ1U2L1dXNmZ5UzdNMUpFeHlqb1JY?=
 =?utf-8?B?a1ZDOHBVZ1I1VmNmQUZ0SmNqU1p2bDI2TFJxbDZkQ3lVTXZyRUQza1FIZlNa?=
 =?utf-8?B?Q3dEdXQ3MUhKZzhieDBTTDNLNEFXOFZhTlY5YXVvMERRSm5tLzBEMXJFRmJo?=
 =?utf-8?B?R3czSmhMV1VUVjRRbmcrYVRBSzlsMXZUTnpzQ00vM2srTkk4TERHZ1IyRHRK?=
 =?utf-8?B?c0JVWTFscE8wR1dSS0NZNzY5Q29kQWdpcDNiQWJ5S09OZnpray9aMEtyei9U?=
 =?utf-8?B?cGhpQUFibXZTMHUrd0E2SXBFN3NEakhUMDUwL21WNHMwRmlGQUgraEVueVpk?=
 =?utf-8?B?aWlCUk43ZFFSdThlT29Dbm5GL0FQTFZNSUFCYUMxNk9BUWorMVlheWZ1SW1J?=
 =?utf-8?B?bzZWNUd0Z1MrRkhuK2lXWEtBc2M0K0VnbGo5NW1BaGs5L2k1VkdkUUpyTStq?=
 =?utf-8?B?azFhaVM4Sm5SVUI3elRSUnlMaVNGYWNYZUx1bnFEWStGejdSanB6V3AwNUpH?=
 =?utf-8?B?RzFMejNHL1FMTG5EeUxPNWVUUVBNRXlvTm4xa0MwZnB6aC9mekliWGluRkpo?=
 =?utf-8?B?d1J2WjBYNDVwNElydCtEVDUwdWZBc1lVUXArVm1xV2xuSWg3M2diWjh1WHFt?=
 =?utf-8?B?RThoQm9PODRWTEVKeENQT1VHcUtwTWUwV1VwMnpSNWl4eTlnWWF6WGVyY2dE?=
 =?utf-8?B?QWJIREhKZ2gvOXhVNTRlaDVRWmdWVFQ0d25EWVRUNVVUbjBBWTVwTzNzTkVz?=
 =?utf-8?B?SEF0K3AwMS8rS25KdWxoZitUVzJYNmxMcDBYdnVmOHM2YTZnanlVZ0xEanZU?=
 =?utf-8?B?ZVd4cGhHemFYOHpEdXo2enBkNDgvNWVtTWd5QVErc3haVHFCYUdBLzF5eS9N?=
 =?utf-8?B?TSs3WWlYWXFBVlkxSzk3UUhFSXdYRVBBV3UvZGJOVTZzUGMzZTRPaEFrenVP?=
 =?utf-8?B?cUhPUWl2L3kwcG5zUVNvakVnMnRXeVBJT0hJejZhQjFRM3dPSXhEV01ZTFNo?=
 =?utf-8?B?UHhQSTF5ZW5TVmxwZEVmWlFjM1V0YnBJYXQ3ZjM0UGtsaFRNSWFodXF2UG5u?=
 =?utf-8?B?djBBbnp2dzhHMlRNek9LWVNKWlFXVmxpdFY4M3lIN1ZLZy9HVlMxSzBHckx2?=
 =?utf-8?B?bGhURXZJa3ZlSGZRRERNRDJpWlI0UThuM3p1MWlORklLZEludDBHK1BEVmVh?=
 =?utf-8?B?QlU3LzJwQnhuc2RaSzU1MUdvL0svNHlRNURMSUhsQ1V6VXlpdG53dVZ5WTRL?=
 =?utf-8?B?N3FpYi9uK05ENmZQRHVhWFNQUzZDWmJvWkV5UE9mV3p3ZEV4d1BVMDF4N0Rq?=
 =?utf-8?B?S3VveG9lUXJkaGwrTG12bEZ5bk9SVy9mS09pWUpKMWpNOTBRbUdyTTZRR2Zu?=
 =?utf-8?B?cDVmdVB0VWdmNHZrR1JuTm11MVdCVVd0NVhDVXNtMmkwVWZKdnQ2NFF0OC81?=
 =?utf-8?B?Rlpxc2tVaFNmeW1zN0ZDYTc1ajZxVUZmeVBxb3NHS1orTE9uTnhCUk9kUE51?=
 =?utf-8?B?eDVNTGZwRUF1QS9ZdVZmOXVkbS9yOFlJTEh4ZldXSzNWblBDZ2JybW9CRHFh?=
 =?utf-8?B?WFNFS2JKWFdHLzN0UFYvMVhWL1dpelJvQmNkaUU4b3BheUVOclpveDk0QVA4?=
 =?utf-8?B?akZwQUdjYVA5MW9VYVBkTXFIY1RMdnhDTW5ndVY4aFo2dHJJYk1sdG9wL0RB?=
 =?utf-8?B?S0dUd2tnaDh4c1JJZUxmQVF1emtiSnlMc0VOcWJZeEpWUnhEVldNVWdSNjhw?=
 =?utf-8?B?STlscG9iZVVVSDFmSDhKZ1k2WWZPSHdGSElkT25Hb29NcnM1VTdNMFJxQUg4?=
 =?utf-8?B?cHJhNjJGOGtjT25rUjFwMk12eVcvbUpBVXVocUdmUmZUK1lZZzN0MjFnYTNj?=
 =?utf-8?B?cnR5M1FHL2xlN2dBcHowZmZxQ1ZDNzNOTTJBVHJwalRzQ3RmNmpNNmdSbXVn?=
 =?utf-8?Q?dNAzXp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 17:58:24.4911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f00b0d-bf70-45ec-7bdd-08ddd512d6bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461

Hi Bjorn, thanks for taking a look!

On 8/4/2025 4:39 PM, Bjorn Helgaas wrote:
> Observe the subject line convention for drivers/pci/pcie/portdrv.c.
> 
> On Wed, Jul 30, 2025 at 04:47:06PM -0500, Ben Cheatham wrote:
>> Update the PCIe portdrv MSI/-X vector allocation code to include the CXL
>> isolation service.
> 
> Use "MSI/MSI-X", not "MSI/-X" to follow PCIe spec formatting and make
> this more greppable.  In subject also.
> 

For sure, I'll update it throughout the series.

> Bjorn


