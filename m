Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4685D558D5B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiFXCp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiFXCp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:45:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBDF56C18;
        Thu, 23 Jun 2022 19:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038757; x=1687574757;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EXnWE+J7Zp2SpNCBIEYR4p0bDMEhSMIZs+lhC3Q9JXU=;
  b=V4CpHslO3m9D3A7zMAMbmhM3nnb2JwcwOJNEVPoqV1BGVw2RwQ313C4o
   ZAO4W6vN1UZSXu4Tds0e3daICbEFo9qp1WVHzLXya/W6UwuoY76zxEKyU
   zwB8uootXzh94Dt/BnMzXbJZiMxfvelAL2ozhYt+rc7cYNNPg7c0xpGkq
   H93HbGNNf+598M5EI4Cpxls/jsyYoILNXQxGhKKf48mrVfnoyKXTcasRf
   8SJJ+609HaeDyIDVUv9Wqo6jw87Zx6T1s2mJG5SaK/nHucNdloog3FBtO
   t3wTgTHFCsP9FFizlvSyTfAagoLlyl43YYN6nwdN+PCquzVNafZb65iE6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="342591917"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="342591917"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="678351656"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2022 19:45:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:56 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:45:55 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:45:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqrSROwq8oBKU+KuDJidfxVDpjENctTd2B9hSmr7XGardAiZ7/CTeFzdDi1Yw5LuxXpCKDNitwInepPLChfkKjiQcUpOiBXTfaIrIbZSOkZn74mG80utLSp/+RYt63nnm105deUUEJ3RSwNjxrrFQmpqSyKbiq7uj3LDVa0xlbpM/6u/FgXn0H188zKP5fk37KuzD1qdweandk7i1yfBcdxJjWPS8gD+QZajrEawIuj1veYbYZEpD0H7PAXrda6OBGaysBOV7wVbYMGoew/qFyM1pgH8cuhFnGFFkXpMbWDA1oKTsBAR11ZkG38GLaEKw6/aG9lZLWQBJdIv/j06Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPBQ5ilRJFGXxFOLqWib5IfP11kcFJ5soRm0M4uVu9k=;
 b=gQHppd2LR8BW15g64JdprdDcCwPy4EVwMIL/t+t48cEulU2VLdAmZQvbqSWnYePEgsG7h721VxOBrqaPWi72bOhxPEDnNNjuHQFDQCorgB6JdhAMV2f+3qv8Y0MZ/aoAtOAKJpi3icdRE6T5bqRouH8wUONNDpUR2xTPuUItPvb81vhjxjB/5yuEu/fVajxI+24bQ+xKN1e1ybiSv58r/CWukEeitHNaKjLZa0ri4J4tncBL1sYYaMVxCu9dgHJyGS1i4Vi+dlC92LSSmuIoZiga9wkN9q5Oz1wVcPWWj8NO7kXED9A1DV1HXOy17r90MJAXyb84Yr9L0A5FafjVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:45:53 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:45:53 +0000
