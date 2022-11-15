Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3434362A29B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 21:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiKOUSs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 15:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiKOUSr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 15:18:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68B62B244;
        Tue, 15 Nov 2022 12:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668543526; x=1700079526;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hvFXD7QWEp4Byr5flsX/z3zdvFOdBIKyo8ioU6e1wiI=;
  b=HrPXDaXDxz5hY2SqTggqzYMrHJZR7DZoKqgKrJNrUpwc4oY6Vd9UXcSs
   vH1oD2Sn8pnC0y4rzZlfu3TRiIqL5jq5ByX8PKg08sx+MYXrakpxu1spl
   by57furuE9RvwTq2jV98ksysc7gnJp1OdbA9XIlyrr/H1vQ1r5MAG+KOf
   U/h4yNUTVhXmH2c3maFgBttdmdUxy/zx/lmewKQRJCGJNh/ix5RLXWrI2
   1qpGBkaci5TL9D5QRdry+Uf2IINGS0LSULSuSOPPEeLy+RwcyiH/WkwqK
   0FOwM5lXOmrs59xbHdcoiywudeBR731snpc0UwC5KFMEaAOp4WDm4QD5h
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="295725474"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="295725474"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 12:18:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="744736700"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="744736700"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2022 12:18:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:18:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 12:18:45 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 12:18:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5QJ0m2ZAkkZ3wmIRiz+Vbdgne+RNM1GQ9PaO1sJ0h7a6OuP6Gob4nQpmmhc8AkBRymQfDH06wtWPBDe1MFM2TzFbeaEvLKio6FHxBfMSi9YuQC0PY66naVYjQgY2Pmz62yAD23zN/w/PTAOVROJXCcIEkbjLcwoB+e41p3p6hX1oJkFr5ZIpNZyAMUDfPQh8PJGekE+tvK6FvcTAwRwt3KZeJyE1xQM1zXjj4uR0RajOTMRlLUYsSea5wzmYDhhCRc79ifT4GRzpGpPf8wN+pHUYSsN2Ow0H9UvHeIqA5VyZAzm4vFsDTm/UphWw1wDuzeFQ2OhJ9PCBcbF0jP6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHY4kCQReCdL+z4kgCGr7cjqcAi5b06ttkZrDOCI0Dw=;
 b=ihITfmeAtl/vKC6Xok2g9Yavh3xF3/W7Bk5biiXdHGqj1Ez+hJYFo+Op5hUSkE5KVMOPn6lc0b9wnu9l2Db7NCIP5SFFYtug5+ldi1rRqOCrCGF5yXiMQj3G31fZ9o+NydXAwQDyIUMarrD49glXd/S5MSZgtQJ3rJ4U5Loe1XBvJwXtXy/HVDaflu7AsLVI7hzvRHwCj+aMpmKvf2yFc1Ie1VrJ6UZAYGJ7Mc68CDuv/hpwjJ2bDrH37bV6a18QE2M+bhnxrmiZ/ynOt3MQ/hdJm7AOZ6LW+vuZD2ARZ1LMvRWVqZiMMKZj1282VwlgGSN5hvnff2i38Gou8A81XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7084.namprd11.prod.outlook.com (2603:10b6:930:50::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 20:18:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 20:18:42 +0000
Date:   Tue, 15 Nov 2022 12:18:38 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/doe: Fix work struct declaration
Message-ID: <Y3P0Hp7eK3V7xRLN@iweiny-mobl>
References: <20221115011943.1051039-1-ira.weiny@intel.com>
 <20221115194424.GA993906@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221115194424.GA993906@bhelgaas>
X-ClientProxiedBy: SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: f24b8fda-0cc2-460a-d8bc-08dac746972e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eZkUuNpVVcCrEP/xvC9yNvFb45x1X/x/OguwWer0LjdmpHjF9uZ50Q14KlVYnwr0ls37R3dqX2WOjIz1UATq4pktF5axGu0UreiVoXcUN870VOTt4+JGrrYZTY8uWDtS+Cs0pG2hvvayeVEFwuM/AjpnMfuLtvHFHuRl+hQbSyavglBtlB6eaRF289TWmVl6Be8hSqerPUrGYRrpo1d/oSm5hCnOWk5neMwNDQyp989Saus/aLGOEK4fdYzi7d8Drwl36OwVMCwvI+iirP2juES1/6UU37xdfBIbiLQcS/hwsjXSrIHWFGEJmWU9yuEE3ugVsYz0eGTUyeaGjng9HuFXoYerRogeBfA+pUqz2J2QzNVXrD4izby0q/imlmkPH9YBwSWBSVRvcE/bkSqwMn2Ya47Ase+33BZw+T5n4rwy04wzt+Kdkmve4e95mIV4UPMKfgGQ5h0jw2+nC1ln7h+cmTQCqkRW6xnfcdFZkpX6H0Zt+uRIwoQ1HImyO0MgOShKQCg1eh7QAiWhJ7NA2Dv5lAQo6Id8ZZTcHPaFjDGZyVTq5PuI14gI3EwF2JDT2RBIyAFGcQtjJAJ44Phkb7WOQYVCHDOWjq2nrdMZYcb6Fyg6NN6veBLPNKLf1fbpTFLxkHHgZCoQ0Q5ULVd9rPjf/keIPBwtu5xYrs6xj1zo1+CfV5ndM2ewQyovq+bKbwrRO7NvfYXbCzuhmdqwXmDyqbUVGftRhFba+FlS++ln8j7+oRrMOuZlYJncvBXoGkjncGAxpOx6BZ/xNgWSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199015)(9686003)(66476007)(66556008)(6512007)(66946007)(82960400001)(316002)(86362001)(44832011)(83380400001)(2906002)(38100700002)(8676002)(41300700001)(5660300002)(8936002)(186003)(4326008)(966005)(6486002)(478600001)(6506007)(6916009)(33716001)(6666004)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x3sxVTNWsuQVxOv0PjUwHcvjUP/FAh+05ZKA41BR1MsWkrNVqJsupvuRxkiJ?=
 =?us-ascii?Q?+1Y04I5Ds1oy0pA/D+JbGGqV8fqGyHX5rayHS7gaHSObeXLugNy+FVVNgNku?=
 =?us-ascii?Q?9pMy3dkpPs05mFMDbicyzJG/hIjSsv4zAPa2b/fql4e63iy7asWpfNnD9GEw?=
 =?us-ascii?Q?DDLOCJxDHQCZ+KnrALl1P209U9C+aUE3Qi2v0NGHmAKFfZM52+j469aRpUcx?=
 =?us-ascii?Q?l1ad3Q0tvKP8rRLgjHndzBpDEFwukNamav3u2cibqGdHtcOnTS7Kp9ORDz1O?=
 =?us-ascii?Q?13td9H6tl1Sp3kIBYjo6yCXKFHchBauR3+vYjRRd/TXOYKvBvUDB8C+8cvvX?=
 =?us-ascii?Q?AB+PgGCaWZtTLfBpDivDtDNdbNikASHW3+/lE4fwObjxHJsCztBo93NzkpGq?=
 =?us-ascii?Q?CIhrNHYzXjEm62qCaVLBw6PuvrzlKgyb1Kt2NMherhSD/FgxTrV8rQX+v8qr?=
 =?us-ascii?Q?Qo0iMF+/zqpOcDNCZbRqPQcUBeJWAsKigD2xAFW3EN52vVu/f/thALXwpPuY?=
 =?us-ascii?Q?d58Bh9853cbBNB6ky/k/OIYat7+822Ft4bDYNDqgviloUQ97qQV6s4KBepM8?=
 =?us-ascii?Q?n7LilGEDu1EtYU2tlspXabhrVIU1w63Y3w7lUjJQsdaNxK2nxO8VpCBnN8po?=
 =?us-ascii?Q?u1+LJw6WAL0eOwsPWU+sx86L2+LfK+mS/uRZ9doruY2WMXVKja9semcIpYCB?=
 =?us-ascii?Q?4AhEGh+ce5sjAgFukBSpjLtGVPrkeMkkvDjWYrAUnLSzwSaI/3wgA5WFV/L6?=
 =?us-ascii?Q?3xLcP08Z3SbGoVDALX0q2TsQ0hNwkcUPSxrNXVvEjG9jUrv9sfk/gTYmxeMr?=
 =?us-ascii?Q?vBRpNJM7Td48/HPG46idVV1tXYBSvKXqQaSP0ik1UmPSvoK+xIy3SVJj8edk?=
 =?us-ascii?Q?bJtArqDxrHcB7lXrs87oRHJIQsAgN/SfJKFdffv5p1Od24/EB3KsjqnDAVzh?=
 =?us-ascii?Q?p7uH7i0SADzpSXMY3NQ3errOO63MdCUrzAj5Ttppv2CmK6t298LROUPc3YRV?=
 =?us-ascii?Q?n6hPBE4ALorYxTh8+R7XscvCprTQEMpW+DVYcRsZJTIKcibjyYm2F3RDdMWu?=
 =?us-ascii?Q?oC/wZq/BvTD3KE3FtwR4ZKUYeyAUH7GfQpkajOprJd8+jD/OG90d5GcUJQRC?=
 =?us-ascii?Q?Ozmnvi4I2AIp8tA+hcyYyWxqRcHAGG0lh2tHdBRPMi/TicTE135OMeTOBzRA?=
 =?us-ascii?Q?znFo6+vxfreLyPanGCxwwrN36cwYU5PYpsbBqgd7atdcAJmn8y3VwH1S4tKN?=
 =?us-ascii?Q?m399VZADmMGYu/tPpumfUc6gD02ubkdGljyR3y561x4oVnOUNVxH01RQTsMa?=
 =?us-ascii?Q?3+y6WElywWE8PLNNWtRO3r09SXuzGjJC66jIcTvkjtQC3QWtjVQLPETBxyy3?=
 =?us-ascii?Q?da/18+hY0nyfBkDVvVKgcEp4JxzzK03T+HKHNNM3njE7S/IJRFt9X1y6+xI4?=
 =?us-ascii?Q?sbfYjCm7aTF3g14hZn1JDT69UPrLnbO7BoyBPqc0N9YaMLufFQ4Ec7/ix/1+?=
 =?us-ascii?Q?AN7/6RypqxqQ2rQtHcoInZI8gjZeml16f2uNO3CmPOkoW6QHN9/x7s1LCyt6?=
 =?us-ascii?Q?6TthoNPrl7YgW6wkAY+6RflhBOPYdT2i1iziSPLTkoCf/5Z5xj10Iu7PGDC2?=
 =?us-ascii?Q?1lYW12dGtX3tuvZFkGM2nwbcQW5ZkdMZfIAx0iqk1xOs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f24b8fda-0cc2-460a-d8bc-08dac746972e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 20:18:42.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NammkBPRdleomi9qMvn3BRaSysELMEoBhSL6asQ7iXr8CSdf1dFcKJqH3YuLUOq7qFF8GGGqdxNtxMNTX0TRUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7084
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 01:44:24PM -0600, Bjorn Helgaas wrote:
> Hi Ira,
> 
> Can you fix the subject to follow capitalization convention (use "git
> log --oneline")
>

My apologies.  I should have capitalized DOE.

>
> and say something more specific than "fix struct"?

How about?

PCI/DOE: Fix initialization of work struct in pci_doe_task

Thanks for the review,
Ira

> 
> On Mon, Nov 14, 2022 at 05:19:43PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The callers of pci_doe_submit_task() allocate the pci_doe_task on the
> > stack.  This causes the work structure to be allocated on the stack
> > without pci_doe_submit_task() knowing.  Work item initialization needs
> > to be done with either INIT_WORK_ONSTACK() or INIT_WORK() depending on
> > how the work item is allocated.
> > 
> > Jonathan suggested creating doe task allocation macros such as
> > DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> > function is not known to the callers and must be initialized correctly.
> > 
> > A follow up suggestion was to have an internal 'pci_doe_work' item
> > allocated by pci_doe_submit_task().[2]  This requires an allocation which
> > could restrict the context where tasks are used.
> > 
> > Compromise with an intermediate step to initialize the task struct with
> > a new call pci_doe_init_task() which must be called prior to submit
> > task.
> 
> I'm not really a fan of passing a parameter to say "this struct is on
> the stack" because that seems kind of error-prone and I don't know
> what the consequence of getting it wrong would be.  Sounds like it
> *could* be some memory corruption or reading garbage data that would
> be hard to debug.
> 
> Do we have cases today where pci_doe_submit_task() can't do the
> kzalloc() as in your patch at [3]?  If the current use cases allow a
> kzalloc(), why not do that now and defer this until it becomes an
> issue?
> 
> Bjorn
> 
> > [1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
> > [2] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667
> 
> [3] https://lore.kernel.org/linux-cxl/Y2AnKB88ALYm9c5L@iweiny-desk3/
> 
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Reported-by: Gregory Price <gregory.price@memverge.com>
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/core/pci.c  |  2 ++
> >  drivers/pci/doe.c       | 14 ++++++++++++--
> >  include/linux/pci-doe.h |  8 +++++---
> >  3 files changed, 19 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 9240df53ed87..a19c1fa0e2f4 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -525,6 +525,7 @@ static int cxl_cdat_get_length(struct device *dev,
> >  	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
> >  	int rc;
> >  
> > +	pci_doe_init_task(cdat_doe, &t.task, true);
> >  	rc = pci_doe_submit_task(cdat_doe, &t.task);
> >  	if (rc < 0) {
> >  		dev_err(dev, "DOE submit failed: %d", rc);
> > @@ -554,6 +555,7 @@ static int cxl_cdat_read_table(struct device *dev,
> >  		u32 *entry;
> >  		int rc;
> >  
> > +		pci_doe_init_task(cdat_doe, &t.task, true);
> >  		rc = pci_doe_submit_task(cdat_doe, &t.task);
> >  		if (rc < 0) {
> >  			dev_err(dev, "DOE submit failed: %d", rc);
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index e402f05068a5..cabeae4ae955 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -319,6 +319,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> >  	};
> >  	int rc;
> >  
> > +	pci_doe_init_task(doe_mb, &task, true);
> >  	rc = pci_doe_submit_task(doe_mb, &task);
> >  	if (rc < 0)
> >  		return rc;
> > @@ -495,6 +496,14 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
> >  
> > +void pci_doe_init_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task,
> > +		       bool onstack)
> > +{
> > +	task->doe_mb = doe_mb;
> > +	__INIT_WORK(&task->work, doe_statemachine_work, onstack);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_doe_init_task);
> > +
> >  /**
> >   * pci_doe_submit_task() - Submit a task to be processed by the state machine
> >   *
> > @@ -517,6 +526,9 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> >  	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
> >  		return -EINVAL;
> >  
> > +	if (WARN_ON_ONCE(task->work.func != doe_statemachine_work))
> > +		return -EINVAL;
> > +
> >  	/*
> >  	 * DOE requests must be a whole number of DW and the response needs to
> >  	 * be big enough for at least 1 DW
> > @@ -528,8 +540,6 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> >  	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> >  		return -EIO;
> >  
> > -	task->doe_mb = doe_mb;
> > -	INIT_WORK(&task->work, doe_statemachine_work);
> >  	queue_work(doe_mb->work_queue, &task->work);
> >  	return 0;
> >  }
> > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > index ed9b4df792b8..457fc0e53d64 100644
> > --- a/include/linux/pci-doe.h
> > +++ b/include/linux/pci-doe.h
> > @@ -31,8 +31,8 @@ struct pci_doe_mb;
> >   * @rv: Return value.  Length of received response or error (bytes)
> >   * @complete: Called when task is complete
> >   * @private: Private data for the consumer
> > - * @work: Used internally by the mailbox
> > - * @doe_mb: Used internally by the mailbox
> > + * @work: Used internally by the mailbox [see pci_doe_init_task()]
> > + * @doe_mb: Used internally by the mailbox [see pci_doe_init_task()]
> >   *
> >   * The payload sizes and rv are specified in bytes with the following
> >   * restrictions concerning the protocol.
> > @@ -53,7 +53,7 @@ struct pci_doe_task {
> >  	void (*complete)(struct pci_doe_task *task);
> >  	void *private;
> >  
> > -	/* No need for the user to initialize these fields */
> > +	/* Call pci_doe_init_task() for these */
> >  	struct work_struct work;
> >  	struct pci_doe_mb *doe_mb;
> >  };
> > @@ -72,6 +72,8 @@ struct pci_doe_task {
> >  
> >  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> >  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> > +void pci_doe_init_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task,
> > +		       bool onstack);
> >  int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> >  
> >  #endif
> > 
> > base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
> > -- 
> > 2.37.2
> > 
