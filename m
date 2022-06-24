Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC954558D66
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiFXCqa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiFXCqa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:46:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAFA56C3A;
        Thu, 23 Jun 2022 19:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038788; x=1687574788;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OTdvADAgli1BCcsI3SQRCJAy3T6RLfLrSgdDO7VGMaY=;
  b=Nu2Q0CJUmorQesFsCxbbOBB68xfucfVwIHgiy0RMhFPUgI1r2J2gZjcw
   GpnnhQjCHO6gfyavr/2XdxBOPxG1uPrPejyf8m3N14yU/oapnMGLT11Tf
   rOfYId7oEYpzPUZhSxA/s9vliwAasXrIrsLDozbiR5VICjhd4VGI9MiqP
   zr7/m5CpiFroxkVDttcqItr7QcJM1bp06ix5Xq8ijdR/4gjnzGpu2Oi7c
   VMNB/eok2UQMlEvF+yecYOMaQBSfEUDZB1iWUBy2DpA32xE1Ct5vDtWWh
   U49aJaUeqQTs6DvS3w9WoLaHfuE2EZOo4K7M/gFSH7pJwwDneDGr4x2u0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="344898318"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="344898318"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:46:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="915490375"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jun 2022 19:46:27 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:46:26 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZxMgGHPpZ9iUn2hgOde8fD11H4kYqSwOCOIuRGjThycsI8doBDBgVzbQ3A4hT7Dfwnl/fmlLlcV5C68c5MuXOLEtdAGmPPyTBXRQ0SXaLqQaGiz2xK4Je89kMaTZ4WP8EXFHfQw6JX/+nUZvNuxhvvsEagouq5d+603pc4jf2qFeb9i0wuNSPp7NX29k+l2XQiC9uaStpuDGCHsIgugcbCscS/DarONzElatGajJVaEcFP/41hnYKWq4zDdG0mqKgfgb1K4CQOUEvHa/Belg80MOtHqRErOX/oT1wkeKv3clo4ZBtcqV7Qnr5cM7ozfodMdqBwxzmn24V/59OyUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC2Qoi7N3OOEJoSaxNFM90Jbrcnlkd7sm8X/nMPSbLw=;
 b=fC9ZlAgqLDSVLI7rZ57gCzyqz8uYSUAW8manme6ixDkiJ7B/RI+ZdxDslT8wyiCutV4WsWrDufoPEQ6fou9YfvdGVpJZvumwYRLZnYlYXK5O67hgr/MqBeLLUiIcnNveLct7hlPAPWPAVNFoFireO3IAx3B1uXzCeJrnVzn6xZljs7tTL43JPYmePg25lBOG2v8wqh07yWbtxdQjOaDyrvJGf83pBgCJLHTPudF+1Bc92w3PZMTyjpn9RIb019UtxE2LnqgTvcJOuSs7cBq+/0d+R8TmcrXX4UAuuKzfkTdKdq/9nAaSmuHuheEN6rH/eDsZbHGVoW0oBzuycKxBuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:46:24 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:46:24 +0000
Date:   Thu, 23 Jun 2022 19:46:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH 11/46] cxl/core: Define a 'struct cxl_endpoint_decoder' for
 tracking DPA resources
