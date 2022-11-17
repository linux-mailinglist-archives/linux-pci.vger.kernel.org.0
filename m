Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD8062E9A4
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 00:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiKQXd7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 18:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiKQXd6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 18:33:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2427E15FE3;
        Thu, 17 Nov 2022 15:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668728037; x=1700264037;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jhxGjTY1MuUVQLst/XnkzUySKc0X1EvnmuXuYaWYgTg=;
  b=jCsj4aLXA63n6LCiZeq9Jr6LwUsrF2bBGzjGHPyoBVA03i0igFQlk+a2
   mC9UZa+vB1zDsiJD3M+Y+vNTsFZ9/ixaYfNTrBMC2uMfTk8g8rezrPziF
   kt9RaforxmOiBkoBEpNdIyVeNYE2Mcw2c8tkIcnsDmmN8ErF0/jiuKEsl
   akTeu+1QbOiOQF7IJ9/6T9A6zXPao1vYPY2+WGc3u+tSdvdZuOLQw7KbM
   xKiqvlEwZlS/+ayLKHFjIVbSS7uJvVINAwKdbvmdYxYDBC/XwaQ/kFQNc
   c5q2PJg5lH9/6uQMpJLCIIDZfSiuh8XwXOdQ2vn+LNOCykyJIJ6GXidxk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="314155372"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="314155372"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 15:33:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="885075027"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="885075027"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 17 Nov 2022 15:33:56 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 15:33:55 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 15:33:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 15:33:55 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 15:33:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fpk4VjgVON3F7qKff//uFDYqlIc+Lgi2oXDJJobGc/CKafvV/OazZ8/LQ0gcjeckNL+IaOLI+/YwrNRXEA1eUXXFKVKGevdJJb77fU4jBRoqk6wpw6c0wbdR+DA/kBe2EQUPRaWWHp7um2cigkI5ZqeQPX2ykx3luNP6976/5L5qA6Q/+30ikeTMY2F/O95uLFrUlBivDfPZNUhLii470m0YsSz4rJrkB1C2NnSFL3ck9UWEDjEkpLD8266vFcw+ESV5a+SDCPd4GrPn/NurazZkik0cZ/cJMYXkS1394p9n/Fnq46pnB2MFwSNJvM6VhBzTFNnnBy5pr636gyw6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGQu3XLifBw20jerbJVI88leJeF88gdNOtT47cokyOA=;
 b=iHbAlnoN91a2wQlR7rCZdE7or4GTpGv0gw7MOWPNpki/vxZ5S6ETRwnRfKR8zlGf3MsxXmOlN//NneNYIWK3KxyMa70Yu7L5NlNkTssgTUDKeg7j/MrzdBaNtbG+1LLhSIyYaBpVKWMTivTXEC5aaYJyIwUu7AetzL2abHLpreiD//9JAyA0aHzaEA5hk/yxPKxeeyKY80H8I0q1XjGiJr42K3k4lgORYQF3d+LjxviCitpqOoqLMxsHJtu57vIUOmb8ov28heBKQ7K1/o2FxHSHARfEiyqNery4w7q/TxKIPPJsd4dtgOETJWGYu5tllrKChpC3pt0dsNI328NclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA2PR11MB4986.namprd11.prod.outlook.com (2603:10b6:806:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 23:33:53 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5813.020; Thu, 17 Nov
 2022 23:33:53 +0000
Message-ID: <0cbf645b-b23a-6c85-4389-bb039a677a52@intel.com>
Date:   Thu, 17 Nov 2022 15:33:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [patch 21/33] genirq/msi: Provide msi_domain_alloc_irq_at()
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
 <20221111135206.463650635@linutronix.de>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221111135206.463650635@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::16) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA2PR11MB4986:EE_
