Return-Path: <linux-pci+bounces-33242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BDEB171D3
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 15:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D42A580488
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 13:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481642C3240;
	Thu, 31 Jul 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yKD9Pqm0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE422F740;
	Thu, 31 Jul 2025 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753967601; cv=fail; b=G519Q4uJQn7x/Li0z3Rgqe+3frrHXjali/bSN6/NbQHFJMm+yoDUb0O8tJkehFqLcQgNLNwyN2XKTWU9DuKrdLmUO/bWgy/L/E09TF5YO2eRBM9lKgtM9fDdPN6Mz2ypmg0BRG3kW4S3IAotcJK0GE64ZVPQS84VRJSD2x/H1WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753967601; c=relaxed/simple;
	bh=yfqfMoYdnWhQfdIcGBr5nbTfs7Y7SZfGdtRnBbDOWaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZT/Sm1hAcLTz/CILac/jJSQ1RJe3rShcxXsZJnbmVZjTIZeZwF5oi208krUpvgAzXlxgXu66iuO931ZNYo61hEgEXWAHJ/zAWBKMJQFZeyYPzI9vzlEMikuNZRpe7MhW84U0eYIVkbxQD06vGt3/3nDtI8gvrQ33bRhb7xi4K1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yKD9Pqm0; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPq/TXCSmR914YsiPgZm1E//QTAYrixmnZa60Xf8eUxTDeezz8NXPXO/xgarT1pedqzW6C2HpD6XbXXIh9Pw87owYhVFM8Qm5mjSODh2pLvtpqCLwiNd+FIYXvmagqFx4Yv7ALw10/JYYI32mGySySDVk3S64iIILbr3eOlLjHNHDunzeXenfbVMgZiv6khNU4FwxUX4em35Q11roPho0SGNqRk3wj8RBOAM4UfbuBXZ3WzNGWQhWiM2pzqNAFOMND9npGycvNuM8Syt7Ib3tok4gJRM1iTIx6s9n8mqXfH+exZXjtgmeGXQ21H6ZKn+VoG3+MlIqu/DUBhAngqQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVMeo2ANGmyrmc7FXmQIs9IjEwEATuiukEFRx5zQvjM=;
 b=MeF9Wo6cb89YM81AhExC6Nyn1RbVgRTAU59qbJhyhFKzoyl/fqbnV9oyApr5DL0ST61fVtSGWbxLn39Cqwr01xC9H5tE8ua0wJ6Q1IWYxiD0SR7qJY8Om9dIISGU5Byg/4iVE2HyuYIvBy0AshUg8TraGTsZkMP58GbdZjO8Dd3WddlXObVCSDIy5Qz5hlzLSX8ljkM/9pH9tdG8VsFQO2aWMPPd7Os6/Mhzu8inTXjl8fBMHhKe+LNCNyMi4nne6JbnS2JpQ/lJmFNHxcN84NXRpEwk7WkqoPQfKfZg6OXJ9QfA0pVm7Sw7x3Srh6hP0mLPxJ1mjOdUD1cEcL+Rfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=wunner.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVMeo2ANGmyrmc7FXmQIs9IjEwEATuiukEFRx5zQvjM=;
 b=yKD9Pqm0r9g9VhCkQu2tuZXl6pP44KGYtIXfFEkzL2IdTtna9Y97ci8ESb27IfYWdEe6Gj4WnJBU8saT1uoyDbyFJp+bxFebAEVtEbnQr2Iq/ckOUfxd1yD8gL+fNPFCcGMWwrecpuBgBDctQcICqFKGvZOJrxUt60RNkTrqHC4=
Received: from CH2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:610:4f::32)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.12; Thu, 31 Jul 2025 13:13:12 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::a2) by CH2PR18CA0022.outlook.office365.com
 (2603:10b6:610:4f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Thu,
 31 Jul 2025 13:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 31 Jul 2025 13:13:11 +0000
Received: from [10.254.54.138] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 08:13:10 -0500
Message-ID: <f4d820a5-958e-47ae-af09-1012c08545be@amd.com>
Date: Thu, 31 Jul 2025 08:13:05 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] PCI: PCIe portdrv: Add interface for getting CXL
 isolation IRQ
