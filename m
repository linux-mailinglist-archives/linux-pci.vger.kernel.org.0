Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ED2648C6C
	for <lists+linux-pci@lfdr.de>; Sat, 10 Dec 2022 02:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiLJBpK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 20:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLJBpI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 20:45:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638C86BCA4;
        Fri,  9 Dec 2022 17:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670636706; x=1702172706;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mqEx4p8I40tKrW+c+1UgLIjFY/5Jc0NNr+V2OMEVUkg=;
  b=hPvxYoeT7XfK5u/lQiuK6nKqx1xeIctggXeoCdbIB3nzrrd1Z10iZFZP
   b8eN3OHgHptUe5oY18e/lcMBR8LOasNCX2Bgwt0J6w2LaGZFKIFyVEjr5
   ZAzVwSSVXkeK1qS98AOvPsrap/93o7s7O50wZ64oXBQOhoAfhfsQE/m7V
   kfajT1Nr565BGXPeA1PVI91R8C9jmm8Xeu0PRNyHGLQO2K3cbos2vBPwG
   sXwswudfmoqwcfr5HmJ8FcfxvosFVOcK0lnGSNTIF4g6gypa4+nOjs+Xe
   /PKFSvoo8MrzrugTafHx5XXKGTO4Btmo0r9iWMA5V2Nft4jtCVJ6vlqQc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="317609382"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="317609382"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 17:45:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="892866472"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="892866472"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 09 Dec 2022 17:45:05 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 17:45:05 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 17:45:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 17:45:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 17:45:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxrtIYzvb3YxS8DTBquAxY1i33GimP9zkixz7Q1NC/AZ9fKOIsukGyZqnABfbZ1l2lRDxqu0rUA6QFmm1CUgKyLa9BLmxzhbZ6ag1G1Bt7j9bgZQkN1sUIybI1DzUZVeFGTf3xYM5P/V0KMvmm7jIrnwuDSjxHvgMaLvUe+PbCUkqgLEUXqAsK4Ao14mK3JYuvmcQQotvZcZxCb5ssF1x/+LXUZh7QTvNIswyGgECJiioBHJtXv/jsspOGXReHxIAvC6WffvIn5Abei2bnWyLMieUXWKsz9dh7j2MQPpgPodpvI6fNyf42G8Biub8XC8XeIqNfakhmmbOjWyyx04LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vn4MGSgWkjWS01z1+LIC4xcM9r4L3oRTvfr5PVtLwg=;
 b=cDFp1PMToUbfEHGqlrTJbdxHxkSSHlRYibTLLTGmjv84hzybvhqiv4JnqQaVJTqAXm5L2w+Wu/qt1Lc/KmPNPFy3IeGWKIqD1OvKDPKrSUb9lTzOaS0Dcejlm5k8rkGn4bn8Nth846J58FeEPfUytz+iYhmfZEcQqC9VOPWAKk82H+C6C6Ad+5jbKKuVrteTkn660T7++I4+b5pvoF2d7qQju211r7i8NLDizshKx1lzIDtOX3fgz+c8kNn8FCADz5EZrFUqHfqaRf88dPdDn4p6GJT0YzkRgy4C5cN4/aPD1oKMcH9rVJijTprw+lZ2/TuJuIL2O5H7OHT/zq+5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6431.namprd11.prod.outlook.com (2603:10b6:8:b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Sat, 10 Dec 2022 01:45:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.019; Sat, 10 Dec 2022
 01:45:01 +0000
Date:   Fri, 9 Dec 2022 17:44:55 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V3 2/8] cxl/mem: Wire up event interrupts
Message-ID: <Y5Pkl1sOeDzeIRQO@iweiny-desk3>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-3-ira.weiny@intel.com>
 <6393ad74877d9_579c129448@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6393ad74877d9_579c129448@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b67c864-991d-409e-e462-08dada5026bd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xsRhv2x74vpRca8S8W8t7jmnTEqUnq4y0HZkkF7z9Z7eOOrceZHFhV+TdxCGERLkaKFt36qoqXCKgQd9iqrTmxEU1rmxmTK/KskS05esyCutb1wKw+WANFwXfYUeZB40XTuPuxGoF46Epc09Wo+yqDZps/IcyNwBjYqWSyzRFPKE0gqaQXDK7KljKYX31Z6RPFsnf3YvoM0Ki5nx/0uksU1UHkC0V00rK/ByYA4HqnQxzwH6Y+L5GqsRGm+98APFSiTJF7bwbCjWSS3aHxteSSLpYOkr0axSFotWpFc+e8781CfwC+gAQawCF4MUuj+uvGO8Ca6EAmzyce89w3ZnfYLtx+dBLvJF+OPLT+CIvrzvc3ENXSYPdkjrC/R5wqKGxk38k84D3OVezRMry6oUsQ9XAGvs2JqQDaOBEfhhosXTBZ3sCcaq6Y1hxRGMgkLh2QbpRF8d7cTPGNwTPMjeZnafVmKndFZa91Lv6pda0scTCHi2+CNgBBecTI8m73dkr1DS6ASLMrxig++TRA8mNCJZCqlO3W6HdOVMBe9MqIN543c/ur69idynBkTKgnIO69xKwNmMUu+XsS27TaX4e8iZmc2tjQySva4lGi3oqkAfAbWB8weVX4bRm9TVrKeJd9687IgOB4qmsEumQ7OVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(6486002)(6506007)(86362001)(6862004)(316002)(66556008)(30864003)(6666004)(5660300002)(26005)(54906003)(8936002)(6636002)(2906002)(66476007)(44832011)(66946007)(4326008)(9686003)(38100700002)(83380400001)(478600001)(8676002)(186003)(41300700001)(6512007)(82960400001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bgBY0Yd3/arYLBC1p2sqILwRkXnLDJ5Ajlv8IphB2iJyhh+THfLcOBBYIXuV?=
 =?us-ascii?Q?JkFQkrcaCxTIZCkGdS6ctRfViKehKPzf/SeSr3K1Pa+4AnoCfcVkjAtxZ2sv?=
 =?us-ascii?Q?qhffPcxr/ZAlNZCfS2wM+YAMWmfle7SW2s4Or2QeBrdQrzbE1e7ISTJ++xdv?=
 =?us-ascii?Q?+tDIfW65KSYvZspsu7ii9hUAITEUzEcVDKOEP+KCupXQ+jhuJHE/6RV1lVn0?=
 =?us-ascii?Q?DGkjQ6qXdqKAa056ta5mavdKSjBnDyL0hRM7SCnbLBvaEkeWGT0Kvm78LHqJ?=
 =?us-ascii?Q?Rmr60pWp/9LKeNM6DBKyft80xPoIY9C2hlk/S+WjjboFLkg4bg+o0LrPGKFH?=
 =?us-ascii?Q?FiqDBa4uQzcWg9aUHMh+ThOHK7SjEbNwtZXLGw4drLWIVabZa729SJF9WNVa?=
 =?us-ascii?Q?SljLVMGXrUPubQTfP92Q9iZSASFfDdsbb1YbcJB1zUYx/xDDp1nssDQ6/Kxg?=
 =?us-ascii?Q?rerXFDdJnDaT6EDcFpSb5FGZMb9FCvrFDJ/q9fX7EfO9N+8Bmsu5d8xOF/iN?=
 =?us-ascii?Q?ZOSiuUWOzaEGOfXGXwbwT4i3xYOnjmiNj2iVQap8Cf6YK69xQHdzRtj+0dFX?=
 =?us-ascii?Q?+TXVkRk8j8org6fLor1DPifHcKW6oRpaFnVzacgTd9rGcQGPz2QF1u8nuPq2?=
 =?us-ascii?Q?WbncrEBH2IWteTIPoF0yAsdbvvCuGpF/4VVBGlRPa/AeKOGcwzI5Tk6I5gb0?=
 =?us-ascii?Q?gQ8pBg6QVzkGEjw83d4xkkkLsUlkiaC5dSOzhkHMZBag+IaSp368Y0LWKsVU?=
 =?us-ascii?Q?eqZqWqNm6YgXFdmNOi8+wRnImHjbEWdRVRNUZbAUmxLNxlE9oo5qx8COJBMJ?=
 =?us-ascii?Q?w1Wzvl18H7sP2TZ42wso8RjvGQRuYQhgyO3527J+BspoPrgSMxLohiI4nBXO?=
 =?us-ascii?Q?MZUssnU+5GCGQKBxdIrHEPRHK/9Y9/+nPrULQrbLBbcj+YdAPs6CNPzg1zWh?=
 =?us-ascii?Q?aoKlDN+lzB2BeSdOdWc2JTVsIWWnWs0xwKQPEmPcuR63byqou3/CY4Y2o1l1?=
 =?us-ascii?Q?Zqu9valCdEUIJWwAMo8qBc2Hh6yGS1or5jcSN7etSV3dVgI2Cv5HmLNftflv?=
 =?us-ascii?Q?C5FFvdMiXqc8EaacXc6i77r6flNRW478vZSXlPFOc9qCrlDoMJjROjq92JUd?=
 =?us-ascii?Q?iAk/VCqde1f05SAxOFs6LEbRLC0NwU1OxXnyuQBbJdhZwJzeBorZzI5VIZDF?=
 =?us-ascii?Q?ggozTUuBltN0Tv2HtI9iS9eGa0UpqWl39SGIbj48MhXw+OWjsyYLnbRrIEMg?=
 =?us-ascii?Q?68qPg23ovpwUlyrd2QY41N9MSNIkBxJcJlF886Fc53zyEBVAk5CrazRzKRI1?=
 =?us-ascii?Q?ajwJi83IpJHQbLMO8tCQP74KbhHIV4ucsgr1db1judGyRo5e63dGDW352KM9?=
 =?us-ascii?Q?ubBzbs1VZUboU7bb5UdID5WPU2CGncd2yHyJWrag9fbBDtnmrNvdkDGSyb7y?=
 =?us-ascii?Q?6V+i4/1MAW+JakxhcZMlFppi8EW3kRjl7jNb2mtx6Nb8h+OeBX/9iffoURxA?=
 =?us-ascii?Q?7q9MW8XYl2FcNyaZ4SPzzVGx58JCf6UBMSWWClztBQbdudGs4sQAWpxUeVTc?=
 =?us-ascii?Q?i84uyoXugWTvi8l4LYqLtsA70UBvHFe28UJnxmBR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b67c864-991d-409e-e462-08dada5026bd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2022 01:45:01.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gx5QcrmRMd7PWeR47VXdQtYRCAOl8fHHA+KwyCrjKEzoT5+VkE958p6OiJZd3JvNKZuq94i1OvxwRdOHVXR2Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6431
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 01:49:40PM -0800, Dan Williams wrote:
> ira.weiny@ wrote:
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
> > 
> > ---
> > Changes from V2:
> > 	General clean up
> > 	Use cxl_log_id to ensure each irq is unique even if the message numbers are not
> > 	Jonathan/Dan
> > 		Only set up irq vector when OSC indicates OS control
> > 	Dan
> > 		Loop reading while status indicates there are more
> > 			events.
> > 		Use new cxl_internal_send_cmd()
> > 		Squash MSI/MSIx base patch from Davidlohr
> > 		Remove uapi defines altogether
> > 		Remove use of msi_enabled
> > 	Remove the use of cxl_event_log_type_str()
> > 	Pick up tag
> > 
> > Changes from V1:
> > 	Remove unneeded evt_int_policy from struct cxl_dev_state
> > 	defer Dynamic Capacity support
> > 	Dave Jiang
> > 		s/irq/rc
> > 		use IRQ_NONE to signal the irq was not for us.
> > 	Jonathan
> > 		use msi_enabled rather than nr_irq_vec
> > 		On failure explicitly set CXL_INT_NONE
> > 		Add comment for Get Event Interrupt Policy
> > 		use devm_request_threaded_irq()
> > 		Use individual handler/thread functions for each of the
> > 		logs rather than struct cxl_event_irq_id.
> > 
> > Changes from RFC v2
> > 	Adjust to new irq 16 vector allocation
> > 	Jonathan
> > 		Remove CXL_INT_RES
> > 	Use irq threads to ensure mailbox commands are executed outside irq context
> > 	Adjust for optional Dynamic Capacity log
> > ---
> >  drivers/cxl/core/mbox.c | 42 +++++++++++++++++++
> >  drivers/cxl/cxlmem.h    | 28 +++++++++++++
> >  drivers/cxl/cxlpci.h    |  6 +++
> >  drivers/cxl/pci.c       | 90 ++++++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 165 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 815da3aac081..2b25691a9b09 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -854,6 +854,48 @@ void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> >  
> > +int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> > +			     struct cxl_event_interrupt_policy *policy)
> > +{
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	int rc;
> > +
> > +	policy->info_settings = CXL_INT_MSI_MSIX;
> > +	policy->warn_settings = CXL_INT_MSI_MSIX;
> > +	policy->failure_settings = CXL_INT_MSI_MSIX;
> > +	policy->fatal_settings = CXL_INT_MSI_MSIX;
> 
> For Robustness Principle "be conservative in what is sent" purposes I
> would do the Get Events first to make sure that nothing is steered to
> the Firmware VDM, and warn the user that their BIOS gave the OS CXL
> Error Control, but did not shutdown event interrupts.
> 
> I.e. if the event interrupts are still steered to BIOS then BIOS may
> think it still has control of the event logs and trouble ensues.

Easy enough to do.

> 
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
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
> > +		.payload_out = policy,
> > +		.size_out = sizeof(*policy),
> > +	};
> > +
> > +	/* Retrieve interrupt message numbers */
> > +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > +	if (rc < 0) {
> > +		dev_err(cxlds->dev, "Failed to get event interrupt policy : %d",
> > +			rc);
> > +		return rc;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_event_config_msgnums, CXL);
> 
> A question, why is this function in the core and not in cxl_pci? For
> cxl_test mocking purposes? Otherwise seems ok to keep this in the same
> file as its only caller.

