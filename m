Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3586D575560
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 20:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbiGNSv3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 14:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbiGNSu7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 14:50:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CD75A2CC;
        Thu, 14 Jul 2022 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657824658; x=1689360658;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k0nTkrWJV1cq+B82cZVkPDGm1hiaziWKFN0LizFd36Q=;
  b=PWlF/HfAKsrTYRepuJeFHQqWBDiHTrojxqEQaxU3oacvKoYvboF22O+/
   h32YtpSew1iDkXKoUe/hLtP2H2MTJw8gsGMERFLyhlUX23iNlIhmi8jYv
   t82eECfDkyLNqCs5gLQYgzXEbPoTkqeK6bj6FJLlZn9KC4QuODSmITqAI
   Ds0RW8+x4cVfOkbZGqxKQ+i0YcGR7afYmFB6cDteGnZLeUkw8c+dGXOms
   Ve2Gsb6ZPUFmmOkcnh9fqmTrygmlPHvuXar4/yXRNPwfy3I/60g6SyoTk
   SVWzAMfpruxuxs6YBrJt2q/s0+VtpO/LnTGYq0VlE1cjvpe0ExQRfjVkM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286742878"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="286742878"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 11:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="685679812"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2022 11:50:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 11:50:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 11:50:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 11:50:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 11:50:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jokfdd/L4yp/5tnMAR4By8tMfaG/Jx6B1b6+cGV2nDajNprin08N3LRwJPcHNC4puVUICD16V/cA67OQSNtaTI3TvN82qCruqtO+LLMRhYiOPVmYdXZKl2X12+a5ymwkrtRRF5XKYLuet95jmrjeeLd4qAsif/jMipyQ3pu9uyaSHKIWRkmC7omI9O3pMaQzSh4gJIUp1jA9EGkf7lWyq7LDlHddVbwluSCMKFLmj8BWkxmOsdv1k2i7WDIZ1ERduEPZM8rCeDgrY8yCUWXBZwDBdJt3ggX7WfRSbQt5oD37UTmEmRjHTEpgbIt1xMFj5o83I/ahiP2dERajvxti8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4GFXOtg0vU8mB70dciHfj0rA6dwM7H+f6lwc3yRRPk=;
 b=gVzR2lvUl35MQGLUmEv+041gemzVQMeeitq8gHF25n5QPSKfmrnEVHOwUQ32gdTK+/LSpKKyRFICCQjLzJKeocZGQWEEuMHAzlNxvvomPnrYdSxvhGQmjg6WVz1AZyVXWlD7lUyd1zLMSzkMSeJp6zzJIYkxCtx9gkVERtOVsmR/9ha+pc/nb2g1cQLLrJA0qpr+M6atyAcR4pA3I4ZGkUrgBb+QRBGHP28t+38x91H4RkXCLM5pJ3SLXOSOBpvm/FyIlKknzknk84V3QiJ9TJzqeSAryQ5wFfPbMOMq5TKuATL86NdRU2t/hS4cESqK8+ouvuvyTlIxdBtj4/dttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MN2PR11MB3581.namprd11.prod.outlook.com (2603:10b6:208:f0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.23; Thu, 14 Jul 2022 18:50:50 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%5]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 18:50:50 +0000
Date:   Thu, 14 Jul 2022 11:50:43 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Lukas Wunner" <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V13 4/9] cxl/pci: Create PCI DOE mailbox's for memory
 devices
Message-ID: <YtBlg+epvGE+bQBe@iweiny-desk3>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-5-ira.weiny@intel.com>
 <62cf8dca27760_1643dc29444@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62cf8dca27760_1643dc29444@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8b697be-65e6-44b0-c3e4-08da65c9c59c
