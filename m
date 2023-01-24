Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37FE67A39A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 21:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjAXUHw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 15:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAXUHv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 15:07:51 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB09E3AB7;
        Tue, 24 Jan 2023 12:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674590868; x=1706126868;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x2Xtk3WUZkDXfX49O2Uu5jm2CjZ9lEBzfHAAHNlnI6g=;
  b=X4spMLJLe7wQTmcFhyxekLcuBB2DhZZ1JifQBV2eQtpEuRceVdOUWIAJ
   u/wQ3k154Q73dtvq8e+l6d1xhe9o1k9C4E31yGQG0EtSc7HyTkIGaYnVs
   E3OqAW2zktpVqc0Ji4oEGuvtC6etHNhGSYKnxp0mL4H2sFtnkX835LNnh
   DSSDmaTu8DEjqKOxBLRqiL3yovB3qLVbKyGXorsOtljSX+kZDF606ir3E
   r5C0oiV17DXVdH5/RlEG+ON4l2GQKBpIl9B1YRMdCM6rTys5Ov9YKX2eO
   WhKnV/JvIzdAetazmGe4WsfWozC/4/FdoqAWipF4t8urpTxm3GWzHChHA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="412625889"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="412625889"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 12:07:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="692699191"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="692699191"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2023 12:07:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 12:07:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 12:07:46 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 24 Jan 2023 12:07:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrGgZGFOZ9KXBvXhtJXQFoj79/sdx+hYN3RQ73CW0qRiAyQo41j/7p7Zjs28eWQhhw2pVpwxu6h/zdRAZbPX8u+ayEcL1ZG+EiyqpPzoefxbfPy/SxPvxyHMd70bfx4Nsn4UsiopHxwPfoM+JIIDuo8gwkx6eFr9HX8aBDgN/r9S0R22ljNg9wsN2BL6rGLboavN8p+VW0EadmlKaZE+5iVfVeoa4QIY8wR+UPs/3NcytDcEM005+rpPdefrFTOZh7lUMkI/PQOh174LFxVrbUd5qYgYnTpKB8L7gjB/zIGJyuZUDYbGxRdC+5x1DfrRe6W8/mC8yrZyBNQE31phfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8QsLlLlfJ91GZXrFN0EeLd0y2XZRLrmymTYfUMX7VE=;
 b=HFRDu7xYBOuiC1NRFdrFpB/s3bKZpOB5swiMye5k5ceSoZc4uUSSH03dMLmR/+7rkAEL6soNEX6LGXFQnJxiqlzEsYhFrbyIwUCxrHALOjE5e87HKuPX7UCwrp7CwQeKqHa1zJ+dS5ChB8in7B6jiJifJCFkL0s1tn2Q+1QroT+3CJmhMrDYO6tLgVypWV7AXr9nIHBYVFUPoX+tBlN1kEI35vK+SCom1PC0m2nkU74/W1HX2/a1nOaBbf6gloI6swLq7ZX0A07745WxlsMScO3PIFrRoXiPDKv945BgpYP9Xo8+jtvCnHLXS4185IJ8x/6w5V23OKzqBuiRfCk1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7744.namprd11.prod.outlook.com (2603:10b6:208:409::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 20:07:36 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Tue, 24 Jan 2023
 20:07:36 +0000
Date:   Tue, 24 Jan 2023 12:07:32 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        "Gregory Price" <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/DOE: Provide synchronous API and use it
 internally
Message-ID: <63d03a84c4e08_9ed6294d9@iweiny-mobl.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
 <b589059ddc82039f00d695d75ac4017504df6bf6.1674468099.git.lukas@wunner.de>
 <20230124104033.000048ec@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230124104033.000048ec@Huawei.com>
X-ClientProxiedBy: BYAPR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:a03:80::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 790049f3-6a2b-4213-3f03-08dafe46a2fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8FxSWJ0/S+JqES6vRLWjLwLlf5YtyVcUZqqiKk9JPMdtK1sf2MtYKHkxs3LlsQvySUx0g0irGx7KbzuSsiFILdhvSSboMOxE0AQN0c2G6gbIT/GrClI65KnjzLoBGCvqa7za1LYScn+seiUXpOJUTmb/Dl99lO3oLod6GqpMFfa+v4YmTPH87uWwShxbB+NeJLDW2163p8V2JjAElLz4RS59CGaKiHfZ2XdG7VJ64kiV7vwLzxBLsfZVMPbOQq1z76rjLspQmSAJy6+TmdZ+leZDTHfDB+NBylFxM9bDTOHOMUpxthRCcP68ZWolGU/HXlVfShk5Io75AT7xfmrypZAhiFWGQWXeN9xeMO6QSP8zavFlcFKfe1qjDYzo9E08oF94SGpFtTB5cdkEZNKzUf+hFBnrk2yzaMEDPXcjrBn/XUxOpS7g8m67jMsfukNUJIty6h0xzBp5yKbdrhLKlqGyfFpMX1Rc+MFakW8WVczw1bUnrEP3wRwkScbqbo0/6JFsHZnhR9OjuQ/oBKkfyQd1RBa8t3IID2+9RL9a4ssRFItXxN6FNNksMFwZvM0HfwIXHQP7hRsNvaDJVtSSHPgzyCgdjc64UEhqjtpS+d8gyNMTRdeUDC+iTqu1ixx4MYLIVUYWmEe5JBKS9xK0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199018)(186003)(6506007)(66946007)(86362001)(6512007)(4326008)(44832011)(478600001)(54906003)(8676002)(5660300002)(83380400001)(6486002)(6666004)(8936002)(110136005)(66556008)(38100700002)(9686003)(26005)(66476007)(41300700001)(316002)(2906002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T94Cyqh9k7YuHtMLWHnNGrikLvGFyW7tWd0nbrKfYrouIOm05mnIEfIOxPlH?=
 =?us-ascii?Q?n3uwIOfX6BIqNXCGUmOwJexwFY6nS7WuyapfMp25L4oey1fi05jCFd4x4Xop?=
 =?us-ascii?Q?eIx+/S3NJpYrJDhkH+iq9cI8FUYNXeQrlhKJC8fxEzh8nILBwlCeIfeHXpAG?=
 =?us-ascii?Q?fNKBn5y8i0lEn5Y8w+qe0vvc4upWAvQfcw2JMOsmC+9axmMZ5SOiEBcAB35K?=
 =?us-ascii?Q?mkdk1bDqghDShz1kjsIe9G9DazZoJ+PaxebqGd+GNTtLAx5Q/ybDyuRUdvrT?=
 =?us-ascii?Q?xV5Lw2ZwdxqAc/aNdWSZk2McRPhN2qTQClBQMBLPGI4jOKnvXJW30SVGCT/b?=
 =?us-ascii?Q?1b/HiC2hevqFSu19skNzwdUI7ZocsMVgP07JmCQSSznNi5GpFKR/TRP9d0Kx?=
 =?us-ascii?Q?LAru+t+18P91tkJxXeJu5+iMrxNExGTL4eAV2rHls44mirFM+dYsQrNhzpAO?=
 =?us-ascii?Q?oVD50F7Fz1Ayf5kkEJyUxUADKf8oJ1P0JcWFBHW/I0XdCH4vR7d/R2GX4slh?=
 =?us-ascii?Q?VdIDLjUDM1Ye8rD7rO4i3itF4zpPqqgmniXC9uQv9YLnkBL17bm4MptHN87R?=
 =?us-ascii?Q?PJl+IfuywrMpMS4Pk/WbtwHZWA/VJw3YiaKv4Xkjofru+iMVxyF0J1dJMIQM?=
 =?us-ascii?Q?+ANH0wk32opEwJlj75te5t8oAJiqyuAXutW+Z4Ab4KXmN1OWSZfAfFfEVqj4?=
 =?us-ascii?Q?EsO0qN1MZuzY0USdDjZCkAcYFXexOca2wixN6chq33ePyEuCDm21UH2ZXrkp?=
 =?us-ascii?Q?rmOdlCmM4yulkRUfff+KDXRoL0rvbcC3juzW0AjM0cOcZZvjm4vO7rGWbSyp?=
 =?us-ascii?Q?choI8y4g3klIkvQ8d3kI/qVxg80XkIUnvr9M6j/Y3KCR852ad8sTxu1M25MV?=
 =?us-ascii?Q?y1Xm6gJ+ndpJOS0Frh1ZEoAUEdA3zCqqqzEzmEKmsOSC/QXEIQoICcykf5wL?=
 =?us-ascii?Q?fwMYJadp4t6e8x7Z9t5xTZlwU0A+lAfy3d3cdhKmMLOolNfDNxZYXfeLdtOl?=
 =?us-ascii?Q?W9fs/656hCLwLdA0+ViK4D9V8UzqkOadvK0qUj1KsHAR2qQFYMbSFc8VMqcO?=
 =?us-ascii?Q?UXFv7FuoTJSAg+a7zyHhm81G7UHfMjJOciJ4rgFupO9pa9nE0rKMfHPKepOG?=
 =?us-ascii?Q?E/zVu9DNyYK9DRUFNfXtbU1U5zPvsRGjs5QZz+iGrITZzyfo7hv/ygrAhWwv?=
 =?us-ascii?Q?QWF8O3JxqwjN55zAKtFRZUVz5gPowGDXk+Ju+7DLe3WCayQS0wvAIa3pLYM4?=
 =?us-ascii?Q?bVZLQMoFu8dM8TXjxiDga8ZlzNoQn8GMSm9vJtib0ZkGjyQhM0ty3jLn9sDw?=
 =?us-ascii?Q?xCcjvigMfNg94ti5NOeYDLjRgVusrChwlScIWoQdvXv7swMsReFtc14NYCkO?=
 =?us-ascii?Q?VGWONb5VAWwD7Ri7+dnMj5W/93mKxlRrWSvaguJfu0TPLlG3cvZtH8U12Pw3?=
 =?us-ascii?Q?vHHNzbFPUXuFihSRuC1gMvr+hoHDnvc3wLAIxrXI1vXaCNhnrsRy3RJpek5Q?=
 =?us-ascii?Q?TwITEXab63gYn3iseEJql7aq8bouj+JgPyBzSBpkYLrreL5nLEYUwWiYROuj?=
 =?us-ascii?Q?vuINjd62DEHnm50g6j2cN+XDGJR+RC57kDR34fKdASZVoZ/QjPEvUcZMm+MC?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 790049f3-6a2b-4213-3f03-08dafe46a2fe
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 20:07:36.4270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UtKLJA9FjDnHb5j22BJhp7rmW5KeX8WO2ayDPom7OIoMtR7ozv08UXxTfqr/ZCPHcI0dIJP4gUX4SiMvdmo6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7744
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Mon, 23 Jan 2023 11:13:00 +0100
> Lukas Wunner <lukas@wunner.de> wrote:
> 
> > The DOE API only allows asynchronous exchanges and forces callers to
> > provide a completion callback.  Yet all existing callers only perform
> > synchronous exchanges.  Upcoming commits for CMA (Component Measurement
> > and Authentication, PCIe r6.0 sec 6.31) likewise require only
> > synchronous DOE exchanges.
> > 
> > Provide a synchronous pci_doe() API call which builds on the internal
> > asynchronous machinery.
> > 
> > Convert the internal pci_doe_discovery() to the new call.
> > 
> > The new API allows submission of const-declared requests, necessitating
> > the addition of a const qualifier in struct pci_doe_task.
> > 
> > Tested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> 
> Pushing the struct down is fine by me, though I'll note we had it
> pretty much like this in one of the earlier versions and got a
> request to use a struct instead to wrap up all the parameters.

I had the same thought but decided not to pick at that old wound...  ;-)

