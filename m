Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E51558F8C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 06:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiFXEUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 00:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiFXEUM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 00:20:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F83649CBE;
        Thu, 23 Jun 2022 21:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656044411; x=1687580411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kf9CFFgXOGWToq/1lPLAO9HeAEErdsvWCZKaBOcE9Vo=;
  b=m0J3fmfL0MEjY3i+cxbjvlW59rVYOA8B/BdKI4HaRYjVRbAEqtRfAchS
   RRyWTY7oC3Vqf29jdY1BZpJv84KhVgmy6pkmUHBqTwGTEUp/MnzW8VzSC
   7xb5L6KmD8/NRLxNYYPuPn6RVtP/1xSamH5uqjxqPQ3F6rH7vcEi3Z3qb
   LgQLIMZuf93unOhKLKfnjDf7s8i2CkvWw56mvG1/6ZcuiPtOEDPIUB/OJ
   APmJAGL+/5SQcmBTE1SDBJDRSXFc/UnkCt/j9fMETfkS8L++RvkhlrN4w
   SQFJi3ofVgPiq3NFa2glSW5v2jI79ZlenvOdTmpRj9/CPmbbPqU3ZsFZ6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367238003"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="367238003"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="645092916"
Received: from daharell-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.intel.com) ([10.209.66.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:10 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, linux-pci@vger.kernel.org,
        patches@lists.linux.dev, hch@lst.de,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 31/46] cxl/hdm: Initialize decoder type for memory expander devices
Date:   Thu, 23 Jun 2022 21:19:35 -0700
Message-Id: <20220624041950.559155-6-dan.j.williams@intel.com>
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

Unless and until accelerator (type-2) drivers start registering for
CXL.mem mapping services from the CXL subsystem core, initialize idle
HDM decoders to the "expander" type. I.e. the only CXL devices using the
CXL core presently are those implementing the CXL 2.0 Type-3 memory
expander device class code that the cxl_pci driver claims.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 672bf3e97811..7b58f6911523 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -474,6 +474,17 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		cxld->flags |= CXL_DECODER_F_ENABLE;
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
+			cxld->target_type = CXL_DECODER_EXPANDER;
+		else
+			cxld->target_type = CXL_DECODER_ACCELERATOR;
+	} else {
+		/* unless / until type-2 drivers arrive, assume type-3 */
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0) {
+			ctrl |= CXL_HDM_DECODER0_CTRL_TYPE;
+			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
+		}
+		cxld->target_type = CXL_DECODER_EXPANDER;
 	}
 	rc = cxl_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
 			 &cxld->interleave_ways);
@@ -488,11 +499,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (rc)
 		return rc;
 
-	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
-		cxld->target_type = CXL_DECODER_EXPANDER;
-	else
-		cxld->target_type = CXL_DECODER_ACCELERATOR;
-
 	if (!cxled) {
 		target_list.value =
 			ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
-- 
2.36.1

