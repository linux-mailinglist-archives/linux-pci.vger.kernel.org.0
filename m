Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F5B558D85
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiFXCsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiFXCsS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:48:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E41F56FBF;
        Thu, 23 Jun 2022 19:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038896; x=1687574896;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AXk4sBysv9W4e38zw/eG1wtIWp3QfmG2ukDIWm44Px4=;
  b=lQONm8h4qpNeZgRxT9xzX5jh8RvHD/mmVIb8XC52PH6uyx6STgX4xQNP
   fm+38PDZXwRzg+jtPRWCLF7cIWnpLKUOEWaPwkEXOoRjG3TrChBvNCi2a
   ajBpC4a4XdXQqojcPX5SWxtKFD7FIRY+CC+T5r8msTLs/S/3W/48j8EA5
   2iNBXWygtvEFIcwq+Ktj9z2GXJdl0B9cZX93jhSfudO0uHp/0YX2pFRsi
   GHOev4AtvWEHBfhhw6ETZuxIBLu1tOmzho+wApEqn/I3Z07uSLoW9Lais
   9oDUz3yB2ckg4fFoBA0iXavXVsNnOe/FhxeSPw0qAkIxhlO51/qw6j39i
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="344898677"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="344898677"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="731139664"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jun 2022 19:48:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:48:15 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:48:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:48:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNYRoYDQa/045JZemQy8gUapv5OyDj9ZJGJ7tOPGztXyrqrSVFhcsO+pqPOo1mZm2n4dQ/+qkcV+IRzT4eqOtScxI/WBpF6xy+MmTckbXwe1++vcwHPdecSc8fycVfg+7JDC/zX1CAEAMYdL20AlcmNzeF7Ozacm5flup2HxRpxlkH+D5ALL2+18buIyWGc2LFSNAsMgMwNTskfAocpoHmbcnr3R3nJU7yqhVrktBWvOiL8RZiBvAL1GnSVfBUu1ObYB9vyGNWK3VjoaqK8FuvzDYYLmbkpYdToiFd1C+BiZIhCDKpJsMuh7eRhEZZ9FA1X8rHjK4djBoibhKAWpFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNJ3L6EkGykBpG8atfsW1a9E1xyOZv+g5W9Byx5LGlY=;
 b=E4/Wsj0jgBn/nukOwfC0jnOKM8mwtMmuQ1OIbJwAHXCwYTP/crsQWDVuXiJ90f7hZm5160l2fLJq4h4MZ+aPaSc5X7TzADPDjd3fJHPMeSddyB3VwXxsEx1EobG7MzplMdo/rIcs1WQo6tKrIFOhp4JW+UyasmgxY3OxgydDK2q9XRHLCN7DfiNRBmFb7oALdBYizROZLDq1sfpH52XwjbLgL8LTLPDDTYSZ36cZj0JYQzrAq+ryeEIDFZI02FQ5LoYcsVoCeY257FtnpJ381ZardxaHzP6cwydghcq/ZRUqPsXwELpyugFGwNEaGqTU+s+4E5zG/XJ4uAJt00xdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB1876.namprd11.prod.outlook.com
 (2603:10b6:404:ff::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 02:48:12 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:48:12 +0000
Date:   Thu, 23 Jun 2022 19:47:54 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 23/46] tools/testing/cxl: Add partition support
Message-ID: <165603887411.551046.13234212587991192347.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MW4PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:303:b5::12) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd2c629b-6bd6-4c53-11e9-08da558bf0e8
X-MS-TrafficTypeDiagnostic: BN6PR11MB1876:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EeLH86wUuBStBJbdFSD8/TrTNCRuj94iuL38HKFDWqK1hSuYdI5GzCFwlAU1+SYIJZpQXvuc5xHAHyhcj3tXbQdktzb8ygvpmMVYrgy2SJijjmsMb+Nra7aGohaLZqkiSK/Q6UUDBbBLi6OWW15d+8WpG4FpWJuV5010HYTyMLrylOhluDa17HdvL2HmkdKJMOj4DeO5/pdLGblNexCTuEGNKLpFs/S2BSt3vhou7CQKKKv8VMSxxDuGAmbgvolfSZa0HO8vBnLg8sTeRKDzHlpYDmhjZS8TkBLD0z9eNf6FNrKREM8DxYpWnjeed0Nnornq8zGW7O8ooZQBeykEmgy9iMOhF/pyW1PWaH66Ndx/cN64pnbBTwXBeuvdcI3CAr8p4YdJGpESnuWTK3Yb2f03tIYAxXopFUZALF9Eoo8yoct57DeTzZElA2lM44XEBC3UqjhlDHVOibTIGYHY/BFPa3KwIQVbRdbsG2rAg/cy1x1URLnBIRYQGXIwNggi7+gIF48Q1GMfJl2Qk17cVuy1wsYaMLOlRQa+9n+WFn/IqjkzfPQhFYkieA/pkX5h4pX0J0mb7yC14K+72k3RLfT+3XTpAs1ZIRDTwr8gOEn3AmMpmkLjN24No1oFHSzGF+fVIRr8H/3Rr77yZMXgto79VkIC1t/TRAlpQ1Pi1kBZ961hdtTybsxzqxhcQxv1RY1xwHeLzSzfr6oJQ03L7CgB4+MyD852aDKGkI2arBKkjeBgnjl8MDaiicYxO8Z8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(376002)(136003)(396003)(366004)(103116003)(9686003)(6916009)(316002)(5660300002)(6666004)(66476007)(2906002)(86362001)(41300700001)(26005)(82960400001)(6486002)(6512007)(478600001)(66556008)(38100700002)(83380400001)(6506007)(186003)(4326008)(66946007)(33716001)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nsum5WaeHUuk8vkDQtTbzcdZqUN4m1yV1cRblOigR35dOhlG3ioD2PYEQ1T7?=
 =?us-ascii?Q?eOpsingm9+9uLb++gVhcADekPc7NPUgXxsyRHKdb0pPffLnju6B/jEtOzmE4?=
 =?us-ascii?Q?pa6bovO/R+8GTrlkI3SB4H41dLZqFSZZKhRgkRHZDNaISWhDALTfkbyo6IRZ?=
 =?us-ascii?Q?zuCT8Tu85Pt4bdjS/mhwji1SOvoLghkiZT7/bN2wZQ0o9O6LhRFLCBIKoChE?=
 =?us-ascii?Q?i2I3ViuNl77iBhbQXaer+g2bhj60wF4QYPMKcRIv6t6zjpUF025ZNDQ+fE1T?=
 =?us-ascii?Q?fMsnJzZR0qIXRW54OT7MawMnERpuoicqQBKlinWSLFo9TdmO49vruoesyb9c?=
 =?us-ascii?Q?J+TLRKds20doRYFkbxKuc85NxT2bqpiERRwXCei6xYxoJl2BJox+03gwATdn?=
 =?us-ascii?Q?NnCdY96f+qSuHqMeLOptdsDqDNkG8G33RIGHbBUY6Kr90ucp2i2D4E3VtvwA?=
 =?us-ascii?Q?cNOKd5HC4EUkwaEbkW0Eapqz9KJkHGGLUVSCpEuWr8ZSk2MPMJS1PFjyDsy9?=
 =?us-ascii?Q?btuJSuExHxohd9/bhtZJDynBO/RDJTLwO8OW6Lc3C4p4Jc/98PToezsDn8VC?=
 =?us-ascii?Q?D0Vu60nKmHKVvkpzaYWH7fDrLjsSTf22Tb19KyJOVfsuanoP7Le308O1IiAk?=
 =?us-ascii?Q?tO8BIkg+k22+gGzZ0VfPcTwKW/jfE2VjnYks4kfMh3RsEx/rvsP8pQG1EgH+?=
 =?us-ascii?Q?/TtZwx/zh/TibN7HcLJ4422l3wWSRNpvI1Z+nTqJ6If2FbGmUDSuibHtL3yy?=
 =?us-ascii?Q?5qkVihcE9qI/8w2Phetu1GXpzeVM3YmlBBuQ4HK/q+y4kdj/aYmiogpKWRuR?=
 =?us-ascii?Q?nDxXVRsWAir0+xL0IjLBGJVAg7xbLjOAf8PRPphFq9zvRay4UuVe6gyiV3PA?=
 =?us-ascii?Q?s6UIK4FuBhWfkSIVB+osP1HC5WNi648TMCOa42dq1BazQxJKi+t19o03e6co?=
 =?us-ascii?Q?CPiSIvL8UGwfdiUCxR0+o53qSLbRUqTFFLA/AcK5fWcZVB8u5z+gkOPlvIpZ?=
 =?us-ascii?Q?+jjdMuj4BY8/s/QAuVQNlovfzQeBeYIsIpWL/NJM7pZ9JhHzWK6YZfnPUynt?=
 =?us-ascii?Q?cGn0odF/FxeLa4WW8oECEwRTwl6nKGrQ6FiCTc3sL3V+vfHGqPjKx1yvVvEx?=
 =?us-ascii?Q?zL5HrYmAEtEQ4gRLbxt2YFnAwSOcVFbbti2XpJt8F4B4mRyTGzi9Zh7Fp0+0?=
 =?us-ascii?Q?mWOfNvcz5S0ZdTtKu9UhiB5fjWrGMwzL/t2mNx3wxpUlxOFS8csw3UZSjR4P?=
 =?us-ascii?Q?rv3ZDB4C8/zbQyNfGmX88lwHB+G3lCcspMNF0EP8R53j8b0Fv8QuBIGKqI6d?=
 =?us-ascii?Q?7NhZKco4qrojnXgyj5LW3Gi+V0hXjxQMwZbJDtJKNNTD6KSJV4lYP4kBrHEx?=
 =?us-ascii?Q?nRi2jq8j9xAQLbLDVkBffg1bKb/lLtddItMUW6rucPm6EcTBxBi/KKwTTy4k?=
 =?us-ascii?Q?SFyVBlN10/oiKPtKyppqZwesuLvc70niQK50kPdbdBonO92jnbMFj8M/Po1m?=
 =?us-ascii?Q?Scq1yK4sNY73YljchAM3NHdQUEc09cUD1xewR5p4ZwPTZDra53G4h9BAKsi5?=
 =?us-ascii?Q?FOTep0+ND89FTZzbIrXWv1gR9KPaY3fJa2wnaSZk5eGUBDGpir5O0YDuJOft?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2c629b-6bd6-4c53-11e9-08da558bf0e8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:47:55.7996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVWaC8NA6sDmHgApFuSalHcBc4+fuQMxzsJw7JYoh13hGWC0Bn4uvQ6KANhSqgv8z+Qt7CljdhA2D6fRUxl7jNuY1M7ybwsuTFryI2Bi0RM=
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

