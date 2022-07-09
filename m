Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64F856CC0C
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 01:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiGIXwx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 19:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIXww (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 19:52:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BA911A13;
        Sat,  9 Jul 2022 16:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657410767; x=1688946767;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NuMfKFQ8bnSn3rm9hbOEEmzWXmtJF9Q5YiDpPXkEIOw=;
  b=cYKnxgafCgzeY/vE+90lSWq1MJKtpHpCFMmMnWQywpUs5mFq/SnYPxWb
   EjT8tRl+OwqzZbky0QxHOJaE3F0qQmBt1X1zNBgQkLEIOUtU7bVMYkPnm
   9pm8BnLygje6aQCCAKAD9gN8gNfJo+zHm7kXOWo5TuHay+CtosbaJ7W4F
   eO/UIABCqO7fwpiDWOkcId5Lf4IujrSakfmGZMhv0FM2Ma2F4Sz0b77T0
   OP7RORVKsFyaGTMt6Mbal3NkDUuwj5/a4sMusys5xV/EH6PTgmPUJmQ+w
   knCLtS9iFemBvRXDaz3FYZFcsemtdXB7/bmMThNKp/fPEt8h1Cb3hcVVi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="284489574"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="284489574"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 16:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="569345032"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 09 Jul 2022 16:52:46 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 16:52:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 9 Jul 2022 16:52:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 9 Jul 2022 16:52:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rbfgnl9ZBUUv/vEbXmKPRflykk/00XmzsgAdQCz7o2VZdSsG9ZllB42E1PzA3FGjAdIKEeau/PUz5r0ySQ+eQrpelXDNxCHJfQXkzc7bCbK487imq5jnUIGZJPybBDk0Avqave8Jd83+0DiZN1q1kyII6mEhJ/dougVtzH4tVaHvq+iczNAJuUF+8dpR8gb10E1t6ZbVX0Ru/lHnEE7/Bl7jo4CrjEiLlcgrjuN5k+9ezlxiKWm47hZravC8T8MI+LGpTA55UO/OZv6RFPKiaaJL9VGXNi0ykVSWaFmEwB7PFoI1u4uSSHHWcyrM5+0X2YtG/4AxkLDjYFPUoB3/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPka3VxfTJrVicR0nICS6sa7eRB30hp+8FUDCXpIJno=;
 b=Vd5UHt28YnzExR4rsnk1dSsyQtzUk/VH7T2SlkugAQiSM7qiMSS+G+HbPsXLhOMC914NGlj9xpmlfGOXQ5HErhIFKsEm2oU0Y8Gd2tgz+QdGreIKA66bAmWHJ54GpQWSR3MFwnnm2rDKB+mvHxfMWnmuaeE4kyPsWOZufZQ2E5IV3uxg6aICflvuhKNSIlC0qujDWPn7iA1t2vdIaRlQBgjBrod0T5aNvSKsxx+SqseOZzb5bew37DOp0ZzfwepIyflWhMecZIgYKaHmFt6fRnWuQAeMG7mmqZIVDn/lM7HEtDSJnocZ2g1tMLGadbnXzEazuMJk/82ptopNO6Px2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB3800.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sat, 9 Jul
 2022 23:52:44 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.021; Sat, 9 Jul 2022
 23:52:44 +0000
Date:   Sat, 9 Jul 2022 16:52:42 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 07/46] cxl: Introduce cxl_to_{ways,granularity}
Message-ID: <62ca14ca209ad_2da5bd294c0@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603875016.551046.17236943065932132355.stgit@dwillia2-xfh>
 <20220628163621.00000005@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628163621.00000005@Huawei.com>
X-ClientProxiedBy: MWHPR2001CA0005.namprd20.prod.outlook.com
 (2603:10b6:301:15::15) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf31027c-eb82-4d0f-deca-08da62061e0c
