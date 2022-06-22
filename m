Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46602556EA4
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 00:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiFVWp0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 18:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiFVWp0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 18:45:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B39387A0;
        Wed, 22 Jun 2022 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655937924; x=1687473924;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NUR8hGBRXHvw10xGoZ4sUD+EiuFKy9IZwWBHUbEIb5U=;
  b=GON92ZPnYVrosTl2qfYwANw7WX1b0xGaEXLImnb1GM5T/8TpmVgMXegW
   cU1wjFqTQA3uUSskrYGrYx3++T+d4c+1nmrLU11uf91r/nJEyLDn1cb1j
   heik1iocWNdknTj9RmUjuLuZzQ9pl+FsUUpm6wNJ1Ts1XBkfBTEK+nnZM
   rWBRJjjNBXK86FXJVg4NsVoXdq3bPtEYy2ywtI6+Gf07j5589H6j8wWwr
   1YOgtnrsWHgQ4s3MVGn/24fjT1Tpd93q6BoMUY5Zd1S18s93nNgK8PH+3
   qc3Nqw7mSj81pCSefMNZ0HsWoRdpkwzu3dqzNTloULyGJMQcPR5nF/HQV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="366885972"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="366885972"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 15:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="621092911"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2022 15:45:23 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 15:45:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 15:45:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 15:45:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBysTpFLDtKkL72wEw6A13o20f2KDx+Vn0tsGCO61Ce+maDxoe3hfGmKULEVFYw1Nc9R8E9Fj3WiwWD4LhLkR34ocxDfYf5MWXZ5k5+jOiuKTwZQ0QuSC4rQFWauaxjEMjlyod9vwPyqONFic/aOW+GiU82YVRRUl89FFhw8buhKT9tBI4llROvuwT+f0J3CL7zx+JR9gjeJT0JMPZ9FGIM6qLFK8eeZ3ImHBaloprt5q/L4iRiehuZFEpPrxFKBAuh7BQ+jP+lEl1HAtjIyN7/CwKM/O7v1vTw2iWGeN/S6+6hLwyuv68/9NxE7cOEYyczYwJmyPudKw7mTOhYljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykIuvDY6XhM1iZOSsojX0F38LeSLn/v5ACnvRWACPMA=;
 b=Z168nCFJ2JeufgAAg2+db6vUuvLRQM6PByRMb+qBg6jf8Qk2gAv2XrX7Jxd8OURm41seAqyMMMGwLuVsjZvC8A77GgMi1sVZNgOGIVFyrvrQLlHGgiprjtmeJiBoRrW5rAjpHVzVhCsdghloI8IJL8JuYLFGBAHxZSRmYLVq6MlyuDG5T9ZZQZw7XssXN9Rde27jVJNePNEIuXuZ+A91UmgkVFHlcDSU/GlEhiUSV18GpY0/EamJ1kckPNlPKuJJN7B0S8+dLNQo8FIaGbLWlurRUnzwbBtBBIKjSySykayyYSWwqlHntx2e/rfcCFLB9OUiCUcf6n/Lk3gX+nnrQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MN2PR11MB3760.namprd11.prod.outlook.com (2603:10b6:208:fa::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Wed, 22 Jun 2022 22:45:20 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Wed, 22 Jun 2022
 22:45:19 +0000
Date:   Wed, 22 Jun 2022 15:45:15 -0700
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
Message-ID: <YrObe+AdfziEPlYB@iweiny-desk3>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-4-ira.weiny@intel.com>
 <62ad06a643ddf_844b1294f@dwillia2-xfh.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62ad06a643ddf_844b1294f@dwillia2-xfh.notmuch>
X-ClientProxiedBy: MW4PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:303:83::30) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2907d12d-c7db-4ec0-4b76-08da54a0e25c
X-MS-TrafficTypeDiagnostic: MN2PR11MB3760:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB3760AEBAB718BD9B1920D55BF7B29@MN2PR11MB3760.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lh32bDACdnY2IMd//0NfxU7YO4JhSTP6IXLSLC4/jxBJH+23w5R79zSvfeSOMimqqPX1ri/epxmwNmD2Fh8rDBM+Z5CK6KT+O/V8mieFd5AxV/TbI78FfMXsuMOCBtMy8zb4VspQg6gkbfgkaXNQZnyePEMOMNizk1tacHUxBlwZf9bW0tQJ4cvHw/gd3S5aWFiLUMHV5QSz+CLqFvi5TU6comzvA5Lc3HVZv8r3L0mxFAEm1GJ1+VSEfl7JQxHm4gNXkqzXgyqF/dISvaQhNF8gu9SXDFUiYCWAF79IxSuWtV/Vg1dKxOWgWOabhp4johK+ZeS/yVPVV6wBlsStrxIaBAwxRtySfV3+Ui50cf/PVADN+yVSlEJqUGmW1wcBh/0mGDGxYZCery83S7sko/kfLd+V9aAeV/J5v1n1KVmZ2ANu9wbcjdiWW/dNOBPdI0d3JEJrbyIe+Cwv533GDWpa3HyuFh1ew6KBAn/dTTuzi+I6pEv00GBNAJId0ddJl1Xf316gtcZJP0JDJh67YyZ9/uxQfqhxgLdIkvMbNeoLVZIUmxxZnjQDNHkEshjZwDXgv6ni4L6Kvs8m7VKbAT/7EUkX0AxOe9d6t/MlQJS8VXhDD13yKTaGfdh7UJuUrnsPiyaiyqGOP+fP5kIAdR3uS0b009TP9ypOgsyaio1Z/ehuqjGHCUL6TiOPjs6JRmeuXJiUzpb198ApJ8IbuUcP1evZOyfof+B3BMEri+USkoT7QvWHb1Fvrg+DUYxE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(376002)(366004)(136003)(346002)(396003)(33716001)(186003)(5660300002)(9686003)(6636002)(15650500001)(66946007)(82960400001)(41300700001)(66476007)(316002)(66556008)(4326008)(6666004)(8676002)(6486002)(6506007)(86362001)(38100700002)(6862004)(44832011)(83380400001)(8936002)(478600001)(54906003)(6512007)(2906002)(26005)(30864003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dx+L7JWToJ4ZC0NkCnQudVfj3jaWft8UGq2kwHeXwP7goqERgZOTI8rE5ZSv?=
 =?us-ascii?Q?AAC0yoxQX95Kw10bIvh+85NhPhpCx3cRnUKQzCr3j0spa9gYqXwiWokPrchC?=
 =?us-ascii?Q?MZ0tB08AKldln9K9GzW3ssAcPNGrq4Ch+MeNluVXGfEwAi1lNZcxdTOJcfxJ?=
 =?us-ascii?Q?1aecGP8MPvdMFzsrMwM3Qxo+t8FkSRI6UWa4mJML6IP3y2K7CmIQVgJi9DgX?=
 =?us-ascii?Q?sIXVxcb/3vGtNOTj2BtQRBOVEnHi2AO0i6q3fmG9cJevDX391Cu+qJPt7X9i?=
 =?us-ascii?Q?o5F+w4GXvxfrHosj2Tw2PM3BYM2Iv0foLQBucjYRtti+3eVdsFnLD14CIMKO?=
 =?us-ascii?Q?pL1WPRFTXXvp1RDxYl1pldwUKXwM/KYfhmAq7P3Gk9q28wEFxsRMSQKfThsw?=
 =?us-ascii?Q?z4Mn5kuOXisdTa2MAUdrKM9aTvxmzexLZfKsFUNikTSeG716hH4SzEJQPLgC?=
 =?us-ascii?Q?OGFAqRnYTmYrXiuFbWDZ1Ke0VQE9Wr0OAsZhVR+G4HC+md4/5wBmv7ks4vLW?=
 =?us-ascii?Q?LXb4MDAanapow1TkU2q1kKAhSsCB43jafegKtdThkI1Nt5xqU+fxlbdDV2mP?=
 =?us-ascii?Q?sM5ljTBw3Q+zAYADTu00KiJIHo5iHzRHqRZOjCp+higmLPIwJAjAclk/OH91?=
 =?us-ascii?Q?e5PdMqL1WodFo7nLFbftxgFy8uN+TyxR3PInzGb2tBsQUmGF28myx3fb8h91?=
 =?us-ascii?Q?2cVR8WOYMC9SYryC/EJwu/My2Z78Mv46SazMDxnfQqwl3+nkmzT2e6po/MpZ?=
 =?us-ascii?Q?0m+YDN5I7FQsLS7HcQnYLGenKZnkeURIvaIKlnipLuxWMkO61dzIF/H2BsiF?=
 =?us-ascii?Q?duhl0A/yOab16QrRdBqPhwXiER+am4k24+NJsxmqzilmaRJjV+PV8KYVH+vN?=
 =?us-ascii?Q?TcpsByVvkeBDp69qwRRAT58lus1WANPYNVADdGFT2lTYiXJVTfn1cc3No+6S?=
 =?us-ascii?Q?7gsyPqbfqjBuctRIgqdHHpJ+/nf/N0Anh+3uSOnuos3WhBKe82keT4l/rTZP?=
 =?us-ascii?Q?sHh+sdyaG5w5uDxxem2x0XJApcc0kUPBqR8pxb3/12xRE4m3ssqFxb1/RZ7z?=
 =?us-ascii?Q?Mkj+C6V0oFE5A2xpHTQddGhjIw48O/M1R2SBJi2nCoX0yExW2eCdZ7Q/s1CY?=
 =?us-ascii?Q?PPFoTmnpQ3yXwRZbIiPDmWdDV38GJXXf8+D8duOQ7t7BA1Hr7GL8AkNBkS5x?=
 =?us-ascii?Q?PsH0yYeYuRPEXTQEV1I1ZZqd8t+lUf6CFLiyzupCQzPuPcc0KOqqkJRORkZ+?=
 =?us-ascii?Q?UQdYCY5R6iLkz0ndI13l6pMTfd4+m5eknk4ixE7i8aUMBaQu4bO3ZlAzdrCT?=
 =?us-ascii?Q?DyOxkRpgK854k0jVRhwmEau+ZBX94Ns9AdPPxXzK6AgWZoyzA/7RKRNJBHDu?=
 =?us-ascii?Q?fF8ZCIG/IX3jaWTAdEU7HGGoN3HSZhfAclPymYSn1ovXkRIUSpxxJ03v+qei?=
 =?us-ascii?Q?slgCazFqeX+dTDvPGPtK5Q6ppTZIx3Q9+Saafx0fTlujs9sjx+lGdIXfZ5KB?=
 =?us-ascii?Q?TqEGLziDhoblVc3TiEmKN8gEt8Rc8IYiubRThgrMnTUzhqA00tv4T5VhC+RV?=
 =?us-ascii?Q?PGJwx3ydzMneuhnUnuuagvcLSOMYToNWP1RtXyFAUj5KWdWW1M1eGGsGM9P6?=
 =?us-ascii?Q?PgtdUN+NxGMeZkxuqsDylxu8uU1tdiJPANMaJdNejG7kEqPURReUjq2Isj2d?=
 =?us-ascii?Q?CRjIeYcMdzPxYloDAELvE+xSVejBvqKG1MF6XdON7Yu/fWAow82PRqoGGCTq?=
 =?us-ascii?Q?2BdmWKwMdw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2907d12d-c7db-4ec0-4b76-08da54a0e25c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 22:45:19.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4Cj7H3Hkep0bgSWhunQDrQSOGiqokAOE8UFH7O0vfY4ecKpu6FgTjCoHR89Jjr4ZBTnilxSkDsxm1chOVJbfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3760
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 17, 2022 at 03:56:38PM -0700, Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Introduced in a PCI r6.0, sec 6.30, DOE provides a config space based
> > mailbox with standard protocol discovery.  Each mailbox is accessed
> > through a DOE Extended Capability.
> > 
> > Each DOE mailbox must support the DOE discovery protocol in addition to
> > any number of additional protocols.
> > 
> > Define core PCI functionality to manage a single PCI DOE mailbox at a
> > defined config space offset.  Functionality includes iterating,
> > creating, query of supported protocol, task submission, and destruction
> > of the mailboxes.
> > 
> > If interrupts are desired, the interrupt number can be queried and
> > passed to the create function.  Passing a negative value disables
> > interrupts for that mailbox.  It is the callers responsibility to ensure
> 
> s/callers/caller's/