Date:   Thu, 23 Jun 2022 19:45:50 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH 07/46] cxl: Introduce cxl_to_{ways,granularity}
Message-ID: <165603875016.551046.17236943065932132355.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MWHPR19CA0078.namprd19.prod.outlook.com
 (2603:10b6:320:1f::16) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f9d6f30-8cea-4d77-58c9-08da558ba741
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FtrY4/C176V34LNqZ8qEa5iwClz0N5z4gAUgASbZ4LjsCd2H8PhLAxEDskBybhyx02nJVV3c93ab+5anV59oZnD7mjF7vsM509tEy9Ei8e8GLyTNqT32gYcQf9y4LBq19nSkGaDAQ1EZsXH9PUR37ibqdnCLRnP8NfhhsX7KYGid/SPC7WObC83jPVY+LupUVDffmVwkDDySMNzlPfzRUp765CA8Pav7Tj2IQ1VZ6LKu2jiJCRjNTJWNvDcP+SsCL7WLI7YVqi7us1ZwykGoApEw2MWTilTdW4I448ytmAcCkXbBHhzqDYR9yi2qOW9wq+sXK9GtqJxHnjKQTC2URaq/ZPC1n2Fg4TGK1j4wtTaemKeAYSZ9IozY+Ai+BmmoJ1tvM0jqhepfa5oJC2+2O8AVu4LlpfUEIwMG+vXaiUOXTFn3EDVjqLL9T6SVmz0Q/O3sqrlyHN5TALLllN5SpNmmDtTC19HT6nSYGu6TtL49+uuPtbial/l+BhslpMXdwRGZPx/YBitO3+Y0DVxku9Ynj/shMhkRnBfu32auxIohZC+nyopV4goZNU99xbNlsTiSYWyKPiUnykmZzbiiFpsnYCqdoOhQcGkAPYgNBXbMPAH5bXK470WMVw8GvKCIUq867YH+S/if/1UtBHJixk0K3nrLcdBAy1rRSlGfFrycQeT0zXsJA6BpJtVHF9SViPSIjmjOmA/xj1Aca6WoCRNNQ6Rmxbqy+/ENP59qoHlJ27TZvdTi7Cio/+KwK8X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QsHC+eNFC8puJXMkKV2oUlyjw7g2A+8sVDnfeqqfzNl+M4zWgmT64b5oXTdq?=
 =?us-ascii?Q?rdJlguV9c/3lrteciVeiQHUl4Hl8upSoMtbnCLfRMgQDPbwWhwzQD8GprnoK?=
 =?us-ascii?Q?+2/Q2wAoWXVyCvuw1+KBw9H+RtcU7g7w1xHiuBcKxFlt0slur1z9Ua+wZMlE?=
 =?us-ascii?Q?XrGMkxGiRXQaAY6Cc3Kj+2It4IN4wtcUi2zI6pHGVIQh4S1lw16ewZhgSyg7?=
 =?us-ascii?Q?UFagVBBR6L+4IyzS3mmzKEKP45invRswJ8ENMyloHhJXup8mcGRF0b/PUWXW?=
 =?us-ascii?Q?59XRJfgKNG5Tn1iKpfEsYQL9cRm1T2GoDV/aYFK6NHHEGSLwwU8L5loA+5ln?=
 =?us-ascii?Q?AoloMUilKHzRrdcP3ubJie5gxw0xEzFVWAK09oJKidBdadHwBEyUuNXNn0p/?=
 =?us-ascii?Q?+Yi8t7/VrsOl0DIEb5t1ZiV8jekdHfFd4YSuRUpvJ1i9lGxvBw8vjzLME653?=
 =?us-ascii?Q?92CCvyV2Ng1oOU7Ywe5D6vDL5LFY2+RaXcbxPRVDkhc9cWFx4LfypC5rnT8z?=
 =?us-ascii?Q?C2RUbxCGWkMpk/1DPz9C60WZVPk6HxXdCoQsDCWlLhvpK7j3QImnGjeKa4Ce?=
 =?us-ascii?Q?QvlYX8Xk8++WbuwsXtCggEaLcRvwDRzx8I3WNRVxBiiFHtzYbRJ52pvuX3BE?=
 =?us-ascii?Q?pGJgHBVqiiw7tu6hjCJ3TTgB2cTIU3NjKr87EyXiVRFtfcCc1o/zjrJ6TRcG?=
 =?us-ascii?Q?WIqt284sbUPcrrql3mcbEjcPvzJ3zAHRlwKvcIb5bR/8y5ohR6zz6uOd4Q9F?=
 =?us-ascii?Q?Iz0UJqbVlOAsfnXqoMjpEkCS9oeEugyx5obpfulk6F8RFx7c80wFiYc3bW6H?=
 =?us-ascii?Q?ZxwuMJGCdB5lyL5nMHkESkcb1offi4GMJKgXgYrvHQpGUX/Z1TwbDtAPCx7a?=
 =?us-ascii?Q?pkDhbLZ6LKC6Yy/lA1gQeUvoouBNVKxgEiR8Iir6RQ5bYv2j4VwCwj/DcdGG?=
 =?us-ascii?Q?C4pSufrF7W8RpdYdMx6HG/N5tQ9CqVwhiT/8KhoJY8iO3h9rDeUzl+bJhEhY?=
 =?us-ascii?Q?K1HKti6kQ6x9FSjefHYv0LIhjXz40UuyuZALNUqOglK1fMAFdXnI1ovATv28?=
 =?us-ascii?Q?r2GY7eh03J1hPZP+S7L6KQDXSHlseqstMm+Dtf+ZksYs+T4jXIlv6MgJOSXU?=
 =?us-ascii?Q?tevDvx9zBZ+klarZW13MyhHxdC/niO2RmY0zRRUQElR4tUMrJ2FMxrfn9jSB?=
 =?us-ascii?Q?MOcWOKdCt34qZBFWH5bSDIxF6T//TxYqcm7QdCUO4FWM5+rkGPG/W1gDbrjm?=
 =?us-ascii?Q?/gCfxluOvqa7bxF9A1n6k5mqR+TdkTeiugdzcCtm6pH6a3a3RffOUkBwd7H4?=
 =?us-ascii?Q?wYZ1is15QpgH/3udScVHJyr2e2ELKdVsOhvXf4BkGybRhecc5IavVcDmRUnQ?=
 =?us-ascii?Q?zIrjXcoR8JeGHBnZwY01M+28EEE10OgYH5mxCZRNWD1QBvQB6AzBP2ovnXgC?=
 =?us-ascii?Q?b3nhrT1brh17alXfOgVDGZ53kSan3MTzZyQowcWQpGoIjMJ53rDps5DkmHg/?=
 =?us-ascii?Q?71Dpp43kqOXpEYKIHMpnEbFGNVYvXpvgrJvXvgpZoRw0DDKUBD3H+nUoa4jf?=
 =?us-ascii?Q?zy6vxzGnB42s2MYaT5A0tmJsn5YgCCuUf2d/Om+U50g3FW825F1YP6SNY3Wk?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9d6f30-8cea-4d77-58c9-08da558ba741
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:45:52.2645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoGLnbdBzGNix9KRAyRLCWbFKkEg//5Z4iPYChZMB/7GKOkGHXLnB4DRjfFzqYGmFwLvHcgGEStL4IXavB73v+idU0Wf4DBjvSNwM+iObv8=
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