To: Lukas Wunner <lukas@wunner.de>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
 <20250730214718.10679-6-Benjamin.Cheatham@amd.com>
 <aIsGX3wPKN-PdXis@wunner.de>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <aIsGX3wPKN-PdXis@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 2962ad7f-4bdd-4026-991a-08ddd0340045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1c1TVNpS2g4b1BBV0pGKzdidXh4M25sbVZLNW9rQWZtZWVvQlVmQ0d3dWYv?=
 =?utf-8?B?Mkk4aWo4c2lENk1UNERQSWJ4QU0zV3ZDeTE4M1RZckc3ZGI4ZDJQSTNuTlJY?=
 =?utf-8?B?andnQzVnZ1NLRGtPZFFweEZtZm8wK3I2WGFZcTB3K3pxeFZXdjlyRkllNTBK?=
 =?utf-8?B?WCtOL1YvZFFnSjV1Tk8xSy83a0JvbTYrcHorOXJsdWdBSGFoR2g2cStRbHVS?=
 =?utf-8?B?NEFoUllYRndFVW55ZU0wRUQ3ZTNhODJBQTJVSi9OVXhFRWl5aGdueHFLZ051?=
 =?utf-8?B?VVBnUytSWDNWY29pMi94N0h0VXFHREd3RVlCUkcwUU5tbzlBT3NNbG8vRVdP?=
 =?utf-8?B?c2swSGRvV1JOMFV6N2RxU09hL2RuSVcrNFBQMi94bG9tUUh5MGRCM0R0bnFk?=
 =?utf-8?B?eTR3OGlWT3ZaeXozMDZxNXUvUUJVbWdrVmJWRXFNalVUeVFPbmU1cVQ0V1Yw?=
 =?utf-8?B?S0ZqcDZSWkRoRHhROGdFK1lxdElJdW5FMmhvSzZ3VUlRRkZmblBYdXdsYnVX?=
 =?utf-8?B?TDRWbWZzWUx4ZGsreHBYaUlST2t1QmdjbDBrZGRBaGRaaEQvNkJDSWo1Z2ZZ?=
 =?utf-8?B?OEdzMHEya21kaWJDbkxiTVZ0dmpWRW5zcU5Jc3JwSDVYY2kyMm55MTJmdEps?=
 =?utf-8?B?T01lUlgrblZzRnU0U1pDRnU5MXZPaVUrVDVneDJZV1NJYmZvQkpaSExUSUpo?=
 =?utf-8?B?Y3N6NGJIU2REdlpvdW4zOWRRSzFYeW0weGc4LzFzdlBhMEh5dUR4Mzk4VVRM?=
 =?utf-8?B?YjE3bTJaaEVnWjQ3a0Yvejk0aXpDUUdpbGo0a2JlcGtjOTVDbW5kbG1xL29O?=
 =?utf-8?B?V2ZadlhJMlNRemFySnZOcmEzeW9STXdrVC9RZ1pIOS9QU1ZOK2NJN3U5QnpJ?=
 =?utf-8?B?eHVXK20ydElaTEhFeE1RSFRwc3g1Sm1QUXhsZ0Y5NVpKUEt0cTlxeDFTSUhs?=
 =?utf-8?B?OGtOazlwOG1jNnUwQnhyeU00eVRzSWxWWmpoSXpPOXJYRDJ0eGxBRkRlUUtv?=
 =?utf-8?B?eHpmRHJqUllwWkdzV1p5MHVhSHYwZDVXaXJUV0Q3NGJXOEhybGN5K3p4cTJM?=
 =?utf-8?B?RldyRFFHSVova21NL0xJWjgyL2xVeGJCdHFsd1J0NmVFNTJpdVhuS1E0VU1Q?=
 =?utf-8?B?d3Nra3EwTFBSbU1DYnZYNmZzN2tRZHFXakxOenNuWW41bnIzRHc1dDFLYlZx?=
 =?utf-8?B?NktxZVFwczgreDRiTXc1dUN5c3VoWFNwUmZzMVoxUkk1VHB6YVVCNTZCVWFH?=
 =?utf-8?B?aUxFTXk4aFJqQVd2VkZLMFlsRXhTcjZhbTEvR2RxRjFMQ21YUmpPWVo2aVpK?=
 =?utf-8?B?aFR5cDNwQ2o1RmpiTjh0VVJVUWRuSVg2SlVEdHhDV2JUbVRpRkNFT1N1RDdD?=
 =?utf-8?B?WXBKYldKMVAySm9CaVM2Qk5PTnpoOG5SYWJtL3RKTVk2UU9oNTJlZkpTcEJP?=
 =?utf-8?B?U3RvM3B4R0h3SGFqNDJYbERoaVhPSHJ1Tm9aeXZCTFpLK29xbWlzVTZvNGNW?=
 =?utf-8?B?ekk4ZzJjYnNSWjlyUXI3L3A1M3cxWmRiSGxacEpWSWFoZmxVYWF2WGZxWlox?=
 =?utf-8?B?WmF0dkpSMU9HVERyUXVGMmtoRzlYRGZBdHZZdnQ1WHE3b0l4Sk9ROXFmQ1NX?=
 =?utf-8?B?N084QkVSNk9hdE5uc3F3YWNKSnpOVFprdFFqNzJtWVNVbFNDWnhZaitBMlRO?=
 =?utf-8?B?QXA2WWl5Y0RkSHRVTDFQSlVRVk52czRqUWNLQWZqWnV0d25FME1CWE00VjA4?=
 =?utf-8?B?VG1zR3dRb3JSNkFiYUpLVjZOTHhLbG1OQWd2aUhJdXI0ZzNIdENkYVowTUwz?=
 =?utf-8?B?MEtZM200dGtZcmtmV2tKdTdqejg3MXM4Qnh2MTMvMEw2WWhVVnZBRzJqU2tR?=
 =?utf-8?B?WmFFMEdUUFVrQ3EyQzZWNXoyd25QYkFzczJpR2lYS2RYQnhibEVZMVg2UGc5?=
 =?utf-8?B?d0k1QkthdnZDNXQrc1dReGlveG9QOXllUVpybnFHOW9GOVpDZlROczFMSG5P?=
 =?utf-8?B?Z2pMS0xhSlN0eXA3RVpjK0toeU51clM5UEwwdGZHT1BlODNTYlc1eFFGcWtS?=
 =?utf-8?Q?V4RlpT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 13:13:11.7153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2962ad7f-4bdd-4026-991a-08ddd0340045
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010

