Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F19558D62
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiFXCqR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiFXCqQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:46:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9597456C1A;
        Thu, 23 Jun 2022 19:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038775; x=1687574775;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UuGrHny67EcriTNUGmCqxqKEAsElauQ4LgH89uYtwsY=;
  b=lIc1xWmL+TfO+y7mlUJwp6iYs+PBuEsGgXE83w2zIGHpFWURtK5Osj/K
   To1a3wbRzAGGhS8xlkZOkN5ExEendWQYJksLvau1LQxosWULN0SrvFZ18
   uCy/6Z6KPtPH4wmrF7pxuSxzBITvFwFQrkwuanBylj1/wI85AZajLMkHu
   LsJmy33kEBtvxuIX74Q9GQ9D6YvssWXPYwTBfvZ1izJGiMqY5nFsy/yPD
   OJSX1i1PQvV5VN/DUNGMl3f58Z11vriYFOfrkNTJ/14f6VVj1OVxzDivb
   FieJ3+cwRTbEAVpPQy8i0+dmdSAFNkjtBIoGYXLLlrdceL1Xe9qlBZFFI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="278453424"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="278453424"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:46:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="678351770"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2022 19:46:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:14 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:46:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hoj0j3QLZKxCDC9hpcYh4V2vXAjHd1nbxdAqk1FiHFBVJ5SMpr4ZyGo68bW1e3c8CxMNAMsArUaZ4NWN6C0G2zgWkdyAnKictR4oHSYCoT+dWFTk8IHKwdhDnBbjSNDm05uXVMs9L00jCqLDJuJnk5Q1/IxmCYRp3TMkzChzTgMZjPFI/FWIiYoVtKDyy/tpUsw6tvcb3lrINvXP/l+kLd6m9Zz1i+uJrJPOVKUXPtoWekgBGQIBWCFE47aAsAJmbzrO55FBTcpPVcA6bdGWCTdPSsCL90hNZP2f5Z4F9BVfLuy6DdCpq2bA+h6TvYrWWPkBqdvNfxoDAl8iZ/YIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjODh95hfxS5/uvvawpYC+4SICNbMQ5wGFwQMZCWAWQ=;
 b=KPLtW3GFZfDsknBuOIc5rJ3WqCIID5lY0szWeEQj0Grh800XqXpy6AGqucOZRfzaOyo9juu+wgo9Vxzbjwm6rDWycxHp3NlaSC32jyA1Y34ioMjt11zvPjY+G2+odZCeGp7wMeokGLEmEBysrk09ONz3JEFLAsXyiO3a4nM10lBqo6IhRL67E7u8q27mwSKNiSL2gRCudRvjQT9Yczr2BiCB5oiBj7XXj2OC+DtT5Dxa816lOWZ5tBLsgxMMtStfhr387Gv8V1GbMuNGv4BaVd2Qh5rMh54j+cl3pFfDU7gGBy4hw+FYDDerjcfGB6pIUvG91QLIhlsB5OWZG4TG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:46:12 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:46:12 +0000
