Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7856E738F47
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 20:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjFUSzj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 14:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjFUSzU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 14:55:20 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7F71FED;
        Wed, 21 Jun 2023 11:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsGVxJeBi7OC1lBn1mLTm3+dkj4dG7Eecw8QDWsVgeLug/dR7pHG0WX30x70vs6oM2ahdddd75ujxL6bM/aCaNGhhvTw2Yl8dxAcA0Mai/M2Aab2cEW2ds91YA86XlnM50YAXJeRlU3JfC/Yup+v1nTm6HAXJuq/0Ff1uRlU9roK+dM+4opDFBQmQhuwjtuYviYkk5fIP6VCNNbvTB1oUy/jw2Rexj3XwMkVDIWHfx5kXfDtJ2VePy7cTZ9cwRDNN+Dhn/J9sj9CMODojDZAQJS9fo7LgTxRjRz2u5pg/TKEzNDPQYUM9BXNTgB2NM1lsGNhnOkHMiKZEc2xfhKV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbsykAfJkgDLJx/l/oQbK+V4uvg6LPXSoJTQwZ1rDv4=;
 b=jRCWH8u508ED4HlmJr4K6ITgyQI05aQQOk8sMU4DeNKhK/X3ioTSf7aVKibZzCki6QxheWZ2dUJMI15xf8Xo40BQslXJVgMPnrpSRxnEgjpBa5GNoS18RUSWYV6aZpHazYy01EOFghauTvSk+ZMluZOL/lFP3BhVGSWzqQpT4CYQRkZu9G1Uwa314SF5EtqEZZRf2JEbtOgRyPYan+DhfRm+EihzHjEnsxowBbOO4dzKmMemBW07cmUlwZ6H8TW/2GtHbjuN+hZfDu/O3wdEFtWUGyGAxyJpm/ZCQyHds6ulhCzBFHeENTWiRcs7ZdLxmcxLj8+YDEUriLlqDhpEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbsykAfJkgDLJx/l/oQbK+V4uvg6LPXSoJTQwZ1rDv4=;
 b=sBeTVibzNQ+ADxQE/+wrHVKG/StI6LJkEhpgCBt+hLBca3TeXvPmA/AlWSu3jHPZYeCYDcZCYKcjC/nPsGc+HzZ6JWsiDqnbZTbxtVWmFY+r0Vn6DVXPV2BODKgYFqDrIKegaAO6xrdOvMF7noolN5VkPx61Rxv4CIJLB0x3tsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 18:55:11 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad%5]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 18:55:11 +0000
