Return-Path: <linux-pci+bounces-10276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 301F6931953
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8E61F21F54
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F653BB2E;
	Mon, 15 Jul 2024 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vI5Qr8WJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457AF1C698;
	Mon, 15 Jul 2024 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064648; cv=fail; b=oZTOHDmhLpWjnlHA1rWS2XZR+D4L0btGzZRAOPV3gRHF+1/XH+Z/tPu4AFliA/uifY07jv1iYHkC+roKQGDkj74IMmBps2YJFw6uKd7umSaukL9r5u4+Af9/TQxhCW2PDLbTudKJ5ZV3V+1vuOliL5/K7v4hiTISSyTkzMvJcFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064648; c=relaxed/simple;
	bh=uvOxxkZ9/7OpgzhSdkRX4A8zdIoOI7mEGx8UAAOi+xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c3jXOL4ZjWuxPenH3iNl30ng4qeNVUBuBafaXDnCVG82MajU/aKCGprmd/fhD/rQk6KGOVCKv7aa/PqslrURmLVjOhdkuCdcA/swe+1kwtgRt4cnT3odU2SVh33ok9e60n/CQNl+SFgoVBAQjDnVsRkjY+/tNFF9gbjj8NUX6NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vI5Qr8WJ; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyFsCM88U768xDnW+64nOrkKFEr7pWIm8UKUMdBbnbMcUyL6Ub/pYl9qb2sEZd5WrP6+Vn/02Pky6aV0zoJTJBrXFaxtoDs1rnBKCg1PbLfo0gQaYQC4+6nwFPPLIjAe3PI/+G4rzzugOF1QUEaEKN9uNqvsBsswtm3B5VCnOqUPS6318D1IcLbkVaWjUc8PB/7bV+HddvZnaZW2rrMJMi0M5gCyz2RKEbQMLZadt5CxVGO6CmOh7rSUQ8ycsYnVxd1eVNdki4MK0qupDqEKMc4vQ/ocXDMN0RhCSoMBfR3fdqpAvYvvkl26RZ5T58rUevsRCwZJGzFXx8Ls8F04fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+zdZx6amfXkDbzMfawUM1FMoJe7Vq5mwPNO/M30W40=;
 b=uAt10YDmmeKsYdoZ7c6xtLPAcyaYsLkbjLoYIsBYVm286vWtH2rGSKJaPmfHhiZ8oBpY6jmVMbCYFEd6ENWHXoKS2Og2ebnYK6GEdQJRE05brUppwrDPnh+d0GuANY7M7MRoapew0itdRgyiUzqU5+xhEdBZDiXKhzFsdSWGFWInZqlEvguh2KxDqF7cBsRoTuLHZ84zLyydsSRKMr9PC7fh/c1jZddZenCzEfyLDCk6o8be3+GPClNpb9kLYKUQMyyl3sS+UHPQ6LRkxkYaW9yW9ArklbGUnp6uOxYLi51VruebwS9E8ZY2BX9TOnwHJ0lYaHpJQ5HEN7wqz1XKXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+zdZx6amfXkDbzMfawUM1FMoJe7Vq5mwPNO/M30W40=;
 b=vI5Qr8WJ+Q6arPDY/d2xb0JjYBqdSXbqbk20XUc0CWgxRdRqysTC4Gc/wN2yXeNuIWljBIVsY4/NR9iVDUgAqVC1ooYXj2xF5v8vGNDQM4QXhxpxqOPxPSYSBK6x3RiKbsufCMFuzGV4KKEK6l1CJQkvpmMwC5rWcFwqvuBN7Pc=
