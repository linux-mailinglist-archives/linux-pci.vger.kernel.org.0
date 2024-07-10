Return-Path: <linux-pci+bounces-10098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AD692DA23
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 22:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC82B2371E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 20:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BEC8289A;
	Wed, 10 Jul 2024 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U2Wvolcp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC595193068;
	Wed, 10 Jul 2024 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643519; cv=fail; b=kZYFmnMMK/mElFU9t7LVo47m3Zcom8o2n3LM6l1XH6eNt+9Yk0I6cxkEZ7u5tMb5s3HIB7UTFY8cHhQrfBt0r2NZfk5UZN0h2FyqnDz5H7fRn4n22HPvdhwyUek19l8IB4k8DeTHZI/gbR+lFnU0Ae0AU6ElpB4ly2y7mtml8SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643519; c=relaxed/simple;
	bh=msueP/Sa8oUocjommD3h70bNF1frkzzU3pZmbcPV3V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kwINg9LcdXnX/Qwbs2QdId2TRmg1zpvM7YyrIzkc6xBJkLYQ9Jxf2ZvEaDwRPHFXiHuMdVetDTJ2N8panw9c3WApmo2FwjgNGCo3O5emCnDaUzuY2QHa4RvqUx11iZ3Tilp+gqUJso1M9vGTMFseO9In9TZ5Yks1rtTng8KW7BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U2Wvolcp; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpaGFUzKV70g/dGsuMYRhxQPCwJoerFJ0fzfU9mymQnSEEJN6E/Bn/TARVJQfEm3ID/zUS4qJPIk+IklYGC+0mfEDF0Mkjs4UiEbYGp1OBgbnnzUvhSs6zCvkIWKn4kTdm3yyvMbT4RKtgUmHcVpeb/XMnZro6lN28qgDWsCgY4RnLV2If5RSqaLWDsfn/PHilj9VCe4eCMewsOT8/pVLQlF9wQg1fCOboZ0zmqbPRowkG7CjTrle76LEY9K4PQiEISfmNC8vGiOfY4x0LtZqViDg5xF6WPt+W06HbM/P7wfgHfBa8AvgLMQgdtsIT943GwxN9hiFvwWqNA74dJs1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wzt7IM6PIc0MpS9h2RwlTYmB3imstn1QfgeZ8lD8JnQ=;
 b=MzLTLqfCDQEnp0o/zBIb6pBGxJ/oDXHgvFbaB5MU56DmJpb8qvMfr0amxZ3z/FhU8gy5lPL6x785PCSYXEvk/LzVnqhJcZBH8KPR82bQaFr9sk/tT+1DujAmx5TXu8inm6IVjp1WCVoNBthHHB/VJ4YPilGDcSxEcku6F4IHiFHq/DehGo8Z3m7IqE2EFMV5sNlElMeFcs3mYq7W4FaHj3VNlwx4FFAWMfQrT2SnM6FxsK+5P9/zshDZ9jnBIeIF48pY78AT+NderA3VrXqnKAX4hA073BFoIZcsgPWHZu32EkG0npaaJNb2SWtz1DxtjZMF5AvKS7lCqg55DseaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wzt7IM6PIc0MpS9h2RwlTYmB3imstn1QfgeZ8lD8JnQ=;
 b=U2WvolcpFQyMt4fRv7k9yxMMx5sB3FLXO8YG3aLk1NxJkUUibebSiPpdtRF5/7jzj1xXAUqaki0Pk0BsxFMkXZKV4Ee9cFzkfG6QytfEhjICMJL2IKUkPHXfT2A1Uny3jVWl/38XdUUHTi8vM6ZBMYdKYPKhpPtaatEHCPdYZhM=
