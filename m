Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773BB56D0F3
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 21:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGJTG3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 15:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGJTG2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 15:06:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD2511C07;
        Sun, 10 Jul 2022 12:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657479987; x=1689015987;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C6JnZ46VTyZBV5xFZMlGQ4AIp7H8Cu+6MGgsZ4jzzA0=;
  b=BGp8+w2lwj53+ez5YIdiEz8SHsWBnIKhzdFP5J5VPp5hG6htvtmW/EDT
   ptG+VxDtEGtEDheCQs+WR6kLtFC0dm2WFBH/2NOoT+w4lmMXZ3RHwOZar
   ZQuYTeSUssm5IAU0vKC18+oc3TACYrrCfrVxJdnyqLhCHXV8Op4FMIB6Q
   cw3f30mLX68PHQlj2srpMPAYj7/N7Q28V+UbsHc2zOYxx5wzaRvlGWibO
   nzkxEGMoA0Voa98r+5a+wbkNhpjINGyFhwj3WpRAwc8/fEI+MLtcILkrg
   eKGp7TYl4hpJ81QTFyGPvlU91iOmJmwMmNWwR83i2099Y2rdleVqUeAn9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="346219787"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="346219787"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 12:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="921552631"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2022 12:06:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 12:06:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 12:06:26 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 12:06:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhh7J3/pTvAL4meGTbpk4tObFNskJKzuwrrC/sAfLQjeEXRVYJwjzFp0RKz7UEMfKJu+627xvhQCGBmmA+sDY8JbC9/+w5DjIPfMg7RGTmG6dVntEozDVmrQCSHdiHm+aYLUb4CABrwVjHrCFobkLMjE1UDuoCJiR/9CZWxOpwCwVjMn8VErAAIz7GEI1YuysoQKJ9ofU5V6iCR/01dLfidwbUW1xIBOR/barz8diZMEwhW9ZLlOmJC1pkwKB7jvi1nhXPYnQOELRf3RjGluXatm9GyMFp8Re9bymc32/uM1HnOWUufodm8X3JWHGRUASBDCEp7OkjWE/0h7yApyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XnBa50lChu7LKyPIuIKmR3BlpTLx00+V+qdl7e6e0g=;
 b=T8zHmeYTnj3p11Cm8zndsPHmjdYU3X9/dI6gk1Bs2XDTBInu4yy2+9YSPjC/+lrXYkAqGtLgCnvTRs8cPEjIZo8IhYsJFnTlriDkvhbJvFp7D6cLfE4kPSIcx8a98LwNYCsCvN2k22BCO9dJ4R0D+OyH2xnj8HQWGPOvk1F5wJ2xMHxB6WkzrnDZzCeDKRhWp8RA/NiQ1hh+S4HTKEH3lGhbSQSK77u4HAvf7Y1uSk+JTE1aHsPjPUVqbJjU0hONuiBIy1+qEs4ZvnIXbFC333Aq1OwRk3o7Gy6Jw2W8blNbhke8fueY0j6WreErYvjomNb6Y3ZdEK32IaorL7pbQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BY5PR11MB4291.namprd11.prod.outlook.com
 (2603:10b6:a03:1c2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sun, 10 Jul
 2022 19:06:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Sun, 10 Jul
 2022 19:06:23 +0000
Date:   Sun, 10 Jul 2022 12:06:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>
Subject: Re: [PATCH 28/46] cxl/port: Move dport tracking to an xarray
Message-ID: <62cb232d48a38_3177ca294ac@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-3-dan.j.williams@intel.com>
 <20220630101808.0000714f@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630101808.0000714f@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:303:8e::10) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da44d5ec-8743-4fcc-77cb-08da62a747f4
