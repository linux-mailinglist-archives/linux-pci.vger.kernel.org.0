Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A346F558D68
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiFXCqj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiFXCqi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:46:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A5F56C31;
        Thu, 23 Jun 2022 19:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038797; x=1687574797;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wmpgh9AjslF4pd11mVcRUXyrDguxp+Op1Ge0VFiVGOY=;
  b=Sn8yERhcXjSp7rsJQ0MeeknjEGO+om6G+vJqPMTXTACP4AeBVHo57Brm
   78SwAi67bjovlC3nlrOuQcItCP0eHIs8oIg1eFbHwRYlCHJ/cPnD8GIih
   4FF/JprXBCemVYLGHh3vYBA5+7KcCmVS5DofCP5ekjBlOUOk+jL4dDXuo
   JJJ0K+bBazbnqSOakM0lYLc8kwe/ngR34UT1CtKI3ARGS6M7lj5JapiUh
   vbK8HE9EIm0xPSEVF5MqaLT5rQRMSTvtvthTLdsGIfR5nxPxEpMgTYrxk
   7RCQEbtsX3wjMa36znz+SDsohGv2HClTcaMmz2KU6aBrN0lhYieO4d3Yy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="280949085"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="280949085"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="834933791"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 19:46:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:36 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:46:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1zfGRfJ4xf1gNtcXlg0B3sAh1Aj8lyRynXwvYrvT+O7QldpRaKuyFYkp5Kx698W5p3//VqEMYqHZTVvQagsnuaM89RRflMMUtlQ1oCPiTHqNKTgW+DbQxgef57WSbD6lzxPxnCKErzhc5O2mq5jRX/bVEZv1kEM20GgmnzrgnefMlUte3DE/bvYxzoUsjWC6QQJ0KOdTONwezTHCTPwekPBkxZuLb4kmzaRC3s7TYE+BeU6WO6gURhi/4KUaToKggnJmBQX7G+iT8xZcOluU9E1orIBb0v3oNaf6WIa7Y6oruONZLVeSr8QyuYeInEAzfyX+6kb1676kq0rSgkfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TefVamjuFD+YmQWUv1V187FHCP7otPSnYBTXRSz0K7E=;
 b=Eadd/g4WjRmHxJJgoiqEoTV0/btak/hy9bSvtOID2PARXYewN29A7uSGsEVPguJWw8CcS1Cp656BxYXX3OsLOFK9TVoGiOVegy7f+gMIxFZekjZrYg+6K7I/DrAQi+SiFE4uZtrICTstUC8FjyaxrRzRROcTnBwb3bFQ8R9suYAGQv8L32mW5A+FXrd+ahOmMDXSDrtbH+GkyEU9NZXez20UPPt0EvZFSVQl6pGXv5bW/DyscOiets5YgGcoVWyqlkMP5MFkL1hKB9qxyMjE2Ej8DXoqlw/i0nGl/WRjMCnXI6b5TQrnD9RSSz7BEGnoEid8RlNd1sOMfTCh8CKWXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:46:34 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:46:34 +0000
