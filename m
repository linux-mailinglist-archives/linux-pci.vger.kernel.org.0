Return-Path: <linux-pci+bounces-36372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87359B812B9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 19:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA8F1C273F8
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 17:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6613A2FC871;
	Wed, 17 Sep 2025 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aV29rs7x"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07572FD1DB;
	Wed, 17 Sep 2025 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130041; cv=fail; b=Hzq4CLx79V+n7frYC71NmgZkcbg5c2Ctl+RL7KIyVMg5RUjpsKRVNOTrV23yI8KVwReXrrt47cqdhdCWVN5hncGz0FCxnnrVqMjYupuMyEUTYxOWCDnp6ewpCQ++pAtkSVg7wrFcr1A3Vle4QClnKLpR09tHpof1awgu83mhXUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130041; c=relaxed/simple;
	bh=bUZzzd5R9xkZm9/hyZmgAWIUdZRmUQ7t3btcf1kW37U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GKqvwycuXA8Tx9ymtyvElXKkBGVyHFZUa4Nf/28gHchMitSeDejo7xd5nAk9noHibOEZLENNeFp07H4/n2RFyW9R5E/hcIkjhCmwZ7VuliG72sRt2wCpJkG3yLz2mMV2JZ4MN7dMdsPMts9VJsBocbLEolJl4lHupP4zxHukuXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aV29rs7x; arc=fail smtp.client-ip=52.101.57.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8in3wONR8Y/7nQynoNp7PQRleK/cTyhW1zfm3PZItxpbrZLhcUzRGBZIS0JUmrfKJwZ2J13UN3PAlf0+TnshLM9fsDMelyozL1pxSzqweT7Cmm8iWzV715dZe5zxernv+cSGkjdXhdT4NWEFCed0yjUoLb6R5uj4mKWEfj/73K++exQRc1NiMe4Yqx2WWU3jJZHr/fux4ooOtU/EZuNVs5LLHP2k4bRPcSLQqi9IxhETSnAXcPtm9tGdfZSCb5AVjggMSyHb/uc4IXBbXkCJdvcPe17Iq2x3W8q/DGCp/ldZZro7b+zJznB3oJxswFK4AxNeol+wcmK0q7e/fJRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCSwGanW3dYq2/CyhJclr/L6/jMDyCkiTW/MbYmKym0=;
 b=dKMui3MFcqAARR0QvvTl/9dfP0dQL+/aS5Wx4i0GO0k5Zi4Z51FmiE/kEIAfmXYwM1llXa9cwAgxj1ad6Nx9Inr8dqi+/gLZLMkNMraWp0z7pNos502ji0kviBXR87TzX285N86n2bWPGJO+diNecvXMr2ZH6F8Y2clHw6DuIlJx4REOjXJS79ridGSz+8Lh2yTHvQ/zUgc9aMEBuWI02Og5iqqSezATsNwjmU1slnDyZ+HIu5pAxLUlcWbhkNfnzVvldfpreeaR4rsmFxvFKy+WY7FKfDhHyvcwaqTZQM00PQW4PG9iSo0z6BRptMKzmBnh04OwWzs2EurQpvQr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCSwGanW3dYq2/CyhJclr/L6/jMDyCkiTW/MbYmKym0=;
 b=aV29rs7xK0boS7vG39RheJu7634tYyeUW71++ADck2bYZ5RZba/eoOSdJvYhpXUBsYgEmy1Eia4oY6KOSWEptZzBVIb10zBYCxylWCRQtzsRwXFeTD57OxcQZSsDks5DUfV0r90anEP6w1j0ZzGMZoEZC6ixdrn4oPHJiA3OiN8=
