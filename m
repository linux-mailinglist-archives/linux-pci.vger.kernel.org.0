Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975A1649511
	for <lists+linux-pci@lfdr.de>; Sun, 11 Dec 2022 17:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiLKQVk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Dec 2022 11:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLKQVj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Dec 2022 11:21:39 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF82BFC;
        Sun, 11 Dec 2022 08:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670775697; x=1702311697;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DOtbzGZuQ5X9gGHsuFeHjdr6HlH2yNv+fxUNFNpWAAw=;
  b=bB3HIwPDOb5wjMLT5K3ct0wD72YXoY/kbyURNHM8AsVPssdDaD/nMBPO
   XT40bcfE/PZapc6SVdwEaBM371vglAYZTQjazw2l5zU4v9yzCG/gDyc2x
   f75ZG9HPf2WUq33nb7iK9kdf14fxU0VNserHSH2WfQqzqqzIDXd9z2aGo
   RjcyNDBEw0XXRQb5JVuNTwn1MxO7eH+ldFiUcUJaj+eGF3UCJOy6uTmrJ
   TF9tUljSnKO/YP84KLOuZLywm6CfsIsNfbzLu8KyMshLUnRC3Ef8Dp3F6
   +qQAggCewDB8HwOPhOtQkVTSSNv+cI04LoBuizN9khUILwy+4D8YJ8Frz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="318858597"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="scan'208";a="318858597"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 08:21:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="650066227"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="scan'208";a="650066227"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 11 Dec 2022 08:21:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 11 Dec 2022 08:21:36 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 11 Dec 2022 08:21:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 11 Dec 2022 08:21:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 11 Dec 2022 08:21:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpoKxWnVAvgiQPmHqhu9VEhKvwyjlrBaKKuCFGRrc1OWSEXL9JMZH+x1NhR9Baf71jg1os156lTUZh5q2EbBim/mv446WmRQ7MkXog7aqeZMtUx5Lj2RryBeTX9Cpk2mXtnw5+aaNTp/0MU/zL7nkdUJWAbir+KbHQjKztBqEVoSQsLiS9S+NCNZLGGPZKshx9nkJZnseYk7k6rzK2mMkpvyvVgwbC9VhGvBTCAGb9z0Igvj9Iu3cMGCVvbm9dxjLTT+/N4DHGZf0dbeBFJDIOACjiv1SI85NJND06qo/DGZJR00uCFXDnXzdv1SxnR8LyCI2d9Vja3rK411S06Ypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVDe2H74FfMRKed6zpJOUKvN/yhBu+L0WPY9n2JmcUs=;
 b=PHYvXSGP4pRjlJMXFFWN7kxMKrEJEqXDjzCOx+xWe+J5qdusazMv/FD80lpC/DuKjfYZ+kGSYtlkAJ00d14scpHyDL/MdAqXBQJdKOc2ybtfLtcNEIDQBamnzYxqg0Ml3bP9WM2oVTB8DwC8sNjHBFEfD59b/tH5RoHsC1ROQEP5wNHb9dXCopbN1ieIXrHw8E61kah/PBQmxYDW9CKF2bZQZLTcWtnrO1iDc+f6Ik4nBA98ru2874ZdYJozpfWvjGU1OYq1x1TQpkulPJzyCO76dL3m5a27j0EwsZkaDogU7h0NYZUbFgTucFEwj6MytIzs72GdE8a/bgMJHGm7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5321.namprd11.prod.outlook.com (2603:10b6:408:136::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sun, 11 Dec
 2022 16:21:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 16:21:31 +0000
Date:   Sun, 11 Dec 2022 08:21:26 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V3 4/8] cxl/mem: Trace DRAM Event Record
Message-ID: <Y5YDhiDt3yeNrnGS@iweiny-mobl>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-5-ira.weiny@intel.com>
 <6393b35111f0_579c12947f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6393b35111f0_579c12947f@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR01CA0015.prod.exchangelabs.com (2603:10b6:a02:80::28)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 466c2017-6f70-4906-7be1-08dadb93c35f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jey8Ry2acLUIk75cb5x5gneqM2q07tzw58l52fHmHifCDcDmlN6Bv4rmgNJa0MZApgpW5n1Fy0yqtElqandYhRjKYMrodXNcHFX69nHZg2CIpuHv3YQF/hRjSi8+bHiv4Cy2I2zuiCn/9sg6UUyFX9fb/5wLetILnyLAnHtXOuQ0MMf49+4YwMhCejYCBhzhvkusgrsg0SnE622sKPAn/bhItanAh/u/g4ulTl2sziyucXfLtks2bnThfxYl2E12v5XJhb4wvzHg30Sem0gu3808b6ay8rx0i6zoNUv21/tsEUgmPqguS9RX/iWl0+krwsTP33cTcE0f0ONpzu59KRI7f6Vd17XGexRFv0XjZsGpkICNt7rv/yZH/Ftq+9UNJ1lPTRrawIDWi4+X5Ktv5QKyuKOeSk0Whjqhz7bhhB+C435s5BimjlPRcuTx48/UQJ30H9z7i0HPApeJljftq7wQkUoADvo9yjd1UWazKdKYZOUfnnjiI4vICGW5FxZKD1hLMH797eIhlTFq9mtP/FubieA0UQMnjDVhn+K+JzxJYWnoTISkCrcYpA2pldlTyWTWC0rs9rQXtzacMjq+gjRiCsCLkWV7XYX1XfwhHvHXGHZUpZ/1fuMOIHuGHUHlF8jotx9kEqAJU/mHGDWQXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199015)(9686003)(478600001)(26005)(186003)(38100700002)(6506007)(6666004)(6512007)(6486002)(83380400001)(82960400001)(33716001)(8676002)(66476007)(66946007)(66556008)(4326008)(54906003)(41300700001)(316002)(6636002)(5660300002)(2906002)(8936002)(44832011)(6862004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o9Mz3WAZNBlGvvWZSF0bmdt5pSsAgxHs3ts6F3+ub3u07MhfHJ58QEw/qy+e?=
 =?us-ascii?Q?oyYPbDPAru4hR8NtPrNrHGpcNWjHTCk+LtsvRk61iAMXkgJ+DgmPM+Eyw3hO?=
 =?us-ascii?Q?tVJM/zigP0+3v4GHFr87TkDxyHagxsNOyrRmHbfPIBeAbpbf4OnzrIMDDNkj?=
 =?us-ascii?Q?qCJy6ndb8bNSewJHpZ+ZA/F//AHRCRN2eCYDtQwT2MAwanU1+2pWH59X5gXC?=
 =?us-ascii?Q?j3icMGFx0Fp4BcSjO5bXt49ePx2o2ItH5KLbT11qxZ88ck5eJ6i5Z8yuknzr?=
 =?us-ascii?Q?yStrhOwfVq15gAuAymQDv7X6TLJAuiBcIMzH8xoUeJivL+U9c71n0XaYq7ec?=
 =?us-ascii?Q?sI+FjcOoyzMZxwKkgUpWwNOu0a+fJTp9TEKCKXixiQVstdck0t7rdfIyC1rI?=
 =?us-ascii?Q?cG9ozhUdNTwD0rPSAly0OfAekMLXkrFKlBeFaTo4bFjt02UTJrBaFqvvgV53?=
 =?us-ascii?Q?dgVmU0hW/Dqx2OVVcdwQNjJMOWEf8sTI8gN1EVCPLIqCY0rjmc8lALDA86Lx?=
 =?us-ascii?Q?9XMAPVBXtSYhpFA9qm1rjrCDBh4r+btsAW2VCt1YW/oBuPBFE3jecjPeQYEW?=
 =?us-ascii?Q?z9l8mpfQQu2V9ta2eGSC0RUgHUriy0k27wNsex+BcE9yVN4U4wLDM6J9IvaY?=
 =?us-ascii?Q?cuPebe7xbz1+8ebcHq8W76xmdXFcpB7IEbm74VErCzb6gYkGePwFpkORMZpD?=
 =?us-ascii?Q?okgORZ1ftsExpHcgPANoXN79etlPnnFIIfcRtCl/FYLX69YA2b/DpPWcLvCt?=
 =?us-ascii?Q?aCyti34zKH6hPPhrKljmyTbAltO1fh4peXK/rSP7S6ExNe9PvjvXcrwYWroX?=
 =?us-ascii?Q?ucZWtAqet0uf1XDXmSaiYGy9i6yMHevE11YsSy+gnQqcxqTIM7RY0wmBB347?=
 =?us-ascii?Q?A2S59IgMwtVGcvuEcvjjQL3GmEHuf/WMHUpfP6T8XzcienZC2KBC7Omggxwj?=
 =?us-ascii?Q?PECER8N7XaGAwHavoreR3bdE/tz0s6tb2k5rbcJERN56LhT/tXbTtEJ9ZL4s?=
 =?us-ascii?Q?2ZROnNijIekziZ0IsrWrL4IRmED5yOJrm+BbarxcprTioQ5UCgyF/flaK/P+?=
 =?us-ascii?Q?yZmdIG+zVX7QUk2//Z45POiH7iG3hu2kZe6s6ewVAQYgNqiDQcGOgzOf3psT?=
 =?us-ascii?Q?FDU+UDNhYarjpDdLluun8xz3B+oTu5sRwCLS39W4MZOtIOTRZ/qDzeuo/IWP?=
 =?us-ascii?Q?9BAo8qm02sOhZJrfsdE/tuZGppthWBbXBPqSW2VB0Hiy3LE6mohWAJPyhZlZ?=
 =?us-ascii?Q?LJfUxPTOVNXJ6xjktbSoFR8qj/gRLSw6pee6MULPOvmmO1U9F3MrTgwJMLA9?=
 =?us-ascii?Q?/sfJPYN+ewOin9Cmi4h4geVWv1Cg56rC2SVooHBVxYhNgarHxSDRwA3Sa49i?=
 =?us-ascii?Q?3bteOz6s8ptclS8J7i7Wn3hpaaPKsFArI3XVl0hR3G4EtKbUPLXBHZtVhXGo?=
 =?us-ascii?Q?vqkZOBL9SfPKQU9CFbAfd8QHxWTsriTFIEhZSZysf3E645KnP9VOBNRE6Ves?=
 =?us-ascii?Q?GsA1ZJYVre9OwZkOTYabjq6OBhap4aRgegqFsBgmW2qIRYPeNuOlSUU8k92v?=
 =?us-ascii?Q?2VFN5cX4q2huDCyqI/6wKJ3z0WhKVQxq+CT1xWyW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 466c2017-6f70-4906-7be1-08dadb93c35f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 16:21:31.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrCBAeCSNAJR+htbqvTzEEriZr4MVZQwOi/SyFbmcP9CoZe63zs84+CCuOH7mAnRU8uDCkwJWlP3n2tU1mEl4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5321
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

On Fri, Dec 09, 2022 at 02:14:41PM -0800, Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.
> > 
> > Determine if the event read is a DRAM event record and if so trace the
> > record.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from v2:
> > 	Dan
> > 		Move tracing to cxl core
> > 		Remove trace_*_enabled() calls
> > 		Pass struct device to trace points
> > 
> > Changes from RFC v2:
> > 	Output DPA flags as a separate field.
> > 	Ensure field names match TP_print output
> > 	Steven
> > 		prefix TRACE_EVENT with 'cxl_'
> > 	Jonathan
> > 		Formatting fix
> > 		Remove reserved field
> > 
> > Changes from RFC:
> > 	Add reserved byte data
> > 	Use new CXL header macros
> > 	Jonathan
> > 		Use get_unaligned_le{24,16}() for unaligned fields
> > 		Use 'else if'
> > 	Dave Jiang
> > 		s/cxl_dram_event/dram
> > 		s/cxl_evt_dram_rec/cxl_event_dram
> > 	Adjust for new phys addr mask
> > ---
> >  drivers/cxl/core/mbox.c  | 13 ++++++
> >  drivers/cxl/core/trace.h | 92 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h     | 23 ++++++++++
> >  3 files changed, 128 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 0d8c66f1cdc5..2fa4645f0ed9 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -726,6 +726,14 @@ static const uuid_t gen_media_event_uuid =
> >  	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
> >  		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
> >  
> > +/*
> > + * DRAM Event Record
> > + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> > + */
> > +static const uuid_t dram_event_uuid =
> > +	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
> > +		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
> > +
> >  static void cxl_trace_event_record(const struct device *dev,
> >  				   enum cxl_event_log_type type,
> >  				   struct cxl_event_record_raw *record)
> > @@ -738,6 +746,11 @@ static void cxl_trace_event_record(const struct device *dev,
> >  
> >  		trace_cxl_general_media(dev, type, rec);
> >  		return;
> > +	} else if (uuid_equal(id, &dram_event_uuid)) {
> > +		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
> > +
> > +		trace_cxl_dram(dev, type, rec);
> > +		return;
> 
> I think I mentioned this before,

Sorry, I don't remember seeing that.

>
> but rather than a "return" in every
> branch just make the 'unknown' case the final else in this if block.

Sounds good.  However the previous patch started this pattern so I fixed it
there and continued through these.

> 
> With that feel free to add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks!
Ira
