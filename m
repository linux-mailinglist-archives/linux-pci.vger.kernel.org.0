Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB6779F9B1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 06:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjINE7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 00:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbjINE7M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 00:59:12 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456FB1BCA;
        Wed, 13 Sep 2023 21:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STGtIcLNZ0Ut7disxN1dLkYDx9LBm8C/ZCVuEajhwc8yaiK6hCj7Z2Xa997EUbQXpgoG3Sfdrth5eLD01F4nBmpN+1oODf8WVN31HdSMtC/a/oIjmopktbHlbViQWZirkTqtX1oJpisSgBTM1d1L3L3yFS3CI2Bob2lkftex63I4Us7LBdATXeip16hRz0URBY9LbnLl/Ne8kN3k0Fp011zel7CCzoKWGTe4N+qL/gMW5GwKovl4qJsqSzVhzXh38e7pguwTPSgVsOR8IjaRDBgU3HfA+C5sA9BqUr/jMo6IhahaerVApZ2VrdpcJZK9gDb5wuDgIiTKsOCkHJxLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1xN1jqPPca/wNnha+ycdzioh2bf9pSwuB49S1gVMI4=;
 b=lcloX7BtSYjuSmhHDMRmWveBjx8kMhi6FEjraT+lmNIOjPa/Tv1xXLqUN/XYerSbFP9tv9pSYbrK6bk0TE8+XNeqcaCCQRooA895GCrZ4k3x9+WFbZ9p5L/jWHbF1KVMya5DG5kI7W391SsPTuPLyKR83M0gk2DQHXz9Is+8UBBFmMGDU9rEUiuSGN9Q4RoRktP/vxd75SDKLJYLNK7vZ1laxd4t6RJlWzf+R9mL17autTRUHoKJSzF4449sM0ZMlLBSpwTsOdLWXMgV9BGVywJqCnQceZXbrAunvs2YyHTDAAvJFidRto6PSpCWTeTN1tYi/ekpNO8C1fYL+PC1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1xN1jqPPca/wNnha+ycdzioh2bf9pSwuB49S1gVMI4=;
 b=jbncDjNDeC0FkPXyPnKCi1gbOQyA3NaVlSy4a/zY4kIrVT5JDg3cgKDoprMD+BzbdtPIkIBQyTedZZoZvmrcV69k904ZNxW3Qc/uAqAzBFyiSVDOW8nf9GbCKTuP7zvEVtFrRXYHxXhZZ6vp95mkwy7Au7P17YU/EUCHetpVRMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 04:59:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 04:59:05 +0000
Message-ID: <75e5175e-406e-41dd-90c7-3dc30741897e@amd.com>
Date:   Wed, 13 Sep 2023 23:59:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk
References: <20230913210543.GA440503@bhelgaas>
 <001d9c72-49df-4a8d-a9bd-10311887c60d@amd.com>
