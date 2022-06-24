Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E59558D78
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiFXCrt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiFXCrs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:47:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454EF56F8B;
        Thu, 23 Jun 2022 19:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038867; x=1687574867;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FC7St/lzkdMuDic+8vrLhdoz+08wwrk0a5ucHr2l22Y=;
  b=U0As67vDFPXiiVOKEjnwe+H4NWpTjETdrOPTIVZphZ8VfcLMTXxL/J6p
   etiuNCoe5Ch1T4ybeJQc+fqpEhr+c5wGzJSetBQOQppv0Rwyc9hjnJduU
   Zx26i+lRp6SGK6IWfithYKgjQIIdnwBY4OKwndT5YNJGKywzcY7uZgDKJ
   U4XReBmI3Rd5ZNX3LWCgKBU0VL0+F84+G6YsZLzU1sybb1T7/Dn43XUQd
   Q940MDHp1VucJJGTeFgj1Gpbt3vIO0CeFSvx1/J0E/KjkDJpLeV74K7i9
   LxnSfPRUdw+Xh8+8lEqPwycw8HOS1htnHondzMT7xKD/0EWml3gB9OqL4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="269632710"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="269632710"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:47:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="731139510"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jun 2022 19:47:46 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:46 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:47:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7hgnP6ZV3RWtm+HuSlG/wXLnxbMT90jouyEujYxi2Wuntq/PNVhH4QR8Z7vEuHlHVwjTxZ4e+1+byu6LK0dZX2wnPERRBrFR9MDuNBp8HtnGxgYjJBNzVWBOEk8W08D9DJfoigp3asiz4QV4qcPc+7+9xUH/vBHVZi8diPya5Ty7Lu5pTufVvfmVJ0BJrhHo+XNQuZm20huM/9E/+WuB4UTL1993i/47Vx8ckbtZhwl30WioF386SLjFq+40m3+PgOKXFhpTaN1slUEiLZuo7PZc+DnTsHoyvIuP1FmwTw7T/7L1/TqiPRFulkp57FyboXFjsejqWph3+fXc9W9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg72d2SkksWGZ/kPLlc5QQFLoWUWatgWr+5oJdEXL6I=;
 b=fn50S8hD/R3KdKF83BxOyKtsD3Z62KnUG83839lefOzue/90exzV4wnYfu+noXgm4Lvl0AVQFe8UmxSoFPoP7yK5GK/Gri8lQIc4bdcVvPUUiY4P+apoMgFidaWSF1Gup4lvLbPbUp40ZMvVixrBlr+KgkF1NfbCDLIkzwNa1ffe2SrBvXJNZfn5GFN/hy4HK4UvncY6iIG/VNFrf93wVkI4JUCyE89/W6B5cP31pTxPuWH7kXa3fbvDf3B6XU/35iU7aAZabbazTY8/a7EKuW85NGZO3YhjcEXK+/PplayuWX10wvGM44K3I4sD+5bH7sek8q5gpsr53KUO2W6neA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB1876.namprd11.prod.outlook.com
 (2603:10b6:404:ff::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 02:47:43 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:47:43 +0000
Date:   Thu, 23 Jun 2022 19:47:33 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 20/46] cxl/mem: Add a debugfs version of 'iomem' for DPA,
 'dpamem'