Interleave granularity and ways have CXL specification defined encodings.
Promote the conversion helpers to a common header, and use them to
replace other open-coded instances.

Force caller to consider the error case of the conversion as well.

Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c     |   34 +++++++++++++++++++---------------
 drivers/cxl/core/hdm.c |   35 +++++++++--------------------------
 drivers/cxl/cxl.h      |   26 ++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 951695cdb455..544cb10ce33e 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -9,10 +9,6 @@
 #include "cxlpci.h"
 #include "cxl.h"
 
-/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
-#define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
-#define CFMWS_INTERLEAVE_GRANULARITY(x)	((x)->granularity + 8)
-
 static unsigned long cfmws_to_decoder_flags(int restrictions)
 {
 	unsigned long flags = CXL_DECODER_F_ENABLE;
@@ -34,7 +30,8 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
 static int cxl_acpi_cfmws_verify(struct device *dev,
 				 struct acpi_cedt_cfmws *cfmws)
 {
-	int expected_len;
+	unsigned int expected_len, ways;
+	int rc;
 
 	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
 		dev_err(dev, "CFMWS Unsupported Interleave Arithmetic\n");
@@ -51,14 +48,14 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (CFMWS_INTERLEAVE_WAYS(cfmws) > CXL_DECODER_MAX_INTERLEAVE) {
-		dev_err(dev, "CFMWS Interleave Ways (%d) too large\n",
-			CFMWS_INTERLEAVE_WAYS(cfmws));
+	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
+	if (rc) {
+		dev_err(dev, "CFMWS Interleave Ways (%d) invalid\n",
+			cfmws->interleave_ways);
 		return -EINVAL;
 	}
 
-	expected_len = struct_size((cfmws), interleave_targets,
-				   CFMWS_INTERLEAVE_WAYS(cfmws));
+	expected_len = struct_size(cfmws, interleave_targets, ways);
 
 	if (cfmws->header.length < expected_len) {
 		dev_err(dev, "CFMWS length %d less than expected %d\n",
@@ -87,7 +84,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	struct device *dev = ctx->dev;
 	struct acpi_cedt_cfmws *cfmws;
 	struct cxl_decoder *cxld;
-	int rc, i;
+	unsigned int ways, i, ig;
+	int rc;
 
 	cfmws = (struct acpi_cedt_cfmws *) header;
 
@@ -99,10 +97,16 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		return 0;
 	}
 
-	for (i = 0; i < CFMWS_INTERLEAVE_WAYS(cfmws); i++)
+	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
+	if (rc)
+		return rc;
+	rc = cxl_to_granularity(cfmws->granularity, &ig);
+	if (rc)
+		return rc;
+	for (i = 0; i < ways; i++)
 		target_map[i] = cfmws->interleave_targets[i];
 
-	cxld = cxl_root_decoder_alloc(root_port, CFMWS_INTERLEAVE_WAYS(cfmws));
+	cxld = cxl_root_decoder_alloc(root_port, ways);
 	if (IS_ERR(cxld))
 		return 0;
 
@@ -112,8 +116,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		.start = cfmws->base_hpa,
 		.end = cfmws->base_hpa + cfmws->window_size - 1,
 	};
-	cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
-	cxld->interleave_granularity = CFMWS_INTERLEAVE_GRANULARITY(cfmws);
+	cxld->interleave_ways = ways;
+	cxld->interleave_granularity = ig;
 
 	rc = cxl_decoder_add(cxld, target_map);
 	if (rc)
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 5c070c93b07f..46635105a1f1 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -128,33 +128,12 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);
 
-static int to_interleave_granularity(u32 ctrl)
-{
-	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
-
-	return 256 << val;
-}
-
-static int to_interleave_ways(u32 ctrl)
-{
-	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl);
-
-	switch (val) {
-	case 0 ... 4:
-		return 1 << val;
-	case 8 ... 10:
-		return 3 << (val - 8);
-	default:
-		return 0;
-	}
-}
-
 static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    int *target_map, void __iomem *hdm, int which)
 {
 	u64 size, base;
+	int i, rc;
 	u32 ctrl;
-	int i;
 	union {
 		u64 value;
 		unsigned char target_id[8];
@@ -183,14 +162,18 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
 	}
-	cxld->interleave_ways = to_interleave_ways(ctrl);
-	if (!cxld->interleave_ways) {
+	rc = cxl_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
+			 &cxld->interleave_ways);
+	if (rc) {
 		dev_warn(&port->dev,
 			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
 			 port->id, cxld->id, ctrl);
-		return -ENXIO;
+		return rc;
 	}
-	cxld->interleave_granularity = to_interleave_granularity(ctrl);
+	rc = cxl_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
+				&cxld->interleave_granularity);
+	if (rc)
+		return rc;
 
 	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
 		cxld->target_type = CXL_DECODER_EXPANDER;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6e08fe8cc0fe..fd02f9e2a829 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -64,6 +64,32 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 	return val ? val * 2 : 1;
 }
 
+/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
+static inline int cxl_to_granularity(u16 ig, unsigned int *val)
+{
+	if (ig > 6)
+		return -EINVAL;
+	*val = 256 << ig;
+	return 0;
+}
+
+/* Encode defined in CXL ECN "3, 6, 12 and 16-way memory Interleaving" */
+static inline int cxl_to_ways(u8 eniw, unsigned int *val)
+{
+	switch (eniw) {
+	case 0 ... 4:
+		*val = 1 << eniw;
+		break;
+	case 8 ... 10:
+		*val = 3 << (eniw - 8);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0

