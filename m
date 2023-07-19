Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE9275A159
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 00:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjGSWGx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 18:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjGSWGv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 18:06:51 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377752108;
        Wed, 19 Jul 2023 15:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FR0IJQq7tblGWohrFjY14j6BEkhunbXZy2YixvNCZ4EwDydeb2JUWiCd9QnvxklGpR6UcOk6HdvG1C+pZuatQnJyVkkCGE0qE85LPkkWEnZuT9e+xvajOwoOb9K7+p8OwnYhUwzVgDX4zBgFvRpw1D+br92508XwCsE4P09qk9Uh/g7wHebO/+01mmMnBio5+Q53PDdOOYeRmFe369MWpMDSzvm0mPn+GgRQZ83vFG3r7IlXrINmNG+/RK7bgoBdE6wrah5q8gMwaB9rge3xXiJHQqH0B4lSDRc3BQadLoz3eZFJ/mraGKsgO926pKBZATlaKUoGJ5jCjjLKORv4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xd/0+D7UwBM59puAraPW4b/cbZC7n4MrFWC7DSVlqiU=;
 b=d+Y8hjyuTfvfnrtZW6Pcr51F3ecMrcXGf5iimvBNxk5UnAB39KysIJWWD14wwIJEgW1dIsi+C+3RTKIJuqZdGRfZWpctsa9H/2sieMm7yhC5XMyHLq7YxKjs8OUNbqrzqv1TXLGGiuaDZfL28am6wfY0WRyDVE36tqTWTalCzyS33zVxX19hfwQA7Apln2hHWkMJm+9kuQ3AQ4CoMFLOUkBu+CoAzWm8aYBueIgI3gle/zDLw8qZrRljfrwyP5JXeUCD2a52mun/nGQJPl1KfOpfN4emKYtmeUN2wHaUXbJ7FeiHzq7Vv82LhCQqrkWBUVUHcLdEzic/11WA5GDmiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xd/0+D7UwBM59puAraPW4b/cbZC7n4MrFWC7DSVlqiU=;
 b=F5yXaoPVTao4GOQArED6IRrKiu2oFmCoExEuioZdjmfo/ZiRYi82Do5jVzNaR0EH43TsBbn2EFORJmWrPeCeedJKoOqqiyVnf7oi0YMyr2u/xp7cgdfVocHSHn6+QhFdB7JpoR/ezZTUWzmEdOoYuv+X7uNTe/CtR2KVjT0V2fI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 22:06:37 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::642c:a4b0:ae3f:378b]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::642c:a4b0:ae3f:378b%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 22:06:37 +0000
