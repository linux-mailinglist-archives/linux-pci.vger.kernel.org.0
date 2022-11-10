Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7356238CC
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 02:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiKJB2M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 20:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiKJB2L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 20:28:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E48A22B19
        for <linux-pci@vger.kernel.org>; Wed,  9 Nov 2022 17:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668043690; x=1699579690;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0MPKzduHhdNi0rzDC6UrH2XfmgkgIBOjIqcpWXCRfCU=;
  b=T4l+HkD5hoOloPEURutSPz5bix3adgVHgzJ0J30aFS3aAyeGSQtrtFay
   SKE4C9paB++9UZT2EHkz02G7LMIjV3kU5tGB4fLHbgIqcfpzQ+p2LeT+G
   aO+tC82zS6kv7HU4Qt0ip1qe3RRdiIvdftRtNNHq7LQjKJNub/yajc5CH
   QUkQBOhA+Wyy1Ymfvtmx3M5/QFL5MQOc8h0RyFEgAKNbK6ktcYvVKS0bS
   ktoKQpfdz41zP22ihC2kg9jOUwr/Wh6duD3GDpRle56blusDjviY7eqa8
   R1IlZ4AlGXKcxIP7ThDG58lkqsGgeEcMACO48N7QZFS0I+Dpxdotpcocv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="309888789"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="309888789"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 17:28:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="882153693"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="882153693"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 09 Nov 2022 17:28:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 17:28:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 17:28:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 17:28:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 17:28:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW6VqsIR5SkeDtdwJ/+tJuZHoUgb2x8eyl1ARCGguid/m+7xHmZuVnPI3qYkdnBmOU5+zhFDXRUABN0MxzTGhcP1RslJt4XHc2bI9rkdxfua21NIrANC/P4fXs0DqUcKt3NoisZpJxrwCfScXYsYvlLjID96TyevhzA7GAZn76L7V1Mtv+PmPA4hR4Zg9tcujha0NERymUb6Ny3EdqBYuEcFLXT8kx9VAMp1Jv0eJ16vTgkD4e+DM7exyCQ68RhrvCjZm+4VFUYnR1HRyszwruF/5745W2U0aEQbpQxrTUi2cC+Hl8I3/eugxZg0PNgXu8RA4pX6Bi0F26kLdRdp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug/GEHiDotGQ7whNsjPGWV7ScIUKezjN1cKP+klus6c=;
 b=QenO9fnpCxUQyXComva6mTVr1WMWt5LK8ntyzHSvfYW82n9AIYx2coVVp8NT7W9CKN19juKtR6npv1kGApYoGmJKtiUJJgiQr4yqYlbV5o4jhceWPVJ9ZQAR2tt0NLu3ZCS/cW5AGNrCIn26I/xFRNZUmTUyoXavb0Fmh7m+OZMHWFNBkl53WbNT9eEM0rTt11bUfP2bjr1T47sk/flc/dSj9kFSYrrK5bHSsts0qdxosXjY/SHZk6Rtl5v4pTrMS0Oz62dwBOyyOE2KdA+10Fd4Zsx9cQ7qtaHHAOvUGz9wt9+J82y5LQ77hzOezZkPxn7j1jDsqooEhyX4WZWDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by SN7PR11MB7089.namprd11.prod.outlook.com (2603:10b6:806:298::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 01:28:02 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::7ac:fe96:566:65e]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::7ac:fe96:566:65e%3]) with mapi id 15.20.5813.012; Thu, 10 Nov 2022
 01:28:02 +0000
