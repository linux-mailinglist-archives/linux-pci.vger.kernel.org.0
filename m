Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21AC608215
	for <lists+linux-pci@lfdr.de>; Sat, 22 Oct 2022 01:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJUXdQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 19:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJUXdP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 19:33:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96442AAC39;
        Fri, 21 Oct 2022 16:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666395194; x=1697931194;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CExfIsYws6jz3RalKJKs/uM3A22cwSyPXZ6NyEzcaPo=;
  b=DXbdmxitFMC7W0xHtX1eUtnRZzIxtj9TS6vJB1wdqXX1i4XmoKVf2ZP7
   zZIHyIGw+O/zeRa1oQ4ko9fQT/W9eqdRKzI2nM9RNxu/0C7NSGIUCcDwf
   kEtk4zZ2SZzkjBEZXcQTrOuu5SSl0CJN9w4HXEl4TIPHXv9jFySyC4Io3
   38RjwEox6BtcAdRznd9019/THXJJsKx+NXdL3NIEmfYm6JjbsXB/c8DNw
   pRJbj5JzFJSMmv/A6dPp7j2QKWvZ2EJnTxj+QSapMAJTT0WQvi/E7nw9Q
   4ltxKmyECpG4HGyDjX0JmCPgOv0YRTXD8FGjC/DEfrW4mRsvtJuoSFm1y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="333706711"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="333706711"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 16:29:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="663937390"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="663937390"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 21 Oct 2022 16:29:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:29:06 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:29:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 16:29:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 16:29:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhKFo2y7ogTuQjSslObnIBDr/NrDUWKU96RZ1jDCWE9tvSCmciNHLjXBlrTM+ORIJ7pxZIByvRLRQoKkznUPXDaumGYidha127hwFePRJr20324ux2fVS2r1l1kdGny6aMeH7ni9Xjrcvkfv49iPU/6csnhyPHtzCYBO12bOocZbOTPwdovi/32HWxWspPP8cMcKxqPyKRjKC6LH5NxvJz7/ajdZpL+UX0gNgC6LHwVu6+XXqX/12KQiETGtN9zSiq/i70tONQ9lJ//Q10MLSMe7Xgqe1G8LED00+sJ57Pr529DhT/g5AUZVGfVXdp9uyQS/lPSv3J58aIPfOAOzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNuUMKMuIfO40p1MrusbqiyppQrUIQSAjgk+FwW1Yt4=;
 b=BsahX/E5uDhUXPUkXVVYuE1teblgcpHADXDShCJxWg16Y6JJ7gfqEbULZBoPdglyomll8BHCiZF6il8XvOTwVF8Q74/3Eww05uPXBm1n536nFdHgPQugYW5I+CNmb57/didRVP7VtEcPd6PXeK09hrLsSKAriM6lvj83kp9LotFYMDlxmDFS28ZggvXSr6ioEURLi+MHTT8Hqgh0uBwXi6qpnYbG9S9FgX/mFyIKD3bqfbtWBH7tpsvrIOqYClUB1pNqCcp207zVetcTbPQtFWZ99kR9QpKJn43LMHEWqSSzam3qeh8DV5IHU4usGDbRY9WQndToMqe8ueB7CBCXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA0PR11MB7306.namprd11.prod.outlook.com
 (2603:10b6:208:438::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 23:29:04 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Fri, 21 Oct
 2022 23:29:04 +0000
Date:   Fri, 21 Oct 2022 16:29:01 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V3 0/2] CXL: Taint user access to DOE mailbox config space
Message-ID: <63532b3d9a65b_4da329488@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220926215711.2893286-1-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220926215711.2893286-1-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::15) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA0PR11MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: d83a7deb-d55a-4ab7-5222-08dab3bc0a6b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ghk76lAmfUbxgx11JGOFQPEJROBhefmQKV7t8iUdNkERGz0lCtPyr00ZKjh15I6iYwu911rV+vR6NGrMH1mEwIWV1Aka+IskvkfeVQHULoYw1IFCF97P7TkXUwoGe0ZvvFcyE1GeRMdxT+DpB91QtBeRuFhHw2Jzzta4beTknfauxKp1bC2alAYP2hCNN8HDdz6LHouTyVGsbpJnL6EjrMzeyntSE+JVLcukIbU+oR7c3KKjI2U78uUX1JomA+GR3JDTkAAN2F48k+aajFQLbQ+qKN434wdGmFriMQx5C23Ji9KRXONYy0RSM988cHb2zN58jPXMgs91+5cYc6PIuODFiSC/Pe9dXuRQqSj6bBYjORGccJcqH5wf/M41Mss3gO7IW91yHZ0E5RvAAkJE+J/DvLZpXVNTSOII1h3e0vmjx0k7VdTxFw4ITYANSipmfeKNSIITqE8k0V79BiytL0Hvwm0LJfanuuUrmu0wxCpWWwP3BeqYYRLkeMpASpOX+z6nphBn25w0zU6db04sObF5iS5btdAWQhkpe25Bz1Z0gxo82alkdQzntvZ+03hBAdmQqcpF/iGeY7AQQ9229ew54Z9FAMc1Yn3CVou9JF2qIS1nZSmQE6/inNeuTB/BhbLCoiqjpOdIkQvfjy2ld/xPI2/OuoIgRnUh4+Nhz1M6wYINqdPU//i/UFhUGEBADTNzWA/RArjiQi+cYmSA/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199015)(15650500001)(6486002)(82960400001)(478600001)(6200100001)(6506007)(83380400001)(38100700002)(186003)(54906003)(4326008)(8676002)(66946007)(26005)(66556008)(86362001)(316002)(9686003)(6862004)(6512007)(2906002)(66476007)(41300700001)(8936002)(5660300002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iG6yCg/t5HPHd8KqFvO4O9ocmtV+ViVRvNARbIKpMTAT0x3q92mXBuyrNFSf?=
 =?us-ascii?Q?lxHedRgyyFzdvZNH0kw5zseIoJZMBQ34jyels78aH8gbkDd8rCoo32/N04kE?=
 =?us-ascii?Q?n6PWDi2b63ZLnFHcEtqOGD9TxKeRjvRTa3swry39x8Ti+Y5s8++4/1SHdccM?=
 =?us-ascii?Q?MgTAy73y098IBx6IJanhyxXhVgpn0WrgfkEgd/swMsOleE/L7rxwbdxSM7HR?=
 =?us-ascii?Q?98f0QUyKqGCc/4n4ELF+N9h6k0P8gz8gmbLzfdQ7Qz7pVgp0sqlYtHvYGieI?=
 =?us-ascii?Q?eD0A2JHQDmlnth/hK1PXluYUvPS/uv+pu6DOEi9SUYzvUt83WL7O1stkXcwR?=
 =?us-ascii?Q?7wnGI059bd/nCbG2kTZUlwCokBcjNT3paXXUu6aTsTe9iS14fKsGYM2ke2Ce?=
 =?us-ascii?Q?31JK/6+CItGNKdflM2K9DIbkudq3GW6D8FjtC7u1MDsNtFZWnay0DoU1YV87?=
 =?us-ascii?Q?Dc+AfBtKngzhzH+FLxIuFWbrp49Xkn2A5cDoZpzbo5DrrW1rSIgo8UEwmTFb?=
 =?us-ascii?Q?LPsspi1V/TFilW5meSZX6Vs8/GTUxncpNkislnjzcz9NY7WOETMBpso5WIBT?=
 =?us-ascii?Q?FrYwFpWXUjCWRbREMAn5T00Sj6msOxniw4kEqgirYoftMHo3XG3BlS9zfDW7?=
 =?us-ascii?Q?pkHzh+CrflnVRP2dgaBTKu6SxGQeKqx7ylndOLYOcZnfQ3z4+Y3BuWuHqAZi?=
 =?us-ascii?Q?rq2I3H992XPLmQBy9ML623V8nxcPvJwP9gYqu54fEGtvZOrj7yNUoj5tgACI?=
 =?us-ascii?Q?vOt1ZbxfMfnyjxqw/+QrQfHW29Zf52qIvlPxj2b7kxeRO3dlXnPHPzwGEOyZ?=
 =?us-ascii?Q?aGuSD+FYSp1BRAzzyDi3GRmovAPYDqTOfEw2CMnrIUcFLhYkMxcCa04d7jmC?=
 =?us-ascii?Q?TKqhEjVl5jZ9wrngwFPf+t5eS46MdFy78rtRvPTWtQECR0r1lpgsjTu1E1NO?=
 =?us-ascii?Q?rkIRSKKrsKpiB3pYFa8SDW03ejQkjgzKhC5wlbQmB2wYKJKctsldPek8H9Qi?=
 =?us-ascii?Q?2B3zraEQTGbCp0Sm0kBT7B9M2BSs1iPBWqLjnyTxZUF5X12gy88EY3UcKeh4?=
 =?us-ascii?Q?qgaf7stDx/lqTd+F3zrxlsqsCWkicxumlrVO5MoQRCnCj8Fso0iTsRV2V5IQ?=
 =?us-ascii?Q?vD1zEV5cU0aq99k8+vCj7ny7BScASvAM4+InTCcPewILgYpKemwZL5NqAWBo?=
 =?us-ascii?Q?kSDYmIETaM9AHEb1AVBcZmeSbyCmHA1YY+iNOo+mUZNntfyMOOhxhIrDMSan?=
 =?us-ascii?Q?I5vc+Von+xqX1oawNDaT5pik7VjVqxyKrBGJLi65upk57//bcmHAKgl2rKAn?=
 =?us-ascii?Q?QNwjJc2z5w5Tmn5qjpquFJTq/ePOAErTwG/YbUIBwh3aoW68FI23f3YcWZSI?=
 =?us-ascii?Q?mEMw0360Es0rQZOQlyXsALR+7m99SHNGgeVCxwjxaISWNPsbG1WcTLvgjLxg?=
 =?us-ascii?Q?+rgMLENTbJILknBQKaO8GIXjSkbvc5VZwZ1FX9ddiz34xXkj2+WTIZeI6eYL?=
 =?us-ascii?Q?nm61b2lyXwDWtRE0BtqVIDadbP/2mfonJVk05XT2RqVSZwRze+KXlHJ5V0R1?=
 =?us-ascii?Q?EhhYYR7S4jZQdJV+bxpmGJU6B9iDvej7tRBCsG2O1YZi8NF9zM+YELmCDX6U?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d83a7deb-d55a-4ab7-5222-08dab3bc0a6b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 23:29:03.8719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXxxdlGZi6LniXslp3n8zWaXYymYCsYypl7sky0IdxK4Rx2HBEYU1xCVazEKpNWali+VNySMWag8tDgew55YiNpl79v3djI6suICHLZv830=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7306
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Changes from V2
> 	Incorporate feedback from Greg and Jonathan
> 
> Changes from V1
> 	Incorporate feedback from Dan and Greg.
> 
> PCI config space access from user space has traditionally been unrestricted
> with writes being an understood risk for device operation.
> 
> Unfortunately, device breakage or odd behavior from config writes lacks
> indicators that can leave driver writers confused when evaluating failures.
> This is especially true with the new PCIe Data Object Exchange (DOE) mailbox
> protocol where backdoor shenanigans from user space through things such as
> vendor defined protocols may affect device operation without complete breakage.
> 
> Even though access should not be restricted it would be nice for driver writers
> to be able to flag critical parts of the config space such that interference
> from user space can be detected.
> 
> Introduce pci_request_config_region_exclusive() and use it in the CXL driver
> for DOE config space.
> 
> Ira Weiny (2):
>   PCI: Allow drivers to request exclusive config regions
>   cxl/doe: Request exclusive DOE access
> 
>  drivers/cxl/pci.c             |  5 +++++
>  drivers/pci/pci-sysfs.c       |  7 +++++++
>  drivers/pci/probe.c           |  6 ++++++
>  include/linux/ioport.h        |  2 ++
>  include/linux/pci.h           | 17 +++++++++++++++++
>  include/uapi/linux/pci_regs.h |  1 +
>  kernel/resource.c             | 13 ++++++++-----
>  7 files changed, 46 insertions(+), 5 deletions(-)
> 
> 
> base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff

Applied for v6.2. I am not a huge fan of the driver_exclusive_resource
naming since it leaves out the configuration address space aspect.
However, any other naming I can think of confuses it with the
traditional PCI device resources which do more than just host
exclusions.
