Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41A356CC88
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 05:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGJDzZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 23:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJDzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 23:55:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748191B7BF;
        Sat,  9 Jul 2022 20:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657425323; x=1688961323;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mHnI+wrIAa/f7xccfiwI37kLenZqDL6w/YtlDBBcqjU=;
  b=M/9Iod29r4oQt5A0cZzdMirggw+60QlEQc+lIMQqvWjGsDXC0rFq6xX/
   iwFzXE9i9REhLp4oQCOjcP1jUDC1EaG0UhWIcHEeP6/rPjFHWPcUfV6sT
   u/lefMmwfSRH9xNTXbPbHJA+qZo97TM+3qD2yEqbzlguY+2KCWABperyd
   zRMHv55LhdCY5erJ5PDenE7P8gVbZVnZ5mRLACjc5Z88Xs2GKiDpju77b
   YqsTVoTjzBn+9n90rxtvaJDzHNZEIdueO9bjQSXrVg/2O8babC2uwV3ie
   UOngCvamv5cg5Xhhf6/aFDxnJJHjvS+t4Pr8JylbsuYRfdLjlitUpdPaz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="283232314"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="283232314"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 20:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="544631818"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 09 Jul 2022 20:55:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 20:55:22 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 20:55:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 9 Jul 2022 20:55:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 9 Jul 2022 20:55:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx6hrNhQjL1B5uBHP2PZSEdycdEHsn5pp+ejTkj5av+CI3HGQqo0B5/El127kkf6pZCnGmKJwg+XJUyil2jziTqC3gOngamV9owlvy0HeEPXiZOkavOEcs+8BEBT0HTpf1Vukk4we1BnXoSS/0PGlJ4hHubHP1NtAJqpeIN/ms0i0kkGI/kZ50MWzNVmJWeXcBVI3WKkIRKrXSMNLIZN2aZ+ntIR0ZFHimzIZLVhIWApReJl6bnIRxCLMnW0LQXVOiEeg+epMpcjKSxeqvNb1K48+MyNjIkgHdJX8osTEbi3UTwkPjGEVed5u6hJI294BlYjYwbq87+rAXGSbLnwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyftBb2M4TxidR5BmtB6rR4VPQ0xm0fB89WLA7xgvhY=;
 b=NiJ5SAP2WPSc+Sv177W2IgOgxvCUHrdH7EChNYjCU9AeDEY9FtK/bGYTXdu5ASWSH5aNGz7Xf1Dgg3DARQWLzoU7cM75COM/3Udw7ElSvMsixQy4hgU6h/EI/jyWBrE7MSscupILoa8HpzmfcEZ2l8WLVrpRt4lzRoYBk+I2jRUFlcbybEtq1bSlPYNBWzMTiaZZT9K9V4o1MLD5u5deD8nAYSsHk1OuzOHD2j2UkzwiofyIxEpQsrv3FcNoq2XplHdiyPltYdgk4TRsS4c1m0cWf/Xz6RukPwa9yCNM/8G4eGPq0lnsnRvzZtPQBGWjqGztrRcfqtgHJ1YB2MK9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB3922.namprd11.prod.outlook.com
 (2603:10b6:405:7b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Sun, 10 Jul
 2022 03:55:19 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.021; Sun, 10 Jul
 2022 03:55:19 +0000
Date:   Sat, 9 Jul 2022 20:55:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 17/46] cxl/hdm: Track next decoder to allocate
Message-ID: <62ca4da570a4e_3177ca294eb@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603882752.551046.12620934370518380800.stgit@dwillia2-xfh>
 <20220629163102.000016c4@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220629163102.000016c4@Huawei.com>