Date:   Thu, 23 Jun 2022 19:46:29 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH 12/46] cxl/mem: Convert partition-info to resources
Message-ID: <165603878921.551046.8127845916514734142.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: CO2PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:104:5::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba54061f-29a9-4926-8ff7-08da558bbe59
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lt9AqI/Kpn+1ngzWQTBFvRUeczlk6nvttsxUSphuhX6L1GSH8iGOc2HrkDYOUAryXutzyKbF/y/ojaKLgCCzw2GfI/WK3iog+plege4BP8JnJBCbszh4q4ftjairqFsxKooATi8Jca7DAY3zFSWi4F2k5lvAGeYuBD6Dz7XRW8gnFD5DNeQRTIE7e/eIyAXU+y21TL71bQNEkp530T42FBZmSF/vAChrnJLbgVmkDgfZXvX9FKgLA0cpP4iBcD5mwpKHTZQFr+DbZm9Bl2HDlG5F5VBUMXpV/MUGqviw2lUNYJa9G+KyuU+nPLXwfZpzZr94ZM6NrozJcs8Z/YVvJz2eJ6jhg7lfjUXVg2KpcqEhtaugLfwsk3151osCwYNGKudN4nURu9QLajbO4MgtOf731e/tpNFUWnHIQ0soiNtmYCzgP8KXDKFktaGQTvk4RODZXQtwhVcCIEurqPQiE2jn2Ai/+zuCm8XIUIyKwUnFaWtLEMB0spJkIGRnLWzfHz6AEspoMDYAXuK4u0yVyueBq9GE2MLn69wyHBQFtcU5N65mh1Hbt5ICOhN8X7kDc4Cnbdwxdx0uHIXfLA/n5rjJly3ScJIQbd17g9hYIAprmGE6FAQhPALxgglJTMPaYDzi7BM0rHnpwakm73Z8qQPu7E8kA4z2++hAVdvjcJJHW5oufCBIa3ofTVf9tweVbvDIXHdzo8BaHTRbFt59uEJ1iTHMYgzWsRLhJQr0PLjFp8/idUQtdCH56lpQHO4X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(6666004)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S8Nw7tAu+exrNLwVf11gcgHufUUk/Y40TOU5hir5BqDot5JCvEYMmpu57a7r?=
 =?us-ascii?Q?80ZSrPX/eLjAMNeb9FvSS0xwckPZ8UHt9j7AqhZlX7DU1jTVMcI9Z4iPuv+5?=
 =?us-ascii?Q?alqot2pFHTshFW6Utkamm308JR4OMvK91cJWTATplBTytNzYT17mEkRdMTEX?=
 =?us-ascii?Q?YNAWnNmKsGh5DIBcN6KFiwP3oq8eY7j7aHbnXBy9WyJp8ulyFf0mVvsmD2as?=
 =?us-ascii?Q?n9ZNdmikFhNRRNx5VMDa0/chIRA0jRprmQvEio1uLvrtdhicQGaW4zp8sWGW?=
 =?us-ascii?Q?ppjaTie7iamH54fZpXAgu9bC80P1IkTwIwgDbAn9n0DyL+QunAPxp/0bWbE2?=
 =?us-ascii?Q?wEHtxTKZn8lFgAe/KG3X07NEnk5s4UyW0aAeaZIyhwOqw+2YfvIWCOhaq5Vf?=
 =?us-ascii?Q?5Q1MKU/cbUGoa21ngIEKWh9nPOySHcXFAKqKK0NZw052Sg9sfPQ8/sflQR52?=
 =?us-ascii?Q?TOsks/EM26Eyvf2Dex8P37SAU/WAtH1tuWgzN55gmNeq58YNh0ZK25j3YV9E?=
 =?us-ascii?Q?8i+eKblDcoNvzDV8JARw+xmBbH6PWiWVqu15fM0WvJnCjYLdjRDe9HgtktRV?=
 =?us-ascii?Q?YDZ+stapO6G/+LC/7IfokY/z5F0lKzerlVq841ojHZUP3J9NTe0/GKs/BfZy?=
 =?us-ascii?Q?32GEb18gAlTAcbpGXUYFkaIosd75/JvucBmQSK1yBHXH0qfaILE0Gg9x3ela?=
 =?us-ascii?Q?VR5ttLnHLRXBZ75WzYQ3r3+xjG8lBVvtNvapn9AELa/15mWMP50jkWR12I00?=
 =?us-ascii?Q?2/iNUbjM9LzyXA6SSvThrZjoiqohzv61pZcAP9kGWU/rZpBjKdDZMRsSnkUY?=
 =?us-ascii?Q?hswF5JmBmvixj6iQMUytWeKxhvnnu822mHt63PjZF1gDxEEUVX0Z43nTGk6G?=
 =?us-ascii?Q?3VYkM09scA/WL97DM8WmlsCS7FQauCfv8XBNuiNAyRylwkUI3dsde4JV1qjf?=
 =?us-ascii?Q?EpUKSVdW5qFCPBRLGRW0A6+hr6PvIs0CJiE2oiS6DGlQrF/2x8uWZiH2Ry8R?=
 =?us-ascii?Q?kjlZ4J62JpDJIF2/kBbJAOUg4EtDyQjNQMBHTM9Hyx63Ut2mbJy3wO3v/i6y?=
 =?us-ascii?Q?b0CWi0yF14MYg6pzvdJNzRmanIZjsquJ4i3DlAQ5vAFkF5CzQTH6x0qT2h+z?=
 =?us-ascii?Q?vtGpOnsiTRMYgNEwg+9GmQQ+JMhlOrTCRZM7UVlBlNg799cUL28OrY+7irxw?=
 =?us-ascii?Q?WHh3VnfRXcBfAJaQQiMzuhgSH7LNK6l4duN6kYd079BsEJRhu/ASqx8SJEG2?=
 =?us-ascii?Q?NoWpV14YDV0nWfcanJW0tDoK/6WkGl7mhgDdoZc6Mf1x7tu8XECV62YaksZN?=
 =?us-ascii?Q?5ei//4EeHZ0XnewsWwYJkJfgoMt6sk8VcbgNWlCzwVkI28vtJxab+Rlxrg/z?=
 =?us-ascii?Q?Pzxsk9fsrTnrmN+/NkBwwuW2omi6uoSJ2Nfg+rIGuDuCyNw+5jm6BmSZdFl3?=
 =?us-ascii?Q?3znI1quOeBiO2BKRkPG294/v8BVAB8hOt5pbA8mxLBaSEwGfiM9aHfwcnUtD?=
 =?us-ascii?Q?JDgKH02trAt9ltbIYM2YdjrmgdSdhksGmQ5WttqaOcWrtFcZ0Eas1EYHGO3C?=
 =?us-ascii?Q?eH+1Mn5E3mtBRwz6sZHuPgKZCO4QDqv3iDpHdMx1K1HcpFQX7NL1S6hrZhGf?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba54061f-29a9-4926-8ff7-08da558bbe59
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:46:30.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oa/hAsqkuihuJudal/n1zQ7WP1qRlWj3obCoOGK4bVOV7Fbosw0ERnjkxeYuFqMrg6+w+YF4IS5JS2yhJUmGGfY9ShJYnuZB92rsjRmx1aA=
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

