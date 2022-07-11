Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011E256D2D3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 04:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiGKCCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 22:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGKCCf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 22:02:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628B11837C;
        Sun, 10 Jul 2022 19:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657504950; x=1689040950;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W8RZjF7YISkvMRQY9nIvw5QicSHfAad76SG62mM/IhA=;
  b=e8yH+bKdtGsW9nq07D8MNp+e+Iwla9e+d4/hC+WCJEbRzASUYaC5Zmq1
   SIj8UE58pvxRQ0dDQ43QCKBc9fgpnIpJl+y6k3X0eB8eXpH+Ndp1WRlnX
   4xaq6VU/u/I/bpPysQ3/j+sFKX5T+ugB3+oDc5LfH/0TMicPHNcFVysaA
   CtIU7iSk5klEoUAXN4NWdIWs3/V/tHlx7FeLpDsw/7gkLNsblqk76VozL
   7tZfsUW08AhhT12AxhUIT+wyp6AlOR+vWGtUXtxUAh/Ra/jJjBhMOVtiX
   0adB3q5d6OTH2XxTW4zI/hQ9wMbhadqYI5W2oAz3Rmej0QmdYVOBMXPwD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="284581069"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="284581069"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 19:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="598885900"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jul 2022 19:02:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 19:02:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 19:02:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 19:02:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTXqi5iRjvjW4rpYgpqpjd3UEb128FvRtseaLlcTJPGiZKWPg22SXSDzcaKda8hqj/2j2WO1s5q8pf6yI7/hq3QBLZpOtEZRa0Ai418yh94nEBLwFSnp5L7IoOJPbX56xYHr96P+8SQ18e2/csyLSP4jssvZZTMSorthd+pvnNZfLoDg2QC9dzpHuDB4sE99Qr4yT2AU6j226i7Med2JGB4aiHo3lZBZXnEQB5bE6m4pq0mgDzBRLAy6GTu7GnsKYL6qVF+yEyPEt26AJIHeG3QhbnvqewwXzQXEqsBkQ9N5zNfw6go/LkpWuzKblWf8FMHvLKmcLqAp4/06g8UwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE3XcEshfFKiPRBfO2CXlzD0hJBsxQh0eLOEaoVDALg=;
 b=Agp7e1ay5TGJ1XfV2CCa2qbDBAfKAPD7YQrM7y0TrzYEvXJOPglB7h1RJv7kzxjq6EfVObNts1P1X2a711Ueb3i8L/wVPoSVLjVmKBwH97vYyjotlCGsbTN9mKejST6Z3+EbpIe3yhQd9Ij56DdrF+AJNivt65tblG+CWofGclsqfkuMhQWoHvsNYf6mpTMlvXj5byUHwSWxQu15K08VOp0Q+fw9yoPHkx/K0C+xQk3CKHcJBBdOuLCyECpJdr/WHlr42DzdH6u+jAlYGtWgjOC8y5KD3otXtkBAgwiqYq9qVtsPpAxfbLbirMOwlzCRYMbfZ0RnOE02dtlrAGogzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH0PR11MB5394.namprd11.prod.outlook.com
 (2603:10b6:610:b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 02:02:26 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Mon, 11 Jul
 2022 02:02:26 +0000
Date:   Sun, 10 Jul 2022 19:02:24 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 40/46] cxl/region: Attach endpoint decoders
Message-ID: <62cb84b0c2298_35351629442@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-15-dan.j.williams@intel.com>
 <20220630173437.0000604d@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630173437.0000604d@Huawei.com>
X-ClientProxiedBy: MW2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:907::34)
 To MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20031e39-1396-43ba-802a-08da62e166fd
