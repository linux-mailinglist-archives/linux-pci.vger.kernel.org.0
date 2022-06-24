Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83E0558D55
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiFXCpg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiFXCpf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:45:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E7B56752;
        Thu, 23 Jun 2022 19:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038734; x=1687574734;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3sxGh1GWh3epEzgXZGKHvSYQ6QP+W0Py2U7f73ecmLA=;
  b=NqvMqirTTLKijqs1sW0hnRShlZ9xHha76CaacaklJ5J12QecrbwA9ErW
   pcM1dw0MYXlIMBsbBDL/DSwWNw7mgKm2S7SchGYcYHh25u6IHi+k1Oq88
   Snq4sAPFz78IerEPCu8wPfCKalv3cnLBVhClRFD9n/aHB3xJz+4DuiGCR
   oytFOnlQ3JOvGfj1A4jbDSPiADYQpfCcwxJA/rDOPBRohluNELTlHsMF0
   w0kd1EaiSow/aJF7SUOuWdDr4cbQi/iszNA5+6uY5d9xFeqNLF+bBdOaM
   Vpq6hOwAIGZQKCXviNOsCrvOINkLf2mKVXBNB3Mot0Ztf9js383fNVCNY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="281986006"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="281986006"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:45:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="834933275"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 19:45:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:45:33 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL6rnUPTbQU0uY6uOEMrgfi4VyGbmTr4VRjghFniu4zQF52q20JB8GQieERlrcBncjSW45tfHc+VDTA2CNmSE07vCKBctre2aXj5NMnVN02PZLtA2ltYLZwLgDAXsmJoFpVKqwYmqUxYwF1UYgDkczH6TTLlttH1qjFmwNOSA5/DVQZeGXK1gguvrMBDXgcg0/ICwH7J/EBBNnPtTCCE9z6ZG33OcrI4DoupGToDPrqzClmtoftUvyK1jsCJ9/TuTkWE5lqTDE+ArjuPqt87kVSWdYaS7Dtk9CR7Ky8nk9MPTYbvptnlKgV88Lz8Rjb9sKEk45X5+Np9ACq219xRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JE4kNN+z/LRdwr0MhnPAFB0wvjb/XAjyw3+wYumk98=;
 b=KRPQZnwXG8uiOPVNSIsXZNoF5YvRR8bcA+AWCbL806BzVQ/CeZ5rh8+2rsKun6atCaEVSTmYp1WOrCSagqMIFU6Ive94R1lxOw4MaZYhLtAPiLPV8hvJEkJYu4X/BQmocoCSoOAMrwCgvb5EI1+30dojwPtAgK5Tn28sJFKcWXp9w3lgim+uu+2dQO7jSisBXeuhaBqBVY/onoLNtWg5AEC3ZeD/XtvfY0rPLc+g+H0YRCae7mp10qE6k52zcopKViUdG4YwdfPoPSA7FqdKJzwI/dU6P7/0CRrU8p6EvOp80r2Iyx2kUVduQxQ97GK9MizrkVVGUtBWlMppcN7xcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:45:31 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:45:31 +0000
