Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692DD558D7E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiFXCsA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiFXCr6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:47:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47CC2DC2;
        Thu, 23 Jun 2022 19:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038876; x=1687574876;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gJJ/mGbkQsbbc0FFtPYAPalhNyTm4kuYNVZzqzJBwW8=;
  b=jZGarvxTFaZIfu/RePHQMBrRS1BsYhbe5qO9LbgLX1SAp1ZzZQIl4Nte
   jF005bQsOtO9vUqqDWNZj32Wtq3yRa7bBUn0nGVc++LIHXGk/uftyPUXH
   mfIjJ8nmdBtvfsEBUDlq09GGqIFSoo0LlxOHh6cDJ6xGoX1AQWfcJA43Y
   znbMps8rGB7jlkt5OPGIi59c6U/ck52J9OBhq4weXEdO9dznu71X8MvPS
   GvmzjFRnZc/oBEkwzNUMmc18s9a5pszV3CmW8VVeG7mFnfculJCu5aRj6
   cbiZd1/O1TnTaHkKrI/WxXsQOah+NibnlYvFMFaWQk38Xy/CuL4Yv4DN7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="306370344"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="306370344"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:47:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="716067830"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga004.jf.intel.com with ESMTP; 23 Jun 2022 19:47:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:47:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ6+KSJSJj7BhfQJcOubPNRTYJUCXvvWhyvxJZBhzLAdiCNSDFAJROMFy3qbPm3Q+QA2Wtbjt8WPq0RS4mJMHfhO74rueyMeEeXIg89UXWIgcXpbSbTiKE3lEAfueVJIzfZQelGYu6ar+7MyYFNNE14aI9XauCgVCiTxLD4VdqIaeiY2V5dVcYo4t13d39/3l/5syk7fRQS85z3ieQ3jB94sDUwsKcdgagQpSR7qMWl9qp9mTfLBPqU0reU6yLE9JHtleJGJo95liUpFJwPRrDMBrwXoPnSbrOZpO65XKOjObwhobycdFrqquTFwj6Zr9E9LyJ/fWxn6t434HJktgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g424Rh+fXPZ+YWDn7Z9CnhBLoeysNzSdZKJptuUaYH0=;
 b=mtAKidz/dpTrELswNDofED7g7vM9k34mnWIGwxwLxfqZoq0EkeldB+cLqwUtafx9xplgB0SMq58OAxIKu2OxOtpHk567Adzu6RvbWIZQoNdACKvlCSbjbQjiLWWRqSmZow7rWLpjwVILibIp/aR4U6oLCOPcTZPr9zJCvRyuKl4hTT0bCJtX+ZNLf73Z94E+Ncllp/wLcRUECEV1w6EmF2YClukaNK5J9IufX7m+HR9+oQ15R2dQMTAh4DxH2Iv+cotH4TlK/I0rbIGI8Rbe/XjHbegVRpERKqlGsIqm014w1/tOdcsAHW6SuFA3YiGA/sFobY8IfdiOY+ma9B3UwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB1876.namprd11.prod.outlook.com
 (2603:10b6:404:ff::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 02:47:53 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:47:50 +0000
Date:   Thu, 23 Jun 2022 19:47:40 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 21/46] tools/testing/cxl: Move cxl_test resources to the top
 of memory
