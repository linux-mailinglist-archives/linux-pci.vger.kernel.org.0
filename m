Return-Path: <linux-pci+bounces-11513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8588A94C5BB
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 22:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95901C2235A
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 20:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C21155A25;
	Thu,  8 Aug 2024 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IMRASpxC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8763D154BE0;
	Thu,  8 Aug 2024 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148938; cv=fail; b=twcu1TMDnGCV2wu7Sj3VGobg2wxDiZxN70XRVLRGi65E14dpGTCJrJd2Jbx9oFNpy0itdbxtwSYSbJ15nPYlkpoOCdobFlS9c00U0BXr1/KJwfZHtzszFVjOxmXxkNRTnsmsgXUOhi6JHyeKTXgi/mNUptqnNgi1LykV/ZTLy9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148938; c=relaxed/simple;
	bh=xU2Bbi/2a7IG7ZF0n26soS3CZln1EKSKFdCHt/nzGiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UHXxgzFdUezM2pad/6IX8LJwLZlGzCLdL/qbBn7wzaO71CP4z0Fv1iwPV0sgicB1Rbljx1CReAUahavefE2cHzr9Grj0EOS3zPgFWPBUANtMsXiriSuzcKKklTGi9J835Zz+SWzi1NZHFn2ZMgT2r7y6UrCr0snK8dsz08n7rdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IMRASpxC; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qK1/emvJIVkCQuSxdmo/SbzAaCPcJohYt24ANczHby8rL+UuZlJovP6AEK/g8QjtpPbEhX0b5RKYiekopu/y+riv5BQR1dvt0TghyQTfZ98vVvf6GNuxaDzwmCINtYI74LunN7zeY9DwdvF3781WI+cOm96Foe1dD1AGIbxP54qZ0QR+S+ZcAo+aOpYOWDynPVPVVg4yp5/8UK0i4xF/cUPb+L0YEpIfbu9koDFU+6i1ZcwsPLX4VmfNxnMUOfHHF4e3aJOBZ9b/AkppJsS2vok1d8wlPCqkYRLlj3bcWdJ0ML9eHINlmgzeGVO9zJKeciB/00DEmtqiWhsnsvSXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1iX9qhLhhhETQFZ+VOafD/x4g5+jGLAKzow1HcfNes=;
 b=kUhfR+80UwkarJIkHvblcleFAXzX3Sz6ltBHPLe9L3V8A6HjY2xamyAARRh6PUDf5QHUL3+w9KOSWSYHHc+w2bdbWrTqjCCbNhC4xuvqotJ+tIsK48eHyyWzOi6DwlcfNlcsv+bWeyHv1nQeN3nYmxX7MpC0VD59ypsXDcUCNdUL1tkJ1uBJU2rdTCbS01e5AMYYKzVwvwD5noGuOJj4I/X+3p2vpBt3hewfX3k2fhRRY0ESy01pajvwNiUupgvYYd1gJW2HdWYwoCBOAPnc8XzO3zLuTVuRw+Pd2Pv5FpisvDtLud8KeOQ/5ftCQjs9BYZgYJpmwp7uD2srFiI1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1iX9qhLhhhETQFZ+VOafD/x4g5+jGLAKzow1HcfNes=;
 b=IMRASpxCupJ1EI6BgXa24cob9FAxM/dJFYbV6XKYrvyRktpHP0rBHhWN22qxqXthe34BInHLTtBnCITyRQDGvvp2bbiYOD1sfToWDZcUc6PO4TjRaKfPyjNx6pTRr2fjMm/adjimQl5Mq5D/VINYjH66j8u7dvn71jFBXtpsCFM=