X-ClientProxiedBy: CO2PR06CA0076.namprd06.prod.outlook.com
 (2603:10b6:104:3::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26e28c5b-4723-42ae-5a1e-08da622801a7
X-MS-TrafficTypeDiagnostic: BN6PR11MB3922:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjpRj5dJiEuPvMSeIKoSqebaaVpWNZwBncQZPIIRfDl7yhuD5cNjQOCdMvqEJc03YlIA75Ks70K2p9Ml4EtMXnWIyXR9FdfsKQ7ibRSSx7j0KlGGeqMYpnwUppUfPHVs6Fcm0q0i/QFxTVkyfY2VY7q1nyZFXAIqaok4tGvNdjt6W072nAdMaS8ZqJ22d5F28EYSYigct2Vl5UgulxVgp1f5F9XhFax2myqbG3pemZGOdOpuwQGjg77SLxvRrJCvNPSihipnpSvtLPrDMK8FcCdOZCpS+c3IwXFSS3DGtyYFhOl3QYRx3m1tvj7fZMApT5cfmeFD3bT/biRIxfD+/gv0qFa9vRP3hxnBVmV3p1TKDzDNOYQjrC6Yez9nIKoo4OVOba9avcfq7FS8+6Hc/ZKuc3WYSf4Dhja0WCKoCR0g2+RS3ulgpy/0F/97rfzzwMp7tCKPy6S0t/4JvkCAY+e1yUrrBAF4VmuQxhIeUop5vOlp89Drw9wX4cNfj4dqefUlBguxUhj9UDuWeIhvWfMR54RGnbDGb6ZOAPkqVRxmHVFcJv0TJgEQcsepm6CKo7+FBFguk4XxDHkodW7X+J5Ie+qGPS5BkcTUA41iq5uXRJjK2IhwBAD9Q4ibnvGEG+j61AQHc4u85cImZGoP0gLmTZ+DKnaTptCzaL3HSS3o87Rn98FBp3+gRGFFIp13Ptv6fwm/4h1YO6c83QyPM155fcuzKUhwSrDfPZt0zeUKbO3uUHnsLdf6HIML24lS6dxn34/ThDvMutDV2Hv7Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(39860400002)(136003)(396003)(6506007)(41300700001)(83380400001)(478600001)(6486002)(5660300002)(8936002)(82960400001)(4326008)(86362001)(110136005)(2906002)(316002)(186003)(38100700002)(66476007)(66556008)(6512007)(66946007)(8676002)(9686003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Psi6XVHhWCvsqSyddu496NMNLMCvh4WF/DCJv2Kiu1ru4J2lVTMXTUPEFBZO?=
 =?us-ascii?Q?kIYZePiA/ryIRgxWFQp5angbxjpU1thggMoxxbw+9PDcE5SUh7eQOON3HOzj?=
 =?us-ascii?Q?63tG+++rmQ6JCfim02gegm7/SBLptWtBDEjkHvMJgEfsnnXS1g8VbxLc/fSy?=
 =?us-ascii?Q?EazFEeqSTRnDBVBAQKdmCZ9lQN/UdD1uRofNobZMvCm8J2HGb50fT7sp2cWZ?=
 =?us-ascii?Q?28oFHYOHt7o+0xAdfg37cetv3aTY0oDSfBeZw76PSA5MIDdDzie5ZWp9dL9A?=
 =?us-ascii?Q?lZ/jp5TSr7FA3V3Ov8eiCkX9DVKMzV+IULh9awfUUEtnA5vE98IGrcw0OrJd?=
 =?us-ascii?Q?ETyippHgR9hAn/NlBlJ4RUk/87ysfvJfSDu95ktk9FkS8rsB1Mp7jguRnC4o?=
 =?us-ascii?Q?fhp9TU7/8/xZ09FvclrjMf+68qCatAHjjzFeefDbu923FpM2tx+N/G257A4e?=
 =?us-ascii?Q?Fogf+B6g58n7rywtfZdjF6g4q8VHCiD2XhLrNN7KfcKlpqtJaXw5t8MNbRDO?=
 =?us-ascii?Q?vFSsyUGk8Zg8HawMwVI/oDzRtpt5dLrMhRYQRkZc60altbwT15kkX9UkB26L?=
 =?us-ascii?Q?kdcRoEQO9i0owWdfspvJDgDvcKqAyjKPUHnQms2wRAr9YXxF7aBa0iDQiAj7?=
 =?us-ascii?Q?ANgQevsawNdDQyJwjRYOYKaXRS2M/Dw0ZeQBtpArSAWkZkmpPQWHTHGCuoHP?=
 =?us-ascii?Q?/0FaiTgMaonsccwyQCrtAEgDUDaf3HPg0fU5hC54QgN/uMkk+HPQv4iETCFK?=
 =?us-ascii?Q?eoofeGYZFsgEMnlhwKvSaFPhyWLSoipwQEZ1BUVKTPvUlKfwI2sqKu6DFGAS?=
 =?us-ascii?Q?qF0M7apvu8Nnyf+MZY+yg5TlazzvEPJdwiVOlCDCWWKJeMWRa2HftjWAKGbS?=
 =?us-ascii?Q?o8Pj18wTYcKytuVgpS/laBQ+GB+AIgs3tyzpg6Hc2nxeOYRmLolX04NcapCB?=
 =?us-ascii?Q?IBuy2YZK2iibKALTgxAglWDXEU/ENYgSVS6ztJl0hFeJLHFoJRStgd/IyMH+?=
 =?us-ascii?Q?TimtFxrboMXG7ywZuSg5kxQZhjnjUrWIUamny5MNelX5d2dlVzkKUDiLa7Tc?=
 =?us-ascii?Q?+1is4mEUklDXx6zFS10eZhQl/CH6szGIolWh7HU1qll4fbpYVfAt7XaRiVWY?=
 =?us-ascii?Q?V4NfI/QvQKQx9UOyZuSXNxRz4ImDcgMEtoxoJ1h+npNDmGxZcWZha2LxekK3?=
 =?us-ascii?Q?Ka6FykNXFkb6qcB/oO2tB5n0EhyAwLJtddWcGMd69YBRkEyY8kaPqDs2nBz2?=
 =?us-ascii?Q?G5ARj5ipZQiIhsQTDlJLC4cVE4FZwsIoMpRssKDZ4Uya8TDvGtzn+yI2tiQe?=
 =?us-ascii?Q?TbuIKUGC1w+cEdUOMUGCkrq/EqB2o3dr1DSZ937BypEVNH28WOlY3drSEfwp?=
 =?us-ascii?Q?uPdJG0Zso7d46IHiRwZEfiHqHGm62FOUd2UGDyY00gjtxg77k07v2L5gqAtq?=
 =?us-ascii?Q?i30SvbM5QLGPcf9v3TjzjoI2oEWQgmGxCni1yjVJDs1ipKGd+0iENsAHhgyf?=
 =?us-ascii?Q?vOgdQHl0k/om9eUkMGWoX6jTCy4yd28yhKO4ON6QpYaEo+ru2wLgNJfj2H/4?=
 =?us-ascii?Q?bMmwR6utRft7Y0J/evsai/AYK5QkMA8zBHlXDWrZdG8Ar+qHrWQ/IBQeWIOp?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e28c5b-4723-42ae-5a1e-08da622801a7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 03:55:19.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNTjejnRyQHQiWA+7S8oVz+wUQh/nj1y5ruZaxsYEScGWuK5ROIoQF7FF9e514SXJhdWmPnmkZL72W+lOEnDvlT+YGWBz/i3IecNrliFDSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3922
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 19:47:07 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The CXL specification enforces that endpoint decoders are committed in
> > hw instance id order. In preparation for adding dynamic DPA allocation,
> > record the hw instance id in endpoint decoders, and enforce allocations
> > to occur in hw instance id order.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> dpa_end isn't a good name given the value isn't a Device Physical Address.
> 
> Otherwise looks fine,
> 
> Jonathan
> 
> > ---
> >  drivers/cxl/core/hdm.c  |   14 ++++++++++++++
> >  drivers/cxl/core/port.c |    1 +
> >  drivers/cxl/cxl.h       |    2 ++
> >  3 files changed, 17 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 3f929231b822..8805afe63ebf 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -153,6 +153,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled, bool remove_ac
> >  	cxled->skip = 0;
> >  	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> >  	cxled->dpa_res = NULL;
> > +	port->dpa_end--;
> >  }
> >  
> >  static void cxl_dpa_release(void *cxled)
> > @@ -183,6 +184,18 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  		return -EBUSY;
> >  	}
> >  
> > +	if (port->dpa_end + 1 != cxled->cxld.id) {
> > +		/*
> > +		 * Assumes alloc and commit order is always in hardware instance
> > +		 * order per expectations from 8.2.5.12.20 Committing Decoder
> > +		 * Programming that enforce decoder[m] committed before
> > +		 * decoder[m+1] commit start.
> > +		 */
> > +		dev_dbg(dev, "decoder%d.%d: expected decoder%d.%d\n", port->id,
> > +			cxled->cxld.id, port->id, port->dpa_end + 1);
> > +		return -EBUSY;
> > +	}
> > +
> >  	if (skip) {
> >  		res = __request_region(&cxlds->dpa_res, base - skip, skip,
> >  				       dev_name(dev), 0);
> > @@ -213,6 +226,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  			cxled->cxld.id, cxled->dpa_res);
> >  		cxled->mode = CXL_DECODER_MIXED;
> >  	}
> > +	port->dpa_end++;
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 9d632c8c580b..54bf032cbcb7 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -485,6 +485,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
> >  	port->uport = uport;
> >  	port->component_reg_phys = component_reg_phys;
> >  	ida_init(&port->decoder_ida);
> > +	port->dpa_end = -1;
> >  	INIT_LIST_HEAD(&port->dports);
> >  	INIT_LIST_HEAD(&port->endpoints);
> >  
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index aa223166f7ef..d8edbdaa6208 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -326,6 +326,7 @@ struct cxl_nvdimm {
> >   * @dports: cxl_dport instances referenced by decoders
> >   * @endpoints: cxl_ep instances, endpoints that are a descendant of this port
> >   * @decoder_ida: allocator for decoder ids
> > + * @dpa_end: cursor to track highest allocated decoder for allocation ordering
> 
> dpa_end not a good name as this isn't a Device Physical Address.

Ok, renamed it to 'hdm_end'. Suitable to add "Reviewed-by" now?
