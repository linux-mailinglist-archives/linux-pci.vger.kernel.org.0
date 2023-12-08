Return-Path: <linux-pci+bounces-720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BCF80AFAB
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 23:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153862816A4
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 22:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8743B46BB3;
	Fri,  8 Dec 2023 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DQahmEIo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2B885;
	Fri,  8 Dec 2023 14:29:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx1bz1A46NrkcX8vxw6b4z0Hk1RMXeXVVvdqoq9sq8TpMq6fpez07PnfiMj5NoUd0pkHF60q1xIhEHrvP2Y5L5mH133fpFgFNTXUPOh8gwvRwaO7wRr420m/slZo9wvziT8RNc/9sLi1ed3T2IbEEHXSKPPaoTfkONy0o3PPVHDazKARMbpcexR3naM+IuuDbp/g6uE2Efu9qe0Am71MlpyddcdNKwUGaMMJvFOvvkKimiGrIeb9VXumA6Ity6nCIiEo2FAu9nzFBjSWFV/Esjgy4AzYrthzkWK32XJIJT7DM7NBMcmeRGxPVE2IJHpGRAUoTpkfVBOJS8831aQ5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSbv52tK73y+kIv9dj517RP55DdB25Q6J1BnLW1Z2Fk=;
 b=TmOfskp8nrklAcj3G3884X2m8c8A+bMqtQLWO1oJuwMR1zaz+db9errfLlr5Kk7q0iTJWheKb/pOFPkYYUhukD8aPPhJkBPM3/6cQri0E4BkTUuVXiy8tbxVgX0yDsndbWfXRfytDXZeVGEyi5LCBsbMsSFRR8zGKHgZdT2g5ZhhNxezDB7MDQGGs/ujP1sltlMEemrbpv3mexcWlvKaf3nUNDvhodYSIDthikQj2O2bI/WO1+ajWMkTmRwT+ksPZ9yOv84WFcDsmkR25GHuXuJ9r0kRt96st7ALH15NzlrMcls6BN8aLRzGPE90VasHBXdhkOb7n2+Gg4hwq8lP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSbv52tK73y+kIv9dj517RP55DdB25Q6J1BnLW1Z2Fk=;
 b=DQahmEIoql+mmEKbLHjMrxskFZyAFiS2S2PEKgWiY81KP8S9Oy1zeNf+aCHtgp0CaHELvi9eNFbOW9sPr3uO4g3Ps52oY9ykRbxbL1zlOKIlF4LeqVIJsAIZzau/Hv5Jwhelrji8xLMiPn4lVnuItV/GToaVBFDIAeD6rnb6slI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 22:29:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 22:29:45 +0000
