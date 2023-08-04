Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1688E76F907
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 06:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjHDEhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 00:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHDEhU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 00:37:20 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E00420F;
        Thu,  3 Aug 2023 21:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMgSr2M7cU/ASkzlKn2HV6VD+uCC4Z0tq04UAvWfCmp0DXRvncY6QoVPSHSjE+l9wOFPe8Wk3Jqptak03sFaCA7xEcLZgKbiJgDUr6KetLY2AbaJeb0fli6kzGrVml+f0fdBqdAcpJugAZ9tqRdF27q4rBs/ee3YIjt94i0t10AvaMdqh5oXUWyJhw4+cQZ4Ro/xzGD/vsfGQ3GKE2g5Fh+S5RPBaSfmpzigLRPKgjzXRYZ3gecLHt2jY6/PllhVgjLFJuTtiJu1kDI8+ND6GfOTG0ten62isVmpQkk+nVOGpyzMoD+8bcr+pGLVK0sauC0/DNsgVBKUoBKZ9zzIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaqrIod005eQGlp+2VsiDtTJ/9cqJR/Va/weuf3g5YA=;
 b=eO9MpnzY9R47ZJC5b+IWIdX7KXDBbXlCV+tErjdg6DpAW42e4WehAXeJFF2hhc8AIRXd8B19wRBXD3IjpOShw7Gem2RKM+pD/FTMvurk53AZPKVCtx4RWO0kcPjBlmCbrU7Q9DSRszapw1Cp4jmSJOEcIbb6sqJsbT50CKCF0gNwi7nUS8nKcJh8hJ9hOJHPndWs1nMC/AEL2VFMgNugaa7OoCPKmi/omU5uYGxrix87HXC/WdOrjOeu4r27rs++UX+kSK3XTnpA71NrqGVACdwr4LSrkQtD4OVxUM7GG7+BSzvBo8gp5DQr7B5zHW0N9UrIy9L5Enr0XIgl7iAX/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaqrIod005eQGlp+2VsiDtTJ/9cqJR/Va/weuf3g5YA=;
 b=lq+8zvLs+weYubgGH+51cghnGqZmKkTwNzNd8ZSsLwQiNsYUpKEQIsgLhw+2yLMRmqthUFFm16odYYdEbyRvrUVNOddWcAMtKL2mnlXazUO0njwZcZMCJLk5sSOe4YEde19Eq6SDVJLL3sYwB+Pg1pgzzMoOyjXrkupIPyENfIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 04:37:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 04:37:13 +0000