X-MS-TrafficTypeDiagnostic: CH0PR11MB5394:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDpeAL12NO9FLWLVn82Gmcp0YONq+ALvldc+pN3ebByFr/JsP2CgYrn3igTwnl6LES7UJjxAeskgXmojreLKv0MADccIES5KJOoCeFzbuoNOjBJMo/xyFnG+x4nEO8B/2ac4QGL8dEqihPRsTYZ7rE4ZNxM076gYjNKunIWr3psthmwxDJniR/3OpN2AGNNiiGa346RNlpQfJj1TekCfQc6P8nChP/RypsZKEhG++NGMfyt0877OE3Z5GUyVE3xgyLgXozKAEM1QmZj35wg6OxSfwK9WolsqGAfb6DTV8G7Yo3910jDKCu3wZTUABugBWJXj6YqSIijvgWlNriUdYjWgkL0pcuE+w9AuKP4pq2s+xiVbSM82g+Em/MLTViI5cmPE9W/Z69/BGA/Emqbwd4FIHFXVsJD3/Ly7FGRdJgRL05R92Eeqe2lb93vDTMWvTKA1l5+Hs5Ic2+OMfhSmimqPwsYBlxDqfvvc4n6xNmeqL+/nIk2AgErehD6V1Na/mppVqg4R/O9QMHkzS5kMdQkjnuTh2uK+W6Of5ibY79N7Qbyk+H9+5YOLkwYCtiyuxS9Wvw61rPsHkDbE3cb7G0iyaxFlljqOWwisMMP6eji8ApyWp8CyC2LqIbAlDVgT4mju7mTlvGRLNgUfyklLJv/A5WgC19W+5H2PgoYV67WRjSW5qASq2JY0mnZFOyg6mD7QM91X+PeHiICEGOnbjeYxZwLwwlhhDDhlLJwyV3jMgwaqkJIPVSZax/rjgjmHW5T06xdZnhdEFgXAvxcNAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(39860400002)(366004)(136003)(110136005)(6486002)(478600001)(86362001)(38100700002)(66476007)(41300700001)(6506007)(4326008)(8676002)(66556008)(66946007)(316002)(186003)(6512007)(9686003)(26005)(8936002)(5660300002)(2906002)(83380400001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8I0rnbkL6UpSEdCC4LRam9nx845MGYL/rQFNtS8Z8dZXdtgFvrTTqlK9RZTH?=
 =?us-ascii?Q?q1TNntMSikWsN4FpWMwLjs1xmDbBeLkwY+PK9l3LmC9IYjXPqWvUq9+R8hxz?=
 =?us-ascii?Q?c2CoJd2kYVyuq4PuH1fbZ0rFFJnS5gOf93lCQftP1zBEIOGyJIWxno+M9w5P?=
 =?us-ascii?Q?I7sn1fB9lDxoMrlqW7BEZYYnnrud/Xehv2Km5piUxAZfAp0RjwW5Bx/gNVkE?=
 =?us-ascii?Q?cmb5zSG4biaAfOAl1wQ5oEFJ97azFvqvu214ij4QmDvFT0N0qgcMAf+wL//G?=
 =?us-ascii?Q?bogUk0+QDrWJ4aphsRkKZAY2DNHWrrNRbPWUoE5LzLG3P/E8hPy2Yb4t9L7E?=
 =?us-ascii?Q?IJzCru2JCWU1bVR2ECfdSyoHET1MqzfZSe5A5UWgxAOH17DWXjPdCJWkOClI?=
 =?us-ascii?Q?R28pTbZBpH3t1nmI3H6tCGZ9rCh06exKaFkO3SCgSrsUz2m5RFZ//U/0RXKB?=
 =?us-ascii?Q?IxVMX7Iz+fkg83AigRgh7nKM1nINl2zwhXfa2UolHP5n/yLyw5FXuWscg8Pm?=
 =?us-ascii?Q?/AOS9wsAv3C/YVrUqyhtfiWS6Jo81zKPOZTpZwlUbE3whFQ9OBg2XULsRd26?=
 =?us-ascii?Q?3ngkk7zyVopM4X5RFIglYV+xkAnYeu3oR4uewUxX2y0w+c0EegjYXAS65Ccm?=
 =?us-ascii?Q?aDOVvOQFYqrFfxjDe1JLbbw9EiDe6f/JZdaQU6HJi7eaC2MoK9cpkOYN9Nvb?=
 =?us-ascii?Q?+AAfkKPAuh0P7OR5HbXiUr/zFDJ8xylCcX8qso5Q6EwBO7b0Q/M+WvAlRaGW?=
 =?us-ascii?Q?ObzvJxA05zhvctIuFWjMBcMM23Nn9A0rLqsrbFPiK55o22T1Z17NXtqiTQiv?=
 =?us-ascii?Q?wA9f0Y1bJ1MSRtfSMLeqd/ycXDCzjQCjE5GVtw4UdM87OdX9wOGNg+vI/Opu?=
 =?us-ascii?Q?4I3XkumNwrfJYgFt9CdohQtDfryv8uexbdadd3ZfmwL+rbaUok9tGT6d6W+S?=
 =?us-ascii?Q?m0SU/uNFvXzi3YV2YhxIMhImnKoM6S/JHqxeLSsEFnJIr/TI5Kd7V/eA1aOU?=
 =?us-ascii?Q?UsjZjAAeFGaGzzkNj1IFKD6l+4zAsX8f6ch/Ly093G5CeLLPy3t8AE4sfPfP?=
 =?us-ascii?Q?BHGvN7o7XuNS3oZu0NMTeF+1+EaagNuhs9RV9FGUpuTyuGw64nIJ5b94Qyst?=
 =?us-ascii?Q?/6bzSPl6g7cacn7piTla6YsWCNUza8OR/F5LPYJf47BqKdDUWFjGzCAZU2ia?=
 =?us-ascii?Q?kFfIaafL41YCqV8/jkUpwSguAPg8vb6NfsPzWNr7UwsJb3n4OpPqQH/r6j51?=
 =?us-ascii?Q?wHIe3q0TCfeGMGq7TidxvicMFkZaGfSYW5ZtHBBk++KzVAjmy25YUS0OpIJ6?=
 =?us-ascii?Q?phEjEYlD7UudfGDR1Pyt3Oh+RneIckR3/DJ5OsfZjQvrpSOZO0i+a9Ju0Ba9?=
 =?us-ascii?Q?1pBVL8QkldBy8ZwVHb/viRFbdFQs2iKdWMV8Y9howo0qgSzGOrBHy2JyqGlq?=
 =?us-ascii?Q?3S9ayuzjTmlFLZFfaVdgFUNu0Bpz2n2NaoCw+hwQmXeJ7iJJ0pLRmtV6uyQx?=
 =?us-ascii?Q?cEvviI8HUrRi/+pLqM+b+0UM12nQtucGKV9Hm4Zh+24p5l+IC1JXVRTK7slc?=
 =?us-ascii?Q?MHM9VtORjTZVuOAT3RfMPt4Z4GWKBsQLrnfopZfCqXpoZV/OECcOBo4OetWh?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20031e39-1396-43ba-802a-08da62e166fd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 02:02:26.4368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vtpgu9FAAW7ti6fKfFqcVJJ9s3IkQaUAhFmcsoY/z0ZolmzMMkk7ZHsJpAhdNZ8nrBydGY1MR6Bh28ADAEiPo7v24wiXjSjGxHYP7cbEzYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5394
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
> On Thu, 23 Jun 2022 21:19:44 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > CXL regions (interleave sets) are made up of a set of memory devices
> > where each device maps a portion of the interleave with one of its
> > decoders (see CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure).
> > As endpoint decoders are identified by a provisioning tool they can be
> > added to a region provided the region interleave properties are set
> > (way, granularity, HPA) and DPA has been assigned to the decoder.
> > 
> > The attach event triggers several validation checks, for example:
> > - is the DPA sized appropriately for the region
> > - is the decoder reachable via the host-bridges identified by the
> >   region's root decoder
> > - is the device already active in a different region position slot
> > - are there already regions with a higher HPA active on a given port
> >   (per CXL 2.0 8.2.5.12.20 Committing Decoder Programming)
> > 
> > ...and the attach event affords an opportunity to collect data and
> > resources relevant to later programming the target lists in switch
> > decoders, for example:
> > - allocate a decoder at each cxl_port in the decode chain
> > - for a given switch port, how many the region's endpoints are hosted
> >   through the port
> > - how many unique targets (next hops) does a port need to map to reach
> >   those endpoints
> > 
> > The act of reconciling this information and deploying it to the decoder
> > configuration is saved for a follow-on patch.
> > 
> > Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/core.h   |   7 +
> >  drivers/cxl/core/port.c   |  10 +-
> >  drivers/cxl/core/region.c | 338 +++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/cxl.h         |  20 +++
> >  drivers/cxl/cxlmem.h      |   5 +
> >  5 files changed, 372 insertions(+), 8 deletions(-)
> > 
> 
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 4830365f3857..65bf84abad57 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -428,6 +428,254 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
> >  	return rc;
> >  }
> >  
> 
> > +
> > +static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
> > +					       struct cxl_region *cxlr)
> > +{
> > +	struct cxl_region_ref *cxl_rr;
> > +
> > +	cxl_rr = kzalloc(sizeof(*cxl_rr), GFP_KERNEL);
> > +	if (!cxl_rr)
> > +		return NULL;
> > +	cxl_rr->port = port;
> > +	cxl_rr->region = cxlr;
> > +	xa_init(&cxl_rr->endpoints);
> > +	return cxl_rr;
> > +}
> > +
> > +static void free_region_ref(struct cxl_region_ref *cxl_rr)
> > +{
> > +	struct cxl_port *port = cxl_rr->port;
> > +	struct cxl_region *cxlr = cxl_rr->region;
> > +	struct cxl_decoder *cxld = cxl_rr->decoder;
> > +
> > +	dev_WARN_ONCE(&cxlr->dev, cxld->region != cxlr, "region mismatch\n");
> > +	if (cxld->region == cxlr) {
> > +		cxld->region = NULL;
> > +		put_device(&cxlr->dev);
> > +	}
> > +
> > +	xa_erase(&port->regions, (unsigned long)cxlr);
> 
> Why do we have things in a free_ function that aren't simply removing things
> created in the alloc()?  I'd kind of expect this to be in a cxl_rr_del() or similar.

Fixed it the other way by just open-coding cxl_rr_add() into
alloc_region_ref(). There was no good reason to have them as separate
steps.

> 
> > +	xa_destroy(&cxl_rr->endpoints);
> > +	kfree(cxl_rr);
> > +}
> > +
> > +static int cxl_rr_add(struct cxl_region_ref *cxl_rr)
> > +{
> > +	struct cxl_port *port = cxl_rr->port;
> > +	struct cxl_region *cxlr = cxl_rr->region;
> > +
> > +	return xa_insert(&port->regions, (unsigned long)cxlr, cxl_rr,
> > +			 GFP_KERNEL);
> > +}
> > +
> > +static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
> > +			 struct cxl_endpoint_decoder *cxled)
> > +{
> > +	int rc;
> > +	struct cxl_port *port = cxl_rr->port;
> > +	struct cxl_region *cxlr = cxl_rr->region;
> > +	struct cxl_decoder *cxld = cxl_rr->decoder;
> > +	struct cxl_ep *ep = cxl_ep_load(port, cxled_to_memdev(cxled));
> > +
> > +	rc = xa_insert(&cxl_rr->endpoints, (unsigned long)cxled, ep,
> > +			 GFP_KERNEL);
> > +	if (rc)
> > +		return rc;
> > +	cxl_rr->nr_eps++;
> > +
> > +	if (!cxld->region) {
> > +		cxld->region = cxlr;
> > +		get_device(&cxlr->dev);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_port_attach_region(struct cxl_port *port,
> > +				  struct cxl_region *cxlr,
> > +				  struct cxl_endpoint_decoder *cxled, int pos)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> > +	struct cxl_region_ref *cxl_rr = NULL, *iter;
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	struct cxl_decoder *cxld = NULL;
> > +	unsigned long index;
> > +	int rc = -EBUSY;
> > +
> > +	lockdep_assert_held_write(&cxl_region_rwsem);
> 
> This function is complex enough that maybe it would benefit from
> some saying what each part is doing.

...added a kdoc block:

/**
 * cxl_port_attach_region() - track a region's interest in a port by endpoint
 * @port: port to add a new region reference 'struct cxl_region_ref'
 * @cxlr: region to attach to @port
 * @cxled: endpoint decoder used to create or further pin a region reference
 * @pos: interleave position of @cxled in @cxlr
 *
 * The attach event is an opportunity to validate CXL decode setup
 * constraints and record metadata needed for programming HDM decoders,
 * in particular decoder target lists.
 *
 * The steps are:
 * - validate that there are no other regions with a higher HPA already
 *   associated with @port
 * - establish a region reference if one is not already present
 *   - additionally allocate a decoder instance that will host @cxlr on
 *     @port
 * - pin the region reference by the endpoint
 * - account for how many entries in @port's target list are needed to
 *   cover all of the added endpoints.
 */

> 
> > +
> > +	xa_for_each(&port->regions, index, iter) {
> > +		struct cxl_region_params *ip = &iter->region->params;
> > +
> > +		if (iter->region == cxlr)
> > +			cxl_rr = iter;
> > +		if (ip->res->start > p->res->start) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s: HPA order violation %s:%pr vs %pr\n",
> > +				dev_name(&port->dev),
> > +				dev_name(&iter->region->dev), ip->res, p->res);
> > +			return -EBUSY;
> > +		}
> > +	}
> > +
> > +	if (cxl_rr) {
> > +		struct cxl_ep *ep_iter;
> > +		int found = 0;
> > +
> > +		cxld = cxl_rr->decoder;
> > +		xa_for_each(&cxl_rr->endpoints, index, ep_iter) {
> > +			if (ep_iter == ep)
> > +				continue;
> > +			if (ep_iter->next == ep->next) {
> > +				found++;
> > +				break;
> > +			}
> > +		}
> > +
> > +		/*
> > +		 * If this is a new target or if this port is direct connected
> > +		 * to this endpoint then add to the target count.
> > +		 */
> > +		if (!found || !ep->next)
> > +			cxl_rr->nr_targets++;
> > +	} else {
> > +		cxl_rr = alloc_region_ref(port, cxlr);
> > +		if (!cxl_rr) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s: failed to allocate region reference\n",
> > +				dev_name(&port->dev));
> > +			return -ENOMEM;
> > +		}
> > +		rc = cxl_rr_add(cxl_rr);
> > +		if (rc) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s: failed to track region reference\n",
> > +				dev_name(&port->dev));
> > +			kfree(cxl_rr);
> > +			return rc;
> > +		}
> > +	}
> > +
> > +	if (!cxld) {
> > +		if (port == cxled_to_port(cxled))
> > +			cxld = &cxled->cxld;
> > +		else
> > +			cxld = cxl_region_find_decoder(port, cxlr);
> > +		if (!cxld) {
> > +			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> > +				dev_name(&port->dev));
> > +			goto out_erase;
> > +		}
> > +
> > +		if (cxld->region) {
> > +			dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
> > +				dev_name(&port->dev), dev_name(&cxld->dev),
> > +				dev_name(&cxld->region->dev));
> > +			rc = -EBUSY;
> > +			goto out_erase;
> > +		}
> > +
> > +		cxl_rr->decoder = cxld;
> > +	}
> > +
> > +	rc = cxl_rr_ep_add(cxl_rr, cxled);
> > +	if (rc) {
> > +		dev_dbg(&cxlr->dev,
> > +			"%s: failed to track endpoint %s:%s reference\n",
> > +			dev_name(&port->dev), dev_name(&cxlmd->dev),
> > +			dev_name(&cxld->dev));
> > +		goto out_erase;
> > +	}
> > +
> > +	return 0;
> > +out_erase:
> > +	if (cxl_rr->nr_eps == 0)
> > +		free_region_ref(cxl_rr);
> > +	return rc;
> > +}
> > +
> 
> >  
> >  static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
> >  {
> > +	struct cxl_port *iter, *ep_port = cxled_to_port(cxled);
> >  	struct cxl_region *cxlr = cxled->cxld.region;
> >  	struct cxl_region_params *p;
> >  
> > @@ -481,6 +811,10 @@ static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
> >  	p = &cxlr->params;
> >  	get_device(&cxlr->dev);
> >  
> > +	for (iter = ep_port; !is_cxl_root(iter);
> > +	     iter = to_cxl_port(iter->dev.parent))
> > +		cxl_port_detach_region(iter, cxlr, cxled);
> > +
> >  	if (cxled->pos < 0 || cxled->pos >= p->interleave_ways ||
> >  	    p->targets[cxled->pos] != cxled) {
> >  		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > @@ -491,6 +825,8 @@ static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
> >  		goto out;
> >  	}
> >  
> > +	if (p->state == CXL_CONFIG_ACTIVE)
> 
> I 'think' the state is either CXL_CONFIG_ACTIVE or CXL_CONFIG_INTERLEAVE_ACTIVE,
> so you could set this unconditionally.  A comment here on permissible
> states would be useful for future reference.

cxl_region_detach() should not care if the region state is idle. Not
that it will happen in the current code, but the only expectation is
that if the region is active and a endpoint departs it must be
downgraded in config state. CXL_CONFIG_IDLE is permissible, although not
expected. I do not think a comment is needed if the "if (p->state ==
CXL_CONFIG_ACTIVE)" check stays.

> 
> > +		p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
> >  	p->targets[cxled->pos] = NULL;
> >  	p->nr_targets--;
> 
> 


