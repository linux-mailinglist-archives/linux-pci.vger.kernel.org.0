Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F8557CEE7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiGUP3M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiGUP3L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 11:29:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC847A51E;
        Thu, 21 Jul 2022 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658417350; x=1689953350;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4R0szUxMHfwtnH6JE4lZGBh/fp22PR7bTCRiO+ba24o=;
  b=NpmgMBxPAUO7nnYxTJDmJtj1YC8WDhV5JVaTNhGUZTDOxBtiyd0v1lzM
   c/mAT7glYc/1n83PtZHjk8zdIIg7JktJ+75bxzRjEu4FR4Ebur2NpeLM2
   fyxw0RjLOJQX+Jud+2aQ5XmDMBHlRPVQOVN1HZ1gnnoVRpS3lxsC7tiL+
   wQuO7j4ptD+hVRDWWJrvJ7kgqzfoPuSkpD65gYmwfT6GxFsErKvVCGzWW
   SaWu1OXpSiVkRjRc9Nlc5v8OObjAfP4fnXvY820HwymY45q5tlQX5A13G
   RCAx/dz2XImoCKY7vTwRoQ/ITybqKSb434hKk9RWGwYUJoF/ZXtpCN4dO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="287086190"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="287086190"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 08:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="740717257"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2022 08:29:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 08:29:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 08:29:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 08:29:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqgn6F+HRAeOJEGLN8RGT4rO/of4d5/2EVw6jUIYvmbMwQe0oJtH3qrRZonO2g5/plC1qQCFzUwZZkM1cO7UUlq3lFyeSZh3JdbHvUyV9tOsDcXazpfJ6OWD5Z/p+ULRi/vX505kCkjhQWBD3GlbIxGsTnuHjy6HreIF8gqxJVTK6vIuneKYN4liEBhnf0q8MW7gkFb/TGt2clX6CQQRHtqckGqmWrFO5NAT7e3y/uazOFiCopEDjYNrvRMAAZZbzi0VsoFTMOdicdwDsHJ1vU95PyT5q1mI4QfymoFaWw+kvAj5BBGa/SMIfSISnBwkT8PXnnjWWTXKZUpiYYlybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XCd1NZwIEMHzaslrapRMwAfYIJbUUl5jxTINQo+ujU=;
 b=V82ZQpOl7dsy03RKzzK5KeWL/tPJe9C9WO6NGdnzzFdi7+6YBjpwh1wthjwMZW5MTOORqvWGJFOk7r9vwAnKjXjB1yhYMGARN2p7AWU1WX128EewPEUxSN40VNauXXO0piBPN4oEfqNzM+qCUq7nKVXgf6rhq+btacMLFkZccmevkn8uGDZ+nfmjpxptvUg2yETqnoTcaaVLpIRQW3o4ginE84r+VaYsLErHsrb45bcRNXJMay5Wfpp2sds5gzSjIo+dt0xAqXEk2cbbQHY7EPGPlz8c9jQQUd0kfVZUub38R3iqKimC8RFwYIOZ1mBw/+o7s8jFrczp7bmc9Gs6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL3PR11MB5746.namprd11.prod.outlook.com
 (2603:10b6:208:353::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 15:29:07 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5458.019; Thu, 21 Jul
 2022 15:29:07 +0000
Date:   Thu, 21 Jul 2022 08:29:05 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@lst.de>, <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 06/28] cxl/hdm: Enumerate allocated DPA
Message-ID: <62d970c11889e_17f3e829411@dwillia2-xfh.jf.intel.com.notmuch>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
 <165784327682.1758207.7914919426043855876.stgit@dwillia2-xfh.jf.intel.com>
 <20220720174031.00006f78@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220720174031.00006f78@Huawei.com>
