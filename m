Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCBF558D52
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiFXCpW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiFXCpU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:45:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2C056757;
        Thu, 23 Jun 2022 19:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038720; x=1687574720;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N/JOWKmPpe5WKo3XhKj8F1LmPUZK/Z0aEj5Tw/CgYxY=;
  b=erSUCTuv23hw+JBsBjpm5MnBSzLndyfDYRJpI9CXPc+N6+Q1PZHG0otw
   EKGMxrgjEF907dWQrIaCV8UABLWjqny8BmiQbGnpYgpbA+9FYkQRFR1Ci
   LcrGstq7wknExHxadehKJyDPy6nqNs2n2zFYq6y1M3OhjqFIJNU0AEspb
   aAiEH+jfCtzhb438St797hDgoecUMhgiFyySb7q/AB+Dwt0XREJC0Z4RU
   kZqYWGcs0xnbaO9m4/O21FgIMOVQ+4TSwsbzgfWd0uxKbOPJA0y9RH+ja
   TFMM6WguqWJvqc8Xl31VnEwg+Pnhk22QmtXt8oKzqI1VWg2GxOyyWG1GA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="260721924"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="260721924"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:45:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="834933150"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 19:45:19 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:45:19 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jq2UWMmaKuiYRsQXlSjXK7hapjovIwd6lI5uw8wvkUDBAxhLTPlo73nupqRO6C4vxOtUVOQWk0fG9P0Iu4EhV7RVt1M6Bh+WGsh/0Vh1YtfY1uo0woMP8ZcQPYSiNeRRdXeyeVnDf7G932yOWCyknTmr5YDnm1iU8EirXJdv6N3CPUQ7NDTDDrB4LPRAQlKz2Yw1mz9BbtSW0kWEGi64iZaK22cakdqmIuVN5DetDD8tu8fwmgNNA1D0Jip9VePDPoSgsufGswcQUPb/3IuLfCsru4eYhRzBNBWmx7YK+JtoJiuKCBBvGEaW/bsLzKW8P95oDpUKthIVMCxVPV7vWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ntl9wxR6g4xykERacCZePKsROjjbl6kQ/gOWEUt1qPE=;
 b=DW2ZrJTBnL1gZOwxa6IWw54HiQbqWqHllHFYhVDUMv2Y4pXxJFWWhoJs/vUS2Gaoj0GYNM4lvZVCZgDGFRPL7rhmIkMZMEvY6r+gwKQthhdJJGI1k2sF8xHubNbhNXHNWTqEhS7FjhiLVXK2xqmh4sIxIGR/BHpLOfBYHD54v5or7fvf4lYJbswklUc5xwaqahW/MdSdYmU5NywFlT+kQu91M1iagVIMQYY/xKRPKDO/30Z0OkkcbGJoX6KUh4YUqQBys5pKZP0ed/+B4GVMXGhNn6qsdIYvLLiWQLt3K2dc2Q6Chk2VLUxJov+RBJqzMcpemSMhvwiCGhSb6PtRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:45:16 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:45:16 +0000
Date:   Thu, 23 Jun 2022 19:45:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 02/46] cxl/port: Keep port->uport valid for the entire life
 of a port