Date:   Thu, 23 Jun 2022 19:45:28 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 04/46] cxl/core: Rename ->decoder_range ->hpa_range
Message-ID: <165603872867.551046.2170426227407458814.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MW4PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:303:8d::6) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09b049cb-7dc3-4010-50da-08da558b9a9e
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkeCNcKkEimcMh1qm3ZvFRfqRRKhTS0uEjzY9DZdsEf7PqjMkK6IEut8LLlPYR447ONptWksHa3WUG7iSJ6ehCc2MTdRivMrdO+UCXMIIqFFzLt6WdKODsCSskED6vFeMsAkrs/ruht3t6O9lD84NzjmRDwIl6m8jwfzYj/b8KgQGWDqNSs3kLwC5p4mqsgOxGnvSPsGacD4MT1c4jPlmtSq9i9lck8MVj6Bxdgi1Wkskn11zRr5/Oe9P3RMil/ta7pWxXF3CETaQ5eCYJcKyPuAhma7OJ3SAP2vnM3urNcR6B29GEgR/riXNHJlRMGqeWUulV4iDXitGl4I88mj6ftQQ4ko7zbUKd6EFh9h9ePlqnHs5YjSxy75JRMgxNP+/ZhR6DfC82RxMdbn7M5b1qTsHKIyxRI8/1PNbmXulRjcrX8UVUIVCpqLLYz/xRoKBhadiRyGx1URwzBLTTtTUXX6qQDP4LT5hJTTVD4dljdUmBVQqtptqic301fcai3DqyRU1rqw1y/fi3wR2TNT0hJ/Wsk0CprmZQRt4akV/gooAsFs4kxa6eyw0iOyucynnQZUnXpwVT7wrsLosf3ZfZ5fJAN3KGehQ4himnL2wujWbJsvZEjyDE6uPMMVVj8dcKt+T0mLz2Rkhva/MgFCuOGg63wCJhXbRnkW/BQ/hN3LhnawQMH0uvkuTvdtPq7m17xtvQLFxf6QXwZ5wY2SI3eRx44TihMQmxzqmXkK5TE7BkJwfNYXT8yckLqJt+CH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(39860400002)(346002)(136003)(366004)(186003)(41300700001)(316002)(83380400001)(8936002)(86362001)(103116003)(478600001)(26005)(5660300002)(2906002)(6486002)(6916009)(33716001)(6666004)(66476007)(66556008)(9686003)(8676002)(6506007)(6512007)(66946007)(82960400001)(4326008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7dk2BAml8ZIBvI3TqrKfclMkdExDSEfT+ZCh7RZB9PkeIzq5lUbK20mE3JIk?=
 =?us-ascii?Q?MTNQ2UUym5nOwSuWd81X7C0RN99+v9ZK8aiLYD30DZHywHCm0rHPq5oqJk/2?=
 =?us-ascii?Q?V1JcgzCxmCu++Iy1BHG5rIcvVSpPP6Giwy9dmwX10UulZPHXtgZCaaxgqcgK?=
 =?us-ascii?Q?mwwgUyA9fkkgqYQ5qbVdkNxvdtGhYa59i+3K72FxcvA3uBuEBICZDAo+xYbA?=
 =?us-ascii?Q?pw8GfzgxhgQNqrH0Gw4IiygkX0l59zAHttsjnw24q7DrGxOOLpaIJwFGLoL7?=
 =?us-ascii?Q?yX62MnKy79W7JcgszDAqGvYUwGx6fTk+JYwmAkrQBPTx3sB1s3DvDZe5Nl2s?=
 =?us-ascii?Q?dvsYk/wAw1tEyKnWZejC92Z3K+eDMdyad9/XbfLhDx39x4JPeClrJpTOxoWn?=
 =?us-ascii?Q?iVatiMRDJ1ffuFYt/SFQ7hlFjNKDebUn6nPXP7ID9uqXvTu0ascNYYOoxxEx?=
 =?us-ascii?Q?Vt0BH4PQKzRnHamjBpSZrqIFHrHuei9QVdmRXzbnutCPxQksPcJRBUwMUMOI?=
 =?us-ascii?Q?2coaK2MUfHmyz1BMZwKC2aCNCdCzoLs2noepfRkhOlX8BYHTGIdVCxRAFaSh?=
 =?us-ascii?Q?qtgR8ZYcM6Vs8pM+VqcCgbexHA2s/MwDOnq8WN3e5V/n+giletOmwNPV+QAb?=
 =?us-ascii?Q?+/ehSS0flKuSMqyqS8cJzdMJ6tGbswP02ZJiEIqiqImJ4lxhEh9MTDvRwdXj?=
 =?us-ascii?Q?NlsRbfViDtYIcT4WyMCv6QHyn4iHBIkJQNUit5axAXf/RbuBTu7Pr7DlV1jk?=
 =?us-ascii?Q?iif/gNhGiNKI3JhRLxT4LLt6iXeyc0jLw7jIBm6RQz4j250RHzHuZcEbttGU?=
 =?us-ascii?Q?F66gQSxEWqrHEiBuS2DNXAuj7CcqiKykGbU/eEysYjG/MY/HOWkIPAvSuEmT?=
 =?us-ascii?Q?cRTupssFYsdU4CpbiIH7TXmXvjWM7W/8CPYc1iaarCXQBCrEA9SOhewsAawS?=
 =?us-ascii?Q?Y3z1gwTOjRx4mY5QGQ8rrwvFY3jYs4DLh/nZIUhEXqY1ZLEtf4OzIjRaszZi?=
 =?us-ascii?Q?jjfkI9mMdidwAwmNaPCGIu78x3nR325xMXAjdWCgeq1Amh8EwNKvYjVFK7vN?=
 =?us-ascii?Q?8AuZ/xlHF42mCgCpam92xHDXXN5T8K06FVF7jzDksH4yh/XfG6lsG205VpfH?=
 =?us-ascii?Q?Pu75vxpZjV537zmk7PHAuDjf2/BRrXPwHOVD76pSw6G+LBzSidApqr+zymaB?=
 =?us-ascii?Q?1SdjF5HMjx7pLr6H9lbfjWA3BQo5LNL0pDMM30P7qv3CdvHMfobwETJyR2rW?=
 =?us-ascii?Q?6gkX3cmvRqyEQbkyQ6mcR4OgVjeHrd7EzB6fXxYPa06EQBcidM6b8zZPNqRF?=
 =?us-ascii?Q?d6z3R6mGTgN4WBr1jzedWv8wcOpQJRRDTHdG85MSCiNnvX9No7oY2/1LTOaI?=
 =?us-ascii?Q?3H60ahkLSigSzqevgLcO5RUjsTMLKKpvyiv43x+6g4DobpLSsVtACSD5KydO?=
 =?us-ascii?Q?0S3VOXzy5gFpwN01l9TQ1hBKJFsrx8OrHzXb6OhADnS8yRAHkrOmzGNr8Yda?=
 =?us-ascii?Q?ti/nP91XpVn+clch6FrKCfvyNLe8uOFJVbKiqK1mzt3ceD2kkzjUa0YIHOBl?=
 =?us-ascii?Q?dBq2kkK/5jH19IQvKs/RBSLAzJLqpRhOuYNGC5i7XpWs+k0GwS0FdfyOznFk?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b049cb-7dc3-4010-50da-08da558b9a9e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:45:31.0478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/jN3SvAN2gj4Ja5dcW7T4YLhwgTACAdLQquyWI4hiGTVorwOolK69BJTMiWxr7MJ0xVoPol+1HHoc8nTyIj/Ns9N+r40BOyWZBlLB69pZ8=
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

In preparation for growing a ->dpa_range attribute for endpoint
decoders, rename the current ->decoder_range to the more descriptive
->hpa_range.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c       |    2 +-
 drivers/cxl/core/port.c      |    4 ++--
 drivers/cxl/cxl.h            |    4 ++--
 tools/testing/cxl/test/cxl.c |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ba3d2d959c71..5c070c93b07f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -172,7 +172,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		return -ENXIO;
 	}
 