X-MS-TrafficTypeDiagnostic: BY5PR11MB4291:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OA+Gh4838BPNLxwXoxxOYiBKalveRJ/vB1bmLrcbYgQOg3oVQIHIbx3UugHZxaE5w8gQ7dgRUczE//kr+8CbNH69HXT0d77wW7z3N1SR7Btt5bhUTk/tbpdVJcZ1XEddc3K7bYWOvSj/q7RLUfrDCVb4S3SYzunmMkpOMGMF++y+BD/DwWk/JpJHpL8RWHSkgYxbck0wvpih9Zd0qHA8POTTmA8mBcq6Vsg9XtPFkne8HYDGNjk1k5M3RJyVx5Z/Jb4y9txUjgXnfMXUNHQGFCFBkXN2lh//WEZVekKiAZ/oNg81khVi3tHgJjvM56rXEkjWpfio/L+8DTtze5G8BjO/c+8lKIagX189KkUh/6lrEHfrTYvGJtr7pu/oe1weqlZrWwOuywjROIFsO7OJwyUtRvl2vJ0qDjm7A98H5ZYMWR7dkrIA9zZsgLg92ZU7NYOF1H+6MBewTJpvT81qsvbdlzfg30jKrLozTW/sXkrBc9tA6ws1Nv2JopLwZ883LI1OMSk6foZ8lxn2s/EO25RWavheOWRVMXQGoHPiioX6t0XwXpaI/Hq3cGse4ASTFICIBMD7UC4MrbC+uMwqRf7v+2oy4Qx9Yyx7dybOSyMPu/QqYCH//NU/mivpS32+dgb05gEom2zdWjsBET0EIZ9o+tFXPgOC10W+gfjoNbAH8es/3DDrgsNDsWcKr7gHugFXIeqzt9POjD8qy6SVwMC+x71+LYly4VJO1oaD9aWVjpLzBKJNeh68SOxXmQtEJuQgyLy0jPDUhmsZexH6myjO4HSsvIKaCyFd7opCSBz7JSzM0o9GTtki0XdSdnme
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(376002)(39860400002)(8936002)(5660300002)(9686003)(2906002)(83380400001)(82960400001)(86362001)(478600001)(38100700002)(110136005)(6486002)(66476007)(66556008)(66946007)(316002)(186003)(4326008)(8676002)(6506007)(41300700001)(6512007)(26005)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QmFAoAAYivGP7Jc3iuK16KBvDetwGWGY5jusKPd4IU7WkL+tGyoshKiAwmBl?=
 =?us-ascii?Q?0KPOx2bQZFZw7YuCfKE1q4QYnA0L6jyANxiyH9UmzBEYXnkwJY2Etj/XSgGb?=
 =?us-ascii?Q?WO6pkTo2nAZqNndvANEnGCuCWVSWrBGATPS/oH+kd020z1l//gxETpQPLcqJ?=
 =?us-ascii?Q?f69CAmB6aeNSu1+1+44OyxVcXiAN/pShyfi59hWuvQqDAiYpaAZotRNC4ByE?=
 =?us-ascii?Q?tQTChqwoBvJyoXRe2MS+Z0npdiz8LtvKe+Rhmpl4bdb8OgsyWwN3AblCWKPp?=
 =?us-ascii?Q?QwZo0CEVRhTMuYlHlq+WEjojq20T/OWK70JPaNtRf5uWCOyGfLlBlrADDnrk?=
 =?us-ascii?Q?TFdGtGLUrEdh/ViXkXXOGhQ1v0xnH8Vk+ffVIKgLY2eeYvKwltKBLV3iintw?=
 =?us-ascii?Q?vMYDB/mvcljeq1qiln8OjMEnDAmZhdOgv131N57UKx5qAxveCbA56ReZgv+r?=
 =?us-ascii?Q?62VWI6pXRQbd6P8/ytMhLVjwXnRtAlyR53hImJiHPutZUYkBXiaGHj0g0cwl?=
 =?us-ascii?Q?E/qM7gYy7CPU16e8Sbx/R6h+RujO16j4xRrOd1l3XG1bzQoWIHSyP+xUqrCK?=
 =?us-ascii?Q?qOWsseHSc01CDDiPJ7VCryLMsytKm6JpK7b4BpzVNalwgkpj+UVgnhJGFpfi?=
 =?us-ascii?Q?dUg9r8EMrlEPCqDRWTXm9X5dIjiUZ/a41qjS4bEGOUS0hNmJr8Q8hutyehDt?=
 =?us-ascii?Q?G5ykDuWauoOTbn1uh3IpdSwn6mjw+w1WOBFJwLvPAUDjMbhM38TO/FfRUDtj?=
 =?us-ascii?Q?ez5HGFy/hVAos69st1WNGPROGS8gjC5kUcNtsXIO6/85Vb13aX5wwxLRcd6T?=
 =?us-ascii?Q?E+1uleRZ6xl0jzP8mTgfyAVDYK1/wtSiCIIQkLX0JqUp7T08nHAqSnjTOMSc?=
 =?us-ascii?Q?hRBIo88Ctcjpj3eCouf79GLNbwaClztmrhW0jgw8K8SmgK/8K1cySFPmYxty?=
 =?us-ascii?Q?x2exJ+xtT10+qRciOxIywN0PbWU4F2WsQQRJw3yy1tne1qT5vk9CIC+nLzs8?=
 =?us-ascii?Q?murTVOPc/KQkdHpJhloJMiogw8Oa9mv7Pl+TeqeuP5CHVTnwtvcDdu5XyrX9?=
 =?us-ascii?Q?tkjaC+bDBtgDl5pQIutpxsiCE0xikkyWBuFwNlBSX+nJASO+UZx2FQObkqA2?=
 =?us-ascii?Q?R/Y4wYx256R74RhkqABapXBCOeouxIMZKsAaplbU1Jrk3Rgy7Bsq1ggjG60o?=
 =?us-ascii?Q?h0JmX3Poy5D993LtLKQIlSmQQP5BvI8b3Ikxx3AX4gxmlvsYRxbQvsin6jjU?=
 =?us-ascii?Q?xLe89Mfu+ODuUF2lig64LFd1c7lfEVIOVrutDG7HZLafgMYGXcCbCHerC2gK?=
 =?us-ascii?Q?dVWeONptdJzZ539+I/Tqagte6CGDlvoGkq3CulwFUZ44EtT6ZeITCNgWD9bH?=
 =?us-ascii?Q?UbgIUul37BjrCZd6XuiCiSsz7uLx7+Yf7cj74ZWKwGYDUGZAcVwfAROqO0VE?=
 =?us-ascii?Q?xQTq7wmXNE5x3/81kVzS68TRcxZmfIn0GbpmFD2sErHr7VG3vMCDl5K2VmG0?=
 =?us-ascii?Q?tk3L4aiUiIufBOm8wvO1PxBIaY2L+qrYqlMfkXdaf1BoiFHIdc2Gc2dJNNvC?=
 =?us-ascii?Q?N5mk0TFqDfEVEsOO1nIKhYqEFSpxHWwox7v+i/wmksmggLJ+2ITUSQb7nWcy?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da44d5ec-8743-4fcc-77cb-08da62a747f4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 19:06:23.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 044+8ZS8fgtVvdY4h2imxiq81t8GMKTLOqXNPEpHC3FvA0KSkOCG771eMiR/m6YSlMlulaUGJbLBOtIdebFLvfJs3dz4dNSrt9ewzQ4k8HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4291
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
> On Thu, 23 Jun 2022 21:19:32 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Reduce the complexity and the overhead of walking the topology to
> > determine endpoint connectivity to root decoder interleave
> > configurations.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Hi Dan,
> 
> A few minor comments inline around naming and also one query on why
> the refactor or reap_ports is connected to the xarray change.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/cxl/acpi.c      |  2 +-
> >  drivers/cxl/core/hdm.c  |  6 ++-
> >  drivers/cxl/core/port.c | 88 ++++++++++++++++++-----------------------
> >  drivers/cxl/cxl.h       | 12 +++---
> >  4 files changed, 51 insertions(+), 57 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 09fe92177d03..92ad1f359faf 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -197,7 +197,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >  	if (!bridge)
> >  		return 0;
> >  
> > -	dport = cxl_find_dport_by_dev(root_port, match);
> > +	dport = cxl_dport_load(root_port, match);
> 
> Load is kind of specific to the xarray.  I'd be tempted to keep it to
> original find naming.