X-MS-Office365-Filtering-Correlation-Id: d3297b2a-8aaa-494a-250f-08dac8f43014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v75xGCMOkSLlIsuoRHlSUeTsn8eOHsg94KTAvVV3umBZ1zX+Gb01JeTITeOBw5ugQ0WCw64lipWgMHvvFExJuPzwrM+AMg9CTFJWZ15eHKobXc1ubq6ksdLroNt0KVYDwCTaGf8mBJRkTxn9RZxWSb2WpEA4LzNZ6107HMqGHm65RabX7E7eGIYOPM8fy+oSgF04G5IX7R4QjAnEFG+2JHqFwqAzr00YYg32I7hEGWDnW3Yd6YA31A0RZB+zCT9tpsDBDji26liBE13R0zwEil1KzeDMgu6FAUuRCSYYy40wMzqfcybPPguzOlE5/7rHC3QiamqEiDYqBDiFVcREDoOJvKM5R3RBrO5MoGZfcBQ2N4SqtQj1UkQtKHHBrk+Eg4qTYN+Sx1hm4AW41feIkhx3yrAIjCTMPrkceTgSpTGPoORnY6aDbZsrJhjL8M0tJXvKFk2x2X5fnox+B2F5ZfqlGQKVJJ/vFhvWbu9xHLjDoorlVf44yfrzpQjfEvmdzs6yz2Be4l7UlD5QUYdZA3N3S12esIOJSWZIKmyMnH4Dh3jU1TTt6Hf97gYhK6lvg0KFlwjUtyjXwKROVMnOVWPZqBaPzknGTbv+KNEagH5fFHHG/DKcM9tqOzfDYkY9MD8z2w6Vznas9lMYQQV4UadZ2tDrPt7wgrt9SUYRk2xdMYqa6//BlkW7Fdm/cvX2vb40tdacJ+rx+7m7SvYgrJSkVor9uc7F3IehgN4LBtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199015)(86362001)(31696002)(82960400001)(186003)(4326008)(2616005)(8676002)(36756003)(41300700001)(66946007)(66556008)(8936002)(7416002)(5660300002)(6486002)(66476007)(44832011)(316002)(26005)(478600001)(6506007)(6666004)(6512007)(110136005)(54906003)(53546011)(38100700002)(83380400001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHphV1dYWEZUb1Urc0pEZjBJbXBncUMrMWdENVFDd3BIaUhXMEpWWTlnVS9J?=
 =?utf-8?B?Y3VPM3dTR2VoSGRPcGtWbWJOeHdZYkRuVTVCUldLNkFmd3Z3NEhHWEFvTWJu?=
 =?utf-8?B?V1NjcStINU5tVStUWkdPVW5YODJ6QldZbmZoUFAvckdRY1hqcnphUEFzY3dB?=
 =?utf-8?B?b2h3VU53WHhXMXhQTmJVem1EKy9LcW00Q3lpVkZyZnJRbm9yZGpwc0c3Zmg2?=
 =?utf-8?B?ejllOWlwTkRSdGJZS0wwbU0zdkhaNmd4NVUyaldNRUI3VDdKRS94K0VzWTZi?=
 =?utf-8?B?YjRGQmpXbGRnamNiWUxuRzU5dTVrUXFzUmFocUZvM2M2azlkTlNUQk9aTHcr?=
 =?utf-8?B?cnhxclRhZkJmMTVKSFZBRm14emh4S01mRGdyOVZYdUZxS0k2RUVRY1lESEha?=
 =?utf-8?B?RUVBaVJLWFhqL2xuRWlibjZPUFhrQUxHVy95SE5lME5md3JGdi8wVDNHeDZN?=
 =?utf-8?B?aUNiOEh1WTE5QkZvM2ttd1lTOXU2YW9PSHgzS29adjR5N2Q3aDFydVFJOGJG?=
 =?utf-8?B?cXJhWUkzUlluUlFTSnNxK1V2U2dVa1BYVVpUQUYrRGR5V3UrbjZGU25tTkRk?=
 =?utf-8?B?WDVxQWpDNjNPNEt1M0RmKzhkSlAwb0FEV2Z5MnN3c3VKNk8xUkR1c1VOQS96?=
 =?utf-8?B?d3BXMk8vUU43ZzVaeHZUbVlKSUhmK09yRkNUZnVSUXFvSDVWeVp3OW1LK2ZL?=
 =?utf-8?B?OWlkWkxzNW4xZmpaMzc2eUU2dWhoNEJWQkJDVGtlZlZPclFBQnk0Ump5VXZY?=
 =?utf-8?B?a281cEFZa1lkb3ZISjhYSEQwRFdySVNLbWtvVXVrdFk5NXFGSmdSYjE0MEww?=
 =?utf-8?B?U1diOGdOd0Q5bnQ0VjVIc2VsNG1BY21CWGlzWldCWjNQZzFndTJJMjkzeHpv?=
 =?utf-8?B?Zmh1Yk54TjNNSU5yYlRQMElSN3NrOFd6ZVBybTc1ZEI5dTBHZkRzSHFvUjg2?=
 =?utf-8?B?bXlSeGUvTGtSMEhNcW9Pbm03ZS9jYktiRGcrb05ybDh1OEs5QVNyZ2xHV1hX?=
 =?utf-8?B?T01JUzVKbkhqQXk3NjgzWC9JRGhOTUhML0V3WDVLeWpLV0ljQjA0dTA0WHJp?=
 =?utf-8?B?Z1k2b09xQkF6RklnM1hJaE40OXE3Vy9wNHQ5QnBOV1hndWhNdTdXUFBHK2Ux?=
 =?utf-8?B?MmlVTFpKQmZVRC8rZ21QTFBab1lVQ1hYbVFEN2M2TVRuSHdKZnAyK21yV1RP?=
 =?utf-8?B?dWQ2Q3I3NWVoYlYvL2NEZjRIWFN3REpnSmxGZ1dLYm80TkdwcDVqYzdQVEdI?=
 =?utf-8?B?ejhRVDNuZzRoc2ZwMjRwd1Y2V1EyWEZ3aFIxdWZRU2YrTVg1a29yaXJzUXdR?=
 =?utf-8?B?Qnp6NDVDZ01jNFVxekNySkZYWEIvT3NrcFVFZlIxZFlRQlg5VDJSYW1ZTUJE?=
 =?utf-8?B?SzFmdlU3d3VxS25Fd1phdXNHaG9SMjJ0QnJFZllTbTdHcEdqZ0RrYmFiZXVS?=
 =?utf-8?B?Q0REWVJVZjRob05Kb2gxLzBZa29lOCtKck1SdXVNemlxL2tkNGJTUVRQY3B1?=
 =?utf-8?B?MWkreTYvTENTcmh5Y2ZsM0hiRnFERkRiRk9FKzQ1Q1YwTXBBNjVZa3l1MnhE?=
 =?utf-8?B?WXRPTGl3ZGVjQktQOCtSeXprM0pMSU5STytINldNa21UN2pnRi9WbjNOeW5K?=
 =?utf-8?B?ZXl5cGY2c3JlcmYwS0dUdWNjTU4rVXozY0RPdzdCUUZJRW84YnFDMFZrd0Fs?=
 =?utf-8?B?alZObTkweGxORC8vTjZScEJjVERsVlB0VjhSWEJrOGpMUktnNlZJcm1najEz?=
 =?utf-8?B?ZEw0aU0rSTNKUDNUVGpReCtWeFlpdXFla0ZMcXllRkFBVDV5SEtMa1BNTGg4?=
 =?utf-8?B?bGV5dFBDZGJ2Y3hmMTc5QmJEMTJjS0xBMmRnT3VxckVRNHFPY2JMaERKSTNz?=
 =?utf-8?B?L2x5SmcyVTlNQTFJRUdMbnp1N1JxcVNuZlJjd1MzVFlkcHFIMGg4ZmMvVktC?=
 =?utf-8?B?TmZUc0ZURlFtZmJlM2hvbTROZFN4TFJqZ3pkN3dJTnRqdTQwRTdqOUNWNjZM?=
 =?utf-8?B?d0hURkljbmRGSmdiQXdFM2NQMHZ1MEVFd1l4NHp2ME83UngvYVdsK3R3QXRW?=
 =?utf-8?B?TGIvSjhIRVlkMy9sZE9NVWNJU01sWjNvN3VPbDRncWVGMlphaTR6NUh1Zm0x?=
 =?utf-8?B?VE1BWlZ4SFZqWnM5ME1RWjZiMlFheFV3M3I5TEw1RXlCMFBWWjFJNjliZmlX?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3297b2a-8aaa-494a-250f-08dac8f43014
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 23:33:53.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSjkB7wWSuiHu52PSSC/ECcl/iCY8FAn8+8RTiUkRyF6cxfEzzBqSEvfOH1dPZqpGuedGtZK2La7uqXqQvuuugvPXBsyOHKCls17W7yAjaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4986
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

