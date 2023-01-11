Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9AD665D81
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 15:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjAKOSO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 09:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239284AbjAKORz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 09:17:55 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A452665
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 06:17:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAgh+1I/+S9lWUF3DZOiFvsXxIKQ00TGcmF/bHh6Qchxgcclj93EaKWz0o+pEHHdl6uoizQX8oSULIXVTsLDbB4NecsHEzR8mMSC2UDt6CVx/6Qde0E30bTbBma5Ydxi9jn2i+XAFG/SotEPUWdbsxlvUQ0lWz+PCfNaM423oV9O9LFqH51FEv9BIRxubwfoVuAo/qAsUMSQ9ZZrrsH9I2zaB37qSN9EKFvZX9Aeb0y4e7PeS7HTFloJ6FMgreOgRFpaICnWq97Y+oQ/nCvwAaTbsvZoBQYa1ca/fPegzJ2uXKMlUXkSABbqRhpf1D3DLYPdz6d1undzPMqEtn2ALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeqHzfC5FBg4jeY4PrNlCfFpNlPsW1HN5Z4avlKTC4s=;
 b=aEZL2io5xWQpztIeQDk3KDtamAO9odXmYzyo6UpS1YZZR+6xRmSwxInNdTXnLTd6rkIiaPUspO6LlNd+2FjWjCGYQjaIi2ZtnIuBHe9tsvD5Za2PIPk2sRsBYPvE/FHsL0bJhih+YxIFqQ9lTVStodkAmM8bYlIzGJhAKPBz2AGb7jDZK66vO/TLli2F5qwfrchoATbbCZnRqaS0MOMUHh6KbZg47LksW4Hpu/fDTQX495uqMfXWGDQT9oLbfxwDC0mBEUqBgJcVLoBHDbpOPtawctkKaTyBrtkOvblOkl6hPOtrqKtxuGeZTWJNAxvrZK8HaPQfrOIFcpZhfEIVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeqHzfC5FBg4jeY4PrNlCfFpNlPsW1HN5Z4avlKTC4s=;
 b=Ko06dCCCV2ZGcKTMT76MElcPt3vRcdffvGQ2oEvgNeQK9Tn0l5+icT2crx1X7aJ7xw17t/EVmoABGMGL0eSyXVdahn8MMfaujiKldjO16SN6D37EWqAHdVHVg2VoqgIGhTlybe/VRP8pZGoSEs9fnoMHifMdWf7pBZgdYUt/10o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 14:17:09 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 14:17:09 +0000
