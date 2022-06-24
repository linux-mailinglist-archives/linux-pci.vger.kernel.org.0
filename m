Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55356558D76
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiFXCrq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiFXCrl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:47:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1C556F8B;
        Thu, 23 Jun 2022 19:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038856; x=1687574856;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Uu69u4RfN/zQjuOLELQ9sAdylGk0iYV+1lZ0Twv6U5o=;
  b=DdiN44zJttGXFiUjEjNW7KqRMI8jL3wmn2wNY+K1nDid7wnWdDLvrk/c
   4J44sVx55U08VKZ7eKdX9wJqM67OZZg++VQKS6dRENRkeTfjCoV5Izhry
   3+VycNvq1wkau7GqsCMbkObJJdhYzNgGl4vvCWtT/CZ/fbp0SGTfyZo9x
   Fm6VbvMSFyPWGKlG9kXJUEgLvvm6BeC5Wv69+RQaBMhRXVk85PS8AkxHH
   n+b8cAgUnbkpKLmpFy1E78AqAn3H2FZQGouINOlZ4zb/XFxpTZDXBTNLV
   r/0K7hD3wKpjcBiSLU6hXc4iNBDzK7FeMLlT2U4PpUXNz7eLAs6glwUrl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="344898568"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="344898568"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:47:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="834934021"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 19:47:35 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:47:35 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8uwEs0xiEJiznCiGHNlO4SVLbJZkX5XhLMM4vyl11pMVLuwFb9k1xU4drM0umzZsIoN55yLDxBMqG9H386afZGJ6Djm8fti3w94ZpvqFBlM6p+pa5cj9CwpI3R3USrTvgjbJGHwLnMwy2v2DKzGM8dBvBE4yVjhPuBd27nt8uzCu5vnReizVR+1YvqE7w0PPZapzAcApqXgJPsxQqAM0EGi+N60PdSr4p8v8F8QGGQQg48OqRHP138+PDHE0w51K7NO2RAWeaC5xb2AEGMYA66pEZlyy1JISvPehr3aiW0G2C1sCnp2aHZOCOOTiiNsWBtl4elQBUdGkUR70IXRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWOFkoDpLa2Rar650FOvtRrs5FEMPCUvgHzxKtb0a20=;
 b=bIAI1Gv8IO5TK4uXIsfJOquChzY8E9tkPlrTnoiD0wvRfT0l77SU27PtOjf32Lw3kwpgcX473jzUihdeZklcz7VrS7Sqmm10M9b503cilh3bnyg935Cv9giSNRZYHozXtlkAa2iBVHZByxSLTmm/4dSee/39HD7o5YqXWUIxwtiQwD05cVsoq3WQf0Yvz/qrI5L26vq7DOSgOqUs/RMSEHnbfBEo0yQvK3Os3pB2ebCdovsPblWYcAAZF3jxXR+oY8290UE+2hQYEE10WnZeByilHqO5XQldjaWxQHyCXziaoyK9Mb1x7pGYdgoN73Jg+W+rN0wkSMqh2yWeUuJTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:47:33 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:47:33 +0000
