Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C65F558D65
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiFXCq3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiFXCq1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:46:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0D356C35;
        Thu, 23 Jun 2022 19:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038785; x=1687574785;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VGzfgn4j+cvzo52W4P5voHaM52wBsUdnDl5FXnJpV9U=;
  b=DpQ4cyNVn/xtp/BxFKcU3d3G+R7VtMfIjNjNaIh+wdfGFDsnZnH+F/Q4
   fOwqOI2aPyZYBzvFPUVj3trns0NMhrSD2fThK19AVDGJNNyM5mBYz7JD6
   CHF9SK8TQWkQtbDdOOMTZgJ7M3R50/0V2UrqJ92TtVL0RX3dwDl7oPTk7
   PsKuhgUcCnLPffHiqSQ/Xi0j81l+ICVrvhY+rIC4PScn1eh2kV2QP5rrz
   u2almKmV9YgCkFcE4W6WIIwGqqTCloF6GKCi1MusSPOVgllxiQi8iH5BJ
   rVpvqs9D/WWLjJO0Z/GRxHpgqJP7LGOfzhBTr8z+moMpATQ4V1BzofJqe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="281636682"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="281636682"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:46:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="678351820"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2022 19:46:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:46:24 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fV5M+CeDbNVwwebQ3ZTJvWdy42n+j5p9ID4I2YKw6MT0nBP/ogr+OOxO5oNWd7XgeNQaXGGtEpxFW6Lcy72Vft2AydJXwEEcvGJ/RQvc1wWVoFmWjwlSt12l0WAByEex6isL0h92T2E8Sicvd/25uLZO/wzhaXqasjUioiVOrtsnsH37O7yySQiQv2duCWOg//iCKAqpoTQJD9zcqbYVjQmNoioZ3tIEpk+Pnp0Ahz/ANMI4sd3HQvm213hCBLpgk+xeApPUvg/VuqOG3czbbt4USdFc98eF/qTBFYCkGQXtXOPi/A4zYdFYWx2mQnkCO+YBrm+92DSJASARi3qiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=171NWBtKaPm5nSeXoPousOa4CXQP9Cpm2WgeN21ciYs=;
 b=MYO82k0CKLHyEdd/Bnr9d5HuCEAjm4dQIweLrsMxeWTpziba5Ip3IwQgbEvc4jt3WsMwZ28SFy/HoGT5XJABMCKXfxUBr0JwRiDSqXXxFoRXFTPOH0MRxcYtURVY13zWt2k85zPWkNYW+4n+YrUOiG4sgmmfbjExSeg9zRwXpxl4VmEphfuYZW/sZxpC3AI+wyZ2AzxwAMcEUmT1rB7UgDiBdmb7v4PNfUQM59yvH4c6vVIuW2if1ckx6u3w35GjmgsPM+7u4Dh0yBlGb9GJD96FXRKELHy32IDgN+UcPsAKAotmYN36wApdpQ7eDDkGfDYUyoxOf1NKYwYt3jFs8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:46:21 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:46:21 +0000
Date:   Thu, 23 Jun 2022 19:46:13 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH 10/46] cxl/core: Define a 'struct cxl_root_decoder' for
 tracking CXL window resources
