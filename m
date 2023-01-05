Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BF665E90A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 11:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjAEKdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 05:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjAEKdT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 05:33:19 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505CC44C68;
        Thu,  5 Jan 2023 02:27:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQuKAZoSEA+EFuh6I8sszZm/BOBOrOtbEpmhgtjxvmsUcQP1bgejJvS3itYekav7/my6AKsvvnlenOK600SUL5OeCkDHrWKdzNT/tFy1aNyyRE1z0vu7+LEsb69kU0B3WQTVriayvxCXHwXQhp4BFWAh//6vQejInR+X4ca8rcTD7+0mDE3c2n/7RaSocPVKp6xp40c1VyDVvDDL+rrYIL2HsJUD7t+aOMNqGneTOzk6w4hTJBkArp6TRWu1fU5j68PaXbhoE36cBriVC5DBfPnFwvX0dRdv2h3CjVpPpP6w4IAjp5is5Riokemga+MHa0GfJjbmgHkUV3OKO6weRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU47etcGxb2QomgoFACnAFsFxnqU7Rk0kq2MAtjR6Rc=;
 b=RN40WGJqWnZUnjuGinHiFtngFvHOGvB84rxuWygCmcCwEt38Fs8C/KB/7Fq2s4rKJV9o+nrDqUmvYtDnklq3JpY3EiaFkt9aQHlo+eRhgP+who2hu4+tWbCLyT4slHgvUnjAM2lVKTANPQ/8qTqNZot2c1xVieEBgsPDwoSg7DVisHjFOVWP+xwMzgyY/Gcwg+fnI/+4rZQ2HV83YMQ7iJ5lN5QDDrI50wIqhObdnIJMSjsO6vYEh4CJgzNEIX0jxRkjl+/0YYT/+rbsKAGMgPDIlNDeMRA6nNm0KWxASgYPiCi78iNQS9RInhOrX4t06OMT5batv7CySpdwuOwsvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU47etcGxb2QomgoFACnAFsFxnqU7Rk0kq2MAtjR6Rc=;
 b=Tfpve/0moWk9Qa5nYIymkVb1nrtnAQBrKHkH6cqu2N8U+xog+4Q7FmHkh6a+pJmk9wFSCQ04mBEYp6PCGAl0WFbs7o7lXcUvvvsZvqtjZlevshBnQosxjVzBEG3HomdY1XPBM7CXkpcyPDQwOMLyrS2Sm7WU6/26YbqCkexMlVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 10:27:41 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 10:27:41 +0000
