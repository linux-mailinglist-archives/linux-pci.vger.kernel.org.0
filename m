Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684B07D5BBE
	for <lists+linux-pci@lfdr.de>; Tue, 24 Oct 2023 21:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbjJXTpq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 15:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjJXTpp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 15:45:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F41F111
        for <linux-pci@vger.kernel.org>; Tue, 24 Oct 2023 12:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jpm4jaxhZVhS++3w9BE4A+PdiZwFmQMkqGzwDfPQCUEoJzhHF2CIdme4TB1mucFYaWCG4NynOz6qNBKgVJOEcalYuFunoekVMCi2fpfKqOtzQzhNOPPHJhBstr/JCaAMlkVZH363p2Y/IER/l2RjT3JPNQTXEW7XFKQZVYCmd2ulxCGnLaYAIm8cINXmBibZtixtPU9Gy+AoAUuNOFan63rKv17reIU8HrAuxSwLeL39hbC/H60ikJHkE/2OLEXsTTTg63iCqE9AmKN5lTV90BSroqSFF+Iafno8Hpves7WBVHC1Qy/6iDYs7gsSJKGFejnYUi2dUaOfCj5j1bwSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BI9ty3nMXN7zOvQzduMQrvecRYqplvaQyOZzNWthI44=;
 b=hCO+1ijSJANsVSt7R2TvNOo96MHIncgb8DYKAfQveaQ61sPbROZXSh5pVLAAYZUH+c4WNTeIMOKc9BiDrTNEY0tu8OV5c59WEEVDTegdIoGiLwPnC0d1tGpv9hpDGKLkHPSoQonBrsqcKajVWKsIHUlZs8CXyx8Vy8FiUluUIZir7QaNI3jjhD7iU4fAmwc6dsplz+9CaPD5NG9bFqbLZZ3M8N1hhGhbNAvKov+TQD25G/IppqrIVHARaslT4PWujnm44T4XstGQcn4Oo/J+/PUXqxsG2ypujI/eHgH80Coe8V+JnPfvfA8wBqailFI+RhyLhLYlcoxLDvftxh6qBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BI9ty3nMXN7zOvQzduMQrvecRYqplvaQyOZzNWthI44=;
 b=kFNxhgJwXn6fJn7qnZ8vDKMsWC3NUE6aYNhyki6+fIQRNb45pL+kBB3vW3kOqfUnlyoKaBmzZ1febZwOLfRkCveU7jsldBjaA8qNjdkz3nhLf+VobUAalMFfODSBA4DL9IcID+gg+PRVmSTXk4ahZ62/fOfFd3jMgpcODd/KSxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL0PR12MB4963.namprd12.prod.outlook.com (2603:10b6:208:17d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 19:45:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Tue, 24 Oct 2023
 19:45:41 +0000
Message-ID: <00cf1ce5-a850-4e39-b698-bb16ba71c190@amd.com>
Date:   Tue, 24 Oct 2023 14:45:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 4/4] platform/x86/amd: pmc: Add support for using
 constraints to decide D3 policy
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
References: <20231009225653.36030-1-mario.limonciello@amd.com>
 <20231009225653.36030-5-mario.limonciello@amd.com>
 <CAAd53p52668p46Bocx2z4VejGFvWz+JUHuz_J762zsD3sJPgUA@mail.gmail.com>
 <1ff61826-0cf4-441e-9e7c-7d8e4cce0606@amd.com>
 <CAAd53p620SFMetOeig-JE7mJzMt7jpFcB8tA=SNSOhi93QMA2Q@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAAd53p620SFMetOeig-JE7mJzMt7jpFcB8tA=SNSOhi93QMA2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL0PR12MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eedeed7-d36f-4c43-4916-08dbd4c9cdb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lf2ujDqmZN56YMdL5dQedaTo2r+MvFgaq8HSDPCGsjonotYglwIVZQMAElT/hWEpjx26pbWFVwuPwVHmKErlp2kcksJpHtzH2BwvnMXvKairJ0AApiYGWvU4lLqMkFLn4dlrx3MdHHSJffyWtfXQ/xUf5zRp0fv7qTGIT4yCCZUOYR0qgm19XOAzJsMEnJi3ZCAehpcRxx8j4pkTljg8//ThlZ7YAaaX3q5KVOllXSyhgwjcxcLnqMgKZHfe/XahFMIMtHj5W7FmG/5kQUag11d3A5JlK57GN9DYdBXOY4GEZFSjFOtpiXLah9GsRwwdQQtzQNFxL/nbUgdDP88ia+nAl/9lMVbmTFFNNUZgsuckcrTe9o+CoOgyR+QzvJUprjEBxX1SjyncjQROojDSG9jpXGhgYY2YYUdSas6I7lzMjy8al4jQfm3jXoJCuoxep1/SxKXQKua34oB3jWcz33ALJCyTjO+6x7e8flT9pAGEIWDhUrARkDBxSUsF/724pyWVy868GU9M6By+E6jzQVoVaMCOtI+8MA5XYD/yamfrJmqZQBZsJQpQj4DGH28sm98FV069bbqlyzFIkRxayeuTF51SiyCq4czYbr1qU5STFK8hgsUQcX0S8bGrHiSULDOn7Swnv/McFnZ7ir1mgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(31686004)(38100700002)(44832011)(2906002)(86362001)(5660300002)(36756003)(4326008)(31696002)(8936002)(8676002)(2616005)(6666004)(478600001)(6916009)(6506007)(66476007)(54906003)(66946007)(66556008)(41300700001)(316002)(83380400001)(6486002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTFQdDE3ZWV6RlNxS0V2T0gyVkU1NlNZK3VUNTlwNDQ4TFdaODlNTjZ5RkRY?=
 =?utf-8?B?LzVCRXJYUGdJd0F6cTZGNXRNZ24yRXQyUk04Mkd1K0trd1FMNVBhQTZIMU1Z?=
 =?utf-8?B?Uk9lb0Fuek0zeUdpc1ZZdE1tdnhlQzNjNHdOUnMxdWYwYjlNc2FUOXBZeXNj?=
 =?utf-8?B?UW9nLzlSSlM4clVWSFlCdmt0TkNWam9xK0pHc2s0ZGdFdGtRR3V2WVJoVnZZ?=
 =?utf-8?B?YUxyS21kOFNwTUs1RW9yc0lscjdiRStOLzd6Q1dGWUsybmtTV3I2TVU0bE40?=
 =?utf-8?B?My96MWR1NldibkYzdndUek4xQXRMOUdMZFVQUlhjSzE0NFg3ZFpua3gvVGQ5?=
 =?utf-8?B?cnRxOVYyYjkrYVhZdThjcGVNNU9pT29qQld5d2p5OWtWU2poV1NEOG9aOGZN?=
 =?utf-8?B?aHNxZlowa1pxVTJWV2ZMVjg2aFVSMXVBYWlBelVhVkFIOXlGN01rdUhadTVs?=
 =?utf-8?B?OGlvbzJYcnF6ZGZtZ01kMW1HbzhjVyt5K3hKQ1Z3VWt4aU9qNUZuZUdoQU5L?=
 =?utf-8?B?SjRrSGNtWnBnbTNzY3RhdE80N1JzcTk1VGhicFd6RHRIcXJCRGYvWHFoVzlH?=
 =?utf-8?B?OEtyaG42TlBkV0RzaXpmSFc0UTA5V2NGN0NORzRCdndkYWZ4Y3dFeVJpNTBu?=
 =?utf-8?B?bktJRWxIVU5zQ3pQMkRRUXIxQWl4Tm9wMWlNYm9JMmwwYXVQck5nM2UvdERI?=
 =?utf-8?B?VlE3N3hVUEpOekNmM3A3aElUUm8zbUhvb1djV01nUjNrL25BZG9ZcHR0VzVP?=
 =?utf-8?B?RmN1R2hnWVpPTmlxRE44MGpUaGtKNjA4L2g4aXViS2lIcGpTOGJ5YnBaMDNR?=
 =?utf-8?B?alNLTWlHcW9DZTd2QkFCeTV1TGh1WUw1YWNXN2JEWmU5RnBEcUpnNzB2eG02?=
 =?utf-8?B?Zi9RT0RvNXEyMG9SZ0VHeFpVNVZzZk92MmdXWlFYbTRuNkxJVjI1ZWhTQ1Rl?=
 =?utf-8?B?UVdlZ09WZy9mUXZ1TzBZZExDSnJnRTlCYnRBczVhM3BwMGF3Q2NsbHhjcjBT?=
 =?utf-8?B?LzZicHE1eDNFZGpGWi8rWGcrc3RNSzlQa25neTFRRFZiL085SitiT25Yblph?=
 =?utf-8?B?MjU3dStVUmphenpyTlhQWG1XcnlrazNBZ1orcnVMRHA2WjJhWnp6RFZuaXJ4?=
 =?utf-8?B?MFNyWEx5YXdSYzhSQnM1Yk5PUmR0MnFYSGlSNTZpekhyeW4yUmVrT2tjaUNK?=
 =?utf-8?B?RkRuRDFuTUx1WWVERjdMU3QyZkFXYUswT0Y1R2Fxa3pqZ3hsVEFMVWNVZ0kw?=
 =?utf-8?B?bE8yQlRaMVI3M1I1ZEdUdk40TWQraUh1VGd4aTliVktENktndmVWeUwxbERX?=
 =?utf-8?B?cTltWHFXcmdLeFJETjNNQy9oSC9kY2REU25Ma1VhUkRvazE4bXNhUVZnUWs5?=
 =?utf-8?B?NmpXL05SNk5KV0o3SFEvYVBYck9vSUtDVkl6dzRqSTViak1oNVBzNzVzU1F0?=
 =?utf-8?B?YjZTMjBsZzhBbTNpdVJPcGhiQ1I4S2ZES3NmUys5c0dnUk9FaXF4d3E0dnht?=
 =?utf-8?B?R2FBMzJ4MmRISGNLRDZpSjFwcEZncHlWRmhORU5KdFRPNmZNcXc0MGZiWGNv?=
 =?utf-8?B?WEFLN0NzOG9OQ05lMUpPblJTUlNMNmxWTlVZRmxrUmE2eGFQS2ZrUFhBbXZ3?=
 =?utf-8?B?czJHTzhWdXlUTjdTYnc5Z2dmckQ3R1lYUnpyaEo5UUhUdWpNVzNZUGd0d0I4?=
 =?utf-8?B?MHpVRmlIS3ZHTFdXWThHREpvUWM1c0F3UDQzRHlMcURwQ1pVQitPS0pTTXRB?=
 =?utf-8?B?ZXJGWHJ0MVMxWG9hcGZXUjJLZks3djFrMUoyaEh4Zml4M1JwNHF1aG1laHQy?=
 =?utf-8?B?b1Q1VFN0dmNNaENpUFltd0N2UEhsbWEwWWNzV0dzUkl2dFcvYmFiTUx3bGt6?=
 =?utf-8?B?N2xGeGJvZTVuRCtBMjdENW1DSGJXUXVHVmpUOW02VHdsRXljVUg4QWIyTHFU?=
 =?utf-8?B?a2xJcU10b0pZbmc0Q2pER0FKYjczdkhyQlFUWmh5cGpHeWsyOUMraDlyenJ4?=
 =?utf-8?B?dmYwRjdoRjFsZk1GU3BlVlJ2ZHJwNGwrcVBVWVFxd0tYR2QwWHg4alp0LzVz?=
 =?utf-8?B?aHJCTUtQWGx2UTBaTFlZdDNONU91dFhtOTJSL1B1VEZWdWwxRVl6VFd4UkFF?=
 =?utf-8?Q?04g/zEiE/RVsNrxP+nt5YP6Jv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eedeed7-d36f-4c43-4916-08dbd4c9cdb5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 19:45:41.0444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ae4DkhGxaf7ZqtqnFbdrg4Uvbk5ZXNRslYftNsk00HcB6Qk/nnm0i9RhH4J/nJrVDArKm9ovkLBgS7CvbyEPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4963
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>>> I've seen both 3 (i.e. ACPI_STATE_D3_HOT) and 4 (i.e.
>>> ACPI_STATE_D3_COLD) defined in LPI constraint table.
>>> Should those two be treated differently?
>>
>> Was this AMD system or Intel system?  AFAIK AMD doesn't use D3cold in
>> constraints, they are collectively "D3".
> 
> Intel based system.
> 
> So the final D3 state is decided by the presence of power resources?
> 

