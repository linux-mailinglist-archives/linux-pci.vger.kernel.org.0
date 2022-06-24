Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2464558D6D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiFXCrB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiFXCrA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:47:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4756C56C3B;
        Thu, 23 Jun 2022 19:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038819; x=1687574819;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dz3JlVvM+NCp8/ANdmpV0PgW+Aj6UnSgstLBRwYzrVg=;
  b=O8ri+1FZWNpTqTBlJqeV0Vt3QDgM5zm0bwTluo2+uGODkBcSpnUsEVsa
   k9Jx7aEmS0RvdZoeVO5rKKy2iZLXEWs/XM/hzVN4zROyZ2o0QM52koWOc
   jIdBzc7dAb6hxbbCRxPpgrwYZsl20iCF5ZsWwUlXAJ7qIs2Pdk0pXVZpb
   m/duUC3yQsqa2SUx3mGnpxGGHGxhNob+Tf+y2btbBSlAzz+CLFDG6VQ1o
   tzw6yfEl96MtYf5gIapOGLshsNF5i1vIqMfRf3apz/SvgfHwOennX0HaC
   cUwijYxobHXt008SbshkFFFLhJPzWEL2CxlJDtfQQdGYJnF2ovIFWnSaD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="269632529"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="269632529"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="834933872"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 19:46:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:57 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:46:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQB8hxw9wtFb0dKPouYb3fhWS5DYa+FAaTMTisj4VbjwR5tuyfPUmUXUdXHoR9T/CqaExWNQA0/hsani3UZhAAMLZDO6u/vCrx2ullHaVPY3cfXXjsRsvnXauJ7uocYDo5QcWruPF8wrqrGh3VA+tpT4MX8UkEFMvajXTX5fA8IKtinPKBTH2xUPOAmss/5r+bo6bPxMWuRzsI5xsL6PSy97tvNgCzyGzAwxSzhNYs+EPkFvrzNp4YnnPY6hj+oel0+zLHRkHYY6AwxqKh2+LjmN0/5w1iKjG+9g/cepfwkQj5CRFcRlL2F68lPMM6pBm7wLnhg+ZvB6nDbftcCJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdDwD6qacucb9YTQbht/3NtFFAez2c2okMTsMqRnzLs=;
 b=aF+mI36sh8oUvtFCXO7ptLwAUtnEgSB17iWnQabj+d455FILTRz2WnL4OL4XMugRZALlLfjeaJUayVvMXPnGBA0WXhO18GuCU3FJHw6seCBcYs3jnyHxLx1BM5P6KdRB20Cjt6mM7yCC6VOo4coQmyb8x2uMJqCIPcDxImnY+a86CIA5SdDgcpiX8tYzIo9+rI1yxVL1LSocSKjhDYjRtb4V9eBPQ568bgPiAGotc/pXcWEYwDqyz9bbbWv6gT9FiJTyuKCN87pneicEP7eKxFyFe5YPACmKfQD9uc2IMFiHrfQHEEY90HZMouDac+vlpC/fnzwdSmEnDHUU3IHEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:46:55 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:46:54 +0000
