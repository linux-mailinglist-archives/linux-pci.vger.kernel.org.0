Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A96A558D73
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiFXCrn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiFXCrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:47:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40D856F8B;
        Thu, 23 Jun 2022 19:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038844; x=1687574844;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k577WlWGR8+tMsjmrBphLWB/BamMu7wSTNCexpx4R3k=;
  b=Yvx5FzFQNLjjUir5cQvAf/bZczG8+xx+ZILOnjK+QA2S7TBFog7+6ARI
   YJJ1P0WeY5ARVmKTnMM2g2kOUYHUrjx6pR6FhTkHkiLlCEIFBCrXW1KQ6
   ZP0epbyY0IkHYemw4ObRYDJxV6cOUF6K9AeayXnkbFsQgIxRCnKYnldGM
   p38Q9cvHcRS30lMv871xbmdhjaovr1ql/Jvl/0nk5U6KBnf3pntOOKVmB
   Ops3ru2/qzR4XNTwI62mVI/CgJvcwULU8ifd3a5upVOsB+Uevxj0C8tP2
   uZCwlnnYL1vge31bJKYoL81+rQITeOnn883XfmSGx1h6xSBuCpGMXXJ3B
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261331945"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="261331945"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:47:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="834933975"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 19:47:23 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:47:23 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfFb6NRtwPae/OGH+KdvvleX/rUgPvyIh4QvtPw72SjlzarUSjC62ynuoCf0njkI1APKsiDuNT8uiPX6+cPATPvCLGqXkjaFPBJ50eybd+m5wQUzUCQc+yGrTbzTVbQW6UWfa3ps7RFXicY+wXzDJMteCtYGB1FDcosN9P3HznojRZfLQ0/sakHNxwU5LifRqgU+qNAzBf3y9uaz6kMy1rB+TCDdsNnKHznV/I0O0EIRA6fd98qn5GSsqAXjbirwxgPQniqsCtwAk/P6ahWvVldrB7QYKLb16v2XES3rFtIwf0tJJouqJrQ99SiW+PSkK6jFQhgsGntK6ymPQETDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfWBfHXLVeiYVRrcD6JcrPyU4M9x3zVr5btJ4kG+YN0=;
 b=WwjOCgYEKCL4AdMsXWln1QM8yy//xWfkq6IYYdnyJHMXOZbwB1C67FLiNLIaX0GPb3Uxdjh0LWLlB5Wj8PXFBXfQ0bueTvQQkb2JblLAyBRtLAE03qkzYYdrfBgKk9arqu0WcIjSSEbpbhpuw97AosOT7NqZ1RVkSieZK6+FrJZZ/Yoj/URI+a2jpNQo8WtaR5QSuYwC5hV5UfTOSJlRZoAancLohRjZD05ujo2zDfNqCiB4RZYXdZ7GNOuYnQHduU9fyNr0OhGLtouHqMdnnDqtY1KBHzKap45KsZszIxhy56sr6IFUZkaWakQdr2cygqhV2WyGE10G81I/6hSGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:47:21 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:47:21 +0000
