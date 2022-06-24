Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B64E558D72
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiFXCr1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiFXCrV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:47:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E207056F8C;
        Thu, 23 Jun 2022 19:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038838; x=1687574838;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cH1NsLuJycPAH4dmJHmiUppgm54AwXkpuVfIYJjOXCA=;
  b=eqWxemmrPJsGoq2MFei2O3xx9I5kC+IOHbRbxxeeBWgu5l543XNzAPDK
   Egd5QdxJt/GSVeI1s0V4gIWIhDleWfI9Th/wantnetjBuUMmjEGNhE+SQ
   Q11joYROoPus6pponngKnpkoNi/KSAQHczG3TtfDHg7HP7rYB/UYLO2LK
   xb+GEGljiYq2Aeju+qyz4gjUNPMKK9mXLGrS+tQdiF2Sgsz1X9q9jRgXz
   LgwMGaP3rmhrz0UBl7FVZ0gCgPssbNvY2pJKGS0I4MVzzx5S95wza0sQy
   tDlBA/WOfaU4lrrQ/Gd4MLDWJ04e1Fs+HNiPxYJf/w5qfOeuZPwcuynPM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="269632611"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="269632611"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:47:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="678352604"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2022 19:47:18 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:47:17 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnGPxMuqYPcNBpRZhr57uT+mpkxD1k0S1socxJtFGDJoiHOxMjNvdSxCwGBXDkjZ6qKGRmRa9YhrHSBO4a7sBmpOq0NUat+/BWLh1bi0kpNitD9bBxDH392Z1zNJeFaj7ySwfcb4nMZ5kpgTTSXO39x2d3XdfjnCEHucGeRS0eh+hhKz+Kz7shSdLK3wQdt6JTubllqJ3taAwVJlFSKgHc+eycW0Lf9GTleSIb8Y5F2+r1YRi1khuVI7uXgDPY3e2Cxwt+LJc4Hyb7ZcmFbdNL8fcT9N8oVTrkgS8X+/wZ6UelxUaKXi/Hgf0zJfkvzwd8HxKSfvsjwJWIB3eALn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yggvu6zgR7pfSSwi2CNLWy2a/rgTnsvIA/617IsPme8=;
 b=a0x7kfI3sgcH7MyUZBtUlQ5qb6r52V7x9hPxGnLO1mEFzqEc28uJIRISY0r46jkLh1v8ApSB5iqLOTJxmopIBNL7k50YYqhwuL9RbF+Ewjdk4N6DMcYzf25vgLmx09vhgU5eaNYGKCvhhUDendG/X3oaZWWTS3MBzuGYvBUi60SPnko7md6HWGsXuPfkTmaYqWT8DJJj9hZ9QMc7xagROHsxyUJOjd3WVXrh0gCOt7ax7jp5rAjXLZvgGY5xKqG5psjj0hMw6w+SLY8Bp3Jar4uz2n34Eyd1fn+euAvMsc9roN5fHGkQYNYObKBeYlHAgMDnJWOY+QmuuIiTbj73xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:47:16 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:47:16 +0000