Content-Language: en-US
In-Reply-To: <001d9c72-49df-4a8d-a9bd-10311887c60d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:806:f2::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b93305-1f76-457f-cf93-08dbb4df51d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pivnjlCCr3n4hmmCHgPq3C4Kz7umZNObLPV8IopOpd6QOlZ3nzZvuD1TtQ5TcV5GW0IjMaAEYDP2oP4lUH4NuC+WsWs94xL4cylxZezAl8FoWvQY3rmXS7QVOgYvY482bvkqXhL/TJsLtP0doUPrcyeMAbMM7XUtQ6fYyp7eG4F+Lw9LPEbbXlsX+CtM9RI4JG3Puh2WksC2y3P2ANHyJNsWnzesucV80C1eLDcdtYADLQ82mXl30Vuuv+LNkgcVaDaQKWHwRjqtJdTJXzk788zVSzCKXf591I4IZsln2G0YHvtVw4ltn8++vP570tKkb23PCyyImuGLqNgjh8/E5B3gWZwKp7JHsq3IhUeQej7CPi0GszD2h4U/H4Fcnv9IO6zhdrI2JuRxSndQKLcNtjph2dRi9tiDQCHE8IfC52iFOSBDJCyGpJZooLNpe4emgLeduwvH2SsEDG3i1uuzD7oXjb+yo5LoyVLz2wZoVjRcqi8+HYybo0RFJS9lP6F3BC5lafJRCMZkAoAEZxGdeA35wuMr4BETdVifmkwWC8nQFd3l8W/4FFTpMP5KY1leQChybW7+cCzlzZ8D0ZmrZHiHf1FfEo6mTQbRBKmNTIZjq1g+0woayg7QFD3bRcWdpB8f1ws3MAwxD7r8ddUkCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(186009)(1800799009)(451199024)(2906002)(86362001)(31696002)(53546011)(26005)(2616005)(36756003)(478600001)(6506007)(6486002)(6666004)(6512007)(83380400001)(38100700002)(7416002)(41300700001)(31686004)(8936002)(8676002)(4326008)(5660300002)(54906003)(316002)(110136005)(66476007)(66946007)(66556008)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkJldUdGTGhyVnJwYnl2U0ZvK041QXJUYnNiTDgyL21IU0RUSEFsWnVFOFE5?=
 =?utf-8?B?UUJib08wcUZad0FtMlhZQ3YyM2xNTGc2TlpiM0JqdmhiNkRZUHQ2ekY2SHFN?=
 =?utf-8?B?cWR2OTdtVncxWFlNM0pQZ0hMNm1yZXh3clhNbm1yaFJxZDVQY1k3bnY0SkJj?=
 =?utf-8?B?RGJUZmlpK3ZkZVdYaGhGQ3hFNmwvKzJQY2QrVGJ2Z21zSkp2SnFndUlSTEJp?=
 =?utf-8?B?a0g1TVYzdFlsTHlOSjFrTE14NUYzUnp0Yit3VXVncWxabDY1WVh6aEVEZGlY?=
 =?utf-8?B?cjJpcE1YQldMUTJVY0tqS3U0b3F5eFY3bFB4dTVJNzljSnRoTndCMkRMNS85?=
 =?utf-8?B?aGxtTE9sRDNtcURRVUQyc21jVUZEUng0b3IxSGZkQWxuL0lzeDBmVTZidTE5?=
 =?utf-8?B?cmhPclNES01rLzRHZUx2dEVHL0xOaXZjQ3ZDemxUdklVWTFXYUE4UXRiTEkx?=
 =?utf-8?B?QkZLOWZVQmg3VHoybFdyZERlaWhGS01lekx0aTZrTG9IQVVJQXpIVlBvYXFQ?=
 =?utf-8?B?RHN5RmlXMThsRzlrOUk2N0VFaTR4OG5pTC9YenBzeDhURG5tSmc4Qm4xUlVI?=
 =?utf-8?B?Ri81ek5JMXQ5MHZuVDZ4VEtubkh1bkNXVUdSdTBRd2NjVGZqYzl4R3pQcVlC?=
 =?utf-8?B?azZvZTNMZVV0K0RGN0FScUhoeFpWKzFVSFJ2UjJzVkdrck1HOXI1MHpOdHdT?=
 =?utf-8?B?MU12RWgrVUFCNEdMRGkyOVg5QVNrcTNRWUYyVFpZclJuQUNuN1BidGZSWXhh?=
 =?utf-8?B?RUVkM3dlMWJOS3h0Z3pDZ1ZPdGZzaTFhQXMyT1E3b3lvNDFpNjM2dGM4NDcw?=
 =?utf-8?B?Z0VRY0hvdDgvQ0hBSG5UeTI5ejVYQW5vMEhJaG9oTlVnS0l4MU10NnlwTVFZ?=
 =?utf-8?B?VmpnWG1hUno0d3RVQ2tOVmRFQU4yUFV5VVp2RGdNVHpBNk81U0VKWitSUVdK?=
 =?utf-8?B?RU11WXJFY1pjWXkxNFZLbnlaNUNaVEVFSnlEbDBxYWd1TWdlTkNuTE1JOUxt?=
 =?utf-8?B?KzdBTEZEa0lmUFN3TzJUR1hPY2RQUjJybXlOOSt1aVR5Z3lINzVhL0FUMjg1?=
 =?utf-8?B?MUFPejk2SXV1WXBrYlRNYTFxcm5JMHk4Z1pyZ1g3NFBMci9BUEJubUgybW1y?=
 =?utf-8?B?cFBoZllNUjM1V3ZiQ3Bmb0JIa1ZvM3ZGMEV3aGY2bFFBc0g4RC9aT1JCVnJ2?=
 =?utf-8?B?OWl4TVhDekpObEd1ckNNandKRG8xdU1EdG5YZ2E1MVR0VXZmcExPQlp5NjN6?=
 =?utf-8?B?VFBacklsZ1dvcHA5ZHN5K1RyWFZ1VTdZaiszcXg3MUE5U1BGNnBSS3ZpSXlu?=
 =?utf-8?B?aUFBQURiSnBCdWNDYWlPVmRyZUZjL08za0p2UXdXV3VTdEZEbGNmUzlLQU1O?=
 =?utf-8?B?Q1p6T2lCRjB1amRBSDk2Q29UNW5oNWpKcjgxSnNGQjdZbS9lS2hwcDNhSE0z?=
 =?utf-8?B?bXR2cWdTb0ZpZ2dOWnAwVlZCY1FsY2pGbE8zWHhaSEsxN0JoOTVvZW51bEtk?=
 =?utf-8?B?d1pleTlqbFcvTjU1YUZnb3pra3BRVVo2QWwvQlpoVklEem13eEIxckVicU9u?=
 =?utf-8?B?NkFNdlQzaERZZzRITXZ0RjJQZ0g2STl2N3Fwa1hYRSt5d1p0UTZTczdHQ0VB?=
 =?utf-8?B?R2pSbk5FNWhmMDZBMDU2RGEra3QrS1VUMTdHZHZIK1JFK04yd3dseEsrTUw4?=
 =?utf-8?B?SWhNdlBWdDF4RVpOWnFhWXVMSEhDdmNadUVhVlRsMTR1d05COWVPbnlaSHpF?=
 =?utf-8?B?ZjdTMUlXbWdPTjhVWXNBaXZrWkF2MzFMU1ZKcEMwVUJjNG95alJEN1diYWpG?=
 =?utf-8?B?Vk9TbXVLdVppeTNVaXZ2VkJ5cHlXN1ZlZkFRdVgyNXBITzVyY1UvUHhtbkVG?=
 =?utf-8?B?K2d6M2l6VzZUUy9OMkdrcURiamJjS3pKRXFWNnpkRGg1alZBR2tUZzJZMnA1?=
 =?utf-8?B?RFRuMnRidUQxUkYrVW9QUTBOVzRVa001OGRWYnNITU5jd2swcWVZZGM3WDJ0?=
 =?utf-8?B?WmY4akQzajVPRWErNUZWM09NSDRBYW5sRUJ1NWhRdStpZ2tUUm9uTVVVZXNU?=
 =?utf-8?B?UmJub04vZ1hWd2FmT0VOV0p6RGVIZjZwLzlpYlNQWTZESWVraFpjcmFyZ2hk?=
 =?utf-8?Q?loceccrRe6kLey+FoXvXNo4aD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b93305-1f76-457f-cf93-08dbb4df51d8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 04:59:04.8723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nsar/gf3pHxlED6mtShC+x3zMlzHYVoUSo7m1qX671hxVjBplRpaQX6eTLH48TtiZ1E3yrB4flbtI73Hp+RxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/13/2023 16:16, Mario Limonciello wrote:
