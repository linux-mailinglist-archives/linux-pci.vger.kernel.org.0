Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D82554CD61
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 17:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbiFOPth (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 11:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiFOPth (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 11:49:37 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67DB15FD1
        for <linux-pci@vger.kernel.org>; Wed, 15 Jun 2022 08:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBraDpLViFvAc/j5lMq4N8p5J0NsCYQ5t+kHngvUEWKtR28XLrPJGENLsiEcBn/DcuhQD1/gwd9Xw1r/4ysUQuRX2qo3K5oZ9qQoSDOZxtXXI+MaN7EjPICKg6nosPfucewLa8HpWYDqCzDr0ngv0uSAyuhKv7CqKAy4kt+3/J8KByxLDJQU+wUV+lyNCFoXxaRxCoOc90+1DDyx6WvdoY6sbI+hUah/B75x7KHO0sgCkkZprkFa0YWWA/3A22+YNvD3GKa2Fpl5SHPcglPgq+CAOCE4uhQZ5dpY4p2VaBuTv0AwMO536GCccAx/zjocoLUQXF8+RemsWzI4fm5Akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn76CCBPTvGXCuCszyodE9omSjkTpfLTXsBkCncpp2I=;
 b=BRZckVqnBYozTa0iuGy33e2HgzBIrgqZ2p6DoyeqoH/rtRe3zpVfmtzfCfnn2Xfqfx8BL1sMtF2acbqiw8vZonox6h+oFOy2jKMp05I//77hEDKN3onwaQBRRZni2Jb3Jrhe8Hb+3njswfYFJ7ZXWeqy7vcQH3G1x0W78gRYpBUBw65xoh5cGblobMqq/sFpniK8liOdBDODpDWYaoaTfl85fu7/vwR7br0X3jXzV6vZj1vJa+NTtbk+FgIDrd7XdgSIG9vIsVXIQDb+9TKojETT8Yv6powaUmOo4zIT2sMKC7rRE1zc6TXyZz9CF9cx2vWd/Ph9v/R2NaJvmMf9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn76CCBPTvGXCuCszyodE9omSjkTpfLTXsBkCncpp2I=;
 b=n26zXwk9uoWMDwGwwFC/QpHkQuP/tL4nPSFV+94xzsjjA7xb0t7E6vfK0+atXPZjc+cnXUS6vDUI/A3uQn/h9mEsVTm9D4lI/euMnc1gRIEWHHNYxUCnb43nHFgWkNeABuZSYIc//yOe5v/Pebj+251Z89C+8wqqMWzLRF453Nw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 15:49:33 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 15:49:33 +0000
Message-ID: <46fe8c3d-d3a7-a7e0-cb8d-e7b4f18ad0c0@amd.com>
Date:   Wed, 15 Jun 2022 11:49:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "Kumar1, Rahul" <Rahul.Kumar1@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
References: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
 <20220210062308.GB929@wunner.de>
 <f3645499-f9ce-4625-60c7-a4a75384870f@amd.com>
 <952f49bc-81f9-68d3-89a7-b89ea173f6df@amd.com>
 <830edffd-edb9-e07a-a87d-21a6f52577e3@amd.com>
 <e38acd32-48f0-8872-8637-856ac0033ce2@linux.intel.com>
 <0754f511-fba7-7ee4-22ac-8457ba71c889@amd.com>
 <65242da6-9917-4307-90fe-4bb4d35c2f1c@linux.intel.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <65242da6-9917-4307-90fe-4bb4d35c2f1c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::18) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da1ccb1a-0a49-451e-0519-08da4ee6a47c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4189:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41897F21805602D876ACB162EAAD9@MN2PR12MB4189.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4stieAEmDXTu4zMT6I/6UmPITsspWqtvw/B/zylx0hgMaVLs1rMs2Kneg02hKESjNoEvRNAGmzi6EHi4I9aq99J19lkTofN8ZqXHzCzNjm4bnwFBMvhrQnIvrz4FTN1CZn7JRzHkkJzHvPsDdGLfLHOFyI1tycR3rRb4g4Tt4bTPFeKHzxCdCXxyOCnTDumLgowKeMR6SJU0Ht60nk0F4xEx1e4+R7PkAWQF5rO3VfcEPsMGf/VO3Gc2reF5O3CGZzmgpX/Axg1emaOS1nNghj/DhomsrPZy+TFSVOHdV1WYaxxoJ/qow61KDdsa8iWRMMMw11FV/grh8se/LUGmjED0oA4tES4p+Yyf6HA8PA/Un9Pfoc9wL87RCZOjLfV3ELOf5q7TVt9g4F/ra9QPvi3lKwly80Hzz6V96n7FL1QHh+oNfUw7/eDC7iSpncDzPAYJcOJoZn9wSWOuQ22y+xqViOwYA986yaSkAD/QAzHzy9c/mQXcl62P37L02lz+07iVZXCDM3KBvwuoaCwT4ApnMyuIDKBNrfqRg1Wb13+lOH29uaGga4/3mdRCvU1SJBXOJzlRJ9pmhkNwjxGcwqEVlvxo8Hn+mweBIsixw+HgnlH9MK2koopopqlNbl6bVJZtgyrFqcz91azQky8m2WkflDNZjkmaidsSnOkbf+h32TANrRMQNqiHlH4q7+FDZu3VesyCdRRT9oTLsz3c4/njTIvJm1WwEm63a3er2a5qWdzZmHTEblRpMxfilwDxAOG0Qj6NnBfwQYdly0TfvU/qg29B99mHu5C0Cmgi5A7SM98cj0xFKUUMjkyzcGkKFj098DObYGFqEjj0G9qyKaBLTuOG668oQP5ZKyRac0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(2906002)(66476007)(66556008)(508600001)(2616005)(66946007)(36756003)(4326008)(8676002)(31686004)(186003)(110136005)(54906003)(83380400001)(316002)(6512007)(31696002)(53546011)(38100700002)(966005)(44832011)(6486002)(8936002)(5660300002)(86362001)(6506007)(45080400002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmRJbmxxbWRtMVNpWVphT1Z3N0EyMXRhLzBpOEVYaEVSTTF1ZG84eWRGelQr?=
 =?utf-8?B?ZHlWUkFOL0xiQlVoaWlvZHBnZE5TWExSZ3lhL3VJSmxkUW1YOUFoeFE0MXEx?=
 =?utf-8?B?MFF1K0c3aG5TQXd5eTBQQ2QyRit4SUQzdDAvc0xPU3Nvd1ZnRWlHZGhwU3dw?=
 =?utf-8?B?NkRENGFFWDdhRFhzSXhJa1NuWG9wWTE0amM4dGxVUzhidnYxekh0RllaYld2?=
 =?utf-8?B?VHF3cDZWRGttdHdBMWdoYnloS1prMlplVldibTlyVXRTc1dHRXBSNmV4a1Bk?=
 =?utf-8?B?dmZkc1NDbWZkTklkTXRGdWdSTTlyY3FtZFVBSUd1Y2lxN3JIcTZNcXlkTnQr?=
 =?utf-8?B?Uy9RSm5YQS9XSnlUV1cydVNSaVR1am43YmE5aW5xa0tHOTZDYzVNTnhDQklT?=
 =?utf-8?B?OG5TYTVBWU8rRzFlcGw4UjRWNW8yR2pBTXpnc1JtVmM1emIySmY5aVhrRDBS?=
 =?utf-8?B?dFcwY3lvUW9rNkpITlZ4YjdLaGxlQUZadjdxU2N4Vzd1ckRiTWR1Y1l0S09r?=
 =?utf-8?B?WjY1Uk9CVjB0Q1kxbloraWw0ekNRY1dMWjBYaGtuOFpKTS9GRUJoeXJDNW5z?=
 =?utf-8?B?dUVNdjBhRjM5YXFRL3hjdnMyZ3pRem1CUEszRmg1SkdxVjdFSXU0MzB0R1hV?=
 =?utf-8?B?NUtrN3UyT1R1K0t3TlVkUE8wbTQ3MjdLazBlbTJiVERWL0w2VjRqeFlMSmg0?=
 =?utf-8?B?aCtTYjZHNHVSb25EU2FyN0R0dEx3UjZMM1pybzliZGwzSG5TUWhsWUJNVW11?=
 =?utf-8?B?QTZlbmxSdUV5SUVWdXVkbGFqR2c5OFJUSUhpaE1jeW1FajBLSkdzUmp5UjYz?=
 =?utf-8?B?MHlpaDFNVWlxcWlveUdvN3BvblEybWZTNmlITUliQzZuRnhsbHQ2SHdHK1NI?=
 =?utf-8?B?ZVAwZ1kyVm5PU01PTFlqZ2lKbEdBZU9tTXpuQUNkU3JFeTVpUytXN0JGTnh1?=
 =?utf-8?B?Z2ZUWXRyV2s5QllRa3graFdEU21Qb21aNjNERmpVMS9mTys3Wk5IU0VnVXhQ?=
 =?utf-8?B?SnRKbTJud2pXUGx4QkF6RVpQTU1QVjNGSnB1bzlsRm5xdVlVZW5NQ1hDRTlX?=
 =?utf-8?B?akkrRm8xSE5oTFZmaCtOa2kzNldNMEozdDYwWHNhV20wdUZuQzRjMTFiOFR1?=
 =?utf-8?B?US9WY2FYY0xNZjBTUGpBVWtpNm5adWVFWFNjTkRxWXlUWTFOczFJZmR1ZDFC?=
 =?utf-8?B?ZGI0amttR3d2OHpKUWxoNVB6dFl1NTQxU3JkelY5ZTNIbUVjdTRtSWhxTXhL?=
 =?utf-8?B?aXpHS0xpTlZCY3lKK1Z0bkRzWWpDUG9PVkg0Ny84QU5GdUxZZ1huSHJuTEd5?=
 =?utf-8?B?MzVwR3hrdFNCVDBHV0NJUlJVVGtuc1FtVC92cUFlNjhkazZ1UXY0dHVpODQ0?=
 =?utf-8?B?VTZNYjBNSU1MWDMvWUxIbGJiYUxWMGJ1T29yZ0tHVkVicU8zS2llT3JKYnRp?=
 =?utf-8?B?cEpFV3Q1aXRVT2E1VjNXWFFNT05lOEpNMGM2VnZqck5Mb2dDaHFrMUtJdlBP?=
 =?utf-8?B?bjdnSVVwS01BL3dEWGM0amdGZG5JdGJOd1lIQ0tid3JxbnFRVXp0TjM2QW1p?=
 =?utf-8?B?U0JTbG1WU05RY1BRbGRSZWg1c1grSmhialRqMDFueU9oQWI1T0N2cHllRzBZ?=
 =?utf-8?B?ZlR5TUIvTnhNUU82NkIzdjd6dVVDSVozd090eWNCc0R0ZUxuczhiRlk0Wm4r?=
 =?utf-8?B?WFhDRW5UZHIzc3RDdE16YjlFTTJsV1MzRnhaWG56V3RSdEtQc2lqSmZFd0xp?=
 =?utf-8?B?UFMvSTZQWllOZ0JCUDM3SFZTU0Faa0FpYlJ0d2FJUnRJc1dxQ3c0R1FmSTJV?=
 =?utf-8?B?VjFRMlk4WnorL2ZsTXp6eWN6dmJYRjBpN2hTeGNKelRaUlVzZzNPQlNvaVo2?=
 =?utf-8?B?Vkl5TGJYME83bTh3NU1HTTVJNXAvRU5ubVY5R1N4WHBoUGY1TWRHOXVObTd6?=
 =?utf-8?B?MmFRanVzcFRJdFhKZTlLSUdpNys4Y0p4WEdmS3B5QkI5dTVLeHZIa21Jb3ow?=
 =?utf-8?B?VFhFazQvRFFxT3FGbHJneHVJU0doSzJxTnE0M2w2RzFpbHpKNVNZNTNCS281?=
 =?utf-8?B?UHN0SWphNWg5Z3AwMWZVTHdWM0Z6SFo4Q3lHYXhYNkRNUDRMMUt3NWkvMUNr?=
 =?utf-8?B?c0VLS01ZbkZkaWs4eWJ1ZkhnaGRBR29FYXVhSFJXb2w4R1pHYlNEb2pDUlBv?=
 =?utf-8?B?KzBKbFozTThPWXJQdjFJQmJ3V2diYkppeStEd3g5dk9HYkNGTHdJN0IvelZx?=
 =?utf-8?B?KzNaRW91SGUzREtCZUJOYVNZWDkxTkxRWG9VT1g0Q09XUy9MNWE3YXF6ZkFn?=
 =?utf-8?B?azh6MXJaNjdyTEV1N3h5cE1hYzFkZlEyYzdBeWlCMzZNMUlJSExrcVpsd3h6?=
 =?utf-8?Q?HYe+SO/gReHOoxmqr4gktTi/ulnu1D2U5+w2bOhhqS27U?=
X-MS-Exchange-AntiSpam-MessageData-1: 25cDnveE3J5orQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1ccb1a-0a49-451e-0519-08da4ee6a47c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 15:49:33.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCHMrWq6z1LVPi2E8qx0VT422hqdprRcPBMPMN8TmsWTFCvY3Xc+TCo/6yho4x6UC0NJM668N4Hbnm+LC5pP6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-06-15 11:14, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 6/14/22 1:35 PM, Andrey Grodzovsky wrote:
>>
>>
>> On 2022-06-14 14:22, Sathyanarayanan Kuppuswamy wrote:
>>> Hi,
>>>
>>> On 6/14/22 11:07 AM, Andrey Grodzovsky wrote:
>>>> Just a gentle ping, also - I updated the ticket https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215590&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C407a04694abb44cad1a908da4ee1c371%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637909028798586221%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=yJ3FgPSbH52kEMmoMjcgmU0apo9LZYtWwe%2B%2Bn%2F4J30U%3D&amp;reserved=0
>>>>
>>>> with the workaround we did if this could help you to advise us
>>>> what would be a generic solution for this ?
>>>>
>>>> Andrey
>>> Can you explain your WA? It seems to be unrelated to deadlock issue
>>> discussed in this thread. Are they related?
>>
>> So from start - originally we have an extension PCI board which is hot plug-able into our system board. On top of this extension board we have
>> AMD dGPU card. Originally we observed hang on resume from sleep (S3) in
>> AER enabled system because of race between AER and pciehp on S3 resume and so this
>> was resolved by the patch https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas%40wunner.de%2FT%2F&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C407a04694abb44cad1a908da4ee1c371%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637909028798586221%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=JCzeDmJmByiqDeAZGYJUjgOW2VIAMybHZgg%2B0YzYd%2Fg%3D&amp;reserved=0
>>
> 
> There is patch to disable AER in suspend/resume path (from Kai-Heng Feng). Did
> you check with this patch?

Yes, this patcheset[1] had no impact on the problem and we only included
the AB-BA Deadlock patch in our code by Lukas since it resolved the SW
deadlock for us.

[1] - 
https://patchwork.kernel.org/project/linux-pci/patch/20220126071853.1940111-1-kai.heng.feng@canonical.com/


> 
>> Now after this we are facing a second issue where after resume and after
>> AER driver recovery completed for pcieport the system won't detect a new
>> hotplug of the extention board into the system board. Anatoli looked
> 
> What about the hotplug events during this sequence? Did you get the
> LINK DOWN/UP or Presence change events?

I think we do get them - both in first time hot plug (step 2)
bellow and in post S3 resume hot plug (step 5 bellow). It's just
that it seems we get timeout for pcie_wait_for_link in step 5)

Step 2) logs
Feb 10 23:36:59 amd-BILBY kernel: [   28.729523] pcieport 0000:00:01.1: 
pciehp: Slot(0): Card present
Feb 10 23:36:59 amd-BILBY kernel: [   28.735552] pcieport 0000:00:01.1: 
pciehp: Slot(0): Link Up