Message-ID: <165603878173.551046.17541236959392713646.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MWHPR18CA0062.namprd18.prod.outlook.com
 (2603:10b6:300:39::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9265494-8d81-4049-15cd-08da558bba37
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6bJjrOxghHesbI9slF8GIQrdKKIk3zyuMwd6/d3w8n6sleGMgp44OKGUzhgbvcIcZbESlP+OdgRR79wmNaULFlnG7M1IHDR+v6W4FCcYv+twUQnA//fSo5Hqqos4LxnuLAgOBMWmB60qyktkNUCNhL01m3/Y81O4vjOTEJNICfzKI3U0pO5Ngh1IJ845y5CZd+KOkUblYpakkm57ahCS1B7suzasF0BxIt4pwfG5t3PMYPsIrxHbhCg728UGZI5sPwL3t0Vnlo2Xof37AkN6K1SCMJ54fXTBXgypuSWQs8Lw44xmCTlVbkzAONBPMKK/WbiGLMuv8X9Kls3RNI/lUJrT1gZ3NYfslPzSoyJyG0aGsXAK3TPplluvudBnUHo6Fg/2zRctBVa1P+dI+DHcOFyQQDV6oIfgyXkYl7eYb1re8VBDjpTGeG+u5bgAeTw0SH+qpetiTVPsF5ZL7cJ8f+YxKKLet0MK/MSfGS9iYlhp8Rn9AK6V/YTKJzt8EQVf2S5sqgszmrHdR644O/0RAu5dGcRgqyxsGsO5geo/80BdQOGCN0BaHPlawSGh1lyWpKksWVjS5jaupXChHq/5OFFKu3ozNCYL6dUBW1kmRLNBpFiZqu+5Lf+936hrk2dnldhulFo7NvxLsBq01wuqDeP3BYEqFsn7bGc2PzqBG+/i3FBR6vW/uc/yUoZJNJG7eX6wDu+uAoGDKs/ZKPFpnJ2Fmvrn8dRP/wIdUN1CCi/6WlHQUl+JgHk4HCImbCsc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(6666004)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cmTvVb+KrI1nBHCfBScfwDFihqcaRM4tKVpzPnTTs1WiqWN2vH73ccHGFK9J?=
 =?us-ascii?Q?hauDMAnkP1jwyapd3Da+qOXEHXr9MnVrAmp2Lipho+2i8zV1CEMpCgEGxxZL?=
 =?us-ascii?Q?UzwdBaidJJfxAhUjGRnHRkBcRxiN2FaOjDqlg+gA0MjSxh8Yf8/elrz+UmBG?=
 =?us-ascii?Q?J6dOdNYACDhgECBFuOOSh58lHxO6cqYdhkicwjO+6pTHnIqNCcZ00pToF/hD?=
 =?us-ascii?Q?/4Ma0gpSZfnmnzVXEu+A6ox5p5gFswGkQ4N88oieZvb0aZ+kY7vX9fPNiT0y?=
 =?us-ascii?Q?4hgWZKoqZyU4b9NOMNJnJoad+noCDfeOSvbmJv724Jo9gohQa2Epm/dPZ1TK?=
 =?us-ascii?Q?PDVyglTneCUDEO9eFJEYLzsj/lbMx/MJhwguGz9OR/9mVaCs3GYvIWlAb/kO?=
 =?us-ascii?Q?w4aVVg9CqW3Qhns46JsWFEcYtJ7BgxVOnwsx6Nht21Lml8/mBQ5wS2vlzF1f?=
 =?us-ascii?Q?IvzzyoUyxwnu5b0rwozzplLiujFcEhzjoKg+QN/PXf2XGQK8Wz9PBzeKsP74?=
 =?us-ascii?Q?8Hnk9n3yFyzdfL1NpKMM6w/w+Vuyt/GaNXHl5KoljWxHi0djEo7eCPr0Vc58?=
 =?us-ascii?Q?nUgYlxR8tXeSwWdOsbegdOVGRZ+2/UMvBT7at0pt7JEN19pR/H/lH5Dgo0BJ?=
 =?us-ascii?Q?YCvfulmBVXh14ImQs8VQ0Ymzip5rd7JTMMvH2GOgLZV+P5lejLuLf/+Qmtn6?=
 =?us-ascii?Q?GrZxGc8orfduufrZEMHwx2Cvz7IHpFj6IVtRzllfjL2ixk2vo1foEM5tjBlU?=
 =?us-ascii?Q?9TPfyxu1vKhaAmnWjviFq1BQy77niIEQoEHRTgaC4JRqyfE+d0itrJKyLjva?=
 =?us-ascii?Q?yLqzM8Sb20687mQ1V6lF1oyK+LzfItd4aZehzSrmbGbal5ts6w7aAhRuAnEt?=
 =?us-ascii?Q?QFjdZTd3KFgrilL61GnitUhSFwssKBIalxqP1oV87Rl6EeH7XMYzsq4nsI4+?=
 =?us-ascii?Q?O4PxCNF+BmiE6WuSdoy/K6HI7jvFmEb2154sJ9hSmDv99iuVaJLAzdEnfic9?=
 =?us-ascii?Q?APD5vjHiBN+MPxgW1VFtySXoaHEsf6ppjgoo/pwg1RrFegQulnaF6PPLmI8h?=
 =?us-ascii?Q?FWsaRSoPhpYcOW/TtYu8mrypSBSyvlJurlDRYLKX5519q5XWSzWyVLksn6GU?=
 =?us-ascii?Q?sv1JCOq7HrEP25N6iknLB6um08i2ufqmZCGRxab6Kry2YTrXp4RTVwYUzalw?=
 =?us-ascii?Q?vIK+KERb61e2IS0buQXlTK4CZRe6Uyi8mX3BeP7++GHgBM8kIIQ03qcUZ3H5?=
 =?us-ascii?Q?CEgtl/Oba6/EQu3S6mWwzwxU4Gc1+MGM+5A4tvMvX/tLhZINf+unJuidMWmn?=
 =?us-ascii?Q?oLMFngPvDY1gFL2P4XGjHtctjv+iB7duZwtKNCdYrImESC1k3Esijm6qDjtO?=
 =?us-ascii?Q?mNLueIXOeVPDqb5POwzkVMNgjiuQQh8fWlhh+p1XqWzfemRlu0XLSYL56twn?=
 =?us-ascii?Q?VQ4HPxy1qQWaw/06hdgpcRS2KWFoTDm7IFUVTq8HZk1R8tCUulxfnK0PB3LI?=
 =?us-ascii?Q?tM5w7xirKnca7T4ge5eyLAFWkaqBQhmPC5pa4Z2f6lldkWmy6v5HKazRmxJQ?=
 =?us-ascii?Q?uV+sgZ3N27rlloYwJOPCnYXTJgIYytZB0cdz4LnriSVcC50iLuj5TyoF+aE8?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9265494-8d81-4049-15cd-08da558bba37
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:46:24.0896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2ZoQcP0ysFFuId82FvRt2D8JCJMvk5s0jbbb6tF5wO6e6pwTlT57+AXcQaz9tR2nc6LrADCg5Eyfh3YCVzHX6AjuNDCwm419s4bcEUeY1E=
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

Previously the target routing specifics of switch decoders and platfom
CXL window resource tracking of root decoders were factored out of
'struct cxl_decoder'. While switch decoders translate from SPA to
downstream ports, endpoint decoders translate from SPA to DPA.

This patch, 3 of 3, adds a 'struct cxl_endpoint_decoder' that tracks an
endpoint-specific Device Physical Address (DPA) resource. For now this
just defines ->dpa_res, a follow-on patch will handle requesting DPA
resource ranges from a device-DPA resource tree.

Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c       |   12 +++++++++---
 drivers/cxl/core/port.c      |   36 +++++++++++++++++++++++++++---------
 drivers/cxl/cxl.h            |   15 ++++++++++++++-
 tools/testing/cxl/test/cxl.c |   11 +++++++++--
 4 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 2d1f3e6eebea..2223d151b61b 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -224,9 +224,15 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 		int rc, target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
 
-		if (is_cxl_endpoint(port))
-			cxld = cxl_endpoint_decoder_alloc(port);
-		else {
+		if (is_cxl_endpoint(port)) {
+			struct cxl_endpoint_decoder *cxled;
+
+			cxled = cxl_endpoint_decoder_alloc(port);
+			if (IS_ERR(cxled))
+				cxld = ERR_CAST(cxled);
+			else
+				cxld = &cxled->cxld;
+		} else {
 			struct cxl_switch_decoder *cxlsd;
 
 			cxlsd = cxl_switch_decoder_alloc(port, target_count);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index abf3455c4eff..b5f5fb9aa4b7 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -243,12 +243,12 @@ static void __cxl_decoder_release(struct cxl_decoder *cxld)
 	put_device(&port->dev);
 }
 
-static void cxl_decoder_release(struct device *dev)
+static void cxl_endpoint_decoder_release(struct device *dev)
 {
-	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
 
-	__cxl_decoder_release(cxld);
-	kfree(cxld);
+	__cxl_decoder_release(&cxled->cxld);
+	kfree(cxled);
 }
 
 static void cxl_switch_decoder_release(struct device *dev)
@@ -278,7 +278,7 @@ static void cxl_root_decoder_release(struct device *dev)
 
 static const struct device_type cxl_decoder_endpoint_type = {
 	.name = "cxl_decoder_endpoint",
-	.release = cxl_decoder_release,
+	.release = cxl_endpoint_decoder_release,
 	.groups = cxl_decoder_endpoint_attribute_groups,
 };
 
@@ -320,6 +320,15 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_decoder, CXL);
 
+struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, !is_endpoint_decoder(dev),
+			  "not a cxl_endpoint_decoder device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_endpoint_decoder, cxld.dev);
+}
+EXPORT_SYMBOL_NS_GPL(to_cxl_endpoint_decoder, CXL);
+
 static struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, !is_switch_decoder(dev),