Message-ID: <165603877351.551046.12325060612893557716.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MW4PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:303:6a::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46ad0e6a-a411-48f8-af55-08da558bb4fd
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1ZKApUkUozfk7SJQtrJYvxyLkjAqoojU8CFZm5xredGa3M7bzC8LH0X52RDHd1DxNN21LAeEoGbcdKnI9XKn4wdH9qt3l03fmJwqT0Zpt17k1da9PydQKlTNycHGP50UVrMOUzC8GznUy76/eZUu5IWQYX2tje/llPL40CciIdfPLfgTqoWXvw+wbl5QvcYJiAMVhfgdMcwhbJ7NT3Z7Rg9rxhV4GG2Kqmbm+3zVUpZCpLoDzVu53F+rlpU5vNfpVIGS0oJc9eFsv8aPE8tUw5pvpxLYvm0UdgBW/8jQ6DcWQhnlN4FrPXXQam+0gI8Qr68ErohMVhAMAJs48sXrap//ycHY0m2NhcaM0t9UVpEfYhZGY4LFsS5Ubkv7oKZ9fkQ9Jna4S3cyYQWWryoYe8NFfK3u20dtdbHiix5lGoHw7RrNpnCq43H5k6HXSjUY/bg+BeOLjYsma8gPy80TRz6NbNGMVOjyqENjQxoci6Mpj/uqv6fsw1jgckIsrbwrgLst/uh85mWHZDLlcPm4C7nx//bVo0L5w0XMtMGWnC80H4SxEaopkGc8QsE+Fvaw6TSsm14TwXmfuBXgNurptl0SoVcC41OofCeDRyH8R4h4+V6Ln6mVfQT1tjD9GARpEzsVofeOp1PD24lOIdWgmeusXkwt+2Yn3xjosZiIu50OVyJw6fWIYGUBNKw1kC0A6kkR7H9ZBICzJ7FYJrvsW7N+impD81cHWEcYZPlHoQA6ymptg1faou1Xhxmi2jl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(6666004)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?INkuCRMje/7Z0ZV2VNs9spJDGX/M9AbgnzY4Jg9T2wTjubdfm9s3u1FcFEug?=
 =?us-ascii?Q?wPLH0ynf4Y8H1x6rwN2EaPN+j/inVVpGHxGKlpomvVF+7n5w1PN76EfFd27z?=
 =?us-ascii?Q?GGDjf/OdfXdSfSGQmDdGkud3QNQ2kFDzlZgyb/dVbZHd5nBs6hozEpiSSXbq?=
 =?us-ascii?Q?JUAY+GmhFv7J4ud2rLDHoNpYNihRExQT4zwDDZZ88TZkosGtRLpIfTrqqKUu?=
 =?us-ascii?Q?AHXKLMcfTZHb7fTqX5A+DUFlyb0az4EJKhpDe8lEe4g4XXtT6w8hUpx2Du8N?=
 =?us-ascii?Q?kEI6adtchb6D9YS/01ZMZKz/Ubqq3eJ3ivnB19UsRRBuWvciK1+QGBHiq0sj?=
 =?us-ascii?Q?HaP8kArbQuOiMNbuW/z0iB6lT9o5sDK161yyJySzlApWJYNKawDGunW0Dseo?=
 =?us-ascii?Q?hhDM8adZiqmJk4IU1fUm+gxgfAp9tQLKolwodTn9+dUYjYADZbuY/y4i7r63?=
 =?us-ascii?Q?+9KZJx5PU1qV8BLHT6JDoi0P8Efw69w2kW78S4ZMw4mohX9n2pKajZvoPpFR?=
 =?us-ascii?Q?Vw8/gGnPNuAlummcM6LK1GcT4u8evsf4fNGJKmuaTEk5u9cjvmUAHI75umW0?=
 =?us-ascii?Q?oGxMLUHDeHuWGRfcgZkVT0W6ZtYoT93P//Ha1SqD6pxSs2sZiGSaU2tv4D3o?=
 =?us-ascii?Q?mMbJGULO91m4su+9Jq/hgw7tKHZGDSeR+3W/00WSDu0IUxmsrqdi0z0WwG4W?=
 =?us-ascii?Q?WopmP+6DPMlS4TCvc2J8MAgWKrUZGQ2cdWLcsaLpWDFRZ0rtF7V93QzuZivo?=
 =?us-ascii?Q?vS1H1WQWrod+gt6DxOgLoIEM2OZ7YjXNXWm5cbm66Cjl6trnVBLiQIEippPc?=
 =?us-ascii?Q?U/k9fGEs220/YUdNgKr2m4TKzx/HeCurCZuxO5v98mBcajpkEWSjS+etJBbU?=
 =?us-ascii?Q?liP8SbiM728wDcsl6293G3r30exfadeetyiJYBRYt7Sv49eC0dCsZeu2QLLw?=
 =?us-ascii?Q?5QMMYk2F7CsqlO3eZ8HHVlQmFTLPxW8N77f94VmxAQt4rauBY3/cBN73MGn3?=
 =?us-ascii?Q?ebm3S2U3hizfrAxEuV3oMaRH3f32/i2cN7V2lwYT/DpVDrUvM/B3edAaLYr+?=
 =?us-ascii?Q?4BMfph0+UbfJayj3Mhplwifd9e/0tqZ2JHc1tmesrBuwlc6I7U9+Q6dGHpvd?=
 =?us-ascii?Q?nV5BhFikQqQLR6BFxI0hDay0rJip3h+hKMO86Ks1PAupWF7JBF/kAMzsevl9?=
 =?us-ascii?Q?rAqNv4h/aqaHhaUxRuFfwqLQBKP44jHJa696UzGUH7CY6I5+T8kXZKQn0815?=
 =?us-ascii?Q?kvqOtfAy5vAh4gcwO+MxbbpOEufopOCGYzBbKBOzR5EmrNHGe4tXDY6dZqJI?=
 =?us-ascii?Q?9gPskQa28v14Mmbt+CsF2aRpd8spVzQkpxEOE0Q+S+HqH5HnrSiEhgqGtfyK?=
 =?us-ascii?Q?ExoapzlNcbP73SjTQJHiaw9Qtu5Hv8onn6UggLEdsQprzcOGjuXk5zQIM31z?=
 =?us-ascii?Q?SOgw5s0iOvjCpbrMon2LMx0xt1Fq0iq9Lab5m8muRHjLotJcnoStLUeh2TO/?=
 =?us-ascii?Q?XvYE5+G2lJqQTpbcsw9kMIGGj90Bn5qBrcz6eqeJ5CYin1unV+fH58LakWjO?=
 =?us-ascii?Q?MtZ4WO4jL1Z6znP2PQADXsGZK9TE53LsF8K/OAf6QQaXLY41+z8r50Ot/K57?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ad0e6a-a411-48f8-af55-08da558bb4fd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:46:15.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvqJTQOsngnUkWVJF5shMoUF187er3Ep3DAJL7hyoZ2LPrPe3oj98I1WjCnnPXWKOdrDJS2xLz9kMo5vcUnXkKLvU0BqnTgwk8cpJMjsd3U=
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

