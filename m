Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDC36327DD
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 16:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiKUPZF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 10:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiKUPYu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 10:24:50 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315A160C0;
        Mon, 21 Nov 2022 07:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669044288; x=1700580288;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eijioLNtzG+TjkZFe2FMwG75TJeu06KBn5jnRKggDq8=;
  b=Gp0bd0zxeercHChvbIiNMdh/3CFiSGL6OG4de7b2nMQNCn/KuKoKvZOn
   wEgRF+q1v7jAlKs0eK8cX27TcuA8zMQ2p4EPAws1XizV+EqF+hBxDIxnQ
   EZRWPdygMpkIlU/CiF5WHuO+Jpc+jhGjNARVcDL5W0qKkj656zUESIWOq
   i8Qm24ozMuhmq5kaVYU9OW9gtMtPWqJ71kDVX/zArvNVLoEaTfAnHczYK
   F8iacATXxo0L8Dyb8xYe3E3XJE5+u3NmcPcUlyIEUOYu4yBHWGvrHmn58
   wauO1e0WXYNNGw+yYu6m0fb4TazbdGlagZQQaFcE16Xl+fiR+DIglyria
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="377843132"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="377843132"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 07:24:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="886156641"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="886156641"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 21 Nov 2022 07:24:47 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 07:24:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 07:24:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 07:24:46 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 07:24:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX770OIv2P23YILNNQ9IOEj2Ua7hgzbvBMBKF846PiG64mtO96g/MJWhLjcSUhe87EbZ98wKhMrpMuU+8pAjH+GpOvHYHRZGnY9Ticwm/K0+Jxa+vVIELGE0fZAbYUCiudcvmE2SYMLnyUI83osaRQEbYXwjid7e6mXRCAMCX7oLikUL5S9yWSSaf0004gOF6NDHZx1AWSKJ+WLNUVajccJN3CtQo3oZkMRDjf0WbhSgEWuqEwPVPj7Y9WWh5Rdm/NavTKdwYmlM3m0RHTghBiXjnL7o66JM4zgQA2f3H43sNJvFdgUTA4JdsgeAMqywhk9cNiSMVjP2pv7S5cdXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfSRODcTgeOCph+bS1PmPiXh4lF7ZeuDRRjU+ppgr0c=;
 b=Mzvj8a/LJMEfYSM4cwjkwQ3mCL1MZXcldWiz9wqZ2R45o1DEmhEZmYQ8/DsM78vE4Ig+26HGM26zSrgBRTAGuFV+D0hceVIyzXTgV3jb3iV7qX1WGIbXJLG5JFUxKsvlPGGrL9LKszO5Z9il83soZlYHL3G3A1l0SIE9R2hdT1Ydw6myjH8jjKaqOG5Zuodjpqg0eUWRDOmKBoVzWAeairmU7ON6qWyx1N9NRr6D6CbkpJUrmuUF3kAHLhMhqwJBbcuRnCzWYYOVxW8i8oWHRcD4L5xNdChDzn+KbVI12Ihgufbz14orU4CpqQjxATV1go0i7Dgud3KSbFFDc+n0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB6852.namprd11.prod.outlook.com
 (2603:10b6:806:2a4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 15:24:42 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 15:24:42 +0000
Date:   Mon, 21 Nov 2022 07:24:37 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI/DOE: Remove asynchronous task support
Message-ID: <637b98358f7d0_1ee2429488@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221119222527.1799836-1-ira.weiny@intel.com>
X-ClientProxiedBy: BY5PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::19) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: eda5a95f-7e98-44c1-eef7-08dacbd48229
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svvjN+XlDJPs/xTnaIMTh0ZQpjLmXTdmLSz0ibQtbTZ/BS1NfiJNpkpBTPHq35Ji7oR2Qwb4ugOEbcgFzfUPlvSYRxO9Qa5w7IoN9/yP6aZzUgu9oJ4+tJvbjTReOBM+YGTA+Glb6eDJUMR9B5CMR7oSHRO5pCG41aEK4Npiol7gTqDnbLVCtUImnDDMs9bjbfkKx0RHoDA/5+oL1GyfL6Am+O+W+Ho/B5Hcfilwebs2uEgGEBNUG+34Vt4QGjLPJUb9XHgZ68UCfsgixmaBLwQCS+hVhdq9TbMYEKDxkpEdDwX6AQdOK/uPEoJw6oSuQ10/7zY+D2ivXdkgNXN2sU4hgolXYrXJZRKrKmrYNdE0tOAJMS/uGyWDdj2IA15cuoTi9mCa3qopPVj6ZKQIRkbW7Z1ioMQqURZm8zBXcY3fu1dpT3QC+jIzsI/j1m1t7FhDNP/whyVy5GuyomiiD2JdmOwLK1KpWbIHMo115OZELMoLZmBvyCYT9lFo3VsYRLuriA4SdFVfaxKqd8AC42KeZ+8jTUiUnjRKhwWQ3sJoUqzNGYmOJqo+Egd1eTZ911Az2/ZMccEPHIVgbAhBRCnsCPSpcPEggXs+iMtUVmvYJSrkOUn4iGNrtcZG3s50H6M47snKQEXD8q1pKAtNiflLgh6ekETCcK5SSmOwljx7JEGEqBFadpVORbOwO236rVw+U6oFdWF4MjIu1ja9fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199015)(6666004)(30864003)(5660300002)(316002)(6486002)(966005)(66556008)(478600001)(4326008)(66946007)(66476007)(41300700001)(8936002)(83380400001)(186003)(2906002)(26005)(8676002)(6512007)(9686003)(6506007)(54906003)(86362001)(110136005)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+6mKdWVHvrenGXCRe8Bh28q7JoIcPsgiYY6p4IC9zEogvq/Py2v/cJfmjobk?=
 =?us-ascii?Q?mVkYz3zIVlvJRndy5dKUrmt9NqBW/ORUddg2eOfE7Ujej++RejPIVwFSGBAz?=
 =?us-ascii?Q?nsVkXId13yhKs5M/pCVvCclC8VPUrOqez6etVn0B4e4WjuktZIjH8t/BliYv?=
 =?us-ascii?Q?S6QTdOM8QR/rck+R25o7QT4gQ2WOOA8bjJ3e+BKD5UR1QgJMccOLWegKRJlT?=
 =?us-ascii?Q?5qwI5LHFELBTOdiMXahb8JLtPKC3BeYDiiT9p1isKjEK2hPbAOrgVpAoMi0i?=
 =?us-ascii?Q?dvy++WFVLFJ3jBmUNLnbg8dvMYzRaO8n1rEJM0Fyj7hFpt1d5zYY6QgAj0G2?=
 =?us-ascii?Q?qmjW0NQrDSkpF4UHMeJw/g5+fhA3VaeKjqutyT56vdKEAxtJdw+49GuHvSVw?=
 =?us-ascii?Q?RSe+SLcD50shk5WsWpKiYA8j47NaHwGA5VzHPul33gsvWHgViHU0mm3edsnd?=
 =?us-ascii?Q?V/IJQ71e3l9FebxVhJMRKLQlf0NO2aIbDe+YZHq3jz2Jb8hcZ5pH14nFAjWX?=
 =?us-ascii?Q?56S3DaJX4D+aNufm6rVOanJzlqnnSJ+QNfBit/A76YAce6qVaEN5ikDaVDRV?=
 =?us-ascii?Q?KTm7t9RWT0uj+45z5+wnv+6kGdsL2rX0oYik4kN73UwQDwKPqKjBFscDgXWo?=
 =?us-ascii?Q?nYHlmctMjlwi2RcqSI8WBRQcs0kilKqJK6+baLwFf7VbKWtC58rS+JwwMlS3?=
 =?us-ascii?Q?XjU0q0v4/jbCqcJsqeZXlBanQmBnWxu64AH2lpPxp0Xqpeo2WPwQaGMDj6YP?=
 =?us-ascii?Q?BhO7Ijf7QoEzzHHvCX7Y9gQKMiHilozKOddFtvGUxtuhe+EAZLdroJPughS+?=
 =?us-ascii?Q?RjwiP+kbuweFTimfAQ9fUisLpmWSvB0JBlxqYRxlJiDR8sFsv/Huyg6gIM/w?=
 =?us-ascii?Q?GAfQRY5/iBmlgaluZtl9jLj38D1P2SWLW6G19Q4SOg7HtsOP/jiOhyiGiIy8?=
 =?us-ascii?Q?mGGHtKPclxdQj96StRROLd4MRFz9s3IUJjTFuLzZZ1OvvIImZMv/82fTfy/W?=
 =?us-ascii?Q?6SJPI11zX02VTwRlYpZb0nBck3ZFdJJG6af3Xkb1FMHjQYGxcIq2OFsXwy84?=
 =?us-ascii?Q?sHmTy2OpYpYJkWIscJY1bxmHLN4+iKpyJwDwDy3AwLoU0tQ16Q4AmnJ6YNHM?=
 =?us-ascii?Q?axRk4VpHGIJa3CKoNe/r8TJDxZy1PRguvBNOsHv1flCTRKnut2OkD2cQ7bnj?=
 =?us-ascii?Q?Y15rvqv+qISCfc50fJAJldfYzvsAZGKp/mcqs6v3S7ESclWheoiwHlaHbzkZ?=
 =?us-ascii?Q?Dde/dHtum+oWNqpegL+/R3DtUZBLRHW3hXZe4CgUnyFdn87Esyw55G2Xkbio?=
 =?us-ascii?Q?n+zPaDoINNkH4DG4bPefIg/uAoBa1niZVp8Rq8zXojvg7zGphfkeqesWr4G6?=
 =?us-ascii?Q?5gfvuZkRPnm4zYvuDGaGxoTeCgCVAEqPRm/k5AE1aGKg0snoa8VmLi8Uiz7B?=
 =?us-ascii?Q?HXLv1tvpgDd+4RGcFdeorhJFkraYBQqNENQ8jIfrQPwKJZYprE9xQf9oSCX5?=
 =?us-ascii?Q?wo2G/j7eQ9fypk1gIV9e9VZzZbPan1mF3vhgcgK1B/5CwcaVnkTHaOAg5pm1?=
 =?us-ascii?Q?1+02OkNoY40DEu0lGhHJV6DOYshuWKVprDz/erzFV9UojeOaaE7YYPJOzw9A?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eda5a95f-7e98-44c1-eef7-08dacbd48229
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 15:24:42.5823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cA3P9Sf0T0uBX5ryi9vry1GUm6+JaujBXk8K1308IpdfzN9HSYyz3IwSYFW4s+Gu9ao+xj+myxPZ2kCVKnu1Zn9qW1iTsQKOrsKK3z6gGxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6852
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Gregory Price and Jonathan Cameron reported a bug within
> pci_doe_submit_task().[1]  The issue was that work item initialization
> needs to be done with either INIT_WORK_ONSTACK() or INIT_WORK()
> depending on how the work item is allocated.
> 
> Initially, it was anticipated that DOE tasks were going to need to be
> submitted asynchronously and the code was designed thusly.  Many
> alternatives were discussed to fix the work initialization issue.[2]
> 
> However, all current users submit tasks synchronously and this has
> therefore become an unneeded maintenance burden.  Remove the extra
> maintenance burden by replacing asynchronous task submission with
> a synchronous wait function.[3]
> 
> [1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
> [2] https://lore.kernel.org/linux-cxl/Y3kSDQDur+IUDs2O@iweiny-mobl/T/#m0f057773d9c75432fcfcc54a2604483fe82abe92
> [3] https://lore.kernel.org/linux-cxl/Y3kSDQDur+IUDs2O@iweiny-mobl/T/#m32d3f9b208ef7486bc148d94a326b26b2d3e69ff
> 
> Reported-by: Gregory Price <gregory.price@memverge.com>
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: "Li, Ming" <ming4.li@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Thanks to Dan for the bulk of the patch.
> Thanks to Ming for pointing out the need for a lock to prevent more
> than 1 task from being processed at a time.
> ---
>  drivers/cxl/core/pci.c  | 16 ++------
>  drivers/pci/doe.c       | 83 ++++++++++++++---------------------------
>  include/linux/pci-doe.h | 10 +----
>  3 files changed, 32 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9240df53ed87..58977e0712b6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -490,21 +490,14 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
>  		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
>  	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
>  
> -static void cxl_doe_task_complete(struct pci_doe_task *task)
> -{
> -	complete(task->private);
> -}
> -
>  struct cdat_doe_task {
>  	u32 request_pl;
>  	u32 response_pl[32];
> -	struct completion c;
>  	struct pci_doe_task task;
>  };
>  
>  #define DECLARE_CDAT_DOE_TASK(req, cdt)                       \
>  struct cdat_doe_task cdt = {                                  \
> -	.c = COMPLETION_INITIALIZER_ONSTACK(cdt.c),           \
>  	.request_pl = req,				      \
>  	.task = {                                             \
>  		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,        \
> @@ -513,8 +506,6 @@ struct cdat_doe_task cdt = {                                  \
>  		.request_pl_sz = sizeof(cdt.request_pl),      \
>  		.response_pl = cdt.response_pl,               \
>  		.response_pl_sz = sizeof(cdt.response_pl),    \
> -		.complete = cxl_doe_task_complete,            \
> -		.private = &cdt.c,                            \
>  	}                                                     \
>  }
>  
> @@ -525,12 +516,12 @@ static int cxl_cdat_get_length(struct device *dev,
>  	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
>  	int rc;
>  
> -	rc = pci_doe_submit_task(cdat_doe, &t.task);
> +	rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
>  	if (rc < 0) {
>  		dev_err(dev, "DOE submit failed: %d", rc);
>  		return rc;
>  	}
> -	wait_for_completion(&t.c);
> +
>  	if (t.task.rv < sizeof(u32))
>  		return -EIO;
>  
> @@ -554,12 +545,11 @@ static int cxl_cdat_read_table(struct device *dev,
>  		u32 *entry;
>  		int rc;
>  
> -		rc = pci_doe_submit_task(cdat_doe, &t.task);
> +		rc = pci_doe_submit_task_wait(cdat_doe, &t.task);
>  		if (rc < 0) {
>  			dev_err(dev, "DOE submit failed: %d", rc);
>  			return rc;
>  		}
> -		wait_for_completion(&t.c);
>  		/* 1 DW header + 1 DW data min */
>  		if (t.task.rv < (2 * sizeof(u32)))
>  			return -EIO;
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index e402f05068a5..41a75112b39b 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -18,7 +18,6 @@
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
> -#include <linux/workqueue.h>
>  
>  #define PCI_DOE_PROTOCOL_DISCOVERY 0
>  
> @@ -40,7 +39,7 @@
>   * @cap_offset: Capability offset
>   * @prots: Array of protocols supported (encoded as long values)
>   * @wq: Wait queue for work item
> - * @work_queue: Queue of pci_doe_work items
> + * @exec_lock: Lock to ensure 1 task is processed at a time
>   * @flags: Bit array of PCI_DOE_FLAG_* flags
>   */
>  struct pci_doe_mb {
> @@ -49,7 +48,7 @@ struct pci_doe_mb {
>  	struct xarray prots;
>  
>  	wait_queue_head_t wq;
> -	struct workqueue_struct *work_queue;
> +	struct mutex exec_lock;
>  	unsigned long flags;
>  };
>  
> @@ -211,7 +210,6 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
>  static void signal_task_complete(struct pci_doe_task *task, int rv)
>  {
>  	task->rv = rv;
> -	task->complete(task);
>  }
>  
>  static void signal_task_abort(struct pci_doe_task *task, int rv)
> @@ -231,10 +229,8 @@ static void signal_task_abort(struct pci_doe_task *task, int rv)
>  	signal_task_complete(task, rv);
>  }
>  
> -static void doe_statemachine_work(struct work_struct *work)
> +static void exec_task(struct pci_doe_task *task)
>  {
> -	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
> -						 work);
>  	struct pci_doe_mb *doe_mb = task->doe_mb;
>  	struct pci_dev *pdev = doe_mb->pdev;
>  	int offset = doe_mb->cap_offset;
> @@ -295,18 +291,12 @@ static void doe_statemachine_work(struct work_struct *work)
>  	signal_task_complete(task, rc);
>  }
>  
> -static void pci_doe_task_complete(struct pci_doe_task *task)
> -{
> -	complete(task->private);
> -}
> -
>  static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
>  			     u8 *protocol)
>  {
>  	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
>  				    *index);
>  	u32 response_pl;
> -	DECLARE_COMPLETION_ONSTACK(c);
>  	struct pci_doe_task task = {
>  		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
>  		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> @@ -314,17 +304,13 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
>  		.request_pl_sz = sizeof(request_pl),
>  		.response_pl = &response_pl,
>  		.response_pl_sz = sizeof(response_pl),
> -		.complete = pci_doe_task_complete,
> -		.private = &c,
>  	};
>  	int rc;
>  
> -	rc = pci_doe_submit_task(doe_mb, &task);
> +	rc = pci_doe_submit_task_wait(doe_mb, &task);
>  	if (rc < 0)
>  		return rc;
>  
> -	wait_for_completion(&c);
> -
>  	if (task.rv != sizeof(response_pl))
>  		return -EIO;
>  
> @@ -376,13 +362,6 @@ static void pci_doe_xa_destroy(void *mb)
>  	xa_destroy(&doe_mb->prots);
>  }
>  
> -static void pci_doe_destroy_workqueue(void *mb)
> -{
> -	struct pci_doe_mb *doe_mb = mb;
> -
> -	destroy_workqueue(doe_mb->work_queue);
> -}
> -
>  static void pci_doe_flush_mb(void *mb)
>  {
>  	struct pci_doe_mb *doe_mb = mb;
> @@ -390,12 +369,9 @@ static void pci_doe_flush_mb(void *mb)
>  	/* Stop all pending work items from starting */
>  	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
>  
> -	/* Cancel an in progress work item, if necessary */
> +	/* Cancel the in progress task and waiting tasks, if necessary */
>  	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
>  	wake_up(&doe_mb->wq);
> -
> -	/* Flush all work items */
> -	flush_workqueue(doe_mb->work_queue);
>  }
>  
>  /**
> @@ -423,25 +399,13 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
>  	doe_mb->pdev = pdev;
>  	doe_mb->cap_offset = cap_offset;
>  	init_waitqueue_head(&doe_mb->wq);
> +	mutex_init(&doe_mb->exec_lock);
>  
>  	xa_init(&doe_mb->prots);
>  	rc = devm_add_action(dev, pci_doe_xa_destroy, doe_mb);
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> -	doe_mb->work_queue = alloc_ordered_workqueue("%s %s DOE [%x]", 0,
> -						dev_driver_string(&pdev->dev),
> -						pci_name(pdev),
> -						doe_mb->cap_offset);
> -	if (!doe_mb->work_queue) {
> -		pci_err(pdev, "[%x] failed to allocate work queue\n",
> -			doe_mb->cap_offset);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -	rc = devm_add_action_or_reset(dev, pci_doe_destroy_workqueue, doe_mb);
> -	if (rc)
> -		return ERR_PTR(rc);
> -
>  	/* Reset the mailbox by issuing an abort */
>  	rc = pci_doe_abort(doe_mb);
>  	if (rc) {
> @@ -496,23 +460,22 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
>  EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
>  
>  /**
> - * pci_doe_submit_task() - Submit a task to be processed by the state machine
> + * pci_doe_submit_task_wait() - Submit and execute a task
>   *
>   * @doe_mb: DOE mailbox capability to submit to
> - * @task: task to be queued
> - *
> - * Submit a DOE task (request/response) to the DOE mailbox to be processed.
> - * Returns upon queueing the task object.  If the queue is full this function
> - * will sleep until there is room in the queue.
> + * @task: task to be run
>   *
> - * task->complete will be called when the state machine is done processing this
> - * task.
> + * Submit and run DOE task (request/response) to the DOE mailbox to be
> + * processed.
>   *
>   * Excess data will be discarded.
>   *
> - * RETURNS: 0 when task has been successfully queued, -ERRNO on error
> + * Context: non-interrupt
> + *
> + * RETURNS: 0 when task was executed, the @task->rv holds the status
> + * result of the executed opertion, -ERRNO on failure to submit.
>   */
> -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> +int pci_doe_submit_task_wait(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  {
>  	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
>  		return -EINVAL;
> @@ -529,8 +492,18 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  		return -EIO;
>  
>  	task->doe_mb = doe_mb;
> -	INIT_WORK(&task->work, doe_statemachine_work);
> -	queue_work(doe_mb->work_queue, &task->work);
> +
> +again:
> +	if (!mutex_trylock(&doe_mb->exec_lock)) {

Nit, lock data, not code. This is not a lock of exec_task() it is a lock of
the doe register state. So I would just call it doe_mb->lock.

> +		if (wait_event_timeout(task->doe_mb->wq,

At the risk of going all the way back to the original proposal, again
apologies for my premature async advocacy, I do not understand why this
chooses to have a trylock+wait_event instead of just queuing in
mutex_lock_interruptible()?

The mutex will attempt to maintain fairness in its own waitqueue. If the
current task in exec_task() sees PCI_DOE_FLAG_CANCEL, it will drop out
and release the lock and then all waiters can check PCI_DOE_FLAG_CANCEL
before exec_task().

At a minimum this needs a comment about why the built-in mutex waitqueue
is not sufficient for this case. Otherwise, this looks like open-coded
locking to me.
