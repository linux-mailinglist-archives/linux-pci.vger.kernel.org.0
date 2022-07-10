Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5101C56D0C1
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 20:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiGJSlH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 14:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJSlG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 14:41:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6569FF9;
        Sun, 10 Jul 2022 11:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657478461; x=1689014461;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y9dmXMkYtemIOSHugejS4Up32vWAYaykcAQab64DJcw=;
  b=PEkbrV11De6lK2kpkMHDXQX00IsfrPBUy9valByuw7hlgyrwsEPCEhQX
   C7J/RoDXWRJ0VuNo4fqqwC6YLILk0NHX3/0cRVeSvtvPpc2wai7pr24KQ
   cwpq0MqC3HpmkUKGa151yauVGJHpIoen1yU/DsPJUmpjugbEUHL6MTUst
   Ge9Ca3RzhmAGp70IuFnu/s4IugLyf5SbfLG4OzpT9o1NLDh/xeXneg0oq
   aMupqJJ6zZq+R/nqoNjqRTH9XUPHqkUrObpmE8LVBZRCl7RZ65qcF+cYJ
   Hth8SQ4IzqBBX9eQBbHredT1rFUMV2dL8S/Oi1dDV631fSTCIo82CT365
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="282082270"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="282082270"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 11:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="771309921"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 10 Jul 2022 11:41:01 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 11:41:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 11:41:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 11:41:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvrV8Td/Ky/cyIFShrrnkTk357kEsc518kLk0AR3kN9SHwyDfoQZRgVuIwdU9FQQUcSyIyUgBsjmryzJTsfOlBm1GqRKIYGhMwf1S00lUejsh0htdK7+5RoGdjpKohS7M2P8C45MQROMoyyDSD8uE48oy1OHHhRs2kbQOoTcXSiKvMkQM2G8IMN8Iwk42U93Re118CYyuW5xGArMDGTstfCkGFuQtS3uWVBEwhy+r2DeUtzjIHMkoEmaa0iEMtGtnT6RsLhtFUrmhrWhvG0S3//4p/eT3l2MBSwy3ThGKVYboUIJFzUprdbmcb8GAiYORi+2RaZPOh8qZMYREoqVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXwj0/RffpRzWGjDmimSTBKiW5kq5EYYnyhY76hwtDs=;
 b=i0ckNL2UMC7WQhSIYoBglL2F1FxOeKb63g5u3yl7adyhLrov9Xa0/E7QnxrNXYVi7wBZTVwqhwrZeyfA4W4Z2kY3Aa1+XsmAw2NXjWDduH0w9rfEEqbL8vRs51S8r8JdLmkH9hbnXl/Y0WxqfxlJgmEoEGf3QqvHpMSpJT0Eyk5lc965QJOSUnaXc/wVX0AsPfKYmB/P7LZg6EBSgv1JAyEfsGuU65CSMkseTE6zFeqs2tB0k7Sg5p3cTwwq47UiV/i6s39VUvozOobcsT6cm902i+d5T3Byqj6XHW4jiRenGLZyFJPobpA3nxmcnEb7BTQtIAPjXr2ubMxyqSsqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5101.namprd11.prod.outlook.com
 (2603:10b6:a03:2dc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sun, 10 Jul
 2022 18:40:58 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Sun, 10 Jul
 2022 18:40:58 +0000
Date:   Sun, 10 Jul 2022 11:40:56 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 25/46] cxl/port: Record dport in endpoint references
Message-ID: <62cb1d37ef8b8_3177ca29427@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603888756.551046.17250550519692729454.stgit@dwillia2-xfh>
 <20220629174936.00003a1f@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220629174936.00003a1f@Huawei.com>
