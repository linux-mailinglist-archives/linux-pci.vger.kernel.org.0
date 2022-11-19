Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEDC630852
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 02:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKSBVW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 20:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiKSBVE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 20:21:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D561CB70DB;
        Fri, 18 Nov 2022 16:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668817167; x=1700353167;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J9ARme1WP0jdLZ7gcQj43odxYEHcKi8nSczjWLAOjCo=;
  b=jfTEeXCxHRbulwqObHgLDcNbr/I05Hx53z3Ypgrf7qf9m9NHikn46wfX
   2U+7+dz0BVVC8CiEQEAbw/mhiJWzsgvMq71jXEp12u3aYNBRwttezwh5B
   YHmw1FG0+0Tac8qcXM48NV2I/cYaSkNBQ+LX+NASoUfwOBeW6xOl7LlnR
   zYs5U5SwwlybGBMlCFEo5b2y3emh013sT60P0j0ZPbdvuRzfFTaTzhS1l
   P5u1aFfBtk1bJMVO+y+D5LQ45ss7R4XUM0qN9Vzxew2ZkjFI0m5dNATH9
   am2cn1Z0bEd1oKdcXuCeaaJ96f1n5zDGemXMYE9lXG7VQM7nCgGguz8C5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="313297380"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="313297380"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 16:19:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="640400657"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="640400657"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2022 16:19:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:19:26 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 16:19:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 16:19:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyKQMDqWCcZEm6digBSiTtGZ+8BnqwTKCcxszmnbr4Q+YuW3XozLzNxI/IfIWk72mTdONF9ArLvdckd5fDH6jFIhZPDe96MJ6xXvrt2xgcWo4yFhANW66g07DVHCU+luzLn9rFZs7ZfkuEDNDaGeGsm2utw/TpJJvh2fy9h35+lTSYlmSd6hc0MRmviGZXHb90S63LTJbqP8PKNN8ZgyzWi3PoEdeHroXecqr1uzmKZs6oac5/alVr0Hoywx3yuOVSzgkwL6zn7HUQCysFHX+vl+GjpfOLp/qQ5wy/i9uLZ8VDuACBN+ZGrGqyOXOoHuO98cfOL5wY4ffLcQg0NtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQjRdTR2nbxfO5kDvBBJPYrdv3gPH8OL152cIrGzkl0=;
 b=j/RQhl8d+d5AuvCQRgYypboZnmclj++oYtwENlojbcurfhvIqDU0yNHkquA4tuBQqrBow5WAqfX+thLnussgYXxXralg0tX+tJYGOQM/f3mNFlk2UcIwP5FxYQn86CXauGWGgnx1vwoCug7XU4g/B0/gOB9GJtmUB+rRvHZnc1csHh3LcYz7RadhbRfzS4HsGwIKKfj6gRHxgrZzKz5lrI1Wx8sRguJhj1VTLOWPwOgqvtoXIBbjnockefQ5fEJn87ss4KoQRFWuFpsDYwWSwkWjiXNyuCTxTh3nyRV8mk0cYY21cnR6f02DmTpDQ9PC5mBJT67VjJ4J3LwlI9wSmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW3PR11MB4698.namprd11.prod.outlook.com (2603:10b6:303:5a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 00:19:19 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5813.020; Sat, 19 Nov
 2022 00:19:19 +0000
Message-ID: <9df48e3d-a4b3-58ef-ab2d-9c4ac931cee8@intel.com>
Date:   Fri, 18 Nov 2022 16:19:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [patch 21/33] genirq/msi: Provide msi_domain_alloc_irq_at()
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
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
 <20221111135206.463650635@linutronix.de>
 <0cbf645b-b23a-6c85-4389-bb039a677a52@intel.com> <87k03tkrii.ffs@tglx>
 <87zgcok4i2.ffs@tglx> <87wn7sjzeq.ffs@tglx>
 <d33e63f0-a5ba-38d3-1cfb-dd5ab8d249b8@intel.com> <87y1s7j3o4.ffs@tglx>
 <36615cba-4429-a493-a533-d7dc0bc46056@intel.com>
In-Reply-To: <36615cba-4429-a493-a533-d7dc0bc46056@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW3PR11MB4698:EE_
X-MS-Office365-Filtering-Correlation-Id: a37e0de4-21c9-48c7-b631-08dac9c3b29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5HosguvqJ38G5SeW9flL4H3IA8DJTBWF9WQwIfi7gasCts42oH2bIXozEFUDZhzEzjFvO0r9kz90k7IUMlFovEQKqQd0QCnr39F6G0C3akNXUrCPJc4PgZFtpL2IKCof8Ssiyoll2Lc7aByysHoGRFyHjnw8HfCzNxsm0+KAFJRLBybMdyGK/ZogfSZzR9Y5jpLvYbg9ItjEZzUC629Y7pO8L0EBhOcoEMgMTm+VIQSr+kBsngVtU50S8sfCX70i59ENZEjc9BIdx7aRhaHZI61I6tlk6Rm2dE8IoQ0DB14YCX0EJOinmUTvIJHUP9YiyuCC/mtyBIBYv62LKbYvpeCrVzk+ois7u/V7wcQ1b4KH8PAygpoADPbQnKHJtpVbOIs93eK33lOBODDyOxmNxE/ut5Vml/7OB6NJeKxuw69Z9IrIBX0mHtmPxqWI/upCGI9wMUytoTElUK0D00gKfmnfvBt/3HjUtO7tz0TzkuN3mjWr9bpySxct0tdPHi5Hk1Cre58JUJeegjdwn2nrTU+X84tjLOYTTBhyf0D54fa3u+h8za9djj9+9+DMPYa8SVv+5JitaCIloGwUsYndKwQZbpwPQmxBwmoH9BZEIDjAUyxa/73IENUQ5QoZdS/LBe1Q7Emrhp9ZxgAOapHzI2gFYCylHjwk5bc4rgpbxYoCTSiBAmSkemxyp3n4weVXW7uzC9wsLymYmfkRn5X8wKRXjE+iAgoaytlh2SIVUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(6666004)(6506007)(316002)(6512007)(54906003)(26005)(110136005)(53546011)(31686004)(41300700001)(7416002)(2616005)(66556008)(186003)(66476007)(8676002)(4326008)(66946007)(8936002)(6486002)(5660300002)(44832011)(478600001)(4744005)(2906002)(31696002)(86362001)(36756003)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnV5OUZHWWxKclpWZ1F0TDI3SmROQTRrT3ptTUhEYlFrcnZsOUJqUFEwaFRy?=
 =?utf-8?B?Ky9xRENHMEFHeVhqUTlCOHFGVkI3WlE5K0VGV0cyT2RZWnYvNEVqL0VYdjBN?=
 =?utf-8?B?N3VVb3J0b1ZMRk5RcmlNeFlxVWo5MU1JVGNvcGVWQ2lqTFZ5NXkvWmNFRlBH?=
 =?utf-8?B?OWlnZGZCZjExM0J6SVJUZzlKazBBaHNiK3VlNmNVNmtXOG5XeDhad1d1NG16?=
 =?utf-8?B?VkR5YzlNZGNMcVdPdDFySHVBSjh6WnFEZHplTVlteHpMSFpkWFljUkxZalRu?=
 =?utf-8?B?S2lyWnZ6VGN5MnI1clRyTmJ1M3d5N05jZTdndzZPVzd4a0svUjJTRm01TTEw?=
 =?utf-8?B?c2dLS0UySld2YnNrMGRDY0xaaXUrdG1vWmo4OUZMcWZVTVhiT3E2NVBWTWoz?=
 =?utf-8?B?dGltZ0x5ODU1dUFDRTlLRllKTk5SbXlFUGk1RTVjcFI3eDlOQmdwWW5kdmp1?=
 =?utf-8?B?aHVteUhVV09qREUyVXFLa09QUDJocUdyNS80ZDl2cnd2OW94Sk1OeHl2MTZB?=
 =?utf-8?B?WlVud3h1RmpvSWkvUnNvNTJMeUx4TU5Yb2wrRi9ZaDg5TG5UeVhyS2lNc2Zw?=
 =?utf-8?B?MVpkczVHU2IzKzZDdXlGUjg4bU5VSGw4WWtGMGJHelNwQm1NQ2lrSUVKOFNq?=
 =?utf-8?B?WVpIVmhyTWMrM3pwTWtia0VvUTdiWVIyQ0FUdWpMRy9LZk9Cek4xb1V4Z2Q2?=
 =?utf-8?B?akkxMVZPT0dCeUQyS0JUbm9MRWlhbzY0ODRqSVUrcTJ5aWRZdmtmcGZTMXpW?=
 =?utf-8?B?eUxFVFVhNjFyOThGeVBQWkpQYm1WMitqcFZtTklQVEpsa21UbkhnZExQcFpV?=
 =?utf-8?B?WlQzNmtCUmhBaTJ6WlFhWGxLR3I2NmY1Q0NJczRBaEMydytNbDk2YWJLdkkz?=
 =?utf-8?B?MmxSK2M5d0g4WnNXNTl0TjVPdXVLYkszSDZZSFlxWldHS1BpRDBHWXptdjdi?=
 =?utf-8?B?Mzlwa0Y5bXNHY2h3T0lOSWNuMXlua29pM1dNdHpXbUVxbnFPNXVxaFhxckdv?=
 =?utf-8?B?elk2MzJkZFRjb0V0RFE2aEtXSGxuMm1SM1QwdGF5dUI0Qk4rUzBFUEZqcG4r?=
 =?utf-8?B?S0Vkc1hEOTBFRzNNeW5SUXRYL3RueVBYY1hrMGVYbUhKQjRhb0c0R2V1M0xD?=
 =?utf-8?B?eUFqVjlvMk1FellvZk5lRFVrbXdkRm13dWRqQmQwZ2hIY1d3WVNvczdmVFpy?=
 =?utf-8?B?UC9QdGRuNi85R095NGg5UTFQN3pKTFZMMU00TTZBcnpqZ3RYQTJyUGtwTmJK?=
 =?utf-8?B?ck9pblNwZWFEd2k4Y2ZISVFlRW9XNlFHMDF3bkJiZ2pvZXRiRW1JZHJBMDZV?=
 =?utf-8?B?SXZDUGhvdlZOSkFtNUV3UERZMXBxNTJ1clZRUG9WQWhZSzZHclRoVm8wNHBX?=
 =?utf-8?B?WTE3dWMyZ2M4Q0tUM0tEK1lsUTYzWWdrTGxzUWRMYkhIcjdBZUNWRmlhVVNT?=
 =?utf-8?B?OG1Sc1ZrSE1LZ3Z5VGwxdzB5UGxGTXBGS1lFZlhJZXkrK1dza1NCSnBSRktw?=
 =?utf-8?B?eXhZSmdXbVhxNm9OajNqSFAvUHhwaXZNNnFtYS8rR0JNVHhnTVlMUmcyaTlq?=
 =?utf-8?B?UUY1TGlLSUFCSXBBVFJJOGFkUDIrdXV0ZnU2Z2svOGpRaGlGNWd5UnNrRDlm?=
 =?utf-8?B?V25mdXpHM0dCQ1ZHMGNOcmVpMjlrd0JKTTVIbEVlU05EWnpKVnlxaG1Balh4?=
 =?utf-8?B?a3dKSlM5eG5TSHVZUTkxTHRUSHJoemZ1NERjVDJXVk5COVBZOXBKakhSRWE5?=
 =?utf-8?B?TUhvbHlTTFZFaGN3WnEzZCtoVmN5N3ZSSU1sWmZxdGh2RHVOdktXRTYyYm56?=
 =?utf-8?B?c2F5YXdXQ1NUTzVtYkpkbmRkdmczSVdVQWJCY3pYbzlnUi9SME9sQUZxWm4r?=
 =?utf-8?B?TFA2dzhyM2ppQXZNUHdrT2VlbWxCSVNvYTFYbXY0VStCNWRkTWdCT2lIOXB6?=
 =?utf-8?B?NVI1TEpiNGI0ZGNVYTArNElUb2VPcWRwSnRoRGlVVThHbkVMNEVQUjhTNW8r?=
 =?utf-8?B?ckw0ei9YUzVWbFF3UkdheHFoNjZ3bVNzejhVRjd2Tkc1TWlHN0RvSTV2dEZs?=
 =?utf-8?B?R3Z0R2lSUzlBczVXODJldm5hMWxqZm1ubVgwNW15QTFwRDNaSVJqbTJLOWMv?=
 =?utf-8?B?YTB0cyswME9zY3gxNUtUbVEyMlI0V01rNXVmS3MyNDdKTVdKN2wrL212U0Fv?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a37e0de4-21c9-48c7-b631-08dac9c3b29a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 00:19:19.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwC9YNy54XSWtvMn37i0/31geYKsb5Dr80R/5Ix+DO8kT7Opdh9CITeg9i2PtCRAoSDuWdF2BQ6l0TKE7HlIazslXqTimI5LMXpvHeif/jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4698
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 11/18/2022 2:59 PM, Reinette Chatre wrote:
> On 11/18/2022 2:31 PM, Thomas Gleixner wrote:
>> On Fri, Nov 18 2022 at 10:18, Reinette Chatre wrote:
>>>> @@ -141,7 +141,7 @@ static int msi_insert_desc(struct device *dev, struct msi_desc *desc,
>>>>  		if (ret)
>>>>  			goto fail;
>>>>  
>>>> -		desc->msi_index = index;
>>>> +		desc->msi_index = index - baseidx;
>>>
>>> Could msi_desc->msi_index be made bigger? The hardware I am testing
>>> on claims to support more IMS entries than what the u16 can
>>> accommodate.
>>
>> Sure that's trivial. How big does it claim it is?
> 
> 2048

Dave Jiang corrected me ... the max the hardware can support
is 16128 so the current size of msi_index is sufficient.

Reinette
