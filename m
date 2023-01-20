Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86F3675FAD
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 22:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjATVfI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 16:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjATVfH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 16:35:07 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A23443914
        for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2023 13:35:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azGQPNbvwlN8mFKvADMA61aBC4mZCuCrWEVYKYOmv5F33vnLtZxrXmHLcqcyDqj3GGygVb7vnKSTXacp9gBf0bkMRD7AZ8nkMLyzdJEUMQ5GSkzNEcX3erNHWckv1jhHZbBUzS+6ldZKc/lUOhc/EeyILfxzSeOAx1O255/hCLeEKfR4Ii5sWVc/BQo/tWNXKWbfD4Ji4Egq0XWqNSqwzLnONXJPexR+Ji6KtBSBhRMTC7fUuyonId009/jdOgjZvz6llEDM2+5Qe0fixE8AX9Y9bVXGf9Ut3F9ef7FFi5OAPjLC4KdDpgxIFqPnRDxneA4d/4Zi5+SrU/4CxPjZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NCH8vwmn9dnpE2G20VizEQsaopXlTIrW5t2Kx3mvrs=;
 b=ewDi5rebwd9/isatUl18BcfS1ywUgCWXd52EzJVq4+vzBRNv6Mb71QkcHlggX7ZL/4UelMNIw1szkvWE0wUWZC3DKP7dy3XSsP27cj2QR97qWQ5Rl57da5n4lYghajwn7CnvGITZdHE12iADSxQDFtuBeeJvtE0dk3aQGxqdOeh+jub/GFare6XD3Ggv7uhYfTkraQyNpFe5mXaj7Ra1gh6y05B/s48kAyaACmi+yRUSHtwpBWsUuljnA4XBPf1jKJaB4ahQGPC/d/q1LXs0mNZL2PVaeVqWBbwfKbwvY7NmnQ8i88ugEleuQ4L1ybzAvC0BST6zGpbA+csVwMZI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NCH8vwmn9dnpE2G20VizEQsaopXlTIrW5t2Kx3mvrs=;
 b=wluCTD4cLHIHP8rXfnK5JbQhAIPXOlykS3aeNIGoLDQjWQWbinmQb62MGvYocKgg5/njPgXfYQV/+wkyLH9eObaKTkyvVrlAthj5GX2W0NSisInr3lf0rzbuj4F00S68n0nl1wbQ0TVcdBORiE88jvkW+Ecq66NdE3hbiTOoMeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 by BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 21:35:04 +0000
Received: from SA1PR12MB7104.namprd12.prod.outlook.com
 ([fe80::73f6:e507:1ec:1792]) by SA1PR12MB7104.namprd12.prod.outlook.com
 ([fe80::73f6:e507:1ec:1792%8]) with mapi id 15.20.5986.023; Fri, 20 Jan 2023
 21:35:04 +0000
Message-ID: <d14fd1b2-41c9-75bd-5b76-d2c396c1ebb7@amd.com>
Date:   Fri, 20 Jan 2023 16:35:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI/hotplug: Replaced down_write_nested with
 hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>,
        Anatoli Antonovitch <a.antonovitch@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20230113170131.5086-1-a.antonovitch@gmail.com>
 <20230120092824.GA2951@wunner.de>