@@ -1258,8 +1267,12 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 			cxld = &cxlsd->cxld;
 		}
 	} else {
-		alloc = kzalloc(sizeof(*cxld), GFP_KERNEL);
-		cxld = alloc;
+		struct cxl_endpoint_decoder *cxled;
+
+		alloc = kzalloc(sizeof(*cxled), GFP_KERNEL);
+		cxled = alloc;
+		if (cxled)
+			cxld = &cxled->cxld;
 	}
 	if (!alloc)
 		return ERR_PTR(-ENOMEM);
@@ -1357,12 +1370,17 @@ EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
  *
  * Return: A new cxl decoder to be registered by cxl_decoder_add()
  */
-struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
+struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
 {
+	struct cxl_decoder *cxld;
+
 	if (!is_cxl_endpoint(port))
 		return ERR_PTR(-EINVAL);
 
-	return cxl_decoder_alloc(port, 0);
+	cxld = cxl_decoder_alloc(port, 0);
+	if (IS_ERR(cxld))
+		return ERR_CAST(cxld);
+	return to_cxl_endpoint_decoder(&cxld->dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_alloc, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6dd1e4c57a67..579f2d802396 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -239,6 +239,18 @@ struct cxl_decoder {
 	unsigned long flags;
 };
 
+/**
+ * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
+ * @cxld: base cxl_decoder_object
+ * @dpa_res: actively claimed DPA span of this decoder
+ * @skip: offset into @dpa_res where @cxld.hpa_range maps
+ */
+struct cxl_endpoint_decoder {
+	struct cxl_decoder cxld;
+	struct resource *dpa_res;
+	resource_size_t skip;
+};
+
 /**
  * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
  * @cxld: base cxl_decoder object
@@ -379,6 +391,7 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
+struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
@@ -386,7 +399,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 						    unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
-struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
+struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
 int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 68288354b419..f52a5dd69d36 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -459,8 +459,15 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 				cxld = ERR_CAST(cxlsd);
 			else
 				cxld = &cxlsd->cxld;
-		} else
-			cxld = cxl_endpoint_decoder_alloc(port);
+		} else {
+			struct cxl_endpoint_decoder *cxled;
+
+			cxled = cxl_endpoint_decoder_alloc(port);
+			if (IS_ERR(cxled))
+				cxld = ERR_CAST(cxled);
+			else
+				cxld = &cxled->cxld;
+		}
 		if (IS_ERR(cxld)) {
 			dev_warn(&port->dev,
 				 "Failed to allocate the decoder\n");

