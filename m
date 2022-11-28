Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADB863B279
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 20:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiK1TsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 14:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiK1Trr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 14:47:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0084E5F64;
        Mon, 28 Nov 2022 11:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669664866; x=1701200866;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xOS20wrtCz0/0WS9n77g1TtAEgD/4B6hV1tXrLrw4PM=;
  b=Cn8LEmAx3H2s1ZOXaVRktVyBJNb66MgmyiG1HgC9aznRrJ5QmfIgoIoW
   FWsIRTcx2BTcnPPv1YvFpJuhLiqFu9G1ZYdIefNkB298RIUS34p+itiMg
   CB/tmmwO8cXiFRd9Fp54YfEU9VS/Wh1nGXDSylRGEH9AWTVJdZ6A3F+1U
   M2MMYg3cSAgYEaZt5TiHE9LXQh9aUW5zqeMnY+HFXVW/D+KCS7ys5tsXI
   MfiPdJStdgwS9OzJBQsMlbZPdOh1fcOpBG5Ucv/v7SLipjNsm77nFn5AP
   dKf37mqPAHmbILHibeHqyE7p+5ku7fG7lLNTAHEqI66Ax8xO6yOq8wk0G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="294629860"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="294629860"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 11:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="972397057"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="972397057"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 28 Nov 2022 11:47:45 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 11:47:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 11:47:44 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 11:47:44 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 11:47:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8PgJZOsMky3ImiduMAd1PXNkw1L6GHJfZxYvnIfq8pG1Z3V0QTL+qrThehUjodJmh8UAyZfBKANBKBX0aR8U8iVU2DkKTrit/yNr0OncIcicI/EW9bD3mb2RMCQHEvR4JIZ5/QlKym0CG5O2LybBrsdFRW2/KKIU56QBt1ti3vdlLRR/BhG6t3SSOY6I4jSQiV6aDHtvzO7X70vinLq02rqENp16uPuRvqfKHF7DoJM7UpDckahMfmqWbnhIGlM36itXqcGxpyTONQx4mlImtTwqMUTezkhR2cphHl4PNN++sVkBohRfSLPuaB7F/MOKMZdKIVz02d2/0v9+sSs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vb9NXfEq8iLxzszVDDuapMqGUS1fE8BdMPr++aKsk3g=;
 b=dFzrr/DehZSR4Dn/E6TC7SGj/292krk/9nenhaXnDW6UsvoGiyaOExIV8AxoHaiG5kU4PTSnDRSnteFl2xu5TExrZeLFkvYig5fILBKgcbueOmppEMW6bNC6g4+jfXDBY+EVL7tpY46JhlreZDLjOKLHqENg0qPblJApg1Q6Zz0TNheelm1iyWyvCUDf5+Al+B8xtdYFacnoDRojC/TfK7x6Xl0mtBiOMjP3LCbFjxWlDT1ErMrHa0aR4WuLz6wAnjbSkCx/0bBld4C5Gs5N4JsVsEngk0sWpp4tNvB3P77vNxfWQ9i71GaYAUEoJOMZW6tSuISDvaxb3aNC8MzJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7191.namprd11.prod.outlook.com (2603:10b6:8:139::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 19:47:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 19:47:41 +0000
Date:   Mon, 28 Nov 2022 11:47:37 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        "Li, Ming" <ming4.li@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V3 2/2] PCI/DOE: Remove asynchronous task support
Message-ID: <Y4UQWZSVIDxIUkQh@iweiny-desk3>
References: <20221128040338.1936529-1-ira.weiny@intel.com>
 <20221128040338.1936529-3-ira.weiny@intel.com>
 <Y4T2s7u8Z8m9q2oS@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y4T2s7u8Z8m9q2oS@aschofie-mobl2>