Date:   Thu, 23 Jun 2022 19:47:07 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 17/46] cxl/hdm: Track next decoder to allocate
Message-ID: <165603882752.551046.12620934370518380800.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MWHPR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:300:95::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94ae1edc-75dc-47e3-694a-08da558bd531
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USuMyRZSscnMNciT619PK9TmVDyCxN+1JIu/gETYCzqO1t5uycsBKgqexDMfJrvoBlMge2+eJwoxd9k/ap9MhFWT8JfRBe+niH66nl83CNX+NBl3y+9PN6rYZvfU0UoVMDrhu4GsXJaeM2cp9TgThinSa4+tdJNZvir9O8nfImMZe+8k8OVwuj6bv+Kq1xfhfa4jtZ101dhp6bl0d9fh8zmXUg0THOZN5oVtsQJGSdRiwyPTAnKJIYBW7mHcSgWaYTVr1HDuUkczXpjsJtRoUXJ0vcYtdpqhTbMrwtXDCsE8rhg1E5p8u/b0amYMQEE17SKMYH2H7Q1mrK1C3oKofc2H2/5Mwmrhs8xZHg//jid+ISWqJ/7WynkJIa6fl0CFAvSeoDKISohQGZivlHsQIZJNChX5lB9CTLJzZ4Ff5Q2ODsqbimvn4UW1O0vMXxq4lwYHNTbmBSt6tnbBwGObm2Cg35MTLggqMEoQjnDKtrwhSMGNriwmE8xZT65ep1rBB/R3S4mlFXLmkt8nxodyh/xudqyZpNmfUm31fTVqKLwndfi9jdVV8NzwQk1YBGrVN3xYAMmjXOFOT0nhe/V28iwmOW+fLTZs2ZQbs9jktvEenBXxjr74I5aTFHsjdGC2ZjfZJa8qLBGwvhFUObK+Ez9AYdSyn8zRqP9DEy2pu+fOGTxJm0UfacylFkaSgEj6kwXQhrwgceWF2RO0IW+nMcUw1i60ku9H3ZROVo28KjzjooOcwcJASkDrZrJ13CDO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(6666004)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y/v1uPS1W9ZjIhwWnrwJXkPzsJQmaZenYxHp91IXJN6HFYv6bX74KlZ62HIm?=
 =?us-ascii?Q?TvMB3MO7zOXqTaNT/uqUI6F7BnHJAA8HHFmUeElSH5kLGv0ylASSivTC4lmZ?=
 =?us-ascii?Q?e/H9WUQcA6z9w5atxNbggWtV0G3fS1u5cGKIvsEPypFeyFyCFNtIsXCEZWP4?=
 =?us-ascii?Q?ZJZoFMd4knuyHFk/6xziDB5juyNTIgnNjJBkClo0c9nlDskaV7rDjDGC92XJ?=
 =?us-ascii?Q?ypv5ytsuQ8f2A9ydO2ic8+AEkfm7E/Yju7vUpceW1XdhmPXaSDU045mqHpGV?=
 =?us-ascii?Q?ofdPI6qS6XHC2ktDlkAMhtAGFQVFtrjSAJfiheofj1WVHetzbZxLk82JiW/8?=
 =?us-ascii?Q?bJDc8MuAPREM0WLyENplEktKcLdzW/gsIPxDmTzkTKuCwt4ocbpuCsfNVmxm?=
 =?us-ascii?Q?/QY9qIoegu7Ok1O2eLSZlagDRXi9chfLTXZTe9Y4StGrSviKGo7U3O/btfzE?=
 =?us-ascii?Q?LgdmwZjA5tSdscRWt5HCALArJrFdGOTQVj9EIbiZbJ4BTCA/R/KgWeVf8pFy?=
 =?us-ascii?Q?OFiLfxEhLQOacrjvaG+aFjwD6RRgaSsJhs6Nvf0+1n6DgNaSvvA61COLouZG?=
 =?us-ascii?Q?ddsVLaaOJmtD48URGOqs+qr0vrTDsRb4mDoUAaluVHZvXwWqN8A02JimcQ/d?=
 =?us-ascii?Q?5WmBVwOTrwjAseriFytWu6NkguKQfSNVQJt2SrJu77JqH3l9iJ/YjTA19Evc?=
 =?us-ascii?Q?jHt5YvORHW0aOhRF222tQijNdYsju3UX77m9DRwbzRiC7vT/ORLB//moZqJS?=
 =?us-ascii?Q?XuRlj4e8psKcXYTWOn1O4wwlZxXaZNfeIDq/L5kHq0is+oOqYP5UrDC5j5Ab?=
 =?us-ascii?Q?LSNj3E208pnqpkRhOYILJ20fsIRyHxeBGuZGZNUjMhcoHdVGq6BUa+2fWdXX?=
 =?us-ascii?Q?qaxzmJ9Cn7TsyMVXP69AJDLSM2xnRfWNHvNwnOigZdYFjUIiM4AEQKyJzfhU?=
 =?us-ascii?Q?Z6kH+fabjqA7s5RzLgFFWyQ8lzvn3pJYlM5/XcGStkO5gwV1JwiTW6+FKi5B?=
 =?us-ascii?Q?p1NG0p75urmMeUedUEUze1cfPs05ksgCIq4X2i7MbVDQAJzxk5Z8wvK+OyEu?=
 =?us-ascii?Q?8XNQptsRHBneoP1gpnCsc36VE0NPuATcVcY3L16Bt6tgY6vE0sVw94RkNPel?=
 =?us-ascii?Q?nP5U+/esL++YrO3QYUTKArCafW/X3v3FGKKNMGkwGLTje+2cUllritIMTif5?=
 =?us-ascii?Q?nwHOFYNR95L7+qe2hWfSKc91+/Y1Fwd0Pf+Soq7krUyec71kmt/dHpmBc3ty?=
 =?us-ascii?Q?1CrlPN7Af2OY85gcYpgG1ig/vAU22DCGPoHwrDV1gajx7DOv/y9ULMiaYygC?=
 =?us-ascii?Q?IoHSWxzobAV8sisSJAreUR0F/GBzEw9BACzszMEdKNM4fIP15VWdqjr+Ymig?=
 =?us-ascii?Q?eZHjDhGkN9cLS+mkZl5g549MnkMqu734Y/85vMCWfDyPZArGT1rOia7nFb8n?=
 =?us-ascii?Q?Gp91Sy7p9E0YNvJm8WFzC8lV7OtLg1wyPlTiRWzYKuV3SULvmHDpT/DexBJJ?=
 =?us-ascii?Q?o+HLOwbMfs9eIZf3eKdVklkD3EBlZdIEkPT28CJAYsxF9tiniVFzJ1AomdGz?=
 =?us-ascii?Q?k0wTx2Du9piB8yLMWYgKmepmdRjl1ijKKOVPWRDIkfFwXxelHccyPDh7Bm6U?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ae1edc-75dc-47e3-694a-08da558bd531
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:47:09.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maNxTkRUAe4X/ZVrFUL3R96Un/byV98XSt3zkX+jJBD41TXoMu4MiMzs4sGQ+8DqbX04zSflHWQJNc0+9YJvGx9YlGrl1WvV6Jc7VVJLrEM=
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