Just following the pattern that functions issuing mailbox commands were in the
core/mbox.c...  I did not realize that was so that they could be in the mock
module.

I'll move it.

> 
> > +
> >  /**
> >   * cxl_mem_get_partition_info - Get partition info
> >   * @cxlds: The device data for the operation
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index dd9aa3dd738e..350cb460e7fc 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -194,6 +194,30 @@ struct cxl_endpoint_dvsec_info {
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
> > +#define CXL_EVENT_INT_MODE_MASK 0x3
> > +#define CXL_EVENT_INT_MSGNUM(setting) (((setting) & 0xf0) >> 4)
> > +struct cxl_event_interrupt_policy {
> > +	u8 info_settings;
> > +	u8 warn_settings;
> > +	u8 failure_settings;
> > +	u8 fatal_settings;
> > +} __packed;
> > +
> > +static inline bool cxl_evt_int_is_msi(u8 setting)
> > +{
> > +	return CXL_INT_MSI_MSIX == (setting & CXL_EVENT_INT_MODE_MASK);
> > +}
> > +
> >  /**
> >   * struct cxl_event_state - Event log driver state
> >   *
> > @@ -288,6 +312,8 @@ enum cxl_opcode {
> >  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> >  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> >  	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
> > +	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
> > +	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
> >  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> >  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> >  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> > @@ -525,6 +551,8 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
> >  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> >  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> >  void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
> > +int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> > +			     struct cxl_event_interrupt_policy *policy);
> >  #ifdef CONFIG_CXL_SUSPEND
> >  void cxl_mem_active_inc(void);
> >  void cxl_mem_active_dec(void);
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index 77dbdb980b12..4aaadf17a985 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -53,6 +53,12 @@
> >  #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
> >  #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
> >  
> > +/*
> > + * NOTE: Currently all the functions which are enabled for CXL require their
> > + * vectors to be in the first 16.  Use this as the max.
> > + */
> > +#define CXL_PCI_REQUIRED_VECTORS 16
> > +
> >  /* Register Block Identifier (RBI) */
> >  enum cxl_regloc_type {
> >  	CXL_REGLOC_RBI_EMPTY = 0,
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 86c84611a168..c84922a287ec 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -452,6 +452,90 @@ static void cxl_clear_event_logs(struct cxl_dev_state *cxlds)
> >  	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> >  }
> >  
> > +static void cxl_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int nvecs;
> > +
> > +	/*
> > +	 * pci_alloc_irq_vectors() handles calling pci_free_irq_vectors()
> > +	 * automatically despite not being called pcim_*.  See
> > +	 * pci_setup_msi_context().
> > +	 */
> 
> I think a more important comment is why the flags are limited to MSIX
> and MSI, that's a non-obvious CXL spec constraint.