Message-ID: <82c139c6-ab4c-9810-bbc6-84e6d19984a6@amd.com>
Date:   Wed, 19 Jul 2023 15:06:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] PCI, AER: Export and make pcie_aer_is_native() global
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        oohall@gmail.com, Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
References: <20230719203600.GA514279@bhelgaas>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230719203600.GA514279@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0037.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::17) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|DM4PR12MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c280af-d3d8-4610-9d07-08db88a46c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qjr+yMap/MAJwOO93pD7nSRtDC7A2+B7f1ktD2S+iRorttHyEzVIJprq4b8IW4WJkhRK5FrlW4erX8HGqWEzIqS+0bZiX3lpWdyylKWuohgMSQ4ZZCdDJvfkyR7b1e0R8QhCiunbZrzJd/anmHvWr9MuoZNNtb086B6bfm9k3XUYE/mhwfXJDulfrRhsUtc4DznPfGMsp9DbELBpgd+eONXBcdq0RPrKkKvchMhmi7bQd/LIVwf3+eySYhV9NrMioLdoFyF6S0NfRfzPP3A8pgnhA3nVaPpF76b//KgWe4XTx5rgYE6qRoax9AdwKNIJk2eKWMfX1ySQ9BwOjkCRHizrcZ5N2HvCIP2kfGVSyiC3xM8jbw73LFB2QhVA3Xi6WDCqwUBhEq1FaZO+AeNOlNRp96sL6ZEdLS91BlfjNDkBQoffGbjCaCwSgLt1MCGGXt6V5o2JS54pj5lzFSMDbHxO5Aty59ccQlbZ68HdoPDPeANIV/wJERo+Rl/yX7OiCosZJctn30qFXc/PSmHb+fa/74uE/HInYnWMvS/Y3qbPuea81ML03n4fknNa+pPLj9y490Cky3CtNFiR7XUZJsWfh7vl7ygBG3fY/fRZ6euG/5if9Kg0weaOUHy4j+KapZeceVFUqWDYq+ghnKl0fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(83380400001)(2616005)(478600001)(6666004)(186003)(31686004)(26005)(53546011)(6506007)(6512007)(8936002)(66476007)(66556008)(8676002)(41300700001)(316002)(2906002)(6916009)(4326008)(6486002)(86362001)(38100700002)(36756003)(54906003)(7416002)(66946007)(31696002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW1BZStGLzNxRUVZbzN2TkwyNnpnSnl2Y1dBbUdCaC9ZUWtXY2VNWlVUTGtq?=
 =?utf-8?B?YzREajhjS2JqdDNVZmNJTVRUYmlYU25FblNHR0NObkQ4RzFNWjU2UTc3eDR5?=
 =?utf-8?B?M1FTM09WSnVld09sTjlzWE5uK2JhTzcwR0NNVFdhTHFlUDdJY2QxejNBWHpE?=
 =?utf-8?B?RDdqUG5lSjRGckJnSVhydFI3RExwcjY1YTFHamQ3ZDVWV1N2K1Y2T0RkMHRv?=
 =?utf-8?B?MFRoQldYNEw1YzZkeDBwMmhJU1RRS1BjTXZHRDBKMXdqTXJYZFJDTC93RHkx?=
 =?utf-8?B?L3ZUaXZyeDZFZmJwUW9hMzNnZG9tdWlRQm9hMHQ4bTRWNng1MlpMZ2R3Z1B2?=
 =?utf-8?B?dUNXeTNKM3ZDTTNteXh0NXM0YjdRcU1KRmVpWWgvK2EzTmxCRm51dDhTbEdu?=
 =?utf-8?B?amc3WFIvWmNlN2IyeVhBamVkME9tb1dFZUJEMkx0T2JTVWtrYjVlamx0M3hO?=
 =?utf-8?B?dUZwQXFzTjI4K2drWW1zUjRpOUpQSDRHS25sQWsxZkh6MllLZTI5N1BubUZU?=
 =?utf-8?B?UFRhcEZXRGNIQjQ3ODNobE1ac2pRdGhBNUJ0cGtEVEcyZ1ZxY2QzNkcxZTRK?=
 =?utf-8?B?d05qN1NSNGVlWmNxV0dyaENPb1BmWkdOa1hHYlhQL0xFazlJbGw4TmF0V1kv?=
 =?utf-8?B?dE9OTk5NNVVhWjY0bHQ0Ym9XWVZGQzBKVVVNNjJoWEgySThzQjY2Mm0zNVNh?=
 =?utf-8?B?MmJFZXNCK1JaenFNUmRrQzJYM0ZBcWJBbVVQNW40Rm5CaUJ4QXdaR1NXc2hL?=
 =?utf-8?B?M21qcUJEYndtOVFUT0hQQ29naU5wVVZjcUpZR3kxYXA0YWF5bTBuS290UTNC?=
 =?utf-8?B?V2U0WXdJTmtrRU9ib1NtNVA0VFRaQjU1ODRTT3VSeDJEMWorck1LdFQ4QTlB?=
 =?utf-8?B?d0g3NjhjTTRhb0JCTk5ndDRqMHVjY1dUSjVCWUZ3OUNNR0kyYjE4U2ZNd1lS?=
 =?utf-8?B?eVVVR2F5dUUweTdncmdhbTkrMGIvZitzKyt3czJGOUJoMUowd3kvdmlyVnN0?=
 =?utf-8?B?akxHVElkMng1YnlHTVhYNUdOYkVrUkd1VDBIVkJzUkw3em9hbVd4cFc3dENX?=
 =?utf-8?B?dTk4dTFHZXFvaFRsUXQvNjlOa2lhYkRaUE9tVE8vcFdQTTdhVHNoWmZjZ0Qz?=
 =?utf-8?B?bjZhZ1pQc25FRkhoNDhrMU42Yjl6ejhEUmt2bWJFTmNmMWlMejViZEdDV2Ew?=
 =?utf-8?B?ZTJiYncvMDRLR0Z0VWkweHRscVNuY2xMazI5TVpYNnVieDl4MEFlWFdabmc4?=
 =?utf-8?B?cGhoNW5WeklmYnArUmc0QkNhM2V2S1ZqdGN2NzhEMTcvVDNpQmtJMEN6ZkYw?=
 =?utf-8?B?MElRWS84S2I0TmlJcVhRMWg1RDhjUjJQb08yejRxNFdyY1g0UG1ldzBIT3BN?=
 =?utf-8?B?RDJ1MzFRd3l0TVNsSVJwVnFsQ0ZVZ1ZmK3VlS3lTNGIvbmNJRnFpUjE3Z3hJ?=
 =?utf-8?B?MHE1YlBLbWRZWjJIWkVKL3F2aVZhNnpNdVVtWlVWZmp1ajZMUm41eDhmcm1k?=
 =?utf-8?B?bjFlQ1pTMFVuaXliYkFPTFMvSy9LdDAwSDZieVZZYndFSjRjcUlmNUhCRzUx?=
 =?utf-8?B?ZjZWS2IyViszeVludW0yTzJRY25uTzJyUURZSVBtN3RwNzV5blNJSEQ4TWtN?=
 =?utf-8?B?SnpHWDdocml6SCtaU3VIRlpyVHR5cms5YUlMdDN1K0lmVEQwR2ZyVko3MmJC?=
 =?utf-8?B?a3p0cnBudHFRMVdPNEtQd1dHSmVGRHZWUmpjcFE5d0RjWFZTRFVaNzhvUU9Y?=
 =?utf-8?B?dVVhejdEODNtWURLSUdDWW9vbldPZ2JidFh4YjNLOWtaMFFzVU9UbFlYaXla?=
 =?utf-8?B?cWlMVzFWWTI1ZGU1eG9GMTE4OTZ6Y09GNHB2ZnR3bFBwOFV0bm5mekpCcWZK?=
 =?utf-8?B?Y0lEOUR0cE9kTXZ4d2hJVkp2QTF4cGpGcWQyS21ObmhEL3Q2WEtMbjZQNmRG?=
 =?utf-8?B?Z0VMcDM5dC9tL2M2bjA2bHZjb0NmM09UMzk0MFRpNGZZWHVsM3RNYU5hZXRh?=
 =?utf-8?B?Vk8rTmVhOVN6Z2xyT2hMM3pvM0ZVQUxndmpaZXl4cWpSNG15SWFqcHB3VnpS?=
 =?utf-8?B?Skwxb2dlekp6b0lSdnl4V2pCQTFCSHI5b3FlNmh4cDVUaUlra016TGE0LzNS?=
 =?utf-8?Q?c1NaF1rN4We3bIUJjFtrOs78t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c280af-d3d8-4610-9d07-08db88a46c43
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 22:06:37.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdV8ikVjE9WHVLpKnxjs3iAf/UJ3O92cqruT2jsMNF1GxogDGsmpgaX16JgYlGrwcZBAKliiYu2CBe8O4YYOUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/19/2023 1:36 PM, Bjorn Helgaas wrote:
> On Wed, Jul 19, 2023 at 07:23:12PM +0000, Smita Koralahalli wrote:
>> Export and move the declaration of pcie_aer_is_native() to a common header
>> file to be reused by cxl/pci module.
> 
> Run "git log --oneline drivers/pci/pcie/aer.c" and format your subject
> line to match.
> 
> "Exporting" pretty much means making it global, so "Export
> pcie_aer_is_native()" is probably enough.
> 
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> With the above,

