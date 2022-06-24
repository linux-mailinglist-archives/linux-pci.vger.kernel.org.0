Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEEA558D7D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiFXCsI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiFXCsH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:48:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8551F634;
        Thu, 23 Jun 2022 19:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038885; x=1687574885;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LlgkVbo0FZHXa/GgNvNhK+JHjqH0j3V8JlVssinAKxE=;
  b=ep9+hFZgAQxYrpS1MYF9UUoz5T+lFZPTpHnMFSx4DXSmtPv+IhkHaMI3
   ceG9BuCGhxpCjahZZqXPBFz+HWCi0LysgZqdljnaim3QIxi07Pu3jlrCF
   6ICCWuf+unYFUwizUjtjMJHqUNh5DILEihh6CF5nC+lSyE0R+GuXEfJQW
   3ILv44ADAeWu1zFgq0vIVTqfzmtIe3t/yILfmt6K1wxTJV+r3tMJYcA8i
   NshUJWztn+7rJzeesW5XGFabmlFi4EzlR20NK6i9l4VEzT7JCiKMVO1w9
   RbHgK7HsIkLGtCXnUYBkoif1XnXZMSruGCzFqstX1KZ4PjU13TGi+sUkI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261332064"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="261332064"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="615817821"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 23 Jun 2022 19:48:04 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:48:04 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:48:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:48:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:48:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrwUyXyCUEjGbS0wMhX4LUB3s48KwLlfi7lMYn9hKjSqOgDVXKbXzvWb5ZfV4hu62ppmiDlQBHHb3ytkQ7rPJTvtW8zVcWq7Flc/m0rALt1t23McQWUc9J2kZGMH3iLKdOAk8uEGwJds2hFc47sOF79LtOtCv3BqYtAkZJ+/44ihq63GgR8zBxCrZOE3kkuXrxxT2nl5n/UB3IL+jpIaBvY9pxCU5kFN8UUQib0AZb5P4BFKqYi6ouYe+A4B6n3vkly2NYwGou8v5KnHiY8U44fWL1Y/jWiqSdiBUSwPMVM64kIF5dPQ7CLiG/ea+Od7TuC7E6YZNJGFOJQhlSn03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4H/LBLjRbx1OLrQJiOoIm1YURxE0H3t4AT8T1pIWOE=;
 b=L/7XfMcNagFCNtFOqLsP1szNLTclBQM1YiJHUi6iReOKHniUaRJ6R1y5ePKITlL9P2Vvpd/QGtU+IvCNe5hlp1B/KuNEw+hFkOwWY6hebGPvVezeg49w3JFBpWjnAF2R1RyWLDhn8vxvvmAXYBIjobRMEFhqUnthlz5JQAJ0xffWoLOL14TAa9lnQee8UWg0CfBc8mQ+8lLAaArdgD6DPmUULjqIME09afy5dR2U5E2pawvMly2bQkWKi8XmPr0jnCUjaFs5kAPFw69kKHV0RW0mX8Nmt5PugfZqgOHDt+Kiun9t4opElbNCjt5cCZYqW81zaaveZ3d/NWoH2xGaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB1876.namprd11.prod.outlook.com
 (2603:10b6:404:ff::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 02:48:01 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:47:59 +0000
Date:   Thu, 23 Jun 2022 19:47:47 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 22/46] tools/testing/cxl: Expand CFMWS windows
Message-ID: <165603886721.551046.8682583835505795210.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MWHPR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:300:116::12) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 075e2e69-2a9e-4e98-0c66-08da558becdb
X-MS-TrafficTypeDiagnostic: BN6PR11MB1876:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27VgnsuyUubuunoNIg+5VsH2nbjNpzyqbsKQloIlPLKwMJ8LER9CHJfuXycLkDTuP/GeBy8Rq6Rk4rTy1KSL2jzaHKt9aelStKKmW2JGfy9MkupWWZWMrwCZj9Xgh/ljlLD3EytHK6zjuHoSaB6orZVBedlSfAyjtcs0ny7LGkKToYuOKGZXgqDNhFccxq+cCUilgCK2QkLmHWwF8M2fDY8nq3EEbYJb8c1hgCU6ZdzuOjkrSvorkhqjGIpgRY7NzV83dc54YaedA3fnKAkGcspqqeanAM9Zsh3EbbYUMXJpvLQ4EUDZ13xBkxh3tIvBA5DN33eKCB24v4uHVoQEzlGBVkVHz8+0ObptS0RwVsgPrrEwHmJdvldTGkkmgN1wnI3eNhOwo9w5wdRTkJcAUqjTFVllv8SJQrvQIpVTDud95MxndBdgQUEu6sKXEWSqkYkv3wRQQrgfnP81nuG6hdzueYKyK6V/w1pRICsM3uAsNQOmWHPovL9JJ9KTe1AG1uKlskmTCfPyvbENZ8yr/PmZtFac/LfJ5xR34A4P9MJYx4/DCqgyuTk55cG2wrt8nmAmesAqzDJOmwGZLq6chx6jpu4iQ4MmeLJJ3NXBtAYcX81xPBX+jeJwrBSZb6hzXzpsAvzyZsovroiyvwlZFAityOQgZEpmmsC4+pvm3PFrY/p11w/8uRz0Jew16YEyOMy3JSdaVwj+/m5InJkeqHVrAW3Pqz5790l8+Tpir1B8nM9et+XYbIkNZN2wOxL5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(376002)(136003)(396003)(366004)(103116003)(9686003)(6916009)(316002)(5660300002)(6666004)(66476007)(2906002)(86362001)(41300700001)(26005)(82960400001)(6486002)(6512007)(478600001)(66556008)(38100700002)(83380400001)(6506007)(186003)(4326008)(66946007)(33716001)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bgJCg4fAFml4f0TVdYav9X4tpuOqv/sYo8mQYoSz1HV//z4KGRGjN8Iry+vo?=
 =?us-ascii?Q?kpbBd1rqUZ3WqDJzaGBc6W4rqBFGPsFZt3wKG7yxk1PrQ263iDefOqfcbSWo?=
 =?us-ascii?Q?5xkEpcboxe71qorlotfD6iJv/vUqrPPWaOGWgVxlrNcGQHGLFOOLXJD2RuHX?=
 =?us-ascii?Q?O4RTm4byd4TyU+uadkVtn7ebX2+g2vbTEkGrKQRt8YjP1um9Brred6+M9Flh?=
 =?us-ascii?Q?cwKcffZSwzvKaKg+KJ5R+/09oUs5P/Qgkx6KDBgiKcM7p1ydh+1HEdR/iaHH?=
 =?us-ascii?Q?Sbl5YanjFsqZJsSUiCgR/1PjeynGZJlxm8ELOVypqpTFEn/wZvRo7Jesc4mF?=
 =?us-ascii?Q?dWrXYjDUzf43XL48yAF0AA/bqqu8ymlnZIA7J06MdkoDYMJECCNhOV71FLpB?=
 =?us-ascii?Q?cnjGJ2fxn7ifVr4MqBez/j/8wmI9b5c55+wI8b6QpPfKBgxWwFyN02CsZwIF?=
 =?us-ascii?Q?eog/dn4EEtMil76si+a6tGV/CyyDZEHwurJkbp39C1waNxdHrUHoNkSiZFkz?=
 =?us-ascii?Q?HDtFbyHiWlBX2oi7cA2V+ap2+FB+gYT8vMtbUGcYR3WgFrcPQEVOTcgBxTrP?=
 =?us-ascii?Q?XtmCe1YhTBOT3sFOQdHFgCKAopTEhDnF3Z5FOuL9Q0ZNH0+M+K1jsGhMACCO?=
 =?us-ascii?Q?bUukG51dDSDhkRi+D2UvsvtlktNBTZqoy36rwkSNfV09P8MFxCI3CK78NJsy?=
 =?us-ascii?Q?BEu/T3hWRJfD4QrbIZdMCkeiq9eGaL+0iUONXXGSSeFH6rqbdFzJ5pgqVRmB?=
 =?us-ascii?Q?V678ulCmdXE6vP7PvtR43UXuy54zKqIpoEWP4XrP6e66Bi+wuUzM3jTbVp98?=
 =?us-ascii?Q?9uRzWj+ksTh+TWbAYkDzajCLOtty0ipDC9EXYQ46LeeHD4JOQEcYTD6SsQ1Z?=
 =?us-ascii?Q?PfxgemPXgvHPB76Zksvfe5pmfMavIN1E4rQPxUFKFiThTbonByw3ediqL15K?=
 =?us-ascii?Q?v1fXfYbWQ+SGNU+7tLlUW12aCBnGmyFYjdrbNt94aHXpm5oq7EkE/iO+MhOK?=
 =?us-ascii?Q?unMkaOMQ2u68xEmX/1RAYY7uIQf6xFwldKJynlEHQ7PHZDnTOrzkCgJVDhim?=
 =?us-ascii?Q?rFRZEO6PT3EAlFpz1JVkJxugxrdJbWaPl8hHJ0zQY2uHtIAXPnEL/p0+Ab/V?=
 =?us-ascii?Q?jLBMSpetbBThqT/jimxWaqfdXddQ3EPiCBvtYmGOZ/hStgEe/Zcr0Phdh/UZ?=
 =?us-ascii?Q?5dKTFrS5ae/xMYoQgGfExCTouklU597AotBpmNNnT/pQ6PbEAitD9mQN04i5?=
 =?us-ascii?Q?gISRia9gMHzx31aWVROhTsAmrXD/YpWfc+s3jNGe8ROgzwHd6NKshgSpziPL?=
 =?us-ascii?Q?WzWCcMscmRRROn8AlIvkzT7nn4RAzelaGGOTkm3y/FFmgy5uvAVtPJpAZvT+?=
 =?us-ascii?Q?tJoUTYkJd4dgqUHMUUGDfuzQuFNQnsz8uWDnTpFXd+MhhJfBAoxoXBMOwq6K?=
 =?us-ascii?Q?D72Z1QS+2u7pkxbt+B/trDdibEP7UsO7qj0Srs88v660tsKbv5g2z2+gDyAa?=
 =?us-ascii?Q?3kuAm+0eJk2sSdnyOzSfkz+IxRlRbjQjfit6em2/i9IBbP5C5t89ygP7WLZX?=
 =?us-ascii?Q?YUOWmfCzVF8ZEkLLbqxHCbFxpZaOd4Nxy+Kr7sqvQykRtzrjwBCzqkHALlEJ?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 075e2e69-2a9e-4e98-0c66-08da558becdb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:47:49.0033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmaXfjeroxkKzrJ+yphRyW2kVig+2CvN5m0P57tKaAoHkc90qlAAU07GN5TFoLwpnNKWak99RgCbOBhLXiTkmPsiqRZVPYHLz3YW97uUTlo=
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

