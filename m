Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93E2556F5B
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 02:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiFWAZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 20:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiFWAZM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 20:25:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AA16580;
        Wed, 22 Jun 2022 17:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655943911; x=1687479911;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/NZUstn51YIE3RonBJT0C3DB1Q3NWOCGv1inh4KMDVw=;
  b=XeuzwC681al4GBgZvTOYuVXNE0HbR/9tNpF3xvrB7YC8gUsMfC9MOLPt
   U1GEllSb1QBg6pzv9Iw+lYXWW73FyUz70fJmw4ta30NrmQykN8EmWtb6J
   HR3WU5dj8CnLc6L4tsOjZu7l2ZzRRoZwaSfOxMnml3L/aaujJi7YY49ff
   Dn+LlkMBICF1WfbbmQMUjzdP+6i00QiBGmzKX5zGNSC3p7n8RKLHMHuzs
   56IbUhF2A9UILv08/oyGzou7G45PBBxHTYiwCQ8KDX/EnYfZQ4L+pqBlf
   s0zRcIUwKqKJY/2t0SKndmKUtTqAq3zNXkMbdOJSsBFGjp9Vi5EUhOP7O
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="278133121"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="278133121"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 17:25:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="834384989"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2022 17:25:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 17:25:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 17:25:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 17:25:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUouGjYn4hQPh7k8apYCPifDH+EJb2rlXpGv2cUxu1LmzOTtZq3fuhtSG3AnamPhOzpTb2Ij0HvITEaxWcfh1/gravtIX9gRSWuVBsefgswuZCSlvlp6wx279QHYxC3p++tu5rvT2/x0l3us8cvaYAPak3oZaAi5+VSYudrv9QG+rhkhmHvjfbsKNqWED4HlPXIicBO0YrW10HryWTObg9E58Jdp2Ln2A6tDTy+s83Pmf5RuIZQLIFqQ2dymurz50krdLXdHN2DhgKi4sfNsr/MkbkR6LJBKsCwjFulGVlcTlwGLHaTWmFECkTw4JBZxY30CywGowS4Ibd52dI4zRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RhcxbcqDoK+buXSP9xI6rZycDi6k4CBDobi8hTkRvU=;
 b=eBdiiinCQmothf0OLLk5rQbc2DfnJK/Xs5Zf2HRm3/e2sudfCs7IWQVxZ5+S+OZAdXJEHmp+J6h6FsuetwZJHzVWAO/QXFS+IZdQ6fimOSOg2oNi/1MB0jgGIFixT2reBDol83LkhE2JqCxcfu8tp3bqGy7RIJV81qdqJR0aRCYzoO/gVvKT3UkaRz2e5CoLTHEACrdVqh70it8pBxAJk1ePIq7BEjy74bqhBF/ly3UsqJiSGjX5Kn12v7d5KnBx5t0/PRYBguYpHJs0j2oz9vvQmy0IPecLx78xCA2X4WUGXjyHFI8epNoyjfFA+u08OUwEG8X4auFOQOkNK4d6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM4PR11MB5536.namprd11.prod.outlook.com (2603:10b6:5:39b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Thu, 23 Jun 2022 00:25:08 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Thu, 23 Jun 2022
 00:25:08 +0000
Date:   Wed, 22 Jun 2022 17:25:02 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <YrOy3vodu3FcRjUY@iweiny-desk3>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-4-ira.weiny@intel.com>
 <62ad06a643ddf_844b1294f@dwillia2-xfh.notmuch>
 <YrObe+AdfziEPlYB@iweiny-desk3>
 <62b39e5eead1_32f38a294b6@dwillia2-xfh.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62b39e5eead1_32f38a294b6@dwillia2-xfh.notmuch>
X-ClientProxiedBy: MW4PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:303:b4::21) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8053734d-790b-4e74-0df6-08da54aed3d6
X-MS-TrafficTypeDiagnostic: DM4PR11MB5536:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM4PR11MB55366B8B0D41E9930738C0B6F7B59@DM4PR11MB5536.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pK2MWwqfB64snFPQ7nsZ7mAWJ3UweTl6IuMKHbN3VStYPeJvNOjiAR5Q6JVVyYonIkfTm8Z1SMQt4mpP5IuFc1OqmLP/KrMr2QUA23EW5isQqO9uTwGWVu86+dOxdEeNui+g2dUdmXBwQJPP+Thj1Qmy9FUMj9E6WUvUR504SMbTq87YPtUDIxHQ4//9jdctyVly/ui5q1P7GPFUSTZ3HSjfKBdV59dk9YQjQd2OcVVFkKVZXQzUaUXGg0iw7w+e2beIbPM+k498uHS8spErAPj8tXdeKG8pII1C8qwyxEXRpySA97AjK8XEnhThiRo5frYNQ2nhHdkK+doITg1f6Zhd77IW5bSCMdSIRQtCyVqFuwwvj1Burrvqc+ir+ZofI3C3PcmaDSQJBguBs7w9lwTpYFpBZYkwswufgS58MSI8HVgw/YEsT+pCdg3HziUzfPfO2+/ClquagZtuyNSG74QyZOhCd5rsxJsP3d4CV34F9Zj/csT1zwVK9kOZHosigReF7HhSGDEClFAPRbzWKMrNbZX81dcmTNL+QeVIzEauDyPHqIjZ7ncPctRZbBuxnS8Kkr6iYrrythhibOsFn6qKwIC8LRtrPeggg+OzJn8XDvVLAfQp5OzEMLeoq88i+5Se4bPMBTTE0Mm4/BV62UQlQ39hs2eVxOMNGc0eCHuWp/2qGjWQwzkKLPCR17ks
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(396003)(366004)(39860400002)(136003)(26005)(4326008)(9686003)(2906002)(44832011)(6666004)(316002)(6512007)(6506007)(66946007)(66476007)(66556008)(86362001)(54906003)(8676002)(6636002)(38100700002)(82960400001)(41300700001)(5660300002)(478600001)(6486002)(6862004)(83380400001)(33716001)(186003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KskN203duuqARywGEAOeVrU+MZimzfGuUZG7m17+Tc3fjXG0cS4Zm8iCQtDY?=
 =?us-ascii?Q?RzBhhndGShwZfoFHZU86rJ+PZ1tka1EPbYDWdme0Gw5QOFMbru1SfnhymdBv?=
 =?us-ascii?Q?b2qzenZ0Duyfroz86ZDDFVwY+NLyArLEqzhCS8CQ0i0hLyUJqE8yfKai6tPk?=
 =?us-ascii?Q?IgUQdPG6/B7uWHwcu81hWO/sRusF8OwDolmGp4+Sac9KXEGKl9EaBHbWnSIH?=
 =?us-ascii?Q?qCkCa/3Ku5dXOx7HrF+BiP9enJaDY/Vnhl7hey3m4wJIuXAQjzLyzmKZHSfO?=
 =?us-ascii?Q?hFFDV4AUrDbjLQWC0OqlNm3YluUzXLsphiwZvRLTmGA6uOpZ31cLzZBCWbyP?=
 =?us-ascii?Q?fchsvR7Egjvu7bg1xXVgxJpqP5iWoBXtQazAck0E1U/D+RmeIyABM0aRq5X/?=
 =?us-ascii?Q?jC4E63xQ81Br8DKpcXJ0CTfei4pm9Lp8JRQxBmC6fY41aSCTrI6d9s7OkQWo?=
 =?us-ascii?Q?SC4TgRT5y8+WeBy21EIutTyYc9exShGznAgaELncKgq+e4KjGXCZZm3ECzwq?=
 =?us-ascii?Q?Wji7amRsglvOdEGIDM5QRCyKecMFVq8eA+Dzs7rASyuqk9LibQOljTIWdlsY?=
 =?us-ascii?Q?WbVAn+wrvZqg1aMdCSlvoGn+J85X4rsBZSVLHa7bxFubF3EZ88aUXFnYGUKE?=
 =?us-ascii?Q?Sk9ASdNDMsKXOpno12DnHfUBldW+H0mmZMF1GbFe28pQnxsIFqMkeiaNoNxd?=
 =?us-ascii?Q?A1KCqLaIa7pYQ5NMD1A7jRWyM8oDSLLsXqDaryD8G0Hbm2ecEPiu+QHmCWA+?=
 =?us-ascii?Q?BeZvftvx01Z/D0Lec+2md2JkhMmzAD8sfauTK6nhQTRQaBA9/L6oUdTJYdEu?=
 =?us-ascii?Q?lpIDsf3I3oW1i+bnXLOOBwQ13fe54Vi5Klou2CkbovruywU35q+vm8M7kSex?=
 =?us-ascii?Q?4fHu7p6fHtgF9hBtS5PAHZeG6qqOIY8s2jS23Fx8mprif6Zj1VHwHxEPWp6x?=
 =?us-ascii?Q?XS7Wx3ZgrQky7+Kj8Dri5Ds72s3xLv1L/taBXtN55s93CCA9cMpyiiHxuTSD?=
 =?us-ascii?Q?bZuxmNBTupBRNQNZBbqIy3xwN6azdB5Atz9c+pKE4HfDyHl66NFUynQXa3by?=
 =?us-ascii?Q?IiUSG/GCaHsebFlH0ynrERkcIu9jgbNi1Kk0UA/ufWMbgdmzC0K1M6KFIdWW?=
 =?us-ascii?Q?9NF8KVWPWDxR1jXpkn60nq91Ul9HcKvYeVQ6pVhDVw1TJ9X9Ye8S3SauoR3g?=
 =?us-ascii?Q?+GkEXrXIK0JrYB83oUdNLH+YceKixErbUDWReeYBRmgXoEUq2gfScCF2nXWS?=
 =?us-ascii?Q?FIeuZ4r7M1AvYvXVmr114RRHhrFLTKJVxzXllK76JCrXAlBtuZ2xOtqWQgfj?=
 =?us-ascii?Q?aRgFZE96l8Kr36rL4ecAYLk8Ssyf0VntLmURE1XnWqXkrtf/IeOQVzZjRyc+?=
 =?us-ascii?Q?DWNvhtc950HPKgtq2ThkBYucGLNq/W4Mhj+i6uUC8tQScqUmjKnjvuAeLzDR?=
 =?us-ascii?Q?xdfoOYvIktEQM3FQHwqmUevuYaqz/JfKCIeZ4SNhMCjKVjAloCKL375iJRob?=
 =?us-ascii?Q?OTXGO5vrPH0DU0tKGGB2dtNYDtJUl1Hd1UbEi3FbntVaTkVNA0gl7Oub8cCh?=
 =?us-ascii?Q?rv4xMuzuIIVfisub4RrgFZ9yCKbyWc8Pt11JkDNKEh8rGqW2yn0lKYBJ5beE?=
 =?us-ascii?Q?kZQdM8nKZDlGw2MfcuJH6Dqq8miyDqigRkGfOlUIdC2CuoOv9mxBOj+pMy8n?=
 =?us-ascii?Q?NMQTrNl1mklM1zu2Q5D2sY4tG0jDULd3pactrVHAK45f1w7ByndrIp6OKa3i?=
 =?us-ascii?Q?4dpsNvjYtNN3p3XnD6TSQqx7I3uPgBU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8053734d-790b-4e74-0df6-08da54aed3d6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 00:25:08.2516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ev2AolJYYfs/FKJap0bfVnR41o4l0fXx4qfMxy6sf51mYh+c5zNENh72c3GvYJHC9CorHsQRndx1uLDnv+gWYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5536
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

On Wed, Jun 22, 2022 at 03:57:34PM -0700, Dan Williams wrote:
> Ira Weiny wrote:
> > On Fri, Jun 17, 2022 at 03:56:38PM -0700, Dan Williams wrote:
> [..]
> > > > +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> > > > +			     u8 *protocol)
> > > > +{
> > > > +	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> > > > +				    *index);
> > > > +	u32 response_pl;
> > > > +	DECLARE_COMPLETION_ONSTACK(c);
> > > > +	struct pci_doe_task task = {
> > > > +		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> > > > +		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> > > > +		.request_pl = &request_pl,
> > > > +		.request_pl_sz = sizeof(request_pl),
> > > > +		.response_pl = &response_pl,
> > > > +		.response_pl_sz = sizeof(response_pl),
> > > > +		.complete = pci_doe_task_complete,
> > > > +		.private = &c,
> > > > +	};
> > > > +	int ret;
> > > > +
> > > > +	ret = pci_doe_submit_task(doe_mb, &task);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	wait_for_completion(&c);
> > > 
> > > Another place where the need for a completion can be replaced with
> > > flush_work().
> > 
> > No not here.  While this call is internal it is actually acting like an
> > external caller.  This specific wait is for that response to get back.
> > 
> > This pattern was specifically asked for by you.  Previously Jonathan had a
> > synchronous call which took care of this but you said let all callers just
> > handle it themselves.  So all callers submit a task and if they want to wait
> > for the response they have to do so themselves.
> 
> Ah, true I remember that. The nice thing about a doing your own
> wait_for_completion() like this is that you can make it
> wait_for_completion_interruptible() to give up on the DOE if it gets
> stalled. However, if you have a work item per-task and you're willing to
> do an uninterruptible sleep, then flush_work(&task->work) is identical.

So when you mentioned a work item per task I really jumped on that idea.  But I
realize now that it is a bit more complicated than that.

Currently a work item is actually one step of the state machine.  The state
machine queues the next step of work as a new work item.

I'm going to have to change the state machine quite a bit.  I still agree with
the one work item per task but it is going to take a bit of work to get the
state machine to operate within that single task.

I don't like what might result if I layer a work queue on top of using the
system work queue for the individual steps of the state machine.  So stay
tuned.

Ira