Message-ID: <165603885318.551046.8308248564880066726.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MWHPR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:300:ee::19) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c69707c-62a1-4240-2c81-08da558be48a
X-MS-TrafficTypeDiagnostic: BN6PR11MB1876:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76xdJBiF4O5MKIIfpyUIlZ7fN+F2T2l5RPhoXUNYp90Wu92i+NH3+T/FANAYdAPieUTSUiNDYQd+MXVnWEeAYk2k0Hu10/glKqRxlMCBUIWNwXTaGTCiFkjDWyc0ltZ+eeW9e54vYJQNHvtXqEuG84zE5NEebuTB+CUSDk+4yosqlUUdcsClK4L0XbFDciBrt8YbMMrKyv0HtSskODr0QiO6gmuJxzTIsw1SK4bbbilgv2OdD9YlsUdlcxFoOMXA80EdU60tvkS2XWaz7Y9Ai8/+1YbAcfHBFbvRBGDus+Kq+HZ4XHHICP/hJQ1GwVQdImGockiTdJ9s2YAnHtcSrJ7u28mewlIkZGkhVDzfiOUO2rd/PfHEyV+wpptSbohBDGF//Eshv5bKkCOLEmOGtc3rrahph1EDW7s5BDRHAd7Aejvw2ZCsoMlXr+25W8W08aX9+tCiAyfoLr72ydhyVqmSFokcjGYIKuiZdVCWGxwPvfjVdqeBlMyF4ZUJq8AfL/OtkNSXqVlQ5I4LN2/Wv4qhjPiJYoOd8vquf0wdxjmN65hRfLsY259T56nyTIC0FTyZMCbsAH+DpwgtqPG49Gs9t1W1Y+9WyEJKuR0S3FaiJSRnOKP7RvZoLFNlS6Jdub7wb8YzKNkedmqjSb2o2dLJs4XDJ8iiA6CZVavloxfCzbZMfwu7+NCKU3TH5ca6GKDoqv/8SzIFxZe1AJoVatgnYvkOk5x0iKoABvH7l93YHisEymNFn9jEcC0EOZ6k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(376002)(136003)(396003)(366004)(103116003)(9686003)(6916009)(316002)(5660300002)(6666004)(66476007)(2906002)(86362001)(41300700001)(26005)(82960400001)(6486002)(6512007)(478600001)(66556008)(38100700002)(83380400001)(6506007)(186003)(4326008)(66946007)(33716001)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BMCuDu5ttKPsXkipq1VyWTE0wJUBxHn0QtK+be8DnI14ve4DEYGBG4GQRXGL?=
 =?us-ascii?Q?AqXksKqt70GaMiVbZFfnNC2DtTQlSVj91gaMhe01cU1GaEOhsuxkrCdkFjju?=
 =?us-ascii?Q?uW8PuNpkY7XZk5josvbUeovWfDYIPUPWXWy6hkFpPeWWiP7wq0r6ag+5+ozA?=
 =?us-ascii?Q?YUFnAezkiAU7SBytfWtOPi/hqyTUnObbXTOO23v4kZm+fY0iMIGit9ipm5SS?=
 =?us-ascii?Q?gGFAmO2HDzJ7S4fpOwN2lPsV+0n7NQKGrhyQ7D0Y/YeadpO0MLXxkJpS69EN?=
 =?us-ascii?Q?7fEnoqVpPupvZZMgMwMevVjH0GvMNocCXJCpVOxVidmqOlwNAYYLvSp4L37W?=
 =?us-ascii?Q?0619bgi+l11bx7lsqvy5o/XXa7HlGck6FiY/CKUDmGYr38momxd4Hy3bNhvX?=
 =?us-ascii?Q?l5MaeeZZwmAWNB654VHGSgY996+KLMFsy9hvJQdJItDQ8vk6O4MyYn8uedgm?=
 =?us-ascii?Q?ZM5wZxllpB3nzmiJE2AUnTq1yEhc7O1g9lFeF+gI1RnYNUgLu+A3so662uy+?=
 =?us-ascii?Q?d4/vZmlBzMDUq13iwT41d+XfWNVPu4mAmaileydqvy6alpEClNCQoYjeS0ru?=
 =?us-ascii?Q?0KNGTg7p3KKhDIpy/DFE6tGcSGMjkCiL/4EVjCKzTCF7+EaaNZav04VNAZzN?=
 =?us-ascii?Q?SL8+ZgNuEb9/98mdvjSEUEVX3jEYWWUGm+653y6ZfgbHD8gTTrIwThPdyXyQ?=
 =?us-ascii?Q?qA+j/tc2bhViWXSdE5uHY6XMsssdgBd8gFS/Zsz1MCa+US+2/wlu9Jx/aFtN?=
 =?us-ascii?Q?Rt1YFDw7KeKU9TzCRra851qqHbPq8rQHlJPkBsPDt/hPztvvj6tvbCveXXdU?=
 =?us-ascii?Q?BIcNVB6+nYxz+JzYtrNNgy422UQDHnbkY+jYM7Y7At73YKqxNQkAde+cPG5Y?=
 =?us-ascii?Q?hebxA+cuqwFu7/2cUmosaWu944NlTM8h77E9PNzBzoqdN2hA4Smba+yJgbQQ?=
 =?us-ascii?Q?fhF8jfvov7x4/iJEPZonQFYrZvyp9/0W4d6DDrhDuhT3dGptaE0wQ/VyklP0?=
 =?us-ascii?Q?l2a2jnOsi8iR+vJWpnVki4W78Zqx+stztIurgSiK7Ny8E25621d7M8Get1L4?=
 =?us-ascii?Q?HIVG/UR9XMnyOg8u56jR5Nb01sldSbARBUC7D13hArYLd5mFqaQKkWBi/zU6?=
 =?us-ascii?Q?hIFYch009XOBuPt0k73e5BkD9v9LmliUQJ8xFTMxEApnFQPw/eKoHeuXq3my?=
 =?us-ascii?Q?283AuQ1F+txbQUBdEVg2pXbZ1xFyGv3OSkn3+8dsqVziDcblM1TSjXiRY1ir?=
 =?us-ascii?Q?uiblRiFMSuFnVXBh+XQua/1srQuJfZKscW0aH0KFtmDhel1w+B0v1HIJMBXy?=
 =?us-ascii?Q?TFOdB/tNZLYO4IeaVCriHeBNDYNk60mdnF9DvMeg6x0Phsd9YdsSYZLW6TZ0?=
 =?us-ascii?Q?t3OC3yYj6b/UDP8/sQKRO6eAfX17RbK29HgzyJb033pjHCND0TyBnSrI388Z?=
 =?us-ascii?Q?ShZ2jLsK7oyuAJoc/3gPOafGx7ii61emxtLmUaq0tFOTWsEqqljZYENWB9gC?=
 =?us-ascii?Q?Cbm7ZmUl05PCTgCnNzPVkiwteQ3iuLne/9sZljJgnUI76hYxPJvzc+UOu418?=
 =?us-ascii?Q?E3BJo5aIXRE/+pesJBDgeT3Q6l0KOKTN0k31eaLmsCH/ju7kPV6r7Z4tMDRP?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c69707c-62a1-4240-2c81-08da558be48a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:47:35.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IRBp5oUsedigm7b9i5Il/Hbc/z8ljgyW1JmlEdTTFPGK8jI50UsaWOCywihxrIM0Ph/wuHCMf6oknYio7D+n/5Je0fdkqxeosx/rYF51YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1876
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

