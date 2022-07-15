Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8BE575871
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241077AbiGOAEp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241076AbiGOAEo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:04:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DD670999;
        Thu, 14 Jul 2022 17:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843483; x=1689379483;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h94bX3pkhvKPJBqJBcBqsOYdL1YyxVd+P+WmQ5R1eyk=;
  b=h41O57aMEJpNFSdD7fYy3HssAI1osMw38fcLTrL9xDsfDwUOX/qQvBC+
   9eesGyYf8rWyxYj3IBHi9dfnxSuIQhPAGoOkXCxXry6YLurOK1BQZRdpF
   MCPgeX1/qrJfpLN1U7xlpcVrS6QWq9sS9UmBe9xTkXCcB0oAjNz9hNy1F
   5gKRRqyrwaG65XbbmmGhlH6KCFNAoXp+eWLSFNFI50c/oWrTHIW725yyE
   DuhKlGWWOpePv0B6MtEKfg4gsy4NQB+eF22A1duhPdSt2G4adNalioHGF
   OLy1/DnDC2z28cZWoL6wA4+uyTHzh2FF50mmpYIoTIg/EO3SfCrLNXKp6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="371978129"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="371978129"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="772801733"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:47 -0700
Subject: [PATCH v2 22/28] cxl/acpi: Add a host-bridge index lookup mechanism
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, hch@lst.de,
        nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:02:47 -0700
Message-ID: <165784336732.1758207.3045854545395563239.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20220624041950.559155-14-dan.j.williams@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |   16 ++++++++++++++++
 drivers/cxl/cxl.h       |    2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index bd0673821d28..2f0b47db53da 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1421,6 +1421,20 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
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
@@ -1510,6 +1524,8 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 		return ERR_PTR(rc);
 	}
 
+	cxlrd->calc_hb = cxl_hb_modulo;
+
 	cxld = &cxlsd->cxld;
 	cxld->dev.type = &cxl_decoder_root_type;
 	/*
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 95d74cf425a4..cd81e642e900 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -322,11 +322,13 @@ struct cxl_switch_decoder {
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
 