In support of testing DPA allocation mecahinisms in the CXL core, the
cxl_test environment needs to support establishing and retrieving the
'pmem partition boundary.

Replace the platform_device_add_resources() method for delineating DPA
within an endpoint with an emulated DEV_SIZE amount of partitionable
capacity. Set DEV_SIZE such that an endpoint has enough capacity to
simultaneously participate in 8 distinct regions.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c      |    7 +-----
 drivers/cxl/cxlmem.h         |    7 ++++++
 tools/testing/cxl/test/cxl.c |   40 +--------------------------------
 tools/testing/cxl/test/mem.c |   51 ++++++++++++++++++++++--------------------
 4 files changed, 36 insertions(+), 69 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index dd438ca12dcd..40e3ccb2bf3e 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -716,12 +716,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
  */
 static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
 {
-	struct cxl_mbox_get_partition_info {
-		__le64 active_volatile_cap;
-		__le64 active_persistent_cap;
-		__le64 next_volatile_cap;
-		__le64 next_persistent_cap;
-	} __packed pi;
+	struct cxl_mbox_get_partition_info pi;
 	int rc;
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_PARTITION_INFO, NULL, 0,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index db9c889f42ab..eee96016c3c7 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -314,6 +314,13 @@ struct cxl_mbox_identify {
 	u8 qos_telemetry_caps;
 } __packed;
 
+struct cxl_mbox_get_partition_info {
+	__le64 active_volatile_cap;
+	__le64 active_persistent_cap;
+	__le64 next_volatile_cap;
+	__le64 next_persistent_cap;
+} __packed;
+
 struct cxl_mbox_get_lsa {
 	__le32 offset;
 	__le32 length;
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 599326796b83..c396f20a57dd 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -582,44 +582,6 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
 #define SZ_512G (SZ_64G * 8)
 #endif
 
-static struct platform_device *alloc_memdev(int id)
-{
-	struct resource res[] = {
-		[0] = {
-			.flags = IORESOURCE_MEM,
-		},
-		[1] = {
-			.flags = IORESOURCE_MEM,
-			.desc = IORES_DESC_PERSISTENT_MEMORY,
-		},
-	};
-	struct platform_device *pdev;
-	int i, rc;
-
-	for (i = 0; i < ARRAY_SIZE(res); i++) {
-		struct cxl_mock_res *r = alloc_mock_res(SZ_256M);
-
-		if (!r)
-			return NULL;
-		res[i].start = r->range.start;
-		res[i].end = r->range.end;
-	}
-
-	pdev = platform_device_alloc("cxl_mem", id);
-	if (!pdev)
-		return NULL;
-
-	rc = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
-	if (rc)
-		goto err;
-
-	return pdev;
-
-err:
-	platform_device_put(pdev);
-	return NULL;
-}
-
 static __init int cxl_test_init(void)
 {
 	int rc, i;
@@ -722,7 +684,7 @@ static __init int cxl_test_init(void)
 		struct platform_device *dport = cxl_switch_dport[i];
 		struct platform_device *pdev;
 
-		pdev = alloc_memdev(i);
+		pdev = platform_device_alloc("cxl_mem", i);
 		if (!pdev)
 			goto err_mem;
 		pdev->dev.parent = &dport->dev;
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index b81c90715fe8..aa2df3a15051 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -10,6 +10,7 @@
 #include <cxlmem.h>
 
 #define LSA_SIZE SZ_128K
+#define DEV_SIZE SZ_2G
 #define EFFECT(x) (1U << x)
 
 static struct cxl_cel_entry mock_cel[] = {
@@ -25,6 +26,10 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_LSA),
 		.effect = cpu_to_le16(0),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_PARTITION_INFO),
+		.effect = cpu_to_le16(0),
+	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_SET_LSA),
 		.effect = cpu_to_le16(EFFECT(1) | EFFECT(2)),
@@ -97,42 +102,37 @@ static int mock_get_log(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 
 static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
-	struct platform_device *pdev = to_platform_device(cxlds->dev);
 	struct cxl_mbox_identify id = {
 		.fw_revision = { "mock fw v1 " },
 		.lsa_size = cpu_to_le32(LSA_SIZE),
-		/* FIXME: Add partition support */
-		.partition_align = cpu_to_le64(0),
+		.partition_align =
+			cpu_to_le64(SZ_256M / CXL_CAPACITY_MULTIPLIER),
+		.total_capacity =
+			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
 	};
-	u64 capacity = 0;
-	int i;
 
 	if (cmd->size_out < sizeof(id))
 		return -EINVAL;
 
-	for (i = 0; i < 2; i++) {
-		struct resource *res;
-
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		if (!res)
-			break;
-
-		capacity += resource_size(res) / CXL_CAPACITY_MULTIPLIER;
+	memcpy(cmd->payload_out, &id, sizeof(id));
 
-		if (le64_to_cpu(id.partition_align))
-			continue;
+	return 0;
+}
 
-		if (res->desc == IORES_DESC_PERSISTENT_MEMORY)
-			id.persistent_capacity = cpu_to_le64(
-				resource_size(res) / CXL_CAPACITY_MULTIPLIER);
-		else
-			id.volatile_capacity = cpu_to_le64(
-				resource_size(res) / CXL_CAPACITY_MULTIPLIER);
-	}
+static int mock_partition_info(struct cxl_dev_state *cxlds,
+			       struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_get_partition_info pi = {
+		.active_volatile_cap =
+			cpu_to_le64(DEV_SIZE / 2 / CXL_CAPACITY_MULTIPLIER),
+		.active_persistent_cap =
+			cpu_to_le64(DEV_SIZE / 2 / CXL_CAPACITY_MULTIPLIER),
+	};
 
-	id.total_capacity = cpu_to_le64(capacity);
+	if (cmd->size_out < sizeof(pi))
+		return -EINVAL;
 
-	memcpy(cmd->payload_out, &id, sizeof(id));
+	memcpy(cmd->payload_out, &pi, sizeof(pi));
 
 	return 0;
 }
@@ -221,6 +221,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_GET_LSA:
 		rc = mock_get_lsa(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_GET_PARTITION_INFO:
+		rc = mock_partition_info(cxlds, cmd);
+		break;
 	case CXL_MBOX_OP_SET_LSA:
 		rc = mock_set_lsa(cxlds, cmd);
 		break;

