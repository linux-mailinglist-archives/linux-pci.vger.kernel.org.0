Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D6B726CFB
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 22:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjFGUiR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 16:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbjFGUiP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 16:38:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016AB1BD3;
        Wed,  7 Jun 2023 13:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRBVJoHUIZU4t1Bg4grn2Vct8jgohsQvzttSE4kCH3BbD/j09QkGB82lW4I/0Al8jZGROkwdx22WWqHGJc+z8SlkeyPyx2sXqQSNdr9Lik8fzvXxjY3uHaTf+Kqr1aTRLmwghZ35tvTX6GJ7Zj5/nW5aOMP178peRjUctBBmDoUsjL4N34Uu++pkWCuJ5pjPsP9GEFaDnkn7KtnFLjcyc4IxEJUXNxiJXdTXrRGUl2K8qfmJDfLY5JgWV382f2nE+pFAfqEbuXFUISQKM01glG8eIRM6SXl5YZ0JyMfBOTimBOyzFBynfcBs291NiPUit8XolYk+xAyweIMofi5/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcEhbwyDZdW5Vi5ef2T1YbSu2IqkneQfnQWMSNUatsQ=;
 b=H0f3/hmxIQVSnrDoQuLVdGpjZlGGShAQSlRN+jsSurHEi3OHIhvzSCikE0maqvIhNVC8UlSPN5JG6PTW64c1TENFJhCkO+2dZ5jAP2NKd0cC+JhMXOlUA5YAtEARU4ownJqoq9X1eglPEA4HYhshhTLeOX5coMBJs9Ih/BzNw/EKZulgjo5WPnjv6HW7PcXqFDdv4SzXZ5Bau+TnKk57vFhhmatM8qsZ6yG6YNMoz7DKi0n/jW98eNQELzyBZq9R1f1orUyFFvwx87IWynMHcf3LEV7urLkR624zp1LeB0xRwoAWfY49JwmUcM0t0ztLsOYVh9Q4aJHG04tKTKWUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcEhbwyDZdW5Vi5ef2T1YbSu2IqkneQfnQWMSNUatsQ=;
 b=wqHEPJhlpsORpOFO43MFfgTlR7aX/oEGEkc5Kc+eElFKrVbpy81gfuPi0Y1eHK1VgUOVLa8HnIV3R0qxX3AhAAnQppFxYDK/c6kaTe+kH6dar6QBEpNu79K+YpK/3FShQw/OEkhYPp9gIpTYHMGmrY3fyVyIewLPtMqvuWJnqSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 20:36:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 20:36:55 +0000
