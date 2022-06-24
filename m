Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4037558D5C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiFXCqA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiFXCp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:45:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B69956C14;
        Thu, 23 Jun 2022 19:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038757; x=1687574757;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lztxfZRTkw+tYTGW2KFzc8KV1gc8+a1gWX+htcS2Qiw=;
  b=CnnpkyOD5NKKetaLLFXKLt0NvTHAL1K9Pdya4Gij/nvHsvln/kFoHqQx
   iEX+zMmdoF9kOUwELHHTscinL04j9YHuCJ+8qvn8hmMfTrNtfIFAB13Zq
   C0dhIn++vzK5WvMuA52dmjKen/14I9aJQOrIvC2mN5rFuvHAzKj2Yv0+J
   kDA8SzFyIrC98dgYaYm1aUyrK9vc+q8eA5nE/VBUvM0QNU8FXTPo/KO2y
   OzQenKbwf3qagBiiW/F6E9/Xsp9cMqEXXaVeFGtyAONBa4MlOpii/UzRY
   Tn+ozrj3umUVEizUyQmQsMCcUMxI6fGIXKg3LeLfWB59wysgg1tdnmWG2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="278453277"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="278453277"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:45:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="834933361"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 19:45:42 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:40 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:45:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfY4AkuOpHPSFp54Yip3gvGpt5xlV4Dl847O9k1JAYjkUrYJ24+RrVPNNegFW1VdkiVZPUNoxYUROLTikqiqBo16b8YVYzdN/ZOdeDkJalTzCfrup23hYB/u9j2sZ2FinuByP4Gx2p6fcsT0pPaMkg9blfbXTz3BJWVcPBTPnIMZVzQYjZtbFgifJc0feo3W+e350wwxY+86/0TLSzFWLP6+cm3WvdpDL8GaeeR34q21kBCNspIm7RgtfPpthyCb6cCjilf4fjomRhVfDpcBEWdcFEvnyAFjoOOrc/qTG1yMhEAD+Ayzf7hwLaJh4DY+LldkdPvcoePmrC1Pe07t+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv2ThpJpK6my0vRxdEoVQSo2pTugOm4681/Sov4BhA0=;
 b=C0JtzEPf1NUDI/4ufMlvdYaxijIHTYhUAB6rZ4Dwurlnzq/L8vog/aGiuhyHGZZAv0ulmG02ZgISktzku1mJ/uk6RAKuL98s9Wqk804lFb+DsyG87s7Y3yVnx2hDmHOUb/Ow6PHBIeeCL01NhJLVTYdsS2T4JlUiZ3RQpICE+Wcioy51fNXBzwzo7X36witlHOcUOhb9OPPWAa36kYFff4dRuXgLsl/uw2Z2rbvmdF8UqPUoakCNXe7o5x9tDJ5HMoXlTSDKPNnJ6PHf0Zs/8ZVaiRY4K14Ogu358UrJshZ9mjJL4mLZggtRG7pFxWtRZZq6Jg23ZVkx5RF8rdLJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:45:38 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:45:38 +0000
Date:   Thu, 23 Jun 2022 19:45:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 05/46] cxl/core: Drop ->platform_res attribute for root
 decoders