Received: from DM6PR05CA0048.namprd05.prod.outlook.com (2603:10b6:5:335::17)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Mon, 15 Jul
 2024 17:30:44 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:335:cafe::48) by DM6PR05CA0048.outlook.office365.com
 (2603:10b6:5:335::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13 via Frontend
 Transport; Mon, 15 Jul 2024 17:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 17:30:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:30:38 -0500
Received: from [172.25.198.154] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 15 Jul 2024 12:30:37 -0500
Message-ID: <6adb0f7c-1b1b-4384-b9af-7c3c50e16147@amd.com>
Date: Mon, 15 Jul 2024 13:30:36 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] x86: PCI: preserve IORESOURCE_STARTALIGN
 alignment
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	<x86@kernel.org>, <linux-pci@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
References: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
 <20240709133610.1089420-5-stewart.hildebrand@amd.com>
 <22e339c1-0ada-0824-cd34-d5779328b522@linux.intel.com>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <22e339c1-0ada-0824-cd34-d5779328b522@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c26fe3-f603-4a8c-2ab3-08dca4f3da8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1hEQmdxK2dCRE9jbFR3R25HaUNNMG5uNVQ3SGcxU1U5NjRyazlOS3BQOVRO?=
 =?utf-8?B?OWhmcnFUclY3ZW9xTmpTMlNMTFdXRnFYenNJV1ozNHFwbGJ5ZUxKOXBOZnJM?=
 =?utf-8?B?ZWp4NlZmOGxMbWpoWlV3RURuaXVOMVIrQS8yVmgwTXpvN2VOUElCeDJUaExa?=
 =?utf-8?B?TU5rUkh6eEFEdFpJdmhWYVdQMnNobVo5bVpjMjBVVDZZQzlYTmp3Z1V3YkZX?=
 =?utf-8?B?VUZZZVBna3pBeXhieUZoeFhyeXFISzkwMTF3elgvenl2S3BremM4VEJLTTJQ?=
 =?utf-8?B?NFQ2alJVTHFIVnpOWUJmeUZFMG9VNGFiNnllaWljUlp3QlFtcDdUOEVmVlc2?=
 =?utf-8?B?ZDA3L0VzbllzRTJYSlFCeE1vVmQvNXp1eEFnWkpxWUk1TThPODVBa0JEQmhJ?=
 =?utf-8?B?YndaQldlM2hXYTBiMjV1OHU1N3kvTjd0TGJCY2dpdy9MVXN4ckwydDJ0eUdl?=
 =?utf-8?B?dW94elRjTnV4dXRNUmJkUWFNYnMvSUZOQTFPbTBRYWw1T1FaaVJiMWxaWHFx?=
 =?utf-8?B?dktDSUJNMlptNHZmMTZYZXdHSkd2b0xIVnk0aHJhVzBXdXV5aDF0ZitneHZr?=
 =?utf-8?B?YXVsYWZ3akV4VFZ6VTVYcVN4UVA4K0QwcjVXODdLTlRmMlZNK0tqNnFuSm1Z?=
 =?utf-8?B?OHpVQmdhVXFXZWRVbkFzak9SOGpvTVFKcElCcUl5T2YzMWhVMmdtcHB2cEdS?=
 =?utf-8?B?eUUxY2ZTbGRraitVU2RSTkJ2N2NYQlpEOUxMei84QklSOTBFU0lZMGRQWnJx?=
 =?utf-8?B?NVRiRlIzVndvWXlXMzM4Vnd0TWVwZnJZcU9WZmxtbmxwaXlhNkR3UkxLUXE1?=
 =?utf-8?B?QkNneThYYTZKcEtiTDRURGNkVUNBTTBDYTR1bUZCR24wZ21oS1A1Vi9GcUsz?=
 =?utf-8?B?OTYwL1hiaG5tajlVVVlpQUhoOWV2cURxOEsybzhUSjgzRVc0TC9NbTVmaXdm?=
 =?utf-8?B?alB2dWdGTG1sMm81Ty81cnhnZlBKSnBaM2ZGUDc1anlkMFp5SDFFSUZWOWxB?=
 =?utf-8?B?QytsMERUYm5xcm8vUVpoNmFQb3RWbW92c0tIcDJuemt6b25PZFNEWjBpakZn?=
 =?utf-8?B?bnhGRzlNWDRqSmwrd0FHNEFnUDlMN2lLZkxjdmxGL2QwZlJYUFlRVE16dVU0?=
 =?utf-8?B?MjNyRGdUT2pBdzBYbmR5cm9tMDh0YzJqRGNkRHVYQ1NEVXN2TjhYd0E5K3lH?=
 =?utf-8?B?RDhmbDBMZzNyQkN4aDV0TXNqQVd0M1JFZGlwLytrWko3RWdpdmFBcllCdDUy?=
 =?utf-8?B?cENuY3ZMRjkzUjZSZ3NqbngrRDJDRUwxc3htSmtTZVIxSWhOYTdPZU9zTFhr?=
 =?utf-8?B?SURKdnFnUCtJa29tU3Z6TStUajcwZ0JTNTZYQXN1YjlRLzJBcWY5ejhmYitF?=
 =?utf-8?B?YVdBcmNEQyt6cno3ek11N1d1VGtMS2RzbTJwdE9iYjhPSUJFVUUvNmtmR3hS?=
 =?utf-8?B?Y0dNeXk2SFI0KzdGVnlRTlVNUXhPb2NPMmxLZGZXbVY3dlMrdmttRUl6MVUx?=
 =?utf-8?B?elh0MnN3QUoyazEzRWpFNmdBa3VKdlhTLzBncDNnaWRnTktUekF1aWtwVlg5?=
 =?utf-8?B?c3J1L1pnVUdVSXJxSk5ramh5VkFaMlBWMGRjSjR3ZVpwNUhXTVRWYWxFaUg0?=
 =?utf-8?B?djhmcktTY3Y1OVIzNklKaURKWU03RkliaHllQjVqQ1F0MDJjMlZnRzhYYW1r?=
 =?utf-8?B?ZlhUekl0V3BXNWJCcnNvTkRkSkxETDZUdGFBNGxOOXp1c0wxOFhnc2NUV0ls?=
 =?utf-8?B?N0t2KzFzSUhTeFFPM2tqaEkydVg1eDNieDlOcEZmSVdEUU1adjRFTktwT3BC?=
 =?utf-8?B?Mi9CcGRvcFhZZzMzc0ZWd2crdjFUWmlCSHZrV0owSWhmbUNURFY5ZHcxQTda?=
 =?utf-8?B?aUltaWF5QmhNSElVQlV3Ky9OaGJNWmtvb3pCTG5ZRkNvT2hqSGNBOWgvSW5s?=
 =?utf-8?Q?lvpzEcHeesWQP/v4clhn1iFw3BhoEnja?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:30:42.9523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c26fe3-f603-4a8c-2ab3-08dca4f3da8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211

