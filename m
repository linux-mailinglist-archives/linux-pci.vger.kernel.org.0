Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693FA426E0A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 17:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbhJHPty (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 11:49:54 -0400
Received: from mail-co1nam11on2070.outbound.protection.outlook.com ([40.107.220.70]:36704
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243130AbhJHPtx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 11:49:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyOURp0DTsS3aML6DR9Lu69IlCVF7JTkTZ8YwLF7y0KhHemuCtLLgGPuFea3xyWCx0gjlk3m1FgDnX1c8WEWANSMbK+/FOavLLWSDRTxDO4D5lOpLFdRu4SFRowMfMlnJ9++LuzShygPm8zouNWl7q8F5n4gBBqlknHDKRblpn0RnpQrHMrwpMhZ0szQxD0BVBuOFaDeUkLNNQwegpllxI5Z6iYAQmQpX3mrGCOxkm1Em2SNwkXcQSGmdB8HW3OM3gz8csE86Di7RIq0OOunagNTlmkH+ox51ETDO2Ba+mzQuq7JhsjmCMdAkyuj54a01Csh21ds8c7Df9138ou5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLd2435mrm5paA6qE5QORDDZQDSZfawGUfqRF5Cu/eg=;
 b=UsyXRkQi6eOFoptmF0/3zSHXRUCBTZw6yQTIxPDUySqBX4rlYu+1uPuf88cUxO4sXbzsK0W2SvO4q+6NrYbuc/UqLT34n7YN7iUgEqPqZtSyw6OEjodVZfA+ngkO/x6bhOAQePYOg/ThqfvrOqzjqmN2d/EPtLo1asYqB/uNA0FUEQ0ZenF3LWNUp6s1Y+jlm5yPjDumbqbn17kxG/Fn5uqujjCCBFae9dheskbTg50LJZmi4cmI6is1QMHFMS37UGMa0p+8QXvduuB9+DZyXopOnSrYga8TZUEtG9l3agCxhmBb2FjBtIUfQGKckyzI4EgU2V0JGOHq+Vp9avpFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLd2435mrm5paA6qE5QORDDZQDSZfawGUfqRF5Cu/eg=;
 b=lalifveDXRZ3vX4FPimmcJt6D1Y4TyPzSoJ7lqRhbFY2g1bjNp75KoeELlV9oNbQPyq45Xczsx+ykLEberxYbCe5Gqg0WlEbVKpsGINlXdrLocFnWwK9OFah1n6RI3hwB8ct3FAseth/8MKCXkNZwT/wCKVCXMnb+6R0R684vo0=
Authentication-Results: acpica.org; dkim=none (message not signed)
 header.d=none;acpica.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Fri, 8 Oct
 2021 15:47:55 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1%5]) with mapi id 15.20.4587.022; Fri, 8 Oct 2021
 15:47:55 +0000
Subject: Re: [PATCH] PCI: Put power resources not tied to a physical node in
 D3cold
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
References: <20211007205126.11769-1-mario.limonciello@amd.com>
 <2211361.ElGaqSPkdT@kreacher>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <8c8df41d-265a-637d-bc26-cdaf0e4e93a8@amd.com>
