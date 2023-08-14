Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF95D77BF76
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 20:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjHNSCT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 14:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjHNSCI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 14:02:08 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89307124;
        Mon, 14 Aug 2023 11:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJ31fcLYOQWyQc2RrlRs0cQ87Y83kAFGt1FwqlKKe0tishIOKdkmscelJolBHiCe8F0th3Yp6OMf57DgsPYbZlSzm6JFLVCLkqaIp2CVhecOprsX13/gpNlHYYQGU4sad5SaeneCVwQDXJy/hcRYWsThqncrnX33PvETHnbcoKJqYZL2GW5ZCuzai5mHiun7wQDqMxvC8BcUqUEfYUJzqWmd/i++F2aWWNRJHa/Ny7v3ZDzUlt3g/9IYqwEqRUY0ynN+fPCzjTmOkrMJnJATzgo7E1WfmH+8m6AlTrmq1SeUReJabdTtQDTMeJku47VRE7dbh9HNY2K648eQCe5hWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qxf8xQ3fgDPdN6zA20Xomtc/n7mCFvQCwLEzYarKUmo=;
 b=dzvU59qKMrRy6YV2EfevRJqhEq25KBkVSO4oYUF1449mXfCEVigzEIdPMuqSee9FlBVCMdvNAWxrfBOUUJx4JTjB5WJEnlgjcoSP+sk6rx8hX7uzeB0MayyIuXaGA+HCHv8XBXMIOQ3joD6GfeZQQVx1dX/1DO9W84UDs3MM6GOu5yvDQI4W3YfXJLiHNUuWpZX81tbhCQvNUanLL+qFpDeAK9RpA6sozkDFT0u21Frrkz4Bx5bQwkgoj6MC9pKxe2NNIIkTqHHWHQSmNI+yXyuEGSBweKFi4P4IkYrn2NqDjh57kY93SE7bCqGhqbOknd76OMj4HLAmGmyY5Ila9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qxf8xQ3fgDPdN6zA20Xomtc/n7mCFvQCwLEzYarKUmo=;
 b=1OSfTfKRdD8cN8c3hG6bjvpHQ2Pj7NeBW5VPxRTBube7yAc6cFQvgKWMGV8Sl8WTPBxN1OIuJYJhhIR8QpJXimv6IgcPSa1qqvEApHev+XuVSKWFJCcWygaRWzKsAUd5eaVyoUFqAK3h3b2GCUnNT3fohM+1Ud62o1bUGo6fz5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 18:02:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 18:02:04 +0000