Message-ID: <4e83c0ea-6d40-f26a-5a30-29234c9d92a2@intel.com>
Date:   Thu, 10 Nov 2022 09:27:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/1] PCI/DOE: adjust data object length
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>, <linux-pci@vger.kernel.org>
References: <20221109175204.GA568218@bhelgaas>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <20221109175204.GA568218@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR11MB3956:EE_|SN7PR11MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e11581e-fdc4-4529-755d-08dac2baced2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zr0GrkEAWXEE8Ek4+2+KukVgOYPScVDXEwhnKkxx0GkS1uzmzqOf1HUDqb3fQzfwSyeGolg4vnfAfXSp+JD8qncBDwvlHMujnGU8r7ftW8YF2TabTJbaDT99HL4a9nqAsONqh1y6eQEcBC7/M3TlZItgeGUz+kquiWLDT+vps6UK/at7+a5UuWIUEvdJdbtGTVmnaMDJ+jfB4MY+xJsAud2ua0mRkE2iNScsA9QreUA8V001juktIz3VVzE1o6O6154vXBPkbmquc/jB8t/U0L60reS9NGAWhEKBaajnXuQ6HIugSR+jfT2I60KtqnkaDPUhG/4geQsFrmAq0bt5sh6yN5drmSDQfSgLIys+gIiFbuHaNciQHb07Gj600/Vf2zhrVuJ38r0x60Yiu6MBulLlnJ+5AgWWBMRXan/G5Fg4xiiLRrwl6skLkcyu+U/yAUmcBal/hkHjv7lguusO7ypnwddDJfktD4bbMfCzQKIMSiTuEEEyOoH8doxYXMamur6QA0Q8wNhU/8FqAej3lR8Yng6IkrIbgNr7pxlCIXOIfSJqfd+RjTQWXpvtDrb+2DRToPMaXgK8A7fNlF97qGyewyrTCpsPuYidiUHRiz30dIFyKM/QR5hDWdsWlcc8EmnLGkYmmXf2+IVOTG0AN1K81OFZKCvu6NZy7OcZlYbmncOGsJX8ssZ2RFGVUuWMo/tNNvwUaX0X5QMI6kuW/6TKX0KdWpx+b4R9EoSceJTpblY17vws9I0bqz4vecft3n+incBYCgHYYWqiVFJ/sI6AH3Lg7u1r6nUSOVbwoC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(478600001)(38100700002)(6486002)(36916002)(2906002)(82960400001)(2616005)(83380400001)(186003)(6666004)(26005)(6512007)(53546011)(36756003)(66556008)(66476007)(316002)(6506007)(4326008)(8676002)(31686004)(66946007)(86362001)(31696002)(8936002)(5660300002)(6916009)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmdNRHZKeDVaMFROTHdrdTNqTkM4Y1pMdmpGV2JiR200Q3E4NmhFSEZKTzZp?=
 =?utf-8?B?VTZuV1B1NFlRWHRxaGI3SFBvV2kzZlJNTFpyQmdnVEJ1QzJONnZNL3NEQ3hU?=
 =?utf-8?B?TGRNWlgxQXJjREZIRUdFbkJqb0FtNXA3M2k5T3N0bjZjMzJXMUFEdXFFclZz?=
 =?utf-8?B?RkdKOHVXSXpiT2tNb3NMMVBxL3I4M3ZxUWNjdy9YUG5IOWlheERDbEhSYmhs?=
 =?utf-8?B?TXJja0piaUpMQjMzYUVuYlJXWXVXYUFuMDdqMXVDNk5MaWpjeERrV2VkbTlh?=
 =?utf-8?B?MWE5L1crYTFiaDVJay8xOEU1eUVXRy9NejNGWDNOV0lPcTF5c3VhR24wanZx?=
 =?utf-8?B?ZXUwODdwTnlnMDZRQlFKdHN3ald1RGJ6TXdXRkltYmNIckFTMitxZWtLVnJK?=
 =?utf-8?B?a0E5eFR1RUFkQlV1S0hLYmlNV1NiZFE0UUFxcEF4clpNVVdyOE5hbFV1WTJt?=
 =?utf-8?B?TEZsdTJoUy9CRSs4MEhKaW5nMGtBUk5ZdnJ1a3AwNXRqZHVQSlhBVlVtbVcv?=
 =?utf-8?B?dTk2bzlxMm9sdm5zSDlBUFZmUTdQSmxGVEMyMnU4c1I5K0FVSytrL2FuZklS?=
 =?utf-8?B?SDI2THdOZEJWNWFJbzFIb1o1eUh0TkhremYyZGdaNG11ditGVW0ycGpxTS81?=
 =?utf-8?B?SzQwN2hRVWRVSHFQQ3FlWm9XbzBOdVZ2R3N0TUhsWEMwT0ZXVUY5b2h1RS9R?=
 =?utf-8?B?eE1JMlJWT3NBS1Z5K0xsS3JSYmJEaXhJUHNvUDdmeWlyeEluR1JMRTlOK3BP?=
 =?utf-8?B?Q1BIY2NTaUNJR0U4SmJQZ3hkSkxGOUpkcnAzTTRSbDN2UUE3blVZcnhKVG1S?=
 =?utf-8?B?cU4rSVdyYUpDdnIvWmtQTTJybnlISjFQMnhQRERhWll2OElxV1REdm9lMk44?=
 =?utf-8?B?WS95czBWWnVweE5kMGgyc3lGVjVRS1kwY3hnRGtwTW9QWHlhOTB2S1Eva0VK?=
 =?utf-8?B?WURLNk95QTRpVXpJUVQ4NmlDakg0VUlUSWdDaG5JYXhlUzd3bzZOY3pYRWEr?=
 =?utf-8?B?RDJPQjFucnhvV2E4bWpYMm1pQTFpZGFlcitDSWlha3JSMHdGeFA3ZjhzQVB3?=
 =?utf-8?B?VDRtSXRpWjUxUGxMUFVFRjVZL2l0a1N0YXVaMzZGSGgxQXk1QzBMc0EvenJE?=
 =?utf-8?B?dEZoVGdyTVBmZWFaMmV6NUczQ2prZFh3SUE0bGJUWStjOUJLQmpGSE1zdXd0?=
 =?utf-8?B?TnQ0RVUvNzlQZHBlcFBiYlRkY2Rqai8wZDJoNkFrMWxNUGtIbW9kYjJlSUg2?=
 =?utf-8?B?SUsxTkQyZXlGYjRvYTNDRVpScjB3d1FYdUs3T0hGbW4zUVlmZTFYVGZzamov?=
 =?utf-8?B?ak8vNTFxWG5Bcm0ycEtXbmY3OVYzdEdVOWJLczI1L1JsSjRnRTFkOGFNdE5I?=
 =?utf-8?B?eTZGZ2RPaTcyNFBDSEhzVGxlQWh1a1B0QWIvUnNLeVFzcmFMN0oyempjNU1O?=
 =?utf-8?B?TEIrZytod3lMUE9zNTdmeTZRMkJaUWpubzRwOFQySml2VmVIck1JTVNLcU51?=
 =?utf-8?B?aWRTRnMyM0cxUExKTE0zVkd0NjB4S01lb3ZBbEJaTFZKNGwwbXEwRklGcWVF?=
 =?utf-8?B?ci9YYlBlVkdBUWduWjVLVnhWdXZLRFNXd09oSlBEdUlIVUxWNTJQalF6cUlL?=
 =?utf-8?B?ZjJyK1l5bjVET1d0cDJjQnFSbytsZ0Z2TEpRODNyZWM3T3RVWWh4M1V2MlVW?=
 =?utf-8?B?ZmNCZDZxY3JQckJLU3AzSDg1aG4rY0VFRCtHblArdW9JcitBbklCbENHendv?=
 =?utf-8?B?cDE4TnR4WWg0YWFMNTZvSUdPUGhRWmJ5WHBTNks3RERuenBjSWFjbG5tUXRC?=
 =?utf-8?B?V3pWUVVpVG94VC9LQXBEQTY2UitBYWxwazhUUjlCSkZGMEpYa0dkOGJEZnRP?=
 =?utf-8?B?ZjMvUWIxOGNiZFQ0YjJVU0VxK3c5dklXY0dnM2VySVAwTlJmREN5SUhkZTl6?=
 =?utf-8?B?Mmt1Rk1ld3k4dXRtSnVKY3AvWTN4VUxmd1VrWkZqUURqazJCVG9PMXJINmVI?=
 =?utf-8?B?ZCtKKzBabXJSV1BWcFo2cUNrR1hnSlIrOVZvU0hZZkpXTk81UWhveWVyUVpP?=
 =?utf-8?B?dmFrQW00M2QzV3FMSU5zVU9VNjF2OGI2RnA4d1FDRTdra093VDF4bjhzNVlu?=
 =?utf-8?Q?OiEhTKoUE0k0LYfmd2aZ7IKiy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e11581e-fdc4-4529-755d-08dac2baced2
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 01:28:01.9544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQqDQHOdKJKmqpYo7N/ejyxEw+onue0j1zNkvavn+q7vfIJwPA2vyXRHuz1K3SCPC+LMJk9SlikvE5FNPfZ3Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7089
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/10/2022 1:52 AM, Bjorn Helgaas wrote:
> On Wed, Nov 09, 2022 at 10:20:44AM +0800, Li Ming wrote:
>> The value of data object length 0x0 indicates 2^18 dwords being
>> transferred, it is introduced in PCIe r6.0,sec 6.30.1. This patch
>> adjusts the value of data object length for the above case on both
>> sending side and receiving side.
>>
>> Besides, it is unnecessary to check whether length is greater than
>> SZ_1M while receiving a response data object, because length from LENGTH
>> field of data object header, max value is 2^18.
>>
>> Signed-off-by: Li Ming <ming4.li@intel.com>
>> ---
>>  drivers/pci/doe.c | 21 +++++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
>> index e402f05068a5..204cbc570f63 100644
>> --- a/drivers/pci/doe.c
>> +++ b/drivers/pci/doe.c
>> @@ -29,6 +29,9 @@
>>  #define PCI_DOE_FLAG_CANCEL	0
>>  #define PCI_DOE_FLAG_DEAD	1
>>  
>> +/* Max data object length is 2^18 dwords */
>> +#define PCI_DOE_MAX_LENGTH	(2 << 18)
> 
> 2 ^  18 == 262144
> 2 << 18 == 524288
> 
Thanks for your review, I will fix it in next version.