Received: from PH7P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::6)
 by PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 20:31:49 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::69) by PH7P220CA0030.outlook.office365.com
 (2603:10b6:510:326::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 20:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 20:31:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 15:31:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 15:31:47 -0500
Received: from [172.25.198.154] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 15:31:46 -0500
Message-ID: <1d0b52bd-1654-4510-92dc-bd48447ff41d@amd.com>
Date: Wed, 10 Jul 2024 16:31:46 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] PCI: restore memory decoding after reallocation
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240709161646.GA175516@bhelgaas>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <20240709161646.GA175516@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b79d89e-d5ee-4964-5791-08dca11f530a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1R5QU9mak5SSWV3UkZaWGgyYVJXUTcyWG5iSlFRQjdLTGduRFpFVzR4S3lj?=
 =?utf-8?B?Wk5uK1NuRDRHUjdhdUNxa281dVNTbHBwcXk1TjZnK2VnRmRXcWEvNkYxdHpV?=
 =?utf-8?B?ZDMzYmhlRkxNMS8xUHFXSkxiL0xYT1NYQU0zRnM0T3JUeHdEMHN4MXZlNXI3?=
 =?utf-8?B?U1lSbmVJRGxsN2RrSHQ4cGlQZEt1V1N5VytPTkdsQjFZeEUrc1oyU3NlcWNo?=
 =?utf-8?B?SmpMdTFrWmJvWlpGcW1vUTRSaDF4K2RUeVo5UzBWUjRqOGQrU1JiTnNkZDE3?=
 =?utf-8?B?Y0dyc0xHS1FkbHRBb09qZExOa1pCRHBMcWhFRW9LcjNHMlZJWFA1akZjSlNK?=
 =?utf-8?B?K3pmTnpUb3ZTMFdWYnpwcjdrWC9BMGw1ay9qNTk2RnQzV0x4aWhnSmc2dG1B?=
 =?utf-8?B?NGxKRXNRQXV6ZkZvTml6bVIxY09NV3g0NjdBdWxvaGMvTmM0ajhOWWxZb3M4?=
 =?utf-8?B?OVZtVmYySTV5L0ozT0RhOHdsZHRwUlJRTHM5TVR4d1NlWkZqQlI0UTNybG4r?=
 =?utf-8?B?eWk4dCtCSG1LWnplczc2ckRMZ1EyZWtITFNNVUVsbm5QRmRXVmc4YUpMV1pO?=
 =?utf-8?B?Zm9Iam04M3lES3FCM2I0ZmhlRVBzWkN5SSt1OVlvaDdXZFBjei9UZ29kaWxF?=
 =?utf-8?B?dFpJQWZQcnMrZm1JblNVbkNHU3J5SU82L3N1ZXFwbks4c0dCZ0lib1dlcnZl?=
 =?utf-8?B?bHpZaVh4dDBMMzlaZ3BDalExNm9MTGxSejBOK0lyNmhQZHNMUkJjcitRS2xm?=
 =?utf-8?B?cDZrODFjQUsvYVF1alV1elp3Skc3bFJWaGRNaktMTlNLa1BONHBiWkJ2cDRC?=
 =?utf-8?B?SWd0TEYxa25nN1BaT0xiOEp4cXpUY1kya2ZkYktEaWJUUTBhS2lsNjhxZDl0?=
 =?utf-8?B?cjBDR0xBRXJCVVZETWROK1RFemtvb2lpTnZJYkVhWXRHL0MwcjJMT0RqQk9J?=
 =?utf-8?B?dS9IdnBlOHpiN1VyOUk3M242RkdHbUdTbmNxVlM0TkFFVlNvUGhpS3hNbnVF?=
 =?utf-8?B?N2JNdmo2cFpZa0JhOXRKdmhlTnhJalNDZGdFbXJEZ083T1ZNc0JkUUFoeWhM?=
 =?utf-8?B?bVNlUFpRdWJVOEROb1hWZXNTS3lmVEhPTVpUWERFcHd5TXptVGx4WGZpV0cx?=
 =?utf-8?B?Y2swT0RUejEwMmFJWUdycnZkNzMxRWlZTGkzT0hDd0cvZVlxYW5FczdqZG13?=
 =?utf-8?B?QmtCL1lvalc5ZklIRVFpQVNyWjhRdldIOGdaeTliVzlXSU04QUNKTnpxVFVN?=
 =?utf-8?B?NnF3ZFJuL1J4WTNnYmN4d25rZXpzSmhBc1YwOW9GWTgvcG9mSUg3RlM0YTIx?=
 =?utf-8?B?OU1FU255dHVmZG1nYlFWY3hFckJiYlJMT2t4b0swYnlsRTZSNkl4dS91aFlT?=
 =?utf-8?B?V0wxZk9xL3BtQ1NMVklsRkhlVmp0MFI5dkp2aXphNk9jZE1STXZMTndCamNE?=
 =?utf-8?B?NjV5SjJocm4rVnhIcXdZMVM5WG1URHEwYTQrcDQvMmJKYTEvcWZxaFJCeWl4?=
 =?utf-8?B?M2lXWnhqNGNqK0ZPY1lVYWVYYnRxS2JhaVVFcDdBY2p5RHhEWEpOMUkydEE5?=
 =?utf-8?B?Rk1QZDRHQU5reUwzUUxNTk8yenJvd3pZc1JZRmsrQ1Q0cmhCVzhkUDhoN2ox?=
 =?utf-8?B?dHd0blI5L3MwNmxGWVh1WnBzamNjM1B2OTBhK2RWWW04MVg0L2VLZFd3a3ZG?=
 =?utf-8?B?bjhVUm9NOHVpa2x2VVZNd0dOeVl2NzI3MEFBZ3Y4Zjh5alBGV3NXTVgrUDhl?=
 =?utf-8?B?dmtKeWhGbFp5ckl4ZEVIUmRQNEtiR01FdUM3ZVpoZE5YekdVUi9kQjdCQlBU?=
 =?utf-8?B?QjgwWHFWMERJOFd1eE1QRU4yRmN3QVZtNm9NY1RaR0Q1bGphZjdRUUtJYkhx?=
 =?utf-8?B?aWZDMDZUY2JOaVFQZVptbVdSdlQwQk1nL2d4YnprN3pKbkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 20:31:48.7137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b79d89e-d5ee-4964-5791-08dca11f530a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423

