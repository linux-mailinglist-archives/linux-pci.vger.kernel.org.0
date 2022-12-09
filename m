Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D45648B6B
	for <lists+linux-pci@lfdr.de>; Sat, 10 Dec 2022 00:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLIXfD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 18:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLIXe4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 18:34:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C11A9D8A9;
        Fri,  9 Dec 2022 15:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670628895; x=1702164895;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QJzHui42ecbELRkxAeD6RGXe0btTH0kJGIE24fDSX3Q=;
  b=f5MKPwz2j2erTiBudYqOmnYlwWmYWrBpqdGngYAZpDUEMN5zfXjjWd7b
   r6CPeN6WxBRYy6qGzreHC6e07fi5CVFOIzUpr1zYj2DsvE6KrCm4tPfHx
   yyDUkrFvQt9MVaYyQZgoP1pqbtbdv9lRbNoaGtneU3+Mxex/VJatOVi6M
   sYE+t5L+p94Hnl9EyLtZ/2LWn0TxibaeCUaSC4PsbGWUs52K+G0eO0Ix8
   MScrjOX5oPcCPb/wcFrRdVSTRMvhodtGFT0j2uEuy8ASYW8fJNaMhHtj7
   b4UvRbgvNQNh2UteUggPULdfUzS9DYlvIXmz8wgnaFHv+xtbRNv6+LbgV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="300991165"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="300991165"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 15:34:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="649714565"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="649714565"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 09 Dec 2022 15:34:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 15:34:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 15:34:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 15:34:53 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 15:34:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcfaxK4pcQpZ5JY50T1933ES4FgT2FXvx/P5Iy9G3umkz9/VVMu0eWbQ0zkxCzA7TdnCFEurIa+ht7HGqMhM+73aAlC4q5LtZ+cazCNTzs4pE7oWbtKGaI27pCNqc5/b4Zz8w9Hka622b+2vueGsJEpebx02qRsCc0zeWW91WWOuSU5926qewzmDxbT0jFivZSSbxfeKSlj+ry4pD2yDXuaf16gwT2ZDwu2gEZV13pzg0rSn9iuv510sZlaszjtqcGSsUxPFyoSvmd4Crj/TgDQZ0chfZ+W1Ko1VHnxDXRTQXaYw2SbWmVZ1njjk0YsgEVxWJDsFluffmh6TNeklWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbOnOER80hMHz78LFZ1JnYA9ELQuMPp/ZzupEMo+Y5E=;
 b=jXIdzwkyMcpiXCrO4WZ4Nz4nibasp6xxOe3404cNv6bWShGfLKFXdxLm00lpce0uY6IBVogS0rl1ZQTrWQnaWq0/KF1b8HUN5hliskvYl/YEhn/HTO/cHj2ZULh50B9A+pOSY++fY7RIGA+NY7hHqdp3qMWxi4Vx/zI/zzmxzsbaiTKRd0nFfx9ai9DIrndFYYMUf7U0O34LcyEaW4LvMJ+Pws312jOF+NR4Ks4lUAMXXTHjLma4IdgnixsHoy9lY0tB/M7u8f7Cms06T+WI0PcYNZmIh07ikJVNaz1/F1+qLmfrvYXkPgnGatVmyNXzcczrVcA5CBZI4ChASZh3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6288.namprd11.prod.outlook.com (2603:10b6:8:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 23:34:48 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 23:34:48 +0000
Date:   Fri, 9 Dec 2022 15:34:42 -0800
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
Subject: Re: [PATCH V3 1/8] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <Y5PGEr4Ngrp07CMU@iweiny-desk3>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-2-ira.weiny@intel.com>
 <639376e1452bd_579c12945c@dwillia2-xfh.jf.intel.com.notmuch>
 <Y5Oh89JFAWYIITUV@iweiny-desk3>
 <6393b7b0e4953_579c1294af@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6393b7b0e4953_579c1294af@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: e44190cb-e192-4c34-79c0-08dada3df547
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRvcOxxe2XaLNMV5DEB8toSNaoA+B3gHtAMDtAA9AeLV5I/W69nyuSvLCwDKphzBrGzQnEBAkr5wsN2LHyhe4uV8PPPiD9zn+U9UfPwibuO3DFhTwMpYali4VlC/vhBKH3zyDkh4tKhxPNTjYnGKPLsiydAywuBoJonMRL8iv0RDyjB5KdYnh6Yp6M75P3QR9d7AiY91YtQdJUvZCzRISIRIrQ0pRUmKfodP8J5Fqo/h0wPpNGvfQsi6piPPp8sf9LcjD8Q0MRaMZkICevEkCM4Nysh5L3SPIXPB2/z3OmwbntwpoHL7Bzq1pRX2jd1YE2sbobRaRJTItvVh0c/CfUjE/GgUXkkATMgDvNqgJaoCRr6DYMDe3U+VPxC8q6SmNnAz8pPvnvir5bG6/rM5u+YHqJ0MXoFijX0mus3eFKl8LduosIfSgtTX87TIzRvoZ+oFVeUVF65fA7fthKbRS02cCTYlnqYfQO2tlw9fzFQN3bsNV1y89yBYDV3ekFi0fEOS2TU8FJZ7GQbnLoZmfamjtLap0YyONtJYwrNyOZA/rMsI94YRGHGKICef/qtigR93Pp9yWhHOwRYFyQNby1ZqfLICbd1z0tbg1+FodGL0g9iCwIzLRveQytbX3v1l+F//xKs5NgcmWY9UoXtdCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199015)(66476007)(66946007)(8676002)(66556008)(4326008)(6486002)(186003)(83380400001)(33716001)(26005)(38100700002)(478600001)(9686003)(6512007)(82960400001)(2906002)(44832011)(41300700001)(6862004)(8936002)(6506007)(6666004)(86362001)(5660300002)(6636002)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EA3IIfCz4LUe9DRH1X00tFaJ9XqLIq8sw06hfVvJ1RYHP2/0mT9WMdg133ag?=
 =?us-ascii?Q?MFrm1mGnh+U4U3anq+lew2mHgwM2NmD2p/F5oGADNP09aKDpHtsStcALBMTJ?=
 =?us-ascii?Q?yV+TQRD5yIbSijNVPyUJK0dT2ln7e5UOIXNppkJ3zUPeTbHaWxUQC7A5Zhun?=
 =?us-ascii?Q?CrY/0BQ3Nip4UM9j0x9r8HE6GiiK4TBNUkU2900E/5Lehe6J6PhScRjYusCg?=
 =?us-ascii?Q?t66tb5/LGuGoJWAZ3cBvLmOOWoPggV8cCm9UBshJb2nS0EooG+F++MPyqAZv?=
 =?us-ascii?Q?JOYkuc/AmLawBFX8yTdOftbEaR+Tzbm+dmOKmYsIH6cV6SKi1CtTaggc6FeI?=
 =?us-ascii?Q?nIcFqef7zSQjdk/VzqYn0d3TFzxW3M/3pA1mGkg45mhidpI2BmwRkng/Wa7M?=
 =?us-ascii?Q?4B4TeEc3XjEwwKLe57mr5vZH7/HXEePyOW19txsseYL1yaGS6Yz91pPyFqb4?=
 =?us-ascii?Q?MxcUYTNIEJe2Ql/7ufHVNGPuOOnInbMdCTdTlvvAwZRCdSp4IslC3JHI0aTV?=
 =?us-ascii?Q?eqTqXCCPIkZCeMXUhZgO1ijJxOSvVf5zQs6s87Oh//MR4Qx/8Us4VkVNV33w?=
 =?us-ascii?Q?4eobSWlxjAW2U9bjUBz2HjWjBsO0OiwZeMTI1TvI0/n43XeuxPV9QJTFJmFj?=
 =?us-ascii?Q?9481ptpe1WOpE4YmQ6GGrdnJH0Q7dD8V1q1pKyZQSuo6wuzudbgiBIT+fM8V?=
 =?us-ascii?Q?mdfgDH5Poe48yS20fvWnzXWi+PUUEF+ax4DFbBThKJwxsZWv7RIfNXbDpYKU?=
 =?us-ascii?Q?k3r/EY28mG1rq0LrVgpKk0BMzjJ31j0wXpjBN44ZvDFumZ7E7tbbnV5wAm1E?=
 =?us-ascii?Q?zHEqfIYYy7gqHB36mViTo520JqFGZJI+pw7Xmv1KTxM9+8ITxXmpM+JAvPEM?=
 =?us-ascii?Q?QX692n+xTL+slEUmSEpOuO6yYBcnFBqMVkQP/uEzeCumQYtPAKxkgLJ52zZ/?=
 =?us-ascii?Q?NbaVWcefDV26H487yuQTpPAduUeeGm1WSPzgHB/fQDStA5aDgZVcnaq4CFMf?=
 =?us-ascii?Q?qDwbvcklPF7C+lLIa/m3jNB5wTen5mHqwxjovWAD7qWooIS54S1RXqMwdKXW?=
 =?us-ascii?Q?VX8uvLM/MSPPaSNES1ScgRqLA06iztZPEuEXOZYjkrZ1wwN4SQ3T3lqCPsr6?=
 =?us-ascii?Q?44Uk1wNW8sbBHsPEkUiYdntry6dRw4S/+dl84iiSN1WsNHdrbekWX1xUH3+9?=
 =?us-ascii?Q?hs43Jkb1N/2mEHx+5ePHQBR0SnptQgLf8vWwQAXV+DA27zVYi8p0G9LRw9RZ?=
 =?us-ascii?Q?rmf6A/h9QnpbTK7eSryPKtiZDCtGqB60XZHwl32juPPaiOVZn/SmjG/iZGwp?=
 =?us-ascii?Q?9Dlmz//O+6DR3lz3mlfJNRbhPzBOJfWzbu0R5rEq540DkNLu9A9A2B9z3FlL?=
 =?us-ascii?Q?dI+wlJBOLI6hn10WPnvFnvCTOOMBxcfUFxg8FYoMUi1qfv+aJBV0MXpG0JL8?=
 =?us-ascii?Q?ShhoQSbWUufRfYAq+AU+mo9LafAo2zDp17jV5iRobODpNh6erFl4S0Y2IJhZ?=
 =?us-ascii?Q?Kxgf5tNAZath9nptxeZFku3nry66Np1o0MeqqTNB7eTX72sYYYIuo17yo92g?=
 =?us-ascii?Q?F8uEDdPYc15T5KMt11lRlODZ/Gr8lVLqfNxrEC82?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e44190cb-e192-4c34-79c0-08dada3df547
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 23:34:48.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7db0ko9++aT/vkEvPiYqsxYOqQmdbOQUhOyKAZFraqthR2WPGqaf/QQ63OcjNRqbvqVYWnd7cpiXC9yPSINaQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6288
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 02:33:20PM -0800, Dan Williams wrote:
> Ira Weiny wrote:
> [..]
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > index 3a66aadb4df0..86c84611a168 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -417,8 +417,44 @@ static void disable_aer(void *pdev)
> > > >  	pci_disable_pcie_error_reporting(pdev);
> > > >  }
> > > >  
> > > > +static void cxl_mem_free_event_buffer(void *buf)
> > > > +{
> > > > +	kvfree(buf);
> > > > +}
> > > > +
> > > > +/*
> > > > + * There is a single buffer for reading event logs from the mailbox.  All logs
> > > > + * share this buffer protected by the cxlds->event_log_lock.
> > > > + */
> > > > +static void cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
> > > > +{
> > > > +	struct cxl_get_event_payload *buf;
> > > > +
> > > > +	dev_dbg(cxlds->dev, "Allocating event buffer size %zu\n",
> > > > +		cxlds->payload_size);
> > > > +
> > > > +	buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> > > > +	if (WARN_ON_ONCE(!buf))
> > > 
> > > No, why is event init so special that it behaves differently than all
> > > the other init-time allocations this driver does?
> > 
> > Previous review agreed that a warn on once would be printed if this universal
> > buffer was not allocated.
> > 
> > > 
> > > > +		return;
> > > 
> > > return -ENOMEM;
> > > 
> > > > +
> > > > +	if (WARN_ON_ONCE(devm_add_action_or_reset(cxlds->dev,
> > > > +			 cxl_mem_free_event_buffer, buf)))
> > > > +		return;
> > > 
> > > ditto.
> > 
> > I'll change both of these with a dev_err() and bail during init.
> 
> No real need to dev_err() for a simple memory allocation faliure, but
> at least it is better than a WARN

Ok no error then.

> 
> > 
> > > 
> > > > +
> > > > +	cxlds->event.buf = buf;
> > > > +}
> > > > +
> > > > +static void cxl_clear_event_logs(struct cxl_dev_state *cxlds)
> > > > +{
> > > > +	/* Force read and clear of all logs */
> > > > +	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> > > > +	/* Ensure prior partial reads are handled, by starting over again */
> > > 
> > > What partial reads? cxl_mem_get_event_records() reads every log until
> > > each returns an empty result. Any remaining events after this returns
> > > are events that fired during the retrieval.
> > 
> > Jonathan was concerned that something could read part of the log and because of
> > the statefullness of the log processing this reading of the log could start in
> > the beginning.  Perhaps from a previous driver unload while reading?
> 
> The driver will not unload without completing any current executions of
> the event retrieval thread otherwise that's an irq shutdown bug.
> 
> > I guess I was also thinking the BIOS could leave things this way?  But I think
> > we should not be here if the BIOS was ever involved right?
> 
> If the OS has CXL Error control and all Event irqs are steered to the OS
> then the driver must be allowed to assume that it has exclusive control
> over event retrieval and clearing.
> 
> > > So I do not think cxl_clear_event_logs() needs to exist, just call
> > > cxl_mem_get_event_records(CXLDEV_EVENT_STATUS_ALL) once and that's it.
> > 
> > That was my inclination but Jonathan's comments got me thinking I was wrong.
> 
> Perhaps that was before we realized the recent CXL _OSC entanglement.

Yea that could have been.  I'm not clear on the order of the comments.

Ok this should be good to go.  Reworking the rest of the series.

Thanks for the review!
Ira
