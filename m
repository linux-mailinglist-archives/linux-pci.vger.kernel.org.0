Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5206F558D60
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiFXCqJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiFXCqI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:46:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD8356759;
        Thu, 23 Jun 2022 19:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038766; x=1687574766;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ES5Q6FuRjJPmaYVv0b5/m9cu+MktkqEe8eUJ+CaqccY=;
  b=K0HSoL5F+wErHl5/enkqpqRkjORYfeByGLvpn+g5AdOux32qn0Jgw7lb
   TEKBeN1pg5yR44QCAV3pplyfXvgQrkW36Kp9+gjotC526sX40ZNkopPDP
   y9vIZ7t8n5fDX/b/UuTws2mvfm44FLxhl1PGPrOD8YNqwJwzIWZeLXNI2
   ovSx+H3Oka31z1++O4Qjv/o258OBx8fkUiXBwhRORqV3pGbnxysRoKMTa
   PTO+HUsAFbXSot/aRYhjxnP7yt13xS38YRCTYpkH3wQ9E7eogyrX/Y/vw
   /drMNnagyL9Vk38qMJBx7sVuHt2PHSFyKPue3p2C8irfjl/RGqor1lx2H
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="306370068"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="306370068"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="563694811"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 23 Jun 2022 19:46:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:46:05 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFFfBrmvytb0cN2DEBkKg5X6VSGXvSif8tF/ok8jIGcjvvyLNGNqaq7qVTVxxNM3P2/RSXpLE83XiA4HBYDFFZj6+GVIBKLL5l3P0moqwf8NwgLpIVXvfmoI/MDjMhzTiSdUohtm7hNMz2WAKuJNjlZj5quZ0Bg2HEYvowoGAmdK0Eh0x9v7vHuE8tru10cjYR/w+vi10KrUo1XUxeVVQWu7JqVlnRpFmsVCEsRqfFz5F4O4nDqBsOAZA7nukCMPdiF42y8LpMfWCmYQeuWU7q45iNR1Ix1lwrS+Jjs9V6wwAMoBInJul36rXt8bK7JebTi9VghGgiFvy/n68WYjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRN2JaGG1FUtDSBI7L9cppARW+npW1ECWP9Db+sHFiA=;
 b=VumEbRBI5ybpNaII9CbQVqE/avpRWQMJlLpVbYDY9OhfGR5F/fGcAEA1vStfJufzYZOZP7ffR9npv0RnPL4r+JPFZL5UG2DyAdTvvwO0MFPRtqyaKAqYf7o9v29IvPftd/mGIGWf9auKGnlg5bH5gZNDgppDXKoIZyY5e6MvnkBun9y5grj34U4+Hk93x0U1LfiBqA4oxPHawo1NBuAzDCsKwG09u/xOOm9MqKbmha5VBfHkuGh1UwDx4F/iHfOKKRh+rqr0MrvC3shSDsbJneCFBPnF04AjEQDltFpzCsBQSm/IlGE2cpThgUNmERTxTxxBpfNDq6OdOzU8qYuVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:46:03 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:46:03 +0000
