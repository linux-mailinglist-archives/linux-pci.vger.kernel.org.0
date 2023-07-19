Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4B47593A2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 13:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjGSLBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 07:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGSLBc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 07:01:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E2618D;
        Wed, 19 Jul 2023 04:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nq71Y44wyybsUA3JENGofK2gW5+LSE7iABXCHwrVPG/CAEH4774xW+elsNTXR3tHAjhOR5gaEqzrfrA6NPgdXctK39in7tyjQ9QTs5iwNu5y7EKFuCXS8LTRFruBojN66rxD/e89KXM6CP3gYksLnZ3c0BBVfKJm/8n6jXjyim8QQ5THT2ER0KGEkiGtb/1Xw+bPDOnWVCItCuUY78fQYg5JjqZpVuryr0bBTLFYhSpCsjVu6AGs41NPUb2EZ29eKQBa6fgVW1/k103Iq4i4Gj7dn0L9SBGgVnwszNaa/+ZdA10KWr97s8PF9IVu4neQ2MljT7JrkErIcjDOPwuriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygXQ49vV4DyCSO6ght96SqywBP2QwQjJ8yPMPR8hhBg=;
 b=MWbdA8NY8I/Rm8dz45915RBINwpqo5MZqbazsxHKYwZxEj50XPKDZXvVvtuYGMjm+x3Mmj5HuS6JNo4+JGdFd0paalhAguW80KeRCvYX3LU7IxY6pCyFxGCmhTR71UU61AGzHcYiCRoGPBjl4IavogqObY2IbuJlOpZZY2y4FJ0Bb7iLIjZd3xwKWFPhtE8AcPyDBcgpPTXBc1p8+8jV5tkUwSx4DAxh9mnkmtjRQfE9T2FmwiSbyfCLhHktzyFqGTF8B+0eVXSbfY8ODjaximHw4nlElJDksU0UHwjDnr8j/y/1hsIkRVVs4Per/lyNFmLNJD/pR40m9bHjpcMKNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygXQ49vV4DyCSO6ght96SqywBP2QwQjJ8yPMPR8hhBg=;
 b=Fw/m/Aa+wMiRKlMH8GxsBaTXis3hv2vZRLaTFNgSM84zFhPuiGekbNBuMraF5TPwjCWdXipn6ZpJk9aG8BbvDMXg19Qs6hHwk8bzEriwh3TASUyceFXr2jBklmaSiBN1X3W30MnzK/XiIkZN4/x7sUOBlti0/SxKwd5eORZQD61IPdmjW1c78WmOgDvs7XBVfxpbGiLgY29YFryZtEq0r2454u7RdDorkv6EsSxePWJQ57zOAAzdVXnakSHv9u43n/hQ3HwXIRMZfoHcSfmd+pN7ICxLImbVnqeLWRk2PbXpv1P72S7azK98n20p3HDfvfUBohT2i9rDosPRfNwSwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 11:01:26 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b1:f0a0:1b20:1bf5]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b1:f0a0:1b20:1bf5%5]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 11:01:26 +0000
