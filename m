Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F837B71B2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 21:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjJCTYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 15:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJCTYg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 15:24:36 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084F79E;
        Tue,  3 Oct 2023 12:24:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOhKSHPB+1E5G/fyEHw5xD7WrgO+P/PTyDWciP5w/BfADw0DSic2+vCef20bAYcwZ2sRQ3mxJLiwOCgiwU+pd0YOfnM9PEat54Me4mxO4gagQyTecZHK/9IBXzTuxd/HxDlHnAIzrv1mhXRr44/dRhiKg40z6Es6MuuAcGYTxo231wB2xuQ08WlY1ae/twCszzHBkQ+Y8y9wXLKm22bFlXZHgJy9sG+QE9CYIvO9+e2hi18fIy0QBzKwkc968Q9OkxhBiPpMmobWVLG2Pj+BSqlfhIhr+E16ysB1Jg4LmBsepM/zb21B3ciPYs8+96PdXmELDgO9Bj33vRRAUEKVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQDIFXYiIxr8PTEgSNWgT+ywsPj7M0jIU2y+/skcqEQ=;
 b=OSjhAfvrVoffKudSyt8uNwLPTwOm5wjvyAqP69JkPFV8XxOuwz39jBlz9iklH/TyHn1u449hgtCBRJ236yaEC8WUFaocTAtoMrcil+NuiP4vttzKBjvCCI8Jp6jieuLNNP6F2RmsOWrzDSz5cc+/X9SsGh63oOR9ALrfJGQ9BkXrOPQ+7yPRagJJMD/dRQqCk0TqPGU2HSLJvHRyQMH88hUTd4gHsmKeK/FXGBMd/rT8CK3suh6UDKtwg9u/lXGfHnJFieSFDhSfPoGEBkGNQVmlYg7kIuPYkRjsVGWyMOnIu4NbkWIzIpE0deIXEJ1B0byLxg/REs4I4HawAF42dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQDIFXYiIxr8PTEgSNWgT+ywsPj7M0jIU2y+/skcqEQ=;
 b=n6JA2zG06nw0+1JqLzldwsPMD/0CSYit5yp1tN+RpqUUUtsx+abiq8AT7T434SO+HXx8J3giJjbjFT8DcSi1bnBwVCK/zDQuN7sWTmEO3r8LzXygjvDo+fZO2FkdR+T+jy2gSAxF42tWpXnGSiIGtptClpx+ZqK6T56FBZmvWAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Tue, 3 Oct
 2023 19:24:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 19:24:28 +0000
