Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940FB640FD5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 22:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiLBVRR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 16:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLBVRP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 16:17:15 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF48ED685;
        Fri,  2 Dec 2022 13:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670015834; x=1701551834;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Te0g8eEUt+Dfk8CbUnKP72XS7+Cz0GVTdoqF+zg0orQ=;
  b=HeUvY3kiM2K5ubBMIpsQKK2SzUIi9d/VuZgnNv5Z8FtuKSivn69WUtO2
   YgwUmLyJOyD5NyKCt9t0TIPyzaElUFjIU9O2sKgcHwQaGKAZ3NL5pypEI
   VS8O5WMEjPhtynyeoJANOmQjoy3Cis9qupoAwulChNuUCS5t9c8mw7S+2
   jfzN6kQeqCP0xLaMWVobAyyi9NAffTlP5jg/yEYMe+4TfhStvgqirQMBo
   IMyXGsIHqMX0LwChFJLIIjwRXgA4nUmY6RaObR1lYLzPfJCp6cXSoz+KY
   N/qobAHlPUhCjnNzltyOwd2ILydYGig2P/Ar42vxUVHVtXM+CrvatGxZC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="378202834"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="378202834"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:17:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="751416024"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="751416024"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2022 13:17:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 13:16:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 13:16:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 13:16:59 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 13:16:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RK9yyf1oLWWPOq9UVEeGdi9pHesqHczJ9IbiDiN8KhA0qKS3UlXwGtlxdGBCjxll2GDLmnfoXtwhhLt1Gl8iu7Zvx2tK4hEqWSILox0VFh5Qqxppw4V8pHcQp3eLMDi+2y7GjNadhWCvodthepApeJN4tvBlVwbFJR80dIsYSTzfzRHCK4gaDiRxatEBpN4+Mq6bfj44PPbtW8s18M5Opgf8mtYQgeouml1O2J8vnWODpQbKHdZ/dXH3kjkLh/bcsrb9Ry/R79UekMLlYAcYjVv97g8CqQC0VOoyXNiHq4biOsO1UKsCv836XtfGncxVs7yQkHv8xedAsha+wxI0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPY7nlSz52ylchh+qwvH+K/8Dv8oGpceC+/pZb5ET3w=;
 b=ltEq2rslim4MVSzNT3P6cQ4q2Usyq2HjGWpfEiV9cRRPEeZUMRS96otbveg4749S5c01lrc8h4ZgcPT9CN1vFkEXnwJlIldgPAYc9RisZJUlJu7q9N44Fupbd8VrMP6l8Wpa5TN84JWOC1RUHlKNigKwGVXcg+h39a9NL8Ki2UeOJiWCdSDzcEdmsBZhYiFCcZBsHDl66uorINBmBbwC6dbakzMMYP7BqbJBs7n2nrZDIUdu+3qT2vj1CEEEdI8z752NvBnssDjuZymrDMziiLYzlYUN9ShV86msKJ1JwcjS+s4tYfFVJOIMRSFaeFqzB6zrOzaTjsi0p8FsuTymwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 21:16:50 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9%12]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 21:16:50 +0000
Message-ID: <d85d91f2-25e7-f706-094b-56c417becf1c@intel.com>
Date:   Fri, 2 Dec 2022 13:16:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [patch 33/33] irqchip: Add IDXD Interrupt Message Store driver
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Marc Zyngier" <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>
References: <20221111133158.196269823@linutronix.de>
 <20221111135207.141746268@linutronix.de>
 <4a15c569-0545-20ac-e74c-ae17f7eb067d@intel.com> <87sfhxoa7i.ffs@tglx>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <87sfhxoa7i.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::19) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5276:EE_
