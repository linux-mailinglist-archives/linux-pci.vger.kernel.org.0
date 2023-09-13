Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC88E79F39D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 23:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjIMVQo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 17:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjIMVQn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 17:16:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583C8CA;
        Wed, 13 Sep 2023 14:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW/U1CPagCNRJCZQEtRB+M1osuz6zRtjBzrj0IqKB8qi/tJbu+uCZr4JWx3YE1wCT9lC2q4Lh0adwj5sYTC+a6ANEC6mBPpFSk12yvqUct+hKu23GI7me4rwbhZ04w+sFBKg8+E0sJP/borcyXXsE3MpNBLcKyEVBMsh2iQFTjxgUPkx3QApHBZHl/47pB5ZQ7j0c1o6SwRReUr5Y+uFlt3obm2IIGPMPNB5GTtNkhgGdhp5m71D7E+UEv9qg1+3VuWgAQzLTKsrIUkt+mfz4ZWcsno+ADiZaXmBmTXhiQXv3UoOmDa6Owcfyr8ppJXy+BhQgEkd1t0dKUmEJaEGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09S4ijxYNEeP3JBWDUcWxPTurF9WkTJwYP6N1WV5VVM=;
 b=iXwM3knCvcDhztLG5lKivAI3SIS859r1ls/PIu5cP0l/TahOzDcHi/MmKJar+6j+nZF/7uaFG0Q06HqDAspRWaVK3EABmQW+AiJVewy/+9d+2DtMlmw0Ya1l+VKiSgWySbkox/5YUyuUdfvhrjMlrY45yFVrnHGXvXMwRMmSQd0n/LBEsPWPwdxQ0lvTw2Yz++Wx0XwQ9VCz8lb3UMA46WnHuE0TcZkamJUKBhgM/4Wi2AoZ3EFlXwJmsKXynvRJqOWiJBHMRcs9R+ogWjUmAElOKOnfmrbnoqjUES5V0xkztjiEgmdVqu7M4D8yAe42hsOAHZGkgfbnqm0H4XaS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09S4ijxYNEeP3JBWDUcWxPTurF9WkTJwYP6N1WV5VVM=;
 b=tgDDssVY+PGaIm89YkMI2+gHeZ+UOBVHujGdBzI0JIK736hxhKDuMrLLrzxIMw44W19ud7waxg4rlfvM8O82kqeiEVTO91X+qI5yvtCBCeAQ934VtyGcq6huCCKb4Khf96DWGtV1WJKSOPkvTVH+frSnxOx/1di6LPlomDr7FwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 21:16:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 21:16:37 +0000