For the x2 host-bridge interleave windows, allow for a
x8-endpoint-interleave configuration per memory-type with each device
contributing the minimum 256MB extent. Similarly, for the x1 host-bridge
interleave windows, allow for a x4-endpoint-interleave configuration per
memory-type.

Bump up the number of decoders per-port to support hosting 8 regions.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/cxl.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index b6e6bc02a507..599326796b83 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -14,7 +14,7 @@
 #define NR_CXL_HOST_BRIDGES 2
 #define NR_CXL_ROOT_PORTS 2
 #define NR_CXL_SWITCH_PORTS 2
-#define NR_CXL_PORT_DECODERS 2
+#define NR_CXL_PORT_DECODERS 8
 
 static struct platform_device *cxl_acpi;
 static struct platform_device *cxl_host_bridge[NR_CXL_HOST_BRIDGES];
@@ -118,7 +118,7 @@ static struct {
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = 0,
-			.window_size = SZ_256M,
+			.window_size = SZ_256M * 4UL,
 		},
 		.target = { 0 },
 	},
@@ -133,7 +133,7 @@ static struct {
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = 1,
-			.window_size = SZ_256M * 2,
+			.window_size = SZ_256M * 8UL,
 		},
 		.target = { 0, 1, },
 	},
@@ -148,7 +148,7 @@ static struct {
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = 2,
-			.window_size = SZ_256M,
+			.window_size = SZ_256M * 4UL,
 		},
 		.target = { 0 },
 	},
@@ -163,7 +163,7 @@ static struct {
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = 3,
-			.window_size = SZ_256M * 2,
+			.window_size = SZ_256M * 8UL,
 		},
 		.target = { 0, 1, },
 	},

