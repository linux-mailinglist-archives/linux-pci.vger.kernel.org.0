Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660285A2828
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 15:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbiHZNA6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 09:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbiHZNA4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 09:00:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7BB6CF47;
        Fri, 26 Aug 2022 06:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=namw3hs/aZQiMj/I7dPHZO1xQgzEyNoi7mOvM2okz/TpkFpkMkWQLVeAq2PR4fcbM4x+LbvTMbcSvyh5f+SA8QMx3APlT+Q80LEtMKpepyBLyLAgXLR0bB0xyw4bsfYj8jV8WmqRPCvIiChr3VuHaiknRBv9KGEi+fmuJ5K/Upj5jrvOLcKV0Vivt/hVmVoq2a3MS4J9PAFJIwauHikFyqGVL+4xT6zkzflACIaH+eErZPSbKiJ2Kj8d1gBhE6IGRPcylyH4IIb1YBiG4dHSCKoCxnHfOE5GhXu6Du2GqtPyXe7IxhBqX5exMosuYgZYf+tyNVXRqIVBAJ6Cj65rHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GNnqLhqy/34VGZWCJQ8R+7AW4ohyehTk5yr4lv62Bk=;
 b=izObi25eJ52F9IJUTdgHyLEqs5XbtthzLP/8/Y1SJjgDHShNX0HZobDHb4A1+S0VNMIE3v37jbRn6fniGIMVl+X/WJhvi1U7MrEsXtvx+ePkMhGSNNfl1wI+zWqouFmGwMuUrbBazOJqkYEjONgJL0khR/dDIL3SYu5/IK4IU/MuuIFQR9bWS3+QhECIUD8kVq5GoKzEyYH7Soo8p30Rf/XJK+a0szkrj7n1ovXQETmEvxv3a0XG43vwT8oZSlPt2Mp1XxAYvl8VLV8MbpIdlWDvY15B+qfztWskvnYM9jAR0yZ+2Hp4FDn3mr5FUVNsJKKwDnvn/uoabzGMe6Hjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GNnqLhqy/34VGZWCJQ8R+7AW4ohyehTk5yr4lv62Bk=;
 b=fYfMlsj7n6bpZljahGI9TmKO0SqjrmFSDsEoVzy28Fda7t4Swqg3Yo5BMk5my21u50FXcXjkCTRFNJQZhViPmFFplt7yJzZcYEMGOyXIu+TdmUm8NFXwtr0IHU5P4lsJEpg6FYmmi0KcvW6TlzrCwD5KKqhp7r3iCahZqSN7F9RDS2GVr7+o1ZTVPspOFirQ0shxz5Ott7bSLmjyCwH67IRh98GFfpOjFsfiFVyBlJdeNXxf7jxTtid+PWdv+4fYbtkN41yY9XL2dl+1T984MQ1Xks8DXaiEDPltE1tI0sFv+XwyRd6S4K6u1pkknOCQMUFKyATdK+PpiAodXYqfww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 13:00:44 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b150:321c:21e4:40c9]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b150:321c:21e4:40c9%7]) with mapi id 15.20.5546.022; Fri, 26 Aug 2022
 13:00:44 +0000
Message-ID: <eb420ee1-424a-5688-8610-9d3e510d0327@nvidia.com>
Date:   Fri, 26 Aug 2022 18:30:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Lukasz Majczak <lma@semihalf.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Ben Chuang <benchuanggli@gmail.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, refactormyself@gmail.com, kw@linux.com,
        kenny@panix.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220722174212.GA1911979@bhelgaas>
 <86522aa5-2855-0f73-ddb2-a2b50b2fd1b7@nvidia.com>
 <CACK8Z6FSr_ztkZ5+ULjHiDZ5L9qR=Ewtq1ZuDofzvJX=mW5WAQ@mail.gmail.com>
 <CAFJ_xbpYrtFrt-hEd7M0jqyH7R9pOKA9884sgMvV2RZXycj7hA@mail.gmail.com>
 <CAFJ_xbqyxJ591DgC=xQEzokip6i_j0mex5SDTBrwkOe=-8bikg@mail.gmail.com>
 <8b36f97c-0cc4-3f4a-3b5b-49ad5786d9e9@nvidia.com>
 <CAFJ_xbr5NjoV1jC3P93N4UgooUuNdCRnrX7HuK=xLtPM5y7EjA@mail.gmail.com>
 <d3228b1f-8d12-bfab-4cba-6d93a6869f20@nvidia.com>
 <CAFJ_xboyQyEaDeQ+pZH_YqN52-ALGNqzmmzeyNt6X_Cz-c1w9Q@mail.gmail.com>
 <b841fe9f-6091-ff55-cd0f-76bc6b04ff46@nvidia.com>
 <CAAd53p7WWxyvvB54ADkFSZE1oJweaoNK25g6YNcNxCqkeWiVKg@mail.gmail.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <CAAd53p7WWxyvvB54ADkFSZE1oJweaoNK25g6YNcNxCqkeWiVKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::15) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f3b68a3-1b3d-4527-0ef5-08da8762fc94
