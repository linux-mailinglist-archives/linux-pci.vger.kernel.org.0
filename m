Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104FB5B78EC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiIMR7H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 13:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiIMR6q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 13:58:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DB18B2CA;
        Tue, 13 Sep 2022 10:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuRAJ1Yds9v3OVjlyUP10KFbtptfg2nRrFFN4Y96zKhnGSJyD8LTj8e4Jam9HQA0W3XhtEV4p9RZH3afDSMyZZ7MDSKr6HyI0SbOkgXcaECv7oUrELRq4BFI+qkr6MiGp9l4ddpYLa4Y2olDRDryQ8J26JLYTwBDGFWt0He2oCLos1PUi4M3BxrYukKHo85e8Cv97Npe6IjtH54W+6NoKhclNTFHJ3QRJjb53fbsayV6b1LlRgdycwtbtxHt0zD3cjnvV0HOXU99P+UuVJK9P6t99lDPTsnEmfEkl1QPNFmSDmWI4I5fKf8UISfkUYMRsBV3Y+WM/ev006qc7SFEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CX02jKyZZG9H8nQ6oZerlV8NqFmA33vxj6HLu8py+2U=;
 b=NDS4VLOe2l5Q0QNOu07RZdvVSUjDCtmY1R9y7aGswsTp+yM2EvQDUhRbnmxo+pPxvlNGRt84IOOA5khvh5BBC05dczGsyDQDMNTzdqBwwO5nWEANUOPxew3Fq3zFhl6DWqlxkOvcfilN1IYOCgxKa0snZGCPFvWEJxAXmtKGnMNHNg+KHcQZeEER1f8iS6H3M7XpfElOyWXGqYgLnA2o97YuWqtSS1ztZupRfJntMgg7gF8uSk7eJF4OcUtGa6s5TWne+WGQAUK+NgcyRGrcMkVgMlo1u3EU08TyJtdUdvCY8efGySMtIvU/d5+MxJVcrXC6b92hdcJDBDnBSNnNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX02jKyZZG9H8nQ6oZerlV8NqFmA33vxj6HLu8py+2U=;
 b=G7COzmS7wKDD72//kfGFfLoDh791RE8x3MM57SkgyIVC5uPSRv7Jdh3sR4adKrThiSJ6bj489IUjBYjN0oN1Yht7HUYijDTcMRGw5uS9VhAWptnVeEWNvlrgtkRLoysgWi2USTVFRunKDdgerC6iUdu1PxYBuk/lsHBDYFWc6SjZVAGUXD1+zJaotudSVyLc31pQYIbT8Oot5EbGCAmH8r2aJkL6pkUHqiCeMw1mRKLQ5ZwAFxSjFDTYrdsiILX6/fsEyDHA8YvgC+Be176wXD2ywZkkOsPjeJzG+E7KHms5vn0JntqHZJDdaeHaBZKOFO7kAJGZsLyxGN0611Zwqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 17:00:37 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::7090:22ef:abb3:ae9f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::7090:22ef:abb3:ae9f%7]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 17:00:37 +0000
