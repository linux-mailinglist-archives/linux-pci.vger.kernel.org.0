Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA5567420A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 20:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjASTFL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 14:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjASTEv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 14:04:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671E895760;
        Thu, 19 Jan 2023 11:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674155043; x=1705691043;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YNxTqOLR8q/Uf0UIXFuf4J95hhqAsF9n4GTZ8Ulqwgo=;
  b=Kre2kR8l/KCWZ3PaNpNAoGk0B0rib/TOOhpLSwtEpUeRd74gFFoZREnO
   Lj3OhTBZtbV+RZ/aCix3D/PdyP3209OMtvMyRBfmqv9LWde33vsfnaT5r
   nqK7sX+gdST6ZD6dQf3aQ/rvKJqAKGVaMS2Ar2kzR6zWCNVu85owhWYG6
   FzR5UyLvVB0ymE1d8rmP7/Mk9HtrMAWm/iZw5qPt2dXthAjE8afyUiLL5
   gRY+4HYf3axqJfGefkp7PKH+PlfXhaMODcogynKXUBny6WAUASLuMfsm3
   J9L+d6LZBynLC6xWyos7PthZkxWjchBQOA+0wmk8dXBxuYHzWX6xrhlt4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="389903447"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="389903447"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 11:01:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="610172924"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="610172924"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2023 11:01:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 11:01:51 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 11:01:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 11:01:50 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 11:01:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ19hHKHABCTC/gMQzEuDerlTDjnrSgu7Vq2sohYsL+W++OqRpKrLGAVJBvr6ywjVrH84NhS2Ii3/tgoFJ0zwp1qE659fu6BSQZIKptnR8XWCssBqwaoGlhKkbgcF9LP5vjgXSu/0nGoNT1n31azvBmiP9E6L3eZFUKGlD5SmLs8/6gYma82o8M1nScYyZbDPOkFLVvcb6PHRnHFHn94bRcrdX2/DAd5d4wIr1tuSVWN3ZPCN5yDox234SDqtsbE0DhsKgXSEtWiUU2vHvj8J6M247cX03QXbgi3B/qu/Qwc7vwkuE2MeMA9EphAEGIsHKXbGNbvcNBTZnTba+6I4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lnGJ6X7AnGPBVCAYVa9rqh9Gx/n9DOggKwZEDGi/2w=;
 b=TOY9ra1lxFdhdk303KU1CG67tz2/qIJEP+4f635cCQcF3jPHtncysn0qMxpQNfps2n+LqXwOcolVkMHCumDJCRgyyqCKwRIcTqJjMn6wYVdR+9UwJq52RgM8jwl+vWj7i1spdVyZOIx+wEAeH8DFlCzFiC/5pBDdjRuK1cIZ99bmAh74DHti0vK7w6pifUxAFaF15xfvQ+yQEw7vG3cAZcpTeoVM6X/xreOZbvtlzXw/Sp/XcELk5+9YbVYRg25oPPwuLhlCb592xei6188bxIBxsETekgvnPDyWwmKEbdgzIsp2CW96SfKrM6aWhJADQXKiSBNt7ruKDl05yy2Gbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SN7PR11MB6797.namprd11.prod.outlook.com (2603:10b6:806:263::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 19:01:46 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3%4]) with mapi id 15.20.6002.026; Thu, 19 Jan 2023
 19:01:46 +0000
Message-ID: <3da4a67c-75e7-5100-dd8b-eee6a442a8c8@intel.com>
Date:   Thu, 19 Jan 2023 20:01:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V1] PCI/ASPM: Skip L1SS save/restore if not already
 enabled
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Vidya Sagar <vidyas@nvidia.com>
CC:     <bhelgaas@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <enriquezmark36@gmail.com>, <tasev.stefanoska@skynet.be>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20230119094913.20536-1-vidyas@nvidia.com>
 <CAAd53p5R9BHoYpHq6WNgwtUAXmvNQnk6gA=C27JTfqeozRKCzQ@mail.gmail.com>
