Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E454B1926
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 00:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242400AbiBJXMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 18:12:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344967AbiBJXMG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 18:12:06 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50DF5F44
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 15:12:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3akQL6+q2B9J2WiRAdh0J6Yi2hS3fou2s43OKO4PiIXKDNujkgbDtq0jaVVfNXAMknw6AufFc3EOMxosuRdg+nBSSEodJhf0OUUZEt/2N6EU45DDAmr5hRB7Vu3zMmEmA0h8LrEr9POKb7p/qymjYhnUuBFsWyK0lAlWw+QVPi5TNq5/yCaaR1YQp4xq2nmR/1KK7+IM9UNJ0vEV5nUTrCPVp/GJwmZnERNPt4W46w0HkuI7k7o1gcQ4gVX11ZWYgImHMuHNj1xaBsroTWylpBe33+/oxzPK8xYsFjcs9qqjZ4u1Ye5E8gGOfScTmXaoB11A2RXGszogNtGBNlTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGTaArD5OwWG6WkVC0nUnxsxanTTuRm9wY6nXb1Kjk8=;
 b=OuJkojLyWsYE9NItBOMIXbXsgBMv0nOCxgnzdaIn0rbXrGPRDgMhHsUr48OPjpeB4tY4NXoKRRMGQYyDEukUY8pXOwBXGjIHSv4Vrjx96uJ1rglj77o8/O+/dml9najDc8hsKb0vYjhEPjcCkX/TD38JkYh9u2184Lpy6K6TbTEdj50jQ3pKbK8UfDaeatYz7XSgnIie75GfgUDG1UM4OzdaExJQ9uHLFN+A5wnM2YfKdo0leWkVxbEvCAVT9F6CXJxAnJO8oy3+1ZEXxfN3IL6NmL1UJsR/9S4gt6lSwlRBjhJTkSo/9W+WWWzsjueVIc38MDB7gDYbNlApfb6N0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGTaArD5OwWG6WkVC0nUnxsxanTTuRm9wY6nXb1Kjk8=;
 b=N50VramAYZzSi9c7ZEJpKdhH8Q31CsNyrf3OymkAVah8LQaZ/4rXUEqUkdh6hwGc8uhRYebyzpaoSxpI5u1liZpMN6TB03JhDZzVHDT/e8r7KfqXopNqBOqi/QfSdAfsmqhxNtQJZlQebp+ryQqO72OcofV67gI9IUv4MkSRS4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 10 Feb
 2022 23:12:03 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 23:12:03 +0000
Message-ID: <9ef6f2f9-a11a-e473-11c6-e6388e8cdc82@amd.com>
Date:   Thu, 10 Feb 2022 18:12:01 -0500
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
 <6da46e96-8d71-3159-d4e1-0c744fb357ba@amd.com>
 <20220210213732.GA25592@wunner.de>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220210213732.GA25592@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::7) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b2fb974-0960-4d3f-59bd-08d9eceabf85
