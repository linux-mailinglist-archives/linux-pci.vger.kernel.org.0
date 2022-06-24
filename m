Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1610558D6A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiFXCqt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiFXCqt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:46:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9866A56F81;
        Thu, 23 Jun 2022 19:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038808; x=1687574808;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=31yi+nv/vyhzD60tgN/bHwd3mp6iHkIHNuQoZZz19ts=;
  b=NNevGeAF1qEUJSbSO5UfmhyFxVEmF85ki2EBwwc5Hm9xlyQ+0cXiCNor
   9djVHUbZ7+oEkfkW9BjQGT+1/G2Go5m/g/3giEns2p4gQp2kK/BA6V+1a
   SEjwosr8iQu1nRnmK0db8y0WMxw+DmiUUTbohJ1l6QEMy82is1MBwSvZu
   dWhrsctknU1ERGfCCbHxD06QA546yswx9uR03H6IibyiLQkJgJ0RxrfE6
   Vk6mQyfYiUr4aoiXfueoiumo3iKfnmtolYnbQ7hSsR7emyFdq1ht3Tfxr
   RtBKb6cUa+E4Y2aJYPP2txcMY39TKfnhzAqv68Cre6yHLMXGGsz2cQveb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="342592102"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="342592102"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:46:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="915490643"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jun 2022 19:46:47 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:46:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:46:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGA8uPd1PkYfhxeNhM572t0hVWjs92SUakGxDthPIHEHKL/WkmB19XNb4c/f4uHKtBRlmXT53D0sk1CqcyAwpquFZoYaCfklJ9E76FkafFBQr8WqJBn5LAfolHM8NPEz0ysHFXEpZeyxS+rDOXTCHnurE9o4BKmO4jyM2GwzNh6pLgAhkeZd3456zEYPYJjLh4/iyp3e78sKE1GMngZ2Gsyrkp59zH3H1V8w1QrT2YPEqztv6v1JLyNPPxZeER+IWPFjuhBE1H3ykmOckLUDu87j+2/ShOPR3BbutPsUZ/kA9TuQk91t8dI7g8BwXwSyPAERisluwP/iOijCjdebcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxf4a0P7ECbLbz8NoQBL7YOPQ815f5aomwrMo88WKuA=;
 b=LTPFIfRsFo0/TY/o56pkxNqBWDBvfbs4D+0IeQrA4m80FAwgoVz/Y6Ebt2ydMaFTGtwlKVZq1U6+hPXSu1UGe6TxA8p/wJZUSclFXNbpIgGO8jod11YhTnjs7N/mibEEfPgVcH+1qI/LAfMfjL+QC6g/KbYegkzTeHUDEnVc1dKbvn5E5Cs9QNyFO7st+yoEGY9PHLYZ2vvQcLENRjPzxw/ONgmoDz9J3SQIE5x1z8jMZc4yyzlr+tmv58Xd7cfm4WiZ8wmNHNKV5AZPKiHsinURMZ6J5YnBaBthpLMp/iQjt/yFf+wjW+ff0ZJ4jL9ITZFfwTbhPHLmjNlrKkoBNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:46:45 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:46:44 +0000
