Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562AD62B153
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 03:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiKPCcJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 21:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiKPCcI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 21:32:08 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290729811;
        Tue, 15 Nov 2022 18:32:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCD9smEeQo7vBSyyUfFRoxIHqSkBIJdEw7rRZLBcMxHj9q87fM3zHvirgllAmC3AMGROEV1AW3rbnVITAT55esDd/6jPXDnGSvKe0Z2csXgsMTu2pe4m+6EVMB/MwI+F93bZB2saHlRODoR5hUOnaiwtVkx3GiDCHkA2xu6mI7SYt2lX1ozJ7hT4wgeMJY1rlWcb/dOSGhzm4BmFwaXU1c1tGHrFlkUlBzLhAO/pGWzWxfXuJG1GaMzchetMLRzOQI2wZmssjnCuq2HtBaHLogf+L592pJ+PxIoKz1T9wCD5//+iRb2L/ZrmHSfpFNEhZkcCFm3gX60kUY6wHNDHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19Sd/HYVfRK/vOVxOW1CuJXiy+MU0JJyjrDDxzUrNOo=;
 b=mWJAqutMdf9ENzHoFs0GpLoYSG7j5u+9E4XTuWk9rkAGbiq5DC/JU0IiQHGn19cQVjtX1k4ftmWqnhkc+L65356SxkXShctZpCMWYn8MVrJCDLXAhY4GbsrJvJZTCRD7r/A2dmRck/a9E49iSiL9Z8UNsK5KqnuibV37U5i4xIG8iGtdkg02P78y8vq33OnlYZNvBnhFT95ZnurrmyaSoIztCY+RZLg4Z1EQNt8vyfnYRpp6nqq2Qi53kn4bv5FEA3rMUlgJ+mlgdMgsa7zqsOgyb4FHO2795rwZR680km6Ircv+ivsLvxJbbvTKYDO/sncTFj60pNA9pNyH76eV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19Sd/HYVfRK/vOVxOW1CuJXiy+MU0JJyjrDDxzUrNOo=;
 b=i7oSnaWdJuH41BUqblmRnxGftWTBp/BOhqJ4mSFMtuzqn6FMEOW0yp+QWO/4G1BlQoP2epjoO8Z6qXEn/jr6vrt93bsYQdTKQmtPBX6Jueztnrb02LPQMcRK5HP+9QVMFJKUiOaDZTFYwbtvFu6wLaFAu7bQjgzNS90jGrLPK28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 02:32:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 02:32:04 +0000
