Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B1A56CB4F
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 22:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiGIUGn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 16:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIUGn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 16:06:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FABE65E8;
        Sat,  9 Jul 2022 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657397201; x=1688933201;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eaeet4UkoL9q2ctVkzn6mx3f829Oc/d+Cy7adZh9bdk=;
  b=Z00xQWUGEgF0SqVdF67/iMfv2WVsGU6SQQqQ6AIJk+HbO4IF57TKlky7
   jq5AaA0Y5O5zcUQlkloMZ3RXoPkIP3f57sGm+Sf5lfJfzYQKySdoH4Gq/
   4v8kixc29d5esyvtkOLzeia4a3AFwnAZ5s8afJkIwDJY2xKb9C8gX5/yB
   DhVaTDVyDdLDfr+14sFO3r0pQeIPpSP81h7ZDsRGKsOD5o2KNdtd5Tldp
   /+w5WCualibIxwDyjE9d0CVSnRYnu1iPYwLi4ZUSzNdGM5FM0JrBD7goL
   eqqaEwkvNzuO7wyO7bTAiLLRB8Q7w9tDKmDgSljrQ93DUIZDxBsyglfMV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="264235998"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="264235998"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 13:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="921343708"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jul 2022 13:06:40 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 9 Jul 2022 13:06:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 9 Jul 2022 13:06:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 9 Jul 2022 13:06:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSU+IbdpWRmbJl7vsDbswIK5yXVy70H58EVh11yRO/lpUkztX6V+LM+Xvsf4ab0AXH1/cRrPxYOrHPlWZqCAWrPjblycrhWnlYf7DZpt03GYWyXYfkpE/syothzx9Iy1lxaP6/Hw9NSK/Ip8ZaXOCbT+X3IBaNZfyQx7loLPY2RMhDR0CpQL0Cq2DjeNS3sxyHXLkvEkYpCKnzv5o0xIpVJMcv/NP2lKWpLwz6pewoEAqDaPzRT6YJROQ5ka3NXexpNWIAcMxPISpOO0vhARbY7zS9mRPTPvxYaGwA9sT4o6dTHoXc3TRGR6QVdN/0JwzPHwgDqRgJCeMQ8yOzTtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbGEeSs17IrUeQqHIw6I2/cKSXTQXPj6XJyBEsb2iGI=;
 b=AC6IG06v0RfjYC8M7Xe+eOxc5kE7gMfTGJXH/fO4g4BR2NQpeq6HVdWAGb2eVPpuhqrJhkBEuyD/f1K4B0v/YprBP8jG7HmnygkywZ2DwQ3AlFRsuAn6syq6u84ZRWfLIhtrpquU1TzhQcLCnOwgm3k6u4/avLhsyPqc6c0iim8t0ey++mumZSf+19mp5xLdtWfUWXfy+TI9Uc7uhoTTcpzakoL7XdBHyYVjF1D8CIgjerIh4aImQLzHpzbrPdKZrY3BqJ5IDyKcMrS/Pzt7CPOl725LFzbilgv5hRE302HI8mLEYka7gXJVH/BaP4Nfyrt90CKg23YEPbNEl2jUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY5PR11MB6163.namprd11.prod.outlook.com
 (2603:10b6:930:28::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sat, 9 Jul
 2022 20:06:38 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.021; Sat, 9 Jul 2022
 20:06:38 +0000
Date:   Sat, 9 Jul 2022 13:06:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Adam Manzanares <a.manzanares@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 01/46] tools/testing/cxl: Fix cxl_hdm_decode_init()
 calling convention
Message-ID: <62c9dfcc4bd7c_2c74df294c1@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603870776.551046.8709990108936497723.stgit@dwillia2-xfh>
 <CGME20220629174147uscas1p211384ae262e099484440ef285be26c75@uscas1p2.samsung.com>
 <20220629174139.GA1139821@bgt-140510-bm01>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220629174139.GA1139821@bgt-140510-bm01>
X-ClientProxiedBy: MWHPR17CA0078.namprd17.prod.outlook.com
 (2603:10b6:300:c2::16) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0cdec2e-bf82-4e0c-a2e0-08da61e68802
