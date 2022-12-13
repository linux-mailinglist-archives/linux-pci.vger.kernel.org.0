Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FCC64BC73
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 19:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiLMS5C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 13:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbiLMS46 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 13:56:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4341DDEC;
        Tue, 13 Dec 2022 10:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670957817; x=1702493817;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HVFP8cKwrd04jktuheWEl8Oe/xUhfxAQxML2oCtL9uU=;
  b=B7TLo6jxY1DoKGOovejdYDnJhD4Gls9KeeuVvJL6AfnaZZMF0GjgCIVV
   VuBQI7Ih+6MXFkZSC3LPSis0zddyPJVeqPVLAhWZxFpEzKeH44bEp7Y+G
   8UC2CFBt7gOWmugYWDldbSx/qf3jFhW0156fe2l+Uhy1Lun5nwcTFT0Ta
   NN3+xOeSFs4tOVHO+zjgm4a2JfBILlQlMFz3jdW7f856er956jX5FoFZp
   VW7oagkuVz/jq77fTinAmtp03zaIcZQjok7lYCS2MtiOFneoP8Ho80FGE
   2zxJbjEwOFVqRIDuRWXsPFJdH1mHas3pgEETvApUkaXpfhGNQ5oTqquco
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="297898457"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="297898457"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 10:56:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="598893801"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="598893801"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2022 10:56:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 10:56:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 10:56:52 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 10:56:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sd8Q+fRpzHtB4PyCLfF7GyrkEMelUBWn5KS0RnlHBu14cL58MVU1d0Jku7zHKG4INux1aOdsaybIDwstl8LkayfLelNYYFeXw3bZGM34c2qeEObChtXpZQqMKvEU3IA5aRT9mH4gCyqGsIMwUj6WcdHgInyw7p7WDz0uLH6Zn6ag6qGj+Ng1ZkZQ230cUjjy7/ekhD3Ma7BvKr/7kruqOFGSIhlAu9/ruSuvNhiZQ/ChXPjPz4U1XdxrdbtF6l7LnMWC4aVs4aoQCmWFGHMHYunH/il81U7y6qsDdX6nFBiCNWlRFXwR52e9vu3pLmAVUqEeX9kUHOy7ZGNFp60CkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kls8GoCn4pjY0cO0+PzibWMnThsbd19DGMj/2Fk0Q8=;
 b=irwKmUXh7qQmh4uBcu1rhvUQt0I1lx7dT5K7g8wXgoSKjNVeBQ2XWy3F+vruKEmAxRN1210LdGhOog9leqLpH+MhhSWnwhDLvoRl0KhxGQ9OyNCEvqQIeYqqe+fqsRSL5mhi+eM8L2ZSkn0DN35S4DvepMSWT1KyRZRV1SgKjJ/CBd/20dlC+Hr6O+OhdTnaCzb2/xwjw6RkQhSlbGMEvJHAA5EEvf64v2GIAwoWCtAHefjRFfrCYwwyOjZuFy1Ss5egrJCPrgGiuZd/IqOjWjFIkZodt/8F1HmDfoswWtePDUSmlPaoxOBPYhTyj/qw+MXlZ7ELXqdVoPz2D+zc1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6567.namprd11.prod.outlook.com (2603:10b6:806:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 18:56:48 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 18:56:48 +0000
Date:   Tue, 13 Dec 2022 10:56:43 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     johnny <johnny.li@montage-tech.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 2/9] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <Y5jK658xKJC3bLny@iweiny-mobl>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
 <20221212070627.1372402-3-ira.weiny@intel.com>
 <Y5ggXi88HancP2LZ@SR651>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y5ggXi88HancP2LZ@SR651>