Thanks for taking a look Lukas! Responses inline.

On 7/31/2025 12:59 AM, Lukas Wunner wrote:
> On Wed, Jul 30, 2025 at 04:47:07PM -0500, Ben Cheatham wrote:
>> Add a function to the CXL isolation service driver that allows the CXL
>> core to get the necessary information for setting up an interrupt
>> handler.
> [...]
>>  static int cxl_isolation_probe(struct pcie_device *dev)
>>  {
>> -	if (!pcie_is_cxl(dev->port) || pcie_cxliso_get_intr_vec(dev->port, NULL))
>> +	struct cxl_isolation_info *info;
>> +	if (!pcie_is_cxl(dev->port) ||
>> +	    pcie_cxliso_get_intr_vec(dev->port, NULL))
>>  		return -ENXIO;
> 
> The re-wrapping of the if-condition shouldn't be here, it should be
> wrapped the way you want it in the patch *introducing* the if-condition.
> 

You're right, don't know why I did that :/.

>> +	info = devm_kzalloc(&dev->device, sizeof(*info), GFP_KERNEL);
>> +	if (!info)
>> +		return -ENOMEM;
>> +
>> +	*info = (struct cxl_isolation_info) {
>> +		.dev = &dev->device,
>> +		.irq = dev->irq,
>> +	};
>> +
>> +	set_service_data(dev, info);
> 
> No, the irq is already saved in struct pcie_device, there's no need
> to duplicate that.
> 

Good point, will do. I think I originally had the mapping of the CXL isolation
register in the struct cxl_isolation_info, but it makes no sense to keep this
around anymore.

Thanks,
Ben