Message-ID: <f864f6ef-29ae-8cb6-b46c-ee0f32c32fe7@amd.com>
Date:   Thu, 3 Aug 2023 23:37:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 3/3] PCI/ACPI: Use device constraints to decide PCI
 target state fallback policy
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230804010229.3664-1-mario.limonciello@amd.com>
 <20230804010229.3664-4-mario.limonciello@amd.com>
 <ZMx+4CxT/b8ShiWR@smile.fi.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZMx+4CxT/b8ShiWR@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0060.namprd05.prod.outlook.com
 (2603:10b6:803:41::37) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: d67c078e-e5d6-4032-c4cc-08db94a4792b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mGoUDxi32xAvgAwZ0FkmYBaSk9jux12Jc3yxXUxxIqIIbnZaj833YcnFPFzTuAjsRSckWM7YVTGd75EeBdaAD2x4wg69aq+N3EDolKx4RFxRF/iCtx/N+bZ4ufv525PM4RQyCXs6rVGbGe4CgDLC5c+k8ML5ELb/dmNZC4Tts3TvoDmmpOLpLh5fXDVpeVPGNPd4Gx77L1oY2pL372bu4TrxJSBn0khGCtDB3CmE1VvmjX0GtrS53MQ6ZdkzVvQXHe7jzL9q4A01+OEjAI+w9P63kW8WmU6LzfBsERn5p8AKyHzJPgVIDUA5THMMADb8cFWZa2vRTUVs36ErtTxYOLxHN1l1ULNuCjIIyqa4weHs05q2GgMv2QdteZr5DLx3ODIWf1I75uwB+LNhGVbRoWC3ft5w3vv+WOHT4QP4zLhp3OVV5hyJuzxYFR3Frowdnu9PgrA1vEDNS/YSaMgClsrjJsbwgF2lTGatwc8tzI57pXPNEDmBYeVIhWgXHwuZstvE4w2W2kN35WqP1LqZNw9jH96rORdPedPrM01W5waAuv7uKb1kt+Z6icSU7sdvX9QpvZ5Nq7q7jSzy6EEdzPhf/tZZ64zdVclIfKj+YMkRF/qBatAZgwwry+Vzq7Me04EX+yDBw7ngmkH4U83KVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(1800799003)(451199021)(186006)(2616005)(53546011)(8676002)(6506007)(83380400001)(66476007)(2906002)(316002)(4326008)(66946007)(5660300002)(6916009)(66556008)(44832011)(8936002)(41300700001)(6486002)(6512007)(478600001)(54906003)(38100700002)(31696002)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHg1bEtJU0hudnY0ZEdQSjJ3WXhzdXI1S1V4UjRnTW9QTS93c3ZHRFR6djMw?=
 =?utf-8?B?Uzk3NkJ5TVlMdTF1RzNRMmlLWERFUVVGWGtMQ1htT3dBT2VWbWNmVUxUTGdj?=
 =?utf-8?B?ZWJkRmNzaVowTGpTQjZLa0oxQUpnbU50Zmh3S2tYY3R2Tm5udUhFdmZ4aEtP?=
 =?utf-8?B?YlB4d2lIM2cyU2FYZWpvRjF0TUpDdXRUNmRORFpxWXpZMlJROFJ1TlcrOFNy?=
 =?utf-8?B?Vk8veTRWQ2l6TzdEdGNzRDBRaG16OWdwWHBEcW5JeGsvY1FkZVVzYVRPc1pR?=
 =?utf-8?B?NTAvd0M1dFY3TW4wRGE3UVhxeVdwcU84Nk1ScXNZeFN5dVV0OEJyem84NGFq?=
 =?utf-8?B?TFFNczdVbDhnL2p6N0N1NFhlcFlRaTZ4REtDTmx6Mk9mbktIbWozdGpLckRn?=
 =?utf-8?B?aFV4ZUVId1RTeEcxVm1wYmRoVHRoNFBuNU03SVc2TTZaWndhUC8weVYvOXZx?=
 =?utf-8?B?Tnp0aFVPYUNxNDFQRFFNaUZucFlBZW9RUDdvRlQ3WkhJVi9CUEk1OTF4Ykhk?=
 =?utf-8?B?Yy83Qy90ZzBIaTJjRy9RVEN2OFRXOFZiYlJoVmRYTjEyL2tFTXdXNjNGejBV?=
 =?utf-8?B?Q24xNDJmU2IwbXF4a0FXa09iWG1MSUhXdkd5NkZOZk0vYjFaWkllSVRJekor?=
 =?utf-8?B?ZEhPb1FmYnJOQjJCOVJhSEtJdGRMdUVhekdjSVphRDdwbU1FOU1zWDJKM2wz?=
 =?utf-8?B?UnFwTklvNU1jM2ZLN2drS1BENjN4d0dFbGl4SWgvQ0x2bzFnL2l3TFhnRVhw?=
 =?utf-8?B?aVpidFRuUU16dDgxQXVQWTJ5NzJoYU92RnpQUEVRL0hzYzhIR0JKNktvVE5r?=
 =?utf-8?B?R0Vqbk4xVjA5ekhPb1RLK2g3Q0FnTHpHTlJlWkc3Zk1wc0xST1I0ZDA1K1k4?=
 =?utf-8?B?TnlPTjBEV0ZvOElrdWRWcldvQmJNSEhpc3h4MVpkMVEwd2doMnJ3djJZeWVL?=
 =?utf-8?B?WEJlYmtUMnRqdklxU2QydjZHcWRTQWtHVUJ6cU1iNEdEVTI1bGJGS3NUYzFI?=
 =?utf-8?B?Q0xOME5oNkRIcys3TFV3OVhjYjJwU0xSQ3BUNXFBTC9qM1RFYXBxUlc2MHlJ?=
 =?utf-8?B?S2p2WEUwQm50ZVZPZy9WeUpFS3hwaDBiNUtpYVdjZlovVkJqVm1OUXNycWtj?=
 =?utf-8?B?cTR3emVXYWZ1cWpTSG41YVI1QkxYcEFOK2x2aHhIdnRmOEhad0NYdDEvUzVY?=
 =?utf-8?B?cURKZ1REOE5Ja3kwUnF3ZTdEemRuZy94MmptaE1wd3RrYlZXRGx1MjI4L2NQ?=
 =?utf-8?B?bmdWOVQxcjl0Nk9ad2ZVelV4TWdvR2pZOHFtdFBMV1R6S2JHMDB2enovTy9O?=
 =?utf-8?B?YnhQOWZhYlNrVVE4c3ZLRC9KQzNHc1hLTmIvS3ZSbEN5b1BSalo2Z0E5TUc5?=
 =?utf-8?B?cUtzSU50QnFOOVFvTm1BTWFnT0c5bDNQRURyQ3hMbEZBUTNPMHpyK2NPdk1W?=
 =?utf-8?B?VzBOUE1oa20xYXpzL1BhM0ZIUGVsenhpUU1vZlJsSDg2M2hvLzlrc1AyRjZJ?=
 =?utf-8?B?U2l4dnlwbDJ4RmtzMVcxSmpBa2U4UXlrdWIvWDVraWVRK2NEblZHZWl1Q2N6?=
 =?utf-8?B?TFMyYXVGY05nQnJwTFFtSFhxM2RIUUFYKzZ1ZDBtTTFYNW8vZ0cxNXpNN1hk?=
 =?utf-8?B?T1lrdE5BaklXbmVya3pva3M5TUtDejR4ZTJvQnY4WjNra2ZkZnZOVXdHS0VO?=
 =?utf-8?B?THdtQ256Vk9jTEdkY3ZLVUxBYSs4UTFJUkppVEdERjdtY094ajNvZjhTZnhv?=
 =?utf-8?B?M3JMeVFEV3BkT0dtSmc4YTFlZUJhOForYng0RVdNTDVrejhRQUlENHk5a0hI?=
 =?utf-8?B?OGtJVXZaaTA4bGtsOHBnWjN2eUQ2dmdkT1NzNjYwZ2FZajE1ZWYwam1hRE9W?=
 =?utf-8?B?YjRlR0dRK0FUWk9vUU14N1ptanI3ZVl5TkZnM2RIa3ZjRUltUGJ4RVRhL2tY?=
 =?utf-8?B?VDNRbmp4c3VxNnRNRGkyK1NCWFBMOEI4MGs3TkQ1RzllZW5kelBzWm85Vmx5?=
 =?utf-8?B?SWFUMEpTL1NRMzhWVHRlT0dnTTl1NHFzOEZvalo3ckNJNlVHMTFyZFBwUXBB?=
 =?utf-8?B?UEc4c1NPY3AvVC85Zlc4dTB6UytsdzJhQVJ2ZVhkQi9ycDVmeE1aZkVBQytS?=
 =?utf-8?B?dXZCUVk1bE9xWE9tSkVrSW5YWDN2d3hUeXBwNHczaDBjTDB0WjNWUVk5emFH?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67c078e-e5d6-4032-c4cc-08db94a4792b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 04:37:13.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lk0jRxsjDeYZTqS5HpV+y+8qXetJ3Eo58gUpXwUVst/ZgkwXpfHNz0dkf7+JfSoYr3PqdTsrFsZMMzZhyZLjtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
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