Message-ID: <165603873619.551046.791596854070136223.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MWHPR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:300:95::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f70cf0dd-f95f-4af2-b455-08da558b9eeb
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tItsLBLc+betbxo5O4s7pEJa0Pau7COFu2+nE5YiTV1S/nUIaK7gMDn4Qdrq+l3ubxUjmwDLyD69cQzTv33GRn9klY2ZC83fHa8tBhf60hWOXQltScz6dNZf6dTaoLETL+iz91gCO5RDZPe0RWCb29aZjq/LNcMY3TaVJvmSwiqojllpMseEmtM5CiXf5HaYR3fzDsZbyUfprDZ2TlI3oysyfhWMd3vFjknoTnRwsL2C0/WV9i7j0Rr+lRJEsyseyb4FwTDIHX2+wn9btlneTuLR8m69PJWXMiQiff+ygCK4b2vbpM4msLsIQZgeHWrxUwTTB6WHSTJrnGxIWc9IpeXTpEnOu6itk5X9w4OluGLmxolNUMEi/t9uxXCxhpnfZD2nx2dSi5sHrA3w6yZrqUSTpXKBOGOyec7fWhXI3WRpzVvAzPIDiAwQCYChvlJKc0HsSWy6jEDusyTvjr10wTWRvZABhOJe8MEZYwfw7qmjEpB+yX8ecAalccYAbyusqyjML+lTLB93Acu7dunidnvf12LXgvHJ6bwPMQtWcLePmhCzrNiKyFc5mUnUpbbJBt6dQ5vI79dr9GJ3IUUKeBWq+nKicODmPhEsGzXF9bEcRpmmNeB2qWqVQWisB427bjEvgnZ+Ev/GSvXybbVKClE1tEkqeMwUH5gnbVHH+AV+FH4Hy4X3E7HuAmOMlMQOjRKdhIKV+FZgJl0qttFrmuZaGbIzP10C84ezP8kbgtWbhQfm2vwemJZmNDqhh5e9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b9Qd/yzko9gooImQS9x0PySU6HBUYCHs8yxkXiU419ztsAaWreYoMOBeJVSH?=
 =?us-ascii?Q?QvTxIt1oFFNriD0C4rTG8KIQd4SIy8gpG4kx3BUCCh+GanB8JlpZkfkbX9ld?=
 =?us-ascii?Q?RQthwq5p8sCPFBtGVrDNou2sxiE1hHcumLPcKEjrDW8ZGGskMFscYyHdAwNG?=
 =?us-ascii?Q?CnqOKzcs+X4y1hftOrsP5lPNrOl7C9q4SYWRwQXaH8uYEp5sLk8NMwS7f+4f?=
 =?us-ascii?Q?Qj2SWvhXU451iJV7xQoXcmb3akTJMRo7YgvlVUQ2+Z2PTYdElFRKABaUfsyV?=
 =?us-ascii?Q?7SIh/nnP1tmkXKK4/+1MDLNfHhFntZbK+WlDVcMlQhQUITqmfxK4wjnXHPqO?=
 =?us-ascii?Q?ldTGE4L1+vrYbxleL1ZXvf5p8xj2m1gR41OdmZbj7dcUapa0sppo+gP1dw4P?=
 =?us-ascii?Q?UNjIRrhUasbrsP0dASNVCtAjCK0RNnvxCih/1KqRXkL6ivGRoC3+Rs/iSPzc?=
 =?us-ascii?Q?qDJeYCYufhu5X9CGg859LfasBjE7ubc4e1AStkwUB282kL41n06Owl9L2FN0?=
 =?us-ascii?Q?xsKjEIej8aIn2Kt/aYgTPj06I4zP6O7RpCWZIrX+udKfJuz3gavWyz7pIe6w?=
 =?us-ascii?Q?qLicdjuveFMkk3ccD6+ksdo0XugwI0xjVhK2KFM9I+uyN+zA/BqL44U6lW+0?=
 =?us-ascii?Q?InheKAM0pV2+JDIktJkm4W0Na4Yyr0GSua0Sp5DcxPUthhj/OxUaVYeZ7nEP?=
 =?us-ascii?Q?9V9XXALssVhmznJAMpkCqLYgEIFq8wLhHDmC8ZPdnEwJFjxFWCy/wCG3pfq3?=
 =?us-ascii?Q?4FpU9L1GK3GlK+3zqryLHlMfo2YwJycgxB0diMsl1k3QiTayDKDzc4rsOjjK?=
 =?us-ascii?Q?2CQ+RBbS4+WKxOaRaJmYBNFS+Ql0ajpIwTdVc4ltR8GWmSyyvgUlQ+3SwYR1?=
 =?us-ascii?Q?jRRvDl7LEkBfrf7SXxaqXckjliL5NqTlOWTLK99WtmPE9jNadONnRi7HIHRj?=
 =?us-ascii?Q?VILWYT1p/5YZp2XQzoYLW/gHQFOl0LdcI0bBuMRgr/a3CPyHbev5rGo55iy3?=
 =?us-ascii?Q?mEyUfan8umFuTBb8dzmdaQDQWiR4avncfFU8wcRGL88lqjY1bQZt7j42oVLy?=
 =?us-ascii?Q?nPpswOJm7XFxAJ1FFUwH0bcuWXBZXnxzOOXHDamE5QwK5FV1TU7ht5QbiZeT?=
 =?us-ascii?Q?pyqb7sm1MURef5U0rnjxAWFnOe5OPfTYsFL3bus0CdaPab/zxFRymc4SSIEJ?=
 =?us-ascii?Q?iLv0EVq+aIS/E5PZOhpVKh1t+O3XB0VdnRPESfEO79NUFnRO7Sm/0UO+KAeF?=
 =?us-ascii?Q?yU2z7I6BZ0CWhQQJII+znOF8t0pKQ8UX+G1SMSR9jL1RYK4rQaAmlyOE9O+3?=
 =?us-ascii?Q?i3MRrkQRqeexm23xWpr672rvWnXfWUPMxwp5/OBdTIj7F1B6iVD7bI1vBMaP?=
 =?us-ascii?Q?ky66p+9T4vo49kIeNvwhbNwAYaQib3k2w285U5ZWI0qNltg8AChJhRxc6yHe?=
 =?us-ascii?Q?p23FsxKlRkXw/74utaAFcM3LURdcrBpnYDjhY3tDhyMPnJRNXdEwUH3Nmeg3?=
 =?us-ascii?Q?GjGrBuf6PXu0f2r2RvOyQK5wavJr0XlGJdzqJW2EVWq+g+dwp1B1YpifWGek?=
 =?us-ascii?Q?DikpseRwEzG0GvhtvKS3ShTPbcs76r8XwTlKv5c/DzhuBHHE908lG2r/SMuL?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f70cf0dd-f95f-4af2-b455-08da558b9eeb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:45:38.2971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PMz2y08d0h2X66wYTC26RauMrwdQyWj0Htfga01jeV14HYyFPtPJkdkpuNdDvM1NrYVYH8znBVIUTGavr0ckJ1Di7Nd3G9CggnHA02jkYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Root decoders are responsible for hosting the available host address
