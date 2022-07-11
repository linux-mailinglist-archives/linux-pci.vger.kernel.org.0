Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EB8570B1F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 22:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGKUGH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 16:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGKUGG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 16:06:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA827B17;
        Mon, 11 Jul 2022 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657569964; x=1689105964;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NRFS9b6YZCP3eHzO3UPYKSbPNwo8WIfxJn895PJvQz8=;
  b=JfXW3yd0N67wtKmMev2xii2OgbZVo02Jc40oHd7tTNT5Uw3rjO5UWSnB
   wmVYucgc4tnGST+Rcy+DiQEacwQGUMgCPXTkMDWTezpZTbX6ALsMsgih2
   m3T8rZL5O2saDIJROYbQ+aKF4pHwiksKJhlzMsgyAtm2ynMKM7mHYvBeT
   283i9sgITbkMioXGbvkEF8LoCNZ3tcV9Xw2NsiOMsEnlnc1Qu2/jKCATD
   hu205wUEjuHHr8s5myg4yUDUSl9En1UjcNXaMuRdmmBH8KXlWuDECfjmw
   IEVu48J1e7AV6vBujy4iPdMF3Y7ki/zjH6WBNDhuwiZ5T0qWymDY/CQ9N
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="267797707"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="267797707"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 13:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="662679020"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2022 13:06:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 13:06:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Jul 2022 13:06:03 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Jul 2022 13:06:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lL3sJxukgPG88YQrbEaCCZbiJH4OyZOtjD26wGiCIlg80nhCSV+qwamiHXPOE1sXc1evKaPeUZxLPe9NcJQC2n+JlaA6KuOVrdS4JQ+JrJFc1mJPfLQhTGbzIF9+ZlEioktExnnIu10ab5+iP3r3hxPnTqrHivYVZagpnYLFNiKIj3do6QXaSZ8yPp+gukzb7r/6DofrMpO8gXD4uAx7ep7sczMnJ6w6frZYJYeCUHrjrPb1O7h/281/+1KB4KJydHOGASEmCKcFMmG7R9o5q7WP2vAtiZJOR5qi5TBfxoxvySh3oyIZXE+yqE3FNKoW0/AQryp2CuwuH6nO5o2R4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnzwSwKeVYRLNBTVWR0zF8dzrsmt88e7OOuJ64xhhtI=;
 b=O9iT7V1xzI+ZVMhUrbZazIY6IyCDFkpiqC7soP+O3LRFvmPHqbnbvTK7jcWfGegTR8hJbv37r+7FutCcuTjpIE+HYjMd6bvykx94/IyrNd9uSBJURwr8UwKNfL/cCuuhyks8+Kip9Fa9pvnUkUXE56bhRJMB3qaYFCRgCfgeCyqRJch/Mxw3Ee01I+QZN4ZgiGDvZb93ymO2+SJjmu9s40f43qob0Zy/8/l5lgMHKTWkpjpX22z8Gl1zgQisA/Piil0VtYEFgp2mqsI+VWJDwvQryeDhyWewRv6xTJrmF1jlMK9+P+tjpti4O82v+Yif1PQSFdRVjDf+ln7RZHr6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BY5PR11MB3959.namprd11.prod.outlook.com
 (2603:10b6:a03:187::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 20:06:00 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Mon, 11 Jul
 2022 20:06:00 +0000
Date:   Mon, 11 Jul 2022 13:05:57 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 46/46] cxl/region: Introduce cxl_pmem_region objects
Message-ID: <62cc82a533fcd_3535162941b@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-21-dan.j.williams@intel.com>
 <20220630183453.00007b56@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630183453.00007b56@Huawei.com>
