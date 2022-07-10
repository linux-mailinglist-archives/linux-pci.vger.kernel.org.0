Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C866F56CC84
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 05:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiGJDpQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 23:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJDpP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 23:45:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633CD11814;
        Sat,  9 Jul 2022 20:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657424714; x=1688960714;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EDRsKs9WsNFAHJg/RGgRNYp8KMUCxYpGFfr12Sqb2XU=;
  b=bBdWZCNW2Wtb57ThDjIWWwIRXAir8CdB6002gE6d2wC1ogmMnXJ1m0YF
   +wpYq1HHDjQr0j10BSZr9P6qFfwlpaUAp+YlI/MQHFWtfEAzTszIc3tz4
   et7/Wp2tLxt5zZfW+Jy4StFQCzr5WjAH05sh12XeZMWutRFzPFMSdROun
   q8qWdH7eM2mGIrP9Ur2OL9HcWJiSEav779btvWgvOeVEdKMIKtvbwW5Fi
   3v+Ic66H+Fv8zCszy86ZGTx7LIZ0UIOV4gJYwSR0r+5f8BpvUlZDz9TgG
   vsE6ZZeSVx773ssp/xIULz37uI8Sl5OugLa4pqDVDt+kkVwBqJyi/0mVA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="348462138"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="348462138"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 20:45:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="840663956"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jul 2022 20:45:13 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 20:45:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 20:45:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 9 Jul 2022 20:45:12 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 9 Jul 2022 20:45:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1xRQiKQ4TFdn4rihbq7b/exObTgGYY/ucmWHtNMINFoWP4CUSnsMA6KKR5Np2Ter8KrtJesyjuKmM3fY4oAF519XRDuZxRc+QcFNQUuZf7n0hMtmskgOVXe3ubToWqW6LQ+eA49vji0pdpVsQuZlPJ3wucQudQ5BIFHXe2M2ZezCIj9enOQOW96K0/Y9EYdFZp5XVfKHQsyAlbCa2FH3pfuB0JRWLcDd8RKj/3I7EV+jJrgQ6rGI42szpI6VKxH3M7e6ZxRtWEqG8rAd4+SQAna+WPe88j386Z//zN0pg4KbpjF6CQRgnEilnMZyjdXjk4fOWXKf1o6o2imJf+H2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWxjUF4TKRbXesHB5fNWMV455fmdzVuLyuBlSMRhPy8=;
 b=c0ZmrrDlkUDy+cgd1wW1vI4P+21rac36NJPq+rraFGwcsAEBEIsRpnFEn7iXfx/yXo0Btx4PSj5HtSP4Q4+k2WzSplsmSSVjhQjwbRd9KQQnk8LvkDZpag9Soe8cC4fN7Kf55EddLKdjOhrDFr0n7WcpWJSMeFOWP3aiO94lnNCNZqonuCRAa/05RSU4R7AFtUgrH8iuhlCbOavqNZopFtqlgWsxlCQQV8MAXBoO2hi0T3WdezsFs7Y3foAR9GILVRaErx103SKJ7t9qSc4+q+UFPP38jS+0JO9GvtaD9VEvuLn1+BaSrioFo4uaDOrpgaf9FlbQvEWHyfBAnfCALA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ1PR11MB6298.namprd11.prod.outlook.com
 (2603:10b6:a03:457::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Sun, 10 Jul
 2022 03:45:09 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.021; Sun, 10 Jul
 2022 03:45:08 +0000
Date:   Sat, 9 Jul 2022 20:45:06 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 16/46] cxl/hdm: Add 'mode' attribute to decoder objects
Message-ID: <62ca4b425e040_3177ca294e3@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603881967.551046.6007594190951596439.stgit@dwillia2-xfh>
 <20220629162807.00007bb7@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220629162807.00007bb7@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:303:b9::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce93ee31-3b26-4deb-fc07-08da622695ab
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6298:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QF/RM0ADoofopNpANmVdXDksndpyaQpHnVB1XFTXz3jjYchWhvFCA31cVYbEy0N3DB2Uy0OMTWrrolUuNVgLRd6IcRtpZYOY25clOTr+GP+kt2fj79g9OJ6h/fc4be64JPdOEEkpckuMQRYp5Mcwxoi+kXnW7ioKi8FxS0LnP634mRspxzM0LxQv12TowaZvlabm7RaMc78QYiDFBdbTE5fAw0yNl/jgXdtrsIzgoOFFf0Mo6akhjxU7vADJL8JYZyTF9lVh5exfIai+R7/h5l3aHY0vqbQ7e28AyNBYXVu17cqNdYarkukgjCkhSqe91VWMslGoDRAgTtzhJhyZkTMCnDQHvLT4KjwBzVEXIz0eEMY8j9jnc+QE6JUwtIM9FL8zDndNUrY8yEJL1z0pwX0811eNOJ4DOm4Iw85ajufHPaZiTd9FLWaUTAVypBku49YgxeWUh//GHnprtg/nVUqn60E6D2sZeQw0lEnx9+KLgHQsTGCmlVZWXnLeYo11m7iZkYYK4jaEm6yrELWpPYvBSAgkx4EtAkWDM8bfM5hMKzrueEevvkKpqaMIHLZrNl15LCO9mYlFOPHTeQ2P4EbGvjmgo/IBkwfJ6GH1K/MZZ5q+xbmrpaPVU+c/HKo91FsiD9GJUxW1givGX/WZUfnxCauDTzZsZ+puMYEpdrzjHCw7q+HLkFSE6cr7FT5orMHGq03/csvsHEGt8mi30mNczt8+LL4utL8yufgP9V4tyhVWALvzt3Xk3fvegkjAiSVeYsq0l7xmdkltrND+Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(39860400002)(136003)(396003)(6506007)(41300700001)(83380400001)(478600001)(6486002)(5660300002)(8936002)(82960400001)(4326008)(86362001)(110136005)(2906002)(316002)(186003)(38100700002)(66476007)(66556008)(6512007)(66946007)(8676002)(9686003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BWjcsbnWFwMR0eDm5OzYX+RbjWz3wu4TOGkJ+Q+apay8gGkCOWV7y51y2BZ5?=
 =?us-ascii?Q?mnhLsknr5CFt5R7uin+gtsyeEDB39XARdcmLknROvNZe8R9WotJqG7NV9S3J?=
 =?us-ascii?Q?/lqOviu+gUXPJJTEnf7TSOV3+GGG4+A1WXu+IpAAo2av7BRCYpP26sysXhmD?=
 =?us-ascii?Q?7SkgJLmQMUAfbcrzlVJtaxwft2FD5HNHbr24/kXimnk5E9iiUKFcAFiJDRKO?=
 =?us-ascii?Q?fJvIdhV89ES6GTB0uxA6Jqy/T0bNUkACcvNhTUEiojMSgT3lKKHU8uCfQAtC?=
 =?us-ascii?Q?QrT8UE4d9YFPcwZQDcjcBhSCGV1cj5cRf92+vUw8tRB/9LP3enJcCXY4ZBj8?=
 =?us-ascii?Q?jFHa2vHLLhO02Q7P++4NyhnHTG6EbOdK6g1QJhReg3j2WCEn1lfvyXno1v9j?=
 =?us-ascii?Q?WGotxite9a+EaFy17hbFhrYEl0WWlQ6f9ZTAtuu61MO87DDK9abLv4fyJBz3?=
 =?us-ascii?Q?JvH2davnoseahA/cUBYjeUTYDvJYcG6XPDBjv5IMoHXfZB/znhW6YmWJy9nw?=
 =?us-ascii?Q?6zONbO972JCAb3ojahVL34Pq1E8IHdkHeUmz/R1kNI0bNKyRCMmHBkG3yKPd?=
 =?us-ascii?Q?PdG+1vEOmizdeUao+BPAv1Gps62c4hnjnAdyWXnL6/slZYZFwpY1RHKkZk7v?=
 =?us-ascii?Q?FU/BsXSX1E4puhD3vYXU1RcwXUyZyR/4lHQqgAh9Au6nraj4UtwKKEqG452K?=
 =?us-ascii?Q?CqxiimqWZ6Jsb4I/0wZnm8kqs2O2gIK8wN1HREEefq2RGZ8d8YPwJW57Gt8r?=
 =?us-ascii?Q?uolTi0oZyxoq8MLEU0kZODBlQF9BVGCSp82GQmcZjxWt09eESo50kk4Lx8C1?=
 =?us-ascii?Q?ie8+kZfeAQt6jFWf3JANffM0H00GAWr4ahAvtGdbsoplcXQc5+N9FpCqTvPK?=
 =?us-ascii?Q?TjMVjQDOkbQlRqgoF56xw55LLF2fXtX5Kn1WZEJS1ucMtrbnBdx0jxxSn1mz?=
 =?us-ascii?Q?Qp4MKjW9EniUEEHvPZ103Nppwsh/h4IhPRPCt3HzwcPkFZ7+tq6zNd5wkVBO?=
 =?us-ascii?Q?vkc5RsgtoPZQiAmjLFHpf4q7JxbhCqWsjEPPem/hhjIrA4P0Q/gbwaghZUml?=
 =?us-ascii?Q?cwPfPccOBuzrXVRR8t8ni6zG3dax/on/PPGwREOep8LAkAPH3/nW9DLjCQl1?=
 =?us-ascii?Q?vy3GUt0sz3jAsur7WRvetXao7xGM/ZR+qMNGJtfZfccU1Q6gRRCJcjm9Vi1N?=
 =?us-ascii?Q?6M1s4rq0eWhd+DahPMpBO2CgUR/HFlIukm35GlSAd/cxOMHaqnnGDciqEjng?=
 =?us-ascii?Q?4nJ9f+0etw/G/Vl3GwCpk69wSSXkNOGNtnB4V3/LkRLofBuOXc8CDhBD6gjc?=
 =?us-ascii?Q?XZtNvuQTJdXWh5QYtqiAQMKYsQHmHE1pejqXLw/Ay4sSC3W2FwuqBvgdDe19?=
 =?us-ascii?Q?Cl3KWi0uKBOKcJ4u3m/3hKqd9NL+15P/WIU8a/INCqmwvj5nwytH3+/Pbpm8?=
 =?us-ascii?Q?oCaH2oFQRXU1AKiKIRtU9IVqMY+QC2lRSwPw3/92bcmRU19wGmrEY1EV0g8c?=
 =?us-ascii?Q?eMtOScTdBkfi0KGg9D74Kqj0jllCFXnXw71M8a2B4nuO++VofzcSCuq8OE8M?=
 =?us-ascii?Q?R0v5SpLPUmwffBwRDrWW0KyciCiSXa7JCgBR+/zoMDKqxxY8Xa19X1hVYkS4?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce93ee31-3b26-4deb-fc07-08da622695ab
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 03:45:08.7264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FTMRqVhw5qOu8I4ep1liVoh0bqXmzgNIsSuUU+97nBtvgLiFOERUmCWPn8d0CnJFftGiubLKrohsp2F2BNMeLi1riXS1MgLi6S7T0/zw0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6298
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
> On Thu, 23 Jun 2022 19:46:59 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Recall that the Device Physical Address (DPA) space of a CXL Memory
> > Expander is potentially partitioned into a volatile and persistent
> > portion. A decoder maps a Host Physical Address (HPA) range to a DPA
> > range and that translation depends on the value of all previous (lower
> > instance number) decoders before the current one.
> > 
> > In preparation for allowing dynamic provisioning of regions, decoders
> > need an ABI to indicate which DPA partition a decoder targets. This ABI
> > needs to be prepared for the possibility that some other agent committed
> > and locked a decoder that spans the partition boundary.
> > 
> > Add 'decoderX.Y/mode' to endpoint decoders that indicates which
> > partition 'ram' / 'pmem' the decoder targets, or 'mixed' if the decoder
> > currently spans the partition boundary.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> A few trivial things inline though I'm not super keen on it being
> introduced RO for just 2 patches...  You could pull forwards
> the outline of the store() to avoid that slight oddity, but
> I'm not that bothered if it is a pain to do.

