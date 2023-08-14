Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B4D77BFA5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 20:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjHNSQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 14:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjHNSPv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 14:15:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2CE1710;
        Mon, 14 Aug 2023 11:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+UXr+XNOjt9eJ9bXZGKZBEEWMoTyrvm2j/LmI4XSQkZyXS+Sy9NEY47ql1oRjZ4JuqJSIox2Puu9CQCwUOt7PpJip5D92RTrW7V4qI6LqjDDYqVqnHNdqB1o6GYS/nuHY6t4rcA39UWqzF0fyycKu2csLgGQAnNTvcd4QxkCWpIobHcYJRopMaCUmEp95nVl3E5VjRmtvv+MILwQmY3tPSILCMxFxLzTWxamQjOt24MAg98ImTuCxctcS6Uc7MUhew+65E5WftfufZyryZpbhz9pJlurG1OzCjmpEqo3x+SUqB9MvEkNaNFFdc0Jpu5KsxVg+Hk5ld83XY0pnumzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSr9iEIxTFa3SEj+M98gTxQjzEhCaf9bOI9pYtqslos=;
 b=AP2AXlrdgPek1mo6nepV7QHr0uaqor4PParDZjAzCXKcJiLVIbenZL9+jkBlMhrLQCtzGKumiVcelisCzh+mgMUI1c7ZlRWo+M+Dz7LxnkgycEeKvkfROCI5KpaAmjABUCmRTafryTkSQzJ06XZhqC+eDrwjUtxD1WOPwbg2RRL5F2v9Nfu9ukDFmC/VSJJusgXhz78h5oR+K12+l+ofMyK7nydBCN/biV7dyk3ocGnumwrMkZc8NGqme4BUh7y9OjOVfNJfZFV6gf8VJYc1ZIFqRsblWWVEnvjxBGqrl443K4LA+m+ZvFyADoGRRHmvnEQUZ/e873U0wiioK6MKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSr9iEIxTFa3SEj+M98gTxQjzEhCaf9bOI9pYtqslos=;
 b=SFNY7fAtepkNDNJOGoQtKXjoaWsk3F8l+bUW/CqXHpFOqgCENDPP4gYN2kJ1ZYT71hyoZMfIziKpm2ylC6lOXsILCGKsXtXjhdlu9jGgWtNlBlMr78DOct0Oq2dBaBxtqGlZGu+nML5LmYt6EmMczjcsRRDlt0+ETMaDA6S5fXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 18:15:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 18:15:47 +0000