X-ClientProxiedBy: SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::11) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27259c6f-a3ec-4825-312f-08da6378c63b
X-MS-TrafficTypeDiagnostic: BY5PR11MB3959:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GcLj9XxTiux6kIFDD4w6iUBVrR/StYmaJWfw3NsOkqORsW019TiIE+pny9aH9+QAi1KEwVx1qpB66k2yIL7UYJE0lI7/dK91p33RRXswue85LUIFHp9IKrqbrKLZ6lXmpN58HoXg1/gTsrQd4ZIo+Dr4Y6mqsol+68T9x3TN8W6KkyY0+joJr67IYc/Obk40dw7iCj0UQtCoRcauaGmZjUi3361FqEt/QrjYV2fUYVlN/WTrNhFSf/uzKqKuCtjUIrBXbmKigSc0Uc45qrJ1udmThyzsKUevoP7yOFAPzNA9SD4xatDk5OydlqH7PKMWjRX4mxcRJRyu5JWCtMzE+JlqA4/vqlMLHSxDq7daxhepIGhM6bml3lUxKSSwP4PswgcEfQZAvnMZcpb2Bn9Fzben9rRbL/fGqcXt/6MtwQgULHrY8MyEOenz15dYbkpP123sX5yQDnSwGvdxOPcNosl+K06sLmUDRMpiC62yflS0vnfndbPPtFM3YAXlPgyG7+9/D9TRsG86pqqKcWiH9iwnLJSJTRRJL9lW2pzOGG+9xppIUyPc2tqRHKmpCrh5pW+/9v5fUtTuhhkAzfmdzIuPWVO97+Vp+/WzcgnmFIJrtfNR1hh+1n59lgUZDwsehDatmo/ZVDl2eo42W403xeFUrVGEQNZ16BPEQru6W9tI8iE7/t4xbUf8OXwp11QFr9bhZ3XxvrbiI2D1RxGoxIcDQoGE1TLzxK+ioejrUaeBLJnqnUnqB2v8Knv00mfHfSg5C3q/5eiVBYz105RNTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(136003)(39860400002)(396003)(86362001)(9686003)(38100700002)(186003)(83380400001)(6512007)(82960400001)(6506007)(26005)(8676002)(6666004)(8936002)(4326008)(66556008)(478600001)(6486002)(66946007)(66476007)(41300700001)(316002)(110136005)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RA1lSz4jYT25ta1BWZTtsUooTjhnoKU3LiJv8zwT7MSMFE+N8MaEVYQuOkVY?=
 =?us-ascii?Q?2rOQiqAI+9UfGr+vRwljrk4CryEJUqFjGTXQow59rwPMmLCVh4JP+e3kj/mF?=
 =?us-ascii?Q?jwgdVPnyIy/W0jidka6AgdlhbYLhvtnWwq24QEttDIH4fVUybVX52ekGam4/?=
 =?us-ascii?Q?/Db4T1AMU4OMhU69H9YnvVJbxmePdHfPh8P9q0TU+NEYIQrxOE28Yjc3n2rh?=
 =?us-ascii?Q?+warDhmLNmjGx5ToipbyumB2SBLlzUYQFnaxHKYjwiCumGY3N9qoOLH1dmEw?=
 =?us-ascii?Q?uz9oAqKxDoUYq9Pj7CYbh9YGdKrI4AVaIlYQqlV/U0pZ/Y6hSm2XlC6RNJot?=
 =?us-ascii?Q?BUL6qKZ3Kv/T+7U1maDLfu8FzXLqYXJUPjY8Hir0AqcEWxl/sKaNuY3fGVm7?=
 =?us-ascii?Q?UxI+WSrxzpJSC9AcgioPfddCZ/rFDanJ55S6u2aLBELB2m4kdpfe+oOnYfLT?=
 =?us-ascii?Q?GVkOP3VzC7SSrCU8i91Yg1Mcl/zMFhZezhMHlgY2IA0WbmJs8Jm17RDZSCxL?=
 =?us-ascii?Q?7cDkGUnYKr2wThV3Fw3eeddrdg8zMrnL3qLVNXDAyV1Agamwg2uGeD9MKBZZ?=
 =?us-ascii?Q?4jNTFj7Ic7sGhATXBXBRu8HV+Ee6Xtsy1JnYfSmRKkVnqHzS2sx+3LoumgEv?=
 =?us-ascii?Q?nLXOnZVvTreK8AlWbmHVx1WSg6RON3zR9fm3b6p8iGYAo+ihGgvElc7jjmII?=
 =?us-ascii?Q?VlgDz6Qlqd2EmSwokfR/Qipzz2lfmNuetsQLl06CHrHulv/PaVbfLf9c9gcH?=
 =?us-ascii?Q?sU4eKaXRCPntbuznOfWWG/MVRjWXjBAT6gsG06Qpa+BdYQYS8CgazqHOU9u6?=
 =?us-ascii?Q?cy77FcmNy/MD5emUkO0uHuWurZrDeRw80wadFjCyy4a8McfH6/yxj+Nm2rHQ?=
 =?us-ascii?Q?l8jhgCu6e7W5Bjhn0h7O6C9JrxHkMSWkb0Uf1ugvMJgcIReEFBEUrYXtIono?=
 =?us-ascii?Q?7mwapumaQARoi7JMQXoZqVtJvhNELcxXg/nwtSeU0Ah947dWbhzTAF5jpiyt?=
 =?us-ascii?Q?hyK24YiJPclh0TGLwgUHRHt7DuxzVCa2geCE4k6qkM7kk5Fm8CYUyi+QQ+OV?=
 =?us-ascii?Q?uhTR6mMMg1fT9zcijdmFLL9UZXxKXb7G6eHRG0n8KZecy1bNqZC9e1t1dfy2?=
 =?us-ascii?Q?yYxmQhdmsw27Ka78Z1v2NSGvPgLEEaD/c1pG7YWfrtIRMG3zJdGMYaWLsyhB?=
 =?us-ascii?Q?iStSAL6nzOrSwLHFDzyiV6D8jy+7hAG1JCvR2AduyWYQrT4QrUJGEBRt5jrt?=
 =?us-ascii?Q?EZvG2Q3XdoFIaySnqzVZ31+ZFSf8apIu57D/K5NNUz7Cpd58nN0bgyywf5Ob?=
 =?us-ascii?Q?Xc/tcgss0/pwy5ZqotCFegHtgGtRgrdBuNo07Ohr4z/BFE37rCax5gR3+4xb?=
 =?us-ascii?Q?9HFYGcn2GGhHgCb838Q40I/chIUVYmKfMlOak5OQo/qgfb8u8RV0F5khReY0?=
 =?us-ascii?Q?waXMUz6mihKKlpWGxxaB65QTVOR9Vbf7glrtHTBv/Ft3EwJIteW4i4f45t86?=
 =?us-ascii?Q?cgN+giU1pQ0pzg0XgDo/eenFHcQDZxS6B/I6kVN648lRBVWjb4JfJIrJrcR4?=
 =?us-ascii?Q?JmvDaehc2Pt7oBBB3sZMauFTp6hCsPdVx7Elut4nj0/JU9zDz/6s05XPWGYZ?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27259c6f-a3ec-4825-312f-08da6378c63b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 20:06:00.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omjYDRRzoCKY5LPulHYpaticpxMnLQoS3pGTbRRKuS/aTAF1HZZm3sRSTzjX86jf7joAQeWRftLyiuL4izKdRbNhIEue5oOH48qqImrbXzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3959
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 21:19:50 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The LIBNVDIMM subsystem is a platform agnostic representation of system
> > NVDIMM / persistent memory resources. To date, the CXL subsystem's
> > interaction with LIBNVDIMM has been to register an nvdimm-bridge device
> > and cxl_nvdimm objects to proxy CXL capabilities into existing LIBNVDIMM
> > subsystem mechanics.
> > 
> > With regions the approach is the same. Create a new cxl_pmem_region
> > object to proxy CXL region details into a LIBNVDIMM definition. With
> > this enabling LIBNVDIMM can partition CXL persistent memory regions with
> > legacy namespace labels. A follow-on patch will add CXL region label and
> > CXL namespace label support to persist region configurations across
> > driver reload / system-reset events.
> ah. Now I see why we share ID space with NVDIMMs. Fair enough, I should
> have read to the end ;)
> 
> > 
> > Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> End of day, so a fairly superficial review on this and I'll hopefully
> take a second look at one or two of the earlier patches when time allows.
> 
> Jonathan
> 
> ...
> 
> > +static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_pmem_region *cxlr_pmem = ERR_PTR(-ENXIO);
> 
> Rarely used, so better to set it where it is.

