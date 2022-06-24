Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857FE558D8A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiFXCsg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiFXCsf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:48:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3285D103;
        Thu, 23 Jun 2022 19:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038913; x=1687574913;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BK7Lmh+TW+KuoD+jkDCWgYnfc7Ds2V2TW7nI4ggT+0Y=;
  b=VnoZOAwcebny6dnPwVFPA9ctC9nXV/5LwIvi58nXGTwM3wzDAVnoORjY
   OYemStoZOsqw0GGXFS71/rbYkApXoZVMWmlN9qN1h9QFM7BS+c+0F9q9D
   +W/Ez35Cy/rg/VtAlbD9hGLcU+SNFfsI6UnGd3bwQBCM3RSZK+X10i11H
   A6o6WzyjDg++ECVukBTzssPijHTFEuqUx6+WY3IOd8AQEfXgrVYkpcg69
   Nxdie6iua+q2DGQ7F5cc5Q5z0igqnuh65KNb3D4BRqWz8d7Ugmx/pEG8p
   hw1pb1PrRANuBGLvqKhZNsH+/8TngIjVpgxL+O7FjizZPWVJZiW0yx/6C
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="281986624"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="281986624"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:48:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="586414218"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 23 Jun 2022 19:48:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:48:32 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:48:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:48:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:48:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdRms7EfRIpp/wThe400xupEpeHFaq30YpE5R2pYenz4UUp1jYmHj6I644rNtVTBboLeiI0pwX3kMuL+sKWDg4NEsokJv218+I+Hjm6WqUhuGo5SE9fqUTFpFO2hZpxE+8nEBMnv849FsQTkw0SXOdVofhiK5hNUlYdcuX8mItYIwIg8UIx9yYI9pq7xd1SjhqHW69sgZ/ssKwdAksm4uN0NTCljplC7+sVHf0MkH7U5nyFRoNmMePWNQHr11+tNP3ZnjkKMYaZSET1RqafZ0zA7VkKtmMQx/iFHn2ylqYBviE5fOqZHi4G6HLreQr3cm8ImqFXWd3PJJWv6lylu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnUc1e8up8Ll7zTD2OMdjn0ASnEOq76sIVLkciQIti0=;
 b=RoqU58/aar9lXj1If+aYescSPawFNJ7KodzwxKw9DJDUGog87DYjOQAigRYQRAwtqa4uUKU5TTcnLmZvSNf6/H9iqnS4eTCWgEGzMXKXcERc21onK1RAEI1rhsme+DSmzzNFb4ypEbuCGBPiUN2XZl23s9zIgNm9O5ezVxLM4GDKlaMPp8/G+gsN8fm2ZTqoWQ3ITmy6QahmF2eKOa4hUuqZ7m6xfB3W5PkKJG0npwqo5qvoFasDaMuWP9AT9Okiktz6qnwGGATwTww5ePLYCJlFdBnkR8cIiixY/rlee/Ro8ajLSrl9K3SHLwzytRJR4isH1bkFt28QdVjmGiXPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB1876.namprd11.prod.outlook.com
 (2603:10b6:404:ff::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 02:48:25 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:48:25 +0000
Date:   Thu, 23 Jun 2022 19:48:07 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 25/46] cxl/port: Record dport in endpoint references
Message-ID: <165603888756.551046.17250550519692729454.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MW4PR04CA0147.namprd04.prod.outlook.com
 (2603:10b6:303:84::32) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84417fa5-4308-4e7a-babf-08da558bf8ff
