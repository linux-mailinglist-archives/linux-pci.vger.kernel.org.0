Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA41600562
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 04:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiJQCq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Oct 2022 22:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiJQCqZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Oct 2022 22:46:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C6346DAF;
        Sun, 16 Oct 2022 19:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVgzIp91INvwyWxk1FjL98z/z80JkIkUcZ86NTAOomi8fx87gOtYfv3Po7THpAoHl9QfZRfRfjh/ZkvSxowWW2WAgb6plvS/tskVkkOWDL4i/ruQWEPsrdSaF9DridxG6bBz87v1WMd3HSWwADFVrKd+gHyfDv+rvJS9DCD1ESoMHKFOrDa+hCSXbPj2vT1vUcVPvFqJANze2FYyRijgrafl5XpFclWJ1Ya11tvYpnwD3gv5uqDhESCacN8hXNKHjb5nKOTGSJmSievq5zG/Qx6+grX9a2st3wuAiIQ74LyTIwZSPIOSwf77qy1qSxMpHdCsK/EuzkGoWgKNi9HZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+V+CLDdiwKzqyjbI9gKVVsyTCfoGJ2PCmvUc7Pcxsw=;
 b=AYEkfsDR2rHCFshYA+5OK9uPfpSRciL5LHDtX7T59pkKepfvtThMXghNHXkWsB2dHe5oPrz6PmRWK9uvP6DkAVn+YAvDx22YSkg2GqlpyD00CfW6pGZzwXOOh8uaW3oqhWtCBrniWbpfDzHMNCLSEDhoQ56ydQG/v/o08waUr2MfVavFj0wz7jkUiVnOkFGuVOUtxUm5cK7RwiYOdKQM5MttyRVlYSpk7o+6aFv/ACwAyuY/TD5QiNhfgwSlSFedFnowHwM/kx9VJh0BDZ8MaQM7V8qpTEOLSE3kwbnzxzRTaCBadGm5Lb+osb5agkCLkz9VXhseonOrC0uCZ8l+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+V+CLDdiwKzqyjbI9gKVVsyTCfoGJ2PCmvUc7Pcxsw=;
 b=acFIW9Dkw0lTj09D1vGiKFy4v5+sUsA3Y5SDo6jTCGa1y/8Lw/oEqx0/6P4R2xiSoX/7F/Z1hbkrFJL6++Vd4lBJtTniKTD6x3KYFOhAZr6Yk6hahbJoK+OnpWQ8zXy2DMynZ2fT0XuaDDUXF+TBQWveZGw2gMUIdHAOHbuqG14kxbozewPNe47XN83/Wab5c/YLSRtQPAsn+VtW8NJSEPZD89aXKZMgTSGNKc2UPi+PlJlFKeFC99UbuAXWvQsHntED0HD+v30V6nUTDB4XgoRiNZ7ptmsXA2N7NUYWjGQBZOS94/VWcG+GaVGmJ4FvgzegVeJTKcgIP+6q6kO/VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by DM6PR12MB5005.namprd12.prod.outlook.com (2603:10b6:5:1be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 02:46:21 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3%7]) with mapi id 15.20.5676.031; Mon, 17 Oct 2022
 02:46:20 +0000
Message-ID: <38c1d688-1488-3ecb-422e-fbc47106c144@nvidia.com>
Date:   Mon, 17 Oct 2022 08:16:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1 0/4] GPIO based PCIe Hot-Plug support
Content-Language: en-US
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kw@linux.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        mani@kernel.org, Sergey.Semin@baikalelectronics.ru,
        jszhang@kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
References: <2a465222-342a-418b-95af-9948f6ce9065@linux.dev>
 <20221003180949.GA2104321@bhelgaas> <20221003182147.jp5gn2jpnf4gucdl@pali>
 <364fc93d-a4b5-59cb-c62a-8e3b32507523@nvidia.com>
 <9210e81f-15ee-6c54-bfbb-1188da48dd68@nvidia.com>
