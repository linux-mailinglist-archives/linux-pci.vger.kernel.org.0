Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CF2595E68
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiHPOfb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 10:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiHPOfZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 10:35:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7821A6CF65;
        Tue, 16 Aug 2022 07:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ds9vtXKl6pDzoLL6UlJHFwgzmb3wo9Z6aB9PU5Idd2J0P9KafudZiKMBupiSi0m4ONvfIcKi37kBoi2OZaMxs09m72n1Jk39aEYMKuFiXqM5yVC2XaOBM2kA6tVjdIFPQ/ZwGKDxMD+DqQtm8yE8yQ9rGMEi9TckSQEOAtxtrT5eBcZKh6JCErK7clOPqYdCIYLNUJibZygMZTaHPZ9uPH4GhetN6ml++P2eSiPfviH+29AlDWTQZEqLaDX1+jXgTXlFiwaGmtnII97HOIZByAqWQJ2WzL6Xm3Yjr7hq5GDkwbrwxMcpIx+dKM4kH8XdXQflBgZm5j4hzbLqToXmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXY0gozIbvPFL27WYqJUQOvc6i+Rbm3I/iaIB5C8whk=;
 b=P6NKJ73sy8/7Znd6qAmRao9amKi24b3qsCY9bNj5EKi9D/HybNnBwMpio3hB5/F+qSbrg3tkE2pgqSmGAqMMI6G4b2vJK/y8vn7uzifQMJB6o21rUWDsxgOBA0khhjhqfdAmaGiAm8jiCQVDYKuTbVncTqrmHqseVCQ40phdcWJkMuuDOr/O9ofog3oJPp3F58uTuBDK15gLFGcuA6YPgjiqTSVLINWENpMFuRI2c6q9htKFQ5NKYxzE9tgy5bObLcDKBQ7wW+roUbpLGSf8aSAQRxxuKdVXbqLGDAbu6Q2kp5KgfgvjQkomJLogXsOiTPoBP0kVmtz3/BEWse1w9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXY0gozIbvPFL27WYqJUQOvc6i+Rbm3I/iaIB5C8whk=;
 b=lsBmqxid6Qbm5LXeONBKpNIW2LT/B1mgS0WRj2iOMl/GTvyabPpvDoi+pYeeSJzjfT8WBbr+JlKEQToej8i61vYnLcpCYsrY269u3M3rg0Z3VhXs47vu9SA48yp0V8+YPpbv7OA8Bc0DQY9SYzqhOK5UPhHbbOQZHTbbTpqbEBxfh1lutbdlTQSW8OUQ/gyoye0IKszmEf8SULHIVy/FzTo9zc4MhLGFRZE9kNSbgV5VO9eCPt/kKLjMGJj8Y6QpmXfdQJz/jz33/BhwWAchYQKuAqDGnzx3XB/Lh9rXM/AKigGdWwXmeJiv4u1NaawLHLebf8rH++txTqk39Dsong==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by BYAPR12MB3093.namprd12.prod.outlook.com (2603:10b6:a03:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 14:35:21 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b150:321c:21e4:40c9]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b150:321c:21e4:40c9%7]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 14:35:20 +0000