X-MS-TrafficTypeDiagnostic: BN6PR11MB1876:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLWAakmekN7u2EH1HIifGc5th2gbebI+u/mxqC57KxWrbloPdmm5IXNjf5kC9Am2qSySQiCUwRtiXj8h/R0jk8gIE1pWSLSJ+2SttIQYD67/T4M1iWHaUE1p46jWbMERMKpyfQeRgs47nIwCH7SyavICBTsk1abSxKximOAP5eoJU8HvhDpyTKu1AlYJIcBFaaEyBmtXcyH9v8N01s4wiYxSuf0rXchL0ovq38AOWxqxvJplg7aVuP7EOqSwricSbHVADJa7IZqN3fu9sngjLiNtBxQd7xwMZgmupLk/640cqnW0BEkZjn2jtQ5hjeGYiy24AZxi4i45x3Tgs+1pvqiUhjfu7+oJpiZSUfKAOzSWzM1pn5TlWruO9Tfjl3jL9mv/cWPRHwDPMLCx8HXUd3SgWSdvqAWN8W0s5F6KtZ7AVd0j/QKqvRLzE+ZxJb0Uf/Lbx2Rd7aOO+VIYwBRFlS/mU7RQyJkAktoIaqxTsB4zF30gvtUk7mIITpQ2Y8aSEB2ebnegN6ei3jNmqRmA+hlcCgQwMXStlqZN+ph7IpTOQCeVBWiwWTw/n72oz4bsfSw1ZDKA3sxu9jxTpnbUmX9WamJs/5dMtwflAD/88YknLqgyBSbOPqWEp7ayuqacHjs8JV9m/v6y6rpveTrh3igLVF3tql0KebKTLLb/BAYc2ZOxBeYxVdLipAyb33iEwRokvX6uVvl3wM0/FIRTwlIws8PQdRj+8USoSFs9HzFOmi6fpVSf28X2+XyKqYGt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(376002)(136003)(396003)(366004)(103116003)(9686003)(6916009)(316002)(5660300002)(6666004)(66476007)(2906002)(86362001)(41300700001)(26005)(82960400001)(6486002)(6512007)(478600001)(66556008)(38100700002)(83380400001)(6506007)(186003)(4326008)(66946007)(33716001)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nMtb7z+xtd5zr8JXjO0hWs5oJ0qVsN9iphvbnJk1Xbqf964LeGFP7p0BeZ7q?=
 =?us-ascii?Q?XpSGfhhuJrWQPUWJ/lylo2UhQS43omXGRmlESC2nFETbA1SDEOjZAgQNMuoS?=
 =?us-ascii?Q?4RWkHkb36Tapr5Pr+jBqfLvMTVx4t+jl/ZzBwQsKmhXRF47i3BdwBbzpqg8F?=
 =?us-ascii?Q?LQZRKZeurnDO8BR9iZfFm+RwUTmU0idlO2lOanKy63sQNNtXsjo1CPMRQxEz?=
 =?us-ascii?Q?oKvgGpIij+sYM9WMR8Skf8zAL2F41QP+VFo38Jiv/w0ju4kXPdLYj3sCpVKf?=
 =?us-ascii?Q?Y+G+79FY+rpVHzCDUeed4hU8Fqk4muRlgSAtwg1lYAljqGboAf8EXrHUlxEK?=
 =?us-ascii?Q?kL0hD0sEyKpZBDX4ZwP/gS43w53UxcdOYHm3C4m7hlr2FlmWhqdozYtyG4hk?=
 =?us-ascii?Q?cxTmnUXC6EYnNUvvQ5xozRRJfzZY3W8/j+5cviN3t0k0af6hxUETPhvjKanb?=
 =?us-ascii?Q?/AW2h8GivQmgAO3YzZLjZ5zsYB+AzDqwRGcS4nzNt7kmifHmxBu+iboJBkb3?=
 =?us-ascii?Q?mNiasr50USsWP35FlJ1GTVR8zkCKfTRdwA+lxw72ylVtAhUcvrKCM49N10gC?=
 =?us-ascii?Q?+j6ISz0QS3qhnMi5DiEl1YdAA5dEI4Yp/0xTIz3ibTGvysyZFr7VuTgAOQGO?=
 =?us-ascii?Q?BOfvMzrVDNzzTms9IDSZ4Vh0G8UyqUhDU2x6glx+brPiBGgxhvMoJYAp1Y1e?=
 =?us-ascii?Q?mwQZH2dWrXuqW1te38yxCfQQCn8keuegqvtKmiS8deja8TxcENiz6dbwlhrW?=
 =?us-ascii?Q?Nx/EG62OJmhHVgbNxAjS4jv92WEek5ym7LGmfkGy7EHrjRu0fyWJO5r1qlPC?=
 =?us-ascii?Q?b857ipbSbitWFSazezPqssmGdN9dlLnWqbIdA0iNCQSE/pOOWzDWfMymM38+?=
 =?us-ascii?Q?SazvXdZ0WL6BGxOBI0lxNIsbSjjg9zVEXYkk7tBRn8Yh3MQSoAZrJ74f1VsO?=
 =?us-ascii?Q?cJ4ivQBeFAtiPQMb2JYSBLI7a9YescFH04FFarpZJYdXv2flSvGMh8QhCZf8?=
 =?us-ascii?Q?XMPikmXBtIIgo0A6b01xELzVqgUQ6JgKghbP++MLKxMKcNr7x7bdMQVoIWRl?=
 =?us-ascii?Q?2rgy+u8srzrbgIShKTG0t16MreS2RG2vzBq7ydONQ79XI8vfkolmLiRCOAMJ?=
 =?us-ascii?Q?P5z5X8y0diXvwX0g0/KUuVIuc+xbLghZTupoR5UpgbSk6Q5RBTmNpXL7GnRA?=
 =?us-ascii?Q?ypHY6AXXso3nK4+ksAPpYaXe7Qeo9MS8gGoDFO3XfpXwIYfaBnDHBd3hKFD9?=
 =?us-ascii?Q?5IPogCXJ3wzAvxc3yGXnGKJpX+NVTtMSmGrytcGWGKMnyO59b/1jCJgrRo3X?=
 =?us-ascii?Q?UFlUh8U3H4svdj5O7EWG27EBUHHpEXnDy39rUfbVF8HA34JPgRJHG8tOkU3s?=
 =?us-ascii?Q?RO3loLnOJB5ZECNXb4BFd1AInqh4J/a38v+lQvc1YZjm9a9/1aSCmd9xn3tL?=
 =?us-ascii?Q?cwoi3LplwuIMsNP3QDFNbtrOOC7fvEho7UsnZMjrXcBho02yHu52aF11yqYj?=
 =?us-ascii?Q?HJ0pJB17JDX+9/BmqNT1lW9gpjhGQJBBGDEtxcKIZ2u1BRXmkT6b35qznmHQ?=
 =?us-ascii?Q?chs4atyfsE4+OwGcW3rxLhW+5gG4RURCb5MTBtisfvAHK8fNkkw7LQ0pS+lF?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84417fa5-4308-4e7a-babf-08da558bf8ff
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:48:09.3920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6A8Ffnye5NSr7E3C6ZfHhH5vq9lxxsuwowzhmFFEJe3os4rbGVGQqBH/aSJcbW0KWg0wKVegiBZ2dmpdhEHCgXhHatc9smk8NCYqd9ORoYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1876
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