In-Reply-To: <9210e81f-15ee-6c54-bfbb-1188da48dd68@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::15) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|DM6PR12MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a3ceeb-21cf-42a0-9ce5-08daafe9c573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95YT393WhaB02P8mE6axbp6z/+1sXepABrKJjWDZT0ZBV/yRUw/B6d23CXrCesUDel++v94NDGybx5mttF3xsSyI4zksRzw4ph6IXmPIN+6CpSGFOtD25OmYSB8vg6DnuSOBNmG7xhMy+S2YvrcMLd6jr0q5wLpI77pFvcgGr3IxOq0r2/o2blNzViOQKP3MHHnP3UjzFYceg7CAvut3B4+ZPP5WwEx+MQhtxj3KswIIKTzBB5aAuV5TTSovpHFv6UuwEjshjTlLDSvo3ZUB6qtS4y/+X9Zl8GCwh8kyJNqHJmAL6qQKDNv1FuuK6F3xCOY3ozJSjfVhK1SQuDoR+OhstK8fcUm+HNRxBcLQeXRKrLtnGr2VOEzE0wvGnBDgjWRR8B7VAr8Is+B6cmZIFQb7NG4gCTv7hPS6l+V4spgG8ZuiRCkuyku7BvYxZsJ8/mV/KLrage8fsDx8aOtz/VTPhamLVmXPvAVUZM8UFsBMt14YCiQLJLylW6pm4WOQN3twv6kZrB84PUYb7ayaNcI6Sx+2hZn4LK9Gm61SBEc4fdZ1ivGQMSrliqtwldhEkRSP9Ts3M5zf6oY6J1e40isyn1OZGV3B7ZHQVREMWuRBJJ+O2LR74nHL0QkF4GZKEpiU0qQ1GlKEOSkcim3iEimlTRxoPVMD3n7rprIAUDgBKhJ5guGlnv2nT1rC1lhBdFju1r4LxSYz2VSTC6wfbkCS/BrML85b73pKleCfFgXL/v2oe7s3i1Nz+xV3nZvwSr/LqRoi9dw3RzyH9eQna7y7pqlBch9i/frnuDwnLwQjqF5ZvZdHUGgVrOYK3wj98FWX1X/aaIwYSBaI6xx9CQ+LilXhypA9WxLGpAmBdESkkke6zh8H47RAiM6s2vWU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199015)(31696002)(36756003)(86362001)(31686004)(38100700002)(186003)(66574015)(2906002)(5660300002)(7416002)(6506007)(6666004)(26005)(53546011)(6512007)(2616005)(478600001)(83380400001)(6486002)(966005)(316002)(110136005)(54906003)(66476007)(66946007)(8676002)(4326008)(41300700001)(66556008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0VveWozTXRHKyt2b082aDVld1dhZ1JGM3lwanJGTldncnM2UHdhNlg1eFN3?=
 =?utf-8?B?ZDJKYllBR1pkdzhTd3VjNnZmTFdJRnpHRWZubE13WVVtZHZleUZoclFWZnlB?=
 =?utf-8?B?QkFLL1dPcVYxSThHTngzTUtLbW1jT1RtRUQvU2ZRZzlhNUNidGpYckdmNU5p?=
 =?utf-8?B?a2RSaTUramtaRFF3aVlHYmtGZXNYWnQ2OE11enZ0dkgydms3UFdHUjlJSkxa?=
 =?utf-8?B?clBYdVlzUDRxMWN5TjY3SG5neXFveWZ3SWF4OWpic0l1M2orNzZTUncxR1JR?=
 =?utf-8?B?VjBCamY3QXFrbTBFb1ZtVWxLcTJhZFUrb1RVRzZnNGtlYlZRWHpVMjNXaStk?=
 =?utf-8?B?b3IyU2p4U0d1NHF3M0hFWTBnTEsrY0tKYXl3TUkzTG9UN3FXNDkwbGgyUmxI?=
 =?utf-8?B?L0owYUVWRHNlNmhYa1JWN1ZOTjNZR1NYOThTdHNhWG9kTHVaMHdGb0w3WEJy?=
 =?utf-8?B?RjFMbmdsb29wd2NmRE9Cc2dqcVlIeEJUQXA5VE13Q2dXdU9PWWZvRmlIeTVH?=
 =?utf-8?B?WWlIM0llMVhBRGhGdkVBWUlLbStsS2x4OXl5K00yZUxmbjRETzVYRG5ZMnVv?=
 =?utf-8?B?OVBwZG5OMGRJMndmYUhYNDc0TlB1TGd2SFlwd1JnbDd1eVlvZ0E1VnBoVjdC?=
 =?utf-8?B?dzlITUhBV093RVBBc3VYdDg4ckI0ZHRFU0JDcjFMdmZYRENCZUVLQW1xUTJs?=
 =?utf-8?B?V1RONndSaWNZbmZuY2Y4S3U2UlpJMW9la3A1TEZsZ0cyMmtOMGxLN1l1OFNL?=
 =?utf-8?B?RVVRb0NFSWViUzZHV0xIZkJPbHpwNmpuMCt6VGtGNk1VZFJBWDR3bnVJTkEr?=
 =?utf-8?B?M2dmTjVacCtpNzF5ZmNTVHJhZHE3ekdnSG00Wkhka1JGdDczMmtNRDlRemtF?=
 =?utf-8?B?YlBZSXFlUnhvQ0hibnVGL3RMeHR0bDRZQnA0eG0xZHZoTUx3MTl4WFhMTFRt?=
 =?utf-8?B?eTVzQ3ltQWt4NTkwa3RXVXpXR3JDbFVWUXk5c2RlT0l3aTFJWm9FR2p1a1ZD?=
 =?utf-8?B?dFRteVhVTVByWUdwWU9ZNzU4aFpEdXZQV0t2OVRsY0NYVXd4TllYOWYramtP?=
 =?utf-8?B?YmlmS2RwNUwxUllSL3h4WkY0L3BHbXBkcm5WTUVLa2NndGtrU1FOc2swVTVw?=
 =?utf-8?B?dWZDRitPYUlkUHZHNExJVW15Ukt1MkZVck5XZ2t4S3dMcUt0WXFHSHYrY1c2?=
 =?utf-8?B?VTBoakRiSXQ4dFJ5WTdmRFlUQjYvd0cwTlJFbWkwby9Fa0pNOTRYTTB3TDZq?=
 =?utf-8?B?UktmcWorazk3bHNDTGx1WDZZUVQ4R1UvOTkxL3NZVzNGYnlXVHQzZGkrd0hR?=
 =?utf-8?B?czdRWTM1dTNvSWFxbXMvTDdETk5yeldmZjE0TzJpL3VUSXQvYzRsYkZ4dVFh?=
 =?utf-8?B?QTBHZzMxZXNhaTZCQVIwVDBkRDRWdmNYeWpZZmNveDhodzdBSjE4Z0tTcjMw?=
 =?utf-8?B?Tk1PTllaNDU2MGhGclhJeTZVaTFhZFBtbERrSlpJem9nMUFMd0c1Znl1NzNZ?=
 =?utf-8?B?aFdDSjU1K0tWb0d4Q1dtcnZyWkd4UXRRei90dzAyUEo0SFhMdnhlcy9tZEJj?=
 =?utf-8?B?YXpnL0swOCtjaHE3NHR1Um14YnVsQ1JxeWJkTnA4MG9OcmlCRUdqVEVRMFhZ?=
 =?utf-8?B?MkdtaktPMEdIUzNKNUp4TXE5cWt5amVmYVB1OC8vN2JkVDRGQ2x1Z3NZUS9k?=
 =?utf-8?B?OUVZTng0c3ZCRmYwaFBmVFBxOWVHR1JJQkR5bTV1bzlZN1NmSXVqMm9kd20y?=
 =?utf-8?B?MU5QaVJmSmx0VXJnT3MxQ0x2VjMwOElWUHdHckZoUlMxZitGb2hCeWxZSlZa?=
 =?utf-8?B?WVBCU3lGYjVPTjh6eEt1eXVHcFh6ekJhTFh3SFJrcExFWCtPeGFZcll2OXVJ?=
 =?utf-8?B?QTAxVG9uL0xxVER6a0pZZFVvZWpHRitvRTkwejNRU3lWQVVZMVY5WjZ1TXh5?=
 =?utf-8?B?YWM4MXg1S0dmY2g4UEpGNjExeUJFcXBTZVNYVlJ4eFQ0NzU4WnRqeXpadHYz?=
 =?utf-8?B?Zzg0NGJmM1JlM3hQZ1NLWFJPVHZrT1dDbEsyaDB5VkR5VjJpUjVoS0R1NitI?=
 =?utf-8?B?RXRydDZ5L3BjRTVKeTlQc3pWZ3AyZ214UENESEdXOWRWdlZpOG9NUWE3TGZR?=
 =?utf-8?Q?n+Ae3/Qb1LBE5Np1R/+EmsCyQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a3ceeb-21cf-42a0-9ce5-08daafe9c573
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 02:46:20.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xj2Z03QXIFdCU+NybySApOfGU50swcpnOswAKhyfrPpSfPAtvHZ1j4IwVnmouhjQ/mFTGZfNaauWnGHDh72gDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/10/2022 11:44 AM, Vidya Sagar wrote:
> 
> 
> On 10/4/2022 9:34 AM, Vidya Sagar wrote:
>>
>>
>> On 10/3/2022 11:51 PM, Pali Rohár wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Monday 03 October 2022 13:09:49 Bjorn Helgaas wrote:
>>>> On Sat, Oct 01, 2022 at 05:50:07PM -0600, Jonathan Derrick wrote:
>>>>> On 10/1/2022 10:20 AM, Pali Rohár wrote:
>>>>> ...
>>>>
>>>>>> Would not it better to rather synthesise PCIe Slot Capabilities 
>>>>>> support
>>>>>> in your PCIe Root Port device (e.g. via pci-bridge-emul.c) and 
>>>>>> then let
>>>>>> existing PCI hotplug code to take care for hotplugging? Because it
>>>>>> already implements all required stuff for re-scanning, registering 
>>>>>> and
>>>>>> unregistering PCIe devices for Root Ports with Slot Capabilities. 
>>>>>> And I
>>>>>> think that there is no need to have just another (GPIO based)
>>>>>> implementation of PCI hotplug.
>>>>>
>>>>> I did that a few years ago (rejected), but can attest to the 
>>>>> robustness of
>>>>> the pcie hotplug code on non-hotplug slots.
>>>>> https://lwn.net/Articles/811988/
>>>>
>>>> I think the thread is here:
>>>> https://lore.kernel.org/linux-pci/1581120007-5280-1-git-send-email-jonathan.derrick@intel.com/ 
>>>>
>>>> and I'm sorry that my response came across as "rejected".  I intended
>>>> it as "this is good ideas and good work and we should keep going".
>>>>
>>>> Bjorn
>>>
>>> Nice! So we have consensus that this is a good idea. Anyway, if you need
>>> help with designing something here, please let me know as I have good
>>> understanding of all (just two) consumers of pci-bridge-emul.c driver.
>>>
>>
>> Thanks all for your comments.
>>
>> I would like to hear from Bjorn / Lorenzo if the design of the current 
>> patch series is fine at a high level or I should explore emulating the 
>> root port's configuration space to fake slot config/control registers 
>> (which in turn depend on the hotplug GPIO interrupt & state to update 
>> Presence Detect related bits in Slot status register) and use the PCIe 
>> native Hot-plug framework itself to carry out with enabling the 
>> Hot-plug functionality?
> 
> Bjorn / Lorenzo,
> Could you please take time to comment on the discussion happened here 
> and the right approach to be followed?

I'm really sorry to bug you on this, but would like to hear your 
comments on the approach to be taken. So, I would really like to hear 
your take on this.

Thanks,
Vidya Sagar

> 
> Thanks,
> Vidya Sagar
> 
>>
>> Thanks,
>> Vidya Sagar
>>
>>
