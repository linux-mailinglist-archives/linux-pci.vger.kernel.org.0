Return-Path: <linux-pci+bounces-36373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053B7B812B6
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 19:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9E96251FF
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 17:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC19A2FD7A7;
	Wed, 17 Sep 2025 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="euobFC6P"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FDE2FC881;
	Wed, 17 Sep 2025 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130044; cv=fail; b=srMu1VF21/TS89l3Y1axKDAvZLDyIu9zgyXvbcJ7dNFFsJ3d04hu+tjz3z0sb8NkyENg5NoL12MqPPKuUps+o/9xEAVMhmHf0TZFpTIBOUL5bhvWDUGXoxz+XGvo6Lyo/7YhQtOXcyK+Qfi22g8tOvOHEcpiWZVkCEO6LEm803U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130044; c=relaxed/simple;
	bh=w20jPL6kRoJUL94vyAKgz+OntKN65ZggHYKDAWYhDRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OQyFBXT/daklra8QaaXs86VSs1e9waY7R+/gyFsBYPVuHB6JJBmzLnFm1o5QIiCaZ32IHYb87JGlf5GwgNunDyk6j+0Q0zOy3XHcU56Sker8sFXpkDgYS4JDy+W8PhJhelX/Qkw39JKR2a+5ZpXuLPKp6Rsok9vlygm8jTJ5FAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=euobFC6P; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVsM1rAYk1EsRbQ9fCgA0vR1CltRvp5U5lsVdroSsc01PTBz4ek9FHPf13M/EPqabkXrokZKyM8i1dBZm6KL0+ZtKTMbqWNpWFP6xbt3JK6BwQzhZ9V/JLJP90e+zXsGQk8mddEpjHcKYTqAim3SiGWR14BBIiRe4jXUUibexjOlvzWi62fRX07ud6Daf35NW5iSL3/7Z7ONC6pePiXq3d/+ioJpvPQ8KmQ3kZ1d1goxAL9SEiePnoBpzi5WltzngEtkXyyz/dRUoVjXANH6+IRSA2us+Wd2SGw6xtvMIGPOkYiVRsnkT9HMaQrUgbjzmfYiOiPNsPte94MwGYOTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sirDx/K9TLFrElbIpRa5XT2mU2IcR29mAKEvJFkAQbg=;
 b=Q+u0wSTrdvPWlGt1XNQogJsd8EKpaQmo1T7EwRWsLKGpItPghwveTROP8zS1jsTqcedOO35FUahVUV602lFnQQZWm0uQNjwwk0922OkqnSZ20Gys5utGCH0pD5GJ7KnHNZ0clrjMiZRg3oZ+1jL1yQNhgUMfvpClWVSW8cCSBi+tECtvWfjBMWhmceG6VJ2hNUDiqLC62P/4RtoT/K0KFEwBKBXrhokZ5HtsjslsJS80OfY/QD1noiCFz606FnISlBzl92aJYrcFCumt9+bpI0+Aazvjh0EzA0mcOSYZYsZnvgVa0KisOkOd7AN50yiya6dgYE+do6nNo8t6kt4T/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sirDx/K9TLFrElbIpRa5XT2mU2IcR29mAKEvJFkAQbg=;
 b=euobFC6PDaWLbXAB9cmTsMucDykaDchHVHlj4IvbiN7MJZiCLDRm4rC7DytH626Qet63dBh3BZ0ygNCIM4WZkQYuxQxujUbcd74xI2rCpDdRH1U4iArg7tIp334gWFX5U8aXTdLSPZxJmhrJv3Pm1XQiKZvAyBRg1jmFkW5i8m0=