-	cxld->decoder_range = (struct range) {
+	cxld->hpa_range = (struct range) {
 		.start = base,
 		.end = base + size - 1,
 	};
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 7810d1a8369b..98bcbbd59a75 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -78,7 +78,7 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
 	if (is_root_decoder(dev))
 		start = cxld->platform_res.start;
 	else
-		start = cxld->decoder_range.start;
+		start = cxld->hpa_range.start;
 
 	return sysfs_emit(buf, "%#llx\n", start);
 }
@@ -93,7 +93,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 	if (is_root_decoder(dev))
 		size = resource_size(&cxld->platform_res);
 	else
-		size = range_len(&cxld->decoder_range);
+		size = range_len(&cxld->hpa_range);
 
 	return sysfs_emit(buf, "%#llx\n", size);
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6799b27c7db2..8256728cea8d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -198,7 +198,7 @@ enum cxl_decoder_type {
  * @dev: this decoder's device
  * @id: kernel device name id
  * @platform_res: address space resources considered by root decoder
- * @decoder_range: address space resources considered by midlevel decoder
+ * @hpa_range: Host physical address range mapped by this decoder
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
@@ -212,7 +212,7 @@ struct cxl_decoder {
 	int id;
 	union {
 		struct resource platform_res;
-		struct range decoder_range;
+		struct range hpa_range;
 	};
 	int interleave_ways;
 	int interleave_granularity;
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 431f2bddf6c8..7a08b025f2de 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -461,7 +461,7 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 			return PTR_ERR(cxld);
 		}
 
-		cxld->decoder_range = (struct range) {
+		cxld->hpa_range = (struct range) {
 			.start = 0,
 			.end = -1,
 		};