space for endpoints and regions to claim. The tracking of that available
capacity can be done in iomem_resource directly. As a result, root
decoders no longer need to host their own resource tree. The
current ->platform_res attribute was added prematurely.

Otherwise, ->hpa_range fills the role of conveying the current decode
range of the decoder.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c      |   17 ++++++++++-------
 drivers/cxl/core/pci.c  |    8 +-------
 drivers/cxl/core/port.c |   30 +++++++-----------------------
 drivers/cxl/cxl.h       |    6 +-----
 4 files changed, 19 insertions(+), 42 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 40286f5df812..951695cdb455 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -108,8 +108,10 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
 	cxld->target_type = CXL_DECODER_EXPANDER;
-	cxld->platform_res = (struct resource)DEFINE_RES_MEM(cfmws->base_hpa,
-							     cfmws->window_size);
+	cxld->hpa_range = (struct range) {
+		.start = cfmws->base_hpa,
+		.end = cfmws->base_hpa + cfmws->window_size - 1,
+	};
 	cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
 	cxld->interleave_granularity = CFMWS_INTERLEAVE_GRANULARITY(cfmws);
 
@@ -119,13 +121,14 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	else
 		rc = cxl_decoder_autoremove(dev, cxld);
 	if (rc) {
-		dev_err(dev, "Failed to add decoder for %pr\n",
-			&cxld->platform_res);
+		dev_err(dev, "Failed to add decoder for [%#llx - %#llx]\n",
+			cxld->hpa_range.start, cxld->hpa_range.end);
 		return 0;
 	}