Date:   Thu, 23 Jun 2022 19:46:05 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 09/46] cxl/acpi: Track CXL resources in iomem_resource
Message-ID: <165603876550.551046.11015869763159096807.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MW4PR04CA0265.namprd04.prod.outlook.com
 (2603:10b6:303:88::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb9fe7c8-fe8f-43df-ddbb-08da558bb03d
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAFqwQYqAgLnzBKP9vEReSDJdYDiEhnanH2sjlb3WANLfz5CI8uPOy7qTORZvvTcae2wkTYd20h0YUsh/iAdZPufK9kemGabsjFdnNiI6XWN4uEAPt5Z7ejZklz0TS2o829n665wF8HSq3Xz0T/Hcu+NfZmlUtnFPdGNqpsNarrDHYbPS9udvKDQiyYnfHsG5PjW7TV4jGUyyqi4jRyH3e4+BhEwrenceJydvd+TVSe0Ekinc9fn7BvUcu5m1kT90L7sYEjRjMZp6PmCq2JrFhP8syE+iz5zd6WHOe4Bzh5zHaMxsyVbuYqj3e/GMN5RUiuCyIIh35AcLyx8kESsn8dQvUEDSr5k88g5Kw0fjcJE/eY6MSP92w27TRwHp2jdpuScSGdS6ZkDXF8HNAG4UaZ//V48JGw2WSk7lq4+XFjA9YPzRqJMB11LcP5gK7clZT8kJ83hnZ4sFiIeKPJLHmBiUopbCg2M9mQHq4WhoXfFVjL6TVERVIBAkSCdSsS4l1IYxJzmuHSFNbDvLzzwams293q5vWDQIjoxFRYFd1urORwxNeRAO+bgHdXopCVUZ4j34SaFR8pPkM1CaA5tWCnJZ+Los30hIfdMxDQ2C+Vb8FZx34H7sNhfVE4aooxKihAuIa7MEq734dXzbS/bYGoo7ebQArksaNX/VPnbovU3vVZxggzqNls+46f9kJ0vuU3nJNlfMd0XQR4IeV32VNrFcoa21AJPyVi/N19PNzrK/hLgV3E6GTjsCIUGQ0IK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(6666004)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Y7qFgcY07FZEnAv5mAoa4alzr+cXzTSNXxfY7ufVyzEIMRe+1zBwC+dLYdo?=
 =?us-ascii?Q?SUCCm5RaOEzmTweLCtxsETEVEdpZVBiIIl97P3w33XaB07aXHRq8BlrM8awn?=
 =?us-ascii?Q?EriUxFdpjUtIW2tvYXwttegPrDxAxxZKjh2jeNgnbiBpPlRa5W0emNrS3BuG?=
 =?us-ascii?Q?Ng2M3mkjXN6KvvXgyOP+7D696VYasSdHv01C8LAoaf9tYyf4Y74rzOn1YfjF?=
 =?us-ascii?Q?HMV1ehAw/zIwY4Gobsy8iANJFAGaxgv9FwkMvAHgjtc72fNNHm/Xup2toZri?=
 =?us-ascii?Q?1lXjkkG5AdT2LdmE+RtPctdJNQbqoJwNRiJQbs8i7rpZwo346pYGp9NsDmmX?=
 =?us-ascii?Q?dq53cFCd6aXDCYbuLxijKX3+MbqQBrcWvuDWrwtWy+wDNnxqlJNSlPmb+8O/?=
 =?us-ascii?Q?vuYSVeja+vgOhwxT0uLbCEzm8VUwV7FH2eIDcv9rdB51rM23AmtC9stA8Izy?=
 =?us-ascii?Q?KcMEr6BONnMwQHzUs+NUoIpiawOhp0QKJbSpBTpTu1iMzqHiozkKizlfXiwg?=
 =?us-ascii?Q?Ei8QAgJabpeVmqt5fEIApe+YOVvZYmUPQ/zl/B5bHqMhDVb2++AaIinKia8D?=
 =?us-ascii?Q?hKDVHIkIoo0Q6eVhwmH61g3QHqduc2GkPbc4BDmGAIz6B0hwk63R04fGQKHP?=
 =?us-ascii?Q?3TAtGSjam4qRMecVNsopNL/IYEEP33ntDyAMYSwCTuaUPDUuTIF5sqCQV2gh?=
 =?us-ascii?Q?9ozBE83qCOnXEzrfLOrVbGiH829ERecDqChhGEDUyb2kRDtYzbMJRyfFP4Dn?=
 =?us-ascii?Q?OGTN6RZIMOraTWcyjnO70zUWRL40g1rOvfhEWeJCDHtcLnh7gViJUteiuLGT?=
 =?us-ascii?Q?T/wZJcMZVLTIZ+2iB3jxHsFKFzw4enG237q4XJv8glOFkh/B7Mu2hW99GdPC?=
 =?us-ascii?Q?T7K65hICITJvTbsRkoKP1IhNES6ampR5NkMOwWi2X+6xjptM0b4Uw9EQcCGS?=
 =?us-ascii?Q?etke0AFAQdYy6oTYy+qgVA+0aCVo3rVR0k45syedell39qwBugEe8mBPurza?=
 =?us-ascii?Q?ar6O4YwBhciSi8IFAOgFq1VyOaGP7tnwj6XIqDedVZ0MOQm4bQcFXyNi2WMw?=
 =?us-ascii?Q?FoF7eD8zOwhkBbGxVmuoRstUgEnwy4Dac6PtQFrsrpN7wB05BwdmxhJVlwwQ?=
 =?us-ascii?Q?NJOl+8WTAVcd8vvbrNAqV/E8BEWx/i4BYhY+4J4jPUtwF9IbaLaf6JGicZeT?=
 =?us-ascii?Q?PDAPSUxh45phP+kuOdSKIwRqeBBfW22rPZmXntCeSy09N0aGNSUAIiip/PVJ?=
 =?us-ascii?Q?o5qXYEyEF/5bf367GEzWqAgrAii9Es9jLEdiI1cRsmbjPwsbzq80jXfI20Cz?=
 =?us-ascii?Q?BMSPR2dbyxMdfOBa2Q3E1iHUvdUIGAO7r6st8ALpeJ/XpFjUZ2XMI98Z6vkl?=
 =?us-ascii?Q?AHr5gs6aBH829gvMFgaZt1COOcD+Hr+CR6kzPTN8CNaBmaQFRwTLQxKgjps2?=
 =?us-ascii?Q?1ZlU5OdnyG3EHr7u0EctzFGnhU946prnJOttq1ufgOcgP8cAhV5DeKBNhTy0?=
 =?us-ascii?Q?UE4XH0ByrmqLjETIXKEMSDBh5U5WI614qEN/o1xpD2y38wKOgxLJNdrVPwKU?=
 =?us-ascii?Q?n1lORCI+DFsLLT1bGEcEtSHnCZjX5QqW9C0kVtr5x+bFjUMch1j0ai6eQIdo?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9fe7c8-fe8f-43df-ddbb-08da558bb03d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:46:07.3412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soPvrOCuSP3RM0iH3ofSnJ0DRPWKqB2llGpltUD+v6EP1N5+Fp1klSai0xQKHNRL+Fty/kY2CUCKmEehTjMcXnrcAdcMZpnjyXQK+yz76Ag=
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

Recall that CXL capable address ranges, on ACPI platforms, are published
in the CEDT.CFMWS (CXL Early Discovery Table - CXL Fixed Memory Window
Structures). These windows represent both the actively mapped capacity
and the potential address space that can be dynamically assigned to a
new CXL decode configuration.

CXL endpoints like DDR DIMMs can be mapped at any physical address
including 0 and legacy ranges.

There is an expectation and requirement that the /proc/iomem interface
and the iomem_resource in the kernel reflect the full set of platform
address ranges. I.e. that every address range that platform firmware and
bus drivers enumerate be reflected as an iomem_resource entry. The hard
requirement to do this for CXL arises from the fact that capabilities
like CONFIG_DEVICE_PRIVATE expect to be able to treat empty
iomem_resource ranges as free for software to use as proxy address
space. Without CXL publishing its potential address ranges in
iomem_resource, the CONFIG_DEVICE_PRIVATE mechanism may inadvertently
steal capacity reserved for runtime provisioning of new CXL regions.

The approach taken supports dynamically publishing the CXL window map on
demand when a CXL platform driver like cxl_acpi loads. The windows are
then forced into the first level of iomem_resource tree via the
insert_resource_expand_to_fit() API. This forcing sacrifices some
resource boundary accurracy in order to better reflect the decode
hierarchy of a CXL window hosting "System RAM" and other resources.

Walkers of the iomem_resource tree will also need to have access to the
related 'struct cxl_decoder' instances to disambiguate which portions of
a CXL memory resource are present vs expanded to enforce the expected
resource topology.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/resource.c  |    7 +++
 2 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index d1b914dfa36c..003fa4fde357 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -73,6 +73,7 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 struct cxl_cfmws_context {
 	struct device *dev;
 	struct cxl_port *root_port;
+	int id;
 };
 
 static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
@@ -84,8 +85,10 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	struct cxl_switch_decoder *cxlsd;
 	struct device *dev = ctx->dev;
 	struct acpi_cedt_cfmws *cfmws;
+	struct resource *cxl_res;
 	struct cxl_decoder *cxld;
 	unsigned int ways, i, ig;
+	struct resource *res;
 	int rc;
 
 	cfmws = (struct acpi_cedt_cfmws *) header;
@@ -107,6 +110,24 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	for (i = 0; i < ways; i++)
 		target_map[i] = cfmws->interleave_targets[i];
 
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	res->name = kasprintf(GFP_KERNEL, "CXL Window %d", ctx->id++);
+	if (!res->name)
+		goto err_name;
+
+	res->start = cfmws->base_hpa;
+	res->end = cfmws->base_hpa + cfmws->window_size - 1;
+	res->flags = IORESOURCE_MEM;
+
+	/* add to the local resource tracking to establish a sort order */
+	cxl_res = dev_get_drvdata(&root_port->dev);
+	rc = insert_resource(cxl_res, res);
+	if (rc)
+		goto err_insert;
+
 	cxlsd = cxl_root_decoder_alloc(root_port, ways);
 	if (IS_ERR(cxld))
 		return 0;
@@ -115,8 +136,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
 	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->hpa_range = (struct range) {
-		.start = cfmws->base_hpa,
-		.end = cfmws->base_hpa + cfmws->window_size - 1,
+		.start = res->start,
+		.end = res->end,
 	};
 	cxld->interleave_ways = ways;
 	cxld->interleave_granularity = ig;
@@ -131,12 +152,19 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 			cxld->hpa_range.start, cxld->hpa_range.end);
 		return 0;
 	}