To date the per-device-partition DPA range information has only been
used for enumeration purposes. In preparation for allocating regions
from available DPA capacity, convert those ranges into DPA-type resource
trees.

With resources and the new add_dpa_res() helper some open coded end
address calculations and debug prints can be cleaned.

The 'cxlds->pmem_res' and 'cxlds->ram_res' resources are child resources
of the total-device DPA space and they in turn will host DPA allocations
from cxl_endpoint_decoder instances (tracked by cxled->dpa_res).

Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c      |   78 ++++++++++++++++++++++++------------------
 drivers/cxl/core/memdev.c    |    4 +-
 drivers/cxl/cxlmem.h         |   10 +++--
 drivers/cxl/pci.c            |    2 +
 tools/testing/cxl/test/mem.c |    2 +
 5 files changed, 55 insertions(+), 41 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 54f434733b56..3fe113dd21ad 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -771,15 +771,6 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	cxlds->partition_align_bytes =
 		le64_to_cpu(id.partition_align) * CXL_CAPACITY_MULTIPLIER;
 
-	dev_dbg(cxlds->dev,
-		"Identify Memory Device\n"
-		"     total_bytes = %#llx\n"
-		"     volatile_only_bytes = %#llx\n"
-		"     persistent_only_bytes = %#llx\n"
-		"     partition_align_bytes = %#llx\n",
-		cxlds->total_bytes, cxlds->volatile_only_bytes,
-		cxlds->persistent_only_bytes, cxlds->partition_align_bytes);
-
 	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
 	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
 
@@ -787,42 +778,63 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
 
