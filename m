Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B407558D50
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiFXCpO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiFXCpN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:45:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D592F522D3;
        Thu, 23 Jun 2022 19:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038712; x=1687574712;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dRj4P82OnytqCwrJAeegbI/5GTXNErF9xp1XTUwfQzA=;
  b=OhFcx9CMmbMUub1//mJAPju7aURCES9l6C09cjHDR7RuAUNKcXDXOpyz
   Jee2koTsAbPATdBPKsMN4jPAQ3GoSk8Z04eq4LvzH7mt/5UAljx/m0qbz
   ywzsxhDm8MndVkza91yKqhi23n/qV5XgVypAwNsrXPEHm8Fvglaqqtwew
   VhLQdNWMkufiRMnZEvOBo4ZDXx4j/SvKThFbo0WTeHRFg1Cxf2L6NgoMt
   jE81b+E71mnXLfTurT5R9YRP2AnYQlT3R6olqu1ls6FBERdCi+ZbIEHGl
   qILH04Gm4QbiqT9VF2LptKBUX2FSvdrjXcfQm/t5a4F6/HBHmzhJKkUfe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="306369860"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="306369860"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="678351319"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2022 19:45:12 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:12 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:45:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1QLWKTDVnKvt7Eh5R73L0y8zM/sQh5oR0RTnfWcrflEzY9MfVsI6k60Y+Mfh/UALp+Yk7Mqx8pwHYCKMkKj3bom2sPgMSN9UZIYpMG8h45EwvIWqPisd237/EXGB5Y1YvpWP4IpoZH22XzKHYjwXO4S3lhIm6EXJlJXTqE5fmVk/TT83t3IiPboJKPxGLwk3nYdBFi5icVzRoL9l0qhheMZSQn02MHvODVusMMZeynbxrADj4k018gld2/yUUZzHsu6EN4d5ja65SosffvruGz32VYbK6wLQfi2qRXznHLOMBHPuuFdjdqqeGgUQ5LZrXqOc2XUDTdIcGfluecjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9+5F/gXJ/1G9PFHiwabwJjHWmnQFfGv5UHF0uA7lNE=;
 b=HxJ6CqyVBM+qYZb7pwc1Z8wqJwV6uXsD2DmlgTT2v9yy5AnWVK73K3F/ZDONuk1bb6ZIaalgAuHP/oSK6qDsZDCScULU+DZTM6BNLszPsBsqJ07h9sWHpV/c/YfYo9ZLC0qFLkOdV7dX/TmEhNHTiMows4CSnviQswBmxRKUZWK98dWFV6csE4vra2UL1wapS1OahoCGWvG8M9JsOvrKpDkWjxJ0vLsP1KN9B0TgBLgkEwLHG7TpNKGKMfP1bNyRgAIvjExvlGYCzurnPji8+HSPJ9HpCw5N/Wcla5KKy7Tvn6DZpv0x431bJ0m0bsCXSfwxBX0kiGVvKxlVRFLPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM5PR11MB1993.namprd11.prod.outlook.com
 (2603:10b6:3:12::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Fri, 24 Jun
 2022 02:45:09 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:45:09 +0000
Date:   Thu, 23 Jun 2022 19:45:07 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 01/46] tools/testing/cxl: Fix cxl_hdm_decode_init() calling
 convention