Done.

[snip]

> > +
> > +enum pci_doe_state {
> > +	DOE_IDLE,
> > +	DOE_WAIT_RESP,
> > +	DOE_WAIT_ABORT,
> > +	DOE_WAIT_ABORT_ON_ERR,
> > +};
> > +
> > +#define PCI_DOE_FLAG_ABORT	0
> > +#define PCI_DOE_FLAG_DEAD	1
> 
> Warning, I tend to review data structures first, so some of the
> questions below might have answers in the code, but I have hard time
> jumping to the implementation if the data structure is not clear.

These are just flags for the state machine.

> 
> > +
> > +/**
> > + * struct pci_doe_mb - State for a single DOE mailbox
> > + *
> > + * This state is used to manage a single DOE mailbox capability.  All fields
> > + * should be considered opaque to the consumers and the structure passed into
> > + * the helpers below after being created by devm_pci_doe_create()
> 
> Hmm, why devm_ and not pcim_ like pcim_enable_device()?

Because I did not know there were pcim_* calls.  But also because that comment
is wrong.   :-(   That was left over from a previous version.

With this version we had agreed to not use device managed calls in this layer
and depend on callers to do that if they wanted.

Since I'm spinning another version I think pcim_create_doe_mb() and dropping
pci_doe_destroy_mb() from the API is a good idea.

> 
> > + *
> > + * @pdev: PCI device this mailbox belongs to
> > + * @abort_c: Completion used for initial abort handling
> 
> What does initial abort handling mean? If it's just a single point in
> time use couldn't that be handled with an on-stack completion?

I think this is going to get reworked with the new dedicated workqueue.  So I'm
not going to address it directly.
> 
> > + * @irq: Interrupt used for signaling DOE ready or abort
> > + * @prots: Array of protocols supported on this DOE
> > + * @num_prots: Size of @prots array
> > + * @cap_offset: Capability offset
> > + * @wq: Wait queue to wait on if a query is in progress
> > + * @cur_task: Current task the state machine is working on
> > + * @task_lock: Protect cur_task
> 
> Protect what about cur_task? Assigning and clearing a pointer is atomic.

As I explained before this is protecting the entrance to the state machine from
potentially multiple writer threads.  See pci_doe_submit_task() for details...

However, again I think this is going to change with the new workqueue.  So I'm
not going to try and address this directly.

> 
> > + * @statemachine: Work item for the DOE state machine
> 
> Why does the pci_doe_mb have a work item? I would expect a work item per
> task. Then this gets a waitqueue for free to wait for task completion.
> Otherwise I suspect this introduces complexity in the DOE implementation
> to simulate per-task-work that a workqueue per DOE and a work item per
> task gets you for free, and for recalling hardware context from one
> firing of the state machine to the next. Just run the task work all
> in-line in one context.

Yep.  Sorry about not following the advise you gave to Jonathan before.  I
should have checked with you.
j
> 
> > + * @state: Current state of this DOE
> > + * @timeout_jiffies: 1 second after GO set
> > + * @busy_retries: Count of retry attempts
> 
> Why is this tracked in the mailbox object itself?

Because this object doubles as the work item.

> 
> > + * @flags: Bit array of PCI_DOE_FLAG_* flags
> > + *
> > + * Note: @prots can't be allocated with struct size because the number of
> > + * protocols is not known until after this structure is in use.  However, the
> > + * single discovery protocol is always required to query for the number of
> > + * protocols.
> 
> Sounds like maybe this wants to be an xarray indexed by the device's
> reported index.

Could be.

> 
> > + */
> > +struct pci_doe_mb {
> > +	struct pci_dev *pdev;
> > +	struct completion abort_c;
> > +	int irq;
> > +	struct pci_doe_protocol *prots;
> > +	int num_prots;
> > +	u16 cap_offset;
> > +
> > +	wait_queue_head_t wq;
> > +	struct pci_doe_task *cur_task;
> > +	spinlock_t task_lock;
> > +	struct delayed_work statemachine;
> > +	enum pci_doe_state state;
> > +	unsigned long timeout_jiffies;
> > +	unsigned int busy_retries;
> > +	unsigned long flags;
> > +};
> > +
> > +static irqreturn_t pci_doe_irq_handler(int irq, void *data)
> > +{
> > +	struct pci_doe_mb *doe_mb = data;
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +	u32 val;
> > +
> > +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +	if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
> > +		pci_write_config_dword(pdev, offset + PCI_DOE_STATUS,
> > +					PCI_DOE_STATUS_INT_STATUS);
> > +		mod_delayed_work(system_wq, &doe_mb->statemachine, 0);
> 
> Wait, no, not system_wq. I expected this wants a dedicated / ordered queue
> per doe and this likely wants a queue that can sleep while processing a
> task and just not support overlapping tasks.
> 
> In that model the irq is just waking up any tasks in execution that are
> awaiting a polling timeout. The irq handler does:
> 
> wake_up(&doe_mb->wait);
> 
> ...and then task that is executing in the queue continues what it was
> doing.

Ok I've looked back and I think there was a lot of confusion here regarding the
use of a workqueue and the number of outstanding work items.

Very early on Jonathan had a queue of tasks.  IIRC you suggested to get rid of
that complexity and just process a single task at a time because we never
expected the queue depth to be very deep (probably only 1 work item at a time
anyway).

I think that is how things got where they were.

After reading through this email I think you are correct.  So I'm not going to
address any of this logic here because I think it will change quite a bit.

> 
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	return IRQ_NONE;
> > +}
> > +
> > +/*
> > + * Only called when safe to directly access the DOE from
> > + * doe_statemachine_work().  Outside access is not protected.  Users who
> > + * perform such access are left with the pieces.
> 
> What pieces, where?

Ok again this comment is slightly out of date.  This call is no longer part of
the 'user' API with the exception of destroying the mailbox whilst the state
machine is running.

I'll delete this comment.

> I expect the abort implementation would be something
> like:

See pci_doe_abort()

> 
> set_bit(ABORT_PENDING) <== blocks new task submissions until clear

Yes

> flush_workqueue() <== make sure all in-flight tasks see the abort

Effectively yes.  schedule_delayed_work() kicks the single work item which can
be in the state machine.

> do_doe_abort(...) <== do the abort

The state machine does this depending on where it is.

> clear_bit(ABORT_PENDING) <== optionally restart the tasks that were
> cancelled, or just expect them to be resubmitted.

This depends on where the item was in the state machine.  It may have already
gotten a response in which case it would be complete or the submit task call
will start returning errors.

Again this path was only called when the mailbox was being destroyed so
resubmission was not possible anyway.

[snip]

> > +
> > +static void signal_task_complete(struct pci_doe_task *task, int rv)
> > +{
> > +	task->rv = rv;
> > +	task->complete(task);
> > +}
> > +
> > +static void retire_cur_task(struct pci_doe_mb *doe_mb)
> > +{
> > +	spin_lock(&doe_mb->task_lock);
> > +	doe_mb->cur_task = NULL;
> > +	spin_unlock(&doe_mb->task_lock);
> 
> What is the lock protecting here? Assigning a pointer is atomic, I think
> this question is moot with a work-item per-task model as retiring the
> task is just a typical work completion.

Yes moot.

[snip]

> > +
> > +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> > +			     u8 *protocol)
> > +{
> > +	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> > +				    *index);
> > +	u32 response_pl;
> > +	DECLARE_COMPLETION_ONSTACK(c);
> > +	struct pci_doe_task task = {
> > +		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> > +		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> > +		.request_pl = &request_pl,
> > +		.request_pl_sz = sizeof(request_pl),
> > +		.response_pl = &response_pl,
> > +		.response_pl_sz = sizeof(response_pl),
> > +		.complete = pci_doe_task_complete,
> > +		.private = &c,
> > +	};
> > +	int ret;
> > +
> > +	ret = pci_doe_submit_task(doe_mb, &task);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	wait_for_completion(&c);
> 
> Another place where the need for a completion can be replaced with
> flush_work().

No not here.  While this call is internal it is actually acting like an
external caller.  This specific wait is for that response to get back.

This pattern was specifically asked for by you.  Previously Jonathan had a
synchronous call which took care of this but you said let all callers just
handle it themselves.  So all callers submit a task and if they want to wait
for the response they have to do so themselves.

> The only thing flush_work() does not offer is the option
> to have an interruptible wait, but for in-kernel DOE cycles
> uninterruptible is ok.
> 
> > +
> > +	if (task.rv != sizeof(response_pl))
> > +		return -EIO;
> > +
> > +	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
> > +	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
> > +			      response_pl);
> > +	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
> > +			   response_pl);
> > +
> > +	return 0;
> > +}
> > +
> > +static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
> > +{
> > +	u8 index = 0;
> > +	int num_prots;
> > +	int rc;
> > +
> > +	/* Discovery protocol must always be supported and must report itself */
> > +	num_prots = 1;
> > +
> > +	doe_mb->prots = kcalloc(num_prots, sizeof(*doe_mb->prots), GFP_KERNEL);
> > +	if (!doe_mb->prots)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * NOTE: doe_mb_prots is freed by pci_doe_free_mb() automatically on
> > +	 * error if pci_doe_cache_protocols() fails past this point.
> > +	 */
> > +	do {
> > +		struct pci_doe_protocol *prot;
> > +
> > +		prot = &doe_mb->prots[num_prots - 1];
> > +		rc = pci_doe_discovery(doe_mb, &index, &prot->vid, &prot->type);
> > +		if (rc)
> > +			return rc;
> > +
> > +		if (index) {
> > +			struct pci_doe_protocol *prot_new;
> > +
> > +			num_prots++;
> > +			prot_new = krealloc(doe_mb->prots,
> > +					    sizeof(*doe_mb->prots) * num_prots,
> > +					    GFP_KERNEL);
> 
> An xarray saves the need for krealloc(), and probably even the need for
> a separate 'struct pci_doe_protocol' allocation since that data fits
> into an unsigned long that the xarray is already allocating for you
> internally.

:-/

> 
> So something like:
> 
>     struct pci_doe_protocol {
>     	union {
>     		unsigned long val;
>     		struct {
>     			u16 vid;
>     			u8 type;
>     		};
>     	};
>     } prot;
> 
>     pci_doe_discovery(doe_mb, &index, &prot.vid, &prot.type);
> 
>     xa_insert(&doe_mb->prots, (unsigned long) index, (void *) prot.val, GFP_KERNEL);
> 
> ...and then to retrieve:
> 
>     void *ent = xa_load(&doe_mb->prots, index);
>     struct pci_doe_protocol prot = { .val = (unsigned long) ent };
> 
> ...wrapped up nicely with helpers to hide all the casting.

Interesting idea.

> 
> 
> > +			if (!prot_new)
> > +				return -ENOMEM;
> > +
> > +			doe_mb->prots = prot_new;
> > +		}
> > +	} while (index);
> > +
> > +	doe_mb->num_prots = num_prots;
> > +	return 0;
> > +}
> > +
> > +static int pci_doe_abort(struct pci_doe_mb *doe_mb)
> > +{
> > +	reinit_completion(&doe_mb->abort_c);
> > +	set_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags);
> > +	schedule_delayed_work(&doe_mb->statemachine, 0);
> > +	wait_for_completion(&doe_mb->abort_c);
> > +
> > +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> > +		return -EIO;
> > +
> > +	return 0;
> > +}
> > +
> > +static int pci_doe_enable_irq(struct pci_doe_mb *doe_mb, unsigned int irq)
> > +{
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +	int rc;
> > +
> > +	/*
> > +	 * Enabling bus mastering is required for MSI/MSIx.  It is safe to call
> > +	 * this multiple times and thus is called here to ensure that mastering
> > +	 * is enabled even if the driver has done so.
> > +	 */
> 
> It is required for MSI/MSIx to work, yes, but if the caller that created
> the doe object has not set it yet that's its prerogative.
> 
> > +	pci_set_master(pdev);
> > +	rc = pci_request_irq(pdev, irq, pci_doe_irq_handler, NULL, doe_mb,
> > +			     "DOE[%d:%s]", irq, pci_name(pdev));
> 
> If the DOE object creation is use devm_ then this wants to be
> devm_request_irq(), although I now notice that devm_pci_doe_create()
> only existed in the code comments, not the implementation.

yea...  Sorry.

> 
> Is there any need for the unmanaged version of this API?

Only that we had agreed to create it unmanaged before because of some auxiliary
bus oddities which made it easier to use an unmanaged API.  Now that that is
gone I'm changing it to pcim_*.

[snip]

> > +
> > +/**
> > + * pci_doe_get_irq_num() - Return the irq number for the mailbox at offset
> > + *
> > + * @pdev: The PCI device
> > + * @offset: Offset of the DOE mailbox
> > + *
> > + * Returns: irq number on success
> > + *	    -errno if irqs are not supported on this mailbox
> > + */
> > +int pci_doe_get_irq_num(struct pci_dev *pdev, int offset)
> > +{
> > +	u32 val;
> > +
> > +	pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);
> > +	if (!FIELD_GET(PCI_DOE_CAP_INT, val))
> > +		return -EOPNOTSUPP;
> 
> I think ENXIO would be more appropriate than this networking errno.

Done.

[snip]

> > +/**
> > + * pci_doe_supports_prot() - Return if the DOE instance supports the given
> > + *			     protocol
> > + * @doe_mb: DOE mailbox capability to query
> > + * @vid: Protocol Vendor ID
> > + * @type: Protocol type
> > + *
> > + * RETURNS: True if the DOE mailbox supports the protocol specified
> > + */
> > +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> > +{
> > +	int i;
> > +
> > +	/* The discovery protocol must always be supported */
> > +	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
> > +		return true;
> > +
> > +	for (i = 0; i < doe_mb->num_prots; i++)
> > +		if ((doe_mb->prots[i].vid == vid) &&
> > +		    (doe_mb->prots[i].type == type))
> > +			return true;
> 
> This becomes an xa_for_each() loop and I don't think you even need
> ->num_prots after this conversion.

Probably not.  I don't even think we need a loop if I understand xarray
correctly.  If the vid/type tuple is the long index then looking up that in the
xarray would return NULL or the value.  But I'm not super familiar with xarray
yet.  So I reserve the right to use xa_for_each().  :-D

[snip]

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
> > +		goto again;
> > +	}
> 
> This looks like it will scramble the order of competing submissions.
> With a work-item per task there may be a race to who call queue_work()
> first, but there will not follow-on races like the ones here for this
> "goto again" case.

Agreed.  and this is all changing.

However, there was no guarantee about submission order in the API nor am I
going to add any.  If a users needs some order they should ensure they are
submitting from a single thread or other synchronization mechanisms in the
callers.

[snip]

> > +void pci_doe_destroy_mb(struct pci_doe_mb *doe_mb)
> > +{
> > +	/* abort any work in progress */
> > +	pci_doe_abort(doe_mb);
> > +
> > +	/* halt the state machine */
> > +	cancel_delayed_work_sync(&doe_mb->statemachine);
> > +
> > +	pci_doe_free_mb(doe_mb);
> 
> Where do racing submitters get told that the DOE is closed for business?

All their submit tasks would return -ERESTARTSYS.  If a task was in the
state machine it will return it's completion.

[snip]

> > +
> > +/**
> > + * pci_doe_for_each_off - Iterate each DOE capability
> > + * @pdev: struct pci_dev to iterate
> > + * @off: u16 of config space offset of each mailbox capability found
> > + */
> > +#define pci_doe_for_each_off(pdev, off) \
> > +	for (off = pci_find_next_ext_capability(pdev, off, \
> > +					PCI_EXT_CAP_ID_DOE); \
> > +		off > 0; \
> > +		off = pci_find_next_ext_capability(pdev, off, \
> > +					PCI_EXT_CAP_ID_DOE))
> 
> New for loop macros should also be added to .clang-format.

Done.

Thanks for the review,
Ira

