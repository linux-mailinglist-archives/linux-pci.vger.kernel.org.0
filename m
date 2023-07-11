Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D09674FB62
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 00:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGKWyw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 18:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjGKWyv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 18:54:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583A7E60;
        Tue, 11 Jul 2023 15:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKkISI8dcGPtnDqCY1jiQ8WLO5D8XhMmV8L33Gam9PmHK7uODnx8KVr+vvOmW5CBuN+Yj6ClXwWl/Ao68wpzHw8/QwqfdCzcAI6CkPTOr1hBIygO7ksdFdMMTwgBQsbSYAHwzzQ9VHicYKglAVXjzpqQ2kUUz0mMFRcDui+eayOWE/CimnrfcmkUTGtdDigIzuCoxZeOX9Wf9Dm6m26HVBD8RjBmEc4a20EmJwPfesDmyAE2NsP/EVl5vkpBdZE9dwoFWbA3Ef1863SUg0CcqOjKvJunI9GUpIlL7/nhXbYnGdA+By5sygwONUU8e7JdyAR9MbWzhk/JGjCyVUU/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZvXVML1c3wAmLONOyDyhelIASdL672e8owQH/lsOmc=;
 b=VzM2hPfMUqsA69Q+8VQ9F1YTodVm6s8GSjqdyAPXS6shvgZquH5gDsp8xvbPa0x/f/1kqd7ta3iAoWUJzd+Z0cQDPovupEc+PRRs2Sdru/xcd+R0Wtd/yqkvAhb9U6tqPkwuPt7O0Dr5wvmIJe0LStV6pqqMG/ysD1LJMrp74T+dtyPwxK+oqu0Kxtrm4zm7bEV5/LJtACoFSYQvf/eAvTVY3pGHCjY/aNLb2XwonvPPTvHjPUMEJpsD5Uj7UI4CCejytuCM6UJnXeLwzr3TyC+825tf9yFTYWC6T8+ZpuRj0Ekp5y/xAg0CmPduirGwciH3N2ENnrB5q/je2pqURQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZvXVML1c3wAmLONOyDyhelIASdL672e8owQH/lsOmc=;
 b=XcBGwUZXYOmpAFJYJmCzktUV6VBWnfaDw4ShtQ6CPhTwpW5u6cbrUaTX5bvct7yOccqtbKRSapOFJPFQyXjTvt2hbCDG8OY2SYj0kM6km7ZkdUu61I/9WfkAuuMPcQPvAx37bc215hLUquobFt819PMteXxdtbKHosACiH2RxkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 22:54:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 22:54:46 +0000