Message-ID: <d2d5e368-abbf-e420-7027-27ba412251e7@amd.com>
Date:   Tue, 15 Nov 2022 20:31:48 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221116003739.GA1061657@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221116003739.GA1061657@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: ac078a07-1627-4cd6-db4e-08dac77ab778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yilGFSbSB8clEpGkmY+vNPYz7GHNiKgncPPatdvVq1M0mLvsaGlFm9EmJzwHvEjzjwUbTbMxghwxSJTt7R1s9EL5MWN6d/cdqf+VQw1pP1ZNinMQztQrO2K1E9tXnx8O/qCNa/fUVZ87MMwILhI0Wab7VFzltp8vOQKhhYQ7x1cyTeAOcNDWAN2CQCg8ceTUx90Phbxoqxfk2GBUslvjEByS3yMLo1I2lUMjKnDbYay3jVgDf78Q445lvXCbqD4cTzE7uVn4CfOektsDZ/ETpZ/KOMMEwzuorroSOaBtBQ/cX/nBEk616uBoR/9HpCLPXpIjh2P5KlEPqfwg7nuQg+1PBk+brGX4/w3oCPh2mnTXmwjmoh7HUlzaC1k1ilrG9LeYpYx43vA1JzEIf5NXeFrLMVXy5fhFpYIKCbS00CXSIVUZIhxlxZ/hMB90B72PjDlovXVLLfDfBnYvrK+Rmd7N2GVoHxasP6tLQRrBw1nbGa3l59UszpeXVSpmMbSKcFqLIhAMVa31X/0XxDUDF7F9Zv/TlwPY9ruESMAEVsr143BaCviS7SAaXdHDUHcE1YYLYrl+003dQAPJcv0NYJDwjXf6KA4Kl08EOcQn/08kEJOrZuDmJ+XSYsEIzskqcdEnpGuU3AuMAQoAyn6+GSl/vIKWMKcxCKPlJwDzievwOekoD2G3jxgJ4HgWCnUfqa0BQI6HIkcrCFX99LuTG7YwAymTHUZeDceAvBeG06AgIJERn1jEki2KJSHXJ39BSdzPO6Tr22Gu6QI/NoUpg11nvx/qf8hERoCasOw0OamZx2HWLLvXI5+ls9IUKBc8rOIYSROQ5/t1Jsh2wneeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199015)(316002)(6512007)(26005)(4326008)(66946007)(19627235002)(8676002)(66476007)(53546011)(66556008)(5660300002)(8936002)(186003)(2616005)(7416002)(41300700001)(36756003)(54906003)(110136005)(6506007)(2906002)(31696002)(86362001)(38100700002)(31686004)(478600001)(6486002)(966005)(6666004)(45080400002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUhqT1MxbjZTaFpQQWNYb3cvWCs1NFNEUmVwSlU4NHpBZEt1d0FJWFp0UEFH?=
 =?utf-8?B?b1YrRyszNEJGM0loNWgzbzhsYy9xRUhIUFd1cW9kM1VabXVxenF4RDNQSmN0?=
 =?utf-8?B?dmlndmhMcGtBVXlGSGxDV2kwdjNLVHlmR2RaemlnOVFpVk4yb0JBWmNvejJY?=
 =?utf-8?B?MTlHRFdQYXFmVFZhaWVROFVjY3ZjSnAwdTMraGs3Y3VlbG1abm5Kb2dYcVB1?=
 =?utf-8?B?TVp0WFZFMXhhZDdUR09nQ210VWU2OHNJZHBaQkdHS0FFRkhOQm5STHlnbXB4?=
 =?utf-8?B?Y1JiTG5OdkM1dHZYU2ljVVA5OXQwcVdsQ21HVzF3TUZnc1d4OFNGN1NrWWg4?=
 =?utf-8?B?VXdOaTRRUSs1UEgwcHplYzA3RDA1TThDb3FjaGx1ZUtWTlQ3WjVDeDNrME4r?=
 =?utf-8?B?Mk54cVA3RVBKU2xkRUdTbE43YWlNL3FIK0RFMmh1ajVPbEhKUTBtaGJYYVlt?=
 =?utf-8?B?QXduck13MDFVcDl5TUd6TTIyOEpXaGtDRVVibVRWcnhZSngvNktzTFBPVVlu?=
 =?utf-8?B?UHpnVFQzWjlKWnJOSHk0TVBNd0RuY0hCbExsakVaMnR0WVR3Zm4rVWRCY3RJ?=
 =?utf-8?B?dmhyR3F4TmtIZTVBTlF4NXFvWkUvZ2hodTI5ZTd3RWhYbVZXQjVOWk1xNlE1?=
 =?utf-8?B?ak9XdXNlUzZXT24ycFNBeTh1QlA3bTZlc0pHdDJ5Z3Q0dmFiOENBTHB4QmtL?=
 =?utf-8?B?c0VjTzZvK3g0aVFyNHVWdVhiSWNUNnFzczNiZ1dDbm51YkJUMUxuUy9HM3FC?=
 =?utf-8?B?Z0M0UmFZblAvdDFUTFZoeElLZ1JUZlcwOWczc0VyeTk5aW1FUzd1V3ZVQ3BT?=
 =?utf-8?B?allwSzRMYzBjT2dTOWs5L1BsdlR1Yzh3U0V6R0RZaElRakxiWmQ1c2N6aUt5?=
 =?utf-8?B?QXc4Sm1qbW1keDdCUVUwelZOU1hLV3ZQZXVwbHdYMk1oaS9VMlVDTUJ3WkVC?=
 =?utf-8?B?aUdDREQ5ZzAzQUJuQmh6dTV4ZSs0eFBHMjJYcUVZYytCbWlmejhzUkZxYlN3?=
 =?utf-8?B?ZTNaeS9JTXFhc2ovb1dUSGZ3UUNQTDFWRyswMzNMTDc0NDRMOHl1c1p1SDFL?=
 =?utf-8?B?c1MrdlZvekVUNmVKbk1ZZk9aM2lKYlZ3Y0xnd3VVcm1JLzFCbUtGT1ZpSEdK?=
 =?utf-8?B?UFZJWk85dTNCTDN0dGxMcjJra1JvVmlKZWlXZ3NVSWRReEwwU0NvZ0JZTVAv?=
 =?utf-8?B?bGh5WVo1NVdwRWxpSXpqdi9FTVZTdjdzdFM0eUo2MHYrU3BSUXYzem5PRGVi?=
 =?utf-8?B?ZDI4OUo3U1VZdUo2RllGUlpmM3kxcGpKb3M1NTNjamlsOGhjOVpYZEp2aVFO?=
 =?utf-8?B?NUpqMGhFQWVmbzYyeXJZTUlxY2RzbHl6NGNBTUd2b3FWV3EyMHAxV0czR04y?=
 =?utf-8?B?Smo0NWZoSzFvUTdZUGlvZ3dkVG12VVl2clh3VHNBUENJek42RVdWcFNiUjB2?=
 =?utf-8?B?OXYrYXM4VWdZQ3lmZ09TZVZHbFliRzAwTCtId1VPODhtOVY3S05pNnRVMUpV?=
 =?utf-8?B?Y3RLSG1NU044ckcyYVZVMGhCTTlBeTFoYkV0TytqZ3VnL1poTTZFN3BFdTdw?=
 =?utf-8?B?c3hXM2NQTTYrTUJrdkgvVWZmYnd5ZnltM2Y4SjVWeHM3TTNYSFJ3UVpNZjFZ?=
 =?utf-8?B?ellzcDg1UHE0ek1SdC9TRXdmb2llSzFkRFIxYVU0a1I2a1ZFSUZ1TnRKQ2Er?=
 =?utf-8?B?cTJuRC9DY28xVUEwQUQvQ202cnRYdTRlKzZFQnlzTWJtZjZ5NExVaVRBMGJF?=
 =?utf-8?B?bVg2eHhJRjVIVTA3SlF1azhnbG1FUDFZUHUxWU1TK3NIbzd6UXhLRXZ2NXQ3?=
 =?utf-8?B?MHdvRWQ4NktqRzdScGluRWdteFZVMzJQdVFCM2ROZmpxSHQ1aTM5NnBmbHRT?=
 =?utf-8?B?dHVXNGZ0VHhUYitINnhVbjNQci9lTXZHazZLeCtpTURkU0FhQWpCLzR3L25B?=
 =?utf-8?B?dUwxdkVaazhrcng1MmdueVJCUTJZWkJhNEJRd2xvcUhUQ2V4NTFTNzJsZG8v?=
 =?utf-8?B?dzd1WUhiUFBGWi9qcFFVZmVaU3d6bVZHSVhOZ3dGTk0vVWtRb2JoWHhyK3Zz?=
 =?utf-8?B?bmhjS3QwdVkxM0EyelZQZjVWeTJHNzNBeHZHYmp5dmcwVG1SSnJ1NGdUQ2Nq?=
 =?utf-8?Q?MQNz0sC64hmWVLDdxEHJxibF2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac078a07-1627-4cd6-db4e-08dac77ab778
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 02:32:04.8538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wk9AiP6NjivgY936wftxxLFGOtQThPVA//0bgJ2w0qmyp80L4sVo6RD7KV8VqiaAhU0ea63LlqsUxtG4FXDHIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/15/2022 18:37, Bjorn Helgaas wrote:
> On Mon, Nov 14, 2022 at 04:33:52PM +0100, Rafael J. Wysocki wrote:
>> On Fri, Nov 11, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>
>>> On Fri, Nov 11, 2022 at 12:58:28PM -0600, Limonciello, Mario wrote:
>>>> On 11/11/2022 11:41, Bjorn Helgaas wrote:
>>>>> On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
>>>>>> Firmware typically advertises that ACPI devices that represent PCIe
>>>>>> devices can support D3 by a combination of the value returned by
>>>>>> _S0W as well as the HotPlugSupportInD3 _DSD [1].
>>>>>>
>>>>>> `acpi_pci_bridge_d3` looks for this combination but also contains
>>>>>> an assumption that if an ACPI device contains power resources the PCIe
>>>>>> device it's associated with can support D3.  This was introduced
>>>>>> from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
>>>>>> D3 if power managed by ACPI").
>>>>>>
>>>>>> Some firmware configurations for "AMD Pink Sardine" do not support
>>>>>> wake from D3 in _S0W for the ACPI device representing the PCIe root
>>>>>> port used for tunneling. The PCIe device will still be opted into
>>>>>> runtime PM in the kernel [2] because of the logic within
>>>>>> `acpi_pci_bridge_d3`. This currently happens because the ACPI
>>>>>> device contains power resources.
>>>
>>> Wait.  Is this as simple as just recognizing that:
>>>
>>>    _PS0 means the OS has a knob to put the device in D0, but it doesn't
>>>    mean the device can wake itself from a low-power state.  The OS has
>>>    to use _S0W to learn the device's ability to wake itself.
>>
>> It is.
> 
> Now I'm confused again about what "HotPlugSupportInD3" means.  The MS
> web page [1] says it identifies Root Ports capable of handling hot
> plug events while in D3.  That sounds kind of related to _S0W: If _S0W
> says "I can wake myself from D3hot and D3cold", how is that different
> from "I can handle hotplug events in D3"?


It's impossible to know for sure the logic in Windows, but from all the 
discussion and patches that have flowed related to it my inference is 
the logic for Windows must only examine and use the "HotPlugSupportInD3" 
property if the device also has _S0W.

> 
> This patch says that if dev's Root Port has "HotPlugSupportInD3", we
> don't need _PS0 or _PR0 for dev.  I guess that must be true, because
> previously the fact that we checked for "HotPlugSupportInD3" meant the
> device did NOT have _PS0 or _PR0.
> 

A lot of this confusion and this patch of mine stem from c6e331312ebfb 
being too broad to start out with IMO.  Wouldn't it have made more sense 
to only match and allowlist that specific topology combination (dGPU 
connected to hotplug port and missing those properties)?

> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-for-pcie-root-ports%23identifying-pcie-root-ports-supporting-hot-plug-in-d3&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cc883ba6351534df445f408dac76ac5e5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638041558659543898%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=5Qv3wUYB%2FXJhbeu%2Fh3A0swvgRaB8afjyEYzu9SpHK%2Bo%3D&amp;reserved=0