Date:   Thu, 23 Jun 2022 19:46:44 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH 14/46] cxl/hdm: Enumerate allocated DPA
Message-ID: <165603880411.551046.9204694225111844300.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MW4PR04CA0327.namprd04.prod.outlook.com
 (2603:10b6:303:82::32) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d91bceac-39cd-4664-ebdf-08da558bc76d
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YoTzZzWzJMYTgZETcE++wwiW+Bc3/gxfOy+HJlbWsFv9bS9Pu6H8TAg9DOPDwGrjtg3RURM+hCjCUxBvTdK2c/S5KtbZDTDhLBGVzuya2kwl1JQUI32TvmyDLXmyREVvY60WgdezQXA7nWCr8crBYuy8Vt+jNNjZJdQp2BnYjbStUHsn5hVFC5h4S5vL8GbktQ1gwg44/DD31vIItlSXnkkh9JmMQpF9EEfRxX5eJxJy1FwZP+EhVAfQnLdmv4BIz7rhU0M70MBHdIxA72U/CQYAh7XKCt3j1QYKSfGkYcy/fmLnDbLblWoLlocvU+24ZP5c9S8aCXuLFPaU1BVbKDp+kFe2EM/y+g+n8PVSPdoxXyveEvZqvCnHV5vZt9LPatMzy2uRzfAkN6b2tWaq/UACjA1ueiKlvgKvqRDA/06/J96pZ6heIz+Bi+D0Sq/0q9pHObwkNZNzufUD71fBndMb7utBtdMwecPq/rf+57eYMX771U9s9MG7FxzsJsGiVZII5RUdIlnlklpTKkSe0pYDraT1+mg1k+XHWyTNGctw+hLxgC+V+mHIuYsk8qku57ce4NqARoKkPCNkWdw5vN45jNI1caceRTOk+1fHvjXdahx0Rxdxo9IkJAi3da/Y4zyoFDu0e5OqS9yqrxLh9LZjdrWcFz9vYEjnrSfWZJH4Sp9rJ2FDZtzahvjJKj5fx/iQ1Hegq9X+YGVNhTcam0993kbYAAWt2bsFJp60xdeAQ7mGLZ7GrYAreQimAkQG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(6666004)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aTc3e3J89KqnwehVkufvF3ug8XAXtRUvsTk/adRoEg/Om4I1aQCST9+yg4VL?=
 =?us-ascii?Q?OVakiAGh0tmTH+iLmtoPYde25K69hRvvbWt2ZEKC1o2cKnqZrVWESW8WHX04?=
 =?us-ascii?Q?PJ1UCF/LeMd/RCPCWRxBvM3zUkTAbG6e7TWLEYHmLRURNj8qTkCa+86+DfGd?=
 =?us-ascii?Q?O6/XRgqU6eiok9HL51XqfVRoPmAo2cz9CmZnTBmGMvf1ZkjLIj7S4c4GcFf+?=
 =?us-ascii?Q?wZvFYfrAT02NebN5XZnNcedo0zbJCCK8OqUTqrbmk0xyL1bbf+n1oqt2WsSE?=
 =?us-ascii?Q?SD6mQnUU4y0V6xFrAERvvw+8ncPrM42ZocVf8wyKKdoMPm4V99mB5n3K+WTB?=
 =?us-ascii?Q?zyzBrLGvxp5udhohVe5j4acPXuSiIou6klZnflmR73I5CT/GE2RvcdDMW66I?=
 =?us-ascii?Q?XTfMoZNbLDy78hPtA96hH2tWVbUItLLZWDTpQ6f5CGsr5xhwJgSnHAbeNFrk?=
 =?us-ascii?Q?kMAwvZlr4B2IvOzdqee1G1HV+JDytJ2A/gq80EjmAyACGzgkK1DALNhXcT/H?=
 =?us-ascii?Q?yVSanot5og8aWQCMPtXFg3oh+/XRgxDcuB/D7gZHx8g87EwKa0zQqcI+aMTg?=
 =?us-ascii?Q?tWRLg9F941Cgfxdi0DbnBFBOsfgr5/nU6O8dLp3/Wy5WRsFDV42Dx7wTWobv?=
 =?us-ascii?Q?LCVGKt1W9HNLe+GDwh1RLc1Qh7O7qetKJglNHdKfR8Zu3aLW5F+zTMx3SDIF?=
 =?us-ascii?Q?xsXVvZfsN5azprgBWh9+fTbAMwAGdRAPe+pMl+lpmeSJwGrwibyAxgbAwLDv?=
 =?us-ascii?Q?fYOp4pkmuE4meiU6rzZDb8y/htghVsQiLNAj51FpRt5QRWOSQ9W0pWnsXeN+?=
 =?us-ascii?Q?FF4KJtZb5tAtq1TAx4B6dHI2qfB7s0O1P9OcgH6HLeVF4r/PaYZM1HRV9iML?=
 =?us-ascii?Q?WfJmb5Ip0yoN1twr5mGz+48ptK3ysI7mu9KV00lMoZ+Pouztgn3nz5cCiQ/9?=
 =?us-ascii?Q?S2w7vkhQJGAZCPAh28COl/HPh9BgFWs4iH2URxPxpBfs/TWS+clreex+5mcO?=
 =?us-ascii?Q?26plm0pbLzoGB0SVglAUUe8mk4lVBRNZxc0052Fm64f8ia2fWqhwZV1viskR?=
 =?us-ascii?Q?T3RwjhCZltVJzPqyeRMSUBhUThpG/m+CAn7xi89K3O8xPY+ODWWgvWlaJKmV?=
 =?us-ascii?Q?1YeEM+EpMoglwntSVZz0hHkO9hWZczuA7ZCykzLqbvBm8svng3hypeanb3XC?=
 =?us-ascii?Q?DJoubH9KuGJ9PFjPwYDFEIxVU/YkORgtLJ1SVYeZXTQnU4us2u7XC5o+q5av?=
 =?us-ascii?Q?dr7qJVHb5/Jm3/sU53JLfr2kATtLA0rHOLS9hdydGHYYRaAZSEBaUBLh6HgC?=
 =?us-ascii?Q?FI5M73COM0OdyVvdy9ZydasnlF96k9XGKJU9wxOgMtuuchUtiHAmfnYYT4vK?=
 =?us-ascii?Q?904DW5oXD4O1FXyK1qW239DCrUb9dBQ7HdheUJ6Oi2S3g1KtXJV7kHsSZn2A?=
 =?us-ascii?Q?I51m+5Bx3aD9IvIiHyKsUm3v+M7RXjdY6UaGdzF5LQECqUggu9cM5fSGcpiF?=
 =?us-ascii?Q?0PQqk2WdKbLiKPN+1V9SiRPVDWgxg72rbdACcxBBRMtQwq0bBqzCrPUbBvFI?=
 =?us-ascii?Q?xcrbm6ZSpZBpCxgqI6pgJtW3PaPVaNJOoyOHjIMorE1bCxt6ov3Z5+3FO0tX?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d91bceac-39cd-4664-ebdf-08da558bc76d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:46:46.3218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JG6ppHoG1+8qY/0ySOyAqckhKUQNFnEu0VVDv2DMX3AXKfXT2z9bNBQnpx8nTuI4Cx63h8KBEVxh3OS9lc1ARGOJP7NQweDmmDMtfuk5+Zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for provisioining CXL regions, add accounting for the DPA
