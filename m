Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDA55A0A5A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 09:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbiHYHeO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 03:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbiHYHeN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 03:34:13 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E9EA345E
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 00:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4bX2O/3zFw4TfiwJzgshKu6qlVRR6q8OO4TAWqDLdfvGl42Gr0XoJQzEJyFtkCl2NYfL8V4ietpi6A+OhuI50wI9lcRERWRTX5m7xg0pMwMNdMfDjxDEVe1WDybHlcg77dFIxcRK6YM6MdF8rw7k39/oGrF9AV/RjC8WcH3s+HmWiFy9jlfba39APpXKVUaY63t7IeDfYWZPZ49On8qxEccWOCykqg8Ff3LCvrkqduqhMMRn6fmtU0nRvYkEjTcziPgPAeex9IQaPNOwns5eUdVI92uZOzBZ5oIodAj7BQadx6GhZE/knAQAmIm8uWl63bT3zjkorSwi5fLwl/UUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4ooapA1bauaCye1LW+igpbo+UEja2iSmtOHVE4HNYQ=;
 b=ju9o6+dzAhXkWSyAvIgeKxwY+qIc54QgWas+vFOH4DwVsvLcMF1gNkD+aRtmPqcdbO7/g17cDgmvaYLMbFGhRFpBPoskBvHsHTF78IEkcVgDh0qUox8r0M7exlx2+K69IJcK/QthRPf4ECXpdvMyo/7E4eY3qQ1WU6DPEH6jbSPp8fpCjKC9xvQrg/sfNumai4YkiIc8flAX1XzvP29W0w45j5meXudBqVm2qAqe2jooHBC/CYP9067SqdNYCftOFu3mYPWBvx2fP8rHJW8IHLaS+ASeI64k2frf2iHzG9K3UC4tBzSDjNV8DfoZJwgTDR53hI9mdkGAmPl72Q6X5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4ooapA1bauaCye1LW+igpbo+UEja2iSmtOHVE4HNYQ=;
 b=AZEDRdtAvncRZVS1uT6x8FkijOptphQ7DvF9LSmWCVOYxZq4bZCdDt2MOW9KEhba0UectDOtha3jO1L+hB/SSnbowDwqIaWNvFWmJeb6ALU2ispSYmsl02SCqv8oZbLIoHgO6job/VGdlhDBbbK/8x8jbIrhQaawv980AfiiSb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN1PR12MB2543.namprd12.prod.outlook.com (2603:10b6:802:2a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 07:34:07 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94%7]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 07:34:07 +0000