Date:   Thu, 23 Jun 2022 19:45:57 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH 08/46] cxl/core: Define a 'struct cxl_switch_decoder'
Message-ID: <165603875762.551046.12872423961024324769.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MW2PR2101CA0035.namprd21.prod.outlook.com
 (2603:10b6:302:1::48) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6236be44-eb78-4126-ce96-08da558baba1
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wD8A69UTgoDqZkdtYvRo9LxVji/wNdhEd4hcJSVOzlEaV0is+PSIhodHcxLQxZbPpmegcwYEyFKRq1LW6r7L83zVBgyc5iTsmfn2ciFgXx36RV5jkwDVN+bjD4a5lA4qVzI2b9dl8Sveu7B20XgcaIT9qT/RyIeahnEQt33K9xB71X+NnXlOTLEo+tYA/OigUAoPId2gTThMzchzwnpLhdlk+/OF7k19N6KTs5Qoa6cFNMAf2pG0bK6G0QStzKnuF8IfQijHaI9qk0YkAYM15mzcPgd7BSHwRmwyVlMPLDHPuS9/NgRwIGFELlwTYRdKFsr2cv1KWVfZDoucN1l55KHmpHusR3CKs0nLjweJ+so9YIxSwmYKABZqssGk0zLAr7nGrXzXVsZEnIJ5c3igo6TSlqpW09swtvdV0fy9OweoI9TBlQLX2RzwkGEWUnj3Ucp7LXBZrRceKXVyBn5Meve9D5yl9+iJn4IcOU2SfMf+tHxBIgs1i9/OOoFFKREWYoITcdf0qc6vaZJGt/In3BaQS7JTufs0njF3X/KMUnMKpfdaqHKLmtFdBp8tIswaRkNMuzJBL3Jgsa/v0J0HCB0lumz7eFL8xuKvhMpDODyOZzLd/aPl5f081V+JSqvzeCkSXSlhppI677akK6CPZMzMRnFJe9HaYHOgLlQM9ajpC7Y6Z8Mb3ZSvM3BWUqh3qcPBnAkmaabccwOeAgOGDZojGRSLagM/4gfjhCUUOgqqwj79yK4nIC0hk1XFN/A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(6666004)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(30864003)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sKDB/ZBT+jY1GZ2ohx2CS1fXog0D+sv2iEuYk7D5lyqnQ6y/5ZzzodEw4sZw?=
 =?us-ascii?Q?n5CPX9aBu/eNoTHIN6Cq4Ns2oRUErGVNjX0gr2K0dt1y/qwLUpt4vO8qTFFq?=
 =?us-ascii?Q?UXCTQxwiL1hC0tjoq8E7cgpBkFf42zYbhrO9s6ygnXG2j9XDP2OYnkqv5MFT?=
 =?us-ascii?Q?7A1Zes5rXpq1swnMD/l2YMCeLEDHXL0MbafptBcoO2GB8ByzCJ9iqO2n8sNt?=
 =?us-ascii?Q?O1wSacquGB38X5bfOV4tbZ+Q1yock89pEArrgpfY4RJqHEr7eiTtKbxLVqBm?=
 =?us-ascii?Q?w/X0pFuI69nELv1qgWtwsnXdd2Jj2Suxc/UUioRsi889h85FGYzwy+vMdqel?=
 =?us-ascii?Q?rNEH+nSyLQMbHHN6P1N2SmT5jhtPl07yfD+B58MyNlk3BVkRiVdYSd0ouLkr?=
 =?us-ascii?Q?Z1//3z6IrFc3d8QV39M2FFilVJudZBO9aWRuEOeQdJWp0syQ66NhFNpdJu2/?=
 =?us-ascii?Q?tDEvlK2F7cpFbz3YW6VN9HDtm04TXjwFtOw2vK+TZ+W2pP/Yh+GMiZqH9ZOa?=
 =?us-ascii?Q?6FL7jZRBE5BagNW7HuIebpk0gA0U24g1goiam1NvgBDNyOSuQ8Ll/F74ASB5?=
 =?us-ascii?Q?XYTz3EfPgLPymbJIcE8Pd/PDEq/DVoh31CuzvVUdAXKYFeSKBRq5p0sTTDxD?=
 =?us-ascii?Q?r4AP1GqDJ040+diqG/YxZAH/lPObKsn5rSZmaAvWnu/yWa/ZHAS5jsrX5ZsV?=
 =?us-ascii?Q?IrtZldG9iPHbnXybp9t85WWFvRYrH0ktiQGHjdKXaIHJuNiHlI9wjjIlBc2c?=
 =?us-ascii?Q?rLnnNZvxSRIq4hRazkUGWzFjijbCknV6ZslntXEykJ+FWU4gtD3EDdpP9yrJ?=
 =?us-ascii?Q?GKTMZVBxOpJCTR6uKxeXrxBU4aI7H0KrxQKwuGMEqZElTyD+h5cSFIIlNEgx?=
 =?us-ascii?Q?YOjjK69HYE5JLmKBR9rQFbG0dg05td2UZLvICtMBATB/s1CLL/wuJPvOPD6V?=
 =?us-ascii?Q?ofVXL43BmnYMG5o3BQhW6+RqcAVY3H93/eBJOqvFjowcQYnOXZ3b5JdH7s4l?=
 =?us-ascii?Q?G6zTfdDqQKtPcGUHEPCjaqPvhTA2A9ISXmUCdEmYMGMRFMI0K+LsngoSq+ZA?=
 =?us-ascii?Q?QaKKf65EDuILqjJGMJpD88d98yKPHSOSj/jw0+ctQqHnvLrUhgjGqAAV07B1?=
 =?us-ascii?Q?5+nDEE0/o89VSd1QwPb3SFCHu12y2C7/Ouc6V7jSNrgkVEyKd17NxQVqZRUR?=
 =?us-ascii?Q?0HL653PIfJIq1f8EfzwKYsjkvwP6tNIPmVtgBGvY0k1UdWe3SnMn/7ywV02l?=
 =?us-ascii?Q?6Xju7eZy/8IyyQUb2EsimxrVtxFCqMk1ZyBKrLNRTgivHN35GP3OdAdTmsT3?=
 =?us-ascii?Q?yggeB7GFdRbBunJRdyvpjupqNvfvnWT585IC0AehpCwicHUUSqKadN8y9fMI?=
 =?us-ascii?Q?h++dvhMNithvrpZWgbH59QEmhRslbumMiyxm/hRrFdugFd4xabnxD1Xi2MIM?=
 =?us-ascii?Q?9datKHfLtrkUOo6008VnqCp8m78frTrp/XY9osNWcIJtOZT9JQcc0t8vHPq8?=
 =?us-ascii?Q?Jc8G+OwbENeOdmVNhxKeuyFhXWjdrOvAS4TSXIpbFKaEhQNC7ZT3iT3Ku8Si?=
 =?us-ascii?Q?fMXV1oD5IcO8VWCXk3u1U2DUG+r2M9vN5SMPGvrIMv5y2nq0Q95mN2TQP8cT?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6236be44-eb78-4126-ce96-08da558baba1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:45:59.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GHnR1cahs3Ppf0jRJWBWIcF1TtGGqpIOXqUfEhwiGhHK0ZxhTYRqiFbCmq1fskRpc/jyBWbG9/99a3l1fg0ZvUtRO/NE8fopyFyLOL6JqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently 'struct cxl_decoder' contains the superset of attributes