space consumed by existing regions / decoders. Recall, a CXL region is a
memory range comrpised from one or more endpoint devices contributing a
mapping of their DPA into HPA space through a decoder.

Record the DPA ranges covered by committed decoders at initial probe of
endpoint ports relative to a per-device resource tree of the DPA type
(pmem or volaltile-ram).

The cxl_dpa_rwsem semaphore is introduced to globally synchronize DPA
state across all endpoints and their decoders at once. The vast majority
of DPA operations are reads as region creation is expected to be as rare
as disk partitioning and volume creation. The device_lock() for this
synchronization is specifically avoided for concern of entangling with
sysfs attribute removal.

Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |  148 ++++++++++++++++++++++++++++++++++++++++++++----
 drivers/cxl/cxl.h      |    2 +
 drivers/cxl/cxlmem.h   |   13 ++++
 3 files changed, 152 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c940a4911fee..daae6e533146 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -7,6 +7,8 @@
 #include "cxlmem.h"
 #include "core.h"
 
+static DECLARE_RWSEM(cxl_dpa_rwsem);
+
 /**
  * DOC: cxl core hdm
  *
@@ -128,10 +130,108 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);
 
+/*
+ * Must be called in a context that synchronizes against this decoder's
+ * port ->remove() callback (like an endpoint decoder sysfs attribute)
+ */
+static void cxl_dpa_release(void *cxled);
+static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled, bool remove_action)
+{
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct resource *res = cxled->dpa_res;
+
+	lockdep_assert_held_write(&cxl_dpa_rwsem);
+
+	if (remove_action)
+		devm_remove_action(&port->dev, cxl_dpa_release, cxled);
+
+	if (cxled->skip)
+		__release_region(&cxlds->dpa_res, res->start - cxled->skip,
+				 cxled->skip);
+	cxled->skip = 0;
+	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
+	cxled->dpa_res = NULL;
+}
+
+static void cxl_dpa_release(void *cxled)
+{
+	down_write(&cxl_dpa_rwsem);
+	__cxl_dpa_release(cxled, false);
+	up_write(&cxl_dpa_rwsem);
+}
+
+static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
+			     resource_size_t base, resource_size_t len,
+			     resource_size_t skip)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct device *dev = &port->dev;
+	struct resource *res;
+
+	lockdep_assert_held_write(&cxl_dpa_rwsem);
+
+	if (!len)
+		return 0;
+
+	if (cxled->dpa_res) {
+		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
+			port->id, cxled->cxld.id, cxled->dpa_res);
+		return -EBUSY;
+	}
+
+	if (skip) {
+		res = __request_region(&cxlds->dpa_res, base - skip, skip,
+				       dev_name(dev), 0);
+		if (!res) {
+			dev_dbg(dev,
+				"decoder%d.%d: failed to reserve skip space\n",
+				port->id, cxled->cxld.id);
+			return -EBUSY;
+		}
+	}
+	res = __request_region(&cxlds->dpa_res, base, len, dev_name(dev), 0);
+	if (!res) {
+		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
+			port->id, cxled->cxld.id);
+		if (skip)
+			__release_region(&cxlds->dpa_res, base - skip, skip);
+		return -EBUSY;
+	}
+	cxled->dpa_res = res;
+	cxled->skip = skip;
+
+	return 0;
+}
+
+static int cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
+			   resource_size_t base, resource_size_t len,
+			   resource_size_t skip)
+{
+	struct cxl_port *port = cxled_to_port(cxled);
+	int rc;
+
+	down_write(&cxl_dpa_rwsem);
+	rc = __cxl_dpa_reserve(cxled, base, len, skip);
+	up_write(&cxl_dpa_rwsem);
+
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
+}
+
 static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