Message-ID: <265757ae-c1bb-410e-b15c-7afbab18edbb@amd.com>
Date:   Mon, 14 Aug 2023 13:02:00 -0500
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
References: <912c659b-420e-4c2d-96f1-0ed6de5d4b4c@amd.com>
 <21332625-6BED-4BD1-85D7-52926C7D61F8@getmailspring.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <21332625-6BED-4BD1-85D7-52926C7D61F8@getmailspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0078.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 33949fde-fb8d-4baa-5865-08db9cf090d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: te6D3wShPYlrld2ikjzcDmmKhYC4fivbc/FhgTHEBeUq7CCFKh73IrUwlswf6/nHfXuSAlezQHJuHGE3YJhFjwpS8Re11l5RpQVyrKadinSOe1E2PfeN9+x75rdB5bAJpFXeXzjNCwHTKGk6EuvXnbbddNfQfe1IeT20znURovEppDnfJjDPF84Q/7nbv7A3Fm5KXLIJPKE/46NYz1l0xG/RQPgacgXzshZGiejfjAHk7GA3qdMkup7qxIvrlWdirpEsY+PcOACSxDUTNOIaYd2kpSU/7FFX9Hkx+nvEo1689vCmnOn2DL8RB3BsnMtYgTkK31iL3l6z1zKuzm88jM7YFISXTlC64g50EU6XePMvaICvGwLSd/de8kl/+7XckW6C+v2LwRmJdqEv48AYvSY3MGN/6f8/NPf42+WdUc9QwuY7bxLKFZGnnBq7bkkDidmWNUC0/Ov23WzM0pIeof/6L30hEL0MwMHzG/TTnqFeorWVhWI6PWovta8NioONGF2XpRTfCxxAO2eKKO7B+bAdtEEUhaSrKTr999doIAoeA7d4byqDfpa7kzbPYlqpD3IQX3iGhGtd7M8/1Lni2as3Y065VcmM8ORHNms1sw4iVSRhZdJSEQUpTFCWG7V+xu/IwXN5SJtPah54djYrW7I93CwfkeHI2UzPJeLXnvRbtEao++5sgOYUpuiYNjye
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(1800799006)(186006)(66899021)(31686004)(6666004)(6486002)(966005)(6506007)(478600001)(83380400001)(36756003)(86362001)(31696002)(40140700001)(6512007)(26005)(66946007)(53546011)(2616005)(2906002)(38100700002)(4326008)(316002)(6916009)(66556008)(66476007)(8676002)(54906003)(5660300002)(41300700001)(8936002)(10126625003)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NThZdkJkSi85YU1PME5weWNDTnpXS0J4elNiZDQ2QzVTSkxRb1NwTmczQkZk?=
 =?utf-8?B?eWI1c2NzRC9DZHhjVW1UM0k2Rm11SFZ2UzBuZTNhaWxQU1NpdGg4djRMaW05?=
 =?utf-8?B?SmNFVUY4cE1QcWtlclh2UUp1MURmUURLT1pIWjlWc2NrVllCRW43Z2E0Tzk3?=
 =?utf-8?B?UjMrWWsyQ2FDaGoyYkxsbFEwMjAzTHZCVTVrSUh3L0JHVG5Va3YyTVJtdE13?=
 =?utf-8?B?NFBOWW9kQiszdk0zU05MRVJKdDNqUWc4Wk1SaGxzYlRoNy9SV1g0ZHZLZzhS?=
 =?utf-8?B?eGIwMThyV1NIZFU4Sm1nbWR3ZndnTWl0aUZHSHk0SWRaOWN6bS9vM0pVS1BS?=
 =?utf-8?B?dVRFYXFObko4VXgvTFJMUVR0VEZPa1dHRm9Rc1pDRmtsN1kxd1h1MzJUWFZN?=
 =?utf-8?B?Ymc4ODB5MjV1S21aTWozWjVtY0dTRFJTMFV0cHlyRzVtRHg2QkI4czArcHFO?=
 =?utf-8?B?amZrcllHcmdSTEpvSTVCNnl1T3JWcUpmSTVLMktlbGdmMUhBQmNjOFNha3RS?=
 =?utf-8?B?ZmRCcSt4SkdGSmxaYlVuZmoveGk3ZWtiSTR5Ukt0TFN0MzRTeUo0V0VBZHg2?=
 =?utf-8?B?QWgzYmFkMGpVbDNIekQ0YmNYRVJUOVg4VTdCNGJxdHJZOTJQT09EM2E1YUNY?=
 =?utf-8?B?SWttR0s2TnBua0x5TVJ4S3Q4aWZOTVlxeTNkR01MV2RoSmZhNVIzR05RTFRC?=
 =?utf-8?B?OVo1VVR3N3JyRWl1ZjRGOTR0Q0hKYllQcjVuYnlBT3hxRmV5TlNPSnU4bC84?=
 =?utf-8?B?MXFoRG5jTlQyVTdLbmtTMzUvU25lbmNBd0lRT3U0eko3d3AyU092VkNZYmFV?=
 =?utf-8?B?Y1pMd21ma1Urb2Q5V1NqSFJVWTM3a21GU0x0U3NoU1JqWFBSN2J0Y1NRZXdy?=
 =?utf-8?B?aDNMa01Ca080V2xTc2dKVThTNW05WjVXZ01wQjFhcng1akd3Q0J0eUxoeWo3?=
 =?utf-8?B?Ump6WEVXTEV5dDBqM0R1TnNsbXVIUXdUNm94Q0x6U3pDVG1kYWYvS296blpG?=
 =?utf-8?B?Z2xwcGJsL0Q1amplVGp5cGlQeXVYamthN0FDakdLSDFnNEFMVHZDUXYyeEhC?=
 =?utf-8?B?a21GMFZxMitoU0ttRXkzZHRwNjBKclJTL2xRKzZ0U0dpc1BKRWZwTzZ3WDVP?=
 =?utf-8?B?NExYTHREVHRuQktQbEpNRllOSnNCUEIvaE5xcGdZU1Vja3hoODNkOVZPd2g5?=
 =?utf-8?B?TVlSZVZzdmhvYzNkbEtzN3NBMmJHUnZmSHluUTZISGg0djZEaTl3b3p1aUZa?=
 =?utf-8?B?VmtrYjNNNVZuQm5Sd2l0TnFEZVlGdHFXZDVWZVRJd25sNkNhU1pud0daNzI1?=
 =?utf-8?B?RFBWdW1ueXBqMW5NOUFoOG96K2g1TDVGQldFWGkybVlDZVEzeDl1VWs1Nm15?=
 =?utf-8?B?Y2cvNmo0dEFtOE9BekZBNGdvREgwY3hLRlF0VWdDQjI0WGptb0NXaEVpTnNG?=
 =?utf-8?B?VUJORGc5aTdGODZyR05Eeml6OTkwc2NMUldqa28xbkRkSEpWazJYamtTQk5j?=
 =?utf-8?B?RzRHTW9pOHY0OHlCUGNPUHQxNTlHL1hDWFVvSzlJSWlPb0FRQVFYQlVpS1Jy?=
 =?utf-8?B?M3hSWWo2b2xpU2FrK0I5YW5mSytCeXFRVzhOUHBuWUhBU21venZlZ1NrTDRQ?=
 =?utf-8?B?Y2J6ZURDWDFZMzB1akpsR0JMVkVKUHMvUDFjWVMxUG5OUm9UYUJyWHZuMlAv?=
 =?utf-8?B?cEp0dTVRNXBFQ0tUSGN6Nld6dHdzNWVWYnRzOWNzOHBMQS9GSmNyK2ZYcjcw?=
 =?utf-8?B?SmJXUzIwMTQyalFKTzJWTmJSR1N5ZU9YWlVqeTdrSjNWSkg2TnJXQm1IeldK?=
 =?utf-8?B?Y3hpdW4zU0JlSzBxL0d4MnpkRG5zSXZ1MjN4aEZQeDZ2Wjd0MnVkL0k0VkJx?=
 =?utf-8?B?ZmNiSk5QckM2N3hhbGxOS1pyL0grNURSUy9NZjc2ZEMySUorNnY2dzNmMjVM?=
 =?utf-8?B?QWw4SXhNSjc2SWpwcTNDL1c2ZjZycGdQdjB6cnRUdDZmeEd3VHIxZS8yaVhh?=
 =?utf-8?B?UmN4RjZsRC9xYmFha3ZJU2txM0hBL0cxRjNJSXFQVm5XVWhLUU0rQXg4d2Rm?=
 =?utf-8?B?STF1dW14c3dNY0s3aE1yMUZVTE9hMDlSTGppa1o4cVU5MWFpa1NiRWFHbU5T?=
 =?utf-8?Q?bJ8pNYDMZeQl4DegFOmJr3mBc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33949fde-fb8d-4baa-5865-08db9cf090d3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 18:02:04.0641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9V1jc+tKwYtnMG+3GyMEPpJwWXF1ULkfh3+GBdZcVbh2HSxrqLgmMd2cS2r8balXpzFCnVnlfNghYPLlYsPtiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/14/2023 12:57 PM, Juno Computers USA wrote:
