Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7EC54C096
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 06:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiFOESo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 00:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiFOESn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 00:18:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D408F4A3F7;
        Tue, 14 Jun 2022 21:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655266722; x=1686802722;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RAwT4sNZajwkr9AmI8kob3r3qSmavigBxRxkj2BnNVY=;
  b=Y5v5wACsLpQzNPc384KdNaB8Tmv3HwRDzduuRQ7uRs3nnxREtq+dADPi
   QKaSotSUTmZjLE1CY+HG/p+1v4/8LiNezP6UNe4K4VTDrHhO6PFShHlM6
   3x9zVPxhhlhf2VgyLmJIFhKwQw4po+9t2I7AQwrgMhquPnsJZsM9Zy7el
   Wd/slp2ZJJLOkxoOC90ze8gvCVBKfU16WfQcDDiV09xsWFZUkzCxkXUy0
   /XtLySP5n6Ww+vnTzYL///iiBrINX7IOWYwrb7P4NCOna+UVC59nfwwIz
   zgT+TrXjRN32xBBIs0rnmMmxXms6h373KnRKLxMw+U72YnLoVTEaLFUrj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="365178201"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="365178201"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 21:18:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="687071159"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2022 21:18:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 21:18:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 21:18:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 21:18:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEYf7DKPWjxNeF4bBm2oUO7/jS1Y3R6B3MqPHIki6U9CQRT8owKqhdsEEmUKCqKwQgFSxgLmCojtfwh/ZDY/x2gB5lilO4K5HaePudv13JItMdFqvh1iLBEnWPkMecIf7Tj2A4YpOKEUsXzyTWKD6xhFDKSnBqIF4mUYFEU4HjPeeB8KwXB9GUCd2uhYXf3h9DXv2lPqFfU1qKZiBFSGB6xbU3VKPJ+ceLMD8VR3WZiHHzCw0WBeETNPB8JipRCpx4esjgPuE1NewImWP8cCdx2vyyB2AiWaWwfn3J7UQRhi1NT6Fz/YZ1xvFkG2hR34J8DNNXZypB+fcos4jxxQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oLI0mNN++8B0XG4z2vdLcOkCkJJUNpctykVgNfZ22g=;
 b=AnPzKpL+26UE01/mBLmkIB3qGHGtZvU0DYFwgw0cHtOpB9ODtRUzWgERgwKyOMJ42TKgI1jamNVJbfQ8D/W/B0YqmyM4m9J4nTnoM19RvfeKHAnbwDMDVRNTNvUdv8Stdgz/L50x3K73chJa9q3LpvFOjpe2G3dksDb2tWOvfJupB1h9rAyc29ph0HIxCNb4IfdrBpa7UzZlOIQXmVMN9G0RtA47IscQOH3xtHOKOmQDxwvB7ewZ07uzL6WPRuQu12q8GwpLP6YYLdNUO7kfIV03U37Nz1v8PfOIh78ORtL7wCuunq8ejkCYhv0LPS/RWOFUIHuXfmX3wQ5RSY6rGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MN2PR11MB3632.namprd11.prod.outlook.com (2603:10b6:208:ec::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Wed, 15 Jun 2022 04:18:40 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%5]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 04:18:40 +0000
Date:   Tue, 14 Jun 2022 21:18:34 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Li, Ming" <ming4.li@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <Yqldmmqdh0HU5/NP@iweiny-desk3>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-4-ira.weiny@intel.com>
 <d67f9d0f-e4c8-35e5-e115-745516655e3b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d67f9d0f-e4c8-35e5-e115-745516655e3b@intel.com>