-	dev_dbg(dev, "add: %s node: %d range %pr\n", dev_name(&cxld->dev),
-		phys_to_target_node(cxld->platform_res.start),
-		&cxld->platform_res);
+	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
+		dev_name(&cxld->dev),
+		phys_to_target_node(cxld->hpa_range.start),
+		cxld->hpa_range.start, cxld->hpa_range.end);
 
 	return 0;
 }
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c4c99ff7b55e..7672789c3225 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -225,7 +225,6 @@ static int dvsec_range_allowed(struct device *dev, void *arg)
 {
 	struct range *dev_range = arg;
 	struct cxl_decoder *cxld;
-	struct range root_range;
 
 	if (!is_root_decoder(dev))
 		return 0;
@@ -237,12 +236,7 @@ static int dvsec_range_allowed(struct device *dev, void *arg)
 	if (!(cxld->flags & CXL_DECODER_F_RAM))
 		return 0;
 
-	root_range = (struct range) {
-		.start = cxld->platform_res.start,
-		.end = cxld->platform_res.end,
-	};
-
-	return range_contains(&root_range, dev_range);
+	return range_contains(&cxld->hpa_range, dev_range);
 }
 
 static void disable_hdm(void *_cxlhdm)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 98bcbbd59a75..b51eb41aa839 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -73,29 +73,17 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
-	u64 start;
 
-	if (is_root_decoder(dev))
-		start = cxld->platform_res.start;
-	else
-		start = cxld->hpa_range.start;
-
-	return sysfs_emit(buf, "%#llx\n", start);
+	return sysfs_emit(buf, "%#llx\n", cxld->hpa_range.start);
 }
 static DEVICE_ATTR_ADMIN_RO(start);
 
 static ssize_t size_show(struct device *dev, struct device_attribute *attr,
-			char *buf)
+			 char *buf)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
-	u64 size;
-
-	if (is_root_decoder(dev))
-		size = resource_size(&cxld->platform_res);
-	else
-		size = range_len(&cxld->hpa_range);
 
-	return sysfs_emit(buf, "%#llx\n", size);
+	return sysfs_emit(buf, "%#llx\n", range_len(&cxld->hpa_range));
 }
 static DEVICE_ATTR_RO(size);
 
@@ -1233,7 +1221,10 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	cxld->interleave_ways = 1;
 	cxld->interleave_granularity = PAGE_SIZE;
 	cxld->target_type = CXL_DECODER_EXPANDER;
-	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
+	cxld->hpa_range = (struct range) {
+		.start = 0,
+		.end = -1,
+	};
 
 	return cxld;
 err:
@@ -1347,13 +1338,6 @@ int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
 	if (rc)
 		return rc;
 
-	/*
-	 * Platform decoder resources should show up with a reasonable name. All
-	 * other resources are just sub ranges within the main decoder resource.
-	 */
-	if (is_root_decoder(dev))
-		cxld->platform_res.name = dev_name(dev);
-
 	return device_add(dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_add_locked, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 8256728cea8d..35ce17872fc1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -197,7 +197,6 @@ enum cxl_decoder_type {
  * struct cxl_decoder - CXL address range decode configuration
  * @dev: this decoder's device
  * @id: kernel device name id
- * @platform_res: address space resources considered by root decoder
  * @hpa_range: Host physical address range mapped by this decoder
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
@@ -210,10 +209,7 @@ enum cxl_decoder_type {
 struct cxl_decoder {
 	struct device dev;
 	int id;
-	union {
-		struct resource platform_res;
-		struct range hpa_range;
-	};
+	struct range hpa_range;
 	int interleave_ways;
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;