Right.  This is why I've mentioned in some of my series that 
pci_d3cold_enable() / pci_d3cold_disable() are misnamed and 
dev->no_d3cold can be misleading.

FYI - I have (slowly) been modifying this series to use 
pci_d3_cold_enable()/pci_d3_cold_disable() instead of the extra overhead 
of the policy decision but I have some problems.

I anticipate future version will also modify pci_bridge_d3_update().

>>
>>>
>>>> +       default:
>>>> +               break;
>>>> +       }
>>>> +
>>>> +       return BRIDGE_PREF_UNSET;
>>>> +}
>>>> +
>>>>    static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>>>>    {
>>>>           struct rtc_device *rtc_device;
>>>> @@ -881,6 +924,11 @@ static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
>>>>           .restore = amd_pmc_s2idle_restore,
>>>>    };
>>>>
>>>> +static struct pci_d3_driver_ops amd_pmc_d3_ops = {
>>>> +       .check = amd_pmc_d3_check,
>>>> +       .priority = 50,
>>>> +};
>>>> +
>>>>    static int amd_pmc_suspend_handler(struct device *dev)
>>>>    {
>>>>           struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
>>>> @@ -1074,10 +1122,19 @@ static int amd_pmc_probe(struct platform_device *pdev)
>>>>                           amd_pmc_quirks_init(dev);
>>>>           }
>>>>
>>>> +       if (amd_pmc_use_acpi_constraints(dev)) {
>>>> +               err = pci_register_driver_d3_policy_cb(&amd_pmc_d3_ops);
>>>> +               if (err)
>>>> +                       goto err_register_lps0;
>>>> +       }
>>>
>>> Does this only apply to PCI? USB can have ACPI companion too.
>>
>> It only applies to things in the constraints, which is only "SOC
>> internal" devices.  No internal USB devices.
> 
> So sounds like it only applies to PCI devices?

Correct.

> 
> Kai-Heng
> 
>>
>>>
>>> Kai-Heng
>>>
>>>> +
>>>>           amd_pmc_dbgfs_register(dev);
>>>>           pm_report_max_hw_sleep(U64_MAX);
>>>>           return 0;
>>>>
>>>> +err_register_lps0:
>>>> +       if (IS_ENABLED(CONFIG_SUSPEND))
>>>> +               acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
>>>>    err_pci_dev_put:
>>>>           pci_dev_put(rdev);
>>>>           return err;
>>>> @@ -1089,6 +1146,8 @@ static void amd_pmc_remove(struct platform_device *pdev)
>>>>
>>>>           if (IS_ENABLED(CONFIG_SUSPEND))
>>>>                   acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
>>>> +       if (amd_pmc_use_acpi_constraints(dev))
>>>> +               pci_unregister_driver_d3_policy_cb(&amd_pmc_d3_ops);
>>>>           amd_pmc_dbgfs_unregister(dev);
>>>>           pci_dev_put(dev->rdev);
>>>>           mutex_destroy(&dev->lock);
>>>> --
>>>> 2.34.1
>>>>
>>