Message-ID: <1e0431bc-6747-4367-bbbd-95c75395329f@amd.com>
Date: Fri, 8 Dec 2023 16:29:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Allocate maximum available buses to help extending
 the daisy chain
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Sanath S <Sanath.S@amd.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <20231208222428.GA808407@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231208222428.GA808407@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR21CA0024.namprd21.prod.outlook.com
 (2603:10b6:5:174::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4943:EE_
X-MS-Office365-Filtering-Correlation-Id: 400a7495-144f-4b24-3ade-08dbf83d2dfe
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7E68fo6S6RzVqjGLs7rCfz9s6jiVvCvI83AJ9Q6HP+j9WfpZE1/W6nh8uYlxhqG8g4UoeESXZLKYOsmNLTQ7PlCqtgxElYikNFNeCFsMZRKZJcpsOZlxE2Zv/g6FV9/MiJX9vBfFjS6ZxVSHRtXRJJvnMgsndksLngz1yMeaskDloTgik+QUEs4OT0doLPVG9OF8zzaMqPNDgcYmdGZyxzjLem/NH6e2IvFdJJZt6hV2CGC/ArXLnj6gtAX1wIymEGmSpdSetTcEF3QPuXAdJh/wAin1fWh6w3VomnFGpOJGI9VuSxXY1Az7MHA2RfbrXRp7lR14t0B6OZa9cuX5/ieEPa8LBtBLpc70DDmucsDGZcNHW+yq39L0sDlOxWX0RduTC3a4QofQLmhhy/Kg4xZp0d4zUjfwYmC7lTDK86M9Vf/e96cmgCSLAM6sSWPfhmILbTMb80LqH0mU+irMRDbJbRql9C90MdkJyDBD+XZK0tCM0T4XcgGHk332eYXNRVzjzl1xkarOVjqj4hx62vpjOKLBtLeOc5zqHww6gRsRwHux3bNYr4PtecHy1Vg6nfcNSUQv7iwbE8aT2ougOcfYEN2tEZPbEQPChGi0/iPSdgVCczuXECj5hHdGUodLjnsZjJi9LGSjhaZk2dmAEdMn+weVkW5Oixp9mhvNH96NBCjTJjY5AX7/M3Qdw/oM91r+1Acwkp28ROBT1ccvGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(110136005)(54906003)(31686004)(478600001)(6666004)(316002)(66946007)(6636002)(6486002)(66556008)(66476007)(66574015)(44832011)(8936002)(26005)(86362001)(4326008)(6512007)(83380400001)(6506007)(53546011)(8676002)(966005)(2616005)(31696002)(5660300002)(2906002)(36756003)(41300700001)(38100700002)(131093003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlJnK1YxQkVTdlVNeTdHZG0yQTR2N1dZd1ZibXlVZGIrd3pvR0U4VS9Eelcx?=
 =?utf-8?B?YUlGWW1GTXl6dDdkcjYyRFVZc1lRcFVqVlZVRmc4dUFHUjBhWWszV2Z2eWR2?=
 =?utf-8?B?Y0xodmoyaU5kcEpVN0NQWjhKcEc2R1ZMOThhY1NIVVg5NVpaaVAycEVmUmFu?=
 =?utf-8?B?aHFnd241bW5IK1FSdnd2RGtPbWVlZkR0ZERaakpjRnNrSEt2OStlUkQ2N2Vw?=
 =?utf-8?B?SW5XZXhZWDNOTXp3UkxubktNTWlTb2RnaU9MdFdya3oyc1M5MFNTUVk3NzND?=
 =?utf-8?B?Rkh2SWhJQ3VjSU51SXNiZHRiU1QyVlZIYW4xWUIxQ2xoVXFNN3BRby9TTGcx?=
 =?utf-8?B?RTJnS3NVUVZDbmZUTkp5Ulk0eGZzdFBNTSs3d2UxdkZwaWN2alNCcm51TUhy?=
 =?utf-8?B?ZjhTaksrQWIzTjlRYm8vUlNKQzNzWkd5aGtPTm5DZmF1YUE4eUZkT2lxTG9Q?=
 =?utf-8?B?dlk5RXJjVDdRcGtkZDVKRXVXKzJzaHNScXcrdzVsWCtINndYUU9EQmRhamt6?=
 =?utf-8?B?K1JuZ01HekFwa1lxMXhlQkVoN0JzK1R4SGZCQnFDc0QzQUVYZERvQ3lKVXBu?=
 =?utf-8?B?cDZHRG8wcTNjcmtPMzBnYVZUSkNTVmdXVTE2dTFUczkyUjR1V2szU3JoVGla?=
 =?utf-8?B?RHNFYjNaTnljeURVb0tqeUhlVjlHbnpxT3NnQzl1QVI3TlpNazNJcFNveGJK?=
 =?utf-8?B?bWN5OGZuc1p0SUhRN2s3YUhSanlHRkVzeGhlUlE3NDZ6ajVlbHBoQXU1ZU1O?=
 =?utf-8?B?TlF2QU5iVHZDeVpuSEhTdmUwN29VUXZwOHdqSGZ4djA5NmhuTXdMNjVwc055?=
 =?utf-8?B?dkJBcHVjZlZ4U0JWVzdlUis1WUJqWUZCNGxoSGxTNTdMQ092ZnpNRzdJV1RU?=
 =?utf-8?B?Mk1ud2NYTWxKREJDVHZwODZoVjlHQWRHbXlUZm1WdURtQmJ3c1c3amRtT1cv?=
 =?utf-8?B?L2MrS3kzeGQxaWx3NzVmblBGZ2NQL0tKTEIzcWpKdklKSndNSzBRQ3N3WFZa?=
 =?utf-8?B?aUxhaFV0cjFXSUpZVkU1b3IxN1puSmdreEVSUHFZVEpQenVKL1dNVmhaTmxz?=
 =?utf-8?B?UnRmMFZVUVZLM01ZVGxRa2JzUm1xU012T0lzcDZEOVVFQkZmc1dzb3ZLdmRk?=
 =?utf-8?B?MGs5T1ZINGJibVNPVWVNa2JQcGQ0cEtkSHpRdDBLSzh4VHhpRkxGeUVoZjlo?=
 =?utf-8?B?KytvQ3Q0SXU2djF0aTN2end5MXVmQXRBeTZKYkN6a242dVpzU0FuNlRUbkhu?=
 =?utf-8?B?UDJ4K1lwNHRvTEdKK3ArbXpvdWMrL1pyTnNQeUNDMm5BUDltM0dyellRczVs?=
 =?utf-8?B?OEJCNkVwN0N5L20xcFJRdzdFSzdNeGV1bjc4Z0hpQUFuME84Tng5Wm9qZ2hz?=
 =?utf-8?B?M24vTlFFVm9RUm1FTDdvQkdXVFh2VEV6WnhySnAvb0VrZDNlOXZBUXExMTds?=
 =?utf-8?B?eEVUWGZKVFovMlZkWUVQQzJnemF4d0x1emtTV0RUREZoMzFvbnBRUnZWdlhT?=
 =?utf-8?B?eWR1OVlpdDdLNE9aQUtzc0d0UytOK1NHb2t4SHpqSkZWWDFSL0d0QXhLdVJF?=
 =?utf-8?B?WDBSOFF4TXhGVUFzTjNlbDB3Y25ZTWxOVEpWWks5UjNZSXNIcmVkK2lEbHZl?=
 =?utf-8?B?MkwzUys0T21Yd0UrVVhMQVNCdW8wdFhkeFRUVSs1cy8waW9zMFhRdnJJRXlY?=
 =?utf-8?B?aVVkYWNQWXA0YVN3bVVoRTMwajkzQ1ZFanRFeTNYRnV2elY1UXowSGpVOGF5?=
 =?utf-8?B?ME9IOWpSaHYxTDRjMWhKSmlKcko0cGRHcTA5ZUtKaU9RRXlOZkZNeC9mRGtk?=
 =?utf-8?B?b0pSOG9EM2krRXFKNVBnSXhPRk5COGEwZEI0bnZBVVJIN0REa0xFQXZrTmh1?=
 =?utf-8?B?Zk80OHBKUkIvZEZXallSOHhaS0tmK0NBbmx6MGFpL2JtVEd5REk4S2toa3hv?=
 =?utf-8?B?b3hKYnU1WnRkU0U2WDVra3hTZ0Y0K1BwMlBubHFxdUt1dVVXa3hiN28wTERI?=
 =?utf-8?B?MjV4NUQ5SE1pV1p4NHYrOEJGRXFoM2dqR1VMdTE0QmQ2UzdLaTl6Qm9sVDlE?=
 =?utf-8?B?NmduV3E3clp1eTlEeERnY1oyNk5SaW5Na0N0cXV2bHI1SEpxclVxd3NJYUZV?=
 =?utf-8?Q?PZqKOBmCia9I6+3xxTipQ+j5l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400a7495-144f-4b24-3ade-08dbf83d2dfe
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 22:29:45.2713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPA3wNgo/0u2HHjZq631Ec109QVyXoEY92I4JzqySqQKp++zga9MHe402wnwos9P3CC/43qF48jNh9pzRzDJGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943

On 12/8/2023 16:24, Bjorn Helgaas wrote:
> [+cc Mika, Maciej]
> 
> On Wed, Aug 16, 2023 at 10:49:23AM +0530, Sanath S wrote:
>> In the case of Thunderbolt, it contains a PCIe switch and one or
>> more hotplug-capable PCIe downstream ports where the daisy chain
>> can be extended.
>>
>> Currently when a Thunderbolt Dock is plugged in during S5/Reboot,
>> System BIOS allocates a very minimal number of buses for bridges and
>> hot-plug capable PCIe downstream ports to enumerate the dock during
>> boot. Because of this, we run out of bus space pretty quickly when
>> more PCIe devices are attached to hotplug downstream ports in order
>> to extend the chain.
>>
>> Before:
>>             +-04.0
>>             +-04.1-[63-c1]----00.0-[64-69]--+-00.0-[65]--
>>             |                               +-01.0-[66]--
>>             |                               +-02.0-[67]--
>>             |                               +-03.0-[68]--
>>             |                               \-04.0-[69]--
>>             +-08.0
> 
> Looks like a clear issue here because there's no other use for
> buses 70-c1.  But what would happen if there were more hotplug-capable
> downstream ports, e.g., assume one at 08.1 leading to [bus c2-c7]?
> 
> The 04.1 bridge has a lot of space, but 08.1 has very little.  With
> this patch, would we distribute it more evenly across 04.1 and 08.1?
> If not, I think we'll just have the same problem when somebody plugs
> in a similar hierarchy at 08.1.
> 
>> In case of a thunderbolt capable bridge, reconfigure the buses allocated
>> by BIOS to the maximum available buses. So that the hot-plug bridges gets
>> maximum buses and chain can be extended to accommodate more PCIe devices.
>> This fix is necessary for all the PCIe downstream ports where the daisy
>> chain can be extended.
>>
>> After:
>>             +-04.0
>>             +-04.1-[63-c1]----00.0-[64-c1]--+-00.0-[65]--
>>             |                               +-01.0-[66-84]--
>>             |                               +-02.0-[85-a3]--
>>             |                               +-03.0-[a4-c0]--
>>             |                               \-04.0-[c1]--
>>             +-08.0
> 
> This doesn't look like anything specific to Thunderbolt; it's just
> that we don't do a good job of reassigning bus numbers in general,
> right?  We shouldn't just punt and say "BIOS should have done
> something" because not all machines *have* BIOS, and the OS can
> reconfigure bus numbers as needed.  The patch certainly isn't
> Thunderbolt-specific.

 From the discussions Sanath and I have been in related to this issue 
the BIOS is pretty static with it's initialization under the presumption 
that the OS will rebalance things if necessary.

> 
> I guess this patch is on hold for now because the kernel test robot
> complained:
> https://lore.kernel.org/r/202308232106.50c8f492-oliver.sang@intel.com
> and this hasn't been resolved or explained yet.
> 

For this particular issue it's being approached a different way.

Windows never rebalances things but doesn't suffer from this issue. 
That's because Windows actually does a "Downstream port reset" when it 
encounters a USB4 router.

Sanath posted a quirk that aligned this behavior when encountering an 
AMD USB4 router, but as part of the discussion I suggested that we do it 
for everyone.

https://lore.kernel.org/linux-usb/20231123065739.GC1074920@black.fi.intel.com/

So Sanath has a new patch that does this that is under testing right now 
and will be posted soon.

Thanks!

>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
>> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>> ---
>>   drivers/pci/probe.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 8bac3ce02609..ab7e90ef2382 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1263,6 +1263,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>   	bool fixed_buses;
>>   	u8 fixed_sec, fixed_sub;
>>   	int next_busnr;
>> +	int start = bus->busn_res.start;
>> +	int end = bus->busn_res.end;
>>   
>>   	/*
>>   	 * Make sure the bridge is powered on to be able to access config
>> @@ -1292,6 +1294,13 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>   		broken = 1;
>>   	}
>>   
>> +	/* Reconfigure, If maximum buses are not allocated */
>> +	if (!pass && start != 0 && end != 0xff && subordinate != end) {
> 
> I don't quite understand the test here.  In the "Before" example
> above, I think bus->busn_res is [bus 63-c1], and subordinate is 69.
> That certainly makes this condition true, but wouldn't you also want
> to reallocate bus numbers if bus->busn_res were [bus 63-ff] and
> subordinate were 69?
> 
>> +		pci_info(dev, "Bridge has subordinate 0x%x but max busn 0x%x, reconfiguring\n",
> 
> Most other logging here starts with lower-case, e.g., "bridge has ..."
> Print the bus numbers in the typical format ("%02x").  Maybe use "%pR"
> and &bus->busn_res for the first part.
> 
>> +			 subordinate, end);
>> +		broken = 1;
>> +	}
>> +
>>   	/*
>>   	 * Disable Master-Abort Mode during probing to avoid reporting of
>>   	 * bus errors in some architectures.
>> -- 
>> 2.34.1
>>