> On 9/13/2023 16:05, Bjorn Helgaas wrote:
> [cut]
>>>> I expect it to be an ongoing issue.  I also expect unless we use
>>>> constraints or convince the firmware team to add a _S0W object with a
>>>> value of "0" for the sake of Linux that we will be adding IDs every 
>>>> year
>>>> to wherever this lands as we reproduce it on newer SoCs.
>>>
>>> So maybe the way to go is to make the AMD PMC driver set a flag for
>>> Root Ports on suspend or similar.
>>
>> I like the quirk approach.  When PMC is involved, the device behavior
>> doesn't conform to what it advertised via PME_Support.
>>
>> The v18 quirk isn't connected to PMC at all, so IIUC it avoids
>> D3hot/D3cold unnecessarily when amd/pmc is not loaded.
>>
> 
> Technically someone could; but realistically no one will be using these 
> machines without amd-pmc.
> 
> The battery life over suspend would be abhorrent.
> 
>> I don't object to avoiding D3hot/D3cold unconditionally.  Presumably
>> we *could* save a little power by using them when amd/pci isn't
>> loaded, but amd/pci would have to iterate through all PCI devices when
>> it loads, save previous state, do the quirk, and then restore the
>> previous state on module unload.  And it would have to use notifiers
>> or assume no Root Port hotplug.  All sounds kind of complicated.
>>
> 
> Yeah this does sound needlessly complicated.
> 
>> Maybe it would even be enough to just clear dev->pme_support so we
>> know wakeups don't work.  It would be a pretty big benefit if we
>> didn't have to add another bit and complicate pci_prepare_to_sleep()
>> or pci_target_state().
>>
> 
> I don't think clearing PME support entirely is going to help.  The 
> reason is that pci_target_state() will fall back to PCI_D3hot when 
> dev->pme_support is fully cleared.
> 
> I think that clearing *just the bits* for D3hot and D3cold in PME 
> support should work though.  I'll test this.

I did confirm this works properly.

> 
> Assuming it works how about if we put the quirk to clear the 
> D3hot/D3cold PME support bit in drivers/platform/x86/amd/pmc/pmc-quirks.c?
> 
> It's still a quirk file and it makes it very clear that this behavior is 
> caused by what amd-pmc does.

I've got it coded up like this and working, so please let me know if 
this approach is amenable and I'll drop an updated version.

If you would prefer it to be in pci/quirks.c I believe I can do either.