Message-ID: <43df753f-faf7-f6be-4adb-e9c3ef615abc@amd.com>
Date:   Thu, 25 Aug 2022 09:34:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
Content-Language: en-US
To:     Stefan Roese <sr@denx.de>, Tom Seewald <tseewald@gmail.com>,
        "Lazar, Lijo" <lijo.lazar@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, regressions@lists.linux.dev,
        David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
        Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20220819190725.GA2499154@bhelgaas>
 <6aad506b-5324-649e-9700-7ceaaf7ef94b@amd.com>
 <CAARYdbhVwD1m1rAzbR=K60O=_A3wFsb1ya=zRV_bmF8s3Kb02A@mail.gmail.com>
 <30671d88-85a1-0cdf-03db-3a77d6ef96e9@amd.com>
 <CAARYdbhdR0v=V82WnQOGBNrcth8z6F_61SxG9OTzgNpgg3xx7A@mail.gmail.com>
 <68f140f8-1877-6077-0992-e435fb9a94e7@denx.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <68f140f8-1877-6077-0992-e435fb9a94e7@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0601CA0033.eurprd06.prod.outlook.com
 (2603:10a6:203:68::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51ef6641-7c10-4517-330e-08da866c315b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2543:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qzkLVIyXhjf4uNoyOuVFlkUguk3xBLirhPf+vl3wg4vmGratJ6WJV+Q17PaAauuRcbYtVC2iWbCnoMSJW4z69ws5/ZGwyJlg5jlWIaoTFWLgRqhYwDu9hnY5zi77ulqsuSn3Yb9erB8bZ005STicTq7mINfXqo4hlWhqk9N5uLfZ61o9eVpFcqPCEj/PcB3ssdBiKtgGMpubXzYIkrXO1w6PoD+yHTSH0un1egtmEjaUBVpVbulyPoAgxSExjqvsAPNLPepk5wP6gdTks3NtG0KVnQ7UHqEWjQMWDb0ID3+RhiRiYNuTe6M7P8GPhBi4Ef73Pw1sLjXe9FEOqmEf5BBidDPauYFJc1kLizMllfP2CuHqHdKZ9oYcB+aH+gvpfGXcquMY6/JfTmNhygH7oYX90yyp/o+cQiVJU+pmN2QzIghOc5ti58VwQGxWnpiMRf6oTVlqjIHf8SqAWek/zTWIT78fnKw2LdHv03cofYRoQZ7dfLuOdj/B9g5ml9uZKyrfY84ss+aCTN7oPcj4PAGHxfX+iZbL8MKvzOG7ufQZ5N0RHyM3KqV48wGgM+V+8wrvOGDfymkzrIeeJLurfmfdbLVDrXccb0s5R29eWO8NFxb3+2Ntzu+rqHgyPnqRHxugTqb445AalC7P9cObpg5qmGea3U1p85fd+gl9AKgeVHmKdFzpMpW11JV2I5MpqNYKRxG/orJEJEYTqsfXargokaoaM/nBq6mLF/OQ3wD6LCULBTApLRViBUYTA1NwHTJ82qfHzJjsflZ1KVS7yOhhtxXCmegMG9g8p18r+VtRFAAXqkJdQlT/yZZ0gViEbESZlNVvBXIIqzUoUhmyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(53546011)(110136005)(26005)(45080400002)(478600001)(2616005)(186003)(966005)(41300700001)(83380400001)(36756003)(6486002)(6666004)(6512007)(6506007)(86362001)(2906002)(31686004)(8936002)(38100700002)(316002)(31696002)(66946007)(4326008)(8676002)(6636002)(54906003)(66556008)(5660300002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUprTEgwVFMrRWFrWnhONlIrZ0Q5WVF2ZTBidlBJOXZwbjcvSENPcWZNL01Z?=
 =?utf-8?B?RW4zSDFyMk5QUDR0UDlrV24zSko3QngzWGpKQjBOSk42MUhtU1NTb004QTM5?=
 =?utf-8?B?bnZsWEtDN0F3NlJZbTdyM0lHaXZxVmprTjZVZTFJYkw5b2grMklTYTA0K29x?=
 =?utf-8?B?TVRyQU85SmNPdUxacldKVE8wVHFPTnZqNjZzZkFjN0syN1JlZ0FITVFMSXVB?=
 =?utf-8?B?bVZkVytZNGxQRkFlUDRROW5uUkR6bi9ZK3RNVEVlTmQwWjhuQlY2ZTRTRHU5?=
 =?utf-8?B?MFFscnU4TzhncStDdTYyQVRZclhYa1hYNml1cXplbmkzalFTbEFmc1RSZ3dj?=
 =?utf-8?B?Ly9UYkt5aTMzeSt6Z1JZVWUwRTEzcXlrNGV5alpqMDRXT3ZvUFMwM1E0MEFo?=
 =?utf-8?B?bXpVandVQjJQREJlSC8vL3hyem5BbGVITHJHcmtUL2diVURNcGFmT2ovbHg5?=
 =?utf-8?B?TG11RDJmYng2b0phMno1SWJCLzI1TUhjWEc0bnYxSm5FSklMQWpob1h2THJr?=
 =?utf-8?B?NGMvNk5pREJaYzk1ZEc1ajZnSGp3YkJoWVc4UnI5Ni82Q280TkNzc0ZCaXY3?=
 =?utf-8?B?Ny8zWlVQOWNodFBzUlNtT0dkQ2FROGxzOFBlZkJNVkR3ZzU2UkJxWU1iMnF4?=
 =?utf-8?B?aEMySnE0U0RKaVozems1bERIbkdSdXVWRWVwdjBRd0p3L3A3TTliMUw4dmhB?=
 =?utf-8?B?a3dXNTFRajErTFpDYTdqYVR4d1BIUHAvQnpjRHFHRjlzVjM1c3U5d2FrMGlz?=
 =?utf-8?B?dHpjWnQ4eldIU2lSSDRiZGVsZEZRWkxWNjJKa3o1WjQ2dUJ0ZWFSMXp5Sysv?=
 =?utf-8?B?RDhCbzgzRDgybGwyTW14cmxqQUo0S3R5cm9vdGR1b1p0YnorVXg3bjZSZ3Zr?=
 =?utf-8?B?b052dnIycDBiaHkzbjNYSFpHRGlTSXNJaExMM0tDOWRqRVIrOUNwNzg0QlJU?=
 =?utf-8?B?R1k3TlVlV1JKc1RZVDdHWVpjQ3h0UmdKMXBvdWttWkV5OHdoT3hnUFBKNUgy?=
 =?utf-8?B?MlpiMGpld0RwQW1ZZWZLTFNSQ3ZkcFoxeUhQeUNCcUQzbUtCdlZralBGRGg1?=
 =?utf-8?B?RjhrSFpwWGtRVXd2RmZUWm1qcWdnclVwaFJrcEpzM0YrWGZLbVhaVEFSVmxJ?=
 =?utf-8?B?bXZGelQvbU40L2xXWlN1L2hEcDBaaEZsc0xTRHhTbE5SQmNJQ1JTRjU3ZWpp?=
 =?utf-8?B?dFg4NUw4UVd0cWQ3QWpRYlJqTFBQc1BkZGFHVktFRk14NlF1b1FzUVU1cFRS?=
 =?utf-8?B?L0p3LzY2QXNhbnBRRCtVWDViNHlqNkZpbUdKa1poVzA3MjZtUHBWRDBFN1J3?=
 =?utf-8?B?ZWsvZi9OZHRmMmJrQk5jbUNvWFlhYXhPVXYzNVhwRWlBODU3ejduRld1WkZT?=
 =?utf-8?B?SElWc2d6SWFRZE9rVmtlYS9vMTk0L3BJU2QycFR0a0o4YkdCNkowUXFkQVpp?=
 =?utf-8?B?U3ozSEV5VlNwQ1lDdnpmaTA1eGh4UEpEREdrRTBKU3AxMFE4S3VCWGdnWlk2?=
 =?utf-8?B?aG13eGR5Z3Fwa3BKRmJQeDJOMWFjM01DWk1hK2swU1h2K2FiR2YrcUtaU21w?=
 =?utf-8?B?K1FpYStzYmhFeERPK0NWL0xtWmQ4TGlBUmlxLzhpelgrUUlKN1Npa0RrT0gr?=
 =?utf-8?B?OFRVajJCYzFOeS9JbWhHVVVQcGcySmFvUDE5dFFsMUtzcFRFcEkxWEhOTlFT?=
 =?utf-8?B?ZGpMdklZTG1RRHJUaGwxN1pVYklZMXY0cG9pQmJlbmNhenBVZGZYSkRrd3Zr?=
 =?utf-8?B?R2hhYzFXSXQ4bFVJbmhOVE5MdEhDak5JYTROdVBXczI4dnZtMWtCWGtqMXBT?=
 =?utf-8?B?VlBoUTcyb05yd1FXWnJIdlozK1Y4a0xOckM3TFdBQWZ6UFYvcTdkaEpvZXVB?=
 =?utf-8?B?Zyt2eHM1Y2hwZTdEQXBCV3MrK1F0VkkrK0oxZWJDdm1HTGNDZld3akhSSlha?=
 =?utf-8?B?cmJuZUhFZXNpVE94TTRSR0FweWs1YzlsRWJVeXZCWWdlUUdvdjB3WlNMRWhq?=
 =?utf-8?B?T2toUVcxaDBicnZCSWhXZ1hOcFpkKzYreXNiczE0QWUyTll4RnBuWGN0K3dt?=
 =?utf-8?B?V1J4UWVvRys2SW9pdGRGNVltZTFFUXFFSXB3akNGdTdkQk5sdENaNnI5L3dP?=
 =?utf-8?Q?tFNELgoqiM8f9TF88x4nSLMot?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ef6641-7c10-4517-330e-08da866c315b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 07:34:07.1809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsGVkjYeAu8TI8llpKq5TW92Lib2ceqKuzIpctxi5OrXKC6g/a5u5YFkqh2HeYVB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2543
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 25.08.22 um 08:40 schrieb Stefan Roese:
> On 24.08.22 16:45, Tom Seewald wrote:
>> On Wed, Aug 24, 2022 at 12:11 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>> Unfortunately, I don't have any NV platforms to test. Attached is an
>>> 'untested-patch' based on your trace logs.
>>>
>>> Thanks,
>>> Lijo
>>
>> Thank you for the patch. It applied cleanly to v6.0-rc2 and after
>> booting that kernel I no longer see any messages about PCI errors. I
>> have uploaded a dmesg log to the bug report:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fattachment.cgi%3Fid%3D301642&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cd55a659245b24864bd2d08da8664ae2d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637970065087671063%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000%7C%7C%7C&amp;sdata=vbhJ9OB0jIYr%2FRkDIbQHhRRqhyklnnHOT9Xi8z17MYY%3D&amp;reserved=0 
>>
>
> I did not follow this thread in depth, but FWICT the bug is solved now
> with this patch. So is it correct, that the now fully enabled AER
> support in the PCI subsystem in v6.0 helped detecting a bug in the AMD
> GPU driver?

It looks like it, but I'm not 100% sure about the rational behind it.

Lijo can you explain more on this?

Thanks,
Christian.

>
> Thanks,
> Stefan

