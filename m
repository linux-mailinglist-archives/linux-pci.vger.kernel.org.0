Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65AD56CC5E
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 04:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGJCVD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 22:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJCVC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 22:21:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D224941;
        Sat,  9 Jul 2022 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657419661; x=1688955661;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Llb1rRlo1JMZVPqluF+p//2sZJ1jzENaEkP+Hviv+mc=;
  b=R2tzUMTI9BIXQo6bXQhdCZTUXuLdDkS7XHGeIGy2Of7IVG/FA8Co1sav
   L/8yDP00mctyeaw/xBz4SQH4UNI8Rg5gHe/KKdZ4T3rqV2CfNuxrV5QMm
   zZy9ytRCGBz7BG5MCYONYstU0vA3Wk/pGFew9R2zVB+7Z/28AnYjAX1lY
   sIUnfZjDLVlsTTc1Cl48GhrHaWPUbsgXFbwvc0BS1gw80ovtVy0G0h9+v
   2wya78lm9n/fy+eV9cygy8Uur4cU87Bw0STAg/TUl9lRM7eB12l0i7Fkt
   IFcTrY+695tP0f8bXgnwiFy/fhCGr/RNmM+W2a9EBaNj6nbPnitJpkK0Y
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="310070347"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="310070347"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 19:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="621672820"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 09 Jul 2022 19:21:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 19:21:00 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 19:21:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 9 Jul 2022 19:21:00 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 9 Jul 2022 19:21:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjYPmrM9xmx6ifCuyACNHU7Utqms8zNfItSNy65ecQIwf7CthhiV6BGbZsKUIQ0biXw6/7N4HvX4zWvBsL00/l+HoHsHnBz6XkgPYEsfaakNLwP9vscHkpsOrIyrXjy9INmhHNaG7R0zhvRrwvqUsb00S1afksVh87eE+PBgsqF6knTRsR3Kyi1vR1KNqpimCDSEaXy/hBiC6D5G+vThAAJ6RNSpxkjqbiZ0cnX6+VU2uPLRxN15YKDeJeEeuElxH4a17rYLZz7+TaAJd0fQkY8tEWGQOWI3LnRQAhrXAWgn9Ivh8WbuA6K8cflHM2IsvMvsZzu9Ow0et/gRO3ufCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85lEATN30emNPEhGULvIlHwKVA0DB02oBoRq2pEud1E=;
 b=ap2QoZ99A/gaIoVvWyq6OHIioQcRcjeS0UqUG6Ew/ZqhXe/Kb/ttFsUMVAb16Kq50vmuti5wnYazexgPY/KPX8Y0NWBp3OGrOhIXJgPWTw3HgQeQjwrAtuux5XErxUVjuAaHO/4TyxaPqFzKTczUKmG/KiwXxeohm9K6UKGSt4x8xmD5QbNpwZhAF1QDcjP18A/ui1tsSI9G4ERbIs0AYxbMehjRZ1mcin/lvP1KFlvCwZToi1fPfVgE7VLenp8R/mQ/OLFZ1D/lRlHhObxTF9fP1O8NJUfM/BtCVfU5MtCyGyB4X2qrWDC1VFYDh7ClrFqAaZO0363MJkQzpOFkvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH0PR11MB5128.namprd11.prod.outlook.com
 (2603:10b6:510:39::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sun, 10 Jul
 2022 02:20:58 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.021; Sun, 10 Jul
 2022 02:20:58 +0000
Date:   Sat, 9 Jul 2022 19:20:56 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 10/46] cxl/core: Define a 'struct cxl_root_decoder' for
 tracking CXL window resources
Message-ID: <62ca37888d9a4_2da5bd2942@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603877351.551046.12325060612893557716.stgit@dwillia2-xfh>
 <20220628174955.00005a53@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628174955.00005a53@Huawei.com>