Recall that the primary role of the cxl_mem driver is to probe if the
given endoint is connected to a CXL port topology. In that process it
walks its device ancestry to its PCI root port. If that root port is
also a CXL root port then the probe process adds cxl_port object
instances at switch in the path between to the root and the endpoint. As
those cxl_port instances are added, or if a previous enumeration
attempt already created the port a 'struct cxl_ep' instance is
registered with that port to track the endpoints interested in that
port.

At the time the cxl_ep is registered the downstream egress path from the
port to the endpoint is known. Take the opportunity to record that
information as it will be needed for dynamic programming of decoder
targets during region provisioning.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |   52 ++++++++++++++++++++++++++++++++---------------
 drivers/cxl/cxl.h       |    2 ++
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 4e4e26ca507c..c54e1dbf92cb 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -866,8 +866,9 @@ static struct cxl_ep *find_ep(struct cxl_port *port, struct device *ep_dev)
 	return NULL;
 }
 
-static int add_ep(struct cxl_port *port, struct cxl_ep *new)
+static int add_ep(struct cxl_ep *new)
 {
+	struct cxl_port *port = new->dport->port;
 	struct cxl_ep *dup;
 
 	device_lock(&port->dev);
@@ -885,14 +886,14 @@ static int add_ep(struct cxl_port *port, struct cxl_ep *new)
 
 /**
  * cxl_add_ep - register an endpoint's interest in a port
- * @port: a port in the endpoint's topology ancestry
+ * @dport: the dport that routes to @ep_dev
  * @ep_dev: device representing the endpoint
  *
  * Intermediate CXL ports are scanned based on the arrival of endpoints.
  * When those endpoints depart the port can be destroyed once all
  * endpoints that care about that port have been removed.
  */
-static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
+static int cxl_add_ep(struct cxl_dport *dport, struct device *ep_dev)
 {
 	struct cxl_ep *ep;
 	int rc;
@@ -903,8 +904,9 @@ static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
 
 	INIT_LIST_HEAD(&ep->list);
 	ep->ep = get_device(ep_dev);
+	ep->dport = dport;
 
-	rc = add_ep(port, ep);
+	rc = add_ep(ep);
 	if (rc)
 		cxl_ep_release(ep);
 	return rc;
@@ -913,11 +915,13 @@ static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
 struct cxl_find_port_ctx {
 	const struct device *dport_dev;
 	const struct cxl_port *parent_port;
+	struct cxl_dport **dport;
 };
 
 static int match_port_by_dport(struct device *dev, const void *data)
 {
 	const struct cxl_find_port_ctx *ctx = data;
+	struct cxl_dport *dport;
 	struct cxl_port *port;
 
 	if (!is_cxl_port(dev))
@@ -926,7 +930,10 @@ static int match_port_by_dport(struct device *dev, const void *data)
 		return 0;
 
 	port = to_cxl_port(dev);
-	return cxl_find_dport_by_dev(port, ctx->dport_dev) != NULL;
+	dport = cxl_find_dport_by_dev(port, ctx->dport_dev);
+	if (ctx->dport)
+		*ctx->dport = dport;
+	return dport != NULL;
 }
 
 static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
@@ -942,24 +949,32 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev)
+static struct cxl_port *find_cxl_port(struct device *dport_dev,
+				      struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
+		.dport = dport,
 	};
+	struct cxl_port *port;
 
-	return __find_cxl_port(&ctx);
+	port = __find_cxl_port(&ctx);
+	return port;
 }
 
 static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