Date:   Thu, 23 Jun 2022 19:46:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH 13/46] cxl/hdm: Require all decoders to be enumerated
Message-ID: <165603879664.551046.6863805202478861026.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MW4PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:303:dc::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ff7ed02-d576-421b-6a42-08da558bc29d
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4vK4/LpbXUvIXAlfcBP/piaB7HUQ5/kIb7q9do6xzGvFTP17TRc/byudqiRyGkpS1lpixrdfnWeHEzOiw1A6xo0ApZF3MvCf5rWGXHq/54fvyhdvL+4pKs1/o8riqpFHMoUugNNJIpvB76WngeDlku7m36m6o7mr07QFwSicpZDIW6Szf3iwOV1Jygz+Qno4+pfqnuQzYrdd7gmkEQvGGs/UNhVkPl6j2j3t6e9JzwFEit4gGvFCwFo7kchdTuCHo5ZQYZe2D7kc00PYXjogmStQDk9IVy8OvhctbaaBVqp9d3j2T/EBOVcVb7vvMs1q3ORHA2aPwDSeRUUR8vnJDcCj33ITeWDhFWQZpdJXDRH3cm1cUXqCYVdyA1qp9jlFbXlnWp9xAgbD6/mqHzAL61Hy+4MjKVYnG6upo/g8PIgYGXFK+ZgGq31eSu3w0r6TzKu7S08pYZqWl3zRPS2ILjJMiTANdRJWn/t+eTZ+hpQCTV0Mw43N9aOJoh1c3c098nhekQuggS/V9fMh3VbAcV4B5naQPlN0JrfpEpJBcCfKkto6Ey4V5HKMzqE5D17bgxbYqu+dDDHjqujaZwo2GLZ37H19Bvi5x8lZHiYAmhe08i8rsbePELIdT7BUv/L3ooSzX0pcTw9Ef96YNsXe2P8w5JCCv7Pafazn4ljzxImzQjnJRTQ4kXNadoemAtteQR551h+ksd9amsdI0Yrur9mPTGh+CfIVqWWXP1tpxN80brOIxaKwbS6wDRrw1/F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(6666004)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ps3J38ZwRKAGKR4zQk37PEXjR3c9ew+PuztY9y05erhpBsv+ntrXS3E3rHzi?=
 =?us-ascii?Q?cM/tutEJ3kFpixiAMyIQlpXjqljJ18pGDebVYapVrdsyJACSSrrYqfPfhEsj?=
 =?us-ascii?Q?oQidrXDTXsoRC6yEju3HYWNZ5RiKCteZdnqqvzVZmXEl9rhZCqorfv/O37Fs?=
 =?us-ascii?Q?c+1YE/XjA95Zcdn4/2i4mdMVP+rTpnzhQRbfUNt3A3VPMWRl+xBaeC8mjKAC?=
 =?us-ascii?Q?/QVpox6l1ONbTyyXuH3wHzZV3kT1hX6mhO6vHwehIy+m/8q5Fw8sHjFMxlP2?=
 =?us-ascii?Q?X3pkP4tnjSC6KZW/CXhIW3/Z4vWGr7h9lK9OxNW/B1+U7oL3ihl9kcB6crdZ?=
 =?us-ascii?Q?X5HWVY831i6kdewhPFd13mu17sbZvVg/24ESLVz1lEBKt2hiqpP1/mC/KNqb?=
 =?us-ascii?Q?o8FD0Nd0PUAC1G4uVV/OhH8Yyj3oHvcoe6eAoFV2wMbzzd1FAGaUFQuc9iVK?=
 =?us-ascii?Q?9KXmnIPla3kMr75AdBZbWJ9y+kJCVB7iy4dgmZmm5OILH1ESHpKS5wixREgG?=
 =?us-ascii?Q?VpfZ1JDTrrNgBQ5Mn1w1TLJrPbBywpHha8vOXzCcACX67Xc6cIU5Q7FCHKhI?=
 =?us-ascii?Q?RoOot3gsTL3o1gnTSnfVSD0fpy17CwrCUBJ6OE76xn7sxura6bZmZWDIFfLe?=
 =?us-ascii?Q?P6nttUp6qTCvJoyWTXgOK2/ancgbmmDb7+T76ELwNN75eVmBF0ZH/QZcFrR3?=
 =?us-ascii?Q?0eGAMLr0gsysvnJAmUqdHF7lZQloBTAbxAQHnWCguokCaDc8lWC4bcMFm4lE?=
 =?us-ascii?Q?6k7Fn7laut5PlLSlAWRuKGmgFS+BV4CUJ0N+PEqOAdehXsWe+k86pxS+Lrfi?=
 =?us-ascii?Q?/SJ3f7qO86V6zsAp+Uh9gxb624gDmFHJmDXqYJks1FrxghF1ocQ7upVJx4aj?=
 =?us-ascii?Q?2PV7QkhA9vQj3wz1tZo2N9zpOrQkGjIYJPg9M/bvjnJSBdzL6WHqPAXE4WY7?=
 =?us-ascii?Q?sGOKxt3LtBOAcxdBIPzfqO2onTGAOZLTNbtiHpoHMqoLfDiuqWi9oTo8cOmI?=
 =?us-ascii?Q?3zRzeuxtuDMFB1ArUzCowLSNTZZ2Tp5smAWLOul+cD3SGcPFAEQkLFDYJIma?=
 =?us-ascii?Q?XXBpSD0mwGohj2s25KKkINM7Ft3X0Oxg2W7H3QY7B5fPTH3dmxkcpVPsii0L?=
 =?us-ascii?Q?cuqbRFlDkE8JqSEhYWiYE9b65jO9sk/7X9NdgI+jvYblpIynBo7ZyQ4ZNy1z?=
 =?us-ascii?Q?HYCGPaBxiSinTx7uhQQYTX1aOV8Es09SerasT8ilrboC3jYpNlG3g2JXcrZ1?=
 =?us-ascii?Q?avYCW5VLw6mDnmUohLSvDUD8ZDm08Rj6Nlznj8X7gPE9fTr0za9cfnTuWRb+?=
 =?us-ascii?Q?A14TV0NAvLjDTNqEXj6TerYV8BjUK1h6aWHBIwEC7NR2hUfZEJVWIUqZNDxm?=
 =?us-ascii?Q?5HKP8q1wvTgDHfF6xk1RVa4MQFKujfmjwSX37T9Gtzws8wN69CKe0Y2V6vrK?=
 =?us-ascii?Q?7i35ef8U6uLgKSIqplH37q09rGukeQc8URkB4cEC11q7OvZczG7sGZX17/vO?=
 =?us-ascii?Q?9hyy20cPI7H0agLZgrR0BTXtzpkP1p1kFRWgZF5zIeTnI9f3hQkh7vbSJcLC?=
 =?us-ascii?Q?QNRtN2/IelFnCNN/4GCJVbL0MTc9hqCDxHzFJ6PYEprEHVemB0HyR/vimPFv?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff7ed02-d576-421b-6a42-08da558bc29d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:46:38.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZBNH1uB651/lnk6v53CKMCOW3fRiqCjtyOHcxPwP9DbZZsDIAXZygIBs0L2tg0xFz2pUY+thgTN0GNjaX6Xm7dugMEOKfMPstJ19wLOXCo=
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