X-ClientProxiedBy: BYAPR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:40::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d7db74-a917-4b25-b587-08dadd3bc994
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FHsaYH1tU1RjptI70RvPS8v1MRpYZKuSoxoBM1upIQ4M8d/+tMFElTxX1vMiyp0MfiQbewbFwiWLQ+YtXyRIybZCsfBu+9PJ0vBLTkSP6pn49XHeZITS2+ZGrdU5dIoZgLnKCvwfF7UM6WYPaLdZYBC9EQagNO5bL9cLmD8CdJZnMKkko9rJQ25nZLBwJc8UalUgqbx15eEJwSNBuqwBN0CAwURl2PknRR0071qMYOcYifkF29GloGvNdrKjPB81LB4gBSaQ0Lw8VLLqCIeVmQE/0usiittizWkwSH957p1itfI2GJhrqw8qW5CCY84WjjDMoJaakaflIjnqzODozwbM7rEJGDurIgVeETk+Ka8yWbCozUKjIVA/TWTtaqWfAALgl+MnXB1dr9O8ikLt+BVg6y/EyzVlyM+alT95y8MKxERMJgrSkExytTdMLpWDLl2T/O3m0R0J7g1ggTq5Er+HL649krugZZvTS93zZStc675rBgOycGLXwEcbpWAv/dqCOwZ0pZka1QJOtPj7FAHyiKfBaGqwfWQftEBBjTJvZpLBUOMSVMBMvt+tCyhnV7IlT4MPb/XtMBEYmv4zNIupaGhLELlufljhn8YXGYPPZ+b+qV3/dxepKKALEI5v3K+AkS++2yhLV+4x3imT0FxaF90HyYBOHPxLrfd9Ag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199015)(82960400001)(38100700002)(33716001)(9686003)(86362001)(316002)(8676002)(4326008)(6916009)(66946007)(478600001)(5660300002)(8936002)(41300700001)(2906002)(44832011)(66476007)(6512007)(966005)(6506007)(6486002)(26005)(54906003)(186003)(66556008)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TP7kCbyxrkSccXqGttWafJAUfOfiOz6njoDR4XSNpgINJvQEXOpEEScItNzD?=
 =?us-ascii?Q?r2tpjBeBkWjUUjY0gL4hpDI2f43h8ae4FTZo1DsuR3TQV1D1koMvNqlR6XWf?=
 =?us-ascii?Q?6TayAZRnJzQXXMnCP7XXmdw91BHA3LhGp9RkagUD05GR0WJ87vpZ7+5vxx69?=
 =?us-ascii?Q?LuWgKxp4HXJWKqGTGne/NGeJtOMetAnspxRxpAgtIRcmLPAl2yj+F9G7oap+?=
 =?us-ascii?Q?SIA9cHk24V46kSLkG67vb2uLhwS8HTuGjLnpMaclV8+ZjUjWpa745kt0/GHA?=
 =?us-ascii?Q?QeYOsoziU6YzTWAUGQbn1a+uO+D8gCxTAdSIkTCK9u5PWqMpwCb+sWeBEmz0?=
 =?us-ascii?Q?VB85r+5q8iIEv4CJMf7dbCYxp+OdEVK9Je08na029vVTcBOHhzRHakRGRqLr?=
 =?us-ascii?Q?sa/HXfLyNjXhqRErI/+Ag/jh493Z5p3i4lsPlrXLSJf8EGUKCE88wQpn+8ay?=
 =?us-ascii?Q?z8wd1xFFpiWf21m5lXPx2YAGVXJlWP3y8bJUbQ/4cNwl/kJkwzPDQ/TXJK+C?=
 =?us-ascii?Q?6jTJX1sXcDU/XLSEWs+S2YpqpBy1E2Ap3o2SqYCKzyp06uO1slMZMjzZR3Y/?=
 =?us-ascii?Q?9p4ooZkxOIfdabGqLZtKliql/vUtYSiToqSU2u0A0cc5cVRhndzpPyIpE+DB?=
 =?us-ascii?Q?q2Ji+l9+rLzoQmK9oCPzaxg6mIdpwIvsxpK8IQxxcsPibKC4LFkr3N8enUpL?=
 =?us-ascii?Q?tVoO7GZgAu1mKPd5TaQUzddhL3rgc5kJJwoNx7KQvw0AS0/ee5Ldn3h0yMal?=
 =?us-ascii?Q?+fSD5tBo6ic4Q6Qk3oGBmTi2QVgOHMEde4dym+0HArHOpsFIPxYtbCndzO/4?=
 =?us-ascii?Q?JMbiaMtUJ2N0rLx47/5Bvu/VCFvwmx+QMlCaHEVsB3Ev/mgfuRuQzXm0rves?=
 =?us-ascii?Q?A3Zvesndmkt8F3g2Kvr/gZEPb41Vb7lzDsEnuI8NcKXkC3YKYEHIvzqsuTYf?=
 =?us-ascii?Q?IqZUZxpgsfdlT5+GQ6WxNt9lTRHyu/Qr6/Eg560DNVz5ZwawV/9K2EC3dxoo?=
 =?us-ascii?Q?3fuTUDsZT3QggOO8jAiI82IT+rDscrniLjnQZOlTdq8sLotxaF5NvtUE0pSt?=
 =?us-ascii?Q?Et7jdfewvNBtlRV/5P/l6ader7QE0Qw1ifctUs6AbZK9MiKZmAFyRcoZUNnf?=
 =?us-ascii?Q?+7s5OXG6GTmGPvNbRtuzKHNsccM063oTeAzifxkaHgeh5IQub/fGY00iPq30?=
 =?us-ascii?Q?eNF2ggaloS0cOyTfaqKGf0m08XVWF6IwWLtwedJh0N/G/LqV/u3T0Axkqnje?=
 =?us-ascii?Q?Wi0l5UGWTnuXcOygrjsayz//3GvMz9IL1KoYpAN11Ijj0k2UOfycgBAQupAO?=
 =?us-ascii?Q?j+2kVVDG+262fCpBzW2TruYyynPl0QzIPPgPmGUdUEWBk29nOwIkJEtPHS6+?=
 =?us-ascii?Q?t3I1JsWbtWySPUpgq0Eng/vnNEcjlBzAjRq3e3KzFqmoXGOWKNEFolX2DUjD?=
 =?us-ascii?Q?b9pqWAC12CHOh7pY6dI6sAY4qtgHVO5e00Xb4vYu8899aQskMYTwFaTJRVZ5?=
 =?us-ascii?Q?aUETjuZRCGmtD3iqeiBFPfuz6kdM4K4bu9n+4yd7jWEZ83xLktITHJpFu9EI?=
 =?us-ascii?Q?imyKbgkQstpY2KXHaQlqrRCM0NIplJB2Bpet4A1U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d7db74-a917-4b25-b587-08dadd3bc994
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 18:56:48.2840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skgCOQ9Kpl8xe2aEnd9IZEUuXRRzBk3z0a4k38CyRVALlG2+gajfnyV6T6WIiNXRrE5ITo68CxtXXJ9ajr0F2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6567
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 13, 2022 at 02:49:02PM +0800, johnny wrote:
> On Sun, Dec 11, 2022 at 11:06:20PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 

