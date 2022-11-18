Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1562FC52
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 19:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242564AbiKRSSn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 13:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241807AbiKRSSl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 13:18:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D450A66C93;
        Fri, 18 Nov 2022 10:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668795520; x=1700331520;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8GhxbfDHATs6L/xyL77xU3HWFcKzXrimFGveiyTA3zA=;
  b=CVpwkWtrY3gq+VOTJY4COwFi2/L5yjMR0VFO3K9k4Xc5ROWaXqXzTIu6
   7vZzAOak55LTb+aPQFiWdJLhwXyOtCigqRCrLYHHwkixOfH47VG8qCaBX
   gDOycFClmBCqzHGJIHnGzAGZuBsoVC4K4++6B2Y1LnwggNGAWbjepfyt3
   HZctlvwCtU3LQbYm/IPUOSXpb4QywEWc9B0svlLZOv5oxrq6cz7+fAs0j
   kAUYGBekPMNAe6SLbDZo+6zJ2WaloAe+prIEiC4MwPT0JSBWPutjza+Pt
   cLk8ONNFXkXaklPSBqHONOto3drCR2FvctDs5k9nKyyHDRLB26iLz29kM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="310831758"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="310831758"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:18:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="671402125"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="671402125"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 18 Nov 2022 10:18:37 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 10:18:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 10:18:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 10:18:36 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 10:18:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLmhD1ZUVsyqo2pOYw6UnKjO68jEkjNdDwH8bvHtngD41/aI/SjM2skbhHnPzqMwNuPCWUo189+uXtLBd1us2C4RqaLTc4qBJiOEF6oj6tn7s3kQcnC1RrMtBY38uU41hvdOLs0utYj3oJcXob6ooGuX+mxFhrRnrJVMff5/Xdk8JCwFf1q2Pda9tAhlJe6ur4i6FdivUgihmYFaplO5iYT8xQECNLqwb0Z289/npQ0g3ISkyUxsbyeInC2RvaQUl55GkpkHCJEIR/26jlLNvnhQPTh25Oi9cDv/ynh+RxqjVE+Wae4i+2lr4Z0NPQCxdkfMxdfFBUwGYZNyVwAaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSL15cyWlUHNxH5mwcxwCN6XxOcoLZwwVjzFTOpTURs=;
 b=hSC3Q8GMl77D65anq46JLD24oiAjbCHor+4J5Bbkqf71elyFOgpSD4h5n1lOhwpfzC3M4xMJ3hT2nnGzjxhWJyGrdqkva/AEm+EtPMUYwHee5hM+SUmagoH+PNHP/V4FUrUODfa1LvWg1ExS393C0FixtUpmOKOeUSSQL4+kLg9s1FOlXB6HVJR++SYMFpeDeKjO0fkUze2sfvrm3wMxwMTCPAZJyhbCbGM2bfJ/KLxQzTbHcwWYybudeY+O5HOwziR14CTK2AcqxSN9FeNFTOkPPbJgDLk8bWDa8XhAgky93Mnq44Hc5d+/TpqXfG3e9kTiXvKnkthRiWUbeqNckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 18:18:34 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5813.020; Fri, 18 Nov
 2022 18:18:34 +0000