Message-ID: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
Date:   Tue, 13 Sep 2022 18:00:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220913101237.4337-1-vidyas@nvidia.com>
 <20220913165159.GH25849@workstation>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220913165159.GH25849@workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0476.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fa4b74-7f3d-42a1-af06-08da95a97aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdMXX23siL7zCz482vWImbKz0vrL0nBw/BWJ/mzxj28vuo1mGAvgDjxgHJNvElPNkACggx//Jy6q8XzY7N75qju8ZsUOQ1fkXQPUsK8isxXCMKRw0poef9g5yrgopkAXoe/kjn5OO4mliqekC4alS3yN0+THgmwx/w/F9SXzueQ+fuitwcjJu5ywtydsH4R5lYuTrYTbj53xFfaM+sQwmYGdfLGhf6mI8dco+lB3FBCpDEkFuHstTIHtWi6XhDhBgMj34pHpprweRiimZeIxFOoUHo89Yvs+cgTKuIAeB8+fo+Sra1ee+yXuF/4vAkpFsnRXXCUTwNrsDxHlPezI5mHESUTtNVlCfnt7cVuiEnhlWnHD4cLyVOwj+JiAxIpsSlQj/6QBLfox/Gc59puWLqallTkVSOv9JLr3Hg8PZ/pey1lpzwD7HVM1EM/7kzo1U18gJl2Cw8sL4xbkOBQRs4s2XezghyfF7w2eSc1oSOQ6pHqOWO/vSxuX3exQKhZOLr/Hhe84nJETzcDmY3l4Q3wyS8RPraiE76yjej7kQPCNd+b2tR9rBYx3JUWSfVr5qEQeHB4+OSHuwf0HpMaHoCQwFkNmPJWrIKHhrBofkUyd32FkbSs+5OkLiK2nDF3nlXpncU1aEPMGZeKiygm4T198ZOdzp+JfuK+A5+nRrovpYZV8RmbrPLMB4u5MXzIm0ZWriZlA3tpZdox61fq3t7xp5aHudCsMnLNVupBuLMchsTvc+pqYqIiSiFvpX2/t65rhs73JpmibzKK1sLqC8cCZ/A3ofdA7cs2MWYn2eMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(86362001)(478600001)(316002)(186003)(53546011)(26005)(110136005)(6506007)(38100700002)(7416002)(41300700001)(2906002)(6512007)(66556008)(6636002)(55236004)(31686004)(66946007)(4326008)(31696002)(8676002)(66476007)(2616005)(8936002)(6486002)(36756003)(6666004)(83380400001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnhUT3dEbVAzV2xyT0Ixb1BHMDUxQkR0MWxVTTJIUUZvOWpoTk1BTFZianlv?=
 =?utf-8?B?UXBZYzlWeU5naUV1QXcvTEVYaWwzYnZ0UXBXT2Rrd0V1d251aTFNL1pSb1la?=
 =?utf-8?B?NzJsMVAwdmdObXNKRURoYno4YkR1bVp4elY5M3B2ZVJZSmlzYlFSUDFSQnYy?=
 =?utf-8?B?dlVVbHpLQkd3cXpPSUZ1WFdpUG9JZDI3MWVSZzRKNmgyUTh3NXRreHJGZThW?=
 =?utf-8?B?aVIxdDFmR1I3MXN5MUpmcWVSaUFGVnhSMmVmOHlMb1JrK2xyYWptNXdGSkJ0?=
 =?utf-8?B?eFo2bGZMK0QyRXZNb003cUFoOUhseEhLdVNmeFBSamxrSXAzaWlrakluWCtJ?=
 =?utf-8?B?cjEzRmgvY0k0eVA2Z0pqdW1URlpzVElPOE9UdXEvY0tiVHZWOGdSUUJ6WXNq?=
 =?utf-8?B?Z05tazZiUktBZStLUXpOYkJXMjFrZXl1Y2ZxSEk5UjRMbTBxSEZGVnAwMzIr?=
 =?utf-8?B?aVlQK29VKy84WWRPTHcwYmxQYitJQ0hSbTQxbnlDcGEybnhsN0k0d1djbkNT?=
 =?utf-8?B?d0xCcHNKMW1yNlpzd1lrOFArQkt2ckdzN1NJVlMrT3dsbTBDSzZJdXlla0dE?=
 =?utf-8?B?anRnd0RqbWJuSGV4UGIzN2NlZVE2VHgvWDhJSm01dFVLWTZtdFd2cHlaZ3E5?=
 =?utf-8?B?czZlamNTODdPNWdNZjZrQjBndlVFZnN2T0xQcWk1WTNBMU5xMmxvYysxb09l?=
 =?utf-8?B?TFBCNzZSMTM1ZHp1VEdCWTNBTnpYbi9lcUtRU3pJdEhZV3Mwc0pWckdMMDY2?=
 =?utf-8?B?L1BySmtKem1mSUVYbVJQNTB4dFExa2h1ZG5DdVhtYWJHNWlRdnJ4eVpLeTgr?=
 =?utf-8?B?UHZmbS8zelByamcrRkdCR0NKRjI0RGFhR29FMVZIQk4wQ1hJc1Q1MGFOVDFF?=
 =?utf-8?B?bkd0cG8yZThkeHk3dUpTSWk1TjBwSHB0NmpsVlRzL1FhbHcvSlR4WUpzVzdj?=
 =?utf-8?B?TnZNNlY5WFQrVUloYlRkMXhXNWhXVFRuTW9OVTRNTDNxdjZEeHUwWW5BOTVz?=
 =?utf-8?B?eFcya2ErV1FVQ0dGUTNxOS9YKzN1WWVxeGovSGlBcDZGNFQ1cHF5SDdaLy9w?=
 =?utf-8?B?WmFGdXNFSE0yR3hSaG5DNUFWWjBtVkQrRTRUNXdaaFg1TVppZDhRdmxORFFN?=
 =?utf-8?B?ZnFPdUpXeVhaMmlWZElPRkFjMjNQNG5HNkYzc2YvY0IrWmJNazFlbVJSazJZ?=
 =?utf-8?B?U0EvTW1OZzlueWd6Zy9hNXpCbUtQMVZ0ODN4WTExVlZhTXA0a0lYQlpJakx6?=
 =?utf-8?B?aU8ydGk3Vm9UY3FsZzNxenFGYjFXTkp1VjhHUEd6K3FRRW0yUDlzdGlHRGhw?=
 =?utf-8?B?UGRFKzR4TC9udTVtTjhEMUh0QUdQVjU3VXAwZUU3WTd3akpqZjJ2VmZuRVp1?=
 =?utf-8?B?cDY5amFHUnNuY1lCUDRNVE9kMHh4dllmUFhFbE13YVUvWnJ0VmlCM09oTlgx?=
 =?utf-8?B?ZGlwdktZN0FuQUJiLzFsTFc4WGpRZXlIbS9MTVhyK2VsNTV0Y1p6dk9nWk1N?=
 =?utf-8?B?ZzhPbkt4QkhVZ0RmL00vNlY1S0E3MTRVc1laUFpVakRpQkVZYTZFZVFJNlFV?=
 =?utf-8?B?eDBYQmV3TFd5VFhRTmpkeVRsVjE1NG5ZTHI4bVlNd2ZkRG40SnVObUZuQUlW?=
 =?utf-8?B?ellaeVFCQjdBb241VnNWZHVuNm03MnpsQ1NoR0FlNUhDQUlzREh3bTJlTmFB?=
 =?utf-8?B?RFpXTjJEZHQwS3dMWktBSU1Lb0s0OCtkWUpnbUNwR1k2M0NvNUl6ZmgrZUww?=
 =?utf-8?B?dEJ4Z0JjeEhBdU16ejBIdVRwclVoU25VOWtub2lKSWJ1MDRLVSs3L2F6VUpE?=
 =?utf-8?B?N2t6cDBWWm0rUmRnZHF4QXFDZGtCNVBPZEtOQUJyMVRpenQrMnBWbmpwUWVm?=
 =?utf-8?B?TTFYOHRHV3MyMmd0eXY1d3JPYVMrTmxGdHcwK0tOazI3bU9zMG9PTUx0Ynh6?=
 =?utf-8?B?TFF6RmljRHppTDZVTzIwbHo3NFVOQVBlczdUbi8zaStyMTBUeHhBaGk2VElr?=
 =?utf-8?B?cEI5V1dxZXZSUGk0UFUrbFh2ZWtGQ25yQlRJY3JINTVhUkRqNTR0L25JTXA4?=
 =?utf-8?B?N1ZIMVVIV1ppRmFJOW1GMkEzQkFLUmFzM0Y0KzN1Q1huY1hzdDFuOHpTVUNH?=
 =?utf-8?B?R09oUU1lWnU0azNkZHhuekV1Z2RSb2t4cHF4ZDZNd0ltQ3lpUUczYlBKR2hz?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fa4b74-7f3d-42a1-af06-08da95a97aed
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 17:00:37.3879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMQKfvZJoNWD1v+mzP6HRHJKPOvaNWTrDX85vYGMyJrM7cmmFvnfyeaICwr2jB6YCBrPCnUFrjS5BKICzq884g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 13/09/2022 17:51, Manivannan Sadhasivam wrote:
> On Tue, Sep 13, 2022 at 03:42:37PM +0530, Vidya Sagar wrote:
>> Some of the platforms (like Tegra194 and Tegra234) have open slots and
>> not having an endpoint connected to the slot is not an error.
>> So, changing the macro from dev_err to dev_info to log the event.
>>
> 
> But the link up not happening is an actual error and -ETIMEDOUT is being
> returned. So I don't think the log severity should be changed.

Yes it is an error in the sense it is a timeout, but reporting an error 
because nothing is attached to a PCI slot seems a bit noisy. Please note 
that a similar change was made by the following commit and it also seems 
appropriate here ...

commit 4b16a8227907118e011fb396022da671a52b2272
Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Date:   Tue Jun 18 23:32:06 2019 +0530

     PCI: tegra: Change link retry log level to debug


BTW, we check for error messages in the dmesg output and this is a new 
error seen as of Linux v6.0 and so this was flagged in a test. We can 
ignore the error, but in this case it seem more appropriate to make this 
a info or debug level print.

Jon

-- 
nvpublic