[snip]

> > +
> > +#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> > +struct cxl_event_record_raw {
> > +	struct cxl_event_record_hdr hdr;
> > +	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
> > +} __packed;
> > +
> > +/*
> > + * Get Event Records output payload
> > + * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
> > + */
> > +#define CXL_GET_EVENT_FLAG_OVERFLOW		BIT(0)
> > +#define CXL_GET_EVENT_FLAG_MORE_RECORDS		BIT(1)
> I don't see any code consumes this more flag, is anything I miss?
> Device shall set this more flag when single output payload can not fit in all records

I should have removed this flag and put something in the cover letter.  I left
it in for completeness but you are correct it is unused.

We determined back in V1 that the more bit was useless in this particular
looping of Get Events Records.[1]

The net-net is that if the driver does not see the number of records go to 0 it
can't be sure it will get an interrupt for the next set of events.  Therefore
it loops until it sees the number of records go to 0.

Ira

[1] https://lore.kernel.org/all/Y4blpk%2FesXJMe79Y@iweiny-desk3/

> > +struct cxl_get_event_payload {
> > +	u8 flags;
> > +	u8 reserved1;
> > +	__le16 overflow_err_count;
> > +	__le64 first_overflow_timestamp;
> > +	__le64 last_overflow_timestamp;
> > +	__le16 record_count;
> > +	u8 reserved2[10];
> > +	struct cxl_event_record_raw records[];
> > +} __packed;
> > +
> > +/*
> > + * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
> > + */
> > +enum cxl_event_log_type {
> > +	CXL_EVENT_TYPE_INFO = 0x00,
> > +	CXL_EVENT_TYPE_WARN,
> > +	CXL_EVENT_TYPE_FAIL,
> > +	CXL_EVENT_TYPE_FATAL,
> > +	CXL_EVENT_TYPE_MAX
> > +};
> > +
> > +/*
> > + * Clear Event Records input payload
> > + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> > + */
> > +#define CXL_CLEAR_EVENT_MAX_HANDLES (0xff)
> > +struct cxl_mbox_clear_event_payload {
> > +	u8 event_log;		/* enum cxl_event_log_type */
> > +	u8 clear_flags;
> > +	u8 nr_recs;
> > +	u8 reserved[3];
> > +	__le16 handle[CXL_CLEAR_EVENT_MAX_HANDLES];
> > +} __packed;
> > +#define CXL_CLEAR_EVENT_LIMIT_HANDLES(payload_size)			\
> > +	(((payload_size) -						\
> > +		(sizeof(struct cxl_mbox_clear_event_payload) -		\
> > +		 (sizeof(__le16) * CXL_CLEAR_EVENT_MAX_HANDLES))) /	\
> > +		sizeof(__le16))
> > +
> >  struct cxl_mbox_get_partition_info {
> >  	__le64 active_volatile_cap;
> >  	__le64 active_persistent_cap;
> > @@ -441,6 +524,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
> >  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
> >  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> >  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> > +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
> >  #ifdef CONFIG_CXL_SUSPEND
> >  void cxl_mem_active_inc(void);
> >  void cxl_mem_active_dec(void);
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 3a66aadb4df0..a2d8382bc593 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -417,8 +417,37 @@ static void disable_aer(void *pdev)
> >  	pci_disable_pcie_error_reporting(pdev);
> >  }
> >  
> > +static void cxl_mem_free_event_buffer(void *buf)
> > +{
> > +	kvfree(buf);
> > +}
> > +
> > +/*
> > + * There is a single buffer for reading event logs from the mailbox.  All logs
> > + * share this buffer protected by the cxlds->event_log_lock.
> > + */
> > +static int cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
> > +{
> > +	struct cxl_get_event_payload *buf;
> > +
> > +	dev_dbg(cxlds->dev, "Allocating event buffer size %zu\n",
> > +		cxlds->payload_size);
> > +
> > +	buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	if (devm_add_action_or_reset(cxlds->dev, cxl_mem_free_event_buffer,
> > +				     buf))
> > +		return -ENOMEM;
> > +
> > +	cxlds->event.buf = buf;
> > +	return 0;
> > +}
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> > +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> >  	struct cxl_register_map map;
> >  	struct cxl_memdev *cxlmd;
> >  	struct cxl_dev_state *cxlds;
> > @@ -494,6 +523,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> >  
> > +	rc = cxl_mem_alloc_event_buf(cxlds);
> > +	if (rc)
> > +		return rc;
> > +
> > +	/*
> > +	 * When BIOS maintains CXL error reporting control, it will process
> > +	 * event records.  Only one agent can do so.
> > +	 */
> > +	if (host_bridge->native_cxl_error)
> > +		cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> > +
> >  	if (cxlds->regs.ras) {
> >  		pci_enable_pcie_error_reporting(pdev);
> >  		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
> > -- 
> > 2.37.2
> > 
> > 
> 
