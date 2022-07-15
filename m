Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78FA5759CC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 05:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241353AbiGODF3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 23:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241315AbiGODE6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 23:04:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995557696C;
        Thu, 14 Jul 2022 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657854296; x=1689390296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U3saHsgvYciwhLfxacVmiu3qWDreQ9A9gfZULUZztoM=;
  b=mtUTpuyWbAaOl88KAeVBPPJJOEAuy5YZFdU/+8WEEG1M/HsOxtCrdsuW
   IFFSqZTK5MRxNhBcTfOfOpQPh7Ii7LgTiS4nKv74a6f0gG52v7dykWKOD
   17NpB+0fd8f7t/69V82c+DPRfjKYTIYFZMOhmMK/iS249+lJK/9mNZ4dB
   cpf/98ZSXNqe8FayuKMjQK8SQy1gwgTrhYFQNShPH3PXYK8Z1yOO8/9IB
   nmHtyPwAIIbAPf2D+ewruE7JVpsdSigG6hsY3AH0bkG4xP6egv0KvViEO
   0fIVBQMLF93ElDcwFZfvTPky5a/SBt3wagGYkbx2fFVPbhT9EKNbyBsNJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="372003645"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="372003645"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 20:04:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="623678661"
Received: from mbordone-mobl.amr.corp.intel.com (HELO localhost) ([10.255.5.217])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 20:04:51 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V14 5/7] driver-core: Introduce BIN_ATTR_ADMIN_{RO,RW}
Date:   Thu, 14 Jul 2022 20:04:22 -0700
Message-Id: <20220715030424.462963-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220715030424.462963-1-ira.weiny@intel.com>
References: <20220715030424.462963-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ira Weiny <ira.weiny@intel.com>

Many binary attributes need to limit access to CAP_SYS_ADMIN only; ie
many binary attributes specify is_visible with 0400 or 0600.

Make setting the permissions of such attributes more explicit by
defining BIN_ATTR_ADMIN_{RO,RW}.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Krzysztof Wilczyński <kw@linux.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V12:
	Pick up review tag
	Bjorn:
		NOTE: this has a lot of similarities to
		https://lore.kernel.org/all/20210416205856.3234481-7-kw@linux.com/
		I'm not sure why that patch was not picked up.  But I've
		added Krzysztof as a suggested by if that is ok?

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