> Please check the link below. These are with pcie_port_pm=off.
> 
> https://pastebin.com/aXbBHf3w <https://pastebin.com/aXbBHf3w>
> https://pastebin.com/xzdGbtuG <https://pastebin.com/xzdGbtuG>
> https://github.com/junocomp/debian-juno-tablet/blob/main/dsdt/tab2/dsdt.dsl <https://github.com/junocomp/debian-juno-tablet/blob/main/dsdt/tab2/dsdt.dsl>
> /sys/firmware/acpi/tables$ ls
> APIC  data  DBGP  DSDT     FACP  FIDT  HPET  MCFG  PRAM   SSDT10  
> SSDT12  SSDT3  SSDT5  SSDT7  SSDT9  WSMT BGRT  DBG2  DMAR  dynamic  
> FACS  FPDT  LPIT  NHLT  SSDT1  SSDT11  SSDT2   SSDT4  SSDT6  SSDT8  TPM2
> 
> Please let em know if you need any more log files.

I need to see a full acpidump, it's not predictable which SSDT contains 
the LPS0 support, and I want to be able to also cross reference the MADT 
(APIC).

Lastly can you please add these all as attachments to a kernel bugzilla?
I worry that pastebin is ephemeral and if we're going to need to link to 
your issue in any way we want somewhere that we know will still be here 
in 10 years when someone cross references a commit message.

