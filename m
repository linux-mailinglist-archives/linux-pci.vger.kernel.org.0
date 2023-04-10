Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08056DCC36
	for <lists+linux-pci@lfdr.de>; Mon, 10 Apr 2023 22:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjDJUgY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Apr 2023 16:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJUgX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2023 16:36:23 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F619A3
        for <linux-pci@vger.kernel.org>; Mon, 10 Apr 2023 13:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSNIbMrs/G3U2PUMYzEw9NMB5cjOLe4O+aiRzVOti79o9PCAyLjrlTzt/EstkjNfYvs+JiLEbLpKDaC20cTws/e6aGNdltpwBdQK9mvmP7b1H1bL7yIEVIjuN8tZT9XSay3Jahw8LVyBrK4Y6iw0MGRGmAXVTR3wKEZv5fX8cOwdyuTQ2tG2kCnK+W5LjKcsQu9/HQpx5a2nCUAvXcgIKzLIfX/8NbsL/cqXsPX5ncvIvplSM/YZJvGLKCarrugNXBgALFBozy1vrtHX3yLVXoLCdMqsIO8GSIgaRgQxMwblLP6v04Cr2RTvVp3iv2y83KfKqJyue+YUFSJnT1bxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiKV5hyUNL1LDvPoZ95o9+l1foALHrwcHiV2gmZ8v9c=;
 b=oCbRAtw0O0ZhCysSsPo6LawiZuTfg1xMExIDd5e1TKQXc0l2ySMomjLUZBarkhvTI+8HdwYC9f8/QSHnJT9aXet0M59WPcSWDVr2GCk2Oo4FEJcN5tLwFv6Q8hgMZRgG+rL8AWuJSwPOkvQX9HLQOj2SAhM9+pkWJU8MBj2hqp9OD1uYVX1jOvtGpW1PtV/5hF15xUGZTQk7l0Ch0EYAr0H0E4tKd9K1N3JQiJy3aZeayBkGdaF99s363Ft+rUXuyQW+CCucF/bQrIpcmlN8pHosWYffsiohwScHPFiKamF1XMba/+u0SbXTKeVc88xeSocXekM02QM8D37Mg1LS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiKV5hyUNL1LDvPoZ95o9+l1foALHrwcHiV2gmZ8v9c=;
 b=MmV+GYjKSESC9H0mVhBdYcJlwpe4cJKYDEWbMAHoR3nTc4GM8cA/FEEWc7/EKrik1gvilJI8aToaOpDfVG7V03gD86o1OKOPiUtBWcFwbSnIB1b5uxmJ6sL8O4XXbtit+BYljgrMgpP8qmDysS/Aq5JbQBJFtNbEPDKSNBtFfVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 20:36:20 +0000
Received: from PH8PR12MB7109.namprd12.prod.outlook.com
 ([fe80::768e:e89d:1481:b7c8]) by PH8PR12MB7109.namprd12.prod.outlook.com
 ([fe80::768e:e89d:1481:b7c8%7]) with mapi id 15.20.6277.035; Mon, 10 Apr 2023
 20:36:20 +0000
Message-ID: <f0742b10-9caf-d66e-460a-0703d7ce2fc2@amd.com>
Date:   Mon, 10 Apr 2023 16:36:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] PCI/hotplug: Replaced down_write_nested with
 hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Anatoli Antonovitch <a.antonovitch@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <1d474514-4d28-d41f-52cd-972ca7e3fc1d@amd.com>
 <20230217160358.GA3404296@bhelgaas>
 <BL1PR12MB51445CE9642195E9DEBC9CB8F7A19@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230219202144.GA12404@wunner.de>