Message-ID: <d33e63f0-a5ba-38d3-1cfb-dd5ab8d249b8@intel.com>
Date:   Fri, 18 Nov 2022 10:18:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [patch 21/33] genirq/msi: Provide msi_domain_alloc_irq_at()
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
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <87wn7sjzeq.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:a03:54::30) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM4PR11MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 242112eb-ef3f-4ea0-cd6c-08dac9914dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AiZ9FvaWDyTah9UFdUkzueQwxQQjU8DqlcgK/P4WCE10prtcLHkW0AGOXSFO821TKThQh8duiW0mN3PTS378JkMEO5jLYTVXivnOWHm2+NDI/0GazrScseXUCO1onGOQuxleMkacaWipSdacY7XzCZvivM2MTS1EWJQ73VNkLEqU1JNxxQA0mty7FO5waREfiPFAxEB1YeQCCja4THmvJ/16I7Rx6Bp0wAyVgJ81UZg7jsxxBK6GZk9+pIEWM+gtTkscM/BD1bezfAoAj31RojlXjMg5q9X3Tom4LAEQ7lKG3Z7ABsxuMQYcbE8OCGsWHGaTPc44HdyIiUDC8j0DwtmmoHy9pULBRROF339l+G4QGMMGM0IZnu+5JMt8thil2ZAnw+SnKkuuwGIjx31xEkS7kLEJM89oC1MZbus6xGCj2D6vREd/pVhjEZbFEyD9enaOSrRR27VWakstJWP0yOvy3LxaiNcpZBdDgBPiAp+g8lVV7biZYcQnKF6WSyi0lwvJkoV9cqKnsNunnL90v528XiJem93AWAN9NEvvwEWFyX2bHTBT42n/PKQeTmkhKE95a6DASkmlUudBngkeBL2XnFWUW+wO/1GWZzs0MaBbwTHkPfeMpWvSOh83AChMSGt1wkPL0dwMT9TiipJpquW3jT4MWtZwKBtrlUOr6DDmSfebuVNdMMY26aDir7ZI0DRWrZsAtdwuqRcpww6yDsV35zHUVRooRDG0RZEiP/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199015)(38100700002)(8936002)(41300700001)(7416002)(31686004)(316002)(6512007)(2616005)(186003)(53546011)(6666004)(26005)(6506007)(31696002)(110136005)(2906002)(83380400001)(54906003)(66946007)(66556008)(82960400001)(66476007)(8676002)(5660300002)(4326008)(44832011)(478600001)(36756003)(86362001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTlud1dBYUJIU2lYZ3dLY2VXUXZTMmlOZDVPQjZEMTlQdmlUc2ZHM2IrdVVo?=
 =?utf-8?B?N2IvQ0UvNFNhQllMMEVQV1dRZEY4Z2R2YWlBa29uQmRiNTBXb2oyNVlwZWdx?=
 =?utf-8?B?dk5BSW1CM2RVQXpwNEkvbllyR05rcjFQbjQ4ckpvR2NnWmg1ZnBrUjc5MjhS?=
 =?utf-8?B?REh2Qk1PaHFEUGJ6UkZUMTFieTFQc1ZUbGlmWFV0Y3F6SWVMWkRLTnVsK0Uz?=
 =?utf-8?B?NENUQjVLNkdDWUE5cGt2NXFoblJvOVdETzZlL05XYTJPUlFkVlZEZTl5ZXJo?=
 =?utf-8?B?bGFKYXJVbE1qNTAzVFVGK3RhSWF2UnNsaWVIajhLV0FpcER1K0M2TW1YQUdS?=
 =?utf-8?B?Umt6QUlnNmlYdW40SkhvTCtXUVlkQkZveWJNQnQvbUdHU0c4SmdieGdsQnNh?=
 =?utf-8?B?Y21ROXhRZnowNXBPZlh1T2YwSzFocldrU3FTNlU0M0VNY2t6T0xkdXZrR3RT?=
 =?utf-8?B?cnFWS1RkcndDbU1yRGRkSmFzaU13dytnMkpjeWdIcllMTEJOeXdVMStKdkE5?=
 =?utf-8?B?b3h2T28vV2RmNGF5Ty8yN05Kenl6VHY4RjBhYW5kaGgyWE1aZ2MvTEE1TEZi?=
 =?utf-8?B?aFVhMVFyOEF0bmRySU0xaDUwMXc2cEJCcjd1UVR0NjRjcVBZRmY3RCtLSTJQ?=
 =?utf-8?B?SWxTSmVGc2l2SFY3VHRqVjA0VDYvYlYvd2pSdEw1T1FiNGdYSGN4cTVLa29R?=
 =?utf-8?B?WEpKM3VmWjdPbW5ycW54WVErTVZHR1lYVWJZWmNWSzdRUHpYWG14bmhlZys5?=
 =?utf-8?B?bEhWZXpnMEd0UE1zejdRRGc5L296MWwwZXd2VTV4Y01jeElVaW52VnBFMWxG?=
 =?utf-8?B?cDB1b3hya1JLUkwvcEcyTDhyRFJLK3RoVld3ZkUwL1dKUm9sK1pYWEZaT3Jp?=
 =?utf-8?B?cllWZWh3d0F2R2JMamdkK3hWMzUwdGdhNDJxRGF6N1FudHFJVUhLeWUxYzFv?=
 =?utf-8?B?cDNEWlBGL0U0d1I4K1R5RS9mZ3kvN0gycGZPTjRCWU40cDVUd3JlMmpkRkli?=
 =?utf-8?B?aHlRWU9jVm9NWU9wRFppUHBMdjZPS0MwMWROZFE5cnpNQWd1Znd0STdzZ0xi?=
 =?utf-8?B?ZERPUEtnU0R6TU5EV1B6TjRpRkJIa3JRWW5Zc0pJVlN0UjVKaTVRUzU3RXpr?=
 =?utf-8?B?eVY5SW4yeXpGNkkycE5GaERnNCtVV2NlSmZ0aUtBbmpkeWFyZ0hWQ2dnQzlN?=
 =?utf-8?B?aERhMFRPdzhHWDFidkZFRUpJZWYzWjNLSm9OOGc2MHE4L2wzVTI0QXFhZHR6?=
 =?utf-8?B?QVV2M3dRMzRGckpXaGpORURFeEUrNDYxUjJ3TTgrSjVweWtNTXJEaDdsbDVY?=
 =?utf-8?B?YWdxSVhWNVZpenRDUFBRcnNxdldOY1RkRFQ1Z05ZV0kyaUxwN3lvdTA0VWx5?=
 =?utf-8?B?R0Y3eWxWSjV4L3M1U1pmWGVMZFVGVE91ZGk4NVFDTU5QOVJEVURQTWd4Y1VO?=
 =?utf-8?B?WStrU1ZIQ2Z5NWJOOHBrM0ZYRzVjNzJPVVRBSkdQaTJzdzJnQlZqS0hZVGk1?=
 =?utf-8?B?c0RGMmVSbWI1Z251b0U0V0dJazRwWkd5OFk3Q1JoMHJpL3hjcWIwTmJOMlkz?=
 =?utf-8?B?QlpQWDdxV29RTGkvYTV4WC9KdVN4OU5KNy9VdnluNFlMZ2drU1didCszK09G?=
 =?utf-8?B?ZjlsQUtiUzhEWisreWh4NmF2QkhsT3BRN04yVTIrWVFGMDBOQmRIYzU4cXJP?=
 =?utf-8?B?TlhNcU4wV2J6eUFxZTVvMnpFOEt5L3RQSEFoQWhwclFyQkdkSnEzelQ3dVFJ?=
 =?utf-8?B?endYdFIvUnpqcmc0SVhNL3hIcFFDWmh0QXZZNjBrQ1V4a3llMXJ5aU1PUVRK?=
 =?utf-8?B?UWlKcGJjckh6V2xtOEIvWThnTUU5UjRrcEpTNzltYWF6cXV6OWU0R1c3MCtm?=
 =?utf-8?B?SldhUU5OTFEzZzZWRUZpb3pRWmhPcmtRNWV1YlFReEQ4Z3I2RVVOb3dKT1FR?=
 =?utf-8?B?ZjhNNnFyelc3Q1gvZXR1QWJFd3kwQU1BQ0lBVENiSjA1eTd2aFRmbDN0Y0No?=
 =?utf-8?B?dk9wZG5qcTgxSC83TzlSMDBodTdnVjVhOHdwa1JzbHNXYTVkbzArWG0wNW5N?=
 =?utf-8?B?K3E0VkpXN0JrVWZjaGE4a1U1NktSa0RvNUpWZ2pscUdhTmxSRWRTWjVTNGhp?=
 =?utf-8?B?TXZERTN6eUR2V21nKzZZM1RYVjBJbzdDZE51YjhySHJ1K1BXVkFTTG1KTmdF?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 242112eb-ef3f-4ea0-cd6c-08dac9914dc3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 18:18:34.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oF+1Ts42Uo+2SG/PeruNAwB8DNlmWqjhBr5n9ZzkRmjYXOzUnnwM7hLZwXTCZs4ANHAuIZ03hmStd2Y2W2l5aXL+Hx7TUiJg4hHxwGM4cro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6480
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

On 11/18/2022 3:05 AM, Thomas Gleixner wrote:
> On Fri, Nov 18 2022 at 10:15, Thomas Gleixner wrote:
>> On Fri, Nov 18 2022 at 01:58, Thomas Gleixner wrote:

...

> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index d4f26649a185..d243ad3e5489 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -141,7 +141,7 @@ static int msi_insert_desc(struct device *dev, struct msi_desc *desc,
>  		if (ret)
>  			goto fail;
>  
> -		desc->msi_index = index;
> +		desc->msi_index = index - baseidx;

Could msi_desc->msi_index be made bigger? The hardware I am testing
on claims to support more IMS entries than what the u16 can
accommodate.

>  		return 0;
>  	} else {
>  		if (index >= hwsize) {
> @@ -1476,9 +1476,10 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
>  				       const struct irq_affinity_desc *affdesc,
>  				       union msi_dev_cookie *cookie)
>  {
> +	struct msi_ctrl ctrl = { .domid	= domid, .nirqs = 1, };
> +	struct msi_domain_info *info;
>  	struct irq_domain *domain;
>  	struct msi_map map = { };
> -	struct msi_desc *desc;

(*desc is still needed)

>  	int ret;
>  
>  	msi_lock_descs(dev);
> @@ -1503,12 +1504,16 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
>  		goto unlock;
>  	}
>  
> -	map.index = desc->msi_index;
> -	ret = msi_domain_alloc_irqs_range_locked(dev, domid, map.index, map.index);
> -	if (ret)
> +	ctrl.first = ctrl.last = desc->msi_index;
> +	info = domain->host_data;
> +
> +	ret = __msi_domain_alloc_irqs(dev, domain, &ctrl);
> +	if (ret) {
>  		map.index = ret;
> -	else
> +		msi_domain_free_locked(dev, &ctrl);
> +	} else {
>  		map.virq = desc->irq;
> +	}
>  unlock:
>  	msi_unlock_descs(dev);
>  	return map;

Thank you very much. With the above snippet it is possible to
allocate an IMS IRQ. I am not yet able to use the IRQ and I am working
on more tracing to figure out why. In the mean time, I did
just try the pci_ims_alloc_irq()/pci_ims_free_irq() flow and
pci_ims_free_irq() triggered the WARN below:

remove_proc_entry: removing non-empty directory 'irq/220', leaking at least 'idxd-portal'
WARNING: CPU: XX PID: 4322 at fs/proc/generic.c:718 remove_proc_entry+0x184/0x190

[SNIP]

RIP: 0010:remove_proc_entry+0x184/0x190
Code: a5 af 48 8d 90 68 ff ff ff 48 85 c0 48 0f 45 c2 48 8b 95 88 00 00 00 4c 8b 80 b0 00 00 00 48 8b 92 b0 00 00 00 e8 2d 67 c6 00 <0f> 0b e9 4d ff ff ff e8 a0 c1 ce 00 0f 1f 44 00 00 41 57 41 56 41
RSP: 0018:ff223b51cf947c80 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ff1b39f680241300 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffffafa37b97 RDI: 00000000ffffffff
RBP: ff1b3a06666b8000 R08: ff1b3a15bdbfffe8 R09: 0000000000000003
R10: ff1b3a15bce00000 R11: ff1b3a15bd900000 R12: ff1b3a06666b8090
R13: 00000000000000dd R14: ff1b3a069237fb80 R15: 0000000000000001
FS:  00007fedd2dff000(0000) GS:ff1b3a15be940000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff8e5bfc01c CR3: 000000110a138006 CR4: 0000000000771ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
<TASK>
unregister_irq_proc+0xe3/0x110
free_desc+0x29/0x70
irq_free_descs+0x4b/0x80
msi_domain_free_locked.part.0+0x19b/0x1d0
msi_domain_free_irqs_range+0x67/0xb0
idxd_wq_free_irq+0x89/0x150 [idxd]
drv_disable_wq+0x5f/0x90 [idxd]
idxd_dmaengine_drv_remove+0xa3/0xc0 [idxd]
device_release_driver_internal+0x1aa/0x230
driver_detach+0x44/0x90
bus_remove_driver+0x58/0xe0
idxd_exit_module+0x18/0x3a [idxd]
__do_sys_delete_module.constprop.0+0x186/0x280
? fpregs_assert_state_consistent+0x22/0x50
? exit_to_user_mode_prepare+0x40/0x150
do_syscall_64+0x40/0x90
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fedd2526c9b
Code: 73 01 c3 48 8b 0d 95 21 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 65 21 0f 00 f7 d8 64 89 01 48
RSP: 002b:00007ffca85a47d8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
RAX: ffffffffffffffda RBX: 000055af0e1a3700 RCX: 00007fedd2526c9b
RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055af0e1a3768
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007fedd25beac0 R11: 0000000000000206 R12: 00007ffca85a4a30
R13: 000055af0e1a32a0 R14: 00007ffca85a58e5 R15: 000055af0e1a3700
</TASK>

Reinette
