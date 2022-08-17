Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15B0596CA0
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 12:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbiHQKKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 06:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiHQKKw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 06:10:52 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F48E54CB4;
        Wed, 17 Aug 2022 03:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3MTG4yCCZk6qzJKk5eUW2VBnz9TfSTiljm8EyYlQ/c4hSQHGg4Ppr3/zrxbrXHblKj5yp+vBBfZIjs3SC+6vS659GcevySpos8oR7/o1NYvMy36N4RcMyYRW0WF8oCBKtrUMtXgYKiIv21BIPUpOWf5U5goP0ftw4cyz87cAiay+wq+mgdbfaNzb3S3z+YH5n9yuWVruPAltQXOP4MNCG2HqbMzkOjTnYhafR0MTTSx9KbwPvGVHvT6P0hNwZnDZJamrNSIiYp28kB4ISWbcWRgnTTiTliDJoVbTDBCOqmS5be1AGeLWLlvBhkJMO0iplbwS0rWDIXFAgn5znw3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELA/LLDHdb7/6Mlej4kFjhbK6L1dKInKuJcTp124QqU=;
 b=RyVpiUHfRTblmwb4TUYqVTG/MZQr25AQGc5c+l/7g6DUj3J6SMhjlzXZcNyVNd/mxp9S0/3rQ7hroVvktb9LoTm2qUeD7+qTietT+813CdxQaAumuYH4lq/NGDdVM60nMyLx9l11nhdV3EaucIBBWB3bjNpz4VRSIUs/uYQuqBiZUMyT+RSN/tQkbN4szLgpkwv7WgLkY2TcqzcPW+GkC7cmDR5wr9JfLJTpfZliwg78xmKKsKj1+RzINv7HkN9EoPqQ2qynXNwUW0Yelw3N5TfBOdfKACaemETOogGktA9VhFTBBu84/4QaHI+RcuIfKDILwT3zUDAPYMnBaxWWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELA/LLDHdb7/6Mlej4kFjhbK6L1dKInKuJcTp124QqU=;
 b=pLyE+TkV54SVw0XXh6lVq4EHyq+rLeaAcmBN6RitMGwHb76fVWBk+ndtgvgNHfBdy6a6xhQp0CN0SCCYPvEIiOwpdNUtAMiYKmXKMZ23SnntaXyjWKPGvH0fJGkucGGhFufWZ6ew3jV2nKdY2VBkXQF/RLmh0B02l5QYOZpacic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Wed, 17 Aug 2022 10:10:48 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5504.020; Wed, 17 Aug 2022
 10:10:48 +0000