Ok yea I'll add that.

But I think the above is important as I missed that detail and went off the
rails.  I would not want someone trying to 'fix' this by adding a devres action
later.

> 
> > +	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_REQUIRED_VECTORS,
> 
> Since I have some other fixups below I'll go ahead and quibble with the
> name. The 'requirement' is 1 vector, so
> s/CXL_PCI_REQUIRED_VECTORS/CXL_PCI_DEFAULT_VECTORS/ or something like
> that. As it stands today there are diminishing returns to ask for more
> than that amount.

ok.

> 
> In the future, if the code knows better that a specific device could
> benefit from more than the default, then it can arrange to override
> this. Absent that, today there is no reason to try to ask for more.

Yes

> 
> > +				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
> > +	if (nvecs < 1)
> > +		dev_dbg(dev, "Failed to alloc irq vectors: %d\n", nvecs);
> 
> Just fail the driver load if this happens. There is something wrong if a
> PCI driver cannot even allocate 1 vector.

Ok

> 
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
> > +	/*
> > +	 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
> > +	 * ignore the reserved upper 32 bits
> > +	 */
> > +	status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> > +	while (status) {
> > +		cxl_mem_get_event_records(cxlds, status);
> > +		cond_resched();
> > +		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> > +	}
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int cxl_req_event_irq(struct cxl_dev_state *cxlds, u8 setting)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct cxl_dev_id *dev_id;
> > +	int irq;
> > +
> > +	if (!cxl_evt_int_is_msi(setting))
> > +		return -ENXIO;
> > +
> > +	/* dev_id must be globally unique and must contain the cxlds */
> > +	dev_id = devm_kmalloc(dev, sizeof(*dev_id), GFP_KERNEL);
> 
> Yes, the id is simple and fully initialized below, but this is not a
> fast path and the rest of the driver uses devm_kzalloc() even if it
> fully inits the result. So its a consistency thing and maybe a "save the
> future person who adds another field without initializing it some
> hassle" thing.