The CXL specification enforces that endpoint decoders are committed in
hw instance id order. In preparation for adding dynamic DPA allocation,
record the hw instance id in endpoint decoders, and enforce allocations
to occur in hw instance id order.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c  |   14 ++++++++++++++
 drivers/cxl/core/port.c |    1 +
 drivers/cxl/cxl.h       |    2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 3f929231b822..8805afe63ebf 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -153,6 +153,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled, bool remove_ac
 	cxled->skip = 0;
 	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
 	cxled->dpa_res = NULL;
+	port->dpa_end--;
 }
 
 static void cxl_dpa_release(void *cxled)
@@ -183,6 +184,18 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 		return -EBUSY;
 	}
 
+	if (port->dpa_end + 1 != cxled->cxld.id) {
+		/*
+		 * Assumes alloc and commit order is always in hardware instance
+		 * order per expectations from 8.2.5.12.20 Committing Decoder
+		 * Programming that enforce decoder[m] committed before
+		 * decoder[m+1] commit start.
+		 */
+		dev_dbg(dev, "decoder%d.%d: expected decoder%d.%d\n", port->id,
+			cxled->cxld.id, port->id, port->dpa_end + 1);
+		return -EBUSY;
+	}
+
 	if (skip) {
 		res = __request_region(&cxlds->dpa_res, base - skip, skip,
 				       dev_name(dev), 0);
@@ -213,6 +226,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			cxled->cxld.id, cxled->dpa_res);
 		cxled->mode = CXL_DECODER_MIXED;
 	}
+	port->dpa_end++;
 
 	return 0;
 }
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 9d632c8c580b..54bf032cbcb7 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -485,6 +485,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	port->uport = uport;
 	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
+	port->dpa_end = -1;
 	INIT_LIST_HEAD(&port->dports);
 	INIT_LIST_HEAD(&port->endpoints);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index aa223166f7ef..d8edbdaa6208 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -326,6 +326,7 @@ struct cxl_nvdimm {
  * @dports: cxl_dport instances referenced by decoders
  * @endpoints: cxl_ep instances, endpoints that are a descendant of this port
  * @decoder_ida: allocator for decoder ids
+ * @dpa_end: cursor to track highest allocated decoder for allocation ordering
  * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
@@ -337,6 +338,7 @@ struct cxl_port {
 	struct list_head dports;
 	struct list_head endpoints;
 	struct ida decoder_ida;
+	int dpa_end;
 	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;

