Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5550856CC16
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 02:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiGJAdi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 20:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJAdh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 20:33:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC7F2606;
        Sat,  9 Jul 2022 17:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657413216; x=1688949216;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Zvf+u5A3UwGruXI5VCMLsau/jkURIWfgJNc/DjeM2Js=;
  b=mRJyP7taqtsE6AneVIjV20Uv40M/gs+iZXANJIP99zgbxUOu1/Sgfik1
   r/RsCg5ms7LmsSgY5f3VCTzKkSgyvw7Pvbm1wpFM2jprdZXr0F2w4R/Zo
   gvcDEH5htXeGfWqRxSa2OBDhRVGMJ+cvkb7kUyBt6mY6AusUaHWd/+hP7
   PpYu0LvcSeqpR8Mtx83u9Zbo0DoyJZi0z7qXpL41SBiVkKfdh6YEG3SWV
   7JehV/2r2+NnmGy+5A/pzRdu78uEQ9xuI4RUSOcClwiV/3uItd/2BBAUN
   q1i52eZ77CJnNUBB/0zCV6Gep0Yy7nvg0niGZ4LrJNKhA1MFZory+aXBS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="346154563"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="346154563"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 17:33:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="697239627"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2022 17:33:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 17:33:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 17:33:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 9 Jul 2022 17:33:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 9 Jul 2022 17:33:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE4xtrJpxHmpwvK5i/hFWvQcI902Pw23eGKFPYyy3gbBnYIfs8IYwnU1N5Oxqs5xaARgnRAVQs7HO5KFNxKrQsMBYQuMLaciLIP5/QCtNFOj1SFnRqAOVWiT9POW1hlXrb/601nmwN3sgsaEg7DAj72EPRnBSSycITxCbrakN5e1gq0nwBTNtMqPtt0oiXtgcGti9tkzudwRvP+zFEkJ9vUpErqiKEcSDQvf2lUayGpbijvAhdECzeLXgO6OGiNdFuO8J9C7frjTeptX4nHDmqGte2nhnozAVt/Jifh1s/+vzoHPLbyBisM2Q1NQhO0nk2Ng29VNMXkNQr0FTwHU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIf7Y2sBb+q2z1SyuJS2itpV3YttgHJn06IerbYy07k=;
 b=EY4wvTd0qhF5cxnxbyWlGyc8L82QOZ2q7dEfgtPBftYnHWNXdWVJrhMrjyEHhyT/X2L5NpR0Mk5dGtwyS1fITep6cJDtqJQwnye9maHwSdafkfkxTRf6suM0jAGA8I+oK2//a79lYTIzGrhjGZXKnJVOHe8QY5FDObokz5ro2erqWyvcxmXR1HtTKzrrfU0tD3O29sfn13n1jMOTmrxW9CpygR08s5oUZxRhUZZN58nIXtKOTdoq0kQLxRd4pwBgzy+0fqfaVs+P+H2WyYj+BpcYkT6BtS2d+5lqGDoGLSGBGXxepeirFAfZWtapzt/ghjswSLq7efCJYKcQ53ENmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY4PR11MB1895.namprd11.prod.outlook.com
 (2603:10b6:903:126::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Sun, 10 Jul
 2022 00:33:31 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.021; Sun, 10 Jul
 2022 00:33:31 +0000
Date:   Sat, 9 Jul 2022 17:33:28 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 08/46] cxl/core: Define a 'struct cxl_switch_decoder'
Message-ID: <62ca1e58cc9b4_2da5bd294ac@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603875762.551046.12872423961024324769.stgit@dwillia2-xfh>
 <20220628171204.00006ad4@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628171204.00006ad4@Huawei.com>
