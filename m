Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C1B70E759
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 23:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbjEWVaA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 17:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbjEWV35 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 17:29:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA0611A;
        Tue, 23 May 2023 14:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuWo0Qj42nYKMwVZ4Dt6uNv1Y4fpGuLxbXdXqvYOuln+om+2267brFhji9VtI5hlnJaFl04Y2SNp4FYb1ki3tnGUryoa+5dN1FxciRTgIWznCZWExD0U8F3A9bHXhF1xa931s54wkLP0sc6p/QYwXCAXuU4g8HOsjBJs+q6BXBf5piDqH//ignD47W0dY4Aw/tUercrU8eybm+qUYW7bAN77Xsdi0+YWclC9+bDT6maBeHuYa213POuLXGvJrQayAT22MjcPDpQ3vJt6CbSMgi9zt52MbOPcbm22s+hKY/hmuQWxT1+M+gOlQn+WgWRuhfN6m8iw0GjZCX9NCIbBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkFcfBx6R5Kum0iQPnQhwyDUtUdWR4oPE+eLo7ysetY=;
 b=VuMW+JHT5Ij0C8MgtYQqw9x+h1juH6MVWzSb4TI3H6Dg7BLyEJIMH29G7XT/FoJK3ERYeYfTgYySubkJJPcTHdjwBd/PZzOB2ZfPmDK9fTstMvHJJCrVmUkQpl4bQRG7jFc3btTN12jbPp+VuEsAecNgNuxdCWXFooLaOTX3KBC/6btHjsAthwu2E3ttIumER8tc02zAx8sqq8GBMvgGEHx6Ed6uoCA3ywGOCGsMHsI2JQAe+SBf1c3KENjurK1j4hDHWQgkzfYQkLuOa6zUsP9nrXq1rYlvtTNAPLcI3JahN9NZ4KDvG/+715Ekzd9Y9cAmxGmx9+FXoih+hZof2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkFcfBx6R5Kum0iQPnQhwyDUtUdWR4oPE+eLo7ysetY=;
 b=V8EKXp91LA0MW39vv/hnutkkGBBxFETB/Q24dzINkrb2oX8CgudozHKZkg4c79Oi9wo8uJM2jng00dqavYobONX6fkaHBF7K9RL6oIvROMJwn2zswAvpeNlLfN3fpfLXCHBv0n7m51NjYCu47+vQYW63wTCOPg2RqORDvIPV8mA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 21:29:53 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::ea3d:ec42:656e:a248]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::ea3d:ec42:656e:a248%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 21:29:53 +0000