-int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
+static int add_dpa_res(struct device *dev, struct resource *parent,
+		       struct resource *res, resource_size_t start,
+		       resource_size_t size, const char *type)
 {
 	int rc;
 
-	if (cxlds->partition_align_bytes == 0) {
-		cxlds->ram_range.start = 0;
-		cxlds->ram_range.end = cxlds->volatile_only_bytes - 1;
-		cxlds->pmem_range.start = cxlds->volatile_only_bytes;
-		cxlds->pmem_range.end = cxlds->volatile_only_bytes +
-				       cxlds->persistent_only_bytes - 1;
+	res->name = type;
+	res->start = start;
+	res->end = start + size - 1;
+	res->flags = IORESOURCE_MEM;
+	if (resource_size(res) == 0) {
+		dev_dbg(dev, "DPA(%s): no capacity\n", res->name);
 		return 0;
 	}
-
-	rc = cxl_mem_get_partition_info(cxlds);
+	rc = request_resource(parent, res);
 	if (rc) {
-		dev_err(cxlds->dev, "Failed to query partition information\n");
+		dev_err(dev, "DPA(%s): failed to track %pr (%d)\n", res->name,
+			res, rc);
 		return rc;
 	}
 
-	dev_dbg(cxlds->dev,
-		"Get Partition Info\n"
-		"     active_volatile_bytes = %#llx\n"
-		"     active_persistent_bytes = %#llx\n"
-		"     next_volatile_bytes = %#llx\n"
-		"     next_persistent_bytes = %#llx\n",
-		cxlds->active_volatile_bytes, cxlds->active_persistent_bytes,
-		cxlds->next_volatile_bytes, cxlds->next_persistent_bytes);
+	dev_dbg(dev, "DPA(%s): %pr\n", res->name, res);
 
-	cxlds->ram_range.start = 0;
-	cxlds->ram_range.end = cxlds->active_volatile_bytes - 1;
+	return 0;
+}
 
-	cxlds->pmem_range.start = cxlds->active_volatile_bytes;
-	cxlds->pmem_range.end =
-		cxlds->active_volatile_bytes + cxlds->active_persistent_bytes - 1;
+int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	int rc;
 
-	return 0;
+	cxlds->dpa_res =
+		(struct resource)DEFINE_RES_MEM(0, cxlds->total_bytes);
+
+	if (cxlds->partition_align_bytes == 0) {
+		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
+				 cxlds->volatile_only_bytes, "ram");
+		if (rc)
+			return rc;
+		return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
+				   cxlds->volatile_only_bytes,
+				   cxlds->persistent_only_bytes, "pmem");
+	}
+
+	rc = cxl_mem_get_partition_info(cxlds);
+	if (rc) {
+		dev_err(dev, "Failed to query partition information\n");
+		return rc;
+	}
+
+	rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
+			 cxlds->active_volatile_bytes, "ram");
+	if (rc)
+		return rc;
+	return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
+			   cxlds->active_volatile_bytes,
+			   cxlds->active_persistent_bytes, "pmem");
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f7cdcd33504a..20ce488a7754 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -68,7 +68,7 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	unsigned long long len = range_len(&cxlds->ram_range);
+	unsigned long long len = resource_size(&cxlds->ram_res);
 
 	return sysfs_emit(buf, "%#llx\n", len);
 }
@@ -81,7 +81,7 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	unsigned long long len = range_len(&cxlds->pmem_range);
+	unsigned long long len = resource_size(&cxlds->pmem_res);
 
 	return sysfs_emit(buf, "%#llx\n", len);
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 7df0b053373a..a9609d40643f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -178,8 +178,9 @@ struct cxl_endpoint_dvsec_info {
  * @firmware_version: Firmware version for the memory device.
  * @enabled_cmds: Hardware commands found enabled in CEL.
  * @exclusive_cmds: Commands that are kernel-internal only
- * @pmem_range: Active Persistent memory capacity configuration
- * @ram_range: Active Volatile memory capacity configuration
+ * @dpa_res: Overall DPA resource tree for the device
+ * @pmem_res: Active Persistent memory capacity configuration
+ * @ram_res: Active Volatile memory capacity configuration
  * @total_bytes: sum of all possible capacities
  * @volatile_only_bytes: hard volatile capacity
  * @persistent_only_bytes: hard persistent capacity
@@ -209,8 +210,9 @@ struct cxl_dev_state {
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 
-	struct range pmem_range;
-	struct range ram_range;
+	struct resource dpa_res;
+	struct resource pmem_res;
+	struct resource ram_res;
 	u64 total_bytes;
 	u64 volatile_only_bytes;
 	u64 persistent_only_bytes;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5a0ae46d4989..eeff9599acda 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -454,7 +454,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-	if (range_len(&cxlds->pmem_range) && IS_ENABLED(CONFIG_CXL_PMEM))
+	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
 
 	return rc;
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 6b9239b2afd4..b81c90715fe8 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -282,7 +282,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
-	if (range_len(&cxlds->pmem_range) && IS_ENABLED(CONFIG_CXL_PMEM))
+	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = devm_cxl_add_nvdimm(dev, cxlmd);
 
 	return 0;

