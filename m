Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D06640CA5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 18:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiLBR4N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 12:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiLBR4I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 12:56:08 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E721E11B7;
        Fri,  2 Dec 2022 09:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670003767; x=1701539767;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uuz5MaW0nTGYjy+cN5f11hjrPdqR0tY7c6WAr4NYLAs=;
  b=coCb7VAY8+w2db1tk2yO4wAxBOCxvZgkGSNihdJvhAQi8P8Whxsffv5l
   DNQ6W8MrkMcDm9C0lXDAXUg6sGzrGMlkxZdTXtO/L+Ks/fJIVJ/R3si0l
   QR3m6d41DSPWy52f9QIKOkHHg9cj1xqBnDC/9cw+YPxouEBpzHBxW11MG
   42opzF3ZAys+S2rVclIRo9LC3m5Ena5/5zZwfD5x4jH7R7LOHA2u3DooG
   Mi3CqU/v5QmtWQ135DZV4VrRG9QtkLM+ZHFQelct+YREwbygBTZV504Vp
   v08MJmT5VHpZpUiXMgxiQAz98F7tI7eBNg8LC5ZaIQOAr+MRQgDK7EXbt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="295705658"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="295705658"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 09:56:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="733891476"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="733891476"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Dec 2022 09:56:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 09:56:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 09:56:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 09:56:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxxXxZJATF8VLZJ39xL7XgZ0Xy3egy32fA0KR0Kvjzvzsxhygfqv1Rruz6s21ArWqQTeeHUTyCeAcT7fqC2fya6Ori3mkamUJzg0EGMeIR4R/vxZSFLAA3BXgOD8fZNutz/33QAy8s7zkXps6SL4WWY5kRpW1O3ZVYXhlFd+6miod/Jx5TRWfPBBAmdDUGPzitKIq/jpLHD+GsBXeqyjkDgzTpxukwyptjEJ/PAbWIeNEG6K2yY1RmCDTxyDQ8SpxMTw/9qmwRd4qFo5G1l2/8hz7KEiS3tO6Wyi/3wWb7kPUp20svAm1WX8Dt7D6pq9MX1SLI8cviRPCQNii3/4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABbo2rEVuOh6V9fLQ4UXsqAPHbnmMqYWmbvOuWNTRBo=;
 b=Q94sOTYwicP4TTq7yOPSmh2g5QsB8cx34uAx1jbNvbpvNagdzEXrEBshJ82a/ybW9AlKW9YOE6MPmrzlvXbl8d8sdywI7BA8We0t2HT8ntRyxlVqI9pU/xOiUQJwqbmtkdb+euunuPLY3R5DjxOrGNjs8wa77UJ+D+qdNoh+EBhsjxgZ75x+WEZzK86TtmtwLR39EQP7fyonVlQjpFcOQ3fznfAw+dxCOmuXRUdlmznN2QJx6Tx04qomUavhtgVl+bYsWed5boO2yPUuEP6LpWsd4pwHhLqBKFJ9Z6hz8qwNkUN3Cv0OQqU3jMWzpLPWJ5cvoxwT1nvIpT+mEAMyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ2PR11MB7646.namprd11.prod.outlook.com (2603:10b6:a03:4c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 17:56:02 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9%12]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 17:56:02 +0000
