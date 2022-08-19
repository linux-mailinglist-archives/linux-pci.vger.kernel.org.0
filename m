Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20C4599789
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 10:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347695AbiHSIhH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 04:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347203AbiHSIgq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 04:36:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A97457239
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 01:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRrG6S+D8B1lD3t2B7mRVPFRrmc+WLT8RlcDZW1VoxRA3QggBs+02meX9EeA8a2WIVoIL5bs9Z92CrlcmUo+cqoL1i6Y2RvrDG9g51WfH77MO1PC4dytHBXYRHb/YP3P4YDqdbhu1D6NvXzOkG8iVA7KcZFEijYPa+UfBBGnoSs1aav2eXLqVc9WVmjUDczVExhbavPD7RoHHvAnpgCEkHfgU2DdmAzpRKutDS9HE+SZmxRsnMuaCOWoepJrOXa+hLZQAP46+xvIVjHMj3ySmf0poHSeEf7DSaPfNvn+18wRBEA0CSZNhYOLUR0MsiUxBjMhDCsKxzsCHkTe5f3xGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaFL2Mj+unXNZUwlHaZeg9ReB5iQJrAkmzI7D5goiJs=;
 b=Zsm6IbPFl2xg961AweRYTX+P+oIwIfwD4H+mL7u7UoD/+Y9NTBsksfLaAnhrLcb/fQq9HmDsO9K+inzW2Fga2qjxHJPO3zIU6xqW1A0vRkRuymoCqU/+XNB82eBcucXXVTD/DJhpZNQ9I6IrtKlRaAwXhh6Bslds8Dz8HY9MEiilO7lU8Ymnn4JxCzQaoY43W8G2hpCYUvyvTQBjYjk/HAsPmxJnQP2IAcBNgFaOiyZV+bMwY+PwH+7ZO5u0ohE0n7UVcFYrHdNzT7Eltcu+yq6SGAjiEI5D0DMQIVN+ZkVVU2fgDA9qanLtbsALY9EBEON/C6ilWoPSweN9zoHpgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaFL2Mj+unXNZUwlHaZeg9ReB5iQJrAkmzI7D5goiJs=;
 b=ArocNPzmgq0SOM7EMNa5+pzhUCQ3sI81cxj7klKTZkFNValEWBHRb28fINfsk36rmddXQRrqkBiL1JAuBgjuN5G9sbM+OL28lYQBLNPuspYT3QgM2zG2bwLg3yPaCE1LKLP5X9gMHvZ3K/jbHq950rXLlPgKk7/FFbdjCo7t8tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB3002.namprd12.prod.outlook.com (2603:10b6:5:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 19 Aug
 2022 08:34:16 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::4195:ca0b:381f:7900]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::4195:ca0b:381f:7900%4]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 08:34:15 +0000
Message-ID: <fc036a10-5c13-fdd7-9d98-2b5f0f8af383@amd.com>
Date:   Fri, 19 Aug 2022 14:03:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xinhui Pan <Xinhui.Pan@amd.com>
Cc:     regressions@lists.linux.dev, David Airlie <airlied@linux.ie>,
        linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Tom Seewald <tseewald@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>, Stefan Roese <sr@denx.de>