X-MS-TrafficTypeDiagnostic: MW4PR12MB6949:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+WySy5KF3SJZkYslDaOPqpoSw0OzwqOaxLJI9HKsfKWBERXvfU1vEDCm3zpxmQWw5LTsvp7PcMUB9AJ/E0H0CW5JOijLA+St6IPFtBuU9A12R20KJ7+jhC76Y9HjU+PdEp2xJKUWPn5xCI4tOsZAM8SpPzmnF0/tQXUbIRRvlNLMUMhI8U9H6Tu54Tf7YEWQkC5RxeqNhuDSmZFjeWsHC4t/dv11e7SjAGIMsjE7IQ07+2n1jli7nbFVwdApdUMJQxJiJ9nlzoe7luEL9a6aAhuFyPAzEIujrXZccDXf0Z997qZJtjIzOKtoqQHNGb9EV1paXVFTBd+WrvDG9y1fFd4xQy9z3xGGjkH2VjVDVtcukBZg33HLZnuYqoFVIFXj2OxHKIj8wHky6Utr2aPXRai5I6efgMMlUPvqAq+NkPw6xjBIBRGvaR7RQeH+lHA3n//ZubFdkSkvRzJhTf+o6U4vDbybOFU7MOI5f9qq5MgxHx/sONNm9ipjIywgthuvkz8s6eFi4W949MEK55LAl62+Y2IA6wsN52YtG4hDIV/e/kGqlGEwxHjvJirQqmBNoZk1a8DMtCBCwSoeJfwxQyhEhOAWuG5voZ0VtB0yuEHc6DRI8E5Nvp+QOIStsubfPW8iqkt0X37P0xlHpaLC0nKVtjaJNUykwOGJTpHxYruD+f5790xsylo206aHltsy3YQe6W3RrA5rIFk7t/wH7tt33V7g0OrVCE5IU6cbIubG3GT2zfFdsJi32LwNzVs2zQjh80BKcmx4Bya2x72QjHIvELD41UURIEqCkjLHx1yRSfmzmYRwne/DD4IIJowSP/6nE1SGdGnGMl0aJtfGVRttjIb94wbQrar3JTiaLl1aPocErLEAlTFpRzkFrsiCWFDO2litj8aGCEE1vRHb+6SNV2PRp9wpDgO3GZqoU/7GK+kN62HWkx+36hr6DzT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(6486002)(7416002)(478600001)(8936002)(966005)(5660300002)(53546011)(6512007)(26005)(41300700001)(30864003)(6506007)(31696002)(15650500001)(6666004)(38100700002)(86362001)(2906002)(2616005)(186003)(83380400001)(8676002)(19627235002)(4326008)(31686004)(66556008)(66476007)(316002)(6916009)(36756003)(66946007)(54906003)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGhoV1pSQWEvaUtSY3QyMHcxYkp6ZENoaVBkMFFYYzE1TmxvNHZFUld3WHFF?=
 =?utf-8?B?NlpQUXk2VlJSMWxITzU2UXRYOGFaVDh1UUpnTGNLd0V0VUVTRWtDNW16bFhF?=
 =?utf-8?B?TDBWeEJTZkFabUNETndwd1dCRG4xQ2ZNUGUxei9nTGhKVm9tTFlsN2NNV0h2?=
 =?utf-8?B?VkZkaGNPL3ZFWUFRZmdOcE5ZZjdQSWthS0QyNFRPdHNETmNpVldWdllKYytw?=
 =?utf-8?B?TjlMZHhHZjFhTHZjTDZsb3liNXVvamt2TjZqbWpVVStnSld1ZjYxTkJON08w?=
 =?utf-8?B?OVFEUGI1RzFNbFI4Zk8zU0trRS9HT0ZLYXBTN2huNzdkbEhEQzFJUVV2YWVI?=
 =?utf-8?B?U0c2TkwyMDVlY1R3Ykp4MXZoOCs1NFVkYkxzajJUN21mYllEQ1dQNGZBN25v?=
 =?utf-8?B?eTNaanhlQXB3ckk2NTJjOUwwVG85c3ZHMU1EYmNPSjBXeTk2aFYyMU5EVVJR?=
 =?utf-8?B?MTN1dEtxNS95cnAxb0k4RXBoY1NKdWFJdytKWUthaUZBb0VoZUw5SVhYZjRm?=
 =?utf-8?B?ZFE4QTZOVzZibUZWMUJ6TE4xYzkyZ0VQbFQwUkY0SmtOdlMrS0ZZV1R4TnNz?=
 =?utf-8?B?eGFJcURDTHhoQ1FMM0RidWNtejRNQjhHODNZMmhZdXRFRGlGeEYreHRPSEdU?=
 =?utf-8?B?SDN2TjhmL0xFNktoSStGaWYzbVNjS3pJS3ZiZU5XZTZ5VkQweFNWVUI1UXVs?=
 =?utf-8?B?MmprQ3RVMDNvcVNyS0JaYXYzTnpTNHBiK1VKdGdZWU5ueW52ZGZmcStMN3BV?=
 =?utf-8?B?QVhyb1VPSGxxUXB3dStra3hmaVRmT0xOUWdzYUxQcmRaY3lFeGJWeWxOS3lu?=
 =?utf-8?B?by9yd2JkRFh2YzRvTHMyU0JDeWp6S3hUUS9SL1BmdlQ2eE9HSlJ2UFR2aWVF?=
 =?utf-8?B?ajIyVWFTeHNJbFp3NFBwQ1VLTGtyOWtaSkdKNkNtUXphekxjQkVhSnptYlcr?=
 =?utf-8?B?YzQwNzUwd2tQU29hUWd5OTB0TTJOaklhUEZqTVhhY0VWdmRUK2ZMUUVyRWFY?=
 =?utf-8?B?SlgrUzdEajZPUkEyTFk5eUtvb01NWW9VZUxDcEZuOHRBZXh3c3Bpckh3ajZp?=
 =?utf-8?B?WllVK3p6RmV3bnF5Mm1YWktSdzRsNVp0aCtMRDZvSnpSUGxaY3h6L3Y0RnBC?=
 =?utf-8?B?TlVHSnR4SXpFMHZiQXZXc0RaNEJPeWJYTWhqcGNyYU93RnFiOVZjU2xLT2l6?=
 =?utf-8?B?TEo2Ym5YSkNTVHRYNlFrVmVCa0h4WFpXcllsWHdCL08xakJZMFk2R2VHbU5M?=
 =?utf-8?B?VHV1SGxTK1RpQjF4T1Z6K25UMUdpd3ovQ2p1SjFudmxrYTJxeFY0T1VWL1BX?=
 =?utf-8?B?L0ZDUkt1S0VCRUs2ZnZ3dTRuamt4QnVtdHIzejRxcVMwbnNRSjV5Ym91YkF6?=
 =?utf-8?B?U01NSlRhTmdUalgvc2ZJOGt0VlpZUjBoZmRlTTJTM2syMGt5dGFBcGYxMHll?=
 =?utf-8?B?UFZlZFBQME9tbjMveHF2ZkU5SGdrS05HTEwxaE52VjZKZzhkTUZBRTNnSmZt?=
 =?utf-8?B?djFpelArc3lqSmVBdHNKYWIyVFNtb3UwT284RWRXaEtENFRnL3EwMVdLMWF2?=
 =?utf-8?B?VUVjZkhPKzA5SVZrK0dqTjlybnRJbHZ3WFg2QlA1eUlwOXFOK3BKNU9HOElt?=
 =?utf-8?B?ZlNONDg3RmR5S0pIOTlWZ241ZHBVMzdxNXl1aVJBVGNnVHA4WFpKc2VKUit4?=
 =?utf-8?B?c015dXgvNlpvdFJNUUVNcnM2bWZZYW9HMU5zMDBGbjRFYTIrU0dPYkIzcW9p?=
 =?utf-8?B?cUUxbE9aTjd5K3RGeEV3azRFRi9vYk9Gdy84bXBvNHVJbUFnemQ1VkRWeVNx?=
 =?utf-8?B?L2tCUDdvWENHYnRYY0NFcE9Walhma052UFovNGs3alJuN2hHUkxZMTNoTEh4?=
 =?utf-8?B?RnZSSjFFVzFyZHNLZjdlak1ENE53SDIwNEtFcy9wNUwxeEpBNUxtSTRIYThQ?=
 =?utf-8?B?bVBRZFIrRVRyTld5ZUZ5a2p2a0ZZYTI4SThERzMzbVhRT3B1R3hkRVpMQ21H?=
 =?utf-8?B?NmdadWNJUDFDSnZTTXhKMW5ZQUFaTWwvbXAweG1yRzRRSHI0R1pXQ0dTNzN4?=
 =?utf-8?B?eTBOblJrUW5JSW4waUZJWnZKeWJPMmhCMno4eEdnNmQ2aGNCTmNKMVJFOEdz?=
 =?utf-8?Q?4QESoZxzp5cI+MeJ0rRMyxFzw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3b68a3-1b3d-4527-0ef5-08da8762fc94
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 13:00:44.5452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20G/Tjf5/abiz85iGD2aMBEVT/M4BUMx9BYWQh8bQuAmSdH7d9Mldmkocmkaj+2SNULZO3i1yBOydTZl1QDZ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
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



