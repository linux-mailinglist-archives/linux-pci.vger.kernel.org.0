Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C99564F337
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 22:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiLPVd5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 16:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLPVd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 16:33:56 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C8661D68;
        Fri, 16 Dec 2022 13:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671226434; x=1702762434;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zPrC1m7pTV7ebQKfsf9VZu2gOdjLxz7UJNahpzNIrk8=;
  b=bq6sojZsf0BZrSFSIC18gfZnSQMiYz5M8kIZbD3BUnqbRHJkDSHGYLiw
   YczMCgFcs2jm994EN6PusIrD9wNZcCZIK6qVFssJ54RVTdMAdHNj5317C
   LtVLH2JOMfnDVh8TYbBAcz76GSYYUceXrGcbpt5y0pzmCeL9Om8JwcFLM
   pvJFRIiI110q3GgWlUPbxbzNWkM0yEC+mt/+H5yifCY1JaIRma4XEuTvH
   oQRxWQEzD0hE2rzJ1eMRg6YEqj275kFE/GIuNu29Igvg2zF2imIbeqQIR
   xg1nRf8tQLu+wTyu907NTB7uktwmGboeqS2r3eikq4NgTQJgl5YlSafCf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="306739203"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="306739203"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 13:33:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="738672349"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="738672349"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Dec 2022 13:33:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 13:33:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 13:33:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 13:33:52 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 13:33:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=covzjGbiU9Qta9Ia5VWPgUfAKKCw9awu2hJgg/u2ElcFoj3wBKZ9dohUa5F1V5xS7au0yyDAAZUQ9LMGrHRpL64Sb7blmy9PX+guix+XE/177MQiIzViryvimoe/zfQDubqRPmbHbfIhoGBOXTwvcrEj4hG8bPFdrB8L+PI4E/C4yvJ4vbqNzrKswL9MvCnSP7BEuBR5mg3Rdfal2DWCBNhf7r0Do5gX5fGQzJ9/iX8l+oaDHot10FLnOHGMummY84+9IEHY5WNbLvNL6uLOvN++44yxNtQUiyvNjhR40wwdF0pnh5BesMnz/ohXGELYmnkJHrR2akNDJoY9kBMLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEIKVxAFhNt3iAMsdEwKVD1dDW1NDL9HQReDGAcIBFQ=;
 b=eOXX0ProXmi+soJ1d/ctreJH/J3psZw5khs9FoRbKHsULSlGlB+M1d/wTjyqnAwPgiu6fVC4Prk30zTDKF6NSUgAFFguAcH41Ua6WJarMV3JoBB6nTAm6LKKq3W39CbpJfWOKvwBTceVFlIaqtuH9jvkYq1QFvDuMEI6mYLLyywMnLfRYBKLPac2YQqpnj8Zh9Yo6bqTJi/LUAMf/tGrTjhAuNz/B4wkBV9fEfr23LtlbibQMNCCaMzRY+b+lbiNjfdIMn0X6m/ICsjOKJ9HhLmnhV8GMoi+9TdZwo44aq477PtW8LR8Firv/dNpt5SRpxQt5sFDS6B76zbLke3AUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN0PR11MB5695.namprd11.prod.outlook.com (2603:10b6:408:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 21:33:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 21:33:47 +0000
Date:   Fri, 16 Dec 2022 13:33:43 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 3/9] cxl/mem: Wire up event interrupts
Message-ID: <Y5zkNxGan2rmSJW0@iweiny-desk3>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
 <20221212070627.1372402-4-ira.weiny@intel.com>
 <20221216182110.00003f62@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221216182110.00003f62@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0192.namprd05.prod.outlook.com
 (2603:10b6:a03:330::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN0PR11MB5695:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc3197f-4e0b-4fd7-2394-08dadfad36ee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfyLiNodqGl6SLLi9mUJeRZrRHmVFee54xYm2+9lG0lN2p4Mw5EonFc5UHz9/FGJLEJx3pCG6D0nHm8KPilxqigGrdCafXfY+z7cO0LSV/LkDnle3QOJ/14jtQlW6iJ5WZwDAtBO8Ao7DdGYBTENe017ApuUvcNyG5dIGfxUel3Q/AHO6SIppi2/6od6xPASlsCQBHeM9fIpsE7lyWUisv7y3tDVjlNiA0yog1S7fSodayFIFjGvyZYDuTEKquvHmrfYPaDc0glp6LpUrmmwaFFqYFSDb8IVV9qrJCE+tikNXVyZcGO0gZqQL/it0VL8Euua42lGr+xMJ71lJIysQnXa6lURTb4z0Rf2iikFsaNjfG+t+NBIEvNgbu9b2FpRjCUNW8THTkiM5XFvEO/Ixf12vbcVgYGGR8DU50TmmLuMiI2UKOYDotNIcRhkLh2Q9BMEqxbrQlSL6bTgMbwsXGYG7cq3KULZt0Ffmc2LRW1lx4Dhf19WaK+rKFh8UY0o2hxl6RV4hEeblmIFaTdawB7S95pHHTG0qhfONIwISDtk6o0lHSNW1bOYdG6DuzFcgiCOZ2WiUuEMF5DMbqj3K7PJU/82UzVyFHcRJZOBy3lokPuL8s52oR+znJ13TdZ7koblI6RptkCa0kmtnIA+BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199015)(86362001)(316002)(6916009)(478600001)(54906003)(6486002)(33716001)(44832011)(6666004)(5660300002)(30864003)(2906002)(8676002)(4326008)(66476007)(66556008)(66946007)(8936002)(41300700001)(38100700002)(82960400001)(9686003)(6506007)(186003)(26005)(6512007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qwJ7tuYKG0sQxy9W4F/ZWBuWmS17UDnu6FvVebQRELbiUO5j23H9auNS28nC?=
 =?us-ascii?Q?fnkUDoRXfiuNmrXhkzyppq5qMnFOF6HJncdUPqJpQsBhCaEh+rkdatSzKJNl?=
 =?us-ascii?Q?qbFQHabHtqVjRNtSrua2V5j02xeNc0/dVX2XvzCCoAznq9XurEgOGYXgQGr5?=
 =?us-ascii?Q?3+Au9CBdRtK9x20ONpLRevIX1UdsiOO+R7RmAVNuHI7HQAlMxdKqb2ViVyPR?=
 =?us-ascii?Q?BsPsQljOYoAm7tGz7wAdNAVM3Tn2DunQyPbsm9pPhQEG2kds7B+lersJHVR4?=
 =?us-ascii?Q?C5axNT+tPpkiUsK/Nlx5af+8QHJEjYlgmCSc4GOZ1rPo3BY42d9d6sN74IAr?=
 =?us-ascii?Q?ZKvd6jrq5X1bjLRoMXZ5AsYKRjHLkhGtpwoqo0UVMv06QbgU7QYM1mua9RZk?=
 =?us-ascii?Q?kmKXRLbMLN74bb5wi/+zrtf34/A4rIlYFbcjbwtem6FQiFbXmAdesnjXg+L2?=
 =?us-ascii?Q?cshuTfgb9F028Uv2rRCAXuOA4+WwUgWp6cdsv8IGrCFNXHj+739bERDmB8M/?=
 =?us-ascii?Q?G6cR/YTx4iSJJk8H8FDOhsFoNYzgOAmJSCUnWIkYwYDhmA1v+TQXVTnKAnZ4?=
 =?us-ascii?Q?RnqXSx34Neeo9xAhW12MTPU9kPqYFwZ1HBQr4HlC3rtWph24We5V9zdHiQEA?=
 =?us-ascii?Q?D9cVYV1FDuioQQsCOZD5tn63FF99wnrTm3yjmCiqBa67mjkA12Mw7LQE9rde?=
 =?us-ascii?Q?7b3UGhoeF45Thkc0giprr3Y0rZ4L0HDcXpSfbAiDbem/sWjJzMEBJJfnNYsd?=
 =?us-ascii?Q?HgfM6fRXYVCnCaw3Uvjy26Yeb+O7m90euo4FMMDIFy8ugagX8lWky+8x5b1x?=
 =?us-ascii?Q?5e3az1Iy/d/966apumM/42krtkEw62Ppan5kxTbSPYHkAlWzr0GzNLLRgapo?=
 =?us-ascii?Q?ttB7ETsK9ExLPD1mc9NhbWCEU87bkn0ZFQikp+8hCwWUbXh61Amsj5SQMApg?=
 =?us-ascii?Q?Hk6lWIdbjThB60yoF7ED9DZ5AngjJ2KMMCnDI/lIlcdvhE78lUCrAk5eHFFj?=
 =?us-ascii?Q?fX18tku2k2twrZtScsw+qb4IQEVkAooJ7s3i6FX8jVIGFKYKVe5YoZbcImc7?=
 =?us-ascii?Q?vGG6+9Tc3rizqkahwWg7Ggdf/aQn5A2NLU3IbAiDw9MdAvYQBq3WRS+SRE9H?=
 =?us-ascii?Q?0sOcShQCG76pfoOCmE0gAMqEccjM0uosmlPMZHXsegixIDDRpa1CFupdOwBn?=
 =?us-ascii?Q?LDY7f/pyjwlf4LCMECopaZNj/FtHLCDOU6ey2D639uIooZp6CjDgK6uAGZ3D?=
 =?us-ascii?Q?SeipN68KjCUlXfKlog+65kM3Md0sr1VkBFaKFF4uhAHNw126TwWGPqrtDmgX?=
 =?us-ascii?Q?Slo8fiucldFUQoS9phLIHAhxJUd3F+mQTXYve+aekdc9T80Mq00j+m7HZAid?=
 =?us-ascii?Q?+CLXHPzX7kLQYr9WPbtGzlaAgem7sCOZLstEjzk5OideCrM4U43SBchvva5v?=
 =?us-ascii?Q?8g4vMw4nU09y24pHJwoHtnFjm2uiJw4bZz8S2eC8FxBQyK8uUur6/YMbsxZF?=
 =?us-ascii?Q?HbEGYVdfMyMoNyOaRAa44UrPZAV/afNJ5upMrzmfhIRDkeqiX3VL6+pJF9cE?=
 =?us-ascii?Q?xMgXcO1ptGLILpNfpnlArElJWTAOp5gKy7YpA0nkOLxBmu6zRn2d4mdgYT6T?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc3197f-4e0b-4fd7-2394-08dadfad36ee
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 21:33:47.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubKmXfZM9xSa9SPZiPgCmgB91Zf1KuRqFUueVXoK0uE4kVUoNB6al8BMPhe5s100LORcncnsswlXqnPAnmJ5+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5695
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 16, 2022 at 06:21:10PM +0000, Jonathan Cameron wrote:
> On Sun, 11 Dec 2022 23:06:21 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Davidlohr Bueso <dave@stgolabs.net>
> > 
> > Currently the only CXL features targeted for irq support require their
> > message numbers to be within the first 16 entries.  The device may
> > however support less than 16 entries depending on the support it
> > provides.
> > 
> > Attempt to allocate these 16 irq vectors.  If the device supports less
> > then the PCI infrastructure will allocate that number.  Upon successful
> > allocation, users can plug in their respective isr at any point
> > thereafter.
> > 
> > CXL device events are signaled via interrupts.  Each event log may have
> > a different interrupt message number.  These message numbers are
> > reported in the Get Event Interrupt Policy mailbox command.
> > 
> > Add interrupt support for event logs.  Interrupts are allocated as
> > shared interrupts.  Therefore, all or some event logs can share the same
> > message number.
> > 
> > In addition all logs are queried on any interrupt in order of the most
> > to least severe based on the status register.
> > 
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> Sometimes it feels like we go around in circles as I'm sure we've
> fixed this at least 3 times now in different sets that got dropped
> (was definitely in the DOE interrupt support set and was controversial ;)

Well I certainly seem to be spinning ATM.  I probably need more eggnog.  ;-)