Message-ID: <4a15c569-0545-20ac-e74c-ae17f7eb067d@intel.com>
Date:   Fri, 2 Dec 2022 09:55:58 -0800
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
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221111135207.141746268@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:a03:80::30) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ2PR11MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: b65d53c4-d01e-4881-2754-08dad48e79b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yi7FIvUlRlaXd6pHMq9JYAu1UxNSKXLFIaVRMWFAVtYiaNl7MiYpmnXuTuqGYZMc4gldc1lIyXi+T4/SXE05EHj49E6oOLtF9OPtcNfGQs5OHlhyBjwqlu8RBPuPyoi0OkVu9YWgWM7LKa8DQrrrq7ydqE9yvarvF1xuJEp2Bvkhb4QyoN6DFfBj55mNLH8mm9FgHBqwLmvl1bSMLVVLqP9gYRR4feEwkMJhL8cVwnyLndSEnL0W9OeT1u7kMYTvkHY9yGtHEv3TVTbfXVYs3HHnRe/tDYPks2IOj/C/3KVy9THa1V3AaNSs0pxLTFZDQe1XLQ7RCZUWONwwPbHJ5v3fEzC7kgBqf5nAwWbQgNhEaHiHkeORVaMoT8DVgQsv41Ol76pzP1IhstURSrBYXpKk2yIXi6JvYgLhiS1aJatZyCp93EufCW3jKXekMFJZgr55yrJNF7eX5JYlCFPYJAUhtm8yKfpMsHPLcqmXUlOTXs9fAnJpj005MtqIg4JTwBFbnq4PL3P0HaaFWKBrjfBxcKi4ufrb4t1yW9fuZLf1RsrRW2+/NBnEIeRaGQ9Rt22czUtC4/O/RKVEGlly6yGEhQ1C0v4ie8/fBFb2lcVU+o5Zb9t6iCDhUnzAHV5+T7FQoCrl04XO6bZuzhdWxf0dmSbjgx3q07e1uS2XgkDW4J1lPL229h0lhrqveer6db1X1RqdpSrb6Rqy304GyOgbhQYc881R02yh1Csgqc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(86362001)(38100700002)(36756003)(31696002)(54906003)(6486002)(110136005)(478600001)(66946007)(8936002)(7416002)(8676002)(2906002)(15650500001)(66556008)(66476007)(41300700001)(4326008)(44832011)(5660300002)(6506007)(83380400001)(6666004)(82960400001)(26005)(6512007)(316002)(53546011)(186003)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L25kWlVKQzE0NFpUbEJURWFUNVNUUlhEdWhTS1dCL08wY0xFbXdGSmFXWnZt?=
 =?utf-8?B?ZFBLVFpBN3YwTHNwNElFM1dZazE5MDQvZGkyVmM3NGQ1c1ZXa0RWNUprcndj?=
 =?utf-8?B?WE4rdGg4ZVpNQUJPaGQzZkx5MFhaeGhodGF0cFdXbVUxRmZSQUJFNW5nQ3VP?=
 =?utf-8?B?ckJ0MVBZc3dxSThsS0c3b012TTIraXhMVjA1UGF4dU9FSEVacXJyWjNaNFhh?=
 =?utf-8?B?MzJJQXhpSDFuTDFzdnRoZnJVSmg2VjlHQTN5RjdEaVhuZWNFckVraEtLenln?=
 =?utf-8?B?Q0hSakIyOFRnMFNFZmM2SnRjTURrZnIxeGd4MzFoaTducHBWcHNFRzZDRGRk?=
 =?utf-8?B?ZTlzVDUxNEZBVUdocFVtU2YwNngyblkyZnpBRzZ2UUdlcWUxaFllRlI0NzFo?=
 =?utf-8?B?QXVmNjQveWpxQTZZMjk4NHl5VjJTVGFyRkh5TDAvZHlOY2p1SjdvcmMvNTFK?=
 =?utf-8?B?VDNZbWJRZWZsaEVlUzF2YWhlQ0xMbC9KSW42S2NLUFhDaWNKQ0dSa3hwNXlo?=
 =?utf-8?B?b1ZVVUVDQTRDUmNFbTFxZCtxeWZrVUxUZDZoMmZ0MnRLaUtDY0Qxb2x5V2Ft?=
 =?utf-8?B?d1BPMnJlR1RkV0MyTHNoM0pTYUkxcm0wQzVualovblhPeERPRmtoVGUvOUhi?=
 =?utf-8?B?ZGluM2xPWnBzL1BKeVJDM3FVb1ZvRnVlZzJmUDk0UkFGMG10WWhCZzFxYzhq?=
 =?utf-8?B?ekFDVzVuNTNUV3g5M2g3ejdYb0tsa1RLMXVKTGEzaVNmWTMvSWxTSEJjMWxi?=
 =?utf-8?B?SDFHRVhBSUJJaHJmdTg3S0dOY0JZSzEyMEJBSzVGYmJQMWxuRnkxSEQ4R3d1?=
 =?utf-8?B?QW1aSzVJUU9EVnBvRlRGYndIakZIVVV2NE13YjViVHFkZVQwQmF3SGxORXlx?=
 =?utf-8?B?aWRoU0ZBeG5RREZqQWNyakV2elhSakxEUEovRWlwNHpVMmY1dkJZRTdDMWhR?=
 =?utf-8?B?RjFrVVJWOWI2VEMxd2pNcnFGTGdXUHM2WnorS1lpa3Y0N3hqMUd5c2RmclN6?=
 =?utf-8?B?SU1mRUZ3MDFQbnhTRWgvcW1SN3RwQ3I2ZEM3MWpyU0tSRzJBZ29ZZy95aTBZ?=
 =?utf-8?B?V0hweGVMK0twRW9tRU5la1g5WHYxUmMrNU1qNFVJNW1XTThUSXgrU1U2QTRo?=
 =?utf-8?B?M0tQOWp1NjRTa1hQMVJVcTBGWUJEc3ladDYrWUpoeFVQWXoyQlJsMHh3TlVk?=
 =?utf-8?B?N0IzNVQrOXNpLy9COFVHU0hMVUQvak5LbWtCRlBhcWJzMnByMmZ4cFA2alBY?=
 =?utf-8?B?RFBtV1YzWGV1dE53cXVBZG5XSFp1NGtmVFBFbzhadmJXb09oUms2NjFZdjcy?=
 =?utf-8?B?V0RtT2djS0xyeU1wMUpkYXN6eW9KeHYwa3V6UHp6bklsd0luSFNmOHNuRDBP?=
 =?utf-8?B?bGJFUk1zYk14S3FKZ3FUUEVVdXd2N2hkUGdmNzN1YktMaGV2bCtGQXhZR0Zw?=
 =?utf-8?B?cDRrbmNIMGtOc2g0ZjZMbDB5OExLREF4c280MjFtU3pTK2NLRTBQK0c1bU8z?=
 =?utf-8?B?VjBPcWtrY2JyajdMNVJXTVVES05DQUVlQjVPZWxqRy9wWE81WEV2NDduZU5C?=
 =?utf-8?B?alN3VkMvUnFsVXM1dGtwZXY1eHN5WkhQcFJ4aTlDSTZSWHNyZFlKR05UWjhj?=
 =?utf-8?B?NEdlNHkwdHM2aytiVUR6VitvUDNmQ0taSnpBMTVnaHR4M0JUVkVxNnlyRmMz?=
 =?utf-8?B?N2Qvd2lpcVZIbTlZU3RkM29jQ1krQ3Iza1hPNFRVYVc4QXQxK3dmRDlXTWRz?=
 =?utf-8?B?VzN5MGZCak82T1M5T2Z6amt2UU91bnRJbTRZdnU0NEp4b0hMQVphTnc3bVZS?=
 =?utf-8?B?TEtXbktQSkR4cFdzUDRCaGlaQ1Q4ekNjaWxsWGI1T3RVR25FK3pwMVdPemVr?=
 =?utf-8?B?anpRcnhRa2ZxOUVncjFmRGNaMnFmTUpxMjlMNHR5a3hCU2R3MDRhSmNRSlN4?=
 =?utf-8?B?ZmRwVlN2dWNGOTNzOTBGWHpBMDRyUjd6OVNoa1ZaOUl2V1BXektXcitLUEhC?=
 =?utf-8?B?eDFTYXk1TUQ0d1VXRXdkSGE3anJnaHFlSWtadGpiSlNaV3VTVnBQT1Fkc0xU?=
 =?utf-8?B?QkNlRml1TUFEQWEzeHdadDF6aXF5Vm5lblBjS3g0YjczM21GZk1HMVYzVU15?=
 =?utf-8?B?aHloeEZyUHM2ckNZY0JvdXNtb25rblVYQ3lwQllwQmJuaU5UdGdVQUMydmFu?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b65d53c4-d01e-4881-2754-08dad48e79b7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 17:56:02.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYa7kC8cr9JQN2gtzvSSpl+T8Yh6B7pBc3kEikBai7KvL38wJUljOihsCGAjqyOYnnDSUgzBUGmxIXoCSy5P/HSI6MAyLzVgllpsPmCjDxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7646
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 11/11/2022 5:59 AM, Thomas Gleixner wrote:
> Provide a driver for the Intel IDXD IMS implementation. The implementation
> uses a large message store array in device memory.
> 
> The IMS domain implementation is minimal and just provides the required
> irq_chip callbacks and one domain callback which prepares the MSI
> descriptor which is allocated by the core for easy usage in the irq_chip
> callbacks.
> 
> The necessary iobase is stored in the irqdomain and the PASID which is
> required for operation is handed in via msi_dev_cookie in the allocation
> function.

