Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207B24B1738
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 21:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiBJUrW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 15:47:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbiBJUrV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 15:47:21 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E711090
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 12:47:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoTlQCg1YyJZk1JnS5ZKaJ35pTNZn0sLjgtgSPvb8vmiivthehl0t7h4+WfU/GG+MovNziO0C1u6QkfzpYbMwVGCewKqGcuE0If+GtWxwRuoqGHoY0+eov/tWLNSasg5P3dkU+Py7TaHfxhCmE1Kof8gW313cD6id43rUtwCl2TyX6b1/4zaPnHZYfkvqW9udhoir5tMasOfaMzupnR89tINxL2K91PeldaubjObiSJG5hEV381R1yhl3XIMEbXInTdRERj89PUTKRq+HP4TdnjMPCuLH32zSydu0VEhszbp0IfolZqysHMOnMJr2tEGiF/rksoFv0ZmYam7S7IngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8IUKIHYuxWE0VW/Xzhd9K7eHeBsQVsoN3rRexhQQhQ=;
 b=nK/aaTQ22otMEPCnj14uu7Tc9t/bsRzktpwCvFc5UFET4X6YRc63Fv7dJBa14aK+bpoy8mlDCI+GsTie0MwyhRA/qJN0Fo6Ie5/FZX+nTE4g9vKKZrEHhivK+gH8tHAsXqSusP+ic6S0WFC08hNWQbU3mGDt4HiYGtOCfLI/hu2Tl6vJ5XdyHQmq1oTIoRDbfuxA+br0L8HHpW97moX9gRhYlm2bd77WtG4//R9/LLMPXQRZxQuhMuXznkHwViASSDyPN2vCL02Ojp0IDbbi59O5sQdB/tUQvP1UJ9QCHakz11Nr3QvLvrZxUuBk+YKCi6V+n4iPFLQ2p9hK8NLX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8IUKIHYuxWE0VW/Xzhd9K7eHeBsQVsoN3rRexhQQhQ=;
 b=rs3VyjFPZSa8j7VN8k7VeuUnz/A0xCYmcdxQZFbN48RVt97J2smeczhV9JPls91FM1StWPtJjm6AxpWVsTynO0gkcAPy7qItTr1ja50LntopGF5kmKkFUVPnwxlq9KbyrWYEWrVFM3b9DaPJ8+eBhHH6q4LZJeHRNzVg09olWbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BN8PR12MB3379.namprd12.prod.outlook.com (2603:10b6:408:42::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 20:47:17 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 20:47:16 +0000
Message-ID: <6da46e96-8d71-3159-d4e1-0c744fb357ba@amd.com>
Date:   Thu, 10 Feb 2022 15:47:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "Kumar1, Rahul" <Rahul.Kumar1@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
References: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
 <20220210062308.GB929@wunner.de>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220210062308.GB929@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::40) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae537d6d-7977-4ce0-21d5-08d9ecd685fa