X-ClientProxiedBy: MW3PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:303:2a::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b1ffc1e-07ad-46d0-fd12-08da621ad377
X-MS-TrafficTypeDiagnostic: PH0PR11MB5128:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiGyozjWNCodKYzXtenVToJNVFO3w58sDeFzA3F0PX/UjhNQPZ6iCbfxGYAuPLrbCsGhiEaEtGOw6c2hSx0XpyJSmoo9dxSNouMxNgkoyfnEyn9r06eGwHf0fwwY78p+kMy9S71zaCrTY0zYcDvitY/AKMatLimfroYFaHpsDVDMIOvim41qK61xY1gZiCVnSEERpGcHhDItiqI/YGAVqVRNLsBEcUzGzEFd/aJ/7FPj79ppyS3M8VhSHijKSFHd3D7beD9xKiZ41bD1BHwdL4VN6R5e6n1qi08ZHpJPLv5olTnENarUYqGl4wemPphiscwA4FAzSLannbFKX4PQwFYCGbFtD7giwImgKKPzGK2Kq90SJocIEI3ZXfKg5KR85bJtbw4LLLqI+GdVmSTBoC9Vh1Si0PK3LjD2KK4yNLIuGI/clXubFlJ1BRWo83MhNVQDlkyzn9plESMs5aAcqjvq5BT0fUBhMakM9xXt3nk/noi0VIblIxG2cW2NQrVmfRzKqGI9aYJUQMRa08LSCZVY+UXIGRi4wGWEIkZUeHt82rwu05h50vUiX3rcJzsKCOk5GKac9ITmH+eChITmU2LMTr3I7LXeDgGqUYZFCmxGqG+FTK0ywjZ8N6ply0SMChDqnMk9k9YZ5U1aMu0XA+81CcVl7da9H1iU/fqOO14WCoghf6xwxr3BF7gy+V5Z9SORmt/z+2qvZyEyuWY02tU4eCJuT3DiBCpY52V47ud0NAy5McRqVJfm8lMSGWBafa5q2gYxLALYkQ235/ieUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(376002)(396003)(366004)(66476007)(186003)(110136005)(4326008)(66946007)(8676002)(82960400001)(83380400001)(38100700002)(316002)(66556008)(2906002)(8936002)(41300700001)(6486002)(478600001)(6506007)(86362001)(26005)(9686003)(6512007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YO3XwsCWRQ9+rVAI+HyaLmKO3dQinrMWsoQfOEl0kEVJgTEP2OmwvCsnSr2z?=
 =?us-ascii?Q?SCfBsL31KbG8z8wYoxllKyqeSkx37pd/Aa/qQtPEQBfx9B3XFuLzqmQrv2Ym?=
 =?us-ascii?Q?gxMSd3JZq6cvFFQTXVXMt7jpgC+zohdcyz5nHVISI0qjWXjtihuSO060wSBd?=
 =?us-ascii?Q?RVv7hAFQJVnp1wvBpji6Rzq95lwqZuwxQznw2ejHyN7FFKAsAdKaKH03BVr5?=
 =?us-ascii?Q?Sz41o61/k4AY3UFMkO6hsOq2JRLuvgLY/MBythex4g9nZgU292QXqYP7vmrG?=
 =?us-ascii?Q?tQRNDwzLiiDWV57j6f9fLQ/KtEsSETx6lGSb2QRbXFTIe7/qIYEkO4GrU2Tr?=
 =?us-ascii?Q?xCtMGC3+SAv2U2Ojqil5GVsA3AzUrXKCL05KxxP1DRdIGMO4lVvMaGNmiAxA?=
 =?us-ascii?Q?czoYtE7RxVrxoqcQb2VadE3EmL25Dc0xK+KMGiNTeOxpleL834LuZ41vGgmb?=
 =?us-ascii?Q?ncNcIyy+pNbtIMq1PtrIe89/wpiGmLmRPHqymGlc66phbUeHIBGn9rWvB26r?=
 =?us-ascii?Q?xd6JmOwJt3cCDUJe7PUEyyM8yV2bCyiNNnvmQ6NhWeFUa4mVKtlJjjL3dHEZ?=
 =?us-ascii?Q?QSSf5oMb/1RZMKV1D0eEig6itWOP6H7hq9EWv/uSj7CatnR1EOMghGfslwqo?=
 =?us-ascii?Q?UdX3CD7pE6Xqm96KjFI661YQOQi0k45k2yYWXQaxzx+i8NAkcIlKr4j1LuS5?=
 =?us-ascii?Q?PnfVE/OsR8VGTJO3BBCQIMGCS3KkMcQelFR6M1zZwbNOD7KprMl5PQbZ7jjk?=
 =?us-ascii?Q?rNRUQ4MqVDaePvYP0rMyxuAJNFBq0qAwN9orzKTeIK/0Im3xJA3/EZhtn1Yq?=
 =?us-ascii?Q?t+pbHCPJUO3w2P3C0SZjas3zNklF37H8quOF5zdl0sqoFQ5qPp5Kxv8dHjtR?=
 =?us-ascii?Q?MmMZp8ogQuBVwGWGd/vw7N/KY2NxTar3bBl9VhGHDLlvgil9leZMXNzjxPAy?=
 =?us-ascii?Q?VuIhCjhp1Hy26ksq+HzUkvQ4mzZPRqD1uOaVUlxs6lF/daA23a0zcNtrjReA?=
 =?us-ascii?Q?h9Gsz0RDdsRirmpw+3mpwxTjVIAFNrWF5Fc36iC0Z1VIkl2+7WwX97LdsDy/?=
 =?us-ascii?Q?AsRDa2TSXlZQcqGEG3qonhExurZMfheV/s0IBCEywLu0P+fm5jey02Uqoi7G?=
 =?us-ascii?Q?/RKxhNW1zx5wDgN6hdR2quK12U/OQUQoNJnXKaQsG/aLyzzMY3UYFHt90XTX?=
 =?us-ascii?Q?oBJ/P5ES0xE4WYnPzANJqF9pljlvW3QJ+D/OsWNidTI+yB8DmG3z4nxt61tT?=
 =?us-ascii?Q?ehtJZ7ULvg1rC/hOgBCvO5wd+1Ne+5wtTrRhNvJGJnFXnPUCew25BAhWwWYz?=
 =?us-ascii?Q?se2101IzC0Sq9EP5o2UDAH5gdi9Z/e0GpDjUG43c3LAzTFoDBuhFZxX6D7Xf?=
 =?us-ascii?Q?9n9EZJe6GTqdqz9KgOmtE8poatWMvMmmZXALoWAfLeasUYwBe6THa51/BYxD?=
 =?us-ascii?Q?yhwFi9m0BJjTdkgnk+C5kLR5CuAQ9Gc08KvcdCVwVoPMWqvZ+SxyWrX3P15L?=
 =?us-ascii?Q?/8XjCbqhL4ZPxDZISju6SdUj2/QSMqa7Ayk+aeIHMBVb8TggFP2D2+La3v1H?=
 =?us-ascii?Q?g2U23031moHMAFOF3bcztEHXYPobYf0OJoH9HidedObGeKW+joiDQtoOVVzP?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1ffc1e-07ad-46d0-fd12-08da621ad377
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 02:20:58.4436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2j5ePL5iJNUeZDC1wGid8/2FgR3S56NwwsL/omFNkJiFX13TqxQQn6tb/p4mVH0OfE0xzZ0OKwqugMy9PAEciQ5uKFjW7aSi+XeuWqnXHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 19:46:13 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Previously the target routing specifics of switch decoders were factored
> > out of 'struct cxl_decoder' into 'struct cxl_switch_decoder'.
> > 
> > This patch, 2 of 3, adds a 'struct cxl_root_decoder' as a superset of a
> > switch decoder that also track the associated CXL window platform
> > resource.
> > 
> > Note that the reason the resource for a given root decoder needs to be
> > looked up after the fact (i.e. after cxl_parse_cfmws() and
> > add_cxl_resource()) is because add_cxl_resource() may have merged CXL
> > windows in order to keep them at the top of the resource tree / decode
> > hierarchy.
> 
> One trivial comment below that follows from earlier patch.
> 
> Otherwise, I'll look again at this when I understand what the constraints
> of CXL windows are that you are dealing with.  I don't get why they might not
> be at the top of the resource tree without the merging!
> 
> > 
> > Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/acpi.c      |   40 ++++++++++++++++++++++++++++++++++++----
> >  drivers/cxl/core/port.c |   43 +++++++++++++++++++++++++++++++++++++------
> >  drivers/cxl/cxl.h       |   15 +++++++++++++--
> >  3 files changed, 86 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 003fa4fde357..5972f380cdf2 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -82,7 +82,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >  	int target_map[CXL_DECODER_MAX_INTERLEAVE];
> >  	struct cxl_cfmws_context *ctx = arg;
> >  	struct cxl_port *root_port = ctx->root_port;
> > -	struct cxl_switch_decoder *cxlsd;
> > +	struct cxl_root_decoder *cxlrd;
> >  	struct device *dev = ctx->dev;
> >  	struct acpi_cedt_cfmws *cfmws;
> >  	struct resource *cxl_res;
> > @@ -128,11 +128,11 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >  	if (rc)
> >  		goto err_insert;
> >  
> > -	cxlsd = cxl_root_decoder_alloc(root_port, ways);
> > -	if (IS_ERR(cxld))
> > +	cxlrd = cxl_root_decoder_alloc(root_port, ways);
> > +	if (IS_ERR(cxlrd))
> >  		return 0;
> >  
> > -	cxld = &cxlsd->cxld;
> > +	cxld = &cxlrd->cxlsd.cxld;
> >  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> >  	cxld->target_type = CXL_DECODER_EXPANDER;
> >  	cxld->hpa_range = (struct range) {
> > @@ -375,6 +375,32 @@ static int add_cxl_resources(struct resource *cxl)
> >  	return 0;
> >  }
> >  
> > +static int pair_cxl_resource(struct device *dev, void *data)
> > +{
> > +	struct resource *cxl_res = data;
> > +	struct resource *p;
> > +
> > +	if (!is_root_decoder(dev))
> > +		return 0;
> > +
> > +	for (p = cxl_res->child; p; p = p->sibling) {
> > +		struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> > +		struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> > +		struct resource res = {
> > +			.start = cxld->hpa_range.start,
> > +			.end = cxld->hpa_range.end,
> > +			.flags = IORESOURCE_MEM,
> > +		};
> > +
> > +		if (resource_contains(p, &res)) {
> > +			cxlrd->res = (struct resource *)p->desc;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_acpi_probe(struct platform_device *pdev)
> >  {
> >  	int rc;
> > @@ -425,6 +451,12 @@ static int cxl_acpi_probe(struct platform_device *pdev)
> >  	if (rc)
> >  		return rc;
> >  
> > +	/*
> > +	 * Populate the root decoders with their related iomem resource,
> > +	 * if present
> > +	 */
> > +	device_for_each_child(&root_port->dev, cxl_res, pair_cxl_resource);
> > +
> >  	/*
> >  	 * Root level scanned with host-bridge as dports, now scan host-bridges
> >  	 * for their role as CXL uports to their CXL-capable PCIe Root Ports.
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index fd1cac13cd2e..abf3455c4eff 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -259,6 +259,23 @@ static void cxl_switch_decoder_release(struct device *dev)
> >  	kfree(cxlsd);
> >  }
> >  
> > +struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev)
> > +{
> > +	if (dev_WARN_ONCE(dev, !is_root_decoder(dev),
> > +			  "not a cxl_root_decoder device\n"))
> > +		return NULL;
> > +	return container_of(dev, struct cxl_root_decoder, cxlsd.cxld.dev);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(to_cxl_root_decoder, CXL);
> > +
> > +static void cxl_root_decoder_release(struct device *dev)
> > +{
> > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> > +
> > +	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
> > +	kfree(cxlrd);
> > +}
> > +
> >  static const struct device_type cxl_decoder_endpoint_type = {
> >  	.name = "cxl_decoder_endpoint",
> >  	.release = cxl_decoder_release,
> > @@ -273,7 +290,7 @@ static const struct device_type cxl_decoder_switch_type = {
> >  
> >  static const struct device_type cxl_decoder_root_type = {
> >  	.name = "cxl_decoder_root",
> > -	.release = cxl_switch_decoder_release,
> > +	.release = cxl_root_decoder_release,
> >  	.groups = cxl_decoder_root_attribute_groups,
> >  };
> >  
> > @@ -1218,9 +1235,23 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> >  
> >  	if (nr_targets) {
> >  		struct cxl_switch_decoder *cxlsd;
> > +		struct cxl_root_decoder *cxlrd;
> > +
> > +		if (is_cxl_root(port)) {
> > +			alloc = kzalloc(struct_size(cxlrd, cxlsd.target,
> > +						    nr_targets),
> > +					GFP_KERNEL);
> > +			cxlrd = alloc;
> > +			if (cxlrd)
> > +				cxlsd = &cxlrd->cxlsd;
> > +			else
> > +				cxlsd = NULL;
> > +		} else {
> > +			alloc = kzalloc(struct_size(cxlsd, target, nr_targets),
> > +					GFP_KERNEL);
> > +			cxlsd = alloc;
> 
> As earlier, I'd prefer you just handled errors when they happened rather than
> dancing onwards...

Yes, this gets cleaned up with moving the allocation to
cxl_root_decoder_alloc() directly.

> 
> > +		}
> >  
> > -		alloc = kzalloc(struct_size(cxlsd, target, nr_targets), GFP_KERNEL);
> > -		cxlsd = alloc;
> >  		if (cxlsd) {
> >  			cxlsd->nr_targets = nr_targets;
> >  			seqlock_init(&cxlsd->target_lock);
> > @@ -1279,8 +1310,8 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> >   * firmware description of CXL resources into a CXL standard decode
> >   * topology.
> >   */
> > -struct cxl_switch_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> > -						  unsigned int nr_targets)
> > +struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> > +						unsigned int nr_targets)
> >  {
> >  	struct cxl_decoder *cxld;
> >  
> > @@ -1290,7 +1321,7 @@ struct cxl_switch_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> >  	cxld = cxl_decoder_alloc(port, nr_targets);
> >  	if (IS_ERR(cxld))
> >  		return ERR_CAST(cxld);
> > -	return to_cxl_switch_decoder(&cxld->dev);
> > +	return to_cxl_root_decoder(&cxld->dev);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
> >  
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 7525b55b11bb..6dd1e4c57a67 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -253,6 +253,16 @@ struct cxl_switch_decoder {
> >  	struct cxl_dport *target[];
> >  };
> >  
> > +/**
> > + * struct cxl_root_decoder - Static platform CXL address decoder
> > + * @res: host / parent resource for region allocations
> > + * @cxlsd: base cxl switch decoder
> > + */
> > +struct cxl_root_decoder {
> > +	struct resource *res;
> > +	struct cxl_switch_decoder cxlsd;
> 
> Could be nice to those container of macros and just put the cxlsd first.

Not possible. @cxlsd needs to be the last attribute because it has a
variably sized flex-array at its end.