On 8/23/2022 8:25 PM, Kai-Heng Feng wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Vidya,
> 
> On Tue, Aug 9, 2022 at 12:17 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>>
>> Thanks Lukasz for the update.
>> I think confirms that there is no issue with the patch as such.
>> Bjorn, could you please define the next step for this patch?
> 
> I think the L1SS cap went away _after_ L1SS registers are restored,
> since your patch already check the cap before doing any write:
> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> +       if (!aspm_l1ss)
> +               return;
> 
> That means it's more likely to be caused by the following change:
> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> 
> So is it possible to clear PCI_L1SS_CTL1 before setting PCI_L1SS_CTL2,
> like what aspm_calc_l1ss_info() does?

I posted a new patch 
https://patchwork.kernel.org/project/linux-pci/patch/20220826125526.28859-1-vidyas@nvidia.com/ 
keeping L1.2 disabled while restoring the rest of the fields in 
Control-1 register and restoring the L1.2 enable bits later. Could you 
please try this new patch on your setup and update your observations?

Thanks & Regards,
Vidya Sagar

> 
> Kai-Heng
> 
>>
>> Thanks,
>> Vidya Sagar
>>
>> On 8/8/2022 7:37 PM, Lukasz Majczak wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> śr., 3 sie 2022 o 14:55 Vidya Sagar <vidyas@nvidia.com> napisał(a):
>>>>
>>>> Thanks Lukasz for the logs.
>>>> I still that the L1SS capability in the root port (00:14.0) disappeared
>>>> after resume.
>>>> I still don't understand how this patch can make the capability register
>>>> itself disappear. Honestly, I still see this as a HW issue.
>>>> Bjorn, could you please throw some light on this?
>>>>
>>>> Thanks,
>>>> Vidya Sagar
>>>>
>>>> On 8/3/2022 5:34 PM, Lukasz Majczak wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> pt., 29 lip 2022 o 16:36 Vidya Sagar <vidyas@nvidia.com> napisał(a):
>>>>>>
>>>>>> Hi Lukasz,
>>>>>> Thanks for sharing your observations.
>>>>>>
>>>>>> Could you please also share the output of 'sudo lspci -vvvv' before and
>>>>>> after suspend-resume cycle with the latest linux-next?
>>>>>> Do we still see the L1SS capabilities getting disappeared post resume?
>>>>>>
>>>>>> Thanks,
>>>>>> Vidya Sagar
>>>>>>
>>>>>> On 7/29/2022 3:09 PM, Lukasz Majczak wrote:
>>>>>>> External email: Use caution opening links or attachments
>>>>>>>
>>>>>>>
>>>>>>> wt., 26 lip 2022 o 09:20 Lukasz Majczak <lma@semihalf.com> napisał(a):
>>>>>>>>
>>>>>>>> wt., 26 lip 2022 o 00:51 Rajat Jain <rajatja@google.com> napisał(a):
>>>>>>>>>
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> On Sat, Jul 23, 2022 at 10:03 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Agree with Bjorn's observations.
>>>>>>>>>> The fact that the L1SS capability registers themselves disappeared in
>>>>>>>>>> the root port post resume indicates that there seems to be something
>>>>>>>>>> wrong with the BIOS itself.
>>>>>>>>>> Could you please check from that perspective?
>>>>>>>>>
>>>>>>>>> ChromeOS Intel platforms use S0ix (suspend-to-idle) for suspend. This
>>>>>>>>> is a shallower sleep state that preserves more state than, for e.g. S3
>>>>>>>>> (suspend-to-RAM). When we use S0ix, then BIOS does not come in picture
>>>>>>>>> at all. i.e. after the kernel runs its suspend routines, it just puts
>>>>>>>>> the CPU into S0ix state. So I do not think there is a BIOS angle to
>>>>>>>>> this.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Vidya Sagar
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 7/22/2022 11:12 PM, Bjorn Helgaas wrote:
>>>>>>>>>>> External email: Use caution opening links or attachments
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On Fri, Jul 22, 2022 at 11:41:14AM +0200, Lukasz Majczak wrote:
>>>>>>>>>>>> pt., 22 lip 2022 o 09:31 Kai-Heng Feng <kai.heng.feng@canonical.com> napisał(a):
>>>>>>>>>>>>> On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@gmail.com> wrote:
>>>>>>>>>>>>>> On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
>>>>>>>>>>>>>>> saved and restored during suspend/resume leading to L1 Substates
>>>>>>>>>>>>>>> configuration being lost post-resume.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Save the L1 Substates control registers so that the configuration is
>>>>>>>>>>>>>>> retained post-resume.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>>>>>>>>>>>> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hi Vidya,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I tested this patch on kernel v5.19-rc6.
>>>>>>>>>>>>>> The test device is GL9755 card reader controller on Intel i5-10210U RVP.
>>>>>>>>>>>>>> This patch can restore L1SS after suspend/resume.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The test results are as follows:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> After Boot:
>>>>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>>>>>>>>>>>              Capabilities: [110 v1] L1 PM Substates
>>>>>>>>>>>>>>                      L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>>>>>>>                                PortCommonModeRestoreTime=255us
>>>>>>>>>>>>>> PortTPowerOnTime=3100us
>>>>>>>>>>>>>>                      L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>>>>>>>>>>                                 T_CommonMode=0us LTR1.2_Threshold=3145728ns
>>>>>>>>>>>>>>                      L1SubCtl2: T_PwrOn=3100us
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> After suspend/resume without this patch.
>>>>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>>>>>>>>>>>              Capabilities: [110 v1] L1 PM Substates
>>>>>>>>>>>>>>                      L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>>>>>>>                                PortCommonModeRestoreTime=255us
>>>>>>>>>>>>>> PortTPowerOnTime=3100us
>>>>>>>>>>>>>>                      L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>>>>>>>>>>>>>                                 T_CommonMode=0us LTR1.2_Threshold=0ns
>>>>>>>>>>>>>>                      L1SubCtl2: T_PwrOn=10us
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> After suspend/resume with this patch.
>>>>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>>>>>>>>>>>              Capabilities: [110 v1] L1 PM Substates
>>>>>>>>>>>>>>                      L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>>>>>>>                                PortCommonModeRestoreTime=255us
>>>>>>>>>>>>>> PortTPowerOnTime=3100us
>>>>>>>>>>>>>>                      L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>>>>>>>>>>                                 T_CommonMode=0us LTR1.2_Threshold=3145728ns
>>>>>>>>>>>>>>                      L1SubCtl2: T_PwrOn=3100us
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Tested-by: Ben Chuang <benchuanggli@gmail.com>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Forgot to add mine:
>>>>>>>>>>>>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Best regards,
>>>>>>>>>>>>>> Ben Chuang
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>> Kenneth R. Crudup <kenny@panix.com>, Could you please verify this patch
>>>>>>>>>>>>>>> on your laptop (Dell XPS 13) one last time?
>>>>>>>>>>>>>>> IMHO, the regression observed on your laptop with an old version of the patch
>>>>>>>>>>>>>>> could be due to a buggy old version BIOS in the laptop.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>> Vidya Sagar
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>       drivers/pci/pci.c       |  7 +++++++
>>>>>>>>>>>>>>>       drivers/pci/pci.h       |  4 ++++
>>>>>>>>>>>>>>>       drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>>>>>>       3 files changed, 55 insertions(+)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>>>>>>>>>>> index cfaf40a540a8..aca05880aaa3 100644
>>>>>>>>>>>>>>> --- a/drivers/pci/pci.c
>>>>>>>>>>>>>>> +++ b/drivers/pci/pci.c
>>>>>>>>>>>>>>> @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
>>>>>>>>>>>>>>>                      return i;
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>              pci_save_ltr_state(dev);
>>>>>>>>>>>>>>> +       pci_save_aspm_l1ss_state(dev);
>>>>>>>>>>>>>>>              pci_save_dpc_state(dev);
>>>>>>>>>>>>>>>              pci_save_aer_state(dev);
>>>>>>>>>>>>>>>              pci_save_ptm_state(dev);
>>>>>>>>>>>>>>> @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
>>>>>>>>>>>>>>>               * LTR itself (in the PCIe capability).
>>>>>>>>>>>>>>>               */
>>>>>>>>>>>>>>>              pci_restore_ltr_state(dev);
>>>>>>>>>>>>>>> +       pci_restore_aspm_l1ss_state(dev);
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>              pci_restore_pcie_state(dev);
>>>>>>>>>>>>>>>              pci_restore_pasid_state(dev);
>>>>>>>>>>>>>>> @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>>>>>>>>>>>>>>>              if (error)
>>>>>>>>>>>>>>>                      pci_err(dev, "unable to allocate suspend buffer for LTR\n");
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> +       error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
>>>>>>>>>>>>>>> +                                           2 * sizeof(u32));
>>>>>>>>>>>>>>> +       if (error)
>>>>>>>>>>>>>>> +               pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>              pci_allocate_vc_save_buffers(dev);
>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>>>>>>>>>>>> index e10cdec6c56e..92d8c92662a4 100644
>>>>>>>>>>>>>>> --- a/drivers/pci/pci.h
>>>>>>>>>>>>>>> +++ b/drivers/pci/pci.h
>>>>>>>>>>>>>>> @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>>>>>>>>>>>>>>>       void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>>>>>>>>>>>>>>>       void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>>>>>>>>>>>>>>>       void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>>>>>>>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>>>>>>>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>>>>>>>>>>>>>>>       #else
>>>>>>>>>>>>>>>       static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>>>>>>>>>>>>>>>       static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>>>>>>>>>>>>>>>       static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>>>>>>>>>>>>>>>       static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>>>>>>>>>>>>>>> +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
>>>>>>>>>>>>>>> +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>>>>>>>>>>>>>>>       #endif
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>       #ifdef CONFIG_PCIE_ECRC
>>>>>>>>>>>>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>>>>>>>>>>>>> index a96b7424c9bc..2c29fdd20059 100644
>>>>>>>>>>>>>>> --- a/drivers/pci/pcie/aspm.c
>>>>>>>>>>>>>>> +++ b/drivers/pci/pcie/aspm.c
>>>>>>>>>>>>>>> @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>>>>>>>>>>>>>>>                                      PCI_L1SS_CTL1_L1SS_MASK, val);
>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +       int aspm_l1ss;
>>>>>>>>>>>>>>> +       struct pci_cap_saved_state *save_state;
>>>>>>>>>>>>>>> +       u32 *cap;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +       if (!pci_is_pcie(dev))
>>>>>>>>>>>>>>> +               return;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>>>>>>>> +       if (!aspm_l1ss)
>>>>>>>>>>>>>>> +               return;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>>>>>>>> +       if (!save_state)
>>>>>>>>>>>>>>> +               return;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +       cap = (u32 *)&save_state->cap.data[0];
>>>>>>>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
>>>>>>>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>> +       int aspm_l1ss;
>>>>>>>>>>>>>>> +       struct pci_cap_saved_state *save_state;
>>>>>>>>>>>>>>> +       u32 *cap;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +       if (!pci_is_pcie(dev))
>>>>>>>>>>>>>>> +               return;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>>>>>>>> +       if (!aspm_l1ss)
>>>>>>>>>>>>>>> +               return;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>>>>>>>> +       if (!save_state)
>>>>>>>>>>>>>>> +               return;
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>> +       cap = (u32 *)&save_state->cap.data[0];
>>>>>>>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
>>>>>>>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>       static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>>>>>>>>>>>>>>>       {
>>>>>>>>>>>>>>>              pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>> 2.17.1
>>>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> With this patch (and also mentioned
>>>>>>>>>>>> https://lore.kernel.org/all/20220509073639.2048236-1-kai.heng.feng@canonical.com/)
>>>>>>>>>>>> applied on 5.10 (chromeos-5.10) I am observing problems after
>>>>>>>>>>>> suspend/resume with my WiFi card - it looks like whole communication
>>>>>>>>>>>> via PCI fails. Attaching logs (dmesg, lspci -vvv before suspend/resume
>>>>>>>>>>>> and after) https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3
>>>>>>>>>>>>
>>>>>>>>>>>> I played a little bit with this code and it looks like the
>>>>>>>>>>>> pci_write_config_dword() to the PCI_L1SS_CTL1 breaks it (don't know
>>>>>>>>>>>> why, not a PCI expert).
>>>>>>>>>>>
>>>>>>>>>>> Thanks a lot for testing this!  I'm not quite sure what to make of the
>>>>>>>>>>> results since v5.10 is fairly old (Dec 2020) and I don't know what
>>>>>>>>>>> other changes are in chromeos-5.10.
>>>>>>>>>
>>>>>>>>> Lukasz: I assume you are running this on Atlas and are seeing this bug
>>>>>>>>> when uprev'ving it to 5.10 kernel. Can you please try it on a newer
>>>>>>>>> Intel platform that have the latest upstream kernel running already
>>>>>>>>> and see if this can be reproduced there too?
>>>>>>>>> Note that the wifi PCI device is different on newer Intel platforms,
>>>>>>>>> but platform design is similar enough that I suspect we should see
>>>>>>>>> similar bug on those too. The other option is to try the latest
>>>>>>>>> ustream kernel on Atlas. Perhaps if we just care about wifi (and
>>>>>>>>> ignore bringing up the graphics stack and GUI), it may come up
>>>>>>>>> sufficiently enough to try this patch?
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>> Rajat
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Random observations, no analysis below.  This from your dmesg
>>>>>>>>>>> certainly looks like PCI reads failing and returning ~0:
>>>>>>>>>>>
>>>>>>>>>>>        Timeout waiting for hardware access (CSR_GP_CNTRL 0xffffffff)
>>>>>>>>>>>        iwlwifi 0000:01:00.0: 00000000: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
>>>>>>>>>>>        iwlwifi 0000:01:00.0: Device gone - attempting removal
>>>>>>>>>>>        Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.
>>>>>>>>>>>
>>>>>>>>>>> And then we re-enumerate 01:00.0 and it looks like it may have been
>>>>>>>>>>> reset (BAR is 0):
>>>>>>>>>>>
>>>>>>>>>>>        pci 0000:01:00.0: [8086:095a] type 00 class 0x028000
>>>>>>>>>>>        pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
>>>>>>>>>>>
>>>>>>>>>>> lspci diffs from before/after suspend:
>>>>>>>>>>>
>>>>>>>>>>>         00:14.0 PCI bridge: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port B #1 (rev fb) (prog-if 00 [Normal decode])
>>>>>>>>>>>           Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>>>>>>>>>>>        -               DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPwr+ TransPend-
>>>>>>>>>>>        +               DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>>>>>>>>>>>        -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
>>>>>>>>>>>        +               LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>>>>>>>>>>>        -               LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
>>>>>>>>>>>        +               LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
>>>>>>>>>>>        -       Capabilities: [150 v0] Null
>>>>>>>>>>>        -       Capabilities: [200 v1] L1 PM Substates
>>>>>>>>>>>        -               L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>>>>        -                         PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
>>>>>>>>>>>        -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>>>>>>>        -                          T_CommonMode=40us LTR1.2_Threshold=98304ns
>>>>>>>>>>>        -               L1SubCtl2: T_PwrOn=60us
>>>>>>>>>>>
>>>>>>>>>>> The DevSta differences might be BIOS bugs, probably not relevant.
>>>>>>>>>>> Interesting that ASPM is disabled, maybe didn't get enabled after
>>>>>>>>>>> re-enumerating 01:00.0?  Strange that the L1 PM Substates capability
>>>>>>>>>>> disappeared.
>>>>>>>>>>>
>>>>>>>>>>>         01:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
>>>>>>>>>>>                        LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
>>>>>>>>>>>        -                       ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>>>>>>>>>>>        +                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>>>>>>>>>                Capabilities: [154 v1] L1 PM Substates
>>>>>>>>>>>                        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>>>>                                  PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
>>>>>>>>>>>        -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>>>>>>>        -                          T_CommonMode=0us LTR1.2_Threshold=98304ns
>>>>>>>>>>>        +               L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>>>>>>>>>>        +                          T_CommonMode=0us LTR1.2_Threshold=0ns
>>>>>>>>>>>
>>>>>>>>>>> Dmesg claimed we reconfigured common clock config.  Maybe ASPM didn't
>>>>>>>>>>> get reinitialized after re-enumeration?  Looks like we didn't restore
>>>>>>>>>>> L1SubCtl1.
>>>>>>>>>>>
>>>>>>>>>>> Bjorn
>>>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Thank you all for the response and input! As Rajat mentioned I'm using
>>>>>>>> chromebook - but not Atlas (Amberlake) - in this case it is Babymega
>>>>>>>> (Apollolake)  - I will try to load most recent kernel and give it a
>>>>>>>> try once again.
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> Lukasz
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>>      I have applied this patch on top of v5.19-rc7 (chromeos) and I'm
>>>>>>> still getting same results:
>>>>>>> https://gist.github.com/semihalf-majczak-lukasz/4b716704c21a3758d6711b2030ea34b9
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Lukasz
>>>>>>>
>>>>> Hi Vidya,
>>>>>
>>>>> Sorry for the long delay, I have retested your patch on top of
>>>>> linux-next/master (next-20220802) - the results for my device remain
>>>>> the same.
>>>>> Here are the logs (lspci -vvv before suspend, lspci -vvv after resume and dmesg)
>>>>> https://gist.github.com/semihalf-majczak-lukasz/c7bfd811359f23278034056a8002b3ef
>>>>> Let me know if you need any more logs and/or tests.
>>>>>
>>>>> Best regards,
>>>>> Lukasz
>>>>>
>>> Hi Vidya,
>>>
>>> After your last email, I've re-tested my setup and (without your
>>> patch)  the capability register also disappears - so it looks there is
>>> - in fact - some problem in my setup and your patch just brings it to
>>> the top as after resume tries to write to a register that is no longer
>>> present. I'm very sorry for the confusion here and I've not notice
>>> that at the very beginning.
>>>
>>> Best regards,
>>> Lukasz
>>>