X-MS-TrafficTypeDiagnostic: CY5PR11MB6163:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kI07C/uRLiDRUKA8YnAAJJEgN1u9rEk0fuhW9P3JhD+FuVfvgwaU9g7rchSi9EuF5mw/er2blogaa+wvsFXAjnYZ8kUpgzncxso3tMLJ8Qdn2RU3nt38QKTgICUHFnSa1yI5a6xW8tlJSsZfWNl/4y+cKSRM9dRvz+L4ddYb48BuHPrOH/8SHJ/CFshpAhGPCIq8St9v31L+hsCE4q05jgLIApj7ovM89HQwMXu1CJu6dDj18js3Pi9RgFyfsq4RQX5pyk3e4EAZ96AjFCV0oF/6SvAbHDMVhhBG7+5AI9/K4N8R9jOnXkMst54R5nq0KPb1lNRiM/9JQkZMyI6mt9cmiEjmFib5anf5U7uVJ7mYiM0quKBAbQicVDkp1vFUGmJRVFrBbkq4UonUTQ0xoBAYgjQV0sRdDq72ExJ++ElqbB+casTK2UgmBWyg90NBrhfGYKcTytK848BshM4FCnckqNIF/byRMX+dFGg4QKCNJI4eeltgaXtb+YqPbfVTEWnejiR3467mgUrV4vuVkMGk6zrhdw61UOZUYPY7gPMyzaBGSJ8L120V0Kri6OboTH3b4jDFpC1mMU1zE9JTo5UCb5KSIZOai01Rw6WgMMK7AfQuQrkW/o7gBNpoMCgqsbQF/WensunaM/keRtrPs95V4KLm5tEzf111RT8kh/KWgEEXdMvpkHhNqdk/QcATLrnYnZqSEQmW8LJ3ln8XaKh5fnudiZtgxOSrr4+2/4BIopLS3ZywTzlIKgZgX0GM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(39860400002)(346002)(376002)(4326008)(316002)(8676002)(66476007)(26005)(66946007)(6512007)(8936002)(6486002)(5660300002)(86362001)(9686003)(478600001)(82960400001)(6506007)(66556008)(38100700002)(110136005)(83380400001)(2906002)(41300700001)(54906003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FiUH78+DXOcBKDYykUTviC0/zaE/X/xazBbOnqJmv7CcDF3Fge1QKyQhqOhm?=
 =?us-ascii?Q?XOWfuFlc4BA3De1fWNpuCKZmkw/555owvOo2WGdw8nrnTqvyMHHMyqAzD3wf?=
 =?us-ascii?Q?ZS3bVuIc6BTfEai/KMmTpturWBqB4dHuZEQvZp4oHfpvtpf6SqCF/iMwvcIC?=
 =?us-ascii?Q?ecK/5FHVdDqnjRRERC2fjpBcAEVUCSmB67z/4Vma+65L2pNtaukzW0EWIyc7?=
 =?us-ascii?Q?n5FXGTFDKgGGGpJcZcfd9h6xmYI7gAhzXIq88mPy5RjmnMCITSH7tgR0Se7z?=
 =?us-ascii?Q?rs5gdRBa6YfZm35udVLVvs6uGwQDEhlXVO8RZlEn3saCGAEPOKLnoKA29oxf?=
 =?us-ascii?Q?ua4vJXJaH7YF9CzhKKQZlkT8hGDL0ZqxZ/2XDlNpe9D83MDWVcq1bMRDWW1o?=
 =?us-ascii?Q?OzFpsMzt2ZP8ENXelwg4Z5LVIfzmD+xQLn4WSmsLskRI3QB6ISE2D3kR5ssT?=
 =?us-ascii?Q?RIz7+LRsItRH/R8eKdYqNdz2ujZsXYA7lE/AUjCkd5GjgPRKnWFb/37d6ZiX?=
 =?us-ascii?Q?gpdVtOK3YoS3w2B3l1qtuQpoJvuYU90JxNlS7VH/P1SvpyFQjBpa2qFFTB6X?=
 =?us-ascii?Q?wxt48V43Bs1zgxMlaK6KNIJZlFSYmCAunmz6Y+UwkTSSbmMiy7lZW2PQms3j?=
 =?us-ascii?Q?MvfRV2FIK+FgYt5N30cm93b9+v7N1CTzFHa+sRJN7Moxmk9oWUgR6KEctCmv?=
 =?us-ascii?Q?IvZf31XbC1x96jSwGfxpuCH4f0Y0ArgVZYp3Bn/vt7eovX5KJiMFKcGgqd0T?=
 =?us-ascii?Q?UmIIF40lFNUaFejerCTqYn0uKQ6TaUPVDgosoiKpkVR1p+S8OeezjsMEcHTf?=
 =?us-ascii?Q?KnCbQ8VISLTvygRJXQAqwy5WLFPVY6Ka+pA4geVvchE5DVLXRdj1nD0MyVsd?=
 =?us-ascii?Q?JeMzGTbnztK3TtwqpRf44aaPtV1/404d30jjpXr5oP/wlUkM+S6IWpLnyiWN?=
 =?us-ascii?Q?aaz3qVSnPrXghTuTQGU9WM+kI1LvBuEFfJzRDt1pIYzBegXbPoe26KKLQkEc?=
 =?us-ascii?Q?DajUif7JcFGh2GSWXlnB/Ixr34bJA1+glqWbyBlHi42vqU97ykh5llVIjIqu?=
 =?us-ascii?Q?zh+XoP3BrrSei/IHxmikuNnU0TqD1mNKTua5V/l9I/Oanf6mLu6bxPZsaMsd?=
 =?us-ascii?Q?6uc38hsjdx8OPmxJrpu1HgFGwKiZF6lrjpy2j7NZ6wAGS4TqOQXJP3ZG5Ffy?=
 =?us-ascii?Q?2RAsgQyvb8qWaTg69o7J43Kq3FplRjckc/EC/mVJhVed86brIpRELr49RqHt?=
 =?us-ascii?Q?WALh3SQduzQ5l92Q47ErddRo39dhDIHN2Ph3U00R77SGQGP08AJbTjzBQD/4?=
 =?us-ascii?Q?1CkX8zYiZa+gvnixfaaD03W+3yReX6r91wfC+KpgcjRrCLBVMjARcFLD+wQ8?=
 =?us-ascii?Q?I1wbgZdk1C6pR3TctZ0GHPUuDCMu+dCexxp7TQYfjo40MnKUN8vwVvOPiHaN?=
 =?us-ascii?Q?fP4Z4WN1gZ0B0jx0yqzIM3PIak+hYHBQseXkOxq5/Ol72aTSZA7KvvVFusaY?=
 =?us-ascii?Q?g7ZjRaFmJ3S9BVW1HSpCmFI+NBdbMu3HuVti9ne9CG9a9Td4C0goLNpsc5bx?=
 =?us-ascii?Q?0NJ13r7aw0U9ndpblY6WRXK8EDIbqs1NAI23h3IjOYXyI2V4j0p6sKYKA9RE?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cdec2e-bf82-4e0c-a2e0-08da61e68802
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 20:06:38.0936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvV49pDU0gpGCbnyT+VveTgGxePgIFg9ohbvJm/AZ3tAIGnYHq9wQ/Qn4NMmoUjLGCIFKyMOcz/0Pn4ertlzWy6lv8dbUNndJ23qP9m2iQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adam Manzanares wrote:
> On Thu, Jun 23, 2022 at 07:45:07PM -0700, Dan Williams wrote:
> > This failing signature:
> > 
> > [    8.392669] cxl_bus_probe: cxl_port endpoint2: probe: 970997760
> > [    8.392670] cxl_port: probe of endpoint2 failed with error 970997760
> > [    8.392719] create_endpoint: cxl_mem mem0: add: endpoint2
> > [    8.392721] cxl_mem mem0: endpoint2 failed probe
> > [    8.392725] cxl_bus_probe: cxl_mem mem0: probe: -6
> > 
> > ...shows cxl_hdm_decode_init() resulting in a return code ("970997760")
> > that looks like stack corruption. The problem goes away if
> > cxl_hdm_decode_init() is not mocked via __wrap_cxl_hdm_decode_init().
> > 
> > The corruption results from the mismatch that the calling convention for
> > cxl_hdm_decode_init() is:
> > 
> > int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
> > 
> > ...and __wrap_cxl_hdm_decode_init() is:
> > 
> > bool __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
> > 
> > ...i.e. an int is expected but __wrap_hdm_decode_init() returns bool.
> > 
> > Fix the convention and cleanup the organization to match
> > __wrap_cxl_await_media_ready() as the difference was a red herring that
> > distracted from finding the bug.
> > 
> > Fixes: 92804edb11f0 ("cxl/pci: Drop @info argument to cxl_hdm_decode_init()")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  tools/testing/cxl/test/mock.c |    8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> > index f1f8c40948c5..bce6a21df0d5 100644
> > --- a/tools/testing/cxl/test/mock.c
> > +++ b/tools/testing/cxl/test/mock.c
> > @@ -208,13 +208,15 @@ int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_await_media_ready, CXL);
> >  
> > -bool __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> > -				struct cxl_hdm *cxlhdm)
> > +int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> > +			       struct cxl_hdm *cxlhdm)
> >  {
> >  	int rc = 0, index;
> >  	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> >  
> > -	if (!ops || !ops->is_mock_dev(cxlds->dev))
> > +	if (ops && ops->is_mock_dev(cxlds->dev))
> > +		rc = 0;
> > +	else
> >  		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
> >  	put_cxl_mock_ops(index);
> >  
> > 
> 
> 
> Looks good.
> 
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>

Just fyi, b4 did not auto-apply this tag due to the missing "-", caught
it manually.