Message-ID: <8c33f83b-3b8c-4714-b812-1e0627fd5537@amd.com>
Date:   Wed, 11 Jan 2023 15:17:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled
 on upstream path"
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-pci@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tony Zhu <tony.zhu@intel.com>, Joerg Roedel <jroedel@suse.de>
References: <20230111085745.401710-1-christian.koenig@amd.com>
 <Y760hRDQbXRlc2Yz@nvidia.com> <0da0f213-5d6a-c692-b9f7-9babb40adc96@amd.com>
 <Y769WqrbEUPQ3pt7@nvidia.com>
 <38a7baf4-9b3b-154b-f764-fa8cfa600858@linux.intel.com>
 <Y77ETB282pVL9/x6@nvidia.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <Y77ETB282pVL9/x6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e8b5e3-3d77-4b2a-8ffd-08daf3de86a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Nidgd8Azqu4BR5db7DIwvSBNvfWBpFgQN8uzry9kIsZzSNNfq+PLa0sQB2YIn0d3Q7vs3zSp2OpVWm3JP1O4Tw2VDZsNuVdEJ7tbDvCWRVZrW5qV934PXKKXA7+WnK94+3IhH2dn7Ti3DP/VSA2FjsPbCoJ474KqhderyhTCfhmWoe46WX59zg4yOgZ/GU51N5hc4ctO+t+08Bauf8d79O5W+L46gG8GzzjApEmMEo+sQGbRSRiEFFcnrtl569hV0J5nDrcb8Ujc2DlOmmayUpc2bXlLPOmp4p3c/bM3JJu0XkgK1YAUcaQdgqOvAe5CNkspIFCjLjJIES9tr33MXPxuctz4Nq37YQNYrvvkD/gHg4sAfCinARQCzg45TD+G29GZRFq0+wdMj9ulbefy45WkU3Ltb2aitPo4jz7+0i/zMUwqhkSuqgS5YNuqW4BSElGnC7QcmWQ8VQgN0+KSoCe+SpXGxDaGnFAliuXHn391jHb6khYMrYqRkXJLeOPaUr+pDLnJn9RJKjAlyq3oFAuwew+jvhlOuQXXBHr6y1yx1PyT9FFmRMUSdbGrzsnzROvrcXLQjR/JQ5/Ibmby4ge+/02DCDyZcxrkFlGHfreI5CPyW2z624Vq7+FcI32ZPXsd9A1kEYRu//zmWY0FpnkNunxrjRv07vd6dngqNpCaGb6uC8MvSSYO25zRSdYVSgS7822AaC1I6qnntcwE8BEIOner6rB+Q6LB/KaVtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199015)(6666004)(6506007)(2906002)(36756003)(8676002)(4326008)(53546011)(5660300002)(8936002)(31686004)(38100700002)(6512007)(478600001)(41300700001)(6486002)(66556008)(66476007)(66946007)(186003)(86362001)(31696002)(2616005)(110136005)(54906003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0NKS05GWDZyQXAyOEZGZjZDa0V3SFh6VzVUYzE5R3F4NlRlR0sraFBGSC9s?=
 =?utf-8?B?cnkwOFlEL0FFZ0N0TTRIR1lGTzhENU5FOTVnUVc2UlNac3dkYUNUdjRWdFg4?=
 =?utf-8?B?RXVCZit5LzJaK1VXTGV5ejk0NVZJRm1yWDAvdEtSVGVaUUVMek53ellIKzEy?=
 =?utf-8?B?WkVBN29QZGdyblNwVmtEOEhoWjhNVWFkV1BYN1dGMFVrU0kyanpHempRUk80?=
 =?utf-8?B?a3FvOXBHejFDTXUrMlF3Uk5UT00za0tuQldqRHJJdjJrTEdTY1FadURlSklw?=
 =?utf-8?B?QUs3eWhyVkpMU1RhY1N3enN1QzkxZFRtUGVFTGVlbE1GWVZoNWpVZCtJeThH?=
 =?utf-8?B?ZVVqWE1yT0duTjhES3VVWktYS2pnQ3FpeFBiUndKTTBjQXJQMWoxTU8zZmpY?=
 =?utf-8?B?TjlCenpMRkprb1AydDhSUWp4czVNcFJWUURtU3pmcG5PaitYdm5XTWxTYWtj?=
 =?utf-8?B?eTVKRU9YcEFjd0doN2F1RzNZSXY5amMzcUZHQm5xRzNBR3o1ZXBndURrUFFt?=
 =?utf-8?B?NERzSUlpVzluY281RjFwS1Q3aGhlcjczdEZzTGJFaDZCN2hVTXdGOGRXM2ZI?=
 =?utf-8?B?bUYxa2VqUFpQRVVBRFRkb1Rob0tTbDZTaC9jbkJzbXVXQ1J5bitsay9zRmJh?=
 =?utf-8?B?ZzZJSlFpenNaOHhFOXEvM081eG5UNzVsY09FMU1iZmYzRFo1YTZ1K0RlOFlG?=
 =?utf-8?B?VTBRTFkvZ2RKMmV5NFQrWEowVVRycER0YU54dlVPbGNVVEFpRHZmb1d3U2RJ?=
 =?utf-8?B?N3FsVFVPMWtjQ3ZWOVpKSk5vQit4aDg3bkQxb01KYk1PMzFNME94T3k3SzhN?=
 =?utf-8?B?ejhETlZjY01hVnlwaWRrcGp0SkxYbDVxeEJDdnJTS2tjYlhkTURZNnY3N3E0?=
 =?utf-8?B?WkllU0NldHBQTkJLUnZmcFY5U2xJaXhNMXZnN3daQmQyTEVVeEVMQVh4cU5I?=
 =?utf-8?B?VVF5OFFQSjN3a25HRlp3OC9QajBQLzM1aFl5MjRCek9SR2lqN1d3eUpMYXBU?=
 =?utf-8?B?NmdsRXRQajQzM3g0eFVuU29YdmExa2JRUHM2VHFlVVphYjRnRlNCelRyZHFv?=
 =?utf-8?B?UlNhRWQxVkVzdkVMUWQ2NXJvRU5SQUU1THNFSXJSYVdwYkgrcXl5OTM5YTRs?=
 =?utf-8?B?S1V5bElQK3JWUVRHMVYzeUUyWGdFWGFrYTVIRG9pSWtiZUxEYXh5WmkzTkd3?=
 =?utf-8?B?a1REeVJzVkVaMU9tU1dETEd5bU5maEE3YWk2dGlmV0VsczZGVkhtc1lZY1lo?=
 =?utf-8?B?d0dxTEF1aERwdE5wYUlnWTJzZW9lTUNyRkZzN2tlcTNOa2drZTU0c0NpMGJx?=
 =?utf-8?B?Z2xscEJNRGExMlExREdKMzBORVZFUllubmZ6ZThXVDcydHBjV201U3lRYmpI?=
 =?utf-8?B?S1ZrcTZDUDZiOVhoM2V3WEMvSDh4eUxyMmk2UkxSUEFoVURId29QUTJFS0NT?=
 =?utf-8?B?c3RBai9RclR3ZFVSS1NwK1VsQlliUllUZlp5czk4bytMYnkxcVgyQWVIMW1H?=
 =?utf-8?B?SGFERUpRcDJhOVAzNzV1cTdieVNqelpmVEJubHlJNjFsVXR2UHNtNGZZVGNk?=
 =?utf-8?B?L1lrYUNZUmNIdUdIaEFNSEEwVDExTEdkRkFaQkRiV2xsWkJTMmFWeTdkYkRF?=
 =?utf-8?B?Z1g4YS9BWkE1WFAvOGd4M3VETTNUVGc0czM5VTFSSExwY2hSSUQ2dDNEdUZS?=
 =?utf-8?B?cWJhWEFZRjcwRm16aThyUk1nUEJKbkszL3lqeEhjSHVGRXZmQ3owbFpWRmxs?=
 =?utf-8?B?Z1pYRUY5WUJlOFRDSDdtSjJlSWNvaVBPZmVSZzhVeTFsUjd6THlkaDUzNHQ1?=
 =?utf-8?B?bVh6U3lETUFHMzFXVkhLWHNGZkhQVDhBWm9MWTQvZ0ZoNTJWRTFaMGJ6eU9F?=
 =?utf-8?B?blpZeHVUVVBLTitNY2dZSVd2dWptTlV2VnBtOE1NR2p5bWtoZGxGWTZFSktw?=
 =?utf-8?B?QlNkSWMvNmpwbWhWNzAyaWxQaFBPRmJwT0FkWEd4TjJRczA3bG9SQTUxanp6?=
 =?utf-8?B?bEtKcFRXTjVEVnhXNkhJdlNOMURORGlad0hCNU1FRVZUVDhybTV3dUkwVmxm?=
 =?utf-8?B?QmNRSjNRODBXTXptTE00ZTlXTFMyajJ4dXBuN0p6Mzg4ZFBJcU5STWs0cHBS?=
 =?utf-8?B?ZDBVcGFjU2pCOFpBb3BBclNFU2t3U29NOHl4VUJDaHIxaUNodG01TEpkOUNY?=
 =?utf-8?Q?CVt8Cg3ew29l1I5g/p30M5GAroHv38nc1nSoG+Nt7Cr4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e8b5e3-3d77-4b2a-8ffd-08daf3de86a7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 14:17:09.6107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XU3LFsu6V6oRRNsafL4ftDh4FozM9UEXo72yUIVWVrMJpN/jN4R978iFDBpXLuC5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 11.01.23 um 15:14 schrieb Jason Gunthorpe:
> On Wed, Jan 11, 2023 at 09:54:03PM +0800, Baolu Lu wrote:
>> On 2023/1/11 21:44, Jason Gunthorpe wrote:
>>>> iommu_enable_pci_caps() in the Intel IOMMU driver. This also does some
>>>> handling for ATS, so here we could check the info->ats_supported flag if ACS
>>>> needs to be checked or not.
>>> *groan*  this is seems wrong 🙁 Lu why are we doing this inside iommu
>>> drivers instead of in the device drivers to declare they want to use
>>> PASID?
>> Currently it's common to enable pasid in the IOMMU drivers, but device
>> driver has more knowledge of the device, hence it makes more sense to
>> move pci_enable_pasid() to the device driver.
> So, lets fix it that way.
>
> Add the flag to the pci_enable_pasid(), set the flag in the AMD
> IOMMU's special AMD GPU only path assuming the device will always use
> ATS

That will fix at least this the AMD use case.

> Do not set the flag in the other iommu drivers

Don't we have other hardware which supports ATS as well and might run 
into the same problem?

Regards,
Christian.

>
> Baolu will send a series to move the pasid enabling from the common
> path to the drivers
>
> Jason