Previously the target routing specifics of switch decoders were factored
out of 'struct cxl_decoder' into 'struct cxl_switch_decoder'.

This patch, 2 of 3, adds a 'struct cxl_root_decoder' as a superset of a
switch decoder that also track the associated CXL window platform
resource.

Note that the reason the resource for a given root decoder needs to be
looked up after the fact (i.e. after cxl_parse_cfmws() and
add_cxl_resource()) is because add_cxl_resource() may have merged CXL
windows in order to keep them at the top of the resource tree / decode
hierarchy.

Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c      |   40 ++++++++++++++++++++++++++++++++++++----
 drivers/cxl/core/port.c |   43 +++++++++++++++++++++++++++++++++++++------
 drivers/cxl/cxl.h       |   15 +++++++++++++--
 3 files changed, 86 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 003fa4fde357..5972f380cdf2 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -82,7 +82,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	int target_map[CXL_DECODER_MAX_INTERLEAVE];
 	struct cxl_cfmws_context *ctx = arg;
 	struct cxl_port *root_port = ctx->root_port;
-	struct cxl_switch_decoder *cxlsd;
+	struct cxl_root_decoder *cxlrd;
 	struct device *dev = ctx->dev;
 	struct acpi_cedt_cfmws *cfmws;
 	struct resource *cxl_res;
@@ -128,11 +128,11 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	if (rc)
 		goto err_insert;
 
-	cxlsd = cxl_root_decoder_alloc(root_port, ways);
-	if (IS_ERR(cxld))
+	cxlrd = cxl_root_decoder_alloc(root_port, ways);
+	if (IS_ERR(cxlrd))
 		return 0;
 
-	cxld = &cxlsd->cxld;
+	cxld = &cxlrd->cxlsd.cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
 	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->hpa_range = (struct range) {
@@ -375,6 +375,32 @@ static int add_cxl_resources(struct resource *cxl)
 	return 0;
 }
 
