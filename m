Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3729553E29
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 23:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355142AbiFUVss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 17:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356655AbiFUVse (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 17:48:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534C865C9;
        Tue, 21 Jun 2022 14:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655848113; x=1687384113;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sWFlCdseb80MsWUVDlWVDG3pUgtAsC1/GLQVHIApDhg=;
  b=m0PfBdESZdrkVEuIvzQzg/PXUdzy7bVckW67tYBJyUoZTHW/jPieLU3L
   IblfiJpVDrh51Spf5mtEv6jE2gnKNqTNFGkcIrFH2lbSVdgYEOfL6dWCG
   MikoxR5XX8Gg6j0aoWtYFuuIUVSRClKW6odywbAV8Xg7cBr72kiIC2HB2
   wvzOj1uNwIjQXxlmZyDPGFq2ZAy7R6Pbuxh/voFQpNHFCiy6KxqENBBun
   kTPmbA1jk4+Ky0xdegaoFiN96WPt/xqMX1GhUHiA6kSftvaIn2FVAC2KV
   9wPOZxcfFGgoz5oXmk5/zIfjNZnu/90ln4pBvzr0od0/R/ReXhgBMTA1o
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="280292178"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="280292178"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 14:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="715138830"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 21 Jun 2022 14:48:22 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 14:48:22 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 21 Jun 2022 14:48:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 21 Jun 2022 14:48:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 21 Jun 2022 14:48:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibaPPdxyepRhzcYdRKEZlX689WI3Y0oYTD8yGrRLoHpXr7E8V06faes2HgjyfB9aOJJFJv/pkTmedBOyVGCGnYv/sRp5aLplYMxHyWdYQVuhgeO0t4tRJx/ejCkDEKcPkgYuOMzti/8uVWuT2d2b4A200KwBp22uQAUEEZNv8GYVntYnZvTSbRfjnfZ7V2Ohcwk2xJ/Cqvth/J3qs/nI/Y5PUFnuD1AdzQJXGHNbiyAFk0724IJmRiDRlHbJRlW8VYwxTab80U5M+T2dwjHDc3JIWM4Rz9bUZ4lzJnRJSH5QLBfOFHAv47+jEC6arDlEUD5CPWfLfJln9ZB8Q360Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ob+/LfV7Rs8s5x2kyD53qcLWUvMXgpemqiV7blaMur4=;
 b=g2u5oepDIGdnBQDC0QpgYrSqub9jWmdAYthNPPR3V8QgJUvGsMPOn+ioAqJY2ju3vdFV1+O1wJOYJ/zEjrna+YQL+Pc7fP5ZHGqL9fpWN0EGH99GkruCP0J7qXn/O9sl7CeDPEonvHfRgTAhdCuEnbAL917Arp/Lbv/tdawXT3zOWDcVD0M4qdlrR+VSVe4P5AufSi/aTELwPVQA0eUFsqg9zJ7ikqXDSbDVCD5KcwhcMgae+7V8yxXrqZ06KHvYp9vhsxfNhmNUuEvbQau7xr/eoMZR5wRdMxAV0uU7UuQKY9ayqO4A34AjPlavXDVj17bnWEjnoso4Sgx+ev6gMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY4PR11MB1720.namprd11.prod.outlook.com
 (2603:10b6:903:2f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Tue, 21 Jun
 2022 21:48:14 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 21:48:13 +0000
Date:   Tue, 21 Jun 2022 14:48:11 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 5/8] cxl/port: Read CDAT table
Message-ID: <62b23c9b3726e_892072944d@dwillia2-xfh.notmuch>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-6-ira.weiny@intel.com>
 <62ad1fb69d742_8920729490@dwillia2-xfh.notmuch>
 <YrI0qQrvM7MzKeLy@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YrI0qQrvM7MzKeLy@iweiny-desk3>
X-ClientProxiedBy: MWHPR22CA0009.namprd22.prod.outlook.com
 (2603:10b6:300:ef::19) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eddf34f-6188-41b3-9144-08da53cfbdaf
X-MS-TrafficTypeDiagnostic: CY4PR11MB1720:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB17209FA19A01B80D9F24BF8FC6B39@CY4PR11MB1720.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+vAlNc+vvz7T3NW4gqn1JtWlQZd/Zsub8UWdE1R5cr0WJ/A+kNjNXY6r2G5NRI2UHtOPCK9imUrRUDxdKcmYAcvROR76YnuqAAdlP4x9aMEVQmnpDVZffA840yWh/deUwbqhNkGBTUViURfiI2/b2mho4k2Dg0pqHKQYaePZthsvrMNUrqfwjvv21JBTR4fv2tulRgU5rtC624TAFCidS50BUFpU/KyY6GXq6nkXBSZ9BUAIe2HcSU0sWEkeVEHlBnvS53Nw+7vBZrOcF/gFRkjwfOovVSreYv3NXOy89g/9g7lV7gTpAqA7/1vQoAZMHUyUPn6hUYedg4PbIz0cImsJUWktn9YLmTgQoU4Dnn7q5qdK22F3WhiUiT7ketLQX8LM+i/TdtCnN+shvOmnUAIsklIokmAtHcxu1pViYvY/xqdf6F7RO/NThVNPKWZcbBuYJOa3ct1qXOMr1H+W69CJtWBoRYcIyU/nFv6VUf+QZ8B2bkx5452lIAlfet7F/HELlOn8yr/SebA/Rwp9/WqejEuX2pW6IAgvyew0PhHmON+iBMV/OEWoJUIrnsvu8CMnc5I8KTu8B8iSbDgsSgbJCydSFGAqclUWyr1A0g9FLi30QA/zCQ9xx1PKaJbP3OniPXeuIQtZoDvv7ixgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(376002)(396003)(39860400002)(66476007)(66946007)(8676002)(2906002)(8936002)(110136005)(4326008)(5660300002)(6506007)(6486002)(478600001)(86362001)(9686003)(54906003)(316002)(26005)(6512007)(66556008)(41300700001)(83380400001)(186003)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B6fFJQNSOfY3M8RJ3nTt33naw1vEw5T1aZINSyxRP4qG+EHOjwx1YO84mJcp?=
 =?us-ascii?Q?O5Kgk6w3ufwvzzjRpXgqhRrbXkty12ofLQCYMOTuUzThv3iF2DvnLAiniC4g?=
 =?us-ascii?Q?NAJBwvc1hNQR6k6Qak+gYlcMvge7TWMU4XwHxaj2F2iWCivU22E+8/PB8RMM?=
 =?us-ascii?Q?/nCUloDCa46tiLcTlu4p7+dElA8q8GadMAtZwuJuIN3CXFIYXB7+ggNhc48R?=
 =?us-ascii?Q?wAGlAYSsH5I4tUZw5zUAQiLShjpFQ9TGHUZA18o8B2Jr6yie2e12ND9BIb93?=
 =?us-ascii?Q?E5xxEhrz9l1TYMZY6ybhx+hNC6RkUtXDTc3t5sFxqnbsXc5Q8gJshQ6eiOts?=
 =?us-ascii?Q?42Gk1For1PpJgJouSfAVy/KOhN7F/CLy7FNWq2ywahYJ/2YzFLIQFmCvSp6G?=
 =?us-ascii?Q?54Xv2SOKjjtVX8m1MZbQE1L5vuh6pXEF9VoZPJdUvwDI3RwJaI83pVM63sAD?=
 =?us-ascii?Q?jGPjsonFChsUkG4CJDYn1Ghh5X9UUaNhoDn+SeOYKgyfRj74Pew+cKZB9DTi?=
 =?us-ascii?Q?4cpogWTfdV6CcjYgIPkQYca7nC5jDYkfCVIHVFrQ7Qx2QfSvMX715C3oyyNn?=
 =?us-ascii?Q?Ltg6rtwF6u3ijI6vNUIJMWAtWkkanDVP8YuyC2P5rta1AzaNrsIRJoOx+bf5?=
 =?us-ascii?Q?WuKgdbXuBbI82oTmA0BKyO5whEv14S+gCoki8DNQTEcuoFi9m64pw1yUkkh2?=
 =?us-ascii?Q?+hXutXocCrgChtmx6g6/m57I4ZIOY+RRu7zPrHvxEFV/tQIb65wMbLLUfBco?=
 =?us-ascii?Q?TzS8GjTjgCOVoZNZkbUe/ZagO2OiCqqPDXrTCptxsJK39NQDmdzzUYF2xazo?=
 =?us-ascii?Q?YUfCGllBsKzMzZeWGImSX7saUZLvheY9SEbBGtnI+AQunI+GoDKG4+iY/d02?=
 =?us-ascii?Q?WA/Fger89QN5jEtLDleVSWuFgebjCcTwg+9DhPvU0/oZKwp7hE+6CO3IcIk4?=
 =?us-ascii?Q?dDUMXGPh06+k6c5ihoB+vVKLzCc9RO906GiwELYvz9OrOcvOUUCU/E2pfyHU?=
 =?us-ascii?Q?SDwdAsTQBfyjS+GW19kZMLY0ADgUBjYK86brUYvTV3dLQmhVqY6YzFGedZEf?=
 =?us-ascii?Q?QHk0Hy/BMWneQe1c29aeBbmVA4gPAHtw/Utn5A/n6axFjoZ8gclQlWwuzxvK?=
 =?us-ascii?Q?X8KYS2F/D6EU8kHiVOMT1+ltc6TqQTglOtePwPWgyf9a+ItVkl2usAciBjzh?=
 =?us-ascii?Q?gbxPoCzp9VfxmSVYKgszTm9g0BIOT/N5iZEhbDoq6TJnCee40VR8qVhkQkVB?=
 =?us-ascii?Q?Kp5/CUxZjuvPNCGwHLpEyqnzWE1LZOqxEZ6FJNQct4zAInePoj6gU88Gr3S3?=
 =?us-ascii?Q?CkUAMHZyLVlN67EqHlS+RDaard4+a0NWS8ArvgLWx5a5VnswfnVNLNaly8wa?=
 =?us-ascii?Q?HFkSsb7a1deJGNSNAaA6XL/UxisYkPK5Z4jB/AkppK78rbHcxcayAQEL2Vfl?=
 =?us-ascii?Q?Scqo7U6cAkM3DpzufGhzI5caIsDi5OTpG4hdetrTt8SSGTj428GlNRQHcb+u?=
 =?us-ascii?Q?fflj4medAovJPsBawHSSap9+FZp2kFGMGweaFlQTEplTMFKBmE8PShnPbbLt?=
 =?us-ascii?Q?h/Tb7AewX3vRLvd8mwQP6+VbUCZibXWC9acOuMe9Pt6Hs2bb0EZCCAO4Ais/?=
 =?us-ascii?Q?BWdGIpxtjuQNMH2e9yr4KzbSMLjTJ+ZiBXC7BHbeGX/UyWUQVSB9f/PtYx2K?=
 =?us-ascii?Q?0mv3oeHHYGodm5z1Rzr65RGy246AMhjSULTjq2E2dMYvXps7X5f/JIqje1F0?=
 =?us-ascii?Q?eJ8jWlj5cGr4SvaERiHufYOD3iMevUg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eddf34f-6188-41b3-9144-08da53cfbdaf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 21:48:13.3800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gT7fCBK70o8w4xAVNRlWrd+4PS09W9NKm4iwEaFjBQMotV9P/t5bpzt6FQ11ZPtu39e1f948n2AboISBA2D58HRQ1qCHb6aYCyrt1g91C8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1720
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

Ira Weiny wrote:
> On Fri, Jun 17, 2022 at 05:43:34PM -0700, Dan Williams wrote:
> > ira.weiny@ wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> 
> [snip]
> 
> > > +
> > > +/**
> > > + * read_cdat_data - Read the CDAT data on this port
> > > + * @port: Port to read data from
> > > + *
> > > + * This call will sleep waiting for responses from the DOE mailbox.
> > > + */
> > > +void read_cdat_data(struct cxl_port *port)
> > > +{
> > > +	static struct pci_doe_mb *cdat_mb;
> > > +	struct device *dev = &port->dev;
> > > +	struct device *uport = port->uport;
> > > +	size_t cdat_length;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * Ensure a reference on the underlying uport device which has the
> > > +	 * mailboxes in it
> > > +	 */
> > > +	get_device(uport);
> > 
> > I had written up a long description grumbling about "just in case"
> > acquistions of device references, but then I lost that draft.
> > 
> > So I'll do the shorter response, but give you more homework in the
> > process. How / Why is that get_device() needed? What are the guarantees that
> > ensure you that the last reference has not been dropped just before that
> > call? Hint: what context is this code running?
> 
> I'll check it out.  I suspect there is some reference on uport already taken
> such that if port is valid uport must be valid.

Right, this routine is called from cxl_port_probe() which holds the
device_lock() and prevents the port from being unregistered before it
has gone through device_release_driver(). The port was registered by the
driver for @uport i.e. cxl_mem. That driver is guaranteed to unregister
the port before it is unregistered itself.

As long as you know that the code path is within the lifespan of
cxl_port_probe() and cxl_port_remove() you are guaranteed to not need to
manage reference counts on the associated cxl_memdev.

> 
> > 
> > > +
> > > +	cdat_mb = find_cdat_mb(uport);
> > > +	if (!cdat_mb) {
> > > +		dev_dbg(dev, "No CDAT mailbox\n");
> > > +		goto out;
> > > +	}
> > > +
> > > +	if (cxl_cdat_get_length(dev, cdat_mb, &cdat_length)) {
> > > +		dev_dbg(dev, "No CDAT length\n");
> > > +		goto out;
> > > +	}
> > > +
> > > +	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> > > +	if (!port->cdat.table)
> > > +		goto out;
> > > +
> > > +	port->cdat.length = cdat_length;
> > > +	ret = cxl_cdat_read_table(dev, cdat_mb, &port->cdat);
> > > +	if (ret) {
> > > +		/* Don't leave table data allocated on error */
> > > +		devm_kfree(dev, port->cdat.table);
> > > +		port->cdat.table = NULL;
> > > +		port->cdat.length = 0;
> > > +		dev_err(dev, "CDAT data read error\n");
> > 
> > Rather than a chatty / ephemeral error message I think this wants some
> > indication in userspace, likely the 0-length CDAT binary attribute, so
> > that userspace can debug why the kernel is picking sub-optimal QTG ids
> > for newly provisioned CXL regions.
> 
> I thought we agreed that 0-length or CDAT query failure would result in no
> sysfs entry?

Oh, I forgot about that, but some new rationale below...

> 
> This message was to alert that a CDAT query was attempted but the read failed
> vs finding no mailbox with CDAT capabilities for example.

...right, but that's an error message buried in the kernel log. I was
hoping for something where tooling can query and say "oh, by the way,
the driver tried and failed to get CDAT from this device that claimed to
support CDAT, remedy that situation if you are seeing unexpected
performance / behavior".

> 
> [snip]
> 
> > >  
> > > +static ssize_t cdat_read(struct file *filp, struct kobject *kobj,
> > > +			 struct bin_attribute *bin_attr, char *buf,
> > > +			 loff_t offset, size_t count)
> > > +{
> > > +	struct device *dev = kobj_to_dev(kobj);
> > > +	struct cxl_port *port = to_cxl_port(dev);
> > > +
> > > +	if (!port->cdat.table)
> > > +		return 0;
> > > +
> > > +	return memory_read_from_buffer(buf, count, &offset,
> > > +				       port->cdat.table,
> > > +				       port->cdat.length);
> > > +}
> > > +
> > > +static BIN_ATTR_RO(cdat, 0);
> > 
> > This should be BIN_ATTR_ADMIN_RO(), see:
> > 
> > 3022c6a1b4b7 driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}
> 
> Are you suggesting I add BIN_ATTR_ADMIN_* macros?

Yes.

> 
> > 
> > > +
> > > +static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
> > > +					      struct bin_attribute *attr, int i)
> > > +{
> > > +	struct device *dev = kobj_to_dev(kobj);
> > > +	struct cxl_port *port = to_cxl_port(dev);
> > > +
> > > +	if ((attr == &bin_attr_cdat) && port->cdat.table)
> > > +		return 0400;
> > 
> > Per above change you only need to manage visibility and not permissions,
> 
> But the permissions indicate visibility (In the kdoc for struct
> attribute_group).
> 
> 
>  *              ...  Must
>  *              return 0 if a binary attribute is not visible. The returned
>  *              value will replace static permissions defined in
>  *              struct bin_attribute.
> 
> And the value returned overrides the mode.
> 
> fs/sysfs/group.c:
> 
> create_files()
> 
>  82                         if (grp->is_bin_visible) {
>  83                                 mode = grp->is_bin_visible(kobj, *bin_attr, i);
>  84                                 if (!mode)
>  85                                         continue;
>  86                         }
>  87 
>  88                         WARN(mode & ~(SYSFS_PREALLOC | 0664),
>  89                              "Attribute %s: Invalid permissions 0%o\n",
>  90                              (*bin_attr)->attr.name, mode);
>  91 
>  92                         mode &= SYSFS_PREALLOC | 0664;
> 
> 
> So I'm willing to add the macro but I'm not sure it is going to change anything
> in this case.

The change I was expecting is that with BIN_ATTR_ADMIN_RO() this
implementation changes from:

	if ((attr == &bin_attr_cdat) && port->cdat.table)
	         return 0400;

...to:

	if ((attr == &bin_attr_cdat) && port->cdat.table)
	         return attr->mode;

...i.e. this routine only modifies visibility, you do not also need it
to enforce the root-read-only permission change since that's already
statically defined at attribute creation time.

> I think to make those _ADMIN_ macros work with is_visible()
> create_files() needs to be changed.  :-/  I'm not sure if the addition of
> DEVICE_ATTR_ADMIN_{RO,RW} intended for is_visible() to be able to override the
> mode?

The intent was that one only needs to look in one place to read the
permission, and is_visible() is (mostly*) only left to change the mode to
0.

* changes from read-only to/from writable would still need is_visble()
to manipulate permissions, but you get the idea.
