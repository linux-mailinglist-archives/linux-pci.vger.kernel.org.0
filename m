Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02A1558FA1
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 06:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiFXEUa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 00:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiFXEUS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 00:20:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB19255367;
        Thu, 23 Jun 2022 21:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656044416; x=1687580416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LEnpiryl3EJtlzLZIRW5oeLAcKcKGsRDBy0eKrTmGME=;
  b=QQ3krwzAt79Lz7+DeVF5at5p/rua/GtMMQG/b2I1X2/0Rf/sxsbivJIV
   npICnr3xaYqNX8G+8tcJjmVnnwwfLZv3F+gar6YnKZQYsYWu9kGKK2TWQ
   pGUaGoWAGmUx/9YIUn/ZL0RmTusXnfTL5YaB0LsXL+KCimzjVoeBX8qPg
   +bXgc/uxq4Ui1muA4Ss7owxRRte7YGYWULZ2EbLNzj9/LV8ZVNJA0G0ak
   c5gX671Twc0K6qdgVnbYMAN4CAC32zL9Z4F4FtD6JWQEicdXLpkaAKvx6
   hHUv/CzmuSeNzhlhjrIk8ZH9fgjRLOPWQ5YRzYI651dh43RLpCBcOuIxt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367238058"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="367238058"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:16 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="645092965"
Received: from daharell-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.intel.com) ([10.209.66.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:15 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, linux-pci@vger.kernel.org,
        patches@lists.linux.dev, hch@lst.de,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 44/46] cxl/pmem: Delete unused nvdimm attribute
Date:   Thu, 23 Jun 2022 21:19:48 -0700
Message-Id: <20220624041950.559155-19-dan.j.williams@intel.com>
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

While there is a need to go from a LIBNVDIMM 'struct nvdimm' to a CXL
'struct cxl_nvdimm', there is no use case to go the other direction.
Likely this is a leftover from an early version of the referenced commit
before it implemented devm for releasing the created nvdimm.

Fixes: 21083f51521f ("cxl/pmem: Register 'pmem' / cxl_nvdimm devices")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 734b4479feb2..d6ff6337aa49 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -411,7 +411,6 @@ struct cxl_nvdimm_bridge {
 struct cxl_nvdimm {
 	struct device dev;
 	struct cxl_memdev *cxlmd;
-	struct nvdimm *nvdimm;
 };
 
 /**
-- 
2.36.1

