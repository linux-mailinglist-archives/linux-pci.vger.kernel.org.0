Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032EA6498A3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 06:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiLLFcp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 00:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiLLFcm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 00:32:42 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB210CF4;
        Sun, 11 Dec 2022 21:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670823161; x=1702359161;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UvtoeP7Azr6DI5W6rdn8Nh1V1c25BqZSDtjr782QnHU=;
  b=KygMa0mA8CNjBk+qaIkhN9RndtEMWQ4oRYibKrc1APPMuHVspjl6XNQC
   D2WFc+h980eU7ZWl/2xLWZq5vQMhER3Mj+sk5dvttTiE1OKkOeaa9045e
   hMaC6yUsZlXI7wmvI2IjpgYOuNJa/ekJIHDIyqiob0uOP8CvygU5nCpzf
   xqUC43lKlb9x8cIPmCYUOAbgNxD43Tv5NSIxRwZHidWQUSPWx/afxFdrP
   zSAqMv0C3x/0EOJ8ez5r9EdVx99/D83xvkx5vqOTtXZRyKN6XHCXM+qCX
   6Guh9n6z25yjcS3xOxMr2a7wjWmqog/IqJ2549Scd8On6VcmU2N1+KCAR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="316465794"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="316465794"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 21:32:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="648039651"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="648039651"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2022 21:32:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 11 Dec 2022 21:32:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 11 Dec 2022 21:32:39 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 11 Dec 2022 21:32:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REeKt+CXym4Dfzl4F1gEALlk8NZzEV6o9Qpvp+zLG39GfZr7qkQtGEk3LYgktfti8aBeNqpZCuI+zkb9xg5M17ft5KlnItE/sG+h5VS7Zj0uatCJjqTCd6VsgJi9fyoUAsLxe6D2BF+f79EEMhyxuzAMt96dPKhS3pXvyxvCt+V53TAuUfsB/jzNtyvQ2XmGrRX/2OQwj8xO+7EpXq0aIdeU2iY6zBBs5cmgpg3Qw+QAcb//JZEPDJqax9x95IQC8q5WG417+IlHEeD0yV6iOd81A6P9jgJ3vjGtWPiWMxX9bpiS9/iptyM/mrUX00MZeeoFwLPeXNC3s0McfFPmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BiFYsVTyb8mzOAo+a4zTSP5BPPdOdWfQHqgklEt2hg=;
 b=QsxaVkMuNTC5RsIahKBAJ7lM0fTyghRLr3yc0S/DD6uuSzc40jAm6vRK1zCkJOWTl8hca6idfU5mR9sVK3Kmv9ydQn2kI9RPt6m0Mx9LTfitC5U6JeKvzcZL32ejRdDfaioNajRsRIRZi46AAOyJQNpgbjqFtkJg1voYwaufGcfpPQ4qgBl1SXG7ut5qhtRS0xOd9kvW8rhkFlVHnDb8LBt9xXGzu9B84dFGgEwCrBP2lqDgVpTJtUybTUpnhsRZRN0FKJ/bUXeI9XWRZr7BKA3cw5t1SDUBoFbfsH6Dsx7g3F3DminYG23xiGbYOvP5+LIxOwZ7sixpq7qcBc+/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV2PR11MB6021.namprd11.prod.outlook.com (2603:10b6:408:17e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 05:32:36 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 05:32:36 +0000
Date:   Sun, 11 Dec 2022 21:32:33 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 0/9] CXL: Process event logs
Message-ID: <Y5a88UgaE3EzJFQh@iweiny-mobl>
References: <20221211-test-b4-v4-0-9f45dfeec102@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221211-test-b4-v4-0-9f45dfeec102@intel.com>
X-ClientProxiedBy: BYAPR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::39) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV2PR11MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfb05db-0295-48fa-5668-08dadc02471a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Esz3yX9bp7fE9/Tt0vuvnvVAAmntViKGm9uRhaDn39+3USPRld9r2IpxCmVQVfP38XdtYjzcSjWlO4iOHa0Gh98jdJVUzbwX7LbMV2Y4vGky1QD24nPnKwXQpquC/n6V+Y0/+PkxrQl5pzuw5tFmPOkwyCPo6duRzUCeWp1Cw4RsvshROMmlKfqIWfbS5XlKXjAVUMmP+x34b+tufl9Jm+y0dGdqIDJ+NYetT0nEalbjes8f0E/ms7uh0Msz40aCH9TvkZaqT/b2fadAgL1DJJNLyUYU/XZiyvtOC9ArFpCpjSahxUy7X5M7LQWUoyJFCFROZEvzUTFcoppHyXdYc7UHFsSwweq/ELEg9vLXcap7ExCgjtUZFiEwttvuKwM8ZnTKQVrtnXXyphmVrPEUVtx4OZPRVhq9+prqzkLv4p4NnDOYslkrxM5vRN3o6BrXIZ5tFImI1hGVhVejtz2mirKc4ahUX9i2c66QkH+C28y9kGzcaAV+ps38pq8ShVdDCOLuJ71SxRFgI4SCb4MxiQIMsx7g+DvB/vCND+Ak5xtwG5V0onDKm10UH96YKQfDJ68/fWrlzhaFt2oYynb0PQqjtoy7eOZ80zgHZfAl+K1XiLeUtWzKxEpa8XL6QjuAx803L5zBTKsZJzrKcNCtjiMyQASrkawxYpBQITisPS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(2906002)(82960400001)(38100700002)(44832011)(26005)(6512007)(6666004)(6506007)(86362001)(9686003)(4326008)(41300700001)(54906003)(8936002)(316002)(110136005)(5660300002)(66476007)(66946007)(8676002)(66556008)(478600001)(966005)(6486002)(33716001)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PMb7tucj0euKgplMCUAhLltsIx7Cptj+wENXxUROOK+4Lwiqgj58h7T1prML?=
 =?us-ascii?Q?P0v32bWdoswHMm+3ID6x67qtpYunq7L8HAYGw9f7wmJDgVnYwNlNNp96kYwh?=
 =?us-ascii?Q?JnR5kJ3yg8aDMAmYt8R0OkaM+oPlTFJEmhuxXMgxgdZ9+TU9P0WpO7dZ84/B?=
 =?us-ascii?Q?beQY+98CVvH2sHT4G3lG0fSnDHTVIUX3FqHzhmY1pf0JAWJlyGUSKHNegi5E?=
 =?us-ascii?Q?s/+F+D7ULzYhocqEkLxuBilE7Lti7/qGQRuSpc3nX9cWTxaJ+xa6ugUj0cZD?=
 =?us-ascii?Q?qgb+h4Jr/2JWNgIHkr8bRE1JngAhbtrpc5P7/nC9xtqi7zKFVyETmzgQ3+Pj?=
 =?us-ascii?Q?aoAyUX3UoHNcnqF6NvVMUyEdbih+5hsAyxIRq3JSqJIuClKeS/G4B/GVOZQ4?=
 =?us-ascii?Q?wWafexsHcSCOAzogVliWyZtIPsHCH9I9Z+GUiRKAyYBGNvpDDiuboID6hnsT?=
 =?us-ascii?Q?dJJHhFux+zH8pZ7+3cgT2TSlhwmI2ODKTSA6ug0NoFpLlibbeAjssXHfaiug?=
 =?us-ascii?Q?+YvpBDPLOgDTCFvb4OZZds8vH/m7IXDUz7AM5+mVzXn9lreRuBs0c6CJT9Ly?=
 =?us-ascii?Q?Vf0xfnovtUeHTSnH085CJrTM7YMxHk+IV/qelA2KMscamS5SY1C65NSqcjui?=
 =?us-ascii?Q?miXumHYHUzqI543wSGq9BTuC9SDwcig8iMbfmoCJ1xoi9Fag//3j5PfIQ6sT?=
 =?us-ascii?Q?6LlVNl6iuvkmXWCNipIlBPlrcnGOpMVz14CndTmgDicyYraUmkLJYlMwhnLl?=
 =?us-ascii?Q?YslwTPdClDexkkDxlax5sukMjne8YVOnYicmWC1Rbkaa/Frhil9xtCLZ/ShB?=
 =?us-ascii?Q?7elQigYFM5ETBzbqafe47t5bEHC8gBIFwAW8jLV6YtrWQutj7eqQEN43IwrI?=
 =?us-ascii?Q?tlXbkGIUF7ncv4a9Xb63A3JIqiBH0aDONrQkjVF622QCjxakdQraaIW1rNP0?=
 =?us-ascii?Q?yUyl/J4GMShOjk+BN/GLbm8Lr3MMzQNwMNjHgtcKA834nAHXHOvsTKEGzbvf?=
 =?us-ascii?Q?wAE05128DtkHuSjrK93eQxdacnl8vDBrBWXFUrk1KV+61EXTSEkF66qw9JRa?=
 =?us-ascii?Q?xSfifyTCFbJ787KLqIGK1vcTl/7xxjWYwuOpHCwKVDjsNVFJM8oKNgemAeRt?=
 =?us-ascii?Q?/PyZ0N3r6/dgNsA7JsnMK+kP5r9UK/gkVGJvWCy4Z9i2R8e4BrDA00ZFYSC5?=
 =?us-ascii?Q?E4iomcJqEIICiKMflrHY93wzUWDl44a7DJCEaqWZ7hKdv7L4XBUEfrejIOXQ?=
 =?us-ascii?Q?Vd7va79+kuDBCZqr+Sc4vPaLzfM9dOQ6wqzG2yqrKiFR00dF7v44dc/zLBYD?=
 =?us-ascii?Q?z0ydfTD2Eq1p2tDRy3Uc7vQn+RDfPFeGqOGt9A4J0rCV8CX4S0DNnWzMofYI?=
 =?us-ascii?Q?XFGxb3wN71QtirQD85SEME604OP9O9J2iNyhVfPaposg6tybzj6Bo80iJjbb?=
 =?us-ascii?Q?R06RlJHyvS+M7h+voKRIV6t0NMSGQ3e2p4puXinvf6O+N/ryYSW/r3W0p66A?=
 =?us-ascii?Q?Qs/xgpaQXaDlK8pvjqK77fTSVakJIesvc2LBE6r8nywUbUTfyYaAT2bh2aBj?=
 =?us-ascii?Q?Hf3GP6MkGbF1gUsFjrNJeXvSJqh+q6QMI3e8LpMZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfb05db-0295-48fa-5668-08dadc02471a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 05:32:36.8694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jLQURDfTrmSvujvLPZkaqBXAXZbVvlFz61/RBngEeBSr/UhSdet464Lu1SoRQGhABCbVYxwErlnfk9CsA/64A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6021
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