Message-ID: <215fbc3b-e7ed-4100-808f-ce5df292039f@amd.com>
Date:   Tue, 3 Oct 2023 14:24:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
References: <20231003191622.GA682654@bhelgaas>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231003191622.GA682654@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:5:177::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f34e601-0ff8-43de-512b-08dbc4465ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyFjI+eueXd3feR0PSqTzXK03XWT+U13M4Mu33M2TiflDIWsrKc+AYP7yzhEnIFpJqfDjVEvi1c1eimqhKWUva4q4fcsDcVHE/LWyVka1Jf0RVYwREKo6ARvnaFM/8c2imQaeaZkCXhxdckCRy8qGlyAcP3fa+1nj5pwg/iqs31csU5SqoS/vzXmvjBVyXTk96Ir5uPP8pNcVqiyB+QkgW664SATbgGCHXi4AmBitBdjrgZnXWqgM+BHtE9kRPpY6vPPynAj5pCCHpSI1mmnBd9wy2q545WL6DyqPDQVdEggUwb40fdoFqbPYZj04a03Vf5cl+DNFmnA0pW5CktVgjz3d56Rlp2NHqzzVwqPbOx5bd9x3h45cnVWp1wxrQRNBUQqUByHZFl6FRGGs1K20BYuupvtV2o4X194K9BFiD/NJdNwNfktwgs41JDf8+tWrIYj4zrM/tlSxLxT5PuD1tMZN5w6H/zTjBy5Y/Y5V0ZDwwIsqVs8SnojRzkJpzztazz8Tl98mpgYqo9kic/T5rKLR3OF5NdYg2t8jN1tC6kROMbhGkbeH6WMPW3MDdZ4o0meckpB3zWnCwuG24Dj+w43WCG3Q1ANGKRC8RFcqGeChXJYcWiy3Jg5SckyJWIHiTuDby5K4HKVrp1fBqIIdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(6506007)(53546011)(6486002)(83380400001)(8676002)(66946007)(6512007)(2616005)(66476007)(15650500001)(26005)(316002)(2906002)(7416002)(41300700001)(4326008)(36756003)(66556008)(5660300002)(6916009)(54906003)(8936002)(44832011)(31696002)(38100700002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlZvL3FhT1hYbnRIQlBLTDg1dXBLc09GdVhjMzdyMU5mRTlSVU1aMlZvNWJq?=
 =?utf-8?B?cm5jS00wQW1tZnRnZ3UzSDFLYlhSUWlpVGNiMEhmaFp1bUE2b2FRM0JBWjRY?=
 =?utf-8?B?Z20wNCtCN2VYSld3Z3FTUmp5UmpZcmRvRDNURkp2eXhMQ1JJZHJ2a2k4TFJU?=
 =?utf-8?B?YWYzVW1tRnU1S2tkdjFzUktlQjZXNFJDaEU3S3dIVXVUYmd1K0hyV1ZSMklu?=
 =?utf-8?B?TDc2NU9wMWUrTXhyMm5XcTZNbytBbDlQNnFMcFFGaXN2citOMmQ1bkphMzBU?=
 =?utf-8?B?MHdMK0F6czAya28vVnQzeFhWUjRLQjliZlFEQXQ0ZHFkTDB3Z0c1VzBHeWpW?=
 =?utf-8?B?VlhLMVlmWkxKbnNYR0t3MkxzMzdkdUk4eWt4dGNWdG5ZYlR3bXh4MlBJN0Vy?=
 =?utf-8?B?VG5DeU4wZy9tWU9Hdk9BZHlhSGRtYkQ5QWJyRGZFMVhiR0xHRGN5bXhwMzg3?=
 =?utf-8?B?SEtXTGZ4bjNFUjlOTWZ5RWZtOGVqZGRlSmNiSDY5Zlk2ZXFka0YrWGttWjFa?=
 =?utf-8?B?enJOUCtza1I4bWVlNEdaaS85UHo2STNPRm1neVUzMi9wVk00dk9OM3dsVm0z?=
 =?utf-8?B?aXZKMWxBSTRqREdtUzZha0JmOGFYaktqaldkWFMxOXVRQzd6VzlhV0RCSEpP?=
 =?utf-8?B?SXNGUGw3QWNYbXlzUHNvQmdNM1MrTzNVbmdnZkZrYnlHVmdYSENrMU5CSTB6?=
 =?utf-8?B?QlIyN0s2YnBtSmMwVEhlNzJkWDdYaUdTQU9KdEx4ejcyZDAxc2ROQVJWZXJa?=
 =?utf-8?B?OXF2YUE2Z3ZpbUl3ZFFIK3czSEpxZG9KRTlYNFFHUGIvS3FxOEQzQWZ2VTFW?=
 =?utf-8?B?QkZvRnBDTTg0Y2J3czhSZXJtamRZa3RjRjNRYVR1R0FQcTFBMmJhQXViSml4?=
 =?utf-8?B?TXF1eWo4UUtoYzA2U25LZzdOemlNY2pJaUxEeXRHUkV1a3lrTFpSVGVVWUNN?=
 =?utf-8?B?UHZVN1p2OWJFQVZwbVlKdVZJNm5HRE9KTlNMSTFyKy9Zc2krZXpjcnh3c0xq?=
 =?utf-8?B?TlNDdU9UckQ5eHV1d0VUL1lJK25wY3U2VkppRjFVODd1akt6SDQyYnlNMXBq?=
 =?utf-8?B?aGtKUmlmOGJhY2xnMjVGWTBiMTdPNDM5dU9JQ05LR2l5VzdqN0dUbTFZbC9n?=
 =?utf-8?B?ZVlCb2dzQ2t0R3UxVElGMWE2eHdXSU9xdVBkSnR4ZW5uOHFhZWEyWWIwMHJn?=
 =?utf-8?B?dVBMaFFSUXN6ZUU1VDhXNUl2N3F4UUVRNnYvZU1Oem9ZVTN2T0xkcFoyUklu?=
 =?utf-8?B?YXVVRW1Tb3QxVlFqMkJudmxudnlTYW16ajNRemhvRHJRVCtLeU5GTng4TDM3?=
 =?utf-8?B?NEZzaDN0THg1azJlMGlyUTEvN1ZqcWdUeW52UXhzbVhSdU5ZdzNXcnpGcjRr?=
 =?utf-8?B?UFhJcS9WUDUzU08wMk03aC90RjJ2VGx5MGxKaTZLQlFRNGIwZTBoUVVrWEJt?=
 =?utf-8?B?Qm1qbTRtWU5EcHZ0NzBCdnJ4TFlSUU81Nk5ON3pmdjlhYUNKcTlsSVg2RTZh?=
 =?utf-8?B?bjRUSk82RkpCeVEvSXI5VmpIWXhrei9CVVp0ZG5nMXAyVWdhaGplZldabnc5?=
 =?utf-8?B?c1lyUjFQL3pYdmFtZ1o3bkZCQjNQQ05tMkVQNVB2cTFnUDEyajdVakxBTEg5?=
 =?utf-8?B?Q1NOUEFUMng4b2VaK1BiL2pzdDY5NWlUM1JBS1h0Z1NrUmhENEFMcFBoZ1pW?=
 =?utf-8?B?bUVnYXR2WkJta1hHTExuR1M0bHY4SzVWeXFOY0ZkNjd1WVltandoeWdIWjFV?=
 =?utf-8?B?V0t5eE9raW1wZDB2b3NVd3NzaWVUSmlCWXdzY01BK2xrUklrbVZZUU9lb0Mw?=
 =?utf-8?B?YWQ0VzJ4alFSQkU3ZmpLdmw1ZjlZOTB1dzFYRTZ5WlRFWkUzdHpXRi9yMVBx?=
 =?utf-8?B?Y1VRdkVXbUVmdFNDeStCdGVPYzRsejJHZWFjN1lRMEo2YmU1b3Y3T09LUjNH?=
 =?utf-8?B?YmsyOEFXVEdCUmJJbnNSZS80OS9HcGJtUURUNUMzRjRyYnB0OUFpYkVNZDdw?=
 =?utf-8?B?VWNJN3ZPMEwySjJVZ1BlL0JDTDdrNVBjUHF1NERrQkx6NFRwOUpsanMyYU5Q?=
 =?utf-8?B?Tzl6TFJXUzJ1NEVKOXFCQlU4MS9MR1pZTkVQMHhXdFNRMjVlaWlCRUJJM1FM?=
 =?utf-8?Q?s9n5poC6WACPxayGTvyZxvKAS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f34e601-0ff8-43de-512b-08dbc4465ccf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 19:24:28.8106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqIg7zhbwlU8AtVTzcjJ0hyHfLFg1CGztAfKdhkK3I53pb821LY7Qw9eOFQAwctfEhSwEr8Sj5jULPe4t33XMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/3/2023 14:16, Bjorn Helgaas wrote:
> On Tue, Oct 03, 2023 at 01:37:34PM -0500, Mario Limonciello wrote:
>> On 10/3/2023 13:31, Bjorn Helgaas wrote:
>>> On Tue, Oct 03, 2023 at 01:06:48PM -0500, Mario Limonciello wrote:
>>>> On 10/3/2023 12:24, Bjorn Helgaas wrote:
>>>>> On Mon, Oct 02, 2023 at 01:09:06PM -0500, Mario Limonciello wrote:
>>>>>> Iain reports that USB devices can't be used to wake a Lenovo Z13 from
>>>>>> suspend.  This occurs because on some AMD platforms, even though the Root
>>>>>> Ports advertise PME_Support for D3hot and D3cold, they don't handle PME
>>>>>> messages and generate wakeup interrupts from those states when amd-pmc has
>>>>>> put the platform in a hardware sleep state.
>>>>> ...
>>>
>>>>> Two questions:
>>>>>
>>>>>      - PME also doesn't work in D3hot, right?
>>>>
>>>> Right.
>>>>
>>>> IMO pci_d3cold_*() is poorly named.
>>>> It's going to prevent D3 on the bridge.
>>>
>>> I agree, that name is super irritating.  I don't even know how to
>>> figure out or verify that pci_d3cold_disable() also disables D3hot.
>>>
>>>>>      - Is it OK to use D3hot and D3cold if we don't have a wakeup device
>>>>>        below the Root Port?  I assume that scenario is possible?
>>>>
>>>> Yes; it's "fine to do that" if there is no wakeup device below the
>>>> root port.
>>>>
>>>> If a user intentionally turns off power/wakeup for the child devices
>>>> (which as said before was USB4 and XHCI PCIe devices) then wakeup
>>>> won't be set.
>>>>
>>>> So in this case as the quirk is implemented I expect the root port
>>>> will be left in D0 even if a user intentionally turns off
>>>> power/wakeup for the USB4 and XHCI devices.
>>>
>>> Even if users don't intentionally turn off wakeup, there are devices
>>> like mass storage and NICs without wake-on-LAN that don't require
>>> wakeup.
>>>
>>> I assume that if there's no downstream device that needs wakeup, this
>>> quirk means we will keep the Root Port in D0 even though we could
>>> safely put it in D3hot or D3cold.
>>
>> Yes that matches my expectation as well.
>>
>>> That's one thing I liked about the v20 iteration -- instead of
>>> pci_d3cold_disable(), we changed dev->pme_support, which should mean
>>> that we only avoid D3hot/D3cold if we need PMEs while in those states,
>>> so I assumed that we *could* use D3 when we don't need the wakeups.
>>
>> If you think it's worth spinning again for this optimization I think a
>> device_may_wakeup() check on the root port can achieve the same result as
>> the v20 PME solution did, but without the walking of a tree in the quirk.
> 
> Why would we use device_may_wakeup() here?  That seems like too much
> assumption about the suspend path,

Because that's what pci_target_state() passes as well to determine if a 
wakeup is needed.

> and we already have the Root Port
> pci_dev, so rp->pme_support is available.  What about something like
> this:
> 

It includes the round trip to config space which Lukas called out as 
negative previously but it should work.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..4b601b1c0830 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6188,3 +6188,60 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
> +
> +#ifdef CONFIG_SUSPEND
> +/*
> + * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
> + * if the SoC is put into a hardware sleep state by the amd-pmc driver, the
> + * Root Ports don't generate wakeup interrupts for USB devices.
> + *
> + * When suspending, remove D3hot and D3cold from the PME_Support advertised
> + * by the Root Port so we don't use those states if we're expecting wakeup
> + * interrupts.  Restore the advertised PME_Support when resuming.
> + */
> +static void amd_rp_pme_suspend(struct pci_dev *dev)
> +{
> +	struct pci_dev *rp;
> +
> +	/*
> +	 * PM_SUSPEND_ON means we're doing runtime suspend, which means
> +	 * amd-pmc will not be involved so PMEs during D3 work as advertised.
> +	 *
> +	 * The PMEs *do* work if amd-pmc doesn't put the SoC in the hardware
> +	 * sleep state, but we assume amd-pmc is always present.
> +	 */
> +	if (pm_suspend_target_state == PM_SUSPEND_ON)
> +		return;
> +
> +	rp = pcie_find_root_port(dev);
> +	if (!rp->pm_cap)
> +		return;
> +
> +	rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
> +				    PCI_PM_CAP_PME_SHIFT);
> +	dev_info_once(&rp->dev, "quirk: disabling D3cold for suspend\n");
> +}
> +
> +static void amd_rp_pme_resume(struct pci_dev *dev)
> +{
> +	struct pci_dev *rp;
> +	u16 pmc;
> +
> +	rp = pcie_find_root_port(dev);
> +	if (!rp->pm_cap)
> +		return;
> +
> +	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
> +	rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
> +}
> +/* Rembrandt (yellow_carp) */
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162e, amd_rp_pme_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162e, amd_rp_pme_resume);
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x162f, amd_rp_pme_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x162f, amd_rp_pme_resume);
> +/* Phoenix (pink_sardine) */
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1668, amd_rp_pme_resume);
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_suspend);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1669, amd_rp_pme_resume);
> +#endif /* CONFIG_SUSPEND */