-			    int *target_map, void __iomem *hdm, int which)
+			    int *target_map, void __iomem *hdm, int which,
+			    u64 *dpa_base)
 {
-	u64 size, base;
+	struct cxl_endpoint_decoder *cxled = NULL;
+	u64 size, base, skip, dpa_size;
+	bool committed;
+	u32 remainder;
 	int i, rc;
 	u32 ctrl;
 	union {
@@ -139,11 +239,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		unsigned char target_id[8];
 	} target_list;
 
+	if (is_endpoint_decoder(&cxld->dev))
+		cxled = to_cxl_endpoint_decoder(&cxld->dev);
+
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
 	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
+	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
 
-	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+	if (!committed)
 		size = 0;
 	if (base == U64_MAX || size == U64_MAX) {
 		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
@@ -156,8 +260,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		.end = base + size - 1,
 	};
 
-	/* switch decoders are always enabled if committed */
-	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
+	/* decoders are enabled if committed */
+	if (committed) {
 		cxld->flags |= CXL_DECODER_F_ENABLE;
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
@@ -180,14 +284,35 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	else
 		cxld->target_type = CXL_DECODER_ACCELERATOR;
 
-	if (is_endpoint_decoder(&cxld->dev))
+	if (!cxled) {
+		target_list.value =
+			ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
+		for (i = 0; i < cxld->interleave_ways; i++)
+			target_map[i] = target_list.target_id[i];
+
 		return 0;
+	}
 
-	target_list.value =
-		ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
-	for (i = 0; i < cxld->interleave_ways; i++)
-		target_map[i] = target_list.target_id[i];
+	if (!committed)
+		return 0;
 
+	dpa_size = div_u64_rem(size, cxld->interleave_ways, &remainder);
+	if (remainder) {
+		dev_err(&port->dev,
+			"decoder%d.%d: invalid committed configuration size: %#llx ways: %d\n",
+			port->id, cxld->id, size, cxld->interleave_ways);
+		return -ENXIO;
+	}
+	skip = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
+	rc = cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
+	if (rc) {
+		dev_err(&port->dev,
+			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
+			port->id, cxld->id, *dpa_base,
+			*dpa_base + dpa_size + skip - 1, rc);
+		return rc;
+	}
+	*dpa_base += dpa_size + skip;
 	return 0;
 }
 
@@ -200,6 +325,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
 	int i, committed;
+	u64 dpa_base = 0;
 	u32 ctrl;
 
 	/*
@@ -247,7 +373,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 			return PTR_ERR(cxld);
 		}
 
-		rc = init_hdm_decoder(port, cxld, target_map, hdm, i);
+		rc = init_hdm_decoder(port, cxld, target_map, hdm, i, &dpa_base);
 		if (rc) {
 			put_device(&cxld->dev);
 			return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 579f2d802396..6832d6d70548 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -56,6 +56,8 @@
 #define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
+#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
+#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
 
 static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a9609d40643f..b4e5ed9eabc9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -50,6 +50,19 @@ static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
 	return container_of(dev, struct cxl_memdev, dev);
 }
 
+static inline struct cxl_port *cxled_to_port(struct cxl_endpoint_decoder *cxled)
+{
+	return to_cxl_port(cxled->cxld.dev.parent);
+}
+
+static inline struct cxl_memdev *
+cxled_to_memdev(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
+
+	return to_cxl_memdev(port->uport);
+}
+
 bool is_cxl_memdev(struct device *dev);
 static inline bool is_cxl_endpoint(struct cxl_port *port)
 {