Message-ID: <ee23accf-3e2e-773b-dc6c-81d9e18d0d0e@amd.com>
Date:   Wed, 21 Jun 2023 11:55:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Clear the optional capabilities in
 DEVCTL2 on a hot-plug
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
References: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230418210526.36514-3-Smita.KoralahalliChannabasappa@amd.com>
 <20230511111902.GA10720@wunner.de>
 <cc36bb5b-6a4a-258b-6707-4d019154e019@amd.com>
 <20230616182409.GA8894@wunner.de>
 <d9cf3451-c0c1-ab86-0528-2c05982e7872@amd.com>
 <20230621071259.GA2028@wunner.de>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230621071259.GA2028@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:a03:255::7) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fadefeb-1a94-4d43-1574-08db72890a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q31OvzKw2aEMbcBpOdSLtSTQmsnv4Q3BMDWUcd+99otezRodkB4HI3P13N3HX5J8h9vBZwTqWsrCHwVh/ZZLI7MgxrVbmCqUv+IBwIYvXngTRN6b7RwNZNBi4R25J1ZHpLGcfMSTQwweqFBnBOXUwYRx4Z4B6V/Rtgrlg9/DsnccCCbWJCrzlIYhm3klQZ3Fj71HRW15VuGwo7wekttr9MSOVWBf1yo8NdKD+BwS+6mqEZ7MYJWda2/I4/v9jPQHhIkeTMbhRFvvwZPQKm1fbAk0tu7jN90P3V1MI8OZR0A1oHV//NXG+wUIyFZLk8ym+kWsBXuEA2FbHg1HAPxOvDNXyH4aBp8URXpN852Ts/KOPvASVI6YQbpy35O54vvX6Z8TX7/wyuM/GCGzNiBAcSNLXSdA7ojGoq9f4yyayjCxStp1YRfPvHTOgOlo6m5klrh2DfG7NReQLGDGRxvIyrevHpo/nAp7fVTV0Yw9o3vxYstC+OJIGDgW7GaOVltk3FsRrxZvCAUGXmq30D8T1tSx1ELRItW5ugHZJ+X2Qnb+FzRHmuenX6LxiKMF3WL0Omz4Q60UB6O9vykjYZu/D04YEgty/n9A651VZsVqu/JC5cil6UAkVqDo8gd7Xp0ts3t3IOcyxKlYnRTkptB19A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(66946007)(66556008)(316002)(4326008)(66476007)(41300700001)(6512007)(8676002)(8936002)(6506007)(53546011)(6916009)(186003)(26005)(2616005)(54906003)(6666004)(6486002)(2906002)(5660300002)(478600001)(38100700002)(31696002)(31686004)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enNwc1F6UGZ0QjNOenZ1bHN3NGpNa3RuRDZTa3Q3YjVEVmVaMlpPTSs0anpo?=
 =?utf-8?B?VElJS1kzVEpVTkdhL2c4Z3BoMTdXUXBVZ1lxZGZTRjZkMGtMcTBQL2tsQUdj?=
 =?utf-8?B?YzM2Wk1PV0w2NkxMZmlOdlVvSmRtODdZaTJnZjZ6NjExMUhGejQ5bzVUUHVo?=
 =?utf-8?B?aEpqdzI5L1UyTVBBczdNUENGWVhLaVV0Z3gxSGE0NllYMmxRWUNGa01EMFBD?=
 =?utf-8?B?Ykh3N3BPOGpKNXdMZkpFMGk4M3k5UlYrOVJvaXJWWTZzSUNHTXBjYjVlT2h3?=
 =?utf-8?B?Q1hQZW1BKzRCUmkyV08rbUpsaFV2TnpSK1RyaUh0aVk0NDlwTFRVaDBHOTNa?=
 =?utf-8?B?dzFUa1dpenRlRTFORlpWZmpNQmU3K2xrVjhidzNDMWRFN0pyTUxKZnNkZWVE?=
 =?utf-8?B?aWVEaTdhdHE0elNqN2RGaU41c0NWekNoOUxYOE9JVlBpSm9TNm1xbU9JdERi?=
 =?utf-8?B?MXhRZmtYU2l0QjQ2aDZOeTFpbnlPTWxGeDlWVmhyR0FKNWhPYldwY0loTHFO?=
 =?utf-8?B?bnNLcWxXZXVTZmk2NDVuMmJ3c3c1VjdzdkJkcjY4V25Ja0xQTWlhN0xNTm84?=
 =?utf-8?B?U2dNVkU1ZkR0NzdLZWdLbHp6T2hEdi9aSVlNV05uUUFLNTYzckJsOUxhekJw?=
 =?utf-8?B?RFN1dlpjejVGUXNJdnVFNlV2UVlaV3VySitaZ0w2c0NadW5kcnlwdmFwSEZj?=
 =?utf-8?B?SHR2SDhnQ2Z0aEQ0M2FrREhkU2ZOTExoN2liVkJocnYwVFVUcjNDclF2Ny8w?=
 =?utf-8?B?a3hBeWExcEJsYWN3VmdLOHB6bmVxS0g1LzJjZXlQNm9mdStHc3N1NHh3RFdN?=
 =?utf-8?B?azJCQTc0RmVqL1J1bmFWL3FXZGVBbCtFYUdsYk5EV3phNTNIRXNueHd3eWJS?=
 =?utf-8?B?NFIxN1VmSlJuTTZtUmFXSnduNUdoMWlWZTRWR0hpN1NGSWhiOWpiL3hVMFQw?=
 =?utf-8?B?cThOZHZMV3JlQWl4Z0tmL245dkhMNjA3VXlSWHJWbmEyNWJiaGErZzB4VWtC?=
 =?utf-8?B?QVpiWE5hRUtXSmVLRmt4ZFVDdDNSVTVLZGh1K1BvVkNzdC9kTEFqYzQ0QzJY?=
 =?utf-8?B?d1VITW5yeDlodUlkaGpNSllZUGxYcnJpNVBzc1paYXdOWlV4c3FjTDRsdFkr?=
 =?utf-8?B?TkIzb2t1VytvZmVGeHR0c1lSb2hmWlg5UG4ySUw0dGdPbWliQWxoUEhMSkQ2?=
 =?utf-8?B?T1Z1bittN1V2L2RkdDJ0SDc4TW1aYURLUW5OVGlNcnd1eE0yRUF0REw2aWxX?=
 =?utf-8?B?L1pBVXpWdzJvQWhoMmY0VXE3MlJUV0VOdGlGYjBHYS9MNWlvN3dHcmQybFI1?=
 =?utf-8?B?bm1lWjYxWGExKzZlbFJFNCtFdVRlZythZHZnYWJsdFBSS05xQzgwZmZTWWtT?=
 =?utf-8?B?VU9XQ2UzVTlNOGtuazYrYmc3L0hZQmZOUU9oZEw4NjNnV0pBRTJySzBIQnZm?=
 =?utf-8?B?NS9UcmEvK1JiQS9GajN5RUpUVXBOQlJqbEdzSmp6RWFhMmpVeitLL2I4eTQ3?=
 =?utf-8?B?WUpFTkk5NTFwTFZpekx3a2luRWZYbkZzL3VKRWd2SkZUdndpSXB1YjZ3UWtk?=
 =?utf-8?B?eU5saU9DSFVRVTBKZktBYlFkcjVERFlBTjVUREZSbi9kUHFRbForRmF4cUxZ?=
 =?utf-8?B?UmY0OXBLZ2hZK21iMTJSU3ovWkIyNmVHTlNJSnB4VmtENGQ1cy84d1A4U3hH?=
 =?utf-8?B?c2grZ1k0MXJ6S1habzRaR2lhRENqV3FKeVhuT1RnZ21uWGhZNGhZL0ZOQUpz?=
 =?utf-8?B?UlJvU3ZMaG1wc3A2V0FrN3pNRjlLWk1rMGZSeFN3TXZKWDl4bUt5TC9FQUdx?=
 =?utf-8?B?RzM0SkN3b29hcy9RcUtzMnN1V0hUVDJFdkxjazc3c0FsVHFHSyt5dnpIZlZR?=
 =?utf-8?B?dHUrUzdrbk5IekZTUDVycXpkOHMrNWg5dHlGYnJwZUF1UGVMNzRENTRMMXhs?=
 =?utf-8?B?bHZIeUxxSHRCMm5NMVNaV0o1cG1hVGdvSzBwcExQTGNtUE51OGs2bXB6dW5B?=
 =?utf-8?B?RHcycFlxZ1FnTUdJK29YeFZVZjg2ZDFWRmZzMjNzOU5vS3NVS1FTa3FBeHVC?=
 =?utf-8?B?WGdaQWpuTU9hRUw5dkJDZEMzS1lVZmlvcDVkVk5xcUtRNTlYT1diOHJVMXZX?=
 =?utf-8?Q?JuF652sauccKHH3ApeF6KYkpp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fadefeb-1a94-4d43-1574-08db72890a15
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 18:55:10.9789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBs3qchVH8RNUd7Su3UCuNFE/olt+Y18/O+yljig3ijckFl1IqIx0PK0M5kkXkc+hKrZuOzMG+W0WltKVifEFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/21/2023 12:12 AM, Lukas Wunner wrote:
> On Fri, Jun 16, 2023 at 04:34:27PM -0700, Smita Koralahalli wrote:
>> On 6/16/2023 11:24 AM, Lukas Wunner wrote:
>>> On Mon, May 22, 2023 at 03:23:31PM -0700, Smita Koralahalli wrote:
>>>> On 5/11/2023 4:19 AM, Lukas Wunner wrote:
>>>>> On Tue, Apr 18, 2023 at 09:05:26PM +0000, Smita Koralahalli wrote:
>>>> Some couple of ways we think could be:
>>>> [1] Check if these bits are enabled by Platform at boot time, clear them
>>>> only it is set during hotplug flow.
>>>> [2] Clear them unconditionally as I did..
>>>> [3] Enable 10-bits tags in Linux when a device is probed just like how
>>>> we do for ARI..
>>>>
>>>> Similarly call pci_enable_atomic_ops_to_root() during a hot add..
>>>
>>> Personally I'm fine with option [2].  If you or Bjorn prefer option [3],
>>> I'm fine with that as well.
>>
>> Looking forward for Bjorn comments!
> 
> You may want to consider first doing [2], i.e. clear the DevCtl2 bits
> on hot removal, and then in a separate step do [3], i.e. add support
> for enabling 10 bit tags and atomic ops in the kernel.  Having that
> would certainly be useful, but it's more complex than just clearing
> the DevCtl2 bits on unplug.  So you may want to do the latter as a
> stop-gap.

Okay I just sent v3 now. I will take care of this in v4 along with other
comments in v3.

Thanks,
Smita
> 
> Thanks,
> 
> Lukas

