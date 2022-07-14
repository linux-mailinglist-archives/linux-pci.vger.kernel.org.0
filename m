Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0B7575120
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 16:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbiGNOyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 10:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238940AbiGNOyO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 10:54:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4824D79;
        Thu, 14 Jul 2022 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657810453; x=1689346453;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R0MQY+TsU/R7528c92SinEiSabQEJF7WNeNLyUIcjX0=;
  b=LgFTxPTuEOLkJzC5r/LbMcQD/4HYVYpRbXl8MbGZUMDc6J8F6llqSKgR
   M0kMpwgLU6U9LrQqq4bN2Q5wGiWDQZrf+TK9Z7u91oppqNSofMRVmfsC+
   0Ck6NXtPwrON0E2coDra68uvzXx2xb1rtHMAIABZSFi819mpn6K1npxND
   bQ54GJJEZ63l6Kjt54NC6tZwqEEIpFI2yomEnCKkmQVtbE3Z1RFC/f0Q8
   BGCbMZedcOGwOPSh+jDPqvUeGLtIugs82tb1CcBUhAlnZJTqNukqgrREx
   mLWddmKcaMOD1CDI3CpDmWRwDgGO0qypyNGl35u8G4YcUkFfuGPNmT/j0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="311185780"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="311185780"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 07:54:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="653901696"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2022 07:54:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 07:54:11 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 07:54:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 07:54:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 07:54:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOWL4TS6KiO8LgwU3I+f9u5xxPrj78/5PFlFaAAC/J8xig69GOCfEvg70Jl1VFYJ9uxYyJQJWTm5ISKQOP2Bk31F9qsGHJ0mc1VzegZIZmlbpxWixOloFRy3LJassBBRP9ou3VlazhTInFL8pmFhz2OaOTyqMFZgz6ztD8Goox6ywaA+v04GiLOA2BhlhRrByy2pZ2iCHkmzI8A97C3oliGEJqwpLU5k0qtDflJX9Qu+pTw/WdVTSiMH5132YtHygMjBvLEsFe3PCCUuD9ZekAtnrp5Oveb/V7pnTgRUWJ1CzPlYqFLagWhQrprx6m0Qfu9/VMb6/XTsiMu/ownjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8lNeWhSZHlOPpGI8Lr6Amj0Q92cFUk9CnGC0extYqA=;
 b=idspYoc7OB0p6IMrbaeMJpYX4Jbr9JrzaB94FFmJPi5SSG3m04DSTz2UlOyRusrLXPxw99Ula/P0ZVHhkJHOskBIuA/QsFySuQnjIvvTqLVSNR/QYChy3WawTlF4hVeJ9sTSLfLFQCemy0JdAX+Ll0u9YX6LmZvZ7jZsAF//FPB4eSQVVNZCJxU+rqB5COw4/QFrUqOVYg1Pa5eYBvAG1XwLfeyjvxkKQUWmL3pXnufHJ1no5tQsVSb60+LMgnu4plUE+lXDwSPrZ4btJD1sYz4hL0wXDMuia0p6IQbk9rwg5U2SV/NNA06jyNyK6Q4cI1F2J684LoLEUGQupim3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CY4PR11MB1718.namprd11.prod.outlook.com (2603:10b6:903:2c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.23; Thu, 14 Jul 2022 14:54:09 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%5]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 14:54:08 +0000
Date:   Thu, 14 Jul 2022 07:54:00 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V13.1] PCI/DOE: Add DOE mailbox support functions
Message-ID: <YtAuCLg2iEePyK9q@iweiny-desk3>
References: <20220705154932.2141021-4-ira.weiny@intel.com>
 <20220711222748.470340-1-ira.weiny@intel.com>
 <Ysyog0OFUu+5MIxT@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Ysyog0OFUu+5MIxT@casper.infradead.org>