needed for all decoder types. Before more type-specific attributes are
added to the common definition, reorganize 'struct cxl_decoder' into type
specific objects.

This patch, the first of three, factors out a cxl_switch_decoder type.
The 'switch' decoder type represents the decoder instances of cxl_port's
that route from the root of a CXL memory decode topology to the
endpoints. They come in two flavors, root-level decoders, statically
defined by platform firmware, and mid-level decoders, where
interleave-granularity, interleave-width, and the target list are
mutable.

Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c           |    4 +
 drivers/cxl/core/hdm.c       |   21 +++++---
 drivers/cxl/core/port.c      |  115 +++++++++++++++++++++++++++++++-----------
 drivers/cxl/cxl.h            |   27 ++++++----
 tools/testing/cxl/test/cxl.c |   12 +++-
 5 files changed, 128 insertions(+), 51 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 544cb10ce33e..d1b914dfa36c 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -81,6 +81,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	int target_map[CXL_DECODER_MAX_INTERLEAVE];
 	struct cxl_cfmws_context *ctx = arg;
 	struct cxl_port *root_port = ctx->root_port;
+	struct cxl_switch_decoder *cxlsd;
 	struct device *dev = ctx->dev;
 	struct acpi_cedt_cfmws *cfmws;
 	struct cxl_decoder *cxld;
@@ -106,10 +107,11 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	for (i = 0; i < ways; i++)
 		target_map[i] = cfmws->interleave_targets[i];
 
-	cxld = cxl_root_decoder_alloc(root_port, ways);
+	cxlsd = cxl_root_decoder_alloc(root_port, ways);
 	if (IS_ERR(cxld))
 		return 0;
 
