Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496E66C4DE4
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 15:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCVOgp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 10:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCVOgf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 10:36:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B820128875;
        Wed, 22 Mar 2023 07:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyZc7oWRoSWb/8u6sueROD+BYPAyLoMyy6uOr640c2gGfVBbBS4PahP9ZkV648OQ1CZWAUtmDxelFxbPId74Pvb97CDnMXnPNlzFu85W0hS5mc+lsrzZKZn8j9Hqk62FXYrnUoA6Y32jh+bmlIKWvVjVJq/CIYTVjas0lDKsb2q6383mFQ3bNzjZxBlV49NaPRKvx7mHjYbYxzPkw8LJeE/OXNHknRDmm1ElhVUiHqcrC3NEAGdbIE56jMwHiRkW4Stpmggap0www1fm7Web3gxtLfYvUjp9cCso3iV1hUpvlvuckaue4yEhRvLARA0cAa8rPFjSgRjFCuk8cRoJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stspvk2EBkkIia5XLi0Wt4aB5GzgEAti+WdNeGjVHYg=;
 b=MQ6blNXPOoN/5oIG6C9eUQiZt5h4T66hFQSQnqdSFT4rr21qjFyKnJU22ivrUZ+9FRvfMbBcNMEoafJI0DsaxV57e/BonTH8At5yaFK+HXM7EMYZ44hf7XI5jpCVKsqbmtJcwVlKEvJA+IDLY4WRO71NUQqwAaqJme52yWNXPRB6vqZN9jsRkC+C27oNuPL4Q+6ELzKNSSrB5g3DkdkeES5mG0LT2U+6VMefCC9ra5KgDIwtdknmHVA+K363uW8Y6rDwd+R1fzuKzej8wuPZTvijTDEIfvGJHXfwHcQ264bvsMy0vBOJh5kfRl2G2XtHjGDeq+2dDcUFF9htIRIe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stspvk2EBkkIia5XLi0Wt4aB5GzgEAti+WdNeGjVHYg=;
 b=BwVRb++JnwaDq/1uj5y9NokT8ZiHRl5sh19rFhzlz5fRo4UcZ1YrJSH3DLqxUaPdLPJ9Ql8+RqhVjRrNoS3Xw6xs1DcYCjhwFRnNpNATtn+DZPd6X2qZ7+u7Xkz18xmYAHxuZmwR98Z2rSQ6+AI4DDRz2PslcBm+q/KhAtC9QJbgkcbJ93XJzElSB8ZLVc+8v3Gi6zQ0LjlPFg6ZH9mnCor0CzkNwXbxCnUrHJVLg8RRWbnDivOZNuzdJHxOWMexBIUi+vTaBxRs4Gj+ToBab+f96Wh0pumrbZWGXCsbmQuObosJajIm75+TK3zqqgZXZmGehPNrVvI/RDEpUzl3OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 14:36:30 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 14:36:30 +0000
Message-ID: <3414723d-7d79-809f-e63f-35243d945b50@nvidia.com>
Date:   Wed, 22 Mar 2023 14:36:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] PCI: Assign PCI domain by ida_alloc()
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20220702204737.7719-1-pali@kernel.org>
 <20220714184130.5436-1-pali@kernel.org>
 <b529cb69-0602-9eed-fc02-2f068707a006@nvidia.com>
 <20230320205936.wd6pj3trljsduj5c@pali>
 <993ca7dc-1d39-6ae9-1033-838d81aeb076@nvidia.com>
