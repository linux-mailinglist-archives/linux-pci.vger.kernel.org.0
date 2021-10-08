Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE8442708E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 20:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbhJHSNE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 14:13:04 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:49824
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241717AbhJHSMh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 14:12:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUFEFCyYIYiYiryFYwX/drHhgVMWwUVktz7OLB01X09fGbGBp6ZWSCn3DtLAtxior+iK/033ipx9/ljpFsbVQDX8pRu89vbajAoilw11tCmmORanuJBQ3bpRhbUmt6JcybXCbIhFXGGSsuXdYtzm3wuK4ZdJyDvJru3rLzN058Bc8uQ5xzoJvkW7Juf5FDYNpOg6VriT+LR0PW9AVRJGzsJR1bF1bAdW2sda21NRebx4HZ/9QEtiidmMKNKSX9W+6P3pWP1cCYn4W5UPKrKTSNPPb7pnGk6NDbNIIqTqVMCeojwDARoFrNbXMukyBwusAyq7hrWx5muegpIm6JXkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPPLbw76JY9JfyR/aGxNIBbQEp5sPJeGJW9YCzKsjnw=;
 b=cZyRm9oRB8IGH3ZaKsE3z0++WTZix5vr05JMy0nns0a1iCUrwa8vyyl2W6L2aI0wdNEItWhamXItlCBmgX4E0+GuwPp6ITeGobGB7RP6d2ZKNM4x1VUZLnwsmxQMfMjqPItOYlD28tgr1PyYxgdcF32308e9qM92Iv3/9209di1D4MIYqB24WcJWzdn0s4KjXz8uAUYgNQvyzwKLv8P/RYHjNB8LztFQ7DdabUL74JJGOhFl7NOH0NySVh1WuMWDnhubfzMXIfyN1gKsdjROxw9GHrvv5u80uVGYpxiHr3cOBEU5ltRMuD+0/91vRskJwExVwxqfeY/6pMi+RBLcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPPLbw76JY9JfyR/aGxNIBbQEp5sPJeGJW9YCzKsjnw=;
 b=RhRP0tzpGAXM0DULkguTYtZ++EsROQrRbQtL87G4843PMFCQjS00wJ7G/OcnsnnsAIVFopF0byfPKuhNN32cIVfdVIMkGWOIiJCYftmyFHmMr92LbPpVQjhKzqU3nL5OB1a7nTElUCAK1AT17OxEwE4tPfurQQ+t/dIP9NUAz7I=
Authentication-Results: acpica.org; dkim=none (message not signed)
 header.d=none;acpica.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 18:10:39 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1%5]) with mapi id 15.20.4587.022; Fri, 8 Oct 2021
 18:10:39 +0000
Subject: Re: [PATCH] PCI: Put power resources not tied to a physical node in
 D3cold
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
References: <20211007205126.11769-1-mario.limonciello@amd.com>
 <2211361.ElGaqSPkdT@kreacher> <8c8df41d-265a-637d-bc26-cdaf0e4e93a8@amd.com>
 <5504370.DvuYhMxLoT@kreacher>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <7d1e1fad-cda4-9889-3a37-074543bb1250@amd.com>
