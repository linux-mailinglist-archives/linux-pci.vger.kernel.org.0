Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AA355D5BB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbiF1EQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 00:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243148AbiF1EQE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 00:16:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9D6286DE;
        Mon, 27 Jun 2022 21:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656389762; x=1687925762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7qO0DPZkQc4ZZj4HTErXJO8r5ny+RaI2QaM+HQgYmVc=;
  b=jzO33vO+sqEMg0Vxn/Gf+uRho4gVz6B7EEOvwwOrydAeRW9A7GNaf7qw
   earKfjJeECR1DOSyVffRCBRv9+3ICu+/YKuXdH5M5JpGJgvtah6Y2cmf3
   dw4nYtTzw0s0Apz/ccpN+UY5+vFHs70EEePmsd2ToCwrk7eYiiFPOIH0e
   qxcOGfxrkp2TkMFx9iRhQwbTGUBDQ9Pl6origTzYT8d2NmVpwvCIOfOqb
   QeVWdLxJR+7DoBJhUpU5bZzz4QIZ9tNJCGgBSk4pUtCFT9DtKi1IbSaBU
   6OVXgcUP9FFAzf6M+JcdMDMAwkSXw3u6ooNMdRkOW1GbtVgTGFxcjWVk4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="262038778"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="262038778"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:16:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="692920285"
Received: from nakedgex-mobl.amr.corp.intel.com (HELO localhost) ([10.255.3.161])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:15:57 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V12 5/9] driver-core: Introduce BIN_ATTR_ADMIN_{RO,RW}
Date:   Mon, 27 Jun 2022 21:15:23 -0700
Message-Id: <20220628041527.742333-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220628041527.742333-1-ira.weiny@intel.com>
References: <20220628041527.742333-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Many binary attributes need to limit access to CAP_SYS_ADMIN only; ie
many binary attributes specify is_visible with 0400 or 0600.

Make setting the permissions of such attributes more explicit by
defining BIN_ATTR_ADMIN_{RO,RW}.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V11:
	New Patch
---
 include/linux/sysfs.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index e3f1e8ac1f85..fd3fe5c8c17f 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -235,6 +235,22 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR_WO(_name, _size)
 #define BIN_ATTR_RW(_name, _size)					\
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
 
+
+#define __BIN_ATTR_ADMIN_RO(_name, _size) {					\
+	.attr	= { .name = __stringify(_name), .mode = 0400 },		\
+	.read	= _name##_read,						\
+	.size	= _size,						\
+}
+
+#define __BIN_ATTR_ADMIN_RW(_name, _size)					\
+	__BIN_ATTR(_name, 0600, _name##_read, _name##_write, _size)
+
+#define BIN_ATTR_ADMIN_RO(_name, _size)					\
+struct bin_attribute bin_attr_##_name = __BIN_ATTR_ADMIN_RO(_name, _size)
+
+#define BIN_ATTR_ADMIN_RW(_name, _size)					\
+struct bin_attribute bin_attr_##_name = __BIN_ATTR_ADMIN_RW(_name, _size)
+
 struct sysfs_ops {
 	ssize_t	(*show)(struct kobject *, struct attribute *, char *);
 	ssize_t	(*store)(struct kobject *, struct attribute *, const char *, size_t);
-- 
2.35.3

