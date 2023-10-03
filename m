Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8902D7B7268
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 22:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjJCUQ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 16:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjJCUQz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 16:16:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B759B;
        Tue,  3 Oct 2023 13:16:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiCppEV8H708fX27TjCWX6Q6yEWEQRm9cmfFa8+AAWAZ/jJB+yluyHb2F4RcgE4ezNbu7gOwviEB0l288NhnXgt0SWl8cQG+SvYlnrZ2rtAPQ1MV9lj5nk6ANK3lPhRNZWgdaIp6YdWbTSLOnBb3P8z8cBUo2pJhTfoKZ9ztNjoRR3HKJOgDXbp6hhDlTyNB5q/ixO1GIMibl410LHAKdN/oe5+GQYGKmz/wGCCUydKxB9KCascgJuzH02ezgOCMR0JVcYvgEXR6+PDZtdfLnhtrFRqMGxtcFuLmngSV6OsDkNhUlodGuTlEKqpTiKiNcFxtYdff7TOsSdbemFnYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzBP4RFaEBm466/mYzOaFRUSdk9Uub5eqkJPHd2KnG0=;
 b=GX2sxUAlYxaOI4pEkXUWbFFpzadENSzCHH3Q3HoywvEoAGEEiU505attG+UUGypAlJ0lrWSWDBdNg580uRhizY/2wx4zj4Ss+zQJXmMxbLuH/BZ6G8dappkpba/Qckp/D5zwweYSeJQNUBI9rkM94ol9u6LGrgph35sSfVh05BFPI3TekT5+/NgDNz5XWmhld5HYwKVy3wdM140Vlq8LBoqJR/nDAaB4cVmF98/tbRtmbPC5ccoqS8ZEk1w0L8X+gJpe+c5yZsI5X2vg5RNCiFGNv6nL1hMcLVi7POjtU2poWa4Fr5cuEf0xVhO1bznN2IBxiSEB+TFt8YGt+O1h0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzBP4RFaEBm466/mYzOaFRUSdk9Uub5eqkJPHd2KnG0=;
 b=unBRu86Rh6KJEZ3tFlhWvcdyhMYuWDEFnt6WcymQmW5sikq3M8UcEUqCzJHcg+J6t/tEoynQ5ubu/5tLOKqGqPm5mwnyvrbwR3VTY0sF/Dz2NTH4iNCwpgj9MttGZOoVHY7l4CCYvFJhI/hGyzqEr6O67wePNLbYPIGSCtoyW18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 20:16:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 20:16:49 +0000