On 7/10/24 10:05, Ilpo Järvinen wrote:
> On Tue, 9 Jul 2024, Stewart Hildebrand wrote:
> 
>> Currently, it's not possible to use the IORESOURCE_STARTALIGN flag on
>> x86 due to the alignment being overwritten in
>> pcibios_allocate_dev_resources(). Make one small change in arch/x86 to
>> make it work on x86.
>>
>> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
>> ---
>> RFC: We don't have enough info in this function to re-calculate the
>>      alignment value in case of IORESOURCE_STARTALIGN. Luckily our
>>      alignment value seems to be intact, so just don't touch it...
>>      Alternatively, we could call pci_reassigndev_resource_alignment()
>>      after the loop. Would that be preferable?
>> ---
>>  arch/x86/pci/i386.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
>> index f2f4a5d50b27..ff6e61389ec7 100644
>> --- a/arch/x86/pci/i386.c
>> +++ b/arch/x86/pci/i386.c
>> @@ -283,8 +283,11 @@ static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
>>  						/* We'll assign a new address later */
>>  						pcibios_save_fw_addr(dev,
>>  								idx, r->start);
>> -						r->end -= r->start;
>> -						r->start = 0;
>> +						if (!(r->flags &
>> +						      IORESOURCE_STARTALIGN)) {
>> +							r->end -= r->start;
>> +							r->start = 0;
>> +						}
>>  					}
>>  				}
>>  			}
>>
> 
> As a general comment to that loop in pcibios_allocate_dev_resources() 
> function, it would be nice to reverse some of the logic in the if 
> conditions and use continue to limit the runaway indentation level.

The similar function pcibios_allocate_resources() in
arch/powerpc/kernel/pci-common.c has moved some of the logic out into a
separate function. I'll do the same here.

