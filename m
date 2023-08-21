Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4377878317F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 21:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjHUTTG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 15:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHUTTF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 15:19:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EED19E;
        Mon, 21 Aug 2023 12:18:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofcj60vK8JiLGRc5p+Sg/FecObJdVGIeC6uWLbWRV5ba8GW6Prryz7d5XBU8szdfu++Wxs6PALXuiwceMrREAVdFcFkf0lgazHItulw/OwV994WPPpkBaDNL00DTaW7Re6nMhN4zpkUQImo1mWyMpah3xM8GLU9vePrrn3xLmDFcsoplQ+4yXvzuRLebawkAqf4m9zgBKACwnkLwYLPtPyu+VyIhoqgjnm4SsudG4k3q6TjnrJ83aQSmBu96r11z7+ky4Om6kJk5R9xBMZMeM0n370KfghYVC2/YvvycMK/Gmo7wNyHHrKweWnIddth7DuHaMF1H5qoxjVaTAtMzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wwxnrNzukeesJdvPUaQvQ6CY6oIJMHWaxWAV8/EuZQ=;
 b=AQJXGK9lkIPNmh5Hept8OGj0J113hBrmbhLncRM55arYzYOa/G5qCPO0Ps/kYKSm+lKYEN+jKdbZfD2I02tuPacFvxxyg8IR4PfbPIuGwSC36BZZ1a8cGmQb5ZrSSM2sxn0jTLhrUu0UXQSmfTHBazDloYUl5G10YTi6qpnyKCwbxr92FDsgCtISebP9wQI4dcE8hZleUgUM59aWDD9FRBeOk+4EDtBLNRGH449qnC3vKJN4x69gSMNndn8hxldvfPOBwbywHMvtevDFuUlnlnZYfMKjCwy5ntO2axWBCEIyPDSQsa17LXqqiIB6s4YLOQgIr8lwhd97Qf3wxKF8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wwxnrNzukeesJdvPUaQvQ6CY6oIJMHWaxWAV8/EuZQ=;
 b=mgrlWhIPwUUIEPbVbPj1R8QeIaE9apjZxMgGbUBcpaX6h2tH5/qRC3hQx/P0awdLILeYysaJO9SuIvY0gJacdfsI2sRgcq6TFRODLPjjNFLYb3dC4hOcKpQt6f7SX6m0KVffyc9U1QEBcnbqtM6X0k8s0GrGdV/+18bWL29+QkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 19:18:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 19:18:07 +0000
