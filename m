Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0686558F99
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 06:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiFXEUS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 00:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiFXEUO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 00:20:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE0A51598;
        Thu, 23 Jun 2022 21:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656044414; x=1687580414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CdACGDCijg9t0Ev44Lk+HSkwOEGVx5BxX7nqS1WZRvY=;
  b=XxC4oB33HZvaCEfomS69yAquxRe13P74l8UFgqILRc0jAGRgpj+ZFQBV
   bnwDSwMtHKPh5xJ0UOQHAyVJnanoBevcRNJEZZYEvXfIFUWprkVRrs5RP
   VrFFOTRgB5ppRb5JJiplKXnZ79KgrkqzvaVxNK+nvItkSL8E3Y3sIvWUx
   8YApmhly27+JjxzC/Q27CKxWZyEN/6cBs1kST+i9ScEIwsKdPNn1IqDOt
   Yx+f3329UIOOZIzGLoFmFiJYziuhZoe01nFpp2ZjnIyWpFInAkXjPowd+
   NIguXB6Lfw+5jZETpqnO8IxXYc0XGCiQ2dmLRsMrbwXD8/8tLlrKOL+qQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367238041"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="367238041"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="645092947"
Received: from daharell-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.intel.com) ([10.209.66.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:13 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, linux-pci@vger.kernel.org,
        patches@lists.linux.dev, hch@lst.de,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 39/46] cxl/acpi: Add a host-bridge index lookup mechanism
Date:   Thu, 23 Jun 2022 21:19:43 -0700
Message-Id: <20220624041950.559155-14-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ACPI CXL Fixed Memory Window Structure (CFMWS) defines multiple
methods to determine which host bridge provides access to a given
endpoint relative to that device's position in the interleave. The
"Interleave Arithmetic" defines either a "standard modulo" /
round-random algorithm, or "xormap" based algorithm which can be defined
as a non-linear transform. Given that there are already more options
beyond "standard modulo" and that "xormap" may turn out to be ACPI CXL
specific, provide a callback for the region provisioning code to map
endpoint positions back to expected host bridge id (cxl_dport target).

For now just support the simple modulo math case and save the xormap for
a follow-on change.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c | 15 +++++++++++++++
 drivers/cxl/cxl.h       |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 562a6453249b..7756409d0a58 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1422,6 +1422,20 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 	return rc;
 }
 
+static struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos)
+{
+	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
+	struct cxl_decoder *cxld = &cxlsd->cxld;
+	int iw;
+
+	iw = cxld->interleave_ways;
+	if (dev_WARN_ONCE(&cxld->dev, iw != cxlsd->nr_targets,
+			  "misconfigured root decoder\n"))
+		return NULL;
+
+	return cxlrd->cxlsd.target[pos % iw];
+}
+
 static struct lock_class_key cxl_decoder_key;
 
 /**
@@ -1466,6 +1480,7 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 				if (rc < 0)
 					goto err;
 				atomic_set(&cxlrd->region_id, rc);
+				cxlrd->calc_hb = cxl_hb_modulo;
 			} else
 				cxlsd = NULL;
 		} else {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9340deccad4f..30227348f768 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -315,11 +315,13 @@ struct cxl_switch_decoder {
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
  * @region_id: region id for next region provisioning event
+ * @calc_hb: which host bridge covers the n'th position by granularity
  * @cxlsd: base cxl switch decoder
  */
 struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
+	struct cxl_dport *(*calc_hb)(struct cxl_root_decoder *cxlrd, int pos);
 	struct cxl_switch_decoder cxlsd;
 };
 
-- 
2.36.1