Message-ID: <b82a50eb-8182-84ca-5b24-dbe8870fa871@amd.com>
Date:   Tue, 11 Jul 2023 17:54:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230711221427.GA250962@bhelgaas>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230711221427.GA250962@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0035.namprd05.prod.outlook.com
 (2603:10b6:803:40::48) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: b89b2a80-a7dc-42a8-4bc4-08db8261d2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wMmGzdwbJxI6udxkx70jVoJY9iUDxURlaaAQPmZAbtJ5DcE1j+R3FyM3N9ySZ2pPEZIfVorGwBUJ4bbD0JrN6qy9MUwG3eoQVJKYOvcFX2WePLdg77zknpdBLCQShYWzGcRaZkFIXsESgtm36ChY8psCBmILYd9DBwtPNr8GaQRZ2Gn4vIgD6VkaFK+BiIG2CntiwfH7ldn9OpBEt10+Glf4yv1enkFyo2uu4njs5PKvMS/OKPeNqXdB84rOwHB96pLvHUGSgEo9KszvynYLPhNwIBCJRgPg4jg7OerpbUxDNxIHwvk/AKM9YDeINNuKrMi1xo+aRYuUelcpGlanI0aVbUoOlDRFnrnW2Vr4xS/lk9jsHlHO94EaLAEzbg7GF5+tkMTmAoA/yCUMxkb9VROiakJqM8AocRcJ5KWhmFoF2haciRD4XUUco+QhFjMTJgaJAn7SI7yAxRLqEiFCNGCwsKDupsKCFgTwZZTd+Y6cOIV36Cl4mgUib65gcHEkX+V/KSSERdwkim4r3IQV5xZwOWHALsP/BdMOUuBEQ+aFLGBV6LIRceJRTLgPLI9K0A9XVvbCVQXiF7RqIdL0e9hCgnqZactMQh06Q+F84lKUJkUkoZm/yl0feFmQ80YxcEB/bNGoXxloERLdG2bPRtRI2ojy96910Cq8xr25H0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(6506007)(186003)(2616005)(966005)(6512007)(53546011)(478600001)(83380400001)(66574015)(41300700001)(44832011)(4326008)(5660300002)(66556008)(2906002)(7416002)(316002)(8676002)(8936002)(66946007)(6916009)(66476007)(6486002)(6666004)(54906003)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1JQNTI3ZDBvRWg0eVBQNGF1UHc2TmVoNzhsRGJNNkRkbGlHc2RBSEJ0NGNt?=
 =?utf-8?B?TGZwSnRnVWgxMWZMbVg4OFl0VkFFQ0FiOE1sUHZYNS9ub3RnZ2E4TXUxTWFa?=
 =?utf-8?B?NktMaFcvUVdHRmhDeWFPZVFwcDBNRFZLeEFibDJUUE1HL0hKY1Z3ZnpIUTdH?=
 =?utf-8?B?REV2T0l6Qk9sWmdvakwzcG1JQkdKME03ekdINU5mSENVK3kzQk8vTnFjaU5v?=
 =?utf-8?B?bTJFWmJWeWFmUXFmejBLaU0wcjAzSFZDMlVjRGZCY2FHSlVNc3BCV3lBdjQ3?=
 =?utf-8?B?bWVlOGtZRU8vQ1hHUXJiOEhFUGVKVDlWR1ArM0JBMnRtZ0MyMEN5RlY1NVNC?=
 =?utf-8?B?VW1TSEJXdkpKczdIWk9RS1YwaDI1eDhZWThXV2VvcjFVcldHSW83Y1BLM0NF?=
 =?utf-8?B?UGR2U0xaRW1hMmFXbjBJd3Btd0hTSElZZXYzQW5VM3VaekU0aWg0L0dCQXpv?=
 =?utf-8?B?VUhYVk9KNEFxZGFYTjl3dXlaZWgxSVJMUlN6UTBtQ1dUVXlEVTh5WmtRamdN?=
 =?utf-8?B?Qnl0eko5d3NpQ3FYK3lMNWZsMnRKQWlnVWNxa2pvRkJ4TmZwSXdCdkNoWEI5?=
 =?utf-8?B?QUlsNHhoTEw4TlBiS3pCSnRzZFZ4b2hKK2YvZU1OMXk1Z3hRdEoyMHNHTEhx?=
 =?utf-8?B?NytRTlNkS1AwTWJ3VW1oMGxwdUlvUlpLWWVPREFvQmltSW1RTUlsMXNWTTl3?=
 =?utf-8?B?Um1WZnJjeTBLK3c0Y3lJMHBsTkFrV3QxeExEQkxvSGlubExQWDA5MkVsaC9X?=
 =?utf-8?B?WjNZVW5BUk1za1hCNWZFM0t0WGQ0dGNNbmIxMEpqVlZicmE2TVYxVjBJa0gz?=
 =?utf-8?B?YUx2RTVZYjJSNnRpZ2VyNkF1cGV2UGxyeDN3UmZjczNWVk9EdWtRZU82eldV?=
 =?utf-8?B?MzQ0NU55L20zd05xc0lVb1lOTkpVcGxpcVhJTkREN3N6cHlxcXVvYk13WnlQ?=
 =?utf-8?B?bFFpVkk2bGtaNGx2VlJiZDJSWDAwcHNFa3F6cWNyaDZWTUtwck5Hd2NSVERw?=
 =?utf-8?B?QmZHNVFCSUVpSnRzazdBUnJoU0FQd3REak1zOURIK1JmYlVFU3Z2a3ZGMUh1?=
 =?utf-8?B?VVpwTlFSd0g0dWhBczhMd3MrZDFpVXpaazBieWlCWXFHMHFFYWVGYk9sWnFk?=
 =?utf-8?B?bnJPMjAreHhKOXFwc3hpenBHcmp3UGRTVDR2a3UwTG9COURlUTdQMTJ6MTJ4?=
 =?utf-8?B?QlZSOHZoTzI5RUlKanpLUjlMdWg1NFlWRWhvb3NXcmF4WDNpSUlCQUZJZG83?=
 =?utf-8?B?TUFIeFBZR2xxc3RYSkErb0FoTlJUYzRTWmoySEVzTFBZeUhFZWxBdEVzcGVR?=
 =?utf-8?B?ZE9JSnRCeVEzRDhNWk8wTlRpQk5NL1dNVlNYZGpmQ2hrT0twaDNiZmhHZExO?=
 =?utf-8?B?N3o3TnBWbkh3Yk1KS3g2a2doelMvSUc3bHM5UTRsRVRoRkNYWUZRTzVidmx1?=
 =?utf-8?B?eSt5YUhEVEJkNDkyaWwveEhBYmhBVWNjY3JGR0FvK1grTjBsNy9SUE9JT1Ey?=
 =?utf-8?B?Z2lyQ01kMExtdWZORlpaNDZXUUM2aWZvNWtodWhaMDR1WkxPRnpKYzQzTGlz?=
 =?utf-8?B?amdNNnpVNWlQTi9mVysxNFhxb0VZaWJZK2h1T3BoQm5jVTQzR0l6bVlYbmlX?=
 =?utf-8?B?ZGljKzAxV1RSSG1rNGxIWGVqSFBnZWV0OXlEQzBhS0UxSVNaZ0JKdjNDK0RW?=
 =?utf-8?B?YWxPbUthRWhkZkdOY0pZSDJmdmpKU1BBcWplaVlPd2NMdWFQSmw5Q1dTa3d3?=
 =?utf-8?B?MGNMODRtRDMra2lDQUtRYmo5cldTd1p1Mmt0bnVuRzlRblJPNWFKaXYrRnE0?=
 =?utf-8?B?UmNrbkM0WWRsMFFhVDFPWlRHaEwrN29veHpubXR4azBCZWsyVUU2SjVCbTF6?=
 =?utf-8?B?NnNnYm45V2lhRldGVnkyQWNkMDQxM2NYSjRsc3B6RG1kcUlidFMwTWwyZjBT?=
 =?utf-8?B?ZkNIRUZFSVpWU3NRc2lNd3BKMTJkeVJ1UzNneTBYTW9YZXpZY3lWTW9PM0Na?=
 =?utf-8?B?bU5pZitkaWRCU3lEUk9kb3kzVGlXOW5SSnIraHNoZ0JuRDUvRkU5TndsU1Uy?=
 =?utf-8?B?eTJEenBUTGxiUXNxR0xCREpYdDV0VmIwVUkyckNHZFI4VU9PUllUY3Q0ZXhM?=
 =?utf-8?B?OWhhdlh2bWlaU0JEaG1Ed3hOVmVpWWFmK1piMENXeEw4Nnhrd0ZFU0d0YU56?=
 =?utf-8?B?QWc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89b2a80-a7dc-42a8-4bc4-08db8261d2a5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 22:54:46.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzYH7REIMbjrgVB5PBwxVbZHEMzVEvnH6uoC4BSGheYS7aX4TsZXClTjc/fltwZu3wf3Wy8+nlFgWlx3NL/I1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/11/23 17:14, Bjorn Helgaas wrote:
> [+cc Andy, Intel MID stuff]
> 
> On Mon, Jul 10, 2023 at 07:53:25PM -0500, Mario Limonciello wrote:
>> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> PCIe ports from modern machines (>2015) are allowed to be put into D3 by
>> storing a flag in the `struct pci_dev` structure.
> 
> It looks like >= 2015 (not >2015).  I think "a flag" refers to
> "bridge_d3".

Yeah.

> 
>> pci_power_manageable() uses this flag to indicate a PCIe port can enter D3.
>> pci_pm_suspend_noirq() uses the return from pci_power_manageable() to
>> decide whether to try to put a device into its target state for a sleep
>> cycle via pci_prepare_to_sleep().
>>
>> For devices that support D3, the target state is selected by this policy:
>> 1. If platform_pci_power_manageable():
>>     Use platform_pci_choose_state()
>> 2. If the device is armed for wakeup:
>>     Select the deepest D-state that supports a PME.
>> 3. Else:
>>     Use D3hot.
>>
>> Devices are considered power manageable by the platform when they have
>> one or more objects described in the table in section 7.3 of the ACPI 6.4
>> specification.
> 
> No point in citing an old version, so please cite ACPI r6.5, sec 7.3.
> 
> The spec claims we only need one object from the table for a device to
> be "power-managed", but in reality, it looks like the only things that
> actually *control* power are _PRx (the _ON/_OFF methods of Power
> Resources) and _PSx (ironically only mentioned parenthically).
> 

Your point has me actually wondering if I've got this entirely wrong.

Should we perhaps be looking specifically for the presence of _SxW to 
decide if a given PCIe port can go below D0?

