Return-Path: <linux-pci+bounces-760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B63680DD85
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 22:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1A61F21B20
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 21:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B574A54FA6;
	Mon, 11 Dec 2023 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dpichDUY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51057D6;
	Mon, 11 Dec 2023 13:48:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftekHBuwatFCU2V+0FbcubwNhywkbXqcztlkNQvWsdHUkJNRDnK5zBjUFzPdpTUqayP+c8xwPTPRI9naZz7mxMrQ3QRHkF5SbKQX85Ll1gLotwi+rmLfjXi5FcX+7LM2UicW/YGUPeVEJZyCEQ9+LWt9HPSYl+tjzi+cqBIBbbo1iuanQOHBR5A94lMQ1YTX/B48gPzdua1//+2F/GAQ6TdN+vmbRtJ9Nxg083VY6jzX0hP6eODApkOvEh13lBSJprpLKTR+I2e7xRe98aFMh5aRSc3rH96qGVfmElYndx2zX4cy95FmAVSUVwlvzrmeIioPSp8Z3cDw6qDv1UrWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qeK8jqiEuWlbOO9DE108xlAgp1LeHKcxg+LrIejZP8=;
 b=WVSHh6vgpAXsmDdtLJj6XFBu0dxrpfgYX31xbZQ6vm94kmb3NgXLlbuYLlihOgCOMQ8oh8v6RWjuShGgy1L3FeBlJ2xNOHqkcD2MhFnjXjhd/Y0tpCWocsBaGN1TgvZo+jBv4cZV1yOdMR6nzz4ZHvJMvobqQtC/c6xWh4lRGqbUplpQqcbLKtCStr1P34P6BjUOGWxJ/OLvgbtbuzU3Hl4lgXmGpzMmVAVqFTBORVNf4E2pQh1nIDIwqcjZHURhlShSrIuHutPg5+/BusiaousQRYmw2Ht6jcOHGMAg2muuz0S+eKtIafpDqOihzYW+JGBu3ZkSsgspkQhDImjneg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qeK8jqiEuWlbOO9DE108xlAgp1LeHKcxg+LrIejZP8=;
 b=dpichDUYAY1IbMV2FS/lT2gl1PMElEHAF/wD/BUSg/H4lHNRSFwt0ussR9R+8JDKuJL1ZW1dcmfgBkUU8+x4G++AQ8pTp4r1tUjzFJDw5ErUV87Nan9kxSjhaUCXYuKbFp4kiy0WnTEE1mwhud5CXaC31v6wjSW/HqY/NqtllgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 21:48:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.033; Mon, 11 Dec 2023
 21:48:43 +0000