Message-ID: <43a9ab32-c030-1906-7e7d-c529e6c9c70d@nvidia.com>
Date:   Wed, 19 Jul 2023 16:31:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Sergey.Semin@baikalelectronics.ru,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230718110913.GA475601@bhelgaas>
Content-Language: en-US
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20230718110913.GA475601@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::20) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: f9dd335d-2f40-4e9e-870e-08db88477f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1GvXK657QBt0bfypeALL3nnnjVo1Nr2+EZ47SnNbpC9F3RyZhQJSdqEjn7kAxf7dYB13Cc9FyYaTwD/Mbz/WH23nxmE4gkhBd6iOjQLbSKjA8qHsT5e0HmdqAnrywEnXPbPV8SFqamN06yapmfuZBBS699HL/rAUyqr5YjFEuWVXPcAkQfKdLTUMGopBiH5HcNZlWWBaACL5UMvL7IcKZHOrehXLH8Fs7q2BAEwYhlWT0UVjIpa6WD0H73387b12lSsxvOZRqp3x37KhVs2p9eI70B+n6+DT6mWOV5a08/KG56lAW2VlKX3og5SLLzW0Cu0FNPPTs8V+nZH0El3I5sA42d8jWa3SdS1S5JV5PVdRrhigrWOtGziTsDgca/LEkNJM+7O8wcJEV14gQ0dZZyIDTGkZbtbyD0BRWNFQASokxh54wN0/UDMYHLt18dCUdqwGuxP2cUPw6cE6XFOBG+GUtK+5nRqz0vMpParPZzeBOjeEUTGXuoZte1c99ggvcKHuVUWT6FRU3GERU8b/2V9hNvpghZITkttNGtPrb2CHzNBLpDbmJj4FvNy28A1eFqSG5lBD/iw50a19iq9U1sPx27t+jUaJNhnwNi8k5Sc4XvAlYYnpLlA/VZ+ki7b/t7t8LhvU7Fe8QDUmpaUhdBbWPGlhv3j9pxoA94ow248LitfQ2GOMbWgq6eJam/8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(31686004)(478600001)(2906002)(6486002)(6666004)(8676002)(36756003)(7416002)(4326008)(6916009)(316002)(66556008)(66476007)(41300700001)(8936002)(66946007)(2616005)(6512007)(38100700002)(966005)(186003)(53546011)(86362001)(31696002)(6506007)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czRHblhKNlQrQVdBdWtLcVFKL283L0QrdjlILzFKTHBvMTIzcHZ4enNQWlpQ?=
 =?utf-8?B?aW1TZ3U3YkEwN3dxQjhBeUdRT3FBZDJ4RWRRaVZrMzdaK09uS0owVnFtZUV0?=
 =?utf-8?B?d3BWbGdLMEYvU3RlNzJOR2FkRGl3Wk5OUzZYT2ZHSW9iYmx0RE1aZE5uVVBD?=
 =?utf-8?B?OXFYSGxPT1lqNnkrbXJwQlZQOVc2VGdHWFFLMUJUNDhBTVgweUZPR05YMXVY?=
 =?utf-8?B?L1R0TlB6NWVVSXl2ZHpleUdTWjgwc0x2T3dqS1l0aW9Dd2p1YStqcFRSOVJZ?=
 =?utf-8?B?WU8yK21FRXFYcHlhampYY2NJL2wyQ2F4NGVzVUgzWU43Y3lNUUNvMkpLKzYr?=
 =?utf-8?B?YWM1WUtZV0pIVTJyZlRFcTkxREZ4bSt4U2dLVlpoblRyTGg5MGt3d01RdnU3?=
 =?utf-8?B?NW1DblpWMDU0ZW5kcXE2M0tHaWlFR09kRjR6RWJiQ0g1NzdjdmtZc0R1bnIw?=
 =?utf-8?B?dC9XdEdGTURmeU4zaUxhK1l5M1dQem1RT3FFZlZSWkZyRHkwWHJEWk90bnl4?=
 =?utf-8?B?ZGVRbXh4UklBMWFXWjVWRndtN01BSEZza0RLV1cwUXpIOVIvSHRzZzVJSTdE?=
 =?utf-8?B?NldaRFluU3NqMGZLL2NLRFJGR3NBTWxTNm9hbHlNMXVnOGd6ZjVKUkEwRHR3?=
 =?utf-8?B?ZU9nZnVTaHVhK1ZFeUQvNzAyYllRYmJhb29hVHF2WlBrQ1RYNWlJQkQzZzNx?=
 =?utf-8?B?cFlyS0d2eFE2d2RGeGNmRGc3bWdHVW0vbDBpNFRzWXNBN2IrQjRudVAvWVR6?=
 =?utf-8?B?WHRXSHdxRUpaTWp0QjEyV2tUbHlyUkdvL0Z1SlMvOWxHUXJGdG1VVFdNcnV3?=
 =?utf-8?B?NFVodkI2KzdmZHFmTzU3VVR4OCsyMHZkNWRlMHEzVjBnbEtUUk5Mb0JLOEMx?=
 =?utf-8?B?R3FSTmNCRWFRR0N0NG5FZm1vdkVrd1RjcVJyNWFDYVFrY0pjYXpqM3FFbkh6?=
 =?utf-8?B?eFJvNVFmbisyb1NNbXN3YjhTR3ErZC9OTk9sTjlFdThTcFArV3dSallLVnhJ?=
 =?utf-8?B?ZFBjam1HQjhQbWNSYzBTZ3l1YkJQeEFZa2lLM09TTWNCVjFxOEcySUprUkZO?=
 =?utf-8?B?STNnMEw1QUFxV1JHNG13ejB6TWh1V0tRWk1DaGtmUWYwSEZPcGlxV1pJNm1T?=
 =?utf-8?B?bDhjUUJLUVJLSHM5U2FTSk0rRzRUUmNDSDN3UGtia1FWVTQ4RksxVWh2RjI2?=
 =?utf-8?B?d2xnSXd2bDNMTTBlbndSSVZHNWtKKzlmb3VBQnNCb1p2VVlhUU40YlBybkM0?=
 =?utf-8?B?eGdWamNtelVDVDZrWGVNMzJXWlZ6Yi9OS3NpVStUdEd0WTltc2VzQ21WZlg5?=
 =?utf-8?B?SWx1bFBaZ0pKVzBsUzlTMk1FeDBaVndtbS9GbUhEdk9vVCt5dXZUWWZWbzV4?=
 =?utf-8?B?Z0RuNW54WTlqOWZwRDVnNnF4alNsbW92cTZUOExNMlpBSmhid1YxY0ZZUjhO?=
 =?utf-8?B?NDdWV2pmL1VIOTNCMXdSMXF6Mk03dysrM2xIdk9ZT1VtempUdlNFM0cxdHBm?=
 =?utf-8?B?Z0tpdnB4UUExaVRPVU9yUHJYbmNTZVNTb1RFSmdwZnpZdW8rQmtYNTRNSERQ?=
 =?utf-8?B?VVZlWEtWbGtmczZBVTZ5UnFjdklkajdZMmNxVmxMR2NvanVQVmRvL0dxaVFK?=
 =?utf-8?B?QmNNV0tubFI5ejZmQWpDd3p1RnpnVHFlWDk0c1pJYU5TZitxNUVhSnkrTHhJ?=
 =?utf-8?B?SldmWmdqb3QvcUhTcndUeWhITXFSUkQ0dEZWMSt3Z05kWkJNZHBrNk8rZmtk?=
 =?utf-8?B?Z0lWbCt0RG0rZDRmT2JaRDJoNnpUM2srdWMvcWxhK0ZhVzRKWE44bEF4c1BL?=
 =?utf-8?B?aDFwNWdhRm84UDI2czd0dVZHcVVoeVlpS01FQTRNbFFKSmVkbi8wWXVwWmZ0?=
 =?utf-8?B?aXdIaFRia0pXTmF6RzhzdXl3NngzR0NrMlNyTEpvZCthN1V0eE5xUDVSRFZJ?=
 =?utf-8?B?UVF1bkJGYTZmTENobGJlMmhUcnZwRnpuOW5HYXZIMExXRjlTandRalR3VHZt?=
 =?utf-8?B?YUhsQTY3REt2bVAvUEptd2ZzS0N4SjF4a2ZDV3ZXWHBueHJEVnZvSEJvOENI?=
 =?utf-8?B?cndsTEVnNnR2WkUrS0VUVVlOZk9yME9DSXNkZ1FnM2E5d2JQanQxM2d5aWhh?=
 =?utf-8?Q?qE0bKmyUyKv24wp7dc95MHQ4A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dd335d-2f40-4e9e-870e-08db88477f27
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:01:26.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IE8we77jzwfhh2BVYDJCNb/LEPNyXwP7xUHOU8xjIobso8DqkDEhUkAehe/KU3VQvtQirgkBx/MwBSCCINoGLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/18/2023 4:39 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Jul 18, 2023 at 08:03:47AM +0530, Vidya Sagar wrote:
>> On 7/14/2023 3:09 AM, Bjorn Helgaas wrote:
>>> On Mon, Jun 19, 2023 at 03:56:04PM +0530, Vidya Sagar wrote:
>>>> This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
>>>> support for 256 Byte payload").
>>>>
>>>> Consider a PCIe hierarchy with a PCIe switch and a device connected
>>>> downstream of the switch that has support for MPS which is the minimum in
>>>> the hierarchy, and root port programmed with an MPS in its DevCtl register
>>>> that is greater than the minimum. In this scenario, the default bus
>>>> configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't configure the
>>>> MPS settings in the hierarchy correctly resulting in the device with
>>>> support for minimum MPS in the hierarchy receiving the TLPs of size more
>>>> than that. Although this can be addressed by appending "pci=pcie_bus_safe"
>>>> to the kernel command line, it doesn't seem to be a good idea to always
>>>> have this commandline argument even for the basic functionality to work.
>>>
>>> I think this has some irrelevant detail (IIUC the problem should
>>> happen even without a switch) and could be more specific (I think the
>>> problem case is RP MPS=256, EP only supports MPS=128).
>>
>> The issue is present only if there is a switch.
> 
> So if there's no switch, and an EP that only supports MPS=128, the PCI
> core changes the RP MPS setting to 128?  Just based on reading the
Yes. The code after the if condition here takes care of that.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/probe.c?h=v6.5-rc2#n2049

> code, I thought we would leave RP MPS=256 and EP MPS=128, which would
> be a problem.  But maybe the PCI core changes the RP down to MPS=128?
> 
> Bjorn
