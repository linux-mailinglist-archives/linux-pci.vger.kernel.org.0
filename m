Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2DA66459E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 17:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjAJQIi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 11:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbjAJQIa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 11:08:30 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97B953730;
        Tue, 10 Jan 2023 08:08:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VipFV5XYCDU8cVk/uXK1pfh5YwoeDXh58qNF/A8yr6ZVf65Sd/kcde2AGpI/bSPBADGpKIJOp9gg687rIKur1ZCXHsgcwps69OxwBYzTjELxTeAihNYMcJJfZSCUuJ0494Z4hb3iFdmOirvC6p6eo3bkTXJWwH7ipSKzv5ssAxXTVps18m///rnQvWVAbc3aVgqMFTpFmrBecQxjMH60f5c9DFnVmDJetni6FfDKH+6DAFM0SGk7RQR1JkpSj/sdkQ+b9vemgjrIkl/UevY6YJbwgpJMcuikq7iDzuBKtSDAvUMjgLJmfGaPU3SfkHzK/Bh9lWKUWsgtWkSSiv60jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLBbCpuys48xfolXMdNcWLIsMhJGoDfuJ1mZ4HaBPd0=;
 b=d1sJyrSlJKuRCOr8yWxb/+D+fXiaTVhGIbICiV26uEYDctO0dpCFqm3JWvTnZ/4F5p3al7xEMMvvppKsGiQezOYKOfSvBRlj0Q1PZ5lgcFKKsJhPaDiuAmI3Z6k7yEmGboTYv2koc0vWlO5zCtllKNZzqkI9Yi49nYYhQcfPixePH7H8J41LmhmE7OT8fDi2INezvslUD3Xn2Yl+pKnCQD53oQvhR2QtaI8dv4SU+cIDfQNYHcnLTt0f1ybk0VPQ4oDUZVVippb5bWhOFjiP+P+rZGWYiBPDO3aGYiAhtautA+V4KYz8SmRZkqeVGi2hQYkpsQX4dF2XQxvMm4Wrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLBbCpuys48xfolXMdNcWLIsMhJGoDfuJ1mZ4HaBPd0=;
 b=dnf2q3Y74wycVlzskMnXBnBBnUA6J4qVGd9O/f3ANEatOnYZZoqs6pzR+ZZQ6PQ9jksB09+0fv3ugQNr21uK/nQgBcH2/yQ/+FKXlWpcAYcz9v7anRxARpn5S/ZtWtYKGaJEMTpfggbkdstbRxQayv8C0HI5HA8G1wB0/39J45w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 16:08:27 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 16:08:27 +0000