ok.

> 
> 
> >  	if (!dport) {
> >  		dev_dbg(host, "host bridge expected and not found\n");
> >  		return 0;
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index c0164f9b2195..672bf3e97811 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -50,8 +50,9 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
> >  {
> >  	struct cxl_switch_decoder *cxlsd;
> > -	struct cxl_dport *dport;
> > +	struct cxl_dport *dport = NULL;
> >  	int single_port_map[1];
> > +	unsigned long index;
> >  
> >  	cxlsd = cxl_switch_decoder_alloc(port, 1);
> >  	if (IS_ERR(cxlsd))
> > @@ -59,7 +60,8 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
> >  
> >  	device_lock_assert(&port->dev);
> >  
> > -	dport = list_first_entry(&port->dports, typeof(*dport), list);
> > +	xa_for_each(&port->dports, index, dport)
> > +		break;
> >  	single_port_map[0] = dport->port_id;
> >  
> >  	return add_hdm_decoder(port, &cxlsd->cxld, single_port_map);
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index ea3ab9baf232..d2f6898940fa 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -452,6 +452,7 @@ static void cxl_port_release(struct device *dev)
> >  	xa_for_each(&port->endpoints, index, ep)
> >  		cxl_ep_remove(port, ep);
> >  	xa_destroy(&port->endpoints);
> > +	xa_destroy(&port->dports);
> >  	ida_free(&cxl_port_ida, port->id);
> >  	kfree(port);
> >  }
> > @@ -566,7 +567,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
> >  	port->component_reg_phys = component_reg_phys;
> >  	ida_init(&port->decoder_ida);
> >  	port->dpa_end = -1;
> > -	INIT_LIST_HEAD(&port->dports);
> > +	xa_init(&port->dports);
> >  	xa_init(&port->endpoints);
> >  
> >  	device_initialize(dev);
> > @@ -696,17 +697,13 @@ static int match_root_child(struct device *dev, const void *match)
> >  		return 0;
> >  
> >  	port = to_cxl_port(dev);
> > -	device_lock(dev);
> > -	list_for_each_entry(dport, &port->dports, list) {
> > -		iter = match;
> > -		while (iter) {
> > -			if (iter == dport->dport)
> > -				goto out;
> > -			iter = iter->parent;
> > -		}
> > +	iter = match;
> > +	while (iter) {
> > +		dport = cxl_dport_load(port, iter);
> > +		if (dport)
> > +			break;
> > +		iter = iter->parent;
> >  	}
> > -out:
> > -	device_unlock(dev);
> >  
> >  	return !!iter;
> >  }
> > @@ -730,9 +727,10 @@ EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
> >  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
> >  {
> >  	struct cxl_dport *dport;
> > +	unsigned long index;
> >  
> >  	device_lock_assert(&port->dev);
> > -	list_for_each_entry (dport, &port->dports, list)
> > +	xa_for_each(&port->dports, index, dport)
> >  		if (dport->port_id == id)
> >  			return dport;
> >  	return NULL;
> > @@ -741,18 +739,21 @@ static struct cxl_dport *find_dport(struct cxl_port *port, int id)
> >  static int add_dport(struct cxl_port *port, struct cxl_dport *new)
> >  {
> >  	struct cxl_dport *dup;
> > +	int rc;
> >  
> >  	device_lock_assert(&port->dev);
> >  	dup = find_dport(port, new->port_id);
> > -	if (dup)
> > +	if (dup) {
> >  		dev_err(&port->dev,
> >  			"unable to add dport%d-%s non-unique port id (%s)\n",
> >  			new->port_id, dev_name(new->dport),
> >  			dev_name(dup->dport));
> > -	else
> > -		list_add_tail(&new->list, &port->dports);
> > +		rc = -EBUSY;
> 
> Direct return slightly simpler and reduce indent on next bit plus makes
> this more obviously an 'error condition' by indenting it.

Looks good, yes.

> 
> > +	} else
> > +		rc = xa_insert(&port->dports, (unsigned long)new->dport, new,
> > +			       GFP_KERNEL);
> >  
> > -	return dup ? -EEXIST : 0;
> > +	return rc;
> >  }
> >  
> >  /*
> > @@ -779,10 +780,8 @@ static void cxl_dport_remove(void *data)
> >  	struct cxl_dport *dport = data;
> >  	struct cxl_port *port = dport->port;
> >  
> > +	xa_erase(&port->dports, (unsigned long) dport->dport);
> >  	put_device(dport->dport);
> > -	cond_cxl_root_lock(port);
> > -	list_del(&dport->list);
> > -	cond_cxl_root_unlock(port);
> >  }
> >  
> >  static void cxl_dport_unlink(void *data)
> > @@ -834,7 +833,6 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
> >  	if (!dport)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > -	INIT_LIST_HEAD(&dport->list);
> >  	dport->dport = dport_dev;
> >  	dport->port_id = port_id;
> >  	dport->component_reg_phys = component_reg_phys;
> > @@ -925,7 +923,7 @@ static int match_port_by_dport(struct device *dev, const void *data)
> >  		return 0;
> >  
> >  	port = to_cxl_port(dev);
> > -	dport = cxl_find_dport_by_dev(port, ctx->dport_dev);
> > +	dport = cxl_dport_load(port, ctx->dport_dev);
> >  	if (ctx->dport)
> >  		*ctx->dport = dport;
> >  	return dport != NULL;
> > @@ -1025,19 +1023,27 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, CXL);
> >   * for a port to be unregistered is when all memdevs beneath that port have gone
> >   * through ->remove(). This "bottom-up" removal selectively removes individual
> >   * child ports manually. This depends on devm_cxl_add_port() to not change is
> > - * devm action registration order.
> > + * devm action registration order, and for dports to have already been
> > + * destroyed by reap_dports().
> >   */
> > -static void delete_switch_port(struct cxl_port *port, struct list_head *dports)
> > +static void delete_switch_port(struct cxl_port *port)
> > +{
> > +	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
> > +	devm_release_action(port->dev.parent, unregister_port, port);
> > +}
> > +
> > +static void reap_dports(struct cxl_port *port)
> >  {
> > -	struct cxl_dport *dport, *_d;
> > +	struct cxl_dport *dport;
> > +	unsigned long index;
> > +
> > +	device_lock_assert(&port->dev);
> >  
> > -	list_for_each_entry_safe(dport, _d, dports, list) {
> > +	xa_for_each(&port->dports, index, dport) {
> >  		devm_release_action(&port->dev, cxl_dport_unlink, dport);
> >  		devm_release_action(&port->dev, cxl_dport_remove, dport);
> >  		devm_kfree(&port->dev, dport);
> >  	}
> > -	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
> > -	devm_release_action(port->dev.parent, unregister_port, port);
> >  }
> >  
> >  static struct cxl_ep *cxl_ep_load(struct cxl_port *port,
> > @@ -1054,8 +1060,8 @@ static void cxl_detach_ep(void *data)
> >  	for (iter = &cxlmd->dev; iter; iter = grandparent(iter)) {
> >  		struct device *dport_dev = grandparent(iter);
> >  		struct cxl_port *port, *parent_port;
> > -		LIST_HEAD(reap_dports);
> >  		struct cxl_ep *ep;
> > +		bool died = false;
> >  
> >  		if (!dport_dev)
> >  			break;
> > @@ -1095,15 +1101,16 @@ static void cxl_detach_ep(void *data)
> >  			 * enumerated port. Block new cxl_add_ep() and garbage
> >  			 * collect the port.
> >  			 */
> > +			died = true;
> >  			port->dead = true;
> > -			list_splice_init(&port->dports, &reap_dports);
> > +			reap_dports(port);
> 
> I'm not immediately clear on why this refactor is tied up with moving
> to the xarray.  Perhaps a comment in the commit message to add
> more detail around this?

Sure, added the following:

   Note that cxl_detach_ep(), after it determines that the last @ep has
   departed and decides to delete the port, now needs to walk the dport
   array with the device_lock() held to remove entries. Previously
   list_splice_init() could be used atomically delete all dport entries at
   once and then perform entry tear down outside the lock. There is no
   list_splice_init() equivalent for the xarray.