Content-Language: en-US
From:   Anatoli Antonovitch <anatoli.antonovitch@amd.com>
In-Reply-To: <20230219202144.GA12404@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::31) To PH8PR12MB7109.namprd12.prod.outlook.com
 (2603:10b6:510:22f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7109:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 53295a94-ca06-4102-2b3c-08db3a033dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RT8Z+XqAL5YGw/OsGx8xi4gCFlEFgVgWDJ9H41dYWDASs6Mdx0AC6hwRQ9Hj4Cz8CncnKRthi6AAx0zEAQiDYs8KHCebA7Y1uz+zFmN+yw6zGlr1Iv0rp5Ku8dtmnxTJLsz4/zZ6lr+iCvgtxynE2kWgRxLlXQ6LDS0hTilg1+Lza0KL7YK18yXltz4pCkgKqbvhYdz9NFcT9ydlsXrppFbxrdbZ/9M9EpStUtSXC78+gQNlq82oA6DS/Sueh9hEdXj+eg835OqyxemY1sI7JmAmxvouIuRlzE4u4vkhtZPWQ1nJGhl68SfWt57Mpg+inT3mPLHxQ1tyJiZv4rbELpCdlGJnumdPKWI7u4wPDwsBh4B8touANLpQ+8els1N6vXQfW9jysEiuatJMOqxyCoExCSxg50cQZ6Fbm80ok3aL/3pmho5A4onS4cKtgAzwH68xnGKOqdiMFQ5BIPMpFLxciMoto5FaNUccTNPpyyUU/OYYA3axU/e1tNkiHDx+nVZ3jCSzgv8tWTiZU8YZVljOLvsBzbEytA0kp998KroyepwiXf7xzQpdmomyPaUwVj5qFqIZ5UjYzlhrvIx72Ml5WLLuWzQX+QX8WbwGxyLQ+mCDBh+7czs7TdkkbT4qdx4dV6cm78xYGko45BE5tyJvOzOTGvJ2DkUJMtn7o7b/OVOzkLV1wMRJSqHXjZnr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199021)(31686004)(478600001)(31696002)(86362001)(83380400001)(36756003)(38100700002)(2616005)(6666004)(6486002)(966005)(2906002)(316002)(6506007)(186003)(44832011)(54906003)(53546011)(6512007)(26005)(66476007)(8676002)(66556008)(6916009)(8936002)(5660300002)(41300700001)(4326008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVzY2NLdVBXRzUzQWprMTZabUxoais4TzZmZkZJS0NFS1VkUDFSU3MyRXM4?=
 =?utf-8?B?bE1mcGlCN1g2QzluOXlxT1NmZ0Rsb0hRcFNKSG5EeS83R1ZBYW9LRnREeDJS?=
 =?utf-8?B?Ukd4NTdUZFJ1Ukg3b3BodFUyVmRKKzhpb0d3b1I0MFlPSjVTd0hFbGFxeVpv?=
 =?utf-8?B?a1lGQ0E5ZVpqZURyQnhsMFNRMW8zYkw1aU5KQlJKNVlFckFDaTYzV01CbjFQ?=
 =?utf-8?B?YVMvSTFlMmhpOTdxT0NaMitHUzQ1bWd3K2RWRjZ1NktLRTZjQkVNTnJ2NWZQ?=
 =?utf-8?B?VHR5YTVkTk1Gc3BlRVlGTlRHVnlacEo3N3BCV3gycjVjVVlZcUdIY1piYnBx?=
 =?utf-8?B?QkMxTDUybFBXQWhOUkJIQm9BMUQ4YXVPRUxwVGVrdFp6R0ZjUnNmWHdjYWtL?=
 =?utf-8?B?UFRMdWVpNnkvaUkzdnllMnYyVldWSlJoanI2eFpVLytyZ1dPWWdXMFJuMVRj?=
 =?utf-8?B?SUx3bkwxN3pVbUE5eEU2L1E4bEM5YW9PMFFMWkxua1RPUzNKaEVvSmZsU1h2?=
 =?utf-8?B?TXphaG5TQVZhcW02QUFzRTFGUjYyb2FFcllUcWk3M1o1MWF6bVY0ZkFNbWVm?=
 =?utf-8?B?V3BrQmVENjdyWEhtRUwxQkw2R2ppa2wxd0UvWkk2ZVJuWGY1Y0JXbCttNjVl?=
 =?utf-8?B?eW9wbkI3YnVRUWdCRzc1UTQrem9FUlg4T1ZpWHdsWjhEWVRMZW1YS2Z6TTJB?=
 =?utf-8?B?QW9IZDV4YmVKVk9sNDJGeG1ubXNxdWVWUG5wMzhaVk9YaHpyUXE1a25mSVVv?=
 =?utf-8?B?aUVpVjNVZng0N21RTmJ0YVlLSitxSlQxVjN3em1xdHNFR3dIV3N6dlFiRWNa?=
 =?utf-8?B?WGRzNWVKRm1IaUFrY2VrSmN2QmIvK05UZjhaTTh3L1o2bTk3aVZheHZhQ3FC?=
 =?utf-8?B?VFBXR016ZHhBVHJxaThFdlRpazljZXFWYWFqbngvTitYKzV0YndXTFhLRXp0?=
 =?utf-8?B?ZTZyajRWUlE5YmM2V3E1RHdLNnFEc1I0RDZSZHJUMHkyTnFKSEZaS2ZxdkFG?=
 =?utf-8?B?MkY0M2JWTGVPaFpiYWY1UnQreEg3YWFHUHRMOElHTGxKTmlORS9OZlFBekpX?=
 =?utf-8?B?c0lkZjRjUHhzSUpCT2NDSXZQVklxdXpPTEt6VGRPV0Ywa0cyRlJtZWpva29B?=
 =?utf-8?B?eWI2RWNrYmxYclhocitRVTRmRXcxWU10MjEveXNkazlJd0FqNTFWL1orM2xX?=
 =?utf-8?B?WW10VHIreitHM2Y2SVkwd2g1Y2plblpCdE1aK1VCZStsYWVyN3JJT1N6K1Zo?=
 =?utf-8?B?b2JmZTlVMVIrS1ZiQjZIN0VQRDBldUc5bHYwVStFUkxlQUtqcmFKTEpZOVpJ?=
 =?utf-8?B?b0VjY0dRU01JTk10bFh6aExZanpnY3Buc1Jib01TTnBmbDZVZDhIbkNmaHNI?=
 =?utf-8?B?MHYrZHZ4TlZSdk44Smc3WUNMOUoyQlZEN2Z2K3hZZ0EwYm9zZ0pmQTJhVWkr?=
 =?utf-8?B?bzZpcVMvbkorZWZDNTJqejVrZ3B5MnI1N05xRU5zTzBsUDRrblR1VEdlNGJT?=
 =?utf-8?B?UzJjZ09DSXZ0bTBYdHhUaUY3SVo2WmVZV2h3ei91cHBUWXN0NmpWN0NoSmE3?=
 =?utf-8?B?YkdrSlliTHFGQmtEZlM4VElDTmFvMUpKdVdFMzc5eFpoL1hzUGlBS0toU3F2?=
 =?utf-8?B?QjIzaWZvV2FUQTN4QzZOa0huTUM4Y0orV3BPUFhkZndDa3NpUHhOM2M1Rzlx?=
 =?utf-8?B?dGhHaWJPZzR1SzFBcU02bGszTkt6WWxMSEV2QTd4V2pDcTRIeFFWK2dpNTBI?=
 =?utf-8?B?OFZ2YkJRT1Jka20wVEZETjlVZ2lKTTl1akdBa1hZNGc0YXNQZzVWK0oxNkNL?=
 =?utf-8?B?UG4yRldZVmtWYllxbWI0TTNjWElZeXFZRkMzTXBmNGlKYm9jTnlvMDlzQ2E4?=
 =?utf-8?B?NUVHLzJ3Um03cURaTjEyUDJxOVZxaUdsbVFrejRVcXpxZ2ZvWFZ4K1RhNkpU?=
 =?utf-8?B?aldhM3ZLWG9YMHp6ekppTHhIVXpVbHNkc3JacmU5cm5oQmNzZytJNVJxZWNL?=
 =?utf-8?B?Nmg4Y0c4QzVvZC85anZVdVBEMHhiaFEwajQxNzc3dXhkR01abWg4NW1oRk56?=
 =?utf-8?B?SHNETU5ERzRGbzN2T2ZjYmh2RDc5bmZqVW85L3QrYnNVaXF0S0FWM3V3Zlk5?=
 =?utf-8?Q?Z89OqXYvapNpW2bd4fy0/BM7U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53295a94-ca06-4102-2b3c-08db3a033dba
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 20:36:20.1073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKufzAMmavWYrnb7WxqjkN8fQZAswkU7HD1gm+SHVX/Ok+Na29XeulWnv/fdisplKRfbOH1gKRp89WnUQ3f0fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Lukas.

The patch has been tested with current kernel 6.3.0-rc5 on the same setup.
The deadlock between reset_lock and device_lock has been fixed.

See details in the dmesg log: dmesg_6.3.0-rc5_fix.txt in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=215590

Thanks,
Anatoli

On 2023-02-19 15:21, Lukas Wunner wrote:
> On Fri, Feb 17, 2023 at 06:37:54PM +0000, Deucher, Alexander wrote:
>>> From: Bjorn Helgaas <helgaas@kernel.org>
>>> On Mon, Feb 13, 2023 at 09:59:52AM -0500, Anatoli Antonovitch wrote:
>>>> On 2023-01-23 14:30, Anatoli Antonovitch wrote:
>>>>> I do not see a deadlock, when applying the following old patch:
>>>>> https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/
>>>> Can we revisit the patches again to get a fix?
>>>> The issue still reproduce and visible in the kernel 6.2.0-rc8.
>>> This old patch would need to be updated and reposted.  There was a 0-day
>>> bot issue and a question to be resolved.  Maybe this is all already resolved,
>>> but it needs to be posted and tested with a current kernel.
>> Lukas, can you resend that patch?  We can test it.
> I'm working on a patch which aims to solve these deadlocks differently,
> by reducing the critical sections for which the reset_lock is held.
> Please stand by.
>
> Thanks,
>
> Lukas