X-MS-TrafficTypeDiagnostic: MN2PR11MB3581:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /v8gvEBzqilFkR/fvW78T6qaNSVqa2SvYFXbWO3jPt4vhAFkrU38cXBa3MlUXtmgKHl1tvEg58CL9tmXFsbPrADxEVSJeoXQwKkvkRH1+k+YHwQQaL8V36Kt7w8NL9M+yuTegJK2fonehJ9neL5CuWO+ew/8YsKxMs1xauRGXOvslESMx0rkTqutARxZfgXTQQb0sVOPDpulTiucdC8fb4PZQvD0vzRLhbnwdTuULNNjc1cHMaxHrEmCrRofXR5/bCpT/lz+B9bxpz4MEmsdUjtvgthPMQlpFcWvGgEVLI11ZYFaWMvEqsdCrUqDV+DK0P3SZeibzVZwIUnvGvDJGBw/0kMqeMhdqXtyT8sjWLF7CTYX+fduBtzwVTf7YisH+G3YXpVSL8e9sEhFDD2e9GnVYqpLEUtS8lLzIDsz78biNaT79ANX5vFrahSZfVwI3qtydIx5hxTp1IT5UJ13AU4hhbrVLk6e+V8dp46zxQSGrk1t1M8SgGsK3KJbeXoZhIGu52SyHYUlSs0so5fJK7mvCUzgDHfrgA8k2oI7IW9iJgle0P5nyRfYN7qMR/dXI3P17uISjJZyW0753cdzUSTMc4m0V2XquEIHKFbm5Q4BB2tM1MLxv3R13xZRi11VU7042NTiLVH/j/4PAknGhFydGtl+N9001F7Mqv2NqClnIAh2htLj4UKbVDC3y+kxfTa5IWQP//oE51/5CWJ4ANp+MiI3J1PmRyeELw26520Jo+6TvV1JVgH2bwSZ1+p2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(396003)(366004)(39860400002)(136003)(376002)(8936002)(6862004)(33716001)(66556008)(44832011)(2906002)(15650500001)(6636002)(54906003)(316002)(4326008)(66946007)(86362001)(66476007)(5660300002)(8676002)(9686003)(6512007)(6666004)(186003)(478600001)(82960400001)(6506007)(6486002)(41300700001)(83380400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CEj3vNH7xdv9ZHoISWkP1uLInyWcfK5iUqnOBeSKk3lXOtzRzPVgdIQoGZNC?=
 =?us-ascii?Q?/vazH1O31pKaqBBcVL5RW1/v1zS7VDEUuj918EBOoXR1D4sbkfDich3NSFr3?=
 =?us-ascii?Q?8xtuYUhEz4xpjMBOCfzHFZ8LeskBJ/HHsdUQS/KIqFb2lovsubbnRoR81Dip?=
 =?us-ascii?Q?mu2BOv+zyczcxBOBYt8LTRxATeMTeMEJ7XJjI1ANGn4UQ1Ch4S2ywRklEHGw?=
 =?us-ascii?Q?LsrSzOLzt7MbSFs30a+o+JDUHYPHa9PyEOO4WTciYSxiYWLiI1sw+YWbi+dv?=
 =?us-ascii?Q?th02VjL0gmct/TOzR2yMFswzKsAGTy1Lq4d80BWOzeJcdVSKP8Mw3CiOBfrn?=
 =?us-ascii?Q?72B+dxJxKkakn8/kjVu99nZvVM1xsWAKJJXfEsnCiPFNYRa/kK/MRmJJuzpg?=
 =?us-ascii?Q?qeycHlNUgND2//5cJzXMhxVh3PCUuE4Ngzfx5ANAe7wAl97a7auHyAYKlV1q?=
 =?us-ascii?Q?CLofoCF3eX9nfzRoNuv6M68i3/RTmPTW/PmDKJ05iuiDHyiyZmvUWH7zNXlI?=
 =?us-ascii?Q?n148Pxe5MSo4guQBDvqSwHiC/sgf775LOojjH6k18GLppBrIsKNWO77f9vSC?=
 =?us-ascii?Q?Dc/tiOr5amIVWCHUU47KsUx2QTAytpOBVCPEBjgD921f4HrxjRQmmtCd66hv?=
 =?us-ascii?Q?i2IG/QCWAoO6+M3P6743/pBCqzY8V1HoM6uaXcP/Sdul4Y7pW0SXY0glI3K6?=
 =?us-ascii?Q?HdIICvR0pZLK6H7HG/ITHBkUcLu/KvukWCsOjA4t1QU0IKSZ7TtL5qJgJsBd?=
 =?us-ascii?Q?A7EvjH8Bl3rZaMG7oLTlkhxpaZg6YUgfgqG+dvfpwSgrddj4G7A1+nMvFKLF?=
 =?us-ascii?Q?VczqZ+1xJr1MYJAEqoBtEMbFC0B0xUrV+Ys+ucsxDqyHYX/TBzND9NR/vf3t?=
 =?us-ascii?Q?UDWJ1hr8SEFtNpSns1ndP7r2AbcQsoDfgdvi/5ROlfakKgwZqrWKwd/qKsE/?=
 =?us-ascii?Q?ePR+rE29ht92skFQR0U+PonCE/EIfN3qf5/2H8Z5HpUG0z0a4uNisqsylsUT?=
 =?us-ascii?Q?gp3jLzK6NNeAdpzW1wTMgDgQzAEX87/JzckUlRVq0Bh7yAjozPsZueaa0wcJ?=
 =?us-ascii?Q?q0k1TWYN92pfF+PDk8O11BpicnT93Ih1FzreM5GFYppFnosou86UHbi44lEo?=
 =?us-ascii?Q?aXtXoijkL8p8ImWFXWDuaRA5q4VxoD7he1rWiMz6xUjDd86KITl9ZCFHxPAO?=
 =?us-ascii?Q?3tmlHhkv6C/90NYhMyS+ITHwA0VGq0DMB79jrm/6H01enH5ODvzNztu4CTQx?=
 =?us-ascii?Q?FIKwO/QyDWMjuBFrf+JN+EPIMvKQtUE3WwXJkE46dwW2P0/3TEvxUXbUCNPd?=
 =?us-ascii?Q?p/LaJV01GOUQJDKBCoRXSr8n3lyuctVZK/VTXsimMNtDuARHvEoygB0LctTT?=
 =?us-ascii?Q?JBTtavlP1lcPeNDRaMsIyEhWK2hpzU8G9CJkkrXH9GNPw2emUjaCzpmUJEtP?=
 =?us-ascii?Q?ldWOf2gW1xtnFv7fclSS+8HB/qzIjyqxs9HFO+8hKti5jIrRLywBG5YVlu7l?=
 =?us-ascii?Q?a1M1HGMhOzQRPHfQlgtoItHEYqZHIICrqoJGdT4q5jN5wxtjN6tpaY79Op/G?=
 =?us-ascii?Q?6B352HZOqPmLH2J9kcHHRMrYyyBz/s0R/o5OA4ZK8uVhtZhsde/dFS7JbqgI?=
 =?us-ascii?Q?q/Gdg7z5dbR0arjiU1KgDRNOY2Blxg2y5SzCjLuzgQNR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b697be-65e6-44b0-c3e4-08da65c9c59c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 18:50:50.5500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRmRuusTUVjpE2Pd/y6+lh7iJ9O2JT2DOHhjaXdne+1DQgk9F44GHZwaVPdnNa7FydYZvqTCPByVAa9VDyPtQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3581
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