>>  /**
>>   * struct pci_doe_mb - State for a single DOE mailbox
>>   *
>> @@ -107,6 +110,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>>  {
>>  	struct pci_dev *pdev = doe_mb->pdev;
>>  	int offset = doe_mb->cap_offset;
>> +	u32 length;
>>  	u32 val;
>>  	int i;
>>  
>> @@ -128,10 +132,12 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>>  		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.type);
>>  	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
>>  	/* Length is 2 DW of header + length of payload in DW */
>> +	length = 2 + task->request_pl_sz / sizeof(u32);
>> +	if (length == PCI_DOE_MAX_LENGTH)
>> +		length = 0;
> 
> Do you check for overflow anywhere?  What if length is
> PCI_DOE_MAX_LENGTH + 1?
> 
>>  	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
>>  			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
>> -					  2 + task->request_pl_sz /
>> -						sizeof(u32)));
>> +					  length);
>>  	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
>>  		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
>>  				       task->request_pl[i]);
>> @@ -178,7 +184,10 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
>>  	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
>>  
>>  	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
>> -	if (length > SZ_1M || length < 2)
>> +	/* A value of 0x0 indicates max data object length */
>> +	if (!length)
>> +		length = PCI_DOE_MAX_LENGTH;
>> +	if (length < 2)
>>  		return -EIO;
>>  
>>  	/* First 2 dwords have already been read */
>> @@ -520,8 +529,12 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>>  	/*
>>  	 * DOE requests must be a whole number of DW and the response needs to
>>  	 * be big enough for at least 1 DW
>> +	 *
>> +	 * Max data object length is 1MB, and data object header occupies 8B,
>> +	 * thus request_pl_sz should not be greater than 1MB - 8B.
>>  	 */
>> -	if (task->request_pl_sz % sizeof(u32) ||
>> +	if (task->request_pl_sz > SZ_1M - 8 ||
>> +	    task->request_pl_sz % sizeof(u32) ||
> 
> Oh, I see, this looks like the check for overflow.  It would be nice
> if it were expressed in terms of PCI_DOE_MAX_LENGTH somehow.
> 
> It would also be nice, but maybe not practical, to have it closer to
> the FIELD_PREP above so it's more obvious that we never try to encode
> something too big.
> 
here is the beginning of a task, and starting to check task->request_pl_sz, so I put request_pl_sz overflow checking here.
do you mean that we keep task->request_pl_sz % sizeof(u32) here and move request_pl_sz overflow checking to closer to the FIELD_PREP above?

Thanks
Ming

>>  	    task->response_pl_sz < sizeof(u32))
>>  		return -EINVAL;
>>  
>> -- 
>> 2.25.1
>>