X-MS-TrafficTypeDiagnostic: SA1PR12MB5669:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB56690952A0CC40DE0A2E639EEA2F9@SA1PR12MB5669.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIOvbsS/KlEJD2MkQKerCk7GCxHK068+7H9j8rXG21r+f0QYz8dqWIpOTdNB5iQL7V+jHd0OAuYIYiVrz/9kV60uLXQcgB1Aih1ENMtT8p16b3AKPKglWLAtp2Q2aEVDDkF1BZ6ZffPW9j5Rw1aTDYOwoAA1/KVJfv9oI0m3vWqtphYkhwD+9kzPF+ySrpOTcDdH1AqLc8Db8IiQ2w+DgABr62FVhKonkPF8kY6W36szjXyyK8XgzX26BHAK4Jz8wXLqmNt8zm0QCfK6Qr1Y5xkvHWSkqY0n6ha3P/2exKBl6JPK19DYw9mm7IEYGikpkTWYYNrG5ucPcKDIpKA9GNQmhYMttRjdICbCTvit7ATlbhfzs+Q9uE/WwF+zPhOzKdHXj4wx3C2x2HP1zLfV1AeGlYrKAmnPu/sKOz8uDoSDMOLeGTyZdvPggAywkVXE2yGpOo9mtH61yrshitBZNcCTmZOZRUoV8P+jMNvCp9dFm1ui4CAcPBJSwW6v299dAAfI0jiT8Bv/Vey9tqJlLtxqmvjzcBLKUfxqk9I7DyB03reyTT1fNkUJmpoFBvL4UJ+xNPsr9V8HmIAoJmLAQ68UKP0CPhvlmMSwbouchIngXYtENNRGw6PQTbA9C1QrWzmc3UU1Du0mntj2aknHNxPB8XhfdqzwKWJRXrN3BE1UP2FHT2LIREL93hcTjEm2NPXsT3ckQvaJhpJbuKWOLO6gxFWwP5CjwJWLpd1eT94=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(316002)(54906003)(6916009)(6486002)(66476007)(5660300002)(86362001)(66946007)(66556008)(4326008)(31696002)(8936002)(53546011)(6512007)(2616005)(508600001)(2906002)(6506007)(83380400001)(44832011)(38100700002)(36756003)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDl5bHVOM3RuVW1pbmhCa0lxd0ZZaHZsWU93N1ZoT050MUxNVWtDSnVlZkhR?=
 =?utf-8?B?QXlVUzRnM2ZMSFFyQ0IzYTZWZW90ejJaR1RVSyt0OHZ5M3JGZG5QOGFRTkR4?=
 =?utf-8?B?VCtMczFBQThkMXRLQnVhNWlvUTJucUp5bGo3N0VFTWhsNytPYTZFWGpINjVG?=
 =?utf-8?B?UTkrR0pHbCtyQlgvYjZodDhTNjBDcWxJRWVMd0x5aktPMSsyVng3UGZULy9x?=
 =?utf-8?B?aXF5MUJSd2RXTTVlYmtha3BmSzhrZkg0UER6TjB3cC9XNjNpeW9OczNwSE5I?=
 =?utf-8?B?U2g3dzZGaWo3Wit4bk10L2U1YWVVaEYxajdHR0oxOVRPL2YyakRoNU43VThn?=
 =?utf-8?B?d1NUMVVyVUpObkxmTTVxb2JxVVZEU3dtWnpKVCtSbXh5Y05sQ2NsZjQ5eWI0?=
 =?utf-8?B?bmxRU1ZHdWhmUGMrNkxuYVNUR1lOTERuTWJzWkdPQzBZOXJKV2owVkdZckF4?=
 =?utf-8?B?N054NzR0OXdONG9XS0sxTEt4d3dianE3SFRjNk54bGRWNWMwYWRLMEp0OS9n?=
 =?utf-8?B?bDQ4blFBUHNrZmlhTi95YytCZzAvTk1BSExmWnFZVyt5RitZR2xsVkpkU3Yv?=
 =?utf-8?B?R2hJMngzb2JUVnRHZ1RHOEtIRDNpTDJZNFlTNytiUmFuSFpGcEs2K1FpSmND?=
 =?utf-8?B?eEVTQU5jdURQaFhESTB1U0JHanJsdit4d2luTERZMnUzbmR3RGFCclNLWFJh?=
 =?utf-8?B?L2hsNEd3bERlUk1uSSt0bEdQSndBZ3JEcnNMY2UxQk5nUUVMQXpCU3hyTWhV?=
 =?utf-8?B?bGNaR1N0YzQwZjdvUmplbys2dnVZbno2VnNRaTd0TjV5ZEgvZEs0Vk95Mk1p?=
 =?utf-8?B?Z21yVE5HbDhkOWxMdDdCTTFLZHdGNk5DWjdjV1liU1cvYmdRa2FhN2x6YUJD?=
 =?utf-8?B?QmpJczNCdjhoV3dmdWZzdDBHQU1LOFh5dndMbUdwMGRxWDhBc3IzM1pReUU3?=
 =?utf-8?B?SzhmOVhNU1BJN2FsTHROS29KQzAvbTVhV0ZEenQyNUhLdzB1YmZiZHcyU2hx?=
 =?utf-8?B?SlYwUzJpNnI4V0ZoOUFKbmdzVE1NOGlrVFp3T1o5WmdTSm5XcUN2WXB5ZTBQ?=
 =?utf-8?B?UHZyajFaVlFqcnYrOTA3K2lxellYRW1pOEdVTVpYcUlWVmhwYlZPLy9UQnFz?=
 =?utf-8?B?SnFMQll0R2JHV1dWRU5kbDFUMkRtSGdmbnVaMXFNeS9DWlVkQU5WdWZ5WVhp?=
 =?utf-8?B?c2FJZ2hkSnFaaTZFeUNGYjRWc1Rzbjl2QzhCZlVUY29BaFVNT1lHeVJMZys4?=
 =?utf-8?B?cUZIMmlXRjk2NW4rYXYzbGFIT2FabTI5ZEplU0wwbTJYdG9Rd1NPM3pmYURm?=
 =?utf-8?B?NGJOOHlsaWY4Q2pER1J4cGladEZnMFhlOUExa25VN0dTbHpuMGlTQ3NTMm1I?=
 =?utf-8?B?aGZUeUlmQVZYcW5FdTZpZkZQL2gremZCQVM4TE9TMDZlTGZtR1RRQyt5TW1G?=
 =?utf-8?B?V3JZU3dGYklOOFI5OEpjYUI1dVFjY3grWHpRRVlBNzFGMW1kQ0VBZldHb2Np?=
 =?utf-8?B?MlIvSjVIaHFiSXZyYWgwZkllREtEVHhxSnFEc041UmQxM01wSllkNXNkcVMv?=
 =?utf-8?B?UStFb0o1NnRsNnJsQmhRR2JrWCtlUnNmUXJUN2czUjRJYTJBR1FIYnZ2aFh6?=
 =?utf-8?B?SUI4Q3gvQ2NkdUcyczZHNFdQc2dlK3hIZnpCOG9qa21xYjNzK2pRaHFTL1Za?=
 =?utf-8?B?QWxKNHNPcjNGclp2Vjlhc2xCemJTQnV3anRpYU81VUxHNUFOb2ZSR1F0QnRo?=
 =?utf-8?B?V2VDbGhEU2I0aCtabmp1bm1Cd2hrbWNWR25HWitheDJQV013dHRsdUVtaEdk?=
 =?utf-8?B?YmRUTk5KRjJZWVBKN3RmMys4KzRobFhTNmViYWtoNkhLK1JjUUFXbHczcGp4?=
 =?utf-8?B?N1FuZkxkT3p0TFhNbFRFWFlpc29GY3poZGdmTzd0WVpKSHZTOEhteXVHZVFl?=
 =?utf-8?B?MXJSVDFCendFcElUOWFhNEZoVE1yZExqZHRNRTVYTzB4dkgwcW9Yc2VQa3VZ?=
 =?utf-8?B?eEZhWktBK0ZvZkhHTHRqaDRtcUxoRlpCTVNLTXJNYS83K1BjQUhDcUJHNS9m?=
 =?utf-8?B?REhnVlBmeWxWMm9OSzJmTkw1Rnp6K1pxelpyTUxObXRoQmNXYnFkZkMzc1Yr?=
 =?utf-8?B?Qy9nQ2Uwcjl4TXk3aXBSRE5XWUh4L1FWcUUzSW5jdjNhMEE1WGZzUDBteXJz?=
 =?utf-8?B?bkJoVzdLWHlRa2Yva1ZRTXBoZWNGRVY2WThxKzkwSW52ZVZEZTlwNjl1RGZ2?=
 =?utf-8?Q?1NOHsnzz36XnKc/d4/IQnWq2q86FFAhHhSkS6g8Oag=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2fb974-0960-4d3f-59bd-08d9eceabf85
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 23:12:03.2450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uF5zpHY6TiCY38fZqZEN1O3b0ymoa5Jd6kwTU26ZHfKV8maCHGB06U6Cop12QX740/+sUu0bqtaRF7DZK4D40g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-02-10 16:37, Lukas Wunner wrote:
> On Thu, Feb 10, 2022 at 03:47:10PM -0500, Andrey Grodzovsky wrote:
>> So the patches indeed helped resolving the deadlock but when we try
>> again to hotplug back there is a link status failure
>>
>> pcieport 0000:00:01.1: pciehp: Slot(0): Card present
>> pcieport 0000:00:01.1: Data Link Layer Link Active not set in 1000 msec
>> pcieport 0000:00:01.1: pciehp: Failed to check link status
>>
>> and more detailed  bellow,
>> we are trying to debug but again, you might have a quick insight
> 
> Well, the link doesn't come up.  Is the Link Disable bit in the
> Link Control Register set for some reason?  Perhaps some ACPI method
> fiddled with it?
> 
> Compare the output of lspci -vv before and after the system sleep
> transition, do you see anything suspicious?
> 
> If you reset the slot via sysfs, does the link come back up?
> 
> You may want to open a bug over at bugzilla.kernel.org and attach
> the full dmesg output which didn't reach the list, as well as lspci
> output.


We will follow on all your advises and update you

> 
> Did you apply only my deadlock fix or also Kai-Heng Feng's AER disablement
> patch?

Yes we did.

Andrey

> 
> Thanks,
> 
> Lukas