+
 	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
 		dev_name(&cxld->dev),
 		phys_to_target_node(cxld->hpa_range.start),
 		cxld->hpa_range.start, cxld->hpa_range.end);
 
 	return 0;
+
+err_insert:
+	kfree(res->name);
+err_name:
+	kfree(res);
+	return -ENOMEM;
 }
 
 __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
@@ -291,9 +319,66 @@ static void cxl_acpi_lock_reset_class(void *dev)
 	device_lock_reset_class(dev);
 }
 
+static void del_cxl_resource(struct resource *res)
+{
+	kfree(res->name);
+	kfree(res);
+}
+
+static void remove_cxl_resources(void *data)
+{
+	struct resource *res, *next, *cxl = data;
+
+	for (res = cxl->child; res; res = next) {
+		struct resource *victim = (struct resource *) res->desc;
+
+		next = res->sibling;
+		remove_resource(res);
+
+		if (victim) {
+			remove_resource(victim);
+			kfree(victim);
+		}
+
+		del_cxl_resource(res);
+	}
+}
+
+static int add_cxl_resources(struct resource *cxl)
+{
+	struct resource *res, *new, *next;
+
+	for (res = cxl->child; res; res = next) {
+		new = kzalloc(sizeof(*new), GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+		new->name = res->name;
+		new->start = res->start;
+		new->end = res->end;
+		new->flags = IORESOURCE_MEM;
+		res->desc = (unsigned long) new;
+
+		insert_resource_expand_to_fit(&iomem_resource, new);
+
+		next = res->sibling;
+		while (next && resource_overlaps(new, next)) {
+			if (resource_contains(new, next)) {
+				struct resource *_next = next->sibling;
+
+				remove_resource(next);
+				del_cxl_resource(next);
+				next = _next;
+			} else
+				next->start = new->end + 1;
+		}
+	}
+	return 0;
+}
+
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
 	int rc;
+	struct resource *cxl_res;
 	struct cxl_port *root_port;
 	struct device *host = &pdev->dev;
 	struct acpi_device *adev = ACPI_COMPANION(host);
@@ -305,21 +390,40 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	cxl_res = devm_kzalloc(host, sizeof(*cxl_res), GFP_KERNEL);
+	if (!cxl_res)
+		return -ENOMEM;
+	cxl_res->name = "CXL mem";
+	cxl_res->start = 0;
+	cxl_res->end = -1;
+	cxl_res->flags = IORESOURCE_MEM;
+
 	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
 	if (IS_ERR(root_port))
 		return PTR_ERR(root_port);
 	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
+	dev_set_drvdata(&root_port->dev, cxl_res);
 
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
 	if (rc < 0)
 		return rc;
 
+	rc = devm_add_action_or_reset(host, remove_cxl_resources, cxl_res);
+	if (rc)
+		return rc;
+
 	ctx = (struct cxl_cfmws_context) {
 		.dev = host,
 		.root_port = root_port,
 	};
-	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, cxl_parse_cfmws, &ctx);
+	rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, cxl_parse_cfmws, &ctx);
+	if (rc < 0)
+		return -ENXIO;
+
+	rc = add_cxl_resources(cxl_res);
+	if (rc)
+		return rc;
 
 	/*
 	 * Root level scanned with host-bridge as dports, now scan host-bridges
diff --git a/kernel/resource.c b/kernel/resource.c
index 34eaee179689..53a534db350e 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -891,6 +891,13 @@ void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
 	}
 	write_unlock(&resource_lock);
 }
+/*
+ * Not for general consumption, only early boot memory map parsing, PCI
+ * resource discovery, and late discovery of CXL resources are expected
+ * to use this interface. The former are built-in and only the latter,
+ * CXL, is a module.
+ */
+EXPORT_SYMBOL_NS_GPL(insert_resource_expand_to_fit, CXL);
 
 /**
  * remove_resource - Remove a resource in the resource tree