Dump the device-physial-address map for a CXL expander in /proc/iomem
style format. E.g.:

  cat /sys/kernel/debug/cxl/mem1/dpamem
  00000000-0fffffff : ram
  10000000-1fffffff : pmem

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h |    1 -
 drivers/cxl/core/hdm.c  |   23 +++++++++++++++++++++++
 drivers/cxl/core/port.c |    1 +
 drivers/cxl/cxlmem.h    |    4 ++++
 drivers/cxl/mem.c       |   23 +++++++++++++++++++++++
 5 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index c242fa02d5e8..472ec9cb1018 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -24,7 +24,6 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_resource(struct cxl_endpoint_decoder *cxled);
 
-struct dentry *cxl_debugfs_create_dir(const char *dir);
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ceb4c28abc1b..c0164f9b2195 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 #include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 
@@ -248,6 +249,28 @@ static int cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+static void __cxl_dpa_debug(struct seq_file *file, struct resource *r, int depth)
+{
+	unsigned long long start = r->start, end = r->end;
+
+	seq_printf(file, "%*s%08llx-%08llx : %s\n", depth * 2, "", start, end,
+		   r->name);
+}
+
+void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
+{
+	struct resource *p1, *p2;
+
+	down_read(&cxl_dpa_rwsem);
+	for (p1 = cxlds->dpa_res.child; p1; p1 = p1->sibling) {
+		__cxl_dpa_debug(file, p1, 0);
+		for (p2 = p1->child; p2; p2 = p2->sibling)
+			__cxl_dpa_debug(file, p2, 1);
+	}
+	up_read(&cxl_dpa_rwsem);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, CXL);
+
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
 {
 	resource_size_t size = 0;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f02b7470c20e..4e4e26ca507c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1702,6 +1702,7 @@ struct dentry *cxl_debugfs_create_dir(const char *dir)
 {
 	return debugfs_create_dir(dir, cxl_debugfs);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_debugfs_create_dir, CXL);
 
 static __init int cxl_core_init(void)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index b4e5ed9eabc9..db9c889f42ab 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -385,4 +385,8 @@ struct cxl_hdm {
 	unsigned int interleave_mask;
 	struct cxl_port *port;
 };
+
+struct seq_file;
+struct dentry *cxl_debugfs_create_dir(const char *dir);
+void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index a979d0b484d5..7513bea55145 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -56,10 +57,26 @@ static void enable_suspend(void *data)
 	cxl_mem_active_dec();
 }
 
+static void remove_debugfs(void *dentry)
+{
+	debugfs_remove_recursive(dentry);
+}
+
+static int cxl_mem_dpa_show(struct seq_file *file, void *data)
+{
+	struct device *dev = file->private;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+
+	cxl_dpa_debug(file, cxlmd->cxlds);
+
+	return 0;
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_port *parent_port;
+	struct dentry *dentry;
 	int rc;
 
 	/*
@@ -73,6 +90,12 @@ static int cxl_mem_probe(struct device *dev)
 	if (work_pending(&cxlmd->detach_work))
 		return -EBUSY;
 
+	dentry = cxl_debugfs_create_dir(dev_name(dev));
+	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
+	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
+	if (rc)
+		return rc;
+
 	rc = devm_cxl_enumerate_ports(cxlmd);
 	if (rc)
 		return rc;

