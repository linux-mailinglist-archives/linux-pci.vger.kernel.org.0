Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EC060E931
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 21:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbiJZTmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 15:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiJZTmF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 15:42:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2B6CC817;
        Wed, 26 Oct 2022 12:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdfIs0olpiSEdyPymn++XcFzlUOrswCJuhFxgmILgkeSLaZCgJ4iT1fDIhcB9Oqkzx1CRnKwleIbBL43eshXnT0oWTslaj8gbCBGZNTvR+1ein3ZSdNGMKVPYDCBmWSa5u9aCMerYwY0uL7U/axhj4hv4OyXMFHr/fgsLLj3NepuGkJIcz0Rls+j0ceByYL8rhGfE7duxTIBRvcHbjmVMYaebh1RgiQItMpCCQfcZAtij3OS8OuE6u6xrh46tYqjndM3l3cHDVRlVSinNqIxfei0tCqvcI8yDYFrcDg+QZ1fkEFANvuGLSIMOF6o1XDL3OFu63cze/Ro/qpa79oTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKA+FbUTGiU1bgkmfehT/I/OT/885dF9//Qyl2lfLHs=;
 b=lEyXkBDVqzBbpO7jnN7BelKPftqx1XYF1OdYGGN7OvcBIBWn0ShFYYe7x9GyjSIT67N3TeGhi5kemwySvKp1AcBuKiAFvuI0Igq0s4txSly44Y5M+6ciV1TrzftFgqT71e/+IQQUdni/zYyNg9eBe6iIMxJRkax4sLPhnQs3cC8462G8Aao9677hNvSZwJ9nP7cb0Dg6a99O8kTsATGQExAWXPGGYkcz0ZjdCY3biLFyW4Aeb6BVlSqqHufoFeZqHVqdgxDNji8E5r0TJfo4J+fHSq0oMKocMrBeAlLEWpHFt2qg6ftzOkNbwBslwgUjnL74rL+eSagyUVAJrAAMCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKA+FbUTGiU1bgkmfehT/I/OT/885dF9//Qyl2lfLHs=;
 b=Xzed8IaP453Em8gf5TXEcCQVqfP1qX2bhgZzX8HQNaIvhUDBBy5+j69tEjRh2JozESK+wpMnUkzhnV2rID3HGo20br4MuvdDpHrboUkAJQFY1AnvOeqIxPGluZUYqVo04QTEMqs+SJeftyIj3DBDLkD7vIib1/soE2pjZiR2EQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 19:42:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5746.026; Wed, 26 Oct 2022
 19:41:59 +0000
