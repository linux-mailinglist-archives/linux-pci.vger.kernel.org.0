Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263A7766D87
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 14:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjG1Moh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 08:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjG1Mog (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 08:44:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAD9135;
        Fri, 28 Jul 2023 05:44:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcilafKUisSkzzK6Pq1QeJLShfFHTEoVQnpChcqcc3GekrFTZhFQwNQ4+mQTpmDYcm9y7oAONQW+Gde7yFn7Y/Kkf9YT/Gx7FDZwd2oZFBLkPTamHGAxz8xy3oNmb9097lZaJ+OiaT9mhTHQSb4ErN74ozibYYtrcEal3//IeaROUDDauOSy5fg6zwZJ5nNvtm/Zu0dqH5hEguEJO3tFv08FpxaYJkkEKpqzpEprXx4fhAxUiq4w3D1ObKLQf29GwToiMYWgMC1578EgOQNHCIzB9lrrDeMYmnSxCrOy5ZrYM8zdI2A3ghJGjJaz8sjHRX5Fyfc344NU462yrLFT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HM5sayR3OJDaVPh8oFsXJFWb3rJCgJs03eahQuh4gbM=;
 b=MiuAGPsoUoIWloVFns/VROHhFg2KTOF2+ajuv0hmDnzL5qs2ZNsSTNXqrTdLDrQ9a37EDSMZDpRrqWa5HdFLh6A9e6l8QRQ5o8s3PKhHum/XslUXnd9iERoOpvmZJibj1GYlm3x5q53u8OMgWFW99ZpnsrihrPjzs8auLKVn21tIo4mekWElTnDE9fY6Z1QetK1sm03e0lBhKfCOSse0V1gu7VEbZOm6K5FFIGtYjiogSnfpq+StmfpJ9q2udr0WU7zjjy/y0x5qtrN8Xr/6DMH9nQiw7GdMUBZ6jsOW1tPQkHISPR7amAXlURfnOkBH+4TXPviESnhxEqXvX44QFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM5sayR3OJDaVPh8oFsXJFWb3rJCgJs03eahQuh4gbM=;
 b=HN1JrJVprk21VW4hfyMYfPcIo1PofmP4ZuRT2bNNBpciTVSrjkcmwB41tRcAf1D+nRGAb1c7IgB3oT7+ei36O1WKUr8kNrd+LslFHXXNgCpflBVYcM/MCLSEj390yABqp6I3RTrpNPgtyI0/roAy9bUXp6+VSWaajB9rKyosa1a+S/8tCibMSjpeZlaJQFWJlK+w+k7XRHo2O15FtWzksQaMdMzi6mZEZ3CTVIdA1BL+S63Gp6n48BV3r/8WScQapfobaZwVPRDN5tmjp9K+C1fERO28YEhDzsLrPrXq1XH/EIL+cC2BTbc0Xm6qUa3iQwlZDAtIKmnUbhIeRZm2Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 12:44:32 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8833:f1bb:7d8b:dce7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8833:f1bb:7d8b:dce7%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 12:44:31 +0000
Message-ID: <64e55105-8d11-2ed6-3753-9bf74a782787@nvidia.com>
Date:   Fri, 28 Jul 2023 13:44:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V4] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        thierry.reding@gmail.com, Sergey.Semin@baikalelectronics.ru,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230721103544.GA569300@bhelgaas>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230721103544.GA569300@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0324.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::24) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5f5867-0323-4949-798a-08db8f6863c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9jMhKTlHXnCDlAwXTDGjkvTYmoi5ZfQEFpxpxo/B9sGHZ++3Z82LbaCt5uP/PnRTyX+8GD1lpLQW2oNuytKmQfMOkzgGnneJPHXBnO0zRksWAPvvxuWzCavQ4xEvDvOFfb4DThq7Jy/eFw0FWqa/CjUPv0l6uGpuNqxHLrbEy/pgPCDY7HuISqu2kUHm2S4t10iV1v0hdiwRW3/vUyePlLFx7CmFO156HuPANYWf36XyVmBDFVRzcRh3PEYdy4aVrsDu93hTZxsOz8uLLkAVs2oSUUNENfDBeQIvJBIsEEYj3RoYzQDBrrh9/0051VIZzWcAO807m0Y+16kCdnMwR0e0wsCqEg0+j7HN8e4au6PRx4bJez73uPb29vKhlYw3A4JlJTBuIeMxIgdoDyoAa8gOT2nbKnpjJ7xROJ73b28Mr0K743D6wz9WG5QI7ccbkIOoHEXnh/BkvwdHlDFYeVUMv/QYvycNIL+TAG50sdqVRpf2BKTkrP9ZgVZJdsfPiA1SQDfmcdUyRBjLHaerhszZVqWA5oYNgeLlhJAGb3yRHuOiDXq1uyfeZFNZ12L8avyHHsyZOyF82f7PUHjQaAIp2/hJSDFCNvm+b4mwpOLDsOO2MChR0yD70ehSZ+1+6WbYxa/DuChP/zk4RPv2mvH4/pP1Mzse/WWhSUNleTB2rLVKKGDEmmMe9pduJbE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199021)(6486002)(6666004)(6512007)(6506007)(966005)(478600001)(53546011)(31686004)(186003)(2616005)(4326008)(6916009)(83380400001)(38100700002)(66476007)(66946007)(66556008)(5660300002)(8676002)(8936002)(4744005)(7416002)(2906002)(41300700001)(316002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clNwR2pTS2VRMG5KR29US1ZteHNTd2htcTQxeHhvd1E5aThJcmd6bU96ZUlw?=
 =?utf-8?B?Nm4vSk1KdWVIbG51REZvYUlJUlJnaDFzbnRvOGo0RU5mMWxCeEFSWEM1SGlZ?=
 =?utf-8?B?Q1ZGV3RhUFVaVXNwb1hrYWRXcGY0SWhwK3RCeHdZaE5SYUpOQzU3SU1VdHBW?=
 =?utf-8?B?RTlaRGsxNVFnZldra2U3NXR5U0JLdWdVbUhiZFVKTGsxd1ZvS0Y1RHJpL1Zj?=
 =?utf-8?B?bUVTMjRhZlhmZ0hWNUt0R0ExbXB1a1oyNVIxL1NEYkpOSWlvQzlQYUJGMzZS?=
 =?utf-8?B?SCtEWnpZSkI2Y2hYZDlIay9pVWphU2Z3cG5MU1pBaWpOd2hZMEdGRWRDQ1lt?=
 =?utf-8?B?VTZRa2FXWFNDTlRXQmhmOW1kczMxQkZaNUQ4a0dqc1FGblN5cDV2K0xJZmNl?=
 =?utf-8?B?NGduam1qZHFBb2M1SVMxTmwwV3MrOVlxODNEOERKWXM0d1JUK2VxQjNmd1pF?=
 =?utf-8?B?K3AxaEowUVJqTWtWMkpVWTA0ZGlyODNaS1l2T0taa08ydlRkNkxJVjN0VGxj?=
 =?utf-8?B?Z1h2VVdVem5CcXV5eGplcWxjcDNoM09zR2RxQkw0V01lV1R5NmVJYWlQa1p4?=
 =?utf-8?B?NTJsZGhpSHprMUUzNXE3ODM5ZlU1SGV6Ykd6TXhWdStjRmN2NzBScDVXZjZx?=
 =?utf-8?B?eUo0ZGpOZWJidDFRMHpjZ0NXNnRPTDZTell6MVQ1R0dOWXRXT3hKN0lBZ1Zj?=
 =?utf-8?B?ZWZPdUNCdzNkenIwSFlzazNFYkJ2NThxSWRGM2U1UEJVQmZkUHk1TEJwYVl6?=
 =?utf-8?B?ZXZYaXozRllQMldKcXhUOTJuR1dzSzdkVCtJNXlHdVhOVDVmYVo4TjVHUCsz?=
 =?utf-8?B?VldSTm11M00rUXhqNnBqQkc2V0kwVjY1TkRYSUl0aW4yalhMV1dXT0hscW0r?=
 =?utf-8?B?TngyekYxSlgwTWZDK2ZuaEMranYweFZpOVVVV0hCTzEwa2NaYTZkcjh1U2tB?=
 =?utf-8?B?SkpMUnFiYTdnZnJxRGlLZHlUV0V3eXE4cFN3VUpUMnpFVW56YWlqcVZUTjNp?=
 =?utf-8?B?Kys2eE95VW80UWRGWmJvVGJNeFUyaHhwamdLVXRFK2JXTXl5OFExSU04L1Vs?=
 =?utf-8?B?akdCUVV5TmlyMXZ0TllkY3pkL3QyV09hR1NSSTZqc2lPaVZ0SUhHbGVubzZq?=
 =?utf-8?B?RWRNZ3VyWERSTHdUOFV0c01PMFRrSXpoc25tblZ5S3BpRmY4Y0plcFpSRFhS?=
 =?utf-8?B?M2U1bHpyTVgxakpleCtUbGxGZzhPczI2SXkvV0I1cEFnZlordnBMTVlpZTkr?=
 =?utf-8?B?YU1LTFMyYUk2Sllsa3htYjhKU1Y4anMxaEdaSTNzMUZXMkZ6Y3Z1MjFPU0FU?=
 =?utf-8?B?YVd6Z3lLQ29uSFZBQzZYVkVjUnJOU0xjWVNwTGRZakdveXJRaFJieit2TmhC?=
 =?utf-8?B?Mng2bU5WbVFYeWg4b1pFQko3dTVESG9KWjJNWkh5TDd1L29JMHViWFkvOUNT?=
 =?utf-8?B?MzI3MkFPMHdXSW1seTIyUThOTFJQd0tyUzM1RTErbTBEaWdySi9xZUVQL2pj?=
 =?utf-8?B?MElLOElIOTRzRnZWZEl6YXVBa29ZN0laYXVWKytwTCtBYU9iVSsxYXpTQzJN?=
 =?utf-8?B?NElhTXB2Ti9IajZubThJVEYvOHBJc3pEU09OODUrcGtoV0ZHU1oySWtTSXNN?=
 =?utf-8?B?eTFpcURGNURaeERNcTJuSFhpVUlhOXNvSHdjRThOWEsvUFhBVVBaTUlsMnA1?=
 =?utf-8?B?Zy80RUk3azF6NzY1U25KYmVBVEZVNTRzbW9IeUFXR3B3UkkvZHhRc3VJcUd2?=
 =?utf-8?B?R0NDcURoTU1Xb2tnMGNickZKN1RhN1RCTUhGMHBFZUhEWnFYQU1EQ09qbEF2?=
 =?utf-8?B?ZExXL2NSUFhwcENiYnVta28wUjdsNmNOd0F4UEFibjc0MW1aSnBoalRSbE1k?=
 =?utf-8?B?NjJnbUFhWmxxQ1lkS29rdFJXMElEOGppckNkaW10VW1uTEJmMngwQkxTc3FR?=
 =?utf-8?B?ZWRKdzc3UVUvQjU0aG5VUjMvMTJ6Mm9uSmR3RTZpU3lxck5mWHd4WXNBQjlx?=
 =?utf-8?B?T2gvYlZQM2NHZlJuTTVVVEJUbHQveVlMcDNKaGRhUGkzbmlJRVp5VnBNUFg1?=
 =?utf-8?B?bHQ1eEIxb3gwLzFYZFlvTXV6b3k0WUxyNC83dGhEZVE5UlBpMHV3TzBrOHJj?=
 =?utf-8?B?djlvcHBYUm9xdXEwdjFTL0gzREg1dE9OakR4RkRERm5CVUZWb3J4MGNEM1k1?=
 =?utf-8?B?N2JBZEo3Vk9jUVRRS0tEcUJkeWJZQnlRTFRjM2ZBcnpkQ2R0RXRFQm9LKzUy?=
 =?utf-8?B?QUNDOGk4bm5OUThsRzBxdm53LzRRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5f5867-0323-4949-798a-08db8f6863c0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 12:44:31.9316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDI6WokBWt1wQDDh1Q6nlnFBZLWyg/vV55TPulqzubngrhJ5AqF8bqDU62EE89//vLnFcbnk3Dxe9DkNxfuamQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 21/07/2023 11:35, Bjorn Helgaas wrote:
> On Fri, Jul 21, 2023 at 09:23:01AM +0100, Jon Hunter wrote:
>> ...
> 
>> I see a version of this patch here ...
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/tegra194
>>
>> However, I don't see this in -next yet. If you are happy with this latest
>> version, could we get this into -next?
> 
> I'm on vacation until Tuesday; will build a new -next branch Tuesday
> or Wednesday.


A friendly reminder on this. Can we queue this up for -next?

I know that there is further discussion on-going about if the core could 
handle this, but right now PCIe is broken on our NVIDIA IGX Orin board 
and we would like to merge this now in the short-term at least.

Thanks!
Jon

-- 
nvpublic