IE very similar to what 8133844a8f24 did but for ports that are not 
hotplug bridges.

> This matches up well with acpi_pci_power_manageable(), which returns
> true if a device has either _PR0 or _PS0.
> 
>    Per ACPI r6.5, sec 7.3, ACPI control of device power states uses
>    Power Resources (i.e., the _ON/_OFF methods of _PRx) or _PSx
>    methods.  Hence acpi_pci_power_manageable() checks for the presence
>    of _PR0 or _PS0.
> 
> Tangent unrelated to *this* patch: I don't know how to think about the
> pci_use_mid_pm() in platform_pci_power_manageable() because I haven't
> seen a MID spec.  pci_use_mid_pm() isn't dependent on "dev", so we
> claim *all* PCI devices, even external ones, are power manageable by
> the platform, which doesn't seem right.
> 
>> At suspend Linux puts PCIe root ports that are not power manageable by
>> the platform into D3hot. Windows only puts PCIe root ports into D3 when
>> they are power manageable by the platform.
>>
>> The policy selected for Linux to put non-power manageable PCIe root ports
>> into D3hot at system suspend doesn't match anything in the PCIe or ACPI
>> specs.
>>
>> Linux shouldn't assume PCIe root ports support D3 just because
>> they're on a machine newer than 2015, the ports should also be considered
>> power manageable by the platform.
>>
>> Add an extra check for PCIe root ports to ensure D3 isn't selected for
>> them if they are not power-manageable through platform firmware.
>> This will avoid pci_pm_suspend_noirq() changing the power state
>> via pci_prepare_to_sleep().
>>
>> The check is focused on PCIe root ports because they are part of
>> the platform.  Other PCIe bridges may be connected externally and thus
>> cannot impose platform specific limitations.
>>
>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html [1]

At least for myself when I respin this, here is the 6.5 link.
https://uefi.org/specs/ACPI/6.5/07_Power_and_Performance_Mgmt.html#device-power-management-objects

>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v6->v7:
>> * revert back to v5 code, rewrite commit message to specific examples
>>    and be more generic
>> ---
>>   drivers/pci/pci.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index f916fd76eba79..4be8c6f8f4ebe 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3041,6 +3041,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>   	if (dmi_check_system(bridge_d3_blacklist))
>>   		return false;
>>   
>> +	/*
>> +	 * It's not safe to put root ports that aren't power manageable
>> +	 * by the platform into D3.
> 
> Does this refer specifically to D3cold?
> 

No, it's intentionally not saying D3hot or D3cold because it's stored to 
"bridge_d3" which is used for both D3hot and D3cold.

> I assume that if we were talking about D3hot, we wouldn't need to
> check for ACPI support because D3hot behavior should be fully covered
> by the PCIe spec.

Right; the PCIe spec indicates that D3hot should be supported by all 
devices and has rules about when you can go into D3hot like not allowing 
it unless child devices are already in D3.

Naïvely you would think that means pci_bridge_d3_possible() shouldn't 
have any of these checks, but they've all obviously all been grown for a 
reason.

The value from pci_bridge_d3_possible() is used both "at suspend" and 
"runtime", but what we're really talking with this issue is is the 
behavior "at suspend".

> 
> Let's be specific about D3hot vs D3cold whenever possible.
> 
>> +	if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
>> +	    !platform_pci_power_manageable(bridge))
>> +		return false;
> 
> If ACPI says a device is not power-manageable, i.e., ACPI doesn't know
> how to put it in D0, it makes sense to return "false" here so we don't
> try to put it in D3cold.
> 
> But I don't understand the ROOT_PORT check.  We may have a Switch
> described via ACPI, and the ROOT_PORT check means we can return "true"
> (it's OK to use D3cold) even if the Switch Port is not power-manageable
> via ACPI.

This feels a lot more of a potential to cause regressions.

Something we could do is include the value for bridge->untrusted in the 
decision, but I'm not convinced that's correct.

Another option can be to merge a series of changes like this:

1) My v5 patch that adds the quirks for the two known broken machines
2) Patch 1/2 from v7
3) Patch 2/2 from v7
4) Another patch to drop the root port check here

#1 could go to 6.5-rcX as it's riskless.  #2-4 could go to linux-next 
and if they work out not to cause any problems we could revert #1.

If they cause problems we come back to the drawing table to find the
right balance.

> 
>>   	/*
>>   	 * It should be safe to put PCIe ports from 2015 or newer
>>   	 * to D3.
>> -- 
>> 2.34.1
>>