Message-ID: <5d9f537b-a7a3-b8ae-8779-9ffc15fd11bb@nvidia.com>
Date:   Tue, 16 Aug 2022 20:05:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Content-Language: en-US
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
References: <051a3baf-b4dd-7764-2e61-03584cefb4d3@nvidia.com>
 <20220729224404.GA478920@bhelgaas> <20220730145025.GA4005@thinkpad>
 <CAL_Jsq+tnLMcKGxzTJODQjCUTXU1yoMS2yF3WxEEfMmfgRt5uQ@mail.gmail.com>
 <20220802072426.GA2494@thinkpad> <20220802140738.GA115652@thinkpad>
 <YvumZJdDAqo7DfBe@lpieralisi>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <YvumZJdDAqo7DfBe@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::18) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c34c6ff-cb57-4402-f12b-08da7f948bc8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3093:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3BmK2JITjVxN1FoN2x2RGVwdHBFT2trTmVmdXVlKzB3VnE2TFNGTHQrUFFi?=
 =?utf-8?B?YTYzTW8zVDFuU0lpUzVWQ0VlVWxBR2JSdFJJMHVDMlgwd0dtcmRoN3BobTNG?=
 =?utf-8?B?MWUzeDBidDl6a09PTExJOUJkUFliWFVvckJrZTZ2ZGlnK2lkMDk1eU9VK0FU?=
 =?utf-8?B?WE9UVmVLQThjNlAxZW9XYlg5RGk5NnBodGd0aG42UEdJUENqOGhSOHlLbzJM?=
 =?utf-8?B?cFFDMVVRdU9kS2c2MEJtVXdxampVMHNIR205TXlIak5zVmh5YkdObThXZ0pU?=
 =?utf-8?B?bm9vMTM2NmJ3U2FqMGRNQ0tOOU94MHUxUjhyaFlWOGw4NVBXVkM0V2g2YjFp?=
 =?utf-8?B?Z05LeXBENEN0ZWlLVWlzcURvR1YyUDYvTnRuZWNPUW0yTXdFRTVZbFBWOW51?=
 =?utf-8?B?NlBudkV2V3NoQk1zWGtHZHovbXZVWWF5cTZ1ZmYwc29CRjl4NXJsdWhpSzdw?=
 =?utf-8?B?TVVua1lMZ29yY3hDV0dCTDkvQW1vTnhjMzRTNDN2bUx1dlNrRUU5QUVtdWhO?=
 =?utf-8?B?Mnhwa2hhc051U1hEUDB3ejRTZ1o3czJqUVo1cWtkS0lIamlmT2xRNDgxZDkr?=
 =?utf-8?B?L2dHYUwxaXdxaVNicDhOczBPN283QkxJT05INldmN0VRZVFPQXZLOHYvOENK?=
 =?utf-8?B?OFVRdFhkcEhHOTIyMUpENFFOSlcyQ2NWU2t1UkppK2pXZjc0Y0UzcVN6Mlgv?=
 =?utf-8?B?dXJUallhRUFhS1Q5MTlqREwweVJQWWg1Y0NVOEY4Mk1KU1pPUFZLclVjSXU5?=
 =?utf-8?B?WWlMdm8yY0wyaTZVTVZ1ZSsweXFzQTlwMWtRcGJET25reUg4YTc1NFkxS0po?=
 =?utf-8?B?eTU0T2xYektFQWlCOXZjM2YxS0E1R1QvYjVRai9Wb1p3MEk5WGpReWVCREFS?=
 =?utf-8?B?aERLTVRxbEwxWDEwTm1jK3hBcEFYRVdmSVltSFhib0lWd25MV0t3ekd2RVJF?=
 =?utf-8?B?TVFQK0R5YzVDSFNMNlFCUUF5Wm1ta2FrRkRjTVZoeWYrMHZ2bm5WYmU1Rm9O?=
 =?utf-8?B?dWdWSXZDSlprbnMxQXAydXdqV0Rrd3k5R3hSNXlsYjlieE5ZV2dLTGRHalYx?=
 =?utf-8?B?eTZXeDZqcTJyZ3c2a0FOSEMyMEFjNVc1cGZwWGl1cHRZYU9aLzFsL3NXOWUy?=
 =?utf-8?B?RFdLYzFEYlpyc2Q0c1QraDNFWHUwMkQ5V3VRM2Iyb0hDakpaL2p1YkZzL1Zi?=
 =?utf-8?B?QlJDTGl2VmFJS0xJWTI2bFJCRERyRkVyY1B0NEN0REZ1TE9zdzR3UTN4TWFJ?=
 =?utf-8?B?RTl5aVpnTUhvSE5aR3lCN1JyRUtja1AvM041VENHVnlhTU9Kdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(66946007)(316002)(31696002)(66556008)(8676002)(83380400001)(53546011)(41300700001)(6666004)(4326008)(2906002)(110136005)(36756003)(54906003)(186003)(31686004)(2616005)(38100700002)(26005)(66476007)(6512007)(6486002)(6506007)(86362001)(8936002)(478600001)(7416002)(5660300002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ei9TbFdvdXUxVjhlNGlNWGQ2MWgxMWsxMUlyci9xNVNqTmJ5b2tXdGRPY3ho?=
 =?utf-8?B?OCtWY3NaN1VqRHZ1WTd5b3R6ZTFZbnhMY2VHUkkxclZ6U1FSbkJqWFUyczdz?=
 =?utf-8?B?T1pyV2ZrSFFZa0o1SzA4dGFpOURldE5nVHdzbmdxaklnelRGMlZDaERmdTdM?=
 =?utf-8?B?Yi9yclBmTFZuWnVlajNlc2J3QzZodjdsYTJlU0FQUzFSK0hnMzJJU2c4NHh6?=
 =?utf-8?B?SzFVcEtLTi92UzllUFVpSXNFeUcyak96WnZkOVdyNTlMMy94Wm93NWlrQ3Yx?=
 =?utf-8?B?N1VwVi9pMy92dnRuWGZFS1d3YU1yZUJZNm1EaW1uZ01TdkZOTzYzblAwYlNl?=
 =?utf-8?B?TmNsRVI3cmVwT3NRYXlxZ0hzS2dqSDBRNytUSmRUVjhTYWNnSjRTaDhNa2Ew?=
 =?utf-8?B?QXFGWE9ab08xYkN5TWhhQk55Rm5DSnFBUS9iY1d1MVVYc0c0WSt1MkJGQ1NK?=
 =?utf-8?B?ckZzSnpBaWxHcGZyYVN3N3JvWm4reFFKU0VZeTAzMWlqc2Rid0VPay93aEdT?=
 =?utf-8?B?dmZiUnJscVZkOXRNRFhBdlo5cFNwaTlYaC9CMmlETzBqS3BUd2w0WkhRK3Rx?=
 =?utf-8?B?RVZUK3BsMUlVa3U3cENMOTIrUExpK0tUK0FNdlU4Z2crWnlCZS92UzNqcmND?=
 =?utf-8?B?ZzNZOWVzVzZJY3lIYW9pU3QwUkYrMEU3b1VFMmdZbTNjUzNFRkEwRW02MFp5?=
 =?utf-8?B?eWxKSTFBdnRZMFl3dFdUZXovV0FqK3NTNHJ3MjVoRlljQjBzaEtoNkM1TkFG?=
 =?utf-8?B?OEpQMDRIY3E0SWxrRmMxKzFNbFhpOHRxMGpHNTVjUTJ2TnNrSUtwbVdVdmMv?=
 =?utf-8?B?WGVNZnI4cG5KWWN5SUowSnFNWUdOQkFST21yRjBvU2h5QVJnQTN5a3VFVUV2?=
 =?utf-8?B?SDBuSXNlRnU3aFFCSFZlM2NaWlBPcU1DT3FtSWxEWmJwbTY1Wkw4MjdTZ3B2?=
 =?utf-8?B?OU1NUTZDRkZybDVGL0Z3eFpNQVZFdjJmUUFwdlU0alNwY1kxNElad0x3TG5G?=
 =?utf-8?B?cjQ1c0NCV0RIMklxaFlPaHRLajI5cGQ1ZGFQR0s5ZVRWdXA1ZVJzRE9zUFov?=
 =?utf-8?B?SmhkVktJYURxWUlsbWhtR0lSNG5XZUJ3VEFnVldZMktYYm9BM3BIcnRuWVVT?=
 =?utf-8?B?WkZnK0QyeXNwNnRETWlUdUluSHByUmlkbmlVRUJGSXBGZzZBcitNekpMYXpI?=
 =?utf-8?B?N28rYXEyUmYrR0szanM5SmovT0RhbkpDZlVQdFBYS3phVHpVRFFLbThKalJy?=
 =?utf-8?B?SzdBdXlqZmdPOU50VDcwN0pxSk8xcWlMd1d2WlA2N0wzVjU3VHVHZjI0L3gz?=
 =?utf-8?B?SDdyZkJzYVNWT2gzK2laVFNEbjBBeE81R3NLNWlCWEZkYlB0SXBkWE1maE8v?=
 =?utf-8?B?bFMzVmZ5bHdOS241dnR5MWM5UlJyYVRYN09EMkFaK1dudWdtemtVWnNpS1l2?=
 =?utf-8?B?OElKUGxCV01rZVFPRDZKbGsvRXZEUDNXeGszTDRhVmx1T2VhQVMzbElvb3lI?=
 =?utf-8?B?VDBZVXNkWFBiWXJuT2d0dUwyM2lkZkcwMWJISXBxTDVNT2RldkdHSmhvTmtw?=
 =?utf-8?B?MWVtTjVRaEJyZTgraDZMa0ZFVjVkTDdFSVB2MVE2cytub09zV1J5OFU4ZE9a?=
 =?utf-8?B?UGYwZW5Hb0Z6eWFneHVycTJzU3oweTFYTFRJWWFWWTZDdVllNkN6U1VBVEM3?=
 =?utf-8?B?cFRmdGk5NldSU251NHQ1R2NlK2N6VGZQNVY1OHlFZ2pNYXAyYmhIN25nTlMz?=
 =?utf-8?B?MkYrbzBiWDFsdmVkT3UxS3RYYkVaTGZGTlJyb2ZKOG5mYk96NC9YSnBxSUx1?=
 =?utf-8?B?SE5LK095dTlqRXdYTE9xbFJIQmkrd2ZIT0U5OTlaOHNEcXFYMjVQOVhXVUNC?=
 =?utf-8?B?MGh1UjQveHhOaldRcUJTV29Od1J1TVJrY1c4K2xmS2t1NG1YWkRmQmZ1KzFB?=
 =?utf-8?B?cGNsckUxaUFSM3ZPL1drWm1YY3ZrY0dpZXJFWHZrUHRVSzN5SjB4TTFJVkNJ?=
 =?utf-8?B?azdmMll1SkUwQm16c2lmWjIwcTlEU0lkeTdEZG11Y3crRCtWWitxaWZMeEQr?=
 =?utf-8?B?SGhDYWg5dWxpR3U1ZVA1YnNnVFYrUzgyNXNjL2ZWSVovQ3JmQldDQmNMUHZ3?=
 =?utf-8?Q?XSBseIa+6CqQRkQaxjYFCYvSt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c34c6ff-cb57-4402-f12b-08da7f948bc8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 14:35:20.8279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hm0u4Ji+3GGhvxDAYVaHucz+1PcQ7hiob1nUKv1ARPDNggZ0rHs17sdgenK6LUvYAy4GL/Ab62q/6oNMn1k4Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3093
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/16/2022 7:45 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Aug 02, 2022 at 07:37:38PM +0530, Manivannan Sadhasivam wrote:
>> On Tue, Aug 02, 2022 at 12:54:37PM +0530, Manivannan Sadhasivam wrote:
>>> On Mon, Aug 01, 2022 at 02:27:14PM -0600, Rob Herring wrote:
>>>> On Sat, Jul 30, 2022 at 8:50 AM Manivannan Sadhasivam
>>>> <manivannan.sadhasivam@linaro.org> wrote:
>>>>>
>>>>> On Fri, Jul 29, 2022 at 05:44:04PM -0500, Bjorn Helgaas wrote:
>>>>>> [+cc Xiaowei (author of 6bfc9c3a2c70), Hou (author of 8bcca2658558)]
>>>>>>
>>>>>> On Thu, Jul 28, 2022 at 05:56:28PM +0530, Vidya Sagar wrote:
>>>>>>> On 7/28/2022 3:44 AM, Bjorn Helgaas wrote:
>>>>>>>> On Wed, Jun 22, 2022 at 09:31:33AM +0530, Vidya Sagar wrote:
>>>>>>>>> Platforms that cannot support their core initialization without the
>>>>>>>>> reference clock from the host, implement the feature 'core_init_notifier'
>>>>>>>>> to indicate the DesignWare sub-system about when their core is getting
>>>>>>>>> initialized. Any accesses to the core (Ex:- DBI) would result in system
>>>>>>>>> hang in such systems (Ex:- tegra194). This patch moves any access to the
>>>>>>>>> core to dw_pcie_ep_init_complete() API which is effectively called only
>>>>>>>>> after the core initialization.
>>>>
>>>>>>    6) What's going on with the CORE_INIT and LINK_UP notifiers?
>>>>>>       dw_pcie_ep_init_notify() is only called by qcom and tegra.
>>>>>>       dw_pcie_ep_linkup() is only called by dra7xx, qcom, and tegra.
>>>>>>       As far as I can tell, nobody at all registers to handle those
>>>>>>       events except a test.  I think it's pointless to have that code
>>>>>>       if nobody uses it.
>>>>>>
>>>>>
>>>>> I have submitted an actual driver that makes use of these notifiers:
>>>>> https://lore.kernel.org/lkml/20220502060611.58987-9-manivannan.sadhasivam@linaro.org/
>>>>
>>>> Notifiers aren't the best interface in the kernel. I think they are
>>>> best used if there's no real linkage between the sender and receiver.
>>>> For an EPC and EPF that's a fixed interface, so define a proper
>>>> interface.
>>>>
>>>
>>> Fair point! The use of notifiers also suffer from an issue where the notifier
>>> chain in EPC is atomic but the EPF calls some of the functions like
>>> pci_epc_write_header() could potentially sleep.
>>>
>>> I'll try to come up with an interface.
>>>
>>
>> I thought about using a new set of callbacks that define the EPC events and
>> have the EPF drivers populate them during probe time. Like below,
>>
>> ```
>> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
>> index e03c57129ed5..45247802d6f7 100644
>> --- a/include/linux/pci-epf.h
>> +++ b/include/linux/pci-epf.h
>> @@ -74,6 +74,20 @@ struct pci_epf_ops {
>>                                          struct config_group *group);
>>   };
>>
>> +/**
>> + * struct pci_epf_events - Callbacks for capturing the EPC events
>> + * @init_complete: Callback for the EPC initialization complete event
>> + * @link_up: Callback for the EPC link up event
>> + */
>> +struct pci_epc_events {
>> +       void (*init_complete)(struct pci_epf *epf);
>> +       void (*link_up)(struct pci_epf *epf);
>> +};
>> +
>>   /**
>>    * struct pci_epf_driver - represents the PCI EPF driver
>>    * @probe: ops to perform when a new EPF device has been bound to the EPF driver
>> @@ -172,6 +186,7 @@ struct pci_epf {
>>          unsigned int            is_vf;
>>          unsigned long           vfunction_num_map;
>>          struct list_head        pci_vepf;
>> +       struct pci_epc_events   *events;
>>   };
>>
>>   /**
>> ```
>>
>> When each of the event is received by the EPC driver, it will use the EPC API
>> to call the relevant event callback for _each_ EPF. Like below:
>>
>> ```
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index 6ad9b38b63a9..4b0b30b91403 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -724,10 +724,15 @@ EXPORT_SYMBOL_GPL(pci_epc_linkdown);
>>    */
>>   void pci_epc_init_notify(struct pci_epc *epc)
>>   {
>> +       struct pci_epf *epf;
>> +
>>          if (!epc || IS_ERR(epc))
>>                  return;
>>
>> -       blocking_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
>> +       list_for_each_entry(epf, &epc->pci_epf, list) {
>> +               if (epf->events->init_complete)
>> +                       epf->events->init_complete(epf);
>> +       }
>>   }
>>   EXPORT_SYMBOL_GPL(pci_epc_init_notify);
>> ```
>>
>> Does this look good to you? I can spin up an RFC series, but wanted to check the
>> interface design beforehand.
> 
> I am resuming patch reviews, have you posted a follow up ?
> 
> Just to understand where we are with this thread and start reviewing
> from there, I will update patchwork accordingly (you should add
> a Link: to this thread anyway in the new series).

Manivannan posted a new patch set at 
https://patchwork.kernel.org/project/linux-pci/list/?series=666818 to 
address concerns with the notifier mechanism.

I would be sending a follow-up patch for the current patch soon.

Thanks,
Vidya Sagar

> 
> Thanks,
> Lorenzo
> 
>> Thanks,
>> Mani
>>
>>> Thanks,
>>> Mani
>>>
>>>> Rob
>>>
>>> --
>>> மணிவண்ணன் சதாசிவம்
>>
>> --
>> மணிவண்ணன் சதாசிவம்