X-ClientProxiedBy: BY3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:254::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87e7b54b-2f78-4de4-2c35-08da6b2dc056
X-MS-TrafficTypeDiagnostic: BL3PR11MB5746:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5HhcWnaBdG8wUeHLEBQEdO02MnBakgczbBR6hCb73AjaR9ELfbveE4ktgsesnHFq/Bb8o522yvrG0aZtzpUgz6YAESXPS86vkayhMW10DalkurOJeSwRxfKVsXJ+7gDJv4jaOaezlXeE+Lsp5cd5QvYiI/BW+5/sjS3kZwG978gBOonymyVkMBH+95yU9R2rgS/+UDA09VuZsmKj6Er30xXn79mIyOkJ52g7nUOYri7mSCEfBYGMgVAkRIigfixKNSnWFfQuGE6sLRfkWcE3909dDAADr7bQIyRobh31tGVL3kOnW7oF3rBoBVDmGM4FoSV12MoMYnI7jOetpgNaL442qMMy2hQmYtg/baMcAdCTjXu+6UH1+ry2Kc47iWwMtZGXDK1/8ICYphnnm/AKJP3xAwnfCZZXmZA9H6cA4iZMDdGhwx+OX9joDSsV7nGGHLVLt2JmdAZSq3vo1GhlXNMd2L2edVPmk7DZwgeANUkyAwUIE/uG5Wxd4CR3vpzsBk2MkTn4o4IUldEEkxsaGalLjXCao5v0G/+RiPNfkMaxOU+itULRJPCazSHLL6pRFr5xR1Rk9fXTsuL4OZ8Ar+DpjcDfMHakvbYWg4I8FgS8FxlA0xYoYKjN8LveoVtzZk228MZ4htP+p4IHNR3xnUOOot1L4h3UKlBy0KAqT+zXTTXRbzr6Ar9mfkG1sxDAlCVTh1+kzbXIox8bCTBtydTT/fqAvdzNBBbflxqm2wxB/4dm/8IuqEzfZnTYM1I3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(136003)(346002)(6486002)(2906002)(6506007)(38100700002)(26005)(66476007)(66946007)(8676002)(86362001)(66556008)(6512007)(9686003)(5660300002)(8936002)(4326008)(83380400001)(316002)(186003)(82960400001)(478600001)(110136005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p3o/G/4o1Ax/jVj2K+W07yo2eWsvxXeGIAiwtL7qOqnPRjCSHfYgztHqrZWp?=
 =?us-ascii?Q?LdX155IZDmZMosXSehtxu4cVUmbf6e+sB3A9cZbFftXVxB1FQTYnupngPbmT?=
 =?us-ascii?Q?MsfWEeAvXJ0CXCKKSpl6J5Avmsn6RDMWPCFz47Im8CTUEXs/pGNQ/A9YfeD0?=
 =?us-ascii?Q?wfC2jEu6Q1E11AQh6HgIp6OYQZB+Wwg7U+FH0u5nt/cg69ptXhV5Bv5GpB4P?=
 =?us-ascii?Q?1KjO2/wZdkv82uNzwQCWLq7GAxOlKGdszOrNd+TdkC0HPu5I/DPFQbVC4aAM?=
 =?us-ascii?Q?whcY6L3F6Jd1aesE30Gyu95Ccc9v2UZnUNDFWtfRK/34RtT6krpVS/V/KEis?=
 =?us-ascii?Q?CIHG5ub4/Kc7ETw+ULsn+API4CHR6pn7aNmHqeu9SwQ3tYXN3iBOt3vOHjc/?=
 =?us-ascii?Q?RDBGFF66/Jd+y36yHYkfEQqp32SD7wYlPQrAuVhKDGOBsVGHcR/iSeIAUv9o?=
 =?us-ascii?Q?8IcWMIXuSK7kyYIhUFAi0X+6kP/PiTYl1hafJYHn5y2KoALwprNPUWzguNRz?=
 =?us-ascii?Q?cXkpVWVPEu5g2JleNQDiXuqvm67wrM+Z8l6MW7oGMao9vt8zloqWbvBUAy8d?=
 =?us-ascii?Q?6Y8qCoVeJ14cG7gHatNkQOpUqWiPCepAbvAGQjgspIshCJRZYVwIfWBbdNIF?=
 =?us-ascii?Q?Wmfj4p9Z5E0vAvXB6IqhQAvsOVqwLKQSl8L4bdTc0H5Jh3dECv08oAqrH3Di?=
 =?us-ascii?Q?VOQc/pNK9YD1F4ndVn7O/KUPmBbfkUui4MyKPxfc8eUGITEKXmOus1YVm+gH?=
 =?us-ascii?Q?FZi32cbPPcjQfKO9ZMZyeGz1FW5AvQYjoM2dL+CV5Y39+6Ijlcq9DUf3GOjY?=
 =?us-ascii?Q?d3KIcPqUZsVE/A0Wnj+5u8zE0X1J+CpHvb2IVYb/XELq1+5JI33Izjn76LX2?=
 =?us-ascii?Q?NbIDq5WyB9Dbs/46yUAOuXTjvlwRrmq2dDPzFH/Okk8QTgj5q3cUIy8DxlCh?=
 =?us-ascii?Q?z7Q6fZQUbZz3M10Xw1zrQhf7onlmA6c4ycHpFiYplDM7MTynqyur+cs8jXZp?=
 =?us-ascii?Q?GJDtUmQoSxZKgCYtV1UbpyGguuGVxfHDv8OTyCkRGg0Et1BHHDh/nvYwPpzX?=
 =?us-ascii?Q?fFtXR2PFyynXicVdqiRgahqXtc8zcsHIWlgbwscyA1EhBbvQee592T/9OHB6?=
 =?us-ascii?Q?oUiQUU9HzD+4WMufIbxo+ZlQXyPyPYjw09HhyZHfjVYsQbfuC+BKzA7R/zmr?=
 =?us-ascii?Q?PjEQZWUPWWsD8kKK0TMWmyds17Hm9fPwE2G/CM0aiSLr+KKzHUCB25a1+xF8?=
 =?us-ascii?Q?ZTOy3y0l1vss0FTj8iBVf8iFI4rTVhiLtsT5B6A8qyqJdOQAoCLAlRd6WsPO?=
 =?us-ascii?Q?TC4uzhVPexOjMu71R9wzW1fOScH41mjemY/cILageoOnZLoKk5Nk84+3VNyQ?=
 =?us-ascii?Q?PG9G2Scl9rm04CQh44ZsEPVilCQR90s5zOEaRsYHSmw2mxgSojML5nBfKoiv?=
 =?us-ascii?Q?jF8KMRviKJHpgzBEIcuThFjO0+lGlRA94HAAX47jKAvRUxycosDSxmMLdMK5?=
 =?us-ascii?Q?FVLmOhn7K3PLNue7bcsUEPcgxDBuHi5kZPLPhuy4avtB4yv+LEyVYnuGMdAw?=
 =?us-ascii?Q?gtcokBrvcsDw0+XXlfemVwXlwOWTsSI/6z/IIdq19yUyIENUjQp6hmGP4Dwh?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e7b54b-2f78-4de4-2c35-08da6b2dc056
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 15:29:07.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTGCt8k0rrwK2sW4F4K4o+GEb9HgqgszQXu+xsjYj+Ix+uEd+AGr+KPDRXS82ksrA+VMAjYtqj4Nc02H6BlmxIDMinVoV2u2Hkdw4PM2U9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5746
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 14 Jul 2022 17:01:16 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In preparation for provisioning CXL regions, add accounting for the DPA
> > space consumed by existing regions / decoders. Recall, a CXL region is a
> > memory range comprised from one or more endpoint devices contributing a
> > mapping of their DPA into HPA space through a decoder.
> > 
> > Record the DPA ranges covered by committed decoders at initial probe of
> > endpoint ports relative to a per-device resource tree of the DPA type
> > (pmem or volatile-ram).
> > 
> > The cxl_dpa_rwsem semaphore is introduced to globally synchronize DPA
> > state across all endpoints and their decoders at once. The vast majority
> > of DPA operations are reads as region creation is expected to be as rare
> > as disk partitioning and volume creation. The device_lock() for this
> > synchronization is specifically avoided for concern of entangling with
> > sysfs attribute removal.
> > 
> > Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com> 
> 
> One trivial ordering question inline. I'm not that bothered whether you
> do anything about it though as it's all very local.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/core/hdm.c |  143 ++++++++++++++++++++++++++++++++++++++++++++----
> >  drivers/cxl/cxl.h      |    2 +
> >  drivers/cxl/cxlmem.h   |   13 ++++
> >  3 files changed, 147 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 650363d5272f..d4c17325001b 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -153,10 +153,105 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, CXL);
> >  
> > +/*
> > + * Must be called in a context that synchronizes against this decoder's
> > + * port ->remove() callback (like an endpoint decoder sysfs attribute)
> > + */
> > +static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct resource *res = cxled->dpa_res;
> > +
> > +	lockdep_assert_held_write(&cxl_dpa_rwsem);
> > +
> > +	if (cxled->skip)
> > +		__release_region(&cxlds->dpa_res, res->start - cxled->skip,
> > +				 cxled->skip);
> > +	cxled->skip = 0;
> > +	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> 
> Minor but I think the ordering in here is unnecessarily not the opposite
> of what is going on in __cxl_dpa_reserve()  Should be releasing the
> actual rs first, then releasing the skip.

Done.