I am trying all three parts of this work out with some experimental
code within the IDXD driver that attempts to use IMS on the host.

In the test, pci_ims_alloc_irq() always encounters -EBUSY and it
seems that there is an attempt to insert the struct msi_desc into
the xarray twice, the second attempt encountering the -EBUSY.

While trying to understand what is going on I found myself looking
at this code area and I'll annotate this patch with what I learned.

On 11/11/2022 5:58 AM, Thomas Gleixner wrote:

...

> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -39,6 +39,7 @@ static inline int msi_sysfs_create_group
>  /* Invalid XA index which is outside of any searchable range */
>  #define MSI_XA_MAX_INDEX	(ULONG_MAX - 1)
>  #define MSI_XA_DOMAIN_SIZE	(MSI_MAX_INDEX + 1)
> +#define MSI_ANY_INDEX		UINT_MAX
>  
>  static inline void msi_setup_default_irqdomain(struct device *dev, struct msi_device_data *md)
>  {
> @@ -126,18 +127,34 @@ static int msi_insert_desc(struct device

When calling pci_ims_alloc_irq(), msi_insert_desc() ends up being
called twice, first with index = MSI_ANY_INDEX, second with index = 0.
(domid = 1 both times)

>  	}
>  
>  	hwsize = msi_domain_get_hwsize(dev, domid);
> -	if (index >= hwsize) {
> -		ret = -ERANGE;
> -		goto fail;
> -	}
>  
> -	desc->msi_index = index;
> -	index += baseidx;
> -	ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
> -	if (ret)
> -		goto fail;
> -	return 0;
> +	if (index == MSI_ANY_INDEX) {
> +		struct xa_limit limit;
> +		unsigned int index;
> +
> +		limit.min = baseidx;
> +		limit.max = baseidx + hwsize - 1;
>  
> +		/* Let the xarray allocate a free index within the limits */
> +		ret = xa_alloc(&md->__store, &index, desc, limit, GFP_KERNEL);
> +		if (ret)
> +			goto fail;
> +

This path (index == MSI_ANY_INDEX) is followed when msi_insert_desc()
is called the first time and the xa_alloc() succeeds at index 65536.

> +		desc->msi_index = index;

This is problematic with desc->msi_index being a u16, assigning
65536 to it becomes 0.

> +		return 0;
> +	} else {
> +		if (index >= hwsize) {
> +			ret = -ERANGE;
> +			goto fail;
> +		}
> +
> +		desc->msi_index = index;
> +		index += baseidx;
> +		ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
> +		if (ret)
> +			goto fail;

This "else" path is followed when msi_insert_desc() is called the second
time with "index = 0". The xa_insert() above fails at index 65536
(baseidx = 65536) with -EBUSY, trickling up as the return code to
pci_ims_alloc_irq().

> +		return 0;
> +	}
>  fail:
>  	msi_free_desc(desc);
>  	return ret;
> @@ -335,7 +352,7 @@ int msi_setup_device_data(struct device
>  
>  	msi_setup_default_irqdomain(dev, md);
>  
> -	xa_init(&md->__store);
> +	xa_init_flags(&md->__store, XA_FLAGS_ALLOC);
>  	mutex_init(&md->mutex);
>  	md->__iter_idx = MSI_XA_MAX_INDEX;
>  	dev->msi.data = md;
> @@ -1423,6 +1440,72 @@ int msi_domain_alloc_irqs_all_locked(str
>  	return msi_domain_alloc_locked(dev, &ctrl);
>  }
>  
> +/**
> + * msi_domain_alloc_irq_at - Allocate an interrupt from a MSI interrupt domain at
> + *			     a given index - or at the next free index
> + *
> + * @dev:	Pointer to device struct of the device for which the interrupts
> + *		are allocated
> + * @domid:	Id of the interrupt domain to operate on
> + * @index:	Index for allocation. If @index == %MSI_ANY_INDEX the allocation
> + *		uses the next free index.
> + * @affdesc:	Optional pointer to an interrupt affinity descriptor structure
> + * @cookie:	Optional pointer to a descriptor specific cookie to be stored
> + *		in msi_desc::data. Must be NULL for MSI-X allocations
> + *
> + * This requires a MSI interrupt domain which lets the core code manage the
> + * MSI descriptors.
> + *
> + * Return: struct msi_map
> + *
> + *	On success msi_map::index contains the allocated index number and
> + *	msi_map::virq the corresponding Linux interrupt number
> + *
> + *	On failure msi_map::index contains the error code and msi_map::virq
> + *	is %0.
> + */
> +struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, unsigned int index,
> +				       const struct irq_affinity_desc *affdesc,
> +				       union msi_dev_cookie *cookie)
> +{
> +	struct irq_domain *domain;
> +	struct msi_map map = { };
> +	struct msi_desc *desc;
> +	int ret;
> +
> +	msi_lock_descs(dev);
> +	domain = msi_get_device_domain(dev, domid);
> +	if (!domain) {
> +		map.index = -ENODEV;
> +		goto unlock;
> +	}
> +
> +	desc = msi_alloc_desc(dev, 1, affdesc);
> +	if (!desc) {
> +		map.index = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	if (cookie)
> +		desc->data.cookie = *cookie;
> +
> +	ret = msi_insert_desc(dev, desc, domid, index);
> +	if (ret) {
> +		map.index = ret;
> +		goto unlock;
> +	}

Above is the first call to msi_insert_desc(/* index = MSI_ANY_INDEX */)

> +
> +	map.index = desc->msi_index;

msi_insert_desc() did attempt to set desc->msi_index to 65536 but map.index ends
up being 0.

> +	ret = msi_domain_alloc_irqs_range_locked(dev, domid, map.index, map.index);

Here is where the second call to msi_insert_desc() originates:

msi_domain_alloc_irqs_range_locked() -> msi_domain_alloc_locked() -> \
__msi_domain_alloc_locked() -> msi_domain_alloc_simple_msi_descs() -> \
msi_domain_add_simple_msi_descs() -> msi_insert_desc()
		

> +	if (ret)
> +		map.index = ret;
> +	else
> +		map.virq = desc->irq;
> +unlock:
> +	msi_unlock_descs(dev);
> +	return map;
> +}
> +
>  static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *domain,
>  				   struct msi_ctrl *ctrl)
>  {
> 

Reinette