Date:   Thu, 23 Jun 2022 19:47:26 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 19/46] cxl/debug: Move debugfs init to cxl_core_init()
Message-ID: <165603884654.551046.4962104601691723080.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: CO2PR07CA0078.namprd07.prod.outlook.com (2603:10b6:100::46)
 To MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82d84f33-71b8-478c-2922-08da558be05e
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqSIwWv77C7IaFHmobYc0OXvm0So1OGu98M0LtVvTbGBNWU9SE5DwZo8d7SERWwxybMbh5XL4FLxYKuAX2nIyn2UtSow3AqxSzFF2sDZfoLNaoQmhGkCc4QMgTnkyjTQO6499KbPBmncB9CLe+2FLoTqFVycVpxEBaLu3MUNJyygSJUUZ+XgtKy4b1Ghw7y5WPIDqCs+CwhD7lmIzwwnX77fapG3uS26UIRV31y3GmZ3LMrsy5BibQ1x5B+DQPHXt1W1AwmgJxgtuIxjseeTl7UEBXvImBNxr33YhuP16+P6buJI4413TM5XDa6qeo8H3S7tjifplVgVW12Kv7qs4/tD/k/RlJCU3kAI0SeQEuHH451IlqHoUuqiocyPOzLUGcZdW0xCesmNV4pevXzlLeEfRtrjKfAFUn6x755mEcrSb7vwTNCJ/nNko+69/ofFxDJo1bLkRJKIQdB7cRUStpuNkpo7RFGIDfoRVsBEbEcP4STBsQjS1mHpQB8jFHIatfekT1swGQkX0ykYHghfskqf2yuX4X1F3mJweWg+35MPBWMNSzd0rsl7KPTXLldclJmWoZs4U9Qv3gcGrxDvXcKK7taZVkJblhvf6AYOV0fgb58OSrDjLwWebgg+Vbmn6raTTQC/fydhK68b23WNRFu52lr489Hc5nrjjywaLWOBmubfEqEByDYdcHQXYf6/2OcFSEyjWqy+eI8gDvK0MiZH8QMpxWT5wI1cXvkdxzMRB28Zit38PuwGKUmEg7K/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(6666004)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AmonIobMrdFzuZGcuXm3hWmkvoOFYGTcJw+x8wByDyBLvdoqCoMiLt6yWgPJ?=
 =?us-ascii?Q?k17TLAiasG4fsUqsMZOz+rYBXdFf7w2rRM1qwO1h74upyjRyYLI4K1eGePOu?=
 =?us-ascii?Q?PgJMJ7nQkyn1VpqB+EEi0FKNNQVHw7sfTNxUlA7e/t3zO4nxYc4L0RefqDa3?=
 =?us-ascii?Q?sDBKfswAOfyFFT0CuGkQiiS52gmq7f6WQ3Ci9IA3GPYIqoFO/0GfEVnBCcxb?=
 =?us-ascii?Q?jLfrjv/m2WHEXPWUWlfEFtH7XVl4GXFlkIlEJK9RmVuHE0Lx+OXUgpf1dpuO?=
 =?us-ascii?Q?9NAFQwT8LY0oBLhaq3sNX70w4nHVpEIwK77cPbogS8R6et9OuJ8c/LTcvBX0?=
 =?us-ascii?Q?dTxyIJsG/hJIhKmq0yiEGsK+Qhl1kYYN0KqsPsWUUyF2kWzvXOMLle5i6VAR?=
 =?us-ascii?Q?FOfsWPG7AJShjJUTrj6dxlyB1MDaHRODuB8cfn5NqxBzwmLy+b4F9qEcNZQ0?=
 =?us-ascii?Q?OhqaES3LYqqwHittS0Kv4iTm783l02HvHz2SufaA0u3hT4azdRF7hXgUQeT7?=
 =?us-ascii?Q?qeoGuoxa9lBShr0GB/8EcnV1SVMIrzi9HRN9fzvFdCy07/I1s7fYquqmI+xa?=
 =?us-ascii?Q?DEFJg0oJ381vLUMKgFiCmpUB9WhjKtLMu7THUHvWUPZRWsthJF97luRecqN2?=
 =?us-ascii?Q?UHjjW+NyG8B7+KEih0gXflA6eOV+GncjkqhJDfJuoH1qjKhWDIT+XmW0+PCG?=
 =?us-ascii?Q?Q7kL9asoM/QfLIxeRG1J9EVOB/D2F54Kbee5SnKDYH9E62gbAQLSH8Lyz+t/?=
 =?us-ascii?Q?aBFy+y1aHFaBHD+m6Qs+gsEOOkAd7pNigZS4iKirpioyIRP/JFWBxTeyhUaB?=
 =?us-ascii?Q?UvxmTRmv4gcCri/j4AaQg4ug0H51vcwst2d61vKS8nDyXSdLylxmLDz6ecwi?=
 =?us-ascii?Q?Tfte4GqVS88USogSvOQK68neLBXBv0o8wp7ykmpgBn9rQ2GYeskfnsd1RuAC?=
 =?us-ascii?Q?8/qrxObQWFS5FhPeXd/NG9gx1P9VylYUbzWj7rmmGs2P7pSRMewVKj2HEmud?=
 =?us-ascii?Q?Y3JDe7MST2EA8kiut97lE/C5nRa2zERJydeVFdwhKtS8HaLS8dkR7dhOkw9J?=
 =?us-ascii?Q?1MLwKfgt6n4aZp3G30K4abK2wffFuP0GF0RROGw0ABzAfZ5xyRwYPb3wpLdO?=
 =?us-ascii?Q?a2sxa5E0HR+Kb65jpn6QqXJOcICR/tTMDi1pvvtqmxdpTdxdQKNZnNrAn7Jt?=
 =?us-ascii?Q?Ff2kiFH+vt7e66o8d1avB+GU4MVqtCCqoUy18cpTabrGwREEZ7F0OCwlDNmc?=
 =?us-ascii?Q?9sBVUZxBuxPc1oLT1bpt/3SsvttK/xWnaJrosVLKVDqEuII9uLZrbP5Y5kUq?=
 =?us-ascii?Q?OiQX3dtaC1of967X8cg1w66Bzo661+PaUYfm7tgy3VCL8+QrAGB56gOmRY7s?=
 =?us-ascii?Q?tO3YIWuAWjoByOq9GCdn/hXLsMdDoBVggMhaEoaNaBLX20opHLreGUUjpEbX?=
 =?us-ascii?Q?C4S0KmogNTTZPSKDCAlryEROk1xeqMb/YeBuq5+p7O14JrqG6vBhkO6+9afN?=
 =?us-ascii?Q?Sidc2j2NyHtY/mqkc+6t5fS74qTZNiEoC9cVwQFN7ZQ2cVQpNvBFdf/kAve4?=
 =?us-ascii?Q?j8QNVpryp1FR7LmAu43qY6IpyChxc6zo45zJL5YpD9zdhpdJlSUz7FHzZs4B?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d84f33-71b8-478c-2922-08da558be05e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:47:28.0522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSxsa7jWik8Xf5Vb2aUKaMOmW6rV9hPARc/ok5JP8MeFCOSusuFC403uNCoJRuDgcLJoHZ7ewNp6dp6NSSYnhIxR85346KPdjuZR8j+iPco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2789
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