Message-ID: <2bec7ee5-2ead-4c46-b6eb-f4d7a2249293@amd.com>
Date:   Mon, 21 Aug 2023 14:18:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14.c 4/4] PCI: ACPI: Limit the Intel specific opt-in to
 D3 to 2024
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20230818194027.27559-1-mario.limonciello@amd.com>
 <20230818194027.27559-5-mario.limonciello@amd.com>
 <CAJZ5v0j_tmW1uWZF7ShK=fwnVGjjy8CSf7DJErJdSaD_dgW8WQ@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0j_tmW1uWZF7ShK=fwnVGjjy8CSf7DJErJdSaD_dgW8WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 75810004-3d18-4b17-ea9f-08dba27b59d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6ASrmHpTxTkL03gINI4gP66rQ2DFv7UhvpvCFRwKijCFXDADPHvkaKw46ZFDrw4AG2XCrCcElD5Rtnwjc/3gxlUgs3w934x/TiXbKWRYAcaXRFTP2lGhfSUGyJoOzpvypZJLbGDnQaueYpGxC2udrqEC36zbAOC5ka+fhWD1lgkUG1kcbrlT0NO7ZpAQrnRSRfNiXvp7jS4yXYjRjbjemDI41wJE9iRiB3w4zhn2Nz/1aSyV8/wQ/Y3zNg75hjiVExXSKMaOPobV+xiB4An7zQGReKoejcZtXYM50s/x98Sc2YPCsrczJ/1xcCVdNvCeP6OKA92YK1RcvLKFTl3NTWqGn0+9gFmjbM4HUEkojnfmRpmFNl+YwUhULZyajVst60s5sC9fLjXDuxKCIz4Wjj1tovuhlj12aJcfFtrIZZSX+nnUqnfhPZNnh+tTKXivUcd6B/qUCt5ukxOO8+BHvlLyTRhhfQHlFd/vMudPB5DFIWTx65WcTvuTUjrGSIaOScJdBeRyLdJdTNtO4pDWUlfLLz8yku1DpRjVQbUJIrAtGkAaSUvLlV3wry4qKG8D9Wd5muaPSP9Lggns512o833j3nnnttsVnFCpsHOixPRZp1UalpiJCvMkETq2BtM64pkp1T4+DaAmZznqaIGFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199024)(1800799009)(186009)(86362001)(5660300002)(2616005)(41300700001)(66556008)(66476007)(316002)(2906002)(66946007)(6916009)(54906003)(31686004)(8676002)(478600001)(4326008)(8936002)(31696002)(6666004)(6486002)(53546011)(6506007)(38100700002)(6512007)(26005)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDF4T1pXZW5XZTFJQkd2Nm9rODlvUkZCK3RCY1JwcVBnQjhQTDlDTy83M0g0?=
 =?utf-8?B?UDVDWnUyNVFDWmVnVklLZUNzUVpabWtCK2w2R3VNRXJlTGVaZkI2RWN4cUl0?=
 =?utf-8?B?ZGpTbm8ybEM0c0VFamMweFVjcGwrSm9rUC96TEU5aEdOQ1l0akExZkluckxw?=
 =?utf-8?B?WmpOTGkwQ1J0Njh1d284bS9QS05MLzdSN1VCWXUzQzJaQnVXU1lmSmhpQ1Qw?=
 =?utf-8?B?MWpqR0hpUWpkQWRFNy9kV0JGdUtCYUc1a3dnZ0prTGlrcDFtbXJxcXpTRXh6?=
 =?utf-8?B?aTF0aEpoU1htZXlDN0FocWt4b0N5RGdnSGlHSmhramdGL3FXQ2o5bEtXYzNz?=
 =?utf-8?B?V2I1Ky9MYmF0amxvV2JKREFEMXRXdE13NGswQ3puMGcrbkM4UnFuWVl6YVkw?=
 =?utf-8?B?TnQ0UEIwSkNuY0xad1I3czUrMkJPbm5STkR4d0drUkVUYlpTa3RkKzlPbGtO?=
 =?utf-8?B?Rk1KdzFxODBSUUlleGpWR3B6R21RVXROZkpMVjRWK3NSU3JtVW4vSGFKRHlI?=
 =?utf-8?B?c0JlUXBsMFMzYmhrbTVNMUpURWJuTkREckhpbmtaWFRBQW9yNXlkNVdvVFcv?=
 =?utf-8?B?QTFuVlI1ZlM3RkxNOUFWYTI0K3FrNkFVMEFaNHpTRWdqTGVyR1NDUFd1WGpU?=
 =?utf-8?B?REhJa3R6eERJQjlSckh0UEhGZkp3UWliN3IwL1ViTXl3Z1AwT3NOYUxjZmMv?=
 =?utf-8?B?Y1QyQVdpajFXZ2VMRVVoUUgzeDBSTXprWUlHRHMvdTg4RGtTeHhMTGhxUW41?=
 =?utf-8?B?cTcxR2R5cW9RSWRxZ0pzQXJuRG15dnNpVWFVQ0tjVTl4THRjT1pxTGpSZEFE?=
 =?utf-8?B?bW5mcTl4OFlicDFLU1Y2aUJESEgzZEFSWkdoL28rMlNJTG1sVzdLZWhzU05C?=
 =?utf-8?B?NHR5azZIZG1zbVlEenQ5dmMxWG9ISktIRWhHOG0yQXhvT3pSWkVwTWR6cDhm?=
 =?utf-8?B?U0dNWGdJMmxwYnNRL2tNVnp4OU1mOHh4Rk1tRXV0Wm1pUWMwV2NOQVF6NXBi?=
 =?utf-8?B?QzkvV2lpaG1LbytRTnk5RC9qTWhQRjJScG1zd25UN2gwS0lueDRIL3dTQkth?=
 =?utf-8?B?M3g5cTJDTWMreEF6aVlCeklSQjgzYjd3aW9sdTltaTI3QmZ4eVF4VVptQzll?=
 =?utf-8?B?UWpHL3psak15T2tBS2RqSEdjRitCMlBLUjFqN2k1a3pONTFhUnBaMnd4TjVi?=
 =?utf-8?B?YStNMGFRUzhDQnJtQlI0QVlkdVFXUm5RazhGOFlBTzBzWVJqaVJlZm1iS3lB?=
 =?utf-8?B?ZzVKcy9Kc2lHT1Z6clJjYjdGYWVCKzBEVWFHVjhaMzV0TDFwSU9BN2xraW9K?=
 =?utf-8?B?VWZEN3ZBSjJDN2Q5SFpLOG5Eekh0bU1FdUZyTm5Ockp0RmF2NUdNT05obFlI?=
 =?utf-8?B?MlQ5bzF3R01BRGplOFNHOHZISE1sQ051VDlMTWdSSWg3YmZFY1MrQloydk8v?=
 =?utf-8?B?L1ZJd0JQZUg0UzN5b1BMNC9TdW44d0RreTRBdWYxNzZxdW5TT3NVdFRqNUMr?=
 =?utf-8?B?ZjZDRlZ2NmVQTldwVG9sM1MxWTB5dHZxbXQwSE1Gc0VvL002SEhpamlickRk?=
 =?utf-8?B?MmtKd2xJRGJQL0pwRWpJY21kSTBhY3RMOTI3UmNTbDdTYnlva1Y0N1FGTHpU?=
 =?utf-8?B?aXpFL2lnb2p4TzdDeTZJZlBWNDU3aVRIUkJmVlJ1amlXU0VFZEp4bTZHekV5?=
 =?utf-8?B?R0xiR3ZVYnBTOFFJTE96ZVl3eUhKeGc2Q1R2YlNoVFRUSzlwK3dENStiRU9L?=
 =?utf-8?B?NkJvY2ZtMU56VjE1cE5LTTc3M0RvSEQzeUZ4T3FBQjd6bU14Smt5R0ZWYW9V?=
 =?utf-8?B?TDV5VXZwVUc3cDBFTUdFRmUzbllTbjNGQkVlUDlzdEhPMDF5N3FGUGtHd013?=
 =?utf-8?B?dm4vUEdmZ0Jrc0FkVmxUeFVNQ3o1Q2Y4K0lxK2F0K1pzNHlMK0dZQ255N29M?=
 =?utf-8?B?byt0UzFRbncyaTRIWHpNbTNmdXpCaENLUHFsLzA0VThsaUlLdC9KT3M2U25h?=
 =?utf-8?B?VGltRi9QeURhclRpbitHSzRpR1gwbDQ4TXlaekJJZlFhcHk3R09ua0c4UzFE?=
 =?utf-8?B?ajlJb2c2K3lxdzMzdTdVVURjUzNGNGdnL1NyWklIc2NJb09RM2FEUHpHZWI1?=
 =?utf-8?Q?JFgPz1qFvqeRwwvBjWejQWQBG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75810004-3d18-4b17-ea9f-08dba27b59d7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:18:07.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JroFqgPT2JUm1z9JvtiRNKe4DPtsfra+OVOY2p/iqwJqxhMB2HH/i8nbp7a9WTn7Kd5S9amHB2iJJ+FqtGATA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/21/2023 1:46 PM, Rafael J. Wysocki wrote:
> On Fri, Aug 18, 2023 at 9:40 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Intel systems that need to have PCIe ports in D3 for low power idle
>> specify this by constraints on the ACPI PNP0D80 device. As this information
>> is queried by acpi_pci_bridge_d3(), limit the DMI BIOS year check to stop
>> at 2024. This will allow future systems to rely on the constraints check
>> and ACPI checks to set up policy like non-Intel systems do.
> 
> So I'm not sure about the value of this change.
> 
> The behavior is made Intel-specific in [14a 1/1] and it will be that
> way at least for some time.  This change only sets the date after
> which it won't be Intel-specific any more, but for what reason
> exactly?
> 
> And why is 2024 the cut-off year (and not 2025, for example)?

No particular reason other than it's a few kernel cycles to get this 
tested and working or revert it if it's a bad idea after all.

> 
> If Intel platforms continue to be OK with putting all PCIe ports into
> D3hot beyond 2024, why restrict the kernel from doing so on them?

OK let me try to explain my thought process.

The reason that root ports were put into D3 on Intel systems was that 
it's required for the system to get into the deepest state.

At the time that it was introduced there wasn't a way for the firmware
to express this desire for root ports that were not power manageable by 
ACPI.

Constraints are a good way to express it, so by limiting the Intel 
hardcode to a number of years gets everyone onto the same codepaths.

But that being said - if you would rather keep Intel as hardcode forever 
this patch can be dropped from the series.

> 
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v13->v14:
>>   * Use a variable instead
>> v12->v13:
>>   * New patch
>> ---
>>   drivers/pci/pci.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index bfdad2eb36d13..c8787d898c377 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3037,16 +3037,22 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>                          return false;
>>
>>                  /*
>> -                * Allow Intel PCIe ports from 2015 onward to go into D3 to
>> +                * Allow Intel PCIe ports from 2015 to 2024 to go into D3 to
>>                   * achieve additional energy conservation on some platforms.
>>                   *
>> +                * Intel systems from 2025 onward that need this are expected
>> +                * to specify this in an LPS0 device constraint instead.
>> +                *
>>                   * This is only set for Intel PCIe ports as it causes problems
>>                   * on both AMD Rembrandt and Phoenix platforms where USB keyboards
>>                   * can not be used to wake the system from suspend.
>>                   */
>> -               if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
>> -                   dmi_get_bios_year() >= 2015)
>> -                       return true;
>> +               if (bridge->vendor == PCI_VENDOR_ID_INTEL) {
>> +                       int year = dmi_get_bios_year();
>> +
>> +                       if (year >= 2015 && year <= 2024)
>> +                               return true;
>> +               }
>>                  break;
>>          }
>>
>> --
>> 2.34.1
>>