Received: from DM6PR11CA0053.namprd11.prod.outlook.com (2603:10b6:5:14c::30)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 17:27:19 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::20) by DM6PR11CA0053.outlook.office365.com
 (2603:10b6:5:14c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Wed,
 17 Sep 2025 17:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 17:27:15 +0000
Received: from [10.236.181.100] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 10:27:14 -0700
Message-ID: <d3987c66-fc41-491c-95ae-07205a4baa87@amd.com>
Date: Wed, 17 Sep 2025 12:27:14 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] cxl/core, PCI: PCIe portdrv: Add CXL timeout range
 programming
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
 <20250730214718.10679-14-Benjamin.Cheatham@amd.com>
 <20250912165541.00004594@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250912165541.00004594@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|BY5PR12MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c768d4-0e34-4a80-223d-08ddf60f722b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2QwTXc1a05FVXlPM0ZCQkFYZ2Nvd29NR29XaEYyRzVQelpFL3AzNUtuZEJL?=
 =?utf-8?B?TDc2VkdSMGhCRUczMmZvejdKR2pqcWtsMDVPS1NvWllnbTRpWk1VR0NHYWVK?=
 =?utf-8?B?anN2UHYrb2NzTjVybFJiQTVueE13V1VvbEFDdDd3czJjY0VlZ0grYXU3cFEy?=
 =?utf-8?B?MmZHbWwyeFNndjR1Z1pqZWZ3czNzaUxYbkMvV09KV1dWY3pJSXNDUDNaSExY?=
 =?utf-8?B?NGNDZ2F2bjFLV0I5VkVHampZd3owa2JyZ3VKNithSVpvc0ZOemE3UWVHL1dL?=
 =?utf-8?B?ZU04TiszZFk4NVpuNmtXNTNtWnczd0RGTk0wazVhckRrVk1aK090T25SeHVu?=
 =?utf-8?B?MHNDak9PS2RSYkZtOFUxRnVBRGFkaldQUDdEQkFHaWN0WEYzYWVCVUJNVFZp?=
 =?utf-8?B?aFdHMlVlZHBKWlQ3MGNIR3E3V1VoazFPenpZUm9kLzZjVWNwejJWaE56Kzk5?=
 =?utf-8?B?ZnRjaUM5eXByUzBPakZnS1RVQ1hwUm5EdGJ1Y2tlbUhubDJWd3JsUlVuWFRC?=
 =?utf-8?B?QmV5SWs4Zy83bXNIK3pPNzdwbWdQS3RrWlFZL3l3eWxxYjBsd3VhQkxPcHR6?=
 =?utf-8?B?R0tpbGpWQm93NW5sZWxVeFJQNzdQOU4zaVZzMGtHek00RHJKSk9wblRIaU5x?=
 =?utf-8?B?N3YxOHNUOTMxRU9zNnBCL2JmMG5qdU5yaDl1RTF2bEgwK0hKTVhaeWpZNzNP?=
 =?utf-8?B?UnNMTUhWMmhKRkNCdFkvL1hVZy9pU0VrZkpjTUtqSmpWcjkzTWQzSkkrR1Y5?=
 =?utf-8?B?K0Jldml1UkVNb1hiYVdCQnFveVJLMzhLRHRtV0JvUEhyZldSTEVBd3hhdHhV?=
 =?utf-8?B?RHVuU3VZeXFxd1Fma3dWek9NSkF3bDFBbTN0TENleS8zSGtxVUVKemdia3RT?=
 =?utf-8?B?eUZJRnRNcUVYZ0NaSXo1MWlWbzZ4b3VmV0YzQjd0N0RTWUtad1RDVm5BVU53?=
 =?utf-8?B?SmpZZFAvWHV0ZGlCMXl2Z2I3OFNMZEIxZWpja2dKMFN6QUgramxZb2FXanRJ?=
 =?utf-8?B?NDlPMkZIMHNEZ21kSUVhTlR0OC94REY3OWdtMUdJYjZoaXB4RldRZjVZelVy?=
 =?utf-8?B?M3M4SVdkWUEyeEpsdHVyNDAvVUIrVXJUaituL2dVSll4WWdRRUIzemtHejVw?=
 =?utf-8?B?Uy9aVWk0UGp6cVE5MktMZ2FFQk9hc2V5a0tVMkEwbS9tWVdwV1RLYXpTMDI0?=
 =?utf-8?B?SDl2RUtER3NsV3MzTUFDT3JhR3dXMTNjUTNsS3hhSUZDQWpqNHU1cFg1bVo5?=
 =?utf-8?B?cFF5NTdZeC9wbFdQTzYzVGFacG9uRytaeWtVU3NjekdIUkRSZ0VJKzdFb3pV?=
 =?utf-8?B?eDFTcElGQ1RZZ2gvNC9Ud3dRNHA0a3Y5Q2V1cnVmbjdvbDczWmpzRW5OTURW?=
 =?utf-8?B?MTlYWDBCWnRJejBuL0k3cE5zQUwwRi85M2NTZmhQM09sMVE4Z3BwM3hNNzUx?=
 =?utf-8?B?UXRuYlNlV3FSZ3hWcVlSYnpycUlqMnIxc1RhQ2M4R2poOG50QlVwbFBBTmRu?=
 =?utf-8?B?dUcrM2ZQRWhJQTQwODNxZ2NvTGFZLzE1THZ2dXVLN3ZaVnlySDYvMUIwWVJi?=
 =?utf-8?B?TlFEZGxhVnBPelVSaHFPMFdnVUxFSDJKdlZ6V3A1M056ZkJLcVJsRWVGTDRm?=
 =?utf-8?B?SEtsdDdHeVZld0JFOUx4Qjc2ZjZJdzBQQ280UmRLTy81UDhoUjhoQ3UzSEV2?=
 =?utf-8?B?ZVViWVJqSWhudnRwMlVSa3Y0aDdMQWR2MzBiU1ZzNTZxU0J2RUg0MzA0OFlR?=
 =?utf-8?B?VWZXQWVPZWk5TTh2M3d0YUJ5cExXTjlFdHV2TXFEU21QYThBTjdHVjJ5VWR1?=
 =?utf-8?B?MFFiUUZZZVlTK3FkeFdBeXd6azgxSFBoMkFmMXFBbkoyUHpLQnJVVjlLYm9y?=
 =?utf-8?B?THk4dzI1eWlsaG1PaHZlanRMQmtoaUpndVFISHJsV2ErRkZxM1VrSlh3VEVC?=
 =?utf-8?B?Q1Y1YlFhVjNEMXQvR3dxL0dSeVQzVEFIdkpiVjZDSHBKaDE5Q2YxVlVRRzg3?=
 =?utf-8?B?R2E3T0ZDeEpEV2daVFlNM0xyamI2OGFkVkgxOGhrbWs1ajRqMmxURUZtQ2Zn?=
 =?utf-8?Q?UCXJ1F?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 17:27:15.6036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c768d4-0e34-4a80-223d-08ddf60f722b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115