+	cxld = &cxlsd->cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
 	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->hpa_range = (struct range) {
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 46635105a1f1..2d1f3e6eebea 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -46,20 +46,20 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
  */
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 {
-	struct cxl_decoder *cxld;
+	struct cxl_switch_decoder *cxlsd;
 	struct cxl_dport *dport;
 	int single_port_map[1];
 
-	cxld = cxl_switch_decoder_alloc(port, 1);
-	if (IS_ERR(cxld))
-		return PTR_ERR(cxld);
+	cxlsd = cxl_switch_decoder_alloc(port, 1);
+	if (IS_ERR(cxlsd))
+		return PTR_ERR(cxlsd);
 
 	device_lock_assert(&port->dev);
 
 	dport = list_first_entry(&port->dports, typeof(*dport), list);
 	single_port_map[0] = dport->port_id;
 
-	return add_hdm_decoder(port, cxld, single_port_map);
+	return add_hdm_decoder(port, &cxlsd->cxld, single_port_map);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);
 
@@ -226,8 +226,15 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 
 		if (is_cxl_endpoint(port))
 			cxld = cxl_endpoint_decoder_alloc(port);
-		else
-			cxld = cxl_switch_decoder_alloc(port, target_count);
+		else {
+			struct cxl_switch_decoder *cxlsd;
+
+			cxlsd = cxl_switch_decoder_alloc(port, target_count);
+			if (IS_ERR(cxlsd))
+				cxld = ERR_CAST(cxlsd);
+			else
+				cxld = &cxlsd->cxld;
+		}
 		if (IS_ERR(cxld)) {
 			dev_warn(&port->dev,
 				 "Failed to allocate the decoder\n");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 13c321afe076..fd1cac13cd2e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -119,20 +119,21 @@ static ssize_t target_type_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(target_type);
 
-static ssize_t emit_target_list(struct cxl_decoder *cxld, char *buf)
+static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
 {
+	struct cxl_decoder *cxld = &cxlsd->cxld;
 	ssize_t offset = 0;
 	int i, rc = 0;
 
 	for (i = 0; i < cxld->interleave_ways; i++) {
-		struct cxl_dport *dport = cxld->target[i];
+		struct cxl_dport *dport = cxlsd->target[i];
 		struct cxl_dport *next = NULL;
 
 		if (!dport)
 			break;
 
 		if (i + 1 < cxld->interleave_ways)
-			next = cxld->target[i + 1];
+			next = cxlsd->target[i + 1];
 		rc = sysfs_emit_at(buf, offset, "%d%s", dport->port_id,
 				   next ? "," : "");
 		if (rc < 0)
@@ -143,18 +144,20 @@ static ssize_t emit_target_list(struct cxl_decoder *cxld, char *buf)
 	return offset;
 }
 
+static struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
+
 static ssize_t target_list_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(dev);
 	ssize_t offset;
 	unsigned int seq;
 	int rc;
 
 	do {
-		seq = read_seqbegin(&cxld->target_lock);
-		rc = emit_target_list(cxld, buf);
-	} while (read_seqretry(&cxld->target_lock, seq));
+		seq = read_seqbegin(&cxlsd->target_lock);
+		rc = emit_target_list(cxlsd, buf);
+	} while (read_seqretry(&cxlsd->target_lock, seq));
 
 	if (rc < 0)
 		return rc;
@@ -232,14 +235,28 @@ static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
 	NULL,
 };
 
+static void __cxl_decoder_release(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	ida_free(&port->decoder_ida, cxld->id);
+	put_device(&port->dev);
+}
+
 static void cxl_decoder_release(struct device *dev)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
-	struct cxl_port *port = to_cxl_port(dev->parent);
 
-	ida_free(&port->decoder_ida, cxld->id);
+	__cxl_decoder_release(cxld);
 	kfree(cxld);
-	put_device(&port->dev);
+}
+
+static void cxl_switch_decoder_release(struct device *dev)
+{
+	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(dev);
+
+	__cxl_decoder_release(&cxlsd->cxld);
+	kfree(cxlsd);
 }
 
 static const struct device_type cxl_decoder_endpoint_type = {
@@ -250,13 +267,13 @@ static const struct device_type cxl_decoder_endpoint_type = {
 
 static const struct device_type cxl_decoder_switch_type = {
 	.name = "cxl_decoder_switch",
-	.release = cxl_decoder_release,
+	.release = cxl_switch_decoder_release,
 	.groups = cxl_decoder_switch_attribute_groups,
 };
 
 static const struct device_type cxl_decoder_root_type = {
 	.name = "cxl_decoder_root",
-	.release = cxl_decoder_release,
+	.release = cxl_switch_decoder_release,
 	.groups = cxl_decoder_root_attribute_groups,
 };
 
@@ -271,15 +288,29 @@ bool is_root_decoder(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
 
+static bool is_switch_decoder(struct device *dev)
+{
+	return is_root_decoder(dev) || dev->type == &cxl_decoder_switch_type;
+}
+
 struct cxl_decoder *to_cxl_decoder(struct device *dev)
 {
-	if (dev_WARN_ONCE(dev, dev->type->release != cxl_decoder_release,
+	if (dev_WARN_ONCE(dev,
+			  !is_switch_decoder(dev) && !is_endpoint_decoder(dev),
 			  "not a cxl_decoder device\n"))
 		return NULL;
 	return container_of(dev, struct cxl_decoder, dev);
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_decoder, CXL);
 
+static struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, !is_switch_decoder(dev),
+			  "not a cxl_switch_decoder device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_switch_decoder, cxld.dev);
+}
+
 static void cxl_ep_release(struct cxl_ep *ep)
 {
 	if (!ep)
@@ -1129,7 +1160,7 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_dport_by_dev, CXL);
 
-static int decoder_populate_targets(struct cxl_decoder *cxld,
+static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 				    struct cxl_port *port, int *target_map)
 {
 	int i, rc = 0;
@@ -1142,17 +1173,17 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 	if (list_empty(&port->dports))
 		return -EINVAL;
 
-	write_seqlock(&cxld->target_lock);
-	for (i = 0; i < cxld->nr_targets; i++) {
+	write_seqlock(&cxlsd->target_lock);
+	for (i = 0; i < cxlsd->nr_targets; i++) {
 		struct cxl_dport *dport = find_dport(port, target_map[i]);
 
 		if (!dport) {
 			rc = -ENXIO;
 			break;
 		}
-		cxld->target[i] = dport;
+		cxlsd->target[i] = dport;
 	}
-	write_sequnlock(&cxld->target_lock);
+	write_sequnlock(&cxlsd->target_lock);
 
 	return rc;
 }
@@ -1179,13 +1210,27 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 {
 	struct cxl_decoder *cxld;
 	struct device *dev;
+	void *alloc;
 	int rc = 0;
 
 	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
 		return ERR_PTR(-EINVAL);
 
-	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
-	if (!cxld)
+	if (nr_targets) {
+		struct cxl_switch_decoder *cxlsd;
+
+		alloc = kzalloc(struct_size(cxlsd, target, nr_targets), GFP_KERNEL);
+		cxlsd = alloc;
+		if (cxlsd) {
+			cxlsd->nr_targets = nr_targets;
+			seqlock_init(&cxlsd->target_lock);
+			cxld = &cxlsd->cxld;
+		}
+	} else {
+		alloc = kzalloc(sizeof(*cxld), GFP_KERNEL);
+		cxld = alloc;
+	}
+	if (!alloc)
 		return ERR_PTR(-ENOMEM);
 
 	rc = ida_alloc(&port->decoder_ida, GFP_KERNEL);
@@ -1196,8 +1241,6 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	get_device(&port->dev);
 	cxld->id = rc;
 
-	cxld->nr_targets = nr_targets;
-	seqlock_init(&cxld->target_lock);
 	dev = &cxld->dev;
 	device_initialize(dev);
 	lockdep_set_class(&dev->mutex, &cxl_decoder_key);
@@ -1222,7 +1265,7 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 
 	return cxld;
 err:
-	kfree(cxld);
+	kfree(alloc);
 	return ERR_PTR(rc);
 }
 
@@ -1236,13 +1279,18 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
  * firmware description of CXL resources into a CXL standard decode
  * topology.
  */
-struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
-					   unsigned int nr_targets)
+struct cxl_switch_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
+						  unsigned int nr_targets)
 {
+	struct cxl_decoder *cxld;
+
 	if (!is_cxl_root(port))
 		return ERR_PTR(-EINVAL);
 
-	return cxl_decoder_alloc(port, nr_targets);
+	cxld = cxl_decoder_alloc(port, nr_targets);
+	if (IS_ERR(cxld))
+		return ERR_CAST(cxld);
+	return to_cxl_switch_decoder(&cxld->dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
 
@@ -1257,13 +1305,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
  * that sit between Switch Upstream Ports / Switch Downstream Ports and
  * Host Bridges / Root Ports.
  */
-struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
-					     unsigned int nr_targets)
+struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
+						    unsigned int nr_targets)
 {
+	struct cxl_decoder *cxld;
+
 	if (is_cxl_root(port) || is_cxl_endpoint(port))
 		return ERR_PTR(-EINVAL);
 
-	return cxl_decoder_alloc(port, nr_targets);
+	cxld = cxl_decoder_alloc(port, nr_targets);
+	if (IS_ERR(cxld))
+		return ERR_CAST(cxld);
+	return to_cxl_switch_decoder(&cxld->dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
 
@@ -1320,7 +1373,9 @@ int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
 
 	port = to_cxl_port(cxld->dev.parent);
 	if (!is_endpoint_decoder(dev)) {
-		rc = decoder_populate_targets(cxld, port, target_map);
+		struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(dev);
+
+		rc = decoder_populate_targets(cxlsd, port, target_map);
 		if (rc && (cxld->flags & CXL_DECODER_F_ENABLE)) {
 			dev_err(&port->dev,
 				"Failed to populate active decoder targets\n");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fd02f9e2a829..7525b55b11bb 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -220,7 +220,7 @@ enum cxl_decoder_type {
 #define CXL_DECODER_MAX_INTERLEAVE 16
 
 /**
- * struct cxl_decoder - CXL address range decode configuration
+ * struct cxl_decoder - Common CXL HDM Decoder Attributes
  * @dev: this decoder's device
  * @id: kernel device name id
  * @hpa_range: Host physical address range mapped by this decoder
@@ -228,10 +228,7 @@ enum cxl_decoder_type {
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
  * @flags: memory type capabilities and locking
- * @target_lock: coordinate coherent reads of the target list
- * @nr_targets: number of elements in @target
- * @target: active ordered target list in current decoder configuration
- */
+*/
 struct cxl_decoder {
 	struct device dev;
 	int id;
@@ -240,12 +237,22 @@ struct cxl_decoder {
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;
 	unsigned long flags;
+};
+
+/**
+ * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
+ * @cxld: base cxl_decoder object
+ * @target_lock: coordinate coherent reads of the target list
+ * @nr_targets: number of elements in @target
+ * @target: active ordered target list in current decoder configuration
+ */
+struct cxl_switch_decoder {
+	struct cxl_decoder cxld;
 	seqlock_t target_lock;
 	int nr_targets;
 	struct cxl_dport *target[];
 };
 
-
 /**
  * enum cxl_nvdimm_brige_state - state machine for managing bus rescans
  * @CXL_NVB_NEW: Set at bridge create and after cxl_pmem_wq is destroyed
@@ -363,10 +370,10 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
-struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
-					   unsigned int nr_targets);
-struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
-					     unsigned int nr_targets);
+struct cxl_switch_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
+						  unsigned int nr_targets);
+struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
+						    unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
 int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 7a08b025f2de..68288354b419 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -451,9 +451,15 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 		struct cxl_decoder *cxld;
 		int rc;
 
-		if (target_count)
-			cxld = cxl_switch_decoder_alloc(port, target_count);
-		else
+		if (target_count) {
+			struct cxl_switch_decoder *cxlsd;
+
+			cxlsd = cxl_switch_decoder_alloc(port, target_count);
+			if (IS_ERR(cxlsd))
+				cxld = ERR_CAST(cxlsd);
+			else
+				cxld = &cxlsd->cxld;
+		} else
 			cxld = cxl_endpoint_decoder_alloc(port);
 		if (IS_ERR(cxld)) {
 			dev_warn(&port->dev,