Date:   Thu, 23 Jun 2022 19:46:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 16/46] cxl/hdm: Add 'mode' attribute to decoder objects
Message-ID: <165603881967.551046.6007594190951596439.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MWHPR14CA0038.namprd14.prod.outlook.com
 (2603:10b6:300:12b::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7840c86e-a364-4c85-bc6a-08da558bd097
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /iLil0337n4i1JA+0tKTSHPBXoL7ujWXLR5aJrDL7m8mF2AifAjTlNp6phLD6WbkfaiCdTmVGTJqXPQ1ziKdU7LRxBPNpHImIXyd/uK7xIU6LsLOQdo1SxMW6T8PNnNyRMs/MeTnkdQFTW3H9ZZr2a/djXSjXgwrGH7V6Y7S4KmHtL4PnYfnLyqWVZYPKbUaGpVDUGm99Ujz9jv6HC8h50y9LmE46Kllmphp7U/7w3LGJ3YEwzTKi9HmtWdAHLzW33ocaSnrYMycnx0uJqNQCMLqtsEFW4n89CfVuM+Z0wnsi2WWbP+iGl2Tpr5smnmTRCmCIWJb1XNUuuCyVasmvkFK6TkhK2ZfksU+cej1NmpsXfhaxHorx/v43iGMR2Ggep1X518sLsMS0w+tZyzCa0DO83RBtIzPmSoz/DfRynUe7uomeIgvNPZf+1QAMd3Mxcm51mkRegtyvSG/2Y9KSyXgFHqnFhOI7k8H7kqljt0tRdlZfUhNbq3akLP+S9UdDqvz1A003n3e5GG1L6lhYrD5JsQpUBWttPZqdfUUX+DaWLttlF72yRjGN51Prm/YFvZM1wCVs+bvjl3LtY4FnUc7Hiy2AeOQrT2r0JZ+oauZT68PoX2AFB6UKhbdN9rz/inBwADM91HlaWsDgxoBwC1Dk34Y9WpAjblW+UgpBuNNVKE0ZHz76bgCMN5kERGurM+wqt1Xt360IepCseaefU0P2CJRoqrIgOZ18fGi1tWgT64r8bIMt+w66HvVzYsD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(6666004)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v9vlvnV6a/JVYG9XUwj+A/QvAeXO8dkFYc04OD/cjdQHdLsP6jsVbFIABpBR?=
 =?us-ascii?Q?QcPanFeFqpOeDDLGQNBqAq2TC5lZ/Ixc7hE61PVoBJqjZBgT1ArFpfb2hiD1?=
 =?us-ascii?Q?315JC4nLipM5t8E7N34u1UQs/bDb+yNW3WX/yu9YwMxO9WEP0ktzidvadk43?=
 =?us-ascii?Q?QXXnRm/dzS0jyhJhwxltGjrbMIfF63alZANgyt6McTdTMN9PPb1E4ktKOIAl?=
 =?us-ascii?Q?ioS/2P13EvuF8hVSDW7//3DaEzfu4DschSxG3cYZUahH2R00/jIUIOoP2CTq?=
 =?us-ascii?Q?QSooVbWDBrecBTIySgHk/WKG/J14wFRpPObfUoWHb4mOkWZpMUxfEVWsrytA?=
 =?us-ascii?Q?HwEOXJDHfNW623xBj6Mj36V3yXe0+4eGiTy9PNde6LmVyCAZZkZb9jFsbSij?=
 =?us-ascii?Q?4nKkDbNgugj7Yzm6rPRunoc/HkrBnTErC1+DI1jxO2TsJdj72CWz8mERLAXl?=
 =?us-ascii?Q?6qEiZVxaUwevRTIFHJwmj9olNMmXPQoNzlwpkIWAs1sNfGOpyP/k5mfCj7pi?=
 =?us-ascii?Q?z5CXnhgYBMuwPZiCrP6rO37Ph8hGCv9ujXdWxnI4oRitjkoN/EVUFVUFG2U8?=
 =?us-ascii?Q?RoBQOnwpYBxW8rxQfIASkf5EQP7CRV4ssQgZgJZJ1rY0IYvdSstenJor1b3c?=
 =?us-ascii?Q?SlW2z9HDLke2pyimHowKhSDfN0Upd07VkdpPZEwGuQJY0CaeesbfCmFJJPYT?=
 =?us-ascii?Q?WrhY6pNWRSBJdOcdG3sdrRDji9fP97Pcyb5I1tVWtGAEUe52xNpXCd8ZwdOW?=
 =?us-ascii?Q?eLykbIH1M0Wh6jFM8EKlYVDOrjfS7rzbqKCIyr9BOO1xF1Ddz9Y9MlescdMW?=
 =?us-ascii?Q?VdMgBI6xzFcC5kDCftWQhjcyt06JzSuvv2ZbXOgD9JKAzU6d3VJkBYRS9xxL?=
 =?us-ascii?Q?I84owu+nnlZl8rE0SLHU2basrc/Z3yUwAWR6IMsmuMITyvJSCrreP/1IU9Ru?=
 =?us-ascii?Q?skFbVIV2+vm3zrixP8AzSYGEIP5vil+O0g1sAdzG6tf8J1yB/hV/Mf7Yb782?=
 =?us-ascii?Q?/7dmvXO1FEwABZPF4GHtqiuI9sNYHT+ucgiX5ed1Y4KwPDKOKrc4J2UiWMmZ?=
 =?us-ascii?Q?G8OgwY0RK3VmW5D/3TUVXqmLwUj9WtXXjnyzUomLFR3o4RrX+JjcHFp/TIit?=
 =?us-ascii?Q?rLDi3LC6ySdo/pyGKRK9HY4MptOAt5Cznl7x9dkF2gRTeM+iFQn/bfq0peVB?=
 =?us-ascii?Q?dZ/LuoqVm9KZfEWGo3ax3zi/m5CjzyIcgBAOyu59wkZH+b48bJc08JCgjbtz?=
 =?us-ascii?Q?vn/cZOt6wVjEpfdHJp5iBCGX0/bzlE8P3vgMo4iei2oZIaj4/QRLFoRhqR55?=
 =?us-ascii?Q?05uJh6AYmqzkI6praesOfgB/XZKca2Chuq0N2jYDV4p88ADfG2dOiG5D6WM4?=
 =?us-ascii?Q?SItIobM0ZK16s0tN4jJXdemppzPDMD43BGCgxkN1D8I5gKG7UTxNn3DoBcHu?=
 =?us-ascii?Q?2B4U0ih/EcwU1aodN0VEsHOhOBhOANE78PU5j7UgSi/9MDJzC42axhUc4eG+?=
 =?us-ascii?Q?B6nLn0iJ67toCjxOVjv5gQjIb0NoQwQNdzynsSNhQcelh11auPrGEE6Z8R+A?=
 =?us-ascii?Q?0NI3TOoV4VimN7BR/YjMG/oDRhXwgpBwi19q+KBv96Pq04Mx3BNpMt0qQEoQ?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7840c86e-a364-4c85-bc6a-08da558bd097
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:47:01.5860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHdceW/7hjxIrdskN0fKozQ8Jk1ccqm4UXrEdkyiqAhpmvo01v+ZG1N+IZQzBoElLLLE7d1usprjYqT0fG7udThgwfGeNo1BzDBaqJrdZ1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recall that the Device Physical Address (DPA) space of a CXL Memory
Expander is potentially partitioned into a volatile and persistent
portion. A decoder maps a Host Physical Address (HPA) range to a DPA
range and that translation depends on the value of all previous (lower
instance number) decoders before the current one.

In preparation for allowing dynamic provisioning of regions, decoders
need an ABI to indicate which DPA partition a decoder targets. This ABI
needs to be prepared for the possibility that some other agent committed
and locked a decoder that spans the partition boundary.

Add 'decoderX.Y/mode' to endpoint decoders that indicates which
partition 'ram' / 'pmem' the decoder targets, or 'mixed' if the decoder
currently spans the partition boundary.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   16 ++++++++++++++++
 drivers/cxl/core/hdm.c                  |   10 ++++++++++
 drivers/cxl/core/port.c                 |   20 ++++++++++++++++++++
 drivers/cxl/cxl.h                       |    9 +++++++++
 4 files changed, 55 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 1fd5984b6158..091459216e11 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -164,3 +164,19 @@ Description:
 		expander memory (type-3). The 'target_type' attribute indicates
 		the current setting which may dynamically change based on what
 		memory regions are activated in this decode hierarchy.
+
+
+What:		/sys/bus/cxl/devices/decoderX.Y/mode
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
+		translates from a host physical address range, to a device local
+		address range. Device-local address ranges are further split
+		into a 'ram' (volatile memory) range and 'pmem' (persistent
+		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
+		'mixed', or 'none'. The 'mixed' indication is for error cases
+		when a decoder straddles the volatile/persistent partition
+		boundary, and 'none' indicates the decoder is not actively
+		decoding, or no DPA allocation policy has been set.
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index daae6e533146..3f929231b822 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -204,6 +204,16 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	cxled->dpa_res = res;
 	cxled->skip = skip;
 
+	if (resource_contains(&cxlds->pmem_res, res))
+		cxled->mode = CXL_DECODER_PMEM;
+	else if (resource_contains(&cxlds->ram_res, res))
+		cxled->mode = CXL_DECODER_RAM;
+	else {
+		dev_dbg(dev, "decoder%d.%d: %pr mixed\n", port->id,
+			cxled->cxld.id, cxled->dpa_res);
+		cxled->mode = CXL_DECODER_MIXED;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b5f5fb9aa4b7..9d632c8c580b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -171,6 +171,25 @@ static ssize_t target_list_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(target_list);
 
+static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+
+	switch (cxled->mode) {
+	case CXL_DECODER_RAM:
+		return sysfs_emit(buf, "ram\n");
+	case CXL_DECODER_PMEM:
+		return sysfs_emit(buf, "pmem\n");
+	case CXL_DECODER_NONE:
+		return sysfs_emit(buf, "none\n");
+	case CXL_DECODER_MIXED:
+	default:
+		return sysfs_emit(buf, "mixed\n");
+	}
+}
+static DEVICE_ATTR_RO(mode);
+
 static struct attribute *cxl_decoder_base_attrs[] = {
 	&dev_attr_start.attr,
 	&dev_attr_size.attr,
@@ -221,6 +240,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
 
 static struct attribute *cxl_decoder_endpoint_attrs[] = {
 	&dev_attr_target_type.attr,
+	&dev_attr_mode.attr,
 	NULL,
 };
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6832d6d70548..aa223166f7ef 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -241,16 +241,25 @@ struct cxl_decoder {
 	unsigned long flags;
 };
 
+enum cxl_decoder_mode {
+	CXL_DECODER_NONE,
+	CXL_DECODER_RAM,
+	CXL_DECODER_PMEM,
+	CXL_DECODER_MIXED,
+};
+
 /**
  * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
  * @cxld: base cxl_decoder_object
  * @dpa_res: actively claimed DPA span of this decoder
  * @skip: offset into @dpa_res where @cxld.hpa_range maps
+ * @mode: which memory type / access-mode-partition this decoder targets
  */
 struct cxl_endpoint_decoder {
 	struct cxl_decoder cxld;
 	struct resource *dpa_res;
 	resource_size_t skip;
+	enum cxl_decoder_mode mode;
 };
 
 /**