From: Ben Widawsky <bwidawsk@kernel.org>

In preparation for region provisioning all device decoders need to be
enumerated since DPA allocations are calculated by summing the
capacities of all decoders in a set. I.e. the programming for decoder[N]
depends on the state of decoder[N-1], so skipping over decoders that
fail to initialize prevents accurate DPA accounting.

Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
[djbw: reword changelog]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 2223d151b61b..c940a4911fee 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -199,7 +199,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
-	int i, committed, failed;
+	int i, committed;
 	u32 ctrl;
 
 	/*
@@ -219,7 +219,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 	if (committed != cxlhdm->decoder_count)
 		msleep(20);
 
-	for (i = 0, failed = 0; i < cxlhdm->decoder_count; i++) {
+	for (i = 0; i < cxlhdm->decoder_count; i++) {
 		int target_map[CXL_DECODER_MAX_INTERLEAVE] = { 0 };
 		int rc, target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
@@ -250,8 +250,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 		rc = init_hdm_decoder(port, cxld, target_map, hdm, i);
 		if (rc) {
 			put_device(&cxld->dev);
-			failed++;
-			continue;
+			return rc;
 		}
 		rc = add_hdm_decoder(port, cxld, target_map);
 		if (rc) {
@@ -261,11 +260,6 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 		}
 	}
 
-	if (failed == cxlhdm->decoder_count) {
-		dev_err(&port->dev, "No valid decoders found\n");
-		return -ENXIO;
-	}
-
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_decoders, CXL);