Message-ID: <a15fe381-1f41-2c92-2ef1-0b4eb30a5142@amd.com>
Date:   Wed, 17 Aug 2022 12:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] PCI: Expose resource resizing through sysfs
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org
References: <166067824399.1885802.12557332818208187324.stgit@omen>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <166067824399.1885802.12557332818208187324.stgit@omen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0021.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::34) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9748830e-029a-4437-6dbd-08da8038c18c
X-MS-TrafficTypeDiagnostic: DM4PR12MB6543:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LomHn/wOtS2hsy17pvQ8r68J6wVI04QTWeOMT51IkXP+5X/J9b5idq+SmD6sE6lKZvzRaeovvdDh0RLROB+5gGII1SKysV26rTSTNmtiyZU5N/qoQhpo+eFlDllPxiji4iSNQeG3dAxv9GmI58bqNWLtsitFhtQAOme168mHjr7G0V6W6VKmT7oI6IZ23oas2dxfCJ8s5fh+Rwvr2px+wuzVXlCCxQQMjOsExqaqsboKRCxHMLWGzP4o8mrpoYA8KJPfBarfAmcdxWTcUocWpVm/g7Ie1WfyYFniHEspsAF+ZOk/vESXWFNsRNtCKY7b5CxscrCHyNUdQIyaTHw0/tBd7KufY4TkLuwBDj4OYHB3DaFEyUeYtw2+Opzr0pFO4BZv7js/6haiRWnA2aVF7UR6DWUCjEgqm0y23WPP6VFgtYpkAaF3cjshznf17iOD/S4B6uiqO5dKM/vISKcMLno1iEOiNHrE7tQ/u+UyQj341L0j6pgxSU75bUKQmomaLd4JeaVUIPHHzQiD6cfi6qyUvL4ARZwFnqkaz2McG6lrZEjGwV73Z/XyagsiJBg6hXACX2xeh4XiSk9vBUQJ5zD3LgRlK5H5a0QnGtP5mZrknoaAWpMaR/2Juw5ntzVOwUbS2oM04Sgl7YQEIIsq7O9FQU9G0W6xFQcqUU/wKEHDyHk6s9HmrxLNij5tw4K2FHijUcrwvE30p0dkQ1Jh3QyiWTkGtL0SNmkBeTiZ97pPXaJD+aFBVBiZQdh6KfkKAlQenLp0pG07vI97X7mdh03NLfWD7Hk9oDhMVr3IshuYem1MQl5+7dYv9wUzjEuMOP3ZA76utREtKsz+KkUeCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(6506007)(6666004)(38100700002)(5660300002)(41300700001)(31686004)(2906002)(36756003)(66946007)(31696002)(6486002)(86362001)(66556008)(66476007)(8676002)(4326008)(8936002)(316002)(478600001)(66574015)(2616005)(83380400001)(186003)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1hxejk5ZDVMSjIxVzVaQ2lLYml3Y2o4NWdlNVJ1RVJvMGFQdWlZSldzYlJa?=
 =?utf-8?B?MHdPa3piOGQwRmFaZW9DazFpOUZ4czc1Myt2N2FvcnBwN04rRFpvMTh1K2JT?=
 =?utf-8?B?Y2xnSXZBcU4xbnFZNTJybFRUanVwc09CZXpnUm5SeDNuNkdtckJ6L2t5UmRn?=
 =?utf-8?B?Q3l5c0dDSEU5UHFVaUdMK3UzT0NPNDA5WExvbzljV3k1THRaamFUbWZTMmcw?=
 =?utf-8?B?WERaK1FLdVVTNGJhWVB4ejdwMU8xNC9WZVY2T1lQb1NNNkk4Q1c3MEdaUjls?=
 =?utf-8?B?TlgvM2VjUDdHaFRjNjdaZU9yZEhxY1ErYmMwWFR6MUdycFNlRUl6LzJ2a21J?=
 =?utf-8?B?dGZHSXM4MlRZY1RrVTNybGtUcEIvVnJ2ZG12ako5MlByVXVoZnlia3FIRjkv?=
 =?utf-8?B?Y21sN0VaVUUwVHk0ZCt4ejJEYTdwRmVoa1lIYjkrNEV6Ull2TlVOd2xtS0RS?=
 =?utf-8?B?NHhqN0QrcktWTW8wcmVvZGZVK2Rzb1c1dlg0cCsxK3JtclQ3Szkxb1p2Z3NL?=
 =?utf-8?B?d3hOVTFQZzREZnFRZ2oycUV1NDJBVzhmcjhRVVVReU5RMlNEd1Y4TEh0Z21i?=
 =?utf-8?B?bGNlZENGeEpYMXFOeERUdWZkYUdaQUFzVnQ0SUYrNXdIV2c0ZWNLZG9ncW1I?=
 =?utf-8?B?RDBZZ0V2VjY1N25iOE5hTlBOTnFiYnlmQzJkZ1ZLaW81U0FqdU0rcmxEaGp5?=
 =?utf-8?B?T3RlOVJrUnEwZkFPVkpxUmYvREhqYy9sUEFJUTRucXJCbGw3VnFpUDJ5Y2tU?=
 =?utf-8?B?OTU3dGJqcEs1NTZNMVlIeDRSS2NmNDNVRE5wZm1QSWREc1pwOTFOcGdNSCtO?=
 =?utf-8?B?MVF3YndIWTNxVkNiTk9Ec2w1TVNkbWpBZ29RZnZHbHFhcW9ITFRKc2NkWTdM?=
 =?utf-8?B?T0V0emtFQ2pwODExVHArTXBIS01HWndTRFVteVhHYlNidWtVcnJKczE5U1Ay?=
 =?utf-8?B?bWJBclI3SThxYTQ3bHVrcWc1UFNlY2xHWk5nZVZDM0VIMzh4cHZqalJEczNl?=
 =?utf-8?B?U0VoUGZPMTlqdStoUWFheXBhdFF5WTFqSFdxZzZoM3ZNSEMzUCtIWExvL253?=
 =?utf-8?B?SnI5b2hVc0FVZmVpM3pJeTQ2QTRWZERCVFhKbTB5YXgxZTU2Rnk0MWdUblhp?=
 =?utf-8?B?T1hTSk9PbjhmLzd1UHFWWEJZVjVpK1NRa1B4UEZ4NXQ3SGdXWFBpYzdrelda?=
 =?utf-8?B?cEF5VnVEbGdBbWg4TmtNdkpaU25FVk5oTWpXSUJJTXRWZno4K2F4cHJmLytK?=
 =?utf-8?B?NkZ0dDhWK2o5dFVqeE9iK29UMGVDbDlCeDQ2UzljUXg0QmtaSnVmYTJpdm1H?=
 =?utf-8?B?ekR1a1F0UExBNW5XMnJhSFdXWG5rcXcxM1dtUFk3b3BlUHN5TkpGU1ZvWTBF?=
 =?utf-8?B?VzdVL295ckN4NnViWVNxSGNXeVZUcS9lYmtXVWlkd2Fxc29JSU5Ubi9uT3Ar?=
 =?utf-8?B?NUdXSjZVL0xVeG5yeWpoMTdsMTZRSXZScSt2WXdHNURUZ2piZVFrMU5nbE82?=
 =?utf-8?B?bU5GbTVwend3ZDBsaE9MY2JhM3BmamJBRy94ZkkwN3pjVWNZMkpkL3l5QUpz?=
 =?utf-8?B?N0dKQzhkb1ZhT2RqRE5qdW5kUFdMQXRsdFRWTVowMDNtNVJCUjFYdHhTTHFH?=
 =?utf-8?B?aEdTMjJaTHU3WVE2UHgyUDU1ck9obWFtQU9vTnAyRjltODNkbzFkUk5DVnU3?=
 =?utf-8?B?RDFuK1hLVUNVdlc5MHp4L3hTdUJ4RmxSbGRqSXdOUEsyckxwRElMVXpxOSs4?=
 =?utf-8?B?UjdmWjlwZmxqOGkvVjg4dlliaGphVVI1MUlNQnBvNkN3UW5KQzNhaG5JTm9B?=
 =?utf-8?B?SGl2MUppOFAwSEhkZnp2aHA0emQrOTQ0Q0dXRHpuRmhta0l5LzdjQ2l3ZmlK?=
 =?utf-8?B?MDVkcnc2M0p2bHVSdEFLcFBWSDFRbnlVdytBQWVXZ1kzQ2dMQjloMnB3bkdY?=
 =?utf-8?B?Q0VmblhKVVQ3V1piUnZHenEzWUI5c1VDeWhPckpFR2VNSlBWNDhyaFcrUVk3?=
 =?utf-8?B?M0Zjd0xaTzhPWlA2M1g1a0hwaEYrcmtNcVVtYW1jQjdCY0VIK3Z2U1cxREtp?=
 =?utf-8?B?QjlVN2FFRkJPWmxZbHBDc2FsVTRXSS95U2xvajVyWFdwS2ZjTkVKS0RFdGxW?=
 =?utf-8?Q?jjqKMAI4IC5UZpvgBb8HGpVul?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9748830e-029a-4437-6dbd-08da8038c18c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 10:10:48.1638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBJYIOKzDdVTXkvxckKSuRWQ3uW+rAcH/DvohPUk7E+2AKISDm65wXTTsZV/jE/G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 16.08.22 um 21:39 schrieb Alex Williamson:
> We have a couple graphics drivers making use of PCIe Resizable BARs
> now, but I've been trying to figure out how we can make use of such
> features for devices assigned to a VM.  This is a proposal for a
> rather basic interface in sysfs such that we have the ability to
> pre-enable larger BARs before we bind devices to vfio-pci and
> attach them to a VM.

Ah, yes please.

I was considering doing this myself just for testing while adding the 
rebar support for the GFX drivers, but then just implementing it on the 
GFX side was simpler.

I would just add a warning that resizing BARs can easily crash the 
system even when no driver directly claimed the resource or PCIe device.

It literally took me weeks to figure out that I need to kick out the EFI 
framebuffer driver before trying to resize the BAR or otherwise I just 
get a hung system.

> Along the way I found a double-free in the error path of creating
> resource attributes, that can certainly be pulled separately (1/).
>
> I'm using an RTX6000 for testing, which unexpectedly only supports
> REBAR with smaller than default sizes, which led me to question
> why we have such heavy requirements for shrinking resources (2/).

Oh, that's easy. You got tons of ARM boards with less than 512MiB of 
address space per root PCIe complex.

If you want to get a GPU working on those you need to decrease the BAR 
size or otherwise you won't be able to fit 256MiB VRAM BAR + register 
BAR into the same hole for the PCIe root complex.

An alternative explanation is that at least AMD produced some boards 
with a messed up resize configuration word. But on those you only got 
256MiB, 512MiB and 1GiB potential BAR sizes IIRC.

Anyway, with an appropriate warning added to the sysfs documentation the 
patch #2 and #3 are Acked-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

>
> The final patch proposes the sysfs interface and I'll leave the
> discussion there for whether this is a good approach.  Thanks,
>
> Alex
> ---
>
> Alex Williamson (3):
>        PCI: Fix double-free in resource attribute error path
>        PCI: Skip reassigning bridge resources if reducing BAR size
>        PCI: Expose PCIe Resizable BAR support via sysfs
>
>
>   Documentation/ABI/testing/sysfs-bus-pci |  27 +++++
>   drivers/pci/pci-sysfs.c                 | 126 +++++++++++++++++++++++-
>   drivers/pci/setup-res.c                 |   2 +-
>   include/linux/pci.h                     |   1 +
>   4 files changed, 154 insertions(+), 2 deletions(-)
>

