Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14F7523097
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 12:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiEKKV3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 06:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbiEKKVR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 06:21:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087CE23BC7
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 03:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXA0w7UA3BTU72/UM9fMEplB8s937JaxDTrxp2BglohERIDuUoXmOmq1g40nR4AYBHo6yTxNOzPkHcwAEWll2SjgtntGhsAdAjxYYfuXlnWJ6bonjPPbEhBcz5//ok84WJg6v8N8QCNzqWHiB9LTaaM3JbnKsNek0nkWvJB8DW4cPoeFz2W1jowoi+rMnFuTNQ61hgr9OpRUkEETYvny5w3jTiWiZqB5l0oErm9gq/M+rGAkeO4JLZIZW/eMpRg2OIp2J0JDVtCJ3YUTCVCsjrMdTvgJT3sShUxpXOWuZQjHMoZ8fvsXksVblKN2WuBx7wY9pln2A65rC0GxEmWQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7RmVfILvCFtUDI+Y8k4nTiOy3dnHt3JlxVb35p5HyA=;
 b=LWVFQKblN8J5tN8iMfovr/QtQzLfgPvDelWbJF9Hw9F5anHYjS0nOacfpbhVoOQaU20bfHuo0pUIkmY4Y/vvcEL5X+TW6IlkY+5Uq2/pphi4v0JZ80M+qu3L55BJ1/rYbpJazNY/PMEMBO/p78lQNhuCbj4rMKQS9rZ3sjCkNJw1UaK3xa6q2WhdtS8L+rt3vpQQGb1B1m0pBE5MGpDzp85TDaUWAuJW8b/nQNXxA8MoEy+oUvYZT/jJuYyDWKJuXtATY/yFSwpogI48uRkKoqB9M/Kn5DdoYia4MU4bAh2KbhB6e6RE5EeGdXplJK9w+2o2W5uHxIhCKsC5Bv1a5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7RmVfILvCFtUDI+Y8k4nTiOy3dnHt3JlxVb35p5HyA=;
 b=D9jlqKYUbwAoI5Z4zxBaVpxrUU47nV+QhLeek2k0yo3UXHYqKdKNJ9HyBoq//Axo2mN8NskmOwT6jHda3ixxOqBRfhdKLVPOFTFR4gfB0dvL/RnrgrOCm2Axpymhz9wgTd4r0LKHtouztXq1M3o8Ub1wnG/rDM66jZ2KKKVaHt0tbPCelIw5FiOCh38dHKZlxWbVfUL5SkkrYxRYTjlBfwSBR49aW8gPCSoL+vVlFrgklOFwHBSZopVLD92oCQurLmiZiAa7MNKFZIoDYePi8sYiGSpQoasmPYzC+4o6daq/wL+Dm0djsg4JnHJXlXukpjqGqSGMAkBka9bLRuuO1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by DM6PR12MB5550.namprd12.prod.outlook.com (2603:10b6:5:1b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 10:21:12 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::f917:a955:6b35:6425]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::f917:a955:6b35:6425%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 10:21:12 +0000
Message-ID: <4097e1b9-02e7-b7c2-991e-f393ecc72f4b@nvidia.com>
Date:   Wed, 11 May 2022 15:50:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Usability of the device-tree property "external-facing" for PCIe
 root ports
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>, rajatja@google.com,
        linux-pci@vger.kernel.org, sdonthineni@nvidia.com
References: <1cda1940-a01f-78b2-0843-34ec1e1a6673@nvidia.com>
 <CAL_JsqKvVSyZeM8X8SkFvO+Ve+8WF2B5Qsr_35=phUgHksP3mg@mail.gmail.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <CAL_JsqKvVSyZeM8X8SkFvO+Ve+8WF2B5Qsr_35=phUgHksP3mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::24) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a58cab7-aedf-4a17-548e-08da3337f8e5
