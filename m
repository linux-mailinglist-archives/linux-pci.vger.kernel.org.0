Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8EE72CF90
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 21:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjFLTbs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 15:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjFLTbr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 15:31:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5864EB1;
        Mon, 12 Jun 2023 12:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AysrGebQwm+xzLbw5fIU+lGdXW1Hpk6cAQkQp4z49plxbwIQ2MstHDnaKLgieY20KGOBmT4KeTwJcZV3acsrVAYW4qWaVKswweAqCIxjbEvQFGvYTCdRHaIqfp1/9SUKsYgDjxg3grbI914Zypxm1qaw4DVUZYngqRWj2gU0LTtzXXYT3JYULwat4xzsB/DpmCRaZ0bMPQb/0BMA2tj7wc0PNE3+zG7k6IA5SisuE9omF/IJFbCdXuJY07jT8n3CXiKg8/8WI93moC10klkChKHpKYZN1IszKNmTtUvAvsnAvMfclvom5/71VKQ3T2/94cV0Xl+GpfxVQ1f60Qtlzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0GZ75BfWRH73VF7TJpEt2ChCDe/w5xPoqQbu3APkuA=;
 b=chQEX48t2HORWdi7ZidfWb9Y1jAxu3vB5jgV70PcADzAfNPsmvz+8KsLqx+jr/Bl2Qcr5kZ4jaU6soKGqVsmnXYxbA79CdWFpGssHAL0zpiAfXc90Ses34/XpybiAIlx9BjyFDu6iO8Rv3CXnoPzHrekoEePqwvCxwVg/8Akr4LbQQXBJAfM+O8ZmIfvBsu4rA7JlEjKj8UCZ5L6EMsr6bCgckxt4H5aXsaojT0DTB2u7fx9aLZ3us32RVKLMn6YJQ6DSlWBZ9x8wt6gERTnadjJszmBfsxdY7NPZe4LVTaKMMXykHuh72CfvaeFlmwduvYmnSjBSmj5RUBKN3jt/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0GZ75BfWRH73VF7TJpEt2ChCDe/w5xPoqQbu3APkuA=;
 b=ZrJZh1VBTY4CNp64ZlZEXch2BpleU3Sj1uxtYC84U4NSxdPSlGy7RKiaUYBa6aQGzpsmAjkGxxsG6MVEk0+tZmeneKcE35uRAG34A3wuSlsYpxmw68twNjM8mphJ5gb/ScLwu5YD0Wb7FKYk6lGep4CtLzYDWwWWMuEWB9E9yAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BN9PR12MB5321.namprd12.prod.outlook.com (2603:10b6:408:102::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 19:31:40 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad%5]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 19:31:40 +0000