Ok.

> 
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	struct device *dev;
> > +	int i;
> > +
> > +	down_read(&cxl_region_rwsem);
> > +	if (p->state != CXL_CONFIG_COMMIT)
> > +		goto out;
> > +	cxlr_pmem = kzalloc(struct_size(cxlr_pmem, mapping, p->nr_targets),
> > +			    GFP_KERNEL);
> > +	if (!cxlr_pmem) {
> > +		cxlr_pmem = ERR_PTR(-ENOMEM);
> > +		goto out;
> > +	}
> > +
> > +	cxlr_pmem->hpa_range.start = p->res->start;
> > +	cxlr_pmem->hpa_range.end = p->res->end;
> > +
> > +	/* Snapshot the region configuration underneath the cxl_region_rwsem */
> > +	cxlr_pmem->nr_mappings = p->nr_targets;
> > +	for (i = 0; i < p->nr_targets; i++) {
> > +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
> > +
> > +		m->cxlmd = cxlmd;
> > +		get_device(&cxlmd->dev);
> > +		m->start = cxled->dpa_res->start;
> > +		m->size = resource_size(cxled->dpa_res);
> > +		m->position = i;
> > +	}
> > +
> > +	dev = &cxlr_pmem->dev;
> > +	cxlr_pmem->cxlr = cxlr;
> > +	device_initialize(dev);
> > +	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
> > +	device_set_pm_not_required(dev);
> > +	dev->parent = &cxlr->dev;
> > +	dev->bus = &cxl_bus_type;
> > +	dev->type = &cxl_pmem_region_type;
> > +out:
> > +	up_read(&cxl_region_rwsem);
> > +
> > +	return cxlr_pmem;
> > +}
> > +
> > +static void cxlr_pmem_unregister(void *dev)
> > +{
> > +	device_unregister(dev);
> > +}
> > +
> > +/**
> > + * devm_cxl_add_pmem_region() - add a cxl_region to nd_region bridge
> > + * @host: same host as @cxlmd
> 
> Run kernel-doc over these and clean all the warning sup.
> Parameter if cxlr not host

Fixed.

> 
> 
> > + *
> > + * Return: 0 on success negative error code on failure.
> > + */
> 
> 
> >  /*
> >   * Unit test builds overrides this to __weak, find the 'strong' version
> > diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> > index b271f6e90b91..4ba7248275ac 100644
> > --- a/drivers/cxl/pmem.c
> > +++ b/drivers/cxl/pmem.c
> > @@ -7,6 +7,7 @@
> 
> >  
> 
> 
> > +static int match_cxl_nvdimm(struct device *dev, void *data)
> > +{
> > +	return is_cxl_nvdimm(dev);
> > +}
> > +
> > +static void unregister_region(void *nd_region)
> 
> Better to give this a more specific name as we have several
> unregister_region() functions in CXL now.

Ok, unregister_nvdimm_region() it is.

> 
> > +{
> > +	struct cxl_nvdimm_bridge *cxl_nvb;
> > +	struct cxl_pmem_region *cxlr_pmem;
> > +	int i;
> > +
> > +	cxlr_pmem = nd_region_provider_data(nd_region);
> > +	cxl_nvb = cxlr_pmem->bridge;
> > +	device_lock(&cxl_nvb->dev);
> > +	for (i = 0; i < cxlr_pmem->nr_mappings; i++) {
> > +		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
> > +		struct cxl_nvdimm *cxl_nvd = m->cxl_nvd;
> > +
> > +		if (cxl_nvd->region) {
> > +			put_device(&cxlr_pmem->dev);
> > +			cxl_nvd->region = NULL;
> > +		}
> > +	}
> > +	device_unlock(&cxl_nvb->dev);
> > +
> > +	nvdimm_region_delete(nd_region);
> > +}
> > +
> 
> > +
> > +static int cxl_pmem_region_probe(struct device *dev)
> > +{
> > +	struct nd_mapping_desc mappings[CXL_DECODER_MAX_INTERLEAVE];
> > +	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
> > +	struct cxl_region *cxlr = cxlr_pmem->cxlr;
> > +	struct cxl_pmem_region_info *info = NULL;
> > +	struct cxl_nvdimm_bridge *cxl_nvb;
> > +	struct nd_interleave_set *nd_set;
> > +	struct nd_region_desc ndr_desc;
> > +	struct cxl_nvdimm *cxl_nvd;
> > +	struct nvdimm *nvdimm;
> > +	struct resource *res;
> > +	int rc = 0, i;
> > +
> > +	cxl_nvb = cxl_find_nvdimm_bridge(&cxlr_pmem->mapping[0].cxlmd->dev);
> > +	if (!cxl_nvb) {
> > +		dev_dbg(dev, "bridge not found\n");
> > +		return -ENXIO;
> > +	}
> > +	cxlr_pmem->bridge = cxl_nvb;
> > +
> > +	device_lock(&cxl_nvb->dev);
> > +	if (!cxl_nvb->nvdimm_bus) {
> > +		dev_dbg(dev, "nvdimm bus not found\n");
> > +		rc = -ENXIO;
> > +		goto out;
> > +	}
> > +
> > +	memset(&mappings, 0, sizeof(mappings));
> > +	memset(&ndr_desc, 0, sizeof(ndr_desc));
> > +
> > +	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
> > +	if (!res) {
> > +		rc = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	res->name = "Persistent Memory";
> > +	res->start = cxlr_pmem->hpa_range.start;
> > +	res->end = cxlr_pmem->hpa_range.end;
> > +	res->flags = IORESOURCE_MEM;
> > +	res->desc = IORES_DESC_PERSISTENT_MEMORY;
> > +
> > +	rc = insert_resource(&iomem_resource, res);
> > +	if (rc)
> > +		goto out;
> > +
> > +	rc = devm_add_action_or_reset(dev, cxlr_pmem_remove_resource, res);
> > +	if (rc)
> > +		goto out;
> > +
> > +	ndr_desc.res = res;
> > +	ndr_desc.provider_data = cxlr_pmem;
> > +
> > +	ndr_desc.numa_node = memory_add_physaddr_to_nid(res->start);
> > +	ndr_desc.target_node = phys_to_target_node(res->start);
> > +	if (ndr_desc.target_node == NUMA_NO_NODE) {
> > +		ndr_desc.target_node = ndr_desc.numa_node;
> > +		dev_dbg(&cxlr->dev, "changing target node from %d to %d",
> > +			NUMA_NO_NODE, ndr_desc.target_node);
> > +	}
> > +
> > +	nd_set = devm_kzalloc(dev, sizeof(*nd_set), GFP_KERNEL);
> > +	if (!nd_set) {
> > +		rc = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	ndr_desc.memregion = cxlr->id;
> > +	set_bit(ND_REGION_CXL, &ndr_desc.flags);
> > +	set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
> > +
> > +	info = kmalloc_array(cxlr_pmem->nr_mappings, sizeof(*info), GFP_KERNEL);
> > +	if (!info)
> > +		goto out;
> > +
> > +	rc = -ENODEV;
> 
> Personal taste, but I'd much rather see that set in the error handlers
> so I can quickly see where it applies.

Ok.

> 
> > +	for (i = 0; i < cxlr_pmem->nr_mappings; i++) {
> > +		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
> > +		struct cxl_memdev *cxlmd = m->cxlmd;
> > +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +		struct device *d;
> > +
> > +		d = device_find_child(&cxlmd->dev, NULL, match_cxl_nvdimm);
> > +		if (!d) {
> > +			dev_dbg(dev, "[%d]: %s: no cxl_nvdimm found\n", i,
> > +				dev_name(&cxlmd->dev));
> > +			goto err;
> > +		}
> > +
> > +		/* safe to drop ref now with bridge lock held */
> > +		put_device(d);
> > +
> > +		cxl_nvd = to_cxl_nvdimm(d);
> > +		nvdimm = dev_get_drvdata(&cxl_nvd->dev);
> > +		if (!nvdimm) {
> > +			dev_dbg(dev, "[%d]: %s: no nvdimm found\n", i,
> > +				dev_name(&cxlmd->dev));
> > +			goto err;
> > +		}
> > +		cxl_nvd->region = cxlr_pmem;
> > +		get_device(&cxlr_pmem->dev);
> > +		m->cxl_nvd = cxl_nvd;
> > +		mappings[i] = (struct nd_mapping_desc) {
> > +			.nvdimm = nvdimm,
> > +			.start = m->start,
> > +			.size = m->size,
> > +			.position = i,
> > +		};
> > +		info[i].offset = m->start;
> > +		info[i].serial = cxlds->serial;
> > +	}
> > +	ndr_desc.num_mappings = cxlr_pmem->nr_mappings;
> > +	ndr_desc.mapping = mappings;
> > +
> > +	/*
> > +	 * TODO enable CXL labels which skip the need for 'interleave-set cookie'
> > +	 */
> > +	nd_set->cookie1 =
> > +		nd_fletcher64(info, sizeof(*info) * cxlr_pmem->nr_mappings, 0);
> > +	nd_set->cookie2 = nd_set->cookie1;
> > +	ndr_desc.nd_set = nd_set;
> > +
> > +	cxlr_pmem->nd_region =
> > +		nvdimm_pmem_region_create(cxl_nvb->nvdimm_bus, &ndr_desc);
> > +	if (IS_ERR(cxlr_pmem->nd_region)) {
> > +		rc = PTR_ERR(cxlr_pmem->nd_region);
> > +		goto err;
> > +	} else
> 
> no need for else as other branch has gone flying off down to
> err.

Yup.

> 
> > +		rc = devm_add_action_or_reset(dev, unregister_region,
> > +					      cxlr_pmem->nd_region);
> > +out:
> 
> Having labels out: and err: where both are used for errors is pretty
> confusing naming...  Perhaps you are better off just not sharing the
> good exit path with any of the error paths.
> 

Ok.

> 
> > +	device_unlock(&cxl_nvb->dev);
> > +	put_device(&cxl_nvb->dev);
> > +	kfree(info);
> 
> Ok, so safe to do this here, but would be nice to do this
> in reverse order of setup with multiple labels so we can avoid
> paths that free things that were never created. Doesn't look
> like it would hurt much to move kfree(info) above the device_unlock()
> and only do that if we have allocated info.

Ok, but no need for more labels, unconditionally free'ing info and
trying to unwind the mapping references can proceed if @info is
initialized to NULL and @i is initialized to 0.