X-MS-TrafficTypeDiagnostic: DM6PR12MB5550:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB55501382C77F32EDE8CE30FFB8C89@DM6PR12MB5550.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLZHlFUDMK2U2soz49oaRK2cRAKZiiYTIVdbVpF7lW6tqNcyRGPWJ8uT4IH9iBqvxqOwLT27I6SV0qfdEsW+HCZIYbHEvgK6hZOSJetVlih76PvzRzH4BgW8WW8OpOg/bXblXu2al2FXGUqIpT0JjbcMkK0XrTMupCSgZByrjz+SCQ+r1capdYk0Kv+UqFW/uz2XcRq2IyCDMVc5xXQmhnI820fEMhx9G5iuDb4H9UbQnZgF3H/JiclHresh2LuzNn7pZcGJDdmfUFdo/VgDSiL8ls2xS3utn1WR1K9LSiC3US88Q15IQFtbVkwrqFNvX6fELvvytIvaO6CXT49GraEN71BuRecl4gpWJx0ceOgvi6YU9rYTfpNdi9S87Odn7HuWDeJSqDNzSReP8MbyBXxBHHL6kTf1qsKOEsG00RUnPN/iBKP/uNL2p/PxpCJBTrZdDd7db47MnUqiy2FHrW+qy8PArm7SBnzf1oxnv4o7TkK1a6i3wOA3nuIVA9B7K2JBR+gvQJ07V7gpTJ0MjnyeRT0KCPX2pJFT6oGJZo5Ckm91E00yNiDtLJ1sM4UY4TePZxR4gEORaP6LMhmW1H42pw4QBIfeLBy4dq+X0io0tgnbKKk5gErYBkdyrrrGNqxSwlNWJKqmXSP0ba0o6xhVJjhekIicNG1FadDBdWy5jH09ntUPKzGn3NMNzH9DSRAr9IGm9fsksLhiaiU21Xde0ExETah/54TH2MzV7Rfa/gvqXBdi2iam7mHha8ZaBK1iLoclNmmwc26A0WCm2G/WzyKFapiBJDS5nWEPv7HyyzYPeOMXR9GZdWQ0F8z2llBbo1+1oOb2SFnBx9aCGNLWuSg9/wE1YtZE/UzfUOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(31696002)(186003)(2616005)(6506007)(66476007)(86362001)(8676002)(4326008)(66556008)(107886003)(508600001)(31686004)(26005)(53546011)(5660300002)(6666004)(6512007)(2906002)(36756003)(8936002)(83380400001)(316002)(6486002)(966005)(38100700002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFVZU2RNc2pKOGpUOFdlWFZvcWJGSTkzVmxyMnV4dy9RZFh2a3lCbzlBTzJK?=
 =?utf-8?B?TVpWSHZPQlVMbDZoTjE2R05ieWFua0tlRTZicE5VblhkY0FicytRVHExTUlV?=
 =?utf-8?B?aHBWZDZpbGJpdXgvMTIwUjR1d00wSk1KSVAwYlBvWTJFMHNmVjBmQjkrazlO?=
 =?utf-8?B?SUM1emNRWnFhMG5FMHBLVUhKdjk1SjVNUG9DeWF4NzJWYS9NSllNaXhyVlVq?=
 =?utf-8?B?VWo1SnVwZUc1ZDZtWUZBdXVEeW15c0NCbEpmVFVJYWtRK3FMZ3FGUVVvWmxZ?=
 =?utf-8?B?VzJDOEh3WWI0VWZXSVdidHQzcmRhOGhnd1pnT3lVK05ReldGL2tpVGZTN2dj?=
 =?utf-8?B?dUJoTVJPKzh5V2lyYVdyNnIyNjh4c0trcXRtK0h5dVp5M2puZndyTGZjbVdn?=
 =?utf-8?B?OUFzV0xjVmR3VU91TE9XblRvMTN0RGNBWnJOczNZNnUzVHhDWG96enVVanZa?=
 =?utf-8?B?Y3IwY3QvMUpEbEpENE1UR2FEN3lqQWtmNEVWcDNzazZyN1pUNlRMZGZHaWdy?=
 =?utf-8?B?S094UTB2SlRrd3g2cVAvK1U4NEtHTkhnQU80SWZhUHRFMU1jMXBkd0JEMmZC?=
 =?utf-8?B?SkwrVUMvdXdvanJRaDJIbWlNWEgvVnNNK04yTTcxSFpWWmVxaExVVmZ2SnYx?=
 =?utf-8?B?Y0hudDN6UEVlYUVVdHozMjFYUENob25GdmFBRGpxMHVIb2dYYlZ5ZS82aE10?=
 =?utf-8?B?T056STVZSnd4Y3EybzBGenNETTBLdWNadS91aWpEN3hJM2hkWUZsclhZQ2dm?=
 =?utf-8?B?clBXZHBVK2tFcDZOTGl1R05zazV6emNaaWkvTVFFT1I3S0NvNUlIOHB2WFNn?=
 =?utf-8?B?dWErVXBhUkUvKzVTbUdxbm9MUlk3U2FPT0R2L3FnSGpzN0paaEx5TmVCV3U5?=
 =?utf-8?B?bHdDSEhqRDRERlAxWHB3c09ZeW9TMndJOWlFNllHOGpSOHFyUVd3VklnNW80?=
 =?utf-8?B?VUFuRnVodGlNeUZhV2xndTdTTk1WaGl6emlnZ1VpbVE5cEFzUkhGTERCU2xR?=
 =?utf-8?B?Vjk1VlMwUUl6aHV0WjZSVTNZNGFxL283UDV4RUpaeXFRSjJXS0ZFQ3RJRVZD?=
 =?utf-8?B?RExKNSs2cG0vckJrTFJzdWFTYm4rL292eVZDOVZZYlZ6Tk5BVnRKU1cvdEdq?=
 =?utf-8?B?dG1jRWxJN2Myd0J4Z3NCcExvVHF1TzBqZXVwUHRzSVg5UHRGWGw2Q0RydE1y?=
 =?utf-8?B?d20xWUpRS2wrUUV5ekpuMG5ieFV3Sjd3TkJoS25iYkdlRjZRTHg1VFVGUUI3?=
 =?utf-8?B?L1VmZEQ4eUE4RWs2Ui9tNFRGRnRUWTEyalNxb0ViREwrUU50TlNRempsTXJh?=
 =?utf-8?B?U0xMN2hKbUxidXNvcXF0M3hFYXNHWG00d0RPNkxlcEdrVDR5MzhOQkczSk90?=
 =?utf-8?B?bmZDMlhaaVNzSnVRK2xCQmhNZllZNlZrbVB0ZHgwOC8xS0hYcGJOeDdOdHo2?=
 =?utf-8?B?eXhLMXh2SlBZVEdNNUNqVTl6L1RTMVp0dTlyc0dkenFrZk04amdKU3hmazBZ?=
 =?utf-8?B?STlkOXBNdXRXc003NTJRVUVObEJXQUw0MnlUZ2hWOTZ1V0ViNERNYTlFMkJU?=
 =?utf-8?B?aGYyYVV6QW00RXJsSHp2S3h3aDRkaXMya0Y5dVJqZHd3cXNmNUlEMFdndFVL?=
 =?utf-8?B?M0NaVEdObUxIWUlPMEZ0V0YxczlRSHpzQ2tsYjRKSzVVUTY4MlZ1bkRYd2da?=
 =?utf-8?B?SjE4eVFrcUY0Y2dReWhZVCsxeUxaQWNBbVVMWTZuOFRSdGFxVzlYckJpSm1C?=
 =?utf-8?B?N0Fzd1dtSTVlU0ZsVHpSbmZVS09GWHNScUxIY2h5QU9xMmJrZVNQdld1ME5q?=
 =?utf-8?B?ZDNrZ1lPTEZ1RkJEeWV2RzhreTVKVXNPbzdYYmlpbjlHTVk3V2VkWVN5dkJl?=
 =?utf-8?B?UHpTazdOQWF4bTJKK1cyVWcycEdhbmxZc0xKSjIzVVU0VE4vRXdsT2w5Ritw?=
 =?utf-8?B?ZXJ3NCtlenBkVDdNVGpPNElBeE1RVGtPSzhKZVNlVVRMbUkyNUE5c2kwQjZ1?=
 =?utf-8?B?enZNc3BPZURuZGpBa1YvMGxjMkp6UXZEbkhWWHJJN09uOXEvcUkxenBraWlz?=
 =?utf-8?B?NHBwVUlqVDA4QUIrZFp4OU5MNDRreG5uUU5JL0FCajFtaFhFZFEydHFwRk1D?=
 =?utf-8?B?VFhObVlKVWVTUWlFVjAxSzkyZDB0VGFJYTAzL3Q5SGtocDRjdkxtQnZSdzBJ?=
 =?utf-8?B?azQ5ZmRjaGxkZFpIdE52dkptRjVMVTBnd2V1RmJFVmsxZWZmcFIxaFRrZGJa?=
 =?utf-8?B?ZmpYeWpQT3FXVmZPQVEzbEQyZmRxdTVUaG9pdzRLdTBHemxDZ2RFZ25uRUxM?=
 =?utf-8?B?TmNWNGhkQ3JFYlpyb083aWJ0ZTJvQzJFNTdHam40WnN3Y2IyMnJKZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a58cab7-aedf-4a17-548e-08da3337f8e5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 10:21:12.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vY1OcbkbcewWhRYD9lYaD0Ck3g49RE9WIKD8XmWiJ2dARmBAMLeQS3do1BIPighfoudq4YIv5r1MD2rzUHulw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5550
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/10/2022 2:07 AM, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sat, May 7, 2022 at 2:18 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>>
>> Hi folks,
> 
> Why send a private email to 4 people to answer on an entirely generic
> subject when you could send it to maillists where anyone besides the 4
> of us could answer and have the answer archived for eternity?
Apologies for not including the mailing list.
I actually wanted to do that but forgot in the end.
Adding Rajat (Based on the offline reply from Bjorn) and mailing list to CC.

> 
>> Given the current implementation of pci_set_bus_of_node() API at
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/of.c#n36
>> , it looks like it can be used only for the cases where a PCIe host
>> bridge is specified in the DT along with the root ports it contains
>> (Ex:-
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/nvidia/tegra186.dtsi#n1313
>> ) and not really for a design where the root ports are directly
>> specified in the DT (Ex:-
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/nvidia/tegra194.dtsi#n2418
>> )
>> Is this behavior by design?
> 
> It should work in either case. The code matches PCI devices to DT
> nodes and the hierarchies have to match. If you don't have a DT node
> link/ptr for the PCI device and you think you should, then there's an
> error in your hierarchy. There's no error messages because not having
> a node is not an error.
Currently, I don't have an explicit root port (something like below) 
mentioned under the host bridge device.

pci@0,0 {
         #address-cells = <3>;
         #size-cells = <2>;
         reg = <0 0 0 0 0>;
         ranges;
};

  I would welcome code that checks for DT nodes
> present which have no PCI device created. That's a first step to
> supporting devices which need some setup from DT first to be
> discoverable.
> 
> Most PCIe hosts only have a single root port with BDF 0:0:0, so the
> root port is often not described and any properties of the RP end up
> described in the host bridge node. That's not too bad as 'if not found
> in your node, check the parent node' is a common DT pattern.
Exactly. It is because of this understanding that I have, I specified 
the 'external-facing' property as part of the host bridge node itself 
and expecting the sub-system to apply it for RP also, but it didn't.
If I create an explicit entry for the root port like above and then add 
'external-facing' property as part of that, then, things are working as 
expected.
So, could it be the reason that a host bridge can/may have more than one 
root port and since only a root port can own a slot/port, 
'external-facing' property should be explicitly specified at a root port 
level (in the DT) and not at host bridge level?

Thanks,
Vidya Sagar
> 
> Rob
> 
> P.S. If you want further replies, please add maillists to this discussion.
> 