X-MS-TrafficTypeDiagnostic: BYAPR11MB3800:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYdi7VJo7DyWreK9ty0Secl3QMi0IhZQhmEjQ54yITAfELB2ADZvrgWpOmcFdHA/f8rsjHlMq5DoQmqz4arguwJS7j5z855nYU5Huucp3kSvS+kAkBtSwRskgdOz4sSXcV1pV8qDsU7L0epA1L4plG2CqQCcg7Ncv1dJOZRpL43Ss7cn+3PFCoPZWi4PRyIoToH8V7/uz6+rpcA0MSK7cPEjewMrZ4/cbRcrYzVoyINHq/FqcB77O4rGQs+RtiQ9+CjY8MzA5++YstHjVdMZlfQhywSeue8fg+7GIo2DEgiYGLBvUlWRAwHm0sDZKPhKmOSrd09hQty7hYxHKrfVI498HZQ722h0V5E11Fewm7yWHNeKKvwQgbAU4Ri1feZCltFHAvtCeIfF9sb7DUuhqO4hZfrKASQOHVzbuEhU8aWiYyNlrXS70VeQfUamoVSNRIhIvLAA/x9+pXcivDEANFY0vTHdJ/UpnwkzGh6+9g8+Qyoti/6tt4X9Khc6m9SnzTo1lxlVHZBuZcB54wJnesiPEPr5BkJ4tg3shkcXMyj2d4SXlofv6HoisoY6RJvCCFaWlg2wh89luijwxUCBd28tNyJ06cooHSYEHVaKlZboQNYOR4w5kXcU2pTsuqJgLYujzpwexHG5OvnU4BeTngU1h5TbT8nIArNWyNKUrZExAXl6pBtelR5epnzfygSvyCnkGpIOUCduWOOwEWmIQbOJfqW+scwsS290G5lXghb9MddkbfIz7Tl/O6Jy4OWuNgeDKa7rJagpZlH0W2cICA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(136003)(396003)(39860400002)(9686003)(66556008)(4326008)(66476007)(8676002)(6486002)(82960400001)(6506007)(6512007)(26005)(41300700001)(86362001)(66946007)(186003)(478600001)(2906002)(110136005)(8936002)(38100700002)(316002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qXc+mx8dTJ70KkONwSKiTM7FASXGjh5ZDEviBUiHu4menz3f7ivpvx9jOlBN?=
 =?us-ascii?Q?qKFkIop2kMLCJ0FXxuOYqbvwUq9UoFK1C+x6mLgRGosJcV6LT0BySncOBmFn?=
 =?us-ascii?Q?hDbCDvqSvyXJGeEwLw986jreEmUwNhnbeYJ5cdv0Qx2sZh4XdggmAY80gkP8?=
 =?us-ascii?Q?+GkATfajW5Itaj3hFzIlDy4vdAaaQwqnEMcCdRzUh/zT7RDW99mCChkQskl9?=
 =?us-ascii?Q?7wiE5c2o7iYS2xlRj349qyNXW9bqznDpN0zRBM0BMv7cxTI6sFZ/Ivj98gbM?=
 =?us-ascii?Q?Ntd9mJuNDdgq7F2NE6Jh1vspxafuCFlm/lcekjzHMxumErsU0QrzOfPeq0II?=
 =?us-ascii?Q?5pr+9yvx/kEtWaKuZxlcYER7FSmGDqltNZNYBBY7dvEnnv0g1bxzOAat2o8J?=
 =?us-ascii?Q?DkqbuEeE1wGN0Zp4o3pZACoBfU28owsv5lu4PRiIMWUwIMeHSPrwbNDjycdb?=
 =?us-ascii?Q?eFqdZvpsOnmF47vaJKL9l1/OC6Jo6CMEFySZ/XGWrhizNJM9rdJ5DD/iV/mK?=
 =?us-ascii?Q?/yCxO5JNmUeQZ4yi9pVOjuG8QZ7Mk6GSrj30TBPKj6S7ANzATTdMXSGOU2oA?=
 =?us-ascii?Q?OICaG1mOX3/1oD9275X07+WgKxZN7mSps4rWYGoLn5RNo1W+Uh7fSomq4Nuc?=
 =?us-ascii?Q?JzBOMbRQcohprYzA7AythY9CNe1sYA1jBcJ+nC4PJIUPCp/xgWlSWdCinst0?=
 =?us-ascii?Q?4IqTu9wn9N3L3g1TGxz9dJBYEOjaFBe9vLU0DjUPaR/IgEtvS2ubH5hUC0aD?=
 =?us-ascii?Q?OgYMScgQ8ajQvjbuCntmYy9hGKVWp99aNzbWsuEvngEB65Glom0ZvrbUGxhX?=
 =?us-ascii?Q?O3bUpAyF15ABhWiifhxUhi7WGbxLq9+B1Ol3QFJskE+OmWfWkM48paeCk5Ai?=
 =?us-ascii?Q?ZGwvcMhVS5WsU9NeuYYvtrY7Gs1Tb0eH6aNS6uQyyREPeVkplhM/xQtIiKf4?=
 =?us-ascii?Q?yXgW427NUsGeVwX4oICxbkDl3NoBkQGN1YBeT06H/RW7FJFsVDroNHha83xo?=
 =?us-ascii?Q?4PZvWu02z25ATQY9oZmFMcOk9yi+nRdZRbfzHvq6MWMfUWj66ckCnhwq9zVk?=
 =?us-ascii?Q?Lx1xXRMGnNE5dKGvQ7vA8Y+KtXwkxp9SZNJa0XhlGIWCD0UXwBKIPLrOck4D?=
 =?us-ascii?Q?iRSA78rR/9vJNXSaq5R0v2Vdex4k22Pv3qFcUcsHZlQ+L78Vvg+jRf9r8LsI?=
 =?us-ascii?Q?GAaRET8rgYoB4mpUV09MPhhs6f02RLvGxM+57mWt1Zjdb1QaLM9Fm6HNJpS2?=
 =?us-ascii?Q?JYUjK9OPloGw+rDl0Loi7MJWE0ZwTS+1EYEUdKCKpW+XmsZQqhdaMvPMorWT?=
 =?us-ascii?Q?ePQ5Hska4Wqz8FKNDbKTr6mVlCQCviDUQ9Qah8GyS6hpfdk24jUBnAWvwY0V?=
 =?us-ascii?Q?PCxViAtP+68y9zbThJVzeF0cRoTR1pNeRHXfEHIxM5JiKyrrB8KD4WT1rKaE?=
 =?us-ascii?Q?MbtVWYuDoNjV7FF0USuyIa4zLQ+Kwnvd9XK8ACDHMbxoG/iXSx0KfxGPrkHn?=
 =?us-ascii?Q?0nze0Q9IWPQlbRmnWCwB4G3ze165mF81VgUxWPKuZq/h3itYvOzRsWcT0Tqx?=
 =?us-ascii?Q?YUUyoMBVdD/h3/nSbR1MKlsirn6g1+Ksq+b83kQ3F2E9o5iv7SnZokFEV5Sl?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf31027c-eb82-4d0f-deca-08da62061e0c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 23:52:44.1707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iv/dYlkkAHG+uqgZBWqcLIO0NdrsPz/el0nUWEiRo+2eKelbNguDQwbW577Eb21Pc6JOhDiILLBDPwfC0lyDXnaAv95MV3TaJC1yfXqiUhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3800
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 19:45:50 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Interleave granularity and ways have CXL specification defined encodings.
> > Promote the conversion helpers to a common header, and use them to
> > replace other open-coded instances.
> > 
> > Force caller to consider the error case of the conversion as well.
> 
> What was the reasoning behind not just returning the value (rather
> than the extra *val parameter)?  Negative values would be errors
> still. Plenty of room to do that in an int.
> 
> I don't really mind, just feels a tiny bit uglier than it could be.

The rationale was to make it symmetric with reverse translation to
encoded values where those encode helpers are used directly for sysfs
input validation like the kstrto*() helpers.

Added a note to that effect.

> 
> Also, there is one little unrelated type change in here.
> 
> > 
> > Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/acpi.c     |   34 +++++++++++++++++++---------------
> >  drivers/cxl/core/hdm.c |   35 +++++++++--------------------------
> >  drivers/cxl/cxl.h      |   26 ++++++++++++++++++++++++++
> >  3 files changed, 54 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 951695cdb455..544cb10ce33e 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -9,10 +9,6 @@
> >  #include "cxlpci.h"
> >  #include "cxl.h"
> >  
> > -/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> > -#define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
> > -#define CFMWS_INTERLEAVE_GRANULARITY(x)	((x)->granularity + 8)
> > -
> >  static unsigned long cfmws_to_decoder_flags(int restrictions)
> >  {
> >  	unsigned long flags = CXL_DECODER_F_ENABLE;
> > @@ -34,7 +30,8 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
> >  static int cxl_acpi_cfmws_verify(struct device *dev,
> >  				 struct acpi_cedt_cfmws *cfmws)
> >  {
> > -	int expected_len;
> > +	unsigned int expected_len, ways;
> 
> Type change for expected_len seems fine but isn't mentioned in the patch description.

Yeah, that seems a thoughtless change to me since only @ways needs to be
an unsigned int. I fixed it up.