-					 struct device *dport_dev)
+					 struct device *dport_dev,
+					 struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
 		.parent_port = parent_port,
+		.dport = dport,
 	};
+	struct cxl_port *port;
 
-	return __find_cxl_port(&ctx);
+	port = __find_cxl_port(&ctx);
+	return port;
 }
 
 /*
@@ -1044,7 +1059,7 @@ static void cxl_detach_ep(void *data)
 		if (!dport_dev)
 			break;
 
-		port = find_cxl_port(dport_dev);
+		port = find_cxl_port(dport_dev, NULL);
 		if (!port)
 			continue;
 
@@ -1119,6 +1134,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	struct device *dparent = grandparent(dport_dev);
 	struct cxl_port *port, *parent_port = NULL;
 	resource_size_t component_reg_phys;
+	struct cxl_dport *dport;
 	int rc;
 
 	if (!dparent) {
@@ -1132,7 +1148,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		return -ENXIO;
 	}
 
-	parent_port = find_cxl_port(dparent);
+	parent_port = find_cxl_port(dparent, NULL);
 	if (!parent_port) {
 		/* iterate to create this parent_port */
 		return -EAGAIN;
@@ -1147,13 +1163,14 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		goto out;
 	}
 
-	port = find_cxl_port_at(parent_port, dport_dev);
+	port = find_cxl_port_at(parent_port, dport_dev, &dport);
 	if (!port) {
 		component_reg_phys = find_component_registers(uport_dev);
 		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
 					 component_reg_phys, parent_port);
+		/* retry find to pick up the new dport information */
 		if (!IS_ERR(port))
-			get_device(&port->dev);
+			port = find_cxl_port_at(parent_port, dport_dev, &dport);
 	}
 out:
 	device_unlock(&parent_port->dev);
@@ -1163,7 +1180,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	else {
 		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
 			dev_name(&port->dev), dev_name(port->uport));
-		rc = cxl_add_ep(port, &cxlmd->dev);
+		rc = cxl_add_ep(dport, &cxlmd->dev);
 		if (rc == -EEXIST) {
 			/*
 			 * "can't" happen, but this error code means
@@ -1197,6 +1214,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 	for (iter = dev; iter; iter = grandparent(iter)) {
 		struct device *dport_dev = grandparent(iter);
 		struct device *uport_dev;
+		struct cxl_dport *dport;
 		struct cxl_port *port;
 
 		if (!dport_dev)
@@ -1212,12 +1230,12 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
 			dev_name(iter), dev_name(dport_dev),
 			dev_name(uport_dev));
-		port = find_cxl_port(dport_dev);
+		port = find_cxl_port(dport_dev, &dport);
 		if (port) {
 			dev_dbg(&cxlmd->dev,
 				"found already registered port %s:%s\n",
 				dev_name(&port->dev), dev_name(port->uport));
-			rc = cxl_add_ep(port, &cxlmd->dev);
+			rc = cxl_add_ep(dport, &cxlmd->dev);
 
 			/*
 			 * If the endpoint already exists in the port's list,
@@ -1258,7 +1276,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
 
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd)
 {
-	return find_cxl_port(grandparent(&cxlmd->dev));
+	return find_cxl_port(grandparent(&cxlmd->dev), NULL);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d8edbdaa6208..e654251a54dd 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -363,10 +363,12 @@ struct cxl_dport {
 /**
  * struct cxl_ep - track an endpoint's interest in a port
  * @ep: device that hosts a generic CXL endpoint (expander or accelerator)
+ * @dport: which dport routes to this endpoint on this port
  * @list: node on port->endpoints list
  */
 struct cxl_ep {
 	struct device *ep;
+	struct cxl_dport *dport;
 	struct list_head list;
 };
 