Message-ID: <525730fd-5982-fea7-b6d5-2da69f225f04@amd.com>
Date:   Tue, 10 Jan 2023 21:38:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Matt Fagnani <matt.fagnani@bell.net>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
 <ff26929d-9fb0-3c85-2594-dc2937c1ba9a@bell.net>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ff26929d-9fb0-3c85-2594-dc2937c1ba9a@bell.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: c13f972d-adc5-4fe9-5cb6-08daf324e82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxcp7F2wADe/vxy/rRDB9F4YZO0BhHmD8BCD0BUM/pTHcFe7XmfAKaSwcOeEhyBeyW8Smnm3UKD8wbRo4hmkFUsEf7yevlgBAOi6UPPYX4hkM4fun/vqH/BJa8nYOPOEq2V3JrCTNja5KrLM78kknbS31nj6EPHTZ0nfgTEsjF7BR/0//Uu3jYRg1A+xwb/bRk73+aaGDnj/+plHjTijmyWeqmtrTs0qmm5Ruv9QJU4W8ryRavv2c39x1qJ+Wcdz6qvg8jliGacAm6UBfxTdz23vWeqU4uybkwGvGHTMK73AuKE1cQ4lEiInRHxpWn/4gDO8ytHj/wjetAXw7dca6rF2T+wi/2sAHy5DzH+/yQ7yksn9k6XfhNyKJxSuq47dw0aQcIhn1aFDo7rq8n2k8tmgk8SiDjV4FGjdA4MNVUVF0f7LOz8ls2Kg8gCme6mQs1cyS8nGBsVxOtpbGSkkeBZvDaiVmZXYKME+TDlr5MyhQpo3LtSFK2kcBaRYyoyf2iR3eSNiDygQz/d6y8L/roxHRa3eRFXC/DUBRkPboyZ5b9Fbh35OpomgX2zzkEstPudpbps9gJmaQGzxtK9yismIF8gN2iv6TnMF7b444LjZBt+MoKOmoBhgbTRPU01z8CLjdUFsqcO+xk/fCaIRHyunvXbFbRe58wCWwSpAZypjc+dk6vSRZStHNBtghUXTu+MCeYWdVeL5qsIqSicSHOCydvkxaA0zDzlcaUsmfLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(316002)(5660300002)(6512007)(186003)(44832011)(6486002)(478600001)(2616005)(31696002)(41300700001)(66946007)(54906003)(4326008)(66556008)(66476007)(110136005)(8936002)(83380400001)(86362001)(36756003)(6666004)(53546011)(31686004)(6506007)(38100700002)(2906002)(66899015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXdXZDJIMHl2VE0wM2N5VStqVzZDQjBWWGxjUnJ5OUQzaHRLYmQwZWZYM3Fi?=
 =?utf-8?B?ZG8vSHFSVlJZTmZ0WHZDR24wR3BENU5HZzlKcFJtSkxoY1c0eHFEeGtTRTlM?=
 =?utf-8?B?RzFqMm9Sd1NXc0gva2dPNXhXNmx1ZWdpWlMzWGdacjl5dVVLZjN2VHJmcGU1?=
 =?utf-8?B?S01ReWZVYVVES29TSGpsdE5STmowbEdIMURjeC9IZVFVa01iZ2tZdWY5OGJk?=
 =?utf-8?B?UzhYZEZQWHBHRWs5M1d0YmNoSXh6SVJJWTUvMGVWQVlGRGZ4N3d2amZ3L2p5?=
 =?utf-8?B?Y09haFA2RzdJcHZ1VmxRWSthZHNVc21WUi9PY1p6Y3RCVFRvMUpYTGg2bjhQ?=
 =?utf-8?B?aUVEVGthS2xMTVFETjJ2MTl0OEliYjlZbVNzRzRicnYrZE1ONk92WUw0amo0?=
 =?utf-8?B?Tm0wdkFnUWt3KzMwT0VEb0ZmTFY1Z2UvMnF2VUpMREkrdUlvYzAvaktqbkdE?=
 =?utf-8?B?SG5YWjJ5L1FPT09sQVlhU3ZGRXNDUUd4VFRQZDZ3dmUvZzdEQTlHL052U0Rt?=
 =?utf-8?B?Q0FQSmxjL3dNUlFHK25tQ2hOWVlOZVZ3ckN3c1ovdS8rVkhuZnpHelQvdVhl?=
 =?utf-8?B?Zld4cDllNWtIUU5DaWMzVG9VMlF5QlZLS2p5ZU0wT2ZSeGw1eVZUTjdubzFI?=
 =?utf-8?B?d3BlQWx5K3ZrYnlzYWdhUFg4UFBLaTdsdFRiTkhUNFdpeGFJSThDRVpwY3l4?=
 =?utf-8?B?OEE5c3RERVROSEdINGNLano0K0FDcmNDRFhURmp5UWp3OUV5RmRIdWh4Vno1?=
 =?utf-8?B?cTJLRmpHQ0JhR0FqUmIxZzE0bU5jUVc3OW9HUUphaEFTZlRrQlFSaTByNzZT?=
 =?utf-8?B?NUI4MWpIWUxVT3NheE1LOEQ0Q0lkaDdkaDI5VE5MUDlkbjFMaC8rYnVzRUhl?=
 =?utf-8?B?WHE2MEgycjQ0cWJ1TUNmSDN5V28zbTBZYkpoK3pwKzN4Tll0bEVEcEZodTVO?=
 =?utf-8?B?Z3lvaWpuQUs2c3dGTktEOW4wUWpZbitxMVE2OHZmdWpLdFpobnREdnVYVWhQ?=
 =?utf-8?B?b0V1cEpYMWFndWE2bU43Qkdxc0twMzhHMDJDQ3pKeE92R0FDYkl1eHZtdFdB?=
 =?utf-8?B?ZzBOQS9Ta3hXY1g2UFZZRGJrdG1hZEowQlZNUG9uMnN4UlJvaHJKVGRrSXVV?=
 =?utf-8?B?dXdGVFlPZjBMWk5heDVTdHhPRFlFSzNjTDljYWxPSEYwZlFZTDRHTVJmOFo5?=
 =?utf-8?B?NUYvQ3ppRWNSS05xeWRFNU9kZUJrWEczRkZDMGFmRGs2eCtGL1l4blFxTVhN?=
 =?utf-8?B?N3puY3B0L3QzdHJDS3RmR0o4MXdaakJKWmtBTCtBeHZCK1VQMlNYbDN1WlNF?=
 =?utf-8?B?TmRmYzNhRjVhWHlOZXpoNjNydFVQUjRUaDA2anB5cXFRWURZNVdiOTFodzds?=
 =?utf-8?B?QkNSL1BiUzR2emxuVm9YWjhlU0lIUmMvQllOU3RpZEpaRmZjV3kwd0c3clY1?=
 =?utf-8?B?SWh5L1F6UXdSbmFGVzdwaHRCdWxxc0ltQ2ZnY2ttdEpLOE5jL0k3N3ZQU2hl?=
 =?utf-8?B?eHZZZmJ1cW1ja01MQkdWTzNjbmpjS1dpa09vZ3F6S1h4QitSbDdlbFJJdEtS?=
 =?utf-8?B?MWdiSXRRMVNwdlJRc3d3dUNiVGh4YkpLeVlvZitJT0h6ZzNFVkhRVVFRT3Jn?=
 =?utf-8?B?N3Rqc09kT1J1UWttU2VLRGdGVmNjNXFacW5wMGN6RXVOaUxvaWgybTc2MHdY?=
 =?utf-8?B?dmZMYXZEUm9oTzc3RmdwUXcrVXVHdFlTUW9keXhQUThuekpjY05DNGtDNHJV?=
 =?utf-8?B?R01IWWo3b2NYYU9aaGh6YWlVeUJLZURuNHpGOFk0S1FIZForRU9JdnhCQWtq?=
 =?utf-8?B?ZkQ3SytyR2FBYmdoZUJwSXUwNjUyU3YrNVNCWk5CUUxlcUxhQXdxMUJwMEJR?=
 =?utf-8?B?MXhPVmhuQnU4eC9mVkp4aDlzZE9mMVpzeTdiT0dSWjRWK2tWdG1BYnd2Tmd2?=
 =?utf-8?B?RjFNb1MrQ1BkNUVNY0QwUTRVVmR5Snc0bVlmZDdPdE0xbUdFaUxsNXRqQW1Y?=
 =?utf-8?B?UVBjU3F2L1JYOWdxR2lXODJLVThUOTNpYmJiTU9UU01OR0JZeGNheFJveEpY?=
 =?utf-8?B?NS9TdXQzVklGLytIQ04raGV6LzFwZStMcjdTRDlIVnJqOVZtdlM1ejZDdnQw?=
 =?utf-8?B?VGFJM0t4TnM5cm8rYmp2N0FJeEs4Z0VVc1Y4SERpZFR2YnpZRE02NGpGbXFV?=
 =?utf-8?Q?fPsE9avORRNuu3+0bjsdF6+ZDrSEzKKZ2i9Aj7tCA3xf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13f972d-adc5-4fe9-5cb6-08daf324e82b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:08:26.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2zDj3r5HtXs3vykKX9HgFguyNAz67EyxYYsPzH0qDxr5jycZiSRezbhM7Ufhf3YM9wvlQs5wdnRsHCmdau32w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Matt,