Message-ID: <33524298-88fe-461e-afdd-85f0763beec9@amd.com>
Date:   Tue, 3 Oct 2023 15:16:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        stable@vger.kernel.org
References: <20231002180906.82089-1-mario.limonciello@amd.com>
 <20231003200034.GB16417@wunner.de>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231003200034.GB16417@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0055.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: c02c8ca2-921c-4203-f9f7-08dbc44dacce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHVc0N/oyvT6kxTz40dMtrfeYc+oufcx2bhb4J8DUG3miaaK12yJ4zrRoWSsFIMg61NjGpTFS9yoAQEsfeiacVs9huyhpyOeZxU3HprKPhNmwEcpIdd3obVHTwaRXEwu24184OamZFN0yHYwLqfuZHBjJwxAvaNuPLpmHn2jzzNnfQBsMj2G2v2wDU2FW0w5accTbcK4tGUp1bAb0zk1sdgwO5VTHrfHOIPuEVQr+j4RVS+YHuP/RJZbrANU/vkhE3oIph0YpdVABz9z46JYRncj4NMIkvVLpqr4xfOGh58MiXmyodLUKpcOfdYNGiUqkMVcQvypaUjVkC2Lz669PSC4ZzIER5oRI9RYY/UujDKx8zh7h3Y3ihxD5imzrZlz/ki+xI/FVsNccRYgZ85iaq3n3y5RTeBPyWzA+2wHEP9E83hTjeSntHE5H3JQhRwLxX6Ky9mlNSguThXcjC8oifCDnQZVMFV1Ty0wpnRnPZZhGvGO/tV4EVyf3ZucaWuw0zxwrlDe7AVS4BkSYmGvJZP2jfqUq5GfECioZCG/Vg4kaj4HeYBvSYLZvLIzwxTvo4xFKOr8SOPq7f3YzS0xAit+MiwdNVXJu1V8FXNGC2JSjKsbHdSew02d3gE+pGOKzaW9SAWkDDrfiWXd3eFBuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6512007)(6506007)(53546011)(83380400001)(38100700002)(31696002)(86362001)(36756003)(2616005)(66574015)(26005)(44832011)(2906002)(15650500001)(5660300002)(4326008)(8936002)(31686004)(8676002)(54906003)(6916009)(66946007)(66556008)(316002)(41300700001)(6486002)(66476007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlVIRit0Q2NvWmN6SWR3elRTYzhlQ3E5WDM4U3RsaGorbzRWcGp1d0t6UEUv?=
 =?utf-8?B?NWF6TXJja1BXajJQekxzbHJpWWo0ZTltL3d6ZllLWUxkZ2RJeXVrb2dtVnV3?=
 =?utf-8?B?Ympvdi9obFQ1bzMxbDhXV1ZtcmtJa3RscWpjV0xNM2ZXbDlITzhQMGxCbXJ5?=
 =?utf-8?B?OFB2cU9LdWFVa3ZXbDNMd2xnNUsra3hIZENZSXU3QUpmSVp2Z2UwbjhZbWVn?=
 =?utf-8?B?c0VVRXVabmhMMVpPSVVlVmcvTkFYT1ZWV2hjM2RmdFlhNVdmckI5UThYSC8y?=
 =?utf-8?B?eFRybWxwMVNsRDlkV2s3SVY2bnJYeDdNQUVoSmJiN1VGMXZwamxWMjZTaXQx?=
 =?utf-8?B?MDFyd2Y0b3EyTk9YaTNsOUVsM2lTWFpwNlQrYy9TZGswWEh3cTBkb2pvd25F?=
 =?utf-8?B?MzNIY09LOHBBK1I5NzNvL285TFB5Y1lHR2xqWTExNythNmNVTnpGaGNBaEpv?=
 =?utf-8?B?WFZTQ09RSGNVZUZJeHZmMXdYMXJsdUlOUmF2WlN4L1ZpczA3VHlsQUx3d1ZW?=
 =?utf-8?B?Y2krL1duY2lKK1hXN3FaWU1VRndWdklJdzR4VHZhb0VMQmJGRHNuOUIzeFRy?=
 =?utf-8?B?U1lxUDNVL0x2dWVTbkp1QVB4ZnlPSTJ1SXdCUEZsNG5FWVhXenZ5c3lQTXpW?=
 =?utf-8?B?QTdsSVVxOHRIakk0bUt6WHgzVjE3NGRsaDdDZGh5OC84eFRwL0dUZUhuaUFo?=
 =?utf-8?B?ZkFGK2VxcGV6ZzFDNTB0UlkrWnlDU0NkWGt3Wm1ONlZGSUt0TDdpQmRIeHU5?=
 =?utf-8?B?eVdoRmNxQzFyc3A1V0NDVVl1eWljdXQxc2dSdVB6NGMzSnNNc1dzVXBkc3Rt?=
 =?utf-8?B?MUF2YUdRL2FXSEM4NFNDa0xLRU01VUgyRnFZdkVXeGI2bE5RTHlNQ21iVGV0?=
 =?utf-8?B?ZTYyUUswRlVxKzdlc2cyOXVaMXBFaktPcmY3NU5pN01QUGIxckdoaG5jS0Vk?=
 =?utf-8?B?Nm1FTWNPeElnZ1RMcGlHdmZVdDByWFdMYmNBVkZLeTRrM05oNzlOZWpubVNi?=
 =?utf-8?B?WnVuRXN6ZEp3ckloYTBVRXdRN0hvRTRnWlBXYm5OZm1iTllGaDJCK3M3aDlC?=
 =?utf-8?B?VGlNL0ROVjRLdHNIY0Q4ZkJrWjBXbjAzZnlnbzBvbmxnK3Vnc3JmbzRJTzFr?=
 =?utf-8?B?ZXgwZXN6VlMvbGVFbjArREZOV3dlTW14RGxGVFVuY29hQVg3TXIxUjVwNzFH?=
 =?utf-8?B?Ukt4UkhVRVdYUytZRG9lZVg2YWJzUElhSkdJWDZYOEY5TXZEYUJIb0tEdDNn?=
 =?utf-8?B?VzBRalkyd0FhZEFFeHVMQ1lqa2V0a3BITnpkMnp6eTh5QzlrTWVEQzBNMUhW?=
 =?utf-8?B?TFcrRmxpeXlKTWN4U1FGeWJ2d2ZFcTZKbGlOclFGZllLZkRmQWRtZnJjR0U5?=
 =?utf-8?B?TDZLZXdUR0lBZUV6OGFYQ08zUDZnZ1FrRTlyNE0rZGpYNXl0cU12bnZBa1or?=
 =?utf-8?B?a2huMm16ZG5zNDc0SzYzZ3hCOGVkeEwwOGhLbTZ0UldSdDBGWjRBVDYyQnFY?=
 =?utf-8?B?UUVYeHgrSnoydEpkRjUwUHJVVis3MUVrWFMxMXpvYzhHbkI2dFp0bUFUZGhr?=
 =?utf-8?B?OFpBSjNBekowSVZ6bTVTMWpSaUFqQ3o1aVNVcVFRZDVpSk5kVVA0WDRkSVVL?=
 =?utf-8?B?SGZFMGZqa0dPQ0RTeE9EY1BXV2RNZG8vd3AxZmpDajk4OU9RN0hKWjQrUHYy?=
 =?utf-8?B?eU54TG03VGYyWk1sU0dweFEza0hQODA4MnpkMnZEbGtCNFg2VCs5ek5QRzIw?=
 =?utf-8?B?ZXh4VUdsM2JqZWIvQlVXN0VpOGw3MHdHUkZib2tuY0RZY21jNkI0Nm14cjhp?=
 =?utf-8?B?L1FSTkxsVmRkaXpZdEJQVmkxanp2dXJoK25FblVQYzI2M1loRDFRUFpUV3JS?=
 =?utf-8?B?VEVEL2hMTE1CTkZhUWVmeW9vSVdrTHNqOGM1eU9zbDFQemVUdmE1cSttbmFJ?=
 =?utf-8?B?aURaV2plLzNUZDA5ajdDbVlESHFHT1FjV3p0c3JEczFGUGsrRklXVVRBMlpF?=
 =?utf-8?B?VlozeDUzRVhMTWszbUJaT2QzZnJnM2NwNGdVcXJDQVF3R1NHbmFtMG1jZ3dq?=
 =?utf-8?B?TkVuNHZOeHk4L3dkTUh6VTBSU3RNTDg1cTYxWTlqc0RCOWw5dFFoNVlBOXRE?=
 =?utf-8?Q?Ri+S9pWfCvaw55MldSkiBAwiX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02c8ca2-921c-4203-f9f7-08dbc44dacce
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 20:16:49.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyOb0VXmzzp2ucnJJ1jACjWONoA5adRTv2458ADkJIAHJCmA6yeb/KJPJ3Knblu0ZhS6UywEt38K8hiDOvvlIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/3/2023 15:00, Lukas Wunner wrote:
> On Mon, Oct 02, 2023 at 01:09:06PM -0500, Mario Limonciello wrote:
>> Iain reports that USB devices can't be used to wake a Lenovo Z13 from
>> suspend.  This occurs because on some AMD platforms, even though the Root
>> Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
>> messages and generate wakeup interrupts from those states when amd-pmc has
>> put the platform in a hardware sleep state.
>>
>> Iain reported this on an AMD Rembrandt platform, but it also affects
>> Phoenix SoCs.  On Iain's system, a USB4 router below the affected Root Port
>> generates the PME. To avoid this issue, disable D3 for the root port
>> associated with USB4 controllers at suspend time.
> [...]
>> +static void quirk_disable_rp_d3cold_suspend(struct pci_dev *dev)
>> +{
>> +	struct pci_dev *rp;
>> +
>> +	/*
>> +	 * PM_SUSPEND_ON means we're doing runtime suspend, which means
>> +	 * amd-pmc will not be involved so PMEs during D3 work as advertised.
>> +	 *
>> +	 * The PMEs *do* work if amd-pmc doesn't put the SoC in the hardware
>> +	 * sleep state, but we assume amd-pmc is always present.
>> +	 */
>> +	if (pm_suspend_target_state == PM_SUSPEND_ON)
>> +		return;
>> +
>> +	rp = pcie_find_root_port(dev);
>> +	pci_d3cold_disable(rp);
>> +	dev_info_once(&rp->dev, "quirk: disabling D3cold for suspend\n");
>> +}
> 
> I think you mentioned in an earlier version of the patch that the
> USB controller could in theory be built into a Thunderbolt-attached
> device and that you wouldn't want to apply the quirk in that case.

It's not necessary with this approach of detecting the PCI IDs used for 
USB4 controllers in Rembrandt and Phoenix.  Those would not be used in 
any hypothetical discrete device.

> 
> Yet this patch doesn't seem to check for that possibility.
> 
> I guess in the affected systems, the USB controller is directly
> below the Root Port.  

Yes

> The pcie_find_root_port() function you're
> using here will walk up the hierarchy until it finds the Root Port,
> i.e. it's specifically for the case where there are switches between
> the USB controller and Root Port (which I think you want to exclude).
> I would have expected that you just call pci_upstream_bridge(dev) once
> and check whether the returned device is a PCI_EXP_TYPE_ROOT_PORT.
> 

Is there an advantage to using pci_upstream_bridge() given it's just one 
step up with pcie_find_root_port()?

> I'm also wondering why you're not invoking pci_d3cold_disable() with
> the USB controller's device (instead of the Root Port).  Setting
> no_d3cold on the USB controller should force all upstream bridges
> into D0.
> 
> Perhaps the reason you're not doing this is because the xhci_hcd driver
> might have called pci_d3cold_disable() as part of a quirk and the
> unconditional pci_d3cold_enable() on resume might clobber that?

That's exactly what I was worried about - what if other callers end up 
using pci_d3cold_disable/pci_d3cold_enable for some reason. We're all 
fighting for the same policy bits.

This being said, I am tending to agree with Bjorn, it's better to just 
clear the PME bits.