X-ClientProxiedBy: MWHPR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:300:93::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6727d1c9-3716-489f-072a-08da62a3bae0
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5101:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ig44uovVf1Bd69jeUo9Z/1v6vCQ2H01wysNs4qtvxBYy2rssJJuRyIuyRRtpTA1cEvU2RBh88sVUim+77gsftgsqEaJglp+cg/B/FyJGEwg1O8lBn/dhNwIIs2h28Q/txYSI/AiCsFTJbeeVXDjKpRamb3yybPOZOtmUK0zyF7QuM/Etj1z/CJ99CZQCqr8xC3hM7ZOh5dacEh07veMjhQGS/tq3EahOsPNy+8erwdEZnMUp0XQHytU0FQADwXFycxYARl9xpXAgekM8SEZjFoV2VtYrKYfTb3VpzwWjMfh9ln50C+hyuZqZbtAKnSpCW4g4KRU7kZPq0gHcVLZJXQB576d9DjKKGf3rmHgkDJfG44exrkq3Kg1Jsq8b+ANoKVENBpsGD/AiC+GqOS3w3Jc7dPBf9MH9Wn4rnuBZg194ZP6zy/t5OL0gNrhtODsjtkAzNMWXydYOIfESk3ek15yG7rBnZUX0z8oojVj9+iMpvM4/bTmH29qxOFL5f+BecBGIVhp2XgV1d1p8D10VcO+bEfWvbIE0fTqwYaRpyv+2Bj2NB/njMSGqYhZdVNQWMDakvTjQq6b38o1Qk7awy6S6OBfOFEgZm+6o2eu2/EP4ifevkJkVN7PxbuxK+WEzmJYYsVis1JMSmfnN06wrXKF+q+kD8z8eAXxG1sbOK4fiFkgkJ5bYICiL83JA+1F+pqTN/iO9DWn/fOeL/H7DRchU79ULHm3vMjLWc608S5bwKQFJwkRaF5xuEgY/lEm+AwDMnQg3H0JoNd2HVJVCRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(136003)(396003)(366004)(110136005)(478600001)(6486002)(38100700002)(86362001)(41300700001)(6512007)(26005)(6506007)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(186003)(9686003)(8936002)(5660300002)(83380400001)(2906002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eg+1L01hqN7uafQZB6CCpFHrU0RPRJVthKZnHbZQR88s5btuJUf3DclZdLlf?=
 =?us-ascii?Q?2LWdId475+0x+I2FWtz4639OrtRxHwJCE+RCH8xr8X8JrD08QAC9bV3L5ni4?=
 =?us-ascii?Q?p3UEtBsLU9dWrxHaU/lsajlvnIvKXp53IArC2pTpB4NX+XLYMX+3Qw9RLPLn?=
 =?us-ascii?Q?I/xhhBnp5gEo0jjWp8XvsHel1rpqUA3IfQ0FoWyRdtfxD8WhBr6d9/RuqGCR?=
 =?us-ascii?Q?MnYUwnQzJ7UlqBJ+V15ZoIca4AxiqFVdHE9T7sdHEIxWkn5yR0v//4Uu4ZT/?=
 =?us-ascii?Q?H6n8lDgOozuO2xH5m8g/mmC6yJrB3Fu/kxEV3l/MKHRkYe3HavWVXbFwykWh?=
 =?us-ascii?Q?fHCFwwrxF6/WDADMUWV0TRO3p2l3VVJswiYaN8fcU9Wf51KNuBaJiYBVTRTy?=
 =?us-ascii?Q?h2xDEEvIpuSG5CBISxTrNnVUu5qpqsTjzUNxFaLf4Ybwa3puNePVD//NVsmx?=
 =?us-ascii?Q?tCH2OFhJ3V1NDN37YnnkYL5StmUOkuqDMSIdeDGkUPJXvMWyj9KAJTJoEb3i?=
 =?us-ascii?Q?Im67Z0E+XPxxG9tSIDdgIs7Vfm+fqxvhXH5rKa1zgqgou2f0Sd4EACHokbae?=
 =?us-ascii?Q?kW48J0b0OhsPOk2hn19uajIzETwZZCLv6nX09hXTKXoNhvGsSxy0llTQzGMf?=
 =?us-ascii?Q?aCwqY9+dIlATDEFEQrJ26Y35WC8R/RL67N+/yGdsJIlTfHPEZZ3Ewye5/NHt?=
 =?us-ascii?Q?mZh8E6ZaBtEzYEhOTN5V9EJpsg6DMA2JOs4nEAgfHFwFf3Wxm0nUuS+Vkv2P?=
 =?us-ascii?Q?adGkQSISfKwNawqHy4mYOdNL9fwQiEXjL0mvS0OYYipOiiqJ0gcueQlKlDNA?=
 =?us-ascii?Q?k4TEFBYKj40472YtLsZoK2v0ZgaBT12Xgf0svMJ5l7wZ6ueEHujboSB2mTYX?=
 =?us-ascii?Q?wAGWozZB4hio6lpI/gFSwbAUSBDzulZnZVKA35ssc8PrI4gLPElkaOJAY8vf?=
 =?us-ascii?Q?ZRNHNmYYQ9vcU6pJBh6tbs8fZEMmNzpDOkfJ6zJW38dYCsD9NiJDg/nbyCtj?=
 =?us-ascii?Q?jUK7mJZbA9Q9Evk+OY6Eej/ib4kmHBHZhPqFn4P5bncbzrVA5M4ywrfSZdO5?=
 =?us-ascii?Q?LEM9QErjTQoFp1Q+5kf/n0zBYkLguThnKZVWfXMGqoodsTM6PsUHpYTVHu1n?=
 =?us-ascii?Q?MH5ZIrcg+S61//hDgSf3fvQNaVIXpmoW5BfY4tANLLRUH6oNVKHpe2RzQ6sl?=
 =?us-ascii?Q?klymAoaAsPHUg9tEbMk3/3vYRDgQLejt4vyTvf28i09RIjwUd5a3Wj3pNn4z?=
 =?us-ascii?Q?+SNmPMELuSQLfIqECsajS+uuGA6eT074f58q3uhRt1HgBUi3PuQox9mAZY6Q?=
 =?us-ascii?Q?1a/j/sIxn4bG8cDVvUpIYCxTvdM+MHNzPpKJr5hOZQtX5Vqy8oVdYU9W8quR?=
 =?us-ascii?Q?eI8M9IJXA70zXHsQZjb7CvfK3WvT/K12MRbUEP/tzn8rAVBSiSZ16fd5g2z+?=
 =?us-ascii?Q?0ZqxrukmneJaQP7GMT+HGFrzPJaGLE3qt5sZVsUsz6XU/c6Qq63HhOKCx30N?=
 =?us-ascii?Q?aXEV14Dmk0mDrVbmvpbhqrekdqH42qSXlPBdEMCw9ReqHL+i2N8yWj1diPEG?=
 =?us-ascii?Q?Gp7yk8jgsTwY+BwLmofUutRKJArgrWUPrCxesxCWPeiVDagLuPv2AaV36E9j?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6727d1c9-3716-489f-072a-08da62a3bae0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 18:40:58.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAguorjGq3gv9ib24BEYGzKIPo28y6w9hsLrvuFTHwjzzIOzHF7C04cPbCbMNvwyVTy3D+ld/r0dzlDm4p9Rpf/fI6s5LqzA3+jEjWbQGok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5101
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 19:48:07 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Recall that the primary role of the cxl_mem driver is to probe if the
> > given endoint is connected to a CXL port topology. In that process it
> > walks its device ancestry to its PCI root port. If that root port is
> > also a CXL root port then the probe process adds cxl_port object
> > instances at switch in the path between to the root and the endpoint. As
> > those cxl_port instances are added, or if a previous enumeration
> > attempt already created the port a 'struct cxl_ep' instance is
> port, a 
> 
> would make this more readable.

Agree.

> 
> > registered with that port to track the endpoints interested in that
> > port.
> > 
> > At the time the cxl_ep is registered the downstream egress path from the
> > port to the endpoint is known. Take the opportunity to record that
> > information as it will be needed for dynamic programming of decoder
> > targets during region provisioning.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Otherwise, one comment on function naming not reflecting what it does
> inline.
> 
> Jonathan
> 
> > ---
> >  drivers/cxl/core/port.c |   52 ++++++++++++++++++++++++++++++++---------------
> >  drivers/cxl/cxl.h       |    2 ++
> >  2 files changed, 37 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 4e4e26ca507c..c54e1dbf92cb 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -866,8 +866,9 @@ static struct cxl_ep *find_ep(struct cxl_port *port, struct device *ep_dev)
> >  	return NULL;
> >  }
> >  
> > -static int add_ep(struct cxl_port *port, struct cxl_ep *new)
> > +static int add_ep(struct cxl_ep *new)
> >  {
> > +	struct cxl_port *port = new->dport->port;
> >  	struct cxl_ep *dup;
> >  
> >  	device_lock(&port->dev);
> > @@ -885,14 +886,14 @@ static int add_ep(struct cxl_port *port, struct cxl_ep *new)
> >  
> >  /**
> >   * cxl_add_ep - register an endpoint's interest in a port
> > - * @port: a port in the endpoint's topology ancestry
> > + * @dport: the dport that routes to @ep_dev
> >   * @ep_dev: device representing the endpoint
> >   *
> >   * Intermediate CXL ports are scanned based on the arrival of endpoints.
> >   * When those endpoints depart the port can be destroyed once all
> >   * endpoints that care about that port have been removed.
> >   */
> > -static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
> > +static int cxl_add_ep(struct cxl_dport *dport, struct device *ep_dev)
> >  {
> >  	struct cxl_ep *ep;
> >  	int rc;
> > @@ -903,8 +904,9 @@ static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
> >  
> >  	INIT_LIST_HEAD(&ep->list);
> >  	ep->ep = get_device(ep_dev);
> > +	ep->dport = dport;
> >  
> > -	rc = add_ep(port, ep);
> > +	rc = add_ep(ep);
> >  	if (rc)
> >  		cxl_ep_release(ep);
> >  	return rc;
> > @@ -913,11 +915,13 @@ static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
> >  struct cxl_find_port_ctx {
> >  	const struct device *dport_dev;
> >  	const struct cxl_port *parent_port;
> > +	struct cxl_dport **dport;
> >  };
> >  
> >  static int match_port_by_dport(struct device *dev, const void *data)
> >  {
> 
> This seems a little oddly name for a function that 'returns'
> the dport via ctx when a match is found.

...but it's called by __find_cxl_port(), so the dport returned by ctx is
just extra metadata ancillary to the first order port lookup.