Received: from DM6PR11CA0047.namprd11.prod.outlook.com (2603:10b6:5:14c::24)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 17:27:13 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::c8) by DM6PR11CA0047.outlook.office365.com
 (2603:10b6:5:14c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 17:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 17:27:13 +0000
Received: from [10.236.181.100] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 10:27:05 -0700
Message-ID: <9369bcb1-0119-4e21-b05a-402667606a03@amd.com>
Date: Wed, 17 Sep 2025 12:27:05 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] PCI: PCIe portdrv: Add cxl_isolation sysfs
 attributes
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
 <20250730214718.10679-13-Benjamin.Cheatham@amd.com>
 <20250912163348.00004d1b@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250912163348.00004d1b@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: aba0aa68-5c1c-4aa2-39e1-08ddf60f70e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWVoRnJRL1h1bktNSUJxMXoyeDI3S0xheU5rSzlUWTRMcGNjS1EwRENjcGZj?=
 =?utf-8?B?NllMdXV2V3VMVnJ6RnBvVERLMDExS1MwNVRNMk5jMDZtdnVtZW9iVVZpQmsv?=
 =?utf-8?B?bVlCcTNvT0xXTG5XM1k2a3Ztb3E4YUdWemlGYUJRcVpVWmt2RGZQTFNSSk9m?=
 =?utf-8?B?V1hWdjBoOE9QY1dnczk4Ym1hZ3RRYml5K2gvYWhMN0NDOXVveGZ5QW9kRTdQ?=
 =?utf-8?B?dTh3UmFaNFBENytHejB3ZmY2Ym5LYytaaTVicG1KN3d2eGhvdUlaNzh4TUw3?=
 =?utf-8?B?RVMwNUNZaktKVXk1UUU1SjFiQ3JFY29mcVJGdk5kT21qeGVOM2w0YjQva0JC?=
 =?utf-8?B?djQyc01DWHpvV09FR29HcTkzNjkwTE43V2h3UzJndEk5TW9TT0l5U1pqV3VR?=
 =?utf-8?B?RDhHQWFYQmZpNGpqeWMwS05MMmRuN0JpWXp4MW90S1g5ZWRxWkg0OGYwNFpH?=
 =?utf-8?B?ZVZxSy9VZGVRQnNvakVNK2xlS3VBUE9Nb0dKLzVyNlFjdTdOZFVUMzFmaFhl?=
 =?utf-8?B?NDlXMDZMb3hINEVvd1hQdUZDR1hIak5KYWpsd01oMTZGV2RGeDNmcncydVBo?=
 =?utf-8?B?eHFlZ3V6bEJCODY5VCtkamNEUDRETVV6WGViWE9aUCtwQytRbEFjeXdveUda?=
 =?utf-8?B?Uy9oZThydUtyMTJYTHIyMnpPUFhtZzBnL2hFRUZDc1I2aEM3dUxLN08wUy9R?=
 =?utf-8?B?YXBka0NRRi9NY2RFSWNraGZHamxsOXkwM3pKdTdaSGJvcUJhVVdsSTNCT0F2?=
 =?utf-8?B?YmV5MUtzT1lUNGVqeHRkd2N4QzVxK0JvejVSRDdjUmNpcS9CbDM4bU5MM3Mw?=
 =?utf-8?B?cEUwYkMxcWtGZGtaNFd5QlEwZlh6VzhSSHhZbkNsb2NIOEFKOVk5S25EdWFa?=
 =?utf-8?B?TGNnYmZXTmFPZUNzdjE3TWlCSlJjSXBYaUpGNkdMSVRnOGt1QVlxRjVOY0NP?=
 =?utf-8?B?RVV5NWFuS0NtRk1Yakx1OFlMa29UR0dNdVRRY0hXcFFwck5pcVNBZ2paVWgx?=
 =?utf-8?B?UExYbS9RWFUrTGFkcGc3ZWFRK3g5V0UrNDhMK0dmUlBZalBQVUlzaXVIeTYy?=
 =?utf-8?B?M3lUcjlQUm0xakwvdjdQSENEZkVvYVRsZ0ZlOEhTWmZ2SDJ4MjhtSGVWVEhS?=
 =?utf-8?B?VU9GT1VTZFo3a044clZVTXpqdTRwUHlJRnN1WEJXSU13Y05RN3ZnOENkVzJI?=
 =?utf-8?B?MXNYYkovWW9Uay9Uak9HTTJkZWN6Q0xqcTF1WVczSlNBVkIvNVhGMENaOWpF?=
 =?utf-8?B?WXhwMkxRQjBDWjVoL05GWVltSmVvbkpPTlJZcnlrMCs4eDJSSGhJaXJpRFVJ?=
 =?utf-8?B?ZUlkbE5adDNHY21vZ1RyWlhqQjVNZHF6bFg1ekZQL3BCZXp4QUtwdlE4NnVo?=
 =?utf-8?B?OFlCSFZscCs3cDlsSHRDc1R0QS9Fbjl1THdoVnZFNEhBMVZsYWltUEk4Vndp?=
 =?utf-8?B?SDhNd1FzWmRhQm03RW1JYzgxTEtjay9MR0V3ZzZPa0gyOUpybEtkTnBiK1Y3?=
 =?utf-8?B?d1U4dEVHVlNsQlJSYUFDZW5PK0kvUStraGFmMGJ4NHZJNVpNODRKS21vdkZl?=
 =?utf-8?B?SGxxVEFBV05yem1NeDl6cDVQNmNLZHdwWStvU29oOWVpTVUyZ0RUQWJINk1y?=
 =?utf-8?B?ang5RzJjTmsrbldtOUFZTkJUTFpxMjZPRGlrT2ZEcjAwRjJqL2lGMDBXMjQ5?=
 =?utf-8?B?TTZZYWdLTDQzOTNybGhRaTYybkRBU2hKY3NTK3JhcEdwZ1Arbk5aNWxhdndU?=
 =?utf-8?B?MVBDMHNXeDZzaFlCOUZpaGdaa3BWRE1QS2RYd3QrZG40QjhxZUhYLzcrRG1D?=
 =?utf-8?B?Ni9aL25SUWJoQkpWRXVaODJoZ3hXb2p1bDE3WVBvcFBuUTBTUVJwd2p5TDF3?=
 =?utf-8?B?VWdrNXRWL1NnRUkwQUFEZG5aRk4vMCtrK3FUeTNYTVB0YnVMdUs3YmxscGhV?=
 =?utf-8?B?NWRBdGt6ZTBwM3I1M0tPcnZhZlFteXFGcEpRc0JXMklHeWQ4RE1mTW9jQ1N2?=
 =?utf-8?B?SWFBcVdPSGNoL2I1elJ3cml2MUhaVXFpSS9MK3lXcTFQSExyaWdQaUx5WUpk?=
 =?utf-8?Q?FAVvXn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 17:27:13.4743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aba0aa68-5c1c-4aa2-39e1-08ddf60f70e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426