In-Reply-To: <993ca7dc-1d39-6ae9-1033-838d81aeb076@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0355.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::31) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4ee20f-460e-479f-27fc-08db2ae2d35e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: du3qy1kEDeIVR8Qgb+h5e3acnbQQKgdscT/nDVGCY9qiBL2FlvvfUx4QcLaMKU5qvp/QtaLJywWCSyqc1WnkoysVm6bIJWbW3bdGfwsdhLb9Byf0DU26fEM2DZuDNGfIRbp5rhkwFCS6Kz+m6YdSPGjYsX2uDZoVYm/dHky/GTa1dz5664Z5Mnto1CyQUXezt6VZHb+rDk3v20IZTacqK3vkG7uarCbsEDi7rjiW/ILZaR08zGAAOV6mg501lMUgg0BP/RhqSXumF3k2hO3iEqjRAO1ptMXusss5KmGhaCmV6ZznIorwoLjYsMYjeftPw0+bG2xE/qEcRMhPfBlnBgwaV6KU99PEjGrtpQvhSu8SLxXMtwaeT+s2f0KmQOEOT0OcUs54Qwq9eTqWvLdjsOhO7ytkJU5EQknSt/OgJwFtraMlkt5CQSS1r4im5pdRY13vMIqGRfbfREwP/EeNssceA7Zb6yoIaYw4lVqtfs094WBmLVJ86WzQ1D4vpa+m8BUjyG5zrnBUWB3ALmoToiigY7DPsI6E8WvtD9/ahhDmS/x5jxfi8pplsFHWQXn74UieVtJAuRS/YB8KJSdcYVFaBMB5potaU5WZ2KantI65Plf3FMr1D2HRYAF7kCDx67GRMwByeXGxkKttMK0ckRZBPEivtiWJ9uBmAoLIT4CN0LJ7xI3G1oMe8YXbx7qWTX3CKL1QsKdQnGKkZ+W0Z9Uyo3J8sFKnNqGeCtZdxuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199018)(66574015)(478600001)(6486002)(2616005)(6666004)(83380400001)(6916009)(8676002)(66476007)(66556008)(66946007)(316002)(6506007)(53546011)(186003)(54906003)(31686004)(4326008)(5660300002)(6512007)(41300700001)(8936002)(38100700002)(2906002)(31696002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWg0R0FIcTFmYkNlZlo0WVlUdy9lSU9idXArZklveUZ1Z0l3QmpVNTBZOVhk?=
 =?utf-8?B?S0YzT1lsOEVMem50RENTbHR2djRsU0pBTTVaazVZYzdnZmhGemNKYk9XOUwz?=
 =?utf-8?B?RFU0NUZmTnllL1FqNDM2RHh3R1dLTFI0NWRJSnpic29pMENDbm92clR2K2Ur?=
 =?utf-8?B?MXg5OWdsa2d6NS9SUjBWZUplUWlPaCtPN3NSdmdOUkRQdjdFa3FXWTBvZWEy?=
 =?utf-8?B?TmlMNGtlUVU4amhLUE51YVJGRW5wcjQzaXRhZDVoQldTbkZGVW9QY3VqdTlm?=
 =?utf-8?B?ZGN6NVRvWFU4cHBWYW4wWG1OUWF6MUFCb0V0T1FSOU1wNjdUMWUxV1JzQVdV?=
 =?utf-8?B?dmE4dFRIN2p0MFh2TVRaMzAzclJmMEc1RWpuOFFPNDZOQU5hcXp1YytCZ1p1?=
 =?utf-8?B?UC9FK3YzQWNOWXV3cittU1VkVGZob0ViMWxvMGNQMDBmY1g2a0V5ME1wdjdT?=
 =?utf-8?B?YTBzT2NyeUd4ZEdWYjlsWExtcHplV08vQVdRWTdhMlIzV2psRjQwRzMyd0RM?=
 =?utf-8?B?SnRGVlY3WUdEK0xjeUVLRzhkdElzZjB0Mm01TmdYWmhOZHZDRkVNSzdIQU1W?=
 =?utf-8?B?N1V2bEZaVkhNdHNMM3hpS3JqRUNjNktQT3pCYjRTLytrNWFScXNhYzF4SHdK?=
 =?utf-8?B?ei9KQ0FkUVkwUVdpdmhVSG1hRUVEUWhCQmFKU0Uwc0lSbXFram53UVd6U1hC?=
 =?utf-8?B?cHpvY29zUTNhUTVod1B3YU1XK0R5b0g1SDkwMFR5UmJiekw1SXVHU3lrTkdo?=
 =?utf-8?B?eFRxbEtuc0pSNzFOYytoNEdqQm52aWxOZHZFMXExTTZVNkF5djVIS2p2R0RW?=
 =?utf-8?B?M3lsZUVZVDAvRks1Z0xaQStrVi90R2puV0pHcmErNElWRVBwaVB2aFFYVEZV?=
 =?utf-8?B?RHZVQ1lseG8ya0ViOXFkNmtXOWFQQk5XcmZYZkZqeE1XU1JxYWdJRmFoYUdz?=
 =?utf-8?B?SERROVUzaGxBbnZWS2F6eEhjSWFuRkI0RW5Nbk4rcTZldFVXcndvQzVMdzRS?=
 =?utf-8?B?YzV6Mi9DS3BhTE9qUUIzVDZ1OWYyQWN3S0Z1Yzc2eVNkZDBpSEhnU25uVVVS?=
 =?utf-8?B?U0VXTDRyb2gwTURYbEEvWnUyQnYrL1RxQkV0VUNjRjFXZnVQVkNxa3dsUEtF?=
 =?utf-8?B?YVlZOFBNTmRkdCtSVnliL0o5UDcxT09ZdVdCSExlSHdDR1FQMFNEd0tiL0ND?=
 =?utf-8?B?dHpPUW40RGlLMjNjRDduMTlhVzY0SEx6OHI3VVFJcTRxblFxcjNLVEtOaXkw?=
 =?utf-8?B?RzZKS0JGZWFSTWp4Y1BaOUhtOU9NTWpQZUY3YmtCNGV1OFN2eXFLckJrdlZF?=
 =?utf-8?B?dTIvdFJ4UGtSemVLby9PTnNaalNoUFJmbEhuYkE5RWtwRTRhQjdKN014L2xN?=
 =?utf-8?B?QmZTMFZyanR5UmlGRGJiSElrNTR2c2g0TDBRV2JCd2U2Wkk5VVhiT0FLampJ?=
 =?utf-8?B?U2Zna25NTkVWVFpaRTV4bkIxNmZ2SiszWmhoZDNhMUIrY2RKeTJjM0g4YlN6?=
 =?utf-8?B?eVJ0dUIrb3dhQndRdThDeUJ4NUVnYlN2Ym1kUGpVOEtCdzQwNW9hZy9ENkE3?=
 =?utf-8?B?TklPc2MvTm9LNWwyNXViS2J2UkJvYVNrdjd0OTVRWERRY2hjaVlCYXRhdUtF?=
 =?utf-8?B?VC8yYzV0dlEzUFpVMXpWdGVSVWJRL3VoVTdIdUJmUzYwZlZOckFDeHdFRHk4?=
 =?utf-8?B?TXMrSWpMOWFYLzF5RUlZZjE4c1QwbXNDQjVsOHpRNlVlekIyZW0rMDdRT095?=
 =?utf-8?B?UDJBd0luUFgzTnlRU01DT3RWVlJ4enRZQnlxbnVXK1c0eU94dWhpemtTMGhy?=
 =?utf-8?B?RnZDOXFHMElRTE9jemxkMldwSTdOL2NORE9RaS9yK0I2bkZ1VXBVczlEMEMz?=
 =?utf-8?B?NzBuSkE3MHQ1bCtuaXF5WFV2bi9HNzBnYVF4dVBURnY1eEhYbDAwZi9uUXBF?=
 =?utf-8?B?OGRzYmlVcjdTSXdDZVJQTWs4dUY3MWRpZG0wTS94TW5DbE5Ocy94VzhKWDNy?=
 =?utf-8?B?VzZsOU5iY1ZKWXBkYjRqWE0vSU50L1VUREhKVGVOanQvRi9WVXZZNkMxVDl0?=
 =?utf-8?B?Y2JJNldiRk5zWXV5TWFDcXlyUDROQmMwMzdDMi9LamdDbklvVkdXTlRXbXlv?=
 =?utf-8?B?dklQOHovT1pUWWpIaG52OG42VXZubEIxVVRoNEdDVHhscXdoS2NTOXJTazhM?=
 =?utf-8?B?cGZsTE9xOE1UcEhZYjBKLzdLY1MxSDh2UmFzMkRrTjhGTXhPc0ovR3RyNlZr?=
 =?utf-8?B?MnFNTTMrUkxCLy9oWWVRNVgyL29nPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4ee20f-460e-479f-27fc-08db2ae2d35e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 14:36:30.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/6jD03sxo2+Ywsti1xW1j5MmH5zqIaEs+fLxOv2Jz9yKfi2mqja6B30XU1Wt5faW80fRvxi28L1mRkVsrQA7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 21/03/2023 18:44, Jon Hunter wrote:
> 
> On 20/03/2023 20:59, Pali Rohár wrote:
>> Hello!
>>
>> On Monday 20 March 2023 20:26:05 Jon Hunter wrote:
>>> Hi Pali,
>>>
>>> After this change was made we are seeing the following bug
>>> report on a Tegra234 Jetson Orin board ...
>>>
>>> [   17.172346] tegra194-pcie 141a0000.pcie: host bridge 
>>> /pcie@141a0000 ranges:
>>> [   17.172470] tegra194-pcie 141a0000.pcie:      MEM 
>>> 0x2800000000..0x2b27ffffff -> 0x2800000000
>>> [   17.172519] tegra194-pcie 141a0000.pcie:      MEM 
>>> 0x2b28000000..0x2b2fffffff -> 0x0040000000
>>> [   17.172548] tegra194-pcie 141a0000.pcie:       IO 
>>> 0x003a100000..0x003a1fffff -> 0x003a100000
>>> [   17.173449] tegra194-pcie 141a0000.pcie: iATU: unroll T, 8 ob, 2 
>>> ib, align 64K, limit 32G
>>> [   18.279048] tegra194-pcie 141a0000.pcie: Phy link never came up
>>> [   19.279285] tegra194-pcie 141a0000.pcie: Phy link never came up
>>> [   19.279599] tegra194-pcie 141a0000.pcie: PCI host bridge to bus 
>>> 0005:00
>>> [   19.279613] pci_bus 0005:00: root bus resource [bus 00-ff]
>>> [   19.279622] pci_bus 0005:00: root bus resource [mem 
>>> 0x2800000000-0x2b27ffffff pref]
>>> [   19.279631] pci_bus 0005:00: root bus resource [mem 
>>> 0x2b28000000-0x2b2fffffff] (bus address [0x40000000-0x47ffffff])
>>> [   19.279639] pci_bus 0005:00: root bus resource [io  
>>> 0x200000-0x2fffff] (bus address [0x3a100000-0x3a1fffff])
>>> [   19.279687] pci 0005:00:00.0: [10de:229a] type 01 class 0x060400
>>> [   19.279886] pci 0005:00:00.0: PME# supported from D0 D3hot
>>> [   19.283256] pci 0005:00:00.0: PCI bridge to [bus 01-ff]
>>> [   19.283590] pcieport 0005:00:00.0: Adding to iommu group 26
>>> [   19.283991] pcieport 0005:00:00.0: PME: Signaling with IRQ 174
>>> [   19.284429] pcieport 0005:00:00.0: AER: enabled with IRQ 174
>>> [   19.285003] pci_bus 0005:01: busn_res: [bus 01-ff] is released
>>> [   19.285591] pci 0005:00:00.0: Removing from iommu group 26
>>> [   19.285751] pci_bus 0005:00: busn_res: [bus 00-ff] is released
>>> [   19.285870] 
>>> ==================================================================
>>> [   19.293351] BUG: KFENCE: use-after-free read in 
>>> pci_bus_release_domain_nr+0x10/0x70
>>>
>>> [   19.302817] Use-after-free read at 0x000000007f3b80eb (in 
>>> kfence-#115):
>>> [   19.309677]  pci_bus_release_domain_nr+0x10/0x70
>>> [   19.309691]  dw_pcie_host_deinit+0x28/0x78
>>> [   19.309702]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
>>> [   19.309734]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
>>> [   19.309752]  platform_probe+0x90/0xd8
>>> [   19.309764]  really_probe+0xb8/0x298
>>> [   19.309777]  __driver_probe_device+0x78/0xd8
>>> [   19.309788]  driver_probe_device+0x38/0x120
>>> [   19.309799]  __device_attach_driver+0x94/0xe0
>>> [   19.309812]  bus_for_each_drv+0x70/0xc8
>>> [   19.309822]  __device_attach+0xfc/0x188
>>> [   19.309833]  device_initial_probe+0x10/0x18
>>> [   19.309844]  bus_probe_device+0x94/0xa0
>>> [   19.309854]  deferred_probe_work_func+0x80/0xb8
>>> [   19.309864]  process_one_work+0x1e0/0x348
>>> [   19.309882]  worker_thread+0x48/0x410
>>> [   19.309891]  kthread+0xf4/0x110
>>> [   19.309904]  ret_from_fork+0x10/0x20
>>>
>>> [   19.311457] kfence-#115: 0x00000000063a155a-0x00000000ba698da8, 
>>> size=1072, cache=kmalloc-2k
>>>
>>> [   19.311469] allocated by task 96 on cpu 10 at 19.279323s:
>>> [   19.311562]  __kmem_cache_alloc_node+0x260/0x278
>>> [   19.311571]  kmalloc_trace+0x24/0x30
>>> [   19.311580]  pci_alloc_bus+0x24/0xa0
>>> [   19.311590]  pci_register_host_bridge+0x48/0x4b8
>>> [   19.311601]  pci_scan_root_bus_bridge+0xc0/0xe8
>>> [   19.311613]  pci_host_probe+0x18/0xc0
>>> [   19.311623]  dw_pcie_host_init+0x2c0/0x568
>>> [   19.311630]  tegra_pcie_dw_probe+0x610/0xb28 [pcie_tegra194]
>>> [   19.311647]  platform_probe+0x90/0xd8
>>> [   19.311653]  really_probe+0xb8/0x298
>>> [   19.311663]  __driver_probe_device+0x78/0xd8
>>> [   19.311672]  driver_probe_device+0x38/0x120
>>> [   19.311682]  __device_attach_driver+0x94/0xe0
>>> [   19.311694]  bus_for_each_drv+0x70/0xc8
>>> [   19.311702]  __device_attach+0xfc/0x188
>>> [   19.311713]  device_initial_probe+0x10/0x18
>>> [   19.311724]  bus_probe_device+0x94/0xa0
>>> [   19.311733]  deferred_probe_work_func+0x80/0xb8
>>> [   19.311743]  process_one_work+0x1e0/0x348
>>> [   19.311753]  worker_thread+0x48/0x410
>>> [   19.311763]  kthread+0xf4/0x110
>>> [   19.311771]  ret_from_fork+0x10/0x20
>>>
>>> [   19.311782] freed by task 96 on cpu 10 at 19.285833s:
>>> [   19.311799]  release_pcibus_dev+0x30/0x40
>>> [   19.311808]  device_release+0x30/0x90
>>> [   19.311814]  kobject_put+0xa8/0x120
>>> [   19.311832]  device_unregister+0x20/0x30
>>> [   19.311839]  pci_remove_bus+0x78/0x88
>>> [   19.311850]  pci_remove_root_bus+0x5c/0x98
>>> [   19.311860]  dw_pcie_host_deinit+0x28/0x78
>>> [   19.311866]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
>>> [   19.311883]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
>>> [   19.311900]  platform_probe+0x90/0xd8
>>> [   19.311906]  really_probe+0xb8/0x298
>>> [   19.311916]  __driver_probe_device+0x78/0xd8
>>> [   19.311926]  driver_probe_device+0x38/0x120
>>> [   19.311936]  __device_attach_driver+0x94/0xe0
>>> [   19.311947]  bus_for_each_drv+0x70/0xc8
>>> [   19.311956]  __device_attach+0xfc/0x188
>>> [   19.311966]  device_initial_probe+0x10/0x18
>>> [   19.311976]  bus_probe_device+0x94/0xa0
>>> [   19.311985]  deferred_probe_work_func+0x80/0xb8
>>> [   19.311995]  process_one_work+0x1e0/0x348
>>> [   19.312005]  worker_thread+0x48/0x410
>>> [   19.312014]  kthread+0xf4/0x110
>>> [   19.312022]  ret_from_fork+0x10/0x20
>>
>> Based on the above trace it looks like a double free of "pp->bridge"
>> structure.
>>
>> Also, which kernel version are you using? Because from above third
>> trace it looks like that dw_pcie_host_deinit() calls first
>> pci_remove_root_bus() function and then (from first strace) it also
>> calls pci_bus_release_domain_nr() function.
> 
> 
> I have definitely seen this with v6.2. I was doing some more testing and 
>   now it appears that the issue is somewhat intermittent. So now I am no 
> longer confident that reverting this change does fix it. The backtrace 
> made it seem like this is a likely candidate, but I need to do more 
> testing.


OK, so I have done some more testing. I found that if I build the 
Tegra194 PCIe driver into the kernel, then I can reproduce the above 
100%. I guess by loading early there is more chance of a probe deferral. 
With that I verified that the issue is seen on v6.2 (as I previously 
observed) and on v6.3-rc3. Reverting this commit on top of v6.3-rc3 
fixes this and I no longer see the problem.

Let me know if you have any thoughts on how to fix this.

Thanks
Jon

-- 
nvpublic