X-ClientProxiedBy: SJ0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 25aa9724-4c43-452c-8d57-08dad1796949
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O5p7QNA42nBZ3I+1tEvbw9CvgjGkxAzLlCwUcya1tVUxCvwLfJyLXYX5pIU5r3r27EstUTZwArCUKqjpWwTDfhOCvquOhEdCn4e1L9IeuKdol3t0eOYP5YQ+g4QV+TazEzymk3VCzakhyKk7qmAc+gOUhp11F2Umi3os1UTT+whPhck4Yohfdvs4kBRk+KpcVaGdSJqvlnO9GMnfGTWXcG+yDil/P8SeSeU8d6HV/U5wfxouLZBp5B1wt0RvBQ5szNVfFw7nR0LNZNPuZNnYrMO7PYtmd0D6jtVaMxNH52rnyq8n2mCZoz6mcL5rjhU8ef5ODE60mOr3VhL497zFOdVfsEvl1XJ6drpFuB5LwcYXXh4sLlljvpY6gNzedHEyzxhN7XvpuDgVMltJZqc5JC0H8YjBqWDFFUCmEchBYmS5J8ZOgDpOK8nmGReOXMY+NvANQuSQ6K49q31AQ5MClZEEJEei49GkWCt1L8LqP0HcfdUNpm9lDoflaCm6nps70Q6/I76yJv3Z+HI4jSH5ctpW88YzxKuRt04DPwKCUQKrW37ADv4Ie++RkNBos2Q3H/A6Emdd1dDlur9ZyV4C6cgZfZPqGUQe2DtMLXPjD6fneuLdY9yXTg1ptAFP1ZePe7iynWvXl3IvCtvUQx8O0wNJP56+a7SfsCKOkEjSnrrE+J/Y4mSx+sp6bJHDW1DJFJISnjceU5tcZMVuHty+Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199015)(2906002)(30864003)(44832011)(316002)(41300700001)(5660300002)(66476007)(66556008)(66946007)(33716001)(6636002)(54906003)(8676002)(8936002)(4326008)(6862004)(6512007)(9686003)(966005)(86362001)(6666004)(478600001)(6486002)(6506007)(26005)(186003)(38100700002)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6I3tRZMI7F4Fx7gS/acDnwZ/Nnl462Va0RR5JoiJwLI0ke/csy2rYjqxLwcT?=
 =?us-ascii?Q?WREIzQWKYodMwMbRL1qIKvyXcy4+abE4acUWkKA6FubjRDbqZGW14Lwiki9y?=
 =?us-ascii?Q?8CCcTbmd2EWhvN3yd1St9y4bbPLcQpw8XRIiWd62m0JTRsem4m/YQpkdClNl?=
 =?us-ascii?Q?FzAdWC4z6d8Z7Y+USLlSrqpzeE0uXBOu+/4iXgvMJ+Gt1oofWZzi0yurCvaK?=
 =?us-ascii?Q?ExzZOJefmnX+SsdxZeTbBDX8SP9SsTj4xQsWcdcEIAnmOoAvK1/07Zv1ETiE?=
 =?us-ascii?Q?4KFpr68DGW85rUvXDvSwvL7KKzSRhpjfXCmxWrKYjyfkXdcm/InLXE75P8Zj?=
 =?us-ascii?Q?rE+jVUgYGLbw1JndvI4HGUA1KcDT7cz8/MUHFUlREm0mDCyXuRVgraJWSE1Q?=
 =?us-ascii?Q?yvoHLve8jMlJkihHGmzR9KfAaP5YYTNeI6uzetMYIO6PpNwbFRgts7Cq/R0k?=
 =?us-ascii?Q?dTZ8NjmJNyRPJyrEDRo6DO7mlkqT2X0Qg+kZw7/zdbgzvPFNx/+viigoKgai?=
 =?us-ascii?Q?gfL7SD2UjBFc3H9aY88Mrhwf1XHaEpUiCTywxmHZJGwlU2LLO8wvNqkL99rw?=
 =?us-ascii?Q?DaAYr+s8PtETyZ7AabHp4kefT9rSZ4XVc5Un5AmoXYLO+KRCPfoPWx4TaZv8?=
 =?us-ascii?Q?m9fRjOv4kKsSrNX2WkcdDWemxKDDeLfYzKtwl+KsQ4Pg/Y5+tdt2y7UN1ubg?=
 =?us-ascii?Q?L+m+DO2VEpBMtS+i2e6PpUzENe4UqJahlBIZQ61isjra+DRWZihTZS87q902?=
 =?us-ascii?Q?y3DLWNEiCulvF3lm4+s38A0/BMXbvGR3ZAYuD3h6uRjjP3qB/7WFnTgpU0Tb?=
 =?us-ascii?Q?ncyPjRVzGdW5nQqWeLU0BJ2aUxB/DEdpxYXqC5Fog2oIFYGFbNq/IVooQloc?=
 =?us-ascii?Q?hif2dZ+Pfc0sef4znMS/uED+3wJA2JrM6nuG3CgX6fRRPa8yIov7yRCh23/R?=
 =?us-ascii?Q?L09qMYnVNxIlMQToZ7TWlRaC8sntteHehpHL43XjH9r+r/ChQjgLLhuD/6NL?=
 =?us-ascii?Q?Yt++HjhkSknV8AiS0G/4y1wdQCHSL/1zGzzDcGp8KQgdE3tlMmTxx8izya1m?=
 =?us-ascii?Q?aaglPRyKddpWw7Ua/Vckdzx/VoOCLwIuY5oV4IVUCnMlcIusMm2t0tXRFl17?=
 =?us-ascii?Q?7XRWiDn3T0p8swDyOzIsk5D1tU7TgIl7oYEe3w7IgAfp8g4ksewU4tK4Vca2?=
 =?us-ascii?Q?HSMkY1RCJw55m7o8wNV1eRImj0R/SQ8bdiOS/Annxj1l+bB3gbVwFx1gwE2w?=
 =?us-ascii?Q?ilSa6mub6ryt5Ov8c8Y47Kdpdew8a+EjbKdeAKcuPLLUciiTYeuVDaEIL9Qt?=
 =?us-ascii?Q?GOKupL4Y+WGHPdg2MBFqhN/xMwwfJ3kC0EER3gxgCyY7d8psraQPhQydC6Bs?=
 =?us-ascii?Q?b3HAuBJ48wyRUj4y8iytw/nxN/IBou7gQr5sXIZRfA9Oz/rQsPMvvp6XswyU?=
 =?us-ascii?Q?2RoZtDS03VBWacmnpZ0M5HZcA2xEN8TnvlePRIP8CdFTji0UjXpnmjC3BEWu?=
 =?us-ascii?Q?pLoZnfaDtWYGfJ9nT48YgIDCvXzyACt13mfVPg/yKqzXP8eJvlSNBiORl755?=
 =?us-ascii?Q?LkXvZ/DJm1gL0W8CWqUg8w6cFjXUXFzSdM9pfDQ8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25aa9724-4c43-452c-8d57-08dad1796949
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 19:47:41.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZNUbUUQ5dsa7/VOBS2L5f2qZ4dtFz9q9oVGZw93+Iu1yCDbbO2Zkr+kMWUrAm+wr0yjnNTUL7AjL6Cu8n+ZQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 28, 2022 at 09:58:11AM -0800, Alison Schofield wrote:
> On Sun, Nov 27, 2022 at 08:03:38PM -0800, Ira Weiny wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Gregory Price and Jonathan Cameron reported a bug within
> > pci_doe_submit_task().[1]  The issue was that work item initialization
> > needs to be done with either INIT_WORK_ONSTACK() or INIT_WORK()
> > depending on how the work item is allocated.
> > 
> > Initially, it was anticipated that DOE tasks were going to need to be
> > submitted asynchronously and the code was designed thusly.  Many
> > alternatives were discussed to fix the work initialization issue.[2]
> > 
> > However, all current users submit tasks synchronously and this has
> > therefore become an unneeded maintenance burden.  Remove the extra
> > maintenance burden by replacing asynchronous task submission with
> > a synchronous wait function.[3]
> 
> Commit msg: Please look at replacing this:
> PCI/DOE: Remove asynchronous task support
> with something like this:
> PCI/DOE: Replace async task submission with sync wait function