X-MS-Office365-Filtering-Correlation-Id: 8739833d-3f2f-4e99-5734-08dad4aa8736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLLoZ3N0ID+uO3Md83gmMzV4vybutKDpR6BWYTrr8Be26gA7U9a7kDlisPLT8Vo0VwwX8yUjjHiDWXEcJdvYN19zvvkUYg6Ywcar7y6kLtMEncu9E/Kr/SwFwKLgjDbatnlAVlYrGHCaYNulkuEld5k+/NzpJskNwYB2nAsrPJ5m144AA4ILxGomRb9KLEtXUqrlttbzW1yI3U4n/cd8Drp+dVbVfLQKaXKy7AfrecCIREb3+Gx8hkp075vfIXv7QJu7QWjn0if6j/bq7Pd5JtcJe6ADyRoPj1EglmaKarxFxxzQ6gLA0+l1Na6T3Fe00GZHDchkgxrev5tOv2njyqxHFuJIbT9MchQYVJe6EBfNteKbRYAr4lA3KdI4z5SaWK9i+P0gDek5MkDBhG/ZjMG6lzSNo5lKanRo96PhJGJaMY+PV2D1OH0m9TY2nuAxcI9ERt6XG8s3ANs81lKL1MDL4nJxhc8k5hKEqdha160VM6WBF/Fw1H2sFHNfES2bbkl7oTKPnFJZ1hYXMMkLMXLix9X7gq0TwNs7eCQeUoQdiOm9wSF3WmssTBjsj6A4eXOzGYQtU1JxElO+QlkNOWExNIoMJTlH79pKxwQsTFS0AvTW0nhywk65AX3/hh0kAZUxiKIEV6xYmfy7IUAGhxgdkF16gxEWNvqvLzwovXpsAvMy6fqDHT8tO/p2khgJbH0oaGwcL1f8uG2z/eviXB2VCqLUiBQXtsFG8M2gyRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(66556008)(82960400001)(31686004)(36756003)(2616005)(38100700002)(86362001)(2906002)(7416002)(4326008)(41300700001)(44832011)(83380400001)(31696002)(6486002)(54906003)(66946007)(478600001)(110136005)(316002)(66476007)(186003)(5660300002)(26005)(53546011)(6666004)(6512007)(6506007)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1BWMlBjUUxkR2had1dxUkpmRHdrL2xJNjdyN2dCdlRZbDhmeHAwdjJlMHRp?=
 =?utf-8?B?eUhSRUZ0cGkrbHZIZHIxYitVUCtMc2pIaVJNK1I0eTFZbUFvUHByR25jcTVU?=
 =?utf-8?B?RnlJRkc0Rml4KzRrL3BqNTRQY2dSL0Y2Rmt3Q3RWZ2FmQncrVFZPeHBSQld6?=
 =?utf-8?B?Y051NHAvNUpSdFUzOU1oUVU0T3JmMmRQK3JhTHUyb1BmUm1KYjlEVEpGMGFy?=
 =?utf-8?B?OTVIWW1BdGhhRGlqMUJtclVhNHFNL1pPeGRsWlJ2dVVWcG51eUdmbUNyUng0?=
 =?utf-8?B?UXEyWmQvd0gvY3VpRDVNbFF5L2tGcTI1OWxTNklPaVIvdGw0ZCtmdnpUbENq?=
 =?utf-8?B?Q2JneVlqSWZxVEpTOE04OVVlZ2N2dUJhM1MySEVTZDhNQnFhblVXY1Vqc1pz?=
 =?utf-8?B?U1ZCQlcxTUZ6dTg2TkNsZHltWmgybUFFdEVnUUUrV09WdFJiMGJlcjIvK3RZ?=
 =?utf-8?B?UlZ2MUVYc2dxSUtVWjZ3ZkNPV2o4VXZyc3pSSnhjRk5uUVVzMFc0ZkNBNnJZ?=
 =?utf-8?B?cngxVmw2M05HTzZ3Z2FJaVVFTHlVL0pISTZBUjhVUE43OFBuRzNtWmJ1NUFL?=
 =?utf-8?B?YU16cU5xVlRmSDI5WU1wZnEwWDJUaDR3R09MTmRyM3hvd1dUTytLNWQxQWp1?=
 =?utf-8?B?Z0F4VE40NVREaCt0MERoR2dVVkxRMGthR3ZUUERPSnBKTUFoM29jWDBOYmU4?=
 =?utf-8?B?ZDJSeUNHUmU1M0NtVVcrc2RKWWJIeUlTK1l3K0FjZzk3SGxqMGdVMFYraWti?=
 =?utf-8?B?akRoUGN3clRxR3JKUTA0WVFEaXJ3Q1dTMFVwQWVRNWdKQUJab25wVDBsTmxR?=
 =?utf-8?B?WXJ6YkpodkVXS1ZiRmh2cy9RYllrdWJudCs1enYvanVsVEdKZEtKRTR3YStu?=
 =?utf-8?B?S0l6V1JLano0a256c0RtQ3lvREdMZ21YdTFUcHJIcGxLMUlDRWxDd1JDdHRt?=
 =?utf-8?B?RzJRQU00SGxQZTFzNU4yY1pURnBhTVhHNzZkWmdBYUJscTl6NlVhdzFXcklY?=
 =?utf-8?B?bHZoMm16ZDBzSzJIWEN2Nmt4V0VJUjVYM3ZheWZnTTZjUGZIeVNGamExWHhn?=
 =?utf-8?B?M0N5WlBOMGlwYVpyQ1lQUG1KdVpuM3VoYjRqWTNDVGVaeXJKWU42SHM0amg1?=
 =?utf-8?B?UVVDRVhRemt1K0psNGk2ZXByQWk2WnVqSkh3eHlQQWdaUFhOZ3c5d3VPSTVZ?=
 =?utf-8?B?aVJuamJ2WXY1UndtOXJUWHpsbWdOUWFkWldyc2pGR0hYVWlxWWxBT0xxRHQz?=
 =?utf-8?B?Mjl4U2MzUUpVbDk1YzV1ZndXUEhqVjVnU1dnb1NnajYxQ2ZORStNVUcyb3Za?=
 =?utf-8?B?K2c4c3lScXc2WFZuWDhxQnQrVDRleER3SlRnL2Z3VS9DdkZPd2tLNS9EdllJ?=
 =?utf-8?B?WDdRTEVJZFRsMVlzMnFSTnlzN3RERStrWGZ3enJnOVczOXJ5M3BIbkdYck95?=
 =?utf-8?B?V3JlZGxyektnWldFVFBjMSt1bDdtOVI4cnFXVytWbTFSK3l0OUFDMS9hTTY4?=
 =?utf-8?B?Nkx2UDF2WDc1Yld4V2t5bEwrVXNEenA3UExvL3pvWWFIMDJTWFVFTWpsU3ZX?=
 =?utf-8?B?K1hrdzRPMGVGbHlyaWZHdWRBZStQcnR4UUU1c2FTM2hzTVdSQmltWTR0U2dM?=
 =?utf-8?B?bmxjclk3V3dxZ2Z0N0wySXF2UG9Ha1FKdU1UWUpWTHExL2hDVVYyV3Y2ODZP?=
 =?utf-8?B?eUJ0TExxUjFzaW9GZVlubWdKOE1uaEs1QkYyL0ZOSmI2aU81cWY0ek1Ma0Jl?=
 =?utf-8?B?TlhjRFNNMklhY1ljWXB0eW5FUUppUk1UMWtzSXhMVzBhUzloZ0pKckU1MU4z?=
 =?utf-8?B?WmpmMGFkN2FEUDdTR2dSUmV1aENRaTlCT2daT0puWTdpTFY0VS9peS9ucC9j?=
 =?utf-8?B?bTJNVDdPRnlUN1ozZFM0am9ob2tQTmNLMHBJLy9zU1FQY0Y2TE1ob2E4YnR2?=
 =?utf-8?B?QVBkQnFlbGh5YnQ1cWcvOGpEYVgvWnRmZTdmVWtjODV3WGhkc1k1bjZ0dlZj?=
 =?utf-8?B?Y3JBR0VQemh1M0ZTNEkrenBheVdWNE4zaFVsNUhJS3NvK05maXNjUWpxQVRE?=
 =?utf-8?B?dnNUSXFGckJzZUJWMkI2bkk1ZkhVUW1XSGhGOEtrTVRramFlQVRUMXF2Y3Vz?=
 =?utf-8?B?OVZFYUVVbG9PN2dMOHVkTS81WnRXTEs4a0RGdHhZbk5Vb2JhRk1za1VRTkdT?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8739833d-3f2f-4e99-5734-08dad4aa8736
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 21:16:50.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FO4DhAa3gr3ZvAR99N/5H2JVPlYbjPQxiyy7ZzEmS5fZ5JRtakn/DwBpD67/vXZPIhtnDodgd6q/frCYdX7BbCUzagF5Mg+X0atcIJjoTME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5276
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 12/2/2022 11:51 AM, Thomas Gleixner wrote:
> On Fri, Dec 02 2022 at 09:55, Reinette Chatre wrote:
>> On 11/11/2022 5:59 AM, Thomas Gleixner wrote:

>> @@ -33,6 +34,8 @@ struct ims_slot {
>>  #define CTRL_PASID_ENABLE	BIT(3)
>>  /* Position of PASID.LSB in the control word */
>>  #define CTRL_PASID_SHIFT	12
>> +/* Valid PASID is 20 bits */
>> +#define CTRL_PASID_VALID	GENMASK(19, 0)
>>  
>>  static inline void iowrite32_and_flush(u32 value, void __iomem *addr)
>>  {
>> @@ -93,12 +96,17 @@ static void idxd_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
>>  	/* Mask the interrupt for paranoia sake */
>>  	iowrite32_and_flush(CTRL_VECTOR_MASKBIT, &slot->ctrl);
>>  
>> -	/*
>> -	 * The caller provided PASID. Shift it to the proper position
>> -	 * and set the PASID enable bit.
>> -	 */
>> -	desc->data.icookie.value <<= CTRL_PASID_SHIFT;
>> -	desc->data.icookie.value |= CTRL_PASID_ENABLE;
>> +	if (pasid_valid((ioasid_t)desc->data.icookie.value)) {
>> +		/*
>> +		 * The caller provided PASID. Shift it to the proper position
>> +		 * and set the PASID enable bit.
>> +		 */
>> +		desc->data.icookie.value &= CTRL_PASID_VALID;
>> +		desc->data.icookie.value <<= CTRL_PASID_SHIFT;
>> +		desc->data.icookie.value |= CTRL_PASID_ENABLE;
>> +	} else {
>> +		desc->data.icookie.value = 0;
>> +	}
> 
> Looks about right. But that needs some sanity measures at the call sites
> so that we don't end up with an invalid PASID in cases where a valid
> PASID is truly required.

I will take a closer look at this. Current call site is explicit to
set an invalid PASID when PASID use is disabled. I still need to do testing
with valid PASID to learn those flows.

Reinette
