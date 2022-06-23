Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A59558860
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 21:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiFWTKN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 15:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiFWTJ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 15:09:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B75121F29;
        Thu, 23 Jun 2022 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656008099; x=1687544099;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K0N3+/cHSET+vukKEIA+DtjXUtFT9Frej5daaywASxg=;
  b=EblOP7WUW/BMfaCGF9fJEYTAc0aJyFBFYaq4jtKJ4FMjif65Ti6QnXEc
   LRG7su1TR55AFm7EH+fsuVfCEhFh8oz2RvQJ/fJ5I3hFiOH3qIO7VE23b
   VJiYNuNT9vliXlrZiqQ1WIo2G+zV7nuBODEu8ruN2t96Fw84TZ6P9ng22
   bTtVcmPWs7kpTEfM70U9N5xMyfg/D1K0Z2ANc2MAsmyWK+FnjAoYYnsy+
   yZISrp+M3tvp/lUT9+sQBy+gPAlYrJ7KLKyW18OOFa3AcFtgnDWQyqNi/
   H5X+cNqxp20342HZIE1jDBB45u9J/EEaWV5VtxdAD6SNTnNQdjsWJYbCz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="280845810"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="280845810"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 11:14:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="915314622"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jun 2022 11:14:57 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 11:14:57 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 11:14:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 11:14:56 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 11:14:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2qk4sCcx8G/FH0J5P3bpbfjUoRWKArWuaLJUHnbA1vYsSlcCB8ZHD0ythfQxjFghgYQ8U62sfbtO42xZLwaXCBv4iauKnekwsGWKLgE2jCul6zRUi6j3t/3ieMDeJdvSnjE8Qfqs1m/qevScl39KyNOvTRj+E7/mkJtD+K2TDNzNu8v9pOGwQwbjDzR9ZgYg6+aPSkLRpep7HRQZHYMXK6hSCNbpI5kUgdg1Hk+U2HrJ+Qva/qJo7jUwHuPAvj0S8Vbsv40qaObfIq+ZwWyPbIM7MMhtgE3wmI6p/yKDfhgUPuN1+x/4yTfdtaYZQCO36tJBtkRSu416bFBhahMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DpArHdlrkxCeoET6GHaoZuDNZOf+kgN8+6XTbXTKJo=;
 b=CmBngaaPyZzMOL4Ppi5tBIJDLbMRppxr8vQaQjmGN1jdQzMGmBfBthweDBOD+56r61QB1uIq6NvRjUcAbPUCPmwAKUWaGUWHUPzx0PbuGWyBBvcM5tK60Q4B7qNTNJOgP2u2J6+4b3LwjAg/6eylT6Dqmc1DLNvxblEtX9AYQSxANei2QdMxG/vW4oWCYTJUAuW6Gy25Eox5yb1/q7RSG8QE4PqemEgOUQMFXsJF+j9+tltLPQyJd+fRanrZqopy0UNKpbO5/pfePwZP4nmlOaP5sMhOxnN43H4+knApz0z0J0VvfQxyk81IX7spCcG64YNPps2QuzKKU6WZBZBrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MWHPR11MB2015.namprd11.prod.outlook.com
 (2603:10b6:300:28::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Thu, 23 Jun
 2022 18:14:54 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 18:14:54 +0000
Date:   Thu, 23 Jun 2022 11:14:52 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <62b4ad9c1611e_3c3ff0294f1@dwillia2-xfh.notmuch>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-4-ira.weiny@intel.com>
 <62ad06a643ddf_844b1294f@dwillia2-xfh.notmuch>
 <YrObe+AdfziEPlYB@iweiny-desk3>
 <62b39e5eead1_32f38a294b6@dwillia2-xfh.notmuch>
 <YrOy3vodu3FcRjUY@iweiny-desk3>
 <20220623112408.00006cd2@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220623112408.00006cd2@Huawei.com>
X-ClientProxiedBy: MWHPR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:300:6c::17) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d0beda5-fd3a-4bc5-e77c-08da5544457b
X-MS-TrafficTypeDiagnostic: MWHPR11MB2015:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 77sB+imbK74hJzFk+n+RLFukjKrJVUIbO8GktuyIcMZefJYLvMvO4vac5IbTqgabU1bfMVHAaOrJHcNEM3BA5K0qKjXtJs9dlTjIcXXx0Zh84b7wfFw4L5YsVUD85gv0XQTVc3D9fVq5UoV9TeBOUWsvT0bw7DY/mZkglUZC4Tp5Zj+qLs21Z7ov3XPFOSqizDrNtcgpfqqr6tXQoRSML0fDgboyU3osNYfZiFs8WN1fOXSMlZqnGC6bqRiT29w7FJNRPV+dDAWIHO76CF2iEXCHs2ceDwGrBVXMQmjhE0JY0CXutr11vpUvQWbDCCGtzy/rVw6A4PZv3DWVuaHg8OWewzS8lPeMmKVRemNXzAFUeRU3ef1XgWpur01R8TrGbBfHToberFJr6K6/2pGQyI0TTZP5/VMnMBnlgDG2R0UtH3TztNOAwmYSii/rzcYQEN0WE6TKcQckfRpuqOE/sjDB2fFXEBw+unbDl9ATEMzha0JXS8JZeSk0YXhZa/T4iRKvhetpPgyi1VQ64PCt8y7yezUwxKfmTbWH+au16lSiQPpAfdD4Wgfg7zHaeOMxPjcKPYpAsrMfmRx54TPHKKjFrGSZdkPH+kyVbleS+NqD5olBockLD7zMa5qHXLUW1isviCdxjE92zRdXDnEHSlmY7Aj7WDJmGbXsThbk9/4Tgr+0xmOnwFqU9Na0ID/mibeg6P0NdZRo/RRoqbatkJe0Yd2WWZwa84BhWgC1TuaZYkbcddQidwHGwbDuv87R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(346002)(396003)(86362001)(8676002)(66476007)(38100700002)(110136005)(82960400001)(5660300002)(186003)(41300700001)(9686003)(26005)(4326008)(6512007)(6506007)(83380400001)(8936002)(15650500001)(66946007)(316002)(66556008)(478600001)(54906003)(6486002)(6636002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LPTS9KuzDauZ/o+4905tUyv8QSu3O0mjTCsYMIsdBEiZpbOtJAu79iI22T6H?=
 =?us-ascii?Q?pU55Y0F3it7Fd/yyWSHStgjdAcxhsdr07fFkJQPzshcNBLaz5Y60uRALAlIl?=
 =?us-ascii?Q?lw5LCQ+R+PNb/Wp+UOZOCKsAFCvL+rlJ7NvPgRsYSwJaYyd2VcwqJS6//F8T?=
 =?us-ascii?Q?XzEo9FjS5GHaz2L6kCSs4LjqbePD7GH+7uigXw6aUegpVr1+QQIW5k0BimGZ?=
 =?us-ascii?Q?jk+EL8FyOHw4Uu2Vubsw5hBzB0UEaH2XEqOP/70b/uDgNOdIQf3kSOYtiXln?=
 =?us-ascii?Q?QiYA1hg4nPZnJF1n+u8/VoAaS1/e0zckGSTbKLarR6USsAmdfVktfqnPoCKA?=
 =?us-ascii?Q?pC6CXvj+a/xvYn1f4BNg+1FWK3yddTfdPGpYKKI7aTbj1B0xeg2/1KQt8Q4a?=
 =?us-ascii?Q?qK/bWFupnbxFxqM1gqcMvn0VqDFVo80yzG+Muc7/FaMG2OYsRQtRsp4Vz8BG?=
 =?us-ascii?Q?esYAQJXgALF9bGbV6QFgUpkqbfLmPOmWE7ZlxGiaS1AY6bVpy8pRRK64Omdq?=
 =?us-ascii?Q?4oqS/nuH/LXP6UHWIsDRoLzzl/LcAkEvJ0E68vWet+IC1EdQeCWDAlD/pIxv?=
 =?us-ascii?Q?JH/UEJVSG3hhMrfPgJZCXxazTTSGaVHwY6sR8o9oEy9cgj4CY2bFrR0nmvjQ?=
 =?us-ascii?Q?PIGTHRBkPpVgFZHB/ZKxC2m2mMsfPpEzx/hGdVN5CaggJPnGYYxt0jC8LFNG?=
 =?us-ascii?Q?6X3Tb5q2hYWaopTjFjDvMI6YfQEb5+ZgNYsztNUEquuBGR0k8OFDtLnn56qF?=
 =?us-ascii?Q?KO78jDcVL20gHG1N15xJq1PUw5izVGcotM63+hQkaxzTWgEQ5w5911MA3jK/?=
 =?us-ascii?Q?ih0skofzmFKdVn6KfZXcoRgFYt6A3sEsIGX60kPe0n5hKo3mQ9KLaIXt1Gyw?=
 =?us-ascii?Q?Vp45TybQRHu0X60HxhVLPLM/yysl42b5BXHxRfq+ZltYuR9PYSjLsp4mRZtX?=
 =?us-ascii?Q?0IJrZihhuGwQ7vvVQ02JzuzWlYDN9R7IwMDEhdO2tCr0+x4nfKivp9n69Re6?=
 =?us-ascii?Q?nDRjHfFlOeohY3YjS+RQPSWuTY7W6aiwfrG4jv5ZGtRnlMXaPZ1aug9CSptR?=
 =?us-ascii?Q?qpCtjFnlU8sg/WVWclZwUqv78SdAKdEZlX3pvLZwIFn417E9HH6S3TI5KFb7?=
 =?us-ascii?Q?5jUJWLUqEfpDEs2lc61Eh++cc6ruxvCP1dJdmQ4k297pbvagj2RCQ9Ww/loY?=
 =?us-ascii?Q?09XY8fvQRduiNQFQV8B4DWPnFq3EH1HBUh9viZ5+WXQoXfLVNZhyKx0Xn5tc?=
 =?us-ascii?Q?R38sgVDOX+xnEghSvZeqF0+BPQbepPeJIBEa/oiAs/hzK9lb1PbX2DhXaHma?=
 =?us-ascii?Q?iPGN9JVtwrg/3SFkp3HB/dtlZvYgkVoyu7cAs+ztZ0emwYTG7Heq5Fo74dlj?=
 =?us-ascii?Q?7Qzb6s6TmeIhnSDaMFdKSqWf5ukqGHcx8RsEVAqlHs35MgMAWKrIYm7JB8Sd?=
 =?us-ascii?Q?SZm8NIugDPpaHt6XVuPpZytmXckGVN8hPj4bI1hAy0LkfOx2od+aRaixqPvB?=
 =?us-ascii?Q?6a+KqEHPkZu9w7XRgJrcCV0dcCGzYEbWKgCita1tW4gsxr29hS7V5RGikrUq?=
 =?us-ascii?Q?pCHqZAGpRcj0Ty5gdVLakHvYAYNNOEx3P7QjZ8wF1vx0KxqfvsiimeLmSu/S?=
 =?us-ascii?Q?LebQ0Vaj/0JEuKxrZ/ow/aEW2Czf2G61keQs/oNxRMLQ5VB8ouYaNjkCCvIg?=
 =?us-ascii?Q?3RnZClZJs87hOh/H+e4I7/TtVfZCqIGbzYh2yIHYQTGGICI8+VCKYQErTYId?=
 =?us-ascii?Q?bkZ/i2zZL6YkqLTJn0oqtjK8/aKH4jQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0beda5-fd3a-4bc5-e77c-08da5544457b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 18:14:54.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EYqoI2d7TeBxcLUksjfPDtK5BPdR4mYGHjMZNjniC/M06cq0o16I1VumaXijnm/3dvXKXAvreLrbAQcjUaEobGxu2iqgcuFPfTKbPbWZg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 22 Jun 2022 17:25:02 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > On Wed, Jun 22, 2022 at 03:57:34PM -0700, Dan Williams wrote:
> > > Ira Weiny wrote:  
> > > > On Fri, Jun 17, 2022 at 03:56:38PM -0700, Dan Williams wrote:  
> > > [..]  
> > > > > > +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> > > > > > +			     u8 *protocol)
> > > > > > +{
> > > > > > +	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> > > > > > +				    *index);
> > > > > > +	u32 response_pl;
> > > > > > +	DECLARE_COMPLETION_ONSTACK(c);
> > > > > > +	struct pci_doe_task task = {
> > > > > > +		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> > > > > > +		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> > > > > > +		.request_pl = &request_pl,
> > > > > > +		.request_pl_sz = sizeof(request_pl),
> > > > > > +		.response_pl = &response_pl,
> > > > > > +		.response_pl_sz = sizeof(response_pl),
> > > > > > +		.complete = pci_doe_task_complete,
> > > > > > +		.private = &c,
> > > > > > +	};
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	ret = pci_doe_submit_task(doe_mb, &task);
> > > > > > +	if (ret < 0)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	wait_for_completion(&c);  
> > > > > 
> > > > > Another place where the need for a completion can be replaced with
> > > > > flush_work().  
> > > > 
> > > > No not here.  While this call is internal it is actually acting like an
> > > > external caller.  This specific wait is for that response to get back.
> > > > 
> > > > This pattern was specifically asked for by you.  Previously Jonathan had a
> > > > synchronous call which took care of this but you said let all callers just
> > > > handle it themselves.  So all callers submit a task and if they want to wait
> > > > for the response they have to do so themselves.  
> > > 
> > > Ah, true I remember that. The nice thing about a doing your own
> > > wait_for_completion() like this is that you can make it
> > > wait_for_completion_interruptible() to give up on the DOE if it gets
> > > stalled. However, if you have a work item per-task and you're willing to
> > > do an uninterruptible sleep, then flush_work(&task->work) is identical.  
> > 
> > So when you mentioned a work item per task I really jumped on that idea.  But I
> > realize now that it is a bit more complicated than that.
> > 
> > Currently a work item is actually one step of the state machine.  The state
> > machine queues the next step of work as a new work item.
> > 
> > I'm going to have to change the state machine quite a bit.  I still agree with
> > the one work item per task but it is going to take a bit of work to get the
> > state machine to operate within that single task.
> > 
> > I don't like what might result if I layer a work queue on top of using the
> > system work queue for the individual steps of the state machine.  So stay
> > tuned.
> 
> Yup.  I went through that (between RFC v1 and RFC v2) and it wasn't pretty
> - maybe it's worth a revisit though.
> 
> To throw another view point in the mix. Note that I want a solution and
> in my view DOE is slow and never on a fast path + I don't see it being
> high churn code so needs to be fairly maintainable but not super simple
> or architecturally clean (at the level of state machines / work queues etc
> - interfaces need to be clean!)
> 
> If we go back to RFC v1, which IIRC was basically queue on a mutex, and
> consider it in the light of where we've ended up.  I wussed out on arguing much
> about this at the time because consensus + moving forward was more
> important to me than the chosen architecture.
> 
> Taking a slightly black and white view of requirements. I don't think
> we loose anything by using this list...
> 
> 1. Synchronous (if anyone needs async at level of caller, they can spin
>    a thread up).  Async is the corner case, not the common one.
> 2. Small number (< 3 I'm guessing) of protocols per instance.
> 3. Very rare there is significant contention.  Fairness doesn't matter.
>    Normally the only reason we'd get contention is userspace triggering
>    access to multiple protocols at a time - probably via sysfs or other slow
>    method.
> 4. Per protocol ordering can be maintained by the protocol, not the DOE layer.
> 5. DOE is basically a bus over which we are talking to different devices
>   - think of it like I2C but rather than address we have protocol IDs.
> 
> That last analogy brings us back to how I think almost all slow buses are
> handled.
> 
> At level of a bus, a lock is used for mutual exclusion (often also protecting
> bus controller register state etc). No workqueues or similar complexity
> - Underlying hardware typically doing DMA of result into a provided buffer
> with only one transaction in flight at that layer at anyone time.
> Note there is more complex handling for high perf cases, but in many cases
> its not really used.
> 
> We have a bus lock that can ensure exclusion over sequences if necessary
> (there's one in SPI).
> 
> If a given driver needs to ensure exclusion for RMW or similar sequences
> of operations it takes a driver specific mutex and holds it across these
> sequences of slow operations, which usually sleep, include interrupts and all
> sorts of fun.  Normally there is a completion in there somewhere to
> get from the 'done' interrupt on the bus controller back to the
> i2c_smbus_bus_read() etc that is waiting on the result.
> 
> This model works, is super simple and layered.
> 
> In case of no contention (perhaps 99% of time), it immediately runs the
> DOE/bus access in the thread that made the read/write request.
> So no overhead of going to a workqueue.  
> 
> Implementation is one linear function, no state machine needed.

Agree on this principle, once you have one linear function then it does not
matter if that function is under a mutex() or is run in an ordered
workqueue.

If the one linear function with a mutex ends up needing to invent its
own waitqueues and event completion notifications then maybe its better
to just use a workqueue than reinvent those wheels, but if push comes to
shove that's just a nice to have if we get to the one linear function
implementation.

> Anyhow, to refer back to my initial comment.  I'm not that fussed on how
> we do this but it's a blocker on other work so quick solution is more
> important to me than perfect one.

Agree.