Received: from BYAPR06CA0042.namprd06.prod.outlook.com (2603:10b6:a03:14b::19)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 20:28:54 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::7a) by BYAPR06CA0042.outlook.office365.com
 (2603:10b6:a03:14b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Thu, 8 Aug 2024 20:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 20:28:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 15:28:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 15:28:52 -0500
Received: from [172.23.60.101] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 Aug 2024 15:28:51 -0500
Message-ID: <d46536be-9036-44f5-a208-34f6c69b4ead@amd.com>
Date: Thu, 8 Aug 2024 16:28:50 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] PCI: Restore resource alignment
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240808192812.GA156171@bhelgaas>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <20240808192812.GA156171@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c856cd-56f8-41fd-12fe-08dcb7e8b89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzlrZ0FObTFSdCsyU21OWTYwQ1lsT29Camt3QlQzdlFkTkVOTEpOQ25ySk9N?=
 =?utf-8?B?blpFR0ZWaTNhSUFFZk1JajdGM1QxMkJrSyszNWp2cXYxZzFUeGxGMG1WVTNJ?=
 =?utf-8?B?OGVRRFNObitsbXprd2c4eVVUUkNxcE5PVkpaWE9Hc1J4blVKd254ZVJKTmtX?=
 =?utf-8?B?N0IxbWtLd251N0luQnJHRXdXVTZxa1NyZVRwdi92U04veVBWNXNWMDB5Smo4?=
 =?utf-8?B?M3NDaERUQXNreEhPKzVVU1g1TkNsRFh2R2wwVVdGRjRUK0l0Vkk4N3IxS04z?=
 =?utf-8?B?QWdxdHI3Wm1lRDMrU1Jhck9FSWxiQUp2b0ovRzBnR1VLaCtGRWp5SjJJQll3?=
 =?utf-8?B?MUJubHF3eTNRSEVUQnd3TElwVFVSblE4cTd6cSs2RG9SUTA1SWV3Nks4aDF5?=
 =?utf-8?B?LzFsbmsyK3RjTUhNbjkxdVNKRUdzbTZiWWtNcEJZbENpZHhEb1ZnMGVtT2Fs?=
 =?utf-8?B?VnBPVWFwTERYVVVxSEZhc0VGZkVDY295RzlONTZsa0V0SFd0REZEVk00a2pQ?=
 =?utf-8?B?dTR6a1JKeForOENkd1FJQmZodnk2RFF1UVFKMmxlb09iekhXMnQ2dnM2ZGQw?=
 =?utf-8?B?dnNUNjRCRDBTZzdnSFE5NDFUbFJPLzgzUmI5QS8rbVc1bjJ0SDJxVzNRNUp0?=
 =?utf-8?B?bmRkdDhXUlRzaW5FU2ZBdjkyNUJzdSt5MnNuUWR0RjA2NjZkdysvS1JFV2lx?=
 =?utf-8?B?SjlQT3VraklSYkpxcnJQMDRySzd0L2NILzJnNm1yeVhNRmkrdzdDVlpheDRr?=
 =?utf-8?B?dkR1R3RQUkhPZW5QY2NHN0ZEQUdTRyswMnFMeDFXZXJ4UHlBU1ZQUmZnNnJO?=
 =?utf-8?B?dHp0QTFxL0hKYTl5MVF4UmJqdHJzdGRWcVpoVGVJQkVmcmtWSHBNRnNBeTJH?=
 =?utf-8?B?SEJ3ZVhoUzZQNk5uTGtzS3JqdjkwWFcrQ3l0bjNvNHoxU0hqNTc5eStvdTZW?=
 =?utf-8?B?d09HK3J0bVBTN1RWMHJEWFNwVENqRE0rTHN4OTIvcHNzMlp1ckVpRytCblVr?=
 =?utf-8?B?RFZhZDZjUUxoNTkydm9aTW1HTWpJTE1RQ0U5UHB2Y1NqUEM1ODIwVWtiSFND?=
 =?utf-8?B?QXUxUTZwNFgvNmJrSm1yQWUvdURmdm9POGVCcHZkaDNEVzlZdjdLQ0IrN3N1?=
 =?utf-8?B?VnU0bDBLM2JFY3BjY0lCUmNSNGg1aHZKRGhvM0xMSjJpZ3dUL0ZwcTlTRjFR?=
 =?utf-8?B?Qi9OUEEzcXZkUW02bTY2YStBVmhnb1RPbWVRN1pZVi90amx4QWc0NnJDcS9P?=
 =?utf-8?B?YVdSSTF1Vk5ZM3Nub29ySSt0bFJTc0xwb2lDT3B4dkhaUTVLTWZRVHdKQ3p0?=
 =?utf-8?B?OFc3SmlwK2NBNXJ0ai85WVNwTTdhMGw5ckhiUnhKTFhpby9FbFBpQWVpL1N1?=
 =?utf-8?B?N25rTU04R0hub1pMbnFpam44SVRhSzhZaGg1UW1JeTVQZzYwOVR4cE5nc1hm?=
 =?utf-8?B?cm9mWEMySmhkZjkrM2UvMitwL1JLQzgzUDZ5V2dkT3R4dDZERnlFM0FaVHFI?=
 =?utf-8?B?RVRKUWNEUW9XK0lrYVVETms1ejdMY0I5TU4zYWo4VTlKUW16TUVSQXBGNWNL?=
 =?utf-8?B?Rkk2OEZkcUcwS0xaSFhIcGdYbVZTOGdpTjU5bEZWR216S1h1aklOajFMQlpU?=
 =?utf-8?B?ZWRCdWcxVUhnbnFLRVIxRDJnR0M3MHhneHJJSU1Ha2F1aHZHSzJoNWw1MDh5?=
 =?utf-8?B?eGhCaVZORkpFNGdqNHVmYzF3TzhleGJ6SHVJU2NXWGhuak1UUlptemNBREFy?=
 =?utf-8?B?NHdnL21kc093dHdXZytmcjg1SlA5aVIvR0ZsQTFOMmNENGRzcFBaWFlUelVV?=
 =?utf-8?B?SlNYV0Q1YnZDVFIwWk54ZTZxU21oWUpsUlg2WjE5dnVueVRZVGY4TmZ0amNN?=
 =?utf-8?B?Y0U2ckNoeWJVR1NkWk9VR05wQUplNUpLZUU5MFVaVE5DRjNWKzBtWVQ5TTBP?=
 =?utf-8?Q?K7Vt50BqZLrmtJ1IOZ3vWz2Yi1PqdJDP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 20:28:53.5424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c856cd-56f8-41fd-12fe-08dcb7e8b89c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716