The use of PASID is optional for dedicated workqueues. Could this be
supported to let the irqchip support all scenarios? Since the cookie is
always provided I was wondering if an invalid PASID can be used to let
the driver disable PASID? Please see the delta snippet below in which I
primarily made such a change, but added a few more changes for
consideration.

Summary of changes:
* Use provided invalid PASID to disable PASID for the interrupt.
* Use bitmask to ensure that the cookie only contains a valid PASID.
* Modify header comment to fix typo.
* Modify header comment to reflect driver usage of macro.

With the first change I am able to test IMS on the host using devmsi-v2-part3
of the development branch. I did try to update to the most recent development
to confirm all is well but version devmsi-v3.1-part3 behaves differently
in that pci_ims_alloc_irq() returns successfully but the returned
virq is 0. This triggers a problem when request_threaded_irq() runs and
reports:
genirq: Flags mismatch irq 0. 00000000 (idxd-portal) vs. 00015a00 (timer)

Thank you very much

Reinette

---
 drivers/irqchip/irq-pci-intel-idxd.c       | 20 ++++++++++++++------
 include/linux/irqchip/irq-pci-intel-idxd.h |  4 ++--
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-pci-intel-idxd.c b/drivers/irqchip/irq-pci-intel-idxd.c
index d33c32787ad5..1b49c884bd85 100644
--- a/drivers/irqchip/irq-pci-intel-idxd.c
+++ b/drivers/irqchip/irq-pci-intel-idxd.c
@@ -4,6 +4,7 @@
  * interrupt message store (IMS).
  */
 #include <linux/device.h>