X-MS-TrafficTypeDiagnostic: BN8PR12MB3379:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3379F725FF88EDD5AE40763FEA2F9@BN8PR12MB3379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0S4ifP2X9Em2P5TqXuc3jRObgUn+NAhYDCc8KZeRYSp6abh0njLN+JnQ0+wWe9qe+0tw/7J0sYJV9yIDUceLETFBSfKCAnSHyyqgpAouXMcMTcQotPjE/SfsBGihisCoT/uIbaJRTblONR1Gs5P7MwnYWtFpfCXJHT8XSWn3YlrDQqNFF11b7hHc0XfQ6pfJ4ZrezQUxGgpaX+0Z3tu1byyiqSKIpP6Dy70eAzc1N/cNjHPaEycWKO2wayRitdGH+BBvui24g8MAvGfbVKynaNu7pAepiUHFP3ILLhytL5lZZeiBMHC1qVUNkroPSxUxVgWbthLz5zPQwmr7OECURNx1vkWawM5lp8BOVTgZwIakLq5zU5RTYHUkzmP7eXkSWbC6G5sxTskxgOaySXFDi7TFQU8g+1HHbWq4o5yY+8t7Zzy6ST7Wo+WILCeVbCXToHmlE1fCQJiON80G+qhX96s4XBlXbLy7hGxBJtke/3Ykp9zjghqvW1kQcBMNEmj4CN1n81qITRbnIQEm6gqyqNtiDeIQ4e4JjpauNierf8VjTBrIgCqGzuPp/imgqEQZQjEfjX9GIDmo983MN/f4dD/u67syDSw7jgabYud2LCGDTTcgtjm9PPFc7fAi0A6cFbSd3eJXkP7suaBVc0UFX1OD8VHpDy8t5kUniZFbOg+TB1p/q1jxVfB5Vq/NRqu+846n0lqEpltIm3qemnO+lNjxOjF168L37PEt1/KHzMuv5uFfLPbp49i0Gq7ppvDLvkNfMsVaILVn6FUtnn7muQvchXrXkfBgybPOVMLMbDZUxJTIh2o/VE3bBwH1msXoIWik9n7de4rahmuXto9SRlGyAkF5LC7VjVH2nCusHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(83380400001)(36756003)(6506007)(86362001)(31696002)(186003)(2906002)(2616005)(6512007)(31686004)(66556008)(316002)(53546011)(6666004)(38100700002)(8676002)(8936002)(4326008)(66946007)(66476007)(508600001)(45080400002)(6916009)(44832011)(966005)(54906003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVJwL2pJTHdneXM1SVVENVZSV3hqeG52eWNNNGF6UXptT2ZDblVMUktBVXlJ?=
 =?utf-8?B?alVHUkNJNFpMVTYyaFVJdTlnOUNlY2lDNzl5RERmMEhsMUlSUnNOaFU3cXNx?=
 =?utf-8?B?S2EvL2xSbGNUbGNXQVZkMnZPYnZOaUpvUjczbVFNcUJGajZVNFRoalR3aTRF?=
 =?utf-8?B?VUNVTFJXa0hWODlRc2wxbjVNVGdaSFZxNzBrUHRwTDRHeE5nWHhuMHFHc3VN?=
 =?utf-8?B?UEUweXUzM0lLL3NvOUk0eUFzQSs4dUE0aUJUWVNsWXhjOThhbisrdytXUU51?=
 =?utf-8?B?S0U0Q0FHOUxnVUFJUzBPQ21KR0VOdUlSNWZmczBlV0N2RXg4L0VDclRlMEF4?=
 =?utf-8?B?ZDZ2RStMU3liT2VlSkc1UlVoazJNYnJ3SmUzWm41TXhaQUVVbUg0VytaVG1R?=
 =?utf-8?B?MnhNSzgycnd6RS90WEhDd0FheGFjTlhhZEpRQmV0OVVpZENRMEh3eWN4SVlL?=
 =?utf-8?B?ZUh4b291bWszZnZ4SG5WS3owU3FNdjlFZGwzcTBneVE4ekpwUVpycHFrUWpl?=
 =?utf-8?B?RnUrVUhrV0daYkxtSGUrb1NaU3psUkd2WjBNOWNaSlpISkZlaXpkV2ZpMTRP?=
 =?utf-8?B?aGVkT3dNWVFGcklDdGtQUkt6NEsyVHh1dXhMS1l6T0g0NTU1d1RxWEJKMW5z?=
 =?utf-8?B?cmxFS0UvSmRobWpXMzA4UUl2WTlIdE1nVStYRTNWbmpkelNJbkFYc3VmQm1K?=
 =?utf-8?B?SDgrQ1lnMGJYYWZ4N2lYU2Fmc3J4Rjc1MERlcjVyZ2FpL1MwOURTS0pEcXRZ?=
 =?utf-8?B?Z3lsbzN5aG9iMHZuRGk1d1J2L0RzTloxdml5V2tqb2xzWTA3SHNwSEp3VzlW?=
 =?utf-8?B?NEQ4RVYvRTJyNm1aMy90SE5DdFNLWWdoL25IM0xDSVg0Y3VoRHBsaGlmUWcy?=
 =?utf-8?B?TFc2dXErSWNWYWxEYWl2Sk1ndE9NQnVhdEFGOGdqbE5yN1pOeXRHVk1DYVk0?=
 =?utf-8?B?ZzExZFlpdGZpRjgxVnRDeGZkRnFvNldaVFpxLzIxVUhDWGcyZWwrNVE2QWwy?=
 =?utf-8?B?N1JaT2pYZ3JKcGl6ZU1wcEprbVVUOHBQYTl4Wm40Q3JaWUZlckxWR241QXRh?=
 =?utf-8?B?ejJSVlA2WVk0Umh6NUR3UUV1d0JiM1N2MHhyaTNwNkpNWGxyendPUlduTWVO?=
 =?utf-8?B?L0NYS0dMT3JwRlZ5OUNRWDFMdms1NUNQSU1wOXVxcjBLa3Y4ejZvVHBlaDVD?=
 =?utf-8?B?ZU9XSG5mLzN2d05HUnBuVHVZZ0w0Vkpyb1REVlBmTjIwKzBQUTI2aFppTzZH?=
 =?utf-8?B?V1N6V2RLcDhLWTlhcHdZSlN4SW9xMHRnRUwwUzJJRytSSVNsaUswaC9taW9z?=
 =?utf-8?B?ZGVRbTQ2SElYMnBYcEpjZmFKOWJVSU9UbkdyOVpmWk9OeXdZQzIrWUhvYTZa?=
 =?utf-8?B?SVJrTS9wbC84eFZKS3l2M0dZK284SUR6eUN5SVE1dWRyWkcwRENhZ1AxeStn?=
 =?utf-8?B?YkdwVnJTNUhFUjJ2cnVxZy9jc1NPS1ZDWEUxOGFyTHJtQWJWcEFOWDluTWZP?=
 =?utf-8?B?Y1A5d2dWc3piYTNtWVgwNnNhVUxqaXl6QUVFN2JHWFZQTUprT25hUnY1WlpW?=
 =?utf-8?B?eFN0Z09sWXdBNnZyTlNONUlKODQ3c2pDdmNtc2tvQ0FodlJqNE9XR3U1dDNn?=
 =?utf-8?B?Z2h5WWwvV1hoWGZFQjNFa29RWlJnbm1KVVh2RUFNZm5ORlBxejRhU0hmenha?=
 =?utf-8?B?NEpuWVMvNWtzb3hDbTJUbGJzeEdJdmkxUGJvSnFkam1laFp6Wkp3ZnpGckw5?=
 =?utf-8?B?eGhNejRaTnhTWHZ2WW50WjFMcGFWV3h1cm82bHJhN3NpT2EzeW9JdkJ0VlJE?=
 =?utf-8?B?QU1nbFlwekQ5QnhuOGRaLzBab2xXbDZuS0NBelgzbFBpN1hVNzRwa3QwME9E?=
 =?utf-8?B?ellGZU1kc2dYUXZKZlJLYnN2SGdsU0JiZkZxeVRic0QzVjZ4blRzUTVWaUo5?=
 =?utf-8?B?c3ZvWjRqRW90NjhRZEJPR2M1cGFFQVdHUncyVDl3TnpXQ3doRWFhMUxUTUNP?=
 =?utf-8?B?Y29aeTF0V3VoeXFpalhiaU8ySnloWG1wdFVQUFlHMjBGL1ZlSnhqVEZhM3ow?=
 =?utf-8?B?bWtudm9nOWo0Tkw4bk5ieGRUM0d5alZTTnZldSt1bXMxZmZ4OFd5b0lyVzhH?=
 =?utf-8?B?NllQajV4YXFxNDV3TmZ2ZTBvWE9jYXd3QzQvSXdKaExGR2UvaXdXOVJMWTB5?=
 =?utf-8?B?ZkFFUlhjNFNybGVaemhmVHdwUHd5cDNHL0RrWjNuaTdSOTlpcENqTTE5UXVR?=
 =?utf-8?Q?kDpg2SlzU5MsZsmZR/pcXah1Lh4CLCaSWzzql+82WA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae537d6d-7977-4ce0-21d5-08d9ecd685fa
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 20:47:16.8148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TO0nzwp9zc6yUUZdQV0iuO5Yg2E1D8KpfNObcAEvyjSgat4g8FdQuVEpceoqdVWzta4KDIuaSvafQ97TXkpS1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3379
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

So the patches indeed helped resolving the deadlock but when we try
again to hotplug back there is a link status failure

pcieport 0000:00:01.1: pciehp: Slot(0): Card present
pcieport 0000:00:01.1: Data Link Layer Link Active not set in 1000 msec
pcieport 0000:00:01.1: pciehp: Failed to check link status

and more detailed  bellow,
we are trying to debug but again, you might have a quick insight

Feb 10 23:37:52 amd-BILBY kernel: [   67.885459] amdgpu 0000:05:00.0: 
amdgpu: RAS: optional ras ta ucode is not available
Feb 10 23:37:52 amd-BILBY kernel: [   67.901477] amdgpu 0000:05:00.0: 
amdgpu: RAP: optional rap ta ucode is not available
Feb 10 23:37:52 amd-BILBY kernel: [   67.915376] [drm] kiq ring mec 2 
pipe 1 q 0
Feb 10 23:37:52 amd-BILBY kernel: [   67.920041] amdgpu: restore the 
fine grain parameters
Feb 10 23:37:52 amd-BILBY kernel: [   68.156714] [drm] VCN decode and 
encode initialized successfully(under SPG Mode).
Feb 10 23:37:52 amd-BILBY kernel: [   68.164222] amdgpu 0000:05:00.0: 
amdgpu: ring gfx uses VM inv eng 0 on hub 0
Feb 10 23:37:52 amd-BILBY kernel: [   68.171275] amdgpu 0000:05:00.0: 
amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
Feb 10 23:37:52 amd-BILBY kernel: [   68.178932] amdgpu 0000:05:00.0: 
amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
Feb 10 23:37:52 amd-BILBY kernel: [   68.186589] amdgpu 0000:05:00.0: 
amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
Feb 10 23:37:52 amd-BILBY kernel: [   68.194247] amdgpu 0000:05:00.0: 
amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
Feb 10 23:37:52 amd-BILBY kernel: [   68.201906] amdgpu 0000:05:00.0: 
amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
Feb 10 23:37:52 amd-BILBY kernel: [   68.209562] amdgpu 0000:05:00.0: 
amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
Feb 10 23:37:52 amd-BILBY kernel: [   68.217216] amdgpu 0000:05:00.0: 
amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
Feb 10 23:37:52 amd-BILBY kernel: [   68.224872] amdgpu 0000:05:00.0: 
amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
Feb 10 23:37:52 amd-BILBY kernel: [   68.232616] amdgpu 0000:05:00.0: 
amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
Feb 10 23:37:52 amd-BILBY kernel: [   68.240272] amdgpu 0000:05:00.0: 
amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
Feb 10 23:37:52 amd-BILBY kernel: [   68.247497] amdgpu 0000:05:00.0: 
amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
Feb 10 23:37:52 amd-BILBY kernel: [   68.249433] ata1: SATA link up 6.0 
Gbps (SStatus 133 SControl 300)
Feb 10 23:37:52 amd-BILBY kernel: [   68.254894] amdgpu 0000:05:00.0: 
amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
Feb 10 23:37:52 amd-BILBY kernel: [   68.261315] ata1.00: supports DRM 
functions and may not be fully accessible
Feb 10 23:37:52 amd-BILBY kernel: [   68.268558] amdgpu 0000:05:00.0: 
amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
Feb 10 23:37:52 amd-BILBY kernel: [   68.276173] ata1.00: disabling 
queued TRIM support
Feb 10 23:37:52 amd-BILBY kernel: [   68.283010] amdgpu 0000:05:00.0: 
amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
Feb 10 23:37:52 amd-BILBY kernel: [   68.289443] ata1.00: supports DRM 
functions and may not be fully accessible
Feb 10 23:37:52 amd-BILBY kernel: [   68.302782] ata1.00: disabling 
queued TRIM support
Feb 10 23:37:52 amd-BILBY kernel: [   68.308863] ata1.00: configured for 
UDMA/133
Feb 10 23:37:52 amd-BILBY kernel: [   68.597833] pci 0000:03:00.0: 
Removing from iommu group 21
Feb 10 23:37:52 amd-BILBY kernel: [   68.597991] acpi LNXPOWER:08: 
Turning OFF
Feb 10 23:37:52 amd-BILBY kernel: [   68.605244] pci_bus 0000:03: 
busn_res: [bus 03] is released
Feb 10 23:37:52 amd-BILBY kernel: [   68.611552] acpi LNXPOWER:07: 
Turning OFF
Feb 10 23:37:52 amd-BILBY kernel: [   68.619469] pci 0000:02:00.0: 
Removing from iommu group 20
Feb 10 23:37:52 amd-BILBY kernel: [   68.626121] acpi LNXPOWER:04: 
Turning OFF
Feb 10 23:37:52 amd-BILBY kernel: [   68.632720] pci_bus 0000:02: 
busn_res: [bus 02-03] is released
Feb 10 23:37:52 amd-BILBY kernel: [   68.638105] OOM killer enabled.
Feb 10 23:37:52 amd-BILBY kernel: [   68.645106] pci 0000:01:00.0: 
Removing from iommu group 19
Feb 10 23:37:52 amd-BILBY kernel: [   68.649418] Restarting tasks ... done.
Feb 10 23:37:52 amd-BILBY kernel: [   68.662516] PM: suspend exit
Feb 10 23:37:52 amd-BILBY kernel: [   68.669613] rfkill: input handler 
disabled
Feb 10 23:37:52 amd-BILBY kernel: [   68.695045] show_signal_msg: 28 
callbacks suppressed
Feb 10 23:37:52 amd-BILBY kernel: [   68.695048] glmark2[1894]: segfault 
at 0 ip 00007f799dae6d85 sp 00007ffd34320bc0 error 4 in 
radeonsi_dri.so[7f799d28d000+a94000]
Feb 10 23:37:52 amd-BILBY kernel: [   68.711653] Code: 00 4c 39 ed 74 6f 
49 89 fc eb 1f 66 2e 0f 1f 84 00 00 00 00 00 48 89 ef e8 08 a2 7a ff 49 
8b ac 24 e0 77 00 00 4c 39 ed 74 4b <48> 8b 55 00 48 8b 45 08 48 8b 5d 
10 48 89 42 08 48 89 10 48 c7 45
Feb 10 23:37:53 amd-BILBY kernel: [   69.684921] pcieport 0000:00:01.1: 
AER: Root Port link has been reset
Feb 10 23:37:53 amd-BILBY kernel: [   69.691438] pcieport 0000:00:01.1: 
AER: Device recovery failed
Feb 10 23:37:53 amd-BILBY kernel: [   69.697327] pcieport 0000:00:01.1: 
AER: Multiple Uncorrected (Fatal) error received: 0000:00:01.0
Feb 10 23:37:53 amd-BILBY kernel: [   69.706231] pcieport 0000:00:01.1: 
AER: can't find device of ID0008
Feb 10 23:40:33 amd-BILBY kernel: [  228.769973] sysrq: HELP : 
loglevel(0-9) reboot(b) crash(c) terminate-all-tasks(e) 
memory-full-oom-kill(f) kill-all-tasks(i) thaw-filesystems(j) sak(k) 
show-backtrace-all-active-cpus(l) show-memory-usage(m) 
nice-all-RT-tasks(n) poweroff(o) show-registers(p) show-all-timers(q) 
unraw(r) sync(s) show-task-states(t) unmount(u) force-fb(V) 
show-blocked-tasks(w) dump-ftrace-buffer(z)
Feb 10 23:41:47 amd-BILBY kernel: [  302.759503] pcieport 0000:00:01.1: 
pciehp: Slot(0): Card present
Feb 10 23:41:49 amd-BILBY kernel: [  304.795473] pcieport 0000:00:01.1: 
Data Link Layer Link Active not set in 1000 msec
Feb 10 23:41:49 amd-BILBY kernel: [  304.803146] pcieport 0000:00:01.1: 
pciehp: Failed to check link status
Feb 10 23:42:30 amd-BILBY kernel: [  345.767046] pcieport 0000:00:01.1: 
pciehp: Slot(0): Card present
Feb 10 23:42:32 amd-BILBY kernel: [  347.811119] pcieport 0000:00:01.1: 
Data Link Layer Link Active not set in 1000 msec
Feb 10 23:42:32 amd-BILBY kernel: [  347.818793] pcieport 0000:00:01.1: 
pciehp: Failed to check link status
Feb 10 23:45:13 amd-BILBY kernel: [  508.465497] pcieport 0000:00:01.1: 
pciehp: Slot(0): Card present
Feb 10 23:45:15 amd-BILBY kernel: [  510.505681] pcieport 0000:00:01.1: 
Data Link Layer Link Active not set in 1000 msec
Feb 10 23:45:15 amd-BILBY kernel: [  510.513355] pcieport 0000:00:01.1: 
pciehp: Failed to check link status

Andrey

On 2022-02-10 01:23, Lukas Wunner wrote:
> On Wed, Feb 09, 2022 at 02:54:06PM -0500, Andrey Grodzovsky wrote:
>> Hi, on kernel based on 5.4.2 we are observing a deadlock between
>> reset_lock semaphore and device_lock (dev->mutex). The scenario
>> we do is putting the system to sleep, disconnecting the eGPU
>> from the PCIe bus (through a special SBIOS setting) or by simply
>> removing power to external PCIe cage and waking the
>> system up.
>>
>> I attached the log. Please advise if you have any idea how
>> to work around it ? Since the kernel is old, does anyone
>> have an idea if this issue is known and already solved in later kernels ?
>> We cannot try with latest since our kernel is custom for that platform.
> 
> It is a known issue.  Here's a fix I submitted during the v5.9 cycle:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas%40wunner.de%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cba698967471548d739c108d9ec5dcf6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637800710411446272%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=hrRVL77%2FNRvojfG2WDamDLO5dsqn3Cv6XxNbP0eGum0%3D&amp;reserved=0
> 
> The fix hasn't been applied yet.  I think I need to rework the patch,
> just haven't found the time.
> 
> Since the trigger in your case are AER-handled errors during a
> system sleep transition, you may also want to consider the
> following 2-patch series by Kai-Heng Feng which is currently
> under discussion:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F20220127025418.1989642-1-kai.heng.feng%40canonical.com%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cba698967471548d739c108d9ec5dcf6c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637800710411446272%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=tnLUa6J%2FLqFrlm4CfZ9l26io0bOQ7ip30d26ax05st4%3D&amp;reserved=0
> 
> That series disables AER during a system sleep transition and
> should thus prevent the flood of AER-handled errors you're seeing.
> Once AER is disabled, the reset-induced deadlocks should go away as well.
> 
> Thanks,
> 
> Lukas