My apologies.  Please ignore this series.

I'm trying to use the new b4 send functionality and was trying to send this
only to myself.  I'm not sure what went wrong.  The patches should be ok but
this did not get sent to all the intended lists and people.

I'm going to resend this hopefully to all the right addresses this time.

Ira

On Sun, Dec 11, 2022 at 09:12:19PM -0800, Ira wrote:
> This code has been tested with a newer qemu which allows for more events to be
> returned at a time as well an additional QMP event and interrupt injection.
> Those patches will follow once they have been cleaned up.
> 
> The series is now in 3 parts:
> 
> 	1) Base functionality including interrupts
> 	2) Tracing specific events (Dynamic Capacity Event Record is defered)
> 	3) cxl-test infrastructure for basic tests
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes in v3:
>         Address comments from Dan
> 
> - Link to v3: https://lore.kernel.org/all/20221208052115.800170-1-ira.weiny@intel.com/
> 
> ---
> Davidlohr Bueso (1):
>       cxl/mem: Wire up event interrupts
> 
> Ira Weiny (8):
>       PCI/CXL: Export native CXL error reporting control
>       cxl/mem: Read, trace, and clear events on driver load
>       cxl/mem: Trace General Media Event Record
>       cxl/mem: Trace DRAM Event Record
>       cxl/mem: Trace Memory Module Event Record
>       cxl/test: Add generic mock events
>       cxl/test: Add specific events
>       cxl/test: Simulate event log overflow
> 
>  drivers/acpi/pci_root.c       |   3 +
>  drivers/cxl/core/mbox.c       | 186 ++++++++++++++++
>  drivers/cxl/core/trace.h      | 479 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h             |  16 ++
>  drivers/cxl/cxlmem.h          | 171 +++++++++++++++
>  drivers/cxl/cxlpci.h          |   6 +
>  drivers/cxl/pci.c             | 236 +++++++++++++++++++++
>  drivers/pci/probe.c           |   1 +
>  include/linux/pci.h           |   1 +
>  tools/testing/cxl/test/Kbuild |   2 +-
>  tools/testing/cxl/test/mem.c  | 352 +++++++++++++++++++++++++++++++
>  11 files changed, 1452 insertions(+), 1 deletion(-)
> ---
> base-commit: acb704099642bc822ef2aed223a0b8db1f7ea76e
> change-id: 20221211-test-b4-e9de44001b6e
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