Message-ID: <2deec417-b1f6-5831-23f2-91fda2c802e5@amd.com>
Date:   Mon, 12 Jun 2023 12:31:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] PCI: pciehp: Add support for native AER and DPC
 handling on async remove
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
References: <20230612175457.GA1342613@bhelgaas>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230612175457.GA1342613@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:a03:80::30) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|BN9PR12MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 7228ed78-47bc-4713-d114-08db6b7ba51a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/wILm1ih79NzonEUe8PlQVXYHKmCd5FIjo6xdDA8foLjtJAjnxnxEc/gk/KM1ITGvLp6PzJa/Leq1Mr8EvorUmMnoHE+0syhtXKGnJ9PoVlqOZAtamFAp2Kk5lTGD08uJNU6r6Akp4JvVfhR2+CEe5XIfMlwe2kNLl+MI6wyCmcaUzw9RD/qGle6M0TsBf876rpp9zfGj9Vm/qwlQrkNq2bC6PgxUTpF2Y5/nbll6deV/S6NyD9kyKlgrOxC2fHznhOnQheC0V1RIcAcMkJT0dBlBMg+TBfX2HWLBgLqzIFaPVm89Q28UWkqYagT+/PRBUSQyPtrSkWRhEpnnlsbzon0y+buMYpiM1vBELA9Z2id6e+P/An4coC2+VZbNPalzKzTb+HO1rrsIEbo2YhuuP1rLNH47xzvSb1Y2RQTkEQVQKu+VyqIRBVKLifrJTqRC4E1MBdHAB5TDOTo3uV2dwSS4dB26gHCq6FXYu32UvPButjB+aNiDhyur49d2DX6Bod79zX2flrx5ag0dKlKMuD1/Z5XAyy2pxRDECWWf5VkjhVPkkqZd0Fp8k4/D7ukoC54gaIAnoXHqBDErPJ7Ya0IzuJ6C6nRMmyOHI1mEapXCo/+h0CSgEzhZW1LQcz5J2DB8aeQ3+lCalzMzTrpsoBA8L1+91dO+x6KlGuEaYK7eF/vGhKd18LGmPqHTIa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(31696002)(86362001)(36756003)(38100700002)(478600001)(6486002)(6666004)(54906003)(8936002)(966005)(8676002)(5660300002)(4326008)(6916009)(66946007)(66476007)(316002)(41300700001)(4744005)(2906002)(31686004)(66556008)(2616005)(83380400001)(6512007)(6506007)(186003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enFvb3kweWY4ZXUwNEQwbHdodmh0ekE1eG9PTTc0K3ovVU9lZ05VWUl0SElh?=
 =?utf-8?B?Y2VBNTBQUnR6bnhCSE55Zk5tMXdRd244R0NtSUplRDhiKzdnUHF3K0d1T2Fq?=
 =?utf-8?B?Vk9ucmRzNklnRHdpS0Q0TnEvdGV5cTlaYzRhcEtxRXB2aXBEQzlQeFV2WHlQ?=
 =?utf-8?B?bU15d1FwMXphSFNYL3BCaWhsYUtlbGN1T2VvNWlnenI4MitGdUFaOW9jZFNC?=
 =?utf-8?B?aDZBakM1U0Y0Wmc5aU9Ba05iMmZJQUdvNUVvMDhXUFNWNHVLZnIzWXdhc1Ns?=
 =?utf-8?B?TFE4UDcwdG5ITW5heW5iaUlpWE5KcjhDSThLSEV2Z3JqaFhpNVplVHlOVnZp?=
 =?utf-8?B?bzNaQ0FLWEdaWDZKUzNjRURFdWVCZkhZWGs3N3k1eENxRmdxN1JCWUhtejZa?=
 =?utf-8?B?MGIwdkdGRjNNMnJWQ2NGRThEdFFiTzdnRmUyWkdXMHBoTi9wcmVoUjVYc2Jw?=
 =?utf-8?B?WmVOWERVdDJTQmRrM0w3ZmpXcjZuTmtlWHMrMXF5RWtQWXF2REtLL2pjb0xY?=
 =?utf-8?B?SG1SVTlUdWh5TFEzMVNXL0FMaHc1WjlBQjN2eDZvaGNrTUV3b3c3YlRxQVNV?=
 =?utf-8?B?dkJIQWFiTUQzclhyd2JVNks5aUJ4Y2tOUTNnd2lDZUZsU1lJaVBLaExNNFVx?=
 =?utf-8?B?RE9zTE1TQk12K1JvME1ZcTFhN1V1SHNwK2hOY2UrcXd4bE9JU2tUckpJeUJo?=
 =?utf-8?B?S1lPSXJmWVV3WnAwWWY3OXhLeWFxNHJveEJqM2gyVC9GV3A3SUQ2WW5DZlhz?=
 =?utf-8?B?R3RWZnZadjduaEluWWR5c1VEYnJIWVFwaUZOTmF4cnVBQzJwSHFqWlA5Y0t3?=
 =?utf-8?B?TnAvOWVWRzFFem9UNjJiblZLRDVqd01tWTJhV01lVkpwVFdLUVBNeHY2aloz?=
 =?utf-8?B?R05NV21ENU1VNVR2a0tpMU1GY1VNRmlCbUZpQ1JTZG1OajVBc2VDNDRKeG8x?=
 =?utf-8?B?S1hDNmtYYS9jTmkxdFhvVll6TUExQzRyVlNDOWxXQldhbUJWQW93a2xUR1Ro?=
 =?utf-8?B?T3NTRTFiU2s1YUZDZWdHcW9weExtUzQ1VHIvb1lWM2w1cnR5L2wyTXhOTC9p?=
 =?utf-8?B?a1g0TkQzR1lxZTlpMHF6K1VDZ3VhZWl4RkRXaU1rckZKYUlta0RRZEVVMWFW?=
 =?utf-8?B?T3pPMFRaZi9iVHRRT3JKMzdvTDFYVitERWxaTmtUSjFUOU9NZDh3UkVlL0tN?=
 =?utf-8?B?dEE0QVJBa20rYWl4TE1SNDdGZnIrS0k1Tnh3QzFXRTY0bjQrdnlrZml6TDNu?=
 =?utf-8?B?OVVUdld6a0NqOTkydVR3VFRXdzJnM3hGTEVyK3RxZHBudzNyM1dTNGd2QWp2?=
 =?utf-8?B?cG1vczd6UWFMU2kzVDEwNTE5MzJKckNjMStMMDg0ejV4aHkyVlF5aVRYVDRL?=
 =?utf-8?B?YWdmSlU0Y0hvb01IeFY3SUlwWGR2SS91RVJUTkRyYWZVYUxpZHV1aTNLaTYw?=
 =?utf-8?B?ZnBmVUNPaEVoQkFrdEUxRzAzRnBnVjkwN1diUUlyR2dVOUFEM2w5N1NmVzU2?=
 =?utf-8?B?T2RvTktpVDZac1J4RjJndFUxellkaFNpSmhiRzRLOE9wMGZWUGRjbC94VDdB?=
 =?utf-8?B?dUpjeWdYUkdjaFpVQ0d6Z0c1VjQxTWRtSXhSVFVnbk92VHhUV3pZa0JSamJG?=
 =?utf-8?B?WHNmT2RrcGxOalVsSTNBd3pNMStRa1J5TzRKanhXYURkVkZZYWZuMlc2U2tO?=
 =?utf-8?B?ZklDQi9RNVFBR2RyL01BVVNjNnV2K3c0ZG1iVHdXUHNkRTNad29GTENDODAw?=
 =?utf-8?B?TnBMRDMrRkpjV01JU0taSXZqUktsU042ODd0RFdHeFJtdlh5Y2poTm5ZOXpO?=
 =?utf-8?B?MGFZbXczcVd1VWpnUUZtL2xhSVMyOElORlBJUVRvWTVLdDVSOWp0WHQyTUo4?=
 =?utf-8?B?dEJjNFZ5Uld4c1VVWHY1Sjd0ejFoQTY2NVBUSjBxZy9LTlNRRTVTaklpTytT?=
 =?utf-8?B?WkR0NDhpRmYwbWtjS2hBQWVZSjNBMXpXTkYyRVMrL0dEOGJIempCNkNzT1dE?=
 =?utf-8?B?TnZyajAwUjhJSm42aG85ZG1NZmJpbkJJVUV2Vk1RM0wzOENWT0JqKzZEUTBM?=
 =?utf-8?B?MzRFMUxzbHRtekFkRlh5bnBrelVuOE9YRjRoeDFhSlVnZmQyS0NKRDBvQ0Yx?=
 =?utf-8?B?Mlh5d1BjcW9LL2FtelI2azg3Vkk0bURHTmtnMEFpK0RLVXpXTzZ2OTBoZkVp?=
 =?utf-8?Q?Pmj41aeLyCJLksMrp6KvF5v3KYHzev71+pbCg6R9QxrH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7228ed78-47bc-4713-d114-08db6b7ba51a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 19:31:39.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4Pg3adsVafGNZgHnggMkOmpPgX7fQ0F7gEQN5XT4LC0Bka99Zsq67Y1hbBi//JmQ2ebj4Xct4FTQOER24hJOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5321
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/12/2023 10:54 AM, Bjorn Helgaas wrote:
> On Tue, May 09, 2023 at 01:58:37PM -0700, Smita Koralahalli wrote:
>> Hi,
>>
>> Could I please get review comments on my patch set? I had re-based
>> it on latest tree in v2 as I did not hear back on my questions in
>> v1.
> 
> Thanks for persevering.  It looks like there may still be some ongoing
> discussion with Lukas?  And a few of his comments that you plan to
> address?  Thanks for looking into the 10-bit tag issue.  I know those
> tag widths are non-trivial to handle correctly and it would be good to
> clean them up.
> 
> Bjorn

Yeah. Since we didn't come to a conclusion on how should we attempt 
clearing 10-bit tags and Atomic Op Requestor, I held on preparing v3.

https://lore.kernel.org/all/cc36bb5b-6a4a-258b-6707-4d019154e019@amd.com/

But I can go ahead and send v3 for just the first patch, 
https://lore.kernel.org/all/8ab986f2-6aa5-401a-aa21-e8b21f68eaad@amd.com/ and 
wait on Lukas for 10-bit tag issue.

Thanks,
Smita