Message-ID: <165603871491.551046.6682199179541194356.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MWHPR19CA0064.namprd19.prod.outlook.com
 (2603:10b6:300:94::26) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa050fff-26cb-4f7e-c552-08da558b91fe
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARnRUkP6uWzLqlqy9Mptm4E0fqzCfOy0GUrvnv7s+lplsIyjECc1aq9mXDfgU3RzwnAE87JH/+zv8ryKZ1UECasGQZgkCd/ifEyguXtghEouO0Lvxr9fTCDZTUywXov8b55XHffE9f+BZHjpdPC0sh+u/fFtCK3lSztZ9/MhhleZx96LbKbMvS4ANGJ8f3qXfOd4L5mymLpbFKKoIbkKjRHFqblN+cysmMIAo7bFpiL/wjcmyx75ua8tmFYssc9CUQHe58OE9hdJTpQDgj+MP9c3uIFtXFWZt93rgiio6MxdpQQ65AG0r51/0p328D2jUcWVtuE1tauNc1EaJKWzK+Cnu80rH0I8VP20/nftoqj8Qu23GjuOfF1cEeLK/eVFf9dTvLK37cmfWJMyTmA4oz49my3Sr2Ek5F1yqD2JTZc6g2DnpIGipR82aOfU3h6XS2pnbH4Vjd3vEy0AAMSRy+Plbo4tj6hR/IGV2fGQ+CoDQmJ0RYavcLwXfJhKkk8q8oEQWCMPGJBzLq9v4a5Pkl2VgjeNsr/X+gMREttPS3GJDE2rdqf0UMQ8JEt3EJV6JiqeKX321dAwKYkIg1IdAJ+ABIZYkKtTjtvFfkjpjw6Bu3GlPOOq4erekVaOKFEPEUY98kBZ8UFNQCqLO0dNhBIF5BtGouewaUOscwO0MavqDjZl8upaVC4B4EcIYbYVIFpTPJcKc8+Osu6Y9WSW6e9S3CWPBxBhpxo8a3BGKke+x+2xvtwl3Azl6lUgbRHD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(39860400002)(346002)(136003)(366004)(186003)(41300700001)(316002)(83380400001)(8936002)(86362001)(103116003)(478600001)(26005)(5660300002)(2906002)(6486002)(6916009)(33716001)(66476007)(66556008)(9686003)(8676002)(6506007)(6512007)(66946007)(82960400001)(4326008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DeweV4nKjfdOECP7rVh+/7QY+po/h8kMx1C9UFfs8UpM7Qz2H0wEyZFZzh0W?=
 =?us-ascii?Q?HfI5aOWc1AeAVWpeg4R1xb0cv0aNZ6o6C1pMNg6e5vwXQTiZmfm9R7v0/jdM?=
 =?us-ascii?Q?hp2tdWAcGk1zDW0/sV7w2kIkm9dVYRG30rXHevSS/DZX67YApe1vujQ6S9UT?=
 =?us-ascii?Q?VXfeUGgC6Unw6sZYsBL7NX/IMIevnILjrOKpA2gYRMPNexRMS+rgZGh5xX+C?=
 =?us-ascii?Q?RgJLH35yr8DhUyUzJM1/39KbiPGHSXyfpfBbVBKqDPlIEY6IgrrRJ5NW/9Bn?=
 =?us-ascii?Q?tKK6Et4iLigyQ8VgWVsmNYDDoj4O1wJBrhZHYGvLDx5L25683DvZls8m6Gzx?=
 =?us-ascii?Q?0KEYO4hKekWABLXwSyVINjR3eSRbYei1tSXSj3p0GUs3g7FIubms5LMIrqKH?=
 =?us-ascii?Q?XT7g6KmdMvSgwEZjuvmSi9Yi9XQTppQ2Fn1sRa+TVF9ZrHQD5E6iDg/SDYz7?=
 =?us-ascii?Q?0AANY7kfa1lVZUG00uQZ5plVbSFiewcf23QkGLc9SQ8nV8E3zZmNXILozdeq?=
 =?us-ascii?Q?tf9aPohJfk8at2UeS7JkJksA1YWWekvyvw11znE68Izp+EsR+IwDIODkT0lp?=
 =?us-ascii?Q?y4jZ75A9D0BZRFLihKU3GMrcIH4jppRn6iKYhdaIaflGvu/UEJDc1X6mLiVi?=
 =?us-ascii?Q?mJf8GQzX6wELATQ0FaqFw7A0eGa4KXwV1vWIuN+zM5hSNS/j9kzUcGxM3dX9?=
 =?us-ascii?Q?JvO8Hw6/4/eCJIzbJ1Vnjo/iK4Gw0lHDICdlvKWReLcdVAUB6wdxqqU5yrCD?=
 =?us-ascii?Q?AqGs8LBZAHY2ACgkc8POwG+dIs4ZxjP8/hhpGp8UPRU+X1sePi4MAaDYoCjP?=
 =?us-ascii?Q?e5cTWc84uquDKYhBM0+KiXyhjRgRbKiITh9DQQsUcnMUdYiSOBSqJtnEWp92?=
 =?us-ascii?Q?4E21mETSM22W9awjiWHEDTCgPoljM49aXsKQQK0u3yuaGeEm0UGeHkXCp2Yu?=
 =?us-ascii?Q?MNv1XPPrOMIv+Rk/RfEUDQ+bhlKAqjCJYAaqb1OJzkwIEoV9JW6M7kx3WZsz?=
 =?us-ascii?Q?M3S9WqJt7qLIy3MVIhV0zUWVqMbdDUWBmilalSEElEdyfVQxr1zlmjAJFqiK?=
 =?us-ascii?Q?qgFDFhlVCw01Mv4EP/T7uaP9Uq3CCq0hBv/4gsBMEtR9ceDGOgjyUI30uDDF?=
 =?us-ascii?Q?MmysrPX30WM362iHzIvH0sBpyfWx5T+S88e4kODcaMJRazumc2x2ULzHaTwL?=
 =?us-ascii?Q?EaKNC6jX5uIrQdO1xJ54PYYvffuhjMmAkhGe8hNhF4NRWFpQaWHjlZXHylIz?=
 =?us-ascii?Q?FER5DhwCbHwjRlm2nWTbEi5f5FtAaPdF/xmHhDgTSyI7kURjKS5JEgIb701X?=
 =?us-ascii?Q?b2yum9IiliXteCm/kCMkJYgqp9PM0qMYWb9p6tTXx99LEcRcOQEBcYHd+yKE?=
 =?us-ascii?Q?8hZU5/El6DpSQm+/MGwaO8YVSBepZ7hJqHCM3CGDQ+cqlCwKIr2nrxY/3sMY?=
 =?us-ascii?Q?NWda+I7A696ei5PxDZQpV812otGpGcd+kFap4NeQWmj7HmxizM3+5YPfmtM/?=
 =?us-ascii?Q?rklqY7M5YmDKy403NcGdaTcCiWeAuzLDm9k01OKWYEa7Xn9Lewl3WkYj0KAn?=
 =?us-ascii?Q?RFOOmbZixHLIe1GoY0iZjevCTQhAcl8aLyQ96fkBylmeEjd4e3zXGGtj4aBI?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa050fff-26cb-4f7e-c552-08da558b91fe
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:45:16.5960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6aPjgwhcV+N8a0LydJwR4jry5y1VYrg/0G/1HyjpBZQyqP8QSBnAUExk+gwxkTOFElO66Ri/rEOC7psnmbas6pSClvXTnJrptmr/rqehvL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The upcoming region provisioning implementation has a need to
dereference port->uport during the port unregister flow. Specifically,
endpoint decoders need to be able to lookup their corresponding memdev
via port->uport.

The existing ->dead flag was added for cases where the core was
committed to tearing down the port, but needed to drop locks before
calling device_unregister(). Reuse that flag to indicate to
delete_endpoint() that it has no "release action" work to do as
unregister_port() will handle it.

Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index dbce99bdffab..7810d1a8369b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -370,7 +370,7 @@ static void unregister_port(void *_port)
 		lock_dev = &parent->dev;
 
 	device_lock_assert(lock_dev);
-	port->uport = NULL;
+	port->dead = true;
 	device_unregister(&port->dev);
 }
 
@@ -857,7 +857,7 @@ static void delete_endpoint(void *data)
 	parent = &parent_port->dev;
 
 	device_lock(parent);
-	if (parent->driver && endpoint->uport) {
+	if (parent->driver && !endpoint->dead) {
 		devm_release_action(parent, cxl_unlink_uport, endpoint);
 		devm_release_action(parent, unregister_port, endpoint);
 	}

