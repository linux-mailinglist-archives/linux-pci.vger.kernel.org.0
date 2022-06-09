Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0F454409C
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 02:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiFIAeg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 20:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiFIAef (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 20:34:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E491E0FF;
        Wed,  8 Jun 2022 17:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654734873; x=1686270873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KKTJkdP9GR4VagUehpxiKYyuJdUsDliTq2Of5wT+/HA=;
  b=h7q28zkYMiFflA5y+/twDYmwLRCk56ntuMtRFsJdMsTYJMRu0+ikqp0V
   y5ChQDetX03dOOA46TrCS9NCPQOFtjG+ssTs/x06V1fjpRTLBCCyX0M9P
   y9CPefc7BJQp4Ps4SvDa+36Lembbo3fVPa+xQIhyc2sS/bETsmLoKni4O
   BMJ/92ViG+1ZBpGDbyX6MGgJ/0Ld11Vsz8pN9KhhWCtASuLoJwYfP5ee+
   pOaK5Ls0DQoVcp8xnNG3Usnqxp4OFHxmrFJuTO3eYYf2fVivvcNglA4Cf
   tfxzQa8585mL9KYVTvzjOMWopCZrNyUsdyHZYlFmKuZQ6dvh1599XQmB9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="341189293"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="341189293"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 17:34:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="724139661"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jun 2022 17:34:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 17:34:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 8 Jun 2022 17:34:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 8 Jun 2022 17:34:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2oyn2fJItjYyoBbTrJjBdXdLQC8SYAwaeUiWcTqnW99U5eIlV/TUqaleuVeZ4Eku6BySiSeNxV9lagLak4cM++vplLWzR2WpQsfFU5D+IczIVgMt+1VpwuK9sQa03Nf9Kj0EtboCZBNDdAZAWS6G+PDh1qryifDwGF0shqerUm1D3csYBElVqoBdFzLbRZ5z7ylb4I49fqXP7TeQHaxU8121CAsu3tewJZzp6dgnUd/wmcRlVXtpctgk2JGKQNmILVNWcsNcXg3OE9id8VJ6sQ1fVjzKn377cydXmp97/uW0xlzxVdSOGXAWWgZyfvbtzx4AbZR2FHJjIVmWw8HWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1SIg8hyaeai3KhS7oqVN/Y/dmMowMXXSjrHrtg9gD0=;
 b=NYHGXS1mJBNkyCSyD0uIAkm0ZSrP8JHWprqGr8kltWv26Ipnx8Ziand9OxJG6TBJArs37TcCA5NdzSq27B69lux3D8c+2ZgFNnfg0AUO8OTyaVOpMZw0qQ/oPOvWW9PvhJMhl/2xfJSQUvy6l75w6pKN2uQQrGbDLHie2npulFxhdIpQnp3m3QlGrJ39DcwJeqdE9zuFSI4+YleuagLmgJiDNzhP9zTu68lpwhmBN5RwnG3bGdyDdOw+9blA0wS6BDZCIfo3rsl3WI8hMwKI7WmOB8Uc5TCjR8QG3sRMrSaQgmpMSrLwWFjlrjZjjaiyFsIIKBgCKu1rPXsimurWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BN6PR1101MB2084.namprd11.prod.outlook.com (2603:10b6:405:50::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 00:34:30 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%4]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 00:34:30 +0000
Date:   Wed, 8 Jun 2022 17:34:24 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Widawsky <bwidawsk@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V10 9/9] cxl/port: Parse out DSMAS data from CDAT table
Message-ID: <YqFAEHdq70u5vtk4@iweiny-desk3>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
 <20220605005049.2155874-10-ira.weiny@intel.com>
 <20220606193220.aw7ouwtop7lo2gpc@bwidawsk-mobl5>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220606193220.aw7ouwtop7lo2gpc@bwidawsk-mobl5>