It's either RO as a temporary state, or a pointless store() as a
temporary state, I think the former is more palatable for bisecting.

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |   16 ++++++++++++++++
> >  drivers/cxl/core/hdm.c                  |   10 ++++++++++
> >  drivers/cxl/core/port.c                 |   20 ++++++++++++++++++++
> >  drivers/cxl/cxl.h                       |    9 +++++++++
> >  4 files changed, 55 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 1fd5984b6158..091459216e11 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -164,3 +164,19 @@ Description:
> >  		expander memory (type-3). The 'target_type' attribute indicates
> >  		the current setting which may dynamically change based on what
> >  		memory regions are activated in this decode hierarchy.
> > +
> > +
> 
> Single blank line used for previous entries. Note this carries to other
> later patches.

It was deliberate, I should go back and fix up the previous ones to be
consistent.

> 
> 
> > +What:		/sys/bus/cxl/devices/decoderX.Y/mode
> > +Date:		May, 2022
> > +KernelVersion:	v5.20
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> > +		translates from a host physical address range, to a device local
> > +		address range. Device-local address ranges are further split
> > +		into a 'ram' (volatile memory) range and 'pmem' (persistent
> > +		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
> > +		'mixed', or 'none'. The 'mixed' indication is for error cases
> > +		when a decoder straddles the volatile/persistent partition
> > +		boundary, and 'none' indicates the decoder is not actively
> > +		decoding, or no DPA allocation policy has been set.
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index daae6e533146..3f929231b822 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -204,6 +204,16 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  	cxled->dpa_res = res;
> >  	cxled->skip = skip;
> >  
> > +	if (resource_contains(&cxlds->pmem_res, res))
> > +		cxled->mode = CXL_DECODER_PMEM;
> > +	else if (resource_contains(&cxlds->ram_res, res))
> > +		cxled->mode = CXL_DECODER_RAM;
> > +	else {
> > +		dev_dbg(dev, "decoder%d.%d: %pr mixed\n", port->id,
> > +			cxled->cxld.id, cxled->dpa_res);
> 
> Why debug for one case and not the the others?

It's an exceptional, "should never happen" case, but can be benign so
it does not rise to the level of dev_warn(). However, if someone is
reporting a bug and I ask for a debug log, this is something odd that
I'd like to see highlighted.