On 9/12/2025 10:55 AM, Jonathan Cameron wrote:
> On Wed, 30 Jul 2025 16:47:15 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add functions to enable programming the CXL.mem transaction timeout
>> range, if supported. Add a sysfs attribute to the "cxl_isolation" group
>> to allow programming the timeout from userspace.
>>
>> The attribute can take either the CXL spec-defined hex value for the
>> associated timeout range (CXL 3.2 8.2.4.24.2 field 3:0) or a
>> string with the range. The range string is formatted as the range letter
>> in uppercase or lowercase, with an optional "2" to specify the second
>> range in the aforementioned spec ref.
>>
>> For example, to program the port with a timeout of 65ms to 210ms (range B)
>> the following strings could be specified: "b2"/"B2". Picking the first
>> portion of range B (16ms to 55ms) would be: "b"/"B".
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> This needs some ABI Docs.

Already done :).

> The spec is exceedingly weird, so working out a sensible way to present
> it to userspace will be a challenge. I vaguely recall the weird timing
> description is from some other spec.  Any idea where and if there is existing 
> ABI for that?

I don't recall if it's based on another spec. My first version of this had some kind of
translation for numbers -> range letters, but I figured it's overkill for something most
people will probably leave at the default. I added a spec ref in the docs for where to
find the timeout ranges, but I can probably just add the actual ranges in the doc.

Thanks,
Ben

> 
>> diff --git a/drivers/pci/pcie/cxl_isolation.c b/drivers/pci/pcie/cxl_isolation.c
>> index 9d2ad14810e8..107201b5843f 100644
>> --- a/drivers/pci/pcie/cxl_isolation.c
>> +++ b/drivers/pci/pcie/cxl_isolation.c
> 
>> +static ssize_t timeout_range_show(struct device *dev,
>> +				  struct device_attribute *attr, char * buf)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct cxl_port *port;
>> +	u32 ctrl, val;
>> +
>> +	struct cxl_dport **dport __free(kfree) =
>> +		kzalloc(sizeof(*dport), GFP_KERNEL);
>> +	if (!dport)
>> +		return -ENOMEM;
>> +
>> +	port = cxl_find_pcie_rp(pdev, dport);
>> +	if (!port || !(*dport))
>> +		return -ENODEV;
>> +
>> +	if (!(*dport)->regs.isolation)
> 
> Same issue with reference leak as in previous patch.
> 
>> +		return -ENXIO;
>> +
>> +	ctrl = readl((*dport)->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
>> +	put_device(&port->dev);
>> +
>> +	val = FIELD_GET(CXL_ISOLATION_CTRL_MEM_TIME_MASK, ctrl);
>> +	for (int i = 0; i < ARRAY_SIZE(ranges); i++)
>> +		if (ranges[i].val == val)
>> +			return sysfs_emit(buf, "%s\n", ranges[i].str);
>> +
>> +	return -ENXIO;
>> +}
>> +DEVICE_ATTR_RW(timeout_range);
> 