Message-ID: <165603870776.551046.8709990108936497723.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: CO2PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:104:5::12) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57c2972c-4812-4f98-2201-08da558b8df4
X-MS-TrafficTypeDiagnostic: DM5PR11MB1993:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zwo8vvfMQEwQMMYgGW5fQzNRhlAJv94HgG/tm1C8GvsASA3JEjh39UVTbghr8TyTt93FcuvJAa9rDCGdclyzO9aqUMp8rGllixoq1AD+714/9Ke2e3/MXDuga5dUuINpHrGoP9S19aAeyTTWQWiBL1/+95CKDt2vmw+GW2W6Isa+DourJHR01fmXZZ6zkOLaOzCMCnNZtWTKCfXbihTKoKTvnpg+JXhrGvT31QfsXCMswYrSix/eDqvjDDay7ozFrMXwPJOVkYKGcEvsOxT2gx6QNRxYbn/TDBGrj2f1Gl/SjdieHsKZxOTUF4QcvDtsqhkY5HcUXruMY8h9HKZ3XIn29w+yaZhSWOCaIaDOfE6s9MdgO0B6uVrvyvi6u912daLgW4ErOvLLMsvExVnUPNCyYYx8f295z7nrRkZzwLM2Y63ChlGpEc7ewe0QR+8sKkqhD7xqhd5fJkCY3Gz0Fn/UqF13KkZkXPUMxs9h6dwBwgo+yowaYmeKlJVJLLYW8C1qnKF+GjEgLKd5zxImr1jJV6ot2g+tJiaOApMugnsY8THeTW+HOlhMG2GBo5IMPAv3x6NzCZ8ky1pBtg2UX4YHmiqmcGV14Id2NWzg5MTxyDtbM9GX3Hgq3Vpd6O69+ujx7oXf25JXxY5HC50enV+6S1l9GF41rYQQ5w6w+bcg92DRp++5aLaAIzYKmRXzRWm+q2hFWNtB9RK01XqZTUaNisJlPfk3XVKFh1eXV3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(376002)(396003)(346002)(136003)(39860400002)(6506007)(6486002)(2906002)(41300700001)(478600001)(66476007)(316002)(9686003)(4326008)(103116003)(8676002)(66556008)(86362001)(33716001)(6916009)(66946007)(6512007)(26005)(83380400001)(38100700002)(8936002)(186003)(82960400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l3TGmcFUQWD4z44/WE6oa4lvIj4hotjRGQAPGKPy5ktU1lbuF5IyOkkdjjq0?=
 =?us-ascii?Q?Js52dN1T1jv+U1hGONKrQrJZFJ7lPOboSbFDAER3B0ko+60HlkuzyrKCt6GV?=
 =?us-ascii?Q?Sudf7tCUyWEDth48F2gJoV4G8D0ET+Sc9Feo2jMhD9nbLkPn/9sbST/yMCUZ?=
 =?us-ascii?Q?uyKko5Ib+1pg2/13/nKjQvG7aEud0MBJuhx4qi+WhjeFqlm6NbVxRIQO6htz?=
 =?us-ascii?Q?FJnCHjKqBF2kyEGAdzC+8QAyZqZ0ClkjhC6Cqi3zYk//lLtUPyc+2/RV6cOW?=
 =?us-ascii?Q?GvDPhHVgKO7Ds4Fkiohh5FO8tFJy80bRpDjm/ZdMOn629rgzP3mD4YmGR42m?=
 =?us-ascii?Q?qbyeyg2anzjrP0VFcmlcuANnV9JWRv5Z2w5zkN94+oRT2kORL2q8litujP0w?=
 =?us-ascii?Q?DP9+0UoT3LJtFrFW7BxTTJB1Cs+culS4NnQ0+et/PwF6RyOx0vTs2qCXUNMb?=
 =?us-ascii?Q?Hj84WAycAXadBRIFuof7Qi2Ma5AJdUelS/5MnUgiGQgGxoDCnbc4/CgQMJru?=
 =?us-ascii?Q?Vr+XJTw/z/seEUbEpSHxVQnC1PExDdgdiwfwW9NBxxOmv7jSmX3NP79dxPA5?=
 =?us-ascii?Q?EgS+680Dl2+SHA/PchU90hvVuAJ/ULzObwx6bs+o33LIhll80Kualdup04ka?=
 =?us-ascii?Q?1j7q1qeujKSqegZ53mOlRkAVsjjBTENj+aa0eUENMK9rCHbE057C6uwnoc18?=
 =?us-ascii?Q?TGLi4f/X249wc1qbBLylPtZAV5hOOeWY2gNjdVzxGno89G3c+Dx1j8sz9Jl7?=
 =?us-ascii?Q?97bPW70ecOjfjZW4+N8HFl+iNOwEaW4+VIh0OQeCzAKLpduJK3JuAa5k56+z?=
 =?us-ascii?Q?LJvZfaoFVyjXFe8uplt07T7BE06abP/jiKYKo9uim9rRsOu7jwC5H/HJr3/t?=
 =?us-ascii?Q?wL2TzgU2HPOxtZ5rcJZScxHROzNue5ZwIIVTFxhcrGpGFMa7QfvsNA5Vri3W?=
 =?us-ascii?Q?0eDGrYdxzI9h2oUiszYW7h/LHRcmdJ1Hm1iQkgmtSNZoP+Ynpkne5qw1/BDE?=
 =?us-ascii?Q?6AImqwzsu8z5rHm1vYpPdm+51qogioqxKdT4RpeY0xixkuBurJDiTj0DTuOH?=
 =?us-ascii?Q?F5ML1qrmHil4xTJTrZedOx5vz815uyXlwhcKMMoAmZQA39cfnGlYfghFMbka?=
 =?us-ascii?Q?RbDLyhhv1QgDKrKolGZZwHRWJbB/zYuWkGA/rrSb1uq1pGbnc+NlbaF8xD7R?=
 =?us-ascii?Q?B3XvymcxGG5kXFqGEuxTMIz2bwVpKgmRh8nxAtcAmIwma/LrcGq86jOcNYlx?=
 =?us-ascii?Q?xjXbwLJOc0sJy9CeqBRD3iXAPFLE5Gmflmeh5KLviI8xNd2R0mYBPiWA+WL9?=
 =?us-ascii?Q?FmtiLmnI0Ck8DVNR8XXmIBU5cRAD3z1JAYftgQXu89Dnp/PA+s9DeI0ugctp?=
 =?us-ascii?Q?Q2bfmxGUjQChj1YTJ+nJLw2EaWZuH8mPES6nHaLVePYSIJBDsXfXtTYuMVRw?=
 =?us-ascii?Q?YTWubgxHeWbwDeen0nTjHAiSng/HR0II3KSdxmqAS3N4BhU5R7wK89aWOfSr?=
 =?us-ascii?Q?P2A1Iw5CFGwF/4MwdNrSeAj/IqYxZJVSnF/M32GzwCnsh4AXZrJzAzB6aboT?=
 =?us-ascii?Q?EXdhUP2uGKzI7NiI0cuXxyIN76co5j5+BWheApMw2svnXPiD8VeSpsTuuaZY?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c2972c-4812-4f98-2201-08da558b8df4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:45:09.8154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RRNjwWsKa8ox89e4wk3x6Vqx6kdFTbq0u8FMdhC4qksUlQV/gyLjAVT2c0du/i6YEcvrj8a5F56ZDquDV3Jh8gqV/WOmwlxbXBsz1JliBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1993
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

This failing signature:

[    8.392669] cxl_bus_probe: cxl_port endpoint2: probe: 970997760
[    8.392670] cxl_port: probe of endpoint2 failed with error 970997760
[    8.392719] create_endpoint: cxl_mem mem0: add: endpoint2
[    8.392721] cxl_mem mem0: endpoint2 failed probe
[    8.392725] cxl_bus_probe: cxl_mem mem0: probe: -6

...shows cxl_hdm_decode_init() resulting in a return code ("970997760")
that looks like stack corruption. The problem goes away if
cxl_hdm_decode_init() is not mocked via __wrap_cxl_hdm_decode_init().

The corruption results from the mismatch that the calling convention for
cxl_hdm_decode_init() is:

int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)

...and __wrap_cxl_hdm_decode_init() is:

bool __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)

...i.e. an int is expected but __wrap_hdm_decode_init() returns bool.

Fix the convention and cleanup the organization to match
__wrap_cxl_await_media_ready() as the difference was a red herring that
distracted from finding the bug.

Fixes: 92804edb11f0 ("cxl/pci: Drop @info argument to cxl_hdm_decode_init()")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/mock.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index f1f8c40948c5..bce6a21df0d5 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -208,13 +208,15 @@ int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_await_media_ready, CXL);
 
-bool __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
-				struct cxl_hdm *cxlhdm)
+int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
+			       struct cxl_hdm *cxlhdm)
 {
 	int rc = 0, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
-	if (!ops || !ops->is_mock_dev(cxlds->dev))
+	if (ops && ops->is_mock_dev(cxlds->dev))
+		rc = 0;
+	else
 		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
 	put_cxl_mock_ops(index);
 

