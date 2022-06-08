Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57437543FBE
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 01:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiFHXHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 19:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFHXHg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 19:07:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9331826B;
        Wed,  8 Jun 2022 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654729640; x=1686265640;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QbuUql+Jw5UTqmE8shjENYEa6d4ElquvooPUL8kaZNQ=;
  b=brj3vY/r0trcKvozrJCc8HB20KD4OpCeJqW+J3CQMQmvtmJxsEWguSDp
   sExwC9g1eBkqGDpg1vWpxbYe9tOs6yUehG6uEm5GDS2N/CyDRXXOGWN4E
   9YJdpX8cFh2u/WGQfYERzWvkYNyK1w4LWk7u+252fTsVjXZOES+gBB7i7
   vSzDuoFRA53du1Z1v8aD5wHMJl7Omjfs8lcPGZ2i0jDGiqzCzXNgwUpG3
   Tm4vnH0S0Yzz0x/HS06ixl/io/pqW9WJMr7tuWS8iiGFcoWlkNwdLyurm
   IXjbKTMu7s+bXfQLOYznppHNnTJ5FWQ0nIgt0s/MXYcGJC4AsjO6g1j2N
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="274599632"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="274599632"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 16:07:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="827228818"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2022 16:07:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 16:07:19 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 16:07:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 8 Jun 2022 16:07:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 8 Jun 2022 16:07:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4g5rahDmLJsw0k7BpzQi46WC2k/7n7GmpGYkkkBCEphgJflO+/54ygqWXw647BF/RQuZM4sL6KNFLgVSHYuaMBQSDE1Y2VQ0oiutHXL6moUDu5/lzNDMpq6nEMurFsLcTFIKoWwItVxGdUBeCmexwdEuBkeDSg3NwAIANIeVdiB9CovgnQDE5v83NbThymsL0LCtjt+EFqGg6FpWNftfBGQoN3ebHQK+xTKNp2kCGnDI6fqujwyj6m8FfTSkCuTKY3tjngYW4RYfW4iKx0amMTE4lk8uk8+B+scb+7VhgQlX1EEuZY/0veUxm8LlWnz/dkvmgfh1jSlaOTHBBuviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8P2hyCPSwDDjiEETd+joLu61E8Pq90UopPFeYEwifI=;
 b=Z1N0Owz1w8XBW31BWWgCwhHeJlu6wkQxSEpM4FOg8H04FGZ5XDxQl8b+Yjk8k0Ojx3cx8CA9VXSWly0DX/ZodM/b508JmMHTAXXfgj/ItmkMN0yL+pzEW13KtfirhXAxrF3vHeenqu3iyNRcphSc+2WC58oG+YVYSNe1BBAytz2q7+2wSve4r+oE5a6DuLmHMv5lewXrtXjdTdhDBGzEzPLFFHj9eLv8LbrFk7MLt2quj1OA95qvxc8B+h6swYHauyq8h0RLY9jtRaG/8KW/VCDR/v8WsHbIxXrhfNWwvuJFc/khQSvWU27KAnHM02sXc/mqgeludS3uOjvP/YT6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DS0PR11MB6493.namprd11.prod.outlook.com (2603:10b6:8:c3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.19; Wed, 8 Jun 2022 23:07:17 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%4]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 23:07:17 +0000
Date:   Wed, 8 Jun 2022 16:07:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Widawsky <bwidawsk@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V10 8/9] cxl/port: Retry reading CDAT on failure
Message-ID: <YqEroOuHpEa2GkHA@iweiny-desk3>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
 <20220605005049.2155874-9-ira.weiny@intel.com>
 <20220606185203.ntm3yf73kf4u2o7a@bwidawsk-mobl5>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220606185203.ntm3yf73kf4u2o7a@bwidawsk-mobl5>
X-ClientProxiedBy: MWHPR21CA0046.namprd21.prod.outlook.com
 (2603:10b6:300:129::32) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0801aee-295e-41c8-7e5a-08da49a3a200
