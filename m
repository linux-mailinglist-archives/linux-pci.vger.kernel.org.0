Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DEB699D47
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 20:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBPT7o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 14:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBPT7n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 14:59:43 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDF33B220;
        Thu, 16 Feb 2023 11:59:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnbwFqXM2SFYLV9O7c6cIDdpoOdQuNNWj0vCJMgYARcrPgNFpps3BygD5wdmLsnfK8wjf1Hi2S1yU1m+hcHHpJpKfLM0rMAEKgdBaHH1lYtbkq14R36jSuXVq5mspHMbDEYhfEQz1kamufCQZ71J9sxoLxjDABqTNE0vl+/ml096pzMuGADDdsOga0ve244NallIgF0oaXBJNNXq/lUZioHv/zaPmGWE2yBVo+emcWwWtKInyeHTqDcQMVAhV4Hoaxj+SshDKj5M/kCUhKeOSWMn1kO+8w5ndYDAo+LOqU9jA408dLShOYUshERUlYOgwVPRi8t2FTUIqdwafDlOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktlIIRZLENSK/bV4nC86tDeUZLOG884zwzGlnMAfyCg=;
 b=KGXM52hJyLYSLz6SB+yq7Y0g7dDXcj0VwY5VuaZoZtra/4J/o0600KDWiCwGelGaJ91cRGCK7Fyi3VSmghH/lZGZUl64LjiRoqV6qrTwTzjosVcrfECznhb4Lzk6bQPaw65qkmbg3OuHHDBX+tqiDJRkWBTmI6nKj/qEeWAsLbJZiDxkg9HGlnTD8qcHGfIAyIegtUWZxvXPPSdqg1FnUdnwHLdVIeFeFX7LgLIYGHSP88zjI9V++40jLyzybg05A7jG1Yc02mgRV6WlK7TJ2LBvBC+F1TWrlvy9okxg0iygzkvzY+kCAV9P5CWrOS1Qp0wfC+urg5n8JR8aTQeDsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktlIIRZLENSK/bV4nC86tDeUZLOG884zwzGlnMAfyCg=;
 b=Wi515FCvFUx0bMHsd9lO2BWG0yy+MoNvxdqbR4sxez+QkKSnQVYE4DjUl98VdpQFMbzQSV+JrVMgAaZuHkfn7f0d0+ug/Sfmjn71InCBkIqvsR/INJyq7o97pKSxFTltxkGt8SjaPGmcqCeGp2jbhlQw6p6nT5zaZPXWYy04s3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4974.namprd12.prod.outlook.com (2603:10b6:5:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 19:59:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 19:59:38 +0000
Message-ID: <9e35ba5a-bc09-30c0-462b-6b83d5edc070@amd.com>
Date:   Thu, 16 Feb 2023 14:59:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Matt Fagnani <matt.fagnani@bell.net>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230215153913.GA3189407@bhelgaas>
 <e3b866eb-830c-9037-39c7-978714aaf4d2@amd.com>
 <51861ff2-380f-640d-d5e8-7efe979a97ea@amd.com>
 <40b2da4a-a205-3cf2-0c78-c94c28b2d3f4@bell.net>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <40b2da4a-a205-3cf2-0c78-c94c28b2d3f4@bell.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 747e448b-9247-4e96-addd-08db1058559a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jk0AWSmAgDM+5U58DtR1RHNyEKJq6riLF/E5ml5NRFQfUSLZrsAwYP1m90UC8JYKgU1cFXjmzFVQriy0by/2eNJ7D/l3DWIrypJBO/DV8eOyV2eCj0eQ/KmFOD6m/qTEB5sQlyrL4R+IqQNS9u/C1TvbzR/iUs8iKFqdYzt/FMSYfxBOPznnJkMoVEI+im8uEQZfiqfibKbLLfvCctniCoX9nHzEy4jliRy02sMsYZjPLyC1SFy+H12j8L4O4/trfY7bXq6brfLuQSKz87/Y9Sfj/QlWsd4W5wJ3AQPwaVS1CXd/jJ18Q/3JCkh+Cs3clSzaEGUrANshmdUMaWTud9HxEuWlIrS3tppKt9usbNXZiKWNNPKqE37vVE6clG5CLgN3H7qJ3s8WFLL2Fe9Moueh9N7Qj7Td0F2Dwv4LKKczB8M2yeaXpe5do9z5xRR0pwXU0zxBqGdksIxgB/zJ1k8bIA5dqiFIZanbOhitk/QrBgmy8MQThmqBwYnciPB/EaXIlh1hqN7arlOLiW6F3R45sOwx1/l1LftgYt3Vg9yosqOIyLe2p23ELmnDwzdROdYp5fEyjI+cdbZs7P/woVWQdUj8lzWCJW/5NhnDqv2071ZCxvsAXJ7SbfIfwZD4J0yvdkBakTHpjqCl4iex2Wh4579isPmcrnwy22gBuJr7wQ4PJS64vcl2OGoFgbtFAhTVuYG4KTSrZMNSLcI5aTQ0tFzxIABvfk5ZbG+O01/bAMQ7hZN1PTiX1EjfYLrFhsc4154JQO+ZESRw6BJJLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199018)(38100700002)(36756003)(31696002)(45080400002)(7416002)(86362001)(44832011)(30864003)(5660300002)(41300700001)(66556008)(478600001)(2906002)(31686004)(66946007)(4326008)(54906003)(110136005)(8936002)(316002)(66476007)(6486002)(83380400001)(53546011)(6506007)(6512007)(186003)(26005)(966005)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUJWOFdlZlpsaUQ0YzdCSzFoYXArZ1lXdGlkRmdMUWs3a1JBcjl0VUhIdVJO?=
 =?utf-8?B?aVNGZWdzM0UxaW16bWYzZmoxRjUvQTV2MTZFU21JUW9tdWZVUUJWM3Rlc2J0?=
 =?utf-8?B?SDZVMTFYQzBzTVNtdjMrNGdSQ21rNVZNaWtaNmtLYzlQakJUVmt2akVNT0s5?=
 =?utf-8?B?bUwyc1ZiK0VseGlCTXNJWHFHNTFVdUNIdzdXQzNLWTAzT0NTaWZaSDRCamZa?=
 =?utf-8?B?dzhIeE5GVTdHSXJGUElRdVpISVFZUGJNcHlLeC9vT0pMVVUwQXFpVHhaKzlS?=
 =?utf-8?B?SVN3d3dlZ2czQXl4NnNudDhIY3gxRjkyWHZQSU1tOFlsMHgrbGNYMkF4ZVV2?=
 =?utf-8?B?aWswZ29Wb2c0WDlWa0dSREp0M3d1Z0FVNys0MXBsU1AvSmk1L0lLck9XUUZ5?=
 =?utf-8?B?UjdDc0M1azdMeVZaZTVSNVhYTFc0OFhHcTNIdE8wMExWQjJpM3hZUXJIWktt?=
 =?utf-8?B?cXRndlRMbit5c0grbFIxeTE2dkhtUWdnazZRTFlkaHNaUjN4Q0YrZU5tK2xP?=
 =?utf-8?B?aVpiaG5rNDh2ZUVxaEFGZytjUlowT09RZXVXY3VwL2ZTSS9DVXlpbGxQVzUy?=
 =?utf-8?B?MkpuRXRBNG9MN3o3Z1I5b1AxYnRBSTlydU91Qm04a01FclNXdXFETTcrNjNi?=
 =?utf-8?B?c0p4cTNHMVRFaFpScklJVzhQTWM2cTBsaWVZM0pnUnhuUzEwVmhUdlVCTmNF?=
 =?utf-8?B?dW14c29iUUxFdVVWcXpZcGh2cUtvdmJ1MzNKZVp2L1hvT0dxT1d5NWNtZ0Vr?=
 =?utf-8?B?N09NOWVHejZLVW8zcXRMQkVHTmxVeW8vK3V5K0VKaVZuS3dIU1VRV2tFaU40?=
 =?utf-8?B?UGlHNE9NWEV0c1NJOXNLWitVTXFQejMxSFhGaXVYUHJ3bkhvNW9Qck9NS0lQ?=
 =?utf-8?B?a1pVeGp0UTdLSzdDTVVOTUIvaXN4ZS9IdGp6ZDYzNkRqSnRUZzhUekx1MlVH?=
 =?utf-8?B?eFpESEN3RnQzVko1N05IQk5TbGZkcTZmamZURC9lQ2c3cWNCV0NSSDQrL3F3?=
 =?utf-8?B?WE82cFYvanJCVFVpVTNMNjVzdmhjbFYycXFQdEdPdE0wSVdYcy81NHY0eGJu?=
 =?utf-8?B?TVRHcmlvaWVqWjJJVnpJUmIwSFk4NEl5MjRpRDF6WkZBTXNqQzltblR2anp2?=
 =?utf-8?B?SkJlcjRQQ2UrZnFybDcvZXpXTjE2N0c3T1k4eVFKT0RrVGVGWXl2cTdxbWRL?=
 =?utf-8?B?dGphSlA2czdaWnJvRjJIb09qWi90dHZoaXdjN2FIem5hcytQeVQ5UGxYY05S?=
 =?utf-8?B?bFQ2RVdIK0ZydEFiWE1VcUZzRzJWVzJEL0tFU2VUVDZhZzdVc3ZWQVlYcnZo?=
 =?utf-8?B?SjkwN1YvNUEzZUZFU0k5cmY0Q1dNMHJxM25BQXNESk5vVHpkN3I2SjV4TEFp?=
 =?utf-8?B?MmUvd21QTWpZcEZTQ1JsZnZlZkpoS2lBRDA3dDVNUWQweFhxWlpxRHBCc3M1?=
 =?utf-8?B?dGluTTRGR0V6ZUMzbjZxa2wwNVEwZHBteE9SRzF4Q2piNTNNU3cxV0V0dk9B?=
 =?utf-8?B?bjQrL1VuaDh4MnBNVkNJblhOQTJvbVhWZ0g2emNIdU5EakZaZFh2MUNBSk83?=
 =?utf-8?B?YTFMbDMzcG9MaHlEN2JVZFpFL0x4NkkvSmZieXhkUlQ1dkdSNCswTmFEUzJj?=
 =?utf-8?B?V0kzN09UK21PcCtvWmxybzZCRVMzRTdDTUFJcU55Mm0zdmRmMWVXdDArdTV3?=
 =?utf-8?B?VjNpanl6cUVEUjVIVnJqaUlFZEt2WXZkUWxWSVMzZWU2eEdNTm9haHV6ZzE1?=
 =?utf-8?B?VjBCSWd2anRwOHlXMisrRUlaVnBYbjQwZ0tKY0hvcTUwN2VpMmFaeldWazNN?=
 =?utf-8?B?dlRiS2lpUmZhM2x2RWYyNWtjbHF5Y2QvMVo2SENPYTd2TlZXaDZycHBDSXJi?=
 =?utf-8?B?MkJjYWY1YWl1bHF2VWRibzdqVUJBcitxZEpBZFpveWJRYTZEci9SeTE2SzFh?=
 =?utf-8?B?ejdMMDV5bStHbmVYcTRTQnNYZUdUSE9qV0F6NVJaWTNsbU9sdy9QWHdzakNQ?=
 =?utf-8?B?cUkxZEtINWl3WWt1Rm0rR1F2M09KcXRSbnFxTjFSajBZbFQySjRhdUtOc0VL?=
 =?utf-8?B?L0FldnNRVTFNeE02bDlwVlU1bzdKbTYyYysrZHgwWmZlZVkxUkhzT29Xc2JD?=
 =?utf-8?Q?nIunTj0tE/VuzA3V1Uwe2O7AY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747e448b-9247-4e96-addd-08db1058559a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 19:59:38.4588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6Ugkj8hRgaI4OkZf2tBEfp7Jb6bpwO4v7u4G2Tt2lfyhZ+nuLVp8Mi90+qx6EFZ2f3LqU6CQCO5exso+Lf8+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4974
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Feb 16 13:22:32 kernel: kfd kfd: amdgpu: Failed to resume IOMMU for 
> device 1002:9874
> Feb 16 13:22:32 kernel: kfd kfd: amdgpu: device 1002:9874 NOT added 
> due to errors 
This look like IOMMU device initialization still fails (but more 
gracefully now). Vasant, is that expected?