Message-ID: <654d2a59-9836-cc6d-c521-6835d725284d@amd.com>
Date:   Tue, 23 May 2023 16:29:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] PCI: Don't assume root ports from > 2015 are power
 manageable
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
References: <ZG0jhvzAZnfscSeC@bhelgaas>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZG0jhvzAZnfscSeC@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR08CA0039.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::13) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: 575144ab-757e-4694-049e-08db5bd4d8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tBWtFsxPBm8e/KejHcgpIqP1iZxwIdkkSxlx5yO3n2Z/YzD0sjCfT5VEeRD8Q5I704PdvTPs6X4EGk9DrZv2awK4Oo3OmTgvxkx29ZBp69GASLiD/MiaiAnmc7PxZ+usLMBA7znQCXADVjPcXo+ETtUZfRl7RrdmOt5Ak6rUtEYNkHpMCV7j+D8eBfH1GdRD+wAOp/Hxk7X0HfZDN8Ut7XxfO9iK9Hv1nnQb3RBx3RJVkHEPqv14UdtsH9PqtR1tLSLUrlu9nmG17bmix2FYVPrRMU7IId2DtPSgqyau/rsP4jdLquJ5V1KpHo2bplGljQt8wQtFhRGeYGrAtptpJOHyDKf/IaJwvlsE/ojizIRAtv8WWTGcAsu43ph0HcsJMRkkC7xPo9eOZKzu8uVX2JyMNX3gUrQfURzrjd6s26Sa+FowjthRYS5uvJKH1G9AxVWPWzXkyAEzH4M3Uxaeri0Tm4gEZjy4gxu1h5HNDQcwBXF8e/IHv7ESrTo7+LVeK9RLJ5xl6PmTN0PjhYvj51IsKcSTTHoYjex1Z8iivMHQ6P6IrzWcaA7g2980zdIR93sCpvq8AQLftLY11R0UJf0R0T3WLe2AsdvEijXNw8kL82OxWVY8RrAjFDvO49UzWFBZEhHRVfju9qSTScYYUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199021)(31696002)(54906003)(38100700002)(41300700001)(6486002)(66476007)(316002)(4326008)(6916009)(66556008)(66946007)(5660300002)(966005)(8936002)(8676002)(86362001)(478600001)(31686004)(83380400001)(66574015)(6506007)(26005)(6512007)(2906002)(53546011)(186003)(36756003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTJEY0dORTcxSmRRMkMyS3JRU3RJNE56dFRBSndnb2p2cks2TWVCdm5xdzEw?=
 =?utf-8?B?dHlIVGNyd1QvTWxjcHI3cHFjUXo5ZVhpZDhpNDRvZXhSVUVnUkI3OE9jV0tT?=
 =?utf-8?B?cnczaDgzRjBDMG9henhOOUlkeDFzNkNCZENSZk45RFdaL2pPOXRuZnArWThh?=
 =?utf-8?B?V0dGcklVRDIwZXZKdTVrSWY4cUxHV2RVZWlIVzNTSk4xT1NQdDNzblhHc1FM?=
 =?utf-8?B?U3lCOTdGUmQrdGExTUVJMkw3MEFLRGlqNUZsbmtSQ3o0bzZBczY3bWVrOW80?=
 =?utf-8?B?NnlwOVM5bkdzdjRiZ0VHSlg5ZnpmOWxKRW9tR0dZWGd1MlBsU2ZnT1FGK0dY?=
 =?utf-8?B?UnVMUlJtOEY3Z3Ywd24xQ1pRWlNHSjZWOGVmTjhwa1U2Yk9PSkt6Tmp3T2VL?=
 =?utf-8?B?YlpPN1BiVFMrYzRsL0VHQTF6bXRka1Bkdmh4WWY4LzhCdDlueTY3NGtySmFR?=
 =?utf-8?B?M1NHZkhDTW9ITkFEZ3lWVTdsSEREL1h6L3NFTzVxSkw2MU9xVDU4ZzRjUEcv?=
 =?utf-8?B?T1g4eVVDclorVTBqTmF0VE9HdEpsZkVvOVFyazVzTVF6YUo1aHRoQXNiNDdz?=
 =?utf-8?B?N0ZXcWpMZEM4RExpblY2YXBNQklKeVV5YnBQWUUvaHBubGlxQmQ5ZHorOHlW?=
 =?utf-8?B?a3NLMjE0SmVnWC8xN3lWOFRVdE5oRURoWEM2TjdlMDRYckRzaEd3TVp4eEpV?=
 =?utf-8?B?SjBqajdqK0MwWEx3QXFEVE9XcFNIOE5LcHY2OXhlcHNIUW0veklTcEU1bWta?=
 =?utf-8?B?QXhya0NGd0JSRm5kVXNpRmpIajJjNTM5S2g1SVVENXp6Vk5LTEVOanVSVkJU?=
 =?utf-8?B?ZGplZHpkZEJpZzE4R3dOcFZ6U1dOZ3IzaXlYcGdwUkY5ZjRDQ1c2ams1bGxK?=
 =?utf-8?B?NnlBbmxpZ3dYV0ZOcTBxVmM4NS9rNUlKMEJxL0IyaEVXZnJNL1BNQ2l2N2Jp?=
 =?utf-8?B?bjhTRmlZYlZXRUZCalBEamZvZ1NiWXhwMDNTSFJFaVdGaTM1NnlkSThGeHFq?=
 =?utf-8?B?cXFzNXBCSnU4VmtqZ2ZuajlJRmU5L013OXFDNEdmMWZpUmdrM2tiL3VvVllo?=
 =?utf-8?B?ZXNoZ3lvMVJJV2dDTXo1MFI2Y1dydDU1THpZTjJhelNKUmJzOTM3UXB1a212?=
 =?utf-8?B?N1dFejQrL2k0MHFNUTF3REV6RkJ3cWpjNkxDb0tpYVN1RVZRK0dpdWlmMmVS?=
 =?utf-8?B?dHJDc05KdlI5Q25lcTVVaExqT0l1U0JjRTBud21nbjVYUVZTSDJlb1k4d2Zk?=
 =?utf-8?B?by8vR3ladnpBNXVFSVFpbEE3WW9McFNySlY1NTVvbzZBODVYVUl0VG9URzhs?=
 =?utf-8?B?ZmxaSTVvaWtPMjJKcWVFR1drUkZzWkltc2gzUEovYUtqM1YxT0gvWHpmc1J1?=
 =?utf-8?B?a2x0UWk2djBHRkJXY0NaelVjT2hTSWdlck1lSEZtZnVNcGdaOVkzL1NzWHJ4?=
 =?utf-8?B?WmduREp2TnZuOVEwRHZDZWFwNUV4Q0JaSWIvc2ZQK2RubGNxMzRXTThVT21D?=
 =?utf-8?B?OTNXV29tREM2Y0NoL1l3TnFPMlZaMVkrblZCNFFab29KaUxJaVFrSkhPeS9p?=
 =?utf-8?B?VHNSTGI4eUJ0TlJEQjlPL05WL012SWlSMWx4cTlDTE5ncVE3WWUyby9lWW1v?=
 =?utf-8?B?Syt3Nm5FL3VZQjZ6RVRTcWRUTTZVdWVzT0J5OE5GR0E5L0pKb2drWTlYdkpx?=
 =?utf-8?B?ekY1bmNqSnQ2OWI5NCsyYWw5TkpacTVEek5SZ3hvOTF2MmgyKzI5WVdMQVR2?=
 =?utf-8?B?blhoWGZxRlkxOTJpYlNVWElBT1pVNnk2UHk3bG1DRHg1K1MweXloV1BSQlRP?=
 =?utf-8?B?U3k5Tmh3blo3R0E2d0NkWUNTVWNycHBZa09aTDJ4UVNTOFF5bUwxUVlmakJq?=
 =?utf-8?B?R3lMN0MxUi9pZ29aYS9uYUxFRU4wdFlIemp2MWpIR0VaaGxMOWRvWVU4cEdr?=
 =?utf-8?B?T3dQc2hVOURpTVhGYUVmODhsUUJGeHVxeEZNM1VTRE01QXFqRXRicmpUYUlZ?=
 =?utf-8?B?NXVNM2dBOUtERUJhYUFIaFlhMjc0djBUMERHRnJMb2J5UGZmajZmczNuMWk0?=
 =?utf-8?B?RGtPZlFnakZjSWxPTEFrWDBYRGFYZURhU0huWFNZMkV5TkFqMWY3UjBLTG1G?=
 =?utf-8?Q?C76A4Ef/VIoQni7bPLkkatLNk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575144ab-757e-4694-049e-08db5bd4d8f4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 21:29:53.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFkWslSikpnWQ9CfthCGEvJEvo25EEbEKJBZfsHBKSff43RbMPo4KDxuBOz9fIcnmu4eIJtIsMMF78m6xMEwVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 5/23/2023 3:35 PM, Bjorn Helgaas wrote:
> [+cc Rafael, Lukas, linux-pm]
>
> On Wed, May 17, 2023 at 10:08:27AM -0500, Mario Limonciello wrote:
>> Using an XHCI device to wakeup the system from s2idle fails when
>> that XHCI device is connected to a USB-C port for an AMD USB4
>> router.
> Are XHCI, USB-C, and the AMD USB4 router just examples?

They're very specific to this case.  If XHCI
keyboard/mouse is connected to a type-C port that is
not connected to AMD USB4 router this issue doesn't occur.

> I assume the
> same issue could happen with non-XHCI and non-AMD devices, too?
Based on what's wrong with Linux and fixed by this patch,
yes this *can* happen to any vendor that the root port doesn't
support waking from for D3 but Linux uses it anyway.
>
> I assume the problem has something to do with PME_Support and some
> device being put in a power state where it cannot generate or forward
> PME messages?  I think the PCIe protocol details would be helpful
> here.

No; it's specific to an internal sequence in the SoC.

If the problematic root port is in D3 during s0i3 this
problematic sequence happens.  If the root port is in D0
then it doesn't.

 From discussion with others in AMD that's at least one
reason why the firmware doesn't advertise any power management
on this root port and why Linux shouldn't be using it.

>> Comparing registers between Linux and Windows 11 this behavior to put root
>> ports into D3 at suspend is unique to Linux.  On an affected system
>> Windows does not put the root ports into D3 over Modern Standby.
>>
>> Windows doesn't put the root ports into D3 because root ports are not
>> power manageable; they're missing _PRW and _S0W.
> platform_pci_power_manageable() tests adev->flags.power_manageable,
> which is set by acpi_bus_get_power_flags() when a device has _PS0 or
> _PR0.
>
> So I don't know what's relevant out of _PRW, _S0W, _PS0, _PR0, but
> this sentence doesn't seem to match the code.

The firmware doesn't have _PS0 or _PR0 either for this root
port.

>> Linux shouldn't be assuming they support D3 just because they're newer
>> than 2015, the ports should also be deemed power manageable.
>> Add an extra check for this to ensure D3 isn't selected for such machines.
> Is this talking about D3hot or D3cold or both?  If we can make this
> explicit, it will help me out.  It's probably obvious to power
> experts, but I'm not one.
Both.
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/pci.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 5ede93222bc1..3fe27aef09e6 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3010,6 +3010,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>   		if (dmi_check_system(bridge_d3_blacklist))
>>   			return false;
>>   
>> +		if (!platform_pci_power_manageable(bridge))
>> +			return false;
>> +
>>   		/*
>>   		 * It should be safe to put PCIe ports from 2015 or newer
>>   		 * to D3.
>> -- 
>> 2.34.1
Something that this patch makes me wonder is if the original
heuristic was actually correct.

Did the PCIe ports from "older" machine have everything needed
to let them go to D3?

Or would this change also let the heuristic be dropped?