Content-Language: en-US
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <CAAd53p5R9BHoYpHq6WNgwtUAXmvNQnk6gA=C27JTfqeozRKCzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|SN7PR11MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: c99d4e99-ea50-4856-5948-08dafa4f9c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVCJtRaPleVRiZumzmx1E1+/93m0TWQz8yUbv4jIAGqKJS6CHDdYjGyQAfDgkMibD6VF0Ltc42rbfmD0EpYY1ccYVyQO/qkXhcyDDDjmOb8ItXOUoQI4dzGdibvKtRP6J+yTsZjc9QFag050vjjAcKFkdFGNkymimI8KCjk407GCfwRl7vD+daldskfWT4gsOFmk2pdfNDQns/sM78My98+N2PuzmmnKySzJCX9iCVJgq7wgdagjhk9aIinmBixcOH35KhQxO8RISdccr9AILUpQPPk4J9h463Mv16IZ93qvwlpn3Zm9UKKhKCxKA/geY3g+tJFiSzZgauRypqOXEPMkthTtDxb6y9JZiqw9rLk2ZTXbp0fAFMyCExH9GAY5L+t0Qucuy8GZZ8/YpxxgZwYsflTh5U9xs3OUo6XczuC0BY9f60A99l7M3f4Wfr/viRfsoHSr0+mVZJlsZHEYsiHvjapxD4gzNiFauqOt1txtcU4i7g/pQZ7csudWfDBFCFpBaGOzP+Bj3+97ji0b96Pdv+JJAkqDuchRN3YN6IaR0bQv93P7zx5aEgumK3pkWXjNxllNQFSNPzcN1kdLpwYH/sSJz/enGMCmxnDKOMMkOuxykJJoAXAIksVu+aR0cUgIgXjZZHR/K0JRkyCo2w6XEF2+X0MVeDBIHXOS0mk9mTXErQTemAUWLOFiTfDDokF5FZDtwcQJA3X6FMayZm1ZMr8s1Qvs2V8BjDSAJpmHLGj5vyO0iyl6oThzIF8fGVaH28SljLaLvnM2KjF+tfROO3NIfZUtjihXM3oYYdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199015)(31686004)(4326008)(41300700001)(2616005)(66476007)(66946007)(26005)(66556008)(186003)(8676002)(6512007)(53546011)(31696002)(36756003)(5660300002)(83380400001)(82960400001)(478600001)(86362001)(8936002)(110136005)(316002)(38100700002)(6486002)(2906002)(6506007)(7416002)(966005)(6666004)(32563001)(45980500001)(43740500002)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWN5dkhIMWwyRlpXaXpkWXh6K01XNWRwbnducWFMakl5OXdzU2dQK0FZajE0?=
 =?utf-8?B?SjlrOEdiZVlwU2VsOFk0RlM1cEMxQ255aytUVEJBNnJZZmpramZKSHBid2lH?=
 =?utf-8?B?TzI5MzFOS0dLOVRDVktXNFplMW1IaUlYa21hU3FLS2lQamRqdENDNmNaTmhi?=
 =?utf-8?B?ODljNUpqOFVBUVoyeFJyalc5QzRyNUFoV1NMVkExSkNnb1Z3SXlWWi8rTlFE?=
 =?utf-8?B?YW5aaitrUVV2RDFYZGRDWGwrZFBaVkhvQjZvMDhKQVZKVCtTNFRYMkNJODZy?=
 =?utf-8?B?elE5SlpuWGNMYmtoR3ozcmxIUWk3SSt4UHd0ZVVsVE5STFpmSllISG0yR01m?=
 =?utf-8?B?bHJkN0VmbGVlczZTa0VkQU55WjNwWjdxQmRmSVlETEFBNWh0UzZHMGs1VDZw?=
 =?utf-8?B?UTRJVzJQcFpVZEtobGNybkt2TitWViswMmhWbWh0QUFxWWZvMDl6aC82VDlF?=
 =?utf-8?B?T3dVdjBibDdvUXpwUHA5MDlkRGxTQWhNK2ppMTEwcHZ5eXU0Q1ZYd1E1dTVL?=
 =?utf-8?B?TStDM1VQS2I1MW5rSjBXWWFMdjg1bEVkVmFYRnRVMFFLVXUzcVJJWVZZVjRo?=
 =?utf-8?B?WnZ5V1FZM1ZBcmpDUktFd3I1Zlo1SDBjUUUybTJLd1owaHMzRklQdWxPRGRo?=
 =?utf-8?B?bXo1cXRtZjNhU2FKQ0NWVUliN3VMOU5uNjZ6cXk4Q2hsdDZoM1cwU29jbkkz?=
 =?utf-8?B?a01Bb2E2aktXWTR1VFFsckFSM2hVU01GRklNWjcxRk1RVnFGUjFVSDRPQk5r?=
 =?utf-8?B?LzgzSHdsYUNSTm5SYU1zWC81dXVDRXluOGs0V2toYVNHTStTUFd0MFhJOVI1?=
 =?utf-8?B?emhHcU9odHJ3Ylk0UWdwSlJOTzI2SllLdFBrSWdqMDlIQjNCVno5V1QwQVJs?=
 =?utf-8?B?bzZMVTUzcWlWUEZlU0ZhMjFCejFXckJuUGhyNDB1MUZNcDlEeS9WOGdKYWp6?=
 =?utf-8?B?bDhaUVNRM1hmeUVNUks5VHc4eWRMSTZTQmxzcmoxbE14bWdUNW83UWpmcE5C?=
 =?utf-8?B?NytTMmNqZ2kwcGJSRUt4eW9hVy84QlVuek43UWVmZnNCQ2FMM2MxMnpjeGg1?=
 =?utf-8?B?b1c0ODk3dEFsZlgzNEdmbGwyblo3UWZjMDd6RTNUZXYzdDFlMStRemRsWTh3?=
 =?utf-8?B?Z24vakE0WGVDRzkwQkdiQm40a0l5UEVKeHVwYjVFOGQrL3Jkb1RNeTRZZldS?=
 =?utf-8?B?SXhnREhUR001T1dsUHF3NTBMUUwrc3ZMVmRaVytKb28zeTl0WDJHRlFVLzN6?=
 =?utf-8?B?bmZ0Tzd0RDR0a1JzdGJEdnVhcWpsNGdHMlIyeU1TNHhJU0hLOUhLaHhtVzB3?=
 =?utf-8?B?UEpPOCtwODhxbWFHTnFPQTI0OWt3VER6VDBET3F5RjBvSWNpUFV1YTA2VlNt?=
 =?utf-8?B?cGtBQi9HaTNTTXNSMGUvVTdiSmREMkk3dWtQS1U4bkpFL0dkNkcxY0ZTWXF2?=
 =?utf-8?B?UkhXdkhvUGZVbGRhRkY1Sng5eUI5RDlFRi9ZK0w3Ui9INHkvdGFTWlkvNlg1?=
 =?utf-8?B?bFZxdlVURXIwY2pjMVVkOGVCbndPT1B4dkxQRGV4UjJNazc0bEQzbGl3VnlM?=
 =?utf-8?B?Y0JXdEtmZkJlbVU0N25hOHJuc2t6eUdGOTNzV2ZaQ0o0TFJmd2VHZEZPVWs4?=
 =?utf-8?B?Q2txRW9adnY1eTMvWEREZGY1T0dOeHlqeHN0cDQ4WWVmUFNvN0ZoNnExWFN5?=
 =?utf-8?B?M2wycWw1cmo2dG5uRENRU3Y1ZUtmd1BHQVpqK0d2YXNmVW9EZ0NCSENDQTho?=
 =?utf-8?B?L0x4TmdKTnYyTVIvNHA2ZkRpZGlrK2xBSHBMVHNra2NuVHZDczkvM1dYR3dG?=
 =?utf-8?B?a0NVMzFSTnczZ1FiZGlOTG4vclMxRUovY0JITWlIV1BaZmJUR3RpcmxVcFlW?=
 =?utf-8?B?ZWpBSWVNa1RiZFhjbnNpU25zZXBUbHMrOUc5a3VvTmhZSW5vMWtRc3IrVjNt?=
 =?utf-8?B?SDA5emJLMDQ2cU5VZFhVZ2xTL2ZjL0FIa3d4aC8yVFdZbUFmQ0FBcnpod2M5?=
 =?utf-8?B?cFVBK1UxTHBpYjNNMmhtRUVYWmNyaG9DVTUralJoaDBLdTR2T2t1YklqY2Vz?=
 =?utf-8?B?dXdFeEhEaGVDTFp1cVMwaE9DeUxzamFkNzVZYkk0bDl0clBGdWlDV3RQelVu?=
 =?utf-8?B?YndKRmVHbTRIQiswQTBaUWw1U25VenJIQ2x3NmY0aFhWK2h3TVgvVnVvampK?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c99d4e99-ea50-4856-5948-08dafa4f9c79
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 19:01:46.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/hmKqFbmSkmsKtRRt0PN/XVtsbmHfcPyn+AiPnwP1Qv9iOYADeF95t47kBMpixlPtjjZDBOitk1X/4NxNmDRD0njoZj2LzHwGE26yXXgwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6797
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/19/2023 3:21 PM, Kai-Heng Feng wrote:
> Hi Vidya,
>
> On Thu, Jan 19, 2023 at 5:49 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>> Skip save and restore of ASPM L1 Sub-States specific registers if they
>> are not already enabled in the system. This is to avoid issues observed
>> on certain platforms during restoration process, particularly when
>> restoring the L1SS registers contents.
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216782
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/pcie/aspm.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 53a1fa306e1e..5d3f09b0a6a9 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -757,15 +757,29 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>>                                  PCI_L1SS_CTL1_L1SS_MASK, val);
>>   }
>>
>> +static bool skip_l1ss_restore;
> Maybe move it inside "struct pci_dev"?

Yes, it can be different for different devices, so it cannot be static IMV.


>> +
>>   void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>>   {
>>          struct pci_cap_saved_state *save_state;
>>          u16 l1ss = dev->l1ss;
>> -       u32 *cap;
>> +       u32 *cap, val;
>>
>>          if (!l1ss)
>>                  return;
>>
>> +       /*
>> +        * Skip save and restore of L1 Sub-States registers if they are not
>> +        * already enabled in the system
>> +        */
>> +       pci_read_config_dword(dev, l1ss + PCI_L1SS_CTL1, &val);
>> +       if (!(val & PCI_L1SS_CTL1_L1SS_MASK)) {
>> +               skip_l1ss_restore = 1;
>> +               return;
>> +       }
>> +
>> +       skip_l1ss_restore = 0;
>> +
>>          save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>>          if (!save_state)
>>                  return;
>> @@ -784,6 +798,9 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
>>          if (!l1ss)
>>                  return;
>>
>> +       if (skip_l1ss_restore)
>> +               return;
>> +
>>          save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>>          if (!save_state)
>>                  return;
>> --
>> 2.17.1
>>
