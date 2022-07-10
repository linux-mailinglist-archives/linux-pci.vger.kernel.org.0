Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32DF56D0FA
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 21:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiGJTJX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 15:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGJTJV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 15:09:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35F414D26;
        Sun, 10 Jul 2022 12:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657480160; x=1689016160;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NpEmIG9olqC5lDfT3grolMghlzDBXijfRAtZdtKqhzE=;
  b=ON0x+hw+6SnADNH0QwnaDq3nWoLCDU5VYJYYmH3X0gbWvGfBkAen1OEY
   Jr/PBPqZ8W84qWPGqv012Nxmb2elonmORbFyZtZ25XinTzBUM4gocT6yD
   P3wgElqAWfsyUT53WorNDYu2f7fPT7lCTO0bLz93ACU6POl43jW+V8Wi2
   kErwZH9IWxBBT6nMKwoBD+yT9fZ+UGHXptZL5kRubbwnebZPk7qJJuoFf
   ZkAVcFyZ/r9rFfzSMG2ZaNIun/iMLITFVqDld7y/bwrQpgC2qcSUWYPoW
   9shxSdwjFZ2TjBknCYrQicyKWPFBtFLPUH3KHfwDy8RxbI/nmwTWfT9yy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="370843993"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="370843993"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 12:09:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="684170199"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2022 12:09:20 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 12:09:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 12:09:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 12:09:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gebHgbAys+9EwTlsdF629LX8Xd/etL5pa9u4pv5eGf6zI35rPwfHh5g5J/k6XtcFjeVB50pH7UxgesoaWJcOOYuvNvl/darz97h/VcqEVe88MigSvcHB+vAiqENnhXkli7x10RPRXNJyoXJ23Xj50uKdjuYmYJuPCQG9c7rFyfO0zhgSSI6I1KvgSKtjkd0TXLF3kwSA2HjNbWHGwYfjsIgFsFMgaBMt6y/D5dh5jlKJ8rjxLFsX/eKMBmsm5kDiWcpSyaP8svbedOTkAHs/QN4LQfSr4pKQJJBkBFPKs7P1mTTBvFOSpq2MMMTBNu4b8lfxJrVLUnzo1bWhzZFLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=appOenBHWhXh2O8DF89V7vsyRHOmqcDWTr96Mptldro=;
 b=nqbzttxkJOQ7c07dnzapEBHFiQl3RJBzaSsIJ1vx+8SeYhIHZfiIZpLXy/Y3KAHIcXHE2mcR/HqFj3awY6td5CT94kPStnZ/97f7BeCLCXhPD3mbwNL2QcxgCQBfQ/xGMJ+k9G8zTq/NqLgTVpF94AAAtRdd/PDJH41mr20icQ0q6362EYdBYazniX0LsYnuFX2leDkEkcq7pmF2ittXYxwr2muNM2PkJ4MJbz605rJHSTTSIzMKyoZPzv7ARrlG39CwuxexJC8ZUwjiMtzEjfWkmEPmAJmTBTRCLowew1hDSPXstFRJ0MO0zZNWdCBzsxQZcxdTiUej21MO8gEDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4432.namprd11.prod.outlook.com
 (2603:10b6:208:193::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sun, 10 Jul
 2022 19:09:17 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Sun, 10 Jul
 2022 19:09:17 +0000
Date:   Sun, 10 Jul 2022 12:09:15 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>
Subject: Re: [PATCH 29/46] cxl/port: Cache CXL host bridge data
Message-ID: <62cb23db999e2_3535162947e@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-4-dan.j.williams@intel.com>
 <20220630102105.000060ab@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630102105.000060ab@Huawei.com>
X-ClientProxiedBy: MWH0EPF00056D02.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:f) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a33cb4f-2284-4387-9d96-08da62a7afaa
X-MS-TrafficTypeDiagnostic: MN2PR11MB4432:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXpVHtEtPyj9AIV6rQP1ezJcYI/JCT4LtYqsqEGcFsoAFU904Qx5GQu7MohhOB8R3SswG9/i+tuCQM38+DsbOgzyaxNf+br81JYWJj+n1qEIgk4eIldB9U8dwIbF+V+NfSmrYI0HRwOK1yAwW9E6VczCHL4Jz1JqXV+TRVyhEaBWVDN0qlW61I+ZmLdqYEYvsP6J6T1R/tLPJ9bo8ld6fbNC3Qf+vg5W4Pa4wHQp6KXiuK8E994unj4ibiDTd+mNkDyAffA8IGJPzbZM15dV3F/qPUBBeMzaU/L9lV9cLowkXiLrg7G/P3y0NqAUcjbFlpEZxvIyxm/kYQOTD4UXx6SLPKNEb6WEzBNb0XDmg6NZb18pBbgJ7RYTKYSZ+j7A0HO5LL7QdLGsLWzZ9jBm7dF08AAKM3xKc/uDNmoxqn3GQVEQq8u4nPHIbm1+YoOQwK4+fNMXb9Unid3XhM+NH1gi7ouH7FKAOmXXujVPpYygIuSY8goLIXSJEs6+K3AFr2/o/3a2It51TB28yLGKWiB63WsNf3XYrYT7705tCvAoHjkLbhI1t4gof/b3SsaY5kUcugJ2ui6KvBhPpgx1s/1l6PV1tNVqyPLvJ/83ERjofGjztl8Ufilni96NLaae9XsOzrf88X1Q26vYTbFGTnDO8U9OOSV9d9rukZ+5RI5g53m1v9Dbk5HOTRCeMhb3M/kVfFWr99TXB0RLv4jBNdWWOR/tSllLsRE7f0sblzi20HzMhbrt5a13LRPQQEVRequVbRb06Q+YadwUy/TeUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(366004)(39860400002)(376002)(316002)(66946007)(66556008)(66476007)(8676002)(4326008)(5660300002)(110136005)(9686003)(6512007)(6506007)(26005)(83380400001)(186003)(86362001)(41300700001)(6486002)(82960400001)(478600001)(2906002)(38100700002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DI+nDc41AEzr/ESmKWd9jyY3V4lsCWzabb2s2GPNgY28WKIaFzOeegaqXwu6?=
 =?us-ascii?Q?8vCawFZN9Rxw4Nd+uOUtAUBx0NDPh3yP2HubMnQiZk0vswxrYN0t7qpXz1hE?=
 =?us-ascii?Q?FO7yr5ZbrGmREUnqGrTJdm6JL60FrJ3Kog5ybkpXGwpiVEr4dzbXva2Zw2EG?=
 =?us-ascii?Q?/ZGTD6ZFb+pNqefR1wmoyAvIbyL8PtMXtIIlhxw511Mm7x3AcOwVpsg+TmbQ?=
 =?us-ascii?Q?iA6eLDFKmBxTT3rbCRtCOQbIHWUdrx/CcPFp5Q4fZgnsDb6HEYmcRe+GKICj?=
 =?us-ascii?Q?Qc3xk1pmWVVFU/B8stBSAO4YgwRexF8NTT4wSzxw7sBX6khEr/EPiTyO1q+a?=
 =?us-ascii?Q?iCj8oA+burZUGnabk7BV1DC1pdkrzesYz4j1UQNVq3tthLFmNeR/fJzh49py?=
 =?us-ascii?Q?iXWHorioJCtSh2xbjRlFQePJ4IHvkarYp596hGfgk4TQNGTnyG81qmvGF/HI?=
 =?us-ascii?Q?65s77QTu48OfxSV6QhGxG7/i3MReP+dadxLZam/aA3lUC2NhSbYay0txD45H?=
 =?us-ascii?Q?Q+qwgaZLMDN0lc0sTF73UB4/CX99n3dhLVpKjPwDJZB7oSJBk8aybxciDpMU?=
 =?us-ascii?Q?wbXWOJ4TzK71TCQwJ8E+NEQx3QLu6CayrI3mXPGbTx8qTuIsRJmin57SWWov?=
 =?us-ascii?Q?Gg9nebRkM+kjuiqn4qjvz/Xf09zLsw9UB06vbWYD3dy/iq7WESVu9Ye/PPCy?=
 =?us-ascii?Q?dJkBCJBtY12X52TGC8ozpChAuh3fnXSG3DeUqGzKmsaPXjUHjxL7sN8Ea3hf?=
 =?us-ascii?Q?vBg7Jy0Ne8U8uIyFaJBBACT/grLVuaXXwIA1FLPmX8VsOgyPexCIH/B9LA/p?=
 =?us-ascii?Q?GOaCf4YmumOmQEbZLa92JQwkYeBcd3yU6hltTE9FLaa0Rnz7lEww4BCThGX5?=
 =?us-ascii?Q?xQhg8dz8v3DsomGenIwPWdWIdJgxhNxjgbeLKiPShe3bI1JsR0CfOvsJ/3ee?=
 =?us-ascii?Q?ubUobL47QGOpuAxdafBykja3qG8upyfXmvAO1GTgmmdTIGIXV0odOMWvoAIo?=
 =?us-ascii?Q?IEM77mzvQom8sR/xTHcmFcoXrmccz5xY6gJSFaqsBqbhGtoF+b1a7KZxOjrv?=
 =?us-ascii?Q?UdqO8JEacbVjzdpBX+By0v7Ku9EtBTtt0k6+c4Usz9QQks/ic95KtAtAYTSu?=
 =?us-ascii?Q?Gwl6Zv5XJiqHlnLL2Nl1z9twOAWpUt1bDhVb38glMlkqzy2FY9LosWPYPuBJ?=
 =?us-ascii?Q?tMR9+RDmzr/I6UytB1NpggU2m+7HbvQRCJ8D0BJ67HOwS1ecQwdQXAdnIDlp?=
 =?us-ascii?Q?fNvRLmB1Z3rimuhjyyCIO1vA8EIPldfKNRn1RE4W6oxFFY/liopwO+nasJfm?=
 =?us-ascii?Q?PToNuzZAQp2vl22Hfq6B9ebTi2EoeDChsLr6oPTxlhoIM6zXrsWbOTNpIt2B?=
 =?us-ascii?Q?SiuzFYK2TwGXBXVTsq6/c3E/u50/0uEoLEgCfPoGdggJ9EVkJThQ+sRqhOOE?=
 =?us-ascii?Q?2c3zZkBvwdxqhQAm36Y6eGc6DQqEt8tg0Vq8bx7pv1ZKbnZ6+bf9jYC4Dyaj?=
 =?us-ascii?Q?ILupNKL3aApGgzhiKJXII052oytm2D+Qgde/IgiRp92T+DoEGqOsXtaCXIco?=
 =?us-ascii?Q?1cdjNGzzoEvn0I7BQvzmd1/PE7w+KmhX/yxLoY9ZC8ARKE3/StM6zSFM/b8b?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a33cb4f-2284-4387-9d96-08da62a7afaa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 19:09:17.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rR2l3iRcsIxw+RQI23PcCm9Pl7YD/c1dDBRVzk0/C9SSeAKhwdBcaZy4vNAEIaeLYvZ6vJphx8XsDpFvaMNjw1CzudbZuESdrmkDjgTI0KQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4432
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

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 21:19:33 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Region creation has need for checking host-bridge connectivity when
> > adding endpoints to regions. Record, at port creation time, the
> > host-bridge to provide a useful shortcut from any location in the
> > topology to the most-significant ancestor.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Trivial comment inline, but otherwise seems reasonable to me.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/core/port.c | 16 +++++++++++++++-
> >  drivers/cxl/cxl.h       |  2 ++
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index d2f6898940fa..c48f217e689a 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -546,6 +546,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
> >  	if (rc < 0)
> >  		goto err;
> >  	port->id = rc;
> > +	port->uport = uport;
> >  
> >  	/*
> >  	 * The top-level cxl_port "cxl_root" does not have a cxl_port as
> > @@ -556,14 +557,27 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
> >  	dev = &port->dev;
> >  	if (parent_dport) {
> >  		struct cxl_port *parent_port = parent_dport->port;
> > +		struct cxl_port *iter;
> >  
> >  		port->depth = parent_port->depth + 1;
> >  		port->parent_dport = parent_dport;
> >  		dev->parent = &parent_port->dev;
> > +		/*
> > +		 * walk to the host bridge, or the first ancestor that knows
> > +		 * the host bridge
> > +		 */
> > +		iter = port;
> > +		while (!iter->host_bridge &&
> > +		       !is_cxl_root(to_cxl_port(iter->dev.parent)))
> > +			iter = to_cxl_port(iter->dev.parent);
> > +		if (iter->host_bridge)
> > +			port->host_bridge = iter->host_bridge;
> > +		else
> > +			port->host_bridge = iter->uport;
> > +		dev_dbg(uport, "host-bridge: %s\n", dev_name(port->host_bridge));
> >  	} else
> >  		dev->parent = uport;
> >  
> > -	port->uport = uport;
> >  	port->component_reg_phys = component_reg_phys;
> >  	ida_init(&port->decoder_ida);
> >  	port->dpa_end = -1;
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 8e2c1b393552..0211cf0d3574 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -331,6 +331,7 @@ struct cxl_nvdimm {
> >   * @component_reg_phys: component register capability base address (optional)
> >   * @dead: last ep has been removed, force port re-creation
> >   * @depth: How deep this port is relative to the root. depth 0 is the root.
> > + * @host_bridge: Shortcut to the platform attach point for this port
> >   */
> >  struct cxl_port {
> >  	struct device dev;
> > @@ -344,6 +345,7 @@ struct cxl_port {
> >  	resource_size_t component_reg_phys;
> >  	bool dead;
> >  	unsigned int depth;
> > +	struct device *host_bridge;
> Would feel more natural up next to the struct device *uport element of cxl_port.

Done.