Message-ID: <1860149a-0c12-4662-9b22-a442632c6536@amd.com>
Date:   Mon, 14 Aug 2023 13:15:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: firmware-iwlwifi: Wireless AC 7265 lacks D3cold support
Content-Language: en-US
To:     Juno Computers USA <usa@junocomputers.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <265757ae-c1bb-410e-b15c-7afbab18edbb@amd.com>
 <7505EB8D-2488-4A4D-A0E8-626FBBA6CCF8@getmailspring.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <7505EB8D-2488-4A4D-A0E8-626FBBA6CCF8@getmailspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:806:d3::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 0246fc36-50d1-4038-6583-08db9cf27b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYZPMrkWjWRnIMbZqBqk5uAQoIWh7kWgjB4TwMpcU3/SHL3I+w2Pjw1u2hKlUezx6MLVLYosvIxot0W+xJao0YiR9QJm/fLMzDzn31C7NnjmEtqyba7eSq3PKBPAWMajYr0Cm1PTTVN/SnjiLaeDfGrWqJPF7bVl+JwEgjuBBap0c4vjGvPPePdR4OiiFivqf2HvWatkja19gROlvnN3lwYeHdmkqYE+2tobyle3aVIev2J9YHc7tSRmuqzT+RWBWpaRjQbjYePgy0KJXcfw8byY0Z5qw3kjQ1N7CVN05RdiXnkWdlu4sTrjSp3TtsQdYYVCsJpuUmXookzYtP/Vm1R1WrNBE/7rEDuuLY8GYxhn7YfabFIIP1pv/teAO4qsyK7YgrVjrmZZ9OfZy6T40r6OfLqkvZz7U3k8Qa/re1hEXDe713CPq6xWBfKddar+c4CtJx+1V7sMkPFJHWT9zjtFqHDSMDsPLKq4kfZKhMzw9Z4cRW0T5usrvnXNkaSxqB8RP/eWPVBYI7d8xSgzWIGK8+D04FqsIbVFaBlgIxSfFET+jfdPtfOxsiLqWIOGydFiRtzG+VsjlLBW3Vx6UjJQvMEJkUaHa+ufNngGzqgSwSZ6GjXvSXf435e6IQ+rOSU/PYEXn6LdsyCsO0KwJK7MBTk+s6ZR48sbuADqOk8aIJAMoHnuQtNTPRG/TCjt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(346002)(39860400002)(376002)(1800799006)(186006)(451199021)(83380400001)(26005)(36756003)(53546011)(6506007)(31686004)(2616005)(66899021)(6916009)(66476007)(66556008)(4326008)(316002)(66946007)(38100700002)(966005)(6512007)(6666004)(31696002)(6486002)(5660300002)(41300700001)(8936002)(8676002)(2906002)(86362001)(40140700001)(478600001)(54906003)(10126625003)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXFGbjNSS2VsTkgyVFBKK2k4UlpKYlhmTUF0b3JnUTJsTTBjaXd1dFQ2UkMr?=
 =?utf-8?B?ZFh2NEtTbDdiWnI5S0g1dEh0NDVLS25QWUY2RWhQQm1pUVhNYkZuYThIMHQr?=
 =?utf-8?B?MWFnOEoxemVLbHFJU0pTNklhQnQrVlVhVEhCWWVmNXBtd0lPYVFZNE5qU1lQ?=
 =?utf-8?B?UW1DTlRPQjF5dVA4a1p4dHRTcjE4SEVqY3Q1bm9zK1I0TWE4eE13UGNIeUhS?=
 =?utf-8?B?cEIrMHJRaFpDTTY1UmRRMTdqek4ybm1KMWJFOE1UUHJSNllyS1htYzd1L1lk?=
 =?utf-8?B?eVJHVjZXUElmdVRoSjVFVFJiQ0o2b1R4cGlvdXoyWVFncXZENzEyWWJ3RnNy?=
 =?utf-8?B?YUl6ak9OSlROclBUeUwvc1dIN1ErelpNWFhXL1A3ZFZpSFpXTVQ1d1gxOXk1?=
 =?utf-8?B?WDVRTTVDVkRxK3Y4TjhGZ1dlTEl5UXAzRmk5Y1N0OGkwaG8xK0VpQUs4Z3h5?=
 =?utf-8?B?QVd4OWcwUWdmS01ISlF2amRzRjVEUHRvQmlXRjJ1ekc1WjFxcGRoa0liSTk3?=
 =?utf-8?B?S3E1WHZQL3UxTStncWs2U3dRNXpsSHNOQ01TUlVYdE9uYmtGTGs3dkZOTWJZ?=
 =?utf-8?B?dkZIYXlhK3JsNi90Ujc1bFdRR1NnSXRyWUtkUmp2Uy9KWHBESjFmWjFzeWZL?=
 =?utf-8?B?UWVYZVIxMXU3N1dVZGZuVEFROUZnWmdaVG1oNnRyNUpNK2o5NW8ydjA3VGlH?=
 =?utf-8?B?Q1VjL3hIaDFYM1ZtdmFTUmlWRXZ6cTFBT0V1Z2x5ZzQyU3dub1hLbTFndlBV?=
 =?utf-8?B?QXhVckg0aVRpbERqQndEUUhzRlh2c1JSYzhLd2hVNFhUR1FnYU0vblVvS1J1?=
 =?utf-8?B?TWh5bjBDMWozZjNLdGF0akZyU1lvVnRSWkpWNUU4VlBxdHRqanhqWDlCMlFQ?=
 =?utf-8?B?TCtyOHNsM3V4RXNLRGJWOHYzSmhuc1NtdG9aZkkxOGpySDYzVjI0TVU0YWJr?=
 =?utf-8?B?S2NvbldmcVFWYXVRaEdRWitDZzJEa1l6aUtXSUM4R1hQR3BYZDRFNUZiWWR5?=
 =?utf-8?B?R1UvNXFxbXNWTXY5anlxSzgyUWw3Qm13RzBUMTUvSytXSTdBLzk0ZnB2YlZI?=
 =?utf-8?B?T2NhR3lacGtlK1FWOXVxa1F2WmJKcUdlcnQvVVZLdkhQMXpYa0N5aHRlNE8x?=
 =?utf-8?B?UWcrQWF4YjM1RDVXbXlmdUZteW9RRmU4TWFITWw2aW5CSU92M3ZNMkNJQXR5?=
 =?utf-8?B?VDg5V1psOU1COFVTVGpWWmZTeCtuYktoSmlvSHN2UG16WldVTHdNNDJsUkkr?=
 =?utf-8?B?SDdxWTdXVzVlMUVVUzNpWU1BQ1FXZlR1d2V5QTdhKzlIY3dnRHdPZjZ5RmRR?=
 =?utf-8?B?WkYxa0Z0T1FWdVFuRVZUSlhSM0twbEthOERyQ0ZKb2xYallTNXNyanFlKzcr?=
 =?utf-8?B?ZXZtRnJqZGZwaEJFRnphaGNCZUtJRW1sbUFld3Q2V0hGaVFUZDVHeWdzenMy?=
 =?utf-8?B?L2dHTmJjMS9YekV3SkJGaEpnV3VSOGVzaTZUSXpZL3hHeC9oelJDQWthSVFo?=
 =?utf-8?B?OE84aUZrUlFWTmdJOUo3MTVycG13bXB4TmV6dyt0RWlyTjY4eTk2SThiSU1s?=
 =?utf-8?B?bjAxZGFNbzdlM2VWaW9GbWs3L09NaVVzWUtPb01qcVBnNFFXbWh5akMwQVJS?=
 =?utf-8?B?TWVNR2laUXpFR25Hd3FRcnNXMVJOYWhtQnBsRzgyenRhQ2J3b1JTdU10b3Np?=
 =?utf-8?B?eW9ya2srRS9CNUtYalVCN1l5SXZMWkVScVFGdnZwR1hGWEduOERFb3psNHpK?=
 =?utf-8?B?R1lrVUdTdHlGaGJ4YVFFTXhoQzVQcUNlUWZseHBnVUZLNW9RNlV3WnVnWlZN?=
 =?utf-8?B?ekEvbE1mZGRzZW5wbU85bElwRVdIbjRCSXNUZGhmSFJzMitFelhVekdUdEx2?=
 =?utf-8?B?YTRBQWJXUGdxaFZ2ZjI4TkZjSlc0UXZpZk01cUhMdmx5ekFNVE9yMzNKZmNP?=
 =?utf-8?B?K0JUV3NGeEQvR3RNSXJqdXQvMTlhbWYvekdpa20wdUtmbmFXQWJGNWt0WnRR?=
 =?utf-8?B?ZHFYRmhlb1M4TkszTnhWOGRBSVgybUd0MHBLMmJIMjZ3UTYrd1QveURHMmpp?=
 =?utf-8?B?elV2ZHlBaGFlRVRDYmM0NEdTZk50QzlvVHY3bU9pSXU2bW40QjQzQ01NT251?=
 =?utf-8?Q?3L6yq3zPvh3GTKYUpF1nKO2Wp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0246fc36-50d1-4038-6583-08db9cf27b4f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 18:15:46.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arV6ctUjMGqL7LVMEDIwEinAUM6n602XpkT7kXSEGewHPkjJY136vvbkQ3oh/NOwB3ll67I+EPvA/N9iYXNZhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/14/2023 1:14 PM, Juno Computers USA wrote:
> Hi, I have never filed from Kernel Buzilla before. Any chance you can 
> send me a link?
> 

Here you go.

https://bugzilla.kernel.org/

Pick "drivers" then "pci" for your bug.

In the CC list you can add my email and Bjorn's email.

> On Aug 14 2023, at 2:02 pm, Limonciello, Mario 
> <mario.limonciello@amd.com> wrote:
> 
> 
> 
>     On 8/14/2023 12:57 PM, Juno Computers USA wrote:
>      > Please check the link below. These are with pcie_port_pm=off.
>      >
>      > https://pastebin.com/aXbBHf3w <https://pastebin.com/aXbBHf3w>
>      > https://pastebin.com/xzdGbtuG <https://pastebin.com/xzdGbtuG>
>      >
>     https://github.com/junocomp/debian-juno-tablet/blob/main/dsdt/tab2/dsdt.dsl <https://github.com/junocomp/debian-juno-tablet/blob/main/dsdt/tab2/dsdt.dsl>
>      > /sys/firmware/acpi/tables$ ls
>      > APIC  data  DBGP  DSDT     FACP  FIDT  HPET  MCFG  PRAM   SSDT10
>      > SSDT12  SSDT3  SSDT5  SSDT7  SSDT9  WSMT BGRT  DBG2  DMAR  dynamic
>      > FACS  FPDT  LPIT  NHLT  SSDT1  SSDT11  SSDT2   SSDT4  SSDT6 
>     SSDT8  TPM2
>      >
>      > Please let em know if you need any more log files.
> 
>     I need to see a full acpidump, it's not predictable which SSDT contains
>     the LPS0 support, and I want to be able to also cross reference the MADT
>     (APIC).
> 
>     Lastly can you please add these all as attachments to a kernel bugzilla?
>     I worry that pastebin is ephemeral and if we're going to need to link to
>     your issue in any way we want somewhere that we know will still be here
>     in 10 years when someone cross references a commit message.
> 
>      > On Aug 14 2023, at 12:58 pm, Limonciello, Mario
>      > <mario.limonciello@amd.com> wrote:
>      >
>      >
>      >
>      > On 8/14/2023 11:56 AM, Juno Computers USA wrote:
>      > > Hi,
>      > >
>      > > I can provide some logs. Should I do it with pcie_port_pm=off or
>      > without?
>      > >
>      >
>      > You could do it with both, just make it clear when you add the
>      > attachment description to the kernel bugzilla which logs are which.
>      >
>      > Also; if you try my patch series please make sure you test
>     without that
>      > parameter and indicate which logs contain it.
>      >
>      > > On Aug 14 2023, at 12:41 pm, Limonciello, Mario
>      > > <mario.limonciello@amd.com> wrote:
>      > >
>      > >
>      > >
>      > > On 8/14/2023 11:35 AM, Bjorn Helgaas wrote:
>      > > > [+cc Mario, linux-pm]
>      > > >
>      > > > On Sun, Aug 13, 2023 at 03:33:21PM +0000, Greenman, Gregory
>     wrote:
>      > > >> On Fri, 2023-08-11 at 15:34 -0400, Juno Computers USA wrote:
>      > > >>> Any updates on this?
>      > > >
>      > > > D3cold support has been a problem area, and there are some
>      > changes in
>      > > > progress [1] that could be related.
>      > >
>      > > Yeah; no harm in at least trying this series. I'd love another data
>      > > point with it.
>      > >
>      > > >
>      > > > Could you possibly collect the complete dmesg logs (with a recent
>      > > > upstream kernel, e.g., v6.4, if possible)? And the output of
>      > > > "sudo lspci -vv"? And the contents of /sys/firmware/acpi/tables/?
>      > > > You can attach them to the Debian bug report if that's
>      > convenient for
>      > > > you.
>      > > >
>      > >
>      > > Yes this could be related but it will come down to
>      > > 1) Whether the root ports are considered power manageable.
>      > > 2) The system uses S0ix or not.
>      > >
>      > > whether the series could help as it stands today.
>      > >
>      > > Please CC me into any kernel bugzilla that you open against a
>      > mainline
>      > > or stable kernel and can capture the lspci output, the dmesg and
>      > > acpidump and I'll look at it.
>      > >
>      > > > Bjorn
>      > > >
>      > > > [1]
>      > >
>      >
>     https://lore.kernel.org/r/20230809185453.40916-1-mario.limonciello@amd.com
>      > >
>      > > BTW - Bjorn, can I have comments on the last patch in this
>     series? I
>      > > have fixes ready locally for everything in the earlier patches
>      > that Andy
>      > > gave feedback but I was hoping for some feedback on the very last
>      > patch
>      > > before I sent out a v12.
>      > >
>      > > Thanks!
>      > >
>      > > >
>      > > >>> On Aug 3 2023, at 8:01 am, Juno Computers USA
>      > > <usa@junocomputers.com> wrote:
>      > > >>>> Dear Maintainer,
>      > > >>>>
>      > > >>>> If D3Cold is enabled from BIOS the tablet boots without Wifi.
>      > > >>>> The only two ways to enable wifi support is either by
>     disabling
>      > > >>>> D3Cold from BIOS (not ideal) or adding pcie_port_pm=off to
>     grub
>      > > >>>>
>      > > >>>> [   12.681303] iwlwifi 0000:01:00.0: Detected Intel(R) Dual
>      > > Band Wireless AC 7265, REV=0x210
>      > > >>>>
>      > > >>>> This is needed for our new Juno Tab 2
>      > > >>>>
>      > > >>>> https://junocomputers.com/us/product/juno-tab-2/
>      > > >>>>
>      > > >>>> I also filed this under Debian bug-tracker.
>      > > >>>>
>      > > >>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1036633
>      > > >>>> Thanks,
>      > > >>>>
>      > > >>>> Giovanni Caligaris
>      > > >>>> Juno Computers USA
>      > > >>>> P: (215) 509-5472
>      > > >>>> W: https://junocomputers.com/us
>      > > >>
>      > > >> This device is very old and actually already EOL, so I'll not be
>      > > >> able to get any support for this internally. D3 works fine
>      > with this
>      > > >> NIC on standard, off the shelf laptops, so I'd guess that the
>      > probem
>      > > >> could be rooted in the tablets' PCIe hardware or maybe the BIOS
>      > > >> itself.
>      > >
>      >
> 