In preparation for a new cxl debugfs file, move 'cxl' directory
establishment and teardown to the core and let subsequent init routines
reference that setup.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h |    2 +-
 drivers/cxl/core/mbox.c |   10 +---------
 drivers/cxl/core/port.c |   13 +++++++++++--
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 47cf0c286fc3..c242fa02d5e8 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -24,9 +24,9 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_resource(struct cxl_endpoint_decoder *cxled);
 
+struct dentry *cxl_debugfs_create_dir(const char *dir);
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
-void cxl_mbox_exit(void);
 
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 3fe113dd21ad..dd438ca12dcd 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -855,19 +855,11 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_state_create, CXL);
 
-static struct dentry *cxl_debugfs;
-
 void __init cxl_mbox_init(void)
 {
 	struct dentry *mbox_debugfs;
 
-	cxl_debugfs = debugfs_create_dir("cxl", NULL);
-	mbox_debugfs = debugfs_create_dir("mbox", cxl_debugfs);
+	mbox_debugfs = cxl_debugfs_create_dir("mbox");
 	debugfs_create_bool("raw_allow_all", 0600, mbox_debugfs,
 			    &cxl_raw_allow_all);
 }
-
-void cxl_mbox_exit(void)
-{
-	debugfs_remove_recursive(cxl_debugfs);
-}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 08851357b364..f02b7470c20e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/workqueue.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -1695,10 +1696,19 @@ struct bus_type cxl_bus_type = {
 };
 EXPORT_SYMBOL_NS_GPL(cxl_bus_type, CXL);
 
+static struct dentry *cxl_debugfs;
+
+struct dentry *cxl_debugfs_create_dir(const char *dir)
+{
+	return debugfs_create_dir(dir, cxl_debugfs);
+}
+
 static __init int cxl_core_init(void)
 {
 	int rc;
 
+	cxl_debugfs = debugfs_create_dir("cxl", NULL);
+
 	cxl_mbox_init();
 
 	rc = cxl_memdev_init();
@@ -1721,7 +1731,6 @@ static __init int cxl_core_init(void)
 	destroy_workqueue(cxl_bus_wq);
 err_wq:
 	cxl_memdev_exit();
-	cxl_mbox_exit();
 	return rc;
 }
 
@@ -1730,7 +1739,7 @@ static void cxl_core_exit(void)
 	bus_unregister(&cxl_bus_type);
 	destroy_workqueue(cxl_bus_wq);
 	cxl_memdev_exit();
-	cxl_mbox_exit();
+	debugfs_remove_recursive(cxl_debugfs);
 }
 
 module_init(cxl_core_init);