X-MS-TrafficTypeDiagnostic: DS0PR11MB6493:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DS0PR11MB6493C464A9443C38D517CA83F7A49@DS0PR11MB6493.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDjHq8vHMXGGH8NIpO1Wg/X3zrpWn4UY0Q1BOijuVAg5dT2FcszvXZjl29gFHAa7aZfaqnaWvTdX+WTsRHJ4PSL7UV3Rc6SJ8fzoks2H1vZVcPoCkyZy+cRbwP0Ezt8s8XHojkuphWGQJLHDsR9jkDRDH4fhTsGcuX8wV4RnaVZQL8uPx2h/JXep7eNHifE1d9jKKEBS7HhRaXk7Zxsa9x0c6PwwwSd1vTzOZxF9+gMNoxyqibL0jxAVisEV9HmjZs2WlT/mUQwFSjkHsQ6tsDzxPwKtatp87yiDVClJc5dPSP6+pg1Ces9MM6iiM+vMjJi8Qp4GF1NRrCv/n4FySbGTgBQ8XMgUVOJJgYqJAekyz8gRZimJUy+zDzs1w1jLPI4e4hhShnmsMpVTTtyjBzlgTvlqnceN9LcDISvMi8BE0EZDBBqxgDGhrjtocxwmVfFNFL0nObeoXxZKbIN5pzLG09CB6a5PZxXOn80b0E8v4ZqSo8LUBZ7zMFQrkcHpmDSyyZaNmVz7kfdjusoZkFIDRLDUMqWD2/SQtv19w/1V7MpyrnNakqM3BvqCZi6oXx4MPY1+R6hZqnQ+Kl8SCIrjFrzBv5a02Ia8WRJPQUL4SQrFHOu2cCB/Chb/O9GxYqgShRkWADN9ZI51bM6CGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(53546011)(26005)(82960400001)(6512007)(6666004)(8676002)(66556008)(5660300002)(66946007)(4326008)(316002)(33716001)(6916009)(54906003)(2906002)(66476007)(44832011)(38100700002)(508600001)(83380400001)(86362001)(6486002)(6506007)(186003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GDyQRXmiDcQESxJP76QEpfH8BoB+qLwSOf7Qi3uE2g4p1f33dV/EMQcT+RcG?=
 =?us-ascii?Q?xrZ3lyLQn6QnQPEV+0UZa+Hv1Qu756bJ4NCu3X7LdJq9FSfK7s6l6lL1S7Nf?=
 =?us-ascii?Q?me0NixtrBVOWUk6RF8IUnjp2EHVXHwk879vAs4tBT08FA10FBTVl4LjA0Kyo?=
 =?us-ascii?Q?pj6XUkCIAf82gFgVbo9lFJ49u7P+Hbl86pCuylO+hmsh259NEs2csitn4oj9?=
 =?us-ascii?Q?KuP49MtVufMUvm7YMgl7rOzBGFUQxV/ClFiyfj8SO8AkkfP5FOYiwix0g/X5?=
 =?us-ascii?Q?Jy75V4lEWL3MyGuJIOcvSpMS2TZXGcYwDxcOgoAPB82WsBSVUfa8KCMNkC/R?=
 =?us-ascii?Q?ZZUEhEHT8z1nceo2u82KkAuoaK2kPNIXBQvdAENMdLwMBVwkbxH1lbwCei0n?=
 =?us-ascii?Q?GUl6T2QEAJi+FWVJPuloobR5sh4r6FGmbHGvh4zwo9tmg/a7Zmh7wqLjoRjz?=
 =?us-ascii?Q?jH+8JnPZalVzPA/QxuM5uFHKRXt70rrREdCcjbd60rJyg3sv+zwafOvczc4i?=
 =?us-ascii?Q?P2XXbbsYZRBeUe4Sg16FFacsUdwGiwzC5PcOkjKWaWU+EoKjIKleaAOybuJx?=
 =?us-ascii?Q?WzHMu2BTz66EdHTCm4EbtysmH1q8UqQUbvLRKPsTKbp9QtGjPgNelMq/5m1Y?=
 =?us-ascii?Q?h+ByewOiLmaU8k/AZJOtKtaaU2OVnmoM3FXOYMeelVBqQmX6d8W8Ez3k56qT?=
 =?us-ascii?Q?V7q86Np6hRH7tFC6RCz354q4orNH1b0qpfPKRyZ9dkNBq38gYu57m5Gx1TNl?=
 =?us-ascii?Q?G3c7NPYvc92IcDLNPt6kaR/G2tkUbnqEfxxrFgukt4DEKtxLGLy84UxhDEsq?=
 =?us-ascii?Q?UvbZkwYRfkimCE3mJF7NZdocfZepOQ6mpchvCLBY6KGHRClH3E704R4N1DZv?=
 =?us-ascii?Q?HF45UBtYTxv1tqSUfyY0cRoAWhuGM9AAnYvQEZbgdiKM7tnc0YbtKZy7BAYl?=
 =?us-ascii?Q?mR0aqRjYEUEjHxAao/nFqrFI9vblDlezvXRuSGjunN7+m6xekhysNHPAP3Hi?=
 =?us-ascii?Q?+hFYB6Gguoo1lBexuEB27Hrkirc0OA2OhgixNYK9cNq4+IwkpKxSRl4GHbS1?=
 =?us-ascii?Q?bz4GoG1L78ku8UUIOJw6SPxheYvy1g8bmd48AXsD0m0Cw8MyDKPJ7CX9cB6u?=
 =?us-ascii?Q?K0r5UtFvq8q7UsruACY/Xb48lNdkuUL8XUkLVeQz5metX57/nqn4kc+bYPXd?=
 =?us-ascii?Q?tDF/KJ6979sFf9D4CCiQF0eFqdW9fVgtjXd+9bHY/fxVViua+26zVpcZbu1+?=
 =?us-ascii?Q?TGA6jmr9YpZKQAiRmBN7s+e4d78vBNTQchbDuz5EwzdhchJLfEoX5EC3gYiO?=
 =?us-ascii?Q?tf4nryXOxMCsWas/849PUBhQ22nfsbAnXpXENM4wV8O4FJjGihM7/T6g0ii0?=
 =?us-ascii?Q?92Wo65X476H9rlHs7rNDrZkS4elb+Ot4IPR+9/v3JjWu4caVIuzTJhCYybJj?=
 =?us-ascii?Q?EjGTY9wF6qfb6/W3cx2mWa67Yg/IZE00xGgtRFC3m6hjCC8CG2sAoePCTPiC?=
 =?us-ascii?Q?zmLmSmFPAdI5aV/7XpfNTVlIDwmGZHmSw0aLNAQUDgJsqtjJxUTUm5bO0TvB?=
 =?us-ascii?Q?MrZVsh1Nb/XW6Z+iktj4f1KurYN/FxuZpMAZ3ftETAfbIkuiVcTy7Fsy5H8D?=
 =?us-ascii?Q?XRhxgshI7dht6fMTJHGgOfoVzOpaTpCWEsGmDyvEj21d4zGOw2RwLQHqylEx?=
 =?us-ascii?Q?0cutt3LHakx8acUbJplgrXka3OXltXrUmE555Bl2lfxgubIMSr4EpwgpLLbn?=
 =?us-ascii?Q?fRpQfo2zzw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0801aee-295e-41c8-7e5a-08da49a3a200
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 23:07:17.3869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /d51n9S8f8WE3GhuuuWeCzxmz2AGaFPkgEwkk5ackcfbcdkSuAdoAXdWnAAVfrsTAdEAw7PDE3Q7vyQC4wjTFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6493
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 06, 2022 at 11:52:03AM -0700, Ben Widawsky wrote:
> On 22-06-04 17:50:48, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The CDAT read may fail for a number of reasons but mainly it is possible
> > to get different parts of a valid state.  The checksum in the CDAT table
> > protects against this.
> > 
> > Now that the cdat data is validated issue a retries if the CDAT read
> s/validated issue a retries/validated, issue a retry/

Thanks!

> > fails.  For now 5 retries are implemented.
> > 
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V9
> > 	Alison Schofield/Davidlohr Bueso
> > 		Print debug on each iteration and error only after failure
> > 
> > Changes from V8
> > 	Move code to cxl/core/pci.c
> > 
> > Changes from V6
> > 	Move to pci.c
> > 	Fix retries count
> > 	Change to 5 retries
> > 
> > Changes from V5:
> > 	New patch -- easy to push off or drop.
> > ---
> >  drivers/cxl/core/pci.c | 34 +++++++++++++++++++++++-----------
> >  1 file changed, 23 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 73e28b82ffcf..e68f13e66fcf 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -631,20 +631,18 @@ static int cxl_cdat_read_table(struct cxl_port *port,
> >  	return rc;
> >  }
> >  
> > -void read_cdat_data(struct cxl_port *port)
> > +static int __read_cdat_data(struct cxl_port *port)
> >  {
> >  	struct device *dev = &port->dev;
> >  	size_t cdat_length;
> >  	int ret;
> >  
> >  	if (cxl_cdat_get_length(port, &cdat_length))
> > -		return;
> > +		return 0;
> >  
> >  	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> > -	if (!port->cdat.table) {
> > -		ret = -ENOMEM;
> > -		goto error;
> > -	}
> > +	if (!port->cdat.table)
> > +		return -ENOMEM;
> >  
> >  	port->cdat.length = cdat_length;
> >  	ret = cxl_cdat_read_table(port, &port->cdat);
> > @@ -652,12 +650,26 @@ void read_cdat_data(struct cxl_port *port)
> >  		devm_kfree(dev, port->cdat.table);
> >  		port->cdat.table = NULL;
> >  		port->cdat.length = 0;
> > -		ret = -EIO;
> > -		goto error;
> > +		return -EIO;
> >  	}
> >  
> > -	return;
> > -error:
> > -	dev_err(dev, "CDAT data read error (%d)\n", ret);
> > +	return 0;
> > +}
> > +
> > +void read_cdat_data(struct cxl_port *port)
> > +{
> > +	int retries = 5;
> > +	int rc;
> > +
> > +	while (retries--) {
> > +		rc = __read_cdat_data(port);
> > +		if (!rc)
> > +			return;
> > +		dev_dbg(&port->dev,
> > +			"CDAT data read error rc=%d (retries %d)\n",
> > +			rc, retries);
> 
> Out of curiousity, what is the purpose of the dev_dbg? To diagnose delays or
> something?

Yes

> 
> > +	}
> > +	dev_err(&port->dev, "CDAT data read failed after %d retries\n",
> > +		retries);
> 
> 
> Reviewed-by: Ben Widawsky <bwidawsk@kernel.org>

Thanks!
Ira

> 
> >  }
> >  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> > -- 
> > 2.35.1
> > 