Message-ID: <abd45ee8-364e-495f-bb62-3871d5ca1d80@amd.com>
Date: Mon, 11 Dec 2023 15:48:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Allocate maximum available buses to help extending
 the daisy chain
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sanath S <Sanath.S@amd.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sanjay R Mehta <sanju.mehta@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <20231208224400.GA835068@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231208224400.GA835068@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0126.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c940e3d-f11e-4ead-6eb3-08dbfa92f21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qa7fIYNYUMvnpQSxlDXy75aBIRZaxFeX8DIqVLe00DBLI5oWT6DRlgdM6exuM+b0ahRZjdW4gKxwD3ypd304jKGOJk7DDqrDYn2/1bbKEotCosDrG6PjC23luiK4v5pl6x7BGN9u6vxZEkxK7n8C5PYGPjrzcdJzwIDGLiLn8LZfVk3XzJBZFK2InUudjwgXLel2LYBVmLm9hggxkgUYNg3hTeL2oTrBMkMtfX6DBQ3PFM2sVvq3yGPrbXC22VMMjVdFRWgPVSxyduU8DOvqY1ldbZLvTcqDH94AgTaPJYlWWh0nmUO6UlqxCSjCtR0WEmGEIwXFC8Wr82b5GIwUM9wYeOypQVCHG3upv6/KPy/GPl1dxlTRLCfxygaqqX1/gTkBf6S8GMalP19UyByw1WljGFW8HaKm9gViW3FUtT4rJeZFn2f1j+2L/Lm0dAE8hZu2dTarK4OSIJUeLOEHgidjNqoaoXsFQVSxtYgY8CqWqZM/QVJGY2cpz28DdZXZMYkJi06mb6XRz6oee79Tccl8XzPGCo97GLK+PP0WvzBLhmZ0V32olJWOsFDPgrYGlSx1Xmv8/iP063k7LFAkJaB7Vi1ZuIdhwLqjmDw/JB3sQiFNguEgUARjNbh+5phnY/FptRyKmd7N7O2Gowz4TquErCYzIKUwkJQFmVZEmco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66574015)(26005)(2616005)(6506007)(6512007)(83380400001)(5660300002)(53546011)(44832011)(478600001)(41300700001)(2906002)(66946007)(6486002)(8676002)(8936002)(4326008)(66556008)(54906003)(66476007)(316002)(966005)(6916009)(31696002)(38100700002)(86362001)(36756003)(31686004)(131093003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHFvSmxTRzY3RytDajNva3hxYzg4ZkZIQW1nc0tlSlNZRHhubTMrQVhYWUN5?=
 =?utf-8?B?U0lRbUxyNHl1RjFZZGYvSHMxSEtXSVdVSTJueDYvdmJVWVYvcm9mOGlHeEN4?=
 =?utf-8?B?a1lHUzlaUDdkUzFmSzRtTWFFSlB1Z2NPT0kzbVhjcGE3bjNLSGVXUndTdEkz?=
 =?utf-8?B?SjZxUXNKc09QQnlZS1hFbXMweEoyYUFFSm0xdm1RdGQvdWFCUlVJVExLendW?=
 =?utf-8?B?K3ZQeVpDVjhYVWJFSW82dXNZMmFHaTgyaFZ2MWZWUHBKYUFhQ25yWmZYYVo5?=
 =?utf-8?B?c1FhWC9zTDc5dDhmdzQ0d2VSQUc3SFhVYkQ5Y2d2NVRXeE1BK2Fsbk1wcUx4?=
 =?utf-8?B?Q0NwVW93RGJOQjVGQmxlZXZidkx4MjQrbHVRVXRBNUQ3d3R2Vyt4QkVwV1Aw?=
 =?utf-8?B?TnFVZGtiRVRweDJZYWZkekpHM0FjN0k3MGkrTXRSV242eHBJQ21DRWMwdUZm?=
 =?utf-8?B?UUpjTVcrOEZoS3dWU3JwWXV6MW1zaGUvZjBmTWZuMjBhS3B0QXJOcWpCN3dN?=
 =?utf-8?B?Q0ZyVng4ajk4SElVMUxZb2RJeWJKUXZ5N29NQS9PczRYRS81dyt5WnVIckJU?=
 =?utf-8?B?K3ErQjZVVzZoeXdXcFZJT0pFYVRkYzY2d3QvdGF1WU5Fc1ZrNFp1SWlOSG1F?=
 =?utf-8?B?eTBPY0xvY0lJc2NWc09TZjNpZ3lEZDF3YWhtZ0M1V2o3UE9UTTlYMTkrWWM4?=
 =?utf-8?B?RDlSdFJBVEpGU3BYZUJZRGFkY1hZTzZwMHhSU0FNSVhlMXZaTEZ2UG1hbGRT?=
 =?utf-8?B?M20vNGtXalhwUnNpa2hHb25FRVlkUGM5Qi93bDJHejZQWWw5V0k0ZGQ4RklL?=
 =?utf-8?B?S0FvalliZzNuS3h1SVpNMUtoQlNwc0RzN1BQbkhReWI2dU5sTSszakJwTHhZ?=
 =?utf-8?B?eHNlMjZNSnRnOUtHYWlkY1JwVTRqTGVaZXFHWTB4UGhUNXRhVnBlbGFqVFNl?=
 =?utf-8?B?T2Z3OVJtK2xGeC9uYXJrSVlwYlJMVldhY1d1TWJ2ekc4TGtOUUNkMEo2TXd5?=
 =?utf-8?B?aVdROUNaK1JNNVdveitWUVFQUzdxWFdJcmt1REVTS2IvRzJRQXFCaHVUeWJn?=
 =?utf-8?B?QUJXNGdMdkpWakFkY3pmYldmekhsY2ZiUWJsVDNTdWNKN3hhR0lnVmhDekJB?=
 =?utf-8?B?TGxUaXEvZHpiNS8yWXN5cUdYbUt0elpQeTE1Y1ZWZ0VrRkRFS2hXSjEwV2du?=
 =?utf-8?B?blJLOUxsMCs2VG84YlNGblRnbExRVUtwMVdrS1Y2MDBrNjUwdjNYcER1dE5j?=
 =?utf-8?B?azF2Z0ZXdGhtbHpaaCtLS3JlRFh6cGpxSU5ITTFhMHRjaFVmRjBMYkxsdDNP?=
 =?utf-8?B?TFFzS3NGcXoyNmVSNWRtWEJxeWVEdjR4YnVhTWRHV3B2ZDR3MmVPVGVpRmxw?=
 =?utf-8?B?MUkyWHQxajNhT3dPcWY5MTBKeVYxbTducWR6RzR5VUpQQ0ptUmZQa3h2TzhY?=
 =?utf-8?B?TVRBTzVuVDA0SEp5U3ZvNGlxUTlRaUt5WGtNV2pIY1R4Ly8xVmFDZ1NhMFla?=
 =?utf-8?B?Ny9JdzRVMzdQa2xUWHBtcWh6VGJMUnhUVjVJYVRXWFlCYWxsM0FnSDlua0JW?=
 =?utf-8?B?WjR5U1NWaDcxZmh4akFXd2dTZUM4ckdYUGtEekFzUS9iOEJyMmM2a0JsaStw?=
 =?utf-8?B?dS9vek42aXVJb2l1UUxQK2haZkUyS1FrQUlXdFN5SDVack5qaXFpY05ZbHJJ?=
 =?utf-8?B?OTZZQk9IakZObFAyYnN6ZjBod0ZzUTlQNXRzc1ppUGRYbzBrSW85ZXBwZUt2?=
 =?utf-8?B?S2I1SFhFKzBFc05mNjNzaEhyV1FHZkxzeDUyTndnNFgzVVRySUlzTlNrY2U0?=
 =?utf-8?B?WHZsNHZLMkJEb2JGMjRUbGNTaUdMVk9tcnBSazBzUlYrYWllZDY1QUgzelJi?=
 =?utf-8?B?elppYXZXMzBIa2h3N2U5MG1YTTZqdVlzYzFzMjdwTTgzNThyL1dRbDBBWDVI?=
 =?utf-8?B?MDB6VC9YWnJlRGdJS1BwZmtDNkZHREExdCtpeUNJQjNES1V0ZDkvRytJVjVE?=
 =?utf-8?B?b2F0eHBhcDljdnZINUtxclNQMzAyc1FzcTVUbElxdWxnWEkxUTFYRUovb0p4?=
 =?utf-8?B?cFovdjlRb0JTK3doMWFoUVpHVHlLb1dneE54cnBMYkhSckh1UHBTcWlPb1Zy?=
 =?utf-8?Q?cfNKVdDQWwl3z3muzVGJPnlQY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c940e3d-f11e-4ead-6eb3-08dbfa92f21e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:48:43.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMuZhST2xiyunBTKkj+lpibvr/yDNXSI1vQ86gRt12Z6B7UK6RqDzbrjI9af5aWxpHaiWY6p/vp0VrVUpfB3Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828

On 12/8/2023 16:44, Bjorn Helgaas wrote:
> On Fri, Dec 08, 2023 at 04:29:42PM -0600, Mario Limonciello wrote:
>> On 12/8/2023 16:24, Bjorn Helgaas wrote:
>>> On Wed, Aug 16, 2023 at 10:49:23AM +0530, Sanath S wrote:
>>>> In the case of Thunderbolt, it contains a PCIe switch and one or
>>>> more hotplug-capable PCIe downstream ports where the daisy chain
>>>> can be extended.
>>>>
>>>> Currently when a Thunderbolt Dock is plugged in during S5/Reboot,
>>>> System BIOS allocates a very minimal number of buses for bridges and
>>>> hot-plug capable PCIe downstream ports to enumerate the dock during
>>>> boot. Because of this, we run out of bus space pretty quickly when
>>>> more PCIe devices are attached to hotplug downstream ports in order
>>>> to extend the chain.
>>>>
>>>> Before:
>>>>              +-04.0
>>>>              +-04.1-[63-c1]----00.0-[64-69]--+-00.0-[65]--
>>>>              |                               +-01.0-[66]--
>>>>              |                               +-02.0-[67]--
>>>>              |                               +-03.0-[68]--
>>>>              |                               \-04.0-[69]--
>>>>              +-08.0
>>>
>>> Looks like a clear issue here because there's no other use for
>>> buses 70-c1.  But what would happen if there were more hotplug-capable
>>> downstream ports, e.g., assume one at 08.1 leading to [bus c2-c7]?
>>>
>>> The 04.1 bridge has a lot of space, but 08.1 has very little.  With
>>> this patch, would we distribute it more evenly across 04.1 and 08.1?
>>> If not, I think we'll just have the same problem when somebody plugs
>>> in a similar hierarchy at 08.1.
>>>
>>>> In case of a thunderbolt capable bridge, reconfigure the buses allocated
>>>> by BIOS to the maximum available buses. So that the hot-plug bridges gets
>>>> maximum buses and chain can be extended to accommodate more PCIe devices.
>>>> This fix is necessary for all the PCIe downstream ports where the daisy
>>>> chain can be extended.
>>>>
>>>> After:
>>>>              +-04.0
>>>>              +-04.1-[63-c1]----00.0-[64-c1]--+-00.0-[65]--
>>>>              |                               +-01.0-[66-84]--
>>>>              |                               +-02.0-[85-a3]--
>>>>              |                               +-03.0-[a4-c0]--
>>>>              |                               \-04.0-[c1]--
>>>>              +-08.0
>>>
>>> This doesn't look like anything specific to Thunderbolt; it's just
>>> that we don't do a good job of reassigning bus numbers in general,
>>> right?  We shouldn't just punt and say "BIOS should have done
>>> something" because not all machines *have* BIOS, and the OS can
>>> reconfigure bus numbers as needed.  The patch certainly isn't
>>> Thunderbolt-specific.
>>
>>  From the discussions Sanath and I have been in related to this issue
>> the BIOS is pretty static with it's initialization under the
>> presumption that the OS will rebalance things if necessary.
>> ...
> 
>> For this particular issue it's being approached a different way.
>>
>> Windows never rebalances things but doesn't suffer from this issue.
>> That's because Windows actually does a "Downstream port reset" when
>> it encounters a USB4 router.
>>
>> Sanath posted a quirk that aligned this behavior when encountering
>> an AMD USB4 router, but as part of the discussion I suggested that
>> we do it for everyone.
>>
>> https://lore.kernel.org/linux-usb/20231123065739.GC1074920@black.fi.intel.com/
>>
>> So Sanath has a new patch that does this that is under testing right
>> now and will be posted soon.
> 
> Hmm, ok.  I don't know what a "downstream port reset" does or how it
> resolves the bus number allocation issue, but I'm happy if you have a
> fix that doesn't need PCI core changes.
> 
> Bjorn

The issue is specifically with resources that were assigned with BIOS in 
this "static case".  The downstream port reset ends up resetting the 
topology and thus the resources get assigned by Linux instead and will
be better balanced for more devices to be daisy chained.