Will make the above two changes in v2. Thanks for the review!

Thanks,
Smita

> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
>> ---
>>   drivers/pci/pcie/aer.c     | 1 +
>>   drivers/pci/pcie/portdrv.h | 2 --
>>   include/linux/aer.h        | 2 ++
>>   3 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index f6c24ded134c..87d90dbda023 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -229,6 +229,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
>>   
>>   	return pcie_ports_native || host->native_aer;
>>   }
>> +EXPORT_SYMBOL_GPL(pcie_aer_is_native);
>>   
>>   int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>>   {
>> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
>> index 58a2b1a1cae4..1f3803bde7ee 100644
>> --- a/drivers/pci/pcie/portdrv.h
>> +++ b/drivers/pci/pcie/portdrv.h
>> @@ -29,10 +29,8 @@ extern bool pcie_ports_dpc_native;
>>   
>>   #ifdef CONFIG_PCIEAER
>>   int pcie_aer_init(void);
>> -int pcie_aer_is_native(struct pci_dev *dev);
>>   #else
>>   static inline int pcie_aer_init(void) { return 0; }
>> -static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>   #endif
>>   
>>   #ifdef CONFIG_HOTPLUG_PCI_PCIE
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 3a3ab05e13fd..94ce49a5f8d5 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -45,6 +45,7 @@ struct aer_capability_regs {
>>   int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>>   int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>>   int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>> +int pcie_aer_is_native(struct pci_dev *dev);
>>   #else
>>   static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>>   {
>> @@ -58,6 +59,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>   {
>>   	return -EINVAL;
>>   }
>> +static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>   #endif
>>   
>>   void cper_print_aer(struct pci_dev *dev, int aer_severity,
>> -- 
>> 2.17.1
>>