X-ClientProxiedBy: MWHPR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:300:d4::16) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a6d9d76-f9d2-4bb3-cd88-08da4e86206a
X-MS-TrafficTypeDiagnostic: MN2PR11MB3632:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB363252C2A32DBA366FE588DEF7AD9@MN2PR11MB3632.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtJ3zZrD4O3RALoZ1LFiMpRad23QxGYtvRBO15Qt6Yi6XBn9ybDFXneBLzbpswoGcbnIMLMc5SUOhOb+7FPLevY7Y5kS6S8Olr47TnH9iterAlvJ6759QATHQwQKllJAlToWWghmX7Mm96ynAHwOddF03Ifs6CTqVJC2G5vs7LJDJaKLWil6ddB5299cVIE5255i9Rlu/nLumPmkoJucToMp7nVZHbfNS9vb4Ax6PIrz4iIpyZWfzu2vXdsRRyaQFWKnBPp4z1yK2DNB00Ac04VQn1hZXz8V4PmW+rTWPQGoS4IvZoDtbtdSfW5JW6pYQ5rlHnbWI1UhW+qY/ODXKXxhQui1IScIf+VdVqflVia+ctkPYJZAnLcz2mh14aMzTd1dA8XPdt1J/ll6gy9F7XyzjSvojR2Q3iOiBknGExPuWFjI3/3oFXIzLf3U4EPnuD5yXNuaQMitKpRAhEYDJBcGRh7uUqCR+JspBawTo7I/a6fz9vNoupZ4vhwLm/eifo7+0WF1IJenyokpQmIj1VgCjl/u4bXzehuoKTsAqOzBGpCHTGZuhX5yIib2C6lfhEfxGRjK9nv3wBdWJ0Fe/24l/MChDDvFn1fp5G0cVXjMCu50xOYrmPvI1DSlSF1V3POuEfFg8/FOqH+icPFNZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(8936002)(6862004)(508600001)(82960400001)(5660300002)(44832011)(6636002)(54906003)(15650500001)(316002)(8676002)(66476007)(6486002)(4326008)(66946007)(66556008)(6506007)(53546011)(6666004)(9686003)(6512007)(83380400001)(186003)(86362001)(26005)(38100700002)(2906002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AVMD+GRDa3DZx5KJRucHEu+282m1v+LpeSm0EJ7RJHl5BmcId8/h9rbkh3hh?=
 =?us-ascii?Q?T4gLuX2W354+l9vbbWZFaMg8s1w8Jrro/7fH/LMAoc4TxLk3xSbjHKQMkPGL?=
 =?us-ascii?Q?/rbMKIXpXj4T7sfMsnFz/24mzqU+z2DY5PkV69YFhglj0MITmWxnznI59PSW?=
 =?us-ascii?Q?EAzeMOhjWzjaDlevcoDFbpASiIKbVE8xSSkgIFDCN5vEEm7m/uW/6+59QF0a?=
 =?us-ascii?Q?TnL8k60UW7AFmFxmuTX4xC8ICC1jyXIAACqIz9XEiExsrZ1DcuSVs6uIgrmI?=
 =?us-ascii?Q?rPW2+7HoIu9p8aIrMTtcWLDhTW7AM7tOXESJn0tzHtkHnX51AhQqYU005f6e?=
 =?us-ascii?Q?j3BWVEX2pbt+kJpRH8it2mBkNWfjPUszNewY+Xx5UAeDbqcim7osvAK46tl7?=
 =?us-ascii?Q?GWDtU1/N3BR6kXAMZ51k87ougYeTGK0QbMjwzo/lb+aY97LaGBfGxnAm5t1b?=
 =?us-ascii?Q?9HD+plbUaejj7MDSIm/kKTEYJ4LMDhtNqR01WOPVnAQSDgaBxeukC9mgiWJF?=
 =?us-ascii?Q?Ie38insrFBJwQEr8wwldYQLjFhjuRQ8TYB+TxQsMGoDtnXOHnyXWubd7K9hJ?=
 =?us-ascii?Q?WghNSEbpiYnru4mHG+TiwPEEknvQoZdkd3vgvJ764dpiYchDrEe7t5BFhCse?=
 =?us-ascii?Q?zxxFOwyXzW3NJz9xBrXmMuxDs9xGNy3zYpz4iCjM+UVhRgnDx/VN5M0LywuF?=
 =?us-ascii?Q?YPglLLT506JFTIrIUqS/W+jSbSr4RSIJyI+0BqXHsEDfcMyESqjVeVG+2Dh0?=
 =?us-ascii?Q?DdjM0op9QS3TWDVy49qVpUKMnSoFpI2JZRi3tZoRswa62EPyfZY+7t7c+7QI?=
 =?us-ascii?Q?+UYYglinfh5C0q1YL5sf7aJvnHKDYRP1Wy5KqILmBTcyQMszXS/DoO2+HT/g?=
 =?us-ascii?Q?dHPKE9T4jTLWqTzuThxCu0RPiZH+mnSGVvrkQHvDQTIbCQB4uOovCqdvz4T3?=
 =?us-ascii?Q?KJhlP4Hw1vI8ruqYiKIL1ZxhzLkKltOevalMuuAlzJNObol/8ylz/ib2Zp52?=
 =?us-ascii?Q?pmNpsM0HzuDQgSaO3GEKHk23DgnxsCivebg0xNO4oLyLatNY/eIODQljj9c5?=
 =?us-ascii?Q?MClk04KpigGuEOjVHb6pQU8Yq6FOhtxPob9uIgDgPUMewBtWAYYAudHUC21b?=
 =?us-ascii?Q?Ei0YIId1KbMT6DKvZr8Vjqn0e9qZtiU4bGH5fHRj2znjwzt39YcyU3xDgWsq?=
 =?us-ascii?Q?0feKFxlQLtgOYHQ0HGuSAED1WbMxJ5UNcgIEMTYRT0V3v/MFhyH9UFEljj6d?=
 =?us-ascii?Q?MWKkxjlMx2ALWu/GquxnWRjut+TwewoscX5+iNqrxKRiN2zAwx8xbmFPhNg8?=
 =?us-ascii?Q?TlZd4CgDu8rx5NZql5ZXs01axibKLI7MQ92uHnfOdcQ2pMGSGKPfrjYXhvfO?=
 =?us-ascii?Q?zYniOSw2ISDeBIPq2jyJP9Nb7qE//41mZfhnBBic2KaC/DelURZd2CmAeJow?=
 =?us-ascii?Q?cMc1uFVpKKy5IezhBnXiI/I/+Ah6CySHSbo7vhh3ZUwP7KQrxmWtBFZ1++cM?=
 =?us-ascii?Q?/uKB5seqmVLqI5mJ8YWBpNAl7lg40EieD5ODUH0K/aMdY83R3tlDmlzRfWxt?=
 =?us-ascii?Q?WPgSMlvAPWALSaZ29PmZxM58ZAJw+8tniN/kD42i3Tn9d1H6NISamcHyFYBH?=
 =?us-ascii?Q?wIUa4AI8tnMh8AOlof1dDWNtjlUXcGN+BEaD/ukUQLZNhS/X7l3zrRu3jc+5?=
 =?us-ascii?Q?EK/FHKu1eNnIYDep3G/vyKsIkvDbPZ5mTgndy8hWYU0a/tQhxMrVVL2cuaiM?=
 =?us-ascii?Q?POsJ5vTxgKlxzb20LGPRlTOYfi1ZVeM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6d9d76-f9d2-4bb3-cd88-08da4e86206a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 04:18:40.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1ppAwR2V5FaXmQZnbTZAp3epf82154rtqJPIhk9pNokEW/Yf70PuKQtb6wKHF/XSMlLHFvgmCohRVP92xyLbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3632
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 14, 2022 at 11:53:29AM +0800, Li, Ming wrote:
> 
> 
> On 6/11/2022 4:22 AM, ira.weiny@intel.com wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 

[snip]

> > +
> > +/**
> > + * pci_doe_submit_task() - Submit a task to be processed by the state machine
> > + *
> > + * @doe_mb: DOE mailbox capability to submit to
> > + * @task: task to be queued
> > + *
> > + * Submit a DOE task (request/response) to the DOE mailbox to be processed.
> > + * Returns upon queueing the task object.  If the queue is full this function
> > + * will sleep until there is room in the queue.
> > + *
> > + * task->complete will be called when the state machine is done processing this
> > + * task.
> > + *
> > + * Excess data will be discarded.
> > + *
> > + * RETURNS: 0 when task has been successful queued, -ERRNO on error
> > + */
> > +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > +{
> > +	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
> > +		return -EINVAL;
> > +
> > +	/* DOE requests must be a whole number of DW */
> > +	if (task->request_pl_sz % sizeof(u32))
> > +		return -EINVAL;
> > +
> > +again:
> > +	spin_lock(&doe_mb->task_lock);
> > +	if (doe_mb->cur_task) {
> > +		spin_unlock(&doe_mb->task_lock);
> > +		wait_event_interruptible(doe_mb->wq, doe_mb->cur_task == NULL);
> Hi,
> do we need to check the returned value of wait_event_interruptible() here? if the returned value is -ERESTARTSYS, I think we should not try it again, just return.
> 

I'm not 100% sure it is necessary.  However, I don't think there is a point in
trying to continue if a system thread is interrupted.  So yea I think this is
a good idea.

Ira