Date:   Fri, 8 Oct 2021 13:10:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <5504370.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0033.prod.exchangelabs.com (2603:10b6:804:2::43)
 To SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.254.54.68] (165.204.77.11) by SN2PR01CA0033.prod.exchangelabs.com (2603:10b6:804:2::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend Transport; Fri, 8 Oct 2021 18:10:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d16a3032-3a1c-490b-318c-08d98a86ef18
X-MS-TrafficTypeDiagnostic: SA0PR12MB4590:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4590A15C70D7594BB64A5C90E2B29@SA0PR12MB4590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKFwjETLQOkv8zcC2jeJBSef4B4XlgG2m5czUPBzv+kyCML0l+RMylB+ZmejjpMrBH5GuPRy1MGaukinjOLj2hy3tCiI5SD4fp8lkHV5s5LkW85qormyUe4kIEsBj8PSN7YkE4wfCLpSC5NL3kbczYMl6i1Cz6IK14j+pr+4D8oCW7zKEEeCYQe5XC7+TrZJhgXqLFFB/9OODHCycDcvy3P0ftQX+zbPsUmsROBr2ZpVxVwX2/BoYxVTkw+pk3ltJqlT/z7PbzXl5tpF6BL7vMF2cuOWFwNhBslDX/oLFj3LTdXJbhV/xaLwycDEzbJqKMydQBlGTvO/OeE5HzMLqqzF4WxF5dca0vZmjzzT5NrxnG8gNR7qCJPpxkNyVVmxMDlv0ekZfEucaY+5JI67ZPa2Zt5KzKbESi1g7d4xWMhO42Ngtlh/hgbhVJQV9wtwc9slEwVErQB3AJuGPp4GttF+s7wfWVXcJ87tu2DFntpPVZZKhJ65LOprMc2LMst7H7f4EqyAD+4/OrC3PrmcWm0omxRS6cfuWq3lwOvQyLq/MHCHp4k04jDpjfKAf14BneTCJSn9nET1UmU4aPUdr9IqdPULFlyLEAi2Bv1sBmnHQe1lgNPZsHg2G86kjJzTDrt5gIM9mMYwrnl26cq46+fBykEvJJBHRfWobHStO3QHzI1HKJp0ut5ehKcJzSBMVE3xIuPyTHRUZvSwIM6Dz1/NHxVK7p5wHJ+xczTPZJ1l43HTzUxtci+ceeYgM/37kTQG3rBQKK+7DlhS/sLsKbFDimkS/UndpS7XpFVEZzVvQPdvJaui+pIeCQ1ezZZ/3ct0KMsRvs/JIjxdNAuG8/JK6urdovwA22/a2UgVU7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(31696002)(83380400001)(30864003)(86362001)(2906002)(6486002)(36756003)(186003)(53546011)(6916009)(508600001)(54906003)(5660300002)(8676002)(45080400002)(38100700002)(8936002)(316002)(16576012)(2616005)(956004)(66476007)(66946007)(66556008)(966005)(26005)(4326008)(32563001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXZqY1YxV21mZzdaMkxXYktBQUZTYktCWm5KMHkrRGpUT2kyaEplN1U3c1li?=
 =?utf-8?B?TytMTklpNWZVdGd1enR5SnZNWk83TURMSGNHT1F1UW5MYk5VNjlZVlVRaFhz?=
 =?utf-8?B?K0hQS3F5QkdsNEZ3Y2pJSFlyRndPWHdPL3FPYVpFV0RwTk44dUhORXVGaFlm?=
 =?utf-8?B?TlRPT0k1djNpQ3Z3YzJNVXF2R010QUtQNE51TWFKbzNTVVBjc2xTTDNNWGZn?=
 =?utf-8?B?UklaZUMyaXlXWU1JdjZFMXdzbkMwTVc2bFV5NkJQTXY2d2UyL09zZFJrcFkx?=
 =?utf-8?B?U0hDVXQ1ajQ1Y3A0VlJPamRaajQwRW9nWUVzQUlodVB4UWpseHc4OFo1aGw0?=
 =?utf-8?B?bEoxYTVGT3ZxQ2UvbkZ3eURSMERaTlNvS3prMkVUZHFhbUlDL2kzeldTOCtN?=
 =?utf-8?B?QXVKUFlSMFBiNThoSm5mS0ZmUWxTMjByNjJGZkRQdW9XLzZTZGdqSFpNZEx0?=
 =?utf-8?B?SlVjTC9PYWhZUGQ0YTNmVDZ1MU9DTjBRaCtmR1A3MDRaYWNHZ3pOT2I3WDBD?=
 =?utf-8?B?dDRiUU02a3BTSFVSL1FBdkVoZXQ3NjBJSjJUQ1R6cmdnZnhCMEFhcnFxdDBp?=
 =?utf-8?B?MWswK1lsNGdnVW1udDRIT24xR2MvUDhWUEYzU09Qb1F6U3BwNFZ1SW9ua3Jm?=
 =?utf-8?B?eXdZZ3d3bDNxelJKTXEvTGk1VFF1N3lpa3FTOURzMmxLVDhnNFJGK3R2dUFG?=
 =?utf-8?B?Y3U1bUV3YlRwcFRMZURlS0w0ZURmVms1SEVaSnNRc3VWT0VCMXY1L1NXdWIw?=
 =?utf-8?B?VGNlanhqSWFyWWZ5bTNEVGk5eDFvenF4Z0Y4MFJsMktmdXdNaFhPZm1LVG9v?=
 =?utf-8?B?eUsrNGZLVy9EaUFidDNsQXpKaFNiNUhQYTAwN1l1TERDdWtDSk5hK0hld0Zj?=
 =?utf-8?B?WFlJakxyNUNWdnIzc0FTZGN3VFFzVjV0RWVLbmswb05uOHhDdnR3RTZ5U1Vz?=
 =?utf-8?B?dmJDY1BHZis3WnBYOFlBeHJ5Y2NRejFhSDlrL29Ib1lhQncrRm1DNjRmaE8w?=
 =?utf-8?B?TXpFVGRLcHlMTDRZVy9sVEVITFlteVJIZkxHTmNyVWhxWThyR09xcGxIdzd3?=
 =?utf-8?B?SGc1ZFQ4dWhlczdFeXhiZkYyL2FWTThDdnI3OWl1WU1TMEplektZbXU0cUhG?=
 =?utf-8?B?b01ESWZaNmZ5Q001eksyaXVMV1lNeDJOVkJ4czNvV1p5NzJ6QlEwZFJCb1pS?=
 =?utf-8?B?Yzg4bUlMNDRpMUNZV3J0bVBldzMrYVA5Y0VMcVFacVVpaW9BRmRpSSsrNTZM?=
 =?utf-8?B?SUZHbi82MU1Tbk5wNnNjaEhpMm8wVFZZSkUrd1YvVjlYNGRzaEpNSEhSU3JK?=
 =?utf-8?B?V0N6T0pWcU1FaUFtRC9QemF4SUlhWWRObHVDRGhwS2xqbnF6RitUb1RJUlpp?=
 =?utf-8?B?RWZaZ1VGa0YzR2dzWnBaOWlnWFRycHZ2a2FKSG5rWmsyMFlIU2hLajZWWHdk?=
 =?utf-8?B?aUliam5yRGJSUUpmZGM3aVN2YkU5ak5tNHVTV1plZTRVd1FVaitCc3FYWnpF?=
 =?utf-8?B?TzI3YjZzR2RNdU8zci9rUW80bWE2RGwxYU1QL01OZWhMdmtFQzFqYVJjQnRF?=
 =?utf-8?B?bEdya1J4bHAxMXp5dE92WThWbkpoVGZHdGx3Znp2dFdaMlRUYWRjMEhFOFBC?=
 =?utf-8?B?YnNnZlEyQXZCT1RuNzZtRmVrUnkyWFordHl4NW5wQURYNGhZOFZhbEF6bGIx?=
 =?utf-8?B?N29la2RHZHg2L0hZTGYyUWsvL0xwa0wzVS9xcXczaWU4Mi9LZnVrRUxrYzdX?=
 =?utf-8?Q?PXcaonyR78m1PrvV09A7A8TNRuX9FggrdmloCmn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16a3032-3a1c-490b-318c-08d98a86ef18
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:10:39.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKaNTgakXuyBjFPwqRePCdv8wj3mcV4jk+iBTK4AZDr04u74FQ2NibClGpSdM7qOYlaoumR7jClTeyAMgNKycQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/8/2021 12:07, Rafael J. Wysocki wrote:
> On Friday, October 8, 2021 5:47:53 PM CEST Limonciello, Mario wrote:
>> On 10/8/2021 09:05, Rafael J. Wysocki wrote:
>>> On Thursday, October 7, 2021 10:51:26 PM CEST Mario Limonciello wrote:
>>>> I found a case that a system that two physical SATA controllers share
>>>> the same ACPI Power Resource.  When a drive is connected to one of
>>>> the controllers then it will bind with PCI devices with the ahci driver
>>>> and form a relationship with the firmware node and physical node.  During
>>>> s2idle I see that the constraints are met for this device as it is
>>>> transitioned into the appropriate state. However the second ACPI node
>>>> doesn't have any relationship with a physical node and stays in "D0":
>>>>
>>>> ```
>>>> ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
>>>> ACPI: PM: Power resource [P0SA] still in use
>>>> acpi device:2a: Power state changed to D3cold
>>>> ```
>>>>
>>>> Due to the refcounting used on the shared power resource putting the
>>>> device with a physical node into D3 doesn't result in the _OFF method
>>>> being called.
>>>>
>>>> To help with this type of problem, make a new helper function that can
>>>> be used to check all the children of an ACPI device and put any firmware
>>>> nodes that don't have physical devices into D3cold to allow shared
>>>> resources to transition. Call this helper function after PCI devices have
>>>> been scanned and ACPI companions have had a chance to associate.
>>>>
>>>> After making this change, here is what the flow looks like:
>>>> ```
>>>> <snip:bootup>
>>>> ACPI: \_SB_.PCI0.GP18.SAT1: ACPI: PM: Power state change: D0 -> D3cold
>>>> ACPI: PM: Power resource [P0SA] still in use
>>>> acpi device:2c: Power state changed to D3cold
>>>> <snip:suspend>
>>>> ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
>>>> ACPI: PM: Power resource [P0SA] turned off
>>>> acpi device:2a: Power state changed to D3cold
>>>> ```
>>>>
>>>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-acpi%2F0571292a-286b-18f2-70ad-12b125a61469%40amd.com%2FT%2F%23m042055c5ca1e49c2829655511f04b0311c142559&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C9ce40aa8a6354d6894e208d98a7e169c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637693098112854874%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=jHHPR2OmnkwP2au7%2FdwQLIlgVfayGN3AEM7isFcu1bc%3D&amp;reserved=0
>>>> BugLink: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D214091&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C9ce40aa8a6354d6894e208d98a7e169c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637693098112864844%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=cXXxJBffXddl8EEhJKXXt8zL7hL36DRkR%2BWwK7Pormw%3D&amp;reserved=0
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/acpi/device_pm.c | 34 ++++++++++++++++++++++++++++++++++
>>>>    drivers/pci/probe.c      |  5 +++++
>>>>    include/acpi/acpi_bus.h  |  1 +
>>>>    3 files changed, 40 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
>>>> index 0028b6b51c87..0fb0bbeeae9e 100644
>>>> --- a/drivers/acpi/device_pm.c
>>>> +++ b/drivers/acpi/device_pm.c
>>>> @@ -149,6 +149,40 @@ static int acpi_dev_pm_explicit_set(struct acpi_device *adev, int state)
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +/**
>>>> + * acpi_device_turn_off_absent_children - Turn off power resources for
>>>> + *					  children not physically present.
>>>> + * @parent: ACPI bridge device
>>>> + */
>>>> +int acpi_device_turn_off_absent_children(struct acpi_device *parent)
>>>> +{
>>>> +	struct acpi_device *adev;
>>>> +	int ret = 0;
>>>> +
>>>> +	if (!parent)
>>>> +		return -EINVAL;
>>>> +
>>>> +	list_for_each_entry(adev, &parent->children, node) {
>>>
>>> It is better to use device_for_each_child() for this, walking the children list
>>> without locking is questionable.
>>>
>>>> +		int state;
>>>> +
>>>> +		if (!adev->flags.power_manageable ||
>>>
>>> This need not be checked, acpi_device_set_power() checks it.
>>>
>>>> +		    !adev->power.flags.power_resources)
>>>
>>> And I'm not sure about this too.  Even if there are no power resources, it
>>> would be still prudent to release PM resources referred to by unused device
>>> objects by calling _PS3 on them.
>>>
>>>> +			continue;
>>>> +		if (acpi_get_first_physical_node(adev))
>>>> +			continue;
>>>
>>> In addition to this, I would check if the device object has _ADR, because
>>> there are legitimate cases when device objects with a _HID have no physical
>>> nodes.
>>>
>>>> +		ret = acpi_device_get_power(adev, &state);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +		if (state == ACPI_STATE_D3_COLD)
>>>> +			continue;
>>>
>>> The above is not necessary.
>>>
>>>> +		ret = acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
>>>> +	return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(acpi_device_turn_off_absent_children);
>>>
>>> And I would put this function into glue.c.
>>>
>>>> +
>>>>    /**
>>>>     * acpi_device_set_power - Set power state of an ACPI device.
>>>>     * @device: Device to set the power state of.
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>> index 79177ac37880..1a45182394d1 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -2939,6 +2939,11 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>>>>    		}
>>>>    	}
>>>>    
>>>> +	/* check for and turn off dangling power resources */
>>>> +	for_each_pci_bridge(dev, bus) {
>>>> +		acpi_device_turn_off_absent_children(ACPI_COMPANION(&dev->dev));
>>>
>>> IMO it would be better to call this from inside of the ACPI subsystem and
>>> after scanning the entire bus.
>>>
>>>> +	}
>>>> +
>>>>    	/*
>>>>    	 * We've scanned the bus and so we know all about what's on
>>>>    	 * the other side of any bridges that may be on this bus plus
>>>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>>>> index 13d93371790e..0eba08b60e13 100644
>>>> --- a/include/acpi/acpi_bus.h
>>>> +++ b/include/acpi/acpi_bus.h
>>>> @@ -510,6 +510,7 @@ int acpi_bus_get_status(struct acpi_device *device);
>>>>    
>>>>    int acpi_bus_set_power(acpi_handle handle, int state);
>>>>    const char *acpi_power_state_string(int state);
>>>> +int acpi_device_turn_off_absent_children(struct acpi_device *parent);
>>>>    int acpi_device_set_power(struct acpi_device *device, int state);
>>>>    int acpi_bus_init_power(struct acpi_device *device);
>>>>    int acpi_device_fix_up_power(struct acpi_device *device);
>>>>
>>>
>>> Overall, something like the appended patch might work. >
>>> Note that on my test-bed machine it makes no difference, though.
>>
>> Yes this helps the resources on the identified problematic machine.
>>
>>>
>>> ---
>>>    drivers/acpi/glue.c     |   28 ++++++++++++++++++++++++++++
>>>    drivers/acpi/internal.h |    2 ++
>>>    drivers/acpi/pci_root.c |    1 +
>>>    3 files changed, 31 insertions(+)
>>>
>>> Index: linux-pm/drivers/acpi/glue.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/acpi/glue.c
>>> +++ linux-pm/drivers/acpi/glue.c
>>> @@ -350,3 +350,31 @@ void acpi_device_notify_remove(struct de
>>>    
>>>    	acpi_unbind_one(dev);
>>>    }
>>> +
>>> +static int acpi_dev_turn_off_if_unused(struct device *dev, void *not_used)
>>> +{
>>> +	struct acpi_device *adev = to_acpi_device(dev);
>>> +
>>> +	acpi_dev_turn_off_unused_descendants(adev);
>>> +
>>> +	if (adev->pnp.type.bus_address && !acpi_get_first_physical_node(adev))
>>> +		acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * acpi_dev_turn_off_unused_descendants - Put unused descendants into D3cold.
>>> + * @adev: ACPI device object at the top of a branch of device hierarchy.
>>> + *
>>> + * Walk the branch of the hierarchy of ACPI device objects starting at @adev
>>> + * and put all of the objects in it that have _ADR and have no corresponding
>>> + * physical nodes into D3cold.
>>> + *
>>> + * This allows power resources that are only referred to by unused ACPI device
>>> + * objects to be turned off.
>>> + */
>>> +void acpi_dev_turn_off_unused_descendants(struct acpi_device *adev)
>>> +{
>>> +	device_for_each_child(&adev->dev, NULL, acpi_dev_turn_off_if_unused);
>>> +}
>>> Index: linux-pm/drivers/acpi/internal.h
>>> ===================================================================
>>> --- linux-pm.orig/drivers/acpi/internal.h
>>> +++ linux-pm/drivers/acpi/internal.h
>>> @@ -88,6 +88,8 @@ bool acpi_scan_is_offline(struct acpi_de
>>>    acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context);
>>>    void acpi_scan_table_notify(void);
>>>    
>>> +void acpi_dev_turn_off_unused_descendants(struct acpi_device *adev);
>>> +
>>>    /* --------------------------------------------------------------------------
>>>                         Device Node Initialization / Removal
>>>       -------------------------------------------------------------------------- */
>>> Index: linux-pm/drivers/acpi/pci_root.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/acpi/pci_root.c
>>> +++ linux-pm/drivers/acpi/pci_root.c
>>> @@ -630,6 +630,7 @@ static int acpi_pci_root_add(struct acpi
>>>    
>>>    	pci_lock_rescan_remove();
>>>    	pci_bus_add_devices(root->bus);
>>> +	acpi_dev_turn_off_unused_descendants(root->device);
>>>    	pci_unlock_rescan_remove();
>>>    	return 1;
>>>    
>>>
>>>
>>>
>>
>> When you submit this if no other changes, please include:
>>
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Thanks, but we may do better in a couple of ways.
> 
> First off, there's no particular reason to restrict the walk to the device
> objects below the host bridge one.
> 
> Second, if the physical node appears while we're removing power from the
> device, whoever adds it may be confused, so it's better to avoid that.
> 
> Please check if the appended one still works for you.
> 
> ---
>   drivers/acpi/glue.c     |   16 ++++++++++++++++
>   drivers/acpi/internal.h |    1 +
>   drivers/acpi/scan.c     |    6 ++++++
>   3 files changed, 23 insertions(+)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -2559,6 +2559,12 @@ int __init acpi_scan_init(void)
>   		}
>   	}
>   
> +	/*
> +	 * Make sure that power management resources are not blocked by ACPI
> +	 * device objects with no users.
> +	 */
> +	bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);
> +
>   	acpi_turn_off_unused_power_resources();
>   
>   	acpi_scan_initialized = true;
> Index: linux-pm/drivers/acpi/glue.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/glue.c
> +++ linux-pm/drivers/acpi/glue.c
> @@ -350,3 +350,19 @@ void acpi_device_notify_remove(struct de
>   
>   	acpi_unbind_one(dev);
>   }
> +
> +int acpi_dev_turn_off_if_unused(struct device *dev, void *not_used)
> +{
> +	struct acpi_device *adev = to_acpi_device(dev);
> +
> +	if (adev->pnp.type.bus_address) {
> +		mutex_lock(&adev->physical_node_lock);
> +
> +		if (list_empty(&adev->physical_node_list))
> +			acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> +
> +		mutex_unlock(&adev->physical_node_lock);
> +	}
> +
> +	return 0;
> +}
> Index: linux-pm/drivers/acpi/internal.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -117,6 +117,7 @@ bool acpi_device_is_battery(struct acpi_
>   bool acpi_device_is_first_physical_node(struct acpi_device *adev,
>   					const struct device *dev);
>   int acpi_bus_register_early_device(int type);
> +int acpi_dev_turn_off_if_unused(struct device *dev, void *not_used);
>   
>   /* --------------------------------------------------------------------------
>                        Device Matching and Notification
> 
> 
> 

I suppose it's intentional - but I did notice a few other devices that 
are affected now too.  Power resources dangling around for some other 
buttons.  However those devices are still indeed working properly.  And 
yes this one still works too for the original reason that prompted this.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