X-ClientProxiedBy: MWHPR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:300:13d::22) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea0ee380-c748-4a19-5aeb-08da620bd074
X-MS-TrafficTypeDiagnostic: CY4PR11MB1895:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jL0fwsQbqP7G40yiRNtp6a4N1UBX+Yj4Mjy2eb7IC9PTXROkO8dwqlQ5wz8yT8DO34mbtT+V11gj9S6Un+UNEViEqRuP9qFMtN70pcVoBYX3P7Wm9FlRXxkkw/aS8iEa4EkukeJ58lel1amCG+3BjY/Z1b22aWESJS6UcKbDQdoMsEXGUfUplcevsgRcOeDMRqvAjrukqxcXJUm3QBKu+OPgoXYRjgAgtK3scvFcPZPF4+k3gDF+2HOpcY/sf7ByYV4TWJTAN0kO3Tf5RwOT3dSz0P6ubZRCRxfZmZ3GgADvAA0nmoIL/zO5IQ/ccVpYs/L1cgW9Td4aNqkK9FhzwJBj2nRlG1xgZj5CW+3Y6VsQu9v++VFnDwd+tdVs1TeJaNXOktYOtEvskAQu7SzHABXYVQu7CJN5iA6Or8dFKBUQEGL7HfNkCeYKw1iZirlo6N2mZ2RgoTXiiGcIVhcYZG6SaNeMIq5iigAA9H0K4s5X5ddxflZEMtDbpAibpjV4yKU7+AEJPaTqmkKap2ZRjoyN1xTrPQ1aVlm1HQFB6aADtR4yns8fAQhi8KqLZf0RS3+LAU8Irme9Ow8wxhYd4Y9BmEtpVo5/PYEkuzPliLJLyJBoJsDDmSkDITeEnnxiMTkJGGv9f6pxEO+SV9JePkJHA+4icZNSpggOAAmtf64uSWCJ3LnL4F6+6TXhld6bYklt4bjZSQ0cf0H5bewyPXsUD+UaF06BrlApKz0Oeewhq2sP3rTy5J+kTKkOK+SnkcjwEgo3IojauM2G9Hsf3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(136003)(376002)(346002)(30864003)(4326008)(8676002)(186003)(5660300002)(83380400001)(2906002)(38100700002)(8936002)(6506007)(26005)(6512007)(9686003)(478600001)(316002)(110136005)(86362001)(41300700001)(6486002)(82960400001)(66946007)(6666004)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QpW8KgtT2tTUv0sTuwfwpbRithTRqQSx1kEvHHHmjPxaM0ACx5US1jHSD20o?=
 =?us-ascii?Q?oxPN4oO16YEeqtRw7OtpNM/CE8twzIFwk2HGf2aa935VIeGQmf4QwbPV5rXG?=
 =?us-ascii?Q?UyaqFhwubxnTeu9B/uMXl8DZ9OdoMnKgu0HmXpbgWlWbALLSgnlFpMqvLR3+?=
 =?us-ascii?Q?8K4vo+8m3ahPTA0H6WNyhMu3N9KmyTvlrEfDNN/xtBxiVEmg8nhPd4XS8KCh?=
 =?us-ascii?Q?DuIDaR2ih8sSW5T507TdCkw5Jm4ZOyvU1Ef9qCcSopwvgRyU3LWNWVBcMY2F?=
 =?us-ascii?Q?EVarRSQ4YEcxX5eeNTZ+oyz3Vz057YxrQnAZquLBKxvcBShnIBhUa7pljeOn?=
 =?us-ascii?Q?fDNOBYJT9jwVJbDL8ZWMCv8ho0+MZ7zp4pN95z02O+5+0vw5/4i6+FPKeZ3A?=
 =?us-ascii?Q?tTnPDHl9pnENEUyT9x8ZoyE6l9qAyTwGl2oJ9N1xzbURwiHkcRvRoYR4Jncw?=
 =?us-ascii?Q?3mO4GeoA7yZNzcFQooKmWhyDn78S68+ok2E+s2VithHoK8E5/NXAV7E5lz2m?=
 =?us-ascii?Q?att9pto1KwEJu77+W+GclBSr8RR/m6bWmv81U6e29vM6GU5Hz4PV84pn9Ahn?=
 =?us-ascii?Q?nHpJycl71sUPeyO/s8y/6d9Su4V7w8gbyFhbIwxmSmGgcAlgl/3w53XiPZNI?=
 =?us-ascii?Q?TuxaKYqKXQbHQRqnLA7ZmktPkQhGtiQRp7JfoxBGuvjYXNgMLs+BlSnYy9Kh?=
 =?us-ascii?Q?exSofNOTHNTKTrqnhdtzJT3t4Yl3dSZI1agQDRTxeJWfoEfk9Nl+U9Ykvdpw?=
 =?us-ascii?Q?AUHik/whNr2sCi/dCH0v9N3oIgYFcBauJ/9WzGGSa+eJ66FPHs5hooMjYKFX?=
 =?us-ascii?Q?fS1xkN2BQGkKIJw2OlKAD3tj0ZT6aJssXAuk1Q4E7luzpxVLR4DBHWfLMlBa?=
 =?us-ascii?Q?JYlxodt23AMwvvOXzMfT+niG/VrjcQumlmy177NVzszUKw2KFB6BzW5d3/3O?=
 =?us-ascii?Q?Tcfdh/pqzu54RDJ+C4obh7Seq+72MQdEe/xHfKWTYd+6xZ18UzEtdGTCt75f?=
 =?us-ascii?Q?gYxdENfaaIXpVRDCV7oNvyHvmG/D4T1VyNksaigiYGWEujv62rI+udhENJZ6?=
 =?us-ascii?Q?NtMzoiVvjWOy+XRPQK9ypZ39bsy9nEXZD1Slhaup6nEkyPWfQtYunYFcwT+k?=
 =?us-ascii?Q?NZlovpq0FYyM20UxKlEnAkoIEG42F+jcUaL5qV1ZDsNaHw9d22PwsBGMUEwV?=
 =?us-ascii?Q?ma/qA4e5KjZk9oeNyronkH6yrrgtAjZ1HwZ+e5fG7ao5hvT2DBl5ge+SJ4xw?=
 =?us-ascii?Q?YNEnJEpCISQhLUuXTqAJ6NnBat2q9CJNLItGYezLIuDSYhmS9mEkgmINMzlZ?=
 =?us-ascii?Q?3H9oE/CbOVT/HAAv/IqC9QfFQaRXrnADPlaHxC2+OQNZUjsB5PkVXY3tmGA7?=
 =?us-ascii?Q?TZ67CYlhp449NWDFErL4Np5MVMudQURUbfq6T374r1IOw7f0QoS9gT/aDhcO?=
 =?us-ascii?Q?CSPuR/tENWxLTfN8zq05bNDuzJEYdPHMZTGRtnb9q0GbzAVabWve71P8qgZQ?=
 =?us-ascii?Q?KgxnPDN/y5NII2ul8UVQKN9v4qqKMLqB0MuCg9+VJihhbw+qEEQuH4qOhy76?=
 =?us-ascii?Q?vW4c47y4LeaBMxl8iIvnxy76H6eHRobA6IijA1xVjfmceNAVMHR6LMvTdvms?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0ee380-c748-4a19-5aeb-08da620bd074
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 00:33:31.0138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47Y3nNQSAxwtJs+ShvFUDuLTR0hvQLWUXWR8nptoWsOIei2vJgB6yn1HbUxXyF1J2isF/vRahzQjtnTHsokzW2zZyGOtfF7ZG0FDIlFerq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1895
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
> On Thu, 23 Jun 2022 19:45:57 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Currently 'struct cxl_decoder' contains the superset of attributes
> > needed for all decoder types. Before more type-specific attributes are
> > added to the common definition, reorganize 'struct cxl_decoder' into type
> > specific objects.
> > 
> > This patch, the first of three, factors out a cxl_switch_decoder type.
> > The 'switch' decoder type represents the decoder instances of cxl_port's
> > that route from the root of a CXL memory decode topology to the
> > endpoints. They come in two flavors, root-level decoders, statically
> > defined by platform firmware, and mid-level decoders, where
> > interleave-granularity, interleave-width, and the target list are
> > mutable.
> 
> I'd like to see this info on cxl_switch_decoder being used for
> switches AND other stuff as docs next to the definition. It confused
> me when looked directly at the resulting of applying this series
> and made more sense once I read to this patch.
> 
> > 
> > Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Basic idea is fine, but there are a few places where I think this is
> 'too clever' with error handling and it's worth duplicating a few
> error messages to keep the flow simpler.
> 
> Also, nice to drop the white space tweaks that have snuck in here.
> Particularly the wrong one ;)
> 
> 
> > ---
> >  drivers/cxl/acpi.c           |    4 +
> >  drivers/cxl/core/hdm.c       |   21 +++++---
> >  drivers/cxl/core/port.c      |  115 +++++++++++++++++++++++++++++++-----------
> >  drivers/cxl/cxl.h            |   27 ++++++----
> >  tools/testing/cxl/test/cxl.c |   12 +++-
> >  5 files changed, 128 insertions(+), 51 deletions(-)
> > 
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 46635105a1f1..2d1f3e6eebea 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> 
> 
> > @@ -226,8 +226,15 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
> >  
> >  		if (is_cxl_endpoint(port))
> >  			cxld = cxl_endpoint_decoder_alloc(port);
> > -		else
> > -			cxld = cxl_switch_decoder_alloc(port, target_count);
> > +		else {
> > +			struct cxl_switch_decoder *cxlsd;
> > +
> > +			cxlsd = cxl_switch_decoder_alloc(port, target_count);
> > +			if (IS_ERR(cxlsd))
> > +				cxld = ERR_CAST(cxlsd);
> 
> As described later, I'd rather local error handing in these branches
> as I think it will be more readable than this dance with error casting. for
> the cost of maybe 2 lines.

I am going to scrub one step deeper and just move all of the decoder
type specific code into the cxl_<type>_decoder_alloc() callers.

> 
> > +			else
> > +				cxld = &cxlsd->cxld;
> > +		}
> >  		if (IS_ERR(cxld)) {
> >  			dev_warn(&port->dev,
> >  				 "Failed to allocate the decoder\n");
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 13c321afe076..fd1cac13cd2e 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> 
> ....
> 
> >  
> > +static void __cxl_decoder_release(struct cxl_decoder *cxld)
> > +{
> > +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> > +
> > +	ida_free(&port->decoder_ida, cxld->id);
> > +	put_device(&port->dev);
> > +}
> > +
> >  static void cxl_decoder_release(struct device *dev)
> >  {
> >  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> > -	struct cxl_port *port = to_cxl_port(dev->parent);
> >  
> > -	ida_free(&port->decoder_ida, cxld->id);
> > +	__cxl_decoder_release(cxld);
> >  	kfree(cxld);
> > -	put_device(&port->dev);
> 
> I was going to moan about this reorder, but this is actually
> the right order as we allocate then get_device() so
> reverse should indeed do the put _device first.
> So good incidental clean up of ordering :)
> 
> > +}
> > +
> > +static void cxl_switch_decoder_release(struct device *dev)
> > +{
> > +	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(dev);
> > +
> > +	__cxl_decoder_release(&cxlsd->cxld);
> > +	kfree(cxlsd);
> >  }
> >  
> >  static const struct device_type cxl_decoder_endpoint_type = {
> > @@ -250,13 +267,13 @@ static const struct device_type cxl_decoder_endpoint_type = {
> >  
> >  static const struct device_type cxl_decoder_switch_type = {
> >  	.name = "cxl_decoder_switch",
> > -	.release = cxl_decoder_release,
> > +	.release = cxl_switch_decoder_release,
> >  	.groups = cxl_decoder_switch_attribute_groups,
> >  };
> >  
> >  static const struct device_type cxl_decoder_root_type = {
> >  	.name = "cxl_decoder_root",
> > -	.release = cxl_decoder_release,
> > +	.release = cxl_switch_decoder_release,
> >  	.groups = cxl_decoder_root_attribute_groups,
> >  };
> >  
> > @@ -271,15 +288,29 @@ bool is_root_decoder(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
> >  
> > +static bool is_switch_decoder(struct device *dev)
> > +{
> > +	return is_root_decoder(dev) || dev->type == &cxl_decoder_switch_type;
> > +}
> > +
> >  struct cxl_decoder *to_cxl_decoder(struct device *dev)
> >  {
> > -	if (dev_WARN_ONCE(dev, dev->type->release != cxl_decoder_release,
> > +	if (dev_WARN_ONCE(dev,
> > +			  !is_switch_decoder(dev) && !is_endpoint_decoder(dev),
> >  			  "not a cxl_decoder device\n"))
> >  		return NULL;
> >  	return container_of(dev, struct cxl_decoder, dev);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(to_cxl_decoder, CXL);
> >  
> > +static struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
> > +{
> > +	if (dev_WARN_ONCE(dev, !is_switch_decoder(dev),
> > +			  "not a cxl_switch_decoder device\n"))
> > +		return NULL;
> > +	return container_of(dev, struct cxl_switch_decoder, cxld.dev);
> > +}
> > +
> >  static void cxl_ep_release(struct cxl_ep *ep)
> >  {
> >  	if (!ep)
> > @@ -1129,7 +1160,7 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_find_dport_by_dev, CXL);
> >  
> > -static int decoder_populate_targets(struct cxl_decoder *cxld,
> > +static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
> >  				    struct cxl_port *port, int *target_map)
> >  {
> >  	int i, rc = 0;
> > @@ -1142,17 +1173,17 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
> >  	if (list_empty(&port->dports))
> >  		return -EINVAL;
> >  
> > -	write_seqlock(&cxld->target_lock);
> > -	for (i = 0; i < cxld->nr_targets; i++) {
> > +	write_seqlock(&cxlsd->target_lock);
> > +	for (i = 0; i < cxlsd->nr_targets; i++) {
> >  		struct cxl_dport *dport = find_dport(port, target_map[i]);
> >  
> >  		if (!dport) {
> >  			rc = -ENXIO;
> >  			break;
> >  		}
> > -		cxld->target[i] = dport;
> > +		cxlsd->target[i] = dport;
> >  	}
> > -	write_sequnlock(&cxld->target_lock);
> > +	write_sequnlock(&cxlsd->target_lock);
> >  
> >  	return rc;
> >  }
> > @@ -1179,13 +1210,27 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> >  {
> >  	struct cxl_decoder *cxld;
> >  	struct device *dev;
> > +	void *alloc;
> >  	int rc = 0;
> >  
> >  	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
> >  		return ERR_PTR(-EINVAL);
> >  
> > -	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> > -	if (!cxld)
> > +	if (nr_targets) {
> > +		struct cxl_switch_decoder *cxlsd;
> > +
> > +		alloc = kzalloc(struct_size(cxlsd, target, nr_targets), GFP_KERNEL);
> 
> I'd rather see a local check on the allocation failure even if it adds a few lines
> of duplicated code - which after you've dropped the local alloc variable won't be
> much even after a later patch adds another path in here.  The eventual code
> of this function is more than a little nasty when an early return in each
> path would, as far as I can tell, give the same result without the at least
> 3 null checks prior to returning (to ensure nothing happens before reaching
> the if (!alloc)
> 
> 
> 
> 
> 		cxlsd = kzalloc()
> 		if (!cxlsd)
> 			return ERR_PTR(-ENOMEM);
> 
> 		cxlsd->nr_targets = nr_targets;
> 		seqlock_init(...)
> 
> 	} else {
> 		cxld = kzalloc(sizerof(*cxld), GFP_KERNEL);
> 		if (!cxld)
> 			return ERR_PTR(-ENOMEM);

Point taken, and it's even cleaner without trying to recover the decoder
type in this function that is mostly just a base 'decoder init' helper.

> 
> > +		cxlsd = alloc;
> > +		if (cxlsd) {
> > +			cxlsd->nr_targets = nr_targets;
> > +			seqlock_init(&cxlsd->target_lock);
> > +			cxld = &cxlsd->cxld;
> > +		}
> > +	} else {
> > +		alloc = kzalloc(sizeof(*cxld), GFP_KERNEL);
> > +		cxld = alloc;
> > +	}
> > +	if (!alloc)
> >  		return ERR_PTR(-ENOMEM);
> >  
> >  	rc = ida_alloc(&port->decoder_ida, GFP_KERNEL);
> > @@ -1196,8 +1241,6 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> >  	get_device(&port->dev);
> >  	cxld->id = rc;
> >  
> > -	cxld->nr_targets = nr_targets;
> > -	seqlock_init(&cxld->target_lock);
> >  	dev = &cxld->dev;
> >  	device_initialize(dev);
> >  	lockdep_set_class(&dev->mutex, &cxl_decoder_key);
> > @@ -1222,7 +1265,7 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> >  
> >  	return cxld;
> >  err:
> > -	kfree(cxld);
> > +	kfree(alloc);
> >  	return ERR_PTR(rc);
> >  }
> >  
> > @@ -1236,13 +1279,18 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> >   * firmware description of CXL resources into a CXL standard decode
> >   * topology.
> >   */
> > -struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> > -					   unsigned int nr_targets)
> > +struct cxl_switch_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> > +						  unsigned int nr_targets)
> >  {
> > +	struct cxl_decoder *cxld;
> > +
> >  	if (!is_cxl_root(port))
> >  		return ERR_PTR(-EINVAL);
> >  
> > -	return cxl_decoder_alloc(port, nr_targets);
> > +	cxld = cxl_decoder_alloc(port, nr_targets);
> > +	if (IS_ERR(cxld))
> > +		return ERR_CAST(cxld);
> > +	return to_cxl_switch_decoder(&cxld->dev);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
> >  
> > @@ -1257,13 +1305,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
> >   * that sit between Switch Upstream Ports / Switch Downstream Ports and
> >   * Host Bridges / Root Ports.
> >   */
> > -struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> > -					     unsigned int nr_targets)
> > +struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> > +						    unsigned int nr_targets)
> >  {
> > +	struct cxl_decoder *cxld;
> > +
> >  	if (is_cxl_root(port) || is_cxl_endpoint(port))
> >  		return ERR_PTR(-EINVAL);
> >  
> > -	return cxl_decoder_alloc(port, nr_targets);
> > +	cxld = cxl_decoder_alloc(port, nr_targets);
> > +	if (IS_ERR(cxld))
> > +		return ERR_CAST(cxld);
> > +	return to_cxl_switch_decoder(&cxld->dev);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
> >  
> > @@ -1320,7 +1373,9 @@ int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
> >  
> >  	port = to_cxl_port(cxld->dev.parent);
> >  	if (!is_endpoint_decoder(dev)) {
> > -		rc = decoder_populate_targets(cxld, port, target_map);
> > +		struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(dev);
> > +
> > +		rc = decoder_populate_targets(cxlsd, port, target_map);
> >  		if (rc && (cxld->flags & CXL_DECODER_F_ENABLE)) {
> >  			dev_err(&port->dev,
> >  				"Failed to populate active decoder targets\n");
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index fd02f9e2a829..7525b55b11bb 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -220,7 +220,7 @@ enum cxl_decoder_type {
> >  #define CXL_DECODER_MAX_INTERLEAVE 16
> >  
> >  /**
> > - * struct cxl_decoder - CXL address range decode configuration
> > + * struct cxl_decoder - Common CXL HDM Decoder Attributes
> >   * @dev: this decoder's device
> >   * @id: kernel device name id
> >   * @hpa_range: Host physical address range mapped by this decoder
> > @@ -228,10 +228,7 @@ enum cxl_decoder_type {
> >   * @interleave_granularity: data stride per dport
> >   * @target_type: accelerator vs expander (type2 vs type3) selector
> >   * @flags: memory type capabilities and locking
> > - * @target_lock: coordinate coherent reads of the target list
> > - * @nr_targets: number of elements in @target
> > - * @target: active ordered target list in current decoder configuration
> > - */
> > +*/
> 
> ?

Fixed.

> 
> >  struct cxl_decoder {
> >  	struct device dev;
> >  	int id;
> > @@ -240,12 +237,22 @@ struct cxl_decoder {
> >  	int interleave_granularity;
> >  	enum cxl_decoder_type target_type;
> >  	unsigned long flags;
> > +};
> > +
> > +/**
> > + * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
> 
> Whilst you define the broad use of switch in the patch description, I think
> it is worth explaining here that it's CFMWS, HB and switch decoders
> (if I understand correctly - this had me very confused when looking
> at the overall code)
> 
> > + * @cxld: base cxl_decoder object
> > + * @target_lock: coordinate coherent reads of the target list
> > + * @nr_targets: number of elements in @target
> > + * @target: active ordered target list in current decoder configuration
> > + */
> > +struct cxl_switch_decoder {
> > +	struct cxl_decoder cxld;
> >  	seqlock_t target_lock;
> >  	int nr_targets;
> >  	struct cxl_dport *target[];
> >  };
> >  
> > -
> 
> *grumble grumble*  Unconnected white space fix.

Just checking if you're paying attention. Fixed.

> 
> >  /**
> >   * enum cxl_nvdimm_brige_state - state machine for managing bus rescans
> >   * @CXL_NVB_NEW: Set at bridge create and after cxl_pmem_wq is destroyed
> > @@ -363,10 +370,10 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
> >  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> >  bool is_root_decoder(struct device *dev);
> >  bool is_endpoint_decoder(struct device *dev);
> > -struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> > -					   unsigned int nr_targets);
> > -struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> > -					     unsigned int nr_targets);
> > +struct cxl_switch_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> > +						  unsigned int nr_targets);
> > +struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> > +						    unsigned int nr_targets);
> >  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
> >  struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
> >  int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 7a08b025f2de..68288354b419 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -451,9 +451,15 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
> >  		struct cxl_decoder *cxld;
> >  		int rc;
> >  
> > -		if (target_count)
> > -			cxld = cxl_switch_decoder_alloc(port, target_count);
> > -		else
> > +		if (target_count) {
> > +			struct cxl_switch_decoder *cxlsd;
> > +
> > +			cxlsd = cxl_switch_decoder_alloc(port, target_count);
> > +			if (IS_ERR(cxlsd))
> > +				cxld = ERR_CAST(cxlsd);
> 
> Looks cleaner to me to move error handling into the branches. You duplicate
> an error print but avoid ERR_CAST mess just to cast it back to an error in the
> error path a few lines later.

ok.