X-ClientProxiedBy: MWHPR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:300:ed::29) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae81a975-8c15-430e-23df-08da49afd0f6
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2084:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR1101MB208490344735A924844D44A2F7A79@BN6PR1101MB2084.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTuHGui59LdfA/O8cvJEa65OjkIk/a9pwGNXxEAQVS3B58Ps2+5OeiDyR4F2K3raTr4YcAb3GdgD9K/Jg1VPQeW2dVnlnwtYGPntrbBCfrtHgo0AQhRvyixwPhh0z2/VZbLzbZBPv8O/y5xkqbLodRXArFJNSXFO8akEPNnxcQjD+QKT9K80QhF2hyl38Wx9Y5HvaZamH4taYhsaeYO0a0RcwiCbI2UDUSpIjqUt+eGI+noqPs0Qs6AVlOUVZd94Pb6sEWrbEEB+z9ZaPOnrK24d7rRpypIEcoAai5/pYXua3uZKhkJE+w1kmM8LFbAwW0lCTOj/rpVX3gwABARpV1jzGADs7ZgQ+7wI5x1Fjx2msJ7d7jPWavt66RhivTozH6uzWeep3sHGRXjSCJFOitFsUOjYSSycAcjXzADlpZWamauCKB9ZSvVIrCNcaiZkCKQsnmwZf8ML3uP+Fh/aTZHLUFw3NfTZLu9wj5CQBNYxnoZk9pTCudm/DwenxuarPh4a5FrEtBCvIZYdkkZ2oYLj3sMRihZU6uFw1ZNDMWFqgpB2l2mBdlWi0EsoRVj4Xs5DZPEV+99XpHbOrQPNXUAffg3VvTybHp/X3bzvJ8MR8ZkVTy4Y6gzWxgZ0zaHnWj1XqeA8iZPo4iZok4b0Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(8936002)(86362001)(38100700002)(82960400001)(5660300002)(508600001)(2906002)(6486002)(316002)(44832011)(4326008)(66476007)(186003)(8676002)(66556008)(66946007)(6666004)(83380400001)(53546011)(6506007)(6512007)(26005)(9686003)(6916009)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L3f0GNNX1e519/XMLzz+TnL3dmB7fCQOe25aKdnt5SOFeqKbzdcIPYWFhOd7?=
 =?us-ascii?Q?BPQ6s3A6Tcbfezc6e85iHPS8tBREtvfV6jdTg2havYgbh7gjP4mAnlMqI0QC?=
 =?us-ascii?Q?WWBIYfVYqjCG6SedtzvLeKlkeWS4uMJwDzYjIZo/xUEv5MVN4Dma6qy1U96y?=
 =?us-ascii?Q?ap48/byrSRzffagbYyixsVCYll++i0zx3jZAAQKE/bo8D5YUXP3Ir4yz1AG/?=
 =?us-ascii?Q?HU2J1sFkHB+p7PbzXOhUF5qvl6bU6NyxRdvMo1EIYGvPlJ+gToOXoblwm9yd?=
 =?us-ascii?Q?9vTJrtU49/pYmJe+wX35CwpVeeePE+lp3AadGkigFwLIU+XBe0ZrVPMHLBax?=
 =?us-ascii?Q?g3juKRFv8Bx3cK7XTq6fNWvYMG5IAOy83UFmV5BV1d43lCnhx2BxONXMxDOq?=
 =?us-ascii?Q?/F120WG09PBsGZjMwg32b044Rxju7zn4ut+RMyX9TnuwSHSqZy/hG8CIfeF2?=
 =?us-ascii?Q?3Q8tahtHinLjFh+DKgwl5de/8d9OGZKuK98GbHg0h96mCcogiL5c4CxqCSVo?=
 =?us-ascii?Q?e2Mgvk+RnLaAmRXuaVSV9t8ORg/UmlilKN3X43g+0ZDAlqE4KnpEnH6D1ASO?=
 =?us-ascii?Q?CBBR07wCwB6N1qZjpRJWCJm8LbGbbrahoNqb8zTb1NsUsviHO5foX4ISY5H9?=
 =?us-ascii?Q?KypV/hvDIubfFKzDO0bi6oCo1GNHNQyIlLs2prghPLCBJ9ohT+Y6w537CPFq?=
 =?us-ascii?Q?U7KZQ0OiPqNehNYw7tPICBuG7RsVnTcua+JqTm/JLFct4Wh2CZ34utrUYgMN?=
 =?us-ascii?Q?lKUNwTgKqaSIdUtzEU5TTlU9gKs2sksRQL+ki9B+qQcbMRvaD/bEeGjDIuYm?=
 =?us-ascii?Q?oZuZ19pZ0Uzyktdi//vyaYHtWrV1/G0XLL7YoiNS4VLs7szIAtxA96+6h9n5?=
 =?us-ascii?Q?oCazgGWESYD6D9DPi7OCKDkXbZj+H43E/a9awS7vA9C9FTv7d3RMjTPCxY+f?=
 =?us-ascii?Q?3tOEz0YNeVWyIu6pmjGLBQ3FXFfCOGK96KeYWiLNnU7w6KBknNOWec3p+RXz?=
 =?us-ascii?Q?yIPD0pe8bNOdr/nn740MOQkTMnk30stF0Bfrpc3bdsFqIeconG60sTr8swB7?=
 =?us-ascii?Q?zjx8F6s5dulviLVfFT9F+8jqeModxzzXDxbJM8Xhi6e0i+9iX11Mhby6e1Ul?=
 =?us-ascii?Q?3MWCNJEirWuAHrylNQyoJ7d2KguiEJz2k/uRfm0TFfO5rpGH0va4HttXmlWO?=
 =?us-ascii?Q?ztKfoEh1vjshLqkOol2NwbqdGmOux03YrehE7MIMU73PTkkbIwb2Q+qSRGAU?=
 =?us-ascii?Q?REwJJJD3VjEfLjcIUHtvWA3IUb9yfcmAGx0cEPvfDPs55bW2HwLzmC5A4LCi?=
 =?us-ascii?Q?+shrY54fpBWBr8d6QiO1WbYIDQAXyFrMS6LF119cVY5sqpdmFMb3H3SX9Lru?=
 =?us-ascii?Q?Tck56pj29kCe6M0i7Cqb2X+faFmJcSwW6rW6zzD0BMd9+AbubeaVWYXtS7zT?=
 =?us-ascii?Q?NRdZQ9c7OUNOdmYBBHo9MR2bpIhL4X/g2Q8/87+CTNtY3jMtnObMC+U0gvbX?=
 =?us-ascii?Q?bAqcB9Rxu4paLeyr+kEUXTlgAhg8Esx/ctKg58lVKJ8UDZIlw+86p00ReCI9?=
 =?us-ascii?Q?rLpMbJSQsREKSO7xrqQslr4fq5xmp2jkXPbHYoMHOMqGsDLk0Iu9aQg6SFJP?=
 =?us-ascii?Q?2QbaIWUPxZtK5daZGwkdlzALgy/G3+tfJ6wLL5ol4ipS367JxeFtiuapU35d?=
 =?us-ascii?Q?ZZae3FbI+mLJz6H7oaXM8rt7MhmwjpO6Se5I4BcNDMuoMn6CqP3EhaxRowbj?=
 =?us-ascii?Q?Yw5vPp50zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae81a975-8c15-430e-23df-08da49afd0f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 00:34:30.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIkvfmXj253ig2/FnYChZz2gBOb2LIy9JaHIvD97LMR0iyyvvhbIgsm6togHEHcFnBtG3XpPUoJLpUGSvkzyBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2084
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 06, 2022 at 12:32:20PM -0700, Ben Widawsky wrote:
> On 22-06-04 17:50:49, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL Ports with memory devices attached need the information from the
> > Device Scoped Memory Affinity Structure (DSMAS).  This information is
> > contained within the CDAT table buffer which is previously read and
> > cached in the port device.
> > 
> > If CDAT data is available, parse and cache DSMAS data from the table.
> > Store this data in unmarshaled struct dsmas data structures for ease of
> > use later.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V8
> > 	Adjust to the cdat data being in cxl_port
> > 
> > Changes from V7
> > 	Rebased on cxl-pending
> > 
> > Changes from V6
> > 	Move to port.c
> > 	It is not an error if no DSMAS data is found
> > 
> > Changes from V5
> > 	Fix up sparse warnings
> > 	Split out cdat_hdr_valid()
> > 	Update cdat_hdr_valid()
> > 		Remove revision and cs field parsing
> > 			There is no point in these
> > 		Add seq check and debug print.
> > 	From Jonathan
> > 		Add spaces around '+' and '/'
> > 		use devm_krealloc() for dmas_ary
> > ---
> >  drivers/cxl/cdat.h     | 17 +++++++++++
> >  drivers/cxl/core/pci.c | 65 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h      |  2 ++
> >  drivers/cxl/cxlmem.h   |  4 +++
> >  drivers/cxl/cxlpci.h   |  1 +
> >  drivers/cxl/mem.c      |  1 +
> >  6 files changed, 90 insertions(+)
> > 
> > diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
> > index 3d8945612511..0a510f73fe6d 100644
> > --- a/drivers/cxl/cdat.h
> > +++ b/drivers/cxl/cdat.h
> > @@ -85,6 +85,23 @@
> >  
> >  #define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
> >  
> > +/**
> > + * struct cxl_dsmas - host unmarshaled version of DSMAS data
> > + *
> > + * As defined in the Coherent Device Attribute Table (CDAT) specification this
> > + * represents a single DSMAS entry in that table.
> > + *
> > + * @dpa_base: The lowest Device Physical Address associated with this DSMAD
> > + * @length: Length in bytes of this DSMAD
> > + * @non_volatile: If set, the memory region represents Non-Volatile memory
> > + */
> > +struct cxl_dsmas {
> > +	u64 dpa_base;
> > +	u64 length;
> > +	/* Flags */
> > +	u8 non_volatile:1;
> > +};
> > +
> >  /**
> >   * struct cxl_cdat - CXL CDAT data
> >   *
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index e68f13e66fcf..9666cc4a67aa 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -673,3 +673,68 @@ void read_cdat_data(struct cxl_port *port)
> >  		retries);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> > +
> > +void parse_dsmas(struct cxl_memdev *cxlmd, struct cxl_port *port)
> > +{
> > +	struct device *dev = &port->dev;
> > +	struct cxl_dsmas *dsmas_ary = NULL;
> > +	u32 *data = port->cdat.table;
> > +	int bytes_left = port->cdat.length;
> > +	int nr_dsmas = 0;
> > +
> > +	if (!data) {
> > +		dev_info(dev, "No CDAT data available for DSMAS\n");
> > +		return;
> > +	}
> > +
> > +	/* Skip header */
> > +	data += CDAT_HEADER_LENGTH_DW;
> > +	bytes_left -= CDAT_HEADER_LENGTH_BYTES;
> > +
> > +	while (bytes_left > 0) {
> > +		u32 *cur_rec = data;
> > +		u8 type = FIELD_GET(CDAT_STRUCTURE_DW0_TYPE, cur_rec[0]);
> > +		u16 length = FIELD_GET(CDAT_STRUCTURE_DW0_LENGTH, cur_rec[0]);
> > +
> > +		if (type == CDAT_STRUCTURE_DW0_TYPE_DSMAS) {
> > +			struct cxl_dsmas *new_ary;
> > +			u8 flags;
> > +
> > +			new_ary = devm_krealloc(dev, dsmas_ary,
> > +					   sizeof(*dsmas_ary) * (nr_dsmas + 1),
> > +					   GFP_KERNEL);
> > +			if (!new_ary) {
> > +				dev_err(dev,
> > +					"Failed to allocate memory for DSMAS data (nr_dsmas %d)\n",
> > +					nr_dsmas);
> > +				return;
> > +			}
> > +			dsmas_ary = new_ary;
> 
> I don't love the realloc on every loop (though I've done something similar
> before). What about allocating enough entries port->cdat.length, and then a
> single krealloc to shorten the array upon success? I think krealloc pretty much
> always succeeds when you shrink FWIW.

I'm not sure that it would be better in any significant way honestly.  The
chances of krealloc failing is small.

> 
> > +
> > +			flags = FIELD_GET(CDAT_DSMAS_DW1_FLAGS, cur_rec[1]);
> 
> Does it make sense to test length/bytes_left before reading cur_rec[1]?

Interesting idea.  On the one hand the CDAT was already validated with the
checksum.  But the checksum could be valid even if the dsmas data was
corrupted.  Especially by a malicious device.  Also, I'm not sure but I think
SPDM would protect us from malicious devices once implemented.

Overall, it seems like checking bytes_left is a good check to ensure we don't
run off the end of our buffer even if it is just some fluke of data reads.

As to length I'm not seeing a danger but it might be nice to know that
something in the dsmas header was wrong.  I'll think on this more.

> 
> > +
> > +			dsmas_ary[nr_dsmas].dpa_base = CDAT_DSMAS_DPA_OFFSET(cur_rec);
> > +			dsmas_ary[nr_dsmas].length = CDAT_DSMAS_DPA_LEN(cur_rec);
> > +			dsmas_ary[nr_dsmas].non_volatile = CDAT_DSMAS_NON_VOLATILE(flags);
> > +
> > +			dev_dbg(dev, "DSMAS %d: %llx:%llx %s\n",
> > +				nr_dsmas,
> > +				dsmas_ary[nr_dsmas].dpa_base,
> > +				dsmas_ary[nr_dsmas].dpa_base +
> > +					dsmas_ary[nr_dsmas].length,
> > +				(dsmas_ary[nr_dsmas].non_volatile ?
> > +					"Persistent" : "Volatile")
> > +				);
> > +
> > +			nr_dsmas++;
> > +		}
> > +
> > +		data += (length / sizeof(u32));
> > +		bytes_left -= length;
> > +	}
> > +
> > +	dev_dbg(dev, "Found %d DSMAS entries\n", nr_dsmas);
> > +	cxlmd->dsmas_ary = dsmas_ary;
> > +	cxlmd->nr_dsmas = nr_dsmas;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(parse_dsmas, CXL);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 531b77d296c7..4d779a8fb807 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -10,6 +10,8 @@
> >  #include <linux/io.h>
> >  #include "cdat.h"
> >  
> > +#include "cdat.h"
> > +
> >  /**
> >   * DOC: cxl objects
> >   *
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 4d2764b865ab..ce5b00f3ebcb 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -36,6 +36,8 @@
> >   * @cxlds: The device state backing this device
> >   * @detach_work: active memdev lost a port in its ancestry
> >   * @id: id number of this memdev instance.
> > + * @dsmas_ary: Array of DSMAS entries as parsed from the CDAT table
> > + * @nr_dsmas: Number of entries in dsmas_ary
> 
> Personally don't think it's necessary to append "_ary". Up to you.

I think it's fine.

Thanks for the review,
Ira