> 
> Let's see if experience convinces people this is the right
> approach this time :) It is perhaps easier to argue
> now the completion is moved down as well as we'd end up with
> a messy case of some elements of the structure being set in the
> caller and others inside where it is called (or some messy
> wrapper structures).  Been a while, but I don't think we had
> such a strong argument in favour of this approach back then.

I think this makes a lot of sense and is clean enough.  I don't think the
number of parameters is outrageous.

Ira

> 
> The const changes makes sense independent of the rest.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
> > ---
> >  drivers/pci/doe.c       | 65 +++++++++++++++++++++++++++++++----------
> >  include/linux/pci-doe.h |  6 +++-
> >  2 files changed, 55 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index 7451b5732044..dce6af2ab574 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -319,26 +319,15 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> >  	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> >  				    *index);
> >  	u32 response_pl;
> > -	DECLARE_COMPLETION_ONSTACK(c);
> > -	struct pci_doe_task task = {
> > -		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> > -		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> > -		.request_pl = &request_pl,
> > -		.request_pl_sz = sizeof(request_pl),
> > -		.response_pl = &response_pl,
> > -		.response_pl_sz = sizeof(response_pl),
> > -		.complete = pci_doe_task_complete,
> > -		.private = &c,
> > -	};
> >  	int rc;
> >  
> > -	rc = pci_doe_submit_task(doe_mb, &task);
> > +	rc = pci_doe(doe_mb, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_PROTOCOL_DISCOVERY,
> > +		     &request_pl, sizeof(request_pl),
> > +		     &response_pl, sizeof(response_pl));
> >  	if (rc < 0)
> >  		return rc;
> >  
> > -	wait_for_completion(&c);
> > -
> > -	if (task.rv != sizeof(response_pl))
> > +	if (rc != sizeof(response_pl))
> >  		return -EIO;
> >  
> >  	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
> > @@ -549,3 +538,49 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_doe_submit_task);
> > +
> > +/**
> > + * pci_doe() - Perform Data Object Exchange
> > + *
> > + * @doe_mb: DOE Mailbox
> > + * @vendor: Vendor ID
> > + * @type: Data Object Type
> > + * @request: Request payload
> > + * @request_sz: Size of request payload (bytes)
> > + * @response: Response payload
> > + * @response_sz: Size of response payload (bytes)
> > + *
> > + * Submit @request to @doe_mb and store the @response.
> > + * The DOE exchange is performed synchronously and may therefore sleep.
> > + *
> > + * RETURNS: Length of received response or negative errno.
> > + * Received data in excess of @response_sz is discarded.
> > + * The length may be smaller than @response_sz and the caller
> > + * is responsible for checking that.
> > + */
> > +int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
> > +	    const void *request, size_t request_sz,
> > +	    void *response, size_t response_sz)
> > +{
> > +	DECLARE_COMPLETION_ONSTACK(c);
> > +	struct pci_doe_task task = {
> > +		.prot.vid = vendor,
> > +		.prot.type = type,
> > +		.request_pl = request,
> > +		.request_pl_sz = request_sz,
> > +		.response_pl = response,
> > +		.response_pl_sz = response_sz,
> > +		.complete = pci_doe_task_complete,
> > +		.private = &c,
> > +	};
> > +	int rc;
> > +
> > +	rc = pci_doe_submit_task(doe_mb, &task);
> > +	if (rc)
> > +		return rc;
> > +
> > +	wait_for_completion(&c);
> > +
> > +	return task.rv;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_doe);
> > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > index ed9b4df792b8..1608e1536284 100644
> > --- a/include/linux/pci-doe.h
> > +++ b/include/linux/pci-doe.h
> > @@ -45,7 +45,7 @@ struct pci_doe_mb;
> >   */
> >  struct pci_doe_task {
> >  	struct pci_doe_protocol prot;
> > -	u32 *request_pl;
> > +	const u32 *request_pl;
> >  	size_t request_pl_sz;
> >  	u32 *response_pl;
> >  	size_t response_pl_sz;
> > @@ -74,4 +74,8 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> >  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> >  int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> >  
> > +int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
> > +	    const void *request, size_t request_sz,
> > +	    void *response, size_t response_sz);
> > +
> >  #endif
> 