+#include <linux/ioasid.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
@@ -33,6 +34,8 @@ struct ims_slot {
 #define CTRL_PASID_ENABLE	BIT(3)
 /* Position of PASID.LSB in the control word */
 #define CTRL_PASID_SHIFT	12
+/* Valid PASID is 20 bits */
+#define CTRL_PASID_VALID	GENMASK(19, 0)
 
 static inline void iowrite32_and_flush(u32 value, void __iomem *addr)
 {
@@ -93,12 +96,17 @@ static void idxd_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
 	/* Mask the interrupt for paranoia sake */
 	iowrite32_and_flush(CTRL_VECTOR_MASKBIT, &slot->ctrl);
 
-	/*
-	 * The caller provided PASID. Shift it to the proper position
-	 * and set the PASID enable bit.
-	 */
-	desc->data.icookie.value <<= CTRL_PASID_SHIFT;
-	desc->data.icookie.value |= CTRL_PASID_ENABLE;
+	if (pasid_valid((ioasid_t)desc->data.icookie.value)) {
+		/*
+		 * The caller provided PASID. Shift it to the proper position
+		 * and set the PASID enable bit.
+		 */
+		desc->data.icookie.value &= CTRL_PASID_VALID;
+		desc->data.icookie.value <<= CTRL_PASID_SHIFT;
+		desc->data.icookie.value |= CTRL_PASID_ENABLE;
+	} else {
+		desc->data.icookie.value = 0;
+	}
 
 	arg->hwirq = desc->msi_index;
 }
diff --git a/include/linux/irqchip/irq-pci-intel-idxd.h b/include/linux/irqchip/irq-pci-intel-idxd.h
index d62ef5b3285c..48c73bffbb5d 100644
--- a/include/linux/irqchip/irq-pci-intel-idxd.h
+++ b/include/linux/irqchip/irq-pci-intel-idxd.h
@@ -9,8 +9,8 @@
 #include <linux/types.h>
 
 /*
- * Conveniance macro to wrap the PASID for interrupt allocation
- * via pci_ims_alloc_irq(pdev, INTEL_IDXD_DEV_COOKIE(pasid))
+ * Convenience macro to wrap the PASID for interrupt allocation
+ * via pci_ims_alloc_irq(pdev, &INTEL_IDXD_DEV_COOKIE(pasid))
  */
 #define INTEL_IDXD_DEV_COOKIE(pasid)	(union msi_instance_cookie) { .value = (pasid), }
 
---   