This would lead to KFD not being available on Carrizo with this kernel, 
which is probably not a big limitation in practice. It would only affect 
compute applications using the ROCm user mode stack. I don't think 
anyone does that these days on these old APUs.

The SMU errors seem unrelated to this unless there is some subtle 
interaction I'm missing.

Regards,
   Felix


Am 2023-02-16 um 13:59 schrieb Matt Fagnani:
> Vasant,
>
> I applied your four patches to 6.2-rc8 and built that. The black 
> screen, null pointer dereference, and warnings didn't happen when 
> booting 6.2-rc8 with your patches. There were errors that the IOMMU 
> wasn't restarted when amdgpu and amdkfd was starting though at kernel: 
> kfd kfd: amdgpu: Failed to resume IOMMU for device 1002:9874. I don't 
> know if those IOMMU errors were expected or not, but I did see those 
> types of messages when I used amd_iommu=off to work around the black 
> screen before. I didn't use amd_iommu=off when testing 6.2-rc8 with 
> your patches. There were also a different amdgpu warning at 
> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu8_smumgr.c:98 
> smu8_send_msg_to_smc_with_parameter+0x103/0x140 and errors about 
> amdgpu timeouts on 1/3 boots. Plasma took over a minute to start and 
> shut down on that boot which was unusually long. I've seen those sorts 
> of amdgpu warnings and errors infrequently before so they might be 
> unrelated to the IOMMU problem. The part of the journal where those 
> errors started was the following.
>
> Feb 16 13:22:31 kernel: [drm] amdgpu kernel modesetting enabled.
> Feb 16 13:22:31 kernel: amdgpu: Topology: Add APU node [0x0:0x0]
> Feb 16 13:22:31 kernel: [drm] initializing kernel modesetting (CARRIZO 
> 0x1002:0x9874 0x103C:0x8332 0xCA).
> Feb 16 13:22:31 kernel: [drm] register mmio base: 0xF0400000
> Feb 16 13:22:31 kernel: [drm] register mmio size: 262144
> Feb 16 13:22:31 kernel: [drm] add ip block number 0 <vi_common>
> Feb 16 13:22:31 kernel: [drm] add ip block number 1 <gmc_v8_0>
> Feb 16 13:22:31 kernel: [drm] add ip block number 2 <cz_ih>
> Feb 16 13:22:31 kernel: [drm] add ip block number 3 <gfx_v8_0>
> Feb 16 13:22:31 kernel: [drm] add ip block number 4 <sdma_v3_0>
> Feb 16 13:22:31 kernel: [drm] add ip block number 5 <powerplay>
> Feb 16 13:22:31 kernel: [drm] add ip block number 6 <dm>
> Feb 16 13:22:31 kernel: [drm] add ip block number 7 <uvd_v6_0>
> Feb 16 13:22:31 kernel: [drm] add ip block number 8 <vce_v3_0>
> Feb 16 13:22:31 kernel: [drm] add ip block number 9 <acp_ip>
> Feb 16 13:22:31 kernel: amdgpu 0000:00:01.0: amdgpu: Fetched VBIOS 
> from VFCT
> Feb 16 13:22:31 kernel: amdgpu: ATOM BIOS: 113-C75100-031
> Feb 16 13:22:31 kernel: [drm] UVD is enabled in physical mode
> Feb 16 13:22:31 kernel: [drm] VCE enabled in physical mode
> Feb 16 13:22:31 kernel: Console: switching to colour dummy device 80x25
> Feb 16 13:22:31 kernel: amdgpu 0000:00:01.0: vgaarb: deactivate vga 
> console
> Feb 16 13:22:31 kernel: amdgpu 0000:00:01.0: amdgpu: Trusted Memory 
> Zone (TMZ) feature not supported
> Feb 16 13:22:31 kernel: [drm] vm size is 64 GB, 2 levels, block size 
> is 10-bit, fragment size is 9-bit
> Feb 16 13:22:31 kernel: amdgpu 0000:00:01.0: amdgpu: VRAM: 512M 
> 0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
> Feb 16 13:22:31 kernel: amdgpu 0000:00:01.0: amdgpu: GART: 1024M 
> 0x000000FF00000000 - 0x000000FF3FFFFFFF
> Feb 16 13:22:31 kernel: [drm] Detected VRAM RAM=512M, BAR=512M
> Feb 16 13:22:31 kernel: [drm] RAM width 64bits UNKNOWN
> Feb 16 13:22:31 kernel: [drm] amdgpu: 512M of VRAM memory ready
> Feb 16 13:22:31 kernel: [drm] amdgpu: 3704M of GTT memory ready.
> Feb 16 13:22:31 kernel: [drm] GART: num cpu pages 262144, num gpu 
> pages 262144
> Feb 16 13:22:31 kernel: [drm] PCIE GART of 1024M enabled (table at 
> 0x000000F400600000).
> Feb 16 13:22:31 kernel: amdgpu: hwmgr_sw_init smu backed is smu8_smu
> Feb 16 13:22:31 kernel: [drm] Found UVD firmware Version: 1.91 Family 
> ID: 11
> Feb 16 13:22:31 kernel: [drm] UVD ENC is disabled
> Feb 16 13:22:31 kernel: [drm] Found VCE firmware Version: 52.4 Binary 
> ID: 3
> Feb 16 13:22:31 kernel: amdgpu: smu version 27.18.00
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB: values for Engine clock
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         300000
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         480000
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         533340
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         576000
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         626090
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         685720
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         720000
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         757900
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB: Validation clocks:
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:    engine_max_clock: 75790
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:    memory_max_clock: 93300
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:    level           : 8
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB: values for Display clock
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         300000
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         400000
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         496560
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         626090
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         685720
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         757900
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         800000
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         847060
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB: Validation clocks:
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:    engine_max_clock: 75790
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:    memory_max_clock: 93300
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:    level           : 8
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB: values for Memory clock
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         667000
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:         933000
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB: Validation clocks:
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:    engine_max_clock: 75790
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:    memory_max_clock: 93300
> Feb 16 13:22:31 kernel: [drm] DM_PPLIB:    level           : 8
> Feb 16 13:22:31 kernel: [drm] Display Core initialized with v3.2.215!
> Feb 16 13:22:32 kernel: [drm] UVD initialized successfully.
> Feb 16 13:22:32 kernel: [drm] VCE initialized successfully.
> Feb 16 13:22:32 kernel: kfd kfd: amdgpu: Allocated 3969056 bytes on gart
> Feb 16 13:22:32 kernel: amdgpu: sdma_bitmap: f
> Feb 16 13:22:32 kernel: kfd kfd: amdgpu: Failed to resume IOMMU for 
> device 1002:9874
> Feb 16 13:22:32 kernel: kfd kfd: amdgpu: device 1002:9874 NOT added 
> due to errors
> Feb 16 13:22:32 kernel: amdgpu 0000:00:01.0: amdgpu: SE 1, SH per SE 
> 1, CU per SH 8, active_cu_number 6
> Feb 16 13:22:32 kernel: [drm] Initialized amdgpu 3.49.0 20150101 for 
> 0000:00:01.0 on minor 0
> Feb 16 13:22:32 kernel: fbcon: amdgpudrmfb (fb0) is primary device
> Feb 16 13:22:33 kernel: Console: switching to colour frame buffer 
> device 170x48
> Feb 16 13:22:33 kernel: amdgpu 0000:00:01.0: [drm] fb0: amdgpudrmfb 
> frame buffer device
> Feb 16 13:22:33 kernel: audit: type=1334 audit(1676571753.397:17): 
> prog-id=21 op=LOAD
> Feb 16 13:22:33 kernel: audit: type=1130 audit(1676571753.419:18): 
> pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel 
> msg='unit=dbus-broker comm="systemd" exe="/usr/lib/systemd/systemd" 
> hostname=? addr=? terminal=? res=success'
> Feb 16 13:22:33 kernel: audit: type=1130 audit(1676571753.456:19): 
> pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel 
> msg='unit=dracut-initqueue comm="systemd" 
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Feb 16 13:22:33 kernel: audit: type=1130 audit(1676571753.492:20): 
> pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel 
> msg='unit=systemd-fsck-root comm="systemd" 
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> Feb 16 13:22:33 kernel: EXT4-fs (dm-0): mounted filesystem 
> 00107de9-54ef-4784-a03f-61802ed0b350 with ordered data mode. Quota 
> mode: none.
> Feb 16 13:22:36 kernel: ------------[ cut here ]------------
> Feb 16 13:22:36 kernel: smu8_send_msg_to_smc_with_parameter(0x0009, 
> 0x0) timed out after 2814625 us
> Feb 16 13:22:36 kernel: WARNING: CPU: 1 PID: 112 at 
> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu8_smumgr.c:98 
> smu8_send_msg_to_smc_with_parameter+0x103/0x140 [amdgpu]
> Feb 16 13:22:36 kernel: Modules linked in: amdgpu i2c_algo_bit 
> drm_ttm_helper ttm iommu_v2 mfd_core drm_buddy gpu_sched 
> drm_display_helper drm_kms_helper hid_logitech_hidpp drm 
> crct10dif_pclmul crc32_pclmul crc32c_intel r8169 sd_mod 
> ghash_clmulni_intel t10_pi sha512_ssse3 crc64_rocksoft_generic 
> crc64_rocksoft wdat_wdt sp5100_tco hid_logitech_dj crc64 cec video wmi 
> fuse dm_multipath
> Feb 16 13:22:36 kernel: CPU: 1 PID: 112 Comm: kworker/1:3 Not tainted 
> 6.2.0-rc8+ #94
> Feb 16 13:22:36 kernel: Hardware name: HP HP Laptop 15-bw0xx/8332, 
> BIOS F.52 12/03/2019
> Feb 16 13:22:36 kernel: Workqueue: events amdgpu_vce_idle_work_handler 
> [amdgpu]
> Feb 16 13:22:36 kernel: RIP: 
> 0010:smu8_send_msg_to_smc_with_parameter+0x103/0x140 [amdgpu]
> Feb 16 13:22:36 kernel: Code: 20 48 c7 c7 28 1c c1 c0 48 89 c1 48 f7 
> ea 48 89 c8 44 89 e9 48 c1 f8 3f 48 c1 fa 07 48 29 c2 49 89 d0 44 89 
> e2 e8 c5 28 48 e0 <0f> 0b eb b0 bd ea ff ff ff eb a9 48 8b 7b 40 be c0 
> 01 00 00 48 8b
> Feb 16 13:22:36 kernel: RSP: 0018:ffffb997004c7db8 EFLAGS: 00010282
> Feb 16 13:22:36 kernel: RAX: 000000000000004b RBX: ffff8b4e4f596800 
> RCX: 0000000000000000
> Feb 16 13:22:36 kernel: RDX: 0000000000000001 RSI: ffffffffa14cf075 
> RDI: 00000000ffffffff
> Feb 16 13:22:36 kernel: RBP: 00000000ffffffc2 R08: 0000000000000000 
> R09: ffffb997004c7c68
> Feb 16 13:22:36 kernel: R10: 0000000000000003 R11: ffffffffa1d42e48 
> R12: 0000000000000009
> Feb 16 13:22:36 kernel: R13: 0000000000000000 R14: 00000003ded365a4 
> R15: 0000000000000002
> Feb 16 13:22:36 kernel: FS:  0000000000000000(0000) 
> GS:ffff8b4f37480000(0000) knlGS:0000000000000000
> Feb 16 13:22:36 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Feb 16 13:22:36 kernel: CR2: 00007f950a698364 CR3: 0000000033c10000 
> CR4: 00000000001506e0
> Feb 16 13:22:36 kernel: Call Trace:
> Feb 16 13:22:36 kernel:  <TASK>
> Feb 16 13:22:36 kernel:  smum_send_msg_to_smc+0xba/0xf0 [amdgpu]
> Feb 16 13:22:36 kernel:  smu8_dpm_powergate_vce+0x15a/0x180 [amdgpu]
> Feb 16 13:22:36 kernel:  pp_set_powergating_by_smu+0xed/0x1f0 [amdgpu]
> Feb 16 13:22:36 kernel: amdgpu_dpm_set_powergating_by_smu+0x84/0xf0 
> [amdgpu]
> Feb 16 13:22:36 kernel:  amdgpu_dpm_enable_vce+0x29/0xa0 [amdgpu]
> Feb 16 13:22:36 kernel:  process_one_work+0x1c8/0x380
> Feb 16 13:22:36 kernel:  worker_thread+0x4d/0x380
> Feb 16 13:22:36 kernel:  ? _raw_spin_lock_irqsave+0x23/0x50
> Feb 16 13:22:36 kernel:  ? __pfx_worker_thread+0x10/0x10
> Feb 16 13:22:36 kernel:  kthread+0xe9/0x110
> Feb 16 13:22:36 kernel:  ? __pfx_kthread+0x10/0x10
> Feb 16 13:22:36 kernel:  ret_from_fork+0x2c/0x50
> Feb 16 13:22:36 kernel:  </TASK>
> Feb 16 13:22:36 kernel: ---[ end trace 0000000000000000 ]---
> Feb 16 13:22:39 kernel: amdgpu: 
> smu8_send_msg_to_smc_with_parameter(0x0004) aborted; SMU still 
> servicing msg (0x0009)
> Feb 16 13:22:41 kernel: amdgpu: 
> smu8_send_msg_to_smc_with_parameter(0x0007) aborted; SMU still 
> servicing msg (0x0009)
>
> I'm attaching the kernel log for the boot of 6.2-rc8 + patches with 
> the IOMMU errors and amdgpu warnings and timeouts.
>
> Thanks,
>
> Matt
>
> On 2/16/23 00:25, Vasant Hegde wrote:
>> Felix, Jason, Matt,
>>
>>
>> On 2/16/2023 6:05 AM, Felix Kuehling wrote:
>>> [+Shimmer, Aaron]
>>>
>>> Am 2023-02-15 um 10:39 schrieb Bjorn Helgaas:
>>>> [+cc Christian, Xinhui, amd-gfx]
>>>>
>>>> On Fri, Jan 06, 2023 at 01:48:11PM +0800, Baolu Lu wrote:
>>>>> On 1/5/23 11:27 PM, Felix Kuehling wrote:
>>>>>> Am 2023-01-05 um 09:46 schrieb Deucher, Alexander:
>>>>>>>> -----Original Message-----
>>>>>>>> From: Hegde, Vasant <Vasant.Hegde@amd.com>
>>>>>>>> On 1/5/2023 4:07 PM, Baolu Lu wrote:
>>>>>>>>> On 2023/1/5 18:27, Vasant Hegde wrote:
>>>>>>>>>> On 1/5/2023 6:39 AM, Matt Fagnani wrote:
>>>>>>>>>>> I built 6.2-rc2 with the patch applied. The same black
>>>>>>>>>>> screen problem happened with 6.2-rc2 with the patch. I
>>>>>>>>>>> tried to use early kdump with 6.2-rc2 with the patch
>>>>>>>>>>> twice by panicking the kernel with sysrq+alt+c after the
>>>>>>>>>>> black screen happened. The system rebooted after about
>>>>>>>>>>> 10-20 seconds both times, but no kdump and dmesg files
>>>>>>>>>>> were saved in /var/crash. I'm attaching the lspci -vvv
>>>>>>>>>>> output as requested. ...
>>>>>>>>>> Looking into lspci output, it doesn't list ACS feature
>>>>>>>>>> for Graphics card. So with your fix it didn't enable PASID
>>>>>>>>>> and hence it failed to boot. ...
>>>>>>>>> So do you mind telling why does the PASID need to be enabled
>>>>>>>>> for the graphic device? Or in another word, what does the
>>>>>>>>> graphic driver use the PASID for? ...
>>>>>>> The GPU driver uses the pasid for shared virtual memory between
>>>>>>> the CPU and GPU.  I.e., so that the user apps can use the same
>>>>>>> virtual address space on the GPU and the CPU.  It also uses
>>>>>>> pasid to take advantage of recoverable device page faults using
>>>>>>> PRS. ...
>>>>>> Agreed. This applies to GPU computing on some older AMD APUs that
>>>>>> take advantage of memory coherence and IOMMUv2 address translation
>>>>>> to create a shared virtual address space between the CPU and GPU.
>>>>>> In this case it seems to be a Carrizo APU. It is also true for
>>>>>> Raven APUs. ...
>>>>> Thanks for the explanation.
>>>>>
>>>>> This is actually the problem that commit 201007ef707a was trying to
>>>>> fix.  The PCIe fabric routes Memory Requests based on the TLP
>>>>> address, ignoring any PASID (PCIe r6.0, sec 2.2.10.4), so a TLP with
>>>>> PASID that should go upstream to the IOMMU may instead be routed as
>>>>> a P2P Request if its address falls in a bridge window.
>>>>>
>>>>> In SVA case, the IOMMU shares the address space of a user
>>>>> application.  The user application side has no knowledge about the
>>>>> PCI bridge window.  It is entirely possible that the device is
>>>>> programed with a P2P address and results in a disaster.
>>>> Is this stalled?  We explored the idea of changing the PCI core so
>>>> that for devices that use ATS/PRI, we could enable PASID without
>>>> checking for ACS [1], but IIUC we ultimately concluded that it was
>>>> based on a misunderstanding of how ATS Translation Requests are routed
>>>> and that an AMD driver change would be required [2].
>>>>
>>>> So it seems like we still have this regression, and we're running out
>>>> of time before v6.2.
>>>>
>>>> [1] 
>>>> https://lore.kernel.org/all/20230114073420.759989-1-baolu.lu@linux.intel.com/
>>>> [2] https://lore.kernel.org/all/Y91X9MeCOsa67CC6@nvidia.com/
>>> If I understand this correctly, the HW or the BIOS is doing 
>>> something wrong
>>> about reporting ACS. I don't know what the GPU driver can do other 
>>> than add some
>>> quirk to stop using AMD IOMMUv2 on this HW/BIOS.
>>>
>>> It looks like the problem is triggered when the driver calls
>>> amd_iommu_init_device. That's when the first WARNs happen, soon 
>>> followed by a
>>> kernel oops in report_iommu_fault. The driver doesn't know anything 
>>> is wrong
>>> because amd_iommu_init_device seems to return "success". And the 
>>> oops is not in
>>> the GPU driver either.
>> WARN is fixed and its in Joerg's tree.
>> https://lore.kernel.org/all/20230111121503.5931-1-vasant.hegde@amd.com/
>>
>> report_iommu_fault() happened because in amd_iommu_init_device() path 
>> it failed
>> to attach devices to new domain and returned error. But it didn't put 
>> devices
>> back to old domain properly. It left in incosistent state and 
>> resulted in IO
>> page fault. I have proposed series to handle device to domain 
>> attachment failure
>> and better handling of subsequent report_iommu_fault().
>> https://lore.kernel.org/linux-iommu/20230215052642.6016-1-vasant.hegde@amd.com/ 
>>
>>
>>
>> @Matt,
>>    Can you please help to verify above patches on your system where 
>> you hit the
>> issue originally?
>>    (Grab above two series, apply it on top of latest kernel and test it)
>>
>> -Vasant
>>