Message-ID: <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
Date:   Thu, 5 Jan 2023 15:57:28 +0530
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
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 250e5b58-0402-4538-d5f1-08daef077974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0y5gR9hxXgSuTnlD4v/TdHyawUu1+bXvAxl0WOV5ezeSkIJaWqvXnl99UdpUhbGkXpFzGNZ+lgMWQDHIXEix48lTj3gCPuuvPVSjThUjgUHJaQNxg2J0FHYLWUcbSgViqsQxsGN0CGvbX76ullNZuJeqbxVY4uuFQ9oRvTBz+Hlv1fuf/7+69rRnhRMC/bc9tOPdzWMFdOGgVYCprf3WQScY5kLEqlx7c/bb9aYp5nMOWKvquNsd4BeCIsUIfmR6WCLWYtAs0CnGS/427tywwtakq7E0b/9d03vfI5rvzcosPZac13s5by4OEXGIfT63T9BF6vEJ+ZZouZPy7jUbEaNXUsJDLQ29GnVoOTJ9GTEMknf+mcGxxDA93uX9+WuFYMRxYso1Oepd3odu1QMAlpZI8QTZ7zgsh4z/ymdFv/N2UfgzcXM3IEadsOapYdh01q8Pq5vXaI0r8RytZ+1Lo1kiMmvMapGXj2RK9oU9S+hnBr8Ve/beDVotTXexskD4g3rxJT8R70xM+NZQfU/YfGYv+3vE189NCTLdKW7bdiw5TaBVaIZx8e8+3t6rOoiYot261aWRFFYRs1U15PuWxRr/ZnkpZYlcJBP38oIaMHAyp99vB0XZk6gT0iUPwBV7Mpib9x0EJePzSPersXLrxFZEyYGGr5RWgViLcYIRnu2l4ORpgPTv6GUqw0bZG5Y8ChJb6+QNVTNs02uSeYZgQWq0cfBBw6RWtteD5QLr0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(110136005)(6506007)(478600001)(6666004)(36756003)(53546011)(86362001)(38100700002)(31696002)(186003)(26005)(83380400001)(2616005)(6486002)(6512007)(8936002)(5660300002)(4744005)(44832011)(31686004)(66946007)(4326008)(66556008)(66476007)(316002)(54906003)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZtZE5ETENVd2hiOXg0N2NrNnZxaUMzQnNyQzgwdkFlZTFQZjNmZXlzd1dH?=
 =?utf-8?B?YUdBclVGZTRDdnJEdGhmZmczTDdJM1kwTWVJYzNmdi9CUHQrUEo5OURKdUcr?=
 =?utf-8?B?WFJnL29lVVNWbUJNVUhFWUNYN0dyblB6STkvR1lTUzQxRUlsSitFQmtVVG14?=
 =?utf-8?B?YUpaQmVDM2Yrc0pVUWY0NTU5aElqamJVQnZxb3NqQ21qR3hBcGsxTlIyUGNG?=
 =?utf-8?B?T21HemJyb0duNWFqTmJLSVhWVFFTVmcvRmVFK1NLenFPYmVRQmxrZGs4Q1ZU?=
 =?utf-8?B?OTI4TVJROGtPOGJjbmxKOHF3c2F0dzd1bXRMUFA2SURJNndoaUxZeUVZclpH?=
 =?utf-8?B?WGFIVWJVMDVobXhhYzlhMm9hSzkrKzdrNHJycjFkckFTMGVVM1N6RUZDK1Z6?=
 =?utf-8?B?NDJ2NkdwTzRWNTQ1emhmNkdmVERVMEJGOHdremJ3K3NmN2lkbERpNHRYL2kz?=
 =?utf-8?B?WXR1cm5XRDFnTkxFdEdZTWdiNlU0a1JSclhMTkROaTMvNE5DR3c2MWlidGc5?=
 =?utf-8?B?SlRmVEkzcTY2cU94WEc0SUJ0SjYxUjViL2RoTWlYcWJXbHRMa2xnSTdTU1Vn?=
 =?utf-8?B?Z1ZYQjBQdGZtRDl3OHQzVHVjZ0g4Vm90Y1VNdTVicUFKaitlbmxMWDlnSzAy?=
 =?utf-8?B?c3dFZWdLQ3R4R1FxWU9BU0YrYmtkOHBMcTJmR0dtK3dOUHJISUZsRFZKQW1a?=
 =?utf-8?B?L2lsQWZ0dHJ4QnBzMlV3TE1LWUhwOGR4c2hJOVQ5NStjcWlQU3grNHJDY0pp?=
 =?utf-8?B?MEgxeGg1Mk9ENkhHemcweG8xaHliTXo4djhoOWErazIrVTZId2xYUTEvVElF?=
 =?utf-8?B?a2ZFM2xaTk1QQ1YzQnYrWVpjd2g1VHVTeC9XcHZIQkY3WFFrYU1oa3RFL0pQ?=
 =?utf-8?B?Lytna0JJa1JDWmpwem1mbEFSY3ZBZHFqOC9UU1VhNktxbWVGaWQveU03eG51?=
 =?utf-8?B?UEdrRGRqcVoyWVhxdkZEclFXSzh2MnN0aStTTUVETHZia1JJYm1aY3NMOEFV?=
 =?utf-8?B?T3g4UzFNMm9rRmJ5N3ZTcVpiZ0tYanJ0NUNIREgrNnQrQ3V4Z0d5cW1jZ3lp?=
 =?utf-8?B?OUdXUTF0YTZQcjNZcXhFN0hkVTg3bjVLRlZXa2NhdksybWtYQXRNQU9DL29m?=
 =?utf-8?B?K200WTlTUzVYWnovaVNKZmJZcG9EK3IvRnNUbDlQdENsaHoxMGR4WHlPN3dh?=
 =?utf-8?B?S2d5V3dpa3RzdzczUEhzdkNtSDNpeFgvdld2NjNqNVU4ak1Bay90UjJWSkpT?=
 =?utf-8?B?c2owYlJ4Z2ZPZWlVVmQrT3loakpXUitrVHd0RlhraEdZa3lsS3UxZmtkbk14?=
 =?utf-8?B?RzIwck5tcmY4bXJFWGxQelFVN0ovNXQrazZvZ3NsMURlYW5QV3diaEdibWlK?=
 =?utf-8?B?QXlIdmVUSDRaT0JiN1d4Y2s1S1AvWnYwcVhvcFNuN2prWm9IVmY2QllhWGxL?=
 =?utf-8?B?Szc4OWk5dW5rdFBRVXFzeFJxN2liSzM3RTJpWlI0U0s0d1A5TXI2cXhxcEFr?=
 =?utf-8?B?M1pCaXMvai9rRGxDQUZrL0dvU0ZjUnllR1lsZS9UamFYdFRnM2tRL25pamFZ?=
 =?utf-8?B?ZmdVdmFTRXZVdEpKVVI2Sjc3SU4zT2tYR055aE1CK1VFUkxudktkMVJXQ3Vr?=
 =?utf-8?B?QXU2Zmtyay82Vmx3bjBuV2tNUkl5bzlQNHpjeGhsT0QxMnhCUFlDcDBxN2tE?=
 =?utf-8?B?WTByOHR2RTUyUFFqOVNFUzVjWU96RHVhbEVQZjhsd2xaRzR6OCtiaGFlR1dJ?=
 =?utf-8?B?VHU1YVpEa1Fxc0xjSTBVY295aWFKYm1uNUxBM3J1Uk0ySGxCTUp1dDBMdjNy?=
 =?utf-8?B?MFlXRXZnNFkydUJ4YlhMWDVLYlhnU1ZHREQ0TWY4b0pzMVpKM0lmKzlsc3VP?=
 =?utf-8?B?TVdUby8rWnZ1Wno0dWYvNWVWR0RLWFlOYVdseU1SdkhIOGpYenBSVDg4RW1s?=
 =?utf-8?B?cndKdXJVS3NGNTlWUU9IZlNHMnFLZHEyQmFXYVJyOWJndXMzck96bzZtU3dT?=
 =?utf-8?B?dFJnMzg0TnNBeUEyMStjWlY5U29ZeHJxRkNOd1NnS2pGbERtMjlEOVFXMTl1?=
 =?utf-8?B?UHhoUFJOelA2UXJZSmdBQXI1bTZOMk43WjhKQUhzQnFyZUhkdXYxSkRLQ3Rx?=
 =?utf-8?Q?DohgCYlPJedcwOk62bLUEQnej?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250e5b58-0402-4538-d5f1-08daef077974
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 10:27:41.1449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6q78C7QNTkn7N3qsWJwV8qPC1Fh2ahpakn6QTebZjeZ2q1MDhcSRYv/bCjzqCqaiXKlmynQ8sjzpuIdT6w2+pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Matt,

On 1/5/2023 6:39 AM, Matt Fagnani wrote:
> I built 6.2-rc2 with the patch applied. The same black screen problem happened
> with 6.2-rc2 with the patch. I tried to use early kdump with 6.2-rc2 with the
> patch twice by panicking the kernel with sysrq+alt+c after the black screen
> happened. The system rebooted after about 10-20 seconds both times, but no kdump
> and dmesg files were saved in /var/crash. I'm attaching the lspci -vvv output as
> requested.
> 

Thanks for testing. As mentioned earlier I was not expecting this patch to fix
the black screen issue. It should fix kernel warnings and IOMMU page fault
related call traces. By any chance do you have the kernel boot logs?


@Baolu,
  Looking into lspci output, it doesn't list ACS feature for Graphics card. So
with your fix it didn't enable PASID and hence it failed to boot.

-Vasant