On 8/8/24 15:28, Bjorn Helgaas wrote:
> On Wed, Aug 07, 2024 at 11:17:12AM -0400, Stewart Hildebrand wrote:
>> Devices with alignment specified will lose their alignment in cases when
>> the bridge resources have been released, e.g. due to insufficient bridge
>> window size. Restore the alignment.
> 
> I guess this fixes a problem when the user has specified
> "pci=resource_alignment=..." and we've decided to release and
> reallocate a bridge window?  Just looking for a bit more concrete
> description of what this problem would look like to a user.

Yes. When alignment has been specified via pcibios_default_alignment()
or by the user with "pci=resource_alignment=...", and the bridge window
is being reallocated, the specified alignment is lost and the resource
may not be sufficiently aligned after reallocation.

I can expand the commit description.

> 
>> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
>> ---
>> v2->v3:
>> * no change
>>
>> v1->v2:
>> * capitalize subject text
>> ---
>>  drivers/pci/setup-bus.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 23082bc0ca37..ab7510ce6917 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -1594,6 +1594,23 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
>>  	}
>>  }
>>  
>> +static void restore_child_resource_alignment(struct pci_bus *bus)
>> +{
>> +	struct pci_dev *dev;
>> +
>> +	list_for_each_entry(dev, &bus->devices, bus_list) {
>> +		struct pci_bus *b;
>> +
>> +		pci_reassigndev_resource_alignment(dev);
>> +
>> +		b = dev->subordinate;
>> +		if (!b)
>> +			continue;
>> +
>> +		restore_child_resource_alignment(b);
>> +	}
>> +}
>> +
>>  #define PCI_RES_TYPE_MASK \
>>  	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
>>  	 IORESOURCE_MEM_64)
>> @@ -1648,6 +1665,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
>>  		r->start = 0;
>>  		r->flags = 0;
>>  
>> +		restore_child_resource_alignment(bus);
>> +
>>  		/* Avoiding touch the one without PREF */
>>  		if (type & IORESOURCE_PREFETCH)
>>  			type = IORESOURCE_PREFETCH;
>> -- 
>> 2.46.0
>>