+static int pair_cxl_resource(struct device *dev, void *data)
+{
+	struct resource *cxl_res = data;
+	struct resource *p;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	for (p = cxl_res->child; p; p = p->sibling) {
+		struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+		struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+		struct resource res = {
+			.start = cxld->hpa_range.start,
+			.end = cxld->hpa_range.end,
+			.flags = IORESOURCE_MEM,
+		};
+
+		if (resource_contains(p, &res)) {
+			cxlrd->res = (struct resource *)p->desc;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
 	int rc;
@@ -425,6 +451,12 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	/*
+	 * Populate the root decoders with their related iomem resource,
+	 * if present
+	 */
+	device_for_each_child(&root_port->dev, cxl_res, pair_cxl_resource);
+
 	/*
 	 * Root level scanned with host-bridge as dports, now scan host-bridges
 	 * for their role as CXL uports to their CXL-capable PCIe Root Ports.
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fd1cac13cd2e..abf3455c4eff 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -259,6 +259,23 @@ static void cxl_switch_decoder_release(struct device *dev)
 	kfree(cxlsd);
 }
 
+struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, !is_root_decoder(dev),
+			  "not a cxl_root_decoder device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_root_decoder, cxlsd.cxld.dev);
+}
+EXPORT_SYMBOL_NS_GPL(to_cxl_root_decoder, CXL);
+
+static void cxl_root_decoder_release(struct device *dev)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+
+	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
+	kfree(cxlrd);
+}
+
 static const struct device_type cxl_decoder_endpoint_type = {
 	.name = "cxl_decoder_endpoint",
 	.release = cxl_decoder_release,
@@ -273,7 +290,7 @@ static const struct device_type cxl_decoder_switch_type = {
 
 static const struct device_type cxl_decoder_root_type = {
 	.name = "cxl_decoder_root",
-	.release = cxl_switch_decoder_release,
+	.release = cxl_root_decoder_release,
 	.groups = cxl_decoder_root_attribute_groups,
 };
 
@@ -1218,9 +1235,23 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 
 	if (nr_targets) {
 		struct cxl_switch_decoder *cxlsd;
+		struct cxl_root_decoder *cxlrd;
+
+		if (is_cxl_root(port)) {
+			alloc = kzalloc(struct_size(cxlrd, cxlsd.target,
+						    nr_targets),
+					GFP_KERNEL);
+			cxlrd = alloc;
+			if (cxlrd)
+				cxlsd = &cxlrd->cxlsd;
+			else
+				cxlsd = NULL;
+		} else {
+			alloc = kzalloc(struct_size(cxlsd, target, nr_targets),
+					GFP_KERNEL);
+			cxlsd = alloc;
+		}
 
-		alloc = kzalloc(struct_size(cxlsd, target, nr_targets), GFP_KERNEL);
-		cxlsd = alloc;
 		if (cxlsd) {
 			cxlsd->nr_targets = nr_targets;
 			seqlock_init(&cxlsd->target_lock);
@@ -1279,8 +1310,8 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
  * firmware description of CXL resources into a CXL standard decode
  * topology.
  */
-struct cxl_switch_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
-						  unsigned int nr_targets)
+struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
+						unsigned int nr_targets)
 {
 	struct cxl_decoder *cxld;
 
@@ -1290,7 +1321,7 @@ struct cxl_switch_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 	cxld = cxl_decoder_alloc(port, nr_targets);
 	if (IS_ERR(cxld))
 		return ERR_CAST(cxld);
-	return to_cxl_switch_decoder(&cxld->dev);
+	return to_cxl_root_decoder(&cxld->dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7525b55b11bb..6dd1e4c57a67 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -253,6 +253,16 @@ struct cxl_switch_decoder {
 	struct cxl_dport *target[];
 };
 
+/**
+ * struct cxl_root_decoder - Static platform CXL address decoder
+ * @res: host / parent resource for region allocations
+ * @cxlsd: base cxl switch decoder
+ */
+struct cxl_root_decoder {
+	struct resource *res;
+	struct cxl_switch_decoder cxlsd;
+};
+
 /**
  * enum cxl_nvdimm_brige_state - state machine for managing bus rescans
  * @CXL_NVB_NEW: Set at bridge create and after cxl_pmem_wq is destroyed
@@ -368,10 +378,11 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 					const struct device *dev);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
+struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
-struct cxl_switch_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
-						  unsigned int nr_targets);
+struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
+						unsigned int nr_targets);
 struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 						    unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);