On 1/6/2023 12:58 PM, Matt Fagnani wrote:
> I booted 6.2-rc2 + patch with rd.driver.blacklist=amdgpu on the kernel command
> line to prevent amdgpu from being started while the initramfs was in use. The
> black screen problem happened later in the boot. I pressed sysrq+alt+s,u,b to do
> an emergency sync, remount read-only, and reboot. The journal for that boot was
> shown on the next boot. The two warnings which I previously reported weren't
> shown in the journal, but the same null pointer dereference which made amdgpu
> crash happened. I'm attaching the kernel log from the journal of that boot.
> 

Thanks for your effort to get boot log. This is helpful.

Looking into the code further,
  iommu_detach_group() didn't attach devices back to default_domain. So IOMMU
point of view device group was left in inconsistent state. This resulted in
IOMMU throwing page fault errors and amd IOMMU event handler code always assumes
that domain is setup properly. That resulted in below NULL pointer dereference
issue.

  Jan 06 02:07:52 kernel: BUG: kernel NULL pointer dereference, address:
0000000000000058
  Jan 06 02:07:52 kernel: #PF: supervisor read access in kernel mode
  Jan 06 02:07:53 kernel: #PF: error_code(0x0000) - not-present page
  Jan 06 02:07:53 kernel: PGD 0 P4D 0
  Jan 06 02:07:53 kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
  Jan 06 02:07:53 kernel: CPU: 2 PID: 56 Comm: irq/24-AMD-Vi Not tainted
6.2.0-rc2+ #89
  Jan 06 02:07:53 kernel: Hardware name: HP HP Laptop 15-bw0xx/8332, BIOS F.52
12/03/2019
  Jan 06 02:07:53 kernel: RIP: 0010:report_iommu_fault+0x11/0x90

Ideally if domain attach fails (in this case its because pasid capability check
returned error) we should put devices back to original domain.. so that it can
continue without PASID capability.

I have a patch to handle these error conditions (not the fix for original
issue). I will try to post it soon.

-Vasant