Date:   Fri, 8 Oct 2021 10:47:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <2211361.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0057.namprd05.prod.outlook.com
 (2603:10b6:803:41::34) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.254.54.68] (165.204.77.11) by SN4PR0501CA0057.namprd05.prod.outlook.com (2603:10b6:803:41::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend Transport; Fri, 8 Oct 2021 15:47:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 267efe43-9d14-4659-4de1-08d98a72feee
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2766D5ACD64A8B2DEB7028B8E2B29@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RozTQ+FHJzOodk/a0tHHJ0OhMP0pWnE+K1DjWUUQgRGED1WxInSljhF7maO70qehMs2D816qpolZtYeBsAXjUuXEvA/WPkD2Vrx5zXENoxLSOnW69v03qgvhpzHdBFo+jENtezQpZO9uMRWYPIfky5RVOVUAntbYc/sMpIbXiMw59MnHYD/JrxtPGS0KcK1WsF7vy0As4jKD/lN/NU8uOe8EKTv7lE7LtWPHcq8jXPBtTh1XLu9OZhzlrw7jYKxBFI5RuwlU7ZrEovv35j8g7LaiaS6eNXPfasHbFExZcwZnrAfD9YrZynhngMAEiSFkLO0MpW2HVwhi73YmNv5bx0UV3He7MZ69sV5HRLJVJ74t7uFWYsea5nGw/W3sOUWYgszwzGsgkcx1p6OnDviMniDkav91434yGuaBjt5hkjc5Le2d/FSC4KPqttBgSB6YSwdyYRrFFHJT5Vc6WzR52iByBbcBTe+Fyp+/Q4UYGlp18ZLNdeIdb/XqvTNpDrVMqLYck8HktJDuwZ4JswAOn+PDfmsjKoY+THAf76PsotMdKKRYhjrNXHYCZmmjhEkiXNhGaNZIpQ8Eh49l7ofLLYBs9EiVRqlW+UPxNMdCvLwos/XDy4mrp9LQdyTdy2KLF4jXGgrOqLRkA63fAr5sHoWOu2/9Z1HR19M8AgMkiS/NIrwTWyM0C5jTiBaWyb8YpkTJDfEnxfuDQ2wA8pDlxQ3qw9iBZOmLg3RsrQ8KJ6r4O7G8CuumA3xYc9aNxkx9zK8FYP8QyVaIkCKuQAzO5KYKwYhDpyoeMDHjT3tQejZd5sTFGVj09kTcScp6LOTbD+g5J4t3zXnYMbw3kQIhFt9hNF5COlT1DSHHrhOiPJBCYQuO+4Y1kUiuj3c0RHNQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(45080400002)(2616005)(31696002)(86362001)(956004)(16576012)(4326008)(8676002)(31686004)(966005)(54906003)(6916009)(66556008)(6486002)(186003)(38100700002)(83380400001)(5660300002)(66476007)(8936002)(66946007)(26005)(36756003)(53546011)(316002)(508600001)(2906002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3BQOGVyWGFOMW03NlIyVm9FcHR4OVdDS0I1blJCeng2NnJZL2Y0YmVla0xx?=
 =?utf-8?B?aENEOFVuMkphb3JsaFA5cTVYUkEzM2tXZndrcFo5dWthV2EraUd2SVBVRDB0?=
 =?utf-8?B?NExWUUIvYmRycVVMYlE5MXk1ZnlPVm5Id1VSbUZ5aXhURWxuSmdVOVZHWnlq?=
 =?utf-8?B?UCtURUhOMW04UytIRjZHYVVOOThBYlIvY0tObC9STjM2L2RuN3QyZUw1Rlhl?=
 =?utf-8?B?NW5ScnNPM2U1eGlCVDVJU3FwZXFscGhNVlp3Ly9nM0tndjVEVk5TeDJNQ2xp?=
 =?utf-8?B?VU5BbGVLQlIweVRNbnZKTy9nOENEZ01aeUFRd2ZVSDZQSVM0VDd1SVJ2Skha?=
 =?utf-8?B?bmN0bk5TNzJnSGRhbkJBRm5USEdGdkVYRkRncXBJU1R4Tmh5NWtIZEZkVE8z?=
 =?utf-8?B?YU04bnhsM29OVzRKUHcvSmFRb0JkVk5WeUkxQlc2SVB0a2ZNUS9DeDVXNS9T?=
 =?utf-8?B?blZBUG1DTXBrZllnMWFxVWs3ZG0zdVNRaEhrdmpFTnlydXJhdE1FWHoyY3dw?=
 =?utf-8?B?eVZDcFJnZ3NiYnowalkrWDMxamJkTm5JKytuWmxwSXpDZ0Z3bTVJeUtReUUv?=
 =?utf-8?B?ZSttR0t1dXh2cVBERUlHSjhMdm9iSzZhYysyWDZiRm5vTDBjMUxKOUpObHlM?=
 =?utf-8?B?SlI4cjlaQ1ZVcWFqYXIwSExGVndZai9UcloyUEhWQlR2RXFINjN2Qm14RXp0?=
 =?utf-8?B?TnlLZ2FockVSOGZkZ0tlVUlZdW5kRHEzcWVpZ1c3MnRQNE5BM2QzaGdyRmZo?=
 =?utf-8?B?c3JrdmhuTHdxdFE4c1dJQi9kcm1Md0xYaEhxWjVkdmNhd01qY3lhRVVwdTIv?=
 =?utf-8?B?QkJiOUw5N3l0WUZ6cTJ3TGloaXpMVy81RnZRR2d2c0hIRG5QY2t1bjRNOHhh?=
 =?utf-8?B?S2hpV1FqbVFsSmd3bC9ybHZJRzc3THJLMHVIZzF1ME9rZ1B4cFBacVVBNEtH?=
 =?utf-8?B?dFB1Ym1kYW1ZZ3JORDhXSUdZUmVwZmVNeUNmVm4xd0hCajZhZWZNczVLaWV4?=
 =?utf-8?B?UFRoN1VreWNKVHkwdUdic2lkcEpQbm96UnhsUDFQdjhGaGUzWVM1VnBGLzJ1?=
 =?utf-8?B?OFNmRmxHUk5iWERuUnYreVZ0aFk1Z3JzeUVvWlpuS2d1YlJza25kazdRd1F4?=
 =?utf-8?B?dnV2V1R4azhwY3kwVTF2ZzB1THdtNHp4YXFpandZbjNvOTZoOE80RmhoeTlz?=
 =?utf-8?B?T1lHeStxOVF1d0pBbFErMkt3anVMOThvKzdGQXpHVGY3VGJEVENHZkdVempP?=
 =?utf-8?B?MG9hd2VCRHhERXRqTTdnMis2aHZOaHRyT2FoclFaZzgvbDRRbzR3QmQ5SHll?=
 =?utf-8?B?QjU0RERpbmlMcklEOUtxZDE3VGROUUpTb3RuRzNmcUlxNFIrd0pMeVVFOHcw?=
 =?utf-8?B?UldHOXRLc25TSyt2Yndkc0NmSnlicEl3OHdOZG9Fb281a0l2MGtNd0JaeFVn?=
 =?utf-8?B?S2sycloyY3lrVndBaHc0by93NXBpdjB6eEJ6WEVHYnF4Z0NnT0JnY1V0NzVX?=
 =?utf-8?B?MWJUVC9mbnFhQXZXdUxtQi9ZMW10aGNjWFVtVXRCWldjemNKek1PelZiR04r?=
 =?utf-8?B?ajJBeXJLS3FGbnZhOEdGclRlNmhXTlRxK00zVEVNQmJsTXczd0kvNTVrVllS?=
 =?utf-8?B?NmV6T2FDT1pHL1RsandxMG56SG5ucU9vS3pweU1iZVpkTzRqRVc4aTIxVGt5?=
 =?utf-8?B?NU5CUGhidFRhb0FHbWJSdGFrRnB2VWpMZnB6K1VwZGxTZkZ3U0UyN3AxSlZN?=
 =?utf-8?Q?hE0vNFYAORHIvI1GuP5wcN6Iuwd2qo3TVzWDg4K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267efe43-9d14-4659-4de1-08d98a72feee
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 15:47:55.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctZ4dNYwYWmmJMXoA7JPQX/kgfgHuu/PiqKbp/CSN7eTv/na+N07ZTiJGfEVFsQ2U0kI9WdQGSKY5q1vMzt5Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/8/2021 09:05, Rafael J. Wysocki wrote:
> On Thursday, October 7, 2021 10:51:26 PM CEST Mario Limonciello wrote:
>> I found a case that a system that two physical SATA controllers share
>> the same ACPI Power Resource.  When a drive is connected to one of
>> the controllers then it will bind with PCI devices with the ahci driver
>> and form a relationship with the firmware node and physical node.  During
>> s2idle I see that the constraints are met for this device as it is
>> transitioned into the appropriate state. However the second ACPI node
>> doesn't have any relationship with a physical node and stays in "D0":
>>
>> ```
>> ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
>> ACPI: PM: Power resource [P0SA] still in use
>> acpi device:2a: Power state changed to D3cold
>> ```
>>
>> Due to the refcounting used on the shared power resource putting the
>> device with a physical node into D3 doesn't result in the _OFF method
>> being called.
>>
>> To help with this type of problem, make a new helper function that can
>> be used to check all the children of an ACPI device and put any firmware
>> nodes that don't have physical devices into D3cold to allow shared
>> resources to transition. Call this helper function after PCI devices have
>> been scanned and ACPI companions have had a chance to associate.
>>
>> After making this change, here is what the flow looks like:
>> ```
>> <snip:bootup>
>> ACPI: \_SB_.PCI0.GP18.SAT1: ACPI: PM: Power state change: D0 -> D3cold
>> ACPI: PM: Power resource [P0SA] still in use
>> acpi device:2c: Power state changed to D3cold
>> <snip:suspend>
>> ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
>> ACPI: PM: Power resource [P0SA] turned off
>> acpi device:2a: Power state changed to D3cold
>> ```
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-acpi%2F0571292a-286b-18f2-70ad-12b125a61469%40amd.com%2FT%2F%23m042055c5ca1e49c2829655511f04b0311c142559&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7Ce54614dae1624dfb240408d98a64b8da%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637692988971446528%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=9fYSZ4d2cA2TnM453MQxqmOlGN%2FU6WNi7By7pVP2EV4%3D&amp;reserved=0
>> BugLink: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D214091&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7Ce54614dae1624dfb240408d98a64b8da%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637692988971446528%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=vsjQOgqzadLYXTfRW2sui5Dp7%2B0EYf14rUCiIDNofoI%3D&amp;reserved=0
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/device_pm.c | 34 ++++++++++++++++++++++++++++++++++
>>   drivers/pci/probe.c      |  5 +++++
>>   include/acpi/acpi_bus.h  |  1 +
>>   3 files changed, 40 insertions(+)
>>
>> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
>> index 0028b6b51c87..0fb0bbeeae9e 100644
>> --- a/drivers/acpi/device_pm.c
>> +++ b/drivers/acpi/device_pm.c
>> @@ -149,6 +149,40 @@ static int acpi_dev_pm_explicit_set(struct acpi_device *adev, int state)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * acpi_device_turn_off_absent_children - Turn off power resources for
>> + *					  children not physically present.
>> + * @parent: ACPI bridge device
>> + */
>> +int acpi_device_turn_off_absent_children(struct acpi_device *parent)
>> +{
>> +	struct acpi_device *adev;
>> +	int ret = 0;
>> +
>> +	if (!parent)
>> +		return -EINVAL;
>> +
>> +	list_for_each_entry(adev, &parent->children, node) {
> 
> It is better to use device_for_each_child() for this, walking the children list
> without locking is questionable.
> 
>> +		int state;
>> +
>> +		if (!adev->flags.power_manageable ||
> 
> This need not be checked, acpi_device_set_power() checks it.
> 
>> +		    !adev->power.flags.power_resources)
> 
> And I'm not sure about this too.  Even if there are no power resources, it
> would be still prudent to release PM resources referred to by unused device
> objects by calling _PS3 on them.
> 
>> +			continue;
>> +		if (acpi_get_first_physical_node(adev))
>> +			continue;
> 
> In addition to this, I would check if the device object has _ADR, because
> there are legitimate cases when device objects with a _HID have no physical
> nodes.
> 
>> +		ret = acpi_device_get_power(adev, &state);
>> +		if (ret)
>> +			return ret;
>> +		if (state == ACPI_STATE_D3_COLD)
>> +			continue;
> 
> The above is not necessary.
> 
>> +		ret = acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_device_turn_off_absent_children);
> 
> And I would put this function into glue.c.
> 
>> +
>>   /**
>>    * acpi_device_set_power - Set power state of an ACPI device.
>>    * @device: Device to set the power state of.
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 79177ac37880..1a45182394d1 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2939,6 +2939,11 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>>   		}
>>   	}
>>   
>> +	/* check for and turn off dangling power resources */
>> +	for_each_pci_bridge(dev, bus) {
>> +		acpi_device_turn_off_absent_children(ACPI_COMPANION(&dev->dev));
> 
> IMO it would be better to call this from inside of the ACPI subsystem and
> after scanning the entire bus.
> 
>> +	}
>> +
>>   	/*
>>   	 * We've scanned the bus and so we know all about what's on
>>   	 * the other side of any bridges that may be on this bus plus
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index 13d93371790e..0eba08b60e13 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -510,6 +510,7 @@ int acpi_bus_get_status(struct acpi_device *device);
>>   
>>   int acpi_bus_set_power(acpi_handle handle, int state);
>>   const char *acpi_power_state_string(int state);
>> +int acpi_device_turn_off_absent_children(struct acpi_device *parent);
>>   int acpi_device_set_power(struct acpi_device *device, int state);
>>   int acpi_bus_init_power(struct acpi_device *device);
>>   int acpi_device_fix_up_power(struct acpi_device *device);
>>
> 
> Overall, something like the appended patch might work. >
> Note that on my test-bed machine it makes no difference, though.

Yes this helps the resources on the identified problematic machine.

> 
> ---
>   drivers/acpi/glue.c     |   28 ++++++++++++++++++++++++++++
>   drivers/acpi/internal.h |    2 ++
>   drivers/acpi/pci_root.c |    1 +
>   3 files changed, 31 insertions(+)
> 
> Index: linux-pm/drivers/acpi/glue.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/glue.c
> +++ linux-pm/drivers/acpi/glue.c
> @@ -350,3 +350,31 @@ void acpi_device_notify_remove(struct de
>   
>   	acpi_unbind_one(dev);
>   }
> +
> +static int acpi_dev_turn_off_if_unused(struct device *dev, void *not_used)
> +{
> +	struct acpi_device *adev = to_acpi_device(dev);
> +
> +	acpi_dev_turn_off_unused_descendants(adev);
> +
> +	if (adev->pnp.type.bus_address && !acpi_get_first_physical_node(adev))
> +		acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> +
> +	return 0;
> +}
> +
> +/**
> + * acpi_dev_turn_off_unused_descendants - Put unused descendants into D3cold.
> + * @adev: ACPI device object at the top of a branch of device hierarchy.
> + *
> + * Walk the branch of the hierarchy of ACPI device objects starting at @adev
> + * and put all of the objects in it that have _ADR and have no corresponding
> + * physical nodes into D3cold.
> + *
> + * This allows power resources that are only referred to by unused ACPI device
> + * objects to be turned off.
> + */
> +void acpi_dev_turn_off_unused_descendants(struct acpi_device *adev)
> +{
> +	device_for_each_child(&adev->dev, NULL, acpi_dev_turn_off_if_unused);
> +}
> Index: linux-pm/drivers/acpi/internal.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -88,6 +88,8 @@ bool acpi_scan_is_offline(struct acpi_de
>   acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context);
>   void acpi_scan_table_notify(void);
>   
> +void acpi_dev_turn_off_unused_descendants(struct acpi_device *adev);
> +
>   /* --------------------------------------------------------------------------
>                        Device Node Initialization / Removal
>      -------------------------------------------------------------------------- */
> Index: linux-pm/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/pci_root.c
> +++ linux-pm/drivers/acpi/pci_root.c
> @@ -630,6 +630,7 @@ static int acpi_pci_root_add(struct acpi
>   
>   	pci_lock_rescan_remove();
>   	pci_bus_add_devices(root->bus);
> +	acpi_dev_turn_off_unused_descendants(root->device);
>   	pci_unlock_rescan_remove();
>   	return 1;
>   
> 
> 
> 

When you submit this if no other changes, please include:

Tested-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks,