Message-ID: <165603886021.551046.12395967874222763381.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MWHPR18CA0039.namprd18.prod.outlook.com
 (2603:10b6:320:31::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 262f64e6-1015-4568-56c3-08da558be8bd
X-MS-TrafficTypeDiagnostic: BN6PR11MB1876:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQE3EjWQCGE3/M9aZn7lHlK/ZxrJqDLR5V1t+VmE+exvbzWe7stoKfB1tpDebJAEe9mRwTkw9usgsyANt+ZExBS+rX69nsV52qfgi/Q+8XWAjcRJ0627epjQgdydg4BpvIw+VuToxIp95L1NzTsJr0bjtuPv29V76ErGYMR/VmaDD99BZFHehAmp8zpOKpTctCiHAA5JtEwVVF3acJssNMe1hNYOFf1kobYPIIzWVL0qe4SL7XHCesituNv/VSEvetBpmx5X0DSET7JYJJLZ6LgH4Av6/h2ORczpNXrOcFvNdL/5q8llfWUk/uO5A3bPyF3LAlXgpxPV6jkQifP0eBj+euVBvPXrjmTmaS07skRHCgkl3elZyd10hzehsUC1v7KEH/HTXdbyalHMsNDVr4ofWeF5DE0zlpV8tXAlNqczoZ1gYFKLdqUEu4UKaalKg5ferp4IWQ5Zcmk9ybErDTt9qwfR7y/W4vD0Ubfkhos2KI0dmpiy+C30tIF7TQmdl0Y9SifTD68eZN26o+koea6itP6EtfH3CZ/nFxeJZmCHaPBDYPm7W1B6sDU88IR7EzBykAvUhXUWpaISeUAle2mW5KV7JQTwwELm98wlA6UTZUrhYVaNJYFCkVORlH2gWaSGlkSDVrY/twTDaNCvCSYDmwrQhyjQzsebDIQAyQPtnk97uoJabOMT2ANz9onrzH1oUaRlUxnP2h8FDLzrinZ9bfTpXH2ozSNWm7CbRtIAaaq+GD3WOQyXOdUMhIgZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(376002)(136003)(396003)(366004)(103116003)(9686003)(6916009)(316002)(5660300002)(6666004)(66476007)(2906002)(86362001)(41300700001)(26005)(82960400001)(6486002)(6512007)(478600001)(66556008)(38100700002)(83380400001)(6506007)(186003)(4326008)(66946007)(33716001)(8676002)(4744005)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3L1wXKvUIDv+yXixfK2VnfTM8573LtoujgF6QX75jPb/6A+mdVKZMIfaP/+n?=
 =?us-ascii?Q?qdABbM1LRVnxRDjTDDmZ0S90d9pcqYWgDdZT8tv26ttuCKOjeJDE7bMgRrvS?=
 =?us-ascii?Q?oC0zeVH1TbYVWccZTvj1fURfNCmOU+ndoTlq1Rcx/JosQN2mXR+ctcMZTqbO?=
 =?us-ascii?Q?V9tjVQMF9oJyFpdK7qJL/kjuAlqZPbqtg/XEQCXqapW47Z+t7F6KnAdA2IZ0?=
 =?us-ascii?Q?D8IksI6Tet26Yj3nTUWhjTYHLEX9Vnt0Ba/MTlgphvsxKFO5IXc2r7EQxMCs?=
 =?us-ascii?Q?QnRyKMsGib/tdizvLQL+LySdXtf2kJ0PYroJWuYotrEcp+KGCDiuTA14JSFX?=
 =?us-ascii?Q?YadwugKLQjtjWS9+3LzUQbV2AHkawgWU+A1VvkdcLlbJ7sg0WdABhqh2bffF?=
 =?us-ascii?Q?ZSdqC9c9oQ2fiQZlspb64EV03Y/wZxcfHx2dIt35iCgYUa2PSuwNpLFKS862?=
 =?us-ascii?Q?6JNEe6XtwNY6m4tAwFoH0Wfd20SJz4umF8K45VaKv2gSZlhhsY/F0uOUKM6X?=
 =?us-ascii?Q?H0mgbAEEbTkdVOyrrMXFXVc35z3u1rWDicNycatnYDSKde+HU5A/TeOCspjV?=
 =?us-ascii?Q?YokpMhWkfiU1jQMiQVo/zbkbsJIEufpJ2a4K/VEZ8Y7B2OA/6T9hop7xZ0f5?=
 =?us-ascii?Q?n/0Vbe4waUkpoqzliFC1D/xEsk/3A/2AFpeJPbejckmTfTw1TNcpiViwAg3C?=
 =?us-ascii?Q?VfZn40hcmI11G2d4piiX1AlnmAuyEzTRBgA3htuXXaRwBqSfr0a2GyHWlQa5?=
 =?us-ascii?Q?wangz5xYD2PdHiG8eCvr1rztxJUpNspmxWZBW3gsWX6aJLJEmLJ4uQvVwxA7?=
 =?us-ascii?Q?GdncjdxYF0zYL2rRRTTxrMpl3Cottc/zum8DhWL5oASu2lGPhpP4MJTOaRpk?=
 =?us-ascii?Q?R8B8Dwjw/77lFGa5DnZtcJiLHQBkwcomVqh10etxetmuYQKRISquoya2p9ag?=
 =?us-ascii?Q?dOGWyr05+hlgvde3oW2dE58o7Ru1nfpThQyvIok/fYV3RJMcX38P0v1Qzhoj?=
 =?us-ascii?Q?INVysGTjwpFLkm0Fxmly3butNhQ53TjjMLI/higo8YS20LPQUAUxcK9p820G?=
 =?us-ascii?Q?yfsrK78DUeZCH8KBTDza4mZlzKaTBS7nI/LFN2xNr5MjzS82sId7JmyCzzp3?=
 =?us-ascii?Q?zNAnMN5eD8zkduXnCGryTc4cEE5t4F4PmL/ED/ujdFQDcURQX489Z5feBSVV?=
 =?us-ascii?Q?Q/KZvO0nVITMjjCdg1iaoD3U6hF7/3OC+6Uz2NSkaynl/EvNEIEgpf1r1m5I?=
 =?us-ascii?Q?h135B5a39Z/GDo54MbirvW7KGFdFZ5ALgyFd3Lk6ZD8917cYqF/aIA2swQwA?=
 =?us-ascii?Q?DtdyNIkIAzvERxXDsr0v05fpsnmgEqLABsiqG5a6H3ifF2w3OcfuiEcevKHe?=
 =?us-ascii?Q?wYVkGwdV6ESCRKbxzB+1gYwkIQeECFm6Sm1o8ec2C/o47Gj0om1PUGXzApD1?=
 =?us-ascii?Q?ANGlzAdAB6Q4hedXjldbXpW0OSlt+TOfwFQUg9hrhW3mutaSvIJ4ClYhtIMD?=
 =?us-ascii?Q?LeSMJ0BGUinRZzCGlb+bZxkUv9FeSlFgb+4tGzpSqlohj+hZrfQP6/0DJQnP?=
 =?us-ascii?Q?llgjPsld8z0whKoGuWoSDtOc/l5qpb9L+hkmntP4PvRMgavE3rrbuZxkvmXb?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 262f64e6-1015-4568-56c3-08da558be8bd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:47:42.0977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4j0ZAakRuuiqe4mzrQvT7xOArOzmbOBIehNMOAtKf8VKePV/GYwLVShV5+3cqsQf7AwoQlsynEkiQwmzBJgbkf46iesoQHNgwQDFv8EfgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1876
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

A recent QEMU upgrade resulted in collisions between QEMU's chosen
location for PCI MMIO and cxl_test's fake address location for emulated
CXL purposes. This was great for testing resource collisions, but not so
great for continuing to test the nominal cases. Move cxl_test to the
top-of-memory where it is less likely to collide with other resources.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/cxl.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index f52a5dd69d36..b6e6bc02a507 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -632,7 +632,8 @@ static __init int cxl_test_init(void)
 		goto err_gen_pool_create;
 	}
 
-	rc = gen_pool_add(cxl_mock_pool, SZ_512G, SZ_64G, NUMA_NO_NODE);
+	rc = gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
+			  SZ_64G, NUMA_NO_NODE);
 	if (rc)
 		goto err_gen_pool_add;
 