Ok yes this makes sense.

Thanks for looking!
Ira

> to more accurately reflect what this patch does. It is not
> only removing code.
> 
> Like the first patch, I'm unfamiliar w the details, and am
> just expecting that a patch that says 'Remove' doesn't add
> anything.
> 
> > 
> > [1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
> > [2] https://lore.kernel.org/linux-cxl/Y3kSDQDur+IUDs2O@iweiny-mobl/T/#m0f057773d9c75432fcfcc54a2604483fe82abe92
> > [3] https://lore.kernel.org/linux-cxl/Y3kSDQDur+IUDs2O@iweiny-mobl/T/#m32d3f9b208ef7486bc148d94a326b26b2d3e69ff
> > 
> > Reported-by: Gregory Price <gregory.price@memverge.com>
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Suggested-by: "Li, Ming" <ming4.li@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V2:
> > 	Jonathan
> > 		Fix comment on struct pci_doe_mb
> > 		Remove signal_task_complete()
> > 
> > Changes from V1:
> > 	Dan Williams:
> > 		Use mutex_lock_interruptible()
> > 		Adjust comment to lock the doe_mb structure not the
> > 		code
> > 	Adjust the locking based on the new series which eliminated
> > 	PCI_DOE_FLAG_CANCEL.
> > 
> > Thanks to Dan for the bulk of the patch.
> > Thanks to Ming for pointing out the need for a lock to prevent more
> > than 1 task from being processed at a time.
> > ---
> >  drivers/cxl/core/pci.c  | 16 ++------
> >  drivers/pci/doe.c       | 86 +++++++++++++----------------------------
> >  include/linux/pci-doe.h | 11 +-----
> >  3 files changed, 31 insertions(+), 82 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 9240df53ed87..58977e0712b6 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -490,21 +490,14 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
> >  		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
> >  	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
> >  
> > -static void cxl_doe_task_complete(struct pci_doe_task *task)
> > -{
> > -	complete(task->private);
> > -}
> > -
> >  struct cdat_doe_task {
> >  	u32 request_pl;
> >  	u32 response_pl[32];
> > -	struct completion c;
> >  	struct pci_doe_task task;
> >  };
> >  
> >  #define DECLARE_CDAT_DOE_TASK(req, cdt)                       \
> >  struct cdat_doe_task cdt = {                                  \
> > -	.c = COMPLETION_INITIALIZER_ONSTACK(cdt.c),           \
> >  	.request_pl = req,				      \
> >  	.task = {                                             \
> >  		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,        \
> > @@ -513,8 +506,6 @@ struct cdat_doe_task cdt = {                                  \
> >  		.request_pl_sz = sizeof(cdt.request_pl),      \
> >  		.response_pl = cdt.response_pl,               \
> >  		.response_pl_sz = sizeof(cdt.response_pl),    \
> > -		.complete = cxl_doe_task_complete,            \
> > -		.private = &cdt.c,                            \
> >  	}                                                     \
> >  }
> >  
> > @@ -525,12 +516,12 @@ static int cxl_cdat_get_length(struct device *dev,
> >  	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
> >  	int rc;
> >  
> > -	rc = pci_doe_submit_task(cdat_doe, &t.task);
> > +	rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
> >  	if (rc < 0) {
> >  		dev_err(dev, "DOE submit failed: %d", rc);
> >  		return rc;
> >  	}
> > -	wait_for_completion(&t.c);
> > +
> >  	if (t.task.rv < sizeof(u32))
> >  		return -EIO;
> >  
> > @@ -554,12 +545,11 @@ static int cxl_cdat_read_table(struct device *dev,
> >  		u32 *entry;
> >  		int rc;
> >  
> > -		rc = pci_doe_submit_task(cdat_doe, &t.task);
> > +		rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
> >  		if (rc < 0) {
> >  			dev_err(dev, "DOE submit failed: %d", rc);
> >  			return rc;
> >  		}
> > -		wait_for_completion(&t.c);
> >  		/* 1 DW header + 1 DW data min */
> >  		if (t.task.rv < (2 * sizeof(u32)))
> >  			return -EIO;
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index 685e7d26c7eb..b399f0f4fb5d 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -18,7 +18,6 @@
> >  #include <linux/mutex.h>
> >  #include <linux/pci.h>
> >  #include <linux/pci-doe.h>
> > -#include <linux/workqueue.h>
> >  
> >  #define PCI_DOE_PROTOCOL_DISCOVERY 0
> >  
> > @@ -40,7 +39,7 @@
> >   * @cap_offset: Capability offset
> >   * @prots: Array of protocols supported (encoded as long values)
> >   * @wq: Wait queue for work item
> > - * @work_queue: Queue of pci_doe_work items
> > + * @lock: Lock state of doe_mb during task processing
> >   * @flags: Bit array of PCI_DOE_FLAG_* flags
> >   */
> >  struct pci_doe_mb {
> > @@ -49,7 +48,7 @@ struct pci_doe_mb {
> >  	struct xarray prots;
> >  
> >  	wait_queue_head_t wq;
> > -	struct workqueue_struct *work_queue;
> > +	struct mutex lock;
> >  	unsigned long flags;
> >  };
> >  
> > @@ -196,12 +195,6 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
> >  	return min(length, task->response_pl_sz / sizeof(u32)) * sizeof(u32);
> >  }
> >  
> > -static void signal_task_complete(struct pci_doe_task *task, int rv)
> > -{
> > -	task->rv = rv;
> > -	task->complete(task);
> > -}
> > -
> >  static void signal_task_abort(struct pci_doe_task *task, int rv)
> >  {
> >  	struct pci_doe_mb *doe_mb = task->doe_mb;
> > @@ -216,13 +209,11 @@ static void signal_task_abort(struct pci_doe_task *task, int rv)
> >  			doe_mb->cap_offset);
> >  		set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> >  	}
> > -	signal_task_complete(task, rv);
> > +	task->rv = rv;
> >  }
> >  
> > -static void doe_statemachine_work(struct work_struct *work)
> > +static void exec_task(struct pci_doe_task *task)
> >  {
> > -	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
> > -						 work);
> >  	struct pci_doe_mb *doe_mb = task->doe_mb;
> >  	struct pci_dev *pdev = doe_mb->pdev;
> >  	int offset = doe_mb->cap_offset;
> > @@ -231,7 +222,7 @@ static void doe_statemachine_work(struct work_struct *work)
> >  	int rc;
> >  
> >  	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
> > -		signal_task_complete(task, -EIO);
> > +		task->rv = -EIO;
> >  		return;
> >  	}
> >  
> > @@ -276,12 +267,7 @@ static void doe_statemachine_work(struct work_struct *work)
> >  		return;
> >  	}
> >  
> > -	signal_task_complete(task, rc);
> > -}
> > -
> > -static void pci_doe_task_complete(struct pci_doe_task *task)
> > -{
> > -	complete(task->private);
> > +	task->rv = rc;
> >  }
> >  
> >  static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> > @@ -290,7 +276,6 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> >  	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> >  				    *index);
> >  	u32 response_pl;
> > -	DECLARE_COMPLETION_ONSTACK(c);
> >  	struct pci_doe_task task = {
> >  		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> >  		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> > @@ -298,17 +283,13 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> >  		.request_pl_sz = sizeof(request_pl),
> >  		.response_pl = &response_pl,
> >  		.response_pl_sz = sizeof(response_pl),
> > -		.complete = pci_doe_task_complete,
> > -		.private = &c,
> >  	};
> >  	int rc;
> >  
> > -	rc = pci_doe_submit_task(doe_mb, &task);
> > +	rc = pci_doe_submit_task_wait(doe_mb, &task);
> >  	if (rc < 0)
> >  		return rc;
> >  
> > -	wait_for_completion(&c);
> > -
> >  	if (task.rv != sizeof(response_pl))
> >  		return -EIO;
> >  
> > @@ -360,13 +341,6 @@ static void pci_doe_xa_destroy(void *mb)
> >  	xa_destroy(&doe_mb->prots);
> >  }
> >  
> > -static void pci_doe_destroy_workqueue(void *mb)
> > -{
> > -	struct pci_doe_mb *doe_mb = mb;
> > -
> > -	destroy_workqueue(doe_mb->work_queue);
> > -}
> > -
> >  /**
> >   * pcim_doe_create_mb() - Create a DOE mailbox object
> >   *
> > @@ -392,25 +366,13 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
> >  	doe_mb->pdev = pdev;
> >  	doe_mb->cap_offset = cap_offset;
> >  	init_waitqueue_head(&doe_mb->wq);
> > +	mutex_init(&doe_mb->lock);
> >  
> >  	xa_init(&doe_mb->prots);
> >  	rc = devm_add_action(dev, pci_doe_xa_destroy, doe_mb);
> >  	if (rc)
> >  		return ERR_PTR(rc);
> >  
> > -	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
> > -						dev_driver_string(&pdev->dev),
> > -						pci_name(pdev),
> > -						doe_mb->cap_offset);
> > -	if (!doe_mb->work_queue) {
> > -		pci_err(pdev, "[%x] failed to allocate work queue\n",
> > -			doe_mb->cap_offset);
> > -		return ERR_PTR(-ENOMEM);
> > -	}
> > -	rc = devm_add_action_or_reset(dev, pci_doe_destroy_workqueue, doe_mb);
> > -	if (rc)
> > -		return ERR_PTR(rc);
> > -
> >  	/* Reset the mailbox by issuing an abort */
> >  	rc = pci_doe_abort(doe_mb);
> >  	if (rc) {
> > @@ -457,24 +419,25 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> >  EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
> >  
> >  /**
> > - * pci_doe_submit_task() - Submit a task to be processed by the state machine
> > + * pci_doe_submit_task_wait() - Submit and execute a task
> >   *
> >   * @doe_mb: DOE mailbox capability to submit to
> > - * @task: task to be queued
> > - *
> > - * Submit a DOE task (request/response) to the DOE mailbox to be processed.
> > - * Returns upon queueing the task object.  If the queue is full this function
> > - * will sleep until there is room in the queue.
> > + * @task: task to be run
> >   *
> > - * task->complete will be called when the state machine is done processing this
> > - * task.
> > + * Submit and run DOE task (request/response) to the DOE mailbox to be
> > + * processed.
> >   *
> >   * Excess data will be discarded.
> >   *
> > - * RETURNS: 0 when task has been successfully queued, -ERRNO on error
> > + * Context: non-interrupt
> > + *
> > + * RETURNS: 0 when task was executed, the @task->rv holds the status
> > + * result of the executed opertion, -ERRNO on failure to submit.
> >   */
> > -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> >  {
> > +	int rc;
> > +
> >  	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
> >  		return -EINVAL;
> >  
> > @@ -490,8 +453,13 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> >  		return -EIO;
> >  
> >  	task->doe_mb = doe_mb;
> > -	INIT_WORK(&task->work, doe_statemachine_work);
> > -	queue_work(doe_mb->work_queue, &task->work);
> > +
> > +	rc = mutex_lock_interruptible(&doe_mb->lock);
> > +	if (rc)
> > +		return rc;
> > +	exec_task(task);
> > +	mutex_unlock(&doe_mb->lock);
> > +
> >  	return 0;
> >  }
> > -EXPORT_SYMBOL_GPL(pci_doe_submit_task);
> > +EXPORT_SYMBOL_GPL(pci_doe_submit_task_wait);
> > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > index ed9b4df792b8..55e6e45b87f3 100644
> > --- a/include/linux/pci-doe.h
> > +++ b/include/linux/pci-doe.h
> > @@ -29,9 +29,6 @@ struct pci_doe_mb;
> >   * @response_pl: The response payload
> >   * @response_pl_sz: Size of the response payload (bytes)
> >   * @rv: Return value.  Length of received response or error (bytes)
> > - * @complete: Called when task is complete
> > - * @private: Private data for the consumer
> > - * @work: Used internally by the mailbox
> >   * @doe_mb: Used internally by the mailbox
> >   *
> >   * The payload sizes and rv are specified in bytes with the following
> > @@ -50,11 +47,6 @@ struct pci_doe_task {
> >  	u32 *response_pl;
> >  	size_t response_pl_sz;
> >  	int rv;
> > -	void (*complete)(struct pci_doe_task *task);
> > -	void *private;
> > -
> > -	/* No need for the user to initialize these fields */
> > -	struct work_struct work;
> >  	struct pci_doe_mb *doe_mb;
> >  };
> >  
> > @@ -72,6 +64,5 @@ struct pci_doe_task {
> >  
> >  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> >  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> > -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> > -
> > +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> >  #endif
> > -- 
> > 2.37.2
> > 