Step 5) logs
Feb 10 23:41:47 amd-BILBY kernel: [  302.759503] pcieport 0000:00:01.1: 
pciehp: Slot(0): Card present
Feb 10 23:41:49 amd-BILBY kernel: [  304.795473] pcieport 0000:00:01.1: 
Data Link Layer Link Active not set in 1000 msec
Feb 10 23:41:49 amd-BILBY kernel: [  304.803146] pcieport 0000:00:01.1: 
pciehp: Failed to check link status





But maybe you meant something else and if so maybe you can
tell me what exactly you want me to look at ?


Andrey

> 
>> into it and found the workaround that I attached that made it work by
>> resetting secondary bus and updating link speed on the upstream bridge
>> after AER recovery complete (post S3 resume).  But this is just a
> 
> 
>> workaround and not a generic solution so we would like to get an advise for a generic fix for this problem.
>>
>> To reiterate the full scenario is like this
>>
>> 1) Boot system
>>
>> 2) Extension board is first time hotplugged and dGPU is added to PCI topology
>>
>> 3) System suspend S3
>>
>> 4)  WE have costum BIOS which 'shuts off' the extension board during sleep so on resume the system discovers that the extension board (and dGPU) are gone and hot removes it from PCI topology. Together with this hot remove AER errors are generated and handled.
>>
>> 5)We again try to hot plug though a script we have but the system won't
>> detect the new hot plug of the extension board.
>>
>> 5*) The given workaround patch fixes issue in bullet 5) and hot plug
>> is detected and system recognizes the extension board and add it and dGPU to PCI topology.
>>
>> Andrey
>>
>>>
>>>>
>>>> On 2022-06-10 17:25, Andrey Grodzovsky wrote:
>>>>>
>>>>>
>>>>> On 2022-02-10 09:39, Andrey Grodzovsky wrote:
>>>>>> Thanks a lot for quick response, we will give this a try.
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>> On 2022-02-10 01:23, Lukas Wunner wrote:
>>>>>>> On Wed, Feb 09, 2022 at 02:54:06PM -0500, Andrey Grodzovsky wrote:
>>>>>>>> Hi, on kernel based on 5.4.2 we are observing a deadlock between
>>>>>>>> reset_lock semaphore and device_lock (dev->mutex). The scenario
>>>>>>>> we do is putting the system to sleep, disconnecting the eGPU
>>>>>>>> from the PCIe bus (through a special SBIOS setting) or by simply
>>>>>>>> removing power to external PCIe cage and waking the
>>>>>>>> system up.
>>>>>>>>
>>>>>>>> I attached the log. Please advise if you have any idea how
>>>>>>>> to work around it ? Since the kernel is old, does anyone
>>>>>>>> have an idea if this issue is known and already solved in later kernels ?
>>>>>>>> We cannot try with latest since our kernel is custom for that platform.
>>>>>>>
>>>>>>> It is a known issue.  Here's a fix I submitted during the v5.9 cycle:
>>>>>>>
>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas%40wunner.de%2F&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C407a04694abb44cad1a908da4ee1c371%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637909028798586221%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=LchNztBhnuGsXC7Shn9AFc%2BRBk%2Bp%2B6O6Vq%2Fj9AzXBxI%3D&amp;reserved=0
>>>>>>>
>>>>>>> The fix hasn't been applied yet.  I think I need to rework the patch,
>>>>>>> just haven't found the time.
>>>>>
>>>>> Hey Lucas - just checking again if you had a chance to push this change
>>>>> through ? It's essential to us in one of our costumer projects so we
>>>>> wonder if have any estimate when will it be up-streamed and if we can
>>>>> help with this. We would also need backporting this back to 5.11 and 5.4
>>>>> kernels after it's upstreamed.
>>>>>
>>>>> Another point I want to mention is that this patch has a negative
>>>>> side effect on plug back times - it causes a regression point for the delay to light-up display at resume time related to back-ported AER
>>>>>
>>>>> Anatoli is working on resolving this and so maybe he can add his
>>>>> comment here and maybe you can help him with proper resolution for this.
>>>>>
>>>>> Andrey
>>>>>
>>>>>>>
>>>>>>> Since the trigger in your case are AER-handled errors during a
>>>>>>> system sleep transition, you may also want to consider the
>>>>>>> following 2-patch series by Kai-Heng Feng which is currently
>>>>>>> under discussion:
>>>>>>>
>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pci%2F20220127025418.1989642-1-kai.heng.feng%40canonical.com%2F&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C407a04694abb44cad1a908da4ee1c371%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637909028798586221%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=I%2FkE9XrIbeeWE%2F8IHXnD%2B3%2BhOnQ2TqgZqlpr9ViKiaI%3D&amp;reserved=0
>>>>>>>
>>>>>>> That series disables AER during a system sleep transition and
>>>>>>> should thus prevent the flood of AER-handled errors you're seeing.
>>>>>>> Once AER is disabled, the reset-induced deadlocks should go away as well.
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> Lukas
>>>
> 