Message-ID: <5c6d4fc9-943b-ecc1-b457-e24451ab2e29@amd.com>
Date:   Wed, 7 Jun 2023 15:36:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 2/2] PCI: Don't assume root ports are power manageable
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20230530163947.230418-1-mario.limonciello@amd.com>
 <20230530163947.230418-2-mario.limonciello@amd.com>
 <20230607080154.GA7545@wunner.de>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230607080154.GA7545@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:5:80::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 06949f6d-59a7-4396-6600-08db6796ef19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xp4kOcMeNZdROFhVmsgUKApgKrkI/eflF21f3lhzygoWtnleNzb1OzBp98LxEA71HIqPqo8bdy7BKkZwE5x4ze1sf+bTlwVc9Bxnww1uiGLU2+fHwJgSL09591b5nG7atZoeBq4oDZiFm2Cr1rNmfoVMNC1EI2JRjMQTYEKngp6JWufkAegYkwKCDkoc9rDJyMumPDMpQe1U79EQjegATaExriN+0XpY4w0c10Uhtq8mlgKrEzBK6ANfftFrr5AhDmtdYxnBwy56A/p2ruQ8TcXsoDsCmCl3qjkCrkxLWhlhH93NqKf7bLOiUy/vIFcFsYJtY5mKoIYnCYEvBDvBP/L+NeJQ8ey+S2IjB6UZQASxcLh4yL7ZX3RsgvYjsafymJIzTlZBEA3HdLrmbJSE6xes9BjODBA6/aAVWKvuc61rWv48KHiSFSsWrY0PXObDfsdEb75nNtbDCy5E4AVbUCRNVNKk4+TcPxTob4DntjGIIA7TZhXagsdryk2f7mIGQ3OjFPvYAlZlCTKQVwYgYqNOFkKLst2XZJG8EnNERjp6QhjnYhnVz3Rp4xIsORvPCfwZrU90Sd1YH81a0SQ9MvEpyhK+1zrzQE/gK/fgIo8mCZoLBk1pQ/uLGNx3EV0jNVBaYPLwm//tVj0wacgYvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(86362001)(83380400001)(54906003)(66476007)(6916009)(38100700002)(66946007)(4326008)(66556008)(6666004)(6486002)(478600001)(2906002)(36756003)(186003)(2616005)(5660300002)(41300700001)(8936002)(8676002)(31696002)(316002)(31686004)(26005)(53546011)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Znd3QUZxMG1vTm1yaVgzdDV3QXljbU9OQjhHM0YxMlBRdzdoZWpUT0s0dW1m?=
 =?utf-8?B?K2YyQklaYzZqcUpoMDVBN2tXRDhDemFCQUZwMXNTOE9yUE9uMlJwOSs0RFZL?=
 =?utf-8?B?cFhjYVh6aHYrOUxiVkFDdnA0RUNyZjllb3ZTL3dMTk5hOWJBNEgxWDRWYm01?=
 =?utf-8?B?aFY5Y1NJanc5R3lsejNMdzcwN2dhNG9iZU5FR200YUNHMjlYVXhscHQ4REpU?=
 =?utf-8?B?WlEyUTdxbWlBeXJQSUdMMk1QWDlReWE1bkVId3RDL0ZKKzU1eThpQ0pvaGFK?=
 =?utf-8?B?WkF1Rm9uOXk2SGgrNVRRTk5Oc0c2em1FNlBxaHZjNnJtbUthZHdGakRtWmRL?=
 =?utf-8?B?SG9xaHBTRTFuTWNOVXJZckdzM25uVzF1YmlDZ01peHZwR3BJR0M0cTA5dVNa?=
 =?utf-8?B?T3pEeWg3b3pUellMby8wWERqZGlkb25ZaG5MQTROUUNtZkduMFF2ck90M0Jn?=
 =?utf-8?B?Yjd6SmtVK1JsUnhjMWUzR1ZLY29Kd0FGdmx1alBueUhDYkw2MzZOMnBCVmVB?=
 =?utf-8?B?UVhBN3NxTDNuTmtxRkxjM05vb0h1anNLVENkVVp0dUxDSjZ5ZUk0RXYwYVNM?=
 =?utf-8?B?TzZ6L2hMRDJENC9nNXlzVUNvRWxtS0tUZGRkOTZCN044WUo4eXVYWG52Z2tO?=
 =?utf-8?B?cnJWNEQ2MldYeGg4Y3lQSWRFMmdkZGFTSFgrVm1xTWNJdGN2dlloenphRGt6?=
 =?utf-8?B?SGEyVGh3NW5PbkVacU90SmMzMGRXeG9nNVRXSXp2YWE3a0QwWWQ4N0dSNkhw?=
 =?utf-8?B?NEt6anpoUmM2NVBoSUpXYStPVjZoaDlNSTJaY0lTWlFFZU9qOGhENUsxNTND?=
 =?utf-8?B?VHNKMmlncEcveE9OVGliVjdiUEhockNUcXpOd0hCSktRc0h0cmhFSXNZN0dV?=
 =?utf-8?B?R1RkdzVwWm14VCtFbmh2STQxdmFJVURUc3pza1dvZkg1YjBWaEpQRjU5RCtI?=
 =?utf-8?B?Tkd1enVtS29XZkp0WDNzUW16YVlJTGh6NHQ3UWZnc2VuUlRlTjJZZk5CUlpz?=
 =?utf-8?B?WWxsZS9YSmErbmxRZVV1WEw0K3F4RDFjaFdvMkRSTkU4bXAwd1U3WGJzREpS?=
 =?utf-8?B?VHZoYnpLdGp4OERVb0pJVFJVWDY4L0dXRHg1SFlXOWR6VW1OUjlmTmdIK2I3?=
 =?utf-8?B?eDhuNXU2NEgxNmpMUVJjUHJ6U09XUGdheWRKN1RnK3p2amQ1Y1NoNjA4Sm9Y?=
 =?utf-8?B?TndBeXUxeVdmdmltb09qZjNkMWsxK2ZTcnVkeUt2TkNEYllWRGluWjB0WGhC?=
 =?utf-8?B?dkwzNlZLR3g3eDZucXYwWnBKVHBsN09ITU5qSjVNUVhiNW5lbzREVnRwMGFJ?=
 =?utf-8?B?UDkxcC9ieGQ1UjVpWWx5SFlwQTcwMS90azdvUjg1eGR2N2FLSUY0V0NvSWpi?=
 =?utf-8?B?RVlMeHFNdEhWRFVaNkd0SVNPV3U3V0ZxTmlTVnE3d21kVi9sZkRuSDRlT3ZG?=
 =?utf-8?B?WVo4enV3SEx6OGhUenUzNGRmOXVkZDhoTGVMNmZDNHduOENPb3lCL282R0xU?=
 =?utf-8?B?TzhyNytpV3FzWVQ0Z29kWDVWOURiay92azk0NXhoNVJvYThIb01uRnM5citr?=
 =?utf-8?B?aElhSGxRSGxqREt0Z2JITmF2ek5pek5CQ0dlRnVBY3gwcmV5djlzVytMcEJW?=
 =?utf-8?B?Vld3SU94UkY2eXpWb004blJHUDFBSHlVVmcyeEU3MlpZR0szYXY1bG9nSDcr?=
 =?utf-8?B?OTdmWFRqcUJSKzhPdWcwQnpIdkVVUEsxaUxTWGtKRnFuRVBGUjNZSEVwMEFl?=
 =?utf-8?B?dDBueFhmbWxsNEZEdXl4SGo3QzQ1aUgyRko5VGVUVGtWeUF6UTZPYlVVTDd0?=
 =?utf-8?B?QitoTUU5aUFzWnR2bllHUk9DZnQrT1hVRC9EMjlzWGVmQ29JWExLTElsQ0xI?=
 =?utf-8?B?cHdBY1lVZlZ6Q1A3YjhuZjZnZ0xGOGtmQk9ITXc3Q2h5UVZjbWZVKzRqdlVE?=
 =?utf-8?B?YUIrQmZmNGVkTUNqengxWnZJOVE5NzU2ZlpRWXA1cVFJaVlCOWxyekxFNmJH?=
 =?utf-8?B?YmJyZ2hOcnZoa1pQSmY2aDlhZVlCMjNBVm1VTTYzVE44bEgxR0p4Z0tvaGFX?=
 =?utf-8?B?UlVaN3JiYzUrWjZvU2FEcExBc0F1ejA4T2l4RXZRRFdnOVNEeitlZlZUMmhi?=
 =?utf-8?Q?mRZc1w8wpS53aVE7Ustt4FaRa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06949f6d-59a7-4396-6600-08db6796ef19
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 20:36:55.8782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uwo4v8MC94zScBqZIP7RYrpNbSpo+QyJ0/ZOTW+RAMgcpBLfY9u/KefoLOniYf1O+j3LMCmwjy4kdL5jRuaICA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
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


On 6/7/2023 3:01 AM, Lukas Wunner wrote:
> On Tue, May 30, 2023 at 11:39:47AM -0500, Mario Limonciello wrote:
>> +	/*
>> +	 * It's not safe to put root ports that don't support power
>> +	 * management into D3.
>> +	 */
>> +	if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
>> +	    !platform_pci_power_manageable(bridge))
>> +		return false;
>> +
>>   	/*
>>   	 * It should be safe to put PCIe ports from 2015 or newer
>>   	 * to D3.
> My recollection is that we began suspending Root Ports to D3hot because
> otherwise low power states of the whole CPU package could not be reached
> on certain Intel CPUs from the 2015+ era.
>
> Do we know if the DSDT of all those systems contains the required ACPI
> objects to continue runtime suspending their Root Ports after this change?
> Otherwise these systems would experience a power regression.
>
> Thanks,
>
> Lukas
You might not have been CC'ed on my earlier patches, but
I was worried about a similar problem and at least in one
of the earlier versions was adjusting the existing
heuristic of ">= 2015" to "Intel & >= 2015".

That being said, this most recent version got R-b and A-b
tags from 3 Intel guys, I would think they cross
referenced reference systems to make that assertion before
adding tags.

