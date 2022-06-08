Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7145543D02
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 21:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiFHTkS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 15:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiFHTkS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 15:40:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95001FE395;
        Wed,  8 Jun 2022 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654717216; x=1686253216;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y0w66oyVs4yiK4P30CROxj1xWq1DUkbvFh/ImjFQr8k=;
  b=nsvWAcbNKyla7aiZxHmojEFrWiV0HD00eter64B534SE6IinYLoO69SU
   L3Hmkeu77G7y/WZ0YS0WvUXGdV7nHpLj22ljOVpfD/8IoT9XpLLH/dzXX
   CCEu+2mgWNwxIPnY5BuH7ulcXr9EA3UPHnyymRR5ZsyZs84nj90c2Jowy
   XgSTMetWPMVju6OOabXCL/2h6N9hXJ6uyww36Z8nP7JWkcSR32Llu4eiY
   Dbc6ETHhH4NGdE5ukP3MMkzyVLMel3TDCdP8YrVP6SENitWrXdw7bf/qK
   aS0Vdl6WBbrBY98jvVXvM6qO1esbYDz0THFwkr3atAcnP24npELTzkCDF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="277844053"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="277844053"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 12:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="710090099"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga004.jf.intel.com with ESMTP; 08 Jun 2022 12:40:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 12:40:16 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 12:40:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 8 Jun 2022 12:40:15 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 8 Jun 2022 12:40:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/bA5Y0pHbt/72yBxG4ZHUmic9fHGPVOt/bqf+gYZciWc5Jwp4LzJvF9O24AoqChIDVm+Ojh19qf5Uq7mAKEZgvSP7nllThQDw3wM7FFJ4lMW+bM1DD6/pXS0TT1SUqqktP0CngcojwVQUpuec2ZOSJOLXxwt6lk2WZatMl17AxvhQwStO6JX0em4xr738riEEXBw1gGCbq2ZTg1HrYnjCkdEmj8hPhj4zsIEN7w1DzWBfNEYz9sLSR0JaX65A+C9frZRtLzyPeGqrb4OkX3RTClvzQEEycC5Ya0yILUT+F2ylg9uJx6o0EdlU9XY98iYcsgYiPf7rKgkq8MNtBHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QE/Ll8B3COcfJy9ZdsgfIhwbTeTFvtE0vww30C9sRMA=;
 b=dcCw+GCINTPID1K6dHeS9g211Z+2uW7JojsNUd3Zmxkp1ziwgauXl+qf8pO293dV0eCqz/y9qWZ51N27lcelJrv2tcZ4IUKcRA98vXqemqVgyMn5UcsWrVLFI0P6W0WUa65u3G94iDILx079L+IeapRXs+Ad0sbmdjsAjo1sN68+TDQ0v99MPqOdO4Bj8XB/O6V4jA2rOfAageUE33OyCHs7OBCdRU8X7FLvGDb+pc2EITZ4WynH0f/SmiwnLpEElGbawpHpMWIjBdNouizlBQovHslNK/dcSnzV4LosXaYgSeeo9+thIQVYWIuSUOBCZ3TveMRFDTUFamxskst3aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.15; Wed, 8 Jun 2022 19:40:13 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%4]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 19:40:13 +0000
Date:   Wed, 8 Jun 2022 12:39:49 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Widawsky <bwidawsk@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V10 5/9] cxl/port: Find a DOE mailbox which supports CDAT
Message-ID: <YqD7BZnbK4wuN6Zm@iweiny-desk3>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
 <20220605005049.2155874-6-ira.weiny@intel.com>
 <20220606174819.hhnb4jh27nxxvrdf@bwidawsk-mobl5>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220606174819.hhnb4jh27nxxvrdf@bwidawsk-mobl5>