From:   Anatoli Antonovitch <anatoli.antonovitch@amd.com>
In-Reply-To: <20230120092824.GA2951@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::32) To SA1PR12MB7104.namprd12.prod.outlook.com
 (2603:10b6:806:29e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7104:EE_|BY5PR12MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: addb0fd6-3dc7-4b8b-fd22-08dafb2e3121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kUreAgV1qSZj/DBvh0E8gqUCv5CZ/0PbuDg3EyUnxy/BH4bCdwjGoDPc80JpbydwlwsSLVSc7I7k7uLx66LeBHY+ajRrF0vSyZqYtEFHzamxPnaRH5Lw1VUUPo6uMwZG+aYg+rKL6fpScFVEZ96lDgiScmysZSsCZbxVhUBWTXI/6PndX21hfuoe6T6Sg6+LSsX5Dm3gLnNJfQV5NySBrorqKxzFqbDkKHEtC1Psss8GEVxPt2Et6V2Ye5ID1QskCoQ6Q9o0laielBE9A1xJ+Jan0xfhi2wb8BecDryuXKV/wlRoT+S7oZ1LB4b8l4W3rON8dDbgct5M/D/zgg59PUiC9aJ+Mh8Mn9o5rS34AVFqakpIFU6Vvv5A0wjLYNSEGTkpv1ddDChFLibE5vMGDUhP2PLLAaXH2UjK2B7MLIE5VUkn0I8bUgMRaWbJhcqvFILXknhBZypPF0oYIdvABrPFqhQwKWDHOsmv9dcHuuDbr23a6uSQ0+52LERodf1GjfgAlRIveRxEMi1R80WmHgvwb2GynaiqeM2Tlrpq2zw5MgxrA1GMhR5waD6aoaYBo3JRSJAD9jg/8UV7bJaHhHFw8/L6dYoIWsO4olov5y/44C8J86wUBN0/NDM0vQnfq3ePZWjYp86tunsJCpwk0k8E6E2SQAha46psaCtzuVCfVhw/PjC9fiKaT2UrpmlD3wwovv/PC+jWJqLDDpCZRlKZ+p4PF8ZTe3uAMNiOHWbuwWC5jlXNMrjgwnWBHZwWDF+Ql/p+egMIksL59leXsT+NIQBGl0JvTllIYX+dWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7104.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199015)(4744005)(5660300002)(44832011)(8936002)(31686004)(4326008)(66946007)(66476007)(66556008)(8676002)(966005)(31696002)(38100700002)(6666004)(26005)(6506007)(6512007)(2906002)(186003)(110136005)(316002)(6486002)(36756003)(478600001)(2616005)(53546011)(83380400001)(41300700001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUJHdndXQUlQRkZ0RTdLTjYvQitDOUgxdlI3VmRCRjdUQUhhdkd6OW5XZkQv?=
 =?utf-8?B?SnYweDdzNzhFdEtEdFBiQk80MzNkZzIxNDZoTk9mUFFUZjkyWkgwUnpMaG1a?=
 =?utf-8?B?eENqQmRlRmhjUWphZk1LR0NueEJKZE9Xb1NqTWtlVXZTL2hITnpFaFFTOVQz?=
 =?utf-8?B?aDBtV1pvQWh5QWdGY3hpTUVCSkl3KzZSTzNiZWlnazhtdzdHTEpoMklYV0hw?=
 =?utf-8?B?WXdwM3lBTTN2TlRCekhLNm1ibEx2NnZYekxDSm9hQk5vbktSR0l1NmFtTDdz?=
 =?utf-8?B?Yy8yK0JjZkZNOVMyTGhrSEtReDhMZDdSVllaUVNYeVNEekJKTkJZVmVwVllU?=
 =?utf-8?B?a0g1UFcrWVJkUkx0NUFJcUM4L0RaWllFUmx3S05GeXJzNVNYdUlhaDJTb0c0?=
 =?utf-8?B?T0tMRWxRV2x2dVZnN3lQOUJvVit5NDlqMGxBMjRQMWNMRGdKK1hFYjhWdjBo?=
 =?utf-8?B?bFpnQ01pc3RaN2JNdXJwU1MzYXJzVWI5d201UXRsd1lCRklWT1hvMEt1Wkcw?=
 =?utf-8?B?ajIwRFZQWGJQcmlhNXR4SzVkRmtVNUZibnFPZFF5RVBwMkhnQlVZeWVtTlZo?=
 =?utf-8?B?Z2g3Y0xoUkRRc2Y4QWV3Z2xUZDViOTZ6SDhmQjN4MmNyQUJGV0dJdzNtUGNQ?=
 =?utf-8?B?RzVHdEtLamN6L0FaVVNKZCt3Skg2SGN0b1kwU1pvWkZjdFVSS3ptUFQ2b1do?=
 =?utf-8?B?K3lxNVJIV2JEeXc0cjNBWUlSNGUyMlFJcEt3WWVnbkpKSDN2QkhsTWdha2Ru?=
 =?utf-8?B?ODR5aE5iQUM2RkZ6Zk5DR01UZ2JTUk9JSitmRDByRW9Ib08xRWFramJjZ0xH?=
 =?utf-8?B?RnNmaWUyWjhNaTIrcGVVaUtsd29pa1FXcTZ1MG1yODNpKytCSmNGUVlPU1JS?=
 =?utf-8?B?U3BqRVJOejdlSVJNTnhBOVh5VkNYVS84ckk0ZTRjRUloVTlXZzNGMHdxaDZi?=
 =?utf-8?B?Wnc5SEZhd21JWWVwVHJHUU5leEVjZWY4S05Gc2daUzJCeEtLc2J6d3BQcHhj?=
 =?utf-8?B?SGJCNXlnWWlJWWhQK2JOV3FnclVYeEM5UmxkZDY0MnBFb3NlTzBNL0VqMmpI?=
 =?utf-8?B?ZnNVeFJWWGZMTXVYakVZa0hYQ0dzVEg2TVpJUWlkVDNDV1grSDBqaE5WYkth?=
 =?utf-8?B?c3ZmRGlsMnc4UTZObGtLUGtUSUVyNFU4REg5dVR5L1VKOWtRWDZaQ0ZuNzNt?=
 =?utf-8?B?cjN2OVFxTVpPZC96emFlQXJ5RURsWENrYXVINWFJMjZiSHpWVlJZTlREWUgx?=
 =?utf-8?B?WG84NGZMT1Q2TjRQbzVFdy9BblJsLzliWVd4UlI4NjBhcVFCdEVweG9lVFNK?=
 =?utf-8?B?OXlLRXFRQndLczRWak1tL1FVeHhRSUd0ZEgwZFluK1owdjQ5ZndYS0E1bXBC?=
 =?utf-8?B?TlAyMUZWTDdXa3hUM0pWOWxhKzM1SkZMalp4Z2kzakR1bE9XeGdjSHdQdHo5?=
 =?utf-8?B?WEQzQTZmNnc3N012QVRvK01iM0p3SjFVTE52MmN1bTVqK2haSXJDT1dPYkNC?=
 =?utf-8?B?M3hFcW5ZOTl5eUs1SVZ4MnVMYmdoR2dyMWZnMHVLbzJzZUFWWkFYWndPQTNU?=
 =?utf-8?B?Wk5IaXh5MlY0cDlMclRxZWs2dXRaazQwZE5tdFNRY1dSdXg0MU1SR282T3Fj?=
 =?utf-8?B?UUI5VWNsNW8renhhMkpCcW5WaWFGQUh0WjdrMVdpWm0ycEZ0S2lPbFBnUm1m?=
 =?utf-8?B?cU95N3FSaCtsRlJQQmhGMnYvNVB6elVhMng4TE1FdmRxNlpzT0lGVGdNUmo2?=
 =?utf-8?B?c3BaSzFwMENJMVNkdVU0RFBQZUtRTjVlRk5DTkpnTjd2UitmVEEveFFZSy91?=
 =?utf-8?B?WkF0d2p4ektQd0FOdmFXWkZTSnhYdURuNURHU3RKd2lMVkcrTUlUbkJpc1B6?=
 =?utf-8?B?V3lad251Yk43dnF1OUxTRXBsOWplZHVFMGplNUpNZjl3OHVKN2VGTGxCb0FS?=
 =?utf-8?B?MU13UE1LUWJXbEtJV1BkSUc2bjdDdFFkb0VYaExyVU5nNlZDa1pWUWZjRlBz?=
 =?utf-8?B?Z1d6ZitXTXRYOVNOb1FGU0dNRkYzSlJUeEJXRWRqaU9oYW5DZGJsWXVZVUVJ?=
 =?utf-8?B?SG1JTjIwZEhqcURVZlJ4MDBtTE80bFhtVXVXTWxlNWtEejZRRHJHRFJOOVNz?=
 =?utf-8?Q?nGIUN6isIABKnGB7LacuzsF5m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addb0fd6-3dc7-4b8b-fd22-08dafb2e3121
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7104.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 21:35:03.9599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erQND1n8QAUJTKTWro4QmeI/WyiR33VKMhIBU9e0Js/g4AoZnIVdaeQrVp9bNMwR1SJQWkPdUam9GtS8NF5IIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

The patch has been tested on the same setup.
Unfortunately, this alternative approach with optimization and simplified
locking is not resolve the issue in
https://bugzilla.kernel.org/show_bug.cgi?id=215590

I have uploaded the log dmesg_6_2_rc4_hotadd_aer_fix_a6bd101b8f84.txt into
the bugzilla for your patch.

Thanks,

Anatoli


On 2023-01-20 04:28, Lukas Wunner wrote:
> I've just submitted an alternative patch to fix this, could you give
> it a spin and see if the issue goes away?
>
> https://patchwork.kernel.org/project/linux-pci/patch/3dc88ea82bdc0e37d9000e413d5ebce481cbd629.1674205689.git.lukas@wunner.de/