Message-ID: <001d9c72-49df-4a8d-a9bd-10311887c60d@amd.com>
Date:   Wed, 13 Sep 2023 16:16:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Content-Language: en-US
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
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230913210543.GA440503@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0193.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be3c778-5c99-4a83-d1c2-08dbb49eb6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14Ry41Dgm3AzbbyflkHDp6ZuRBBVGtK61yzkvA07Jn9k/AcFb8DkX8xV4FgUO650RJywhN/EewhpYp16sv2AXZoTHg0Mcfs1Trj9D9vfNKKKsJIECnNEeFGE1zm7n1iCCh5yO9JLK6hPlJ6aJLr8Q6r4tyN3Ynv+wRDnLAukZC+QRXniNGXTL7ugEGqlpUlrVZGWoKbWoWP+s0D7FHdLsfTXkD5oqewSHQ12QxOcnkI+o+zOlLsv+zoDut8wLvLpe5y/Y7l/mqAH9ZL3rklSd+V6dHGja9nl5YcVq2zgg75YUiXl0Bym+0SMmFq0uAh8IZBCsE902xLMKfXCQ2JLSF2btatmFvwzrRvLewR/NWbeNn3hmLldJdaM47Asmp23kfWEvD/agu/kEGwG3YjdM7zBUNa1D+v/oyH/LhmYL7kuvrvzjYrpErCYa5ollH+PmiESy8iAS5YeqGoAd60w+PzGZWtjnqMFPqPT5HCS1IA0Pcye0Dbvseo1kbL4CN/VmCC4ZN7T7AtnlDsk7rbkRu1GsVheX16Z8NsSY/XonSYhcEIGKfzUbAMbpe23/wlnO3JO7MlIZ5n9hogSOVBtmaU4B9kFTt0SKKHhqYuX6Gzlm2OfNlHrQ+Um/FBSzlcOzKP6uHenl7D231hjvipe8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(186009)(1800799009)(451199024)(66946007)(6506007)(110136005)(478600001)(53546011)(6486002)(6666004)(2616005)(316002)(26005)(83380400001)(7416002)(66476007)(54906003)(66556008)(44832011)(2906002)(8676002)(4326008)(41300700001)(8936002)(5660300002)(36756003)(31696002)(6512007)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkQzUFJnbXFGN09uTnRLaU9QWkFldlZjWE5ITmRuY3RkRXU5U1k0TWZlR1RQ?=
 =?utf-8?B?RTdRV05pR1V3YUh0Y2EyT1R5b0NBcHluelVVZENsSFdxV2lWNkVObzhCM0kw?=
 =?utf-8?B?bkxKVUc3dnU4MFRhdGN0Qk5hTjdkU2wxTFpmYTZpMDMxRVM4YTBJYlV6UmVh?=
 =?utf-8?B?Z2pXOUN3YlM0TG5MTHoyMm1TdVNuY240amt4TTdvczQ1czFTZ01WQjJiN05D?=
 =?utf-8?B?MmNaR21YOWZ4T0haMk84bjZEdFlLMVAyRHdhT21rMXZlUlRBT2hURHJIaVZ1?=
 =?utf-8?B?QmV4aWFmTzBYbEk0WWdPUXVGaTNvemtQTnZPd0pLeXhCWXIzSUNISlJPaWdk?=
 =?utf-8?B?SXFrNVk1cW9BWUtjTmsvQVdMVExCYWRyb2xndTRZVGsyaE9ZbzhjeW1wdEZv?=
 =?utf-8?B?Y0ZUalc3WnJENnRiVG54eFZsckZtaHhQRnlFNnNSYlZCc3dLS3lLOUJ1d3Vu?=
 =?utf-8?B?Q3BIbm03RGluV05raFIvdDkvbStJVFdPMmIzbkp3UEF0NDNIOFhjaHNGc3ZQ?=
 =?utf-8?B?LzFYM3pjUE56WEdhVVJQYy83ZXFpZ1Z0aHQ1WjBxRjNrbFZmWWhyWFBsWFBT?=
 =?utf-8?B?REJpdkNxdUo4bjVmVVRrZERXNmNxS2FVbHFDaG9jUk1aaXJTbEN6V25HMURX?=
 =?utf-8?B?dXQwOWFiUE9YMlo4YnBFTWpIZExScUwyODFRWTR4VmlIeXA5ZEovNDlDSFZB?=
 =?utf-8?B?Z2xkR1crd2xFSUhOVGxQMlppQVFGV2JrQUlhTEladHlzaTgyRWxxQ2M0ampD?=
 =?utf-8?B?bWN4UFJzVEkrNFpNNWRvZ0tHaFU1SXFrWGdSQ1A0UkU4WTNQSTNjZHFOMUpT?=
 =?utf-8?B?MHk5ZWw0cmtldWttVGxZZ2Y5RXJyUXJwTkFjT25OMWwzaFdXUktPZHlVWTBN?=
 =?utf-8?B?TEFvOGxvaURzc2pwT09BZzRDNTJ6SVd3ZThRVFdDVWlYcWxkcVl0b3dHT21n?=
 =?utf-8?B?SlR5RklzVXcrYXg1YjVSMitLb1VsaEM3bXFZOTl6U1BMek1NQk5ITUgxNGVw?=
 =?utf-8?B?UXYvY01YSTVOYW14RFZiOHBnL1E0ZTBNQWhabFUrdDF1dEFBbjJadkZVK0ly?=
 =?utf-8?B?NUgwOVZscjhXenROSURQcm9RL0cvZXJacHdhQUZxOFNIeUZ5WG9BQXM1aklL?=
 =?utf-8?B?ZENMdElYZDV3N0dhRjhLWjFiV3psQ3Q5RkRnSzR2aURLYTVpTU84RXU5Vnhu?=
 =?utf-8?B?UWtCQlBBRncrT1h5aDJ3RkNNeno5ZXU1V1RlaTZad3BxK3htVkRCVWU2T3Qy?=
 =?utf-8?B?L1B6ckxYSWdqbHVJOU9PbUhVWThuNnViaW53bHdLN0lRZ0p4UXpHUzNzWmF1?=
 =?utf-8?B?bnVvcDlKbTlCSzZjcHJHNjFKa2c2YzZjUUxIa2lGZlhsSGlpNG5WSllSS0tx?=
 =?utf-8?B?YlBxWWpjSnpUSGliM0grQzZyMFo3UGFpdTE4REJNY0w3a2NBdGo2NmgxQVFo?=
 =?utf-8?B?clFvUVZ5NkdJSDE3NVFCQTlSdGNmdXV4Z3pTd2UwZkpERElqeHRJOW5KSmZ0?=
 =?utf-8?B?TSs4R1RMV2l2NTFjSlBQVU43QWtSRU01bGdSQWM4VTYySkRmZGo2Yng0Q2Q0?=
 =?utf-8?B?cmxrbEw1UERuOHdyYXByL3RJc3BWMWZsL3l1eUk2TC9vNnRlODEwbXZLV2tW?=
 =?utf-8?B?Z25jcnBHS2hQWnRRL2lOaVRYR3JwNmlvTGYxYnhQWDZra0p3aWJUMDdvSmUv?=
 =?utf-8?B?MVBISVZjQnRiYXBQWTdDU0gyUldNQ0twS0tsYWdUT1lteEx0ZEc0L2lDQ0I5?=
 =?utf-8?B?OUdhQlZURzJPdEprRnlUVm9peDEzb2tZOE82YXlIaWc2WlFTbk81QUxwa0Z4?=
 =?utf-8?B?VFdFNGNFVkRFTldzV2lNdUtzT3I4N2xjMEY5M1FPSEFNRVNGOGU4SE1iSGth?=
 =?utf-8?B?UmZDSG5pKzU2Z0M1c0hXeDhNVDRGU1FBTmtuT2k4eUo2bG82SGdPMDB3WVZq?=
 =?utf-8?B?YzYxVXhGNHRpU0VwcjlLQ1ZNZGowU05yQXlCTE9qZDJsRWMwbWJqMmx4RHY1?=
 =?utf-8?B?UUo0ZW9TdEt1OTBEU2ZsM1hqNUhTbnBFZ0VaMmFDWGlUM0hLYWMvcW1jS1RR?=
 =?utf-8?B?NWRBZ2w0cVFtcUxmZmNJckhaR2R2ZEVNaWFkYUQzRUpkb0MwbGZVeUlhUEgv?=
 =?utf-8?Q?9DLLok3dNyo785/3n0QRlexEn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be3c778-5c99-4a83-d1c2-08dbb49eb6e8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 21:16:37.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvL74PN1LzUC1myQ6d1w/vEZbeHe0SDFHgYa9ZH0xkGahbTfaqvgZp44sm1ymmAv3oHmsDzdR+sgdddHyB4YTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/13/2023 16:05, Bjorn Helgaas wrote:
[cut]
>>> I expect it to be an ongoing issue.  I also expect unless we use
>>> constraints or convince the firmware team to add a _S0W object with a
>>> value of "0" for the sake of Linux that we will be adding IDs every year
>>> to wherever this lands as we reproduce it on newer SoCs.
>>
>> So maybe the way to go is to make the AMD PMC driver set a flag for
>> Root Ports on suspend or similar.
> 
> I like the quirk approach.  When PMC is involved, the device behavior
> doesn't conform to what it advertised via PME_Support.
> 
> The v18 quirk isn't connected to PMC at all, so IIUC it avoids
> D3hot/D3cold unnecessarily when amd/pmc is not loaded.
> 

Technically someone could; but realistically no one will be using these 
machines without amd-pmc.

The battery life over suspend would be abhorrent.

> I don't object to avoiding D3hot/D3cold unconditionally.  Presumably
> we *could* save a little power by using them when amd/pci isn't
> loaded, but amd/pci would have to iterate through all PCI devices when
> it loads, save previous state, do the quirk, and then restore the
> previous state on module unload.  And it would have to use notifiers
> or assume no Root Port hotplug.  All sounds kind of complicated.
> 

Yeah this does sound needlessly complicated.

> Maybe it would even be enough to just clear dev->pme_support so we
> know wakeups don't work.  It would be a pretty big benefit if we
> didn't have to add another bit and complicate pci_prepare_to_sleep()
> or pci_target_state().
> 

I don't think clearing PME support entirely is going to help.  The 
reason is that pci_target_state() will fall back to PCI_D3hot when 
dev->pme_support is fully cleared.

I think that clearing *just the bits* for D3hot and D3cold in PME 
support should work though.  I'll test this.

Assuming it works how about if we put the quirk to clear the 
D3hot/D3cold PME support bit in drivers/platform/x86/amd/pmc/pmc-quirks.c?

It's still a quirk file and it makes it very clear that this behavior is 
caused by what amd-pmc does.