On 9/12/2025 10:33 AM, Jonathan Cameron wrote:
> On Wed, 30 Jul 2025 16:47:14 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add sysfs attributes to enable/disable CXL isolation and transaction
>> timeout. The intended use for these attributes is to disable isolation
>> and/or timeout as part of device maintenance or hotplug.
>>
>> The attributes are added under a new "cxl_isolation" group on the PCIe
>> Root Port device.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Comments below apply in quite a few of these functions, I just
> picked one example to talk about.
> 
> Thanks,
> 
> Jonathan
> 
>> diff --git a/drivers/pci/pcie/cxl_isolation.c b/drivers/pci/pcie/cxl_isolation.c
>> index 5a56a327b599..9d2ad14810e8 100644
>> --- a/drivers/pci/pcie/cxl_isolation.c
>> +++ b/drivers/pci/pcie/cxl_isolation.c
> 
> 
> 
>> +static ssize_t timeout_ctrl_show(struct device *dev,
>> +				 struct device_attribute *attr, char *buf)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct cxl_port *port;
>> +	u32 ctrl;
>> +
>> +	struct cxl_dport **dport __free(kfree) =
>> +		kzalloc(sizeof(*dport), GFP_KERNEL);
>> +	if (!dport)
>> +		return -ENOMEM;
>> +
>> +	port = cxl_find_pcie_rp(pdev, dport);
> 	struct cxl_port *port __free(put_cxl_port) = cxl_find_pcie_rp();
> 
> Same for other cases above.

I realized I could use __free() for device references when implementing Bjorn's suggested
changes, so my local version already has this for these funcitons (and next patch).

> 
> 
>> +	if (!port || !(*dport))
> 
> leaks device reference if port is set and dport isn't.
> 
>> +		return -ENODEV;
>> +
>> +	if (!(*dport)->regs.isolation)
> leaks device reference.
>> +		return -ENXIO;
>> +
>> +	ctrl = readl((*dport)->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
>> +	put_device(&port->dev);
> 
> and no need to do this by hand.
> 
>> +
>> +	return sysfs_emit(buf, "%lu\n",
>> +			  FIELD_GET(CXL_ISOLATION_CTRL_MEM_TIME_ENABLE, ctrl));
>> +}
>> +DEVICE_ATTR_RW(timeout_ctrl);
>> +
>> +static struct attribute *isolation_attrs[] = {
>> +	&dev_attr_timeout_ctrl.attr,
>> +	&dev_attr_isolation_ctrl.attr,
>> +	NULL,
> My favorite trivial comment :) No need for that trailing comma.

Yep, I'm bad about that one. I'll remove it!

>> +};
> 
> 
> 