> 
> Nothing in this patch set calls pci_set_master() so no interrupts
> will even be delivered.

Is this a bug in Qemu then?  Because this _is_ tested and irqs _were_
delivered.  I thought we determined that pci_set_master() was called in
pcim_enable_device() but I don't see that now.  :-(

What I do know is this works with Qemu.  :-/

Ira

> I don't think there are any sets in flight
> that would fix that.
> 
> Jonathan
> 
> 
> > 
> > ---
> > Changes from V3:
> > 	Adjust based on changes in patch 1
> > 	Consolidate event setup into cxl_event_config()
> > 	Consistently use cxl_event_* for function names
> > 	Remove cxl_event_int_is_msi()
> > 	Ensure DCD log is ignored in status
> > 	Simplify event status loop logic
> > 	Dan
> > 		Fail driver load if the irq's are not allocated
> > 		move cxl_event_config_msgnums() to pci.c
> > 		s/CXL_PCI_REQUIRED_VECTORS/CXL_PCI_DEFAULT_MAX_VECTORS
> > 		s/devm_kmalloc/devm_kzalloc
> > 		Fix up pci_alloc_irq_vectors() comment
> > 		Pass pdev to cxl_alloc_irq_vectors()
> > 		Check FW irq policy prior to configuration
> > 	Jonathan
> > 		Use FIELD_GET instead of manual masking
> > ---
> >  drivers/cxl/cxl.h    |   4 +
> >  drivers/cxl/cxlmem.h |  19 ++++
> >  drivers/cxl/cxlpci.h |   6 ++
> >  drivers/cxl/pci.c    | 208 +++++++++++++++++++++++++++++++++++++++++--
> >  4 files changed, 231 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 5974d1082210..b3964149c77b 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -168,6 +168,10 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
> >  				 CXLDEV_EVENT_STATUS_FAIL |	\
> >  				 CXLDEV_EVENT_STATUS_FATAL)
> >  
> > +/* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
> > +#define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
> > +#define CXLDEV_EVENT_INT_MSGNUM_MASK	GENMASK(7, 4)
> > +
> >  /* CXL 2.0 8.2.8.4 Mailbox Registers */
> >  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
> >  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index dd9aa3dd738e..bd8bfbe61ec8 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -194,6 +194,23 @@ struct cxl_endpoint_dvsec_info {
> >  	struct range dvsec_range[2];
> >  };
> >  
> > +/**
> > + * Event Interrupt Policy
> > + *
> > + * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
> > + */
> > +enum cxl_event_int_mode {
> > +	CXL_INT_NONE		= 0x00,
> > +	CXL_INT_MSI_MSIX	= 0x01,
> > +	CXL_INT_FW		= 0x02
> > +};
> > +struct cxl_event_interrupt_policy {
> > +	u8 info_settings;
> > +	u8 warn_settings;
> > +	u8 failure_settings;
> > +	u8 fatal_settings;
> > +} __packed;
> > +
> >  /**
> >   * struct cxl_event_state - Event log driver state
> >   *
> > @@ -288,6 +305,8 @@ enum cxl_opcode {
> >  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> >  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> >  	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
> > +	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
> > +	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
> >  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> >  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> >  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index 77dbdb980b12..a8ea04f536ab 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -53,6 +53,12 @@
> >  #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
> >  #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
> >  
> > +/*
> > + * NOTE: Currently all the functions which are enabled for CXL require their
> > + * vectors to be in the first 16.  Use this as the default max.
> > + */
> > +#define CXL_PCI_DEFAULT_MAX_VECTORS 16
> > +
> >  /* Register Block Identifier (RBI) */
> >  enum cxl_regloc_type {
> >  	CXL_REGLOC_RBI_EMPTY = 0,
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index a2d8382bc593..d42d87faddb8 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -445,6 +445,201 @@ static int cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
> >  	return 0;
> >  }
> >  
> > +static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
> > +{
> > +	int nvecs;
> > +
> > +	/*
> > +	 * CXL requires MSI/MSIX support.
> > +	 *
> > +	 * Additionally pci_alloc_irq_vectors() handles calling
> > +	 * pci_free_irq_vectors() automatically despite not being called
> > +	 * pcim_*.  See pci_setup_msi_context().
> > +	 */
> > +	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_DEFAULT_MAX_VECTORS,
> > +				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
> > +	if (nvecs < 1) {
> > +		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
> > +		return -ENXIO;
> > +	}
> > +	return 0;
> > +}
> > +
> > +struct cxl_dev_id {
> > +	struct cxl_dev_state *cxlds;
> > +};
> > +
> > +static irqreturn_t cxl_event_thread(int irq, void *id)
> > +{
> > +	struct cxl_dev_id *dev_id = id;
> > +	struct cxl_dev_state *cxlds = dev_id->cxlds;
> > +	u32 status;
> > +
> > +	do {
> > +		/*
> > +		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
> > +		 * ignore the reserved upper 32 bits
> > +		 */
> > +		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> > +		/* Ignore logs unknown to the driver */
> > +		status &= CXLDEV_EVENT_STATUS_ALL;
> > +		if (!status)
> > +			break;
> > +		cxl_mem_get_event_records(cxlds, status);
> > +		cond_resched();
> > +	} while (status);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct cxl_dev_id *dev_id;
> > +	int irq;
> > +
> > +	if (FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting) != CXL_INT_MSI_MSIX)
> > +		return -ENXIO;
> > +
> > +	/* dev_id must be globally unique and must contain the cxlds */
> > +	dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
> > +	if (!dev_id)
> > +		return -ENOMEM;
> > +	dev_id->cxlds = cxlds;
> > +
> > +	irq =  pci_irq_vector(pdev,
> > +			      FIELD_GET(CXLDEV_EVENT_INT_MSGNUM_MASK, setting));
> > +	if (irq < 0)
> > +		return irq;
> > +
> > +	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
> > +					 IRQF_SHARED, NULL, dev_id);
> > +}
> > +
> > +static int cxl_event_get_int_policy(struct cxl_dev_state *cxlds,
> > +				    struct cxl_event_interrupt_policy *policy)
> > +{
> > +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
> > +		.payload_out = policy,
> > +		.size_out = sizeof(*policy),
> > +	};
> > +	int rc;
> > +
> > +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > +	if (rc < 0)
> > +		dev_err(cxlds->dev, "Failed to get event interrupt policy : %d",
> > +			rc);
> > +
> > +	return rc;
> > +}
> > +
> > +static int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> > +				    struct cxl_event_interrupt_policy *policy)
> > +{
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	int rc;
> > +
> > +	policy->info_settings = CXL_INT_MSI_MSIX;
> > +	policy->warn_settings = CXL_INT_MSI_MSIX;
> > +	policy->failure_settings = CXL_INT_MSI_MSIX;
> > +	policy->fatal_settings = CXL_INT_MSI_MSIX;
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
> > +		.payload_in = policy,
> > +		.size_in = sizeof(*policy),
> > +	};
> > +
> > +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > +	if (rc < 0) {
> > +		dev_err(cxlds->dev, "Failed to set event interrupt policy : %d",
> > +			rc);
> > +		return rc;
> > +	}
> > +
> > +	/* Retrieve final interrupt settings */
> > +	return cxl_event_get_int_policy(cxlds, policy);
> > +}
> > +
> > +static int cxl_event_irqsetup(struct cxl_dev_state *cxlds)
> > +{
> > +	struct cxl_event_interrupt_policy policy;
> > +	int rc;
> > +
> > +	rc = cxl_event_config_msgnums(cxlds, &policy);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = cxl_event_req_irq(cxlds, policy.info_settings);
> > +	if (rc) {
> > +		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
> > +		return rc;
> > +	}
> > +
> > +	rc = cxl_event_req_irq(cxlds, policy.warn_settings);
> > +	if (rc) {
> > +		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
> > +		return rc;
> > +	}
> > +
> > +	rc = cxl_event_req_irq(cxlds, policy.failure_settings);
> > +	if (rc) {
> > +		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
> > +		return rc;
> > +	}
> > +
> > +	rc = cxl_event_req_irq(cxlds, policy.fatal_settings);
> > +	if (rc) {
> > +		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
> > +		return rc;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static bool cxl_event_int_is_fw(u8 setting)
> > +{
> > +	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
> > +
> > +	return mode == CXL_INT_FW;
> > +}
> > +
> > +static int cxl_event_config(struct pci_host_bridge *host_bridge,
> > +			    struct cxl_dev_state *cxlds)
> > +{
> > +	struct cxl_event_interrupt_policy policy;
> > +	int rc;
> > +
> > +	/*
> > +	 * When BIOS maintains CXL error reporting control, it will process
> > +	 * event records.  Only one agent can do so.
> > +	 */
> > +	if (!host_bridge->native_cxl_error)
> > +		return 0;
> > +
> > +	rc = cxl_event_get_int_policy(cxlds, &policy);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (cxl_event_int_is_fw(policy.info_settings) ||
> > +	    cxl_event_int_is_fw(policy.warn_settings) ||
> > +	    cxl_event_int_is_fw(policy.failure_settings) ||
> > +	    cxl_event_int_is_fw(policy.fatal_settings)) {
> > +		dev_err(cxlds->dev, "FW still in control of Event Logs despite _OSC settings\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	rc = cxl_event_irqsetup(cxlds);
> > +	if (rc)
> > +		return rc;
> > +
> > +	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> > @@ -519,6 +714,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > +	rc = cxl_alloc_irq_vectors(pdev);
> > +	if (rc)
> > +		return rc;
> > +
> >  	cxlmd = devm_cxl_add_memdev(cxlds);
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> > @@ -527,12 +726,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > -	/*
> > -	 * When BIOS maintains CXL error reporting control, it will process
> > -	 * event records.  Only one agent can do so.
> > -	 */
> > -	if (host_bridge->native_cxl_error)
> > -		cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> > +	rc = cxl_event_config(host_bridge, cxlds);
> > +	if (rc)
> > +		return rc;
> >  
> >  	if (cxlds->regs.ras) {
> >  		pci_enable_pcie_error_reporting(pdev);
> 