> On Aug 14 2023, at 12:58 pm, Limonciello, Mario 
> <mario.limonciello@amd.com> wrote:
> 
> 
> 
>     On 8/14/2023 11:56 AM, Juno Computers USA wrote:
>      > Hi,
>      >
>      > I can provide some logs. Should I do it with pcie_port_pm=off or
>     without?
>      >
> 
>     You could do it with both, just make it clear when you add the
>     attachment description to the kernel bugzilla which logs are which.
> 
>     Also; if you try my patch series please make sure you test without that
>     parameter and indicate which logs contain it.
> 
>      > On Aug 14 2023, at 12:41 pm, Limonciello, Mario
>      > <mario.limonciello@amd.com> wrote:
>      >
>      >
>      >
>      > On 8/14/2023 11:35 AM, Bjorn Helgaas wrote:
>      > > [+cc Mario, linux-pm]
>      > >
>      > > On Sun, Aug 13, 2023 at 03:33:21PM +0000, Greenman, Gregory wrote:
>      > >> On Fri, 2023-08-11 at 15:34 -0400, Juno Computers USA wrote:
>      > >>> Any updates on this?
>      > >
>      > > D3cold support has been a problem area, and there are some
>     changes in
>      > > progress [1] that could be related.
>      >
>      > Yeah; no harm in at least trying this series. I'd love another data
>      > point with it.
>      >
>      > >
>      > > Could you possibly collect the complete dmesg logs (with a recent
>      > > upstream kernel, e.g., v6.4, if possible)? And the output of
>      > > "sudo lspci -vv"? And the contents of /sys/firmware/acpi/tables/?
>      > > You can attach them to the Debian bug report if that's
>     convenient for
>      > > you.
>      > >
>      >
>      > Yes this could be related but it will come down to
>      > 1) Whether the root ports are considered power manageable.
>      > 2) The system uses S0ix or not.
>      >
>      > whether the series could help as it stands today.
>      >
>      > Please CC me into any kernel bugzilla that you open against a
>     mainline
>      > or stable kernel and can capture the lspci output, the dmesg and
>      > acpidump and I'll look at it.
>      >
>      > > Bjorn
>      > >
>      > > [1]
>      >
>     https://lore.kernel.org/r/20230809185453.40916-1-mario.limonciello@amd.com
>      >
>      > BTW - Bjorn, can I have comments on the last patch in this series? I
>      > have fixes ready locally for everything in the earlier patches
>     that Andy
>      > gave feedback but I was hoping for some feedback on the very last
>     patch
>      > before I sent out a v12.
>      >
>      > Thanks!
>      >
>      > >
>      > >>> On Aug 3 2023, at 8:01 am, Juno Computers USA
>      > <usa@junocomputers.com> wrote:
>      > >>>> Dear Maintainer,
>      > >>>>
>      > >>>> If D3Cold is enabled from BIOS the tablet boots without Wifi.
>      > >>>> The only two ways to enable wifi support is either by disabling
>      > >>>> D3Cold from BIOS (not ideal) or adding pcie_port_pm=off to grub
>      > >>>>
>      > >>>> [   12.681303] iwlwifi 0000:01:00.0: Detected Intel(R) Dual
>      > Band Wireless AC 7265, REV=0x210
>      > >>>>
>      > >>>> This is needed for our new Juno Tab 2
>      > >>>>
>      > >>>> https://junocomputers.com/us/product/juno-tab-2/
>      > >>>>
>      > >>>> I also filed this under Debian bug-tracker.
>      > >>>>
>      > >>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1036633
>      > >>>> Thanks,
>      > >>>>
>      > >>>> Giovanni Caligaris
>      > >>>> Juno Computers USA
>      > >>>> P: (215) 509-5472
>      > >>>> W: https://junocomputers.com/us
>      > >>
>      > >> This device is very old and actually already EOL, so I'll not be
>      > >> able to get any support for this internally. D3 works fine
>     with this
>      > >> NIC on standard, off the shelf laptops, so I'd guess that the
>     probem
>      > >> could be rooted in the tablets' PCIe hardware or maybe the BIOS
>      > >> itself.
>      >
> 