Ah yea, changed.

> 
> > +	if (!dev_id)
> > +		return -ENOMEM;
> > +	dev_id->cxlds = cxlds;
> > +
> > +	irq =  pci_irq_vector(pdev, CXL_EVENT_INT_MSGNUM(setting));
> > +	if (irq < 0)
> > +		return irq;
> > +
> > +	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
> > +					 IRQF_SHARED, NULL, dev_id);
> > +}
> > +
> > +static void cxl_event_irqsetup(struct cxl_dev_state *cxlds)
> > +{
> > +	struct cxl_event_interrupt_policy policy;
> > +
> > +	if (cxl_event_config_msgnums(cxlds, &policy))
> > +		return;
> 
> If not all interrupts can be steered to the OS probably best to abort
> the entire event setup.

It seems like if native_cxl_error is true and the irq policy is FW then the
device and/or BIOS have misconfigured something and this should be a driver
load failure, not just aborting the event setup.

Right?  Based on all the other things which are causing driver load failures it
seems like this should follow that same pattern.

> 
> Otherwise if you can steer all to the OS, if any of the below fails that
> should be a driver load failure. I certainly do not want to debug
> someone's system that randomly failed alternating log type interrupts.

ok.

> 
> > +
> > +	if (cxl_req_event_irq(cxlds, policy.info_settings))
> > +		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
> > +
> > +	if (cxl_req_event_irq(cxlds, policy.warn_settings))
> > +		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
> > +
> > +	if (cxl_req_event_irq(cxlds, policy.failure_settings))
> > +		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
> > +
> > +	if (cxl_req_event_irq(cxlds, policy.fatal_settings))
> > +		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
> > +}
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> > @@ -526,14 +610,18 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > +	cxl_alloc_irq_vectors(cxlds);
> 
> Just pass the pdev directly here, no other part of cxlds is needed.

Ok yea.

Ira

> 
> > +
> >  	cxlmd = devm_cxl_add_memdev(cxlds);
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> >  
> >  	if (host_bridge->native_cxl_error) {
> >  		cxl_mem_alloc_event_buf(cxlds);
> > -		if (cxlds->event.buf)
> > +		if (cxlds->event.buf) {
> > +			cxl_event_irqsetup(cxlds);
> >  			cxl_clear_event_logs(cxlds);
> > +		}
> >  	}
> >  
> >  	if (cxlds->regs.ras) {
> > -- 
> > 2.37.2
> > 
> 
> 