X-ClientProxiedBy: SJ0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::27) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0df5f12e-2b20-469b-16c1-08da4986b4ed
X-MS-TrafficTypeDiagnostic: CH0PR11MB5300:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CH0PR11MB530072AD46940B3BDB9B6CF8F7A49@CH0PR11MB5300.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtNaPQ5grwpi8LRzB+I0RpNHYugn7oOaMJXHLC0LpTjtmilIJhThWBHr4Df3g/AQ1w7Dq4GFuXMG172cuVpHhXktadjAk8jA45G+Cq8ltBkCxpbEwlkHohqv0KzWrgHqPaxLgcOkCTHg5sqUPTYFAu/8t18T5Ap+KI14T/EwIp0hyk2LDE54P5OvkSFha1FVhmpe2qasnctUtx+pYfpdf7w/DF5tdJEks6ohIZ8C68ipE6bhv6ucNmvtrwAvY9mCQ0dx1gI47Awoe4fo5d0W4ExTfUEWEW+HXh440NV6G+Sdw3LkGRBxSmtx/GZ6qsp4tYqDA9aZiubCJRxKx2w7n+QJOh+XfGW3/MhRAMpt46glF1qGwvZklPMbxaIaCN43W57ayA0r6BcHvpJV6hBK0WYPDNCspThaPap1VXjXinga9OnUpyfeGCqE9Qn3njldJwDXtvltS9f7Fx4JfjbbiTWeMa/xdwWalEN0RMAeG6BiRZHrGpGOkdyPe1/4t8uSTl+n6pCT4vFts2AOAuSur5/ZBgMPUGXDuJqfrl13+Y6ah+6By+IokjEMI7S3JmGyq35KtfjYwtUn2WB6Gk23w1/AD1/evSaxQ3LMsGRwQRApI0OdP778h3Z6jqCjUQKdbAAFnSMhCBS0jFduSZM1NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(26005)(53546011)(44832011)(6486002)(6506007)(186003)(38100700002)(66556008)(8936002)(316002)(508600001)(33716001)(6916009)(54906003)(9686003)(5660300002)(6666004)(6512007)(66946007)(15650500001)(8676002)(66476007)(4326008)(86362001)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9lPoGlNj8jSUqxKiI/qLUdUZG83RJD5Nmezs76POl09z4V9NVA3owDW+nntk?=
 =?us-ascii?Q?QDiJOyZDv7MFtSR39ktNERha4GfcEjDhFkXyCSiLblWajGggTOZLildLWGWM?=
 =?us-ascii?Q?Fas3b4rEkYM4ev0Ud0ufjoYvdW+DHFNHtTR95DFgXhN+II8LIOuJNN323vhW?=
 =?us-ascii?Q?9Fji+yFhoivvx5vCP7coD298q/AYBNsSB+0mRpi0/RyrPuNyYZRYGGuxHb2b?=
 =?us-ascii?Q?NcZIXy6FXTEF0yAAqO9WooGlMZCKeQu8sD+2MF89f0oxMSggdeKJiXy2S5B+?=
 =?us-ascii?Q?KERsZ1PEBH6YswLGN1LuCkE3Ft+MWOMHg9sN57c01UvWFzrFMut1dMEDDa1c?=
 =?us-ascii?Q?PLLnMmcouGD/AiR/kfO8GhpunwNwg6nRJRsNtP9mI1qzrJwmjQ/IMMJkrSaK?=
 =?us-ascii?Q?wOTHx4HdtZnXtqiQIPmbV/De7Xqe3FXIWh/Pgr4jRQSoCqkWTS4eGaxrqUR6?=
 =?us-ascii?Q?flroqAdDLevY67NSszbMZJR9oVALKUE3w8t0eTVqJJ+sNlyqIiMmqxqhuKfb?=
 =?us-ascii?Q?uwsGkcwGRJMum0lRJZO3UONzNmm4Za9BOZZlej9F6TB7ju2pOF6U4B1rUAfk?=
 =?us-ascii?Q?0vj4K/homjGC6A1jN5fwCM1+O4aTVkrfjGFdyz8KYBOzKbCHyJHLy/anx/EZ?=
 =?us-ascii?Q?GmnMR0txpUGPh+EdZFiT+QjTLsOFpNUe76LtRU+L9YYp7bNHLpd4vb/VOW/I?=
 =?us-ascii?Q?MS35S4APsLRfmucS946jybcnWW8OgY3IcHQK3ZDg7JQKjEOZIkRa1j64gAZg?=
 =?us-ascii?Q?j5gsHREhQLvh1anPnvGc9Pgwd4WVeoec0bPjXI35PPJd2oqx/ZaUwKTn0ior?=
 =?us-ascii?Q?wOMO2qKTKXjFnBx7U2rNi0DvkKLMTN68wOLvOSraD10/iZattvYHkMCYJAaU?=
 =?us-ascii?Q?sRjKQSXSxObQT7dTHkDqsONyDkqWYBAPQohMzxn9DWbqdTDVVgcB8bM4aFCP?=
 =?us-ascii?Q?zJKx2JTOdUzsWQOn4NAHylPcBzpDTX/NeqM4ltz9IGOKmYT4q2y0n+IiNLZN?=
 =?us-ascii?Q?Nab5lH9EfirNbIuI19NI5BTC4y799mKnNLNlh2CbuOFxoR8xn2yP4NDu/uHl?=
 =?us-ascii?Q?IePfZ04jDPazd+G+3PIZKlIJaBjGV7pzgHYdIKPu0zlEf88OFNEKqwif+Wya?=
 =?us-ascii?Q?6oGI7eDov9Eap9kcmBYvY880TjUw2o8XWlI/nDHps0ifHWHt14YCWhZYr7Bj?=
 =?us-ascii?Q?KH5D0mBLmEhqPUtNi6govxp+Q4CsBrubJXTGykterRakqu5pzKVR9f7XEtMT?=
 =?us-ascii?Q?cV/zGMC4aQGH/rjLdNOCfdmb8cRvqxZvs8uTQCtrN/nR7Q2UV2PvpfbY4CPD?=
 =?us-ascii?Q?BpdcQIp8L77yqTgnPVeVH0WO3m7fNKy1u04zY7rlqYD45kiWYKE1KW92XbAZ?=
 =?us-ascii?Q?/CqjKrO5cSzA0n1A7v0DARkoIWv5gUMztyS7qSXb8q475DTVRvrlOC9sSXtt?=
 =?us-ascii?Q?/CGa6Ot1w2e+m9eQKYOE5X6x1gqS/BmY57xM2uYdfykza133QuTp4M8hF5SE?=
 =?us-ascii?Q?CRZEX1yWiIUjGoaTOrA7HfGUOcjVHVFPt8oLyPg6bN0zLvkYOH69qIDRITSJ?=
 =?us-ascii?Q?Il2uhymGlRp3PtnELE4VaYqeN/LN84WyOQQolt/mo0r8Dfy5RLC/F1u8OHkH?=
 =?us-ascii?Q?dc++p+yBzIeEPQKXIQyvJxGRAX/F5YINv8sbgEAYpgVroWWnKrkMVJVSJm1X?=
 =?us-ascii?Q?2e51Efqqu/qq5Qom01xxa1BkPZwEDJqc82G4GKF/sFoqxd4LNvXLXeI2xOaG?=
 =?us-ascii?Q?3H/6w6AxXQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df5f12e-2b20-469b-16c1-08da4986b4ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 19:40:13.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4rcf2m8WZ75wOaxG9tTvME8y74zKkGbG2P2LzC0TuiCjy2E4MQV1D8D5OU57MN5V1nSpDPC5B+3E+vBbSH7FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5300
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 06, 2022 at 10:48:19AM -0700, Ben Widawsky wrote:
> On 22-06-04 17:50:45, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Each CXL device may have multiple DOE mailbox capabilities and each
> > mailbox may support multiple protocols.  CXL port devices need to query
> > the CDAT information specifically.
> > 
> > Search the DOE mailboxes for one which supports the CDAT protocol.
> > Cache that mailbox to be used for future queries.
> > 
> > Only support memory devices at this time.
> > 
> > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V9
> > 	Ben Widawsky
> > 		s/cxl_find_cdat_mb/cxl_cache_cdat_mb/; add kdoc
> > 	Jonathan Cameron
> > 		Move cache_cdat to port probe [Not 100% necessary but it
> > 		goes along with reading the cdat data.]
> > 
> > Changes from V8
> > 	Incorporate feedback from Jonathan
> > 	Move all this to the cxl_port object
> > 
> > Changes from V7
> > 	Minor code clean ups
> > 
> > Changes from V6
> > 	Adjust for aux devices being a CXL only concept
> > 	Update commit msg.
> > 	Ensure devices iterated by auxiliary_find_device() are checked
> > 		to be DOE devices prior to checking for the CDAT
> > 		protocol
> > 	From Ben
> > 		Ensure reference from auxiliary_find_device() is dropped
> > ---
> >  drivers/cxl/core/pci.c | 35 +++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h      |  2 ++
> >  drivers/cxl/cxlpci.h   |  1 +
> >  drivers/cxl/port.c     |  2 ++
> >  4 files changed, 40 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index c4c99ff7b55e..d814d8317975 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -4,11 +4,14 @@
> >  #include <linux/device.h>
> >  #include <linux/delay.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> >  #include <cxlpci.h>
> >  #include <cxlmem.h>
> >  #include <cxl.h>
> >  #include "core.h"
> >  
> > +#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
> > +
> >  /**
> >   * DOC: cxl core pci
> >   *
> > @@ -458,3 +461,35 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
> > +
> > +/**
> > + * cxl_cache_cdat_mb() -- cache the DOE mailbox which suports the CDAT protocol
> > + *
> > + * @port: Port to containing DOE Mailboxes
> > + *
> > + * Cache a pointer to the doe mailbox which supports CDAT.
> > + */
> > +void cxl_cache_cdat_mb(struct cxl_port *port)
> > +{
> > +	struct device *dev = port->uport;
> > +	struct cxl_memdev *cxlmd;
> > +	struct cxl_dev_state *cxlds;
> > +	int i;
> > +
> > +	if (!is_cxl_memdev(dev))
> > +		return;
> > +
> > +	cxlmd = to_cxl_memdev(dev);
> > +	cxlds = cxlmd->cxlds;
> > +
> > +	for (i = 0; i < cxlds->num_mbs; i++) {
> > +		struct pci_doe_mb *cur = cxlds->doe_mbs[i];
> > +
> > +		if (pci_doe_supports_prot(cur, PCI_DVSEC_VENDOR_ID_CXL,
> > +					  CXL_DOE_PROTOCOL_TABLE_ACCESS)) {
> > +			port->cdat_mb = cur;
> 
> What happens if cxl_pci is unloaded after this? Would it be better to copy out
> the CDAT info? Otherwise, I think you need to hold a ref on the PCI device
> (though I only took a quick look).

<sigh> I thought that could not happen but I see I was wrong.

A reference will need to be taken for at least the duration of the query.
Originally I had this set up to try and make it easier to query later.  But I
think that is a waste ATM.

I'm going to rework this ownership.

Thanks for the review,
Ira

> 
> > +			return;
> > +		}
> > +	}
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_cache_cdat_mb, CXL);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 140dc3278cde..0a86be589ffc 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -267,6 +267,7 @@ struct cxl_nvdimm {
> >   * @component_reg_phys: component register capability base address (optional)
> >   * @dead: last ep has been removed, force port re-creation
> >   * @depth: How deep this port is relative to the root. depth 0 is the root.
> > + * @cdat_mb: Mailbox which supports the CDAT protocol
> >   */
> >  struct cxl_port {
> >  	struct device dev;
> > @@ -278,6 +279,7 @@ struct cxl_port {
> >  	resource_size_t component_reg_phys;
> >  	bool dead;
> >  	unsigned int depth;
> > +	struct pci_doe_mb *cdat_mb;
> >  };
> >  
> >  /**
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index fce1c11729c2..ddbb8b77752e 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -74,4 +74,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
> >  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
> >  struct cxl_dev_state;
> >  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
> > +void cxl_cache_cdat_mb(struct cxl_port *port);
> >  #endif /* __CXL_PCI_H__ */
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index 3cf308f114c4..04f3d1fc6e07 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> > @@ -49,6 +49,8 @@ static int cxl_port_probe(struct device *dev)
> >  	if (IS_ERR(cxlhdm))
> >  		return PTR_ERR(cxlhdm);
> >  
> > +	cxl_cache_cdat_mb(port);
> > +
> >  	if (is_cxl_endpoint(port)) {
> >  		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> >  		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > -- 
> > 2.35.1
> > 