Message-ID: <00469c01-643e-e88f-22ba-afcdd98fe121@amd.com>
Date:   Wed, 26 Oct 2022 14:41:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221026190909.GA760069@bhelgaas>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221026190909.GA760069@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:610:5a::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e157c3-323f-47fb-0856-08dab78a25b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLXhbGkFU393yRzZyv9ZWPgVmgHOpGhcRE9hThOw93v6Qch0Rv5nOFZxmt+78H7YBgujScE3r4mcueqk7Lotg3pv7tgXSmmbsv6ghhjQfCwyQAcXiuRUDRnKF056sNpcURhhMJNZc6rsSmGlNR0JAV+JVBF4zfdTvibTnKrkvTkyVS6WB/XQJOlFTaUc1l8oXmRO0cqDosBi0rR9iMdwyF4F2W8RS6CRndlkQX6r7beE8RlaSsu4PKR60H8KvG469mnsZxlr6oXWqa5D1WrB3yWh2eHYscN+OJG7oIU2m64F0DeremrA2F/Upc+A1dX9xJr7Ths0s75u9ZYusgTNKkXcoQ0y04NvNhsVQkTtx6pP3BJDifZTsFEUUd3JdtINrWidTP2ChtRCKuqZCJjPnfyE4zeau0oCUNHVD0YByPP1wR+3Tx2qO2Dv8dKorKU2UdGxUs3YbD494V6Q2dRiAIjtLfWUIgvc40y7k2lcb+b8TpYiQmQ9Rof5eokdFLog8dZx2fxCuXfuDvh025R0cBONzmjCMhc6qrzl8cGQx4A/jByTVlgY9D6SZECcNMbkEneJTsBm2vwENBWmqjTrZx2j6pkpoBsMBvVf5+SmxSqvf/3J3SmsELyPHr1qkaP2a6FzIRMuP0P1EY7FrfG+aWAyq6fiCUXOsEFFMPiL/qtZ+Kena3ze593jwT6F58NkPFUqdZ2eRXgvBq8FUm9mXpxDHGcJalgOtbfozQvuLhU3Myw5kNliRDX6AQXwpZHXTitnKwH2v5IKPdJdW2hMkUi77ZY4LR1N5ZgG1O0ggQa3T4ZMrhDRNy2oLtYgW0fRsq0qxCIVOqrJsYZUH74Gy75Ey0sL9ESSE3cMxFfXLpzdWedMPrOWg3eepwkYqjtX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(36756003)(53546011)(66556008)(8676002)(4326008)(6666004)(6506007)(66946007)(66476007)(19627235002)(316002)(38100700002)(6916009)(54906003)(2906002)(186003)(5660300002)(15650500001)(83380400001)(31696002)(86362001)(66574015)(26005)(6512007)(41300700001)(2616005)(8936002)(6486002)(966005)(31686004)(478600001)(45080400002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEgvVERoVE9FK0o0cW5Ea21HMi9iQnd5V2FvRHZtNmhPbFF6aTBkOExQN01H?=
 =?utf-8?B?b1psK3pzTDZjUFB4SWVSR3RBVGVQb1dhUVRJOWJkeTYzWFBmcnpWZG9YelhS?=
 =?utf-8?B?aEUrM20vZWpxMVdSaWVCVXViYnJtZ3AzT29tcVFrcmZndGxiSERCR0NoekRV?=
 =?utf-8?B?WFhPeFR6V1R5MHFtK3RwV3drTzZBUktvYzAvTTR0ZFdUbnNxZERNWnY5eVNH?=
 =?utf-8?B?OGg4aFN6ZUJrc0N4M3hlcExrYXc5VDNLbWE4REdKeXpkbHlMcFFXRVkvdWhS?=
 =?utf-8?B?L1lXVTJKRkdCWjBJTytzZ2pmQlBqRkU4SzNick9iczNYN0Rncy85UFd6UkpI?=
 =?utf-8?B?aHR2VGpOTjN6NmZVdWdGZExWSWp4dVhjKzBjV3lQOUtYaDlCZXQ4c1FpZTJh?=
 =?utf-8?B?dUF6aTRWbEdMdTErUzRMdmxZcFB1ZXdvM3l3SjlHOXRYZ2lqdXV3UHNWS2Zl?=
 =?utf-8?B?ZFJkZWRSV0p1K3A0bG52ZWlSVmFBeHdiTnB6T3FtZWR4M3FOOGRBYW8zeVdS?=
 =?utf-8?B?ZmtMRjJIWEMyaDZKN2U3ckkvdGtLUUFQNUdTZHRic0xzV0ovalFyclFNTFRV?=
 =?utf-8?B?TzhJamdQaUlRODZVRXJNRm5SQk5oSmdvQlYzSG9idlhQenJKY1MvbUM0bEZN?=
 =?utf-8?B?aUgrejhPSkxkd2sxRHprcjZMVnl4cVZlR1F0OEFHSWh0eDExa0lReE8rQWhi?=
 =?utf-8?B?bVRETGZUaGFxcUZSaEJ2NmVobnNEY3BIeVBFRDBOSFRXcWNqMWRjeE00b2dq?=
 =?utf-8?B?a0VFSWlqZ2N2bjl1VTlwZWJaOUt1TzU2M1FtUGVSRXJrdzBPcENiT21tMU5s?=
 =?utf-8?B?N1dIWFowc0hoczVkSTUvTVl1eHQxKzJLWURCZElYazBRMnRNMWVoQ0krVVVY?=
 =?utf-8?B?MVRhVzJwc3ZUZktJaDkrNzNmQWNZMDV3a1piTlJ6R09RVVlDcDZkNUZMcnBz?=
 =?utf-8?B?RDB5Mm9hVEVhZWJxQUxVTzhPd2R0OEUraXZkRDNpMkFqMTlaV1NIWVlyNlBG?=
 =?utf-8?B?MWUrcFRkYUw0bDdWdk94VWpvSXV3SGVsRm51bnZHamk0bzFpaG9CVnk0T1E3?=
 =?utf-8?B?R0NadnFjQUUreGUxREE1MDAvaDZnTW10akhIeHMrNWt5NHhjU0xFdlUweSth?=
 =?utf-8?B?WWpPbmN6NUd5ZjBsUzl3VE91bm1qZUFHUmt5NXluZkc1ZGRmeWtxRGFpN1g1?=
 =?utf-8?B?cVpuamVRejg5R2UrcmluWk9Yc0JDVURteTkzKy92T2hFby9uRGFoeEVSRVR6?=
 =?utf-8?B?TVprN29zSjZVOXg3dTJlWVVES1ZkbUczTlJWQlVGMkpESWJGYi85aWc2Zksx?=
 =?utf-8?B?R0ZvdG45M2tGOFFvYy9VNTZneUgxcmIvanp3Q2NxUkdKdDkwUWl0ZnhmUVdE?=
 =?utf-8?B?b2NJLzAyaGovMVRpRmo2RlJtUnh6dGhDR3FOZk95KzdRaCtrOFRNQ3F0OUZR?=
 =?utf-8?B?YzJ3T09OZlZmMTN3SzlrYjd0TGhnbDk0aEc5Z0QwM2RSZzJsWk1CMzB6c0tW?=
 =?utf-8?B?Qno1R0p1ZVd3Q1RKNTBzdUVVQUNVRE9sdTlGdjZqUzc4aElIWE00eUpxcVdW?=
 =?utf-8?B?V25pckhvR1M4TmUyVXI0U3l1dzNMN002ZjdHOHY2TXV2TTU4OWdOQkNTQisz?=
 =?utf-8?B?S3d1Umg3QkFNd0dMaVJmSHVVTlhMSVBmYmdnTW91citreDNVTVRDSE1PZUpr?=
 =?utf-8?B?UUt2dlF0YXl4TTlzRDJjaWpTZ28wbDNWRUtSL3FGOGhLVlFHWXc0NzJ1Y3Bn?=
 =?utf-8?B?MHpZS2tiRXYrTGlCQktyeE1VMklleFMvOXk5K2xRNC9hTTFldisvTDR4cGth?=
 =?utf-8?B?cy9hTlg4QnBkQmwzNGtIU1k2Ni9PeU1YRm1IZGFWUDFHQ0xOcTdUL294OUVX?=
 =?utf-8?B?cUhNaGczVjQzeVBoQ01obGtRWjhISExzaVBqc0RaVUxSNU8rS016TXVkU1I4?=
 =?utf-8?B?ZjA3R2hYVXhvOFdWKzRSa1ZqRCtmZGlhQW15b2cwUUJ1dFU1b3dlR3c2VWh1?=
 =?utf-8?B?am1CYVJXazMrQ3hkQmhVME95ZDBzbFdQUE1GQVVrRWQzUFdFTlhVM0VvMWkx?=
 =?utf-8?B?OU00VDZMcHdlemtLckFiWDlaamJZcTFMRER3d0hVZzRqeExqRm9Sd2U1Q2Nn?=
 =?utf-8?Q?vZlbmBYsmsAFa6OR5TRtubCJC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e157c3-323f-47fb-0856-08dab78a25b2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 19:41:59.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYRWDI1nI2VHhUDXwgb5we97xEyT1u52PIUkPgO9dst+GSiNSeIcexgUzfbVLjs22+9wpAQWZFVJURUuVOn5rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/26/2022 14:09, Bjorn Helgaas wrote:
> Hi Mario,
> 
> Thanks for expanding the commit log.  I'm sure this patch is the right
> thing to do; I just want to connect a few more dots to make it less
> likely that we'll break this in the future.

OK.  I'll pick up those two tags from Mika and Rafael and try to reword 
the commit message a bit.

> 
> On Tue, Oct 25, 2022 at 05:10:54PM -0500, Mario Limonciello wrote:
>> Firmware typically advertises that PCIe devices can support D3
>> by a combination of the value returned by _S0W as well as the
>> HotPlugSupportInD3 _DSD.
> 
> All PCI devices are required to support both D3hot and D3cold (PCIe
> r6.0, sec 5.3.1.4), so I think what's being advertised here is about
> what firmware can do (which of course implicitly depends on controls
> provided by the platform hardware), not what the *device* supports.
> 
> The OS can put a device in D3hot by itself with the PM Control
> register, so I assume the important thing here is whether firmware has
> interfaces to put a device in D3cold and bring it back to D0.

If you completely ignore _S0W, sure you can put the device into D3hot by 
changing this register but while in the firmware configuration I 
describe you won't get wake events to pull you out of it.

So the PCIe device will stay in this state until the OS does something.

> 
> I know we only get to acpi_pci_bridge_d3() for PCIe devices, but when
> the device properties and ACPI interfaces are not PCIe-specific, I
> don't think we should restrict it by saying "PCIe".

Thanks for clarifying.  I'm thinking I'll s/PCIe/ACPI/ in the commit
message to convey this.

> 
>> `acpi_pci_bridge_d3` looks for this combination but also contains
>> an assumption that if a device contains power resources it can support
>> D3.  This was introduced from commit c6e331312ebf ("PCI/ACPI: Whitelist
>> hotplug ports for D3 if power managed by ACPI").
>>
>> On some firmware configurations for "AMD Pink Sardine" D3 is not
>> supported for wake in _S0W for the PCIe root port for tunneling.
>> However the device will still be opted into runtime PM since
>> `acpi_pci_bridge_d3` returns since the ACPI device contains power
>> resources.
>>
>> When the thunderbolt driver is loaded a device link between the USB4
>> router and the PCIe root port for tunneling is created where the PCIe
>> root port for tunneling is the consumer and the USB4 router is the
>> supplier.  Here is a demonstration of this topology that occurs:
>>
>> ├─ 0000:00:03.1
>> |       | ACPI Path: \_SB_.PCI0.GP11 (Supports "0" in _S0W)
>> |       | Device Links: supplier:pci:0000:c4:00.5
>> |       └─ D0 (Runtime PM enabled)
>> ├─ 0000:00:04.1
>> |       | ACPI Path: \_SB_.PCI0.GP12 (Supports "0" in _S0W)
>> |       | Device Links: supplier:pci:0000:c4:00.6
>> |       └─ D0 (Runtime PM enabled)
>> ├─ 0000:00:08.3
>> |       | ACPI Path: \_SB_.PCI0.GP19
>> |       ├─ D0 (Runtime PM disabled)
>> |       ├─ 0000:c4:00.3
>> |       |       | ACPI Path: \_SB_.PCI0.GP19.XHC3
>> |       |       | Device Links: supplier:pci:0000:c4:00.5
>> |       |       └─ D3cold (Runtime PM enabled)
>> |       ├─ 0000:c4:00.4
>> |       |       | ACPI Path: \_SB_.PCI0.GP19.XHC4
>> |       |       | Device Links: supplier:pci:0000:c4:00.6
>> |       |       └─ D3cold (Runtime PM enabled)
>> |       ├─ 0000:c4:00.5
>> |       |       | ACPI Path: \_SB_.PCI0.GP19.NHI0 (Supports "4" in _S0W)
>> |       |       | Device Links: consumer:pci:0000:00:03.1 consumer:pci:0000:c4:00.3
>> |       |       └─ D3cold (Runtime PM enabled)
>> |       └─ 0000:c4:00.6
>> |               | ACPI Path: \_SB_.PCI0.GP19.NHI1 (Supports "4" in _S0W)
>> |               | Device Links: consumer:pci:0000:c4:00.4 consumer:pci:0000:00:04.1
>> |               └─ D3cold (Runtime PM enabled)
> 
> Can you label the devices above to correspond with the preceding
> paragraph?  I assume one of the XHC devices is the USB4 router, but I
> don't know which is the Root Port.

In the above example there are 2 USB4 routers, 2 PCIe root ports used 
for tunneling and 2 XHCI PCIe devices.

> 
> Are all the devices relevant to the problem?  If not, prune the ones
> that don't matter.  It looks like the domain ("0000") could also be
> pruned out.

They're all relevant because links are made between them.  If the XHCI
PCIe device was not in runtime PM, it could prevent the router from 
going into runtime PM as well just the same.

I could remove one triplet of devices to keep it simpler (USB4 router, 
XHCI PCIe device and PCIe root port for tunneling) but all systems I've 
seen have 2.

> 
> If you also include the _PR0 and/or _PS0 methods, we'll be able to see
> why the current code doesn't do what we want and why the new code
> will.

OK, I'll add a line/assertion which have _PS0/_PR0.

> 
> What determines the device links?  I assume there's some ACPI
> information that connects the USB4 router with the Root Port?

They're created when the firmware node has "usb4-host-interface".  I'll 
add some lines to describe this as well to the commit message.

https://github.com/torvalds/linux/blob/v6.1-rc1/drivers/thunderbolt/acpi.c#L29

> 
> What are the "D0" and "D3cold" annotations telling me?  What does
> "runtime PM enabled" mean?  Is that determined based on some ACPI
> methods?

D0/D3cold are tell you at rest what power states each ACPI device is in 
as read from /sys/bus/pci/devices/{bdf}/power_state

The USB4 routers are in D3cold, which shouldn't have occurred because 
the PCIe root ports for tunneling are in D0.

This only happened because runtime PM was enabled on the PCIe root port 
for tunneling, and runtime PM was enabled because acpi_pci_bridge_d3 
asserted that it supported it.

> 
>> Allowing the PCIe root port for tunneling to go into runtime PM (even if
>> it doesn't support D3) allows the USB4 router to also go into runtime PM.
>> The PCIe root port for tunneling stays in D0 but is in runtime PM. Due to
>> the device link the USB4 router transitions to D3cold when this happens.
> 
> It's probably obvious to PM folks what "going into runtime PM" means,
> but it would help me out to describe it in terms of the hardware state
> of the device, e.g., D3hot or whatever.

I think a simplified description here is "the device has been put into 
the deepest sleep state that it can wake itself from at runtime".

Suppliers can't go into runtime PM until all consumers of the device 
have done so.  If a consumer doesn't support runtime PM then it will 
block the supplier from entering runtime PM.

> 
>> The expectation is the USB4 router should have also remained in D0 since
>> the PCIe root port for tunneling remained in D0.
>>
>> Instead of making this assertion from the power resources check
>> immediately, move the check to later on, which will have validated
>> that the device supports wake from D3hot or D3cold.
>>
>> This fix prevents the USB4 router going into D3 when the firmware says that
>> the PCIe root port for tunneling can't handle it while still allowing
>> system that don't have the HotplugSupportInD3 _DSD to also enter D3 if they
>> have power resources that can wake from D3.
> 
> I guess there's a theme here of looking for concrete terms that I can
> connect directly to the spec vs abstract things like "going into
> runtime PM" or "root port can't handle D3" (which I think is actually
> saying something about what *firmware* can do).

The UBS4 CM spec doesn't describe the ACPI relationships.
So I'm afraid the best I can come up with is what Microsoft says:

"For the PCIe and USB 3.x software stacks to establish power relations 
with the USB4 host router, device-specific data (_DSD) for the tunneled 
PCIe and USB 3.x ports is required. In the absence of this, the USB4 
domain may power down without coordinating with the tunneled PCIe and 
USB 3.x devices."

https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/usb4-acpi-requirements#port-mapping-_dsd-for-usb-3x-and-pcie

"Runtime PM" is the power relation that is used for Linux.

Back when we did dff6139015dc6 earlier this year the Yellow Carp systems 
didn't have power resources declared in this particularly firmware 
configuration so the behavior caused by c6e331312ebf didn't negatively 
affect anything.

If they did, I'd like to think I would have done this right the first 
time =).

> 
>> Fixes: dff6139015dc6 ("PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2->v3:
>>   * Reword commit message
>> v1->v2:
>>   * Just return value of acpi_pci_power_manageable (Rafael)
>>   * Remove extra word in commit message
>> ---
>>   drivers/pci/pci-acpi.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index a46fec776ad77..8c6aec50dd471 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -984,10 +984,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>   	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
>>   		return false;
>>   
>> -	/* Assume D3 support if the bridge is power-manageable by ACPI. */
>> -	if (acpi_pci_power_manageable(dev))
>> -		return true;
>> -
>>   	rpdev = pcie_find_root_port(dev);
>>   	if (!rpdev)
>>   		return false;
>> @@ -1023,7 +1019,8 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>   	    obj->integer.value == 1)
>>   		return true;
>>   
>> -	return false;
>> +	/* Assume D3 support if the bridge is power-manageable by ACPI. */
>> +	return acpi_pci_power_manageable(dev);
>>   }
>>   
>>   int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>> -- 
>> 2.34.1
>>