On 7/9/24 12:16, Bjorn Helgaas wrote:
> On Tue, Jul 09, 2024 at 09:36:00AM -0400, Stewart Hildebrand wrote:
>> Currently, the PCI subsystem unconditionally clears the memory decoding
>> bit of devices with resource alignment specified. Unfortunately, some
>> drivers assume memory decoding was enabled by firmware. Restore the
>> memory decoding bit after the resource has been reallocated.
> 
> Which drivers have you tripped over?  Those drivers apparently don't
> call pci_enable_device() and assume the firmware has left memory
> decoding enabled.  I don't think there's any guarantee that firmware
> must do that, so the drivers are probably broken on some platforms,
> and we could improve things overall by adding the pci_enable_device()
> to them.

Agreed. Well, it would be vgacon, but lspci -v doesn't actually show any
driver attached to the device in my test case. Presumably because vgacon
just uses the 0xb8000 buffer directly without any sort of PCI
involvement. Memory decoding must be enabled on this particular VGA
device for vgacon to properly display a console on the display. If
memory decoding becomes disabled on the VGA device (or fails to be
reenabled), the console ceases to display properly.

>> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
>> ---
>> Relevant prior discussion at [1]
>>
>> [1] https://lore.kernel.org/linux-pci/20160906165652.GE1214@localhost/
>> ---
>>  drivers/pci/pci.c       |  1 +
>>  drivers/pci/setup-bus.c | 25 +++++++++++++++++++++++++
>>  include/linux/pci.h     |  2 ++
>>  3 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index f017e7a8f028..7953e75b9129 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6633,6 +6633,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>>  
>>  	pci_read_config_word(dev, PCI_COMMAND, &command);
>>  	if (command & PCI_COMMAND_MEMORY) {
>> +		dev->dev_flags |= PCI_DEV_FLAGS_MEMORY_ENABLE;
>>  		command &= ~PCI_COMMAND_MEMORY;
>>  		pci_write_config_word(dev, PCI_COMMAND, command);
>>  	}
> 
> It would be nice if this could be contained to
> pci_reassigndev_resource_alignment() so the clear and restore could be
> in the same function.  But I suppose the concern is that re-enabling
> decoding too early could be an issue in a hierarchy where bridge
> windows are also reassigned?

Well, yes, and, even if the bridge windows are sufficient and we're just
allocating a new a BAR, that happens later on. If we were to return from
pci_reassigndev_resource_alignment() with memory decoding enabled, we'd
have the situation described in [1] with our knowledge of what the BAR
contains thrown away while memory decoding is enabled. We'd also
potentially be writing the new BAR while memory decoding is enabled.

>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index ab7510ce6917..6847b251e19a 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -2131,6 +2131,29 @@ pci_root_bus_distribute_available_resources(struct pci_bus *bus,
>>  	}
>>  }
>>  
>> +static void restore_memory_decoding(struct pci_bus *bus)
>> +{
>> +	struct pci_dev *dev;
>> +
>> +	list_for_each_entry(dev, &bus->devices, bus_list) {
>> +		struct pci_bus *b;
>> +
>> +		if (dev->dev_flags & PCI_DEV_FLAGS_MEMORY_ENABLE) {
>> +			u16 command;
>> +
>> +			pci_read_config_word(dev, PCI_COMMAND, &command);
>> +			command |= PCI_COMMAND_MEMORY;
>> +			pci_write_config_word(dev, PCI_COMMAND, command);
>> +		}
>> +
>> +		b = dev->subordinate;
>> +		if (!b)
>> +			continue;
>> +
>> +		restore_memory_decoding(b);
>> +	}
>> +}
>> +
>>  /*
>>   * First try will not touch PCI bridge res.
>>   * Second and later try will clear small leaf bridge res.
>> @@ -2229,6 +2252,8 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>>  	goto again;
>>  
>>  dump:
>> +	restore_memory_decoding(bus);
>> +
>>  	/* Dump the resource on buses */
>>  	pci_bus_dump_resources(bus);
>>  }
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index e83ac93a4dcb..cb5df4c6a999 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -245,6 +245,8 @@ enum pci_dev_flags {
>>  	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
>>  	/* Device does honor MSI masking despite saying otherwise */
>>  	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
>> +	/* Firmware enabled memory decoding, to be restored if BAR is updated */
>> +	PCI_DEV_FLAGS_MEMORY_ENABLE = (__force pci_dev_flags_t) (1 << 13),
>>  };
>>  
>>  enum pci_irq_reroute_variant {
>> -- 
>> 2.45.2
>>