References: <20220818203812.GA2381243@bhelgaas>
 <c1a4da18-a6e1-c633-a585-1b4940a5de59@amd.com>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <c1a4da18-a6e1-c633-a585-1b4940a5de59@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::12) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27edcbb0-651b-49a0-709c-08da81bd99b0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3002:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+z6jrJ8VC4xIFHNgh9uz2Pj9/wlh7CJ8xehV7cKJ5sR7CbsuOkDA+3paubg5v+r9mVmceaNQ2TL1QX8DWUlVBBaQc3JDK/jm9/Wq+unqyqTL8ZzlOpuWiwVZAEnOzpRx2UytnD3hbvz20NaJsVkKc6vw9JeuCCIjoZfz0fjp/itAGCHEPpbud7azGXKdWdkmc2NK3BwngYLywJdKcOX03JigaFEncsCRu2Xbz/48uKsL3iJQXAKbeHgTecnIU2FCz2OsHBpARoBGqfeesJK7YkCs8mq6RBxRlKJkJ4LCWPgu7wP0nO8lTPnOMrj3cuqPyPeSmwvfx3efbDugnvqwDFT6wiy0Fs2Qj0JUF1QuJe6AVCW+ABcRPdHT7d0wOWCbunBEFmoW2EWt6sOHnIGnsBdXOsmP1AplBgYkNUEBcLfpLPHrnYvWxk/Pi5BApj3qq3+f3j5iyyUXiu7AkrEx/v2fv3mNZtft6QcDhy2FQryoDkx+Y83jMkpgcE07zVVSjTtmRVbQ6ZQKr9azR47+WdKEKEqgeUWBwFbK/GMNwF1lXsvzeDsFwTyS7DUySWk3Wi+RGJ7jhhGkFh8w1zvc3mBFDfT0kgrUJn1opA6WAgeSivM7sz0WeIYUZcpoW6oSQvllDbOv2/jo0/Y0FDoTMoN03/tD0S4z7pvTSqLqKXnXkiQVHd2WnI/EtJle0vMZUgfOlBQwKF6jCjVieA0iuc5oR2xaHBB9bogpTaPUKMWqwGY/gBFChNBlp1NNSjnxHOy9uK8NQvr/Fw75xB3yX9VJGRJUMk9fw/1LLNbxB8ClKop5Us2gpw/NGjEnIczAqzw1DoGaI0VGUrsXINx3UA1rQcaKeZM5HP2oov+RZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(83380400001)(86362001)(66574015)(2616005)(38100700002)(8936002)(2906002)(31696002)(186003)(4326008)(66556008)(66946007)(8676002)(110136005)(45080400002)(6486002)(966005)(6512007)(41300700001)(478600001)(31686004)(316002)(26005)(6506007)(6666004)(53546011)(54906003)(5660300002)(36756003)(66476007)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTg2cHBJVVBoSGpLWGJCZjl1WVlhNFJQdHBNYSttM05PQWxoK0tSRG5FeWZs?=
 =?utf-8?B?UGRUQWdtNm5KbDVDQjdtb0NNNmFRbERvMGZaUCtpSGtGY3BZZjVlMUVXZWZL?=
 =?utf-8?B?SmpDYzhuazk5NmJzeXY1aUpSV3R2WFBFS1JpbERkQldNWFRQVnZUcnN0TjJk?=
 =?utf-8?B?S0g4dFBocU4zaCtEV2luUkZyenNSWlByZVdnTjFKTTRBWDRJbHNYTXJGdlgx?=
 =?utf-8?B?VXlsdFo1OCtVaFkya3hER0Foc2FNMzV6NnhLanVQTVVxZjlOVTBMYjBvT0Nh?=
 =?utf-8?B?L0E4UlhYdnBLRTlXNzJmQVlKTUtZWjBrRVpyWUtWV09Hd0puQVY5a0FpOEJx?=
 =?utf-8?B?RTZ2M1k2OW5rTXhPQktLUHBJSTEySWpWa0tmZFloWDBCb28xM3BrbkFXOWxo?=
 =?utf-8?B?akRldVRQbFR1RkppdldjZ0F4SjdZakt3Rm02LzJWQU52ZCtFME5ISVRUb1hF?=
 =?utf-8?B?RDRPNWVOb1pCUUdRd3JGdkVJTitINXJiTWFjUjg2UFFIdyswYmxzbXlscUd6?=
 =?utf-8?B?WFNHVUt4VzZpR1o4YXBSMVhDeTc0VVNWQ2RNa0l0dFpGWDhETUdNSSt2VURS?=
 =?utf-8?B?VUhNaUplSjBZMUo4dDk5RFhNR28vUG5kMlVwYk04OENjRnloNzBBd250dlU2?=
 =?utf-8?B?OE9OSm04T1VDQ3JBUW1JV0VDWVQ5WXVtcmFXU254KzRMd0wyR05UZ1dSQzg4?=
 =?utf-8?B?NE5jRmxCYkd2MHZIazh3TzR3NVZvVnlrQUczQ1RIakVqOG9TZGJJbHBrVkV6?=
 =?utf-8?B?VDNvWmd0V1B2SWZVYThsK2MwWXh5MHlqa001dXZsamxoYmpTSmVISzZHZmR4?=
 =?utf-8?B?NC81Q3hwZVRFK1d1NzBZRkpZM0pEclNURXdmL1RYK3k4KzVYMGVWMndmT2Iw?=
 =?utf-8?B?RVFVLzZWdDBmem5vTDVOZEczZ3A3NTlIOXZDZnhtVUR3Q0NqL3lobVM4dG1m?=
 =?utf-8?B?UmFQVEhTdjRaVWNoL0RITEpqamlvMDQ3RC9uT1EvZHJFNFZuTHVyOU9uRjJv?=
 =?utf-8?B?dEVwVVFFRzZ3Y09LMGdKOTMvNm9EbytwYnkrWDRJaHFtd0NvSG5YNmNRdkxx?=
 =?utf-8?B?U1VOeHlyemg0ZzZud1g2VVhtNmJUZFcxOHREaVJVUjZoc1hWU1FTamNWUldL?=
 =?utf-8?B?YTB3REpXZWg3NHVRVUlsMll4Y1NYMVhHL3JRL0drYWlzaE11allINFNvckc1?=
 =?utf-8?B?YThTZ1BWNzNqWElNWW83Z1JYb096TW0wbU5wR3lqU2NoRWphWGh3WnJKaGc0?=
 =?utf-8?B?QmIyNVhLMDNQQ0w2d1ozNTlYSDcySlhKaTVaR3RPMTUyRWVESzBzbno4azNU?=
 =?utf-8?B?V0VWNjBvSzJyWUs4d3hJWUR6QWRhdldWT1dGVUgvdTlmN0FqK3QwbnAvOFRJ?=
 =?utf-8?B?d0dDdXFnWTFtdnBvR3FoMFFkdForVlMzb3pucXVFTHl0VXQwWWUzTFM2SGV1?=
 =?utf-8?B?bHgzbnVUWnFsV25FYmxybzZWSkk5cWJ0cFJuK2I5N25VNUZvZDJjNkQ1Q2FY?=
 =?utf-8?B?LzlRbEE3NGtaM3pjVjNObDl0OFVTaXZKcmwzOTBCSUlzMTgxL1JmOWxQblpQ?=
 =?utf-8?B?Y3RuanRldVhBS1pHeXoyVkZNMXloWTA0NXlOVXZpNjBQUDhJZVM5Yk5MM2dt?=
 =?utf-8?B?MGkzQ3RBcGttTlZ0UVVlZWtMdGNJNFlFd1F0dzBRTDRTZlhwNUdseGp2NURT?=
 =?utf-8?B?Z1lDYUFudDhFYVZJQnRIYVoxV2t2RW5LMXdSQlFmN1FyNmgydVI2aXFsSVVq?=
 =?utf-8?B?Sy96by9Lc1BhbmF6ZHF2bGpKb2ZPbGtrOGJjYm1IbWptWHVLb0Q5QnR2TDBY?=
 =?utf-8?B?aVE3Yzh2WC9TL3pYVjBldnVPNVZLNlFmRGk5alE2MHJOM2pNalM3SDVoQUZL?=
 =?utf-8?B?Q0xOUjRDWkErRGNjZTdkbGhCY2NOMWV4OUVrN0NaUS9MWUlGcTRGcGpZWlpU?=
 =?utf-8?B?ZTJJMjh2akZQTUtibm1nTkc0b2d3ZUNsMEczMFJXVVd6MTlNVW83SFBPTEQ1?=
 =?utf-8?B?R2VVZDdlR3hjVEVOT1QxQ2N5TStvUy80aklkcGtxSmhCa2swZmV0VVBxTXJn?=
 =?utf-8?B?a0tOZEtiekZJYWJoWGxoUTBRYmJuNmNBbGNmRXBjV1ExMnFRc1UwK1g2UzJN?=
 =?utf-8?Q?xGwhrgjnUs/FIhjge3lohLdlT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27edcbb0-651b-49a0-709c-08da81bd99b0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 08:34:15.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrGtEiZhtBT1AnQ+vlBJip+A3vqL5mR/pSyDrxTvDqdmhub1IfihwY1jsbgWEW8Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/19/2022 12:35 PM, Christian König wrote:
> Hi Bjorn,
> 
> Am 18.08.22 um 22:38 schrieb Bjorn Helgaas:
>> [Adding amdgpu folks]
>>
>> On Wed, Aug 17, 2022 at 11:45:15PM +0000, bugzilla-daemon@kernel.org 
>> wrote:
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216373&amp;data=05%7C01%7Clijo.lazar%40amd.com%7C59322ae65b814f132a7e08da81b14a95%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637964895716218989%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=tSdOYv7x%2BO6Rm01OFSDV0j3gevlhTF9lOq9pY2AixRM%3D&amp;reserved=0 
>>>
>>>
>>>              Bug ID: 216373
>>>             Summary: Uncorrected errors reported for AMD GPU
>>>      Kernel Version: v6.0-rc1
>>>          Regression: No
>>> ...
>> I marked this as a regression in bugzilla.
>>
>>> Hardware:
>>> CPU: Intel i7-12700K (Alder Lake)
>>> GPU: AMD RX 6700 XT [1002:73df]
>>> Motherboard: ASUS Prime Z690-A
>>>
>>> Problem:
>>> After upgrading to v6.0-rc1 the kernel is now reporting uncorrected 
>>> PCI errors
>>> for my GPU.
>> Thank you very much for the report and for taking the trouble to
>> bisect it and test Kai-Heng's patch!
>>
>> I suspect that booting with "pci=noaer" should be a temporary
>> workaround for this issue.  If it, can you add that to the bugzilla
>> for anybody else who trips over this?
>>
>>> I have bisected this issue to: 
>>> [8795e182b02dc87e343c79e73af6b8b7f9c5e635]
>>> PCI/portdrv: Don't disable AER reporting in get_port_device_capability()
>>> Reverting that commit causes the errors to cease.
>> I suspect the errors still occur, but we just don't notice and log
>> them.
>>
>>> I have also tried Kai-Heng Feng's patch[1] which seems to resolve a 
>>> similar
>>> problem, but it did not fix my issue.
>>>
>>> [1]
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F20220706123244.18056-1-kai.heng.feng%40canonical.com%2F&amp;data=05%7C01%7Clijo.lazar%40amd.com%7C59322ae65b814f132a7e08da81b14a95%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637964895716218989%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=7U52%2BsKIHHn1%2B%2F40dbPS38IGBrBYgBxCXAoFKcrTVGU%3D&amp;reserved=0 
>>>
>>>
>>> dmesg snippet:
>>>
>>> pcieport 0000:00:01.0: AER: Multiple Uncorrected (Non-Fatal) error 
>>> received:
>>> 0000:03:00.0
>>> amdgpu 0000:03:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal),
>>> type=Transaction Layer, (Requester ID)
>>> amdgpu 0000:03:00.0:   device [1002:73df] error 
>>> status/mask=00100000/00000000
>>> amdgpu 0000:03:00.0:    [20] UnsupReq               (First)
>>> amdgpu 0000:03:00.0: AER:   TLP Header: 40000001 0000000f 95e7f000 
>>> 00000000
>> I think the TLP header decodes to:
>>
>>    0x40000001 = 0100 0000 ... 0000 0001 binary
>>    0x0000000f = 0000 0000 ... 0000 1111 binary
>>
>>    Fmt           010b                 3 DW header with data
>>    Type          0000b  010 0 0000    MWr Memory Write Request
>>    Length        00 0000 0001b        1 DW
>>    Requester ID  0x0000               00:00.0
>>    Tag           0x00
>>    Last DW BE    0000b                must be zero for 1 DW write
>>    First DW BE   1111b                all 4 bytes in DW enabled
>>    Address       0x95e7f000
>>    Data          0x00000000
>>
>> So I think this is a 32-bit write of zero to PCI bus address
>> 0x95e7f000.
>>
>> Your dmesg log says:
>>
>>    pci 0000:02:00.0: PCI bridge to [bus 03]
>>    pci 0000:02:00.0:   bridge window [mem 0x95e00000-0x95ffffff]
>>    pci 0000:03:00.0: reg 0x24: [mem 0x95e00000-0x95efffff]
>>    [drm] register mmio base: 0x95E00000
>>
>> So this looks like a write to the device's BAR 5.  I don't see a PCI
>> reason why this should fail.  Maybe there's some amdgpu reason?
> 
> Well I have seen a couple of boards where stuff like that happened, but 
> from my experience this always has some hardware problem as background.
> 
>  From my understanding what essentially happens is that a write doesn't 
> make it to the device (e.g. transmission errors can't be corrected).
> 
> It's quite likely that the write is then either dropped and doesn't 
> matter that much (just clearing the framebuffer for example) or repeated 
> and because of this everything still seems to work fine.
> 
> Either way I suggest to try this with some other hartdware 
> configuration. E.g. put the GPU in another system and see if it still 
> gives the same issues or put another GPU into this system.
> 

Or, it could be amdgpu or some other software component -

register mmio base: 0x95E00000
Address       0x95e7f000

0x95e7f000 indicates access from CPU to a register offset 0x7FE000. This 
doesn't look like a valid register offset for this chip (device 
[1002:73df]). Any other clues in dmesg?

Thanks,
Lijo


> Regards,
> Christian.
> 
> 
>>
>> Bjorn
> 