X-ClientProxiedBy: SJ0PR05CA0126.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::11) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25bf0d3e-c7ab-4856-7f6b-08da65a8b489
X-MS-TrafficTypeDiagnostic: CY4PR11MB1718:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znvRkcstGWZik0+tVCzyVAzG3it52wntXF4ckepBZXHAV9Xh61S/lDykVDkdkL0EBqHBzgy2y6U61ZHwqU/g7xwZLB13yECa/BDqRQneKXCER9ZJhvyadVpaI0D1ox7NBrBpi+9TTLTVmgScO+OBAzM3z/27IL3GBCXPlpyJFpHl+WvlEmPhJEmFxCtrf/lBSRUv8SSOoGTOfMAsIARWIVHW9hoJGB/WJsKXtva0erByBkgIM4JYO599GPYMcUUMsXY4bkWtIiv3W2CmsQpJFxDPxTHmuI7DmBYzCnIpk2ziEo9Ze+4yuxO+ikWdtElxCKM3vmXaVmsuw/L16EkIXdxfKQZSpbi648nm8/z8BuOLe60ZOt9miHsIoQEuhIYbs2zdAD1657PVRQcq8wOxRXpgqpx4Z1ojV+6GvuHia53+xboDqnvZMGPydBNXBlh+A+xS3yA+W1KMU5ImN5mH9ZOqcIv9yQowLFO4gDyzCB6QEwv6I2Lzoj0lFnRDPS2rBEFncKKnGXkwnJ5ypjiKpl1E2f18d18EyQNfSjfinmTaTXucSzj4Sf1NSCFWQvhU9RtF5XqNC7DxZbUn+b3vAm2iQiLajHahqHn+gJMkXalm+njTU6YFjnZpxVmkO822o+WSNTu6t12HoSbAnYylQbM1AlHH0WJBr3jYK67OKfTmqTeEPqLGi9WglNi4dGp6VM2rel6b09bR3kY3aDBIHhDDrqM+syPs/3TEsElcp3vHQiTRGbLeiR0ry0O0AOzu9X7gZe/DDGbPF884trKKiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(346002)(39860400002)(396003)(376002)(2906002)(15650500001)(66476007)(5660300002)(44832011)(8936002)(66946007)(4326008)(8676002)(66556008)(54906003)(33716001)(6916009)(316002)(6512007)(86362001)(9686003)(6506007)(6666004)(6486002)(186003)(41300700001)(82960400001)(38100700002)(478600001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fhezgeJy1ai6GmsCAbO2VPoW+ss1ycZ33/k+ekG6IwyygPJc9tZJOf7u54oc?=
 =?us-ascii?Q?P+6MtLYAQaa6/NYGeLGgCoepn7wRfvUFxHqma3LzzH7bXJclSeZFXc1u2C0T?=
 =?us-ascii?Q?fd0Nkewqib99QmTGDPNQgckIOn8smCNqX/wYTFHqtfutjHGNViVqm2oQ2Idv?=
 =?us-ascii?Q?fxoaxEhNjE3DItaf347BKukTEc+sLi9nIUA+zEsmCjj13W8NidO9SUuzESIE?=
 =?us-ascii?Q?Ox6ZW6+zvA/MvAeO6bfWNijWQV+i7fXv5WqyZ+kZmo1RO5te5DFmgolcpWqz?=
 =?us-ascii?Q?O5QhIeJF6Jp3BwjZT5GeiEqwSEYcQn0Uv5BRr/h17gcHrenBdx6kx65sOxvN?=
 =?us-ascii?Q?5pOC7gyZJNvq0veR+08RlKr4Z9UmSH+KPHY7xIBnCKDSEtDiIo4zqd/Nu3GK?=
 =?us-ascii?Q?3i/Yoeus7WpHIWNRoc7UnM1b97l1Lq5BNTCWBZ+LoyuHB4glG0IloLWbLE9/?=
 =?us-ascii?Q?Ub/I5gpkitPe52DgBmSehES9Q+7DnQ8QETBmbXp9T02XoJgUTMGZhIt4+w+m?=
 =?us-ascii?Q?/KDo09GL1IisLVedHPl7AKm28o/6wwMveVUKQsTBo+56sIqBbYyshj/aJ9Nv?=
 =?us-ascii?Q?734kgImMzSjz6Vz64qVyiAjD2v7L62Rm+o8gafvNB1wwlmp8DrPG+qwc5uuO?=
 =?us-ascii?Q?M/W8wK1ilm31cg+oeWprJcjR0V6ReBPjPIwODNMK4dqmguAhGPzXhHeCSdJ5?=
 =?us-ascii?Q?nR/QCeo0ncGwU+tPOL8BKeDdE5/7OAxFI5HOK2fWfs5qoL8H66Dr8bp6yRfH?=
 =?us-ascii?Q?pvlemaCvMiR+Q37O3nfC1tDxHuhIOxHDmoS+auoO8rsAz75xXzQXzxtqjWaU?=
 =?us-ascii?Q?DFO4wsPqyLjmtLss4nO62wMbAvmGeUazHakl1B3mUCZ2TtRZUokmVNS7aEnV?=
 =?us-ascii?Q?NCHo9T/9a/A3Ig8Ps0JV55Xh8DOSNqQ21U7uvWXGaYtGYt7cOeebUKuShvZ+?=
 =?us-ascii?Q?mMSPsr9XPoj8/yv/Chg6NxVBRX1O1mkEgrnTFdYETTIztA2onjYgpJclUM4W?=
 =?us-ascii?Q?fZDWjtRLTccVsqGKiX3Ga8dJJoUjAinnteqGldU61qGpDyfNYjxh5eSzhhKe?=
 =?us-ascii?Q?zk0I0WYTjRMciLwFT2FtbBjJpU1DzAQk/ATS0plCL1GOUwqHkHPGjSb3XAYQ?=
 =?us-ascii?Q?a38s3dapJwtT6Fdens5yxux/u6Canrev2paRJr4VhTmzkVEUlk+d1f/C1G25?=
 =?us-ascii?Q?7ZBqHzPY+OsdJ7uN0Rq7zkcxwbD0s/pIsrmgrxxM1Da/Gw5JNx2rAbSn181N?=
 =?us-ascii?Q?0Cmgjho87SgqjDRqmJal937XFueP0Rn/jfpCMEHxGp/YEajRsWKjgLbZNOmd?=
 =?us-ascii?Q?UWx0QNm3O4ZnLA7abxAv9iW1ztjmtjvGBIvF8n+b/zoWJEot+BAIVc4VZJLR?=
 =?us-ascii?Q?JF4nMnM7bLo6126isjHTTcxPf8VuAWsvR2ygccZeq+QMBsbHgX58isP5gfkn?=
 =?us-ascii?Q?/K+F6NGzwt3/X3GvLGpZfA+J6tQ9uv1472RUSWmu9S8XseTygL3oYXalYDoJ?=
 =?us-ascii?Q?ZuejmLd2PxhCQiel5H+wgLGCUP8kOK03p3VtHCHzexwPJm4jUKRIhAQhPdSS?=
 =?us-ascii?Q?sP3vIUw2njlpsInzduen7r9nfZ55MYLtwNeP9ATVDyEc1R5noWoPzxiOTQNP?=
 =?us-ascii?Q?n26M5W6sYRVsPDH0qthTpr0+HtD/dJ/A1xX81yrdl0yw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bf0d3e-c7ab-4856-7f6b-08da65a8b489
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 14:54:08.6835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxWTIyAFLM1ptpKtzZJjEiN1j4lP3wbeKA0pgsuXlNW612u8Sk+enHK1r1XU1LaT8VKymCRzbU+IcFPEe/G8zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1718
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 11, 2022 at 11:47:31PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 11, 2022 at 03:27:48PM -0700, ira.weiny@intel.com wrote:
> > +/**
> > + * struct pci_doe_mb - State for a single DOE mailbox
> > + *
> > + * This state is used to manage a single DOE mailbox capability.  All fields
> > + * should be considered opaque to the consumers and the structure passed into
> > + * the helpers below after being created by devm_pci_doe_create()
> > + *
> > + * @pdev: PCI device this mailbox belongs to
> > + * @cap_offset: Capability offset
> > + * @prots: Array of protocols supported (encoded as long values)
> > + * @wq: Wait queue for work item
> > + * @work_queue: Queue of pci_doe_work items
> > + * @flags: Bit array of PCI_DOE_FLAG_* flags
> > + *
> > + * Note: @prots can't be allocated with struct size because the number of
> > + * protocols is not known until after this structure is in use.  However, the
> > + * single discovery protocol is always required to query for the number of
> > + * protocols.
> > + */
> 
> Can you add at least stub documentation in Documentation/PCI/doe.rst
> and include the kernel-doc from both pci-doe.c and pci-doe.h?

Yes that is a good idea, thanks.

> 
> > +static int pci_doe_abort(struct pci_doe_mb *doe_mb)
> > +{
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +	unsigned long timeout_jiffies;
> > +
> > +	pci_dbg(pdev, "[%x] Issuing Abort\n", offset);
> 
> "Issuing DOE abort", perhaps?

I've set dev_fmt to prefix with "DOE: ".  So I think that should be ok.

Thanks for the review!
Ira