On Wed, Jul 13, 2022 at 08:30:18PM -0700, Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 

[snip]

> > +
> > +static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	u16 off = 0;
> > +
> > +	/*
> > +	 * Mailbox creation is best effort.  Higher layers must determine if
> > +	 * the lack of a mailbox for their protocol is a device failure or not.
> > +	 */
> > +	pci_doe_for_each_off(pdev, off) {
> > +		struct pci_doe_mb *doe_mb;
> > +
> > +		doe_mb = pcim_doe_create_mb(pdev, off);
> > +		if (IS_ERR(doe_mb)) {
> > +			pci_err(pdev,
> > +				"Failed to create MB object for MB @ %x\n",
> > +				off);
> 
> oh, the rest of cxl_pci driver is using dev_err() and dev_dbg(), not a
> big deal, can be a follow-on cleanup to make it consistent.

Changed since I'm reving anyway.

> 
> > +			continue;
> > +		}
> > +
> > +		if (xa_insert(&cxlds->doe_mbs, off, doe_mb, GFP_KERNEL)) {
> 
> xarray all the things! Nice.
> 
> > +			pci_err(pdev,
> > +				"xa_insert failed to insert MB @ %x\n",
> > +				off);
> > +			continue;
> 
> Lets make these error messages more actionable:
> 
> "Failed to setup DOE, CDAT data may not be available"

I really wanted this to be generic rather than mention something like CDAT
here.

But I see in the other patch you mention skipping the creation of all the
mailboxes and just grab the CDAT one.

Let me resolve that first.

> 
> > +		}
> > +
> > +		pci_dbg(pdev, "Created DOE mailbox @%x\n", off);
> > +	}
> > +}
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct cxl_register_map map;
> > @@ -408,6 +446,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (IS_ERR(cxlds))
> >  		return PTR_ERR(cxlds);
> >  
> > +	xa_init(&cxlds->doe_mbs);
> > +	if (devm_add_action(&pdev->dev, cxl_pci_destroy_doe, &cxlds->doe_mbs))
> > +		return -ENOMEM;
> > +
> 
> This belongs inside devm_cxl_pci_create_doe().

Done.

Ira

> 
> >  	cxlds->serial = pci_get_dsn(pdev);
> >  	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> >  		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> > @@ -434,6 +476,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  
> >  	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
> >  
> > +	devm_cxl_pci_create_doe(cxlds);
> > +
> >  	rc = cxl_pci_setup_mailbox(cxlds);
> >  	if (rc)
> >  		return rc;
> > -- 
> > 2.35.3
> > 
> 
> 