On 8/3/23 23:30, Andy Shevchenko wrote:
> On Thu, Aug 03, 2023 at 08:02:29PM -0500, Mario Limonciello wrote:
>> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> PCIe ports from modern machines (>=2015) are allowed to be put into D3 by
>> storing a value to the `bridge_d3` variable in the `struct pci_dev`
>> structure.
>>
>> pci_power_manageable() uses this variable to indicate a PCIe port can
>> enter D3.
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
>> one or more objects described in the table in section 7.3 of the ACPI 6.5
>> specification.
>>
>> When devices are not considered power manageable; specs are ambiguous as
>> to what should happen.  In this situation Windows 11 leaves PCIe
>> ports in D0 while Linux puts them into D3 due to the above mentioned
>> commit.
>>
>> In Windows systems that support Modern Standby specify hardware
>> pre-conditions for the SoC to achieve the lowest power state by device
>> constraints in a SOC specific "Power Engine Plugin" (PEP) [2] [3].
>> They can be marked as disabled or enabled and when enabled can specify
>> the minimum power state required for an ACPI device.
>>
>> When it is ambiguous what should happen, adjust the logic for
>> pci_target_state() to check whether a device constraint is present
>> and enabled.
>> * If power manageable by ACPI use this to get to select target state
>> * If a device constraint is present but disabled then choose D0
>> * If a device constraint is present and enabled then use it
>> * If a device constraint is not present, then continue to existing
>>    logic (if marked for wakeup use deepest state that PME works)
>> * If not marked for wakeup choose D3hot
> 
> ...
> 
>> +/**
>> + * acpi_get_lps0_constraint - get any LPS0 constraint for a device
>> + * @dev: device to get constraint for
>> + *
>> + * If a constraint has been specified in the _DSM method for the device,
>> + * and the constraint is enabled return it.  If the constraint is disabled,
>> + * return 0. Otherwise, return -ENODEV.
>> + */
> 
> I believe you get a kernel-doc warning. Always test kernel doc with
> 
> 	scripts/kernel-doc -v -none -Wall ...your file...
> 

Thanks, will double check these.

> ...
> 
>> +/**
>> + * acpi_pci_device_constraint - determine if the platform has a contraint for the device
>> + * @dev: PCI device to check
>> + * @result (out): the constraint specified by the platform
>> + *
>> + * If the platform has specified a constraint for a device, this function will
>> + * return 0 and set @result to the constraint.
>> + * Otherwise, it will return an error code.
>> + */
> 
> Ditto.
> 
> ...
> 
>> +int acpi_pci_device_constraint(struct pci_dev *dev, int *result)
>> +{
>> +	int constraint;
>> +
>> +	constraint = acpi_get_lps0_constraint(&dev->dev);
> 
>> +	pci_dbg(dev, "ACPI device constraint: %d\n", constraint);
> 
> Does it make sense before the below check? Why can we be interested in the
> _exact_ negative values? (Note that non-printing is already a sign that either
> we don't call this or have negative constraint.)

There are two different negative values that can come up:
-ENODEV or -EINVAL.  Both were interesting while coming up with this 
series because they mean something different about why a constraint 
wasn't selected.

-ENODEV means the constraint wasn't found.
-EINVAL means the constraint was found but something is wrong with the 
table parser or the table itself.  I found the table parser wasn't 
working correctly originaly thanks to this.

Maybe now that I've got it all working you're right and this should go
after the error checking.

> 
>> +	if (constraint < 0)
>> +		return constraint;
>> +	*result = constraint;
>> +
>> +	return 0;
>> +}
> 

